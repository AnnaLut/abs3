

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CUSTOMERW_IDDPL.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CUSTOMERW_IDDPL ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CUSTOMERW_IDDPL ("RNK", "IDDPL") AS 
  SELECT rnk, SUBSTR (VALUE, 4, 2) || '.' || SUBSTR (VALUE, 7, 4)  IDDPL
     FROM customerw
    WHERE tag = 'IDDPL'
    AND (value like '__/__/____' or value like '__.__.____' or value like '__,__,____');

PROMPT *** Create  grants  V_CUSTOMERW_IDDPL ***
grant SELECT                                                                 on V_CUSTOMERW_IDDPL to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CUSTOMERW_IDDPL to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CUSTOMERW_IDDPL.sql =========*** End 
PROMPT ===================================================================================== 
