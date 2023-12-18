codeunit 80107 "UF SeminarDocumentPrint"
{
    TableNo = "UF SeminarReportSelections";
    trigger OnRun()
    begin

    end;

    var
        SemRepSel: record "UF SeminarReportSelections";

    procedure PrintSeminarRegistrationHeader(SeminarRegHeader: record "UF Seminar Registration Header")
    begin
        SeminarRegHeader.SetRecFilter(); // e non setrange perche deve impostare i valori della chiave primaria corrente sul valore di un campo CODE e non INT cosa che il setrange non ci permette di fare in questo caso
        SemRepSel.SetRange(Usage, SemRepSel.Usage::"S.Registration");
        SemRepSel.SetFilter("Report ID", '<>0'); // e non .setrange("Report ID", 1) perche deve poter trovare valori diversi da 0 anche negativi 
        SemRepSel.Ascending := false; // infatti deve cercare in entrambe le direzioni
        if SemRepSel.Find('-') then // non findset dato che non funziona con l'ascending perche va in una sola direzione
            repeat
                report.RunModal(SemRepSel."Report ID", true, false, SeminarRegHeader);
            until SemRepSel.Next() = 0;
    end;
}