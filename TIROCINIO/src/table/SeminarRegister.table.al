table 80108 "UF Seminar Register"
{
    Caption = 'Seminar Register', Comment = 'ITA="Registro Fatturazione Corso"';
    LookupPageId = "UF Seminar Register";

    fields
    {
        field(1; "No."; Integer)
        {
            Caption = 'No.', Comment = 'ITA="Nr."';
        }
        field(2; "From Entry No."; Integer)
        {
            Caption = 'From Entry No.', Comment = 'ITA="Dalla Voce Nr."';
            TableRelation = "UF Seminar Ledger Entry";
        }
        field(3; "To Entry No."; Integer)
        {
            Caption = 'To Entry No.', Comment = 'ITA="Alla Voce Nr."';
            TableRelation = "UF Seminar Ledger Entry";
        }
        field(4; "Creation Date"; Date)
        {
            Caption = 'Creation Date', Comment = 'ITA="Data Creazione"';
        }
        field(5; "Source Code"; Code[10])
        {
            Caption = 'Source Code', Comment = 'ITA="Codice Sorgente"';
            TableRelation = "Source Code";
        }
        field(6; "User ID"; Code[50])
        {
            Caption = 'User ID', Comment = 'ITA="ID Utente"';
            TableRelation = User."User Name";
        }
        field(7; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name', Comment = 'ITA="Nome Def. Registrazioni"';
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
        key(Key1; "Source Code", "Journal Batch Name", "Creation Date")
        {

        }
    }
}