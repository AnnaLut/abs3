

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_DPT_AGREEMENTS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_DPT_AGREEMENTS ***

   CREATE SEQUENCE  BARS.S_DPT_AGREEMENTS  MINVALUE 0 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 3028183 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_DPT_AGREEMENTS ***
grant SELECT                                                                 on S_DPT_AGREEMENTS to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_DPT_AGREEMENTS.sql =========*** E
PROMPT ===================================================================================== 
