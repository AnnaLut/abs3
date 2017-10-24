

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_INS_ATTRS.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_INS_ATTRS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_INS_ATTRS ("ATTR_ID", "NAME", "TYPE_ID", "TYPE_NAME") AS 
  SELECT att.id AS attr_id, att.name, att.type_id, a.name as type_name
       FROM ins_attrs att, ins_attr_types a
       WHERE att.type_id = a.id
   ORDER BY att.id;

PROMPT *** Create  grants  V_INS_ATTRS ***
grant SELECT                                                                 on V_INS_ATTRS     to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_INS_ATTRS.sql =========*** End *** ==
PROMPT ===================================================================================== 
