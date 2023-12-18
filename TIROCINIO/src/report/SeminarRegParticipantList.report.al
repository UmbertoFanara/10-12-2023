report 80100 "UF SeminarRegParticipantList"
{
    ApplicationArea = All;
    Caption = 'Seminar Reg. Participant List', Comment = 'ITA="Lista Alunni Fattura Corso"';
    DefaultRenderingLayout = SeminarRDLC;
    UsageCategory = ReportsAndAnalysis;
    PreviewMode = PrintLayout;

    dataset
    {


        dataitem(Header; "UF Seminar Registration Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Seminar No.";
            CalcFields = "Instructor Name";

            column(No_; Header."No.")
            {
                IncludeCaption = true;
            }
            column(Seminar_No_; Header."Seminar No.")
            {
                IncludeCaption = true;
            }
            column(Seminar_Name; Header."Seminar Name")
            {
                IncludeCaption = true;
            }
            column(Starting_Date; Header."Starting Date")
            {
                IncludeCaption = true;
            }
            column("Duration"; Header.Duration)
            {
                IncludeCaption = true;
            }
            column(Instructor_Name; Header."Instructor Name")
            {
                IncludeCaption = true;
            }
            column(Seminar_Room_Name; Header."Seminar Room Name")
            {
                IncludeCaption = true;
            }

            dataitem(Lines; "UF Seminar Registration Line")
            {
                DataItemTableView = sorting("Seminar Registration No.", "Line No.");
                DataItemLinkReference = Header;
                DataItemLink = "Seminar Registration No." = field("No.");
                column(Bill_to_Customer_No_; Lines."Bill-to Customer No.")
                {
                    IncludeCaption = true;
                }
                column(Participant_Contact_No_; Lines."Participant Contact No.")
                {
                    IncludeCaption = true;
                }
                column(Participant_Name; Lines."Participant Name")
                {
                    IncludeCaption = true;
                }


                dataitem("Integer"; "Integer")
                {
                    DataItemTableView = where(Number = const(1));
                    column(CompanyInformation_Name; CompanyInformation.Name)
                    {
                    }

                    dataitem("User ID"; User)
                    {
                        DataItemLinkReference = Header;
                        DataItemLink = "User Security ID" = field("SystemCreatedBy");

                        column(User_Name; "User Name")
                        {

                        }
                        trigger OnPreDataItem()
                        begin
                            CompanyInformation.Get();
                            user.Get(Header.SystemCreatedBy);
                        end;
                    }
                }
            }
        }
    }
    rendering
    {
        layout(SeminarRDLC)
        {
            Type = RDLC;
            LayoutFile = './src/Layout/Seminar.rdlc';
            Caption = 'Seminar_RDLC';
            Summary = 'Report for UF Seminar.';
        }
    }
    labels
    {
        LableName = 'Seminar Registration', comment = 'Registrazione corso';
    }
    var
        CompanyInformation: record "Company Information";
        user: record user;
}