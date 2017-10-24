

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_ZAPROS.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_ZAPROS ***

   CREATE SEQUENCE  BARS.S_ZAPROS  MINVALUE 0 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 5500854 CACHE 20 ORDER  NOCYCLE ;

PROMPT *** Create  grants  S_ZAPROS ***
grant SELECT                                                                 on S_ZAPROS        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_ZAPROS.sql =========*** End *** =
PROMPT ===================================================================================== 
