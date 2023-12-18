page 80112 "UF Seminar Card"
{
    ApplicationArea = All;
    Caption = 'Seminars', Comment = 'ITA="Corso"';
    DataCaptionFields = "No.", Name;
    PageType = Card;
    SourceTable = "UF Seminar";
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General', Comment = 'ITA="Generale"';
                field("No."; Rec."No.")
                {
                    Tooltip = 'Generates the Seminar Series Number.', Comment = 'ITA="Genera il codice seriale del corso."';
                    // aggiorna la pagina quando l'edit guidato assegna un valore al campo No.
                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit() then
                            CurrPage.Update();
                    end;
                }
                field(Name; Rec.Name)
                {
                    Tooltip = 'Specifies the Name.', Comment = 'ITA="Specifica il nome del corso."';
                }
                field("Search Name"; Rec."Search Name")
                {
                    Tooltip = 'Specifies the Search Name.', Comment = 'ITA="Specifica il nome per la ricerca del corso."';
                }
                field("Seminar Duration"; Rec."Seminar Duration")
                {
                    Tooltip = 'Specifies the Seminar Duration.', Comment = 'ITA="Specifica la durata del corso."';
                }
                field("Minimum Participants"; Rec."Minimum Participants")
                {
                    Tooltip = 'Specifies the minimum participants number.', Comment = 'ITA="Specifica il numero minimo di alunni per il corso."';
                }
                field("Maximum Participants"; Rec."Maximum Participants")
                {
                    Tooltip = 'Specifies the maximum participants number.', Comment = 'ITA="Specifica il numero massimo di alunni per il corso."';
                }
                field(Blocked; Rec.Blocked)
                {
                    Tooltip = 'Specifies if the seminar is Blocked.', Comment = 'ITA="Specifica se il corso è bloccato."';
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    Tooltip = 'Specifies the Last Date Modified.', Comment = 'ITA="Specifica l''ultima data di modifica."';
                }
            }
            group(Invoicing)
            {
                Caption = 'Invoicing', Comment = 'ITA="Fatturazione"';
                field("Seminar Price"; Rec."Seminar Price")
                {
                    Tooltip = 'Specifies the Seminar Price.', Comment = 'ITA="Specifica il prezzo del corso."';
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    Tooltip = 'Specifies the Gen. Prod. Posting Group.', Comment = 'ITA="Specifica la Cat. reg. articolo/servizio."';
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    Tooltip = 'Specifies the VAT Prod. Posting Group.', Comment = 'ITA="Specifica la Reg. IVA articolo/servizio."';
                }
                field("Job No."; Rec."Job No.")
                {
                    Tooltip = 'Specifies the Job No. .', Comment = 'ITA="Specifica il numero identificativo della commessa."';
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
            action("View Co&mments")
            {
                ApplicationArea = All;
                Image = "View";
                RunObject = page "Comment Sheet";
                RunPageLink = "Table Name" = const(Seminar),
                                     "No." = field("No.");
                RunPageView = sorting("Table Name", "No.");
                Caption = 'Comments', Comment = 'ITA="Commenti"';
                ToolTip = 'Insert a Comment.', comment = 'ITA="Inserisci un commento."';
            }
            action("Extended T&ext")
            {
                ApplicationArea = All;
                Image = "Comment";
                RunObject = page "Extended Text";
                RunPageLink = "Table Name" = const(Seminar),
                                     "No." = field("No.");
                RunPageView = sorting("Table Name", "No.");
                Caption = 'Extended Texts', Comment = 'ITA="Testi Estesi"';
                ToolTip = 'Insert an Extended Text.', comment = 'ITA="Inserisci un testo esteso."';
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
    // libera i filtri creati sul campo No. dopo che trova il record specifico per le operazioni
    trigger OnAfterGetRecord()
    begin
        Rec.SetRange("No.", '');
    end;
}
