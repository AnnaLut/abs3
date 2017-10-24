

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/FINMON/View/LAST_REQUEST.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view LAST_REQUEST ***

  CREATE OR REPLACE FORCE VIEW FINMON.LAST_REQUEST ("ID", "KL_ID", "KL_DATE", "IN_DATE", "IN_N", "FILE_I_ID", "TEXT", "ANSW", "FILE_O_ID", "OUT_N", "RESP_DOD", "DFILE_ID", "STATUS") AS 
  SELECT   "ID",
            "KL_ID",
            "KL_DATE",
            "IN_DATE",
            "IN_N",
            "FILE_I_ID",
            "TEXT",
            "ANSW",
            "FILE_O_ID",
            "OUT_N",
            "RESP_DOD",
            "DFILE_ID",
            "STATUS"
     FROM   REQUEST QQ
    WHERE   QQ.IN_DATE = (SELECT   MAX (IN_DATE)
                            FROM   REQUEST
                           WHERE   KL_ID = QQ.KL_ID AND KL_DATE = QQ.KL_DATE);



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/FINMON/View/LAST_REQUEST.sql =========*** End ***
PROMPT ===================================================================================== 
