page 80103 "UF Seminar Room Card"
{
    AdditionalSearchTerms = 'UF';
    ApplicationArea = All;
    Caption = 'Seminar Rooms', Comment = 'ITA="Aula Corso"';
    DataCaptionFields = Code, Name;
    PageType = Card;
    SourceTable = "UF Seminar Room";
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General', Comment = 'ITA="Generale"';
                field("Code"; Rec.Code)
                {
                    Tooltip = 'Generates the Code.', Comment = 'ITA="Genera il codice identificativo dell''aula."';
                }
                field(Name; Rec.Name)
                {
                    Tooltip = 'Specifies the Name.', Comment = 'ITA="Specifica il nominativo dell''aula."';
                }
                field(Address; Rec.Address)
                {
                    Tooltip = 'Specifies the address.', Comment = 'ITA="Specifica l''indirizzo dell''aula."';
                }
                field("Address 2"; Rec."Address 2")
                {
                    Tooltip = 'Specifies the address 2.', Comment = 'ITA="Specifica il secondo indirizzo dell''aula."';
                }
                field(City; Rec.City)
                {
                    Tooltip = 'Specifies the City.', Comment = 'ITA="Specifica la città in l''aula si trova."';
                }
                field("Post Code"; Rec."Post Code")
                {
                    Tooltip = 'Specifies the Post Code.', Comment = 'ITA="Specifica il CAP dell''aula."';
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    Tooltip = 'Specifies the Country/Region Code.', Comment = 'ITA="Specifica il codice regionale."';
                }
                field("Internal/External"; Rec."Internal/External")
                {
                    Tooltip = 'Select if the seminar is internal or external.', Comment = 'ITA="Seleziona se l''Aula è In Sede o In Succursale."';
                }
                field("Maximum Participants"; Rec."Maximum Participants")
                {
                    Tooltip = 'Specifies the maximum participants number.', Comment = 'ITA="Specifica il numero massimo di alunni per l''aula."';
                }
                field("Resource No."; Rec."Resource No.")
                {
                    Tooltip = 'Specifies the resource number.', Comment = 'ITA="Specifica il numero identificatvo della risorsa."';
                }

            }
            group(Contacts)
            {
                Caption = 'Contacts', Comment = 'ITA="Contatti"';
                field("Contact No."; Rec."Contact No.")
                {
                    Tooltip = 'Specifies the contact number.', Comment = 'ITA="Specifica il numero identificatvo del contatto dell''aula."';
                }
                field("Phone No."; Rec."Phone No.")
                {
                    Tooltip = 'Specifies the phone number.', Comment = 'ITA="Specifica il numero telefonico dell''aula."';
                    Importance = Promoted;
                }
                field("Fax No."; Rec."Fax No.")
                {
                    Tooltip = 'Specifies the fax number.', Comment = 'ITA="Specifica il numero di fax dell''aula."';
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    Tooltip = 'Specifies the E-Mail.', Comment = 'ITA="Specifica l''e-Mail dell''aula."';
                    Importance = Promoted;
                }
                field("Home Page"; Rec."Home Page")
                {
                    Tooltip = 'Specifies the Home Page.', Comment = 'ITA="Specifica la home page dell''aula."';
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

