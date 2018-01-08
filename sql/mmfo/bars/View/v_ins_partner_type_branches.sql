

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_INS_PARTNER_TYPE_BRANCHES.sql =======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_INS_PARTNER_TYPE_BRANCHES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_INS_PARTNER_TYPE_BRANCHES ("ID", "BRANCH", "BRANCH_NAME", "PARTNER_ID", "PARTNER_NAME", "TYPE_ID", "TYPE_NAME", "TARIFF_ID", "TARIFF_NAME", "FEE_ID", "FEE_NAME", "LIMIT_ID", "LIMIT_NAME", "APPLY_HIER", "CUSTID") AS 
  select ptb.id,
       ptb.branch,
       b.name         as branch_name,
       ptb.partner_id,
       p.name         as partner_name,
       ptb.type_id,
       t.name         as type_name,
       ptb.tariff_id,
       tf.name         as tariff_name,
       ptb.fee_id,
       f.name         as fee_name,
       ptb.limit_id,
       l.name         as limit_name,
       ptb.apply_hier,
       p.custtype     as custid
  from ins_partner_type_branches ptb,
       branch                    b,
       ins_partners              p,
       ins_types                 t,
       ins_tariffs               tf,
       ins_fees                  f,
       ins_limits                l
 where ptb.branch = b.branch(+)
   and ptb.partner_id = p.id(+)
   and ptb.type_id = t.id(+)
   and ptb.tariff_id = tf.id(+)
   and ptb.fee_id = f.id(+)
   and ptb.limit_id = l.id(+)
 order by ptb.branch, ptb.partner_id, ptb.type_id;

PROMPT *** Create  grants  V_INS_PARTNER_TYPE_BRANCHES ***
grant SELECT                                                                 on V_INS_PARTNER_TYPE_BRANCHES to BARSREADER_ROLE;
grant SELECT                                                                 on V_INS_PARTNER_TYPE_BRANCHES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_INS_PARTNER_TYPE_BRANCHES to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_INS_PARTNER_TYPE_BRANCHES.sql =======
PROMPT ===================================================================================== 
