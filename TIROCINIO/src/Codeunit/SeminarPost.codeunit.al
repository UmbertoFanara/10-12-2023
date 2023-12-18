codeunit 80102 "UF SeminarPost"
{
    TableNo = "UF Seminar Registration Header";
    trigger OnRun()

    begin
        ClearAll();
        SeminarRegHeader := Rec;
        SeminarRegHeader.TestField("Posting Date");
        SeminarRegHeader.TestField("Document Date");
        SeminarRegHeader.TestField("Starting Date");
        SeminarRegHeader.TestField("Seminar No.");
        SeminarRegHeader.TestField(Duration);
        SeminarRegHeader.TestField("Instructor Code");
        SeminarRegHeader.TestField("Seminar Room Code");
        SeminarRegHeader.TestField("Job No.");
        SeminarRegHeader.TestField(Status, SeminarRegHeader.Status::Closed);

        SeminarRoom.Get(SeminarRegHeader."Seminar Room Code");
        SeminarRoom.TestField("Resource No.");
        Instructor.Get(SeminarRegHeader."Instructor Code");
        Instructor.TestField("Resource No.");

        SeminarRegLine.SetRange("Seminar Registration No.", SeminarRegHeader."No.");
        if SeminarRegLine.IsEmpty then
            error(NotFoundSemRegLineErr, SeminarRegHeader.TableCaption())
        else
            Window.Open('#1#################################\' +
            WinDlgTxt);
        Window.Update(1, Strsubstno(UpdateDlgTxt, RegDlgTxt, SeminarRegHeader."No."));

        if SeminarRegHeader."Posting No." = '' then begin
            SeminarRegHeader.TestField("Posting No. Series");
            SeminarRegHeader."Posting No." := NoSeriesMgt.GetNextNo(SeminarRegHeader."Posting No. Series", SeminarRegHeader."Posting Date", true);
            SeminarRegHeader.Modify();
            Commit();
        end;

        SeminarRegLine.LockTable();
        SeminarLedgEntry.LockTable();
        SourceCodeSetup.Get();
        SourceCode := SourceCodeSetup."UF Seminar";

        PstdSeminarRegHeader.Init();
        PstdSeminarRegHeader."No." := SeminarRegHeader."Posting No.";
        PstdSeminarRegHeader."Seminar Date" := SeminarRegHeader."Starting Date";
        PstdSeminarRegHeader."Seminar No." := SeminarRegHeader."Seminar No.";
        PstdSeminarRegHeader."Seminar Name" := SeminarRegHeader."Seminar Name";
        PstdSeminarRegHeader."Instructor Code" := SeminarRegHeader."Instructor Code";
        PstdSeminarRegHeader."Instructor Name" := SeminarRegHeader."Instructor Name";
        PstdSeminarRegHeader.Duration := SeminarRegHeader.Duration;
        PstdSeminarRegHeader."Maximum Participants" := SeminarRegHeader."Maximum Participants";
        PstdSeminarRegHeader."Minimum Participants" := SeminarRegHeader."Minimum Participants";
        PstdSeminarRegHeader."Seminar Room Code" := SeminarRegHeader."Seminar Room Code";
        PstdSeminarRegHeader."Seminar Room Name" := SeminarRegHeader."Seminar Room Name";
        PstdSeminarRegHeader."Seminar Room Address" := SeminarRegHeader."Seminar Room Address";
        PstdSeminarRegHeader."Seminar Room Address 2" := SeminarRegHeader."Seminar Room Address 2";
        PstdSeminarRegHeader."Seminar Room Post Code" := SeminarRegHeader."Seminar Room Post Code";
        PstdSeminarRegHeader."Seminar Room City" := SeminarRegHeader."Seminar Room City";
        PstdSeminarRegHeader."Seminar Room Phone No." := SeminarRegHeader."Seminar Room Phone No.";
        PstdSeminarRegHeader."Seminar Price" := SeminarRegHeader."Seminar Price";
        PstdSeminarRegHeader."Gen. Prod. Posting Group" := SeminarRegHeader."Gen. Prod. Posting Group";
        PstdSeminarRegHeader."VAT Prod. Posting Group" := SeminarRegHeader."VAT Prod. Posting Group";
        PstdSeminarRegHeader.Comment := SeminarRegHeader.Comment;
        PstdSeminarRegHeader."Posting Date" := SeminarRegHeader."Posting Date";
        PstdSeminarRegHeader."Document Date" := SeminarRegHeader."Document Date";
        PstdSeminarRegHeader."Job No." := SeminarRegHeader."Job No.";
        PstdSeminarRegHeader."Reason Code" := SeminarRegHeader."Reason Code";
        PstdSeminarRegHeader."No. Series" := SeminarRegHeader."No. Series";
        PstdSeminarRegHeader."Registration No. Series" := SeminarRegHeader."Posting No. Series";
        PstdSeminarRegHeader."Registration No." := SeminarRegHeader."No.";
        PstdSeminarRegHeader."Source Code" := SourceCode;
        PstdSeminarRegHeader."User ID" := CopyStr(UserId, 1, MaxStrLen(PstdSeminarRegHeader."User ID"));
        PstdSeminarRegHeader.Insert();

        Window.Update(1, StrSubstNo(PstngHdrDlgTxt, SeminarRegHeader."No.", PstdSeminarRegHeader."No."));

        CopyCommentLines(SeminarCommentLine."Document Type"::"Seminar Registration", SeminarCommentLine."Document Type"::"Posted Seminar Registration", SeminarRegHeader."No.", PstdSeminarRegHeader."No.");

        CopyCharges(SeminarRegHeader."No.", PstdSeminarRegHeader."No.");

        LineCount := 0;
        SeminarRegLine.Reset();
        SeminarRegLine.SetRange("Seminar Registration No.", SeminarRegHeader."No.", SeminarRegHeader."No.");
        if SeminarRegLine.Findset() then
            repeat
                LineCount := LineCount + 1;
                Window.Update(2, LineCount);

                SeminarRegLine.TestField("Bill-to Customer No.");
                SeminarRegLine.TestField("Participant Contact No.");

                if not SeminarRegLine."To Invoice" then begin
                    SeminarRegLine."Seminar Price" := 0;
                    SeminarRegLine."Line Discount %" := 0;
                    SeminarRegLine."Line Discount Amount" := 0;
                    SeminarRegLine.Amount := 0;
                end;
                PostSeminarJnlLine(2);

                PstdSeminarRegLine.Init();
                PstdSeminarRegLine.TransferFields(SeminarRegLine);
                PstdSeminarRegLine."Seminar Registration No." := PstdSeminarRegHeader."No.";
                PstdSeminarRegLine.Insert();
            until SeminarRegLine.Next() = 0;

        PostCharge();

        PostSeminarJnlLine(0);
        PostSeminarJnlLine(1);


        SeminarRegHeader.Delete();
        SeminarRegLine.Deleteall();

        SeminarCommentLine.SetRange("Document Type", SeminarCommentLine."Document Type"::"Seminar Registration");
        SeminarCommentLine.SetRange("No.", SeminarRegHeader."No.");
        SeminarCommentLine.DeleteAll();

        SeminarCharge.SetRange(Description);
        SeminarCharge.DeleteAll();
        Rec := SeminarRegHeader;
        Window.Close();
    end;

    var
        SeminarRegHeader: record "UF Seminar Registration Header";
        SeminarRegLine: record "UF Seminar Registration Line";
        PstdSeminarRegHeader: record "UF Posted Seminar Reg Header";
        PstdSeminarRegLine: record "UF Posted Seminar Reg Line";
        SeminarCommentLine: record "UF Seminar Comment Line";
        SeminarCommentLine2: record "UF Seminar Comment Line";
        SeminarCharge: record "UF Seminar Charge";
        PstdSeminarCharge: record "UF Posted Seminar Charge";
        SeminarRoom: record "UF Seminar Room";
        Seminar: record "UF Seminar";
        Instructor: record "UF Instructor";
        Job: record Job;
        JobTask: record "Job Task";
        Resource: record Resource;
        Customer: record Customer;
        GLAccount: record "G/L Account";
        Contact: record Contact;
        JobJnlTemplate: record "Job Journal Template";
        JobJnlBatch: record "Job Journal Batch";
        JobLedgEntry: record "Job Ledger Entry";
        SeminarLedgEntry: record "UF Seminar Ledger Entry";
        JobJnlLine: record "Job Journal Line";
        SeminarJnlLine: record "UF Seminar Journal Line";
        SourceCodeSetup: record "Source Code Setup";
        JobJnlPostLine: codeunit "Job Jnl.-Post Line";
        SeminarJnlPostLine: codeunit "UF SeminarJnlPostLine";
        NoSeriesMgt: codeunit NoSeriesManagement;
        ModifyHeader: boolean;
        Window: dialog;
        SourceCode: code[10];
        NextEntryNo: integer;
        LineCount: integer;
        JobLedgEntryNo: integer;
        SeminarLedgEntryNo: integer;
        EntryCounter: integer;
        TotalCounter: integer;
        NotFoundSemRegLineErr: label 'There are no Participants found for %1 record', comment = '%1headerNo. ITA="Non è stato trovato nessun alunno per la fattura del corso Nr. %1"';
        WinDlgTxt: label 'Posting lines              #2######\', comment = 'ITA="Contabilizzando righe              #2######\"';
        UpdateDlgTxt: label '%1 No.: %2', comment = 'ITA="%1 Nr.: %2"';
        RegDlgTxt: label 'Registration', comment = 'ITA="Fatture"';
        PstngHdrDlgTxt: label 'Registration %1  ---> Posted Reg. %2', comment = '%1 nr.reg, %2 nr.posted.reg ITA="Fattura Nr. %1 ---> In fattura contabile Nr. %2"';

    local procedure CopyCommentLines(FromDocumentType: Enum "UF Sem. Comment Document Type"; ToDocumentType: Enum "UF Sem. Comment Document Type"; FromNumber: code[20]; ToNumber: code[20])
    begin
        SeminarCommentLine.Reset();
        SeminarCommentLine.SetRange("Document Type", FromDocumentType);
        SeminarCommentLine.SetRange("No.", FromNumber);
        if SeminarCommentLine.FindSet() then
            repeat
                SeminarCommentLine2 := SeminarCommentLine;
                SeminarCommentLine2."Document Type" := ToDocumentType;
                SeminarCommentLine2."No." := ToNumber;
                SeminarCommentLine2.Insert();
            until SeminarCommentLine.Next() = 0;
    end;

    local procedure CopyCharges(FromNumber: code[20]; ToNumber: code[20])
    begin
        SeminarCharge.SetRange("Seminar Registration No.", FromNumber);
        if SeminarCharge.FindSet() then
            repeat
                PstdSeminarCharge.Init();
                PstdSeminarCharge.TransferFields(SeminarCharge);
                PstdSeminarCharge."Seminar Registration No." := ToNumber;
                PstdSeminarCharge.Insert();
            until SeminarCharge.Next() = 0;
    end;

    local procedure PostJobJnlLine(ChargeType: Enum "UF Type Seminar Charge"): integer
    begin
        if NextEntryNo = 0 then begin
            JobLedgEntry.LockTable();
            if JobLedgEntry.FindLast() then
                NextEntryNo := JobLedgEntry."Entry No.";
            NextEntryNo := NextEntryNo + 1;
        end;
        JobTask.SetRange("Job No.", SeminarRegHeader."Job No.");
        JobTask.SetRange("Job Task Type", JobTask."Job Task Type"::Posting);
        if not JobTask.FindSet() then
            Error('Non c''è nessuna JobTask di tipo Posting per il Nr. della fattura')
        else
            JobJnlLine."Job Task No." := JobTask."Job Task No.";
        JobJnlLine."Line No." := NextEntryNo;
        JobJnlLine."Posting Date" := SeminarRegHeader."Posting Date";
        JobJnlLine."Document No." := PstdSeminarRegHeader."No.";
        JobJnlLine."Document Date" := SeminarRegHeader."Document Date";
        JobJnlLine."Job No." := SeminarRegHeader."Job No.";
        JobJnlLine."Entry Type" := JobJnlLine."Entry Type"::Usage;
        JobJnlLine."UF Seminar Registration No." := PstdSeminarRegHeader."No.";
        JobJnlLine."Source Code" := SourceCode;
        Customer.SetRange("No.", SeminarCharge."Bill-to Customer No.");

        case ChargeType of
            ChargeType::"G/L Account":
                begin
                    GLAccount.Get(SeminarCharge."No.");

                    JobJnlLine.Type := JobJnlLine.Type::"G/L Account";
                    JobJnlLine."No." := GLAccount."No.";
                    JobJnlLine.Description := SeminarCharge.Description;
                    JobJnlLine."Description 2" := Customer.Name;
                    JobJnlLine.Chargeable := SeminarCharge."To Invoice";
                    JobJnlLine."Gen. Prod. Posting Group" := GLAccount."Gen. Prod. Posting Group";
                    JobJnlLine."Gen. Bus. Posting Group" := GLAccount."Gen. Bus. Posting Group";
                    JobJnlLine.Quantity := SeminarCharge.Quantity;
                    JobJnlLine."Quantity (Base)" := 1;
                    JobJnlLine."Unit Cost" := 0;
                    JobJnlLine."Total Cost" := 0;
                    JobJnlLine."Unit Price" := SeminarCharge."Unit Price";
                    JobJnlLine."Total Price" := SeminarCharge."Total Price";
                    JobJnlLine."Unit of Measure Code" := '';
                end;

            ChargeType::"Resource":
                begin
                    Resource.Get(SeminarCharge."No.");

                    JobJnlLine.Type := JobJnlLine.Type::Resource;
                    JobJnlLine."No." := Resource."No.";
                    JobJnlLine.Description := SeminarCharge.Description;
                    JobJnlLine."Description 2" := Customer.Name;
                    JobJnlLine.Chargeable := SeminarCharge."To Invoice";
                    JobJnlLine.Quantity := SeminarCharge.Quantity;
                    JobJnlLine."Gen. Prod. Posting Group" := Resource."Gen. Prod. Posting Group";
                    JobJnlLine."Unit of Measure Code" := SeminarCharge."Unit Of Measure Code";
                    JobJnlLine."Qty. per Unit of Measure" := SeminarCharge."Qty. per Unit of Measure";
                    JobJnlLine."Unit Price" := SeminarCharge."Unit Price";
                    JobJnlLine."Total Price" := SeminarCharge."Total Price";
                end;
        end;
        NextEntryNo := NextEntryNo + 1;
        // JobLedgEntry.FindLast();
        exit(JobJnlPostLine.RunWithCheck(JobJnlLine));
    end;

    local procedure PostSeminarJnlLine(ChargeType: option Instructor,Room,Participant,Charge): integer
    begin

        SeminarJnlLine.Init();
        SeminarJnlLine."Seminar No." := SeminarRegHeader."Seminar No.";
        SeminarJnlLine."Posting Date" := SeminarRegHeader."Posting Date";
        SeminarJnlLine."Document Date" := SeminarRegHeader."Document Date";
        SeminarJnlLine."Document No." := PstdSeminarRegHeader."No.";
        SeminarJnlLine."Charge Type" := ChargeType;
        SeminarJnlLine."Instructor Code" := SeminarRegHeader."Instructor Code";
        SeminarJnlLine."Starting Date" := SeminarRegHeader."Starting Date";
        SeminarJnlLine."Seminar Registration No." := PstdSeminarRegHeader."No.";
        SeminarJnlLine."Job No." := SeminarRegHeader."Job No.";
        SeminarJnlLine."Seminar Room Code" := SeminarRegHeader."Seminar Room Code";
        SeminarJnlLine."Source Type" := SeminarJnlLine."Source Type"::Seminar;
        SeminarJnlLine."Source No." := SeminarRegHeader."Seminar No.";
        SeminarJnlLine."Source Code" := SourceCode;
        SeminarJnlLine."Reason Code" := SeminarRegHeader."Reason Code";
        SeminarJnlLine."Posting No. Series" := SeminarRegHeader."Posting No. Series";
        case ChargeType of
            ChargeType::Instructor:
                begin
                    Instructor.Get(SeminarRegHeader."Instructor Code");
                    SeminarJnlLine.Description := Instructor.Name;
                    SeminarJnlLine.Type := SeminarJnlLine.Type::Resource;
                    SeminarJnlLine.Chargeable := false;
                    SeminarJnlLine.Quantity := SeminarRegHeader.Duration;
                    SeminarJnlLine."Job Ledger Entry No." := PostJobJnlLine(SeminarCharge.Type);
                end;
            ChargeType::Room:
                begin
                    SeminarRoom.Get(SeminarRegHeader."Seminar Room Code");
                    SeminarJnlLine.Description := SeminarRoom.Name;
                    SeminarJnlLine.Type := SeminarJnlLine.Type::Resource;
                    SeminarJnlLine.Chargeable := false;
                    SeminarJnlLine.Quantity := SeminarRegHeader.Duration;
                    SeminarJnlLine."Job Ledger Entry No." := PostJobJnlLine(SeminarCharge.Type);
                end;
            ChargeType::Participant:
                begin
                    Contact.Get(SeminarRegLine."Participant Contact No.");
                    SeminarJnlLine."Bill-to Customer No." := SeminarRegLine."Bill-to Customer No.";
                    SeminarJnlLine."Participant Contact No." := SeminarRegLine."Participant Contact No.";
                    SeminarJnlLine."Participant Name" := Contact.Name;
                    SeminarJnlLine.Description := Contact.Name;
                    SeminarJnlLine.Type := SeminarJnlLine.Type::Resource;
                    SeminarJnlLine.Chargeable := SeminarRegLine."To Invoice";
                    SeminarJnlLine.Quantity := 1;
                    SeminarJnlLine."Unit Price" := SeminarRegLine."Seminar Price";
                    SeminarJnlLine."Total Price" := SeminarRegLine.Amount;
                    SeminarJnlLine."Job Ledger Entry No." := PostJobJnlLine(SeminarCharge.Type);
                end;
            ChargeType::Charge:
                begin
                    if SeminarCharge.Type = SeminarCharge.Type::"G/L Account" then
                        SeminarJnlLine.Type := SeminarJnlLine.Type::"G/L Account";
                    if SeminarCharge.Type = SeminarCharge.Type::Resource then
                        SeminarJnlLine.Type := SeminarJnlLine.Type::Resource;

                    SeminarJnlLine.Description := SeminarCharge.Description;
                    SeminarJnlLine."Bill-to Customer No." := SeminarCharge."Bill-to Customer No.";
                    SeminarJnlLine.Quantity := SeminarCharge.Quantity;
                    SeminarJnlLine."Unit Price" := SeminarCharge."Unit Price";
                    SeminarJnlLine."Total Price" := SeminarCharge."Total Price";
                    SeminarJnlLine.Chargeable := SeminarCharge."To Invoice";
                    SeminarJnlLine."Job Ledger Entry No." := PostJobJnlLine(SeminarCharge.Type);
                end;
        end;

        SeminarJnlPostLine.RunWithCheck(SeminarJnlLine);


        exit(SeminarLedgEntry."Entry No.");
    end;

    local procedure PostCharge()
    begin
        SeminarCharge.SetRange("Seminar Registration No.", SeminarRegHeader."No.");
        if SeminarCharge.FindSet() then
            repeat
                PostSeminarJnlLine(3);
            until SeminarCharge.Next() = 0;
    end;
}