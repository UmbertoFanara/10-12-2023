codeunit 80106 "UF SeminarRegistrationPrinted"
{
    TableNo = "UF Seminar Registration Header";
    trigger OnRun()
    begin
        rec.find();
        rec."No. Printed" := rec."No. Printed" + 1;
        rec.Modify();
        Commit();
    end;
}