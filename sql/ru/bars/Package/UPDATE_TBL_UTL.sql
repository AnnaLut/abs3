PROMPT =====================================================================================
PROMPT *** Run *** ============= Scripts /Sql/BARS/package/update_tbl_utl.sql ============***
PROMPT =====================================================================================

CREATE OR REPLACE PACKAGE BARS.UPDATE_TBL_UTL
is

    -----------------------------------------------------------------
    --
    --   Пакет утилит для проверки наличия расхождений между оперативными
    --   таблицами и соответствующими update таблицами
    --
    --   Расхождения могут возникать в случае отключения триггеров или прамых добавлений/изменений в update таблицах
    --   
    --   created: Mykhalevich (13.02.2018)
    --
    -- version 1.0 13.02.2018 (Mykhalevich) Добавлены функции для таблиц:
    --                        ACCOUNTS    <-> ACCOUNTS_UPDATE
    --                        DPT_DEPOSIT <-> DPT_DEPOSIT_CLOS
    --                        CUSTOMERW   <-> CUSTOMERW_UPDATE
    --                        ACCOUNTSW   <-> ACCOUNTSW_UPDATE
    --                        ND_TXT      <-> ND_TXT_UPDATE
    --                        W4_ACC      <-> W4_ACC_UPDATE
    --                        BPK_ACC     <-> BPK_ACC_UPDATE
    -----------------------------------------------------------------

    G_HEADER_VERSION      constant varchar2(64)  := 'version 1.0 13.02.2018';

    ----------------------------------------------------------------
    -- HEADER_VERSION()
    -- Функция возвращает строку с версией заголовка пакета
    function header_version return varchar2;

    -----------------------------------------------------------------
    -- BODY_VERSION()
    -- Функция возвращает строку с версией тела пакета
    function body_version return varchar2;

    --------------------------------------------------------------------------------------------------------------------
    -- ACCOUNTS_UPDATE
    -- Проверяет наличие расхождений между таблицами ACCOUNTS <-> ACCOUNTS_UPDATE
    -- Данные в последней записи (по IDUPD) в ACCOUNTS_UPDATE должны соответствовать данным в ACCOUNTS
    --  количество расхождений сохраняется в UPDATE_TBL_STAT в разрезе полей
    -- Не исправляется ситуация, когда в BARS.ACCOUNTS_UPDATE запись есть, а в ACCOUNTS - нет (такого быть не должно)
    --   и поскольку данные могли быть переданы в ХД или попасть в отчеты необходимо эти кейсы разбирать отдельно
    --------------------------------------------------------------------------------------------------------------------
    procedure CHECK_ACCOUNTS_UPDATE;                                                    --9001
    procedure SYNC_ACCOUNTS_UPDATE( p_id out number, p_rowcount out number);            --9101

    --------------------------------------------------------------------------------------------------------------------
    -- DPT_DEPOSIT_CLOS
    -- если есть запись в DPT_DEPOSIT_CLOS и нет в DPT_DEPOSIT - ничего не делаем, хотя в DPT_DEPOSIT_CLOS может отсутствовать факт переноса в архив
    -- если есть запись в DPT_DEPOSIT и нет в DPT_DEPOSIT_CLOS - также ничего не делаем, хотя нужно было-бы добавить заись с action_id=0
    -- поэтому проверяем расхождения только если записи есть в обеих таблицах
    --------------------------------------------------------------------------------------------------------------------
    procedure CHECK_DPT_DEPOSIT_CLOS;                                                   --9002
    procedure SYNC_DPT_DEPOSIT_CLOS( p_id out number, p_rowcount out number);           --9102

    --------------------------------------------------------------------------------------------------------------------
    -- CUSTOMERW_UPDATE
    --------------------------------------------------------------------------------------------------------------------
    procedure CHECK_CUSTOMERW_UPDATE;                                                   --9004
    procedure SYNC_CUSTOMERW_UPDATE( p_id out number, p_rowcount out number);           --9104
    procedure SYNC_CUSTOMERW_UPDATE_DWH( p_id OUT NUMBER, p_rowcount OUT NUMBER);       --9104

    --------------------------------------------------------------------------------------------------------------------
    -- ACCOUNTSW_UPDATE
    --------------------------------------------------------------------------------------------------------------------
    procedure CHECK_ACCOUNTSW_UPDATE;                                                   --9015
    procedure SYNC_ACCOUNTSW_UPDATE( p_id out number, p_rowcount out number);           --9115
    procedure SYNC_ACCOUNTSW_UPDATE_DWH( p_id out number, p_rowcount out number);       --9115

    --------------------------------------------------------------------------------------------------------------------
    -- ND_TXT_UPDATE
    --------------------------------------------------------------------------------------------------------------------
    procedure CHECK_ND_TXT_UPDATE;                                                      --9016
    procedure SYNC_ND_TXT_UPDATE( p_id out number, p_rowcount out number);              --9116
    procedure SYNC_ND_TXT_UPDATE_DWH( p_id out number, p_rowcount out number);          --9116

    --------------------------------------------------------------------------------------------------------------------
    -- W4_ACC_UPDATE
    --------------------------------------------------------------------------------------------------------------------
    procedure CHECK_W4_ACC_UPDATE;                                                      --9022
    procedure SYNC_W4_ACC_UPDATE( p_id out number, p_rowcount out number);              --9122

    --------------------------------------------------------------------------------------------------------------------
    -- BPK_ACC_UPDATE
    --------------------------------------------------------------------------------------------------------------------
    procedure CHECK_BPK_ACC_UPDATE;                                                     --9023
    procedure SYNC_BPK_ACC_UPDATE( p_id out number, p_rowcount out number);             --9123

end;
/

CREATE OR REPLACE PACKAGE BODY BARS.UPDATE_TBL_UTL
IS
    G_BODY_VERSION       constant varchar2(64) := 'version 1.0 13.02.2018';
    G_TRACE              constant varchar2(20) := 'BARS.UPDATE_TBL_UTL.';
    G_MODULE             constant varchar2(3)  := 'UPL';

    G_STAT_FILE_ID       constant varchar2(50) := 'STAT_FILE_ID';
    G_STAT_JOB_ID        constant varchar2(50) := 'STAT_JOB_ID';
    G_STAT_GROUP_ID      constant varchar2(50) := 'STAT_GROUP_ID';

    G_RUN_ID             BARS.UPDATE_TBL_STAT.RUN_ID%TYPE;  -- ID процесса
    G_START_DT           date;                              -- Время старта процесса
    G_END_DT             date;                              -- Время окончания процесса
    G_STAT_ID            BARS.UPDATE_TBL_STAT.STAT_ID%TYPE; -- ID из barsupl.upl_stats, если запущено из АРМ "Вивантаження данних"
    G_LOGNAME            BARS.STAFF$BASE.LOGNAME%TYPE := 'BARSUPL';   -- Логин пользователя, от которого будет проводится синхронизация

    -----------------------------------------------------------------
    -- HEADER_VERSION()
    -- Функция возвращает строку с версией заголовка пакета
    function header_version return varchar2 is
    begin
       return 'package header UPDATE_TBL_UTL: ' || G_HEADER_VERSION;
    end header_version;

    ---------------------------------------------------------------
    -- BODY_VERSION()
    -- Функция возвращает строку с версией тела пакета
    function body_version return varchar2 is
    begin
       return 'package body UPDATE_TBL_UTL ' || G_BODY_VERSION;
    end body_version;

    ---------------------------------------------------------------
    -- INS_STAT()
    --     p_FIELD_NAME - 
    --     p_FIELD_TYPE - 
    --     p_value      - 
    --     p_tbl        - 
    --
    -- НАЗНАЧЕНИЕ+ОПИСАНИЕ РАБОТЫ+УСЛОВИЯ
    procedure INS_STAT(p_FIELD_NAME in varchar2,
                       p_FIELD_TYPE in varchar2,
                       p_value      in varchar2,
                       p_tbl        in varchar2)
    is
        l_id           BARS.UPDATE_TBL_STAT.ID%TYPE;
        l_trace        varchar2(500) := G_TRACE || 'ins_stat: ';
        pragma autonomous_transaction;
    BEGIN
        if G_RUN_ID is null
        then
           raise_application_error(-20000, l_trace || 'Process is not started.');
        end if;

        l_id := BARS.S_UPDATE_TBL_STAT.NEXTVAL;
        begin
            G_STAT_ID := to_number(BARSUPL.BARS_UPLOAD.get_param(G_STAT_FILE_ID));
        exception
            when others
            then
                if sqlcode = -06502
                then
                    G_STAT_ID := null;
                end if;
        end;

        INSERT INTO BARS.UPDATE_TBL_STAT(ID,
                                         STAT_ID,
                                         FIELD_NAME,
                                         FIELD_TYPE,
                                         VALUE,
                                         RUN_ID,
                                         STARTDATE,
                                         ENDDATE,
                                         TBL_NAME,
                                         KF)
             VALUES (l_id,
                     G_STAT_ID,
                     p_FIELD_NAME,
                     p_FIELD_TYPE,
                     p_value,
                     G_RUN_ID,
                     G_START_DT,
                     G_END_DT,
                     p_tbl,
                     bars.gl.kf);

        if lower(p_FIELD_NAME) = 'end_process'
        then
            UPDATE BARS.UPDATE_TBL_STAT dt
               SET DT.ENDDATE = G_END_DT
             WHERE DT.RUN_ID = G_RUN_ID;
        end if;

        COMMIT;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            raise;
    END;

    procedure start_process(p_tbl_name   in varchar2,
                            p_oper_type  in varchar2)
    is
        l_trace                       varchar2(500) := G_TRACE || 'start_process: ';
    begin
        --if G_RUN_ID is not null
        --then
        --   raise_application_error(-20000, l_trace || 'Process RUN_ID=' || to_char(G_RUN_ID) || ' is started.');
        --end if;
        G_RUN_ID   := BARS.S_UPDATE_TBL_STAT.NEXTVAL;
        G_START_DT := sysdate;

        INS_STAT('start_process',
                 p_oper_type,
                 null,
                 p_tbl_name);
    end;

    procedure end_process(p_tbl_name   in varchar2,
                          p_oper_type  in varchar2)
    is
        l_trace                       varchar2(500) := G_TRACE || 'end_process: ';
        l_errm                        varchar2(1000);
    begin
        if G_RUN_ID is null
        then
           raise_application_error(-20000, l_trace || 'Process is not started.');
        end if;
        G_END_DT := sysdate;

        INS_STAT('end_process',
                 p_oper_type,
                 null,
                 p_tbl_name);

        G_RUN_ID   := null;
        G_END_DT   := null;
        G_START_DT := null;
        G_STAT_ID  := null;
    end;

    procedure error_process(p_tbl_name   in varchar2,
                            p_oper_type  in varchar2,
                            p_errmess    in varchar2)
    is
        l_trace                       varchar2(500) := G_TRACE || 'error_process: ';
        l_stat_id                     number;
        l_err                         varchar2(1000);
    begin
        INS_STAT('error_process',
                 p_oper_type,
                 null,
                 p_tbl_name);

        bars.bars_audit.error(l_trace || ' ошибочное завершение проверки (' || p_tbl_name || ') UPDATE_TBL_STAT.ID=' || to_char(G_RUN_ID) || ' : ' || p_errmess);
        end_process(p_tbl_name,
                    p_oper_type);
    end;

    --------------------------------------------------------------------------------------------------------------------
    -- CHECK_ACCOUNTS_UPDATE
    --------------------------------------------------------------------------------------------------------------------
    PROCEDURE CHECK_ACCOUNTS_UPDATE
    IS
        l_tbl_name                    VARCHAR2(100) := 'ACCOUNTS_UPDATE';
        l_trace                       varchar2(500) := G_TRACE || 'CHECK_ACCOUNTS_UPDATE: ';
    BEGIN
        start_process(l_tbl_name, 'CHECK');

        INSERT INTO BARS.UPDATE_TBL_STAT(ID,
                                         STAT_ID,
                                         FIELD_NAME,
                                         FIELD_TYPE,
                                         VALUE,
                                         RUN_ID,
                                         STARTDATE,
                                         ENDDATE,
                                         TBL_NAME)
            SELECT BARS.S_UPDATE_TBL_STAT.NEXTVAL,
                   G_STAT_ID,
                   DECODE(t_pivot.i,
                          30, fld30,
                          1,  fld1,   2, fld2,    3,  fld3,   4, fld4,
                          5,  fld5,   6, fld6,    7,  fld7,   8, fld8,
                          9,  fld9,   10, fld10,  11, fld11,  12, fld12,
                          13, fld13,  14, fld14,  15, fld15,  16, fld16,
                          17, fld17,  18, fld18,  19, fld19,  20, fld20,
                          21, fld21,  22, fld22,  23, fld23,  24, fld24,
                          25, fld25,  26, fld26,  27, fld27,  28, fld28,
                          29, fld29)                       AS field,
                   'count_diff' type1,
                   DECODE(t_pivot.i,
                          30, decode(c30, null, 0, c30),
                          1,  c1,   2,  c2,   3,  c3,   4,  c4,
                          5,  c5,   6,  c6,   7,  c7,   8,  c8,
                          9,  c9,   10, c10,  11, c11,  12, c12,
                          13, c13,  14, c14,  15, c15,  16, c16,
                          17, c17,  18, c18,  19, c19,  20, c20,
                          21, c21,  22, c22,  23, c23,  24, c24,
                          25, c25,  26, c26,  27, c27,  28, c28,
                          29, c29)  AS CNT,
                   G_RUN_ID,
                   G_START_DT,
                   G_END_DT,
                   l_tbl_name
              FROM (    SELECT ROWNUM AS i
                          FROM DUAL
                    CONNECT BY LEVEL <= 30) t_pivot,
                   (SELECT /*+ no_index(acu PK_ACCOUNTSUPD) */
                          'TOTAL_ROWS' fld30,  SUM(1) c30,
                           'acc' fld1,         SUM(DECODE(ac.acc, acu.acc, 0, 1)) c1,
                           'KF' fld2,          SUM(DECODE(ac.KF, acu.KF, 0, 1)) c2,
                           'NLS' fld3,         SUM(DECODE(ac.NLS, acu.NLS, 0, 1)) c3,
                           'KV' fld4,          SUM(DECODE(ac.KV, acu.KV, 0, 1)) c4,
                           'BRANCH' fld5,      SUM(DECODE(ac.BRANCH, acu.BRANCH, 0, 1)) c5,
                           'NLSALT' fld6,      SUM(DECODE(ac.NLSALT, acu.NLSALT, 0, 1)) c6,
                           'NBS' fld7,         SUM(DECODE(ac.NBS, acu.NBS, 0, 1)) c7,
                           'NBS2' fld8,        SUM(DECODE(ac.NBS2, acu.NBS2, 0, 1)) c8,
                           'DAOS' fld9,        SUM(DECODE(ac.DAOS, acu.DAOS, 0, 1)) c9,
                           'ISP' fld10,        SUM(DECODE(ac.ISP, acu.ISP, 0, 1)) c10,
                           'NMS' fld11,        SUM(DECODE(ac.NMS, acu.NMS, 0, 1)) c11,
                           'LIM' fld12,        SUM(DECODE(ac.LIM, acu.LIM, 0, 1)) c12,
                           'PAP' fld13,        SUM(DECODE(ac.PAP, acu.PAP, 0, 1)) c13,
                           'TIP' fld14,        SUM(DECODE(ac.TIP, acu.TIP, 0, 1)) c14,
                           'VID' fld15,        SUM(DECODE(ac.VID, acu.VID, 0, 1)) c15,
                           'MDATE' fld16,      SUM(DECODE(ac.MDATE, acu.MDATE, 0, 1)) c16,
                           'DAZS' fld17,       SUM(DECODE(ac.DAZS, acu.DAZS, 0, 1)) c17,
                           'ACCC' fld18,       SUM(DECODE(ac.ACCC, acu.ACCC, 0, 1)) c18,
                           'BLKD' fld19,       SUM(DECODE(ac.BLKD, acu.BLKD, 0, 1)) c19,
                           'BLKK' fld20,       SUM(DECODE(ac.BLKK, acu.BLKK, 0, 1)) c20,
                           'POS' fld21,        SUM(DECODE(ac.POS, acu.POS, 0, 1)) c21,
                           'SECI' fld22,       SUM(DECODE(ac.SECI, acu.SECI, 0, 1)) c22,
                           'SECO' fld23,       SUM(DECODE(ac.SECO, acu.SECO, 0, 1)) c23,
                           'GRP' fld24,        SUM(DECODE(ac.GRP, acu.GRP, 0, 1)) c24,
                           'OSTX' fld25,       SUM(DECODE(ac.OSTX, acu.OSTX, 0, 1)) c25,
                           'RNK' fld26,        SUM(DECODE(ac.RNK, acu.RNK, 0, 1)) c26,
                           'TOBO' fld27,       SUM(DECODE(ac.TOBO, acu.TOBO, 0, 1)) c27,
                           'OB22' fld28,       SUM(DECODE(ac.OB22, acu.OB22, 0, 1)) c28,
                           'SEND_SMS' fld29,   SUM(DECODE(ac.SEND_SMS, acu.SEND_SMS, 0, 1)) c29
                      FROM BARS.ACCOUNTS ac
                      LEFT JOIN BARS.ACCOUNTS_UPDATE acu ON (ac.acc = acu.acc AND ac.kf = acu.kf)
                     WHERE (DECODE(ac.acc, acu.acc, 1, 0) = 0
                         OR DECODE(ac.KF, acu.KF, 1, 0) = 0
                         OR DECODE(ac.NLS, acu.NLS, 1, 0) = 0
                         OR DECODE(ac.KV, acu.KV, 1, 0) = 0
                         OR DECODE(ac.BRANCH, acu.BRANCH, 1, 0) = 0
                         OR DECODE(ac.NLSALT, acu.NLSALT, 1, 0) = 0
                         OR DECODE(ac.NBS, acu.NBS, 1, 0) = 0
                         OR DECODE(ac.NBS2, acu.NBS2, 1, 0) = 0
                         OR DECODE(ac.DAOS, acu.DAOS, 1, 0) = 0
                         OR DECODE(ac.ISP, acu.ISP, 1, 0) = 0
                         OR DECODE(ac.NMS, acu.NMS, 1, 0) = 0
                         OR DECODE(ac.LIM, acu.LIM, 1, 0) = 0
                         OR DECODE(ac.PAP, acu.PAP, 1, 0) = 0
                         OR DECODE(ac.TIP, acu.TIP, 1, 0) = 0
                         OR DECODE(ac.VID, acu.VID, 1, 0) = 0
                         OR DECODE(ac.MDATE, acu.MDATE, 1, 0) = 0
                         OR DECODE(ac.DAZS, acu.DAZS, 1, 0) = 0
                         OR DECODE(ac.ACCC, acu.ACCC, 1, 0) = 0
                         OR DECODE(ac.BLKD, acu.BLKD, 1, 0) = 0
                         OR DECODE(ac.BLKK, acu.BLKK, 1, 0) = 0
                         OR DECODE(ac.POS, acu.POS, 1, 0) = 0
                         OR DECODE(ac.SECI, acu.SECI, 1, 0) = 0
                         OR DECODE(ac.SECO, acu.SECO, 1, 0) = 0
                         OR DECODE(ac.GRP, acu.GRP, 1, 0) = 0
                         OR DECODE(ac.OSTX, acu.OSTX, 1, 0) = 0
                         OR DECODE(ac.RNK, acu.RNK, 1, 0) = 0
                         OR DECODE(ac.TOBO, acu.TOBO, 1, 0) = 0
                         OR DECODE(ac.OB22, acu.OB22, 1, 0) = 0
                         OR DECODE(ac.SEND_SMS, acu.SEND_SMS, 1, 0) = 0)
                       and acu.IDUPD IN (  SELECT /*+ no_index(upd2 PK_ACCOUNTSUPD) */
                                                  MAX(upd2.IDUPD)
                                             FROM BARS.ACCOUNTS_UPDATE upd2
                                            where upd2.kf = bars.gl.kf
                                            GROUP BY upd2.acc)
                       AND ac.KF = bars.gl.kf);
        end_process(l_tbl_name, 'CHECK');
        COMMIT;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            error_process(l_tbl_name, 'ERR', substr(dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace(), 1, 1000) );
            RAISE;
    END;

    --------------------------------------------------------------------------------------------------------------------
    -- SYNC_ACCOUNTS_UPDATE
    --------------------------------------------------------------------------------------------------------------------
    PROCEDURE SYNC_ACCOUNTS_UPDATE ( p_id out number, p_rowcount out number)
    IS
        l_tbl_name                    VARCHAR2(100) := 'ACCOUNTS_UPDATE';
        l_trace                       varchar2(500) := G_TRACE || 'SYNC_ACCOUNTS_UPDATE: ';
        l_staff_id                    bars.staff$base.id%type;
        l_staff_nm                    bars.staff$base.logname%type;
    BEGIN
        start_process(l_tbl_name, 'SYNC');
        SELECT id, logname into l_staff_id, l_staff_nm FROM bars.staff$base WHERE logname = G_LOGNAME;
        INSERT /*+ APPEND */
              INTO  BARS.ACCOUNTS_UPDATE(IDUPD, CHGACTION, CHGDATE, EFFECTDATE, DONEBY,
                                         ACC, NLS, NLSALT, KV, NBS, NBS2, DAOS, ISP, NMS, PAP, VID, DAZS, BLKD, BLKK, POS, TIP,
                                         GRP, SECI, SECO, LIM, ACCC, TOBO, BRANCH, MDATE, OSTX, SEC, RNK, KF, SEND_SMS, OB22,
                                         GLOBALBD)
            SELECT /*+ no_index(u PK_ACCOUNTSUPD) */ /*    PARALLEL */
                  bars_sqnc.get_nextval('S_ACCOUNTS_UPDATE', COALESCE(a.KF, u.KF)) IDUPD,
                  CASE
                      WHEN u.dazs IS     NULL AND a.dazs IS NOT NULL THEN 3             -- closed
                      WHEN u.dazs IS NOT NULL AND a.dazs IS     NULL THEN 0             -- reopen
                      WHEN u.acc IS NULL THEN 2                                         -- create
                      WHEN u.daos <> a.daos THEN 4                                      --"DAOS was changed"
                      ELSE 2
                  END AS CHGACTION,
                  SYSDATE AS CHGDATE,
                  CASE
                      WHEN u.acc IS NULL THEN GREATEST(a.daos, NVL(a.dazs, TO_DATE('01.01.1001', 'dd.mm.yyyy')))
                      WHEN u.dazs IS NOT NULL AND a.dazs IS     NULL THEN u.dazs        -- reopen
                      WHEN u.dazs IS     NULL AND a.dazs IS NOT NULL THEN a.dazs        -- closed
                      WHEN u.daos <> a.daos THEN GREATEST(u.daos, a.daos)               -- "DAOS was changed"
                      ELSE bars.gl.bd
                  END AS EFFECTDATE,
                  l_staff_nm,
                  DECODE(a.acc, NULL, u.acc, a.acc),
                  DECODE(a.acc, NULL, u.NLS, a.NLS),
                  DECODE(a.acc, NULL, u.NLSALT, a.NLSALT),
                  DECODE(a.acc, NULL, u.KV, a.KV),
                  DECODE(a.acc, NULL, u.NBS, a.NBS),
                  DECODE(a.acc, NULL, u.NBS2, a.NBS2),
                  DECODE(a.acc, NULL, u.DAOS, a.DAOS),
                  DECODE(a.acc, NULL, u.ISP, a.ISP),
                  DECODE(a.acc, NULL, u.NMS, a.NMS),
                  DECODE(a.acc, NULL, u.PAP, a.PAP),
                  DECODE(a.acc, NULL, u.VID, a.VID),
                  DECODE(a.acc, NULL, u.DAZS, a.DAZS),
                  DECODE(a.acc, NULL, u.BLKD, a.BLKD),
                  DECODE(a.acc, NULL, u.BLKK, a.BLKK),
                  DECODE(a.acc, NULL, u.POS, a.POS),
                  DECODE(a.acc, NULL, u.TIP, a.TIP),
                  DECODE(a.acc, NULL, u.GRP, a.GRP),
                  DECODE(a.acc, NULL, u.SECI, a.SECI),
                  DECODE(a.acc, NULL, u.SECO, a.SECO),
                  DECODE(a.acc, NULL, u.LIM, a.LIM),
                  DECODE(a.acc, NULL, u.ACCC, a.ACCC),
                  DECODE(a.acc, NULL, u.TOBO, a.TOBO),
                  DECODE(a.acc, NULL, u.BRANCH, a.BRANCH),
                  DECODE(a.acc, NULL, u.MDATE, a.MDATE),
                  DECODE(a.acc, NULL, u.OSTX, a.OSTX),
                  a.SEC,
                  DECODE(a.acc, NULL, u.RNK, a.RNK),
                  DECODE(a.acc, NULL, u.KF, a.KF),
                  DECODE(a.acc, NULL, u.SEND_SMS, a.SEND_SMS),
                  DECODE(a.acc, NULL, u.OB22, a.OB22),
                  COALESCE(bars.gl.bd, bars.glb_bankdate)
             FROM BARS.ACCOUNTS a
                  LEFT JOIN BARS.ACCOUNTS_UPDATE u ON (u.acc = a.acc)
            WHERE (DECODE(a.NLS, u.NLS, 1, 0) = 0
                OR DECODE(a.NLSALT, u.NLSALT, 1, 0) = 0
                OR DECODE(a.KV, u.KV, 1, 0) = 0
                OR DECODE(a.NBS, u.NBS, 1, 0) = 0
                OR DECODE(a.NBS2, u.NBS2, 1, 0) = 0
                OR DECODE(a.DAOS, u.DAOS, 1, 0) = 0
                OR DECODE(a.ISP, u.ISP, 1, 0) = 0
                OR DECODE(a.NMS, u.NMS, 1, 0) = 0
                OR DECODE(a.PAP, u.PAP, 1, 0) = 0
                OR DECODE(a.VID, u.VID, 1, 0) = 0
                OR DECODE(a.DAZS, u.DAZS, 1, 0) = 0
                OR DECODE(a.BLKD, u.BLKD, 1, 0) = 0
                OR DECODE(a.BLKK, u.BLKK, 1, 0) = 0
                OR DECODE(a.POS, u.POS, 1, 0) = 0
                OR DECODE(a.TIP, u.TIP, 1, 0) = 0
                OR DECODE(a.GRP, u.GRP, 1, 0) = 0
                OR DECODE(a.LIM, u.LIM, 1, 0) = 0
                OR DECODE(a.ACCC, u.ACCC, 1, 0) = 0
                OR DECODE(a.TOBO, u.TOBO, 1, 0) = 0
                OR DECODE(a.BRANCH, u.BRANCH, 1, 0) = 0
                OR DECODE(a.MDATE, u.MDATE, 1, 0) = 0
                OR DECODE(a.OSTX, u.OSTX, 1, 0) = 0
                OR DECODE(a.RNK, u.RNK, 1, 0) = 0
                OR DECODE(a.KF, u.KF, 1, 0) = 0
                OR DECODE(a.SEND_SMS, u.SEND_SMS, 1, 0) = 0
                OR DECODE(a.OB22, u.OB22, 1, 0) = 0)
              and u.idupd IN (  SELECT /*+ no_index(au2 PK_ACCOUNTSUPD) */
                                        MAX(au2.idupd)
                                   FROM BARS.ACCOUNTS_UPDATE au2
                               GROUP BY ACC)
              AND a.KF = bars.gl.kf;

        INS_STAT('rowcount',
                 'SYNC',
                 SQL%ROWCOUNT,
                 l_tbl_name);
        end_process(l_tbl_name, 'SYNC');
        COMMIT;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            error_process(l_tbl_name, 'ERR', substr(dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace(), 1, 1000) );
            RAISE;
    END;

    --------------------------------------------------------------------------------------------------------------------
    -- CHECK_DPT_DEPOSIT_CLOS
    --------------------------------------------------------------------------------------------------------------------
    PROCEDURE CHECK_DPT_DEPOSIT_CLOS
    IS
        l_tbl_name                    VARCHAR2(100) := 'DPT_DEPOSIT_CLOS';
        l_trace                       varchar2(500) := G_TRACE || 'CHECK_DPT_DEPOSIT_CLOS: ';
    BEGIN
        start_process(l_tbl_name, 'CHECK');

        INSERT INTO BARS.UPDATE_TBL_STAT(ID,
                                         STAT_ID,
                                         FIELD_NAME,
                                         FIELD_TYPE,
                                         VALUE,
                                         RUN_ID,
                                         STARTDATE,
                                         ENDDATE,
                                         TBL_NAME)
            SELECT BARS.S_UPDATE_TBL_STAT.NEXTVAL,
                   G_STAT_ID,
                   DECODE(t_pivot.i,
                          1,  f1,   2,  f2,   3,  f3,   4,  f4,
                          5,  f5,   6,  f6,   7,  f7,   8,  f8,
                          9,  f9,   10, f10,  11, f11,  12, f12,
                          13, f13,  14, f14,  15, f15,  16, f16,
                          17, f17,  18, f18,  19, f19,  20, f20,
                          21, f21,  22, f22,  23, f23,  24, f24,
                          25, f25,  26, f26,  27, f27,  28, f28,
                          29, f29,  30, f30,  31, f31,  32, f32,
                          33, f33,  34, f34,  35, f35)  AS field,
                   'count_diff' type1,
                   DECODE(t_pivot.i,
                          1,  c1,   2,  c2,   3,  c3,   4,  c4,
                          5,  c5,   6,  c6,   7,  c7,   8,  c8,
                          9,  c9,   10, c10,  11, c11,  12, c12,
                          13, c13,  14, c14,  15, c15,  16, c16,
                          17, c17,  18, c18,  19, c19,  20, c20,
                          21, c21,  22, c22,  23, c23,  24, c24,
                          25, c25,  26, c26,  27, c27,  28, c28,
                          29, c29,  30, c30,  31, c31,  32, c32,
                          33, c33,  34, c34,  35, decode(c35, null, 0, c35))  AS CNTDIFF,
                   G_RUN_ID,
                   G_START_DT,
                   G_END_DT,
                   l_tbl_name
              FROM (    SELECT ROWNUM AS i
                          FROM DUAL
                    CONNECT BY LEVEL <= 35) t_pivot,
                   (SELECT SUM(1) c35,
                           'TOTAL_ROWS' f35,
                           SUM(DECODE(d.WB, u.WB, 0, 1)) c1,                              'WB' f1,
                           SUM(DECODE(d.DEPOSIT_ID, u.DEPOSIT_ID, 0, 1)) c2,              'DEPOSIT_ID' f2,
                           SUM(DECODE(d.VIDD, u.VIDD, 0, 1)) c3,                          'VIDD' f3,
                           SUM(DECODE(d.ACC, u.ACC, 0, 1)) c4,                            'ACC' f4,
                           SUM(DECODE(d.KV, u.KV, 0, 1)) c5,                              'KV' f5,
                           SUM(DECODE(d.RNK, u.RNK, 0, 1)) c6,                            'RNK' f6,
                           SUM(DECODE(d.DAT_BEGIN, u.DAT_BEGIN, 0, 1)) c7,                'DAT_BEGIN' f7,
                           SUM(DECODE(d.DAT_END, u.DAT_END, 0, 1)) c8,                    'DAT_END' f8,
                           SUM(DECODE(d.COMMENTS, u.COMMENTS, 0, 1)) c9,                  'COMMENTS' f9,
                           SUM(DECODE(d.MFO_P, u.MFO_P, 0, 1)) c10,                       'MFO_P' f10,
                           SUM(DECODE(d.NLS_P, u.NLS_P, 0, 1)) c11,                       'NLS_P' f11,
                           SUM(DECODE(d.LIMIT, u.LIMIT, 0, 1)) c12,                       'LIMIT' f12,
                           SUM(DECODE(d.DEPOSIT_COD, u.DEPOSIT_COD, 0, 1)) c13,           'DEPOSIT_COD' f13,
                           SUM(DECODE(d.NAME_P, u.NAME_P, 0, 1)) c14,                     'NAME_P' f14,
                           SUM(DECODE(d.DATZ, u.DATZ, 0, 1)) c15,                         'DATZ' f15,
                           SUM(DECODE(d.OKPO_P, u.OKPO_P, 0, 1)) c16,                     'OKPO_P' f16,
                           SUM(DECODE(d.DAT_EXT_INT, u.DAT_EXT_INT, 0, 1)) c17,           'DAT_EXT_INT' f17,
                           SUM(DECODE(d.CNT_DUBL, u.CNT_DUBL, 0, 1)) c18,                 'CNT_DUBL' f18,
                           SUM(DECODE(d.CNT_EXT_INT, u.CNT_EXT_INT, 0, 1)) c19,           'CNT_EXT_INT' f19,
                           SUM(DECODE(d.FREQ, u.FREQ, 0, 1)) c20,                         'FREQ' f20,
                           SUM(DECODE(d.ND, u.ND, 0, 1)) c21,                             'ND' f21,
                           SUM(DECODE(d.BRANCH, u.BRANCH, 0, 1)) c22,                     'BRANCH' f22,
                           SUM(DECODE(d.DPT_D, u.DPT_D, 0, 1)) c23,                       'DPT_D' f23,
                           SUM(DECODE(d.ACC_D, u.ACC_D, 0, 1)) c24,                       'ACC_D' f24,
                           SUM(DECODE(d.MFO_D, u.MFO_D, 0, 1)) c25,                       'MFO_D' f25,
                           SUM(DECODE(d.NLS_D, u.NLS_D, 0, 1)) c26,                       'NLS_D' f26,
                           SUM(DECODE(d.NMS_D, u.NMS_D, 0, 1)) c27,                       'NMS_D' f27,
                           SUM(DECODE(d.OKPO_D, u.OKPO_D, 0, 1)) c28,                     'OKPO_D' f28,
                           SUM(DECODE(d.DAT_END_ALT, u.DAT_END_ALT, 0, 1)) c29,           'DAT_END_ALT' f29,
                           SUM(DECODE(d.STOP_ID, u.STOP_ID, 0, 1)) c30,                   'STOP_ID' f30,
                           SUM(DECODE(d.KF, u.KF, 0, 1)) c31,                             'KF' f31,
                           SUM(DECODE(d.USERID, u.USERID, 0, 1)) c32,                     'USERID' f32,
                           SUM(DECODE(d.ARCHDOC_ID, u.ARCHDOC_ID, 0, 1)) c33,             'ARCHDOC_ID' f33,
                           SUM(DECODE(d.FORBID_EXTENSION, u.FORBID_EXTENSION, 0, 1)) c34, 'FORBID_EXTENSION' f34
                      FROM BARS.DPT_DEPOSIT d
                           JOIN (SELECT *
                                   FROM BARS.DPT_DEPOSIT_CLOS u1
                                  WHERE u1.IDUPD IN ( SELECT MAX(u2.IDUPD)
                                                        FROM BARS.DPT_DEPOSIT_CLOS u2
                                                       where kf = bars.gl.kf
                                                       GROUP BY u2.DEPOSIT_ID
                                                      --having max(decode(action_id, 1, 2, 2, 2, 0)) = 0
                                                    )
                                 ) u
                               ON (d.KF = u.KF AND d.DEPOSIT_ID = u.DEPOSIT_ID)
                     WHERE (DECODE(d.WB, u.WB, 1, 0) = 0
                         OR DECODE(d.DEPOSIT_ID, u.DEPOSIT_ID, 1, 0) = 0
                         OR DECODE(d.VIDD, u.VIDD, 1, 0) = 0
                         OR DECODE(d.ACC, u.ACC, 1, 0) = 0
                         OR DECODE(d.KV, u.KV, 1, 0) = 0
                         OR DECODE(d.RNK, u.RNK, 1, 0) = 0
                         OR DECODE(d.DAT_BEGIN, u.DAT_BEGIN, 1, 0) = 0
                         OR DECODE(d.DAT_END, u.DAT_END, 1, 0) = 0
                         OR DECODE(d.COMMENTS, u.COMMENTS, 1, 0) = 0
                         OR DECODE(d.MFO_P, u.MFO_P, 1, 0) = 0
                         OR DECODE(d.NLS_P, u.NLS_P, 1, 0) = 0
                         OR DECODE(d.LIMIT, u.LIMIT, 1, 0) = 0
                         OR DECODE(d.DEPOSIT_COD, u.DEPOSIT_COD, 1, 0) = 0
                         OR DECODE(d.NAME_P, u.NAME_P, 1, 0) = 0
                         OR DECODE(d.DATZ, u.DATZ, 1, 0) = 0
                         OR DECODE(d.OKPO_P, u.OKPO_P, 1, 0) = 0
                         OR DECODE(d.DAT_EXT_INT, u.DAT_EXT_INT, 1, 0) = 0
                         OR DECODE(d.CNT_DUBL, u.CNT_DUBL, 1, 0) = 0
                         OR DECODE(d.CNT_EXT_INT, u.CNT_EXT_INT, 1, 0) = 0
                         OR DECODE(d.FREQ, u.FREQ, 1, 0) = 0
                         OR DECODE(d.ND, u.ND, 1, 0) = 0
                         OR DECODE(d.BRANCH, u.BRANCH, 1, 0) = 0
                         OR DECODE(d.DPT_D, u.DPT_D, 1, 0) = 0
                         OR DECODE(d.ACC_D, u.ACC_D, 1, 0) = 0
                         OR DECODE(d.MFO_D, u.MFO_D, 1, 0) = 0
                         OR DECODE(d.NLS_D, u.NLS_D, 1, 0) = 0
                         OR DECODE(d.NMS_D, u.NMS_D, 1, 0) = 0
                         OR DECODE(d.OKPO_D, u.OKPO_D, 1, 0) = 0
                         OR DECODE(d.DAT_END_ALT, u.DAT_END_ALT, 1, 0) = 0
                         OR DECODE(d.STOP_ID, u.STOP_ID, 1, 0) = 0
                         OR DECODE(d.KF, u.KF, 1, 0) = 0
                         OR DECODE(d.USERID, u.USERID, 1, 0) = 0
                         OR DECODE(d.ARCHDOC_ID, u.ARCHDOC_ID, 1, 0) = 0
                         OR DECODE(d.FORBID_EXTENSION, u.FORBID_EXTENSION, 1, 0) = 0)
                       AND d.KF = bars.gl.kf
                       AND u.KF = bars.gl.kf);
        end_process(l_tbl_name, 'CHECK');
        COMMIT;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            error_process(l_tbl_name, 'ERR', substr(dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace(), 1, 1000) );
            RAISE;
    END;

    --------------------------------------------------------------------------------------------------------------------
    -- SYNC_DPT_DEPOSIT_CLOS
    --------------------------------------------------------------------------------------------------------------------
    PROCEDURE SYNC_DPT_DEPOSIT_CLOS( p_id OUT NUMBER, p_rowcount OUT NUMBER)
    IS
        l_tbl_name                    VARCHAR2(100) := 'dpt_deposit_clos';
        l_trace                       varchar2(500) := G_TRACE || 'SYNC_DPT_DEPOSIT_CLOS: ';
        l_staff_id                    bars.staff$base.id%type;
        l_staff_nm                    bars.staff$base.logname%type;
    BEGIN
        start_process(l_tbl_name, 'SYNC');
        SELECT id, logname into l_staff_id, l_staff_nm FROM bars.staff$base WHERE logname = G_LOGNAME;
        INSERT INTO dpt_deposit_clos(idupd,
                                     deposit_id,
                                     nd,
                                     vidd,
                                     acc,
                                     kv,
                                     rnk,
                                     freq,
                                     datz,
                                     dat_begin,
                                     dat_end,
                                     dat_end_alt,
                                     mfo_p,
                                     nls_p,
                                     name_p,
                                     okpo_p,
                                     dpt_d,
                                     acc_d,
                                     mfo_d,
                                     nls_d,
                                     nms_d,
                                     okpo_d,
                                     LIMIT,
                                     deposit_cod,
                                     comments,
                                     action_id,
                                     actiion_author,
                                     "WHEN",
                                     bdate,
                                     stop_id,
                                     kf,
                                     cnt_dubl,
                                     cnt_ext_int,
                                     dat_ext_int,
                                     userid,
                                     archdoc_id,
                                     forbid_extension,
                                     branch,
                                     wb)
            SELECT bars_sqnc.get_nextval('s_dpt_deposit_clos') as IDUPD,
                   DECODE(d.DEPOSIT_ID, NULL, u.DEPOSIT_ID, d.DEPOSIT_ID),
                   DECODE(d.DEPOSIT_ID, NULL, u.ND, d.ND),
                   DECODE(d.DEPOSIT_ID, NULL, u.VIDD, d.VIDD),
                   DECODE(d.DEPOSIT_ID, NULL, u.ACC, d.ACC),
                   DECODE(d.DEPOSIT_ID, NULL, u.KV, d.KV),
                   DECODE(d.DEPOSIT_ID, NULL, u.RNK, d.RNK),
                   DECODE(d.DEPOSIT_ID, NULL, u.FREQ, d.FREQ),
                   DECODE(d.DEPOSIT_ID, NULL, u.DATZ, d.DATZ),
                   DECODE(d.DEPOSIT_ID, NULL, u.DAT_BEGIN, d.DAT_BEGIN),
                   DECODE(d.DEPOSIT_ID, NULL, u.DAT_END, d.DAT_END),
                   DECODE(d.DEPOSIT_ID, NULL, u.DAT_END_ALT, d.DAT_END_ALT),
                   DECODE(d.DEPOSIT_ID, NULL, u.MFO_P, d.MFO_P),
                   DECODE(d.DEPOSIT_ID, NULL, u.NLS_P, d.NLS_P),
                   DECODE(d.DEPOSIT_ID, NULL, u.NAME_P, d.NAME_P),
                   DECODE(d.DEPOSIT_ID, NULL, u.OKPO_P, d.OKPO_P),
                   DECODE(d.DEPOSIT_ID, NULL, u.DPT_D, d.DPT_D),
                   DECODE(d.DEPOSIT_ID, NULL, u.ACC_D, d.ACC_D),
                   DECODE(d.DEPOSIT_ID, NULL, u.MFO_D, d.MFO_D),
                   DECODE(d.DEPOSIT_ID, NULL, u.NLS_D, d.NLS_D),
                   DECODE(d.DEPOSIT_ID, NULL, u.NMS_D, d.NMS_D),
                   DECODE(d.DEPOSIT_ID, NULL, u.OKPO_D, d.OKPO_D),
                   DECODE(d.DEPOSIT_ID, NULL, u.LIMIT, d.LIMIT),
                   DECODE(d.DEPOSIT_ID, NULL, u.DEPOSIT_COD, d.DEPOSIT_COD),
                   DECODE(d.DEPOSIT_ID, NULL, u.COMMENTS, d.COMMENTS),
                   CASE
                       --WHEN d.DEPOSIT_ID IS NULL and (not exists (select 1 from BARS.DPT_DEPOSIT_CLOS cu where cu.DEPOSIT_ID = u.DEPOSIT_ID and cu.action_id in (1,2))) THEN 1
                       --WHEN d.DEPOSIT_ID IS NULL THEN 1
                       --WHEN u.DEPOSIT_ID IS NULL THEN 0
                       WHEN DECODE(d.VIDD, u.VIDD, 1, 0) = 0 THEN 6
                       WHEN ((u.dat_begin IS NULL AND d.dat_begin IS NOT NULL)
                         OR (u.dat_end IS NULL AND d.dat_end IS NOT NULL)
                         OR (u.dat_begin IS NOT NULL AND d.dat_begin IS NULL)
                         OR (u.dat_end IS NOT NULL AND d.dat_end IS NULL)
                         OR (u.dat_begin != d.dat_begin)
                         OR (u.dat_end != d.dat_end))
                       THEN 3
                       ELSE 4
                   END action_id,
                   l_staff_id as ACTIION_AUTHOR,
                   SYSDATE as WHEN,
                   bars.gl.bd as BDATE,
                   DECODE(d.deposit_id, NULL, u.STOP_ID, d.STOP_ID),
                   DECODE(d.deposit_id, NULL, u.KF, d.KF),
                   DECODE(d.deposit_id, NULL, u.CNT_DUBL, d.CNT_DUBL),
                   DECODE(d.deposit_id, NULL, u.CNT_EXT_INT, d.CNT_EXT_INT),
                   DECODE(d.deposit_id, NULL, u.DAT_EXT_INT, d.DAT_EXT_INT),
                   DECODE(d.deposit_id, NULL, u.USERID, d.USERID),
                   DECODE(d.deposit_id, NULL, u.ARCHDOC_ID, d.ARCHDOC_ID),
                   DECODE(d.deposit_id, NULL, u.FORBID_EXTENSION, d.FORBID_EXTENSION),
                   DECODE(d.deposit_id, NULL, u.BRANCH, d.BRANCH),
                   DECODE(d.deposit_id, NULL, u.WB, d.WB)
              FROM BARS.DPT_DEPOSIT d
                              JOIN (SELECT *
                                      FROM BARS.DPT_DEPOSIT_CLOS u1
                                     WHERE u1.IDUPD IN ( SELECT MAX(u2.IDUPD)
                                                           FROM BARS.DPT_DEPOSIT_CLOS u2
                                                          where kf = bars.gl.kf
                                                          GROUP BY u2.DEPOSIT_ID
                                                          --having max(decode(action_id, 1, 2, 2, 2, 0)) = 0
                                                       )
                                    ) u
                       ON (d.KF = u.KF AND d.DEPOSIT_ID = u.DEPOSIT_ID)
             WHERE (DECODE(d.WB, u.WB, 1, 0) = 0
                 OR DECODE(d.DEPOSIT_ID, u.DEPOSIT_ID, 1, 0) = 0
                 OR DECODE(d.VIDD, u.VIDD, 1, 0) = 0
                 OR DECODE(d.ACC, u.ACC, 1, 0) = 0
                 OR DECODE(d.KV, u.KV, 1, 0) = 0
                 OR DECODE(d.RNK, u.RNK, 1, 0) = 0
                 OR DECODE(d.DAT_BEGIN, u.DAT_BEGIN, 1, 0) = 0
                 OR DECODE(d.DAT_END, u.DAT_END, 1, 0) = 0
                 OR DECODE(d.COMMENTS, u.COMMENTS, 1, 0) = 0
                 OR DECODE(d.MFO_P, u.MFO_P, 1, 0) = 0
                 OR DECODE(d.NLS_P, u.NLS_P, 1, 0) = 0
                 OR DECODE(d.LIMIT, u.LIMIT, 1, 0) = 0
                 OR DECODE(d.DEPOSIT_COD, u.DEPOSIT_COD, 1, 0) = 0
                 OR DECODE(d.NAME_P, u.NAME_P, 1, 0) = 0
                 OR DECODE(d.DATZ, u.DATZ, 1, 0) = 0
                 OR DECODE(d.OKPO_P, u.OKPO_P, 1, 0) = 0
                 OR DECODE(d.DAT_EXT_INT, u.DAT_EXT_INT, 1, 0) = 0
                 OR DECODE(d.CNT_DUBL, u.CNT_DUBL, 1, 0) = 0
                 OR DECODE(d.CNT_EXT_INT, u.CNT_EXT_INT, 1, 0) = 0
                 OR DECODE(d.FREQ, u.FREQ, 1, 0) = 0
                 OR DECODE(d.ND, u.ND, 1, 0) = 0
                 OR DECODE(d.BRANCH, u.BRANCH, 1, 0) = 0
                 OR DECODE(d.DPT_D, u.DPT_D, 1, 0) = 0
                 OR DECODE(d.ACC_D, u.ACC_D, 1, 0) = 0
                 OR DECODE(d.MFO_D, u.MFO_D, 1, 0) = 0
                 OR DECODE(d.NLS_D, u.NLS_D, 1, 0) = 0
                 OR DECODE(d.NMS_D, u.NMS_D, 1, 0) = 0
                 OR DECODE(d.OKPO_D, u.OKPO_D, 1, 0) = 0
                 OR DECODE(d.DAT_END_ALT, u.DAT_END_ALT, 1, 0) = 0
                 OR DECODE(d.STOP_ID, u.STOP_ID, 1, 0) = 0
                 OR DECODE(d.KF, u.KF, 1, 0) = 0
                 OR DECODE(d.USERID, u.USERID, 1, 0) = 0
                 OR DECODE(d.ARCHDOC_ID, u.ARCHDOC_ID, 1, 0) = 0
                 OR DECODE(d.FORBID_EXTENSION, u.FORBID_EXTENSION, 1, 0) = 0);

        INS_STAT('rowcount',
                 'SYNC',
                 SQL%ROWCOUNT,
                 l_tbl_name);
        
                end_process(l_tbl_name, 'SYNC');
        COMMIT;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            error_process(l_tbl_name, 'ERR', substr(dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace(), 1, 1000) );
            RAISE;
    END;


    --------------------------------------------------------------------------------------------------------------------
    -- CHECK_CUSTOMERW_UPDATE
    --------------------------------------------------------------------------------------------------------------------
    PROCEDURE CHECK_CUSTOMERW_UPDATE
    IS
        l_tbl_name                    VARCHAR2(100) := 'CUSTOMERW_UPDATE';
        l_trace                       varchar2(500) := G_TRACE || 'CHECK_CUSTOMERW_UPDATE: ';
    BEGIN
        start_process(l_tbl_name, 'CHECK');

        INSERT INTO BARS.UPDATE_TBL_STAT(ID,
                                         STAT_ID,
                                         FIELD_NAME,
                                         FIELD_TYPE,
                                         VALUE,
                                         RUN_ID,
                                         STARTDATE,
                                         ENDDATE,
                                         TBL_NAME)
            SELECT BARS.S_UPDATE_TBL_STAT.NEXTVAL,
                   G_STAT_ID,
                   f1 AS field,
                   'count_diff' type1,
                   c1 AS CNTDIFF,
                   G_RUN_ID,
                   G_START_DT,
                   G_END_DT,
                   l_tbl_name
              FROM ( select count(*) c1, coalesce(cw.TAG, wu.TAG) f1
                       from BARS.CUSTOMERW     cw
                            join BARS.CUSTOMER c on (cw.rnk = c.rnk)
                       full outer join (select u1.rnk, cast(u1.tag as char(5)) as tag, u1.value,u1.isp
                                          from BARS.CUSTOMERW_UPDATE u1 
                                         where u1.IDUPD in (select max(u2.IDUPD)
                                                              from BARS.CUSTOMERW_UPDATE u2
                                                             group by trim(u2.tag), u2.rnk
                                                           ) 
                                           and u1.CHGACTION <> 3
                                       ) wu on ( cw.rnk = wu.rnk and cw.tag = wu.tag )
                      where decode(wu.value, cw.value, 0, 1) = 1
                         or wu.rnk is null
                         or cw.rnk is null
                      group by coalesce(cw.TAG, wu.TAG));
        end_process(l_tbl_name, 'CHECK');
        COMMIT;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            error_process(l_tbl_name, 'ERR', substr(dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace(), 1, 1000) );
            RAISE;
    END;

    --------------------------------------------------------------------------------------------------------------------
    -- SYNC_CUSTOMERW_UPDATE
    --------------------------------------------------------------------------------------------------------------------
    PROCEDURE SYNC_CUSTOMERW_UPDATE( p_id OUT NUMBER, p_rowcount OUT NUMBER)
    IS
        l_tbl_name                    VARCHAR2(100) := 'CUSTOMERW_UPDATE';
        l_trace                       varchar2(500) := G_TRACE || 'SYNC_CUSTOMERW_UPDATE: ';
        l_staff_id                    bars.staff$base.id%type;
        l_staff_nm                    bars.staff$base.logname%type;
    BEGIN
        start_process(l_tbl_name, 'SYNC');
        SELECT id, logname into l_staff_id, l_staff_nm FROM bars.staff$base WHERE logname = G_LOGNAME;
        INSERT INTO BARS.CUSTOMERW_UPDATE(IDUPD,
                                          EFFECTDATE,
                                          DONEBY,
                                          CHGDATE,
                                          CHGACTION,
                                          tag,
                                          RNK,
                                          ISP,
                                          VALUE)
            SELECT bars_sqnc.get_nextval('s_customerw_update') as IDUPD,
                   COALESCE(bars.gl.bd, bars.glb_bankdate),
                   l_staff_nm,
                   SYSDATE,
                   DECODE(custw.rnk, NULL, 3, 2) CHGACTION,
                   DECODE(custw.rnk, NULL, cwu.TAG, trim(custw.tag)),
                   DECODE(custw.rnk, NULL, cwu.RNK, custw.RNK),
                   DECODE(custw.rnk, NULL, cwu.ISP, custw.ISP),
                   DECODE(custw.rnk, NULL, cwu.VALUE, custw.VALUE)
              FROM (SELECT cw.*
                      FROM BARS.CUSTOMER c, BARS.CUSTOMERW cw
                     WHERE cw.rnk = c.rnk) custw
                   FULL OUTER JOIN (SELECT  u1.rnk, cast(u1.tag as char(5)) as tag_char, u1.value, u1.isp, u1.tag as tag
                                      FROM BARS.CUSTOMERW_UPDATE u1
                                     WHERE u1.IDUPD IN (  SELECT MAX(u2.IDUPD)
                                                                    FROM BARS.CUSTOMERW_UPDATE u2
                                                                GROUP BY trim(u2.tag), u2.rnk)
                                       AND u1.CHGACTION <> '3') cwu
                       ON (custw.rnk = cwu.rnk AND custw.tag = cwu.tag_char)
             WHERE (DECODE(custw.VALUE, cwu.VALUE, 1, 0) = 0
                 or   cwu.rnk is null
                 or custw.rnk is null);

        INS_STAT('rowcount',
                 'SYNC',
                 SQL%ROWCOUNT,
                 l_tbl_name);
        end_process(l_tbl_name, 'SYNC');
        COMMIT;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            error_process(l_tbl_name, 'ERR', substr(dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace(), 1, 1000) );
            RAISE;
    END;

    --------------------------------------------------------------------------------------------------------------------
    -- SYNC_CUSTOMERW_UPDATE_DWH
    -- синхронизация только тех тегов, которые передаются в DWH
    --------------------------------------------------------------------------------------------------------------------
    PROCEDURE SYNC_CUSTOMERW_UPDATE_DWH( p_id OUT NUMBER, p_rowcount OUT NUMBER)
    IS
        l_tbl_name                    VARCHAR2(100) := 'CUSTOMERW_UPDATE';
        l_trace                       varchar2(500) := G_TRACE || 'SYNC_CUSTOMERW_UPDATE_DWH: ';
        l_staff_id                    bars.staff$base.id%type;
        l_staff_nm                    bars.staff$base.logname%type;
    BEGIN
        start_process(l_tbl_name, 'SYNC');
        SELECT id, logname into l_staff_id, l_staff_nm FROM bars.staff$base WHERE logname = G_LOGNAME;
        INSERT INTO BARS.CUSTOMERW_UPDATE(IDUPD,
                                          EFFECTDATE,
                                          DONEBY,
                                          CHGDATE,
                                          CHGACTION,
                                          tag,
                                          RNK,
                                          ISP,
                                          VALUE)
            WITH tg as (select /*+ inline */tag, cast(tag as char(5)) as tag_char from barsupl.upl_tag_lists where tag_table = 'CUST_FIELD')
            SELECT bars_sqnc.get_nextval('s_customerw_update') as IDUPD,
                   COALESCE(bars.gl.bd, bars.glb_bankdate),
                   l_staff_nm,
                   SYSDATE,
                   DECODE(custw.rnk, NULL, 3, 2) CHGACTION,
                   DECODE(custw.rnk, NULL, cwu.TAG, trim(custw.tag)),
                   DECODE(custw.rnk, NULL, cwu.RNK, custw.RNK),
                   DECODE(custw.rnk, NULL, cwu.ISP, custw.ISP),
                   DECODE(custw.rnk, NULL, cwu.VALUE, custw.VALUE)
              FROM (SELECT cw.*
                      FROM BARS.CUSTOMER c, BARS.CUSTOMERW cw, tg
                     WHERE cw.rnk = c.rnk
                       and cw.tag = tg.tag_char) custw
                   FULL OUTER JOIN (SELECT  u1.rnk, cast(u1.tag as char(5)) as tag_char, u1.value, u1.isp, u1.tag as tag
                                      FROM BARS.CUSTOMERW_UPDATE u1
                                     WHERE u1.IDUPD IN (  SELECT MAX(u2.IDUPD)
                                                            FROM BARS.CUSTOMERW_UPDATE u2, tg
                                                           where u2.tag = tg.tag
                                                           GROUP BY trim(u2.tag), u2.rnk)
                                       AND u1.CHGACTION <> '3') cwu
                       ON (custw.rnk = cwu.rnk AND custw.tag = cwu.tag_char)
             WHERE (DECODE(custw.VALUE, cwu.VALUE, 1, 0) = 0
                 or   cwu.rnk is null
                 or custw.rnk is null);
        INS_STAT('rowcount',
                 'SYNC',
                 SQL%ROWCOUNT,
                 l_tbl_name);
        end_process(l_tbl_name, 'SYNC');
        COMMIT;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            error_process(l_tbl_name, 'ERR', substr(dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace(), 1, 1000) );
            RAISE;
    END;

    --------------------------------------------------------------------------------------------------------------------
    -- CHECK_ACCOUNTSW_UPDATE
    --------------------------------------------------------------------------------------------------------------------
    PROCEDURE CHECK_ACCOUNTSW_UPDATE
    IS
        l_tbl_name                    VARCHAR2(100) := 'ACCOUNTSW_UPDATE';
        l_trace                       varchar2(500) := G_TRACE || 'CHECK_ACCOUNTSW_UPDATE: ';
    BEGIN
        start_process(l_tbl_name, 'CHECK');

        INSERT INTO BARS.UPDATE_TBL_STAT(ID,
                                         STAT_ID,
                                         FIELD_NAME,
                                         FIELD_TYPE,
                                         VALUE,
                                         RUN_ID,
                                         STARTDATE,
                                         ENDDATE,
                                         TBL_NAME)
            SELECT BARS.S_UPDATE_TBL_STAT.NEXTVAL,
                   G_STAT_ID,
                   f1 AS field,
                   'count_diff' type1,
                   c1 AS CNTDIFF,
                   G_RUN_ID,
                   G_START_DT,
                   G_END_DT,
                   l_tbl_name
              FROM (SELECT count(*) c1, coalesce(w.TAG, u.TAG) f1
                      FROM (select w1.* from BARS.ACCOUNTSW w1 where w1.kf = bars.gl.kf) w
                           FULL OUTER JOIN (SELECT *
                                              FROM BARS.ACCOUNTSW_UPDATE u1
                                             WHERE u1.IDUPD IN (  SELECT MAX(u2.IDUPD)
                                                                     FROM BARS.ACCOUNTSW_UPDATE u2
                                                                    where u2.KF = bars.gl.kf
                                                                 GROUP BY u2.acc, u2.tag)
                                               AND u1.chgaction != 'D'
                                               and u1.KF = bars.gl.kf
                                           ) u
                               ON (w.acc = u.acc AND w.kf = u.kf AND w.tag = u.tag)
                     WHERE ( DECODE(w.ACC, u.ACC, 1, 0) = 0
                        or DECODE(w.TAG, u.TAG, 1, 0) = 0
                        or decode(w.VALUE, u.VALUE, 1, 0) = 0)
                     group by coalesce(w.tag, u.tag));
        end_process(l_tbl_name, 'CHECK');
        COMMIT;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            error_process(l_tbl_name, 'ERR', substr(dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace(), 1, 1000) );
            RAISE;
    END;

    --------------------------------------------------------------------------------------------------------------------
    -- SYNC_ACCOUNTSW_UPDATE
    --------------------------------------------------------------------------------------------------------------------
    PROCEDURE SYNC_ACCOUNTSW_UPDATE( p_id OUT NUMBER, p_rowcount OUT NUMBER)
    IS
        l_tbl_name                    VARCHAR2(100) := 'ACCOUNTSW_UPDATE';
        l_trace                       varchar2(500) := G_TRACE || 'SYNC_ACCOUNTSW_UPDATE: ';
        l_staff_id                    bars.staff$base.id%type;
        l_staff_nm                    bars.staff$base.logname%type;
    BEGIN
        start_process(l_tbl_name, 'SYNC');
        SELECT id, logname into l_staff_id, l_staff_nm FROM bars.staff$base WHERE logname = G_LOGNAME;
        INSERT INTO BARS.ACCOUNTSW_UPDATE(IDUPD,
                                          CHGACTION,
                                          EFFECTDATE,
                                          CHGDATE,
                                          DONEBY,
                                          ACC,
                                          TAG,
                                          VALUE,
                                          KF)
            SELECT bars.bars_sqnc.get_nextval(s_accountsw_update.NEXTVAL, COALESCE(w.KF, u.KF)),
                   DECODE(w.acc, NULL, 'D', 'U'),
                   bars.gl.bd,
                   SYSDATE,
                   l_staff_id,
                   DECODE(w.acc, NULL, u.ACC, w.ACC),
                   DECODE(w.acc, NULL, u.TAG, w.TAG),
                   DECODE(w.acc, NULL, u.VALUE, w.VALUE),
                   DECODE(w.acc, NULL, u.KF, w.KF)
              FROM (select w1.* from BARS.ACCOUNTSW w1 where w1.kf = bars.gl.kf) w
                   FULL OUTER JOIN (SELECT *
                                      FROM BARS.ACCOUNTSW_UPDATE u1
                                     WHERE u1.IDUPD IN (  SELECT MAX(u2.IDUPD)
                                                            FROM BARS.ACCOUNTSW_UPDATE u2
                                                           where u2.KF = bars.gl.kf
                                                           GROUP BY u2.acc, u2.tag)
                                       and u1.KF = bars.gl.kf
                                       AND u1.CHGACTION <> 'D') u
                       ON (w.acc = u.acc AND w.tag = u.tag AND w.kf = u.kf)
             WHERE (DECODE(w.ACC, u.ACC, 1, 0) = 0
                 OR DECODE(w.TAG, u.TAG, 1, 0) = 0
                 OR DECODE(w.VALUE, u.VALUE, 1, 0) = 0
                 OR DECODE(w.KF, u.KF, 1, 0) = 0);

        INS_STAT('rowcount',
                 'SYNC',
                 SQL%ROWCOUNT,
                 l_tbl_name);
        end_process(l_tbl_name, 'SYNC');
        COMMIT;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            error_process(l_tbl_name, 'ERR', substr(dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace(), 1, 1000) );
            RAISE;
    END;

    --------------------------------------------------------------------------------------------------------------------
    -- SYNC_ACCOUNTSW_UPDATE_DWH
    -- синхронизация только тех тегов, которые передаются в DWH
    --------------------------------------------------------------------------------------------------------------------
    PROCEDURE SYNC_ACCOUNTSW_UPDATE_DWH( p_id OUT NUMBER, p_rowcount OUT NUMBER)
    IS
        l_tbl_name                    VARCHAR2(100) := 'ACCOUNTSW_UPDATE';
        l_trace                       varchar2(500) := G_TRACE || 'SYNC_ACCOUNTSW_UPDATE_DWH: ';
        l_staff_id                    bars.staff$base.id%type;
        l_staff_nm                    bars.staff$base.logname%type;
    BEGIN
        start_process(l_tbl_name, 'SYNC');
        SELECT id, logname into l_staff_id, l_staff_nm FROM bars.staff$base WHERE logname = G_LOGNAME;
        INSERT INTO BARS.ACCOUNTSW_UPDATE(IDUPD,
                                          CHGACTION,
                                          EFFECTDATE,
                                          CHGDATE,
                                          DONEBY,
                                          ACC,
                                          TAG,
                                          VALUE,
                                          KF)
            WITH tg as (select /*+ inline */ tag from barsupl.upl_tag_lists where tag_table = 'ACC_FIELD')
            SELECT bars.bars_sqnc.get_nextval(s_accountsw_update.NEXTVAL, COALESCE(w.KF, u.KF)),
                   DECODE(w.acc, NULL, 'D', 'U'),
                   bars.gl.bd,
                   SYSDATE,
                   l_staff_id,
                   DECODE(w.acc, NULL, u.ACC, w.ACC),
                   DECODE(w.acc, NULL, u.TAG, w.TAG),
                   DECODE(w.acc, NULL, u.VALUE, w.VALUE),
                   DECODE(w.acc, NULL, u.KF, w.KF)
              FROM (select w1.* from BARS.ACCOUNTSW w1, tg where w1.kf = bars.gl.kf and w1.tag = tg.tag) w
                   FULL OUTER JOIN (SELECT *
                                      FROM BARS.ACCOUNTSW_UPDATE u1
                                     WHERE u1.IDUPD IN (  SELECT MAX(u2.IDUPD)
                                                            FROM BARS.ACCOUNTSW_UPDATE u2, tg
                                                           where u2.KF = bars.gl.kf
                                                             and u2.tag = tg.tag
                                                           GROUP BY u2.acc, u2.tag)
                                       and u1.KF = bars.gl.kf
                                       AND u1.CHGACTION <> 'D') u
                       ON (w.acc = u.acc AND w.tag = u.tag AND w.kf = u.kf)
             WHERE (DECODE(w.ACC, u.ACC, 1, 0) = 0
                 OR DECODE(w.TAG, u.TAG, 1, 0) = 0
                 OR DECODE(w.VALUE, u.VALUE, 1, 0) = 0
                 OR DECODE(w.KF, u.KF, 1, 0) = 0);

        INS_STAT('rowcount',
                 'SYNC',
                 SQL%ROWCOUNT,
                 l_tbl_name);
        end_process(l_tbl_name, 'SYNC');
        COMMIT;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            error_process(l_tbl_name, 'ERR', substr(dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace(), 1, 1000) );
            RAISE;
    END;

    --------------------------------------------------------------------------------------------------------------------
    -- CHECK_ND_TXT_UPDATE
    --------------------------------------------------------------------------------------------------------------------
    PROCEDURE CHECK_ND_TXT_UPDATE
    IS
        l_tbl_name                    VARCHAR2(100) := 'ND_TXT_UPDATE';
        l_trace                       varchar2(500) := G_TRACE || 'CHECK_ND_TXT_UPDATE: ';
    BEGIN
        start_process(l_tbl_name, 'CHECK');

        INSERT INTO BARS.UPDATE_TBL_STAT(ID,
                                         STAT_ID,
                                         FIELD_NAME,
                                         FIELD_TYPE,
                                         VALUE,
                                         RUN_ID,
                                         STARTDATE,
                                         ENDDATE,
                                         TBL_NAME)
            SELECT BARS.S_UPDATE_TBL_STAT.NEXTVAL,
                   G_STAT_ID,
                   f1 AS field,
                   'count_diff' type1,
                   c1 AS CNTDIFF,
                   G_RUN_ID,
                   G_START_DT,
                   G_END_DT,
                   l_tbl_name
              FROM (SELECT count(*) c1, coalesce(n.TAG, u.TAG) f1
                      FROM BARS.ND_TXT n
                      FULL OUTER JOIN (SELECT *
                                         FROM BARS.ND_TXT_UPDATE u1
                                        WHERE u1.IDUPD IN ( SELECT MAX(u2.IDUPD)
                                                                  FROM BARS.ND_TXT_UPDATE u2
                                                                 GROUP BY u2.nd, u2.tag, u2.kf )
                                          AND u1.CHGACTION <> 3) u
                          ON (n.kf = u.kf AND n.nd = u.nd AND n.tag = u.tag)
                     WHERE decode(n.txt, u.txt, 0, 1) = 1
                        or n.nd is null
                        or u.nd is null
                      group by coalesce(n.TAG, u.TAG));
        end_process(l_tbl_name, 'CHECK');
        COMMIT;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            error_process(l_tbl_name, 'ERR', substr(dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace(), 1, 1000) );
            RAISE;
    END;

    --------------------------------------------------------------------------------------------------------------------
    -- SYNC_ND_TXT_UPDATE
    --------------------------------------------------------------------------------------------------------------------
    PROCEDURE SYNC_ND_TXT_UPDATE( p_id OUT NUMBER, p_rowcount OUT NUMBER)
    IS
        l_tbl_name                    VARCHAR2(100) := 'ND_TXT_UPDATE';
        l_trace                       varchar2(500) := G_TRACE || 'SYNC_ND_TXT_UPDATE: ';
        l_staff_id                    bars.staff$base.id%type;
        l_staff_nm                    bars.staff$base.logname%type;
    BEGIN
        start_process(l_tbl_name, 'SYNC');
        SELECT id, logname into l_staff_id, l_staff_nm FROM bars.staff$base WHERE logname = G_LOGNAME;
        INSERT INTO BARS.ND_TXT_UPDATE(ND,
                                       TAG,
                                       TXT,
                                       CHGDATE,
                                       CHGACTION,
                                       DONEBY,
                                       IDUPD,
                                       KF,
                                       EFFECTDATE,
                                       GLOBAL_BDATE)
            SELECT DECODE(n.nd, NULL, u.nd, n.nd),
                   DECODE(n.nd, NULL, u.tag, n.tag),
                   DECODE(n.nd, NULL, u.txt, n.txt),
                   SYSDATE,
                   DECODE(n.nd, NULL, 3, 2),
                   l_staff_nm,
                   bars.bars_sqnc.get_nextval('s_nd_txt_update', COALESCE(n.KF, u.KF)),
                   DECODE(n.nd, NULL, u.kf, n.kf),
                   COALESCE(bars.gl.bd, bars.glb_bankdate) EFFECTDATE,
                   bars.glb_bankdate GLOBAL_BDATE
              FROM BARS.ND_TXT n
                   FULL OUTER JOIN (SELECT *
                                      FROM BARS.ND_TXT_UPDATE u1
                                     WHERE u1.IDUPD IN (  SELECT MAX(u2.IDUPD)
                                                            FROM BARS.ND_TXT_UPDATE u2
                                                           GROUP BY u2.nd, u2.tag, u2.kf)
                                       AND u1.CHGACTION <> 3) u
                       ON (n.KF = u.KF AND n.nd = u.nd AND n.tag = u.tag)
             WHERE (DECODE(n.ND,  u.ND,  1, 0) = 0
                 OR DECODE(n.TAG, u.TAG, 1, 0) = 0
                 OR DECODE(n.TXT, u.TXT, 1, 0) = 0
                 OR DECODE(n.KF,  u.KF,  1, 0) = 0);

        INS_STAT('rowcount',
                 'SYNC',
                 SQL%ROWCOUNT,
                 l_tbl_name);
        end_process(l_tbl_name, 'SYNC');
        COMMIT;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            error_process(l_tbl_name, 'ERR', substr(dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace(), 1, 1000) );
            RAISE;
    END;

    --------------------------------------------------------------------------------------------------------------------
    -- SYNC_ND_TXT_UPDATE_DWH
    -- синхронизация только тех тегов, которые передаются в DWH
    --------------------------------------------------------------------------------------------------------------------
    PROCEDURE SYNC_ND_TXT_UPDATE_DWH( p_id OUT NUMBER, p_rowcount OUT NUMBER)
    IS
        l_tbl_name                    VARCHAR2(100) := 'ND_TXT_UPDATE';
        l_trace                       varchar2(500) := G_TRACE || 'SYNC_ND_TXT_UPDATE_DWH: ';
        l_staff_id                    bars.staff$base.id%type;
        l_staff_nm                    bars.staff$base.logname%type;
    BEGIN
        start_process(l_tbl_name, 'SYNC');
        SELECT id, logname into l_staff_id, l_staff_nm FROM bars.staff$base WHERE logname = G_LOGNAME;
        INSERT INTO BARS.ND_TXT_UPDATE(ND,
                                       TAG,
                                       TXT,
                                       CHGDATE,
                                       CHGACTION,
                                       DONEBY,
                                       IDUPD,
                                       KF,
                                       EFFECTDATE,
                                       GLOBAL_BDATE)
            WITH tg as (select /*+ inline */ tag  from barsupl.upl_tag_lists where tag_table in ('CC_TAGS', 'CD_TAGS'))
            SELECT DECODE(n.nd, NULL, u.nd, n.nd) as ND,
                   DECODE(n.nd, NULL, u.tag, n.tag) as TAG,
                   DECODE(n.nd, NULL, u.txt, n.txt) as TXT,
                   SYSDATE as CHGDATE,
                   DECODE(n.nd, NULL, 3, 2) as CHGACTION,
                   l_staff_nm as DONEBY,
                   bars.bars_sqnc.get_nextval('s_nd_txt_update', COALESCE(n.KF, u.KF)) as IDUPD,
                   DECODE(n.nd, NULL, u.kf, n.kf) as KF,
                   COALESCE(bars.gl.bd, bars.glb_bankdate) as EFFECTDATE,
                   bars.glb_bankdate as GLOBAL_BDATE
              FROM BARS.ND_TXT n
                   JOIN tg on (n.tag = tg.tag)
                   FULL OUTER JOIN (SELECT *
                                      FROM BARS.ND_TXT_UPDATE u1
                                     WHERE u1.IDUPD IN (  SELECT MAX(u2.IDUPD)
                                                            FROM BARS.ND_TXT_UPDATE u2, tg
                                                           WHERE u2.tag = tg.tag
                                                           GROUP BY u2.nd, u2.tag, u2.kf)
                                       AND u1.CHGACTION <> 3) u
                       ON (n.KF = u.KF AND n.nd = u.nd AND n.tag = u.tag)
             WHERE (DECODE(n.ND,  u.ND,  1, 0) = 0
                 OR DECODE(n.TAG, u.TAG, 1, 0) = 0
                 OR DECODE(n.TXT, u.TXT, 1, 0) = 0
                 OR DECODE(n.KF,  u.KF,  1, 0) = 0);

        INS_STAT('rowcount',
                 'SYNC',
                 SQL%ROWCOUNT,
                 l_tbl_name);
        end_process(l_tbl_name, 'SYNC');
        COMMIT;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            error_process(l_tbl_name, 'ERR', substr(dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace(), 1, 1000) );
            RAISE;
    END;

    --------------------------------------------------------------------------------------------------------------------
    -- CHECK_W4_ACC_UPDATE
    --------------------------------------------------------------------------------------------------------------------
    PROCEDURE CHECK_W4_ACC_UPDATE
    IS
        l_tbl_name                    VARCHAR2(100) := 'W4_ACC_UPDATE';
        l_trace                       varchar2(500) := G_TRACE || 'CHECK_W4_ACC_UPDATE: ';
    BEGIN
        start_process(l_tbl_name, 'CHECK');

        INSERT INTO BARS.UPDATE_TBL_STAT(ID,
                                         STAT_ID,
                                         FIELD_NAME,
                                         FIELD_TYPE,
                                         VALUE,
                                         RUN_ID,
                                         STARTDATE,
                                         ENDDATE,
                                         TBL_NAME)
            SELECT BARS.S_UPDATE_TBL_STAT.NEXTVAL,
                   G_STAT_ID,
                   DECODE(t_pivot.i,
                          1,  f1,   2,  f2,   3,  f3,   4,  f4,
                          5,  f5,   6,  f6,   7,  f7,   8,  f8,
                          9,  f9,   10, f10,  11, f11,  12, f12,
                          13, f13,  14, f14,  15, f15,  16, f16,
                          17, f17,  18, f18,  19, f19,  20, f20,
                          21, f21,  22, f22,  23, f23,  24, f24,
                          25, f25,  26, f26,  27, f27,  28, f28,
                          29, f29,  30, f30)  AS field,
                   'count_diff' type1,
                   DECODE(t_pivot.i,
                          1,  c1,   2,  c2,   3,  c3,   4,  c4,
                          5,  c5,   6,  c6,   7,  c7,   8,  c8,
                          9,  c9,   10, c10,  11, c11,  12, c12,
                          13, c13,  14, c14,  15, c15,  16, c16,
                          17, c17,  18, c18,  19, c19,  20, c20,
                          21, c21,  22, c22,  23, c23,  24, c24,
                          25, c25,  26, c26,  27, c27,  28, c28,
                          29, c29,  30, decode(c30, null, 0, c30))  AS CNTDIFF,
                   G_RUN_ID,
                   G_START_DT,
                   G_END_DT,
                   l_tbl_name
              FROM (    SELECT ROWNUM AS i
                          FROM DUAL
                    CONNECT BY LEVEL <= 30) t_pivot,
                   (SELECT /*+ no_index(u PK_W4ACC_UPDATE) */
                          SUM(1) c30,                           'TOTAL_ROWS' f30,
                           SUM(DECODE(n.ACC_PK, u.ACC_PK, 0, 1)) c1,          'ACC_PK' f1,
                           SUM(DECODE(n.ACC_OVR, u.ACC_OVR, 0, 1)) c2,        'ACC_OVR' f2,
                           SUM(DECODE(n.ACC_9129, u.ACC_9129, 0, 1)) c3,      'ACC_9129' f3,
                           SUM(DECODE(n.ACC_3570, u.ACC_3570, 0, 1)) c4,      'ACC_3570' f4,
                           SUM(DECODE(n.ACC_2208, u.ACC_2208, 0, 1)) c5,      'ACC_2208' f5,
                           SUM(DECODE(n.ACC_2627, u.ACC_2627, 0, 1)) c6,      'ACC_2627' f6,
                           SUM(DECODE(n.ACC_2207, u.ACC_2207, 0, 1)) c7,      'ACC_2207' f7,
                           SUM(DECODE(n.ACC_3579, u.ACC_3579, 0, 1)) c8,      'ACC_3579' f8,
                           SUM(DECODE(n.ACC_2209, u.ACC_2209, 0, 1)) c9,      'ACC_2209' f9,
                           SUM(DECODE(n.CARD_CODE, u.CARD_CODE, 0, 1)) c10,   'CARD_CODE' f10,
                           SUM(DECODE(n.ACC_2625X, u.ACC_2625X, 0, 1)) c11,   'ACC_2625X' f11,
                           SUM(DECODE(n.ACC_2627X, u.ACC_2627X, 0, 1)) c12,   'ACC_2627X' f12,
                           SUM(DECODE(n.ACC_2625D, u.ACC_2625D, 0, 1)) c13,   'ACC_2625D' f13,
                           SUM(DECODE(n.ACC_2628, u.ACC_2628, 0, 1)) c14,     'ACC_2628' f14,
                           SUM(DECODE(n.ACC_2203, u.ACC_2203, 0, 1)) c15,     'ACC_2203' f15,
                           SUM(DECODE(n.FIN, u.FIN, 0, 1)) c16,               'FIN' f16,
                           SUM(DECODE(n.FIN23, u.FIN23, 0, 1)) c17,           'FIN23' f17,
                           SUM(DECODE(n.OBS23, u.OBS23, 0, 1)) c18,           'OBS23' f18,
                           SUM(DECODE(n.KAT23, u.KAT23, 0, 1)) c19,           'KAT23' f19,
                           SUM(DECODE(n.K23, u.K23, 0, 1)) c20,               'K23' f20,
                           SUM(DECODE(n.DAT_BEGIN, u.DAT_BEGIN, 0, 1)) c21,   'DAT_BEGIN' f21,
                           SUM(DECODE(n.DAT_END, u.DAT_END, 0, 1)) c22,       'DAT_END' f22,
                           SUM(DECODE(n.DAT_CLOSE, u.DAT_CLOSE, 0, 1)) c23,   'DAT_CLOSE' f23,
                           SUM(DECODE(n.PASS_DATE, u.PASS_DATE, 0, 1)) c24,   'PASS_DATE' f24,
                           SUM(DECODE(n.PASS_STATE, u.PASS_STATE, 0, 1)) c25, 'PASS_STATE' f25,
                           SUM(DECODE(n.KOL_SP, u.KOL_SP, 0, 1)) c26,         'KOL_SP' f26,
                           SUM(DECODE(n.S250, u.S250, 0, 1)) c27,             'S250' f27,
                           SUM(DECODE(n.GRP, u.GRP, 0, 1)) c28,               'GRP' f28,
                           SUM(DECODE(n.KF, u.KF, 0, 1)) c29,                 'KF' f29
                      FROM BARS.W4_ACC_UPDATE u FULL OUTER JOIN BARS.W4_ACC n ON (u.nd = n.nd)
                     WHERE (DECODE(n.ACC_PK, u.ACC_PK, 1, 0) = 0
                         OR DECODE(n.ACC_OVR, u.ACC_OVR, 1, 0) = 0
                         OR DECODE(n.ACC_9129, u.ACC_9129, 1, 0) = 0
                         OR DECODE(n.ACC_3570, u.ACC_3570, 1, 0) = 0
                         OR DECODE(n.ACC_2208, u.ACC_2208, 1, 0) = 0
                         OR DECODE(n.ACC_2627, u.ACC_2627, 1, 0) = 0
                         OR DECODE(n.ACC_2207, u.ACC_2207, 1, 0) = 0
                         OR DECODE(n.ACC_3579, u.ACC_3579, 1, 0) = 0
                         OR DECODE(n.ACC_2209, u.ACC_2209, 1, 0) = 0
                         OR DECODE(n.CARD_CODE, u.CARD_CODE, 1, 0) = 0
                         OR DECODE(n.ACC_2625X, u.ACC_2625X, 1, 0) = 0
                         OR DECODE(n.ACC_2627X, u.ACC_2627X, 1, 0) = 0
                         OR DECODE(n.ACC_2625D, u.ACC_2625D, 1, 0) = 0
                         OR DECODE(n.ACC_2628, u.ACC_2628, 1, 0) = 0
                         OR DECODE(n.ACC_2203, u.ACC_2203, 1, 0) = 0
                         OR DECODE(n.FIN, u.FIN, 1, 0) = 0
                         OR DECODE(n.FIN23, u.FIN23, 1, 0) = 0
                         OR DECODE(n.OBS23, u.OBS23, 1, 0) = 0
                         OR DECODE(n.KAT23, u.KAT23, 1, 0) = 0
                         OR DECODE(n.K23, u.K23, 1, 0) = 0
                         OR DECODE(n.DAT_BEGIN, u.DAT_BEGIN, 1, 0) = 0
                         OR DECODE(n.DAT_END, u.DAT_END, 1, 0) = 0
                         OR DECODE(n.DAT_CLOSE, u.DAT_CLOSE, 1, 0) = 0
                         OR DECODE(n.PASS_DATE, u.PASS_DATE, 1, 0) = 0
                         OR DECODE(n.PASS_STATE, u.PASS_STATE, 1, 0) = 0
                         OR DECODE(n.KOL_SP, u.KOL_SP, 1, 0) = 0
                         OR DECODE(n.S250, u.S250, 1, 0) = 0
                         OR DECODE(n.GRP, u.GRP, 1, 0) = 0
                         OR DECODE(n.KF, u.KF, 1, 0) = 0)
                       and n.kf = bars.gl.kf
                       and u.IDUPD IN (  SELECT /*+ no_index(u1 PK_W4ACC_UPDATE) */
                                                MAX(u1.IDUPD)
                                           FROM BARS.W4_ACC_UPDATE u1
                                          where u1.kf = bars.gl.kf
                                       GROUP BY u1.nd)
                       AND u.chgaction <> 'D');
        end_process(l_tbl_name, 'CHECK');
        COMMIT;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            error_process(l_tbl_name, 'ERR', substr(dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace(), 1, 1000) );
            RAISE;
    END;

    --------------------------------------------------------------------------------------------------------------------
    -- SYNC_W4_ACC_UPDATE
    --------------------------------------------------------------------------------------------------------------------
    PROCEDURE SYNC_W4_ACC_UPDATE( p_id OUT NUMBER, p_rowcount OUT NUMBER)
    IS
        l_tbl_name                    VARCHAR2(100) := 'W4_ACC_UPDATE';
        l_trace                       varchar2(500) := G_TRACE || 'SYNC_W4_ACC_UPDATE: ';
        l_staff_id                    bars.staff$base.id%type;
        l_staff_nm                    bars.staff$base.logname%type;
    BEGIN
        start_process(l_tbl_name, 'SYNC');
        SELECT id, logname into l_staff_id, l_staff_nm FROM bars.staff$base WHERE logname = G_LOGNAME;
        INSERT /*+ APPEND */
              INTO  BARS.W4_ACC_UPDATE(idupd,
                                       chgaction,
                                       effectdate,
                                       chgdate,
                                       doneby,
                                       nd,
                                       acc_pk,
                                       acc_ovr,
                                       acc_9129,
                                       acc_3570,
                                       acc_2208,
                                       acc_2627,
                                       acc_2207,
                                       acc_3579,
                                       acc_2209,
                                       card_code,
                                       acc_2625x,
                                       acc_2627x,
                                       acc_2625d,
                                       acc_2628,
                                       acc_2203,
                                       fin,
                                       fin23,
                                       obs23,
                                       kat23,
                                       k23,
                                       dat_begin,
                                       dat_end,
                                       dat_close,
                                       pass_date,
                                       pass_state,
                                       kol_sp,
                                       s250,
                                       grp,
                                       global_bdate,
                                       kf)
            SELECT /*+ no_index(u PK_W4ACC_UPDATE) */
                  bars_sqnc.get_nextval('s_w4acc_update', COALESCE(n.KF, u.KF)) AS idupd,
                   CASE WHEN n.nd IS NULL THEN 'D' ELSE 'U' END AS chgaction,
                   NVL(GREATEST(COALESCE(u.EFFECTDATE, TO_DATE('01/01/1900', 'dd/mm/yyyy')),                                 -- максимальный из update
                                (SELECT MAX(a.daos) dt                                                        -- либо максимальная дата открытия счета
                                   FROM bars.accounts a
                                  WHERE a.acc IN (n.acc_pk,
                                                  n.acc_ovr,
                                                  n.acc_9129,
                                                  n.acc_3570,
                                                  n.acc_2208,
                                                  n.acc_2627,
                                                  n.acc_2207,
                                                  n.acc_3579,
                                                  n.acc_2209,
                                                  n.acc_2625x,
                                                  n.acc_2627x,
                                                  n.acc_2625d,
                                                  n.acc_2628,
                                                  n.acc_2203))),
                       bars.gl.bd)
                       AS effectdate,                                                                                   -- либо текущая (по умолчанию)
                   SYSDATE AS chgdate,
                   l_staff_id AS doneby,
                   DECODE(n.nd, NULL, u.nd, n.nd) AS nd,
                   DECODE(n.nd, NULL, u.acc_pk, n.acc_pk) AS acc_pk,
                   DECODE(n.nd, NULL, u.acc_ovr, n.acc_ovr) AS acc_ovr,
                   DECODE(n.nd, NULL, u.acc_9129, n.acc_9129) AS acc_9129,
                   DECODE(n.nd, NULL, u.acc_3570, n.acc_3570) AS acc_3570,
                   DECODE(n.nd, NULL, u.acc_2208, n.acc_2208) AS acc_2208,
                   DECODE(n.nd, NULL, u.acc_2627, n.acc_2627) AS acc_2627,
                   DECODE(n.nd, NULL, u.acc_2207, n.acc_2207) AS acc_2207,
                   DECODE(n.nd, NULL, u.acc_3579, n.acc_3579) AS acc_3579,
                   DECODE(n.nd, NULL, u.acc_2209, n.acc_2209) AS acc_2209,
                   DECODE(n.nd, NULL, u.card_code, n.card_code) AS card_code,
                   DECODE(n.nd, NULL, u.acc_2625x, n.acc_2625x) AS acc_2625x,
                   DECODE(n.nd, NULL, u.acc_2627x, n.acc_2627x) AS acc_2627x,
                   DECODE(n.nd, NULL, u.acc_2625d, n.acc_2625d) AS acc_2625d,
                   DECODE(n.nd, NULL, u.acc_2628, n.acc_2628) AS acc_2628,
                   DECODE(n.nd, NULL, u.acc_2203, n.acc_2203) AS acc_2203,
                   DECODE(n.nd, NULL, u.fin, n.fin) AS fin,
                   DECODE(n.nd, NULL, u.fin23, n.fin23) AS fin23,
                   DECODE(n.nd, NULL, u.obs23, n.obs23) AS obs23,
                   DECODE(n.nd, NULL, u.kat23, n.kat23) AS kat23,
                   DECODE(n.nd, NULL, u.k23, n.k23) AS k23,
                   DECODE(n.nd, NULL, u.dat_begin, n.dat_begin) AS dat_begin,
                   DECODE(n.nd, NULL, u.dat_end, n.dat_end) AS dat_end,
                   DECODE(n.nd, NULL, u.dat_close, n.dat_close) AS dat_close,
                   DECODE(n.nd, NULL, u.pass_date, n.pass_date) AS pass_date,
                   DECODE(n.nd, NULL, u.pass_state, n.pass_state) AS pass_state,
                   DECODE(n.nd, NULL, u.kol_sp, n.kol_sp) AS kol_sp,
                   DECODE(n.nd, NULL, u.s250, n.s250) AS s250,
                   DECODE(n.nd, NULL, u.grp, n.grp) AS grp,
                   bars.gl.bd AS global_bdate,
                   DECODE(n.nd, NULL, u.kf, n.kf) AS kf
              FROM BARS.W4_ACC_UPDATE u
                   FULL OUTER JOIN BARS.W4_ACC n ON (u.nd = n.nd)
             WHERE (DECODE(n.ND, u.ND, 1, 0) = 0
                 OR DECODE(n.ACC_PK, u.ACC_PK, 1, 0) = 0
                 OR DECODE(n.ACC_OVR, u.ACC_OVR, 1, 0) = 0
                 OR DECODE(n.ACC_9129, u.ACC_9129, 1, 0) = 0
                 OR DECODE(n.ACC_3570, u.ACC_3570, 1, 0) = 0
                 OR DECODE(n.ACC_2208, u.ACC_2208, 1, 0) = 0
                 OR DECODE(n.ACC_2627, u.ACC_2627, 1, 0) = 0
                 OR DECODE(n.ACC_2207, u.ACC_2207, 1, 0) = 0
                 OR DECODE(n.ACC_3579, u.ACC_3579, 1, 0) = 0
                 OR DECODE(n.ACC_2209, u.ACC_2209, 1, 0) = 0
                 OR DECODE(n.CARD_CODE, u.CARD_CODE, 1, 0) = 0
                 OR DECODE(n.ACC_2625X, u.ACC_2625X, 1, 0) = 0
                 OR DECODE(n.ACC_2627X, u.ACC_2627X, 1, 0) = 0
                 OR DECODE(n.ACC_2625D, u.ACC_2625D, 1, 0) = 0
                 OR DECODE(n.ACC_2628, u.ACC_2628, 1, 0) = 0
                 OR DECODE(n.ACC_2203, u.ACC_2203, 1, 0) = 0
                 OR DECODE(n.FIN, u.FIN, 1, 0) = 0
                 OR DECODE(n.FIN23, u.FIN23, 1, 0) = 0
                 OR DECODE(n.OBS23, u.OBS23, 1, 0) = 0
                 OR DECODE(n.KAT23, u.KAT23, 1, 0) = 0
                 OR DECODE(n.K23, u.K23, 1, 0) = 0
                 OR DECODE(n.DAT_BEGIN, u.DAT_BEGIN, 1, 0) = 0
                 OR DECODE(n.DAT_END, u.DAT_END, 1, 0) = 0
                 OR DECODE(n.DAT_CLOSE, u.DAT_CLOSE, 1, 0) = 0
                 OR DECODE(n.PASS_DATE, u.PASS_DATE, 1, 0) = 0
                 OR DECODE(n.PASS_STATE, u.PASS_STATE, 1, 0) = 0
                 OR DECODE(n.KOL_SP, u.KOL_SP, 1, 0) = 0
                 OR DECODE(n.S250, u.S250, 1, 0) = 0
                 OR DECODE(n.GRP, u.GRP, 1, 0) = 0
                 OR DECODE(n.KF, u.KF, 1, 0) = 0)
               and (u.IDUPD IN (  SELECT /*+ no_index(w4u PK_W4ACC_UPDATE) */
                                         MAX(w4u.IDUPD)
                                    FROM BARS.W4_ACC_UPDATE w4u
                                GROUP BY w4u.nd)
                AND u.chgaction <> 'D');

        INS_STAT('rowcount',
                 'SYNC',
                 SQL%ROWCOUNT,
                 l_tbl_name);
        end_process(l_tbl_name, 'SYNC');
        COMMIT;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            error_process(l_tbl_name, 'ERR', substr(dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace(), 1, 1000) );
            RAISE;
    END;


    --------------------------------------------------------------------------------------------------------------------
    -- CHECK_BPK_ACC_UPDATE
    --------------------------------------------------------------------------------------------------------------------
    PROCEDURE CHECK_BPK_ACC_UPDATE
    IS
        l_tbl_name                    VARCHAR2(100) := 'BPK_ACC_UPDATE';
        l_trace                       varchar2(500) := G_TRACE || 'CHECK_BPK_ACC_UPDATE: ';
    BEGIN
        start_process(l_tbl_name, 'CHECK');

        INSERT INTO BARS.UPDATE_TBL_STAT(ID,
                                         STAT_ID,
                                         FIELD_NAME,
                                         FIELD_TYPE,
                                         VALUE,
                                         RUN_ID,
                                         STARTDATE,
                                         ENDDATE,
                                         TBL_NAME)
            SELECT BARS.S_UPDATE_TBL_STAT.NEXTVAL,
                   G_STAT_ID,
                   DECODE(t_pivot.i,
                          1,  f1,   2,  f2,   3,  f3,   4,  f4,
                          5,  f5,   6,  f6,   7,  f7,   8,  f8,
                          9,  f9,   10, f10,  11, f11,  12, f12,
                          13, f13,  14, f14,  15, f15,  16, f16,
                          17, f17,  18, f18,  19, f19,  20, f20,
                          21, f21,  22, f22,  23, f23)  AS field,
                   'count_diff' type1,
                   DECODE(t_pivot.i,
                          1,  decode(c1, null, 0, c1),
                                    2,  c2,   3,  c3,   4,  c4,
                          5,  c5,   6,  c6,   7,  c7,   8,  c8,
                          9,  c9,   10, c10,  11, c11,  12, c12,
                          13, c13,  14, c14,  15, c15,  16, c16,
                          17, c17,  18, c18,  19, c19,  20, c20,
                          21, c21,  22, c22,  23, c23)  AS CNTDIFF,
                   G_RUN_ID,
                   G_START_DT,
                   G_END_DT,
                   l_tbl_name
              FROM (    SELECT ROWNUM AS i
                          FROM DUAL
                    CONNECT BY LEVEL <= 23) t_pivot,
                   (SELECT SUM(1) c1,                                         'TOTAL_ROWS' f1,
                           SUM(DECODE(n.ACC_PK, u.ACC_PK, 0, 1)) c2,          'ACC_PK' f2,
                           SUM(DECODE(n.ACC_OVR, u.ACC_OVR, 0, 1)) c3,        'ACC_OVR' f3,
                           SUM(DECODE(n.ACC_9129, u.ACC_9129, 0, 1)) c4,      'ACC_9129' f4,
                           SUM(DECODE(n.ACC_TOVR, u.ACC_TOVR, 0, 1)) c5,      'ACC_TOVR' f5,
                           SUM(DECODE(n.KF, u.KF, 0, 1)) c6,                  'KF' f6,
                           SUM(DECODE(n.ACC_3570, u.ACC_3570, 0, 1)) c7,      'ACC_3570' f7,
                           SUM(DECODE(n.ACC_2208, u.ACC_2208, 0, 1)) c8,      'ACC_2208' f8,
                           SUM(DECODE(n.PRODUCT_ID, u.PRODUCT_ID, 0, 1)) c9,  'PRODUCT_ID' f9,
                           SUM(DECODE(n.ACC_2207, u.ACC_2207, 0, 1)) c10,     'ACC_2207' f10,
                           SUM(DECODE(n.ACC_3579, u.ACC_3579, 0, 1)) c11,     'ACC_3579' f11,
                           SUM(DECODE(n.ACC_2209, u.ACC_2209, 0, 1)) c12,     'ACC_2209' f12,
                           SUM(DECODE(n.ACC_W4, u.ACC_W4, 0, 1)) c13,         'ACC_W4' f13,
                           SUM(DECODE(n.FIN, u.FIN, 0, 1)) c14,               'FIN' f14,
                           SUM(DECODE(n.FIN23, u.FIN23, 0, 1)) c15,           'FIN23' f15,
                           SUM(DECODE(n.OBS23, u.OBS23, 0, 1)) c16,           'OBS23' f16,
                           SUM(DECODE(n.KAT23, u.KAT23, 0, 1)) c17,           'KAT23' f17,
                           SUM(DECODE(n.K23, u.K23, 0, 1)) c18,               'K23' f18,
                           SUM(DECODE(n.DAT_END, u.DAT_END, 0, 1)) c19,       'DAT_END' f19,
                           SUM(DECODE(n.KOL_SP, u.KOL_SP, 0, 1)) c20,         'KOL_SP' f20,
                           SUM(DECODE(n.S250, u.S250, 0, 1)) c21,             'S250' f21,
                           SUM(DECODE(n.GRP, u.GRP, 0, 1)) c22,               'GRP' f22,
                           SUM(DECODE(n.DAT_CLOSE, u.DAT_CLOSE, 0, 1)) c23,   'DAT_CLOSE' f23
                      FROM (SELECT *
                              FROM BARS.BPK_ACC_UPDATE
                             WHERE IDUPD IN (  SELECT MAX(IDUPD)
                                                 FROM BARS.BPK_ACC_UPDATE
                                             GROUP BY nd)
                               AND chgaction != 'D') u
                           FULL OUTER JOIN BARS.BPK_ACC n ON (u.nd = n.nd AND u.kf = n.kf)
                     WHERE (DECODE(n.ACC_PK, u.ACC_PK, 1, 0) = 0
                         OR DECODE(n.ACC_OVR, u.ACC_OVR, 1, 0) = 0
                         OR DECODE(n.ACC_9129, u.ACC_9129, 1, 0) = 0
                         OR DECODE(n.ACC_TOVR, u.ACC_TOVR, 1, 0) = 0
                         OR DECODE(n.KF, u.KF, 1, 0) = 0
                         OR DECODE(n.ACC_3570, u.ACC_3570, 1, 0) = 0
                         OR DECODE(n.ACC_2208, u.ACC_2208, 1, 0) = 0
                         OR DECODE(n.PRODUCT_ID, u.PRODUCT_ID, 1, 0) = 0
                         OR DECODE(n.ACC_2207, u.ACC_2207, 1, 0) = 0
                         OR DECODE(n.ACC_3579, u.ACC_3579, 1, 0) = 0
                         OR DECODE(n.ACC_2209, u.ACC_2209, 1, 0) = 0
                         OR DECODE(n.ACC_W4, u.ACC_W4, 1, 0) = 0
                         OR DECODE(n.FIN, u.FIN, 1, 0) = 0
                         OR DECODE(n.FIN23, u.FIN23, 1, 0) = 0
                         OR DECODE(n.OBS23, u.OBS23, 1, 0) = 0
                         OR DECODE(n.KAT23, u.KAT23, 1, 0) = 0
                         OR DECODE(n.K23, u.K23, 1, 0) = 0
                         OR DECODE(n.DAT_END, u.DAT_END, 1, 0) = 0
                         OR DECODE(n.KOL_SP, u.KOL_SP, 1, 0) = 0
                         OR DECODE(n.S250, u.S250, 1, 0) = 0
                         OR DECODE(n.GRP, u.GRP, 1, 0) = 0
                         OR DECODE(n.DAT_CLOSE, u.DAT_CLOSE, 1, 0) = 0)
                       AND n.KF = bars.gl.kf
                       AND u.KF = bars.gl.kf);
        end_process(l_tbl_name, 'CHECK');
        COMMIT;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            error_process(l_tbl_name, 'ERR', substr(dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace(), 1, 1000) );
            RAISE;
    END;

    --------------------------------------------------------------------------------------------------------------------
    -- SYNC_BPK_ACC_UPDATE
    --------------------------------------------------------------------------------------------------------------------
    PROCEDURE SYNC_BPK_ACC_UPDATE( p_id OUT NUMBER, p_rowcount OUT NUMBER)
    IS
        l_tbl_name                    VARCHAR2(100) := 'BPK_ACC_UPDATE';
        l_trace                       varchar2(500) := G_TRACE || 'SYNC_BPK_ACC_UPDATE: ';
        l_staff_id                    bars.staff$base.id%type;
        l_staff_nm                    bars.staff$base.logname%type;
    BEGIN
        start_process(l_tbl_name, 'SYNC');
        SELECT id, logname into l_staff_id, l_staff_nm FROM bars.staff$base WHERE logname = G_LOGNAME;
        INSERT /*+ APPEND */
              INTO  BARS.BPK_ACC_UPDATE(idupd,
                                        chgaction,
                                        effectdate,
                                        chgdate,
                                        doneby,
                                        ND,
                                        ACC_PK,
                                        ACC_OVR,
                                        ACC_9129,
                                        ACC_TOVR,
                                        KF,
                                        ACC_3570,
                                        ACC_2208,
                                        PRODUCT_ID,
                                        ACC_2207,
                                        ACC_3579,
                                        ACC_2209,
                                        ACC_W4,
                                        FIN,
                                        FIN23,
                                        OBS23,
                                        KAT23,
                                        K23,
                                        DAT_END,
                                        KOL_SP,
                                        S250,
                                        GRP,
                                        GLOBAL_BDATE,
                                        DAT_CLOSE)
            SELECT bars_sqnc.get_nextval('s_bpkacc_update', COALESCE(n.KF, u.KF)) AS idupd,
                   CASE WHEN n.nd IS NULL THEN 'D' ELSE DECODE(u.chgaction, NULL, 'I', 'U') END AS chgaction,
                   NVL(GREATEST(COALESCE(u.EFFECTDATE, TO_DATE('01/01/1900', 'dd/mm/yyyy')),                                 -- максимальный из update
                                (SELECT MAX(a.daos) dt                                                        -- либо максимальная дата открытия счета
                                   FROM bars.accounts a
                                  WHERE a.acc IN (n.acc_w4,
                                                  n.acc_pk,
                                                  n.acc_ovr,
                                                  n.acc_9129,
                                                  n.acc_tovr,
                                                  n.acc_3570,
                                                  n.acc_2208,
                                                  n.acc_2207,
                                                  n.acc_3579,
                                                  n.acc_2209))),
                       bars.gl.bd)
                       AS effectdate,                                                                                   -- либо текущая (по умолчанию)
                   SYSDATE AS chgdate,
                   l_staff_id AS doneby,
                   DECODE(n.nd, NULL, u.ND, n.ND) AS ND,
                   DECODE(n.nd, NULL, u.ACC_PK, n.ACC_PK) AS ACC_PK,
                   DECODE(n.nd, NULL, u.ACC_OVR, n.ACC_OVR) AS ACC_OVR,
                   DECODE(n.nd, NULL, u.ACC_9129, n.ACC_9129) AS ACC_9129,
                   DECODE(n.nd, NULL, u.ACC_TOVR, n.ACC_TOVR) AS ACC_TOVR,
                   DECODE(n.nd, NULL, u.KF, n.KF) AS KF,
                   DECODE(n.nd, NULL, u.ACC_3570, n.ACC_3570) AS ACC_3570,
                   DECODE(n.nd, NULL, u.ACC_2208, n.ACC_2208) AS ACC_2208,
                   DECODE(n.nd, NULL, u.PRODUCT_ID, n.PRODUCT_ID) AS PRODUCT_ID,
                   DECODE(n.nd, NULL, u.ACC_2207, n.ACC_2207) AS ACC_2207,
                   DECODE(n.nd, NULL, u.ACC_3579, n.ACC_3579) AS ACC_3579,
                   DECODE(n.nd, NULL, u.ACC_2209, n.ACC_2209) AS ACC_2209,
                   DECODE(n.nd, NULL, u.ACC_W4, n.ACC_W4) AS ACC_W4,
                   DECODE(n.nd, NULL, u.FIN, n.FIN) AS FIN,
                   DECODE(n.nd, NULL, u.FIN23, n.FIN23) AS FIN23,
                   DECODE(n.nd, NULL, u.OBS23, n.OBS23) AS OBS23,
                   DECODE(n.nd, NULL, u.KAT23, n.KAT23) AS KAT23,
                   DECODE(n.nd, NULL, u.K23, n.K23) AS K23,
                   DECODE(n.nd, NULL, u.DAT_END, n.DAT_END) AS DAT_END,
                   DECODE(n.nd, NULL, u.KOL_SP, n.KOL_SP) AS KOL_SP,
                   DECODE(n.nd, NULL, u.S250, n.S250) AS S250,
                   DECODE(n.nd, NULL, u.GRP, n.GRP) AS GRP,
                   bars.gl.bd AS GLOBAL_BDATE,
                   DECODE(n.nd, NULL, u.DAT_CLOSE, n.DAT_CLOSE) AS DAT_CLOSE
              FROM (SELECT *
                      FROM BARS.BPK_ACC_UPDATE
                     WHERE IDUPD IN (  SELECT MAX(IDUPD)
                                         FROM BARS.BPK_ACC_UPDATE
                                     GROUP BY nd)
                       AND chgaction != 'D') u
                   FULL OUTER JOIN BARS.BPK_ACC n ON (u.nd = n.nd AND u.kf = n.kf)
             WHERE (DECODE(n.ACC_PK, u.ACC_PK, 1, 0) = 0
                 OR DECODE(n.ACC_OVR, u.ACC_OVR, 1, 0) = 0
                 OR DECODE(n.ACC_9129, u.ACC_9129, 1, 0) = 0
                 OR DECODE(n.ACC_TOVR, u.ACC_TOVR, 1, 0) = 0
                 OR DECODE(n.KF, u.KF, 1, 0) = 0
                 OR DECODE(n.ACC_3570, u.ACC_3570, 1, 0) = 0
                 OR DECODE(n.ACC_2208, u.ACC_2208, 1, 0) = 0
                 OR DECODE(n.PRODUCT_ID, u.PRODUCT_ID, 1, 0) = 0
                 OR DECODE(n.ACC_2207, u.ACC_2207, 1, 0) = 0
                 OR DECODE(n.ACC_3579, u.ACC_3579, 1, 0) = 0
                 OR DECODE(n.ACC_2209, u.ACC_2209, 1, 0) = 0
                 OR DECODE(n.ACC_W4, u.ACC_W4, 1, 0) = 0
                 OR DECODE(n.FIN, u.FIN, 1, 0) = 0
                 OR DECODE(n.FIN23, u.FIN23, 1, 0) = 0
                 OR DECODE(n.OBS23, u.OBS23, 1, 0) = 0
                 OR DECODE(n.KAT23, u.KAT23, 1, 0) = 0
                 OR DECODE(n.K23, u.K23, 1, 0) = 0
                 OR DECODE(n.DAT_END, u.DAT_END, 1, 0) = 0
                 OR DECODE(n.KOL_SP, u.KOL_SP, 1, 0) = 0
                 OR DECODE(n.S250, u.S250, 1, 0) = 0
                 OR DECODE(n.GRP, u.GRP, 1, 0) = 0
                 OR DECODE(n.DAT_CLOSE, u.DAT_CLOSE, 1, 0) = 0);

        INS_STAT('rowcount',
                 'SYNC',
                 SQL%ROWCOUNT,
                 l_tbl_name);
        end_process(l_tbl_name, 'SYNC');
        COMMIT;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            error_process(l_tbl_name, 'ERR', substr(dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace(), 1, 1000) );
            RAISE;
    END;

END;
/

PROMPT *** Create  grants  UPDATE_TBL_UTL ***
grant EXECUTE                                                                on UPDATE_TBL_UTL     to BARSUPL;
grant EXECUTE                                                                on UPDATE_TBL_UTL     to BARS_ACCESS_USER;
grant EXECUTE                                                                on UPDATE_TBL_UTL     to UPLD;


PROMPT =====================================================================================
PROMPT *** End *** ============= Scripts /Sql/BARS/package/update_tbl_utl.sql ============***
PROMPT =====================================================================================
