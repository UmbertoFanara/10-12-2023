page 80111 "UF Seminar Setup"
{
    AdditionalSearchTerms = 'UF';
    ApplicationArea = All;
    Caption = 'Seminar Setup', comment = 'ITA="Setup Corsi"';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "UF Seminar Setup";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General', Comment = 'ITA="Generale"';
                field("Seminar Nos."; Rec."Seminar Nos.")
                {
                    Tooltip = 'Generates the Seminar Nos.', Comment = 'ITA="Imposta la generazione delle seriali per i corsi."';
                }
                field("Seminar Registration Nos."; Rec."Seminar Registration Nos.")
                {
                    Tooltip = 'Generates the Seminar Registration Nos.', Comment = 'ITA="Imposta la generazione delle seriali per i corsi da registrare."';
                }
                field("Posted Seminar Reg. Nos."; Rec."Posted Seminar Reg. Nos.")
                {
                    Tooltip = 'Generates the Seminar Reg. Nos.', Comment = 'ITA="Imposta la generazione delle seriali per i corsi registrati."';
                }
            }
        }
    }
    // Genera il record nella tabella se non lo trova
    trigger OnOpenPage()
    begin
        if not rec.get() then
            rec.insert();
    end;
}