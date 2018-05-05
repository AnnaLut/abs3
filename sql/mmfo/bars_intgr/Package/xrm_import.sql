prompt package bars_intgr.xrm_import

create or replace package xrm_import
is
    --
    -- Наполнение витрин для псевдо-онлайн выгрузок в CRM
    --
    g_header_version  constant varchar2(64)  := 'version 0.2.0 21/03/2018';

    --
    -- header_version - возвращает версию заголовка пакета
    --
    function header_version return varchar2;

    --
    -- body_version - возвращает версию тела пакета
    --
    function body_version return varchar2;


    function add38phone (p_phone in varchar2, p_kf varchar2 default sys_context('bars_context', 'user_mfo')) return varchar2;

    --
    -- Устанавливает максимальный idupd по таблицам-зависимостям объекта (в случае успешной выгрузки)
    --
    procedure reset_object_idupd(p_object_name varchar2, p_kf varchar2 default sys_context('bars_context', 'user_mfo'));

    --
    -- Очистка витрины для дельты (ежедневная)
    -- p_kf - МФО, для которого очищаем данные; для слэша очищаем витрину полностью
    --
    procedure clear_datamart (p_datamart_name in varchar2, p_kf in varchar2 default sys_context('bars_context', 'user_mfo'));

    --
    -- Очистка всех витрин для дельты (ежедневная)
    -- p_kf - МФО, для которого очищаем данные; для слэша очищаем витрины полностью
    --
    procedure clear_datamarts(p_kf in varchar2 default sys_context('bars_context', 'user_mfo'));

    --
    -- Выгрузка CLIENTFO2 - физические лица
    --
    procedure import_clientfo2 (p_rows_ok  out number,
                                p_rows_err out number,
                                p_status   out varchar2);

    procedure import_client_address;

    ---
    --- Запуск выгрузки по объекту в контексте указанного МФО (для параллели).
    ---
    procedure imp_run_by_mfo(p_mfo          in     varchar2,
                             p_object_proc  in     varchar2,
                             p_id_event     in     number);
    --
    -- Общая процедура запуска выгрузки
    --
    procedure imp_run;

end xrm_import;
/
show errors;

create or replace package body xrm_import
is
    g_body_version constant varchar2(64) := 'Version 0.2.0 21/03/2018';
    G_TRACE        constant varchar2(20) := 'xrm_import.';
    G_IS_MMFO      constant number(1)    := 1;

    /** header_version -  */
    function header_version return varchar2 is
    begin
        return 'Package header xrm_import ' || g_header_version;
    end header_version;

    /** body_version -  */
    function body_version return varchar2 is
    begin
        return 'Package body xrm_import ' || g_body_version;
    end body_version;

    --
    -- Логгирование статистики
    -- Не автономная транзакция, чтобы не было проблем с параллелью
    --
    procedure log_stat_event(p_changenumber number   default null,
                             p_start_time   date     default null,
                             p_stop_time    date     default null,
                             p_object_name  varchar2 default null,
                             p_rows_ok      number   default null,
                             p_rows_err     number   default null,
                             p_status       varchar2 default null,
                             p_id    in out number) is
    begin
        if (p_id is null) then
            insert into bars_intgr.intgr_stats
              (id,
               changenumber,
               object_name,
               start_time,
               stop_time,
               rows_ok,
               rows_err,
               status)
            values
              (s_stats.nextval,
               p_changenumber,
               p_object_name,
               p_start_time,
               p_stop_time,
               p_rows_ok,
               p_rows_err,
               p_status)
            returning id into p_id;
        else
            update bars_intgr.intgr_stats
               set stop_time = nvl(p_stop_time, stop_time),
                   rows_ok   = nvl(p_rows_ok, rows_ok),
                   rows_err  = nvl(p_rows_err, rows_err),
                   status    = nvl(p_status, status)
            where id = p_id;
        end if;

        commit;
    end log_stat_event;

    --
    -- Возвращает список ключей (измененных записей) для дельты; не поддерживает составные ключи
    --
    function get_changed_keys (p_object_name varchar2,
                               p_kf varchar2 default sys_context('bars_context', 'user_mfo'))
    return bars.number_list
    is
    l_trace varchar2(150) := g_trace || 'get_changed_keys: ';
    l_keys bars.number_list;
    l_sql clob;
    begin
        bars.bars_audit.info(l_trace||'start.');
        -- конструируем запрос
        select listagg ('select distinct '||key_column||' from bars.'||table_name||' where idupd>='||idupd||case when sql_predicate is not null then ' and '||sql_predicate end,
               ' union ' )
               within group (order by 1) q
        into l_sql
        from imp_object_dependency
        where kf = p_kf
        and object_name = p_object_name;
        bars.bars_audit.info(l_trace||'prepared sql = ['||l_sql||']');

        execute immediate l_sql bulk collect into l_keys;
        bars.bars_audit.info(l_trace||'finish');
        return l_keys;
    end get_changed_keys;

    --
    -- Инкрементирует и возвращает номер дельты в разрезе объекта и МФО; для слэша инкрементим все и возвращаем максимальный
    --
    function increment_object_changenumber(p_object_name varchar2,
                                           p_kf varchar2 default sys_context('bars_context', 'user_mfo'))
    return number
    is
    l_ret number;
    begin
        update imp_object_mfo
        set changenumber = changenumber + 1
        where object_name = p_object_name
        and kf = nvl(p_kf, kf)
        returning max(changenumber) into l_ret;
        return l_ret;
    end increment_object_changenumber;

    --
    -- Устанавливает максимальный idupd по таблицам-зависимостям объекта (в случае успешной выгрузки)
    --
    procedure reset_object_idupd(p_object_name varchar2, p_kf varchar2 default sys_context('bars_context', 'user_mfo'))
        is
    l_max_idupd number;
    begin
        for rec in (select table_name from imp_object_dependency where kf = p_kf)
        loop
            -- e.g. "select max(idupd) from bars.customer_update where kf = 300465"
            execute immediate 'select max(idupd) from bars.'||rec.table_name||case when G_IS_MMFO = 1 then ' where kf = '||p_kf else '' end into l_max_idupd;

            update imp_object_dependency
            set idupd = l_max_idupd
            where object_name = p_object_name
            and table_name = rec.table_name
            and kf = p_kf;
        end loop;
    end reset_object_idupd;

    --
    -- Очистка витрины для дельты (ежедневная)
    -- p_kf - МФО, для которого очищаем данные; для слэша очищаем витрину полностью
    --
    procedure clear_datamart (p_datamart_name in varchar2, p_kf in varchar2 default sys_context('bars_context', 'user_mfo'))
        is
    l_trace varchar2(150) := g_trace || 'clear_datamart['||p_datamart_name||']: ';
    resourse_busy exception;
    pragma exception_init(resourse_busy, -54);
    begin
        if p_kf is null then
            execute immediate 'truncate table bars_intgr.'||p_datamart_name;
        else
            execute immediate 'alter table bars_intgr.'||p_datamart_name||' truncate partition for ('''||p_kf||''')';
        end if;
    exception
        when resourse_busy then
            bars.bars_audit.error(l_trace || 'resourse busy; очистим в следующий раз');
    end clear_datamart;

    --
    -- Очистка всех витрин для дельты (ежедневная)
    -- p_kf - МФО, для которого очищаем данные; для слэша очищаем витрины полностью
    --
    procedure clear_datamarts(p_kf in varchar2 default sys_context('bars_context', 'user_mfo'))
        is
    begin
        for rec in (select * from imp_object)
        loop
            clear_datamart(rec.object_name, p_kf);
        end loop;
    end clear_datamarts;

    --
    -- add prefix '38' to phone number
    --
    function add38phone (p_phone in varchar2, p_kf varchar2 default sys_context('bars_context', 'user_mfo'))
       return varchar2
    is
       l_phone     varchar2 (20);
       l_phonecode varchar2(3);
    begin
       if p_phone is null then
           return null;
       end if;
       -- видаляємі всі символи, крім цифрових
       l_phone := regexp_replace(p_phone,'[^[[:digit:]]]*');
       if     length (l_phone) = 10                     -- довжина 10 символів
          and substr (l_phone, 1, 1) = '0'              -- ведучий 0
          and l_phone != '0000000000'                   -- не всі нулі
       then
          l_phone := '38' || l_phone;
       end if;
       if     length (l_phone) = 11                     -- довжина 11 символів
          and substr (l_phone, 1, 2) = '80'              -- ведучий 80
          and l_phone != '00000000000'                   -- не всі нулі
       then
          l_phone := '3' || l_phone;
       end if;
       if     length (l_phone) = 7                     -- довжина 7 символів
          and l_phone != '0000000'                     -- не всі нулі
       then
          select max(pcode) into l_phonecode from bars_dm.regions where kf = p_kf; /*test*/
          l_phone := '38' || l_phonecode || l_phone;
       end if;
       if l_phone = '380' then l_phone := null; end if;
       return l_phone;
    exception
        when no_data_found then
            return l_phone;
    end add38phone;

    --
    -- Выгрузка CLIENTFO2 - физические лица
    --
    procedure import_clientfo2 (p_rows_ok  out number,
                                p_rows_err out number,
                                p_status   out varchar2)
        is
    c_object_name  constant varchar2(32) := 'CLIENTFO2';
    l_changenumber number;

    l_changelist bars.number_list;

    l_test_log varchar2(4000);
    begin
        bars.bars_audit.info(g_trace||' clientfo_imp start');

        /* собираем измененные записи */
        l_changelist := get_changed_keys(c_object_name);

        bars.bars_audit.info(g_trace||c_object_name||': finished collecting rnk: '||l_changelist.count);

        savepoint imp_start;

        select listagg(column_value, ',') within group (order by 1) into l_test_log from table(l_changelist) where rownum <= 15;
        bars.bars_audit.info(g_trace||c_object_name||': rnks:'||substr(l_test_log, 1, 150));

        l_changenumber := increment_object_changenumber(c_object_name);

        /* выгрузка */

        merge into clientfo2 C
        using (
                with delta as (select /*+ materialize*/ column_value as rnk from table(l_changelist))
                  select l_changenumber as changenumber,
                       c.rnk,--РНК
                       c.branch,--відділення
                       c.kf,
                       bars.fio(c.nmk,1) as last_name,--прізвище
                       bars.fio(c.nmk,2) as first_name,--ім'я
                       bars.fio(c.nmk,3) as middle_name,--по-батькові
                       substr(trim(gr),1,30) as gr,--громадянство
                       p.bday,--дата народження
                       p.passp,--тип документу
                       p.ser as ser,--серія
                       p.numdoc as numdoc,--номер документу
                       p.pdate  as pdate,--дата видачі
                       p.organ,--орган видачі
                       c.okpo  as okpo,--ІНН
                       xrm_import.add38phone(substr(mpno,1,20), c.kf) as telm,--мобільний
                       xrm_import.add38phone(p.teld, c.kf) teld,--домашній телефон
                       xrm_import.add38phone(p.telw, c.kf) telw,--робочий телефон
                       tel_d as teladd,--додатковий телефон
                       substr(email,1,30) as email,--електронна пошта
                       au_country,
                       au_domain,
                       au_region,
                       au_locality,
                       au_adress,
                       au_zip,
                       ap_country,
                       ap_domain,
                       ap_region,
                       ap_locality,
                       ap_adress,
                       ap_zip,
                       af_country,
                       af_domain,
                       af_region,
                       af_locality,
                       af_adress,
                       af_zip,
                       decode(c.date_off, null, '1', '0') as cust_status,--статус клієнта БАРС
                       (select max(rnkto) from bars.rnk2nls r2 where r2.rnkfrom=c.rnk and decode(c.date_off, null, '1', '0') = '0') as cust_active,--РНК активного клієнта
                       decode(c.codcagent,5,1,2) rezident,--резидент
                       decode(to_number(nvl(c.sed, 0)),91,2,34,2,1) as subject_class,--класифікація суб'єкта
                       case
                            when length(trim(w.cigpo))=1
                                and regexp_replace(trim(w.cigpo), '\D') = trim(w.cigpo)
                                and trim(w.cigpo) != '0'
                             then trim(w.cigpo)
                            when trim(w.cigpo) is null
                             then ''
                            else '9'
                       end as emp_status,--статус зайнятості особи
                       decode(to_number(p.sex),1,1,2,2,0) as sex,--стать
                       (select prinsiderlv1 from bars.prinsider where prinsider = nvl(c.prinsider,2)) as insider,--признак інсайдера
                       decode(vipk,'1',1,0) vipk,--значення параметру
                       (select max(fio_manager) from bars.vip_flags where rnk=c.rnk) vip_fio_manager,--піб працівника по віп
                       (select max(phone_manager) from bars.vip_flags where rnk=c.rnk) vip_phone_manager,--телефон працівника по віп
                       (select s.active_directory_name
                        from bars.vip_flags v
                        join bars.staff_ad_user s on v.account_manager = s.user_id
                        where rnk=c.rnk) vip_account_manager,--аккаунт працівника по віп в форматі АД
                       date_on,--дата відкриття клієнта
                       date_off,--дата закриття
                       p.eddr_id,
                       p.BPLACE,--місце народження
                       p.actual_date,
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
                       ww.FADR,--адрес временного пребывания
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
--                       ww.STMT, 06.12.2016 [COBUSUPABS-5030]  замена на c.STMT
                       c.STMT,  --Формат выписки
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
                       case c.CRISK when 1 then 'А' when 2 then 'Б' when 3 then 'В' when 4 then 'Г' end as CRISK_KL,
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
                       c.NOTESEC,
                       c.MB,
                       ww.PUBLP,
                       ww.WORKB,
                       c.C_REG,
                       c.C_DST,
                       c.RGADM,
                       c.RGTAX,
                       c.DATEA,
                       c.DATET,
                       c.RNKP,
                       ww.CIGPO,
                       cntr.NAME as COUNTRY_NAME,
                       ww.TARIF,
                       ww.AINAB,
                       c.TGR,
                       c.CUSTTYPE,
                       ww.RIZIK,
                       ww.SNSDR,
                       ww.IDPIB,
                       c.FS,
                       c.SED,
                       ww.DJER,
                       c.CODCAGENT,
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
                       a.au_country as j_country,
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
                       a.j_koatuu,
                       a.j_region_id,
                       a.j_area_id,
                       a.j_settlement_id,
                       a.j_street_id,
                       a.j_house_id,
                       a.af_country as f_country,
                       a.af_zip as f_zip,
                       a.af_domain as f_domain,
                       a.af_region as f_region,
                       a.af_locality as f_locality,
                       a.af_adress as f_address,
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
                       a.f_koatuu,
                       a.f_region_id,
                       a.f_area_id,
                       a.f_settlement_id,
                       a.f_street_id,
                       a.f_house_id,
                       a.ap_country as p_country,
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
                       a.p_koatuu,
                       a.p_region_id,
                       a.p_area_id,
                       a.p_settlement_id,
                       a.p_street_id,
                       a.p_house_id
                  from bars.customer c, bars.person p,
                         ( select rnk,
                                "'1'_C1" au_country,
                                "'1'_C2" au_zip,
                                "'1'_C3" au_domain,
                                "'1'_C4" au_region,
                                "'1'_C5" au_locality,
                                "'1'_C6" au_adress,
                                "'1'_C7" j_territory_id,
                                "'1'_C8" j_locality_type,
                                "'1'_C9" j_street_type,
                                "'1'_C10" j_street,
                                "'1'_C11" j_home_type,
                                "'1'_C12" j_home,
                                "'1'_C13" j_homepart_type,
                                "'1'_C14" j_homepart,
                                "'1'_C15" j_room_type,
                                "'1'_C16" j_room,
                                "'1'_C17" j_koatuu,
                                "'1'_C18" j_region_id,
                                "'1'_C19" j_area_id,
                                "'1'_C20" j_settlement_id,
                                "'1'_C21" j_street_id,
                                "'1'_C22" j_house_id,
                                "'2'_C1" af_country,
                                "'2'_C2" af_zip,
                                "'2'_C3" af_domain,
                                "'2'_C4" af_region,
                                "'2'_C5" af_locality,
                                "'2'_C6" af_adress,
                                "'2'_C7" f_territory_id,
                                "'2'_C8" f_locality_type,
                                "'2'_C9" f_street_type,
                                "'2'_C10" f_street,
                                "'2'_C11" f_home_type,
                                "'2'_C12" f_home,
                                "'2'_C13" f_homepart_type,
                                "'2'_C14" f_homepart,
                                "'2'_C15" f_room_type,
                                "'2'_C16" f_room,
                                "'2'_C17" f_koatuu,
                                "'2'_C18" f_region_id,
                                "'2'_C19" f_area_id,
                                "'2'_C20" f_settlement_id,
                                "'2'_C21" f_street_id,
                                "'2'_C22" f_house_id,
                                "'3'_C1" ap_country,
                                "'3'_C2" ap_zip,
                                "'3'_C3" ap_domain,
                                "'3'_C4" ap_region,
                                "'3'_C5" ap_locality,
                                "'3'_C6" ap_adress,
                                "'3'_C7" p_territory_id,
                                "'3'_C8" p_locality_type,
                                "'3'_C9" p_street_type,
                                "'3'_C10" p_street,
                                "'3'_C11" p_home_type,
                                "'3'_C12" p_home,
                                "'3'_C13" p_homepart_type,
                                "'3'_C14" p_homepart,
                                "'3'_C15" p_room_type,
                                "'3'_C16" p_room,
                                "'3'_C17" p_koatuu,
                                "'3'_C18" p_region_id,
                                "'3'_C19" p_area_id,
                                "'3'_C20" p_settlement_id,
                                "'3'_C21" p_street_id,
                                "'3'_C22" p_house_id
                           from (select bars.customer_address.rnk, type_id, country,zip, domain, region, locality, address, territory_id, locality_type, street_type,
                                   street, home_type, home, homepart_type, homepart, room_type, room, koatuu, region_id, area_id, settlement_id, street_id, house_id 
                                   from bars.customer_address
                                   join delta on bars.customer_address.rnk = delta.rnk)
                          pivot (max(country) c1, max(zip) c2, max(domain) c3, max(region) c4, max(locality) c5, max(address) c6, max(territory_id) c7,
                          max(locality_type) c8, max(street_type) c9, max(street) c10, max(home_type) c11, max(home) c12, max(homepart_type) c13,
                          max(homepart) c14,max(room_type) c15, max(room) c16, max(koatuu) c17, max(region_id) c18, max(area_id) c19, max(settlement_id) c20,
                          max(street_id) c21, max(house_id) c22
                                   for type_id in ('1', '2', '3')
                                )
                          ) a,
                             (select rnk,
                                    "'CIGPO'_CC"  as cigpo,
                                    "'EMAIL'_CC"  as email,
                                    "'GR   '_CC"  as gr,
                                    "'MPNO '_CC"  as mpno,
                                    "'VIP_K'_CC"  as vipk,
                                    "'TEL_D'_CC"  as tel_d,
                                    "'UADR'_CC"   as UADR
                               from (select w.rnk, tag, value
                                       from bars.customerw w
                                       join delta on w.rnk = delta.rnk
                                      where tag in ('CIGPO','EMAIL','GR   ','MPNO ','VIP_K', 'TEL_D', 'UADR')
                                    )
                             pivot ( max(value) cc for tag in ('CIGPO', 'EMAIL', 'GR   ', 'MPNO ', 'VIP_K', 'TEL_D', 'UADR'))
                             ) w
                              , delta, bars.EBKC_GCIF gc, bars.RNK_REKV rkv, bars.country cntr,
                              (select rnk,
                                      "'SUBSD'_CC" as SUBSD,
                                      "'SUBSN'_CC" as SUBSN,
                                      "'ELT_N'_CC" as ELT_N,
                                      "'ELT_D'_CC" as ELT_D,
                                      "'SW_RN'_CC" as SW_RN,
                                      "'Y_ELT'_CC" as Y_ELT,
                                      "'BUSSS'_CC" as BUSSS,
                                      "'PC_MF'_CC" as PC_MF,
                                      "'PC_Z4'_CC" as PC_Z4,
                                      "'PC_Z3'_CC" as PC_Z3,
                                      "'PC_Z5'_CC" as PC_Z5,
                                      "'PC_Z2'_CC" as PC_Z2,
                                      "'PC_Z1'_CC" as PC_Z1,
                                      "'AGENT'_CC" as AGENT,
                                      "'PC_SS'_CC" as PC_SS,
                                      "'STMT'_CC" as STMT,
                                      "'VIDKL'_CC" as VIDKL,
                                      "'TIPA'_CC" as TIPA,
                                      "'PHKLI'_CC" as PHKLI,
                                      "'AF1_9'_CC" as AF1_9,
                                      "'IDDPD'_CC" as IDDPD,
                                      "'DAIDI'_CC" as DAIDI,
                                      "'DATVR'_CC" as DATVR,
                                      "'DATZ'_CC" as DATZ,
                                      "'IDDPL'_CC" as IDDPL,
                                      "'IDDPR'_CC" as IDDPR,
                                      "'OBSLU'_CC" as OBSLU,
                                      "'CRSRC'_CC" as CRSRC,
                                      "'DJOTH'_CC" as DJOTH,
                                      "'DJAVI'_CC" as DJAVI,
                                      "'DJ_TC'_CC" as DJ_TC,
                                      "'DJOWF'_CC" as DJOWF,
                                      "'DJCFI'_CC" as DJCFI,
                                      "'DJ_LN'_CC" as DJ_LN,
                                      "'DJ_FH'_CC" as DJ_FH,
                                      "'DJ_CP'_CC" as DJ_CP,
                                      "'CHORN'_CC" as CHORN,
                                      "'SPMRK'_CC" as SPMRK,
                                      "'K013'_CC" as K013,
                                      "'KODID'_CC" as KODID,
                                      "'MS_FS'_CC" as MS_FS,
                                      "'MS_VD'_CC" as MS_VD,
                                      "'MS_GR'_CC" as MS_GR,
                                      "'LICO'_CC" as LICO,
                                      "'MOB01'_CC" as MOB01,
                                      "'MOB02'_CC" as MOB02,
                                      "'MOB03'_CC" as MOB03,
                                      "'SUBS'_CC" as SUBS,
                                      "'DEATH'_CC" as DEATH,
                                      "'NSMCV'_CC" as NSMCV,
                                      "'NSMCC'_CC" as NSMCC,
                                      "'NSMCT'_CC" as NSMCT,
                                      "'SAMZ'_CC" as SAMZ,
                                      "'O_REP'_CC" as OREP,
                                      "'OVIFS'_CC" as OVIFS,
                                      "'AF6'_CC" as AF6,
                                      "'FSKRK'_CC" as FSKRK,
                                      "'FSOMD'_CC" as FSOMD,
                                      "'FSVED'_CC" as FSVED,
                                      "'FSZPD'_CC" as FSZPD,
                                      "'FSPOR'_CC" as FSPOR,
                                      "'FSRKZ'_CC" as FSRKZ,
                                      "'FSZOP'_CC" as FSZOP,
                                      "'FSKPK'_CC" as FSKPK,
                                      "'FSKPR'_CC" as FSKPR,
                                      "'FSDIB'_CC" as FSDIB,
                                      "'FSCP'_CC" as FSCP,
                                      "'FSVLZ'_CC" as FSVLZ,
                                      "'FSVLA'_CC" as FSVLA,
                                      "'FSVLN'_CC" as FSVLN,
                                      "'FSVLO'_CC" as FSVLO,
                                      "'FSSST'_CC" as FSSST,
                                      "'FSSOD'_CC" as FSSOD,
                                      "'FSVSN'_CC" as FSVSN,
                                      "'SN_GC'_CC" as SN_GC,
                                      "'PUBLP'_CC" as PUBLP,
                                      "'WORKB'_CC" as WORKB,
                                      "'CIGPO'_CC" as CIGPO,
                                      "'TARIF'_CC" as TARIF,
                                      "'AINAB'_CC" as AINAB,
                                      "'SNSDR'_CC" as SNSDR,
                                      "'IDPIB'_CC" as IDPIB,
                                      "'DJER'_CC" as DJER,
                                      "'SUTD'_CC" as SUTD,
                                      "'RVDBC'_CC" as RVDBC,
                                      "'RVIBA'_CC" as RVIBA,
                                      "'RVIDT'_CC" as RVIDT,
                                      "'RV_XA'_CC" as RV_XA,
                                      "'RVIBR'_CC" as RVIBR,
                                      "'RVIBB'_CC" as RVIBB,
                                      "'RVRNK'_CC" as RVRNK,
                                      "'RVPH1'_CC" as RVPH1,
                                      "'RVPH2'_CC" as RVPH2,
                                      "'RVPH3'_CC" as RVPH3,
                                      "'FADR'_CC" as FADR,
                                      "'RIZIK'_CC" as RIZIK,
                                      "'DOV_P'_CC" as DOV_P,
                                      "'DOV_A'_CC" as DOV_A,
                                      "'DOV_F'_CC" as DOV_F
                               from (select w.rnk, tag, value
                                       from bars.customerw w
                                       join delta on w.rnk = delta.rnk
                                      where tag in ('SUBSD','SUBSN','ELT_N','ELT_D','SW_RN','Y_ELT','BUSSS','PC_MF',
                                                    'PC_Z4','PC_Z3','PC_Z5','PC_Z2','PC_Z1','AGENT','PC_SS','STMT',
                                                    'VIDKL','TIPA','PHKLI','AF1_9','IDDPD','DAIDI','DATVR','DATZ',
                                                    'IDDPL','IDDPR','OBSLU','CRSRC','DJOTH','DJAVI','DJ_TC','DJOWF',
                                                    'DJCFI','DJ_LN','DJ_FH','DJ_CP','CHORN','SPMRK','K013','KODID',
                                                    'MS_FS','MS_VD','MS_GR','LICO','MOB01','MOB02','MOB03','SUBS',
                                                    'DEATH','NSMCV','NSMCC','NSMCT','SAMZ','O_REP','OVIFS','AF6',
                                                    'FSKRK','FSOMD','FSVED','FSZPD','FSPOR','FSRKZ','FSZOP','FSKPK',
                                                    'FSKPR','FSDIB','FSCP','FSVLZ','FSVLA','FSVLN','FSVLO','FSSST',
                                                    'FSSOD','FSVSN','SN_GC','PUBLP','WORKB','CIGPO','TARIF','AINAB',
                                                    'SNSDR','IDPIB','DJER','SUTD','RVDBC','RVIBA','RVIDT','RV_XA',
                                                    'RVIBR','RVIBB','RVRNK','RVPH1','RVPH2','RVPH3','FADR','RIZIK',
                                                    'DOV_P', 'DOV_A', 'DOV_F')
                                    )
                             pivot ( max(value) cc for tag in ('SUBSD','SUBSN','ELT_N','ELT_D','SW_RN','Y_ELT','BUSSS','PC_MF',
                                                              'PC_Z4','PC_Z3','PC_Z5','PC_Z2','PC_Z1','AGENT','PC_SS','STMT',
                                                              'VIDKL','TIPA','PHKLI','AF1_9','IDDPD','DAIDI','DATVR','DATZ',
                                                              'IDDPL','IDDPR','OBSLU','CRSRC','DJOTH','DJAVI','DJ_TC','DJOWF',
                                                              'DJCFI','DJ_LN','DJ_FH','DJ_CP','CHORN','SPMRK','K013','KODID',
                                                              'MS_FS','MS_VD','MS_GR','LICO','MOB01','MOB02','MOB03','SUBS',
                                                              'DEATH','NSMCV','NSMCC','NSMCT','SAMZ','O_REP','OVIFS','AF6',
                                                              'FSKRK','FSOMD','FSVED','FSZPD','FSPOR','FSRKZ','FSZOP','FSKPK',
                                                              'FSKPR','FSDIB','FSCP','FSVLZ','FSVLA','FSVLN','FSVLO','FSSST',
                                                              'FSSOD','FSVSN','SN_GC','PUBLP','WORKB','CIGPO','TARIF','AINAB',
                                                              'SNSDR','IDPIB','DJER','SUTD','RVDBC','RVIBA','RVIDT','RV_XA',
                                                              'RVIBR','RVIBB','RVRNK','RVPH1','RVPH2','RVPH3','FADR','RIZIK',
                                                              'DOV_P', 'DOV_A', 'DOV_F'))
                             ) ww
              where c.custtype=3
                and c.rnk=p.rnk
                and c.COUNTRY = cntr.COUNTRY(+)
                and c.rnk = rkv.RNK(+)
                and c.rnk = gc.RNK(+)
                and c.rnk = a.rnk(+)
                and c.rnk = w.rnk(+)
                and c.rnk = ww.rnk(+)
                --and not (C.ise in ('14100', '14200', '14101','14201') and C.sed ='91') --фильтруем ФОПов
                and C.RNK = delta.rnk /* дельта */

        ) Q
        on (c.rnk = Q.rnk and c.kf = q.kf)
        when matched then
            update
            set
            c.changenumber = q.changenumber,
            c.LAST_NAME = q.LAST_NAME,
            c.FIRST_NAME = q.FIRST_NAME,
            c.MIDDLE_NAME = q.MIDDLE_NAME,
            c.BDAY = q.BDAY,
            c.GR = q.GR,
            c.PASSP = q.PASSP,
            c.SER = q.SER,
            c.NUMDOC = q.NUMDOC,
            c.PDATE = q.PDATE,
            c.ORGAN = q.ORGAN,
            c.PASSP_EXPIRE_TO = q.ACTUAL_DATE,
            c.PASSP_TO_BANK = null, --q.PASSP_TO_BANK,
            --c.KF = q.KF,
            --c.RNK = q.RNK,
            c.OKPO = q.OKPO,
            c.CUST_STATUS = q.CUST_STATUS,
            c.CUST_ACTIVE = q.CUST_ACTIVE,
            c.TELM = q.TELM,
            c.TELW = q.TELW,
            c.TELD = q.TELD,
            c.TELADD = q.TELADD,
            c.EMAIL = q.EMAIL,
            c.ADR_POST_COUNTRY = q.AP_COUNTRY,
            c.ADR_POST_DOMAIN = q.AP_DOMAIN,
            c.ADR_POST_REGION = q.AP_REGION,
            c.ADR_POST_LOC = q.AP_LOCALITY,
            c.ADR_POST_ADR = q.AP_ADRESS,
            c.ADR_POST_ZIP = q.AP_ZIP,
            c.ADR_FACT_COUNTRY = q.AU_COUNTRY,
            c.ADR_FACT_DOMAIN = q.AU_DOMAIN,
            c.ADR_FACT_REGION = q.AU_REGION,
            c.ADR_FACT_LOC = q.AU_LOCALITY,
            c.ADR_FACT_ADR = q.AU_ADRESS,
            c.ADR_FACT_ZIP = q.AU_ZIP,
            c.ADR_WORK_COUNTRY = q.AU_COUNTRY,
            c.ADR_WORK_DOMAIN = q.AU_DOMAIN,
            c.ADR_WORK_REGION = q.AU_REGION,
            c.ADR_WORK_LOC = q.AU_LOCALITY,
            c.ADR_WORK_ADR = q.AU_ADRESS,
            c.ADR_WORK_ZIP = q.AU_ZIP,
            c.BRANCH = q.BRANCH,
            c.NEGATIV_STATUS = null, --q.NEGATIV_STATUS,
            c.REESTR_MOB_BANK = null, --q.REESTR_MOB_BANK,
            c.REESTR_INET_BANK = null, --q.REESTR_INET_BANK,
            c.REESTR_SMS_BANK = null, --q.REESTR_SMS_BANK,
            c.MONTH_INCOME = null, --q.MONTH_INCOME,
            c.SUBJECT_ROLE = null, --q.SUBJECT_ROLE,
            c.REZIDENT = q.REZIDENT,
            c.MERRIED = q.PC_SS,
            c.EMP_STATUS = q.EMP_STATUS,
            c.SUBJECT_CLASS = q.SUBJECT_CLASS,
            c.INSIDER = q.INSIDER,
            c.SEX = q.SEX,
            c.VIPK = q.VIPK,
            c.VIP_FIO_MANAGER = q.VIP_FIO_MANAGER,
            c.VIP_PHONE_MANAGER = q.VIP_PHONE_MANAGER,
            c.DATE_ON = q.DATE_ON,
            c.DATE_OFF = q.DATE_OFF,
            c.EDDR_ID = q.EDDR_ID,
            c.IDCARD_VALID_DATE = q.ACTUAL_DATE,
            c.IDDPL = q.IDDPL,
            c.BPLACE = q.BPLACE,
            c.SUBSD = q.SUBSD,
            c.SUBSN = q.SUBSN,
            c.ELT_N = q.ELT_N,
            c.ELT_D = q.ELT_D,
            c.GCIF = q.GCIF,
            c.NOMPDV = q.NOMPDV,
            c.NOM_DOG = q.NOM_DOG,
            c.SW_RN = q.SW_RN,
            c.Y_ELT = q.Y_ELT,
            c.ADM = q.ADM,
            c.FADR = q.FADR,
            c.ADR_ALT = q.ADR_ALT,
            c.BUSSS = q.BUSSS,
            c.PC_MF = q.PC_MF,
            c.PC_Z4 = q.PC_Z4,
            c.PC_Z3 = q.PC_Z3,
            c.PC_Z5 = q.PC_Z5,
            c.PC_Z2 = q.PC_Z2,
            c.PC_Z1 = q.PC_Z1,
            c.AGENT = q.AGENT,
            c.PC_SS = q.PC_SS,
            c.STMT = q.STMT,
            c.VIDKL = q.VIDKL,
            c.VED = q.VED,
            c.TIPA = q.TIPA,
            c.PHKLI = q.PHKLI,
            c.AF1_9 = q.AF1_9,
            c.IDDPD = q.IDDPD,
            c.DAIDI = q.DAIDI,
            c.DATVR = q.DATVR,
            c.DATZ = q.DATZ,
            c.DATE_PHOTO = q.DATE_PHOTO,
            c.IDDPR = q.IDDPR,
            c.ISE = q.ISE,
            c.OBSLU = q.OBSLU,
            c.CRSRC = q.CRSRC,
            c.DJOTH = q.DJOTH,
            c.DJAVI = q.DJAVI,
            c.DJ_TC = q.DJ_TC,
            c.DJOWF = q.DJOWF,
            c.DJCFI = q.DJCFI,
            c.DJ_LN = q.DJ_LN,
            c.DJ_FH = q.DJ_FH,
            c.DJ_CP = q.DJ_CP,
            c.CHORN = q.CHORN,
            c.CRISK_KL = q.CRISK_KL,
            c.BC = q.BC,
            c.SPMRK = q.SPMRK,
            c.K013 = q.K013,
            c.KODID = q.KODID,
            c.COUNTRY = q.COUNTRY,
            c.MS_FS = q.MS_FS,
            c.MS_VD = q.MS_VD,
            c.MS_GR = q.MS_GR,
            c.LIM_KASS = q.LIM_KASS,
            c.LIM = q.LIM,
            c.LICO = q.LICO,
            c.UADR = q.UADR,
            c.MOB01 = q.MOB01,
            c.MOB02 = q.MOB02,
            c.MOB03 = q.MOB03,
            c.SUBS = q.SUBS,
            c.K050 = q.K050,
            c.DEATH = q.DEATH,
            c.NO_PHONE = q.NO_PHONE,
            c.NSMCV = q.NSMCV,
            c.NSMCC = q.NSMCC,
            c.NSMCT = q.NSMCT,
            c.NOTES = q.NOTES,
            c.SAMZ = q.SAMZ,
            c.OREP = q.OREP,
            c.OVIFS = q.OVIFS,
            c.AF6 = q.AF6,
            c.FSKRK = q.FSKRK,
            c.FSOMD = q.FSOMD,
            c.FSVED = q.FSVED,
            c.FSZPD = q.FSZPD,
            c.FSPOR = q.FSPOR,
            c.FSRKZ = q.FSRKZ,
            c.FSZOP = q.FSZOP,
            c.FSKPK = q.FSKPK,
            c.FSKPR = q.FSKPR,
            c.FSDIB = q.FSDIB,
            c.FSCP = q.FSCP,
            c.FSVLZ = q.FSVLZ,
            c.FSVLA = q.FSVLA,
            c.FSVLN = q.FSVLN,
            c.FSVLO = q.FSVLO,
            c.FSSST = q.FSSST,
            c.FSSOD = q.FSSOD,
            c.FSVSN = q.FSVSN,
            c.DOV_P = q.DOV_P,
            c.DOV_A = q.DOV_A,
            c.DOV_F = q.DOV_F,
            c.NMKV = q.NMKV,
            c.SN_GC = q.SN_GC,
            c.NMKK = q.NMKK,
            c.PRINSIDER = q.PRINSIDER,
            c.NOTESEC = q.NOTESEC,
            c.MB = q.MB,
            c.PUBLP = q.PUBLP,
            c.WORKB = q.WORKB,
            c.C_REG = q.C_REG,
            c.C_DST = q.C_DST,
            c.RGADM = q.RGADM,
            c.RGTAX = q.RGTAX,
            c.DATEA = q.DATEA,
            c.DATET = q.DATET,
            c.RNKP = q.RNKP,
            c.CIGPO = q.CIGPO,
            c.COUNTRY_NAME = q.COUNTRY_NAME,
            c.TARIF = q.TARIF,
            c.AINAB = q.AINAB,
            c.TGR = q.TGR,
            c.CUSTTYPE = q.CUSTTYPE,
            c.RIZIK = q.RIZIK,
            c.SNSDR = q.SNSDR,
            c.IDPIB = q.IDPIB,
            c.FS = q.FS,
            c.SED = q.SED,
            c.DJER = q.DJER,
            c.CODCAGENT = q.CODCAGENT,
            c.SUTD = q.SUTD,
            c.RVDBC = q.RVDBC,
            c.RVIBA = q.RVIBA,
            c.RVIDT = q.RVIDT,
            c.RV_XA = q.RV_XA,
            c.RVIBR = q.RVIBR,
            c.RVIBB = q.RVIBB,
            c.RVRNK = q.RVRNK,
            c.RVPH1 = q.RVPH1,
            c.RVPH2 = q.RVPH2,
            c.RVPH3 = q.RVPH3,
            c.SAB = q.SAB,
            c.VIP_ACCOUNT_MANAGER = q.VIP_ACCOUNT_MANAGER
        when not matched then insert
            (CHANGENUMBER, LAST_NAME,FIRST_NAME,MIDDLE_NAME,BDAY,GR,PASSP,SER,NUMDOC,PDATE,ORGAN,PASSP_EXPIRE_TO,PASSP_TO_BANK,KF,RNK,OKPO,CUST_STATUS,CUST_ACTIVE,TELM,TELW,
            TELD,TELADD,EMAIL,ADR_POST_COUNTRY,ADR_POST_DOMAIN,ADR_POST_REGION,ADR_POST_LOC,ADR_POST_ADR,ADR_POST_ZIP,ADR_FACT_COUNTRY,ADR_FACT_DOMAIN,ADR_FACT_REGION,
            ADR_FACT_LOC,ADR_FACT_ADR,ADR_FACT_ZIP,ADR_WORK_COUNTRY,ADR_WORK_DOMAIN,ADR_WORK_REGION,ADR_WORK_LOC,ADR_WORK_ADR,ADR_WORK_ZIP,BRANCH,NEGATIV_STATUS,
            REESTR_MOB_BANK,REESTR_INET_BANK,REESTR_SMS_BANK,MONTH_INCOME,SUBJECT_ROLE,REZIDENT,MERRIED,EMP_STATUS,SUBJECT_CLASS,INSIDER,SEX,VIPK,VIP_FIO_MANAGER,
            VIP_PHONE_MANAGER,DATE_ON,DATE_OFF,EDDR_ID,IDCARD_VALID_DATE,IDDPL,BPLACE,SUBSD,SUBSN,ELT_N,ELT_D,GCIF,NOMPDV,NOM_DOG,SW_RN,Y_ELT,ADM,FADR,ADR_ALT,BUSSS,
            PC_MF,PC_Z4,PC_Z3,PC_Z5,PC_Z2,PC_Z1,"AGENT",PC_SS,STMT,VIDKL,VED,TIPA,PHKLI,AF1_9,IDDPD,DAIDI,DATVR,DATZ,DATE_PHOTO,IDDPR,ISE,OBSLU,CRSRC,DJOTH,DJAVI,DJ_TC,
            DJOWF,DJCFI,DJ_LN,DJ_FH,DJ_CP,CHORN,CRISK_KL,BC,SPMRK,K013,KODID,COUNTRY,MS_FS,MS_VD,MS_GR,LIM_KASS,LIM,LICO,UADR,MOB01,MOB02,MOB03,SUBS,K050,DEATH,NO_PHONE,
            NSMCV,NSMCC,NSMCT,NOTES,SAMZ,OREP,OVIFS,AF6,FSKRK,FSOMD,FSVED,FSZPD,FSPOR,FSRKZ,FSZOP,FSKPK,FSKPR,FSDIB,FSCP,FSVLZ,FSVLA,FSVLN,FSVLO,FSSST,FSSOD,FSVSN,DOV_P,
            DOV_A,DOV_F,NMKV,SN_GC,NMKK,PRINSIDER,NOTESEC,MB,PUBLP,WORKB,C_REG,C_DST,RGADM,RGTAX,DATEA,DATET,RNKP,CIGPO,COUNTRY_NAME,TARIF,AINAB,TGR,CUSTTYPE,RIZIK,SNSDR,
            IDPIB,FS,SED,DJER,CODCAGENT,SUTD,RVDBC,RVIBA,RVIDT,RV_XA,RVIBR,RVIBB,RVRNK,RVPH1,RVPH2,RVPH3,SAB,VIP_ACCOUNT_MANAGER)
            values
            (q.CHANGENUMBER, q.LAST_NAME,q.FIRST_NAME,q.MIDDLE_NAME,q.BDAY,q.GR,q.PASSP,q.SER,q.NUMDOC,q.PDATE,q.ORGAN,q.ACTUAL_DATE,null,q.KF,q.RNK,q.OKPO,q.CUST_STATUS,
            q.CUST_ACTIVE,q.TELM,q.TELW,q.TELD,q.TELADD,q.EMAIL,q.AP_COUNTRY,q.AP_DOMAIN,q.AP_REGION,q.AP_LOCALITY,q.AP_ADRESS,q.AP_ZIP,
            q.AU_COUNTRY,q.AU_DOMAIN,q.AU_REGION,q.AU_LOCALITY,q.AU_ADRESS,q.AU_ZIP,q.AU_COUNTRY,q.AU_DOMAIN,q.AU_REGION,
            q.AU_LOCALITY,q.AU_ADRESS,q.AU_ZIP,q.BRANCH,null,null,null,null,null,null,
            q.REZIDENT,q.PC_SS,q.EMP_STATUS,q.SUBJECT_CLASS,q.INSIDER,q.SEX,q.VIPK,q.VIP_FIO_MANAGER,q.VIP_PHONE_MANAGER,q.DATE_ON,q.DATE_OFF,q.EDDR_ID,q.ACTUAL_DATE,
            q.IDDPL,q.BPLACE,q.SUBSD,q.SUBSN,q.ELT_N,q.ELT_D,q.GCIF,q.NOMPDV,q.NOM_DOG,q.SW_RN,q.Y_ELT,q.ADM,q.FADR,q.ADR_ALT,q.BUSSS,q.PC_MF,q.PC_Z4,q.PC_Z3,q.PC_Z5,q.PC_Z2,
            q.PC_Z1,q.AGENT,q.PC_SS,q.STMT,q.VIDKL,q.VED,q.TIPA,q.PHKLI,q.AF1_9,q.IDDPD,q.DAIDI,q.DATVR,q.DATZ,q.DATE_PHOTO,q.IDDPR,q.ISE,q.OBSLU,q.CRSRC,q.DJOTH,q.DJAVI,
            q.DJ_TC,q.DJOWF,q.DJCFI,q.DJ_LN,q.DJ_FH,q.DJ_CP,q.CHORN,q.CRISK_KL,q.BC,q.SPMRK,q.K013,q.KODID,q.COUNTRY,q.MS_FS,q.MS_VD,q.MS_GR,q.LIM_KASS,q.LIM,q.LICO,q.UADR,
            q.MOB01,q.MOB02,q.MOB03,q.SUBS,q.K050,q.DEATH,q.NO_PHONE,q.NSMCV,q.NSMCC,q.NSMCT,q.NOTES,q.SAMZ,q.OREP,q.OVIFS,q.AF6,q.FSKRK,q.FSOMD,q.FSVED,q.FSZPD,q.FSPOR,
            q.FSRKZ,q.FSZOP,q.FSKPK,q.FSKPR,q.FSDIB,q.FSCP,q.FSVLZ,q.FSVLA,q.FSVLN,q.FSVLO,q.FSSST,q.FSSOD,q.FSVSN,q.DOV_P,q.DOV_A,q.DOV_F,q.NMKV,q.SN_GC,q.NMKK,q.PRINSIDER,
            q.NOTESEC,q.MB,q.PUBLP,q.WORKB,q.C_REG,q.C_DST,q.RGADM,q.RGTAX,q.DATEA,q.DATET,q.RNKP,q.CIGPO,q.COUNTRY_NAME,q.TARIF,q.AINAB,q.TGR,q.CUSTTYPE,q.RIZIK,q.SNSDR,
            q.IDPIB,q.FS,q.SED,q.DJER,q.CODCAGENT,q.SUTD,q.RVDBC,q.RVIBA,q.RVIDT,q.RV_XA,q.RVIBR,q.RVIBB,q.RVRNK,q.RVPH1,q.RVPH2,q.RVPH3,q.SAB,q.VIP_ACCOUNT_MANAGER)
        log errors into ERR$_CLIENTFO2 reject limit unlimited;

        p_rows_ok := sql%rowcount;
        select count(*) into p_rows_err from ERR$_CLIENTFO2 where changenumber = l_changenumber;

        reset_object_idupd(c_object_name);

        p_status := 'SUCCESS';

        bars.bars_audit.info(g_trace||c_object_name||': finished');
    exception
        when others then
            rollback to imp_start;
            p_status := 'ERROR';
            bars.bars_audit.error(g_trace||c_object_name||': '|| dbms_utility.format_error_stack || chr(10) ||dbms_utility.format_error_backtrace);
            raise;
    end import_clientfo2;

    procedure import_client_address
        is

	l_ourmfo varchar2(6) := sys_context('bars_context', 'user_mfo');
    begin
        null;
    end import_client_address;


    ---
    --- Запуск выгрузки по объекту в контексте указанного МФО (для параллели).
    ---
    procedure imp_run_by_mfo(p_mfo          in     varchar2,
                             p_object_proc  in     varchar2,
                             p_id_event     in     number)
        is
        l_trace  varchar2(500) := G_TRACE||'imp_run_by_mfo: ';
        l_stats_current_row intgr_stats%rowtype;
        l_errmsg varchar2(512);
        l_rows_ok number;
        l_rows_err number;
        l_status varchar2(32);
    begin
        -- представляемся и запускаем выгрузку
        bars.bc.go(p_mfo);
        execute immediate 'begin ' || p_object_proc || '(:p1, :p2, :p3); end;'
        using in out l_rows_ok, in out l_rows_err, in out l_status;

        commit;

        -- лочим строку статистики и обновляем статус (кроме ERROR) и инкрементно выгруженные строки
        select * into l_stats_current_row from intgr_stats where id = p_id_event for update;
        log_stat_event(p_rows_ok    => nvl(l_stats_current_row.rows_ok, 0) + l_rows_ok,
                       p_rows_err   => nvl(l_stats_current_row.rows_err, 0) + l_rows_err,
                       p_status     => case when l_stats_current_row.status in ('ERROR', 'INPROCESS') and l_status != 'ERROR' then l_stats_current_row.status else l_status end,
                       p_id         => l_stats_current_row.id);
    exception
        when others then
            l_errmsg :=substr(l_trace||' Error: '
                                     ||dbms_utility.format_error_stack()||chr(10)
                                     ||dbms_utility.format_error_backtrace()
                                     , 1, 512);
            bars.bars_audit.error(l_errmsg);
            -- лочим строку статистики и ставим статус ошибки
            select * into l_stats_current_row from intgr_stats where id = p_id_event for update;
            log_stat_event(p_id => l_stats_current_row.id, p_status => 'ERROR');
    end imp_run_by_mfo;

    --
    -- Общая процедура запуска выгрузки
    --
    procedure imp_run
    is
        l_trace           constant varchar2(500) := G_TRACE||'imp_run: ';
        l_changenumber    number;
        l_id_event        number;
        l_errmsg          varchar2(512);

        -- parallel stuff
        c_task_name       constant varchar2(32) := 'INTGR_IMPORT';
        l_chunk_stmt      varchar2(128);
        l_mfo_cnt         number;
        l_task_statement  varchar2(4000) := q'[
        begin
            bars_login.login_user(sys_guid, :usr_id, null, null);
            bars.bc.go(:START_ID);
            bars_intgr.xrm_import.imp_run_by_mfo(p_mfo => to_char(:END_ID),
                                                 p_object_proc => ':object_proc',
                                                 p_id_event => :id_event);
            commit;
            bars.bars_login.logout_user;
        end;
        ]';
        l_usr_id          number;
        l_final_status    varchar2(32);
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
        -- получаем id сессии
        select nvl(max(changenumber),1) + 1 into l_changenumber from intgr_stats;

        -- кем логинимся
        select id into l_usr_id from bars.staff$base t where t.logname = 'BARS_INTGR';
        l_task_statement := replace(l_task_statement, ':usr_id', l_usr_id);

        for cur in (select object_name, object_proc from imp_object where active = 1 order by imp_order)
        loop
            begin
                -- получаем число МФО для паралеллизма
                select count(*) into l_mfo_cnt from imp_object_mfo where object_name = cur.object_name;
                -- получаем чанки по МФО
                l_chunk_stmt := 'select kf as START_ID, kf as END_ID from imp_object_mfo where object_name = '''||cur.object_name||'''';

                -- лог начала задачи
                log_stat_event (p_changenumber => l_changenumber,
                                p_start_time => sysdate,
                                p_stop_time => null,
                                p_object_name => cur.object_name,
                                p_rows_ok => null,
                                p_rows_err => null,
                                p_status => 'INPROCESS',
                                p_id => l_id_event );


                -- удаляем предыдущую задачу
                drop_import_task;
                dbms_parallel_execute.create_task(c_task_name);
                -- создаем чанки по МФО
                dbms_parallel_execute.create_chunks_by_sql(task_name => c_task_name,
                                                           sql_stmt  => l_chunk_stmt,
                                                           by_rowid  => false);
                -- запуск задачи по всем МФО
                dbms_parallel_execute.run_task(task_name      => c_task_name,
                                               sql_stmt       => replace(replace(l_task_statement, ':object_proc', cur.object_proc), ':id_event', l_id_event),
                                               language_flag  => dbms_sql.native,
                                               parallel_level => case when G_IS_MMFO = 1 then l_mfo_cnt+1 else 0 end);


                -- лог окончания
                select case when status = 'ERROR' then 'ERROR' else 'SUCCESS' end into l_final_status from intgr_stats where id = l_id_event;
                log_stat_event(p_stop_time => sysdate,
                               p_id        => l_id_event,
                               p_status    => l_final_status);
                commit;
            exception
                when others then
                    /* если что-то случилось с паралеллизмом - удаляем задачу и логируем ошибку */
                    l_errmsg :=substr(l_trace||' Error: '
                                             ||dbms_utility.format_error_stack()||chr(10)
                                             ||dbms_utility.format_error_backtrace()
                                             , 1, 512);
                    bars.bars_audit.error(l_errmsg);
                    drop_import_task;
                    log_stat_event(p_stop_time  => sysdate,
                                   p_status => 'ERROR',
                                   p_id => l_id_event);

            end;
            -- обнуляем id выгрузки объекта
            l_id_event := null;
            l_final_status := null;
        end loop;

    end imp_run;

begin
    select case when count(*)>1 then 1 else 0 end
    into G_IS_MMFO
    from bars.mv_kf;
end;
/
show errors;
