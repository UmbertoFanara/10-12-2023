page 80117 "UF Posted Seminar Reg List"
{
    ApplicationArea = All;
    Caption = 'Posted Seminar Registration List', Comment = 'ITA="Fatture Contabili Corsi"';
    CardPageId = "UF Posted Seminar Reg Main";
    Editable = false;
    PageType = list;
    SourceTable = "UF Posted Seminar Reg Header";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    Tooltip = 'Specifies the No. .', Comment = 'ITA="Specifica il numero identificativo della fattura."';
                }
                field("Seminar Date"; Rec."Seminar Date")
                {
                    Tooltip = 'Specifies the Starting Date.', Comment = 'ITA="Specifica la data di inizio."';
                }
                field("Seminar No."; Rec."Seminar No.")
                {
                    Tooltip = 'Specifies the Seminar No.', Comment = 'ITA="Specifica il numero identificativo del corso nella fattura."';
                }
                field("Seminar Name"; Rec."Seminar Name")
                {
                    Tooltip = 'Specifies the Seminar Name.', Comment = 'ITA="Specifica il nome del corso."';
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
            actionref("Posted Charges_Promoted"; "Posted C&harges")
            {
            }
            actionref("&Navigate_Promoted"; "&Navigate")
            {
            }
        }
    }

}