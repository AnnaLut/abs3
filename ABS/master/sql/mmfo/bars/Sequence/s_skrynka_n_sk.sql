

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_SKRYNKA_N_SK.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_SKRYNKA_N_SK ***

   CREATE SEQUENCE  BARS.S_SKRYNKA_N_SK  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 43 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_SKRYNKA_N_SK ***
grant SELECT                                                                 on S_SKRYNKA_N_SK  to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_SKRYNKA_N_SK.sql =========*** End
PROMPT ===================================================================================== 
