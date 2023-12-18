page 80105 "UF Seminar Register"
{
    ApplicationArea = all;
    Caption = 'Seminar Register', Comment = 'ITA="Registro Fatturazioni Corsi"';
    Editable = false;
    PageType = list;
    SourceTable = "UF Seminar Register";
    UsageCategory = Administration;
    layout
    {
        area(Content)
        {
            repeater(general)
            {
                field("No."; Rec."No.")
                {
                    Tooltip = 'Specifies the No. of the Seminar Register line.', Comment = 'ITA="Specifica il Nr. identificativo della riga di Registro Corsi."';
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    Tooltip = 'Specifies the Creation Date of the Seminar Register line.', Comment = 'ITA="Specifica la Data di Creazione della riga di Registro Corsi."';
                }
                field("User ID"; Rec."User ID")
                {
                    Tooltip = 'Specifies the User ID of the Seminar Register line.', Comment = 'ITA="Specifica l''id Utente associato alla riga di Registro Corsi."';
                }
                field("Source Code"; Rec."Source Code")
                {
                    Tooltip = 'Specifies the Source Code of the Seminar Register line.', Comment = 'ITA="Specifica il Codice Sorgente associato alla riga di Registro Corsi."';
                }
                field("Journal Batch Name"; Rec."Journal Batch Name")
                {
                    Tooltip = 'Specifies the Journal Batch Name of the Seminar Register line.', Comment = 'ITA=" Specifica il Nome Def. Registrazioni associato alla riga di Registro Corsi."';
                }
                field("From Entry No."; Rec."From Entry No.")
                {
                    Tooltip = 'Specifies the initial range of the Seminar Register line.', Comment = 'ITA="Specifica il valore iniziale dell''intevallo per l''operazione di registrazione associata alla riga."';
                }
                field("To Entry No."; Rec."To Entry No.")
                {
                    Tooltip = 'Specifies the last value for the range of the Seminar Register line.', Comment = 'ITA="Specifica il valore finale dell''intervallo per l''operazione di registrazione associata alla riga."';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            group("Related I&nformation")
            {
                Caption = 'Related Information', Comment = 'ITA="Informazioni Correlate"';
                action("R&egister")
                {
                    Caption = 'Register', Comment = 'ITA="Registro Contabile"';
                    Tooltip = 'Opens the Corrisponding Seminar Ledger Record', Comment = 'ITA="Apre la voce contabile corrispondente alla registrazione"';
                    //    Promoted = true;
                    //    PromotedIsBig = true;
                    //    PromotedOnly = true;
                    //    PromotedCategory = Process;
                    Image = ItemLedger;
                    RunObject = codeunit "UF SeminarRegShowLedger";
                }
            }
        }
        area(Promoted)
        {
            actionref("Register_Promoted"; "R&egister")
            {
            }
        }
    }
}