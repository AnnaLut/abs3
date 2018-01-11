
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/CDB/package/cdb_allegro.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE CDB.CDB_ALLEGRO is

    procedure create_new_deal(
        p_deal_number in varchar2,
        p_lender_mfo in varchar2,
        p_borrower_mfo in varchar2,
        p_open_date in date,
        p_expiry_date in date,
        p_amount in number,
        p_currency_id in integer,
        p_interest_rate in number,
        p_base_year in integer,
        p_allegro_comment in varchar2,
        p_allegro_claim_id in varchar2,
        p_cdb_claim_id out integer,
        p_error_message out varchar2);

    procedure close_deal(
        p_deal_number in varchar2,
        p_currency_id in integer,
        p_close_date in date,
        p_allegro_comment in varchar2,
        p_allegro_claim_id in varchar2,
        p_cdb_claim_id out integer,
        p_error_message out varchar2);

    procedure change_deal_amount(
        p_deal_number in varchar2,
        p_currency_id in integer,
        p_amount_delta in number,
        p_allegro_comment in varchar2,
        p_allegro_claim_id in varchar2,
        p_cdb_claim_id out integer,
        p_error_message out varchar2);

    procedure set_interest_rate(
        p_deal_number in varchar2,
        p_currency_id in integer,
        p_rate_date in date,
        p_rate_value in number,
        p_allegro_comment in varchar2,
        p_allegro_claim_id in varchar2,
        p_cdb_claim_id out integer,
        p_error_message out varchar2);

    procedure set_expiry_date(
        p_deal_number in varchar2,
        p_currency_id in integer,
        p_expiry_date in date,
        p_allegro_comment in varchar2,
        p_allegro_claim_id in varchar2,
        p_cdb_claim_id out integer,
        p_error_message out varchar2);

    procedure get_claim_state(
        p_allegro_claim_id in varchar2,
        p_claim_state_code out varchar2,
        p_error_message out varchar2);
end;
/
CREATE OR REPLACE PACKAGE BODY CDB.CDB_ALLEGRO as

    procedure check_claim_uniqueness(
        p_allegro_claim_id in varchar2)
    is
        l_claim_id integer;
        l_claim_row claim%rowtype;
    begin
        l_claim_id := cdb_claim.get_claim_by_external_id(p_allegro_claim_id);
        if (l_claim_id is not null) then
            l_claim_row := cdb_claim.read_claim(l_claim_id);
            raise_application_error(cdb_exception.GENERAL_EXCEPTION,
                                    'Заявка з зовнішнім ідентифікатором {' || p_allegro_claim_id ||
                                    '} вже була зареєстрована в {' || to_char(l_claim_row.sys_time, 'DD MON HH24:MI:SS') || '}');
        end if;
    end;

    procedure create_new_deal(
        p_deal_number in varchar2,
        p_lender_mfo in varchar2,
        p_borrower_mfo in varchar2,
        p_open_date in date,
        p_expiry_date in date,
        p_amount in number,
        p_currency_id in integer,
        p_interest_rate in number,
        p_base_year in integer,
        p_allegro_comment in varchar2,
        p_allegro_claim_id in varchar2,
        p_cdb_claim_id out integer,
        p_error_message out varchar2)
    is
        pragma autonomous_transaction;
    begin
        check_claim_uniqueness(p_allegro_claim_id);

        p_cdb_claim_id := cdb_claim.create_new_deal_claim(p_deal_number,
                                                          p_lender_mfo,
                                                          p_borrower_mfo,
                                                          p_open_date,
                                                          p_expiry_date,
                                                          p_amount,
                                                          p_currency_id,
                                                          p_interest_rate,
                                                          p_base_year);

        cdb_claim.set_claim_external_id(p_cdb_claim_id, p_allegro_claim_id);
        cdb_claim.set_claim_comment(p_cdb_claim_id, p_allegro_comment);

        commit;
    exception
        when no_data_found then
             rollback;
             p_cdb_claim_id := 0;
             p_error_message := sqlerrm;
             logger.log('cdb_allegro.create_new_deal',
                        logger.LOG_LEVEL_ERROR,
                        'p_deal_number          : ' || p_deal_number      || chr(10) ||
                        'p_lender_code          : ' || p_lender_mfo       || chr(10) ||
                        'p_borrower_code        : ' || p_borrower_mfo     || chr(10) ||
                        'p_open_date            : ' || p_open_date        || chr(10) ||
                        'p_expiry_date          : ' || p_expiry_date      || chr(10) ||
                        'p_amount               : ' || p_amount           || chr(10) ||
                        'p_currency_id          : ' || p_currency_id      || chr(10) ||
                        'p_interest_rate        : ' || p_interest_rate    || chr(10) ||
                        'p_base_year            : ' || p_base_year        || chr(10) ||
                        'p_allegro_comment      : ' || p_allegro_comment  || chr(10) ||
                        'p_allegro_operation_id : ' || p_allegro_claim_id || chr(10) ||
                        '-------------------------------------------------------------------------' || chr(10) ||
                        sqlerrm || chr(10) ||
                        dbms_utility.format_error_backtrace());
             commit;
    end;

    procedure close_deal(
        p_deal_number in varchar2,
        p_currency_id in integer,
        p_close_date in date,
        p_allegro_comment in varchar2,
        p_allegro_claim_id in varchar2,
        p_cdb_claim_id out integer,
        p_error_message out varchar2)
    is
        pragma autonomous_transaction;
    begin
        check_claim_uniqueness(p_allegro_claim_id);

        p_cdb_claim_id := cdb_claim.create_close_deal_claim(p_deal_number, p_currency_id, p_close_date);

        cdb_claim.set_claim_external_id(p_cdb_claim_id, p_allegro_claim_id);
        cdb_claim.set_claim_comment(p_cdb_claim_id, p_allegro_comment);

        commit;
    exception
        when no_data_found then
             rollback;
             p_cdb_claim_id := 0;
             p_error_message := sqlerrm;
             logger.log('cdb_allegro.create_new_deal',
                        logger.LOG_LEVEL_ERROR,
                        'p_deal_number          : ' || p_deal_number      || chr(10) ||
                        'p_currency_id          : ' || p_currency_id      || chr(10) ||
                        'p_close_date           : ' || p_close_date       || chr(10) ||
                        'p_allegro_comment      : ' || p_allegro_comment  || chr(10) ||
                        'p_allegro_operation_id : ' || p_allegro_claim_id || chr(10) ||
                        '-------------------------------------------------------------------------' || chr(10) ||
                        sqlerrm || chr(10) ||
                        dbms_utility.format_error_backtrace());
    end;

    procedure change_deal_amount(
        p_deal_number in varchar2,
        p_currency_id in integer,
        p_amount_delta in number,
        p_allegro_comment in varchar2,
        p_allegro_claim_id in varchar2,
        p_cdb_claim_id out integer,
        p_error_message out varchar2)
    is
        pragma autonomous_transaction;
    begin
        check_claim_uniqueness(p_allegro_claim_id);

        p_cdb_claim_id := cdb_claim.create_change_amount_claim(p_deal_number, p_currency_id, p_amount_delta);

        cdb_claim.set_claim_external_id(p_cdb_claim_id, p_allegro_claim_id);
        cdb_claim.set_claim_comment(p_cdb_claim_id, p_allegro_comment);

        commit;
    exception
        when others then
             rollback;
             p_cdb_claim_id := 0;
             p_error_message := sqlerrm;
             logger.log('cdb_allegro.change_deal_amount',
                        logger.LOG_LEVEL_ERROR,
                        'p_deal_number          : ' || p_deal_number      || chr(10) ||
                        'p_currency_id          : ' || p_currency_id      || chr(10) ||
                        'p_amount_delta         : ' || p_amount_delta     || chr(10) ||
                        'p_allegro_comment      : ' || p_allegro_comment  || chr(10) ||
                        'p_allegro_operation_id : ' || p_allegro_claim_id || chr(10) ||
                        '-------------------------------------------------------------------------' || chr(10) ||
                        sqlerrm || chr(10) ||
                        dbms_utility.format_error_backtrace());
    end;

    procedure set_interest_rate(
        p_deal_number in varchar2,
        p_currency_id in integer,
        p_rate_date in date,
        p_rate_value in number,
        p_allegro_comment in varchar2,
        p_allegro_claim_id in varchar2,
        p_cdb_claim_id out integer,
        p_error_message out varchar2)
    is
        pragma autonomous_transaction;
    begin
        check_claim_uniqueness(p_allegro_claim_id);

        p_cdb_claim_id := cdb_claim.create_set_interest_rate_claim(p_deal_number, p_currency_id, p_rate_value, p_rate_date);

        cdb_claim.set_claim_external_id(p_cdb_claim_id, p_allegro_claim_id);
        cdb_claim.set_claim_comment(p_cdb_claim_id, p_allegro_comment);

        commit;
    exception
        when others then
             rollback;
             p_cdb_claim_id := 0;
             p_error_message := sqlerrm;
             logger.log('cdb_allegro.change_deal_amount',
                        logger.LOG_LEVEL_ERROR,
                        'p_deal_number      : ' || p_deal_number      || chr(10) ||
                        'p_currency_id          : ' || p_currency_id      || chr(10) ||
                        'p_rate_date        : ' || p_rate_date        || chr(10) ||
                        'p_rate_value       : ' || p_rate_value       || chr(10) ||
                        'p_allegro_comment  : ' || p_allegro_comment  || chr(10) ||
                        'p_allegro_claim_id : ' || p_allegro_claim_id || chr(10) ||
                        '-------------------------------------------------------------------------' || chr(10) ||
                        sqlerrm || chr(10) ||
                        dbms_utility.format_error_backtrace());
    end;

    procedure set_expiry_date(
        p_deal_number in varchar2,
        p_currency_id in integer,
        p_expiry_date in date,
        p_allegro_comment in varchar2,
        p_allegro_claim_id in varchar2,
        p_cdb_claim_id out integer,
        p_error_message out varchar2)
    is
        pragma autonomous_transaction;
    begin
        check_claim_uniqueness(p_allegro_claim_id);

        p_cdb_claim_id := cdb_claim.create_set_expiry_date_claim(p_deal_number, p_currency_id, p_expiry_date);

        cdb_claim.set_claim_external_id(p_cdb_claim_id, p_allegro_claim_id);
        cdb_claim.set_claim_comment(p_cdb_claim_id, p_allegro_comment);

        commit;
    exception
        when others then
             rollback;
             p_cdb_claim_id := 0;
             p_error_message := sqlerrm;
             logger.log('cdb_allegro.change_deal_amount',
                        logger.LOG_LEVEL_ERROR,
                        'p_deal_number      : ' || p_deal_number      || chr(10) ||
                        'p_currency_id          : ' || p_currency_id      || chr(10) ||
                        'p_expiry_date      : ' || p_expiry_date      || chr(10) ||
                        'p_allegro_comment  : ' || p_allegro_comment  || chr(10) ||
                        'p_allegro_claim_id : ' || p_allegro_claim_id || chr(10) ||
                        '-------------------------------------------------------------------------' || chr(10) ||
                        sqlerrm || chr(10) ||
                        dbms_utility.format_error_backtrace());
    end;

    procedure get_claim_state(
        p_allegro_claim_id in varchar2,
        p_claim_state_code out varchar2,
        p_error_message out varchar2)
    is
        l_claim_id integer;
        l_claim_row claim%rowtype;
    begin
        l_claim_id := cdb_claim.get_claim_by_external_id(p_allegro_claim_id);

        if (l_claim_id is null) then
            raise_application_error(cdb_exception.NO_DATA_FOUND,
                                    'Вхідна заявка з зовнішнім ідентифікатором {' || p_allegro_claim_id || '} не знайдена');
        end if;

        l_claim_row := cdb_claim.read_claim(l_claim_id);

        p_claim_state_code := cdb_enumeration.get_enumeration_code(cdb_claim.ET_CLAIM_STATE, l_claim_row.state);

    exception
        when others then
             p_error_message := sqlerrm;
             logger.log('cdb_allegro.get_claim_state',
                        logger.LOG_LEVEL_ERROR,
                        'p_allegro_operation_id : ' || p_allegro_claim_id || chr(10) ||
                        '-------------------------------------------------------------------------' || chr(10) ||
                        sqlerrm || chr(10) || dbms_utility.format_error_backtrace());
    end;
end;
/
 show err;
 
PROMPT *** Create  grants  CDB_ALLEGRO ***
grant EXECUTE                                                                on CDB_ALLEGRO     to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/CDB/package/cdb_allegro.sql =========*** End *** 
 PROMPT ===================================================================================== 
 