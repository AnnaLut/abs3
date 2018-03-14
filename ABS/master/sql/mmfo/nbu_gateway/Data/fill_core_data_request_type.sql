begin
    nbu_core_service.cor_data_request_type(nbu_core_service.REQ_TYPE_PERSON, 'Фізичні особи', '',
   'declare
        partition_doesnt_exist exception;
        pragma exception_init(partition_doesnt_exist, -2149);
    begin
        begin
            execute immediate ''alter table nbu_gateway.core_person_fo truncate partition for ('' || :l_request_id || '') reuse storage'';
        exception
            when partition_doesnt_exist then
                 null;
        end;

        insert into nbu_gateway.core_person_fo
        select :l_request_id,
               t.rnk,
               t.lastname,
               t.firstname,
               t.middlename,
               t.isrez,
               t.inn,
               t.birthday,
               t.countrycodnerez,
               t.k060,
               null,              -- person_code
               null,              -- default_person_kf
               null,              -- default_person_id
               null,              -- person_object_id
               ''RECEIVED'',      -- status
               null,              -- status_message
               t.kf
        from   bars.nbu_person_fo t
        where  t.kf = :l_kf;
    end;', 1);

    nbu_core_service.cor_data_request_type(nbu_core_service.REQ_TYPE_PERSON_DOCUMENT, 'Документи фізичної особи', '',
   'declare
        partition_doesnt_exist exception;
        pragma exception_init(partition_doesnt_exist, -2149);
    begin
        begin
            execute immediate ''alter table nbu_gateway.core_document_fo truncate partition for ('' || :l_request_id || '') reuse storage'';
        exception
            when partition_doesnt_exist then
                 null;
        end;

        insert into nbu_gateway.core_document_fo
        select :l_request_id,              -- request_id number(38)
               t.rnk,                      -- rnk number(38)
               t.typed,                    -- typed number(1)
               t.seriya,                   -- seriya varchar2(20)
               t.nomerd,                   -- nomerd varchar2(20)
               t.dtd,                      -- dtd date
               t.kf                        -- kf varchar2(6 char)
        from   bars.nbu_document_fo t
        where  t.kf = :l_kf;
    end;', 1);

    nbu_core_service.cor_data_request_type(nbu_core_service.REQ_TYPE_PERSON_ADDRESS, 'Адреси фізичної особи', '',
   'declare
        partition_doesnt_exist exception;
        pragma exception_init(partition_doesnt_exist, -2149);
    begin
        begin
            execute immediate ''alter table nbu_gateway.core_address_fo truncate partition for ('' || :l_request_id || '') reuse storage'';
        exception
            when partition_doesnt_exist then
                 null;
        end;

        insert into nbu_gateway.core_address_fo
        select :l_request_id,               -- request_id    number(38),
               t.rnk,                       -- rnk           number(38),
               t.codregion,                 -- codregion     varchar2(3 char),
               t.area,                      -- area          varchar2(100 char),
               t.zip,                       -- zip           varchar2(10 char),
               t.city,                      -- city          varchar2(254 char),
               t.streetaddress,             -- streetaddress varchar2(254 char),
               t.houseno,                   -- houseno       varchar2(50 char),
               t.adrkorp,                   -- adrkorp       varchar2(10 char),
               t.flatno,                    -- flatno        varchar2(10 char),
               t.kf                         -- kf            varchar2(6 char)
        from   bars.nbu_address_fo t
        where  t.kf = :l_kf;
    end;', 1);
/*
    nbu_core_service.cor_data_request_type(nbu_core_service.REQ_TYPE_PERSON_WORKPLACE, 'Місце роботи фізичної особи', '',
   'declare
        partition_doesnt_exist exception;
        pragma exception_init(partition_doesnt_exist, -2149);
    begin
        begin
            execute immediate ''alter table nbu_gateway.core_organization_fo truncate partition for ('' || :l_request_id || '') reuse storage'';
        exception
            when partition_doesnt_exist then
                 null;
        end;

        insert into nbu_gateway.core_organization_fo
        select :l_request_id,               -- request_id number(38),
               t.rnk,                       -- rnk        number(38),
               t.typew,                     -- typew      number(1),
               t.codedrpou,                 -- codedrpou  varchar2(20),
               t.namew,                     -- namew      varchar2(254),
               t.kf                         -- kf         varchar2(6 char)
        from   bars.nbu_organization_fo t
        where  t.kf = :l_kf;
    end;', 1);
*/
    nbu_core_service.cor_data_request_type(nbu_core_service.REQ_TYPE_PERSON_INCOME, 'Дохід фізичної особи', '',
   'declare
        partition_doesnt_exist exception;
        pragma exception_init(partition_doesnt_exist, -2149);
    begin
        begin
            execute immediate ''alter table nbu_gateway.core_profit_fo truncate partition for ('' || :l_request_id || '') reuse storage'';
        exception
            when partition_doesnt_exist then
                 null;
        end;

        insert into nbu_gateway.core_profit_fo
        select :l_request_id,               -- request_id   number(38),
               t.rnk,                       -- rnk          number(38),
               t.real6month,                -- real6month   number(32),
               t.noreal6month,              -- noreal6month number(32),
               t.kf                         -- kf           varchar2(6 char)
        from   bars.nbu_profit_fo t
        where  t.kf = :l_kf;
    end;', 1);

    nbu_core_service.cor_data_request_type(nbu_core_service.REQ_TYPE_PERSON_FAMILY, 'Склад сім''ї фізичної особи', '',
   'declare
        partition_doesnt_exist exception;
        pragma exception_init(partition_doesnt_exist, -2149);
    begin
        begin
            execute immediate ''alter table nbu_gateway.core_family_fo truncate partition for ('' || :l_request_id || '') reuse storage'';
        exception
            when partition_doesnt_exist then
                 null;
        end;

        insert into nbu_gateway.core_family_fo
        select :l_request_id,               -- request_id number(38),
               t.rnk,                       -- rnk        number(38),
               t.status_f,                  -- status_f   varchar2(5),
               t.members,                   -- members    number(2),
               t.kf                         -- kf         varchar2(6 char)
        from   bars.nbu_family_fo t
        where  t.kf = :l_kf;
    end;', 1);

    nbu_core_service.cor_data_request_type(nbu_core_service.REQ_TYPE_COMPANY, 'Юридична особа', '',
   'declare
        partition_doesnt_exist exception;
        pragma exception_init(partition_doesnt_exist, -2149);
    begin
        begin
            execute immediate ''alter table nbu_gateway.core_person_uo truncate partition for ('' || :l_request_id || '') reuse storage'';
        exception
            when partition_doesnt_exist then
                 null;
        end;

        insert into nbu_gateway.core_person_uo
        select :l_request_id,               -- request_id number(38),
               t.rnk,                       -- rnk                number(38),
               t.nameur,                    -- nameur             varchar2(254 char),
               t.isrez,                     -- isrez              varchar2(5 char),
               t.codedrpou,                 -- codedrpou          varchar2(20 char),
               t.registryday,               -- registryday        date,
               t.numberregistry,            -- numberregistry     varchar2(32 char),
               t.k110,                      -- k110               varchar2(5 char),
               t.ec_year,                   -- ec_year            date,
               t.countrycodnerez,           -- countrycodnerez    varchar2(3 char),
               t.ismember,                  -- ismember           varchar2(5 char),
               t.iscontroller,              -- iscontroller       varchar2(5 char),
               t.ispartner,                 -- ispartner          varchar2(5 char),
               t.isaudit,                   -- isaudit            varchar2(5 char),
               t.k060,                      -- k060               varchar2(2 char),
               null,                        -- company_code       varchar2(30 char),
               null,                        -- default_company_kf varchar2(6 char),
               null,                        -- default_company_id number(38),
               null,                        -- company_object_id  number(38),
               ''RECEIVED'',                -- status             varchar2(30 char),
               null,                        -- status_message     varchar2(4000),
               t.kf                         -- kf                 varchar2(6 char)
        from   bars.nbu_person_uo t
        where  t.kf = :l_kf;
    end;', 1);

    nbu_core_service.cor_data_request_type(nbu_core_service.REQ_TYPE_COMPANY_PERFORMANCE, 'Фінансові показники діяльності юридичної особи', '',
   'declare
        partition_doesnt_exist exception;
        pragma exception_init(partition_doesnt_exist, -2149);
    begin
        begin
            execute immediate ''alter table nbu_gateway.core_finperformance_uo truncate partition for ('' || :l_request_id || '') reuse storage'';
        exception
            when partition_doesnt_exist then
                 null;
        end;

        insert into nbu_gateway.core_finperformance_uo
        select :l_request_id,         -- request_id number(38),
               t.rnk,                 -- rnk        number(38),
               t.sales,               -- sales      number(32),
               t.ebit,                -- ebit       number(32),
               t.ebitda,              -- ebitda     number(32),
               t.totaldebt,           -- totaldebt  number(32),
               t.kf                   -- kf         varchar2(6 char)
        from   bars.nbu_finperformance_uo t
        where  t.kf = :l_kf;
    end;', 1);

    nbu_core_service.cor_data_request_type(nbu_core_service.REQ_TYPE_COMPANY_GROUP, 'Склад групи юридичних осіб', '',
   'declare
        partition_doesnt_exist exception;
        pragma exception_init(partition_doesnt_exist, -2149);
    begin
        begin
            execute immediate ''alter table nbu_gateway.core_groupur_uo truncate partition for ('' || :l_request_id || '') reuse storage'';
        exception
            when partition_doesnt_exist then
                 null;
        end;

        insert into nbu_gateway.core_groupur_uo
        select :l_request_id,        -- request_id   number(38),
               t.rnk,                -- rnk          number(38),
               t.whois,              -- whois        number(1),
               t.isrezgr,            -- isrezgr      varchar2(4000),
               t.codedrpougr,        -- codedrpougr  varchar2(4000),
               t.nameurgr,           -- nameurgr     varchar2(4000),
               t.countrycodgr,       -- countrycodgr varchar2(4000),
               t.kf                  -- kf           varchar2(6 char)
        from   bars.nbu_groupur_uo t
        where  t.kf = :l_kf;
    end;', 1);

    nbu_core_service.cor_data_request_type(nbu_core_service.REQ_TYPE_COMPANY_GROUP_PERF, 'Фінансові показники діяльності групи юридичних осіб', '',
   'declare
        partition_doesnt_exist exception;
        pragma exception_init(partition_doesnt_exist, -2149);
    begin
        begin
            execute immediate ''alter table nbu_gateway.core_finperformancegr_uo truncate partition for ('' || :l_request_id || '') reuse storage'';
        exception
            when partition_doesnt_exist then
                 null;
        end;

        insert into nbu_gateway.core_finperformancegr_uo
        select :l_request_id,        -- request_id  number(38),
               t.rnk,                -- rnk         number(38),
               t.salesgr,            -- salesgr     number(32),
               t.ebitgr,             -- ebitgr      number(32),
               t.ebitdagr,           -- ebitdagr    number(32),
               t.totaldebtgr,        -- totaldebtgr number(32),
               t.classgr,            -- classgr     varchar2(3),
               t.kf                  -- kf          varchar2(6 char)
        from   bars.nbu_finperformancegr_uo t
        where  t.kf = :l_kf;
    end;', 1);

    nbu_core_service.cor_data_request_type(nbu_core_service.REQ_TYPE_COMPANY_PARTNER, 'Пов''язані контрагенти/партнери юридичної особи', '',
   'declare
        partition_doesnt_exist exception;
        pragma exception_init(partition_doesnt_exist, -2149);
    begin
        begin
            execute immediate ''alter table nbu_gateway.core_partners_uo truncate partition for ('' || :l_request_id || '') reuse storage'';
        exception
            when partition_doesnt_exist then
                 null;
        end;

        insert into nbu_gateway.core_partners_uo
        select :l_request_id,        -- request_id   number(38),
               t.rnk,                -- rnk          number(38),
               t.isrezpr,            -- isrezpr      varchar2(5),
               t.codedrpoupr,        -- codedrpoupr  varchar2(20),
               t.nameurpr,           -- nameurpr     varchar2(254),
               t.countrycodpr,       -- countrycodpr varchar2(3),
               t.kf                  -- kf           varchar2(6 char)
        from   bars.nbu_partners_uo t
        where  t.kf = :l_kf;
    end;', 1);

    nbu_core_service.cor_data_request_type(nbu_core_service.REQ_TYPE_COMPANY_PARTN_PERF, 'Фінансові показники діяльності пов''язаних контрагентів юридичної особи', '',
   'declare
        partition_doesnt_exist exception;
        pragma exception_init(partition_doesnt_exist, -2149);
    begin
        begin
            execute immediate ''alter table nbu_gateway.core_finperformancepr_uo truncate partition for ('' || :l_request_id || '') reuse storage'';
        exception
            when partition_doesnt_exist then
                 null;
        end;

        insert into nbu_gateway.core_finperformancepr_uo
        select :l_request_id,        -- request_id number(38),
               t.rnk,                -- rnk        number(38),
               t.sales,              -- sales      number(32),
               t.ebit,               -- ebit       number(32),
               t.ebitda,             -- ebitda     number(32),
               t.totaldebt,          -- totaldebt  number(32),
               t.kf                  -- kf         varchar2(6 char)
        from   bars.nbu_finperformancepr_uo t
        where  t.kf = :l_kf;
    end;', 1);

    nbu_core_service.cor_data_request_type(nbu_core_service.REQ_TYPE_COMPANY_OWNER_PERS, 'Власники істотної частки в капіталі компанії - фізичні особи', '',
   'declare
        partition_doesnt_exist exception;
        pragma exception_init(partition_doesnt_exist, -2149);
    begin
        begin
            execute immediate ''alter table nbu_gateway.core_ownerpp_uo truncate partition for ('' || :l_request_id || '') reuse storage'';
        exception
            when partition_doesnt_exist then
                 null;
        end;

        insert into nbu_gateway.core_ownerpp_uo
        select :l_request_id,        -- request_id number(38),
               t.rnk,                -- rnk        number(38),
               t.rnkb,               -- rnkb       number(38),
               t.lastname,           -- lastname   varchar2(100),
               t.firstname,          -- firstname  varchar2(100),
               t.middlename,         -- middlename varchar2(100),
               t.isrez,              -- isrez      varchar2(5),
               t.inn,                -- inn        number(20),
               t.countrycod,         -- countrycod varchar2(3),
               t.percent,            -- percent    number(9,6),
               t.kf                  -- kf         varchar2(6 char)
        from   bars.nbu_ownerpp_uo t
        where  t.kf = :l_kf;
    end;', 1);

    nbu_core_service.cor_data_request_type(nbu_core_service.REQ_TYPE_COMPANY_OWNER_COMP, 'Власники істотної частки в капіталі компанії - юридичні особи', '',
   'declare
        partition_doesnt_exist exception;
        pragma exception_init(partition_doesnt_exist, -2149);
    begin
        begin
            execute immediate ''alter table nbu_gateway.core_ownerjur_uo truncate partition for ('' || :l_request_id || '') reuse storage'';
        exception
            when partition_doesnt_exist then
                 null;
        end;

        insert into nbu_gateway.core_ownerjur_uo
        select :l_request_id,         -- request_id       number(38),
               t.rnk,                 -- rnk              number(38),
               t.rnkb,                -- rnkb             number(38),
               t.nameoj,              -- nameoj           varchar2(254),
               t.isrezoj,             -- isrezoj          varchar2(5),
               t.codedrpouoj,         -- codedrpouoj      varchar2(20),
               t.registrydayoj,       -- registrydayoj    date,
               t.numberregistryoj,    -- numberregistryoj varchar2(32),
               t.countrycodoj,        -- countrycodoj     varchar2(3),
               t.percentoj,           -- percentoj        number(9,6),
               t.kf                   -- kf               varchar2(6 char)
        from   bars.nbu_ownerjur_uo t
        where  t.kf = :l_kf;
    end;', 1);

    nbu_core_service.cor_data_request_type(nbu_core_service.REQ_TYPE_PLEDGE, 'Застави', '',
   'declare
        partition_doesnt_exist exception;
        pragma exception_init(partition_doesnt_exist, -2149);
    begin
        begin
            execute immediate ''alter table nbu_gateway.core_pledge_dep truncate partition for ('' || :l_request_id || '') reuse storage'';
        exception
            when partition_doesnt_exist then
                 null;
        end;

        insert into nbu_gateway.core_pledge_dep
        select :l_request_id,             -- request_id          number(38),
               t.rnk,                     -- rnk                 number(38),
               t.acc,                     -- acc                 number(38),
               t.ordernum,                -- ordernum            number(2),
               t.numberpledge,            -- numberpledge        varchar2(30),
               t.pledgeday,               -- pledgeday           date,
               t.s031,                    -- s031                varchar2(2),
               t.r030,                    -- r030                varchar2(3),
               t.sumpledge,               -- sumpledge           number(32),
               t.pricepledge,             -- pricepledge         number(32),
               t.lastpledgeday,           -- lastpledgeday       date,
               t.codrealty,               -- codrealty           number(1),
               t.ziprealty,               -- ziprealty           varchar2(10),
               t.squarerealty,            -- squarerealty        number(16,4),
               t.real6income,             -- real6income         number(32),
               t.noreal6income,           -- noreal6income       number(32),
               t.flaginsurancepledge,     -- flaginsurancepledge number(1),
               t.numdogdp,                -- numdogdp            varchar2(50),
               t.dogdaydp,                -- dogdaydp            date,
               t.r030dp,                  -- r030dp              varchar2(3),
               t.sumdp,                   -- sumdp               number(32),
               null,                      -- default_pledge_kf   varchar2(6 char),
               null,                      -- default_pledge_id   varchar2(6 char),
               null,                      -- pledge object_id
               ''RECEIVED'',              -- status              varchar2(30 char),
               null,                      -- status_message      varchar2(4000 byte),
               t.kf                       -- kf                  varchar2(6 char)
        from   bars.nbu_pledge_dep t
        where  t.kf = :l_kf;
    end;', 1);

    nbu_core_service.cor_data_request_type(nbu_core_service.REQ_TYPE_LOAN, 'Кредитні договори', '',
   'declare
        partition_doesnt_exist exception;
        pragma exception_init(partition_doesnt_exist, -2149);
    begin
        begin
            execute immediate ''alter table nbu_gateway.core_credit truncate partition for ('' || :l_request_id || '') reuse storage'';
        exception
            when partition_doesnt_exist then
                 null;
        end;

        insert into nbu_gateway.core_credit
        select :l_request_id,       -- request_id       number(38),
               t.rnk,               -- rnk              number(38),
               t.nd,                -- nd               number(30),
               t.ordernum,          -- ordernum         number(2),
               t.flagosoba,         -- flagosoba        varchar2(5),
               t.typecredit,        -- typecredit       number(2),
               t.numdog,            -- numdog           varchar2(50),
               t.dogday,            -- dogday           date,
               t.endday,            -- endday           date,
               t.sumzagal,          -- sumzagal         number(32),
               t.r030,              -- r030             varchar2(3),
               t.proccredit,        -- proccredit       number(5,2),
               t.sumpay,            -- sumpay           number(32),
               t.periodbase,        -- periodbase       number(1),
               t.periodproc,        -- periodproc       number(1),
               t.sumarrears,        -- sumarrears       number(32),
               t.arrearbase,        -- arrearbase       number(32),
               t.arrearproc,        -- arrearproc       number(32),
               t.daybase,           -- daybase          number(5),
               t.dayproc,           -- dayproc          number(5),
               t.factendday,        -- factendday       date,
               t.flagz,             -- flagz            varchar2(5),
               t.klass,             -- klass            varchar2(2),
               t.risk,              -- risk             number(32),
               t.flaginsurance,     -- flaginsurance    varchar2(5),
               null,                -- default_loan_kf  varchar2(6 char),
               null,                -- default_loan_id  varchar2(6 char),
               null,                -- loan_object_id   number(38),
               ''RECEIVED'',        -- status           varchar2(30 char),
               null,                -- status_message   varchar2(4000 byte),
               t.kf                 -- kf               varchar2(6 char)
        from   bars.nbu_credit t
        where  t.kf = :l_kf;
    end;', 1);

    nbu_core_service.cor_data_request_type(nbu_core_service.REQ_TYPE_LOAN_PLEDGE, 'Застави по кредитних договорах', '',
   'declare
        partition_doesnt_exist exception;
        pragma exception_init(partition_doesnt_exist, -2149);
    begin
        begin
            execute immediate ''alter table nbu_gateway.core_credit_pledge truncate partition for ('' || :l_request_id || '') reuse storage'';
        exception
            when partition_doesnt_exist then
                 null;
        end;

        insert into nbu_gateway.core_credit_pledge
        select :l_request_id,       -- request_id  number(38),
               t.rnk,               -- rnk         number(38),
               t.nd,                -- nd          number(38),
               t.acc_ple,           -- acc         number(38),
               t.sumpledge,         -- sumpledge   number(32),
               t.pricepledge,       -- pricepledge number(32),
               t.kf                 -- kf          varchar2(6 char)
        from   bars.nbu_credit_pledge t
        where  t.kf = :l_kf;
    end;', 1);

    nbu_core_service.cor_data_request_type(nbu_core_service.REQ_TYPE_LOAN_TRANCHE, 'Транші по кредитних договорах', '',
   'declare
        partition_doesnt_exist exception;
        pragma exception_init(partition_doesnt_exist, -2149);
    begin
        begin
            execute immediate ''alter table nbu_gateway.core_credit_tranche truncate partition for ('' || :l_request_id || '') reuse storage'';
        exception
            when partition_doesnt_exist then
                 null;
        end;

        insert into nbu_gateway.core_credit_tranche
        select :l_request_id,       -- request_id   number(38),
               t.rnk,               -- rnk          number(38),
               t.nd,                -- nd           number(30),
               t.numdogtr,          -- numdogtr     varchar2(50),
               t.dogdaytr,          -- dogdaytr     date,
               t.enddaytr,          -- enddaytr     date,
               t.sumzagaltr,        -- sumzagaltr   number(32),
               t.r030tr,            -- r030tr       varchar2(3),
               t.proccredittr,      -- proccredittr number(5,2),
               t.periodbasetr,      -- periodbasetr number(1),
               t.periodproctr,      -- periodproctr number(1),
               t.sumarrearstr,      -- sumarrearstr number(32),
               t.arrearbasetr,      -- arrearbasetr number(32),
               t.arrearproctr,      -- arrearproctr number(32),
               t.daybasetr,         -- daybasetr    number(5),
               t.dayproctr,         -- dayproctr    number(5),
               t.factenddaytr,      -- factenddaytr date,
               t.klasstr,           -- klasstr      varchar2(1),
               t.risktr,            -- risktr       number(32),
               t.kf                 -- kf           varchar2(6 char)
        from   bars.nbu_credit_tranche t
        where  t.kf = :l_kf;
    end;', 1);

    commit;
end;
/

