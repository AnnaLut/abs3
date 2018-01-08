

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DEPRICATED_PARAMS.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DEPRICATED_PARAMS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DEPRICATED_PARAMS ("PAR", "VAL", "COMM") AS 
  select substr(par,1,100) par,
       substr(val,1,250) val,
       substr(comm,1,250) comm
  from v_depricated_params$global
union all
select substr(par,1,100) par,
       substr(val,1,250) val,
       substr(comm,1,250) comm
  from v_depricated_params$base
 where kf = sys_context ('bars_context', 'user_mfo')
   and par not in ('BANKDATE', 'RRPDAY')
;

PROMPT *** Create  grants  V_DEPRICATED_PARAMS ***
grant FLASHBACK,REFERENCES,SELECT                                            on V_DEPRICATED_PARAMS to BARSAQ with grant option;
grant SELECT                                                                 on V_DEPRICATED_PARAMS to BARSUPL;
grant SELECT                                                                 on V_DEPRICATED_PARAMS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DEPRICATED_PARAMS to START1;
grant SELECT                                                                 on V_DEPRICATED_PARAMS to SWTOSS;
grant SELECT                                                                 on V_DEPRICATED_PARAMS to TOSS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DEPRICATED_PARAMS.sql =========*** En
PROMPT ===================================================================================== 
