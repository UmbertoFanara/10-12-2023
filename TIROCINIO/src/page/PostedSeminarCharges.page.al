page 80106 "UF Posted Seminar Charges"
{
    ApplicationArea = All;
    Caption = 'Posted Seminar Charges', Comment = 'ITA="Spese Contabili Corsi"';
    Editable = false;
    PageType = list;
    SourceTable = "UF Posted Seminar Charge";
    UsageCategory = none;

    layout
    {
        area(content)
        {
            repeater(general)
            {
                field(Type; Rec.Type)
                {
                    Tooltip = 'Specifies the Posted Seminar Charge Type.', Comment = 'ITA="Specifica il tipo di spesa contabile del corso."';
                }
                field("No."; Rec."No.")
                {
                    Tooltip = 'Specifies the Posted Seminar Charge No.', Comment = 'ITA="Specifica il numero identificativo della spesa contabile del corso."';
                }
                field(Description; Rec.Description)
                {
                    Tooltip = 'Specifies the Posted Seminar Charge Description.', Comment = 'ITA="Specifica la descrizione della spesa contabile del corso."';
                }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    Tooltip = 'Specifies the Posted Bill-to Customer No. .', Comment = 'ITA="Specifica il numero identificativo del cliente cui la spesa è stata fatturata."';
                }
                field("To Invoice"; Rec."To Invoice")
                {
                    Tooltip = 'Specifies if the charge is To Invoice or not.', Comment = 'ITA="Specifica se la spesa è da fatturare."';
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    Tooltip = 'Specifies Unit of Measure Code for the Posted Seminar Charge.', Comment = 'ITA="Specifica il codice identificativo per l''unità di misura adatta alla spesa del corso."';
                }
                field(Quantity; Rec.Quantity)
                {
                    Tooltip = 'Specifies the Quantity.', Comment = 'ITA="Specifica la quantità."';
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    Tooltip = 'Specifies the Unit Price.', Comment = 'ITA="Specifica il prezzo unitario."';
                }
                field("Total Price"; Rec."Total Price")
                {
                    Tooltip = 'Calcualtes the Total Charge Price multiplying quantity for unit price.', Comment = 'ITA="Calcola il prezzo totale della spesa moltiplicando la quantità per il prezzo unitario."';
                }
            }
        }
    }
}