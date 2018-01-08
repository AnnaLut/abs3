

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_SPECPARAM_UPDATE.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_SPECPARAM_UPDATE ***

   CREATE SEQUENCE  BARS.S_SPECPARAM_UPDATE  MINVALUE 0 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 9844074 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_SPECPARAM_UPDATE ***
grant SELECT                                                                 on S_SPECPARAM_UPDATE to ABS_ADMIN;
grant SELECT                                                                 on S_SPECPARAM_UPDATE to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_SPECPARAM_UPDATE.sql =========***
PROMPT ===================================================================================== 
