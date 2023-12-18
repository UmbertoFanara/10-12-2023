table 80100 "UF Instructor"
{
    Caption = 'Instructors', Comment = 'ITA="Docente"';
    DataCaptionFields = Code, Name;
    DrillDownPageId = "UF Instructors";
    LookupPageId = "UF Instructors";

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code', comment = 'ITA="Codice"';
            NotBlank = true;
        }
        field(2; Name; Text[100])
        {
            Caption = 'Name', Comment = 'ITA="Nome"';
        }
        field(3; "Internal/External"; Option)
        {
            OptionMembers = "Internal","External";
            OptionCaption = 'Internal, External', comment = 'ITA="Interno,Esterno"';
            Caption = 'Internal/External', comment = 'ITA="Interno/Esterno"';
        }
        field(4; "Resource No."; Code[20])
        {
            Caption = 'Resouce No.', Comment = 'ITA="Nr. Risorsa"';
            TableRelation = Resource where(Type = const(Person)); // 156
            // riempie il nome dalla tabella master se il campo nome è vuoto
            trigger OnValidate()
            var
                Resource: Record Resource;
            begin
                if Resource.Get("Resource No.") and (Rec.Name = '') then
                    Rec.Name := Resource.Name;
            end;
        }
        field(5; "Contact No."; Code[20])
        {
            Caption = 'Contact No.', Comment = 'Nr. Contatto';
            TableRelation = Contact; //5050
            // riempie il nome dalla tabella master dei Contatti se il campo nome è vuoto
            trigger OnValidate()
            var
                Contact: Record Contact;
            begin
                if Contact.GET("Contact No.") and (Rec.Name = '') then
                    Rec.Name := Contact.Name;
            end;
        }
    }
    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }
}