
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/CDB/package/cdb_ui.sql =========*** Run *** =====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE CDB.CDB_UI is
    procedure accept_claim(
        p_claim_id in integer,
        p_is_success out integer,
        p_message out varchar2);
    procedure repeat_claim(
        p_claim_id in integer,
        p_is_success out integer,
        p_message out varchar2);
    procedure cancel_claim(
        p_claim_id in integer,
        p_comment in varchar2,
        p_is_success out integer,
        p_message out varchar2);
    procedure repeat_transaction(
        p_transaction_id in integer,
        p_is_success out integer,
        p_message out varchar2);
    procedure cancel_transaction(
        p_transaction_id in integer,
        p_comment in varchar2,
        p_is_success out integer,
        p_message out varchar2);
end;
/
CREATE OR REPLACE PACKAGE BODY CDB.CDB_UI as

    YES constant integer := 1;
    NO  constant integer := 0;

    procedure accept_claim(
        p_claim_id in integer,
        p_is_success out integer,
        p_message out varchar2)
    is
        pragma autonomous_transaction;
    begin
        p_is_success := YES;

        cdb_claim.set_claim_state_accepted(p_claim_id);

        commit;

    exception
        when others then
             rollback;
             logger.log('cdb_ui.accept_claim', logger.LOG_LEVEL_ERROR,
                        'p_claim_id : ' || p_claim_id || chr(10) ||
                        sqlerrm || chr(10) || dbms_utility.format_error_backtrace());
             p_is_success := NO;
             p_message := sqlerrm;
    end;

    procedure repeat_claim(
        p_claim_id in integer,
        p_is_success out integer,
        p_message out varchar2)
    is
        pragma autonomous_transaction;
        l_claim_row claim%rowtype;
    begin
        p_is_success := YES;

        l_claim_row := cdb_claim.read_claim(p_claim_id);
        if (l_claim_row.state in (cdb_claim.CLAIM_STATE_NEW, cdb_claim.CLAIM_STATE_CHECK_FAILED, cdb_claim.CLAIM_STATE_WAIT_FOR_BARS)) then
            cdb_dispatcher.perform_claim_checks(p_claim_id, l_claim_row.claim_type_id);
            cdb_dispatcher.process_claim(p_claim_id, l_claim_row.claim_type_id);
        elsif (l_claim_row.state in (cdb_claim.CLAIM_STATE_CHECKED, cdb_claim.CLAIM_STATE_ACCEPTED, cdb_claim.CLAIM_STATE_INVALID)) then
            cdb_dispatcher.process_claim(p_claim_id, l_claim_row.claim_type_id);
        elsif(l_claim_row.state in (cdb_claim.CLAIM_STATE_CANCELED)) then
            raise_application_error(cdb_exception.GENERAL_EXCEPTION,
                                    'Заявка відмінена - будь-яка подальша обробка не можлива');
        else
            raise_application_error(cdb_exception.GENERAL_EXCEPTION,
                                    'Заявка зі статусом {' || cdb_enumeration.get_enumeration_code(cdb_claim.ET_CLAIM_STATE, l_claim_row.state) ||
                                    '} не може повторно оброблятися');
        end if;

        commit;
    exception
        when others then
             rollback;
             logger.log('cdb_ui.repeat_claim', logger.LOG_LEVEL_ERROR,
                        'p_claim_id : ' || p_claim_id || chr(10) ||
                        sqlerrm || chr(10) || dbms_utility.format_error_backtrace());
             p_is_success := NO;
             p_message := sqlerrm;
    end;

    procedure cancel_claim(
        p_claim_id in integer,
        p_comment in varchar2,
        p_is_success out integer,
        p_message out varchar2)
    is
        pragma autonomous_transaction;
    begin
        p_is_success := YES;

        cdb_claim.set_claim_state_canceled(p_claim_id, p_comment);

        commit;

    exception
        when others then
             rollback;
             logger.log('cdb_ui.cancel_claim', logger.LOG_LEVEL_ERROR,
                        'p_claim_id : ' || p_claim_id || chr(10) ||
                        sqlerrm || chr(10) || dbms_utility.format_error_backtrace());
             p_is_success := NO;
             p_message := sqlerrm;
    end;

    procedure repeat_transaction(
        p_transaction_id in integer,
        p_is_success out integer,
        p_message out varchar2)
    is
        pragma autonomous_transaction;
        l_transaction_row bars_transaction%rowtype;
    begin
        p_is_success := YES;

        l_transaction_row := cdb_bars_client.read_bars_transaction(p_transaction_id);

        if (l_transaction_row.state in (cdb_bars_client.TRAN_STATE_NEW, cdb_bars_client.TRAN_STATE_INVALID, cdb_bars_client.TRAN_STATE_WAIT_FOR_BARS)) then
            cdb_bars_client.process_bars_transaction(p_transaction_id, l_transaction_row.transaction_type);
        elsif (l_transaction_row.state = cdb_bars_client.TRAN_STATE_CANCELED) then
            raise_application_error(cdb_exception.GENERAL_EXCEPTION,
                                    'Транзакція відмінена - будь-яка подальша обробка не можлива');
        else
            raise_application_error(cdb_exception.GENERAL_EXCEPTION,
                                    'Транзакція знаходиться в стані {' || cdb_enumeration.get_enumeration_code(cdb_bars_client.ET_TRANSACTION_STATE, l_transaction_row.state) ||
                                    '} і не підлягає повторній обробці');
        end if;

        commit;
    exception
        when others then
             rollback;
             logger.log('cdb_ui.repeat_transaction', logger.LOG_LEVEL_ERROR,
                        'p_transaction_id : ' || p_transaction_id || chr(10) ||
                        sqlerrm || chr(10) || dbms_utility.format_error_backtrace());
             p_is_success := NO;
             p_message := sqlerrm;
    end;

    procedure cancel_transaction(
        p_transaction_id in integer,
        p_comment in varchar2,
        p_is_success out integer,
        p_message out varchar2)
    is
        pragma autonomous_transaction;
    begin
        logger.log('cdb_ui.cancel_transaction',
                   'p_transaction_id : ' || p_transaction_id || chr(10) ||
                   'p_comment        : ' || p_comment);

        p_is_success := YES;

        cdb_bars_client.cancel_transaction(p_transaction_id, p_comment);

        commit;

    exception
        when others then
             rollback;
             logger.log('cdb_ui.cancel_transaction',
                        'p_transaction_id : ' || p_transaction_id || chr(10) ||
                        'p_comment        : ' || p_comment || chr(10) ||
                        sqlerrm || chr(10) || dbms_utility.format_error_backtrace());
             p_is_success := NO;
             p_message := sqlerrm;
    end;
end;
/
 show err;
 
PROMPT *** Create  grants  CDB_UI ***
grant EXECUTE                                                                on CDB_UI          to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/CDB/package/cdb_ui.sql =========*** End *** =====
 PROMPT ===================================================================================== 
 