

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_REZ_OTCN.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_REZ_OTCN ***

   CREATE SEQUENCE  BARS.S_REZ_OTCN  MINVALUE 0 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 662 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_REZ_OTCN ***
grant SELECT                                                                 on S_REZ_OTCN      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on S_REZ_OTCN      to RCC_DEAL;
grant SELECT                                                                 on S_REZ_OTCN      to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_REZ_OTCN.sql =========*** End ***
PROMPT ===================================================================================== 
