create or replace package deal_utl is

    -- Author  : Artem Yurchenko
    -- Date    : 2015-04-20
    -- Purpose : Головний інструментальний пакет для виконання операцій, що властиві всім типам угод в АБС

    OBJ_TYPE_DEAL                  constant varchar2(30 char) := 'DEAL';

    ATTR_CODE_DEAL_NUMBER          constant varchar2(30 char) := 'DEAL_NUMBER';
    ATTR_CODE_CUSTOMER_ID          constant varchar2(30 char) := 'DEAL_CUSTOMER';
    ATTR_CODE_PRODUCT_ID           constant varchar2(30 char) := 'DEAL_PRODUCT';
    ATTR_CODE_START_DATE           constant varchar2(30 char) := 'DEAL_START_DATE';
    ATTR_CODE_EXPIRY_DATE          constant varchar2(30 char) := 'DEAL_EXPIRY_DATE';
    ATTR_CODE_CLOSE_DATE           constant varchar2(30 char) := 'DEAL_CLOSE_DATE';
    ATTR_CODE_BRANCH_ID            constant varchar2(30 char) := 'DEAL_BRANCH';
    ATTR_CODE_CURATOR_ID           constant varchar2(30 char) := 'DEAL_CURATOR';

    ATTR_CODE_INT_CRED_RANK_INIT   constant varchar2(30 char) := 'DEAL_VNCRP';
    ATTR_CODE_INT_CRED_RANK_CURR   constant varchar2(30 char) := 'DEAL_VNCRR';

    ATTR_CODE_FIN_CONDITION        constant varchar2(30 char) := 'DEAL_FIN_CONDITION';           -- Клас позичальника (фін.стан)
    ATTR_CODE_OVERDUE_DAYS         constant varchar2(30 char) := 'DEAL_OVERDUE_DAYS';            -- Кількість днів прострочки за угодою
    ATTR_CODE_PORTFOL_RESERVE_FLAG constant varchar2(30 char) := 'DEAL_PORTFOL_RESERVE_FLAG';    -- Ознака портфельного методу (8)
    ATTR_CODE_PORTFOL_RESERVE_GRP  constant varchar2(30 char) := 'DEAL_PORTFOL_RESERVE_GRP';     -- Група активу портфельного методу

    --> Постанова Правління Національного банку України від 25.01.2012 р. № 23
    ATTR_CODE_FIN_CONDITION_23     constant varchar2(30 char) := 'DEAL_FIN_CONDITION_23';        -- Клас позичальника (class of borrower) – набір показників для характеристики позичальника (контрагента банку) за результатами оцінки його фінансового стану

    ATTR_CODE_DEBT_SERV_CLASS_23   constant varchar2(30 char) := 'DEAL_DEBT_SERV_CLASS_23';      -- Стан обслуговування боргу - стан виконання боржником зобов’язань за договором
                                                                                                 -- Кількість календарних днів прострочення (уключно) Стан обслуговування боргу
                                                                                                 -- від 0 до 7                                        “високий”
                                                                                                 -- від 8 до 30                                       “добрий”
                                                                                                 -- від 31 до 90                                      “задовільний”
                                                                                                 -- від 91 до 180                                     “слабкий”
                                                                                                 -- понад 180                                         “незадовільний”

    ATTR_CODE_FIN_QUALITY_CATEG_23 constant varchar2(30 char) := 'DEAL_FIN_QUALITY_CATEGORY_23'; -- Категорiя якостi за кредитом
                                                                                                 -- Клас боржника - юридичної особи       Стан обслуговування боргу
                                                                                                 --                                       “високий”    “добрий”    “задовільний”    “слабкий”    “незадовільний”
                                                                                                 --                               1       І            І           IІІ              IV           V
                                                                                                 --                               2       І            І           IІІ              IV           V
                                                                                                 --                               3       І            ІІ          IІІ              IV           V
                                                                                                 --                               4       І            ІІ          IІІ              IV           V
                                                                                                 --                               5       ІІ           ІІ          IІІ              IV           V
                                                                                                 --                               6       ІІ           ІІІ         IV               ІV           V
                                                                                                 --                               7       ІІ           IІІ         IV               ІV           V
                                                                                                 --                               8       IІ           IІІ         ІV               ІV           V
                                                                                                 --                               9       ІІ           ІІІ         ІV               V            V

    ATTR_CODE_RISK_RATE_23         constant varchar2(30 char) := 'DEAL_RISK_RATE_23';            -- Коефіцієнт ризику
                                                                                                 -- Категорія якості за кредитом   Значення показника ризику кредиту
                                                                                                 --                  І - найвища                         0,01 - 0,06
                                                                                                 --                  ІІ                                  0,07 - 0,20
                                                                                                 --                  ІІІ                                 0,21 - 0,50
                                                                                                 --                  ІV                                  0,51 - 0,99
                                                                                                 --                  V - найнижча                        1,0
    --< Постанова Правління Національного банку України від 25.01.2012 р. № 23

    function read_account_type(
        p_account_type_id in integer,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return deal_account_type%rowtype;

    function read_account_type(
        p_account_type_code in varchar2,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return deal_account_type%rowtype;

    procedure check_deal_type(
        p_deal_type_row in object_type%rowtype);

    function create_account_type(
        p_account_type_code in varchar2,
        p_account_type_name in varchar2,
        p_deal_type_code in varchar2,
        p_gl_account_type_code in varchar2 default null,
        p_balance_account in varchar2 default null,
        p_ob22_code in varchar2 default null,
        p_account_mask in varchar2 default null,
        p_is_permanent in char default 'Y',
        p_is_auto_open_allowed in char default 'N',
        p_get_deal_account_function in varchar2 default null,
        p_value_by_date_flag char default 'N',
        p_save_history_flag char default 'N')
    return integer;

    function create_deal(
        p_deal_type_code in varchar2,
        p_deal_number in varchar2,
        p_customer_id in integer,
        p_product_id in integer,
        p_start_date in date default bankdate(),
        p_expiry_date in date default null,
        p_curator_id in integer default user_id(),
        p_branch in varchar2 default sys_context(bars_context.CONTEXT_CTX, bars_context.CTXPAR_USERBRANCH),
        p_state_code in varchar2 default null)
    return integer;

    function read_deal(
        p_deal_id in integer,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return deal%rowtype;

    function get_deal_type_id(
        p_deal_id in integer)
    return integer;

    function get_deal_number(
        p_deal_id in integer)
    return varchar2;

    function get_deal_customer_id(
        p_deal_id in integer)
    return integer;

    function get_deal_product_id(
        p_deal_id in integer)
    return integer;

    function get_deal_start_date(
        p_deal_id in integer)
    return date;

    function get_deal_expiry_date(
        p_deal_id in integer)
    return date;

    function get_deal_close_date(
        p_deal_id in integer)
    return date;

    function get_object_state_id(
        p_deal_id in integer)
    return integer;

    function get_deal_branch_id(
        p_deal_id in integer)
    return varchar2;

    function get_deal_curator_id(
        p_deal_id in integer)
    return integer;

    function get_deal_number(
        p_deal_id in integer,
        p_value_date in date)
    return varchar2;

    function get_deal_customer_id(
        p_deal_id in integer,
        p_value_date in date)
    return integer;

    function get_deal_product_id(
        p_deal_id in integer,
        p_value_date in date)
    return integer;

    function get_deal_start_date(
        p_deal_id in integer,
        p_value_date in date)
    return date;

    function get_deal_expiry_date(
        p_deal_id in integer,
        p_value_date in date)
    return date;

    function get_deal_close_date(
        p_deal_id in integer,
        p_value_date in date)
    return date;

/*    function get_object_state_id(
        p_deal_id in integer,
        p_value_date in date)
    return integer;
*/
    function get_deal_branch_id(
        p_deal_id in integer,
        p_value_date in date)
    return varchar2;

    function get_deal_curator_id(
        p_deal_id in integer,
        p_value_date in date)
    return integer;

    procedure set_deal_number(
        p_deal_id in integer,
        p_deal_number in varchar2,
        p_comment in varchar2 default null);

    procedure set_deal_number(
        p_deal_id in integer,
        p_deal_number in varchar2,
        p_value_date in date,
        p_comment in varchar2 default null);

    procedure set_deal_number(
        p_deal_id in integer,
        p_deal_number in varchar2,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2 default null);

    procedure set_deal_customer_id(
        p_deal_id in integer,
        p_customer_id in integer,
        p_comment in varchar2 default null);

    procedure set_deal_customer_id(
        p_deal_id in integer,
        p_customer_id in integer,
        p_value_date in date,
        p_comment in varchar2 default null);

    procedure set_deal_customer_id(
        p_deal_id in integer,
        p_customer_id in integer,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2 default null);

    procedure set_deal_product_id(
        p_deal_id in integer,
        p_product_id in integer,
        p_comment in varchar2 default null);

    procedure set_deal_product_id(
        p_deal_id in integer,
        p_product_id in integer,
        p_value_date in date,
        p_comment in varchar2 default null);

    procedure set_deal_product_id(
        p_deal_id in integer,
        p_product_id in integer,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2 default null);

    procedure set_deal_start_date(
        p_deal_id in integer,
        p_start_date in date,
        p_comment in varchar2 default null);

    procedure set_deal_start_date(
        p_deal_id in integer,
        p_start_date in date,
        p_value_date in date,
        p_comment in varchar2 default null);

    procedure set_deal_start_date(
        p_deal_id in integer,
        p_start_date in date,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2 default null);

    procedure set_deal_expiry_date(
        p_deal_id in integer,
        p_expiry_date in date,
        p_comment in varchar2 default null);

    procedure set_deal_expiry_date(
        p_deal_id in integer,
        p_expiry_date in date,
        p_value_date in date,
        p_comment in varchar2 default null);

    procedure set_deal_expiry_date(
        p_deal_id in integer,
        p_expiry_date in date,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2 default null);

    procedure set_deal_close_date(
        p_deal_id in integer,
        p_close_date in date,
        p_comment in varchar2 default null);

    procedure set_deal_close_date(
        p_deal_id in integer,
        p_close_date in date,
        p_value_date in date,
        p_comment in varchar2 default null);

    procedure set_deal_close_date(
        p_deal_id in integer,
        p_close_date in date,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2 default null);

    procedure set_deal_branch_id(
        p_deal_id in integer,
        p_branch_id in varchar2,
        p_comment in varchar2 default null);

    procedure set_deal_branch_id(
        p_deal_id in integer,
        p_branch_id in varchar2,
        p_value_date in date,
        p_comment in varchar2 default null);

    procedure set_deal_branch_id(
        p_deal_id in integer,
        p_branch_id in varchar2,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2 default null);

    procedure set_deal_curator_id(
        p_deal_id in integer,
        p_curator_id in integer,
        p_comment in varchar2 default null);

    procedure set_deal_curator_id(
        p_deal_id in integer,
        p_curator_id in integer,
        p_value_date in date,
        p_comment in varchar2 default null);

    procedure set_deal_curator_id(
        p_deal_id in integer,
        p_curator_id in integer,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2 default null);

    function get_deal_account(
        p_deal_id in integer,
        p_account_type_id in integer)
    return integer;

    function get_deal_account(
        p_deal_id in integer,
        p_account_type_code in varchar2)
    return integer;

    function get_deal_accounts(
        p_deal_id in integer,
        p_account_type_id in integer)
    return number_list;

    function get_deal_accounts(
        p_deal_id in integer,
        p_account_type_code in varchar2)
    return number_list;

    procedure set_deal_account(
        p_deal_id in integer,
        p_account_type_id in integer,
        p_account_id in integer);

    procedure set_deal_account(
        p_deal_id in integer,
        p_account_type_code in varchar2,
        p_account_id in integer);

    procedure set_deal_accounts(
        p_deal_id in integer,
        p_account_type_id in integer,
        p_accounts in number_list);

    procedure set_deal_accounts(
        p_deal_id in integer,
        p_account_type_code in varchar2,
        p_accounts in number_list);

    function get_account_deals(
        p_account_id in integer,
        p_account_type_id in integer,
        p_value_date in date default trunc(sysdate))
    return number_list;

    function get_account_deal(
        p_account_id in integer,
        p_account_type_id in integer,
        p_choose_one_from_list in char default 'N')
    return integer;

    function get_account_deal_row(
        p_account_id in integer,
        p_account_type_id in integer,
        p_choose_one_from_list in char default 'N')
    return deal%rowtype;

    function find_deal_account(
        p_deal_id in integer,
        p_account_type_id in integer,
        p_currency_id in integer default null,
        p_raise_ndf in char default 'Y')
    return integer;

    procedure set_deal_account_settings(
        p_account_type_id in integer, -- тип потрібного рахунку
        p_deal_group_id in integer,   -- ідентифікатор групи, до якої відноситься угода
        p_currency_id in integer,     -- валюта операції (не обов'язковий) (PS: не рахунку, а саме операції)
        p_product_id in integer,      -- продукт угоди, по якій виконується операція (не обов'язковий)
        p_branch_code in varchar2,    -- код відділення, в якому виконується операція (не обов'язковий)
        p_account_id in integer);     -- ідентифікатор рахунку, що відповідає заданій конфігурації параметрів

    procedure set_deal_account_settings(
        p_account_type_code in varchar2, -- тип потрібного рахунку
        p_deal_group_id in integer,   -- ідентифікатор групи, до якої відноситься угода
        p_currency_id in integer,     -- валюта операції (не обов'язковий) (PS: не рахунку, а саме операції)
        p_product_id in integer,      -- продукт угоди, по якій виконується операція (не обов'язковий)
        p_branch_code in varchar2,    -- код відділення, в якому виконується операція (не обов'язковий)
        p_account_id in integer);      -- ідентифікатор рахунку, що відповідає заданій конфігурації параметрів

    function get_deal_account_settings(
        p_account_type_id in integer,
        p_deal_group_id in integer,
        p_currency_id in integer default null,
        p_product_id in integer default null,
        p_branch_code in varchar2 default null)
    return integer;

    function get_deal_account_settings(
        p_account_type_code in varchar2,
        p_deal_group_id in integer,
        p_currency_id in integer default null,
        p_product_id in integer default null,
        p_branch_code in varchar2 default null)
    return integer;

    procedure get_deal_balance_acc_settings(
        p_account_type_id in integer,
        p_deal_group_id in integer,
        p_currency_id in integer default null,
        p_product_id in integer default null,
        p_balance_account out varchar2,
        p_ob22_code out varchar2);

    procedure set_deal_balance_acc_settings(
        p_account_type_id in integer,    -- тип потрібного рахунку
        p_deal_group_id in integer,      -- ідентифікатор групи, до якої відноситься угода
        p_currency_id in integer,        -- валюта операції (не обов'язковий) (PS: не рахунку, а саме операції)
        p_product_id in integer,         -- продукт угоди, по якій виконується операція (не обов'язковий)
        p_balance_account in varchar2,   -- балансовий рахунок, що відповідає заданій конфігурації параметрів
        p_ob22_code in varchar2);        -- код ОБ22, що відповідає заданій конфігурації параметрів

    procedure set_deal_balance_acc_settings(
        p_account_type_code in varchar2, -- тип потрібного рахунку
        p_deal_group_id in integer,      -- ідентифікатор групи, до якої відноситься угода
        p_currency_id in integer,        -- валюта операції (не обов'язковий) (PS: не рахунку, а саме операції)
        p_product_id in integer,         -- продукт угоди, по якій виконується операція (не обов'язковий)
        p_balance_account in varchar2,   -- балансовий рахунок, що відповідає заданій конфігурації параметрів
        p_ob22_code in varchar2);        -- код ОБ22, що відповідає заданій конфігурації параметрів

    procedure get_deal_balance_acc_settings(
        p_account_type_code in varchar2,
        p_deal_group_id in integer,
        p_currency_id in integer default null,
        p_product_id in integer default null,
        p_balance_account out varchar2,
        p_ob22_code out varchar2);
end;
/
create or replace package body deal_utl as

    procedure check_deal_type(
        p_deal_type_row in object_type%rowtype)
    is
    begin
        if (p_deal_type_row.id not member of object_utl.get_inheritance_tree(deal_utl.OBJ_TYPE_DEAL)) then
            raise_application_error(-20000, 'Тип об''єкту {' || p_deal_type_row.type_name ||
                                            '} не належить до підмножини об''єктів типу "Угода"');
        end if;

        if (p_deal_type_row.is_active = 'N') then
            raise_application_error(-20000, 'Тип угоди {' || p_deal_type_row.type_name ||
                                            '} не вктивний - реєстрація нових угод заборонена');
        end if;
    end;

    procedure check_deal_product(
        p_deal_type_id in integer,
        p_product_id in integer)
    is
        l_product_row deal_product%rowtype;
    begin
        if (p_product_id is not null) then
            l_product_row := product_utl.read_product(p_product_id);

            if (l_product_row.is_active = 'N') then
                raise_application_error(-20000, 'Продукт {' || l_product_row.product_name ||
                                                '} не активний - реєстрація нових угод заборонена');
            end if;

            if (l_product_row.valid_from > trunc(sysdate)) then
                raise_application_error(-20000, 'Продукт {' || l_product_row.product_name ||
                                                '} почне діяти з дати {' || to_char(l_product_row.valid_from, 'dd.mm.yyyy') ||
                                                ' - до цієї дати відкриття угод заборонено');
            end if;

            if (trunc(sysdate) > l_product_row.valid_through) then
                raise_application_error(-20000, 'Продукт {' || l_product_row.product_name ||
                                                '} припинив діяти з дати {' || to_char(l_product_row.valid_through, 'dd.mm.yyyy') ||
                                                ' - відкриття угод заборонено');
            end if;

            if (l_product_row.deal_type_id <> p_deal_type_id) then
                raise_application_error(-20000, 'Тип нової угоди {' || object_utl.get_object_type_name(p_deal_type_id) ||
                                                '} не відповідає типу угоди продукту {' || object_utl.get_object_type_name(l_product_row.deal_type_id) || '}');
            end if;
        end if;
    end;

    function read_account_type(
        p_account_type_id in integer,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return deal_account_type%rowtype
    is
        l_account_type_row deal_account_type%rowtype;
    begin
        if (p_lock) then
            select *
            into   l_account_type_row
            from   deal_account_type t
            where  t.id = p_account_type_id
            for update;
        else
            select *
            into   l_account_type_row
            from   deal_account_type t
            where  t.id = p_account_type_id;
        end if;

        return l_account_type_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                 raise_application_error(-20000, 'Тип рахунку з ідентифікатором {' || p_account_type_id || '} не знайдений');
             else return null;
             end if;
    end;

    function read_account_type(
        p_account_type_code in varchar2,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return deal_account_type%rowtype
    is
        l_attribute_kind_row attribute_kind%rowtype;
    begin
        l_attribute_kind_row := attribute_utl.read_attribute(p_account_type_code, p_raise_ndf => false);

        if (l_attribute_kind_row.id is not null) then
            return read_account_type(l_attribute_kind_row.id, p_lock, p_raise_ndf);
        else
            if (p_raise_ndf) then
                raise_application_error(-20000, 'Тип рахунку з кодом {' || p_account_type_code || '} не знайдений');
            else return null;
            end if;
        end if;
    end;

    function create_account_type(
        p_account_type_code in varchar2,
        p_account_type_name in varchar2,
        p_deal_type_code in varchar2,
        p_gl_account_type_code in varchar2 default null,
        p_balance_account in varchar2 default null,
        p_ob22_code in varchar2 default null,
        p_account_mask in varchar2 default null,
        p_is_permanent in char default 'Y',
        p_is_auto_open_allowed in char default 'N',
        p_get_deal_account_function in varchar2 default null,
        p_value_by_date_flag char default 'N',
        p_save_history_flag char default 'N')
    return integer
    is
        l_attribute_row attribute_kind%rowtype;
        l_object_type_row object_type%rowtype;
    begin
        l_attribute_row := attribute_utl.read_attribute(p_account_type_code, p_raise_ndf => false);
        l_object_type_row := object_utl.read_object_type(p_deal_type_code);

        if (l_attribute_row.id is null) then
            if (p_is_permanent = 'Y') then
                l_attribute_row.id := attribute_utl.create_parameter(p_account_type_code,
                                                                     p_account_type_name,
                                                                     p_deal_type_code,
                                                                     attribute_utl.VALUE_TYPE_NUMBER,
                                                                     p_value_table_owner => null,
                                                                     p_value_table_name => 'DEAL_ACCOUNT',
                                                                     p_attribute_column_name => 'ACCOUNT_TYPE_ID',
                                                                     p_key_column_name => 'DEAL_ID',
                                                                     p_value_column_name => 'ACCOUNT_ID',
                                                                     p_value_by_date_flag => p_value_by_date_flag,
                                                                     p_multi_values_flag => 'Y',
                                                                     p_save_history_flag => p_save_history_flag,
                                                                     p_set_value_procedures => null);
            else
                -- типи рахунків, що не зберігають свої зв'язки з угодами
                if (p_get_deal_account_function is null) then
                    raise_application_error(-20000, 'Функція пошуку рахунку по угоді не вказана - ' || 
                                                    'для типів рахунків, що визначають ідентифікатор рахунку в момент виконання, ' ||
                                                    'а не зберігають зв''язок рахунку та угоди, наявність даної функції обов''язкова');
                end if;
                l_attribute_row.id := attribute_utl.create_calculated_attribute(p_account_type_code,
                                                                                p_account_type_name,
                                                                                p_deal_type_code,
                                                                                attribute_utl.VALUE_TYPE_NUMBER,
                                                                                p_value_by_date_flag => p_value_by_date_flag,
                                                                                p_multi_values_flag => 'Y',
                                                                                p_get_value_function => p_get_deal_account_function);
            end if;
        else
            if (l_attribute_row.attribute_type_id = attribute_utl.ATTR_TYPE_FIXED and p_is_permanent = 'N') then
                raise_application_error(-20000, 'Тип рахунку {' || l_attribute_row.attribute_name ||
                                                '} був створений як такий, що зберігає зв''язок угоди з рахунками - відмінити цей зв''язок не можливо');
            end if;

            if (not tools.equals(l_attribute_row.attribute_name, p_account_type_name)) then
                attribute_utl.set_value(l_attribute_row.id, attribute_utl.ATTR_CODE_NAME, p_account_type_name);
            end if;

            if (not tools.equals(l_attribute_row.object_type_id, l_object_type_row.id)) then
                attribute_utl.set_value(l_attribute_row.id, attribute_utl.ATTR_CODE_OBJECT_TYPE, l_object_type_row.id);
            end if;

            if (not tools.equals(l_attribute_row.value_by_date_flag, p_value_by_date_flag)) then
                attribute_utl.set_value(l_attribute_row.id, attribute_utl.ATTR_CODE_VALUE_BY_DATE_FLAG, p_value_by_date_flag);
            end if;

            if (not tools.equals(l_attribute_row.save_history_flag, p_save_history_flag)) then
                attribute_utl.set_value(l_attribute_row.id, attribute_utl.ATTR_CODE_SAVE_HISTORY_FLAG, p_save_history_flag);
            end if;
        end if;

        merge into deal_account_type a
        using dual
        on (a.id = l_attribute_row.id)
        when matched then update
             set a.gl_account_type_code = p_gl_account_type_code,
                 a.balance_account = p_balance_account,
                 a.ob22_code = p_ob22_code,
                 a.account_mask = p_account_mask
        when not matched then insert
             values (l_attribute_row.id,
                     p_gl_account_type_code,
                     p_balance_account,
                     p_ob22_code,
                     p_account_mask,
                     p_is_auto_open_allowed);

        return l_attribute_row.id;
    end;

    procedure set_deal_balance_acc_settings(
        p_account_type_id in integer,  -- тип потрібного рахунку
        p_deal_group_id in integer,    -- ідентифікатор групи, до якої відноситься угода
        p_currency_id in integer,      -- валюта операції (не обов'язковий) (PS: не рахунку, а саме операції)
        p_product_id in integer,       -- продукт угоди, по якій виконується операція (не обов'язковий)
        p_balance_account in varchar2, -- балансовий рахунок, що відповідає заданій конфігурації параметрів
        p_ob22_code in varchar2)       -- код ОБ22, що відповідає заданій конфігурації параметрів
    is
    begin
        if (p_balance_account is null) then
            delete deal_balance_account_settings t
            where  t.account_type_id = p_account_type_id and
                   (p_deal_group_id is null and t.deal_group_id is null or t.deal_group_id = p_deal_group_id) and
                   (p_currency_id is null and t.currency_id is null or t.currency_id = p_currency_id) and
                   (p_product_id is null and t.product_id is null or t.product_id = p_product_id);
        else
            merge into deal_balance_account_settings a
            using dual
            on (a.account_type_id = p_account_type_id and
                (p_deal_group_id is null and a.deal_group_id is null or a.deal_group_id = p_deal_group_id) and
                (p_currency_id is null and a.currency_id is null or a.currency_id = p_currency_id) and
                (p_product_id is null and a.product_id is null or a.product_id = p_product_id))
            when matched then update
                 set a.balance_account = p_balance_account,
                     a.ob22_code = p_ob22_code
            when not matched then insert
                 values (p_account_type_id, p_deal_group_id, p_currency_id, p_product_id, p_balance_account, p_ob22_code);
        end if;
    end;

    procedure set_deal_balance_acc_settings(
        p_account_type_code in varchar2,  -- тип потрібного рахунку
        p_deal_group_id in integer,    -- ідентифікатор групи, до якої відноситься угода
        p_currency_id in integer,      -- валюта операції (не обов'язковий) (PS: не рахунку, а саме операції)
        p_product_id in integer,       -- продукт угоди, по якій виконується операція (не обов'язковий)
        p_balance_account in varchar2, -- балансовий рахунок, що відповідає заданій конфігурації параметрів
        p_ob22_code in varchar2)       -- код ОБ22, що відповідає заданій конфігурації параметрів
    is
    begin
        set_deal_balance_acc_settings(attribute_utl.get_attribute_id(p_account_type_code),
                                      p_deal_group_id,
                                      p_currency_id,
                                      p_product_id,
                                      p_balance_account,
                                      p_ob22_code);
    end;

    procedure get_deal_balance_acc_settings(
        p_account_type_id in integer,
        p_deal_group_id in integer,
        p_currency_id in integer default null,
        p_product_id in integer default null,
        p_balance_account out varchar2,
        p_ob22_code out varchar2)
    is
    begin
        select min(t.balance_account)
                   keep (dense_rank last order by t.deal_group_id nulls first,
                                                  t.currency_id nulls first,
                                                  t.product_id nulls first),
               min(t.ob22_code)
                   keep (dense_rank last order by t.deal_group_id nulls first,
                                                  t.currency_id nulls first,
                                                  t.product_id nulls first)
        into   p_balance_account, p_ob22_code
        from   deal_balance_account_settings t
        where  t.account_type_id = p_account_type_id and
               (t.deal_group_id is null or t.deal_group_id = p_deal_group_id) and -- TODO : реализовать поиск по иерархии групп
               (t.currency_id is null or t.currency_id = p_currency_id) and
               (t.product_id is null or t.product_id = p_product_id);
    end;

    procedure get_deal_balance_acc_settings(
        p_account_type_code in varchar2,
        p_deal_group_id in integer,
        p_currency_id in integer default null,
        p_product_id in integer default null,
        p_balance_account out varchar2,
        p_ob22_code out varchar2)
    is
    begin
        get_deal_balance_acc_settings(attribute_utl.get_attribute_id(p_account_type_code),
                                      p_deal_group_id,
                                      p_currency_id,
                                      p_product_id,
                                      p_balance_account,
                                      p_ob22_code);
    end;

    procedure set_deal_account_settings(
        p_account_type_id in integer, -- тип потрібного рахунку
        p_deal_group_id in integer,   -- ідентифікатор групи, до якої відноситься угода
        p_currency_id in integer,     -- валюта операції (не обов'язковий) (PS: не рахунку, а саме операції)
        p_product_id in integer,      -- продукт угоди, по якій виконується операція (не обов'язковий)
        p_branch_code in varchar2,    -- код відділення, в якому виконується операція (не обов'язковий)
        p_account_id in integer)      -- ідентифікатор рахунку, що відповідає заданій конфігурації параметрів
    is
    begin
        if (p_account_id is null) then
            delete deal_account_settings t
            where  t.account_type_id = p_account_type_id and
                   (p_deal_group_id is null and t.deal_group_id is null or t.deal_group_id = p_deal_group_id) and
                   (p_currency_id is null and t.currency_id is null or t.currency_id = p_currency_id) and
                   (p_product_id is null and t.product_id is null or t.product_id = p_product_id) and
                   (p_branch_code is null and t.branch_code is null or t.branch_code = p_branch_code);
        else
            merge into deal_account_settings a
            using dual
            on (a.account_type_id = p_account_type_id and
                (p_deal_group_id is null and a.deal_group_id is null or a.deal_group_id = p_deal_group_id) and
                (p_currency_id is null and a.currency_id is null or a.currency_id = p_currency_id) and
                (p_product_id is null and a.product_id is null or a.product_id = p_product_id) and
                (p_branch_code is null and a.branch_code is null or a.branch_code = p_branch_code))
            when matched then update
                 set a.account_id = p_account_id
            when not matched then insert
                 values (p_account_type_id, p_deal_group_id, p_currency_id, p_product_id, p_branch_code, p_account_id);
        end if;
    end;

    procedure set_deal_account_settings(
        p_account_type_code in varchar2, -- тип потрібного рахунку
        p_deal_group_id in integer,   -- ідентифікатор групи, до якої відноситься угода
        p_currency_id in integer,     -- валюта операції (не обов'язковий) (PS: не рахунку, а саме операції)
        p_product_id in integer,      -- продукт угоди, по якій виконується операція (не обов'язковий)
        p_branch_code in varchar2,    -- код відділення, в якому виконується операція (не обов'язковий)
        p_account_id in integer)      -- ідентифікатор рахунку, що відповідає заданій конфігурації параметрів
    is
    begin
        set_deal_account_settings(attribute_utl.get_attribute_id(p_account_type_code),
                                  p_deal_group_id,
                                  p_currency_id,
                                  p_product_id,
                                  p_branch_code,
                                  p_account_id);
    end;

    function get_deal_account_settings(
        p_account_type_id in integer,
        p_deal_group_id in integer,
        p_currency_id in integer default null,
        p_product_id in integer default null,
        p_branch_code in varchar2 default null)
    return integer
    is
        l_account_id integer;
    begin
        select min(t.account_id)
                   keep (dense_rank last order by t.deal_group_id nulls first,
                                                  t.currency_id nulls first,
                                                  t.product_id nulls first,
                                                  t.branch_code nulls first)
        into   l_account_id
        from   deal_account_settings t
        where  t.account_type_id = p_account_type_id and
               (p_deal_group_id is null or t.deal_group_id = p_deal_group_id) and -- TODO : реализовать поиск по иерархии групп
               (p_currency_id is null or t.currency_id = p_currency_id) and
               (p_product_id is null or t.product_id = p_product_id) and
               (p_branch_code is null or p_branch_code like t.branch_code || '%');

        return l_account_id;
    end;

    function get_deal_account_settings(
        p_account_type_code in varchar2,
        p_deal_group_id in integer,
        p_currency_id in integer default null,
        p_product_id in integer default null,
        p_branch_code in varchar2 default null)
    return integer
    is
    begin
        return get_deal_account_settings(attribute_utl.get_attribute_id(p_account_type_code),
                                         p_deal_group_id,
                                         p_currency_id,
                                         p_product_id,
                                         p_branch_code);
    end;

    function create_deal(
        p_deal_type_code in varchar2,
        p_deal_number in varchar2,
        p_customer_id in integer,
        p_product_id in integer,
        p_start_date in date default bankdate(),
        p_expiry_date in date default null,
        p_curator_id in integer default user_id(),
        p_branch in varchar2 default sys_context(bars_context.CONTEXT_CTX, bars_context.CTXPAR_USERBRANCH),
        p_state_code in varchar2 default null)
    return integer
    is
        l_deal_type_row object_type%rowtype;
        l_deal_id integer;
        l_customer_row customer%rowtype;
    begin
        if (p_start_date is null) then
            raise_application_error(-20000, 'Дата початку дії угоди не вказана');
        end if;

        if (p_branch is null) then
            raise_application_error(-20000, 'Філіал угоди не вказаний');
        end if;

        if (p_expiry_date is not null and p_start_date > p_expiry_date) then
            raise_application_error(-20000, 'Дата початку дії угоди {' || to_char(p_start_date, 'dd.mm.yyyy') ||
                                            '} не може перевищувати дату її завершення {' || to_char(p_expiry_date, 'dd.mm.yyyy') || '}');
        end if;

        l_deal_type_row := object_utl.read_object_type(p_deal_type_code);

        check_deal_type(l_deal_type_row);
        check_deal_product(l_deal_type_row.id, p_product_id);

        l_customer_row := customer_utl.read_customer(p_customer_id);

        if (l_customer_row.date_off is not null and l_customer_row.date_off <= bankdate()) then
            raise_application_error(-20000, 'Контрагент {' || l_customer_row.nmk ||
                                            '} закритий (' || to_char(l_customer_row.date_off, 'dd.mm.yyyy') ||
                                            ') - реєстрація нових угод заборонена');
        end if;

        if (p_state_code is null) then
            l_deal_id := object_utl.create_object(l_deal_type_row.id);
        else
            l_deal_id := object_utl.create_object(l_deal_type_row.id, p_state_code);
        end if;

        insert into deal (id, deal_type_id)
        values (l_deal_id, l_deal_type_row.id);

        set_deal_customer_id(l_deal_id, p_customer_id);
        set_deal_start_date(l_deal_id, p_start_date);
        set_deal_branch_id(l_deal_id, p_branch);

        if (p_deal_number is not null) then
            set_deal_number(l_deal_id, p_deal_number);
        end if;

        if (p_product_id is not null) then
            set_deal_product_id(l_deal_id, p_product_id);
        end if;

        if (p_expiry_date is not null) then
            set_deal_expiry_date(l_deal_id, p_expiry_date);
        end if;

        if (p_curator_id is not null) then
            set_deal_curator_id(l_deal_id, p_curator_id);
        end if;

        return l_deal_id;
    end;

    function read_deal(
        p_deal_id in integer,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return deal%rowtype
    is
        l_deal_row deal%rowtype;
    begin
        if (p_lock) then
            select *
            into   l_deal_row
            from   deal d
            where  d.id = p_deal_id
            for update wait 60;
        else
            select *
            into   l_deal_row
            from   deal d
            where  d.id = p_deal_id;
        end if;

        return l_deal_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                 raise_application_error(-20000, 'Угода з ідентифікатором {' || p_deal_id || '} не знайдена');
             else return null;
             end if;
    end;

    function get_deal_type_id(
        p_deal_id in integer)
    return integer
    is
    begin
        return read_deal(p_deal_id, p_raise_ndf => false).deal_type_id;
    end;

    function get_deal_number(
        p_deal_id in integer)
    return varchar2
    is
    begin
        return read_deal(p_deal_id, p_raise_ndf => false).deal_number;
    end;

    function get_deal_customer_id(
        p_deal_id in integer)
    return integer
    is
    begin
        return read_deal(p_deal_id, p_raise_ndf => false).customer_id;
    end;

    function get_deal_product_id(
        p_deal_id in integer)
    return integer
    is
    begin
        return read_deal(p_deal_id, p_raise_ndf => false).product_id;
    end;

    function get_deal_start_date(
        p_deal_id in integer)
    return date
    is
    begin
        return read_deal(p_deal_id, p_raise_ndf => false).start_date;
    end;

    function get_deal_expiry_date(
        p_deal_id in integer)
    return date
    is
    begin
        return read_deal(p_deal_id, p_raise_ndf => false).expiry_date;
    end;

    function get_deal_close_date(
        p_deal_id in integer)
    return date
    is
    begin
        return read_deal(p_deal_id, p_raise_ndf => false).close_date;
    end;

    function get_object_state_id(
        p_deal_id in integer)
    return integer
    is
    begin
        return object_utl.read_object(p_deal_id, p_raise_ndf => false).state_id;
    end;

    function get_deal_branch_id(
        p_deal_id in integer)
    return varchar2
    is
    begin
        return read_deal(p_deal_id, p_raise_ndf => false).branch_id;
    end;

    function get_deal_curator_id(
        p_deal_id in integer)
    return integer
    is
    begin
        return read_deal(p_deal_id, p_raise_ndf => false).curator_id;
    end;

    function get_deal_number(
        p_deal_id in integer,
        p_value_date in date)
    return varchar2
    is
    begin
        return attribute_utl.get_string_value(p_deal_id, deal_utl.ATTR_CODE_DEAL_NUMBER, p_value_date);
    end;

    function get_deal_customer_id(
        p_deal_id in integer,
        p_value_date in date)
    return integer
    is
    begin
        return attribute_utl.get_number_value(p_deal_id, deal_utl.ATTR_CODE_CUSTOMER_ID, p_value_date);
    end;

    function get_deal_product_id(
        p_deal_id in integer,
        p_value_date in date)
    return integer
    is
    begin
        return attribute_utl.get_number_value(p_deal_id, deal_utl.ATTR_CODE_PRODUCT_ID, p_value_date);
    end;

    function get_deal_start_date(
        p_deal_id in integer,
        p_value_date in date)
    return date
    is
    begin
        return attribute_utl.get_date_value(p_deal_id, deal_utl.ATTR_CODE_START_DATE, p_value_date);
    end;

    function get_deal_expiry_date(
        p_deal_id in integer,
        p_value_date in date)
    return date
    is
    begin
        return attribute_utl.get_date_value(p_deal_id, deal_utl.ATTR_CODE_EXPIRY_DATE, p_value_date);
    end;

    function get_deal_close_date(
        p_deal_id in integer,
        p_value_date in date)
    return date
    is
    begin
        return attribute_utl.get_date_value(p_deal_id, deal_utl.ATTR_CODE_CLOSE_DATE, p_value_date);
    end;

/*    function get_object_state_id(
        p_deal_id in integer,
        p_value_date in date default trunc(sysdate))
    return integer
    is
    begin
        return attribute_utl.get_number_value(p_deal_id, deal_utl.ATTR_CODE_STATE_ID, p_value_date);
    end;
*/
    function get_deal_branch_id(
        p_deal_id in integer,
        p_value_date in date)
    return varchar2
    is
    begin
        return attribute_utl.get_string_value(p_deal_id, deal_utl.ATTR_CODE_BRANCH_ID, p_value_date);
    end;

    function get_deal_curator_id(
        p_deal_id in integer,
        p_value_date in date)
    return integer
    is
    begin
        return attribute_utl.get_number_value(p_deal_id, deal_utl.ATTR_CODE_CURATOR_ID, p_value_date);
    end;

    procedure set_deal_number(
        p_deal_id in integer,
        p_deal_number in varchar2,
        p_comment in varchar2 default null)
    is
    begin
        attribute_utl.set_value(p_deal_id, deal_utl.ATTR_CODE_DEAL_NUMBER, p_deal_number, p_comment);
    end;

    procedure set_deal_number(
        p_deal_id in integer,
        p_deal_number in varchar2,
        p_value_date in date,
        p_comment in varchar2 default null)
    is
    begin
        attribute_utl.set_value(p_deal_id, deal_utl.ATTR_CODE_DEAL_NUMBER, p_deal_number, p_value_date, p_comment);
    end;

    procedure set_deal_number(
        p_deal_id in integer,
        p_deal_number in varchar2,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2 default null)
    is
    begin
        attribute_utl.set_value(p_deal_id, deal_utl.ATTR_CODE_DEAL_NUMBER, p_deal_number, p_valid_from, p_valid_through, p_comment);
    end;

    procedure set_deal_customer_id(
        p_deal_id in integer,
        p_customer_id in integer,
        p_comment in varchar2 default null)
    is
    begin
        attribute_utl.set_value(p_deal_id, deal_utl.ATTR_CODE_CUSTOMER_ID, p_customer_id, p_comment);
    end;

    procedure set_deal_customer_id(
        p_deal_id in integer,
        p_customer_id in integer,
        p_value_date in date,
        p_comment in varchar2 default null)
    is
    begin
        attribute_utl.set_value(p_deal_id, deal_utl.ATTR_CODE_CUSTOMER_ID, p_customer_id, p_value_date, p_comment);
    end;

    procedure set_deal_customer_id(
        p_deal_id in integer,
        p_customer_id in integer,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2 default null)
    is
    begin
        attribute_utl.set_value(p_deal_id, deal_utl.ATTR_CODE_CUSTOMER_ID, p_customer_id, p_valid_from, p_valid_through, p_comment);
    end;

    procedure set_deal_product_id(
        p_deal_id in integer,
        p_product_id in integer,
        p_comment in varchar2 default null)
    is
    begin
        attribute_utl.set_value(p_deal_id, deal_utl.ATTR_CODE_PRODUCT_ID, p_product_id, p_comment);
    end;

    procedure set_deal_product_id(
        p_deal_id in integer,
        p_product_id in integer,
        p_value_date in date,
        p_comment in varchar2 default null)
    is
    begin
        attribute_utl.set_value(p_deal_id, deal_utl.ATTR_CODE_PRODUCT_ID, p_product_id, p_value_date, p_comment);
    end;

    procedure set_deal_product_id(
        p_deal_id in integer,
        p_product_id in integer,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2 default null)
    is
    begin
        attribute_utl.set_value(p_deal_id, deal_utl.ATTR_CODE_PRODUCT_ID, p_product_id, p_valid_from, p_valid_through, p_comment);
    end;

    procedure set_deal_start_date(
        p_deal_id in integer,
        p_start_date in date,
        p_comment in varchar2 default null)
    is
    begin
        attribute_utl.set_value(p_deal_id, deal_utl.ATTR_CODE_START_DATE, p_start_date, p_comment);
    end;

    procedure set_deal_start_date(
        p_deal_id in integer,
        p_start_date in date,
        p_value_date in date,
        p_comment in varchar2 default null)
    is
    begin
        attribute_utl.set_value(p_deal_id, deal_utl.ATTR_CODE_START_DATE, p_start_date, p_value_date, p_comment);
    end;

    procedure set_deal_start_date(
        p_deal_id in integer,
        p_start_date in date,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2 default null)
    is
    begin
        attribute_utl.set_value(p_deal_id, deal_utl.ATTR_CODE_START_DATE, p_start_date, p_valid_from, p_valid_through, p_comment);
    end;

    procedure set_deal_expiry_date(
        p_deal_id in integer,
        p_expiry_date in date,
        p_comment in varchar2 default null)
    is
    begin
        attribute_utl.set_value(p_deal_id, deal_utl.ATTR_CODE_EXPIRY_DATE, p_expiry_date, p_comment);
    end;

    procedure set_deal_expiry_date(
        p_deal_id in integer,
        p_expiry_date in date,
        p_value_date in date,
        p_comment in varchar2 default null)
    is
    begin
        attribute_utl.set_value(p_deal_id, deal_utl.ATTR_CODE_EXPIRY_DATE, p_expiry_date, p_value_date, p_comment);
    end;

    procedure set_deal_expiry_date(
        p_deal_id in integer,
        p_expiry_date in date,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2 default null)
    is
    begin
        attribute_utl.set_value(p_deal_id, deal_utl.ATTR_CODE_EXPIRY_DATE, p_expiry_date, p_valid_from, p_valid_through, p_comment);
    end;

    procedure set_deal_close_date(
        p_deal_id in integer,
        p_close_date in date,
        p_comment in varchar2 default null)
    is
    begin
        attribute_utl.set_value(p_deal_id, deal_utl.ATTR_CODE_CLOSE_DATE, p_close_date, p_comment);
    end;

    procedure set_deal_close_date(
        p_deal_id in integer,
        p_close_date in date,
        p_value_date in date,
        p_comment in varchar2 default null)
    is
    begin
        attribute_utl.set_value(p_deal_id, deal_utl.ATTR_CODE_CLOSE_DATE, p_close_date, p_value_date, p_comment);
    end;

    procedure set_deal_close_date(
        p_deal_id in integer,
        p_close_date in date,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2 default null)
    is
    begin
        attribute_utl.set_value(p_deal_id, deal_utl.ATTR_CODE_CLOSE_DATE, p_close_date, p_valid_from, p_valid_through, p_comment);
    end;

    procedure set_deal_state(
        p_deal_id in integer,
        p_state_id in integer,
        p_comment in varchar2 default null)
    is
    begin
        object_utl.set_object_state(p_deal_id, p_state_id, p_comment);
    end;

    procedure set_deal_state(
        p_deal_id in integer,
        p_state_id in integer,
        p_value_date in date,
        p_comment in varchar2 default null)
    is
    begin
        object_utl.set_object_state(p_deal_id, p_state_id, p_value_date, p_comment);
    end;

    procedure set_deal_state(
        p_deal_id in integer,
        p_state_id in integer,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2 default null)
    is
    begin
        object_utl.set_object_state(p_deal_id, p_state_id, p_valid_from, p_valid_through, p_comment);
    end;

    procedure set_deal_state(
        p_deal_id in integer,
        p_state_code in varchar2,
        p_comment in varchar2 default null)
    is
    begin
        object_utl.set_object_state(p_deal_id, p_state_code, p_comment);
    end;

    procedure set_deal_state(
        p_deal_id in integer,
        p_state_code in varchar2,
        p_value_date in date,
        p_comment in varchar2 default null)
    is
    begin
        object_utl.set_object_state(p_deal_id, p_state_code, p_value_date, p_comment);
    end;

    procedure set_deal_state(
        p_deal_id in integer,
        p_state_code in varchar2,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2 default null)
    is
    begin
        object_utl.set_object_state(p_deal_id, p_state_code, p_valid_from, p_valid_through, p_comment);
    end;

    procedure set_deal_branch_id(
        p_deal_id in integer,
        p_branch_id in varchar2,
        p_comment in varchar2 default null)
    is
    begin
        attribute_utl.set_value(p_deal_id, deal_utl.ATTR_CODE_BRANCH_ID, p_branch_id, p_comment);
    end;

    procedure set_deal_branch_id(
        p_deal_id in integer,
        p_branch_id in varchar2,
        p_value_date in date,
        p_comment in varchar2 default null)
    is
    begin
        attribute_utl.set_value(p_deal_id, deal_utl.ATTR_CODE_BRANCH_ID, p_branch_id, p_value_date, p_comment);
    end;

    procedure set_deal_branch_id(
        p_deal_id in integer,
        p_branch_id in varchar2,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2 default null)
    is
    begin
        attribute_utl.set_value(p_deal_id, deal_utl.ATTR_CODE_BRANCH_ID, p_branch_id, p_valid_from, p_valid_through, p_comment);
    end;

    procedure set_deal_curator_id(
        p_deal_id in integer,
        p_curator_id in integer,
        p_comment in varchar2 default null)
    is
    begin
        attribute_utl.set_value(p_deal_id, deal_utl.ATTR_CODE_CURATOR_ID, p_curator_id, p_comment);
    end;

    procedure set_deal_curator_id(
        p_deal_id in integer,
        p_curator_id in integer,
        p_value_date in date,
        p_comment in varchar2 default null)
    is
    begin
        attribute_utl.set_value(p_deal_id, deal_utl.ATTR_CODE_CURATOR_ID, p_curator_id, p_value_date, p_comment);
    end;

    procedure set_deal_curator_id(
        p_deal_id in integer,
        p_curator_id in integer,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2 default null)
    is
    begin
        attribute_utl.set_value(p_deal_id, deal_utl.ATTR_CODE_CURATOR_ID, p_curator_id, p_valid_from, p_valid_through, p_comment);
    end;

    function get_deal_account(
        p_deal_id in integer,
        p_account_type_id in integer)
    return integer
    is
        l_accounts number_list;
    begin
        l_accounts := attribute_utl.get_number_values(p_deal_id, p_account_type_id);
        if (l_accounts is null or l_accounts is empty) then
            return null;
        else
            if (l_accounts.count = 1) then
                return l_accounts(1);
            else
                raise_application_error(-20000, 'По типу рахунку {' || attribute_utl.get_attribute_name(p_account_type_id) ||
                                                '} прив''язано більше одного рахунку до угоди з ідентифікатором {' || p_deal_id ||
                                                '}. Для отримання всіх прив''язаних рахунків необхідно скористатися функцією get_deal_accounts' ||
                                                ', що поверне весь масив рахунків');
            end if;
        end if;
    end;

    function get_deal_account(
        p_deal_id in integer,
        p_account_type_code in varchar2)
    return integer
    is
    begin
        return get_deal_account(p_deal_id, attribute_utl.read_attribute(p_account_type_code).id);
    end;

    function get_deal_accounts(
        p_deal_id in integer,
        p_account_type_id in integer)
    return number_list
    is
    begin
        return attribute_utl.get_number_values(p_deal_id, p_account_type_id);
    end;

    function get_deal_accounts(
        p_deal_id in integer,
        p_account_type_code in varchar2)
    return number_list
    is
    begin
        return attribute_utl.get_number_values(p_deal_id, p_account_type_code);
    end;

    procedure set_deal_account(
        p_deal_id in integer,
        p_account_type_id in integer,
        p_account_id in integer)
    is
    begin
        attribute_utl.set_value(p_deal_id, p_account_type_id, number_list(p_account_id));
    end;

    procedure set_deal_account(
        p_deal_id in integer,
        p_account_type_code in varchar2,
        p_account_id in integer)
    is
    begin
        attribute_utl.set_value(p_deal_id, p_account_type_code, number_list(p_account_id));
    end;

    procedure set_deal_accounts(
        p_deal_id in integer,
        p_account_type_id in integer,
        p_accounts in number_list)
    is
    begin
        attribute_utl.set_value(p_deal_id, p_account_type_id, p_accounts);
    end;

    procedure set_deal_accounts(
        p_deal_id in integer,
        p_account_type_code in varchar2,
        p_accounts in number_list)
    is
    begin
        attribute_utl.set_value(p_deal_id, p_account_type_code, p_accounts);
    end;

    function get_account_deals(
        p_account_id in integer,
        p_account_type_id in integer,
        p_value_date in date default trunc(sysdate))
    return number_list
    is
        l_deals number_list;
        l_attribute_current_date date;
    begin
        -- В разі виникнення розходжень між deal_account і attribute_value_by_date - розкоментувати закоментовані частини коду
        l_attribute_current_date := attribute_utl.get_attribute_current_date(p_account_type_id);

        if (tools.equals(l_attribute_current_date, p_value_date)) then
            select da.deal_id
            bulk collect into l_deals
            from   deal_account da
            where  da.account_type_id = p_account_type_id and
                   da.account_id = p_account_id;
        else
            select vbd.object_id
            bulk collect into l_deals
            from   attribute_value_by_date vbd
            where  vbd.attribute_id = p_account_type_id and
                   vbd.nested_table_id in (select v.nested_table_id
                                           from   attribute_values v
                                           where  v.number_values = p_account_id) and
                   vbd.value_date = (select max(vd.value_date)
                                     from   attribute_value_by_date vd
                                     where  vd.attribute_id = p_account_type_id and
                                            vd.object_id = vbd.object_id and
                                            (vd.value_date is null or vd.value_date <= p_value_date or p_value_date is null));
        end if;

        return l_deals;
    end;

    function get_account_deal(
        p_account_id in integer,
        p_account_type_id in integer,
        p_choose_one_from_list in char default 'N')
    return integer
    is
        l_deal_id integer;
        l_deals number_list;
    begin
        l_deals := get_account_deals(p_account_id, p_account_type_id);

        if (l_deals is null or l_deals is empty) then
            return null;
        elsif (l_deals.count = 1) then
            return l_deals(l_deals.first);
        else
            if (p_choose_one_from_list = 'Y') then
                -- в тому разі, коли ми маємо більше ніж одну угоду, прив'язану до одного і того самого рахунку, потрібно визначити яку з них
                -- повернути в якості основної - на даний час алгоритм працює наступним чином:
                --  - відкидаються всі угоди, статус яких "Видалена"
                --  - відбирається угода за пріоритетом - серед відкритих та що була створена останньою,
                --    якщо відкритих немає, то серед закритих та, що була закрита останньою
                select min(d.id) keep (dense_rank first order by d.close_date desc, d.id desc)
                into   l_deal_id
                from   deal d
                join   object o on o.id = d.id and
                                   o.state_id <> object_utl.get_deleted_object_state_id
                where  d.id in (select column_value from table(l_deals));

                return l_deal_id;
            else
                raise_application_error(-20000, 'Рахунок з ідентифікатором {' || p_account_id ||
                                                '} прив''язаний до більш ніж однієї угоди - для отримання повного переліку цих угод необхідно ' ||
                                                'використовувати функцію get_account_deals');
            end if;
        end if;
    end;

    function get_account_deal_row(
        p_account_id in integer,
        p_account_type_id in integer,
        p_choose_one_from_list in char default 'N')
    return deal%rowtype
    is
        l_deal_id integer;
    begin
        l_deal_id := get_account_deal(p_account_id, p_account_type_id, p_choose_one_from_list);

        if (l_deal_id is not null) then
            return read_deal(l_deal_id);
        else return null;
        end if;
    end;

    function find_deal_account(
        p_deal_id in integer,
        p_account_type_id in integer,
        p_currency_id in integer default null,
        p_raise_ndf in char default 'Y')
    return integer
    is
        l_attribute_row attribute_kind%rowtype;
        l_deal_accounts number_list;
        l_account_id integer;
    begin
        l_attribute_row := attribute_utl.read_attribute(p_account_type_id);

        if (l_attribute_row.attribute_type_id = attribute_utl.ATTR_TYPE_FIXED) then
            if (p_currency_id is null) then
                -- валюта не вказана - очікується, що рахунок буде тільки один і в потрібній валюті
                l_account_id := get_deal_account(p_deal_id, p_account_type_id);
            else
                -- валюта вказана - відбираємо лише ті рахунки, що відкриті в потрібній валюті
                -- (приорітет у відкритих рахунків, але якщо таких не знайдено - відбираємо рахунок, що був закритий останнім)
                l_deal_accounts := get_deal_accounts(p_deal_id, p_account_type_id);

                if (l_deal_accounts is not null and l_deal_accounts is not empty) then
                    select min(a.acc) keep (dense_rank last order by a.dazs)
                    into   l_account_id
                    from   accounts a
                    where  a.acc in (select column_value from table(l_deal_accounts)) and
                           a.kv = p_currency_id;
                end if;
            end if;
        else
            l_account_id := attribute_utl.get_number_value(p_deal_id, p_account_type_id);
        end if;

        if (l_account_id is null and p_raise_ndf = 'Y') then
            raise_application_error(-20000, 'Рахунок типу {' || l_attribute_row.attribute_name ||
                                            '} для угоди {' || p_deal_id ||
                                            case when p_currency_id is null then null
                                                 else '} в валюті {' || p_currency_id
                                            end ||
                                            '} не знайдений');
        end if;

        return l_account_id;
    end;
/*
    function get_or_create_deal_account(
        p_deal_id in integer,
        p_account_type_id in integer,
        p_currency_id in integer)
    return integer
    is
        l_account_row accounts%rowtype;
        l_account_number varchar2(30 char);
        l_account_type_row deal_account_type%rowtype;
        l_deal_row deal%rowtype;
    begin
        l_account_row.acc := get_deal_account(p_deal_id, p_account_type_id);

        if (l_account_row.acc is null) then
            l_account_type_row := read_account_type(p_account_type_id);
            l_deal_row := read_deal(p_deal_id);

            if (l_account_type_row.account_number_func is not null) then
                execute immediate 'begin :account_number := ' || l_account_type_row.account_number_func ||
                                         '(:account_type_id, :deal_id, :currency_id); end;'
                using out l_account_number,
                          l_account_type_row.id,
                          l_deal_row.id,
                          p_currency_id;
            else
                \*raise_application_error(-20000, 'Функція генерації номеру рахунку для типу {' || attribute_utl.get_attribute_name(l_account_type_row.id) ||
                                                '} не вказана');*\
                l_account_number := f_newnls2(null,
                                              l_account_type_row.account_mask,
                                              l_account_type_row.balance_account,
                                              l_deal_row.customer_id,
                                              l_deal_row.id,
                                              nvl(l_account_type_row.currency_id, p_currency_id));
            end if;

            if (l_account_number is not null) then
                l_account_row := account_utl.read_account(l_account_number, nvl(l_account_type_row.currency_id, p_currency_id));
                if (l_account_row.acc is not null) then
                    return l_account_row.acc;
                else
                    raise_application_error(-20000, 'Функціонал автоматичного відкриття рахунків не реалізований');
                    -- accreg.OPN_ACC(
                end if;
            else
                raise_application_error(-20000, 'Не вдалось сформувати номер рахунку типу {' || attribute_utl.get_attribute_name(l_account_type_row.id) ||
                                                '} для угоди з ідентифікатором {' || l_deal_row.id ||
                                                '} в валюті {' || nvl(l_account_type_row.currency_id, p_currency_id) || '}');
            end if;
        end if;
    end;*/
end;
/
