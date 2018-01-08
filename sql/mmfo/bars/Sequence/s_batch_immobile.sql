

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_BATCH_IMMOBILE.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_BATCH_IMMOBILE ***

   CREATE SEQUENCE  BARS.S_BATCH_IMMOBILE  MINVALUE 1 MAXVALUE 999999999999999 INCREMENT BY 1 START WITH 183 CACHE 20 ORDER  NOCYCLE ;

PROMPT *** Create  grants  S_BATCH_IMMOBILE ***
grant SELECT                                                                 on S_BATCH_IMMOBILE to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_BATCH_IMMOBILE.sql =========*** E
PROMPT ===================================================================================== 
