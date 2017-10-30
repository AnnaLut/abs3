create or replace package sto_payment_utl is

    function get_version return varchar2;

    -- статуси платежу
    -- набор статусів погоджений зі СБОН+
    STO_PM_STATE_NEW               constant integer := 0;
    STO_PM_STATE_DECLINED_BY_SBON  constant integer := 1;
    STO_PM_STATE_DECLINED_BY_BARS  constant integer := 2;
    STO_PM_STATE_READY_TO_WITHDRAW constant integer := 3;
    STO_PM_STATE_WITHDRAWN_IN_BARS constant integer := 4;
    STO_PM_STATE_SENT              constant integer := 5;
    STO_PM_STATE_DECLINED_BY_WAY4  constant integer := 6;
    -- внутрішні статуси АБС
    STO_PM_STATE_WITHDR_IN_PROGRES constant integer := 10;
    STO_PM_STATE_WITHDRAW_FAILED   constant integer := 11;
    STO_PM_STATE_CANCEL_BY_CLIENT  constant integer := 12;
    STO_PM_STATE_SBON_AMOUNT_GOT   constant integer := 13;
    STO_PM_STATE_PROCESS_ERROR     constant integer := 14;

    DOCUMENT_STATE_PLAN            constant integer := 0;
    DOCUMENT_STATE_COMPLETED       constant integer := 5;
    DOCUMENT_STATE_STORNED         constant integer := -1;
    DOCUMENT_STATE_IN_QUEUE        constant integer := 20;
    DOCUMENT_STATE_OUT_QUEUE       constant integer := 21;

    TRANS_ACCOUNT_PARAMETER        constant varchar2(30 char) := 'STO_TRANSIT';

    function read_payment(
        p_payment_id in integer,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return sto_payment%rowtype;

    procedure track_payment_state(
        p_payment_id in integer,
        p_state in integer,
        p_comment in varchar2);

    procedure set_payment_state(
        p_payment_id in integer,
        p_state in integer,
        p_comment in varchar2);

    function get_payment_state_name(
        p_payment_state_id in integer)
    return varchar2;

    function get_next_payment_date(
        p_start_date in date,
        p_frequency in integer,
        p_holiday_shift in integer)
    return date;

    function get_payment_additional_info(
        p_payer_account_id in integer,
        p_order_id in integer)
    return clob;

    procedure generate_regular_payments;

    procedure decline_payment_by_sbon(
        p_payment_id in integer,
        p_description in varchar2);

    procedure set_payment_amount_by_sbon(
        p_payment_id in integer,
        p_debt_amount in number,
        p_payment_amount in number,
        p_fee_amount in number);

    procedure set_fee_amount_by_sbon(
        p_payment_id in integer,
        p_fee_amount in number);

    procedure set_payment_purpose_by_sbon(
        p_payment_id in integer,
        p_purpose in varchar2);

    procedure close_payment_by_sbon(
        p_payment_id in integer,
        p_receiver_mfo in varchar2,
        p_receiver_account in varchar2,
        p_receiver_edrpou in varchar2,
        p_provider_purpose in varchar2);

    procedure pay_off_order_amounts(
        p_start_id in varchar2,
        p_end_id in varchar2);

    procedure pay_off_order_amounts;

    procedure complete_payments_withdrawal;
end;
/
create or replace package body sto_payment_utl as

    G_VERSION constant varchar2(64) := 'version 2.2 19.10.2017';

    function get_version
    return varchar2
    is
    begin
        return 'Package sto_payment_utl ' || G_VERSION;
    end;

    procedure track_payment_state(
        p_payment_id in integer,
        p_state in integer,
        p_comment in varchar2)
    is
    begin
        insert into sto_payment_tracking
        values (bars_sqnc.get_nextval('sto_payment_tracking_seq'), p_payment_id, p_state, p_comment, sysdate);
    end;

    function get_payment_errors_count(
        p_payment_id in integer)
    return integer
    is
        l_errors_count integer default 0;
    begin
        for i in (select t.state
                  from   sto_payment_tracking t
                  where  t.payment_id = p_payment_id
                  order by t.id desc) loop
            if (i.state = sto_payment_utl.STO_PM_STATE_PROCESS_ERROR) then
                l_errors_count := l_errors_count + 1;
            else
                exit;
            end if;
        end loop;

        return l_errors_count;
    end;

    procedure set_payment_state(
        p_payment_id in integer,
        p_state in integer,
        p_comment in varchar2)
    is
    begin
        update sto_payment p
        set    p.state = p_state
        where  p.id = p_payment_id;

        track_payment_state(p_payment_id, p_state, p_comment);
    end;

    procedure create_payment_que(
        p_payment_id IN integer)
    is
    begin
        insert into sto_payment_que
        values (p_payment_id);

        track_payment_state(p_payment_id, sto_payment_utl.DOCUMENT_STATE_IN_QUEUE, 'Вставлено документ в чергу на відправку SMS');
    end;

    function create_payment(
        p_order_id in integer,
        p_value_date in date,
        p_payment_amount in number,
        p_fee_amount in number,
        p_purpose in varchar2,
        p_receiver_mfo in varchar2,
        p_receiver_account in varchar2,
        p_receiver_edrpou in varchar2,
        p_branch in varchar2,
        p_mfo in varchar2)
    return integer
    is
        l_payment_id integer;
    begin

        insert into sto_payment
        values (bars_sqnc.get_nextval('sto_payment_seq', bars_context.extract_mfo(p_branch)),
                p_order_id,
                sto_payment_utl.STO_PM_STATE_NEW,
                p_value_date,
                null,
                p_payment_amount,
                p_fee_amount,
                p_purpose,
                p_receiver_mfo,
                p_receiver_account,
                p_receiver_edrpou,
                p_branch,
                p_mfo)
        returning id into l_payment_id;

        track_payment_state(l_payment_id, sto_payment_utl.STO_PM_STATE_NEW, '');

        create_payment_que(l_payment_id);

        return l_payment_id;
    end;

    procedure create_payment_que(
        p_payment_id in integer,
        p_errormsg out varchar2)
    is
    begin
        begin
            insert into sto_payment_que
            values (p_payment_id);
        exception
            when dup_val_on_index then
                 p_errormsg := 'Платіж '||to_char(p_payment_id)||' вже в черзі';

                 bars_audit.info('create_payment_utl.create_payment_que: ' || p_errormsg);
        end;

        track_payment_state(p_payment_id, sto_payment_utl.DOCUMENT_STATE_IN_QUEUE, 'Вставлено документ в чергу на выдправку SMS');
    end;

    procedure delete_payment_que(
        p_payment_id in integer,
        p_errormsg out varchar2)
    is
    begin
        delete sto_payment_que t
        where  t.id = p_payment_id;

        if (sql%rowcount = 0) then
            p_errormsg := 'Платіж ' || to_char(p_payment_id) || ' не знайдено в черзі платежів';
            bars_audit.info('create_payment_utl.create_payment_que:' || p_errormsg);
        else
            p_errormsg := 'Ok';
        end if;

        track_payment_state(p_payment_id, sto_payment_utl.DOCUMENT_STATE_OUT_QUEUE, 'Сквітовано CRM і видалено з черги на выдправку SMS');
    end;

    procedure cancel_payment(
        p_payment_id in integer,
        p_errormsg out varchar2)
    is
    begin
        update sto_payment p
        set    p.state = sto_payment_utl.STO_PM_STATE_CANCEL_BY_CLIENT
        where  p.id = p_payment_id and
               p.state in (sto_payment_utl.STO_PM_STATE_NEW, sto_payment_utl.STO_PM_STATE_READY_TO_WITHDRAW);

        if (sql%rowcount = 0) then
            p_errormsg := 'Відміна за SMS : Платіж ' || to_char(p_payment_id) || ' не знайдено в черзі платежів';
        else
            track_payment_state(p_payment_id, sto_payment_utl.STO_PM_STATE_CANCEL_BY_CLIENT, 'Canceled by SMS');
            p_errormsg := 'Ok';
        end if;
    END;

    function read_payment(
        p_payment_id in integer,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return sto_payment%rowtype
    is
        l_payment_row sto_payment%rowtype;
    begin
        if (p_lock) then
            select *
            into   l_payment_row
            from   sto_payment p
            where  p.id = p_payment_id
            for update;
        else
            select *
            into   l_payment_row
            from   sto_payment p
            where  p.id = p_payment_id;
        end if;

        return l_payment_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                raise_application_error(-20000, 'Регулярний платіж з ідентифікатором {' || p_payment_id || '} не знайдений');
             else return null;
             end if;
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

    function get_payment_state_name(
        p_payment_state_id in integer)
    return varchar2
    is
    begin
        case (p_payment_state_id)
        when sto_payment_utl.STO_PM_STATE_NEW               then return 'Новий';
        when sto_payment_utl.STO_PM_STATE_DECLINED_BY_SBON  then return 'Відхилений СБОН+';
        when sto_payment_utl.STO_PM_STATE_DECLINED_BY_BARS  then return 'Відхилений АБС';
        when sto_payment_utl.STO_PM_STATE_READY_TO_WITHDRAW then return 'Готовий до списання';
        when sto_payment_utl.STO_PM_STATE_WITHDRAWN_IN_BARS then return 'Списаний з рахунку клієнта';
        when sto_payment_utl.STO_PM_STATE_SENT              then return 'Зарахований на рахунок провайдера';
        when sto_payment_utl.STO_PM_STATE_WITHDR_IN_PROGRES then return 'Запит на списання відправлений до ПЦ';
        when sto_payment_utl.STO_PM_STATE_WITHDRAW_FAILED   then return 'Відхилений Процесинговим Центром';
        when sto_payment_utl.STO_PM_STATE_CANCEL_BY_CLIENT  then return 'Відхилений Клієнтом';
        when sto_payment_utl.STO_PM_STATE_SBON_AMOUNT_GOT   then return 'Надійшла сума платежу та комісії від СБОН+';
        when sto_payment_utl.STO_PM_STATE_PROCESS_ERROR     then return 'Помилки при оплаті';
        else return null;
        end case;
    end;

    function get_next_payment_date(p_start_date in date, p_frequency in integer, p_holiday_shift in integer)
    return date
    is
        l_units_count integer;
        l_next_payment_date date;
        l_next_work_date date;
        l_prev_work_date date;
    begin
        if (p_frequency = sto_utl.STO_FREQ_DAILY) then
            l_next_payment_date := greatest(p_start_date, bankdate());
        elsif (p_frequency = sto_utl.STO_FREQ_MONTHLY) then
            l_units_count := ceil(months_between(bankdate(), p_start_date));
            l_next_payment_date := add_months_alt(p_start_date, l_units_count);
        elsif (p_frequency = sto_utl.STO_FREQ_QUARTERLY) then
            l_units_count := ceil(months_between(bankdate(), p_start_date) / 3);
            l_next_payment_date := add_months_alt(p_start_date, l_units_count * 3);
        elsif (p_frequency = sto_utl.STO_FREQ_YEARLY) then
            l_units_count := ceil(months_between(bankdate(), p_start_date) / 12);
            l_next_payment_date := add_months_alt(p_start_date, l_units_count * 12);
        else
            l_next_payment_date := null;
        end if;

        if (p_holiday_shift is null or p_holiday_shift = 0) then
            return l_next_payment_date;
        else
            l_next_work_date := dat_next_u(l_next_payment_date, 0);

            if (l_next_payment_date = l_next_work_date) then
                return l_next_payment_date;
            else
                if (p_holiday_shift > 0) then
                    return l_next_work_date;
                elsif (p_holiday_shift < 0) then
                    l_prev_work_date := dat_next_u(l_next_payment_date, -1);
                    if (l_prev_work_date <= p_start_date) then
                        return l_next_work_date;
                    end if;
                    return l_prev_work_date;
                end if;
            end if;
        end if;
    end;

    procedure generate_regular_payments
    is
        l_payment_id integer;
        l_order_sep_row sto_sep_order%rowtype;
        l_order_sbon_free_row sto_sbon_order_free%rowtype;
        l_order_sbon_contr_row sto_sbon_order_contr%rowtype;
        l_order_sbon_no_contr_row sto_sbon_order_no_contr%rowtype;
        l_sbon_provider_row sto_sbon_product%rowtype;
        l_bank_date date default bankdate();
        l_third_work_day date;
        l_errmsg varchar2(250) := '';
    begin
        l_third_work_day := dat_next_u(l_bank_date,  3);

        bars_audit.info('generate_regular_payments: l_bank_date=' || l_bank_date || ',l_third_work_day= ' || l_third_work_day);

        for i in (select *
                  from   (select o.*, get_next_payment_date(o.start_date, o.payment_frequency, o.holiday_shift) next_payment_date
                          from   sto_order o
                          where  o.state <> sto_utl.STO_ORDER_STATE_CANCELED and
                                 o.state <> sto_utl.STO_ORDER_STATE_NEW and
                                 o.cancel_date is null and
                                     l_third_work_day >= o.start_date and
                                     (o.stop_date is null or l_bank_date <= o.stop_date)) f
                  where f.next_payment_date is not null and
                        (f.stop_date is null or f.next_payment_date <= f.stop_date) and
                        f.next_payment_date between l_bank_date and l_third_work_day and
                        not exists (select 1
                                    from   sto_payment p
                                    where  p.order_id = f.id and
                                           p.value_date = f.next_payment_date))
        loop
            bars_audit.info('generate_regular_payments: i.id=' || to_char(i.id));

            if (i.order_type_id = sto_utl.STO_TYPE_SEP_PAYMENT) then
                l_order_sep_row := sto_utl.read_sep_order(i.id);
                l_payment_id := create_payment(i.id,
                                               i.next_payment_date,
                                               l_order_sep_row.regular_amount,
                                               null,
                                               l_order_sep_row.purpose,
                                               l_order_sep_row.receiver_mfo,
                                               l_order_sep_row.receiver_account,
                                                   l_order_sep_row.receiver_edrpou,
                                                   i.branch,
                                                   i.kf);
            elsif (i.order_type_id = sto_utl.STO_TYPE_SBON_PAYMENT_FREE) then
                l_order_sbon_free_row := sto_sbon_utl.read_sbon_order_free(i.id);
                l_payment_id := create_payment(i.id,
                                               i.next_payment_date,
                                               l_order_sbon_free_row.regular_amount,
                                               null,
                                               l_order_sbon_free_row.purpose,
                                               l_order_sbon_free_row.receiver_mfo,
                                               l_order_sbon_free_row.receiver_account,
                                                   l_order_sbon_free_row.receiver_edrpou,
                                                   i.branch,
                                                   i.kf);
            elsif (i.order_type_id = sto_utl.STO_TYPE_SBON_PAYMENT_CONTR) then

                l_sbon_provider_row := sto_sbon_utl.read_sbon_product(i.product_id);
                bars_audit.info('generate_regular_payments: l_sbon_provider_row=' || to_char(l_sbon_provider_row.RECEIVER_ACCOUNT));
                l_order_sbon_contr_row := sto_sbon_utl.read_sbon_order_contr(i.id);
                l_payment_id := create_payment(i.id,
                                               i.next_payment_date,
                                               l_order_sbon_contr_row.regular_amount,
                                               null,
                                               l_sbon_provider_row.payment_name,
                                               l_sbon_provider_row.receiver_mfo,
                                               l_sbon_provider_row.receiver_account,
                                                   l_sbon_provider_row.receiver_edrpou,
                                                   i.branch,
                                                   i.kf);
                bars_audit.info('generate_regular_payments: l_payment_id=' || to_char(l_payment_id));
            elsif (i.order_type_id = sto_utl.STO_TYPE_SBON_PAYMENT_NOCONTR) then
                l_sbon_provider_row := sto_sbon_utl.read_sbon_product(i.product_id);
                l_order_sbon_no_contr_row := sto_sbon_utl.read_sbon_order_no_contr(i.id);
                l_payment_id := create_payment(i.id,
                                               i.next_payment_date,
                                               l_order_sbon_no_contr_row.regular_amount,
                                               null,
                                               l_sbon_provider_row.payment_name,
                                               l_sbon_provider_row.receiver_mfo,
                                               l_sbon_provider_row.receiver_account,
                                                   l_sbon_provider_row.receiver_edrpou,
                                                   i.branch,
                                                   i.kf);
                end if;
            create_payment_que (l_payment_id, l_errmsg);
        end loop;
    end;

    procedure check_new_payment(
        p_payment_id in integer)
    is
    begin
        null;
    end;

    procedure decline_payment_by_sbon(
        p_payment_id in integer,
        p_description in varchar2)
    is
        l_payment_row sto_payment%rowtype;
    begin
        l_payment_row := read_payment(p_payment_id, p_lock => true);

        if (l_payment_row.state not in (sto_payment_utl.STO_PM_STATE_NEW, sto_payment_utl.STO_PM_STATE_SBON_AMOUNT_GOT)) then
            raise_application_error(-20000, 'Платіж знаходиться в стані {' || get_payment_state_name(l_payment_row.state) || '} і не може бути відхилений системою СБОН+');
        end if;

        update sto_payment p
        set    p.state = sto_payment_utl.STO_PM_STATE_DECLINED_BY_SBON
        where  p.id = p_payment_id;

        track_payment_state(p_payment_id, sto_payment_utl.STO_PM_STATE_DECLINED_BY_SBON, p_description);
    end;

    procedure inform_customer(
        p_customer_id in integer,
        p_message in varchar2)
    is
        l_msgid integer;
        l_customer_phone varchar2(30 char);
    begin
        l_customer_phone := customer_utl.get_customer_mobile_phone(p_customer_id);
        if (l_customer_phone is not null) then
            bars_sms.create_msg(p_msgid           => l_msgid,
                                p_creation_time   => sysdate,
                                p_expiration_time => sysdate + 1,
                                p_phone           => l_customer_phone,
                                p_encode          => 'lat',
                                p_msg_text        => substr(p_message, 1, 160),
                                p_kf              => sys_context('bars_context','user_mfo'));
        end if;
    end;

    procedure inform_customer_by_order(
        p_order_id in integer,
        p_message in varchar2)
    is
        l_order_row sto_order%rowtype;
        l_account_row accounts%rowtype;
    begin
        l_order_row := sto_utl.read_order(p_order_id);
        l_account_row := account_utl.read_account(l_order_row.payer_account_id);

        inform_customer(l_account_row.rnk, p_message);
    end;

    procedure inform_customer_about_new_paym(
        p_order_id in integer,
        p_withdraw_amount in number,
        p_payment_date in date)
    is
    begin
        return;
        inform_customer_by_order(p_order_id,
                                 'Platizh na sumu ' || to_char(p_withdraw_amount, 'FM9999999990.00') ||
                                 ' zaplanovaniy na ' || to_char(p_payment_date, 'DD.MM.YYYY') ||
                                 '. Dlya skasuvannya nadishlit'' sms z tekstom "stop" na nomer <???>');
    end;

    procedure set_payment_amount_by_sbon(
        p_payment_id in integer,
        p_debt_amount in number,
        p_payment_amount in number,
        p_fee_amount in number)
    is
        l_payment_row sto_payment%rowtype;
        l_order_row sto_order%rowtype;
        l_contract_order_row sto_sbon_order_contr%rowtype;
        l_product_row sto_product%rowtype;
        l_new_state integer;
        l_payment_amount number;
    begin
        l_payment_amount:=p_payment_amount;

        l_payment_row := read_payment(p_payment_id, p_lock => true);

        l_order_row := sto_utl.read_order(l_payment_row.order_id);

        l_product_row := sto_utl.read_product(l_order_row.product_id);

        if (l_product_row.order_type_id in (sto_utl.STO_TYPE_SBON_PAYMENT_FREE, sto_utl.STO_TYPE_SBON_PAYMENT_NOCONTR)) then
            if (p_payment_amount is null or p_payment_amount <> l_payment_row.payment_amount) then
                raise_application_error(-20000, 'Режим роботи провайдера ' || l_product_row.product_name || ' не передбачає можливості зміни суми платежу');
            end if;
        elsif (l_product_row.order_type_id = sto_utl.STO_TYPE_SBON_PAYMENT_CONTR) then
            l_contract_order_row := sto_sbon_utl.read_sbon_order_contr(l_order_row.id);
            if (l_contract_order_row.regular_amount is not null and l_contract_order_row.regular_amount <> p_payment_amount) then
                raise_application_error(-20000, 'Кліент бажає платити фіксовану суму: ' || to_char(l_contract_order_row.regular_amount, 'FM9999999990.00') || ' - змінювати суму платежу заборонено');
            else
                if (l_contract_order_row.ceiling_amount is not null and l_contract_order_row.ceiling_amount < p_payment_amount) then
                    l_payment_amount:=l_contract_order_row.ceiling_amount;
                    track_payment_state(p_payment_id, l_payment_row.state, 'Кліент зазначив граничну суму сплати '||to_char(l_contract_order_row.ceiling_amount,'FM9999999990.00'));
                end if;
            end if;
        end if;

        if (l_payment_row.state not in (sto_payment_utl.STO_PM_STATE_NEW, sto_payment_utl.STO_PM_STATE_SBON_AMOUNT_GOT)) then
            raise_application_error(-20000, 'Платіж знаходиться в стані {' || get_payment_state_name(l_payment_row.state) || '} і не може приймати оновлення сум від СБОН+');
        end if;

        l_new_state := sto_payment_utl.STO_PM_STATE_READY_TO_WITHDRAW;

        update sto_payment p
        set    p.debt_amount = p_debt_amount,
               p.payment_amount = l_payment_amount,
               p.fee_amount = p_fee_amount,
               p.state = l_new_state
        where  p.id = p_payment_id;

        if (l_new_state = sto_payment_utl.STO_PM_STATE_READY_TO_WITHDRAW) then
            inform_customer_about_new_paym(l_payment_row.order_id, nvl(p_payment_amount, 0) + nvl(p_fee_amount, 0), l_payment_row.value_date);
        end if;

        track_payment_state(p_payment_id, l_new_state, 'СБОН+ надав значення сум заборгованості та комісії');
    end;

    procedure set_fee_amount_by_sbon(
        p_payment_id in integer,
        p_fee_amount in number)
    is
        l_payment_row sto_payment%rowtype;
        l_new_state integer;
    begin
        l_payment_row := read_payment(p_payment_id, p_lock => true);

        if (l_payment_row.state not in (sto_payment_utl.STO_PM_STATE_NEW, sto_payment_utl.STO_PM_STATE_SBON_AMOUNT_GOT)) then
            raise_application_error(-20000, 'Платіж знаходиться в стані {' || get_payment_state_name(l_payment_row.state) || '} і не може приймати оновлення суми комісії від СБОН+');
        end if;

        l_new_state := sto_payment_utl.STO_PM_STATE_READY_TO_WITHDRAW;

        update sto_payment p
        set    p.fee_amount = p_fee_amount,
               p.state = l_new_state
        where  p.id = p_payment_id;

        if (l_new_state = sto_payment_utl.STO_PM_STATE_READY_TO_WITHDRAW) then
            inform_customer_about_new_paym(l_payment_row.order_id, nvl(l_payment_row.payment_amount, 0) + nvl(p_fee_amount, 0), l_payment_row.value_date);
        end if;

        track_payment_state(p_payment_id, l_new_state, 'СБОН+ надав значення суми комісії');
    end;

    procedure set_payment_purpose_by_sbon(
        p_payment_id in integer,
        p_purpose in varchar2)
    is
        l_payment_row sto_payment%rowtype;
        l_new_state integer;
    begin
        l_payment_row := read_payment(p_payment_id, p_lock => true);

        if (l_payment_row.state not in (sto_payment_utl.STO_PM_STATE_NEW, sto_payment_utl.STO_PM_STATE_SBON_AMOUNT_GOT)) then
            raise_application_error(-20000, 'Платіж знаходиться в стані {' || get_payment_state_name(l_payment_row.state) || '} і не може приймати оновлення призначення платежу від СБОН+');
        end if;

        l_new_state := case when l_payment_row.state = sto_payment_utl.STO_PM_STATE_SBON_AMOUNT_GOT then sto_payment_utl.STO_PM_STATE_READY_TO_WITHDRAW
                            else l_payment_row.state
                       end;

        update sto_payment p
        set    p.purpose = p_purpose,
               p.state = l_new_state
        where  p.id = p_payment_id;

        if (l_new_state = sto_payment_utl.STO_PM_STATE_READY_TO_WITHDRAW) then
            inform_customer_about_new_paym(l_payment_row.order_id, nvl(l_payment_row.payment_amount, 0) + nvl(l_payment_row.fee_amount, 0), l_payment_row.value_date);
        end if;

        track_payment_state(p_payment_id, l_new_state, 'СБОН+ надав текст призначення платежу');
    end;

    procedure close_payment_by_sbon(
        p_payment_id in integer,
        p_receiver_mfo in varchar2,
        p_receiver_account in varchar2,
        p_receiver_edrpou in varchar2,
        p_provider_purpose in varchar2)
    is
        l_payment_row sto_payment%rowtype;
    begin
        bars_audit.trace('sto_payment_utl.close_payment_by_sbon' || chr(10) ||
                         'p_payment_id       : ' || p_payment_id       || chr(10) ||
                         'p_receiver_mfo     : ' || p_receiver_mfo     || chr(10) ||
                         'p_receiver_account : ' || p_receiver_account || chr(10) ||
                         'p_receiver_edrpou  : ' || p_receiver_edrpou  || chr(10) ||
                         'p_provider_purpose : ' || p_provider_purpose);

        l_payment_row := read_payment(p_payment_id, p_lock => true);

        if (l_payment_row.state not in (sto_payment_utl.STO_PM_STATE_WITHDRAWN_IN_BARS)) then
            raise_application_error(-20000, 'Платіж знаходиться в стані {' || get_payment_state_name(l_payment_row.state) || '} і не може бути завершений');
        end if;

        update sto_payment p
        set    p.state = sto_payment_utl.STO_PM_STATE_SENT,
               p.receiver_mfo = p_receiver_mfo,
               p.receiver_account = p_receiver_account,
               p.receiver_edrpou = p_receiver_edrpou,
               p.purpose = p_provider_purpose
        where  p.id = p_payment_id;

        track_payment_state(p_payment_id, sto_payment_utl.STO_PM_STATE_SENT, 'СБОН+ успішно завершив обробку платежу');
    end;

    function new_xml_element(p_name in varchar2, p_value in varchar2)
    return varchar2
    is
    begin
        if (p_value is null) then
            return null;
        end if;

        return '<' || p_name || '>' || p_value || '</' || p_name || '>';
    end;

    function new_xml_element(p_name in varchar2, p_value in date, p_format in varchar2 default sto_utl.FORMAT_DATE)
    return varchar2
    is
    begin
        if (p_value is null) then
            return null;
        end if;

        return '<' || p_name || '>' || to_char(p_value, p_format) || '</' || p_name || '>';
    end;

    function get_payment_additional_info(
        p_payer_account_id in integer,
        p_order_id in integer)
    return clob
    is
        l_clob clob;
        l_account_row accounts%rowtype;
        l_customer_row customer%rowtype;
        l_person_row person%rowtype;
        l_address_line varchar2(210 char);
        l_extra_attributes clob;
        l_xml xmltype;
    begin
        l_account_row := account_utl.read_account(p_payer_account_id);
        l_customer_row := customer_utl.read_customer(l_account_row.rnk);
        l_person_row := customer_utl.read_person(l_account_row.rnk, p_raise_ndf => false);
        l_address_line := substr(customer_utl.get_customer_address_line(l_account_row.rnk), 1, 210);

        l_extra_attributes := sto_utl.get_order_extra_info(p_order_id);

        if (l_extra_attributes is not null) then
            l_xml := xmltype(l_extra_attributes);
            l_xml := l_xml.extract('/Attributes/node()');
        end if;

        dbms_lob.createtemporary(l_clob, false);
        dbms_lob.append(l_clob, '<?xml version="1.0" encoding="UTF-8"?>' ||
                                '<DodPar>' ||
                                    new_xml_element('PayerName', l_customer_row.nmk) ||
                                    new_xml_element('PayerBirthdate', l_person_row.bday) ||
                                    new_xml_element('PayerPassportSeries', l_person_row.ser) ||
                                    new_xml_element('PayerPassportNumber', l_person_row.numdoc) ||
                                    new_xml_element('PayerPassportIssueDate', l_person_row.pdate) ||
                                    new_xml_element('PayerPassportIssuer', l_person_row.organ) ||
                                    new_xml_element('PayerIPN', l_customer_row.okpo) ||
                                    new_xml_element('PayerAddress', l_address_line) ||
                                    case when l_xml is null then null
                                         else l_xml.GetStringVal()
                                    end ||
                                '</DodPar>');

        return l_clob;
    end;

    procedure link_payment_to_document(
        p_payment_id in integer,
        p_document_id in integer)
    is
    begin
        insert into sto_payment_document_link
        values (p_payment_id, p_document_id);
    end;

    procedure ipay_doc_pc (
      p_tt     in oper.tt%type,
      p_vob    in oper.vob%type,
      p_dk     in oper.dk%type,
      p_sk     in oper.sk%type,
      p_nam_a  in oper.nam_a%type,
      p_nlsa   in oper.nlsa%type,
      p_mfoa   in oper.mfoa%type,
      p_id_a   in oper.id_a%type,
      p_nam_b  in oper.nam_b%type,
      p_nlsb   in oper.nlsb%type,
      p_mfob   in oper.mfob%type,
      p_id_b   in oper.id_b%type,
      p_kv     in oper.kv%type,
      p_s      in oper.s%type,
      p_kv2    in oper.kv2%type,
      p_s2     in oper.s2%type,
      p_nazn   in oper.nazn%type,
      p_ref    out number )
    is
      l_bdate  date;
      l_mfo    varchar2(6);
      l_ref    number;
      l_flag   number;
      l_sos    integer;
    begin

      l_bdate := gl.bdate;
      l_mfo   := gl.amfo;

      select nvl(min(value),1) into l_flag from tts_flags where tt = p_tt and fcode = 37;

      gl.ref (l_ref);

      gl.in_doc3 (ref_    => l_ref,
                  tt_     => p_tt,
                  vob_    => p_vob,
                  nd_     => to_char(l_ref),
                  pdat_   => sysdate,
                  vdat_   => l_bdate,
                  dk_     => p_dk,
                  kv_     => p_kv,
                  s_      => p_s * 100,
                  kv2_    => p_kv2,
                  s2_     => p_s2 * 100,
                  sk_     => p_sk,
                  data_   => l_bdate,
                  datp_   => l_bdate,
                  nam_a_  => substr(p_nam_a, 1, 38),
                  nlsa_   => p_nlsa,
                  mfoa_   => nvl(p_mfoa,l_mfo),
                  nam_b_  => substr(p_nam_b, 1, 38),
                  nlsb_   => p_nlsb,
                  mfob_   => nvl(p_mfob,l_mfo),
                  nazn_   => substr(p_nazn, 1, 160),
                  d_rec_  => null,
                  id_a_   => p_id_a,
                  id_b_   => p_id_b,
                  id_o_   => null,
                  sign_   => null,
                  sos_    => null,
                  prty_   => 0,
                  uid_    => user_id);

      gl.dyntt2(sos_   => l_sos,
                mod1_  => sto_payment_utl.DOCUMENT_STATE_PLAN,
                mod2_  => null,
                ref_   => l_ref,
                vdat1_ => l_bdate,
                vdat2_ => null,
                tt0_   => p_tt,
                dk_    => p_dk,
                kva_   => p_kv,
                mfoa_  => p_mfoa,
                nlsa_  => p_nlsa,
                sa_    => p_s * 100,
                kvb_   => p_kv,
                mfob_  => p_mfob,
                nlsb_  => p_nlsb,
                sb_    => p_s * 100,
                sq_    => p_s * 100,
                nom_   => null);
/*
      paytt ( flg_ => null,
              ref_ => l_ref,
             datv_ => l_bdate,
               tt_ => p_tt,
              dk0_ => p_dk,
              kva_ => p_kv,
             nls1_ => p_nlsa,
               sa_ => p_s * 100,
              kvb_ => p_kv2,
             nls2_ => p_nlsb,
               sb_ => p_s2 * 100);
*/
        p_ref := l_ref;
    end ipay_doc_pc;

    procedure pay_off_order_amount(p_payment_id in integer)
    is
        l_payment_row sto_payment%rowtype;
        l_order_row sto_order%rowtype;
        l_account_row accounts%rowtype;
        l_customer_row customer%rowtype;
        l_transit_account_row accounts%rowtype;
        l_payment_amount number;
        l_ref integer;
        l_transit_account_number varchar2(30 char);
    begin
        l_payment_row := read_payment(p_payment_id, p_lock => true);
        l_payment_amount := nvl(l_payment_row.payment_amount, 0) + nvl(l_payment_row.fee_amount, 0);

        if (l_payment_amount > 0) then
            l_order_row := sto_utl.read_order(l_payment_row.order_id);
            l_account_row := account_utl.read_account(l_order_row.payer_account_id, p_lock => true);
            if (l_account_row.dazs is null or l_account_row.dazs >=gl.bDATE)then
                  l_customer_row := customer_utl.read_customer(l_account_row.rnk);
                  l_transit_account_number := branch_attribute_utl.get_value(sys_context('BARS_CONTEXT', 'USER_BRANCH'), sto_payment_utl.TRANS_ACCOUNT_PARAMETER);
                  l_transit_account_row := account_utl.read_account(l_transit_account_number, l_account_row.kv, p_lock => true);
                  -- документ Дт         : l_account_row.nls
                  --          Кт         : l_provider_row.transit_account
                  --          Сумма      : l_payment_row.payment_amount + l_payment_row.fee_amount
                  --          Назначение : l_payment_row.purpose
                  ipay_doc_pc (p_tt    => 'ST1',
                               p_vob   => 6,
                               p_dk    => 1,
                               p_sk    => null,
                               p_nam_a => substr(l_customer_row.nmk, 1, 38),
                               p_nlsa  => l_account_row.nls,
                               p_mfoa  => gl.amfo,
                               p_id_a  => l_customer_row.okpo,
                               p_nam_b => l_transit_account_row.nms,
                               p_nlsb  => l_transit_account_row.nls,
                               p_mfob  => gl.amfo,
                               p_id_b  => f_ourokpo,
                               p_kv    => l_account_row.kv,
                               p_s     => l_payment_amount,
                               p_kv2   => l_account_row.kv,
                               p_s2    => l_payment_amount,
                               p_nazn  => l_payment_row.purpose,
                               p_ref   => l_ref);

                  update sto_payment p
                  set    p.state = sto_payment_utl.STO_PM_STATE_WITHDR_IN_PROGRES
                  where  p.id = p_payment_id;

                  link_payment_to_document(p_payment_id, l_ref);

                  track_payment_state(p_payment_id, sto_payment_utl.STO_PM_STATE_WITHDR_IN_PROGRES, 'Документ на оплату сформований - ідентифікатор документа : ' || l_ref);
            else
                  update sto_payment p
                     set p.state = sto_payment_utl.STO_PM_STATE_DECLINED_BY_BARS
                   where p.id = p_payment_id;

                   track_payment_state(p_payment_id, sto_payment_utl.STO_PM_STATE_DECLINED_BY_BARS, 'Документ на оплату не сформований - Рахунок закритий : ' ||  l_account_row.nls);
            end if;
        else
            update sto_payment p
            set    p.state = sto_payment_utl.STO_PM_STATE_DECLINED_BY_BARS
            where  p.id = p_payment_id;

            track_payment_state(p_payment_id, sto_payment_utl.STO_PM_STATE_DECLINED_BY_BARS, 'Сума платежу повинна бути більше 0');
        end if;
    end;

  function get_mfo_parameter(
        p_parameter_name in varchar2,
        p_kf in varchar2)
    return varchar2
    is
        l_value params$base.val%type;
    begin
        select p.val
        into   l_value
        from   params$base p
        where  p.par = p_parameter_name and
               p.kf = p_kf;

        return l_value;
    exception
        when no_data_found then
             return null;
    end;

    procedure pay_off_order_amounts(
        p_start_id in varchar2,
        p_end_id in varchar2)
    is
        l_bank_date date;
        l_sbon_user_id integer;
        l_sbon_user_name varchar2(300 char);
    begin
        bars_audit.trace('sto_payment_utl.pay_off_order_amounts' || chr(10) ||
                         'user_id      : ' || user_id || chr(10) ||
                         'session_user : ' || sys_context('USERENV', 'SESSION_USER'));

        l_sbon_user_name := get_mfo_parameter('STO_USER', p_start_id);

        begin
            select id
            into   l_sbon_user_id
            from   staff$base t
            where  t.logname = l_sbon_user_name;
        exception
            when no_data_found then
                 raise_application_error(-20000, 'Технологічний користувач СБОН з логіном {' || l_sbon_user_name || '} не знайдений');
        end;

        bars_login.login_user(sys_guid(), l_sbon_user_id, '', '');
        l_bank_date := bankdate();

        for i in (select * from sto_payment p
                  where  p.state = sto_payment_utl.STO_PM_STATE_READY_TO_WITHDRAW and
                         p.value_date <= l_bank_date and
                         exists (select 1
                                 from   sto_order o
                                 where  o.id = p.order_id and
                                        (o.stop_date is null or o.stop_date >= l_bank_date) and
                                        o.cancel_date is null and
                                        o.order_type_id not in (sto_utl.STO_TYPE_SEP_PAYMENT))
                  order by p.id) loop
            begin
                savepoint before_document;
            pay_off_order_amount(i.id);
            exception
                 when others then
                      rollback to before_document;
                      bars_audit.error('sto_payment_utl.pay_off_order_amounts' || chr(10) ||
                                       sqlerrm || chr(10) || dbms_utility.format_error_backtrace());
                      track_payment_state(i.id, sto_payment_utl.STO_PM_STATE_PROCESS_ERROR, substrb(sqlerrm || chr(10) || dbms_utility.format_error_backtrace(), 1, 4000));

                      if (get_payment_errors_count(i.id) >= 3) then
                          set_payment_state(i.id, sto_payment_utl.STO_PM_STATE_PROCESS_ERROR, substrb(sqlerrm || chr(10) || dbms_utility.format_error_backtrace(), 1, 4000));
                      end if;

            end;

        end loop;

        bars_login.logout_user();
    end;

    procedure pay_off_order_amounts
    is
        l_bank_date date := gl.bDATE;
		l_sbon_user_id staff$base.id%type;
    begin
        bars_audit.trace('sto_payment_utl.pay_off_order_amounts' || chr(10) ||
                         'user_id      : ' || user_id || chr(10) ||
                         'session_user : ' || sys_context('USERENV', 'SESSION_USER'));
						 
        for rec in (select kf from mv_kf)
		loop
			begin
				select id
				into   l_sbon_user_id
				from   staff$base t
				where  t.logname = branch_attribute_utl.get_value('/'||rec.kf||'/', 'STO_USER');
			exception
				when no_data_found then
					 raise_application_error(-20000, 'Технологічний користувач СБОН з логіном {' || branch_attribute_utl.get_value('/'||rec.kf||'/', 'STO_USER') || '} не знайдений');
			end;
			bars_login.login_user(sys_guid(), l_sbon_user_id, '', '');	
			
			bars_audit.info('sto_payment_utl.pay_off_order_amounts' || chr(10) ||
							 'user_id      : ' || user_id || chr(10) ||
							 'session_user : ' || sys_context('USERENV', 'SESSION_USER'));			
		
			for i in (select * from sto_payment p
					  where  p.state = sto_payment_utl.STO_PM_STATE_READY_TO_WITHDRAW and
							 p.value_date <= l_bank_date and
							 exists (select 1
									 from   sto_order o
									 where  o.id = p.order_id and
											(o.stop_date is null or o.stop_date >= l_bank_date) and
											o.cancel_date is null and
											o.order_type_id not in (sto_utl.STO_TYPE_SEP_PAYMENT))
					  order by p.id) loop
				pay_off_order_amount(i.id);
			end loop;
			bars_login.logout_user;
		end loop;
    end;

    procedure complete_payments_withdrawal
    is
    begin
        update sto_payment p
        set    p.state = sto_payment_utl.STO_PM_STATE_WITHDRAWN_IN_BARS
        where  p.state = sto_payment_utl.STO_PM_STATE_WITHDR_IN_PROGRES and
               exists (select 1
                       from   sto_payment_document_link l
                       where  l.payment_id = p.id and
                              exists (select 1
                                      from   oper o
                                      where  o.ref = l.document_id and
                                             o.sos = sto_payment_utl.DOCUMENT_STATE_COMPLETED));
    end;
end;
/
show err;

grant debug, execute on sto_payment_utl to bars_access_defrole;
