
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/CDB/package/cdb_dispatcher.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE CDB.CDB_DISPATCHER is

    -- типи операцій
    ET_OPERATION_TYPE              constant integer := 301;
    OPT_REGISTER_NEW_DEAL          constant integer := 1;
    OPT_CHANGE_AMOUNT              constant integer := 2;
    OPT_CHANGE_INTEREST_RATE       constant integer := 3;
    OPT_CHANGE_EXPIRY_DATE         constant integer := 4;
    OPT_CLOSE_DEAL                 constant integer := 5;

    -- статуси операцій
    ET_OPEATION_STATE              constant integer := 302;
    OPERATION_STATE_NEW            constant integer := 1;
    OPERATION_STATE_WAIT           constant integer := 2;
    OPERATION_STATE_INVALID        constant integer := 3;
    OPERATION_STATE_COMPLETED      constant integer := 4;
    OPERATION_STATE_CANCELED       constant integer := 5;
    OPERATION_STATE_PART_COMPLETED constant integer := 7;

    ATTR_KIND_EXPIRY_DATE          constant integer := 1;
    ATTR_KIND_CLOSE_DATE           constant integer := 2;
    ATTR_KIND_AMOUNT               constant integer := 3;
    ATTR_KIND_INTEREST_RATE        constant integer := 4;
    ATTR_KIND_BASE_YEAR            constant integer := 5;

    INTEREST_KIND_ASSETS           constant integer := 0;
    INTEREST_KIND_LIABILITIES      constant integer := 1;

    procedure set_operation_state(
        p_operation_id in integer,
        p_state in integer);

    procedure perform_claim_checks(
        p_claim_id in integer,
        p_claim_type in integer);

    procedure process_claim(
        p_claim_id in integer,
        p_claim_type in integer);

    procedure process_claims;

    procedure process_new_deal_claim(p_claim_id in integer);
end;
/
CREATE OR REPLACE PACKAGE BODY CDB.CDB_DISPATCHER as

    function read_operation(
        p_operation_id in integer,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return operation%rowtype
    is
        l_operation_row operation%rowtype;
    begin
        if (p_lock) then
            select *
            into   l_operation_row
            from   operation o
            where  o.id = p_operation_id
            for update;
        else
            select *
            into   l_operation_row
            from   operation o
            where  o.id = p_operation_id;
        end if;

        return l_operation_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                raise_application_error(cdb_exception.NO_DATA_FOUND, 'Операція з ідентифікатором {' || p_operation_id || '} не знайдена');
             else return null;
             end if;
    end;

    function create_operation(
        p_deal_id in integer,
        p_operation_type in integer,
        p_claim_id in integer)
    return integer
    is
        l_operation_id integer;
    begin
        insert into operation
        values (operation_seq.nextval, p_deal_id, p_operation_type, p_claim_id, cdb_dispatcher.OPERATION_STATE_NEW, sysdate)
        returning id into l_operation_id;

        return l_operation_id;
    end;

    procedure set_operation_state(p_operation_id in integer, p_state in integer)
    is
        l_operation_row operation%rowtype;
    begin
        l_operation_row := read_operation(p_operation_id, p_lock => true);

        update operation o
        set    o.state = p_state
        where  o.id = p_operation_id;

        if (p_state = cdb_dispatcher.OPERATION_STATE_COMPLETED) then
            cdb_claim.set_claim_state_completed(l_operation_row.claim_id);
        elsif (p_state = cdb_dispatcher.OPERATION_STATE_CANCELED) then
            cdb_claim.set_claim_state_canceled(l_operation_row.claim_id, 'Всі дочірні транзакції відхилено - заявка відхиляється');
        elsif (p_state = cdb_dispatcher.OPERATION_STATE_PART_COMPLETED) then
            cdb_claim.set_claim_state_part_completed(l_operation_row.claim_id, 'Обробку завершено - деякі транзакції були відхилені');
        end if;
    end;

    procedure check_new_deal_claim(p_claim_id in integer)
    is
        pragma autonomous_transaction;
        l_claim_row claim%rowtype;
        l_new_deal_claim_row claim_new_deal%rowtype;
        l_deal_row deal%rowtype;
    begin
        l_claim_row := cdb_claim.read_claim(p_claim_id, p_lock => true);

        if (l_claim_row.state not in (cdb_claim.CLAIM_STATE_NEW, cdb_claim.CLAIM_STATE_CHECK_FAILED, cdb_claim.CLAIM_STATE_WAIT_FOR_BARS)) then
            rollback;
            return;
        end if;

        l_new_deal_claim_row := cdb_claim.read_claim_new_deal(p_claim_id);

        if (l_new_deal_claim_row.deal_number is null) then
            raise_application_error(cdb_exception.CHECK_CLAIM_EXCEPTION, 'Номер угоди не заповнений');
        elsif (l_new_deal_claim_row.open_date is null) then
            raise_application_error(cdb_exception.CHECK_CLAIM_EXCEPTION, 'Дата початку угоди не вказана');
        elsif (l_new_deal_claim_row.expiry_date is null) then
            raise_application_error(cdb_exception.CHECK_CLAIM_EXCEPTION, 'Дата завершення угоди не вказана');
        elsif (l_new_deal_claim_row.lender_code is null) then
            raise_application_error(cdb_exception.CHECK_CLAIM_EXCEPTION, 'Код МФО кредитора не вказаний');
        elsif (l_new_deal_claim_row.borrower_code is null) then
            raise_application_error(cdb_exception.CHECK_CLAIM_EXCEPTION, 'Код МФО позичальника не вказаний');
        elsif (l_new_deal_claim_row.amount is null) then
            raise_application_error(cdb_exception.CHECK_CLAIM_EXCEPTION, 'Сума угоди не вказана');
        elsif (l_new_deal_claim_row.currency_id is null) then
            raise_application_error(cdb_exception.CHECK_CLAIM_EXCEPTION, 'Валюта угоди не вказана');
        elsif (l_new_deal_claim_row.interest_rate is null) then
            raise_application_error(cdb_exception.CHECK_CLAIM_EXCEPTION, 'Відсоткова ставка угоди не вказана');
        elsif (l_new_deal_claim_row.open_date >= l_new_deal_claim_row.expiry_date) then
            raise_application_error(cdb_exception.CHECK_CLAIM_EXCEPTION, 'Дата початку угоди має бути меньшою за дату завершення');
        end if;

        l_deal_row := cdb_deal.read_deal(l_new_deal_claim_row.deal_number, l_new_deal_claim_row.currency_id, p_raise_ndf => false);
        if (l_deal_row.id is not null) then
            raise_application_error(cdb_exception.CHECK_CLAIM_EXCEPTION,
                                    'Угода з номером {' || l_new_deal_claim_row.deal_number ||
                                        '} та валютою {' || l_new_deal_claim_row.currency_id ||
                                        '} вже була зареєстрована - дата початку угоди {' || to_char(l_deal_row.open_date, 'DD.MM.YYYY') || '}');
        end if;

        tools.hide_hint(cdb_branch.read_branch(l_new_deal_claim_row.lender_code).id);
        tools.hide_hint(cdb_branch.read_branch(l_new_deal_claim_row.borrower_code).id);
        tools.hide_hint(cdb_currency.read_currency(l_new_deal_claim_row.currency_id).id);

        -- cdb_claim.set_claim_state_checked(p_claim_id);
        cdb_claim.set_claim_state_accepted(p_claim_id, 'Автоматичні перевірки пройшли успішно');

        commit;
    exception
        when others then
             logger.log('cdb_dispatcher.check_new_deal_claim', logger.LOG_LEVEL_ERROR,
                        'claim id: ' || p_claim_id || chr(10) ||
                        sqlerrm || chr(10) || dbms_utility.format_error_backtrace);
             rollback;

             cdb_claim.set_claim_state_check_failed(p_claim_id,
                                                    case when sqlcode = cdb_exception.HAVE_TO_WAIT_FOR_BARS then
                                                              cdb_claim.CLAIM_STATE_WAIT_FOR_BARS
                                                         else cdb_claim.CLAIM_STATE_CHECK_FAILED
                                                    end,
                                                    sqlerrm,
                                                    dbms_utility.format_error_backtrace());
             commit;
    end;

    procedure check_change_amount_claim(p_claim_id in integer)
    is
        pragma autonomous_transaction;
        l_claim_row claim%rowtype;
        l_change_amount_claim_row claim_change_amount%rowtype;
        l_deal_row deal%rowtype;
        l_loan_id integer;
        l_deposit_id integer;
        l_loan_object_row bars_object%rowtype;
        l_deposit_object_row bars_object%rowtype;
        -- l_loan_deal_amount number;
        -- l_deposit_deal_amount number;
    begin
        l_claim_row := cdb_claim.read_claim(p_claim_id, p_lock => true);

        if (l_claim_row.state not in (cdb_claim.CLAIM_STATE_NEW, cdb_claim.CLAIM_STATE_CHECK_FAILED, cdb_claim.CLAIM_STATE_WAIT_FOR_BARS)) then
            rollback;
            return;
        end if;

        l_change_amount_claim_row := cdb_claim.read_claim_change_amount(p_claim_id);

        if (l_change_amount_claim_row.deal_number is null) then
            raise_application_error(cdb_exception.CHECK_CLAIM_EXCEPTION, 'Номер угоди не заповнений');
        end if;
        if (l_change_amount_claim_row.new_deal_amount is null) then
            raise_application_error(cdb_exception.CHECK_CLAIM_EXCEPTION, 'Нова сумма угоди не вказана');
        end if;

        l_deal_row := cdb_deal.read_deal(l_change_amount_claim_row.deal_number, l_change_amount_claim_row.currency_id);
        l_loan_id := cdb_bars_object.get_deal_loan_id(l_deal_row.id);
        l_deposit_id := cdb_bars_object.get_deal_deposit_id(l_deal_row.id);

        l_loan_object_row := cdb_bars_object.read_bars_object(l_loan_id);
        l_deposit_object_row := cdb_bars_object.read_bars_object(l_deposit_id);

        if (l_loan_object_row.bars_object_id is null) then
            raise_application_error(cdb_exception.GENERAL_EXCEPTION,
                                    'Ідентифікатор кредитної угоди в АБС не визначений для номера угоди {' || l_deal_row.deal_number ||
                                    '} та філії {' || cdb_branch.get_branch_name(l_loan_object_row.branch_id) || '}');
        end if;

        if (l_deposit_object_row.bars_object_id is null) then
            raise_application_error(cdb_exception.GENERAL_EXCEPTION,
                                    'Ідентифікатор депозитної угоди в АБС не визначений для номера угоди {' || l_deal_row.deal_number ||
                                    '} та філії {' || cdb_branch.get_branch_name(l_deposit_object_row.branch_id) || '}');
        end if;
/*
        l_loan_deal_amount := cdb_bars_client.get_deal_amount(l_loan_object_row.branch_id, l_loan_object_row.bars_object_id);
        l_deposit_deal_amount := cdb_bars_client.get_deal_amount(l_deposit_object_row.branch_id, l_deposit_object_row.bars_object_id);
        if (l_loan_deal_amount <> l_deposit_deal_amount) then
            raise_application_error(cdb_exception.HAVE_TO_WAIT_FOR_BARS,
                                    'Сума кредитної частини угоди в АБС {' || l_loan_deal_amount ||
                                    '} не співпадає з сумою депозитної частини угоди {' || l_deposit_deal_amount || '}');
        end if;
        if (l_loan_deal_amount <> l_deal_row.amount) then
            raise_application_error(cdb_exception.HAVE_TO_WAIT_FOR_BARS,
                                    'Сума угоди в АБС {' || l_loan_deal_amount ||
                                    '} не співпадає з сумою угоди в ЦБД {' || l_deal_row.amount || '}');
        end if;
*/
        -- cdb_claim.set_claim_state_checked(p_claim_id);
        cdb_claim.set_claim_state_accepted(p_claim_id, 'Автоматичні перевірки пройшли успішно');

        commit;
    exception
        when others then
             logger.log('cdb_dispatcher.check_change_amount_claim', logger.LOG_LEVEL_ERROR,
                        'claim id: ' || p_claim_id || chr(10) ||
                        sqlerrm || chr(10) || dbms_utility.format_error_backtrace);
             rollback;

             cdb_claim.set_claim_state_check_failed(p_claim_id,
                                                    case when sqlcode = cdb_exception.HAVE_TO_WAIT_FOR_BARS then
                                                              cdb_claim.CLAIM_STATE_WAIT_FOR_BARS
                                                         else cdb_claim.CLAIM_STATE_CHECK_FAILED
                                                    end,
                                                    sqlerrm,
                                                    dbms_utility.format_error_backtrace());
             commit;
    end;

    procedure check_change_int_rate_claim(p_claim_id in integer)
    is
        pragma autonomous_transaction;
        l_claim_row claim%rowtype;
        l_change_int_rate_claim_row claim_change_interest_rate%rowtype;
        l_deal_row deal%rowtype;
        l_loan_id integer;
        l_deposit_id integer;
        l_loan_object_row bars_object%rowtype;
        l_deposit_object_row bars_object%rowtype;
        -- l_interest_rates t_date_number_pairs;
    begin
        l_claim_row := cdb_claim.read_claim(p_claim_id, true);

        if (l_claim_row.state not in (cdb_claim.CLAIM_STATE_NEW, cdb_claim.CLAIM_STATE_CHECK_FAILED, cdb_claim.CLAIM_STATE_WAIT_FOR_BARS)) then
            rollback;
            return;
        end if;

        l_change_int_rate_claim_row := cdb_claim.read_claim_change_int_rate(p_claim_id);

        if (l_change_int_rate_claim_row.deal_number is null) then
            raise_application_error(cdb_exception.CHECK_CLAIM_EXCEPTION, 'Номер угоди не заповнений');
        end if;
        if (l_change_int_rate_claim_row.interest_rate_date is null) then
            raise_application_error(cdb_exception.CHECK_CLAIM_EXCEPTION, 'Дата початку дії ставки не заповнена');
        end if;

        l_deal_row := cdb_deal.read_deal(l_change_int_rate_claim_row.deal_number, l_change_int_rate_claim_row.currency_id);
        l_loan_id := cdb_bars_object.get_deal_loan_id(l_deal_row.id);
        l_deposit_id := cdb_bars_object.get_deal_deposit_id(l_deal_row.id);

        l_loan_object_row := cdb_bars_object.read_bars_object(l_loan_id);
        l_deposit_object_row := cdb_bars_object.read_bars_object(l_deposit_id);

        if (l_loan_object_row.bars_object_id is null) then
            raise_application_error(cdb_exception.GENERAL_EXCEPTION,
                                    'Ідентифікатор кредитної угоди в АБС не визначений для номера угоди {' || l_deal_row.deal_number ||
                                    '} та філії {' || cdb_branch.get_branch_name(l_loan_object_row.branch_id) || '}');
        end if;

        if (l_deposit_object_row.bars_object_id is null) then
            raise_application_error(cdb_exception.GENERAL_EXCEPTION,
                                    'Ідентифікатор депозитної угоди в АБС не визначений для номера угоди {' || l_deal_row.deal_number ||
                                    '} та філії {' || cdb_branch.get_branch_name(l_deposit_object_row.branch_id) || '}');
        end if;

        -- перевіримо співпадіння налаштувань ставок кредитора, позичальника та ЦБД
        -- l_interest_rates := cdb_deal.get_deal_interest_rates(l_deal_row.id, cdb_deal.RATE_KIND_MAIN);

    /*    cdb_bars_client.check_deal_interest_rate(l_loan_object_row.branch_id,
                                                 l_loan_object_row.bars_object_id,
                                                 cdb_dispatcher.INTEREST_KIND_ASSETS,
                                                 l_interest_rates);

        cdb_bars_client.check_deal_interest_rate(l_deposit_object_row.branch_id,
                                                 l_deposit_object_row.bars_object_id,
                                                 cdb_dispatcher.INTEREST_KIND_LIABILITIES,
                                                 l_interest_rates);*/

        -- cdb_claim.set_claim_state_checked(p_claim_id);
        cdb_claim.set_claim_state_accepted(p_claim_id, 'Автоматичні перевірки пройшли успішно');

        commit;
    exception
        when others then
             logger.log('cdb_dispatcher.check_change_int_rate_claim', logger.LOG_LEVEL_ERROR,
                        'claim id: ' || p_claim_id || chr(10) ||
                        sqlerrm || chr(10) || dbms_utility.format_error_backtrace);
             rollback;

             cdb_claim.set_claim_state_check_failed(p_claim_id,
                                                    case when sqlcode = cdb_exception.HAVE_TO_WAIT_FOR_BARS then
                                                              cdb_claim.CLAIM_STATE_WAIT_FOR_BARS
                                                         else cdb_claim.CLAIM_STATE_CHECK_FAILED
                                                    end,
                                                    sqlerrm,
                                                    dbms_utility.format_error_backtrace());
             commit;
    end;

    procedure check_change_exp_date_claim(p_claim_id in integer)
    is
        pragma autonomous_transaction;
        l_claim_row claim%rowtype;
        l_change_exp_date_claim_row claim_change_expiry_date%rowtype;
        l_deal_row deal%rowtype;
        l_loan_id integer;
        l_deposit_id integer;
        l_loan_object_row bars_object%rowtype;
        l_deposit_object_row bars_object%rowtype;
        -- l_loan_expiry_date date;
        -- l_deposit_expiry_date date;
    begin
        l_claim_row := cdb_claim.read_claim(p_claim_id, p_lock => true);

        if (l_claim_row.state not in (cdb_claim.CLAIM_STATE_NEW, cdb_claim.CLAIM_STATE_CHECK_FAILED, cdb_claim.CLAIM_STATE_WAIT_FOR_BARS)) then
            rollback;
            return;
        end if;

        l_change_exp_date_claim_row := cdb_claim.read_claim_change_exp_date(p_claim_id);

        if (l_change_exp_date_claim_row.deal_number is null) then
            raise_application_error(cdb_exception.CHECK_CLAIM_EXCEPTION, 'Номер угоди не заповнений');
        end if;
        if (l_change_exp_date_claim_row.expiry_date is null) then
            raise_application_error(cdb_exception.CHECK_CLAIM_EXCEPTION, 'Дата завершення дії угоди не заповнена');
        end if;

        l_deal_row := cdb_deal.read_deal(l_change_exp_date_claim_row.deal_number, l_change_exp_date_claim_row.currency_id);
        l_loan_id := cdb_bars_object.get_deal_loan_id(l_deal_row.id);
        l_deposit_id := cdb_bars_object.get_deal_deposit_id(l_deal_row.id);

        l_loan_object_row := cdb_bars_object.read_bars_object(l_loan_id);
        l_deposit_object_row := cdb_bars_object.read_bars_object(l_deposit_id);

        if (l_loan_object_row.bars_object_id is null) then
            raise_application_error(cdb_exception.GENERAL_EXCEPTION,
                                    'Ідентифікатор кредитної угоди в АБС не визначений для номера угоди {' || l_deal_row.deal_number ||
                                    '} та філії {' || cdb_branch.get_branch_name(l_loan_object_row.branch_id) || '}');
        end if;

        if (l_deposit_object_row.bars_object_id is null) then
            raise_application_error(cdb_exception.GENERAL_EXCEPTION,
                                    'Ідентифікатор депозитної угоди в АБС не визначений для номера угоди {' || l_deal_row.deal_number ||
                                    '} та філії {' || cdb_branch.get_branch_name(l_deposit_object_row.branch_id) || '}');
        end if;

        -- перевіримо співпадіння налаштувань ставок кредитора, позичальника та ЦБД
        /*
        l_loan_expiry_date := cdb_bars_client.get_deal_expiry_date(l_loan_object_row.branch_id, l_loan_object_row.bars_object_id);
        l_deposit_expiry_date := cdb_bars_client.get_deal_expiry_date(l_deposit_object_row.branch_id, l_deposit_object_row.bars_object_id);

        if (l_loan_expiry_date <> l_deposit_expiry_date) then
            raise_application_error(cdb_exception.HAVE_TO_WAIT_FOR_BARS,
                                    'Дата завершення кредитної частини угоди {' || to_char(l_loan_expiry_date, 'DD.MM.YYYY') ||
                                    '} не співпадає з датою завершення депозитної частини угоди {' || to_char(l_deposit_expiry_date, 'DD.MM.YYYY') || '}');
        end if;
        */
        -- cdb_claim.set_claim_state_checked(p_claim_id);
        cdb_claim.set_claim_state_accepted(p_claim_id, 'Автоматичні перевірки пройшли успішно');

        commit;
    exception
        when others then
             logger.log('cdb_dispatcher.check_change_exp_date_claim', logger.LOG_LEVEL_ERROR,
                        'claim id: ' || p_claim_id || chr(10) ||
                        sqlerrm || chr(10) || dbms_utility.format_error_backtrace);
             rollback;

             cdb_claim.set_claim_state_check_failed(p_claim_id,
                                                    case when sqlcode = cdb_exception.HAVE_TO_WAIT_FOR_BARS then
                                                              cdb_claim.CLAIM_STATE_WAIT_FOR_BARS
                                                         else cdb_claim.CLAIM_STATE_CHECK_FAILED
                                                    end,
                                                    sqlerrm,
                                                    dbms_utility.format_error_backtrace());
             commit;
    end;

    procedure check_close_deal_claim(p_claim_id in integer)
    is
        pragma autonomous_transaction;
        l_claim_row claim%rowtype;
        l_close_deal_claim_row claim_close_deal%rowtype;
        l_deal_row deal%rowtype;
        l_loan_id integer;
        l_deposit_id integer;
        l_loan_object_row bars_object%rowtype;
        l_deposit_object_row bars_object%rowtype;
        l_loan_row bars_deal%rowtype;
        l_deposit_row bars_deal%rowtype;

        l_lender_main_account_row bars_account%rowtype;
        -- l_lender_interest_account_row bars_account%rowtype;
        l_borrow_main_account_row bars_account%rowtype;
        -- l_borrow_interest_account_row bars_account%rowtype;

        l_loan_rest number;
        l_deposit_rest number;
        -- l_loan_interest_rest number;
        -- l_deposit_interest_rest number;
    begin
        l_claim_row := cdb_claim.read_claim(p_claim_id, p_lock => true);

        if (l_claim_row.state not in (cdb_claim.CLAIM_STATE_NEW, cdb_claim.CLAIM_STATE_CHECK_FAILED, cdb_claim.CLAIM_STATE_WAIT_FOR_BARS)) then
            rollback;
            return;
        end if;

        l_close_deal_claim_row := cdb_claim.read_claim_close_deal(p_claim_id);

        if (l_close_deal_claim_row.deal_number is null) then
            raise_application_error(cdb_exception.CHECK_CLAIM_EXCEPTION, 'Номер угоди не заповнений');
        end if;

        l_deal_row := cdb_deal.read_deal(l_close_deal_claim_row.deal_number, l_close_deal_claim_row.currency_id);

        l_loan_id := cdb_bars_object.get_deal_loan_id(l_deal_row.id);
        l_deposit_id := cdb_bars_object.get_deal_deposit_id(l_deal_row.id);

        l_loan_object_row := cdb_bars_object.read_bars_object(l_loan_id);
        l_deposit_object_row := cdb_bars_object.read_bars_object(l_deposit_id);

        if (l_loan_object_row.bars_object_id is null) then
            raise_application_error(cdb_exception.GENERAL_EXCEPTION,
                                    'Ідентифікатор кредитної угоди в АБС не визначений для номера угоди {' || l_deal_row.deal_number ||
                                    '} та філії {' || cdb_branch.get_branch_name(l_loan_object_row.branch_id) || '}');
        end if;

        if (l_deposit_object_row.bars_object_id is null) then
            raise_application_error(cdb_exception.GENERAL_EXCEPTION,
                                    'Ідентифікатор депозитної угоди в АБС не визначений для номера угоди {' || l_deal_row.deal_number ||
                                    '} та філії {' || cdb_branch.get_branch_name(l_deposit_object_row.branch_id) || '}');
        end if;
/*
        -- відміняємо перевірку процентів, оскільки це призводить до затримок в процесі роботи та в деяких випадках
        -- має виконуватися в ручному режимі без прив'язки до погашення основної суми
        cdb_bars_client.check_deal_before_close(l_deal_row.lender_id, l_loan_object_row.bars_object_id);
        cdb_bars_client.check_deal_before_close(l_deal_row.borrower_id, l_deposit_object_row.bars_object_id);
*/
        l_loan_row := cdb_bars_object.read_bars_deal(l_loan_id);
        l_deposit_row := cdb_bars_object.read_bars_deal(l_deposit_id);

        l_lender_main_account_row := cdb_bars_object.read_bars_account(l_loan_row.main_account_id);
        -- l_lender_interest_account_row := cdb_bars_object.read_bars_account(l_loan_row.interest_account_id);
        l_borrow_main_account_row := cdb_bars_object.read_bars_account(l_deposit_row.main_account_id);
        -- l_borrow_interest_account_row := cdb_bars_object.read_bars_account(l_deposit_row.interest_account_id);

        l_loan_rest := abs(cdb_bars_client.get_account_rest(l_deal_row.lender_id,
                                                            l_lender_main_account_row.account_number,
                                                            l_deal_row.currency_id)) / 100;

        l_deposit_rest := abs(cdb_bars_client.get_account_rest(l_deal_row.borrower_id,
                                                               l_borrow_main_account_row.account_number,
                                                               l_deal_row.currency_id)) / 100;

        if (l_loan_rest <> l_deposit_rest) then
            raise_application_error(cdb_exception.HAVE_TO_WAIT_FOR_BARS,
                                    'Кредитний залишок ' || l_loan_rest ||
                                    ' угоди ' || l_deal_row.deal_number ||
                                    ' не співпадає з депозитним залишком ' || l_deposit_rest);
        end if;
/*
        l_loan_interest_rest := abs(cdb_bars_client.get_account_rest(l_deal_row.lender_id,
                                                                     l_lender_interest_account_row.account_number,
                                                                     l_deal_row.currency_id)) / 100;

        l_deposit_interest_rest := abs(cdb_bars_client.get_account_rest(l_deal_row.borrower_id,
                                                                        l_borrow_interest_account_row.account_number,
                                                                        l_deal_row.currency_id)) / 100;
        if (l_loan_interest_rest <> l_deposit_interest_rest) then
            raise_application_error(cdb_exception.HAVE_TO_WAIT_FOR_BARS,
                                    'Залишок відсотків ' || l_loan_interest_rest ||
                                    ' за кредитною угодою ' || l_deal_row.deal_number ||
                                    ' не співпадає з залишком відсотків за депозитом ' || l_deposit_interest_rest);
        end if;
*/
        -- cdb_claim.set_claim_state_checked(p_claim_id);
        cdb_claim.set_claim_state_accepted(p_claim_id, 'Автоматичні перевірки пройшли успішно');

        commit;
    exception
        when others then
             logger.log('cdb_dispatcher.check_close_deal_claim', logger.LOG_LEVEL_ERROR,
                        'claim id: ' || p_claim_id || chr(10) ||
                        sqlerrm || chr(10) || dbms_utility.format_error_backtrace);
             rollback;

             cdb_claim.set_claim_state_check_failed(p_claim_id,
                                                    case when sqlcode = cdb_exception.HAVE_TO_WAIT_FOR_BARS then
                                                              cdb_claim.CLAIM_STATE_WAIT_FOR_BARS
                                                         else cdb_claim.CLAIM_STATE_CHECK_FAILED
                                                    end,
                                                    sqlerrm,
                                                    dbms_utility.format_error_backtrace());
             commit;
    end;

    function check_new_deal_claim_queue(p_claim_id in integer)
    return boolean
    is
        l_new_deal_claims t_number_list;
    begin
        -- тільки одна заявка типу "Нова угода" може оброблятися в один момент
        -- це пов'язано з нумерацією рахунків - між моментом генераці номера рахунку та його вставкою в АБС
        -- проходить достатньо часу для того щоб інша угода в процесі обробки отримала такий самий номер рахунку...
        select c.id
        bulk collect into l_new_deal_claims
        from   claim c
        where  c.id < p_claim_id and
               c.claim_type_id = cdb_claim.CLAIM_TYPE_NEW_DEAL and
               c.state in (cdb_claim.CLAIM_STATE_CHECKED, cdb_claim.CLAIM_STATE_ACCEPTED, cdb_claim.CLAIM_STATE_PREPARED);

        return l_new_deal_claims is empty;
    end;

    function check_new_deal_claim_queue(p_claim_new_deal_row in claim_new_deal%rowtype)
    return boolean
    is
        l_new_deal_transactions t_number_list;
        l_lender_branch_id integer;
        l_borrower_branch_id integer;
    begin
        -- тільки одна заявка типу "Нова угода" може оброблятися в один момент
        -- це пов'язано з нумерацією рахунків - між моментом генераці номера рахунку та його вставкою в АБС
        -- проходить достатньо часу для того щоб інша угода в процесі обробки отримала такий самий номер рахунку...
        l_lender_branch_id := cdb_branch.get_branch_id(p_claim_new_deal_row.lender_code);
        l_borrower_branch_id := cdb_branch.get_branch_id(p_claim_new_deal_row.borrower_code);

        select t.id
        bulk collect into l_new_deal_transactions
        from   bars_transaction t
        where  t.transaction_type in (cdb_bars_client.TRAN_TYPE_BARS_DEAL, cdb_bars_client.TRAN_TYPE_BARS_ACCOUNT) and
               t.state in (cdb_bars_client.TRAN_STATE_NEW, cdb_bars_client.TRAN_STATE_INVALID, cdb_bars_client.TRAN_STATE_WAIT_FOR_BARS) and
               exists (select 1
                       from   bars_object bo
                       where  bo.id = t.object_id and
                              bo.branch_id in (l_lender_branch_id, l_borrower_branch_id));

        return l_new_deal_transactions is empty;
    end;

    procedure process_new_deal_claim(p_claim_id in integer)
    is
        pragma autonomous_transaction;
        l_claim_row claim%rowtype;
        l_claim_new_deal_row claim_new_deal%rowtype;
        l_deal_id integer;
        l_operation_id integer;
        l_deposit_id integer;
        l_loan_id integer;
        l_lender_branch_row branch%rowtype;
        l_borrower_branch_row branch%rowtype;
        l_lender_account_number varchar2(30 char);
        l_lender_interest_account varchar2(30 char);
        l_borrower_account_number varchar2(30 char);
        l_borrower_interest_account varchar2(30 char);
        l_lender_account_id integer;
        l_lender_interest_account_id integer;
        l_borrower_account_id integer;
        l_borrower_interest_account_id integer;
        l_lender_transit_account_id integer;
        l_borrower_transit_account_id integer;
        l_lending_document_id integer;
        -- l_borrowing_document_id integer;
        l_comment varchar2(4000 byte);
    begin
        l_claim_row := cdb_claim.read_claim(p_claim_id, true);

        if (l_claim_row.state not in (cdb_claim.CLAIM_STATE_CHECKED, cdb_claim.CLAIM_STATE_ACCEPTED, cdb_claim.CLAIM_STATE_INVALID)) then
            rollback;
            return;
        end if;

        l_claim_new_deal_row := cdb_claim.read_claim_new_deal(p_claim_id);

        if (not check_new_deal_claim_queue(l_claim_new_deal_row)) then
            rollback;
            return;
        end if;

        l_lender_branch_row := cdb_branch.read_branch(l_claim_new_deal_row.lender_code);
        l_borrower_branch_row := cdb_branch.read_branch(l_claim_new_deal_row.borrower_code);

        cdb_bars_client.generate_accounts(l_lender_branch_row.id,
                                          cdb_bars_object.BALANCE_ACC_LENT_FUNDS,
                                          l_claim_new_deal_row.currency_id,
                                          l_lender_account_number,
                                          l_lender_interest_account);

        cdb_bars_client.generate_accounts(l_borrower_branch_row.id,
                                          cdb_bars_object.BALANCE_ACC_BORROWED_FUNDS,
                                          l_claim_new_deal_row.currency_id,
                                          l_borrower_account_number,
                                          l_borrower_interest_account);

        cdb_bars_object.check_account_number_uniquness(l_lender_branch_row.id, l_lender_account_number, l_claim_new_deal_row.currency_id);
        cdb_bars_object.check_account_number_uniquness(l_lender_branch_row.id, l_lender_interest_account, l_claim_new_deal_row.currency_id);
        cdb_bars_object.check_account_number_uniquness(l_borrower_branch_row.id, l_borrower_account_number, l_claim_new_deal_row.currency_id);
        cdb_bars_object.check_account_number_uniquness(l_borrower_branch_row.id, l_borrower_interest_account, l_claim_new_deal_row.currency_id);

        l_deal_id := cdb_deal.create_deal(l_claim_new_deal_row.deal_number,
                                          l_lender_branch_row.id,
                                          l_borrower_branch_row.id,
                                          l_claim_new_deal_row.open_date,
                                          l_claim_new_deal_row.expiry_date,
                                          l_claim_new_deal_row.amount,
                                          l_claim_new_deal_row.currency_id,
                                          l_claim_new_deal_row.base_year);

        l_operation_id := create_operation(l_deal_id, cdb_dispatcher.OPT_REGISTER_NEW_DEAL, p_claim_id);

        cdb_deal.set_deal_interest_rate(l_deal_id, cdb_deal.RATE_KIND_MAIN, l_claim_new_deal_row.open_date, l_claim_new_deal_row.interest_rate, l_operation_id);

        cdb_attribute.create_attribute_history(l_deal_id, cdb_dispatcher.ATTR_KIND_EXPIRY_DATE  , l_claim_new_deal_row.expiry_date  , l_operation_id);
        cdb_attribute.create_attribute_history(l_deal_id, cdb_dispatcher.ATTR_KIND_AMOUNT       , l_claim_new_deal_row.amount       , l_operation_id);
        cdb_attribute.create_attribute_history(l_deal_id, cdb_dispatcher.ATTR_KIND_BASE_YEAR    , l_claim_new_deal_row.base_year    , l_operation_id);

        l_lender_account_id := cdb_bars_object.create_account(l_deal_id,
                                                              cdb_bars_object.BALANCE_ACC_LENT_FUNDS,
                                                              l_lender_account_number,
                                                              l_lender_branch_row.id);

        l_lender_interest_account_id := cdb_bars_object.create_account(l_deal_id,
                                                                       cdb_bars_object.BALANCE_ACC_LENDER_INTEREST,
                                                                       l_lender_interest_account,
                                                                       l_lender_branch_row.id);

        l_borrower_account_id := cdb_bars_object.create_account(l_deal_id,
                                                                cdb_bars_object.BALANCE_ACC_BORROWED_FUNDS,
                                                                l_borrower_account_number,
                                                                l_borrower_branch_row.id);

        l_borrower_interest_account_id := cdb_bars_object.create_account(l_deal_id,
                                                                         cdb_bars_object.BALANCE_ACC_BORROWER_INTEREST,
                                                                         l_borrower_interest_account,
                                                                         l_borrower_branch_row.id);

        l_lender_transit_account_id := cdb_branch.get_branch_transit_account(l_lender_branch_row.id, l_borrower_branch_row.id);
        l_borrower_transit_account_id := cdb_branch.get_branch_transit_account(l_borrower_branch_row.id, l_lender_branch_row.id);

        l_loan_id := cdb_bars_object.create_bars_loan(l_deal_id,
                                                      cdb_bars_client.BARS_DEAL_TYPE_LENDING,
                                                      cdb_bars_client.BARS_DEAL_KIND_LOAN,
                                                      l_lender_account_id,
                                                      l_lender_interest_account_id,
                                                      l_lender_transit_account_id,
                                                      l_lender_branch_row.id);

        l_deposit_id := cdb_bars_object.create_bars_deposit(l_deal_id,
                                                            cdb_bars_client.BARS_DEAL_TYPE_BORROWING,
                                                            cdb_bars_client.BARS_DEAL_KIND_DEPOSIT,
                                                            l_borrower_account_id,
                                                            l_borrower_interest_account_id,
                                                            l_borrower_transit_account_id,
                                                            l_borrower_branch_row.id);

        cdb_bars_object.set_deal_party(l_loan_id, l_deposit_id);
        cdb_bars_object.set_deal_party(l_deposit_id, l_loan_id);

        l_lending_document_id := cdb_bars_object.create_bars_document(l_deal_id,
                                                                      'KV7',
                                                                      1,
                                                                      l_lender_account_id,
                                                                      l_borrower_account_id,
                                                                      l_claim_new_deal_row.amount,
                                                                      l_claim_new_deal_row.currency_id,
                                                                      'Розміщення коштів згідно угоди №' || l_claim_new_deal_row.deal_number ||
                                                                          ' від ' || to_char(l_claim_new_deal_row.open_date, 'DD.MM.YYYY'),
                                                                      l_lender_branch_row.id);
/*
        l_borrowing_document_id := cdb_bars_object.create_bars_document(l_deal_id,
                                                                        'KV1',
                                                                        6,
                                                                        l_borrower_transit_account_id,
                                                                        l_borrower_account_id,
                                                                        l_claim_new_deal_row.amount,
                                                                        l_claim_new_deal_row.currency_id,
                                                                        'Залучення коштів згідно угоди №' || l_claim_new_deal_row.deal_number ||
                                                                            ' від ' || to_char(l_claim_new_deal_row.open_date, 'DD.MM.YYYY'),
                                                                        l_borrower_branch_row.id);
*/
        tools.hide_hint(cdb_bars_client.create_bars_transaction(l_deposit_id, l_operation_id, cdb_bars_client.TRAN_TYPE_BARS_DEAL, 1));
        tools.hide_hint(cdb_bars_client.create_bars_transaction(l_loan_id, l_operation_id, cdb_bars_client.TRAN_TYPE_BARS_DEAL, 1));
        tools.hide_hint(cdb_bars_client.create_bars_transaction(l_lending_document_id, l_operation_id, cdb_bars_client.TRAN_TYPE_BARS_DOCUMENT, 2));
        -- tools.hide_hint(cdb_bars_client.create_bars_transaction(l_borrowing_document_id, l_operation_id, cdb_bars_client.TRAN_TYPE_BARS_DOCUMENT, 2));

        l_comment := cdb_claim.get_claim_comment(p_claim_id);
        if (l_comment is not null) then
            tools.hide_hint(cdb_bars_client.create_deal_comment_tran(l_deposit_id, l_operation_id, 3, l_comment));
            tools.hide_hint(cdb_bars_client.create_deal_comment_tran(l_loan_id, l_operation_id, 3, l_comment));
        end if;

        cdb_claim.set_claim_state_prepared(p_claim_id);

        commit;
    exception
        when others then
             logger.log('cdb_dispatcher.process_new_deal_claim', logger.LOG_LEVEL_ERROR,
                        'claim id: ' || p_claim_id || chr(10) ||
                        sqlerrm || chr(10) || dbms_utility.format_error_backtrace);
             rollback;

             cdb_claim.set_claim_state_invalid(p_claim_id,
                                               sqlerrm,
                                               dbms_utility.format_error_backtrace());
             commit;
    end;

    procedure process_change_amount_claim(p_claim_id in integer)
    is
        pragma autonomous_transaction;
        l_claim_row claim%rowtype;
        l_change_amount_claim_row claim_change_amount%rowtype;
        l_deal_row deal%rowtype;
        l_loan_id integer;
        l_deposit_id integer;
        l_loan_deal_row bars_deal%rowtype;
        l_deposit_deal_row bars_deal%rowtype;
        l_amount_delta number;
        l_operation_id integer;
        l_sender_document_id integer;
        -- l_receiver_document_id integer;
        l_comment varchar2(4000 byte);
    begin
        l_claim_row := cdb_claim.read_claim(p_claim_id, true);

        if (l_claim_row.state not in (cdb_claim.CLAIM_STATE_CHECKED, cdb_claim.CLAIM_STATE_ACCEPTED, cdb_claim.CLAIM_STATE_INVALID)) then
            rollback;
            return;
        end if;

        l_change_amount_claim_row := cdb_claim.read_claim_change_amount(p_claim_id);

        l_deal_row := cdb_deal.read_deal(l_change_amount_claim_row.deal_number, l_change_amount_claim_row.currency_id, p_lock => true);
        l_loan_id := cdb_bars_object.get_deal_loan_id(l_deal_row.id);
        l_deposit_id := cdb_bars_object.get_deal_deposit_id(l_deal_row.id);

        l_amount_delta := l_change_amount_claim_row.new_deal_amount - l_deal_row.amount;

        l_loan_deal_row := cdb_bars_object.read_bars_deal(l_loan_id);
        l_deposit_deal_row := cdb_bars_object.read_bars_deal(l_deposit_id);

        l_operation_id := create_operation(l_deal_row.id, cdb_dispatcher.OPT_CHANGE_AMOUNT, p_claim_id);
        cdb_attribute.set_attribute_value(l_deal_row.id, cdb_dispatcher.ATTR_KIND_AMOUNT, l_change_amount_claim_row.new_deal_amount, l_operation_id);

        tools.hide_hint(cdb_bars_client.create_bars_transaction(l_loan_id, l_operation_id, cdb_bars_client.TRAN_TYPE_CHANGE_DEAL_AMOUNT, 1));
        tools.hide_hint(cdb_bars_client.create_bars_transaction(l_deposit_id, l_operation_id, cdb_bars_client.TRAN_TYPE_CHANGE_DEAL_AMOUNT, 1));

        if (l_amount_delta > 0) then
            l_sender_document_id := cdb_bars_object.create_bars_document(l_deal_row.id,
                                                                         'KV7',
                                                                         1,
                                                                         l_loan_deal_row.main_account_id,
                                                                         l_deposit_deal_row.main_account_id,
                                                                         l_amount_delta,
                                                                         l_deal_row.currency_id,
                                                                         'Додаткове розміщення суми угоди №' || l_deal_row.deal_number ||
                                                                             ' від ' || to_char(l_deal_row.open_date, 'DD.MM.YYYY'),
                                                                         l_deal_row.lender_id);
/*
            l_receiver_document_id := cdb_bars_object.create_bars_document(l_deal_row.id,
                                                                           'KV1',
                                                                           6,
                                                                           l_deposit_deal_row.transit_account_id,
                                                                           l_deposit_deal_row.main_account_id,
                                                                           l_amount_delta,
                                                                           l_deal_row.currency_id,
                                                                           'Додаткове залучення суми угоди №' || l_deal_row.deal_number ||
                                                                               ' від ' || to_char(l_deal_row.open_date, 'DD.MM.YYYY'),
                                                                           l_deal_row.borrower_id);
*/
        else
            l_sender_document_id := cdb_bars_object.create_bars_document(l_deal_row.id,
                                                                         'WD7',
                                                                         1,
                                                                         l_deposit_deal_row.main_account_id,
                                                                         l_loan_deal_row.main_account_id,
                                                                         abs(l_amount_delta),
                                                                         l_deal_row.currency_id,
                                                                         'Часткове повернення суми угоди №' || l_deal_row.deal_number,
                                                                         l_deal_row.borrower_id);
/*
            l_receiver_document_id := cdb_bars_object.create_bars_document(l_deal_row.id,
                                                                           'KV1',
                                                                           6,
                                                                           l_loan_deal_row.transit_account_id,
                                                                           l_loan_deal_row.main_account_id,
                                                                           abs(l_amount_delta),
                                                                           l_deal_row.currency_id,
                                                                           'Прийняття часткового погашення суми угоди №' || l_deal_row.deal_number,
                                                                           l_deal_row.lender_id);
*/
        end if;

        tools.hide_hint(cdb_bars_client.create_bars_transaction(l_sender_document_id, l_operation_id, cdb_bars_client.TRAN_TYPE_BARS_DOCUMENT, 2));
        -- tools.hide_hint(cdb_bars_client.create_bars_transaction(l_receiver_document_id, l_operation_id, cdb_bars_client.TRAN_TYPE_BARS_DOCUMENT, 2));

        l_comment := cdb_claim.get_claim_comment(p_claim_id);
        if (l_comment is not null) then
            tools.hide_hint(cdb_bars_client.create_deal_comment_tran(l_deposit_id, l_operation_id, 3, l_comment));
            tools.hide_hint(cdb_bars_client.create_deal_comment_tran(l_loan_id, l_operation_id, 3, l_comment));
        end if;

        cdb_claim.set_claim_state_prepared(p_claim_id);

        commit;
    exception
        when others then
             logger.log('cdb_dispatcher.process_change_amount_claim', logger.LOG_LEVEL_ERROR,
                        'claim id: ' || p_claim_id || chr(10) ||
                        sqlerrm || chr(10) || dbms_utility.format_error_backtrace);
             rollback;

             cdb_claim.set_claim_state_invalid(p_claim_id,
                                               sqlerrm,
                                               dbms_utility.format_error_backtrace());
             commit;
    end;

    procedure process_change_int_rate_claim(p_claim_id in integer)
    is
        pragma autonomous_transaction;
        l_claim_row claim%rowtype;
        l_change_int_rate_claim_row claim_change_interest_rate%rowtype;
        l_deal_row deal%rowtype;
        l_loan_id integer;
        l_deposit_id integer;
        l_loan_row bars_deal%rowtype;
        l_deposit_row bars_deal%rowtype;
        l_operation_id integer;
        l_comment varchar2(4000 byte);
    begin
        l_claim_row := cdb_claim.read_claim(p_claim_id, true);

        if (l_claim_row.state not in (cdb_claim.CLAIM_STATE_CHECKED, cdb_claim.CLAIM_STATE_ACCEPTED, cdb_claim.CLAIM_STATE_INVALID)) then
            rollback;
            return;
        end if;

        l_change_int_rate_claim_row := cdb_claim.read_claim_change_int_rate(p_claim_id);

        l_deal_row := cdb_deal.read_deal(l_change_int_rate_claim_row.deal_number, l_change_int_rate_claim_row.currency_id, p_lock => true);
        l_loan_id := cdb_bars_object.get_deal_loan_id(l_deal_row.id);
        l_deposit_id := cdb_bars_object.get_deal_deposit_id(l_deal_row.id);

        l_loan_row := cdb_bars_object.read_bars_deal(l_loan_id);
        l_deposit_row := cdb_bars_object.read_bars_deal(l_deposit_id);

        -- установимо нові ставки в ЦБД
        l_operation_id := create_operation(l_deal_row.id, cdb_dispatcher.OPT_CHANGE_INTEREST_RATE, p_claim_id);
        cdb_deal.set_deal_interest_rate(l_deal_row.id,
                                        cdb_deal.RATE_KIND_MAIN,
                                        l_change_int_rate_claim_row.interest_rate_date,
                                        l_change_int_rate_claim_row.interest_rate,
                                        l_operation_id);

        -- заплануємо зміну ставок кредитора та позичальника в АБС
        tools.hide_hint(cdb_bars_client.create_interest_rate_tran(l_loan_row.main_account_id,
                                                                  l_operation_id,
                                                                  1,
                                                                  cdb_dispatcher.INTEREST_KIND_ASSETS,
                                                                  l_change_int_rate_claim_row.interest_rate_date,
                                                                  l_change_int_rate_claim_row.interest_rate));
        tools.hide_hint(cdb_bars_client.create_interest_rate_tran(l_deposit_row.main_account_id,
                                                                  l_operation_id,
                                                                  1,
                                                                  cdb_dispatcher.INTEREST_KIND_LIABILITIES,
                                                                  l_change_int_rate_claim_row.interest_rate_date,
                                                                  l_change_int_rate_claim_row.interest_rate));

        l_comment := cdb_claim.get_claim_comment(p_claim_id);
        if (l_comment is not null) then
            tools.hide_hint(cdb_bars_client.create_deal_comment_tran(l_deposit_id, l_operation_id, 3, l_comment));
            tools.hide_hint(cdb_bars_client.create_deal_comment_tran(l_loan_id, l_operation_id, 3, l_comment));
        end if;

        cdb_claim.set_claim_state_prepared(p_claim_id);

        commit;
    exception
        when others then
             logger.log('cdb_dispatcher.process_change_int_rate_claim', logger.LOG_LEVEL_ERROR,
                        'claim id: ' || p_claim_id || chr(10) ||
                        sqlerrm || chr(10) || dbms_utility.format_error_backtrace);
             rollback;

             cdb_claim.set_claim_state_invalid(p_claim_id,
                                               sqlerrm,
                                               dbms_utility.format_error_backtrace());
             commit;
    end;

    procedure process_change_exp_date_claim(p_claim_id in integer)
    is
        pragma autonomous_transaction;
        l_claim_row claim%rowtype;
        l_change_exp_date_claim_row claim_change_expiry_date%rowtype;
        l_deal_row deal%rowtype;
        l_loan_id integer;
        l_deposit_id integer;
        l_operation_id integer;
        l_comment varchar2(4000 byte);
    begin
        l_claim_row := cdb_claim.read_claim(p_claim_id, true);

        if (l_claim_row.state not in (cdb_claim.CLAIM_STATE_CHECKED, cdb_claim.CLAIM_STATE_ACCEPTED, cdb_claim.CLAIM_STATE_INVALID)) then
            rollback;
            return;
        end if;

        l_change_exp_date_claim_row := cdb_claim.read_claim_change_exp_date(p_claim_id);

        l_deal_row := cdb_deal.read_deal(l_change_exp_date_claim_row.deal_number, l_change_exp_date_claim_row.currency_id, p_lock => true);
        l_loan_id := cdb_bars_object.get_deal_loan_id(l_deal_row.id);
        l_deposit_id := cdb_bars_object.get_deal_deposit_id(l_deal_row.id);

        -- установимо нові ставки в ЦБД
        l_operation_id := create_operation(l_deal_row.id, cdb_dispatcher.OPT_CHANGE_EXPIRY_DATE, p_claim_id);
        cdb_attribute.set_attribute_value(l_deal_row.id, cdb_dispatcher.ATTR_KIND_EXPIRY_DATE, l_change_exp_date_claim_row.expiry_date, l_operation_id);

        -- заплануємо зміну ставок кредитора та позичальника в АБС
        tools.hide_hint(cdb_bars_client.create_bars_transaction(l_loan_id,
                                                                l_operation_id,
                                                                cdb_bars_client.TRAN_TYPE_CHANGE_EXPIRY_DATE,
                                                                1));
        tools.hide_hint(cdb_bars_client.create_bars_transaction(l_deposit_id,
                                                                l_operation_id,
                                                                cdb_bars_client.TRAN_TYPE_CHANGE_EXPIRY_DATE,
                                                                1));

        l_comment := cdb_claim.get_claim_comment(p_claim_id);
        if (l_comment is not null) then
            tools.hide_hint(cdb_bars_client.create_deal_comment_tran(l_loan_id, l_operation_id, 3, l_comment));
            tools.hide_hint(cdb_bars_client.create_deal_comment_tran(l_deposit_id, l_operation_id, 3, l_comment));
        end if;

        cdb_claim.set_claim_state_prepared(p_claim_id);

        commit;
    exception
        when others then
             logger.log('cdb_dispatcher.process_change_exp_date_claim', logger.LOG_LEVEL_ERROR,
                        'claim id: ' || p_claim_id || chr(10) ||
                        sqlerrm || chr(10) || dbms_utility.format_error_backtrace);
             rollback;

             cdb_claim.set_claim_state_invalid(p_claim_id,
                                               sqlerrm,
                                               dbms_utility.format_error_backtrace());
             commit;
    end;

    procedure process_close_deal_claim(p_claim_id in integer)
    is
        pragma autonomous_transaction;
        l_claim_row claim%rowtype;
        l_claim_close_deal_row claim_close_deal%rowtype;
        l_deal_row deal%rowtype;
        l_loan_id integer;
        l_deposit_id integer;
        l_loan_row bars_deal%rowtype;
        l_deposit_row bars_deal%rowtype;
        l_lender_main_account_row bars_account%rowtype;
        -- l_lender_interest_account_row bars_account%rowtype;
        l_loan_rest number;
        -- l_loan_interest_rest number;
        -- l_interest_payment_doc_id integer;
        -- l_interest_receiving_doc_id integer;
        l_main_debt_payment_doc_id integer;
        -- l_main_debt_receiving_doc_id integer;
        l_operation_id integer;
        l_comment varchar2(4000 byte);
    begin
        l_claim_row := cdb_claim.read_claim(p_claim_id, p_lock => true);

        if (l_claim_row.state not in (cdb_claim.CLAIM_STATE_CHECKED, cdb_claim.CLAIM_STATE_ACCEPTED, cdb_claim.CLAIM_STATE_INVALID)) then
            rollback;
            return;
        end if;

        l_claim_close_deal_row := cdb_claim.read_claim_close_deal(p_claim_id);

        l_deal_row := cdb_deal.read_deal(l_claim_close_deal_row.deal_number, l_claim_close_deal_row.currency_id, p_lock => true);

        l_loan_id := cdb_bars_object.get_deal_loan_id(l_deal_row.id);
        l_deposit_id := cdb_bars_object.get_deal_deposit_id(l_deal_row.id);

        l_loan_row := cdb_bars_object.read_bars_deal(l_loan_id);
        l_deposit_row := cdb_bars_object.read_bars_deal(l_deposit_id);

        l_lender_main_account_row := cdb_bars_object.read_bars_account(l_loan_row.main_account_id);
        -- l_lender_interest_account_row := cdb_bars_object.read_bars_account(l_loan_row.interest_account_id);

        l_loan_rest := abs(cdb_bars_client.get_account_rest(l_deal_row.lender_id,
                                                            l_lender_main_account_row.account_number,
                                                            l_deal_row.currency_id)) / 100;
/*
        l_loan_interest_rest := abs(cdb_bars_client.get_account_rest(l_deal_row.lender_id,
                                                                     l_lender_interest_account_row.account_number,
                                                                     l_deal_row.currency_id)) / 100;
*/
        l_operation_id := create_operation(l_deal_row.id, cdb_dispatcher.OPT_CLOSE_DEAL, p_claim_id);
        cdb_attribute.set_attribute_value(l_deal_row.id, cdb_dispatcher.ATTR_KIND_CLOSE_DATE, l_claim_close_deal_row.close_date, l_operation_id);
/*
        if (abs(l_loan_interest_rest) <> 0) then
            l_interest_payment_doc_id := cdb_bars_object.create_bars_document(l_deal_row.id,
                                                                              'WD7',
                                                                              1,
                                                                              l_deposit_row.interest_account_id,
                                                                              l_loan_row.interest_account_id,
                                                                              l_loan_interest_rest,
                                                                              l_deal_row.currency_id,
                                                                              'Погашення відсотків за угодою №' || l_deal_row.deal_number,
                                                                              l_deal_row.borrower_id);

            l_interest_receiving_doc_id := cdb_bars_object.create_bars_document(l_deal_row.id,
                                                                                'KV1',
                                                                                6,
                                                                                l_loan_row.transit_account_id,
                                                                                l_loan_row.interest_account_id,
                                                                                l_loan_interest_rest,
                                                                                l_deal_row.currency_id,
                                                                                'Прийняття погашення відсотків за угодою №' || l_deal_row.deal_number,
                                                                                l_deal_row.lender_id);

            tools.hide_hint(cdb_bars_client.create_bars_transaction(l_interest_payment_doc_id,
                                                                    l_operation_id,
                                                                    cdb_bars_client.TRAN_TYPE_BARS_DOCUMENT, 1));

            tools.hide_hint(cdb_bars_client.create_bars_transaction(l_interest_receiving_doc_id,
                                                                    l_operation_id,
                                                                    cdb_bars_client.TRAN_TYPE_BARS_DOCUMENT, 1));
        end if;
*/
        if (l_loan_rest <> 0) then
            l_main_debt_payment_doc_id := cdb_bars_object.create_bars_document(l_deal_row.id,
                                                                               'WD7',
                                                                               1,
                                                                               l_deposit_row.main_account_id,
                                                                               l_loan_row.main_account_id,
                                                                               l_loan_rest,
                                                                               l_deal_row.currency_id,
                                                                               'Погашення основної суми угоди №' || l_deal_row.deal_number,
                                                                               l_deal_row.borrower_id);
/*
            l_main_debt_receiving_doc_id := cdb_bars_object.create_bars_document(l_deal_row.id,
                                                                                 'KV1',
                                                                                 6,
                                                                                 l_loan_row.transit_account_id,
                                                                                 l_loan_row.main_account_id,
                                                                                 l_loan_rest,
                                                                                 l_deal_row.currency_id,
                                                                                 'Прийняття погашення основної суми угоди №' || l_deal_row.deal_number,
                                                                                 l_deal_row.lender_id);
*/
            tools.hide_hint(cdb_bars_client.create_bars_transaction(l_main_debt_payment_doc_id,
                                                                    l_operation_id,
                                                                    cdb_bars_client.TRAN_TYPE_BARS_DOCUMENT,
                                                                    1));
/*
            tools.hide_hint(cdb_bars_client.create_bars_transaction(l_main_debt_receiving_doc_id,
                                                                    l_operation_id,
                                                                    cdb_bars_client.TRAN_TYPE_BARS_DOCUMENT,
                                                                    1));
*/
        end if;
/*
        tools.hide_hint(cdb_bars_client.create_bars_transaction(l_loan_id,
                                                                l_operation_id,
                                                                cdb_bars_client.TRAN_TYPE_CLOSE_DEAL,
                                                                2));
        tools.hide_hint(cdb_bars_client.create_bars_transaction(l_deposit_id,
                                                                l_operation_id,
                                                                cdb_bars_client.TRAN_TYPE_CLOSE_DEAL,
                                                                2));

        tools.hide_hint(cdb_bars_client.create_bars_transaction(l_loan_row.main_account_id,
                                                                l_operation_id,
                                                                cdb_bars_client.TRAN_TYPE_CLOSE_ACCOUNT,
                                                                2));
        tools.hide_hint(cdb_bars_client.create_bars_transaction(l_loan_row.interest_account_id,
                                                                l_operation_id,
                                                                cdb_bars_client.TRAN_TYPE_CLOSE_ACCOUNT,
                                                                3));
        tools.hide_hint(cdb_bars_client.create_bars_transaction(l_deposit_row.main_account_id,
                                                                l_operation_id,
                                                                cdb_bars_client.TRAN_TYPE_CLOSE_ACCOUNT,
                                                                2));
        tools.hide_hint(cdb_bars_client.create_bars_transaction(l_deposit_row.interest_account_id,
                                                                l_operation_id,
                                                                cdb_bars_client.TRAN_TYPE_CLOSE_ACCOUNT,
                                                                3));
*/
        l_comment := cdb_claim.get_claim_comment(p_claim_id);
        if (l_comment is not null) then
            tools.hide_hint(cdb_bars_client.create_deal_comment_tran(l_deposit_id, l_operation_id, 4, l_comment));
            tools.hide_hint(cdb_bars_client.create_deal_comment_tran(l_loan_id, l_operation_id, 4, l_comment));
        end if;

        cdb_claim.set_claim_state_prepared(p_claim_id);

        commit;
    exception
        when others then
             logger.log('cdb_dispatcher.process_close_deal_claim', logger.LOG_LEVEL_ERROR,
                        'claim id: ' || p_claim_id || chr(10) ||
                        sqlerrm || chr(10) || dbms_utility.format_error_backtrace);
             rollback;

             cdb_claim.set_claim_state_invalid(p_claim_id,
                                               sqlerrm,
                                               dbms_utility.format_error_backtrace());
             commit;
    end;

    procedure perform_claim_checks(p_claim_id in integer, p_claim_type in integer)
    is
    begin
        case (p_claim_type)
        when cdb_claim.CLAIM_TYPE_NEW_DEAL then
             check_new_deal_claim(p_claim_id);
        when cdb_claim.CLAIM_TYPE_CHANGE_AMOUNT then
             check_change_amount_claim(p_claim_id);
        when cdb_claim.CLAIM_TYPE_SET_INTEREST_RATE then
             check_change_int_rate_claim(p_claim_id);
        when cdb_claim.CLAIM_TYPE_SET_EXPIRY_DATE then
             check_change_exp_date_claim(p_claim_id);
        when cdb_claim.CLAIM_TYPE_CLOSE_DEAL then
             check_close_deal_claim(p_claim_id);
        end case;
    end;

    procedure process_claim(p_claim_id in integer, p_claim_type in integer)
    is
    begin
        case (p_claim_type)
        when cdb_claim.CLAIM_TYPE_NEW_DEAL then
             process_new_deal_claim(p_claim_id);
        when cdb_claim.CLAIM_TYPE_CLOSE_DEAL then
             process_close_deal_claim(p_claim_id);
        when cdb_claim.CLAIM_TYPE_CHANGE_AMOUNT then
             process_change_amount_claim(p_claim_id);
        when cdb_claim.CLAIM_TYPE_SET_INTEREST_RATE then
             process_change_int_rate_claim(p_claim_id);
        when cdb_claim.CLAIM_TYPE_SET_EXPIRY_DATE then
             process_change_exp_date_claim(p_claim_id);
        end case;
    end;

    procedure process_claims
    is
    begin
        for i in (select c.id, c.claim_type_id from claim c where c.state = cdb_claim.CLAIM_STATE_NEW order by c.id) loop
            perform_claim_checks(i.id, i.claim_type_id);
        end loop;

        for i in (select c.id, c.claim_type_id from claim c where c.state in (cdb_claim.CLAIM_STATE_CHECKED, cdb_claim.CLAIM_STATE_ACCEPTED) order by c.id desc) loop
            process_claim(i.id, i.claim_type_id);
        end loop;
    end;
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/CDB/package/cdb_dispatcher.sql =========*** End *
 PROMPT ===================================================================================== 
 