codeunit 80105 "UF NavigateFindRecordSub"
{
    var
        [SecurityFiltering(SecurityFilter::Filtered)]
        SeminarRegHeader: Record "UF Seminar Registration Header";
        [SecurityFiltering(SecurityFilter::Filtered)]
        PstdSeminarRegHeader: Record "UF Posted Seminar Reg Header";
        [SecurityFiltering(SecurityFilter::Filtered)]
        SeminarLedgEntry: Record "UF Seminar Ledger Entry";

    [EventSubscriber(ObjectType::page, page::Navigate, 'OnAfterNavigateFindRecords', '', false, false)]
    local procedure Navigate_OnAfterNavigateFindRecords(Sender: Page Navigate; var DocumentEntry: Record "Document Entry"; DocNoFilter: Text; PostingDateFilter: Text)

    begin
        if SeminarRegHeader.ReadPermission then begin
            SeminarRegHeader.Reset();
            SeminarRegHeader.SetFilter("No.", DocNoFilter);
            SeminarRegHeader.SetFilter("Posting Date", PostingDateFilter);
            Sender.InsertIntoDocEntry(DocumentEntry, DATABASE::"UF Seminar Registration Header", 0, SeminarRegHeader.TableCaption(), SeminarRegHeader.Count);
        end;
        if PstdSeminarRegHeader.ReadPermission then begin
            PstdSeminarRegHeader.Reset();
            PstdSeminarRegHeader.SetFilter("No.", DocNoFilter);
            PstdSeminarRegHeader.SetFilter("Posting Date", PostingDateFilter);
            Sender.InsertIntoDocEntry(DocumentEntry, DATABASE::"UF Posted Seminar Reg Header", 0, PstdSeminarRegHeader.TableCaption(), PstdSeminarRegHeader.Count);
        end;
        if SeminarLedgEntry.ReadPermission then begin
            SeminarLedgEntry.Reset();
            SeminarLedgEntry.SetCurrentKey("Document No.", "Posting Date");
            SeminarLedgEntry.SetFilter("Document No.", DocNoFilter);
            SeminarLedgEntry.SetFilter("Posting Date", PostingDateFilter);
            Sender.InsertIntoDocEntry(DocumentEntry, DATABASE::"UF Seminar Ledger Entry", 0, SeminarLedgEntry.TableCaption(), SeminarLedgEntry.Count);
        end;
    end;

    [EventSubscriber(ObjectType::page, page::Navigate, 'OnAfterNavigateShowRecords', '', false, false)]
    local procedure Navigate_OnAfterNavigateShowRecords(TableID: Integer; DocNoFilter: Text; PostingDateFilter: Text)

    begin
        case TableID of
            DATABASE::"UF Seminar Registration Header":
                begin
                    SeminarRegHeader.SetFilter("No.", DocNoFilter);
                    SeminarRegHeader.SetFilter("Posting Date", PostingDateFilter);
                    Page.Run(0, SeminarRegHeader);
                end;
            DATABASE::"UF Posted Seminar Reg Header":
                begin
                    PstdSeminarRegHeader.SetFilter("No.", DocNoFilter);
                    PstdSeminarRegHeader.SetFilter("Posting Date", PostingDateFilter);
                    Page.Run(0, PstdSeminarRegHeader);
                end;
            DATABASE::"UF Seminar Ledger Entry":
                begin
                    SeminarLedgEntry.SetFilter("Document No.", DocNoFilter);
                    SeminarLedgEntry.SetFilter("Posting Date", PostingDateFilter);
                    Page.Run(0, SeminarLedgEntry);
                end
        end;
    end;
}
