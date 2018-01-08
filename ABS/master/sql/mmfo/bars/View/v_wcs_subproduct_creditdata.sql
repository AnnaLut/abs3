

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_SUBPRODUCT_CREDITDATA.sql =======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_SUBPRODUCT_CREDITDATA ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_SUBPRODUCT_CREDITDATA ("SUBPRODUCT_ID", "CRDDATA_ID", "CRDDATA_NAME", "TYPE_ID", "TYPE_NAME", "QUESTION_ID", "IS_VISIBLE", "IS_READONLY", "IS_CHECKABLE", "CHECK_PROC") AS 
  select t.subproduct_id,
       t.crddata_id,
       t.crddata_name,
       t.type_id,
       t.type_name,
       scd.question_id,
       scd.is_visible,
       scd.is_readonly,
       scd.is_checkable,
       scd.check_proc
  from (select s.id       as subproduct_id,
               cb.id      as crddata_id,
               cb.name    as crddata_name,
               cb.type_id,
               qt.name    as type_name,
               cb.ord
          from wcs_subproducts     s,
               wcs_creditdata_base cb,
               wcs_question_types  qt
         where cb.type_id = qt.id) t,
       wcs_subproduct_creditdata scd
 where t.subproduct_id = scd.subproduct_id(+)
   and t.crddata_id = scd.crddata_id(+)
 order by t.ord;

PROMPT *** Create  grants  V_WCS_SUBPRODUCT_CREDITDATA ***
grant SELECT                                                                 on V_WCS_SUBPRODUCT_CREDITDATA to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_SUBPRODUCT_CREDITDATA.sql =======
PROMPT ===================================================================================== 
