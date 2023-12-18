codeunit 80103 "UF SeminarPostYesNo"
{
    TableNo = "UF Seminar Registration Header";
    trigger OnRun()
    begin
        SeminarRegHeader.Copy(rec);
        Code();
        rec := SeminarRegHeader;
    end;

    var
        SeminarRegHeader: record "UF Seminar Registration Header";
        SeminarPost: codeunit "UF SeminarPost";
        RegPostConfTxt: Label 'Continue to post Seminar Registration No.: %1?', comment = ' %1 DocumentNo. ITA="Procedere alla registrazione della Fattura Corso Nr.: %1 ?"';

    local procedure Code()
    begin
        if not Confirm(RegPostConfTxt, false, SeminarRegHeader."No.") then
            exit;
        SeminarPost.Run(SeminarRegHeader);
        Commit();
    end;
}