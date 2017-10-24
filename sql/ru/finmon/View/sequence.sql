

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/FINMON/View/SEQUENCE.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view SEQUENCE ***

  CREATE OR REPLACE FORCE VIEW FINMON.SEQUENCE ("FILEA_N", "FILEA_DATE", "FILEU_N", "FILEU_DATE", "FILED_N", "FILED_DATE", "FILEN_N", "FILEN_DATE", "FILEE_N", "FILEE_DATE", "FILE1_N", "FILE1_DATE", "FILE3_N", "FILE3_DATE", "FILE7_N", "FILE7_DATE", "FILE0_N", "FILE0_DATE", "FILEF_N", "FILEF_DATE", "FILEH_N", "FILEH_DATE", "FILEK_N", "FILEK_DATE", "FILEL_N", "FILEL_DATE", "ID_FILE_OUT", "ID_FILE_IN", "ID_BANK", "ID_OPER", "ID_USERS", "ID_REQUEST", "ID_PERSON", "ID_PERSON_BANK", "ID_DECISION", "KL_ID", "KL_ID_DATE", "BRANCH_ID", "IS_ACTIVE") AS 
  SELECT   nvl(a.FILEA_N, 0),
            nvl(a.FILEA_DATE, sysdate),
            nvl(a.FILEU_N, 0),
            nvl(a.FILEU_DATE, sysdate),
            nvl(a.FILED_N, 0),
            nvl(a.FILED_DATE, sysdate),
            nvl(a.FILEN_N, 0),
            nvl(a.FILEN_DATE, sysdate),
            nvl(a.FILEE_N, 0),
            nvl(a.FILEE_DATE, sysdate),
            nvl(a.FILE1_N, 0),
            nvl(a.FILE1_DATE, sysdate),
            nvl(a.FILE3_N, 0),
            nvl(a.FILE3_DATE, sysdate),
            nvl(a.FILE7_N, 0),
            nvl(a.FILE7_DATE, sysdate),
            nvl(a.FILE0_N, 0),
            nvl(a.FILE0_DATE, sysdate),
            nvl(a.FILEF_N, 0),
            nvl(a.FILEF_DATE, sysdate),
            nvl(a.FILEH_N, 0),
            nvl(a.FILEH_DATE, sysdate),
            nvl(a.FILEK_N, 0),
            nvl(a.FILEK_DATE, sysdate),
            nvl(a.FILEL_N, 0),
            nvl(a.FILEL_DATE, sysdate),
            CAST (s.ID_FILE_OUT AS number (38, 0)),
            CAST (s.ID_FILE_IN AS number (38, 0)),
            CAST (s.ID_BANK AS number (38, 0)),
            CAST (s.ID_OPER AS number (38, 0)),
            CAST (s.ID_USERS AS number (38, 0)),
            CAST (s.ID_REQUEST AS number (38, 0)),
            CAST (s.ID_PERSON AS number (38, 0)),
            CAST (s.ID_PERSON_BANK AS number (38, 0)),
            nvl(a.ID_DECISION, 0),
            CAST (s.KL_ID AS number (38, 0)),
            s.KL_ID_DATE,
            CAST (s.BRANCH_ID AS number (38, 0)),
            CAST (s.IS_ACTIVE AS number (38, 0))
     FROM   branch_sequence s,
            (  SELECT   p.branch_id,
                        CAST (MAX(DECODE(par, 'ID_DECISION', TO_NUMBER (val))) AS number (38, 0)) AS ID_DECISION,
                        CAST (MAX(DECODE(par, 'FILEA_N', TO_NUMBER (val))) AS number (38, 0)) AS FILEA_N,
                                  MAX(DECODE(par, 'FILEA_DATE', TO_DATE (val, 'yyyy-mm-dd'))) AS FILEA_DATE,
                        CAST (MAX(DECODE(par, 'FILEU_N', TO_NUMBER (val))) AS number (38, 0)) AS FILEU_N,
                                  MAX(DECODE(par, 'FILEU_DATE', TO_DATE (val, 'yyyy-mm-dd'))) AS FILEU_DATE,
                        CAST (MAX(DECODE(par, 'FILED_N', TO_NUMBER (val))) AS number (38, 0)) AS FILED_N,
                                  MAX(DECODE(par, 'FILED_DATE', TO_DATE (val, 'yyyy-mm-dd'))) AS FILED_DATE,
                        CAST (MAX(DECODE(par, 'FILEN_N', TO_NUMBER (val))) AS number (38, 0)) AS FILEN_N,
                                  MAX(DECODE (par, 'FILEN_DATE', TO_DATE (val, 'yyyy-mm-dd'))) AS FILEN_DATE,
                        CAST (MAX(DECODE (par, 'FILEE_N', TO_NUMBER (val))) AS number (38, 0)) AS FILEE_N,
                                  MAX(DECODE(par, 'FILEE_DATE', TO_DATE (val, 'yyyy-mm-dd'))) AS FILEE_DATE,
                        CAST (MAX(DECODE(par, 'FILE1_N', TO_NUMBER (val))) AS number (38, 0)) AS FILE1_N,
                                  MAX(DECODE(par,  'FILE1_DATE', TO_DATE (val, 'yyyy-mm-dd'))) AS FILE1_DATE,
                        CAST (MAX(DECODE(par, 'FILE3_N', TO_NUMBER (val))) AS number (38, 0)) AS FILE3_N,
                                  MAX(DECODE(par, 'FILE3_DATE', TO_DATE (val, 'yyyy-mm-dd'))) AS FILE3_DATE,
                        CAST (MAX(DECODE(par, 'FILE7_N', TO_NUMBER (val))) AS number (38, 0)) AS FILE7_N,
                                  MAX(DECODE(par, 'FILE7_DATE', TO_DATE (val, 'yyyy-mm-dd'))) AS FILE7_DATE,
                        CAST (MAX(DECODE(par, 'FILE0_N', TO_NUMBER (val))) AS number (38, 0)) AS FILE0_N,
                                  MAX(DECODE(par, 'FILE0_DATE', TO_DATE (val, 'yyyy-mm-dd'))) AS FILE0_DATE,
                        CAST (MAX(DECODE(par, 'FILEF_N', TO_NUMBER (val))) AS number (38, 0)) AS FILEF_N,
                                  MAX(DECODE(par, 'FILEF_DATE', TO_DATE (val, 'yyyy-mm-dd'))) AS FILEF_DATE,
                        CAST (MAX(DECODE(par, 'FILEH_N', TO_NUMBER (val))) AS number (38, 0)) AS FILEH_N,
                                  MAX(DECODE(par, 'FILEH_DATE', TO_DATE (val, 'yyyy-mm-dd'))) AS FILEH_DATE,
                        CAST (MAX(DECODE(par, 'FILEK_N', TO_NUMBER (val))) AS number (38, 0)) AS FILEK_N,
                                  MAX(DECODE(par, 'FILEK_DATE', TO_DATE (val, 'yyyy-mm-dd'))) AS FILEK_DATE,
                        CAST (MAX(DECODE(par, 'FILEL_N', TO_NUMBER (val))) AS number (38, 0)) AS FILEL_N,
                                  MAX(DECODE(par, 'FILEL_DATE', TO_DATE (val, 'yyyy-mm-dd'))) AS FILEL_DATE
                 FROM   sequence_file_params p
                WHERE   p.branch_id = get_branch_id
             GROUP BY   p.branch_id) a
    WHERE       s.branch_id = get_branch_id
            AND s.is_active = 1
            AND s.BRANCH_ID = a.BRANCH_ID;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/FINMON/View/SEQUENCE.sql =========*** End *** ===
PROMPT ===================================================================================== 
