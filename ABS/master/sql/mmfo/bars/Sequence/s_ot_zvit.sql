

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_OT_ZVIT.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_OT_ZVIT ***

   CREATE SEQUENCE  BARS.S_OT_ZVIT  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 ORDER  CYCLE ;

PROMPT *** Create  grants  S_OT_ZVIT ***
grant SELECT                                                                 on S_OT_ZVIT       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_OT_ZVIT.sql =========*** End *** 
PROMPT ===================================================================================== 
