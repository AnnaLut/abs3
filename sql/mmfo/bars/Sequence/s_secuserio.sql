

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_SECUSERIO.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_SECUSERIO ***

   CREATE SEQUENCE  BARS.S_SECUSERIO  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 7377 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_SECUSERIO ***
grant SELECT                                                                 on S_SECUSERIO     to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_SECUSERIO.sql =========*** End **
PROMPT ===================================================================================== 
