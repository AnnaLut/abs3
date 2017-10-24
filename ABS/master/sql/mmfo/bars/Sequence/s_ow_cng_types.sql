

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_OW_CNG_TYPES.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_OW_CNG_TYPES ***

   CREATE SEQUENCE  BARS.S_OW_CNG_TYPES  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 41 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_OW_CNG_TYPES ***
grant SELECT                                                                 on S_OW_CNG_TYPES  to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_OW_CNG_TYPES.sql =========*** End
PROMPT ===================================================================================== 
