

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/DPT_BRATES_EXPORT.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure DPT_BRATES_EXPORT ***

  CREATE OR REPLACE PROCEDURE BARS.DPT_BRATES_EXPORT (p int, p_filename out varchar2)
IS  L_DAT           DATE;
    l_FILE_CLOB     CLOB;
    L_FILENAME      VARCHAR2(100);
BEGIN

    L_DAT       := NVL(TO_DATE(GetGlobalOption ('BRATES_DATE'),'DD/MM/YYYY'),SYSDATE);
    L_FILENAME  := GetGlobalOption ('BRATES_PATH')||'brates'||TO_CHAR(l_DAT,'YYYYMMDD')||'.sql';
    P_FILENAME  := L_FILENAME;
    L_FILE_CLOB := NULL;

    for list in (
        SELECT ' MERGE INTO BARS.BRATES A USING (SELECT '
                || TO_CHAR (BR_ID)
                || ' as BR_ID, '
                || TO_CHAR (BR_TYPE)
                || ' as BR_TYPE, '''
                || NAME
                || ''' as NAME, '''
                || NVL(FORMULA,'NULL')
                || ''' as FORMULA, '
                || TO_CHAR(INUSE)
                || ' as INUSE, '''
                || COMM
                || ''' as COMM FROM DUAL) B ON (A.BR_ID = B.BR_ID) WHEN NOT MATCHED THEN INSERT ( BR_ID, BR_TYPE, NAME, FORMULA, INUSE,  COMM) '
                || ' VALUES (  B.BR_ID, B.BR_TYPE, B.NAME, B.FORMULA, B.INUSE,  B.COMM) '
                || ' WHEN MATCHED THEN UPDATE SET A.BR_TYPE = B.BR_TYPE, A.NAME = B.NAME, A.FORMULA = B.FORMULA, A.INUSE = B.INUSE, A.COMM = B.COMM; ' as TXT
          FROM BRATES
         WHERE BR_ID IN (SELECT DISTINCT BR_ID
                           FROM BARS.BR_NORMAL_EDIT
                          WHERE BDATE >= L_DAT
                         UNION ALL
                         SELECT DISTINCT BR_ID
                           FROM BARS.BR_TIER_EDIT
                          WHERE BDATE >= L_DAT)
   UNION ALL
      SELECT    ' MERGE INTO BARS.BR_NORMAL_EDIT A USING '
             || '(SELECT '
             || TO_CHAR (BR_ID)
             || ' as BR_ID, '
             || 'TO_DATE('''
             || TO_CHAR (BDATE, 'dd/mm/yyyy')
             || ''',''dd/mm/yyyy'') as BDATE, '
             || TO_CHAR (KV)
             || ' as KV, '
             || TO_CHAR (RATE)
             || ' as RATE '
             || ' FROM DUAL) B '
             || ' ON (A.BR_ID = B.BR_ID and A.BDATE = B.BDATE and A.KV = B.KV) '||chr(10)||chr(13)
             || ' WHEN NOT MATCHED THEN INSERT (  BR_ID, BDATE, KV, RATE) ' ||chr(10)||chr(13)
             || ' VALUES (  B.BR_ID, B.BDATE, B.KV, B.RATE) '||chr(10)||chr(13)
             || ' WHEN MATCHED THEN UPDATE SET A.RATE = B.RATE; 'as TXT
        FROM BARS.BR_NORMAL_EDIT
       WHERE BDATE >= l_DAT
  UNION ALL
      SELECT    ' MERGE INTO BARS.BR_TIER_EDIT A USING '
             || '(SELECT '
             || TO_CHAR (BR_ID)
             || ' as BR_ID, '
             || 'TO_DATE('''
             || TO_CHAR (BDATE, 'dd/mm/yyyy')
             || ''',''dd/mm/yyyy'') as BDATE, '
             || TO_CHAR (KV)
             || ' as KV, '
             || TO_CHAR (S)
             || ' as S, '
             || TO_CHAR (RATE)
             || ' as RATE '
             || ' FROM DUAL) B '
             || ' ON (A.BR_ID = B.BR_ID and A.BDATE = B.BDATE and A.KV = B.KV and A.S = B.S) '||chr(10)||chr(13)
             || ' WHEN NOT MATCHED THEN INSERT (  BR_ID, BDATE, KV, S, RATE) ' ||chr(10)||chr(13)
             || ' VALUES (  B.BR_ID, B.BDATE, B.KV, B.S, B.RATE) '||chr(10)||chr(13)
             || ' WHEN MATCHED THEN UPDATE SET A.RATE = B.RATE; 'as TXT
        FROM BARS.BR_TIER_EDIT
       WHERE BDATE >= l_DAT)
    loop
        L_FILE_CLOB := L_FILE_CLOB ||' '|| LIST.TXT||chr(10)||chr(13) ;
    end loop;
        L_FILE_CLOB := L_FILE_CLOB ||' '|| 'COMMIT;';
    INSERT INTO IMP_FILE (FILE_NAME, FILE_CLOB)
     VALUES (L_FILENAME, L_FILE_CLOB);

END DPT_BRATES_EXPORT;
/
show err;

PROMPT *** Create  grants  DPT_BRATES_EXPORT ***
grant EXECUTE                                                                on DPT_BRATES_EXPORT to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/DPT_BRATES_EXPORT.sql =========***
PROMPT ===================================================================================== 
