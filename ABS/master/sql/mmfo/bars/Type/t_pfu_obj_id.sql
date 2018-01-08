
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/t_pfu_obj_id.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.T_PFU_OBJ_ID as table of R_PFU_OBJ_ID
/

 show err;
 
PROMPT *** Create  grants  T_PFU_OBJ_ID ***
grant EXECUTE                                                                on T_PFU_OBJ_ID    to PFU;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/t_pfu_obj_id.sql =========*** End *** =
 PROMPT ===================================================================================== 
 