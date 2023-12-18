page 80110 "UF Instructors"
{
    AdditionalSearchTerms = 'UF';
    ApplicationArea = All;
    Caption = 'Instructors', comment = 'ITA="Docenti"';
    DataCaptionFields = Code, Name;
    PageType = List;
    SourceTable = "UF Instructor";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                Caption = 'General', Comment = 'ITA="Generale"';
                field("Code"; rec.Code)
                {
                    Tooltip = 'Specifies the value of the Instructor Code.', Comment = 'ITA="Specifica il codice identificativo del docente."';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Instructor Name.', Comment = 'ITA="Specifica il nome del docente."';
                }
                field("Internal/External"; Rec."Internal/External")
                {
                    ToolTip = 'Select if the instructor is Internal or External.', Comment = 'ITA="Seleziona se il docente è interno o esterno."';
                }
                field("Resource No."; Rec."Resource No.")
                {
                    ToolTip = 'Specifies the value of the Resouce No. .', Comment = 'ITA="Specifica il numero identificativo della risorsa corrispondente al docente."';
                }
                field("Contact No."; Rec."Contact No.")
                {
                    ToolTip = 'Specifies the value of the Contact No. .', comment = 'ITA="Specifica il numero identificativo del contatto per il docente."';
                }
            }
        }
        area(FactBoxes)
        {
            systempart(Links; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = true;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = Notes;
                Visible = true;
            }
        }
    }
}