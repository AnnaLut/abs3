

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPT_AGREEMENTS_CHANGE_AMOUNT.sql ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPT_AGREEMENTS_CHANGE_AMOUNT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPT_AGREEMENTS_CHANGE_AMOUNT ("DPT_ID", "DPT_NUM", "DPT_CUR", "CURRENT_AMOUNT", "CURRENT_AMOUNT_CASH", "CURRENT_AMOUNT_CASHLESS", "PRIMARY_AMOUNT_CASH", "PRIMARY_AMOUNT_CASHLESS", "AGRMNTS_AMOUNT_CASH", "AGRMNTS_AMOUNT_CASHLESS", "PENYA_AMOUNT") AS 
  select dpt_id, dpt_num, dpt_cur, dpt_saldo,
       greatest (0, saldo_cash - penya_amount),
       saldo_cashless - decode(greatest (0, saldo_cash - penya_amount), 0, penya_amount, 0),
       primary_amount_cash,
       primary_amount_cashless,
       amount_cash,
       amount_cashless,
       penya_amount
  from (select dpt_id, dpt_num, dpt_cur, dpt_saldo,
               least (dpt_saldo, greatest (0, primary_amount_cash     + amount_cash))     saldo_cash,
               least (dpt_saldo, greatest (0, primary_amount_cashless + amount_cashless)) saldo_cashless,
               primary_amount_cash,
               primary_amount_cashless,
               amount_cash,
               amount_cashless,
               penya_amount
         from (select dpt.dpt_id, dpt.dpt_num, dpt.dpt_cur, dpt.dpt_saldo,
                      decode (nvl (ncash.cashtype, '0'), '0', dpt.dpt_amount, 0) primary_amount_cash,
                      decode (nvl (ncash.cashtype, '0'), '1', dpt.dpt_amount, 0) primary_amount_cashless,
                      agr.amount_cash, agr.amount_cashless,
                      nvl (penya.amount, 0) penya_amount
                from (select d.deposit_id dpt_id, d.nd dpt_num, a.kv dpt_cur,
                             d.limit dpt_amount, a.ostb dpt_saldo
                        from dpt_deposit d, accounts a
                       where d.acc = a.acc) dpt,
                     (select dpt_id, substr (value, 1, 1) cashtype
                        from dpt_depositw
                       where tag = 'NCASH') ncash,
                     (select dpt_id,
                             sum (nvl (amount_cash, 0)) amount_cash,
                             sum (nvl (amount_cashless, 0)) amount_cashless
                        from dpt_agreements
                       where agrmnt_type = 2
                         and agrmnt_state >= 0
                       group by dpt_id) agr,
                     (select p.dpt_id, sum (o.s) amount
                        from dpt_deposit d, dpt_payments p, opldok o, op_rules r
                       where d.deposit_id = p.dpt_id
                         and p.ref = o.ref
                         and d.acc = o.acc
                         and o.dk = 0
                         and o.sos > 0
                         and o.tt = r.tt
                         and r.tag = 'DPTOP'
                         and r.val = '81'
                       group by p.dpt_id) penya
                where dpt.dpt_id = agr.dpt_id
                  and dpt.dpt_id = ncash.dpt_id(+)
                  and dpt.dpt_id = penya.dpt_id(+)  ) )
 ;

PROMPT *** Create  grants  V_DPT_AGREEMENTS_CHANGE_AMOUNT ***
grant SELECT                                                                 on V_DPT_AGREEMENTS_CHANGE_AMOUNT to BARSREADER_ROLE;
grant SELECT                                                                 on V_DPT_AGREEMENTS_CHANGE_AMOUNT to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DPT_AGREEMENTS_CHANGE_AMOUNT to DPT_ROLE;
grant SELECT                                                                 on V_DPT_AGREEMENTS_CHANGE_AMOUNT to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_DPT_AGREEMENTS_CHANGE_AMOUNT to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPT_AGREEMENTS_CHANGE_AMOUNT.sql ====
PROMPT ===================================================================================== 
