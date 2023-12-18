table 80109 "UF Seminar Setup"
{
    Caption = 'Seminar Setup', comment = 'ITA="Setup Corso"';
    LookupPageId = "UF Seminar Setup";
    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key', comment = 'ITA="Chiave Primaria"';
        }
        field(2; "Seminar Nos."; Code[10])
        {
            Caption = 'Seminar Nos.', comment = 'ITA="Seriale corso"';
            TableRelation = "No. Series";
        }
        field(3; "Seminar Registration Nos."; Code[10])
        {
            Caption = 'Seminar Registration Nos.', comment = 'ITA="Seriale corso da Registrare"';
            TableRelation = "No. Series";
        }
        field(4; "Posted Seminar Reg. Nos."; Code[10])
        {
            Caption = 'Posted Seminar Reg. Nos.', comment = 'ITA="Seriale corso Registrato"';
            TableRelation = "No. Series";
        }
    }
    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}