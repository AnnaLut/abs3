create or replace package body interest_utl as

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
        l_mfo varchar2(6 char) := case when p_mfo is null then bars_context.current_mfo() else p_mfo end;
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

        if (l_mfo is null) then
            l_mfo := account_utl.get_account_mfo(p_main_account_id);
        end if;

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
        p_mfo in varchar2 default bars_context.current_mfo())
    is
        l_mfo varchar2(6 char) := case when p_mfo is null then bars_context.current_mfo() else p_mfo end;
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

        if (l_mfo is null) then
            l_mfo := account_utl.get_account_mfo(p_main_account_id);
        end if;

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
                          case when p_interest_amount <> 0 then interest_utl.INT_RECKONING_STATE_NEW
                               else interest_utl.INT_RECKONING_STATE_ONLY_INFO
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

        if (l_int_reckoning_row.state_id = interest_utl.INT_RECKONING_STATE_PAYED) then
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
                if (i.state_id in (interest_utl.INT_RECKONING_STATE_EDITED, interest_utl.INT_RECKONING_STATE_PAYED)) then
                    exit;
                end if;

                if (i.date_from > l_int_reckoning_row.date_from) then
                    l_interest_amount := i.original_interest_amount + l_interest_tail;
                    l_interest_tail := l_interest_amount - round(l_interest_amount);

                    if (round(l_interest_amount) = 0) then
                        l_state_id := interest_utl.INT_RECKONING_STATE_ONLY_INFO;
                        l_message := '���� �������, ����������� �� ����� � ' || to_char(i.date_from, 'dd.mm.yyyy') || ' �� ' || to_char(i.date_to, 'dd.mm.yyyy') || ' ������� ����';
                    else
                        if (i.state_id = interest_utl.INT_RECKONING_STATE_ONLY_INFO) then
                            l_state_id := interest_utl.INT_RECKONING_STATE_NEW;
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
            if (l_int_reckoning_row.state_id = interest_utl.INT_RECKONING_STATE_ONLY_INFO) then
                l_message := '';
            else
                l_message := l_int_reckoning_row.message;
            end if;
        end if;

        update int_reckoning t
        set    t.interest_amount = p_interest_amount,
               t.purpose = p_purpose,
               t.interest_tail = 0,
               t.state_id = interest_utl.INT_RECKONING_STATE_EDITED,
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

    procedure prepare_interest_utl(
        p_reckoning_id in varchar2,
        p_account_id in integer,
        p_account_number in varchar2,
        p_account_rest in number,
        p_interest_kind in integer,
        p_interest_base in integer, --
        p_date_from in date,
        p_date_through in date,
        p_deal_id in integer)
    is
        l_interest_amount number;
    begin
        savepoint before_accruement;

        acrn.p_int( p_account_id, p_interest_kind, p_date_from, p_date_through, l_interest_amount, null, 1);
        --------------------------------------------------------------------------------------------------------------
        -- 13.09.2016 ������ - ��� ���������� ��������� �� ���������� %% � ������� ��������, % ������, �������� ����

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
                  '�����.%% �� ���.' || p_account_number || ' � ' || to_char(m.fdat, 'dd.mm.yy') || ' �� ' || to_char(m.tdat, 'dd.mm.yy') || ' ���.',
                  interest_utl.INT_RECKONING_STATE_NEW,
                  '',
                  null
                  
           from   acr_intn m
           where  m.acc = p_account_id and
                  m.id = p_interest_kind;
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
                    interest_utl.INT_RECKONING_STATE_ONLY_INFO,
                    '���� �������, ����������� �� ����� � ' || to_char(p_date_from, 'dd.mm.yyyy') || ' �� ' || to_char(p_date_through, 'dd.mm.yyyy') || ' ������� ����',
                    null);
        end if;
    exception
        when others then
             rollback to before_accruement;
             bars_audit.error('interest_utl.prepare_interest_utl' || chr(10) ||
                              'reckoning_id   : ' || p_reckoning_id   || chr(10) ||
                              'account_id     : ' || p_account_id     || chr(10) ||
                              'account_number : ' || p_account_number || chr(10) ||
                              'account_rest   : ' || p_account_rest   || chr(10) ||
                              'interest_kind  : ' || p_interest_kind  || chr(10) ||
                              'interest_base  : ' || p_interest_base  || chr(10) ||
                              'date_from      : ' || p_date_from      || chr(10) ||
                              'date_through   : ' || p_date_through   || chr(10) ||
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

        for i in (select a.acc, a.nls, a.nbs, a.rnk, a.ostc, i.acr_dat, i.id, i.basey, i.stp_dat
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

        for i in (select d.nd, d.vidd, a.kv, d.rnk, a.nbs, a.acc, a.nls, i.acr_dat, i.id, a.ostc, i.tt, i.basey, i.stp_dat
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
        p_silent_mode in boolean default false)
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
        if (p_int_reckoning_row.state_id not in (interest_utl.INT_RECKONING_STATE_NEW, interest_utl.INT_RECKONING_STATE_FAILED, interest_utl.INT_RECKONING_STATE_EDITED)) then
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
            if (l_interest_account_row.acc is null) then
                raise_application_error(-20000, '������� ������/������ ��� ����������� ������� � ��������������� {' || l_int_accn_row.acrb || '} �� ���������');
            end if;

            -- ���� ������� ������������� � ����� ��������� �������, �� ��������� �������� �� ������ ������� �������
            -- (���� ���� ���������� �� ������ ��������� �������, ��������� ������ ����� - ������ (959), � ������� ������� � ������� ��� (840))
            -- �����, ���������� ���� ������������ ������� ������������ � ������ ������� ������/������ � ����� ������ ��������
            l_interest_amount := currency_utl.convert_amount(abs(p_int_reckoning_row.interest_amount), l_account_row.kv, l_interest_account_row.kv);
            l_income_amount := currency_utl.convert_amount(abs(p_int_reckoning_row.interest_amount), l_account_row.kv, l_income_account_row.kv);

            -- ��������� ���������� � ���� ���, ���� ����� ����������� ���� ������� ����� �� 0
            -- ������, ����������� ���� ������� �������� �� �������� ������� �������
            if (l_interest_amount > 0 and l_income_amount > 0) then
                l_operation_type := nvl(l_int_accn_row.tt, '%%1');

                l_dk := case when l_interest_account_row.pap = 1 then 1 -- �������� �������
                             else 0 -- �������� ������� (�������� ������� �������)
                        end;

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
                              l_int_accn_row.acr_dat, -- �������� �������� �������� ����, �� ��� ��������� �������
                              l_int_accn_row.s);      -- � ����� ������ ������� ������� �������

                if (p_int_reckoning_row.deal_id is not null) then
                    cck_utl.link_document_to_deal(p_int_reckoning_row.deal_id, l_document_id);
                end if;

                update int_reckoning t
                set    t.state_id = interest_utl.INT_RECKONING_STATE_PAYED,
                       t.message = '³������ ����������',
                       t.oper_ref=l_document_id
                where  t.id = p_int_reckoning_row.id;
            else
                l_interest_tail := p_int_reckoning_row.interest_amount + p_int_reckoning_row.interest_tail;
                update int_reckoning t
                set    t.state_id = interest_utl.INT_RECKONING_STATE_PAYED,
                       t.message = '���� ������� ������� ���� - �������� �� �����������, ' ||
                                   '���� ���������� ����������� �������������� ' || to_char(p_int_reckoning_row.date_to, 'dd.mm.yyyy')
                where  t.id = p_int_reckoning_row.id;
            end if;

            update int_accn t
            set    t.acr_dat = p_int_reckoning_row.date_to,
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
                 set    t.state_id = interest_utl.INT_RECKONING_STATE_FAILED,
                        t.message = substrb('������� ��� ���������� �������: ' || l_error_message, 1, 4000)
                 where  t.id = p_int_reckoning_row.id;
             else
                 raise;
             end if;
    end;

    procedure pay_accrued_interest
    is
    begin
        for i in (select *
                  from   int_reckoning t
                  where  t.reckoning_id = sys_context('bars_pul', 'reckoning_id')
                  for update skip locked) loop

            pay_int_reckoning_row(i, p_silent_mode => true);
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
end;
/
show err