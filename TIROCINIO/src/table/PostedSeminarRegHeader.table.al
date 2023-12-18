table 80111 "UF Posted Seminar Reg Header"
{
    Caption = 'Posted Seminar Registration Header', Comment = 'ITA="Testata Contabile Fattura Corso"';
    LookupPageId = "UF Posted Seminar Reg List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.', Comment = 'ITA="Nr."';
        }
        field(2; "Seminar Date"; Date)
        {
            Caption = 'Seminar Date', Comment = 'ITA="Data Corso"';
        }
        field(3; "Seminar No."; Code[10])
        {
            Caption = 'Seminar No.', Comment = 'ITA="Nr. Corso"';
            TableRelation = "UF Seminar";
        }
        field(4; "Seminar Name"; Text[50])
        {
            Caption = 'Seminar Name', Comment = 'ITA="Nome Corso"';
        }
        field(5; "Instructor Code"; Code[10])
        {
            Caption = 'Instructor Code', Comment = 'ITA="Codice Docente"';
            TableRelation = "UF Instructor";
        }
        field(6; "Instructor Name"; Text[100])
        {
            Caption = 'Instructor Name', Comment = 'ITA="Nome Docente"';
            CalcFormula = lookup("UF Instructor".Name where(Code = field("Instructor Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(7; "Duration"; Decimal)
        {
            Caption = 'Duration', Comment = 'ITA="Durata"';
            DecimalPlaces = 0 : 1;
        }
        field(8; "Maximum Participants"; Integer)
        {
            Caption = 'Maximum Participants', Comment = 'ITA="Nr. Massimo di Alunni"';
        }
        field(9; "Minimum Participants"; Integer)
        {
            Caption = 'Minimum Participants', Comment = 'ITA="Nr. Minimo di Alunni"';
        }
        field(10; "Seminar Room Code"; Code[20])
        {
            Caption = 'Seminar Room Code', Comment = 'ITA="Codice Aula"';
            TableRelation = "UF Seminar Room";
        }
        field(11; "Seminar Room Name"; Text[30])
        {
            Caption = 'Seminar Room Name', Comment = 'ITA="Nome Aula"';
        }
        field(12; "Seminar Room Address"; Text[30])
        {
            Caption = 'Seminar Room Address', Comment = 'ITA="Indirizzo Aula"';
        }
        field(13; "Seminar Room Address 2"; Text[30])
        {
            Caption = 'Seminar Room Address 2', Comment = 'ITA="Secondo Indirizzo Aula"';
        }
        field(14; "Seminar Room Post Code"; Code[20])
        {
            Caption = 'Seminar Room Post Code', Comment = 'ITA="CAP Aula"';
            TableRelation = "Post Code";
        }
        field(15; "Seminar Room City"; Text[30])
        {
            Caption = 'Seminar Room City', Comment = 'ITA="Città Aula"';
        }
        field(16; "Seminar Room Phone No."; Text[30])
        {
            Caption = 'Seminar Room Phone No.', Comment = 'ITA="Nr. Telefonico Aula"';
        }
        field(17; "Seminar Price"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Seminar Price', Comment = 'ITA="Prezzo Corso"';
        }
        field(18; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group', Comment = 'ITA="Cat. Reg. Articolo/Servizio"';
            TableRelation = "Gen. Product Posting Group";
        }
        field(19; "VAT Prod. Posting Group"; Code[10])
        {
            Caption = 'VAT Prod. Posting Group', Comment = 'ITA="Cat. Reg. IVA Articolo/Servizio"';
            TableRelation = "VAT Product Posting Group";
        }
        field(20; Comment; Boolean)
        {
            CalcFormula = exist("UF Seminar Comment Line" where("No." = field("No.")));
            Caption = 'Comment', Comment = 'ITA="Commento"';
            FieldClass = FlowField;
        }
        field(21; "Posting Date"; Date)
        {
            Caption = 'Posting Date', Comment = 'ITA="Data Registrazione"';
        }
        field(22; "Document Date"; Date)
        {
            Caption = 'Document Date', Comment = 'ITA="Data Fattura"';
        }
        field(23; "Job No."; Code[20])
        {
            Caption = 'Job. No.', Comment = 'ITA="Nr. Commessa"';
            TableRelation = Job;
        }
        field(24; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code', Comment = 'ITA="Codice Causale"';
            TableRelation = "Reason Code";
        }
        field(25; "No. Series"; Code[10])
        {
            Caption = 'No. Series', Comment = 'ITA="Nr. Seriale"';
            TableRelation = "No. Series";
        }
        field(26; "Registration No. Series"; Code[20])
        {
            Caption = 'Registration No. Series', Comment = 'ITA="Nr. Seriale Registrazione"';
            TableRelation = "No. Series";
        }
        field(27; "Registration No."; Code[20])
        {
            Caption = 'Registration No.', Comment = 'ITA="Nr. Registrazione"';
        }
        field(28; "User ID"; Code[36])
        {
            Caption = 'User ID', Comment = 'ITA="ID Utente"';
            TableRelation = User;
        }
        field(29; "Source Code"; Code[10])
        {
            Caption = 'Source Code', Comment = 'ITA="Codice Sorgente"';
            TableRelation = "Source Code";
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
        key(key1; "Seminar Room Code")
        {
            SumIndexFields = Duration;
        }
    }
}