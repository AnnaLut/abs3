

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/OBPC_TRAN_ALL.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view OBPC_TRAN_ALL ***

  CREATE OR REPLACE FORCE VIEW BARS.OBPC_TRAN_ALL ("ID", "CARD_ACCT", "CURRENCY", "CCY", "TRAN_DATE", "TRAN_TYPE", "CARD", "SLIP_NR", "BATCH_NR", "ABVR_NAME", "CITY", "MERCHANT", "TRAN_AMT", "AMOUNT", "TRAN_NAME", "TRAN_RUSS", "POST_DATE", "CARD_TYPE", "COUNTRY", "MCC_CODE", "TERMINAL", "REF", "IDN") AS 
  select id, card_acct, currency, ccy, tran_date, tran_type, card, slip_nr, batch_nr,
       abvr_name, city, merchant, tran_amt, amount, tran_name, tran_russ, post_date,
       card_type, country, mcc_code, terminal, null ref, idn
  from obpc_tran
union
select id, card_acct, currency, ccy, tran_date, tran_type, card, slip_nr, batch_nr,
       abvr_name, city, merchant, tran_amt, amount, tran_name, tran_russ, post_date,
       card_type, country, mcc_code, terminal, ref, idn
  from obpc_tran_hist
union
select id, card_acct, currency, ccy, tran_date, tran_type, card, slip_nr, batch_nr,
       abvr_name, city, merchant, tran_amt, amount, tran_name, tran_russ, post_date,
       card_type, country, mcc_code, terminal, null, idn
  from obpc_tran_arc;

PROMPT *** Create  grants  OBPC_TRAN_ALL ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OBPC_TRAN_ALL   to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on OBPC_TRAN_ALL   to OBPC;
grant SELECT                                                                 on OBPC_TRAN_ALL   to RPBN001;
grant FLASHBACK,SELECT                                                       on OBPC_TRAN_ALL   to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/OBPC_TRAN_ALL.sql =========*** End *** 
PROMPT ===================================================================================== 
