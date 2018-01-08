

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_CP_REFW_UPDATE.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_CP_REFW_UPDATE ***

   CREATE SEQUENCE  BARS.S_CP_REFW_UPDATE  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 545 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_CP_REFW_UPDATE ***
grant SELECT                                                                 on S_CP_REFW_UPDATE to ABS_ADMIN;
grant SELECT                                                                 on S_CP_REFW_UPDATE to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_CP_REFW_UPDATE.sql =========*** E
PROMPT ===================================================================================== 
