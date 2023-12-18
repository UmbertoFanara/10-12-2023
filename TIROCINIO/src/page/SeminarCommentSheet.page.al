page 80102 "UF Seminar Comment Sheet"
{
    ApplicationArea = All;
    AutoSplitKey = true;
    Caption = 'Seminar Comments', Comment = 'ITA="Commenti Corso"';
    DataCaptionFields = "No.";
    MultipleNewLines = true;
    DelayedInsert = true;
    PageType = list;
    SourceTable = "UF Seminar Comment Line";
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Tooltip = 'Specifies the Seminar Comment No. .', Comment = 'ITA="Specifica il numero identificativo del commento alla fattura del corso."';
                }
                field("Date"; rec.Date)
                {
                    ApplicationArea = All;
                    Tooltip = 'Specifies the Seminar Comment Date.', Comment = 'ITA="Inserisci la data di immissione del commento alla fattura del corso."';
                }
                field("Code"; rec.Code)
                {
                    ApplicationArea = All;
                    Tooltip = 'Not Visible.', Comment = 'ITA="Campo non mostrato."';
                    Visible = false;
                }
                field(Comment; rec.Comment)
                {
                    ApplicationArea = All;
                    Tooltip = 'Write a Seminar Comment.', Comment = 'ITA="Commenta la fattura del corso."';
                }
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    var
        SeminarCommentLine: Record "UF Seminar Comment Line";
    begin
        SeminarCommentLine.SetUpNewLine();
    end;
}