codeunit 80104 "UF JobJnlPostLineSub"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Jnl.-Post Line", 'OnBeforeJobLedgEntryInsert', '', true, true)]
    local procedure JobJnlPostLine_OnBeforeJobLedgEntryInsert(var JobLedgerEntry: Record "Job Ledger Entry"; JobJournalLine: Record "Job Journal Line")
    begin
        JobLedgerEntry."Entry No." := JobJournalLine."Line No.";
        JobLedgerEntry."UF Seminar Registration No." := JobJournalLine."UF Seminar Registration No.";
    end;
}