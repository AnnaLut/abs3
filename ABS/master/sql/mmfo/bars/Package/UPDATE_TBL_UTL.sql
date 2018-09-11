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
    -- version 1.1 10.05.2018 (Kharin) Добавлены функции для таблиц:
    --                        BPK_PARAMETERS  <-> BPK_PARAMETERS_UPDATE
    -- version 1.2 16.05.2018 (Kharin) Добавлены функции для таблиц:
    --                        CC_DEAL  <-> CC_DEAL_UPDATE
    -- version 1.3 18.05.2018 (Kharin) Исправлена процедура SYNC_BPK_PARAMETERS_UPDATE
    -- version 1.4 25.07.2018 (LesivRI) Добавлены нові процедури TRIM_W4_ACC_UPDATE, TRIM_BPK_ACC_UPDATE, SYNC_VIP_FLAGS_ARC, CHECK_VIP_FLAGS_ARC, CHECK_CP_ACCOUNTS_UPDATE, SYNC_CP_ACCOUNTS_UPDATE
    --                                  добавлені перегружені процедури:
    --                                  CHECK_ACCOUNTS_UPDATE( p_id out number)
    --                                  SYNC_ACCOUNTS_UPDATE
    --                                  CHECK_CC_DEAL_UPDATE( p_id out number)
    --                                  SYNC_CC_DEAL_UPDATE
    --                                  CHECK_DPT_DEPOSIT_CLOS( p_id out number)
    --                                  SYNC_DPT_DEPOSIT_CLOS
    --                                  CHECK_CUSTOMERW_UPDATE( p_id out number)
    --                                  SYNC_CUSTOMERW_UPDATE
    --                                  SYNC_CUSTOMERW_UPDATE_DWH
    --                                  CHECK_ACCOUNTSW_UPDATE( p_id out number)
    --                                  SYNC_ACCOUNTSW_UPDATE
    --                                  SYNC_ACCOUNTSW_UPDATE_DWH
    --                                  CHECK_ND_TXT_UPDATE( p_id out number)
    --                                  SYNC_ND_TXT_UPDATE
    --                                  SYNC_ND_TXT_UPDATE_DWH
    --                                  CHECK_W4_ACC_UPDATE( p_id out number)
    --                                  SYNC_W4_ACC_UPDATE
    --                                  CHECK_BPK_ACC_UPDATE( p_id out number)
    --                                  SYNC_BPK_ACC_UPDATE
    --                                  CHECK_BPK_PARAMETERS_UPDATE( p_id out number)
    --                                  SYNC_BPK_PARAMETERS_UPDATE
    --                                  SYNC_BPK_PARAMETERS_UPDATE_DWH
    --                                  CHECK_VIP_FLAGS_ARC( p_id out number)
    --                                  SYNC_VIP_FLAGS_ARC
    --                                  CHECK_CP_ACCOUNTS_UPDATE( p_id out number)
    --                                  SYNC_CP_ACCOUNTS_UPDATE

    -----------------------------------------------------------------

    G_HEADER_VERSION      constant varchar2(64)  := 'version 1.4 25.07.2018';

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
    procedure CHECK_ACCOUNTS_UPDATE;
    procedure CHECK_ACCOUNTS_UPDATE( p_id out number);
    procedure SYNC_ACCOUNTS_UPDATE;
    procedure SYNC_ACCOUNTS_UPDATE( p_id out number, p_rowcount out number);

    --------------------------------------------------------------------------------------------------------------------
    -- CC_DEAL_UPDATE
    --------------------------------------------------------------------------------------------------------------------
    procedure CHECK_CC_DEAL_UPDATE;
    procedure CHECK_CC_DEAL_UPDATE( p_id out number);
    procedure SYNC_CC_DEAL_UPDATE;
    procedure SYNC_CC_DEAL_UPDATE( p_id out number, p_rowcount out number);

    --------------------------------------------------------------------------------------------------------------------
    -- DPT_DEPOSIT_CLOS
    -- если есть запись в DPT_DEPOSIT_CLOS и нет в DPT_DEPOSIT - ничего не делаем, хотя в DPT_DEPOSIT_CLOS может отсутствовать факт переноса в архив
    -- если есть запись в DPT_DEPOSIT и нет в DPT_DEPOSIT_CLOS - также ничего не делаем, хотя нужно было-бы добавить заись с action_id=0
    -- поэтому проверяем расхождения только если записи есть в обеих таблицах
    --------------------------------------------------------------------------------------------------------------------
    procedure CHECK_DPT_DEPOSIT_CLOS;
    procedure CHECK_DPT_DEPOSIT_CLOS( p_id out number);
    procedure SYNC_DPT_DEPOSIT_CLOS;
    procedure SYNC_DPT_DEPOSIT_CLOS( p_id out number, p_rowcount out number);

    --------------------------------------------------------------------------------------------------------------------
    -- CUSTOMERW_UPDATE
    --------------------------------------------------------------------------------------------------------------------
    procedure CHECK_CUSTOMERW_UPDATE;
    procedure CHECK_CUSTOMERW_UPDATE( p_id out number);
    procedure SYNC_CUSTOMERW_UPDATE;
    procedure SYNC_CUSTOMERW_UPDATE( p_id out number, p_rowcount out number);
    procedure SYNC_CUSTOMERW_UPDATE_DWH;
    procedure SYNC_CUSTOMERW_UPDATE_DWH( p_id OUT NUMBER, p_rowcount OUT NUMBER);

    --------------------------------------------------------------------------------------------------------------------
    -- ACCOUNTSW_UPDATE
    --------------------------------------------------------------------------------------------------------------------
    procedure CHECK_ACCOUNTSW_UPDATE;
    procedure CHECK_ACCOUNTSW_UPDATE( p_id out number);
    procedure SYNC_ACCOUNTSW_UPDATE;
    procedure SYNC_ACCOUNTSW_UPDATE( p_id out number, p_rowcount out number);
    procedure SYNC_ACCOUNTSW_UPDATE_DWH;
    procedure SYNC_ACCOUNTSW_UPDATE_DWH( p_id out number, p_rowcount out number);

    --------------------------------------------------------------------------------------------------------------------
    -- ND_TXT_UPDATE
    --------------------------------------------------------------------------------------------------------------------
    procedure CHECK_ND_TXT_UPDATE;
    procedure CHECK_ND_TXT_UPDATE( p_id out number);
    procedure SYNC_ND_TXT_UPDATE;
    procedure SYNC_ND_TXT_UPDATE( p_id out number, p_rowcount out number);
    procedure SYNC_ND_TXT_UPDATE_DWH;
    procedure SYNC_ND_TXT_UPDATE_DWH( p_id out number, p_rowcount out number);

    --------------------------------------------------------------------------------------------------------------------
    -- W4_ACC_UPDATE
    --------------------------------------------------------------------------------------------------------------------
    procedure CHECK_W4_ACC_UPDATE;
    procedure CHECK_W4_ACC_UPDATE( p_id out number);
    procedure SYNC_W4_ACC_UPDATE;
    procedure SYNC_W4_ACC_UPDATE( p_id out number, p_rowcount out number);
    --procedure TRIM_W4_ACC_UPDATE( p_dt date);

    --------------------------------------------------------------------------------------------------------------------
    -- BPK_ACC_UPDATE
    --------------------------------------------------------------------------------------------------------------------
    procedure CHECK_BPK_ACC_UPDATE;
    procedure CHECK_BPK_ACC_UPDATE( p_id out number);
    procedure SYNC_BPK_ACC_UPDATE;
    procedure SYNC_BPK_ACC_UPDATE( p_id out number, p_rowcount out number);
    --procedure TRIM_BPK_ACC_UPDATE( p_dt date);

    --------------------------------------------------------------------------------------------------------------------
    -- BPK_PARAMETERS_UPDATE
    --------------------------------------------------------------------------------------------------------------------
    procedure CHECK_BPK_PARAMETERS_UPDATE;
    procedure CHECK_BPK_PARAMETERS_UPDATE( p_id out number);
    procedure SYNC_BPK_PARAMETERS_UPDATE;
    procedure SYNC_BPK_PARAMETERS_UPDATE( p_id out number, p_rowcount out number);
    procedure SYNC_BPK_PARAMETERS_UPDATE_DWH;
    procedure SYNC_BPK_PARAMETERS_UPDATE_DWH( p_id out number, p_rowcount out number);

    --------------------------------------------------------------------------------------------------------------------
    -- VIP_FLAGS_ARC
    --------------------------------------------------------------------------------------------------------------------
    procedure CHECK_VIP_FLAGS_ARC;
    procedure CHECK_VIP_FLAGS_ARC( p_id out number);
    procedure SYNC_VIP_FLAGS_ARC;
    procedure SYNC_VIP_FLAGS_ARC( p_id out number, p_rowcount out number);

    --------------------------------------------------------------------------------------------------------------------
    -- CP_ACCOUNTS_UPDATE
    --------------------------------------------------------------------------------------------------------------------
    procedure CHECK_CP_ACCOUNTS_UPDATE;
    procedure CHECK_CP_ACCOUNTS_UPDATE( p_id out number);
    procedure SYNC_CP_ACCOUNTS_UPDATE;
    procedure SYNC_CP_ACCOUNTS_UPDATE( p_id out number, p_rowcount out number);


end;
/

CREATE OR REPLACE PACKAGE BODY BARS.UPDATE_TBL_UTL
IS
    G_BODY_VERSION       constant varchar2(64) := 'version 1.4 25.07.2018';
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

        INSERT INTO BARS.UPDATE_TBL_STAT(ID, STAT_ID, FIELD_NAME, FIELD_TYPE, VALUE, RUN_ID, STARTDATE, ENDDATE, TBL_NAME, KF)
               VALUES (l_id, G_STAT_ID, p_FIELD_NAME, p_FIELD_TYPE, p_value, G_RUN_ID, G_START_DT, G_END_DT, p_tbl, bars.gl.kf);

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
    -- CHECK_ACCOUNTS_UPDATE( p_id out number)
    --------------------------------------------------------------------------------------------------------------------
    PROCEDURE CHECK_ACCOUNTS_UPDATE( p_id out number)
    IS
        l_tbl_name                    VARCHAR2(100) := 'ACCOUNTS_UPDATE';
        l_trace                       varchar2(500) := G_TRACE || 'CHECK_ACCOUNTS_UPDATE: ';
        l_kf                          varchar2(6)   := bars.gl.kf;
    BEGIN
        start_process(l_tbl_name, 'CHECK');

        INSERT INTO BARS.UPDATE_TBL_STAT(ID, STAT_ID, FIELD_NAME, FIELD_TYPE, VALUE, RUN_ID, STARTDATE, ENDDATE, TBL_NAME)
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
          from (select rownum as i from dual connect by level <= 30) t_pivot,
               (select 'TOTAL_ROWS' as fld30,     sum(1)                                        as c30,
                       'ACC'        as fld1 ,     sum(decode(a.acc      , au.acc       , 0, 1)) as c1 ,
                       'KF'         as fld2 ,     sum(decode(a.kf       , au.kf        , 0, 1)) as c2 ,
                       'NLS'        as fld3 ,     sum(decode(a.nls      , au.nls       , 0, 1)) as c3 ,
                       'KV'         as fld4 ,     sum(decode(a.kv       , au.kv        , 0, 1)) as c4 ,
                       'BRANCH'     as fld5 ,     sum(decode(a.branch   , au.branch    , 0, 1)) as c5 ,
                       'NLSALT'     as fld6 ,     sum(decode(a.nlsalt   , au.nlsalt    , 0, 1)) as c6 ,
                       'NBS'        as fld7 ,     sum(decode(a.nbs      , au.nbs       , 0, 1)) as c7 ,
                       'NBS2'       as fld8 ,     sum(decode(a.nbs2     , au.nbs2      , 0, 1)) as c8 ,
                       'DAOS'       as fld9 ,     sum(decode(a.daos     , au.daos      , 0, 1)) as c9 ,
                       'ISP'        as fld10,     sum(decode(a.isp      , au.isp       , 0, 1)) as c10,
                       'NMS'        as fld11,     sum(decode(a.nms      , au.nms       , 0, 1)) as c11,
                       'LIM'        as fld12,     sum(decode(a.lim      , au.lim       , 0, 1)) as c12,
                       'PAP'        as fld13,     sum(decode(a.pap      , au.pap       , 0, 1)) as c13,
                       'TIP'        as fld14,     sum(decode(a.tip      , au.tip       , 0, 1)) as c14,
                       'VID'        as fld15,     sum(decode(a.vid      , au.vid       , 0, 1)) as c15,
                       'MDATE'      as fld16,     sum(decode(a.mdate    , au.mdate     , 0, 1)) as c16,
                       'DAZS'       as fld17,     sum(decode(a.dazs     , au.dazs      , 0, 1)) as c17,
                       'ACCC'       as fld18,     sum(decode(a.accc     , au.accc      , 0, 1)) as c18,
                       'BLKD'       as fld19,     sum(decode(a.blkd     , au.blkd      , 0, 1)) as c19,
                       'BLKK'       as fld20,     sum(decode(a.blkk     , au.blkk      , 0, 1)) as c20,
                       'POS'        as fld21,     sum(decode(a.pos      , au.pos       , 0, 1)) as c21,
                       'SECI'       as fld22,     sum(decode(a.seci     , au.seci      , 0, 1)) as c22,
                       'SECO'       as fld23,     sum(decode(a.seco     , au.seco      , 0, 1)) as c23,
                       'GRP'        as fld24,     sum(decode(a.grp      , au.grp       , 0, 1)) as c24,
                       'OSTX'       as fld25,     sum(decode(a.ostx     , au.ostx      , 0, 1)) as c25,
                       'RNK'        as fld26,     sum(decode(a.rnk      , au.rnk       , 0, 1)) as c26,
                       'TOBO'       as fld27,     sum(decode(a.tobo     , au.tobo      , 0, 1)) as c27,
                       'OB22'       as fld28,     sum(decode(a.ob22     , au.ob22      , 0, 1)) as c28,
                       'SEND_SMS'   as fld29,     sum(decode(a.send_sms , au.send_sms  , 0, 1)) as c29
                  from bars.accounts a
                  left outer join (select ac.* 
                                    from bars.accounts_update ac 
                                   where ac.idupd in (select max(u.idupd)
                                                       from bars.accounts_update u
                                                      where u.kf = l_kf           -- accounts_update has policy BUT this table WILL include PARTITIONs for field KF
                                                      group by u.acc)
                                   and ac.kf = l_kf) au on (a.acc = au.acc)       -- accounts_update has policy BUT this table WILL include PARTITIONs for field KF
                 where (decode(a.kf        , au.kf        , 1, 0) = 0
                     or decode(a.nls       , au.nls       , 1, 0) = 0
                     or decode(a.kv        , au.kv        , 1, 0) = 0
                     or decode(a.branch    , au.branch    , 1, 0) = 0
                     or decode(a.nlsalt    , au.nlsalt    , 1, 0) = 0
                     or decode(a.nbs       , au.nbs       , 1, 0) = 0
                     or decode(a.nbs2      , au.nbs2      , 1, 0) = 0
                     or decode(a.daos      , au.daos      , 1, 0) = 0
                     or decode(a.isp       , au.isp       , 1, 0) = 0
                     or decode(a.nms       , au.nms       , 1, 0) = 0
                     or decode(a.lim       , au.lim       , 1, 0) = 0
                     or decode(a.pap       , au.pap       , 1, 0) = 0
                     or decode(a.tip       , au.tip       , 1, 0) = 0
                     or decode(a.vid       , au.vid       , 1, 0) = 0
                     or decode(a.mdate     , au.mdate     , 1, 0) = 0
                     or decode(a.dazs      , au.dazs      , 1, 0) = 0
                     or decode(a.accc      , au.accc      , 1, 0) = 0
                     or decode(a.blkd      , au.blkd      , 1, 0) = 0
                     or decode(a.blkk      , au.blkk      , 1, 0) = 0
                     or decode(a.pos       , au.pos       , 1, 0) = 0
                     or decode(a.seci      , au.seci      , 1, 0) = 0
                     or decode(a.seco      , au.seco      , 1, 0) = 0
                     or decode(a.grp       , au.grp       , 1, 0) = 0
                     or decode(a.ostx      , au.ostx      , 1, 0) = 0
                     or decode(a.rnk       , au.rnk       , 1, 0) = 0
                     or decode(a.tobo      , au.tobo      , 1, 0) = 0
                     or decode(a.ob22      , au.ob22      , 1, 0) = 0
                     or decode(a.send_sms  , au.send_sms  , 1, 0) = 0)
                     and a.kf = l_kf);                                                -- USE KF for EXPLAIN PLAN

        p_id := G_RUN_ID;
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
    -- CHECK_ACCOUNTS_UPDATE
    --------------------------------------------------------------------------------------------------------------------
    PROCEDURE CHECK_ACCOUNTS_UPDATE
    IS
        l_run_id                      number;
    BEGIN
        CHECK_ACCOUNTS_UPDATE(l_run_id);
    EXCEPTION
        WHEN OTHERS
        THEN
            RAISE;
    END;

    --------------------------------------------------------------------------------------------------------------------
    -- SYNC_ACCOUNTS_UPDATE ( p_id out number, p_rowcount out number)
    --------------------------------------------------------------------------------------------------------------------
    PROCEDURE SYNC_ACCOUNTS_UPDATE ( p_id out number, p_rowcount out number)
    IS
        l_tbl_name                    VARCHAR2(100) := 'ACCOUNTS_UPDATE';
        l_trace                       varchar2(500) := G_TRACE || 'SYNC_ACCOUNTS_UPDATE: ';
        l_staff_id                    bars.staff$base.id%type;
        l_staff_nm                    bars.staff$base.logname%type;
        l_kf                          varchar2(6)   := bars.gl.kf;
        l_bd                          date          := bars.gl.bd;
        l_glb_bankdate                date          := bars.glb_bankdate;
    BEGIN
        start_process(l_tbl_name, 'SYNC');
        --SELECT id, logname into l_staff_id, l_staff_nm FROM bars.staff$base WHERE logname = G_LOGNAME;
        INSERT
              INTO  BARS.ACCOUNTS_UPDATE(IDUPD, CHGACTION, CHGDATE, EFFECTDATE, DONEBY,
                                         ACC, NLS, NLSALT, KV, NBS, NBS2, DAOS, ISP, NMS, PAP, VID, DAZS, BLKD, BLKK, POS, TIP,
                                         GRP, SECI, SECO, LIM, ACCC, TOBO, BRANCH, MDATE, OSTX, SEC, RNK, KF, SEND_SMS, OB22,
                                         GLOBALBD)
            --SELECT /*+ no_index(u PK_ACCOUNTSUPD) */ /*    PARALLEL */
            select bars_sqnc.get_nextval('s_accounts_update', coalesce(a.kf, au.kf)) idupd,
                   case
                       when au.acc is null then 2                                         -- create
                       when au.dazs is     null and a.dazs is not null then 3             -- closed
                       when au.dazs is not null and a.dazs is     null then 0             -- reopen
                       when au.daos <> a.daos then 4                                      --"daos was changed"

                       else 2
                   end as chgaction,
                   sysdate as chgdate,
                   case
                       when au.acc is null then greatest(a.daos, nvl(a.dazs, to_date('01.01.1001', 'dd.mm.yyyy')))
                       when au.dazs is not null and a.dazs is     null then au.dazs        -- reopen
                       when au.dazs is     null and a.dazs is not null then a.dazs        -- closed
                       when au.daos <> a.daos then greatest(au.daos, a.daos)               -- "daos was changed"
                       else l_bd
                   end as effectdate,
                   l_staff_nm,
                   decode(a.acc, null, au.acc       , a.acc         ) as acc      ,
                   decode(a.acc, null, au.nls       , a.nls         ) as nls      ,
                   decode(a.acc, null, au.nlsalt    , a.nlsalt      ) as nlsalt   ,
                   decode(a.acc, null, au.kv        , a.kv          ) as kv       ,
                   decode(a.acc, null, au.nbs       , a.nbs         ) as nbs      ,
                   decode(a.acc, null, au.nbs2      , a.nbs2        ) as nbs2     ,
                   decode(a.acc, null, au.daos      , a.daos        ) as daos     ,
                   decode(a.acc, null, au.isp       , a.isp         ) as isp      ,
                   decode(a.acc, null, au.nms       , a.nms         ) as nms      ,
                   decode(a.acc, null, au.pap       , a.pap         ) as pap      ,
                   decode(a.acc, null, au.vid       , a.vid         ) as vid      ,
                   decode(a.acc, null, au.dazs      , a.dazs        ) as dazs     ,
                   decode(a.acc, null, au.blkd      , a.blkd        ) as blkd     ,
                   decode(a.acc, null, au.blkk      , a.blkk        ) as blkk     ,
                   decode(a.acc, null, au.pos       , a.pos         ) as pos      ,
                   decode(a.acc, null, au.tip       , a.tip         ) as tip      ,
                   decode(a.acc, null, au.grp       , a.grp         ) as grp      ,
                   decode(a.acc, null, au.seci      , a.seci        ) as seci     ,
                   decode(a.acc, null, au.seco      , a.seco        ) as seco     ,
                   decode(a.acc, null, au.lim       , a.lim         ) as lim      ,
                   decode(a.acc, null, au.accc      , a.accc        ) as accc     ,
                   decode(a.acc, null, au.tobo      , a.tobo        ) as tobo     ,
                   decode(a.acc, null, au.branch    , a.branch      ) as branch   ,
                   decode(a.acc, null, au.mdate     , a.mdate       ) as mdate    ,
                   decode(a.acc, null, au.ostx      , a.ostx        ) as ostx     ,
                   a.sec                                              as sec      ,
                   decode(a.acc, null, au.rnk       , a.rnk         ) as rnk      ,
                   decode(a.acc, null, au.kf        , a.kf          ) as kf       ,
                   decode(a.acc, null, au.send_sms  , a.send_sms    ) as send_sms ,
                   decode(a.acc, null, au.ob22      , a.ob22        ) as ob22     ,
                   coalesce(l_bd, l_glb_bankdate)                     as globalbd 
             from bars.accounts a
             left outer join (select ac.* 
                               from bars.accounts_update ac 
                              where ac.idupd in (select max(u.idupd)
                                                  from bars.accounts_update u
                                                 where u.kf = l_kf           -- accounts_update has policy BUT this table WILL include PARTITIONs for field KF
                                                 group by u.acc)
                              and ac.kf = l_kf) au on (a.acc = au.acc)       -- accounts_update has policy BUT this table WILL include PARTITIONs for field KF
            where (decode(a.nls      , au.nls      , 1, 0) = 0
                or decode(a.nlsalt   , au.nlsalt   , 1, 0) = 0
                or decode(a.kv       , au.kv       , 1, 0) = 0
                or decode(a.nbs      , au.nbs      , 1, 0) = 0
                or decode(a.nbs2     , au.nbs2     , 1, 0) = 0
                or decode(a.daos     , au.daos     , 1, 0) = 0
                or decode(a.isp      , au.isp      , 1, 0) = 0
                or decode(a.nms      , au.nms      , 1, 0) = 0
                or decode(a.pap      , au.pap      , 1, 0) = 0
                or decode(a.vid      , au.vid      , 1, 0) = 0
                or decode(a.dazs     , au.dazs     , 1, 0) = 0
                or decode(a.blkd     , au.blkd     , 1, 0) = 0
                or decode(a.blkk     , au.blkk     , 1, 0) = 0
                or decode(a.pos      , au.pos      , 1, 0) = 0
                or decode(a.tip      , au.tip      , 1, 0) = 0
                or decode(a.grp      , au.grp      , 1, 0) = 0
                or decode(a.lim      , au.lim      , 1, 0) = 0
                or decode(a.accc     , au.accc     , 1, 0) = 0
                or decode(a.tobo     , au.tobo     , 1, 0) = 0
                or decode(a.branch   , au.branch   , 1, 0) = 0
                or decode(a.mdate    , au.mdate    , 1, 0) = 0
                or decode(a.ostx     , au.ostx     , 1, 0) = 0
                or decode(a.rnk      , au.rnk      , 1, 0) = 0
                or decode(a.kf       , au.kf       , 1, 0) = 0
                or decode(a.send_sms , au.send_sms , 1, 0) = 0
                or decode(a.ob22     , au.ob22     , 1, 0) = 0)
                and a.kf = l_kf;                                                  -- USE KF for EXPLAIN PLAN

        p_rowcount := SQL%ROWCOUNT;
        p_id := G_RUN_ID;
        INS_STAT('rowcount',
                 'SYNC',
                 p_rowcount,
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
    -- SYNC_ACCOUNTS_UPDATE
    --------------------------------------------------------------------------------------------------------------------
    PROCEDURE SYNC_ACCOUNTS_UPDATE
    IS
        l_run_id                      number;
        l_row_count                   number;
    BEGIN
        SYNC_ACCOUNTS_UPDATE(l_run_id, l_row_count);
    EXCEPTION
        WHEN OTHERS
        THEN
            RAISE;
    END;

    --------------------------------------------------------------------------------------------------------------------
    -- CHECK_CC_DEAL_UPDATE( p_id out number)
    --------------------------------------------------------------------------------------------------------------------
    PROCEDURE CHECK_CC_DEAL_UPDATE( p_id out number)
    IS
       l_tbl_name                    VARCHAR2(100) := 'CC_DEAL_UPDATE';
       l_trace                       varchar2(500) := G_TRACE || 'CHECK_CC_DEAL_UPDATE: ';
    BEGIN
       start_process(l_tbl_name, 'CHECK');
 
       INSERT INTO BARS.UPDATE_TBL_STAT(ID, STAT_ID, FIELD_NAME, FIELD_TYPE, VALUE, RUN_ID, STARTDATE, ENDDATE, TBL_NAME)
       SELECT BARS.S_UPDATE_TBL_STAT.NEXTVAL,
              G_STAT_ID,
              DECODE ( t_pivot.i,
                       1, f1,    2, f2,    3, f3,    4, f4,    5, f5,
                       6, f6,    7, f7,    8, f8,    9, f9,    10, f10,
                      11, f11,  12, f12,  13, f13,  14, f14,   15, f15,
                      16, f16,  17, f17,  18, f18,  19, f19,   20, f20,
                      21, f21,  22, f22,  23, f23,  24, f24,   25, f25,
                      26, f26,  27, f27,  28, f28 ) AS field,
              'count_diff' type1,
              DECODE ( t_pivot.i,
                       1, c1,    2, c2,    3, c3,    4, c4,    5, c5,
                       6, c6,    7, c7,    8, c8,    9, c9,   10, c10,
                       11, c11, 12, c12,  13, c13,  14, c14,  15, c15,
                       16, c16, 17, c17,  18, c18,  19, c19,  20, c20,
                       21, c21, 22, c22,  23, c23,  24, c24,  25, c25,
                       26, c26, 27, c27,  28, decode(c28, null, 0, c28) ) AS CNT,
             G_RUN_ID,
             G_START_DT,
             G_END_DT,
             l_tbl_name
         FROM ( SELECT ROWNUM AS i FROM DUAL CONNECT BY LEVEL <= 28) t_pivot,
              ( SELECT SUM ( DECODE ( ccd.ND, ccd_upd.ND, 0, 1 ) ) c1,                             'ND' f1,
                       SUM ( DECODE ( ccd.SOS, ccd_upd.SOS, 0, 1 ) ) c2,                           'SOS' f2,
                       SUM ( DECODE ( ccd.CC_ID, ccd_upd.CC_ID, 0, 1 ) ) c3,                       'CC_ID' f3,
                       SUM ( DECODE ( ccd.SDATE, ccd_upd.SDATE, 0, 1 ) ) c4,                       'SDATE' f4,
                       SUM ( DECODE ( ccd.WDATE, ccd_upd.WDATE, 0, 1 ) ) c5,                       'WDATE' f5,
                       SUM ( DECODE ( ccd.RNK, ccd_upd.RNK, 0, 1 ) ) c6,                           'RNK' f6,
                       SUM ( DECODE ( ccd.VIDD, ccd_upd.VIDD, 0, 1 ) ) c7,                         'VIDD' f7,
                       SUM ( DECODE ( ccd.LIMIT, ccd_upd.LIMIT, 0, 1 ) ) c8,                       'LIMIT' f8,
                       SUM ( DECODE ( ccd.KPROLOG, ccd_upd.KPROLOG, 0, 1 ) ) c9,                   'KPROLOG' f9,
                       SUM ( DECODE ( ccd.USER_ID, ccd_upd.USER_ID, 0, 1 ) ) c10,                  'USER_ID' f10,
                       SUM ( DECODE ( ccd.OBS, ccd_upd.OBS, 0, 1 ) ) c11,                          'OBS' f11,
                       SUM ( DECODE ( ccd.BRANCH, ccd_upd.BRANCH, 0, 1 ) ) c12,                    'BRANCH' f12,
                       SUM ( DECODE ( ccd.KF, ccd_upd.KF, 0, 1 ) ) c13,                            'KF' f13,
                       SUM ( DECODE ( ccd.IR, ccd_upd.IR, 0, 1 ) ) c14,                            'IR' f14,
                       SUM ( DECODE ( ccd.PROD, ccd_upd.PROD, 0, 1 ) ) c15,                        'PROD' f15,
                       SUM ( DECODE ( ccd.SDOG, ccd_upd.SDOG, 0, 1 ) ) c16,                        'SDOG' f16,
                       SUM ( DECODE ( ccd.SKARB_ID, ccd_upd.SKARB_ID, 0, 1 ) ) c17,                'SKARB_ID' f17,
                       SUM ( DECODE ( ccd.FIN, ccd_upd.FIN, 0, 1 ) ) c18,                          'FIN' f18,
                       SUM ( DECODE ( ccd.NDI, ccd_upd.NDI, 0, 1 ) ) c19,                          'NDI' f19,
                       SUM ( DECODE ( ccd.FIN23, ccd_upd.FIN23, 0, 1 ) ) c20,                      'FIN23' f20,
                       SUM ( DECODE ( ccd.OBS23, ccd_upd.OBS23, 0, 1 ) ) c21,                      'OBS23' f21,
                       SUM ( DECODE ( ccd.KAT23, ccd_upd.KAT23, 0, 1 ) ) c22,                      'KAT23' f22,
                       SUM ( DECODE ( ccd.K23, ccd_upd.K23, 0, 1 ) ) c23,                          'K23' f23,
                       SUM ( DECODE ( ccd.KOL_SP, ccd_upd.KOL_SP, 0, 1 ) ) c24,                    'KOL_SP' f24,
                       SUM ( DECODE ( ccd.S250, ccd_upd.S250, 0, 1 ) ) c25,                        'S250' f25,
                       SUM ( DECODE ( ccd.GRP, ccd_upd.GRP, 0, 1 ) ) c26,                          'GRP' f26,
                       SUM ( DECODE ( ccd.NDG, ccd_upd.NDG, 0, 1 ) ) c27,                          'NDG' f27,
                       SUM ( 1 ) c28,                                                              'TOTAL_ROWS' f28
                  FROM BARS.CC_DEAL ccd
                       FULL OUTER JOIN
                       ( SELECT *
                           FROM BARS.CC_DEAL_UPDATE ccd_upd1
                          WHERE     ccd_upd1.IDUPD IN (  SELECT MAX (
                                                                      ccd_upd2.IDUPD )
                                                           FROM BARS.CC_DEAL_UPDATE ccd_upd2
                                                       GROUP BY ccd_upd2.ND )
                                AND ccd_upd1.CHGACTION <> 'D'
                                AND ccd_upd1.KF = bars.gl.kf) ccd_upd
                          ON ( ccd.ND = ccd_upd.ND AND ccd.kf = ccd_upd.kf )
                 WHERE     (    DECODE ( ccd.ND, ccd_upd.ND, 1, 0 ) = 0
                             OR DECODE ( ccd.SOS, ccd_upd.SOS, 1, 0 ) = 0
                             OR DECODE ( ccd.CC_ID, ccd_upd.CC_ID, 1, 0 ) = 0
                             OR DECODE ( ccd.SDATE, ccd_upd.SDATE, 1, 0 ) = 0
                             OR DECODE ( ccd.WDATE, ccd_upd.WDATE, 1, 0 ) = 0
                             OR DECODE ( ccd.RNK, ccd_upd.RNK, 1, 0 ) = 0
                             OR DECODE ( ccd.VIDD, ccd_upd.VIDD, 1, 0 ) = 0
                             OR DECODE ( ccd.LIMIT, ccd_upd.LIMIT, 1, 0 ) = 0
                             OR DECODE ( ccd.KPROLOG, ccd_upd.KPROLOG, 1, 0 ) = 0
                             OR DECODE ( ccd.USER_ID, ccd_upd.USER_ID, 1, 0 ) = 0
                             OR DECODE ( ccd.OBS, ccd_upd.OBS, 1, 0 ) = 0
                             OR DECODE ( ccd.BRANCH, ccd_upd.BRANCH, 1, 0 ) = 0
                             OR DECODE ( ccd.KF, ccd_upd.KF, 1, 0 ) = 0
                             OR DECODE ( ccd.IR, ccd_upd.IR, 1, 0 ) = 0
                             OR DECODE ( ccd.PROD, ccd_upd.PROD, 1, 0 ) = 0
                             OR DECODE ( ccd.SDOG, ccd_upd.SDOG, 1, 0 ) = 0
                             OR DECODE ( ccd.SKARB_ID, ccd_upd.SKARB_ID, 1, 0 ) = 0
                             OR DECODE ( ccd.FIN, ccd_upd.FIN, 1, 0 ) = 0
                             OR DECODE ( ccd.NDI, ccd_upd.NDI, 1, 0 ) = 0
                             OR DECODE ( ccd.FIN23, ccd_upd.FIN23, 1, 0 ) = 0
                             OR DECODE ( ccd.OBS23, ccd_upd.OBS23, 1, 0 ) = 0
                             OR DECODE ( ccd.KAT23, ccd_upd.KAT23, 1, 0 ) = 0
                             OR DECODE ( ccd.K23, ccd_upd.K23, 1, 0 ) = 0
                             OR DECODE ( ccd.KOL_SP, ccd_upd.KOL_SP, 1, 0 ) = 0
                             OR DECODE ( ccd.S250, ccd_upd.S250, 1, 0 ) = 0
                             OR DECODE ( ccd.GRP, ccd_upd.GRP, 1, 0 ) = 0
                             OR DECODE ( ccd.NDG, ccd_upd.NDG, 1, 0 ) = 0)
                          );

        p_id := G_RUN_ID;
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
    -- CHECK_CC_DEAL_UPDATE
    --------------------------------------------------------------------------------------------------------------------
    PROCEDURE CHECK_CC_DEAL_UPDATE
    IS
       l_run_id                      number;
    BEGIN
       CHECK_CC_DEAL_UPDATE(l_run_id);
    EXCEPTION
        WHEN OTHERS
        THEN
            RAISE;
    END;

    --------------------------------------------------------------------------------------------------------------------
    -- SYNC_CC_DEAL_UPDATE( p_id out number, p_rowcount out number )
    --------------------------------------------------------------------------------------------------------------------
    PROCEDURE SYNC_CC_DEAL_UPDATE( p_id out number, p_rowcount out number )
    IS
       l_tbl_name                    VARCHAR2(100) := 'CC_DEAL_UPDATE';
       l_trace                       varchar2(500) := G_TRACE || 'SYNC_CC_DEAL_UPDATE: ';
       l_staff_id                    bars.staff$base.id%type;
       l_staff_nm                    bars.staff$base.logname%type;
    BEGIN
       start_process(l_tbl_name, 'SYNC');
       SELECT id, logname into l_staff_id, l_staff_nm FROM bars.staff$base WHERE logname = G_LOGNAME;

       INSERT
              INTO BARS.CC_DEAL_UPDATE ( IDUPD, CHGACTION, EFFECTDATE, CHGDATE, DONEBY,
                                         ND, SOS, CC_ID, SDATE, WDATE, RNK, VIDD, LIMIT, KPROLOG, USER_ID,
                                         OBS, BRANCH, KF, IR, PROD, SDOG, SKARB_ID, FIN, NDI, FIN23, OBS23,
                                         KAT23, K23, KOL_SP, S250, GRP, NDG )
       SELECT bars.bars_sqnc.get_nextval ( 'S_CCDEAL_UPDATE', COALESCE(ccd.KF, u.KF) ),
              DECODE ( ccd.ND, NULL, 'D', 'U' ),
              COALESCE ( bars.gl.bd, bars.glb_bankdate ),
              SYSDATE,
              l_staff_id,
              DECODE ( ccd.nd, NULL, u.ND, ccd.ND ),
              DECODE ( ccd.nd, NULL, u.SOS, ccd.SOS ),
              DECODE ( ccd.nd, NULL, u.CC_ID, ccd.CC_ID ),
              DECODE ( ccd.nd, NULL, u.SDATE, ccd.SDATE ),
              DECODE ( ccd.nd, NULL, u.WDATE, ccd.WDATE ),
              DECODE ( ccd.nd, NULL, u.RNK, ccd.RNK ),
              DECODE ( ccd.nd, NULL, u.VIDD, ccd.VIDD ),
              DECODE ( ccd.nd, NULL, u.LIMIT, ccd.LIMIT ),
              DECODE ( ccd.nd, NULL, u.KPROLOG, ccd.KPROLOG ),
              DECODE ( ccd.nd, NULL, u.USER_ID, ccd.USER_ID ),
              DECODE ( ccd.nd, NULL, u.OBS, ccd.OBS ),
              DECODE ( ccd.nd, NULL, u.BRANCH, ccd.BRANCH ),
              DECODE ( ccd.nd, NULL, u.KF, ccd.KF ),
              DECODE ( ccd.nd, NULL, u.IR, ccd.IR ),
              DECODE ( ccd.nd, NULL, u.PROD, ccd.PROD ),
              DECODE ( ccd.nd, NULL, u.SDOG, ccd.SDOG ),
              DECODE ( ccd.nd, NULL, u.SKARB_ID, ccd.SKARB_ID ),
              DECODE ( ccd.nd, NULL, u.FIN, ccd.FIN ),
              DECODE ( ccd.nd, NULL, u.NDI, ccd.NDI ),
              DECODE ( ccd.nd, NULL, u.FIN23, ccd.FIN23 ),
              DECODE ( ccd.nd, NULL, u.OBS23, ccd.OBS23 ),
              DECODE ( ccd.nd, NULL, u.KAT23, ccd.KAT23 ),
              DECODE ( ccd.nd, NULL, u.K23, ccd.K23 ),
              DECODE ( ccd.nd, NULL, u.KOL_SP, ccd.KOL_SP ),
              DECODE ( ccd.nd, NULL, u.S250, ccd.S250 ),
              DECODE ( ccd.nd, NULL, u.GRP, ccd.GRP ),
              DECODE ( ccd.nd, NULL, u.NDG, ccd.NDG )
         FROM BARS.CC_DEAL ccd
              FULL OUTER JOIN
              ( SELECT *
                  FROM BARS.CC_DEAL_UPDATE u1
                 WHERE u1.IDUPD IN (  SELECT MAX ( u2.IDUPD )
                                        FROM BARS.CC_DEAL_UPDATE u2
                                       GROUP BY u2.ND )
                   AND u1.CHGACTION <> 'D' ) u
                 ON ( ccd.ND = u.ND AND ccd.kf = u.kf )
        WHERE (    DECODE ( ccd.ND,       u.ND, 1, 0 ) = 0
                OR DECODE ( ccd.SOS,      u.SOS, 1, 0 ) = 0
                OR DECODE ( ccd.CC_ID,    u.CC_ID, 1, 0 ) = 0
                OR DECODE ( ccd.SDATE,    u.SDATE, 1, 0 ) = 0
                OR DECODE ( ccd.WDATE,    u.WDATE, 1, 0 ) = 0
                OR DECODE ( ccd.RNK,      u.RNK, 1, 0 ) = 0
                OR DECODE ( ccd.VIDD,     u.VIDD, 1, 0 ) = 0
                OR DECODE ( ccd.LIMIT,    u.LIMIT, 1, 0 ) = 0
                OR DECODE ( ccd.KPROLOG,  u.KPROLOG, 1, 0 ) = 0
                OR DECODE ( ccd.USER_ID,  u.USER_ID, 1, 0 ) = 0
                OR DECODE ( ccd.OBS,      u.OBS, 1, 0 ) = 0
                OR DECODE ( ccd.BRANCH,   u.BRANCH, 1, 0 ) = 0
                OR DECODE ( ccd.KF,       u.KF, 1, 0 ) = 0
                OR DECODE ( ccd.IR,       u.IR, 1, 0 ) = 0
                OR DECODE ( ccd.PROD,     u.PROD, 1, 0 ) = 0
                OR DECODE ( ccd.SDOG,     u.SDOG, 1, 0 ) = 0
                OR DECODE ( ccd.SKARB_ID, u.SKARB_ID, 1, 0 ) = 0
                OR DECODE ( ccd.FIN,      u.FIN, 1, 0 ) = 0
                OR DECODE ( ccd.NDI,      u.NDI, 1, 0 ) = 0
                OR DECODE ( ccd.FIN23,    u.FIN23, 1, 0 ) = 0
                OR DECODE ( ccd.OBS23,    u.OBS23, 1, 0 ) = 0
                OR DECODE ( ccd.KAT23,    u.KAT23, 1, 0 ) = 0
                OR DECODE ( ccd.K23,      u.K23, 1, 0 ) = 0
                OR DECODE ( ccd.KOL_SP,   u.KOL_SP, 1, 0 ) = 0
                OR DECODE ( ccd.S250,     u.S250, 1, 0 ) = 0
                OR DECODE ( ccd.GRP,      u.GRP, 1, 0 ) = 0
                OR DECODE ( ccd.NDG,      u.NDG, 1, 0 ) = 0 );

        p_rowcount := SQL%ROWCOUNT;
        p_id := G_RUN_ID;
        INS_STAT('rowcount',
                 'SYNC',
                 p_rowcount,
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
    -- SYNC_CC_DEAL_UPDATE
    --------------------------------------------------------------------------------------------------------------------
    PROCEDURE SYNC_CC_DEAL_UPDATE
    IS
       l_run_id                      number;
       l_row_count                   number;
    BEGIN
    SYNC_CC_DEAL_UPDATE(l_run_id, l_row_count);
    EXCEPTION
        WHEN OTHERS
        THEN
            RAISE;
    END;

    --------------------------------------------------------------------------------------------------------------------
    -- CHECK_DPT_DEPOSIT_CLOS( p_id out number)
    --------------------------------------------------------------------------------------------------------------------
    PROCEDURE CHECK_DPT_DEPOSIT_CLOS( p_id out number)
    IS
        l_tbl_name                    VARCHAR2(100) := 'DPT_DEPOSIT_CLOS';
        l_trace                       varchar2(500) := G_TRACE || 'CHECK_DPT_DEPOSIT_CLOS: ';
    BEGIN
        start_process(l_tbl_name, 'CHECK');

        INSERT INTO BARS.UPDATE_TBL_STAT(ID, STAT_ID, FIELD_NAME, FIELD_TYPE, VALUE, RUN_ID, STARTDATE, ENDDATE, TBL_NAME)
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
                                AND u1.KF = bars.gl.kf
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
                     );

        p_id := G_RUN_ID;
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
    -- CHECK_DPT_DEPOSIT_CLOS
    --------------------------------------------------------------------------------------------------------------------
    PROCEDURE CHECK_DPT_DEPOSIT_CLOS
    IS
        l_run_id                      number;
    BEGIN
        CHECK_DPT_DEPOSIT_CLOS(l_run_id);
    EXCEPTION
        WHEN OTHERS
        THEN
            RAISE;
    END;

    --------------------------------------------------------------------------------------------------------------------
    -- SYNC_DPT_DEPOSIT_CLOS( p_id OUT NUMBER, p_rowcount OUT NUMBER)
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
        INSERT INTO dpt_deposit_clos(idupd, deposit_id, nd, vidd, acc, kv, rnk, freq, datz, dat_begin, dat_end,
                                     dat_end_alt, mfo_p, nls_p, name_p, okpo_p, dpt_d, acc_d, mfo_d, nls_d,
                                     nms_d, okpo_d, LIMIT, deposit_cod, comments, action_id, actiion_author,
                                     "WHEN", bdate, stop_id, kf, cnt_dubl, cnt_ext_int, dat_ext_int, userid,
                                     archdoc_id, forbid_extension, branch, wb)
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

        p_rowcount := SQL%ROWCOUNT;
        p_id := G_RUN_ID;
        INS_STAT('rowcount',
                 'SYNC',
                 p_rowcount,
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
    -- SYNC_DPT_DEPOSIT_CLOS
    --------------------------------------------------------------------------------------------------------------------
    PROCEDURE SYNC_DPT_DEPOSIT_CLOS
    IS
       l_run_id                      number;
       l_row_count                   number;
    BEGIN
       SYNC_DPT_DEPOSIT_CLOS(l_run_id, l_row_count);
    EXCEPTION
        WHEN OTHERS
        THEN
            RAISE;
    END;

    --------------------------------------------------------------------------------------------------------------------
    -- CHECK_CUSTOMERW_UPDATE( p_id out number)
    --------------------------------------------------------------------------------------------------------------------
    PROCEDURE CHECK_CUSTOMERW_UPDATE( p_id out number)
    IS
        l_tbl_name                    VARCHAR2(100) := 'CUSTOMERW_UPDATE';
        l_trace                       varchar2(500) := G_TRACE || 'CHECK_CUSTOMERW_UPDATE: ';
    BEGIN
        start_process(l_tbl_name, 'CHECK');

        INSERT INTO BARS.UPDATE_TBL_STAT(ID, STAT_ID, FIELD_NAME, FIELD_TYPE, VALUE, RUN_ID, STARTDATE, ENDDATE, TBL_NAME)
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

        p_id := G_RUN_ID;
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
    -- CHECK_CUSTOMERW_UPDATE
    --------------------------------------------------------------------------------------------------------------------
    PROCEDURE CHECK_CUSTOMERW_UPDATE
    IS
       l_run_id                      number;
    BEGIN
       CHECK_CUSTOMERW_UPDATE(l_run_id);
    EXCEPTION
        WHEN OTHERS
        THEN
            RAISE;
    END;

    --------------------------------------------------------------------------------------------------------------------
    -- SYNC_CUSTOMERW_UPDATE( p_id OUT NUMBER, p_rowcount OUT NUMBER)
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
        
        INSERT INTO BARS.CUSTOMERW_UPDATE(IDUPD, EFFECTDATE, DONEBY, CHGDATE, CHGACTION, tag, RNK, ISP, VALUE, kf)
            SELECT bars_sqnc.get_nextval('s_customerw_update', coalesce (custw.kf, cwu.kf)) as IDUPD,
                   COALESCE(bars.gl.bd, bars.glb_bankdate),
                   l_staff_nm,
                   SYSDATE,
                   DECODE(custw.rnk, NULL, 3, 2) CHGACTION,
                   DECODE(custw.rnk, NULL, cwu.TAG, trim(custw.tag)),
                   DECODE(custw.rnk, NULL, cwu.RNK, custw.RNK),
                   DECODE(custw.rnk, NULL, cwu.ISP, custw.ISP),
                   DECODE(custw.rnk, NULL, cwu.VALUE, custw.VALUE),
                   coalesce (custw.kf, cwu.kf) as KF
              FROM (SELECT cw.RNK, cw.TAG, cw.VALUE, cw.ISP, c.kf
                      FROM BARS.CUSTOMER c, BARS.CUSTOMERW cw
                     WHERE cw.rnk = c.rnk) custw
                   FULL OUTER JOIN (SELECT  u1.rnk, cast(u1.tag as char(5)) as tag_char, u1.value, u1.isp, u1.kf, u1.tag as tag
                                      FROM BARS.CUSTOMERW_UPDATE u1
                                     WHERE u1.IDUPD IN (  SELECT MAX(u2.IDUPD)
                                                            FROM BARS.CUSTOMERW_UPDATE u2
                                                           GROUP BY trim(u2.tag), u2.rnk)
                                       AND u1.CHGACTION <> '3') cwu
                       ON (custw.rnk = cwu.rnk AND custw.tag = cwu.tag_char)
             WHERE (DECODE(custw.VALUE, cwu.VALUE, 1, 0) = 0
                or  cwu.rnk is null
                or  custw.rnk is null);

        p_rowcount := SQL%ROWCOUNT;
        p_id := G_RUN_ID;
        INS_STAT('rowcount',
                 'SYNC',
                 p_rowcount,
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
    -- SYNC_CUSTOMERW_UPDATE
    --------------------------------------------------------------------------------------------------------------------
    PROCEDURE SYNC_CUSTOMERW_UPDATE
    IS
       l_run_id                      number;
       l_row_count                   number;
    BEGIN
        SYNC_CUSTOMERW_UPDATE(l_run_id, l_row_count);
    EXCEPTION
        WHEN OTHERS
        THEN
            RAISE;
    END;

    --------------------------------------------------------------------------------------------------------------------
    -- SYNC_CUSTOMERW_UPDATE_DWH( p_id OUT NUMBER, p_rowcount OUT NUMBER)
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

        INSERT INTO BARS.CUSTOMERW_UPDATE(IDUPD, EFFECTDATE, DONEBY, CHGDATE, CHGACTION, tag, RNK, ISP, VALUE, kf)
        WITH tg as (select /*+ inline */ tag, cast(tag as char(5)) as tag_char from barsupl.upl_tag_lists where tag_table = 'CUST_FIELD')
        SELECT bars_sqnc.get_nextval('s_customerw_update', coalesce (custw.kf, cwu.kf)) as IDUPD,
               COALESCE(bars.gl.bd, bars.glb_bankdate),
               l_staff_nm,
               SYSDATE,
               DECODE(custw.rnk, NULL, 3, 2) CHGACTION,
               DECODE(custw.rnk, NULL, cwu.TAG, trim(custw.tag)),
               DECODE(custw.rnk, NULL, cwu.RNK, custw.RNK),
               DECODE(custw.rnk, NULL, cwu.ISP, custw.ISP),
               DECODE(custw.rnk, NULL, cwu.VALUE, custw.VALUE),
               coalesce (custw.kf, cwu.kf) as KF
          FROM (SELECT cw.RNK, cw.TAG, cw.VALUE, cw.ISP, c.kf
                  FROM BARS.CUSTOMER c, BARS.CUSTOMERW cw, tg
                 WHERE cw.rnk = c.rnk
                   and cw.tag = tg.tag_char) custw
               FULL OUTER JOIN (SELECT  u1.rnk, cast(u1.tag as char(5)) as tag_char, u1.value, u1.isp, u1.kf, u1.tag as tag
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

        p_rowcount := SQL%ROWCOUNT;
        p_id := G_RUN_ID;
        INS_STAT('rowcount',
                 'SYNC',
                 p_rowcount,
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
    PROCEDURE SYNC_CUSTOMERW_UPDATE_DWH
    IS
       l_run_id                      number;
       l_row_count                   number;
    BEGIN
       SYNC_CUSTOMERW_UPDATE_DWH(l_run_id, l_row_count);
    EXCEPTION
        WHEN OTHERS
        THEN
            RAISE;
    END;

    --------------------------------------------------------------------------------------------------------------------
    -- CHECK_ACCOUNTSW_UPDATE( p_id out number)
    --------------------------------------------------------------------------------------------------------------------
    PROCEDURE CHECK_ACCOUNTSW_UPDATE( p_id out number)
    IS
        l_tbl_name                    VARCHAR2(100) := 'ACCOUNTSW_UPDATE';
        l_trace                       varchar2(500) := G_TRACE || 'CHECK_ACCOUNTSW_UPDATE: ';
    BEGIN
        start_process(l_tbl_name, 'CHECK');

        INSERT INTO BARS.UPDATE_TBL_STAT(ID, STAT_ID, FIELD_NAME, FIELD_TYPE, VALUE, RUN_ID, STARTDATE, ENDDATE, TBL_NAME)
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

        p_id := G_RUN_ID;
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
    -- CHECK_ACCOUNTSW_UPDATE
    --------------------------------------------------------------------------------------------------------------------
    PROCEDURE CHECK_ACCOUNTSW_UPDATE
    IS
       l_run_id                      number;
    BEGIN
       CHECK_ACCOUNTSW_UPDATE(l_run_id);
    EXCEPTION
        WHEN OTHERS
        THEN
            RAISE;
    END;

    --------------------------------------------------------------------------------------------------------------------
    -- SYNC_ACCOUNTSW_UPDATE( p_id OUT NUMBER, p_rowcount OUT NUMBER)
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

        INSERT INTO BARS.ACCOUNTSW_UPDATE(IDUPD, CHGACTION, EFFECTDATE, CHGDATE, DONEBY, ACC, TAG, VALUE, KF)
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

        p_rowcount := SQL%ROWCOUNT;
        p_id := G_RUN_ID;
        INS_STAT('rowcount',
                 'SYNC',
                 p_rowcount,
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
    -- SYNC_ACCOUNTSW_UPDATE
    --------------------------------------------------------------------------------------------------------------------
    PROCEDURE SYNC_ACCOUNTSW_UPDATE
    IS
       l_run_id                      number;
       l_row_count                   number;
    BEGIN
       SYNC_ACCOUNTSW_UPDATE(l_run_id, l_row_count);
    EXCEPTION
        WHEN OTHERS
        THEN
            RAISE;
    END;

    --------------------------------------------------------------------------------------------------------------------
    -- SYNC_ACCOUNTSW_UPDATE_DWH( p_id OUT NUMBER, p_rowcount OUT NUMBER)
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

        INSERT INTO BARS.ACCOUNTSW_UPDATE(IDUPD, CHGACTION, EFFECTDATE, CHGDATE, DONEBY, ACC, TAG, VALUE, KF)
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

        p_rowcount := SQL%ROWCOUNT;
        p_id := G_RUN_ID;
        INS_STAT('rowcount',
                 'SYNC',
                 p_rowcount,
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
    PROCEDURE SYNC_ACCOUNTSW_UPDATE_DWH
    IS
       l_run_id                      number;
       l_row_count                   number;
    BEGIN
       SYNC_ACCOUNTSW_UPDATE_DWH(l_run_id, l_row_count);
    EXCEPTION
        WHEN OTHERS
        THEN
            RAISE;
    END;

    --------------------------------------------------------------------------------------------------------------------
    -- CHECK_ND_TXT_UPDATE( p_id out number)
    --------------------------------------------------------------------------------------------------------------------
    PROCEDURE CHECK_ND_TXT_UPDATE( p_id out number)
    IS
        l_tbl_name                    VARCHAR2(100) := 'ND_TXT_UPDATE';
        l_trace                       varchar2(500) := G_TRACE || 'CHECK_ND_TXT_UPDATE: ';
    BEGIN
        start_process(l_tbl_name, 'CHECK');

        INSERT INTO BARS.UPDATE_TBL_STAT(ID, STAT_ID, FIELD_NAME, FIELD_TYPE, VALUE, RUN_ID, STARTDATE, ENDDATE, TBL_NAME)
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

        p_id := G_RUN_ID;
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
    -- CHECK_ND_TXT_UPDATE
    --------------------------------------------------------------------------------------------------------------------
    PROCEDURE CHECK_ND_TXT_UPDATE
    IS
       l_run_id                      number;
    BEGIN
       CHECK_ND_TXT_UPDATE(l_run_id);
    EXCEPTION
        WHEN OTHERS
        THEN
            RAISE;
    END;

    --------------------------------------------------------------------------------------------------------------------
    -- SYNC_ND_TXT_UPDATE( p_id OUT NUMBER, p_rowcount OUT NUMBER)
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

        INSERT INTO BARS.ND_TXT_UPDATE(ND, TAG, TXT, CHGDATE, CHGACTION, DONEBY, IDUPD, KF, EFFECTDATE, GLOBAL_BDATE)
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

        p_rowcount := SQL%ROWCOUNT;
        p_id := G_RUN_ID;
        INS_STAT('rowcount',
                 'SYNC',
                 p_rowcount,
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
    -- SYNC_ND_TXT_UPDATE
    --------------------------------------------------------------------------------------------------------------------
    PROCEDURE SYNC_ND_TXT_UPDATE
    IS
       l_run_id                      number;
       l_row_count                   number;
    BEGIN
       SYNC_ND_TXT_UPDATE(l_run_id, l_row_count);
    EXCEPTION
        WHEN OTHERS
        THEN
            RAISE;
    END;

    --------------------------------------------------------------------------------------------------------------------
    -- SYNC_ND_TXT_UPDATE_DWH( p_id OUT NUMBER, p_rowcount OUT NUMBER)
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

        INSERT INTO BARS.ND_TXT_UPDATE(ND, TAG, TXT, CHGDATE, CHGACTION, DONEBY, IDUPD, KF, EFFECTDATE, GLOBAL_BDATE)
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
            OR  DECODE(n.TAG, u.TAG, 1, 0) = 0
            OR  DECODE(n.TXT, u.TXT, 1, 0) = 0
            OR  DECODE(n.KF,  u.KF,  1, 0) = 0);

        p_rowcount := SQL%ROWCOUNT;
        p_id := G_RUN_ID;
        INS_STAT('rowcount',
                 'SYNC',
                 p_rowcount,
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
    PROCEDURE SYNC_ND_TXT_UPDATE_DWH
    IS
       l_run_id                      number;
       l_row_count                   number;
    BEGIN
       SYNC_ND_TXT_UPDATE_DWH(l_run_id, l_row_count);
    EXCEPTION
        WHEN OTHERS
        THEN
            RAISE;
    END;

    --------------------------------------------------------------------------------------------------------------------
    -- CHECK_W4_ACC_UPDATE( p_id out number)
    --------------------------------------------------------------------------------------------------------------------
    PROCEDURE CHECK_W4_ACC_UPDATE( p_id out number)
    IS
        l_tbl_name                    VARCHAR2(100) := 'W4_ACC_UPDATE';
        l_trace                       varchar2(500) := G_TRACE || 'CHECK_W4_ACC_UPDATE: ';
    BEGIN
        start_process(l_tbl_name, 'CHECK');
        insert into bars.update_tbl_stat(id, stat_id, field_name, field_type, value, run_id, startdate, enddate, tbl_name)
        select bars.s_update_tbl_stat.nextval,
               g_stat_id,
               DECODE(t_pivot.i, 31, fld31,
               1 , fld1 , 2 , fld2 , 3 , fld3 , 4 , fld4 , 5 , fld5 , 6 , fld6 , 7 , fld7 , 8 , fld8 , 9 , fld9 , 10, fld10, 11, fld11,
               12, fld12, 13, fld13, 14, fld14, 15, fld15, 16, fld16, 17, fld17, 18, fld18, 19, fld19, 20, fld20, 21, fld21, 22, fld22,
               23, fld23, 24, fld24, 25, fld25, 26, fld26, 27, fld27, 28, fld28, 29, fld29, 30, fld30) as field,
               'count_diff' type1,
               decode(t_pivot.i, 31, decode(c31, null, 0, c31),
               1 , c1 , 2 , c2 , 3 , c3 , 4 , c4 , 5 , c5 , 6 , c6 , 7 , c7 , 8 , c8 , 9 , c9 , 10, c10, 11, c11,
               12, c12, 13, c13, 14, c14, 15, c15, 16, c16, 17, c17, 18, c18, 19, c19, 20, c20, 21, c21, 22, c22,
               23, c23, 24, c24, 25, c25, 26, c26, 27, c27, 28, c28, 29, c29, 30, c30) as cnt,
               g_run_id,
               g_start_dt,
               g_end_dt,
               l_tbl_name
        from 
        (select rownum as i from dual connect by level <= 31) t_pivot,
        (select 'TOTAL_ROWS'  as fld31 , sum(1)                                            as c31 ,
                'ND'          as fld1  , sum (decode(w.nd          ,wu.nd         ,0 , 1)) as c1  ,
                'ACC_PK'      as fld2  , sum (decode(w.acc_pk      ,wu.acc_pk     ,0 , 1)) as c2  ,
                'ACC_OVR'     as fld3  , sum (decode(w.acc_ovr     ,wu.acc_ovr    ,0 , 1)) as c3  ,
                'ACC_9129'    as fld4  , sum (decode(w.acc_9129    ,wu.acc_9129   ,0 , 1)) as c4  ,
                'ACC_3570'    as fld5  , sum (decode(w.acc_3570    ,wu.acc_3570   ,0 , 1)) as c5  ,
                'ACC_2208'    as fld6  , sum (decode(w.acc_2208    ,wu.acc_2208   ,0 , 1)) as c6  ,
                'ACC_2627'    as fld7  , sum (decode(w.acc_2627    ,wu.acc_2627   ,0 , 1)) as c7  ,
                'ACC_2207'    as fld8  , sum (decode(w.acc_2207    ,wu.acc_2207   ,0 , 1)) as c8  ,
                'ACC_3579'    as fld9  , sum (decode(w.acc_3579    ,wu.acc_3579   ,0 , 1)) as c9  ,
                'ACC_2209'    as fld10 , sum (decode(w.acc_2209    ,wu.acc_2209   ,0 , 1)) as c10 ,
                'CARD_CODE'   as fld11 , sum (decode(w.card_code   ,wu.card_code  ,0 , 1)) as c11 ,
                'ACC_2625X'   as fld12 , sum (decode(w.acc_2625x   ,wu.acc_2625x  ,0 , 1)) as c12 ,
                'ACC_2627X'   as fld13 , sum (decode(w.acc_2627x   ,wu.acc_2627x  ,0 , 1)) as c13 ,
                'ACC_2625D'   as fld14 , sum (decode(w.acc_2625d   ,wu.acc_2625d  ,0 , 1)) as c14 ,
                'ACC_2628'    as fld15 , sum (decode(w.acc_2628    ,wu.acc_2628   ,0 , 1)) as c15 ,
                'ACC_2203'    as fld16 , sum (decode(w.acc_2203    ,wu.acc_2203   ,0 , 1)) as c16 ,
                'FIN'         as fld17 , sum (decode(w.fin         ,wu.fin        ,0 , 1)) as c17 ,
                'FIN23'       as fld18 , sum (decode(w.fin23       ,wu.fin23      ,0 , 1)) as c18 ,
                'OBS23'       as fld19 , sum (decode(w.obs23       ,wu.obs23      ,0 , 1)) as c19 ,
                'KAT23'       as fld20 , sum (decode(w.kat23       ,wu.kat23      ,0 , 1)) as c20 ,
                'K23'         as fld21 , sum (decode(w.k23         ,wu.k23        ,0 , 1)) as c21 ,
                'DAT_BEGIN'   as fld22 , sum (decode(w.dat_begin   ,wu.dat_begin  ,0 , 1)) as c22 ,
                'DAT_END'     as fld23 , sum (decode(w.dat_end     ,wu.dat_end    ,0 , 1)) as c23 ,
                'DAT_CLOSE'   as fld24 , sum (decode(w.dat_close   ,wu.dat_close  ,0 , 1)) as c24 ,
                'PASS_DATE'   as fld25 , sum (decode(w.pass_date   ,wu.pass_date  ,0 , 1)) as c25 ,
                'PASS_STATE'  as fld26 , sum (decode(w.pass_state  ,wu.pass_state ,0 , 1)) as c26 ,
                'KOL_SP'      as fld27 , sum (decode(w.kol_sp      ,wu.kol_sp     ,0 , 1)) as c27 ,
                'S250'        as fld28 , sum (decode(w.s250        ,wu.s250       ,0 , 1)) as c28 ,
                'GRP'         as fld29 , sum (decode(w.grp         ,wu.grp        ,0 , 1)) as c29 ,
                'KF'          as fld30 , sum (decode(w.kf          ,wu.kf         ,0 , 1)) as c30 
         from  bars.w4_acc w
         full outer join (select u.* 
                           from bars.w4_acc_update u
                          where idupd in (select max(idupd)
                                           from bars.w4_acc_update up
                                          group by up.nd)
                          and u.chgaction <> 'D') wu on wu.nd = w.nd
         where (decode(w.acc_pk      ,wu.acc_pk      ,1, 0) = 0 or
                decode(w.acc_ovr     ,wu.acc_ovr     ,1, 0) = 0 or
                decode(w.acc_9129    ,wu.acc_9129    ,1, 0) = 0 or
                decode(w.acc_3570    ,wu.acc_3570    ,1, 0) = 0 or
                decode(w.acc_2208    ,wu.acc_2208    ,1, 0) = 0 or
                decode(w.acc_2627    ,wu.acc_2627    ,1, 0) = 0 or
                decode(w.acc_2207    ,wu.acc_2207    ,1, 0) = 0 or
                decode(w.acc_3579    ,wu.acc_3579    ,1, 0) = 0 or
                decode(w.acc_2209    ,wu.acc_2209    ,1, 0) = 0 or
                decode(w.card_code   ,wu.card_code   ,1, 0) = 0 or
                decode(w.acc_2625x   ,wu.acc_2625x   ,1, 0) = 0 or
                decode(w.acc_2627x   ,wu.acc_2627x   ,1, 0) = 0 or
                decode(w.acc_2625d   ,wu.acc_2625d   ,1, 0) = 0 or
                decode(w.acc_2628    ,wu.acc_2628    ,1, 0) = 0 or
                decode(w.acc_2203    ,wu.acc_2203    ,1, 0) = 0 or
                decode(w.fin         ,wu.fin         ,1, 0) = 0 or
                decode(w.fin23       ,wu.fin23       ,1, 0) = 0 or
                decode(w.obs23       ,wu.obs23       ,1, 0) = 0 or
                decode(w.kat23       ,wu.kat23       ,1, 0) = 0 or
                decode(w.k23         ,wu.k23         ,1, 0) = 0 or
                decode(w.dat_begin   ,wu.dat_begin   ,1, 0) = 0 or
                decode(w.dat_end     ,wu.dat_end     ,1, 0) = 0 or
                decode(w.dat_close   ,wu.dat_close   ,1, 0) = 0 or
                decode(w.pass_date   ,wu.pass_date   ,1, 0) = 0 or
                decode(w.pass_state  ,wu.pass_state  ,1, 0) = 0 or
                decode(w.kol_sp      ,wu.kol_sp      ,1, 0) = 0 or
                decode(w.s250        ,wu.s250        ,1, 0) = 0 or
                decode(w.grp         ,wu.grp         ,1, 0) = 0 or
                decode(w.kf          ,wu.kf          ,1, 0) = 0 )); 

        p_id := G_RUN_ID;
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
    -- CHECK_W4_ACC_UPDATE
    --------------------------------------------------------------------------------------------------------------------
    PROCEDURE CHECK_W4_ACC_UPDATE
    IS
       l_run_id                      number;
    BEGIN
        CHECK_W4_ACC_UPDATE(l_run_id);
    EXCEPTION
        WHEN OTHERS
        THEN
            RAISE;
    END;

    --------------------------------------------------------------------------------------------------------------------
    -- SYNC_W4_ACC_UPDATE( p_id OUT NUMBER, p_rowcount OUT NUMBER)
    --------------------------------------------------------------------------------------------------------------------
    PROCEDURE SYNC_W4_ACC_UPDATE( p_id OUT NUMBER, p_rowcount OUT NUMBER)
    IS
        l_tbl_name                    VARCHAR2(100) := 'W4_ACC_UPDATE';
        l_trace                       varchar2(500) := G_TRACE || 'SYNC_W4_ACC_UPDATE: ';
        l_staff_id                    bars.staff$base.id%type;
        l_staff_nm                    bars.staff$base.logname%type;
        l_glb_bankdate                date := bars.glb_bankdate;
    BEGIN

        start_process(l_tbl_name, 'SYNC');
        SELECT id, logname into l_staff_id, l_staff_nm FROM bars.staff$base WHERE logname = G_LOGNAME;

    insert into bars.w4_acc_update(idupd, chgaction, effectdate, global_bdate, chgdate, doneby,
    nd, acc_pk, acc_ovr, acc_9129, acc_3570, acc_2208, acc_2627, acc_2207,
    acc_3579, acc_2209, card_code, acc_2625x, acc_2627x, acc_2625d, acc_2628,
    acc_2203, fin, fin23, obs23, kat23, k23, dat_begin, dat_end, dat_close,
    pass_date, pass_state, kol_sp, s250, grp, kf)
    
    select 
        bars.bars_sqnc.get_nextval('s_w4acc_update', coalesce(w.kf, wu.kf)) as idupd         ,
        decode(w.nd, null, 'D', 'U')                                        as chgaction     ,
        nvl(greatest(coalesce(wu.effectdate, to_date('01/01/1900', 'dd/mm/yyyy'))            ,       -- максимальный из update
           (select max(a.daos) dt                                                                    -- либо максимальная дата открытия счета
              from bars.accounts a
             where a.acc in (w.acc_pk, w.acc_ovr, w.acc_9129, w.acc_3570, w.acc_2208, w.acc_2627, w.acc_2207,
                             w.acc_3579, w.acc_2209, w.acc_2625x, w.acc_2627x, w.acc_2625d, w.acc_2628, w.acc_2203))),
                       bars.gl.bd)
                                                                               as effectdate   ,      -- либо текущая (по умолчанию)
        l_glb_bankdate                                                         as global_bdate ,      -- було bars.gl.bd змінив на bars.glb_bankdate (Сказав змінити VHarin)
        sysdate                                                                as chgdate      ,
        l_staff_id                                                             as doneby       ,
        decode(w.nd, null ,wu.nd          ,w.nd        )                       as nd           , 
        decode(w.nd, null ,wu.acc_pk      ,w.acc_pk    )                       as acc_pk       , 
        decode(w.nd, null ,wu.acc_ovr     ,w.acc_ovr   )                       as acc_ovr      , 
        decode(w.nd, null ,wu.acc_9129    ,w.acc_9129  )                       as acc_9129     , 
        decode(w.nd, null ,wu.acc_3570    ,w.acc_3570  )                       as acc_3570     , 
        decode(w.nd, null ,wu.acc_2208    ,w.acc_2208  )                       as acc_2208     , 
        decode(w.nd, null ,wu.acc_2627    ,w.acc_2627  )                       as acc_2627     , 
        decode(w.nd, null ,wu.acc_2207    ,w.acc_2207  )                       as acc_2207     , 
        decode(w.nd, null ,wu.acc_3579    ,w.acc_3579  )                       as acc_3579     , 
        decode(w.nd, null ,wu.acc_2209    ,w.acc_2209  )                       as acc_2209     , 
        decode(w.nd, null ,wu.card_code   ,w.card_code )                       as card_code    , 
        decode(w.nd, null ,wu.acc_2625x   ,w.acc_2625x )                       as acc_2625x    , 
        decode(w.nd, null ,wu.acc_2627x   ,w.acc_2627x )                       as acc_2627x    , 
        decode(w.nd, null ,wu.acc_2625d   ,w.acc_2625d )                       as acc_2625d    , 
        decode(w.nd, null ,wu.acc_2628    ,w.acc_2628  )                       as acc_2628     , 
        decode(w.nd, null ,wu.acc_2203    ,w.acc_2203  )                       as acc_2203     , 
        decode(w.nd, null ,wu.fin         ,w.fin       )                       as fin          , 
        decode(w.nd, null ,wu.fin23       ,w.fin23     )                       as fin23        , 
        decode(w.nd, null ,wu.obs23       ,w.obs23     )                       as obs23        , 
        decode(w.nd, null ,wu.kat23       ,w.kat23     )                       as kat23        , 
        decode(w.nd, null ,wu.k23         ,w.k23       )                       as k23          , 
        decode(w.nd, null ,wu.dat_begin   ,w.dat_begin )                       as dat_begin    , 
        decode(w.nd, null ,wu.dat_end     ,w.dat_end   )                       as dat_end      , 
        decode(w.nd, null ,wu.dat_close   ,w.dat_close )                       as dat_close    , 
        decode(w.nd, null ,wu.pass_date   ,w.pass_date )                       as pass_date    , 
        decode(w.nd, null ,wu.pass_state  ,w.pass_state)                       as pass_state   , 
        decode(w.nd, null ,wu.kol_sp      ,w.kol_sp    )                       as kol_sp       , 
        decode(w.nd, null ,wu.s250        ,w.s250      )                       as s250         , 
        decode(w.nd, null ,wu.grp         ,w.grp       )                       as grp          , 
        decode(w.nd, null ,wu.kf          ,w.kf        )                       as kf
    from  bars.w4_acc w
    full outer join (select u.* 
                      from bars.w4_acc_update u
                     where idupd in (select max(idupd)
                                      from bars.w4_acc_update up
                                     group by up.nd)
                     and u.chgaction <> 'D') wu on wu.nd = w.nd
    where (decode(w.acc_pk      ,wu.acc_pk      ,1, 0) = 0 or
           decode(w.acc_ovr     ,wu.acc_ovr     ,1, 0) = 0 or
           decode(w.acc_9129    ,wu.acc_9129    ,1, 0) = 0 or
           decode(w.acc_3570    ,wu.acc_3570    ,1, 0) = 0 or
           decode(w.acc_2208    ,wu.acc_2208    ,1, 0) = 0 or
           decode(w.acc_2627    ,wu.acc_2627    ,1, 0) = 0 or
           decode(w.acc_2207    ,wu.acc_2207    ,1, 0) = 0 or
           decode(w.acc_3579    ,wu.acc_3579    ,1, 0) = 0 or
           decode(w.acc_2209    ,wu.acc_2209    ,1, 0) = 0 or
           decode(w.card_code   ,wu.card_code   ,1, 0) = 0 or
           decode(w.acc_2625x   ,wu.acc_2625x   ,1, 0) = 0 or
           decode(w.acc_2627x   ,wu.acc_2627x   ,1, 0) = 0 or
           decode(w.acc_2625d   ,wu.acc_2625d   ,1, 0) = 0 or
           decode(w.acc_2628    ,wu.acc_2628    ,1, 0) = 0 or
           decode(w.acc_2203    ,wu.acc_2203    ,1, 0) = 0 or
           decode(w.fin         ,wu.fin         ,1, 0) = 0 or
           decode(w.fin23       ,wu.fin23       ,1, 0) = 0 or
           decode(w.obs23       ,wu.obs23       ,1, 0) = 0 or
           decode(w.kat23       ,wu.kat23       ,1, 0) = 0 or
           decode(w.k23         ,wu.k23         ,1, 0) = 0 or
           decode(w.dat_begin   ,wu.dat_begin   ,1, 0) = 0 or
           decode(w.dat_end     ,wu.dat_end     ,1, 0) = 0 or
           decode(w.dat_close   ,wu.dat_close   ,1, 0) = 0 or
           decode(w.pass_date   ,wu.pass_date   ,1, 0) = 0 or
           decode(w.pass_state  ,wu.pass_state  ,1, 0) = 0 or
           decode(w.kol_sp      ,wu.kol_sp      ,1, 0) = 0 or
           decode(w.s250        ,wu.s250        ,1, 0) = 0 or
           decode(w.grp         ,wu.grp         ,1, 0) = 0 or
           decode(w.kf          ,wu.kf          ,1, 0) = 0 ); 

        p_rowcount := SQL%ROWCOUNT;
        p_id := G_RUN_ID;
        INS_STAT('rowcount', 'SYNC', p_rowcount, l_tbl_name);
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
    -- SYNC_W4_ACC_UPDATE
    --------------------------------------------------------------------------------------------------------------------
    PROCEDURE SYNC_W4_ACC_UPDATE
    IS
       l_run_id                      number;
       l_row_count                   number;
    BEGIN
       SYNC_W4_ACC_UPDATE(l_run_id, l_row_count);
    EXCEPTION
        WHEN OTHERS
        THEN
            RAISE;
    END;

    --------------------------------------------------------------------------------------------------------------------
    -- TRIM_W4_ACC_UPDATE
    -- Временно закомментировано до решения вопроса - куда складывать архивные данные?
    --------------------------------------------------------------------------------------------------------------------
--    PROCEDURE TRIM_W4_ACC_UPDATE(p_dt DATE)
--    /* Видалити дані з таб W4_ACC_UPDATE і вставити в таб. W4_ACC_UPDATE_ARC
--       На умову видалення перевіряються записи з effectdate < P_DT
--       Не видаляються записи з: chgaction = 'I' - для отримання факту створення договору
--                                chgaction = 'D' - для отримання факту видалення договору
--    */
--    IS
--        l_tbl_name                    VARCHAR2(100) := 'W4_ACC_UPDATE';
--        l_trace                       varchar2(500) := G_TRACE || 'TRIM_W4_ACC_UPDATE: ';
--    BEGIN 
--        start_process(l_tbl_name, 'TRIM');
--        INSERT INTO BARS.W4_ACC_UPDATE_ARCHIVE (
--                    IDUPD,CHGACTION,EFFECTDATE,
--                    CHGDATE,DONEBY,ND,
--                    ACC_PK,ACC_OVR,ACC_9129,
--                    ACC_3570,ACC_2208,ACC_2627,
--                    ACC_2207,ACC_3579,ACC_2209,
--                    CARD_CODE,ACC_2625X,ACC_2627X,
--                    ACC_2625D,ACC_2628,ACC_2203,
--                    FIN,FIN23,OBS23,
--                    KAT23,K23,DAT_BEGIN,
--                    DAT_END,DAT_CLOSE,PASS_DATE,
--                    PASS_STATE,KOL_SP,S250,
--                    GRP,GLOBAL_BDATE,KF)
--        SELECT      IDUPD,CHGACTION,EFFECTDATE,
--                    CHGDATE,DONEBY,ND,
--                    ACC_PK,ACC_OVR,ACC_9129,
--                    ACC_3570,ACC_2208,ACC_2627,
--                    ACC_2207,ACC_3579,ACC_2209,
--                    CARD_CODE,ACC_2625X,ACC_2627X,
--                    ACC_2625D,ACC_2628,ACC_2203,
--                    FIN,FIN23,OBS23,
--                    KAT23,K23,DAT_BEGIN,
--                    DAT_END,DAT_CLOSE,PASS_DATE,
--                    PASS_STATE,KOL_SP,S250,
--                    GRP,GLOBAL_BDATE,KF
--        FROM(   SELECT  W.*,
--                CASE    WHEN WA.IDUPD IS NOT NULL 
--                        OR W.CHGACTION IN ('I', 'D') 
--                        OR W.EFFECTDATE >= P_DT THEN 'NOT_DELETE' ELSE 'DELETE' END AS CHG_FLAG
--                FROM BARS.W4_ACC_UPDATE  W         
--                LEFT OUTER JOIN (SELECT MAX (IDUPD) AS IDUPD
--                                    FROM BARS.W4_ACC_UPDATE
--                                WHERE EFFECTDATE < P_DT
--                                AND CHGACTION = 'U'
--                                GROUP BY ND  ) WA ON WA.IDUPD = W.IDUPD) TB 
--        WHERE TB.CHG_FLAG = 'DELETE';
--
--
--        DELETE FROM BARS.W4_ACC_UPDATE WW 
--        WHERE WW.IDUPD IN ( SELECT U.IDUPD 
--                            FROM BARS.W4_ACC_UPDATE U 
--                            LEFT OUTER JOIN BARS.W4_ACC_UPDATE_ARCHIVE A ON A.IDUPD = U.IDUPD
--                            WHERE A.IDUPD IS NOT NULL);
--        
--        INS_STAT('rowcount','TRIM',SQL%ROWCOUNT,l_tbl_name);
--        
--        END_PROCESS(L_TBL_NAME, 'TRIM');
--        COMMIT; 
--    
--    EXCEPTION
--        WHEN OTHERS
--        THEN
--            ROLLBACK;
--            error_process(l_tbl_name, 'ERR', substr(dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace(), 1, 1000) );
--            RAISE;
--    END;

    --------------------------------------------------------------------------------------------------------------------
    -- CHECK_BPK_ACC_UPDATE( p_id out number)
    --------------------------------------------------------------------------------------------------------------------
    PROCEDURE CHECK_BPK_ACC_UPDATE( p_id out number)
    IS
        l_tbl_name                    VARCHAR2(100) := 'BPK_ACC_UPDATE';
        l_trace                       varchar2(500) := G_TRACE || 'CHECK_BPK_ACC_UPDATE: ';
    BEGIN
        start_process(l_tbl_name, 'CHECK');

        INSERT INTO BARS.UPDATE_TBL_STAT(ID, STAT_ID, FIELD_NAME, FIELD_TYPE, VALUE, RUN_ID, STARTDATE, ENDDATE, TBL_NAME)
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
                               AND chgaction != 'D'
                               AND KF = bars.gl.kf) u
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
                      );

        p_id := G_RUN_ID;
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
    -- CHECK_BPK_ACC_UPDATE
    --------------------------------------------------------------------------------------------------------------------
    PROCEDURE CHECK_BPK_ACC_UPDATE
    IS
       l_run_id                      number;
    BEGIN
       CHECK_BPK_ACC_UPDATE(l_run_id);
    EXCEPTION
        WHEN OTHERS
        THEN
            RAISE;
    END;

    --------------------------------------------------------------------------------------------------------------------
    -- SYNC_BPK_ACC_UPDATE( p_id OUT NUMBER, p_rowcount OUT NUMBER)
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
        INSERT
              INTO  BARS.BPK_ACC_UPDATE(idupd, chgaction, effectdate, chgdate, doneby,
                                        ND, ACC_PK, ACC_OVR, ACC_9129, ACC_TOVR, KF, ACC_3570, ACC_2208, PRODUCT_ID,
                                        ACC_2207, ACC_3579, ACC_2209, ACC_W4, FIN, FIN23, OBS23, KAT23, K23, DAT_END,
                                        KOL_SP, S250, GRP, GLOBAL_BDATE, DAT_CLOSE)
            SELECT bars_sqnc.get_nextval('s_bpkacc_update', COALESCE(n.KF, u.KF)) AS idupd,
                   CASE WHEN n.nd IS NULL THEN 'D' ELSE DECODE(u.chgaction, NULL, 'I', 'U') END AS chgaction,
                   NVL(GREATEST(COALESCE(u.EFFECTDATE, TO_DATE('01/01/1900', 'dd/mm/yyyy')),                  -- максимальный из update
                                (SELECT MAX(a.daos) dt                                                        -- либо максимальная дата открытия счета
                                   FROM bars.accounts a
                                  WHERE a.acc IN (n.acc_w4, n.acc_pk, n.acc_ovr, n.acc_9129, n.acc_tovr, n.acc_3570, n.acc_2208, n.acc_2207, n.acc_3579, n.acc_2209))),
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
                     WHERE IDUPD IN ( SELECT MAX(IDUPD)
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

        p_rowcount := SQL%ROWCOUNT;
        p_id := G_RUN_ID;
        INS_STAT('rowcount',
                 'SYNC',
                 p_rowcount,
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
    -- SYNC_BPK_ACC_UPDATE
    --------------------------------------------------------------------------------------------------------------------
    PROCEDURE SYNC_BPK_ACC_UPDATE
    IS
       l_run_id                      number;
       l_row_count                   number;
    BEGIN
       SYNC_BPK_ACC_UPDATE(l_run_id, l_row_count);
    EXCEPTION
        WHEN OTHERS
        THEN
            RAISE;
    END;

    --------------------------------------------------------------------------------------------------------------------
    -- TRIM_BPK_ACC_UPDATE
    -- Временно закомментировано до решения вопроса - куда складывать архивные данные?
    --------------------------------------------------------------------------------------------------------------------
--    PROCEDURE TRIM_BPK_ACC_UPDATE(p_dt DATE)
--    /* Видалити дані з таб BPK_ACC_UPDATE і вставити в таб. BPK_ACC_UPDATE_ARC
--       На умову видалення перевіряються записи з effectdate < P_DT
--       Не видаляються записи з: chgaction = 'I' - для отримання факту створення рахунку
--                                chgaction = 'D' - для отримання факту видалення рахунку
--    */
--    IS
--        l_tbl_name                    VARCHAR2(100) := 'BPK_ACC_UPDATE';
--        l_trace                       varchar2(500) := G_TRACE || 'TRIM_BPK_ACC_UPDATE: ';
--    BEGIN
--        start_process(l_tbl_name, 'TRIM');
--        INSERT INTO BARS.BPK_ACC_UPDATE_ARCHIVE(
--                    IDUPD,CHGACTION,EFFECTDATE,
--                    CHGDATE,DONEBY,ACC_PK,
--                    ACC_OVR,ACC_9129,ACC_TOVR,
--                    KF,ACC_3570,ACC_2208,
--                    ND,PRODUCT_ID,ACC_2207,
--                    ACC_3579,ACC_2209,ACC_W4,
--                    FIN,FIN23,OBS23,
--                    KAT23,K23,DAT_END,
--                    KOL_SP,S250,GRP,
--                    GLOBAL_BDATE,DAT_CLOSE)
--        SELECT      IDUPD,CHGACTION,EFFECTDATE,
--                    CHGDATE,DONEBY,ACC_PK,
--                    ACC_OVR,ACC_9129,ACC_TOVR,
--                    KF,ACC_3570,ACC_2208,
--                    ND,PRODUCT_ID,ACC_2207,
--                    ACC_3579,ACC_2209,ACC_W4,
--                    FIN,FIN23,OBS23,
--                    KAT23,K23,DAT_END,
--                    KOL_SP,S250,GRP,
--                    GLOBAL_BDATE,DAT_CLOSE
--        FROM(       SELECT
--                    B.*,
--                    CASE WHEN BP.IDUPD IS NOT NULL 
--                         OR B.CHGACTION IN ('I', 'D') 
--                         OR EFFECTDATE >= P_DT THEN 'NOT_DELETE' ELSE 'DELETE' END AS CHG_FLAG
--              FROM BARS.BPK_ACC_UPDATE B
--              LEFT OUTER JOIN (SELECT MAX (IDUPD) AS IDUPD
--                                FROM BARS.BPK_ACC_UPDATE
--                               WHERE EFFECTDATE < P_DT 
--                               AND CHGACTION = 'U'
--                               GROUP BY ND ) BP ON BP.IDUPD = B.IDUPD) T
--        WHERE T.CHG_FLAG = 'DELETE';
--
--        DELETE FROM BARS.BPK_ACC_UPDATE AC 
--        WHERE AC.IDUPD IN (SELECT U.IDUPD 
--                            FROM BARS.BPK_ACC_UPDATE U 
--                            LEFT OUTER JOIN BARS.BPK_ACC_UPDATE_ARCHIVE A ON A.IDUPD = U.IDUPD
--                            WHERE A.IDUPD IS NOT NULL);
--
--        INS_STAT('rowcount','TRIM',SQL%ROWCOUNT,l_tbl_name);
--        end_process(l_tbl_name, 'TRIM');
--        COMMIT;
--    EXCEPTION
--        WHEN OTHERS
--        THEN
--            ROLLBACK;
--            error_process(l_tbl_name, 'ERR', substr(dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace(), 1, 1000) );
--            RAISE;
--    END;

    --------------------------------------------------------------------------------------------------------------------
    -- CHECK_BPK_PARAMETERS_UPDATE( p_id out number)
    --------------------------------------------------------------------------------------------------------------------
    PROCEDURE CHECK_BPK_PARAMETERS_UPDATE( p_id out number)
    IS
        l_tbl_name                    VARCHAR2(100) := 'BPK_PARAMETERS_UPDATE';
        l_trace                       varchar2(500) := G_TRACE || 'CHECK_BPK_PARAMETERS_UPDATE: ';
    BEGIN
        start_process(l_tbl_name, 'CHECK');

        INSERT INTO BARS.UPDATE_TBL_STAT(ID, STAT_ID, FIELD_NAME, FIELD_TYPE, VALUE, RUN_ID, STARTDATE, ENDDATE, TBL_NAME)
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
                  FROM (SELECT b.nd, b.tag, b.value, coalesce(w4.kf, bpk.kf) kf
                          FROM BARS.BPK_PARAMETERS b
                          left join bars.w4_acc  w4  on (w4.nd  = b.nd)
                          left join bars.bpk_acc bpk on (bpk.nd = b.nd)
                         WHERE w4.nd  is not null
                            or bpk.nd is not null) n
                  FULL OUTER JOIN (SELECT *
                                     FROM BARS.BPK_PARAMETERS_UPDATE u1
                                    WHERE u1.IDUPD IN ( SELECT MAX(u2.IDUPD)
                                                              FROM BARS.BPK_PARAMETERS_UPDATE u2
                                                             GROUP BY u2.nd, u2.tag, u2.kf )
                                      AND u1.CHGACTION <> 'D') u
                      ON (n.kf = u.kf and n.nd = u.nd AND n.tag = u.tag)
                 WHERE decode(n.value, u.value, 0, 1) = 1
                    or n.nd is null
                    or u.nd is null
                  group by coalesce(n.TAG, u.TAG));

        p_id := G_RUN_ID;
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
    -- CHECK_BPK_PARAMETERS_UPDATE
    --------------------------------------------------------------------------------------------------------------------
    PROCEDURE CHECK_BPK_PARAMETERS_UPDATE
    IS
       l_run_id                      number;
    BEGIN
       CHECK_BPK_PARAMETERS_UPDATE(l_run_id);
    EXCEPTION
        WHEN OTHERS
        THEN
            RAISE;
    END;

    --------------------------------------------------------------------------------------------------------------------
    -- SYNC_BPK_PARAMETERS_UPDATE( p_id OUT NUMBER, p_rowcount OUT NUMBER)
    --------------------------------------------------------------------------------------------------------------------
    PROCEDURE SYNC_BPK_PARAMETERS_UPDATE( p_id OUT NUMBER, p_rowcount OUT NUMBER)
    IS
        l_tbl_name                    VARCHAR2(100) := 'BPK_PARAMETERS_UPDATE';
        l_trace                       varchar2(500) := G_TRACE || 'SYNC_BPK_PARAMETERS_UPDATE: ';
        l_staff_id                    bars.staff$base.id%type;
        l_staff_nm                    bars.staff$base.logname%type;
    BEGIN
        start_process(l_tbl_name, 'SYNC');
        SELECT id, logname into l_staff_id, l_staff_nm FROM bars.staff$base WHERE logname = G_LOGNAME;

        INSERT INTO BARS.BPK_PARAMETERS_UPDATE(ND, TAG, VALUE, CHGDATE, CHGACTION, DONEBY, IDUPD, KF, EFFECTDATE, GLOBAL_BDATE)
            SELECT DECODE(n.nd, NULL, u.nd, n.nd) as ND,
                   DECODE(n.nd, NULL, u.tag, n.tag) as TAG,
                   DECODE(n.nd, NULL, u.value, n.value) as VALUE,
                   SYSDATE as CHGDATE,
                   DECODE(n.nd, NULL, 'D', 'U') as CHGACTION,
                   l_staff_id as DONEBY,
                   bars.bars_sqnc.get_nextval('s_bpk_parameters_update', COALESCE(n.KF, u.KF)) as IDUPD,
                   DECODE(n.nd, NULL, u.kf, n.kf) as KF,
                   COALESCE(bars.gl.bd, bars.glb_bankdate) as EFFECTDATE,
                   bars.glb_bankdate as GLOBAL_BDATE
              FROM (SELECT b.nd, b.tag, b.value, coalesce(w4.kf, bpk.kf) kf
                      FROM BARS.BPK_PARAMETERS b
                      left join bars.w4_acc  w4  on (w4.nd  = b.nd)
                      left join bars.bpk_acc bpk on (bpk.nd = b.nd)
                     WHERE w4.nd  is not null
                        or bpk.nd is not null) n
              FULL OUTER JOIN (SELECT *
                                 FROM BARS.BPK_PARAMETERS_UPDATE u1
                                WHERE u1.IDUPD IN (  SELECT MAX(u2.IDUPD)
                                                       FROM BARS.BPK_PARAMETERS_UPDATE u2
                                                      GROUP BY u2.nd, u2.tag, u2.kf)
                                  AND u1.CHGACTION <> 'D') u
                   ON (n.KF = u.KF AND n.nd = u.nd AND n.tag = u.tag)
             WHERE (DECODE(n.ND,  u.ND,  1, 0) = 0
                 OR DECODE(n.TAG, u.TAG, 1, 0) = 0
                 OR DECODE(n.VALUE, u.VALUE, 1, 0) = 0
                 OR DECODE(n.KF,  u.KF,  1, 0) = 0);

        p_rowcount := SQL%ROWCOUNT;
        p_id := G_RUN_ID;
        INS_STAT('rowcount',
                 'SYNC',
                 p_rowcount,
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
    -- SYNC_BPK_PARAMETERS_UPDATE
    --------------------------------------------------------------------------------------------------------------------
    PROCEDURE SYNC_BPK_PARAMETERS_UPDATE
    IS
       l_run_id                      number;
       l_row_count                   number;
    BEGIN
       SYNC_BPK_PARAMETERS_UPDATE(l_run_id, l_row_count);
    EXCEPTION
        WHEN OTHERS
        THEN
            RAISE;
    END;

    --------------------------------------------------------------------------------------------------------------------
    -- SYNC_BPK_PARAMETERS_UPDATE_DWH( p_id OUT NUMBER, p_rowcount OUT NUMBER)
    -- синхронизация только тех тегов, которые передаются в DWH
    --------------------------------------------------------------------------------------------------------------------
    PROCEDURE SYNC_BPK_PARAMETERS_UPDATE_DWH( p_id OUT NUMBER, p_rowcount OUT NUMBER)
    IS
        l_tbl_name                    VARCHAR2(100) := 'BPK_PARAMETERS_UPDATE';
        l_trace                       varchar2(500) := G_TRACE || 'SYNC_BPK_PARAMETERS_UPDATE_DWH: ';
        l_staff_id                    bars.staff$base.id%type;
        l_staff_nm                    bars.staff$base.logname%type;
    BEGIN
        start_process(l_tbl_name, 'SYNC');
        SELECT id, logname into l_staff_id, l_staff_nm FROM bars.staff$base WHERE logname = G_LOGNAME;
        INSERT INTO BARS.BPK_PARAMETERS_UPDATE(ND, TAG, VALUE, CHGDATE, CHGACTION, DONEBY, IDUPD, KF, EFFECTDATE, GLOBAL_BDATE)
            WITH tg as (select /*+ inline */ tag  from barsupl.upl_tag_lists where tag_table in ('BPK_TAGS'))
            SELECT DECODE(n.nd, NULL, u.nd, n.nd) as ND,
                   DECODE(n.nd, NULL, u.tag, n.tag) as TAG,
                   DECODE(n.nd, NULL, u.value, n.value) as value,
                   SYSDATE as CHGDATE,
                   DECODE(n.nd, NULL, 'D', 'U') as CHGACTION,
                   l_staff_id as DONEBY,
                   bars.bars_sqnc.get_nextval('s_bpk_parameters_update', COALESCE(n.KF, u.KF)) as IDUPD,
                   DECODE(n.nd, NULL, u.kf, n.kf) as KF,
                   COALESCE(bars.gl.bd, bars.glb_bankdate) as EFFECTDATE,
                   bars.glb_bankdate as GLOBAL_BDATE
              FROM (SELECT b.nd, b.tag, b.value, coalesce(w4.kf, bpk.kf) kf
                      FROM BARS.BPK_PARAMETERS b
                           join tg on (b.tag = tg.tag)
                      left join bars.w4_acc  w4  on (w4.nd  = b.nd)
                      left join bars.bpk_acc bpk on (bpk.nd = b.nd)
                     WHERE w4.nd  is not null
                        or bpk.nd is not null) n
                   FULL OUTER JOIN (SELECT *
                                      FROM BARS.BPK_PARAMETERS_UPDATE u1
                                     WHERE u1.IDUPD IN (  SELECT MAX(u2.IDUPD)
                                                            FROM BARS.BPK_PARAMETERS_UPDATE u2, tg
                                                           WHERE u2.tag = tg.tag
                                                           GROUP BY u2.nd, u2.tag, u2.kf)
                                       AND u1.CHGACTION <> 'D') u
                       ON (n.KF = u.KF AND n.nd = u.nd AND n.tag = u.tag)
             WHERE (DECODE(n.ND,    u.ND,    1, 0) = 0
                 OR DECODE(n.TAG,   u.TAG,   1, 0) = 0
                 OR DECODE(n.VALUE, u.VALUE, 1, 0) = 0
                 OR DECODE(n.KF,    u.KF,    1, 0) = 0);

        p_rowcount := SQL%ROWCOUNT;
        p_id := G_RUN_ID;
        INS_STAT('rowcount',
                 'SYNC',
                 p_rowcount,
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
    -- SYNC_BPK_PARAMETERS_UPDATE_DWH
    -- синхронизация только тех тегов, которые передаются в DWH
    --------------------------------------------------------------------------------------------------------------------
    PROCEDURE SYNC_BPK_PARAMETERS_UPDATE_DWH
    IS
       l_run_id                      number;
       l_row_count                   number;
    BEGIN
       SYNC_BPK_PARAMETERS_UPDATE_DWH(l_run_id, l_row_count);
    EXCEPTION
        WHEN OTHERS
        THEN
            RAISE;
    END;

    --------------------------------------------------------------------------------------------------------------------
    -- CHECK_VIP_FLAGS_ARC( p_id out number)
    --------------------------------------------------------------------------------------------------------------------
    PROCEDURE CHECK_VIP_FLAGS_ARC( p_id out number)
    IS
        l_tbl_name                    VARCHAR2(100) := 'VIP_FLAGS_ARC';
        l_trace                       varchar2(500) := G_TRACE || 'CHECK_VIP_FLAGS_ARC: ';
    BEGIN
        start_process(l_tbl_name, 'CHECK');
        INSERT INTO BARS.UPDATE_TBL_STAT(ID, STAT_ID, FIELD_NAME, FIELD_TYPE, VALUE, RUN_ID, STARTDATE, ENDDATE, TBL_NAME)
        SELECT BARS.S_UPDATE_TBL_STAT.NEXTVAL,
               G_STAT_ID,
               DECODE(t_pivot.i,
                      14, fld14,
                       1,  fld1,   2, fld2,    3,  fld3,   4, fld4,
                       5,  fld5,   6, fld6,    7,  fld7,   8, fld8,
                       9,  fld9,   10, fld10,  11, fld11,  12, fld12,
                       13, fld13) AS field,
               'count_diff' type1,
               DECODE(T_PIVOT.I,
                      14, DECODE(C14, NULL, 0, C14),
                       1,  C1,   2,  C2,   3,  C3,   4,  C4,
                       5,  C5,   6,  C6,   7,  C7,   8,  C8,
                       9,  C9,  10, C10,   11, C11,  12, C12,  
                       13, C13) AS CNT,
               G_RUN_ID,
               G_START_DT,
               G_END_DT,
               L_TBL_NAME
        FROM ( SELECT ROWNUM AS I FROM DUAL CONNECT BY LEVEL <= 14) T_PIVOT,
             ( SELECT
               'TOTAL_ROWS'      AS FLD14, SUM(1) AS C14,
               'MFO'             AS FLD1 , SUM(DECODE(VF.MFO            , VFU.MFO            , 0, 1)) AS C1,
               'RNK'             AS FLD2 , SUM(DECODE(VF.RNK            , VFU.RNK            , 0, 1)) AS C2,
               'VIP'             AS FLD3 , SUM(DECODE(VF.VIP            , VFU.VIP            , 0, 1)) AS C3,
               'KVIP'            AS FLD4 , SUM(DECODE(VF.KVIP           , VFU.KVIP           , 0, 1)) AS C4,
               'DATBEG'          AS FLD5 , SUM(DECODE(VF.DATBEG         , VFU.DATBEG         , 0, 1)) AS C5,
               'DATEND'          AS FLD6 , SUM(DECODE(VF.DATEND         , VFU.DATEND         , 0, 1)) AS C6,
               'COMMENTS'        AS FLD7 , SUM(DECODE(VF.COMMENTS       , VFU.COMMENTS       , 0, 1)) AS C7,
               'CM_FLAG'         AS FLD8 , SUM(DECODE(VF.CM_FLAG        , VFU.CM_FLAG        , 0, 1)) AS C8,
               'CM_TRY'          AS FLD9 , SUM(DECODE(VF.CM_TRY         , VFU.CM_TRY         , 0, 1)) AS C9,
               'FIO_MANAGER'     AS FLD10, SUM(DECODE(VF.FIO_MANAGER    , VFU.FIO_MANAGER    , 0, 1)) AS C10,
               'PHONE_MANAGER'   AS FLD11, SUM(DECODE(VF.PHONE_MANAGER  , VFU.PHONE_MANAGER  , 0, 1)) AS C11,
               'MAIL_MANAGER'    AS FLD12, SUM(DECODE(VF.MAIL_MANAGER   , VFU.MAIL_MANAGER   , 0, 1)) AS C12,
               'ACCOUNT_MANAGER' AS FLD13, SUM(DECODE(VF.ACCOUNT_MANAGER, VFU.ACCOUNT_MANAGER, 0, 1)) AS C13
             FROM BARS.VIP_FLAGS VF
             FULL OUTER JOIN (SELECT AR.* FROM (SELECT A.*, ROW_NUMBER() OVER(PARTITION BY A.MFO, A.RNK ORDER BY A.IDUPD DESC) RN
                                                                  FROM BARS.VIP_FLAGS_ARC A
                                                                 WHERE A.MFO = COALESCE(BARS.GL.KF, A.MFO)) AR
                                                WHERE AR.RN = 1
                                                AND AR.VID != 'D') VFU ON (VFU.MFO = VF.MFO AND VFU.RNK = VF.RNK)
             WHERE(DECODE(VF.VIP, VFU.VIP, 1, 0) = 0
                OR DECODE(VF.KVIP, VFU.KVIP, 1, 0) = 0
                OR DECODE(VF.DATBEG, VFU.DATBEG, 1, 0) = 0
                OR DECODE(VF.DATEND, VFU.DATEND, 1, 0) = 0
                OR DECODE(VF.COMMENTS, VFU.COMMENTS, 1, 0) = 0
                OR DECODE(VF.CM_FLAG, VFU.CM_FLAG, 1, 0) = 0
                OR DECODE(VF.CM_TRY, VFU.CM_TRY, 1, 0) = 0
                OR DECODE(VF.FIO_MANAGER, VFU.FIO_MANAGER, 1, 0) = 0
                OR DECODE(VF.PHONE_MANAGER, VFU.PHONE_MANAGER, 1, 0) = 0
                OR DECODE(VF.MAIL_MANAGER, VFU.MAIL_MANAGER, 1, 0) = 0
                OR DECODE(VF.ACCOUNT_MANAGER, VFU.ACCOUNT_MANAGER, 1, 0) = 0)
                AND (VF.MFO = COALESCE(BARS.GL.KF, VF.MFO) OR VF.MFO IS NULL));

        p_id := G_RUN_ID;
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
    -- CHECK_VIP_FLAGS_ARC
    --------------------------------------------------------------------------------------------------------------------
    PROCEDURE CHECK_VIP_FLAGS_ARC
    IS
       l_run_id                      number;
    BEGIN
       CHECK_VIP_FLAGS_ARC(l_run_id);
    EXCEPTION
        WHEN OTHERS
        THEN
            RAISE;
    END;

    --------------------------------------------------------------------------------------------------------------------
    -- SYNC_VIP_FLAGS_ARC ( p_id out number, p_rowcount out number)
    --------------------------------------------------------------------------------------------------------------------
    PROCEDURE SYNC_VIP_FLAGS_ARC( p_id out number, p_rowcount out number)
    IS
        l_tbl_name                    VARCHAR2(100) := 'VIP_FLAGS_ARC';
        l_trace                       varchar2(500) := G_TRACE || 'SYNC_VIP_FLAGS_ARC: ';
        l_staff_id                    bars.staff$base.id%type;
        l_staff_nm                    bars.staff$base.logname%type;
    BEGIN
    
    START_PROCESS(l_tbl_name, 'SYNC');
    SELECT id, logname into l_staff_id, l_staff_nm FROM bars.staff$base WHERE logname = G_LOGNAME;
    INSERT INTO bars.vip_flags_arc (mfo, rnk, vip, kvip, datbeg, datend, comments, cm_flag, cm_try, fio_manager,
    phone_manager, mail_manager, account_manager, idupd, fdat, idu, vid, kf, effectdate, global_bdate)
    select 
    decode(vf.rnk, null, vfu.mfo,             vf.mfo)             as mfo,
    decode(vf.rnk, null, vfu.rnk,             vf.rnk)             as rnk,
    decode(vf.rnk, null, vfu.vip,             vf.vip)             as vip,
    decode(vf.rnk, null, vfu.kvip,            vf.kvip)            as kvip,
    decode(vf.rnk, null, vfu.datbeg,          vf.datbeg)          as datbeg,
    decode(vf.rnk, null, vfu.datend,          vf.datend)          as datend,
    decode(vf.rnk, null, vfu.comments,        vf.comments)        as comments,
    decode(vf.rnk, null, vfu.cm_flag,         vf.cm_flag)         as cm_flag,
    decode(vf.rnk, null, vfu.cm_try,          vf.cm_try)          as cm_try,
    decode(vf.rnk, null, vfu.fio_manager,     vf.fio_manager)     as fio_manager,
    decode(vf.rnk, null, vfu.phone_manager,   vf.phone_manager)   as phone_manager,
    decode(vf.rnk, null, vfu.mail_manager,    vf.mail_manager)    as mail_manager,
    decode(vf.rnk, null, vfu.account_manager, vf.account_manager) as account_manager,
    bars.bars_sqnc.get_nextval('s_vip_flags_arc')                 as idupd,
    sysdate                                                       as fdat,
    l_staff_id                                                    as idu,
    decode(vf.rnk, null, 'D', 'U')                                as vid,
    bars.gl.kf                                                    as kf,
    coalesce(bars.gl.bd, bars.glb_bankdate)                       as effectdate,
    bars.glb_bankdate                                             as global_bdate
    from bars.vip_flags vf 
    full outer join (select ar.* from (select a.*, row_number() over(partition by a.mfo, a.rnk order by a.idupd desc) rn
                                        from bars.vip_flags_arc a
                                       where a.mfo = coalesce(bars.gl.kf, a.mfo)) ar
                     where ar.rn = 1
                     and ar.vid != 'D') vfu on (vf.rnk = vfu.rnk and vf.mfo = vfu.mfo)
    where 
    (  decode(vf.vip, vfu.vip, 1, 0) = 0
    or decode(vf.kvip, vfu.kvip, 1, 0) = 0
    or decode(vf.datbeg, vfu.datbeg, 1, 0) = 0
    or decode(vf.datend, vfu.datend, 1, 0) = 0
    or decode(vf.comments, vfu.comments, 1, 0) = 0
    or decode(vf.cm_flag, vfu.cm_flag, 1, 0) = 0
    or decode(vf.cm_try, vfu.cm_try, 1, 0) = 0
    or decode(vf.fio_manager, vfu.fio_manager, 1, 0) = 0
    or decode(vf.phone_manager, vfu.phone_manager, 1, 0) = 0
    or decode(vf.mail_manager, vfu.mail_manager, 1, 0) = 0
    or decode(vf.account_manager, vfu.account_manager, 1, 0) = 0)
    and (vf.mfo = coalesce(bars.gl.kf, vf.mfo) or vf.mfo is null);

    p_rowcount := SQL%ROWCOUNT;
    p_id := G_RUN_ID;
    INS_STAT('rowcount', 'SYNC', p_rowcount, l_tbl_name);
    END_PROCESS(l_tbl_name, 'SYNC');
    COMMIT;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            ERROR_PROCESS(l_tbl_name, 'ERR', substr(dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace(), 1, 1000) );
            RAISE;
    END;

    --------------------------------------------------------------------------------------------------------------------
    -- SYNC_VIP_FLAGS_ARC
    --------------------------------------------------------------------------------------------------------------------
    PROCEDURE SYNC_VIP_FLAGS_ARC
    IS
        l_run_id                      number;
        l_row_count                   number;
    BEGIN
        SYNC_VIP_FLAGS_ARC(l_run_id,l_row_count);
    EXCEPTION
        WHEN OTHERS
        THEN
            RAISE;
    END;

    --------------------------------------------------------------------------------------------------------------------
    -- CHECK_CP_ACCOUNTS_UPDATE( p_id out number)
    --------------------------------------------------------------------------------------------------------------------
    PROCEDURE CHECK_CP_ACCOUNTS_UPDATE( p_id out number)
    IS
        l_tbl_name                    VARCHAR2(100) := 'CP_ACCOUNTS_UPDATE';
        l_trace                       varchar2(500) := G_TRACE || 'CHECK_CP_ACCOUNTS_UPDATE: ';
    BEGIN
        start_process(l_tbl_name, 'CHECK');
        INSERT INTO BARS.UPDATE_TBL_STAT(ID, STAT_ID, FIELD_NAME, FIELD_TYPE, VALUE, RUN_ID, STARTDATE, ENDDATE, TBL_NAME)
        SELECT BARS.S_UPDATE_TBL_STAT.NEXTVAL,
               G_STAT_ID,
               DECODE(t_pivot.i, 4, fld4, 1, fld1, 2, fld2, 3, fld3) AS field,
               'count_diff' type1,
               DECODE(T_PIVOT.I, 4, DECODE(C4, NULL, 0, C4), 1, C1, 2, C2, 3, C3) AS CNT,
               G_RUN_ID,
               G_START_DT,
               G_END_DT,
               L_TBL_NAME
        FROM ( SELECT ROWNUM AS I FROM DUAL CONNECT BY LEVEL <= 4) T_PIVOT,
             ( SELECT
               'TOTAL_ROWS'  AS FLD4, SUM(1) AS C4,
               'CP_REF'      AS FLD1, SUM(DECODE(AC.CP_REF     , ACU.CP_REF     , 0, 1)) AS C1,
               'CP_ACCTYPE'  AS FLD2, SUM(DECODE(AC.CP_ACCTYPE , ACU.CP_ACCTYPE , 0, 1)) AS C2,
               'CP_ACC'      AS FLD3, SUM(DECODE(AC.CP_ACC     , ACU.CP_ACC     , 0, 1)) AS C3
             FROM BARS.CP_ACCOUNTS AC
             JOIN BARS.REGIONS R ON (R.CODE = SUBSTR(AC.CP_REF, -2, 2) AND R.KF = BARS.GL.KF)
             FULL OUTER JOIN (SELECT * FROM (SELECT A.*, ROW_NUMBER() OVER(PARTITION BY A.CP_REF, A.CP_ACCTYPE, A.CP_ACC ORDER BY A.IDUPD DESC) RN 
                                              FROM BARS.CP_ACCOUNTS_UPDATE A
                                             WHERE A.KF = BARS.GL.KF) AA
                              WHERE AA.RN =1
                              AND AA.CHGACTION <> 'D') ACU ON AC.CP_REF = ACU.CP_REF AND AC.CP_ACCTYPE = ACU.CP_ACCTYPE AND AC.CP_ACC = ACU.CP_ACC
             WHERE(DECODE(AC.CP_REF,     ACU.CP_REF,     1, 0) = 0
                OR DECODE(AC.CP_ACCTYPE, ACU.CP_ACCTYPE, 1, 0) = 0
                OR DECODE(AC.CP_ACC,     ACU.CP_ACC,     1, 0) = 0));

        p_id := G_RUN_ID;
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
    -- CHECK_CP_ACCOUNTS_UPDATE
    --------------------------------------------------------------------------------------------------------------------
    PROCEDURE CHECK_CP_ACCOUNTS_UPDATE
    IS
       l_run_id                      number;
    BEGIN
       CHECK_CP_ACCOUNTS_UPDATE(l_run_id);
    EXCEPTION
        WHEN OTHERS
        THEN
            RAISE;
    END;

    --------------------------------------------------------------------------------------------------------------------
    -- SYNC_CP_ACCOUNTS_UPDATE ( p_id out number, p_rowcount out number)
    --------------------------------------------------------------------------------------------------------------------
    PROCEDURE SYNC_CP_ACCOUNTS_UPDATE( p_id out number, p_rowcount out number)
    IS
        l_tbl_name                    VARCHAR2(100) := 'CP_ACCOUNTS_UPDATE';
        l_trace                       varchar2(500) := G_TRACE || 'SYNC_CP_ACCOUNTS_UPDATE: ';
        l_staff_id                    bars.staff$base.id%type;
        l_staff_nm                    bars.staff$base.logname%type;
    BEGIN
    
    START_PROCESS(l_tbl_name, 'SYNC');
    SELECT id, logname into l_staff_id, l_staff_nm FROM bars.staff$base WHERE logname = G_LOGNAME;
    INSERT INTO bars.cp_accounts_update (idupd, chgaction, effectdate, globalbd, chgdate, doneby, kf, cp_ref, cp_acctype, cp_acc)
    select bars.bars_sqnc.get_nextval('s_cpaccounts_update')          as idupd,
           decode(ac.cp_ref, null, 'D', 'U')                          as chgaction, -- OR decode(ac.cp_ref, null, 'D', 'I') because trigger gives two case : D and I
           coalesce(bars.gl.bd, bars.glb_bankdate)                    as effectdate,
           bars.glb_bankdate                                          as globalbd,
           sysdate                                                    as chgdate, 
           l_staff_id                                                 as doneby, 
           coalesce (r.kf, acu.kf)                                    as kf,
           decode(ac.cp_ref,     null, acu.cp_ref,     ac.cp_ref)     as cp_ref,
           decode(ac.cp_acctype, null, acu.cp_acctype, ac.cp_acctype) as cp_acctype,
           decode(ac.cp_acc,     null, acu.cp_acc,     ac.cp_acc)     as cp_acc
           from bars.cp_accounts ac
           join bars.regions r on (r.code = substr(ac.cp_ref, -2, 2) and r.kf = bars.gl.kf)
           full outer join (select * from (select a.*, row_number() over(partition by a.cp_ref, a.cp_acctype, a.cp_acc order by a.idupd desc) rn 
                                            from bars.cp_accounts_update a
                                           where a.kf = bars.gl.kf) aa
                            where aa.rn =1
                            and aa.chgaction <> 'D') acu on ac.cp_ref = acu.cp_ref and ac.cp_acctype = acu.cp_acctype and ac.cp_acc = acu.cp_acc
           where(decode(ac.cp_ref,     acu.cp_ref,     1, 0) = 0
              or decode(ac.cp_acctype, acu.cp_acctype, 1, 0) = 0
              or decode(ac.cp_acc,     acu.cp_acc,     1, 0) = 0);

    p_rowcount := SQL%ROWCOUNT;
    p_id := G_RUN_ID;
    INS_STAT('rowcount', 'SYNC', p_rowcount, l_tbl_name);
    END_PROCESS(l_tbl_name, 'SYNC');
    COMMIT;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            ERROR_PROCESS(l_tbl_name, 'ERR', substr(dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace(), 1, 1000) );
            RAISE;
    END;

    --------------------------------------------------------------------------------------------------------------------
    -- SYNC_CP_ACCOUNTS_UPDATE
    --------------------------------------------------------------------------------------------------------------------
    PROCEDURE SYNC_CP_ACCOUNTS_UPDATE
    IS
        l_run_id                      number;
        l_row_count                   number;
    BEGIN
        SYNC_CP_ACCOUNTS_UPDATE(l_run_id,l_row_count);
    EXCEPTION
        WHEN OTHERS
        THEN
            RAISE;
    END;

END;
/

PROMPT *** Create  grants  UPDATE_TBL_UTL ***

begin
   execute immediate 'grant EXECUTE  on BARS.UPDATE_TBL_UTL     to BARSUPL';
   exception when others then if sqlcode=-1917 or sqlcode=-990 or sqlcode=-1031   then null; else raise; end if;  --ORA-01031: insufficient privileges
end;
/

begin
   execute immediate 'grant EXECUTE  on BARS.UPDATE_TBL_UTL     to BARS_ACCESS_USER';
   exception when others then if sqlcode=-1917 or sqlcode=-990 or sqlcode=-1031  then null; else raise; end if; --ORA-01031: insufficient privileges
end;
/

begin
   execute immediate 'grant EXECUTE  on BARS.UPDATE_TBL_UTL     to UPLD';
   exception when others then if sqlcode=-1917 or sqlcode=-990 or sqlcode=-1031  then null; else raise; end if; --ORA-01031: insufficient privileges
end;
/

PROMPT =====================================================================================
PROMPT *** End *** ============= Scripts /Sql/BARS/package/update_tbl_utl.sql ============***
PROMPT =====================================================================================
