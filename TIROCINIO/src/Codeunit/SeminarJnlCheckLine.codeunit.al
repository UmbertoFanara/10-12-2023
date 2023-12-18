codeunit 80111 "UF SeminarJnlCheckLine"
{   // Pag. 32 Punto 3
    TableNo = "UF Seminar Journal Line";
    // Pag. 32 Punto 5
    trigger OnRun()
    begin
        RunCheck(Rec);
    end;
    // Pag. 32 Punto 4
    procedure RunCheck(var SeminarJnlLine: record "UF Seminar Journal Line")
    var
        GLSetup: record "General Ledger Setup";
        UserSetup: record "User Setup";
        ZeroOrBlankErr: label '%1 cannot be zero or blank', Comment = '%1 field ITA="Il valore del campo %1 non può essere vuoto o nullo."';
        BlankPstDataErr: Label 'Posting Date cannot be blank', Comment = 'ITA="Il valore della Data di Registrazione non può essere vuoto."';
        ClosingDateErr: label '%1 cannot be a closing date', Comment = '%1 field ITA="Il valore del campo %1 non può essere una data di chiusura."';
        NotBetweenDateErr: label '%1 is not between the %2 and %3 dates', Comment = '%1 field, %2 from date field, %3 to date field ITA="il giorno della %1 non è compreso fra i valori di %2 e %3"';
    // Pag. 32 Punto 6-1
    begin
        if SeminarJnlLine.EmptyLine() then
            exit;
        // Pag. 32 Punto 6-2
        SeminarJnlLine.TestField("Posting Date", ErrorInfo.Create(BlankPstDataErr, false, SeminarJnlLine, 4));
        SeminarJnlLine.TestField("Job No.", ErrorInfo.Create(StrSubstNo(ZeroOrBlankErr, SeminarJnlLine.FieldCaption("Job No.")), false, SeminarJnlLine, 22));
        SeminarJnlLine.TestField("Seminar No.", ErrorInfo.Create(StrSubstNo(ZeroOrBlankErr, SeminarJnlLine.FieldCaption("Seminar No.")), false, SeminarJnlLine, 3));

        // Pag. 32 Punto 6-3
        if SeminarJnlLine."Charge Type" = SeminarJnlLine."Charge Type"::Instructor then
            SeminarJnlLine.TestField("Instructor Code", ErrorInfo.Create(StrSubstNo(ZeroOrBlankErr, SeminarJnlLine.FieldCaption("Instructor Code")), false, SeminarJnlLine, 19));
        if SeminarJnlLine."Charge Type" = SeminarJnlLine."Charge Type"::Room then
            SeminarJnlLine.TestField("Seminar Room Code", ErrorInfo.Create(StrSubstNo(ZeroOrBlankErr, SeminarJnlLine.FieldCaption("Seminar Room Code")), false, SeminarJnlLine, 18));
        if SeminarJnlLine."Charge Type" = SeminarJnlLine."Charge Type"::Participant then
            SeminarJnlLine.TestField("Participant Contact No.", ErrorInfo.Create(StrSubstNo(ZeroOrBlankErr, SeminarJnlLine.FieldCaption("Participant Contact No.")), false, SeminarJnlLine, 15));
        // Pag. 32 Punto 6-4
        if SeminarJnlLine.Chargeable = true then
            SeminarJnlLine.TestField("Bill-to Customer No.", ErrorInfo.Create(StrSubstNo(ZeroOrBlankErr, SeminarJnlLine.FieldCaption("Bill-to Customer No.")), false, SeminarJnlLine, 9));

        // Pag. 32 Punto 6-5
        if SeminarJnlLine."Posting Date" <> 0D then
            if SeminarJnlLine."Posting Date" <> NormalDate(SeminarJnlLine."Posting Date") then
                SeminarJnlLine.FieldError(SeminarJnlLine."Posting Date", ErrorInfo.Create(StrSubstNo(ClosingDateErr, SeminarJnlLine.FieldCaption("Posting Date")), false, SeminarJnlLine, 4));
        UserSetup.Get('TOP\U.FANARA');
        // Pag. 32 Punto 6-6
        if (SeminarJnlLine."Posting Date" < UserSetup."Allow Posting From") or (SeminarJnlLine."Posting Date" > UserSetup."Allow Posting To") then
            SeminarJnlLine.FieldError(SeminarJnlLine."Posting Date", ErrorInfo.Create(StrSubstNo(NotBetweenDateErr, SeminarJnlLine.FieldCaption("Posting Date"), UserSetup.FieldCaption("Allow Posting From"), UserSetup.FieldCaption("Allow Posting To")), false, SeminarJnlLine, 4));
        // Pag. 32 Punto 6-6-1

        if (UserSetup."Allow Posting From" = 0D) and (UserSetup."Allow Posting To" = 0D) then
            if (SeminarJnlLine."Posting Date" < GLSetup."Allow Posting From") or (SeminarJnlLine."Posting Date" > GLSetup."Allow Posting To") then
                // Pag. 32 Punto 6-6-2
                SeminarJnlLine.FieldError(SeminarJnlLine."Posting Date", ErrorInfo.Create(StrSubstNo(NotBetweenDateErr, SeminarJnlLine.FieldCaption("Posting Date"), GLSetup.FieldCaption("Allow Posting From"), GLSetup.FieldCaption("Allow Posting To")), false, SeminarJnlLine, 4));

        // Pag.33 Punto 6-7
        if SeminarJnlLine."Document Date" <> 0D then
            if SeminarJnlLine."Document Date" <> NormalDate(SeminarJnlLine."Document Date") then
                SeminarJnlLine.FieldError(SeminarJnlLine."Document Date", ErrorInfo.Create(StrSubstNo(ClosingDateErr, SeminarJnlLine.FieldCaption("Document Date")), false, SeminarJnlLine, 5));
    end;
}