

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_TARIF.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_TARIF ***

   CREATE SEQUENCE  BARS.S_TARIF  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 ORDER  NOCYCLE ;

PROMPT *** Create  grants  S_TARIF ***
grant SELECT                                                                 on S_TARIF         to ABS_ADMIN;
grant SELECT                                                                 on S_TARIF         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on S_TARIF         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_TARIF.sql =========*** End *** ==
PROMPT ===================================================================================== 
