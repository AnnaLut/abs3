

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSUPL/View/V_UPL_AUTOJOB_PARAM_VALUES.sql =====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_UPL_AUTOJOB_PARAM_VALUES ***

  CREATE OR REPLACE FORCE VIEW BARSUPL.V_UPL_AUTOJOB_PARAM_VALUES ("JOB_NAME", "IS_ACTIVE", "PARAM", "VALUE", "DESCRIPT", "ISDEFAULT", "DEFAULT_VAL", "ACTUAL_VAL", "KF") AS 
  select a.job_name,
          is_active,
          a.param,
          case when v.param is null then a.value else v.value end value,
          descript,
          case when v.param is null then 1 else 0 end isdefault,
          a.value default_val,
          v.param actual_val,
          case when v.kf is null then sys_context('bars_context','user_mfo') else v.kf end kf
     from (select j.is_active,
                  j.job_name,
                  p.param,
                  p.defval value,
                  p.descript
             from upl_autojob_params p, upl_autojobs j) a,
          upl_autojob_param_values v
    where v.param(+) = a.param and v.job_name(+) = a.job_name;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSUPL/View/V_UPL_AUTOJOB_PARAM_VALUES.sql =====
PROMPT ===================================================================================== 
