

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_STMT.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_STMT ***

   CREATE SEQUENCE  BARS.S_STMT  MINVALUE 0 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1128043330 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_STMT ***
grant SELECT                                                                 on S_STMT          to ABS_ADMIN;
grant SELECT                                                                 on S_STMT          to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_STMT.sql =========*** End *** ===
PROMPT ===================================================================================== 
