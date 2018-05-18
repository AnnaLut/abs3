create or replace package interest_utl is

    -- ��� ��������� ������ (int_idn)
    INTEREST_KIND_EFFECTIVE_RATE   constant integer := -2; -- ��������� ��������� ������ (������)
    INTEREST_KIND_ASSETS           constant integer :=  0; -- ������
    INTEREST_KIND_LIABILITIES      constant integer :=  1; -- ������
    INTEREST_KIND_FEES             constant integer :=  2; -- ����/�����
    INTEREST_KIND_LIABILITIES_FEES constant integer :=  3; -- ���� (������)
    INTEREST_KIND_EARLY_REPAYM_FEE constant integer :=  4; -- ����� �� ���������� ���������
    INTEREST_KIND_DEPOSIT_FEE      constant integer :=  5; -- ������ �� ���������

    -- ��� �������, �� ���� ������������ ������� (int_ion)
    BALANCE_KIND_BANK_DATE_OUT     constant integer := 0; -- �������� �� ��������� ����
    BALANCE_KIND_BANK_DATE_IN      constant integer := 1; -- ������� �� ��������� ����
    BALANCE_KIND_CALENDAR_OUT      constant integer := 3; -- �������� �� ���������� ����
    BALANCE_KIND_CALENDAR_IN       constant integer := 4; -- ������� �� ���������� ����

    INTEREST_METH_NORMAL           constant integer :=  0; -- ����������
    INTEREST_METH_AVERAGE_REST     constant integer :=  1; -- ��-����������
    INTEREST_METH_SAVINGS          constant integer :=  2; -- ����������
    INTEREST_METH_AMORT_BY_DATE    constant integer :=  3; -- ��������������� (�� ���� ���.%%)
    INTEREST_METH_AMORTIZATION     constant integer :=  4; -- �����������
    INTEREST_METH_AMORT_EFFEC_RATE constant integer :=  6; -- �����-�� �� ������� ��.% (���.��)
    INTEREST_METH_OVERDR_FLOW_RATE constant integer :=  7; -- �������� ������ ����������
    INTEREST_METH_COUPON_PAY_SCHED constant integer :=  8; -- �� ����i�� ������ ������ (���.��)
    INTEREST_METH_COMMIS_LAST_REST constant integer := 91; -- ������������� ( �� ���� �������)
    INTEREST_METH_COMMIS_DEB_TURN  constant integer := 92; -- ������������� (�� ����� ���.����.)
    INTEREST_METH_INIT_LOAN_AMOUNT constant integer := 93; -- % �� �������������� ����� ��
    INTEREST_METH_AVG_WEIGHT_AMOUN constant integer := 94; -- % �� ���������������� ����� �������
    INTEREST_METH_BY_INIT_REST     constant integer := 95; -- 95 �� ���������� ���
    INTEREST_METH_BY_CURRENT_REST  constant integer := 96; -- 96 �� �������� ���
    INTEREST_METH_BY_FIXED_AMOUNT  constant integer := 97; -- 97 �� ���������� ����
    INTEREST_METH_BY_CURRENT_LIMIT constant integer := 98; -- 98 �i� ������� ���� �i�i��
    INTEREST_METH_BY_LIMIT_SUM     constant integer := 99; -- 99 г�.% ��� �� � �����

    LT_RECKONING_STATE constant varchar2(30 char) := 'INTEREST_RECKONING_STATE';
    RECKONING_STATE_RECKONED       constant integer :=  1;
    RECKONING_STATE_MODIFIED       constant integer :=  2;
    RECKONING_STATE_RECKONING_FAIL constant integer :=  3;
    RECKONING_STATE_GROUPED        constant integer :=  4;
    RECKONING_STATE_ACCRUED        constant integer :=  5;
    RECKONING_STATE_ACCRUAL_FAILED constant integer :=  6;
    RECKONING_STATE_ACCR_DISCARDED constant integer :=  7;
    RECKONING_STATE_PAYED          constant integer :=  8;
    RECKONING_STATE_PAYMENT_FAILED constant integer :=  9;
    RECKONING_STATE_PAYM_DISCARDED constant integer := 10;
    RECKONING_STATE_ONLY_INFO      constant integer := 99;

    LT_RECKONING_LINE_TYPE         constant varchar2(30 char) := 'RECKONING_LINE_TYPE';
    RECKONING_TYPE_RAW             constant integer := 1;
    RECKONING_TYPE_GROUPING_UNIT   constant integer := 2;
    RECKONING_TYPE_CORRECTION      constant integer := 3;

    LT_RECKONING_DOCUMENT_ROLE     constant varchar2(30 char) := 'RECKONING_DOCUMENT_ROLE';
    RECKONING_DOC_ROLE_ACCRUAL     constant integer := 1;
    RECKONING_DOC_ROLE_PAYMENT     constant integer := 2;

    LT_RECKONING_GROUPING_MODE     constant varchar2(30 char) := 'RECKONING_GROUPING_MODE';
    GROUPING_MODE_NO_GROUPING      constant integer := 0;
    GROUPING_MODE_GROUP_BY_RATES   constant integer := 1;
    GROUPING_MODE_GROUP_ALL        constant integer := 99;

    LT_PERIODICITY_KIND            constant varchar2(30 char) := 'PERIODICITY_KIND';
    PERIODICITY_KIND_MANUAL        constant integer := 1;
    PERIODICITY_KIND_BY_DAY        constant integer := 2;
    PERIODICITY_KIND_BY_WEEK       constant integer := 3;
    PERIODICITY_KIND_BY_MONTH      constant integer := 4;
    PERIODICITY_KIND_BY_YEAR       constant integer := 5;
    PERIODICITY_KIND_BY_WEEK_DAY   constant integer := 6;
    PERIODICITY_KIND_BY_MONTH_DAY  constant integer := 7;
    PERIODICITY_KIND_BY_YEAR_DAY   constant integer := 8;
    PERIODICITY_KIND_NOT_AVAILABLE constant integer := 99;

    type t_interest_reckonings is table of int_reckonings%rowtype;

    type t_reckoning_unit is record
    (
        account_id integer,
        account_number varchar2(15 char),
        interest_kind integer,
        reckoning_method integer,
        reckoning_calendar integer,
        deal_id integer,
        date_from date,
        date_through date,
        base_amount integer,
        interest_amount number,
        error_message varchar2(32767 byte)
    );

    type t_reckoning_units is table of t_reckoning_unit;

    function read_int_accn(
        p_account_id in integer,
        p_interest_kind_id in integer,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return int_accn%rowtype;

    function read_int_idn(
        p_interest_kind_id integer,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return int_idn%rowtype;

    function get_interest_kind_name(
        p_interest_kind_id in integer)
    return integer;

    function get_interest_account_id(
        p_account_id in integer,
        p_interest_kind in integer)
    return integer;

    function get_income_account_id(
        p_account_id in integer,
        p_interest_kind in integer)
    return integer;

    -- ��������� rowtype ������ int_ratn, �� 䳺 �� ���� p_date_for
    function get_int_ratn_row_for_date(
        p_main_account_id in integer,
        p_interest_kind_id in integer,
        p_date_for in date)
    return int_ratn%rowtype;

    -- ��������� rowtype ������ int_ratn, �� 䳺 �� ���� ���� p_date_after
    -- �� �� ����'������ ���� ���� �������� �� p_date_after - ���� ���� ���� ����-���� ������ �� p_date_after
    -- (p_date_after �� ���������� � ������ ������ - �������� �������� � ����� ������� ������ ������ �� p_date_after)
    function get_int_ratn_row_after_date(
        p_main_account_id in integer,
        p_interest_kind_id in integer,
        p_date_after in date)
    return int_ratn%rowtype;

    procedure create_int_accn(
        p_main_account_id in integer,
        p_interest_kind_id in integer,
        p_rest_kind_id in integer,
        p_accrual_method_id in integer,
        p_base_year_id in integer,
        p_accrual_frequency_id in integer,
        p_accrual_stop_date in date,
        p_accrual_operation_code in varchar2,
        p_interest_account_id in integer,
        p_opposite_account_id in integer,
        p_payment_operation_code in varchar2 default null,
        p_payment_currency_id in integer default null,
        p_payment_doc_purpose_template in varchar2 default null,
        p_receiver_account_number in varchar2 default null,
        p_receiver_mfo in varchar2 default null,
        p_receiver_name in varchar2 default null,
        p_receiver_okpo in varchar2 default null,
        p_base_month_id in integer default null,
        p_last_accrual_date in date default null,
        p_last_payment_date in date default null,
        p_interest_remnant in number default null,
        p_overdraft_floating_rate_num in integer default null,
        p_mfo in varchar2 default null);

    procedure create_int_ratn(
        p_main_account_id in integer,
        p_interest_kind_id in integer,
        p_start_date in date,
        p_interest_rate in integer,
        p_base_rate_id in integer,
        p_base_rate_modifier in integer,
        p_mfo in varchar2 default sys_context('bars_context','user_mfo'));

    procedure set_interest_rate(
        p_main_account_id in integer,
        p_interest_kind_id in integer,
        p_interest_rate in number,
        p_base_rate_id in integer,
        p_base_rate_modifier in integer,
        p_valid_from in date default gl.bd(),
        p_valid_through in date default null,
        p_mfo in varchar2 default null);

    procedure start_reckoning;

    procedure end_reckoning;

    function find_previous_date(
        p_date_for in date,
        p_period_kind in varchar2,
        p_period_length in integer default 1,
        p_initial_date in date default null,
        p_strict_shift in integer default 0,
        p_holidays_handling in integer default 0)
    return date;

    function find_next_date(
        p_date_for in date,
        p_period_kind in varchar2,
        p_period_length in integer default 1,
        p_initial_date in date default null,
        p_strict_shift in integer default 0,
        p_holidays_handling in integer default null)
    return date;

    function pipe_dates(
        p_date_from in date,
        p_date_through in date,
        p_period_kind in varchar2,
        p_period_length in integer,
        p_initial_date in date,
        p_strict_shift in integer,
        p_holidays_handling in integer)
    return date_list
    pipelined;

    -- ��������� ������ � ������������ ���������� ��������
    procedure create_reckoning_row(
        p_account_id in integer,                      -- ������������� �������, �� ����� �������������� �������
        p_interest_kind in integer,                   -- ��� ��������� ������ (������� int_idn, 0 - ������, 1 - ������, 2 - ���� � �.�.)
        p_date_from in date,                          -- ���� ������� ������, �� ���� ����������� ������� (������� ������ �����������)
        p_date_through in date,                       -- ���� ���������� ������, �� ���� ����������� ������� (������� ������ �����������)
        p_account_rest in integer,                    -- ������� �������, �� ���� ������������� ������� (�������� �������� ������ �����������)
        p_interest_rate in number,                    -- ������, �� 䳺 �������� �������������� ������
        p_interest_amount in integer,                 -- ���� ������������ ������� � ������� � ����� ��������� �������
        p_interest_tail in number,                    -- ������ ������� ������
        p_purpose in varchar2,                        -- ����������� ��������
        p_deal_id in integer default null,            -- ������������� �����, � ������ ��� ������������� ������� (�� ����'������)
        p_row_state_id in integer default null,       -- ������ ������ ��� ����������� (��� ����������� �� �������� - �������� null)
        p_row_comment in varchar2 default null);      -- ��������, �� ������������ �����������

    procedure take_reckoning_data(
        p_base_year in integer,
        p_purpose in varchar2 default null,
        p_deal_id in integer default null);

    function lock_reckoning_row(
        p_id in integer,
        p_skip_locked in boolean default true)
    return int_reckoning%rowtype;

    procedure edit_reckoning_row(
        p_id in integer,
        p_interest_amount in number,
        p_purpose in varchar2);

    procedure prepare_interest_utl(
        p_reckoning_id in varchar2,
        p_account_id in integer,
        p_account_number in varchar2,
        p_account_rest in number,
        p_interest_kind in integer,
        p_interest_base in integer, --
        p_interest_method_id in integer,
        p_date_from in date,
        p_date_through in date,
        p_deal_id in integer);

    function prepare_interest(
        p_accounts in number_list,
        p_date_through in date)
    return varchar2;

    function prepare_deal_interest(
        p_deals in number_list,
        p_date_through in date)
    return varchar2;

    procedure pay_int_reckoning_row(
        p_int_reckoning_row in int_reckoning%rowtype,
        p_silent_mode in boolean default false,
        p_do_not_store_interest_tails in boolean default false);

    procedure pay_accrued_interest(
        p_do_not_store_interest_tails in boolean default false);

    procedure remove_reckoning(
        p_id in integer);

    function read_reckoning_row(
        p_id in integer,
        p_raise_ndf in boolean default true,
        p_lock in boolean default false)
    return int_reckonings%rowtype;

    function create_interest_reckoning(
        p_reckoning_type_id in integer,
        p_account_id in integer,
        p_interest_kind_id in integer,
        p_date_from in date,
        p_date_through in date,
        p_account_rest in integer,
        p_interest_rate in number,
        p_interest_amount in integer,
        p_interest_tail in number,
        p_state_id in integer default null,
        p_deal_id in integer default null)
    return integer;

    function get_rate_purpose_clause(
        p_reckoning_id in integer,
        p_reckoning_type_id in integer,
        p_interest_rate in number)
    return varchar2;
/*
    function generate_accrual_purpose(
        p_reckoning_method in integer,
        p_account_number in varchar2,
        p_date_from in date,
        p_date_through in date,
        p_interest_rate in number)
    return varchar2;
*/
    function generate_accrual_purpose(
        p_reckoning_id in integer,
        p_reckoning_type_id in integer,
        p_reckoning_method in integer,
        p_account_number in varchar2,
        p_date_from in date,
        p_date_through in date,
        p_interest_rate in number)
    return varchar2;
/*
    function generate_payment_purpose(
        p_reckoning_method in integer,
        p_account_number in varchar2,
        p_date_from in date,
        p_date_through in date,
        p_interest_rate in number)
    return varchar2;
*/
    function generate_payment_purpose(
        p_reckoning_id in integer,
        p_reckoning_type_id in integer,
        p_reckoning_method in integer,
        p_account_number in varchar2,
        p_date_from in date,
        p_date_through in date,
        p_interest_rate in number)
    return varchar2;

    function get_accrual_purpose(
        p_reckoning_id in integer)
    return varchar2;

    function get_payment_purpose(
        p_reckoning_id in integer)
    return varchar2;

    function get_reckoning_purpose(
        p_reckoning_id in integer)
    return varchar2;

    function get_reckoning_comment(
        p_reckoning_id in integer,
        p_reckoning_state_id in integer,
        p_accrual_document_id in integer,
        p_payment_document_id in integer)
    return varchar2;

    procedure reckon_interest(
        p_reckoning_unit in out nocopy t_reckoning_unit);

    procedure reckon_interest(
        p_account_id in integer,
        p_interest_kind_id in integer,
        p_date_through in date,
        p_deal_id in integer default null);

    -- ��������� ���������� ������������� ��� ������� �� ���������� ������� "�� �����������" ��� ������� �������
    procedure reckon_interest(
        p_accounts in number_list,
        p_date_through in date);

    -- ��������� ������������� ��� ������� �� ���������� ��������� �� ������� �������:
    -- ����������� ������, �������� ���� ���������� (�����/�����/���� � �.�.)
    procedure reckon_interest(
        p_reckoning_units in out nocopy t_reckoning_units);

    procedure reckon_deal_interest(
        p_deals in number_list,
        p_date_through in date);

    procedure group_reckonings(
        p_accounts in number_list,
        p_grouping_mode_id in integer);

    procedure redact_reckoning(
        p_reckoning_id in integer,
        p_interest_amount in number,
        p_accrual_purpose in varchar2);

    function months_between_alt(
        p_date_from in date,
        p_date_to   in date)
    return number;

    procedure clear_reckonings(
        p_reckoning_row in int_reckonings%rowtype);

    procedure clear_reckonings(
        p_account_id in integer,
        p_interest_kind_id in integer,
        p_date_from in date);

    procedure clear_reckonings(
        p_account_id in integer,
        p_interest_kind_id in integer default null);

    procedure accrue_interest(
        p_reckoning_row in int_reckonings%rowtype,
        p_silent_mode in boolean default false,
        p_do_not_store_interest_tail in boolean default false,
        p_dk in integer default null);

    procedure accrue_reckoned_interest(
        p_filter in varchar2,
        p_do_not_store_interest_tail in boolean default false);

    procedure accrue_reckoned_interest(
        p_accounts in number_list,
        p_do_not_store_interest_tail in boolean default false);

    procedure accrue_deal_interest(
        p_deals in number_list,
        p_do_not_store_interest_tail in boolean default false);

    procedure pay_interest(
        p_reckoning_row int_reckonings%rowtype,
        p_silent_mode in boolean default false);

    procedure pay_accrued_interest(
        p_filter in varchar2);

    procedure pay_accrued_interest(
        p_accounts in number_list);

    procedure on_accrual_document_revert(
        p_document_id in integer);

    procedure on_payment_document_revert(
        p_document_id in integer);

    procedure accrue_reckoned_interest;
/*
    procedure accrue_reckoned_interest(
        p_dictionary_list in t_dictionary_list,
        p_message out varchar2);*/
/*
    procedure calculate_interest_amount;
*/
    procedure p_int(
        acc_  integer, -- account number
        id_   smallint,-- calc code
        dt1_  date,    -- from date
        dt2_  date,    -- to   date
        int_  out number, -- interest accrued
        ost_  decimal default null,
        mode_ smallint default 0);
end;
/
create or replace package body interest_utl as

    acc_form integer := 0;
    g_acc integer := 0;

    function read_int_accn(
        p_account_id in integer,
        p_interest_kind_id in integer,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return int_accn%rowtype
    is
        l_int_accn_row int_accn%rowtype;
    begin
        if (p_lock) then
            select *
            into   l_int_accn_row
            from   int_accn n
            where  n.acc = p_account_id and
                   n.id = p_interest_kind_id
            for update;
        else
            select *
            into   l_int_accn_row
            from   int_accn n
            where  n.acc = p_account_id and
                   n.id = p_interest_kind_id;
        end if;

        return l_int_accn_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                 raise_application_error(-20000,
                                         '��������� �������� ��� ������� � ��������������� {' || p_account_id ||
                                         '} ��� ���� {' || p_interest_kind_id ||
                                         '} �� �������');
             else return null;
             end if;
    end;

    function read_int_idn(
        p_interest_kind_id integer,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return int_idn%rowtype
    is
        l_int_idn_row int_idn%rowtype;
    begin
        if (p_lock) then
            select *
            into   l_int_idn_row
            from   int_idn t
            where  t.id = p_interest_kind_id
            for update;
        else
            select *
            into   l_int_idn_row
            from   int_idn t
            where  t.id = p_interest_kind_id;
        end if;

        return l_int_idn_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                 raise_application_error(-20000, '��� ����������� ������� � ��������������� {' || p_interest_kind_id || '} �� ���������');
             else return null;
             end if;
    end;

    function get_interest_kind_name(
        p_interest_kind_id in integer)
    return integer
    is
    begin
        return read_int_idn(p_interest_kind_id, p_raise_ndf => false).name;
    end;

    function get_interest_account_id(
        p_account_id in integer,
        p_interest_kind in integer)
    return integer
    is
    begin
        return read_int_accn(p_account_id, p_interest_kind, p_raise_ndf => false).acra;
    end;

    function get_income_account_id(
        p_account_id in integer,
        p_interest_kind in integer)
    return integer
    is
    begin
        return read_int_accn(p_account_id, p_interest_kind, p_raise_ndf => false).acrb;
    end;

    procedure create_int_accn(
        p_main_account_id in integer,
        p_interest_kind_id in integer,
        p_rest_kind_id in integer,
        p_accrual_method_id in integer,
        p_base_year_id in integer,
        p_accrual_frequency_id in integer,
        p_accrual_stop_date in date,
        p_accrual_operation_code in varchar2,
        p_interest_account_id in integer,
        p_opposite_account_id in integer,
        p_payment_operation_code in varchar2 default null,
        p_payment_currency_id in integer default null,
        p_payment_doc_purpose_template in varchar2 default null,
        p_receiver_account_number in varchar2 default null,
        p_receiver_mfo in varchar2 default null,
        p_receiver_name in varchar2 default null,
        p_receiver_okpo in varchar2 default null,
        p_base_month_id in integer default null,
        p_last_accrual_date in date default null,
        p_last_payment_date in date default null,
        p_interest_remnant in number default null,
        p_overdraft_floating_rate_num in integer default null,
        p_mfo in varchar2 default null)
    is
        l_mfo varchar2(6 char) := case when p_mfo is null then sys_context('bars_context','user_mfo')else p_mfo end;
    begin
        if (p_main_account_id is null) then
            raise_application_error(-20000, '������� �� ����� ������������� ������� �� ��������');
        end if;

        if (p_interest_kind_id is null) then
            raise_application_error(-20000, '��� ����������� ������� �� ��������');
        end if;

        if (p_rest_kind_id is null) then
            raise_application_error(-20000, '��� �������, �� ���� ������������� ������� �� ��������');
        end if;

        if (p_accrual_method_id is null) then
            raise_application_error(-20000, '����� ���������� ������� �� ��������');
        end if;

        if (p_base_year_id is null) then
            raise_application_error(-20000, '���� ����������� ������� �� �������');
        end if;

        if (p_accrual_frequency_id is null) then
            raise_application_error(-20000, '����������� ����������� ������� �� �������');
        end if;

        if (p_interest_account_id is null) then
            raise_application_error(-20000, '������� ������� �� ��������');
        end if;

        if (p_opposite_account_id is null) then
            raise_application_error(-20000, '������� ������/������ �� ��������');
        end if;

        /*if (l_mfo is null) then
            l_mfo := account_utl.get_account_mfo(p_main_account_id);
        end if;*/

        begin
            insert into int_accn
            values (p_main_account_id,                    -- acc     number(38),                       ����� �����
                    p_interest_kind_id,                   -- id      number,
                    p_accrual_method_id,                  -- metr    number,                           ����� ����������
                    p_base_month_id,                      -- basem   integer,                          ������� �����
                    p_base_year_id,                       -- basey   integer,                          ������� ���
                    p_accrual_frequency_id,               -- freq    number(3),                        �������������
                    p_accrual_stop_date,                  -- stp_dat date,                             ���� ���������
                    p_last_accrual_date,                  -- acr_dat date default (trunc(sysdate)-1),  ���� ���������� ����������
                    p_last_payment_date,                  -- apl_dat date,                             ���� ��������� �������
                    nvl(p_accrual_operation_code, '%%1'), -- tt      char(3) default '%%1',            ��� �������� ���������� ���������
                    p_interest_account_id,                -- acra    number(38),                       ���� ���.%%
                    p_opposite_account_id,                -- acrb    number(38),                       ��������� 6-7 ������
                    p_interest_remnant,                   -- s       number default 0,                 ����� ���������
                    p_payment_operation_code,             -- ttb     char(3),                          ��� �������� ������� %
                    p_payment_currency_id,                -- kvb     number(3),                        ��� ������ ������� %
                    p_receiver_account_number,            -- nlsb    varchar2(15),                     ���� ���������� ��� ������� %
                    p_receiver_mfo,                       -- mfob    varchar2(12),                     ��� ���������� ��� ������� %
                    p_receiver_name,                      -- namb    varchar2(38),                     ������������ ���������� ��� ������� %
                    p_payment_doc_purpose_template,       -- nazn    varchar2(160),                    ���������� �������
                    p_rest_kind_id,                       -- io      number(1) default 0,              ��� ������� (�� ���-�� int_ion)
                    user_id(),                            -- idu     number,
                    p_overdraft_floating_rate_num,        -- idr     integer,                          ����� ����� �������� % ������ ���������� (��� METR=7).
                    l_mfo,                                -- kf      varchar2(6) default sys_context('bars_context','user_mfo'),
                    p_receiver_okpo);                     -- okpo    varchar2(14)
        exception
            when dup_val_on_index then
                 raise_application_error(-20000,
                                         '��������� ����������� ������� ���� {' || get_interest_kind_name(p_interest_kind_id) ||
                                         '} ��� ������� {' || account_utl.get_account_number(p_main_account_id) || '} ��� ��������');
        end;
    end;

    procedure create_int_ratn(
        p_main_account_id in integer,
        p_interest_kind_id in integer,
        p_start_date in date,
        p_interest_rate in integer,
        p_base_rate_id in integer,
        p_base_rate_modifier in integer,
        p_mfo in varchar2 default sys_context('bars_context','user_mfo'))
    is
        l_mfo varchar2(6 char) := case when p_mfo is null then sys_context('bars_context','user_mfo') else p_mfo end;
    begin
        if (p_main_account_id is null) then
            raise_application_error(-20000, '������� �� ����� ������������� ������� �� ��������');
        end if;

        if (p_interest_kind_id is null) then
            raise_application_error(-20000, '��� ����������� ������� �� ��������');
        end if;

        if (p_start_date is null) then
            raise_application_error(-20000, '���� ������� 䳿 ������ �� �������');
        end if;

        if (p_interest_rate is null and p_base_rate_id is null) then
            raise_application_error(-20000, '³��������� ������ �� �������');
        elsif (p_interest_rate is not null and p_base_rate_id is not null and p_base_rate_modifier is null) then
            raise_application_error(-20000, '����������� ������ ������ �� ��������');
        end if;

        /*if (l_mfo is null) then
            l_mfo := account_utl.get_account_mfo(p_main_account_id);
        end if;*/

        begin
            insert into int_ratn
            values (p_main_account_id,     -- acc  number(38),
                    p_interest_kind_id,    -- id   number,
                    p_start_date,          -- bdat date,
                    p_interest_rate,       -- ir   number,
                    p_base_rate_id,        -- br   number(38),
                    p_base_rate_modifier,  -- op   number(4),
                    user_id(),             -- idu  number(38),
                    l_mfo);                -- kf   varchar2(6) default sys_context('bars_context','user_mfo')
        exception
            when dup_val_on_index then
                 raise_application_error(-20000,
                                         '³�������� ������ ��� ���� ����������� {' || get_interest_kind_name(p_interest_kind_id) ||
                                         '} ��� ������� {' || account_utl.get_account_number(p_main_account_id) ||
                                         '} �� ���� {' || to_char(p_start_date, 'dd.mm.yyyy') || '} ��� �������');
        end;
    end;

    function get_int_ratn_row_for_date(
        p_main_account_id in integer,
        p_interest_kind_id in integer,
        p_date_for in date)
    return int_ratn%rowtype
    is
        l_int_ratn_row int_ratn%rowtype;
    begin
        select p_main_account_id,
               p_interest_kind_id,
               min(t.bdat) keep (dense_rank last order by t.bdat),
               min(t.ir) keep (dense_rank last order by t.bdat),
               min(t.br) keep (dense_rank last order by t.bdat),
               min(t.op) keep (dense_rank last order by t.bdat),
               min(t.idu) keep (dense_rank last order by t.bdat),
               min(t.kf) keep (dense_rank last order by t.bdat)
        into   l_int_ratn_row
        from   int_ratn t
        where  t.acc = p_main_account_id and
               t.id = p_interest_kind_id and
               t.bdat <= p_date_for;

        return l_int_ratn_row;
    end;

    function get_int_ratn_row_after_date(
        p_main_account_id in integer,
        p_interest_kind_id in integer,
        p_date_after in date)
    return int_ratn%rowtype
    is
        l_int_ratn_row int_ratn%rowtype;
    begin
        select p_main_account_id,
               p_interest_kind_id,
               min(t.bdat),
               min(t.ir) keep (dense_rank first order by t.bdat),
               min(t.br) keep (dense_rank first order by t.bdat),
               min(t.op) keep (dense_rank first order by t.bdat),
               min(t.idu) keep (dense_rank first order by t.bdat),
               min(t.kf) keep (dense_rank first order by t.bdat)
        into   l_int_ratn_row
        from   int_ratn t
        where  t.acc = p_main_account_id and
               t.id = p_interest_kind_id and
               t.bdat > p_date_after;

        return l_int_ratn_row;
    end;

    procedure set_interest_rate(
        p_main_account_id in integer,
        p_interest_kind_id in integer,
        p_interest_rate in number,
        p_base_rate_id in integer,
        p_base_rate_modifier in integer,
        p_valid_from in date default gl.bd(),
        p_valid_through in date default null,
        p_mfo in varchar2 default null)
    is
        l_int_ratn_row_after_date int_ratn%rowtype;
        l_int_ratn_row_for_date int_ratn%rowtype;
    begin
        if (p_main_account_id is null) then
            raise_application_error(-20000, '������� �� ����� ������������� ������� �� ��������');
        end if;

        if (p_interest_kind_id is null) then
            raise_application_error(-20000, '��� ����������� ������� �� ��������');
        end if;

        if (p_valid_from is null) then
            raise_application_error(-20000, '���� ������� 䳿 ������ �� �������');
        end if;

        if (p_interest_rate is null and p_base_rate_id is null) then
            raise_application_error(-20000, '³�������� ������ �� �������');
        elsif (p_interest_rate is not null and p_base_rate_id is not null and p_base_rate_modifier is null) then
            raise_application_error(-20000, '����������� ������ ������ �� ��������');
        end if;

        -- ���� ���������� 䳿 ������ �� ������� - �� ������, �� ������ 䳺 �����������
        -- � ����� ��� ���� �������� ������ ����������� �� ������� ��������, �� ���� ���� ���� p_valid_from
        -- (�� ������ � ����� ������� 䳿 ����� �� p_valid_from (�������) ������������ � �������)
        if (p_valid_through is null) then
            delete int_ratn t
            where  t.acc = p_main_account_id and
                   t.id = p_interest_kind_id and
                   tools.compare_range_borders(p_valid_from, t.bdat) <= 0;

            create_int_ratn(p_main_account_id, p_interest_kind_id, p_valid_from, p_interest_rate, p_base_rate_id, p_base_rate_modifier, p_mfo => p_mfo);
        else
            l_int_ratn_row_for_date := get_int_ratn_row_for_date(p_main_account_id, p_interest_kind_id, p_valid_through);

            delete int_ratn t
            where  t.acc = p_main_account_id and
                   t.id = p_interest_kind_id and
                   tools.compare_range_borders(p_valid_from, t.bdat) <= 0 and
                   tools.compare_range_borders(t.bdat, p_valid_through) <= 0;

            create_int_ratn(p_main_account_id, p_interest_kind_id, p_valid_from, p_interest_rate, p_base_rate_id, p_base_rate_modifier, p_mfo => p_mfo);

            -- ������� ����� 䳿 ���� ������ ��������� ����� p_valid_through, �� � ���� p_valid_through + 1 ������ (��������) ����
            -- �� �������� ������, �� ���� �� ����� ������� (���� ���� �������� ���� ��������)
            if (l_int_ratn_row_for_date.bdat is not null) then

                -- ���������� �� ��� �� ����������� ���� �������� ������, �� ������ ���� � ���� p_valid_through + 1
                -- ���� ���� �������� ���������� - ����� �� ������, ������� ����� �������� ������ �� 䳺 ������� ��� ���� ���� p_valid_through
                l_int_ratn_row_after_date := get_int_ratn_row_after_date(p_main_account_id, p_interest_kind_id, p_valid_through);

                -- ���� ����� (tools.compare_range_borders(p_valid_through + 1, l_int_ratn_row_after_date.bdat) < 0) �������� ��� �� ��
                -- �������� ������ � ����� ������� 䳿 ���� p_valid_through �������� � ���� ���� ������� 䳿 ����� �� p_valid_through + 1.
                -- � ����� ��� ����� �������� ������ �������� ���� � ���� p_valid_through + 1 �� ���� ������� 䳿 �������� ������ (l_int_ratn_row_after_date.bdat)
                if (tools.compare_range_borders(p_valid_through + 1, l_int_ratn_row_after_date.bdat) < 0) then
                    create_int_ratn(p_main_account_id,
                                    p_interest_kind_id,
                                    p_valid_through + 1,
                                    l_int_ratn_row_for_date.ir,
                                    l_int_ratn_row_for_date.br,
                                    l_int_ratn_row_for_date.op,
                                    p_mfo => l_int_ratn_row_for_date.kf);
                end if;
            end if;
        end if;
    end;

    procedure start_reckoning
    is
    begin
        pul.set_mas_ini('reckoning_id', sys_guid(), null);
    end;

    procedure end_reckoning
    is
    begin
        pul.set_mas_ini('reckoning_id', null, null);
    end;

    procedure create_reckoning_row(
        p_account_id in integer,
        p_interest_kind in integer,
        p_date_from in date,
        p_date_through in date,
        p_account_rest in integer,
        p_interest_rate in number,
        p_interest_amount in integer,
        p_interest_tail in number,
        p_purpose in varchar2,
        p_deal_id in integer default null,
        p_row_state_id in integer default null,
        p_row_comment in varchar2 default null)
    is
        l_reckoning_id varchar2(32 char) := pul.get_mas_ini_val('reckoning_id');
    begin
        if (l_reckoning_id is null) then
            start_reckoning();
            l_reckoning_id := pul.get_mas_ini_val('reckoning_id');
        end if;
         insert
         into int_reckoning
                ( id,
                  reckoning_id,
                  deal_id,
                  account_id,
                  interest_kind,
                  date_from,
                  date_to,
                  account_rest,
                  interest_rate,
                  interest_amount,
                  interest_tail,
                  purpose,
                  state_id,
                  message,
                  oper_ref
                 )
        values (s_int_reckoning.nextval,
                l_reckoning_id,
                p_deal_id,
                p_account_id,
                p_interest_kind,
                p_date_from,
                p_date_through,
                p_account_rest,
                p_interest_rate,
                p_interest_amount,
                p_interest_tail,
                case when p_purpose is null then
                          '�����.%% �� ���.' || account_utl.get_account_number(p_account_id) || ' � ' || to_char(p_date_from, 'dd.mm.yy') || ' �� ' || to_char(p_date_through, 'dd.mm.yy') || ' ���.'
                     else p_purpose
                end,
                case when p_row_state_id is null then
                          case when p_interest_amount <> 0 then interest_utl.RECKONING_STATE_RECKONED
                               else interest_utl.RECKONING_STATE_ONLY_INFO
                          end
                     else p_row_state_id
                end,
                p_row_comment,
                null);
    end;

    function lock_reckoning_row(
        p_id in integer,
        p_skip_locked in boolean default true)
    return int_reckoning%rowtype
    is
        l_int_reckoning_row int_reckoning%rowtype;
    begin
        -- ������� ������ � ����� �������� �������� ��� ��, �� ����-��� ���� ���� �������� ������ ���� �� ����� ������ ������
        -- � ���� �� ���������� � ��� ������ - ���� � ����� ������ ������ � ������������ ���������� ������ ���������� ������ ��
        -- �������������� ���������� ����������, ���������� � ������ ���
        if (p_skip_locked) then
            select *
            into   l_int_reckoning_row
            from   int_reckoning t
            where  t.reckoning_id = sys_context('bars_pul', 'reckoning_id') and
                   t.id = p_id
            for update skip locked;
        else
            select *
            into   l_int_reckoning_row
            from   int_reckoning t
            where  t.reckoning_id = sys_context('bars_pul', 'reckoning_id') and
                   t.id = p_id
            for update;
        end if;

        return l_int_reckoning_row;
    exception
        when no_data_found then
             if (p_skip_locked) then
                 return null;
             else
                 raise_application_error(-20000, '��� ���������� ������� � ��������������� {' || p_id || '} �� �������');
             end if;
    end;

    procedure edit_reckoning_row(
        p_id in integer,
        p_interest_amount in number,
        p_purpose in varchar2)
    is
        l_int_reckoning_row int_reckoning%rowtype;
        l_account_row accounts%rowtype;
        l_interest_amount number;
        l_interest_tail number;
        l_state_id integer;
        l_message varchar2(4000 byte);
    begin
        l_int_reckoning_row := lock_reckoning_row(p_id, p_skip_locked => false);

        if (l_int_reckoning_row.state_id = interest_utl.RECKONING_STATE_ACCRUED) then
            l_account_row := account_utl.read_account(l_int_reckoning_row.account_id);

            raise_application_error(-20000, '�������� �� ���� ����������� ������� ' ||
                                            to_char(currency_utl.from_fractional_units(l_int_reckoning_row.interest_amount, l_account_row.kv), 'FM999999999999999999990.00') || ' ' ||
                                            currency_utl.get_currency_lcv(l_account_row.kv) ||
                                            ' ��� �������� - ����������� ����������');
        end if;
        -- ���� ���� ������� ������������ ������ - �������� ��� ��������� ������ ������� ������ �������, ��������� � ��������� ��������� ����������
        -- �������, �� ���������� ������ �������� �� �������� ����. � ���������� �� �������� �����, �������� �� ������� ����� ������� �� ������
        -- ������� (������� �� ����� ������� ������)
        if (not tools.equals(p_interest_amount, l_int_reckoning_row.interest_amount)) then
            l_interest_tail := 0;

            -- "����������" ���������� ���� ����������� ������� � ���������� ���� � ������� ���������� ������������ ������
            for i in (select t.id,
                             t.date_from,
                             t.date_to,
                             t.interest_amount +
                                  t.interest_tail -
                                  lead(t.interest_tail, 1, 0)
                                  over (partition by t.account_id, t.interest_kind order by t.date_from desc) original_interest_amount,
                             t.state_id,
                             t.message
                      from   int_reckoning t
                      where  t.reckoning_id = sys_context('bars_pul', 'reckoning_id') and
                             t.account_id = l_int_reckoning_row.account_id and
                             t.interest_kind = l_int_reckoning_row.interest_kind and
                             t.date_from >= l_int_reckoning_row.date_from
                      order by t.date_from
                      for update) loop

                -- ����������� ������� ������ ���������� ���� ���� ���� �� ����������� ������������ ������ ��� ��� �������� ����
                if (i.state_id in (interest_utl.RECKONING_STATE_MODIFIED, interest_utl.RECKONING_STATE_ACCRUED)) then
                    exit;
                end if;

                if (i.date_from > l_int_reckoning_row.date_from) then
                    l_interest_amount := i.original_interest_amount + l_interest_tail;
                    l_interest_tail := l_interest_amount - round(l_interest_amount);

                    if (round(l_interest_amount) = 0) then
                        l_state_id := interest_utl.RECKONING_STATE_ONLY_INFO;
                        l_message := '���� �������, ����������� �� ����� � ' || to_char(i.date_from, 'dd.mm.yyyy') || ' �� ' || to_char(i.date_to, 'dd.mm.yyyy') || ' ������� ����';
                    else
                        if (i.state_id = interest_utl.RECKONING_STATE_ONLY_INFO) then
                            l_state_id := interest_utl.RECKONING_STATE_RECKONED;
                            l_message := '';
                        else
                            l_state_id := i.state_id;
                            l_message := i.message;
                        end if;
                    end if;

                    update int_reckoning t
                    set    t.interest_amount = round(l_interest_amount),
                           t.interest_tail = l_interest_tail,
                           t.state_id = l_state_id,
                           t.message = l_message
                    where  t.id = i.id;
                end if;
            end loop;
        end if;

        if (round(p_interest_amount) = 0) then
            l_message := '���� �������, ����������� �� ����� � ' || to_char(l_int_reckoning_row.date_from, 'dd.mm.yyyy') || ' �� ' || to_char(l_int_reckoning_row.date_to, 'dd.mm.yyyy') || ' ������� ����';
        else
            if (l_int_reckoning_row.state_id = interest_utl.RECKONING_STATE_ONLY_INFO) then
                l_message := '';
            else
                l_message := l_int_reckoning_row.message;
            end if;
        end if;

        update int_reckoning t
        set    t.interest_amount = p_interest_amount,
               t.purpose = p_purpose,
               t.interest_tail = 0,
               t.state_id = interest_utl.RECKONING_STATE_MODIFIED,
               t.message = l_message
        where  t.id = p_id and
               t.reckoning_id = sys_context('bars_pul', 'reckoning_id');
    end;

    -- ������������ �� ���, �� ����������� � ������� acr_intn, ������ ����� � int_reckoning (��� ����������� �����������).
    -- ����� �������� ���� ���������, ������� acr_intn ��������� ��������� �� ��������� ��������� ���������� �������.
    -- �� ����� �� prepare_interest_utl, �� ������� ���������� ��������� ���������� ������� acrn.p_int(), � ����� �������
    -- ������ � acr_intn ������ ���� �������� ����� ���������� � ����� ������� ����������� (���������, ������)
    procedure take_reckoning_data(
        p_base_year in integer,
        p_purpose in varchar2 default null,
        p_deal_id in integer default null)
    is
    begin
        for i in (select * from acr_intn) loop
            create_reckoning_row(i.acc,
                                 i.id,
                                 i.fdat,
                                 i.tdat,
                                 i.osts / acrn.dlta(p_base_year, i.fdat, i.tdat + 1),
                                 i.ir,
                                 abs(round(i.acrd)),
                                 i.remi,
                                 p_purpose,
                                 p_deal_id);
        end loop;
    end;

    -- Returns Base Rate AND SUM(amount * rate)
    procedure p_bns(
        rat_    out number,                -- rate
        amnt_   out number,                -- SUM (amount * rate)
        dat_    in  date,                  -- efective date
        nb_     in  smallint,              -- base rate code
        kv_     in  smallint,              -- currency code
        ostf_   in  number,                -- account balance
        op_     in  smallint default null, -- rate amend op code
        amnd_   in  number   default null, -- rate amend value
        kf_     in  varchar  default null) --
    is
        br_    number;
        ostp_  number;
        osts_  number;
        tmps_  number;

        rato_  number;
        ratb_  number;
        rats_  number;

        kvs_   smallint;

        type_  int;
        form_  varchar2(25);
        l_kf   varchar2(6);
    begin

      br_  := 0;
      ostp_:= 0;
      osts_:= ostf_;

      if ( kf_ is null )
      then l_kf := sys_context('bars_context','user_mfo');
      else l_kf := kf_;
      end if;

      if ( l_kf is null )
      then
        raise_application_error( -20666, '�� ������� ��� ��� ���������� �������� ������ ������!' );
      end if;

      select br_type ,formula
        into type_, form_
        from brates
       where br_id=nb_;

      if type_ in (1,4)
      then
        declare
          c_cursor int;
          dyn_sql_ varchar2(250);
        begin
          if type_ = 4 and form_ is not null
          then -- 4 - �� ������� ������� (���� ���� �������� ������)

            c_cursor:=dbms_sql.open_cursor;
            --����������� ���.sql � ��������������� ����������� ���� � ���
            dyn_sql_:=
            'select '||form_||'(to_date('''||to_char(dat_)||'''),'||acc_form||','||to_char(nb_)||') from dual';
            dbms_sql.parse(c_cursor, dyn_sql_, dbms_sql.native);
            --���������� ���� ������� � select
            dbms_sql.define_column(c_cursor, 1, br_ );
            --��������� �������������� sql
            tools.hide_hint(dbms_sql.execute(c_cursor));
            --���������
            if dbms_sql.fetch_rows(c_cursor)>0 then
               --����� �������������� ����������
               dbms_sql.column_value(c_cursor,1, br_ );
            end if;

          else -- 1 - ������� ���������� ������

            -- ���� ����� �������� ��� % ������, ����������� �� ������ ����
            select rate
              into br_
              from br_normal_edit
             where (  br_id, kv, bdate ) in ( select br_id, kv, max(bdate)
                                                   from br_normal_edit
                                                  where  br_id = nb_
                                                    and kv    = kv_
                                                    and bdate <=dat_
                                                  group by  br_id, kv );

           end if;

           if    op_ = 1 then  br_ := br_ + amnd_;
           elsif op_ = 2 then  br_ := br_ - amnd_;
           elsif op_ = 3 then  br_ := br_ * amnd_;
           elsif op_ = 4 then  br_ := br_ / amnd_;
           end if;

         exception
           when others then br_ := 0;
         end;
         -- 2-����., 3-����.,����������������, 7-����., � �������� ������
      elsif type_ in (2,3,7)
      then

        tmps_ := 0;
        for tie in ( select rate
                          , case
                            when t.s = 0 and type_=7
                            then get_dptamount(g_acc)
                            else t.s
                            end as s
                       from br_tier_edit t
                      where ( br_id, kv, bdate ) in ( select  br_id, kv, max(bdate)
                                                            from br_tier_edit
                                                           where br_id = nb_
                                                             and kv    = kv_
                                                             and bdate <=dat_
                                                           group by  br_id, kv )
                      order by s )
        loop
          br_ := tie.rate;
          if    op_ = 1 then  br_ := br_ + amnd_;
          elsif op_ = 2 then  br_ := br_ - amnd_;
          elsif op_ = 3 then  br_ := br_ * amnd_;
          elsif op_ = 4 then  br_ := br_ / amnd_;
          end if;
          exit when tie.s >= ostf_;
          if type_ in (3,7)
          then
            ostp_ := ostp_ + br_ * (tie.s - tmps_);
            osts_ := osts_ - tie.s + tmps_;
            tmps_   := tie.s;
          end if;
         end loop;

      -- 5-����������� � ������ ������, 6-�����������, ����������������
      elsif type_ in (5,6)
      then

        begin
          select unique kv
            into kvs_
            from br_tier
           where br_id=nb_;
        exception
           when no_data_found then kvs_:=kv_;
           when too_many_rows then kvs_:=kv_;
        end;

        tmps_ := 0;

        for tie in ( select t.rate
                          , t.s
                       from br_tier t
                      where t.br_id=nb_
                        and t.kv=kvs_
                        and t.bdate=(select max(bdate) from br_tier
                                      where bdate<=dat_ and br_id=nb_ and kv=kvs_)
                      order by s)
        loop
          br_ := tie.rate;
          if    op_ = 1 then  br_ := br_ + amnd_;
          elsif op_ = 2 then  br_ := br_ - amnd_;
          elsif op_ = 3 then  br_ := br_ * amnd_;
          elsif op_ = 4 then  br_ := br_ / amnd_;
          end if;

          gl.x_rat( rato_,ratb_,rats_,kvs_,kv_,dat_ );

          if tie.s * rato_ >= ostf_ then exit; end if;

          if type_=6
          then
            ostp_ := ostp_ + br_ * (tie.s * rato_ - tmps_);
            osts_ := osts_ - tie.s * rato_ + tmps_;
            tmps_   := tie.s * rato_;
          end if;
        end loop;

      end if;

      rat_  := br_;
      amnt_ := osts_ * br_ + ostp_;

    end;

    -- calculates interest for given amount at given account
    procedure p_int(
        acc_  integer, -- account number
        id_   smallint,-- calc code
        dt1_  date,    -- from date
        dt2_  date,    -- to   date
        int_  out number, -- interest accrued
        ost_  decimal default null,
        mode_ smallint default 0) -- mode   play(0)/real(1), play(2)
                                      /*
                                      mode_ = 0  �������������
                                      mode_ = 1  �������� ����������
                                      mode_ = 2  ������������� ��� ��-��
                                      */
    is
        dtmp_  date;
        dat0_  date;
        dat1_  date;
        dat2_  date;
        b_yea  number;
        ostf_  number;
        ir0_   number;
        nb0_   number;
        sdat_  date;
        bdat_  date;
        tdat_  date;
        ir_    number;
        br_    number;
        osts_  number;
        ostp_  number;
        osta_  number;

        acrd_  number;
        acr_   number;

        dlta_  number;
        kv_    smallint;
        op_    smallint;
        remi_  number      default 0;
        arow   urowid      default null;
        kol_   int; -- ���-�� ��
        acc_alt_pk_ int := case when mode_ <= 1 then acc_ else mode_ end;

          -- ����� % �������� - ������� �� �����
          cursor c_acc
          is
          select i.acc, i.basey, i.basem, nvl(i.io, 0) io, i.acr_dat + 1 dat,
                 a.kf, a.kv, decode(i.metr, 96, 0, i.metr) metr, a.pap, i.s, i.stp_dat
            from int_accn i
               , accounts a
           where a.acc = i.acc
             and i.acc = acc_alt_pk_
             and i.id  = id_
             and i.metr in (0, 1, 2, 3, 4, 5, 96);

                --����� % ������ ��������������  - ������� �� �����
         cursor c_rati is
                     select bdat, nvl(ir,0) ir, op, nvl(br,0) br
                       from int_ratn i
                      where acc = acc_alt_pk_ and id=id_ and
                      ( i.bdat<= dat2_ and i.bdat>dat1_ or
                        i.bdat = (select max(bdat)
                                  from int_ratn
                                  where bdat<=dat1_ and acc=acc_alt_pk_ and id=id_ )
                       )
                      order by i.bdat;

                --����� % ������ �������  - ������� �� �����
         cursor c_ratb is
                     select br, bdat
                       from int_ratn i
                      where acc = acc_alt_pk_ and id=id_ and
                      ( i.bdat<= dat2_ and i.bdat>dat1_ or
                        i.bdat = (select max(bdat)
                                  from int_ratn
                                  where bdat<=dat1_ and acc=acc_alt_pk_ and id=i.id)
                       )
                      group by bdat, br;

                --����� �������� ������ �������  - �� ������� �� �����
         cursor c_bno(bri_ number,kv_ number, start_dat_ date, end_dat_ date) is
                     select bdate
                       from br_normal b
                      where br_id=bri_ and kv=kv_ and
                           (b.bdate <= end_dat_ and b.bdate > start_dat_ or
                            b.bdate=
                            (select max(bdate)
                             from  br_normal
                             where bdate<=start_dat_ and br_id=bri_ and kv=kv_))
                   group by bdate;

                --����� �������� ������ �������  - �� ������� �� �����
         cursor c_bti(bri_ number,kv_ number, start_dat_ date, end_dat_ date) is
                     select bdate
                       from br_tier b
                      where br_id=bri_ and kv=kv_ and
                           (b.bdate <= end_dat_ and b.bdate > start_dat_ or
                            b.bdate=
                            (select max(bdate)
                             from  br_tier
                             where bdate<=start_dat_ and br_id=bri_ and kv=kv_))
                     group by bdate;

                --����� �������� - ������� �� �����
         cursor c_salo is
                     select fdat,ostf-dos+kos ostf
                       from saldoa
                      where acc=acc_ and (fdat<=dat2_ and fdat>dat1_ or
                            fdat=(select max(fdat)
                            from saldoa where fdat<=dat1_ and acc=acc_));

                --����� �������� - ������� �� �����
         cursor c_sali is
                    select fdat,ostf,sum(dos) dos from (
                     select fdat,ostf,dos
                       from saldoa
                      where acc=acc_ and fdat<=dat2_ and fdat>=dat1_
                      union all
                     select dat1_ fdat, ostf-dos+kos ostf,0 dos
                       from saldoa
                      where acc=acc_ and
                            fdat=(select max(fdat)
                            from saldoa where fdat<dat1_ and acc=acc_)
                      union all
                     select fdat+1 fdat,ostf-dos+kos ostf,0 dos
                       from saldoa
                      where acc=acc_ and fdat<dat2_ and fdat>=dat1_ )
                      group by fdat,ostf;
                --����� �������� - ������� �� �����
         cursor c_salh2 is
                     select fdat,ostf-dos+kos ostf
                       from saldoho
                      where fdat<=dat2_ and fdat>dat1_ or
                            fdat=(select max(fdat)
                            from saldoa where fdat<=dat1_ and acc=acc_);

                --����� �������� - ������� �� ����� (��-��!)
         cursor c_salh3 is
                    select fdat,ostf,sum(dos) dos from (
                     select fdat,ostf,dos
                       from saldoho
                      where fdat<=dat2_ and fdat>=dat1_
                      union all
                     select dat1_ fdat, ostf-dos+kos ostf,0 dos
                       from saldoho
                      where fdat=
                    (select max(fdat) from saldoho where fdat<dat1_ )
                      union all
                     select fdat+1 fdat,ostf-dos+kos ostf,0 dos
                       from saldoho
                      where fdat<dat2_ and fdat>=dat1_ )
                      group by fdat,ostf;
                -- ��� ������ �����������
         cursor c_amo is
                     select a.mdate, (s.ostf - s.dos + s.kos) + a.ostf ostf
                       from accounts a,
                            saldoa   s
                      where a.acc    = acc_
                        and a.acc    = s.acc
                        and s.fdat   = (select max(fdat)
                                          from saldoa
                                         where acc   = acc_
                                           and fdat <= dat2_ );

        prev_rat    c_ratb%rowtype;
        rat         c_ratb%rowtype;
        dat_end     date;

        type xxx is record (
               dat  date,
               ostf number,
               ir   number,
               op   number,
               br   number,
               brn  number );

        key varchar2(9);
        type x is table of xxx index by varchar2(9);
        tmp x;
    begin
        dat1_   := trunc(dt1_);
        acr_    := 0;
        g_acc   := acc_;

        if (mode_ = 1) then
            delete from acr_intn where acc = acc_ and id = id_;
        end if;

        while (dat1_ <= trunc(dt2_)) loop
            if trunc(dat1_, 'YEAR') <> trunc(dt2_,'YEAR') then
                dat2_ := to_date('3112' || to_char(dat1_, 'YYYY'), 'DDMMYYYY');
            else
                dat2_ := trunc(dt2_);
            end if;

            for acc in c_acc loop

                if (mode_ = 2) then  -- 06.08.2012  ��� �������� ������ ��� ��-��
                    acc.io := 0;
                end if;

                if (acr_ = 0 and mode_ = 1) then
                    remi_ := acc.s;
                end if; -- previous unpaid reminder

                if (acc.basey = 0 or (acc.basey = 4 and acrn.cur_basey is null)) then  -- ����/���� ������� % ������
                    b_yea := to_date('3112' || to_char(dat1_, 'YYYY'), 'DDMMYYYY') - trunc(dat1_, 'YEAR') + 1;
                elsif acc.basey = 1 then
                    b_yea := 365;
                elsif acc.basey in (2, 12) then
                    b_yea := 360;
                elsif acc.basey = 3 then
                    b_yea := 360;
                elsif acc.basey = 4 then
                    b_yea := acrn.cur_basey;
                elsif acc.basey = 5 then -- ����/���� �������� % ������
                    dtmp_:= to_date('01' || to_char(dat1_ - 1, 'MMYYYY'), 'DDMMYYYY');
                    b_yea := add_months(dtmp_, 1) - dtmp_;
                elsif acc.basey in (6, 16) then          -- 30/30 �������� % ������
                    b_yea := 30;
                    if to_char(dat1_, 'YYYYMM') <> to_char(dt2_, 'YYYYMM') then
                        dat2_:= last_day(dat1_);  -- ������ ����� �� �������� ���. (��� �������� � ���. % ������)
                    end if;
                elsif acc.basey = 7 then
                    b_yea := 364;
                else
                    goto end_acc;
                end if;

                -- ����������� �� ���� ���������� ��������� �� ��������� ����� ("������ ���������")
                if (acc.metr = 3) then
                    declare
                        l_datend date;
                        l_datacr date;
                    begin
                        select acr_dat into l_datacr from int_accn where acrb = acc_ and id = 1;

                        l_datend := least (dat2_, l_datacr);
                        for sal in c_amo loop
                            acrd_ := 0;
                            if (id_ = 0 and sal.ostf < 0 and l_datacr >= dat1_) then
                                osts_ := sal.ostf - acr_;
                                dlta_ := l_datend - dat1_ + 1;
                                acrd_ := osts_ * dlta_ / (l_datacr - dat1_ + 1);
                                if acrd_ <> 0 then
                                   if mode_ = 1 then
                                      insert into acr_intn (acc,  id,  fdat,  tdat,     ir, br, osts,  acrd)
                                      values               (acc_, id_, dat1_, l_datend, 0,  0,  osts_, acrd_);
                                   end if;
                                   acr_ := acr_ + acrd_;
                                end if;
                            end if;
                        end loop;
                        goto end_acc;
                    exception
                      when no_data_found then null;
                    end;
                elsif acc.metr = 4 then
                    -- ����������� ������� ������
                    for sal in c_amo loop

                         if acc.io = 0 then
                             kol_ := 0;
                         else
                             kol_ := 1;
                         end if;

                         dat2_ := least (dat2_, sal.mdate - kol_);

                         acrd_ := 0;

                         if (id_ in (0, 2) and sal.ostf < 0) or
                            (id_ in (1, 3) and sal.ostf > 0) then

                            osts_ := sal.ostf - acr_;
                            dlta_ := dat2_ - dat1_ + 1;
                            acrd_ := osts_ * dlta_/  ((sal.mdate - kol_) - dat1_ + 1);
                            if id_ in (0, 2) then acrd_ := least(acrd_,    0); end if;
                            if id_ in (1, 3) then acrd_ := greatest(acrd_, 0); end if;
                        end if;

                        if acrd_ != 0 then
                           if mode_ = 1 then
                              insert into acr_intn (acc, id, fdat, tdat, ir, br, osts, acrd, remi)
                              values (acc_, id_, dat1_, dat2_, 0, 0, osts_, acrd_, remi_);
                           end if;
                           acr_ := acr_ + acrd_;
                        end if;
                        if sal.ostf - acr_ = 0 then dat2_ := trunc(dt2_); end if;
                    end loop;

                    goto end_acc;

                elsif acc.metr = 5 then
                    -- ������������ ������ � �����������
                    --����������� �� ������ ��.% ������
                    -- ���������� 2 ����.�������� �� ���.����� ��������
                    -- id=0 - ����������� ����� ������: acc 3114, acra 3118
                    -- id=2 - ��.�����  ��� �����������:���� acc 3114, acra 3116
                    --                            ��� ������ acc 3114, acra 3117
                    -- ��.������ ������������ ��� ������� ����.,
                    -- �.� = ��� ��.������/36500
                    --��������� � ���������� ����� �������� � �����������

                    declare
                        n_    number; -- ������� �������
                        ir_   number; -- ��� % ������ �������
                        accdp_ int  ; -- acc ��������/������
                        dp_   number; -- ������� �������/������
                        erat_ number; -- ��.% ������ - �������
                        kup1_ number;
                        dp1_  number; -- �������/������ 1-�� ���
                        mdate_ date ; -- ���� ��������� ��
                        daos_  date ; -- ���� ��������  ��

                        dat_n_ date ; -- ���� ����������� ��������� ��������
                        dat_i_ date ; -- ���� ��������� ��������� ��� % ������
                        dat_e_ date ; -- ���� ��������� ��������� ��. % ������

                    begin
                        --����� �������� + ����������� % ������ + acc ����� ��������/������
                        select sn.fdat, sn.ostf-sn.dos+sn.kos,
                               a.mdate, a.daos, i.acra, r.ir, r.bdat
                        into   dat_n_, n_,
                               mdate_, daos_, accdp_, ir_, dat_i_
                        from   saldoa sn, accounts a , int_ratn r, int_accn i
                        where  a.acc = acc_ and
                               sn.acc = a.acc and
                               (sn.acc,sn.fdat) = (select acc, max(fdat) from saldoa
                                                   where acc = sn.acc and fdat<=dat2_
                                                   group by acc) and
                               r.acc = a.acc and r.id = i.id - 2 and
                               (r.acc,r.id,r.bdat) = (select acc,id,max(bdat) from int_ratn
                                                      where acc = r.acc and id = r.id and bdat <= dat2_
                                                      group by acc, id) and
                               i.acc=a.acc and i.id=id_ and
                               i.acra is not null and i.acrb is not null;

                        -- ����� ��������/������
                        select s.ostf - s.dos + s.kos
                        into   dp_
                        from   saldoa s
                        where  s.acc = accdp_ and
                               s.ostf - s.dos + s.kos <> 0 and
                               (s.acc,fdat) = (select acc, max(fdat)
                                               from   saldoa
                                               where  acc = s.acc and fdat <= dat2_
                                               group by acc);
                        --���� ��� ��������������
                        if n_ = 0 or dat2_>= mdate_ or abs(dp_) <= 100 then
                            --���������� ������������
                            dp1_ := dp_;
                        else
                            -- ��.% ������
                            begin
                              select r.ir, r.bdat
                              into erat_, dat_e_
                              from int_ratn r
                              where r.acc=acc_ and r.id=id_ and
                                    (r.acc,r.id,r.bdat) = (select acc,id,max(bdat) from int_ratn
                                                           where acc=r.acc and id=r.id and bdat<=dat1_ group by acc,id);
                            exception when no_data_found then dat_e_ := null;
                            end;

                            if    dat_e_  is null
                               or dat_e_ < dat_i_
                               or dat_e_ < dat_n_ then
                                -- ������ ������������� ��� ����������
                                -- ������ - � �������:
                                -- 1) ��������� �������� ����
                                -- 2) �������. ��� % ������� ����

                                kup1_ := n_* ir_/36500;
                                dp1_  := dp_ / (mdate_ - dat_n_ );
                                erat_ := (kup1_-dp1_) / (( n_+dp_ + n_)/2) ;
                                insert into int_ratn (acc,id,bdat,ir) values (acc_,id_,dat2_,erat_);
                            end if;

                            if dat2_ >= dat_n_  then
                                dlta_ := dat2_- greatest(dat_n_,dat1_) + 1 ;
                                dp1_  := round( ((n_+dp_)*erat_ - n_*ir_/36500 ) * dlta_, 0);
                            else
                                dp1_  := 0;
                            end if;
                        end if;

                        if dp1_ <> 0 then
                           if mode_ = 1 then
                              insert into acr_intn (acc, id, fdat, tdat,ir,br,osts,acrd)
                                           values (acc_,id_, greatest(dat_n_,dat1_),dat2_,0,0,dp_,dp1_ );
                           end if;
                           acr_ := acr_ + dp1_;
                        end if;

                    exception
                        when no_data_found then goto end_acc;
                    end;
                    goto end_acc;
                end if;

                -- collect balance history

                if ost_ is null then
                   if acc.io = 1 then
                      for sal in c_sali loop
                          if sal.fdat <  dat1_ then
                              sal.fdat := dat1_;
                          end if;

                          tmp(to_char(sal.fdat, 'yyyymmdd') || '0').dat := sal.fdat;
                          tmp(to_char(sal.fdat, 'yyyymmdd') || '0').ostf := sal.ostf - sal.dos;

                      end loop;

                   elsif acc.io in (2,3) then

                      delete from saldoho;

                      dat0_ := dat1_-10; -- �������� � ������� 10 �������� ������

                      insert into saldoho (fdat,ostf,dos,kos)
                      select fdat, acrn.ho_ost(acc_,fdat,-dos+kos,rownum),dos,kos
                        from (
                      select fdat,sum(dos) dos,sum(kos) kos
                        from (
                      select fdat, dos, kos
                        from saldoa
                       where acc=acc_ and
                             fdat=(select max(fdat)
                             from saldoa where acc=acc_ and fdat < dat0_ and acc=acc_)
                       union all
                      select fdat, dos, kos
                        from saldoa
                       where acc = acc_ and fdat between dat0_ and dat2_
                       union all
                      select cdat, nvl(dos,0), nvl(kos,0)
                        from v_saldo_holiday v
                       where acc = acc_ and cdat between dat0_ and dat2_
                       union all
                      select (select min(fdat) from saldoa
                               where acc=acc_ and fdat > v.cdat),  nvl(-v.dos,0), nvl(-v.kos,0)
                        from v_saldo_holiday v
                       where acc = acc_ and cdat between dat0_ and dat2_
                             )
                       group by fdat order by fdat );

                      if acc.io = 2 then
                         for sal in c_salh2 loop
                             if sal.fdat <  dat1_ then
                                sal.fdat := dat1_;
                             end if;

                             tmp(to_char(sal.fdat,'yyyymmdd')||'0').dat :=sal.fdat;
                             tmp(to_char(sal.fdat,'yyyymmdd')||'0').ostf:=sal.ostf;

                         end loop;
                      else -- acc.io = 3
                         for sal in c_salh3 loop
                             if sal.fdat <  dat1_ then
                                sal.fdat := dat1_;
                             end if;

                             tmp(to_char(sal.fdat,'yyyymmdd')||'0').dat :=sal.fdat;
                             tmp(to_char(sal.fdat,'yyyymmdd')||'0').ostf:=sal.ostf-sal.dos;

                         end loop;
                      end if;
                   else
                      for sal in c_salo loop
                          if sal.fdat <  dat1_ then
                             sal.fdat := dat1_;
                          end if;

                          tmp(to_char(sal.fdat,'yyyymmdd')||'0').dat :=sal.fdat;
                          tmp(to_char(sal.fdat,'yyyymmdd')||'0').ostf:=sal.ostf;

                      end loop;
                   end if;
                else

                   tmp(to_char(dat1_,'yyyymmdd')||'0').dat :=dat1_;
                   tmp(to_char(dat1_,'yyyymmdd')||'0').ostf:=ost_;

                end if;

                -- collect individual rate history
                for rat in c_rati loop

                    if rat.bdat <  dat1_ then
                       rat.bdat := dat1_;
                    end if;

                    tmp(to_char(rat.bdat,'yyyymmdd')||'3').dat :=rat.bdat;
                    tmp(to_char(rat.bdat,'yyyymmdd')||'3').ir  :=rat.ir;
                    tmp(to_char(rat.bdat,'yyyymmdd')||'3').op  :=rat.op;
                    tmp(to_char(rat.bdat,'yyyymmdd')||'3').brn :=rat.br;

                end loop;

                -- collect base rate history
                prev_rat.br   := null;
                prev_rat.bdat := null;
                rat.br        := null;
                rat.bdat      := null;

                open c_ratb;   --������� % ������ �� ������
                loop
                    fetch c_ratb into rat;

                    if (deb.debug) then
                        dbms_output.put_line('c_rati loop: ' || prev_rat.br || ' ' || acc.kv || ' ' || prev_rat.bdat || ' ' || dat_end);
                    end if;
                    if prev_rat.br is not null then  --�������� �� ������ ������

                       if c_ratb%notfound then
                          dat_end := dat2_;     --������� ����� ��������� ���. ������ - ����� ������� ����������
                       else
                          dat_end := rat.bdat;  --������� ����� ��������� ���. ������ - ������ �������� ����. ������
                       end if;

                       for bas in c_bno(prev_rat.br,acc.kv, prev_rat.bdat, dat_end) loop --������� ���������� ��������� ������

                           if bas.bdate <  prev_rat.bdat then      --���� �������� ������ ����������� ������
                              bas.bdate := prev_rat.bdat;          --������� �������� �������� �� ���. �� �����
                           end if;

                           tmp(to_char(bas.bdate,'yyyymmdd')||'2').dat :=bas.bdate;
                           tmp(to_char(bas.bdate,'yyyymmdd')||'2').brn:=prev_rat.br;

                       end loop;

                       for tie in c_bti(prev_rat.br,acc.kv, prev_rat.bdat, dat_end) loop  --������� ����������� ��������� ������

                           if (deb.debug) then
                               dbms_output.put_line('c_bti loop: ' || tie.bdate || ' ' || prev_rat.br);
                           end if;

                           if tie.bdate <  prev_rat.bdat then
                              tie.bdate := prev_rat.bdat;
                           end if;

                           tmp(to_char(tie.bdate,'yyyymmdd')||'1').dat :=tie.bdate;
                           tmp(to_char(tie.bdate,'yyyymmdd')||'1').brn:=prev_rat.br;

                       end loop;
                    end if;
                    prev_rat:=rat;

                    exit when c_ratb%notfound;
                end loop;

                close c_ratb;

                tmp(to_char(dat2_ + 1,'yyyymmdd') || '4').dat := dat2_ + 1;

                -- end of collection

                ostf_ := null;
                bdat_ := null;
                ir0_  := 0;
                op_   := null;
                nb0_  := null;

                osta_ := 0;
                sdat_ := null;

                if (deb.debug) then
                    key := tmp.first;
                    while key is not null loop
                        if (key = tmp.first) then
                            dbms_output.put_line('Content of TMP collection:');
                            dbms_output.put_line('----------------------------------------------------------------------');
                            dbms_output.put_line('key       dat                   ostf   ir   op   br   brn');
                            dbms_output.put_line('----------------------------------------------------------------------');
                        end if;

                        dbms_output.put_line(lpad(key, 9) || ' ' ||
                                             lpad(nvl(to_char(tmp(key).dat, 'dd.mm.yyyy'), ' '), 10) || ' ' ||
                                             lpad(nvl(to_char(tmp(key).ostf), ' '), 15) || ' ' ||
                                             lpad(nvl(to_char(tmp(key).ir), ' '), 4) || ' ' ||
                                             lpad(nvl(to_char(tmp(key).op), ' '), 4) || ' ' ||
                                             lpad(nvl(to_char(tmp(key).br), ' '), 4) || ' ' ||
                                             lpad(nvl(to_char(tmp(key).brn), ' '), 15));
                        key := tmp.next(key);
                    end loop;

                    dbms_output.put_line('');
                end if;

                key := tmp.first;
                while key is not null loop

                    tmp(key).ostf := nvl(tmp(key).ostf, ostf_);
                    tmp(key).ir   := nvl(tmp(key).ir, ir0_);
                    tmp(key).op   := nvl(tmp(key).op, op_);
                    tmp(key).brn  := nvl(tmp(key).brn, nb0_);

                    if bdat_ <> tmp(key).dat and ostf_ is not null then
                       if acc.metr=2 then

                          sdat_ := nvl(sdat_, bdat_);

                          if tmp(key).ir = ir0_ and tmp(key).brn = nb0_ then

                             if (acc.pap = 1 and ostf_ <= tmp(key).ostf or
                                 acc.pap = 2 and ostf_ >= tmp(key).ostf) then

                                 ostf_ := tmp(key).ostf;
                             end if;

                             if substr(key,-1) <> '4' then
                                 goto int_333;
                             end if;

                          end if;

                       end if;

                       if (acc.metr = 1) then    -- �� ����������
                           if (deb.debug and sdat_ is null) then
                               dbms_output.put_line('key       sdat_         tmp(key).ostf  tmp(key).ir tmp(key).brn ir0_       nb0_ bdat_      tmp(key).dat dlta_          osta_           ostf_' );
                               dbms_output.put_line('----------------------------------------------------------------------------------------------------------------------------------------------');
                           end if;

                           sdat_ := nvl(sdat_, bdat_);
                           dlta_ := acrn.dlta(acc.basey, bdat_, tmp(key).dat);
                           osta_ := osta_ + ostf_ * dlta_;

                           if (deb.debug) then
                               dbms_output.put_line(key || ' ' ||
                                                    sdat_ || ' ' ||
                                                    lpad(tmp(key).ostf, 17) || ' ' ||
                                                    lpad(tmp(key).ir, 12)  || ' ' ||
                                                    lpad(tmp(key).brn, 12)  || ' ' ||
                                                    lpad(ir0_, 4) || ' ' ||
                                                    lpad(nb0_, 10) || ' ' ||
                                                    to_char(bdat_, 'dd.mm.yyyy') || ' ' ||
                                                    to_char(tmp(key).dat, 'dd.mm.yyyy') || ' ' ||
                                                    lpad(dlta_, 8) || ' ' ||
                                                    lpad(osta_, 15) || ' ' ||
                                                    lpad(ostf_, 15));
                           end if;

                           if tmp(key).ir <> ir0_ or tmp(key).brn <> nb0_ or substr(key, -1) in ('4', '2', '1') then
                               -- ���� ������ ���������� ��� ����� �� ��������� ������ ��������� - ����������� �������� �������� ������� ��� ������� �������
                               ostf_ := osta_ / acrn.dlta(acc.basey, sdat_, tmp(key).dat);
                               osta_ := 0;

                               if (deb.debug) then
                                   dbms_output.put_line('');
                               end if;
                           else
                               -- ���� ������ �� �������� � �� ��������� ������ � ���������, �� �������� ������� � ���������� osta_ � ������� �� ����� �����
                               if (substr(key, -1) <> '4') then
                                   goto int_222;
                               end if;
                           end if;

                       end if;

                       if (acc.metr = 0) then      -- ����������
                           sdat_ := bdat_;
                       end if;

                       tdat_ := tmp(key).dat - 1;
                       ostp_ := 0;

                       if mod(id_, 2) = 0 and ostf_ < 0 or
                          mod(id_, 2) = 1 and ostf_ > 0 then

                           ir_ := ir0_;

                           if (nb0_ > 0) then
                               acc_form := acc.acc;
                               p_bns(br_, ostp_, sdat_, nb0_, acc.kv, abs(ostf_), op_, ir_, acc.kf);

                               if (ostf_ < 0) then
                                   ostp_ := -ostp_;
                               end if;

                               ir_ := 0;
                           else
                               br_ := 0;
                           end if;
                       else
                           ir_ := 0;
                           br_ := 0;
                       end if;

                       dlta_ := acrn.dlta(acc.basey, sdat_, tmp(key).dat);

                       --------------- acrn.cur_nomin
                       if nvl(acrn.cur_nomin, 0) > 0 then
                           kol_  := abs(ostf_) / acrn.cur_nomin;
                           acrd_ := (ir_ * sign(ostf_) * acrn.cur_nomin + ostp_) * dlta_ / b_yea / 100;
                       else
                           kol_  := 1;
                           acrd_ := (ir_ * ostf_ + ostp_) * dlta_ / b_yea / 100;
                       end if;

                       if (deb.debug) then
                           dbms_output.put_line('interest amount: ' || acrd_);
                       end if;

                       osts_ := ostf_ * dlta_;

                       if (acrd_ <> 0 or acc.metr in (1, 2)) then
                           acrd_:= acrd_ + remi_; -- ����� %% +- ������ ������ � �������� ����
                           remi_:= acrd_ - round(acrd_);

                           if (mode_ = 1) then
                               if (kol_ > 1) then
                                   acrd_ := round(acrd_, 0) * kol_;
                               end if;

                               insert into acr_intn (acc, id, fdat, tdat, ir, br, osts, acrd, remi)
                               values (acc_, id_, sdat_, tdat_, ir_, br_, osts_, round(acrd_), remi_)
                               returning rowid into arow;
                           end if;

                           if (deb.debug) then
                               dbms_output.put_line('total interest amount (before): ' || acr_);
                           end if;

                           acr_ := acr_ + round(acrd_);
                           if (substr(key, -1) = '4') then
                               acr_ := acr_ + remi_;
                           end if;

                           if (deb.debug) then
                               dbms_output.put_line('total interest amount (after): ' || acr_);
                               dbms_output.put_line('');
                           end if;
                       end if;
                    end if;

                    if (acc.metr = 2) then
                        sdat_ := null;
                    end if;

                    if (acc.metr = 1) then
                        sdat_ := null;
                        osta_ := 0;
                    end if;

                    <<int_222>>
                    --��� ��������� �� ����������� � ����� �������� ����� ������, ���
                    --��� ���������� ������� ��� ���������� �����: ����� ���������� ���������
                    ostf_ := tmp(key).ostf;

                    <<int_333>>
                    bdat_ := tmp(key).dat;
                    ir0_  := tmp(key).ir;
                    op_   := tmp(key).op;
                    nb0_  := tmp(key).brn;

                    key := tmp.next(key);

                end loop;

                tmp.delete;

                <<end_acc>>
                null;
            end loop;

            dat1_ := dat2_ + 1;
        end loop;

        if (arow is not null and mode_ = 1) then
            update acr_intn set tdat=dt2_ where rowid=arow;
        end if;
        int_ := acr_;
    end;

    procedure prepare_interest_utl(
        p_reckoning_id in varchar2,
        p_account_id in integer,
        p_account_number in varchar2,
        p_account_rest in number,
        p_interest_kind in integer,
        p_interest_base in integer, --
        p_interest_method_id in integer,
        p_date_from in date,
        p_date_through in date,
        p_deal_id in integer)
    is
        l_interest_amount number;
        l_date_from date;
        l_date_through date;
        l_interest_rate number;
        l_interest_line_rate number;
        l_interest_line_amount number;
    begin
        savepoint before_accruement;

        acrn.p_int( p_account_id, p_interest_kind, p_date_from, p_date_through, l_interest_amount, null, 1);
        --------------------------------------------------------------------------------------------------------------
        -- 13.09.2016 ������ - ��� ���������� ��������� �� ���������� %% � ������� ��������, % ������, �������� ����
/*
        If l_interest_amount <> 0 then
           insert
         into int_reckoning
                ( id,
                  reckoning_id,
                  deal_id,
                  account_id,
                  interest_kind,
                  date_from,
                  date_to,
                  account_rest,
                  interest_rate,
                  interest_amount,
                  interest_tail,
                  purpose,
                  state_id,
                  message,
                  oper_ref
                 )
           select s_int_reckoning.nextval,
                  p_reckoning_id,
                  p_deal_id,
                  p_account_id,
                  p_interest_kind,
                  m.fdat,
                  m.tdat,
                  m.osts / acrn.dlta(p_interest_base, m.fdat, m.tdat + 1),
                  m.ir,
                  abs(round(m.acrd)),
                  m.remi,
                  case when p_interest_method_id = 4 then
                            '����������� ���. (�������.) ' || p_account_number || ' � ' || to_char(m.fdat, 'dd.mm.yy') || ' �� ' || to_char(m.tdat, 'dd.mm.yy') || ' ���.'
                       else '�����.%% �� ���.' || p_account_number || ' � ' || to_char(m.fdat, 'dd.mm.yy') || ' �� ' || to_char(m.tdat, 'dd.mm.yy') || ' ���.'
                  end,
                  interest_utl.INT_RECKONING_STATE_NEW,
                  '',
                  null

           from   acr_intn m
           where  m.acc = p_account_id and
                  m.id = p_interest_kind;
*//*
        If l_interest_amount <> 0 then
           insert
         into int_reckoning
                ( id,
                  reckoning_id,
                  deal_id,
                  account_id,
                  interest_kind,
                  date_from,
                  date_to,
                  account_rest,
                  interest_rate,
                  interest_amount,
                  interest_tail,
                  purpose,
                  state_id,
                  message,
                  oper_ref
                 )
           values (s_int_reckoning.nextval,
                  p_reckoning_id,
                  p_deal_id,
                  p_account_id,
                  p_interest_kind,
                  p_date_from,
                  p_date_through,
                  fost(p_account_id, gl.bd()), -- m.osts / acrn.dlta(p_interest_base, m.fdat, m.tdat + 1),
                  acrn.fproc(p_account_id),
                  abs(round(l_interest_amount)),
                  l_interest_amount - round(l_interest_amount),
                  case when p_interest_method_id = 4 then
                            '����������� ���. (�������.) ' || p_account_number || ' � ' || to_char(p_date_from, 'dd.mm.yy') || ' �� ' || to_char(p_date_through, 'dd.mm.yy') || ' ���.'
                       else '�����.%% �� ���.' || p_account_number || ' � ' || to_char(p_date_from, 'dd.mm.yy') || ' �� ' || to_char(p_date_through, 'dd.mm.yy') || ' ���. ������ % ' || to_char(acrn.fproc(p_account_id, gl.bd()), 'FM999999990.0099')
                  end,
                  interest_utl.INT_RECKONING_STATE_NEW,
                  '',
                  null);
*/      If l_interest_amount <> 0 then
            for i in (select m.fdat,
                             m.tdat,
                             m.acrd,
                             row_number() over (order by m.fdat) line_number,
                             count(*) over() total_lines_count
                      from   acr_intn m
                      where  m.acc = p_account_id and
                             m.id = p_interest_kind
                      order by m.fdat) loop

                l_interest_rate := acrn.fprocn(p_account_id, p_interest_kind, i.fdat);
                if (l_date_from is null) then
                    l_date_from := i.fdat;
                    l_date_through := i.tdat;
                    l_interest_line_rate := l_interest_rate;
                    l_interest_line_amount := i.acrd;
                else
                    if (l_interest_rate <> l_interest_line_rate) then
                        insert into int_reckoning
                        values ( s_int_reckoning.nextval,
                                 p_reckoning_id,
                                 p_deal_id,
                                 p_account_id,
                                 p_interest_kind,
                                 l_date_from,
                                 l_date_through,
                                 fost(p_account_id, l_date_from),
                                 l_interest_line_rate,
                                 abs(round(l_interest_line_amount)),
                                 l_interest_line_amount - round(l_interest_line_amount),
                                 case when p_interest_method_id = 4 then
                                           '����������� ���. (�������.) ' || p_account_number || ' � ' || to_char(l_date_from, 'dd.mm.yy') || ' �� ' || to_char(l_date_through, 'dd.mm.yy') || ' ���.'
                                      else '�����.%% �� ���.' || p_account_number || ' � ' || to_char(l_date_from, 'dd.mm.yy') || ' �� ' || to_char(l_date_through, 'dd.mm.yy') || ' ���. ������ % ' || to_char(l_interest_line_rate, 'FM999999990.0099')
                                 end,
                                 interest_utl.RECKONING_STATE_RECKONED,
                                 '',
                                 null
                                 );

                        l_date_from := i.fdat;
                        l_date_through := i.tdat;
                        l_interest_line_rate := l_interest_rate;
                        l_interest_line_amount := i.acrd;
                   else
                       l_date_through := i.tdat;
                       l_interest_line_amount := l_interest_line_amount + i.acrd;
                   end if;
                end if;
                if (i.line_number = i.total_lines_count) then
                    insert into int_reckoning
                    values ( s_int_reckoning.nextval,
                             p_reckoning_id,
                             p_deal_id,
                             p_account_id,
                             p_interest_kind,
                             l_date_from,
                             l_date_through,
                             fost(p_account_id, l_date_from),
                             l_interest_line_rate,
                             abs(round(l_interest_line_amount)),
                             l_interest_line_amount - round(l_interest_line_amount),
                             case when p_interest_method_id = 4 then
                                       '����������� ���. (�������.) ' || p_account_number || ' � ' || to_char(l_date_from, 'dd.mm.yy') || ' �� ' || to_char(l_date_through, 'dd.mm.yy') || ' ���.'
                                  else '�����.%% �� ���.' || p_account_number || ' � ' || to_char(l_date_from, 'dd.mm.yy') || ' �� ' || to_char(l_date_through, 'dd.mm.yy') || ' ���. ������ % ' || to_char(l_interest_line_rate, 'FM999999990.0099')
                             end,
                             interest_utl.RECKONING_STATE_RECKONED,
                             '',
                             null
                             );
                end if;

           end loop;
        else
            -- ����� ���� = 0, �� ���� �������� ������� acr_dat ���-����� ���� ����� ����������
            insert
         into int_reckoning
                ( id,
                  reckoning_id,
                  deal_id,
                  account_id,
                  interest_kind,
                  date_from,
                  date_to,
                  account_rest,
                  interest_rate,
                  interest_amount,
                  interest_tail,
                  purpose,
                  state_id,
                  message,
                  oper_ref
                 )
            values (s_int_reckoning.nextval,
                    p_reckoning_id,
                    p_deal_id,
                    p_account_id,
                    p_interest_kind,
                    p_date_from,
                    p_date_through,
                    p_account_rest,
                    acrn.fprocn(p_account_id, p_interest_kind, p_date_through),
                    0,
                    0,
                    '',
                    interest_utl.RECKONING_STATE_ONLY_INFO,
                    '���� �������, ����������� �� ����� � ' || to_char(p_date_from, 'dd.mm.yyyy') || ' �� ' || to_char(p_date_through, 'dd.mm.yyyy') || ' ������� ����',
                    null);
        end if;
    exception
        when others then
             rollback to before_accruement;
             bars_audit.error('interest_utl.prepare_interest_utl' || chr(10) ||
                              'reckoning_id    : ' || p_reckoning_id       || chr(10) ||
                              'account_id      : ' || p_account_id         || chr(10) ||
                              'account_number  : ' || p_account_number     || chr(10) ||
                              'account_rest    : ' || p_account_rest       || chr(10) ||
                              'interest_kind   : ' || p_interest_kind      || chr(10) ||
                              'interest_base   : ' || p_interest_base      || chr(10) ||
                              'interest_method : ' || p_interest_method_id || chr(10) ||
                              'date_from       : ' || p_date_from          || chr(10) ||
                              'date_through    : ' || p_date_through       || chr(10) ||
                               sqlerrm || chr(10) || dbms_utility.format_error_backtrace());
    end;

    function prepare_interest(
        p_accounts in number_list,
        p_date_through in date)
    return varchar2
    is
        l_reckoning_id varchar2(32 char) := sys_guid();
    begin
        if (p_date_through is null) then
            raise_application_error(-20000, '����, �� ��� ������������� ������� �� �������');
        end if;

        if (p_accounts is null or p_accounts is empty) then
            return l_reckoning_id;
        end if;

        for i in (select a.acc, a.nls, a.nbs, a.rnk, a.ostc, i.acr_dat, i.id, i.basey, i.stp_dat, i.metr
                  from accounts a
                  join int_accn i on i.acc = a.acc and
                                     i.id = a.pap - 1 and
                                     i.acr_dat < p_date_through
                  where a.acc in (select column_value from table(p_accounts)) and
                        a.nbs is not null and -- �� ���������� ������� �� �������� ��������
                        a.dazs is null) loop

            prepare_interest_utl(l_reckoning_id,
                                 i.acc,
                                 i.nls,
                                 i.ostc,
                                 i.id,
                                 i.basey,
                                 i.metr,
                                 i.acr_dat + 1,
                                 case when i.stp_dat is null then p_date_through
                                      else least(p_date_through, i.stp_dat)
                                 end,
                                 null);
        end loop;

        pul.set_mas_ini('RECKONING_ID', l_reckoning_id, '');

        return l_reckoning_id;
    end;

    function prepare_deal_interest(
        p_deals in number_list,
        p_date_through in date)
    return varchar2
    is
        l_reckoning_id varchar2(32 char) := sys_guid();
    begin
        if (p_date_through is null) then
            raise_application_error(-20000, '����, �� ��� ������������� ������� �� �������');
        end if;

        if (p_deals is null or p_deals is empty) then
            return l_reckoning_id;
        end if;

        for i in (select d.nd, d.vidd, a.kv, d.rnk, a.nbs, a.acc, a.nls, i.acr_dat, i.id, a.ostc, i.tt, i.basey, i.stp_dat, i.metr
                  from cc_deal d
                  join nd_acc na on na.nd = d.nd
                  join accounts a on a.acc = na.acc and
                                     a.dazs is null and
                                     a.nbs is not null -- �� ���������� ������� �� �������� ��������
                  join int_accn i on i.acc = a.acc and
                                     i.id = a.pap - 1 and
                                     i.acr_dat < p_date_through
                  where d.nd in (select column_value from table(p_deals)) and
                        d.sos <> 15) loop


            prepare_interest_utl(l_reckoning_id,
                                 i.acc,
                                 i.nls,
                                 i.ostc,
                                 i.id,
                                 i.basey,
                                 i.metr,
                                 i.acr_dat + 1,
                                 case when i.stp_dat is null then p_date_through
                                      else least(p_date_through, i.stp_dat)
                                 end,
                                 i.nd);
        end loop;

        pul.set_mas_ini('RECKONING_ID', l_reckoning_id, '');

        return l_reckoning_id;
    end;

    procedure pay_int_reckoning_row(
        p_int_reckoning_row in int_reckoning%rowtype,
        p_silent_mode in boolean default false,
        p_do_not_store_interest_tails in boolean default false)
    is
        l_account_row accounts%rowtype;
        l_int_accn_row int_accn%rowtype;
        l_interest_account_row accounts%rowtype;
        l_income_account_row accounts%rowtype;

        l_document_id integer;
        l_operation_type varchar2(30 char);
        l_dk integer;
        l_interest_amount number;
        l_income_amount number;
        l_interest_tail number := p_int_reckoning_row.interest_tail;
        l_purpose varchar2(160 char);
        l_error_message varchar2(4000 byte);
        l_sos integer;
    begin
        if (p_int_reckoning_row.state_id not in (interest_utl.RECKONING_STATE_RECKONED, interest_utl.RECKONING_STATE_ACCRUAL_FAILED, interest_utl.RECKONING_STATE_MODIFIED)) then
            return;
        end if;

        savepoint before_doc;

        if (p_int_reckoning_row.interest_tail <> 0 or p_int_reckoning_row.interest_amount <> 0) then

            l_account_row := account_utl.read_account(p_int_reckoning_row.account_id);
            l_int_accn_row := interest_utl.read_int_accn(p_int_reckoning_row.account_id, p_int_reckoning_row.interest_kind, p_lock => true);

            l_interest_account_row := account_utl.read_account(l_int_accn_row.acra, p_lock => true, p_raise_ndf => false);
            if (l_interest_account_row.acc is null) then
                raise_application_error(-20000, '������� ����������� ������� � ��������������� {' || l_int_accn_row.acra || '} �� ���������');
            end if;

            l_income_account_row := account_utl.read_account(l_int_accn_row.acrb, p_lock => true, p_raise_ndf => false);
            if (l_income_account_row.acc is null) then
                raise_application_error(-20000, '������� ������/������ ��� ����������� ������� � ��������������� {' || l_int_accn_row.acrb || '} �� ���������');
            end if;

            -- ���� ������� ������������� � ����� ��������� �������, �� ��������� �������� �� ������ ������� �������
            -- (���� ���� ���������� �� ������ ��������� �������, ��������� ������ ����� - ������ (959), � ������� ������� � ������� ��� (840))
            -- �����, ���������� ���� ������������ ������� ������������ � ������ ������� ������/������ � ����� ������ ��������
            if (l_int_accn_row.id = interest_utl.INTEREST_KIND_FEES and l_int_accn_row.metr > 90) then
                l_interest_amount := abs(p_int_reckoning_row.interest_amount);
                l_income_amount := abs(p_int_reckoning_row.interest_amount);
            else
                l_interest_amount := currency_utl.convert_amount(abs(p_int_reckoning_row.interest_amount), l_account_row.kv, l_interest_account_row.kv);
                l_income_amount := currency_utl.convert_amount(abs(p_int_reckoning_row.interest_amount), l_account_row.kv, l_income_account_row.kv);
            end if;
            -- ��������� ���������� � ���� ���, ���� ����� ����������� ���� ������� ����� �� 0
            -- ������, ����������� ���� ������� �������� �� �������� ������� �������
            if (l_interest_amount > 0 and l_income_amount > 0) then
                l_operation_type := nvl(l_int_accn_row.tt, '%%1');

                if (l_int_accn_row.id mod 2 = 0) then -- �����
                    l_dk := 1; -- ������ ������� �������: acra - acrb
                else
                    l_dk := 0; -- �������� ������� ������� ��� ��������: acrb - acra
                end if;

                -- ����������� (����� ������� �������: ����������� ��������� ������� ���������� �� ������� ������)
                if (l_int_accn_row.metr = 4) then
                    l_dk := case when l_dk = 0 then 1
                                 when l_dk = 1 then 0
                                 else l_dk
                            end;
                end if;

                l_purpose := case when p_int_reckoning_row.purpose is null then
                                       '�����.%% �� ���.' || l_account_row.nls ||
                                       ' � ' || to_char(p_int_reckoning_row.date_from, 'dd.mm.yy') ||
                                       ' �� ' || to_char(p_int_reckoning_row.date_to, 'dd.mm.yy') || ' ���.'
                                  else p_int_reckoning_row.purpose
                             end;

                gl.ref(l_document_id);

                gl.in_doc3 (ref_   => l_document_id,
                            tt_    => l_operation_type,
                            vob_   => 6,
                            nd_    => substr(to_char(l_document_id), 1, 9),
                            pdat_  => sysdate,
                            vdat_  => gl.bdate,
                            dk_    => l_dk,
                            kv_    => l_interest_account_row.kv,
                            s_     => l_interest_amount,
                            kv2_   => l_income_account_row.kv,
                            s2_    => l_income_amount,
                            sk_    => null,
                            data_  => gl.bdate,
                            datp_  => gl.bdate,
                            nam_a_ => substr(l_interest_account_row.nms, 1, 38),
                            nlsa_  => l_interest_account_row.nls,
                            mfoa_  => gl.amfo,
                            nam_b_ => substr(l_income_account_row.nms, 1, 38),
                            nlsb_  => l_income_account_row.nls,
                            mfob_  => gl.amfo,
                            nazn_  => l_purpose,
                            d_rec_ => null,
                            id_a_  => customer_utl.get_customer_okpo(l_interest_account_row.rnk),
                            id_b_  => customer_utl.get_customer_okpo(l_income_account_row.rnk),
                            id_o_  => null,
                            sign_  => null,
                            sos_   => 1,
                            prty_  => null,
                            uid_   => null);

                gl.dyntt2(sos_   => l_sos,
                          mod1_  => 0,
                          mod2_  => 0,
                          ref_   => l_document_id,
                          vdat1_ => gl.bdate,
                          vdat2_ => null,
                          tt0_   => l_operation_type,
                          dk_    => l_dk,
                          kva_   => l_interest_account_row.kv,
                          mfoa_  => gl.amfo,
                          nlsa_  => l_interest_account_row.nls,
                          sa_    => l_interest_amount,
                          kvb_   => l_income_account_row.kv,
                          mfob_  => gl.amfo,
                          nlsb_  => l_income_account_row.nls,
                          sb_    => l_income_amount,
                          sq_    => null,
                          nom_   => null);

                gl.pay(p_flag => 2, p_ref => l_document_id, p_vdat => gl.bd());

                -- ������� ������-������� � ���������� ���������, ���� � ������� ����� ������������� ������ ��� �������� ���������.
                acrn.acr_dati(p_int_reckoning_row.account_id,
                              p_int_reckoning_row.interest_kind,
                              l_document_id,
                              p_int_reckoning_row.date_to, -- �������� �������� �������� ����, �� ��� ��������� �������
                              p_int_reckoning_row.interest_tail);      -- � ����� ������ ������� ������� �������

                if (p_int_reckoning_row.deal_id is not null) then
                    cck_utl.link_document_to_deal(p_int_reckoning_row.deal_id, l_document_id);
                end if;

                update int_reckoning t
                set    t.state_id = interest_utl.RECKONING_STATE_ACCRUED,
                       t.message = '³������ ����������',
                       t.oper_ref=l_document_id
                where  t.id = p_int_reckoning_row.id;
            else
                l_interest_tail := p_int_reckoning_row.interest_amount + p_int_reckoning_row.interest_tail;
                update int_reckoning t
                set    t.state_id = interest_utl.RECKONING_STATE_ACCRUED,
                       t.message = '���� ������� ������� ���� - �������� �� �����������, ' ||
                                   '���� ���������� ����������� �������������� ' || to_char(p_int_reckoning_row.date_to, 'dd.mm.yyyy')
                where  t.id = p_int_reckoning_row.id;
            end if;

            if (p_do_not_store_interest_tails) then
                l_interest_tail := 0;
            end if;

            update int_accn t
            set    t.acr_dat = case when t.acr_dat is null then p_int_reckoning_row.date_to
                                    else greatest(t.acr_dat, p_int_reckoning_row.date_to)
                               end,
                   t.s = l_interest_tail
            where  t.acc = p_int_reckoning_row.account_id and
                   t.id = p_int_reckoning_row.interest_kind;
        end if;
    exception
        when others then
             rollback to before_doc;

             l_error_message := sqlerrm || dbms_utility.format_error_backtrace();
             bars_audit.error('interest_utl.pay_int_reckoning_row (exception)' || chr(10) || l_error_message);

             if (p_silent_mode) then
                 update int_reckoning t
                 set    t.state_id = interest_utl.RECKONING_STATE_ACCRUAL_FAILED,
                        t.message = substrb('������� ��� ���������� �������: ' || l_error_message, 1, 4000)
                 where  t.id = p_int_reckoning_row.id;
             else
                 raise;
             end if;
    end;

    procedure pay_accrued_interest(
        p_do_not_store_interest_tails in boolean default false)
    is
    begin
        for i in (select *
                  from   int_reckoning t
                  where  t.reckoning_id = sys_context('bars_pul', 'reckoning_id')
                  order by t.account_id, t.date_to
                  for update skip locked) loop

            pay_int_reckoning_row(i, p_silent_mode => true, p_do_not_store_interest_tails => p_do_not_store_interest_tails);
        end loop;
    end;

    procedure remove_reckoning(
        p_id in integer)
    is
    begin
        delete int_reckoning t
        where  t.reckoning_id = sys_context('bars_pul', 'reckoning_id') and
               t.id = p_id;
    end;

    function read_reckoning_row(
        p_id in integer,
        p_raise_ndf in boolean default true,
        p_lock in boolean default false)
    return int_reckonings%rowtype
    is
        l_int_reckoning_row int_reckonings%rowtype;
    begin
        if (p_lock) then
            select *
            into   l_int_reckoning_row
            from   int_reckonings t
            where  t.id = p_id
            for update;
        else
            select *
            into   l_int_reckoning_row
            from   int_reckonings t
            where  t.id = p_id;
        end if;

        return l_int_reckoning_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                 raise_application_error(-20000, '���������� ������� � ��������������� {' || p_id || '} �� ���������');
             else return null;
             end if;
    end;

    function read_document(
        p_document_id in integer,
        p_raise_ndf in boolean default true)
    return oper%rowtype
    is
        l_document_row oper%rowtype;
    begin
        select *
        into   l_document_row
        from   oper t
        where  t.ref = p_document_id;

        return l_document_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                 raise_application_error(-20000, '�������� � ��������������� {' || p_document_id || '} �� ���������');
             else return null;
             end if;
    end;
/*
    procedure date_span(
        p_date_from in date,
        p_date_through in date,
        p_days out integer,
        p_weeks out integer,
        p_months out integer,
        p_quarters out integer,
        p_years out integer)
    is
    begin
        p_days := p_date_through - p_date_from;
        p_weeks := trunc();
    end;
*/
    function is_leap_year(p_date in date)
    return integer
    is
        l_year integer := extract(year from p_date);
    begin
        return case when ((l_year mod 4 = 0) and (not l_year mod 100 = 0)) or (l_year mod 400 = 0) then 1
                    else 0
               end;
    end;

    function days_in_year(p_date in date)
    return integer
    is
    begin
        return case when is_leap_year(p_date) = 1 then 365
                    else 366
               end;
    end;

    function add_months_alt(
        p_date   in date,
        p_months in integer)
    return date
    is
        l_last_day date;
    begin
        l_last_day := add_months(p_date, p_months);
        return l_last_day - greatest(0, (extract(day from l_last_day) - extract(day from p_date)));
    end;

    function months_between_alt(
        p_date_from in date,
        p_date_to   in date)
    return number
    is
        l_day_from   integer;
        l_month_from integer;
        l_year_from  integer;
        l_day_to     integer;
        l_month_to   integer;
        l_year_to    integer;

        l_months_between integer;

        l_days_between integer;
    begin
        l_day_from   := extract(day from p_date_from);
        l_month_from := extract(month from p_date_from);
        l_year_from  := extract(year from p_date_from);

        l_day_to     := extract(day from p_date_to);
        l_month_to   := extract(month from p_date_to);
        l_year_to    := extract(year from p_date_to);

        l_months_between := (l_year_to - l_year_from) * 12 + (l_month_to - l_month_from);

        if (l_day_to > l_day_from and l_day_from = extract(day from last_day(p_date_from))) then
            l_day_to := l_day_from;
        end if;

        if (l_day_from > l_day_to and l_day_to = extract(day from last_day(p_date_to))) then
            l_day_from := l_day_to;
        end if;

        if (l_day_from > l_day_to) then
            l_months_between := l_months_between - 1;
            l_day_to := l_day_to + 31;
        end if;

        l_days_between := l_day_to - l_day_from;

        return l_months_between + l_days_between / 31;
    end;

    function handle_holidays(
        p_date in date,
        p_handling_mode in integer,
        p_minimum_date in date default null)
    return date
    is
        l_date date;
    begin
        if (p_date is null or p_handling_mode is null) then
            return null;
        end if;

        if (p_handling_mode > 0) then
            l_date := dat_next_u(p_date, 0);
        elsif (p_handling_mode < 0) then
            if (p_date <> dat_next_u(p_date, 0)) then
                l_date := dat_next_u(p_date, -1);
                if (p_minimum_date is not null and l_date < p_minimum_date) then
                    l_date := dat_next_u(p_minimum_date, 1);
                end if;
            end if;
        else
            l_date := p_date;
        end if;

        return l_date;
    end;

    function find_previous_date(
        p_date_for in date,
        p_period_kind in varchar2,
        p_period_length in integer default 1,
        p_initial_date in date default null,
        p_strict_shift in integer default 0,
        p_holidays_handling in integer default 0)
    return date
    is
        l_initial_date date := case when p_initial_date is null then p_date_for else p_initial_date end;
        l_previous_date date;
        l_days_remainder integer;
        l_months_remainder number;
        l_periods_between integer;
        l_months_between number;
    begin
        if (p_date_for is null or p_period_kind is null or p_period_length is null) then
            return null;
        end if;

        if (p_period_length <= 0) then
            raise_application_error(-20000, '������� ������ ������� ���� ����� ����');
        end if;

        if (p_date_for < l_initial_date) then
            raise_application_error(-20000, '���� ��� ��� ������������� �������� �������� {' || to_char(p_date_for, 'dd.mm.yyyy') ||
                                            '} �� ���� ���� ������� �� ���� ������� ����� {' || to_char(l_initial_date, 'dd.mm.yyyy') || '}');
        end if;

        case (upper(p_period_kind))
        when 'DAY' then
             l_days_remainder := (p_date_for - l_initial_date) mod p_period_length;

             l_periods_between := trunc((p_date_for - l_initial_date) / p_period_length) -
                                      case when l_days_remainder = 0 and p_strict_shift = 1 then 1
                                           else 0
                                      end;
             l_previous_date := l_initial_date + (l_periods_between * p_period_length);
        when 'WEEK' then
             return find_previous_date(p_date_for, 'DAY', p_period_length * 7, p_initial_date, p_strict_shift);
        when 'MONTH' then
             l_months_between := round(months_between_alt(l_initial_date, p_date_for), 10);

             l_months_remainder := l_months_between / p_period_length - trunc(l_months_between / p_period_length);

             l_periods_between := trunc(l_months_between / p_period_length) -
                                      case when l_months_remainder = 0 and p_strict_shift = 1 then 1
                                           else 0
                                      end;

             l_previous_date := add_months_alt(l_initial_date, l_periods_between * p_period_length);
        when 'QUARTER' then
             return find_previous_date(p_date_for, 'MONTH', p_period_length * 3, p_initial_date, p_strict_shift);
        when 'YEAR' then
             return find_previous_date(p_date_for, 'MONTH', p_period_length * 12, p_initial_date, p_strict_shift);
        else
             raise_application_error(-20000, '������������ ��� ������ {' || p_period_kind || '}');
        end case;

        l_previous_date := handle_holidays(l_previous_date, p_holidays_handling, l_initial_date);

        return greatest(l_previous_date, l_initial_date);
    end;

    function find_next_date(
        p_date_for in date,
        p_period_kind in varchar2,
        p_period_length in integer default 1,
        p_initial_date in date default null,
        p_strict_shift in integer default 0,
        p_holidays_handling in integer default null)
    return date
    is
        l_initial_date date := case when p_initial_date is null then p_date_for else p_initial_date end;
        l_next_date date;
        l_days_difference integer;
        l_period_length integer := p_period_length;
        l_initial_day integer;
        l_day_for integer;
        l_date_for date;
        l_starting_date date;
    begin
        if (p_date_for is null or p_period_kind is null or p_period_length is null) then
            return null;
        end if;

        -- �������� ��������� ���������� ����
        l_starting_date := find_previous_date(p_date_for, p_period_kind, p_period_length, p_initial_date, p_strict_shift => 0, p_holidays_handling => 0);

        if (l_starting_date = p_date_for and p_strict_shift = 0) then
            -- ���� ���� �� ���� ����� �� � ����'������� � ���� ���������� ��䳿 ������� � ����� �� ��� �� ������ �������� ����,
            -- ������� �� ��� �� ���� - ��������� �������� �������� ���� ���������� ��䳿
            return greatest(l_initial_date, handle_holidays(l_starting_date, p_holidays_handling, l_initial_date));
        end if;

        case (upper(p_period_kind))
        when 'DAY' then
             l_next_date := l_starting_date + p_period_length;
        when 'WEEK' then
             l_next_date := l_starting_date + (7 * p_period_length);
        when 'MONTH' then
             l_next_date := add_months_alt(l_starting_date, p_period_length);
        when 'QUARTER' then
             l_next_date := add_months_alt(l_starting_date, 3 * p_period_length);
        when 'YEAR' then
             l_next_date := add_months_alt(l_starting_date, 12 * p_period_length);
        else
             raise_application_error(-20000, '������������ ��� ������ {' || p_period_kind || '}');
        end case;

        return greatest(l_initial_date, handle_holidays(l_next_date, p_holidays_handling, l_initial_date));
    end;

    function pipe_dates(
        p_date_from in date,
        p_date_through in date,
        p_period_kind in varchar2,
        p_period_length in integer,
        p_initial_date in date,
        p_strict_shift in integer,
        p_holidays_handling in integer)
    return date_list
    pipelined
    is
        l_calendar_date date;
        l_date_through date;
        l_prev_date_through date;
    begin
        if (p_date_from is null or p_date_through is null or p_period_kind is null or p_initial_date is null) then
            return;
        end if;

        l_calendar_date := find_next_date(p_date_from, p_period_kind, p_period_length, p_initial_date, p_strict_shift, 0);
        l_date_through := handle_holidays(l_calendar_date, p_holidays_handling, p_date_from); -- find_previous_date(p_date_from, p_period_kind, p_period_length, p_initial_date, p_strict_shift, p_holidays_handling);
        loop
            if (l_date_through is null or l_date_through > p_date_through) then
                exit;
            end if;

            if (l_prev_date_through is null or l_prev_date_through <> l_date_through) then
                pipe row (l_date_through);
            end if;

            l_prev_date_through := l_date_through;
            l_calendar_date := find_next_date(l_calendar_date, p_period_kind, p_period_length, p_initial_date, 1, 0);
            l_date_through := handle_holidays(l_calendar_date, p_holidays_handling, l_calendar_date);
        end loop;
    end;

    procedure track_reckoning(
        p_reckoning_id in integer,
        p_state_id in integer,
        p_tracking_message in varchar2)
    is
    begin
        insert into int_reckoning_tracking
        values (s_int_reckoning_tracking.nextval,
                p_reckoning_id,
                p_state_id,
                p_tracking_message,
                sysdate,
                sys_context('bars_global', 'user_id'));
    end;

    function create_interest_reckoning(
        p_reckoning_type_id in integer,
        p_account_id in integer,
        p_interest_kind_id in integer,
        p_date_from in date,
        p_date_through in date,
        p_account_rest in integer,
        p_interest_rate in number,
        p_interest_amount in integer,
        p_interest_tail in number,
        p_state_id in integer default null,
        p_deal_id in integer default null)
    return integer
    is
        l_state_id integer := p_state_id;
    begin
        if (p_reckoning_type_id not in (interest_utl.RECKONING_TYPE_RAW, interest_utl.RECKONING_TYPE_GROUPING_UNIT, interest_utl.RECKONING_TYPE_CORRECTION)) then
            raise_application_error(-20000, '������������ ��� ������ � ��������������� {' || p_reckoning_type_id || '}');
        end if;

        if (l_state_id is null) then
            l_state_id := case when p_interest_amount <> 0 then interest_utl.RECKONING_STATE_RECKONED
                               else interest_utl.RECKONING_STATE_ONLY_INFO
                          end;
        end if;

        insert into int_reckonings
        values (s_int_reckoning.nextval,
                p_reckoning_type_id,
                p_deal_id,
                p_account_id,
                p_interest_kind_id,
                p_date_from,
                p_date_through,
                p_account_rest,
                p_interest_rate,
                p_interest_amount,
                p_interest_tail,
                l_state_id,
                null,
                null,
                null,
                null,
                null);

        track_reckoning(s_int_reckoning.currval, l_state_id, '');

        return s_int_reckoning.currval;
    end;

    procedure set_reckoning_state(
        p_reckoning_id in integer,
        p_state_id in integer,
        p_tracking_message in varchar2 default null)
    is
    begin
        update int_reckonings t
        set    t.state_id = p_state_id
        where  t.id = p_reckoning_id;

        track_reckoning(p_reckoning_id, p_state_id, p_tracking_message);
    end;

    function get_reckoning_comment(
        p_reckoning_id in integer,
        p_reckoning_state_id in integer,
        p_accrual_document_id in integer,
        p_payment_document_id in integer)
    return varchar2
    is
        l_reckoning_comment varchar2(4000 byte);
    begin
        if (p_reckoning_state_id in (interest_utl.RECKONING_STATE_RECKONING_FAIL,
                                     interest_utl.RECKONING_STATE_ACCRUAL_FAILED,
                                     interest_utl.RECKONING_STATE_PAYMENT_FAILED)) then
            select min(t.tracking_message) keep (dense_rank last order by t.id)
            into   l_reckoning_comment
            from   int_reckoning_tracking t
            where  t.reckoning_id = p_reckoning_id;
        elsif (p_reckoning_state_id in (interest_utl.RECKONING_STATE_ACCRUED)) then
            l_reckoning_comment := '��������� �����������: ' || p_accrual_document_id;
        elsif (p_reckoning_state_id in (interest_utl.RECKONING_STATE_PAYED)) then
            l_reckoning_comment := '��������� �������: ' || p_payment_document_id;
        end if;

        return l_reckoning_comment;
    end;

    function get_rate_purpose_clause(
        p_reckoning_id in integer,
        p_reckoning_type_id in integer,
        p_interest_rate in number)
    return varchar2
    is
        l_interest_rates number_list;
        l_rate_dates string_list;
    begin
        if (p_reckoning_type_id = INTEREST_UTL.RECKONING_TYPE_RAW) then
            return case when p_interest_rate is null then null
                        else ' ������: ' || to_char(p_interest_rate, 'FM999999990.0099') || '%'
                   end;
        elsif (p_reckoning_type_id = INTEREST_UTL.RECKONING_TYPE_GROUPING_UNIT) then
            select f.interest_rate,
                   to_char(f.date_from, 'dd/mm') || '-' || to_char(f.interest_rate, 'FM999999990.0099') || '%' rate_date
            bulk collect into l_interest_rates, l_rate_dates
            from   (select d.date_from, d.interest_rate
                    from   (select t.date_from,
                                   t.interest_rate,
                                   lag(t.interest_rate, 1, null) over (order by t.date_from) next_interest_rate,
                                   case when t.interest_rate = lag(t.interest_rate, 1, null) over (order by t.date_from) then 0
                                        else 1
                                   end rate_change_flag
                            from   int_reckonings t
                            where  t.grouping_line_id = p_reckoning_id) d
                    where d.rate_change_flag = 1) f;
            if (l_interest_rates is empty) then
                return null;
            elsif (l_interest_rates.count = 1) then
                return ' ������: ' || to_char(l_interest_rates(l_interest_rates.first), 'FM999999990.0099') || '%';
            else
                return ' ������: ' || tools.words_to_string(l_rate_dates, ', ', 100, p_ignore_nulls => 'Y');
            end if;
        else
            return null;
        end if;
    end;
/*
    function generate_accrual_purpose(
        p_reckoning_method in integer,
        p_account_number in varchar2,
        p_date_from in date,
        p_date_through in date,
        p_interest_rate in number)
    return varchar2
    is
    begin
        return case when p_reckoning_method = 4 then
                         substr('����������� ���. (�������.) ' || p_account_number ||
                                ' � ' || to_char(p_date_from, 'dd.mm.yy') ||
                                ' �� ' || to_char(p_date_through, 'dd.mm.yy') || ' ���.', 1, 160)
                    else case when p_reckoning_method = 1 then
                                   substr('�����.%% �� ���.' || p_account_number ||
                                   ' � ' || to_char(p_date_from, 'dd.mm.yy') ||
                                   ' �� ' || to_char(p_date_through, 'dd.mm.yy') ||
                                   ' ���.', 1, 160)
                              else
                                   substr('�����.%% �� ���.' || p_account_number ||
                                   ' � ' || to_char(p_date_from, 'dd.mm.yy') ||
                                   ' �� ' || to_char(p_date_through, 'dd.mm.yy') ||
                                   ' ���. ������ % ' || to_char(p_interest_rate, 'FM999999990.0099'), 1, 160)
                         end
               end;
    end;
*/
    function generate_accrual_purpose(
        p_reckoning_id in integer,
        p_reckoning_type_id in integer,
        p_reckoning_method in integer,
        p_account_number in varchar2,
        p_date_from in date,
        p_date_through in date,
        p_interest_rate in number)
    return varchar2
    is
    begin
        return case when p_reckoning_method = 4 then
                         substr('����������� ���. (�������.) ' || p_account_number ||
                                ' � ' || to_char(p_date_from, 'dd.mm.yy') ||
                                ' �� ' || to_char(p_date_through, 'dd.mm.yy') || ' ���.', 1, 160)
                    else substr('�����.%% �� ���.' || p_account_number ||
                                ' � ' || to_char(p_date_from, 'dd.mm.yy') ||
                                ' �� ' || to_char(p_date_through, 'dd.mm.yy') ||
                                ' ���.' ||
                                get_rate_purpose_clause(p_reckoning_id, p_reckoning_type_id, p_interest_rate), 1, 160)
               end;
    end;
/*
    function generate_payment_purpose(
        p_reckoning_method in integer,
        p_account_number in varchar2,
        p_date_from in date,
        p_date_through in date,
        p_interest_rate in number)
    return varchar2
    is
    begin
        return case when p_reckoning_method = 1 then
                         substr('����.%% �� ���.' || p_account_number ||
                         ' � ' || to_char(p_date_from, 'dd.mm.yy') ||
                         ' �� ' || to_char(p_date_through, 'dd.mm.yy') ||
                         ' ���.', 1, 160)
                    else
                         substr('����.%% �� ���.' || p_account_number ||
                         ' � ' || to_char(p_date_from, 'dd.mm.yy') ||
                         ' �� ' || to_char(p_date_through, 'dd.mm.yy') ||
                         ' ���. ������ % ' || to_char(p_interest_rate, 'FM999999990.0099'), 1, 160)
               end;
    end;
*/
    function generate_payment_purpose(
        p_reckoning_id in integer,
        p_reckoning_type_id in integer,
        p_reckoning_method in integer,
        p_account_number in varchar2,
        p_date_from in date,
        p_date_through in date,
        p_interest_rate in number)
    return varchar2
    is
    begin
        return substr('����.%% �� ���.' || p_account_number ||
                      ' � ' || to_char(p_date_from, 'dd.mm.yy') ||
                      ' �� ' || to_char(p_date_through, 'dd.mm.yy') ||
                      ' ���.' ||
                      get_rate_purpose_clause(p_reckoning_id, p_reckoning_type_id, p_interest_rate), 1, 160);
    end;

    function get_accrual_purpose(
        p_reckoning_id in integer)
    return varchar2
    is
        l_reckoning_row int_reckonings%rowtype;
        l_int_accn_row int_accn%rowtype;
    begin
        l_reckoning_row := read_reckoning_row(p_reckoning_id);

        if (l_reckoning_row.accrual_purpose is null) then
            l_int_accn_row := read_int_accn(l_reckoning_row.account_id, l_reckoning_row.interest_kind_id);
            return generate_accrual_purpose(l_reckoning_row.id,
                                            l_reckoning_row.line_type_id,
                                            l_int_accn_row.metr,
                                            account_utl.get_account_number(l_reckoning_row.account_id),
                                            l_reckoning_row.date_from,
                                            l_reckoning_row.date_through,
                                            l_reckoning_row.interest_rate);
        else
            return l_reckoning_row.accrual_purpose;
        end if;
    end;

    function get_payment_purpose(
        p_reckoning_id in integer)
    return varchar2
    is
        l_reckoning_row int_reckonings%rowtype;
        l_int_accn_row int_accn%rowtype;
    begin
        l_reckoning_row := read_reckoning_row(p_reckoning_id);

        if (l_reckoning_row.payment_purpose is null) then
            l_int_accn_row := read_int_accn(l_reckoning_row.account_id, l_reckoning_row.interest_kind_id);

            return generate_payment_purpose(l_reckoning_row.id,
                                            l_reckoning_row.line_type_id,
                                            l_int_accn_row.metr,
                                            account_utl.get_account_number(l_reckoning_row.account_id),
                                            l_reckoning_row.date_from,
                                            l_reckoning_row.date_through,
                                            l_reckoning_row.interest_rate);
        else
            return l_reckoning_row.payment_purpose;
        end if;
    end;

    function get_reckoning_purpose(
        p_reckoning_id in integer)
    return varchar2
    is
        l_reckoning_row int_reckonings%rowtype;
    begin
        l_reckoning_row := read_reckoning_row(p_reckoning_id);
        if (l_reckoning_row.state_id in (interest_utl.RECKONING_STATE_PAYED)) then
            return read_document(l_reckoning_row.payment_document_id, p_raise_ndf => false).nazn;
        elsif (l_reckoning_row.state_id in (interest_utl.RECKONING_STATE_ACCRUED, interest_utl.RECKONING_STATE_PAYMENT_FAILED)) then
            return case when l_reckoning_row.payment_purpose is null then
                             generate_payment_purpose(l_reckoning_row.id,
                                                      l_reckoning_row.line_type_id,
                                                      read_int_accn(l_reckoning_row.account_id, l_reckoning_row.interest_kind_id).metr,
                                                      account_utl.get_account_number(l_reckoning_row.account_id),
                                                      l_reckoning_row.date_from,
                                                      l_reckoning_row.date_through,
                                                      l_reckoning_row.interest_rate)
                        else l_reckoning_row.payment_purpose
                   end;
        elsif (l_reckoning_row.state_id in (interest_utl.RECKONING_STATE_RECKONED,
                                            interest_utl.RECKONING_STATE_MODIFIED, interest_utl.RECKONING_STATE_ACCRUAL_FAILED)) then
            return case when l_reckoning_row.accrual_purpose is null then
                             get_accrual_purpose(p_reckoning_id)
                        else l_reckoning_row.accrual_purpose
                   end;
        end if;

        return null;
    end;

    procedure redact_reckoning(
        p_reckoning_id in integer,
        p_interest_amount in number,
        p_accrual_purpose in varchar2)
    is
        l_reckoning_row int_reckonings%rowtype;
        l_account_row accounts%rowtype;
    begin
        /*logger.info('interest_utl.redact_reckoning',
                        'p_reckoning_id    : ' || p_reckoning_id    || chr(10) ||
                        'p_interest_amount : ' || p_interest_amount || chr(10) ||
                        'p_accrual_purpose : ' || p_accrual_purpose);*/

        l_reckoning_row := interest_utl.read_reckoning_row(p_reckoning_id, p_lock => true);
        l_account_row := account_utl.read_account(l_reckoning_row.account_id);

        if (l_reckoning_row.state_id not in (interest_utl.RECKONING_STATE_RECKONED, interest_utl.RECKONING_STATE_MODIFIED,
                                             interest_utl.RECKONING_STATE_RECKONING_FAIL, interest_utl.RECKONING_STATE_ACCRUAL_FAILED,
                                             interest_utl.RECKONING_STATE_ONLY_INFO, interest_utl.RECKONING_STATE_ACCRUED,
                                             interest_utl.RECKONING_STATE_PAYMENT_FAILED)) then
            raise_application_error(-20000, '³������ �� ������� ' || l_account_row.nls ||
                                            ' �� ����� � ' || to_char(l_reckoning_row.date_from, 'dd.mm.yyyy') ||
                                            ' �� ' || to_char(l_reckoning_row.date_through, 'dd.mm.yyyy') ||
                                            ' ����������� � ������ {' || list_utl.get_item_name(interest_utl.LT_RECKONING_STATE, l_reckoning_row.state_id) ||
                                            '} � �� ������ ���� �����������');
        end if;

        if (l_reckoning_row.state_id in (interest_utl.RECKONING_STATE_ACCRUED, interest_utl.RECKONING_STATE_PAYMENT_FAILED)) then
            if (l_reckoning_row.interest_amount <> currency_utl.to_fractional_units(p_interest_amount, l_account_row.kv)) then
                raise_application_error(-20000, '���������� �������� ���� �������, �� ���� ���������');
            end if;
        end if;

        update int_reckonings t
        set    t.interest_amount = currency_utl.to_fractional_units(p_interest_amount, l_account_row.kv),
               t.accrual_purpose = p_accrual_purpose,
               t.interest_tail = 0
        where  t.id = p_reckoning_id;

        track_reckoning(p_reckoning_id,
                        interest_utl.RECKONING_STATE_MODIFIED,
                        '����� ����������� ���������� �������. ���� ���� �������: ' || p_interest_amount ||
                        ' ' || currency_utl.get_currency_lcv(l_account_row.kv) ||
                        ' (' || p_accrual_purpose ||
                        '). �������� �������� ���� �������: ' || currency_utl.from_fractional_units(l_reckoning_row.interest_amount, l_account_row.kv) ||
                        ' ' || currency_utl.get_currency_lcv(l_account_row.kv) ||
                        ' (' || get_accrual_purpose(p_reckoning_id) || ')');
    end;

    procedure clear_reckonings_utl(
        p_reckoning_row in int_reckonings%rowtype)
    is
    begin
        if (p_reckoning_row.line_type_id = interest_utl.RECKONING_TYPE_GROUPING_UNIT) then
            for i in (select * from int_reckonings t where t.grouping_line_id = p_reckoning_row.id) loop
                if (i.state_id <> interest_utl.RECKONING_STATE_GROUPED) then
                    raise_application_error(-20000, '��������� ������� ���������� ������ ���������� ������� - ' ||
                                                    '�����, �� ������� �� ����� � ��������������� {' || p_reckoning_row.id ||
                                                    '} �� ������ {' || list_utl.get_item_name(interest_utl.LT_RECKONING_STATE, i.state_id) || '}');
                end if;
                clear_reckonings_utl(i);
            end loop;
        end if;

        delete int_reckoning_tracking t where t.reckoning_id = p_reckoning_row.id;
        delete int_reckonings t where t.id = p_reckoning_row.id;
    end;

    procedure clear_reckonings(
        p_reckoning_row in int_reckonings%rowtype)
    is
    begin
        if (p_reckoning_row.state_id not in (interest_utl.RECKONING_STATE_RECKONED, interest_utl.RECKONING_STATE_MODIFIED,
                                                 interest_utl.RECKONING_STATE_ACCRUAL_FAILED, interest_utl.RECKONING_STATE_ONLY_INFO,
                                                 interest_utl.RECKONING_STATE_RECKONING_FAIL)) then
            raise_application_error(-20000, '���������� ������� �� ����� {' || p_reckoning_row.date_from || ' - ' || p_reckoning_row.date_through ||
                                            '} �� ������� ' || account_utl.get_account_number(p_reckoning_row.account_id) ||
                                            '(' || account_utl.get_account_currency_id(p_reckoning_row.account_id) || ')' ||
                                            ' �������� � ���� {' || list_utl.get_item_name(interest_utl.LT_RECKONING_STATE, p_reckoning_row.state_id) ||
                                            '} � �� ���� ���� ���������');
        end if;

        clear_reckonings_utl(p_reckoning_row);
    end;

    procedure clear_reckonings(
        p_account_id in integer,
        p_interest_kind_id in integer,
        p_date_from in date)
    is
    begin
        for i in (select t.*
                  from   int_reckonings t
                  where  t.account_id = p_account_id and
                         t.interest_kind_id = p_interest_kind_id and
                         t.date_through >= p_date_from and
                         t.grouping_line_id is null
                  order by t.date_from
                  for update) loop

            clear_reckonings(i);
        end loop;
    end;

    procedure clear_reckonings(
        p_account_id in integer,
        p_interest_kind_id in integer default null)
    is
    begin
        for i in (select t.*
                  from   int_reckonings t
                  where  t.account_id = p_account_id and
                         (p_interest_kind_id is null or t.interest_kind_id = p_interest_kind_id) and
                         t.grouping_line_id is null
                  order by t.date_from desc
                  for update) loop
            if (i.state_id not in (interest_utl.RECKONING_STATE_RECKONED, interest_utl.RECKONING_STATE_MODIFIED,
                                   interest_utl.RECKONING_STATE_ACCRUAL_FAILED, interest_utl.RECKONING_STATE_ONLY_INFO,
                                   interest_utl.RECKONING_STATE_RECKONING_FAIL)) then
                exit;
            end if;

            clear_reckonings(i);
        end loop;
    end;

    procedure reckon_interest(
        p_reckoning_unit in out nocopy t_reckoning_unit)
    is
    begin
        clear_reckonings(p_reckoning_unit.account_id,
                         p_reckoning_unit.interest_kind,
                         p_reckoning_unit.date_from);

        delete acr_intn;

        interest_utl.p_int(p_reckoning_unit.account_id,
                           p_reckoning_unit.interest_kind,
                           p_reckoning_unit.date_from,
                           p_reckoning_unit.date_through,
                           p_reckoning_unit.interest_amount,
                           null,
                           1);

        if (p_reckoning_unit.interest_amount <> 0) then
            for i in (select * from acr_intn) loop
                tools.hide_hint(
                    create_interest_reckoning(interest_utl.RECKONING_TYPE_RAW,
                                              p_reckoning_unit.account_id,
                                              p_reckoning_unit.interest_kind,
                                              i.fdat,
                                              i.tdat,
                                              i.osts / acrn.dlta(p_reckoning_unit.reckoning_calendar, i.fdat, i.tdat + 1),
                                              case when nvl(i.br, 0) = 0 then nvl(i.ir, 0) else i.br end,
                                              abs(round(i.acrd)),
                                              i.remi,
                                              null,
                                              p_reckoning_unit.deal_id));
            end loop;
        else
            -- ����� ���� = 0, �� ���� �������� ������� acr_dat ���-����� ���� ����� ����������
            tools.hide_hint(
                create_interest_reckoning(interest_utl.RECKONING_TYPE_RAW,
                                          p_reckoning_unit.account_id,
                                          p_reckoning_unit.interest_kind,
                                          p_reckoning_unit.date_from,
                                          p_reckoning_unit.date_through,
                                          fost(p_reckoning_unit.account_id, p_reckoning_unit.date_from),
                                          acrn.fprocn(p_reckoning_unit.account_id, p_reckoning_unit.interest_kind, p_reckoning_unit.date_through),
                                          0,
                                          0,
                                          null,
                                          p_reckoning_unit.deal_id));
        end if;
    end;

    procedure reckon_interest(
        p_account_id in integer,
        p_interest_kind_id in integer,
        p_date_through in date,
        p_deal_id in integer default null)
    is
        l_int_accn_row int_accn%rowtype;
        l_reckoning_unit t_reckoning_unit;
    begin
        l_int_accn_row := read_int_accn(p_account_id, p_interest_kind_id);
        l_reckoning_unit.account_id := l_int_accn_row.acc;
        l_reckoning_unit.account_number := account_utl.get_account_number(p_account_id);
        l_reckoning_unit.interest_kind := p_interest_kind_id;
        l_reckoning_unit.reckoning_method := l_int_accn_row.metr;
        l_reckoning_unit.reckoning_calendar := l_int_accn_row.basey;
        l_reckoning_unit.deal_id := p_deal_id;
        l_reckoning_unit.date_from := l_int_accn_row.acr_dat + 1;
        l_reckoning_unit.date_through := p_date_through;

        reckon_interest(l_reckoning_unit);
    end;

    procedure reckon_interest(
        p_reckoning_units in out nocopy t_reckoning_units)
    is
        l binary_integer;
        l_reckoning_id integer;
    begin
        if (p_reckoning_units is null or p_reckoning_units is empty) then
            return;
        end if;

        l := p_reckoning_units.first;
        while (l is not null) loop
            savepoint before_reckoning;

            begin
                reckon_interest(p_reckoning_units(l));
            exception
                when others then
                     rollback to before_reckoning;

                     /*bars_audit.log_error('interest_utl.reckon_interest (exception)',
                                          'account_id      : ' || p_reckoning_units(l).account_id         || chr(10) ||
                                          'account_number  : ' || p_reckoning_units(l).account_number     || chr(10) ||
                                          'interest_kind   : ' || p_reckoning_units(l).interest_kind      || chr(10) ||
                                          'interest_base   : ' || p_reckoning_units(l).reckoning_calendar || chr(10) ||
                                          'interest_method : ' || p_reckoning_units(l).reckoning_method   || chr(10) ||
                                          'date_from       : ' || p_reckoning_units(l).date_from          || chr(10) ||
                                          'date_through    : ' || p_reckoning_units(l).date_through       || chr(10) ||
                                           sqlerrm || chr(10) || dbms_utility.format_error_backtrace());*/

                     l_reckoning_id := create_interest_reckoning(interest_utl.RECKONING_TYPE_RAW,
                                               p_reckoning_units(l).account_id,
                                               p_reckoning_units(l).interest_kind,
                                               p_reckoning_units(l).date_from,
                                               p_reckoning_units(l).date_through,
                                               p_reckoning_units(l).base_amount,
                                               null,
                                               null,
                                               null,
                                               interest_utl.RECKONING_STATE_RECKONING_FAIL,
                                               p_reckoning_units(l).deal_id);
                     track_reckoning(l_reckoning_id, interest_utl.RECKONING_STATE_RECKONING_FAIL, sqlerrm || chr(10) || dbms_utility.format_error_backtrace());
            end;

            l := p_reckoning_units.next(l);
        end loop;
    end;

    procedure reckon_interest(
        p_accounts in number_list,
        p_date_through in date)
    is
        l_reckoning_units t_reckoning_units;
        l integer;
    begin
        if (p_date_through is null) then
            raise_application_error(-20000, '����, �� ��� ������������� ������� �� �������');
        end if;

        if (p_accounts is null or p_accounts is empty) then
            return;
        end if;

        l := p_accounts.first;
        while (l is not null) loop
            clear_reckonings(p_accounts(l), null);
            l := p_accounts.next(l);
        end loop;

        select /*+noparallel*/a.acc,
               a.nls,
               i.id,
               i.metr,
               i.basey,
               null,
               i.acr_dat + 1 date_from,
               case when i.stp_dat is null then p_date_through
                    else least(p_date_through, i.stp_dat)
               end date_through,
               null,
               null,
               null
        bulk collect into l_reckoning_units
        from   accounts a
        join   int_accn i on i.acc = a.acc and
                             i.id = a.pap - 1 and
                             (i.acr_dat is null or i.acr_dat < p_date_through)
        where  a.acc in (select column_value from table(p_accounts)) and
               a.nbs is not null and
               a.dazs is null;

        reckon_interest(l_reckoning_units);
    end;

    procedure reckon_deal_interest(
        p_deals in number_list,
        p_date_through in date)
    is
        l_reckoning_units t_reckoning_units;
        l_accounts number_list;
        l integer;
    begin
        if (p_date_through is null) then
            raise_application_error(-20000, '����, �� ��� ������������� ������� �� �������');
        end if;

        if (p_deals is null or p_deals is empty) then
            return;
        end if;

        select dd.accs
        bulk collect into l_accounts
        from   cc_deal d
        join   cc_add dd on dd.nd = d.nd and dd.adds = 0
        where  d.nd in (select column_value from table(p_deals)) and
               d.sos <> 15;

        l := l_accounts.first;
        while (l is not null) loop
            clear_reckonings(l_accounts(l), null);
            l := l_accounts.next(l);
        end loop;

        select /*+noparallel*/s.acc,
               s.nls,
               i.id,
               i.metr,
               i.basey,
               s.nd,
               i.acr_dat + 1 date_from,
               case when i.stp_dat is null then p_date_through
                    else least(p_date_through, i.stp_dat)
               end date_through,
               null,
               null,
               null
        bulk collect into l_reckoning_units
        from   (select min(d.nd) keep (dense_rank first order by d.nd) nd,
                       a.acc,
                       a.nls,
                       a.pap
                from   cc_deal d
                join   cc_add dd on dd.nd = d.nd and dd.adds = 0
                join   accounts a on a.acc = dd.accs
                where  d.nd in (select column_value from table(p_deals)) and
                       d.sos not in (cck_utl.DEAL_STATE_CLOSED, cck_utl.DEAL_STATE_DELETED) and
                       a.nbs is not null and
                       a.dazs is null
                group by a.acc, a.pap, a.nls) s
        join   int_accn i on i.acc = s.acc and
                             i.id = s.pap - 1 and
                             (i.acr_dat is null or i.acr_dat < p_date_through);

        reckon_interest(l_reckoning_units);
    end;

    procedure group_reckonings(
        p_accounts in number_list,
        p_grouping_mode_id in integer)
    is
        l_interest_kind_id integer;
        l_date_from date;
        l_date_through date;
        l_interest_line_rate number;
        l_interest_line_account_rest number;
        l_interest_line_amount number;
        l_interest_line_tail number;
        l_grouped_set number_list := number_list();
        l_grouping_line_id integer;
        l integer;
        j integer;
    begin
        if (p_accounts is null or p_accounts is empty) then
            return;
        end if;

        if (p_grouping_mode_id is null or p_grouping_mode_id = interest_utl.GROUPING_MODE_NO_GROUPING) then
            return;
        end if;

        l := p_accounts.first;
        while (l is not null) loop

            l_date_from := null;
            for i in (select t.*,
                             row_number() over (order by t.date_from) line_number,
                             count(*) over (partition by t.interest_kind_id) total_lines_count
                      from   int_reckonings t
                      where  t.account_id = p_accounts(l) and
                             t.line_type_id = interest_utl.RECKONING_TYPE_RAW and
                             t.grouping_line_id is null and
                             -- t.interest_amount + t.interest_tail <> 0 and
                             t.state_id in (interest_utl.RECKONING_STATE_RECKONED, interest_utl.RECKONING_STATE_MODIFIED,
                                            interest_utl.RECKONING_STATE_ONLY_INFO, interest_utl.RECKONING_STATE_ACCRUAL_FAILED)
                      order by t.interest_kind_id, t.date_from) loop

                -- l_interest_rate := acrn.fprocn(i.account_id, i.interest_kind_id, i.date_from);
                if (l_date_from is null) then
                    l_interest_kind_id := i.interest_kind_id;
                    l_date_from := i.date_from;
                    l_date_through := i.date_through;
                    l_interest_line_rate := i.interest_rate;
                    l_interest_line_amount := i.interest_amount;
                    l_interest_line_tail := i.interest_tail;
                    l_interest_line_account_rest := i.account_rest;
                    l_grouped_set := number_list(i.id);
                else
                    if (l_interest_kind_id <> i.interest_kind_id or
                        (p_grouping_mode_id = interest_utl.GROUPING_MODE_GROUP_BY_RATES and i.interest_rate <> l_interest_line_rate)) then

                        if (l_interest_line_amount > 0) then
                            l_grouping_line_id := create_interest_reckoning(interest_utl.RECKONING_TYPE_GROUPING_UNIT,
                                                      i.account_id,
                                                      i.interest_kind_id,
                                                      l_date_from,
                                                      l_date_through,
                                                      l_interest_line_account_rest,
                                                      l_interest_line_rate,
                                                      l_interest_line_amount,
                                                      l_interest_line_tail,
                                                      null,
                                                      i.deal_id);

                            l_interest_kind_id := i.interest_kind_id;
                            l_date_from := i.date_from;
                            l_date_through := i.date_through;
                            l_interest_line_rate := i.interest_rate;
                            l_interest_line_amount := i.interest_amount;
                            l_interest_line_tail := i.interest_tail;
                            l_interest_line_account_rest := i.account_rest;

                            j := l_grouped_set.first;
                            while (j is not null) loop
                                set_reckoning_state(l_grouped_set(j), interest_utl.RECKONING_STATE_GROUPED);

                                update int_reckonings t
                                set    t.grouping_line_id = l_grouping_line_id
                                where  t.id = l_grouped_set(j);

                                j := l_grouped_set.next(j);
                            end loop;

                            l_grouped_set := number_list(i.id);
                        end if;
                   else
                       l_date_through := i.date_through;
                       l_interest_line_tail := i.interest_tail;
                       l_interest_line_amount := l_interest_line_amount + i.interest_amount;
                       l_interest_line_account_rest := i.account_rest;

                       l_grouped_set.extend(1);
                       l_grouped_set(l_grouped_set.last) := i.id;
                   end if;
                end if;

                if (i.line_number = i.total_lines_count and l_interest_line_amount > 0) then
                    l_grouping_line_id := create_interest_reckoning(interest_utl.RECKONING_TYPE_GROUPING_UNIT,
                                              i.account_id,
                                              i.interest_kind_id,
                                              l_date_from,
                                              l_date_through,
                                              l_interest_line_account_rest,
                                              l_interest_line_rate,
                                              l_interest_line_amount,
                                              l_interest_line_tail,
                                              null,
                                              i.deal_id);

                    j := l_grouped_set.first;
                    while (j is not null) loop
                        set_reckoning_state(l_grouped_set(j), interest_utl.RECKONING_STATE_GROUPED);

                        update int_reckonings t
                        set    t.grouping_line_id = l_grouping_line_id
                        where  t.id = l_grouped_set(j);

                        j := l_grouped_set.next(j);
                    end loop;
                end if;
            end loop;
            l := p_accounts.next(l);
        end loop;
    end;

    procedure check_if_prev_line_accrued(
        p_account_id in integer,
        p_interest_kind in integer,
        p_date_from in date)
    is
    begin
        for i in (select * from int_reckonings t
                  where  t.account_id = p_account_id and
                         t.interest_kind_id = p_interest_kind and
                         t.state_id in (interest_utl.RECKONING_STATE_RECKONED, interest_utl.RECKONING_STATE_MODIFIED,
                                        interest_utl.RECKONING_STATE_RECKONING_FAIL, interest_utl.RECKONING_STATE_ACCRUAL_FAILED) and
                         t.grouping_line_id is null and
                         t.date_through < p_date_from) loop
            raise_application_error(-20000, '³������ �� ��������� ����� (' || to_char(i.date_from, 'dd.mm.yy') || ' - ' || to_char(i.date_through, 'dd.mm.yy') ||
                                            ') �� �� ��������� - ����������� �� ������� ������ ������������ �� ������');
        end loop;
    end;

    procedure check_if_next_line_accrued(
        p_account_id in integer,
        p_interest_kind in integer,
        p_date_through in date)
    is
    begin
        for i in (select * from int_reckonings t
                  where  t.account_id = p_account_id and
                         t.interest_kind_id = p_interest_kind and
                         t.state_id not in (interest_utl.RECKONING_STATE_RECKONED, interest_utl.RECKONING_STATE_MODIFIED,
                                            interest_utl.RECKONING_STATE_RECKONING_FAIL, interest_utl.RECKONING_STATE_ACCRUAL_FAILED,
                                            interest_utl.RECKONING_STATE_ONLY_INFO) and
                         t.grouping_line_id is null and
                         t.date_from > p_date_through) loop
            raise_application_error(-20000, '³������ �� ��������� ����� (' || to_char(i.date_from, 'dd.mm.yy') || ' - ' || to_char(i.date_through, 'dd.mm.yy') ||
                                            ') ��� ��������� - ������ ����������� �� ���� ' || to_char(p_date_through, 'dd.mm.yy') || ' ���������� �� �����');
        end loop;
    end;

    function get_reckoning_by_accrual_doc(
        p_document_id in integer,
        p_raise_ndf in boolean default true)
    return int_reckonings%rowtype
    is
        l_reckoning_row int_reckonings%rowtype;
    begin
        select *
        into   l_reckoning_row
        from   int_reckonings t
        where  t.accrual_document_id = p_document_id;

        return l_reckoning_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                 raise_application_error(-20000, '���������� �������, ����������� ���������� � ��������������� {' || p_document_id || '} �� ���������');
             else return null;
             end if;
    end;

    function get_reckoning_by_payment_doc(
        p_document_id in integer,
        p_raise_ndf in boolean default true)
    return int_reckonings%rowtype
    is
        l_reckoning_row int_reckonings%rowtype;
    begin
        select *
        into   l_reckoning_row
        from   int_reckonings t
        where  t.payment_document_id = p_document_id;

        return l_reckoning_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                 raise_application_error(-20000, '���������� �������, ���������� ���������� � ��������������� {' || p_document_id || '} �� ���������');
             else return null;
             end if;
    end;

    procedure set_accrual_document(
        p_reckoning_id in integer,
        p_document_id in integer)
    is
        l_reckoning_row int_reckonings%rowtype;
    begin
        if (p_document_id is not null) then
            l_reckoning_row := get_reckoning_by_accrual_doc(p_document_id, p_raise_ndf => false);

            if (l_reckoning_row.id = p_reckoning_id) then
                return; -- �������� �����������, �� ����'������� �� ���������� �������, ��� �� ����� ����'������
            elsif (l_reckoning_row.id <> p_reckoning_id) then
                raise_application_error(-20000, '�������� ����������� � ��������������� {' || p_document_id ||
                                                '} ��� ����''������ �� ���������� ������ �� ����� � ' || to_char(l_reckoning_row.date_from, 'dd.mm.yyyy') ||
                                                ' �� ' || to_char(l_reckoning_row.date_through, 'dd.mm.yyyy') ||
                                                ' �� ������� ' || account_utl.get_account_number(l_reckoning_row.account_id));
            end if;
        end if;

        update int_reckonings t
        set    t.accrual_document_id = p_document_id
        where  t.id = p_reckoning_id;
    end;

    procedure set_payment_document(
        p_reckoning_id in integer,
        p_document_id in integer)
    is
        l_reckoning_row int_reckonings%rowtype;
    begin
        if (p_document_id is not null) then
            l_reckoning_row := get_reckoning_by_payment_doc(p_document_id, p_raise_ndf => false);

            if (l_reckoning_row.id = p_reckoning_id) then
                return; -- �������� �������, �� ����'������� �� ���������� �������, ��� �� ����� ����'������
            elsif (l_reckoning_row.id <> p_reckoning_id) then
                raise_application_error(-20000, '�������� ������� ������� � ��������������� {' || p_document_id ||
                                                '} ��� ����''������ �� ���������� ������ �� ����� � ' || to_char(l_reckoning_row.date_from, 'dd.mm.yyyy') ||
                                                ' �� ' || to_char(l_reckoning_row.date_through, 'dd.mm.yyyy') ||
                                                ' �� ������� ' || account_utl.get_account_number(l_reckoning_row.account_id));
            end if;
        end if;

        update int_reckonings t
        set    t.payment_document_id = p_document_id
        where  t.id = p_reckoning_id;
    end;

    procedure verify_reckoned_interest(
        p_reckoning_row in int_reckonings%rowtype)
    is
        l_interest_amount number;
        l_account_row accounts%rowtype;
        l_modifications_count integer;
    begin
        select count(*)
        into   l_modifications_count
        from   int_reckoning_tracking t
        where  t.reckoning_id = p_reckoning_row.id and
               t.state_id = interest_utl.RECKONING_STATE_MODIFIED;

        if (l_modifications_count = 0) then
            p_int(p_reckoning_row.account_id, p_reckoning_row.interest_kind_id, p_reckoning_row.date_from, p_reckoning_row.date_through, l_interest_amount, mode_ => 0);
            if (abs(p_reckoning_row.interest_amount - round(l_interest_amount)) > 2) then
                l_account_row := account_utl.read_account(p_reckoning_row.account_id);

                raise_application_error(-20000, '���� ������������� �������� (' ||
                                                to_char(currency_utl.from_fractional_units(p_reckoning_row.interest_amount, l_account_row.kv), 'FM9999999999999990.00') ||
                                                ' ' || currency_utl.get_currency_lcv(l_account_row.kv) ||
                                                '} ����������� �� ���������� ����������� {' ||
                                                to_char(currency_utl.from_fractional_units(round(l_interest_amount), l_account_row.kv), 'FM9999999999999990.00') ||
                                                ' ' || currency_utl.get_currency_lcv(l_account_row.kv) ||
                                                '} ��������� �������� ����������� ������� �������');
            end if;
        end if;
    end;

    procedure accrue_interest(
        p_reckoning_row in int_reckonings%rowtype,
        p_silent_mode in boolean default false,
        p_do_not_store_interest_tail in boolean default false,
        p_dk in integer default null)
    is
        l_account_row accounts%rowtype;
        l_int_accn_row int_accn%rowtype;
        l_interest_account_row accounts%rowtype;
        l_income_account_row accounts%rowtype;

        l_document_id integer;
        l_operation_type varchar2(30 char);
        l_dk integer;
        l_interest_amount number;
        l_income_amount number;
        l_interest_tail number := p_reckoning_row.interest_tail;
        l_purpose varchar2(160 char);
        l_error_message varchar2(4000 byte);
        l_sos integer;
    begin
        /*logger.log_info('interest_utl.accrue_interest',
                        'p_int_reckoning_row.id               : ' || p_reckoning_row.id               || chr(10) ||
                        'p_int_reckoning_row.account_id       : ' || p_reckoning_row.account_id       || chr(10) ||
                        'p_int_reckoning_row.interest_kind_id : ' || p_reckoning_row.interest_kind_id || chr(10) ||
                        'p_int_reckoning_row.date_from        : ' || p_reckoning_row.date_from        || chr(10) ||
                        'p_int_reckoning_row.date_through     : ' || p_reckoning_row.date_through     || chr(10) ||
                        'p_int_reckoning_row.interest_amount  : ' || p_reckoning_row.interest_amount);*/

        if (p_reckoning_row.state_id = interest_utl.RECKONING_STATE_ACCRUED) then
            return;
        end if;

	        if (p_reckoning_row.state_id not in (interest_utl.RECKONING_STATE_RECKONED, interest_utl.RECKONING_STATE_ACCRUAL_FAILED, interest_utl.RECKONING_STATE_MODIFIED)) then
            return;
        end if;

        savepoint before_doc;

        check_if_prev_line_accrued(p_reckoning_row.account_id, p_reckoning_row.interest_kind_id, p_reckoning_row.date_from);

        verify_reckoned_interest(p_reckoning_row);
        if (p_reckoning_row.interest_tail <> 0 or p_reckoning_row.interest_amount <> 0) then

            l_account_row := account_utl.read_account(p_reckoning_row.account_id);
            l_int_accn_row := interest_utl.read_int_accn(p_reckoning_row.account_id, p_reckoning_row.interest_kind_id, p_lock => true);

            l_interest_account_row := account_utl.read_account(l_int_accn_row.acra, p_lock => true, p_raise_ndf => false);
            if (l_interest_account_row.acc is null) then
                raise_application_error(-20000, '������� ����������� ������� � ��������������� {' || l_int_accn_row.acra || '} �� ���������');
            end if;

            l_income_account_row := account_utl.read_account(l_int_accn_row.acrb, p_lock => true, p_raise_ndf => false);
            if (l_income_account_row.acc is null) then
                raise_application_error(-20000, '������� ������/������ ��� ����������� ������� � ��������������� {' || l_int_accn_row.acrb || '} �� ���������');
            end if;

            -- ���� ������� ������������� � ����� ��������� �������, �� ��������� �������� �� ������ ������� �������
            -- (���� ���� ���������� �� ������ ��������� �������, ��������� ������ ����� - ������ (959), � ������� ������� � ������� ��� (840))
            -- �����, ���������� ���� ������������ ������� ������������ � ������ ������� ������/������ � ����� ������ ��������
            l_interest_amount := currency_utl.convert_amount(abs(p_reckoning_row.interest_amount), l_account_row.kv, l_interest_account_row.kv);
            l_income_amount := currency_utl.convert_amount(abs(p_reckoning_row.interest_amount), l_account_row.kv, l_income_account_row.kv);

            -- ��������� ���������� � ���� ���, ���� ����� ����������� ���� ������� ����� �� 0
            -- ������, ����������� ���� ������� �������� �� �������� ������� �������
            if (l_interest_amount > 0 and l_income_amount > 0) then
                l_operation_type := nvl(l_int_accn_row.tt, '%%1');

                if (p_dk is null) then
                    l_dk := case when l_interest_account_row.pap = 1 then 1 -- �������� �������
                                 else 0 -- �������� ������� (�������� ������� �������)
                            end;
                    if (l_int_accn_row.metr = 4) then
                        l_dk := case when l_dk = 0 then 1
                                     when l_dk = 1 then 0
                                     else l_dk
                                end; -- �����������
                    end if;
                else
                    l_dk := p_dk;
                end if;

                l_purpose := get_accrual_purpose(p_reckoning_row.id);

                gl.ref(l_document_id);

                gl.in_doc3 (ref_   => l_document_id,
                            tt_    => l_operation_type,
                            vob_   => 6,
                            nd_    => substr(to_char(l_document_id), 1, 9),
                            pdat_  => sysdate,
                            vdat_  => gl.bdate,
                            dk_    => l_dk,
                            kv_    => l_interest_account_row.kv,
                            s_     => l_interest_amount,
                            kv2_   => l_income_account_row.kv,
                            s2_    => l_income_amount,
                            sk_    => null,
                            data_  => gl.bdate,
                            datp_  => gl.bdate,
                            nam_a_ => substr(l_interest_account_row.nms, 1, 38),
                            nlsa_  => l_interest_account_row.nls,
                            mfoa_  => gl.amfo,
                            nam_b_ => substr(l_income_account_row.nms, 1, 38),
                            nlsb_  => l_income_account_row.nls,
                            mfob_  => gl.amfo,
                            nazn_  => l_purpose,
                            d_rec_ => null,
                            id_a_  => customer_utl.get_customer_okpo(l_interest_account_row.rnk),
                            id_b_  => customer_utl.get_customer_okpo(l_income_account_row.rnk),
                            id_o_  => null,
                            sign_  => null,
                            sos_   => 1,
                            prty_  => null,
                            uid_   => null);

                gl.dyntt2(sos_   => l_sos,
                          mod1_  => 0,
                          mod2_  => 0,
                          ref_   => l_document_id,
                          vdat1_ => gl.bdate,
                          vdat2_ => null,
                          tt0_   => l_operation_type,
                          dk_    => l_dk,
                          kva_   => l_interest_account_row.kv,
                          mfoa_  => gl.amfo,
                          nlsa_  => l_interest_account_row.nls,
                          sa_    => l_interest_amount,
                          kvb_   => l_income_account_row.kv,
                          mfob_  => gl.amfo,
                          nlsb_  => l_income_account_row.nls,
                          sb_    => l_income_amount,
                          sq_    => null,
                          nom_   => null);

                gl.pay(p_flag => 2, p_ref => l_document_id, p_vdat => gl.bd());

                -- ������� ������-������� � ���������� ���������, ���� � ������� ����� ������������� ������ ��� �������� ���������.
                acrn.acr_dati(p_reckoning_row.account_id,
                              p_reckoning_row.interest_kind_id,
                              l_document_id,
                              l_int_accn_row.acr_dat,    -- �������� �������� ����, �� ��� ��������� �������
                              l_int_accn_row.s);  -- � ����� ������ ������� ������� �������

                if (p_reckoning_row.deal_id is not null) then
                    cck_utl.link_document_to_deal(p_reckoning_row.deal_id, l_document_id);
                end if;

                set_accrual_document(p_reckoning_row.id, l_document_id);

                set_reckoning_state(p_reckoning_row.id, interest_utl.RECKONING_STATE_ACCRUED);
            else
                l_interest_tail := p_reckoning_row.interest_amount + p_reckoning_row.interest_tail;

                set_reckoning_state(p_reckoning_row.id, interest_utl.RECKONING_STATE_ACCRUED);
            end if;

            if (p_do_not_store_interest_tail) then
                l_interest_tail := 0;
            end if;
        else
            set_reckoning_state(p_reckoning_row.id, interest_utl.RECKONING_STATE_ACCR_DISCARDED);
        end if;

        update int_accn t
        set    t.acr_dat = case when t.acr_dat is null then p_reckoning_row.date_through
                                else greatest(t.acr_dat, p_reckoning_row.date_through)
                           end,
               t.s = l_interest_tail
        where  t.acc = p_reckoning_row.account_id and
               t.id = p_reckoning_row.interest_kind_id;
    exception
        when others then
             rollback to before_doc;

             l_error_message := sqlerrm || dbms_utility.format_error_backtrace();
             /*bars_audit.log_error('interest_utl.accrue_interest (exception)', l_error_message);*/

             if (p_silent_mode) then
                 set_reckoning_state(p_reckoning_row.id, interest_utl.RECKONING_STATE_ACCRUAL_FAILED, l_error_message);
             else
                 raise;
             end if;
    end;

    procedure accrue_reckoned_interest(
        p_filter in varchar2,
        p_do_not_store_interest_tail in boolean default false)
    is
        l_statement varchar2(32767 byte) := 'select * from int_reckonings where id in (select id from v_interest_to_accrual where state_id in (1, 2, 6)';
        l_interest_reckonings t_interest_reckonings;
        l integer;
    begin
        /*bars_audit.log_info('interest_utl.accrue_reckoned_interest', 'p_filter : ' || p_filter);*/

        if  (p_filter is not null) then
            l_statement := l_statement || ' and ' || p_filter;
        end if;

        l_statement := l_statement || ') order by account_id, interest_kind_id, date_from /*for update of id skip locked*/';

        execute immediate l_statement bulk collect into l_interest_reckonings;

        l := l_interest_reckonings.first;
        while (l is not null) loop
            accrue_interest(l_interest_reckonings(l), p_silent_mode => true, p_do_not_store_interest_tail => p_do_not_store_interest_tail);

            l := l_interest_reckonings.next(l);
        end loop;
    end;

    procedure accrue_reckoned_interest(
        p_accounts in number_list,
        p_do_not_store_interest_tail in boolean default false)
    is
        l_interest_reckonings t_interest_reckonings;
        l integer;
    begin
       /* bars_audit.log_info('interest_utl.accrue_reckoned_interest', 'p_accounts : ' || tools.number_list_to_string(p_accounts, p_ceiling_length => 2000));*/

        if (p_accounts is null or p_accounts is empty) then
            return;
        end if;

        select *
        bulk collect into l_interest_reckonings
        from   int_reckonings t
        where  t.state_id in (interest_utl.RECKONING_STATE_RECKONED, interest_utl.RECKONING_STATE_MODIFIED, interest_utl.RECKONING_STATE_ACCRUAL_FAILED) and
               t.account_id in (select column_value from table(p_accounts))
        order by t.account_id, t.interest_kind_id, t.date_from
        for update skip locked;

        l := l_interest_reckonings.first;
        while (l is not null) loop
            accrue_interest(l_interest_reckonings(l), p_silent_mode => true, p_do_not_store_interest_tail => p_do_not_store_interest_tail);
            l := l_interest_reckonings.next(l);
        end loop;
    end;

    procedure accrue_deal_interest(
        p_deals in number_list,
        p_do_not_store_interest_tail in boolean default false)
    is
        l_interest_reckonings t_interest_reckonings;
        l integer;
    begin
      /*  bars_audit.log_info('interest_utl.accrue_deal_interest', 'p_deals : ' || tools.number_list_to_string(p_deals, p_ceiling_length => 2000));*/

        if (p_deals is null or p_deals is empty) then
            return;
        end if;

        select *
        bulk collect into l_interest_reckonings
        from   int_reckonings t
        where  t.state_id in (interest_utl.RECKONING_STATE_RECKONED, interest_utl.RECKONING_STATE_MODIFIED, interest_utl.RECKONING_STATE_ACCRUAL_FAILED) and
               t.deal_id in (select column_value from table(p_deals))
        order by t.account_id, t.interest_kind_id, t.date_from
        for update skip locked;

        l := l_interest_reckonings.first;
        while (l is not null) loop
            accrue_interest(l_interest_reckonings(l), p_silent_mode => true, p_do_not_store_interest_tail => p_do_not_store_interest_tail);
            l := l_interest_reckonings.next(l);
        end loop;
    end;

    procedure pay_interest(
        p_reckoning_row in int_reckonings%rowtype,
        p_silent_mode in boolean default false)
    is
        l_int_accn_row             int_accn%rowtype;
        l_account_row              accounts%rowtype;
        l_interest_account_row     accounts%rowtype;

        l_accrual_document_row     oper%rowtype;

        l_receiver_mfo             varchar2(6 char);
        l_receiver_account_number  varchar2(15 char);
        l_receiver_currency_id     integer;
        l_receiver_account_row     accounts%rowtype;
        l_receiver_name            varchar2(38 char);
        l_receiver_okpo            varchar2(14 char);

        l_payer_amount             number(38);
        l_receiver_amount          number(38);
        l_document_id              number(38);
        l_operation_type           varchar2(3 char);
        l_payment_purpose          varchar2(160 char);

        l_error_message            varchar(4000 byte);
    begin
        if (p_reckoning_row.state_id = interest_utl.RECKONING_STATE_PAYED) then
            return;
        end if;

        if (p_reckoning_row.state_id not in (interest_utl.RECKONING_STATE_ACCRUED, interest_utl.RECKONING_STATE_PAYMENT_FAILED)) then
            return;
        end if;

        savepoint before_doc;

        l_account_row := account_utl.read_account(p_reckoning_row.account_id, p_lock => true);

        if (p_reckoning_row.state_id not in (interest_utl.RECKONING_STATE_ACCRUED, interest_utl.RECKONING_STATE_PAYMENT_FAILED)) then
            raise_application_error(-20000, '³������ �� ����� � {' || to_char(p_reckoning_row.date_from, 'dd.mm.yyyy') ||
                                            '} �� {' || to_char(p_reckoning_row.date_through, 'dd.mm.yyyy') ||
                                            '} �� ������� {' || l_account_row.nls ||
                                            '} ����� ������ {' || list_utl.get_item_name(interest_utl.LT_RECKONING_STATE, p_reckoning_row.state_id) ||
                                            '} � �� ������ ���� ��������');
        end if;

        if (p_reckoning_row.accrual_document_id is null) then
            raise_application_error(-20000, '�� ������������ ��''���� ���������� ������� � ���������� ����������� �� ����� � {' || to_char(p_reckoning_row.date_from, 'dd.mm.yyyy') ||
                                            '} �� {' || to_char(p_reckoning_row.date_through, 'dd.mm.yyyy') ||
                                            '} �� ������� {' || l_account_row.nls || '}');
        end if;

        l_int_accn_row := read_int_accn(p_reckoning_row.account_id, p_reckoning_row.interest_kind_id);
        l_interest_account_row := account_utl.read_account(l_int_accn_row.acra, p_lock => true);

        l_receiver_mfo := nvl(l_int_accn_row.mfob, l_account_row.kf);
        l_receiver_account_number := nvl(l_int_accn_row.nlsb, l_account_row.nls);
        l_receiver_currency_id := nvl(l_int_accn_row.kvb, l_account_row.kv);

        if (l_receiver_mfo = gl.amfo) then
            l_receiver_account_row := account_utl.read_account(l_receiver_account_number, l_receiver_currency_id, p_raise_ndf => false);
        end if;

        l_receiver_name := substr(trim(case when l_int_accn_row.namb is null then
                                                 case when l_receiver_account_row.nms is null then
                                                           customer_utl.get_customer_short_name(l_account_row.rnk)
                                                      else l_receiver_account_row.nms
                                                 end
                                            else l_int_accn_row.namb
                                       end), 1, 38);
        l_receiver_okpo := case when l_int_accn_row.okpo is null then
                                     case when l_receiver_account_row.rnk is null then
                                               customer_utl.get_customer_okpo(l_account_row.rnk)
                                          else customer_utl.get_customer_okpo(l_receiver_account_row.rnk)
                                     end
                                else l_int_accn_row.okpo
                           end;

        if (l_receiver_mfo = gl.amfo) then
            l_operation_type := '024';  ---<--  024 - ���������� ������� !!!
        else
            l_operation_type := 'PS2';  ---<--  PS2 - ������������� ������� !!!
        end if;

        select * into l_accrual_document_row from oper o where o.ref = p_reckoning_row.accrual_document_id;

        if (l_accrual_document_row.sos <> 5) then
            raise_application_error(-20000, '�������� ����������� ������� �� ����� � {' || to_char(p_reckoning_row.date_from, 'dd.mm.yyyy') ||
                                            '} �� {' || to_char(p_reckoning_row.date_through, 'dd.mm.yyyy') ||
                                            '} �� ������� {' || l_account_row.nls ||
                                            '} �� ���������� �� ���� ��� ����������� - ��� ������� ������� ��������� ��������� ����������� �������');
        end if;

        select sum(s * decode(t.dk, 1, 1, -1))
        into   l_payer_amount
        from   opldok t
        where  t.ref = l_accrual_document_row.ref and
               t.acc = l_interest_account_row.acc;

        l_payer_amount := p_reckoning_row.interest_amount;
        l_payer_amount := least(l_payer_amount, l_interest_account_row.ostc);

        l_receiver_amount := currency_utl.convert_amount(l_payer_amount, l_interest_account_row.kv, l_receiver_currency_id);

        l_payment_purpose := get_payment_purpose(p_reckoning_row.id);

        gl.ref (l_document_id);

        gl.in_doc3(ref_   => l_document_id,
                   tt_    => l_operation_type,
                   vob_   => 6,
                   nd_    => substr(to_char(l_document_id), 1, 10),
                   pdat_  => sysdate,
                   vdat_  => gl.bdate,
                   dk_    => 1,
                   kv_    => l_interest_account_row.kv,
                   s_     => l_payer_amount,
                   kv2_   => l_receiver_currency_id,
                   s2_    => l_receiver_amount,
                   sk_    => null,
                   data_  => gl.bdate,
                   datp_  => gl.bdate,
                   nam_a_ => substr(l_interest_account_row.nms, 1, 38),
                   nlsa_  => l_interest_account_row.nls,
                   mfoa_  => gl.amfo,
                   nam_b_ => substr(l_receiver_name, 1, 38),
                   nlsb_  => l_receiver_account_number,
                   mfob_  => l_receiver_mfo,
                   nazn_  => l_payment_purpose,
                   d_rec_ => null,
                   id_a_  => customer_utl.get_customer_okpo(l_account_row.rnk),
                   id_b_  => l_receiver_okpo,
                   id_o_  => null,
                   sign_  => null,
                   sos_   => 1,
                   prty_  => null,
                   uid_   => null);

        paytt(flg_  => 0,
              ref_  => l_document_id,
              datv_ => gl.bdate,
              tt_   => l_operation_type,
              dk0_  => 1,
              kva_  => l_interest_account_row.kv,
              nls1_ => l_interest_account_row.nls,
              sa_   => l_payer_amount,
              kvb_  => l_receiver_currency_id,
              nls2_ => l_receiver_account_number,
              sb_   => l_receiver_amount);

         set_payment_document(p_reckoning_row.id, l_document_id);

         set_reckoning_state(p_reckoning_row.id, interest_utl.RECKONING_STATE_PAYED);

         update int_accn t
         set    t.apl_dat = case when t.apl_dat is null then p_reckoning_row.date_through
                                 else greatest(t.apl_dat, p_reckoning_row.date_through)
                            end
         where  t.acc = p_reckoning_row.account_id and
                t.id = p_reckoning_row.interest_kind_id;

    exception
        when others then
             rollback to before_doc;

             l_error_message := sqlerrm || dbms_utility.format_error_backtrace();
             /*bars_audit.log_error('interest_utl.pay_interest (exception)', l_error_message);*/

             if (p_silent_mode) then
                 set_reckoning_state(p_reckoning_row.id, interest_utl.RECKONING_STATE_PAYMENT_FAILED, l_error_message);
             else
                 raise;
             end if;
    end;

    procedure pay_accrued_interest(
        p_filter in varchar2)
    is
        l_interest_reckonings t_interest_reckonings;
        l_statement varchar2(32767 byte) := 'select * from int_reckonings r where r.interest_kind_id = 1 and ' ||
                                            'r.id in (select id from v_interest_to_payment where state_id in (5, 9)';
        l integer;
    begin
       /* bars_audit.log_info('interest_utl.pay_accrued_interest', 'p_filter : ' || p_filter);*/

        if  (p_filter is not null) then
            l_statement := l_statement || ' and ' || p_filter;
        end if;

        l_statement := l_statement || ') order by account_id, interest_kind_id, date_from for update skip locked';

        execute immediate l_statement bulk collect into l_interest_reckonings;

        l := l_interest_reckonings.first;
        while (l is not null) loop
            pay_interest(l_interest_reckonings(l), p_silent_mode => true);

            l := l_interest_reckonings.next(l);
        end loop;
    end;

    procedure pay_accrued_interest(
        p_accounts in number_list)
    is
        l_interest_reckonings t_interest_reckonings;
        l integer;
    begin
        /*bars_audit.log_trace('interest_utl.pay_accrued_interest', 'p_accounts : ' || tools.number_list_to_string(p_accounts, p_ceiling_length => 2000));*/

        if (p_accounts is null or p_accounts is empty) then
            return;
        end if;

        select *
        bulk collect into l_interest_reckonings
        from   int_reckonings t
        where  t.state_id in (interest_utl.RECKONING_STATE_ACCRUED, interest_utl.RECKONING_STATE_PAYMENT_FAILED) and
               t.account_id in (select column_value from table(p_accounts))
        order by t.account_id, t.interest_kind_id, t.date_from
        for update skip locked;

        l := l_interest_reckonings.first;
        while (l is not null) loop
            pay_interest(l_interest_reckonings(l));
            l := l_interest_reckonings.next(l);
        end loop;
    end;

    procedure on_accrual_document_revert(
        p_document_id in integer)
    is
        l_reckoning_row int_reckonings%rowtype;
        l_payment_document_row oper%rowtype;
    begin
        l_reckoning_row := get_reckoning_by_accrual_doc(p_document_id, p_raise_ndf => false);

        if (l_reckoning_row.id is null) then
            return;
        end if;

        if (l_reckoning_row.state_id = interest_utl.RECKONING_STATE_PAYED) then
            l_payment_document_row := read_document(p_document_id);
            if (l_payment_document_row.sos > 0) then
                raise_application_error(-20000, '���������� ���������� �������� ����������� �������, �� ��� �������� ���������� ' || l_payment_document_row.ref);
            end if;
        end if;

        check_if_next_line_accrued(l_reckoning_row.account_id, l_reckoning_row.interest_kind_id, l_reckoning_row.date_through);
        set_accrual_document(l_reckoning_row.id, null);
        set_reckoning_state(l_reckoning_row.id, interest_utl.RECKONING_STATE_RECKONED, '�������� ����������� � ��������������� ' || p_document_id || ' �����������');
    end;

    procedure on_payment_document_revert(
        p_document_id in integer)
    is
        l_reckoning_row int_reckonings%rowtype;
    begin
        l_reckoning_row := get_reckoning_by_payment_doc(p_document_id, p_raise_ndf => false);

        if (l_reckoning_row.id is null) then
            return;
        end if;

        set_payment_document(l_reckoning_row.id, null);
        set_reckoning_state(l_reckoning_row.id, interest_utl.RECKONING_STATE_ACCRUED, '�������� ������� � ��������������� ' || p_document_id || ' �����������');
    end;

    procedure accrue_reckoned_interest
    is
    begin
      null;
       /* bars_audit.log_info('interest_utl.accrue_reckoned_interest', '');*/
    end;
/*
    procedure accrue_reckoned_interest(
        p_dictionary_list in t_dictionary_list,
        p_message out varchar2)
    is
        i integer;
        j integer;
    begin
        if (p_dictionary_list is null) then
            p_message := p_message || 'dictionary list : null';
        elsif (p_dictionary_list is empty) then
            p_message := p_message || 'dictionary list : empty';
        else
            p_message := p_message || 'dictionary list contains ' || p_dictionary_list.count || ' item(s)' || tools.crlf;
            p_message := p_message || '------------------------------------------------------------------------------------' || tools.crlf;

            i := p_dictionary_list.first;
            while (i is not null) loop
                if (p_dictionary_list(i) is null) then
                    p_message := p_message || '    dictionary # ' || i || ' : null' || tools.crlf;
                elsif (p_dictionary_list(i) is empty) then
                    p_message := p_message || '    dictionary # ' || i || ' : empty' || tools.crlf;
                else
                    p_message := p_message || '    dictionary # ' || i || ' : ' || p_dictionary_list(i).count || ' item(s)' || tools.crlf;
                    j := p_dictionary_list(i).first;
                    while (j is not null) loop
                        if (p_dictionary_list(i)(j) is null) then
                            p_message := p_message || '          item # ' || j || ' : null' || tools.crlf;
                        else
                            p_message := p_message || '          item # ' || j || ' : { key : ' || p_dictionary_list(i)(j).key || ', value : ' || p_dictionary_list(i)(j).value || ' }' || tools.crlf;
                        end if;
                        j := p_dictionary_list(i).next(j);
                    end loop;
                end if;
                p_message := p_message || tools.crlf;
                i := p_dictionary_list.next(i);
            end loop;
        end if;

        bars_audit.log_info('interest_utl.accrue_reckoned_interest', p_message);
    end;*/


-- Dummy interest calculation methods:
/*
              -- ����������� �� ���� ���������� ��������� �� ��������� ����� ("������ ���������")
              if (acc.metr = 3) then
                  declare
                      l_datend date;
                      l_last_accrual_date date;
                  begin
                      select acr_dat
                      into   l_last_accrual_date
                      from   int_accn
                      where  acrb = p_account_id and
                             id = 1;

                      l_datend := least (l_date_through, l_last_accrual_date);

                      for sal in c_amo loop

                          l_row_interest_amount := 0;

                          if (p_interest_kind_id = 0 and sal.ostf < 0 and l_last_accrual_date >= l_date_from) then
                              osts_ := sal.ostf - l_interest_amount;
                              l_days_in_period := l_datend - l_date_from + 1;
                              l_row_interest_amount := osts_ * l_days_in_period / (l_last_accrual_date - l_date_from + 1);

                              if l_row_interest_amount <> 0 then
                                  if mode_ = 1 then
                                     insert into acr_intn (acc, id, fdat, tdat, ir, br, osts, acrd)
                                     values (p_account_id, p_interest_kind_id, l_date_from, l_datend, 0, 0, osts_, l_row_interest_amount);
                                  end if;
                                  l_interest_amount := l_interest_amount + l_row_interest_amount;
                              end if;
                          end if;
                      end loop;

                      goto end_acc;
                  exception
                    when no_data_found then null;
                  end;

        -- ��� ������ �����������
        cursor c_amo is
        select a.mdate, (s.ostf - s.dos + s.kos) + a.ostf ostf
        from   accounts a,
               saldoa s
        where  a.acc = p_account_id and
               a.acc = s.acc and
               s.fdat = (select max(fdat)
                         from   saldoa
                         where  acc = p_account_id and
                                fdat <= l_date_through);

              --
              -- ����������� ������� ������
              --
              elsif acc.metr = 4 then

                for sal in c_amo
                loop

                    if acc.io = 0 then
                        kol_ := 0;
                    else
                        kol_ := 1;
                    end if;

                    l_date_through := least (l_date_through, sal.mdate - kol_);

                    l_row_interest_amount := 0;

                    if (p_interest_kind_id in (0, 2) and sal.ostf < 0) or
                       (p_interest_kind_id in (1, 3) and sal.ostf > 0) then

                       osts_ := sal.ostf - l_interest_amount;
                       l_days_in_period := l_date_through - l_date_from + 1;
                       l_row_interest_amount := osts_ * l_days_in_period/  ((sal.mdate - kol_) - l_date_from + 1);
                       if p_interest_kind_id in (0, 2) then l_row_interest_amount := least(l_row_interest_amount,    0); end if;
                       if p_interest_kind_id in (1, 3) then l_row_interest_amount := greatest(l_row_interest_amount, 0); end if;
                   end if;

                   if l_row_interest_amount != 0 then
                      if mode_ = 1 then
                         insert into acr_intn (acc, id, fdat, tdat, ir, br, osts, acrd, remi)
                         values (p_account_id, p_interest_kind_id, l_date_from, l_date_through, 0, 0, osts_, l_row_interest_amount, l_interest_remainder);
                      end if;
                      l_interest_amount := l_interest_amount + l_row_interest_amount;
                   end if;
                   if sal.ostf - l_interest_amount = 0 then l_date_through := trunc(p_date_through); end if;
                end loop;
                goto end_acc;
          end if;
*/
/*
    -- Calculates interest for given amount at given account
    function calculate_interest_amount(
        p_account_id         integer, -- account number
        p_interest_kind_id   smallint,-- calc code
        p_date_from          date,    -- from date
        p_date_through       date,    -- to   date
        p_account_rest       decimal  default null,
        mode_                smallint default 0) -- mode   play(0)/real(1), play(2)
                                                 -- mode_ = 0  �������������
                                                 -- mode_ = 1  �������� ����������
                                                 -- mode_ = 2  ������������� ��� ��-��
    return number
    is
        l_interest_amount        number;

        l_row_interest_amount    number;
        l_row_date_from          date;
        l_row_date_through       date;

        l_prev_row_date_from     date;
        l_prev_row_interest_rate number;
        l_prev_row_account_rest  number;
        l_prev_row_operation     smallint;
        l_prev_row_base_rate     number;

        l_interest_remainder     number default 0;

        l_date_from              date;
        l_date_through           date;
        l_days_in_period         number;
        l_days_in_year           number;

        l_dummy_date             date;

        ir_    number;
        br_    number;

        osts_  number;
        ostp_  number;
        osta_  number;

        arow   urowid default null;

        l_prev_base_rate number;
        l_prev_base_rate_date date;


        --����� �������� - ������� �� �����
        cursor c_salo is
        select fdat, ostf - dos + kos ostf
        from   saldoa
        where  acc = p_account_id and
               (fdat <= l_date_through and fdat > l_date_from or
                fdat = (select max(fdat) from saldoa where fdat <= l_date_from and acc = p_account_id));

            --����� �������� - ������� �� �����
        cursor c_sali is
        select fdat, ostf, sum(dos) dos
        from   (-- ������ ������� �� ����� �� l_date_from �� l_date_through
                select fdat, ostf, dos
                from   saldoa
                where  acc = p_account_id and fdat <= l_date_through and fdat >= l_date_from
                union all
                -- ������� �� ���� ������� ������: l_date_from
                select l_date_from fdat, ostf - dos + kos ostf, 0 dos
                from   saldoa
                where  acc=p_account_id and
                       fdat = (select max(fdat)
                               from   saldoa
                               where  fdat < l_date_from and acc = p_account_id)
                union all
                -- ������� ������� �������, �� �� ��������� ���� ������ ���� ������� � ����������� ������� ��������� ���
                select fdat+1 fdat,ostf-dos+kos ostf,0 dos
                from saldoa
                where acc=p_account_id and fdat<l_date_through and fdat>=l_date_from)
        group by fdat, ostf;

        -- ����� �������� - ������� �� �����
        cursor c_salh2 is
        select fdat, ostf - dos + kos ostf
        from   saldoho
        where  fdat <= l_date_through and fdat > l_date_from or
               fdat = (select max(fdat)
                       from   saldoa
                       where  fdat <= l_date_from and
                              acc = p_account_id);

        -- ����� �������� - ������� �� ����� (��-��!)
        cursor c_salh3 is
        select fdat, ostf, sum(dos) dos
        from   (select fdat, ostf, dos
                from   saldoho
                where  fdat <= l_date_through and fdat >= l_date_from
                union all
                select l_date_from fdat, ostf - dos + kos ostf, 0 dos
                from   saldoho
                where  fdat = (select max(fdat) from saldoho where fdat < l_date_from)
                union all
                select fdat + 1 fdat, ostf - dos + kos ostf, 0 dos
                from saldoho
                where fdat < l_date_through and fdat >= l_date_from )
        group by fdat, ostf;

        type t_reckoning_line is record
        (
            dat  date,
            ostf number,
            ir   number,
            op   number,
            br   number,
            brn  number
        );

        key varchar2(9);
        type t_reckoning_lines is table of t_reckoning_line index by varchar2(9);
        l_reckoning_lines t_reckoning_lines;
    begin
        l_interest_amount := 0;
        l_date_from := trunc(p_date_from);
        g_acc := p_account_id;

        if (mode_ = 1) then
            delete from acr_intn where acc = p_account_id and id = p_interest_kind_id;
        end if;

        -- ���� �� ����� - ����� �� ������� �������
        while l_date_from <= trunc(p_date_through) loop

          if trunc(l_date_from, 'YEAR') <> trunc(p_date_through, 'YEAR') then
              l_date_through := to_date('3112' || to_char(l_date_from, 'YYYY'), 'DDMMYYYY');
          else
              l_date_through := trunc(p_date_through);
          end if;

          for acc in (select i.acc, i.basey, i.basem, nvl(i.io, 0) io, i.acr_dat + 1 dat,
                             a.kf, a.kv, decode(i.metr, 96, 0, i.metr) metr, a.pap, i.s, i.stp_dat
                      from   int_accn i,
                             accounts a
                      where  a.acc = i.acc and
                             i.acc = p_account_id and
                             i.id  = p_interest_kind_id and
                             i.metr in (0, 1, 2, 3, 4, 96)) loop

              if l_interest_amount = 0 and mode_ = 1 then
                 l_interest_remainder := acc.s;
              end if;

              if acc.basey = 0 then  -- ����/���� ������� % ������
                 l_days_in_year := to_date('3112' || to_char(l_date_from, 'YYYY'), 'DDMMYYYY') - trunc(l_date_from, 'YEAR') + 1;
              elsif acc.basey = 1 then
                 l_days_in_year := 365;
              elsif acc.basey in (2, 3) then
                 l_days_in_year := 360;
              elsif acc.basey = 5 then          -- ����/���� �������� % ������
                 l_days_in_year := add_months(trunc(l_date_from - 1, 'MONTH'), 1) - trunc(l_date_from - 1, 'MONTH');
              else
                 raise_application_error(-20000, '����������� �������� ��������� �������� ����: ' || acc.basey);
              end if;

              -- collect balance history
              if p_account_rest is null then
                 if acc.io = 1 then
                    for sal in c_sali loop
                        if sal.fdat <  l_date_from then
                           sal.fdat := l_date_from;
                        end if;

                        l_reckoning_lines(to_char(sal.fdat,'yyyymmdd')||'0').dat :=sal.fdat;
                        l_reckoning_lines(to_char(sal.fdat,'yyyymmdd')||'0').ostf:=sal.ostf-sal.dos;

                    end loop;

                 elsif acc.io in (2,3) then

                    delete from saldoho;

                    l_dummy_date := l_date_from - 10; -- �������� � ������� 10 �������� ������

                    insert into saldoho (fdat,ostf,dos,kos)
                    select fdat, acrn.ho_ost(p_account_id, fdat, -dos + kos, rownum), dos, kos
                    from   (select fdat, sum(dos) dos, sum(kos) kos
                            from   (select fdat, dos, kos
                                    from   saldoa
                                    where  acc = p_account_id and
                                           fdat = (select max(fdat)
                                                   from   saldoa
                                                   where  acc = p_account_id and
                                                          fdat < l_dummy_date)
                                    union all
                                    select fdat, dos, kos
                                    from   saldoa
                                    where  acc = p_account_id and fdat between l_dummy_date and l_date_through
                                    union all
                                    select cdat, nvl(dos, 0), nvl(kos, 0)
                                    from   v_saldo_holiday v
                                    where  acc = p_account_id and cdat between l_dummy_date and l_date_through
                                    union all
                                    select (select min(fdat)
                                            from   saldoa
                                            where  acc = p_account_id and
                                                   fdat > v.cdat),
                                           nvl(-v.dos, 0),
                                           nvl(-v.kos, 0)
                                    from   v_saldo_holiday v
                                    where  acc = p_account_id and cdat between l_dummy_date and l_date_through)
                              group by fdat order by fdat);

                    if acc.io = 2 then
                       for sal in c_salh2 loop
                           if sal.fdat <  l_date_from then
                              sal.fdat := l_date_from;
                           end if;

                           l_reckoning_lines(to_char(sal.fdat, 'yyyymmdd') || '0').dat := sal.fdat;
                           l_reckoning_lines(to_char(sal.fdat, 'yyyymmdd') || '0').ostf := sal.ostf;

                       end loop;
                    else -- acc.io = 3
                       for sal in c_salh3 loop
                           if sal.fdat <  l_date_from then
                              sal.fdat := l_date_from;
                           end if;

                           l_reckoning_lines(to_char(sal.fdat,'yyyymmdd')||'0').dat :=sal.fdat;
                           l_reckoning_lines(to_char(sal.fdat,'yyyymmdd')||'0').ostf:=sal.ostf-sal.dos;

                       end loop;
                    end if;
                 else
                    for sal in c_salo loop
                        if sal.fdat <  l_date_from then
                           sal.fdat := l_date_from;
                        end if;

                        l_reckoning_lines(to_char(sal.fdat,'yyyymmdd')||'0').dat :=sal.fdat;
                        l_reckoning_lines(to_char(sal.fdat,'yyyymmdd')||'0').ostf:=sal.ostf;

                    end loop;
                 end if;
              else

                 l_reckoning_lines(to_char(l_date_from, 'yyyymmdd') || '0').dat := l_date_from;
                 l_reckoning_lines(to_char(l_date_from, 'yyyymmdd') || '0').ostf := p_account_rest;

              end if;

              -- collect individual rate history
              for i in (select greatest(r.bdat, l_date_from) bdat,
                               nvl(ir, 0) ir,
                               op,
                               nvl(br, 0) br
                        from   int_ratn r
                        where  r.acc = p_account_id and
                               r.id = p_interest_kind_id and
                               (r.bdat <= l_date_through and
                                r.bdat > l_date_from or
                                r.bdat = (select max(rr.bdat)
                                          from   int_ratn rr
                                          where  rr.bdat <= l_date_from and
                                                 rr.acc = p_account_id and
                                                 rr.id = p_interest_kind_id))) loop

                  l_reckoning_lines(to_char(i.bdat, 'yyyymmdd') || '3').dat := i.bdat;
                  l_reckoning_lines(to_char(i.bdat, 'yyyymmdd') || '3').ir  := i.ir;
                  l_reckoning_lines(to_char(i.bdat, 'yyyymmdd') || '3').op  := i.op;
                  l_reckoning_lines(to_char(i.bdat, 'yyyymmdd') || '3').brn := i.br;
              end loop;

              -- collect base rate history
              l_prev_base_rate := null;
              l_prev_base_rate_date := null;

              -- ������� % ������ �� ������
              -- ����� % ������ ������� - ������� �� �����
              for rat in (select r.br,
                                 r.bdat date_from,
                                 lead(r.bdat, 1, l_date_through) over (order by r.bdat) date_to
                          from   int_ratn r
                          where  r.acc = p_account_id and
                                 r.id = p_interest_kind_id and
                                 (r.bdat <= l_date_through and
                                  r.bdat > l_date_from or
                                  r.bdat = (select max(rr.bdat)
                                            from   int_ratn rr
                                            where  rr.bdat <= l_date_from and
                                                   rr.acc = p_account_id and
                                                   rr.id = p_interest_kind_id))) loop

                  -- ������� ���������� ��������� ������
                  for bas in (select bdate
                              from   br_normal b
                              where  b.br_id = l_prev_base_rate and b.kv = acc.kv and
                                     (b.bdate <= rat.date_to and
                                      b.bdate > l_prev_base_rate_date or
                                      b.bdate = (select max(bb.bdate)
                                                 from   br_normal bb
                                                 where  bb.bdate <= l_prev_base_rate_date and
                                                        bb.br_id = l_prev_base_rate and
                                                        bb.kv = acc.kv))
                              group by b.bdate) loop

                      if bas.bdate < l_prev_base_rate_date then      --���� �������� ������ ����������� ������
                          bas.bdate := l_prev_base_rate_date;          --������� �������� �������� �� ���. �� �����
                      end if;

                      l_reckoning_lines(to_char(bas.bdate, 'yyyymmdd') || '2').dat := bas.bdate;
                      l_reckoning_lines(to_char(bas.bdate, 'yyyymmdd') || '2').brn := l_prev_base_rate;
                  end loop;

                  -- ����� �������� ������ �������  - �� ������� �� �����
                  --������� ����������� ��������� ������
                  for tie in (select b.bdate
                              from   br_tier b
                              where  b.br_id = l_prev_base_rate and
                                     b.kv = acc.kv and
                                     (b.bdate <= rat.date_to and
                                      b.bdate > l_prev_base_rate_date or
                                      b.bdate = (select max(bb.bdate)
                                                 from   br_tier bb
                                                 where  bb.bdate <= l_prev_base_rate_date and
                                                        bb.br_id = l_prev_base_rate and
                                                        bb.kv = acc.kv))
                              group by b.bdate) loop
                      if tie.bdate <  l_prev_base_rate_date then
                         tie.bdate := l_prev_base_rate_date;
                      end if;

                      l_reckoning_lines(to_char(tie.bdate, 'yyyymmdd') || '1').dat := tie.bdate;
                      l_reckoning_lines(to_char(tie.bdate, 'yyyymmdd') || '1').brn := l_prev_base_rate;
                  end loop;
              end loop;

              l_reckoning_lines(to_char(l_date_through + 1, 'yyyymmdd') || '4').dat := l_date_through + 1;

              -- end of collection

              l_prev_row_account_rest  := null;
              l_prev_row_date_from     := null;
              l_prev_row_interest_rate := 0;
              l_prev_row_operation   := null;
              l_prev_row_base_rate  := null;

              osta_ := 0;
              l_row_date_from := null;


              key := l_reckoning_lines.first;
              while key is not null loop

                  l_reckoning_lines(key).ostf := nvl(l_reckoning_lines(key).ostf, l_prev_row_account_rest);
                  l_reckoning_lines(key).ir   := nvl(l_reckoning_lines(key).ir, l_prev_row_interest_rate);
                  l_reckoning_lines(key).op   := nvl(l_reckoning_lines(key).op, l_prev_row_operation);
                  l_reckoning_lines(key).brn  := nvl(l_reckoning_lines(key).brn, l_prev_row_base_rate);

                  if (l_prev_row_date_from <> l_reckoning_lines(key).dat and l_prev_row_account_rest is not null) then

                     if acc.metr = 2 then

                        l_row_date_from := nvl(l_row_date_from, l_prev_row_date_from);

                        if l_reckoning_lines(key).ir = l_prev_row_interest_rate and l_reckoning_lines(key).brn = l_prev_row_base_rate then

                           if (acc.pap = 1 and l_prev_row_account_rest <= l_reckoning_lines(key).ostf or
                               acc.pap = 2 and l_prev_row_account_rest >= l_reckoning_lines(key).ostf) then

                              l_prev_row_account_rest := l_reckoning_lines(key).ostf;
                           end if;

                           if substr(key,-1)<>'4' then
                              goto int_333;
                           end if;

                        end if;

                     end if;

                     if acc.metr=1 then    -- �� ����������

                        l_row_date_from := nvl(l_row_date_from, l_prev_row_date_from);

                        if l_reckoning_lines(key).ir=l_prev_row_interest_rate and l_reckoning_lines(key).brn=l_prev_row_base_rate then

                           l_days_in_period := acrn.dlta(acc.basey,l_prev_row_date_from,l_reckoning_lines(key).dat);
                           osta_ := osta_ + l_prev_row_account_rest * l_days_in_period;

                           if substr(key,-1)<>'4' then
                              goto int_222;
                           end if;
                        end if;

                        l_prev_row_account_rest := osta_ / acrn.dlta(acc.basey, l_row_date_from, l_reckoning_lines(key).dat);
                        osta_ := 0;
                     end if;

                     if acc.metr=0 then      -- ����������
                        l_row_date_from := l_prev_row_date_from;
                     end if;

                     l_row_date_through := l_reckoning_lines(key).dat-1;
                     ostp_ := 0;

                     if mod(p_interest_kind_id, 2) = 0 and l_prev_row_account_rest < 0 or
                        mod(p_interest_kind_id, 2) = 1 and l_prev_row_account_rest > 0 then

                        ir_ := l_prev_row_interest_rate;

                        if l_prev_row_base_rate > 0 then
                           acc_form := acc.acc;
                           p_bns(br_, ostp_, l_row_date_from, l_prev_row_base_rate, acc.kv, abs(l_prev_row_account_rest), l_prev_row_operation, ir_, acc.kf);
                           if l_prev_row_account_rest < 0 then
                              ostp_ := -ostp_;
                           end if;
                           ir_ := 0;
                        else
                           br_ := 0;
                        end if;
                     else
                        ir_ := 0;
                        br_ := 0;
                     end if;

                     l_days_in_period := acrn.dlta(acc.basey, l_row_date_from, l_reckoning_lines(key).dat);

                     l_row_interest_amount := ( ir_ * l_prev_row_account_rest + ostp_ ) * l_days_in_period / l_days_in_year / 100;

                     osts_ := l_prev_row_account_rest * l_days_in_period;

                     if l_row_interest_amount <> 0 or acc.metr in (1, 2) then

                        l_row_interest_amount := l_row_interest_amount + l_interest_remainder; -- ����� %% +- ������ ������ � �������� ����
                        l_interest_remainder := l_row_interest_amount - round(l_row_interest_amount);

                        if (mode_ = 1) then
                            insert into acr_intn (acc, id, fdat, tdat, ir, br, osts, acrd, remi)
                            values (p_account_id, p_interest_kind_id, l_row_date_from, l_row_date_through, ir_, br_, osts_, round(l_row_interest_amount), l_interest_remainder)
                            returning rowid into arow;
                        end if;

                        --- ������� ������ ������� ����������� ������� ����,
                        -- ������� �������� ������������ �������, �� ������ ������� ��������� ������ ����������� ����
                        l_interest_amount := l_interest_amount + l_row_interest_amount;
                     end if;
                  end if;

                  if acc.metr=2 then l_row_date_from := null; end if;

                  if acc.metr=1 then
                     l_row_date_from := null;
                     osta_ := 0;
                  end if;

                  <<int_222>>
                  --��� ��������� �� ����������� � ����� �������� ����� ������, ���
                  --��� ���������� ������� ��� ���������� �����: ����� ���������� ���������
                  l_prev_row_account_rest := l_reckoning_lines(key).ostf;

                  <<int_333>>
                  l_prev_row_date_from := l_reckoning_lines(key).dat;
                  l_prev_row_interest_rate  := l_reckoning_lines(key).ir;
                  l_prev_row_operation   := l_reckoning_lines(key).op;
                  l_prev_row_base_rate  := l_reckoning_lines(key).brn;

                  key := l_reckoning_lines.next(key);

              end loop;

              l_reckoning_lines.delete;
          end loop;
          l_date_from := l_date_through + 1;
        end loop;

        if arow is not null and mode_ = 1 then
           update acr_intn set tdat = p_date_through where rowid = arow;
        end if;

        return l_interest_amount;
    end;

    procedure calculate_interest_amount
    is
    begin
        delete tmp_reckoning_line;

        insert into tmp_reckoning_line
        select 'STARTING POINT',      -- event_class               varchar2(30 char),
               t.deal_id,             -- deal_id                   number(38),
               t.account_id,          -- account_id                number(38),
               t.interest_kind,       -- interest_kind             number(38),
               t.reckoning_method,    -- reckoning_method          number(38),
               t.reckoning_calendar,  -- reckoning_calendar        number(38),
               t.balance_kind,        -- balance_kind              number(38),
               t.date_from,           -- date_from                 date,
               null,                  -- date_through              date,
               null,                  -- account_rest              number(38),
               null,                  -- base_rate_id              number(38),
               null,                  -- base_rate_value           number,
               null,                  -- individual_rate_operation number(38),
               null,                  -- individual_rate           number,
               null,                  -- days_in_period            number(38),
               null,                  -- days_in_year              number(3),
               null,                  -- interest_amount           number(38),
               null,                  -- interest_remainder        number,
               null                   -- error_message             varchar2(4000 byte)
        from   tmp_reckoning_unit t;

        merge into tmp_reckoning_line a
        using (select account_id,
                      deal_id,
                      interest_kind,
                      reckoning_method,
                      reckoning_calendar,
                      balance_kind,
                      fdat,
                      ostf - sum(dos) account_rest
               from (select s.fdat,
                            s.ostf,
                            s.dos,
                            r.deal_id,
                            r.account_id,
                            r.interest_kind,
                            r.reckoning_method,
                            r.reckoning_calendar,
                            r.balance_kind
                     from   saldoa s
                     join   tmp_reckoning_unit r on s.acc = r.account_id and
                                                    s.fdat between r.date_from and r.date_through and
                                                    r.balance_kind = 1
                     union all
                     select r.date_from fdat,
                            s.ostf - s.dos + s.kos ostf,
                            0 dos,
                            r.deal_id,
                            r.account_id,
                            r.interest_kind,
                            r.reckoning_method,
                            r.reckoning_calendar,
                            r.balance_kind
                     from   saldoa s
                     join   tmp_reckoning_unit r on s.acc = r.account_id and
                                                    s.fdat = (select max(ss.fdat)
                                                              from   saldoa ss
                                                              where  ss.fdat < r.date_from and
                                                                     ss.acc = r.account_id) and
                                                    r.balance_kind = 1
                     union all
                     select s.fdat + 1 fdat,
                            s.ostf - s.dos + s.kos ostf,
                            0 dos,
                            r.deal_id,
                            r.account_id,
                            r.interest_kind,
                            r.reckoning_method,
                            r.reckoning_calendar,
                            r.balance_kind
                     from   saldoa s
                     join   tmp_reckoning_unit r on s.acc = r.account_id and
                                                    s.fdat <= r.date_through and
                                                    s.fdat >= r.date_from and
                                                    r.balance_kind = 1)
               group by fdat,
                        ostf,
                        account_id,
                        deal_id,
                        interest_kind,
                        reckoning_method,
                        reckoning_calendar,
                        balance_kind) s
        on (tools.compare(a.deal_id, s.deal_id) = 0 and
            a.account_id = s.account_id and
            a.interest_kind = s.interest_kind and
            a.date_from  = s.fdat)
        when matched then update
             set a.account_rest = s.account_rest
        when not matched then insert
             values ('ACCOUNT REST CHANGE',
                     s.deal_id,
                     s.account_id,
                     s.interest_kind,
                     s.reckoning_method,
                     s.reckoning_calendar,
                     s.balance_kind,
                     s.fdat,
                     null,
                     s.account_rest,
                     null,
                     null,
                     null,
                     null,
                     null,
                     null,
                     null,
                     null,
                     null);
    end;
*/
end;
/
