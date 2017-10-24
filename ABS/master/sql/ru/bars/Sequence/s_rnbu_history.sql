

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_RNBU_HISTORY.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_RNBU_HISTORY ***

   CREATE SEQUENCE  BARS.S_RNBU_HISTORY  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_RNBU_HISTORY ***
grant SELECT                                                                 on S_RNBU_HISTORY  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on S_RNBU_HISTORY  to START1;
grant SELECT                                                                 on S_RNBU_HISTORY  to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_RNBU_HISTORY.sql =========*** End
PROMPT ===================================================================================== 
