

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_INS_PARTNER_TYPE_SCANS.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  view V_INS_PARTNER_TYPE_SCANS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_INS_PARTNER_TYPE_SCANS ("ID", "PARTNER_ID", "PARTNER_NAME", "TYPE_ID", "TYPE_NAME", "SCAN_ID", "SCAN_NAME", "IS_REQUIRED", "CUSTID") AS 
  select pts.id,
       pt.partner_id,
       p.name as partner_name,
       pt.type_id,
       t.name as type_name,
       pts.scan_id,
       s.name as scan_name,
       pts.is_required,
       p.custtype as custid
  from ins_partner_types      pt,
       ins_partners           p,
       ins_types              t,
       ins_partner_type_scans pts,
       ins_scans              s
 where pt.partner_id = p.id
   and pt.type_id = t.id
   and (pt.partner_id = pts.partner_id or pts.partner_id is null)
   and (pt.type_id = pts.type_id or pts.type_id is null)
   and pts.scan_id = s.id
   and pt.active = 1
 order by pts.scan_id;

PROMPT *** Create  grants  V_INS_PARTNER_TYPE_SCANS ***
grant SELECT                                                                 on V_INS_PARTNER_TYPE_SCANS to BARSREADER_ROLE;
grant SELECT                                                                 on V_INS_PARTNER_TYPE_SCANS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_INS_PARTNER_TYPE_SCANS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_INS_PARTNER_TYPE_SCANS.sql =========*
PROMPT ===================================================================================== 
