table 80114 "UF SeminarReportSelections"
{
    Caption = 'Seminar Report Selection', Comment = 'ITA="transaltion"';

    fields
    {
        field(1; Usage; Option)
        {
            Caption = 'Usage', Comment = 'ITA="Utilizzo"';
            OptionCaption = 'S.Registration', Comment = 'ITA="Registrazione Corso"';
            OptionMembers = "S.Registration";
        }
        field(2; Sequence; Code[10])
        {
            Caption = 'Sequence', Comment = 'ITA="Sequenza"';
            Numeric = true;
        }
        field(3; "Report ID"; Integer)
        {
            Caption = 'Report ID', Comment = 'ITA="ID Report"';
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = const(Report));
            trigger OnValidate();
            begin
                CalcFields("Report Name");
            end;
        }
        field(4; "Report Name"; Text[80])
        {
            Caption = 'Report Name', Comment = 'ITA="Nome Report"';
            CalcFormula = lookup(AllObjWithCaption."Object Caption" where("Object Type" = const(Report), "Object ID" = field("Report ID")));
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(PK; Usage, Sequence)
        {
            Clustered = true;
        }
    }
    var
        SemRepSel2: record "UF SeminarReportSelections";

    procedure NewRecord()
    begin
        SemRepSel2.SetRange(Usage, Usage);
        if SemRepSel2.Find('+') and (SemRepSel2.Sequence <> '') then
            Sequence := IncStr(SemRepSel2.Sequence)
        else
            Sequence := '1';
    end;
}