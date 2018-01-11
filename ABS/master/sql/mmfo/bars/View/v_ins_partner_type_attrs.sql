

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_INS_PARTNER_TYPE_ATTRS.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  view V_INS_PARTNER_TYPE_ATTRS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_INS_PARTNER_TYPE_ATTRS ("ID", "PARTNER_ID", "PARTNER_NAME", "TYPE_ID", "TYPE_NAME", "ATTR_ID", "ATTR_NAME", "ATTR_TYPE_ID", "ATTR_TYPE_NAME", "IS_REQUIRED", "CUSTID") AS 
  select pta.id,
       pta.partner_id,
       p.name as partner_name,
       pt.type_id,
       t.name as type_name,
       pta.attr_id,
       a.name as attr_name,
       a.type_id as attr_type_id,
       ta.name as attr_type_name,
       pta.is_required,
       p.custtype as custid
  from ins_partner_type_attrs pta, ins_attrs a, ins_partners p, ins_attr_types ta, ins_types t, ins_partner_types pt
 where pt.partner_id = p.id
   and pt.type_id = t.id
   and (pt.partner_id = pta.partner_id or pta.partner_id is null)
   and (pt.type_id = pta.type_id or pta.type_id is null)
   and pta.attr_id = a.id
   and a.type_id = ta.id
   and pt.active = 1
 order by pta.attr_id;

PROMPT *** Create  grants  V_INS_PARTNER_TYPE_ATTRS ***
grant SELECT                                                                 on V_INS_PARTNER_TYPE_ATTRS to BARSREADER_ROLE;
grant SELECT                                                                 on V_INS_PARTNER_TYPE_ATTRS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_INS_PARTNER_TYPE_ATTRS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_INS_PARTNER_TYPE_ATTRS.sql =========*
PROMPT ===================================================================================== 
