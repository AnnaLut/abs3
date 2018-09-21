create or replace type t_core_company under t_core_object
(
    company_code            varchar2(30 char),                      -- унікальний код юридичної особи, що базується на ІПН, а за його відсутності використовуються паспортні дані
                                                                    -- або автоматично згенерований ідентифікатор для нерезидентів

    codman                  varchar2(4000 byte),                    -- кнікальний код боржника, наданий реєстром під час першого успішного прийому інформації про боржника
                                                                    -- (0 – якщо інформація про боржника надається вперше)

    nameur                  varchar2(254 char),                     -- найменування боржника

    isrez                   varchar2(5 char),                       -- ознака резидентності особи (true або false)
    codedrpou               varchar2(20 char),                      -- код ЄДРПОУ боржника
    registryday             date,                                   -- дата державної реєстрації юридичної особи
    numberregistry          varchar2(32 char),                      -- номер державної реєстрації юридичної особи
    k110                    varchar2(5 char),                       -- вид економічної діяльності
    ec_year                 date,                                   -- рік, за який визначено вид економічної діяльності (календарний рік)
    countrycodnerez         varchar2(3 char),                       -- країна реєстрації боржника – нерезидента

    -- розмір фінансових показників діяльності боржника (структура finperformance)
    sales                   number(32),                             -- показник сукупного обсягу реалізації (SALES)
    ebit                    number(32),                             -- показник фінансового результату від операційної діяльності (EBIT)
                                                                    -- не зазначається для фізичної особи–суб’єкта підприємницької діяльності
    ebitda                  number(32),                             -- показник фінансового результату від звичайної діяльності до оподаткування фінансових витрат і нарахування амортизації (EBITDA)
                                                                    -- не зазначається для фізичної особи–суб’єкта підприємницької діяльності
    totaldebt               number(32),                             -- показник концентрації залучених коштів (TOTAL NET DEBT)

    ismember                varchar2(5 char),                       -- приналежність боржника до групи юридичних осіб, що знаходяться під спільним контролем (true-так; false-ні)
                                                                    -- якщо боржник – фізична особа-суб’єкт підприємницької діяльності зазначається null
    iscontroller            varchar2(5 char),                       -- статус участі боржника в групі (true – материнська компанія/контролер; false – учасник;
                                                                    -- null - якщо боржник не входить до групи юридичних осіб (тобто isMember має значення false)
                                                                    -- або боржник є фізичною особою - суб’єктом підприємницької  діяльності
    companies_group         t_core_company_group,                   -- Перелік юридичних осіб, що входять до групи юридичних осіб, що знаходяться під спільним контролем
    -- розмір фінансових показників діяльності групи юридичних осіб, що знаходяться під спільним контролем (структура finperformancegr)
    -- якщо боржник - юридична особа не входить до групи юридичних осіб, структура (елемент) finperformancegr не вказується
    salesgr                 number(32),                             -- показник сукупного обсягу реалізації  (SALES)
    ebitgr                  number(32),                             -- показник фінансового результату від операційної діяльності (EBIT)
    ebitdagr                number(32),                             -- показник фінансового результату від звичайної діяльності до оподаткування фінансових витрат і нарахування амортизації (EBITDA)
    totaldebtgr             number(32),                             -- показник концентрації залучених коштів (TOTAL NET DEBT)
    classgr                 varchar2(3 char),                       -- клас групи

    ispartner               varchar2(5 char),                       -- факт приналежності боржника до групи пов’язаних контрагентів, що несуть спільний економічний ризик
                                                                    -- (true - так; false - ні; якщо боржник – фізична особа-суб’єкт підприємницької діяльності, зазначається null)
    partners                t_core_company_partners,                -- перелік юридичних осіб, які належать до групи пов’язаних контрагентів (структура partners)
                                                                    -- якщо боржник - юридична особа не входить до групи пов’язаних контрагентів, структура partners не вказується
    -- розмір фінансових показників діяльності групи пов’язаних контрагентів (структура finperformancepr)
    -- якщо боржник-юридична особа не входить до групи пов’язаних контрагентів, структура finperformancepr не вказується
    salespr                 number(32),                             -- показник сукупного обсягу реалізації (SALES)
    ebitpr                  number(32),                             -- показник фінансового результату від операційної діяльності (EBIT)
                                                                    -- не зазначається для фізичної особи–суб’єкта підприємницької діяльності
    ebitdapr                number(32),                             -- показник фінансового результату від звичайної діяльності до оподаткування фінансових витрат і нарахування амортизації (EBITDA)
                                                                    -- не зазначається для фізичної особи–суб’єкта підприємницької діяльності
    totaldebtpr             number(32),                             -- показник концентрації залучених коштів (TOTAL NET DEBT)
                                                                    -- не зазначається для фізичної особи–суб’єкта підприємницької діяльності

    isaudit                 varchar2(5 char),                       -- факт проходження аудиту фінансової звітності (true-так; false-ні;
                                                                    -- якщо боржник–фізична особа - суб’єкт підприємницької  діяльності зазначається null)
    k060                    varchar2(2 char),                       -- тип пов’язаної з банком особи (не зазначається для фізичної особи–суб’єкта підприємницької діяльності)

    ownerpp                 t_core_company_owner_persons,           -- власники істотної участі – фізичні особи (структура ownerpp)
                                                                    -- якщо боржник є фізичною особою–підприємцем, структура ownerpp не вказується
    ownerjur                t_core_company_owner_companies,         -- власники істотної участі – юридичні особи (структура ownerjur)
                                                                    -- якщо боржник - юридична особа є фізичною особою – підприємцем, структура ownerjur не вказується
    k020                  VARCHAR2(20 char),
    coddocum              number(2),
    isKr                  number(1), 
    
    constructor function t_core_company(
        p_report_id in integer,
        p_company_id in integer,
        p_company_kf in varchar2)
    return self as result,

    overriding member procedure perform_check(
        p_is_valid out boolean,
        p_validation_message out varchar2),

    overriding member function get_json
    return clob,

    overriding member function equals(
        p_core_object in t_core_object)
    return boolean
)
/
create or replace type body t_core_company is

     constructor function t_core_company(
         p_report_id in integer,
         p_company_id in integer,
         p_company_kf in varchar2)
     return self as result
     is
         l_object_row nbu_reported_object%rowtype;
         l_customer_object_row nbu_reported_customer%rowtype;
         l_company_row core_person_uo%rowtype;
         l_company_performance_row core_finperformance_uo%rowtype;
         l_company_group_perf_row core_finperformancegr_uo%rowtype;
         l_company_part_perf_row core_finperformancepr_uo%rowtype;
     begin

         l_company_row := nbu_core_service.get_core_company_row(p_report_id, p_company_id, p_company_kf);

         if (l_company_row.rnk is null) then
             return;
         end if;

         l_company_performance_row := nbu_core_service.get_core_company_perf_row(p_report_id, p_company_id, p_company_kf);
         l_customer_object_row := nbu_object_utl.read_customer(l_company_row.codedrpou, p_raise_ndf => false);

         if (l_customer_object_row.id is not null) then
             l_object_row := nbu_object_utl.read_object(l_customer_object_row.id);
         end if;

         nameur          := l_company_row.nameur;
         isrez           := l_company_row.isrez;
         codedrpou       := l_company_row.codedrpou;
         registryday     := l_company_row.registryday;
         numberregistry  := l_company_row.numberregistry;
         k110            := l_company_row.k110;
         ec_year         := l_company_row.ec_year;
         countrycodnerez := l_company_row.countrycodnerez;

         sales           := l_company_performance_row.sales;
         ebit            := l_company_performance_row.ebit;
         ebitda          := l_company_performance_row.ebitda;
         totaldebt       := l_company_performance_row.totaldebt;

         coddocum        :=l_company_row.coddocum;
         k020            :=l_company_row.k020;
         isKR            :=l_company_row.iskr;

         ismember        := l_company_row.ismember;
         iscontroller    := l_company_row.iscontroller;

         if (ismember = 'true') then
             companies_group := nbu_core_service.get_core_company_group(p_report_id, p_company_id, p_company_kf);

             l_company_group_perf_row := nbu_core_service.get_core_company_gr_perf_row(p_report_id, p_company_id, p_company_kf);

             salesgr     := l_company_group_perf_row.salesgr;
             ebitgr      := l_company_group_perf_row.ebitgr;
             ebitdagr    := l_company_group_perf_row.ebitdagr;
             totaldebtgr := l_company_group_perf_row.totaldebtgr;
             classgr     := l_company_group_perf_row.classgr;
         end if;

         ispartner       := l_company_row.ispartner;

         if (ispartner = 'true') then
             partners := nbu_core_service.get_core_company_partners(p_report_id, p_company_id, p_company_kf);

             l_company_part_perf_row := nbu_core_service.get_core_company_part_perf_row(p_report_id, p_company_id, p_company_kf);

             salespr     := l_company_part_perf_row.sales;
             ebitpr      := l_company_part_perf_row.ebit;
             ebitdapr    := l_company_part_perf_row.ebitda;
             totaldebtpr := l_company_part_perf_row.totaldebt;
         end if;

         isaudit         := l_company_row.isaudit;
         k060            := bars.string_list(lpad(l_company_row.k060, 2, '0'));
         --k060            := l_company_row.k060;

         ownerpp         := nbu_core_service.get_core_company_owner_persons(p_report_id, p_company_id, p_company_kf);
         ownerjur        := nbu_core_service.get_core_company_owner_company(p_report_id, p_company_id, p_company_kf);

         codman          := l_object_row.external_id;
         company_code    := l_company_row.company_code;

         core_object_id  := p_company_id;
         core_object_kf  := p_company_kf;

         reported_object_id := l_object_row.id;
         external_object_id := l_object_row.external_id;

         return;
     end;

     overriding member procedure perform_check(
         p_is_valid out boolean,
         p_validation_message out varchar2)
     is
     begin
        p_is_valid := true;

        if (registryday is null) then
            p_validation_message := 'Не заповнена дата державної реєстрації';
            p_is_valid := false;
        end if;

        if (company_code is null) then
            p_validation_message := case when p_validation_message is null then null else p_validation_message || ', ' end || 'Не заповнений код ЄДРПОУ';
            p_is_valid := false;
        end if;
     end;

     overriding member function get_json
     return clob
     is
         l_clob clob;
         l_attributes bars.string_list := bars.string_list();
         l_group_members bars.string_list := bars.string_list();
         l_owner_persons bars.string_list := bars.string_list();
         l_owner_companies bars.string_list := bars.string_list();
         l_performance_keys bars.string_list := bars.string_list();
         l integer;
     begin
         l_attributes.extend(100);
         l_attributes(1) := json_utl.make_json_value('codMan', nvl(codman, '0'),p_mandatory => true);
         l_attributes(2) := json_utl.make_json_value('isRez', nvl(isrez, 'true'), p_mandatory => true);
         l_attributes(3) := json_utl.make_json_string('codEdrpou', company_code);
         l_attributes(4):=json_utl.make_json_value('codDocum',coddocum,p_mandatory => true);
         l_attributes(5):=json_utl.make_json_string('codK020',k020, p_mandatory => true);

         l_attributes(6) := json_utl.make_json_string('nameUr', nameur, p_mandatory => true);
         l_attributes(7) := json_utl.make_json_date('registryDay', registryday, p_mandatory => true);
         l_attributes(8) := json_utl.make_json_string('numberRegistry', numberregistry, p_mandatory => true);
         l_attributes(9) := json_utl.make_json_value('ecActivity', '{ ' || json_utl.make_json_string('k110', nvl(k110, 'ZZZZZ')) || ', ' ||
                                                                           json_utl.make_json_date('ec_year', nvl(ec_year, date '0001-01-01')) ||
                                                                    ' }');
         if (isrez = 'false') then
             l_attributes(10) := json_utl.make_json_string('countryCodNerez', countrycodnerez ,p_mandatory => true);
         end if;

         l_attributes(11) := json_utl.make_json_value('finPerformance', '{ ' ||
                                                                            json_utl.make_json_value('sales', nvl(sales, 0), p_mandatory => true) || ', ' ||
                                                                            json_utl.make_json_value('ebit', nvl(ebit, 0), p_mandatory => true) || ', ' ||
                                                                            json_utl.make_json_value('ebitda', nvl(ebitda, 0), p_mandatory => true) || ', ' ||
                                                                            json_utl.make_json_value('totalDebt', nvl(totaldebt, 0), p_mandatory => true) ||
                                                                       ' }');

         l_attributes(12) := json_utl.make_json_value('isMember', nvl(ismember, 'false'));
         l_attributes(13) := json_utl.make_json_value('isController', nvl(iscontroller, 'false'));

         if (companies_group is not null and companies_group is empty) then
             l_group_members.extend(companies_group.count);

             l := companies_group.first;
             while (l is not null) loop
                 if (companies_group(l) is not null) then
                     l_group_members(l) := companies_group(l).get_json();
                 end if;

                 l := companies_group.next(l);
             end loop;

             if (l_group_members.count > 1) then
                 l_attributes(14) := json_utl.make_json_value('groupUr', '[' || bars.tools.words_to_string(l_group_members, p_splitting_symbol => ', ', p_ignore_nulls => 'Y') || ']');
             else
                 l_attributes(14) := json_utl.make_json_value('groupUr', bars.tools.words_to_string(l_group_members, p_splitting_symbol => ', ', p_ignore_nulls => 'Y'));
             end if;

             l_attributes(15) := json_utl.make_json_value('finPerformanceGr', '{ ' ||
                                                                                   json_utl.make_json_value('sales', nvl(salesgr, 0), p_mandatory => true) || ', ' ||
                                                                                   json_utl.make_json_value('ebit', nvl(ebitgr, 0), p_mandatory => true) || ', ' ||
                                                                                   json_utl.make_json_value('ebitda', nvl(ebitdagr, 0), p_mandatory => true) || ', ' ||
                                                                                   json_utl.make_json_value('totalDebt', nvl(totaldebtgr, 0), p_mandatory => true) ||
                                                                              ' }');
         end if;

         l_attributes(16) := json_utl.make_json_value('isPartner', ispartner, p_mandatory => true);

         if (ispartner = 'true') then
             l_attributes(15) := json_utl.make_json_value('finPerformancePr', '{ ' ||
                                                                                   json_utl.make_json_value('sales', nvl(salespr, 0), p_mandatory => true) || ', ' ||
                                                                                   json_utl.make_json_value('ebit', nvl(ebitpr, 0), p_mandatory => true) || ', ' ||
                                                                                   json_utl.make_json_value('ebitda', nvl(ebitdapr, 0), p_mandatory => true) || ', ' ||
                                                                                   json_utl.make_json_value('totalDebt', nvl(totaldebtpr, 0), p_mandatory => true) ||
                                                                              ' }');
         end if;

         l_attributes(17) := json_utl.make_json_value('isAudit', nvl(isaudit, 'false'));

         l_attributes(18) := json_utl.make_json_value('k060',
                                                      '["' || nvl(bars.tools.words_to_string(k060, p_splitting_symbol => '", "', p_ignore_nulls => 'Y'), '99') || '"]',
                                                      p_mandatory => true);
        /* l_attributes(18) := json_utl.make_json_string('k060', k060 , p_mandatory => true);*/

         l_attributes(19) := json_utl.make_json_value('isKr',nvl(isKr,0));

         if (ownerpp is not null and ownerpp is not empty) then
             l_owner_persons.extend(ownerpp.count);
             l := ownerpp.first;
             while (l is not null) loop

                 l := ownerpp.next(l);
             end loop;
         end if;

         dbms_lob.createtemporary(l_clob, false);

         dbms_lob.append(l_clob, '{ "data": { ');

         l := l_attributes.first;
         while (l is not null) loop
             if (l_attributes(l) is not null) then
                 dbms_lob.append(l_clob, l_attributes(l) || ', ');
             end if;
             l := l_attributes.next(l);
         end loop;

         l_clob := rtrim(l_clob, ', ');
         dbms_lob.append(l_clob, '} }');

         return l_clob;
     end;

     overriding member function equals(
         p_core_object in t_core_object)
     return boolean
     is
         l_equals boolean;
         l_core_company t_core_company;
         l integer;
     begin
         if (p_core_object is null) then
             return null;
         end if;

         if (p_core_object is of (t_core_company)) then
             l_core_company := treat(p_core_object as t_core_company);
         else
             raise_application_error(-20000, 'Тип об''єкта з ідентифікатором {' || p_core_object.core_object_id || '/' || p_core_object.core_object_kf || '} не є Юридичною особою');
         end if;

         l_equals := bars.tools.equals(l_core_company.company_code    , company_code) and
                     bars.tools.equals(l_core_company.nameur          , nameur         ) and
                     bars.tools.equals(l_core_company.isrez           , isrez          ) and
                     bars.tools.equals(l_core_company.codedrpou       , codedrpou      ) and
                     bars.tools.equals(l_core_company.registryday     , registryday    ) and
                     bars.tools.equals(l_core_company.numberregistry  , numberregistry ) and
                     bars.tools.equals(l_core_company.k110            , k110           ) and
                     bars.tools.equals(l_core_company.ec_year         , ec_year        ) and
                     bars.tools.equals(l_core_company.countrycodnerez , countrycodnerez) and

                     bars.tools.equals(l_core_company.sales           , sales          ) and
                     bars.tools.equals(l_core_company.ebit            , ebit           ) and
                     bars.tools.equals(l_core_company.ebitda          , ebitda         ) and
                     bars.tools.equals(l_core_company.totaldebt       , totaldebt      ) and
                     bars.tools.equals(l_core_company.ismember        , ismember       ) and
                     bars.tools.equals(l_core_company.iscontroller    , iscontroller   ) and

                     bars.tools.equals(l_core_company.salesgr         , salesgr        ) and
                     bars.tools.equals(l_core_company.ebitgr          , ebitgr         ) and
                     bars.tools.equals(l_core_company.ebitdagr        , ebitdagr       ) and
                     bars.tools.equals(l_core_company.totaldebtgr     , totaldebtgr    ) and
                     bars.tools.equals(l_core_company.classgr         , classgr        ) and
                     bars.tools.equals(l_core_company.ispartner       , ispartner      ) and

                     bars.tools.equals(l_core_company.salespr         , salespr        ) and
                     bars.tools.equals(l_core_company.ebitpr          , ebitpr         ) and
                     bars.tools.equals(l_core_company.ebitdapr        , ebitdapr       ) and
                     bars.tools.equals(l_core_company.totaldebtpr     , totaldebtpr    ) and
                     bars.tools.equals(l_core_company.isaudit         , isaudit        ) and
                     bars.tools.equals(l_core_company.k060            , k060           );

         if (l_equals) then
             if ((l_core_company.companies_group is null or l_core_company.companies_group is empty) and (companies_group is null or companies_group is empty)) then
                 l_equals := true;
             else
                 -- для порівняння вмісту колекцій таким чином їх значення повинні бути відсортовані в одному і тому самому порядку
                 if (l_core_company.companies_group is not null and companies_group is not null) then
                     if (l_core_company.companies_group.count = companies_group.count) then
                         l := l_core_company.companies_group.first;
                         while (l_equals and l is not null) loop
                             l_equals := bars.tools.equals(l_core_company.companies_group(l).whois       , companies_group(l).whois       ) and
                                         bars.tools.equals(l_core_company.companies_group(l).isrezgr     , companies_group(l).isrezgr     ) and
                                         bars.tools.equals(l_core_company.companies_group(l).codedrpougr , companies_group(l).codedrpougr ) and
                                         bars.tools.equals(l_core_company.companies_group(l).nameurgr    , companies_group(l).nameurgr    ) and
                                         bars.tools.equals(l_core_company.companies_group(l).countrycodgr, companies_group(l).countrycodgr);
                             l := l_core_company.companies_group.next(l);
                         end loop;
                     else
                         l_equals := false;
                     end if;
                 else
                     l_equals := false;
                 end if;
             end if;
         end if;

         if (l_equals) then
             if ((l_core_company.partners is null or l_core_company.partners is empty) and (partners is null or partners is empty)) then
                 l_equals := true;
             else
                 -- для порівняння вмісту колекцій таким чином їх значення повинні бути відсортовані в одному і тому самому порядку
                 if (l_core_company.partners is not null and partners is not null) then
                     if (l_core_company.partners.count = partners.count) then
                         l := l_core_company.partners.first;
                         while (l_equals and l is not null) loop
                             l_equals := bars.tools.equals(l_core_company.partners(l).isrezpr     , partners(l).isrezpr     ) and
                                         bars.tools.equals(l_core_company.partners(l).codedrpoupr , partners(l).codedrpoupr ) and
                                         bars.tools.equals(l_core_company.partners(l).nameurpr    , partners(l).nameurpr    ) and
                                         bars.tools.equals(l_core_company.partners(l).countrycodpr, partners(l).countrycodpr);
                             l := l_core_company.partners.next(l);
                         end loop;
                     else
                         l_equals := false;
                     end if;
                 else
                     l_equals := false;
                 end if;
             end if;
         end if;

         if (l_equals) then
             if ((l_core_company.ownerpp is null or l_core_company.ownerpp is empty) and (ownerpp is null or ownerpp is empty)) then
                 l_equals := true;
             else
                 -- для порівняння вмісту колекцій таким чином їх значення повинні бути відсортовані в одному і тому самому порядку
                 if (l_core_company.ownerpp is not null and ownerpp is not null) then
                     if (l_core_company.ownerpp.count = ownerpp.count) then
                         l := l_core_company.ownerpp.first;
                         while (l_equals and l is not null) loop
                             l_equals := bars.tools.equals(l_core_company.ownerpp(l).lastname  , ownerpp(l).lastname  ) and
                                         bars.tools.equals(l_core_company.ownerpp(l).firstname , ownerpp(l).firstname ) and
                                         bars.tools.equals(l_core_company.ownerpp(l).middlename, ownerpp(l).middlename) and
                                         bars.tools.equals(l_core_company.ownerpp(l).isrez     , ownerpp(l).isrez     ) and
                                         bars.tools.equals(l_core_company.ownerpp(l).inn       , ownerpp(l).inn       ) and
                                         bars.tools.equals(l_core_company.ownerpp(l).countrycod, ownerpp(l).countrycod) and
                                         bars.tools.equals(l_core_company.ownerpp(l).perсent   , ownerpp(l).perсent   );

                             l := l_core_company.ownerpp.next(l);
                         end loop;
                     else
                         l_equals := false;
                     end if;
                 else
                     l_equals := false;
                 end if;
             end if;
         end if;

         if (l_equals) then
             if ((l_core_company.ownerjur is null or l_core_company.ownerjur is empty) and (ownerjur is null or ownerjur is empty)) then
                 l_equals := true;
             else
                 -- для порівняння вмісту колекцій таким чином їх значення повинні бути відсортовані в одному і тому самому порядку
                 if (l_core_company.ownerjur is not null and ownerjur is not null) then
                     if (l_core_company.ownerjur.count = ownerjur.count) then
                         l := l_core_company.ownerjur.first;
                         while (l_equals and l is not null) loop
                             l_equals := bars.tools.equals(l_core_company.ownerjur(l).nameoj          , ownerjur(l).nameoj          ) and
                                         bars.tools.equals(l_core_company.ownerjur(l).isrezoj         , ownerjur(l).isrezoj         ) and
                                         bars.tools.equals(l_core_company.ownerjur(l).codedrpouoj     , ownerjur(l).codedrpouoj     ) and
                                         bars.tools.equals(l_core_company.ownerjur(l).registrydayoj   , ownerjur(l).registrydayoj   ) and
                                         bars.tools.equals(l_core_company.ownerjur(l).numberregistryoj, ownerjur(l).numberregistryoj) and
                                         bars.tools.equals(l_core_company.ownerjur(l).countrycodoj    , ownerjur(l).countrycodoj    ) and
                                         bars.tools.equals(l_core_company.ownerjur(l).perсentoj       , ownerjur(l).perсentoj       );

                             l := l_core_company.ownerjur.next(l);
                         end loop;
                     else
                         l_equals := false;
                     end if;
                 else
                     l_equals := false;
                 end if;
             end if;
         end if;

         return l_equals;
     end;
 end;
/
