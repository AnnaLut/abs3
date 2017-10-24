 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/cck_utl.sql =========*** Run *** ===
 PROMPT ===================================================================================== 

create or replace package cck_utl is
    -- Author  : Artem Yurchenko
    -- Created : 3.08.2016
    -- Purpose : набір утилітарних функцій для роботи з об'єктами модуля CCK (кредити юридичних і фізичних осіб + МБДК +
    --         : деякі інші типи угод, що використовують ту ж саму платформу, що і модуль CCK)
    -- Note    : не вносити змін без погодження з автором

    -- Типи угод (таблиця cc_tipd)
    DEAL_TYPE_ALLOCATION_OF_FUNDS constant integer := 1; -- Розміщення (актив)
    DEAL_TYPE_FUNDRAISING         constant integer := 2; -- Залучення (пасив)

    -- Статуси угоди(таблиця cc_sos)
    DEAL_STATE_NEW                constant integer :=  0; -- Новый
    DEAL_STATE_TO_AUTHORIZATION   constant integer :=  2; -- Передано на авторизацію
    DEAL_STATE_APPROVED           constant integer :=  6; -- Согласован
    DEAL_STATE_ACTIVE             constant integer := 10; -- Нормальный
    DEAL_STATE_NEARLY_OVERDUE     constant integer := 11; -- Загроза просрочки
    DEAL_STATE_MANUAL_LOCK        constant integer := 12; -- Ручне Блокування
    DEAL_STATE_OVERDUE            constant integer := 13; -- Проcрочен
    DEAL_STATE_DELETED            constant integer := 14; -- Техн.удал.
    DEAL_STATE_CLOSED             constant integer := 15; -- Закрыт

    -- Джерела коштів (таблиця cc_source)
    FUNDS_SOURCE_OWN            constant integer := 4; -- Самостійно залучені кошти

    function read_cc_vidd(
        p_kind_id in integer,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return cc_vidd%rowtype;

    function read_cc_deal(
        p_deal_id in integer,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return cc_deal%rowtype;

    function read_cc_add(
        p_deal_id in integer,
        p_application_id in integer default 0,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return cc_add%rowtype;

    function read_cc_swtrace(
        p_customer_id in integer,
        p_currency_id in integer,
        p_raise_ndf in boolean default true)
    return cc_swtrace%rowtype;

    function read_cc_tag(
        p_tag in varchar2,
        p_raise_ndf in boolean default true)
    return cc_tag%rowtype;

    function read_cc_pawn(
        p_pawn_kind_id in varchar2,
        p_raise_ndf in boolean default true)
    return cc_pawn%rowtype;

    function create_cc_deal(
        p_deal_kind_id in integer,
        p_deal_number in varchar2,
        p_client_id in integer,
        p_deal_amount in number,
        p_expiry_date in date,
        p_interest_rate in number default null,
        p_product_code in varchar2 default null,
        p_debt_service_quality_id in integer default null,
        p_original_deal_id in integer default null,
        p_registration_date in date default gl.bd(),
        p_deal_state_id in integer default cck_utl.DEAL_STATE_ACTIVE,
        p_branch_code in varchar2 default bars_context.current_branch_code(),
        p_mfo in varchar2 default bars_context.current_mfo(),
        p_user_id in integer default user_id())
    return integer;

    procedure create_cc_add(
        p_deal_id in integer,
        p_deal_amount in number,                                       -- (s           number(24,4) ) поточна сума угоди (на відміну від первинної суми угоди, може змінюватися)
        p_currency_id in integer,                                      -- (kv          integer      ) валюта угоди
        p_start_date in date,                                          -- (bdate       date         ) дата початку дії угоди (може відрізнятися від дати реєстрації, але за замовчанням співпадає з нею)
        p_payment_date in date,                                        -- (wdate       date         ) дата оплати (може відрізнятися від дати початку дії, але за замовчанням співпадає з нею)
        p_main_account_id in integer,                                  -- (accs        number(38)   ) ідентифікатор основного рахунку по угоді (рахунок основної заборгованості для кредитних угод або основний рахунок депозиту)
        p_our_corresp_bank_nostro_acc in integer default null,         -- (refp        integer      ) номер рахунку в нашому банку для банка-кореспондента, через який надходять кошти від партнера (балансовий 1500 / рідше 1600 - для тих випадків, коли кредитуємо коррахунок партнера, відкритий у нашому банку)
        p_our_corresp_bank_bic in varchar2 default null,               -- (swi_bic     char(11)     ) поле 57a : BIC-код нашого банку-кореспонденту для вхідних SWIFT-ових повідомлень (використовується партнером при перерахуванні коштів)
        p_our_corresp_bank_account in varchar2 default null,           -- (swi_acc     varchar2(34) ) поле 57a : номер рахунку нашого банку-кореспонденту для вхідних SWIFT-ових повідомлень (використовується партнером при перерахуванні коштів)
        p_our_interest_corresp_bank in varchar2 default null,          -- (int_partya  varchar2(250)) поле 57  : реквізити нашого банку-кореспонденту для вхідних SWIFT-ових повідомлень по погашенню відсотків
        p_our_interest_interm_bank in varchar2 default null,           -- (int_interma varchar2(250)) поле 56  : реквізити нашого банку посередника для вхідних SWIFT повідомлень по погашенню відсотків
        p_partner_bic in varchar2 default null,                        -- (mfokred     varchar2(12) ) МФО/BIC основного рахунку партнера
        p_partner_account in varchar2 default null,                    -- (acckred     varchar2(34) ) поле 58a : номер основного рахунку партнера (використовується при заповненні поля 58a в SWIFT-овому повідомленні)
        p_partner_alt_requisites in varchar2 default null,             -- (field_58d   varchar2(250)) поле 58d : альтернативне заповнення реквізитів отримувача в системі SWIFT
        p_partner_bank_bic in varchar2 default null,                   -- (swo_bic     char(11)     ) поле 57a : траса платежу : BIC-код банку партнера в системі SWIFT на який зараховуються кошти (довідник - таблиця CC_SWTRACE)
        p_partner_bank_account in varchar2 default null,               -- (swo_acc     varchar2(34) ) поле 57a : траса платежу : номер рахунку партнера в системі SWIFT, на який зараховуються кошти (довідник - таблиця CC_SWTRACE)
        p_partner_bank_alt_requisites in varchar2 default null,        -- (alt_partyb  varchar2(250)) поле 57d : альтернативне заповнення реквізитів банку отримувача в системі SWIFT
        p_partner_intermediary_bank in varchar2 default null,          -- (interm_b    varchar2(250)) поле 56  : реквізити банку-посередника в системі SWIFT для перерахування основної суми
        p_partner_interest_bic in varchar2 default null,               -- (mfoperc     varchar2(12) ) МФО/BIC рахунку відсотків партнера
        p_partner_interest_account in varchar2 default null,           -- (accperc     varchar2(34) ) поле 58a : номер рахунку відсотків партнера (використовується при заповненні поля 58a в SWIFT-ових повідомленнях по виплаті відсотків)
        p_partner_interest_bank in varchar2 default null,              -- (int_partyb  varchar2(250)) поле 58  : реквізити банку партнера в системі SWIFT для перерахування відсотків
        p_partner_interest_interm_bank in varchar default null,        -- (int_intermb varchar2(250)) поле 56  : реквізити банку посередника партнера для перерахування відсотків
        p_swift_out_message_id in integer default null,                -- (swo_ref     number(38)   ) ідентифікатор сформованого SWIFT-ового повідомлення, з таблиці SW_JOURNAL
        p_transit_account in varchar2 default null,                    -- (nls_1819    varchar2(14) ) транзитний рахунок для угод МБДК
        p_interest_account_id in integer default null,                 -- (accp        number(38)   ) ідентифікатор рахунку нарахованих відсотків
        p_expected_interest_amount in number default null,             -- (int_amount  number(24,4) ) очікувана сума відсотків за угодою
        p_event_frequency_id in integer default 2,                     -- (freq        integer      ) періодичність подій по угоді (довідник - таблиця freq)
        p_loan_aim_id in integer default null,                         -- (aim         integer      ) ідентифікатор цільового призначення кредиту
        p_funds_source_id in integer default cck_utl.FUNDS_SOURCE_OWN, -- (sour        integer      ) ідентифікатор джерела походження коштів
        p_mfo in varchar2 default bars_context.current_mfo(),          -- (kf          varchar2(6)  ) МФО в якому зареєстрована угода
        p_application_id in integer default 0,                          -- (adds        integer      ) ідентифікатор додаткової угоди
        p_certificate_nbu IN VARCHAR2 default null);              -- (n_nbu       varchar2(50)    ) номер свідоцтва НБУ

    function get_deal_kind_name(
         p_deal_kind_id in integer)
    return integer;

    function get_deal_interest_kind(
         p_deal_type_id in integer)
    return integer;

    function get_deal_attribute(
        p_deal_id in integer,
        p_attribute_code in varchar2)
    return varchar2;

    procedure set_deal_attribute(
        p_deal_id in integer,
        p_attribute_code in varchar2,
        p_value in varchar2);

    procedure link_account_to_deal(
        p_deal_id in integer,
        p_account_id in integer);

    procedure link_document_to_deal(
        p_deal_id in integer,
        p_document_id in integer);
end;
/
create or replace package body cck_utl as

    function read_cc_vidd(
        p_kind_id in integer,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return cc_vidd%rowtype
    is
        l_credit_kind_row cc_vidd%rowtype;
    begin
        if (p_lock) then
            select *
            into   l_credit_kind_row
            from   cc_vidd t
            where  t.vidd = p_kind_id
            for update;
        else
            select *
            into   l_credit_kind_row
            from   cc_vidd t
            where  t.vidd = p_kind_id;
        end if;

        return l_credit_kind_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                raise_application_error(-20000,
                                        'Вид угоди з ідентифікатором {' || p_kind_id || '} не знайдений');
             else return null;
             end if;
    end;

    function read_cc_deal(
        p_deal_id in integer,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return cc_deal%rowtype
    is
        l_deal_row cc_deal%rowtype;
    begin
        if (p_lock) then
            select *
            into   l_deal_row
            from   cc_deal t
            where  t.nd = p_deal_id
            for update;
        else
            select *
            into   l_deal_row
            from   cc_deal t
            where  t.nd = p_deal_id;
        end if;
        return l_deal_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                 raise_application_error(-20000, 'Угода з ідентифікатором {' || p_deal_id || '} не знайдена');
             else return null;
             end if;
    end;

    function read_cc_add(
        p_deal_id in integer,
        p_application_id in integer default 0,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return cc_add%rowtype
    is
        l_addition_row cc_add%rowtype;
    begin
        if (p_lock) then
            select *
            into   l_addition_row
            from   cc_add t
            where  t.nd = p_deal_id and
                   t.adds = p_application_id
            for update;
        else
            select *
            into   l_addition_row
            from   cc_add t
            where  t.nd = p_deal_id and
                   t.adds = p_application_id;
        end if;
        return l_addition_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                 raise_application_error(-20000, 'Додаткові параметри угоди з ідентифікатором {' || p_deal_id ||
                                                 '} не знайдені для номеру додаткової угоди {' || p_application_id || '}');
             else return null;
             end if;
    end;

    function read_cc_swtrace(
        p_customer_id in integer,
        p_currency_id in integer,
        p_raise_ndf in boolean default true)
    return cc_swtrace%rowtype
    is
        l_cc_swtrace_row cc_swtrace%rowtype;
    begin
        select t.*
        into   l_cc_swtrace_row
        from   cc_swtrace t
        where  t.rnk = p_customer_id and
               t.kv = p_currency_id;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                 raise_application_error(-20000, 'Траса платежу SWIFT для партнера з ідентифікатором {' || p_customer_id || '} і валюти {' || p_currency_id || '} не знайдена');
             else return null;
             end if;
    end;

    function read_cc_tag(
        p_tag in varchar2,
        p_raise_ndf in boolean default true)
    return cc_tag%rowtype
    is
        l_cc_tag_row cc_tag%rowtype;
    begin
        select *
        into   l_cc_tag_row
        from   cc_tag t
        where  t.tag = upper(p_tag);

        return l_cc_tag_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                 raise_application_error(-20000, 'Вид атрибуту угоди з кодом {' || p_tag || '} не знайдений');
             else return null;
             end if;
    end;

    function read_cc_pawn(
        p_pawn_kind_id in varchar2,
        p_raise_ndf in boolean default true)
    return cc_pawn%rowtype
    is
        l_cc_pawn_row cc_pawn%rowtype;
    begin
        select *
        into   l_cc_pawn_row
        from   cc_pawn t
        where  t.pawn = p_pawn_kind_id;

        return l_cc_pawn_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                 raise_application_error(-20000, 'Вид застави з ідентифікатором {' || p_pawn_kind_id || '} не знайдений');
             else return null;
             end if;
    end;

    function create_cc_deal(
        p_deal_kind_id in integer,
        p_deal_number in varchar2,
        p_client_id in integer,
        p_deal_amount in number,
        p_expiry_date in date,
        p_interest_rate in number default null,
        p_product_code in varchar2 default null,
        p_debt_service_quality_id in integer default null,
        p_original_deal_id in integer default null,
        p_registration_date in date default gl.bd(),
        p_deal_state_id in integer default cck_utl.DEAL_STATE_ACTIVE,
        p_branch_code in varchar2 default bars_context.current_branch_code(),
        p_mfo in varchar2 default bars_context.current_mfo(),
        p_user_id in integer default user_id())
    return integer
    is
        l_deal_id integer;
    begin
        l_deal_id := bars_sqnc.get_nextval('s_cc_deal');

        insert into cc_deal
        values (l_deal_id,                    -- nd       number(30),
                p_deal_state_id,              -- sos      integer,
                p_deal_number,                -- cc_id    varchar2(50),
                p_registration_date,          -- sdate    date default sysdate,
                p_expiry_date,                -- wdate    date default sysdate,
                p_client_id,                  -- rnk      integer,
                p_deal_kind_id,               -- vidd     integer,
                p_deal_amount,                -- limit    number(24,4),
                0,                            -- kprolog  integer,
                p_user_id,                    -- user_id  integer,
                p_debt_service_quality_id,    -- obs      integer,
                p_branch_code,                -- branch   varchar2(30) default sys_context('bars_context','user_branch'),
                p_mfo,                        -- kf       varchar2(6) default sys_context('bars_context','user_mfo'),
                p_interest_rate,              -- ir       number,
                p_product_code,               -- prod     varchar2(100),
                p_deal_amount,                -- sdog     number(24,2),
                null,                         -- skarb_id varchar2(50),
                null,                         -- fin      integer,
                p_original_deal_id,           -- ndi      integer,
                null,                         -- fin23    integer,
                null,                         -- obs23    integer,
                null,                         -- kat23    integer,
                null,                         -- k23      number,
                null,                         -- kol_sp   number,
                null,                         -- s250     varchar2(1),
                null,
				null,
				null,
    null
				);                        -- grp      integer

        return l_deal_id;
    end;

    procedure create_cc_add(
        p_deal_id in integer,
        p_deal_amount in number,                                       -- (s           number(24,4) ) поточна сума угоди (на відміну від первинної суми угоди, може змінюватися)
        p_currency_id in integer,                                      -- (kv          integer      ) валюта угоди
        p_start_date in date,                                          -- (bdate       date         ) дата початку дії угоди (може відрізнятися від дати реєстрації, але за замовчанням співпадає з нею)
        p_payment_date in date,                                        -- (wdate       date         ) дата оплати (може відрізнятися від дати початку дії, але за замовчанням співпадає з нею)
        p_main_account_id in integer,                                  -- (accs        number(38)   ) ідентифікатор основного рахунку по угоді (рахунок основної заборгованості для кредитних угод або основний рахунок депозиту)
        p_our_corresp_bank_nostro_acc in integer default null,         -- (refp        integer      ) номер рахунку в нашому банку для банка-кореспондента, через який надходять кошти від партнера (балансовий 1500 / рідше 1600 - для тих випадків, коли кредитуємо коррахунок партнера, відкритий у нашому банку)
        p_our_corresp_bank_bic in varchar2 default null,               -- (swi_bic     char(11)     ) поле 57a : BIC-код нашого банку-кореспонденту для вхідних SWIFT-ових повідомлень (використовується партнером при перерахуванні коштів)
        p_our_corresp_bank_account in varchar2 default null,           -- (swi_acc     varchar2(34) ) поле 57a : номер рахунку нашого банку-кореспонденту для вхідних SWIFT-ових повідомлень (використовується партнером при перерахуванні коштів)
        p_our_interest_corresp_bank in varchar2 default null,          -- (int_partya  varchar2(250)) поле 57  : реквізити нашого банку-кореспонденту для вхідних SWIFT-ових повідомлень по погашенню відсотків
        p_our_interest_interm_bank in varchar2 default null,           -- (int_interma varchar2(250)) поле 56  : реквізити нашого банку посередника для вхідних SWIFT повідомлень по погашенню відсотків
        p_partner_bic in varchar2 default null,                        -- (mfokred     varchar2(12) ) МФО/BIC основного рахунку партнера
        p_partner_account in varchar2 default null,                    -- (acckred     varchar2(34) ) поле 58a : номер основного рахунку партнера (використовується при заповненні поля 58a в SWIFT-овому повідомленні)
        p_partner_alt_requisites in varchar2 default null,             -- (field_58d   varchar2(250)) поле 58d : альтернативне заповнення реквізитів отримувача в системі SWIFT
        p_partner_bank_bic in varchar2 default null,                   -- (swo_bic     char(11)     ) поле 57a : траса платежу : BIC-код банку партнера в системі SWIFT на який зараховуються кошти (довідник - таблиця CC_SWTRACE)
        p_partner_bank_account in varchar2 default null,               -- (swo_acc     varchar2(34) ) поле 57a : траса платежу : номер рахунку партнера в системі SWIFT, на який зараховуються кошти (довідник - таблиця CC_SWTRACE)
        p_partner_bank_alt_requisites in varchar2 default null,        -- (alt_partyb  varchar2(250)) поле 57d : альтернативне заповнення реквізитів банку отримувача в системі SWIFT
        p_partner_intermediary_bank in varchar2 default null,          -- (interm_b    varchar2(250)) поле 56  : реквізити банку-посередника в системі SWIFT для перерахування основної суми
        p_partner_interest_bic in varchar2 default null,               -- (mfoperc     varchar2(12) ) МФО/BIC рахунку відсотків партнера
        p_partner_interest_account in varchar2 default null,           -- (accperc     varchar2(34) ) поле 58a : номер рахунку відсотків партнера (використовується при заповненні поля 58a в SWIFT-ових повідомленнях по виплаті відсотків)
        p_partner_interest_bank in varchar2 default null,              -- (int_partyb  varchar2(250)) поле 58  : реквізити банку партнера в системі SWIFT для перерахування відсотків
        p_partner_interest_interm_bank in varchar default null,        -- (int_intermb varchar2(250)) поле 56  : реквізити банку посередника партнера для перерахування відсотків
        p_swift_out_message_id in integer default null,                -- (swo_ref     number(38)   ) ідентифікатор сформованого SWIFT-ового повідомлення, з таблиці SW_JOURNAL
        p_transit_account in varchar2 default null,                    -- (nls_1819    varchar2(14) ) транзитний рахунок для угод МБДК
        p_interest_account_id in integer default null,                 -- (accp        number(38)   ) ідентифікатор рахунку нарахованих відсотків
        p_expected_interest_amount in number default null,             -- (int_amount  number(24,4) ) очікувана сума відсотків за угодою
        p_event_frequency_id in integer default 2,                     -- (freq        integer      ) періодичність подій по угоді (довідник - таблиця freq)
        p_loan_aim_id in integer default null,                         -- (aim         integer      ) ідентифікатор цільового призначення кредиту
        p_funds_source_id in integer default cck_utl.FUNDS_SOURCE_OWN, -- (sour        integer      ) ідентифікатор джерела походження коштів
        p_mfo in varchar2 default bars_context.current_mfo(),          -- (kf          varchar2(6)  ) МФО в якому зареєстрована угода
        p_application_id in integer default 0,                         -- (adds        integer      ) ідентифікатор додаткової угоди
        p_certificate_nbu IN VARCHAR2 default null)                -- (n_nbu       varchar2(50)    ) номер свідоцтва НБУ
    is
    begin
        insert into cc_add
        values (p_deal_id,                      -- nd          number(30),
                p_application_id,               -- adds        integer,
                p_loan_aim_id,                  -- aim         integer,
                p_deal_amount,                  -- s           number(24,4),
                p_currency_id,                  -- kv          integer,
                p_start_date,                   -- bdate       date default sysdate,
                p_payment_date,                 -- wdate       date default sysdate,
                p_main_account_id,              -- accs        number(38),
                p_interest_account_id,          -- accp        number(38),
                p_funds_source_id,              -- sour        integer,
                p_partner_account,              -- acckred     varchar2(34),
                p_partner_bic,                  -- mfokred     varchar2(12),
                p_event_frequency_id,           -- freq        integer,
                null,                           -- pdate       date,
                null,                           -- refv        integer,
                p_our_corresp_bank_nostro_acc,           -- refp        integer,
                p_partner_interest_account,     -- accperc     varchar2(34),
                p_partner_interest_bic,         -- mfoperc     varchar2(12),
                p_our_corresp_bank_bic,         -- swi_bic     char(11),
                p_our_corresp_bank_account,     -- swi_acc     varchar2(34),
                null,                           -- swi_ref     number(38),
                p_partner_bank_bic,             -- swo_bic     char(11),
                p_partner_bank_account,         -- swo_acc     varchar2(34),
                p_swift_out_message_id,         -- swo_ref     number(38),
                p_expected_interest_amount,     -- int_amount  number(24,4),
                p_partner_bank_alt_requisites,  -- alt_partyb  varchar2(250),
                p_partner_intermediary_bank,    -- interm_b    varchar2(250),
                p_our_interest_corresp_bank,    -- int_partya  varchar2(250),
                p_partner_interest_bank,        -- int_partyb  varchar2(250),
                p_our_interest_interm_bank,     -- int_interma varchar2(250),
                p_partner_interest_interm_bank, -- int_intermb varchar2(250),
                null,                           -- ssuda       number(12),
                p_mfo,                          -- kf          varchar2(6) default sys_context('bars_context','user_mfo'),
                null,                           -- okpokred    varchar2(14),
                null,                           -- namkred     varchar2(38),
                null,                           -- naznkred    varchar2(160),
                p_transit_account,              -- nls_1819    varchar2(14),
                p_partner_alt_requisites,      -- field_58d   varchar2(250)
                p_certificate_nbu);              -- n_nbu       varchar2(50)   номер свідоцтва НБУ
    end;

    function get_deal_kind_name(
         p_deal_kind_id in integer)
    return integer
    is
    begin
        return read_cc_vidd(p_deal_kind_id, p_raise_ndf => false).name;
    end;

    function get_deal_interest_kind(
         p_deal_type_id in integer)
    return integer
    is
    begin
        return case when p_deal_type_id = cck_utl.DEAL_TYPE_ALLOCATION_OF_FUNDS then interest_utl.INTEREST_KIND_ASSETS
                    else interest_utl.INTEREST_KIND_LIABILITIES
               end;
    end;

    function get_deal_attribute(
        p_deal_id in integer,
        p_attribute_code in varchar2)
    return varchar2
    is
        l_cc_tag_row cc_tag%rowtype;
        l_value varchar2(4000 byte);
    begin
        l_cc_tag_row := read_cc_tag(p_attribute_code);

        select txt
        into   l_value
        from   nd_txt t
        where  t.nd = p_deal_id and
               t.tag = l_cc_tag_row.tag;

        return l_value;
    exception
        when no_data_found then
             return null;
    end;

    procedure set_deal_attribute(
        p_deal_id in integer,
        p_attribute_code in varchar2,
        p_value in varchar2)
    is
        l_cc_tag_row cc_tag%rowtype;
    begin
        l_cc_tag_row := read_cc_tag(p_attribute_code);

        if (p_value is null) then
            delete nd_txt t
            where  t.nd = p_deal_id and
                   t.tag = l_cc_tag_row.tag;
        else
            update nd_txt t
            set    t.txt = p_value
            where  t.nd = p_deal_id and
                   t.tag = l_cc_tag_row.tag;

            if (sql%rowcount = 0) then
                insert into nd_txt
                values (p_deal_id, l_cc_tag_row.tag, p_value, bars_context.current_mfo());
            end if;
        end if;
    end;

    procedure link_account_to_deal(
        p_deal_id in integer,
        p_account_id in integer)
    is
    begin
        merge into nd_acc a
        using dual
        on (a.nd = p_deal_id and
            a.acc = p_account_id)
        when not matched then insert
             values (p_deal_id, p_account_id, bars_context.current_mfo());
    end;

    procedure link_document_to_deal(
        p_deal_id in integer,
        p_document_id in integer)
    is
    begin
        merge into mbd_k_r a
        using dual
        on (a.nd = p_deal_id and
            a.ref = p_document_id)
        when not matched then insert
             values (p_deal_id, p_document_id);
    end;
end;
/
 show err;
 
PROMPT *** Create  grants  CCK_UTL ***
grant EXECUTE                                                                on CCK_UTL         to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/cck_utl.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 