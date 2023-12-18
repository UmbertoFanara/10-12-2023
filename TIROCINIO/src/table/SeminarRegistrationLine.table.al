table 80104 "UF Seminar Registration Line"
{
    Caption = 'Seminar Registration Line', Comment = 'ITA="Riga Fattura Corso"';
    fields
    {
        field(1; "Seminar Registration No."; Code[20])
        {
            Caption = 'Seminar Registration No.', Comment = 'ITA="Nr. Registrazione Corso"';
            TableRelation = "UF Seminar Registration Header";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.', Comment = 'ITA="Nr. Riga"';
        }
        field(3; "Bill-to Customer No."; Code[20])
        {
            Caption = 'Bill-to Customer No.', Comment = 'ITA="Da Fatturare al Cliente Nr."';
            TableRelation = Customer;

            // pag. 33 punto 6
            trigger OnValidate()
            begin
                if (rec."Bill-to Customer No." <> xrec."Bill-to Customer No.") and (rec.Registered = true) then
                    error(Reg001Err, FieldCaption(Registered));
            end;
        }
        field(4; "Participant Contact No."; Code[20])
        {
            Caption = 'Participant Contact No.', Comment = 'ITA="Nr. Contatto Alunno"';
            TableRelation = Contact;

            //pag. 34 punto 7
            trigger OnLookup()
            var
                ContactBusinessRelation: record "Contact Business Relation";
                Contact: record "Contact";
            begin
                ContactBusinessRelation.reset();
                ContactBusinessRelation.SetRange("Link to Table", ContactBusinessRelation."Link to Table"::Customer);
                ContactBusinessRelation.SetRange("No.", "Bill-to Customer No.");
                if ContactBusinessRelation.FindFirst() then
                    Contact.SetRange("Company No.", ContactBusinessRelation."Contact No.");
                if page.RunModal(page::"Contact List", Contact) = action::LookupOK then
                    "Participant Contact No." := Contact."No.";
                CalcFields("Participant Name");
            end;
        }
        field(5; "Participant Name"; text[100])
        {
            Caption = 'Participant Name', Comment = 'ITA="Nome Alunno"';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Contact.Name where("No." = field("Participant Contact No.")));
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
            Caption = 'Confirmation Date', Comment = 'ITA="Data di Conferma"';
            Editable = false;
        }
        field(10; "Seminar Price"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Seminar Price', Comment = 'ITA="Prezzo Corso"';

            //pag. 34 punto 8
            trigger OnValidate()
            begin
                if (rec."Seminar Price" <> 0) or (rec."Seminar Price" <> xrec."Seminar Price") then
                    Validate(rec."Line Discount %");
            end;
        }
        field(11; "Line Discount %"; Decimal)
        {
            Caption = 'Line Discount %', Comment = 'ITA="Riga Percentuale di Sconto"';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
            MaxValue = 100;

            //pag 34 punto 9
            trigger OnValidate()
            var
                GeneralLedgerSetup: record "General Ledger Setup";
            begin
                if rec."Seminar Price" = 0 then
                    rec."Line Discount Amount" := 0
                else
                    GeneralLedgerSetup.Get();
                rec."Line Discount Amount" := Round(rec."Line Discount %" * rec."Seminar Price" * 0.01, GeneralLedgerSetup."Amount Rounding Precision");
                UpdateAmount();
            end;
        }
        field(12; "Line Discount Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Line Discount Amount', Comment = 'ITA="Riga Ammontare Sconto"';

            //pag.34 punto 10
            trigger OnValidate()
            var
                GeneralLedgerSetup: record "General Ledger Setup";
            begin
                if rec."Seminar Price" = 0 then
                    rec."Line Discount %" := 0
                else
                    GeneralLedgerSetup.Get();
                rec."Line Discount %" := Round(rec."Line Discount Amount" / rec."Seminar Price" * 100, GeneralLedgerSetup."Amount Rounding Precision");
                UpdateAmount();
            end;
        }
        field(13; Amount; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount', Comment = 'ITA="Ammontare"';

            //pag.34 punto 11
            trigger OnValidate()
            var
                GeneralLedgerSetup: record "General Ledger Setup";
            begin
                TestField(rec."Bill-to Customer No.");
                TestField(rec."Seminar Price");
                GeneralLedgerSetup.Get();
                rec.Amount := Round(rec.Amount, GeneralLedgerSetup."Amount Rounding Precision");
                rec."Line Discount Amount" := rec."Seminar Price" - rec.Amount;
                if rec."Seminar Price" = 0 then
                    rec."Line Discount %" := 0
                else
                    "Line Discount %" := Round(rec."Line Discount Amount" / rec."Seminar Price" * 100, GeneralLedgerSetup."Amount Rounding Precision");
            end;
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
    var
        Reg001Err: Label 'Cannot delete a %1 record', Comment = '%1 campo ITA=Non puoi cancellare un record già %1"';

    // pag. 32 punto 1
    procedure GetSeminarRegHeader()
    var
        SeminarRegHeader: record "UF Seminar Registration Header";
    begin
        if SeminarRegHeader."No." <> "Seminar Registration No." then
            SeminarRegHeader.get("Seminar Registration No.");
    end;

    // pag. 32 punto 2
    procedure CalcAmount()
    begin
        Amount := round(("Seminar Price" / 100) * (100 - "Line Discount %"));
    end;

    // pag. 32 punto 3
    procedure UpdateAmount()
    var
        GeneralLedgerSetup: record "General Ledger Setup";
    begin
        GeneralLedgerSetup.get();
        Amount := Round("Seminar Price" - "Line Discount Amount", GeneralLedgerSetup."Amount Rounding Precision");
    end;

    // pag. 33 punto 5
    trigger OnInsert()
    var
        SeminarRegHeader: record "UF Seminar Registration Header";
    begin
        SeminarRegHeader.Get("Seminar Registration No.");
        rec."Register Date" := WorkDate();
        rec."Seminar Price" := SeminarRegHeader."Seminar Price";
    end;
    // pag.33 punto 5
    trigger OnDelete()
    begin
        rec.TestField(Registered, false);
    end;
}