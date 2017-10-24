

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/View/V_KF_CONTRACTS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_KF_CONTRACTS ***

  CREATE OR REPLACE FORCE VIEW BARSAQ.V_KF_CONTRACTS ("KF", "PID", "IMPEXP", "RNK", "NAME", "DATEOPEN", "DATECLOSE", "S", "KV", "BENEFCOUNTRY", "BENEFNAME", "BENEFBANK", "BENEFACC", "AIM", "COND", "ID_OPER", "CONTINUED", "DETAILS", "DAT", "CLOSED", "OE", "BENEFADR", "BENEFBIC", "CONTROL_DAYS", "BANK_CODE", "BANKCOUNTRY", "BRANCH") AS 
  select
   t.kf,
   t.pid, t.impexp, t.rnk,
   t.name, t.dateopen, t.dateclose,
   t.s, t.kv, t.benefcountry,
   t.benefname, t.benefbank, t.benefacc,
   t.aim, t.cond, t.id_oper,
   t.continued, t.details, t.dat,
   t.closed, t.oe, t.benefadr,
   t.benefbic, t.control_days, t.bank_code,
   t.bankcountry, t.branch
from bars.top_contracts t;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/View/V_KF_CONTRACTS.sql =========*** End *
PROMPT ===================================================================================== 
