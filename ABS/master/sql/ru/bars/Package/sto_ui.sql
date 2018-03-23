
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/sto_ui.sql =========*** Run *** ====
 PROMPT ===================================================================================== 
 
CREATE OR REPLACE PACKAGE BARS.STO_UI is
  G_HEADER_VERSION  CONSTANT VARCHAR2(64)  :=  'version 2.2  21.04.2017';

 function header_version return varchar2;
 function body_version   return varchar2;

 function get_reciever_nms(p_mfo in varchar2, p_nls in varchar2) return varchar2;
 function get_reciever_okpo(p_mfo in varchar2, p_nls in varchar2) return varchar2;
   function check_order(
        p_payer_account_id in integer,
        p_start_date in date,
        p_stop_date in date,
        p_payment_frequency in integer) return varchar2;
    procedure new_sep_order(
        p_payer_account_id in integer,
        p_start_date in date,
        p_stop_date in date,
        p_payment_frequency in integer,
        p_holiday_shift in integer,
        p_regular_amount in number,
        p_receiver_mfo in varchar2,
        p_receiver_account in varchar2,
        p_receiver_name in varchar2,
        p_receiver_edrpou in varchar2,
        p_purpose in varchar2,
        p_sendsms in varchar2);

    procedure new_free_sbon_order(
        p_payer_account_id in integer,
        p_start_date in date,
        p_stop_date in date,
        p_payment_frequency in integer,
        p_holiday_shift in integer,
        p_provider_id in integer,
        p_regular_amount in number,
        p_receiver_mfo in varchar2,
        p_receiver_account in varchar2,
        p_receiver_name in varchar2,
        p_receiver_edrpou in varchar2,
        p_purpose in varchar2,
        p_extra_attributes in clob,
        p_sendsms in varchar2);

     procedure new_free_sbon_order_ext(
        p_payer_account_id in integer,
        p_start_date in date,
        p_stop_date in date,
        p_payment_frequency in integer,
        p_holiday_shift in integer,
        p_provider_id in integer,
        p_regular_amount in number,
        p_receiver_mfo in varchar2,
        p_receiver_account in varchar2,
        p_receiver_name in varchar2,
        p_receiver_edrpou in varchar2,
        p_purpose in varchar2,
        p_extra_attributes in clob,
        p_sendsms in varchar2,
        p_order_id out number,
        p_result_code out number,
        p_result_message out varchar2);

    procedure new_sbon_order_with_contr(
        p_payer_account_id in integer,
        p_start_date in date,
        p_stop_date in date,
        p_payment_frequency in integer,
        p_holiday_shift in integer,
        p_provider_id in integer,
        p_personal_account in varchar2,
        p_regular_amount in number,
        p_ceiling_amount in number,
        p_extra_attributes in clob,
        p_sendsms in varchar2);

    procedure new_sbon_order_with_contr_ext(
        p_payer_account_id in integer,
        p_start_date in date,
        p_stop_date in date,
        p_payment_frequency in integer,
        p_holiday_shift in integer,
        p_provider_id in integer,
        p_personal_account in varchar2,
        p_regular_amount in number,
        p_ceiling_amount in number,
        p_extra_attributes in clob,
        p_sendsms in varchar2,
        p_order_id out number,
        p_result_code out number,
        p_result_message out varchar2);

    procedure new_sbon_order_with_no_contr(
        p_payer_account_id in integer,
        p_start_date in date,
        p_stop_date in date,
        p_payment_frequency in integer,
        p_holiday_shift in integer,
        p_provider_id in integer,
        p_personal_account in varchar2,
        p_regular_amount in number,
        p_extra_attributes in clob,
        p_sendsms in varchar2);

        procedure new_sbon_order_with_no_contr_e(
        p_payer_account_id in integer,
        p_start_date in date,
        p_stop_date in date,
        p_payment_frequency in integer,
        p_holiday_shift in integer,
        p_provider_id in integer,
        p_personal_account in varchar2,
        p_regular_amount in number,
        p_extra_attributes in clob,
        p_sendsms in varchar2,
        p_order_id out number,
        p_result_code out number,
        p_result_message out varchar2);

    procedure edit_sep_order(
        p_order_id in integer,
        p_payer_account_id in integer,
        p_start_date in date,
        p_stop_date in date,
        p_payment_frequency in integer,
        p_holiday_shift in integer,
        p_regular_amount in number,
        p_receiver_mfo in varchar2,
        p_receiver_account in varchar2,
        p_receiver_name in varchar2,
        p_receiver_edrpou in varchar2,
        p_purpose in varchar2,
        p_sendsms in varchar2);

    procedure edit_free_sbon_order(
        p_order_id in integer,
        p_payer_account_id in integer,
        p_start_date in date,
        p_stop_date in date,
        p_payment_frequency in integer,
        p_holiday_shift in integer,
        p_provider_id in integer,
        p_regular_amount in number,
        p_receiver_mfo in varchar2,
        p_receiver_account in varchar2,
        p_receiver_name in varchar2,
        p_receiver_edrpou in varchar2,
        p_purpose in varchar2,
        p_extra_attributes in clob,
        p_sendsms in varchar2);

    procedure edit_sbon_order_with_contr(
        p_order_id in integer,
        p_payer_account_id in integer,
        p_start_date in date,
        p_stop_date in date,
        p_payment_frequency in integer,
        p_holiday_shift in integer,
        p_provider_id in integer,
        p_personal_account in varchar2,
        p_regular_amount in number,
        p_ceiling_amount in number,
        p_extra_attributes in clob,
        p_sendsms in varchar2);

    procedure edit_sbon_order_with_no_contr(
        p_order_id in integer,
        p_payer_account_id in integer,
        p_start_date in date,
        p_stop_date in date,
        p_payment_frequency in integer,
        p_holiday_shift in integer,
        p_provider_id in integer,
        p_personal_account in varchar2,
        p_regular_amount in number,
        p_extra_attributes in clob,
        p_sendsms in varchar2);

    procedure shift_priority(
        p_order_id in integer,
        p_shift_direction in integer);

    procedure close_order(
        p_order_id in integer,
        p_close_date in date);

    function date_to_char_in_genitive(
        p_date in date)
    return varchar2;

    procedure change_order_state(
        p_order_id in integer,
        p_state_id in integer);
end;
/
CREATE OR REPLACE PACKAGE BODY BARS.STO_UI as
  G_BODY_VERSION  CONSTANT VARCHAR2(64)  :=  'version 2.2  21.04.2017';

  FUNCTION header_version
     RETURN VARCHAR2
  IS
  BEGIN
     RETURN 'Package header sto_ui ' || G_HEADER_VERSION;
  END header_version;

  FUNCTION body_version
     RETURN VARCHAR2
  IS
  BEGIN
     RETURN 'Package body sto_ui ' || G_BODY_VERSION;
  END body_version;


   function get_reciever_nms(p_mfo in varchar2, p_nls in varchar2) return varchar2
   is
    l_nms varchar2(100);
   begin
    bars_audit.info('!!!get_reciever_nms start');
    begin
     select nms
       into l_nms
       from accounts
      where nls = p_nls
        and kf = p_mfo
        and kv = 980 and rownum = 1;
    exception when no_data_found then
     begin
      select name
        into l_nms
        from alien
       where mfo = p_mfo
         and kv = 980
         and nls = p_nls and rownum = 1;
     exception when no_data_found then l_nms := null;
     end;
     when others then null; bars_audit.info(sqlerrm);
    end;
    bars_audit.info('!!!get_reciever_nms end= '|| l_nms);
   return l_nms;
   end;

      function get_reciever_okpo(p_mfo in varchar2, p_nls in varchar2) return varchar2
   is
    l_okpo varchar2(12);
   begin
    bars_audit.info('!!!get_reciever_okpo start');
    begin
     select c.okpo
       into l_okpo
       from accounts a, customer c
      where a.rnk = c.rnk
        and a.nls = p_nls
        and a.kf = p_mfo
        and a.kv = 980 and rownum = 1;
    exception when no_data_found then
     begin
      select okpo
        into l_okpo
        from alien
       where mfo = p_mfo
         and kv = 980
         and nls = p_nls and rownum = 1;
     exception when no_data_found then l_okpo := null;
     end;
     when others then null; bars_audit.info(sqlerrm);
    end;
    bars_audit.info('!!!get_reciever_okpo end= '|| l_okpo);
   return l_okpo;
   end;
    procedure check_order(
        p_payer_account_id in integer,
        p_start_date in date,
        p_stop_date in date,
        p_payment_frequency in integer)
    is
        l_account_row accounts%rowtype;
        l_error_message varchar2(4000);
    begin
        l_error_message := check_order( p_payer_account_id => p_payer_account_id, p_start_date => p_start_date, p_stop_date => p_stop_date,p_payment_frequency => p_payment_frequency);
        if (l_error_message is not null) then
            raise_application_error(-20000, l_error_message);
        end if;

    end;

   function check_order(
        p_payer_account_id in integer,
        p_start_date in date,
        p_stop_date in date,
        p_payment_frequency in integer) return varchar2
    is
        l_account_row accounts%rowtype;
        l_error_message varchar2(4000);
    begin
        if (p_payer_account_id is null or p_payer_account_id = 0) then
            l_error_message := 'Рахунок платника не вказаний';
        end if;
        if (p_start_date is null) then
            l_error_message := 'Дата початку перерахувань не може залишатися пустою';
        end if;
        if (p_start_date > p_stop_date) then
            l_error_message := 'Дата початку {' || to_char(p_start_date, sto_utl.FORMAT_DATE) ||
                                            '} не може перевищувати дату завершення перерахувань {' ||
                                            to_char(p_stop_date, sto_utl.FORMAT_DATE) || '}';
        end if;
        if (p_stop_date is not null and p_stop_date <= bankdate()) then
            l_error_message := 'Дата завершення перерахувань не може бути меньшою за ' ||
                                            'поточну банківську дату {' || to_char(bankdate(), sto_utl.FORMAT_DATE) || '}';
        end if;
        if (p_payment_frequency is null or p_payment_frequency = 0) then
            l_error_message := 'Періодичність перерахувань не вказана';
        end if;

        l_account_row := account_utl.read_account(p_payer_account_id);
        if (l_account_row.nbs not in ('2625', '2620')) then
            l_error_message := 'Неприпустимий балансовий рахунок платника {' || l_account_row.nbs || '}';
        end if;
        if (l_account_row.dazs is not null) then
            l_error_message := 'Рахунок {' || l_account_row.nls || '} закритий';
        end if;
        if (l_account_row.kv <> sto_utl.CURRENCY_CODE_HRYVNIA) then
            l_error_message :='Реєстрація розпоряджень на регулярне перерахування ' ||
                                            'коштів в валюті відмінній від Гривні не передбачено';
        end if;
        return l_error_message;
    end;


    procedure new_sep_order(
        p_payer_account_id in integer,
        p_start_date in date,
        p_stop_date in date,
        p_payment_frequency in integer,
        p_holiday_shift in integer,
        p_regular_amount in number,
        p_receiver_mfo in varchar2,
        p_receiver_account in varchar2,
        p_receiver_name in varchar2,
        p_receiver_edrpou in varchar2,
        p_purpose in varchar2,
        p_sendsms in varchar2)
    is
        l_order_id integer;
    begin
        bars_audit.trace('sto_ui.new_sep_order' || chr(10) ||
                         'p_payer_account_id  : ' || p_payer_account_id  || chr(10) ||
                         'p_start_date        : ' || p_start_date        || chr(10) ||
                         'p_stop_date         : ' || p_stop_date         || chr(10) ||
                         'p_payment_frequency : ' || p_payment_frequency || chr(10) ||
                         'p_holiday_shift     : ' || p_holiday_shift     || chr(10) ||
                         'p_regular_amount    : ' || p_regular_amount    || chr(10) ||
                         'p_receiver_mfo      : ' || p_receiver_mfo      || chr(10) ||
                         'p_receiver_account  : ' || p_receiver_account  || chr(10) ||
                         'p_receiver_name     : ' || p_receiver_name     || chr(10) ||
                         'p_receiver_edrpou   : ' || p_receiver_edrpou   || chr(10) ||
                         'p_purpose           : ' || p_purpose           || chr(10) ||
                         'p_sendsms           : ' || p_sendsms);

        if (p_start_date <= bankdate()) then
            raise_application_error(-20000, 'Дата початку перерахувань не може бути меньшою за наступний банківський день (' || to_char(bankdate() + 1, sto_utl.FORMAT_DATE) || ')');
        end if;

        check_order(p_payer_account_id, p_start_date, p_stop_date, p_payment_frequency);
        sto_utl.check_receiver(p_receiver_mfo, p_receiver_account, p_receiver_name, p_receiver_edrpou);

        l_order_id := sto_utl.create_sep_order(p_payer_account_id,
                                               p_start_date,
                                               p_stop_date,
                                               p_payment_frequency,
                                               p_holiday_shift,
                                               p_regular_amount,
                                               p_receiver_mfo,
                                               p_receiver_account,
                                               p_receiver_name,
                                               p_receiver_edrpou,
                                               p_purpose,
                                               p_sendsms);
    end;

    procedure new_free_sbon_order(
        p_payer_account_id in integer,
        p_start_date in date,
        p_stop_date in date,
        p_payment_frequency in integer,
        p_holiday_shift in integer,
        p_provider_id in integer,
        p_regular_amount in number,
        p_receiver_mfo in varchar2,
        p_receiver_account in varchar2,
        p_receiver_name in varchar2,
        p_receiver_edrpou in varchar2,
        p_purpose in varchar2,
        p_extra_attributes in clob,
        p_sendsms in varchar2)
    is
        l_order_id integer;
        l_product_row sto_product%rowtype;
    begin
        bars_audit.trace('sto_ui.new_free_sbon_order' || chr(10) ||
                         'p_payer_account_id  : ' || p_payer_account_id  || chr(10) ||
                         'p_start_date        : ' || p_start_date        || chr(10) ||
                         'p_stop_date         : ' || p_stop_date         || chr(10) ||
                         'p_payment_frequency : ' || p_payment_frequency || chr(10) ||
                         'p_holiday_shift     : ' || p_holiday_shift     || chr(10) ||
                         'p_provider_id       : ' || p_provider_id       || chr(10) ||
                         'p_regular_amount    : ' || p_regular_amount    || chr(10) ||
                         'p_receiver_mfo      : ' || p_receiver_mfo      || chr(10) ||
                         'p_receiver_account  : ' || p_receiver_account  || chr(10) ||
                         'p_receiver_name     : ' || p_receiver_name     || chr(10) ||
                         'p_receiver_edrpou   : ' || p_receiver_edrpou   || chr(10) ||
                         'p_purpose           : ' || p_purpose);

        if (p_start_date <= bankdate()) then
            raise_application_error(-20000, 'Дата початку перерахувань не може бути меньшою за наступний банківський день (' || to_char(bankdate() + 1, sto_utl.FORMAT_DATE) || ')');
        end if;

        check_order(p_payer_account_id, p_start_date, p_stop_date, p_payment_frequency);

        if (p_regular_amount is null or p_regular_amount = 0) then
            raise_application_error(-20000, 'Сума регулярного перерахування не вказана');
        end if;

        l_product_row := sto_utl.read_product(p_provider_id);

        if (l_product_row.order_type_id <> sto_utl.STO_TYPE_SBON_PAYMENT_FREE) then
            raise_application_error(-20000, 'Режим роботи провайдера {' || l_product_row.order_type_id ||
                                            '} не відповідає типу платежу {' || sto_utl.STO_TYPE_SBON_PAYMENT_FREE || '}');
        end if;

        sto_utl.check_receiver(p_receiver_mfo, p_receiver_account, p_receiver_name, p_receiver_edrpou);

        l_order_id := sto_sbon_utl.create_free_sbon_order(p_provider_id,
                                                          p_payer_account_id,
                                                          p_start_date,
                                                          p_stop_date,
                                                          p_payment_frequency,
                                                          p_holiday_shift,
                                                          p_regular_amount,
                                                          p_receiver_mfo,
                                                          p_receiver_account,
                                                          p_receiver_name,
                                                          p_receiver_edrpou,
                                                          p_purpose,
                                                          p_sendsms);

        sto_utl.set_order_extra_attributes(l_order_id, p_extra_attributes);
    end;

        procedure new_free_sbon_order_ext(
        p_payer_account_id in integer,
        p_start_date in date,
        p_stop_date in date,
        p_payment_frequency in integer,
        p_holiday_shift in integer,
        p_provider_id in integer,
        p_regular_amount in number,
        p_receiver_mfo in varchar2,
        p_receiver_account in varchar2,
        p_receiver_name in varchar2,
        p_receiver_edrpou in varchar2,
        p_purpose in varchar2,
        p_extra_attributes in clob,
        p_sendsms in varchar2,
        p_order_id out number,
        p_result_code out number,
        p_result_message out varchar2)
    is
        l_order_id integer;
        l_product_row sto_product%rowtype;
    begin
        p_order_id := -1;
        p_result_code := 0;
        bars_audit.trace('sto_ui.new_free_sbon_order' || chr(10) ||
                         'p_payer_account_id  : ' || p_payer_account_id  || chr(10) ||
                         'p_start_date        : ' || p_start_date        || chr(10) ||
                         'p_stop_date         : ' || p_stop_date         || chr(10) ||
                         'p_payment_frequency : ' || p_payment_frequency || chr(10) ||
                         'p_holiday_shift     : ' || p_holiday_shift     || chr(10) ||
                         'p_provider_id       : ' || p_provider_id       || chr(10) ||
                         'p_regular_amount    : ' || p_regular_amount    || chr(10) ||
                         'p_receiver_mfo      : ' || p_receiver_mfo      || chr(10) ||
                         'p_receiver_account  : ' || p_receiver_account  || chr(10) ||
                         'p_receiver_name     : ' || p_receiver_name     || chr(10) ||
                         'p_receiver_edrpou   : ' || p_receiver_edrpou   || chr(10) ||
                         'p_purpose           : ' || p_purpose);

        if (p_start_date <= bankdate()) then
            p_result_code:= -1;
            p_result_message:= 'Дата початку перерахувань не може бути меньшою за наступний банківський день (' || to_char(bankdate() + 1, sto_utl.FORMAT_DATE) || ')';
            return;
        end if;

        p_result_message:= check_order(p_payer_account_id, p_start_date, p_stop_date, p_payment_frequency);
        if (p_result_message is not null) then return; end if;

        if (p_regular_amount is null or p_regular_amount = 0) then
            p_result_code:= -1;
            p_result_message:= 'Сума регулярного перерахування не вказана';
            return;
        end if;

        l_product_row := sto_utl.read_product(p_provider_id);

        if (l_product_row.order_type_id <> sto_utl.STO_TYPE_SBON_PAYMENT_FREE) then
           p_result_code:= -1;
           p_result_message:= 'Режим роботи провайдера {' || l_product_row.order_type_id ||'} не відповідає типу платежу {' || sto_utl.STO_TYPE_SBON_PAYMENT_FREE || '}';
           return;
        end if;

        sto_utl.check_receiver(p_receiver_mfo, p_receiver_account, p_receiver_name, p_receiver_edrpou);

        l_order_id := sto_sbon_utl.create_free_sbon_order(p_provider_id,
                                                          p_payer_account_id,
                                                          p_start_date,
                                                          p_stop_date,
                                                          p_payment_frequency,
                                                          p_holiday_shift,
                                                          p_regular_amount,
                                                          p_receiver_mfo,
                                                          p_receiver_account,
                                                          p_receiver_name,
                                                          p_receiver_edrpou,
                                                          p_purpose,
                                                          p_sendsms);

        sto_utl.set_order_extra_attributes(l_order_id, p_extra_attributes);
        p_order_id := l_order_id;
        if (p_order_id is not null) then p_result_message := 'Ok'; end if;
    end;

    procedure new_sbon_order_with_contr(
        p_payer_account_id in integer,
        p_start_date in date,
        p_stop_date in date,
        p_payment_frequency in integer,
        p_holiday_shift in integer,
        p_provider_id in integer,
        p_personal_account in varchar2,
        p_regular_amount in number,
        p_ceiling_amount in number,
        p_extra_attributes in clob,
        p_sendsms in varchar2)
    is
        l_order_id integer;
        l_product_row sto_product%rowtype;
    begin
        bars_audit.trace('sto_ui.new_sbon_order_with_contr' || chr(10) ||
                         'p_payer_account_id  : ' || p_payer_account_id  || chr(10) ||
                         'p_start_date        : ' || p_start_date        || chr(10) ||
                         'p_stop_date         : ' || p_stop_date         || chr(10) ||
                         'p_payment_frequency : ' || p_payment_frequency || chr(10) ||
                         'p_holiday_shift     : ' || p_holiday_shift     || chr(10) ||
                         'p_provider_id       : ' || p_provider_id       || chr(10) ||
                         'p_personal_account  : ' || p_personal_account  || chr(10) ||
                         'p_regular_amount    : ' || p_regular_amount    || chr(10) ||
                         'p_ceiling_amount    : ' || p_ceiling_amount);

        if (p_start_date <= bankdate()) then
            raise_application_error(-20000, 'Дата початку перерахувань не може бути меньшою за наступний банківський день (' || to_char(bankdate() + 1, sto_utl.FORMAT_DATE) || ')');
        end if;

        check_order(p_payer_account_id, p_start_date, p_stop_date, p_payment_frequency);

        if (p_personal_account is null) then
            raise_application_error(-20000, 'Має бути вказаний номер договору клієнта з провайдером');
        end if;
        if ((p_regular_amount is null or p_regular_amount = 0) and
            (p_ceiling_amount is null or p_ceiling_amount = 0)) then
            raise_application_error(-20000, 'Має бути вказана фіксована або гранична сума перерахування');
        end if;
        if (p_regular_amount is not null and p_regular_amount <> 0 and
            p_ceiling_amount is not null and p_ceiling_amount <> 0) then
            raise_application_error(-20000, 'Лише одна з двох сум платежу (фіксована або максимальна) може бути вказана');
        end if;

        l_product_row := sto_utl.read_product(p_provider_id);

        if (l_product_row.order_type_id <> sto_utl.STO_TYPE_SBON_PAYMENT_CONTR) then
            raise_application_error(-20000, 'Режим роботи провайдера {' || l_product_row.order_type_id ||
                                            '} не відповідає типу платежу {' || sto_utl.STO_TYPE_SBON_PAYMENT_CONTR || '}');
        end if;

        l_order_id := sto_sbon_utl.create_sbon_order_with_contr(p_provider_id,
                                                                p_payer_account_id,
                                                                p_start_date,
                                                                p_stop_date,
                                                                p_payment_frequency,
                                                                p_holiday_shift,
                                                                p_personal_account,
                                                                case when p_regular_amount = 0 then null
                                                                     else p_regular_amount
                                                                end,
                                                                case when p_ceiling_amount = 0 then null
                                                                     else p_ceiling_amount
                                                                end,
                                                                p_sendsms);

        sto_utl.set_order_extra_attributes(l_order_id, p_extra_attributes);
    end;

     procedure new_sbon_order_with_contr_ext(
        p_payer_account_id in integer,
        p_start_date in date,
        p_stop_date in date,
        p_payment_frequency in integer,
        p_holiday_shift in integer,
        p_provider_id in integer,
        p_personal_account in varchar2,
        p_regular_amount in number,
        p_ceiling_amount in number,
        p_extra_attributes in clob,
        p_sendsms in varchar2,
        p_order_id out number,
        p_result_code out number,
        p_result_message out varchar2)
    is
        l_order_id integer;
        l_product_row sto_product%rowtype;
    begin
        p_result_code := 0;
        p_order_id := -1;
        bars_audit.trace('sto_ui.new_sbon_order_with_contr_ex' || chr(10) ||
                         'p_payer_account_id  : ' || p_payer_account_id  || chr(10) ||
                         'p_start_date        : ' || p_start_date        || chr(10) ||
                         'p_stop_date         : ' || p_stop_date         || chr(10) ||
                         'p_payment_frequency : ' || p_payment_frequency || chr(10) ||
                         'p_holiday_shift     : ' || p_holiday_shift     || chr(10) ||
                         'p_provider_id       : ' || p_provider_id       || chr(10) ||
                         'p_personal_account  : ' || p_personal_account  || chr(10) ||
                         'p_regular_amount    : ' || p_regular_amount    || chr(10) ||
                         'p_ceiling_amount    : ' || p_ceiling_amount);

        if (p_start_date <= bankdate()) then
            p_result_code := -1;
            p_result_message := 'Дата початку перерахувань не може бути меньшою за наступний банківський день (' || to_char(bankdate() + 1, sto_utl.FORMAT_DATE) || ')';
            return;
        end if;

        p_result_message :=  check_order(p_payer_account_id, p_start_date, p_stop_date, p_payment_frequency);
        if (p_result_message is not null) then return; end if;

        if (p_personal_account is null) then
            p_result_code := -1;
            p_result_message := 'Має бути вказаний номер договору клієнта з провайдером';
            return;
        end if;
        if ((p_regular_amount is null or p_regular_amount = 0) and
            (p_ceiling_amount is null or p_ceiling_amount = 0)) then
            p_result_code := -1;
            p_result_message :='Має бути вказана фіксована або гранична сума перерахування';
            return;
        end if;
        if (p_regular_amount is not null and p_regular_amount <> 0 and
            p_ceiling_amount is not null and p_ceiling_amount <> 0) then
            p_result_code := -1;
            p_result_message :='Лише одна з двох сум платежу (фіксована або максимальна) може бути вказана';
            return;
        end if;

        l_product_row := sto_utl.read_product(p_provider_id);

        if (l_product_row.order_type_id <> sto_utl.STO_TYPE_SBON_PAYMENT_CONTR) then
            p_result_code := -1;
            p_result_message :='Режим роботи провайдера {' || l_product_row.order_type_id ||
                                            '} не відповідає типу платежу {' || sto_utl.STO_TYPE_SBON_PAYMENT_CONTR || '}';
            return;
        end if;

        l_order_id := sto_sbon_utl.create_sbon_order_with_contr(p_provider_id,
                                                                p_payer_account_id,
                                                                p_start_date,
                                                                p_stop_date,
                                                                p_payment_frequency,
                                                                p_holiday_shift,
                                                                p_personal_account,
                                                                case when p_regular_amount = 0 then null
                                                                     else p_regular_amount
                                                                end,
                                                                case when p_ceiling_amount = 0 then null
                                                                     else p_ceiling_amount
                                                                end,
                                                                p_sendsms);

        sto_utl.set_order_extra_attributes(l_order_id, p_extra_attributes);
        p_order_id := l_order_id;
        if (p_order_id is not null) then p_result_message := 'Ok'; end if;
    end;

    procedure new_sbon_order_with_no_contr(
        p_payer_account_id in integer,
        p_start_date in date,
        p_stop_date in date,
        p_payment_frequency in integer,
        p_holiday_shift in integer,
        p_provider_id in integer,
        p_personal_account in varchar2,
        p_regular_amount in number,
        p_extra_attributes in clob,
        p_sendsms in varchar2)
    is
        l_order_id integer;
        l_product_row sto_product%rowtype;
    begin
        bars_audit.trace('sto_ui.new_sbon_order_with_no_contr' || chr(10) ||
                         'p_payer_account_id  : ' || p_payer_account_id  || chr(10) ||
                         'p_start_date        : ' || p_start_date        || chr(10) ||
                         'p_stop_date         : ' || p_stop_date         || chr(10) ||
                         'p_payment_frequency : ' || p_payment_frequency || chr(10) ||
                         'p_holiday_shift     : ' || p_holiday_shift     || chr(10) ||
                         'p_provider_id       : ' || p_provider_id       || chr(10) ||
                         'p_personal_account  : ' || p_personal_account  || chr(10) ||
                         'p_regular_amount    : ' || p_regular_amount);

        if (p_start_date <= bankdate()) then
            raise_application_error(-20000, 'Дата початку перерахувань не може бути меньшою за наступний банківський день (' || to_char(bankdate() + 1, sto_utl.FORMAT_DATE) || ')');
        end if;

        check_order(p_payer_account_id, p_start_date, p_stop_date, p_payment_frequency);

        if (p_regular_amount is null or p_regular_amount = 0) then
            raise_application_error(-20000, 'Сума регулярного перерахування не вказана');
        end if;

        l_product_row := sto_utl.read_product(p_provider_id);

        if (l_product_row.order_type_id <> sto_utl.STO_TYPE_SBON_PAYMENT_NOCONTR) then
            raise_application_error(-20000, 'Режим роботи провайдера {' || l_product_row.order_type_id ||
                                            '} не відповідає типу платежу {' || sto_utl.STO_TYPE_SBON_PAYMENT_NOCONTR || '}');
        end if;

        l_order_id := sto_sbon_utl.create_sbon_order_with_nocontr(p_provider_id,
                                                                  p_payer_account_id,
                                                                  p_start_date,
                                                                  p_stop_date,
                                                                  p_payment_frequency,
                                                                  p_holiday_shift,
                                                                  p_personal_account,
                                                                  p_regular_amount,
                                                                  p_sendsms);

        sto_utl.set_order_extra_attributes(l_order_id, p_extra_attributes);
    end;

        procedure new_sbon_order_with_no_contr_e(
        p_payer_account_id in integer,
        p_start_date in date,
        p_stop_date in date,
        p_payment_frequency in integer,
        p_holiday_shift in integer,
        p_provider_id in integer,
        p_personal_account in varchar2,
        p_regular_amount in number,
        p_extra_attributes in clob,
        p_sendsms in varchar2,
        p_order_id out number,
        p_result_code out number,
        p_result_message out varchar2)
    is
        l_order_id integer;
        l_product_row sto_product%rowtype;
    begin
        p_order_id := -1;
        p_result_code := 0;
        bars_audit.trace('sto_ui.new_sbon_order_with_no_contr' || chr(10) ||
                         'p_payer_account_id  : ' || p_payer_account_id  || chr(10) ||
                         'p_start_date        : ' || p_start_date        || chr(10) ||
                         'p_stop_date         : ' || p_stop_date         || chr(10) ||
                         'p_payment_frequency : ' || p_payment_frequency || chr(10) ||
                         'p_holiday_shift     : ' || p_holiday_shift     || chr(10) ||
                         'p_provider_id       : ' || p_provider_id       || chr(10) ||
                         'p_personal_account  : ' || p_personal_account  || chr(10) ||
                         'p_regular_amount    : ' || p_regular_amount);

        if (p_start_date <= bankdate()) then
           p_result_code := -1;
           p_result_message := 'Дата початку перерахувань не може бути меньшою за наступний банківський день (' || to_char(bankdate() + 1, sto_utl.FORMAT_DATE) || ')';
           return;
        end if;

        p_result_message:= check_order(p_payer_account_id, p_start_date, p_stop_date, p_payment_frequency);
        if (p_result_message is not null) then return; end if;

        if (p_regular_amount is null or p_regular_amount = 0) then
           p_result_code := -1;
           p_result_message := 'Сума регулярного перерахування не вказана';
           return;
        end if;

        l_product_row := sto_utl.read_product(p_provider_id);

        if (l_product_row.order_type_id <> sto_utl.STO_TYPE_SBON_PAYMENT_NOCONTR) then
           p_result_code := -1;
           p_result_message := 'Режим роботи провайдера {' || l_product_row.order_type_id ||
                                            '} не відповідає типу платежу {' || sto_utl.STO_TYPE_SBON_PAYMENT_NOCONTR || '}';
           return;
        end if;

        l_order_id := sto_sbon_utl.create_sbon_order_with_nocontr(p_provider_id,
                                                                  p_payer_account_id,
                                                                  p_start_date,
                                                                  p_stop_date,
                                                                  p_payment_frequency,
                                                                  p_holiday_shift,
                                                                  p_personal_account,
                                                                  p_regular_amount,
                                                                  p_sendsms);

        sto_utl.set_order_extra_attributes(l_order_id, p_extra_attributes);
        p_order_id := l_order_id;
        if (p_order_id is not null) then p_result_message := 'Ok'; end if;
    end;

    procedure edit_sep_order(
        p_order_id in integer,
        p_payer_account_id in integer,
        p_start_date in date,
        p_stop_date in date,
        p_payment_frequency in integer,
        p_holiday_shift in integer,
        p_regular_amount in number,
        p_receiver_mfo in varchar2,
        p_receiver_account in varchar2,
        p_receiver_name in varchar2,
        p_receiver_edrpou in varchar2,
        p_purpose in varchar2,
        p_sendsms in varchar2)
    is
        l_order_row sto_order%rowtype;
    begin
        bars_audit.trace('sto_ui.new_sep_order' || chr(10) ||
                         'p_payer_account_id  : ' || p_payer_account_id  || chr(10) ||
                         'p_start_date        : ' || p_start_date        || chr(10) ||
                         'p_stop_date         : ' || p_stop_date         || chr(10) ||
                         'p_payment_frequency : ' || p_payment_frequency || chr(10) ||
                         'p_holiday_shift     : ' || p_holiday_shift     || chr(10) ||
                         'p_regular_amount    : ' || p_regular_amount    || chr(10) ||
                         'p_receiver_mfo      : ' || p_receiver_mfo      || chr(10) ||
                         'p_receiver_account  : ' || p_receiver_account  || chr(10) ||
                         'p_receiver_name     : ' || p_receiver_name     || chr(10) ||
                         'p_receiver_edrpou   : ' || p_receiver_edrpou   || chr(10) ||
                         'p_purpose           : ' || p_purpose);

        if (p_regular_amount is null or p_regular_amount = 0) then
            raise_application_error(-20000, 'Сума регулярного перерахування не вказана');
        end if;

        check_order(p_payer_account_id, p_start_date, p_stop_date, p_payment_frequency);

        sto_utl.check_receiver(p_receiver_mfo, p_receiver_account, p_receiver_name, p_receiver_edrpou);

        l_order_row := sto_utl.read_order(p_order_id, p_lock => true);
        if (p_start_date <= bankdate() and l_order_row.start_date <> p_start_date) then
            -- змінили дату першого платежу - повторно виконаємо перевірку на перевищення банківського дня
            raise_application_error(-20000, 'Дата початку перерахувань не може бути меньшою за наступний банківський день (' || to_char(bankdate() + 1, sto_utl.FORMAT_DATE) || ')');
        end if;

        sto_utl.update_sep_order(p_order_id,
                                 p_payer_account_id,
                                 p_start_date,
                                 p_stop_date,
                                 p_payment_frequency,
                                 p_holiday_shift,
                                 p_regular_amount,
                                 p_receiver_mfo,
                                 p_receiver_account,
                                 p_receiver_name,
                                 p_receiver_edrpou,
                                 p_purpose,
                                 p_sendsms);
    end;

    procedure edit_free_sbon_order(
        p_order_id in integer,
        p_payer_account_id in integer,
        p_start_date in date,
        p_stop_date in date,
        p_payment_frequency in integer,
        p_holiday_shift in integer,
        p_provider_id in integer,
        p_regular_amount in number,
        p_receiver_mfo in varchar2,
        p_receiver_account in varchar2,
        p_receiver_name in varchar2,
        p_receiver_edrpou in varchar2,
        p_purpose in varchar2,
        p_extra_attributes in clob,
        p_sendsms in varchar2)
    is
        l_order_row sto_order%rowtype;
        l_product_row sto_product%rowtype;
    begin
        bars_audit.trace('sto_ui.new_free_sbon_order' || chr(10) ||
                         'p_payer_account_id  : ' || p_order_id          || chr(10) ||
                         'p_start_date        : ' || p_start_date        || chr(10) ||
                         'p_stop_date         : ' || p_stop_date         || chr(10) ||
                         'p_payment_frequency : ' || p_payment_frequency || chr(10) ||
                         'p_holiday_shift     : ' || p_holiday_shift     || chr(10) ||
                         'p_provider_id       : ' || p_provider_id       || chr(10) ||
                         'p_regular_amount    : ' || p_regular_amount    || chr(10) ||
                         'p_receiver_mfo      : ' || p_receiver_mfo      || chr(10) ||
                         'p_receiver_account  : ' || p_receiver_account  || chr(10) ||
                         'p_receiver_name     : ' || p_receiver_name     || chr(10) ||
                         'p_receiver_edrpou   : ' || p_receiver_edrpou   || chr(10) ||
                         'p_purpose           : ' || p_purpose);

        check_order(p_payer_account_id, p_start_date, p_stop_date, p_payment_frequency);

        if (p_regular_amount is null or p_regular_amount = 0) then
            raise_application_error(-20000, 'Сума регулярного перерахування не вказана');
        end if;

        l_product_row := sto_utl.read_product(p_provider_id);

        if (l_product_row.order_type_id <> sto_utl.STO_TYPE_SBON_PAYMENT_FREE) then
            raise_application_error(-20000, 'Режим роботи провайдера {' || l_product_row.order_type_id ||
                                            '} не відповідає типу платежу {' || sto_utl.STO_TYPE_SBON_PAYMENT_FREE || '}');
        end if;

        sto_utl.check_receiver(p_receiver_mfo, p_receiver_account, p_receiver_name, p_receiver_edrpou);

        l_order_row := sto_utl.read_order(p_order_id, p_lock => true);
        if (p_start_date <= bankdate() and l_order_row.start_date <> p_start_date) then
            -- змінили дату першого платежу - повторно виконаємо перевірку на перевищення банківського дня
            raise_application_error(-20000, 'Дата початку перерахувань не може бути меньшою за наступний банківський день (' || to_char(bankdate() + 1, sto_utl.FORMAT_DATE) || ')');
        end if;

        sto_sbon_utl.update_free_sbon_order(p_order_id,
                                            p_payer_account_id,
                                            p_start_date,
                                            p_stop_date,
                                            p_payment_frequency,
                                            p_holiday_shift,
                                            p_provider_id,
                                            p_regular_amount,
                                            p_receiver_mfo,
                                            p_receiver_account,
                                            p_receiver_name,
                                            p_receiver_edrpou,
                                            p_purpose,
                                            p_sendsms);

        sto_utl.set_order_extra_attributes(p_order_id, p_extra_attributes);
    end;

    procedure edit_sbon_order_with_contr(
        p_order_id in integer,
        p_payer_account_id in integer,
        p_start_date in date,
        p_stop_date in date,
        p_payment_frequency in integer,
        p_holiday_shift in integer,
        p_provider_id in integer,
        p_personal_account in varchar2,
        p_regular_amount in number,
        p_ceiling_amount in number,
        p_extra_attributes in clob,
        p_sendsms in varchar2)
    is
        l_order_row sto_order%rowtype;
        l_product_row sto_product%rowtype;
    begin
        bars_audit.trace('sto_ui.new_sbon_order_with_contr' || chr(10) ||
                         'p_payer_account_id  : ' || p_order_id          || chr(10) ||
                         'p_start_date        : ' || p_start_date        || chr(10) ||
                         'p_stop_date         : ' || p_stop_date         || chr(10) ||
                         'p_payment_frequency : ' || p_payment_frequency || chr(10) ||
                         'p_holiday_shift     : ' || p_holiday_shift     || chr(10) ||
                         'p_provider_id       : ' || p_provider_id       || chr(10) ||
                         'p_personal_account  : ' || p_personal_account  || chr(10) ||
                         'p_regular_amount    : ' || p_regular_amount    || chr(10) ||
                         'p_ceiling_amount    : ' || p_ceiling_amount);

        check_order(p_payer_account_id, p_start_date, p_stop_date, p_payment_frequency);

        if (p_personal_account is null) then
            raise_application_error(-20000, 'Має бути вказаний номер договору клієнта з провайдером');
        end if;
        if ((p_regular_amount is null or p_regular_amount = 0) and
            (p_ceiling_amount is null or p_ceiling_amount = 0)) then
            raise_application_error(-20000, 'Має бути вказана фіксована або гранична сума перерахування');
        end if;
        if (p_regular_amount is not null and p_regular_amount <> 0 and
            p_ceiling_amount is not null and p_ceiling_amount <> 0) then
            raise_application_error(-20000, 'Лише одна з двох сум платежу (фіксована або максимальна) може бути вказана');
        end if;

        l_product_row := sto_utl.read_product(p_provider_id);

        if (l_product_row.order_type_id <> sto_utl.STO_TYPE_SBON_PAYMENT_CONTR) then
            raise_application_error(-20000, 'Режим роботи провайдера {' || l_product_row.order_type_id ||
                                            '} не відповідає типу платежу {' || sto_utl.STO_TYPE_SBON_PAYMENT_CONTR || '}');
        end if;

        l_order_row := sto_utl.read_order(p_order_id, p_lock => true);
        if (p_start_date <= bankdate() and l_order_row.start_date <> p_start_date) then
            -- змінили дату першого платежу - повторно виконаємо перевірку на перевищення банківського дня
            raise_application_error(-20000, 'Дата початку перерахувань не може бути меньшою за наступний банківський день (' || to_char(bankdate() + 1, sto_utl.FORMAT_DATE) || ')');
        end if;

        sto_sbon_utl.update_sbon_order_with_contr(p_order_id,
                                                  p_payer_account_id,
                                                  p_start_date,
                                                  p_stop_date,
                                                  p_payment_frequency,
                                                  p_holiday_shift,
                                                  p_provider_id,
                                                  p_personal_account,
                                                  case when p_regular_amount = 0 then null
                                                       else p_regular_amount
                                                  end,
                                                  case when p_ceiling_amount = 0 then null
                                                       else p_ceiling_amount
                                                  end,
                                                  p_sendsms);

        sto_utl.set_order_extra_attributes(p_order_id, p_extra_attributes);
    end;

    procedure edit_sbon_order_with_no_contr(
        p_order_id in integer,
        p_payer_account_id in integer,
        p_start_date in date,
        p_stop_date in date,
        p_payment_frequency in integer,
        p_holiday_shift in integer,
        p_provider_id in integer,
        p_personal_account in varchar2,
        p_regular_amount in number,
        p_extra_attributes in clob,
        p_sendsms in varchar2)
    is
        l_order_row sto_order%rowtype;
        l_product_row sto_product%rowtype;
    begin
        bars_audit.trace('sto_ui.new_sbon_order_with_no_contr' || chr(10) ||
                         'p_payer_account_id  : ' || p_order_id          || chr(10) ||
                         'p_start_date        : ' || p_start_date        || chr(10) ||
                         'p_stop_date         : ' || p_stop_date         || chr(10) ||
                         'p_payment_frequency : ' || p_payment_frequency || chr(10) ||
                         'p_holiday_shift     : ' || p_holiday_shift     || chr(10) ||
                         'p_provider_id       : ' || p_provider_id       || chr(10) ||
                         'p_personal_account  : ' || p_personal_account  || chr(10) ||
                         'p_regular_amount    : ' || p_regular_amount);
        check_order(p_payer_account_id, p_start_date, p_stop_date, p_payment_frequency);

        if (p_regular_amount is null or p_regular_amount = 0) then
            raise_application_error(-20000, 'Сума регулярного перерахування не вказана');
        end if;

        l_product_row := sto_utl.read_product(p_provider_id);

        if (l_product_row.order_type_id <> sto_utl.STO_TYPE_SBON_PAYMENT_NOCONTR) then
            raise_application_error(-20000, 'Режим роботи провайдера {' || l_product_row.order_type_id ||
                                            '} не відповідає типу платежу {' || sto_utl.STO_TYPE_SBON_PAYMENT_NOCONTR || '}');
        end if;

        l_order_row := sto_utl.read_order(p_order_id, p_lock => true);
        if (p_start_date <= bankdate() and l_order_row.start_date <> p_start_date) then
            -- змінили дату першого платежу - повторно виконаємо перевірку на перевищення банківського дня
            raise_application_error(-20000, 'Дата початку перерахувань не може бути меньшою за наступний банківський день (' || to_char(bankdate() + 1, sto_utl.FORMAT_DATE) || ')');
        end if;

        sto_sbon_utl.update_sbon_order_with_nocontr(p_order_id,
                                                    p_payer_account_id,
                                                    p_start_date,
                                                    p_stop_date,
                                                    p_payment_frequency,
                                                    p_holiday_shift,
                                                    p_provider_id,
                                                    p_personal_account,
                                                    p_regular_amount,
                                                    p_sendsms);

        sto_utl.set_order_extra_attributes(p_order_id, p_extra_attributes);
    end;

    -- зміна порядку оплати розпоряджень по одному рахунку
    function get_prev_order(p_order_row in sto_order%rowtype)
    return sto_order%rowtype
    is
        l_order_row sto_order%rowtype;
    begin
        select *
        into   l_order_row
        from   sto_order o
        where  o.rowid = (select min(od.rowid) keep (dense_rank last order by od.priority)
                          from   sto_order od
                          where  od.payer_account_id = p_order_row.payer_account_id and
                                 od.priority < p_order_row.priority and
                                 od.cancel_date is null and
                                 (od.stop_date is null or od.stop_date >= bankdate()));

        return l_order_row;
    exception
        when no_data_found then
             return null;
    end;

    function get_next_order(p_order_row in sto_order%rowtype)
    return sto_order%rowtype
    is
        l_order_row sto_order%rowtype;
    begin
        select *
        into   l_order_row
        from   sto_order o
        where  o.rowid = (select min(od.rowid) keep (dense_rank first order by od.priority)
                          from   sto_order od
                          where  od.payer_account_id = p_order_row.payer_account_id and
                                 od.priority > p_order_row.priority and
                                 od.cancel_date is null and
                                 (od.stop_date is null or od.stop_date >= bankdate()));

        return l_order_row;
    exception
        when no_data_found then
             return null;
    end;

    procedure shift_priority(
        p_order_id in integer,
        p_shift_direction in integer)
    is
        l_order_row sto_order%rowtype;
        l_another_order_row sto_order%rowtype;
    begin
        bars_audit.debug('sto_ui.shift_priority' || chr(10) ||
                         'p_order_id        : ' || p_order_id || chr(10) ||
                         'p_shift_direction : ' || p_shift_direction);

        l_order_row := sto_utl.read_order(p_order_id);
        if (p_shift_direction > 0) then
            l_another_order_row := get_next_order(l_order_row);
            if (l_another_order_row.id is not null) then
                sto_utl.set_order_priority(l_another_order_row.id, l_order_row.priority);
                sto_utl.set_order_priority(l_order_row.id, l_order_row.priority + 1);
            end if;
        elsif (p_shift_direction < 0) then
            l_another_order_row := get_prev_order(l_order_row);
            if (l_another_order_row.id is not null) then
                sto_utl.set_order_priority(l_another_order_row.id, l_order_row.priority);
                sto_utl.set_order_priority(l_order_row.id, l_order_row.priority - 1);
            end if;
        end if;
    end;

    procedure close_order(
        p_order_id in integer,
        p_close_date in date)
    is
        l_close_date date default p_close_date;
    begin
        if (l_close_date is null) then
            l_close_date := bankdate;
        end if;

        sto_utl.close_order(p_order_id, l_close_date);

    end;

    function date_to_char_in_genitive(
        p_date in date)
    return varchar2
    is
        l_day integer;
        l_month integer;
        l_year integer;
        l_month_in_genitive varchar2(30 char);
    begin
        if (p_date is null) then
            return null;
        end if;

        l_day := extract(day from p_date);
        l_month := extract(month from p_date);
        l_year := extract(year from p_date);

        l_month_in_genitive := case when l_month =  1 then 'січня'
                                    when l_month =  2 then 'лютого'
                                    when l_month =  3 then 'березня'
                                    when l_month =  4 then 'квітня'
                                    when l_month =  5 then 'травня'
                                    when l_month =  6 then 'червня'
                                    when l_month =  7 then 'липня'
                                    when l_month =  8 then 'серпня'
                                    when l_month =  9 then 'вересня'
                                    when l_month = 10 then 'жовтня'
                                    when l_month = 11 then 'листопада'
                                    when l_month = 12 then 'грудня'
                               end;

        return to_char(l_day, 'FM90') || ' ' || l_month_in_genitive || ' ' || to_char(l_year, 'FM9990');
    end;

    procedure change_order_state(
        p_order_id in integer,
        p_state_id in integer) is
    begin
       sto_utl.set_order_state(p_order_id, p_state_id);
    end;
end;
/
 show err;
 
PROMPT *** Create  grants  STO_UI ***
grant DEBUG,EXECUTE                                                          on STO_UI          to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/sto_ui.sql =========*** End *** ====
 PROMPT ===================================================================================== 
 