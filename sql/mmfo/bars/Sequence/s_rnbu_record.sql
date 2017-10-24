

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_RNBU_RECORD.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_RNBU_RECORD ***

   CREATE SEQUENCE  BARS.S_RNBU_RECORD  MINVALUE 1 MAXVALUE 999999999999999 INCREMENT BY 1 START WITH 1069000124 CACHE 1000 NOORDER  CYCLE ;

PROMPT *** Create  grants  S_RNBU_RECORD ***
grant SELECT                                                                 on S_RNBU_RECORD   to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_RNBU_RECORD.sql =========*** End 
PROMPT ===================================================================================== 
