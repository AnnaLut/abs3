

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_INS_PARTNER_BRANCH_RNK.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  view V_INS_PARTNER_BRANCH_RNK ***

  CREATE OR REPLACE FORCE VIEW BARS.V_INS_PARTNER_BRANCH_RNK ("PARTNER_ID", "BRANCH", "BRANCH_NAME", "RNK", "NAME_FULL", "NAME_SHORT", "INN", "TEL", "MFO", "NLS", "ADR") AS 
  select pbr.partner_id,
       pbr.branch,
       b.name         as branch_name,
       pbr.rnk,
       c.nmk          as name_full,
       c.nmkk         as name_short,
       c.okpo         as inn,
       cp.tel_fax     as tel,
       cp.mainmfo     as mfo,
       cp.mainnls     as nls,
       c.adr          as adr
  from ins_partner_branch_rnk pbr, branch b, customer c, corps cp
 where pbr.branch = b.branch
   and pbr.rnk = c.rnk
   and pbr.rnk = cp.rnk(+)
 order by pbr.partner_id, pbr.branch;

PROMPT *** Create  grants  V_INS_PARTNER_BRANCH_RNK ***
grant SELECT                                                                 on V_INS_PARTNER_BRANCH_RNK to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_INS_PARTNER_BRANCH_RNK.sql =========*
PROMPT ===================================================================================== 
