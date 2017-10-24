
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/kfile_pack.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.KFILE_PACK 
IS
    -- Author  : Alex.Iurchenko
    -- Created : 31.12.1899 23:59:59
    -- Purpose : package for work with k-files data(CA LEVEL)
    -- Версія пакету
    G_HEADER_VERSION   CONSTANT VARCHAR2 (64) := 'version 1.00 XX/XX/2015';

    C_OB_CORPORATION_STATE CONSTANT VARCHAR2 (25 CHAR) := 'OB_CORPORATION_STATE';
    C_OB_STATE_ACTIVE      CONSTANT INT := 1;
    C_OB_STATE_LOCKED      CONSTANT INT := 2;
    C_OB_STATE_CLOSED      CONSTANT INT := 3;

    TYPE R_UNIT IS RECORD (ID OB_CORPORATION.ID%TYPE, CORPORATION_NAME OB_CORPORATION.CORPORATION_NAME%TYPE);
    TYPE T_UNITS IS TABLE OF R_UNIT;


    TYPE MEASURE_RECORD IS RECORD
    (
        kf   VARCHAR2 (6),
        OST_SUM  NUMBER
    );

    TYPE MEASURE_TABLE IS TABLE OF MEASURE_RECORD;

    TYPE MEASURE_RECORD_2 IS RECORD
    (
        KOD_USTAN  NUMBER,
        OST_SUM    NUMBER
    );

    TYPE MEASURE_TABLE_2 IS TABLE OF MEASURE_RECORD_2;

    -- header_version - возвращает версию заголовка пакета
    FUNCTION HEADER_VERSION RETURN VARCHAR2;

    -- body_version - возвращает версию тела пакета
    FUNCTION BODY_VERSION RETURN VARCHAR2;

    FUNCTION GET_C_OB_CORPORATION_STATE RETURN VARCHAR2;

    PROCEDURE ADD_CORPORATION (P_CORPORATION_CODE   OB_CORPORATION.CORPORATION_CODE%TYPE,
                               P_CORPORATION_NAME   OB_CORPORATION.CORPORATION_NAME%TYPE,
                               P_PARENT_ID          OB_CORPORATION.PARENT_ID%TYPE DEFAULT NULL,
                               P_EXTERNAL_ID        OB_CORPORATION.EXTERNAL_ID%TYPE);

    PROCEDURE EDIT_CORPORATION (P_ID                 OB_CORPORATION.ID%TYPE,
                                P_CORPORATION_CODE   OB_CORPORATION.CORPORATION_CODE%TYPE,
                                P_CORPORATION_NAME   OB_CORPORATION.CORPORATION_NAME%TYPE,
                                P_EXTERNAL_ID        OB_CORPORATION.EXTERNAL_ID%TYPE);

    PROCEDURE LOCK_CORPORATION_ITEM(P_UNIT_ID OB_CORPORATION.ID%TYPE);

    PROCEDURE UNLOCK_CORPORATION_ITEM(P_UNIT_ID OB_CORPORATION.ID%TYPE);

    PROCEDURE CLOSE_CORPORATION_ITEM(P_UNIT_ID OB_CORPORATION.ID%TYPE);

    FUNCTION KF_OST_SUM (P_CORP_ID      OB_CORPORATION_DATA.CORPORATION_ID%TYPE,
                         P_NBS          OB_CORPORATION_DATA.NLS%TYPE,
                         P_KV_FLAG      INTEGER,
                         P_KOD_ANALYT   OB_CORPORATION_DATA.KOD_ANALYT%TYPE,
                         P_DATE_START   OB_CORPORATION_DATA.POSTDAT%TYPE,
                         P_DATE_END     OB_CORPORATION_DATA.POSTDAT%TYPE)
    RETURN MEASURE_TABLE PIPELINED;

    FUNCTION KF_OST_SUM_USTAN (P_CORP_ID      OB_CORPORATION_DATA.CORPORATION_ID%TYPE,
                               P_NBS          OB_CORPORATION_DATA.NLS%TYPE,
                               P_KV_FLAG      INTEGER,
                               P_KOD_ANALYT   OB_CORPORATION_DATA.KOD_ANALYT%TYPE,
                               P_DATE_START        OB_CORPORATION_DATA.POSTDAT%TYPE,
                               P_DATE_end       OB_CORPORATION_DATA.POSTDAT%TYPE)
    RETURN MEASURE_TABLE_2 PIPELINED;

    FUNCTION GET_POSSIBLE_UNITS(P_ID_UNIT OB_CORPORATION.ID%TYPE) RETURN T_UNITS PIPELINED;

    PROCEDURE CHANGE_HIERARCHY (P_ID_UNIT   OB_CORPORATION.ID%TYPE,
                                P_PARENT_ID OB_CORPORATION.PARENT_ID%TYPE);
    --процедура обновления счетов корпоративных клиентов(обновляет включение в выписку, код ТРКК, код подразделения, дату открытия и альтернат. корпорацию)
    procedure UPDATE_ACC_CORP(p_acc_corp_params T_acc_corp_params);
    procedure corp_data_ins (
   p_session_id    ob_corporation_data.session_id%type);
   procedure corp_data_del (
   p_session_id    ob_corporation_data.session_id%type);
   function corp_data_cnt (
   p_session_id    ob_corporation_data.session_id%type)  return number;
function get_correct_session_id (p_corporation_id number,p_ourmfo number, p_session_id number)
return number;
function get_correct_nbs (p_corporation_id number, p_nbs number)
return number;
function get_mmfo_type return number;
procedure ins_customerw (p_rnk customerw.rnk%type,p_external_id varchar2, p_org_id varchar2);
procedure ins_nbs (p_EXTERNAL_ID varchar2,p_NBS varchar2,PREPORT_IN varchar2);
procedure ins_nbs_grc (p_EXTERNAL_ID varchar2,p_NBS varchar2,PREPORT_IN varchar2);
PROCEDURE KFILE_GET_DICT;
procedure dict_send_cnt(res_ out varchar2);
procedure  dict_send (xml_body in clob, res_ out varchar2);
PROCEDURE KFILE_GET (xml_body CLOB, res_ OUT varchar2);
PROCEDURE KFILE_SEND(p_date in varchar2, p_corp_code varchar2);
END KFILE_PACK;
/
CREATE OR REPLACE PACKAGE BODY BARS.KFILE_PACK 
IS
    -- ?ерс?џ пакету
    G_BODY_VERSION   CONSTANT VARCHAR2 (64) := 'version 1.00 01/11/2015';
    G_DBGCODE        CONSTANT VARCHAR2 (20) := 'kfile_pack';
    ------------------------------------------------------------------------------------
    CURSOR CUR_CURR_CORPORATION_STATE (P_ID OB_CORPORATION.ID%TYPE) IS
    SELECT STATE_ID
    FROM OB_CORPORATION C
    WHERE C.ID = P_ID;
    ------------------------------------------------------------------------------------
    CURSOR POSIBLE_UNITS (P_ID OB_CORPORATION.ID%TYPE, P_ROOT OB_CORPORATION.ID%TYPE) IS
    SELECT T.ID, T.CORPORATION_NAME
    FROM OB_CORPORATION T
    WHERE T.STATE_ID <> C_OB_STATE_CLOSED
    START WITH ID = P_ROOT
    CONNECT BY PRIOR ID = PARENT_ID
    MINUS
    SELECT T.ID, T.CORPORATION_NAME
    FROM OB_CORPORATION T
    WHERE T.STATE_ID <> C_OB_STATE_CLOSED
    START WITH ID = P_ID
    CONNECT BY PRIOR ID = PARENT_ID;
    ------------------------------------------------------------------------------------
    CURSOR GET_ROOT(P_ID OB_CORPORATION.ID%TYPE) IS
    SELECT MAX(ID) KEEP (DENSE_RANK LAST ORDER BY LEVEL)
    FROM OB_CORPORATION T
    START WITH ID = P_ID
    CONNECT BY ID = PRIOR PARENT_ID;
    ------------------------------------------------------------------------------------
    --
    -- ora_lock    exception;
    -- pragma exception_init(ora_lock, -54);

    -- header_version - возвращает версию заголовка пакета
    FUNCTION HEADER_VERSION RETURN VARCHAR2 IS
    BEGIN
        RETURN 'Package header ' || G_DBGCODE || ' ' || G_HEADER_VERSION || '.';
    END HEADER_VERSION;

    -- body_version - возвращает версию тела пакета
    FUNCTION BODY_VERSION RETURN VARCHAR2 IS
    BEGIN
        RETURN 'Package body ' || G_DBGCODE || ' ' || G_BODY_VERSION || '.';
    END BODY_VERSION;

    FUNCTION GET_C_OB_CORPORATION_STATE RETURN VARCHAR2 IS
    BEGIN
        RETURN C_OB_CORPORATION_STATE;
    END;
    PROCEDURE ADD_CORPORATION (P_CORPORATION_CODE OB_CORPORATION.CORPORATION_CODE%TYPE,
                               P_CORPORATION_NAME OB_CORPORATION.CORPORATION_NAME%TYPE,
                               P_PARENT_ID        OB_CORPORATION.PARENT_ID%TYPE DEFAULT NULL,
                               P_EXTERNAL_ID      OB_CORPORATION.EXTERNAL_ID%TYPE) IS
        L_CORP_ID  OB_CORPORATION.ID%TYPE;
        L_CORP_ROW OB_CORPORATION%ROWTYPE;
        RES        NUMBER;
    BEGIN

        if P_PARENT_ID is null then --корневаЯ корпорациЯ
          begin
            select 1 into res from V_ROOT_CORPORATION t where P_EXTERNAL_ID = t.EXTERNAL_ID;
            --нашли - ругаемсЯ
            raise_application_error (-20300,'Џґдроздґл з таким ґдентифґкатором вже ґсну№');
          exception
            when no_data_found then null; --не нашли - все нормально
          end;
        else     --подразделение
          begin
            select 1 into res from V_ORG_CORPORATIONS t
            where t.EXTERNAL_ID = P_EXTERNAL_ID
            and   t.base_extid = (select t.base_extid from V_ORG_CORPORATIONS t where P_PARENT_ID = t.ID); --находим ид корневой корпорации
            raise_application_error (-20300,'Џґдроздґл з таким ґдентифґкатором вже ґсну№');
          exception
            when no_data_found then null;
          end;
        end if;

        SELECT S_OB_CORPORATION.NEXTVAL INTO L_CORP_ID FROM DUAL;

        INSERT INTO BARS.OB_CORPORATION T1 (T1.ID)
        VALUES (L_CORP_ID)
        RETURNING ID INTO L_CORP_ROW.ID;

        IF (P_CORPORATION_NAME IS NOT NULL) THEN
            BARS.ATTRIBUTE_UTL.SET_VALUE (L_CORP_ROW.ID,
                                          'CORPORATION_NAME',
                                          P_CORPORATION_NAME);
        END IF;

        IF (P_CORPORATION_CODE IS NOT NULL) THEN
            BARS.ATTRIBUTE_UTL.SET_VALUE (L_CORP_ROW.ID,
                                          'CORPORATION_CODE',
                                          P_CORPORATION_CODE);
        END IF;

        IF (P_PARENT_ID IS NOT NULL ) THEN
            BARS.ATTRIBUTE_UTL.SET_VALUE (L_CORP_ROW.ID,
                                          'CORPORATION_PARENT_ID',
                                          P_PARENT_ID);
        END IF;

        IF (P_EXTERNAL_ID IS NOT NULL) THEN
            BARS.ATTRIBUTE_UTL.SET_VALUE (L_CORP_ROW.ID,
                                          'CORPORATION_EXTERNAL_ID',
                                          P_EXTERNAL_ID);
        END IF;

        BARS.ATTRIBUTE_UTL.SET_VALUE (L_CORP_ROW.ID,
                                      'CORPORATION_STATE_ID',
                                      C_OB_STATE_ACTIVE);
    END ADD_CORPORATION;

    PROCEDURE EDIT_CORPORATION (P_ID               OB_CORPORATION.ID%TYPE,
                                P_CORPORATION_CODE OB_CORPORATION.CORPORATION_CODE%TYPE,
                                P_CORPORATION_NAME OB_CORPORATION.CORPORATION_NAME%TYPE,
                                P_EXTERNAL_ID      OB_CORPORATION.EXTERNAL_ID%TYPE) IS
        L_CORP_ROW OB_CORPORATION%ROWTYPE;
        res        number;
    BEGIN
        BEGIN
            SELECT T1.* INTO L_CORP_ROW
            FROM OB_CORPORATION T1
            WHERE T1.ID = P_ID;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20101, 'Не знайдено п?дрозд?л корпорац?И з кодом '|| TO_CHAR(P_ID));
        END;

        if L_CORP_ROW.PARENT_ID is null then --корневаЯ корпорациЯ
          begin
            select 1 into res from V_ROOT_CORPORATION t where P_EXTERNAL_ID = t.EXTERNAL_ID and P_ID != t.ID;
            --нашли - ругаемсЯ
            raise_application_error (-20300,'Џґдроздґл з таким ґдентифґкатором вже ґсну№');
          exception
            when no_data_found then null; --не нашли - все нормально
          end;
        else     --подразделение
          begin
            select 1 into res from V_ORG_CORPORATIONS t
            where t.EXTERNAL_ID = P_EXTERNAL_ID
            and   P_ID != t.ID
            and   t.base_extid = (select t.base_extid from V_ORG_CORPORATIONS t where L_CORP_ROW.PARENT_ID = t.ID); --находим ид корневой корпорации
            raise_application_error (-20300,'Џґдроздґл з таким ґдентифґкатором вже ґсну№');
          exception
            when no_data_found then null;
          end;
        end if;

        IF (P_CORPORATION_NAME <> L_CORP_ROW.CORPORATION_NAME
        OR (P_CORPORATION_NAME IS NULL AND L_CORP_ROW.CORPORATION_NAME IS NOT NULL)
        OR (P_CORPORATION_NAME IS NOT NULL AND L_CORP_ROW.CORPORATION_NAME IS NULL)) THEN
            BARS.ATTRIBUTE_UTL.SET_VALUE (L_CORP_ROW.ID,
                                          'CORPORATION_NAME',
                                          P_CORPORATION_NAME);
        END IF;

        IF (P_CORPORATION_CODE <> L_CORP_ROW.CORPORATION_CODE
        OR (P_CORPORATION_CODE IS NULL AND L_CORP_ROW.CORPORATION_CODE IS NOT NULL)
        OR (P_CORPORATION_CODE IS NOT NULL AND L_CORP_ROW.CORPORATION_CODE IS NULL)) THEN
            BARS.ATTRIBUTE_UTL.SET_VALUE (L_CORP_ROW.ID,
                                          'CORPORATION_CODE',
                                          P_CORPORATION_CODE);
        END IF;

        IF (P_EXTERNAL_ID <> L_CORP_ROW.EXTERNAL_ID
        OR (P_EXTERNAL_ID IS NULL AND L_CORP_ROW.EXTERNAL_ID IS NOT NULL)
        OR (P_EXTERNAL_ID IS NOT NULL AND L_CORP_ROW.EXTERNAL_ID IS NULL)) THEN
            BARS.ATTRIBUTE_UTL.SET_VALUE (L_CORP_ROW.ID,
                                          'CORPORATION_EXTERNAL_ID',
                                          P_EXTERNAL_ID);
        END IF;
    END EDIT_CORPORATION;

    PROCEDURE LOCK_CORPORATION_ITEM(P_UNIT_ID OB_CORPORATION.ID%TYPE) IS
        CURSOR CUR_CORPORATION IS
        SELECT S.ID
        FROM OB_CORPORATION S
        WHERE S.STATE_ID = C_OB_STATE_ACTIVE
        START WITH ID = P_UNIT_ID
        CONNECT BY PRIOR ID = PARENT_ID;
        TYPE TAB_CORPORATION IS TABLE OF CUR_CORPORATION%ROWTYPE;
        L_TAB_CORPORATION TAB_CORPORATION;
        L_CURR_CORPORATION_STATE OB_CORPORATION.STATE_ID%TYPE;
    BEGIN
        OPEN CUR_CURR_CORPORATION_STATE(P_ID => P_UNIT_ID);
        FETCH CUR_CURR_CORPORATION_STATE INTO L_CURR_CORPORATION_STATE;
        CLOSE CUR_CURR_CORPORATION_STATE;

        IF L_CURR_CORPORATION_STATE = C_OB_STATE_ACTIVE THEN
            OPEN CUR_CORPORATION;
            LOOP
                FETCH CUR_CORPORATION BULK COLLECT INTO L_TAB_CORPORATION LIMIT 500;
                EXIT WHEN NVL(L_TAB_CORPORATION.COUNT,0) = 0;
                FOR I IN L_TAB_CORPORATION.FIRST..L_TAB_CORPORATION.LAST LOOP
                    BARS.ATTRIBUTE_UTL.SET_VALUE (L_TAB_CORPORATION(I).ID,
                                                  'CORPORATION_STATE_ID',
                                                  C_OB_STATE_LOCKED);
                END LOOP;
            END LOOP;
            CLOSE CUR_CORPORATION;
        ELSE
            RAISE_APPLICATION_ERROR(-20000, 'Нев?дпов?дн?сть статус?в!');
        END IF;
    END;

    PROCEDURE UNLOCK_CORPORATION_ITEM(P_UNIT_ID OB_CORPORATION.ID%TYPE) IS
    CURSOR CUR_CORPORATION IS
        SELECT S.ID
        FROM OB_CORPORATION S
        WHERE S.STATE_ID = C_OB_STATE_LOCKED
        START WITH ID = P_UNIT_ID
        CONNECT BY PRIOR PARENT_ID = ID;
        TYPE TAB_CORPORATION IS TABLE OF CUR_CORPORATION%ROWTYPE;
        L_TAB_CORPORATION TAB_CORPORATION;
        L_CURR_CORPORATION_STATE OB_CORPORATION.STATE_ID%TYPE;
    BEGIN
        OPEN CUR_CURR_CORPORATION_STATE(P_ID => P_UNIT_ID);
        FETCH CUR_CURR_CORPORATION_STATE INTO L_CURR_CORPORATION_STATE;
        CLOSE CUR_CURR_CORPORATION_STATE;

        IF L_CURR_CORPORATION_STATE = C_OB_STATE_LOCKED THEN
            OPEN CUR_CORPORATION;
            LOOP
                FETCH CUR_CORPORATION BULK COLLECT INTO L_TAB_CORPORATION LIMIT 500;
                EXIT WHEN NVL(L_TAB_CORPORATION.COUNT,0) = 0;
                FOR I IN L_TAB_CORPORATION.FIRST..L_TAB_CORPORATION.LAST LOOP
                    BARS.ATTRIBUTE_UTL.SET_VALUE (L_TAB_CORPORATION(I).ID,
                                                  'CORPORATION_STATE_ID',
                                                  C_OB_STATE_ACTIVE);
                END LOOP;
            END LOOP;
            CLOSE CUR_CORPORATION;
        ELSE
            RAISE_APPLICATION_ERROR(-20000, 'Нев?дпов?дн?сть статус?в!');
        END IF;
    END;

    PROCEDURE CLOSE_CORPORATION_ITEM(P_UNIT_ID OB_CORPORATION.ID%TYPE) IS
        CURSOR CUR_CORPORATION IS
        SELECT S.ID
        FROM OB_CORPORATION S
        WHERE S.STATE_ID <> C_OB_STATE_CLOSED
        START WITH ID = P_UNIT_ID
        CONNECT BY PRIOR ID = PARENT_ID;
        TYPE TAB_CORPORATION IS TABLE OF CUR_CORPORATION%ROWTYPE;
        L_TAB_CORPORATION TAB_CORPORATION;
        L_CURR_CORPORATION_STATE OB_CORPORATION.STATE_ID%TYPE;
    BEGIN
        OPEN CUR_CURR_CORPORATION_STATE(P_ID => P_UNIT_ID);
        FETCH CUR_CURR_CORPORATION_STATE INTO L_CURR_CORPORATION_STATE;
        CLOSE CUR_CURR_CORPORATION_STATE;

        IF L_CURR_CORPORATION_STATE <> C_OB_STATE_CLOSED THEN
            OPEN CUR_CORPORATION;
            LOOP
                FETCH CUR_CORPORATION BULK COLLECT INTO L_TAB_CORPORATION LIMIT 500;
                EXIT WHEN NVL(L_TAB_CORPORATION.COUNT,0) = 0;
                FOR I IN L_TAB_CORPORATION.FIRST..L_TAB_CORPORATION.LAST LOOP
                    BARS.ATTRIBUTE_UTL.SET_VALUE (L_TAB_CORPORATION(I).ID,
                                                  'CORPORATION_STATE_ID',
                                                  C_OB_STATE_CLOSED);
                END LOOP;
            END LOOP;
            CLOSE CUR_CORPORATION;
        ELSE
            RAISE_APPLICATION_ERROR(-20000, 'Нев?дпов?дн?сть статус?в!');
        END IF;
    END;

   -- возвращает общую сумму остатков за период по календарным днџм (учитываџ первую и последнюю даты)
   -- (используетсџ в дальнейшем к примеру длџ расчета средневзвешенного остатка период)
   FUNCTION KF_OST_SUM(P_CORP_ID    IN OB_CORPORATION_DATA.CORPORATION_ID%TYPE,
                       P_NBS        IN OB_CORPORATION_DATA.NLS%TYPE,
                       -- p_kv_flag - ознака, џка вказуЬ по џким валютам формувати залишки
                       -- 0 - вс? валюти
                       -- 1 - гривнџ
                       -- 2 - ?ноземн? валюти (вс? кр?м гривн?)
                       P_KV_FLAG    INTEGER,
                       P_KOD_ANALYT IN OB_CORPORATION_DATA.KOD_ANALYT%TYPE,
                       P_DATE_START IN OB_CORPORATION_DATA.POSTDAT%TYPE,
                       P_DATE_END   IN OB_CORPORATION_DATA.POSTDAT%TYPE)
     RETURN MEASURE_TABLE
     PIPELINED IS
     REC       MEASURE_RECORD;
     DATE_I    OB_CORPORATION_DATA.POSTDAT%TYPE;
     DATE_MIN  OB_CORPORATION_DATA.POSTDAT%TYPE;
     DATE_max  OB_CORPORATION_DATA.POSTDAT%TYPE;
     OST_      OB_CORPORATION_DATA.OSTQ%TYPE := 0;
     SS_       OB_CORPORATION_DATA.OSTQ%TYPE := 0;
     DATE_DIFF DECIMAL;
     CURSOR C1 IS
       SELECT DISTINCT CD.kf
         FROM OB_CORPORATION_DATA CD
        WHERE     CD.ROWTYPE = 0
              AND CD.CORPORATION_ID = P_CORP_ID;
   BEGIN
     FOR I IN C1 LOOP
       BEGIN

         --  менџем первую дату периода (если перваџ дата в ob_corporation_data больше, чем перваџ дата периода)
         SELECT MIN(CD.file_date)
           INTO DATE_MIN
           FROM OB_CORPORATION_DATA CD
          WHERE     CD.ROWTYPE = 0
                AND CD.CORPORATION_ID = P_CORP_ID
                AND CD.kf = I.kf
                AND trunc(CD.file_date) BETWEEN P_DATE_START AND P_DATE_END;

          SELECT max(CD.file_date)
           INTO DATE_max
           FROM OB_CORPORATION_DATA CD
          WHERE     CD.ROWTYPE = 0
                AND CD.CORPORATION_ID = P_CORP_ID
                AND CD.kf = I.kf
                AND trunc(CD.file_date) BETWEEN P_DATE_START AND P_DATE_END;


           /*
         IF DATE_MIN <= P_DATE_START THEN
           DATE_I := P_DATE_START;
         ELSE
           DATE_I := DATE_MIN;
         END IF;

    
         SELECT count(distinct file_Date)
           INTO DATE_DIFF
           FROM OB_CORPORATION_DATA cd
           where    CD.ROWTYPE = 0
                AND CD.CORPORATION_ID = P_CORP_ID
                AND CD.kf = I.kf
                and trunc(CD.file_date) BETWEEN P_DATE_START AND P_DATE_END;

     */
     DATE_DIFF:=0;
         -- устанавливаем предельную дату длџ суммированиџ = второй дате периода
         -- не имеет значениџ есть ли такаџ дата в ob_corporation_data, если еще не наступила,
         -- то будет прогнозный расчет cо значением остатка=текущему

         -- суммируем в выбранном периоде остатки
         WHILE DATE_max >= DATE_min LOOP
           BEGIN
             IF P_KV_FLAG = 0 THEN -- вс? валюти
               SELECT SUM(cd.ostq-cd.obkrq+cd.obdbq)
                 INTO OST_
                 FROM OB_CORPORATION_DATA CD
                WHERE CD.ROWTYPE = 0
                  AND CD.CORPORATION_ID = P_CORP_ID
                  and get_correct_session_id(cd.corporation_id,cd.kf,cd.session_id)=1
                  and get_correct_nbs(cd.corporation_id,substr(cd.nls,1,4))=1
                  AND CD.kf = I.kf
                  AND CD.NLS LIKE P_NBS || '%'
                  AND  ( decode(P_KOD_ANALYT,'%', nvl(CD.KOD_ANALYT,0), P_KOD_ANALYT) = nvl(CD.KOD_ANALYT,0) or  decode(P_KOD_ANALYT,'%', nvl('0'||CD.KOD_ANALYT,0), '0'||P_KOD_ANALYT) = nvl('0'||CD.KOD_ANALYT,0) )
                  AND CD.file_date =
                      (SELECT min(T1.file_date)
                         FROM OB_CORPORATION_DATA T1
                        WHERE     T1.kf = I.kf
                              AND T1.CORPORATION_ID = P_CORP_ID
                              AND T1.file_date >= DATE_max);
             END IF;
             IF P_KV_FLAG = 1 THEN -- гривнџ
               SELECT SUM(cd.ostq-cd.obkrq+cd.obdbq)
                 INTO OST_
                 FROM OB_CORPORATION_DATA CD
                WHERE CD.ROWTYPE = 0
                  AND CD.CORPORATION_ID = P_CORP_ID
                 and get_correct_session_id(cd.corporation_id,cd.kf,cd.session_id)=1
                  and get_correct_nbs(cd.corporation_id,substr(cd.nls,1,4))=1
                  AND CD.kf = I.kf
                  AND CD.NLS LIKE P_NBS || '%'
                  AND CD.KV = 980
                   AND  ( decode(P_KOD_ANALYT,'%', nvl(CD.KOD_ANALYT,0), P_KOD_ANALYT) = nvl(CD.KOD_ANALYT,0) or  decode(P_KOD_ANALYT,'%', nvl('0'||CD.KOD_ANALYT,0), '0'||P_KOD_ANALYT) = nvl('0'||CD.KOD_ANALYT,0) )
                  AND CD.file_date =
                      (SELECT min(T1.file_date)
                         FROM OB_CORPORATION_DATA T1
                        WHERE     T1.kf = I.kf
                              AND T1.CORPORATION_ID = P_CORP_ID
                              AND T1.file_date >= DATE_max);
             END IF;
             IF P_KV_FLAG = 2 THEN -- ?ноземн? валюти
               SELECT SUM(cd.ostq-cd.obkrq+cd.obdbq)
                 INTO OST_
                 FROM OB_CORPORATION_DATA CD
                WHERE CD.ROWTYPE = 0
                  AND CD.CORPORATION_ID = P_CORP_ID
                  and get_correct_session_id(cd.corporation_id,cd.kf,cd.session_id)=1
                  and get_correct_nbs(cd.corporation_id,substr(cd.nls,1,4))=1
                  AND CD.kf = I.kf
                  AND CD.NLS LIKE P_NBS || '%'
                  AND CD.KV != 980
                   AND  ( decode(P_KOD_ANALYT,'%', nvl(CD.KOD_ANALYT,0), P_KOD_ANALYT) = nvl(CD.KOD_ANALYT,0) or  decode(P_KOD_ANALYT,'%', nvl('0'||CD.KOD_ANALYT,0), '0'||P_KOD_ANALYT) = nvl('0'||CD.KOD_ANALYT,0) )
                  AND CD.file_date =
                      (SELECT Min(T1.file_date)
                         FROM OB_CORPORATION_DATA T1
                        WHERE     T1.kf = I.kf
                              AND T1.CORPORATION_ID = P_CORP_ID
                              AND T1.file_date >= DATE_max);
             END IF;
             SS_    := SS_ + OST_;
             OST_   := 0;
             DATE_max := DATE_max - 1;
             DATE_DIFF:=DATE_DIFF+1;
           END;
         END LOOP;
         REC.kf  := I.kf;
         REC.OST_SUM := TRUNC(SS_ / 100 / DATE_DIFF, 2); -- /100 - в гривны; /date_diff - среднее за период;
         PIPE ROW(REC);
         SS_ := 0;
                exception when  ZERO_DIVIDE THEN raise_application_error (-20001, 'Відсутні данні за вказаний період');
       END;
     END LOOP;

     RETURN;
   END KF_OST_SUM;

   -- возвращает общую сумму остатков за период по календарным днџм (учитываџ первую и последнюю даты)
   -- (используетсџ в дальнейшем к примеру длџ расчета средневзвешенного остатка период)
   FUNCTION KF_OST_SUM_USTAN(P_CORP_ID    IN OB_CORPORATION_DATA.CORPORATION_ID%TYPE,
                             P_NBS        IN OB_CORPORATION_DATA.NLS%TYPE,
                             -- p_kv_flag - ознака, џка вказуЬ по џким валютам формувати залишки
                             -- 0 - вс? валюти
                             -- 1 - гривнџ
                             -- 2 - ?ноземн? валюти (вс? кр?м гривн?)
                             P_KV_FLAG    INTEGER,
                             P_KOD_ANALYT IN OB_CORPORATION_DATA.KOD_ANALYT%TYPE,
                             P_DATE_START      IN OB_CORPORATION_DATA.POSTDAT%TYPE,
                             P_DATE_END      IN OB_CORPORATION_DATA.POSTDAT%TYPE)
     RETURN MEASURE_TABLE_2
     PIPELINED IS
     REC       MEASURE_RECORD_2;
     DATE_I    OB_CORPORATION_DATA.POSTDAT%TYPE;
     DATE_MIN  OB_CORPORATION_DATA.POSTDAT%TYPE;
     DATE_max  OB_CORPORATION_DATA.POSTDAT%TYPE;
     OST_      OB_CORPORATION_DATA.OSTQ%TYPE := 0;
     SS_       OB_CORPORATION_DATA.OSTQ%TYPE := 0;
     DATE_DIFF DECIMAL;
     CURSOR C1 IS
       SELECT DISTINCT CD.KOD_USTAN
         FROM OB_CORPORATION_DATA CD
        WHERE     CD.ROWTYPE = 0
              AND CD.CORPORATION_ID = P_CORP_ID;
   BEGIN

     FOR I IN C1 LOOP
       BEGIN
--  менџем первую дату периода (если перваџ дата в ob_corporation_data больше, чем перваџ дата периода)
         SELECT MIN(CD.file_date)
           INTO DATE_MIN
           FROM OB_CORPORATION_DATA CD
          WHERE     CD.ROWTYPE = 0
                AND CD.CORPORATION_ID = P_CORP_ID
               -- AND CD.kf = I.kf
                AND trunc(CD.file_date) BETWEEN P_DATE_START AND P_DATE_END;

          SELECT max(CD.file_date)
           INTO DATE_max
           FROM OB_CORPORATION_DATA CD
          WHERE     CD.ROWTYPE = 0
                AND CD.CORPORATION_ID = P_CORP_ID
               -- AND CD.kf = I.kf
                AND trunc(CD.file_date) BETWEEN P_DATE_START AND P_DATE_END;
                /*
         SELECT count(distinct file_Date)
           INTO DATE_DIFF
           FROM OB_CORPORATION_DATA cd
           where    CD.ROWTYPE = 0
                AND CD.CORPORATION_ID = P_CORP_ID
               -- AND CD.kf = I.kf
                and trunc(CD.file_date) BETWEEN P_DATE_START AND P_DATE_END;*/
            DATE_DIFF:=0;
         -- устанавливаем предельную дату длџ суммированиџ = второй дате периода
         -- не имеет значениџ есть ли такаџ дата в ob_corporation_data, если еще не наступила,
         -- то будет прогнозный расчет cо значением остатка=текущему

         -- суммируем в выбранном периоде остатки
         WHILE DATE_max >= DATE_min LOOP
           BEGIN
             IF P_KV_FLAG = 0 THEN -- вс? валюти
               SELECT SUM(cd.ostq-cd.obkrq+cd.obdbq)
                 INTO OST_
                 FROM OB_CORPORATION_DATA CD
                WHERE     CD.ROWTYPE = 0
                      AND CD.CORPORATION_ID = P_CORP_ID
                      AND CD.KOD_USTAN = I.KOD_USTAN
                      AND CD.NLS LIKE P_NBS || '%'
                      and get_correct_session_id(cd.corporation_id,cd.kf,cd.session_id)=1
                      and get_correct_nbs(cd.corporation_id,substr(cd.nls,1,4))=1
                      AND  ( decode(P_KOD_ANALYT,'%', nvl(CD.KOD_ANALYT,0), P_KOD_ANALYT) = nvl(CD.KOD_ANALYT,0) or  decode(P_KOD_ANALYT,'%', nvl('0'||CD.KOD_ANALYT,0), '0'||P_KOD_ANALYT) = nvl('0'||CD.KOD_ANALYT,0) )
                      AND CD.file_date =
                          (SELECT MIN(T1.file_date)
                             FROM OB_CORPORATION_DATA T1
                            WHERE     T1.KOD_USTAN = I.KOD_USTAN
                                  AND T1.CORPORATION_ID = P_CORP_ID
                                  AND T1.file_date >= DATE_max);
             END IF;
             IF P_KV_FLAG = 1 THEN -- гривнџ
               SELECT SUM(cd.ostq-cd.obkrq+cd.obdbq)
                 INTO OST_
                 FROM OB_CORPORATION_DATA CD
                WHERE     CD.ROWTYPE = 0
                      AND CD.CORPORATION_ID = P_CORP_ID
                      AND CD.KOD_USTAN = I.KOD_USTAN
                      AND CD.KV = 980
                      AND CD.NLS LIKE P_NBS || '%'
                      and get_correct_session_id(cd.corporation_id,cd.kf,cd.session_id)=1
                      and get_correct_nbs(cd.corporation_id,substr(cd.nls,1,4))=1
                      AND  ( decode(P_KOD_ANALYT,'%', nvl(CD.KOD_ANALYT,0), P_KOD_ANALYT) = nvl(CD.KOD_ANALYT,0) or  decode(P_KOD_ANALYT,'%', nvl('0'||CD.KOD_ANALYT,0), '0'||P_KOD_ANALYT) = nvl('0'||CD.KOD_ANALYT,0) )
                      AND CD.file_date =
                          (SELECT MIN(T1.file_date)
                             FROM OB_CORPORATION_DATA T1
                            WHERE     T1.KOD_USTAN = I.KOD_USTAN
                                  AND T1.CORPORATION_ID = P_CORP_ID
                                  AND T1.file_date >= DATE_max);
             END IF;
             IF P_KV_FLAG = 2 THEN -- ?ноземн? валюти
               SELECT SUM(cd.ostq-cd.obkrq+cd.obdbq)
                 INTO OST_
                 FROM OB_CORPORATION_DATA CD
                WHERE     CD.ROWTYPE = 0
                      AND CD.CORPORATION_ID = P_CORP_ID
                      AND CD.KOD_USTAN = I.KOD_USTAN
                      AND CD.KV != 980
                      AND CD.NLS LIKE P_NBS || '%'
                      and get_correct_session_id(cd.corporation_id,cd.kf,cd.session_id)=1
                      and get_correct_nbs(cd.corporation_id,substr(cd.nls,1,4))=1
                      AND  ( decode(P_KOD_ANALYT,'%', nvl(CD.KOD_ANALYT,0), P_KOD_ANALYT) = nvl(CD.KOD_ANALYT,0) or  decode(P_KOD_ANALYT,'%', nvl('0'||CD.KOD_ANALYT,0), '0'||P_KOD_ANALYT) = nvl('0'||CD.KOD_ANALYT,0) )
                      AND CD.file_date =
                          (SELECT MIN(T1.file_date)
                             FROM OB_CORPORATION_DATA T1
                            WHERE     T1.KOD_USTAN = I.KOD_USTAN
                                  AND T1.CORPORATION_ID = P_CORP_ID
                                  AND T1.file_date >= DATE_max);
             END IF;
             SS_    := SS_ + OST_;
             OST_   := 0;
             DATE_MIN := DATE_MIN + 1;
             DATE_DIFF:=DATE_DIFF+1;
           END;
         END LOOP;
         REC.KOD_USTAN := I.KOD_USTAN;
         REC.OST_SUM   := TRUNC(SS_ / 100 / DATE_DIFF, 2); -- /100 - в гривны; /date_diff - среднее за период;
         PIPE ROW(REC);
         SS_ := 0;
       exception when  ZERO_DIVIDE THEN raise_application_error (-20001, 'Відсутні данні за вказаний період');
       END;
     END LOOP;

     RETURN;
   END KF_OST_SUM_USTAN;

    FUNCTION GET_POSSIBLE_UNITS(P_ID_UNIT OB_CORPORATION.ID%TYPE) RETURN T_UNITS PIPELINED IS
        ------------------------------------------------------------------------------------
        L_UNIT R_UNIT;
        L_ROOT OB_CORPORATION.ID%TYPE;
        L_UNITS T_UNITS;
        ------------------------------------------------------------------------------------
    BEGIN
        OPEN GET_ROOT(P_ID_UNIT);
        FETCH GET_ROOT INTO L_ROOT;
        CLOSE GET_ROOT;

        OPEN POSIBLE_UNITS(P_ID_UNIT, L_ROOT);
        FETCH POSIBLE_UNITS BULK COLLECT INTO L_UNITS;
        CLOSE POSIBLE_UNITS;

        IF NVL(L_UNITS.COUNT,0) <> 0 THEN
            FOR I IN L_UNITS.FIRST .. L_UNITS.LAST LOOP
                L_UNIT.ID := L_UNITS(I).ID;
                L_UNIT.CORPORATION_NAME := L_UNITS(I).CORPORATION_NAME;
                PIPE ROW(L_UNIT);
            END LOOP;
        END IF;
    END;

    PROCEDURE CHANGE_HIERARCHY (P_ID_UNIT   OB_CORPORATION.ID%TYPE,
                                P_PARENT_ID OB_CORPORATION.PARENT_ID%TYPE) IS
        ------------------------------------------------------------------------------------
        L_UNIT R_UNIT;
        L_ROOT OB_CORPORATION.ID%TYPE;
        L_UNITS T_UNITS;
        ------------------------------------------------------------------------------------
        L_EXISTS BOOLEAN;
        ------------------------------------------------------------------------------------
    BEGIN
        OPEN GET_ROOT(P_ID_UNIT);
        FETCH GET_ROOT INTO L_ROOT;
        CLOSE GET_ROOT;

        OPEN POSIBLE_UNITS(P_ID_UNIT, L_ROOT);
        FETCH POSIBLE_UNITS BULK COLLECT INTO L_UNITS;
        CLOSE POSIBLE_UNITS;

        IF NVL(L_UNITS.COUNT,0) <> 0 THEN
            FOR I IN L_UNITS.FIRST .. L_UNITS.LAST LOOP
                IF P_PARENT_ID = L_UNITS(I).ID THEN
                    L_EXISTS := TRUE;
                    EXIT;
                END IF;
            END LOOP;
        END IF;

        IF L_EXISTS THEN
            UPDATE OB_CORPORATION SET PARENT_ID = P_PARENT_ID WHERE ID = P_ID_UNIT;
        ELSE
            RAISE_APPLICATION_ERROR(-20000, 'Нев?рний батьк?вський п?дрозд?л!');
        END IF;
    END;

--процедура обновлениџ счетов корпоративных клиентов(обновлџет включение в выписку, код Х¬јј, код подразделениџ, дату открытиџ и альтернат. корпорацию)
    procedure UPDATE_ACC_CORP(p_acc_corp_params T_acc_corp_params) as
      l_obpcp varchar2(500);
      l_alt_cod accountsw.TAG%type;
      res number;
      --l_obcrp varchar2(500);
    begin
      for i in p_acc_corp_params.FIRST .. p_acc_corp_params.LAST loop

        --дата открытиџ
        --IS NOT NULL(web) !
        update accounts t
           set t.daos = p_acc_corp_params(i).daos
         where t.ACC = p_acc_corp_params(i).acc;
        --выписка
        update ACCOUNTSW t
           set t.VALUE = p_acc_corp_params(i).use_invp
         where t.ACC = p_acc_corp_params(i).acc
           and t.TAG = 'CORPV';
        if SQL%rowcount = 0 then
          insert into accountsw t
            (acc, tag, value)
          values
            (p_acc_corp_params(i).acc, 'CORPV', p_acc_corp_params(i).use_invp);
        end if;

        --TRKK код
        update SPECPARAM_INT t
           set t.TYPNLS = p_acc_corp_params(i).trkk
         where t.ACC = p_acc_corp_params(i).acc;
        if SQL%rowcount = 0 then
          insert into SPECPARAM_INT t
            (acc, typnls)
          values
            (p_acc_corp_params(i).acc, p_acc_corp_params(i).trkk);
        end if;
        --get customer corp_code and inst_code
        select cw1.VALUE/*, cw2.VALUE*/ into l_obpcp--, l_obcrp
        from accounts a
        left join customerw cw1 on a.rnk = cw1.RNK and cw1.TAG = 'OBPCP'
        --left join customerw cw2 on a.rnk = cw2.RNK and cw2.TAG = 'OBCRP'
        where a.ACC = p_acc_corp_params(i).acc;

        --проверим, есть ли такое подразделение у корпорации клиента или альтернативной корпорации
        begin
          select 1 into res from V_ORG_CORPORATIONS t
          where (t.base_extid = l_obpcp or t.base_extid = p_acc_corp_params(i).alt_corp_cod)
          and rownum = 1
          and t.EXTERNAL_ID = p_acc_corp_params(i).inst_kod;
          --јод установи
          update ACCOUNTSW t
             set t.VALUE = p_acc_corp_params(i).inst_kod
           where t.ACC = p_acc_corp_params(i).acc
             and t.TAG = 'OBCORPCD';
          if SQL%rowcount = 0 then
            insert into accountsw t
              (acc, tag, value)
            values
              (p_acc_corp_params(i).acc, 'OBCORPCD', p_acc_corp_params(i).inst_kod);
          end if;
          --если не нашли - просто не добавлЯем
        exception when no_data_found then null;--raise_application_error(-20500, 'instance not found');
        end;

        --check, if alt_corp != customer's corp
        if l_obpcp != p_acc_corp_params(i).alt_corp_cod then l_alt_cod := p_acc_corp_params(i).alt_corp_cod;
          else l_alt_cod := null;
        end if;
          --альтернатива
          update ACCOUNTSW t
             set t.VALUE = l_alt_cod
           where t.ACC = p_acc_corp_params(i).acc
             and t.TAG = 'OBCORP';
          if SQL%rowcount = 0 then
            insert into accountsw t
              (acc, tag, value)
            values
              (p_acc_corp_params(i).acc,
               'OBCORP',
               l_alt_cod);
          end if;

      end loop;
    end UPDATE_ACC_CORP;

procedure corp_data_ins (
   p_session_id    ob_corporation_data.session_id%type)
as
begin
   insert into ob_corporation_data
      select *
        from ob_corporation_data_tmp
       where session_id = p_session_id;
        delete ob_corporation_data_tmp
         where session_id = p_session_id;
end;

procedure corp_data_del (
   p_session_id    ob_corporation_data.session_id%type)
as
begin
   delete ob_corporation_data_tmp
         where session_id = p_session_id;
end;

function corp_data_cnt (
   p_session_id    ob_corporation_data.session_id%type)  return number
as
l_cnt number;
begin
   select count(*) into l_cnt from  ob_corporation_data_tmp
         where session_id = p_session_id;
   return l_cnt;
end;

function get_correct_session_id (p_corporation_id number,p_ourmfo number, p_session_id number)
return number
is
l_sess_id number;
begin
    begin
    select session_id into l_sess_id from
             (select kf, corporation_id, trunc(file_date) file_date, max(session_id) session_id
                     from ob_corporation_data
                    where corporation_id=p_corporation_id and kf=p_ourmfo
                 group by kf, corporation_id, trunc(file_date))
    where  session_id=p_session_id;
          exception when no_data_found then return 0;
    end;
return 1;
end;

function get_correct_nbs (p_corporation_id number, p_nbs number)
return number
is
l_sess_id number;
l_kf ob_corporation_nbs_report.kf%type;
begin
    begin
    select distinct kf into l_kf from ob_corporation_nbs_report;
    exception when too_many_rows then
       begin
         begin
            select nbs into l_sess_id from OB_CORPORATION_NBS_REPORT_GRC
            where report_in='Y'
            and external_id=p_corporation_id and nbs=p_nbs;
         exception when no_data_found then return 0;
         end;
       return 1;
       end;
    end;

    begin
        select nbs into l_sess_id from OB_CORPORATION_NBS_REPORT
        where report_in='Y'
        and external_id=p_corporation_id and nbs=p_nbs;
    exception when no_data_found then return 0;
    end;
return 1;
end;
function get_mmfo_type return number
is
l_type mv_kf.kf%type;
begin
select kf into l_type from mv_kf;
if l_type='300465'
then return 0;
else return 1;
end if;
   exception when too_many_rows then return 0;
end;
procedure ins_customerw (p_rnk customerw.rnk%type,p_external_id varchar2, p_org_id varchar2)
is
 begin

      insert into customerw(rnk, tag, value, isp) values (p_rnk, 'OBPCP', p_external_id, 0);
      insert into customerw(rnk, tag, value, isp) values (p_rnk, 'OBCRP', p_org_id, 0);
 end;

procedure ins_nbs (p_EXTERNAL_ID varchar2,p_NBS varchar2,PREPORT_IN varchar2)
is
l_id ob_corporation.id%type;
l_name ob_corporation.CORPORATION_NAME%type;

 begin

    select id into l_id from  v_root_corporation where EXTERNAL_ID=p_EXTERNAL_ID;
    select CORPORATION_NAME into l_name from  v_root_corporation where  EXTERNAL_ID=p_EXTERNAL_ID;
    insert into OB_CORPORATION_NBS_REPORT values (l_id,p_EXTERNAL_ID,l_name,p_NBS,PREPORT_IN,f_ourmfo());

 end;

procedure ins_nbs_grc (p_EXTERNAL_ID varchar2,p_NBS varchar2,PREPORT_IN varchar2)
is
l_id ob_corporation.id%type;
l_name ob_corporation.CORPORATION_NAME%type;

 begin

    select id into l_id from  v_root_corporation where EXTERNAL_ID=p_EXTERNAL_ID;
    select CORPORATION_NAME into l_name from  v_root_corporation where  EXTERNAL_ID=p_EXTERNAL_ID;
    insert into OB_CORPORATION_NBS_REPORT_GRC values (l_id,p_EXTERNAL_ID,l_name,p_NBS,PREPORT_IN);

 end;

PROCEDURE KFILE_GET_DICT
is
l_ret           varchar2(4000);
l_start         number;
l_end           number;
l_parser        dbms_xmlparser.parser;
l_doc           dbms_xmldom.domdocument;
l_analyticlist  dbms_xmldom.domnodelist;
l_analytic      dbms_xmldom.domnode;
l_corp          ob_corporation%rowtype;

function decode_base_to_row(par varchar2) return varchar2 is
begin
  return utl_encode.text_decode(par, encoding => utl_encode.base64);
end;

function get_param_webconfig(par varchar2) return web_barsconfig.val%type is
    l_res web_barsconfig.val%type;
begin
    select val into l_res from web_barsconfig where key = par;
    return trim(l_res);
exception
    when no_data_found then
      raise_application_error(-20000,
                              'Не найден KEY=' || par ||
                              ' в таблице web_barsconfig!');
end;

function encode_base64(par varchar2) return varchar2 is
  begin
    return utl_encode.text_encode(par, encoding => utl_encode.base64);
  end;

procedure transfer_xml(ret_ out clob,p_method in varchar2,xml_body clob)
   is
    l_request  soap_rpc.t_request;
    l_response soap_rpc.t_response;
    l_tmp      xmltype;
    l_clob     clob;
function extract(p_xml       in xmltype,
                   p_xpath     in varchar2,
                   p_mandatory in number) return varchar2 is
  g_is_error     boolean := false;
  g_cur_rep_id   number := -1;
  g_cur_block_id number := -1;
  begin
    begin
      return p_xml.extract(p_xpath).getStringVal();
    exception
      when others then
        if p_mandatory is null or g_is_error then
          return null;
        else
          if sqlcode = -30625 then
            bars_error.raise_nerror('BCK',
                                    'XMLTAG_NOT_FOUND',
                                    p_xpath,
                                    g_cur_block_id,
                                    g_cur_rep_id);
          else
            raise;
          end if;
        end if;
    end;
  end;
  begin
    --подготовить реквест
    l_request := soap_rpc.new_request(p_url         => get_param_webconfig('KFILE.SendData'),
                                      p_namespace   => 'http://tempuri.org/',
                                      p_method      => p_method,
                                      p_wallet_dir  => get_param_webconfig('KFILE.Wallet_dir'),
                                      p_wallet_pass => get_param_webconfig('KFILE.Wallet_pass'));
    -- добавить параметры

  if p_method='GetDict' then
   soap_rpc.add_parameter(l_request,
                           'Data',
                            xml_body
                            );
  end if;

    -- позвать метод веб-сервиса
    l_response := soap_rpc.invoke(l_request);
     --Фикс неприятности в работе xpath при указанных xmlns
    l_clob := replace(l_response.doc.getClobVal(), 'xmlns', 'mlns');
    l_tmp  := xmltype(l_clob);
    ret_:=extract(l_tmp, '/'||p_method||'Response/'||p_method||'Result/text()', null);
  end transfer_xml;
begin
  if kfile_pack.get_mmfo_type = 1 then

   transfer_xml(l_ret,'GetDictCnt',null);

   l_parser       := dbms_xmlparser.newparser;
   dbms_xmlparser.parseclob(l_parser, decode_base_to_row(l_ret));
   l_doc          := dbms_xmlparser.getdocument(l_parser);
   l_analyticlist := dbms_xmldom.getelementsbytagname(l_doc, 'record');
   l_analytic     := dbms_xmldom.item(l_analyticlist, 0);
   dbms_xslprocessor.valueof(l_analytic, 'MIN/text()', l_start);
   dbms_xslprocessor.valueof(l_analytic, 'MAX/text()', l_end);
   dbms_xmlparser.freeparser(l_parser);
   DBMS_XMLDOM.freeDocument(l_doc);

   transfer_xml(l_ret,'GetDict',to_clob('DICT'));

    savepoint sp_before;

    l_parser := dbms_xmlparser.newparser;
    dbms_xmlparser.parseclob(l_parser, decode_base_to_row(l_ret));
    l_doc := dbms_xmlparser.getdocument(l_parser);
    l_analyticlist := dbms_xmldom.getelementsbytagname(l_doc, 'record');

    begin

    delete ob_corporation;

      for i in 0 .. dbms_xmldom.getlength(l_analyticlist) - 1
      loop
        l_analytic := dbms_xmldom.item(l_analyticlist, i);
                        dbms_xslprocessor.valueof(l_analytic, 'ID/text()', l_corp.ID);
                        dbms_xslprocessor.valueof(l_analytic, 'CC/text()', l_corp.CORPORATION_CODE);
                        dbms_xslprocessor.valueof(l_analytic, 'CN/text()', l_corp.CORPORATION_NAME);
                        dbms_xslprocessor.valueof(l_analytic, 'P/text()', l_corp.PARENT_ID);
                        dbms_xslprocessor.valueof(l_analytic, 'S/text()', l_corp.STATE_ID);
                        dbms_xslprocessor.valueof(l_analytic, 'E/text()', l_corp.EXTERNAL_ID);

      insert into ob_corporation values l_corp;

      end loop;

    exception  when others then
                rollback to sp_before; raise;
    end;
    dbms_xmlparser.freeparser(l_parser);
   DBMS_XMLDOM.freeDocument(l_doc);

    for c in l_start..l_end
    loop
    transfer_xml(l_ret,'GetDict',to_clob(c));
    l_parser := dbms_xmlparser.newparser;
    dbms_xmlparser.parseclob(l_parser, decode_base_to_row(l_ret));
    l_doc := dbms_xmlparser.getdocument(l_parser);
    l_analyticlist := dbms_xmldom.getelementsbytagname(l_doc, 'record');

    begin

      for i in 0 .. dbms_xmldom.getlength(l_analyticlist) - 1
      loop
        l_analytic := dbms_xmldom.item(l_analyticlist, i);
                        dbms_xslprocessor.valueof(l_analytic, 'ID/text()', l_corp.ID);
                        dbms_xslprocessor.valueof(l_analytic, 'CC/text()', l_corp.CORPORATION_CODE);
                        dbms_xslprocessor.valueof(l_analytic, 'CN/text()', l_corp.CORPORATION_NAME);
                        dbms_xslprocessor.valueof(l_analytic, 'P/text()', l_corp.PARENT_ID);
                        dbms_xslprocessor.valueof(l_analytic, 'S/text()', l_corp.STATE_ID);
                        dbms_xslprocessor.valueof(l_analytic, 'E/text()', l_corp.EXTERNAL_ID);

      insert into ob_corporation values l_corp;

      end loop;

    exception  when others then
                rollback to sp_before; raise;
    end;
    dbms_xmlparser.freeparser(l_parser);
    DBMS_XMLDOM.freeDocument(l_doc);

    end loop;
    end if;
end KFILE_GET_DICT;
procedure  dict_send_cnt (res_ out varchar2)
is

function encode_base64(par varchar2) return varchar2 is
  begin
    return utl_encode.text_encode(par, encoding => utl_encode.base64);
  end;
begin
select '<?xml version="1.0" encoding="windows-1251"?>' ||
              '<records>'||
              xmlagg(xmlelement("record",
                xmlelement("MIN",min),
                xmlelement("MAX",max)
              )).getclobval() ||'</records>' into res_
         from (select min(id) min,max(id)max from ob_corporation where parent_id is not null);

      res_:=encode_base64(res_);
end;

procedure  dict_send (xml_body in clob, res_ out varchar2)
is
l_id number;
l_type varchar2(4);

function encode_base64(par varchar2) return varchar2 is
  begin
    return utl_encode.text_encode(par, encoding => utl_encode.base64);
  end;
begin
l_type:=substr(xml_body,1,4);

if l_type='DICT'
then
select '<?xml version="1.0" encoding="windows-1251"?>' ||
              '<records>'||
              xmlagg(xmlelement("record",
                xmlelement("ID",ID),
                xmlelement("CC",CORPORATION_CODE),
                xmlelement("CN",CORPORATION_NAME),
                xmlelement("P",PARENT_ID),
                xmlelement("S",STATE_ID),
                xmlelement("E",EXTERNAL_ID)
              )).getclobval() ||'</records>' into res_
         from (select * from ob_corporation where parent_id is null );
res_:=encode_base64(res_);
else
l_id:=to_number(substr(xml_body,1,4));
select '<?xml version="1.0" encoding="windows-1251"?>' ||
              '<records>'||
              xmlagg(xmlelement("record",
                xmlelement("ID",ID),
                xmlelement("CC",CORPORATION_CODE),
                xmlelement("CN",CORPORATION_NAME),
                xmlelement("P",PARENT_ID),
                xmlelement("S",STATE_ID),
                xmlelement("E",EXTERNAL_ID)
              )).getclobval() ||'</records>' into res_
         from (select * from ob_corporation where parent_id is not null and id=l_id);
res_:=encode_base64(res_);
end if;
end;
PROCEDURE KFILE_GET (xml_body CLOB, res_ OUT varchar2)
IS
        n number:=0;
        l_parser        dbms_xmlparser.parser;
        l_doc           dbms_xmldom.domdocument;
        l_analyticlist  dbms_xmldom.DOMNodeList;
        l_analytic      dbms_xmldom.DOMNode;
        l_corp          ob_corporation_data%rowtype;
        l_dat               varchar(200);


function decode_base_to_row(par varchar2) return varchar2 is
begin
  return utl_encode.text_decode(par, encoding => utl_encode.base64);
end;

BEGIN
  execute immediate 'alter session set ddl_lock_timeout=30';

  l_parser := dbms_xmlparser.newparser;
  dbms_xmlparser.parseclob(l_parser, decode_base_to_row(xml_body));
  l_doc := dbms_xmlparser.getdocument(l_parser);
  l_analyticlist := dbms_xmldom.getelementsbytagname(l_doc, 'record');

    begin
         savepoint sp_before;

      for i in 0 .. dbms_xmldom.getlength(l_analyticlist) - 1
      loop
        l_analytic := dbms_xmldom.item(l_analyticlist, i);
                        dbms_xslprocessor.valueof(l_analytic, 'CORPORATION_ID/text()', l_corp.CORPORATION_ID);
                        dbms_xslprocessor.valueof(l_analytic, 'FILE_DATE/text()', l_dat);
                        l_corp.file_date:=to_Date(l_dat,'DDMMYYYY');
                        dbms_xslprocessor.valueof(l_analytic, 'ROWTYPE/text()', l_corp.ROWTYPE);
                        dbms_xslprocessor.valueof(l_analytic, 'KF/text()', l_corp.KF);
                        dbms_xslprocessor.valueof(l_analytic, 'NLS/text()', l_corp.NLS);
                        dbms_xslprocessor.valueof(l_analytic, 'KV/text()', l_corp.KV);
                        dbms_xslprocessor.valueof(l_analytic, 'OKPO/text()', l_corp.OKPO);
                        dbms_xslprocessor.valueof(l_analytic, 'OBDB/text()', l_corp.OBDB);
                        dbms_xslprocessor.valueof(l_analytic, 'OBDBQ/text()', l_corp.OBDBQ);
                        dbms_xslprocessor.valueof(l_analytic, 'OBKR/text()', l_corp.OBKR);
                        dbms_xslprocessor.valueof(l_analytic, 'OBKRQ/text()', l_corp.OBKRQ);
                        dbms_xslprocessor.valueof(l_analytic, 'OST/text()', l_corp.OST);
                        dbms_xslprocessor.valueof(l_analytic, 'OSTQ/text()', l_corp.OSTQ);
                        dbms_xslprocessor.valueof(l_analytic, 'KOD_CORP/text()', l_corp.KOD_CORP);
                        dbms_xslprocessor.valueof(l_analytic, 'KOD_USTAN/text()', l_corp.KOD_USTAN);
                        dbms_xslprocessor.valueof(l_analytic, 'KOD_ANALYT/text()', l_corp.KOD_ANALYT);
                        dbms_xslprocessor.valueof(l_analytic, 'DAPP/text()',l_dat);
                        l_corp.DAPP:=to_Date(l_dat,'DDMMYYYY');
                        dbms_xslprocessor.valueof(l_analytic, 'POSTDAT/text()', l_dat);
                        l_corp.POSTDAT:=to_Date(l_dat,'DDMMYYYY');
                        dbms_xslprocessor.valueof(l_analytic, 'DOCDAT/text()', l_dat);
                        l_corp.DOCDAT:=to_Date(l_dat,'DDMMYYYY');
                        dbms_xslprocessor.valueof(l_analytic, 'VALDAT/text()',l_dat);
                        l_corp.VALDAT:=to_Date(l_dat,'DDMMYYYY');
                        dbms_xslprocessor.valueof(l_analytic, 'ND/text()', l_corp.ND);
                        dbms_xslprocessor.valueof(l_analytic, 'VOB/text()', l_corp.VOB);
                        dbms_xslprocessor.valueof(l_analytic, 'DK/text()', l_corp.DK);
                        dbms_xslprocessor.valueof(l_analytic, 'MFOA/text()', l_corp.MFOA);
                        dbms_xslprocessor.valueof(l_analytic, 'NLSA/text()', l_corp.NLSA);
                        dbms_xslprocessor.valueof(l_analytic, 'KVA/text()', l_corp.KVA);
                        dbms_xslprocessor.valueof(l_analytic, 'NAMA/text()', l_corp.NAMA);
                        dbms_xslprocessor.valueof(l_analytic, 'OKPOA/text()', l_corp.OKPOA);
                        dbms_xslprocessor.valueof(l_analytic, 'MFOB/text()', l_corp.MFOB);
                        dbms_xslprocessor.valueof(l_analytic, 'NLSB/text()', l_corp.NLSB);
                        dbms_xslprocessor.valueof(l_analytic, 'KVB/text()', l_corp.KVB);
                        dbms_xslprocessor.valueof(l_analytic, 'NAMB/text()', l_corp.NAMB);
                        dbms_xslprocessor.valueof(l_analytic, 'OKPOB/text()', l_corp.OKPOB);
                        dbms_xslprocessor.valueof(l_analytic, 'S/text()', l_corp.S);
                        dbms_xslprocessor.valueof(l_analytic, 'DOCKV/text()', l_corp.DOCKV);
                        dbms_xslprocessor.valueof(l_analytic, 'SQ/text()', l_corp.SQ);
                        dbms_xslprocessor.valueof(l_analytic, 'NAZN/text()', l_corp.NAZN);
                        dbms_xslprocessor.valueof(l_analytic, 'DOCTYPE/text()', l_corp.DOCTYPE);
                        dbms_xslprocessor.valueof(l_analytic, 'POSTTIME/text()', l_dat);
                        l_corp.POSTTIME:=null;--нужно допилить
                        dbms_xslprocessor.valueof(l_analytic, 'NAMK/text()', l_corp.NAMK);
                        dbms_xslprocessor.valueof(l_analytic, 'NMS/text()', l_corp.NMS);
                        dbms_xslprocessor.valueof(l_analytic, 'TT/text()', l_corp.TT);
                        dbms_xslprocessor.valueof(l_analytic, 'SESSION_ID/text()', l_corp.SESSION_ID);

      bc.go('/');

      if i=0 then
      insert into ob_corporation_session(id,kf,file_date,file_corporation_id,state_id,sys_time,sync_type)
      values (l_corp.SESSION_ID,l_corp.KF,l_corp.file_date,null,0,sysdate,'DATA');
      end if;

      insert into ob_corporation_data values l_corp;

      end loop;

    exception when dup_val_on_index then
                null;
              when others then
                rollback to sp_before;
                res_:=substr(SQLERRM, 1, 4000);
    end;

   dbms_xmlparser.freeparser(l_parser);
   DBMS_XMLDOM.freeDocument(l_doc);

END KFILE_GET;
PROCEDURE KFILE_SEND(p_date in varchar2, p_corp_code varchar2)
is
l_xml_body  clob;
l_ret       varchar2(4000);
l_corp_code varchar2(10);
l_sync      number;

  function get_param_webconfig(par varchar2) return web_barsconfig.val%type is
    l_res web_barsconfig.val%type;
  begin
    select val into l_res from web_barsconfig where key = par;
    return trim(l_res);
  exception
    when no_data_found then
      raise_application_error(-20000,
                              'Не найден KEY=' || par ||
                              ' в таблице web_barsconfig!');
  end;

function encode_base64(par varchar2) return varchar2 is
  begin
    return utl_encode.text_encode(par, encoding => utl_encode.base64);
  end;

procedure transfer_xml(xml_body clob, ret_ out clob)
   is
    l_request  soap_rpc.t_request;
    l_response soap_rpc.t_response;
    l_tmp      xmltype;
    l_message  varchar2(4000);
    l_clob     clob;
function extract(p_xml       in xmltype,
                   p_xpath     in varchar2,
                   p_mandatory in number) return varchar2 is
  g_is_error     boolean := false;
  g_cur_rep_id   number := -1;
  g_cur_block_id number := -1;
  begin
    begin
      return p_xml.extract(p_xpath).getStringVal();
    exception
      when others then
        if p_mandatory is null or g_is_error then
          return null;
        else
          if sqlcode = -30625 then
            bars_error.raise_nerror('BCK',
                                    'XMLTAG_NOT_FOUND',
                                    p_xpath,
                                    g_cur_block_id,
                                    g_cur_rep_id);
          else
            raise;
          end if;
        end if;
    end;
  end;
  begin
    --подготовить реквест
    l_request := soap_rpc.new_request(p_url         => get_param_webconfig('KFILE.SendData'),
                                      p_namespace   => 'http://tempuri.org/',
                                      p_method      => 'SendData',
                                      p_wallet_dir  => get_param_webconfig('KFILE.Wallet_dir'),
                                      p_wallet_pass => get_param_webconfig('KFILE.Wallet_pass'));
    -- добавить параметры
    soap_rpc.add_parameter(l_request,
                           'Data',
                            xml_body
                            );
    -- позвать метод веб-сервиса
    l_response := soap_rpc.invoke(l_request);
     --Фикс неприятности в работе xpath при указанных xmlns
    l_clob := replace(l_response.doc.getClobVal(), 'xmlns', 'mlns');
    l_tmp  := xmltype(l_clob);
    ret_:=extract(l_tmp, '/SendDataResponse/SendDataResult/text()', null);

  end transfer_xml;
begin

  if (p_corp_code is null) then
    l_corp_code := '%';
  else
    l_corp_code := p_corp_code;
  end if;

  p_lic26_kfile_mmfo(p_s=>to_date(p_date, 'DDMMYYYY'),


                     p_corpc=>l_corp_code,
                     p_sync=>l_sync);

  if kfile_pack.get_mmfo_type = 1 then

     for c in (select * from ob_corporation_data where session_id=l_sync) loop
       select '<?xml version="1.0" encoding="windows-1251"?>' ||
              '<records>'||
              xmlagg(xmlelement("record",
                xmlelement("CORPORATION_ID",c.CORPORATION_ID),
                xmlelement("FILE_DATE",to_char(trunc(c.FILE_DATE),'DDMMYYYY')),
                xmlelement("ROWTYPE",c.ROWTYPE),
                xmlelement("KF",c.KF),
                xmlelement("NLS",c.NLS),
                xmlelement("KV",c.KV),
                xmlelement("OKPO",c.OKPO),
                xmlelement("OBDB",c.OBDB),
                xmlelement("OBDBQ",c.OBDBQ),
                xmlelement("OBKR",c.OBKR),
                xmlelement("OBKRQ",c.OBKRQ),
                xmlelement("OST",c.OST),
                xmlelement("OSTQ",c.OSTQ),
                xmlelement("KOD_CORP",c.KOD_CORP),
                xmlelement("KOD_USTAN",c.KOD_USTAN),
                xmlelement("KOD_ANALYT",c.KOD_ANALYT),
                xmlelement("DAPP",to_char(trunc(c.dapp),'DDMMYYYY')),
                xmlelement("POSTDAT",to_char(trunc(c.postdat),'DDMMYYYY')),
                xmlelement("DOCDAT",to_char(trunc(c.docdat),'DDMMYYYY')),
                xmlelement("VALDAT",to_char(trunc(c.valdat),'DDMMYYYY')),
                xmlelement("ND",c.ND),
                xmlelement("VOB",c.VOB),
                xmlelement("DK",c.DK),
                xmlelement("MFOA",c.MFOA),
                xmlelement("NLSA",c.NLSA),
                xmlelement("KVA",c.KVA),
                xmlelement("NAMA",c.NAMA),
                xmlelement("OKPOA",c.OKPOA),
                xmlelement("MFOB",c.MFOB),
                xmlelement("NLSB",c.NLSB),
                xmlelement("KVB",c.KVB),
                xmlelement("NAMB",c.NAMB),
                xmlelement("OKPOB",c.OKPOB),
                xmlelement("S",c.S),
                xmlelement("DOCKV",c.DOCKV),
                xmlelement("SQ",c.SQ),
                xmlelement("NAZN",c.NAZN),
                xmlelement("DOCTYPE",c.DOCTYPE),
                xmlelement("POSTTIME",to_char(c.POSTTIME,'DDMMYYYYHHMM')),
                xmlelement("NAMK",c.NAMK),
                xmlelement("NMS",c.NMS),
                xmlelement("TT",c.TT),
                xmlelement("SESSION_ID",c.SESSION_ID)
              )).getclobval() ||'</records>' into l_xml_body
         from dual;
          begin

           transfer_xml(encode_base64(l_xml_body), l_ret);

          if l_ret is not null then
            raise_application_error (-20000, l_ret);
          end if;
          end;

     end loop;

  end if;

end KFILE_SEND;
BEGIN
   -- Initialization
   NULL;
END KFILE_PACK;
/
 show err;
 
PROMPT *** Create  grants  KFILE_PACK ***
grant DEBUG,EXECUTE                                                          on KFILE_PACK      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on KFILE_PACK      to CORP_CLIENT;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/kfile_pack.sql =========*** End *** 
 PROMPT ===================================================================================== 
 