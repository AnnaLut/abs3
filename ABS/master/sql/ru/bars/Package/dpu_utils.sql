create or replace package DPU_UTILS
is
  -------------------------------------------------------------
  --                                                         --
  --   Пакет вспомогательных функций для работы модуля DPU   --
  --                                                         --
  -------------------------------------------------------------

  --
  -- constants
  --
  head_ver     constant varchar2(64)  := 'version 1.21 16.11.2017';
  head_awk     constant varchar2(512) := '';

  --
  -- types
  --

  --
  -- variables
  --

  --
  -- HEADER_VERSION() - функция определения версии заголовка пакета
  --
  function header_version return varchar2;

  --
  -- BODY_VERSION() - функция определения версии тела пакета
  --
  function body_version   return varchar2;

  --
  -- GEN_SCRIPT4VIDD() - процедура создания сценария для выгрузки вида депозита
  --
  -- Параметры:
  --            p_vidd - код вида депозитного договора юр.лица
  --
  procedure gen_script4vidd (p_vidd in dpu_vidd.vidd%type);

  --
  -- GEN_SCRIPT4TYPES() - ф-я  створення сценарію для експорту типу депозиту ЮО
  --
  -- Параметри:
  --            p_typeid - код типу депозитного продукту ЮО
  --
  function gen_script4types
  ( p_typeid in dpu_types.type_id%type )
  return varchar2_list pipelined;

  --
  -- Синхронізація параметрів продукту з видами депозитів
  --
  -- Параметри:
  --            p_typeid - код типу депозитного продукту ЮО
  --
  procedure TYPE_CONSTRUCTOR
  ( p_typeid       in     dpu_types.type_id%type
  );

  --
  -- SET_DPUVIDDRATE() - процедура валидации и записи строки в справочник
  --                     "Шкалы процентных ставок по депозитам ЮЛ"
  --
  -- Параметры:
  --              p_id - идентификатор записи
  --              p_kf - код філіалу (МФО)
  --          p_typeid - код типа депозитного договора юр.лица
  --              p_kv - числовой код валюты
  --            p_vidd - код вида депозитного договора юр.лица
  --        p_termmnth - срок депозита в месяцах
  --        p_termdays - срок депозита в днях
  --        p_termincl - признак включения гран.срока в диапазон
  --           p_limit - граничная сумма в коп.
  --        p_summincl - признак включения гран.суммы в диапазон
  --         p_actrate - процентная ставка
  --         p_maxrate - макс.допустимая процентная ставка
  --
  procedure SET_DPUVIDDRATE
  ( p_id           in     dpu_vidd_rate.id%type
  , p_kf           in     dpu_vidd_rate.kf%type
  , p_typeid       in     dpu_vidd_rate.type_id%type
  , p_kv           in     dpu_vidd_rate.kv%type
  , p_vidd         in     dpu_vidd_rate.vidd%type
  , p_termmnth     in     dpu_vidd_rate.term%type
  , p_termdays     in     dpu_vidd_rate.term_days%type
  , p_termincl     in     dpu_vidd_rate.term_include%type
  , p_limit        in     dpu_vidd_rate.limit%type
  , p_summincl     in     dpu_vidd_rate.summ_include%type
  , p_actrate      in     dpu_vidd_rate.rate%type
  , p_maxrate      in     dpu_vidd_rate.max_rate%type
  );

  --
  --
  --
  procedure ADD_SUBTYPE
  ( p_tp_id        in     dpu_vidd.type_id%type
  , p_sbtp_code    in     dpu_vidd.dpu_code%type
  , p_sbtp_nm      in     dpu_vidd.name%type
  , p_ccy_id       in     dpu_vidd.kv%type
  , p_nbs_dep      in     dpu_vidd.bsd%type
  , p_nbs_int      in     dpu_vidd.bsn%type
  , p_prd_tp_id    in     number -- deprecated
  , p_term_tp      in     dpu_vidd.term_type%type
  , p_term_min     in     dpu_vidd.term_min%type
  , p_term_max     in     dpu_vidd.term_max%type
  , p_amnt_min     in     dpu_vidd.min_summ%type
  , p_amnt_max     in     dpu_vidd.max_summ%type      default null
  , p_amnt_add     in     dpu_vidd.limit%type         default null
  , p_line         in     dpu_vidd.FL_EXTEND%type     default 0
  , p_longation    in     dpu_vidd.fl_autoextend%type default 0
  , p_replenish    in     dpu_vidd.fl_add%type        default 0
  , p_comproc      in     dpu_vidd.COMPROC%type       default 0
  , p_irvcbl       in     dpu_vidd.IRVK%type          default 1
  , p_basey        in     dpu_vidd.basey%type         default 0
  , p_metr         in     dpu_vidd.metr%type          default 0
  , p_freq         in     dpu_vidd.freq_v%type        default 5
  , p_br_id        in     dpu_vidd.br_id%type         default null
  , p_tt           in     dpu_vidd.tt%type            default 'DU%'
  , p_pny_id       in     dpu_vidd.id_stop%type       default -1
  , p_fine         in     dpu_vidd.penya%type         default null
  , p_exn_mth      in     dpu_vidd.exn_mth_id%type    default null
  , p_tpl_id       in     dpu_vidd.shablon%type
  , p_comment      in     dpu_vidd.comments%type      default null
  , p_sbtp_id      out    dpu_vidd.vidd%type
  , p_err_msg      out    varchar2
  );

  --
  --
  --
  procedure UPD_SUBTYPE
  ( p_sbtp_id      in     dpu_vidd.vidd%type
  , p_sbtp_code    in     dpu_vidd.dpu_code%type
  , p_sbtp_nm      in     dpu_vidd.name%type
  , p_term_tp      in     dpu_vidd.term_type%type
  , p_term_min     in     dpu_vidd.term_min%type
  , p_term_max     in     dpu_vidd.term_max%type
  , p_amnt_min     in     dpu_vidd.min_summ%type
  , p_amnt_max     in     dpu_vidd.max_summ%type
  , p_amnt_add     in     dpu_vidd.limit%type
  , p_longation    in     dpu_vidd.fl_autoextend%type
  , p_replenish    in     dpu_vidd.fl_add%type
  , p_comproc      in     dpu_vidd.COMPROC%type
  , p_irvcbl       in     dpu_vidd.IRVK%type
  , p_freq         in     dpu_vidd.freq_v%type
  , p_br_id        in     dpu_vidd.br_id%type
  , p_tt           in     dpu_vidd.tt%type
  , p_pny_id       in     dpu_vidd.id_stop%type
  , p_fine         in     dpu_vidd.penya%type         default null
  , p_exn_mth      in     dpu_vidd.exn_mth_id%type    default null
  , p_tpl_id       in     dpu_vidd.shablon%type
  , p_comment      in     dpu_vidd.comments%type
  , p_err_msg      out    varchar2
  );

  --
  -- Зміна ознаки активності виду депозиту
  --
  procedure SUBTYPE_CHG_STE
  ( p_sbtp_id      in     dpu_vidd.vidd%type
  , p_sbtp_ste     in     dpu_vidd.flag%type
  );

  --
  --
  --
  procedure DEL_SUBTYPE
  ( p_sbtp_id      in     dpu_vidd.vidd%type
  , p_err_msg      out    varchar2
  );

  --
  --
  --
  procedure DEL_SUBTYPE
  ( p_sbtp_id      in     dpu_vidd.vidd%type
  );

  --
  -- Експорт вид депозиту в SQL-сценарій
  --
  procedure EXPRT_SUBTYPE
  ( p_sbtp_id      in     dpu_vidd.vidd%type
  , p_script          out clob
  , p_file_nm         out varchar2
  );

  --
  -- Новий код штрафу
  --
  procedure CRT_PENALTY
  ( penalty_nm     in     dpt_stop.name%type
  , msr_prd_code   in     dpt_stop.fl%type       default 0
  , pny_bal_tp     in     dpt_stop.sh_ost%type   default 2
  , ruthless       in     dpt_stop.sh_proc%type  default 0
  );

  --
  -- Новий код штрафу
  --
  procedure add_penalty
  ( penalty_nm     in     dpt_stop.name%type
  , msr_prd_id     in     dpt_stop.fl%type       default 0 -- В %-ах від строку
  , pny_bal_tp     in     dpt_stop.sh_ost%type   default 2 -- По історії залишку
  , ruthless       in     dpt_stop.sh_proc%type  default 0 -- Без
  , module_code    in     dpt_stop.mod_code%type default 'DPU'
  , penalty_id     out    dpt_stop.id%type
  , p_err_msg      out    sec_audit.rec_message%type
  );

  --
  -- Зміна параметрів штрафу
  --
  procedure upd_penalty
  ( penalty_id     in     dpt_stop.id%type
  , penalty_nm     in     dpt_stop.name%type
  , msr_prd_id     in     dpt_stop.fl%type
  , pny_bal_tp     in     dpt_stop.sh_ost%type
  , ruthless       in     dpt_stop.sh_proc%type
  , penalty_tp     in     dpt_stop_a.sh_proc%type default null
  , pny_prd_tp     in     dpt_stop_a.sh_term%type default null
  , p_err_msg      out    varchar2
  );

  --
  -- Видалення штрафу
  --
  procedure DEL_PENALTY
  ( penalty_id     in     dpt_stop.id%type
  );

  --
  --
  -- Параметры:
  --  pny_lwr_lmt  - нижня межа
  --  penalty_val  - значення штрафу в штрафному періоді
  --  penalty_tp   - тип штрафу
  --  pny_prd_val  - значення штрафного періоду
  --  pny_prd_tp   - тип штрафний період
  --  p_err_msg    - повідомлення про помилку
  --
  procedure SET_PENALTY_VALUE
  ( penalty_id     in     dpt_stop.id%type
  , pny_lwr_lmt    in     DPT_STOP_A.K_SROK%type
  , pny_upr_lmt    in     dpt_stop_a.k_srok%type
  , penalty_val    in     DPT_STOP_A.K_PROC%type
  , penalty_tp     in     DPT_STOP_A.SH_PROC%type
  , pny_prd_val    in     DPT_STOP_A.K_TERM%type  default null
  , pny_prd_tp     in     DPT_STOP_A.SH_TERM%type default 0
  , p_err_msg      out    varchar2
  );

  ---
  --
  ---
  procedure DEL_PENALTY_VALUE
  ( penalty_id     in     dpt_stop_a.id%type
  , penalty_prd    in     dpt_stop_a.k_srok%type
  , p_err_msg      out    varchar2
  );

  --
  -- Заповнення довідника рахунків витрат для видів депозитів ЮО
  --
  procedure FILL_PROCDR
  ( p_clean        in     signtype             default 0
  , p_open         in     signtype             default 0
  , p_kf           in     proc_dr$base.kf%type default sys_context('bars_context','user_mfo')
  );

  --
  --
  --
  procedure ADD_TYPE
  ( p_tp_nm        in     DPU_TYPES.TYPE_NAME%type
  , p_tp_code      in     DPU_TYPES.TYPE_CODE%type default null
  , p_sort_ordr    in     DPU_TYPES.SORT_ORD%type  default null
  , p_active       in     DPU_TYPES.FL_ACTIVE%type default 0
  , p_tpl_id       in     DPU_TYPES.SHABLON%type   default null
  , p_tp_id        out    DPU_TYPES.type_id%type
  , p_err_msg      out    varchar2
  );

  --
  --
  --
  procedure UPD_TYPE
  ( p_tp_id        in     dpu_vidd.type_id%type
  , p_tp_nm        in     DPU_TYPES.TYPE_NAME%type
  , p_tp_code      in     DPU_TYPES.TYPE_CODE%type
  , p_sort_ordr    in     DPU_TYPES.SORT_ORD%type
  , p_active       in     DPU_TYPES.FL_ACTIVE%type
  , p_tpl_id       in     DPU_TYPES.SHABLON%type
  , p_err_msg      out    varchar2
  );

  --
  --
  --
  procedure DEL_TYPE
  ( p_tp_id        in     dpu_vidd.vidd%type
  , p_err_msg      out    varchar2
  );

  --
  --
  --
  procedure DEL_TYPE
  ( p_tp_id        in     dpu_vidd.vidd%type
  );



END DPU_UTILS;
/

show errors;

create or replace package body DPU_UTILS
is
  --
  -- constants
  --
  body_ver    constant varchar2(64)   := 'version 1.34 15.12.2017';
  body_awk    constant varchar2(512)  := ''||
$if DPU_PARAMS.SBER
$then
  'Ощадбанк'
$else
  'Інші'
$end
  ;
  c_modcode   constant varchar2(3)    := 'DPU';
  c_maxamount constant number(38)     := 999999999999;
  nlchr       constant char(2)        := chr(13)||chr(10);
  --
  -- types
  --
  type t_root      is table of doc_root%rowtype;
  type t_rate      is table of dpu_vidd_rate%rowtype;
  type t_stop_type is table of dpt_stop_a%rowtype;
  type t_ob22_type is table of dpu_types_ob22%rowtype;

  --
  -- variables
  --
  g_start_dt                  date;
  g_finish_dt                 date;
  g_mask_grp_set              number(3);

  --
  -- HEADER_VERSION() - функция определения версии заголовка пакета
  --
  function header_version return varchar2
  is
  begin

    return 'Package header: '||head_ver||chr(10)||
           'AWK definition: '||head_awk;

  end header_version;

  --
  -- BODY_VERSION() - функция определения версии тела пакета
  --
  function body_version return varchar2
  is
  begin

    return 'Package body  : '||body_ver||chr(10)||
           'AWK definition: '||body_awk;

  end body_version;

  --
  -- DBLQUOTE() - функция замены одинарных кавычек в заданной строке на двойные
  --            - возвращает преобразованную строку
  --
  -- Параметры:
  --            p_txt - строка
  --
  function dblquote (p_txt varchar2) return varchar2
  is
  begin
    return replace(p_txt, chr(39), chr(39)||chr(39));
  end dblquote;

  --
  -- GEN_SCRIPT4VIDD() - процедура создания сценария для выгрузки вида депозита
  --
  -- Параметры:
  --            p_vidd - код вида депозитного договора юр.лица
  --
  procedure gen_script4vidd (p_vidd in dpu_vidd.vidd%type)
  is
    title       constant varchar2(60) := 'dputl.genscript:';
    l_clob      clob;
    l_text      varchar2(32000);
    l_viddrow   dpu_vidd%rowtype;
    l_typerow   dpu_types%rowtype;
    l_template  doc_scheme%rowtype;
    l_stoprow   dpt_stop%rowtype;
    l_stopdata  t_stop_type;
    l_root      t_root;
    l_rate      t_rate;
$if DPU_PARAMS.SBER
$then
    l_ob22      t_ob22_type;
$end
  begin

    bars_audit.trace('%s entry with %s', title, to_char(p_vidd));

    dbms_lob.createtemporary( l_clob, false );

    begin
      select * into l_viddrow from dpu_vidd where vidd = p_vidd;
    exception
      when no_data_found then
        dbms_output.put_line ('ERR: не найден вид договора № '||to_char(p_vidd));
        return;
    end;
    bars_audit.trace('%s depositypename - %s', title, l_viddrow.name);

    l_text :=          'prompt =============================================================='||nlchr;
    l_text := l_text ||'prompt === ЭКСПОРТ ВИДА ДЕПОЗИТНОГО ДОГОВОРА ЮР.ЛИЦА № '||lpad(to_char(p_vidd), 10, '_')||' ==='||nlchr;
    l_text := l_text ||'prompt =============================================================='||nlchr||nlchr;
    l_text := l_text ||'set serveroutput on' ||nlchr;
    l_text := l_text ||'set feed         off'||nlchr;
    l_text := l_text ||nlchr;
    l_text := l_text ||'declare'                                     ||nlchr;
    l_text := l_text ||'  l_typeid        dpu_types.type_id%type;'   ||nlchr;
    l_text := l_text ||'  l_typename      dpu_types.type_name%type;' ||nlchr;
    l_text := l_text ||'  l_typecode      dpu_types.type_code%type;' ||nlchr;
    l_text := l_text ||'  l_sortord       dpu_types.sort_ord%type;'  ||nlchr;
    l_text := l_text ||'  l_flactive      dpu_types.fl_active%type;' ||nlchr;
    l_text := l_text ||'begin'                                       ||nlchr;
    l_text := l_text ||nlchr;

    -- часть 1. Тип депозитного договора
    select * into l_typerow from dpu_types where type_id = l_viddrow.type_id;

    bars_audit.trace('%s typename - %s', title, l_typerow.type_name);

    l_text := l_text ||'  -- часть 1. тип депозитного договора...'||nlchr;
    l_text := l_text ||'  begin'||nlchr;
    l_text := l_text ||'    l_typeid   := '''||to_char(l_typerow.type_id)   ||''';'||nlchr;
    l_text := l_text ||'    l_typename := '''||dblquote(l_typerow.type_name)||''';'||nlchr;
    l_text := l_text ||'    l_typecode := '''||dblquote(l_typerow.type_code)||''';'||nlchr;
    l_text := l_text ||'    l_sortord  := '''||to_char(l_typerow.sort_ord)  ||''';'||nlchr;
    l_text := l_text ||'    l_flactive := '''||to_char(l_typerow.fl_active) ||''';'||nlchr;
    l_text := l_text ||'    insert into DPU_TYPES ( TYPE_ID, TYPE_NAME, TYPE_CODE, SORT_ORD, FL_ACTIVE )'||nlchr;
    l_text := l_text ||'    values ( l_typeid, l_typename, l_typecode, l_sortord, l_flactive );'||nlchr;
    l_text := l_text ||'    dbms_output.put_line(''Создан тип договора № '||to_char(l_typerow.type_id)||' - '||dblquote(l_typerow.type_code)||''' );'||nlchr;
    l_text := l_text ||'  exception'||nlchr;
    l_text := l_text ||'    when DUP_VAL_ON_INDEX then'||nlchr;
    l_text := l_text ||'      update DPU_TYPES '||nlchr;
    l_text := l_text ||'         set TYPE_NAME = l_typename,'||nlchr;
    l_text := l_text ||'             TYPE_CODE = l_typecode,'||nlchr;
    l_text := l_text ||'             SORT_ORD  = l_sortord,' ||nlchr;
    l_text := l_text ||'             FL_ACTIVE = l_flactive' ||nlchr;
    l_text := l_text ||'       where TYPE_ID   = l_typeid;'  ||nlchr;
    l_text := l_text ||'      dbms_output.put_line(''Обновлен тип договора № '||to_char(l_typerow.type_id)||' - '||dblquote(l_typerow.type_code)||''');'||nlchr;
    l_text := l_text ||'  end;'||nlchr;
    l_text := l_text ||nlchr;

    dbms_lob.append(l_clob, l_text);
    l_text := null;
    bars_audit.trace('%s dpu_type script succ.created', title);

    -- часть 2. Шаблон депозитного договора
    if (l_viddrow.shablon is not null)
    then

      select * into l_template
        from DOC_SCHEME
       where id = l_viddrow.shablon;

      bars_audit.trace('%s template - %s', title, l_template.id);

       l_text := l_text ||'  -- часть 2. шаблон депозитного договора...'||nlchr;
       l_text := l_text ||'  begin'||nlchr;
       l_text := l_text ||'    insert into DOC_SCHEME ( ID, NAME ) '||nlchr;
       l_text := l_text ||'    values (''' || nvl(dblquote(l_template.id),   '') ||''',  ''' || nvl(dblquote(l_template.name), '') ||'''); '||nlchr;
       l_text := l_text ||'    dbms_output.put_line(''Создан шаблон '||dblquote(l_template.id)||' - '||dblquote(l_template.name)||'''); '||nlchr;
       l_text := l_text ||'  exception '||nlchr;
       l_text := l_text ||'    when dup_val_on_index then '||nlchr;
       l_text := l_text ||'      update doc_scheme '||nlchr;
       l_text := l_text ||'         set name = '''||nvl(dblquote(l_template.name), '') ||'''' ||nlchr;
       l_text := l_text ||'       where id   = '''||nvl(dblquote(l_template.id),   '') ||''';'||nlchr;
       l_text := l_text ||'      dbms_output.put_line(''Обновлен шаблон '||dblquote(l_template.id)||' - '||dblquote(l_template.name)||'''); '||nlchr;
       l_text := l_text ||'  end;'||nlchr;
       l_text := l_text ||nlchr;

       select * bulk collect
         into l_root
         from doc_root
        where id = l_viddrow.shablon;

       for i in 1..l_root.count loop
         bars_audit.trace('%s template_type - %s', title, to_char(l_root(i).vidd));
         if i = 1 then
            l_text := l_text ||'  -- часть 2.1. привязка к видам договоров (cc_vidd)...'||nlchr;
         end if;
         l_text := l_text ||'  begin'||nlchr;
         l_text := l_text ||'    insert into DOC_ROOT ( VIDD, ID )'||nlchr;
         l_text := l_text ||'    values ('|| nvl(to_char(l_root(i).vidd), 'null') ||', '''|| nvl(dblquote(l_root(i).id), '')||''');'||nlchr;
         l_text := l_text ||'    dbms_output.put_line(''Шаблон '||dblquote(l_template.id)||' привязан к типу договора №'||to_char(l_root(i).vidd)||''');'||nlchr;
         l_text := l_text ||'  exception'||nlchr;
         l_text := l_text ||'    when dup_val_on_index then null;'||nlchr;
         l_text := l_text ||'  end;'||nlchr;
         l_text := l_text ||nlchr ;
       end loop;

       dbms_lob.append(l_clob, l_text);
       l_text := null;

    end if;

    bars_audit.trace('%s doc_scheme script succ.created', title);

    -- 3. Параметри штрафу
    if (l_viddrow.id_stop > 0)
    then

      bars_audit.trace( '%s stopid - %s', title, to_char(l_viddrow.id_stop) );

      select * into l_stoprow
        from dpt_stop
       where id = l_viddrow.id_stop;

      l_text := l_text ||'  -- штраф...'||nlchr;
      l_text := l_text ||'  begin'||nlchr;
      l_text := l_text ||'    insert into DPT_STOP ( ID, NAME, FL, SH_PROC, SH_OST )'||nlchr;
      l_text := l_text ||'    values ('||nvl(to_char(l_stoprow.id), 'null')||', '
                                       ||'substr('''||nvl(dblquote(l_stoprow.name), '') ||''', 1, 50), '
                                       ||nvl(to_char(l_stoprow.fl),     'null') ||', '
                                       ||nvl(to_char(l_stoprow.sh_proc),'null') ||', '
                                       ||nvl(to_char(l_stoprow.sh_ost), 'null') ||');'||nlchr;
      l_text := l_text ||'    dbms_output.put_line(''Создан штраф № '||to_char(l_stoprow.id)||' - '||dblquote(l_stoprow.name)||''');'||nlchr;
      l_text := l_text ||'  exception'||nlchr;
      l_text := l_text ||'    when dup_val_on_index then'||nlchr;
      l_text := l_text ||'      update DPT_STOP'||nlchr;
      l_text := l_text ||'         set name    = substr('||''''||nvl(dblquote(l_stoprow.name), '') ||''', 1, 50),'||nlchr;
      l_text := l_text ||'             fl      = '||nvl(to_char(l_stoprow.fl),          '') ||',' ||nlchr;
      l_text := l_text ||'             sh_proc = '||nvl(to_char(l_stoprow.sh_proc), 'null') ||',' ||nlchr;
      l_text := l_text ||'             sh_ost  = '||nvl(to_char(l_stoprow.sh_ost),  'null') ||' ' ||nlchr;
      l_text := l_text ||'       where id      = '||nvl(to_char(l_stoprow.id),      'null') ||';' ||nlchr;
      l_text := l_text ||'      dbms_output.put_line(''Обновлен штраф № '||to_char(l_stoprow.id)||' - '||dblquote(l_stoprow.name)||''');'||nlchr;
      l_text := l_text ||'  end;'||nlchr;
      l_text := l_text ||nlchr ;
      l_text := l_text ||'  -- удаление описания штрафа...'||nlchr;
      l_text := l_text ||'  delete from DPT_STOP_A where ID = '||to_char(l_viddrow.id_stop)||';' ||nlchr;
      l_text := l_text ||nlchr ;

      dbms_lob.append(l_clob, l_text);
      l_text := null;

      select * bulk collect
        into l_stopdata
        from DPT_STOP_A
       where id = l_viddrow.id_stop
       order by k_srok;

      for i in 1..l_stopdata.count
      loop

        l_text := l_text ||'  begin '||nlchr;
        l_text := l_text ||'    insert into DPT_STOP_A (id, k_srok, k_proc, k_term, sh_proc, sh_term)'||nlchr;
        l_text := l_text ||'    values ('||nvl(to_char(l_stopdata(i).id),      'null') ||', '
                                         ||nvl(to_char(l_stopdata(i).k_srok),  'null') ||', '
                                         ||nvl(to_char(l_stopdata(i).k_proc),  'null') ||', '
                                         ||nvl(to_char(l_stopdata(i).k_term),  'null') ||', '
                                         ||nvl(to_char(l_stopdata(i).sh_proc), 'null') ||', '
                                         ||nvl(to_char(l_stopdata(i).sh_term), 'null') ||');'||nlchr;
        l_text := l_text ||'  exception' ||nlchr;
        l_text := l_text ||'    when dup_val_on_index then'||nlchr;
        l_text := l_text ||'      update DPT_STOP_A'||nlchr;
        l_text := l_text ||'         set K_PROC  = '||nvl(to_char(l_stopdata(i).k_proc),  'null') ||nlchr;
        l_text := l_text ||'           , K_TERM  = '||nvl(to_char(l_stopdata(i).k_term),  'null') ||nlchr;
        l_text := l_text ||'           , SH_PROC = '||nvl(to_char(l_stopdata(i).sh_proc), 'null') ||nlchr;
        l_text := l_text ||'           , SH_TERM = '||nvl(to_char(l_stopdata(i).sh_term), 'null') ||nlchr;
        l_text := l_text ||'       where ID      = '||to_char(l_stopdata(i).id)                   ||nlchr;
        l_text := l_text ||'         and K_SROK  = '||to_char(l_stopdata(i).k_srok) ||';'         ||nlchr;
        l_text := l_text ||'  end; '||nlchr;
        l_text := l_text ||nlchr ;

        dbms_lob.append(l_clob, l_text);
        l_text := null;

      End loop;

    End If;

    -- часть 4. Вид депозитного договора
    l_text := DPT_UTILS.GET_INSERT4TABLE( 'DPU_VIDD', 'VIDD = '||to_char(l_viddrow.vidd), 2, 'BARS', 'U' );
    l_text := replace( l_text, '1 row created.', 'Створено вид депозиту № '||to_char(l_viddrow.vidd)||' - '||dblquote(l_viddrow.name) );
    l_text := replace( l_text, '1 row updated.', 'Оновлено вид депозиту № '||to_char(l_viddrow.vidd)||' - '||dblquote(l_viddrow.name) );
    l_text := '  -- 4. вид депозитного договору...' || nlchr || l_text;
    dbms_lob.append( l_clob, l_text );
    l_text := null;

    bars_audit.trace('%s dpu_vidd script succ.created', title);

    -- 5. Шкала процентных ставок.
    select * bulk collect
      into l_rate
      from DPU_VIDD_RATE
     where vidd = l_viddrow.vidd;

    for i in 1..l_rate.count loop
        bars_audit.trace('%s rate_id - %s', title, to_char(l_rate(i).id));
        if i = 1 then
           l_text := l_text ||'  -- 5. шкала процентных ставок...'||nlchr;
        end if;
        l_text := l_text ||'  begin '||nlchr;
        l_text := l_text ||'    insert into DPU_VIDD_RATE'||nlchr;
        l_text := l_text ||'      ( ID, VIDD, TERM, LIMIT, RATE, TERM_DAYS, TERM_INCLUDE, SUMM_INCLUDE, MAX_RATE, TYPE_ID, KV )'||nlchr;
        l_text := l_text ||'    values '||nlchr;
        l_text := l_text ||'      (' || nvl( to_char(l_rate(i).id          ), 'null') ||', '   ||nlchr;
        l_text := l_text ||'       ' || nvl( to_char(l_rate(i).vidd        ), 'null') ||', '   ||nlchr;
        l_text := l_text ||'       ' || nvl( to_char(l_rate(i).term        ), 'null') ||', '   ||nlchr;
        l_text := l_text ||'       ' || nvl( to_char(l_rate(i).limit       ), 'null') ||', '   ||nlchr;
        l_text := l_text ||'       ' || nvl( to_char(l_rate(i).rate        ), 'null') ||', '   ||nlchr;
        l_text := l_text ||'       ' || nvl( to_char(l_rate(i).term_days   ), 'null') ||', '   ||nlchr;
        l_text := l_text ||'       ' || nvl( to_char(l_rate(i).term_include), 'null') ||', '   ||nlchr;
        l_text := l_text ||'       ' || nvl( to_char(l_rate(i).summ_include), 'null') ||', '   ||nlchr;
        l_text := l_text ||'       ' || nvl( to_char(l_rate(i).max_rate    ), 'null') ||', '   ||nlchr;
        l_text := l_text ||'       ' || nvl( to_char(l_rate(i).type_id     ), 'null') ||', '   ||nlchr;
        l_text := l_text ||'       ' || nvl( to_char(l_rate(i).kv          ), 'null') ||');'   ||nlchr;

        l_text := l_text ||'  exception '||nlchr;
        l_text := l_text ||'    when dup_val_on_index then null;'||nlchr;
        l_text := l_text ||'  end;'||nlchr;
        l_text := l_text ||nlchr;

        if i = l_rate.count then
           l_text := l_text ||'  dbms_output.put_line(''Обновлены шкалы проц.ставок для вида договора № '||to_char(l_viddrow.vidd)||''');'||nlchr;
           l_text := l_text ||nlchr ;
        end if;

    end loop;

    if l_text is not null
    then
       dbms_lob.append(l_clob, l_text);
    end if;

    l_text := null;
    bars_audit.trace('%s dpu_vidd_rate script succ.created', title);

$if DPU_PARAMS.SBER
$then
    -- 6. Параметры OB22 для счетов
    l_text := DPT_UTILS.GET_INSERT4TABLE( 'DPU_TYPES_OB22', 'TYPE_ID = '||to_char(l_viddrow.type_id), 2, 'BARS', 'U' );
    l_text := '  -- 6. параметры OB22...' || nlchr || l_text;
    dbms_lob.append( l_clob, l_text );
    l_text := null;

--  select *
--    bulk collect
--    into l_ob22
--    from DPU_TYPES_OB22
--   where TYPE_ID = l_viddrow.type_id;
--
--  for o in 1..l_ob22.count
--  loop
--
--    bars_audit.trace( '%s ob22 - (%s/%s, %s/%s, %s/%s, %s/%s)', title,
--                      l_ob22(o).nbs_dep, l_ob22(o).ob22_dep, l_ob22(o).nbs_int, l_ob22(o).ob22_int,
--                      l_ob22(o).nbs_exp, l_ob22(o).ob22_exp, l_ob22(o).nbs_red, l_ob22(o).ob22_red );
--    if ( o = 1 )
--    then
--       -- l_text := l_text ||nlchr;
--       l_text := l_text ||'  -- 6. параметры OB22...'||nlchr;
--    end if;
--
--    l_text := l_text ||'  begin '||nlchr;
--    l_text := l_text ||'    insert into DPU_TYPES_OB22'||nlchr;
--    l_text := l_text ||'      ( type_id, k013, S181, R034, nbs_dep, ob22_dep, nbs_int, ob22_int, nbs_exp, ob22_exp, nbs_red, ob22_red ) '||nlchr;
--    l_text := l_text ||'    values '||nlchr;
--    l_text := l_text ||'      ( '   || nvl( to_char(l_ob22(o).type_id ), 'null') ||  ', ' ;
--    l_text := l_text ||       ''''  || nvl(dblquote(l_ob22(o).k013    ),     '') ||''', ' ;
--    l_text := l_text ||       ''''  || nvl(dblquote(l_ob22(o).S181    ),     '') ||''', ' ;
--    l_text := l_text ||       ''''  || nvl(dblquote(l_ob22(o).R034    ),     '') ||''', ' ;
--    l_text := l_text ||       ''''  || nvl(dblquote(l_ob22(o).nbs_dep ),     '') ||''', ' ;
--    l_text := l_text ||       ''''  || nvl(dblquote(l_ob22(o).ob22_dep),     '') ||''', ' ;
--    l_text := l_text ||       ''''  || nvl(dblquote(l_ob22(o).nbs_int ),     '') ||''', ' ;
--    l_text := l_text ||       ''''  || nvl(dblquote(l_ob22(o).ob22_int),     '') ||''', ' ;
--    l_text := l_text ||       ''''  || nvl(dblquote(l_ob22(o).nbs_exp ),     '') ||''', ' ;
--    l_text := l_text ||       ''''  || nvl(dblquote(l_ob22(o).ob22_exp),     '') ||''', ' ;
--    l_text := l_text ||       ''''  || nvl(dblquote(l_ob22(o).nbs_red ),     '') ||''', ' ;
--    l_text := l_text ||       ''''  || nvl(dblquote(l_ob22(o).ob22_red),     '') ||''');' ||nlchr;
--    l_text := l_text ||'    dbms_output.put_line(''Заповнено ОБ22 для типу договору № '||to_char(l_ob22(o).type_id)||''' );'||nlchr;
--    l_text := l_text ||'  exception '||nlchr;
--    l_text := l_text ||'    when DUP_VAL_ON_INDEX then'||nlchr;
--    l_text := l_text ||'      update DPU_TYPES_OB22'  ||nlchr;
--    l_text := l_text ||'         set nbs_dep  = '||''''||nvl(dblquote(l_ob22(o).nbs_dep), '') ||''', '||nlchr;
--    l_text := l_text ||'             ob22_dep = '||''''||nvl(dblquote(l_ob22(o).ob22_dep), '') ||''', '||nlchr;
--    l_text := l_text ||'             nbs_int  = '||''''||nvl(dblquote(l_ob22(o).nbs_int ), '') ||''', '||nlchr;
--    l_text := l_text ||'             ob22_int = '||''''||nvl(dblquote(l_ob22(o).ob22_int), '') ||''', '||nlchr;
--    l_text := l_text ||'             nbs_exp  = '||''''||nvl(dblquote(l_ob22(o).nbs_exp ), '') ||''', '||nlchr;
--    l_text := l_text ||'             ob22_exp = '||''''||nvl(dblquote(l_ob22(o).ob22_exp), '') ||''', '||nlchr;
--    l_text := l_text ||'             nbs_red  = '||''''||nvl(dblquote(l_ob22(o).nbs_red ), '') ||''', '||nlchr;
--    l_text := l_text ||'             ob22_red = '||''''||nvl(dblquote(l_ob22(o).ob22_red), '') ||'''  '||nlchr;
--    l_text := l_text ||'       where type_id  = '|| to_char(l_ob22(o).type_id)    ||nlchr;
--    l_text := l_text ||'         and K013     = '||''''|| l_ob22(o).k013 || ''' ' ||nlchr;
--    l_text := l_text ||'         and S181     = '||''''|| l_ob22(o).S181 || ''' ' ||nlchr;
--    l_text := l_text ||'         and R034     = '||''''|| l_ob22(o).R034 || ''';' ||nlchr;
--    l_text := l_text ||'    dbms_output.put_line(''Оновлено ОБ22 для типу договору № '||to_char(l_viddrow.type_id)||''' );'||nlchr;
--    l_text := l_text ||'  end; '||nlchr;
--    l_text := l_text ||nlchr;
--    dbms_lob.append(l_clob, l_text);
--    l_text := null;
--
--  End Loop;

    bars_audit.trace('%s dpu_types_ob22 script succ.created', title);
$end

    l_text := l_text ||nlchr;
    l_text := l_text ||'  commit;'||nlchr;
    l_text := l_text ||nlchr;
    l_text := l_text ||'end;'||nlchr;
    l_text := l_text ||'/   '||nlchr;
    l_text := l_text ||nlchr;
    l_text := l_text ||'set feed on '||nlchr;

    dbms_lob.append(l_clob, l_text);
    l_text := null;

    begin
      insert into tmp_expdptype (modcode, typeid, clobdata, clobleng)
      values (c_modcode, p_vidd, l_clob, dbms_lob.getlength(l_clob));
    exception
      when dup_val_on_index then
        update tmp_expdptype
           set clobdata = l_clob,
               clobleng = dbms_lob.getlength(l_clob)
         where modcode  = c_modcode
           and typeid   = p_vidd;
    end;
    bars_audit.trace('%s tmp_expdptype succ.inserted', title);

    dbms_lob.freetemporary(l_clob);

    bars_audit.trace('%s exit', title);

  exception
    when others then
      bars_error.raise_nerror (c_modcode, 'GEN_EXPDPTYPE_FAILED', to_char(p_vidd), sqlerrm);

  end GEN_SCRIPT4VIDD;

  --
  -- GEN_SCRIPT4TYPES() - створення сценарію для експорту типу депозиту
  --
  -- Параметри:
  --            p_typeid - код типу депозитного продукту ЮО
  --
  function gen_script4types
  ( p_typeid in dpu_types.type_id%type )
    return varchar2_list
           pipelined
  is
    title       constant varchar2(30) := 'dpu_utils.genscript4types:';
    l_script    clob;
    l_text      varchar2(32000);
    l_clobsize  pls_integer;
    l_offset    pls_integer;
  begin
$if DPU_PARAMS.SBER
$then

    bars_audit.trace( '%s entry with: typeid => %s.', title, nvl(to_char(p_typeid),'null') );

    dbms_lob.createtemporary (l_script,  false);

    l_text := 'prompt ==============================================================='||nlchr||
              'prompt === ЕКСПОРТ ТИПУ ДЕПОЗИТНОГО ДОГОВОРУ ЮР.ОСОБИ № '||lpad(to_char(p_typeid), 10, '_')||' ==='||nlchr||
              'prompt ==============================================================='||nlchr||
              ''                                                                   ||nlchr||
              'set serveroutput on'                                                ||nlchr||
              'set feed off'                                                       ||nlchr||
              ''                                                                   ||nlchr||
              '-- generated at '|| to_char(sysdate,'dd/mm/yyyy hh24:mi:ss')        ||nlchr||
              ''                                                                   ||nlchr||
              'begin'                                                              ||nlchr||
              ''                                                                   ||nlchr||
              '  -- параметри типу депозиту'                                       ||nlchr||
              ''                                                                   ||nlchr;

    dbms_lob.append(l_script, l_text);

    -- експорт параметрів типу депозиту (продукту)
    l_text := dpt_utils.get_insert4table( 'DPU_TYPES', 'TYPE_ID = '||to_char(p_typeid), 2 );

    dbms_lob.append(l_script, l_text);
  /*
    l_text := '  -- коди валют типу депозиту '                                     ||nlchr||
              ''                                                                   ||nlchr||
              '  DELETE FROM DPU_TYPES_CURRENCY '                                  ||nlchr||
              '   WHERE TYPE_ID = '||to_char(p_typeid)||';'                        ||nlchr||
              ''                                                                   ||nlchr;

    dbms_lob.append(l_script, l_text);

    -- експорт кодів валют типу депозиту
    l_text := dpt_utils.get_insert4table( 'DPU_TYPES_CURRENCY', 'TYPE_ID = '||to_char(p_typeid), 2 );

    dbms_lob.append(l_script, l_text);

    l_text := '  -- коди періодичності виплат типу депозиту '                      ||nlchr||
              ''                                                                   ||nlchr||
              '  DELETE FROM DPU_TYPES_FREQ '                                      ||nlchr||
              '   WHERE TYPE_ID = '||to_char(p_typeid)||';'                        ||nlchr||
              ''                                                                   ||nlchr;

    dbms_lob.append(l_script, l_text);

    -- експорт кодів періодичності виплат типу депозиту
    l_text := dpt_utils.get_insert4table( 'DPU_TYPES_FREQ', 'TYPE_ID = '||to_char(p_typeid), 2 );

    dbms_lob.append(l_script, l_text);
  */
    l_text := '  -- аналітика типу депозиту (K013, S181, R034, R020, OB22) '       ||nlchr||
              '  '                                                                 ||nlchr||
              '  DELETE FROM DPU_TYPES_OB22 '                                      ||nlchr||
              '   WHERE TYPE_ID = '||to_char(p_typeid)||';'                        ||nlchr||
              '  '                                                                 ||nlchr;

    dbms_lob.append(l_script, l_text);

    -- експорт аналітики типу депозиту (K013, S181, R034, R020, OB22)
    l_text := dpt_utils.get_insert4table( 'DPU_TYPES_OB22', 'TYPE_ID = '||to_char(p_typeid), 2 );

    dbms_lob.append(l_script, l_text);

    l_text := '  commit;'                                                          ||nlchr||
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

      pipe row ( SubStr(l_script, l_offset, 2000) );

      l_offset := l_offset + 2000;

    end loop;

    dbms_lob.freetemporary( l_script );

    bars_audit.trace('%s exit with: clobsize = %s', title, to_char(l_clobsize) );

    return;

  exception
    when others then
      raise_application_error( -20000, dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace(), true );
$else
    null;
$end
  end GEN_SCRIPT4TYPES;

  --
  -- SET_DPUVIDDRATE() - процедура валидации и записи строки в справочник
  --                     "Шкалы процентных ставок по депозитам ЮЛ"
  --
  -- Параметры:
  --              p_id - идентификатор записи
  --          p_typeid - код типа депозитного договора юр.лица
  --              p_kv - числовой код валюты
  --            p_vidd - код вида депозитного договора юр.лица
  --        p_termmnth - срок депозита в месяцах
  --        p_termdays - срок депозита в днях
  --        p_termincl - признак включения гран.срока в диапазон
  --           p_limit - граничная сумма в коп.
  --        p_summincl - признак включения гран.суммы в диапазон
  --         p_actrate - процентная ставка
  --         p_maxrate - макс.допустимая процентная ставка
  --
  procedure set_dpuviddrate
  ( p_id           in     dpu_vidd_rate.id%type
  , p_kf           in     dpu_vidd_rate.kf%type
  , p_typeid       in     dpu_vidd_rate.type_id%type
  , p_kv           in     dpu_vidd_rate.kv%type
  , p_vidd         in     dpu_vidd_rate.vidd%type
  , p_termmnth     in     dpu_vidd_rate.term%type
  , p_termdays     in     dpu_vidd_rate.term_days%type
  , p_termincl     in     dpu_vidd_rate.term_include%type
  , p_limit        in     dpu_vidd_rate.limit%type
  , p_summincl     in     dpu_vidd_rate.summ_include%type
  , p_actrate      in     dpu_vidd_rate.rate%type
  , p_maxrate      in     dpu_vidd_rate.max_rate%type
  ) is
    title    constant     varchar2(60) := 'dpu_utils.set_dpuviddrate:';
    l_rec                 dpu_vidd_rate%rowtype;
    ---
    l_max_val             pls_integer;
    l_crn_val             pls_integer;
    ---
  begin

    bars_audit.trace( '%s entry with {%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s}'
                    , bars_audit.args( title,               to_char(p_id),
                                       to_char(p_typeid),   to_char(p_kv),
                                       to_char(p_vidd),     to_char(p_termmnth),
                                       to_char(p_termdays), to_char(p_termincl),
                                       to_char(p_limit),    to_char(p_summincl),
                                       to_char(p_actrate),  to_char(p_maxrate) ) );

    -- идентификатор строки
    if p_id > 0
    then -- заданий
      l_rec.id := p_id;
    else -- не заданий
      l_rec.id := 0;
    end if;

    -- валидация вида договора, валюты и типа продукта
    if p_vidd is not null
    then

       begin
         select vidd, type_id, kv
           into l_rec.vidd, l_rec.type_id, l_rec.kv
           from dpu_vidd
          where vidd = p_vidd;
         bars_audit.trace('%s vidd %s found, type_id = %s, kv = %s', title,
                          to_char(l_rec.vidd),
                          to_char(l_rec.type_id),
                          to_char(l_rec.kv));
       exception
         when no_data_found then
           bars_error.raise_nerror(c_modcode, 'SETYPERATE_VIDD_NOT_FOUND',
                                   to_char(p_vidd));
       end;

      -- проверка соответствия заданного продукта продукту указанного вида договора
      if p_typeid != l_rec.type_id
      then
        bars_error.raise_nerror( c_modcode, 'SETYPERATE_TYPEID_MISMATCH',
                                 to_char(p_typeid),
                                 to_char(l_rec.type_id),
                                 to_char(p_vidd) );
       end if;

      -- проверка соответствия заданной валюты валюте указанного вида договора
      if p_kv != l_rec.kv
      then
        bars_error.raise_nerror( c_modcode, 'SETYPERATE_KV_MISMATCH',
                                 to_char(p_kv),
                                 to_char(l_rec.kv),
                                 to_char(p_vidd));
      end if;

    else

      l_rec.vidd := null;

      begin
        select type_id into l_rec.type_id from dpu_types where type_id = p_typeid;
      exception
        when NO_DATA_FOUND then
          bars_error.raise_nerror( c_modcode, 'SETYPERATE_TYPEID_NOT_FOUND', nvl(to_char(p_typeid), '_') );
       end;

      begin
        select kv into l_rec.kv from tabval where kv = p_kv;
      exception
        when no_data_found then
          bars_error.raise_nerror( c_modcode, 'SETYPERATE_KV_NOT_FOUND', nvl(to_char(p_kv), '_'));
      end;

    end if;

    if ( p_termmnth < 0 or p_termmnth > 999  ) or
       ( p_termdays < 0 or p_termdays > 9999 ) or
       ( p_termincl not in (0, 1)            )
    then
       bars_error.raise_nerror(c_modcode, 'SETYPERATE_TERM_INVALID',
                               nvl(to_char(p_termmnth), '_'),
                               nvl(to_char(p_termdays), '_'),
                               nvl(to_char(p_termincl), '_'));
    end if;

    if p_limit < 0 or p_summincl not in (0, 1)
    then
      bars_error.raise_nerror( c_modcode, 'SETYPERATE_AMNT_INVALID',
                               nvl(to_char(p_limit), '_'),
                               nvl(to_char(p_summincl), '_'));
    end if;

    if nvl(p_actrate, -13) < 0 or p_maxrate < 0 or p_maxrate < p_actrate
    then
      bars_error.raise_nerror( c_modcode, 'SETYPERATE_RATE_INVALID',
                               nvl(to_char(p_actrate), '_'),
                               nvl(to_char(p_maxrate), '_'));
    end if;

    l_rec.kf := coalesce( p_kf, sys_context('bars_context','user_mfo') );

    if ( l_rec.kf Is Null )
    then
      bars_error.raise_nerror( c_modcode, 'GENERAL_ERROR_CODE', 'Не вказано код філіалу (МФО)!' );
    end if;

    l_rec.term         := nvl(p_termmnth, 0);
    l_rec.term_days    := nvl(p_termdays, 0);
    l_rec.term_include := nvl(p_termincl, 0);
    l_rec.summ_include := nvl(p_summincl, 0);
    l_rec.limit        := nvl(p_limit,    c_maxamount);
    l_rec.rate         := p_actrate;
    l_rec.max_rate     := p_maxrate;

    if ( l_rec.id > 0 )
    then
      update DPU_VIDD_RATE
         set ROW = l_rec
       where id  = l_rec.id;
      bars_audit.trace( '%s № %s updated for type %s/%s/%s, term %s/%s, amnt %s',
                        title,to_char(l_rec.id),to_char(l_rec.type_id),
                        to_char(l_rec.kv),to_char(l_rec.vidd),to_char(l_rec.term),
                        to_char(l_rec.term_days),to_char(l_rec.limit));
    end if;

    if ( l_rec.id = 0 OR sql%rowcount = 0 )
    then -- не заданий ід запису або такого ід не існує

$if DPU_PARAMS.SBER
$then
      l_rec.id := bars_sqnc.get_nextval( 'S_DPU_VIDD_RATE' );
$else
      l_rec.id := S_DPU_VIDD_RATE.NextVal;
$end

      begin
        insert
          into BARS.DPU_VIDD_RATE
        values l_rec;
        bars_audit.trace( '%s № %s inserted for type %s/%s/%s, term %s/%s, amnt %s',
                          title,to_char(l_rec.id),to_char(l_rec.type_id),
                          to_char(l_rec.kv),to_char(l_rec.vidd),to_char(l_rec.term),
                          to_char(l_rec.term_days),to_char(l_rec.limit) );
      exception
        when DUP_VAL_ON_INDEX then

          if ( inStr(sqlErrm ,'PK_DPUVIDDRATE') > 0 )
          then -- for PK

            -- виправляємо значення сіквенса
            begin

              select max(ID)
                into l_max_val
                from BARS.DPU_VIDD_RATE;

$if DPU_PARAMS.SBER
$then
              l_crn_val := bars_sqnc.get_currval( 'S_DPU_VIDD_RATE' );

              if ( trunc(l_max_val/100) > l_crn_val )
              then -- якщо ідентифікатори ще без коду РУ
                l_max_val := trunc(l_max_val/100);
              end if;
$else
              l_crn_val := S_DPU_VIDD_RATE.CurrVal;
$end

              execute immediate 'alter sequence S_DPU_VIDD_RATE increment by ' || to_char( abs(l_max_val - l_crn_val) );

              execute immediate 'select S_DPU_VIDD_RATE.NextVal from dual'
                 into l_crn_val;

              execute immediate 'alter sequence S_DPU_VIDD_RATE increment by 1';

            end;

            -- повторний запуск
            SET_DPUVIDDRATE( p_id       => p_id
                           , p_kf       => p_kf
                           , p_typeid   => p_typeid
                           , p_kv       => p_kv
                           , p_vidd     => p_vidd
                           , p_termmnth => p_termmnth
                           , p_termdays => p_termdays
                           , p_termincl => p_termincl
                           , p_limit    => p_limit
                           , p_summincl => p_summincl
                           , p_actrate  => p_actrate
                           , p_maxrate  => p_maxrate
                           );
          else -- UK_DPUVIDDRATE
            --
            bars_error.raise_nerror( c_modcode, 'GENERAL_ERROR_CODE'
                                   , 'Record for fields ( TYPE_ID, KV, VID, TERM, TERM_DAYS, LIMIT ) with specified values already exists!' );
          end if;

        when OTHERS then
          bars_error.raise_nerror( c_modcode, 'SETYPERATE_FAILED',
                                   to_char(l_rec.type_id),        to_char(l_rec.kv),
                                   nvl(to_char(l_rec.vidd), '_'), to_char(l_rec.term),
                                   to_char(l_rec.term_days),      to_char(l_rec.limit),
                                   sqlerrm );
      end;

    end if;

    bars_audit.trace('%s exit', title);

  end set_dpuviddrate;

  --
  -- Синхронізація параметрів продукту з видами депозитів
  --
  procedure TYPE_CONSTRUCTOR
  ( p_typeid in dpu_types.type_id%type
  ) is
$if DPU_PARAMS.SBER
$then
    title      constant varchar2(30) := 'dpu_utils.type_constructor:';
    l_type     dpu_types%rowtype;

    type t_rec is record ( fl_add      dpu_vidd.fl_add%type,
                           curr_id     dpu_vidd.kv%type,
                           freq_id     dpu_vidd.freq_v%type,
                           freq_name   freq.name%type,
                           nbs_dep     dpu_vidd.bsd%type,
                           nbs_int     dpu_vidd.bsn%type,
--                         IRVK        dpu_vidd.IRVK%type,
                           s181        dpu_types_ob22.s181%type,
                           term_type   dpu_types.term_type%type,
                           term_min    dpu_types.term_min%type,
                           term_max    dpu_types.term_max%type,
                           term_add    dpu_types.term_add%type );

    type t_tab is table of t_rec;

    l_tab      t_tab;
    ---
    -- proccedure
    ---
    procedure set_vidd
    ( p_rec  in  t_rec,
      p_cap  in  dpu_vidd.comproc%type   default 0 )
    is
      l_vidd     dpu_vidd.vidd%type;
      l_name     dpu_vidd.name%type;
    begin

      bars_audit.info( 'dpu_utils.type_constructor.set_vidd entry with: term_type = ' || p_rec.term_type ||
                       ', term_min = ' || p_rec.term_min ||
                       ', term_max = ' || p_rec.term_max );

      -- bars_audit.trace( 'dpu_utils.type_constructor.set_vidd entry with: typeid => %s, kv=%s, nbs=%s, freq=%s, comproc=%s.',
      --                   to_char(p_typeid), to_char(p_rec.curr_id), p_rec.nbs_dep, to_char(p_rec.freq_id), to_char(p_rec.comproc) );

      -- Формуємо назву виду депозиту
      If ( p_rec.term_type = 1 )
      Then -- фіксований термін

        If (p_rec.term_max >= 1)
        Then
          l_name := l_type.type_name || ' ' || trunc(p_rec.term_max)    || ' міс. ';
        Else
          l_name := l_type.type_name || ' ' || (p_rec.term_max * 10000) || ' днів ';
        End If;

      Else -- Діапазон

        Case
          When p_rec.s181 = '1' Then 
            l_name := l_type.type_name ||' < року ';
          When p_rec.s181 = '2' Then 
            l_name := l_type.type_name ||' > року ';
          Else
            l_name := l_type.type_name;
        End Case;

      End If;

      If (p_cap = 1) Then
        l_name := l_name || '(Капіталізація %)';
      Else
        l_name := l_name || '(% '|| p_rec.freq_name ||')';
      End If;

      update DPU_VIDD
         set NAME      = l_name,
             ID_STOP   = l_type.stop_id,
             BR_ID     = l_type.br_id,
             METR      = l_type.metr_id,
             TT        = 'DU%',
             TIP_OST   = 1,
             MIN_SUMM  = l_type.sum_min,
             MAX_SUMM  = l_type.sum_max,
             LIMIT     = l_type.sum_add,
             SHABLON   = l_type.shablon,
             DPU_TYPE  = to_number(p_rec.s181),
             FL_ADD    = p_rec.fl_add,
             FLAG      = 1,
             FL_EXTEND = 0,
             TERM_MIN  = p_rec.term_min,
             TERM_MAX  = p_rec.term_max,
             TERM_ADD  = p_rec.term_add
       where TYPE_ID   = p_typeid
         and KV        = p_rec.curr_id
         and BSD       = p_rec.nbs_dep
         and FREQ_V    = p_rec.freq_id
         and COMPROC   = p_cap
         and FLAG      = 0
         and TERM_TYPE = p_rec.term_type
         and ( ( term_type = 1 and term_max  = p_rec.term_max) or (term_type = 2) )
         and rownum    = 1
      returning vidd into l_vidd;

      If (sql%rowcount = 0) then
        -- створюємо новий вид депозиту
        select s_dpu_vidd.nextval
          into l_vidd from dual;

        insert
          into DPU_VIDD
          ( vidd, name, dpu_code, kv,
            bsd, bsn,
            tt, basey, freq_n, tip_ost, flag, fl_extend, fl_autoextend,
            min_summ,  max_summ, limit,
            id_stop,   br_id,    metr,
            shablon,   fl_add,   DPU_TYPE,
            comproc,   freq_v,   type_id,
            term_type, term_min, term_max, term_add )
        values
          ( l_vidd, l_name,  l_type.type_code, p_rec.curr_id,
            p_rec.nbs_dep,    p_rec.nbs_int,
            'DU%', 0, 1, 0, 1, 0, 0,
            l_type.sum_min,  l_type.sum_max,   l_type.sum_add,
            l_type.stop_id,  l_type.br_id,     l_type.metr_id,
            l_type.shablon,  p_rec.fl_add,     p_rec.S181,
            p_cap,           p_rec.freq_id,    l_type.type_id,
            p_rec.term_type, p_rec.term_min,   p_rec.term_max, p_rec.term_add );

        bars_audit.trace( '%s створено новий виду депозиту № %s.', title, to_char(l_vidd) );

      Else
        bars_audit.trace( '%s оновлено параметри виду депозиту № %s.', title, to_char(l_vidd) );
      End If;

      -- капіталізація можлива лище при щомісячній виплаті %%
      If ((p_rec.freq_id = 5) And (l_type.comproc = 1) And (p_cap = 0)) Then
        set_vidd( p_rec, 1 );
      End If;

    end set_vidd;
    ---
  begin

    bars_audit.trace( '%s entry with: typeid => %s.', title, nvl(to_char(p_typeid),'null') );

    begin
      select * into l_type
        from DPU_TYPES where type_id = p_typeid;
    exception
      when NO_DATA_FOUND then
        raise_application_error( -20666, 'Не знайдено депозитний продукт з кодом ' || to_char(p_typeid), true );
    end;

    -- актуалізуємо сіквенс
    dpt_utils.normalization_sequence( 'DPU_VIDD' );

    -- знімаємо активність по всіх видах які належать вказаному типу
    update BARS.DPU_VIDD
       set flag    = 0
     where type_id = p_typeid;

    ---
    -- формуємо макети видів депозитів
    ---
    If (l_type.term_type = 1)
    Then -- якщо терміни депозиту фіксовані

      select nvl2(l_type.sum_add, 1, 0)  as fl_add,
             c.curr_id, f.freq_id, q.name as freq_name,
             o.NBS_DEP, o.NBS_INT, o.IRVK,
             l_type.term_type, m.term_id, m.term_id, l_type.term_add
        bulk collect
        into l_tab
        from DPU_TYPES_OB22     o,
             DPU_TYPES_TERM     m,
             DPU_TYPES_CURRENCY c,
             DPU_TYPES_FREQ     f,
             FREQ               q
       where o.type_id = p_typeid
         and o.r034    = decode(c.curr_id, 980, 1, 2)
         and m.type_id = o.type_id
         and c.type_id = o.type_id
         and f.type_id = o.type_id
         and q.freq    = f.freq_id
       order by o.IRVK, c.CURR_ID, o.NBS_DEP, f.FREQ_ID;

    Else -- якщо термін діапазон

      select nvl2(l_type.sum_add, 1, 0)  as fl_add,
             c.curr_id, f.freq_id, q.name as freq_name,
             o.nbs_dep, o.nbs_int, o.IRVK,
             l_type.term_type, l_type.term_min, l_type.term_max, l_type.term_add
        bulk collect
        into l_tab
        from BARS.dpu_types_ob22     o,
             BARS.dpu_types_currency c,
             BARS.dpu_types_freq     f,
             BARS.freq               q
       where o.type_id = p_typeid
         and o.r034    = decode(c.curr_id, 980, 1, 2)
         and c.type_id = o.type_id
         and f.type_id = o.type_id
         and q.freq    = f.freq_id
       order by o.IRVK, c.curr_id, o.nbs_dep, f.freq_id;

    End If;

    -- for k in 1 .. l_tab.count
    If (l_tab.count > 0) 
    Then

      for k in l_tab.first .. l_tab.last
      Loop
        -- змінюємо параметри існуючих або створюємо нові види депозитів
        set_vidd( l_tab(k) );
      End Loop;

    End If;

    bars_audit.trace( '%s exit.', title );
$else
  begin

    null;
$end
  exception
    when OTHERS then
      bars_audit.info( 'dpu_utils.type_constructor exit with ERROR: ' || dbms_utility.format_error_stack() || dbms_utility.format_error_backtrace() );
      raise_application_error( -20666, SqlErrm, true );
  end TYPE_CONSTRUCTOR;

  --
  --
  --
  procedure ADD_SUBTYPE
  ( p_tp_id        in     dpu_vidd.type_id%type
  , p_sbtp_code    in     dpu_vidd.dpu_code%type
  , p_sbtp_nm      in     dpu_vidd.name%type
  , p_ccy_id       in     dpu_vidd.kv%type
  , p_nbs_dep      in     dpu_vidd.bsd%type
  , p_nbs_int      in     dpu_vidd.bsn%type
  , p_prd_tp_id    in     number -- deprecated
  , p_term_tp      in     dpu_vidd.term_type%type
  , p_term_min     in     dpu_vidd.term_min%type
  , p_term_max     in     dpu_vidd.term_max%type
  , p_amnt_min     in     dpu_vidd.min_summ%type
  , p_amnt_max     in     dpu_vidd.max_summ%type      default null
  , p_amnt_add     in     dpu_vidd.limit%type         default null
  , p_line         in     dpu_vidd.FL_EXTEND%type     default 0
  , p_longation    in     dpu_vidd.fl_autoextend%type default 0
  , p_replenish    in     dpu_vidd.fl_add%type        default 0
  , p_comproc      in     dpu_vidd.comproc%type       default 0
  , p_irvcbl       in     dpu_vidd.irvk%type          default 1
  , p_basey        in     dpu_vidd.basey%type         default 0
  , p_metr         in     dpu_vidd.metr%type          default 0
  , p_freq         in     dpu_vidd.freq_v%type        default 5
  , p_br_id        in     dpu_vidd.br_id%type         default null
  , p_tt           in     dpu_vidd.tt%type            default 'DU%'
  , p_pny_id       in     dpu_vidd.id_stop%type       default -1
  , p_fine         in     dpu_vidd.penya%type         default null
  , p_exn_mth      in     dpu_vidd.exn_mth_id%type    default null
  , p_tpl_id       in     dpu_vidd.shablon%type
  , p_comment      in     dpu_vidd.comments%type      default null
  , p_sbtp_id      out    dpu_vidd.vidd%type
  , p_err_msg      out    varchar2
  ) is
  /**
  <b>ADD_SUBTYPE</b> - Надання доступу групі користувачів до групи рахунків
  %param p_acc_grp_id - Ід. групи рахунків

  %version 1.0
  %usage    створення зв`язку між групою рахунків та групою користувачів
  */
    title       constant  varchar2(64) := $$PLSQL_UNIT||'.ADD_SUBTYPE';
  begin

    bars_audit.trace( '%s: Entry with ( p_tp_id=%s, p_ccy_id=%s, p_term_tp=%s ).'
                    , title, to_char(p_tp_id), to_char(p_ccy_id), to_char(p_term_tp) );

    bars_audit.trace( '%s:( p_term_min=%s, p_term_max=%s, p_amnt_min=%s, p_amnt_max=%s, p_amnt_add=%s, p_tpl_id=%s, p_irvcbl=%s ).'
                    , title, to_char(p_term_min), to_char(p_term_max), to_char(p_amnt_min)
                    , to_char(p_amnt_max), to_char(p_amnt_add), p_tpl_id, to_char(p_irvcbl) );

    case
      when ( p_prd_tp_id Is Null )
      then
        bars_error.raise_nerror( 'DPU', 'GENERAL_ERROR_CODE', 'Не вказано строковість (S181) для виду депозту!' );
      when ( p_term_tp Is Null )
      then
        bars_error.raise_nerror( 'DPU', 'GENERAL_ERROR_CODE', 'Не вказано тип терміну для виду депозту!' );
      when ( p_term_min Is Null )
      then
        bars_error.raise_nerror( 'DPU', 'GENERAL_ERROR_CODE', 'Не вказано мінімальний термін договору для виду депозту!' );
      when ( p_term_max is Null )
      then
        bars_error.raise_nerror( 'DPU', 'GENERAL_ERROR_CODE', 'Не вказано максимальний термін договору для виду депозту!' );
      when ( p_term_min > p_term_max )
      then
        bars_error.raise_nerror( 'DPU', 'GENERAL_ERROR_CODE', 'Мінімальний термін > Максимального терміну!' );
      when ( p_term_min = p_term_max and p_term_tp = 2 )
      then
        bars_error.raise_nerror( 'DPU', 'GENERAL_ERROR_CODE', 'Мінімальний термін = Максимальному терміну!' );
      else
        null;
    end case;

    begin

      insert
        into DPU_VIDD
        ( TYPE_ID, DPU_CODE, NAME, KV, BSD, BSN
        , DPU_TYPE, TERM_TYPE, TERM_MIN, TERM_MAX, MIN_SUMM,  MAX_SUMM, LIMIT
        , FLAG, FL_EXTEND, FL_AUTOEXTEND, FL_ADD, COMPROC, IRVK
        , BASEY, METR, TIP_OST, FREQ_N, FREQ_V, BR_ID, TT, ID_STOP, PENYA
        , SHABLON, COMMENTS, EXN_MTH_ID
        , VIDD )
      values
        ( p_tp_id, p_sbtp_code, p_sbtp_nm, p_ccy_id, p_nbs_dep, p_nbs_int
        , p_prd_tp_id, p_term_tp, p_term_min, p_term_max, p_amnt_min, p_amnt_max, p_amnt_add
        , 0, p_line, p_longation, p_replenish, p_comproc, p_irvcbl
        , p_basey, p_metr, 1, 1, p_freq, p_br_id, p_tt, p_pny_id, p_fine
        , p_tpl_id, p_comment, p_exn_mth
        , S_DPU_VIDD.NextVal )
      returning VIDD
           into p_sbtp_id;

      bars_audit.trace( '%s: created new deposit subtype #%s.'
                      , title, to_char(p_sbtp_id) );

      p_err_msg := null;

    exception
      when OTHERS then
        -- ORA-00001: unique constraint (BARS.PK_DPUVIDD) violated
        p_err_msg := sqlerrm;
        bars_audit.error( title || sqlerrm || dbms_utility.format_error_backtrace() );
    end;

    bars_audit.trace( '%s: Exit.', title );

  end ADD_SUBTYPE;

  --
  --
  --
  procedure DEL_SUBTYPE
  ( p_sbtp_id      in     dpu_vidd.vidd%type
  , p_err_msg      out    varchar2
  ) is
  /**
  <b>DEL_SUBTYPE</b> - Видалення виду депозиту
  %param p_sbtp_id   - Ід. виду депозиту
  %param p_exn_mth   - Ідентифікатор методу автопролонгації депозиту

  %version 1.0
  %usage   Видалення виду депозиту з довідника
  */
    title       constant  varchar2(60) := 'dpu_utils.del_subtype';
    l_qty                 number(3);
  begin

    bars_audit.trace( '%s: Entry with ( sbtp_id=%s ).', title, to_char(p_sbtp_id) );

    select count(DPU_ID)
      into l_qty
      from BARS.DPU_DEAL
     where VIDD = p_sbtp_id;

    if ( l_qty = 0 )
    then

      begin

        delete BARS.DPU_VIDD
         where VIDD = p_sbtp_id;

        bars_audit.trace( '%s: deleted deposit subtype #%s.', title, to_char(p_sbtp_id) );

      exception
        when OTHERS then
          p_err_msg := sqlerrm;
          bars_audit.error( title || sqlerrm || chr(10) || dbms_utility.format_error_backtrace() );
      end;

    else
      p_err_msg := 'Видалення неможливе (відкрито '||to_char(l_qty)||
                   ' договорів з видом депозиту #' ||to_char(p_sbtp_id)||')!';
    end if;

    bars_audit.trace( '%s: Exit.', title );

  end DEL_SUBTYPE;

  --
  --
  --
  procedure DEL_SUBTYPE
  ( p_sbtp_id      in     dpu_vidd.vidd%type
  ) is
    l_err_msg             varchar2(2000);
    l_pos                 number(4);
  begin

    DEL_SUBTYPE( p_sbtp_id => p_sbtp_id
               , p_err_msg => l_err_msg
            );

    if ( l_err_msg Is Null )
    then
      null;
    else

      l_pos := inStr( l_err_msg, 'ORA-' );

      if ( l_pos > 0 )
      then
        l_pos     := l_pos + 9;
        l_err_msg := SubStr( l_err_msg, l_pos, inStr( l_err_msg, chr(10) ) - l_pos );
      else
        null;
      end if;

      bars_error.raise_nerror( 'DPU', 'GENERAL_ERROR_CODE', l_err_msg );

    end if;

  end DEL_SUBTYPE;

  --
  --
  --
  procedure UPD_SUBTYPE
  ( p_sbtp_id      in     dpu_vidd.vidd%type
  , p_sbtp_code    in     dpu_vidd.dpu_code%type
  , p_sbtp_nm      in     dpu_vidd.name%type
  , p_term_tp      in     dpu_vidd.term_type%type
  , p_term_min     in     dpu_vidd.term_min%type
  , p_term_max     in     dpu_vidd.term_max%type
  , p_amnt_min     in     dpu_vidd.min_summ%type
  , p_amnt_max     in     dpu_vidd.max_summ%type
  , p_amnt_add     in     dpu_vidd.limit%type
  , p_longation    in     dpu_vidd.fl_autoextend%type
  , p_replenish    in     dpu_vidd.fl_add%type
  , p_comproc      in     dpu_vidd.comproc%type
  , p_irvcbl       in     dpu_vidd.irvk%type
  , p_freq         in     dpu_vidd.freq_v%type
  , p_br_id        in     dpu_vidd.br_id%type
  , p_tt           in     dpu_vidd.tt%type
  , p_pny_id       in     dpu_vidd.id_stop%type
  , p_fine         in     dpu_vidd.penya%type         default null
  , p_exn_mth      in     dpu_vidd.exn_mth_id%type    default null
  , p_tpl_id       in     dpu_vidd.shablon%type
  , p_comment      in     dpu_vidd.comments%type
  , p_err_msg      out    varchar2
  ) is
  /**
  <b>UPD_SUBTYPE</b> - Внесення змін у параметри виду депозиту
  %param p_sbtp_id   - Ід. виду депозиту
  %param p_sbtp_code -
  %param p_sbtp_nm   -
  %param p_term_tp   -
  %param p_term_min  -
  %param p_term_max  -
  %param p_amnt_min  -
  %param p_amnt_max  -
  %param p_amnt_add  -
  %param p_longation -
  %param p_replenish -
  %param p_comproc   -
  %param p_irvcbl    - 
  %param p_freq      -
  %param p_br_id     -
  %param p_tt        -
  %param p_pny_id    -
  %param p_fine      -
  %param p_exn_mth   - Ідентифікатор методу автопролонгації депозиту
  %param p_tpl_id    -
  %param p_comment   -
  %param p_err_msg   -

  %version 1.3
  %usage   зміна параметрів виду депозиту
  */
    title       constant  varchar2(60) := 'dpu_utils.upd_subtype';
  begin

    bars_audit.trace( '%s: Entry with ( sbtp_id=%s, term_tp=%s, term_min=%s, term_max=%s, amnt_min=%s, amnt_max=%s, amnt_add=%s ).'
                    , title, to_char(p_sbtp_id), to_char(p_term_tp), to_char(p_term_min)
                    , to_char(p_term_max), to_char(p_amnt_min), to_char(p_amnt_max), to_char(p_amnt_add) );

    bars_audit.trace( '%s: Entry with ( longation=%s, replenish=%s, comproc=%s, irvcbl=%s, tpl_id=%s ).'
                    , title, to_char(p_longation), to_char(p_replenish), to_char(p_comproc)
                    , to_char(p_irvcbl), p_tpl_id );

    case
      when ( p_term_min Is Null )
      then
        bars_error.raise_nerror( 'DPU', 'GENERAL_ERROR_CODE', 'Не вказано мінімальний термін договору для виду депозту!' );
      when ( p_term_max is Null )
      then
        bars_error.raise_nerror( 'DPU', 'GENERAL_ERROR_CODE', 'Не вказано максимальний термін договору для виду депозту!' );
      when ( p_term_min > p_term_max )
      then
        bars_error.raise_nerror( 'DPU', 'GENERAL_ERROR_CODE', 'Мінімальний термін перевишує максимальний термін!' );
      else
        null;
    end case;

    begin

      update DPU_VIDD
         set DPU_CODE      = p_sbtp_code
           , NAME          = p_sbtp_nm
           , TERM_TYPE     = p_term_tp
           , TERM_MIN      = p_term_min
           , TERM_MAX      = p_term_max
           , MIN_SUMM      = p_amnt_min
           , MAX_SUMM      = p_amnt_max
           , LIMIT         = nvl(p_amnt_add,nvl2(p_replenish,0,p_amnt_add))
           , FREQ_V        = p_freq
           , BR_ID         = p_br_id
           , TT            = p_tt
           , ID_STOP       = p_pny_id
           , PENYA         = p_fine
           , SHABLON       = p_tpl_id
           , COMMENTS      = p_comment
           , FL_AUTOEXTEND = p_longation
           , FL_ADD        = p_replenish
           , COMPROC       = p_comproc
           , IRVK          = p_irvcbl
           , EXN_MTH_ID    = p_exn_mth
       where VIDD = p_sbtp_id;

      if ( sql%rowcount > 0 )
      then
        bars_audit.trace( '%s: changed parameters of deposit subtype #%s.', title, to_char(p_sbtp_id) );
      end if;

    exception
      when OTHERS then
        p_err_msg := sqlerrm;
        bars_audit.error( title || sqlerrm || dbms_utility.format_error_backtrace() );
    end;

    bars_audit.trace( '%s: Exit.', title );

  end UPD_SUBTYPE;

  --
  --
  --
  procedure SUBTYPE_CHG_STE
  ( p_sbtp_id      in     dpu_vidd.vidd%type
  , p_sbtp_ste     in     dpu_vidd.flag%type
  ) is
  /**
  <b>SUBTYPE_CHG_STE</b> - Зміна стану виду депозитного договору
  %param p_sbtp_id   - Ід.  виду депозиту
  %param p_sbtp_ste  - Стан виду депозиту

  %version 1.0
  %usage   Зміна ознаки активності виду депозиту ( 1 - активний / 0 - неактивний )
  */
    title       constant  varchar2(60) := 'dpu_utils.subtype_chg_ste';
    l_qty                 number(3);
  begin

    bars_audit.trace( '%s: Entry with ( sbtp_id=%s, p_sbtp_ste=%s ).', title, to_char(p_sbtp_id), to_char(p_sbtp_ste) );

    update BARS.DPU_VIDD
       set FLAG = p_sbtp_ste
     where VIDD = p_sbtp_id;

    if (sql%rowcount > 0)
    then
      bars_audit.trace( '%s: changed state for deposit subtype #%s.', title, to_char(p_sbtp_id) );
    end if;

    bars_audit.trace( '%s: Exit.', title );

  end SUBTYPE_CHG_STE;

  --
  -- Експорт вид депозиту в SQL-сценарій
  --
  procedure EXPRT_SUBTYPE
  ( p_sbtp_id      in     dpu_vidd.vidd%type
  , p_script          out clob
  , p_file_nm         out varchar2
  ) is
  /**
  <b>SUBTYPE_CHG_STE</b> - Експорт вид депозиту в SQL-сценарій
  %param p_sbtp_id   - Ід. виду депозиту
  %param p_script    - SQL-сценарій створення/оновлення виду депозиту
  %paramp_file_nm    - Назва файлу SQL-сценарію (містить Ід. виду депозиту)

  %version 1.0
  %usage   Експорт вид депозиту
  */
    title       constant  varchar2(64) := $$PLSQL_UNIT||'.EXPRT_SUBTYPE';
    l_script              clob;
  begin

    bars_audit.trace( '%s: Entry with ( sbtp_id=%s ).', title, to_char(p_sbtp_id) );
    
    dbms_lob.createtemporary( p_script, false );

    GEN_SCRIPT4VIDD( p_sbtp_id );

    select CLOBDATA
      into l_script
      from TMP_EXPDPTYPE
     where MODCODE = c_modcode
       and TYPEID  = p_sbtp_id;

    p_file_nm := 'dputype_'||to_char(p_sbtp_id,'FM0000')||'.sql';
    
    dbms_lob.append( p_script, l_script );

    bars_audit.trace( '%s: Exit.', title );

  end EXPRT_SUBTYPE;

  --
  -- Новий код штрафу
  --
  procedure CRT_PENALTY
  ( penalty_nm     in     dpt_stop.name%type
  , msr_prd_code   in     dpt_stop.fl%type       default 0 -- В %-ах від строку
  , pny_bal_tp     in     dpt_stop.sh_ost%type   default 2 -- По історії залишку
  , ruthless       in     dpt_stop.sh_proc%type  default 0 -- Без
  ) is
    title       constant  varchar2(60) := 'dpu_utils.crt_penalty';
    l_pny_id              dpt_stop.id%type;
    l_err_msg             sec_audit.rec_message%type;
  begin

    bars_audit.trace( '%s: Entry with ( penalty_nm=%s, ).', title );

    add_penalty( penalty_nm  => penalty_nm
               , msr_prd_id  => msr_prd_code
               , pny_bal_tp  => pny_bal_tp
               , ruthless    => ruthless
               , module_code => 'DPU'
               , penalty_id  => l_pny_id
               , p_err_msg   => l_err_msg
               );

    bars_audit.trace( '%s: Exit with ( pny_id=%s, err_msg=%s ).'
                    , title, to_char(l_pny_id), l_err_msg );

  end CRT_PENALTY;

  --
  -- Новий код штрафу
  --
  procedure ADD_PENALTY
  ( penalty_nm     in     dpt_stop.name%type
  , msr_prd_id     in     dpt_stop.fl%type       default 0 -- В %-ах від строку
  , pny_bal_tp     in     dpt_stop.sh_ost%type   default 2 -- По історії залишку
  , ruthless       in     dpt_stop.sh_proc%type  default 0 -- Без
  , module_code    in     dpt_stop.mod_code%type default 'DPU'
  , penalty_id     out    dpt_stop.id%type
 , p_err_msg      out    sec_audit.rec_message%type
  ) is
    title       constant  varchar2(60) := 'dpu_utils.add_penalty';
    l_yes                 signtype;
    ---
    l_max_val  pls_integer;
    l_crn_val  pls_integer;
    ---
  begin

    bars_audit.trace( '%s: Entry with (msr_prd_id=%s, pny_bal_tp=%s, ruthless=%s).'
                    , title, to_char(msr_prd_id), to_char(pny_bal_tp), to_char(ruthless) );

    l_yes := case when ( nvl(ruthless,0) = 0 ) then 0 else 1 end;

    bars_audit.trace( '%s: (l_yes=%s).', title, to_char(l_yes) );

    begin

      insert
        into BARS.DPT_STOP
        ( ID, NAME, FL, SH_OST, SH_PROC, MOD_CODE )
      values
        ( S_DPT_STOP_ID.NextVal, penalty_nm, msr_prd_id, pny_bal_tp, l_yes, module_code )
      returning ID
           into penalty_id;

      bars_audit.trace( '%s: created new deposit penalty #%s.'
                      , title, to_char(penalty_id) );

      p_err_msg := null;

    exception
      when DUP_VAL_ON_INDEX then

        -- виправляємо значення сіквенса
        begin

          select max(ID)
            into l_max_val
            from BARS.DPT_STOP;

          l_crn_val := S_DPT_STOP_ID.CurrVal;

          execute immediate 'alter sequence S_DPT_STOP_ID increment by ' || to_char( abs(l_max_val - l_crn_val) );

          execute immediate 'select S_DPT_STOP_ID.nextval from dual'
             into l_crn_val;

          execute immediate 'alter sequence S_DPT_STOP_ID increment by 1';

        end;

        -- повторний запуск
        DPU_UTILS.ADD_PENALTY( penalty_nm  => penalty_nm
                             , msr_prd_id  => msr_prd_id
                             , pny_bal_tp  => pny_bal_tp
                             , ruthless    => ruthless
                             , module_code => module_code
                             , penalty_id  => penalty_id
                             , p_err_msg   => p_err_msg );

      when OTHERS then
        p_err_msg :=  SubStr(sqlerrm,1,4000);
        bars_audit.error( SubStr(title || sqlerrm || dbms_utility.format_error_backtrace(),1,4000) );
    end;

    bars_audit.trace( '%s: Exit.', title );

  end ADD_PENALTY;

  --
  -- Зміна параметрів штрафу
  --
  procedure UPD_PENALTY
  ( penalty_id     in     dpt_stop.id%type
  , penalty_nm     in     dpt_stop.name%type
  , msr_prd_id     in     dpt_stop.fl%type
  , pny_bal_tp     in     dpt_stop.sh_ost%type
  , ruthless       in     dpt_stop.sh_proc%type
  , penalty_tp     in     dpt_stop_a.sh_proc%type default null
  , pny_prd_tp     in     dpt_stop_a.sh_term%type default null
  , p_err_msg      out    varchar2
  ) is
  /*
  - Ознака безжального штрафу за умови, що вклад не вилітав повний місяць
  */
    title       constant  varchar2(60) := 'dpu_utils.upd_penalty';
  begin

    bars_audit.trace( '%s: Entry with ( penalty_id=%s, penalty_tp=%s, pny_prd_tp=%s ).'
                    , title, to_char(penalty_id), to_char(penalty_tp), to_char(pny_prd_tp) );

    p_err_msg := null;

    begin

      update BARS.DPT_STOP
         set NAME    = nvl( penalty_nm, NAME    )
           , FL      = nvl( msr_prd_id, FL      )
           , SH_OST  = nvl( pny_bal_tp, SH_PROC )
           , SH_PROC = nvl( ruthless,   SH_OST  )
       where ID = penalty_id;

      if (sql%rowcount > 0)
      then
        bars_audit.trace( '%s: changed parameters deposit penalty #%s.', title, to_char(penalty_id) );
      end if;

      if ( penalty_tp Is Not Null )
      then
        update BARS.DPT_STOP_A
           set SH_PROC = penalty_tp
         where ID = penalty_id
           and SH_PROC <> penalty_tp;
      end if;

      if (sql%rowcount > 0)
      then
        bars_audit.trace( '%s: changed penalty type on %s for penalty #%s.'
                        , title, to_char(penalty_tp), to_char(penalty_id) );
      end if;

      if ( pny_prd_tp Is Not Null )
      then
        update BARS.DPT_STOP_A
           set SH_TERM = pny_prd_tp
             , K_TERM  = null
         where ID = penalty_id
           and SH_TERM <> pny_prd_tp;
      end if;

      if (sql%rowcount > 0)
      then
        bars_audit.trace( '%s: changed period type on %s for penalty #%s.'
                        , title, to_char(pny_prd_tp), to_char(penalty_id) );
      end if;

    exception
      when OTHERS then
        p_err_msg := sqlerrm;
        bars_audit.error( title || sqlerrm || dbms_utility.format_error_backtrace() );
    end;

    bars_audit.trace( '%s: Exit.', title );

  end UPD_PENALTY;

  ---
  --
  ---
  procedure DEL_PENALTY
  ( penalty_id     in     dpt_stop.id%type
  ) is
    title       constant  varchar2(60) := 'dpu_utils.del_penalty';
    l_qty                 number(3);
  begin

    bars_audit.trace( '%s: Entry with ( penalty_id=%s ).', title, to_char(penalty_id) );

    select count(ID)
      into l_qty
      from BARS.DPT_STOP
     where ID = penalty_id
       and MOD_CODE = 'DPU';

    if ( l_qty = 0 )
    then
      bars_error.raise_nerror( 'DPU', 'GENERAL_ERROR_CODE', 'Видалення неможливе (штраф не належить депозитному модулю ЮО)!' );
    end if;

    -- select count(TYPE_ID)
    --   into l_qty
    --   from BARS.DPU_TYPES
    --  where STOP_ID = penalty_id;
    --
    -- if ( l_qty > 0 )
    -- then
    --   bars_error.raise_nerror( 'DPU', 'GENERAL_ERROR_CODE', 'Видалення неможливе (існує '||to_char(l_qty)||
    --                                   ' типів депозиту з вказаним кодом штрафу)!' );
    -- end if;

    select count(VIDD)
      into l_qty
      from BARS.DPU_VIDD
     where ID_STOP = penalty_id;

    if ( l_qty > 0 )
    then
      bars_error.raise_nerror( 'DPU', 'GENERAL_ERROR_CODE', 'Видалення неможливе (існує '||to_char(l_qty)||
                                      ' видів депозиту з вказаним кодом штрафу)!' );
    end if;

    select count(DPU_ID)
      into l_qty
      from BARS.DPU_DEAL
     where ID_STOP = penalty_id;

    if ( l_qty > 0 )
    then
      bars_error.raise_nerror( 'DPU', 'GENERAL_ERROR_CODE', 'Видалення неможливе (існує '||to_char(l_qty)||
                                      ' депозитних договорів з вказаним кодом штрафу)!' );
    end if;

    begin

      delete DPT_STOP_A
       where ID = penalty_id;

      delete DPT_STOP
       where ID = penalty_id;

      bars_audit.trace( '%s: deleted deposit penalty #%s.', title, to_char(penalty_id) );

    exception
      when OTHERS then
        -- p_err_msg := sqlerrm;
        bars_audit.error( title || sqlerrm || dbms_utility.format_error_backtrace() );
        bars_error.raise_nerror( 'DPU', 'GENERAL_ERROR_CODE', sqlerrm );
    end;

    bars_audit.trace( '%s: Exit.', title );

  end DEL_PENALTY;

  ---
  --
  ---
  procedure SET_PENALTY_VALUE
  ( penalty_id     in     dpt_stop.id%type
  , pny_lwr_lmt    in     dpt_stop_a.k_srok%type
  , pny_upr_lmt    in     dpt_stop_a.k_srok%type
  , penalty_val    in     dpt_stop_a.k_proc%type
  , penalty_tp     in     dpt_stop_a.sh_proc%type
  , pny_prd_val    in     dpt_stop_a.k_term%type  default null
  , pny_prd_tp     in     dpt_stop_a.sh_term%type default 0
  , p_err_msg      out    varchar2
  ) is
  /**
  <b>SET_PENALTY_VALUE</b> - Внесення змін у параметри штрафу депозиту 
  %param pny_lwr_lmt  - нижня межа ( = 0 - вставка, > 0 - редагування
  %param pny_upr_lmt  - верхня межа
  %param penalty_val  - значення штрафу в штрафному періоді
  %param penalty_tp   - тип штрафу
  %param pny_prd_val  - значення штрафного періоду
  %param pny_prd_tp   - тип штрафний період
  %param p_err_msg    - повідомлення про помилку

  %version 1.3
  %usage   зміна параметрів штрафу депозиту
  */
    title       constant  varchar2(64) := $$PLSQL_UNIT || '.SET_PENALTY_VALUE';
    l_lwr_lmt             dpt_stop_a.k_srok%type;
    l_upr_lmt             dpt_stop_a.k_srok%type;
    l_msr_prd_id          dpt_stop.fl%type;
  begin

    bars_audit.trace( '%s: Entry with ( penalty_id=%s, pny_lwr_lmt=%s, pny_upr_lmt=%s, '||
                      'penalty_val=%s, penalty_tp=%s, pny_prd_val=%s, pny_prd_tp=%s ).', title
                    , to_char(penalty_id), to_char(pny_lwr_lmt), to_char(pny_upr_lmt), to_char(penalty_val)
                    , to_char(penalty_tp), to_char(pny_prd_val), to_char(pny_prd_tp) );

    case -- перевірки
      when ( penalty_tp = 5 )
      then -- Тип штрафу -> "Фіксований тип %% ставки"
        begin
          select null
            into l_lwr_lmt
            from BRATES
           where BR_ID = penalty_val;
        exception
          when NO_DATA_FOUND then
            bars_error.raise_nerror( c_modcode, 'GENERAL_ERROR_CODE', 'Не знайдено базову ставку з кодом = '||to_char(penalty_val) );
        end;
--    when ( l_msr_prd_id = 0 )
--    then -- Одиниці виміру періоду для штрафу -> "В %-ах від строку"
--      case
--        when ( pny_upr_lmt > 100 )
--        then bars_error.raise_nerror( c_modcode, 'GENERAL_ERROR_CODE', '' );
--        when ( penalty_val > 100 )
--        then bars_error.raise_nerror( c_modcode, 'GENERAL_ERROR_CODE', '' );
--        else null;
--      end case;
      else
        null;
    end case;
    
    begin
      
      p_err_msg := null;
      
      if ( pny_lwr_lmt >= 0 )
      then -- edit record

        If ( pny_lwr_lmt >= pny_upr_lmt )
        then
          bars_error.raise_nerror( c_modcode, 'GENERAL_ERROR_CODE', 'Нижня межа штрафного терміну більша або рівна верхній межі!' );
        end if;

        select max( case when (K_SROK <= pny_lwr_lmt) then K_SROK else null end )
             , min( case when (K_SROK >  pny_lwr_lmt) then K_SROK else null end )
          into l_lwr_lmt
             , l_upr_lmt
          from DPT_STOP_A
         where ID = penalty_id;
        
        bars_audit.trace( '%s: l_lwr_lmt=%s, l_upr_lmt=%s.', title, to_char(l_lwr_lmt), to_char(l_upr_lmt) );

        -- edit penalty value
        update DPT_STOP_A
           set K_PROC  = penalty_val
             , SH_PROC = penalty_tp
             , K_TERM  = pny_prd_val
             , SH_TERM = pny_prd_tp
         where ID = penalty_id
           and K_SROK = pny_lwr_lmt;

        -- edit penalty limit
        update DPT_STOP_A
           set K_SROK = pny_upr_lmt
         where ID = penalty_id
           and K_SROK = l_upr_lmt;

      else -- new record

        select max( case when (K_SROK <  pny_upr_lmt) then K_SROK else null end )
             , min( case when (K_SROK >= pny_upr_lmt) then K_SROK else null end )
          into l_lwr_lmt
             , l_upr_lmt
          from DPT_STOP_A
         where ID = penalty_id;

        bars_audit.trace( '%s: l_lwr_lmt=%s, l_upr_lmt=%s.', title, to_char(l_lwr_lmt), to_char(l_upr_lmt) );

        if ( l_lwr_lmt Is Null and l_upr_lmt Is Null )
        then -- first one

          insert -- нижня межа
            into DPT_STOP_A
            ( ID, K_SROK, K_PROC, SH_PROC, K_TERM, SH_TERM )
          values
            ( penalty_id, 0, penalty_val, penalty_tp, pny_prd_val, pny_prd_tp );

          bars_audit.trace( '%s: inserted lower limit value for penalty #%s.', title, to_char(penalty_id) );

          insert -- верхня межа
            into DPT_STOP_A
            ( ID, K_SROK, K_PROC, SH_PROC, K_TERM, SH_TERM )
          values
            ( penalty_id, pny_upr_lmt, 100, 0, NULL, 0 );

          bars_audit.trace( '%s: inserted upper limit value for penalty #%s.', title, to_char(penalty_id) );

        else -- all subsequent

          -- duplicate row
          insert
            into DPT_STOP_A
               ( ID, K_SROK,      K_PROC, SH_PROC, K_TERM, SH_TERM )
          select ID, pny_upr_lmt, K_PROC, SH_PROC, K_TERM, SH_TERM
            from BARS.DPT_STOP_A
           where ID = penalty_id
             and K_SROK = l_lwr_lmt;

          -- update row
          update DPT_STOP_A
             set K_PROC  = penalty_val
               , SH_PROC = penalty_tp
               , K_TERM  = pny_prd_val
               , SH_TERM = pny_prd_tp
           where ID      = penalty_id
             and K_SROK  = l_lwr_lmt;

        end if;

      end if;

    exception
      when OTHERS then
        p_err_msg := sqlerrm;
        bars_audit.error( title || sqlerrm || dbms_utility.format_error_backtrace() );
        rollback;
    end;

    bars_audit.trace( '%s: Exit with ( err_msg = %s ).', title, p_err_msg );

  end SET_PENALTY_VALUE;

  ---
  --
  ---
  procedure DEL_PENALTY_VALUE
  ( penalty_id     in     dpt_stop_a.id%type
  , penalty_prd    in     dpt_stop_a.k_srok%type
  , p_err_msg      out    varchar2
  ) is
    title       constant  varchar2(60) := 'dpu_utils.del_penalty_value';
    l_qty                 pls_integer;
  begin

    bars_audit.trace( '%s: Entry with ( sbtp_id=%s ).', title, to_char(penalty_id) );

    begin

      if ( penalty_prd Is Null )
      then -- delete all records

        delete DPT_STOP_A
         where ID = penalty_id;

      else -- only one record

        select count(1)
          into l_qty
          from DPT_STOP_A
         where ID = penalty_id;
        
        if ( l_qty > 2 )
        then

          delete DPT_STOP_A
           where ID = penalty_id
             and K_SROK = penalty_prd;

        else
          
          delete DPT_STOP_A
           where ID = penalty_id;
          
        end if;

      end if;

      bars_audit.trace( '%s: deleted deposit penalty value for #%s.', title, to_char(penalty_id) );

    exception
      when OTHERS then
        p_err_msg := sqlerrm;
        bars_audit.error( title || sqlerrm || dbms_utility.format_error_backtrace() );
    end;

    bars_audit.trace( '%s: Exit.', title );

  end DEL_PENALTY_VALUE;

  --
  --
  --
  procedure FILL_PROCDR
  ( p_clean        in     signtype             default 0
  , p_open         in     signtype             default 0
  , p_kf           in     proc_dr$base.kf%type default sys_context('bars_context','user_mfo')
  ) is
  /**
  <b>FILL_PROCDR</b> - Наповнення довідника рахунків витрат для видів депозитів ЮО
  %param p_clean - Очищення довідника
  %param p_open  - Відкрити рахунок якщо відсутній
  %param p_kf    - Код фiлiалу (МФО)

  %version 1.2
  %usage   автоматичне заповнення довідника рахунків витрат для депозитних продуктів ЮО
  */
    title     constant    varchar2(64)           := 'dpu_utils.fill_procdr';
    src       constant    proc_dr$base.sour%type := 4;

    type t_rec is record( vidd       dpu_vidd.vidd%type
                        , bsd        accounts.nbs%type
                        , bsn        accounts.nbs%type
                        , bsd7       accounts.nbs%type
                        , ob22_d7    accounts.ob22%type
                        , nbs_red    accounts.nbs%type
                        , ob22_red   accounts.ob22%type
                        , branch     accounts.branch%type );

    type t_tab    is table of t_rec;
    type tab_type is table of accounts.nls%type
                     index by varchar2(21);

    l_tab                  t_tab;
    t_acc                  tab_type;
    l_branch               branch.branch%type := '*';
    l_branch_mask          varchar2(16);

    l_nbs_d7               dpu_types_ob22.nbs_exp%type  := '*';
    l_ob22d7               dpu_types_ob22.ob22_exp%type := '*';
    l_nbs_red              dpu_types_ob22.nbs_red%type  := '*';
    l_ob22_red             dpu_types_ob22.ob22_red%type := '*';

    l_nls_exp              accounts.nls%type;
    l_nls_red              accounts.nls%type;

    l_usr_lvl              number(1);
    ---
    procedure OPEN_ACCOUNT
    ( p_nbs     in  accounts.nbs%type
    , p_ob22    in  accounts.ob22%type
    , p_branch  in  accounts.branch%type
    , p_kv      in  accounts.kv%type default 980
    , p_nls     out accounts.nls%type
    ) is
      l_acc         accounts.nls%type;
    begin

      begin

        -- 1) Установить код вал
        pul.Set_Mas_Ini('OP_BSOB_KV', to_char(p_kv) , 'Код валюти для открытия счета');

        -- 2) открыть счет
        BARS.OP_BMASK( p_branch, p_nbs, p_ob22, null, null, null, p_nls, l_acc );

        update ACCOUNTS
           set TOBO   = p_branch
             , BRANCH = p_branch
             , OB22   = p_ob22
         where ACC    = l_acc;

        -- 3) додали в масив
        t_acc(p_nbs||p_ob22||p_branch) := p_nls;

      exception
        when OTHERS then
          p_nls := null;
          bars_audit.info( title || sqlerrm || dbms_utility.format_error_backtrace() );
      end;

    end OPEN_ACCOUNT;
    ---
  begin

    bars_audit.trace( '%s: Entry with ( clean=%s, open=%s, kf=%s ).'
                    , title, to_char(p_clean), to_char(p_open), p_kf );

    -- контекстний рівень користувача
    l_usr_lvl := (length(sys_context('bars_context','user_branch'))-1)/7;

    case
    when ( l_usr_lvl = 0 )
    then
      if ( p_kf Is Null )
      then -- for all KF
        for i in ( select KF
                     from MV_KF )
        loop
          FILL_PROCDR( p_clean => p_clean
                     , p_open  => p_open
                     , p_kf    => i.KF );
        end loop;
      else -- for one KF
        BARS_CONTEXT.SUBST_MFO( p_kf );
        l_branch_mask := '/' || p_kf || '/______/%';
      end if;
    when ( l_usr_lvl = 1 )
    then -- ігноруємо значення параметру p_kf (так як може бути вказано NULL або KF іншого РУ)
      l_branch_mask := sys_context('bars_context','user_branch') || '______/%';
    else
      raise_application_error( -20666, 'ERR: Заборонено виконання функції користувачем '||to_char(l_usr_lvl)||'-го рівня!', true );
    end case;

    if ( p_clean = 1 )
    then -- з очищенням наявних записів

      delete PROC_DR$BASE
       where KF = p_kf
         and ( NBS, SOUR, REZID ) in ( select BSD, 4, VIDD
                                         from DPU_VIDD );

      bars_audit.trace( title || ' deleted: '||to_char(sql%rowcount)||' rows.' );

      select o.VIDD,
             o.NBS_DEP, o.NBS_INT,
             o.NBS_EXP, o.OB22_EXP,
             o.NBS_RED, o.OB22_RED,
             b.BRANCH
        bulk collect
        into l_tab
        from DPU_VIDD_OB22 o
           , BRANCH        b
       where b.DATE_CLOSED is null
         and b.BRANCH like l_branch_mask
       order by o.NBS_EXP, o.OB22_EXP, b.BRANCH;

    else

      select o.vidd,
             o.nbs_dep, o.nbs_int,
             o.nbs_exp, o.ob22_exp,
             o.nbs_red, o.ob22_red,
             b.branch
        bulk collect
        into l_tab
        from DPU_VIDD_OB22 o -- активні види депозитів
           , BRANCH        b
       where b.DATE_CLOSED is null
         and b.BRANCH like l_branch_mask
         and not exists ( select 1 from PROC_DR$BASE
                           WHERE nbs = o.nbs_dep
                             AND branch = b.branch
                             AND sour = 4
                             AND rezid = o.vidd )
       order by o.nbs_exp, o.ob22_exp, b.branch;

    end if;

    if ( l_tab.count > 0 )
    then

      bars_audit.trace( '%s: %s rows selected.', title, to_char(l_tab.count) );

      l_branch_mask := SubStr( l_branch_mask, 1, 15 );

      -- пошук рахунків витрат / зменшення витрат
      for acc in ( select NBS || OB22 || BRANCH as CODE, NLS
                     from ( select a7.NBS, a7.OB22, a7.BRANCH, a7.NLS
                                 , dense_rank() over ( partition by a7.NBS, a7.OB22, a7.BRANCH order by a7.NBS, a7.OB22, a7.BRANCH, a7.ACC ) as MIN_ACC_F
                              from ( select unique NBS_EXP, OB22_EXP
                                       from DPU_TYPES_OB22
                                   ) ob
                              join ACCOUNTS a7
                                on ( a7.NBS = ob.NBS_EXP and a7.OB22 = ob.OB22_EXP )
                             where a7.KV = 980
                               and a7.DAZS Is NULL
                               and a7.BRANCH like l_branch_mask
                          )
                    where MIN_ACC_F = 1
                    union all
                   select NBS || OB22 || BRANCH as CODE, NLS
                     from ( select a6.NBS, a6.OB22, a6.BRANCH, a6.NLS
                                 , dense_rank() over ( partition by a6.NBS, a6.OB22, a6.BRANCH order by a6.NBS, a6.OB22, a6.BRANCH, a6.ACC ) as MIN_ACC_F
                              from ( select unique NBS_RED, OB22_RED
                                       from DPU_TYPES_OB22
                                      where NBS_RED  Is Not Null
                                        and OB22_RED Is Not Null
                                   ) ob
                              join ACCOUNTS a6
                                on ( a6.NBS = ob.NBS_RED and a6.OB22 = ob.OB22_RED )
                             where a6.KV = 980
                               and a6.DAZS Is NULL
                               and a6.BRANCH like l_branch_mask
                          )
                    where MIN_ACC_F = 1 )
      loop
        t_acc(acc.CODE) := acc.NLS;
      end loop;

      --
      for k in l_tab.first .. l_tab.last
      loop

        if ( (l_nbs_d7 != l_tab(k).bsd7) Or
             (l_ob22d7 != l_tab(k).ob22_d7) Or
             (l_branch != SubStr(l_tab(k).branch, 1, 15)) )
        then

          l_branch   := SubStr(l_tab(k).branch, 1, 15);
          l_nbs_d7   := l_tab(k).bsd7;
          l_ob22d7   := l_tab(k).ob22_d7;
          l_nbs_red  := l_tab(k).nbs_red;
          l_ob22_red := l_tab(k).ob22_red;

          -- рахунок витрат
          begin
            l_nls_exp := t_acc( l_nbs_d7 || l_ob22d7 || l_branch );
          exception
            when NO_DATA_FOUND then
              if ( p_open = 1 )
              then
                open_account( p_nbs    => l_nbs_d7
                            , p_ob22   => l_ob22d7
                            , p_branch => l_branch
                            , p_nls    => l_nls_exp );
              else
                l_nls_exp := null;
              end if;
          end;

          -- рахунок зменшення витрат
          if (l_ob22_red is Not Null)
          then
            begin
              l_nls_red := t_acc( l_nbs_red || l_ob22_red || l_branch );
            exception
              when NO_DATA_FOUND then
                if ( p_open = 1 and l_nls_exp is not null )
                then
                  open_account( p_nbs    => l_nbs_red
                              , p_ob22   => l_ob22_red
                              , p_branch => l_branch
                              , p_nls    => l_nls_red );
                else
                  l_nls_red := null;
                end if;
            end;
          else
            l_nls_red := null;
          end if;

        end if;

        if ( l_nls_exp is not null )
        then
          begin
            insert into PROC_DR$BASE
              (         NBS,       G67,       V67, SOUR,         NBSN,      G67N,      V67N,         REZID, IO,          BRANCH,    KF)
            values
              (l_tab(k).bsd, l_nls_exp, l_nls_exp,    4, l_tab(k).bsn, l_nls_red, l_nls_red, l_tab(k).vidd,  1, l_tab(k).branch, p_kf );

          exception
            when OTHERS then
              bars_audit.error( title || chr(10) || dbms_utility.format_error_stack() || dbms_utility.format_error_backtrace() );
          end;
        end if;

      end loop;

      commit;

      l_tab.delete();
      t_acc.delete();

    else

      if ( p_clean = 1 )
      then -- з очищенням наявних записів
        rollback;
        raise_application_error( -20666, 'ERR: Не заповнено довідник ОБ22 для типів депозитів ЮО!', true );
      else
        bars_audit.info( title || ' No rows selected!' );
      end if;

    end if;

    bars_audit.trace( '%s: Exit.', title );

  end FILL_PROCDR;

  --
  --
  --
  procedure ADD_TYPE
  ( p_tp_nm        in     dpu_types.type_name%type
  , p_tp_code      in     dpu_types.type_code%type default null
  , p_sort_ordr    in     dpu_types.sort_ord%type  default null
  , p_active       in     dpu_types.fl_active%type default 0
  , p_tpl_id       in     dpu_types.shablon%type   default null
  , p_tp_id        out    dpu_types.type_id%type
  , p_err_msg      out    varchar2
  ) is
  /**
  <b>ADD_TYPE</b> - Створення нового типу депозиту ЮО
  %param p_tp_nm     - Назва типу
  %param p_tp_code   - Код типу
  %param p_sort_ordr - Порядковий номер для сортування
  %param p_active    - Ознака активності
  %param p_tpl_id    - Ід. шаблону договору

  %version 1.0
  %usage    створення нового типу депозиту ЮО
  */
    title       constant  varchar2(60) := 'dpu_utils.add_type';
  begin

    bars_audit.trace( '%s: Entry with (tp_nm=%s, tp_code=%s, sort_ordr=%s, active=%s, tpl_id=%s ).'
                    , title, p_tp_nm, p_tp_code, to_char(p_sort_ordr), to_char(p_active), p_tpl_id );

    case
      when ( p_tp_nm Is Null )
      then bars_error.raise_nerror( 'DPU', 'GENERAL_ERROR_CODE', 'Не вказано назву типу!' );
      when ( p_active Not In ( 0, 1 ) )
      then bars_error.raise_nerror( 'DPU', 'GENERAL_ERROR_CODE', 'Вказано некоректне значення для ознаки активності типу!' );
      else null;
    end case;

    begin

      select max(TYPE_ID)
        into p_tp_id
        from BARS.DPU_TYPES;

      p_tp_id := nvl(p_tp_id,0) + 1;

      insert
        into BARS.DPU_TYPES
           ( TYPE_ID, TYPE_NAME, TYPE_CODE, SORT_ORD, FL_ACTIVE, SHABLON )
      values
           ( p_tp_id, p_tp_nm, p_tp_code, p_sort_ordr, p_active, p_tpl_id );

      bars_audit.trace( '%s: created new deposit type #%s.', title, to_char(p_tp_id) );

      p_err_msg := null;

    exception
      when OTHERS then
        p_err_msg := sqlerrm;
        bars_audit.error( title || sqlerrm || dbms_utility.format_error_backtrace() );
    end;

    bars_audit.trace( '%s: Exit.', title );

  end ADD_TYPE;

  --
  --
  --
  procedure UPD_TYPE
  ( p_tp_id        in     dpu_vidd.type_id%type
  , p_tp_nm        in     dpu_types.type_name%type
  , p_tp_code      in     dpu_types.type_code%type
  , p_sort_ordr    in     dpu_types.sort_ord%type
  , p_active       in     dpu_types.fl_active%type
  , p_tpl_id       in     dpu_types.shablon%type
  , p_err_msg      out    varchar2
  ) is
  /**
  <b>UPD_TYPE</b> - Внесення змін у параметри типу депозиту ЮО
  %param p_tp_id     - Ід. типу
  %param p_tp_nm     - Назва типу
  %param p_tp_code   - Код типу
  %param p_sort_ordr - Порядковий номер для сортування
  %param p_active    - Ознака активності
  %param p_tpl_id    - Ід. шаблону договору

  %version 1.0
  %usage   зміна параметрів типу депозиту ЮО
  */
    title       constant  varchar2(60) := 'dpu_utils.upd_type';
  begin

    bars_audit.trace( '%s: Entry with ( tp_id=%s, tp_nm=%s, tp_code=%s, sort_ordr=%s, active=%s, tpl_id=%s ).'
                    , title, to_char(p_tp_id), p_tp_nm, p_tp_code, to_char(p_sort_ordr), to_char(p_active), p_tpl_id );

    case
      when ( p_tp_id Is Null )
      then bars_error.raise_nerror( 'DPU', 'GENERAL_ERROR_CODE', 'Не вказано ідентифікатор типу депозту!' );
      when ( p_tp_nm Is Null )
      then bars_error.raise_nerror( 'DPU', 'GENERAL_ERROR_CODE', 'Не вказано назву типу депозту!' );
      when ( p_active Not In ( 0, 1 ) )
      then bars_error.raise_nerror( 'DPU', 'GENERAL_ERROR_CODE', 'Вказано некоректне значення для ознаки активності типу!' );
      else null;
    end case;

    begin

      update BARS.DPU_TYPES
         set TYPE_NAME = p_tp_nm
           , TYPE_CODE = p_tp_code
           , SORT_ORD  = p_sort_ordr
           , FL_ACTIVE = p_active
           , SHABLON   = p_tpl_id
       where TYPE_ID = p_tp_id;


      if (sql%rowcount > 0)
      then
        bars_audit.trace( '%s: changed parameters deposit type #%s.', title, to_char(p_tp_id) );
      end if;

    exception
      when OTHERS then
        p_err_msg := sqlerrm;
        bars_audit.error( title || sqlerrm || dbms_utility.format_error_backtrace() );
    end;

    bars_audit.trace( '%s: Exit.', title );

  end UPD_TYPE;

  --
  --
  --
  procedure DEL_TYPE
  ( p_tp_id        in     dpu_vidd.vidd%type
  , p_err_msg      out    varchar2
  ) is
  /**
  <b>DEL_TYPE</b> - Видалення типу депозиту
  %param p_tp_id - Ід. типу депозиту

  %version 1.0
  %usage   Видалення типу депозиту з довідника
  */
    title       constant  varchar2(60) := 'dpu_utils.del_type';
    l_qty                 number(3);
  begin

    bars_audit.trace( '%s: Entry with ( tp_id=%s ).', title, to_char(p_tp_id) );

    select count(VIDD)
      into l_qty
      from BARS.DPU_VIDD
     where TYPE_ID = p_tp_id;

    if ( l_qty = 0 )
    then

      begin

        delete BARS.DPU_TYPES
         where TYPE_ID = p_tp_id;

        bars_audit.trace( '%s: deleted deposit type #%s.', title, to_char(p_tp_id) );

      exception
        when OTHERS then
          p_err_msg := sqlerrm;
          bars_audit.error( title || sqlerrm || dbms_utility.format_error_backtrace() );
      end;

    else
      p_err_msg := 'Видалення неможливе (існує '||to_char(l_qty)||
                   ' видів депозиту які належать типу '||to_char(p_tp_id)||')!';
    end if;

    bars_audit.trace( '%s: Exit.', title );

  end DEL_TYPE;

  --
  --
  --
  procedure DEL_TYPE
  ( p_tp_id        in     dpu_vidd.vidd%type
  ) is
    l_err_msg             varchar2(2000);
    l_pos                 number(4);
  begin

    DEL_TYPE( p_tp_id   => p_tp_id
            , p_err_msg => l_err_msg
            );

    if ( l_err_msg Is Null )
    then
      null;
    else

      l_pos := inStr( l_err_msg, 'ORA-' );

      if ( l_pos > 0 )
      then
        l_pos     := l_pos + 9;
        l_err_msg := SubStr( l_err_msg, l_pos, inStr( l_err_msg, chr(10) ) - l_pos );
      else
        null;
      end if;

      bars_error.raise_nerror( 'DPU', 'GENERAL_ERROR_CODE', l_err_msg );

    end if;

  end DEL_TYPE;


BEGIN
  NULL;
END DPU_UTILS;
/

show errors;

grant EXECUTE on DPU_UTILS to BARS_ACCESS_DEFROLE;
grant EXECUTE on DPU_UTILS to DPT;
grant EXECUTE on DPU_UTILS to DPT_ADMIN;
