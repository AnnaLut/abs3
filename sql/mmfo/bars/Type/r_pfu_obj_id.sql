
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/r_pfu_obj_id.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.R_PFU_OBJ_ID as object (
  obj_id number(38),
  res    integer
)
/

 show err;
 
PROMPT *** Create  grants  R_PFU_OBJ_ID ***
grant EXECUTE                                                                on R_PFU_OBJ_ID    to PFU;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/r_pfu_obj_id.sql =========*** End *** =
 PROMPT ===================================================================================== 
 