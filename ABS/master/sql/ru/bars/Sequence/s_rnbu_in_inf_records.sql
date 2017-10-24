

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_RNBU_IN_INF_RECORDS.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_RNBU_IN_INF_RECORDS ***

   CREATE SEQUENCE  BARS.S_RNBU_IN_INF_RECORDS  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 101 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_RNBU_IN_INF_RECORDS ***
grant SELECT                                                                 on S_RNBU_IN_INF_RECORDS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on S_RNBU_IN_INF_RECORDS to RPBN002;
grant SELECT                                                                 on S_RNBU_IN_INF_RECORDS to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_RNBU_IN_INF_RECORDS.sql =========
PROMPT ===================================================================================== 
