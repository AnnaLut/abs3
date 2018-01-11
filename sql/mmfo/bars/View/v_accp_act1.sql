

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ACCP_ACT1.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ACCP_ACT1 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ACCP_ACT1 ("NAME", "NDOG", "DDOG", "OKPO", "SCOPE_DOG", "ORDER_FEE", "AMOUNT_FEE", "FEE_MFO", "FEE_NLS", "FEE_OKPO", "SUM_PAYS", "SUM_FEE", "CNT_PAYS", "PERIOD_START", "PERIOD_END", "AFEE", "SF_1", "SF_2", "SF_3") AS 
  select ao.name,
          ao.ndog,
          ao.ddog,
          ao.okpo,
          ao.scope_dog,
          ao.order_fee,
          ao.amount_fee,
          ao.fee_mfo,
          ao.fee_nls,
          ao.fee_okpo,
          s as sum_pays,
          case
           when ao.order_fee=2 then sf_2
           when ao.order_fee=3 then sf_3
           else sf_1
          end as sum_fee,
          cnt_pays,
          period_start,
          period_end,
          afee,
          sf_1,
          sf_2,
          sf_3
    from
     (
      select okpo,
            sum(s)     s,        -- сума платеж≥в
            sum(sf_1)  sf_1,     -- сума ком≥с≥й по кожному платежу
            sum(sf_2)  sf_2,     -- сума ком≥с≥й по платежах за день
            sum(sf_3)  sf_3,     -- ком≥с≥€ за м≥с€ць
            avg(afee)  afee,     -- ком≥с≥€
            sum(cnt_pays) cnt_pays,  -- к≥льк≥сть платеж≥в
            max(period_start) period_start,
            max(period_end)   period_end
       from v_accp_docs_grp
      group by okpo) op
     ,accp_orgs ao
    WHERE ao.okpo = op.okpo;

PROMPT *** Create  grants  V_ACCP_ACT1 ***
grant SELECT                                                                 on V_ACCP_ACT1     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ACCP_ACT1.sql =========*** End *** ==
PROMPT ===================================================================================== 
