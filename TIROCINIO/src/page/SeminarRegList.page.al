page 80114 "UF Seminar Reg. List"
{
    AdditionalSearchTerms = 'UF';
    ApplicationArea = All;
    Caption = 'UF Seminar Regs', Comment = 'ITA="Fatture Corsi"';
    CardPageId = "UF Seminar Reg. Main";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "UF Seminar Registration Header";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                Caption = 'General', Comment = 'ITA="Generale"';
                field("No."; Rec."No.")
                {
                    Tooltip = 'Specifies the No. .', Comment = 'ITA="Specifica il numero identificativo della fattura."';
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    Tooltip = 'Specifies the Starting Date.', Comment = 'ITA="Specifica la data di inizio."';
                }
                field("Seminar No."; Rec."Seminar No.")
                {
                    Tooltip = 'Specifies the Seminar No.', Comment = 'ITA="Specifica il numero identificativo del corso nella fattura da registrare"';
                }
                field("Seminar Name"; Rec."Seminar Name")
                {
                    Tooltip = 'Specifies the Seminar Name.', Comment = 'ITA="Specifica il nome del corso."';
                }
                field(Status; Rec.Status)
                {
                    Tooltip = 'Select the Status for the invoice.', Comment = 'ITA="Seleziona lo stato della fattura."';
                }
                field("Duration"; Rec.Duration)
                {
                    Tooltip = 'Specifies the seminar Duration.', Comment = 'ITA="Specifica la durata del corso."';
                }
                field("Maximum Participants"; Rec."Maximum Participants")
                {
                    Tooltip = 'Specifies the Maximum Participants.', Comment = 'ITA="Specifica il numero massimo di alunni."';
                }
                field("Seminar Room Code"; Rec."Seminar Room Code")
                {
                    Tooltip = 'Specifies the Seminar Room Code.', Comment = 'ITA="Specifica il codice identificativo dell''aula."';
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
                Caption = 'Open Comments', Comment = 'ITA="Apri Commenti"';
                Tooltip = 'Open Comments Page.', Comment = 'ITA="Apre il foglio dei commenti."';
                RunPageLink = "No." = field("No.");
            }
            action("C&harges")
            {
                ApplicationArea = All;
                Image = ContractPayment;
                RunObject = page "UF Seminar Charge Form";
                Caption = 'Open charges', Comment = 'ITA="Apri Spese"';
                Tooltip = 'Open Charges Page.', Comment = 'ITA="Apre pagina delle spese."';
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
            actionref(Post_Promoted; "P&ost")
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