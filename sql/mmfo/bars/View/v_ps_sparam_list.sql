

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_PS_SPARAM_LIST.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_PS_SPARAM_LIST ***

  CREATE OR REPLACE FORCE VIEW BARS.V_PS_SPARAM_LIST ("NBS", "SPID", "NAME", "SEMANTIC", "OPT", "SQLVAL") AS 
  SELECT a.nbs,
            a.spid,
            b.name,
            b.semantic,
            a.opt,
            a.sqlval
       FROM PS_SPARAM a, sparam_list b
      WHERE A.SPID = B.SPID
   ORDER BY a.nbs, b.spid;

PROMPT *** Create  grants  V_PS_SPARAM_LIST ***
grant SELECT                                                                 on V_PS_SPARAM_LIST to BARSREADER_ROLE;
grant SELECT                                                                 on V_PS_SPARAM_LIST to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_PS_SPARAM_LIST to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_PS_SPARAM_LIST.sql =========*** End *
PROMPT ===================================================================================== 
