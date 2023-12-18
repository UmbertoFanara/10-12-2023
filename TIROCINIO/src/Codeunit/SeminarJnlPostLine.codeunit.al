codeunit 80112 "UF SeminarJnlPostLine"
{
    TableNo = "UF Seminar Journal Line";

    // pag. 33 punto 11
    trigger OnRun()
    begin
        RunWithCheck(Rec);
    end;

    // pag. 33 punto 7
    var
        SeminarJnlLine: record "UF Seminar Journal Line";
        SeminarLedgerEntry: record "UF Seminar Ledger Entry";
        SeminarRegister: record "UF Seminar Register";
        SeminarJnlCheckLine: codeunit "UF SeminarJnlCheckLine";
        NextEntryNo: integer;

    // // pag. 33 punti 12,  
    procedure GetSeminarRegister(var NewSeminarRegister: record "UF Seminar Register")

    begin
        NewSeminarRegister := SeminarRegister;
    end;

    // pag. 33 punti 13, 
    procedure RunWithCheck(var SeminarJnlLine2: record "UF Seminar Journal Line")

    begin
        SeminarJnlLine.Copy(SeminarJnlLine2);
        Code();
        SeminarJnlLine2 := SeminarJnlLine;
    end;

    // pag. 33-34 punto 14
    local procedure Code()
    begin

        if SeminarJnlLine.EmptyLine() then
            exit;

        SeminarJnlCheckLine.RunCheck(SeminarJnlLine);

        if NextEntryNo = 0 then begin
            SeminarLedgerEntry.LockTable();
            if SeminarLedgerEntry.FindLast() then
                NextEntryNo := SeminarLedgerEntry."Entry No.";
            NextEntryNo := NextEntryNo + 1;
        end;

        if SeminarJnlLine."Document Date" = 0D then
            SeminarJnlLine."Document Date" := SeminarJnlLine."Posting Date";

        if SeminarRegister."No." = 0 then begin
            SeminarRegister.LockTable();
            if (not SeminarRegister.FindLast()) or (SeminarRegister."To Entry No." <> 0) then begin
                SeminarRegister.Init();
                SeminarRegister."No." := SeminarRegister."No." + 1;
                SeminarRegister."From Entry No." := NextEntryNo;
                SeminarRegister."To Entry No." := NextEntryNo;
                SeminarRegister."Creation Date" := Today();
                SeminarRegister."Source Code" := SeminarLedgerEntry."Source Code";
                SeminarRegister."Journal Batch Name" := SeminarJnlLine."Journal Batch Name";
                SeminarRegister."User ID" := CopyStr(UserId, 1, MaxStrLen(SeminarRegister."User ID"));
                SeminarRegister.Insert();
            end;
        end;
        SeminarRegister."To Entry No." := NextEntryNo;
        SeminarRegister.Modify();

        SeminarLedgerEntry.Init();
        SeminarLedgerEntry."Seminar No." := SeminarJnlLine."Seminar No.";
        SeminarLedgerEntry."Posting Date" := SeminarJnlLine."Posting Date";
        SeminarLedgerEntry."Document Date" := SeminarJnlLine."Document Date";
        SeminarLedgerEntry."Entry Type" := SeminarJnlLine."Entry Type";
        SeminarLedgerEntry."Document No." := SeminarJnlLine."Document No.";
        SeminarLedgerEntry.Description := SeminarJnlLine.Description;
        SeminarLedgerEntry."Bill-to Customer No." := SeminarJnlLine."Bill-to Customer No.";
        SeminarLedgerEntry."Charge Type" := SeminarJnlLine."Charge Type";
        SeminarLedgerEntry.Type := SeminarJnlLine.Type;
        SeminarLedgerEntry.Quantity := SeminarJnlLine.Quantity;
        SeminarLedgerEntry."Unit Price" := SeminarJnlLine."Unit Price";
        SeminarLedgerEntry."Total Price" := SeminarJnlLine."Total Price";
        SeminarLedgerEntry."Participant Contact No." := SeminarJnlLine."Participant Contact No.";
        SeminarLedgerEntry."Participant Name" := SeminarJnlLine."Participant Name";
        SeminarLedgerEntry.Chargeable := SeminarJnlLine.Chargeable;
        SeminarLedgerEntry."Seminar Room Code" := SeminarJnlLine."Seminar Room Code";
        SeminarLedgerEntry."Instructor Code" := SeminarJnlLine."Instructor Code";
        SeminarLedgerEntry."Starting Date" := SeminarJnlLine."Starting Date";
        SeminarLedgerEntry."Seminar Registration No." := SeminarJnlLine."Seminar Registration No.";
        SeminarLedgerEntry."Job No." := SeminarJnlLine."Job No.";
        // "Remaining Amount"
        SeminarLedgerEntry."Source Type" := SeminarJnlLine."Source Type";
        SeminarLedgerEntry."Source No." := SeminarJnlLine."Source No.";
        SeminarLedgerEntry."Journal Batch Name" := SeminarJnlLine."Journal Batch Name";
        SeminarLedgerEntry."Source Code" := SeminarJnlLine."Source Code";
        SeminarLedgerEntry."Reason Code" := SeminarJnlLine."Reason Code";
        SeminarLedgerEntry."No. Series" := SeminarJnlLine."Posting No. Series";
        SeminarLedgerEntry."User ID" := CopyStr(UserId, 1, MaxStrLen(SeminarRegister."User ID"));
        SeminarLedgerEntry."Entry No." := NextEntryNo;
        SeminarLedgerEntry."Job Ledger Entry No." := SeminarJnlLine."Job Ledger Entry No.";
        SeminarLedgerEntry.Insert();
        NextEntryNo := NextEntryNo + 1;
    end;

}