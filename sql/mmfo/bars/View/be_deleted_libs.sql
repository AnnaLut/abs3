

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/BE_DELETED_LIBS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view BE_DELETED_LIBS ***

  CREATE OR REPLACE FORCE VIEW BARS.BE_DELETED_LIBS ("PATH_NAME", "DESCR", "FILE_DATE", "FILE_SIZE", "VERSION", "LINKS", "CRITICAL", "STATUS", "INS_DATE", "INS_USER") AS 
  SELECT
  "PATH_NAME","DESCR","FILE_DATE","FILE_SIZE","VERSION","LINKS","CRITICAL","STATUS","INS_DATE","INS_USER"
FROM
  BE_LIBS_ARC A
WHERE
  A.PATH_NAME NOT IN (SELECT PATH_NAME FROM BE_LIBS) AND
  A.INS_DATE = (SELECT MIN(INS_DATE) FROM BE_LIBS_ARC WHERE PATH_NAME=A.PATH_NAME AND INS_DATE=A.INS_DATE)
 ;

PROMPT *** Create  grants  BE_DELETED_LIBS ***
grant SELECT                                                                 on BE_DELETED_LIBS to BARSREADER_ROLE;
grant SELECT                                                                 on BE_DELETED_LIBS to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BE_DELETED_LIBS to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/BE_DELETED_LIBS.sql =========*** End **
PROMPT ===================================================================================== 
