pageextension 80100 "UF SourceCodeSetupExt" extends 279
{
    layout
    {
        addafter("Job G/L WIP")
        {
            field("UF Seminar"; rec."UF Seminar")
            {
                Tooltip = 'Specifies the code linked to entries that are posted from Seminar.', Comment = 'ITA="Specifica il codice seriale associato alle voci contabili per i corsi."';
            }
        }
    }
}