
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/view/v_dict_dmsu_depts.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FORCE VIEW BARS.V_DICT_DMSU_DEPTS ("ID", "CODE", "NAME", "IS_ACTIVE", "VALID_FROM", "VALID_TO", "LAST_DT", "LAST_USER") AS 
  select "ID","CODE","NAME","IS_ACTIVE","VALID_FROM","VALID_TO","LAST_DT","LAST_USER" from DICT_DMSU_DEPTS t
where is_active = 1
;
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/view/v_dict_dmsu_depts.sql =========*** End 
 PROMPT ===================================================================================== 
 