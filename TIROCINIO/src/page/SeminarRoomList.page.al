page 80104 "UF Seminar Room List"
{
    AdditionalSearchTerms = 'UF';
    ApplicationArea = All;
    Caption = 'Seminar Rooms', comment = 'ITA="Aule Corsi"';
    CardPageId = "UF Seminar Room Card";
    DataCaptionFields = Code, Name, "Internal/External";
    Editable = false;
    PageType = List;
    SourceTable = "UF Seminar Room";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                Caption = 'General', Comment = 'ITA="Generale"';
                field("Code"; Rec.Code)
                {
                    Tooltip = 'Specifies the Seminar Room Code.', Comment = 'ITA="Specifica il codice identificativo dell''aula."';
                }
                field(Name; Rec.Name)
                {
                    Tooltip = 'Specifies the Seminar Room Name.', Comment = 'ITA="Specifica il nominativo dell''aula."';
                }
                field("Maximum Participants"; Rec."Maximum Participants")
                {
                    Tooltip = 'Specifies the maximum participants number.', Comment = 'ITA="Specifica il numero massimo di alunni per l''aula."';
                }
                field("Resource No."; Rec."Resource No.")
                {
                    Tooltip = 'Specifies the minumum participants number.', Comment = 'ITA="Specifica il numero minimo di alunni l''aula."';
                }
            }
        }
        area(FactBoxes)
        {
            systempart(Links; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = true;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = Notes;
                Visible = true;
            }
        }
    }
    actions
    {
        area(Navigation)
        {
            group("&Apri")
            {
                Caption = 'Apri';
                Image = Open;
                action("View Co&mments")
                {
                    ApplicationArea = All;
                    Image = "View";
                    RunObject = page "Comment Sheet";
                    RunPageLink = "Table Name" = const("Seminar Room"),
                                     "No." = field(Code);
                    RunPageView = sorting("Table Name", "No.");
                    Caption = 'Comment', Comment = 'ITA="Commento"';
                    Tooltip = 'Insert Comment.', Comment = 'ITA="Inserisci un commento."';
                }
                action("Extended T&ext")
                {
                    ApplicationArea = All;
                    Image = "Comment";
                    RunObject = page "Extended Text";
                    RunPageLink = "Table Name" = const("Seminar Room"),
                                     "No." = field(Code);
                    RunPageView = sorting("Table Name", "No.");
                    Caption = 'Extended Text', Comment = 'ITA="Testo Esteso"';
                    Tooltip = 'Insert Text.', Comment = 'ITA="Inserisci un testo."';
                }
                action("Open H&omePage")
                {
                    ApplicationArea = All;
                    Image = "Home";
                    Caption = 'Open Home Page';
                    Tooltip = 'On click opens URL.', Comment = 'ITA="Apri la home page nel browser."';

                    trigger OnAction()
                    begin
                        if rec."Home Page" <> '' then
                            Hyperlink(rec."Home Page");
                    end;
                }
            }
        }
        area(Promoted)
        {
            actionref("View Comments_Promoted"; "View Co&mments")
            {
            }
            actionref("Extended Text_Promoted"; "Extended T&ext")
            {
            }
            actionref("Open HomePage_Promoted"; "Open H&omePage")
            {
            }
        }
    }
}
