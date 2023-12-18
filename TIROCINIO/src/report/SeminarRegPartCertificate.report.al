report 80101 "UF SeminarRegPartCertificate"
{
    Caption = 'Participant Certificate', Comment = 'ITA="Attestato Alunno"';
    DefaultRenderingLayout = CertificateWord;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;



    dataset
    {
        dataitem(Header; "UF Seminar Registration Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Starting Date", "Seminar No.";
            CalcFields = "Instructor Name";
            PrintOnlyIfDetail = true;

            column(Seminar_Name; Header."Seminar Name")
            {
                IncludeCaption = true;
            }

            column(Instructor_Name; Header."Instructor Name")
            {
                IncludeCaption = true;
            }
            dataitem(Lines; "UF Seminar Registration Line")
            {
                DataItemTableView = sorting("Seminar Registration No.", "Line No.");
                DataItemLinkReference = Header;
                DataItemLink = "Seminar Registration No." = field("No.");
                column(Picture; CompanyInformation.Picture)
                {

                }
                column(Participant_Name; Lines."Participant Name")
                {
                    IncludeCaption = true;
                }

                trigger OnAfterGetRecord()
                begin
                    if lines."Participant Name" = '' then
                        CurrReport.Skip();
                end;
            }


            trigger OnPreDataItem()
            begin
                CompanyInformation.Get();
                CompanyInformation.CalcFields(Picture);
            end;
        }
    }

    rendering
    {
        layout(CertificateWord)
        {
            Type = Word;
            LayoutFile = './src/Layout/Certificate.docx';
            Caption = 'Certificate_Word';
            Summary = 'Participant Word Certificate.';
        }
        layout(CertificateRDLC)
        {
            Type = RDLC;
            LayoutFile = './src/Layout/Certificate.rdlc';
            Caption = 'Certificate_RDLC';
            Summary = 'Participant RDLC Certificate';
        }
    }
    labels
    {
        LableName = 'Seminar Registration', comment = 'ITA="Registrazione corso"';
        LabelTitle = 'Participant Certificate', comment = 'ITA="Attestato Alunno"';
        LabelPhrase = 'has participated in seminar', comment = 'ITA="ha frequentato il corso"';

    }
    var
        CompanyInformation: Record "Company Information";

}