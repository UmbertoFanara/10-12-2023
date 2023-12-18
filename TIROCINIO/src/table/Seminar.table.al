table 80110 "UF Seminar"
{
    Caption = 'Seminar', comment = 'ITA="Corso"';
    DataCaptionFields = "No.", Name;
    LookupPageId = "UF Seminar List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.', comment = 'ITA="Nr."';
            // Svuota il codice seriale per fare spazio alla procedura OnAssistEdit()
            trigger OnValidate()
            begin
                SeminarSetup.Get();
                if "No." <> xRec."No." then begin
                    NoSeriesManagement.TestManual(SeminarSetup."Seminar Nos.");
                    "No. Series" := '';
                end
            end;
        }
        field(2; Name; Text[50])
        {
            Caption = 'Name', comment = 'ITA="Nome"';
            trigger OnValidate()
            // Se il valore di SearchName è MAIUSC oppure se è vuoto 
            // imposta il valore del campo riempendolo col valore del campo Name
            begin
                if ("Search Name" = UpperCase(xRec.Name)) or ("Search Name" = '') then
                    "Search Name" := Name;
            end;
        }
        field(3; "Seminar Duration"; Decimal)
        {
            Caption = 'Seminar Duration', comment = 'ITA="Durata Corso"';
            DecimalPlaces = 0 : 1;
        }
        field(4; "Minimum Participants"; Integer)
        {
            Caption = 'Minimum Participants', comment = 'ITA="Nr. Minimo Alunni"';
            trigger OnValidate();
            // Compara il numero di partecipanti minmo con quello massimo 
            // e se il primo risulta inferiore al secondo crea un messaggio di errore.
            var
                MinPart, MaxPart : integer;
            begin
                MaxPart := Rec."Maximum Participants";
                MinPart := Rec."Minimum Participants";
                if MinPart > MaxPart then
                    ERROR('Il valore di %1 non puo essere maggiore di %2', FieldCaption("Minimum Participants"), FieldCaption("Maximum Participants"));
            end;

        }
        field(5; "Maximum Participants"; Integer)
        {
            Caption = 'Maximum Participants', comment = 'ITA="Nr. Massimo Alunni"';
        }
        field(6; "Search Name"; Code[50])
        {
            Caption = 'Search Name', comment = 'ITA="Nome Ricerca"';
        }
        field(7; Blocked; Boolean)
        {
            Caption = 'Blocked', comment = 'ITA="Bloccato"';
        }
        field(8; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified', comment = 'ITA="Data Ultima Modifica"';
            Editable = false;
        }
        field(9; Comment; Boolean)
        {
            Caption = 'Comment', comment = 'ITA="Commento"';
            FieldClass = FlowField;
            CalcFormula = exist("Comment Line" where("Table Name" = const(Seminar)));
            Editable = false;
        }
        field(10; "Job No."; Code[20])
        {
            Caption = 'Job No.', comment = 'ITA="Nr. Commessa"';
            TableRelation = Job; // 167
            // Prende i valore del numero lavoro e lo svuota se il lavoro è di tipo Blocked ???
            trigger OnValidate()
            var
                Job: Record Job;
            begin
                Job.Get("Job No.");
                Job.TestField(Blocked, Job.Blocked::" ");
            end;
        }
        field(11; "Seminar Price"; Decimal)
        {
            Caption = 'Seminar Price', comment = 'ITA="Prezzo Corso"';
            AutoFormatType = 1;
        }
        field(12; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group', comment = 'ITA="Cat. Reg. Articolo/Servizio"';
            TableRelation = "Gen. Product Posting Group"; // 251
            // Uniforma i record del campo dalla tabella 251 convalidandoli ???
            trigger OnValidate()
            var
                GenProductPostingGroup: Record "Gen. Product Posting Group";
            begin
                if xRec."Gen. Prod. Posting Group" <> "Gen. Prod. Posting Group" then
                    if GenProductPostingGroup.ValidateVatProdPostingGroup(GenProductPostingGroup, "Gen. Prod. Posting Group") then
                        Validate("VAT Prod. Posting Group", GenProductPostingGroup."Def. VAT Prod. Posting Group");
            end;
        }
        field(13; "VAT Prod. Posting Group"; Code[10])
        {
            Caption = 'VAT Prod. Posting Group', comment = 'ITA="Cat. Reg. IVA Articolo/Servizio"';
            TableRelation = "VAT Product Posting Group"; // 324
        }
        field(14; "No. Series"; Code[20])
        {
            Caption = 'No. Series', comment = 'ITA="Seriale"';
            TableRelation = "No. Series";
            Editable = false;
        }
        field(20; "Date Filter"; Date)
        {
            Caption = 'Date Filter', Comment = 'ITA="Filtro Data"';
            FieldClass = FlowFilter;
        }
        field(21; "Charge Type Filter"; Option)
        {
            Caption = 'Charge Type Filter', Comment = 'ITA="Filtro Tipo Spesa"';
            FieldClass = FlowFilter;
            OptionMembers = "Instructor","Room","Participant","Charge";
            OptionCaption = 'Instructor, Room, Participant, Charge', comment = 'ITA="Docente, Aula, Alunno, Spesa"';
        }
        field(25; "Total Price"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Total Price', Comment = 'ITA="Totale Prezzo"';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("UF Seminar Ledger Entry"."Total Price" where("Seminar No." = field("No."),
                                                                            "Posting Date" = field("Date Filter"),
                                                                            "Charge Type" = field("Charge Type Filter")));
        }
        field(26; "Total Price (Not Chargeable)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Total Price (Not Chargeable)', Comment = 'ITA="Totale Prezzo (Non Esigibile)"';
            FieldClass = FlowField;
            CalcFormula = sum("UF Seminar Ledger Entry"."Total Price" where("Seminar No." = field("No."),
                                                                            "Posting Date" = field("Date Filter"),
                                                                            "Charge Type" = field("Charge Type Filter"),
                                                                            Chargeable = const(false)));
        }
        field(27; "Total Price (Chargeable)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Total Price (Chargeable)', Comment = 'ITA="Totale Prezzo (Esigibile)"';
            FieldClass = FlowField;
            CalcFormula = sum("UF Seminar Ledger Entry"."Total Price" where("Seminar No." = field("No."),
                                                                            "Posting Date" = field("Date Filter"),
                                                                            "Charge Type" = field("Charge Type Filter"),
                                                                            Chargeable = const(true)));
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
        key(key1; "Search Name")
        {

        }
    }
    var
        SeminarSetup: Record "UF Seminar Setup";
        Seminar: Record "UF Seminar";
        NoSeriesManagement: Codeunit NoSeriesManagement;
    // genera il codice seriale per il Corso attraverso i parametri del record in Seminar Setup
    procedure AssistEdit(): Boolean
    begin
        Seminar := Rec;
        SeminarSetup.Get();
        SeminarSetup.TestField("Seminar Nos.");
        if NoSeriesManagement.SelectSeries(SeminarSetup."Seminar Nos.", xrec."No. Series", "No. Series") then begin
            NoSeriesManagement.SetSeries("No.");
            Rec := Seminar;
            exit(true);
        end;
    end;
    // assegna il nuovo codice seriale
    trigger OnInsert()
    begin
        if "No." = '' then begin
            SeminarSetup.Get();
            SeminarSetup.TestField("Seminar Nos.");
            NoSeriesManagement.InitSeries(SeminarSetup."Seminar Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
    end;
    // Cambia il valore del campo LDM alla data di oggi
    trigger OnRename()
    begin
        "Last Date Modified" := Today();
    end;
    // All'eliminazione della voce cancella anche i rispettivi commenti e testi estesi nelle tabelle di riferimento
    trigger OnDelete()
    var
        CommentLine: Record "Comment Line";
        ExtendedTextHeader: Record "Extended Text Header";
    begin
        CommentLine.Reset();
        CommentLine.SetRange("Table Name", CommentLine."Table Name"::"Seminar");
        CommentLine.SetRange("No.", rec."No.");
        CommentLine.DeleteAll(true);
        ExtendedTextHeader.Reset();
        ExtendedTextHeader.SetRange("Table Name", ExtendedTextHeader."Table Name"::"Seminar");
        ExtendedTextHeader.SetRange("No.", rec."No.");
        ExtendedTextHeader.DeleteAll(true);
    end;
}