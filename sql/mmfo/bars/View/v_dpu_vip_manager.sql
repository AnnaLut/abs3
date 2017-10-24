

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPU_VIP_MANAGER.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPU_VIP_MANAGER ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPU_VIP_MANAGER ("ID", "FIO", "BRANCH") AS 
  ( select id, fio, branch
    from staff$base
   where id in ( select regexp_substr(val,'[^,]+', 1, level) userid
                   from (select val from params$base where par = 'DPU_VIP_MANAGER')
                connect by level<=length(val)-length(replace(val,','))+1
               )
);

PROMPT *** Create  grants  V_DPU_VIP_MANAGER ***
grant DELETE,INSERT,SELECT,UPDATE                                            on V_DPU_VIP_MANAGER to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_DPU_VIP_MANAGER to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_DPU_VIP_MANAGER to DPT_ADMIN;
grant SELECT                                                                 on V_DPU_VIP_MANAGER to START1;
grant FLASHBACK,SELECT                                                       on V_DPU_VIP_MANAGER to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPU_VIP_MANAGER.sql =========*** End 
PROMPT ===================================================================================== 
