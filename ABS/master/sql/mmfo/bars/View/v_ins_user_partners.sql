

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_INS_USER_PARTNERS.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  view V_INS_USER_PARTNERS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_INS_USER_PARTNERS ("PARTNER_ID", "NAME", "RNK", "NAME_FULL", "NAME_SHORT", "INN", "TEL", "MFO", "NLS", "ADR", "AGR_NO", "AGR_SDATE", "AGR_EDATE", "TARIFF_ID", "TARIFF_NAME", "FEE_ID", "FEE_NAME", "LIMIT_ID", "LIMIT_NAME", "ACTIVE", "CUSTID") AS 
  select p."PARTNER_ID",p."NAME",p."RNK",p."NAME_FULL",p."NAME_SHORT",p."INN",p."TEL",p."MFO",p."NLS",p."ADR",p."AGR_NO",p."AGR_SDATE",p."AGR_EDATE",p."TARIFF_ID",p."TARIFF_NAME",p."FEE_ID",p."FEE_NAME",p."LIMIT_ID",p."LIMIT_NAME",p."ACTIVE",p."CUSTID"
  from v_ins_partners p
 where p.active = 1
   and exists
 (select 1
          from ins_partner_type_branches ptb
         where sys_context('bars_context', 'user_branch') like
               ptb.branch || decode(ptb.apply_hier, 1, '%', '')
           and (ptb.partner_id = p.partner_id or ptb.partner_id is null))
 order by p.partner_id;

PROMPT *** Create  grants  V_INS_USER_PARTNERS ***
grant SELECT                                                                 on V_INS_USER_PARTNERS to BARSREADER_ROLE;
grant SELECT                                                                 on V_INS_USER_PARTNERS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_INS_USER_PARTNERS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_INS_USER_PARTNERS.sql =========*** En
PROMPT ===================================================================================== 
