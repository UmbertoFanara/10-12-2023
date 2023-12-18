page 80108 "UF Seminar Reg. Subpage"
{
    AutoSplitKey = true;
    Caption = 'Lines', Comment = 'ITA="Righe"';
    DelayedInsert = true;
    PageType = ListPart;
    SourceTable = "UF Seminar Registration Line";
    UsageCategory = None;
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                ShowCaption = false;
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
                    BlankNumbers = BlankZero;
                    Tooltip = 'Specifies the Line Discont %.', Comment = 'ITA=Specifica la percentuale di sconto per la voce."';
                }
                field("Line Discount Amount"; Rec."Line Discount Amount")
                {
                    BlankNumbers = BlankZero;
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
