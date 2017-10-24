

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_KP_KOMIS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_KP_KOMIS ***

   CREATE SEQUENCE  BARS.S_KP_KOMIS  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 16 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_KP_KOMIS ***
grant SELECT                                                                 on S_KP_KOMIS      to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_KP_KOMIS.sql =========*** End ***
PROMPT ===================================================================================== 
