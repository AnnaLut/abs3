

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPT_POLITICAL_INSTABILITY.sql =======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPT_POLITICAL_INSTABILITY ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPT_POLITICAL_INSTABILITY ("CRT_DATE", "CRT_BRANCH", "CRT_STAFF_ID", "FIO", "BIRTH_DATE", "INN", "DOC", "OLD_DPT_ID", "OLD_DAT_BEGIN", "OLD_DAT_END", "OLD_TERMINATION_DATE", "OLD_KV", "OLD_BALANCE", "OLD_PENALTY_SUM", "NEW_DPT_ID", "NEW_DAT_BEGIN", "NEW_DAT_END", "NEW_KV", "NEW_BALANCE") AS 
  select pi.crt_date,
       pi.crt_branch,
       pi.crt_staff_id,
       c.nmk as fio,
       p.bday as birth_date,
       c.okpo as inn,
       p.ser || p.numdoc as doc,
       dco.deposit_id as old_dpt_id,
       dco.dat_begin as old_dat_begin,
       dco.dat_end as old_dat_end,
       trunc(dco.when) as old_termination_date,
       dco.kv as old_kv,
       fost(dco.acc, trunc(dco.when) - 1) / 100 as old_balance,
       pi.penalty_sum as old_penalty_sum,
       dcn.deposit_id as new_dpt_id,
       dcn.dat_begin as new_dat_begin,
       dcn.dat_end as new_dat_end,
       dcn.kv as new_kv,
       dcn.limit / 100 as new_balance
  from dpt_political_instability pi,
       dpt_deposit_clos          dco,
       dpt_deposit_clos          dcn,
       customer                  c,
       person                    p
 where pi.crt_branch like sys_context('bars_context', 'user_branch_mask')
   and pi.old_dpt_id = dco.deposit_id
   and dco.action_id = 2
   and pi.new_dpt_id = dcn.deposit_id
   and dcn.action_id = 0
   and dco.rnk = c.rnk
   and c.rnk = p.rnk
 order by pi.crt_date desc;

PROMPT *** Create  grants  V_DPT_POLITICAL_INSTABILITY ***
grant SELECT                                                                 on V_DPT_POLITICAL_INSTABILITY to BARSREADER_ROLE;
grant SELECT                                                                 on V_DPT_POLITICAL_INSTABILITY to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DPT_POLITICAL_INSTABILITY to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPT_POLITICAL_INSTABILITY.sql =======
PROMPT ===================================================================================== 
