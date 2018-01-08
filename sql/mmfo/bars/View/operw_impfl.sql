

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/OPERW_IMPFL.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view OPERW_IMPFL ***

  CREATE OR REPLACE FORCE VIEW BARS.OPERW_IMPFL ("REF", "VALUE") AS 
  SELECT REF,VALUE  FROM operw  WHERE tag='IMPFL'
 ;

PROMPT *** Create  grants  OPERW_IMPFL ***
grant SELECT                                                                 on OPERW_IMPFL     to BARSREADER_ROLE;
grant SELECT                                                                 on OPERW_IMPFL     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OPERW_IMPFL     to START1;
grant SELECT                                                                 on OPERW_IMPFL     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/OPERW_IMPFL.sql =========*** End *** ==
PROMPT ===================================================================================== 
