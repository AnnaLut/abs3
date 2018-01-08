

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_OPER.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_OPER ***

   CREATE SEQUENCE  BARS.S_OPER  MINVALUE 0 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1228672643 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_OPER ***
grant SELECT                                                                 on S_OPER          to ABS_ADMIN;
grant SELECT                                                                 on S_OPER          to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_OPER.sql =========*** End *** ===
PROMPT ===================================================================================== 
