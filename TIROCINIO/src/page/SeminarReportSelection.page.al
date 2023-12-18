page 80118 "UF SeminarReportSelection"
{
    PageType = Worksheet;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "UF SeminarReportSelections";

    layout
    {
        area(Content)
        {
            field(ReportUsage; ReportUsage)
            {

                Tooltip = '', Comment = 'ITA=""';
                OptionCaption = 'Registration';

                trigger OnValidate();
                begin
                    SetUsageFilter();
                    CurrPage.Update();
                end;

            }
            repeater(GroupName)
            {
                field(Sequence; Rec.Sequence)
                {
                    Tooltip = '', Comment = 'ITA=""';
                }
                field("Report ID"; Rec."Report ID")
                {
                    Tooltip = '', Comment = 'ITA=""';
                    LookupPageId = "All Objects with Caption";
                }
                field("Report Name"; Rec."Report Name")
                {
                    Tooltip = '', Comment = 'ITA=""';
                    DrillDown = false;
                }
            }
        }
    }

    var
        ReportUsage: Option Registration;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        rec.NewRecord();
    end;

    procedure SetUsageFilter()
    begin
        rec.FilterGroup(2);
        if ReportUsage = ReportUsage::Registration then
            rec.SetRange(rec.usage, rec.Usage::"S.Registration");
        rec.FilterGroup(0);
    end;
}