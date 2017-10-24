

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_ALT_BPK.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_ALT_BPK ***

   CREATE SEQUENCE  BARS.S_ALT_BPK  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 41 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_ALT_BPK ***
grant SELECT                                                                 on S_ALT_BPK       to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_ALT_BPK.sql =========*** End *** 
PROMPT ===================================================================================== 
