

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/BIRJA.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** Create  view BIRJA ***

  CREATE OR REPLACE FORCE VIEW BARS.BIRJA ("PAR", "COMM", "VAL", "KF") AS 
  SELECT par, comm, val, kf
     FROM birja_mfo
    WHERE kf = SYS_CONTEXT ('bars_context', 'user_mfo')
   UNION ALL
   SELECT par, comm, val, null kf FROM birja_param;

PROMPT *** Create  grants  BIRJA ***
grant FLASHBACK,REFERENCES,SELECT                                            on BIRJA           to BARSAQ with grant option;
grant SELECT                                                                 on BIRJA           to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on BIRJA           to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on BIRJA           to F_500;
grant SELECT                                                                 on BIRJA           to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/BIRJA.sql =========*** End *** ========
PROMPT ===================================================================================== 
