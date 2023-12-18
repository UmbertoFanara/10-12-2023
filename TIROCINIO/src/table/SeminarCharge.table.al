table 80105 "UF Seminar Charge"
{
    Caption = 'Seminar Charge', Comment = 'ITA="Spesa Corso"';
    LookupPageId = "UF Seminar Reg. List";

    fields
    {
        field(1; "Seminar Registration No."; Code[20])
        {
            Caption = 'Seminar Registration No.', Comment = 'ITA="Nr. Registrazione Corso"';
            NotBlank = true;
            TableRelation = "UF Seminar Registration Header";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.', Comment = 'ITA="Nr. Riga"';
        }
        field(3; "Job No."; Code[20])
        {
            Caption = 'Job No.', Comment = 'ITA="Nr. Commessa"';
            TableRelation = Job;

            // pag. 23 punto 3
            trigger OnValidate();
            var
                Job: Record Job;
            begin
                if rec."Job No." <> '' then begin
                    job.get(rec."Job No.");
                    job.TestField(Blocked, job.Blocked::" ");
                    job.TestField(Status, job.status::Open);
                end;
            end;
        }
        field(4; Type; enum "UF Type Seminar Charge")
        {
            Caption = 'Type', Comment = 'ITA="Tipo"';

            // pag. 23 punto 4
            trigger OnValidate()
            begin
                if rec.Type <> xrec.Type then
                    rec.Description := '';
            end;

        }
        field(5; "No."; Code[20])
        {
            Caption = 'No.', Comment = 'ITA="Nr."';
            TableRelation = if (Type = const(Resource)) Resource
            else
            if (Type = const("G/L Account")) "G/L Account";

            // Pag. 23 punto 5
            trigger OnValidate()
            var
                TResource: Record Resource;
                GLAccount: Record "G/L Account";
            begin
                case Type of
                    Type::Resource:
                        begin
                            TResource.Get("No.");
                            TResource.TestField(Blocked, false);
                            TResource.TestField("Gen. Prod. Posting Group");
                            Description := TResource.Name;
                            "Gen. Prod. Posting Group" := TResource."Gen. Prod. Posting Group";
                            "VAT Prod. Posting Group" := TResource."VAT Prod. Posting Group";
                            "Unit Of Measure Code" := TResource."Base Unit of Measure";
                            "Unit Price" := TResource."Unit Price";
                        end;
                    Type::"G/L Account":
                        begin
                            GLAccount.Get("No.");
                            GLAccount.CheckGLAcc();
                            GLAccount.TestField("Direct Posting", true);
                            Description := GLAccount.Name;
                            "Gen. Prod. Posting Group" := GLAccount."Gen. Bus. Posting Group";
                            "VAT Prod. Posting Group" := GLAccount."VAT Bus. Posting Group";
                        end;
                end;
            end;
        }
        field(6; Description; text[100])
        {
            Caption = 'Description', Comment = 'ITA="Descrizione"';
        }
        field(7; Quantity; Decimal)
        {
            Caption = 'Quantity', Comment = 'ITA="Quantità"';
            DecimalPlaces = 0 : 5;
            // pag. 24 punto 6
            trigger OnValidate()
            begin
                if rec.Quantity <> xRec.Quantity then
                    CalculateTotalPrice();
            end;
        }
        field(8; "Unit Price"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Price', Comment = 'ITA="Prezzo Unità"';
            MinValue = 0;

            // pag. 24 punto 6
            trigger OnValidate()
            begin
                if rec."Unit Price" <> xRec."Unit Price" then
                    CalculateTotalPrice();
            end;
        }
        field(9; "Total Price"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Total Price', Comment = 'ITA="Totale Prezzo"';
            Editable = false;
        }
        field(10; "To Invoice"; Boolean)
        {
            Caption = 'To Invoice', Comment = 'ITA="Da Fatturare"';
            InitValue = true;
        }
        field(11; "Bill-to Customer No."; Code[20])
        {
            Caption = 'Bill To Customer No.', Comment = 'ITA="Da Fatturare al Cliente Nr."';
            TableRelation = customer;
        }
        field(12; "Unit Of Measure Code"; Code[10])
        {
            Caption = 'Unit Of Measure Code', Comment = 'ITA="Codice Unità Di Misura"';
            TableRelation = if (Type = const(Resource)) "Resource Unit of Measure".Code where("Resource No." = field("No."))
            else
            "Unit of Measure";

            // pag. 24 punto 7
            trigger OnValidate()
            var
                TResource: record Resource;
                ResourceUofM: record "Resource Unit of Measure";
            begin
                case Type of
                    Type::Resource:
                        begin
                            TResource.Get("No.");
                            if "Unit Of Measure Code" = '' then
                                "Unit Of Measure Code" := TResource."Base Unit of Measure";
                            ResourceUofM.Get("No.", "Unit Of Measure Code");
                            rec."Qty. per Unit of Measure" := ResourceUofM."Qty. per Unit of Measure";
                            rec."Unit Price" := round(tresource."Unit Price" * "Qty. per Unit of Measure", 0.01);
                            CalculateTotalPrice();
                        end;
                    Type::"G/L Account":
                        begin
                            "Qty. per Unit of Measure" := 1;
                            if CurrFieldNo = FieldNo("Unit Of Measure Code") then
                                Validate(Quantity);
                        end;
                end;
            end;
        }
        field(13; "Gen. Prod. Posting Group"; Code[20])
        {
            Caption = 'Gen. Prod. Posting Group', Comment = 'ITA="Cat. Reg. Articolo/Servizio"';
            TableRelation = "Gen. Product Posting Group";
        }
        field(14; "VAT Prod. Posting Group"; Code[20])
        {
            Caption = 'VAT Prod. Posting Group', Comment = 'ITA="Cat. Reg. IVA Articolo/Servizio"';
        }
        field(15; "Qty. per Unit of Measure"; Decimal)
        {
            Caption = 'Qty. per Unit of Measure', Comment = 'ITA="Quant. per Unità di Misura"';
        }
        field(16; Registered; Boolean)
        {
            Caption = 'Registered', Comment = 'ITA="Registrato"';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Seminar Registration No.", "Line No.")
        {
            Clustered = true;
        }
        key(key2; "Job No.")
        {

        }
    }
    // pag. 23 punto 1
    trigger OnInsert()
    var
        SeminarRegistrationHeader: Record "UF Seminar Registration Header";
    begin

        SeminarRegistrationHeader.Get(rec."Seminar Registration No.");
        rec."Job No." := SeminarRegistrationHeader."Job No.";
    end;


    // pag. 23 punto 2
    trigger OnDelete()
    begin
        rec.TestField(Registered, false);
        rec.Delete();
    end;

    // pag. 24 punto 6
    local procedure CalculateTotalPrice()
    begin
        rec."Total Price" := round(rec."Unit Price" * rec.Quantity, 0.01);
    end;
}