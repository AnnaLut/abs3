SET LINES 1000
SET TRIMSPOOL ON
SET SERVEROUTPUT ON SIZE 1000000
SET FEED OFF

declare
  NEW_TABID_ NUMBER;
  TMP_       NUMBER;
  STR_SELECT VARCHAR2(4000);
  STR_INSERT VARCHAR2(4000);
  STR_UPDATE VARCHAR2(4000);
  STR_DELETE VARCHAR2(4000);
  STR_FNAME  VARCHAR2(100);
  STR_ENCODE VARCHAR2(3);
  
  FUNCTION GET_TABID (TABNAME_ VARCHAR2) RETURN NUMBER 
  IS 
    TABID_ NUMBER;
  BEGIN
    BEGIN
      SELECT TABID INTO TABID_ 
      FROM META_TABLES
      WHERE TABNAME=TABNAME_;
    EXCEPTION WHEN NO_DATA_FOUND THEN TABID_:=NULL;
    END;
    RETURN TABID_;
  END;
  
begin
    -- Поиск кода таблицы
    NEW_TABID_ := GET_TABID('SB_OB22');
    IF NEW_TABID_ IS NULL THEN
      DBMS_OUTPUT.PUT_LINE('Таблица SB_OB22 не описана в БМД!');
    ELSE
      
      -- Присвоение переменных
      
      STR_SELECT:=
        'SELECT  distinct '||CHR(13)||CHR(10)||
        '   1,  R020 "НБС", '||CHR(13)||CHR(10)||
        '          OB22 "НOB22" , '||CHR(13)||CHR(10)||
        '           TXT "Н_Наименование",'||CHR(13)||CHR(10)||
        '            PRIZ  "Н_PRIZ",'||CHR(13)||CHR(10)||
        '            COD_ACT "Н_COD_ACT",  '||CHR(13)||CHR(10)||
        '            D_OPEN "Н_Дата_Откр", '||CHR(13)||CHR(10)||
        '             D_CLOSE "Н_Дата_Закр",  '||CHR(13)||CHR(10)||
        '             TO_CHAR( NULL ) "С_Наименование",'||CHR(13)||CHR(10)||
        '             TO_CHAR(NULL) "С_PRIZ",'||CHR(13)||CHR(10)||
        '             TO_CHAR( NULL ) "С_COD_ACT",'||CHR(13)||CHR(10)||
        '              NULL "С_Дата_Откр",'||CHR(13)||CHR(10)||
        '              NULL "С_Дата_Закр" '||CHR(13)||CHR(10)||
        'FROM SB_OB22N '||CHR(13)||CHR(10)||
        'WHERE D_CLOSE is null  and ( R020 , OB22)   NOT IN  (SELECT  R020, OB22  FROM SB_OB22 )'||CHR(13)||CHR(10)||
        'UNION ALL '||CHR(13)||CHR(10)||
        'SELECT  '||CHR(13)||CHR(10)||
        '   2,  SB_OB22.R020,  '||CHR(13)||CHR(10)||
        '         SB_OB22.OB22, '||CHR(13)||CHR(10)||
        '         SB_OB22.TXT,'||CHR(13)||CHR(10)||
        '         SB_OB22.PRIZ,  '||CHR(13)||CHR(10)||
        '         SB_OB22.COD_ACT, '||CHR(13)||CHR(10)||
        '         SB_OB22.D_OPEN,'||CHR(13)||CHR(10)||
        '         SB_OB22.D_CLOSE, '||CHR(13)||CHR(10)||
        '         SB_OB22N.TXT,  '||CHR(13)||CHR(10)||
        '         SB_OB22N.PRIZ,'||CHR(13)||CHR(10)||
        '         SB_OB22N.COD_ACT, '||CHR(13)||CHR(10)||
        '         SB_OB22N.D_OPEN,'||CHR(13)||CHR(10)||
        '          SB_OB22N.D_CLOSE'||CHR(13)||CHR(10)||
        'FROM SB_OB22, SB_OB22N '||CHR(13)||CHR(10)||
        'WHERE  SB_OB22N.R020=SB_OB22.R020   AND SB_OB22N.OB22=SB_OB22.OB22'||CHR(13)||CHR(10)||
        '        AND (SB_OB22N.TXT<>SB_OB22.TXT OR SB_OB22N.PRIZ<>SB_OB22.PRIZ OR '||CHR(13)||CHR(10)||
        '                   SB_OB22N.COD_ACT<>SB_OB22.COD_ACT) '||CHR(13)||CHR(10)||
        '        AND  SB_OB22N.D_CLOSE is null '||CHR(13)||CHR(10)||
        '        AND ROWNUM=1'||CHR(13)||CHR(10)||
        'UNION ALL '||CHR(13)||CHR(10)||
        'SELECT   '||CHR(13)||CHR(10)||
        '  3,  R020 "НБС",'||CHR(13)||CHR(10)||
        '      OB22 "НOB22" ,'||CHR(13)||CHR(10)||
        '      TO_CHAR( NULL ) "Н_Наименование",'||CHR(13)||CHR(10)||
        '      TO_CHAR(NULL) "Н_PRIZ",'||CHR(13)||CHR(10)||
        '      TO_CHAR( NULL ) "Н_COD_ACT",'||CHR(13)||CHR(10)||
        '      NULL "Н_Дата_Откр",'||CHR(13)||CHR(10)||
        '      NULL "Н_Дата_Закр",'||CHR(13)||CHR(10)||
        '      TXT "С_Наименование",'||CHR(13)||CHR(10)||
        '      PRIZ  "С_PRIZ",'||CHR(13)||CHR(10)||
        '      COD_ACT "С_COD_ACT",'||CHR(13)||CHR(10)||
        '      D_OPEN "С_Дата_Откр",'||CHR(13)||CHR(10)||
        '      D_CLOSE "С_Дата_Закр"'||CHR(13)||CHR(10)||
        'FROM SB_OB22'||CHR(13)||CHR(10)||
        'WHERE ( R020 , OB22)   NOT IN  ( SELECT  A.R020, A.OB22  FROM SB_OB22N A )'||CHR(13)||CHR(10)||
        '';
      
      STR_INSERT:=
        'INSERT INTO SB_OB22 ( R020, OB22 )'||CHR(13)||CHR(10)||
        'SELECT distinct A.R020, A.OB22 '||CHR(13)||CHR(10)||
        '  FROM ( SELECT B.R020, B.OB22, max(B.A010) '||CHR(13)||CHR(10)||
        '           FROM SB_OB22N  B '||CHR(13)||CHR(10)||
        '          WHERE B.D_CLOSE IS NULL '||CHR(13)||CHR(10)||
        '            AND B.D_OPEN=(SELECT max(S.D_OPEN) FROM SB_OB22N S WHERE S.R020=B.R020 AND S.OB22=B.OB22)'||CHR(13)||CHR(10)||
        '          GROUP BY B.R020, B.OB22 ) A '||CHR(13)||CHR(10)||
        ' WHERE (A.R020, A.OB22) NOT IN ( SELECT R020, OB22 FROM SB_OB22 ) '||CHR(13)||CHR(10)||
        '';
      
      STR_UPDATE:=
        'update SB_OB22 o'||CHR(13)||CHR(10)||
        '   set ( TXT, PRIZ, D_OPEN, D_CLOSE, COD_ACT ) = ( select n.TXT, n.PRIZ, n.D_OPEN, n.D_CLOSE, n.COD_ACT'||CHR(13)||CHR(10)||
        '                                                     from SB_OB22N n'     ||CHR(13)||CHR(10)||
        '                                                    where n.R020 = o.R020'||CHR(13)||CHR(10)||
        '                                                      and n.OB22 = o.OB22'||CHR(13)||CHR(10)||
        '                                                      and rownum = 1 )'   ||CHR(13)||CHR(10)||
        ' where ( o.R020, o.OB22 ) IN ( select R020, OB22'                         ||CHR(13)||CHR(10)||
        '                                 from SB_OB22N'                           ||CHR(13)||CHR(10)||
        '                                where R020 IS NOT NULL'                   ||CHR(13)||CHR(10)||
        '                                  and OB22 IS NOT NULL )'                 ||CHR(13)||CHR(10)||
        '';
      
      STR_DELETE := '';
      
      STR_FNAME  := 'SB_OB22N';
      
      STR_ENCODE := 'DOS';
      
      -- Обновление выражений в DBF_SYNC_TABS
      BEGIN
        SELECT TABID INTO TMP_ FROM DBF_SYNC_TABS WHERE TABID=NEW_TABID_;
        UPDATE DBF_SYNC_TABS SET 
          S_SELECT  = STR_SELECT,
          S_INSERT  = STR_INSERT,
          S_UPDATE  = STR_UPDATE,
          S_DELETE  = STR_DELETE,
          FILE_NAME = STR_FNAME,
          ENCODE    = STR_ENCODE
        WHERE TABID = NEW_TABID_;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          INSERT INTO DBF_SYNC_TABS (TABID, S_SELECT, S_INSERT, S_UPDATE, S_DELETE, FILE_NAME, ENCODE) 
          VALUES (NEW_TABID_, STR_SELECT, STR_INSERT, STR_UPDATE, STR_DELETE, STR_FNAME, STR_ENCODE);
      END;
      DBMS_OUTPUT.PUT_LINE('Таблица SB_OB22 внесена/обновлена в редактировании синхронизируемых таблиц');
      
    END IF;
end;
/

COMMIT;

SET FEED ON
