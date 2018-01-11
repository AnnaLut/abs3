

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/EBK_PACKAGE_NMBR.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  sequence EBK_PACKAGE_NMBR ***

   CREATE SEQUENCE  BARS.EBK_PACKAGE_NMBR  MINVALUE 1 MAXVALUE 9999999999 INCREMENT BY 1 START WITH 592377 CACHE 20 NOORDER  CYCLE ;

PROMPT *** Create  grants  EBK_PACKAGE_NMBR ***
grant SELECT                                                                 on EBK_PACKAGE_NMBR to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/EBK_PACKAGE_NMBR.sql =========*** E
PROMPT ===================================================================================== 
