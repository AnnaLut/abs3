

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NOSTRO_SALDO.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NOSTRO_SALDO ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NOSTRO_SALDO ("MFO", "KODN", "KV", "OST") AS 
  select banks.mfo, banks.kodn, accounts.kv, -accounts.ostc from accounts, bank_acc, banks
where banks.mfo = bank_acc.mfo
and bank_acc.acc = accounts.acc
and case
    when tip in ('N00','L00','L01','T00','T0D','TNB','TND','L99','N99','TUR','TUD','902','90D') then tip
    else null
    end = 'N00'
 ;

PROMPT *** Create  grants  V_NOSTRO_SALDO ***
grant SELECT                                                                 on V_NOSTRO_SALDO  to BARSREADER_ROLE;
grant SELECT                                                                 on V_NOSTRO_SALDO  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_NOSTRO_SALDO  to TOSS;
grant SELECT                                                                 on V_NOSTRO_SALDO  to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_NOSTRO_SALDO  to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NOSTRO_SALDO.sql =========*** End ***
PROMPT ===================================================================================== 
