enum 80101 "UF Status Seminar Reg. Header"
{
    Extensible = true;

    value(80000; Planning) { Caption = 'Planning', Comment = 'ITA="In Definizione"'; }
    value(80001; Registration) { Caption = 'Registration', Comment = 'ITA="Registrazione"'; }
    value(80002; Closed) { Caption = 'Closed', Comment = 'ITA="Chiuso"'; }
    value(80003; Canceled) { Caption = 'Canceled', Comment = 'ITA="Cancellato"'; }
}