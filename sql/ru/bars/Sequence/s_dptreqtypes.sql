

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_DPTREQTYPES.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_DPTREQTYPES ***

   CREATE SEQUENCE  BARS.S_DPTREQTYPES  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 41 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_DPTREQTYPES ***
grant SELECT                                                                 on S_DPTREQTYPES   to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_DPTREQTYPES.sql =========*** End 
PROMPT ===================================================================================== 
