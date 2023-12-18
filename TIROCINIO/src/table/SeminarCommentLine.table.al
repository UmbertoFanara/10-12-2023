table 80101 "UF Seminar Comment Line"
{
    Caption = 'Seminar Comment Line', comment = 'ITA="Riga Commento Corso"';
    DrillDownPageID = "UF Seminar Comment";
    LookupPageID = "UF Seminar Comment";

    fields
    {
        field(1; "Document Type"; Enum "UF Sem. Comment Document Type")
        {
            Caption = 'Document Type', comment = 'ITA="Tipo Documento"';
        }
        field(2; "No."; Code[20])
        {
            Caption = 'No.', comment = 'ITA="Nr."';
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.', comment = 'ITA="Nr. Riga"';
        }
        field(4; "Date"; Date)
        {
            Caption = 'Date', comment = 'ITA="Data"';
        }
        field(5; "Code"; Code[10])
        {
            Caption = 'Code', comment = 'ITA="Codice"';
        }
        field(6; Comment; Text[80])
        {
            Caption = 'Comment', comment = 'ITA="Commento"';
        }
        field(7; "Document Line No."; Integer)
        {
            Caption = 'Document Line No.', comment = 'ITA="Nr. Riga Fattura"';
        }
    }

    keys
    {
        key(Key1; "Document Type", "No.", "Document Line No.", "Line No.")
        {
            Clustered = true;
        }
    }
    procedure SetUpNewLine()
    var
        SeminarCommentLine: Record "UF Seminar Comment Line";
    begin
        SeminarCommentLine.SetRange("Document Type", "Document Type");
        SeminarCommentLine.SetRange("No.", "No.");
        SeminarCommentLine.SetRange("Document Line No.", "Document Line No.");
        SeminarCommentLine.SetRange(Date, WorkDate());
        if not SeminarCommentLine.FindFirst() then
            Date := WorkDate();

        OnAfterSetUpNewLine(Rec, SeminarCommentLine);
    end;

    procedure CopyComments(FromDocumentType: Integer; ToDocumentType: Integer; FromNumber: Code[20]; ToNumber: Code[20])
    var
        SeminarCommentLine: Record "UF Seminar Comment Line";
        SeminarCommentLine2: Record "UF Seminar Comment Line";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeCopyComments(SeminarCommentLine, ToDocumentType, IsHandled, FromDocumentType, FromNumber, ToNumber);
        if IsHandled then
            exit;

        SeminarCommentLine.SetRange("Document Type", FromDocumentType);
        SeminarCommentLine.SetRange("No.", FromNumber);
        if SeminarCommentLine.FindSet() then
            repeat
                SeminarCommentLine2 := SeminarCommentLine;
                SeminarCommentLine2."Document Type" := "UF Sem. Comment Document Type".FromInteger(ToDocumentType);
                SeminarCommentLine2."No." := ToNumber;
                SeminarCommentLine2.Insert();
            until SeminarCommentLine.Next() = 0;
    end;

    procedure CopyLineComments(FromDocumentType: Integer; ToDocumentType: Integer; FromNumber: Code[20]; ToNumber: Code[20]; FromDocumentLineNo: Integer; ToDocumentLineNo: Integer)
    var
        SeminarCommentLineSource: Record "UF Seminar Comment Line";
        SeminarCommentLineTarget: Record "UF Seminar Comment Line";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeCopyLineComments(
          SeminarCommentLineTarget, IsHandled, FromDocumentType, ToDocumentType, FromNumber, ToNumber, FromDocumentLineNo, ToDocumentLineNo);
        if IsHandled then
            exit;

        SeminarCommentLineSource.SetRange("Document Type", FromDocumentType);
        SeminarCommentLineSource.SetRange("No.", FromNumber);
        SeminarCommentLineSource.SetRange("Document Line No.", FromDocumentLineNo);
        if SeminarCommentLineSource.FindSet() then
            repeat
                SeminarCommentLineTarget := SeminarCommentLineSource;
                SeminarCommentLineTarget."Document Type" := "UF Sem. Comment Document Type".FromInteger(ToDocumentType);
                SeminarCommentLineTarget."No." := ToNumber;
                SeminarCommentLineTarget."Document Line No." := ToDocumentLineNo;
                SeminarCommentLineTarget.Insert();
            until SeminarCommentLineSource.Next() = 0;
    end;

    procedure CopyLineCommentsFromSeminarLines(FromDocumentType: Integer; ToDocumentType: Integer; FromNumber: Code[20]; ToNumber: Code[20]; var TempSeminarLineSource: Record "UF Seminar Registration Line" temporary)
    var
        SeminarCommentLineSource: Record "UF Seminar Comment Line";
        SeminarCommentLineTarget: Record "UF Seminar Comment Line";
        IsHandled: Boolean;
        NextLineNo: Integer;
    begin
        IsHandled := false;
        OnBeforeCopyLineCommentsFromSeminarLines(
          SeminarCommentLineTarget, IsHandled, FromDocumentType, ToDocumentType, FromNumber, ToNumber, TempSeminarLineSource);
        if IsHandled then
            exit;

        SeminarCommentLineTarget.SetRange("Document Type", ToDocumentType);
        SeminarCommentLineTarget.SetRange("No.", ToNumber);
        SeminarCommentLineTarget.SetRange("Document Line No.", 0);
        if SeminarCommentLineTarget.FindLast() then;
        NextLineNo := SeminarCommentLineTarget."Line No." + 10000;
        SeminarCommentLineTarget.Reset();

        SeminarCommentLineSource.SetRange("Document Type", FromDocumentType);
        SeminarCommentLineSource.SetRange("No.", FromNumber);
        if TempSeminarLineSource.FindSet() then
            repeat
                SeminarCommentLineSource.SetRange("Document Line No.", TempSeminarLineSource."Line No.");
                if SeminarCommentLineSource.FindSet() then
                    repeat
                        SeminarCommentLineTarget := SeminarCommentLineSource;
                        SeminarCommentLineTarget."Document Type" := "UF Sem. Comment Document Type".FromInteger(ToDocumentType);
                        SeminarCommentLineTarget."No." := ToNumber;
                        SeminarCommentLineTarget."Document Line No." := 0;
                        SeminarCommentLineTarget."Line No." := NextLineNo;
                        SeminarCommentLineTarget.Insert();
                        NextLineNo += 10000;
                    until SeminarCommentLineSource.Next() = 0;
            until TempSeminarLineSource.Next() = 0;
    end;

    procedure CopyHeaderComments(FromDocumentType: Integer; ToDocumentType: Integer; FromNumber: Code[20]; ToNumber: Code[20])
    var
        SeminarCommentLineSource: Record "UF Seminar Comment Line";
        SeminarCommentLineTarget: Record "UF Seminar Comment Line";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeCopyHeaderComments(SeminarCommentLineTarget, IsHandled, FromDocumentType, ToDocumentType, FromNumber, ToNumber);
        if IsHandled then
            exit;

        SeminarCommentLineSource.SetRange("Document Type", FromDocumentType);
        SeminarCommentLineSource.SetRange("No.", FromNumber);
        SeminarCommentLineSource.SetRange("Document Line No.", 0);
        if SeminarCommentLineSource.FindSet() then
            repeat
                SeminarCommentLineTarget := SeminarCommentLineSource;
                SeminarCommentLineTarget."Document Type" := "UF Sem. Comment Document Type".FromInteger(ToDocumentType);
                SeminarCommentLineTarget."No." := ToNumber;
                SeminarCommentLineTarget.Insert();
            until SeminarCommentLineSource.Next() = 0;
    end;

    procedure DeleteComments(DocType: Option; DocNo: Code[20])
    begin
        SetRange("Document Type", DocType);
        SetRange("No.", DocNo);
        if not IsEmpty() then
            DeleteAll();
    end;

    procedure ShowComments(DocType: Option; DocNo: Code[20]; DocLineNo: Integer)
    var
        SeminarCommentSheet: Page "UF Seminar Comment Sheet";
    begin
        SetRange("Document Type", DocType);
        SetRange("No.", DocNo);
        SetRange("Document Line No.", DocLineNo);
        Clear(SeminarCommentSheet);
        SeminarCommentSheet.SetTableView(Rec);
        SeminarCommentSheet.RunModal();
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterSetUpNewLine(var SeminarCommentLineRec: Record "UF Seminar Comment Line"; var SeminarCommentLineFilter: Record "UF Seminar Comment Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCopyComments(var SeminarCommentLine: Record "UF Seminar Comment Line"; ToDocumentType: Integer; var IsHandled: Boolean; FromDocumentType: Integer; FromNumber: Code[20]; ToNumber: Code[20])
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCopyLineComments(var SeminarCommentLine: Record "UF Seminar Comment Line"; var IsHandled: Boolean; FromDocumentType: Integer; ToDocumentType: Integer; FromNumber: Code[20]; ToNumber: Code[20]; FromDocumentLineNo: Integer; ToDocumentLine: Integer)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCopyLineCommentsFromSeminarLines(var SeminarCommentLine: Record "UF Seminar Comment Line"; var IsHandled: Boolean; FromDocumentType: Integer; ToDocumentType: Integer; FromNumber: Code[20]; ToNumber: Code[20]; var TempSeminarLineSource: Record "UF Seminar Registration Line" temporary)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCopyHeaderComments(var SeminarCommentLine: Record "UF Seminar Comment Line"; var IsHandled: Boolean; FromDocumentType: Integer; ToDocumentType: Integer; FromNumber: Code[20]; ToNumber: Code[20])
    begin
    end;
}

