

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_ANI3.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_ANI3 ***

   CREATE SEQUENCE  BARS.S_ANI3  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1000021 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_ANI3 ***
grant SELECT                                                                 on S_ANI3          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on S_ANI3          to SALGL;
grant SELECT                                                                 on S_ANI3          to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_ANI3.sql =========*** End *** ===
PROMPT ===================================================================================== 
