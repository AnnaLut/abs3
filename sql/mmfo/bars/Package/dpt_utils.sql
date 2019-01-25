create or replace package DPT_UTILS
is
  head_ver  constant varchar2(64)  := 'version 1.16  12.04.2016';
  head_awk  constant varchar2(512) := '';
  --
  --  служебные функции
  --
  function header_version return varchar2;
  function body_version   return varchar2;

  --
  -- создание сценария для выгрузки вида вклада
  --
  procedure gen_script4vidd (p_vidd in dpt_vidd.vidd%type);

  --
  --  повертає integer масив у вигляді стоки з розділювачем
  --
  function table2list( p_table in number_list,
                       p_delim in varchar2
                     ) return varchar2;

  --
  --  повертає varchar2 масив у вигляді стоки з розділювачем
  --
  function table2list( p_table in varchar2_list,
                       p_delim in varchar2
                     ) return varchar2;

  --
  -- повертає масив значень поля P_COL_NAME таблиці P_TAB_NAME у вигляді стоки з розділювачем
  --
  function table2list_EX( p_tab_name    all_tab_cols.table_name%type,   -- назва наблиці
                          p_col_name    all_tab_cols.column_name%type,  -- назва поля типу varchar2
                          p_condition   varchar2  default null          -- умова для відбору запиів ([where ... ]|[order by...])
                        ) return varchar2;

  --
  -- ф-я повертає вміст p_clob частинами по p_str_size символів
  -- у вигляді varchar2 таблиці
  --
  function clob2str
  ( p_clob      IN OUT NOCOPY CLOB
  , p_str_size  IN            NUMBER
  ) return varchar2_list pipelined;

  ---
  -- ф-я повертає insert на заповнення вказаної таблиці 
  --     p_tab_name  - назва таблиці
  --     p_condition - умова для відбору записів з таблиці
  --     p_offset    - к-ть пробілів для відступу
  --     p_owner     - власник таблиці (назва схеми)
  --     p_mode      - режим формування DML інструкції (I - only insert, M - insert and update)
  ---
  function get_insert4table
  ( p_tab_name    all_tab_cols.table_name%type
  , p_condition   varchar2
  , p_offset      number                  default 0
  , p_owner       all_tab_cols.owner%type default null
  , p_mode        varchar2                default 'I'
  ) return clob;

  --
  -- створення сценарію вивантаження даних таблиці DPT_BRATES
  -- ( також експортуються необхідні базові ставки )
  --
  function gen_script4dptbrates
  ( p_modcode   in  bars_supp_modules.mod_code%type,
    p_str_size  in  number  default 2000
  ) return varchar2_list  pipelined;

  --
  -- процедура нормалізації сіквенсів таблиці
  --
  procedure NORMALIZATION_SEQUENCE
  ( p_tab_name  in  all_tab_cols.table_name%type,     -- назва таблиці
    p_last_val  in  number default null               --
  );

  --
  -- процедура відновлення депозитного договору з архіву
  --
  procedure RECOVERY_CONTRACT
  ( p_dptid  in   dpt_deposit.deposit_id%type         -- ідентифікатор деп.договору ФО
  );

  --
  --
  --
  function get_DptHash
  ( p_dptid   in   dpt_deposit.deposit_id%type        -- ідентифікатор деп.договору
  ) return varchar2;

  --
  -- Сихронізація рахунків витрат
  -- (в %% картках рахунків депозитного потрфеля з довідникам proc_dr$base)
  --
  procedure sync_acc_expenses
  ( p_vidd  in   dpt_vidd.vidd%type                   -- код виду вкладу
  );

  ---
  -- Приєднання шаблону до виду депозиту
  ---
  procedure SET_VIDD_TEMPLATE
  ( p_vidd      in   dpt_vidd.vidd%type,
    p_template  in   doc_scheme.id%type,
    p_flags     in   dpt_vidd_flags.id%type default null
  );

  procedure UPD_VIDD_TEMPLATE
  ( p_vidd      in   dpt_vidd.vidd%type,
    p_template  in   doc_scheme.id%type,
    p_flags     in   dpt_vidd_flags.id%type default null
  );
  ---
  -- Перенесення протоколу виконання автоматичних операцій
  -- депозитного модуля ФО до архіву
  ---
  procedure TRANSFER_LOG2ARCHIVE
  ( p_parallel  in   number default 0              -- Перенесення в архів з (1) / без (0) використання паралелізму
  );


END DPT_UTILS;
/

show errors;

create or replace package body DPT_UTILS
is
--
-- constants
--
body_ver  constant varchar2(32)  := 'version 1.26  06.03.2018';
body_awk  constant varchar2(512) := '';

modcod    constant varchar2(3)   := 'DPT';
nlchr     constant char(2)       := chr(13)||chr(10);

--
-- variables
--

--
-- types
--
type t_brnmrl    is table of br_normal%rowtype;
type t_brtier    is table of br_tier%rowtype;
type t_stopdata  is table of dpt_stop_a%rowtype;
type t_extndata  is table of dpt_vidd_extdesc%rowtype;
type t_params    is table of dpt_vidd_params%rowtype;
type t_transact  is table of dpt_tts_vidd%rowtype;
type t_template  is table of dpt_vidd_scheme%rowtype;
type t_field     is table of dpt_vidd_field%rowtype;
type t_root      is table of doc_root%rowtype;
type t_scalerate is table of dpt_vidd_rate%rowtype;
type t_prgssrate is table of dpt_rate_rise%rowtype;

-- 
-- определение версии заголовка пакета
-- 
function header_version return varchar2 is
begin
  return 'Package DPT_UTILS header '||head_ver||'.'||chr(10)||
         'AWK definition: '||chr(10)||head_awk;
end header_version;

--
-- возвращает версию тела пакета DPT
--
function body_version return varchar2 is
begin
  return 'Package DPT_UTILS body '  ||body_ver||'.'||chr(10)||
         'AWK definition: '||chr(10)||body_awk;
end body_version;

--
-- возвращает строку с двойными кавычками вместо одинарных
-- 
function dblquote (p_txt varchar2) return varchar2 is
begin
  return replace(p_txt, chr(39), chr(39)||chr(39)); 
end dblquote;

--
-- создание сценария для выгрузки типа вклада (dpt_types)
--
procedure iappend_clob4type 
 (p_typeid in dpt_types.type_id%type,
  p_script in out clob)
is
  title      constant varchar2(60) := 'iclob4type:';
  l_typerow  dpt_types%rowtype;
  l_text     varchar2(32000);
begin
  
  bars_audit.trace('%s entry, typeid=>%s', title, to_char(p_typeid));
  
  -- N.B. обновляются все параметры типа вклада
  
  select * into l_typerow from dpt_types where type_id = p_typeid;
  bars_audit.trace('%s typename - %s', title, l_typerow.type_name);
  
  l_text := l_text ||'  -- тип депозитного договора...'||nlchr;
  l_text := l_text ||'  begin '||nlchr;
  l_text := l_text ||'    insert into dpt_types (type_id, type_name, type_code, sort_ord) '||nlchr;
  l_text := l_text ||'    values ('||nvl(to_char(l_typerow.type_id),  'null') ||', '   
                                   ||'substr(''' || nvl(dblquote(l_typerow.type_name), '') ||''', 1, 100), ' 
                                   ||'substr(''' || nvl(dblquote(l_typerow.type_code), '') ||''', 1, 4),  '
                                   ||nvl(to_char(l_typerow.sort_ord), 'null') ||');' ||nlchr;
  l_text := l_text ||'    dbms_output.put_line(''Создан тип договора № '||to_char(l_typerow.type_id)||' - '||dblquote(l_typerow.type_name)||''');'||nlchr;
  l_text := l_text ||'  exception '||nlchr;
  l_text := l_text ||'    when dup_val_on_index then '||nlchr;
  l_text := l_text ||'      update dpt_types '||nlchr;
  l_text := l_text ||'         set type_name = substr('||''''||nvl(dblquote(l_typerow.type_name),  '') ||''',1,100), '||nlchr;
  l_text := l_text ||'             type_code = substr('||''''||nvl(dblquote(l_typerow.type_code),  '') ||''',1,4), '||nlchr;
  l_text := l_text ||'             sort_ord  = '||nvl(to_char(l_typerow.sort_ord), 'null') ||' '||nlchr;
  l_text := l_text ||'       where type_id   = '||nvl(to_char(l_typerow.type_id),  'null') ||';'||nlchr;
  l_text := l_text ||'      dbms_output.put_line(''Обновлен тип договора № '||to_char(l_typerow.type_id)||' - '||dblquote(l_typerow.type_name)||'''); '||nlchr;
  l_text := l_text ||'  end; '||nlchr;
  l_text := l_text ||nlchr ;

  dbms_lob.append(p_script, l_text);
  
  bars_audit.trace('%s exit', title);

end iappend_clob4type;

--
-- создание сценария для выгрузки базовой ставки (brates, br_normal, br_edit)
--
procedure iappend_clob4brate
 (p_brateid in brates.br_id%type,
  p_comment in varchar2,
  p_script  in out clob)
is
  title      constant varchar2(60) := 'iclob4brate:';
  l_braterow brates%rowtype;
  l_text     varchar2(32000);
  l_brnmrl   t_brnmrl;
  l_brtier   t_brtier;
begin
  
  bars_audit.trace('%s entry, brateid=>%s, comment=>%s', title, to_char(p_brateid), p_comment);

  -- N.B. изменение базовой ставки не выполняется, выдается сообщение-предупреждение
  -- N.B. история изменения баз.ставок импортируется только для новых ставок
  -- N.B. проверить импорт в br_normal/br_tier для мульти-МФО
  
  select * into l_braterow from brates where br_id = p_brateid;
  bars_audit.trace('%s bratename - %s', title, l_braterow.name);
  
  l_text := l_text ||'  -- '||p_comment||'...'||nlchr;
  l_text := l_text ||'  begin '||nlchr;
  l_text := l_text ||'    insert into brates (br_id, br_type, name, formula) ' ||nlchr;
  l_text := l_text ||'    values ('||nvl(to_char(l_braterow.br_id),   'null') ||', ' 
                                   ||nvl(to_char(l_braterow.br_type), 'null') ||', '            
                                   ||'substr('''||nvl(dblquote(l_braterow.name),    '') ||''', 1,  35), ' 
                                   ||'substr('''||nvl(dblquote(l_braterow.formula), '') ||''', 1, 250));' ||nlchr;
  select b.* 
    bulk collect 
    into l_brnmrl 
    from br_normal b
   where b.br_id = p_brateid 
     and b.bdate >= (select nvl(max(b1.bdate), bankdate) 
                       from br_normal b1 
                      where b1.br_id  = b.br_id 
                        and b1.kv     = b.kv 
                        and b1.bdate <= bankdate)
   order by  b.kv, b.bdate;
  
  for i in 1..l_brnmrl.count loop
      l_text := l_text ||'    insert into br_normal (br_id, bdate, kv, rate)'||nlchr;
      l_text := l_text ||'    values ('||to_char(l_brnmrl(i).br_id)||', '   
                                       ||'to_date('''||to_char(l_brnmrl(i).bdate, 'dd.mm.yyyy')||''',''dd.mm.yyyy''), '   
                                       ||to_char(l_brnmrl(i).kv)||', '
                                       ||to_char(l_brnmrl(i).rate)||');'||nlchr; 
  end loop;

  select b.* 
    bulk collect 
    into l_brtier 
    from br_tier b
   where b.br_id = p_brateid 
     and b.bdate >= (select nvl(max(b1.bdate), bankdate) 
                       from br_tier b1 
                      where b1.br_id  = b.br_id 
                        and b1.kv     = b.kv 
                        and b1.bdate <= bankdate)
   order by b.kv, b.bdate, b.s;
  
  for i in 1..l_brtier.count loop
      l_text := l_text ||'    insert into br_tier (br_id, bdate, kv, s, rate) '||nlchr;
      l_text := l_text ||'    values ('||to_char(l_brtier(i).br_id)||', '   
                                       ||'to_date('''||to_char(l_brtier(i).bdate, 'dd.mm.yyyy')||''',''dd.mm.yyyy''), '
                                       ||to_char(l_brtier(i).kv)  ||', '   
                                       ||to_char(l_brtier(i).s)   ||', '   
                                       ||to_char(l_brtier(i).rate)||');'||nlchr; 
  end loop;

  l_text := l_text ||'    dbms_output.put_line(''Создана баз.ставка № '||to_char(l_braterow.br_id)||' - '||dblquote(l_braterow.name)||''');'||nlchr;
  l_text := l_text ||'  exception '||nlchr;
  l_text := l_text ||'    when dup_val_on_index then '||nlchr;
  l_text := l_text ||'      dbms_output.put_line(''Найдена баз.ставка № '||to_char(l_braterow.br_id)||'. Необходимо проверить ее соответствие эталонной!''); '||nlchr;
  l_text := l_text ||'  end; '||nlchr;
  l_text := l_text ||nlchr ;

  dbms_lob.append(p_script, l_text);
 
  bars_audit.trace('%s exit', title);

end iappend_clob4brate;

--
-- создание сценария для выгрузки штрафа (dpt_stop, dpt_stop_a)
--
procedure iappend_clob4stop
 (p_stopid in dpt_stop.id%type,
  p_script in out clob)
is
  title      constant varchar2(60) := 'iclob4stop:';
  l_stoprow  dpt_stop%rowtype;
  l_stopdata t_stopdata;
  l_text     varchar2(32000);
begin
  
  bars_audit.trace('%s entry, stopid=>%s', title, to_char(p_stopid));

  -- N.B. 
  select * into l_stoprow from dpt_stop where id = p_stopid;
  bars_audit.trace('%s stopname - %s', title, l_stoprow.name);
  
  l_text := l_text ||'  -- штраф...'||nlchr;
  l_text := l_text ||'  begin '||nlchr;
  l_text := l_text ||'    insert into dpt_stop (id, name, fl, sh_proc, sh_ost) '||nlchr;
  l_text := l_text ||'    values ('||nvl(to_char(l_stoprow.id), 'null')||', '
                                   ||'substr('''||nvl(dblquote(l_stoprow.name), '') ||''', 1, 50), '
                                   ||nvl(to_char(l_stoprow.fl),     'null') ||', '           
                                   ||nvl(to_char(l_stoprow.sh_proc),'null') ||', '           
                                   ||nvl(to_char(l_stoprow.sh_ost), 'null') ||');'||nlchr;           
  l_text := l_text ||'    dbms_output.put_line(''Создан штраф № '||to_char(l_stoprow.id)||' - '||dblquote(l_stoprow.name)||''');'||nlchr;
  l_text := l_text ||'  exception '||nlchr;
  l_text := l_text ||'    when dup_val_on_index then '||nlchr;
  l_text := l_text ||'      update dpt_stop '||nlchr;
  l_text := l_text ||'         set name    = substr('||''''||nvl(dblquote(l_stoprow.name), '') ||''', 1, 50), '||nlchr;
  l_text := l_text ||'             fl      = '||nvl(to_char(l_stoprow.fl),          '') ||',' ||nlchr;
  l_text := l_text ||'             sh_proc = '||nvl(to_char(l_stoprow.sh_proc), 'null') ||',' ||nlchr;
  l_text := l_text ||'             sh_ost  = '||nvl(to_char(l_stoprow.sh_ost),  'null') ||' ' ||nlchr;
  l_text := l_text ||'       where id      = '||nvl(to_char(l_stoprow.id),      'null') ||';' ||nlchr;
  l_text := l_text ||'      dbms_output.put_line(''Обновлен штраф № '||to_char(l_stoprow.id)||' - '||dblquote(l_stoprow.name)||'''); '||nlchr;
  l_text := l_text ||'  end; '||nlchr;
  l_text := l_text ||nlchr ;
  
  l_text := l_text ||'  -- удаление описания штрафа...'||nlchr;
  l_text := l_text ||'  delete from dpt_stop_a where id = '||to_char(l_stoprow.id)||';' ||nlchr;
  l_text := l_text ||nlchr ;
  
  dbms_lob.append(p_script, l_text);
  l_text := null;
  
  select * bulk collect into l_stopdata from dpt_stop_a where id = p_stopid order by k_srok;
     
  for i in 1..l_stopdata.count loop
      l_text := l_text ||'  begin '||nlchr;
      l_text := l_text ||'    insert into dpt_stop_a (id, k_srok, k_proc, k_term, sh_proc, sh_term)'||nlchr;
      l_text := l_text ||'    values ('||nvl(to_char(l_stopdata(i).id),      'null') ||', '
                                       ||nvl(to_char(l_stopdata(i).k_srok),  'null') ||', '
                                       ||nvl(to_char(l_stopdata(i).k_proc),  'null') ||', '
                                       ||nvl(to_char(l_stopdata(i).k_term),  'null') ||', '
                                       ||nvl(to_char(l_stopdata(i).sh_proc), 'null') ||', '
                                       ||nvl(to_char(l_stopdata(i).sh_term), 'null') ||');'||nlchr; 
      l_text := l_text ||'  exception '||nlchr;
      l_text := l_text ||'    when dup_val_on_index then '||nlchr;
      l_text := l_text ||'      update dpt_stop_a '||nlchr;
      l_text := l_text ||'         set k_proc  = '||nvl(to_char(l_stopdata(i).k_proc),  'null') ||', '||nlchr;
      l_text := l_text ||'             k_term  = '||nvl(to_char(l_stopdata(i).k_term),  'null') ||', '||nlchr;
      l_text := l_text ||'             sh_proc = '||nvl(to_char(l_stopdata(i).sh_proc), 'null') ||', '||nlchr;
      l_text := l_text ||'             sh_term = '||nvl(to_char(l_stopdata(i).sh_term), 'null') ||'  '||nlchr;      
      l_text := l_text ||'       where id      = '||to_char(l_stopdata(i).id)     ||' ' ||nlchr;
      l_text := l_text ||'         and k_srok  = '||to_char(l_stopdata(i).k_srok) ||';' ||nlchr;
      l_text := l_text ||'  end; '||nlchr;
      l_text := l_text ||nlchr ;

      dbms_lob.append(p_script, l_text);
      l_text := null;

  end loop;
  
  bars_audit.trace('%s exit', title);

end iappend_clob4stop;

--
-- создание сценария для выгрузки метода переоформления вклада
--
procedure iappend_clob4extnd
 (p_extid  in dpt_vidd_extypes.id%type,
  p_script in out clob)
is
  title      constant varchar2(60) := 'iclob4extnd:';
  l_exttype  dpt_vidd_extypes%rowtype;
  l_extdesc  t_extndata;
  l_text     varchar2(32000);
begin
  
  bars_audit.trace('%s entry, extid=>%s', title, to_char(p_extid));
  
  -- N.B. 

  select * into l_exttype from dpt_vidd_extypes where id = p_extid;
  bars_audit.trace('%s extndname - %s', title, l_exttype.name);

  l_text := l_text ||'  -- метод переоформления...'||nlchr;
  l_text := l_text ||'  begin '||nlchr;
  l_text := l_text ||'    insert into dpt_vidd_extypes (id, name, bonus_proc, bonus_rate, ext_condition) '||nlchr;
  l_text := l_text ||'    values ('||nvl(to_char(l_exttype.id), 'null') ||', '||nlchr;
  l_text := l_text ||'            substr('''||nvl(dblquote(l_exttype.name),          '') ||''', 1,  100), '||nlchr;  
  l_text := l_text ||'            substr('''||nvl(dblquote(l_exttype.bonus_proc),    '') ||''', 1, 3000), '||nlchr;  
  l_text := l_text ||'            substr('''||nvl(dblquote(l_exttype.bonus_rate),    '') ||''', 1, 3000), '||nlchr;  
  l_text := l_text ||'            substr('''||nvl(dblquote(l_exttype.ext_condition), '') ||''', 1, 4000));'||nlchr;  
  l_text := l_text ||'    dbms_output.put_line(''Создан метод переоформления № '||to_char(l_exttype.id)||' - '||dblquote(l_exttype.name)||''');'||nlchr;
  l_text := l_text ||'  exception '||nlchr;
  l_text := l_text ||'    when dup_val_on_index then '||nlchr;
  l_text := l_text ||'      update dpt_vidd_extypes '||nlchr;
  l_text := l_text ||'         set name          = substr('||''''||nvl(dblquote(l_exttype.name),          '') ||''', 1, 100),  '||nlchr;
  l_text := l_text ||'             bonus_proc    = substr('||''''||nvl(dblquote(l_exttype.bonus_proc),    '') ||''', 1, 3000), '||nlchr;
  l_text := l_text ||'             bonus_rate    = substr('||''''||nvl(dblquote(l_exttype.bonus_rate),    '') ||''', 1, 3000), '||nlchr;
  l_text := l_text ||'             ext_condition = substr('||''''||nvl(dblquote(l_exttype.ext_condition), '') ||''', 1, 4000)  '||nlchr;
  l_text := l_text ||'       where id   = '||nvl(to_char(l_exttype.id), 'null') ||';' ||nlchr;
  l_text := l_text ||'      dbms_output.put_line(''Обновлен метод переоформления № '||to_char(l_exttype.id)||' - '||dblquote(l_exttype.name)||'''); '||nlchr;
  l_text := l_text ||'  end; '||nlchr;
  l_text := l_text ||nlchr ;
  
  dbms_lob.append(p_script, l_text);
  l_text := null;

  select * bulk collect into l_extdesc from dpt_vidd_extdesc where type_id = p_extid order by ext_num;
  
  for i in 1..l_extdesc.count loop
      l_text := l_text ||'  begin '||nlchr;
      l_text := l_text ||'    insert into dpt_vidd_extdesc '||nlchr;
      l_text := l_text ||'      (type_id, ext_num,  term_mnth, term_days, indv_rate, oper_id, base_rate, method_id) '||nlchr;
      l_text := l_text ||'    values '||nlchr;  
      l_text := l_text ||'      ('||nvl(to_char(l_extdesc(i).type_id),   'null') ||', '
                                  ||nvl(to_char(l_extdesc(i).ext_num),   'null') ||', '
                                  ||nvl(to_char(l_extdesc(i).term_mnth), 'null') ||', '
                                  ||nvl(to_char(l_extdesc(i).term_days), 'null') ||', '
                                  ||nvl(to_char(l_extdesc(i).indv_rate), 'null') ||', '
                                  ||nvl(to_char(l_extdesc(i).oper_id),   'null') ||', '
                                  ||nvl(to_char(l_extdesc(i).base_rate), 'null') ||', '
                                  ||nvl(to_char(l_extdesc(i).method_id), 'null') ||');'||nlchr; 
      l_text := l_text ||'  exception '||nlchr;
      l_text := l_text ||'    when dup_val_on_index then '||nlchr;
      l_text := l_text ||'      update dpt_vidd_extdesc '||nlchr;
      l_text := l_text ||'         set indv_rate = '||nvl(to_char(l_extdesc(i).indv_rate), 'null') ||', '||nlchr;
      l_text := l_text ||'             oper_id   = '||nvl(to_char(l_extdesc(i).oper_id),   'null') ||', '||nlchr;
      l_text := l_text ||'             base_rate = '||nvl(to_char(l_extdesc(i).base_rate), 'null') ||', '||nlchr;
      l_text := l_text ||'             method_id = '||nvl(to_char(l_extdesc(i).method_id), 'null') ||'  '||nlchr;      
      l_text := l_text ||'       where type_id   = '||to_char(l_extdesc(i).type_id)   ||nlchr;
      l_text := l_text ||'         and ext_num   = '||to_char(l_extdesc(i).ext_num)   ||nlchr;
      l_text := l_text ||'         and term_mnth = '||to_char(l_extdesc(i).term_mnth) ||nlchr;
      l_text := l_text ||'         and term_days = '||to_char(l_extdesc(i).term_days) ||';' ||nlchr;
      l_text := l_text ||'  end; '||nlchr;
      l_text := l_text ||nlchr ;
      
      dbms_lob.append(p_script, l_text);
      l_text := null;

  end loop;
  
  bars_audit.trace('%s exit', title);

end iappend_clob4extnd;

--
-- создание сценария для выгрузки настройки вида вклада
--
procedure iappend_clob4vidd
 (p_data   in dpt_vidd%rowtype, 
  p_script in out clob)
is
  title  constant varchar2(60) := 'iclob4vidd:';
  l_text varchar2(32000);
begin
  
  bars_audit.trace('%s entry, vidd=>%s/%s', title, to_char(p_data.vidd), p_data.type_name);

  -- N.B. поля acc7 + shablon + br_bonus + br_op + nls_k + nlsn_k не передаются

  l_text := l_text ||'  -- настройка вида вклада...'||nlchr;
  l_text := l_text ||'  begin '||nlchr;
  l_text := l_text ||'    insert into dpt_vidd '||nlchr;
  l_text := l_text ||'      ( vidd, type_name, type_id, flag, '                                    ||nlchr;
  l_text := l_text ||'        kv, min_summ, bsd, bsn, bsa, '                                       ||nlchr;
  l_text := l_text ||'        term_type, duration, duration_days, duration_max, duration_days_max,'||nlchr;
  l_text := l_text ||'        limit, max_limit, term_add, auto_add, '                              ||nlchr;
  l_text := l_text ||'        basey, freq_n, tip_ost, metr, amr_metr, tt,'                         ||nlchr;  
  l_text := l_text ||'        basem, br_id, comproc, freq_k, id_stop, br_wd, '                     ||nlchr;
  l_text := l_text ||'        br_id_l, fl_2620, fl_dubl, term_dubl, extension_id, '                ||nlchr;
  l_text := l_text ||'        idg, ids, type_cod, deposit_cod, '                                   ||nlchr;
  l_text := l_text ||'        datn, datk, kodz, fmt, comments)'                                    ||nlchr;
  l_text := l_text ||'    values '                                                                 ||nlchr;
  -- строка 1
  l_text := l_text ||'      ( '||nvl(to_char(p_data.vidd),    'null')||', '
                               ||'substr('''||nvl(dblquote(p_data.type_name), '')||''', 1, 50), '
                               ||nvl(to_char(p_data.type_id), 'null')||', '
                               ||nvl(to_char(p_data.flag),    'null')||', '                        ||nlchr; 
  -- строка 2
  l_text := l_text ||'       '||nvl(to_char(p_data.kv),       'null')||', '
                              ||nvl(to_char(p_data.min_summ), 'null')||', '
                              ||'substr('''||nvl(dblquote(p_data.bsd), '')||''', 1, 4), '
                              ||'substr('''||nvl(dblquote(p_data.bsn), '')||''', 1, 4), '
                              ||'substr('''||nvl(dblquote(p_data.bsa), '')||''', 1, 4), '          ||nlchr; 
  -- строка 3
  l_text := l_text ||'       '||nvl(to_char(p_data.term_type)    ,     'null')||', '
                              ||nvl(to_char(p_data.duration)     ,     'null')||', '
                              ||nvl(to_char(p_data.duration_days),     'null')||', '
                              ||nvl(to_char(p_data.duration_max)     , 'null')||', '
                              ||nvl(to_char(p_data.duration_days_max), 'null')||', '               ||nlchr;  
  -- строка 4
  l_text := l_text ||'      '||nvl(to_char(p_data.limit)        , 'null')||', '
                             ||nvl(to_char(p_data.max_limit)    , 'null')||', '
                             ||nvl(to_char(p_data.term_add)     , 'null')||', '
                             ||nvl(to_char(p_data.auto_add)     , 'null')||', '||nlchr;  
  -- строка 5
  l_text := l_text ||'      '||nvl(to_char(p_data.basey)        , 'null')||', '  
                             ||nvl(to_char(p_data.freq_n)       , 'null')||', '
                             ||nvl(to_char(p_data.tip_ost)      , 'null')||', '
                             ||nvl(to_char(p_data.metr)         , 'null')||', '
                             ||nvl(to_char(p_data.amr_metr)     , 'null')||', '
                             ||' substr('''||nvl(dblquote(p_data.tt), '')||''', 1, 3), '||nlchr; 
  -- строка 6
  l_text := l_text ||'      '||nvl(to_char(p_data.basem)        , 'null')||', '
                             ||nvl(to_char(p_data.br_id)        , 'null')||', '
                             ||nvl(to_char(p_data.comproc)      , 'null')||', '
                             ||nvl(to_char(p_data.freq_k)       , 'null')||', '
                             ||nvl(to_char(p_data.id_stop)      , 'null')||', '
                             ||nvl(to_char(p_data.br_wd)        , 'null')||', '||nlchr; 
  -- строка 7
  l_text := l_text ||'      '||nvl(to_char(p_data.br_id_l)      , 'null')||', '
                             ||nvl(to_char(p_data.fl_2620)      , 'null')||', '
                             ||nvl(to_char(p_data.fl_dubl)      , 'null')||', '
                             ||nvl(to_char(p_data.term_dubl)    , 'null')||', '
                             ||nvl(to_char(p_data.extension_id) , 'null')||', '||nlchr;  
  -- строка 8
  l_text := l_text ||'      '||nvl(to_char(p_data.idg)          , 'null')||', '
                             ||nvl(to_char(p_data.ids)          , 'null')||', '
                             ||'substr('''||nvl(dblquote(p_data.type_cod), '')||''', 1, 4), ' 
                             ||'substr('''||nvl(dblquote(p_data.deposit_cod), '')||''', 1, 4), '||nlchr;
  -- строка 9
  l_text := l_text ||'      to_date('''||nvl(to_char(p_data.datn, 'dd.mm.yyyy'), '')||''',''dd.mm.yyyy''), '
                         ||'to_date('''||nvl(to_char(p_data.datk, 'dd.mm.yyyy'), '')||''',''dd.mm.yyyy''), '
                         ||nvl(to_char(p_data.kodz), 'null')||', '
                         ||nvl(to_char(p_data.fmt) , 'null')||', '
                         ||'substr('''||nvl(dblquote(p_data.comments),'')||''', 1, 128) );'||nlchr; 
  
  l_text := l_text ||'    dbms_output.put_line(''Создан вид вклада № '||to_char(p_data.vidd)||' - '||dblquote(p_data.type_name)||''');'||nlchr;
  l_text := l_text ||'  exception '||nlchr;
  l_text := l_text ||'    when dup_val_on_index then '||nlchr;
  l_text := l_text ||'      update dpt_vidd '||nlchr;
  l_text := l_text ||'         set type_name         = substr('''||nvl(dblquote(p_data.type_name),          '')||''', 1, 50), '||nlchr; 
  l_text := l_text ||'             type_id           = '||nvl(to_char(p_data.type_id),                  'null')||', '||nlchr;  
  l_text := l_text ||'             flag              = '||nvl(to_char(p_data.flag),                     'null')||', '||nlchr;  
  l_text := l_text ||'             type_cod          = substr('''||nvl(dblquote(p_data.type_cod),           '')||''', 1, 4), ' ||nlchr; 
  l_text := l_text ||'             kv                = '||nvl(to_char(p_data.kv),                       'null')||', '||nlchr;  
  l_text := l_text ||'             min_summ          = '||nvl(to_char(p_data.min_summ),                 'null')||', '||nlchr;  
  l_text := l_text ||'             bsd               = substr('''||nvl(dblquote(p_data.bsd),                '')||''', 1, 4), ' ||nlchr; 
  l_text := l_text ||'             bsn               = substr('''||nvl(dblquote(p_data.bsn),                '')||''', 1, 4), ' ||nlchr; 
  l_text := l_text ||'             bsa               = substr('''||nvl(dblquote(p_data.bsa),                '')||''', 1, 4), ' ||nlchr; 
  l_text := l_text ||'             term_type         = '||nvl(to_char(p_data.term_type),                'null')||', '||nlchr;  
  l_text := l_text ||'             duration          = '||nvl(to_char(p_data.duration),                 'null')||', '||nlchr;  
  l_text := l_text ||'             duration_days     = '||nvl(to_char(p_data.duration_days),            'null')||', '||nlchr; 
  l_text := l_text ||'             duration_max      = '||nvl(to_char(p_data.duration_max),             'null')||', '||nlchr; 
  l_text := l_text ||'             duration_days_max = '||nvl(to_char(p_data.duration_days_max),        'null')||', '||nlchr;   
  l_text := l_text ||'             limit         = '||nvl(to_char(p_data.limit),                    'null')||', '||nlchr;  
  l_text := l_text ||'             max_limit     = '||nvl(to_char(p_data.max_limit),                'null')||', '||nlchr;  
  l_text := l_text ||'             term_add      = '||nvl(to_char(p_data.term_add),                 'null')||', '||nlchr;  
  l_text := l_text ||'             auto_add      = '||nvl(to_char(p_data.auto_add),                 'null')||', '||nlchr;  
  l_text := l_text ||'             basey         = '||nvl(to_char(p_data.basey),                    'null')||', '||nlchr;  
  l_text := l_text ||'             freq_n        = '||nvl(to_char(p_data.freq_n),                   'null')||', '||nlchr;  
  l_text := l_text ||'             tip_ost       = '||nvl(to_char(p_data.tip_ost),                  'null')||', '||nlchr;  
  l_text := l_text ||'             metr          = '||nvl(to_char(p_data.metr),                     'null')||', '||nlchr;  
  l_text := l_text ||'             amr_metr      = '||nvl(to_char(p_data.amr_metr),                 'null')||', '||nlchr;  
  l_text := l_text ||'             tt            = substr('''||nvl(dblquote(p_data.tt),                 '')||''', 1, 3), ' ||nlchr; 
  l_text := l_text ||'             basem         = '||nvl(to_char(p_data.basem),                    'null')||', '||nlchr;  
  l_text := l_text ||'             br_id         = '||nvl(to_char(p_data.br_id),                    'null')||', '||nlchr;  
  l_text := l_text ||'             comproc       = '||nvl(to_char(p_data.comproc),                  'null')||', '||nlchr;  
  l_text := l_text ||'             freq_k        = '||nvl(to_char(p_data.freq_k),                   'null')||', '||nlchr; 
  l_text := l_text ||'             id_stop       = '||nvl(to_char(p_data.id_stop),                  'null')||', '||nlchr;  
  l_text := l_text ||'             br_wd         = '||nvl(to_char(p_data.br_wd),                    'null')||', '||nlchr;  
  l_text := l_text ||'             idg           = '||nvl(to_char(p_data.idg),                      'null')||', '||nlchr;  
  l_text := l_text ||'             ids           = '||nvl (to_char(p_data.ids),                     'null')||', '||nlchr;  
  l_text := l_text ||'             br_id_l       = '||nvl(to_char(p_data.br_id_l),                  'null')||', '||nlchr;  
  l_text := l_text ||'             fl_2620       = '||nvl(to_char(p_data.fl_2620),                  'null')||', '||nlchr;  
  l_text := l_text ||'             fl_dubl       = '||nvl(to_char(p_data.fl_dubl),                  'null')||', '||nlchr;  
  l_text := l_text ||'             term_dubl     = '||nvl(to_char(p_data.term_dubl),                'null')||', '||nlchr;  
  l_text := l_text ||'             extension_id  = '||nvl(to_char(p_data.extension_id),             'null')||', '||nlchr;  
  l_text := l_text ||'             deposit_cod   = substr('''||nvl(dblquote(p_data.deposit_cod),        '')||''', 1, 4), ' ||nlchr; 
  l_text := l_text ||'             datn          = to_date('''||nvl(to_char(p_data.datn, 'dd.mm.yyyy'), '')||''',''dd.mm.yyyy''), '||nlchr; 
  l_text := l_text ||'             datk          = to_date('''||nvl(to_char(p_data.datk, 'dd.mm.yyyy'), '')||''',''dd.mm.yyyy''), '||nlchr; 
  l_text := l_text ||'             kodz          = '||nvl(to_char(p_data.kodz),                     'null')||', '||nlchr; 
  l_text := l_text ||'             fmt           = '||nvl(to_char(p_data.fmt),                      'null')||', '||nlchr;  
  l_text := l_text ||'             comments      = substr('''||nvl(dblquote(p_data.comments),           '')||''', 1,  128) ' ||nlchr; 
  l_text := l_text ||'       where vidd          = '||to_char(p_data.vidd)||';'||nlchr;
  l_text := l_text ||'      dbms_output.put_line(''Обновлен вид вклада № '||to_char(p_data.vidd)||' - '||dblquote(p_data.type_name)||''');'||nlchr;
  l_text := l_text ||nlchr ;
  l_text := l_text ||'      -- очистка связей с операциями, шаблонами, шкалами ставок, доп.параметрами ...'||nlchr;
  l_text := l_text ||'      delete from dpt_vidd_params where vidd = '||to_char(p_data.vidd)||';'||nlchr;
  l_text := l_text ||'      delete from dpt_tts_vidd    where vidd = '||to_char(p_data.vidd)||';'||nlchr;
  l_text := l_text ||'      delete from dpt_vidd_scheme where vidd = '||to_char(p_data.vidd)||';'||nlchr;
  l_text := l_text ||'      delete from dpt_vidd_field  where vidd = '||to_char(p_data.vidd)||';'||nlchr;
  l_text := l_text ||'      dbms_output.put_line(''Выполнена очистка связей с операциями, шаблонами, шкалами ставок и др. для вида вклада № '||to_char(p_data.vidd)||' - '||dblquote(p_data.type_name)||''');'||nlchr;
  l_text := l_text ||'  end; '||nlchr;
  l_text := l_text ||nlchr ;

  dbms_lob.append(p_script, l_text);
  
  bars_audit.trace('%s exit', title);

end iappend_clob4vidd;

--
-- создание сценария для выгрузки доп.параметров вида вклада 
--
procedure iappend_clob4params
 (p_vidd   in dpt_vidd.vidd%type, 
  p_script in out clob)
is  
  title    constant varchar2(60) := 'iclob4param:';
  l_text   varchar2(32000);
  l_params t_params;
begin

  bars_audit.trace('%s entry, vidd=>%s', title, to_char(p_vidd));

  -- N.B. импорт кодов параметров из dpt_vidd_tags не выполняется

  select * bulk collect into l_params from dpt_vidd_params where vidd = p_vidd order by tag;
  
  for i in 1..l_params.count loop
      
      if i = 1 then
         l_text := l_text ||'  -- доп.параметры вида вклада...'||nlchr;
      end if;
      
      l_text := l_text ||'  begin '||nlchr;
      l_text := l_text ||'    insert into dpt_vidd_params (vidd, tag, val) '||nlchr;
      l_text := l_text ||'    values ('||to_char(l_params(i).vidd)||', '   
                                    ||'substr('''||dblquote(l_params(i).tag)||''', 1, 16), ' 
                                    ||'substr('''||dblquote(l_params(i).val)||''', 1, 3000));'||nlchr;
      l_text := l_text ||'  exception '||nlchr;
      l_text := l_text ||'    when dup_val_on_index then '||nlchr;
      l_text := l_text ||'      update dpt_vidd_params '||nlchr;
      l_text := l_text ||'         set val  = substr('''||dblquote(l_params(i).val)||''', 1, 3000) '||nlchr;
      l_text := l_text ||'       where vidd = '||to_char(l_params(i).vidd)||nlchr;
      l_text := l_text ||'         and tag  = substr('''||to_char(l_params(i).tag)||''', 1, 16);'||nlchr;
      l_text := l_text ||'  end; '||nlchr;
      l_text := l_text ||nlchr ;

      if i = l_params.count then
         l_text := l_text ||'  dbms_output.put_line(''Заполнены/обновлены доп.параметры вида вклада № '||to_char(p_vidd)||'''); '||nlchr;
         l_text := l_text ||nlchr ;
      end if;

      dbms_lob.append(p_script, l_text);
      l_text := null;

  end loop;

  bars_audit.trace('%s exit', title);

end iappend_clob4params;

--
-- создание сценария для выгрузки операций, допустимых для данного вида вклада
--
procedure iappend_clob4transacts
 (p_vidd   in dpt_vidd.vidd%type, 
  p_script in out clob)
is  
  title      constant varchar2(60) := 'iclob4transact:';
  l_text     varchar2(32000);
  l_transact t_transact;
begin

  bars_audit.trace('%s entry, vidd=>%s', title, to_char(p_vidd));
  
  -- N.B. импорт операций из TTS не выполняется
  
  select * bulk collect into l_transact from dpt_tts_vidd where vidd = p_vidd order by tt;
  
  for i in 1..l_transact.count loop
      
      if i = 1 then
         l_text := l_text ||'  -- допустимые операции для вида вклада...'||nlchr;
      end if;
      
      l_text := l_text ||'  begin '||nlchr;
      l_text := l_text ||'    insert into dpt_tts_vidd (vidd, tt, ismain) '||nlchr;
      l_text := l_text ||'    values ('||to_char(l_transact(i).vidd)||', '   
                                    ||'substr('''||dblquote(l_transact(i).tt)||''', 1, 3), ' 
                                    ||nvl(to_char(l_transact(i).ismain), 'null')||');'||nlchr;
      l_text := l_text ||'  exception '||nlchr;
      l_text := l_text ||'    when dup_val_on_index then null;'||nlchr;
      l_text := l_text ||'  end;'||nlchr;
      l_text := l_text ||nlchr ;
  
      if i = l_transact.count then
         l_text := l_text ||'  dbms_output.put_line(''Заполнены/обновлены доп.операции для вида вклада № '||to_char(p_vidd)||'''); '||nlchr;
         l_text := l_text ||nlchr ;
      end if;

      dbms_lob.append(p_script, l_text);
      l_text := null;

  end loop;

  bars_audit.trace('%s exit', title);

end iappend_clob4transacts;

--
-- создание сценария для выгрузки шаблонов договоров и ДС, допустимых для данного вида вклада
--
procedure iappend_clob4templates
 (p_vidd   in dpt_vidd.vidd%type, 
  p_script in out clob)
is
  title      constant varchar2(60) := 'iclob4template:';
  l_docs     doc_scheme%rowtype;
  l_template t_template;
  l_root     t_root;
  l_text     varchar2(32000);
begin

  bars_audit.trace('%s entry, vidd=>%s', title, to_char(p_vidd));

  -- N.B. 

  select * bulk collect into l_template from dpt_vidd_scheme where vidd = p_vidd order by flags, id;
  
  for i in 1..l_template.count loop
      
      if i = 1 then
         l_text := l_text ||'  -- допустимые шаблоны для вида вклада...'||nlchr;
      end if;
      
      -- создание шаблона в doc_scheme
      begin
        select * into l_docs from doc_scheme where id = l_template(i).id;     
          bars_audit.trace('%s template - %s', title, l_docs.id);

          l_text := l_text ||'  begin '||nlchr;
          l_text := l_text ||'    insert into doc_scheme (id, name) '||nlchr;
          l_text := l_text ||'    values ('''||nvl(dblquote(l_docs.id), '')||''', '''||nvl(dblquote(l_docs.name), '')||'''); '||nlchr;
          l_text := l_text ||'    dbms_output.put_line(''Создан шаблон '||dblquote(l_docs.id)||' - '||dblquote(l_docs.name)||'''); '||nlchr;
          l_text := l_text ||'  exception '||nlchr;
          l_text := l_text ||'    when dup_val_on_index then '||nlchr;
          l_text := l_text ||'      update doc_scheme '||nlchr;
          l_text := l_text ||'         set name = '''||nvl(dblquote(l_docs.name), '') ||'''  '||nlchr;
          l_text := l_text ||'       where id   = '''||nvl(dblquote(l_docs.id),   '') ||'''; '||nlchr;
          l_text := l_text ||'      dbms_output.put_line(''Обновлен шаблон '||dblquote(l_docs.id)||' - '||dblquote(l_docs.name)||'''); '||nlchr;
          l_text := l_text ||'  end; '||nlchr;
          l_text := l_text ||nlchr;          

          select * bulk collect into l_root from doc_root where id = l_template(i).id order by vidd;

          for j in 1..l_root.count loop
              bars_audit.trace('%s template_type - %s', title, to_char(l_root(j).vidd));
              l_text := l_text ||'  begin '||nlchr;
              l_text := l_text ||'    insert into doc_root (vidd, id) '||nlchr;
              l_text := l_text ||'    values ('||to_char(l_root(j).vidd)||', '''||dblquote(l_root(j).id)||'''); '||nlchr;
              l_text := l_text ||'  exception '||nlchr;
              l_text := l_text ||'    when dup_val_on_index then null; '||nlchr;
              l_text := l_text ||'  end; '||nlchr;
              l_text := l_text ||nlchr ;
          end loop;

          l_text := l_text ||'  begin '||nlchr;
          l_text := l_text ||'    insert into dpt_vidd_scheme (vidd, id, id_fr, flags) '||nlchr;
          l_text := l_text ||'    values ('||to_char(l_template(i).vidd)||', '
                                        ||'substr('''||dblquote(l_template(i).id)||''', 1, 35), '
                                        ||'substr('''||dblquote(l_template(i).id_fr)||''', 1, 35), '
                                        ||to_char(l_template(i).flags)||');'||nlchr;
          l_text := l_text ||'  exception '||nlchr;
          l_text := l_text ||'    when dup_val_on_index then '||nlchr;
          l_text := l_text ||'      update dpt_vidd_scheme '||nlchr;
          l_text := l_text ||'         set flags = '||to_char(l_template(i).flags)||nlchr;
          l_text := l_text ||'       where vidd  = '||to_char(l_template(i).vidd) ||nlchr;
          l_text := l_text ||'         and id    = substr('''||to_char(l_template(i).id)||''', 1, 35);'||nlchr;
          l_text := l_text ||'  end; '||nlchr;
          l_text := l_text ||nlchr ;

          if i = l_template.count then
             l_text := l_text ||'  dbms_output.put_line(''Заполнены/обновлены доп.шаблоны для вида вклада № '||to_char(p_vidd)||'''); '||nlchr;
             l_text := l_text ||nlchr ;
          end if;

          dbms_lob.append(p_script, l_text);
          l_text := null;
      
      exception when no_data_found 
      then null;
      end;
      begin -- FRX - шаблоны
        select * into l_docs from doc_scheme where id = l_template(i).id_fr;
        bars_audit.trace('%s FRX template - %s', title, l_docs.id);

          l_text := l_text ||'  begin '||nlchr;
          l_text := l_text ||'    insert into doc_scheme (id, name) '||nlchr;
          l_text := l_text ||'    values ('''||nvl(dblquote(l_docs.id), '')||''', '''||nvl(dblquote(l_docs.name), '')||'''); '||nlchr;
          l_text := l_text ||'    dbms_output.put_line(''Создан шаблон '||dblquote(l_docs.id)||' - '||dblquote(l_docs.name)||'''); '||nlchr;
          l_text := l_text ||'  exception '||nlchr;
          l_text := l_text ||'    when dup_val_on_index then '||nlchr;
          l_text := l_text ||'      update doc_scheme '||nlchr;
          l_text := l_text ||'         set name = '''||nvl(dblquote(l_docs.name), '') ||'''  '||nlchr;
          l_text := l_text ||'       where id   = '''||nvl(dblquote(l_docs.id),   '') ||'''; '||nlchr;
          l_text := l_text ||'      dbms_output.put_line(''Обновлен шаблон '||dblquote(l_docs.id)||' - '||dblquote(l_docs.name)||'''); '||nlchr;
          l_text := l_text ||'  end; '||nlchr;
          l_text := l_text ||nlchr ;

          select * bulk collect into l_root from doc_root where id = l_template(i).id order by vidd;

          for j in 1..l_root.count loop
              bars_audit.trace('%s FRX template_type - %s', title, to_char(l_root(j).vidd));
              l_text := l_text ||'  begin '||nlchr;
              l_text := l_text ||'    insert into doc_root (vidd, id) '||nlchr;
              l_text := l_text ||'    values ('||to_char(l_root(j).vidd)||', '''||dblquote(l_root(j).id)||'''); '||nlchr;
              l_text := l_text ||'  exception '||nlchr;
              l_text := l_text ||'    when dup_val_on_index then null; '||nlchr;
              l_text := l_text ||'  end; '||nlchr;
              l_text := l_text ||nlchr ;
          end loop;

          l_text := l_text ||'  begin '||nlchr;
          l_text := l_text ||'    insert into dpt_vidd_scheme (vidd, id, id_fr, flags) '||nlchr;
          l_text := l_text ||'    values ('||to_char(l_template(i).vidd)||', '
                                        ||'substr('''||dblquote(l_template(i).id)||''', 1, 35), '
                                        ||'substr('''||dblquote(l_template(i).id_fr)||''', 1, 35), '
                                        ||to_char(l_template(i).flags)||');'||nlchr;
          l_text := l_text ||'  exception '||nlchr;
          l_text := l_text ||'    when dup_val_on_index then '||nlchr;
          l_text := l_text ||'      update dpt_vidd_scheme '||nlchr;
          l_text := l_text ||'         set flags = '||to_char(l_template(i).flags)||nlchr;
          l_text := l_text ||'       where vidd  = '||to_char(l_template(i).vidd) ||nlchr;
          l_text := l_text ||'         and id_fr = substr('''||to_char(l_template(i).id_fr)||''', 1, 35);'||nlchr;
          l_text := l_text ||'  end; '||nlchr;
          l_text := l_text ||nlchr ;

          if i = l_template.count then
             l_text := l_text ||'  dbms_output.put_line(''Заполнены/обновлены доп.шаблоны для вида вклада № '||to_char(p_vidd)||'''); '||nlchr;
             l_text := l_text ||nlchr ;
          end if;

          dbms_lob.append(p_script, l_text);
          l_text := null;           
      exception when no_data_found then null;                
      end;  
  end loop;

  bars_audit.trace('%s exit', title);

end iappend_clob4templates;

--
-- создание сценария для выгрузки доп.реквизитов вкладов, допустимых для данного вида вклада
--
procedure iappend_clob4fields
 (p_vidd   in dpt_vidd.vidd%type, 
  p_script in out clob)
is
  title   constant varchar2(60) := 'iclob4fields:';
  l_text  varchar2(32000);
  l_field t_field;
begin

  bars_audit.trace('%s entry, vidd=>%s', title, to_char(p_vidd));
  
  -- N.B. 
  
  select * bulk collect into l_field from dpt_vidd_field where vidd = p_vidd order by tag;
  
  for i in 1..l_field.count loop
      null;
      
      if i = 1 then
         l_text := l_text ||'  -- допустимые доп.реквизиты вклада для вида вклада...'||nlchr;
      end if;
      
      l_text := l_text ||'  begin '||nlchr;
      l_text := l_text ||'    insert into dpt_vidd_field (vidd, tag, obz) '||nlchr;
      l_text := l_text ||'    values ('||to_char(l_field(i).vidd)||', '   
                                    ||'substr('''||dblquote(l_field(i).tag)||''', 1, 5), ' 
                                    ||nvl(to_char(l_field(i).obz), 'null')||');'||nlchr;
      l_text := l_text ||'  exception '||nlchr;
      l_text := l_text ||'    when dup_val_on_index then '||nlchr;
      l_text := l_text ||'      update dpt_vidd_field '||nlchr;
      l_text := l_text ||'         set obz  = '||nvl(to_char(l_field(i).obz), 'null')||nlchr;
      l_text := l_text ||'       where vidd = '||to_char(l_field(i).vidd) ||nlchr;
      l_text := l_text ||'         and tag  = substr('''||to_char(l_field(i).tag)||''', 1, 5);'||nlchr;
      l_text := l_text ||'  end; '||nlchr;
      l_text := l_text ||nlchr ;
      
      if i = l_field.count then
         l_text := l_text ||'  dbms_output.put_line(''Заполнены/обновлены доп.реквизиты вклада для вида вклада № '||to_char(p_vidd)||'''); '||nlchr;
         l_text := l_text ||nlchr ;
      end if;

      dbms_lob.append(p_script, l_text);
      l_text := null;

  end loop;

  bars_audit.trace('%s exit', title);

end iappend_clob4fields;

--
-- создание сценария для выгрузки шкал процентных ставок и прогрессивных ставок
--
procedure iappend_clob4rates
 (p_vidd   in dpt_vidd.vidd%type, 
  p_script in out clob)
is
  title  constant varchar2(60) := 'iclob4rates:';
  l_text varchar2(32000);
  l_scale t_scalerate;
  l_prgss t_prgssrate;
begin

  bars_audit.trace('%s entry, vidd=>%s', title, to_char(p_vidd));
  
  -- N.B. 
  
  select * bulk collect into l_scale from dpt_vidd_rate where vidd = p_vidd order by id;
  
  for i in 1..l_scale.count loop
      if i = 1 then
         l_text := l_text ||'  -- шкала процентных ставок для вида вклада...'||nlchr;
      end if;
      
      l_text := l_text ||'  begin '||nlchr;
      l_text := l_text ||'    insert into dpt_vidd_rate (vidd, id, term_m, term_d, limit, rate, dat) '||nlchr;
      l_text := l_text ||'    values ('||to_char(l_scale(i).vidd)  ||', '   
                                       ||to_char(l_scale(i).id)    ||', '
                                       ||to_char(l_scale(i).term_m)||', '
                                       ||to_char(l_scale(i).term_d)||', '
                                       ||to_char(l_scale(i).limit) ||', '
                                       ||to_char(l_scale(i).rate)  ||', '
                                       ||'to_date('''||to_char(l_scale(i).dat, 'dd.mm.yyyy')||''',''dd.mm.yyyy''));'||nlchr;
      l_text := l_text ||'  exception '||nlchr;
      l_text := l_text ||'    when dup_val_on_index then '||nlchr;
      l_text := l_text ||'      update dpt_vidd_rate '||nlchr;
      l_text := l_text ||'         set term_m  = '||to_char(l_scale(i).term_m)||', '||nlchr;
      l_text := l_text ||'             term_d  = '||to_char(l_scale(i).term_d)||', '||nlchr;
      l_text := l_text ||'             limit   = '||to_char(l_scale(i).limit) ||', '||nlchr;
      l_text := l_text ||'             rate    = '||to_char(l_scale(i).rate)  ||', '||nlchr;
      l_text := l_text ||'             dat     = to_date('''||to_char(l_scale(i).dat, 'dd.mm.yyyy')||''',''dd.mm.yyyy'') '||nlchr; 
      l_text := l_text ||'       where vidd    = '||to_char(l_scale(i).vidd)||nlchr;
      l_text := l_text ||'         and id      = '||to_char(l_scale(i).id)  ||';'||nlchr;
      l_text := l_text ||'  end; '||nlchr;
      l_text := l_text ||nlchr ;
      
      if i = l_scale.count then
         l_text := l_text ||'  dbms_output.put_line(''Заполнена/обновлена шкала процентных ставок для вида вклада № '||to_char(p_vidd)||'''); '||nlchr;
         l_text := l_text ||nlchr ;
      end if;
  
      dbms_lob.append(p_script, l_text);
      l_text := null;

  end loop;

  select * bulk collect into l_prgss from dpt_rate_rise where vidd = p_vidd order by duration_m, duration_d;
  
  for i in 1..l_prgss.count loop
      if i = 1 then
         l_text := l_text ||'  -- шкала прогрессивных ставок для вида вклада...'||nlchr;
      end if;
      
      l_text := l_text ||'  begin '||nlchr;
      l_text := l_text ||'    insert into dpt_rate_rise (vidd, duration_m, duration_d, ir, op, br, id) '||nlchr;
      l_text := l_text ||'    values ('||to_char(l_prgss(i).vidd)       ||', '   
                                       ||to_char(l_prgss(i).duration_m) ||', '
                                       ||to_char(l_prgss(i).duration_d) ||', '
                                       ||nvl(to_char(l_prgss(i).ir),'null')||', '
                                       ||nvl(to_char(l_prgss(i).op),'null')||', '
                                       ||nvl(to_char(l_prgss(i).br),'null')||', '
                                       ||nvl(to_char(l_prgss(i).id),'null')||');'||nlchr;
      l_text := l_text ||'  exception '||nlchr;
      l_text := l_text ||'    when dup_val_on_index then '||nlchr;
      l_text := l_text ||'      update dpt_rate_rise '||nlchr;
      l_text := l_text ||'         set ir         = '||nvl(to_char(l_prgss(i).ir),'null')||', '||nlchr;
      l_text := l_text ||'             op         = '||nvl(to_char(l_prgss(i).op),'null')||', '||nlchr;
      l_text := l_text ||'             br         = '||nvl(to_char(l_prgss(i).br),'null')||', '||nlchr;
      l_text := l_text ||'             id         = '||nvl(to_char(l_prgss(i).id),'null')      ||nlchr;
      l_text := l_text ||'       where vidd       = '||to_char(l_prgss(i).vidd)      ||nlchr;
      l_text := l_text ||'         and duration_m = '||to_char(l_prgss(i).duration_m)||nlchr;
      l_text := l_text ||'         and duration_d = '||to_char(l_prgss(i).duration_d)||';'||nlchr;
      l_text := l_text ||'  end; '||nlchr;
      l_text := l_text ||nlchr ;
      
      if i = l_prgss.count then
         l_text := l_text ||'  dbms_output.put_line(''Заполнена/обновлена шкала прогрессивных ставок для вида вклада № '||to_char(p_vidd)||'''); '||nlchr;
         l_text := l_text ||nlchr ;
      end if;
  
      dbms_lob.append(p_script, l_text);
      l_text := null;

  end loop;

  bars_audit.trace('%s exit', title);

end iappend_clob4rates;

--
--
--
procedure gen_script4vidd (p_vidd in dpt_vidd.vidd%type)
is
  title      constant varchar2(60) := 'gen_expdptype:';
  l_script   clob;
  l_text     varchar2(32000);
  l_viddrow  dpt_vidd%rowtype;
  l_typerow  dpt_types%rowtype;
begin

  bars_audit.trace('%s entry, vidd=>%s', title, to_char(p_vidd));
  
  dbms_lob.createtemporary (l_script,  false);

  begin
    select * into l_viddrow from dpt_vidd where vidd = p_vidd;
  exception
    when no_data_found then
      -- !!! описать ошибку
      dbms_output.put_line ('ERR: не найден вид вклада № '||to_char(p_vidd));
      return;
  end;
  bars_audit.trace('%s typename - %s', title, l_viddrow.type_name);
  
  l_text :=          'prompt =============================================================== '||nlchr;
  l_text := l_text ||'prompt === ЭКСПОРТ ВИДА ДЕПОЗИТНОГО ДОГОВОРА ФИЗ.ЛИЦА № '||lpad(to_char(p_vidd), 10, '_')||' === '||nlchr;
  l_text := l_text ||'prompt =============================================================== '||nlchr||nlchr;   
  l_text := l_text ||'set serveroutput on'||nlchr;
  l_text := l_text ||'set feed off       '||nlchr;
  l_text := l_text ||nlchr ;
  l_text := l_text ||'begin '||nlchr;
  l_text := l_text ||nlchr ;
  dbms_lob.append(l_script, l_text);
  l_text := null;
  
  -- тип депозитного договора (dpt_types)
  -- N.B. сценарий на создание типа № 0 не формируется
  if l_viddrow.type_id > 0 then
     iappend_clob4type (p_typeid => l_viddrow.type_id, p_script => l_script);
  end if;
  if l_viddrow.id_stop > 0 then
     iappend_clob4stop(p_stopid => l_viddrow.id_stop, p_script => l_script);
  end if;
  
  -- метод расчета ставки при переоформлении вклада
  if l_viddrow.extension_id > 0 then
     iappend_clob4extnd(p_extid => l_viddrow.extension_id, p_script => l_script);
  end if;

  -- настройка вида вклада
  iappend_clob4vidd(p_data => l_viddrow, p_script => l_script);

  -- заполнение доп.параметров вида вклада 
  iappend_clob4params(p_vidd => l_viddrow.vidd, p_script => l_script);

  -- привязка операций, допустимых для данного вида вклада
  iappend_clob4transacts(p_vidd => l_viddrow.vidd, p_script => l_script);

  -- привязка шаблонов договоров и доп.соглашений, допустимых для данного вида вклада
  iappend_clob4templates(p_vidd => l_viddrow.vidd, p_script => l_script);

  -- привязка доп.реквизитов вкладов, допустимых для данного вида вклада
  iappend_clob4fields(p_vidd => l_viddrow.vidd, p_script => l_script);

  
  -- !!!! открытие счетов расходов и заполнение спр-ка "proc_dr"

  -- N.B. привязка польз-лей и подразделений, допустимых для данного вида вклада, 
  -- не выполняется

  l_text := l_text ||nlchr ;
  l_text := l_text ||'  commit; '||nlchr;
  l_text := l_text ||nlchr ;
  l_text := l_text ||'end; '||nlchr;
  l_text := l_text ||'/   '||nlchr;  
  l_text := l_text ||nlchr ;
  l_text := l_text ||'set feed on '||nlchr;
     
  dbms_lob.append(l_script, l_text);
  l_text := null;

  begin
    insert into tmp_expdptype (modcode, typeid, clobdata, clobleng)
    values (modcod, p_vidd, l_script, dbms_lob.getlength(l_script));
  exception
    when dup_val_on_index then
      update tmp_expdptype 
         set clobdata = l_script,
             clobleng = dbms_lob.getlength(l_script)
       where modcode  = modcod
         and typeid   = p_vidd;  
  end;  
  bars_audit.trace('%s tmp_expdptype succ.inserted', title);
  
  dbms_lob.freetemporary(l_script);
  
  bars_audit.trace('%s exit', title);

exception
  when others then
    bars_error.raise_nerror (modcod, 'GEN_EXPDPTYPE_FAILED', to_char(p_vidd), sqlerrm);

end gen_script4vidd;

--==============================================================================
--
--==============================================================================

--
-- ф-я повертає перелік полів таблиці розділених комою
--
function get_tab_cols_list( p_tab_name  all_tab_cols.table_name%type )
return  varchar2
is
 l_cols_list_tab   dbms_utility.uncl_array;
 l_cols_count      BINARY_INTEGER;
 l_cols_list_str   VARCHAR2(4000); 
begin
  select COLUMN_NAME
    bulk collect
    into l_cols_list_tab
    from ALL_TAB_COLS 
   where table_name = UPPER( p_tab_name )
   order by column_id;
  
  dbms_utility.table_to_comma(l_cols_list_tab, l_cols_count, l_cols_list_str);
  
  bars_audit.trace( 'DPT_UTILS.GET_TAB_COLS_LIST: exit with: Array Size  -> %s, List -> %s', to_char(l_cols_count), l_cols_list_str );
  
  return l_cols_list_str;
  
exception
  when others then
    raise_application_error( -20000, dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace(), true );
end get_tab_cols_list;

--
--  перегружена ф-я повертає varchar2 масив у вигляді стоки з розділювачем
--
function table2list( p_table in varchar2_list,
                     p_delim in varchar2
                   )
return varchar2
IS
  l_list  varchar2(4000);
begin

  If p_delim Is Null then
    raise_application_error (-20500, 'invalid delimiter');
  end if;
  
  For k in p_table.first .. p_table.last
  Loop
    If InStr(p_table(k), p_delim) != 0 THEN
      raise_application_error (-20500, 'Invalid Delimiter');
    End If;

    IF k > 1 THEN
      l_list := l_list || p_delim || p_table(k);
    Else
      l_list := l_list || p_table(k);
    End IF;
    
  End Loop;
  
  RETURN l_list;
  
END table2list;

--
--  перегружена ф-я повертає integer масив у вигляді стоки з розділювачем
--
function table2list( p_table in number_list,
                     p_delim in varchar2
                   )
return varchar2
IS
  l_list  varchar2(4000);
begin

  If p_delim Is Null then
    raise_application_error (-20500, 'invalid delimiter');
  end if;
  
  l_list := null;
  
  For k in p_table.first .. p_table.last
  Loop

    If k > 1 Then
      l_list := l_list || p_delim || p_table(k);
    Else
      l_list := l_list || p_table(k);
    End If;
    
  End Loop;
  
  RETURN l_list;
  
END table2list;


function table2list_EX
( p_tab_name    all_tab_cols.table_name%type   -- назва наблиці
, p_col_name    all_tab_cols.column_name%type  -- назва поля типу varchar2
, p_condition   varchar2  default null         -- умова для відбору запиів ([where ... ]|[order by...])
) return varchar2
is
  l_table  varchar2_list;
  l_sql    varchar2(500);
begin
  
  l_sql := 'select ' || p_col_name || ' from ' || p_tab_name || ' ' || p_condition;
  
  begin
    execute immediate l_sql bulk collect into l_table;
  exception
    when others then
      bars_audit.error( 'DPT_UTILS.TABLE2LIST_EX: l_sql=' || l_sql || dbms_utility.format_error_stack() || dbms_utility.format_error_backtrace() );
  end;
  
  if l_table.count > 0 
  then
    RETURN dpt_utils.table2list( p_table => l_table,
                                 p_delim => ','
                               );
  else
    RETURN '<null>';
  end if;
  
end table2list_EX;


/*
--
--  повертає вміст стоки з розділювачем у вигляді масиву VARCHAR2
--
FUNCTION list2table( p_list  IN varchar2,
                     p_delim IN varchar2 )
  RETURN varchar2_list
  PIPELINED
IS
  l_pos_last  pls_integer;
  l_pos_curr  pls_integer;
  l_ret_val   varchar2(500);
BEGIN
  
  IF p_delim IS NULL THEN
    raise_application_error (-20500, 'Invalid Delimiter');
  END IF;
  
  l_pos_last := length(p_list);
  l_pos_curr := 0;
  
  LOOP
    
    l_pos_curr := InStr(p_list, p_delim, (l_pos_curr + 1), 1);
    
    EXIT WHEN l_pos_curr = 0;
    
    l_ret_val := SubStr(p_list, last_pos,length(in_str)));
    
    If Length(l_ret_val) > 0 Then
      PIPE ROW ( l_ret );
    Else
      null;
    End if;
    
  END LOOP;
  
  RETURN;
  
END list2table;
*/


--
-- ф-я повертає вміст p_clob частинами по p_str_size символів
-- у вигляді varchar2 таблиці
--
function clob2str
( p_clob      IN OUT NOCOPY CLOB
, p_str_size  IN            NUMBER
) return VARCHAR2_LIST 
  pipelined
is
  l_clobsize  PLS_INTEGER;
  l_offset    PLS_INTEGER;
begin
  l_clobsize := dbms_lob.getlength( p_clob );
  l_offset   := 1;
  
  While l_offset <= l_clobsize
  loop
    
    -- pipe row ( SubStr(p_clob, l_offset, p_str_size) );
    
    -- заміна усіх [LF] на [CR][LF]
    pipe row ( REGEXP_REPLACE( SubStr(p_clob, l_offset, p_str_size), '[^'||CHR(13)||']'||CHR(10), CHR(13)||CHR(10) ) );
    
    l_offset := l_offset + p_str_size;
    
  end loop;
  
  return;
  
end clob2str;

---
-- Повертає insert на заповнення вказаної таблиці 
---
function GET_INSERT4TABLE
( p_tab_name    all_tab_cols.table_name%type
, p_condition   varchar2
, p_offset      number                  default 0
, p_owner       all_tab_cols.owner%type default null
, p_mode        varchar2                default 'I'
) return clob
is
  /* 
   p_tab_name  - назва таблиці
   p_condition - умова відбору записів з табоиці
   p_offset    - к-ть пробілів для відступу
   p_owner     - власник таблиці (назва схеми)
   p_mode      - режим формування DML інструкції (I - only insert, M - insert and update)
  */
  title   constant  varchar2(32) := 'DPT_UTILS.GET_INSERT4TABLE';
  
  l_cols_list_tab   dbms_utility.uncl_array;
  l_cols_type_tab   dbms_utility.name_array;
  l_cols_count      PLS_INTEGER;
  l_cols_list_str   VARCHAR2(1000);
  l_pkey_cols_tab   dbms_utility.uncl_array;
  l_pkey_cols_cnt   PLS_INTEGER;
  l_pkey_column     VARCHAR2(30);
  --
  l_Cursor          integer;
  l_status          integer;
  l_offset          varchar2(10);
  l_owner           all_tab_cols.owner%type;
  l_tbl_nm          all_tab_cols.table_name%type;
  l_sTmp            varchar2(2000);
  l_sTmp2           varchar2(2000);
  l_sTmp3           varchar2(1000);
  l_ValueString     varchar2(1000);
  l_ValueNumber     number;
  l_ValueDate       date;
  l_ValueClob       CLOB;
  --
  l_text            clob;
  
  -- COBUMMFO-9690 Begin
  l_module          varchar2(64);
  l_action          varchar2(64);
  -- COBUMMFO-9690 End
  --
  -- str
  --
  procedure concatenation
  ( p_col_name   in  varchar2,
    p_col_value  in  varchar2
  ) is
  begin
    -- якщо поле входить в перв.ключ
    if (p_col_name = l_pkey_column)
    then
      
      l_sTmp3 := case 
                   when (l_sTmp3 Is Null) then ''
                   else (l_sTmp3 || nlchr || l_offset || '       and ')
                 end || p_col_name || ' = ' || chr(39) || dblquote(p_col_value) || chr(39);
    else
      
      if (p_col_value is null) 
      then
        l_sTmp2 := l_sTmp2 || p_col_name || ' = null';
      else
        l_sTmp2 := l_sTmp2 || p_col_name || ' = ' || chr(39) || dblquote(p_col_value) || chr(39);
      end if;
    
      l_sTmp2 := l_sTmp2|| ',' || nlchr || l_offset || '           ';
      
    end if;
    
  end concatenation;
  --
  -- num
  -- 
  procedure concatenation
  ( p_col_name   in  varchar2,
    p_col_value  in  number
  ) is
  begin
    -- якщо поле входить в перв.ключ
    if (p_col_name = l_pkey_column)
    then
      
      l_sTmp3 := case 
                   when (l_sTmp3 Is Null) then ''
                   else (l_sTmp3 || nlchr || l_offset || '       and ')
                 end || p_col_name || ' = ' || to_char(p_col_value);
      
    else
      
      if (p_col_value is null)
      then
        l_sTmp2 := l_sTmp2 || p_col_name || ' = null';
      else
        l_sTmp2 := l_sTmp2 || p_col_name || ' = ' || to_char(p_col_value);
      end if;
      
      l_sTmp2 := l_sTmp2|| ',' || nlchr || l_offset || '           ';
      
    end if;
    
  end concatenation;
  --
  -- dat
  -- 
  procedure concatenation
  ( p_col_name   in  varchar2,
    p_col_value  in  date
  ) is
  begin
    -- якщо поле входить в PK
    if (p_col_name = l_pkey_column)
    then
      
      l_sTmp3 := case 
                 when (l_sTmp3 Is Null) then ''
                 else (l_sTmp3 || nlchr || l_offset || '       and ')
                 end || p_col_name || ' = to_date(' || chr(39) || to_char(p_col_value, 'dd/mm/yyyy') || chr(39) || ',''dd/mm/yyyy'')';
    else
    
      if (p_col_value is null) 
      then
        l_sTmp2 := l_sTmp2 || p_col_name || ' = null';
      else
        -- Обробка годин, хвилин і секунд (якщо є то повн. формат - інакше тільки дата)
        if (p_col_value > trunc(p_col_value)) then
          l_sTmp2 := l_sTmp2 || p_col_name || ' = to_date(' || chr(39) || to_char(p_col_value, 'dd/mm/yyyy hh24:mi:ss') || chr(39) || ',''dd/mm/yyyy hh24:mi:ss'')';
        else
          l_sTmp2 := l_sTmp2 || p_col_name || ' = to_date(' || chr(39) || to_char(p_col_value, 'dd/mm/yyyy'           ) || chr(39) || ',''dd/mm/yyyy'')';
        end if;
        
      end if;
      
      l_sTmp2 := l_sTmp2|| ',' || nlchr || l_offset || '           ';
      
    end if;
    
  end concatenation;
  --
  -- CLOB
  --
  procedure concatenation
  ( p_col_name   in  varchar2,
    p_col_value  in out NOCOPY CLOB
  ) is
  begin

    if (p_col_value is null) 
    then
      l_sTmp2 := l_sTmp2 || p_col_name || ' = null';
    else
      l_sTmp2 := l_sTmp2 || p_col_name || ' = ' || chr(39) || replace(p_col_value, chr(39), chr(39)||chr(39)) || chr(39);
    end if;
    
    l_sTmp2 := l_sTmp2|| ',' || nlchr || l_offset || '           ';
    
    /*
    l_tmp := length(l_uplsql_row.sql_text);

     case
      when l_tmp = 0 
      then
        l_text := l_text || '  l_Sqltext    := null;' || nlchr;
        
      when l_tmp < 4000 
      then
        l_text := l_text || '  l_Sqltext    := ' || chr(39) || dblquote(l_uplsql_row.sql_text) || chr(39) || ';' || nlchr;
        
      else
        
        l_tmp := CEIL(l_tmp / 4000);
        
        begin
          for k in 1 .. l_tmp
          loop
            l_text := l_text || '  l_Sqltext    := l_Sqltext || ' || chr(39) || 
                      dblquote(SubStr(l_uplsql_row.sql_text, (k-1)*4000+1, 4000)) || chr(39) || ';' || nlchr;
          end loop;
        end;
        
    end case;

    */
  end concatenation;
  --
  -- повертає к-т полів в PRIMARY_KEY
  --
  function GET_PKEY_COLS_COUNT
    return pls_integer
  is
    l_cnt  pls_integer := 0;
  begin

    for i in l_pkey_cols_tab.first .. l_pkey_cols_tab.last
    loop
      
      if ( l_pkey_cols_tab(i) is Not Null )
      then
        l_cnt := l_cnt + 1;
      end if;
      
    end loop;
    
    return l_cnt;
    
  end GET_PKEY_COLS_COUNT;
  ---
begin

  bars_audit.trace( '%s: Start with ( tab_name = %s, condition = %s, offset = %s, mode = %s ).'
                  , title, nvl(p_tab_name,'null'), nvl(p_condition,'null'), to_char(p_offset), p_mode );

  dbms_application_info.read_module(l_module, l_action); -- COBUMMFO-9690
  dbms_application_info.set_action( 'DPT_UTILS.GET_INSERT4TABLE' );
  
  dbms_application_info.set_client_info( 'tab_name=' || nvl(p_tab_name,'null') || ', condition=' || nvl(p_condition,'null') );
  
  if ( p_tab_name is null )
  then
    return null;
  else
    l_tbl_nm := UPPER( p_tab_name );
    sys.DBMS_LOB.CREATETEMPORARY( lob_loc => l_text
                                , cache   => false
                                , dur     => DBMS_LOB.CALL );
  end if;
  
  if ( p_owner Is Null )
  then
    l_owner := 'BARS';
--  l_owner := sys_context('USERENV','CURRENT_SCHEMA');
  else
    l_owner := p_owner;
  end if;
  
  if ( p_offset > 0 ) 
  then
    l_offset := Rpad(' ', p_offset);
  else
    l_offset := '';
  end if;
  
  bars_audit.trace( '%s: owner = %s, condition = %s, mode = %s ).'
                  , title, l_owner, nvl(p_condition,'null'), p_mode );
  --
  -- інформація про структуру талиці:
  --   назва полів;
  --   тип даних полів
  --   унікальний ключ таблиці (поля які у нього входять)
  select tc.COLUMN_NAME, tc.DATA_TYPE, cc.COLUMN_NAME
    BULK COLLECT
    INTO l_cols_list_tab, l_cols_type_tab, l_pkey_cols_tab
    from ALL_TAB_COLS tc
    left
    join ( select cc.table_name, cc.column_name
             from ALL_CONSTRAINTS  c
             join ALL_CONS_COLUMNS cc on ( cc.table_name = c.table_name AND cc.constraint_name = c.constraint_name )
            where c.owner = l_owner
              and c.table_name = l_tbl_nm
              and c.constraint_type = 'P'
          ) cc on ( cc.TABLE_NAME = tc.TABLE_NAME AND cc.COLUMN_NAME = tc.COLUMN_NAME )
   where tc.OWNER = l_owner
     and tc.TABLE_NAME = l_tbl_nm
   order by COLUMN_ID;
  
  dbms_application_info.set_client_info( 'count pkey columns' );
  
  -- к-ть полів що входять у PRIMARY_KEY
  l_pkey_cols_cnt := GET_PKEY_COLS_COUNT();
  
  dbms_application_info.set_client_info( 'pkey_cols_cnt = ' || to_char(l_pkey_cols_cnt) );
  
  -- к-ть полів (l_cols_count) та перелік полів таблиці розділених комою (l_cols_list_str)
  DBMS_UTILITY.TABLE_TO_COMMA( l_cols_list_tab, l_cols_count, l_cols_list_str );
  
  l_Cursor := dbms_sql.open_cursor;
  
  if ( p_condition is null )
  then
    l_sTmp := ( 'select ' || l_cols_list_str || ' from ' || l_owner || '.' || l_tbl_nm );
  else
    l_sTmp := upper(p_condition);
    l_sTmp := replace(p_condition, 'WHERE');
    l_sTmp := ( 'select ' || l_cols_list_str || ' from ' || l_owner || '.' || l_tbl_nm || ' where ' || l_sTmp );
  end if;
  
  if ( UPPER(SYS_CONTEXT('USERENV', 'MODULE')) like '%SQL%PLUS%' )
  then
    dbms_output.put_line( 'SQL Statement:' || l_sTmp );
  else
    bars_audit.trace( '%s SQL Statement: %s;', title, l_sTmp );
  end if;
  
  dbms_sql.parse( l_Cursor, l_sTmp, dbms_sql.native );
  
  -- DEFINE_COLUMNS
  for col in 1..l_cols_count
  loop
    case
      -- Текстові дані
      when l_cols_type_tab(col) in ('VARCHAR2', 'CHAR', 'VARCHAR') then
        dbms_sql.define_column( c           => l_Cursor,
                                position    => col,
                                column      => l_ValueString,
                                column_size => 1000 );
      
      -- Числові данні (NUMBER)
      when l_cols_type_tab(col) in ('NUMBER') then
        dbms_sql.define_column( c        => l_Cursor,
                                position => col,
                                column   => l_ValueNumber );
      
      -- Календарні данні (DATE)
      when l_cols_type_tab(col) in ('DATE') then
        dbms_sql.define_column( c        => l_Cursor,
                                position => col,
                                column   => l_ValueDate );
      
      -- Текстові данні (CLOB)
      when l_cols_type_tab(col) in ('CLOB') then
        dbms_sql.define_column( c        => l_Cursor,
                                position => col,
                                column   => l_ValueClob );
      
      else
        null;
        
    end case;
    
  end loop; 
  
  l_status := dbms_sql.execute(l_Cursor);
  
  -- Fetch a row from the source table
  WHILE DBMS_SQL.FETCH_ROWS( l_Cursor ) > 0 
  LOOP
    
    if ( p_mode = 'I')
    then
      
      l_text := l_text || l_offset || 'Insert into ' || l_owner || '.' || l_tbl_nm || nlchr;
      l_text := l_text || l_offset || '  ( ' || l_cols_list_str || ' )'            || nlchr;
      l_text := l_text || l_offset || 'Values '                                    || nlchr;
      
    else

      l_text := l_text || l_offset || 'begin'                                        || nlchr;
      l_text := l_text || l_offset || '  Insert into ' || l_owner || '.' || l_tbl_nm || nlchr;
      l_text := l_text || l_offset || '    ( ' || l_cols_list_str || ' )'            || nlchr;
      l_text := l_text || l_offset || '  Values '                                    || nlchr;
      
    end if;
    
    l_sTmp  := null;
    l_sTmp2 := null;
    l_sTmp3 := null;
    
    dbms_application_info.set_client_info( 'Processing row #' || to_char(DBMS_SQL.LAST_ROW_COUNT) );
    
    -- get column values of the row
    << on_columns >>
    for col in 1..l_cols_count
    loop
      
      l_pkey_column := l_pkey_cols_tab(col);
      
      case
        -- Текстові дані
        when l_cols_type_tab(col) in ('VARCHAR2', 'CHAR', 'VARCHAR') then
          dbms_sql.column_value( c        => l_Cursor,
                                 position => col,
                                 value    => l_ValueString );
          
          if l_ValueString is null
          then
            l_sTmp := l_sTmp || 'null';
          else
            l_sTmp := l_sTmp || chr(39) || dblquote(l_ValueString) || chr(39);
          end if;
          
          concatenation( l_cols_list_tab(col), l_ValueString );
           
        -- Числові данні
        when l_cols_type_tab(col) in ('NUMBER') then
          dbms_sql.column_value( c        => l_Cursor,
                                 position => col,
                                 value    => l_ValueNumber );
          
          if l_ValueNumber is null
          then
            l_sTmp := l_sTmp || 'null';
          else
            l_sTmp := l_sTmp || to_char(l_ValueNumber);
          end if;
          
          concatenation( l_cols_list_tab(col), l_ValueNumber );
          
        -- Календарні данні
        when l_cols_type_tab(col) in ('DATE') then
          dbms_sql.column_value( c        => l_Cursor,
                                 position => col,
                                 value    => l_ValueDate );
          
          if l_ValueDate is null
          then
            l_sTmp  := l_sTmp  || 'null';
            l_sTmp2 := l_sTmp2 || l_cols_list_tab(col) || ' = null';
          else
            -- Обробка годин, хвилин і секунд (якщо є то повн. формат - інакше тільки дата)
            if (l_ValueDate > trunc(l_ValueDate)) 
            then
              l_sTmp  := l_sTmp  || 'to_date(' || chr(39) || to_char(l_ValueDate, 'dd/mm/yyyy hh24:mi:ss') || chr(39) || ',''dd/mm/yyyy hh24:mi:ss'')';
              l_sTmp2 := l_sTmp2 || l_cols_list_tab(col)  || ' = to_date(' || chr(39) || to_char(l_ValueDate, 'dd/mm/yyyy hh24:mi:ss') || chr(39) || ',''dd/mm/yyyy hh24:mi:ss'')';
            else
              l_sTmp  := l_sTmp  || 'to_date(' || chr(39) || to_char(l_ValueDate, 'dd/mm/yyyy') || chr(39) || ',''dd/mm/yyyy'')';
              l_sTmp2 := l_sTmp2 || l_cols_list_tab(col)  || ' = to_date(' || chr(39) || to_char(l_ValueDate, 'dd/mm/yyyy') || chr(39) || ',''dd/mm/yyyy'')';
            end if;
            
          end if;
          
          concatenation( l_cols_list_tab(col), l_ValueDate );
          
        -- Текстові данні (CLOB)
        when l_cols_type_tab(col) in ('CLOB') then
          dbms_sql.column_value( c        => l_Cursor,
                                 position => col,
                                 value    => l_ValueClob );
          
          if ( l_ValueClob is Null )
          then
            l_sTmp := l_sTmp || 'null';
          else
            l_sTmp := l_sTmp || chr(39) || replace(l_ValueClob, chr(39), chr(39)||chr(39)) || chr(39);
          end if;
          
          concatenation( l_cols_list_tab(col), l_ValueClob );
        
        else -- Поля BLOB, LONG ...
          null;
      end case;
      
      -- дадаєм кому
      if col != l_cols_count 
      then
        l_sTmp := (l_sTmp || ', ');
      else
        l_sTmp2 := SubStr(l_sTmp2, 1, length(l_sTmp2) - (15+p_offset));
      end if;
      
    end loop on_columns;
    
    bars_audit.trace( '%s values ( %s )', title, l_sTmp );
    dbms_application_info.set_client_info( 'finished make statment for row ' || to_char(DBMS_SQL.LAST_ROW_COUNT) );
    
    if ( p_mode = 'I')
    then
    
      l_text := l_text   || l_offset ||'  ( ' || l_sTmp || ' ); '                     ||nlchr;
      
    else

      l_text := l_text   || l_offset ||'    ( ' || l_sTmp || ' );'                    ||nlchr;
      l_text := l_text   || l_offset ||'  dbms_output.put_line( ''1 row created.'' );'||nlchr;
      l_text := l_text   || l_offset ||'exception'                                    ||nlchr;
      l_text := l_text   || l_offset ||'  when DUP_VAL_ON_INDEX then'                 ||nlchr;
      
      -- якщо к-ть полів таблиці = к-ті полів в індексі (INDEX ORGANIZED) то null
      If (l_cols_count = l_pkey_cols_cnt)
      Then
        l_text := l_text || l_offset ||'    null;'                                      ||nlchr;
      Else
        l_text := l_text || l_offset ||'    update ' || l_owner || '.' || l_tbl_nm      ||nlchr;
        l_text := l_text || l_offset ||'       set ' || l_sTmp2                         ||nlchr;
        l_text := l_text || l_offset ||'     where ' || l_sTmp3 || ';'                  ||nlchr;
        l_text := l_text || l_offset ||'    dbms_output.put_line( ''1 row updated.'' );'||nlchr;
      End If;

      l_text := l_text   || l_offset ||'end;'                                           ||nlchr;

      if ( p_offset = 0 ) 
      then -- для звичайної вигрузки інсертів додаємо символ "/"
        l_text := l_text || '/ '                   || nlchr;
      end if;

    end if;

    l_text := l_text || nlchr;

  end loop;

  l_cols_list_tab.delete();
  l_cols_type_tab.delete();
  l_pkey_cols_tab.delete();

  IF DBMS_SQL.IS_OPEN( l_Cursor )
  THEN
    DBMS_SQL.CLOSE_CURSOR( l_Cursor );
  END IF;

  dbms_application_info.set_module(l_module, l_action /*NULL,NULL -- COBUMMFO-9690*/);
  dbms_application_info.set_client_info(Null);

  bars_audit.trace( '%s Exit.', title );

  return l_text;
  
exception
  when OTHERS then
    
    l_cols_list_tab.delete();
    l_cols_type_tab.delete();
    l_pkey_cols_tab.delete();

    IF DBMS_SQL.IS_OPEN( l_Cursor ) 
    THEN
      DBMS_SQL.CLOSE_CURSOR( l_Cursor );
    END IF;
    
    DBMS_LOB.close( l_text );
    DBMS_LOB.FREETEMPORARY( l_text );
    
    dbms_application_info.set_module(l_module, l_action); -- COBUMMFO-9690
    RAISE_APPLICATION_ERROR( -20666, dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace(), true );
    
end GET_INSERT4TABLE;

--
-- створення сценарію вивантаження даних таблиці DPT_BRATES 
-- ( також експортуються необхідні базові ставки )
--
function gen_script4dptbrates ( p_modcode   in  bars_supp_modules.mod_code%type,
                                p_str_size  in  number  default 2000 )
  return varchar2_list 
         pipelined
is
  title       constant varchar2(60) := 'gen_dptbrates:';
  l_script    clob;
  l_text      varchar2(32000);
  l_clobsize  pls_integer;
  l_offset    pls_integer;
begin
  bars_audit.trace( '%s entry with: modcode => %s, str_size = %s', title, nvl(p_modcode,'null'), to_char(p_str_size) );
  
  dbms_lob.createtemporary (l_script,  false);
  
  l_text := 'prompt =========================================================== '||nlchr||
            'prompt === ЕКСПОРТ БАЗОВИХ СТАВОК ДЛЯ ВИДІВ ДЕПОЗИТІВ ФІЗ.ОСІБ === '||nlchr||
            'prompt =========================================================== '||nlchr||
            ''                                                                   ||nlchr||
            'set serveroutput on'                                                ||nlchr||
            'set feed off'                                                       ||nlchr||
            ''                                                                   ||nlchr||
            'begin '                                                             ||nlchr||
            '-- generated at '|| to_char(sysdate,'dd/mm/yyyy hh24:mi:ss')        ||nlchr||
            ''                                                                   ||nlchr||
            '  -- базові ставки видів '                                          ||nlchr||
            ''                                                                   ||nlchr ;
  
  dbms_lob.append(l_script, l_text);
  
  -- вигружаєм базові ставки які наявні в таблиці BRATES
  if p_modcode is null then
    l_text := get_insert4table( 'BRATES', 'BR_ID IN (select BR_ID from DPT_BRATES)' );
  else
    l_text := get_insert4table( 'BRATES', 'BR_ID IN (select BR_ID from DPT_BRATES where MOD_CODE = '||chr(39)||p_modcode||chr(39)||')' );
  end if;
  
  dbms_lob.append(l_script, l_text);
  
  l_text := ''                                                                   ||nlchr||
            '  -- історія змін базових ставок по видам банківськи продуктів '    ||nlchr||
            ''                                                                   ||nlchr ;
  
  dbms_lob.append(l_script, l_text);
  
  -- вигружаєм дані з таблиці DPT_BRATES
  if p_modcode is null then
    l_text := get_insert4table( 'DPT_BRATES', null );
  else
    l_text := get_insert4table( 'DPT_BRATES', 'MOD_CODE = '||chr(39)||p_modcode||chr(39) );
  end if;
  
  dbms_lob.append(l_script, l_text);
   
  l_text := ''                                                                   ||nlchr||
            '  commit;'                                                          ||nlchr||
            ''                                                                   ||nlchr||
            'end;'                                                               ||nlchr||
            '/'                                                                  ||nlchr||
            ''                                                                   ||nlchr||
            'set feed on'                                                        ||nlchr ;
  
  dbms_lob.append(l_script, l_text);
  l_text := null;
  
  l_clobsize := dbms_lob.getlength( l_script );
  l_offset   := 1;
  
  While l_offset <= l_clobsize
  loop
    
    pipe row ( SubStr(l_script, l_offset, p_str_size) );
    
    l_offset := l_offset + p_str_size;
    
  end loop;
  
  dbms_lob.freetemporary( l_script );
  
  bars_audit.trace('%s exit with: clobsize = %s', title, to_char(l_clobsize) );
  
  return;
  
exception
  when others then
    raise_application_error( -20000, dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace(), true );
    --bars_error.raise_nerror (modcod, 'GEN_EXPDPTYPE_FAILED', to_char(0), sqlerrm);
end gen_script4dptbrates;

--
-- процедура нормалізації сіквенсів таблиці
--
procedure NORMALIZATION_SEQUENCE
( p_tab_name  in  all_tab_cols.table_name%type,  -- назва таблиці
  p_last_val  in  number default null            -- значення сіквенса (якщо треба поставити своє)
) is
  l_sequence  all_sequences.sequence_name%type;
  l_column    all_tab_columns.column_name%type;
  l_seq_id    number;
  l_tab_id    number;
  err_null    exception;
begin

  begin
    select COLUMN_NAME
      into l_column
      from ALL_CONS_COLUMNS
     where (OWNER, CONSTRAINT_NAME, TABLE_NAME) in ( select OWNER, CONSTRAINT_NAME, TABLE_NAME from ALL_CONSTRAINTS
                                                      where OWNER = 'BARS' AND TABLE_NAME = p_tab_name AND CONSTRAINT_TYPE = 'P' );
  exception
  -- якщо PK не з одного поля значить sequence у нього немає
    when TOO_MANY_ROWS then
      bars_audit.trace( 'NORMALIZATION_SEQUENCE: not found primary key in %s', p_tab_name );
      raise err_null;
  end;
  
  begin
    select REFERENCED_NAME  
      into l_SEQUENCE
      from ALL_DEPENDENCIES
     where REFERENCED_TYPE = 'SEQUENCE'
        and (OWNER, NAME) in ( select OWNER, TRIGGER_NAME from ALL_TRIGGERS 
                                where OWNER = 'BARS' AND TABLE_NAME = p_tab_name );
  exception
  -- якщо немає sequence у таблиці
    when NO_DATA_FOUND then
      bars_audit.trace( 'NORMALIZATION_SEQUENCE: not found sequence for %s', p_tab_name );
      raise err_null;
  end;
  
  bars_audit.trace('NORMALIZATION_SEQUENCE: SEQUENCE_NAME = %s, COLUMN_NAME = %s', l_SEQUENCE, l_column );
  
  execute immediate 'select '||l_SEQUENCE||'.nextval from dual'
     into l_seq_id;
  
  if ( p_last_val is null ) then
    execute immediate 'select max('||l_column||') from '||p_tab_name
       into l_tab_id;
  else
    l_tab_id := p_last_val;
  end if;
  
  bars_audit.trace('NORMALIZATION_SEQUENCE: SEQUENCE LAST VALUE = %s, MAX COLUMN VALUE = %s', to_char(l_seq_id), to_char(l_tab_id) );
  
  if (l_tab_id != l_seq_id) then
     
    execute immediate 'alter sequence ' || l_SEQUENCE || ' increment by ' || to_char(l_tab_id - l_seq_id);

    execute immediate 'select '         || l_SEQUENCE || '.nextval from dual'
       into l_seq_id;
      
    execute immediate 'alter sequence ' || l_SEQUENCE || ' increment by 1';
    
    bars_audit.trace('NORMALIZATION_SEQUENCE: SEQUENCE NEW VALUE = %s', to_char(l_seq_id) );
    
  end if;
  
exception
  when ERR_NULL then
    null;
  when OTHERS   then
    raise_application_error(-20000, dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace());
end NORMALIZATION_SEQUENCE;

--
-- процедура відновлення депозитного договору з архіву
--
procedure RECOVERY_CONTRACT( p_dptid  in   dpt_deposit.deposit_id%type )  -- ідентифікатор деп.договору ФО
is
  title   constant varchar2(32) := 'RECOVERY_CONTRACT';
  l_dpt   dpt_deposit_clos%rowtype;

  -- COBUMMFO-9690 Begin
  l_module          varchar2(64);
  l_action          varchar2(64);
  -- COBUMMFO-9690 End
begin

  dbms_application_info.read_module(l_module, l_action); -- COBUMMFO-9690
  dbms_application_info.set_action('recovery_deposit');
 
  begin
    select c.* 
      into l_dpt
      from DPT_DEPOSIT_CLOS c
     where c.action_id in (1,2)
       and c.deposit_id = p_dptid
       and not exists (select 1 from dpt_deposit d where d.deposit_id = c.deposit_id);
  exception
    when no_data_found then
      raise_application_error(-20000, 'Вклад не найден или не закрыт!');
  end;

  -- видаляєм запис про закриття депозиту
  delete DPT_DEPOSIT_CLOS
   where IDUPD = l_dpt.idupd;

  -- повертаєм депозит в портфель та вставляэмо запис про відновлення з архіву
  insert
    into DPT_DEPOSIT
       ( DEPOSIT_ID, ND, VIDD, ACC, KV, RNK,
         FREQ, DATZ, DAT_BEGIN, DAT_END, DAT_END_ALT,
         MFO_P, NLS_P, NAME_P, OKPO_P,
         DPT_D, ACC_D, MFO_D, NLS_D, NMS_D, OKPO_D,
         LIMIT, DEPOSIT_COD, COMMENTS, STOP_ID, CNT_DUBL,
         CNT_EXT_INT, DAT_EXT_INT, KF, BRANCH, USERID )
  values
       ( l_dpt.deposit_id, l_dpt.nd, l_dpt.vidd, l_dpt.acc, l_dpt.kv, l_dpt.rnk,
         l_dpt.freq,  l_dpt.datz,  l_dpt.dat_begin, l_dpt.dat_end, l_dpt.dat_end_alt,
         l_dpt.mfo_p, l_dpt.nls_p, l_dpt.name_p, l_dpt.okpo_p,
         l_dpt.dpt_d, l_dpt.acc_d, l_dpt.mfo_d, l_dpt.nls_d, l_dpt.nms_d, l_dpt.okpo_d,
         l_dpt.limit, l_dpt.deposit_cod, l_dpt.comments, l_dpt.stop_id, l_dpt.cnt_dubl,
         l_dpt.cnt_ext_int, l_dpt.dat_ext_int, l_dpt.kf, l_dpt.branch, l_dpt.userid );

  -- реанімуємо рахунки
  for ac in ( select ACCID from DPT_ACCOUNTS where DPTID = l_dpt.deposit_id )
  loop
    -- ACCREG.P_ACC_RESTORE( ac.ACCID );
    update ACCOUNTS
       set DAZS = NULL
     where ACC = ac.ACCID
       and DAZS Is Not Null;
  end loop;

  bars_audit.info( title || ': Вклад # '||to_char(p_dptid)||' успішно відновлено!' ); 

  dbms_application_info.set_action(l_action /*null -- COBUMMFO-9690*/);
exception
  when others then
    dbms_application_info.set_action(l_action /*null -- COBUMMFO-9690*/);
    bars_audit.error( title||': '||dbms_utility.format_error_stack()||dbms_utility.format_error_backtrace() );
    raise_application_error( -20000, dbms_utility.format_error_stack()||dbms_utility.format_error_backtrace(), true );
end RECOVERY_CONTRACT;


--
-- ф-я повертає ХЕШ депозитного договору
--
function get_DptHash ( p_dptid   in   dpt_deposit.deposit_id%type )   -- ідентифікатор деп.договору
  return varchar2
is
  title       constant varchar2(60) := 'DPT_UTILS.get_DptHash: ';
  modcode     constant varchar2(3)  := 'DPT';
  l_str_data  VARCHAR2(250);
  l_raw_data  RAW(2000);
  l_str_key   varchar(8);
  l_raw_key   RAW(32);
begin
  /*
  begin
    --  дата операции, сума, валюта, %% ставка,  бранч, ід юзера    
    select to_char(sysdate,'dd/mm/yyyy hh24:mi') ||';'||to_char(d.limit)||'/'||to_char(d.kv)||';'||
           to_char(dpt.fproc(d.acc, bankdate),'FM990D099')||'%'||';'||d.branch||';'||to_char(user_id)  
      into l_str_data
      from DPT_DEPOSIT_CLOS d
     where d.deposit_id = p_dptid
       and d.action_id  = 0;
  exception
    when NO_DATA_FOUND then
       bars_error.raise_nerror( modcode, 'DPT_NOT_FOUND', to_char(p_dptid) );
  end;
  
  -- return lower(rawtohex);
  
  -- dbms_crypto.hash(utl_raw.cast_to_raw(l_str_data), 2) -- MD5
  
  -- Для шифрування використовується 8 байтовий ключ 
  l_str_key  := ('<'||F_OURMFO_G||'>');
  
  l_raw_data := UTL_I18N.STRING_TO_RAW (l_str_data, 'AL32UTF8');
  l_raw_key  := UTL_I18N.STRING_TO_RAW (l_str_key,  'AL32UTF8');
  
  RETURN RAWTOHEX( SYS.DBMS_CRYPTO.ENCRYPT( TYP => SYS.DBMS_CRYPTO.DES_CBC_PKCS5,
                                            SRC => l_raw_data,
                                            KEY => l_raw_key )
                 );
  */
  return null;
end get_DptHash;

--
-- Сихронізація рахунків витрат 
-- (в %% картках рахунків депозитного потрфеля з довідникам proc_dr$base)
--
procedure sync_acc_expenses
( p_vidd  in   dpt_vidd.vidd%type )
is
  l_acc7  accounts.acc%type;
  l_id    int_accn.id%type := 1;
  l_nbs   dpt_vidd.bsd%type;
  --
  -- internal function and procedure
  --
  function get_acc
  ( p_nls  accounts.nls%type,
    p_kv   accounts.kv%type
  ) return accounts.acc%type
  RESULT_CACHE -- RELIES_ON(PROC_DR$BASE)
  is
    l_acc  accounts.acc%type;
  begin
    begin
      select acc
        into l_acc
        from BARS.accounts
       where nls = p_nls
         and kv  = p_kv
         and dazs is null;
    exception
      when NO_DATA_FOUND then
        bars_audit.trace( 'DPT_UTILS.sync_acc_expenses: не знайдено рахунок №' ||p_nls||'/'||p_kv );
        l_acc := null;
    end;
    
    Return l_acc;
    
  end get_acc;
  ---
begin
  
  begin
    select bsd
      into l_nbs
      from BARS.dpt_vidd
     where vidd = p_vidd;
  exception
    when NO_DATA_FOUND then
      bars_error.raise_nerror( 'DPT', 'VIDD_NOT_FOUND', to_char(p_vidd) );
  end;
  
  for k in ( select d.acc, i.acrb, a.nls, p.g67
               from DPT_DEPOSIT  d,
                    INT_ACCN     i,
                    ACCOUNTS     a,
                    PROC_DR$BASE p
              where d.vidd = p_vidd
                and (i.acc = d.acc and i.id = l_id)
                and a.acc = i.acrB
                and p.nbs = l_nbs
                and p.branch = d.branch
                and p.sour = 4
                and p.rezid = d.vidd
                and a.nls <> p.g67 )
  loop
    
    l_acc7 := get_acc(k.g67, 980);
    
    if (l_acc7 is not null) then
      update BARS.INT_ACCN
         set acrB = l_acc7
       where ACC = k.acc
         and ID  = l_id;
    end if;
    
  end loop;
  
end sync_acc_expenses;

---
-- Приєднання шаблону до виду депозиту
---
procedure SET_VIDD_TEMPLATE
( p_vidd      in   dpt_vidd.vidd%type,
  p_template  in   doc_scheme.id%type,
  p_flags     in   dpt_vidd_flags.id%type default null
) is
  l_fr             doc_scheme.fr%type;
  l_flags          dpt_vidd_flags.id%type;
  l_template       doc_scheme.id%type;
  l_template_fr    doc_scheme.id%type;
begin
  
  begin 
    -- перевірка наявності шаблону та визначення його типу 
    select FR
      into l_fr
      from DOC_SCHEME
     where id = p_template;
    
    if (l_fr = 0)
    then
      l_template    := p_template;
      l_template_fr := null;
    else
      l_template    := p_template;
      l_template_fr := p_template;
    end if;
        
    if (p_flags is Null)
    then
      -- якщо не вказнано до якого коду ДУ відноститься - беремо перший вільний
      select min(id)
        into l_flags
        from DPT_VIDD_FLAGS
       where ID not in ( select flags from dpt_vidd_scheme where vidd = p_vidd )
         and ACTIVITY = 1;
    else
      l_flags := p_flags;
    end if;
    
    begin
      insert into BARS.DPT_VIDD_SCHEME
        ( VIDD, FLAGS, ID, ID_FR )
      values
        ( p_vidd, l_flags, l_template, l_template_fr );
    exception
      when DUP_VAL_ON_INDEX then
        update BARS.DPT_VIDD_SCHEME
           set ID    = l_template,
               ID_FR = l_template_fr
         where vidd  = p_vidd
           and flags = l_flags;
    end;
  
  end;
  
end SET_VIDD_TEMPLATE;

--
--
--
PROCEDURE UPD_VIDD_TEMPLATE
( p_vidd      IN   dpt_vidd.vidd%TYPE,
  p_template  IN   doc_scheme.id%TYPE,
  p_flags     IN   dpt_vidd_flags.id%TYPE DEFAULT NULL
) IS
  l_fr             doc_scheme.fr%TYPE;
  l_flags          dpt_vidd_flags.id%TYPE;
  l_template       doc_scheme.id%TYPE;
  l_template_fr    doc_scheme.id%TYPE;
BEGIN
  
  -- перевірка наявності шаблону та визначення його типу
  SELECT FR
    INTO l_fr
    FROM DOC_SCHEME
   WHERE id = p_template;
  
  BEGIN
     IF (l_fr = 0)
     THEN
        UPDATE bars.dpt_vidd_scheme
           SET flags = p_flags
         WHERE vidd = p_vidd 
           AND id = p_template;
     ELSE
        UPDATE bars.dpt_vidd_scheme
           SET flags = p_flags
         WHERE vidd = p_vidd 
           AND id_fr = p_template;
     END IF;
  EXCEPTION
     WHEN DUP_VAL_ON_INDEX
     THEN
        bars_error.raise_nerror ('DPT', 'ERROR_TEMPLATES');
  END;
  
END UPD_VIDD_TEMPLATE;

---
-- remove template
---
-- REM_VIDD_TEMPLATE

---
-- Перенесення протоколу виконання автоматичних операцій 
-- депозитного модуля ФО до архіву
---
procedure TRANSFER_LOG2ARCHIVE
( p_parallel  in     number default 0
) is
  l_date             date;
  l_count            pls_integer;
  type t_list        is table of DPT_JOBS_LOG.RUN_ID%type;
  l_list             t_list;
begin
  
  l_date := trunc(sysdate,'YYYY');
  
  bars_audit.info('DPT_UTILS.transfer_log2archive: start with date = ' || to_char(l_date,'dd/mm/yyyy') || '.');
  
  IF ( p_parallel = 0 )
  THEN 
    
    begin 
      
      bars_audit.info( 'DPT_UTILS.transfer_log2archive: move data to archive without Parallelism.' );
      
      select RUN_ID
        bulk collect
        into l_list
        from BARS.DPT_JOBS_JRNL
       where BANK_DATE < l_date;
      
      l_count := l_list.count;
      
      if ( l_count > 0 )
      then -- move to archive one by one
        
        for i in 1..l_count
        loop
          
          begin
            
            insert 
              into BARS.DPT_JOBS_LOG_ARCH
                 ( REC_ID, RUN_ID, JOB_ID, DPT_ID, BRANCH, REF, RNK, KV, DPT_SUM, INT_SUM
                 , STATUS, ERRMSG, NLS, CONTRACT_ID, DEAL_NUM, RATE_VAL, RATE_DAT, KF )
            select REC_ID, RUN_ID, JOB_ID, DPT_ID, BRANCH, REF, RNK, KV, DPT_SUM, INT_SUM
                 , STATUS, ERRMSG, NLS, CONTRACT_ID, DEAL_NUM, RATE_VAL, RATE_DAT, KF
              from BARS.DPT_JOBS_LOG
             where RUN_ID = l_list(i);
          
          exception
            when OTHERS then
              bars_audit.info('DPT_UTILS.transfer_log2archive: error moving rows to archive with run_id = ' || to_char(l_list(i)) );
              l_list.delete(i); -- 
          end;
          
        end loop;
        
        -- remove from active table
        forall d in indices of l_list
        delete BARS.DPT_JOBS_LOG
         where RUN_ID = l_list(d);
      
      end if;
      
    end;
  
  ELSE
    
    begin
      
      bars_audit.info('DPT_UTILS.transfer_log2archive: move data to archive WITH PARALLELISM.');
      
      execute immediate 'ALTER SESSION ENABLE PARALLEL DML';  
      
      insert /*+ APPEND */
        into BARS.DPT_JOBS_LOG_ARCH
      select /*+ parallel(DPT_JOBS_LOG)*/ *
        from BARS.DPT_JOBS_LOG
       where run_id in ( select run_id 
                           from BARS.DPT_JOBS_JRNL
                          where bank_date < l_date );
      
      l_count := SQL%ROWCOUNT;
      
      bars_audit.trace('DPT_UTILS.transfer_log2archive: moved to the archive ' || to_char(l_count) || ' records.');
      
      delete from BARS.DPT_JOBS_LOG
       where run_id in ( select run_id 
                           from BARS.DPT_JOBS_JRNL
                          where bank_date < l_date );
    
    end;
    
  END IF;
  
  If (l_count > 0)
  Then
    
    execute immediate 'ALTER TABLE BARS.DPT_JOBS_LOG ENABLE ROW MOVEMENT';
    
    execute immediate 'ALTER TABLE BARS.DPT_JOBS_LOG SHRINK SPACE CASCADE';
    
  Else
    
    bars_audit.info('DPT_UTILS.transfer_log2archive: No entries found for the transfer of the archive.');
    
  End If;
      
  bars_audit.info('DPT_UTILS.transfer_log2archive: completed.');
  
end TRANSFER_LOG2ARCHIVE; 


END DPT_UTILS;
/

show err;

grant EXECUTE on DPT_UTILS to BARS_ACCESS_DEFROLE;
grant EXECUTE on DPT_UTILS to DPT_ADMIN;
