

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_KKFORBK_DATA.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_KKFORBK_DATA ***

   CREATE SEQUENCE  BARS.S_KKFORBK_DATA  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_KKFORBK_DATA ***
grant SELECT                                                                 on S_KKFORBK_DATA  to CM_ACCESS_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_KKFORBK_DATA.sql =========*** End
PROMPT ===================================================================================== 
