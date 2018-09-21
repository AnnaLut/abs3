create or replace package nbu_data_service is

    LT_REPORT_INSTANCE_STAGE       constant varchar2(30 char) := 'NBU_601_REPORT_INSTANCE_STAGE';
    REP_STAGE_NEW                  constant integer := 1;
    REP_STAGE_RECEIVING_DATA       constant integer := 2;
    REP_STAGE_CONSOLIDATION        constant integer := 3;
    REP_STAGE_TRANSFERING          constant integer := 4;
    REP_STAGE_FINISHED             constant integer := 5;
    REP_STAGE_DISCARDED            constant integer := 6;
/*
    procedure start_new_report_instance(
        p_reporting_date in date,
        p_run_immediately in boolean default true);
*/
    procedure set_report_state(
        p_report_id in integer,
        p_state_id in integer,
        p_tracking_comment in varchar2);

    function make_new_non_resident_code
    return varchar2;

    function make_company_code(
        p_edrpou in varchar2,
        p_core_company_id in integer,
        p_core_company_kf in varchar2,
        p_isrez in varchar2)
    return varchar2;

    function make_person_code(
        p_report_id in integer,
        p_ipn in varchar2,
        p_core_person_id in integer,
        p_core_person_kf in varchar2,
        p_isrez in varchar2)
    return varchar2;

    function make_pledge_code(
        p_customer_code in varchar2,
        p_pledge_number in varchar2,
        p_pledge_date in date)
    return varchar2;

    procedure initialize_exchange_rates;

    function get_exchange_rate(
        p_currency_id in integer)
    return number;


    procedure gather_data(
        p_report_id in integer);

    procedure start_report;
/*
    procedure send_data_601(
        p_object_id in integer);

    procedure send_data_601;

    procedure call_service_601;
*/
end;
/
create or replace package body nbu_data_service as

     DATA_CONSOLIDAT_PROGRAM_NAME constant varchar2(30 char) := 'NBU601_DATA_CONSOLIDATION';

     type t_exchange_rates is table of number index by pls_integer;

     g_exchange_rates t_exchange_rates;

     procedure track_report_instance(
         p_report_id in integer,
         p_stage_id in integer,
         p_tracking_message in varchar2)
     is
     begin
         insert into nbu_report_instance_tracking
         values (p_report_id, sysdate, p_stage_id, substrb(p_tracking_message, 1, 4000));
     end;

     function create_report_instance(
         p_reporting_date in date)
     return integer
     is
         l_report_id integer;
     begin
         insert into nbu_report_instance
         values (s_nbu_report_instance.nextval, p_reporting_date, nbu_core_service.REQ_STATE_NEW)
         returning id
         into l_report_id;

         track_report_instance(l_report_id, nbu_data_service.REP_STAGE_NEW, 'Сформовано новий екземпляр звіту 601 для дати ' || to_char(p_reporting_date, 'dd.mm.yyyy hh24:mi:ss'));

         return l_report_id;
     end;

     function read_report_instance(
         p_report_id in integer)
     return nbu_report_instance%rowtype
     is
         l_report_row nbu_report_instance%rowtype;
     begin
         select *
         into   l_report_row
         from   nbu_report_instance t
         where  t.id = p_report_id;

         return l_report_row;
     exception
         when no_data_found then
              raise_application_error(-20000, 'Звіт з ідентифікатором {' || p_report_id || '} не знайдений');
     end;
 /*
     procedure deploy_core_data_requests(
         p_report_id in integer)
     is
         l_data_request_id integer;
         l_report_row nbu_report_instance%rowtype;
     begin
         l_report_row := read_report_instance(p_report_id);

         for i in (select * from nbu_core_branch t where t.is_active = 1) loop
             for j in (select * from nbu_core_data_request_type t where t.is_active = 1) loop
                 l_data_request_id := nbu_core_service.create_data_request(j.id, i.kf, l_report_row.reporting_date, p_report_id => p_report_id);
             end loop;
         end loop;
     end;
 */
     procedure set_report_state(
         p_report_id in integer,
         p_state_id in integer,
         p_tracking_comment in varchar2)
     is
     begin
         update nbu_report_instance t
         set    t.stage_id = p_state_id
         where  t.id = p_report_id;

         track_report_instance(p_report_id, p_state_id, p_tracking_comment);
     end;
 /*
     procedure start_new_report_instance(
         p_reporting_date in date,
         p_run_immediately in boolean default true)
     is
         l_report_id integer;
     begin
 \*
         for i in (select t.*
                   from   nbu_report_instance t
                   where  t.reporting_date >= p_reporting_date
                   order by t.reporting_date) loop

             raise_application_error(-20000, 'Зріз даних на дату ' || to_char(i.reporting_date, 'dd.mm.yyyy hh24:mi:ss') || ' вже існує');
         end loop;
 *\
         for i in (select t.*
                   from   nbu_report_instance t
                   where  t.stage_id not in (nbu_data_service.REP_STAGE_TRANSFERING,
                                             nbu_data_service.REP_STAGE_FINISHED,
                                             nbu_data_service.REP_STAGE_DISCARDED)
                   order by t.id) loop
             raise_application_error(-20000, 'Зріз даних за дату {' || to_char(i.reporting_date, 'dd.mm.yyyy') ||
                                             '} перебуває в стані {' || bars.list_utl.get_item_name(nbu_data_service.LT_REPORT_INSTANCE_STAGE, i.stage_id) ||
                                             '} - необхідно завершити або відмінити його перед тим як починати формування нового');
         end loop;

         l_report_id := create_report_instance(p_reporting_date);

         deploy_core_data_requests(l_report_id);

         if (p_run_immediately) then
             -- фіксуємо транзакцію тут, оскільки подальший виклик процедур обробки в паралельних сесіях базується на зафіксованих даних
             commit;
             nbu_core_service.run_all_data_requests(l_report_id);
         end if;
     end;
 */
     function make_new_non_resident_code
     return varchar2
     is
     begin
         return to_char(s_nbu_non_resident_counter.nextval, 'FM0000000000');
     end;

     function make_company_code(
         p_edrpou in varchar2,
         p_core_company_id in integer,
         p_core_company_kf in varchar2,
         p_isrez in varchar2)
     return varchar2
     is
         l_customer_code varchar2(30 char);
         l_customer_row nbu_reported_customer%rowtype;
         l_edrpou varchar2(30 char) := trim(p_edrpou);
     begin
         if (p_isrez = 'true') then
             -- резиденти
             if (length(l_edrpou) >= 8 and regexp_like(l_edrpou, '^\d+$') and not regexp_like(l_edrpou, '(^0+$)|(^1+$)|(^2+$)|(^3+$)|(^4+$)|(^5+$)|(^6+$)|(^7+$)|(^8+$)|(^9+$)')) then
                 -- маємо надію на те, що вказано коректний ЄДРПОУ (більше або дорівнює 8 цифр і заповнений не однією і тією самою цифрою)
                 l_customer_code := l_edrpou;
             end if;
         else
             -- нерезиденти
             -- if (l_edrpou is null) then
                 -- нерезидент, який не має номера реєстрації в податковій і будь-яких інших реєстраційних номерів
                 -- шукаємо його за ідентифікатором АБС - якщо він до нас уже потрапляв, ми повинні використовувати той
                 -- самий ідентифікатор, який був згенерований при першій реєстрації
                 l_customer_row := nbu_object_utl.get_customer_by_core_id(p_core_company_id, p_core_company_kf);
                 if (l_customer_row.id is not null) then
                     -- знайшли існуючий об'єкт НБУ - використовуємо його код реєстрації в НБУ
                     l_customer_code := l_customer_row.customer_code;
                 else
                     -- не знайшли об'єкт НБУ за його ідентифікатором в АБС - генеруємо новий код нерезидента
                     l_customer_code := 'IN' || make_new_non_resident_code();
                 end if;
             -- else
             --     l_customer_code := 'IN' || l_edrpou;
             -- end if;
         end if;

         return l_customer_code;
     end;

     function make_person_code(
         p_report_id in integer,
         p_ipn in varchar2,
         p_core_person_id in integer,
         p_core_person_kf in varchar2,
         p_isrez in varchar2)
     return varchar2
     is
         l_customer_code varchar2(30 char);
         l_ipn varchar2(30 char) := trim(p_ipn);
         l_customer_row nbu_reported_customer%rowtype;
         l_id_card varchar2(30 char);
         l_passport varchar2(30 char);
         l_documents t_core_person_documents;
         l integer;
     begin
         if (p_isrez = 'true') then
             -- резиденти
             if (length(l_ipn) >= 8 and regexp_like(l_ipn, '^\d+$') and not regexp_like(l_ipn, '(^0+$)|(^1+$)|(^2+$)|(^3+$)|(^4+$)|(^5+$)|(^6+$)|(^7+$)|(^8+$)|(^9+$)')) then
                 -- маємо надію на те, що вказано коректний ІПН (більше або дорівнює 8 цифр і заповнений не однією і тією самою цифрою)
                 l_customer_code := l_ipn;
             else
                 l_documents := nbu_core_service.get_core_person_documents(p_report_id, p_core_person_id, p_core_person_kf);

                 if (l_documents is not null and l_documents is not empty) then
                     l := l_documents.first;
                     while (l is not null) loop
                         if (l_documents(l).typed = 3) then
                             l_id_card := trim(l_documents(l).nomerd);
                         elsif (l_documents(l).typed = 1) then
                             l_passport := trim(l_documents(l).seriya) || trim(l_documents(l).nomerd);
                         end if;
                         l := l_documents.next(l);
                     end loop;

                     l_customer_code := coalesce(l_id_card, l_passport);
                 end if;
             end if;
         else
             -- нерезиденти
             if (l_ipn is null) then
                 -- шукаємо нерезидента за ідентифікатором АБС - якщо він до нас уже потрапляв, ми повинні використовувати той
                 -- самий ідентифікатор, який був згенерований при першій реєстрації

                 l_customer_row := nbu_object_utl.get_customer_by_core_id(p_core_person_id, p_core_person_kf);

                 if (l_customer_row.id is not null) then
                     -- знайшли існуючий об'єкт НБУ - використовуємо його код реєстрації в НБУ
                     l_customer_code := l_customer_row.customer_code;
                 else
                     -- не знайшли об'єкт НБУ за його ідентифікатором в АБС - генеруємо новий код нерезидента
                     l_customer_code := 'IN' || make_new_non_resident_code();
                 end if;
             else
                 l_customer_code := 'IN' || l_ipn;
             end if;
         end if;

         return l_customer_code;
     end;

     function make_pledge_code(
         p_customer_code in varchar2,
         p_pledge_number in varchar2,
         p_pledge_date in date)
     return varchar2
     is
     begin
         if (p_customer_code is null or p_pledge_number is null or p_pledge_date is null) then
             return null;
         else
             return p_customer_code || '-' || p_pledge_number || '-' || to_char(p_pledge_date, 'yyyymmdd');
         end if;
     end;

     procedure initialize_exchange_rates
     is
     begin
         g_exchange_rates.delete();

         for i in (select x.kv, x.rate_o / power(10, (select c.dig from bars.tabval$global c where c.kv = x.kv)) rate_o
                   from   bars.cur_rates$base x
                   where  (x.kv, x.vdate, x.branch) in (select t.kv,
                                                               min(t.vdate) keep (dense_rank last order by t.vdate, t.branch) last_rate_date,
                                                               min(t.branch) keep (dense_rank last order by t.vdate, t.branch) last_branch
                                                        from   bars.cur_rates$base t
                                                        where  t.vdate >= sysdate - 10 and
                                                               t.vdate <= sysdate
                                                        group by t.kv)) loop
             g_exchange_rates(i.kv) := i.rate_o;
         end loop;

         g_exchange_rates(980) := 1;
     end;

     function get_exchange_rate(
         p_currency_id in integer)
     return number
     is
     begin
         if (g_exchange_rates.exists(p_currency_id)) then
             return g_exchange_rates(p_currency_id);
         else
             raise_application_error(-20000, 'Не визначено курс валюти ' || p_currency_id);
         end if;
     end;

     procedure gather_company_data(
         p_report_id in integer)
     is
         l_data_type_id integer;
     begin
         l_data_type_id := nbu_core_service.get_request_type_id(nbu_core_service.REQ_TYPE_COMPANY);

         update core_person_uo t
         set    t.company_code = make_company_code(t.codedrpou, t.rnk, t.kf, t.isrez)
         where  t.request_id in (select r.id
                                 from   nbu_core_data_request r
                                 where  r.report_id = p_report_id and
                                        r.data_type_id = l_data_type_id);

         update core_person_uo t
         set    t.status = 'INVALID',
                t.status_message = 'Не дійсне значення коду ЄДРПОУ: ' || t.codedrpou
         where  t.company_code is null and
                t.request_id in (select r.id
                                 from   nbu_core_data_request r
                                 where  r.report_id = p_report_id and
                                        r.data_type_id = l_data_type_id);

         insert into tmp_company
         select t.company_code,  -- company_code varchar2(30 char),
                null,            -- total_loans_amount number(38),
                t.request_id,    -- request_id number(38),
                t.kf,            -- core_company_kf varchar2(6 char),
                t.rnk,           -- core_company_id number(38),
                null,            -- default_core_company_kf varchar2(6 char),
                null             -- default_core_company_id number(38)
         from   core_person_uo t
         where  t.request_id in (select max(r.id)
                                 from   nbu_core_data_request r
                                 where  r.data_type_id = l_data_type_id and
                                        r.state_id in (nbu_core_service.REQ_STATE_DATA_DELIVERED, nbu_core_service.REQ_STATE_INCLUDED_IN_REPORT)
                                 group by r.kf);

         -- поєднаємо виборку даних з регіонів з об'єктами, що вже відправлялися або підготовлені до відправки в НБУ
         -- визначаємо який із ідентифікаторів (RNK) компанії в РУ (записи з одним і тим самим кодом ЄДРПОУ) буде надавати дані для передачі до НБУ
         merge into tmp_company a
         using (select t.core_company_kf, t.core_company_id,
                       coalesce(min(case when t.core_company_kf = c.core_customer_kf and t.core_company_id = c.core_customer_id then
                                              t.core_company_kf
                                         else null
                                    end) over (partition by t.company_code order by null),
                                first_value(t.core_company_kf) over (partition by t.company_code order by t.core_company_id, t.core_company_kf rows between unbounded preceding and unbounded following)) default_core_company_kf,
                       coalesce(min(case when t.core_company_kf = c.core_customer_kf and t.core_company_id = c.core_customer_id then
                                              t.core_company_id
                                         else null
                                    end) over (partition by t.company_code order by null),
                                first_value(t.core_company_id) over (partition by t.company_code order by t.core_company_id, t.core_company_kf rows between unbounded preceding and unbounded following)) default_core_company_id
                from   tmp_company t
                left join nbu_reported_customer c on c.customer_code = t.company_code) s
         on (a.core_company_kf = s.core_company_kf and
             a.core_company_id = s.core_company_id)
         when matched then update
              set a.default_core_company_kf = s.default_core_company_kf,
                  a.default_core_company_id = s.default_core_company_id;
     end;

     procedure gather_person_data(
         p_report_id in integer)
     is
         l_data_type_id integer;
     begin
         l_data_type_id := nbu_core_service.get_request_type_id(nbu_core_service.REQ_TYPE_PERSON);

         update core_person_fo t
         set    t.person_code = make_person_code(p_report_id, t.inn, t.rnk, t.kf, t.isrez)
         where  t.request_id in (select r.id
                                 from   nbu_core_data_request r
                                 where  r.report_id = p_report_id and
                                        r.data_type_id = l_data_type_id);

         update core_person_fo t
         set    t.status = 'INVALID',
                t.status_message = 'Не дійсне значення ідентифікаційного коду: ' || t.inn
         where  t.person_code is null and
                t.request_id in (select r.id
                                 from   nbu_core_data_request r
                                 where  r.report_id = p_report_id and
                                        r.data_type_id = l_data_type_id);

         insert into tmp_person
         select t.person_code,  -- person_code varchar2(30 char),
                null,           -- total_loans_amount number(38),
                t.request_id,   -- request_id number(38),
                t.kf,           -- core_person_kf varchar2(6 char),
                t.rnk,          -- core_person_id number(38),
                null,           -- default_core_person_kf varchar2(6 char),
                null            -- default_core_person_id number(38)
         from   core_person_fo t
         where  t.request_id in (select min(r.id) keep (dense_rank last order by r.id)
                                 from   nbu_core_data_request r
                                 where  r.data_type_id = l_data_type_id and
                                        r.state_id in (nbu_core_service.REQ_STATE_DATA_DELIVERED, nbu_core_service.REQ_STATE_INCLUDED_IN_REPORT)
                                 group by r.kf);

         -- поєднаємо виборку даних з регіонів з об'єктами, що вже відправлялися або підготовлені до відправки в НБУ
         -- визначаємо який із ідентифікаторів (RNK) компанії в РУ (записи з одним і тим самим кодом ЄДРПОУ) буде надавати дані для передачі до НБУ
         merge into tmp_person a
         using (select t.core_person_kf, t.core_person_id,
                       coalesce(min(case when t.core_person_kf = c.core_customer_kf and t.core_person_id = c.core_customer_id then
                                              t.core_person_kf
                                         else null
                                    end) over (partition by t.person_code order by null),
                                first_value(t.core_person_kf) over (partition by t.person_code order by t.core_person_id, t.core_person_kf rows between unbounded preceding and unbounded following)) default_core_person_kf,
                       coalesce(min(case when t.core_person_kf = c.core_customer_kf and t.core_person_id = c.core_customer_id then
                                              t.core_person_id
                                         else null
                                    end) over (partition by t.person_code order by null),
                                first_value(t.core_person_id) over (partition by t.person_code order by t.core_person_id, t.core_person_kf rows between unbounded preceding and unbounded following)) default_core_person_id
                from   tmp_person t
                left join nbu_reported_customer c on c.customer_code = t.person_code) s
         on (a.core_person_kf = s.core_person_kf and a.core_person_id = s.core_person_id)
         when matched then update
              set a.default_core_person_kf = s.default_core_person_kf,
                  a.default_core_person_id = s.default_core_person_id;
     end;

     procedure gather_pledge_data(
         p_report_id in integer)
     is
         l_data_type_id integer;
     begin
         l_data_type_id := nbu_core_service.get_request_type_id(nbu_core_service.REQ_TYPE_PLEDGE);

         update core_pledge_dep t
         set    t.status = 'INVALID',
                t.status_message = 'Ключові реквізити (номер договору або дата початку дії) не заповнені'
         where  (t.numberpledge is null or t.pledgeday is null) and
                t.request_id in (select r.id
                                 from   nbu_core_data_request r
                                 where  r.report_id = p_report_id and
                                        r.data_type_id = l_data_type_id);

         insert into tmp_pledge
         select coalesce(c.company_code, p.person_code),  -- customer_code varchar2(4000 byte),
                t.numberpledge,                           -- pledge_number varchar2(4000 byte),
                t.pledgeday,                              -- pledge_date date,
                t.request_id,                             -- request_id number(38),
                t.kf,                                     -- core_pledge_kf varchar2(6 char),
                t.acc,                                    -- core_pledge_id number(38),
                t.rnk,                                    -- core_customer_id number(38)
                null,                                     -- default_pledge_core_kf varchar2(6 char),
                null,                                      -- default_pledge_core_id number(38)
                t.s031                                    -- varchar2
         from   core_pledge_dep t
         left join tmp_company c on c.core_company_kf = t.kf and c.core_company_id = t.rnk
         left join tmp_person p on p.core_person_kf = t.kf and p.core_person_id = t.rnk
         where  t.request_id in (select max(r.id)
                                 from   nbu_core_data_request r
                                 where  r.data_type_id = l_data_type_id and
                                        r.state_id in (nbu_core_service.REQ_STATE_DATA_DELIVERED, nbu_core_service.REQ_STATE_INCLUDED_IN_REPORT)
                                 group by r.kf);

       --при добавлении типа и порядкового номера мердж нам не нужен
         merge into tmp_pledge a
         using (select t.core_pledge_kf, t.core_pledge_id,
                       coalesce(min(case when t.core_pledge_kf = l.core_pledge_kf and t.core_pledge_id = l.core_pledge_id then
                                              t.core_pledge_kf
                                         else null
                                    end) over (partition by t.customer_code, t.pledge_number, t.pledge_date order by null),
                                first_value(t.core_pledge_kf) over (partition by t.customer_code, t.pledge_number, t.pledge_date
                                                                  order by t.pledge_date, t.core_pledge_id
                                                                  rows between unbounded preceding and unbounded following)) default_core_pledge_kf,
                       coalesce(min(case when t.core_pledge_kf = l.core_pledge_kf and t.core_pledge_id = l.core_pledge_id then
                                              t.core_pledge_id
                                         else null
                                    end) over (partition by t.customer_code, t.pledge_number, t.pledge_date order by null),
                                first_value(t.core_pledge_id) over (partition by t.customer_code, t.pledge_number, t.pledge_date
                                                                  order by t.pledge_date, t.core_pledge_id
                                                                  rows between unbounded preceding and unbounded following)) default_core_pledge_id
                from   tmp_pledge t
                left join nbu_reported_customer c on c.customer_code = t.customer_code
                left join nbu_reported_pledge l on l.customer_object_id = c.id and l.pledge_number = t.pledge_number and l.pledge_date = t.pledge_date) s
         on (a.core_pledge_kf = s.core_pledge_kf and
             a.core_pledge_id = s.core_pledge_id)
         when matched then update
              set a.default_core_pledge_kf = s.default_core_pledge_kf,
                  a.default_core_pledge_id = s.default_core_pledge_id;
     end;

     procedure gather_loan_data(
         p_report_id in integer)
     is
         l_data_type_id integer;
     begin
         initialize_exchange_rates();

         l_data_type_id := nbu_core_service.get_request_type_id(nbu_core_service.REQ_TYPE_LOAN);

         update core_credit t
         set    t.status = 'INVALID',
                t.status_message = 'Ключові реквізити (номер договору або дата початку дії) не заповнені'
         where  (t.numdog is null or t.dogday is null) and
                t.request_id in (select r.id
                                 from   nbu_core_data_request r
                                 where  r.report_id = p_report_id and
                                        r.data_type_id = l_data_type_id);

         insert into tmp_loan
         select coalesce(c.company_code, p.person_code),               -- customer_code varchar2(4000 byte),
                t.numdog,                                              -- loan_number varchar2(4000 byte),
                t.dogday,                                              -- loan_date date,
                abs(t.sumzagal) * get_exchange_rate(t.r030),               -- loan_amount number(38),
                t.request_id,                                          -- request_id number(38),
                t.kf,                                                  -- core_loan_kf varchar2(6 char),
                t.nd,                                                  -- core_loan_id number(38),
                t.rnk,                                                 -- core_customer_id number(38)
                null,                                                  -- default_core_loan_kf varchar2(6 char)
                null                                                   -- default_core_loan_id number(38)
         from   core_credit t
         left join tmp_company c on c.core_company_kf = t.kf and c.core_company_id = t.rnk
         left join tmp_person p on p.core_person_kf = t.kf and p.core_person_id = t.rnk
         where  -- t.sumzagal < 0 and
                t.request_id in (select max(r.id)
                                 from   nbu_core_data_request r
                                 where  r.data_type_id = l_data_type_id and
                                        r.state_id in (nbu_core_service.REQ_STATE_DATA_DELIVERED, nbu_core_service.REQ_STATE_INCLUDED_IN_REPORT)
                                 group by r.kf);

         merge into tmp_loan a
         using (select t.core_loan_kf, t.core_loan_id,
                       coalesce(min(case when t.core_loan_kf = l.core_loan_kf and t.core_loan_id = l.core_loan_id then
                                              t.core_loan_kf
                                         else null
                                    end) over (partition by t.customer_code, t.loan_number, t.loan_date order by null),
                                first_value(t.core_loan_kf) over (partition by t.customer_code, t.loan_number, t.loan_date
                                                                  order by t.loan_date, t.core_loan_id
                                                                  rows between unbounded preceding and unbounded following)) default_core_loan_kf,
                       coalesce(min(case when t.core_loan_kf = l.core_loan_kf and t.core_loan_id = l.core_loan_id then
                                              t.core_loan_id
                                         else null
                                    end) over (partition by t.customer_code, t.loan_number, t.loan_date order by null),
                                first_value(t.core_loan_id) over (partition by t.customer_code, t.loan_number, t.loan_date
                                                                  order by t.loan_date, t.core_loan_id
                                                                  rows between unbounded preceding and unbounded following)) default_core_loan_id
                from   tmp_loan t
                left join nbu_reported_customer c on c.customer_code = t.customer_code
                left join nbu_reported_loan l on l.customer_object_id = c.id and l.loan_number = t.loan_number and l.loan_date = t.loan_date) s
         on (a.core_loan_kf = s.core_loan_kf and
             a.core_loan_id = s.core_loan_id)
         when matched then update
              set a.default_core_loan_kf = s.default_core_loan_kf,
                  a.default_core_loan_id = s.default_core_loan_id;
     end;

     procedure gather_total_loan_amounts
     is
     begin
         merge into tmp_company a
         using (select d.core_company_kf, d.core_company_id, min(d.total_loans_amount) keep (dense_rank first order by null) total_loans_amount
                from   (select c.core_company_kf, c.core_company_id,
                               sum(l.loan_amount) over (partition by c.company_code order by null) total_loans_amount
                        from   tmp_company c
                        left join tmp_loan l on l.core_loan_kf = c.core_company_kf and l.core_customer_id = c.core_company_id) d
                group by d.core_company_kf, d.core_company_id) s
         on (a.core_company_kf = s.core_company_kf and
             a.core_company_id = s.core_company_id)
         when matched then update
              set a.total_loans_amount = nvl(s.total_loans_amount, 0);

         merge into tmp_person a
         using (select d.core_person_kf, d.core_person_id,
                       min(d.total_loans_amount) keep (dense_rank first order by null) total_loans_amount
                from   (select c.core_person_kf, c.core_person_id,
                               sum(l.loan_amount) over (partition by c.person_code order by null) total_loans_amount
                        from   tmp_person c
                        left join tmp_loan l on l.core_loan_kf = c.core_person_kf and l.core_customer_id = c.core_person_id) d
                group by d.core_person_kf, d.core_person_id) s
         on (a.core_person_kf = s.core_person_kf and
             a.core_person_id = s.core_person_id)
         when matched then update
              set a.total_loans_amount = nvl(s.total_loans_amount, 0);
     end;

     procedure process_company_data(
         p_report_id in integer)
     is
         l_bottom_line number := 5000000;
         l_company t_core_company;
         l_previous_company t_core_company;
         l_is_valid boolean;
         l_validation_message varchar2(4000 byte);
         l_min_salary varchar(10);
     begin
         -- деактивуємо компанії, коди яких більше не існують
         for i in (select c.id, c.customer_code
                   from   nbu_reported_customer c
                   join   nbu_reported_object o on o.id = c.id and
                                                   o.object_type_id = nbu_object_utl.OBJ_TYPE_COMPANY and
                                                   o.state_id in (nbu_object_utl.OBJ_STATE_NEW,
                                                                  -- nbu_object_utl.OBJ_STATE_MODIFIED,
                                                                  nbu_object_utl.OBJ_STATE_REPORTED)
                   where  c.customer_code not in (select t.company_code
                                                  from   tmp_company t
                                                  where  t.company_code is not null)) loop

             nbu_object_utl.dismiss_object(i.id, 'Код юридичної особи {' || i.customer_code || '} деактивується у зв''язку з його відсутністю в поточній версії даних АБС');
         end loop;

         -- TODO : переделать на индивидуальную обработку по каждой записи

         -- оскільки індекс по ідентифікатору юридичної особи в nbu_reported_company унікальний, для того щоб уникнути можливого дублювання (у разі порушення порядку вставки/оновлення даних)
         -- попередньо очищуємо зв'язок об'єктів з даними юридичних осіб в АБС (якщо ці зв'язки змінилися) перед тим як заповнювати їх новими значеннями
         for i in (select c.id, t.company_code, t.default_core_company_kf, t.default_core_company_id
                   from   tmp_company t
                   join   nbu_reported_customer c on (/*t.company_code is null or */c.customer_code <> t.company_code) and
                                                     c.core_customer_kf = t.default_core_company_kf and
                                                     c.core_customer_id = t.default_core_company_id
                   join   nbu_reported_object o on o.id = c.id and
                                                   o.object_type_id = nbu_object_utl.OBJ_TYPE_COMPANY) loop

             nbu_object_utl.set_customer_core_id(i.id, null, null);
         end loop;

         for i in (select t.*, c.id customer_object_id
                   from   tmp_company t
                   left join nbu_reported_customer c on c.customer_code = t.company_code
                   where  t.company_code is not null) loop

             begin
               --- добавляем проверку на мин зарплату!
              select attribute_value into l_min_salary from  bars.branch_attribute_value where attribute_code='$BASE';
               if  (i.total_loans_amount >=(l_min_salary*10000)) then
                   update core_person_uo p set isKr=1 where p.rnk=i.core_company_id and p.request_id=i.request_id;
                   else
                   update core_person_uo p set isKr=0 where p.rnk=i.core_company_id and p.request_id=i.request_id;
               end if;

                 if (i.total_loans_amount >= l_bottom_line or i.customer_object_id is not null) then
                     -- якщо сума заборгованості перевищує граничне значення (-i.total_loans_amount >= l_bottom_line)
                     -- або ми хоча б раз відправляли відомості по даному клієнту до НБУ (i.company_object_id is not null)
                     -- починаємо обробку цих записів
                     if (i.core_company_kf = i.default_core_company_kf and i.core_company_id = i.default_core_company_id) then

                         l_company := t_core_company(p_report_id, i.core_company_id, i.core_company_kf);

                         l_company.perform_check(l_is_valid, l_validation_message);

                         if (l_is_valid) then
                             if (l_company.reported_object_id is null) then
                                 nbu_object_utl.create_company(l_company);
                                 bars.tools.hide_hint(nbu_service_utl.arrange_post_session(p_report_id, l_company));
                             else
                                 l_previous_company := t_core_company(p_report_id - 1, i.core_company_id, i.core_company_kf);

                                 if (not l_company.equals(l_previous_company)) then
                                     nbu_object_utl.alter_company(l_company);
                                     bars.tools.hide_hint(nbu_service_utl.arrange_post_session(p_report_id, l_company));
                                 end if;
                             end if;

                             nbu_core_service.set_core_company_state(i.request_id,
                                                                     i.core_company_id,
                                                                     'ACCEPTED',
                                                                     null,
                                                                     i.default_core_company_id,
                                                                     i.default_core_company_kf,
                                                                     l_company.reported_object_id);
                         else
                             nbu_core_service.set_core_company_state(i.request_id,
                                                                     i.core_company_id,
                                                                     'INVALID',
                                                                     l_validation_message,
                                                                     i.default_core_company_id,
                                                                     i.default_core_company_kf,
                                                                     l_company.reported_object_id);
                         end if;
                     else
                         nbu_core_service.set_core_company_state(i.request_id,
                                                                 i.core_company_id,
                                                                 'DUPLICATE',
                                                                 'Для передачі даних до НБУ по клієнту з кодом {' || i.company_code ||
                                                                 '} використовується запис з РНК {' || i.default_core_company_id ||
                                                                 '} в філії {' || i.default_core_company_kf || '}',
                                                                 i.default_core_company_id,
                                                                 i.default_core_company_kf,
                                                                 null);
                     end if;
                 else
                     -- якщо суми не достатньо і по даному клієнту ніколи не передавалися відомості до НБУ, то і далі продовжуємо їх не передавати
                     nbu_core_service.set_core_company_state(i.request_id,
                                                             i.core_company_id,
                                                             'INSUFFICIENT_AMOUNT',
                                                             'Загальна сума заборгованості {' || to_char(nvl(i.total_loans_amount, 0) / 100, 'FM99999999990.00') ||
                                                             ' грн.} менша за граничне значення {' || to_char(l_bottom_line / 100, 'FM999990.00') || ' грн.}',
                                                             i.default_core_company_id,
                                                             i.default_core_company_kf,
                                                             null);
                 end if;
             exception
                 when others then
                      nbu_core_service.set_core_company_state(i.request_id,
                                                              i.core_company_id,
                                                              'ERROR',
                                                              sqlerrm || bars.tools.crlf ||
                                                                      dbms_utility.format_error_backtrace(),
                                                              i.default_core_company_id,
                                                              i.default_core_company_kf,
                                                              null);
             end;
         end loop;
     end;

     procedure process_person_data(
         p_report_id in integer)
     is
         l_bottom_line number := 5000000;
         l_person t_core_person;
         l_previous_person t_core_person;
         l_is_valid boolean;
         l_validation_message varchar2(4000 byte);
         l_min_salary varchar(10);
     begin
         -- деактивуємо компанії, коди яких більше не існують
         for i in (select p.id, p.customer_code
                   from   nbu_reported_customer p
                   join   nbu_reported_object o on o.id = p.id and
                                                   o.object_type_id = nbu_object_utl.OBJ_TYPE_PERSON and
                                                   o.state_id in (nbu_object_utl.OBJ_STATE_NEW,
                                                                  -- nbu_object_utl.OBJ_STATE_MODIFIED,
                                                                  nbu_object_utl.OBJ_STATE_REPORTED)
                   where  p.customer_code not in (select t.person_code
                                                  from  tmp_person t
                                                  where t.person_code is not null)) loop

             nbu_object_utl.dismiss_object(i.id, 'Код фізичної особи {' || i.customer_code || '} деактивується у зв''язку з його відсутністю в поточній версії даних АБС');
         end loop;

         for i in (select c.id
                   from   tmp_person t
                   join   nbu_reported_customer c on c.customer_code <> t.person_code and
                                                     c.core_customer_kf = t.default_core_person_kf and
                                                     c.core_customer_id = t.default_core_person_id
                   join   nbu_reported_object o on o.id = c.id and
                                                   o.object_type_id = nbu_object_utl.OBJ_TYPE_PERSON) loop

             nbu_object_utl.set_customer_core_id(i.id, null, null);
         end loop;

         for i in (select t.*, c.id customer_object_id from tmp_person t
                   left join nbu_reported_customer c on c.customer_code = t.person_code
                   where  t.person_code is not null) loop
             begin
              --- добавляем проверку на мин зарплату!
              select attribute_value into l_min_salary from  bars.branch_attribute_value where attribute_code='$BASE';
               if  (i.total_loans_amount >=(l_min_salary*10000)) then
                   update core_person_fo f set isKr=1 where f.rnk=i.core_person_id and f.request_id=i.request_id;
                   else
                   update core_person_fo f set isKr=0 where f.rnk=i.core_person_id and f.request_id=i.request_id;
               end if;

                 if (i.total_loans_amount >= l_bottom_line or i.customer_object_id is not null) then
                     -- якщо сума заборгованості перевищує граничне значення (-i.total_loans_amount >= l_bottom_line)
                     -- або ми хоча б раз відправляли відомості по даному клієнту до НБУ (i.person_object_id is not null)
                     -- починаємо обробку цих записів
                     if (i.core_person_kf = i.default_core_person_kf and i.core_person_id = i.default_core_person_id) then

                         -- TODO : перевіряти наявність вже запланованих але ще не підписаних сесій і синхронізувати їх

                         l_person := t_core_person(p_report_id, i.core_person_id, i.core_person_kf);

                         l_person.perform_check(l_is_valid, l_validation_message);

                         if (l_is_valid) then
                             if (l_person.reported_object_id is null) then
                                 nbu_object_utl.create_person(l_person);
                                 bars.tools.hide_hint(nbu_service_utl.arrange_post_session(p_report_id, l_person));
                             else
                                 l_previous_person := t_core_person(p_report_id - 1, i.core_person_id, i.core_person_kf);

                                 if (not l_person.equals(l_previous_person)) then
                                     nbu_object_utl.alter_person(l_person);
                                     bars.tools.hide_hint(nbu_service_utl.arrange_post_session(p_report_id, l_person));
                                 end if;
                             end if;

                             nbu_core_service.set_core_person_state(i.request_id,
                                                                    i.core_person_id,
                                                                    'ACCEPTED',
                                                                    null,
                                                                    i.default_core_person_id,
                                                                    i.default_core_person_kf,
                                                                    l_person.reported_object_id);
                         else
                             nbu_core_service.set_core_person_state(i.request_id,
                                                                    i.core_person_id,
                                                                    'INVALID',
                                                                    l_validation_message,
                                                                    i.default_core_person_id,
                                                                    i.default_core_person_kf,
                                                                    l_person.reported_object_id);
                         end if;
                     else
                         nbu_core_service.set_core_person_state(i.request_id,
                                                                i.core_person_id,
                                                                'DUPLICATE',
                                                                'Для передачі даних до НБУ по клієнту з кодом {' || i.person_code ||
                                                                '} використовується запис з РНК {' || i.default_core_person_id ||
                                                                '} в філії {' || i.default_core_person_kf || '}',
                                                                i.default_core_person_id,
                                                                i.default_core_person_kf,
                                                                null);
                     end if;
                 else
                     -- якщо суми не достатньо і по даному клієнту ніколи не передавалися відомості до НБУ, то і далі продовжуємо їх не передавати
                     nbu_core_service.set_core_person_state(i.request_id,
                                                             i.core_person_id,
                                                             'INSUFFICIENT_AMOUNT',
                                                             'Загальна сума заборгованості {' || to_char(nvl(i.total_loans_amount, 0) / 100, 'FM99999999990.00') ||
                                                             ' грн.} менша за граничне значення {' || to_char(l_bottom_line / 100, 'FM999990.00') || ' грн.}',
                                                             i.default_core_person_id,
                                                             i.default_core_person_kf,
                                                             null);
                 end if;
             exception
                 when others then
                      nbu_core_service.set_core_person_state(i.request_id,
                                                             i.core_person_id,
                                                             'ERROR',
                                                             sqlerrm || bars.tools.crlf ||
                                                                        dbms_utility.format_error_backtrace(),
                                                             i.default_core_person_id,
                                                             i.default_core_person_kf,
                                                             null);
             end;
         end loop;
     end;

     procedure process_pledge_data(
         p_report_id in integer)
     is
         l_pledge t_core_pledge;
         l_previous_pledge t_core_pledge;
         l_is_valid boolean;
         l_validation_message varchar2(4000 byte);
     begin
         -- деактивуємо застави, коди яких більше не існують
         for i in (select p.id, p.pledge_number, p.pledge_date, c.customer_code
                   from   nbu_reported_pledge p
                   join   nbu_reported_customer c on c.id = p.customer_object_id
                   where  (c.customer_code, p.pledge_number, p.pledge_date) not in (select t.customer_code, t.pledge_number, t.pledge_date
                                                                                    from   tmp_pledge t
                                                                                    where  t.customer_code is not null and
                                                                                           t.pledge_number is not null and
                                                                                           t.pledge_date is not null and
                                                                                           t.pledge_type is not null)) loop
             nbu_object_utl.dismiss_object(i.id, 'Застава з номером {' || i.pledge_number ||
                                                 '} на дату {' || i.pledge_date ||
                                                 '} для клієнта з кодом {' || i.customer_code ||
                                                 '} деактивується у зв''язку з його відсутністю в поточній версії даних АБС');
         end loop;

         for i in (select /*+Ordered*/
                          c.id
                   from   tmp_pledge t
                   join   nbu_reported_pledge p on p.core_pledge_kf = t.core_pledge_kf and p.core_pledge_id = t.core_pledge_id
                   join   nbu_reported_customer c on c.id = p.customer_object_id
                   where  c.customer_code <> t.customer_code or
                          p.pledge_number <> t.pledge_number or
                          p.pledge_date <> t.pledge_date) loop

             nbu_object_utl.set_pledge_core_id(i.id, null, null);
         end loop;

         for i in (select * from tmp_pledge t where t.pledge_number is not null and t.pledge_date is not null) loop
             begin
               if (i.core_pledge_kf = i.default_core_pledge_kf and i.core_pledge_id = i.default_core_pledge_id) then
                     l_pledge := t_core_pledge(p_report_id, i.core_pledge_id, i.core_pledge_kf);

                     if (l_pledge.customer_id is not null) then
                         if (l_pledge.reported_object_id is not null or l_pledge.sumpledge > 0) then
                             l_pledge.perform_check(l_is_valid, l_validation_message);

                             if (l_is_valid) then
                                 if (l_pledge.reported_object_id is null) then
                                     nbu_object_utl.create_pledge(l_pledge);
                                     bars.tools.hide_hint(nbu_service_utl.arrange_pledge_session(p_report_id, l_pledge));
                                 else
                                     l_previous_pledge := t_core_pledge(p_report_id - 1, i.core_pledge_id, i.core_pledge_kf);

                                     if (not l_pledge.equals(l_previous_pledge)) then
                                         nbu_object_utl.alter_pledge(l_pledge);
                                         bars.tools.hide_hint(nbu_service_utl.arrange_pledge_session(p_report_id, l_pledge));
                                     end if;
                                 end if;

                                 nbu_core_service.set_core_pledge_state(i.request_id,
                                                                        i.core_pledge_id,
                                                                        'ACCEPTED',
                                                                        null,
                                                                        i.default_core_pledge_id,
                                                                        i.default_core_pledge_kf,
                                                                        l_pledge.reported_object_id);
                             else
                                 nbu_core_service.set_core_pledge_state(i.request_id,
                                                                        i.core_pledge_id,
                                                                        'INVALID',
                                                                        l_validation_message,
                                                                        i.default_core_pledge_id,
                                                                        i.default_core_pledge_kf,
                                                                        l_pledge.reported_object_id);
                             end if;
                         else
                             nbu_core_service.set_core_credit_state(i.request_id,
                                                                    i.core_pledge_id,
                                                                    'DECLINED',
                                                                    'Сума договору застави складає {' || l_pledge.sumpledge ||
                                                                        '} - договір не підлягає передачі до НБУ',
                                                                    i.default_core_pledge_id,
                                                                    i.default_core_pledge_kf,
                                                                    null);
                         end if;
                     else
                         nbu_core_service.set_core_pledge_state(i.request_id,
                                                                i.core_pledge_id,
                                                                'DECLINED',
                                                                'Клієнт-власник застави з ідентифікатором {' || l_pledge.core_customer_id || '/' || l_pledge.core_object_kf ||
                                                                    '} не підлягає передачі до НБУ',
                                                                i.default_core_pledge_id,
                                                                i.default_core_pledge_kf,
                                                                null);
                     end if;
                 else
                     nbu_core_service.set_core_pledge_state(i.request_id,
                                                            i.core_pledge_id,
                                                            'DUPLICATE',
                                                            'Для передачі даних до НБУ по заставі з номером {' || i.pledge_number ||
                                                            '} від {' || to_char(i.pledge_date, 'dd.mm.yyyy') ||
                                                            '} використовується запис з ідентифікатором {' || i.default_core_pledge_id ||
                                                            '} в філії {' || i.default_core_pledge_kf || '}',
                                                            i.default_core_pledge_id,
                                                            i.default_core_pledge_kf,
                                                            null);
                 end if;
             exception
                 when others then
                      nbu_core_service.set_core_pledge_state(i.request_id,
                                                             i.core_pledge_id,
                                                             'ERROR',
                                                             sqlerrm || bars.tools.crlf ||
                                                                        dbms_utility.format_error_backtrace(),
                                                             i.default_core_pledge_id,
                                                             i.default_core_pledge_kf,
                                                             null);
             end;
         end loop;
     end;

     procedure process_loan_data(
         p_report_id in integer)
     is
         l_loan t_core_loan;
         l_previous_loan t_core_loan;
         l_is_valid boolean;
         l_validation_message varchar2(4000 byte);
     begin
         -- деактивуємо застави, коди яких більше не існують
         for i in (select p.id, p.loan_number, p.loan_date, c.customer_code
                   from   nbu_reported_loan p
                   join   nbu_reported_customer c on c.id = p.customer_object_id
                   where  (c.customer_code, p.loan_number, p.loan_date) not in (select t.customer_code, t.loan_number, t.loan_date
                                                                                from   tmp_loan t
                                                                                where  t.customer_code is not null and
                                                                                       t.loan_number is not null and
                                                                                       t.loan_date is not null)) loop
             nbu_object_utl.dismiss_object(i.id, 'Кредит з номером {' || i.loan_number ||
                                                 '} на дату {' || i.loan_date ||
                                                 '} для клієнта з кодом {' || i.customer_code ||
                                                 '} деактивується у зв''язку з його відсутністю в поточній версії даних АБС');
         end loop;

         for i in (select /*+Ordered*/
                          c.id
                   from   tmp_loan t
                   join   nbu_reported_loan p on p.core_loan_kf = t.core_loan_kf and p.core_loan_id = t.core_loan_id
                   join   nbu_reported_customer c on c.id = p.customer_object_id
                   where  c.customer_code <> t.customer_code or
                          p.loan_number <> t.loan_number or
                          p.loan_date <> t.loan_date) loop

             nbu_object_utl.set_loan_core_id(i.id, null, null);
         end loop;

         for i in (select * from tmp_loan t where t.loan_number is not null and t.loan_date is not null) loop
             begin
                 if (i.core_loan_kf = i.default_core_loan_kf and i.core_loan_id = i.default_core_loan_id) then
                     l_loan := t_core_loan(p_report_id, i.core_loan_id, i.core_loan_kf);

                     if (l_loan.customer_id is not null) then
                         if (l_loan.reported_object_id is not null or l_loan.sumzagal > 0) then
                             l_loan.perform_check(l_is_valid, l_validation_message);

                             if (l_is_valid) then
                                 if (l_loan.reported_object_id is null) then
                                     nbu_object_utl.create_loan(l_loan);
                                     bars.tools.hide_hint(nbu_service_utl.arrange_loan_session(p_report_id, l_loan));
                                 else
                                     l_previous_loan := t_core_loan(p_report_id - 1, i.core_loan_id, i.core_loan_kf);

                                     if (not l_loan.equals(l_previous_loan)) then
                                         nbu_object_utl.alter_loan(l_loan);
                                         bars.tools.hide_hint(nbu_service_utl.arrange_loan_session(p_report_id, l_loan));
                                     end if;
                                 end if;

                                 nbu_core_service.set_core_credit_state(i.request_id,
                                                                        i.core_loan_id,
                                                                        'ACCEPTED',
                                                                        null,
                                                                        i.default_core_loan_id,
                                                                        i.default_core_loan_kf,
                                                                        l_loan.reported_object_id);
                             else
                                 nbu_core_service.set_core_credit_state(i.request_id,
                                                                        i.core_loan_id,
                                                                        'INVALID',
                                                                        l_validation_message,
                                                                        i.default_core_loan_id,
                                                                        i.default_core_loan_kf,
                                                                        l_loan.reported_object_id);
                             end if;
                         else
                             nbu_core_service.set_core_credit_state(i.request_id,
                                                                    i.core_loan_id,
                                                                    'DECLINED',
                                                                    'Сума кредитного договору складає {' || l_loan.sumzagal ||
                                                                        '} - договір не підлягає передачі до НБУ',
                                                                    i.default_core_loan_id,
                                                                    i.default_core_loan_kf,
                                                                    null);
                         end if;
                     else
                         nbu_core_service.set_core_credit_state(i.request_id,
                                                                i.core_loan_id,
                                                                'DECLINED',
                                                                'Клієнт-позичальник з ідентифікатором {' || l_loan.core_customer_id || '/' || l_loan.core_object_kf ||
                                                                    '} не підлягає передачі до НБУ',
                                                                i.default_core_loan_id,
                                                                i.default_core_loan_kf,
                                                                null);
                     end if;
                 else
                     nbu_core_service.set_core_credit_state(i.request_id,
                                                            i.core_loan_id,
                                                            'DUPLICATE',
                                                            'Для передачі даних до НБУ по кредитному договору з номером {' || i.loan_number ||
                                                            '} від {' || to_char(i.loan_date, 'dd.mm.yyyy') ||
                                                            '} використовується запис з ідентифікатором {' || i.default_core_loan_id ||
                                                            '} в філії {' || i.default_core_loan_kf || '}',
                                                            i.default_core_loan_id,
                                                            i.default_core_loan_kf,
                                                            null);
                 end if;
             exception
                 when others then
                      nbu_core_service.set_core_credit_state(i.request_id,
                                                             i.core_loan_id,
                                                             'ERROR',
                                                             sqlerrm || bars.tools.crlf ||
                                                                        dbms_utility.format_error_backtrace(),
                                                             i.default_core_loan_id,
                                                             i.default_core_loan_kf,
                                                             null);
             end;
         end loop;
     end;

     procedure gather_data(
         p_report_id in integer)
     is
     begin
         -- TODO : закрити всі запити даних на прийом - як тільки починається консолідація даних, дані з РУ більше не приймаються

         gather_company_data(p_report_id);

         gather_person_data(p_report_id);

         gather_pledge_data(p_report_id);

         gather_loan_data(p_report_id);

         gather_total_loan_amounts();

         process_company_data(p_report_id);

         process_person_data(p_report_id);

         process_pledge_data(p_report_id);

         process_loan_data(p_report_id);

         set_report_state(p_report_id, nbu_data_service.REP_STAGE_TRANSFERING, null);
     end;

     procedure ensure_wrapper_program(
         p_action              in varchar2,
         p_description         in varchar2)
     is
         l_prog_number_of_arguments integer default 0;
         l_program_availability varchar2(30 char);
     begin
         begin
             select t.number_of_arguments, t.enabled
             into   l_prog_number_of_arguments, l_program_availability
             from   user_scheduler_programs t
             where  t.program_name = DATA_CONSOLIDAT_PROGRAM_NAME;

             if (l_prog_number_of_arguments <> 1) then
                 if (l_program_availability = 'TRUE') then
                     dbms_scheduler.disable(name => DATA_CONSOLIDAT_PROGRAM_NAME, force => true);
                     l_program_availability := 'FALSE';
                 end if;

                 sys.dbms_scheduler.set_attribute(name => DATA_CONSOLIDAT_PROGRAM_NAME,
                                                  attribute => 'number_of_arguments',
                                                  value => 1);
             end if;
         exception
             when no_data_found then
                  dbms_scheduler.create_program(program_name        => 'NBU_GATEWAY.' || DATA_CONSOLIDAT_PROGRAM_NAME,
                                                program_type        => 'STORED_PROCEDURE',
                                                program_action      => p_action,
                                                number_of_arguments => 1,
                                                enabled             => false,
                                                comments            => p_description);
                  l_program_availability := 'FALSE';
         end;

         dbms_scheduler.define_program_argument(program_name      => DATA_CONSOLIDAT_PROGRAM_NAME,
                                                argument_position => 1,
                                                argument_name     => 'p_report_id',
                                                argument_type     => 'number');

         if (l_program_availability = 'FALSE') then
             sys.dbms_scheduler.enable(name => DATA_CONSOLIDAT_PROGRAM_NAME);
         end if;
     end;

     procedure ensure_wrapper_job(
         p_job_name in varchar2,
         p_description in varchar2)
     is
         l_job_existance_flag integer;
     begin
         begin
             select 1
             into   l_job_existance_flag
             from   user_scheduler_jobs t
             where  t.job_name = p_job_name;
         exception
             when no_data_found then
                  dbms_scheduler.create_job(job_name     => p_job_name,
                                            program_name => DATA_CONSOLIDAT_PROGRAM_NAME,
                                            auto_drop    => false,
                                            comments     => p_description,
                                            enabled      => false);
         end;
 /*
         dbms_scheduler.set_attribute(name      => p_job_name,
                                      attribute => 'RAISE_EVENTS',
                                      value     => \*dbms_scheduler.JOB_SUCCEEDED + *\dbms_scheduler.JOB_FAILED + dbms_scheduler.JOB_STOPPED);
 */
     end;

     procedure start_report
     is
         l_reporting_date date := trunc(sysdate, 'mm');
         l_report_id integer;
         l_new_data_exist_flag boolean := false;
         l_job_name varchar2(70 char) := 'NBU601_DATA_CONSOLIDATIONJ';

         job_is_running exception;
         pragma exception_init(job_is_running, -27478);
     begin
         l_report_id := create_report_instance(l_reporting_date);

         for i in (select * from nbu_core_data_request r
                   where  r.reporting_date = l_reporting_date and
                          r.state_id = nbu_core_service.REQ_STATE_DATA_DELIVERED and
                          r.report_id is null
                   for update nowait) loop
             l_new_data_exist_flag := true;
             nbu_core_service.include_request_to_report(i.id, l_report_id);
         end loop;

         if (not l_new_data_exist_flag) then
             raise_application_error(-20000, 'Відсутні нові дані для формування звіту');
         end if;

         set_report_state(l_report_id, nbu_data_service.REP_STAGE_CONSOLIDATION, null);

         commit;

         ensure_wrapper_program('nbu_data_service.gather_data',
                                'Процедура консолідації даних для формування 601-ї форми');

         ensure_wrapper_job(l_job_name, 'Процедура консолідації даних для формування 601-ї форми');

         dbms_scheduler.set_job_argument_value(job_name       => l_job_name,
                                               argument_name  => 'p_report_id',
                                               argument_value => l_report_id);

         begin
             dbms_scheduler.run_job(job_name => l_job_name, use_current_session => false);
         exception
             when job_is_running then
                  null;
         end;
     end;
 end;
/
