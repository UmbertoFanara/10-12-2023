report 80102 "UF SeminarInvoices"
{
    ApplicationArea = All;
    ProcessingOnly = true;
    UsageCategory = Tasks;

    dataset
    {
        dataitem(SeminarLedgerEntry; "UF Seminar Ledger Entry")
        {
            DataItemTableView = sorting("Bill-to Customer No.", "Seminar Registration No.", "Charge Type", "Participant Contact No.");
            RequestFilterFields = "Bill-to Customer No.", "Seminar No.", "Posting Date";
            trigger OnAfterGetRecord()
            begin
                JobLedgerEntry.Get(SeminarLedgerEntry."Job Ledger Entry No.");
                if "Bill-to Customer No." <> Customer."No." then
                    Customer.get("Bill-to Customer No.");

                if Customer.Blocked in [Customer.Blocked::All, Customer.Blocked::Invoice] then
                    NoOfSalesInvErrors := NoOfSalesInvErrors + 1
                else begin
                    if "Bill-to Customer No." <> SalesHeader."Bill-to Customer No." then
                        Window.Update(1, "Bill-to Customer No.");
                    if SalesHeader."No." <> '' then
                        FinalizeSalesInvoiceHeader();
                    InsertSalesInvoiceHeader();
                    SalesLine."Document Type" := SalesHeader."Document Type";
                    SalesLine."Document No." := SalesHeader."No.";
                end;
                Window.Update(2, "Seminar Registration No.");

                SalesLine.Type := JobLedgerEntry.Type;

                case JobLedgerEntry.Type of
                    Type::"G/L Account":
                        begin
                            Job.Get(SeminarLedgerEntry."Job No.");
                            Job.TestField("Job Posting Group");
                            JobPostingGroup.Get(Job."Job Posting Group");
                            JobPostingGroup.TestField("G/L Expense Acc. (Contract)");
                            SalesLine."No." := JobPostingGroup."G/L Expense Acc. (Contract)";
                        end;
                    else
                        SalesLine."No." := JobLedgerEntry."No.";
                        SalesLine."Document Type" := SalesHeader."Document Type";
                        SalesLine."Document No." := SalesHeader."No.";
                        SalesLine."Line No." := NextLineNo;
                        SalesLine.Description := SeminarLedgerEntry.Description;
                        SalesLine."Work Type Code" := JobLedgerEntry."Work Type Code";
                        SalesLine."Unit of Measure Code" := JobLedgerEntry."Unit of Measure Code";
                        if (JobLedgerEntry."Total Price" <> 0) and (JobLedgerEntry.Quantity <> 0) then
                            SalesLine."Unit Price" := JobLedgerEntry."Total Price" / JobLedgerEntry.Quantity;
                end;

                if SalesHeader."Currency Code" <> '' then
                    if SalesHeader."Currency Factor" = 0 then
                        CurrencyExchRate.ExchangeAmtLCYToFCY(WorkDate(), SalesHeader."Currency Code",
                                SalesLine."Unit Price", SalesHeader."Currency Factor");
                if (JobLedgerEntry."Total Cost" <> 0) and (JobLedgerEntry.Quantity <> 0) then
                    SalesLine."Unit Cost (LCY)" := JobLedgerEntry."Total Cost" / JobLedgerEntry.Quantity;
                SalesLine.Quantity := JobLedgerEntry.Quantity;
                SalesLine."Job No." := JobLedgerEntry."Job No.";
                SalesLine.Insert();

                NextLineNo := NextLineNo + 1000;
            end;

            trigger OnPostDataItem()
            begin
                Window.Close();
                if SalesHeader."No." = '' then
                    Message(Text006Msg)
                else begin
                    FinalizeSalesInvoiceHeader();
                    if NoOfSalesInvErrors = 0 then
                        Message(
                          Text007Msg,
                          NoOfSalesInv)
                    else
                        Message(
                          Text005Msg,
                          NoOfSalesInvErrors);
                end;
            end;

            trigger OnPreDataItem()
            begin
                if PostingDateReq = 0D then
                    Error(Text000Err);
                if DocDateReq = 0D then
                    Error(Text001Err);

                Window.Open(Text002Lbl + Text003Lbl + Text004Lbl);
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(PostingDateReqField; PostingDateReq)
                    {
                        Caption = 'Posting Date', Comment = 'ITA="Data Contabile"';
                        Tooltip = '', Comment = 'ITA=""';
                    }
                    field(DocDateReqField; DocDateReq)
                    {
                        Caption = 'Document Date', Comment = 'ITA="Data Fattura"';
                        Tooltip = '', Comment = 'ITA=""';
                    }
                    field(CalcInvoiceDiscountField; CalcInvoiceDiscount)
                    {
                        Caption = 'Calc. Inv. Discount', Comment = 'ITA=""';
                        Tooltip = '', Comment = 'ITA=""';
                    }
                    field(PostInvoicesField; PostInvoices)
                    {
                        Caption = 'Post Invoices', Comment = 'ITA=""';
                        Tooltip = '', Comment = 'ITA=""';
                    }
                }
            }
        }
        actions
        {

        }
        trigger OnOpenPage()
        begin
            if PostingDateReq = 0D then
                PostingDateReq := WorkDate();
            if DocDateReq = 0D then
                DocDateReq := WorkDate();
            SalesSetup.Get();
            CalcInvoiceDiscount := SalesSetup."Calc. Inv. Discount";
        end;
    }

    //  rendering
    // {

    // }

    labels
    {

    }

    var
        SalesHeader: record "Sales Header";
        SalesLine: record "Sales Line";
        SalesSetup: record "Sales & Receivables Setup";
        GLSetup: record "General Ledger Setup";
        Customer: record Customer;
        Job: record Job;
        JobLedgerEntry: record "Job Ledger Entry";
        JobPostingGroup: record "Job Posting Group";
        CurrencyExchRate: record "Currency Exchange Rate";
        SalesCalcDiscount: codeunit "Sales-Calc. Discount";
        SalesPost: codeunit "Sales-Post";
        Window: dialog;
        PostingDateReq, DocDateReq : date;
        CalcInvoiceDiscount, PostInvoices : boolean;
        NextLineNo, NoOfSalesInvErrors, NoOfSalesInv : integer;

        Text000Err: Label 'Please enter the posting date.', Comment = 'ITA="Inserisci una data di contabilizzazione"';
        Text001Err: Label 'Please enter the document date.', Comment = 'ITA="Inserisci una data documento"';
        Text002Lbl: Label 'Creating Seminar Invoices...\\', Comment = 'ITA="Creando Fatture Corso...\\"';
        Text003Lbl: Label 'Customer No.     #1##########\', Comment = 'ITA="Cliente Nr.    #1##########\"';
        Text004Lbl: Label 'Registration No.     #2##########\', Comment = 'ITA="Fattura Nr.     #2##########\"';
        Text005Msg: Label 'Not all invoices are posted. A total of %1 invoices are not posted.', Comment = 'ITA="Non tutte le fatture sono state registrate. Un totale di %1 fatture non sono state registrate"';
        Text006Msg: Label 'There is nothing to invoice', Comment = 'ITA="Non c''è nessuna fattura da registrare"';
        Text007Msg: Label 'The number of invoice(s) created is %1.', Comment = 'ITA="Sono state create %1 fatture"';

    local procedure FinalizeSalesInvoiceHeader()
    begin
        if CalcInvoiceDiscount then begin
            SalesCalcDiscount.Run(SalesLine);
            SalesHeader.Get(SalesLine."Document Type", SalesLine."No.");
            Commit();
            Clear(SalesCalcDiscount);
            Clear(SalesPost);
            NoOfSalesInv := NoOfSalesInv + 1;
        end;
        if PostInvoices then begin
            Clear(SalesPost);
            if not SalesPost.Run(SalesHeader) then
                NoOfSalesInvErrors := NoOfSalesInvErrors + 1;
        end;
    end;

    local procedure InsertSalesInvoiceHeader()
    begin
        SalesHeader.Init();
        SalesHeader."Document Type" := SalesHeader."Document Type"::Invoice;
        SalesHeader."No." := '';
        SalesHeader.Insert(true);
        SalesHeader.Validate("Sell-to Customer No.", SeminarLedgerEntry."Bill-to Customer No.");
        if SalesHeader."Bill-to Customer No." <> SalesHeader."Sell-to Customer No." then
            SalesHeader.Validate("Bill-to Customer No.", SeminarLedgerEntry."Bill-to Customer No.");
        SalesHeader.Validate("Posting Date", PostingDateReq);
        SalesHeader.Validate("Document Date", DocDateReq);
        SalesHeader.Validate("Currency Code", '');
        SalesHeader.Modify();
        Commit();
        NextLineNo := 10000;
    end;


}