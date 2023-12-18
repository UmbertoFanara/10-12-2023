page 80100 "UF Seminar Ledger Entries"
{
    AdditionalSearchTerms = 'UF';
    Caption = 'UF Seminar Ledgers Entries', Comment = 'ITA="Movimenti Contabili Corsi"';
    Editable = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "UF Seminar Ledger Entry";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Posting Date"; Rec."Posting Date")
                {
                    Tooltip = 'Specifies the Posting Date for the entry.', Comment = 'ITA="Specifica la data di registrazione della voce contabile associata alla fattura del corso."';
                }
                field("Document No."; Rec."Document No.")
                {
                    Tooltip = 'Specifies the entry''s Document No.', Comment = 'ITA="Specifica il Nr. della Fattura associata alla registrazione contabile della voce."';
                }
                field("Document Date"; Rec."Document Date")
                {
                    Tooltip = 'Specifies the entry''s Document Date.', Comment = 'ITA="Specifica la Data della Fattura associata alla registrazione contabile della voce."';
                    Visible = false;
                }
                field("Entry Type"; Rec."Entry Type")
                {
                    Tooltip = 'Specifies the entry''s Type.', Comment = 'ITA="Specifica il Tipo associtato alla registrazione contabile della voce."';
                }
                field("Seminar No."; Rec."Seminar No.")
                {
                    Tooltip = 'Specifies the entry''s Seminar No.', Comment = 'ITA="Specifica il Nr. identificativo del Corso associato alla registrazione contabile della voce."';
                }
                field(Description; Rec.Description)
                {
                    Tooltip = 'Specifies a Description for the entry.', Comment = 'ITA="Specifica la Descrizione associtata alla registrazione contabile della voce."';
                }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    Tooltip = 'Specifies the entry''s Bill-to Customer No.', Comment = 'ITA="Specifica il Nr. del Cliente a cui Fatturare associato alla registrazione contabile della voce."';
                }
                field("Charge Type"; Rec."Charge Type")
                {
                    Tooltip = 'Specifies the entry''s Charge Type.', Comment = 'ITA="Specifica il Tipo di Spesa associato alla registrazione contabile della voce."';
                }
                field(Type; Rec.Type)
                {
                    Tooltip = 'Specifies the entry''s Type.', Comment = 'ITA="Specifica il Tipo della voce di registrazione contabile."';
                }
                field(Quantity; Rec.Quantity)
                {
                    Tooltip = 'Specifies the Quantity that was posted on the entry.', Comment = 'ITA="Specifica la Quantità associata alla registrazione contabile della voce."';
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    Tooltip = 'Specifiies the Unit Price that was posted on the entry.', Comment = 'ITA="Specifica il Prezzo Unitario associato alla registrazione contabile della voce."';
                }
                field("Total Price"; Rec."Total Price")
                {
                    Tooltip = 'Specifiies the Total Price that was posted on the entry.', Comment = 'ITA="Specifica il Prezzo Totale per la registrazione contabile della voce."';
                }
                field("Remaining Amount"; Rec."Remaining Amount")
                {
                    Tooltip = 'Specifies the Remaining Amount of the entry.', Comment = 'ITA="Specifica l''Ammontare Residuo per la registrazione contabile della voce."';
                }
                field(Chargeable; Rec.Chargeable)
                {
                    Tooltip = 'Specifies if the entry is Chargeable or not.', Comment = 'ITA="Specifica alla voce contabile registrata possono essere associate spese o no."';
                }
                field("Participant Contact No."; Rec."Participant Contact No.")
                {
                    Tooltip = 'Specifies the Participant Contact No. for the entry.', Comment = 'ITA="Specifica il Nr. identificativo per il Contatto dell''alunno associato alla registrazione contabile della voce per il corso."';
                }
                field("Participant Name"; Rec."Participant Name")
                {
                    Tooltip = 'Specifies the Participant Name for the seminar''s entry.', Comment = 'ITA="Specifica il Nome dell''Alunno associato alla registrazione contabile della voce per il corso."';
                }
                field("Instructor Code"; Rec."Instructor Code")
                {
                    Tooltip = 'Specifies the Instructor Code for the seminar''s entry.', Comment = 'ITA="Specifica il Codice identificativo per il Docente associato alla registrazione contabile della voce per il corso."';
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    Tooltip = 'Specifies the Starting Date for the seminar''s entry.', Comment = 'ITA="Specifica la data d''inizio del corso associato alla registrazione contabile."';
                }
                field("Seminar Registration No."; Rec."Seminar Registration No.")
                {
                    Tooltip = 'Specifies No. for the Seminar''s registration entry.', Comment = 'ITA="Specifica il Nr. identificativo di registrazione Corso associato alla registrazione contabile."';
                }
                field("Job No."; Rec."Job No.")
                {
                    Tooltip = 'Specifies the entry''s Job No.', Comment = 'ITA="Specifica il Nr. identificativo della Commessa associata alla registrazione contabile della voce per il corso."';
                }
                /*
                field("Job Ledger Entry No."; Rec.Job Ledger Entry No.)
                {
                    Tooltip = '', Comment = 'ITA=""';
                } */
                field("Entry No."; Rec."Entry No.")
                {
                    Tooltip = 'Specifies the No. for the entry.', Comment = 'ITA="Specifica il Nr. identificativo della voce di registrazione contabile."';
                }

            }
        }
    }
    actions
    {
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
                    ToolTip = 'Find entries and documents that exist for the document number and posting date on the selected document. (Formerly this action was named Navigate.)';

                    trigger OnAction()
                    var
                        Navigate: page Navigate;
                    begin
                        Navigate.SetDoc(Rec."Posting Date", Rec."Document No.");
                        Navigate.Run();
                    end;
                }
            }
        }
        area(Promoted)
        {
            actionref("&Navigate_Promoted"; "&Navigate")
            {
            }
        }
    }

}