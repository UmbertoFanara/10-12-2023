codeunit 80100 "UF VerificaUrl"
{

    procedure VerificaUrl(Url: Text[90]);

    begin
        if StrPos(LowerCase(Url), 'https://') <> 1 then
            error('HomePage non valida');
    end;
}