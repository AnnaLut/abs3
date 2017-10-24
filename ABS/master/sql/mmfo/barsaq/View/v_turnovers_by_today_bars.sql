

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/View/V_TURNOVERS_BY_TODAY_BARS.sql =======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_TURNOVERS_BY_TODAY_BARS ***

  CREATE OR REPLACE FORCE VIEW BARSAQ.V_TURNOVERS_BY_TODAY_BARS ("BANK_ID", "ACC_NUM", "CUR_ID", "TURNS_DATE", "PREV_TURNS_DATE", "BALANCE", "DEBIT_TURNS", "CREDIT_TURNS") AS 
  select a.kf bank_id, a.nls acc_num, a.kv cur_id, s.fdat turns_date, s.pdat prev_turns_date, 
           s.ostf/t.denom balance, s.dos/t.denom debit_turns, s.kos/t.denom credit_turns
      from ibank_acc c,
           bars.accounts a, 
           bars.saldoa s, 
           bars.tabval t
     where c.acc  = s.acc
       and a.acc=c.acc 
       and a.kv  = t.kv                       
       and s.fdat   >= trunc(sysdate-1);



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/View/V_TURNOVERS_BY_TODAY_BARS.sql =======
PROMPT ===================================================================================== 
