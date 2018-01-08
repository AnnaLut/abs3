

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_INS_PARTNER_TYPE_ATTRS_ADM.sql ======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_INS_PARTNER_TYPE_ATTRS_ADM ***

  CREATE OR REPLACE FORCE VIEW BARS.V_INS_PARTNER_TYPE_ATTRS_ADM ("ID", "PARTNER_ID", "PARTNER_NAME", "TYPE_ID", "TYPE_NAME", "ATTR_ID", "ATTR_NAME", "ATTR_TYPE_ID", "ATTR_TYPE_NAME", "IS_REQUIRED", "CUSTID") AS 
  select pta.id,
       pta.partner_id,
       p.name as partner_name,
       t.id as type_id,
       t.name as type_name,
       pta.attr_id,
       a.name as attr_name,
       a.type_id as attr_type_id,
       a.name as attr_type_name,
       pta.is_required,
       p.custtype as custid
  from ins_partner_type_attrs pta,
       ins_attrs a,
       ins_partners p,
       ins_types t
 where pta.partner_id = p.id(+)
   and pta.attr_id = a.id(+)
   and pta.type_id = t.id(+)
 order by pta.attr_id;

PROMPT *** Create  grants  V_INS_PARTNER_TYPE_ATTRS_ADM ***
grant SELECT                                                                 on V_INS_PARTNER_TYPE_ATTRS_ADM to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_INS_PARTNER_TYPE_ATTRS_ADM.sql ======
PROMPT ===================================================================================== 
