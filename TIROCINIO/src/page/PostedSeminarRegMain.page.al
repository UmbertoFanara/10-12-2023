page 80116 "UF Posted Seminar Reg Main"
{
    ApplicationArea = All;
    Caption = 'Posted Seminar Reg Main', Comment = 'ITA="Fattura Contabile Corso';
    PageType = Document;
    Editable = false;
    SourceTable = "UF Posted Seminar Reg Header";
    UsageCategory = none;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'Posted Header', Comment = 'ITA="Testata Contabile"';
                field("No."; Rec."No.")
                {
                    Tooltip = 'Generates the No.', Comment = 'ITA="Genera il codice identificativo della fattura."';
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
            part(PostedSeminarRegistrationLines; "UF Posted Seminar Reg Sub")
            {
                Caption = 'Posted Lines', Comment = 'ITA="Righe Contabili"';
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
            action("Posted C&harges")
            {
                ApplicationArea = All;
                Image = Cost;
                RunObject = page "UF Posted Seminar Charges";
                Caption = 'Posted Charges', Comment = 'ITA="Spese Contabili"';
                Tooltip = 'Opens charges for the seminar.', Comment = 'ITA="Apre le spese per il corso."';
                RunPageLink = "Seminar Registration No." = field("No.");
            }
        }
        area(Processing)
        {
            group("S&how Entries")
            {
                Caption = 'Show Entries', Comment = 'ITA="Trova Voci"';

                action("&Navigate")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Find entries...';
                    Image = Navigate;
                    ShortCutKey = 'Ctrl+Alt+Q';
                    ToolTip = 'Find entries and documents that exist for the document number and posting date on the selected document.', comment = 'ITA="Trova la Fattura contabile corrispondente al Nr. e alla Data del documento"';
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
            actionref("Posted Charges_Promoted"; "Posted C&harges")
            {
            }
            actionref("&Navigate_Promoted"; "&Navigate")
            {
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.SetRange("No.", '');
    end;
}