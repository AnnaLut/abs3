

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_CC_DOCS_ADDS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_CC_DOCS_ADDS ***

   CREATE SEQUENCE  BARS.S_CC_DOCS_ADDS  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_CC_DOCS_ADDS ***
grant SELECT                                                                 on S_CC_DOCS_ADDS  to ABS_ADMIN;
grant SELECT                                                                 on S_CC_DOCS_ADDS  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on S_CC_DOCS_ADDS  to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_CC_DOCS_ADDS.sql =========*** End
PROMPT ===================================================================================== 
