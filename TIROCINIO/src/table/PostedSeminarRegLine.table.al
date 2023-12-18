table 80112 "UF Posted Seminar Reg Line"
{
    Caption = 'Posted Seminar Registration Line', Comment = 'ITA="Riga Contabile Fattura Corso"';
    LookupPageId = "UF Posted Seminar Reg Sub";

    fields
    {
        field(1; "Seminar Registration No."; Code[20])
        {
            Caption = 'Seminar Registration No.', Comment = 'ITA="Nr. Registrazione Corso"';
            TableRelation = "UF Posted Seminar Reg Header";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.', Comment = 'ITA="Nr. Riga"';
        }
        field(3; "Bill-to Customer No."; Code[20])
        {
            Caption = 'Bill-to Customer No.', Comment = 'ITA="Da Fatturare al Cliente Nr."';
            TableRelation = Customer;
        }
        field(4; "Participant Contact No."; Code[20])
        {
            Caption = 'Participant Contact No.', Comment = 'ITA="Nr. Contatto Alunno"';
            TableRelation = Contact;
        }
        field(5; "Participant Name"; Text[100])
        {
            CalcFormula = lookup(Contact.Name where("No." = field("Participant Contact No.")));
            Caption = 'Participant Name', Comment = 'ITA="Nome Alunno"';
            FieldClass = FlowField;
        }
        field(6; "Register Date"; Date)
        {
            Caption = 'Register Date', Comment = 'ITA="Data Registrazione"';
            Editable = false;
        }
        field(7; "To Invoice"; Boolean)
        {
            Caption = 'To Invoice', Comment = 'ITA="Da Fatturare"';
            InitValue = true;
        }
        field(8; Participated; Boolean)
        {
            Caption = 'Participated', Comment = 'ITA="Frequentato"';
        }
        field(9; "Confirmation Date"; Date)
        {
            Caption = 'Confirmation Date', Comment = 'ITA="Data Conferma"';
            Editable = false;
        }
        field(10; "Seminar Price"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Seminar Price', Comment = 'ITA="Prezzo Corso"';
        }
        field(11; "Line Discount %"; Decimal)
        {
            Caption = 'Line Discount %', Comment = 'ITA="Sconto Riga %"';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;
        }
        field(12; "Line Discount Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Line Discount Amount', Comment = 'ITA="Ammontare Sconto Riga"';
        }
        field(13; Amount; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount', Comment = 'ITA="Ammontare';
        }
        field(14; Registered; Boolean)
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
    }
}