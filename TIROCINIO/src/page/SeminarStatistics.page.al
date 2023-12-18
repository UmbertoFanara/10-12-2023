page 80119 "UF SeminarStatistics"
{
    ApplicationArea = All;
    Caption = 'Seminar Statistics', Comment = 'ITA="Statistiche Corso"';
    Editable = false;
    LinksAllowed = false;
    PageType = Card;
    SourceTable = "UF Seminar";
    UsageCategory = History;



    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General', Comment = 'ITA="Generale"';
                fixed(Control1000000002)
                {
                    ShowCaption = false;
                    group("This Period")
                    {
                        Caption = 'This Period', Comment = 'ITA=""';
                        field("SeminarDateName[1]"; SeminarDateName[1])
                        {
                        }
                        field("TotalPrice[1]"; TotalPrice[1])
                        {
                            Caption = 'Total Price', Comment = 'ITA=""';
                        }
                        field("TotalPriceNotChargeable[1]"; TotalPriceNotChargeable[1])
                        {
                            Caption = 'Total Price (Not Chargeable)', Comment = 'ITA=""';
                        }
                        field("TotalPriceChargeable[1]"; TotalPriceChargeable[1])
                        {
                            Caption = 'Total Price (Chargeable)', Comment = 'ITA=""';
                        }
                    }
                    group("This Year")
                    {
                        Caption = 'This Year', Comment = 'ITA=""';
                        field("SeminarDateName[2]"; SeminarDateName[2])
                        {
                        }
                        field("TotalPrice[2]"; TotalPrice[2])
                        {
                            Caption = 'Total Price', Comment = 'ITA=""';
                        }
                        field("TotalPriceNotChargeable[2]"; TotalPriceNotChargeable[2])
                        {
                            Caption = 'Total Price (Not Chargeable)', Comment = 'ITA=""';
                        }
                        field("TotalPriceChargeable[2]"; TotalPriceChargeable[2])
                        {
                            Caption = 'Total Price (Chargeable)', Comment = 'ITA=""';
                        }
                    }
                    group("Last Year")
                    {
                        Caption = 'Last Year', Comment = 'ITA=""';
                        field("SeminarDateName[3]"; SeminarDateName[3])
                        {
                        }
                        field("TotalPrice[3]"; TotalPrice[3])
                        {
                            Caption = 'Total Price', Comment = 'ITA=""';
                        }
                        field("TotalPriceNotChargeable[3]"; TotalPriceNotChargeable[3])
                        {
                            Caption = 'Total Price (Not Chargeable)', Comment = 'ITA=""';
                        }
                        field("TotalPriceChargeable[3]"; TotalPriceChargeable[3])
                        {
                            Caption = 'Total Price (Chargeable)', Comment = 'ITA=""';
                        }
                    }
                    group("To Date")
                    {
                        Caption = 'To Date', Comment = 'ITA=""';
                        field("SeminarDateName[4]"; SeminarDateName[4])
                        {
                        }
                        field("TotalPrice[4]"; TotalPrice[4])
                        {
                            Caption = 'Total Price', Comment = 'ITA=""';
                        }
                        field("TotalPriceNotChargeable[4]"; TotalPriceNotChargeable[4])
                        {
                            Caption = 'Total Price (Not Chargeable)', Comment = 'ITA=""';
                        }
                        field("TotalPriceChargeable[4]"; TotalPriceChargeable[4])
                        {
                            Caption = 'Total Price (Chargeable)', Comment = 'ITA=""';
                        }
                    }
                }
            }
        }
    }

    actions
    {

    }
    trigger OnAfterGetRecord()
    begin
        rec.SetRange("No.", rec."No.");
        if CurrentDate <> WorkDate() then begin
            CurrentDate := WorkDate();
            DateFilterCalc.CreateAccountingPeriodFilter(SeminarDateFilter[1], SeminarDateName[1], CurrentDate, 0);
            DateFilterCalc.CreateFiscalYearFilter(SeminarDateFilter[2], SeminarDateName[2], CurrentDate, 0);
            DateFilterCalc.CreateFiscalYearFilter(SeminarDateFilter[3], SeminarDateName[3], CurrentDate, -1);
        end;

        for i := 1 to 4 do begin
            rec.SetFilter("Date Filter", SeminarDateFilter[i]);
            rec.CalcFields("Total Price", "Total Price (Not Chargeable)", "Total Price (Chargeable)");
            TotalPrice[i] := rec."Total Price";
            TotalPriceNotChargeable[i] := rec."Total Price (Not Chargeable)";
            TotalPriceChargeable[i] := rec."Total Price (Chargeable)";
        end;

        rec.SetRange("Date Filter", 0D, CurrentDate);
    end;

    var
        DateFilterCalc: Codeunit "DateFilter-Calc";
        SeminarDateFilter: array[4] of Text[30];
        SeminarDateName: array[4] of Text[30];
        CurrentDate: Date;
        TotalPrice: array[4] of Decimal;
        TotalPriceNotChargeable: array[4] of Decimal;
        TotalPriceChargeable: array[4] of Decimal;
        i: Integer;
}