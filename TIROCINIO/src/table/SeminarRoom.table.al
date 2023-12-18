table 80102 "UF Seminar Room"
{
    Caption = 'Seminar Rooms', comment = 'ITA="Aula Corso"';
    DataCaptionFields = Code, Name;
    LookupPageId = "UF Seminar Room List";

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code', comment = 'ITA="Codice"';
            NotBlank = true;
        }
        field(2; Name; Text[100])
        {
            Caption = 'Name', comment = 'ITA="Nome"';
        }
        field(3; Address; Text[50])
        {
            Caption = 'Address', comment = 'ITA="Indirizzo"';
        }
        field(4; "Address 2"; Text[50])
        {
            Caption = 'Address 2', comment = 'ITA="Secondo Indirizzo"';
        }
        field(5; City; Text[30])
        {
            Caption = 'City', comment = 'ITA="Città"';
            // riempie gli altri campi dei contatti in base alla città selezionata
            trigger OnValidate()
            var
                mycounty: Text[30];
            begin
                PostCode.ValidateCity(City, "Post Code", mycounty, "Country/Region Code", true);
            end;
            // idem su ricerca
            trigger OnLookup()
            var
                myCity: Text;
                County: Text;
            begin
                myCity := Rec.City;
                PostCode.LookupPostCode(myCity, "Post Code", County, "Country/Region Code");
                Rec.City := CopyStr(myCity, 1, MaxStrLen(Rec.City));
            end;
        }
        field(6; "Post Code"; Code[20])
        {
            Caption = 'Post Code', comment = 'ITA="CAP"';
            TableRelation = "Post Code"; //225

            trigger OnValidate()
            var
                mycounty: Text[30];
            begin
                PostCode.ValidatePostCode(City, "Post Code", mycounty, "Country/Region Code", true);
            end;

            trigger OnLookup()
            var
                myCity: Text;
                County: Text;

            begin
                myCity := Rec.City;
                PostCode.LookupPostCode(myCity, "Post Code", County, "Country/Region Code");
                rec.City := CopyStr(myCity, 1, MaxStrLen(Rec.City));
            end;
        }
        field(7; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code', comment = 'ITA="Codice Regionale"';
            TableRelation = "Country/Region"; // 9
        }
        field(8; "Phone No."; Text[30])
        {
            Caption = 'Phone No.', comment = 'ITA="Nr. Telefonico"';
            ExtendedDatatype = PhoneNo;
        }
        field(9; "Fax No."; Text[30])
        {
            Caption = 'Fax No.', comment = 'ITA="Nr. Fax"';
            ExtendedDatatype = PhoneNo;
        }
        field(10; "Name 2"; Text[50])
        {
            Caption = 'Name 2', comment = 'ITA="Secondo Nome"';
        }
        field(11; Contact; Text[50])
        {
            Caption = 'Contact', comment = 'ITA="Contatto"';
        }
        field(12; "E-Mail"; Text[80])
        {
            Caption = 'E-Mail', comment = 'ITA="E-Mail"';
            ExtendedDatatype = EMail;
        }
        field(13; "Home Page"; Text[90])
        {
            Caption = 'Home Page', comment = 'ITA="Home Page"';
            ExtendedDatatype = URL;

            trigger OnValidate()
            var
                VerificaUrl: Codeunit "UF VerificaUrl";
            begin
                if (rec."Home Page" <> '') or ("Home Page" <> xrec."Home Page") then
                    VerificaUrl.VerificaUrl(rec."Home Page");
            end;
        }
        field(14; "Maximum Participants"; Integer)
        {
            Caption = 'Maximum Participants', comment = 'ITA=" Nr. Massimo Alunni"';
        }
        field(15; Allocation; Decimal)
        {
            Caption = 'Allocation', comment = 'ITA="Designata"';
            Editable = false;
        }
        field(16; "Resource No."; Code[20])
        {
            Caption = 'Resource No.', comment = 'ITA="Nr. Risorsa"';
            TableRelation = Resource where(Type = const(Machine));
            trigger OnValidate()
            var
                Resource: Record Resource;
            begin
                if Resource.Get("Resource No.") and (Name = '') then
                    Name := Resource.Name
            end;
        }
        field(17; Comment; Boolean)
        {
            Caption = 'Comment', comment = 'ITA="Commento"';
            FieldClass = FlowField;
            CalcFormula = exist("Comment Line" where("Table Name" = const("Seminar Room")));
            Editable = false;
        }
        field(18; "Internal/External"; Option)
        {

            OptionMembers = "Internal","External";
            OptionCaption = 'Internal, External', comment = 'ITA="In Sede/Succursale"';
            Caption = 'Internal/External', comment = 'ITA="In Sede/Succursale"';
        }
        field(19; "Contact No."; Code[20])
        {
            Caption = 'Contact No.', comment = 'ITA="Nr. Contatto"';
            TableRelation = Contact; //5050
            trigger OnValidate()
            var
                Contact: Record Contact;
            begin
                if Contact.Get("Resource No.") and (Name = '') then
                    Name := Contact.Name
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
    var
        PostCode: Record "Post Code";
    // All'eliminazione della voce cancella anche i rispettivi commenti e testi estesi nelle tabelle di riferimento
    trigger OnDelete()
    var
        CommentLine: Record "Comment Line";
        ExtendedTextHeader: Record "Extended Text Header";
    begin
        CommentLine.Reset();
        CommentLine.SetRange("Table Name", CommentLine."Table Name"::"Seminar Room");
        CommentLine.SetRange("No.", Code);
        CommentLine.DeleteAll();

        ExtendedTextHeader.Reset();
        ExtendedTextHeader.SetRange("Table Name", ExtendedTextHeader."Table Name"::"Seminar Room");
        ExtendedTextHeader.SetRange("No.", Code);
        ExtendedTextHeader.DeleteAll(true);
    end;
}