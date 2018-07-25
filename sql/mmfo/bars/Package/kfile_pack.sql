CREATE OR REPLACE PACKAGE "KFILE_PACK"
IS
    -- Author  : Alex.Iurchenko
    -- Created : 31.12.1899 23:59:59
    -- Purpose : package for work with k-files data(CA LEVEL)
    -- Версія пакету
    G_HEADER_VERSION   CONSTANT VARCHAR2 (64) := 'VERSION 1.00 04/12/2015';

    C_OB_CORPORATION_STATE CONSTANT VARCHAR2 (25 CHAR) := 'OB_CORPORATION_STATE';
    C_OB_STATE_ACTIVE      CONSTANT INT := 1;
    C_OB_STATE_LOCKED      CONSTANT INT := 2;
    C_OB_STATE_CLOSED      CONSTANT INT := 3;

    TYPE R_UNIT IS RECORD (ID OB_CORPORATION.EXTERNAL_ID%TYPE, NAME OB_CORPORATION.CORPORATION_NAME%TYPE);
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
  
    FUNCTION GET_C_OB_CORP_STATE RETURN VARCHAR2;
-----------------------------------------------------------kfile_sync
-- get next id in recieved data table
function get_last_id(p_last_id in decimal)  return decimal;

-- get next id in recieved data table (delete old data for corporation)
function get_sync_id(p_MFO in varchar2, p_CORP_ID in varchar2, p_SYNC_DATE in varchar2, p_d_type number default 1)  return number;
procedure set_last_corp (p_s date, p_corpc varchar2, p_kf varchar2, p_sess_id number);
-- fill data on date(p_date format DDMMYYYY)
procedure fill_data(p_date date, p_corp_code varchar2);

procedure SYNC_OB_CORP(
   p_ID                IN OB_CORPORATION.ID%TYPE,
   p_CORPORATION_CODE  IN OB_CORPORATION.CORPORATION_CODE%TYPE,
   p_CORPORATION_NAME  IN OB_CORPORATION.CORPORATION_NAME%TYPE,
   p_PARENT_ID         IN OB_CORPORATION.PARENT_ID%TYPE,
   p_STATE_ID          IN OB_CORPORATION.state_id%TYPE,
   p_EXTERNAL_ID       IN OB_CORPORATION.EXTERNAL_ID%TYPE);
-----------------------------------------------------------end kfile_sync
-----------------------------------------------------------p_lic26_kfile_mmfo
procedure lic26_kfile (p_s      date,           -- дата по
                         p_corpc  varchar2);

FUNCTION GET_ALL_UNITS(P_ACC ACCOUNTS.ACC%TYPE) RETURN T_UNITS PIPELINED;
-----------------------------------------------------------p_lic26_kfile_mmfo



    PROCEDURE ADD_CORP (P_CORPORATION_CODE  OB_CORPORATION.CORPORATION_CODE%TYPE,
                        P_CORPORATION_NAME  OB_CORPORATION.CORPORATION_NAME%TYPE,
                        P_PARENT_ID         OB_CORPORATION.PARENT_ID%TYPE DEFAULT NULL,
                        P_EXTERNAL_ID       OB_CORPORATION.EXTERNAL_ID%TYPE);

       PROCEDURE EDIT_CORP (P_ID               OB_CORPORATION.ID%TYPE,
                            P_CORPORATION_CODE OB_CORPORATION.CORPORATION_CODE%TYPE,
                            P_CORPORATION_NAME OB_CORPORATION.CORPORATION_NAME%TYPE,
                            P_EXTERNAL_ID      OB_CORPORATION.EXTERNAL_ID%TYPE,
                            P_PARENT_ID        OB_CORPORATION.EXTERNAL_ID%TYPE);

    PROCEDURE LOCK_CORP_ITEM(P_UNIT_ID OB_CORPORATION.ID%TYPE);

    PROCEDURE UNLOCK_CORP_ITEM(P_UNIT_ID OB_CORPORATION.ID%TYPE);

    PROCEDURE CLOSE_CORP_ITEM(P_UNIT_ID OB_CORPORATION.ID%TYPE);

  /*  FUNCTION KF_OST_SUM (P_CORP_ID      OB_CORPORATION_DATA.CORPORATION_ID%TYPE,
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
    RETURN MEASURE_TABLE_2 PIPELINED;*/

    FUNCTION GET_POSSIBLE_UNITS(P_ID_UNIT OB_CORPORATION.ID%TYPE) RETURN T_UNITS PIPELINED;
    --процедура обновления счетов корпоративных клиентов(обновляет включение в выписку, код ТРКК, код подразделения, дату открытия и альтернат. корпорацию)
    procedure UPDATE_ACC_CORP(p_acc      number, 
                              p_invp     varchar2, 
                              p_trkk     varchar2, 
                              p_sub_corp varchar2, 
                              p_alt_corp varchar2, 
                              p_daos     date);
    function get_mmfo_type return number;
    procedure ins_customerw (p_rnk customerw.rnk%type,p_external_id varchar2, p_org_id varchar2);
    function crt_dict_xml return clob;
    function pars_dict_xml(p_clob in clob) return clob;
    function crt_xml(p_sess_id in number, p_kf in varchar2) return clob;
    function pars_xml(p_clob in clob) return clob;
    procedure send_kfiles(p_id number, p_mmfo varchar2);
    
    procedure send_corp_dict;
    
    procedure send_dict_result(p_transp_id varchar2);
    
    procedure send_kfile_result(p_transp_id varchar2);
	
	procedure crt_txt_k_file(p_sess_id in number,
                          p_corp_id in number,
                          p_kf      in varchar2,
                          p_fname   in out varchar2,
                          p_k_file  out clob);
                        
    procedure crt_kfile(p_sess_id in number,
                     p_kf      in varchar2,
                     p_corp_id in number default null);
                          
    /*procedure ins_nbs_rep(p_corp_id number, p_nbs varchar2, p_rep_id number);
  
    procedure del_nbs_rep(p_id char);
 
    procedure upd_nbs_rep(p_id char, p_user_id number, p_corp_id number, p_nbs varchar2, p_rep_id number);*/
	
END KFILE_PACK;
/
CREATE OR REPLACE PACKAGE BODY BARS.KFILE_PACK
IS
    -- Версія пакету
    G_BODY_VERSION   CONSTANT VARCHAR2 (64) := 'VERSION 1.11 04/12/2017';
    G_DBGCODE        CONSTANT VARCHAR2 (20) := 'KFILE_PACK';
    ------------------------------------------------------------------------------------

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

--GET_C_OB_CORPORATION_STATE
    FUNCTION GET_C_OB_CORP_STATE RETURN VARCHAR2 IS
    BEGIN
        RETURN C_OB_CORPORATION_STATE;
    END;

    FUNCTION GET_CORP_STATE (P_ID OB_CORPORATION.ID%TYPE) return number IS
        l_STATE_ID number;
        begin
    SELECT STATE_ID into l_STATE_ID
    FROM OB_CORPORATION C
    WHERE C.ID = P_ID;
    return l_STATE_ID;
    exception when no_data_found then
        return null;
    END GET_CORP_STATE;

--get_web_params
    function get_param_webconfig(par varchar2) return web_barsconfig.val%type is
        l_res web_barsconfig.val%type;
      begin
        select val into l_res from web_barsconfig where key = par;
        return trim(l_res);
      exception
        when no_data_found then
          raise_application_error(-20000,
                                  'Не знайдено KEY=' || par ||
                                  ' в таблице web_barsconfig!');
      end;

 procedure crt_txt_k_file(p_sess_id in number,
                          p_corp_id in number,
                          p_kf      in varchar2,
                          p_fname   in out varchar2,
                          p_k_file  out clob) is
     l_clob clob;
     l_filename varchar2(50);
 begin
     DBMS_LOB.CREATETEMPORARY(l_clob, true);
     for j in (select ROWTYPE || '|' || lpadchr(kf, ' ', 9) || '|' ||
                      lpadchr(nls, ' ', 14) || '|' ||
                      lpadchr(nvl(kv, 0), ' ', 3) || '|' ||
                      lpadchr(okpo, ' ', 14) || '|' ||
                      lpadchr(nvl(obdb, 0), ' ', 14) || '|' ||
                      lpadchr(nvl(obdbq, 0), ' ', 14) || '|' ||
                      lpadchr(nvl(obkr, 0), ' ', 14) || '|' ||
                      lpadchr(nvl(obkrq, 0), ' ', 14) || '|' ||
                      lpadchr(nvl(ost, 0), ' ', 14) || '|' ||
                      lpadchr(nvl(ostq, 0), ' ', 14) || '|' ||
                      lpadchr(case when rowtype = 2 then 0 else kod_corp end, ' ', 20) || '|' ||
                      lpadchr(nvl(kod_ustan, 0), ' ', 20) || '|' ||
                      lpadchr(case when length(kod_analyt) = 1 then '0' || substr(kod_analyt, 1, 2) else substr(kod_analyt, 1, 2) end, ' ', 2) || '|' ||
                      lpadchr(to_char(dapp, 'YYMMDD'), ' ', 6) || '|' ||
                      rpadchr(case when rowtype = 2 then 'WINDOWS-1251' else null end, ' ', 60) || '|' ||
                      lpadchr(to_char(postdat, 'YYMMDD'), ' ', 6) || '|' ||
                      lpadchr(to_char(docdat, 'YYMMDD'), ' ', 6) || '|' ||
                      lpadchr(to_char(valdat, 'YYMMDD'), ' ', 6) || '|' ||
                      rpadchr(nd, ' ', 10) || '|' ||
                      lpadchr(nvl(substr(to_char(vob), 1, 2), 0), ' ', 2) || '|' ||
                      lpadchr(nvl(dk, 0), ' ', 1) || '|' ||
                      lpadchr(mfoa, ' ', 9) || '|' ||
                      rpadchr(case when rowtype = 2 then '0' else to_char(nlsa) end, ' ', 14) || '|' || rpadchr(nvl(kva, 0), ' ', 3) || '|' ||
                      rpadchr(substr(nama, 1, 38), ' ', 38) || '|' ||
                      rpadchr(substr(okpoa, 1, 38), ' ', 14) || '|' ||
                      lpadchr(mfob, ' ', 9) || '|' || rpadchr(nlsb, ' ', 14) || '|' ||
                      rpadchr(nvl(kvb, 0), ' ', 3) || '|' ||
                      rpadchr(substr(namb, 1, 38), ' ', 38) || '|' ||
                      rpadchr(substr(okpob, 1, 38), ' ', 14) || '|' ||
                      lpadchr(nvl(s, 0), ' ', 16) || '|' ||
                      rpadchr(nvl(dockv, 0), ' ', 3) || '|' ||
                      lpadchr(nvl(sq, 0), ' ', 16) || '|' ||
                      rpadchr(substr(nazn, 1, 160), ' ', 160) || '|' ||
                      lpadchr(nvl(doctype, 0), ' ', 1) || '|' ||
                      lpadchr(to_char(posttime, 'HHMM'), ' ', 4) || '|' ||
                      rpadchr(substr(namk, 1, 60), ' ', 60) || '|' ||
                      rpadchr(substr(nms, 1, 60), ' ', 60) || '|' ||
                      rpadchr(tt, ' ', 3) || '|' as k_file_str
                 from V_OB_CORP_REPORT
                where kf = p_kf
                  and corporation_id = p_corp_id
                  and session_id = p_sess_id) loop
         DBMS_LOB.WRITEAPPEND(l_clob, length(j.k_file_str) + 2, j.k_file_str || chr(13) || chr(10));
     end loop;
        select 'K'||substr(k.kod_s||substr( getchr(substr(to_char(T1.FILE_DATE,'DD/MM/YYYY'),-2,2))||
                                            getchr(substr(to_char(T1.FILE_DATE,'DD/MM/YYYY'),4,2))||
                                            getchr(substr(to_char(T1.FILE_DATE,'DD/MM/YYYY'),1,2))|| '.'||
                                            lpadchr(p_corp_id,'0',2)||'1', 1,8),1,50) as filename
                                            into l_filename
       FROM BARS.ob_corp_sess t1
       left join bars.clim_mfo k on k.kf = t1.kf
       where t1.id = p_sess_id
         and t1.kf = p_kf;

     p_fname:= l_filename;
     p_k_file:= l_clob;
 end;

 procedure crt_kfile(p_sess_id in number,
                     p_kf      in varchar2,
                     p_corp_id in number default null) is

  l_url         params$global.val%type :=  getglobaloption('ABSBARS_WEBSERVER_PROTOCOL')||'://'||getglobaloption('ABSBARS_WEBSERVER_IP_ADRESS')||'/barsroot/api/kfile/CrtKfile';
  l_f_path      varchar2(255) :=branch_attribute_utl.get_value('TMS_REPORTS_DIR');
  l_wallet_path varchar2(256) := getglobaloption('PATH_FOR_ABSBARS_WALLET');
  l_wallet_pwd  varchar2(256) := getglobaloption('PASS_FOR_ABSBARS_WALLET');
  l_response    wsm_mgr.t_response;
  l_id varchar2(36);
  begin

  for i in (select corp_id
              from ob_corp_sess_corp c
             where c.kf = p_kf
               and c.sess_id = p_sess_id
               and c.is_last = 1
               and case when p_corp_id is null then -1 else c.corp_id end = case when p_corp_id is null then -1 else p_corp_id end)
           loop

             wsm_mgr.prepare_request(p_url         => l_url,
                          p_action      => null,
                          p_http_method => wsm_mgr.g_http_get,
                          p_wallet_path => l_wallet_path,
                          p_wallet_pwd  => l_wallet_pwd,
                          p_body        => null);
             WSM_MGR.ADD_HEADER('sess_id', to_char(p_sess_id));
             WSM_MGR.ADD_HEADER('corp_id', to_char(i.corp_id));
             WSM_MGR.ADD_HEADER('kf', p_kf);
             WSM_MGR.ADD_HEADER('path', l_f_path);
             -- позвать метод веб-сервиса
             wsm_mgr.execute_api(l_response);
           end loop;
  end;

 /*procedure ins_nbs_rep(p_corp_id number, p_nbs varchar2, p_rep_id number) is

 begin
 insert into ob_corp_nbs_rep(id, corp_id, nbs, rep_id) values (sys_guid(), p_corp_id, p_nbs, p_rep_id);
 end;

 procedure del_nbs_rep(p_id char) is

 begin
 delete ob_corp_nbs_rep where id = p_id;
 end;

 procedure upd_nbs_rep(p_id char, p_user_id number, p_corp_id number, p_nbs varchar2, p_rep_id number) is

 begin
 update ob_corp_nbs_rep r
    set corp_id = p_corp_id,
        nbs     = p_nbs,
        rep_id  = p_rep_id
 where id = p_id;
 end;*/


    procedure loger(p_module varchar2,
                    p_sess_id number,
                    p_err clob,
                    p_state number default 1,
                    p_clob clob default null,
                    p_blob blob default null) is
        pragma autonomous_transaction;
        log_id number;
    begin
            update bars.ob_corp_sess q
                set q.state_id = p_state
            where q.id = p_sess_id;

        log_id:=S_OB_CORP_SESS_TRACK.NEXTVAL;
        insert into bars.ob_corp_sess_track(ID, SESS_ID, ERR_SOURCE, STATE_ID, ERR_REP, ERR_ZIP, ERR_XML, SYS_TIME)
        values (log_id, p_sess_id, p_module, p_state, p_err, p_blob, p_clob, sysdate);
     commit;
    end;
--xpath_extract
    function extract(p_xml       in xmltype,
                     p_xpath     in varchar2,
                     p_mandatory in number) return clob is
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


-----------------------------------------------------------------------------------
    function get_last_id(p_last_id in decimal) return decimal is
      l_last_id decimal;
    begin
      select max(t1.id)
        into l_last_id
        from bars.attribute_history t1,
             bars.object_type       t2,
             bars.attribute_kind    t3,
             bars.ob_corporation    t4
       where t1.attribute_id = t3.id
         and t3.object_type_id = t2.id
         and t2.type_code = 'CORPORATIONS'
         and t4.id = t1.object_id
         and t1.id > p_last_id;
      if (l_last_id is null) then
        select max(t1.id)
          into l_last_id
          from bars.attribute_history t1,
               bars.object_type       t2,
               bars.attribute_kind    t3,
               bars.ob_corporation    t4
         where t1.attribute_id = t3.id
           and t3.object_type_id = t2.id
           and t2.type_code = 'CORPORATIONS'
           and t4.id = t1.object_id;
      end if;
      return l_last_id;
    end;

---------------------------------------------------------------------------------------
    function get_sync_id(P_MFO in varchar2, P_CORP_ID in varchar2, P_SYNC_DATE in varchar2, p_d_type number default 1)
      return number
      is
      pragma autonomous_transaction;
      l_sync_id decimal;
      begin
       l_sync_id:=S_OB_CORPORATION_SESSION.nextval;
      insert into BARS.OB_CORP_SESS ( id, KF, FILE_DATE, state_id, sys_time, d_type)
      values(l_sync_id, p_MFO , to_date(p_SYNC_DATE,'DDMMYYYY'), 0, sysdate, p_d_type);
        if (P_CORP_ID is null and p_d_type = 1) then
            FOR I IN (SELECT TO_NUMBER(A.EXTERNAL_ID) AS C_ID FROM OB_CORPORATION A WHERE A.PARENT_ID IS NULL) LOOP
                INSERT INTO OB_CORP_SESS_CORP(SESS_ID, KF, CORP_ID,IS_LAST) VALUES(l_sync_id, P_MFO, I.C_ID,1);
            END LOOP;
        ELSIF p_d_type = 1 then
        INSERT INTO OB_CORP_SESS_CORP(SESS_ID, KF, CORP_ID,IS_LAST) VALUES (l_sync_id, P_MFO, to_number(P_CORP_ID),1);
        END IF;
      commit;
      return l_sync_id;
    end ;
------------------------------------------------------------------------------------------------
    procedure set_last_corp (p_s date, p_corpc varchar2, p_kf varchar2, p_sess_id number) is
    begin
         if (p_corpc='%') then
                update OB_CORP_SESS_CORP q
                set q.is_last = 0
                where q.kf = p_kf
                and q.sess_id<>p_sess_id
                and q.sess_id in (select id from OB_CORP_SESS A WHERE a.FILE_DATE = p_s);

				update OB_CORP_DATA_ACC q
                set q.is_last = 0
                where q.kf = p_kf
                and q.sess_id<>p_sess_id
                and q.FDAT = p_s;
        ELSE
                update OB_CORP_SESS_CORP q
                set q.is_last = 0
                where q.sess_id in (select id from OB_CORP_SESS A
                                    JOIN OB_CORP_SESS_CORP B ON A.ID = B.SESS_ID and a.kf = b.kf
                                    WHERE A.kf = p_kf
                                    and a.id<>p_sess_id
                                    AND a.FILE_DATE = p_s and B.CORP_ID = to_nume(p_corpc));

			    update OB_CORP_DATA_ACC q
                set q.is_last = 0
				where q.kf = p_kf
                and q.sess_id<>p_sess_id
                and q.FDAT = p_s
				and q.CORP_ID = to_nume(p_corpc);
        END IF;
    end;
-----------------------------------------------------------------------------------------
    procedure fill_data(p_date date, p_corp_code varchar2) is
      l_jobname varchar2(64) := 'K_FILES_CREATE_FOR'||f_ourmfo;
      l_action varchar2(2000) :=
    'begin
        bars_login.login_user(sys_guid, 1, null, null);
        bc.go('''||f_ourmfo||''');
        kfile_pack.LIC26_KFILE(to_date('''||to_char(p_date, 'dd.mm.yyyy')||''',''dd.mm.yyyy'')'||
                               case when p_corp_code is null then ', null' else ', '||p_corp_code end||');
        commit;
        bms.send_message(p_receiver_id     => '||user_id||',
         p_message_type_id => 1,
         p_message_text    => ''К-Файл сформовано '||case when p_corp_code is null then 'для всіх корпорацій' else 'для '||
                                p_corp_code||' корпорації' end||', МФО: '||f_ourmfo||' на дату: '||to_char(p_date, 'dd.mm.yyyy')||''',
         p_delay           => 0,
         p_expiration      => 0);
     exception
         when others then
                 bms.send_message(p_receiver_id     => '||user_id||',
                 p_message_type_id => 1,
                 p_message_text    => ''Помилка формування К-Файлу '||case when p_corp_code is null then 'для всіх корпорацій' else 'для '||
                                        p_corp_code||' корпорації' end||', МФО: '||f_ourmfo||' на дату: '||to_char(p_date, 'dd.mm.yyyy')||''',
                 p_delay           => 0,
                 p_expiration      => 0);
     end;';
    begin
    if SYS_CONTEXT ('bars_context', 'user_mfo') is null then
    raise_application_error(-20000, 'Формування К-файлів на рівні "/" заборонено!!');
    end if;

    dbms_scheduler.create_job(job_name => l_jobname,
                              job_type => 'PLSQL_BLOCK',
                              job_action => l_action,
                              auto_drop => true,
                              enabled => true);
exception
    when others then
        -- в любом случае срубаем джоб
        dbms_scheduler.drop_job(l_jobname, force => true);
        raise;
    end;

---------------------------------------------------------end kfile_sync;

---------------------------------------------------------p_lic26_kfile_mmfo

PROCEDURE lic26_kfile
             (p_s        date,           -- дата по
              p_corpc    varchar2 )      -- код корпорации
is
type lt_data_acc is table of OB_CORP_DATA_ACC%rowtype;
l_data_acc lt_data_acc:=lt_data_acc();

type lt_data_doc is table of OB_CORP_DATA_DOC%rowtype;
l_data_doc lt_data_doc:=lt_data_doc();


   l_nb       varchar2(38);
   l_ostqp    number;
   l_ostq     number;
   l_sq       number;
   l_s        number;
   l_psum     number;
   l_lcv      char(3);


   l_sumdbq   number;  -- общая сумма дебет  в эквиваленте по всем платежам ждя данного счета
   l_sumkrq   number;  -- общая сумма кредит в эквиваленте по всем платежам ждя данного счета
   l_postdat  date;

   l_sync     number;

   l_mfo_d  varchar2(6);
   l_nls_d  varchar2(14);
   l_kv_d   number;
   l_nam_d  varchar2(70);
   l_okpo_d varchar2(16);


   l_whoiam  number;   -- 0-плательщик, 1- получатель
procedure l_ins_data_acc(p_data_acc lt_data_acc) is
begin
forall j in p_data_acc.first .. p_data_acc.last
      insert into ob_corp_data_acc values p_data_acc(j);
end;
procedure l_ins_data_doc(p_data_doc lt_data_doc) is
begin
    forall j in p_data_doc.first .. p_data_doc.last
      insert into ob_corp_data_doc values p_data_doc(j);
end;

begin

   bars_audit.trace('p_lic26_kfile: формирование К файла за: ' ||to_char(p_s,'dd/mm/yyyy') ||' маска корпорации: '||p_corpc);



        l_sync := get_sync_id(f_ourmfo, p_corpc, to_char(p_s,'DDMMYYYY'));

   -----------------------------
   -- по счетам
   -----------------------------
   for c0 in (select case when dapp is not null then acc else null end as sal_acc,
               acc, fdat, ost, nls, kv, kos, dos, nms, dapp, okpo, nmkk nmk,
               (ost+dos-kos) ostf, rnk, typnls, nvl(alt_corp_cod,corp_kod) kodk, kodu, pos
               from(
                    select a.acc, trunc(p_s) fdat, a.nls, a.kv, nvl(s.kos,0) as kos,
                           nvl(s.dos,0) as dos, a.nms nms, c.okpo, c.nmkk, a.rnk,
                           coalesce(s.pdat,(select max(fdat)
                                                   from saldoa s
                                                   where s.fdat  <= trunc(p_s)
                                                   and s.acc = a.acc)) as dapp,
                           nvl((select ost from (SELECT s.acc, s.fdat,
                                                        nvl(s.ostf,0) - nvl(s.dos,0) + nvl(s.kos,0) as OST,
                                                        max(s.fdat) over (partition by s.acc) as m_fdat
                                                        FROM saldoa s where s.fdat  <= trunc(p_s)) q
                                                        where m_fdat = fdat and q.acc = a.acc),0) as ost,
                     (SELECT s.TYPNLS
                      FROM SPECPARAM_INT s
                      WHERE a.ACC = s.ACC) typnls, cw.value as corp_kod,
                     (SELECT w3.VALUE
                      FROM accountsw w3
                      WHERE a.ACC = w3.ACC
                      AND w3.TAG = 'OBCORPCD') as kodu,
                      a.pos,
                     (SELECT w1.VALUE
                      FROM accountsw w1
                      WHERE a.ACC = w1.ACC
                      AND w1.TAG = 'OBCORP'
                      AND exists(select 1
                                 from ob_corporation obc
                                 where obc.external_id = w1.value
                                 and obc.parent_id is null)) AS alt_corp_cod
    from accounts a
    join accountsw aw on a.acc = aw.acc
    join customerw cw on a.rnk = cw.rnk
    join customer c on a.rnk = c.rnk
    left join saldoa s on s.acc = a.acc and s.fdat = trunc(p_s)
    where aw.TAG = 'CORPV' and aw.value = 'Y'
    and cw.TAG = 'OBPCP'
    and exists(select 1
               from ob_corporation obc
               where obc.external_id = cw.value
               and obc.parent_id is null)
    and (a.dazs >= trunc(p_s) or a.dazs is null))
    where decode(p_corpc,null, nvl(alt_corp_cod,corp_kod), p_corpc) = nvl(alt_corp_cod,corp_kod))
            loop


      bars_audit.trace('p_lic26_kfile: за число : ' ||to_char(c0.fdat,'dd/mm/yyyy') ||' счет '||c0.nls||'-'||c0.kv);
      bars_audit.trace('p_lic26_kfile: за число : ' ||to_char(c0.fdat,'dd/mm/yyyy') ||' счет '||c0.nls||'-'||c0.kv);


      l_sumdbq := 0;
      l_sumkrq := 0;

      l_ostq   := case  c0.kv  when  gl.baseval  then c0.ost else 0 end;

      ----------------
      -- по проводкам
      ----------------
      for c1 in (select ref,tt, s * decode(dk,0,-1,1) s,txt, dk, stmt, f_ourmfo kf
                  from opldok where acc=c0.acc and fdat=c0.fdat and sos=5)
         loop

         -----------------------------
         -- по документам
         -----------------------------
         for c2 in (select o.vob,
                           replace(o.nd, '|', '/') nd,
                           o.dk, o.mfoa, o.nlsa, o.nam_a, o.id_a,
                           o.mfob, o.nlsb,    o.nam_b, o.id_b,
                           o.ref, o.kv2,
                           case when o.tt = c1.tt or o.tt = 'R00' or o.tt = 'R01' or o.tt = 'ЭНД' or o.tt='ЭНК' then o.nazn
                           else t.name end nazn,
                           o.userid, o.sk, o.kv, o.d_rec, o.datd, o.pdat, o.vdat, o.datp,
                           to_char(pdat,'hh24mi') dtime,
                           o.tt
                    from oper o, tts t
                    where o.ref=c1.ref and c1.tt=t.tt )
         loop
            -----------------суми-------
               l_sq :=0;
               l_s  :=   sign(c1.s) * c1.s;

               if c0.kv <> gl.baseval then
               l_sq:= gl.p_icurval(c0.kv, l_s, c0.fdat);
               if c1.dk = 1 then
                  l_sumkrq := l_sumkrq +  l_sq;
               else
                  l_sumdbq := l_sumdbq +  l_sq;
               end if;
           else
               l_sq:= l_s;
               if c1.dk = 1 then
                  l_sumkrq := l_sumkrq +  l_s;
               else
                  l_sumdbq := l_sumdbq +  l_s;
               end if;
               end if;
            -----------------суми-------
                l_data_doc.extend;
                l_data_doc(l_data_doc.last).sess_id:= l_sync;
                l_data_doc(l_data_doc.last).acc:= c0.acc;
                l_data_doc(l_data_doc.last).kf:= gl.amfo;
                l_data_doc(l_data_doc.last).ref:= c1.ref;
                l_data_doc(l_data_doc.last).docdat :=c2.datd;
                l_data_doc(l_data_doc.last).valdat :=c2.vdat;
                l_data_doc(l_data_doc.last).nd:= trim(c2.nd);
                l_data_doc(l_data_doc.last).vob :=c2.vob;
                l_data_doc(l_data_doc.last).dk :=c1.dk;
                l_data_doc(l_data_doc.last).s:= l_s;
                l_data_doc(l_data_doc.last).dockv :=c0.kv;
                l_data_doc(l_data_doc.last).sq :=l_sq;
                l_data_doc(l_data_doc.last).nazn:= replace(c2.nazn,'|',' ');
                l_data_doc(l_data_doc.last).tt :=c1.tt;

                begin
                  -- исключаем технологические визы
                  select dat into l_postdat
                    from oper_visa
                   where status = 2 and ref = c1.ref and groupid not in (77,80,81,30,94,130);
               exception when no_data_found then
                  l_postdat := to_date(to_char(c0.fdat,'ddmmyyyy')||to_char(c2.pdat,'hh24miss'),'ddmmyyyyhh24miss');
               end;
                  l_data_doc(l_data_doc.last).postdat:= l_postdat;


-- если счет присутсвует в документе, тогда реквизиты брать из документа
               case when c0.nls = c2.nlsa then
                        l_mfo_d  := c1.kf;
                        l_nls_d  := c2.nlsa;
                        l_kv_d   := c0.kv;
                        l_nam_d  := c2.nam_a;
                        l_okpo_d := c2.id_a;
                    when c0.nls = c2.nlsb then
                        l_mfo_d  := c1.kf;
                        l_nls_d  := c2.nlsb;
                        l_kv_d   := c0.kv;
                        l_nam_d  := c2.nam_b;
                        l_okpo_d := c2.id_b;
-- иначе, реквизиты счета и клиента
                    else
                        l_mfo_d  := c1.kf;
                        l_nls_d  := c0.nls;
                        l_kv_d   := c0.kv;
                        l_nam_d  := c0.nms;
                        l_okpo_d := c0.okpo;
               end case;



            if c1.dk = 0 then
               l_whoiam := 0;
                        l_data_doc(l_data_doc.last).mfoa  := l_mfo_d;
                        l_data_doc(l_data_doc.last).nlsa  := l_nls_d;
                        l_data_doc(l_data_doc.last).kva   := l_kv_d;
                        l_data_doc(l_data_doc.last).nama  := replace(l_nam_d, '|',' ');
                        l_data_doc(l_data_doc.last).okpoa := l_okpo_d;

            else
               l_whoiam := 1;
                        l_data_doc(l_data_doc.last).mfob  := l_mfo_d;
                        l_data_doc(l_data_doc.last).nlsb  := l_nls_d;
                        l_data_doc(l_data_doc.last).kvb   := l_kv_d;
                        l_data_doc(l_data_doc.last).namb  := replace(l_nam_d, '|',' ');
                        l_data_doc(l_data_doc.last).okpob := l_okpo_d;
            end if;

            -- найдем контр агента по OPLDOK
            if (c2.tt<>c1.tt) or (c2.nlsa<>c0.nls and c2.nlsb<>c0.nls ) then
               l_mfo_d  := c1.kf;
               -- найти вторую сторону по opldok
               select nls, kv, okpo, nmk
                 into l_nls_d, l_kv_d, l_okpo_d, l_nam_d
                 from accounts a, customer c
                where a.rnk = c.rnk
                  and acc = (select acc
                               from opldok
                              where ref = c1.ref and stmt = c1.stmt and dk<> c1.dk);

                  if l_whoiam = 0 then
                            l_data_doc(l_data_doc.last).mfob  := l_mfo_d;
                            l_data_doc(l_data_doc.last).nlsb  := l_nls_d;
                            l_data_doc(l_data_doc.last).kvb   := l_kv_d;
                            l_data_doc(l_data_doc.last).namb  := replace(l_nam_d, '|',' ');
                            l_data_doc(l_data_doc.last).okpob := l_okpo_d;
                  else
                            l_data_doc(l_data_doc.last).mfoa  := l_mfo_d;
                            l_data_doc(l_data_doc.last).nlsa  := l_nls_d;
                            l_data_doc(l_data_doc.last).kva   := l_kv_d;
                            l_data_doc(l_data_doc.last).nama  := replace(l_nam_d, '|',' ');
                            l_data_doc(l_data_doc.last).okpoa := l_okpo_d;
                  end if;

            else
                  if l_whoiam = 0 then   -- мы плательщики
                    if c2.dk = 1 then
                        l_data_doc(l_data_doc.last).mfob  := c2.mfob;
                        l_data_doc(l_data_doc.last).nlsb  := c2.nlsb;
                        l_data_doc(l_data_doc.last).kvb   := c2.kv2;
                        l_data_doc(l_data_doc.last).namb  := replace(c2.nam_b, '|',' ');
                        l_data_doc(l_data_doc.last).okpob := c2.id_b;
                    else
                        l_data_doc(l_data_doc.last).mfob  := c2.mfoa;
                        l_data_doc(l_data_doc.last).nlsb  := c2.nlsa;
                        l_data_doc(l_data_doc.last).kvb   := c2.kv;
                        l_data_doc(l_data_doc.last).namb  := replace(c2.nam_a, '|',' ');
                        l_data_doc(l_data_doc.last).okpob := c2.id_a;
                    end if;

                  else                   -- мы получатели
                    if c2.dk = 1 then
                        l_data_doc(l_data_doc.last).mfoa  := c2.mfoa;
                        l_data_doc(l_data_doc.last).nlsa  := c2.nlsa;
                        l_data_doc(l_data_doc.last).kva   := c2.kv;
                        l_data_doc(l_data_doc.last).nama  := replace(c2.nam_a, '|',' ');
                        l_data_doc(l_data_doc.last).okpoa := c2.id_a;
                    else
                        l_data_doc(l_data_doc.last).mfoa  := c2.mfob;
                        l_data_doc(l_data_doc.last).nlsa  := c2.nlsb;
                        l_data_doc(l_data_doc.last).kva   := c2.kv2;
                        l_data_doc(l_data_doc.last).nama  := replace(c2.nam_b, '|',' ');
                        l_data_doc(l_data_doc.last).okpoa := c2.id_b;
                    end if;
               end if;
            end if;
          end loop; -- oper
         end loop; -- opldok



      -- для валютного счета, если вообще было движение и он требует переоценку
      if c0.kv <> gl.baseval and c0.sal_acc is not null and (c0.pos <> 2 or c0.pos is null)  then

        -- найдем исходящий остаток в эквиваленте на отчетную дату
        l_ostq  := gl.p_icurval(c0.kv,c0.ost, c0.fdat);
            /* нужно подсчитать переоценку и сформировать псевдоплатеж (это только если входящий остаток <>0)
               а также сформировать псевдо платеж если сумма еквивалентов док-тов <> еквиваленту оборотов по счету.
               найдем исходящий остаток в эквиваленте на предидущий день движения*/

           l_ostqp:= fostq(c0.acc,dat_next_u(c0.fdat,-1));

           l_psum  := l_ostq - l_ostqp + l_sumdbq - l_sumkrq;

         -- формируем корректирующий платеж
         if l_psum <> 0 then
            begin
               select substr(val,1,38) into l_nb from params where par = 'NAME';
            exception when no_data_found then
               l_nb := 'our bank name' ;
            end;

            bars_audit.trace('требуется платеж переоценки');

            -- курс увеличился
               l_data_doc.extend;
               l_data_doc(l_data_doc.last).sess_id:= l_sync;
               l_data_doc(l_data_doc.last).acc:= c0.acc;
                l_data_doc(l_data_doc.last).kf:= gl.amfo;
               l_data_doc(l_data_doc.last).ref:= '0';
            if (l_psum > 0 ) then
               l_data_doc(l_data_doc.last).nlsa := '3801';
               l_data_doc(l_data_doc.last).nlsb := c0.nls;
               l_data_doc(l_data_doc.last).nama := l_nb;
               l_data_doc(l_data_doc.last).namb := c0.nmk;
               l_data_doc(l_data_doc.last).okpoa:= gl.aokpo;
               l_data_doc(l_data_doc.last).okpob:= c0.okpo;
               l_sumkrq := l_sumkrq + l_psum;
            else
               l_data_doc(l_data_doc.last).nlsb := '3801';
               l_data_doc(l_data_doc.last).nlsa := c0.nls;
               l_data_doc(l_data_doc.last).namb := l_nb;
               l_data_doc(l_data_doc.last).nama := c0.nmk;
               l_data_doc(l_data_doc.last).okpob:= gl.aokpo;
               l_data_doc(l_data_doc.last).okpoa:= c0.okpo;
               l_sumdbq := l_sumdbq + (-1)* l_psum;
            end if;

            -- псевдо-платеж в связи с переоценкой
            if  l_ostqp <> 0 then
                -- для назначения платежа вытянем курсы
                select lcv into l_lcv
                from tabval  where kv = c0.kv;
                l_data_doc(l_data_doc.last).nazn := 'Переоцiнка залишку по '||l_lcv||'. ';
            else
                l_data_doc(l_data_doc.last).nazn := 'Коригування при обчисленнi еквiваленту';
            end if;
                l_data_doc(l_data_doc.last).postdat:=p_s;
                l_data_doc(l_data_doc.last).docdat :=p_s;
                l_data_doc(l_data_doc.last).valdat :=p_s;
                l_data_doc(l_data_doc.last).nd     :=to_char(sysdate,'hh24miss');
                l_data_doc(l_data_doc.last).vob    :=6;
                l_data_doc(l_data_doc.last).mfoa   :=gl.amfo;
                l_data_doc(l_data_doc.last).kva    :=c0.kv;
                l_data_doc(l_data_doc.last).mfob   :=gl.amfo;
                l_data_doc(l_data_doc.last).kvb    :=c0.kv;
                l_data_doc(l_data_doc.last).s      :=0;
                l_data_doc(l_data_doc.last).sq     :=sign(l_psum)*l_psum;
                l_data_doc(l_data_doc.last).dockv  :=c0.kv;
                l_data_doc(l_data_doc.last).dk:=(case when l_psum > 0 then 1 else 0 end);
                l_data_doc(l_data_doc.last).tt     :='PRC';

         end if;  -- l_psum <> 0

      end if;  -- c0.kv <> gl.baseval and c0.sal_acc is not null
      --
      -- искусственно сделаем груповую строку по счету (тип строки = 0)
      --
                l_data_acc.extend;
                l_data_acc(l_data_acc.last).sess_id   := l_sync;
                l_data_acc(l_data_acc.last).acc       := c0.acc;
                l_data_acc(l_data_acc.last).kf        := gl.amfo;
                l_data_acc(l_data_acc.last).fdat      := p_s;
                l_data_acc(l_data_acc.last).corp_id   := c0.kodk;
                l_data_acc(l_data_acc.last).nls       := c0.nls;
                l_data_acc(l_data_acc.last).kv        := c0.kv;
                l_data_acc(l_data_acc.last).okpo      := c0.okpo;
                l_data_acc(l_data_acc.last).obdb      := c0.dos;
                l_data_acc(l_data_acc.last).obdbq     := l_sumdbq;
                l_data_acc(l_data_acc.last).obkr      := c0.kos;
                l_data_acc(l_data_acc.last).obkrq     := l_sumkrq;
                l_data_acc(l_data_acc.last).ost       := c0.ost;
                l_data_acc(l_data_acc.last).ostq      := l_ostq;
                l_data_acc(l_data_acc.last).kod_ustan := c0.kodu;
                l_data_acc(l_data_acc.last).kod_analyt:= lpad(c0.typnls,2,'0');
                l_data_acc(l_data_acc.last).dapp      := c0.dapp;
                l_data_acc(l_data_acc.last).postdat   :=c0.fdat;
                l_data_acc(l_data_acc.last).namk      :=replace(c0.nmk,'|',' ');
                l_data_acc(l_data_acc.last).nms       :=replace(c0.nms,'|',' ');
				l_data_acc(l_data_acc.last).is_last   :=1;


    if l_data_doc.last >= 1000 then
        l_ins_data_acc(l_data_acc);
    l_data_acc.delete;
        l_ins_data_doc(l_data_doc);
    l_data_doc.delete;
    end if;

       end loop; -- accounts

        l_ins_data_acc(l_data_acc);
    l_data_acc.delete;
        l_ins_data_doc(l_data_doc);
    l_data_doc.delete;

        update BARS.OB_CORP_SESS s
       set s.state_id = 1
    where s.id = l_sync;

exception when others then
    update BARS.OB_CORP_SESS s
       set s.state_id = 3
    where s.id = l_sync;
END lic26_kfile;


FUNCTION GET_ALL_UNITS(P_ACC ACCOUNTS.ACC%TYPE) RETURN T_UNITS PIPELINED IS
        ------------------------------------------------------------------------------------
       CURSOR POSIBLE_UNITS (P_ROOT OB_CORPORATION.ID%TYPE) IS
            SELECT T.ID, T.CORPORATION_NAME
            FROM OB_CORPORATION T
            WHERE T.STATE_ID <> C_OB_STATE_CLOSED
            START WITH ID = P_ROOT
            CONNECT BY PRIOR ID = PARENT_ID;
        L_UNIT R_UNIT;
        L_ROOT OB_CORPORATION.ID%TYPE;
        L_UNITS T_UNITS;
        L_CORP_EXT_ID VARCHAR(2);
        ------------------------------------------------------------------------------------
    BEGIN
        SELECT C.VALUE INTO L_CORP_EXT_ID
        FROM CUSTOMERW C
        JOIN ACCOUNTS A ON A.RNK = C.RNK
        WHERE c.tag = 'OBPCP'
        and A.ACC = P_ACC;

        SELECT MAX(ID) KEEP (DENSE_RANK LAST ORDER BY LEVEL) INTO L_ROOT
        FROM OB_CORPORATION T
        START WITH ID = L_CORP_EXT_ID
        CONNECT BY ID = PRIOR PARENT_ID;

        OPEN POSIBLE_UNITS(L_ROOT);
        FETCH POSIBLE_UNITS BULK COLLECT INTO L_UNITS;
        CLOSE POSIBLE_UNITS;

        IF NVL(L_UNITS.COUNT,0) <> 0 THEN
            FOR I IN L_UNITS.FIRST .. L_UNITS.LAST LOOP
                L_UNIT.ID := L_UNITS(I).ID;
                L_UNIT.NAME := L_UNITS(I).NAME;
                PIPE ROW(L_UNIT);
            END LOOP;
        END IF;
    END;

---------------------------------------------------------end p_lic26_kfile_mmfo

---------------------------------------------------------kfile_pack
---------------------------------------------------------kfile_sync
--Синхронизація довідника OB_CORPORATION
    procedure SYNC_OB_CORP(
       P_ID                 IN OB_CORPORATION.ID%TYPE,
       P_CORPORATION_CODE   IN OB_CORPORATION.CORPORATION_CODE%TYPE,
       P_CORPORATION_NAME   IN OB_CORPORATION.CORPORATION_NAME%TYPE,
       P_PARENT_ID          IN OB_CORPORATION.PARENT_ID%TYPE,
       P_STATE_ID           IN OB_CORPORATION.STATE_ID%TYPE,
       P_EXTERNAL_ID        IN OB_CORPORATION.EXTERNAL_ID%TYPE)
    IS
       l_corp_row    OB_CORPORATION%ROWTYPE;
    BEGIN
       BEGIN
          SELECT t1.*
            INTO l_corp_row
            FROM OB_CORPORATION t1
           WHERE T1.ID = p_ID;
       EXCEPTION
          WHEN NO_DATA_FOUND
          THEN
             --select S_OB_CORPORATION.nextval into l_corp_id from dual;
             INSERT INTO BARS.OB_CORPORATION t1 (T1.ID)
                  VALUES (p_ID)
               RETURNING id
                    INTO l_corp_row.id;
       END;

       --DBMS_OUTPUT.PUT_LINE (l_corp_row.CORP_NAME);

       IF (   p_CORPORATION_NAME <> l_corp_row.CORPORATION_NAME
           OR (    p_CORPORATION_NAME IS NULL
               AND l_corp_row.CORPORATION_NAME IS NOT NULL)
           OR (    p_CORPORATION_NAME IS NOT NULL
               AND l_corp_row.CORPORATION_NAME IS NULL))
       THEN
          BARS.ATTRIBUTE_UTL.SET_VALUE (l_corp_row.id,
                                        'CORPORATION_NAME',
                                        p_CORPORATION_NAME);
       END IF;

       IF (   p_CORPORATION_CODE <> l_corp_row.CORPORATION_CODE
           OR (    p_CORPORATION_CODE IS NULL
               AND l_corp_row.CORPORATION_CODE IS NOT NULL)
           OR (    p_CORPORATION_CODE IS NOT NULL
               AND l_corp_row.CORPORATION_CODE IS NULL))
       THEN
          BARS.ATTRIBUTE_UTL.SET_VALUE (l_corp_row.id,
                                        'CORPORATION_CODE',
                                        p_CORPORATION_CODE);
       END IF;

       IF (   p_PARENT_ID <> l_corp_row.PARENT_ID
           OR (p_PARENT_ID IS NULL AND l_corp_row.PARENT_ID IS NOT NULL)
           OR (p_PARENT_ID IS NOT NULL AND l_corp_row.PARENT_ID IS NULL))
       THEN
          BARS.ATTRIBUTE_UTL.SET_VALUE (l_corp_row.id,
                                        'CORPORATION_PARENT_ID',
                                        p_PARENT_ID);
       END IF;

       IF (   p_STATE_ID <> l_corp_row.STATE_ID
           OR (p_STATE_ID IS NULL AND l_corp_row.STATE_ID IS NOT NULL)
           OR (p_STATE_ID IS NOT NULL AND l_corp_row.STATE_ID IS NULL))
       THEN
          BARS.ATTRIBUTE_UTL.SET_VALUE (l_corp_row.id,
                                        'CORPORATION_STATE_ID',
                                        p_STATE_ID);
       END IF;

       IF (   p_EXTERNAL_ID <> l_corp_row.EXTERNAL_ID
           OR (p_EXTERNAL_ID IS NULL AND l_corp_row.EXTERNAL_ID IS NOT NULL)
           OR (p_EXTERNAL_ID IS NOT NULL AND l_corp_row.EXTERNAL_ID IS NULL))
       THEN
          BARS.ATTRIBUTE_UTL.SET_VALUE (l_corp_row.id,
                                        'CORPORATION_EXTERNAL_ID',
                                        p_EXTERNAL_ID);
       END IF;

    END SYNC_OB_CORP;

-------------------------------------------------------------------------------------

    PROCEDURE ADD_CORP (P_CORPORATION_CODE   OB_CORPORATION.CORPORATION_CODE%TYPE,
                        P_CORPORATION_NAME   OB_CORPORATION.CORPORATION_NAME%TYPE,
                        P_PARENT_ID          OB_CORPORATION.PARENT_ID%TYPE DEFAULT NULL,
                        P_EXTERNAL_ID        OB_CORPORATION.EXTERNAL_ID%TYPE) IS
        L_CORPORATION_ID  OB_CORPORATION.ID%TYPE;
        L_CORPORATION_ROW OB_CORPORATION%ROWTYPE;
        RES        NUMBER;
    BEGIN

        if P_PARENT_ID is null then --корневая корпорация
          begin
            select 1 into res from V_ROOT_CORPORATION t where P_EXTERNAL_ID = t.EXTERNAL_ID;
            --нашли - ругаемся
            raise_application_error (-20300,'Підрозділ з таким ідентифікатором вже існує');
          exception
            when no_data_found then null; --не нашли - все нормально
          end;
        else     --подразделение
          begin
            select 1 into res from V_ORG_CORPORATIONS t
            where t.EXTERNAL_ID = P_EXTERNAL_ID
            and   t.base_extid = (select t.base_extid from V_ORG_CORPORATIONS t where t.ID = P_PARENT_ID); --находим ид корневой корпорации
            raise_application_error (-20300,'Підрозділ з таким ідентифікатором вже існує');
          exception
            when no_data_found then null;
          end;
        end if;

        SELECT S_OB_CORPORATION.NEXTVAL INTO L_CORPORATION_ID FROM DUAL;

        INSERT INTO BARS.OB_CORPORATION T1 (T1.ID)
        VALUES (L_CORPORATION_ID)
        RETURNING ID INTO L_CORPORATION_ROW.ID;

        IF (P_CORPORATION_NAME IS NOT NULL) THEN
            BARS.ATTRIBUTE_UTL.SET_VALUE (L_CORPORATION_ROW.ID,
                                          'CORPORATION_NAME',
                                          P_CORPORATION_NAME);
        END IF;

        IF (P_CORPORATION_CODE IS NOT NULL) THEN
            BARS.ATTRIBUTE_UTL.SET_VALUE (L_CORPORATION_ROW.ID,
                                          'CORPORATION_CODE',
                                          P_CORPORATION_CODE);
        END IF;

        IF (P_PARENT_ID IS NOT NULL ) THEN
            BARS.ATTRIBUTE_UTL.SET_VALUE (L_CORPORATION_ROW.ID,
                                          'CORPORATION_PARENT_ID',
                                          P_PARENT_ID);
        END IF;

        IF (P_EXTERNAL_ID IS NOT NULL) THEN
            BARS.ATTRIBUTE_UTL.SET_VALUE (L_CORPORATION_ROW.ID,
                                          'CORPORATION_EXTERNAL_ID',
                                          P_EXTERNAL_ID);
        END IF;

        BARS.ATTRIBUTE_UTL.SET_VALUE (L_CORPORATION_ROW.ID,
                                      'CORPORATION_STATE_ID',
                                      C_OB_STATE_ACTIVE);
    END ADD_CORP;
----------------------------------------------------------------------------------------------------------------------
    PROCEDURE EDIT_CORP (P_ID               OB_CORPORATION.ID%TYPE,
                         P_CORPORATION_CODE OB_CORPORATION.CORPORATION_CODE%TYPE,
                         P_CORPORATION_NAME OB_CORPORATION.CORPORATION_NAME%TYPE,
                         P_EXTERNAL_ID      OB_CORPORATION.EXTERNAL_ID%TYPE,
                         P_PARENT_ID        OB_CORPORATION.EXTERNAL_ID%TYPE) IS
            CURSOR POSIBLE_UNITS (P_ID OB_CORPORATION.EXTERNAL_ID%TYPE, P_ROOT OB_CORPORATION.ID%TYPE) IS
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
        L_ROOT OB_CORPORATION.ID%TYPE;
        L_UNITS T_UNITS;
        L_EXISTS BOOLEAN:=false;
        L_CORPORATION_ROW OB_CORPORATION%ROWTYPE;
        l_parent_id number;
        res        number;
    BEGIN
        BEGIN
            SELECT T1.* INTO L_CORPORATION_ROW
            FROM OB_CORPORATION T1
            WHERE T1.ID = P_ID;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20101, 'Не знайдено підрозділ корпорації з кодом '|| TO_CHAR(P_ID));
        END;

        if L_CORPORATION_ROW.PARENT_ID is null then --корневая корпорация
          begin
            select 1 into res from V_ROOT_CORPORATION t where P_EXTERNAL_ID = t.EXTERNAL_ID and P_ID != t.ID;
            --нашли - ругаемся
            raise_application_error (-20300,'Підрозділ з таким ідентифікатором вже існує');
          exception
            when no_data_found then null; --не нашли - все нормально
          end;
        else     --подразделение
          begin
            select 1 into res from V_ORG_CORPORATIONS t
            where t.EXTERNAL_ID = P_EXTERNAL_ID
            and   P_ID != t.ID
            and   t.base_extid = (select t.base_extid from V_ORG_CORPORATIONS t where L_CORPORATION_ROW.PARENT_ID = t.ID); --находим ид корневой корпорации
            raise_application_error (-20300,'Підрозділ з таким ідентифікатором вже існує');
          exception
            when no_data_found then null;
          end;
        end if;

        IF (P_CORPORATION_NAME <> L_CORPORATION_ROW.CORPORATION_NAME
        OR (P_CORPORATION_NAME IS NULL AND L_CORPORATION_ROW.CORPORATION_NAME IS NOT NULL)
        OR (P_CORPORATION_NAME IS NOT NULL AND L_CORPORATION_ROW.CORPORATION_NAME IS NULL)) THEN
            BARS.ATTRIBUTE_UTL.SET_VALUE (L_CORPORATION_ROW.ID,
                                          'CORPORATION_NAME',
                                          P_CORPORATION_NAME);
        END IF;

        IF (P_CORPORATION_CODE <> L_CORPORATION_ROW.CORPORATION_CODE
        OR (P_CORPORATION_CODE IS NULL AND L_CORPORATION_ROW.CORPORATION_CODE IS NOT NULL)
        OR (P_CORPORATION_CODE IS NOT NULL AND L_CORPORATION_ROW.CORPORATION_CODE IS NULL)) THEN
            BARS.ATTRIBUTE_UTL.SET_VALUE (L_CORPORATION_ROW.ID,
                                          'CORPORATION_CODE',
                                          P_CORPORATION_CODE);
        END IF;

        IF (P_EXTERNAL_ID <> L_CORPORATION_ROW.EXTERNAL_ID
        OR (P_EXTERNAL_ID IS NULL AND L_CORPORATION_ROW.EXTERNAL_ID IS NOT NULL)
        OR (P_EXTERNAL_ID IS NOT NULL AND L_CORPORATION_ROW.EXTERNAL_ID IS NULL)) THEN
            BARS.ATTRIBUTE_UTL.SET_VALUE (L_CORPORATION_ROW.ID,
                                          'CORPORATION_EXTERNAL_ID',
                                          P_EXTERNAL_ID);
        END IF;



        SELECT MAX(ID) KEEP (DENSE_RANK LAST ORDER BY LEVEL) INTO L_ROOT
        FROM OB_CORPORATION T
        START WITH ID = P_ID
        CONNECT BY ID = PRIOR PARENT_ID;

       begin
       select ID into l_parent_id from v_ob_corp_l1 c where c.base_extid = L_ROOT and c.ext_id = P_PARENT_ID;
       exception when no_data_found then null;
       end;
       select count(*) into res from v_ob_corp_l1 c where c.parent_id = l_parent_id and c.id = P_ID;
       if res = 0 and P_PARENT_ID is not null then
            OPEN POSIBLE_UNITS(P_ID, L_ROOT);
            FETCH POSIBLE_UNITS BULK COLLECT INTO L_UNITS;
            CLOSE POSIBLE_UNITS;

                IF NVL(L_UNITS.COUNT,0) <> 0 THEN
                    FOR I IN L_UNITS.FIRST .. L_UNITS.LAST LOOP
                        IF l_parent_id = L_UNITS(I).ID THEN
                            L_EXISTS := TRUE;
                            EXIT;
                        END IF;
                    END LOOP;
                END IF;


                IF L_EXISTS THEN
                    UPDATE OB_CORPORATION SET PARENT_ID = l_parent_id WHERE ID = P_ID;
                ELSE
                    RAISE_APPLICATION_ERROR(-20000, 'Невірний батьківський підрозділ!');
                END IF;
       end if;
    END EDIT_CORP;
--------------------------------------------------------------------------------------
    PROCEDURE LOCK_CORP_ITEM(P_UNIT_ID OB_CORPORATION.ID%TYPE) IS
        CURSOR CUR_CORP IS
        SELECT S.ID
        FROM OB_CORPORATION S
        WHERE S.STATE_ID = C_OB_STATE_ACTIVE
        START WITH ID = P_UNIT_ID
        CONNECT BY PRIOR ID = PARENT_ID;
    BEGIN
        IF GET_CORP_STATE(P_UNIT_ID) = C_OB_STATE_ACTIVE THEN
            FOR CORP IN CUR_CORP LOOP
                BARS.ATTRIBUTE_UTL.SET_VALUE (CORP.ID,
                                              'CORPORATION_STATE_ID',
                                              C_OB_STATE_LOCKED);
            END LOOP;
        ELSE
            RAISE_APPLICATION_ERROR(-20000, 'Невідповідність статусів!');
        END IF;
    END;
------------------------------------------------------------------------------------
    PROCEDURE UNLOCK_CORP_ITEM(P_UNIT_ID OB_CORPORATION.ID%TYPE) IS
    CURSOR CUR_CORP IS
        SELECT S.ID
        FROM OB_CORPORATION S
        WHERE S.STATE_ID = C_OB_STATE_LOCKED
        START WITH ID = P_UNIT_ID
        CONNECT BY PRIOR PARENT_ID = ID;
    BEGIN
        IF GET_CORP_STATE(P_UNIT_ID) = C_OB_STATE_LOCKED THEN
           FOR CORP IN CUR_CORP LOOP
                    BARS.ATTRIBUTE_UTL.SET_VALUE (CORP.ID,
                                                  'CORPORATION_STATE_ID',
                                                  C_OB_STATE_ACTIVE);
           END LOOP;
        ELSE
            RAISE_APPLICATION_ERROR(-20000, 'Невідповідність статусів!');
        END IF;
    END;
---------------------------------------------------------------------------------------
    PROCEDURE CLOSE_CORP_ITEM(P_UNIT_ID OB_CORPORATION.ID%TYPE) IS
        CURSOR CUR_CORP IS
        SELECT S.ID
        FROM OB_CORPORATION S
        WHERE S.STATE_ID <> C_OB_STATE_CLOSED
        START WITH ID = P_UNIT_ID
        CONNECT BY PRIOR ID = PARENT_ID;
    BEGIN
        IF GET_CORP_STATE(P_UNIT_ID) <> C_OB_STATE_CLOSED THEN
           FOR CORP IN CUR_CORP LOOP
                    BARS.ATTRIBUTE_UTL.SET_VALUE (CORP.ID,
                                                  'CORPORATION_STATE_ID',
                                                  C_OB_STATE_CLOSED);
            END LOOP;
        ELSE
            RAISE_APPLICATION_ERROR(-20000, 'Невідповідність статусів!');
        END IF;
    END;
--------------------------------------------------виборка корпорації(PIPELINED)
    FUNCTION GET_POSSIBLE_UNITS(P_ID_UNIT OB_CORPORATION.ID%TYPE) RETURN T_UNITS PIPELINED IS
        ------------------------------------------------------------------------------------
       CURSOR POSIBLE_UNITS (P_ID OB_CORPORATION.EXTERNAL_ID%TYPE, P_ROOT OB_CORPORATION.ID%TYPE) IS
            SELECT EXTERNAL_ID, CORPORATION_NAME FROM (
            SELECT T.ID, T.EXTERNAL_ID, T.CORPORATION_NAME
            FROM OB_CORPORATION T
            WHERE T.STATE_ID <> C_OB_STATE_CLOSED
            START WITH ID = P_ROOT
            CONNECT BY PRIOR ID = PARENT_ID
            MINUS
            SELECT T.ID, T.EXTERNAL_ID, T.CORPORATION_NAME
            FROM OB_CORPORATION T
            WHERE T.STATE_ID <> C_OB_STATE_CLOSED
            START WITH ID = P_ID
            CONNECT BY PRIOR ID = PARENT_ID)
            ORDER BY TO_NUMBER(ID);
        L_UNIT R_UNIT;
        L_ROOT OB_CORPORATION.ID%TYPE;
        L_UNITS T_UNITS;
        ------------------------------------------------------------------------------------
    BEGIN
        SELECT MAX(ID) KEEP (DENSE_RANK LAST ORDER BY LEVEL) INTO L_ROOT
        FROM OB_CORPORATION T
        START WITH ID = P_ID_UNIT
        CONNECT BY ID = PRIOR PARENT_ID;

        OPEN POSIBLE_UNITS(P_ID_UNIT, L_ROOT);
        FETCH POSIBLE_UNITS BULK COLLECT INTO L_UNITS;
        CLOSE POSIBLE_UNITS;

        IF NVL(L_UNITS.COUNT,0) <> 0 THEN
            FOR I IN L_UNITS.FIRST .. L_UNITS.LAST LOOP
                L_UNIT.ID := L_UNITS(I).ID;
                L_UNIT.NAME := L_UNITS(I).NAME;
                PIPE ROW(L_UNIT);
            END LOOP;
        END IF;
    END;
----------------------------------------------------------------------оновлення PARENT_ID корпорації


--процедура обновлениџ счетов корпоративных клиентов(обновлџет включение в выписку, код Х¬јј, код подразделениџ, дату открытиџ и альтернат. корпорацию)
    procedure UPDATE_ACC_CORP(p_acc      number,
                              p_invp     varchar2,
                              p_trkk     varchar2,
                              p_sub_corp varchar2,
                              p_alt_corp varchar2,
                              p_daos     date) as
      l_daos date;
      l_obpcp varchar2(500);
      res number;
      --l_obcrp varchar2(500);
    begin

        --дата відкриття
        /*select daos into l_daos from accounts t where t.ACC = p_acc;
        if (l_daos <> p_daos and p_daos is not null) then
            update accounts t
               set t.daos = p_daos
             where t.ACC = p_acc;
        elsif p_daos is null then
            raise_application_error(-20000, 'Поле дата відкриття порожнє!!');
        end if;*/



        --выписка
        if p_invp in ('Y', 'N') then
            update ACCOUNTSW t
               set t.VALUE = p_invp
             where t.ACC = p_acc
               and t.TAG = 'CORPV';
            if SQL%rowcount = 0 then
              insert into accountsw t (acc, tag, value)
              values (p_acc, 'CORPV', p_invp);
            end if;
         else
          raise_application_error(-20000, 'Значення поля включення до виписки можуть приймати значення Y або N');
         end if;


        --TRKK код
        begin
        select count(*) into res from typnls_corp t where t.kod = p_trkk;
        exception when no_data_found then
           null;
        end;
        if (res<>0 or p_trkk is null) then
        update SPECPARAM_INT t
           set t.TYPNLS = p_trkk
         where t.ACC = p_acc;
        if SQL%rowcount = 0 then
          insert into SPECPARAM_INT t (acc, typnls)
          values (p_acc, p_trkk);
        end if;
        elsif (res=0) then
        raise_application_error(-20000, 'Код ТРКК відсутній в довіднику!!');
        end if;
        --get customer corp_code and inst_code
        select cw1.VALUE into l_obpcp
        from accounts a
        join customerw cw1 on a.rnk = cw1.RNK and cw1.TAG = 'OBPCP'
        where a.ACC = p_acc;

        --проверим, есть ли такое подразделение у корпорации клиента или альтернативной корпорации
        begin
              select 1 into res from V_ORG_CORPORATIONS t
              where (t.base_extid = l_obpcp or t.base_extid = p_alt_corp)
              and rownum = 1
              and t.EXTERNAL_ID = p_sub_corp;
              --јод установи
              update ACCOUNTSW t
                 set t.VALUE = p_sub_corp
               where t.ACC = p_acc
                 and t.TAG = 'OBCORPCD';
              if SQL%rowcount = 0 then
                insert into accountsw t (acc, tag, value)
                values (p_acc, 'OBCORPCD', p_sub_corp);
              end if;
        exception when no_data_found then
            raise_application_error(-20500, 'В довіднику віднсутній підрозділ '||p_sub_corp||' з основною корпорацією '||l_obpcp||' або альтернитивною корпорацією '||p_alt_corp);
        end;


        --альтернатива
        select count(*) into res from V_ROOT_CORPORATION t where t.EXTERNAL_ID = p_alt_corp;

        --check, if alt_corp != customer's corp
        if (l_obpcp != p_alt_corp and res<>0) or p_alt_corp is null then
            update ACCOUNTSW t
             set t.VALUE = p_alt_corp
           where t.ACC = p_acc
             and t.TAG = 'OBCORP';
          if SQL%rowcount = 0 then
            insert into accountsw t (acc, tag, value)
            values (p_acc, 'OBCORP', p_alt_corp);
          end if;
          else
              raise_application_error(-20500, 'Код альтернативної '||p_alt_corp||' корпорації не знайдено в довіднику корпорацій!!');
        end if;
    end UPDATE_ACC_CORP;
-----------------------------------------------отримання признаку РУ/ММФО






-----------------------------------------------------------------------------

 /*     -- возвращает общую сумму остатков за период по календарным днџм (учитываџ первую и последнюю даты)
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
     l_sum     OB_CORPORATION_DATA.OSTQ%TYPE := 0;
     l_kf      OB_CORPORATION_DATA.KF%TYPE;
     l_dat     OB_CORPORATION_DATA.file_date%TYPE;
     l_last_zn OB_CORPORATION_DATA.OSTQ%TYPE := 0;
     l_dat_loop OB_CORPORATION_DATA.file_date%TYPE;
     l_d_sql clob;
     l_ref_cur sys_refcursor;
     type l_my_tab is table of number index by varchar2(255);
     l_rec l_my_tab;
     DATE_DIFF DECIMAL;
     CURSOR kf_cur IS
       SELECT DISTINCT CD.kf
         FROM v_ob_corporation_data_last CD
        WHERE     CD.ROWTYPE = 0
              AND CD.CORPORATION_ID = P_CORP_ID
              and cd.file_date >= P_DATE_START and cd.file_date <= P_DATE_START+10 ;
   BEGIN
         --  менџем первую дату периода (если перваџ дата в ob_corporation_data больше, чем перваџ дата периода)
         -- устанавливаем предельную дату длџ суммированиџ = второй дате периода
         -- не имеет значениџ есть ли такаџ дата в ob_corporation_data, если еще не наступила,
         -- то будет прогнозный расчет cо значением остатка=текущему
         -- суммируем в выбранном периоде остатки
          l_d_sql:= ' SELECT SUM(cd.ostq-cd.obkrq+cd.obdbq) as suma, CD.kf, cd.file_date
                  FROM v_ob_corporation_data_last cd
                  join v_ob_corporation_nbs_report spr on cd.corporation_id = spr.external_id and substr(cd.nls,1,4) = spr.nbs
                  WHERE CD.ROWTYPE = 0
                  AND CD.CORPORATION_ID = '||P_CORP_ID||'
                  AND substr(CD.NLS,1,4) = '||P_NBS||''||
                  case when P_KV_FLAG = 1 then 'AND CD.KV = 980'
                  when P_KV_FLAG = 2 then 'AND CD.KV <> 980' else '' end
                  || case when P_KOD_ANALYT <> '%' then 'AND ('||P_KOD_ANALYT||' = nvl(CD.KOD_ANALYT,0) or  ''0''||'||P_KOD_ANALYT||' = nvl(CD.KOD_ANALYT,0))' else '' end
                  ||' AND cd.file_date >= date'''||to_char(P_DATE_START,'yyyy-mm-dd')||'''
                  AND cd.file_date <= date'''||to_char(P_DATE_END,'yyyy-mm-dd')||''' +10
                  group by cd.kf, cd.file_date
                  order by CD.kf asc, cd.file_date desc';

              open l_ref_cur for l_d_sql;
                loop
                  fetch l_ref_cur into l_sum, l_kf, l_dat;
                    if l_kf is not null and l_dat is not null then
                    l_rec(l_kf||to_char(l_dat,'ddmmyyyy')):=l_sum;
                    end if;
                  exit when l_ref_cur%notfound;
                end loop;
              close l_ref_cur;

              for l_kf_k in kf_cur loop
              l_dat_loop:=P_DATE_END+10;
              l_last_zn:=0;
              l_sum:=0;
              DATE_DIFF:=0;
                     WHILE l_dat_loop >= P_DATE_START LOOP
                        if l_rec.exists(l_kf_k.KF||to_char(l_dat_loop,'ddmmyyyy')) then
                            l_last_zn:=l_rec(l_kf_k.KF||to_char(l_dat_loop,'ddmmyyyy'));
                        end if;
                        if l_dat_loop<=P_DATE_END then
                            l_sum:=l_sum+l_last_zn;
                            DATE_DIFF:=DATE_DIFF+1;
                        end if;
                            l_dat_loop:=l_dat_loop-1;
                     end loop;
                begin
                REC.kf:= l_kf_k.KF;
                REC.OST_SUM:= TRUNC(l_sum / 100 / DATE_DIFF, 2); -- /100 - в гривны; /date_diff - среднее за период;
                PIPE ROW(REC);
                exception when  ZERO_DIVIDE THEN raise_application_error (-20001, 'Відсутні данні за вказаний період');
                end;
              end loop;
     RETURN;
    EXCEPTION WHEN OTHERS THEN
    close l_ref_cur;
    raise;
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
     l_sum     OB_CORPORATION_DATA.OSTQ%TYPE := 0;
     l_K_UST   OB_CORPORATION_DATA.KOD_USTAN%TYPE;
     l_dat     OB_CORPORATION_DATA.file_date%TYPE;
     l_last_zn OB_CORPORATION_DATA.OSTQ%TYPE := 0;
     l_dat_loop OB_CORPORATION_DATA.file_date%TYPE;
     l_d_sql clob;
     l_ref_cur sys_refcursor;
     type l_my_tab is table of number index by varchar2(255);
     l_rec l_my_tab;
     DATE_DIFF DECIMAL;
     CURSOR KOD_USTAN_cur IS
       SELECT DISTINCT CD.KOD_USTAN
         FROM OB_CORPORATION_DATA CD
        WHERE     CD.ROWTYPE = 0
              AND CD.CORPORATION_ID = P_CORP_ID;
   BEGIN
--  менџем первую дату периода (если перваџ дата в ob_corporation_data больше, чем перваџ дата периода)
-- устанавливаем предельную дату длџ суммированиџ = второй дате периода
-- не имеет значениџ есть ли такаџ дата в ob_corporation_data, если еще не наступила,
-- то будет прогнозный расчет cо значением остатка=текущему
-- суммируем в выбранном периоде остатки
        l_d_sql:= ' SELECT SUM(cd.ostq-cd.obkrq+cd.obdbq) as suma, CD.KOD_USTAN, cd.file_date
                  FROM v_ob_corporation_data_last cd
                  join v_ob_corporation_nbs_report spr on cd.corporation_id = spr.external_id and substr(cd.nls,1,4) = spr.nbs
                  WHERE CD.ROWTYPE = 0
                  AND CD.CORPORATION_ID = '||P_CORP_ID||'
                  AND substr(CD.NLS,1,4) = '||P_NBS||''||
                  case when P_KV_FLAG = 1 then 'AND CD.KV = 980'
                  when P_KV_FLAG = 2 then 'AND CD.KV <> 980' else '' end
                  || case when P_KOD_ANALYT <> '%' then 'AND ('||P_KOD_ANALYT||' = nvl(CD.KOD_ANALYT,0) or  ''0''||'||P_KOD_ANALYT||' = nvl(CD.KOD_ANALYT,0))' else '' end
                  ||' AND cd.file_date >= date'''||to_char(P_DATE_START,'yyyy-mm-dd')||'''
                  AND cd.file_date <= date'''||to_char(P_DATE_END,'yyyy-mm-dd')||''' +10
                  group by cd.KOD_USTAN, cd.file_date
                  order by CD.KOD_USTAN asc, cd.file_date desc';

              open l_ref_cur for l_d_sql;
                loop
                  fetch l_ref_cur into l_sum, l_K_UST, l_dat;
                    if l_K_UST is not null and l_dat is not null then
                    l_rec(l_K_UST||to_char(l_dat,'ddmmyyyy')):=l_sum;
                    end if;
                  exit when l_ref_cur%notfound;
                end loop;
              close l_ref_cur;

              for k_ust_c in KOD_USTAN_cur loop
              l_dat_loop:=P_DATE_END+10;
              l_last_zn:=0;
              l_sum:=0;
              DATE_DIFF:=0;
                     WHILE l_dat_loop >= P_DATE_START LOOP
                        if l_rec.exists(k_ust_c.KOD_USTAN||to_char(l_dat_loop,'ddmmyyyy')) then
                            l_last_zn:=l_rec(k_ust_c.KOD_USTAN||to_char(l_dat_loop,'ddmmyyyy'));
                        end if;
                        if l_dat_loop<=P_DATE_END then
                            l_sum:=l_sum+l_last_zn;
                            DATE_DIFF:=DATE_DIFF+1;
                        end if;
                            l_dat_loop:=l_dat_loop-1;
                     end loop;
                begin
                REC.KOD_USTAN:= k_ust_c.KOD_USTAN;
                REC.OST_SUM:= TRUNC(l_sum / 100 / DATE_DIFF, 2); -- /100 - в гривны; /date_diff - среднее за период;
                PIPE ROW(REC);
                exception when  ZERO_DIVIDE THEN raise_application_error (-20001, 'Відсутні данні за вказаний період');
                end;
              end loop;

     RETURN;
    EXCEPTION WHEN OTHERS THEN
    close l_ref_cur;
    raise;
   END KF_OST_SUM_USTAN;*/
--------------------------------------------------------------------------
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
-------------------------------------------------вставка в customerw
procedure ins_customerw (p_rnk customerw.rnk%type,p_external_id varchar2, p_org_id varchar2)
is
 begin

      insert into customerw(rnk, tag, value, isp) values (p_rnk, 'OBPCP', p_external_id, 0);
      insert into customerw(rnk, tag, value, isp) values (p_rnk, 'OBCRP', p_org_id, 0);
 end;

-------------------------------------------------------------------------crt_dict_xml
function crt_dict_xml return clob
is
  l_clob           clob;
  l_id             number;
  l_kf             varchar2(6);
  l_file_date      date;
  l_sync           number;
  l_doc            dbms_xmldom.domdocument;
  l_root_node      dbms_xmldom.domnode;
  l_main_node      dbms_xmldom.domnode;--root
  l_head_node      dbms_xmldom.domnode;--head
  l_corps_node     dbms_xmldom.domnode;--corps
  l_corp_node      dbms_xmldom.domnode;--corp
  l_chs_node       dbms_xmldom.domnode;--chs
  l_ch_node        dbms_xmldom.domnode;--ch
  l_ch_chs_node    dbms_xmldom.domnode;--ch_chs
  l_ch_ch_node     dbms_xmldom.domnode;--ch_ch
  l_acc_sub_node   dbms_xmldom.domnode;
  l_acc_subt_node  dbms_xmldom.domnode;

procedure lg_add_text_elem(m_node dbms_xmldom.domnode,
                           node_name varchar2,
                           node_val varchar2,
                           lp_doc dbms_xmldom.domdocument) is
begin
l_acc_sub_node := dbms_xmldom.appendchild(m_node,
                              dbms_xmldom.makenode(dbms_xmldom.createelement(lp_doc, node_name)));

l_acc_subt_node:= dbms_xmldom.appendchild(l_acc_sub_node,
                              dbms_xmldom.makenode(dbms_xmldom.createtextnode(lp_doc, node_val)));
end;

begin
l_sync := get_sync_id(f_ourmfo, '%', to_char(sysdate,'DDMMYYYY'),0);
    dbms_lob.createtemporary(l_clob, true, 2);
    -- Create an empty XML document
    l_doc := dbms_xmldom.newdomdocument;
        dbms_xmldom.setVersion(l_doc,'1.0" encoding="windows-1251');
        -- Create a root node
        l_root_node := dbms_xmldom.makenode(l_doc);
            -- Create a new Supplier Node and add it to the root node
            l_main_node := dbms_xmldom.appendchild(l_root_node,
                           dbms_xmldom.makenode(dbms_xmldom.createelement(l_doc,'root')));
        --data for header
        select id,kf,file_date into l_id, l_kf, l_file_date from ob_corp_sess where id = l_sync;
        l_head_node  := dbms_xmldom.appendchild(l_main_node,
                           dbms_xmldom.makenode(dbms_xmldom.createelement(l_doc, 'head')));

        lg_add_text_elem(l_head_node, 'sess_id',to_char(l_id), l_doc);
        lg_add_text_elem(l_head_node, 'kf',     l_kf, l_doc);
        lg_add_text_elem(l_head_node, 'f_date', to_char(l_file_date,'dd.mm.yyyy'), l_doc);


        l_corps_node  := dbms_xmldom.appendchild(l_main_node,
                           dbms_xmldom.makenode(dbms_xmldom.createelement(l_doc, 'corps')));

for corps in (select   id, corporation_code,
                       corporation_name, parent_id,
                       state_id, external_id
              from ob_corporation where parent_id is null
              order by to_number(external_id)) loop

            l_corp_node  := dbms_xmldom.appendchild(l_corps_node,
                                dbms_xmldom.makenode(dbms_xmldom.createelement(l_doc, 'corp')));

                lg_add_text_elem(l_corp_node, 'corp_id',to_char(corps.id),l_doc);
                lg_add_text_elem(l_corp_node, 'corp_code',to_char(corps.corporation_code),l_doc);
                lg_add_text_elem(l_corp_node, 'corp_name',to_char(corps.corporation_name),l_doc);
                lg_add_text_elem(l_corp_node, 'perent_id',to_char(corps.parent_id),l_doc);
                lg_add_text_elem(l_corp_node, 'state_id',to_char(corps.state_id),l_doc);
                lg_add_text_elem(l_corp_node, 'ext_id',to_char(corps.external_id),l_doc);




            l_chs_node := dbms_xmldom.appendchild(l_corp_node,
                              dbms_xmldom.makenode(dbms_xmldom.createelement(l_doc, 'ch_corps')));


        for ch_corp in (select   id, corporation_code,
                       corporation_name, parent_id,
                       state_id, external_id
              from ob_corporation where parent_id = corps.id
              order by to_number(external_id)) loop


                 l_ch_node := dbms_xmldom.appendchild(l_chs_node,
                              dbms_xmldom.makenode(dbms_xmldom.createelement(l_doc, 'ch_corp')));

                lg_add_text_elem(l_ch_node, 'corp_id',to_char(ch_corp.id),l_doc);
                lg_add_text_elem(l_ch_node, 'corp_code',to_char(ch_corp.corporation_code),l_doc);
                lg_add_text_elem(l_ch_node, 'corp_name',to_char(ch_corp.corporation_name),l_doc);
                lg_add_text_elem(l_ch_node, 'state_id',to_char(ch_corp.state_id),l_doc);
                lg_add_text_elem(l_ch_node, 'ext_id',to_char(ch_corp.external_id),l_doc);

                             l_ch_chs_node := dbms_xmldom.appendchild(l_ch_node,
                              dbms_xmldom.makenode(dbms_xmldom.createelement(l_doc, 'ch_ch_corps')));


                                    for ch_ch_corp in (select   id, corporation_code,
                                                   corporation_name, parent_id,
                                                   state_id, external_id
                                          from ob_corporation where parent_id = ch_corp.id
                                          order by to_number(external_id)) loop


                                             l_ch_ch_node := dbms_xmldom.appendchild(l_ch_chs_node,
                                                          dbms_xmldom.makenode(dbms_xmldom.createelement(l_doc, 'ch_ch_corp')));

                                            lg_add_text_elem(l_ch_ch_node, 'corp_id',to_char(ch_ch_corp.id),l_doc);
                                            lg_add_text_elem(l_ch_ch_node, 'corp_code',to_char(ch_ch_corp.corporation_code),l_doc);
                                            lg_add_text_elem(l_ch_ch_node, 'corp_name',to_char(ch_ch_corp.corporation_name),l_doc);
                                            lg_add_text_elem(l_ch_ch_node, 'state_id',to_char(ch_ch_corp.state_id),l_doc);
                                            lg_add_text_elem(l_ch_ch_node, 'ext_id',to_char(ch_ch_corp.external_id),l_doc);




end loop;
    end loop;
          end loop;
dbms_xmldom.writetoclob(l_doc, l_clob);
  dbms_xmldom.freedocument(l_doc);
return l_clob;
exception when others then
loger('CRT_DICT_XML', l_sync, to_char(-sqlcode)||' '||sqlerrm(-sqlcode), 3, l_clob);
raise;
end crt_dict_xml;
------------------------------------------------------------------------------pars_dict_xml
function pars_dict_xml(p_clob in clob) return clob
IS
        l_parser        dbms_xmlparser.parser;
        l_sess          dbms_xmldom.domdocument;
        l_fileheader    dbms_xmldom.DOMNodeList;
        l_header        dbms_xmldom.DOMNode;
        l_corp_l        dbms_xmldom.DOMNodeList;
        l_corp          dbms_xmldom.DOMNode;
        l_corp_el       dbms_xmldom.DOMElement;
        l_chs_l         dbms_xmldom.DOMNodeList;
        l_chs           dbms_xmldom.DOMNode;
        l_chs_el        dbms_xmldom.DOMElement;
        l_ch_l          dbms_xmldom.DOMNodeList;
        l_ch            dbms_xmldom.DOMNode;
        l_ch_el         dbms_xmldom.DOMElement;
        l_ch_chs_l      dbms_xmldom.DOMNodeList;
        l_ch_chs        dbms_xmldom.DOMNode;
        l_ch_chs_el     dbms_xmldom.DOMElement;
        l_ch_ch_l       dbms_xmldom.DOMNodeList;
        l_ch_ch         dbms_xmldom.DOMNode;
        l_str           varchar(255);
l_clob clob;
l_ob_corp_ses ob_corp_sess%rowtype;
type lt_ob_corp is table of ob_corporation%rowtype;
l_ob_corp_m lt_ob_corp:=lt_ob_corp();
l_ob_corp_ch lt_ob_corp:=lt_ob_corp();
l_ob_corp_ch_ch lt_ob_corp:=lt_ob_corp();

l_errors number;
l_errs clob;
dml_errors EXCEPTION;
    PRAGMA exception_init(dml_errors, -24381);

procedure bi_ob_corp(lp_ob_corp lt_ob_corp) is
begin
    begin
    forall j in lp_ob_corp.first .. lp_ob_corp.last SAVE EXCEPTIONS
      insert into ob_corporation values lp_ob_corp(j);
    exception when dml_errors then
         l_errors := sql%bulk_exceptions.count;
                for i in 1 .. l_errors
                loop
                    l_errs:=l_errs||to_clob('ob_corporation:');
                    l_errs:=l_errs||to_clob('-'||sql%bulk_exceptions(i).error_code||' ');
                    l_errs:=l_errs||to_clob(sqlerrm(-sql%bulk_exceptions(i).error_code)||' ');
                    l_errs:=l_errs||to_clob(sql%bulk_exceptions(i).error_index||chr(10));
                end loop;
    end;
end;

BEGIN
  l_clob:= p_clob;
  l_parser := dbms_xmlparser.newparser;
  dbms_xmlparser.parseclob(l_parser, l_clob);
  l_sess := dbms_xmlparser.getdocument(l_parser);
  l_fileheader := dbms_xmldom.getelementsbytagname(l_sess, 'head');
  l_header := dbms_xmldom.item(l_fileheader, 0);

  dbms_xslprocessor.valueof(l_header, 'sess_id/text()', l_str);
  l_ob_corp_ses.id:=to_number(l_str);

  dbms_xslprocessor.valueof(l_header, 'kf/text()', l_str);
  l_ob_corp_ses.kf:=l_str;

  dbms_xslprocessor.valueof(l_header, 'f_date/text()', l_str);
  l_ob_corp_ses.file_date:=to_date(l_str,'dd.mm.yyyy');
  l_ob_corp_ses.state_id:=0;
  l_ob_corp_ses.sys_time:=sysdate;
    begin
  insert into ob_corp_sess values l_ob_corp_ses;
    exception when dup_val_on_index then
        l_errs:=l_errs||to_clob('ob_corp_session:');
        l_errs:=l_errs||to_clob(to_char(sqlcode)||chr(10));
    end;

  l_corp_l:= dbms_xmldom.getelementsbytagname(l_sess, 'corp');--corp nodelist
    for c in 0 .. dbms_xmldom.getlength(l_corp_l)-1
    loop
    l_corp := dbms_xmldom.item(l_corp_l, c);--corp node

    l_ob_corp_m.extend;
    l_ob_corp_m(l_ob_corp_m.last).id:=to_number(dbms_xslprocessor.valueof(l_corp, 'corp_id/text()'));
    l_ob_corp_m(l_ob_corp_m.last).corporation_code:=dbms_xslprocessor.valueof(l_corp, 'corp_code/text()');
    l_ob_corp_m(l_ob_corp_m.last).corporation_name:=dbms_xslprocessor.valueof(l_corp, 'corp_name/text()');
    l_ob_corp_m(l_ob_corp_m.last).parent_id:=to_number(dbms_xslprocessor.valueof(l_corp, 'perent_id/text()'));
    l_ob_corp_m(l_ob_corp_m.last).state_id:=to_number(dbms_xslprocessor.valueof(l_corp, 'state_id/text()'));
    l_ob_corp_m(l_ob_corp_m.last).external_id:=dbms_xslprocessor.valueof(l_corp, 'ext_id/text()');

    l_corp_el  := dbms_xmldom.makeElement(l_corp);--corp element
    l_chs_l := dbms_xmldom.getelementsbytagname(l_corp_el, 'ch_corps');
    l_chs   := dbms_xmldom.item(l_chs_l, 0); --беремо перший node chs
    l_chs_el := dbms_xmldom.makeElement(l_chs); --створюємо елемент chs
    l_ch_l:=dbms_xmldom.getelementsbytagname(l_chs_el,'ch_corp'); --створюємо nodelist ch


      for ch in 0 .. dbms_xmldom.getlength(l_ch_l)-1
        loop
        l_ch := dbms_xmldom.item(l_ch_l, ch);
        l_ob_corp_ch.extend;
        l_ob_corp_ch(l_ob_corp_ch.last).parent_id :=l_ob_corp_m(l_ob_corp_m.last).id;

            l_ob_corp_ch(l_ob_corp_ch.last).id:=to_number(dbms_xslprocessor.valueof(l_ch, 'corp_id/text()'));
            l_ob_corp_ch(l_ob_corp_ch.last).corporation_code :=dbms_xslprocessor.valueof(l_ch, 'corp_code/text()');
            l_ob_corp_ch(l_ob_corp_ch.last).corporation_name :=dbms_xslprocessor.valueof(l_ch, 'corp_name/text()');
            l_ob_corp_ch(l_ob_corp_ch.last).state_id :=to_number(dbms_xslprocessor.valueof(l_ch, 'state_id/text()'));
            l_ob_corp_ch(l_ob_corp_ch.last).external_id :=dbms_xslprocessor.valueof(l_ch, 'ext_id/text()');

                    l_ch_el  := dbms_xmldom.makeElement(l_ch);--corp element
                    l_ch_chs_l := dbms_xmldom.getelementsbytagname(l_ch_el, 'ch_ch_corps');
                    l_ch_chs   := dbms_xmldom.item(l_ch_chs_l, 0); --беремо перший node chs
                    l_ch_chs_el := dbms_xmldom.makeElement(l_ch_chs); --створюємо елемент chs
                    l_ch_ch_l:=dbms_xmldom.getelementsbytagname(l_ch_chs_el,'ch_ch_corp'); --створюємо nodelist ch


                      for i in 0 .. dbms_xmldom.getlength(l_ch_ch_l)-1
                        loop
                        l_ch_ch := dbms_xmldom.item(l_ch_ch_l, i);
                        l_ob_corp_ch_ch.extend;
                        l_ob_corp_ch_ch(l_ob_corp_ch_ch.last).parent_id :=l_ob_corp_ch(l_ob_corp_ch.last).id;

                            l_ob_corp_ch_ch(l_ob_corp_ch_ch.last).id:=to_number(dbms_xslprocessor.valueof(l_ch_ch, 'corp_id/text()'));
                            l_ob_corp_ch_ch(l_ob_corp_ch_ch.last).corporation_code :=dbms_xslprocessor.valueof(l_ch_ch, 'corp_code/text()');
                            l_ob_corp_ch_ch(l_ob_corp_ch_ch.last).corporation_name :=dbms_xslprocessor.valueof(l_ch_ch, 'corp_name/text()');
                            l_ob_corp_ch_ch(l_ob_corp_ch_ch.last).state_id :=to_number(dbms_xslprocessor.valueof(l_ch_ch, 'state_id/text()'));
                            l_ob_corp_ch_ch(l_ob_corp_ch_ch.last).external_id :=dbms_xslprocessor.valueof(l_ch_ch, 'ext_id/text()');


    if l_ob_corp_ch_ch.last>=1000 then
        bi_ob_corp(l_ob_corp_ch_ch);
        l_ob_corp_ch_ch.delete;
    end if;
end loop;
    if l_ob_corp_m.last >= 1000 or l_ob_corp_ch_ch.last>=1000 then
            bi_ob_corp(l_ob_corp_ch);
            bi_ob_corp(l_ob_corp_ch_ch);
        l_ob_corp_ch.delete;
        l_ob_corp_ch_ch.delete;
        end if;
end loop;
    if l_ob_corp_ch.last >= 1000 or l_ob_corp_m.last >= 1000 or l_ob_corp_ch_ch.last>=1000 then
            bi_ob_corp(l_ob_corp_m);
            bi_ob_corp(l_ob_corp_ch);
            bi_ob_corp(l_ob_corp_ch_ch);
        l_ob_corp_m.delete;
        l_ob_corp_ch.delete;
        l_ob_corp_ch_ch.delete;
        end if;
end loop;
        bi_ob_corp(l_ob_corp_m);
        bi_ob_corp(l_ob_corp_ch);
        bi_ob_corp(l_ob_corp_ch_ch);
    l_ob_corp_m.delete;
    l_ob_corp_ch.delete;
    l_ob_corp_ch_ch.delete;
if l_errs is null then
loger('PARS_XML', l_ob_corp_ses.id, l_errs, 1, '');
else
loger('PARS_XML', l_ob_corp_ses.id, l_errs, 2, l_clob);
end if;
dbms_xmldom.freedocument(l_sess);
return l_errs;
exception when others then
loger('PARS_XML', l_ob_corp_ses.id, l_errs, 3, l_clob);
raise;
end;

-------------------------------------------------------------------------create_xml
function crt_xml(p_sess_id in number, p_kf in varchar2) return clob
is
  l_clob           clob;
  l_id             number;
  l_kf             varchar2(6);
  l_file_date      date;
  l_doc            dbms_xmldom.domdocument;
  l_root_node      dbms_xmldom.domnode;
  l_main_node      dbms_xmldom.domnode;--root
  l_head_node      dbms_xmldom.domnode;--head
  l_corps_node     dbms_xmldom.domnode;--corps
  l_corp_node      dbms_xmldom.domnode;--corp
  l_acc_node       dbms_xmldom.domnode;--acc
  l_docs_node      dbms_xmldom.domnode;--docs
  l_doc_node       dbms_xmldom.domnode;--doc
  l_acc_sub_node   dbms_xmldom.domnode;
  l_acc_subt_node  dbms_xmldom.domnode;

procedure lg_add_text_elem(m_node dbms_xmldom.domnode,
                           node_name varchar2,
                           node_val varchar2,
                           lp_doc dbms_xmldom.domdocument) is
begin
l_acc_sub_node := dbms_xmldom.appendchild(m_node,
                              dbms_xmldom.makenode(dbms_xmldom.createelement(lp_doc, node_name)));

l_acc_subt_node:= dbms_xmldom.appendchild(l_acc_sub_node,
                              dbms_xmldom.makenode(dbms_xmldom.createtextnode(lp_doc, node_val)));
end;

begin
    dbms_lob.createtemporary(l_clob, true, 2);
    -- Create an empty XML document
    l_doc := dbms_xmldom.newdomdocument;
        dbms_xmldom.setVersion(l_doc,'1.0" encoding="windows-1251');
        -- Create a root node
        l_root_node := dbms_xmldom.makenode(l_doc);
            -- Create a new Supplier Node and add it to the root node
            l_main_node := dbms_xmldom.appendchild(l_root_node,
                           dbms_xmldom.makenode(dbms_xmldom.createelement(l_doc,'root')));
        select id,kf,file_date into l_id, l_kf, l_file_date from ob_corp_sess where id = p_sess_id;
        l_head_node  := dbms_xmldom.appendchild(l_main_node,
                           dbms_xmldom.makenode(dbms_xmldom.createelement(l_doc, 'head')));

        lg_add_text_elem(l_head_node, 'sess_id',to_char(l_id),                     l_doc);
        lg_add_text_elem(l_head_node, 'kf',     l_kf,                              l_doc);
        lg_add_text_elem(l_head_node, 'f_date', to_char(l_file_date,'dd.mm.yyyy'), l_doc);


        l_corps_node  := dbms_xmldom.appendchild(l_main_node,
                           dbms_xmldom.makenode(dbms_xmldom.createelement(l_doc, 'corps')));

for corps in (select distinct corp_id
                    from ob_corp_data_acc
                    where sess_id = p_sess_id and kf = p_kf
                    order by corp_id) loop

            l_corp_node  := dbms_xmldom.appendchild(l_corps_node,
                                dbms_xmldom.makenode(dbms_xmldom.createelement(l_doc, 'corp')));

                lg_add_text_elem(l_corp_node, 'corp_id',to_char(corps.corp_id),l_doc);

    for corp_acc in (select acc, corp_id, kf, nls, kv, okpo, obdb, obdbq, obkr, obkrq,
                            ost, ostq, kod_ustan, kod_analyt, dapp, postdat, namk, nms
                    from ob_corp_data_acc
                    where sess_id = p_sess_id and kf = p_kf and corp_id = corps.corp_id) loop

            l_acc_node  := dbms_xmldom.appendchild(l_corp_node,
                           dbms_xmldom.makenode(dbms_xmldom.createelement(l_doc, 'acc')));

            lg_add_text_elem(l_acc_node, 'acc_id',    to_char(corp_acc.acc),                  l_doc);
            lg_add_text_elem(l_acc_node, 'nls',       corp_acc.nls,                           l_doc);
            lg_add_text_elem(l_acc_node, 'kv',        to_char(corp_acc.kv),                   l_doc);
            lg_add_text_elem(l_acc_node, 'okpo',      corp_acc.okpo,                          l_doc);
            lg_add_text_elem(l_acc_node, 'obdb',      to_char(corp_acc.obdb),                 l_doc);
            lg_add_text_elem(l_acc_node, 'obdbq',     to_char(corp_acc.obdbq),                l_doc);
            lg_add_text_elem(l_acc_node, 'obkr',      to_char(corp_acc.obkr),                 l_doc);
            lg_add_text_elem(l_acc_node, 'obkrq',     to_char(corp_acc.obkrq),                l_doc);
            lg_add_text_elem(l_acc_node, 'ost',       to_char(corp_acc.ost),                  l_doc);
            lg_add_text_elem(l_acc_node, 'ostq',      to_char(corp_acc.ostq),                 l_doc);
            lg_add_text_elem(l_acc_node, 'kod_ustan', to_char(corp_acc.kod_ustan),            l_doc);
            lg_add_text_elem(l_acc_node, 'kod_analyt',corp_acc.kod_analyt,                    l_doc);
            lg_add_text_elem(l_acc_node, 'dapp',      to_char(corp_acc.dapp,'dd.mm.yyyy'),    l_doc);
            lg_add_text_elem(l_acc_node, 'postdat',   to_char(corp_acc.postdat,'dd.mm.yyyy'), l_doc);
            lg_add_text_elem(l_acc_node, 'namk',      corp_acc.namk,                          l_doc);
            lg_add_text_elem(l_acc_node, 'nms',       corp_acc.nms,                           l_doc);


            l_docs_node := dbms_xmldom.appendchild(l_acc_node,
                              dbms_xmldom.makenode(dbms_xmldom.createelement(l_doc, 'docs')));


        for corp_doc in (select ref, postdat, docdat, valdat, nd, vob, dk, mfoa, nlsa, kva, nama,
                                okpoa, mfob, nlsb, kvb, namb, okpob, s, dockv, sq, nazn, tt
                         from ob_corp_data_doc
                         where sess_id = p_sess_id and acc = corp_acc.acc) loop


                 l_doc_node := dbms_xmldom.appendchild(l_docs_node,
                              dbms_xmldom.makenode(dbms_xmldom.createelement(l_doc, 'doc')));

                 lg_add_text_elem(l_doc_node, 'ref',       to_char(corp_doc.ref),                             l_doc);
                 lg_add_text_elem(l_doc_node, 'dk',        to_char(corp_doc.dk),                              l_doc);
                 lg_add_text_elem(l_doc_node, 'postdat',   to_char(corp_doc.postdat,'dd.mm.yyyy hh24:mi:ss'), l_doc);
                 lg_add_text_elem(l_doc_node, 'docdat',    to_char(corp_doc.docdat,'dd.mm.yyyy'),             l_doc);
                 lg_add_text_elem(l_doc_node, 'valdat',    to_char(corp_doc.valdat,'dd.mm.yyyy'),             l_doc);
                 lg_add_text_elem(l_doc_node, 'nd',        corp_doc.nd,                                       l_doc);
                 lg_add_text_elem(l_doc_node, 'vob',       to_char(corp_doc.vob),                             l_doc);
                 lg_add_text_elem(l_doc_node, 'mfoa',      corp_doc.mfoa,                                     l_doc);
                 lg_add_text_elem(l_doc_node, 'nlsa',      corp_doc.nlsa,                                     l_doc);
                 lg_add_text_elem(l_doc_node, 'kva',       to_char(corp_doc.kva),                             l_doc);
                 lg_add_text_elem(l_doc_node, 'nama',      corp_doc.nama,                                     l_doc);
                 lg_add_text_elem(l_doc_node, 'okpoa',     corp_doc.okpoa,                                    l_doc);
                 lg_add_text_elem(l_doc_node, 'mfob',      corp_doc.mfob,                                     l_doc);
                 lg_add_text_elem(l_doc_node, 'nlsb',      corp_doc.nlsb,                                     l_doc);
                 lg_add_text_elem(l_doc_node, 'kvb',       to_char(corp_doc.kvb),                             l_doc);
                 lg_add_text_elem(l_doc_node, 'namb',      corp_doc.namb,                                     l_doc);
                 lg_add_text_elem(l_doc_node, 'okpob',     corp_doc.okpob,                                    l_doc);
                 lg_add_text_elem(l_doc_node, 's',         to_char(corp_doc.s),                               l_doc);
                 lg_add_text_elem(l_doc_node, 'dockv',     to_char(corp_doc.dockv),                           l_doc);
                 lg_add_text_elem(l_doc_node, 'sq',        to_char(corp_doc.sq),                              l_doc);
                 lg_add_text_elem(l_doc_node, 'nazn',      corp_doc.nazn,                                     l_doc);
                 lg_add_text_elem(l_doc_node, 'tt',        corp_doc.tt,                                       l_doc);

end loop;
    end loop;
        end loop;
dbms_xmldom.writetoclob(l_doc, l_clob);
  dbms_xmldom.freedocument(l_doc);
return l_clob;
exception when others then
loger('CRT_XML', l_id, to_char(-sqlcode)||' '||sqlerrm(-sqlcode), 3, l_clob);
end crt_xml;
------------------------------------------------------------------------------------------pars_xml
function pars_xml(p_clob in clob) return clob
IS
        l_parser        dbms_xmlparser.parser;
        l_sess          dbms_xmldom.domdocument;
        l_fileheader    dbms_xmldom.DOMNodeList;
        l_header        dbms_xmldom.DOMNode;
        l_corp_l        dbms_xmldom.DOMNodeList;
        l_corp          dbms_xmldom.DOMNode;
        l_corp_el       dbms_xmldom.DOMElement;
        l_accs_l        dbms_xmldom.DOMNodeList;
        l_acc           dbms_xmldom.DOMNode;
        l_acc_el        dbms_xmldom.DOMElement;
        l_docs_nl       dbms_xmldom.DOMNodeList;
        l_docs          dbms_xmldom.DOMNode;
        l_doc_el        dbms_xmldom.DOMElement;
        l_docs_l        dbms_xmldom.DOMNodeList;
        l_doc           dbms_xmldom.DOMNode;
        l_corp_id       number;
        l_str           varchar(255);
l_clob clob;
l_ob_corp_ses ob_corp_sess%rowtype;
type lt_ob_corp_acc is table of  ob_corp_data_acc%rowtype;
l_ob_corp_acc lt_ob_corp_acc:=lt_ob_corp_acc();
type lt_ob_corp_doc is table of  ob_corp_data_doc%rowtype;
l_ob_corp_doc lt_ob_corp_doc:=lt_ob_corp_doc();

l_errors number;
l_errs clob;
dml_errors EXCEPTION;
    PRAGMA exception_init(dml_errors, -24381);

procedure bi_ob_corp_acc(lp_ob_corp_acc lt_ob_corp_acc) is
begin
    begin
    forall j in lp_ob_corp_acc.first .. lp_ob_corp_acc.last SAVE EXCEPTIONS
      insert into ob_corp_data_acc values lp_ob_corp_acc(j);
    exception when dml_errors then
         l_errors := sql%bulk_exceptions.count;
                for i in 1 .. l_errors
                loop
                    l_errs:=l_errs||to_clob('ob_corp_data_acc:');
                    l_errs:=l_errs||to_clob('-'||sql%bulk_exceptions(i).error_code||' ');
                    l_errs:=l_errs||to_clob(sqlerrm(-sql%bulk_exceptions(i).error_code)||' ');
                    l_errs:=l_errs||to_clob(sql%bulk_exceptions(i).error_index||chr(10));
                end loop;
    end;
end;

procedure bi_ob_corp_doc(lp_ob_corp_doc lt_ob_corp_doc) is
begin
    begin
    forall j in lp_ob_corp_doc.first .. lp_ob_corp_doc.last SAVE EXCEPTIONS
      insert into ob_corp_data_doc values lp_ob_corp_doc(j);
    exception when dml_errors then
         l_errors := sql%bulk_exceptions.count;
                for i in 1 .. l_errors
                loop
                    l_errs:=l_errs||to_clob('ob_corp_data_doc:');
                    l_errs:=l_errs||to_clob('-'||sql%bulk_exceptions(i).error_code||' ');
                    l_errs:=l_errs||to_clob(sqlerrm(-sql%bulk_exceptions(i).error_code)||' ');
                    l_errs:=l_errs||to_clob(sql%bulk_exceptions(i).error_index||chr(10));
                end loop;
    end;
end;


BEGIN
  l_clob:= p_clob;
  l_parser := dbms_xmlparser.newparser;
  dbms_xmlparser.parseclob(l_parser, l_clob);
  l_sess := dbms_xmlparser.getdocument(l_parser);
  l_fileheader := dbms_xmldom.getelementsbytagname(l_sess, 'head');
  l_header := dbms_xmldom.item(l_fileheader, 0);

  dbms_xslprocessor.valueof(l_header, 'sess_id/text()', l_str);
  l_ob_corp_ses.id:=to_number(l_str);

  dbms_xslprocessor.valueof(l_header, 'kf/text()', l_str);
  l_ob_corp_ses.kf:=l_str;

  dbms_xslprocessor.valueof(l_header, 'f_date/text()', l_str);
  l_ob_corp_ses.file_date:=to_date(l_str,'dd.mm.yyyy');
  l_ob_corp_ses.state_id:=0;----------------------------------------
  l_ob_corp_ses.sys_time:=sysdate;
    begin
  insert into ob_corp_sess values l_ob_corp_ses;
    exception when dup_val_on_index then
        l_errs:=l_errs||to_clob('ob_corp_session:');
        l_errs:=l_errs||to_clob(to_char(sqlcode)||chr(10));
    end;

  l_corp_l:= dbms_xmldom.getelementsbytagname(l_sess, 'corp');--corp nodelist
    for c in 0 .. dbms_xmldom.getlength(l_corp_l)-1
    loop
    l_corp := dbms_xmldom.item(l_corp_l, c);--corp node
    l_corp_el  := dbms_xmldom.makeElement(l_corp);--corp element
    l_corp_id:=to_number(dbms_xslprocessor.valueof(l_corp, 'corp_id/text()'));
    l_accs_l := dbms_xmldom.getelementsbytagname(l_corp_el, 'acc');
        insert into ob_corp_sess_corp(SESS_ID, CORP_ID) VALUES (l_ob_corp_ses.id, l_corp_id);-----------------

      for i in 0 .. dbms_xmldom.getlength(l_accs_l)-1
        loop
        l_ob_corp_acc.extend;
        l_acc := dbms_xmldom.item(l_accs_l, i);
        l_acc_el  := dbms_xmldom.makeElement(l_acc);
		l_ob_corp_acc(l_ob_corp_acc.last).is_last:=1;
        l_ob_corp_acc(l_ob_corp_acc.last).sess_id:= l_ob_corp_ses.id;

        l_ob_corp_acc(l_ob_corp_acc.last).acc:=to_number(nvl(dbms_xslprocessor.valueof(l_acc, 'acc_id/text()'),0));

        l_ob_corp_acc(l_ob_corp_acc.last).kf:=l_ob_corp_ses.kf;
        l_ob_corp_acc(l_ob_corp_acc.last).corp_id:=l_corp_id;
        l_ob_corp_acc(l_ob_corp_acc.last).fdat:=l_ob_corp_ses.file_date;
        l_ob_corp_acc(l_ob_corp_acc.last).nls:=dbms_xslprocessor.valueof(l_acc, 'nls/text()');
        l_ob_corp_acc(l_ob_corp_acc.last).kv:=to_number(nvl(dbms_xslprocessor.valueof(l_acc, 'kv/text()'),0));
        l_ob_corp_acc(l_ob_corp_acc.last).okpo:=dbms_xslprocessor.valueof(l_acc, 'okpo/text()');
        l_ob_corp_acc(l_ob_corp_acc.last).obdb:=to_number(nvl(dbms_xslprocessor.valueof(l_acc, 'obdb/text()'),0));
        l_ob_corp_acc(l_ob_corp_acc.last).obdbq:=to_number(nvl(dbms_xslprocessor.valueof(l_acc, 'obdbq/text()'),0));
        l_ob_corp_acc(l_ob_corp_acc.last).obkr:=to_number(nvl(dbms_xslprocessor.valueof(l_acc, 'obkr/text()'),0));
        l_ob_corp_acc(l_ob_corp_acc.last).obkrq:=to_number(nvl(dbms_xslprocessor.valueof(l_acc, 'obkrq/text()'),0));
        l_ob_corp_acc(l_ob_corp_acc.last).ost:=to_number(nvl(dbms_xslprocessor.valueof(l_acc, 'ost/text()'),0));
        l_ob_corp_acc(l_ob_corp_acc.last).ostq:=to_number(nvl(dbms_xslprocessor.valueof(l_acc, 'ostq/text()'),0));
        l_ob_corp_acc(l_ob_corp_acc.last).kod_ustan:=dbms_xslprocessor.valueof(l_acc, 'kod_ustan/text()');
        l_ob_corp_acc(l_ob_corp_acc.last).kod_analyt:=dbms_xslprocessor.valueof(l_acc, 'kod_analyt/text()');
        l_ob_corp_acc(l_ob_corp_acc.last).dapp:=to_date(dbms_xslprocessor.valueof(l_acc, 'dapp/text()'),'dd.mm.yyyy');
        l_ob_corp_acc(l_ob_corp_acc.last).postdat:=to_date(dbms_xslprocessor.valueof(l_acc, 'postdat/text()'),'dd.mm.yyyy');
        l_ob_corp_acc(l_ob_corp_acc.last).namk:=dbms_xslprocessor.valueof(l_acc, 'namk/text()');
        l_ob_corp_acc(l_ob_corp_acc.last).nms:=dbms_xslprocessor.valueof(l_acc, 'nms/text()');
------------------------------docs
            l_docs_nl:= dbms_xmldom.getelementsbytagname(l_acc_el,'docs'); --беремо nodelist docs
            l_docs   := dbms_xmldom.item(l_docs_nl, 0); --беремо перший node docs

            l_doc_el := dbms_xmldom.makeElement(l_docs); --створюємо елемент docs
            l_docs_l:=dbms_xmldom.getelementsbytagname(l_doc_el,'doc'); --створюємо nodelist doc

            for j in 0 .. dbms_xmldom.getlength(l_docs_l)-1
             loop

            l_doc := dbms_xmldom.item(l_docs_l, j); --беремо J node doc
                l_ob_corp_doc.extend;
                l_ob_corp_doc(l_ob_corp_doc.last).sess_id:=l_ob_corp_acc(l_ob_corp_acc.last).sess_id;
                l_ob_corp_doc(l_ob_corp_doc.last).acc:=l_ob_corp_acc(l_ob_corp_acc.last).acc;
                l_ob_corp_doc(l_ob_corp_doc.last).kf:=l_ob_corp_acc(l_ob_corp_acc.last).kf;
                l_ob_corp_doc(l_ob_corp_doc.last).ref:=to_number(nvl(dbms_xslprocessor.valueof(l_doc, 'ref/text()'),0));
                l_ob_corp_doc(l_ob_corp_doc.last).dk:=to_number(nvl(dbms_xslprocessor.valueof(l_doc, 'dk/text()'),0));
                l_ob_corp_doc(l_ob_corp_doc.last).postdat:=to_date(dbms_xslprocessor.valueof(l_doc, 'postdat/text()'),'dd.mm.yyyy hh24:mi:ss');
                l_ob_corp_doc(l_ob_corp_doc.last).docdat:=to_date(dbms_xslprocessor.valueof(l_doc, 'docdat/text()'),'dd.mm.yyyy');
                l_ob_corp_doc(l_ob_corp_doc.last).valdat:=to_date(dbms_xslprocessor.valueof(l_doc, 'valdat/text()'),'dd.mm.yyyy');
                l_ob_corp_doc(l_ob_corp_doc.last).nd:=dbms_xslprocessor.valueof(l_doc, 'nd/text()');
                l_ob_corp_doc(l_ob_corp_doc.last).vob:=to_number(nvl(dbms_xslprocessor.valueof(l_doc, 'vob/text()'),0));
                l_ob_corp_doc(l_ob_corp_doc.last).mfoa:=dbms_xslprocessor.valueof(l_doc, 'mfoa/text()');
                l_ob_corp_doc(l_ob_corp_doc.last).nlsa:=dbms_xslprocessor.valueof(l_doc, 'nlsa/text()');
                l_ob_corp_doc(l_ob_corp_doc.last).kva:=to_number(nvl(dbms_xslprocessor.valueof(l_doc, 'kva/text()'),0));
                l_ob_corp_doc(l_ob_corp_doc.last).nama:=dbms_xslprocessor.valueof(l_doc, 'nama/text()');
                l_ob_corp_doc(l_ob_corp_doc.last).okpoa:=dbms_xslprocessor.valueof(l_doc, 'okpoa/text()');
                l_ob_corp_doc(l_ob_corp_doc.last).mfob:=dbms_xslprocessor.valueof(l_doc, 'mfob/text()');
                l_ob_corp_doc(l_ob_corp_doc.last).nlsb:=dbms_xslprocessor.valueof(l_doc, 'nlsb/text()');
                l_ob_corp_doc(l_ob_corp_doc.last).kvb:=to_number(nvl(dbms_xslprocessor.valueof(l_doc, 'kvb/text()'),0));
                l_ob_corp_doc(l_ob_corp_doc.last).namb:=dbms_xslprocessor.valueof(l_doc, 'namb/text()');
                l_ob_corp_doc(l_ob_corp_doc.last).okpob:=dbms_xslprocessor.valueof(l_doc, 'okpob/text()');
                l_ob_corp_doc(l_ob_corp_doc.last).s:=to_number(nvl(dbms_xslprocessor.valueof(l_doc, 's/text()'),0));
                l_ob_corp_doc(l_ob_corp_doc.last).dockv:=to_number(nvl(dbms_xslprocessor.valueof(l_doc, 'dockv/text()'),0));
                l_ob_corp_doc(l_ob_corp_doc.last).sq:=to_number(nvl(dbms_xslprocessor.valueof(l_doc, 'sq/text()'),0));
                l_ob_corp_doc(l_ob_corp_doc.last).nazn:=dbms_xslprocessor.valueof(l_doc, 'nazn/text()');
                l_ob_corp_doc(l_ob_corp_doc.last).tt:=dbms_xslprocessor.valueof(l_doc, 'tt/text()');

        end loop;

    if l_ob_corp_acc.last >= 1000 or l_ob_corp_doc.last >= 1000 then
        bi_ob_corp_acc(l_ob_corp_acc);
        bi_ob_corp_doc(l_ob_corp_doc);
    l_ob_corp_acc.delete;
    l_ob_corp_doc.delete;
    end if;
end loop;
if l_errs is null then
set_last_corp (l_ob_corp_ses.file_date, l_corp_id, l_ob_corp_ses.kf, l_ob_corp_ses.id);
end if;
end loop;
        bi_ob_corp_acc(l_ob_corp_acc);
        bi_ob_corp_doc(l_ob_corp_doc);
    l_ob_corp_acc.delete;
    l_ob_corp_doc.delete;
if l_errs is null then
loger('PARS_XML', l_ob_corp_ses.id, l_errs, 1, '');
    update BARS.OB_CORP_SESS s
       set s.state_id = 2
    where s.id = l_ob_corp_ses.id;
else
loger('PARS_XML', l_ob_corp_ses.id, l_errs, 2, l_clob);
    update BARS.OB_CORP_SESS s
       set s.state_id = 2
    where s.id = l_ob_corp_ses.id;
end if;
dbms_xmldom.freedocument(l_sess);
return l_errs;
exception when others then
loger('PARS_XML', l_ob_corp_ses.id, l_errs, 3, l_clob);
    update BARS.OB_CORP_SESS s
       set s.state_id = 3
    where s.id = l_ob_corp_ses.id;
end;

procedure send_kfiles(p_id number, p_mmfo varchar2) is
    /*params BARSTRANS.TRANSP_UTL.t_add_params;
l_sess_id   varchar2(36);
l_xml_body  clob;
l_ret       varchar2(4000);
l_corp_code varchar2(10);
l_sync      number;
l_crt_err   number:=0;*/
begin
null;
/*if SYS_CONTEXT ('bars_context', 'user_mfo') is null then
raise_application_error(-20000, 'Передача К-файлів з рівні "/" заборонено!!');
elsif SYS_CONTEXT ('bars_context', 'user_mfo') != p_mmfo then
raise_application_error(-20000, 'Передача К-файлів іншого МФО заборонено!!');
end if;



  if kfile_pack.get_mmfo_type = 0 then
       l_xml_body:= crt_xml(p_id, p_mmfo);
       BARSTRANS.TRANSP_UTL.send(l_xml_body, params, 'K_FILE_DATE', '300465', l_sess_id);
       loger('KFILE_SEND', l_sync, to_clob(l_ret), 3, l_xml_body);
            if l_ret is not null then
                raise_application_error (-20000, 'Помилка при передачі: '||l_ret);
            end if;
  else
   raise_application_error (-20000, 'З серверу ММФО К-файли передаються автоматично!!');
  end if;*/
end send_kfiles;

procedure proc_corp_dict(p_transp_id varchar2) is
l_clob clob;
begin
null;
/*select d_clob into l_clob from BARSTRANS.INPUT_REQS where id = p_transp_id;
l_clob:=pars_dict_xml(l_clob);*/
end;


procedure send_corp_dict is
/*l_params BARSTRANS.TRANSP_UTL.t_add_params;
l_send_list BARSTRANS.TRANSP_UTL.NUMBER_LIST;
l_sess_id   varchar2(36);
l_xml_body  clob;
l_ret       varchar2(4000);
l_corp_code varchar2(10);
l_sync      number;
l_crt_err   number:=0;*/
begin
null;
/*if SYS_CONTEXT ('bars_context', 'user_mfo') is null or SYS_CONTEXT ('bars_context', 'user_mfo') = '300465' then
       l_xml_body:= crt_dict_xml;

        select to_number(kf) as kf bulk collect into l_send_list
        from clim_mfo m
        where not exists(select 1 from mv_kf k where k.kf = m.kf);

       BARSTRANS.TRANSP_UTL.send(l_xml_body, l_params, 'K_FILE_CORP_DICT', l_send_list, l_sess_id);
       --loger('KFILE_SEND', l_sync, to_clob(l_ret), 3, l_xml_body);
            if l_ret is not null then
                raise_application_error (-20000, 'Помилка при передачі: '||l_ret);
            end if;
else
raise_application_error(-20000, 'Передача довідника заборонено!!');
end if;*/
end send_corp_dict;

procedure send_dict_result(p_transp_id varchar2) is
    l_status number;
    begin
                 null;
                 /*select q.status into l_status from barstrans.out_main_req q where q.id = p_transp_id;

                 bms.send_message(p_receiver_id     => user_id,
                 p_message_type_id => 1,
                 p_message_text    => 'Довідник корпорацій доставлено успішно.',
                 p_delay           => 0,
                 p_expiration      => 0);*/
    end;

procedure send_kfile_result(p_transp_id varchar2) is
    l_status number;
    begin
                 null;
                 /*select q.status into l_status from barstrans.out_main_req q where q.id = p_transp_id;

                 bms.send_message(p_receiver_id     => user_id,
                 p_message_type_id => 1,
                 p_message_text    => 'К-файли доставлено успішно.',
                 p_delay           => 0,
                 p_expiration      => 0);*/
    end;

BEGIN
   -- Initialization
   NULL;
END KFILE_PACK;
/
