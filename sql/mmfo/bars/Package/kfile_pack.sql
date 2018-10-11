CREATE OR REPLACE PACKAGE BARS."KFILE_PACK" IS
    -- Author  : Alex.Iurchenko
    -- Created : 31.12.1899 23:59:59
    -- Purpose : package for work with k-files data(CA LEVEL)
    -- Версія пакету
    G_HEADER_VERSION CONSTANT VARCHAR2(64) := 'VERSION 1.01 09/08/2018';

    C_OB_CORPORATION_STATE CONSTANT VARCHAR2(25 CHAR) := 'OB_CORPORATION_STATE';
    C_OB_STATE_ACTIVE      CONSTANT INT := 1;
    C_OB_STATE_LOCKED      CONSTANT INT := 2;
    C_OB_STATE_CLOSED      CONSTANT INT := 3;

    TYPE R_UNIT IS RECORD(
        ID   OB_CORPORATION.EXTERNAL_ID%TYPE,
        NAME OB_CORPORATION.CORPORATION_NAME%TYPE);
    TYPE T_UNITS IS TABLE OF R_UNIT;

    TYPE MEASURE_RECORD IS RECORD(
        kf      VARCHAR2(6),
        OST_SUM NUMBER);

    TYPE MEASURE_TABLE IS TABLE OF MEASURE_RECORD;

    TYPE MEASURE_RECORD_2 IS RECORD(
        KOD_USTAN NUMBER,
        OST_SUM   NUMBER);

    TYPE MEASURE_TABLE_2 IS TABLE OF MEASURE_RECORD_2;

    -- header_version - возвращает версию заголовка пакета
    FUNCTION HEADER_VERSION RETURN VARCHAR2;

    -- body_version - возвращает версию тела пакета
    FUNCTION BODY_VERSION RETURN VARCHAR2;

    FUNCTION GET_C_OB_CORP_STATE RETURN VARCHAR2;
    
    procedure kfile_vzd;                        
                            
    -- fill data on date(p_date format DDMMYYYY)
    procedure fill_data(p_date date, p_corp_code varchar2);
    -----------------------------------------------------------p_lic26_kfile_mmfo
    procedure lic26_kfile(p_s date, p_corpc number, p_sess_id out number);

    FUNCTION GET_ALL_UNITS(P_ACC ACCOUNTS.ACC%TYPE) RETURN T_UNITS PIPELINED;

    PROCEDURE ADD_CORP(P_CORPORATION_CODE OB_CORPORATION.CORPORATION_CODE%TYPE,
                       P_CORPORATION_NAME OB_CORPORATION.CORPORATION_NAME%TYPE,
                       P_PARENT_ID        OB_CORPORATION.PARENT_ID%TYPE DEFAULT NULL,
                       P_EXTERNAL_ID      OB_CORPORATION.EXTERNAL_ID%TYPE);

    PROCEDURE EDIT_CORP(P_ID               OB_CORPORATION.ID%TYPE,
                        P_CORPORATION_CODE OB_CORPORATION.CORPORATION_CODE%TYPE,
                        P_CORPORATION_NAME OB_CORPORATION.CORPORATION_NAME%TYPE,
                        P_EXTERNAL_ID      OB_CORPORATION.EXTERNAL_ID%TYPE,
                        P_PARENT_ID        OB_CORPORATION.EXTERNAL_ID%TYPE);

    PROCEDURE LOCK_CORP_ITEM(P_UNIT_ID OB_CORPORATION.ID%TYPE);

    PROCEDURE UNLOCK_CORP_ITEM(P_UNIT_ID OB_CORPORATION.ID%TYPE);

    PROCEDURE CLOSE_CORP_ITEM(P_UNIT_ID OB_CORPORATION.ID%TYPE);

    function kf_ost_sum(p_corp_id    in number,
                        p_nbs        in varchar2,
                        p_kv_flag    in number, --0 - всі валюти, 1 - гривні, 2 - всі крім гривні)
                        p_kod_analyt in varchar2,
                        p_date_start in date,
                        p_date_end   in date,
                        p_rep_id     in number) return measure_table
        pipelined;

    function kf_ost_sum_ustan(p_corp_id    in number,
                              p_nbs        in varchar2,
                              p_kv_flag    in number, --0 - всі валюти, 1 - гривні, 2 - всі крім гривні)
                              p_kod_analyt in varchar2,
                              p_date_start in date,
                              p_date_end   in date,
                              p_rep_id     in number) return measure_table_2
        pipelined;

    function get_possible_units(p_id_unit ob_corporation.id%type) return t_units pipelined;
    --процедура обновления счетов корпоративных клиентов(обновляет включение в выписку, код ТРКК, код подразделения, дату открытия и альтернат. корпорацию)
    procedure UPDATE_ACC_CORP(p_acc      number,
                              p_invp     varchar2,
                              p_trkk     varchar2,
                              p_sub_corp varchar2,
                              p_alt_corp varchar2,
                              p_daos     date);
    procedure ins_customerw(p_rnk         customerw.rnk%type,
                            p_external_id varchar2,
                            p_org_id      varchar2);

    procedure crt_txt_k_file(p_sess_id in number,
                             p_corp_id in number,
                             p_kf      in varchar2,
                             p_fname   in out varchar2,
                             p_k_file  out clob);

    procedure crt_kfile(p_sess_id in number,
                        p_kf      in varchar2,
                        p_corp_id in number default null);

END KFILE_PACK;
/
CREATE OR REPLACE PACKAGE BODY BARS."KFILE_PACK"
IS
    -- Версія пакету
    G_BODY_VERSION   CONSTANT VARCHAR2 (64) := 'VERSION 1.11 04/12/2017';
    G_DBGCODE        CONSTANT VARCHAR2 (20) := 'KFILE_PACK';
    ------------------------------------------------------------------------------------

-- header_version - возвращает версию заголовка пакета
 function header_version return varchar2 is
 begin
     return 'Package header ' || g_dbgcode || ' ' || g_header_version || '.';
 end header_version;

-- body_version - возвращает версию тела пакета
 function body_version return varchar2 is
 begin
     return 'Package body ' || g_dbgcode || ' ' || g_body_version || '.';
 end body_version;

--get_c_ob_corporation_state
 function get_c_ob_corp_state return varchar2 is
 begin
     return c_ob_corporation_state;
 end;
 
 procedure log_err(p_state number, p_id number, p_clob clob default null) is    
 pragma autonomous_transaction;
 begin
     update BARS.OB_CORP_SESS s
       set s.state_id = p_state,
           s.err_log = p_clob
     where s.id = p_id;
 commit;    
 end; 
 
 function encode_base64(p_blob in blob) return clob is
            l_clob           clob;
            l_result         clob;
            l_offset         integer;
            l_chunk_size     binary_integer := 23808;
            l_buffer_varchar varchar2(32736);
            l_buffer_raw     raw(32736);
          begin
            if (p_blob is null) then
              return null;
            end if;

            dbms_lob.createtemporary(l_clob, false);

            l_offset := 1;
            for i in 1 .. ceil(dbms_lob.getlength(p_blob) / l_chunk_size) loop
              dbms_lob.read(p_blob, l_chunk_size, l_offset, l_buffer_raw);
              l_buffer_raw     := utl_encode.base64_encode(l_buffer_raw);
              l_buffer_varchar := utl_raw.cast_to_varchar2(l_buffer_raw);
              l_buffer_varchar :=regexp_replace(l_buffer_varchar, '\s', '');
              dbms_lob.writeappend(l_clob, length(l_buffer_varchar), l_buffer_varchar);
              l_offset := l_offset + l_chunk_size;
            end loop;

            l_result := l_clob;
            dbms_lob.freetemporary(l_clob);

            return l_result;
        end;
        
 function clob_to_blob(p_clob in clob) return blob is
     l_blob         blob;
     l_warning      integer;
     l_dest_offset  integer := 1;
     l_src_offset   integer := 1;
     l_blob_csid    number := dbms_lob.default_csid;
     l_lang_context number := dbms_lob.default_lang_ctx;
 begin
            if (p_clob is null) then
              return null;
            end if;
            
     dbms_lob.createtemporary(l_blob, false);

     dbms_lob.converttoblob(dest_lob     => l_blob,
                            src_clob     => p_clob,
                            amount       => dbms_lob.lobmaxsize,
                            dest_offset  => l_dest_offset,
                            src_offset   => l_src_offset,
                            blob_csid    => l_blob_csid,
                            lang_context => l_lang_context,
                            warning      => l_warning);
     return l_blob;
 end;

 function get_corp_state(p_id ob_corporation.id%type) return number is l_state_id number;
 begin
     select state_id
       into l_state_id
       from ob_corporation c
      where c.id = p_id;
     return l_state_id;
 exception
     when no_data_found then
         return null;
 end get_corp_state;

 procedure crt_txt_k_file(p_sess_id in number,
                          p_corp_id in number,
                          p_kf      in varchar2,
                          p_fname   in out varchar2,
                          p_k_file  out clob) is
     l_clob clob;
     l_filename varchar2(50);
 begin
     DBMS_LOB.CREATETEMPORARY(l_clob, true, DBMS_LOB.SESSION);
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
                      lpadchr(to_char(posttime, 'HH24MI'), ' ', 4) || '|' ||
                      rpadchr(substr(namk, 1, 60), ' ', 60) || '|' ||
                      rpadchr(substr(nms, 1, 60), ' ', 60) || '|' ||
                      rpadchr(tt, ' ', 3) || '|' || chr(13) || chr(10) as k_file_str
                 from V_OB_CORP_REPORT
                where kf = p_kf
                  and corporation_id = p_corp_id
                  and session_id = p_sess_id) loop
         DBMS_LOB.WRITEAPPEND(l_clob, length(j.k_file_str), j.k_file_str);
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
     dbms_lob.freetemporary(l_clob);
 exception when others then
    logger.error(substr(G_DBGCODE || to_char(p_sess_id) || sqlerrm || dbms_utility.format_error_backtrace(), 1, 4000));
    raise_application_error(-20000, dbms_utility.format_error_backtrace || ' ' || sqlerrm);
 end;

 procedure crt_kfile(p_sess_id in number,
                     p_kf      in varchar2,
                     p_corp_id in number default null) is

  l_url           varchar2(1024) :=  branch_attribute_utl.get_value('LINK_FOR_ABSBARS_WEBAPISERVICES')||'kfiles/CrtKfile';
  l_f_path        varchar2(255) :=branch_attribute_utl.get_value('TMS_REPORTS_DIR');
  l_wallet_path   varchar2(256) := getglobaloption('PATH_FOR_ABSBARS_WALLET');
  l_wallet_pwd    varchar2(256) := getglobaloption('PASS_FOR_ABSBARS_WALLET');
  l_login         varchar2(400):= branch_attribute_utl.get_value('TMS_LOGIN');
  l_password      varchar2(400):= branch_attribute_utl.get_value('TMS_PASS');
  l_response      wsm_mgr.t_response;
  fname           varchar2(50);
  l_clob          clob;
  begin

  for i in (select corp_id
              from ob_corp_sess_corp c
             where c.kf = p_kf
               and c.sess_id = p_sess_id
               and c.is_last = 1
               and case when p_corp_id is null then -1 else c.corp_id end = case when p_corp_id is null then -1 else p_corp_id end)
           loop
           
           crt_txt_k_file(p_sess_id, i.corp_id, p_kf, fname, l_clob);
           
           if l_clob is not null then          
           l_clob:=encode_base64(utl_compress.lz_compress(clob_to_blob(l_clob)));
           
             wsm_mgr.prepare_request(p_url=> l_url,
                          p_action      => null,
                          p_http_method => wsm_mgr.g_http_post,
                          p_wallet_path => l_wallet_path,
                          p_wallet_pwd  => l_wallet_pwd,
                          p_body        => l_clob);
             WSM_MGR.add_parameter('path', l_f_path);
             WSM_MGR.add_parameter('filename', fname);
             WSM_MGR.add_header('Authorization', 'Basic ' ||
             utl_raw.cast_to_varchar2(utl_encode.base64_encode(utl_raw.cast_to_raw(l_login || ':' || l_password))));
             -- позвать метод веб-сервиса
             wsm_mgr.execute_api(l_response);
           end if;
           end loop;
  exception when others then
      logger.error(substr(G_DBGCODE || to_char(p_sess_id) || sqlerrm || dbms_utility.format_error_backtrace(), 1, 4000));
      raise_application_error(-20000, dbms_utility.format_error_backtrace || ' ' || sqlerrm);
  end;
  
  procedure kfile_vzd is 
  l_date date:= gl.bd();
  l_corpc number:=null;
  l_kf varchar2(6):=f_ourmfo();
  l_session number;
  begin
  lic26_kfile(l_date, l_corpc, l_session);
  crt_kfile(l_session, l_kf);
  end;

---------------------------------------------------------------------------------------
 function get_sync_id(p_mfo in varchar2, p_sync_date in date) return number is
      l_sync_id number;
      begin
      insert into BARS.OB_CORP_SESS 
      (id, 
       KF, 
       FILE_DATE, 
       state_id, 
       sys_time)
      values
      (S_OB_CORPORATION_SESSION.nextval, 
       p_mfo , 
       p_sync_date, 
       0, 
       sysdate) 
       returning id into l_sync_id;
      commit;
      return l_sync_id;
 end;
------------------------------------------------------------------------------------------------
    procedure set_last_corp (p_s date, p_corpc number, p_kf varchar2, p_sess_id number) is
         l_corp_list number_list;
         l_sess_list number_list;
    begin
         
            
          begin
            select id bulk collect into l_sess_list 
              from OB_CORP_SESS A
             where a.kf = p_kf
               and a.file_date = p_s;
          exception when no_data_found then
          null;
          end;
            
         if (p_corpc is null) then
                forall j in 1..l_sess_list.count 
                    update OB_CORP_SESS_CORP q set q.is_last = 0
                    where q.sess_id = l_sess_list(j)
                      and q.sess_id <> p_sess_id;

                forall j in 1..l_sess_list.count
                    update OB_CORP_DATA_ACC q set q.is_last = 0
                    where q.sess_id = l_sess_list(j)
                      and q.sess_id <> p_sess_id;
                
                SELECT TO_NUMBER(A.EXTERNAL_ID) bulk collect into l_corp_list 
                  FROM OB_CORPORATION A 
                 WHERE A.PARENT_ID IS NULL;
                
                
        ELSE
                forall j in 1..l_sess_list.count 
                    update OB_CORP_SESS_CORP q set q.is_last = 0
                    where q.sess_id = l_sess_list(j) 
                      and q.corp_id = p_corpc
                      and q.sess_id <> p_sess_id;

                forall j in 1..l_sess_list.count
                    update OB_CORP_DATA_ACC q set q.is_last = 0
                    where q.sess_id = l_sess_list(j) 
                      and q.corp_id = p_corpc
                      and q.sess_id <> p_sess_id;
                    
                SELECT p_corpc bulk collect into l_corp_list 
                  FROM dual;

        END IF;
        
        forall j in l_corp_list.first..l_corp_list.last
                    INSERT INTO OB_CORP_SESS_CORP(SESS_ID, KF, CORP_ID,IS_LAST) 
                    VALUES (p_sess_id, p_kf, l_corp_list(j),1); 
                    
                    update OB_CORP_DATA_ACC a
                       set a.is_last = 1
                    where a.sess_id = p_sess_id;  
    end;
-----------------------------------------------------------------------------------------
    procedure fill_data(p_date date, p_corp_code varchar2) is
      l_jobname varchar2(64) := 'K_FILES_CREATE_FOR'||f_ourmfo;
      l_action varchar2(2000) :=
    'declare
     l_sess_id number;
     begin
        bars_login.login_user(sys_guid(), '||user_id||', null, null);
        bc.go('''||f_ourmfo||''');
        kfile_pack.LIC26_KFILE(to_date('''||to_char(p_date, 'dd.mm.yyyy')||''',''dd.mm.yyyy'')'||
                               case when p_corp_code is null then ', null' else ', '||p_corp_code end||', l_sess_id);
        commit;
        bms.send_message(p_receiver_id     => '||user_id||',
         p_message_type_id => 1,
         p_message_text    => ''К-Файл сформовано '||case when p_corp_code is null then 'для всіх корпорацій' else 'для '||
                                p_corp_code||' корпорації' end||', МФО: '||f_ourmfo||' на дату: '||to_char(p_date, 'dd.mm.yyyy')||''',
         p_delay           => 0,
         p_expiration      => 0);
         bars_login.logout_user;
     exception
         when others then
                 logger.error(substr(''KFILE_PACK - '' || sqlerrm || dbms_utility.format_error_backtrace(), 1, 4000));
                 
                 bms.send_message(p_receiver_id     => '||user_id||',
                 p_message_type_id => 1,
                 p_message_text    => ''Помилка формування К-Файлу '||case when p_corp_code is null then 'для всіх корпорацій' else 'для '||
                                        p_corp_code||' корпорації' end||', МФО: '||f_ourmfo||' на дату: '||to_char(p_date, 'dd.mm.yyyy')||''',
                 p_delay           => 0,
                 p_expiration      => 0);
                 bars_login.logout_user;
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
        logger.error(substr(G_DBGCODE || ' - ' || sqlerrm || dbms_utility.format_error_backtrace(), 1, 4000));
        -- в любом случае срубаем джоб
        dbms_scheduler.drop_job(l_jobname, force => true);
        raise_application_error(-20000, dbms_utility.format_error_backtrace || ' ' || sqlerrm);
    end;

PROCEDURE lic26_kfile (p_s           date,           -- дата по
                       p_corpc       number,
                       p_sess_id out number)      -- код корпорации
is
type lt_data_acc is table of OB_CORP_DATA_ACC%rowtype;
l_data_acc lt_data_acc:=lt_data_acc();

type lt_data_doc is table of OB_CORP_DATA_DOC%rowtype;
l_data_doc lt_data_doc:=lt_data_doc();

   dml_errors EXCEPTION;
   PRAGMA exception_init(dml_errors, -24381);
   l_err_clob clob;

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
   l_errors   number; 
   l_str      varchar2(32000); 
begin
forall j in p_data_acc.first .. p_data_acc.last SAVE EXCEPTIONS
      insert into ob_corp_data_acc values p_data_acc(j);
exception when dml_errors then
         l_errors := sql%bulk_exceptions.count;
                for i in 1 .. l_errors
                loop
                    l_str:='acc | ';
                    l_str:= l_str||'-'||to_char(sql%bulk_exceptions(i).error_code)||' | ';
                    l_str:= l_str||to_char(p_data_acc(sql%bulk_exceptions(i).error_index).SESS_ID)||' | ';
                    l_str:= l_str||to_char(p_data_acc(sql%bulk_exceptions(i).error_index).ACC)||' | ';
                    l_str:= l_str||p_data_acc(sql%bulk_exceptions(i).error_index).KF||' | ';
                    l_str:= l_str||sqlerrm(-sql%bulk_exceptions(i).error_code)||chr(10);
                    DBMS_LOB.WRITEAPPEND(l_err_clob, length(l_str), l_str);
                end loop;      
end;
procedure l_ins_data_doc(p_data_doc lt_data_doc) is
   l_errors   number; 
   l_str      varchar2(32000);  
begin
    forall j in p_data_doc.first .. p_data_doc.last SAVE EXCEPTIONS
      insert into ob_corp_data_doc values p_data_doc(j);
exception when dml_errors then
         l_errors := sql%bulk_exceptions.count;
                for i in 1 .. l_errors
                loop
                    l_str:='doc | ';
                    l_str:=l_str||'-'||sql%bulk_exceptions(i).error_code||' | ';
                    l_str:=l_str||to_char(p_data_doc(sql%bulk_exceptions(i).error_index).SESS_ID)||' | ';
                    l_str:=l_str||to_char(p_data_doc(sql%bulk_exceptions(i).error_index).ACC||' | ');
                    l_str:=l_str||p_data_doc(sql%bulk_exceptions(i).error_index).KF||' | ';
                    l_str:=l_str||to_char(p_data_doc(sql%bulk_exceptions(i).error_index).REF)||' | ';
                    l_str:=l_str||to_char(p_data_doc(sql%bulk_exceptions(i).error_index).DK)||' | ';
                    l_str:= l_str||sqlerrm(-sql%bulk_exceptions(i).error_code)||chr(10);
                    DBMS_LOB.WRITEAPPEND(l_err_clob, length(l_str), l_str);
                end loop;    
end;

begin
   DBMS_LOB.CREATETEMPORARY(l_err_clob, true, DBMS_LOB.SESSION);

   bars_audit.trace('p_lic26_kfile: формирование К файла за: ' ||to_char(p_s,'dd/mm/yyyy') ||' маска корпорации: '||p_corpc);
  
        l_sync := get_sync_id(f_ourmfo, p_s);
        p_sess_id:=l_sync;
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
      for c1 in (select ref,tt, s * decode(dk,0,-1,1) s,txt, dk, stmt, kf
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
    
    set_last_corp (p_s, p_corpc, f_ourmfo, l_sync);
    
    
   
    if length(l_err_clob) = 0 then
       log_err(1, l_sync); 
       commit; 
    else
       log_err(3, l_sync, l_err_clob);
       rollback;
       raise_application_error(-20000, to_char(substr(l_err_clob, 1, 4000)));
    end if;
    
    dbms_lob.freetemporary(l_err_clob); 
    

exception when others then
    logger.error(substr(G_DBGCODE || to_char(p_s, 'ddmmyyyy') || p_corpc || sqlerrm || dbms_utility.format_error_backtrace(), 1, 4000));
    log_err(3, l_sync, l_err_clob);
    rollback;
    dbms_lob.freetemporary(l_err_clob);
    raise_application_error(-20000, dbms_utility.format_error_backtrace || ' ' || sqlerrm);
END lic26_kfile;


 function get_all_units(p_acc accounts.acc%type) return t_units pipelined is
     cursor posible_units(p_root ob_corporation.id%type) is
         select t.id, t.corporation_name
           from ob_corporation t
          where t.state_id <> c_ob_state_closed
          start with id = p_root
         connect by prior id = parent_id;
     l_unit        r_unit;
     l_root        ob_corporation.id%type;
     l_units       t_units;
     l_corp_ext_id varchar(2);
 begin
     select c.value
       into l_corp_ext_id
       from customerw c
       join accounts a
         on a.rnk = c.rnk
      where c.tag = 'OBPCP'
        and a.acc = p_acc;
 
     select max(id) keep(dense_rank last order by level)
       into l_root
       from ob_corporation t
      start with id = l_corp_ext_id
     connect by id = prior parent_id;
 
     open posible_units(l_root);
     fetch posible_units bulk collect
         into l_units;
     close posible_units;
 
     if nvl(l_units.count, 0) <> 0 then
         for i in l_units.first .. l_units.last loop
             l_unit.id   := l_units(i).id;
             l_unit.name := l_units(i).name;
             pipe row(l_unit);
         end loop;
     end if;
 exception when others then
    logger.error(substr(G_DBGCODE || ' - ' || sqlerrm || dbms_utility.format_error_backtrace(), 1, 4000));
    raise_application_error(-20000, dbms_utility.format_error_backtrace || ' ' || sqlerrm);
 end;
-------------------------------------------------------------------------------------

 procedure add_corp(p_corporation_code ob_corporation.corporation_code%type,
                    p_corporation_name ob_corporation.corporation_name%type,
                    p_parent_id        ob_corporation.parent_id%type default null,
                    p_external_id      ob_corporation.external_id%type) is
     l_corporation_id  ob_corporation.id%type;
     l_corporation_row ob_corporation%rowtype;
     res               number;
 begin
 
     if p_parent_id is null then
         --корневая корпорация
         begin
             select 1
               into res
               from v_root_corporation t
              where p_external_id = t.external_id;
             --нашли - ругаемся
             raise_application_error(-20300,
                                     'Підрозділ з таким ідентифікатором вже існує');
         exception
             when no_data_found then
                 null; --не нашли - все нормально
         end;
     else
         --подразделение
         begin
             select 1
               into res
               from v_org_corporations t
              where t.external_id = p_external_id
                and t.base_extid =
                    (select t.base_extid
                       from v_org_corporations t
                      where t.id = p_parent_id); --находим ид корневой корпорации
             raise_application_error(-20300,
                                     'Підрозділ з таким ідентифікатором вже існує');
         exception
             when no_data_found then
                 null;
         end;
     end if;
 
     select s_ob_corporation.nextval into l_corporation_id from dual;
 
     insert into bars.ob_corporation t1
         (t1.id)
     values
         (l_corporation_id)
     returning id into l_corporation_row.id;
 
     if (p_corporation_name is not null) then
         bars.attribute_utl.set_value(l_corporation_row.id,
                                      'CORPORATION_NAME',
                                      p_corporation_name);
     end if;
 
     if (p_corporation_code is not null) then
         bars.attribute_utl.set_value(l_corporation_row.id,
                                      'CORPORATION_CODE',
                                      p_corporation_code);
     end if;
 
     if (p_parent_id is not null) then
         bars.attribute_utl.set_value(l_corporation_row.id,
                                      'CORPORATION_PARENT_ID',
                                      p_parent_id);
     end if;
 
     if (p_external_id is not null) then
         bars.attribute_utl.set_value(l_corporation_row.id,
                                      'CORPORATION_EXTERNAL_ID',
                                      p_external_id);
     end if;
 
     bars.attribute_utl.set_value(l_corporation_row.id,
                                  'CORPORATION_STATE_ID',
                                   c_ob_state_active);
 exception when others then
    logger.error(substr(G_DBGCODE || ' - ' || sqlerrm || dbms_utility.format_error_backtrace(), 1, 4000));
    raise_application_error(-20000, dbms_utility.format_error_backtrace || ' ' || sqlerrm);                                 
 end add_corp;
----------------------------------------------------------------------------------------------------------------------
 procedure edit_corp(p_id               ob_corporation.id%type,
                     p_corporation_code ob_corporation.corporation_code%type,
                     p_corporation_name ob_corporation.corporation_name%type,
                     p_external_id      ob_corporation.external_id%type,
                     p_parent_id        ob_corporation.external_id%type) is
     cursor posible_units(p_id   ob_corporation.external_id%type,
                          p_root ob_corporation.id%type) is
         select t.id, t.corporation_name
           from ob_corporation t
          where t.state_id <> c_ob_state_closed
          start with id = p_root
         connect by prior id = parent_id
         minus
         select t.id, t.corporation_name
           from ob_corporation t
          where t.state_id <> c_ob_state_closed
          start with id = p_id
         connect by prior id = parent_id;
     l_root            ob_corporation.id%type;
     l_units           t_units;
     l_exists          boolean := false;
     l_corporation_row ob_corporation%rowtype;
     l_parent_id       number;
     res               number;
 begin
     begin
         select t1.*
           into l_corporation_row
           from ob_corporation t1
          where t1.id = p_id;
     exception
         when no_data_found then
             raise_application_error(-20101,
                                     'Не знайдено підрозділ корпорації з кодом ' ||
                                     to_char(p_id));
     end;
 
     if l_corporation_row.parent_id is null then
         --корневая корпорация
         begin
             select 1
               into res
               from v_root_corporation t
              where p_external_id = t.external_id
                and p_id != t.id;
             --нашли - ругаемся
             raise_application_error(-20300,
                                     'Підрозділ з таким ідентифікатором вже існує');
         exception
             when no_data_found then
                 null; --не нашли - все нормально
         end;
     else
         --подразделение
         begin
             select 1
               into res
               from v_org_corporations t
              where t.external_id = p_external_id
                and p_id != t.id
                and t.base_extid =
                    (select t.base_extid
                       from v_org_corporations t
                      where l_corporation_row.parent_id = t.id); --находим ид корневой корпорации
             raise_application_error(-20300,
                                     'Підрозділ з таким ідентифікатором вже існує');
         exception
             when no_data_found then
                 null;
         end;
     end if;
 
     if (p_corporation_name <> l_corporation_row.corporation_name or
        (p_corporation_name is null and
        l_corporation_row.corporation_name is not null) or
        (p_corporation_name is not null and
        l_corporation_row.corporation_name is null)) then
         bars.attribute_utl.set_value(l_corporation_row.id,
                                      'CORPORATION_NAME',
                                      p_corporation_name);
     end if;
 
     if (p_corporation_code <> l_corporation_row.corporation_code or
        (p_corporation_code is null and
        l_corporation_row.corporation_code is not null) or
        (p_corporation_code is not null and
        l_corporation_row.corporation_code is null)) then
         bars.attribute_utl.set_value(l_corporation_row.id,
                                      'CORPORATION_CODE',
                                      p_corporation_code);
     end if;
 
     if (p_external_id <> l_corporation_row.external_id or
        (p_external_id is null and
        l_corporation_row.external_id is not null) or
        (p_external_id is not null and
        l_corporation_row.external_id is null)) then
         bars.attribute_utl.set_value(l_corporation_row.id,
                                      'CORPORATION_EXTERNAL_ID',
                                      p_external_id);
     end if;
 
     select max(id) keep(dense_rank last order by level)
       into l_root
       from ob_corporation t
      start with id = p_id
     connect by id = prior parent_id;
 
     begin
         select id
           into l_parent_id
           from v_ob_corp_l1 c
          where c.base_extid = l_root
            and c.ext_id = p_parent_id;
     exception
         when no_data_found then
             null;
     end;
     select count(*)
       into res
       from v_ob_corp_l1 c
      where c.parent_id = l_parent_id
        and c.id = p_id;
     if res = 0 and p_parent_id is not null then
         open posible_units(p_id, l_root);
         fetch posible_units bulk collect
             into l_units;
         close posible_units;
     
         if nvl(l_units.count, 0) <> 0 then
             for i in l_units.first .. l_units.last loop
                 if l_parent_id = l_units(i).id then
                     l_exists := true;
                     exit;
                 end if;
             end loop;
         end if;
     
         if l_exists then
             update ob_corporation
                set parent_id = l_parent_id
              where id = p_id;
         else
             raise_application_error(-20000,
                                     'Невірний батьківський підрозділ!');
         end if;
     end if;
 exception when others then
    logger.error(substr(G_DBGCODE || ' - ' || sqlerrm || dbms_utility.format_error_backtrace(), 1, 4000));
    raise_application_error(-20000, dbms_utility.format_error_backtrace || ' ' || sqlerrm);
 end edit_corp;
--------------------------------------------------------------------------------------
 procedure lock_corp_item(p_unit_id ob_corporation.id%type) is
     cursor cur_corp is
         select s.id
           from ob_corporation s
          where s.state_id = c_ob_state_active
          start with id = p_unit_id
         connect by prior id = parent_id;
 begin
     if get_corp_state(p_unit_id) = c_ob_state_active then
         for corp in cur_corp loop
             bars.attribute_utl.set_value(corp.id,
                                          'CORPORATION_STATE_ID',
                                          c_ob_state_locked);
         end loop;
     else
         raise_application_error(-20000,
                                 'Невідповідність статусів!');
     end if;
 exception when others then
    logger.error(substr(G_DBGCODE || ' - ' || sqlerrm || dbms_utility.format_error_backtrace(), 1, 4000));
    raise_application_error(-20000, dbms_utility.format_error_backtrace || ' ' || sqlerrm);
 end;
------------------------------------------------------------------------------------
 procedure unlock_corp_item(p_unit_id ob_corporation.id%type) is
     cursor cur_corp is
         select s.id
           from ob_corporation s
          where s.state_id = c_ob_state_locked
          start with id = p_unit_id
         connect by prior parent_id = id;
 begin
     if get_corp_state(p_unit_id) = c_ob_state_locked then
         for corp in cur_corp loop
             bars.attribute_utl.set_value(corp.id,
                                          'CORPORATION_STATE_ID',
                                          c_ob_state_active);
         end loop;
     else
         raise_application_error(-20000,
                                 'Невідповідність статусів!');
     end if;
 exception when others then
    logger.error(substr(G_DBGCODE || ' - ' || sqlerrm || dbms_utility.format_error_backtrace(), 1, 4000));
    raise_application_error(-20000, dbms_utility.format_error_backtrace || ' ' || sqlerrm);
 end;
 
---------------------------------------------------------------------------------------
 procedure close_corp_item(p_unit_id ob_corporation.id%type) is
     cursor cur_corp is
         select s.id
           from ob_corporation s
          where s.state_id <> c_ob_state_closed
          start with id = p_unit_id
         connect by prior id = parent_id;
 begin
     if get_corp_state(p_unit_id) <> c_ob_state_closed then
         for corp in cur_corp loop
             bars.attribute_utl.set_value(corp.id,
                                          'CORPORATION_STATE_ID',
                                          c_ob_state_closed);
         end loop;
     else
         raise_application_error(-20000,
                                 'Невідповідність статусів!');
     end if;
 exception when others then
    logger.error(substr(G_DBGCODE || ' - ' || sqlerrm || dbms_utility.format_error_backtrace(), 1, 4000));
    raise_application_error(-20000, dbms_utility.format_error_backtrace || ' ' || sqlerrm);
 end;
 
--------------------------------------------------виборка корпорації(PIPELINED)
 function get_possible_units(p_id_unit ob_corporation.id%type)
     return t_units
     pipelined is
     cursor posible_units(p_id   ob_corporation.external_id%type,
                          p_root ob_corporation.id%type) is
         select external_id, corporation_name
           from (select t.id, t.external_id, t.corporation_name
                   from ob_corporation t
                  where t.state_id <> c_ob_state_closed
                  start with id = p_root
                 connect by prior id = parent_id
                 minus
                 select t.id, t.external_id, t.corporation_name
                   from ob_corporation t
                  where t.state_id <> c_ob_state_closed
                  start with id = p_id
                 connect by prior id = parent_id)
          order by to_number(id);
     l_unit  r_unit;
     l_root  ob_corporation.id%type;
     l_units t_units;
 begin
     select max(id) keep(dense_rank last order by level)
       into l_root
       from ob_corporation t
      start with id = p_id_unit
     connect by id = prior parent_id;
 
     open posible_units(p_id_unit, l_root);
     fetch posible_units bulk collect
         into l_units;
     close posible_units;
 
     if nvl(l_units.count, 0) <> 0 then
         for i in l_units.first .. l_units.last loop
             l_unit.id   := l_units(i).id;
             l_unit.name := l_units(i).name;
             pipe row(l_unit);
         end loop;
     end if;
 exception when others then
    logger.error(substr(G_DBGCODE || ' - ' || sqlerrm || dbms_utility.format_error_backtrace(), 1, 4000));
    raise_application_error(-20000, dbms_utility.format_error_backtrace || ' ' || sqlerrm);
 end;
----------------------------------------------------------------------оновлення PARENT_ID корпорації


--процедура обновлениџ счетов корпоративных клиентов(обновлџет включение в выписку, код Х¬јј, код подразделениџ, дату открытиџ и альтернат. корпорацию)
 procedure update_acc_corp(p_acc      number,
                           p_invp     varchar2,
                           p_trkk     varchar2,
                           p_sub_corp varchar2,
                           p_alt_corp varchar2,
                           p_daos     date) as
     l_daos  date;
     l_obpcp varchar2(500);
     res     number;
     --l_obcrp varchar2(500);
 begin
 
     --дата відкриття
     /*select daos into l_daos from accounts t where t.acc = p_acc;
     if (l_daos <> p_daos and p_daos is not null) then
         update accounts t set t.daos = p_daos where t.acc = p_acc;
     elsif p_daos is null then
         raise_application_error(-20000,
                                 'Поле дата відкриття порожнє!!');
     end if;*/
 
     --выписка
     if p_invp in ('Y', 'N') then
         update accountsw t
            set t.value = p_invp
          where t.acc = p_acc
            and t.tag = 'CORPV';
         if sql%rowcount = 0 then
             insert into accountsw t
                 (acc, tag, value)
             values
                 (p_acc, 'CORPV', p_invp);
         end if;
     else
         raise_application_error(-20000,
                                 'Значення поля включення до виписки можуть приймати значення Y або N');
     end if;
 
     --trkk код
     begin
         select count(*) into res from typnls_corp t where t.kod = p_trkk;
     exception
         when no_data_found then
             null;
     end;
     if (res <> 0 or p_trkk is null) then
         update specparam_int t set t.typnls = p_trkk where t.acc = p_acc;
         if sql%rowcount = 0 then
             insert into specparam_int t
                 (acc, typnls)
             values
                 (p_acc, p_trkk);
         end if;
     elsif (res = 0) then
         raise_application_error(-20000,
                                 'Код ТРКК відсутній в довіднику!!');
     end if;
     --get customer corp_code and inst_code
     select cw1.value
       into l_obpcp
       from accounts a
       join customerw cw1
         on a.rnk = cw1.rnk
        and cw1.tag = 'OBPCP'
      where a.acc = p_acc;
 
     --проверим, есть ли такое подразделение у корпорации клиента или альтернативной корпорации
     begin
         select 1
           into res
           from v_org_corporations t
          where (t.base_extid = l_obpcp or t.base_extid = p_alt_corp)
            and rownum = 1
            and t.external_id = p_sub_corp;
         --јод установи
         update accountsw t
            set t.value = p_sub_corp
          where t.acc = p_acc
            and t.tag = 'OBCORPCD';
         if sql%rowcount = 0 then
             insert into accountsw t
                 (acc, tag, value)
             values
                 (p_acc, 'OBCORPCD', p_sub_corp);
         end if;
     exception
         when no_data_found then
             raise_application_error(-20500,
                                     'В довіднику віднсутній підрозділ ' ||
                                     p_sub_corp ||
                                     ' з основною корпорацією ' || l_obpcp ||
                                     ' або альтернитивною корпорацією ' ||
                                     p_alt_corp);
     end;
 
     --альтернатива
     select count(*)
       into res
       from v_root_corporation t
      where t.external_id = p_alt_corp;
 
     --check, if alt_corp != customer's corp
     if (l_obpcp != p_alt_corp and res <> 0) or p_alt_corp is null then
         update ACCOUNTSW t
            set t.VALUE = p_alt_corp
          where t.ACC = p_acc
            and t.TAG = 'obcorp';
         if SQL%rowcount = 0 then
             insert into accountsw t
                 (acc, tag, value)
             values
                 (p_acc, 'obcorp', p_alt_corp);
         end if;
     else
         raise_application_error(-20500,
                                 'код альтернативної ' || p_alt_corp ||
                                 ' корпорації не знайдено в довіднику корпорацій!!');
     end if;
 exception when others then
    logger.error(substr(G_DBGCODE || ' - ' || sqlerrm || dbms_utility.format_error_backtrace(), 1, 4000));
    raise_application_error(-20000, dbms_utility.format_error_backtrace || ' ' || sqlerrm); 
 end update_acc_corp;
-----------------------------------------------------------------------------

   -- возвращает общую сумму остатков за период по календарным днџм (учитываџ первую и последнюю даты)
   -- (используетсџ в дальнейшем к примеру длџ расчета средневзвешенного остатка период)
 function kf_ost_sum(p_corp_id    in number,
                     p_nbs        in varchar2,
                     p_kv_flag    in number, --0 - всі валюти, 1 - гривні, 2 - всі крім гривні)
                     p_kod_analyt in varchar2,
                     p_date_start in date,
                     p_date_end   in date,
                     p_rep_id     in number) return measure_table
     pipelined is
     rec        measure_record;
     l_sum      ob_corp_data_acc.ostq%type := 0;
     l_kf       ob_corp_data_acc.kf%type;
     l_dat      ob_corp_data_acc.fdat%type;
     l_last_zn  ob_corp_data_acc.ostq%type := 0;
     l_dat_loop ob_corp_data_acc.fdat%type;
     l_d_sql    clob;
     l_ref_cur  sys_refcursor;
     type l_my_tab is table of number index by varchar2(255);
     l_rec     l_my_tab;
     date_diff decimal;
 begin
     --  менџем первую дату периода (если перваџ дата в ob_corporation_data больше, чем перваџ дата периода)
     -- устанавливаем предельную дату длџ суммированиџ = второй дате периода
     -- не имеет значениџ есть ли такаџ дата в ob_corporation_data, если еще не наступила,
     -- то будет прогнозный расчет cо значением остатка=текущему
     -- суммируем в выбранном периоде остатки
     l_d_sql := 'SELECT SUM(cd.ostq-cd.obkrq+cd.obdbq) as suma, CD.kf, cd.fdat
                       FROM ob_corp_data_acc cd
                      WHERE cd.is_last = 1 
                        AND CD.CORP_ID = :P_CORP_ID
                        AND substr(CD.NLS,1,4) = :P_NBS' || case
                    when p_kv_flag = 1 then
                     ' AND CD.KV = 980 '
                    when p_kv_flag = 2 then
                     ' AND CD.KV <> 980 '
                    else
                     ' '
                end || case
                    when p_kod_analyt <> '%' then
                     ' AND :P_KOD_ANALYT = CD.KOD_ANALYT '
                    else
                     ' '
                end ||
                'AND cd.fdat >= :P_DATE_START
                        AND cd.fdat <= :P_DATE_END +10
                        group by cd.kf, cd.fdat
                        order by CD.kf asc, cd.fdat desc';
     if p_kod_analyt <> '%' then
         open l_ref_cur for l_d_sql
             using p_corp_id, p_nbs, p_kod_analyt, p_date_start, p_date_end;
     else
         open l_ref_cur for l_d_sql
             using p_corp_id, p_nbs, p_date_start, p_date_end;
     end if;
     loop
         fetch l_ref_cur
             into l_sum, l_kf, l_dat;
         if l_kf is not null and l_dat is not null then
             l_rec(l_kf || to_char(l_dat, 'ddmmyyyy')) := l_sum;
         end if;
         exit when l_ref_cur%notfound;
     end loop;
     close l_ref_cur;
 
     for l_kf_k in (select kf from clim_mfo) loop
         l_dat_loop := p_date_end + 10;
         l_last_zn  := 0;
         l_sum      := 0;
         date_diff  := 0;
         while l_dat_loop >= p_date_start loop
             if l_rec.exists(l_kf_k.kf || to_char(l_dat_loop, 'ddmmyyyy')) then
                 l_last_zn := l_rec(l_kf_k.kf ||
                                    to_char(l_dat_loop, 'ddmmyyyy'));
             end if;
             if l_dat_loop <= p_date_end then
                 l_sum     := l_sum + l_last_zn;
                 date_diff := date_diff + 1;
             end if;
             l_dat_loop := l_dat_loop - 1;
         end loop;
         begin
             rec.kf      := l_kf_k.kf;
             rec.ost_sum := trunc(l_sum / 100 / date_diff, 2); -- /100 - в гривны; /date_diff - среднее за период;
             pipe row(rec);
         exception
             when zero_divide then
                 raise_application_error(-20001,
                                         'Відсутні данні за вказаний період');
         end;
     end loop;
     return;
 exception
     when others then
         close l_ref_cur;
         logger.error(substr(G_DBGCODE || ' - ' || sqlerrm || dbms_utility.format_error_backtrace(), 1, 4000));
         raise_application_error(-20000, dbms_utility.format_error_backtrace || ' ' || sqlerrm);
 end kf_ost_sum;

------------------------------------------------------------------------------------------------------------
   -- возвращает общую сумму остатков за период по календарным днџм (учитываџ первую и последнюю даты)
   -- (используетсџ в дальнейшем к примеру длџ расчета средневзвешенного остатка период)
 function kf_ost_sum_ustan(p_corp_id    in number,
                           p_nbs        in varchar2,
                           p_kv_flag    in number, --0 - всі валюти, 1 - гривні, 2 - всі крім гривні)
                           p_kod_analyt in varchar2,
                           p_date_start in date,
                           p_date_end   in date,
                           p_rep_id     in number) return measure_table_2
    pipelined is
    rec        measure_record_2;
    l_sum      ob_corp_data_acc.ostq%type := 0;
    l_k_ust    ob_corp_data_acc.kod_ustan%type;
    l_dat      ob_corp_data_acc.fdat%type;
    l_last_zn  ob_corp_data_acc.ostq%type := 0;
    l_dat_loop ob_corp_data_acc.fdat%type;
    l_d_sql    clob;
    l_ref_cur  sys_refcursor;
    type l_my_tab is table of number index by varchar2(255);
    l_rec     l_my_tab;
    date_diff decimal;
 begin
    --  менџем первую дату периода (если перваџ дата в ob_corporation_data больше, чем перваџ дата периода)
    -- устанавливаем предельную дату длџ суммированиџ = второй дате периода
    -- не имеет значениџ есть ли такаџ дата в ob_corporation_data, если еще не наступила,
    -- то будет прогнозный расчет cо значением остатка=текущему
    -- суммируем в выбранном периоде остатки
    l_d_sql := 'SELECT SUM(cd.ostq-cd.obkrq+cd.obdbq) as suma, CD.KOD_USTAN, cd.fdat
                     FROM ob_corp_data_acc cd                   
                    WHERE cd.is_last = 1 
                      AND CD.CORP_ID = :P_CORP_ID
                      AND substr(CD.NLS,1,4) = :P_NBS ' || case
                   when p_kv_flag = 1 then
                    'AND CD.KV = 980 '
                   when p_kv_flag = 2 then
                    'AND CD.KV <> 980 '
                   else
                    ' '
               end || case
                   when p_kod_analyt <> '%' then
                    'AND :P_KOD_ANALYT = CD.KOD_ANALYT '
                   else
                    ' '
               end || ' 
                      AND cd.fdat >= :P_DATE_START
                      AND cd.fdat <= :P_DATE_END +10
                    group by cd.KOD_USTAN, cd.fdat
                    order by CD.KOD_USTAN asc, cd.fdat desc';

    if p_kod_analyt <> '%' then
        open l_ref_cur for l_d_sql
            using p_corp_id, p_nbs, p_kod_analyt, p_date_start, p_date_end;
    else
        open l_ref_cur for l_d_sql
            using p_corp_id, p_nbs, p_date_start, p_date_end;
    end if;
    loop
        fetch l_ref_cur
            into l_sum, l_k_ust, l_dat;
        if l_k_ust is not null and l_dat is not null then
            l_rec(l_k_ust || to_char(l_dat, 'ddmmyyyy')) := l_sum;
        end if;
        exit when l_ref_cur%notfound;
    end loop;
    close l_ref_cur;

    for k_ust_c in (select c.external_id
                      from ob_corporation c
                     where c.parent_id = p_corp_id) loop
        l_dat_loop := p_date_end + 10;
        l_last_zn  := 0;
        l_sum      := 0;
        date_diff  := 0;
        while l_dat_loop >= p_date_start loop
            if l_rec.exists(k_ust_c.external_id ||
                            to_char(l_dat_loop, 'ddmmyyyy')) then
                l_last_zn := l_rec(k_ust_c.external_id ||
                                   to_char(l_dat_loop, 'ddmmyyyy'));
            end if;
            if l_dat_loop <= p_date_end then
                l_sum     := l_sum + l_last_zn;
                date_diff := date_diff + 1;
            end if;
            l_dat_loop := l_dat_loop - 1;
        end loop;
        begin
            rec.kod_ustan := k_ust_c.external_id;
            rec.ost_sum   := trunc(l_sum / 100 / date_diff, 2); -- /100 - в гривны; /date_diff - среднее за период;
            pipe row(rec);
        exception
            when zero_divide then
                raise_application_error(-20001,
                                        'Відсутні данні за вказаний період');
        end;
    end loop;

    return;
exception
    when others then
    close l_ref_cur;
    logger.error(substr(G_DBGCODE || ' - ' || sqlerrm || dbms_utility.format_error_backtrace(), 1, 4000));
    raise_application_error(-20000, dbms_utility.format_error_backtrace || ' ' || sqlerrm);
 end kf_ost_sum_ustan;

-------------------------------------------------вставка в customerw
procedure ins_customerw (p_rnk customerw.rnk%type,p_external_id varchar2, p_org_id varchar2)
is
 begin

      insert into customerw(rnk, tag, value, isp) values (p_rnk, 'OBPCP', p_external_id, 0);
      insert into customerw(rnk, tag, value, isp) values (p_rnk, 'OBCRP', p_org_id, 0);
 exception
    when others then
    logger.error(substr(G_DBGCODE || ' - ' || sqlerrm || dbms_utility.format_error_backtrace(), 1, 4000));
    raise_application_error(-20000, dbms_utility.format_error_backtrace || ' ' || sqlerrm); 
 end;


BEGIN
   -- Initialization
   NULL;
END KFILE_PACK;
/
