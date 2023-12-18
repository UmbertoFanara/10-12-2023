table 80107 "UF Seminar Ledger Entry"
{
    Caption = 'Seminar Ledger Entry', Comment = 'ITA="Movimento Contabile Corso"';
    LookupPageId = "UF Seminar Ledger Entries";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.', Comment = 'ITA="Nr. Voce"';
        }
        field(2; "Seminar No."; Code[20])
        {
            Caption = 'Seminar No.', Comment = 'ITA="Nr. Corso"';
            TableRelation = "UF Seminar";
        }
        field(3; "Posting Date"; Date)
        {
            Caption = 'Posting Date', Comment = 'ITA="Data Registrazione"';
        }
        field(4; "Document Date"; Date)
        {
            Caption = 'Document Date', Comment = 'ITA="Data Fattura"';
        }
        field(5; "Entry Type"; Option)
        {
            Caption = 'Entry Type', Comment = 'ITA="Tipo Voce"';
            OptionMembers = "Registration","Cancellation";
            OptionCaption = 'Registration, Cancellation', comment = 'ITA="Registrazione, Annullamento"';
        }
        field(6; "Document No."; Code[20])
        {
            Caption = 'Document No.', Comment = 'ITA="Nr. Fattura"';
        }
        field(7; Description; Text[50])
        {
            Caption = 'Description', Comment = 'ITA="Descrizione"';
        }
        field(8; "Bill-to Customer No."; Code[20])
        {
            Caption = 'Bill-to Customer No.', Comment = 'ITA="Da Fatturare al Cliente Nr."';
            TableRelation = Customer;
        }
        field(9; "Charge Type"; Option)
        {
            Caption = 'Charge Type', Comment = 'ITA="Tipo Spesa"';
            OptionMembers = "Instructor","Room","Participant","Charge";
            OptionCaption = 'Instructor, Room, Participant, Charge', comment = 'ITA="Docente, Aula, Alunno, Spesa"';
        }
        field(10; Type; Option)
        {
            Caption = 'Type', Comment = 'ITA="Tipo"';
            OptionMembers = "Resource","G/L Account";
            OptionCaption = 'Resource, G/L Account', comment = 'ITA="Risorsa, Conto C/G"';
        }
        field(11; Quantity; Decimal)
        {
            Caption = 'Quantity', Comment = 'ITA="Quantità"';
            DecimalPlaces = 0 : 5;
        }
        field(12; "Unit Price"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Price', Comment = 'ITA="Prezzo Unitario"';
        }
        field(13; "Total Price"; Decimal)
        {
            Caption = 'Total Price', Comment = 'ITA="Prezzo Totale"';
            AutoFormatType = 1;
        }
        field(14; "Participant Contact No."; Code[20])
        {
            Caption = 'Participant Contact No.', Comment = 'ITA="Nr. Contatto Alunno"';
            TableRelation = Contact;
        }
        field(15; "Participant Name"; Text[50])
        {
            Caption = 'Participant Name', Comment = 'ITA="Nome Alunno"';
        }
        field(16; Chargeable; Boolean)
        {
            Caption = 'Chargeable', Comment = 'ITA="Addebiltabile"';
            InitValue = true;
        }
        field(17; "Seminar Room Code"; Code[10])
        {
            Caption = 'Seminar Room Code', Comment = 'ITA="Codice Aula Corso"';
            TableRelation = "UF Seminar Room";
        }
        field(18; "Instructor Code"; Code[10])
        {
            Caption = 'Instructor Code', Comment = 'ITA="Codice Docente"';
            TableRelation = "UF Instructor";
        }
        field(19; "Starting Date"; Date)
        {
            Caption = 'Starting Date', Comment = 'ITA="Data Inizio"';
        }
        field(20; "Seminar Registration No."; Code[20])
        {
            Caption = 'Seminar Registration No.', Comment = 'ITA="Nr. Registrazione Corso"';
        }
        field(21; "Job No."; Code[20])
        {
            Caption = 'Job No.', Comment = 'ITA="Nr. Commessa"';
            TableRelation = Job;
        }
        field(22; "Remaining Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Remaining Amount', Comment = 'ITA="Ammontare Restante"';
            Editable = false;
        }
        field(23; "Source Type"; Option)
        {
            Caption = 'Source Type', Comment = 'ITA="Tipo Sorgente"';
            OptionMembers = " ","Seminar";
            OptionCaption = ' , Seminar', comment = 'ITA=" , Corso"';
        }
        field(24; "Source No."; Code[20])
        {
            Caption = 'Source No.', Comment = 'ITA="Nr. Sorgente"';
            TableRelation = if ("Source Type" = const(Seminar)) "UF Seminar";
        }
        field(25; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name', Comment = 'ITA="Nome Def. Registrazioni"';
        }
        field(26; "Source Code"; Code[10])
        {
            Caption = 'Source Code', Comment = 'ITA="Codice Sorgente"';
            TableRelation = "Source Code";
        }
        field(27; "Reason Code"; Code[20])
        {
            Caption = 'Reason Code', Comment = 'ITA="Codice Causale"';
            TableRelation = "Reason Code";
        }
        field(28; "No. Series"; Code[10])
        {
            Caption = 'No. Series', Comment = 'ITA="Nr. Serie"';
            TableRelation = "No. Series";
        }
        field(29; "User ID"; Code[50])
        {
            Caption = 'User ID', Comment = 'ITA="ID Utente"';
            TableRelation = User."User Name";
            // TestTableRelation = false;
        }
        field(30; "Job Ledger Entry No."; Integer)
        {
            Caption = 'Job Ledger Entry No.', Comment = 'ITA="No. Voce Registro Commesse"';
            TableRelation = "Job Ledger Entry";
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(Key1; "Seminar No.", "Posting Date")
        {

        }
        key(Key2; "Bill-to Customer No.", "Seminar Registration No.", "Charge Type", "Participant Contact No.")
        {

        }
        key(Key3; "Document No.", "Posting Date")
        {

        }
        key(Key4; "Seminar No.", "Posting Date", "Charge Type", Chargeable)
        {
            SumIndexFields = "Total Price";
        }
    }
}