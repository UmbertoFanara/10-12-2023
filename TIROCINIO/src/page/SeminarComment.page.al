page 80107 "UF Seminar Comment"
{
    ApplicationArea = All;
    Caption = 'Seminar Comment', Comment = 'ITA="Commenti Corso"';
    DataCaptionFields = "No.";
    Editable = false;
    LinksAllowed = false;
    PageType = List;
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
                    Tooltip = 'Specifies Seminar Comment No.', Comment = 'ITA="Specifica il numero identificativo del commento alla fattura del corso."';
                }
                field("Date"; rec.Date)
                {
                    ApplicationArea = All;
                    Tooltip = 'Specifies Seminar Comment Date.', Comment = 'ITA="Inserire la data di immissione del commento alla fattura del corso."';
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
}