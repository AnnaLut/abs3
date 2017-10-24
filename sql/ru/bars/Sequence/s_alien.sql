

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_ALIEN.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_ALIEN ***

   CREATE SEQUENCE  BARS.S_ALIEN  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 206783 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_ALIEN ***
grant SELECT                                                                 on S_ALIEN         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_ALIEN.sql =========*** End *** ==
PROMPT ===================================================================================== 
