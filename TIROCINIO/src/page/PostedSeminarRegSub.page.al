page 80115 "UF Posted Seminar Reg Sub"
{
    ApplicationArea = All;
    AutoSplitKey = true;
    Caption = 'Posted Lines', Comment = 'ITA="Righe Contabili Fattura Corso "';
    Editable = false;
    PageType = ListPart;
    SourceTable = "UF Posted Seminar Reg Line";
    UsageCategory = None;


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    Tooltip = 'Specifies the Bill-to Customer No.', Comment = 'ITA="Specifica il numero identificativo del il cliente a cui fatturare."';
                }
                field("Participant Contact No."; Rec."Participant Contact No.")
                {
                    Tooltip = 'Specifies the Participant Contact No.', Comment = 'ITA="Specifica il numero identificativo per il contatto dell''alunno."';
                }
                field("Participant Name"; Rec."Participant Name")
                {
                    Tooltip = 'Specifies the Participant Name.', Comment = 'ITA="Specifica nome dell''alunno."';
                }
                field(Participated; Rec.Participated)
                {
                    Tooltip = 'Specifies if Seminar is Participated.', Comment = 'ITA="Specifica se il corso è frequentato."';
                }
                field("Register Date"; Rec."Register Date")
                {
                    Tooltip = 'Specifies the Register Date.', Comment = 'ITA="Specifica la data di registrazione della voce."';
                }
                field("Confirmation Date"; Rec."Confirmation Date")
                {
                    Tooltip = 'Specifies the Confirmation Date.', Comment = 'ITA="Specifica la data di conferma."';
                }
                field("To Invoice"; Rec."To Invoice")
                {
                    Tooltip = 'Specifies if is To Invoice.', Comment = 'ITA="Specifica se riga è da fatturare."';
                }
                field(Registered; Rec.Registered)
                {
                    Tooltip = 'Specifies if is registered.', Comment = 'ITA="Specifica se la riga è stata registrata."';
                }
                field("Seminar Price"; Rec."Seminar Price")
                {
                    Tooltip = 'Specifies the Seminar Price.', Comment = 'ITA="Specifica il prezzo del corso."';
                }
                field("Line Discount %"; Rec."Line Discount %")
                {
                    BlankZero = true;
                    Tooltip = 'Specifies the Line Discont %.', Comment = 'ITA="Specifica la percentuale di sconto per la voce."';
                }
                field("Line Discount Amount"; rec."Line Discount Amount")
                {
                    BlankZero = true;
                    Tooltip = 'Specifies the Line Discount Amount.', Comment = 'ITA="Specifica l''ammontare dello sconto per la voce."';
                }
                field(Amount; Rec.Amount)
                {
                    Tooltip = 'Specifies the Amount.', Comment = 'ITA="Specifica l''ammontare."';
                }
            }
        }
    }
}