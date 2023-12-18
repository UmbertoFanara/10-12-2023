page 80109 "UF Seminar Reg. Main"
{
    AdditionalSearchTerms = 'UF';
    ApplicationArea = All;
    Caption = 'Seminar Registration Form', Comment = 'ITA="Fattura Corso"';
    PageType = Document;
    SourceTable = "UF Seminar Registration Header";
    UsageCategory = none;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'Header', Comment = 'ITA="Testata"';
                field("No."; Rec."No.")
                {
                    Tooltip = 'Generates the No.', Comment = 'ITA="Genera il codice identificativo della fattura."';
                    //pag. 32 punto 20 che è un'incognita
                    trigger OnAssistEdit()
                    begin
                        if xrec.AssistEdit() then
                            CurrPage.Update();
                    end;
                }
                field("Posting No. Series"; Rec."Posting No. Series")
                {
                    Tooltip = 'Define Posting No. Series.', Comment = 'ITA="Definisce il Nr. Serie per le Fatture Contabili."';
                }
                field("Posting No."; rec."Posting No.")
                {
                    Tooltip = 'Select or automatically generates the Posting No.', Comment = 'ITA="Seleziona o genera automaticamente il Nr. per la Fattura Contabile."';
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    Tooltip = 'Specifies the Starting Date.', Comment = 'ITA="Specifica la data di inizio del corso."';
                }
                field("Seminar No."; Rec."Seminar No.")
                {
                    Tooltip = 'Specifies the Seminar No.', Comment = 'ITA="Specifica il numero identificativo del corso da fatturare."';
                }
                field("Seminar Name"; Rec."Seminar Name")
                {
                    Tooltip = 'Specifies the Seminar Name.', Comment = 'ITA="Specifica il nome del corso cui la fattura si riferisce."';
                }
                field("Instructor Code"; Rec."Instructor Code")
                {
                    Tooltip = 'Specifies the Instructor Code.', Comment = 'ITA="Specifica il codice identificativo del docente."';
                }
                field("Instructor Name"; Rec."Instructor Name")
                {
                    DrillDown = false;
                    Tooltip = 'Specifies the Instructor Name.', Comment = 'ITA="Specifica o genera il nome del docente."';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    Tooltip = 'Specifies or generates the Posting Date.', Comment = 'ITA="Specifica o genera la data registrazione della fattura."';
                }
                field("Document Date"; Rec."Document Date")
                {
                    Tooltip = 'Specifies or generates the Date.', Comment = 'ITA="Specifica o genera la data della fattura."';
                }
                field(Status; Rec.Status)
                {
                    Tooltip = 'Select the Status.', Comment = 'ITA="Seleziona lo stato della fattura."';
                }
                field("Duration"; Rec.Duration)
                {
                    Tooltip = 'Specifies the seminar Duration.', Comment = 'ITA="Specifica la durata del corso."';
                }
                field("Maximum Participants"; Rec."Maximum Participants")
                {
                    Tooltip = 'Specifies the Maximum Participants.', Comment = 'ITA="Specifica il numero massimo di alunni."';
                }
                field("Minimum Participants"; Rec."Minimum Participants")
                {
                    Tooltip = 'Specifies the Minimum Participants.', Comment = 'ITA="Specifica il numero minimo di alunni."';
                }
            }
            part(SeminarRegistrationLines; "UF Seminar Reg. Subpage")
            {
                ApplicationArea = All;
                Caption = 'Lines', Comment = 'ITA="Righe"';
                SubPageLink = "Seminar Registration No." = field("No.");
            }
            group("Seminar Room")
            {
                Caption = 'Seminar Room', Comment = 'ITA="Aula Corso"';
                field("Seminar Room Code"; Rec."Seminar Room Code")
                {
                    Tooltip = 'Specifies the Seminar Room Code.', Comment = 'ITA="Specifica il codice identificativo dell''aula."';
                }
                field("Seminar Room Name"; Rec."Seminar Room Name")
                {
                    Tooltip = 'Specifies the Seminar Room Name.', Comment = 'ITA="Specifica il nome dell''aula."';
                }
                field("Seminar Room Address"; Rec."Seminar Room Address")
                {
                    Tooltip = 'Specifies the Seminar Room Address.', Comment = 'ITA="Specifica l''indirizzo dell''aula."';
                }
                field("Seminar Room Address 2"; Rec."Seminar Room Address 2")
                {
                    Tooltip = 'Specifies the Seminar Room Address 2.', Comment = 'ITA="Specifica il secondo indirizzo dell''aula."';
                }
                field("Seminar Room Post Code"; Rec."Seminar Room Post Code")
                {
                    Tooltip = 'Specifies the Seminar Room Post Code.', Comment = 'ITA="Specifica o seleziona il codice di registrazione dell''aula."';
                }
                field("Seminar Room City"; Rec."Seminar Room City")
                {
                    Tooltip = 'Specifies the Seminar Room City.', Comment = 'ITA="Specifica o seleziona la città dell''aula."';
                }
                field("Seminar Room Phone No."; Rec."Seminar Room Phone No.")
                {
                    Tooltip = 'Specifies the Seminar Room Phone No.', Comment = 'ITA="Specifica il riferimento telefonico dell''aula."';
                }
            }
            group(Invoicing)
            {
                Caption = 'Invoicing', Comment = 'ITA="Fatturazione"';
                field("Seminar Price"; Rec."Seminar Price")
                {
                    Tooltip = 'Specifies the Seminar Price.', Comment = 'ITA="Specifica il prezzo del corso da fatturare."';
                }
                field("Job No."; Rec."Job No.")
                {
                    Tooltip = 'Specifies the Job No.', Comment = 'ITA="Specifica il codice identificativo della commessa."';
                }
            }
        }
    }
    actions
    {
        area(Navigation)
        {
            action("Co&mments")
            {
                ApplicationArea = All;
                Image = ViewComments;
                RunObject = page "UF Seminar Comment Sheet";
                Caption = 'Comments', Comment = 'ITA="Commenti"';
                Tooltip = 'Write an invoice comment.', Comment = 'ITA="Inserisci un commento."';
                RunPageLink = "No." = field("No.");
            }
            action("C&harges")
            {
                ApplicationArea = All;
                Image = Cost;
                RunObject = page "UF Seminar Charge Form";
                Caption = 'Charges', Comment = 'ITA="Spese"';
                Tooltip = 'Insert a charge for the seminar.', Comment = 'ITA="Inserisci una spesa."';
                RunPageLink = "Seminar Registration No." = field("No.");
            }

        }
        area(Processing)
        {
            group(Posting)
            {
                Caption = 'Posting', Comment = 'ITA="Registrazione"';
                Image = Post;

                action("P&ost")
                {
                    Caption = 'Post', Comment = 'ITA="Registra"';
                    Tooltip = 'Post Seminar Document', Comment = 'ITA="Registra la fattura del corso"';
                    Image = Post;
                    RunObject = codeunit "UF SeminarPostYesNo";
                    ShortcutKey = 'F9';
                }

            }
            group("Report")
            {
                action("P&rint")
                {
                    ApplicationArea = All;
                    Image = Print;
                    Caption = 'Print', Comment = 'ITA="Stampa"';
                    Tooltip = 'Print a report for the seminar.', Comment = 'ITA="Stampa un report per il corso."';


                    trigger OnAction()
                    var
                        DocPrint: Codeunit "UF SeminarDocumentPrint";
                    begin
                        DocPrint.PrintSeminarRegistrationHeader(Rec);
                    end;
                }
            }
            group("S&how Entries")
            {
                Caption = 'Show Entries', Comment = 'ITA="Trova Voci"';

                action("&Navigate")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Find entries...';
                    Image = Navigate;
                    ShortCutKey = 'Ctrl+Alt+Q';
                    ToolTip = 'Find entries and documents that exist for the document number and posting date on the selected document.', comment = 'ITA="Trova le Fatture contabili corrispondenti al Nr. e alla Data del documento selezionato"';
                    ;

                    trigger OnAction()
                    var
                        Navigate: page Navigate;
                    begin
                        Navigate.SetDoc(Rec."Posting Date", Rec."No.");
                        Navigate.Run();
                    end;
                }
            }
        }
        area(Promoted)
        {
            actionref(Comments_Promoted; "Co&mments")
            {
            }
            actionref(Charges_Promoted; "C&harges")
            {
            }
            actionref(Posting_Promoted; "P&ost")
            {
            }
            actionref(Print_Promoted; "P&rint")
            {
            }
            actionref("&Navigate_Promoted"; "&Navigate")
            {
            }
        }
    }
}