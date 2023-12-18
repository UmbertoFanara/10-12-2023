table 80103 "UF Seminar Registration Header"
{
    Caption = 'Seminar Registration Header', Comment = 'ITA="Testata Fattura Corso"';
    LookupPageID = "UF Seminar Reg. List";
    DrillDownPageId = "UF Seminar Reg. List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.', Comment = 'ITA="Nr."';
            // pag. 27 punto 6
            trigger OnValidate()
            var
                SeminarSetup: record "UF Seminar Setup";
                NoSeriesManagement: codeunit NoSeriesManagement;
            begin
                if "No." <> xrec."No." then begin
                    SeminarSetup.Get();
                    NoSeriesManagement.TestManual(SeminarSetup."Seminar Registration Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Starting Date"; Date)
        {
            Caption = 'Starting Date', Comment = 'ITA="Data di Inizio"';

            // pag.28 punto 7
            trigger OnValidate()
            begin
                if "Starting Date" <> xrec."Starting Date" then
                    rec.TestField(Status, Status::Planning);
            end;
        }
        field(3; "Seminar No."; Code[20])
        {
            Caption = 'Seminar No.', Comment = 'ITA="Nr. Corso"';
            TableRelation = "UF Seminar";
            // Artigianale
            trigger OnValidate()
            var
                Seminar: record "UF Seminar";
            begin
                if "Seminar No." <> xRec."Seminar No." then begin
                    SeminarRegLine.Reset();
                    SeminarRegLine.SetRange("Seminar Registration No.", "No.");
                    SeminarRegLine.SetRange(Registered, true);
                    if SeminarRegLine.FindSet() then
                        Error(SemChangeErr, SeminarRegLine.TableCaption(), SeminarRegLine."Seminar Registration No.", FieldCaption("Seminar No."), "Seminar No.");
                    seminar.Get("Seminar No.");
                    seminar.TestField(Blocked, false);
                    seminar.TestField("Gen. Prod. Posting Group");
                    seminar.TestField("VAT Prod. Posting Group");
                    "Seminar Name" := seminar.Name;
                    Duration := seminar."Seminar Duration";
                    "Seminar Price" := seminar."Seminar Price";
                    "Gen. Prod. Posting Group" := seminar."Gen. Prod. Posting Group";
                    "VAT Prod. Posting Group" := seminar."VAT Prod. Posting Group";
                    "Minimum Participants" := seminar."Minimum Participants";
                    "Maximum Participants" := seminar."Maximum Participants";
                    Validate("Job No.", seminar."Job No.");
                end;
            end;
        }
        field(4; "Seminar Name"; Text[50])
        {
            Caption = 'Seminar Name', Comment = 'ITA="Nome Corso"';
        }
        field(5; "Instructor Code"; Code[10])
        {
            Caption = 'Instructor Code', Comment = 'ITA="Codice Docente"';
            TableRelation = "UF Instructor";
            // pag. 29 punto 9
            trigger OnValidate()
            var
                Instructor: record "UF Instructor";
            begin
                if ("Instructor Code" <> '') or ("Instructor Code" <> xrec."Instructor Code") then
                    if Instructor.Get(rec."Instructor Code") then
                        rec."Instructor Name" := instructor.Name;
            end;
        }
        field(6; "Instructor Name"; Text[100])
        {
            Caption = 'Instructor Name', Comment = 'ITA="Nome Docente"';
            CalcFormula = lookup("UF Instructor".Name where("Code" = field("Instructor Code")));
            Editable = false;
            FieldClass = FlowField;
            InitValue = '';
        }
        field(7; Status; enum "UF Status Seminar Reg. Header")
        {
            Caption = 'Status', Comment = 'ITA="Stato"';
            InitValue = Planning;
        }
        field(8; "Duration"; Decimal)
        {
            Caption = 'Duration', Comment = 'ITA="Durata"';
            DecimalPlaces = 0 : 1;
        }
        field(9; "Maximum Participants"; Integer)
        {
            Caption = 'Maximum Participants', Comment = 'ITA="Nr. Massimo Alunni"';
        }
        field(10; "Minimum Participants"; Integer)
        {
            Caption = 'Minimum Participants', Comment = 'ITA="Nr. Minimo Alunni"';
        }
        field(11; "Seminar Room Code"; Code[10])
        {
            Caption = 'Seminar Room Code', Comment = 'ITA="Codice Aula"';
            TableRelation = "UF Seminar Room";
            // pag. 29 punto 10
            trigger OnValidate()
            var
                SeminarRoom: record "UF Seminar Room";
            begin
                if rec."Seminar Room Code" = '' then begin
                    rec."Seminar Room Name" := '';
                    rec."Seminar Room Address" := '';
                    rec."Seminar Room Address 2" := '';
                    rec."Seminar Room Post Code" := '';
                    rec."Seminar Room City" := '';
                    "Seminar Room Phone No." := '';
                end else
                    SeminarRoom.get(rec."Seminar Room Code");
                rec."Seminar Room Name" := SeminarRoom.Name;
                rec."Seminar Room Address" := SeminarRoom.Address;
                rec."Seminar Room Address 2" := SeminarRoom."Address 2";
                rec."Seminar Room Post Code" := SeminarRoom."Post Code";
                rec."Seminar Room City" := SeminarRoom.City;
                "Seminar Room Phone No." := SeminarRoom."Phone No.";
                // pag. 29 punto 11
                if (CurrFieldNo <> 0) then
                    if (SeminarRoom."Maximum Participants" <> 0) and (SeminarRoom."Maximum Participants" < rec."Maximum Participants") then
                        if Confirm(Confirm001Msg, true, rec."Maximum Participants", SeminarRoom."Maximum Participants", FieldCaption(rec."Maximum Participants"), rec.TableCaption, SeminarRoom.TableCaption) then
                            rec."Maximum Participants" := SeminarRoom."Maximum Participants";
            end;
        }
        field(12; "Seminar Room Name"; Text[100])
        {
            Caption = 'Seminar Room Name', Comment = 'ITA="Nominativo Aula"';
        }
        field(13; "Seminar Room Address"; Text[50])
        {
            Caption = 'Seminar Room Address', Comment = 'ITA="Indirizzo Aula"';
        }
        field(14; "Seminar Room Address 2"; Text[50])
        {
            Caption = 'Seminar Room Address 2', Comment = 'ITA="Secondo Indirizzo Aula"';
        }
        field(15; "Seminar Room Post Code"; Code[20])
        {
            Caption = 'Seminar Room Post Code', Comment = 'ITA="CAP Aula"';
            TableRelation = "Post Code";

            // pag. 30 punto 12
            trigger OnValidate()
            var
                PostCode: Record "Post Code";
            begin
                if ("Seminar Room Post Code" <> '') or ("Seminar Room Post Code" <> xrec."Seminar Room Post Code") then
                    PostCode.ValidatePostCode("Seminar Room City", "Seminar Room Post Code", "Seminar Room County", "Seminar Room Country/Region", true);
            end;

            // pag. 30 punto 13
            trigger OnLookup()
            var
                PostCode: Record "Post Code";
                SeminarRoomCity: text;
                County: text;
            begin
                County := rec."Seminar Room County";
                SeminarRoomCity := rec."Seminar Room City";
                PostCode.LookupPostCode(SeminarRoomCity, "Seminar Room Post Code", County, rec."Seminar Room Country/Region");
                rec."Seminar Room County" := CopyStr(County, 1, MaxStrLen("Seminar Room County"));
                rec."Seminar Room City" := CopyStr(SeminarRoomCity, 1, MaxStrLen("Seminar Room City"));
            end;

        }
        field(16; "Seminar Room City"; Text[30])
        {
            Caption = 'Seminar Room City', Comment = 'ITA="Città Aula"';
            // pag. 30 punto 14
            trigger OnValidate()
            var
                PostCode: Record "Post Code";
            begin
                if ("Seminar Room City" <> '') or (Rec."Seminar Room City" <> xRec."Seminar Room City") then
                    PostCode.ValidateCity(rec."Seminar Room City", rec."Seminar Room Post Code", rec."Seminar Room County", rec."Seminar Room Country/Region", true);
            end;
            //pag. 30 punto 15
            trigger OnLookup();
            var
                PostCode: Record "Post Code";
                SeminarRoomCity: text;
                County: text;
            begin
                SeminarRoomCity := rec."Seminar Room City";
                PostCode.Get(rec."Seminar Room Post Code", SeminarRoomCity);
                PostCode.LookupPostCode(SeminarRoomCity, rec."Seminar Room Post Code", County, rec."Seminar Room Country/Region");
                rec."Seminar Room County" := CopyStr(County, 1, MaxStrLen("Seminar Room County"));
                rec."Seminar Room City" := CopyStr(SeminarRoomCity, 1, MaxStrLen("Seminar Room City"));
            end;

        }
        field(17; "Seminar Room Phone No."; Text[30])
        {
            Caption = 'Seminar Room Phone No.', Comment = 'ITA="Nr. Telefonico Aula"';
            // Set Extended Data Type Prop.
        }
        field(18; "Seminar Price"; Decimal)
        {
            Caption = 'Seminar Price', Comment = 'ITA="Prezzo Corso"';
            AutoFormatType = 1;

            // pag. 30 punto 16
            trigger OnValidate()
            begin
                if (rec."Seminar Price" <> xrec."Seminar Price") and (rec.Status <> rec.Status::Canceled) then begin
                    SeminarRegLine.SetRange("Seminar Registration No.", "No.");
                    SeminarRegLine.SetRange("Line No.", 10000);
                    SeminarRegLine.SetRange(Registered, false);
                    if SeminarRegLine.FindSet(false, false) then
                        if Confirm(Confirm002Msg, false, FieldCaption(rec."Seminar Price"), SeminarRegLine.TableCaption) then begin
                            repeat
                                SeminarRegLine.Validate("Seminar Price", rec."Seminar Price");
                                SeminarRegLine.Modify();
                            until SeminarRegLine.Next() = 0;
                            Modify();
                        end;
                end;
            end;
        }
        field(19; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group', Comment = 'ITA="Cat. Reg. Articolo/Servizio"';
            TableRelation = "Gen. Product Posting Group";
        }
        field(20; "VAT Prod. Posting Group"; Code[10])
        {
            Caption = 'VAT Prod. Posting Group', Comment = 'ITA="Cat. Reg. IVA Articolo/Servizio"';
            TableRelation = "VAT Product Posting Group";
        }
        field(21; Comment; Boolean)
        {
            Caption = 'Comment', Comment = 'ITA="Commento"';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = exist("UF Seminar Comment Line" where("No." = field("No.")));
        }
        field(22; "Posting Date"; Date)
        {
            Caption = 'Posting Date', Comment = 'ITA="Data di Registrazione"';
        }
        field(23; "Document Date"; Date)
        {
            Caption = 'Document Date', Comment = 'ITA="Data Fattura"';
        }
        field(24; "Job No."; Code[20])
        {
            Caption = 'Job No.', Comment = 'ITA="Nr. Commessa"';
            TableRelation = Job;
            // pag. 30 punto 17
            trigger OnValidate()
            var
                SeminarCharge: record "UF Seminar Charge";
            begin
                if rec."Job No." <> xrec."Job No." then begin
                    SeminarCharge.SetRange("Job No.", xrec."Job No.");
                    SeminarCharge.SetRange("Seminar Registration No.", rec."No.");
                    if SeminarCharge.FindSet(true, true) then
                        if Confirm(Confirm003Msg, true, FieldCaption("Job No."), SeminarCharge.TableCaption) then
                            SeminarCharge.ModifyAll("Job No.", rec."Job No.")
                        else
                            rec."Job No." := xrec."Job No.";
                end;
            end;
        }
        field(25; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code', Comment = 'ITA="Codice Causale"';
            TableRelation = "Reason Code";
        }
        field(26; "No. Series"; Code[20])
        {
            Caption = 'No. Series', Comment = 'ITA="Nr. di Serie"';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(27; "Posting No. Series"; Code[20])
        {
            Caption = 'Posting No. Series', Comment = 'ITA="Nr. Serie Fatture Contabili"';
            TableRelation = "No. Series";
            // pag. 31 punto 18
            trigger OnValidate()
            var
                SeminarSetup: record "UF Seminar Setup";
                NoSeriesMgt: codeunit NoSeriesManagement;
            begin
                if "Posting No. Series" = '' then
                    exit;

                SeminarSetup.Get();
                SeminarSetup.TestField("Seminar Registration Nos.");
                SeminarSetup.TestField("Posted Seminar Reg. Nos.");
                NoSeriesMgt.TestSeries(SeminarSetup."Posted Seminar Reg. Nos.", "Posting No. Series");
                TestField("Posting No.", '');
            end;

            trigger OnLookup()
            var
                SeminarRegHeader: record "UF Seminar Registration Header";
                SeminarSetup: record "UF Seminar Setup";
                NoSeriesMgt: codeunit NoSeriesManagement;
            begin
                SeminarRegHeader := Rec;
                SeminarSetup.Get();
                SeminarSetup.TestField("Seminar Registration Nos.");
                SeminarSetup.TestField("Posted Seminar Reg. Nos.");
                if NoSeriesMgt.LookupSeries(SeminarSetup."Posted Seminar Reg. Nos.", "Posting No. Series") then
                    NoSeriesMgt.SetSeries("Posting No.");
                Rec := SeminarRegHeader;
            end;
        }
        field(28; "Posting No."; Code[20])
        {
            Caption = 'Posting No.', Comment = 'ITA="Nr. Fattura Contabile"';

            trigger OnValidate()
            var
                SeminarSetup: record "UF Seminar Setup";
                NoSeriesManagement: codeunit NoSeriesManagement;
            begin
                if "Posting No." <> xrec."Posting No." then begin
                    SeminarSetup.Get();
                    NoSeriesManagement.TestManual(SeminarSetup."Posted Seminar Reg. Nos.");
                    "Posting No. Series" := '';
                end;
            end;
        }
        field(29; "Seminar Room County"; Text[30])
        {
            Caption = 'Seminar County', Comment = 'ITA="Contea Aula"';
        }
        field(30; "Seminar Room Country/Region"; Code[10])
        {
            Caption = 'Seminar Room Country/Region Code', Comment = 'ITA="Codice Regionale Aula"';
        }
        field(40; "No. Printed"; Integer)
        {
            Caption = 'No. Printed', Comment = 'ITA="Nr. Report"';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Seminar Room Code")
        {
            SumIndexFields = Duration;
        }
    }
    var
        SeminarRegLine: record "UF Seminar Registration Line";
        RegCheck001Err: Label '%1 field %2 is %3', Comment = '%1 nometab, %2 nomecampo, %3 valregistered ITA="Il valore del campo %2 della tabella %1 è %3"';
        EmptyCheck002Err: Label '%1 record is not empty.', Comment = '%1 nometab ITA="Il record della tabella %1 non è vuoto."';
        Rename003Err: Label 'Record of %1 cannot be renamed.', Comment = '%1 nometab ITA="Il record della tabella %1 non può essere rinominato."';
        SemChangeErr: Label 'You cannot change the %3 value: "%4" because there are already some registered %1 inserted in the registration No. %2  ', Comment = '%1nometabSemRegLine %2valorecampoSemRegNo. %3NomecampoSemNo. %4valorecampoSemNo. ITA="Non Puoi cambiare il valore "%4" di %3 perchè ci sono gia %1 contabili inserite nella fattura Nr. %2"';
        Confirm001Msg: Label 'Do you want to change the value of  %4 %3: %1 to the value of %5 %3: %2 ?', Comment = '%1 valoremaxpart, %2 valmaxpartseminarroom, %3 nomecampo, %4 nometab, %5 nometabsemroom ITA="Vuoi cambiare il valore di  %5 %3: %2 in quello di %4 %3: %1 ?"';
        Confirm002Msg: Label 'Do you want to change %1 in table %2 too ?', Comment = '%1 nomecampo, %2 nometab ITA="Vuoi cambiare il %1 anche nella tabella %2 ?"';
        Confirm003Msg: Label 'Do you want to change the value of %1 in table %2 too ?', Comment = '%1 nomecampo, %2 nometab ITA="Vuoi cambiare il valore del %2 anche nella tabella %2 ?"';



    // pag. 27 punto 3
    trigger OnInsert()
    var
        SeminarSetup: Record "UF Seminar Setup";
        NoSeriesManagement: codeunit NoSeriesManagement;
    begin
        if rec."No." = '' then begin
            SeminarSetup.Get();
            SeminarSetup.TestField("Seminar Registration Nos.");
            NoSeriesManagement.InitSeries(SeminarSetup."Seminar Registration Nos.", xRec."No. Series", 0D, rec."No.", rec."No. Series");
        end;
        if rec."Posting No." = '' then begin
            SeminarSetup.Get();
            SeminarSetup.TestField("Posted Seminar Reg. Nos.");
            NoSeriesManagement.InitSeries(SeminarSetup."Posted Seminar Reg. Nos.", xRec."Posting No. Series", 0D, rec."Posting No.", rec."Posting No. Series");
        end;
        InitRecord();
    end;



    // pag. 27 punto 5
    trigger OnRename()
    begin
        Error(Rename003Err, rec.TableCaption);
    end;

    // pag. 27 punto 4
    trigger OnDelete()
    var
        SeminarCharge: Record "UF Seminar Charge";
        SeminarCommentLine: Record "UF Seminar Comment Line";
    begin
        TestField(Status, Status::Canceled);
        SeminarRegLine.Reset();
        SeminarRegLine.SetRange("Seminar Registration No.", rec."No.");
        SeminarRegLine.SetRange("Line No.", 10000);
        SeminarRegLine.SetRange(Registered, true);
        if SeminarRegLine.FindSet() then
            Error(RegCheck001Err, SeminarRegLine.TableCaption, SeminarRegLine.FieldCaption(Registered), true);
        SeminarRegLine.SetRange(Registered);
        SeminarRegLine.DeleteAll(true);

        SeminarCharge.Reset();
        SeminarCharge.SetRange("Seminar Registration No.", "No.");
        if not SeminarCharge.IsEmpty then
            Error(EmptyCheck002Err, SeminarCharge.TableCaption);

        SeminarCommentLine.Reset();
        SeminarCommentLine.SetRange("Document Type", SeminarCommentLine."Document Type"::"Seminar Registration");
        SeminarCommentLine.SetRange("No.", "No.");
        SeminarCommentLine.DeleteAll();
    end;
    // pag. 26 punto 1
    procedure AssistEdit(/* OldSeminarRegHeader: record "UF Seminar Registration Header" */): Boolean
    var
        SeminarRegistrationHeader: Record "UF Seminar Registration Header";
        SeminarSetup: Record "UF Seminar Setup";
        NoSeriesManagement: codeunit NoSeriesManagement;
    begin
        SeminarRegistrationHeader := Rec;
        SeminarSetup.Get();
        SeminarSetup.TestField("Seminar Registration Nos.");
        if NoSeriesManagement.SelectSeries(SeminarSetup."Seminar Registration Nos.", xRec."No. Series", "No. Series") then begin
            NoseriesManagement.SetSeries("No.");
            Rec := SeminarRegistrationHeader;
            exit(true);
        end;
    end;

    // pag. 26 punto 2
    procedure InitRecord()
    var
        SeminarSetup: record "UF Seminar Setup";
        NoSeriesManagement: codeunit NoSeriesManagement;
    begin
        if "Posting Date" = 0D then begin
            "Posting Date" := today();
            "Document Date" := today();
        end;
        SeminarSetup.Get();
        SeminarSetup.TestField("Posted Seminar Reg. Nos.");
        NoSeriesManagement.SetDefaultSeries("Posting No. Series", SeminarSetup."Posted Seminar Reg. Nos."); // terzo numeratore non ancora utilizzato
    end;
}