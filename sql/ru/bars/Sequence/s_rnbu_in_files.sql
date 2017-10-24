

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_RNBU_IN_FILES.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_RNBU_IN_FILES ***

   CREATE SEQUENCE  BARS.S_RNBU_IN_FILES  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 40656 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_RNBU_IN_FILES ***
grant SELECT                                                                 on S_RNBU_IN_FILES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on S_RNBU_IN_FILES to RPBN002;
grant SELECT                                                                 on S_RNBU_IN_FILES to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_RNBU_IN_FILES.sql =========*** En
PROMPT ===================================================================================== 
