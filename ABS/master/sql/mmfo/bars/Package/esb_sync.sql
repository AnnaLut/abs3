-- Start of DDL Script for Package BARS.ESB_SYNC
-- Generated 25.02.2019 17:12:04 from BARS@COBUSUPABS_DEV_MMFO_DB

CREATE OR REPLACE 
PACKAGE esb_sync
AS
    -- Тестирование. Вариант вызова сервиса
    g_execute_version             NUMBER (1) DEFAULT 0;

    gc_header_version    CONSTANT VARCHAR2 (64) := 'version 1.03 25/02/2019';
    gc_awk_header_defs   CONSTANT VARCHAR2 (512) := '';

    --- TBIU_CURRATEKOMUPD  TAIU_DILER_KURS_FACT

    ---- установка параметров в web_barsconfig параметров используемых для сервиса
    PROCEDURE set_param_web_barsconfig (
        l_config_key         web_barsconfig.key%TYPE,
        l_config_val         web_barsconfig.val%TYPE,
        l_config_descript    web_barsconfig.comm%TYPE DEFAULT NULL);

    PROCEDURE define_global_var;

    FUNCTION get_is_needed (pi_table_name VARCHAR2)
        RETURN BOOLEAN;

    FUNCTION get_msgid (pi_custype VARCHAR2)
        RETURN bars_intgr.cur_rate_commercial.msgid%TYPE;

    -------------------
    PROCEDURE create_main_jobs (pi_interval_run NUMBER DEFAULT 60);

    PROCEDURE create_job (pi_custype VARCHAR2);

    PROCEDURE stop_job (pi_custype VARCHAR2);

    PROCEDURE run_all_sync;

    PROCEDURE syncurse_official_job;

    PROCEDURE syncurse_commercial_job;

    PROCEDURE syncurse_dealer_job;



    PROCEDURE purge_old_data;

    ------------
    PROCEDURE execute_soap_own (
        po_request          OUT NOCOPY CLOB,
        po_response         OUT NOCOPY CLOB,
        po_status_code      OUT        NUMBER,
        li_table_name                  VARCHAR2,
        li_msgid                       bars_intgr.cur_rate_commercial.msgid%TYPE);

    PROCEDURE execute_soap (
        li_table_name                 VARCHAR2,
        li_msgid                      bars_intgr.cur_rate_commercial.msgid%TYPE,
        po_error           OUT NOCOPY VARCHAR2,
        po_staus           OUT        bars_intgr.cur_rate_commercial.state%TYPE);

    --------------------------------------------------------------------------------
    -- header_version - возвращает версию заголовка пакета

    FUNCTION header_version
        RETURN VARCHAR2;

    -- body_version - возвращает версию тела пакета

    FUNCTION body_version
        RETURN VARCHAR2;
END;
/



-- End of DDL Script for Package BARS.ESB_SYNC

-- Start of DDL Script for Package Body BARS.ESB_SYNC
-- Generated 25.02.2019 17:12:04 from BARS@COBUSUPABS_DEV_MMFO_DB

CREATE OR REPLACE 
PACKAGE BODY esb_sync
AS
    gc_body_version    CONSTANT VARCHAR2 (64) := 'version 1.12 25/02/2019';
    gc_awk_body_defs   CONSTANT VARCHAR2 (512) := '';

    TYPE t_param4soap IS TABLE OF VARCHAR2 (500)
        INDEX BY VARCHAR2 (100);

    ----- константы
    -- state 0 добавлено, 1 отправлено сервису, 2 успешное обработан, 8 устарел
    cstate_new         CONSTANT NUMBER (1) := 0;
    cstate_sent        CONSTANT NUMBER (1) := 1;
    cstate_process     CONSTANT NUMBER (1) := 2;
    cstate_stale       CONSTANT NUMBER (1) := 8;

    ----  основніе переменніе доступа к сервису
    ---

    g_service_method            VARCHAR2 (100);
    g_xmlhead          CONSTANT VARCHAR2 (100)
        := '<?xml version="1.0" encoding="utf-8"?>' ;
    g_transfer_timeout          NUMBER;
    g_url                       VARCHAR2 (2000);
    g_url_abs                   VARCHAR2 (2000);
    g_wallet_path               VARCHAR2 (4000 BYTE);
    g_wallet_pass               VARCHAR2 (4000 BYTE);
    g_soap_login                VARCHAR2 (4000 BYTE);
    g_soap_password             VARCHAR2 (4000 BYTE);

    g_request                   wsm_mgr.t_request;
    g_parameters                wsm_mgr.t_parameters;
    g_headers                   wsm_mgr.t_headers;

    gc_name_unit       CONSTANT VARCHAR2 (500) DEFAULT $$plsql_unit || '.';
    g_name_unit                 VARCHAR2 (500);



    PROCEDURE set_param_web_barsconfig (
        l_config_key         web_barsconfig.key%TYPE,
        l_config_val         web_barsconfig.val%TYPE,
        l_config_descript    web_barsconfig.comm%TYPE DEFAULT NULL)
    AS
    BEGIN
        IF l_config_key IS NULL
        THEN
            RETURN;
        END IF;

        MERGE INTO web_barsconfig wbc
        USING      (SELECT INITCAP (TRIM (l_config_key)) key,
                           l_config_val val
                    FROM   DUAL) v
        ON         (wbc.key = v.key)
        WHEN MATCHED
        THEN
            UPDATE SET
                wbc.val = v.val, wbc.comm = NVL (l_config_descript, comm)
                WHERE      wbc.val <> v.val OR wbc.comm <> comm
        WHEN NOT MATCHED
        THEN
            INSERT VALUES     (1,
                               INITCAP (TRIM (l_config_key)),
                               NULL,
                               l_config_val,
                               l_config_descript);

        DBMS_OUTPUT.put_line (
               gc_name_unit
            || 'set_param_web_barsconfig  =>  Параметр '
            || l_config_key
            || ' значение '
            || l_config_val
            || ' Изменено строк: '
            || SQL%ROWCOUNT);
    END set_param_web_barsconfig;



    PROCEDURE define_global_var
    AS
    BEGIN
        g_execute_version := NVL ($$soap_mode_type, 0);
        g_name_unit := gc_name_unit || 'define_global_var => ';

        g_url := parameter_utl.get_value_from_config ('Esb_Currency.Url');
        ---- константа. привязка к WebRozdrib
        g_url_abs :=  getglobaloption ('LINK_FOR_ABSBARS_WEBROZDRIB') || 'ABSCurrencyRates.asmx' ;
        g_service_method :=
            parameter_utl.get_value_from_config ('Esb_Currency.Method');

        g_wallet_path :=
            parameter_utl.get_value_from_config ('Esb_Currency.Wallet_Dir');
        g_wallet_pass :=
            parameter_utl.get_value_from_config ('Esb_Currency.Wallet_Pass');

        --- в текущей реализации не используются. но пусть будут
        g_soap_login :=
            parameter_utl.get_value_from_config ('Esb_Currency.Soap_Login');
        g_soap_password :=
            parameter_utl.get_value_from_config ('Esb_Currency.Soap_Pasword');

        g_transfer_timeout :=
            NVL (
                parameter_utl.get_value_from_config ('Esb_Currency.Timeout'),
                60);

        bars_audit.trace (
            '%s Заполнение параметров URL = %s  URL_ABS = %s Метод  = %s Wallet_path = %s',
            g_name_unit,
            g_url,
            g_url_abs,
            g_service_method,
            g_wallet_path);
    END define_global_var;


    --- получаем MsgID для таблицы
    FUNCTION get_msgid (pi_custype VARCHAR2)
        RETURN bars_intgr.cur_rate_commercial.msgid%TYPE
    AS
    BEGIN
        RETURN CASE UPPER (pi_custype)
                   WHEN 'CUR_RATE_COMMERCIAL'
                   THEN
                       bars_intgr.s_cur_rate_commercial.NEXTVAL
                   WHEN 'CUR_RATE_DEALER'
                   THEN
                       bars_intgr.s_cur_rate_dealer.NEXTVAL
                   WHEN 'CUR_RATE_OFFICIAL'
                   THEN
                       bars_intgr.s_cur_rate_official.NEXTVAL
                   ELSE
                       0
               END;
    END get_msgid;

    PROCEDURE loggi (
        pi_msgid                          bars_intgr.cur_esb_sync_log.msgid%TYPE,
        pi_curtype                        bars_intgr.cur_esb_sync_log.cur_type%TYPE,
        pi_request          IN OUT NOCOPY bars_intgr.cur_esb_sync_log.request%TYPE,
        pi_response         IN OUT NOCOPY bars_intgr.cur_esb_sync_log.response%TYPE,
        pi_responsestatus                 bars_intgr.cur_esb_sync_log.responsestatus%TYPE DEFAULT NULL,
        pi_errortext                      bars_intgr.cur_esb_sync_log.errortext%TYPE DEFAULT NULL)
    AS
        PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
        INSERT INTO bars_intgr.cur_esb_sync_log (msgid,
                                                 cur_type,
                                                 request,
                                                 response,
                                                 responsestatus,
                                                 msgsysdate,
                                                 errortext)
        VALUES      (pi_msgid,
                     pi_curtype,
                     pi_request,
                     pi_response,
                     pi_responsestatus,
                     SYSDATE,
                     pi_errortext);

        COMMIT;
    END;

    FUNCTION get_textvalue (
        pi_clob            IN OUT NOCOPY XMLTYPE,
        pi_nodename                      VARCHAR2,
        pi_namespacename                 VARCHAR2 DEFAULT NULL)
        RETURN VARCHAR2
    AS
        l_res       VARCHAR2 (4000);
        l_res_xml   XMLTYPE;
    BEGIN
        l_res_xml :=
            pi_clob.EXTRACT (pi_nodename || '/text()', pi_namespacename);

        IF l_res_xml IS NOT NULL
        THEN
            l_res := l_res_xml.getstringval ();
        ELSE
            l_res := NULL;
        END IF;

        RETURN l_res;
    END get_textvalue;

    FUNCTION get_textvalue (
        pi_clob            IN OUT NOCOPY CLOB,
        pi_nodename                      VARCHAR2,
        pi_namespacename                 VARCHAR2 DEFAULT NULL)
        RETURN VARCHAR2
    AS
        l_res_xml   XMLTYPE;
    BEGIN
        l_res_xml := xmltype (pi_clob);
        RETURN get_textvalue (l_res_xml, pi_nodename, pi_namespacename);
    END;

    FUNCTION get_is_needed (pi_table_name VARCHAR2)
        RETURN BOOLEAN
    AS
        l_result   NUMBER;
        p_sql      VARCHAR2 (2000);
    BEGIN
        EXECUTE IMMEDIATE
               'SELECT COUNT (1) FROM   bars_intgr.'
            || pi_table_name
            || ' WHERE  state IN (0, 1) '
            INTO l_result;

        RETURN NOT l_result = 0;
    END get_is_needed;



    PROCEDURE stop_job (pi_custype VARCHAR2)
    AS
    -- ORA-27366: job "BARS.ESB_CURS_OFF" is not running
    -- ORA-27475: "BARS.ESB_CURS_OFF" must be a job


    BEGIN
        CASE pi_custype
            WHEN 'CUR_RATE_COMMERCIAL'
            THEN
                DBMS_SCHEDULER.stop_job ('ESB_CURS_COMM', TRUE);
            WHEN 'CUR_RATE_DEALER'
            THEN
                DBMS_SCHEDULER.stop_job ('ESB_CURS_DEAL', TRUE);
            WHEN 'CUR_RATE_OFFICIAL'
            THEN
                DBMS_SCHEDULER.stop_job ('ESB_CURS_OFF', TRUE);
        END CASE;
    EXCEPTION
        WHEN OTHERS
        THEN
            IF SQLCODE IN (-27366)
            THEN
                NULL;
            ELSE
                RAISE;
            END IF;
    END stop_job;

    PROCEDURE start_job (pi_custype VARCHAR2)
    AS
    BEGIN
        CASE pi_custype
            WHEN 'CUR_RATE_COMMERCIAL'
            THEN
                DBMS_SCHEDULER.enable ('ESB_CURS_COMM');
            --DBMS_SCHEDULER.run_job ('ESB_CURS_COMM');
            WHEN 'CUR_RATE_DEALER'
            THEN
                DBMS_SCHEDULER.enable ('ESB_CURS_DEAL');
            --DBMS_SCHEDULER.run_job ('ESB_CURS_DEAL');
            WHEN 'CUR_RATE_OFFICIAL'
            THEN
                DBMS_SCHEDULER.enable ('ESB_CURS_OFF');
        --DBMS_SCHEDULER.run_job ('ESB_CURS_OFF');
        END CASE;
    END start_job;

    PROCEDURE drop_job (pi_custype VARCHAR2)
    AS
    BEGIN
        DBMS_SCHEDULER.drop_job (pi_custype);
    EXCEPTION
        WHEN OTHERS
        THEN
            IF SQLCODE = -27475 --[1]: ORA-27475: "BARS.ESB_CURS_SYNC" must be a job
            THEN
                NULL;
            END IF;
    END drop_job;

    PROCEDURE create_main_jobs (pi_interval_run NUMBER DEFAULT 60)
    AS
    BEGIN
        drop_job ('ESB_CURS_SYNC');
        drop_job ('ESB_CURS_COMM');
        drop_job ('ESB_CURS_OFF');
        drop_job ('ESB_CURS_DEAL');

        DBMS_SCHEDULER.create_job (
            job_name          => 'ESB_CURS_SYNC',
            job_type          => 'PLSQL_BLOCK',
            job_action        => 'esb_sync.run_all_sync;',
            start_date        => SYSTIMESTAMP,
            repeat_interval   => 'FREQ=SECONDLY;INTERVAL=' || pi_interval_run,
            end_date          => NULL,
            enabled           => TRUE,
            auto_drop         => FALSE,
            comments          => 'Cинхронизация курсов ');

        create_job ('CUR_RATE_OFFICIAL');
        create_job ('CUR_RATE_COMMERCIAL');
        create_job ('CUR_RATE_DEALER');
    END;

    PROCEDURE create_job (pi_custype VARCHAR2)
    AS
        l_job_name         VARCHAR2 (250);
        l_procedure_name   VARCHAR2 (250);
        l_interval         NUMBER;
    BEGIN
        l_interval :=
            NVL (
                parameter_utl.get_value_from_config ('Esb_Currency.Interval'),
                60);

        CASE pi_custype
            WHEN 'CUR_RATE_COMMERCIAL'
            THEN
                l_procedure_name := 'esb_sync.syncurse_commercial_job';
                l_job_name := 'ESB_CURS_COMM';
            WHEN 'CUR_RATE_DEALER'
            THEN
                l_procedure_name := 'esb_sync.syncurse_dealer_job';
                l_job_name := 'ESB_CURS_DEAL';
            WHEN 'CUR_RATE_OFFICIAL'
            THEN
                l_procedure_name := 'esb_sync.syncurse_official_job';
                l_job_name := 'ESB_CURS_OFF';
        END CASE;

        drop_job (l_job_name);
        DBMS_SCHEDULER.create_job (
            job_name          => l_job_name,
            job_type          => 'STORED_PROCEDURE',
            job_action        => l_procedure_name,
            start_date        => SYSTIMESTAMP,
            repeat_interval   => 'FREQ=SECONDLY;INTERVAL=' || l_interval,
            end_date          => NULL,
            enabled           => FALSE,
            auto_drop         => TRUE,
            comments          =>    'Синхронизация курсов валют по витрине '
                                 || pi_custype);
    END create_job;

    PROCEDURE set_state_stale (pi_custype VARCHAR2)
    AS
        TYPE t_rowid IS TABLE OF ROWID;

        lt_rowid   t_rowid;
        l_cursor   SYS_REFCURSOR;
    BEGIN
        g_name_unit := gc_name_unit || 'set_state_stale => ';

        OPEN l_cursor FOR
               ' SELECT ro
                FROM   (SELECT r.rowid ro,
                ROW_NUMBER () OVER (PARTITION BY kv ORDER BY kvfixingdate DESC) rn
        FROM   bars_intgr.'
            || pi_custype
            || ' r  WHERE  r.state IN (0, 1)) WHERE  rn > 1 ';

        FETCH l_cursor
        BULK COLLECT INTO lt_rowid;

        ---- есть ли  устаревшие курсі
        IF lt_rowid.COUNT = 0
        THEN
            RETURN;
        END IF;

        FORALL i IN 1 .. lt_rowid.LAST
            EXECUTE IMMEDIATE
                   ' UPDATE bars_intgr.'
                || pi_custype
                || '  r
            SET    r.state = 8  --, KVNAME=KVNAME||''**''
            WHERE  r.ROWID = :rid'
                USING lt_rowid (i);

        bars_audit.trace ('%s Помечено устарешими в %s %s строк',
                          g_name_unit,
                          pi_custype,
                          TO_CHAR (lt_rowid.COUNT));
    END set_state_stale;

    PROCEDURE set_new_msgid (pi_custype VARCHAR2)
    AS
        l_count_new   NUMBER;
        l_msgid_new   bars_intgr.cur_rate_commercial.msgid%TYPE;
    BEGIN
        g_name_unit := gc_name_unit || 'set_new_msgid => ';

        EXECUTE IMMEDIATE
               'SELECT COUNT (1)
        FROM   bars_intgr.'
            || pi_custype
            || ' r   WHERE  r.state = 0 AND r.msgid IS NULL'
            INTO l_count_new;


        bars_audit.trace ('%s промежуточно для нового msgid %s',
                          TO_CHAR (l_count_new));


        IF l_count_new = 0
        THEN
            bars_audit.trace ('%s Новый MsgID для %s не требуется',
                              g_name_unit,
                              pi_custype);
            RETURN;
        END IF;

        ---  есть курсы которым требуется msgid
        l_msgid_new := get_msgid (pi_custype);

        EXECUTE IMMEDIATE
               'UPDATE bars_intgr.'
            || pi_custype
            || '  r
            SET    r.msgid = :msgid
            WHERE      r.state = 0
                   AND r.msgid IS NULL '
            USING l_msgid_new;

        bars_audit.trace ('%s Взяли новый MsgID %s  для %s для %s строк ',
                          g_name_unit,
                          TO_CHAR (l_msgid_new),
                          pi_custype,
                          TO_CHAR (SQL%ROWCOUNT));
    END set_new_msgid;

    PROCEDURE set_state_sent (
        pi_custype    VARCHAR2,
        pi_state      bars_intgr.cur_rate_commercial.state%TYPE,
        pi_msgid      bars_intgr.cur_rate_commercial.msgid%TYPE)
    AS
    BEGIN
        g_name_unit := gc_name_unit || 'set_state_sent => ';

        ---bars_audit.trace ('%s Start ', g_name_unit);

        EXECUTE IMMEDIATE
               'UPDATE bars_intgr.'
            || pi_custype
            || ' r
            SET    r.state = :state
            WHERE  r.msgid = :msgid AND r.state <> :state and r.state in (0,1)'
            USING pi_state, pi_msgid, pi_state;


        IF SQL%ROWCOUNT <> 0
        THEN
            bars_audit.trace (
                '%s Обработано - %s в %s по MSDID %s. Установлен статус %s',
                g_name_unit,
                TO_CHAR (SQL%ROWCOUNT),
                pi_custype,
                TO_CHAR (pi_msgid),
                TO_CHAR (pi_state));
        END IF;
    END;

    --- проходим по всем витринам и в случае наличия несинхрон кусов (записи со статусом 0,1)  запускаем процесс по ней
    PROCEDURE run_all_sync
    AS
    BEGIN
        g_name_unit := gc_name_unit || 'run_all_sync => ';
        bars_audit.trace ('%s Запуск', g_name_unit);

        IF get_is_needed ('CUR_RATE_OFFICIAL')
        THEN
            start_job ('CUR_RATE_OFFICIAL');
        END IF;

        IF get_is_needed ('CUR_RATE_COMMERCIAL')
        THEN
            start_job ('CUR_RATE_COMMERCIAL');
        END IF;

        IF get_is_needed ('CUR_RATE_DEALER')
        THEN
            start_job ('CUR_RATE_DEALER');
        END IF;
    END run_all_sync;


    PROCEDURE syncurse_official_job
    AS
        l_error       VARCHAR2 (2000);
        l_state_new   bars_intgr.cur_rate_commercial.state%TYPE;
    BEGIN
        g_name_unit := gc_name_unit || 'syncurse_official_job => ';

        bars_audit.trace ('%s Запуск JOB', g_name_unit);

        set_state_stale ('CUR_RATE_OFFICIAL');
        set_new_msgid ('CUR_RATE_OFFICIAL');

        COMMIT;                         ---- чтобы изменения msgid видела шина

        FOR rec
            IN (SELECT   DISTINCT r.msgid, 'CUR_RATE_OFFICIAL' tname
                FROM     bars_intgr.cur_rate_official r
                WHERE        r.state IN (cstate_new, cstate_sent)
                         AND r.msgid IS NOT NULL
                ORDER BY msgid)
        LOOP
            execute_soap (li_table_name   => rec.tname,
                          li_msgid        => rec.msgid,
                          po_error        => l_error,
                          po_staus        => l_state_new);

            set_state_sent (pi_custype   => 'CUR_RATE_OFFICIAL',
                            pi_state     => l_state_new,
                            pi_msgid     => rec.msgid);
        END LOOP;

        COMMIT;
        bars_audit.trace ('%s End JOB', g_name_unit);

        ---- если нет несинхронизированных курсов, отключаемся
        IF NOT get_is_needed ('CUR_RATE_OFFICIAL')
        THEN
            DBMS_SCHEDULER.disable ('ESB_CURS_OFF', TRUE);
        END IF;
    END syncurse_official_job;

    PROCEDURE syncurse_commercial_job
    AS
        l_error       VARCHAR2 (2000);
        l_state_new   bars_intgr.cur_rate_commercial.state%TYPE;
    BEGIN
        g_name_unit := gc_name_unit || 'syncurse_commercial_job => ';
        bars_audit.trace ('%s START JOB', g_name_unit);

        set_state_stale ('CUR_RATE_COMMERCIAL');
        set_new_msgid ('CUR_RATE_COMMERCIAL');

        COMMIT;                         ---- чтобы изменения msgid видела шина

        FOR rec
            IN (SELECT   DISTINCT r.msgid, 'CUR_RATE_COMMERCIAL' tname
                FROM     bars_intgr.cur_rate_commercial r
                WHERE        r.state IN (cstate_new, cstate_sent)
                         AND r.msgid IS NOT NULL
                ORDER BY msgid)
        LOOP
            execute_soap (li_table_name   => rec.tname,
                          li_msgid        => rec.msgid,
                          po_error        => l_error,
                          po_staus        => l_state_new);

            set_state_sent (pi_custype   => 'CUR_RATE_COMMERCIAL',
                            pi_state     => l_state_new,
                            pi_msgid     => rec.msgid);
        END LOOP;

        COMMIT;

        ---- если нет несинхронизированных курсов, отключаемся
        IF NOT get_is_needed ('CUR_RATE_COMMERCIAL')
        THEN
            DBMS_SCHEDULER.disable ('ESB_CURS_COMM', TRUE);
        END IF;
    END syncurse_commercial_job;

    PROCEDURE syncurse_dealer_job
    AS
        l_error       VARCHAR2 (2000);
        l_state_new   bars_intgr.cur_rate_commercial.state%TYPE;
    BEGIN
        g_name_unit := gc_name_unit || 'syncurse_dealer_job => ';
        bars_audit.trace ('%s START JOB', g_name_unit);

        set_state_stale ('CUR_RATE_DEALER');
        set_new_msgid ('CUR_RATE_DEALER');

        COMMIT;                         ---- чтобы изменения msgid видела шина

        FOR rec
            IN (SELECT   DISTINCT r.msgid, 'CUR_RATE_DEALER' tname
                FROM     bars_intgr.cur_rate_dealer r
                WHERE        r.state IN (cstate_new, cstate_sent)
                         AND r.msgid IS NOT NULL
                ORDER BY msgid)
        LOOP
            execute_soap (li_table_name   => rec.tname,
                          li_msgid        => rec.msgid,
                          po_error        => l_error,
                          po_staus        => l_state_new);

            set_state_sent (pi_custype   => 'CUR_RATE_DEALER',
                            pi_state     => l_state_new,
                            pi_msgid     => rec.msgid);
        END LOOP;

        COMMIT;

        ---- если нет несинхронизированных курсов, дизейблим джоб
        IF NOT get_is_needed ('CUR_RATE_DEALER')
        THEN
            DBMS_SCHEDULER.disable ('ESB_CURS_DEAL', TRUE);
        END IF;

        bars_audit.trace ('%s EXIT JOB', g_name_unit);
    END syncurse_dealer_job;

    PROCEDURE purge_old_data
    AS
        p_date   DATE;
    BEGIN
        g_name_unit := gc_name_unit || 'purge_old_data => ';
        p_date := TRUNC (SYSDATE) - 30;

        DELETE FROM bars_intgr.cur_rate_commercial
        WHERE       arcdate < p_date;

        DELETE FROM bars_intgr.cur_rate_dealer
        WHERE       arcdate < p_date;

        DELETE FROM bars_intgr.cur_rate_official
        WHERE       arcdate < p_date;

        COMMIT;

        DELETE FROM bars_intgr.cur_esb_sync_log
        WHERE       msgsysdate < p_date;

        COMMIT;

        bars_audit.info (
               g_name_unit
            || 'Выполнена очистка витрин в BARS_INTGR : CUR_RATE_COMMERCIAL , CUR_RATE_DEALER, CUR_RATE_OFFICIAL по дату '
            || TO_CHAR (p_date, 'dd-mm-yyyy'));
    END purge_old_data;

    ----------------------------------------
    ------ вызовы сервиса

    PROCEDURE prepare_request
    AS
    BEGIN
        --bars_audit.trace (gc_name_unit || 'prepare_request');

        ---- готовимся
        g_parameters.delete;
        g_headers.delete;

        DBMS_LOB.createtemporary (g_request.body, FALSE);

        g_request.url := g_url;
        g_request.action := NULL;
        g_request.http_method := wsm_mgr.g_http_post;
        g_request.content_type := wsm_mgr.g_ct_xml; -- 'text/xml' ; g_ct_json 'application/json' ; g_ct_html 'text/html'
        g_request.content_charset := wsm_mgr.g_cc_utf8; --   g_cc_utf8    constant varchar2(20) := 'charset=utf-8';   g_cc_win1251 constant varchar2(20) := 'charset=windows-1251';
        g_request.wallet_path := g_wallet_path;
        g_request.wallet_pwd := g_wallet_pass;
        --   g_request.body := p_body;
        --   g_request.blob_body := p_blob_body;
        g_request.parameters := g_parameters;
        g_request.headers := g_headers;
        g_request.soap_method := g_service_method;
        g_request.soap_login := g_soap_login;
        g_request.soap_password := g_soap_password;
    END prepare_request;

    PROCEDURE execute_soap (
        li_table_name                 VARCHAR2,
        li_msgid                      bars_intgr.cur_rate_commercial.msgid%TYPE,
        po_error           OUT NOCOPY VARCHAR2,
        po_staus           OUT        bars_intgr.cur_rate_commercial.state%TYPE)
    AS
        l_response        wsm_mgr.t_response;
        l_status_code     INTEGER;
        l_error_details   CLOB;
        l_request         CLOB;
        l_body            CLOB;
    BEGIN
        g_name_unit := gc_name_unit || 'execute_soap => ';
        po_staus := cstate_sent;

        IF g_url IS NULL OR g_url_abs IS NULL OR g_service_method IS NULL
        THEN
            bars_audit.trace (
                '%s Не заполнен все необходимые параметры вызова сервиса URL = %s URL_ABS = %s  Метод  = %s ',
                g_name_unit,
                g_url,
                g_url_abs,
                g_service_method);
            raise_application_error (
                -20001,
                'Не заполнен все необходимые параметры вызова сервиса ИШД');
        END IF;

        ----формируем тело запроса
        DBMS_LOB.createtemporary (l_body, TRUE);
        DBMS_LOB.append (
            l_body,
               '<requestBody><MsgID>'
            || TO_CHAR (li_msgid)
            || '</MsgID><RateType>'
            || li_table_name
            || '</RateType><TimeStamp>'
            || TO_CHAR (SYSDATE, 'yyyy-mm-dd"T"hh24:mi:ss')
            || '</TimeStamp></requestBody>');

        DBMS_LOB.append (l_body, '<url>' || g_url || '</url>');


        bars.wsm_mgr.prepare_request (
            p_url            => g_url_abs,
            p_action         => NULL,
            p_http_method    => bars.wsm_mgr.g_http_post,
            p_content_type   => bars.wsm_mgr.g_ct_xml,
            p_namespace      => 'http://tempuri.org/',
            p_soap_method    => g_service_method,
            p_wallet_path    => g_wallet_path,
            p_wallet_pwd     => g_wallet_pass,
            p_body           => l_body);

        ---- вызов сервиса
        bars.wsm_mgr.execute_soap (l_response,
                                   l_status_code,
                                   l_error_details);

        -- разбор результата

        IF l_status_code IN (404)
        THEN
            po_error := 'Не удалось найти данный ресурс - ' || g_url_abs;
        ELSIF l_status_code IN (200, 201)
        THEN
            --- сервер вызван успешно

            IF LOWER (TRIM (get_textvalue (l_response.cdoc, '//Result'))) =
                   'true'
            THEN
                po_error := NULL;
                po_staus := cstate_process;
            ELSE
                po_error :=
                       get_textvalue (l_response.cdoc, '//ErrorId')
                    || ' '
                    || get_textvalue (l_response.cdoc, '//ErrorMessage');
            END IF;
        ELSE
            po_error := get_textvalue (l_error_details, '//faultstring');
        END IF;

        loggi (pi_msgid            => li_msgid,
               pi_curtype          => li_table_name,
               pi_request          => l_body,
               pi_response         => l_response.cdoc,
               pi_responsestatus   => l_status_code,
               pi_errortext        => po_error);
    EXCEPTION
        WHEN OTHERS
        THEN
            po_error := SQLERRM;
            po_staus := cstate_sent;
            loggi (pi_msgid            => li_msgid,
                   pi_request          => l_request,
                   pi_response         => l_response.cdoc,
                   pi_curtype          => li_table_name,
                   pi_responsestatus   => 0,
                   pi_errortext        => SQLCODE || ' ' || SQLERRM);
    END execute_soap;

    PROCEDURE execute_soap_own (
        po_request          OUT NOCOPY CLOB,
        po_response         OUT NOCOPY CLOB,
        po_status_code      OUT        NUMBER,
        li_table_name                  VARCHAR2,
        li_msgid                       bars_intgr.cur_rate_commercial.msgid%TYPE)
    AS
        TYPE t_parameters IS TABLE OF bars.wsm_mgr.t_parameter
            INDEX BY BINARY_INTEGER;

        TYPE t_headers IS TABLE OF bars.wsm_mgr.t_header
            INDEX BY BINARY_INTEGER;


        TYPE t_request IS RECORD
        (
            url               VARCHAR2 (32767),
            action            VARCHAR2 (256),
            http_method       VARCHAR2 (10),
            content_type      VARCHAR2 (256),
            content_charset   VARCHAR2 (256),
            wallet_path       VARCHAR2 (256),
            wallet_pwd        VARCHAR2 (256),
            body              CLOB,
            blob_body         BLOB,
            parameters        t_parameters,
            headers           t_headers,
            namespace         VARCHAR2 (256),
            soap_method       VARCHAR2 (256),
            soap_login        VARCHAR2 (30 CHAR),
            soap_password     VARCHAR2 (255 CHAR)
        );

        l_parameter    bars.wsm_mgr.t_parameter;

        l_http_req     UTL_HTTP.req;
        l_http_resp    UTL_HTTP.resp;
        l_header       bars.wsm_mgr.t_header;
        l_db_charset   VARCHAR2 (100) := 'AL32UTF8';

        l_env          CLOB;
        l_env_length   NUMBER;
        l_tmp          RAW (32767);
        l_result       CLOB;
        l_offset       NUMBER := 1;
        l_amount       NUMBER := 2000;
        l_buffer       VARCHAR2 (2000);

        PROCEDURE ADD_PARAMETER (p_name    IN VARCHAR2,
                                 p_value   IN CLOB,
                                 p_type    IN VARCHAR2 DEFAULT 'string')
        AS
            l_parameter   bars.wsm_mgr.t_parameter;
        BEGIN
            l_parameter.p_param_name := p_name;
            l_parameter.p_param_value := p_value;
            l_parameter.p_param_type := p_type;
            g_request.parameters (g_request.parameters.COUNT + 1) :=
                l_parameter;
        END;
    BEGIN
        g_name_unit := gc_name_unit || 'execute_soap_own => ';
        bars_audit.trace ('%s Start service');

        prepare_request;

        ADD_PARAMETER (p_name => 'MsgID', p_value => TO_CHAR (li_msgid));
        ADD_PARAMETER (p_name => 'RateType', p_value => li_table_name);
        ADD_PARAMETER (
            p_name    => 'Timestamp',
            p_value   => TO_CHAR (SYSDATE, 'yyyy-mm-dd"T"hh24:mi:ss'));


        ---добавка параметров в тело запроса через массив
        FOR i IN 1 .. g_request.parameters.COUNT
        LOOP
            l_parameter := g_request.parameters (i);

            DBMS_LOB.writeappend (
                g_request.body,
                LENGTH ('<' || l_parameter.p_param_name || '>'),
                '<' || l_parameter.p_param_name || '>');
            DBMS_LOB.append (g_request.body,
                             DBMS_XMLGEN.CONVERT (l_parameter.p_param_value));
            DBMS_LOB.writeappend (
                g_request.body,
                LENGTH ('</' || l_parameter.p_param_name || '>'),
                '</' || l_parameter.p_param_name || '>');
        END LOOP;

        l_env :=
               g_xmlhead
            || '<soap:Envelope  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"  xmlns:xsd="http://www.w3.org/2001/XMLSchema" '
            || 'xmlns:oshb="http://oshb.currency.rates.ua" '
            || 'xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">';

        --- тело .  в универсальн || g_request.soap_method
        DBMS_LOB.append (l_env,
                         '<soap:Body><oshb:GetCurrencyRatesRequest>  ');

        DBMS_LOB.append (l_env, g_request.body);
        DBMS_LOB.append (
            l_env,
               '</oshb:GetCurrencyRatesRequest '
            || '></soap:Body></soap:Envelope>');

        g_request.body := l_env;
        ----- присваиваем out переменной подготовленный конверт
        po_request := l_env;

        -- определяем длину сообщения
        l_env_length := DBMS_LOB.getlength (l_env);

        -- SSL соединение выполняем через wallet
        IF (INSTR (LOWER (g_request.url), 'https://') > 0)
        THEN
            UTL_HTTP.set_wallet (g_request.wallet_path, g_request.wallet_pwd);
        END IF;

        ---------------- отправка
        BEGIN
            l_http_req :=
                UTL_HTTP.begin_request (g_request.url,
                                        g_request.http_method,
                                        bars.wsm_mgr.g_http_version);
        EXCEPTION
            WHEN UTL_HTTP.request_failed
            THEN
                raise_application_error (
                    -20001,
                       'Не запущено сервіс за адресою ['
                    || g_request.url
                    || ']'
                    || SQLERRM,
                    FALSE);
        END;

        -- header
        FOR i IN 1 .. g_request.headers.COUNT
        LOOP
            l_header := g_request.headers (i);
            UTL_HTTP.set_header (l_http_req,
                                 l_header.p_header_name,
                                 l_header.p_header_value);
        END LOOP;

        UTL_HTTP.set_header (
            l_http_req,
            'SOAPAction',
            g_request.namespace || '/' || g_request.soap_method);  ------ Ощад

        UTL_HTTP.set_header (
            l_http_req,
            'Content-Type',
            g_request.content_type || ';' || g_request.content_charset);

        ---- нет Ю 32кб
        IF (l_db_charset = 'AL32UTF8')
        THEN
            l_tmp :=
                UTL_RAW.cast_to_raw (
                    DBMS_LOB.SUBSTR (l_env, l_env_length, 1));
        ELSE
            l_tmp :=
                UTL_RAW.CONVERT (
                    UTL_RAW.cast_to_raw (
                        DBMS_LOB.SUBSTR (l_env, l_env_length, 1)),
                    'american_america.al32utf8',
                    'american_america.' || LOWER (l_db_charset));
        END IF;


        UTL_HTTP.set_transfer_timeout (g_transfer_timeout);

        UTL_HTTP.set_header (l_http_req,
                             'Content-Length',
                             UTL_RAW.LENGTH (l_tmp));

        UTL_HTTP.write_raw (l_http_req, l_tmp);



        l_http_resp := UTL_HTTP.get_response (l_http_req);

        -- читаем ответ
        DBMS_LOB.createtemporary (l_result, FALSE);

        DBMS_LOB.open (l_result, DBMS_LOB.lob_readwrite);

        BEGIN
            LOOP
                UTL_HTTP.read_text (l_http_resp, l_buffer);
                DBMS_LOB.writeappend (l_result, LENGTH (l_buffer), l_buffer);
            END LOOP;
        EXCEPTION
            WHEN UTL_HTTP.end_of_body
            THEN
                NULL;
        END;

        UTL_HTTP.end_response (l_http_resp);
        ----- заполняем out параметрі
        po_response := l_result;
        po_status_code := l_http_resp.status_code;
    EXCEPTION
        WHEN OTHERS
        THEN
            po_status_code := SQLCODE;
            po_response := DBMS_UTILITY.format_error_stack;
            RAISE;
    END;

    --------------------------------------------------------------------------------
    --------------------------------------------------------------------------------
    -- header_version - возвращает версию заголовка пакета
    --

    FUNCTION header_version
        RETURN VARCHAR2
    IS
    BEGIN
        RETURN    'Package header esb_sync '
               || gc_header_version
               || '.'
               || CHR (10)
               || 'AWK definition: '
               || CHR (10)
               || gc_awk_header_defs;
    END header_version;

    -- body_version - возвращает версию тела пакета
    --

    FUNCTION body_version
        RETURN VARCHAR2
    IS
    BEGIN
        RETURN    'Package body esb_sync '
               || gc_body_version
               || '.'
               || CHR (10)
               || 'AWK definition: '
               || CHR (10)
               || gc_awk_body_defs;
    END body_version;
BEGIN
    define_global_var;
END;
/



-- End of DDL Script for Package Body BARS.ESB_SYNC

