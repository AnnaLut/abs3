

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FIL_87.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FIL_87 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FIL_87 ("INIT_DATE", "LAST_DATE", "FILE_ID", "MFO", "RECORD_ID", "P080", "R020_FA", "OB22", "S", "PAP", "KOD") AS 
  select f.init_date,
         f.last_date,
         f.file_id,
         f.mfo mfo,
         i.record_id,
        substr(i.parameter,2,4) p080,
        substr(i.parameter,6,4) r020_fa,
        substr(i.parameter,10,2) ob22,
        i.value s,
        substr(i.parameter,1,1)  pap,
        i.parameter kod
   from RNBU_IN_FILES f, RNBU_IN_INF_RECORDS i, v_branch v
  where f.mfo=v.MFO
   and  f.file_name like ('_87%')
   and substr(i.parameter,1,1)in ('1','2')
   and f.file_id=i.file_id;

PROMPT *** Create  grants  V_FIL_87 ***
grant SELECT                                                                 on V_FIL_87        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_FIL_87        to NALOG;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FIL_87.sql =========*** End *** =====
PROMPT ===================================================================================== 
