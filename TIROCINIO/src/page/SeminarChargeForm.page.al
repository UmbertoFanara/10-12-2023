page 80101 "UF Seminar Charge Form"
{
    ApplicationArea = All;
    AutoSplitKey = true;
    Caption = 'Seminar Charge', Comment = 'ITA="Spese Corso"';
    PageType = List;
    UsageCategory = None;
    SourceTable = "UF Seminar Charge";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                Caption = 'General', Comment = 'ITA="Generale"';
                field(Type; Rec.Type)
                {
                    Tooltip = 'Specifies the Seminar Charge Type.', Comment = 'ITA="Specifica il tipo di spesa del corso."';
                }
                field("No."; rec."No.")
                {
                    Tooltip = 'Specifies the Seminar Charge No.', Comment = 'ITA="Specifica il numero identificativo della spesa del corso."';
                }
                field(Description; Rec.Description)
                {
                    Tooltip = 'Specifies the Seminar Charge Description.', Comment = 'ITA="Specifica la descrizione della spesa del corso."';
                }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    Tooltip = 'Specifies the Bill-to Customer No. .', Comment = 'ITA="Specifica il numero identificativo del cliente a cui fatturare la spesa."';
                }
                field("To Invoice"; Rec."To Invoice")
                {
                    Tooltip = 'Specifies if the charge is To Invoice or not.', Comment = 'ITA="Specifica se la spesa è da fatturare."';
                }
                field("Unit Of Measure Code"; Rec."Unit Of Measure Code")
                {
                    Tooltip = 'Specifies Unit of Measure Code for the Seminar Charge.', Comment = 'ITA="Specifica il codice identificativo per l''unità di misura adatta alla spesa del corso."';
                }
                field(Quantity; Rec.Quantity)
                {
                    Tooltip = 'Specifies the Quantity.', Comment = 'ITA="Specifica la quantità."';
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    Tooltip = 'Specifies the Unit Price.', Comment = 'ITA="Specifica il prezzo unitario."';
                }
                field("Total Price"; rec."Total Price")
                {
                    Tooltip = 'Calcualtes the Total Charge Price multiplying quantity for unit price.', Comment = 'ITA="Calcola il prezzo totale della spesa moltiplicando la quantità per il prezzo unitario."';
                }
            }
        }
    }
}