

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_FILE_HEADER.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_FILE_HEADER ***

   CREATE SEQUENCE  BARS.S_FILE_HEADER  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 242 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_FILE_HEADER ***
grant SELECT                                                                 on S_FILE_HEADER   to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_FILE_HEADER.sql =========*** End 
PROMPT ===================================================================================== 
