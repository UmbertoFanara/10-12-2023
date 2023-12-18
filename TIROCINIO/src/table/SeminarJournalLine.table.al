table 80106 "UF Seminar Journal Line"
{
    Caption = 'Seminar Journal Line', Comment = 'ITA="Riga Mastrino Corsi"';

    fields
    {
        field(1; "Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name', Comment = 'ITA="Nome Schema Registrazioni"';
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.', Comment = 'ITA="Nr. Riga"';
        }
        field(3; "Seminar No."; Code[20])
        {
            Caption = 'Seminar No.', Comment = 'ITA="Nr. Corso"';
            TableRelation = "UF Seminar";
        }
        field(4; "Posting Date"; Date)
        {
            Caption = 'Posting Date', Comment = 'ITA="Data Registrazione"';
        }
        field(5; "Document Date"; Date)
        {
            Caption = 'Document Date', Comment = 'ITA="Data Fattura"';
        }
        field(6; "Entry Type"; Option)
        {
            Caption = 'Entry Type', Comment = 'ITA="Tipo Voce"';
            OptionMembers = "Registration","Cancellation";
            OptionCaption = 'Registration, Cancellation', comment = 'ITA="Registrazione, Annullamento"';
        }
        field(7; "Document No."; Code[20])
        {
            Caption = 'Document No.', Comment = 'ITA="Nr. Fattura"';
        }
        field(8; Description; Text[50])
        {
            Caption = 'Description', Comment = 'ITA="Descrizione"';
        }
        field(9; "Bill-to Customer No."; Code[20])
        {
            Caption = 'Bill-to Customer No.', Comment = 'ITA="Da Fatturare al Cliente Nr."';
            TableRelation = Customer;
        }
        field(10; "Charge Type"; Option)
        {
            Caption = 'Charge Type', Comment = 'ITA="Tipo Spesa"';
            OptionMembers = "Instructor","Room","Participant","Charge";
            OptionCaption = 'Instructor, Room, Participant, Charge', comment = 'ITA="Docente, Aula, Alunno, Spesa"';
        }
        field(11; Type; Option)
        {
            Caption = 'Type', Comment = 'ITA="Tipo"';
            OptionMembers = "Resource","G/L Account";
            OptionCaption = 'Resource, G/L Account', comment = 'ITA="Risorsa, Conto C/G"';
        }
        field(12; Quantity; Decimal)
        {
            Caption = 'Quantity', Comment = 'ITA="Quantità"';
            DecimalPlaces = 0 : 5;
        }
        field(13; "Unit Price"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Price', Comment = 'ITA="Prezzo Unitario"';
        }
        field(14; "Total Price"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Total Price', Comment = 'ITA="Prezzo Totale"';
        }
        field(15; "Participant Contact No."; Code[20])
        {
            Caption = 'Participant Contact No.', Comment = 'ITA="Nr. Contatto Alunno"';
            TableRelation = Contact;
        }
        field(16; "Participant Name"; Text[50])
        {
            Caption = 'Participant Name', Comment = 'ITA="Nome Alunno"';
        }
        field(17; Chargeable; Boolean)
        {
            Caption = 'Chargeable', Comment = 'ITA="Addebitabile"';
            InitValue = true;
        }
        field(18; "Seminar Room Code"; Code[10])
        {
            Caption = 'Seminar Room Code', Comment = 'ITA="Codice Aula Corso"';
            TableRelation = "UF Seminar Room";
        }
        field(19; "Instructor Code"; Code[10])
        {
            Caption = 'Instructor Code', Comment = 'ITA="Codice Docente"';
            TableRelation = "UF Instructor";
        }
        field(20; "Starting Date"; Date)
        {
            Caption = 'Starting Date', Comment = 'ITA="Data Inizio"';
        }
        field(21; "Seminar Registration No."; Code[20])
        {
            Caption = 'Seminar Registration No.', Comment = 'ITA="Nr. Registrazione Corso"';
        }
        field(22; "Job No."; Code[20])
        {
            Caption = 'Job No.', Comment = 'ITA="Nr. Commessa"';
            TableRelation = Job;
        }
        field(23; "Job Ledger Entry No."; Integer)
        {
            Caption = 'Job Ledger Entry No.', Comment = 'ITA="Nr. Movimento Contabile Commessa"';
            TableRelation = "Job Ledger Entry";
        }
        field(24; "Source Type"; Option)
        {
            Caption = 'Source Type', Comment = 'ITA="Tipo Sorgente"';
            OptionMembers = " ","Seminar";
            OptionCaption = ' , Seminar', comment = 'ITA=" , Corso"';
        }
        field(25; "Source No."; Code[20])
        {
            Caption = 'Source No.', Comment = 'ITA="Nr. Sorgente"';
            TableRelation = if ("Source Type" = const(Seminar)) "UF Seminar";
        }
        field(26; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name', Comment = 'ITA="Nome Def. Registrazioni"';
        }
        field(27; "Source Code"; Code[10])
        {
            Caption = 'Source Code', Comment = 'ITA="Codice Sorgente"';
            TableRelation = "Source Code";
        }
        field(28; "Reason Code"; Code[20])
        {
            Caption = 'Reason Code', Comment = 'ITA="Codice Causale"';
        }
        field(29; "Posting No. Series"; Code[10])
        {
            Caption = 'Posting No. Series', Comment = 'ITA="Nr. Seriale Registrazione"';
        }
    }

    keys
    {
        key(PK; "Journal Template Name", "Journal Batch Name", "Line No.")
        {
            Clustered = true;
        }
    }

    procedure EmptyLine(): Boolean
    begin
        if rec."Seminar No." = '' then
            exit(true);
    end;

}