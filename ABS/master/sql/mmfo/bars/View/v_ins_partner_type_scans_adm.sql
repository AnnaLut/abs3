

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_INS_PARTNER_TYPE_SCANS_ADM.sql ======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_INS_PARTNER_TYPE_SCANS_ADM ***

  CREATE OR REPLACE FORCE VIEW BARS.V_INS_PARTNER_TYPE_SCANS_ADM ("ID", "PARTNER_ID", "PARTNER_NAME", "TYPE_ID", "TYPE_NAME", "SCAN_ID", "SCAN_NAME", "IS_REQUIRED", "CUSTID") AS 
  select pts.id,
       pts.partner_id,
       p.name as partner_name,
       pts.type_id,
       t.name as type_name,
       pts.scan_id,
       s.name as scan_name,
       pts.is_required,
       p.custtype as custid
  from ins_partner_type_scans pts,
       ins_partners           p,
       ins_types              t,
       ins_scans              s
 where pts.partner_id = p.id(+)
   and pts.type_id = t.id(+)
   and pts.scan_id = s.id
 order by pts.partner_id, pts.type_id;

PROMPT *** Create  grants  V_INS_PARTNER_TYPE_SCANS_ADM ***
grant SELECT                                                                 on V_INS_PARTNER_TYPE_SCANS_ADM to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_INS_PARTNER_TYPE_SCANS_ADM.sql ======
PROMPT ===================================================================================== 
