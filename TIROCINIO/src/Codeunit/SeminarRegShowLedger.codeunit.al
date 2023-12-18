codeunit 80101 "UF SeminarRegShowLedger"
{
    TableNo = "UF Seminar Register";
    trigger OnRun()
    var
        SemLdgEntry: Record "UF Seminar Ledger Entry";
    begin
        SemLdgEntry.SetRange("Entry No.", rec."From Entry No.", rec."To Entry No.");
        Page.Run(Page::"UF Seminar Ledger Entries", SemLdgEntry);
    end;


}