
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/sync.sql =========*** Run *** ======
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.SYNC 
is
   --
   --  SYNC
   --  Модуль передачі даних між БД РУ та ЦА
   --

   g_header_version    constant varchar2 (64) := 'version 1.00.01 20/07/2015';
   g_awk_header_defs   constant varchar2 (512) := '';

   --------------------------------------------------------------------------------
   -- Типи
   --

   --------------------------------------------------------------------------------
   -- Константи
   --
   --------------------------------------------------------------------------------
   -- Глобальні константи
   --

   --------------------------------------------------------------------------------
   -- Глобальні змінні
   --

   --------------------------------------------------------------------------------
   -- header_version - повертає версію заголовка пакету
   --
   function header_version return varchar2;

   --------------------------------------------------------------------------------
   -- body_version - повертає версію тіла пакету
   --
   function body_version return varchar2;

   function get_table_names(p_tab varchar2) return varchar2;

   function get_table_types(p_tab varchar2) return varchar2;

   procedure execute_script(p_service_name in varchar2, p_data out clob);

   function f_sync_transmit (p_service_name in varchar2, p_server_ip in varchar2 := null) return varchar2;

   procedure data_load(p_tab varchar2, p_data clob);

   procedure sync_parse(p_params in clob, p_in_data in clob, p_out_data out clob, p_error out clob, p_status out number);

   function convert_to_base64(p_clob clob) return clob;

   function convert_from_base64(p_clob clob) return clob;

END sync;
/
CREATE OR REPLACE PACKAGE BODY BARS.SYNC 
is
   --
   --  SYNC
   --

   --g_body_version       constant varchar2 (64) := 'version 1.00.01 17/07/2015';
   g_body_version       constant varchar2 (64) := 'version 1.00.02 01/12/2015';
   g_awk_body_defs      constant varchar2 (512) := '';
   g_trace_module       constant varchar2(10) := 'sync.';

   g_REAL_webserver_IP  constant varchar2(64) := 'https://mmfo-web.oschadbank.ua';
   g_TEST_webserver_IP  constant varchar2(64) := 'http://10.1.81.245';

   g_sync_url    varchar2(200);
   g_wallet_dir  varchar2(64);
   g_wallet_pass varchar2(64);

   --------------------------------------------------------------------------------
   -- header_version - повертає версію заголовка пакету
   --
   function header_version return varchar2
   is
   begin
      return    'Package header SYNC '
             || g_header_version
             || '.'
             || CHR (10)
             || 'AWK definition: '
             || CHR (10)
             || g_awk_header_defs;
   end header_version;

   --------------------------------------------------------------------------------
   -- body_version - повертає версію тіла пакету
   --
   function body_version return varchar2
   is
   begin
      return    'Package body SYNC '
             || g_body_version
             || '.'
             || CHR (10)
             || 'AWK definition: '
             || CHR (10)
             || g_awk_body_defs;
   end body_version;

function get_table_names(p_tab varchar2) return varchar2
is
  l_txt varchar2(4000):='(';
begin
  if p_tab is null then return ''; end if;
  for l in (select column_name from user_tab_columns where table_name=upper(p_tab) order by column_id asc) loop
    l_txt:=l_txt||case when l_txt='(' then ' ' else ', ' end||l.column_name;
  end loop;
  return l_txt||' )';
end get_table_names;

function get_table_types(p_tab varchar2) return varchar2
is
  l_txt varchar2(4000):=null;
begin
  if p_tab is null then return ''; end if;
  for l in (select column_id, data_type from user_tab_columns where table_name=upper(p_tab) order by column_id) loop
    l_txt:=l_txt||case when l_txt is null then ' #' else ', #' end;
    case l.data_type when 'VARCHAR2' then l_txt:=l_txt||to_char(l.column_id, 'fm00')||'#'||' STR';
                     when 'NUMBER' then l_txt:=l_txt||to_char(l.column_id, 'fm00')||'#'||' NUM';
                     when 'DATE' then l_txt:=l_txt||to_char(l.column_id, 'fm00')||'#'||' DAT';
                     when 'RAW' then l_txt:=l_txt||to_char(l.column_id, 'fm00')||'#'||' RAW';
                     else l_txt:=l_txt||to_char(l.column_id, 'fm00')||' ???';
    end case;
  end loop;
  return l_txt;
end get_table_types;

  --------------------------------------------------------------------------------
  -- extract_from_xml - отримати значення з xml
  --
  function extract_from_xml(p_xml in xmltype, p_xpath in varchar2, p_default in varchar2) return clob is
  begin
    return p_xml.extract(p_xpath).getClobVal();
  exception
    when others then
      if sqlcode = -30625 then
        return p_default;
      else
        raise;
      end if;
  end extract_from_xml;

  ------------------------------------------------------------------------------
  -- кодування стрічки у base64
  --
  function convert_to_base64(p_clob clob) return clob is
    l_clob clob;
    l_step pls_integer := 48*250; -- make sure you set a multiple of 3 not higher than 24573
  begin
    dbms_lob.createtemporary(l_clob, false);
    for i in 0 .. trunc((dbms_lob.getlength(p_clob) - 1) / l_step) loop
      dbms_lob.append(l_clob, utl_raw.cast_to_varchar2(utl_encode.base64_encode(utl_raw.cast_to_raw(dbms_lob.substr(p_clob, l_step, i * l_step + 1)))));
    end loop;
    return l_clob;
  end;

  ------------------------------------------------------------------------------
  -- декодування стрічки з base64
  --
  function convert_from_base64(p_clob clob) return clob is
    l_clob clob;
    l_step pls_integer; -- make sure you set a multiple of 3 not higher than 24573
    l_n number;
    l_len number;
  begin
    l_step:=250*dbms_lob.instr(p_clob, chr(10)); if l_step=0 then l_step:=250*66; end if;
    l_len:= dbms_lob.getlength(p_clob); l_n:=1; dbms_lob.createtemporary(l_clob, false);
    while  l_n<=l_len loop
      dbms_lob.append(l_clob, utl_raw.cast_to_varchar2(utl_encode.base64_decode(utl_raw.cast_to_raw(dbms_lob.substr(p_clob, l_step, l_n)))));
      l_n:=l_n+l_step;
    end loop;
    return l_clob;
  end;

procedure transmit_action(p_sync_url in varchar2, l_params in clob, l_in_data in clob, l_out_data out clob, l_error out clob, l_status out number)
  is
    l_request    soap_rpc.t_request;
    l_response   soap_rpc.t_response;
    l_xml        xmltype;
    l_clob       clob;
begin
  --sync_parse(convert_to_base64(l_params), convert_to_base64(l_in_data), l_out_data, l_error, l_status);--

  begin
    select val into g_wallet_dir from birja where par = 'Wlt_dir';
    select val into g_wallet_pass from birja where par = 'Wlt_pass';
  exception
    when no_data_found then null; -- поки давимо
  end;

  -- запрос на вызов сервиса
  l_request := soap_rpc.new_request(p_url => p_sync_url, p_namespace => 'http://tempuri.org/', p_method => 'TransmitAction', p_wallet_dir => g_wallet_dir, p_wallet_pass => g_wallet_pass);

  -- параметри
  soap_rpc.add_parameter(l_request, 'in_params', convert_to_base64(l_params));
  soap_rpc.add_parameter(l_request, 'in_data', convert_to_base64(l_in_data));
  -- виклик сервісу
  bars_audit.info('SYNC_TRANSMIT Step0 '||user_name||'  '||to_char(sysdate, 'yyyy/mm/dd HH24:MI:SS')||chr(13)||l_params);
  l_response := soap_rpc.invoke(l_request);

  -- разбираем ответ
  l_clob := replace(l_response.doc.getClobVal(), 'xmlns', 'mlns');
  l_xml  := xmltype(l_clob);
  l_status := to_number(extract_from_xml(l_xml, '/TransmitActionResponse/TransmitActionResult/Status/text()', null));
  l_error := extract_from_xml(l_xml, '/TransmitActionResponse/TransmitActionResult/ErrorMessage/text()', null);
  l_out_data := extract_from_xml(l_xml, '/TransmitActionResponse/TransmitActionResult/StrData/text()', null);
  l_error := convert_from_base64(l_error); l_out_data := convert_from_base64(l_out_data);
end;

procedure execute_script(p_service_name in varchar2, p_data out clob)
is
  l_query varchar2(24000);
  l_query_types varchar2(4000);
  l_query_names varchar2(4000);

  l_n number;
  l_n1 number;
  l_n2 number;
  l_m1 number;
  l_m2 number;
  l_ms1 varchar2(4);
  l_ms2 varchar2(3);
  l_q varchar2(32000);
  l_qn varchar2(32000):='select ';

  l_txt varchar2(32000);
  type t_d is ref cursor;
  l_d t_d;
begin
  dbms_lob.createtemporary(p_data, false);
  select query, query_types, query_names into l_query, l_query_types, l_query_names from sync_metadata where service_name=p_service_name;
  if l_query is not null then
    for l in (select * from sync_params where params != 'SERVICE_NAME') loop
      l_query:=replace(l_query, l.params, case when l.type='DATE' then 'to_date('''||l.value||''', ''dd/mm/yyyy'')'
                                               when l.type='DATETIME' then 'to_date('''||l.value||''', ''dd/mm/yyyy HH24:MI:SS'')'
                                               when l.type='STR' then ''''||l.value||''''
                                               else l.value end);
    end loop;
    l_n1:=instr(upper(l_query),'FROM'); l_n2:=instr(upper(l_query),'SELECT')+6; l_q:=substr(l_query, l_n2, l_n1-l_n2); l_n:=1;
    l_m1:=length(l_query_types); l_m2:=2;
    while l_m2<l_m1 loop
      l_ms1:=substr(l_query_types, l_m2, 4); l_ms2:=substr(l_query_types, l_m2+5, 3); l_m2:=l_m2+10;
      l_n2:=instr(l_q, ',', l_n); if l_n2=0 then l_n2:=l_n1; end if;
      l_qn:=l_qn||''' '||l_ms1||' ''||'||case when l_ms2 in ('NUM', 'DAT') then 'to_char(' else 'replace(' end||trim(' ' from substr(l_q, l_n, l_n2-l_n))||
            case l_ms2 when 'NUM' then ', ''fm999999999999'')' when 'DAT' then ', ''yyyy/mm/dd HH24:MI:SS'')'  else ', ''#'', ''##'')' end||'||';
      l_n:=l_n2+1;
    end loop;
    l_query:=l_qn||'''###'' '||substr(l_query,l_n1);
    dbms_lob.append(p_data, l_query_names||'###'||l_query_types||'###'); l_n:=0;
    open l_d for l_query;
    loop
      fetch l_d into l_txt; exit when l_d%notfound;
      dbms_lob.append(p_data, replace(l_txt, chr(13), '###'));
      l_n:=l_n+1;
    end loop;
    if l_n=0 then dbms_lob.trim(p_data, 0); dbms_lob.append(p_data, 'NULL'); end if;
  else
    dbms_lob.append(p_data, 'NULL');
  end if;
end execute_script;

procedure data_load(p_tab in varchar2, p_data in clob)
is
  l_name varchar2(4000);
  l_type varchar2(4000);
  l_fk varchar2(32);
  l_n1 number;
  l_n2 number;
  len number;
  l_str varchar2(24000);
  type t_mark is record (key varchar2(6), type varchar2(100));
  type t_m is table of t_mark index by binary_integer;
  m t_m;
  m_count number;
  l_txt1 varchar2(4000);
  l_txt2 varchar2(4000);
begin
  l_str:=dbms_lob.substr(p_data, 4, 1); if l_str='NULL' then return; end if; l_str:='';

  l_n1:=dbms_lob.instr(p_data, '###'); l_name:=dbms_lob.substr(p_data, l_n1-1, 1);
  l_n2:=dbms_lob.instr(p_data, '###', l_n1+1); l_type:=dbms_lob.substr(p_data, l_n2-l_n1-3, l_n1+3);
  l_fk:='###'||substr(l_type, instr(l_type, ' #'), 6); len:=length(l_type); l_n1:=1; m_count:=0;
  while l_n1<len loop
     m_count:=m_count+1; l_n1:=instr(l_type,' #',l_n1);
     m(m_count).key:=substr(l_type,l_n1,6); m(m_count).type:=substr(l_type,l_n1+6,3);
     l_n1:=l_n1+9;
  end loop;

  len:=DBMS_LOB.GETLENGTH(p_data);
  while 0<l_n2 and l_n2<len loop
    l_n1:=dbms_lob.instr(p_data, l_fk, l_n2); l_n2:=dbms_lob.instr(p_data, l_fk, l_n1+1);
    l_str:=dbms_lob.substr(p_data, case when l_n2=0 then len-2 else l_n2 end-l_n1-3, l_n1+3); l_txt2:='';
    l_str:=replace(l_str,'''','''''');
    for i in 1..m_count loop
      l_txt1:=l_txt2;
      case m(i).type when 'NUM' then l_txt2:=case when i<m_count then ', ' else '' end;
                     when 'DAT' then l_txt1:=l_txt1||'to_date('''; l_txt2:=''', ''yyyy/mm/dd HH24:MI:SS'')'||case when i<m_count then ', ' else '' end;
                     else l_txt1:=l_txt1||''''; l_txt2:=''''||case when i<m_count then ', ' else '' end;
      end case;
      l_str:=replace(l_str, m(i).key, l_txt1);
    end loop;

    l_str:=l_str||l_txt2||' )'; l_str:=replace(l_str,', ''''###',', NULL###'); l_str:=replace(l_str,' '''',',' NULL,');
    l_str:=replace(l_str,'###',chr(13)); l_str:=replace(l_str,'##','#');
    l_str:='insert into '||p_tab||' '||l_name||' values ( '||l_str;

    execute immediate l_str;
  end loop;

  commit;
end data_load;

function f_sync_transmit (p_service_name in varchar2, p_server_ip in varchar2 := null) return varchar2
is
  l_n number;
  l_direct varchar2(8);
  l_buf_table varchar2(32);
  l_num number;
  l_dat date;

  l_params clob;
  l_in_data clob;
  l_out_data clob;
  l_error clob;

  l_status number;
  l_txt varchar2(1024);
  l_url varchar2(512);

  l_global_name varchar2(100);
begin
  select count(*), max(direct), max(buf_table) into l_n, l_direct, l_buf_table from sync_metadata where service_name=p_service_name;
  if l_n != 1 then return 'Сервіс '||p_service_name||' не описаний!'; end if;

  if l_direct != 'INIT' then return 'Сервіс '||p_service_name||' описаний від імені відповідача. Запуск ініціюючої функції неможливий!'; end if;
  select count(*) into l_n from sync_params where params='SERVICE_NAME'; if l_n>0 then return 'Сервіс '||p_service_name||' зайнятий!'; end if;
  ---------------------------------------------------------------------------------------------
  select nvl(sum(case when a.params like '%'||b.params||'%' then 1 else 0 end), 0) into l_n
    from sync_params_list a join sync_params_list b on b.params != a.params and b.service_name=p_service_name
   where a.service_name=p_service_name;

  if l_n>0 then return 'Окремі імена параметрів є частиною імені інших параметрів. Така комбінація параметрів WEB-сервісу '||p_service_name||' недопустима!'; end if;
  select count(*) into l_n
    from (select p.params as p
            from sync_params_list t left outer join sync_params p on p.params=t.params
           where t.required=1 and t.service_name=p_service_name) a
   where a.p is null;
  if l_n >0 then return 'Не задані обов`язкові параметри сервісу '||p_service_name||'!'; end if;
  select count(*) into l_n from sync_params;
  if l_n>0 then
    for l in (select p.params, p.value, t.type from sync_params p left outer join sync_params_list t on t.params=p.params and t.service_name=p_service_name) loop
      begin
        if l.type is null then return 'Параметр '||l.params||' відсутній у описі сервісу. Запуск сервісу '||p_service_name||' неможливий!'; end if;
        case l.type
          when 'NUM' then l_num:=to_number(l.value);
          when 'DATE' then l_dat:=to_date(l.value, 'dd/mm/yyyy');
          when 'DATETIME' then l_dat:=to_date(l.value, 'dd/mm/yyyy HH24:MI:SS');
          when 'STR' then l_txt:=l.value;
        end case;
      exception  when others then
        return 'Значення параметру '||l.params||' не відповідає описаному типу '||l.type||' (з врахуванням формату). Запуск сервісу '||p_service_name||' неможливий!';
      end;
      update sync_params set type=l.type where params=l.params;
    end loop;
  end if;
  insert into sync_params (params, type, value) values ('SERVICE_NAME', 'STR', p_service_name);
  select * into l_global_name from global_name;
  --l_global_name:='khrsn72';
  insert into sync_params (params, type, value) values ('GLOBAL_NAME', 'STR', l_global_name);
  insert into sync_params (params, type, value) values ('BANKDATE', 'STR', to_char(bankdate, 'yyyy/mm/dd'));
  commit;

  dbms_lob.createtemporary(l_params, false);
  for l in ( select '( PARAMS, TYPE, VALUE )### #01# STR, #02# STR, #03# STR###' as d from dual
               union all select ' #01# '||replace(replace(params, '#', '##'), chr(13), '###')||' #02# '||type||
                                ' #03# '||replace(replace(value, '#', '##'), chr(13), '###')||'###' from sync_params ) loop
    dbms_lob.append(l_params, l.d);
  end loop;

  begin
    execute_script(p_service_name, l_in_data);
  exception
    when others then
    begin
      l_n:=sqlcode; l_txt:=sqlerrm; return 'При виконанні скрипта відправки даних виникло виключення: '||l_n||' '||l_txt||'!';
    end;
  end;
--insert into tmp_klp_clob (namef, c) values ('outd',l_in_data);
--commit;
  if f_ourmfo<>'300465' then
    if  l_global_name like 'BARSDB%' then
      l_url:= g_REAL_webserver_IP||'/barsroot/cim/services/SyncService.asmx';
    else
      l_url:= g_TEST_webserver_IP||'/barsroot/cim/services/SyncService.asmx';
    end if;
  else
    l_url:=p_server_ip||'/barsroot/cim/services/SyncService.asmx';
  end if;
  dbms_lob.createtemporary(l_out_data, false); dbms_lob.createtemporary(l_error, false);
  /* Передача даних на сторну відповідача*/
  transmit_action(l_url, l_params, l_in_data, l_out_data, l_error, l_status);

  begin
    data_load('sync_errors', l_error);
  exception
    when others then
    begin
      l_n:=sqlcode; l_txt:=sqlerrm; return 'При завантаженні таблиці помилок виникло виключення '||l_n||' '||l_txt||'!';
    end;
  end;

  if l_status != 0 then
    return 'Підчас виклику WEB-сервісу обміну даними виникла помилка ( код: '||l_status||' )!';
  elsif l_buf_table is not null then
    begin
      data_load(l_buf_table, l_out_data);
    exception
      when others then
      begin
        l_n:=sqlcode; l_txt:=sqlerrm; return 'При завантаженні отриманих даних виникло виключення '||l_n||' '||l_txt||'!';
      end;
    end;
  end if;

  delete sync_params; commit;
  return 'Обмін даними успішно завершений.';

end f_sync_transmit;

procedure sync_parse(p_params in clob, p_in_data in clob, p_out_data out clob, p_error out clob, p_status out number)
--p_status: 0 - ok, можна продовжувати, >0 - помилка,яка вимагає припинення передачі
is
  l_n number;
  l_service_name varchar2(32);
  l_direct varchar2(8);
  l_params clob;
  l_in_data clob;

  l_query varchar2(4000);
  l_pre_func varchar2(4000);
  l_post_func varchar2(4000);
  l_buf_table varchar2(128);
  l_txt varchar2(4000);

  l_txt_i varchar2(10);
  l_txt_w varchar2(10);
  l_name_i varchar2(100);
  l_name_w varchar2(100);
  l_sysdate varchar2(32);
  l_err_name varchar2(12);
begin
  l_sysdate:=to_char(l_sysdate, 'yyyy/mm/dd HH24:MI:SS');
  l_params := convert_from_base64(p_params);
  l_in_data := convert_from_base64(p_in_data);

  delete from sync_params;--!!!
  p_status:=0;
  begin
    data_load('SYNC_PARAMS', l_params);
  exception
    when others then
    begin
      p_status:=sqlcode; l_txt:=sqlerrm;
      insert into sync_errors (component, err_txt)
        values('PARSE_ERR','При завантаженні таблиці параметрів виникло виключення: '||p_status||' '||l_txt||'!');
      p_status:=1;
    end;
  end;

  if p_status !=1 then
    select count(*), max(value) into l_n, l_service_name from sync_params where params='SERVICE_NAME';
    if l_n != 1 then
      insert into sync_errors (component, err_txt)
        values('PARSE_ERR','У прийнятих даних відсутня назва WEB-сервісу. Передачу даних припинено!'); p_status:=1;
    end if;
  end if;

  if p_status !=1 then
    select count(*), max(direct) into l_n, l_direct from sync_metadata where service_name=l_service_name;
    if l_n != 1 or l_direct != 'RESPONSE' then  insert into sync_errors (component, err_txt)
       values('PARSE_ERR','Сервіс '||l_service_name||' описаний від імені ініціатора. Передачу даних припинено!'); p_status:=1;
    end if;
  end if;

  if p_status !=1 then
    select * into l_name_w from global_name; select value into l_name_i from sync_params where params='GLOBAL_NAME';
    if l_name_w like 'BARSDB%' then
      if l_name_i like 'BARSDB%' then
        select to_char(bankdate, 'yyyy/mm/dd'), value into l_txt_w, l_txt_i from sync_params where params='BANKDATE';
        if not (l_txt_i=l_txt_w) then
          insert into sync_errors (component, err_txt)
            values('PARSE_ERR', 'Банківська дата ініціатора ('||l_txt_i||') не відповідає банківській даті відповідача ('||l_txt_w||'). Передачу даних припинено!'); p_status:=1;
        end if;
      else
        insert into sync_errors (component, err_txt)
          values('PARSE_ERR', 'Спроба підключення тестової БД ініціатора '||l_name_i||' до реальної БД відповідача '||l_name_w||'. Передачу даних припинено!'); p_status:=1;
      end if;
    else
      if l_name_i like 'BARSDB%' then
        insert into sync_errors (component, err_txt)
          values('PARSE_ERR', 'Спроба підключення реальної БД ініціатора '||l_name_i||' до тестової БД відповідача '||l_name_w||'. Передачу даних припинено!'); p_status:=1;
      end if;
    end if;
  end if;

  if p_status !=1 then
    select query, pre_func, post_func, buf_table into l_query, l_pre_func, l_post_func, l_buf_table from sync_metadata where service_name=l_service_name;
    if l_buf_table is not null then
      begin
        data_load(l_buf_table, l_in_data); commit;
      exception
        when others then
        begin
          p_status:=sqlcode; l_txt:=sqlerrm;
          insert into sync_errors (component, err_txt)
            values('PARSE_ERR','При завантаженні таблиці вхідних даних виникло виключення '||p_status||' '||l_txt||'.');
          delete from tmp_klp_clob where namef like 'IND_%';
          insert into tmp_klp_clob (namef, c) values ('IND_'||to_char(sysdate, 'mmddHH24MI'), l_in_data);
          p_status:=1;
        end;
      end;
    end if;
  end if;

  if p_status != 1 then
    if l_pre_func is not null or l_post_func is not null then
      for l in (select * from sync_params where params != 'SERVICE_NAME') loop
        if l_pre_func is not null then
           l_pre_func:=replace(l_pre_func, l.params, case when l.type='DATE' then 'to_date('''||l.value||''', ''dd/mm/yyyy'')'
                                                          when l.type='DATETIME' then 'to_date('''||l.value||''', ''dd/mm/yyyy HH24:MI:SS'')'
                                                          else l.value end);
        end if;
        if l_post_func is not null then
           l_post_func:=replace(l_post_func, l.params, case when l.type='DATE' then 'to_date('''||l.value||''', ''dd/mm/yyyy'')'
                                                            when l.type='DATETIME' then 'to_date('''||l.value||''', ''dd/mm/yyyy HH24:MI:SS'')'
                                                            else l.value end);
        end if;
      end loop;
    end if;

    l_txt:='';
    if l_pre_func is not null then
      begin
       execute immediate 'begin :x:='||l_pre_func||'; end;' using out l_txt;
      exception
        when others then
        begin
          p_status:=sqlcode; l_txt:=sqlerrm;
          insert into sync_errors (component, err_txt)
            values('PARSE_ERR','При виконанні префіксної функції виникло виключення '||p_status||' '||l_txt||'.');
          p_status:=1;
        end;
      end;
      insert into sync_errors (component, err_txt) values('PRE_FUNC_MSG',l_txt);
    end if;
  end if;

  if p_status !=1 then
    begin
      execute_script(l_service_name, p_out_data);
    exception
      when others then
      begin
        p_status:=sqlcode; l_txt:=sqlerrm;
        insert into sync_errors (component, err_txt)
          values('PARSE_ERR','При виконанні скрипта виникло виключення '||p_status||' '||l_txt||'.');
        p_status:=1;
      end;
    end;
  end if;

  if p_out_data is null then dbms_lob.createtemporary(p_out_data, false); end if;
  if dbms_lob.getlength(p_out_data)=0 then dbms_lob.append(p_out_data, 'NULL'); end if;

  if p_status !=1 then
    l_txt:='';
    if l_post_func is not null then
      begin
        execute immediate 'begin :x:='||l_post_func||'; end;' using out l_txt;
      exception
        when others then
        begin
          p_status:=sqlcode;  l_txt:=sqlerrm;
          insert into sync_errors (component, err_txt)
            values('PARSE_ERR','При виконанні постфіксної функції виникло виключення '||p_status||' '||l_txt||'.');
          p_status:=1;
        end;
      end;
      insert into sync_errors (component, err_txt) values('POST_FUNC_MSG',l_txt);
    end if;
  end if;

  dbms_lob.createtemporary(p_error, false); dbms_lob.append(p_error, '( COMPONENT, ERR_TXT )### #01# STR, #02# STR###');
  for l in ( select ' #01# '||replace(replace(component, '#', '##'), chr(13), '###')||
                    ' #02# '||replace(replace(err_txt, '#', '##'), chr(13), '###')||'###' as d from sync_errors ) loop
    dbms_lob.append(p_error, l.d);
  end loop;
  if dbms_lob.getlength(p_error)=43 then
    dbms_lob.erase(p_error, l_n); dbms_lob.trim(p_error, 0); dbms_lob.append(p_error, 'NULL');
  end if;

  p_out_data := convert_to_base64(p_out_data);
  bars_audit.info('SYNC_PARSE '||user_name||'  '||l_sysdate||'  '||to_char(l_sysdate, 'yyyy/mm/dd HH24:MI:SS')||chr(13)||l_params||chr(13)||chr(13)||p_error); commit;
  p_error := convert_to_base64(p_error);
  return;

end sync_parse;

end sync;
/
 show err;
 
PROMPT *** Create  grants  SYNC ***
grant EXECUTE                                                                on SYNC            to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on SYNC            to CIM_ROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/sync.sql =========*** End *** ======
 PROMPT ===================================================================================== 
 