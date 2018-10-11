PROMPT package/dm_import.sql
CREATE OR REPLACE PACKAGE DM_IMPORT
is
    --
    -- Наполнение витрин для файловых выгрузок в CRM
    --
    g_header_version  constant varchar2(64)  := 'version 5.0.6 04/09/2018 '; -- CUSTOMERS_PLT optimiz.+2620БПК.+gcif
    g_header_defs     constant varchar2(512) := '';

    C_FULLIMP         constant period_type.id%TYPE  := 'MONTH';
    C_INCRIMP         constant period_type.id%TYPE  := 'DAY';

    --
    -- header_version - возвращает версию заголовка пакета
    --
    function header_version return varchar2;

    --
    -- body_version - возвращает версию тела пакета
    --
    function body_version return varchar2;

    --
    -- log statistic info
    --
    procedure log_stat_event(p_id_session number default null,
                             p_start_time date default null,
                             p_stop_time  date default null,
                             p_obj        varchar2 default null,
                             p_perid      number default null,
                             p_rows_ok    number default null,
                             p_rows_err   number default null,
                             p_status     varchar2 default null,
                             p_id         in out number);

    --
    -- import full (month)
    --
    procedure imp_month (p_dat in date default sysdate);

    --
    -- import incremental (day)
    --
    procedure imp_day (p_dat in date default sysdate);

    --
    -- import customers
    --
    procedure customers_imp(p_dat        in date default trunc(sysdate),
                            p_periodtype in varchar2 default C_FULLIMP,
                            p_rows       out number,
                            p_rows_err   out number,
                            p_state      out varchar2);
    --
    -- import credits statistic data monthly
    --
    procedure credits_stat_imp(p_dat        in date default trunc(sysdate),
                               p_periodtype in varchar2 default C_FULLIMP,
                               p_rows       out number,
                               p_rows_err   out number,
                               p_state      out varchar2);

    --
    -- import credits dynamic
    --
    procedure credits_dyn_imp(p_dat        in date default trunc(sysdate),
                              p_periodtype in varchar2 default C_FULLIMP,
                              p_rows       out number,
                              p_rows_err   out number,
                              p_state      out varchar2);

    --
    -- import deposits
    --
    procedure deposits_imp(p_dat        in date default trunc(sysdate),
                           p_periodtype in varchar2 default C_FULLIMP,
                           p_rows       out number,
                           p_rows_err   out number,
                           p_state      out varchar2);

    --
    -- Выгрузка клиентских счетов
    --
    procedure accounts_imp (p_dat        in  date     default trunc(sysdate), 
                            p_periodtype in  varchar2 default C_FULLIMP, 
                            p_rows       out number, 
                            p_rows_err   out number, 
                            p_state      out varchar2);

    --
    -- import bpk
    --
    procedure bpk_imp(p_dat        in date default trunc(sysdate),
                      p_periodtype in varchar2 default C_FULLIMP,
                      p_rows       out number,
                      p_rows_err   out number,
                      p_state      out varchar2);

    --
    -- import corps customers
    --
    procedure custur_imp(p_dat        in date default trunc(sysdate),
                         p_periodtype in varchar2 default C_FULLIMP,
                         p_rows       out number,
                         p_rows_err   out number,
                         p_state      out varchar2);

    --
    -- import corps rel customers
    --
    procedure custur_rel_imp(p_dat        in date default trunc(sysdate),
                         p_periodtype in varchar2 default C_FULLIMP,
                         p_rows       out number,
                         p_rows_err   out number,
                         p_state      out varchar2);

    --
    -- import FO segmentation
    --
    procedure cust_segm_imp(p_dat        in date default trunc(sysdate),
                         p_periodtype in varchar2 default C_FULLIMP,
                         p_rows       out number,
                         p_rows_err   out number,
                         p_state      out varchar2);

    procedure customer_segment_changes(
        p_date_from in date,
        p_date_to in date,
        p_rows_count out integer,
        p_errors_count out integer,
        p_state_code out varchar2);

    procedure customer_segment_snapshot(
        p_snapshot_value_date in date,
        p_rows_count out integer,
        p_errors_count out integer,
        p_state_code out varchar2);

    --
    -- import assurances
    --
    procedure assurance_imp(p_dat        in date default trunc(sysdate),
                         p_periodtype in varchar2 default C_INCRIMP,
                         p_rows       out number,
                         p_rows_err   out number,
                         p_state      out varchar2);

    --
    -- import zalogov
    --
    procedure zastava_imp(p_dat        in date default trunc(sysdate),
                          p_periodtype in varchar2 default C_FULLIMP,
                          p_rows       out number,
                          p_rows_err   out number,
                          p_state      out varchar2);

    procedure deposits_plt_imp (p_dat in date default trunc(sysdate),
                                p_periodtype in varchar2 default C_FULLIMP,
                                p_rows out number,
                                p_rows_err out number,
                                p_state out varchar2);

    procedure bpk_plt_imp(p_dat        in date default trunc(sysdate),
                          p_periodtype in varchar2 default C_FULLIMP,
                          p_rows       out number,
                          p_rows_err   out number,
                          p_state      out varchar2);

    procedure customers_plt_imp(p_dat    in date default trunc(sysdate),
                            p_periodtype in varchar2 default C_FULLIMP,
                            p_rows       out number,
                            p_rows_err   out number,
                            p_state      out varchar2);

    --
    -- выгрузка поручителей / залогодателей по кредитам
    --     МФО;
    --     Вид кредиту;
    --     Номер кредиту;
    --     РНК;
    --     Тип зв’язку (застоводавець/поручитель);
    --     Сума.
    --
    procedure credits_zal_imp ( p_dat in date default trunc(sysdate),
                                p_periodtype in varchar2 default C_FULLIMP,
                                p_rows out number,
                                p_rows_err out number,
                                p_state out varchar2);
    --
    -- clear old data
    --
    procedure clear_data (p_dat in date default trunc(sysdate));

    --
    -- get period id
    --
    function get_period_id (p_period_type period_type.id%type, p_period_date date)
        return periods.id%type;


    FUNCTION add38phone (p_phone IN VARCHAR2, p_kf in varchar2)
       RETURN VARCHAR2;

    ---
    --- Запуск выгрузки по объекту в контексте указанного МФО (для параллели).
    ---
    procedure imp_run_by_mfo(p_mfo          in     varchar2,
                             p_obj_proc     in     varchar2,
                             p_dat          in     date,
                             p_periodtype   in     varchar2,
                             p_id_event     in     number
                             );
    --
    -- import data
    --
    procedure imp_run(p_dat        in date default sysdate,
                      p_periodtype in varchar2 default C_FULLIMP);

    --
    -- выгрузка для кредитов по финансовых операциях
    --
    procedure credits_oper_imp (p_dat    in date default trunc(sysdate),
                                p_periodtype in varchar2 default C_FULLIMP,
                                p_rows       out number,
                                p_rows_err   out number,
                                p_state      out varchar2);
    --
    -- выгрузка для депозитов по финансовых операциях
    --
    procedure deposits_oper_imp (p_dat    in date default trunc(sysdate),
                                 p_periodtype in varchar2 default C_FULLIMP,
                                 p_rows       out number,
                                 p_rows_err   out number,
                                 p_state      out varchar2);
    --
    -- выгрузка для кредитов по финансовых операциях
    --
    procedure credits_oper_imp (p_dat    in date default trunc(sysdate),
                                p_periodtype in varchar2 default C_FULLIMP,
                                p_rows       out number,
                                p_rows_err   out number,
                                p_state      out varchar2);
    --
    -- выгрузка для депозитов по финансовых операциях
    --
    procedure deposits_oper_imp (p_dat    in date default trunc(sysdate),
                                 p_periodtype in varchar2 default C_FULLIMP,
                                 p_rows       out number,
                                 p_rows_err   out number,
                                 p_state      out varchar2);
end;
/
Show errors;

CREATE OR REPLACE PACKAGE BODY DM_IMPORT
 is


    g_body_version constant varchar2(64) := 'Version 5.0.6 04/09/2018';--+2620БПК.+gcif
    g_body_defs    constant varchar2(512) := null;
    G_TRACE        constant varchar2(20) := 'dm_import.';
    -- BARS_INTGR - integration (changenumber by object / KF)
    -- DIY - parallel
    -- partitioned: segments, credits_stat, custur, customers_plt
    c_cntdays constant number := 40; -- кількість днів, за які зберігаємо дані у вітринах

    /** header_version -  */
    function header_version return varchar2 is
    begin
      return 'Package header dm_import ' || g_header_version || chr(10) ||
             'AWK definition: ' || chr(10) || g_header_defs;
    end header_version;

    /** body_version -  */
    function body_version return varchar2 is
    begin
      return 'Package body dm_import ' || g_body_version ||  chr(10) ||
             'AWK definition: ' || chr(10) || g_body_defs;
    end body_version;

    --
    -- Очищаем существующую партицию или добавляем новую
    --
    procedure add_partition(p_table_name in varchar2, p_period_id in periods.id%type)
    is
    partition_exist exception;
    pragma exception_init (partition_exist, -14312);
    begin
          execute immediate 'alter table '||p_table_name||' add partition P'||p_period_id||' values ('||p_period_id||')';
    exception
    when partition_exist then
        bars_audit.info('Вивантаження даних для CRM - така секція в вітрині вже існує '|| p_table_name ||' за період   з ідентифікатором {' || p_period_id || '}');
    end add_partition;

    --
    -- Очищаем субпартицию по ИД периода и КФ - или вызываем add_partition() Предполагаем, что субпартиции созданы автоматически в соответствии с шаблоном
    --
    procedure truncate_kf_subpartition(p_table_name in varchar2, p_period_id in periods.id%type, p_kf in varchar2)
        is
        subpartition_doesnt_exist exception;
        pragma exception_init(subpartition_doesnt_exist, -14251);
    begin
        -- устанавливаем время ожидания ddl_lock, чтобы не получить -54 при одновременном truncate
        execute immediate 'alter session set ddl_lock_timeout=60';
        execute immediate 'alter table '||p_table_name||' truncate subpartition '||'P'||p_period_id||'_KF_'||p_kf; -- e.g. P995_KF_300465
    exception
        when subpartition_doesnt_exist then
            add_partition(p_table_name, p_period_id);
    end truncate_kf_subpartition;

    --
    -- Удаляем записи из errlog-таблицы за указанный период
    --
    procedure clear_err_log(p_table_name in varchar2, p_per_id in periods.id%type)
        is
        l_err_log_name varchar2(64) := 'ERR$_'||p_table_name;
        l_ourmfo varchar2(6) := sys_context('bars_context', 'user_mfo');
    begin
        execute immediate 'delete from '||l_err_log_name||' where per_id = :p_per_id and kf = nvl(:l_ourmfo, kf)' using p_per_id, l_ourmfo;
        commit;
    end clear_err_log;

    --
    -- Логгирование статистики
    -- Не автономная транзакция, чтобы не было проблем с параллелью
    --
    procedure log_stat_event(p_id_session number default null,
                             p_start_time date default null,
                             p_stop_time  date default null,
                             p_obj        varchar2 default null,
                             p_perid      number default null,
                             p_rows_ok    number default null,
                             p_rows_err   number default null,
                             p_status     varchar2 default null,
                             p_id         in out number) is
    begin
      if (p_id is null) then
        insert into bars_dm.dm_stats
          (id,
           id_session,
           obj,
           start_time,
           stop_time,
           per_id,
           rows_ok,
           rows_err,
           status)
        values
          (s_stats.nextval,
           p_id_session,
           p_obj,
           p_start_time,
           p_stop_time,
           p_perid,
           p_rows_ok,
           p_rows_err,
           p_status)
        returning id into p_id;
      else
        update dm_stats
           set stop_time = nvl(p_stop_time, stop_time),
               rows_ok   = nvl(p_rows_ok, rows_ok),
               rows_err  = nvl(p_rows_err, rows_err),
               status    = nvl(p_status, status)
         where id = p_id;
      end if;

      commit;
    end log_stat_event;
    
    --
    -- Уведомление интеграционной схемы (BARS_INTGR) о завершении полной выгрузки по объекту
    -- запись в лог, при успешной выгрузке - увеличение changenumber, переключение витрины на bars_dm
    --
    procedure notify_intgr (p_periodtype   in period_type.id%type,
                            p_objects_list in bars.varchar2_list,
                            p_start_time   in date,
                            p_rows_ok      in number,
                            p_rows_err     in number,
                            p_status       in bars_dm.dm_stats.status%type)
    is
    begin
        if p_periodtype = C_FULLIMP then
            for obj in (select column_value as obj_name from table(p_objects_list))
            loop
                if p_status = 'SUCCESS' then
                    bars_intgr.xrm_import.increment_object_changenumber(obj.obj_name);
                    bars_intgr.xrm_import.set_import_mode(p_mode        => bars_intgr.xrm_import.G_IMPORT_MODE_FULL, 
                                                          p_object_name => obj.obj_name);
                end if;
                bars_intgr.xrm_import.log_stat_details(p_changenumber => case when p_status = 'SUCCESS' then bars_intgr.xrm_import.get_object_changenumber(obj.obj_name) end,
                                                       p_start_time   => p_start_time,
                                                       p_stop_time    => sysdate,
                                                       p_object_name  => obj.obj_name,
                                                       p_rows_ok      => p_rows_ok,
                                                       p_rows_err     => p_rows_err,
                                                       p_status       => p_status);
            end loop;
        else return;
        end if;
    end notify_intgr;

    --
    -- import month (full)
    --
    procedure imp_month (p_dat in date default sysdate)
    is
    begin
        imp_run(p_dat => p_dat, p_periodtype => C_FULLIMP);
    end imp_month;

    --
    -- import day (incremental)
    --
    procedure imp_day (p_dat in date default sysdate)
    is
    begin
        imp_run(p_dat => p_dat, p_periodtype => C_INCRIMP);
    end imp_day;

        --
        -- Выгрузка клиентов-физлиц
        --
        procedure customers_imp(p_dat        in date default trunc(sysdate),
                                p_periodtype in varchar2 default C_FULLIMP,
                                p_rows       out number,
                                p_rows_err   out number,
                                p_state      out varchar2)
        is
            l_trace  varchar2(500) := G_TRACE || 'customers_imp: ';
            l_per_id periods.id%type;
            l_row    customers%rowtype;
            l_errmsg varchar2(512);

            c        sys_refcursor;

            q_str          varchar2(32000);
            q_str_inc_pre  varchar2(4000) :=
                     'with  c1 as ((select distinct rnk from bars.customer_update cu where cu.custtype = 3 and cu.chgdate between trunc(:p_dat) and trunc(:p_dat)+0.99999)
                       union
                     (select distinct rnk from bars.customerw_update cwu where cwu.chgdate between trunc(:p_dat) and trunc(:p_dat)+0.99999)
                       union
                     (select distinct rnk from bars.person_update pu where  pu.chgdate between trunc(:p_dat) and trunc(:p_dat)+0.99999))
                     ';

            q_str_main  varchar2(32000) :=
                       ' select
                           s_customers.nextval,
                           c.kf,
                           c.rnk,
                           c.branch,
                           bars.fio(c.nmk,1) as last_name,
                           bars.fio(c.nmk,2) as first_name,
                           bars.fio(c.nmk,3) as middle_name,
                           substr(trim(gr),1,30) as gr,
                           p.bday,
                           p.passp,
                           p.ser as ser,
                           p.numdoc as numdoc,
                           p.pdate  as pdate,
                           p.organ,
                           c.okpo  as okpo,
                           dm_import.add38phone(substr(mpno,1,20), c.kf) as mpno,
                           dm_import.add38phone(p.teld, c.kf) teld,
                           dm_import.add38phone(p.telw, c.kf) telw,
                           substr(email,1,30) as email,
                           au_contry,
                           au_domain,
                           au_region,
                           au_locality,
                           au_adress,
                           au_zip,
                           ap_contry,
                           ap_domain,
                           ap_region,
                           ap_locality,
                           ap_adress,
                           ap_zip,
                           decode(c.date_off, null, ''1'', ''0'') as cust_status,
                           (select max(rnkto) from bars.rnk2nls r2 where r2.rnkfrom=c.rnk and decode(c.date_off, null, ''1'', ''0'') = ''0'') as cust_active,
                           decode(c.codcagent,5,1,2) rezident,
                           decode(to_number(nvl(c.sed, 0)),91,2,34,2,1) as subject_class,
                           case
                                when length(trim(cigpo))=1
                                    and regexp_replace(trim(cigpo), ''\D'') = trim(cigpo)
                                    and trim(cigpo) != ''0''
                                 then trim(cigpo)
                                when trim(cigpo) is null
                                 then ''''
                                else ''9''
                           end as emp_status,
                           decode(to_number(p.sex),1,1,2,2,0) as sex,
                           (select prinsiderlv1 from bars.prinsider where prinsider = nvl(c.prinsider,2)) as insider,
                           decode(vipk,''1'',1,0) vipk,
                           decode(vipk,''1'', (select max(fio_manager) from bars.vip_flags where rnk=c.rnk),'''') fio_man,
                           decode(vipk,''1'', (select max(phone_manager) from bars.vip_flags where rnk=c.rnk),'''') phone_man,
                           date_on,
                           date_off,
                           p.eddr_id,
                           p.actual_date
                      from bars.customer c, bars.person p,
                             ( select rnk,
                                    "''1''_C1" au_contry,
                                    "''1''_C2" au_zip,
                                    "''1''_C3" au_domain,
                                    "''1''_C4" au_region,
                                    "''1''_C5" au_locality,
                                    "''1''_C6" au_adress,
                                    "''1''_C7" au_terid,
                                    "''2''_C1" af_contry,
                                    "''2''_C2" af_zip,
                                    "''2''_C3" af_domain,
                                    "''2''_C4" af_region,
                                    "''2''_C5" af_locality,
                                    "''2''_C6" af_adress,
                                    "''2''_C7" af_terid,
                                    "''3''_C1" ap_contry,
                                    "''3''_C2" ap_zip,
                                    "''3''_C3" ap_domain,
                                    "''3''_C4" ap_region,
                                    "''3''_C5" ap_locality,
                                    "''3''_C6" ap_adress,
                                    "''3''_C7" ap_terid
                               from (select rnk, type_id, country,zip, domain, region, locality, address, territory_id from bars.customer_address)
                              pivot (max(country) c1, max(zip) c2, max(domain) c3, max(region) c4, max(locality) c5, max(address) c6, max(territory_id) c7
                                       for type_id in (''1'', ''2'', ''3'')
                                    )
                              ) a,
                                 (select rnk,
                                        "''CIGPO''_CC"  as cigpo,
                                        "''EMAIL''_CC"  as email,
                                        "''GR   ''_CC"  as gr,
                                        "''MPNO ''_CC"  as mpno,
                                        "''VIP_K''_CC"  as vipk
                                   from (select w.rnk, tag, value
                                           from bars.customerw w
                                          where tag in (''CIGPO'',''EMAIL'',''GR   '',''MPNO '',''VIP_K'')
                                        )
                                 pivot ( max(value) cc for tag in (''CIGPO'', ''EMAIL'', ''GR   '', ''MPNO '', ''VIP_K''))
                                 ) w
                                 ';

            q_str_inc_suf  varchar2(4000) :=
                  ' ,c1
                  where c.custtype=3
                    and c.rnk=p.rnk
                    and c.rnk = a.rnk(+)
                    and c.rnk = w.rnk(+)
                    and C.RNK = c1.rnk';

            q_str_full_suf  varchar2(4000) :=
                  ' where c.custtype=3
                    and c.rnk=p.rnk
                    and c.rnk = a.rnk(+)
                    and c.rnk = w.rnk(+)';

            l_rows     pls_integer := 0;
            l_rows_err pls_integer := 0;

        begin
            bars.bars_audit.info(l_trace||' start');
            -- get period id
            l_per_id := get_period_id (p_periodtype, p_dat);
            --
            if l_per_id is null then
                return;
            end if;

            delete from customers where per_id=l_per_id;
            --
            if (p_periodtype = C_INCRIMP) then
                q_str := q_str_inc_pre || q_str_main || q_str_inc_suf;
                open c for q_str using p_dat, p_dat, p_dat, p_dat, p_dat, p_dat;
            else
                q_str := q_str_main || q_str_full_suf;
                open c for q_str ;
            end if;

            l_row.per_id := l_per_id;
    --        l_row.mfo := bars.f_ourmfo_g;

            loop
              begin
                fetch c into l_row.id, l_row.kf, l_row.rnk,l_row.branch,l_row.last_name,l_row.first_name,l_row.middle_name,
                l_row.gr,l_row.bday,l_row.passp,l_row.ser,l_row.numdoc,l_row.pdate,l_row.organ,l_row.okpo,
                l_row.telm,l_row.teld,l_row.telw,l_row.email,
                l_row.adr_fact_country, l_row.adr_fact_domain, l_row.adr_fact_region, l_row.adr_fact_loc, l_row.adr_fact_adr, l_row.adr_fact_zip,
                l_row.adr_post_country, l_row.adr_post_domain, l_row.adr_post_region, l_row.adr_post_loc, l_row.adr_post_adr, l_row.adr_post_zip,
                l_row.cust_status, l_row.cust_active, l_row.rezident, l_row.subject_class, l_row.emp_status, l_row.sex, l_row.insider,
                l_row.vipk, l_row.vip_fio_manager, l_row.vip_phone_manager,
                l_row.date_on, l_row.date_off, l_row.eddr_id, l_row.actual_date;

                exit when c%notfound;

                insert into customers values l_row;

                l_rows:=l_rows + 1;
                dbms_application_info.set_client_info(l_trace||to_char(l_rows)|| ' processed');

              exception
                when others then
                  l_errmsg :=substr(l_trace||' Error: '
                                           ||dbms_utility.format_error_stack()||chr(10)
                                           ||dbms_utility.format_error_backtrace()
                                           , 1, 512);
                  bars.bars_audit.error(l_errmsg);
                  l_rows_err:=l_rows_err + 1;
              end;
            end loop;

            close c;

            p_rows := l_rows;
            p_rows_err := l_rows_err;
            p_state := 'SUCCESS';

            bars.bars_audit.info(l_trace||' customers count='||l_rows||', errors='||l_rows_err);
            bars.bars_audit.info(l_trace||' finish');
        end customers_imp;

    --
    -- Выгрузка "статических" данных по кредитам
    -- Всегда выгружаем полный объем
    --
    procedure credits_stat_imp(p_dat        in date default trunc(sysdate),
                               p_periodtype in varchar2 default C_FULLIMP,
                               p_rows       out number,
                               p_rows_err   out number,
                               p_state      out varchar2)
    is
        l_trace  varchar2(500) := G_TRACE || 'credits_stat_imp: ';
        l_per_id periods.id%type;

        l_rows     pls_integer := 0;
        l_rows_err pls_integer := 0;
        l_ourmfo   varchar2(6) := sys_context('bars_context', 'user_mfo');

        l_insert_target varchar2(64);
    begin
        bars.bars_audit.info(l_trace||' start');
      -- отримання id періоду
        l_per_id := get_period_id (p_periodtype, p_dat);

        if l_per_id is null then
            return;
        end if;

        truncate_kf_subpartition('CREDITS_STAT', l_per_id, l_ourmfo);
        -- стандартні кредитні договора

        -- удаляем данные о предыдущих ошибках периода
        clear_err_log(p_table_name => 'CREDITS_STAT', p_per_id => l_per_id);

        -- e.g. partition (P1164) or subpartition (P1164_KF_300465)
        l_insert_target := case when l_ourmfo is null then 'partition (P'||l_per_id||')' else 'subpartition (P'||l_per_id||'_KF_'||l_ourmfo||')' end;
        bars.bars_audit.info(l_trace||' insert target: '||l_insert_target);

        begin
            execute immediate q'[
            insert /*+ APPEND */ into credits_stat ]'||l_insert_target||q'[
            (
                                     id,
                                     per_id,
                                     nd,
                                     rnk,
                                     kf,
                                     branch,
                                     okpo,
                                     cc_id,
                                     sdate,
                                     wdate,
                                     wdate_fact,
                                     vidd,
                                     prod,
                                     prod_clas,
                                     pawn,
                                     sdog,
                                     term,
                                     kv,
                                     pog_plan,
                                     pog_fact,
                                     borg_sy,
                                     borgproc_sy,
                                     bpk_nls,
                                     intrate,
                                     ptn_name,
                                     ptn_okpo,
                                     ptn_mother_name,
                                     open_date_bal22,
                                     es000,
                                     es003,
                                     vidd_custtype,
                                     ob22,
                                     nms,
									 nls)
            select  s_credits.nextval,
                    :l_per_id,
                    ccd.nd,
                    ccd.rnk,
                    ccd.kf,
                    ccd.branch,
                    c.okpo,
                    ccd.cc_id,
                    ccd.sdate,
                    ccd.wdate,
                    SQ8.wdate_fact,
                    ccd.vidd,
                    null as prod,
                    substr(ccd.prod,1,6) as prod_class,
                    (select case R.cnt when 0 then null when 1 then R.s031 else '40' end as pawn
                     from
                        (
                            select z.kf, ad.nd, max(p.s031) as s031, count(*) as cnt --into l_t_row.pawn
                            from bars.cc_add ad, bars.accounts a, bars.cc_accp z, bars.cc_pawn p, bars.pawn_acc pa
                            where z.accs = ad.ACCS  and z.acc = a.acc and a.nbs like '9%' and (a.dazs is null or a.dazs>sysdate) and a.daos <= sysdate
                            and a.acc = pa.acc and pa.pawn = p.pawn
                            group by z.kf, ad.nd
                        ) R
                     where r.kf = ccd.kf and r.nd = ccd.nd
                     ) as pawn,
                    ccd.sdog,
                    trunc(MONTHS_BETWEEN(ccd.WDATE+1, ccd.sdate)) as term,
                    (select kv from bars.cc_add where nd = ccd.nd and kf = ccd.kf) as kv,
                    (select nvl(sum(sumg)/100,0)
                     from bars.cc_lim g
                     where nd = ccd.nd
                       and (g.nd, g.fdat) = (select nd, max(fdat)
                                             from bars.cc_lim
                                            where nd = g.nd
                                              and fdat >= trunc(trunc(:p_dat,'MONTH')-1,'MONTH') and fdat <= trunc(:p_dat,'MONTH')-1
                                              and sumg > 0
                                            group by nd)) as pog_plan,
                    (select nvl(sum(sa.kos),0)/100
                      from bars.saldoa sa, bars.accounts a, bars.nd_acc na
                     where a.acc = sa.acc and a.acc=na.ACC and na.nd=ccd.nd and na.kf = ccd.kf and a.TIP='LIM' and sa.dos - sa.kos < 0
                       and fdat >= trunc(trunc(:p_dat,'MONTH')-1,'MONTH') and fdat<= trunc(:p_dat,'MONTH')-1) as pog_fact, -- фактично погашено за минулий місяць
                     abs(nvl(BRG.borg, 0)) as borg_sy,
                     abs(nvl(BRG.borgproc, 0)) as borgproc_sy,
                     null as bpk_nls,
                     acrn.fprocn(SQ8.acc8, 0, :p_dat) as intrate,
                     PARTNER.ptn_name,
                     PARTNER.ptn_okpo,
                     PARTNER.ptn_mother_name,
                     (select max(daos)
                         from bars.accounts a, bars.nd_acc n
                        where n.nd = ccd.nd and n.kf = ccd.kf and a.acc = n.acc and a.kf = n.kf and a.nbs in ('2202', '2203', '2232', '2233')) as open_date_bal22,
                     (select n.TXT
                         from nd_txt n
                         where n.nd = ccd.nd
                         and tag = 'ES000'
                         and kf = ccd.kf) as ES000,
                     (select n.TXT
                         from nd_txt n
                         where n.nd = ccd.nd
                         and tag = 'ES003'
                         and kf = ccd.kf) as ES003,
                      case when (C.ise in ('14100', '14200', '14101','14201') and C.sed ='91') then 2 else ccv.custtype end as vidd_custtype, -- #COBUSUPABS-6567
                      main_acc.ob22,
                      main_acc.nms,
					  a_acc.nls
            from bars.cc_deal ccd
            join bars.customer c on ccd.rnk = c.rnk
            join bars.cc_vidd ccv on ccd.vidd = ccv.vidd
            left join
            (select na.kf, na.nd, a.acc as acc8, dazs as wdate_fact
             from bars.accounts a, bars.nd_acc na
             where a.acc = na.acc and a.tip='LIM') SQ8 on SQ8.nd = ccd.nd and SQ8.kf = ccd.kf
            left join
            (
                       -- Сума залишку заборгованості на початок року, грн
                       -- беремо з місяних снапів
                       -- по снапах дані на 01.12.2014 це вхідний залишок на 01.01.2015
            select na.kf, na.nd,
                    sum(case when a.tip in ('SS ','SP ','SL ')   then b.ost end)/100 as borg,
                    sum(case when a.tip in ('SN ', 'SPN', 'SLN') then b.ost end)/100 as borgproc
               from bars.nd_acc na, bars.accounts a, bars.agg_monbals b
              where na.ACC=a.acc
                and a.tip in ('SS ','SP ','SL ', 'SN ', 'SPN', 'SLN')
                and a.acc=b.acc
                and b.kf = a.kf
                and b.fdat = trunc(trunc(:p_dat,'YEAR')-1,'MONTH')
                and (a.dazs is null or a.dazs>trunc(:p_dat,'YEAR'))
                and a.daos <= trunc(:p_dat,'YEAR')
                group by na.kf, na.nd) BRG on ccd.nd = BRG.nd and ccd.kf = BRG.kf
            left join
            (select d.nd, d.kf, d2.txt,
                    case when d2.txt = 'Taк' then nvl(w.ptn_name, w.name) else '' end as ptn_name,
                    case when d2.txt = 'Taк' then w.ptn_okpo else '' end as ptn_okpo,
                    case when d2.txt = 'Taк' then (select nvl(m.ptn_name, m.name) from bars.wcs_partners_all m where m.id = w.id_mather) else '' end ptn_mother_name
             from bars.nd_txt d
             left join bars.nd_txt d2 on d.nd = d2.nd and d.kf = d2.kf and d2.tag = 'PARTN'
             join bars.wcs_partners_all w on to_number(regexp_replace(trim(d.txt), '\D')) = w.id
              where d.tag = 'PAR_N'
                and regexp_replace(trim(d.txt), '\D') = trim(d.txt)) PARTNER on ccd.nd = PARTNER.nd and ccd.kf = PARTNER.KF
            left join
            (select na.kf,
                    na.nd,
                    max(ob22) keep (dense_rank first order by dazs desc nulls first) as ob22,
                    max(nms) keep (dense_rank first order by dazs desc nulls first) as nms
             from bars.nd_acc na
             join bars.accounts a on na.kf = a.kf and na.acc = a.acc
             where a.tip = 'SS'
             group by na.kf, na.nd
            ) MAIN_ACC on ccd.kf = main_acc.kf and ccd.nd = main_acc.nd
			left join bars.nd_acc nd_acc on ccd.nd = nd_acc.nd and nd_acc.kf = ccd.kf
            left join bars.accounts a_acc on a_acc.acc = nd_acc.acc  and a_acc.kf = nd_acc.kf
            where c.CUSTTYPE in (2, 3) and ccd.vidd in (1, 2, 3, 11, 12, 13)
			  and (a_acc.tip = 'SG ' or a_acc.nbs in ('2620','2625','2600'))
            -- and not (C.ise in ('14100', '14200', '14101','14201') and C.sed ='91') --фильтруем ФОПов -- 20.03.2017  COBUSUPABS-5659
            LOG ERRORS into ERR$_CREDITS_STAT ('STANDARD') reject limit unlimited
            ]' using l_per_id, p_dat, p_dat, p_dat, p_dat, p_dat, p_dat, p_dat, p_dat;

            l_rows := l_rows + sql%rowcount;
            commit;
        exception
            when others then
                rollback;
                raise;
        end;
        bars.bars_audit.info(l_trace||' std crd finished');
        ------------------------
        -- договора по БПК
        ------------------------

        begin
            execute immediate q'[
            insert /*+ APPEND */ into credits_stat ]'||l_insert_target||q'[
            (
                                     id,
                                     per_id,
                                     nd,
                                     rnk,
                                     kf,
                                     branch,
                                     okpo,
                                     cc_id,
                                     sdate,
                                     wdate,
                                     wdate_fact,
                                     vidd,
                                     prod,
                                     prod_clas,
                                     pawn,
                                     sdog,
                                     term,
                                     kv,
                                     pog_plan,
                                     pog_fact,
                                     borg_sy,
                                     borgproc_sy,
                                     bpk_nls,
                                     intrate,
                                     ptn_name,
                                     ptn_okpo,
                                     ptn_mother_name,
                                     open_date_bal22,
                                     es000,
                                     es003,
                                     vidd_custtype,
                                     ob22,
                                     nms,
									 nls)
            with cur as
            (select ba.nd, ba.acc_pk, ba.acc_ovr, ba.acc_2208, c.rnk, a.branch, a.kf, a.nbs, a.ob22, a.daos, a.dazs, a.kv, c.okpo,
                                           aa.lim, aa.nls nls2625, aa.daos daos2625, AA.DAZS dazs2625, a.ostc ost_ovr, A9129.OSTC ost_9129, a9129.daos daos9129,
                                           (select sp.nkd from bars.specparam sp where sp.acc=ba.acc_ovr) nkd
            from bars.bpk_all_accounts ba, bars.accounts a, bars.customer c, bars.accounts aa, bars.accounts a9129
            where ba.acc_ovr is not null
                and ba.acc_ovr = a.acc
                and a.nbs in ('2202','2203')
                and a.rnk      = c.rnk
                and c.custtype in (2, 3)
            --  and not (C.ise in ('14100', '14200', '14101','14201') and C.sed ='91') --фильтруем ФОПов -- 20.03.2017  COBUSUPABS-5659
                and ba.acc_pk = aa.acc and aa.nbs in ('2625', '2620')
                and ba.acc_9129 = a9129.acc(+)

            union all
            select ba.nd, ba.acc_pk, ba.acc_ovr, ba.acc_2208, c.rnk, a9129.branch, a9129.kf, a9129.nbs, a9129.ob22, a9129.daos, a9129.dazs, a9129.kv, c.okpo,
                                           a.lim, a.nls nls2625, a.daos daos2625, A.DAZS dazs2625, 0 ost_ovr, A9129.OSTC ost_9129, a9129.daos daos9129,
                                           (select sp.nkd from bars.specparam sp where sp.acc=ba.acc_9129) nkd
            from bars.bpk_all_accounts ba, bars.accounts a, bars.customer c, bars.accounts a9129
            where ba.acc_ovr is null
                and ba.acc_pk = a.acc and a.nbs in ('2625', '2620')
                and a.rnk = c.rnk
                and c.custtype in (2, 3) -- and nvl(trim(c.sed),'00')<>'91'
            --  and not (C.ise in ('14100', '14200', '14101','14201') and C.sed ='91') --фильтруем ФОПов -- 20.03.2017  COBUSUPABS-5659
                and ba.acc_9129 is not null
                and ba.acc_9129 = a9129.acc
            )
            select
            s_credits.nextval,
            :l_per_id,
            cur.nd,
            rnk,
            cur.kf,
            branch,
            okpo,
            nkd as cc_id,
            daos9129 as sdate,
            add_months(cur.daos2625, BPK_AW_TERM.bpk_term) as wdate,
            dazs as wdate_fact,
            19 as vidd,
            null as prod,
            cur.nbs || cur.ob22 as prod_class,
            null as pawn,
            abs(cur.ost_ovr + nvl(cur.ost_9129,0))/100 as sdog,
            trunc(MONTHS_BETWEEN(add_months(cur.daos2625, BPK_AW_TERM.bpk_term), daos9129)) as term,
            cur.kv,
            0 as pog_plan,
            (select nvl(sum(sa.kos),0)/100
               from bars.saldoa sa
              where sa.acc = cur.acc_ovr
                and fdat >= trunc(trunc(:p_dat,'MONTH')-1,'MONTH') and fdat<= trunc(:p_dat,'MONTH')-1) as pog_fact,
            (select nvl(abs(sum(b.ost))/100, 0)
              from bars.agg_monbals b
             where b.acc=cur.acc_ovr
               and b.fdat = trunc(trunc(:p_dat,'YEAR')-1,'MONTH')
               and b.kf = cur.kf) as borg_sy,
            (select nvl(abs(sum(b.ost))/100, 0)
               from bars.agg_monbals b
              where b.acc=cur.acc_2208
                and b.fdat = trunc(trunc(:p_dat,'YEAR')-1,'MONTH')
                and b.kf = cur.kf) as borgproc_sy,
            nls2625 as bpk_nls,
            acrn.fprocn(cur.acc_ovr, 0, :p_dat) as intrate,
            null as ptn_name,
            null as ptn_okpo,
            null as ptn_mother_name,
            case when cur.acc_ovr is not null then cur.daos end as open_date_bal22,
            (select n.TXT
             from nd_txt n
             where n.nd = cur.nd
             and tag = 'ES000'
             and kf = cur.kf) as ES000,
            (select n.TXT
             from nd_txt n
             where n.nd = cur.nd
             and tag = 'ES000'
             and kf = cur.kf) as ES003,
            3 as vidd_custtype, -- хардкод по #COBUSUPABS-6567
            main_acc.ob22,
            main_acc.nms,
			main_nls.nls
            from cur
            left join
            (select acc, nvl(to_number(aw.value), 0) as bpk_term
               from bars.accountsw aw
              where aw.tag = 'PK_TERM') BPK_AW_TERM on cur.acc_pk = BPK_AW_TERM.acc
            left join
            (select na.kf,
                    na.nd,
                    max(ob22) keep (dense_rank first order by dazs desc nulls first) as ob22,
                    max(nms) keep (dense_rank first order by dazs desc nulls first) as nms
             from bars.nd_acc na
             join bars.accounts a on na.kf = a.kf and na.acc = a.acc
             where a.tip = 'SS'
             group by na.kf, na.nd
            ) MAIN_ACC on cur.kf = main_acc.kf and cur.nd = main_acc.nd
			 left join 
            (select na.kf,
                    na.nd,
                    a.nls
             from bars.nd_acc na
             join bars.accounts a on na.kf = a.kf and na.acc = a.acc
             where (a.tip = 'SG ' or a.nbs in ('2620','2625','2600'))
            ) MAIN_NLS on cur.kf = main_nls.kf and cur.nd = main_nls.nd 
            LOG ERRORS into ERR$_CREDITS_STAT ('BPK') reject limit unlimited
            ]' using l_per_id, p_dat, p_dat, p_dat, p_dat, p_dat;

            l_rows := l_rows + sql%rowcount;
            commit;
        exception
            when others then
                rollback;
                raise;
        end;
        bars.bars_audit.info(l_trace||' bpk crd finished');

        -- считаем кол-во ошибочных строк
        select count(*) into l_rows_err from ERR$_CREDITS_STAT where PER_ID = l_per_id;

        p_rows := l_rows;
        p_rows_err := l_rows_err;
        p_state := 'SUCCESS';

        bars.bars_audit.info(l_trace||' finish');

    end credits_stat_imp;

    --
    -- Выгрузка "динамических" данных по кредитам
    -- Всегда выгружается полный объем
    --
    procedure credits_dyn_imp (p_dat in date default trunc(sysdate), p_periodtype in varchar2 default C_FULLIMP, p_rows out number, p_rows_err out number, p_state out varchar2)
    is
        l_trace       varchar2(500) := G_TRACE || 'credits_dyn_imp: ';
        l_per_id      periods.id%type;
        l_row         credits_dyn%rowtype;
        l_a8_kv       pls_integer :=0;
        l_acc_ss      int;

        l_errmsg varchar2(512);

        l_rows     pls_integer := 0;
        l_rows_err pls_integer := 0;

        l_cnt     pls_integer := 0;

        type   saldoa_tt is table of bars.saldoa%rowtype;

    begin
        bars.bars_audit.info(l_trace||' start');
        -- отримання id періоду
        l_per_id := get_period_id (p_periodtype, p_dat);

        if l_per_id is null then
            return;
        end if;

        delete from credits_dyn where per_id=l_per_id;
        --

        for cur in ( select ccd.cc_id, ccd.nd, ccd.RNK, ccd.kf, ccd.BRANCH, c.OKPO,
                            ccd.sdate, ccd.WDATE, ccd.vidd, ccd.prod, ccd.sdog, ccd.sos, ccd.kat23, ccv.custtype as vidd_custtype
                       from bars.cc_deal ccd
                            join bars.customer c on ccd.rnk = c.rnk
                            join bars.cc_vidd ccv on ccd.vidd = ccv.vidd
                      where c.CUSTTYPE in (2, 3) and ccd.vidd in (1, 2, 3, 11, 12, 13)
    --                    and not (C.ise in ('14100', '14200', '14101','14201') and C.sed ='91') --фильтруем ФОПов -- 20.03.2017  COBUSUPABS-5659
                   )
        loop
          begin
            l_row.id     := s_credits.nextval;
            l_row.per_id := l_per_id;
            -- id договору
            l_row.nd     := cur.nd;
            l_row.rnk    := cur.rnk;
            l_row.kf     := cur.kf;
            -- Номер договору
            l_row.cc_id  := cur.cc_id;
            l_row.sdate  := cur.sdate;
            l_row.branch := cur.branch;
            -- Тип договору (11,12,13)
            l_row.vidd := cur.vidd;
            -- Тип клиєнта по виду договора
            l_row.VIDD_CUSTTYPE := cur.VIDD_CUSTTYPE;
            -- Стан договору
            l_row.sos := cur.sos;
            -- наступний платіж
            select min(fdat)
              into l_row.next_pay
              from bars.cc_lim g
             where nd = cur.nd
               and (g.nd, g.fdat) = (select nd, min(fdat)
                                     from bars.cc_lim
                                    where nd = g.nd
                                      and fdat > p_dat
                                      and sumg > 0
                                    group by nd);

            -- Сума наступного платежу
            begin
                select g.sumo/100, g.sumg/100, (g.sumo - g.sumg-nvl(g.sumk,0))/100
                  into l_row.next_pay_all, l_row.next_pay_tilo, l_row.next_pay_proc
                  from bars.cc_lim g
                 where nd = cur.nd
                   and (g.nd, g.fdat) = (select nd, min(fdat)
                                         from bars.cc_lim
                                        where nd = g.nd
                                          and fdat > p_dat
                                          and sumg > 0
                                        group by nd);
              exception when no_data_found then
                 l_row.next_pay_all := 0;
                 l_row.next_pay_tilo := 0;
                 l_row.next_pay_proc := 0;
             end;

            -- На стадії розгляду питання про визнання проблемним
            -- Звідки брати?
            l_row.probl_rozgl := null;

            -- Дата визнання кредиту проблемним
            select min(to_date(nt.TXT,'dd/mm/yyyy'))
              into l_row.probl_date
              from bars.nd_txt nt
             where tag='NOHOP' and nt.ND=cur.nd and nt.kf = cur.kf;

            -- Визнання кредиту проблемним
            select decode(l_row.probl_date, null, 0, 1) into l_row.probl from dual;

            -- Дата останньої реструктуризації кредита
            select max(fdat) into l_row.cred_datechange from bars.cck_restr where nd = cur.nd;

            l_row.cred_change := null;
            -- Зміна умов кредитування (реструктизацыя)
            -- тип останьої реструктизації
            -- для одного договору за звітну дату може бути кілька реструктизацій
            -- !уточнити. поки беремо мах
            if (l_row.cred_datechange is not null) then
              select decode(max(vid_restr),1,1,2,1,3,1,13,1,7,2,3)
               into l_row.cred_change
               from bars.cck_restr where nd = cur.nd and fdat = l_row.cred_datechange;
            end if;

            -- Валюта договору (кредиту)
            select kv into l_a8_kv
              from bars.accounts a, bars.nd_acc na
             where a.acc = na.acc and na.ND=cur.nd and a.tip='LIM';

            -- Сума заборгованості за кредитом у валюті кредиту
            select sum(bars.gl.p_ncurval(l_a8_kv,
                                           bars.gl.p_icurval(a.kv, bars.fost(a.acc, p_dat), p_dat),
                                           p_dat))/100
              into l_row.borg
              from bars.accounts a, bars.nd_acc na
             where a.acc = na.acc and na.ND=cur.nd
               and a.tip in ('SS ', 'SP ', 'SL ', 'SN ', 'SPN', 'SLN', 'SK0', 'SK9', 'SN8');

            l_row.borg := abs(nvl(l_row.borg, 0));


            -- Сума заборгованості за тілом кредиту у валюті кредиту
            select sum(bars.gl.p_ncurval(l_a8_kv,
                                           bars.gl.p_icurval(a.kv, bars.fost(a.acc, p_dat), p_dat),
                                           p_dat))/100
              into l_row.borg_tilo
              from bars.accounts a, bars.nd_acc na
             where a.acc = na.acc and na.ND=cur.nd
               and a.tip = 'SS ';

            l_row.borg_tilo := abs(nvl(l_row.borg_tilo, 0));


            -- Сума заборгованості за відсотками у валюті кредиту
            select sum(bars.gl.p_ncurval(l_a8_kv,
                                           bars.gl.p_icurval(a.kv, bars.fost(a.acc, p_dat), p_dat),
                                           p_dat))/100
              into l_row.borg_proc
              from bars.accounts a, bars.nd_acc na
             where a.acc = na.acc and na.ND=cur.nd
               and a.tip = 'SN ';

            l_row.borg_proc := abs(nvl(l_row.borg_proc, 0));


            -- Сума простроченої заборгованості за тілом у валюті кредиту
            select sum(bars.gl.p_ncurval(l_a8_kv,
                                           bars.gl.p_icurval(a.kv, bars.fost(a.acc, p_dat), p_dat),
                                           p_dat))/100
              into l_row.borg_tilo_prosr
              from bars.accounts a, bars.nd_acc na
             where a.acc = na.acc and na.ND=cur.nd
               and a.tip in ('SP ');

            l_row.borg_tilo_prosr := abs(nvl(l_row.borg_tilo_prosr, 0));

            l_row.prosrcnt := 0;
            l_row.prosr1   := null;

            bars.bars_audit.trace('%s nd=%s tilo_prosroc= %s',l_trace, to_char(cur.nd), to_char(l_row.borg_tilo_prosr));

            if l_row.borg_tilo_prosr > 0 then
                -- Кількість прострочених платежів (уточнение: если на данный момент кредит в
                -- просрочке, то сколько на данный момент у него подряд просроченых !непогашених платежей)
                -- по тілу
                declare
                  l_first_delay_date date;
                  l_first_delay_done number;
                  l_skos             bars.saldoa.kos%type;

                  l_rs               saldoa_tt;

                  l_f    boolean := true;
                begin
                  -- ищем ближайший день выхода на просрочку
                  select max(s.fdat)
                    into l_first_delay_date
                    from bars.saldoa s
                   where fdat <= p_dat
                     and ((ostf = 0 and dos > 0)                 -- стандартна прострочка
                       or (ostf < 0 and dos = 0 and kos = 0))    -- заімпортовані з Скарбу
                     and s.acc in (select n.acc
                                     from bars.nd_acc n, bars.accounts a
                                    where a.acc = n.acc
                                      and A.DAZS is null
                                      and n.nd = cur.nd
                                      and a.tip ='SP ');

                  bars.bars_audit.trace('%s nd=%s date_prostr= %s',l_trace, to_char(cur.nd),to_char(l_first_delay_date,'dd.mm.yyyy'));
                  -- если нашли то смотрим была ли загашена просрочка по тілу
                  -- тіло гаситься останім
                  if (l_first_delay_date is null) then
                    l_row.prosrcnt := 0;
                    l_row.prosr1   := null;
                  else
                    select count(1)
                      into l_first_delay_done
                      from bars.saldoa s
                     where s.fdat >= l_first_delay_date
                       and (s.ostf - s.dos + s.kos) >= 0
                       -- Виключаємо випадок, коли в saldoa запис з ostf=0,dos=0,kos=0
                       and not (ostf = 0 and dos =0 and kos =0)
                       and s.acc in (select n.acc
                                       from bars.nd_acc n, bars.accounts a
                                      where a.acc = n.acc
                                        and A.DAZS is null
                                        and n.nd = cur.nd
                                        and a.tip = 'SP ');

                    bars.bars_audit.trace('%s nd=%s prosroc_done= %s',l_trace, to_char(cur.nd), to_char(l_first_delay_done));
                    -- если погасил то ОК
                    -- если нет, то считаем кол-во записей где были обороты
                    -- по выносу на простроску
                    if (l_first_delay_done > 0) then
                      l_row.prosrcnt := 0;
                      l_row.prosr1   := null;
                    else
                      -- сума кред.оборотів (погашень)
                      select nvl(sum(s.kos), 0)
                        into l_skos
                        from bars.saldoa s
                       where s.kos > 0
                         and s.fdat between l_first_delay_date and p_dat
                         and s.acc in (select n.acc
                                         from bars.nd_acc n, bars.accounts a
                                        where a.acc = n.acc
                                          and A.DAZS is null
                                          and n.nd = cur.nd
                                          and a.tip = 'SP ');

                      bars.bars_audit.trace('%s nd=%s skos= %s',l_trace, to_char(cur.nd), to_char(l_skos));
                      -- retrive acc.array
                      -- масив виносу на прострочку
                      select --+ leading(n a s)
                        * bulk collect into l_rs
                        from bars.saldoa s
                       where s.fdat between l_first_delay_date and p_dat
                         and ((s.dos >= 0 and s.kos = 0) or (s.dos > 0 and s.kos > 0))
                         and s.acc in (select n.acc
                                         from bars.nd_acc n, bars.accounts a
                                        where a.acc = n.acc
                                          and A.DAZS is null
                                          and n.nd = cur.nd
                                          and a.tip = 'SP ')
                       order by fdat;

                      bars.bars_audit.trace('%s nd=%s dos_count= %s',l_trace, to_char(cur.nd), to_char(l_rs.count));

                      for i in 1 .. l_rs.count loop
                        -- якщо КД імпортований з скарбу
                        -- на рах. прострочки негативний залишок з нульовими оборотами
                        if i=1 and l_rs(i).ostf<0 and l_rs(i).dos = 0 and l_rs(i).kos = 0 then
                           l_skos := l_skos + l_rs(i).ostf;
                        end if;

                        bars.bars_audit.trace('%s i=%s skos= %s dos=%s',l_trace, to_char(i), to_char(l_skos),to_char(l_rs(i).dos));

                        l_skos := l_skos - l_rs(i).dos;
                        if l_skos < 0 and l_f then
                          l_row.prosr1 := l_rs(i).fdat;
                          l_f  := false;
                        end if;

                        if l_skos < 0 then
                            if l_rs(i).dos >= 0 then l_row.prosrcnt := l_row.prosrcnt + 1; end if;
                        end if;

                      end loop;

                    end if;
                  end if;
                end;

            end if;


            -- Сума простроченої заборгованості за процентами у валюті кредиту
            select sum(bars.gl.p_ncurval(l_a8_kv,
                                           bars.gl.p_icurval(a.kv, bars.fost(a.acc, p_dat), p_dat),
                                           p_dat))/100
              into l_row.borg_proc_prosr
              from bars.accounts a, bars.nd_acc na
             where a.acc = na.acc and na.ND=cur.nd
               and a.tip in ('SPN');

            l_row.borg_proc_prosr := abs(nvl(l_row.borg_proc_prosr, 0));

            l_row.prosrcnt_proc := 0;
            l_row.prosr2   := null;

            if l_row.borg_proc_prosr > 0 then
                -- Кількість прострочених платежів (уточнение: если на данный момент кредит в
                -- просрочке, то сколько на данный момент у него подряд просроченых !непогашених платежей)
                -- по відсотках
                declare
                  l_first_delay_date date;
                  l_first_delay_done number;
                  l_skos             bars.saldoa.kos%type;

                  l_rs               saldoa_tt;

                  l_f    boolean := true;
                begin
                  -- ищем ближайший день выхода на просрочку
                  select max(s.fdat)
                    into l_first_delay_date
                    from bars.saldoa s
                   where fdat <= p_dat
                     and ((ostf = 0 and dos > 0)                 -- стандартна прострочка
                       or (ostf < 0 and dos = 0 and kos = 0))    -- заімпортовані з Скарбу
                     and s.acc in (select n.acc
                                     from bars.nd_acc n, bars.accounts a
                                    where a.acc = n.acc
                                      and A.DAZS is null
                                      and n.nd = cur.nd
                                      and a.tip ='SPN');

                  -- если нашли то смотрим была ли загашена просрочка
                  if (l_first_delay_date is null) then
                    l_row.prosrcnt_proc := 0;
                    l_row.prosr2   := null;
                  else
                    select count(1)
                      into l_first_delay_done
                      from bars.saldoa s
                     where s.fdat >= l_first_delay_date
                       and (s.ostf - s.dos + s.kos) >= 0
                       -- Виключаємо випадок, коли в saldoa запис з ostf=0,dos=0,kos=0
                       and not (ostf = 0 and dos =0 and kos =0)
                       and s.acc in (select n.acc
                                       from bars.nd_acc n, bars.accounts a
                                      where a.acc = n.acc
                                        and A.DAZS is null
                                        and n.nd = cur.nd
                                        and a.tip = 'SPN');

                    -- если погасил то ОК
                    -- если нет, то считаем кол-во записей где были обороты
                    -- по выносу на простроску
                    if (l_first_delay_done > 0) then
                      l_row.prosrcnt_proc := 0;
                      l_row.prosr2   := null;
                    else
                      -- сума кред.оборотів (погашень)
                      select nvl(sum(s.kos), 0)
                        into l_skos
                        from bars.saldoa s
                       where s.kos > 0
                         and s.fdat between l_first_delay_date and p_dat
                         and s.acc in (select n.acc
                                         from bars.nd_acc n, bars.accounts a
                                        where a.acc = n.acc
                                          and A.DAZS is null
                                          and n.nd = cur.nd
                                          and a.tip = 'SPN');

                      -- retrive acc.array
                      -- масив виносу на прострочку
                      select --+ leading(n a s)
                        * bulk collect into l_rs
                        from bars.saldoa s
                       where s.fdat between l_first_delay_date and p_dat
                         and ((s.dos >= 0 and s.kos = 0) or (s.dos > 0 and s.kos > 0))
                         and s.acc in (select n.acc
                                         from bars.nd_acc n, bars.accounts a
                                        where a.acc = n.acc
                                          and A.DAZS is null
                                          and n.nd = cur.nd
                                          and a.tip = 'SPN')
                       order by fdat;

                      for i in 1 .. l_rs.count loop
                        -- якщо КД імпортований з скарбу
                        -- на рах. прострочки негативний залишок з нульовими оборотами
                        if i=1 and l_rs(i).ostf<0 and l_rs(i).dos = 0 and l_rs(i).kos = 0 then
                           l_skos := l_skos + l_rs(i).ostf;
                        end if;

                        l_skos := l_skos - l_rs(i).dos;
                        if l_skos < 0 and l_f then
                          l_row.prosr2 := l_rs(i).fdat;
                          l_f  := false;
                        end if;
                        if l_skos < 0 then
                            if l_rs(i).dos >= 0 then l_row.prosrcnt_proc := l_row.prosrcnt_proc + 1; end if;
                        end if;
                      end loop;

                    end if;
                  end if;
                end;

            end if;


            -- Кількість фактів виходу на просрочку (saldoa.ostf=0)
            select count(distinct fdat)
              into l_row.prosr_fact_cnt
              from bars.saldoa s
             where fdat <= p_dat
               and ((ostf = 0 and dos > 0)                  -- стандартна прострочка
                  or (ostf < 0 and dos = 0 and kos = 0))    -- заімпортовані з Скарбу
               and s.acc in (select n.acc
                               from bars.nd_acc n, bars.accounts a
                              where a.acc = n.acc
                                and n.nd = cur.nd
                                and a.tip = 'SP ');


            -- Сума і дата останього платежу
            l_row.last_pay_date := null;
            l_row.last_pay_suma := 0;

            -- Сума простроченої заборгованості за кредитом у валюті кредиту
            select sum(bars.gl.p_ncurval(l_a8_kv,
                                           bars.gl.p_icurval(a.kv, bars.fost(a.acc, p_dat), p_dat),
                                           p_dat))/100
              into l_row.borg_prosr
              from bars.accounts a, bars.nd_acc na
             where a.acc = na.acc and na.ND=cur.nd
               and a.tip in ('SP ', 'SPN', 'SK9');

            l_row.borg_prosr := abs(nvl(l_row.borg_prosr, 0));

            -- Сума пені у валюті кредиту
            select sum(bars.gl.p_ncurval(l_a8_kv,
                                           bars.gl.p_icurval(a.kv, bars.fost(a.acc, p_dat), p_dat),
                                           p_dat))/100
              into l_row.penja
              from bars.accounts a, bars.nd_acc na
             where a.acc = na.acc and na.ND=cur.nd
               and a.tip in ('SN8');

            l_row.penja := abs(nvl(l_row.penja, 0));


            -- Сума нарахованих штрафів у валюті кредиту
            -- ! штрафи в АБС відсутні
            l_row.shtraf := null;

           -- Сума повернутих коштів по кредиту в поточному році, грн
           select nvl(sum(sa.kos)/100,0)
             into l_row.pay_tilo
             from bars.saldoa sa, bars.accounts a, bars.nd_acc na
            where a.acc = sa.acc and a.acc=na.ACC and na.nd=cur.nd and a.TIP='LIM' and sa.dos - sa.kos < 0
              and fdat >= trunc(p_dat,'YEAR');

           -- Сума повернутих процентів за кредитом в поточному році, грн
           select greatest(bars.gl.p_ncurval(l_a8_kv,nvl(sum(bars.gl.p_Icurval(a.kv,s.kos,p_dat)),0),p_dat)- --1
                    bars.gl.p_Ncurval(l_a8_kv,nvl(sum(bars.gl.p_Icurval(a.kv,decode(a.tip,'SPN',s.DOS,0),p_dat)),0),p_dat)- -- 2
                    bars.gl.p_Ncurval(l_a8_kv,nvl(sum(bars.gl.p_Icurval(a.kv,decode(a.tip,'SPN',s.KOS,0),p_dat)),0),p_dat) --
                  ,0)/100
             into l_row.pay_proc
             from bars.accounts a, bars.nd_acc n, bars.saldoa s
            where n.nd=cur.ND and n.acc=a.acc and a.tip in ('SN ','SPN')
              and s.acc=a.acc
              and s.fdat>= trunc(sysdate,'YEAR');

            -- Категорія ризику
            -- Беремо з cc_deal.kat23
            l_row.cat_ryzyk := cur.kat23;

            -- ? Дата віднесення кредиту на рахунок простроченої заборгованості
            -- ? Що мається на увазі
            -- в першому наближенні беремо Дата виникнення першої прострочки за кредитом
            select  min(fdat) into l_row.cred_to_prosr
              from bars.saldoa
             where ostf = 0
                   and fdat <= p_dat and dos > 0
               and acc in (select n.acc from bars.nd_acc n, bars.accounts a
                            where a.acc = n.acc and n.nd = cur.nd and a.tip = 'SP ');

            --104 Дата перенесення заборгованості на позабалансові рахунки
            begin
              select min(fdat)
                into l_row.borg_to_pbal
                from bars.saldoa
               where ostf = 0 and fdat <= p_dat and dos > 0
                 and acc in (select n.acc from bars.nd_acc n, bars.accounts a
                                where a.acc = n.acc and n.nd = cur.ND and a.tip = 'S9N');
            exception when no_data_found then l_row.borg_to_pbal := null;
            end;

            -- acc SS (судн.счет)
            begin
              select accs into l_acc_ss
                from bars.cc_add ca, bars.accounts a
               where ca.nd = cur.nd and ca.adds = 0 and ca.accs = a.acc and (a.dazs is null or a.dazs > p_dat) and a.daos <= p_dat;
            exception when no_data_found then l_acc_ss := null;
            end;

            -- ? Вартість прийнятого майна на баланс, грн
            -- беремо з P_INV_CC_FL
            -- 35 Сума забезпечення на звітну дату у вигляді поруки (34 код згідно класифікатора НБУ KL_S031), грн
            --
            l_row.vart_majna := 0;

            begin
             select nvl(sum(bars.fost(a.acc, p_dat))/100,0)
               into l_row.vart_majna
               from bars.accounts a, bars.cc_accp z, bars.cc_pawn c, bars.pawn_acc pa
              where z.accs = l_acc_ss and z.acc = a.acc and a.nbs = '9031' and a.tip='ZAL'
                and (a.dazs is null or a.dazs>p_dat) and a.daos <= p_dat
                and a.acc = pa.acc and pa.pawn = c.pawn and c.s031 = 34;
            exception when no_data_found then l_row.vart_majna := 0;
            end;

            -- Чинна дата погашення у звязку з останіми змінами
            -- Планируемая дата погашения с учетом последней пролонгации - если пролонгации не было - пусто
            --
            begin
              select mdate into l_row.pog_finish
               from bars.cc_prol p
              where npp = ( select max(npp)
                              from bars.cc_prol
                             where fdat <= p_dat and npp>0
                                   and nd = p.nd
                                   and mdate is not null
                                  group by nd)
                    and nd = cur.nd and rownum = 1;
            exception when no_data_found then l_row.pog_finish := null;
            end;

            -- Сума простроченої заборгованості за тілом у гривні
            select sum(bars.gl.p_icurval(a.kv, bars.fost(a.acc, p_dat), p_dat))/100
              into l_row.tilo_prosr_uah
              from bars.accounts a, bars.nd_acc na
             where a.acc = na.acc and na.ND=cur.nd
               and a.tip in ('SP ');

            l_row.tilo_prosr_uah := abs(nvl(l_row.tilo_prosr_uah, 0));


            -- Сума простроченої заборгованості за процентами у гривні
            select sum(bars.gl.p_icurval(a.kv, bars.fost(a.acc, p_dat), p_dat))/100
              into l_row.proc_prosr_uah
              from bars.accounts a, bars.nd_acc na
             where a.acc = na.acc and na.ND=cur.nd
               and a.tip in ('SPN');

            l_row.proc_prosr_uah := abs(nvl(l_row.proc_prosr_uah, 0));

            -- Сума заборгованості за тілом у гривні
            select sum(bars.gl.p_icurval(a.kv, bars.fost(a.acc, p_dat), p_dat))/100
              into l_row.borg_tilo_uah
              from bars.accounts a, bars.nd_acc na
             where a.acc = na.acc and na.ND=cur.nd
               and a.tip in ('SS ');

            l_row.borg_tilo_uah := abs(nvl(l_row.borg_tilo_uah, 0));


            -- Сума  заборгованості за процентами у гривні
            select sum(bars.gl.p_icurval(a.kv, bars.fost(a.acc, p_dat), p_dat))/100
              into l_row.borg_proc_uah
              from bars.accounts a, bars.nd_acc na
             where a.acc = na.acc and na.ND=cur.nd
               and a.tip in ('SN ');

            l_row.borg_proc_uah := abs(nvl(l_row.borg_proc_uah, 0));

            -- Перераховано кошти від ВДВС (наразі алгоритм відсутній)
            l_row.pay_vdvs := null;

            -- Сума комісії за кредитом у валюті кредиту
            select sum(bars.gl.p_ncurval(l_a8_kv,
                                           bars.gl.p_icurval(a.kv, bars.fost(a.acc, p_dat), p_dat),
                                           p_dat))/100
              into l_row.amount_commission
              from bars.accounts a, bars.nd_acc na
             where a.acc = na.acc and na.ND=cur.nd
               and a.tip = 'SK0';

            l_row.amount_commission := abs(nvl(l_row.amount_commission, 0));

            -- Сума простроченої комісії за кредитом у валюті кредиту
            select sum(bars.gl.p_ncurval(l_a8_kv,
                                           bars.gl.p_icurval(a.kv, bars.fost(a.acc, p_dat), p_dat),
                                           p_dat))/100
              into l_row.amount_prosr_commission
              from bars.accounts a, bars.nd_acc na
             where a.acc = na.acc and na.ND=cur.nd
               and a.tip = 'SK9';

            l_row.amount_prosr_commission := abs(nvl(l_row.amount_prosr_commission, 0));


                   -- Статус КД в реєстрі
           begin
             select n.TXT into l_row.ES000
             from nd_txt n
             where n.nd = cur.nd
             and tag = 'ES000'
             and kf = cur.kf;
           exception
             when no_data_found then null;
           end;
           -- дата отримання відшкодування
           begin
             select n.TXT into l_row.ES003
             from nd_txt n
             where n.nd = cur.nd
             and tag = 'ES003'
             and kf = cur.kf;
           exception
             when no_data_found then null;
           end;

            ----------------------------

            insert into credits_dyn values l_row;

            l_rows := l_rows + 1;

            dbms_application_info.set_client_info(l_trace||to_char(l_cnt)|| ' processed (std credits)');
            l_cnt:=l_cnt+1;

          exception
            when others then
              l_rows_err := l_rows_err + 1;
              l_errmsg :=substr(l_trace||' Error: nd='|| cur.nd || ', '
                                       ||dbms_utility.format_error_stack()||chr(10)
                                       ||dbms_utility.format_error_backtrace()
                                       , 1, 512);
              bars.bars_audit.error(l_errmsg);
          end;

         end loop;

         bars.bars_audit.info(l_trace||' std crd count='||l_cnt);

        ------------------------
        -- договора по БПК
        ------------------------
        l_cnt := 0;
        for cur in (    select ba.nd, ba.acc_pk, ba.acc_ovr, ba.acc_2208, c.rnk, a.branch, a.kf, a.nbs, a.ob22, a.daos, a.dazs, a.kv, c.okpo,
                               aa.lim, aa.nls nls2625, aa.daos daos2625, AA.DAZS dazs2625, a.ostc ost_ovr, A9129.OSTC ost_9129, BA.ACC_2207, BA.ACC_2209, a9129.daos daos9129,
                               (select sp.nkd from bars.specparam sp where sp.acc=ba.acc_ovr) nkd
                        from bars.bpk_all_accounts ba, bars.accounts a, bars.customer c, bars.accounts aa, bars.accounts a9129
                        where ba.acc_ovr is not null
                            and ba.acc_ovr = a.acc
                            and a.nbs in ('2202','2203')
                            and a.rnk      = c.rnk
                            and c.custtype in (2, 3) -- and nvl(trim(c.sed),'00')<>'91'
    --                        and not (C.ise in ('14100', '14200', '14101','14201') and C.sed ='91') --фильтруем ФОПов -- 20.03.2017  COBUSUPABS-5659
                            and ba.acc_pk = aa.acc and aa.nbs in ('2625','2620')
                            and ba.acc_9129 = a9129.acc(+)
                            union
                        select ba.nd, ba.acc_pk, ba.acc_ovr, ba.acc_2208, c.rnk, a9129.branch, a9129.kf, a9129.nbs, a9129.ob22, a9129.daos, a9129.dazs, a9129.kv, c.okpo,
                               a.lim, a.nls nls2625, a.daos daos2625, A.DAZS dazs2625, 0 ost_ovr, A9129.OSTC ost_9129,  BA.ACC_2207, BA.ACC_2209, a9129.daos daos9129,
                               (select sp.nkd from bars.specparam sp where sp.acc=ba.acc_9129) nkd
                        from bars.bpk_all_accounts ba, bars.accounts a, bars.customer c, bars.accounts a9129
                        where ba.acc_ovr is null
                            and ba.acc_pk = a.acc and a.nbs in ('2625','2620')
                            and a.rnk = c.rnk
                            and c.custtype in (2, 3) -- and nvl(trim(c.sed),'00')<>'91'
    --                        and not (C.ise in ('14100', '14200', '14101','14201') and C.sed ='91') --фильтруем ФОПов -- 20.03.2017  COBUSUPABS-5659
                            and ba.acc_9129 is not null
                            and ba.acc_9129 = a9129.acc
                   )
         loop
           begin

            l_row.id := s_credits.nextval;
            l_row.per_id := l_per_id;

            -- id договору
            l_row.nd  := cur.nd;

            -- РНК
            l_row.rnk := cur.rnk;

            -- Регіональне управління
            l_row.kf  := cur.kf;

            -- Номер договору
            l_row.cc_id := cur.nkd;

            -- Відділення, за яким закріплено повернення кредиту
            l_row.branch := cur.branch;

            -- Стан договору
            l_row.sos := null;

            -- тип договору (для БПК = 19)
            l_row.vidd  := 19;

            -- Тип клиєнта по виду договора
            l_row.vidd_custtype := 3; -- #COBUSUPABS-6567

            -- Дата укладання договору
            -- беремо, як дату відкриття 9129
            -- !до 15.12.2015 брали дату відкриття рах.овердрафту
            l_row.sdate := cur.daos9129;

            -- Обнуляємо
            -- Дата наступного платежу
            l_row.next_pay := null;
            -- Сума наступного платежу
            l_row.next_pay_all  := 0;
            l_row.next_pay_tilo := 0;
            l_row.next_pay_proc := 0;
            -- На стадії розгляду питання про визнання проблемним
            l_row.probl_rozgl := null;
    /*        -- Дата визнання кредиту проблемним
            l_row.probl_date := null;
            -- Визнання кредиту проблемним
            l_row.probl := 0;*/
               -- Дата визнання кредиту проблемним
            select min(to_date(t.value,'dd/mm/yyyy'))
              into l_row.probl_date
              from bars.accountsw t
             where t.tag='DATEOFKK' and t.acc=cur.acc_pk;--cur.acc_ovr;

            -- Визнання кредиту проблемним
            select decode(l_row.probl_date, null, 0, 1) into l_row.probl from dual;



            -- Дата останньої реструктуризації кредита
            l_row.cred_datechange := null;
            l_row.cred_change := null;

            -- Сума заборгованості за тілом кредиту у валюті кредиту
            select sum(ostc/100) into l_row.borg_tilo
              from bars.accounts a
             where a.acc=cur.acc_ovr;

            l_row.borg_tilo := abs(nvl(l_row.borg_tilo, 0));

            -- Сума заборгованості за відсотками у валюті кредиту
              select sum(ostc/100) into l_row.borg_proc
                from bars.accounts a
               where a.acc = cur.acc_2208;

            l_row.borg_proc := abs(nvl(l_row.borg_proc, 0));

            -- Сума заборгованості за кредитом у валюті кредиту
            l_row.borg := l_row.borg_tilo + l_row.borg_proc;


            -- Кількість фактів виходу на просрочку (saldoa.ostf=0)
            l_row.prosr_fact_cnt := 0;

            -- todo реалізувати!
            l_row.last_pay_date := null;
            l_row.last_pay_suma := 0;

            -- Сума простроченої заборгованості за тілом у валюті кредиту
            select sum(ostc/100) into l_row.borg_tilo_prosr
              from bars.accounts a
             where a.acc=cur.acc_2207;

            -- Дата першого простроченого непогашеного платежу по тілу
            l_row.prosr1 := null;
            -- Кількість прострочених платежів
            l_row.prosrcnt := 0;

           l_row.borg_tilo_prosr := abs(nvl(l_row.borg_tilo_prosr, 0));

           -- todo переписати
            if l_row.borg_tilo_prosr > 0 then
                -- Кількість прострочених платежів (уточнение: если на данный момент кредит в
                -- просрочке, то сколько на данный момент у него подряд просроченых !непогашених платежей)
                -- по тілу
                declare
                  l_first_delay_date date;
                  l_first_delay_done number;
                  l_skos             bars.saldoa.kos%type;

                  l_rs               saldoa_tt;

                  l_f    boolean := true;
                begin
                  -- ищем ближайший день выхода на просрочку
                  select max(s.fdat)
                    into l_first_delay_date
                    from bars.saldoa s
                   where fdat <= p_dat
                     and (ostf = 0 and dos > 0)                 -- стандартна прострочка
                     and s.acc = cur.acc_2207;

                  bars.bars_audit.trace('%s bpk nd=%s date_prostr= %s',l_trace, to_char(cur.nd),to_char(l_first_delay_date,'dd.mm.yyyy'));
                  if (l_first_delay_date is null) then
                    l_row.prosrcnt := 0;
                    l_row.prosr1   := null;
                  else
                    select count(1)
                      into l_first_delay_done
                      from bars.saldoa s
                     where s.fdat >= l_first_delay_date
                       and (s.ostf - s.dos + s.kos) >= 0
                       -- Виключаємо випадок, коли в saldoa запис з ostf=0,dos=0,kos=0
                       and not (ostf = 0 and dos =0 and kos =0)
                       and s.acc = cur.acc_2207;

                    bars.bars_audit.trace('%s bpk nd=%s prosroc_done= %s',l_trace, to_char(cur.nd), to_char(l_first_delay_done));
                    -- если погасил то ОК
                    -- если нет, то считаем кол-во записей где были обороты
                    -- по выносу на простроску
                    if (l_first_delay_done > 0) then
                      l_row.prosrcnt := 0;
                      l_row.prosr1   := null;
                    else
                      -- сума кред.оборотів (погашень)
                      select nvl(sum(s.kos), 0)
                        into l_skos
                        from bars.saldoa s
                       where s.kos > 0
                         and s.fdat between l_first_delay_date and p_dat
                         and s.acc = cur.acc_2207;

                      bars.bars_audit.trace('%s bpk nd=%s skos= %s',l_trace, to_char(cur.nd), to_char(l_skos));
                      -- retrive acc.array
                      -- масив виносу на прострочку
                      select * bulk collect
                        into l_rs
                        from bars.saldoa s
                       where s.fdat between l_first_delay_date and p_dat
                         and s.dos > 0
                         and s.acc = cur.acc_2207
                       order by fdat;

                      bars.bars_audit.trace('%s nd=%s dos_count= %s',l_trace, to_char(cur.nd), to_char(l_rs.count));

                      for i in 1 .. l_rs.count loop
                        -- якщо КД імпортований з скарбу
                        -- на рах. прострочки негативний залишок з нульовими оборотами
                        if i=1 and l_rs(i).ostf<0 and l_rs(i).dos = 0 and l_rs(i).kos = 0 then
                           l_skos := l_skos + l_rs(i).ostf;
                        end if;

                        bars.bars_audit.trace('%s i=%s skos= %s dos=%s',l_trace, to_char(i), to_char(l_skos),to_char(l_rs(i).dos));

                        l_skos := l_skos - l_rs(i).dos;
                        if l_skos < 0 and l_f then
                          l_row.prosr1 := l_rs(i).fdat;
                          l_f  := false;
                        end if;

                        if l_skos < 0 then
                            if l_rs(i).dos > 0 then l_row.prosrcnt := l_row.prosrcnt + 1; end if;
                        end if;

                      end loop;

                    end if;
                  end if;
                end;

            end if;

            -- Сума простроченої заборгованості за процентами у валюті кредиту
           select sum(ostc/100) into l_row.borg_proc_prosr
              from bars.accounts a
             where a.acc=cur.acc_2209;

            l_row.borg_proc_prosr := abs(nvl(l_row.borg_proc_prosr, 0));

            -- Дата першого непогашеного платежу по відсотках
            l_row.prosr2 := null;

            -- Кількість прострочених платежів
            l_row.prosrcnt_proc := 0;

           -- todo переписати
            if l_row.borg_proc_prosr > 0 then
                -- Кількість прострочених платежів (уточнение: если на данный момент кредит в
                -- просрочке, то сколько на данный момент у него подряд просроченых !непогашених платежей)
                -- по тілу
                declare
                  l_first_delay_date date;
                  l_first_delay_done number;
                  l_skos             bars.saldoa.kos%type;

                  l_rs               saldoa_tt;

                  l_f    boolean := true;
                begin
                  -- ищем ближайший день выхода на просрочку
                  select max(s.fdat)
                    into l_first_delay_date
                    from bars.saldoa s
                   where fdat <= p_dat
                     and (ostf = 0 and dos > 0)                 -- стандартна прострочка
                     and s.acc = cur.acc_2209;

                  bars.bars_audit.trace('%s bpk nd=%s date_prostr= %s',l_trace, to_char(cur.nd),to_char(l_first_delay_date,'dd.mm.yyyy'));
                  if (l_first_delay_date is null) then
                    l_row.prosrcnt_proc := 0;
                    l_row.prosr2   := null;
                  else
                    select count(1)
                      into l_first_delay_done
                      from bars.saldoa s
                     where s.fdat >= l_first_delay_date
                       and (s.ostf - s.dos + s.kos) >= 0
                       -- Виключаємо випадок, коли в saldoa запис з ostf=0,dos=0,kos=0
                       and not (ostf = 0 and dos =0 and kos =0)
                       and s.acc = cur.acc_2209;

                    bars.bars_audit.trace('%s bpk nd=%s prosroc_done= %s',l_trace, to_char(cur.nd), to_char(l_first_delay_done));
                    -- если погасил то ОК
                    -- если нет, то считаем кол-во записей где были обороты
                    -- по выносу на простроску
                    if (l_first_delay_done > 0) then
                      l_row.prosrcnt_proc := 0;
                      l_row.prosr2   := null;
                    else
                      -- сума кред.оборотів (погашень)
                      select nvl(sum(s.kos), 0)
                        into l_skos
                        from bars.saldoa s
                       where s.kos > 0
                         and s.fdat between l_first_delay_date and p_dat
                         and s.acc = cur.acc_2209;

                      bars.bars_audit.trace('%s bpk nd=%s skos= %s',l_trace, to_char(cur.nd), to_char(l_skos));
                      -- retrive acc.array
                      -- масив виносу на прострочку
                      select * bulk collect
                        into l_rs
                        from bars.saldoa s
                       where s.fdat between l_first_delay_date and p_dat
                         and s.dos > 0
                         and s.acc = cur.acc_2209
                       order by fdat;

                      bars.bars_audit.trace('%s nd=%s dos_count= %s',l_trace, to_char(cur.nd), to_char(l_rs.count));

                      for i in 1 .. l_rs.count loop
                        -- якщо КД імпортований з скарбу
                        -- на рах. прострочки негативний залишок з нульовими оборотами
                        if i=1 and l_rs(i).ostf<0 and l_rs(i).dos = 0 and l_rs(i).kos = 0 then
                           l_skos := l_skos + l_rs(i).ostf;
                        end if;

                        bars.bars_audit.trace('%s i=%s skos= %s dos=%s',l_trace, to_char(i), to_char(l_skos),to_char(l_rs(i).dos));

                        l_skos := l_skos - l_rs(i).dos;
                        if l_skos < 0 and l_f then
                          l_row.prosr2 := l_rs(i).fdat;
                          l_f  := false;
                        end if;

                        if l_skos < 0 then
                            if l_rs(i).dos > 0 then l_row.prosrcnt_proc := l_row.prosrcnt_proc + 1; end if;
                        end if;

                      end loop;

                    end if;
                  end if;
                end;

            end if;

            -- Сума простроченої заборгованості за кредитом у валюті кредиту
            l_row.borg_prosr := l_row.borg_tilo_prosr + l_row.borg_proc_prosr;

            --l_row.borg_prosr := abs(nvl(l_row.borg_prosr, 0));

            -- Сума пені у валюті кредиту
            l_row.penja := 0;

            -- Сума нарахованих штрафів у валюті кредиту
            -- ! штрафи в АБС відсутні
            l_row.shtraf := 0;

            -- Сума повернутих коштів по кредиту в поточному році, грн
            -- todo додати конвертацію, якщо кредит валютний
            select nvl(sum(sa.kos)/100,0)
              into l_row.pay_tilo
              from bars.saldoa sa
             where sa.acc = cur.acc_ovr
               and fdat >= trunc(p_dat,'YEAR');

            -- Сума повернутих процентів за кредитом в поточному році, грн
            -- todo додати конвертацію, якщо кредит валютний
            select nvl(sum(sa.kos)/100,0)
              into l_row.pay_proc
              from bars.saldoa sa
             where sa.acc = cur.acc_2208
               and fdat >= trunc(p_dat,'YEAR');

            -- Категорія ризику
            select max(vb.kat23) into l_row.cat_ryzyk
              from bars.vx1_bpk vb
             where vb.nd=cur.nd;

            -- Дата віднесення кредиту на рахунок простроченої заборгованості
            -- беремо Дату виникнення залишку на 2207
            select  min(fdat) into l_row.cred_to_prosr
              from bars.saldoa
             where ostf = 0
                   and fdat <= p_dat and dos > 0
                   and acc = cur.acc_2207 ;

            -- Дата перенесення заборгованості на позабалансові рахунки
            l_row.borg_to_pbal := null;

            --  Вартість прийнятого майна на баланс, грн
            l_row.vart_majna := 0;

            -- Чинна дата погашення у звязку з останіми змінами
            l_row.pog_finish := null;

            if cur.acc_2207 is not null then
                l_row.tilo_prosr_uah := abs(nvl(bars.gl.p_icurval(cur.kv, bars.fost(cur.acc_2207, p_dat), p_dat)/100,0));
            else
                l_row.tilo_prosr_uah := null;
            end if;

            if cur.acc_2209 is not null then
                l_row.proc_prosr_uah := abs(nvl(bars.gl.p_icurval(cur.kv, bars.fost(cur.acc_2209, p_dat), p_dat)/100,0));
            else
                l_row.proc_prosr_uah := null;
            end if;

                    -- Сума заборгованості за тілом у гривні
            if cur.acc_ovr is not null then
                l_row.borg_tilo_uah := abs(nvl(bars.gl.p_icurval(cur.kv, bars.fost(cur.acc_ovr, p_dat), p_dat)/100,0));
            else
                l_row.borg_tilo_uah := null;
            end if;

            -- Сума  заборгованості за процентами у гривні
            if cur.acc_2208 is not null then
                l_row.borg_proc_uah := abs(nvl(bars.gl.p_icurval(cur.kv, bars.fost(cur.acc_2208, p_dat), p_dat)/100,0));
            else
                l_row.borg_proc_uah := null;
            end if;

            -- Перераховано кошти від ВДВС (наразі алгоритм відсутній)
            l_row.pay_vdvs := null;

            --Для БПК комісії відсутні
            l_row.amount_commission := null;

            l_row.amount_prosr_commission := null;

            -- Статус КД в реєстрі
           begin
             select n.TXT into l_row.ES000
             from nd_txt n
             where n.nd = cur.nd
             and tag = 'ES000'
             and kf = cur.kf;
           exception
             when no_data_found then null;
           end;
           -- дата отримання відшкодування
           begin
             select n.TXT into l_row.ES003
             from nd_txt n
             where n.nd = cur.nd
             and tag = 'ES003'
             and kf = cur.kf;
           exception
             when no_data_found then null;
           end;

            insert into credits_dyn values l_row;
            l_rows:=l_rows + 1;

            l_cnt := l_cnt + 1;
            dbms_application_info.set_client_info(l_trace||to_char(l_cnt)|| ' processed (bpk credits)');

          exception
            when others then
              l_rows_err:=l_rows_err + 1;
              l_errmsg :=substr(l_trace||' Error: nd='|| cur.nd || ', '
                                       ||dbms_utility.format_error_stack()||chr(10)
                                       ||dbms_utility.format_error_backtrace()
                                       , 1, 512);
              bars.bars_audit.error(l_errmsg);
          end;

        end loop;

        p_rows := l_rows;
        p_rows_err := l_rows_err;
        p_state := 'SUCCESS';

        bars.bars_audit.info(l_trace||' bpk crd count='||l_cnt);

        bars.bars_audit.info(l_trace||' finish');

        exception
            when others then
              l_errmsg :=substr(l_trace||' Error: '
                                       ||dbms_utility.format_error_stack()||chr(10)
                                       ||dbms_utility.format_error_backtrace()
                                       , 1, 512);
              bars.bars_audit.error(l_errmsg);

    end credits_dyn_imp;

    --
    -- Выгрузка депозитов
    --
    procedure deposits_imp (p_dat in date default trunc(sysdate), p_periodtype in varchar2 default C_FULLIMP, p_rows out number, p_rows_err out number, p_state out varchar2)
    is
        l_trace  varchar2(500) := G_TRACE||'deposits_imp: ';
        l_per_id periods.id%type;
        l_row    deposits%rowtype;
        l_errmsg varchar2(512);

        l_rows     pls_integer := 0;
        l_rows_err pls_integer := 0;

        c        sys_refcursor;
        c_clos   sys_refcursor;

        q_str  varchar2(32000);

        /*
        || Відкриті договорі
        ||
        */
        -- Договора, в яких були зміни параметрів в поточному дні
        q_str_day_pre  varchar2(4000) :=
        ' with dd as
             (select distinct deposit_id as deposit_id from bars.dpt_deposit_clos ddc
                     where ddc.WHEN between trunc(:p_dat) and trunc(:p_dat)+0.99999
                       and ddc.action_id not in (1,2))
             select
             d.deposit_id
            ,d.branch
            ,d.kf
            ,d.rnk
            ,d.nd
            ,d.dat_begin
            ,d.dat_end
            ,a.nls
            ,d.vidd
            ,trunc(months_between(d.dat_end,d.dat_begin)) term
            ,a.ostc/100 sdog
            ,a.kv
            ,bars.acrn.fproc(a.acc,sysdate) intrate
            ,d.limit/100 sdog_begin
            ,(select max(fdat)
                     from bars.saldoa s
                    where s.acc = a.acc and s.kos>0) last_dat
            ,(select sum (kos)/100
                     from bars.saldoa s
                    where s.acc = a.acc and fdat =(select max(fdat)
                                                     from bars.saldoa s
                                                    where s.acc = a.acc and s.kos>0)
                                                    ) last_sum
            ,a.ostc/100 ostc
            ,(select sum (kos)/100
                     from bars.saldoa s
                    where s.acc = aproc.acc and fdat between aproc.daos and :p_dat) sum_proc
            ,0 suma_proc_plan
            ,0 dpt_status
            ,(select nvl(sum(s)/100,0)
               from bars.saldoa s, bars.opldok d
              where s.acc=d.acc and s.fdat=d.fdat and s.acc = aproc.acc and s.dos>0 and dk=0
                and not exists (select 1 from bars.opldok k where k.ref=d.ref and k.stmt = d.stmt and k.fdat=d.fdat and k.s=d.s and dk=1 and k.acc=a.acc)) suma_proc_payoff
            ,(select max(s.fdat)
               from bars.saldoa s, bars.opldok d
              where s.acc=d.acc and s.fdat=d.fdat and s.acc = aproc.acc and s.dos>0 and dk=0
                and not exists (select 1 from bars.opldok k where k.ref=d.ref and k.stmt = d.stmt and k.fdat=d.fdat and k.s=d.s and dk=1 and k.acc=a.acc)) date_proc_payoff
            ,(select max(fdat)
                     from bars.saldoa s
                    where s.acc = a.acc and s.dos>0) date_dep_payoff
            ,d.datz
            ,a.dazs
            ,a.blkd
            ,a.blkk
            ,d.cnt_dubl
            ,d.archdoc_id
            ,d.wb
            ,a.ob22
            ,a.nms
        from bars.dpt_deposit d, bars.accounts a, bars.int_accn ia, bars.accounts aproc, dd, bars.customer c
        where d.acc=a.acc and ia.acc=a.acc and ia.acra=aproc.acc
          and D.DEPOSIT_ID = dd.deposit_id
          and d.rnk = c.rnk and not (c.ise in (''14100'', ''14200'', ''14101'',''14201'') and c.sed =''91'')
          and a.nbs != ''2620''
        union
        ';

        -- Основний запит
        -- повертає всі відкриті договора
        q_str_full  varchar2(4000) :=
        ' select
             d.deposit_id
            ,d.branch
            ,d.kf
            ,d.rnk
            ,d.nd
            ,d.dat_begin
            ,d.dat_end
            ,a.nls
            ,d.vidd
            ,trunc(months_between(d.dat_end,d.dat_begin)) term
            ,a.ostc/100 sdog
            ,a.kv
            ,bars.acrn.fproc(a.acc,sysdate) intrate
            ,d.limit/100 sdog_begin
            ,(select max(fdat)
                     from bars.saldoa s
                    where s.acc = a.acc and s.kos>0) last_dat
            ,(select sum (kos)/100
                     from bars.saldoa s
                    where s.acc = a.acc and fdat =(select max(fdat)
                                                     from bars.saldoa s
                                                    where s.acc = a.acc and s.kos>0)
                                                    ) last_sum
            ,a.ostc/100 ostc
            ,(select sum (kos)/100
                     from bars.saldoa s
                    where s.acc = aproc.acc and fdat between aproc.daos and :p_dat) sum_proc
            ,0 suma_proc_plan
            ,0 dpt_status
            ,(select nvl(sum(s)/100,0)
               from bars.saldoa s, bars.opldok d
              where s.acc=d.acc and s.fdat=d.fdat and s.acc = aproc.acc and s.dos>0 and dk=0
                and not exists (select 1 from bars.opldok k where k.ref=d.ref and k.stmt = d.stmt and k.fdat=d.fdat and k.s=d.s and dk=1 and k.acc=a.acc)) suma_proc_payoff
            ,(select max(s.fdat)
               from bars.saldoa s, bars.opldok d
              where s.acc=d.acc and s.fdat=d.fdat and s.acc = aproc.acc and s.dos>0 and dk=0
                and not exists (select 1 from bars.opldok k where k.ref=d.ref and k.stmt = d.stmt and k.fdat=d.fdat and k.s=d.s and dk=1 and k.acc=a.acc)) date_proc_payoff
            ,(select max(fdat)
                     from bars.saldoa s
                    where s.acc = a.acc and s.dos>0) date_dep_payoff
            ,d.datz
            ,a.dazs
            ,a.blkd
            ,a.blkk
            ,d.cnt_dubl
            ,d.archdoc_id
            ,d.wb
            ,a.ob22
            ,a.nms
        from bars.dpt_deposit d, bars.accounts a, bars.int_accn ia, bars.accounts aproc, bars.customer c
        where d.acc=a.acc and ia.acc=a.acc and ia.acra=aproc.acc
        and d.rnk = c.rnk and not (c.ise in (''14100'', ''14200'', ''14101'',''14201'') and c.sed =''91'')
        and a.nbs != ''2620'' ';

        -- обмеження до основної вибірки на
        -- рух по рахунку депозиту або відсотків в поточному банківському дні
        q_str_day_post  varchar2(4000) :=
        ' and (a.dapp between trunc(:p_dat) and trunc(:p_dat)+0.99999 or aproc.dapp between trunc(:p_dat) and trunc(:p_dat)+0.99999)  ';

        /*
        || Закриті договора
        || вивантажуємо за рік
        */
        q_str_clos_pre varchar2(4000) :=
        'with dc as
         (select MAX (idupd) idupd
            from bars.dpt_deposit_clos d1
           where d1.action_id in (1,2) and d1.bdate > trunc(:p_dat)-365
         ';

        q_str_clos_day  varchar2(4000) :=
        ' and d1.WHEN between trunc(:p_dat) and trunc(:p_dat)+0.99999
        ';

        q_str_clos_main varchar2(4000) :=
        ' group by d1.deposit_id)
         select
             d.deposit_id
            ,d.branch
            ,d.kf
            ,d.rnk
            ,d.nd
            ,d.dat_begin
            ,d.dat_end
            ,a.nls
            ,d.vidd
            ,trunc(months_between(d.dat_end,d.dat_begin)) term
            ,a.ostc/100 sdog
            ,a.kv
            ,bars.acrn.fproc(a.acc,sysdate) intrate
            ,d.limit/100 sdog_begin
            ,(select max(fdat)
                     from bars.saldoa s
                    where s.acc = a.acc and s.kos>0) last_dat
            ,(select sum (kos)/100
                     from bars.saldoa s
                    where s.acc = a.acc and fdat =(select max(fdat)
                                                     from bars.saldoa s
                                                    where s.acc = a.acc and s.kos>0)
                                                    ) last_sum
            ,a.ostc/100 ostc
            ,(select sum (kos)/100
                     from bars.saldoa s
                    where s.acc = aproc.acc and fdat between aproc.daos and :p_dat) sum_proc
            ,0 suma_proc_plan
            ,d.action_id dpt_status
            ,(select nvl(sum(s)/100,0)
               from bars.saldoa s, bars.opldok d
              where s.acc=d.acc and s.fdat=d.fdat and s.acc = aproc.acc and s.dos>0 and dk=0
                and not exists (select 1 from bars.opldok k where k.ref=d.ref and k.stmt = d.stmt and k.fdat=d.fdat and k.s=d.s and dk=1 and k.acc=a.acc)) suma_proc_payoff
            ,(select max(s.fdat)
               from bars.saldoa s, bars.opldok d
              where s.acc=d.acc and s.fdat=d.fdat and s.acc = aproc.acc and s.dos>0 and dk=0
                and not exists (select 1 from bars.opldok k where k.ref=d.ref and k.stmt = d.stmt and k.fdat=d.fdat and k.s=d.s and dk=1 and k.acc=a.acc)) date_proc_payoff
            ,(select max(fdat)
                     from bars.saldoa s
                    where s.acc = a.acc and s.dos>0) date_dep_payoff
            ,d.datz
            ,a.dazs
            ,a.blkd
            ,a.blkk
            ,d.cnt_dubl
            ,d.archdoc_id
            ,d.wb
            ,a.ob22
            ,a.nms
         from bars.dpt_deposit_clos d, bars.accounts a, bars.int_accn ia, bars.accounts aproc, dc, bars.customer c
        where d.acc=a.acc and ia.acc=a.acc and ia.acra=aproc.acc
          and d.rnk = c.rnk and not (c.ise in (''14100'', ''14200'', ''14101'',''14201'') and c.sed =''91'')
          and a.nbs != ''2620''
          and d.idupd = dc.idupd ';

    begin
        bars.bars_audit.info(l_trace||' start');
        -- get period id
        l_per_id := get_period_id (p_periodtype, p_dat);

        if l_per_id is null then
            return;
        end if;

        delete from deposits where per_id=l_per_id;

        -- відкриті договора
        if (p_periodtype = 'DAY') then
            q_str := q_str_day_pre || q_str_full || q_str_day_post;
            open c for q_str using p_dat, p_dat, p_dat, p_dat, p_dat, p_dat, p_dat, p_dat;
        else
            open c for q_str_full using p_dat;
        end if;

        l_row.per_id := l_per_id;

        -- відкриті договора

        loop
          begin
            fetch c into l_row.deposit_id, l_row.branch, l_row.kf, l_row.rnk, l_row.nd, l_row.dat_begin,
                         l_row.dat_end, l_row.nls, l_row.vidd, l_row.term, l_row.sdog, l_row.kv,
                         l_row.intrate, l_row.sdog_begin, l_row.last_add_date, l_row.last_add_suma,
                         l_row.ostc, l_row.suma_proc, l_row.suma_proc_plan,
                         l_row.dpt_status, l_row.suma_proc_payoff, l_row.date_proc_payoff, l_row.date_dep_payoff, l_row.datz,
                         l_row.dazs, l_row.blkd, l_row.blkk, l_row.cnt_dubl, l_row.archdoc_id, l_row.wb, l_row.ob22, l_row.nms;

            exit when c%notfound;

            insert into deposits values l_row;
            l_rows:=l_rows+1;

            dbms_application_info.set_client_info(l_trace||to_char(l_rows)|| ' processed');

          exception
            when others then
              l_rows_err:=l_rows_err+1;
              l_errmsg :=substr(l_trace||' Error: '
                                       ||dbms_utility.format_error_stack()||chr(10)
                                       ||dbms_utility.format_error_backtrace()
                                       , 1, 512);
              bars.bars_audit.error(l_errmsg);
          end;
        end loop;

        close c;

        -- закриті договора

        if (p_periodtype = 'DAY') then
            q_str := q_str_clos_pre || q_str_clos_day || q_str_clos_main;
            open c_clos for q_str using p_dat, p_dat, p_dat, p_dat;
        else
            q_str := q_str_clos_pre || q_str_clos_main ;
            open c_clos for q_str using p_dat, p_dat;
        end if;

        loop
          begin
            fetch c_clos into l_row.deposit_id, l_row.branch, l_row.kf, l_row.rnk, l_row.nd, l_row.dat_begin,
                         l_row.dat_end, l_row.nls, l_row.vidd, l_row.term, l_row.sdog, l_row.kv,
                         l_row.intrate, l_row.sdog_begin, l_row.last_add_date, l_row.last_add_suma,
                         l_row.ostc, l_row.suma_proc, l_row.suma_proc_plan,
                         l_row.dpt_status, l_row.suma_proc_payoff, l_row.date_proc_payoff, l_row.date_dep_payoff, l_row.datz,
                         l_row.dazs, l_row.blkd, l_row.blkk, l_row.cnt_dubl, l_row.archdoc_id, l_row.wb, l_row.ob22, l_row.nms;

            exit when c_clos%notfound;

            insert into deposits values l_row;
            l_rows:=l_rows+1;

            dbms_application_info.set_client_info(l_trace||to_char(l_rows)|| ' processed(clos)');

          exception
            when others then
              l_rows_err:=l_rows_err+1;
              l_errmsg :=substr(l_trace||' Error: '
                                       ||dbms_utility.format_error_stack()||chr(10)
                                       ||dbms_utility.format_error_backtrace()
                                       , 1, 512);
              bars.bars_audit.error(l_errmsg);
          end;
        end loop;

        close c_clos;

        p_rows := l_rows;
        p_rows_err := l_rows_err;
        p_state := 'SUCCESS';

        bars.bars_audit.info(l_trace||' deposits count='||l_rows);
        bars.bars_audit.info(l_trace||' finish');

    end deposits_imp;


    --
    -- Выгрузка клиентских счетов
    --
    procedure accounts_imp (p_dat        in  date     default trunc(sysdate), 
                            p_periodtype in  varchar2 default C_FULLIMP, 
                            p_rows       out number, 
                            p_rows_err   out number, 
                            p_state      out varchar2)
    is
        l_trace      varchar2(500)          := G_TRACE||'accounts_imp: ';
        l_errmsg     varchar2(512);
        -- intgr logs
        l_start_time  date                  := sysdate;
        l_rows        pls_integer           := 0;
        l_rows_err    pls_integer           := 0;

        l_row         dm_accounts%rowtype;
        l_per_id      periods.id%type;
        c             sys_refcursor;
        q_str_pre  varchar2(4000) := 'with dapp as
                                         (select a.acc
                                            from bars.accounts a
                                           where a.dapp=trunc(:p_dat)),
                                           acupd as
                                         (select distinct au.acc as acc
                                            from bars.accounts_update au
                                           where au.chgdate between trunc(:p_dat) and trunc(:p_dat)+0.99999),
                                           acvive_accounts as
                                         (select acc from dapp
                                           union
                                          select acc from acupd)
                                           ';

        q_str    varchar2(4000) := 'SELECT a.acc,
                                       a.branch,
                                       a.kf,
                                       a.rnk,
                                       a.nls,
                                       NVL (dd.vidd, 0) vidd,
                                       a.daos,
                                       a.kv,
                                       acrn.fproc (a.acc, :p_dat) intrate,
                                       0 massa,
                                       0 count_zl,
                                       a.ostc / 100 ostc,
                                       NVL ((SELECT (SUM (dos) + SUM (kos)) / 100
                                               FROM bars.saldoa
                                              WHERE acc = a.acc
                                                and fdat >= trunc(trunc(:p_dat,''MONTH'')-1,''MONTH'') and fdat<= trunc(:p_dat,''MONTH'')-1),
                                            0
                                           ) ob_mon,
                                       (SELECT max(fdat)
                                             FROM bars.saldoa s
                                            WHERE s.acc = a.acc AND s.kos>0) last_add_date,
                                        (SELECT SUM (kos)/100
                                                     FROM bars.saldoa s
                                                    WHERE s.acc = a.acc AND fdat =(SELECT max(fdat)
                                                                                     FROM bars.saldoa s
                                                                                    WHERE s.acc = a.acc AND s.kos>0)
                                                                                    ) last_add_suma,
                                       a.dazs,
                                       decode(a.dazs,null,1,0) acc_status,
                                       a.blkd,
                                       a.blkk,
                                       a.ob22,
                                       a.nms
                                   ';

        q_str_postfull  varchar2(4000) :=  ' FROM bars.accounts a, bars.dpt_deposit dd, bars.customer c
                                 WHERE a.acc = dd.acc(+) AND nbs = ''2620''
                                 and a.rnk = c.rnk
                                 and c.custtype = 3 and not (C.ise in (''14100'', ''14200'', ''14101'',''14201'') and C.sed =''91'')
                                   AND not exists (select 1 from bars.dpt_vidd dv where dd.VIDD=dv.vidd and dv.bsd = ''2620'' and dv.duration<>0) ';

        q_str_postinc varchar2(4000) :=  ' FROM bars.accounts a, bars.dpt_deposit dd, acvive_accounts aa, bars.customer c
                                 WHERE a.acc = dd.acc(+) AND nbs = ''2620''
                                 and a.rnk = c.rnk
                                 and c.custtype = 3 and not (C.ise in (''14100'', ''14200'', ''14101'',''14201'') and C.sed =''91'')
                                   AND not exists (select 1 from bars.dpt_vidd dv where dd.VIDD=dv.vidd and dv.bsd = ''2620'' and dv.duration<>0)
                                   and a.acc = aa.acc';

    begin
        bars.bars_audit.info(l_trace||' start');
        -- get period id
        l_per_id := get_period_id (p_periodtype, p_dat);

        if l_per_id is null then
            return;
        end if;

        delete from dm_accounts where per_id=l_per_id;

        -- денні зміни
        -- ! додати аналіз змін залишку
        if (p_periodtype = C_INCRIMP) then
            q_str := q_str_pre || q_str || q_str_postinc;
            open c for q_str using p_dat, p_dat, p_dat, p_dat, p_dat, p_dat;
        else
            q_str := q_str || q_str_postfull;
            open c for q_str using p_dat, p_dat, p_dat;
        end if;

        l_row.per_id := l_per_id;

        loop
          begin
            fetch c into l_row.acc, l_row.branch, l_row.kf, l_row.rnk, l_row.nls,
                         l_row.vidd, l_row.daos, l_row.kv, l_row.intrate, l_row.massa,
                         l_row.count_zl, l_row.ostc, l_row.ob_mon,
                         l_row.last_add_date, l_row.last_add_suma, l_row.dazs, l_row.acc_status,
                         l_row.blkd, l_row.blkk, l_row.ob22, l_row.nms;

            exit when c%notfound;

            insert into dm_accounts values l_row;

            l_rows := l_rows + 1;

            dbms_application_info.set_client_info(l_trace||to_char(l_rows)|| ' processed');

          exception
            when others then
              l_rows_err := l_rows_err + 1;
              l_errmsg :=substr(l_trace||' Error: '
                                       ||dbms_utility.format_error_stack()||chr(10)
                                       ||dbms_utility.format_error_backtrace()
                                       , 1, 512);
              bars.bars_audit.error(l_errmsg);
          end;

        end loop;

        close c;

        p_rows := l_rows;
        p_rows_err := l_rows_err;
        p_state := 'SUCCESS';
        bars.bars_audit.info(l_trace||' accounts count='||l_rows);
        bars.bars_audit.info(l_trace||' finish');

        notify_intgr(p_periodtype   => p_periodtype,
                     p_objects_list => bars.varchar2_list('ACCOUNTS'),
                     p_start_time   => l_start_time,
                     p_rows_ok      => l_rows,
                     p_rows_err     => l_rows_err,
                     p_status       => p_state);

    end accounts_imp;

    --
    -- Выгрузка БПК
    --
    procedure bpk_imp (p_dat in date default trunc(sysdate), p_periodtype in varchar2 default C_FULLIMP, p_rows out number, p_rows_err out number, p_state out varchar2)
    is
        l_trace  varchar2(500) := G_TRACE||'bpk_imp: ';
        l_per_id periods.id%type;
        l_row    bpk%rowtype;
        l_errmsg varchar2(512);

        l_rows     pls_integer := 0;
        l_rows_err pls_integer := 0;

        c        sys_refcursor;

        q_str_pre  varchar2(4000) := 'with dapp as
                                         (select a.acc
                                            from bars.accounts a
                                           where a.dapp=trunc(:p_dat)),
                                           acupd as
                                         (select distinct au.acc as acc
                                            from bars.accounts_update au
                                           where au.chgdate between trunc(:p_dat) and trunc(:p_dat)+0.99999),
                                           acvive_accounts as
                                         (select acc from dapp
                                           union
                                          select acc from acupd)
                                           ';

        q_str    varchar2(4000) := 'select a.branch
                                        ,a.kf
                                        ,a.rnk
                                        ,w.nd
                                        ,w.dat_begin
                                        ,w.card_code as bpk_type
                                        ,a.nls
                                        ,a.daos
                                        ,a.kv
                                        ,bars.acrn.fproc (a.acc, :p_dat) intrate
                                        ,a.ostc/100 ostc
                                        ,(SELECT max(fdat)
                                                 FROM bars.saldoa s
                                                WHERE s.acc = a.acc AND (s.kos+s.dos)>0) date_lastop
                                        ,nvl2(w.acc_ovr,1,0) cred_line
                                        ,a.lim/100  cred_lim
                                        ,abs(ao.ostc/100) use_cred_sum
                                        ,a.dazs
                                        ,a.blkd
                                        ,a.blkk
                                        ,decode(a.dazs,null,1,0) status_bpk
                                        ,pk_prct.okpo pk_okpo
                                        ,pk_prct.name pk_name
                                        ,pk_prct.okpo_n pk_okpo_n
                                      ';


        q_str_postfull  varchar2(4000) :=  ' from bars.accounts a, bars.accounts ao, bars.w4_acc w,
                                          (select aw.acc, p.id, p.name, p.okpo, p.product_code, p.okpo_n from bars.accountsw aw, bars.bpk_proect p
                                            where aw.tag = ''PK_PRCT''
                                              and to_number(aw.value)= p.id
                                              and regexp_replace(trim(aw.value), ''\D'') = trim(aw.value)) pk_prct
                                    where w.acc_pk = a.acc
                                     and w.acc_ovr = ao.acc(+)
                                     and w.acc_pk = pk_prct.acc(+) ';

        q_str_postinc varchar2(4000) :=  ' from bars.accounts a, bars.accounts ao, bars.w4_acc w, acvive_accounts aa,
                                          (select aw.acc, p.id, p.name, p.okpo, p.product_code, p.okpo_n from bars.accountsw aw, bars.bpk_proect p
                                            where aw.tag = ''PK_PRCT''
                                              and to_number(aw.value)= p.id
                                              and regexp_replace(trim(aw.value), ''\D'') = trim(aw.value)) pk_prct
                                    where w.acc_pk = a.acc
                                     and w.acc_ovr = ao.acc(+)
                                     and w.acc_pk = pk_prct.acc(+)
                                     and a.acc = aa.acc';

    begin
        bars.bars_audit.info(l_trace||' start');
        -- get period id
        l_per_id := get_period_id (p_periodtype, p_dat);

        if l_per_id is null then
            return;
        end if;

        delete from bpk where per_id=l_per_id;

        -- денні зміни
        if (p_periodtype = C_INCRIMP) then
            q_str := q_str_pre || q_str || q_str_postinc;
            open c for q_str using p_dat, p_dat, p_dat, p_dat;
        else
            q_str := q_str || q_str_postfull;
            open c for q_str using p_dat;
        end if;

        l_row.per_id := l_per_id;

        loop
          begin
            fetch c into l_row.branch, l_row.kf, l_row.rnk, l_row.nd,
                         l_row.dat_begin, l_row.bpk_type, l_row.nls, l_row.daos, l_row.kv,
                         l_row.intrate, l_row.ostc, l_row.date_lastop,
                         l_row.cred_line, l_row.cred_lim, l_row.use_cred_sum,
                         l_row.dazs, l_row.blkd, l_row.blkk, l_row.bpk_status,
                         l_row.pk_okpo, l_row.pk_name, l_row.pk_okpo_n;

            exit when c%notfound;

            insert into bpk values l_row;
            l_rows := l_rows + 1;

            dbms_application_info.set_client_info(l_trace||to_char(l_rows)|| ' processed');

          exception
            when others then
              l_rows_err := l_rows_err + 1;
              l_errmsg :=substr(l_trace||' Error: '
                                       ||dbms_utility.format_error_stack()||chr(10)
                                       ||dbms_utility.format_error_backtrace()
                                       , 1, 512);
              bars.bars_audit.error(l_errmsg);
          end;

        end loop;

        close c;

        p_rows := l_rows;
        p_rows_err := l_rows_err;
        p_state := 'SUCCESS';
        bars.bars_audit.info(l_trace||' bpk count='||l_rows);
        bars.bars_audit.info(l_trace||' finish');

    end bpk_imp;

    --
    -- Выгрузка клиентов-юрлиц
    --
    procedure custur_imp  (p_dat in date default trunc(sysdate), p_periodtype in varchar2 default C_FULLIMP, p_rows out number, p_rows_err out number, p_state out varchar2)
    is
        l_trace  varchar2(500) := G_TRACE||'custur_imp: ';
        l_per_id periods.id%type;

        l_rows     pls_integer := 0;
        l_rows_err pls_integer := 0;

        l_insert_target varchar2(64);
        l_ourmfo       varchar2(6) := sys_context('bars_context', 'user_mfo');
        -- общий запрос
        q_str          varchar2(32000);
        -- цель для вставки
        q_insert       varchar2(4000);
        -- измененные записи (дельта)
        q_str_inc_pre  varchar2(4000) :=
        ' with customer_updated as
         ((select distinct rnk from bars.customer_update cu where cu.custtype in (1,2) and cu.chgdate between trunc(:p_dat) and trunc(:p_dat)+0.99999)
          union
         (select distinct rnk from bars.customerw_update cwu where cwu.chgdate between trunc(:p_dat) and trunc(:p_dat)+0.99999)
          union
         (select distinct rnk from bars.corps_update pu where pu.chgdate between trunc(:p_dat) and trunc(:p_dat)+0.99999)
          union
         (select distinct rnk from bars.custbank_update pu where pu.chgdate between trunc(:p_dat) and trunc(:p_dat)+0.99999)
          union
         (select distinct rnk from bars.ebkc_gcif ebkg where  ebkg.insert_date between trunc(:p_dat) and trunc(:p_dat)+0.99999)
         ) ';
        -- основной запрос
        q_str_main  varchar2(32000) :=
        ' select
           :per_id,
           c.kf,
           c.rnk,
           c.branch,
           c.nmk,
           c.nmkk,
           ci.ruk,
           c.okpo,
           decode(c.custtype, 1, w.email, 2, ci.e_mail, '''') as email,
           ci.telr,
           ci.telb,
           ci.tel_fax,
           c.date_on,
           c.date_off,
           a.au_contry,
           a.au_zip,
           a.au_domain,
           a.au_region,
           a.au_locality_type,
           a.au_locality,
           a.au_adress,
           a.au_street_type,
           a.au_street,
           a.au_home_type,
           a.au_home,
           a.au_homepart_type,
           a.au_homepart,
           a.au_room_type,
           a.au_room,
           a.af_contry,
           a.af_zip,
           a.af_domain,
           a.af_region,
           a.af_locality_type,
           a.af_locality,
           a.af_adress,
           a.af_street_type,
           a.af_street,
           a.af_home_type,
           a.af_home,
           a.af_homepart_type,
           a.af_homepart,
           a.af_room_type,
           a.af_room,
           w.fsdry,
           w.fskpr,
           c.ved,
           w.idpib,
           w.uudv,
           w.kvpkk,
           c.oe,
           c.ise,
           c.fs,
           c.sed,
           (select rezid from bars.codcagent where codcagent=c.codcagent) rezid,
           w.ainab,
           w.fsved,
           cast (null as number(1)) as kbfl,
           c.prinsider,
           c.country,
           c.custtype,
           greatest((select max (trunc (cu.chgdate)) from bars.customer_update cu
                       where cu.rnk = c.rnk),
                    (select max (trunc (cu.chgdate)) from bars.customerw_update cu
                      where cu.rnk = c.rnk),
                    (select nvl(max(trunc (cu.chgdate)),to_date(''01012001'', ''ddmmyyyy'')) from bars.corps_update cu
                      where cu.rnk = c.rnk),
                    (select nvl(max(trunc (cu.chgdate)),to_date(''01012001'', ''ddmmyyyy'')) from bars.custbank_update cu
                      where cu.rnk = c.rnk)  )
                 AS lastChangeDt,                       --Дата останньої модифікації
           g.gcif
    from bars.customer c,
         (select c1.rnk, p.ruk, p.telr, p.telb, '''' as tel_fax, '''' as e_mail from bars.customer c1, bars.custbank p where c1.custtype=1 and c1.rnk=p.rnk
          union all
          select c2.rnk, p.ruk, p.telr, p.telb,  p.tel_fax, p.e_mail from bars.customer c2, bars.corps p where c2.custtype=2 and c2.rnk=p.rnk) ci,
         (select rnk,
                                "''1''_C1" au_contry,
                                "''1''_C2" au_zip,
                                "''1''_C3" au_domain,
                                "''1''_C4" au_region,
                                "''1''_C5" au_locality_type,
                                "''1''_C6" au_locality,
                                "''1''_C7" au_adress,
                                "''1''_C8" au_street_type,
                                "''1''_C9" au_street,
                                "''1''_C10" au_home_type,
                                "''1''_C11" au_home,
                                "''1''_C12" au_homepart_type,
                                "''1''_C13" au_homepart,
                                "''1''_C14" au_room_type,
                                "''1''_C15" au_room,
                                "''2''_C1" af_contry,
                                "''2''_C2" af_zip,
                                "''2''_C3" af_domain,
                                "''2''_C4" af_region,
                                "''2''_C5" af_locality_type,
                                "''2''_C6" af_locality,
                                "''2''_C7" af_adress,
                                "''2''_C8" af_street_type,
                                "''2''_C9" af_street,
                                "''2''_C10" af_home_type,
                                "''2''_C11" af_home,
                                "''2''_C12" af_homepart_type,
                                "''2''_C13" af_homepart,
                                "''2''_C14" af_room_type,
                                "''2''_C15" af_room
                           from (select rnk, type_id, country,zip, domain, region, locality_type, locality, address, street_type, street,
                                        home_type, home, homepart_type, homepart, room_type, room
                                   from bars.customer_address)
                          pivot (max(country) c1, max(zip) c2, max(domain) c3, max(region) c4, max(locality_type) c5, max(locality) c6,
                                 max(address) c7, max(street_type) c8, max(street) c9, max(home_type) c10, max(home) c11,
                                 max(homepart_type) c12, max(homepart) c13, max(room_type) c14, max(room) c15
                                   for type_id in (''1'', ''2'')
                                )
                          ) a,
                         (select rnk,
                                    "''FSDRY''_CC"  as fsdry,
                                    "''FSKPR''_CC"  as fskpr,
                                    "''IDPIB''_CC"  as idpib,
                                    "''UUDV ''_CC"  as uudv,
                                    "''KVPKK''_CC"  as kvpkk,
                                    "''AINAB''_CC"  as ainab,
                                    "''FSVED''_CC"  as fsved,
                                    "''EMAIL''_CC"  as email
                               from (select w.rnk, tag, value
                                       from bars.customerw w
                                      where tag in (''FSDRY'', ''FSKPR'', ''IDPIB'', ''UUDV '', ''KVPKK'', ''AINAB'', ''FSVED'', ''EMAIL'')
                                    )
                             pivot ( max(value) cc for tag in (''FSDRY'', ''FSKPR'', ''IDPIB'', ''UUDV '', ''KVPKK'', ''AINAB'', ''FSVED'', ''EMAIL''))
                             ) w,
                             bars.ebkc_gcif g
                             ';
        -- дельта
        q_str_inc_suf  varchar2(4000) :=
              ' ,customer_updated c1
                where c.rnk = ci.rnk
                  and c.rnk = c1.rnk
                  and c.rnk=a.rnk(+)
                  and c.rnk=w.rnk(+)
                  and c.rnk = g.rnk(+)';
        -- полная выгрузка
        q_str_full_suf  varchar2(4000) :=
              ' where c.rnk = ci.rnk
                  and c.rnk=a.rnk(+)
                  and c.rnk=w.rnk(+)
                  and c.rnk = g.rnk(+)';

        q_log_errors varchar2(4000) := q'[ LOG ERRORS into ERR$_CUSTUR ('INS') reject limit unlimited ]';

    begin
        bars.bars_audit.info(l_trace||' start');
        -- get period id
        l_per_id := get_period_id (p_periodtype, p_dat);

        if l_per_id is null then
            return;
        end if;

        truncate_kf_subpartition('CUSTUR', l_per_id, l_ourmfo);

        -- удаляем данные о предыдущих ошибках периода
        clear_err_log(p_table_name => 'CUSTUR', p_per_id => l_per_id);

        -- e.g. partition (P1164) or subpartition (P1164_KF_300465)
        l_insert_target := case when l_ourmfo is null then 'partition (P'||l_per_id||')' else 'subpartition (P'||l_per_id||'_KF_'||l_ourmfo||')' end;
        bars.bars_audit.info(l_trace||' insert target: '||l_insert_target);

        dbms_application_info.set_client_info('BARS_DM: IMPORT_'||p_periodtype||': CUSTUR '||l_ourmfo);

        begin
            q_insert :=
            q'[
            insert /*+ APPEND */ into custur ]'||l_insert_target||q'[
            (
            per_id,
            kf,
            rnk,
            branch,
            nmk,
            nmkk,
            ruk,
            okpo,
            e_mail,
            telr,
            telb,
            tel_fax,
            date_on,
            date_off,
            au_contry,
            au_zip,
            au_domain,
            au_region,
            au_locality_type,
            au_locality,
            au_adress,
            au_street_type,
            au_street,
            au_home_type,
            au_home,
            au_homepart_type,
            au_homepart,
            au_room_type,
            au_room,
            af_contry,
            af_zip,
            af_domain,
            af_region,
            af_locality_type,
            af_locality,
            af_adress,
            af_street_type,
            af_street,
            af_home_type,
            af_home,
            af_homepart_type,
            af_homepart,
            af_room_type,
            af_room,
            fsdry,
            fskpr,
            ved,
            idpib,
            uudv,
            kvpkk,
            oe,
            ise,
            fs,
            sed,
            rezid,
            ainab,
            fsved,
            kbfl,
            prinsider,
            country,
            custtype,
            lastchangedt,
            gcif)
            ]';

        if (p_periodtype = C_INCRIMP) then
            /* дельта */
            q_str := q_insert || q_str_inc_pre || q_str_main || q_str_inc_suf || q_log_errors;
            execute immediate q_str using p_dat, p_dat, p_dat, p_dat, p_dat, p_dat, p_dat, p_dat,p_dat, p_dat, l_per_id;
        else
            /* полная выгрузка */
            q_str := q_insert || q_str_main || q_str_full_suf || q_log_errors;
            execute immediate q_str using l_per_id;
        end if;

        l_rows := l_rows + sql%rowcount;
        commit;

        exception
            when others then
                rollback;
                raise;
        end;

        -- считаем кол-во ошибочных строк
        select count(*) into l_rows_err from ERR$_CUSTUR where PER_ID = l_per_id;

        p_rows := l_rows;
        p_rows_err := l_rows_err;
        p_state := 'SUCCESS';

        dbms_application_info.set_client_info('');
        bars.bars_audit.info(l_trace||' finish');

    end custur_imp;

    --
    -- Выгрузка связей клиентов
    -- Инкрементная и "полная" (+ удаленные связи за месяц)
    --
    procedure custur_rel_imp(p_dat        in date default trunc(sysdate),
                         p_periodtype in varchar2 default C_FULLIMP,
                         p_rows       out number,
                         p_rows_err   out number,
                         p_state      out varchar2) is
        l_trace  varchar2(500) := G_TRACE||'custur_rel_imp: ';
        l_per_id periods.id%type;
        l_row    custur_rel%rowtype;
        l_errmsg varchar2(512);

        l_rows     pls_integer := 0;
        l_rows_err pls_integer := 0;

        c        sys_refcursor;

        q_str_inc  varchar2(4000) :=
                'with customer_rel_updated as
                  (select distinct rnk, rel_rnk, rel_id, rel_intext from bars.customer_rel_update cru where cru.chgdate between trunc(:p_dat) and trunc(:p_dat)+0.99999)
                select c.kf,
                       cru.rnk,
                       cru.rel_id,
                       cru.rel_rnk,
                       cru.rel_intext,
                       r.name,
                       r.okpo,
                       r.vaga1,
                       r.custtype,
                       r.tel,
                       r.email,
                       r.position,
                       r.sed,
                       r.bdate,
                       r.edate,
                       r.sign_privs,
                       coalesce(case when r.rnk is null then ''D'' else '''' end, case when not (c.date_off is null or c.date_off>=sysdate) then ''Z'' else '''' end) as change_type,
                       case when c.custtype = 3 and C.ise in (''14100'', ''14200'', ''14101'',''14201'') and C.sed =''91'' then 4 else c.custtype end CL_TYPE
                 from customer_rel_updated cru
                 left join bars.V_CUSTOMER_REL r on (cru.rnk = r.rnk and cru.rel_rnk = r.rel_rnk and cru.rel_intext = r.rel_intext and cru.rel_id = r.rel_id)
                 join bars.customer c on cru.rnk = c.rnk
                where (r.vaga1 is not null or r.vaga2 is null)   -- COBUSUPABS-5519';

                /* #COBUXRMCORP-5 костыль - уже не "полная" выгрузка, а вдобавок ко всему выгружаем удаленные записи за 30 календ. дней */
        q_str_full  varchar2(4000) :=
                'with customer_rel_updated as
                  (select distinct rnk, rel_rnk, rel_id, rel_intext from bars.customer_rel_update cru where cru.chgdate between trunc(:p_dat)-30 and trunc(:p_dat)+0.99999)
                select c.kf,
                       c.rnk,
                       coalesce(r.rel_id, cru.rel_id),
                       coalesce(r.rel_rnk, cru.rel_rnk),
                       coalesce(r.rel_intext, cru.rel_intext),
                       r.name,
                       r.okpo,
                       r.vaga1,
                       r.custtype,
                       r.tel,
                       r.email,
                       r.position,
                       r.sed,
                       r.bdate,
                       r.edate,
                       r.sign_privs,
                       coalesce(case when r.rnk is null then ''D'' else '''' end, case when not (c.date_off is null or c.date_off>=sysdate) then ''Z'' else '''' end) as change_type,
                       case when c.custtype = 3 and C.ise in (''14100'', ''14200'', ''14101'',''14201'') and C.sed =''91'' then 4 else c.custtype end CL_TYPE
                 from customer_rel_updated cru
                 full join bars.V_CUSTOMER_REL r on (cru.rnk = r.rnk and cru.rel_rnk = r.rel_rnk and cru.rel_intext = r.rel_intext and cru.rel_id = r.rel_id)
                 join bars.customer  c on cru.rnk = c.rnk or r.rnk = c.rnk
                where (r.vaga1 is not null or r.vaga2 is null)   -- COBUSUPABS-5519';
    begin
        bars.bars_audit.info(l_trace||' start');

        l_per_id := get_period_id (p_periodtype, p_dat);

        if l_per_id is null then
            return;
        end if;

        delete from custur_rel where per_id=l_per_id;

        l_row.per_id := l_per_id;

        if (p_periodtype = C_INCRIMP) then
            open c for q_str_inc using p_dat, p_dat;
        else
            open c for q_str_full using p_dat, p_dat;
        end if;

        loop
          begin
            fetch c into
             l_row.kf, l_row.rnk, l_row.rel_id, l_row.rel_rnk, l_row.rel_intext, l_row.name, l_row.okpo, l_row.vaga1, l_row.custtype,
             l_row.tel, l_row.email,  l_row.position,l_row.sed, l_row.bdate, l_row.edate,l_row.sign_privs, l_row.change_type, l_row.cl_type;

            exit when c%notfound;

            insert into custur_rel values l_row;

            l_rows:=l_rows + 1;
            dbms_application_info.set_client_info(l_trace||to_char(l_rows)|| ' processed');

          exception
            when others then
              l_errmsg :=substr(l_trace||' Error: '
                                       ||dbms_utility.format_error_stack()||chr(10)
                                       ||dbms_utility.format_error_backtrace()
                                       , 1, 512);
              bars.bars_audit.error(l_errmsg);
              l_rows_err:=l_rows_err + 1;
          end;
        end loop;

        close c;

        p_rows := l_rows;
        p_rows_err := l_rows_err;
        p_state := 'SUCCESS';

        bars.bars_audit.info(l_trace||' finish');
    end custur_rel_imp;

    procedure clear_segmentation_data(
        p_period_id in integer)
    is
    begin
        declare
            partition_doesnt_exist exception;
            pragma exception_init(partition_doesnt_exist, -2149);
        begin
            execute immediate 'alter table customers_segment truncate partition for (' || p_period_id || ')';
        exception
            when partition_doesnt_exist then
                 null;
        end;

        bars_audit.info('Сегментація клієнтів для XRM - попередні дані за період з ідентифікатором {' || p_period_id || '} видалено');
    end;

    -- Сегменты: разворачивание (pivot) и сохранение
    procedure store_customer_segments_data(
        p_period_id in integer,
        p_attribute_values in bars.t_attribute_values,
        p_rows_count out integer,
        p_errors_count out integer)
    is
        l_customer_segments T_CUST_SEGMENTS;
        l_lastchangedate date := trunc(sysdate);
        l_cursor sys_refcursor;
        l_errors_count integer;

        l_user_mfo varchar2(6) := sys_context('bars_context', 'user_mfo');
        dml_errors exception;
        pragma exception_init(dml_errors, -24381);
        l_limit number := 10000;
    begin
        p_rows_count := 0;
        p_errors_count := 0;

        open l_cursor for
        select TR_CUST_SEGMENT(p_period_id,
               l_user_mfo,
               object_id,
               max(asg),-- as masg,
               max(fsg),-- as mfsg,
               max(bsg),-- as mbsg,
               max(svp),-- as msvp,
               max(tsg),-- as mtsg,
               max(ppsg),-- as mppsg,
               max(dpsg),-- as mdpsg,
               max(crsg),-- as mcrsg,
               max(escrsg),-- as mescrsg,
               max(encrsg),-- as mencrsg,
               max(crcdsg),-- as mcrcdsg,
               max(dbcdsg),-- as mdbcdsg,
               max(curacsg),-- as mcuracsg,
               l_lastchangedate)-- as lastd)
               from
        (select --p_period_id,                              -- PER_ID
               --l_user_mfo,                               -- KF
               object_id,                                -- RNK
               max(activity_segment) asg,                         -- SEGMENT_ACT
               max(financial_segment) fsg,                        -- SEGMENT_FIN
               max(behavior_segment) bsg,                         -- SEGMENT_BEH
               max(name) svp,                                     -- SOCIAL_VIP
               max(transactions_segment) tsg,                     -- SEGMENT_TRANS
               max(product_pressure_segment) ppsg,                 -- PRODUCT_AMOUNT
               max(deposits_segment) dpsg,                         -- DEPOSIT_AMMOUNT
               max(credits_segment) crsg,                          -- CREDITS_AMMOUNT
               max(ensured_credits_segment) escrsg,                  -- GARANTCREDITS_AMMOUNT
               max(energy_credits_segment) encrsg,                   -- CARDCREDITS_AMMOUNT
               max(credit_cards_segment) crcdsg,                     -- ENERGYCREDITS_AMMOUNT
               max(debit_cards_segment) dbcdsg,                      -- CARDS_AMMOUNT
               max(current_accounts_segment) curacsg,                 -- ACCOUNTS_AMMOUNT
               null as lastd                                     -- LASTCHANGEDT
        from  table(p_attribute_values) t
        join  bars.attribute_kind k on k.id = t.attribute_id
        left join bars.vip_flags v on v.rnk = t.object_id and
                                      v.mfo = l_user_mfo
        left join bars.vip_calc_tp vt on vt.id = kvip
        pivot (min(t.number_value) for attribute_code in ('CUSTOMER_SEGMENT_ACTIVITY'       as activity_segment,
                                                          'CUSTOMER_SEGMENT_FINANCIAL'      as financial_segment,
                                                          'CUSTOMER_SEGMENT_BEHAVIOR'       as behavior_segment,
                                                          'CUSTOMER_SEGMENT_TRANSACTIONS'   as transactions_segment,
                                                          'CUSTOMER_SEGMENT_PRODUCTS_AMNT'  as product_pressure_segment,
                                                          'CUSTOMER_PRDCT_AMNT_DPT'         as deposits_segment,
                                                          'CUSTOMER_PRDCT_AMNT_CREDITS'     as credits_segment,
                                                          'CUSTOMER_PRDCT_AMNT_CRD_GARANT'  as ensured_credits_segment,
                                                          'CUSTOMER_PRDCT_AMNT_CRDENERGY'   as energy_credits_segment,
                                                          'CUSTOMER_PRDCT_AMNT_CRDCARDS'    as credit_cards_segment,
                                                          'CUSTOMER_PRDCT_AMNT_CARDS'       as debit_cards_segment,
                                                          'CUSTOMER_PRDCT_AMNT_ACC'         as current_accounts_segment))
        group by object_id)
        group by object_id;
        loop
            fetch l_cursor bulk collect into l_customer_segments limit l_limit;

            p_rows_count := p_rows_count + l_customer_segments.count;

            begin
                merge into customers_segment c
                using (select * from table( cast (l_customer_segments as T_CUST_SEGMENTS))) lc
                on (c.per_id = p_period_id and c.rnk = lc.RNK /*and c.kf = lc.KF*/)
                when matched then
                  update
                  set c.SEGMENT_ACT = coalesce(lc.SEGMENT_ACT, c.SEGMENT_ACT),
                      c.SEGMENT_FIN = coalesce(lc.SEGMENT_FIN, c.SEGMENT_FIN),
                      c.SEGMENT_BEH = coalesce(lc.SEGMENT_BEH, c.SEGMENT_BEH),
                      c.SOCIAL_VIP  = coalesce(lc.SOCIAL_VIP, c.SOCIAL_VIP),
                      c.SEGMENT_TRANS = coalesce(lc.SEGMENT_TRANS, c.SEGMENT_TRANS),
                      c.PRODUCT_AMOUNT = coalesce(lc.PRODUCT_AMOUNT, c.PRODUCT_AMOUNT),
                      c.DEPOSIT_AMMOUNT = coalesce(lc.DEPOSIT_AMMOUNT, c.DEPOSIT_AMMOUNT),
                      c.CREDITS_AMMOUNT = coalesce(lc.CREDITS_AMMOUNT, c.CREDITS_AMMOUNT),
                      c.GARANTCREDITS_AMMOUNT = coalesce(lc.GARANTCREDITS_AMMOUNT, c.GARANTCREDITS_AMMOUNT),
                      c.CARDCREDITS_AMMOUNT = coalesce(lc.CARDCREDITS_AMMOUNT, c.CARDCREDITS_AMMOUNT),
                      c.ENERGYCREDITS_AMMOUNT = coalesce(lc.ENERGYCREDITS_AMMOUNT, c.ENERGYCREDITS_AMMOUNT),
                      c.CARDS_AMMOUNT = coalesce(lc.CARDS_AMMOUNT, c.CARDS_AMMOUNT),
                      c.ACCOUNTS_AMMOUNT = coalesce(lc.ACCOUNTS_AMMOUNT, c.ACCOUNTS_AMMOUNT),
                      c.LASTCHANGEDT = lc.LASTCHANGEDT
                when not matched then
                  insert values (lc.PER_ID, lc.KF, lc.RNK, lc.SEGMENT_ACT, lc.SEGMENT_FIN, lc.SEGMENT_BEH, lc.SOCIAL_VIP, lc.SEGMENT_TRANS, lc.PRODUCT_AMOUNT,
                  lc.DEPOSIT_AMMOUNT, lc.CREDITS_AMMOUNT, lc.GARANTCREDITS_AMMOUNT, lc.CARDCREDITS_AMMOUNT, lc.ENERGYCREDITS_AMMOUNT, lc.CARDS_AMMOUNT,
                  lc.ACCOUNTS_AMMOUNT, lc.LASTCHANGEDT);
            exception
                when dml_errors then
                    l_errors_count := sql%bulk_exceptions.count;
                    for i in 1 .. l_errors_count loop
                        bars.bars_audit.error('Вивантаження до XRM сегментів кдієнта ' || l_customer_segments(sql%bulk_exceptions(i).error_index).rnk || chr(10) ||
                                              sqlerrm(-sql%bulk_exceptions(i).error_code));
                    end loop;
                    p_errors_count := p_errors_count + l_errors_count;
            end;

            bars_audit.info('Сегментація клієнтів для XRM - розгортання вертикально підготовлених даних в рядок для кожного клієнта і вставка до вітрини даних' || chr(10) ||
                            'кількість оброблених даних: ' || l_customer_segments.count);

            exit when l_cursor%notfound;
        end loop;

        close l_cursor;
    end;

    -- Сегменты: выгрузка дельты
    procedure customer_segment_changes(
        p_date_from in date,
        p_date_to in date,
        p_rows_count out integer,
        p_errors_count out integer,
        p_state_code out varchar2)
    is
        l_period_id integer;

        l_attribute_values bars.t_attribute_values;
        l_cursor sys_refcursor;
        l_rows_count integer;
        l_errors_count integer;
        l_trace varchar2(500) := G_TRACE||'customer_segment_changes: ';
        l_limit number := 10000;
        l_ourmfo varchar2(6) := sys_context('bars_context', 'user_mfo');
    begin
        p_rows_count := 0;
        p_errors_count := 0;

        l_period_id := get_period_id ('DAY', p_date_from);

        if (l_period_id is null) then
            return;
        end if;
        --clear_segmentation_data(l_period_id);
        truncate_kf_subpartition('CUSTOMERS_SEGMENT', l_period_id, l_ourmfo);
        /* если контекст МФО указан - представляемся им, нет - бежим по всем kf */
        for lc_kf in (select m.kf from bars.mv_kf m where m.kf = nvl(l_ourmfo, m.kf))
        loop
            bars.bc.go(lc_kf.kf);
            open l_cursor for
                    select /* parallel(4) leading(k) */ bars.t_attribute_value(h.attribute_id, h.object_id, min(h.number_value) keep (dense_rank last order by h.value_date), null, null, null, null, null, null, null, null, null) as R
                    from bars.attribute_value_by_date h
                    join bars.attribute_kind k on k.id = h.attribute_id
                    join bars.customer c on c.rnk = h.object_id and c.custtype = 3
                    join bars.person p on p.rnk = h.object_id
                    where  k.attribute_code in ('CUSTOMER_SEGMENT_ACTIVITY', 'CUSTOMER_SEGMENT_FINANCIAL',
                                                'CUSTOMER_SEGMENT_BEHAVIOR', 'CUSTOMER_SEGMENT_TRANSACTIONS',
                                                'CUSTOMER_SEGMENT_PRODUCTS_AMNT', 'CUSTOMER_PRDCT_AMNT_DPT',
                                                'CUSTOMER_PRDCT_AMNT_CREDITS', 'CUSTOMER_PRDCT_AMNT_CRD_GARANT',
                                                'CUSTOMER_PRDCT_AMNT_CRDENERGY', 'CUSTOMER_PRDCT_AMNT_CRDCARDS',
                                                'CUSTOMER_PRDCT_AMNT_CARDS', 'CUSTOMER_PRDCT_AMNT_ACC') and k.value_by_date_flag = 'Y'
                       and h.OBJECT_ID in (select OBJECT_ID from bars.attribute_value_by_date where value_date between p_date_from and p_date_to)
                    group by h.attribute_id, h.object_id
                    union all
                    select /* parallel(4) leading(k) */ bars.t_attribute_value(h.attribute_id, h.object_id, h.number_value, null, null, null, null, null, null, null, null, null) as R
                    from bars.attribute_value h
                    join bars.attribute_kind k on k.id = h.attribute_id
                    join bars.customer c on c.rnk = h.object_id and c.custtype = 3
                    join bars.person p on p.rnk = h.object_id
                    where  k.attribute_code in ('CUSTOMER_SEGMENT_ACTIVITY', 'CUSTOMER_SEGMENT_FINANCIAL',
                                                'CUSTOMER_SEGMENT_BEHAVIOR', 'CUSTOMER_SEGMENT_TRANSACTIONS',
                                                'CUSTOMER_SEGMENT_PRODUCTS_AMNT', 'CUSTOMER_PRDCT_AMNT_DPT',
                                                'CUSTOMER_PRDCT_AMNT_CREDITS', 'CUSTOMER_PRDCT_AMNT_CRD_GARANT',
                                                'CUSTOMER_PRDCT_AMNT_CRDENERGY', 'CUSTOMER_PRDCT_AMNT_CRDCARDS',
                                                'CUSTOMER_PRDCT_AMNT_CARDS', 'CUSTOMER_PRDCT_AMNT_ACC') and k.value_by_date_flag = 'N';

            loop
                fetch l_cursor bulk collect into l_attribute_values limit l_limit;

                store_customer_segments_data(l_period_id, l_attribute_values, l_rows_count, l_errors_count);

                p_rows_count := p_rows_count + l_rows_count;
                p_errors_count := p_errors_count + l_errors_count;

                dbms_application_info.set_client_info(l_trace||to_char(p_rows_count)|| ' processed');

                exit when l_cursor%notfound;
            end loop;
        end loop;
        bars.bc.go(nvl(l_ourmfo, '/'));

        select count(*) into p_rows_count from customers_segment t where t.per_id = l_period_id;

        bars_audit.info('Сегментація клієнтів для XRM - вставку даних до таблиці customer_segments завершено' || chr(10) ||
                        'загальна кількість клієнтів: ' || p_rows_count || chr(10) ||
                        'помилок вставки: ' || p_errors_count);

        p_state_code := 'SUCCESS';
    end customer_segment_changes;

    -- Сегменты: полная выгрузка
    procedure customer_segment_snapshot(
        p_snapshot_value_date in date,
        p_rows_count out integer,
        p_errors_count out integer,
        p_state_code out varchar2)
    is
        l_period_id integer;
        l_attribute_values bars.t_attribute_values;
        l_cursor sys_refcursor;
        l_rows_count integer;
        l_trace varchar2(500) := G_TRACE||'customer_segment_snapshot: ';
        l_errors_count integer;
        l_limit number := 10000;
    begin
        p_rows_count := 0;
        p_errors_count := 0;

        l_period_id := get_period_id ('MONTH', p_snapshot_value_date);

        if (l_period_id is null) then
            return;
        end if;

        bars_audit.info('Сегментація клієнтів для XRM - початок підготовки даних за дату ' || p_snapshot_value_date);
        --clear_segmentation_data(l_period_id);
        truncate_kf_subpartition('CUSTOMERS_SEGMENT', l_period_id, sys_context('bars_context', 'user_mfo'));

        for lc_kf in (select kf from bars.mv_kf)
        loop
            bars.bc.go(lc_kf.kf);
            open l_cursor for
                select /* parallel(4) leading(k) */ bars.t_attribute_value(h.attribute_id, h.object_id, min(h.number_value) keep (dense_rank last order by h.value_date), null, null, null, null, null, null, null, null, null)
                                    from bars.attribute_value_by_date h
                                    join bars.attribute_kind k on k.id = h.attribute_id
                                    join bars.customer c on c.rnk = h.object_id and c.custtype = 3
                                    join bars.person p on p.rnk = h.object_id
                                    where  k.attribute_code in ('CUSTOMER_SEGMENT_ACTIVITY', 'CUSTOMER_SEGMENT_FINANCIAL',
                                                                'CUSTOMER_SEGMENT_BEHAVIOR', 'CUSTOMER_SEGMENT_TRANSACTIONS',
                                                                'CUSTOMER_SEGMENT_PRODUCTS_AMNT', 'CUSTOMER_PRDCT_AMNT_DPT',
                                                                'CUSTOMER_PRDCT_AMNT_CREDITS', 'CUSTOMER_PRDCT_AMNT_CRD_GARANT',
                                                                'CUSTOMER_PRDCT_AMNT_CRDENERGY', 'CUSTOMER_PRDCT_AMNT_CRDCARDS',
                                                                'CUSTOMER_PRDCT_AMNT_CARDS', 'CUSTOMER_PRDCT_AMNT_ACC') and k.value_by_date_flag = 'Y'
                                    and h.value_date <= sysdate
                                    group by h.attribute_id, h.object_id
                union all
                select /* parallel(4) leading(k) */ bars.t_attribute_value(h.attribute_id, h.object_id, h.number_value, null, null, null, null, null, null, null, null, null)
                                    from bars.attribute_value h
                                    join bars.attribute_kind k on k.id = h.attribute_id
                                    join bars.customer c on c.rnk = h.object_id and c.custtype = 3
                                    join bars.person p on p.rnk = h.object_id
                                    where  k.attribute_code in ('CUSTOMER_SEGMENT_ACTIVITY', 'CUSTOMER_SEGMENT_FINANCIAL',
                                                                'CUSTOMER_SEGMENT_BEHAVIOR', 'CUSTOMER_SEGMENT_TRANSACTIONS',
                                                                'CUSTOMER_SEGMENT_PRODUCTS_AMNT', 'CUSTOMER_PRDCT_AMNT_DPT',
                                                                'CUSTOMER_PRDCT_AMNT_CREDITS', 'CUSTOMER_PRDCT_AMNT_CRD_GARANT',
                                                                'CUSTOMER_PRDCT_AMNT_CRDENERGY', 'CUSTOMER_PRDCT_AMNT_CRDCARDS',
                                                                'CUSTOMER_PRDCT_AMNT_CARDS', 'CUSTOMER_PRDCT_AMNT_ACC') and k.value_by_date_flag = 'N';

            loop
                fetch l_cursor bulk collect into l_attribute_values limit l_limit;

                store_customer_segments_data(l_period_id, l_attribute_values, l_rows_count, l_errors_count);

                p_rows_count := p_rows_count + l_rows_count;
                p_errors_count := p_errors_count + l_errors_count;

                dbms_application_info.set_client_info(l_trace||to_char(p_rows_count)|| ' processed');

                exit when l_cursor%notfound;
            end loop;
        end loop;
        bars.bc.home;

        select count(*) into p_rows_count from customers_segment t where t.per_id = l_period_id;

        bars_audit.info('Сегментація клієнтів для XRM - вставку даних до таблиці customer_segments завершено' || chr(10) ||
                        'загальна кількість клієнтів: ' || p_rows_count || chr(10) ||
                        'помилок вставки: ' || p_errors_count);

        p_state_code := 'SUCCESS';
    end customer_segment_snapshot;

    --
    -- Сегментация физлиц - общий метод
    --
    procedure cust_segm_imp(
        p_dat        in date default trunc(sysdate),
        p_periodtype in varchar2 default C_FULLIMP,
        p_rows       out number,
        p_rows_err   out number,
        p_state      out varchar2)
    is
    begin
        if (p_periodtype = C_INCRIMP) then
            customer_segment_changes(trunc(p_dat), trunc(p_dat) + 1, p_rows, p_rows_err, p_state);
        else
            customer_segment_snapshot(trunc(p_dat), p_rows, p_rows_err, p_state);
        end if;
    end;

    -- TODO: К УДАЛЕНИЮ
    -- import assurances
    -- 18/04/2016 only for GOUK
    -- вивантаження не проводиться (уточнюються умови)
    procedure assurance_imp(p_dat        in date default trunc(sysdate),
                             p_periodtype in varchar2 default C_INCRIMP,
                             p_rows       out number,
                             p_rows_err   out number,
                             p_state      out varchar2) is

        l_trace  varchar2(500) := G_TRACE||'assurance_imp: ';
        l_per_id periods.id%type;
        l_row    dm_assurances_gouk%rowtype;
        l_errmsg varchar2(512);

        l_rows     pls_integer := 0;
        l_rows_err pls_integer := 0;

        l_axa   boolean;

    begin
        bars.bars_audit.info(l_trace||' start');

        -- get period id
        l_per_id := get_period_id (p_periodtype, p_dat);

        if l_per_id is null then
            return;
        end if;

        delete from dm_assurances_gouk where per_id=l_per_id;

        l_row.per_id := l_per_id;

        for cur in
            (select p.ref, a.kf, a.nls, o.s, o.nazn
                          from bars.opldok p, bars.oper o, bars.accounts a
                         where p.acc = a.acc
                           and p.ref = o.ref
                           and p.tt = o.tt
                           and a.nls = o.nlsb
                           and fdat  = trunc(p_dat)
                           and p.sos = 5
                           and p.dk = 1
                           and a.nls in
                                    ('265043021596'
                                    ,'265033011590'
                                    ,'265013011141'
                                    ,'26503301873'
                                    ,'265023051146'
                                    ,'26502301829')
                           and (lower(nazn) like '%cтраховий%' or lower(nazn) like '%страховий%')
                           and regexp_count(nazn,';') >=9
                   )
        loop
          begin
            l_row.kf := cur.kf;
            -- Для АХА в призначені платежу наявні символи '/=' початок поля структурованого платежу
            l_axa := instr(cur.nazn, '/=') > 0;

            if l_axa then cur.nazn:=substr(cur.nazn, instr(cur.nazn, '/=')); end if;

            l_row.ref:= cur.ref;
            l_row.nls:= cur.nls;

            -- Код виду страхування
            if l_axa then l_row.cod:=regexp_substr(cur.nazn, '[^;]+', 1, 3 );
                else l_row.cod:=regexp_substr(cur.nazn, '[^;]+', 1, 2);
            end if;

            -- № договору страхування
            l_row.ndog := regexp_substr(cur.nazn, '[^;]+', 1, 4);

            -- Сума страхового платежу
            l_row.s_pay := cur.s/100;

            -- Комісія за страховим платежем
            -- Для АXА в 8 полі, для інших розраховується
            if l_axa then
              begin
                 l_row.s_com := to_number(replace(regexp_substr(cur.nazn, '[^;]+', 1, 8),',','.'));
              exception when VALUE_ERROR then l_row.s_com := 0;
              end;
            else
              if l_row.s_pay <= 1000
                then l_row.s_com := greatest(round(l_row.s_pay/100,2),5);
              elsif  l_row.s_pay <= 10000
                then l_row.s_com := round(l_row.s_pay*0.75/100,2);
              else -- s > 10000.01
                l_row.s_com := least(round(l_row.s_pay*0.5/100,2),500);
              end if;
            end if;

            -- Номер установи банку
            l_row.dep_bank := regexp_substr(cur.nazn, '[^;]+', 1, 9);

            insert into dm_assurances_gouk values l_row;

            l_rows := l_rows + 1;

          exception
            when others then
              l_rows_err := l_rows_err + 1;
              l_errmsg :=substr(l_trace||' Error: '
                                       ||dbms_utility.format_error_stack()||chr(10)
                                       ||dbms_utility.format_error_backtrace()
                                       , 1, 512);
              bars.bars_audit.error(l_errmsg);
         end;

        end loop;

        p_rows := l_rows;
        p_rows_err := l_rows_err;
        p_state := 'SUCCESS';

        bars.bars_audit.info(l_trace||' finish');

    end assurance_imp;


    --
    -- Выгрузка залогов
    --
    procedure zastava_imp  (p_dat in date default trunc(sysdate), p_periodtype in varchar2 default C_FULLIMP, p_rows out number, p_rows_err out number, p_state out varchar2)
    is
        l_trace  varchar2(500) := G_TRACE||'zastava_imp: ';
        l_per_id periods.id%type;
        l_row    zastava%rowtype;
        l_errmsg varchar2(512);

        l_rows     pls_integer := 0;
        l_rows_err pls_integer := 0;

        c        sys_refcursor;
    begin
        bars.bars_audit.info(l_trace||' start');

        -- get period id
        l_per_id := get_period_id (p_periodtype, p_dat);

        if l_per_id is null then
            return;
        end if;

        delete from zastava where per_id=l_per_id;

        l_row.per_id := l_per_id;

        for cur in ( SELECT d.kf, d.rnk,  -- актуальна застава
                           c.okpo,
                           d.nd,
                           d.vidd,
                           pa.cc_idz,
                           pa.sdatz,
                           pa.mpawn,
                           s.pawn_23,
                           ABS (a9.ostc / 100) bvart,
                           pa.nree,
                           pa.acc acc_pawn,
                           a9.rnk rnk_accpawn,
                           0 as state_accpawn
                      FROM bars.accounts a,
                           bars.nd_acc na,
                           bars.cc_deal d,
                           bars.customer c,
                           bars.cc_accp p,
                           bars.accounts a9,
                           bars.pawn_acc pa,
                           bars.cc_pawn s
                     WHERE d.rnk = c.rnk AND c.custtype in (2, 3) AND d.vidd in (1, 2, 3, 11, 12, 13)
                       and d.nd = na.nd
                       AND na.acc = a.acc  AND a.tip = 'SS '  AND a.dazs IS NULL
                       AND p.accs = a.acc
                       AND a9.acc = p.acc
                       AND p.acc = pa.acc
                       AND pa.pawn = s.pawn
                    union all
                      SELECT d.kf, d.rnk,   -- видалена застава
                           c.okpo,
                           d.nd,
                           d.vidd,
                           pa.cc_idz,
                           pa.sdatz,
                           pa.mpawn,
                           s.pawn_23,
                           ABS (a9.ostc / 100) bvart,
                           pa.nree,
                           pa.acc acc_pawn,
                           a9.rnk rnk_accpawn,
                           1 as state_accpawn
                      FROM bars.accounts a,
                           bars.nd_acc na,
                           bars.cc_deal d,
                           bars.customer c,
                           (select nd, acc, accs from
                                 (select u.*, l.acc as del
                                    from bars.cc_accp_update u
                                         left outer join bars.cc_accp l on l.acc=u.acc and l.nd=u.nd
                                   where u.chgaction='D' and u.effectdate>=sysdate-7
                                 ) z
                                 where del is null
                           group by nd, acc, accs)  p,
                           bars.accounts a9,
                           bars.pawn_acc pa,
                           bars.cc_pawn s
                     WHERE d.rnk = c.rnk AND c.custtype in (2, 3) AND d.vidd in (1, 2, 3, 11, 12, 13)
                       and d.nd = na.nd
                       AND na.acc = a.acc  AND a.tip = 'SS '
                       AND p.accs = a.acc
                       AND a9.acc = p.acc
                       AND p.acc = pa.acc
                       AND pa.pawn = s.pawn
                   )
        loop
          begin
            l_row.kf := cur.kf;
            l_row.rnk:= cur.rnk;
            l_row.okpo := cur.okpo;
            l_row.nd  := cur.nd;
            l_row.vidd:= cur.vidd;
            -- номер договору застави
            l_row.ndz:= cur.cc_idz;
            -- дата договору застави
            l_row.datez:= cur.sdatz;
            -- Індекс, місцезнаходження заставленого майна
            l_row.mpawn:=cur.mpawn;
            -- Код підвиду забезпечення згідно з класифікатору банку
            l_row.pawnpawn := cur.pawn_23;
            -- Код предмету застави
            l_row.pawn:= null;
            -- Родові ознаки предмету застави
            l_row.ozn := null;
            -- Договірна вартість заставленого майна
            l_row.bvart:= cur.bvart;
            -- Справедлива (рекомендована) вартість
            l_row.svart:= cur.bvart;
            -- Реєстраційний номер в державному реєстрі обтяжень
            l_row.nree:=cur.nree;
            l_row.ndstrah:= null;
            l_row.datestrah:= null;
            l_row.cntchk:= null;
            l_row.dlchk:= null;
            l_row.nfact:= null;
            l_row.stzz:= null;
            -- id рахунку застави
            l_row.acc_pawn:= cur.acc_pawn;
            -- РНК заставодавця
            l_row.rnk_accpawn:= cur.rnk_accpawn;
            -- статус застави
            l_row.state_accpawn:= cur.state_accpawn;

            insert into zastava values l_row;

            l_rows := l_rows + 1;

          exception
            when others then
              l_rows_err := l_rows_err + 1;
              l_errmsg :=substr(l_trace||' Error: '
                                       ||dbms_utility.format_error_stack()||chr(10)
                                       ||dbms_utility.format_error_backtrace()
                                       , 1, 512);
              bars.bars_audit.error(l_errmsg);
         end;

        end loop;

        p_rows := l_rows;
        p_rows_err := l_rows_err;
        p_state := 'SUCCESS';

        bars.bars_audit.info(l_trace||' finish');

    end zastava_imp;


    --
    -- Расширенная выгрузка депозитов
    --
    procedure deposits_plt_imp (p_dat in date default trunc(sysdate), p_periodtype in varchar2 default C_FULLIMP, p_rows out number, p_rows_err out number, p_state out varchar2)
    is
        l_trace  varchar2(500) := G_TRACE||'deposits_plt_imp: ';
        l_per_id periods.id%type;
        l_row    deposit_PLT%rowtype;
        l_errmsg varchar2(512);
        l_start_time date := sysdate;

        l_rows     pls_integer := 0;
        l_rows_err pls_integer := 0;
    begin
        bars.bars_audit.info(l_trace||' start');
        -- get period id
        l_per_id := get_period_id (p_periodtype, p_dat);

        if l_per_id is null then
            return;
        end if;

        delete from deposit_plt where per_id=l_per_id;

        l_row.per_id := l_per_id;

        -- відкриті договора
        for c in ( with dd as
                   (select distinct deposit_id as deposit_id from bars.dpt_deposit_clos ddc
                           where ddc.WHEN between trunc(p_dat) and trunc(p_dat)+0.99999
                             and ddc.action_id not in (1,2))
                   select
                           d.deposit_id                                                         --ід депозиту
                          ,d.branch                                                             --відділення
                          ,d.kf                                                                 --РУ
                          ,d.rnk                                                                --РНК
                          ,d.nd                                                                 --номер договору
                          ,d.dat_begin                                                          --договір від
                          ,d.dat_end                                                            --дата закінчення договору
                          ,a.nls                                                                --номер рахунку
                          ,d.vidd                                                               --вид вкладу
                          ,trunc(months_between(d.dat_end,d.dat_begin)) term                    --строк вкладу
                          ,a.ostc/100 sdog                                                      --сума вкладу
                          ,a.kv                                                                 --валюта вкладу
                          ,bars.acrn.fproc(a.acc,sysdate) intrate                               --відсоткова ставка
                          ,d.limit/100 sdog_begin                                               --початкова сума вкладу
                          ,(select max(fdat)
                                   from bars.saldoa s
                                  where s.acc = a.acc and s.kos>0) last_dat                       --дата останнього поповнення
                          ,(select sum (kos)/100
                                   from bars.saldoa s
                                  where s.acc = a.acc and fdat =(select max(fdat)
                                                                   from bars.saldoa s
                                                                  where s.acc = a.acc and s.kos>0)
                                                                  ) last_sum                      --сума останнього поповнення
                          ,a.ostc/100 ostc                                                        --поточний залишок
                          ,(select sum (kos)/100
                                   from bars.saldoa s
                                  where s.acc = aproc.acc and fdat between aproc.daos and p_dat) sum_proc --поточна сума нарахованих відсотків
                          ,0 suma_proc_plan                                                       --сума відсотків на планову дату виплати
                          ,0 dpt_status                                                           --статус деп. договору - 0 - відкритий, 1 - закритий
                          ,(select nvl(sum(s)/100,0)
                             from bars.saldoa s, bars.opldok d
                            where s.acc=d.acc and s.fdat=d.fdat and s.acc = aproc.acc and s.dos>0 and dk=0
                              and not exists (select 1 from bars.opldok k where k.ref=d.ref and k.stmt = d.stmt and k.fdat=d.fdat and k.s=d.s and dk=1 and k.acc=a.acc)) suma_proc_payoff --сума випл. відсотків
                          ,(select max(s.fdat)
                             from bars.saldoa s, bars.opldok d
                            where s.acc=d.acc and s.fdat=d.fdat and s.acc = aproc.acc and s.dos>0 and dk=0
                              and not exists (select 1 from bars.opldok k where k.ref=d.ref and k.stmt = d.stmt and k.fdat=d.fdat and k.s=d.s and dk=1 and k.acc=a.acc)) date_proc_payoff --дата виплати відсотків(остання)
                          ,(select max(fdat)
                                   from bars.saldoa s
                                  where s.acc = a.acc and s.dos>0) date_dep_payoff                       --дата виплати депозиту
                          ,d.datz                                                                        --дата заключення вкладу
                          ,a.dazs                                                                        --дата закриття рахунку
                          ,a.blkd                                                                        --код блокування рахунку по дебету
                          ,a.blkk                                                                        --код блокування рахунку по кредиту
                          ,d.cnt_dubl                                                                    --кількість пролонгацій
                          ,d.archdoc_id                                                                  --ідентифікатор депозитного договору в ЕАД
                          ,dw.value as ncash                                                                      --нал/безнал
                          ,(select cc.NMK from bars.accounts a left join bars.customer cc on a.rnk = cc.rnk where a.ACC = d.ACC_D)  as NAME_D
                          ,d.OKPO_D                                                                      --код получателя депозита
                          ,d.NLS_D                                                                       --номер счета получателя депозита
                          ,d.MFO_D                                                                       --МФО счета получателя депозита
                          ,d.NAME_P                                                                      --Получатель %
                          ,d.OKPO_P                                                                      --код получателя %
                          ,ia.NLSB                                                                       --номер счета получателя %
                          ,ia.MFOB                                                                       --МФО счета получателя %
                          ,(SELECT max(Ain.NLS) FROM bars.ACCOUNTS ain, bars.dpt_accounts dain, bars.dpt_deposit din
                            where ain.acc = dain.accid
                             and dain.accid != din.acc
                             and dain.dptid = Din.DEPOSIT_ID
                             and dain.dptid = d.DEPOSIT_ID
                          ) as NLSP --счет % по депозитам
                          ,case ddt.TYP_TR when 'M' then 1 end rosp_m  --на імєя малолітньої особи(розпорядник)
                          ,case ddt.TYP_TR when 'C' then 1 end mal     --малолітня особа
                          ,case ddt.TYP_TR when 'B' then 1 end ben     --бенефіціар
                          ,dv.TYPE_NAME vidd_name   --вид вкладу(символьний)
                          ,d.wb
                          ,a.ob22
                          ,a.nms
              from bars.dpt_deposit d, bars.accounts a, bars.int_accn ia, bars.accounts aproc, dd, bars.DPT_DEPOSITW dw, bars.DPT_TRUSTEE ddt, bars.DPT_VIDD dv
              , bars.customer c
              where d.acc=a.acc and ia.acc=a.acc and ia.acra=aproc.acc
                --and (a.dapp between trunc(p_dat) and trunc(p_dat)+0.99999 or aproc.dapp between trunc(p_dat) and trunc(p_dat)+0.99999)
                and D.DEPOSIT_ID = dd.deposit_id
                and d.DEPOSIT_ID = dw.DPT_ID(+)
                and dw.TAG(+) = 'NCASH'
                and d.DEPOSIT_ID = ddt.DPT_ID(+)
                and d.vidd = dv.VIDD(+)
                and d.rnk = c.rnk and c.custtype = 3 and not (C.ise in ('14100', '14200', '14101','14201') and C.sed ='91') --фильтруем ФОПов
                and a.nbs != '2620'
                and p_periodtype = 'DAY' /*выполняем только для ежедневной выгрузки*/
              union
               select
                   d.deposit_id
                  ,d.branch
                  ,d.kf
                  ,d.rnk
                  ,d.nd
                  ,d.dat_begin
                  ,d.dat_end
                  ,a.nls
                  ,d.vidd
                  ,trunc(months_between(d.dat_end,d.dat_begin)) term
                  ,a.ostc/100 sdog
                  ,a.kv
                  ,bars.acrn.fproc(a.acc,sysdate) intrate
                  ,d.limit/100 sdog_begin
                  ,(select max(fdat)
                           from bars.saldoa s
                          where s.acc = a.acc and s.kos>0) last_dat
                  ,(select sum (kos)/100
                           from bars.saldoa s
                          where s.acc = a.acc and fdat =(select max(fdat)
                                                           from bars.saldoa s
                                                          where s.acc = a.acc and s.kos>0)
                                                          ) last_sum
                  ,a.ostc/100 ostc
                  ,(select sum (kos)/100
                           from bars.saldoa s
                          where s.acc = aproc.acc and fdat between aproc.daos and p_dat) sum_proc
                  ,0 suma_proc_plan
                  ,0 dpt_status
                  ,(select nvl(sum(s)/100,0)
                     from bars.saldoa s, bars.opldok d
                    where s.acc=d.acc and s.fdat=d.fdat and s.acc = aproc.acc and s.dos>0 and dk=0
                      and not exists (select 1 from bars.opldok k where k.ref=d.ref and k.stmt = d.stmt and k.fdat=d.fdat and k.s=d.s and dk=1 and k.acc=a.acc)) suma_proc_payoff
                  ,(select max(s.fdat)
                     from bars.saldoa s, bars.opldok d
                    where s.acc=d.acc and s.fdat=d.fdat and s.acc = aproc.acc and s.dos>0 and dk=0
                      and not exists (select 1 from bars.opldok k where k.ref=d.ref and k.stmt = d.stmt and k.fdat=d.fdat and k.s=d.s and dk=1 and k.acc=a.acc)) date_proc_payoff
                  ,(select max(fdat)
                           from bars.saldoa s
                          where s.acc = a.acc and s.dos>0) date_dep_payoff
                  ,d.datz
                  ,a.dazs
                  ,a.blkd
                  ,a.blkk
                  ,d.cnt_dubl
                  ,d.archdoc_id
                  ,dw.value as ncash                                                                      --нал/безнал
                  ,(select cc.NMK from bars.accounts a left join bars.customer cc on a.rnk = cc.rnk where a.ACC = d.ACC_D)  as NAME_D
                  ,d.OKPO_D                                                                      --код получателя депозита
                  ,d.NLS_D                                                                       --номер счета получателя депозита
                  ,d.MFO_D                                                                       --МФО счета получателя депозита
                  ,d.NAME_P                                                                      --Получатель %
                  ,d.OKPO_P                                                                      --код получателя %
                  ,ia.NLSB                                                                       --номер счета получателя %
                  ,ia.MFOB                                                                       --МФО счета получателя %
                  ,(SELECT max(Ain.NLS) FROM bars.ACCOUNTS ain, bars.dpt_accounts dain, bars.dpt_deposit din
                    where ain.acc = dain.accid
                     and dain.accid != din.acc
                     and dain.dptid = Din.DEPOSIT_ID
                     and dain.dptid = d.DEPOSIT_ID
                  ) as NLSP --счет % по депозитам
                  ,case ddt.TYP_TR when 'M' then 1 end rosp_m  --на імєя малолітньої особи(розпорядник)
                  ,case ddt.TYP_TR when 'C' then 1 end mal     --малолітня особа
                  ,case ddt.TYP_TR when 'B' then 1 end ben     --бенефіціар
                  ,dv.TYPE_NAME vidd_name   --вид вкладу(символьний)
                  ,d.wb
                  ,a.ob22
                  ,a.nms
              from bars.dpt_deposit d, bars.accounts a, bars.int_accn ia, bars.accounts aproc, bars.DPT_DEPOSITW dw, bars.DPT_TRUSTEE ddt, bars.DPT_VIDD dv
              , bars.customer c
              where d.acc=a.acc and ia.acc=a.acc and ia.acra=aproc.acc
              and
                (
                  p_periodtype = 'DAY' and /*только для ежедневных выгрузок*/
                  (a.dapp between trunc(p_dat) and trunc(p_dat)+0.99999 or aproc.dapp between trunc(p_dat) and trunc(p_dat)+0.99999)
                )
              and d.DEPOSIT_ID = dw.DPT_ID(+)
              and dw.TAG(+) = 'NCASH'
              and d.DEPOSIT_ID = ddt.DPT_ID(+)
              and d.vidd = dv.VIDD(+)
              and d.rnk = c.rnk and c.custtype = 3 and not (C.ise in ('14100', '14200', '14101','14201') and C.sed ='91') --фильтруем ФОПов
              and a.nbs != '2620'

              union

                         select
                   d.deposit_id
                  ,d.branch
                  ,d.kf
                  ,d.rnk
                  ,d.nd
                  ,d.dat_begin
                  ,d.dat_end
                  ,a.nls
                  ,d.vidd
                  ,trunc(months_between(d.dat_end,d.dat_begin)) term
                  ,a.ostc/100 sdog
                  ,a.kv
                  ,bars.acrn.fproc(a.acc,sysdate) intrate
                  ,d.limit/100 sdog_begin
                  ,(select max(fdat)
                           from bars.saldoa s
                          where s.acc = a.acc and s.kos>0) last_dat
                  ,(select sum (kos)/100
                           from bars.saldoa s
                          where s.acc = a.acc and fdat =(select max(fdat)
                                                           from bars.saldoa s
                                                          where s.acc = a.acc and s.kos>0)
                                                          ) last_sum
                  ,a.ostc/100 ostc
                  ,(select sum (kos)/100
                           from bars.saldoa s
                          where s.acc = aproc.acc and fdat between aproc.daos and p_dat) sum_proc
                  ,0 suma_proc_plan
                  ,0 dpt_status
                  ,(select nvl(sum(s)/100,0)
                     from bars.saldoa s, bars.opldok d
                    where s.acc=d.acc and s.fdat=d.fdat and s.acc = aproc.acc and s.dos>0 and dk=0
                      and not exists (select 1 from bars.opldok k where k.ref=d.ref and k.stmt = d.stmt and k.fdat=d.fdat and k.s=d.s and dk=1 and k.acc=a.acc)) suma_proc_payoff
                  ,(select max(s.fdat)
                     from bars.saldoa s, bars.opldok d
                    where s.acc=d.acc and s.fdat=d.fdat and s.acc = aproc.acc and s.dos>0 and dk=0
                      and not exists (select 1 from bars.opldok k where k.ref=d.ref and k.stmt = d.stmt and k.fdat=d.fdat and k.s=d.s and dk=1 and k.acc=a.acc)) date_proc_payoff
                  ,(select max(fdat)
                           from bars.saldoa s
                          where s.acc = a.acc and s.dos>0) date_dep_payoff
                  ,d.datz
                  ,a.dazs
                  ,a.blkd
                  ,a.blkk
                  ,d.cnt_dubl
                  ,d.archdoc_id
                  ,dw.value as ncash                                                                      --нал/безнал
                  ,(select cc.NMK from bars.accounts a left join bars.customer cc on a.rnk = cc.rnk where a.ACC = d.ACC_D)  as NAME_D
                  ,d.OKPO_D                                                                      --код получателя депозита
                  ,d.NLS_D                                                                       --номер счета получателя депозита
                  ,d.MFO_D                                                                       --МФО счета получателя депозита
                  ,d.NAME_P                                                                      --Получатель %
                  ,d.OKPO_P                                                                      --код получателя %
                  ,ia.NLSB                                                                       --номер счета получателя %
                  ,ia.MFOB                                                                       --МФО счета получателя %
                  ,(SELECT max(Ain.NLS) FROM bars.ACCOUNTS ain, bars.dpt_accounts dain, bars.dpt_deposit din
                    where ain.acc = dain.accid
                     and dain.accid != din.acc
                     and dain.dptid = Din.DEPOSIT_ID
                     and dain.dptid = d.DEPOSIT_ID
                  ) as NLSP --счет % по депозитам
                  ,case ddt.TYP_TR when 'M' then 1 end rosp_m  --на імєя малолітньої особи(розпорядник)
                  ,case ddt.TYP_TR when 'C' then 1 end mal     --малолітня особа
                  ,case ddt.TYP_TR when 'B' then 1 end ben     --бенефіціар
                  ,dv.TYPE_NAME vidd_name   --вид вкладу(символьний)
                  ,d.wb
                  ,a.ob22
                  ,a.nms
              from bars.dpt_deposit d, bars.accounts a, bars.int_accn ia, bars.accounts aproc, bars.DPT_DEPOSITW dw, bars.DPT_TRUSTEE ddt, bars.DPT_VIDD dv
              , bars.customer c
              where d.acc=a.acc and ia.acc=a.acc and ia.acra=aproc.acc
              and p_periodtype = 'MONTH'
              and d.DEPOSIT_ID = dw.DPT_ID(+)
              and dw.TAG(+) = 'NCASH'
              and d.DEPOSIT_ID = ddt.DPT_ID(+)
              and d.vidd = dv.VIDD(+)
              and d.rnk = c.rnk and c.custtype = 3 and not (C.ise in ('14100', '14200', '14101','14201') and C.sed ='91') --фильтруем ФОПов
              and a.nbs != '2620'
         )
        loop
          begin
            l_row.deposit_id := c.deposit_id;
            l_row.branch := c.branch;
            l_row.kf := c.kf;
            l_row.rnk := c.rnk;
            l_row.nd := c.nd;
            l_row.dat_begin := c.dat_begin;
            l_row.dat_end   := c.dat_end;
            l_row.nls       := c.nls;
            l_row.vidd      := c.vidd;
            l_row.term      := c.term;
            l_row.sdog      := c.sdog;
            l_row.kv        := c.kv;
            l_row.intrate   := c.intrate;
            l_row.sdog_begin := c.sdog_begin;
            l_row.last_add_date := c.last_dat;
            l_row.last_add_suma := c.last_sum;
            l_row.ostc          := c.ostc;
            l_row.suma_proc     := c.sum_proc;
            l_row.suma_proc_plan := c.suma_proc_plan;
            l_row.dpt_status     := c.dpt_status;
            l_row.suma_proc_payoff := c.suma_proc_payoff;
            l_row.date_proc_payoff := c.date_proc_payoff;
            l_row.date_dep_payoff := c.date_dep_payoff;
            l_row.datz            := c.datz;
            l_row.dazs            := c.dazs;
            l_row.blkd            := c.blkd;
            l_row.blkk            := c.blkk;
            l_row.cnt_dubl        := c.cnt_dubl;
            l_row.archdoc_id      := c.archdoc_id;
            l_row.NCASH           := c.ncash;
            l_row.NAME_D          := c.name_d;
            l_row.OKPO_D          := c.okpo_d;
            l_row.NLS_D           := c.nls_d;
            l_row.MFO_D           := c.mfo_d;
            l_row.NAME_P          := c.name_p;
            l_row.OKPO_P          := c.okpo_p;
            l_row.NLSB            := c.nlsb;
            l_row.MFOB            := c.mfob;
            l_row.NLSP            := c.nlsp;
            l_row.ROSP_M          := c.rosp_m;
            l_row.MAL             := c.mal;
            l_row.BEN             := c.ben;
            l_row.VIDD_NAME       := c.vidd_name;
            l_row.MASSA           := null;
            l_row.PER_ID      := l_per_id;
            l_row.wb          := c.wb;
            l_row.ob22            := c.ob22;
            l_row.nms             := c.nms;
            l_row.ob22 := c.ob22;
            l_row.nms := c.nms;

            insert into deposit_PLT values l_row;
            l_rows:=l_rows+1;

            dbms_application_info.set_client_info(l_trace||to_char(l_rows)|| ' processed');

          exception
            when others then
              l_rows_err:=l_rows_err+1;
              l_errmsg :=substr(l_trace||' Error: '
                                       ||dbms_utility.format_error_stack()||chr(10)
                                       ||dbms_utility.format_error_backtrace()
                                       , 1, 512);
              bars.bars_audit.error(l_errmsg);
          end;
        end loop;

        -- закриті договора
        for c_clos in (with dc as
                       (select MAX (idupd) idupd
                          from bars.dpt_deposit_clos d1
                         where d1.action_id in (1,2) and d1.bdate > trunc(p_dat)-365
                         and   d1.WHEN between trunc(p_dat) and trunc(p_dat)+0.99999
                         and p_periodtype = 'DAY' /*Только для ежедневных выгрузок*/
                         group by d1.deposit_id

                          union

                          select MAX (idupd) idupd
                          from bars.dpt_deposit_clos d1
                         where d1.action_id in (1,2) and d1.bdate > trunc(p_dat)-365
                          and p_periodtype = 'MONTH'
                          group by d1.deposit_id)
         select distinct /*not sure about distinct, temp. solution*/
             d.deposit_id
            ,d.branch
            ,d.kf
            ,d.rnk
            ,d.nd
            ,d.dat_begin
            ,d.dat_end
            ,a.nls
            ,d.vidd
            ,trunc(months_between(d.dat_end,d.dat_begin)) term
            ,a.ostc/100 sdog
            ,a.kv
            ,bars.acrn.fproc(a.acc,sysdate) intrate
            ,d.limit/100 sdog_begin
            ,(select max(fdat)
                     from bars.saldoa s
                    where s.acc = a.acc and s.kos>0) last_dat
            ,(select sum (kos)/100
                     from bars.saldoa s
                    where s.acc = a.acc and fdat =(select max(fdat)
                                                     from bars.saldoa s
                                                    where s.acc = a.acc and s.kos>0)
                                                    ) last_sum
            ,a.ostc/100 ostc
            ,(select sum (kos)/100
                     from bars.saldoa s
                    where s.acc = aproc.acc and fdat between aproc.daos and p_dat) sum_proc
            ,0 suma_proc_plan
            ,d.action_id dpt_status
            ,(select nvl(sum(s)/100,0)
               from bars.saldoa s, bars.opldok d
              where s.acc=d.acc and s.fdat=d.fdat and s.acc = aproc.acc and s.dos>0 and dk=0
                and not exists (select 1 from bars.opldok k where k.ref=d.ref and k.stmt = d.stmt and k.fdat=d.fdat and k.s=d.s and dk=1 and k.acc=a.acc)) suma_proc_payoff
            ,(select max(s.fdat)
               from bars.saldoa s, bars.opldok d
              where s.acc=d.acc and s.fdat=d.fdat and s.acc = aproc.acc and s.dos>0 and dk=0
                and not exists (select 1 from bars.opldok k where k.ref=d.ref and k.stmt = d.stmt and k.fdat=d.fdat and k.s=d.s and dk=1 and k.acc=a.acc)) date_proc_payoff
            ,(select max(fdat)
                     from bars.saldoa s
                    where s.acc = a.acc and s.dos>0) date_dep_payoff
            ,d.datz
            ,a.dazs
            ,a.blkd
            ,a.blkk
            ,d.cnt_dubl
            ,d.archdoc_id
            ,dw.value as ncash                                                                     --нал/безнал
            ,(select cc.NMK from bars.accounts a left join bars.customer cc on a.rnk = cc.rnk where a.ACC = d.ACC_D)  as NAME_D
            ,d.OKPO_D                                                                      --код получателя депозита
            ,d.NLS_D                                                                       --номер счета получателя депозита
            ,d.MFO_D                                                                       --МФО счета получателя депозита
            ,d.NAME_P                                                                      --Получатель %
            ,d.OKPO_P                                                                      --код получателя %
            ,ia.NLSB                                                                       --номер счета получателя %
            ,ia.MFOB                                                                       --МФО счета получателя %
            ,(SELECT max(Ain.NLS) FROM bars.ACCOUNTS ain, bars.dpt_accounts dain, bars.dpt_deposit din
              where ain.acc = dain.accid
               and dain.accid != din.acc
               and dain.dptid = Din.DEPOSIT_ID
               and dain.dptid = d.DEPOSIT_ID
            ) as NLSP --счет % по депозитам
            ,case ddt.TYP_TR when 'M' then 1 end rosp_m  --на імєя малолітньої особи(розпорядник)
            ,case ddt.TYP_TR when 'C' then 1 end mal     --малолітня особа
            ,case ddt.TYP_TR when 'B' then 1 end ben     --бенефіціар
            ,dv.TYPE_NAME vidd_name   --вид вкладу(символьний)
            ,d.wb
            ,a.ob22
            ,a.nms
         from bars.dpt_deposit_clos d, bars.accounts a, bars.int_accn ia, bars.accounts aproc, dc, bars.DPT_DEPOSITW dw, bars.DPT_TRUSTEE ddt, bars.DPT_VIDD dv, bars.customer c
        where d.acc=a.acc and ia.acc=a.acc and ia.acra=aproc.acc
          and d.idupd = dc.idupd
          and d.DEPOSIT_ID = dw.DPT_ID(+)
          and dw.TAG(+) = 'NCASH'
          and d.DEPOSIT_ID = ddt.DPT_ID(+)
          and d.vidd = dv.VIDD(+)
          and d.rnk = c.rnk and c.custtype = 3 and not (C.ise in ('14100', '14200', '14101','14201') and C.sed ='91') --фильтруем ФОПов
          and a.nbs != '2620'
          )
        loop
          begin
            l_row.deposit_id := c_clos.deposit_id;
            l_row.branch := c_clos.branch;
            l_row.kf := c_clos.kf;
            l_row.rnk := c_clos.rnk;
            l_row.nd := c_clos.nd;
            l_row.dat_begin := c_clos.dat_begin;
            l_row.dat_end   := c_clos.dat_end;
            l_row.nls       := c_clos.nls;
            l_row.vidd      := c_clos.vidd;
            l_row.term      := c_clos.term;
            l_row.sdog      := c_clos.sdog;
            l_row.kv        := c_clos.kv;
            l_row.intrate   := c_clos.intrate;
            l_row.sdog_begin := c_clos.sdog_begin;
            l_row.last_add_date := c_clos.last_dat;
            l_row.last_add_suma := c_clos.last_sum;
            l_row.ostc          := c_clos.ostc;
            l_row.suma_proc     := c_clos.sum_proc;
            l_row.suma_proc_plan := c_clos.suma_proc_plan;
            l_row.dpt_status     := c_clos.dpt_status;
            l_row.suma_proc_payoff := c_clos.suma_proc_payoff;
            l_row.date_proc_payoff := c_clos.date_proc_payoff;
            l_row.date_dep_payoff := c_clos.date_dep_payoff;
            l_row.datz            := c_clos.datz;
            l_row.dazs            := c_clos.dazs;
            l_row.blkd            := c_clos.blkd;
            l_row.blkk            := c_clos.blkk;
            l_row.cnt_dubl        := c_clos.cnt_dubl;
            l_row.archdoc_id      := c_clos.archdoc_id;
            l_row.NCASH           := c_clos.ncash;
            l_row.NAME_D          := c_clos.name_d;
            l_row.OKPO_D          := c_clos.okpo_d;
            l_row.NLS_D           := c_clos.nls_d;
            l_row.MFO_D           := c_clos.mfo_d;
            l_row.NAME_P          := c_clos.name_p;
            l_row.OKPO_P          := c_clos.okpo_p;
            l_row.NLSB            := c_clos.nlsb;
            l_row.MFOB            := c_clos.mfob;
            l_row.NLSP            := c_clos.nlsp;
            l_row.ROSP_M          := c_clos.rosp_m;
            l_row.MAL             := c_clos.mal;
            l_row.BEN             := c_clos.ben;
            l_row.VIDD_NAME       := c_clos.vidd_name;
            l_row.MASSA           := null;
            l_row.PER_ID      := l_per_id;
            l_row.wb          := c_clos.wb;
            l_row.ob22            := c_clos.ob22;
            l_row.nms             := c_clos.nms;
            l_row.ob22 := c_clos.ob22;
            l_row.nms := c_clos.nms;
            insert into deposit_PLT values l_row;
            l_rows:=l_rows+1;

            dbms_application_info.set_client_info(l_trace||to_char(l_rows)|| ' processed');

          exception
            when others then
              l_rows_err:=l_rows_err+1;
              l_errmsg :=substr(l_trace||' Error: '
                                       ||dbms_utility.format_error_stack()||chr(10)
                                       ||dbms_utility.format_error_backtrace()
                                       , 1, 512);
              bars.bars_audit.error(l_errmsg);
          end;
        end loop;

        p_rows := l_rows;
        p_rows_err := l_rows_err;
        p_state := 'SUCCESS';
        
        notify_intgr(p_periodtype   => p_periodtype,
                     p_objects_list => bars.varchar2_list('DEPOSITS2'),
                     p_start_time   => l_start_time,
                     p_rows_ok      => l_rows,
                     p_rows_err     => l_rows_err,
                     p_status       => p_state);

        bars.bars_audit.info(l_trace||' deposits count='||l_rows);
        bars.bars_audit.info(l_trace||' finish');

    end deposits_plt_imp;


    --
    -- Расширенная выгрузка БПК
    --
    procedure bpk_plt_imp (p_dat in date default trunc(sysdate), p_periodtype in varchar2 default C_FULLIMP, p_rows out number, p_rows_err out number, p_state out varchar2)
    is
        l_trace  varchar2(500) := G_TRACE||'bpk_plt_imp: ';
        l_per_id periods.id%type;
        l_row    bpk_plt%rowtype;
        l_errmsg varchar2(512);
        l_start_time date := sysdate;

        l_rows     pls_integer := 0;
        l_rows_err pls_integer := 0;

    begin
        bars.bars_audit.info(l_trace||' start');
        -- get period id
        l_per_id := get_period_id (p_periodtype, p_dat);

        if l_per_id is null then
            return;
        end if;

        delete from bpk_plt where per_id=l_per_id;
        -- денні зміни

        l_row.per_id := l_per_id;

        for c in (with dapp as
                 (select a.acc
                    from bars.accounts a
                   where a.dapp=trunc(p_dat)),
                   acupd as
                 (select distinct au.acc as acc
                    from bars.accounts_update au
                   where au.chgdate between trunc(p_dat) and trunc(p_dat)+0.99999),
                   acvive_accounts as
                 (select acc from dapp
                   union
                  select acc from acupd)

                select a.branch      --відділення
                      ,a.kf          --РУ
                      ,a.rnk         --РНК
                      ,w.nd          --Номер договору
                      ,w.dat_begin   --Дата договору
                      ,w.card_code as bpk_type --тип платіжної картки
                      ,a.nls       --номер рахунку
                      ,a.daos      --дата відкриття рахунку
                      ,a.kv        --валюта рахунку
                      ,bars.acrn.fproc (a.acc, p_dat) intrate  --відсоткова ставка
                      ,a.ostc/100 ostc --поточний залишок на рахунку
                      ,(SELECT max(fdat)
                               FROM bars.saldoa s
                              WHERE s.acc = a.acc AND (s.kos+s.dos)>0) date_lastop  --дата останньої операції
                      ,nvl2(w.acc_ovr,1,0) cred_line  --кредитна лінія
                      ,a.lim/100  cred_lim            --сума встановленої кредитної лінії
                      ,abs(ao.ostc/100) use_cred_sum  --використана сума кредитної лінії
                      ,a.dazs           --дата закриття рахунку
                      ,a.blkd           --код блокування рахунку по дебету
                      ,a.blkk           --код блокування рахунку по кредиту
                      ,decode(a.dazs,null,1,0) status_bpk        --статус договору по рахунку(1 - відкритий, 0 - закритий)
                      ,pk_prct.okpo pk_okpo    --зарплатний проект, ЄДРПОУ організації
                      ,pk_prct.name pk_name    --зарплатний проект, назва організації
                      ,pk_prct.okpo_n pk_okpo_n  --зарплатний проект, код організації
                      ,pk_prct.id as pk_oldnd -- номер договора по ЗП ?
                      ,a.VID --????
                      ,ww.lie_sum
                      ,ww.lie_val
                      ,ww.lie_date
                      ,ww.lie_docn
                      ,ww.lie_atrt
                      ,ww.lie_doc
                      ,ww.pk_term
                      ,pk_work
                      ,pk_cntrw
                      ,pk_ofax
                      ,pk_phone
                      ,pk_pcodw
                      ,pk_odat
                      ,pk_strtw
                      ,pk_cityw
                      ,pk_offic
                      ,nvl(d.CLOSE_DATE, d.EXPIRY_DATE) as dkbo_date_off
                      ,d.START_DATE as dkbo_start_date
                      ,d.DEAL_NUMBER as dkbo_deal_number
                      ,s.KOS
                      ,s.DOS
                      ,w4_arsum
                      ,w4_kproc
                      ,w4_sec
                      ,a.acc
                      ,a.ob22
                      ,a.nms
                       from bars.accounts a, bars.accounts ao, bars.w4_acc w, acvive_accounts aa,
                        (select aw.acc, p.id, p.name, p.okpo, p.product_code, p.okpo_n from bars.accountsw aw, bars.bpk_proect p
                          where aw.tag = 'PK_PRCT'
                            and to_number(aw.value)= p.id
                            and regexp_replace(trim(aw.value), '\D') = trim(aw.value)) pk_prct,
                            (select acc,
                              "'LIE_SUM'_CC"  as lie_sum,
                              "'LIE_VAL'_CC"  as lie_val,
                              "'LIE_DATE'_CC"  as lie_date,
                              "'LIE_DOCN'_CC"  as lie_docn,
                              "'LIE_ATRT'_CC"  as lie_atrt,
                              "'LIE_DOC'_CC"  as lie_doc,
                              "'PK_TERM'_CC"  as pk_term,
                              "'PK_WORK'_CC"  as pk_work,
                              "'PK_CNTRW'_CC"  as pk_cntrw,
                              "'PK_OFAX'_CC"  as pk_ofax,
                              "'PK_PHONE'_CC"  as pk_phone,
                              "'PK_PCODW'_CC"  as pk_pcodw,
                              "'PK_ODAT'_CC"  as pk_odat,
                              "'PK_STRTW'_CC"  as pk_strtw,
                              "'PK_CITYW'_CC"  as pk_cityw,
                              "'PK_OFFIC'_CC"  as pk_offic,
                              "'W4_ARSUM'_CC"  as w4_arsum,
                              "'W4_KPROC'_CC"  as w4_kproc,
                              "'W4_SEC'_CC"  as w4_sec
                         from (select w.acc, w.tag, w.value
                                 from bars.accountsw w
                                where tag in ('LIE_SUM','LIE_VAL','LIE_DATE','LIE_DOCN','LIE_ATRT', 'LIE_DOC', 'PK_TERM', 'PK_WORK', 'PK_CNTRW', 'PK_OFAX', 'PK_PHONE', 'PK_PCODW', 'PK_ODAT', 'PK_STRTW', 'PK_CITYW', 'PK_OFFIC', 'W4_ARSUM', 'W4_KPROC', 'W4_SEC')
                              )
                       pivot ( max(value) cc for tag in ('LIE_SUM', 'LIE_VAL', 'LIE_DATE', 'LIE_DOCN', 'LIE_ATRT', 'LIE_DOC', 'PK_TERM', 'PK_WORK', 'PK_CNTRW', 'PK_OFAX', 'PK_PHONE', 'PK_PCODW', 'PK_ODAT', 'PK_STRTW', 'PK_CITYW', 'PK_OFFIC', 'W4_ARSUM', 'W4_KPROC', 'W4_SEC'))
                                             ) ww,
                         bars.deal d,
                         (select acc, kos, dos from bars.saldoa where FDAT = trunc(p_dat)) S
                  where w.acc_pk = a.acc
                   and w.acc_ovr = ao.acc(+)
                   and w.acc_pk = pk_prct.acc(+)
                   and a.acc = aa.acc
                   and p_periodtype = 'DAY' /*Только для ежедневных выгрузок*/
                   and a.ACC = ww.acc(+)
                   and a.RNK = d.CUSTOMER_ID(+)
                   and a.ACC = s.ACC(+)

                   union all

                select a.branch      --відділення
                      ,a.kf          --РУ
                      ,a.rnk         --РНК
                      ,w.nd          --Номер договору
                      ,w.dat_begin   --Дата договору
                      ,w.card_code as bpk_type --тип платіжної картки
                      ,a.nls       --номер рахунку
                      ,a.daos      --дата відкриття рахунку
                      ,a.kv        --валюта рахунку
                      ,bars.acrn.fproc (a.acc, p_dat) intrate  --відсоткова ставка
                      ,a.ostc/100 ostc --поточний залишок на рахунку
                      ,(SELECT max(fdat)
                               FROM bars.saldoa s
                              WHERE s.acc = a.acc AND (s.kos+s.dos)>0) date_lastop  --дата останньої операції
                      ,nvl2(w.acc_ovr,1,0) cred_line  --кредитна лінія
                      ,a.lim/100  cred_lim            --сума встановленої кредитної лінії
                      ,abs(ao.ostc/100) use_cred_sum  --використана сума кредитної лінії
                      ,a.dazs           --дата закриття рахунку
                      ,a.blkd           --код блокування рахунку по дебету
                      ,a.blkk           --код блокування рахунку по кредиту
                      ,decode(a.dazs,null,1,0) status_bpk        --статус договору по рахунку(1 - відкритий, 0 - закритий)
                      ,pk_prct.okpo pk_okpo    --зарплатний проект, ЄДРПОУ організації
                      ,pk_prct.name pk_name    --зарплатний проект, назва організації
                      ,pk_prct.okpo_n pk_okpo_n  --зарплатний проект, код організації
                      ,pk_prct.id as pk_oldnd
                      ,a.VID --????
                      ,ww.lie_sum
                      ,ww.lie_val
                      ,ww.lie_date
                      ,ww.lie_docn
                      ,ww.lie_atrt
                      ,ww.lie_doc
                      ,ww.pk_term
                      ,pk_work
                      ,pk_cntrw
                      ,pk_ofax
                      ,pk_phone
                      ,pk_pcodw
                      ,pk_odat
                      ,pk_strtw
                      ,pk_cityw
                      ,pk_offic
                      ,nvl(d.CLOSE_DATE, d.EXPIRY_DATE) as dkbo_date_off
                      ,d.START_DATE as dkbo_start_date
                      ,d.DEAL_NUMBER as dkbo_deal_number
                      ,s.KOS
                      ,s.DOS
                      ,w4_arsum
                      ,w4_kproc
                      ,w4_sec
                      ,a.acc
                      ,a.ob22
                      ,a.nms
                       from bars.accounts a, bars.accounts ao, bars.w4_acc w/*, acvive_accounts aa*/,
                        (select aw.acc, p.id, p.name, p.okpo, p.product_code, p.okpo_n from bars.accountsw aw, bars.bpk_proect p
                          where aw.tag = 'PK_PRCT'
                            and to_number(aw.value)= p.id
                            and regexp_replace(trim(aw.value), '\D') = trim(aw.value)) pk_prct,
                            (select acc,
                              "'LIE_SUM'_CC"  as lie_sum,
                              "'LIE_VAL'_CC"  as lie_val,
                              "'LIE_DATE'_CC"  as lie_date,
                              "'LIE_DOCN'_CC"  as lie_docn,
                              "'LIE_ATRT'_CC"  as lie_atrt,
                              "'LIE_DOC'_CC"  as lie_doc,
                              "'PK_TERM'_CC"  as pk_term,
                              "'PK_WORK'_CC"  as pk_work,
                              "'PK_CNTRW'_CC"  as pk_cntrw,
                              "'PK_OFAX'_CC"  as pk_ofax,
                              "'PK_PHONE'_CC"  as pk_phone,
                              "'PK_PCODW'_CC"  as pk_pcodw,
                              "'PK_ODAT'_CC"  as pk_odat,
                              "'PK_STRTW'_CC"  as pk_strtw,
                              "'PK_CITYW'_CC"  as pk_cityw,
                              "'PK_OFFIC'_CC"  as pk_offic,
                              "'W4_ARSUM'_CC"  as w4_arsum,
                              "'W4_KPROC'_CC"  as w4_kproc,
                              "'W4_SEC'_CC"  as w4_sec
                         from (select w.acc, w.tag, w.value
                                 from bars.accountsw w
                                where tag in ('LIE_SUM','LIE_VAL','LIE_DATE','LIE_DOCN','LIE_ATRT', 'LIE_DOC', 'PK_TERM', 'PK_WORK', 'PK_CNTRW', 'PK_OFAX', 'PK_PHONE', 'PK_PCODW', 'PK_ODAT', 'PK_STRTW', 'PK_CITYW', 'PK_OFFIC', 'W4_ARSUM', 'W4_KPROC', 'W4_SEC')
                              )
                       pivot ( max(value) cc for tag in ('LIE_SUM', 'LIE_VAL', 'LIE_DATE', 'LIE_DOCN', 'LIE_ATRT', 'LIE_DOC', 'PK_TERM', 'PK_WORK', 'PK_CNTRW', 'PK_OFAX', 'PK_PHONE', 'PK_PCODW', 'PK_ODAT', 'PK_STRTW', 'PK_CITYW', 'PK_OFFIC', 'W4_ARSUM', 'W4_KPROC', 'W4_SEC'))
                                             ) ww,
                         bars.deal d,
                         (select acc, kos, dos from bars.saldoa where FDAT = trunc(p_dat)) S
                  where w.acc_pk = a.acc
                   and w.acc_ovr = ao.acc(+)
                   and w.acc_pk = pk_prct.acc(+)
                   and p_periodtype = 'MONTH' /*Только для ежедневных выгрузок*/
                   and a.ACC = ww.acc(+)
                   and a.RNK = d.CUSTOMER_ID(+)
                   and a.ACC = s.ACC(+)
                   )
        loop
          begin
            l_row.per_id := l_per_id;
            l_row.branch := c.branch;
            l_row.kf := c.kf;
            l_row.rnk := c.rnk;
            l_row.nd := c.nd;
            l_row.dat_begin := c.dat_begin;
            l_row.bpk_type := c.bpk_type;
            l_row.nls := c.nls;
            l_row.daos := c.daos;
            l_row.kv := c.kv;
            l_row.intrate := c.intrate;
            l_row.ostc := c.ostc;
            l_row.date_lastop := c.date_lastop;
            l_row.cred_line := c.cred_line;
            l_row.cred_lim := c.cred_lim;
            l_row.use_cred_sum := c.use_cred_sum;
            l_row.dazs := c.dazs;
            l_row.blkd := c.blkd;
            l_row.blkk := c.blkk;
            l_row.bpk_status := c.status_bpk;
            l_row.pk_okpo := c.pk_okpo;
            l_row.pk_name := c.pk_name;
            l_row.pk_okpo_n := c.pk_okpo_n;
            l_row.VID := c.vid;
            l_row.LIE_SUM := c.lie_sum;
            l_row.LIE_VAL := c.lie_val;
            l_row.LIE_DATE := c.lie_date;
            l_row.LIE_DOCN := c.lie_docn;
            l_row.LIE_ATRT := c.lie_atrt;
            l_row.LIE_DOC := c.lie_doc;
            l_row.PK_TERM := c.pk_term;
            l_row.PK_OLDND := c.pk_oldnd;
            l_row.PK_WORK := c.pk_work;
            l_row.PK_CNTRW := c.pk_cntrw;
            l_row.PK_OFAX := c.pk_ofax;
            l_row.PK_PHONE := c.pk_phone;
            l_row.PK_PCODW := c.pk_pcodw;
            l_row.PK_ODAT := c.pk_odat;
            l_row.PK_STRTW := c.pk_strtw;
            l_row.PK_CITYW := c.pk_cityw;
            l_row.PK_OFFIC := c.pk_offic;
            l_row.DKBO_DATE_OFF := c.dkbo_date_off;
            l_row.DKBO_START_DATE := c.dkbo_start_date;
            l_row.DKBO_DEAL_NUMBER := c.dkbo_deal_number;
            l_row.KOS := c.kos;
            l_row.DOS := c.dos;
            l_row.W4_ARSUM := c.w4_arsum;
            l_row.W4_KPROC := c.w4_kproc;
            l_row.W4_SEC := c.w4_sec;
            l_row.acc := c.acc;
            l_row.ob22 := c.ob22;
            l_row.nms := c.nms;
            insert into bpk_plt values l_row;
            l_rows := l_rows + 1;

            dbms_application_info.set_client_info(l_trace||to_char(l_rows)|| ' processed');

          exception
            when others then
              l_rows_err := l_rows_err + 1;
              l_errmsg :=substr(l_trace||' Error: '
                                       ||dbms_utility.format_error_stack()||chr(10)
                                       ||dbms_utility.format_error_backtrace()
                                       , 1, 512);
              bars.bars_audit.error(l_errmsg);
          end;

        end loop;

        p_rows := l_rows;
        p_rows_err := l_rows_err;
        p_state := 'SUCCESS';
        
        notify_intgr(p_periodtype   => p_periodtype,
                     p_objects_list => bars.varchar2_list('BPK2'),
                     p_start_time   => l_start_time,
                     p_rows_ok      => l_rows,
                     p_rows_err     => l_rows_err,
                     p_status       => p_state);
                     
        bars.bars_audit.info(l_trace||' bpk_plt count='||l_rows);
        bars.bars_audit.info(l_trace||' finish');

    end bpk_plt_imp;



    --
    -- Расширенная выгрузка клиентов-физлиц
    --
    procedure customers_plt_imp(p_dat        in date default trunc(sysdate),
                            p_periodtype in varchar2 default C_FULLIMP,
                            p_rows       out number,
                            p_rows_err   out number,
                            p_state      out varchar2)
    is
        l_trace  varchar2(500) := G_TRACE || 'customers_plt_imp: ';
        l_per_id periods.id%type;
        l_start_time date := sysdate;

        l_rows     pls_integer := 0;
        l_rows_err pls_integer := 0;

        l_insert_target varchar2(4000);
        l_ourmfo       varchar2(6) := sys_context('bars_context', 'user_mfo');

        -- общий запрос
        q_str      clob:='';    --varchar2(32000);
        -- цель для вставки
        q_insert       varchar2(10000);
        -- измененные записи (дельта)
        q_str_inc_pre  varchar2(4000) :=
        'with  c1 as (
                      (select distinct rnk from bars.customer_update cu where cu.custtype = 3 and cu.chgdate between trunc(:p_dat) and trunc(:p_dat)+0.99999)
                   union
                      (select distinct rnk from bars.customerw_update cwu where cwu.chgdate between trunc(:p_dat) and trunc(:p_dat)+0.99999)
                   union
                      (select distinct rnk from bars.customer_address_update cau where cau.effectdate between trunc(:p_dat) and trunc(:p_dat)+0.99999)
                   union
                      (select distinct rnk from bars.person_update pu where  pu.chgdate between trunc(:p_dat) and trunc(:p_dat)+0.99999)
                   union
                      (select distinct rnk from bars.ebkc_gcif ebkg where  ebkg.insert_date between trunc(:p_dat) and trunc(:p_dat)+0.99999)
                     )';
        -- основной запрос
        q_str_main  varchar2(32000) :=
        '
                  select
              null as ID,
              :per_id,
              c.kf kf,
              c.kf ru,
              c.rnk,--РНК
              c.branch,--відділення
              bars.fio(c.nmk,1) as last_name,--прізвище
              bars.fio(c.nmk,2) as first_name,--ім''я
              bars.fio(c.nmk,3) as middle_name,--по-батькові
              decode(to_number(p.sex),1,1,2,2,0) as sex,--стать
              substr(trim(gr),1,30) as gr,--громадянство
              p.bday,--дата народження
              p.passp,--тип документу
              p.ser as ser,--серія
              p.numdoc as numdoc,--номер документу
              p.pdate  as pdate,--дата видачі
              p.organ,--орган видачі
              p.actual_date as passp_expire_to,
              null as pass_to_bank,
              c.okpo  as okpo,--ІНН
              decode(c.date_off, null, ''1'', ''0'') as cust_status,--статус клієнта БАРС
              (select max(rnkto) from bars.rnk2nls r2 where r2.rnkfrom=c.rnk and decode(c.date_off, null, ''1'', ''0'') = ''0'') as cust_active,--РНК активного клієнта
              substr(mpno,1,20) as telm,--мобільний
              p.telw telw,--робочий телефон
              p.teld teld,--домашній телефон
              tel_d as teladd,--додатковий телефон
              substr(email,1,30) as email,--електронна пошта
              ap_contry,
              ap_domain,
              ap_region,
              ap_locality,
              ap_adress,
              ap_zip, /* В adr_fact - адрес регистрации - выгружаем юридический адрес; Место работы - аналогично, т.е. дублируем */
              au_contry,
              au_domain,
              au_region,
              au_locality,
              au_adress,
              au_zip,
              au_contry,
              au_domain,
              au_region,
              au_locality,
              au_adress,
              au_zip,
              null negativ_status,
              null reestr_mob_bank,
              null reestr_inet_bank,
              null reestr_sms_bank,
              null month_income,
              null subject_role,
              decode(c.codcagent,5,1,2) rezident,--резидент
              ww.PC_SS as merried,
                       case
                            when length(w.cigpo)=1
                             and w.cigpo != ''0''
                            then w.cigpo
                            when trim(w.cigpo) is null
                     then ''''
                    else ''9''
               end as emp_status,--статус зайнятості особи"
              decode(to_number(nvl(c.sed, 0)),91,2,34,2,1) as subject_class,--класифікація суб''єкта
              (select prinsiderlv1 from bars.prinsider where prinsider = nvl(c.prinsider,2)) as insider,--признак інсайдера
              decode(vipk,''1'',1,0) vipk,--значення параметру
              (select fio_manager from bars.vip_flags where rnk=c.rnk and mfo = c.kf) vip_fio_manager,--піб працівника по віп
              (select phone_manager from bars.vip_flags where rnk=c.rnk and mfo = c.kf) vip_phone_manager,--телефон працівника по віп
              date_on,--дата відкриття клієнта
              date_off,--дата закриття
              p.eddr_id,
              p.actual_date,
              p.BPLACE,--місце народження
              ww.SUBSD,
              ww.SUBSN,
              ww.ELT_N,
              ww.ELT_D,
              gc.GCIF,
              c.NOMPDV,
              rkv.NOM_DOG,
              ww.SW_RN,
              ww.Y_ELT,
              c.ADM,           --Адм. орган регистрации
              rkv.ADR_ALT,
              ww.BUSSS,
              ww.PC_MF,
              ww.PC_Z4,
              ww.PC_Z3,
              ww.PC_Z5,
              ww.PC_Z2,
              ww.PC_Z1,
              ww.AGENT,
              ww.PC_SS,
              --  ww.STMT, 06.12.2016 [COBUSUPABS-5030]  замена на c.STMT
              c.STMT,  --Формат выписки c.STMT,  --Формат выписки"
              ww.VIDKL,
              c.VED,--Вид экономической деятельности
              ww.TIPA,
              ww.PHKLI,
              ww.AF1_9,
              ww.IDDPD,
              ww.DAIDI,
              ww.DATVR,
              ww.DATZ,
              ww.IDDPL,
              p.DATE_PHOTO,
              ww.IDDPR,
              c.ISE,--Институционный сектор экономики (К070)
              ww.OBSLU,
              ww.CRSRC,
              ww.DJOTH,
              ww.DJAVI,
              ww.DJ_TC,
              ww.DJOWF,
              ww.DJCFI,
              ww.DJ_LN,
              ww.DJ_FH,
              ww.DJ_CP,
              ww.CHORN,
              case c.CRISK when 1 then ''А'' when 2 then ''Б'' when 3 then ''В'' when 4 then ''Г'' end as CRISK_KL,
              case c.BC when 0 then 1 when 1 then 0 end as BC,
              ww.SPMRK,
              ww.K013,
              ww.KODID,
              c.COUNTRY,
              ww.MS_FS,
              ww.MS_VD,
              ww.MS_GR,
              rkv.LIM_KASS,
              c.LIM,
              ww.LICO,
              UADR,
              ww.MOB01,
              ww.MOB02,
              ww.MOB03,
              ww.SUBS,
              c.K050,
              ww.DEATH,
      --      case when p.CELLPHONE is null then 1 else 0 end as NO_PHONE, --mpno?
              nvl2(w.mpno, 0, 1) as NO_PHONE,
              ww.NSMCV,
              ww.NSMCC,
              ww.NSMCT,
              c.NOTES,
              ww.SAMZ,
              ww.OREP,
              ww.OVIFS,
              ww.AF6,
              ww.FSKRK,
              ww.FSOMD,
              ww.FSVED,
              ww.FSZPD,
              ww.FSPOR,
              ww.FSRKZ,
              ww.FSZOP,
              ww.FSKPK,
              ww.FSKPR,
              ww.FSDIB,
              ww.FSCP,
              ww.FSVLZ,
              ww.FSVLA,
              ww.FSVLN,
              ww.FSVLO,
              ww.FSSST,
              ww.FSSOD,
              ww.FSVSN,
              ww.DOV_P,
              ww.DOV_A,
              ww.DOV_F,
              c.NMKV,
              ww.SN_GC,
              c.NMKK,
              c.PRINSIDER,
              c.MB,
              ww.PUBLP,
              ww.WORKB,
              ww.CIGPO,
              cntr.NAME as COUNTRY_NAME,
              ww.TARIF,
              ww.AINAB,
              c.TGR,
              ww.SNSDR,
              ww.IDPIB,
              c.FS,
              ww.DJER,
              ww.SUTD,
              ww.RVDBC,
              ww.RVIBA,
              ww.RVIDT,
              ww.RV_XA,
              ww.RVIBR,
              ww.RVIBB,
              ww.RVRNK,
              ww.RVPH1,
              ww.RVPH2,
              ww.RVPH3,
              c.SAB,
              a.au_contry as j_country,
              a.au_zip as j_zip,
              a.au_domain as j_domain,
              a.au_region as j_region,
              a.au_locality as j_locality,
              a.au_adress as j_address,
              a.j_territory_id,
              a.j_locality_type,
              a.j_street_type,
              a.j_street,
              a.j_home_type,
              a.j_home,
              a.j_homepart_type,
              a.j_homepart,
              a.j_room_type,
              a.j_room,
              a.af_contry as f_country,
              a.af_zip as f_zip,
              a.af_domain as f_domain,
              a.af_region as f_region,
              a.af_locality as f_locality,
              ww.FADR,--адрес временного пребывания
              a.f_territory_id,
              a.f_locality_type,
              a.f_street_type,
              a.f_street,
              a.f_home_type,
              a.f_home,
              a.f_homepart_type,
              a.f_homepart,
              a.f_room_type,
              a.f_room,
              a.ap_contry as p_country,
              a.ap_zip as p_zip,
              a.ap_domain as p_domain,
              a.ap_region as p_region,
              a.ap_locality as p_locality,
              a.ap_adress as p_address,
              a.p_territory_id,
              a.p_locality_type,
              a.p_street_type,
              a.p_street,
              a.p_home_type,
              a.p_home,
              a.p_homepart_type,
              a.p_homepart,
              a.p_room_type,
              a.p_room,
              a.af_adress as f_address,
              c.NOTESEC,
              c.C_REG,
              c.C_DST,
              c.RGADM,
              c.RGTAX,
              c.DATEA,
              c.DATET,
              c.RNKP,
              c.CUSTTYPE,
              ww.RIZIK,
              c.SED,
              c.CODCAGENT,
              a.j_koatuu,
              a.j_region_id,
              a.j_area_id,
              a.j_settlement_id,
              a.j_street_id,
              a.j_house_id,
              a.f_koatuu,
              a.f_region_id,
              a.f_area_id,
              a.f_settlement_id,
              a.f_street_id,
              a.f_house_id,
              a.p_koatuu,
              a.p_region_id,
              a.p_area_id,
              a.p_settlement_id,
              a.p_street_id,
              a.p_house_id,
              (select s.active_directory_name
                 from bars.vip_flags v
                 join bars.staff_ad_user s on v.account_manager = s.user_id
                where rnk=c.rnk and mfo = c.kf) vip_account_manager --аккаунт працівника по віп в форматі АД
                  from bars.customer c, bars.person p,
                         ( select rnk,
                                "''1''_C1" au_contry,
                                "''1''_C2" au_zip,
                                "''1''_C3" au_domain,
                                "''1''_C4" au_region,
                                "''1''_C5" au_locality,
                                "''1''_C6" au_adress,
                                "''1''_C7" j_territory_id,
                                "''1''_C8" j_locality_type,
                                "''1''_C9" j_street_type,
                                "''1''_C10" j_street,
                                "''1''_C11" j_home_type,
                                "''1''_C12" j_home,
                                "''1''_C13" j_homepart_type,
                                "''1''_C14" j_homepart,
                                "''1''_C15" j_room_type,
                                "''1''_C16" j_room,
                                "''1''_C17" j_koatuu,
                                "''1''_C18" j_region_id,
                                "''1''_C19" j_area_id,
                                "''1''_C20" j_settlement_id,
                                "''1''_C21" j_street_id,
                                "''1''_C22" j_house_id,
                                "''2''_C1" af_contry,
                                "''2''_C2" af_zip,
                                "''2''_C3" af_domain,
                                "''2''_C4" af_region,
                                "''2''_C5" af_locality,
                                "''2''_C6" af_adress,
                                "''2''_C7" f_territory_id,
                                "''2''_C8" f_locality_type,
                                "''2''_C9" f_street_type,
                                "''2''_C10" f_street,
                                "''2''_C11" f_home_type,
                                "''2''_C12" f_home,
                                "''2''_C13" f_homepart_type,
                                "''2''_C14" f_homepart,
                                "''2''_C15" f_room_type,
                                "''2''_C16" f_room,
                                "''2''_C17" f_koatuu,
                                "''2''_C18" f_region_id,
                                "''2''_C19" f_area_id,
                                "''2''_C20" f_settlement_id,
                                "''2''_C21" f_street_id,
                                "''2''_C22" f_house_id,
                                "''3''_C1" ap_contry,
                                "''3''_C2" ap_zip,
                                "''3''_C3" ap_domain,
                                "''3''_C4" ap_region,
                                "''3''_C5" ap_locality,
                                "''3''_C6" ap_adress,
                                "''3''_C7" p_territory_id,
                                "''3''_C8" p_locality_type,
                                "''3''_C9" p_street_type,
                                "''3''_C10" p_street,
                                "''3''_C11" p_home_type,
                                "''3''_C12" p_home,
                                "''3''_C13" p_homepart_type,
                                "''3''_C14" p_homepart,
                                "''3''_C15" p_room_type,
                                "''3''_C16" p_room,
                                "''3''_C17" p_koatuu,
                                "''3''_C18" p_region_id,
                                "''3''_C19" p_area_id,
                                "''3''_C20" p_settlement_id,
                                "''3''_C21" p_street_id,
                                "''3''_C22" p_house_id
                           from (select rnk, type_id, country,zip, domain, region, locality, address, territory_id, locality_type, street_type,
                           street, home_type, home, homepart_type, homepart, room_type, room, koatuu, region_id, area_id, settlement_id, street_id, house_id from bars.customer_address)
                          pivot (max(country) c1, max(zip) c2, max(domain) c3, max(region) c4, max(locality) c5, max(address) c6, max(territory_id) c7,
                          max(locality_type) c8, max(street_type) c9, max(street) c10, max(home_type) c11, max(home) c12, max(homepart_type) c13,
                          max(homepart) c14,max(room_type) c15, max(room) c16, max(koatuu) c17, max(region_id) c18, max(area_id) c19, max(settlement_id) c20,
                          max(street_id) c21, max(house_id) c22
                                   for type_id in (''1'', ''2'', ''3'')
                                )
                          ) a,
                             (select rnk,
                                    "''CIGPO''_CC"  as cigpo,
                                    "''EMAIL''_CC"  as email,
                                    "''GR   ''_CC"  as gr,
                                    "''MPNO ''_CC"  as mpno,
                                    "''VIP_K''_CC"  as vipk,
                                    "''TEL_D''_CC"  as tel_d,
                                    "''UADR''_CC"   as UADR
                               from (select w.rnk, tag, value
                                       from bars.customerw w
                                      where tag in (''CIGPO'',''EMAIL'',''GR   '',''MPNO '',''VIP_K'', ''TEL_D'', ''UADR'')
                                    )
                             pivot ( max(value) cc for tag in (''CIGPO'', ''EMAIL'', ''GR   '', ''MPNO '', ''VIP_K'', ''TEL_D'', ''UADR''))
                             ) w
                              ,bars.EBKC_GCIF gc, bars.RNK_REKV rkv, bars.country cntr,
                              (select rnk,
                                      "''SUBSD''_CC" as SUBSD,
                                      "''SUBSN''_CC" as SUBSN,
                                      "''ELT_N''_CC" as ELT_N,
                                      "''ELT_D''_CC" as ELT_D,
                                      "''SW_RN''_CC" as SW_RN,
                                      "''Y_ELT''_CC" as Y_ELT,
                                      "''BUSSS''_CC" as BUSSS,
                                      "''PC_MF''_CC" as PC_MF,
                                      "''PC_Z4''_CC" as PC_Z4,
                                      "''PC_Z3''_CC" as PC_Z3,
                                      "''PC_Z5''_CC" as PC_Z5,
                                      "''PC_Z2''_CC" as PC_Z2,
                                      "''PC_Z1''_CC" as PC_Z1,
                                      "''AGENT''_CC" as AGENT,
                                      "''PC_SS''_CC" as PC_SS,
                                      "''STMT''_CC" as STMT,
                                      "''VIDKL''_CC" as VIDKL,
                                      "''TIPA''_CC" as TIPA,
                                      "''PHKLI''_CC" as PHKLI,
                                      "''AF1_9''_CC" as AF1_9,
                                      "''IDDPD''_CC" as IDDPD,
                                      "''DAIDI''_CC" as DAIDI,
                                      "''DATVR''_CC" as DATVR,
                                      "''DATZ''_CC" as DATZ,
                                      "''IDDPL''_CC" as IDDPL,
                                      "''IDDPR''_CC" as IDDPR,
                                      "''OBSLU''_CC" as OBSLU,
                                      "''CRSRC''_CC" as CRSRC,
                                      "''DJOTH''_CC" as DJOTH,
                                      "''DJAVI''_CC" as DJAVI,
                                      "''DJ_TC''_CC" as DJ_TC,
                                      "''DJOWF''_CC" as DJOWF,
                                      "''DJCFI''_CC" as DJCFI,
                                      "''DJ_LN''_CC" as DJ_LN,
                                      "''DJ_FH''_CC" as DJ_FH,
                                      "''DJ_CP''_CC" as DJ_CP,
                                      "''CHORN''_CC" as CHORN,
                                      "''SPMRK''_CC" as SPMRK,
                                      "''K013''_CC" as K013,
                                      "''KODID''_CC" as KODID,
                                      "''MS_FS''_CC" as MS_FS,
                                      "''MS_VD''_CC" as MS_VD,
                                      "''MS_GR''_CC" as MS_GR,
                                      "''LICO''_CC" as LICO,
                                      "''MOB01''_CC" as MOB01,
                                      "''MOB02''_CC" as MOB02,
                                      "''MOB03''_CC" as MOB03,
                                      "''SUBS''_CC" as SUBS,
                                      "''DEATH''_CC" as DEATH,
                                      "''NSMCV''_CC" as NSMCV,
                                      "''NSMCC''_CC" as NSMCC,
                                      "''NSMCT''_CC" as NSMCT,
                                      "''SAMZ''_CC" as SAMZ,
                                      "''O_REP''_CC" as OREP,
                                      "''OVIFS''_CC" as OVIFS,
                                      "''AF6''_CC" as AF6,
                                      "''FSKRK''_CC" as FSKRK,
                                      "''FSOMD''_CC" as FSOMD,
                                      "''FSVED''_CC" as FSVED,
                                      "''FSZPD''_CC" as FSZPD,
                                      "''FSPOR''_CC" as FSPOR,
                                      "''FSRKZ''_CC" as FSRKZ,
                                      "''FSZOP''_CC" as FSZOP,
                                      "''FSKPK''_CC" as FSKPK,
                                      "''FSKPR''_CC" as FSKPR,
                                      "''FSDIB''_CC" as FSDIB,
                                      "''FSCP''_CC" as FSCP,
                                      "''FSVLZ''_CC" as FSVLZ,
                                      "''FSVLA''_CC" as FSVLA,
                                      "''FSVLN''_CC" as FSVLN,
                                      "''FSVLO''_CC" as FSVLO,
                                      "''FSSST''_CC" as FSSST,
                                      "''FSSOD''_CC" as FSSOD,
                                      "''FSVSN''_CC" as FSVSN,
                                      "''SN_GC''_CC" as SN_GC,
                                      "''PUBLP''_CC" as PUBLP,
                                      "''WORKB''_CC" as WORKB,
                                      "''CIGPO''_CC" as CIGPO,
                                      "''TARIF''_CC" as TARIF,
                                      "''AINAB''_CC" as AINAB,
                                      "''SNSDR''_CC" as SNSDR,
                                      "''IDPIB''_CC" as IDPIB,
                                      "''DJER''_CC" as DJER,
                                      "''SUTD''_CC" as SUTD,
                                      "''RVDBC''_CC" as RVDBC,
                                      "''RVIBA''_CC" as RVIBA,
                                      "''RVIDT''_CC" as RVIDT,
                                      "''RV_XA''_CC" as RV_XA,
                                      "''RVIBR''_CC" as RVIBR,
                                      "''RVIBB''_CC" as RVIBB,
                                      "''RVRNK''_CC" as RVRNK,
                                      "''RVPH1''_CC" as RVPH1,
                                      "''RVPH2''_CC" as RVPH2,
                                      "''RVPH3''_CC" as RVPH3,
                                      "''FADR''_CC" as FADR,
                                      "''RIZIK''_CC" as RIZIK,
                                      "''DOV_P''_CC" as DOV_P,
                                      "''DOV_A''_CC" as DOV_A,
                                      "''DOV_F''_CC" as DOV_F
                               from (select w.rnk, tag, value
                                       from bars.customerw w
                                      where tag in (''SUBSD'',''SUBSN'',''ELT_N'',''ELT_D'',''SW_RN'',''Y_ELT'',''BUSSS'',''PC_MF'',
                                                    ''PC_Z4'',''PC_Z3'',''PC_Z5'',''PC_Z2'',''PC_Z1'',''AGENT'',''PC_SS'',''STMT'',
                                                    ''VIDKL'',''TIPA'',''PHKLI'',''AF1_9'',''IDDPD'',''DAIDI'',''DATVR'',''DATZ'',
                                                    ''IDDPL'',''IDDPR'',''OBSLU'',''CRSRC'',''DJOTH'',''DJAVI'',''DJ_TC'',''DJOWF'',
                                                    ''DJCFI'',''DJ_LN'',''DJ_FH'',''DJ_CP'',''CHORN'',''SPMRK'',''K013'',''KODID'',
                                                    ''MS_FS'',''MS_VD'',''MS_GR'',''LICO'',''MOB01'',''MOB02'',''MOB03'',''SUBS'',
                                                    ''DEATH'',''NSMCV'',''NSMCC'',''NSMCT'',''SAMZ'',''O_REP'',''OVIFS'',''AF6'',
                                                    ''FSKRK'',''FSOMD'',''FSVED'',''FSZPD'',''FSPOR'',''FSRKZ'',''FSZOP'',''FSKPK'',
                                                    ''FSKPR'',''FSDIB'',''FSCP'',''FSVLZ'',''FSVLA'',''FSVLN'',''FSVLO'',''FSSST'',
                                                    ''FSSOD'',''FSVSN'',''SN_GC'',''PUBLP'',''WORKB'',''CIGPO'',''TARIF'',''AINAB'',
                                                    ''SNSDR'',''IDPIB'',''DJER'',''SUTD'',''RVDBC'',''RVIBA'',''RVIDT'',''RV_XA'',
                                                    ''RVIBR'',''RVIBB'',''RVRNK'',''RVPH1'',''RVPH2'',''RVPH3'',''FADR'',''RIZIK'',
                                                    ''DOV_P'', ''DOV_A'', ''DOV_F'')
                                    )
                             pivot ( max(value) cc for tag in (''SUBSD'',''SUBSN'',''ELT_N'',''ELT_D'',''SW_RN'',''Y_ELT'',''BUSSS'',''PC_MF'',
                                                              ''PC_Z4'',''PC_Z3'',''PC_Z5'',''PC_Z2'',''PC_Z1'',''AGENT'',''PC_SS'',''STMT'',
                                                              ''VIDKL'',''TIPA'',''PHKLI'',''AF1_9'',''IDDPD'',''DAIDI'',''DATVR'',''DATZ'',
                                                              ''IDDPL'',''IDDPR'',''OBSLU'',''CRSRC'',''DJOTH'',''DJAVI'',''DJ_TC'',''DJOWF'',
                                                              ''DJCFI'',''DJ_LN'',''DJ_FH'',''DJ_CP'',''CHORN'',''SPMRK'',''K013'',''KODID'',
                                                              ''MS_FS'',''MS_VD'',''MS_GR'',''LICO'',''MOB01'',''MOB02'',''MOB03'',''SUBS'',
                                                              ''DEATH'',''NSMCV'',''NSMCC'',''NSMCT'',''SAMZ'',''O_REP'',''OVIFS'',''AF6'',
                                                              ''FSKRK'',''FSOMD'',''FSVED'',''FSZPD'',''FSPOR'',''FSRKZ'',''FSZOP'',''FSKPK'',
                                                              ''FSKPR'',''FSDIB'',''FSCP'',''FSVLZ'',''FSVLA'',''FSVLN'',''FSVLO'',''FSSST'',
                                                              ''FSSOD'',''FSVSN'',''SN_GC'',''PUBLP'',''WORKB'',''CIGPO'',''TARIF'',''AINAB'',
                                                              ''SNSDR'',''IDPIB'',''DJER'',''SUTD'',''RVDBC'',''RVIBA'',''RVIDT'',''RV_XA'',
                                                              ''RVIBR'',''RVIBB'',''RVRNK'',''RVPH1'',''RVPH2'',''RVPH3'',''FADR'',''RIZIK'',
                                                              ''DOV_P'', ''DOV_A'', ''DOV_F''))
                             ) ww
                             ';

    -- дельта
    q_str_inc_suf  varchar2(4000) :=
             ' ,c1
              where c.custtype=3
                and c.rnk=p.rnk
                and c.COUNTRY = cntr.COUNTRY(+)
                and c.rnk = rkv.RNK(+)
                and c.rnk = gc.RNK(+)
                and c.rnk = a.rnk(+)
                and c.rnk = w.rnk(+)
                and c.rnk = ww.rnk(+)
                and C.RNK = c1.rnk --Только для ежедневных выгрузок
                 ';
    -- полная выгрузка
    q_str_full_suf  varchar2(4000) :=
            ' where c.custtype=3
                and c.rnk=p.rnk
                and c.COUNTRY = cntr.COUNTRY(+)
                and c.rnk = rkv.RNK(+)
                and c.rnk = gc.RNK(+)
                and c.rnk = a.rnk(+)
                and c.rnk = w.rnk(+)
                and c.rnk = ww.rnk(+)
                 ';

    q_log_errors varchar2(4000) := q'[ LOG ERRORS into ERR$_CUSTOMERS_PLT ('INS') reject limit unlimited ]';

          begin
          bars.bars_audit.info(l_trace||' start');
          -- get period id
          l_per_id := get_period_id (p_periodtype, p_dat);

          if l_per_id is null then
            return;
          end if;

          truncate_kf_subpartition('CUSTOMERS_PLT', l_per_id, l_ourmfo);

          -- удаляем данные о предыдущих ошибках периода
          clear_err_log(p_table_name => 'CUSTOMERS_PLT', p_per_id => l_per_id);

          -- e.g. partition (P1164) or subpartition (P1164_KF_300465)
          l_insert_target := case when l_ourmfo is null then 'partition (P'||l_per_id||')' else 'subpartition (P'||l_per_id||'_KF_'||l_ourmfo||')' end;
          bars.bars_audit.info(l_trace||' insert target: '||l_insert_target);

          dbms_application_info.set_client_info('BARS_DM: IMPORT_'||p_periodtype||': CUSTOMERS_PLT '||l_ourmfo);
     begin
          q_insert :=
            q'[
            insert /*+ APPEND */ into CUSTOMERS_PLT ]'||l_insert_target||q'[
            (
              ID,
              PER_ID,
              KF,
              RU,
              RNK,
              BRANCH,
              LAST_NAME,
              FIRST_NAME,
              MIDDLE_NAME,
              SEX,
              GR,
              BDAY,
              PASSP,
              SER,
              NUMDOC,
              PDATE,
              ORGAN,
              PASSP_EXPIRE_TO,
              PASSP_TO_BANK,
              OKPO,
              CUST_STATUS,
              CUST_ACTIVE,
              TELM,
              TELW,
              TELD,
              TELADD,
              EMAIL,
              ADR_POST_COUNTRY,
              ADR_POST_DOMAIN,
              ADR_POST_REGION,
              ADR_POST_LOC,
              ADR_POST_ADR,
              ADR_POST_ZIP,
              ADR_FACT_COUNTRY,
              ADR_FACT_DOMAIN,
              ADR_FACT_REGION,
              ADR_FACT_LOC,
              ADR_FACT_ADR,
              ADR_FACT_ZIP,
              ADR_WORK_COUNTRY,
              ADR_WORK_DOMAIN,
              ADR_WORK_REGION,
              ADR_WORK_LOC,
              ADR_WORK_ADR,
              ADR_WORK_ZIP,
              NEGATIV_STATUS,
              REESTR_MOB_BANK,
              REESTR_INET_BANK,
              REESTR_SMS_BANK,
              MONTH_INCOME,
              SUBJECT_ROLE,
              REZIDENT,
              MERRIED,
              EMP_STATUS,
              SUBJECT_CLASS,
              INSIDER,
              VIPK,
              VIP_FIO_MANAGER,
              VIP_PHONE_MANAGER,
              DATE_ON,
              DATE_OFF,
              EDDR_ID,
              ACTUAL_DATE,
              BPLACE,
              SUBSD,
              SUBSN,
              ELT_N,
              ELT_D,
              GCIF,
              NOMPDV,
              NOM_DOG,
              SW_RN,
              Y_ELT,
              ADM,
              ADR_ALT,
              BUSSS,
              PC_MF,
              PC_Z4,
              PC_Z3,
              PC_Z5,
              PC_Z2,
              PC_Z1,
              AGENT,
              PC_SS,
              STMT,
              VIDKL,
              VED,
              TIPA,
              PHKLI,
              AF1_9,
              IDDPD,
              DAIDI,
              DATVR,
              DATZ,
              IDDPL,
              DATE_PHOTO,
              IDDPR,
              ISE,
              OBSLU,
              CRSRC,
              DJOTH,
              DJAVI,
              DJ_TC,
              DJOWF,
              DJCFI,
              DJ_LN,
              DJ_FH,
              DJ_CP,
              CHORN,
              CRISK_KL,
              BC,
              SPMRK,
              K013,
              KODID,
              COUNTRY,
              MS_FS,
              MS_VD,
              MS_GR,
              LIM_KASS,
              LIM,
              LICO,
              UADR,
              MOB01,
              MOB02,
              MOB03,
              SUBS,
              K050,
              DEATH,
              NO_PHONE,
              NSMCV,
              NSMCC,
              NSMCT,
              NOTES,
              SAMZ,
              OREP,
              OVIFS,
              AF6,
              FSKRK,
              FSOMD,
              FSVED,
              FSZPD,
              FSPOR,
              FSRKZ,
              FSZOP,
              FSKPK,
              FSKPR,
              FSDIB,
              FSCP,
              FSVLZ,
              FSVLA,
              FSVLN,
              FSVLO,
              FSSST,
              FSSOD,
              FSVSN,
              DOV_P,
              DOV_A,
              DOV_F,
              NMKV,
              SN_GC,
              NMKK,
              PRINSIDER,
              MB,
              PUBLP,
              WORKB,
              CIGPO,
              COUNTRY_NAME,
              TARIF,
              AINAB,
              TGR,
              SNSDR,
              IDPIB,
              FS,
              DJER,
              SUTD,
              RVDBC,
              RVIBA,
              RVIDT,
              RV_XA,
              RVIBR,
              RVIBB,
              RVRNK,
              RVPH1,
              RVPH2,
              RVPH3,
              SAB,
              J_COUNTRY,
              J_ZIP,
              J_DOMAIN,
              J_REGION,
              J_LOCALITY,
              J_ADDRESS,
              J_TERRITORY_ID,
              J_LOCALITY_TYPE,
              J_STREET_TYPE,
              J_STREET,
              J_HOME_TYPE,
              J_HOME,
              J_HOMEPART_TYPE,
              J_HOMEPART,
              J_ROOM_TYPE,
              J_ROOM,
              F_COUNTRY,
              F_ZIP,
              F_DOMAIN,
              F_REGION,
              F_LOCALITY,
              FADR,
              F_TERRITORY_ID,
              F_LOCALITY_TYPE,
              F_STREET_TYPE,
              F_STREET,
              F_HOME_TYPE,
              F_HOME,
              F_HOMEPART_TYPE,
              F_HOMEPART,
              F_ROOM_TYPE,
              F_ROOM,
              P_COUNTRY,
              P_ZIP,
              P_DOMAIN,
              P_REGION,
              P_LOCALITY,
              P_ADDRESS,
              P_TERRITORY_ID,
              P_LOCALITY_TYPE,
              P_STREET_TYPE,
              P_STREET,
              P_HOME_TYPE,
              P_HOME,
              P_HOMEPART_TYPE,
              P_HOMEPART,
              P_ROOM_TYPE,
              P_ROOM,
              F_ADDRESS,
              NOTESEC,
              C_REG,
              C_DST,
              RGADM,
              RGTAX,
              DATEA,
              DATET,
              RNKP,
              CUSTTYPE,
              RIZIK,
              SED,
              CODCAGENT,
              J_KOATUU,
              J_REGION_ID,
              J_AREA_ID,
              J_SETTLEMENT_ID,
              J_STREET_ID,
              J_HOUSE_ID,
              F_KOATUU,
              F_REGION_ID,
              F_AREA_ID,
              F_SETTLEMENT_ID,
              F_STREET_ID,
              F_HOUSE_ID,
              P_KOATUU,
              P_REGION_ID,
              P_AREA_ID,
              P_SETTLEMENT_ID,
              P_STREET_ID,
              P_HOUSE_ID,
              VIP_ACCOUNT_MANAGER
            )
            ]';
    if (p_periodtype = C_INCRIMP) then
        /* дельта */
       q_str := q_insert || q_str_inc_pre || q_str_main || q_str_inc_suf || q_log_errors;
       execute immediate q_str using p_dat, p_dat, p_dat, p_dat, p_dat, p_dat, p_dat, p_dat, p_dat, p_dat, l_per_id;
    else
        /* полная выгрузка */
       q_str := q_insert || q_str_main || q_str_full_suf || q_log_errors;
       execute immediate q_str using l_per_id;
            end if;
    l_rows := l_rows + sql%rowcount;
    commit;
          exception
            when others then
            rollback;
            raise;
          end;
            -- считаем кол-во ошибочных строк
        select count(*) into l_rows_err from ERR$_CUSTOMERS_PLT where PER_ID = l_per_id and kf = l_ourmfo;

        p_rows := l_rows;
        p_rows_err := l_rows_err;
        p_state := 'SUCCESS';

        notify_intgr(p_periodtype   => p_periodtype,
                     p_objects_list => bars.varchar2_list('CLIENTFO2', 'CLIENT_ADDRESS'),
                     p_start_time   => l_start_time,
                     p_rows_ok      => l_rows,
                     p_rows_err     => l_rows_err,
                     p_status       => p_state);
                     
        dbms_application_info.set_client_info('');
        bars.bars_audit.info(l_trace||' finish');
    exception
        when others then
            p_state := 'ERROR';
            notify_intgr(p_periodtype   => p_periodtype,
                         p_objects_list => bars.varchar2_list('CLIENTFO2', 'CLIENT_ADDRESS'),
                         p_start_time   => l_start_time,
                         p_rows_ok      => l_rows,
                         p_rows_err     => l_rows_err,
                         p_status       => p_state);
            raise;
    end customers_plt_imp;

    --
    -- выгрузка поручителей / залогодателей по кредитам
    --     МФО;
    --     Вид кредиту;
    --     Номер кредиту;
    --     РНК;
    --     Тип зв’язку (застоводавець/поручитель);
    --     Сума.
    --
    procedure credits_zal_imp ( p_dat in date default trunc(sysdate),
                                p_periodtype in varchar2 default C_FULLIMP,
                                p_rows out number,
                                p_rows_err out number,
                                p_state out varchar2)
    is
        l_trace  varchar2(500) := G_TRACE||'credits_zal_imp: ';
        l_per_id periods.id%type;
        l_errmsg varchar2(512);
        l_ourmfo       varchar2(6) := sys_context('bars_context', 'user_mfo');

        l_rows     pls_integer := 0;
        --l_rows_err pls_integer := 0;

    begin
        bars.bars_audit.info(l_trace||' start');
        -- get period id
        l_per_id := get_period_id (p_periodtype, p_dat);

        if l_per_id is null then
            return;
        end if;
        begin

            delete from credits_zal where per_id=l_per_id and kf = l_ourmfo;
            --
            -- денні зміни

            insert into credits_zal (per_id, kf, nd, vidd_name, rnk, rel_type, zal_sum)
            with changes_ccd as
            (select distinct nd from bars.cc_deal_update c
             where c.EFFECTDATE between trunc(p_dat) and trunc(p_dat)+0.99999), -- изменения по кредитам
                 changes_cc_accp as
            (select distinct acc, nd from bars.cc_accp_update c
             where c.EFFECTDATE between trunc(p_dat) and trunc(p_dat)+0.99999), -- изменения по залогам (связь)
                 changes_acc as
            (select distinct acc from bars.accounts_update c
             where c.EFFECTDATE between trunc(p_dat) and trunc(p_dat)+0.99999
             and exists (select 1 from bars.cc_accp cp where c.acc = cp.acc)) -- изменения по счетам
            select  l_per_id,
                    cd.kf,
                    cd.nd,
                    v.name,
                    a.rnk,
                    case when a.nbs like '95%' then 'заставодавець' when a.nbs like '90%' then 'поручитель' else '' end as rel_type,
                    a.ostb --нужен плановый
            from bars.cc_deal cd
            join bars.cc_vidd v on cd.vidd = v.vidd
            join (select distinct acc, nd from bars.cc_accp) ca on cd.nd = ca.nd
            join bars.accounts a on a.acc = ca.acc
            where
            p_periodtype = 'MONTH'
            or
            p_periodtype = 'DAY'
            -- Згідно заявки COBUMMFO-8186 вибірка за день повинна прцювати,як повне вивантаження
            /*and
            (
                cd.nd in (select nd from changes_ccd)
                or
                (ca.nd, ca.acc) in (select nd, acc from changes_cc_accp)
                or
                a.acc in (select acc from changes_acc)
            )*/
            ;

            l_rows := sql%rowcount;

            dbms_application_info.set_client_info(l_trace||to_char(l_rows)|| ' processed');
            p_state := 'SUCCESS';

     exception
        when others then
          p_state := 'ERROR';
          l_errmsg :=substr(l_trace||' Error: '
                                   ||dbms_utility.format_error_stack()||chr(10)
                                   ||dbms_utility.format_error_backtrace()
                                   , 1, 512);
          bars.bars_audit.error(l_errmsg);
     end;

        p_rows := l_rows;
        p_rows_err := 0;
        bars.bars_audit.info(l_trace||' finish');

    end credits_zal_imp;

    --
    -- Очистка старых данных в витринах
    --
    procedure clear_data (p_dat in date default trunc(sysdate))
    is
        l_periods bars.number_list;

        procedure clear_partition(p_table_name in varchar2, p_periods in bars.number_list)
        is
            partition_doesnt_exist exception;
            pragma exception_init(partition_doesnt_exist, -2149);
            l integer;
        begin
            if (p_periods is not null and p_periods is not empty) then
                execute immediate 'lock table ' || p_table_name || ' in exclusive mode';

                l := p_periods.first;
                while (l is not null) loop
                    begin
                        execute immediate 'alter table ' || p_table_name || ' drop partition for (' || p_periods(l) || ')';
                    exception
                        when partition_doesnt_exist then
                             null;
                    end;
                    l := p_periods.next(l);
                end loop;
            end if;
        end;

    begin

        select p.id
        bulk collect into l_periods
        from   periods p
        where  p.sdate < p_dat - c_cntdays;

        clear_partition('bars_dm.customers_segment', l_periods);
        clear_partition('bars_dm.customers_plt', l_periods);
        clear_partition('bars_dm.credits_stat', l_periods);

        delete from bars_dm.customers c
         where C.PER_ID in (select id from periods p where P.SDATE < p_dat - c_cntdays);
        commit;
        --

        delete from bars_dm.credits_dyn  c
         where C.PER_ID in (select id from periods p where P.SDATE < p_dat - c_cntdays);
        commit;
        --
        delete from bars_dm.deposits   c
         where C.PER_ID in (select id from periods p where P.SDATE < p_dat - c_cntdays);
        commit;
        --
        delete from bars_dm.dm_accounts   c
         where C.PER_ID in (select id from periods p where P.SDATE < p_dat - c_cntdays);
        commit;
        --
        delete from bars_dm.bpk   c
         where C.PER_ID in (select id from periods p where P.SDATE < p_dat - c_cntdays);
        commit;

        delete from bars_dm.bpk_plt   c
         where C.PER_ID in (select id from periods p where P.SDATE < p_dat - c_cntdays);
        commit;
        --
        delete from bars_dm.deposit_plt   c
         where C.PER_ID in (select id from periods p where P.SDATE < p_dat - c_cntdays);
        commit;
        --

        delete from bars_dm.credits_zal   c
         where C.PER_ID in (select id from periods p where P.SDATE < p_dat - c_cntdays);
        commit;

    end clear_data;

    --
    -- Получение периода выгрузки
    --
    function get_period_id (p_period_type in period_type.id%type,
                            p_period_date in date)
    return periods.id%type
    is
        l_id    periods.id%type;
        l_period_date      date;
    begin
        -- якщо час дати періоду попадає в проміжок від 1 сек. до 6 годин
        -- то повертаємо попередній день
        -- якщо передається trunc(), то повертаємо поточний день.
        -- зроблено для коректного періоду у випадку, якщо вигрузка деяких об'єктів
        -- не встигає до 24:00

        l_period_date :=
         case
         when  p_period_date - trunc(p_period_date) between 0.00001 and 0.25
          then p_period_date - 0.24999
         else  p_period_date
        end;

        select p.id
          into l_id
          from periods p
         where p.type = p_period_type
           and trunc(l_period_date) between p.sdate and p.edate;
        return l_id;
       exception
          when no_data_found then
            return(null);
    end get_period_id;

    --
    -- add prefix '38' to phone number
    --

    FUNCTION add38phone (p_phone IN VARCHAR2, p_kf varchar2)
       RETURN VARCHAR2
    IS
       l_phone     VARCHAR2 (20);
       l_phonecode varchar2(3);
    BEGIN
       if p_phone is null then
           return null;
       end if;
       -- видаляємі всі символи, крім цифрових
       l_phone := regexp_replace(p_phone,'[^[[:digit:]]]*');

       IF     LENGTH (l_phone) = 10                     -- довжина 10 символів
          AND SUBSTR (l_phone, 1, 1) = '0'              -- ведучий 0
          AND l_phone != '0000000000'                   -- не всі нулі
       THEN
          l_phone := '38' || l_phone;
       END IF;

       IF     LENGTH (l_phone) = 11                     -- довжина 11 символів
          AND SUBSTR (l_phone, 1, 2) = '80'              -- ведучий 80
          AND l_phone != '00000000000'                   -- не всі нулі
       THEN
          l_phone := '3' || l_phone;
       END IF;

       IF     LENGTH (l_phone) = 7                     -- довжина 7 символів
          AND l_phone != '0000000'                     -- не всі нулі
       THEN
          select max(pcode) into l_phonecode from regions where kf = p_kf;
          l_phone := '38' || l_phonecode || l_phone;
       END IF;

       IF l_phone = '380' THEN l_phone := NULL; END IF;

       RETURN l_phone;
    END add38phone;

    ---
    --- Запуск выгрузки по объекту в контексте указанного МФО (для параллели).
    ---
    procedure imp_run_by_mfo(p_mfo          in     varchar2,
                             p_obj_proc     in     varchar2,
                             p_dat          in     date,
                             p_periodtype   in     varchar2,
                             p_id_event     in     number
                             )
        is
        l_trace  varchar2(500) := G_TRACE||'imp_run_by_mfo: ';
        l_stats_current_row dm_stats%rowtype;
        l_errmsg varchar2(512);
        l_rows_ok number;
        l_rows_err number;
        l_status varchar2(32);
    begin
        -- представляемся и запускаем выгрузку
        bars.bc.go(p_mfo);
        execute immediate 'begin ' || p_obj_proc || '(:p1, :p2, :p3, :p4, :p5); end;'
        using in p_dat, in p_periodtype, in out l_rows_ok, in out l_rows_err, in out l_status;

        commit;

        -- лочим строку статистики и обновляем статус (кроме ERROR) и инкрементно выгруженные строки
        select * into l_stats_current_row from dm_stats where id = p_id_event for update;
        log_stat_event(p_rows_ok    => nvl(l_stats_current_row.rows_ok, 0) + l_rows_ok,
                       p_rows_err   => nvl(l_stats_current_row.rows_err, 0) + l_rows_err,
                       p_status     => case when l_stats_current_row.status in ('ERROR', 'INPROCESS') and l_status != 'ERROR' then l_stats_current_row.status else l_status end,
                       p_id         => l_stats_current_row.id);
    exception
        when others then
            -- лочим строку статистики и ставим статус ошибки
            select * into l_stats_current_row from dm_stats where id = p_id_event for update;
            log_stat_event(p_id => l_stats_current_row.id, p_status => 'ERROR');
            l_errmsg :=substr(l_trace||' Error: '
                                     ||dbms_utility.format_error_stack()||chr(10)
                                     ||dbms_utility.format_error_backtrace()
                                     , 1, 512);
            bars.bars_audit.error(l_errmsg);
    end imp_run_by_mfo;

    --
    -- Общая процедура запуска выгрузки
    --
    procedure imp_run (p_dat in date default sysdate, p_periodtype in varchar2 default C_FULLIMP)
    is
        l_trace  varchar2(500) := G_TRACE||'imp_run: ';
        l_per_id    number;
        l_id_session  number;
        l_id_event  number;
        l_errmsg    varchar2(512);

        -- parallel stuff
        c_task_name  constant varchar2(32) := 'IMP_' || p_periodtype;
        l_chunk_stmt varchar2(128) := q'[select kf as START_ID, kf as END_ID from bars.mv_kf]';
        l_mfo_cnt    number;
        l_task_statement varchar2(4000) := q'[
        begin
            bars_login.login_user(sys_guid, :usr_id, null, null);
            bars.bc.go(:START_ID);
            bars_dm.dm_import.imp_run_by_mfo(p_mfo => to_char(:END_ID),
                                             p_obj_proc => ':obj_proc',
                                             p_dat => to_date(']' || to_char(p_dat, 'dd.mm.yyyy') || q'[', 'dd.mm.yyyy'),
                                             p_periodtype => ']' || p_periodtype || q'[',
                                             p_id_event => :id_event);
            commit;
            bars.bars_login.logout_user;
        end;
        ]';
        l_usr_id number;
        l_final_status varchar2(32);
        task_doesnt_exist exception;
        pragma exception_init(task_doesnt_exist, -29498);
        -- drop task if exists
        procedure drop_import_task
            is
        begin
            DBMS_PARALLEL_EXECUTE.DROP_TASK (c_task_name);
        exception
            when task_doesnt_exist then null;
        end drop_import_task;

    begin
        -- получаем период
        l_per_id := get_period_id (p_periodtype, p_dat);
        -- получаем id сессии
        select nvl(max(id_session),1) + 1 into l_id_session from dm_stats;
        -- получаем число МФО для паралеллизма
        select count(*) into l_mfo_cnt from bars.mv_kf;
        -- кем логинимся
        select id into l_usr_id from bars.staff$base t where t.logname = 'BARS_DM';
        l_task_statement := replace(l_task_statement, ':usr_id', l_usr_id);

        for cur in (select obj_name, obj_proc, parallel_flag from dm_obj where imp_type = p_periodtype and active = 1 order by imp_order)
        loop
            begin
                -- лог начала задачи
                log_stat_event (p_id_session => l_id_session,
                                p_start_time => sysdate,
                                p_stop_time => null,
                                p_obj => cur.obj_name,
                                p_perid => l_per_id,
                                p_rows_ok => null,
                                p_rows_err => null,
                                p_status => 'INPROCESS',
                                p_id => l_id_event );

                if cur.parallel_flag='Y' then
                    -- удаляем предыдущую задачу
                    drop_import_task;
                    dbms_parallel_execute.create_task(c_task_name);
                    -- создаем чанки по МФО
                    dbms_parallel_execute.create_chunks_by_sql(task_name => c_task_name,
                                                               sql_stmt  => l_chunk_stmt,
                                                               by_rowid  => false);
                    -- запуск задачи по всем МФО
                    dbms_parallel_execute.run_task(task_name      => c_task_name,
                                                   sql_stmt       => replace(replace(l_task_statement, ':obj_proc', cur.obj_proc), ':id_event', l_id_event),
                                                   language_flag  => dbms_sql.native,
                                                   parallel_level => l_mfo_cnt + 1);

                else
                    -- запускаем со '/', без параллели
                    imp_run_by_mfo(p_mfo        => '/',
                                   p_obj_proc   => cur.obj_proc,
                                   p_dat        => p_dat,
                                   p_periodtype => p_periodtype,
                                   p_id_event   => l_id_event);
                end if;
                -- лог окончания
                select case when status = 'ERROR' then 'ERROR' else 'SUCCESS' end into l_final_status from dm_stats where id = l_id_event;
                log_stat_event(p_stop_time => sysdate,
                               p_id        => l_id_event,
                               p_status    => l_final_status);
                commit;
            exception
                when others then
                    /* если что-то случилось с паралеллизмом - удаляем задачу и логируем ошибку */
                    drop_import_task;

                    log_stat_event(p_stop_time  => sysdate,
                                   p_status => 'ERROR',
                                   p_id => l_id_event);

                    l_errmsg :=substr(l_trace||' Error: '
                                             ||dbms_utility.format_error_stack()||chr(10)
                                             ||dbms_utility.format_error_backtrace()
                                             , 1, 512);
                    bars.bars_audit.error(l_errmsg);
            end;
            -- обнуляем id выгрузки объекта
            l_id_event := null;
            l_final_status := null;
        end loop;
        
        /* вручную переключаем в интегр. схеме витрину accounts_cash */
        declare
        l_rows_ok number;
        l_start_time date := sysdate;
        begin
            select count(*) into l_rows_ok from bars_intgr.vw_ref_accounts_xrm;
            notify_intgr(p_periodtype   => p_periodtype,
                         p_objects_list => bars.varchar2_list('ACCOUNTS_CASH'),
                         p_start_time   => l_start_time,
                         p_rows_ok      => l_rows_ok,
                         p_rows_err     => 0,
                         p_status       => 'SUCCESS');
        end;

        commit;

    end imp_run;

    --
    -- выгрузка для кредитов по финансовых операциях
    --

    procedure credits_oper_imp  (p_dat in date default trunc(sysdate)
                               , p_periodtype in varchar2 default C_FULLIMP
                               , p_rows out number
                               , p_rows_err out number
                               , p_state out varchar2)
    is
        l_trace  varchar2(500) := G_TRACE||'credits_oper: ';
        l_per_id periods.id%type;

        l_rows     pls_integer := 0;
        l_rows_err pls_integer := 0;

        l_insert_target varchar2(64);
        l_ourmfo       varchar2(6) := sys_context('bars_context', 'user_mfo');
        -- общий запрос
        q_str          varchar2(32000);
        -- цель для вставки
        q_insert       varchar2(4000);
        -- измененные записи (дельта)
        q_str_inc_pre  varchar2(4000) := ' ';
        -- основной запрос
        q_str_main  varchar2(32000) :=
        'select
                :per_id
                ,nd_ac.nd nd_cre
                ,cd.cc_id
                ,cd.vidd
                ,o.kf
                ,o.ref
                ,o.nd
                ,o.mfoa
                ,o.nlsa
                ,o.s
                ,o.kv
                ,o.vdat
                ,o.s2
                ,o.kv2
                ,o.mfob
                ,o.nlsb
                ,o.sk
                ,o.datd
                ,o.nazn
                ,o.tt
                ,o.tobo
                ,o.id_a
                ,o.nam_a
                ,o.id_b
                ,o.nam_b
                ,o.vob
                ,o.pdat
                ,o.odat
            from bars.nd_acc nd_ac, bars.accounts ac, bars.cc_deal cd,bars.oper o
           where nd_ac.acc = ac.acc
             and nd_ac.nd = cd.nd
             and cd.vidd in (1,2,3,11,12,13)
           and ( (o.nlsa = ac.nls and o.kv= ac.kv and o.mfoa = ac.kf)  or (o.nlsb = ac.nls and nvl(o.kv2,o.kv)=ac.kv and o.mfob = ac.kf))
        ';
        -- дельта
        q_str_inc_suf  varchar2(4000) :=
              ' and o.pdat  between trunc(:p_dat) and trunc(:p_dat)+0.99999';
        -- полная выгрузка
        q_str_full_suf  varchar2(4000) :=
              ' and o.pdat  between trunc(:p_dat)-7 and trunc(:p_dat)+0.99999';

        q_log_errors varchar2(4000) := q'[ LOG ERRORS into ERR$_CREDITS_OPER ('INS') reject limit unlimited ]';

    begin
        bars.bars_audit.info(l_trace||' start');
        -- get period id
        l_per_id := get_period_id (p_periodtype, p_dat);

        if l_per_id is null then
            return;
        end if;

        truncate_kf_subpartition('CREDITS_OPER', l_per_id, l_ourmfo);

        -- удаляем данные о предыдущих ошибках периода
        clear_err_log(p_table_name => 'CREDITS_OPER', p_per_id => l_per_id);

        -- e.g. partition (P1164) or subpartition (P1164_KF_300465)
        l_insert_target := case when l_ourmfo is null then 'partition (P'||l_per_id||')' else 'subpartition (P'||l_per_id||'_KF_'||l_ourmfo||')' end;
        bars.bars_audit.info(l_trace||' insert target: '||l_insert_target);

        dbms_application_info.set_client_info('BARS_DM: IMPORT_'||p_periodtype||': CREDITS_OPER '||l_ourmfo);

        begin
            q_insert :=
            q'[
            insert /*+ APPEND */ into CREDITS_OPER ]'||l_insert_target||q'[
            (
                 per_id
                ,nd_cre
                ,cc_id
                ,vidd
                ,kf
                ,ref
                ,nd
                ,mfoa
                ,nlsa
                ,s
                ,kv
                ,vdat
                ,s2
                ,kv2
                ,mfob
                ,nlsb
                ,sk
                ,datd
                ,nazn
                ,tt
                ,tobo
                ,ida
                ,nama
                ,idb
                ,namb
                ,vob
                ,pdat
                ,odat)
            ]';

        if (p_periodtype = C_INCRIMP) then
            /* дельта */
            q_str := q_insert || q_str_inc_pre || q_str_main || q_str_inc_suf || q_log_errors;
            dbms_output.put_line(q_str );
            execute immediate q_str using l_per_id,p_dat, p_dat;
        else
            /* полная выгрузка */
            q_str := q_insert || q_str_main || q_str_full_suf || q_log_errors;
            dbms_output.put_line(q_str );
            execute immediate q_str using l_per_id,p_dat, p_dat;
        end if;

        l_rows := l_rows + sql%rowcount;
        commit;

        exception
            when others then
                rollback;
                raise;
        end;

        -- считаем кол-во ошибочных строк
        select count(*) into l_rows_err from ERR$_CREDITS_OPER where PER_ID = l_per_id;

        p_rows := l_rows;
        p_rows_err := l_rows_err;
        p_state := 'SUCCESS';

        dbms_application_info.set_client_info('');
        bars.bars_audit.info(l_trace||' finish');

    end credits_oper_imp;

    --
    -- выгрузка для депозитов по финансовых операциях
    --

    procedure deposits_oper_imp  (p_dat in date default trunc(sysdate)
                                 ,p_periodtype in varchar2 default C_FULLIMP
                                 ,p_rows out number
                                 ,p_rows_err out number
                                 ,p_state out varchar2)
    is
        l_trace  varchar2(500) := G_TRACE||'deposits_oper_imp: ';
        l_per_id periods.id%type;

        l_rows     pls_integer := 0;
        l_rows_err pls_integer := 0;

        l_insert_target varchar2(64);
        l_ourmfo       varchar2(6) := sys_context('bars_context', 'user_mfo');
        -- общий запрос
        q_str          varchar2(32000);
        -- цель для вставки
        q_insert       varchar2(4000);
        -- измененные записи (дельта)
        q_str_inc_pre  varchar2(4000) := ' ';
        -- основной запрос
        q_str_main  varchar2(32000) :=
        'select
                :per_id
                ,o.kf
                ,dpt_dep.deposit_id
                ,dpt_dep.nd
                ,dpt_dep.cnt_dubl
                ,o.ref
                ,o.nd
                ,o.mfoa
                ,o.nlsa
                ,o.s
                ,o.kv
                ,o.vdat
                ,o.s2
                ,o.kv2
                ,o.mfob
                ,o.nlsb
                ,o.sk
                ,o.datd
                ,o.nazn
                ,o.tt
                ,o.tobo
                ,o.id_a
                ,o.nam_a
                ,o.id_b
                ,o.nam_b
                ,o.vob
                ,o.pdat
                ,o.odat
            from bars.dpt_payments dpt, bars.oper o ,
        ';
        -- дельта
        q_str_inc_suf  varchar2(4000) :=
              'bars.dpt_deposit dpt_dep
               where dpt.ref = o.ref
                 and dpt.dpt_id = dpt_dep.deposit_id
                 and o.pdat  between trunc(:p_dat) and trunc(:p_dat)+0.99999';
        -- полная выгрузка
        q_str_full_suf  varchar2(4000) :=
              '(select dp_d.kf, dp_d.deposit_id, dp_d.cnt_dubl, dp_d.nd
                  from bars.dpt_deposit dp_d
                union
                select distinct dp_c.kf, dp_c.deposit_id, dp_c.cnt_dubl, dp_c.nd
                  from bars.dpt_deposit_clos dp_c
                 where dp_c.dat_end between trunc(:p_dat)-7 and trunc(:p_dat)
                ) dpt_dep
                 where dpt.ref = o.ref
                   and dpt.dpt_id = dpt_dep.deposit_id
                   and o.pdat  between trunc(:p_dat)-7 and trunc(:p_dat)+0.99999';
        q_log_errors varchar2(4000) := q'[ LOG ERRORS into ERR$_DEPOSITS_OPER ('INS') reject limit unlimited ]';
    begin
        bars.bars_audit.info(l_trace||' start');
        -- get period id
        l_per_id := get_period_id (p_periodtype, p_dat);

        if l_per_id is null then
            return;
        end if;

        truncate_kf_subpartition('DEPOSITS_OPER', l_per_id, l_ourmfo);

        -- удаляем данные о предыдущих ошибках периода
        clear_err_log(p_table_name => 'DEPOSITS_OPER', p_per_id => l_per_id);

        -- e.g. partition (P1164) or subpartition (P1164_KF_300465)
        l_insert_target := case when l_ourmfo is null then 'partition (P'||l_per_id||')' else 'subpartition (P'||l_per_id||'_KF_'||l_ourmfo||')' end;
        bars.bars_audit.info(l_trace||' insert target: '||l_insert_target);

        dbms_application_info.set_client_info('BARS_DM: IMPORT_'||p_periodtype||': DEPOSITS_OPER '||l_ourmfo);

        begin
            q_insert :=
            q'[
            insert /*+ APPEND */ into DEPOSITS_OPER ]'||l_insert_target||q'[
            (
                 per_id
                ,kf
                ,deposit_id
                ,nd_dep
                ,cnt_dubl
                ,ref
                ,nd
                ,mfoa
                ,nlsa
                ,s
                ,kv
                ,vdat
                ,s2
                ,kv2
                ,mfob
                ,nlsb
                ,sk
                ,datd
                ,nazn
                ,tt
                ,tobo
                ,ida
                ,nama
                ,idb
                ,namb
                ,vob
                ,pdat
                ,odat)
            ]';

        if (p_periodtype = C_INCRIMP) then
            /* дельта */
            q_str := q_insert || q_str_inc_pre || q_str_main || q_str_inc_suf || q_log_errors;
            dbms_output.put_line(q_str );
            execute immediate q_str using l_per_id,p_dat, p_dat;
        else
            /* полная выгрузка */
            q_str := q_insert || q_str_main || q_str_full_suf || q_log_errors;
            dbms_output.put_line(q_str );
            execute immediate q_str using l_per_id,p_dat, p_dat,p_dat, p_dat;
        end if;

        l_rows := l_rows + sql%rowcount;
        commit;

        exception
            when others then
                rollback;
                raise;
        end;

        -- считаем кол-во ошибочных строк
        select count(*) into l_rows_err from ERR$_DEPOSITS_OPER where PER_ID = l_per_id;

        p_rows := l_rows;
        p_rows_err := l_rows_err;
        p_state := 'SUCCESS';

        dbms_application_info.set_client_info('');
        bars.bars_audit.info(l_trace||' finish');

    end deposits_oper_imp;
end;
/
show err;

grant execute on dm_import to barsupl;
grant execute on dm_import to bars_intgr with grant option;