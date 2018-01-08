

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_INS_PARTNERS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_INS_PARTNERS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_INS_PARTNERS ("PARTNER_ID", "NAME", "RNK", "NAME_FULL", "NAME_SHORT", "INN", "TEL", "MFO", "NLS", "ADR", "AGR_NO", "AGR_SDATE", "AGR_EDATE", "TARIFF_ID", "TARIFF_NAME", "FEE_ID", "FEE_NAME", "LIMIT_ID", "LIMIT_NAME", "ACTIVE", "CUSTID", "CUSNAME") AS 
  select p.id as partner_id,
       p.name,
       p.rnk,
       c.nmk as name_full,
       c.nmkk as name_short,
       c.okpo as inn,
       cp.tel_fax as tel,
       cp.mainmfo as mfo,
       cp.mainnls as nls,
       c.adr as adr,
       p.agr_no,
       p.agr_sdate,
       p.agr_edate,
       p.tariff_id,
       t.name         as tariff_name,
       p.fee_id,
       f.name         as fee_name,
       p.limit_id,
       l.name         as limit_name,
       active,
       ct.custtype    as custid,
       ct.name        as cusname
  from ins_partners p, customer c, corps cp, ins_tariffs t, ins_fees f, ins_limits l, custtype ct
 where p.rnk = c.rnk(+)
   and p.rnk = cp.rnk(+)
   and p.tariff_id = t.id(+)
   and p.fee_id = f.id(+)
   and p.limit_id = l.id(+)
   and p.custtype = ct.custtype(+)
 order by p.active desc, p.id;

PROMPT *** Create  grants  V_INS_PARTNERS ***
grant SELECT                                                                 on V_INS_PARTNERS  to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_INS_PARTNERS.sql =========*** End ***
PROMPT ===================================================================================== 
