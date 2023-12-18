page 80113 "UF Seminar List"
{
    AdditionalSearchTerms = 'UF';
    ApplicationArea = All;
    Caption = 'Seminars', comment = 'ITA="Corsi"';
    CardPageId = "UF Seminar Card";
    PageType = List;
    SourceTable = "UF Seminar";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                Caption = 'General', Comment = 'ITA="Generale"';
                field("No."; Rec."No.")
                {
                    Tooltip = 'Specifies the No. .', Comment = 'ITA="Specifica il numero identificativo del corso."';
                }
                field(Name; Rec.Name)
                {
                    Tooltip = 'Specifies the Name.', Comment = 'ITA="Specifica il nome del corso."';
                }
                field("Seminar Duration"; Rec."Seminar Duration")
                {
                    Tooltip = 'Specifies the Seminar Duration.', Comment = 'ITA="Specifica la durata del corso."';
                }
                field("Minimum Participants"; Rec."Minimum Participants")
                {
                    Tooltip = 'Specifies the Minimum Participants number.', Comment = 'ITA="Specifica il numero minimo di alunni."';
                    Visible = false;
                }
                field("Maximum Participants"; Rec."Maximum Participants")
                {
                    Tooltip = 'Specifies the Maximum Participants number.', Comment = 'ITA="Specifica il numero massimo di alunni."';
                    Visible = false;
                }
                field("Seminar Price"; Rec."Seminar Price")
                {
                    Tooltip = 'Specifies the Seminar Price.', Comment = 'ITA="Specifica il prezzo del corso."';
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    Tooltip = 'Specifies the Gen. Prod. Posting Group.', Comment = 'ITA="Specifica la cat. reg. articolo/servizio."';
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    Tooltip = 'Specifies the VAT Prod. Posting Group.', Comment = 'ITA="Specifica la reg. IVA articolo/servizio."';
                }
                field("Job No."; Rec."Job No.")
                {
                    Tooltip = 'Specifies the Job No. .', Comment = 'ITA="Specifica il numero identificativo della commessa per il corso."';
                }
            }
        }
    }
    actions
    {
        area(Navigation)
        {
            action("View Co&mments")
            {
                ApplicationArea = All;
                Image = "Comment";
                RunObject = page "Comment Sheet";
                RunPageLink = "Table Name" = const(Seminar),
                                     "No." = field("No.");
                RunPageView = sorting("Table Name", "No.");
                Tooltip = 'Insert Comment.', Comment = 'ITA="Inserisci un commento."';
            }
            action("Extended T&ext")
            {
                ApplicationArea = All;
                Image = "View";
                RunObject = page "Extended Text";
                RunPageLink = "Table Name" = const(Seminar),
                                     "No." = field("No.");
                RunPageView = sorting("Table Name", "No.");
                Tooltip = 'Insert Text.', Comment = 'ITA="Inserisci un testo."';
            }
            group("Related I&nformation")
            {
                action("L&edger Entries")
                {
                    Caption = 'Ledger Entries', Comment = 'ITA="Voci Contabili"';
                    Tooltip = 'Opens corrisponding ledger entries', Comment = 'ITA="Apre il libro mastro per le voci corrispondenti"';
                    ShortcutKey = 'CTRL + Shift + N';
                    Image = Ledger;
                    RunObject = page "UF Seminar Ledger Entries";
                    RunPageLink = "Seminar No." = field("No.");
                    RunPageView = sorting("Seminar no.", "Posting Date");
                    trigger OnAction()
                    begin
                        CurrPage.Update(true);
                    end;
                }
                action("&Statistics")
                {
                    Caption = 'Statistics', Comment = 'ITA="Statistiche"';
                    Tooltip = 'Ones page Seminar statistics for the selected Seminar.', Comment = 'ITA="Apre la pagina Statistice corso per il corso selezionato."';
                    ShortcutKey = 'Ctrl+Shift+J';
                    Image = "Statistics";
                    RunObject = page "UF SeminarStatistics";
                    RunPageLink = "No." = field("No."),
                                  "Date Filter" = field("Date Filter"),
                                  "Charge Type Filter" = field("Charge Type Filter");
                }
                action("R&egistrations")
                {
                    Caption = 'Register', Comment = 'ITA="Registro"';
                    Tooltip = 'Open corresponding register entries', Comment = 'ITA="apre le voci del registro contabilizzazioni corrispondenti"';
                    Image = Register;
                    RunObject = page "UF Posted Seminar Reg List";
                    RunPageLink = "Seminar No." = field("No.");

                    trigger OnAction()
                    begin
                        CurrPage.Update(true);
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
            actionref("Ledger Entries_Promoted"; "L&edger Entries")
            {
            }
            actionref("Register_Promoted"; "R&egistrations")
            {
            }
            actionref("Statistics_Promoted"; "&Statistics")
            {
            }
        }
    }
}