
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/sto_integration_xrm.sql =========***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.STO_INTEGRATION_XRM is

 G_HEADER_VERSION  CONSTANT VARCHAR2(64)  :=  'version 1.2  16.05.2016';
 function header_version return varchar2;
 function body_version   return varchar2;
 
    TYPE r_storec IS record (
         ru                varchar2(6 char),
         rnk               number(38),
         telephone_number  varchar2(15 char),
         payment_id        number(38),
         contract_number   number(38),
         payment_amount    number,
         fee_amount        number,
         payment_date      varchar2(10 char));

    type r_stolist is table of r_storec;

    function get_sto_lst
    return r_stolist pipelined;

    procedure delete_payment_que (
        p_ru           in  number,
        p_payment_id   in  integer,
        p_errormsg     out varchar2);

    procedure cancel_payment (
        p_ru           in  number,
        p_payment_id   in  integer,
        p_errormsg     out varchar2);
end;
/
CREATE OR REPLACE PACKAGE BODY BARS.STO_INTEGRATION_XRM as

  G_BODY_VERSION  CONSTANT VARCHAR2(64)  :=  'version 1.2 16.05.2016';

  FUNCTION header_version
     RETURN VARCHAR2
  IS
  BEGIN
     RETURN 'Package header sto_integration_xrm ' || G_HEADER_VERSION;
  END header_version;

  FUNCTION body_version
     RETURN VARCHAR2
  IS
  BEGIN
     RETURN 'Package body sto_integration_xrm ' || G_BODY_VERSION;
  END body_version;
  
    procedure clear_redundant_items(
        p_payment_ids in number_list)
    is
        pragma autonomous_transaction;
    begin
        delete sto_payment_que where id in (select column_value from table(p_payment_ids));
        commit;
    end;

    function get_sto_lst
    return r_stolist pipelined
    is
        l_storec r_storec;
        l_redundant_payment_ids number_list := number_list();
        l_old_fashioned_id varchar2(38 char);
        l_kf varchar2(6 char);
    begin
        for i in (  select spq.id payment_id,
                           so.kf,
                           so.id order_id,
                           c.rnk,
                           cw.value phone_number,
                           sp.payment_amount,
                           sp.fee_amount,
                           sp.value_date,
                           so.send_sms,
                           sp.state
                      from bars.sto_payment_que spq
                      left join bars.sto_payment sp on sp.id = spq.id
                      left join bars.sto_order so on so.id = sp.order_id
                      left join bars.accounts a on a.acc = so.payer_account_id
                      left join bars.customer c on c.rnk = a.rnk
                      left join bars.customerw cw on cw.rnk = c.rnk and cw.tag = 'MPNO  ')
        loop
            if (i.send_sms = 'Y' and i.state in (sto_payment_utl.STO_PM_STATE_READY_TO_WITHDRAW) and i.payment_amount > 0 and i.phone_number is not null and i.value_date >= gl.bd) then
                l_storec.ru                 := i.kf;
                l_storec.rnk                := i.rnk;
                l_storec.telephone_number   := i.phone_number;
                l_storec.payment_amount     := i.payment_amount;
                l_storec.fee_amount         := i.fee_amount;
                l_storec.payment_date       := to_char(i.value_date);

                bars_sqnc.split_key(i.payment_id, l_old_fashioned_id, l_kf);
                l_storec.payment_id := l_old_fashioned_id;

                bars_sqnc.split_key(i.order_id, l_old_fashioned_id, l_kf);
                l_storec.contract_number := l_old_fashioned_id;

                pipe row (l_storec);
            else
                if (i.state not in (sto_payment_utl.STO_PM_STATE_NEW, sto_payment_utl.STO_PM_STATE_SBON_AMOUNT_GOT)) then
                    l_redundant_payment_ids.extend(1);
                    l_redundant_payment_ids(l_redundant_payment_ids.last) := i.payment_id;
                end if;
            end if;
        end loop;

        clear_redundant_items(l_redundant_payment_ids);
    end;

    procedure delete_payment_que (
        p_ru         in  number,
        p_payment_id in  integer,
        p_errormsg   out varchar2)
    is
    begin
        --ikf(p_ru);

        delete from sto_payment_que
        where id = bars_sqnc.rukey(p_payment_id);

        if (sql%rowcount = 0) then
            p_errormsg := 'ѕлат≥ж ' || bars_sqnc.rukey(p_payment_id) || ' не знайдено в черз≥ платеж≥в';
            bars_audit.info('sto_integration_xrm.delete_payment_que:' || p_errormsg);
        else
            bars.sto_payment_utl.track_payment_state(bars_sqnc.rukey(p_payment_id), sto_payment_utl.DOCUMENT_STATE_OUT_QUEUE, '—кв≥товано CRM ≥ видалено з черги на в≥дправку SMS');
            p_errormsg := 'Ok';
        end if;
    exception
        when others then
             p_errormsg := sqlerrm;
             bars_audit.error('sto_integration_xrm.delete_payment_que: ' || sqlerrm || chr(10) || dbms_utility.format_error_backtrace());
    end;

    procedure cancel_payment(
        p_ru         in  number,
        p_payment_id in  integer,
        p_errormsg   out varchar2)
    is
        l_payment_row sto_payment%rowtype;
    begin
        --ikf(p_ru);

        l_payment_row := sto_payment_utl.read_payment(bars_sqnc.rukey(p_payment_id), p_lock => true);

        if (l_payment_row.state in (sto_payment_utl.STO_PM_STATE_NEW, sto_payment_utl.STO_PM_STATE_READY_TO_WITHDRAW)) then
            sto_payment_utl.set_payment_state(l_payment_row.id, sto_payment_utl.STO_PM_STATE_CANCEL_BY_CLIENT, ' л≥Їнт в≥дм≥нив плат≥ж за допомогою смс');
        end if;

        p_errormsg := 'Ok';
    exception
        when others then
             p_errormsg := sqlerrm || chr(10) || dbms_utility.format_error_backtrace();
    end;
end;
/
 show err;
 
PROMPT *** Create  grants  STO_INTEGRATION_XRM ***
grant EXECUTE                                                                on STO_INTEGRATION_XRM to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/sto_integration_xrm.sql =========***
 PROMPT ===================================================================================== 
 