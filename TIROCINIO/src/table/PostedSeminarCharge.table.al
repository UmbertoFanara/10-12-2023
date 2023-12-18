table 80113 "UF Posted Seminar Charge"
{
    Caption = 'Posted Seminar Charge', Comment = 'ITA="Spesa Contabile Corso"';
    LookupPageId = "UF Posted Seminar Reg List";

    fields
    {
        field(1; "Seminar Registration No."; Code[20])
        {
            Caption = 'Seminar Registration No.', Comment = 'ITA="Nr. Registrazione Corso"';
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.', Comment = 'ITA="Nr. Riga"';
        }
        field(3; "Job No."; Code[20])
        {
            Caption = 'Job. No.', Comment = 'ITA="Nr. Commessa"';
            TableRelation = Job;
        }
        field(4; Type; enum "UF Type Seminar Charge")
        {
            Caption = 'Type', Comment = 'ITA="Tipo"';
        }
        field(5; "No."; Code[20])
        {
            Caption = 'No.', Comment = 'ITA="Nr."';
            TableRelation =
            if (Type = const(Resource)) Resource
            else
            if (Type = const("G/L Account")) "G/L Account";
        }
        field(6; Description; Text[100])
        {
            Caption = 'Description', Comment = 'ITA="Descrizione"';
        }
        field(7; Quantity; Decimal)
        {
            Caption = 'Quantity', Comment = 'ITA="Quantità"';
            DecimalPlaces = 0 : 5;
        }
        field(8; "Unit Price"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Price', Comment = 'ITA="Prezzo Unitario"';
            MinValue = 0;
        }
        field(9; "Total Price"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Total Price', Comment = 'ITA="Prezzo Totale"';
            MinValue = 0;
        }
        field(10; "To Invoice"; Boolean)
        {
            Caption = 'To Invoice', Comment = 'ITA="Da Fatturare"';
            InitValue = true;
        }
        field(11; "Bill-to Customer No."; Code[20])
        {
            Caption = 'Bill-to Customer No.', Comment = 'ITA="Da Fatturare al Cliente Nr."';
            TableRelation = Customer;
        }
        field(12; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code', Comment = 'ITA="Codice Unita di Misura"';
            TableRelation = if (Type = const(Resource)) "Resource Unit of Measure".Code where("Resource No." = field("No."))
            else
            "Unit of Measure";
        }
        field(13; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group', Comment = 'ITA="Cat. Reg. Articolo/Servizio"';
            TableRelation = "Gen. Product Posting Group";
        }
        field(14; "VAT Prod. Posting Group"; Code[10])
        {
            Caption = 'VAT Prod. Posting Group', Comment = 'ITA="Cat. Reg. IVA Articolo/Servizio"';
            TableRelation = "VAT Product Posting Group";
        }
        field(15; "Qty. per Unit of Measure"; Decimal)
        {
            Caption = 'Qty. per Unit of Measure', Comment = 'ITA="Quantità per Unità di Misura"';
        }
        field(16; Registered; Boolean)
        {
            Caption = 'Registered', Comment = 'ITA="Registrato"';
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Seminar Registration No.", "Line No.")
        {
            Clustered = true;
        }
        key(key1; "Job No.")
        {

        }
    }

}