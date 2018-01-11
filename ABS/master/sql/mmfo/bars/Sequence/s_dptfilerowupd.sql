

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_DPTFILEROWUPD.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_DPTFILEROWUPD ***

   CREATE SEQUENCE  BARS.S_DPTFILEROWUPD  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 50541 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_DPTFILEROWUPD ***
grant SELECT                                                                 on S_DPTFILEROWUPD to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_DPTFILEROWUPD.sql =========*** En
PROMPT ===================================================================================== 
