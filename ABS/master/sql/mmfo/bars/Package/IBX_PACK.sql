
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/ibx_pack.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
CREATE OR REPLACE PACKAGE BARS.IBX_PACK is

  -- ===============================================================================================
  g_header_version constant varchar2(64) := 'version 2.0.2 22.01.2018';
  -- Имя пакета
  g_pack constant varchar2(100) := 'ibx_pack';
  -- Имя модуля для работы с ошибками
  g_mod constant varchar2(3) := 'IBX';
  --
  -- возвращает версию заголовка пакета
  function header_version return varchar2;
  -- возвращает версию тела пакета
  function body_version return varchar2;
  -- ===============================================================================================

---
-- Получение сумы %% к оплате
--
 function  Int_for_pay (p_nd number) return number;

   type varchar2_list_pck is table of varchar2(4000) index by binary_integer;

  /*
   IBox - проплата задолжености (ON-line оплата с терминала)
  */
  /*procedure pay(p_type_id    in ibx_recs.type_id%type, -- Тип интерфейса
                p_ext_ref    in ibx_recs.ext_ref%type, -- Референс документа в IBox
                p_ext_date   in ibx_recs.ext_date%type, -- Дата/время операции в IBox
                p_ext_source in ibx_recs.ext_source%type, -- Источник платежа в IBox
                p_deal_id    in ibx_recs.deal_id%type, -- Ид. сделки
                p_sum        in ibx_recs.summ%type, -- Сумма операции (в коп)
                p_res_code   out number, -- Код результата
                p_res_text   out varchar2, -- Текст результата
                p_res_ref    out oper.ref%type -- Референс-результат оплаты
                );

   procedure pay_nonstop24(p_type_id    in ibx_recs.type_id%type, -- Тип интерфейса
                p_ext_ref    in ibx_recs.ext_ref%type, -- Референс документа в IBox
                p_ext_date   in ibx_recs.ext_date%type, -- Дата/время операции в IBox
                p_ext_source in ibx_recs.ext_source%type, -- Источник платежа в IBox
                p_deal_id    in ibx_recs.deal_id%type, -- Ид. сделки
                p_sum        in ibx_recs.summ%type, -- Сумма операции (в коп)
                        p_sign       in varchar2,
                        p_act        in number,
                        p_serv_id    in varchar2,
                p_res_code   out number, -- Код результата
                p_res_text   out varchar2, -- Текст результата
                p_res_ref    out oper.ref%type -- Референс-результат оплаты
                );

   procedure pay_qiwi(p_type_id    in ibx_recs.type_id%type, -- Тип интерфейса
                p_ext_ref    in ibx_recs.ext_ref%type, -- Референс документа в IBox
                p_ext_date   in varchar2, -- Дата/время операции в IBox
                p_ext_source in ibx_recs.ext_source%type, -- Источник платежа в IBox
                p_deal_id    in varchar2, -- Ид. сделки
                p_sum        in varchar2, -- Сумма операции (в коп)
                      p_res_code   out number, -- Код результата
                p_res_text   out varchar2, -- Текст результата
                p_res_date   out varchar2, -- дата поступления в АБС
                p_res_ref    out oper.ref%type -- Референс-результат оплаты
                );
    procedure bak_qiwi(p_type_id    in ibx_recs.type_id%type, -- Тип интерфейса
                p_ext_ref    in ibx_recs.ext_ref%type, -- Референс документа в IBox
                p_ext_date   in varchar2, -- Дата/время операции в IBox
                p_ext_ref_bak    in ibx_recs.ext_ref%type, -- Референс документа в IBox на который пришло сторно
                p_ext_date_bak   in varchar2, -- Дата/время операции в IBox на который пришло сторно
                p_deal_id    in varchar2, -- Ид. сделки
                p_sum        in varchar2, -- Сумма операции (в коп)
                      p_res_code   out number, -- Код результата
                p_res_text   out varchar2, -- Текст результата
                p_res_ref    out oper.ref%type -- Референс-результат оплаты
                );*/

  procedure get_info_osc(p_acc_id in w4_acc.acc_pk%type,
                         p_sign   in varchar2,
                         p_bs_id  out ibx_types.id%type,
                         p_comp_id out varchar2,
                         p_res_code out number,
                         p_res_text out varchar2
                        );


  procedure pay_osc(p_type_id    in ibx_recs.type_id%type, -- Тип интерфейса           bs_id
                p_ext_ref    in ibx_recs.ext_ref%type, -- Референс документа в IBox    id
                p_ext_date   in varchar2, -- Дата/время операции в IBox  date
                p_ext_source in varchar2, --код  терминала
                p_receipt_num in varchar2,--номер чека                
                p_deal_id    in ibx_recs.deal_id%type, -- Ид. сделки                   acc_id
                p_sum        in ibx_recs.summ%type, -- Сумма операции (в коп)          sum
                p_sign       in clob,           --                                 hash
                p_act        in decimal,
                p_serv_id    in varchar2,
                p_res_code   out number, -- Код результата
                p_res_text   out varchar2, -- Текст результата
                p_res_ref    out oper.ref%type -- Референс-результат оплаты
                );

  /*
   IBox - квитовка реестра - вставка заголовка файла
  */
  procedure kwt_file_header(p_type_id     in ibx_files.type_id%type, -- Тип интерфейса
                            p_file_name   in ibx_files.file_name%type, -- Имя пакета реестра
                            p_file_date   in ibx_files.file_date%type, -- Дата реестра
                            p_total_count in ibx_files.total_count%type, -- Общее кол-во записей в реестре
                            p_total_sum   in ibx_files.total_sum%type, -- Общая сумма записей в реестре
                            p_res_code    out number, -- Код результата
                            p_res_text    out varchar2 -- Текст результата
                            );
  /*
   IBox - квитовка реестра - проверка тела и заголовка файла
   return:
   1 - успешная проверка
   0 - неуспешная проверка
  */
  function kwt_check_file(p_type_id   in ibx_files.type_id%type, -- Тип интерфейса
                          p_file_name in ibx_files.file_name%type -- Имя пакета реестра
                          ) return number;
  /*
   IBox - квитовка реестра - вставка одной записи файла
  */
  procedure kwt_file_record(p_type_id   in ibx_recs.type_id%type, -- Тип интерфейса
                            p_file_name in ibx_recs.file_name%type, -- Имя пакета реестра
                            p_ext_ref   in ibx_recs.ext_ref%type, -- Референс документа в IBox
                            p_ext_date  in ibx_recs.ext_date%type, -- Дата/время операции в IBox
                            p_deal_id   in ibx_recs.deal_id%type, -- Ид сделки
                            p_sum       in ibx_recs.summ%type, -- Сумма операции
                            p_res_code  out number, -- Код результата
                            p_res_text  out varchar2 -- Текст результата
                            );

   -- Квитовка
  procedure verification(p_type_id in ibx_types.id%type, -- Тип интерфейса
                     p_params  in xmltype, -- XML c входящими параметрами
                     p_result  out xmltype -- XML c результатом выполнения
                     );

  -- Получение справки о сделке
  procedure get_info(p_type_id in ibx_types.id%type, -- Тип интерфейса
                     p_params  in xmltype, -- XML c входящими параметрами
                     p_result  out xmltype -- XML c результатом выполнения
                     );

  procedure get_info_doc(p_params  in xmltype, -- XML c входящими параметрами
                         p_result  out xmltype -- XML c результатом выполнения
                        );

  -- !!! Временно - Получение справки о сделке - БНК24
/*  procedure get_info_bnk24(p_params in xmltype, -- XML c входящими параметрами
                           p_result out xmltype -- XML c результатом выполнения
                           );*/

   function get_sha1(p_string varchar2) return varchar2;

   function get_md5 (input_string varchar2) return varchar2;

  --Получение справки о сделке - NonStop24
  procedure get_info_nonstop24(p_params in xmltype, -- XML c входящими параметрами
                               p_result out xmltype -- XML c результатом выполнения
                               );
/*    --Получение справки о сделке - QIWI
  procedure get_info_qiwi(p_transaction_id in varchar2,
                          p_agr_num in varchar2, -- Номер договора
                          p_result out xmltype -- XML c результатом выполнения
                            );*/
  --Процедура оплати по всем правилам через PAYTT
  procedure pay_gl(p_src_nls  in varchar2,
                   p_trans_nls in varchar2,
                   p_deal_id  in varchar2,
                   p_sum      in number,
                   p_date     in date,
                   p_receipt_num varchar2,
                   p_res_code out number,
                   p_res_text out varchar2,
                   p_res_ref  out oper.ref%type);

  procedure pay_legal_pers(p_trade_point in varchar2,
                          p_payer_name in varchar2,
                          p_receiver_acc in varchar2,
                          p_receiver_mfo in varchar2,
                          p_receiver_curr in varchar2,
                          p_receiver_okpo in integer,
                          p_receiver_name in varchar2,
                          p_cash_symb in varchar2,
                          p_payment_purpose in varchar2,
                          p_transaction_info in varchar2_list_pck,
                          p_answer_info out varchar2_list_pck,
                          p_res_code out number,
                          p_res_text out varchar2);

  procedure ins_log_xml(p_in_xml clob, p_out_xml clob, p_ref varchar2);

end ibx_pack;
/
CREATE OR REPLACE PACKAGE BODY BARS.IBX_PACK is
  -- ================================== Константы ===============================================
  g_body_version constant varchar2(64) := 'version 2.0.2 22.01.2018';

  -- ===============================================================================================
  -- header_version - возвращает версию заголовка пакета
  function header_version return varchar2 is
  begin
    return 'Package header wcs_exchange ' || g_header_version || '.';
  end header_version;
  -- возвращает версию тела пакета
  function body_version return varchar2 is
  begin
    return 'Package body wcs_exchange ' || g_body_version || '.';
  end body_version;
  -- ===============================================================================================

  function get_nd(p_agr_num w4_acc.acc_pk%type)
    return w4_acc.nd%type
    is
        l_nd w4_acc.nd%type;
    begin
      begin
        select nd into l_nd
            from w4_acc
        where acc_pk=p_agr_num;
        exception when no_data_found then
            l_nd:=null;
      end;
        return l_nd;
    end;
---
-- Получение сумы %% к оплате
--
 function  Int_for_pay (p_nd number) return number is
  w4    w4_acc%rowtype ;
  l_2209 number   := 0 ;
  l_2208 number   := 0 ;
  t_dat01  date :=trunc(sysdate, 'MM');
  p_dat01  date :=trunc(trunc(sysdate, 'MM')-1, 'MM');
begin

  begin
    select * into w4 from w4_acc where nd =p_nd;
  exception when no_data_found then return 0;
  end;

  If w4.acc_2209 is not null then
     select  - ostc into l_2209 from accounts where acc = w4.acc_2209;
  end if;

  If to_number(to_char(sysdate,'DD')) <= 15 then
     select NVL ( sum ( CASE WHEN fdat < t_dat01 THEN dos  --  + начисл
                             ELSE                    -kos  --  - погаш
                             END
                      ), 0)
     into l_2208
     from saldoA
     where acc = w4.acc_2208 and fdat >= p_dat01 ;
  end if;

  Return l_2209 + l_2208;

end Int_for_pay;


  ---------------------------
  -- Проверка доступности интерфейса пользователю
  procedure check_type_access(p_type_id in ibx_types.id%type -- Тип интерфейса
                              ) is
    l_proc     varchar2(100) := 'check_type_access';
    l_ibx_type ibx_types%rowtype;
  begin
    bars_audit.trace(g_pack || ': ' || l_proc ||
                     ' entry point. Params: p_type_id => %s',
                     p_type_id);

    -- параметьры интерфейса оплаты
    begin
      select it.*
        into l_ibx_type
        from ibx_types it
       where it.id = p_type_id
         and it.staff_id = user_id;
    exception
      when no_data_found then
        bars_audit.info(g_pack || ': ' || l_proc ||
                        ' end. Error: Доступ к интерфейсу ' || p_type_id ||
                        ' пользователю №' || to_char(user_id) ||
                        ' не выдан');
        raise_application_error(-20001,
                                'Доступ до інтерфейсу ' || p_type_id ||
                                ' користувачу №' || to_char(user_id) ||
                                ' не видано',
                                true);
    end;

    bars_audit.trace(g_pack || ': ' || l_proc || ' finish.');
  end check_type_access;

  /*
   IBox - проплата задолжености (ON-line оплата с терминала)
  */
  /*procedure pay(p_type_id    in ibx_recs.type_id%type, -- Тип интерфейса
                p_ext_ref    in ibx_recs.ext_ref%type, -- Референс документа в IBox
                p_ext_date   in ibx_recs.ext_date%type, -- Дата/время операции в IBox
                p_ext_source in ibx_recs.ext_source%type, -- Источник платежа в IBox
                p_deal_id    in ibx_recs.deal_id%type, -- Ид. сделки
                p_sum        in ibx_recs.summ%type, -- Сумма операции (в коп)
                p_res_code   out number, -- Код результата
                p_res_text   out varchar2, -- Текст результата
                p_res_ref    out oper.ref%type -- Референс-результат оплаты
                ) is
    l_proc varchar2(30) := 'pay';
    l_ibx_type ibx_types%rowtype;
    l_ibx_rec  ibx_recs%rowtype;
    l_ibx_file ibx_files%rowtype;
    l_nd       w4_acc.nd%type;
  begin


    bars_audit.trace(g_pack || '. ' || l_proc ||
                     ': Start. Params: p_type_id = ' || p_type_id ||
                     'p_ext_ref = ' || p_ext_ref || 'p_ext_date = ' ||
                     to_char(p_ext_date) || 'p_ext_source = ' ||
                     p_ext_source || 'p_deal_id = ' || p_deal_id ||
                     'p_sum = ' || to_char(p_sum));

    -- проверка доступности интерфейса пользователю
    check_type_access(p_type_id);

    l_nd:=get_nd(p_deal_id);

    -- отсекаем нулевые и отрицательные суммы
    if (p_sum <= 0) then
      p_res_code := 4;
      p_res_text := 'Помилка у суммі документу';
      return;
    end if;

    -- поиск документа в уже принятых
    begin
      select ir.*
        into l_ibx_rec
        from ibx_recs ir
       where ir.type_id = p_type_id
         and ir.ext_ref = p_ext_ref
         for update;

      -- оплачен ли уже документ
      if (l_ibx_rec.abs_ref is not null) then
        p_res_code := 0;
        p_res_text := 'Документ вже прийнят';
        p_res_ref  := l_ibx_rec.abs_ref;
        return;
      end if;
    exception
      when no_data_found then
        null;
    end;

    -- попытка проплатить сквитованым днем
    begin
      select if.*
        into l_ibx_file
        from ibx_files if
       where if.type_id = p_type_id
         and if.file_date = trunc(p_ext_date);

      p_res_code := 5;
      p_res_text := 'Спроба проплатити зквитованим днем';
      return;
    exception
      when no_data_found then
        null;
    end;

    -- Проверка Дата «Интерфейса» не отличается от Нашего Банковского Дня Больше чем на 30 дней
    if (abs(p_ext_date - gl.bdate) > 30) then
      p_res_code := 7;
      p_res_text := 'Дата «Інтерфейсу» відрізняється від нашої Банківської більш ніж на 30 днів';
      return;
    end if;

    -- параметьры интерфейса оплаты
    select it.* into l_ibx_type from ibx_types it where it.id = p_type_id;

    -- оплата
    begin
      savepoint sp_before_pay;

      -- разбор суммы погашения
      -- Имя процедуры оплаты (параметры: p_src_nls in varchar2 (номер счета для списания), p_deal_id in varchar2 (ид. сделки), p_sum in number (сумма платежа в коп), p_date in date (дата платежа), p_res_code out number (код результата), p_res_text out varchar2 (текст результата), p_res_ref out oper.ref%type (референс))
      execute immediate 'begin ' || l_ibx_type.proc_pay ||
                        '(:p_src_nls, :l_nd, :p_sum, :p_date, :p_res_code, :p_res_text, :p_res_ref); end;'
        using l_ibx_type.nls, l_nd, p_sum, p_ext_date, out p_res_code, out p_res_text, out p_res_ref;

      -- добавляем документ в таблицу квитовки
      insert into ibx_recs
        (type_id, ext_ref, ext_date, ext_source, deal_id, summ, abs_ref)
      values
        (p_type_id,
         p_ext_ref,
         p_ext_date,
         p_ext_source,
         p_deal_id,
         p_sum,
         p_res_ref);
    exception
      when others then
        rollback to savepoint sp_before_pay;

        p_res_code := 6;
        p_res_text := 'Внутрішня помилка';

        bars_audit.error(substr(g_pack || '. ' || l_proc ||
                                ': Error: Ошибка оплаты: ' ||
                                dbms_utility.format_error_backtrace,
                                1,
                                4000));
        return;
    end;

    -- оплата прошла успешно
    p_res_code := 0;
    p_res_text := '';

    bars_audit.info(g_pack || '. ' || l_proc || ': Finish. p_res_ref = ' ||
                    to_char(p_res_ref) || ' p_res_code => ' ||
                    to_char(p_res_code) || ', p_res_text => ' ||
                    p_res_text);
    return;
  end pay;

*/
  --Оплата с терминала NonStop24 On-line
  /*procedure pay_nonstop24(p_type_id    in ibx_recs.type_id%type, -- Тип интерфейса
                p_ext_ref    in ibx_recs.ext_ref%type, -- Референс документа в IBox
                p_ext_date   in ibx_recs.ext_date%type, -- Дата/время операции в IBox
                p_ext_source in ibx_recs.ext_source%type, -- Источник платежа в IBox
                p_deal_id    in ibx_recs.deal_id%type, -- Ид. сделки
                p_sum        in ibx_recs.summ%type, -- Сумма операции (в коп)
                p_sign       in varchar2,
                p_act        in number,
                p_serv_id    in varchar2,
                p_res_code   out number, -- Код результата
                p_res_text   out varchar2, -- Текст результата
                p_res_ref    out oper.ref%type -- Референс-результат оплаты
                ) is
    l_proc varchar2(30) := 'pay_nonstop24';
    l_ibx_type ibx_types%rowtype;
    l_ibx_rec  ibx_recs%rowtype;
    l_ibx_file ibx_files%rowtype;
    l_nd       w4_acc.nd%type;
      l_secret   varchar2(256) :='UNITYBARS22';
      l_sign_validate varchar2(256);
    l_tarif_prod w4_product.tarif%type;
  begin


    bars_audit.trace(g_pack || '. ' || l_proc ||
                     ': Start. Params: p_type_id = ' || p_type_id ||
                     'p_ext_ref = ' || p_ext_ref || 'p_ext_date = ' ||
                     to_char(p_ext_date) || 'p_ext_source = ' ||
                     p_ext_source || 'p_deal_id = ' || p_deal_id ||
                     'p_sum = ' || to_char(p_sum));

    -- проверка доступности интерфейса пользователю
    check_type_access(p_type_id);

    --Проверка подписи
    l_sign_validate:=get_sha1(p_act||'_'||p_deal_id||'_'||p_serv_id||'_'||p_ext_ref||'_'||l_secret);

    if upper(p_sign)<>upper(l_sign_validate) then
        p_res_code := -101;
        p_res_text := 'Подпись не верна';
        return;
    end if;

    --l_nd:=get_nd(p_deal_id);

    -- отсекаем нулевые и отрицательные суммы
    if (p_sum <= 0) then
      p_res_code := -42;
      p_res_text := 'Платеж на данную сумму невозможен для данного клиента';
      return;
    end if;

--Комиссия по продукту
\*   begin
    select p.tarif into l_tarif_prod
        from w4_acc a, w4_card c, w4_product p
    where a.card_code=c.code
      and c.product_code=p.code
      and a.agr_num=p_deal_id;
     exception when others then
          p_res_code := -90;
          p_res_text := 'Внутреняя ошибка';
          return;
    end;*\

    -- поиск документа в уже принятых
    begin
      select ir.*
        into l_ibx_rec
        from ibx_recs ir
       where ir.type_id = p_type_id
         and ir.ext_ref = p_ext_ref
         for update;

      -- оплачен ли уже документ
      if (l_ibx_rec.abs_ref is not null) then
        p_res_code := -100;
        p_res_text := 'Документ уже был принят';
        p_res_ref  := l_ibx_rec.abs_ref;
        return;
      end if;
    exception
      when no_data_found then
        null;
    end;

    -- попытка проплатить сквитованым днем
    begin
      select if.*
        into l_ibx_file
        from ibx_files if
       where if.type_id = p_type_id
         and if.file_date = trunc(p_ext_date);

      p_res_code := -101;
      p_res_text := 'Попытка оплатить сквитованим днем';
      return;
    exception
      when no_data_found then
        null;
    end;

    -- Проверка Дата «Интерфейса» не отличается от Нашего Банковского Дня Больше чем на 30 дней
    if (abs(p_ext_date - gl.bdate) > 30) then
      p_res_code := -101;
      p_res_text := 'Дата "Оплаты" отличается от нашей Банковской больше чем на 30 дней';
      return;
    end if;

    -- параметьры интерфейса оплаты
    select it.* into l_ibx_type from ibx_types it where it.id = p_type_id;

    -- оплата
    begin
      savepoint sp_before_pay;

      -- разбор суммы погашения
      -- Имя процедуры оплаты (параметры: p_src_nls in varchar2 (номер счета для списания), p_deal_id in varchar2 (ид. сделки), p_sum in number (сумма платежа в коп), p_date in date (дата платежа), p_res_code out number (код результата), p_res_text out varchar2 (текст результата), p_res_ref out oper.ref%type (референс))
      execute immediate 'begin ' || l_ibx_type.proc_pay ||
                        '(:p_src_nls, :l_nd, :p_sum, :p_date, :p_res_code, :p_res_text, :p_res_ref); end;'
        using l_ibx_type.nls, l_nd, p_sum, p_ext_date, out p_res_code, out p_res_text, out p_res_ref;

      -- добавляем документ в таблицу квитовки
      insert into ibx_recs
        (type_id, ext_ref, ext_date, ext_source, deal_id, summ, abs_ref)
      values
        (p_type_id,
         p_ext_ref,
         p_ext_date,
         p_ext_source,
         p_deal_id,
         p_sum,
         p_res_ref);
    exception
      when others then
        rollback to savepoint sp_before_pay;

        p_res_code := -90;
        p_res_text := 'Внутреняя ошибка';

        bars_audit.error(substr(g_pack || '. ' || l_proc ||
                                ': Error: Ошибка оплаты: ' ||
                                dbms_utility.format_error_backtrace,
                                1,
                                4000));
        return;
    end;

    -- оплата прошла успешно
    p_res_code := 22;
    --нужно узнать суму чистой комиссии по формуле
    --((100-100*3,99%)*3,99%)-(100,2,5%)
    -- 100 - сума которую засунули в терминал
    -- 3,99%  комиссия которую взымаем
    -- 2,5%  возврат терминальщику
    p_res_text := 'Переказ власних коштів між рахунками без ПДВ.';
    bars_audit.info(g_pack || '. ' || l_proc || ': Finish. p_res_ref = ' ||
                    to_char(p_res_ref) || ' p_res_code => ' ||
                    to_char(p_res_code) || ', p_res_text => ' ||
                    p_res_text);
    return;
  end pay_nonstop24;*/

   --Оплата с терминала QiWi On-line
  /*procedure pay_qiwi(p_type_id    in ibx_recs.type_id%type, -- Тип интерфейса
                p_ext_ref    in ibx_recs.ext_ref%type, -- Референс документа в IBox
                p_ext_date   in varchar2, -- Дата/время операции в IBox
                p_ext_source in ibx_recs.ext_source%type, -- Источник платежа в IBox
                p_deal_id    in varchar2, -- Ид. сделки
                p_sum        in varchar2, -- Сумма операции (в коп)
                p_res_code   out number, -- Код результата
                p_res_text   out varchar2, -- Текст результата
                p_res_date   out varchar2, -- дата поступления в АБС
                p_res_ref    out oper.ref%type -- Референс-результат оплаты
                ) is
    l_proc varchar2(30) := 'pay_qiwi';
    l_ibx_type ibx_types%rowtype;
    l_ibx_rec  ibx_recs%rowtype;
    l_ibx_file ibx_files%rowtype;
    l_nd       w4_acc.nd%type;
    l_tarif_prod w4_product.tarif%type;
    l_deal_id number;
    l_ext_date date;
    l_sum number;
  begin

    bars_audit.trace(g_pack || '. ' || l_proc ||
                     ': Start. Params: p_type_id = ' || p_type_id ||
                     'p_ext_ref = ' || p_ext_ref || 'p_ext_date = ' ||
                     to_char(p_ext_date) || 'p_ext_source = ' ||
                     p_ext_source || 'p_deal_id = ' || p_deal_id ||
                     'p_sum = ' || to_char(p_sum));

    -- проверка доступности интерфейса пользователю
    check_type_access(p_type_id);

    begin
      l_deal_id:=to_number(p_deal_id);
      exception when others then
        p_res_code:=4;
        p_res_text:='Невірний формат номера договора клієнта';
        return;
      end;

     begin
       l_ext_date:=to_date(p_ext_date, 'yyyymmddHH24MISS');
       exception when others then
         p_res_code:=8;
         p_res_text:='Невірний формат Дати';
         return;
       end;

        begin
       l_sum:=to_number(replace(p_sum, '.', ''));
       exception when others then
         p_res_code:=8;
         p_res_text:='Невірний формат Суми';
         return;
       end;


      l_nd:=get_nd(l_deal_id);

    -- отсекаем нулевые и отрицательные суммы
    if (l_sum <= 0) then
      p_res_code := 241;
      p_res_text := 'Платеж на данную сумму невозможен для данного клиента';
      return;
    end if;

--Комиссия по продукту
   begin
    select p.tarif into l_tarif_prod
        from w4_acc a, w4_card c, w4_product p
    where a.card_code=c.code
      and c.product_code=p.code
      and a.agr_num=l_deal_id;
     exception when others then
          p_res_code := 300;
          p_res_text := 'Інша помилка провайдера';
          return;
    end;

    -- поиск документа в уже принятых
    begin
      select ir.*
        into l_ibx_rec
        from ibx_recs ir
       where ir.type_id = p_type_id
         and ir.ext_ref = p_ext_ref
         for update;

      -- оплачен ли уже документ
      if (l_ibx_rec.abs_ref is not null) then
        p_res_code := 7;
        p_res_text := 'Документ уже был принят';
        p_res_ref  := l_ibx_rec.abs_ref;
        return;
      end if;
    exception
      when no_data_found then
        null;
    end;

    -- попытка проплатить сквитованым днем
    begin
      select if.*
        into l_ibx_file
        from ibx_files if
       where if.type_id = p_type_id
         and if.file_date = trunc(l_ext_date);

      p_res_code := 7;
      p_res_text := 'Попытка оплатить сквитованим днем';
      return;
    exception
      when no_data_found then
        null;
    end;

    -- Проверка Дата «Интерфейса» не отличается от Нашего Банковского Дня Больше чем на 30 дней
    if (abs(l_ext_date - gl.bdate) > 30) then
      p_res_code := 7;
      p_res_text := 'Дата "Оплаты" отличается от нашей Банковской больше чем на 30 дней';
      return;
    end if;

    -- параметьры интерфейса оплаты
    select it.* into l_ibx_type from ibx_types it where it.id = p_type_id;

    -- оплата
    begin
      savepoint sp_before_pay;

      -- разбор суммы погашения
      -- Имя процедуры оплаты (параметры: p_src_nls in varchar2 (номер счета для списания), p_deal_id in varchar2 (ид. сделки), p_sum in number (сумма платежа в коп), p_date in date (дата платежа), p_res_code out number (код результата), p_res_text out varchar2 (текст результата), p_res_ref out oper.ref%type (референс))
      execute immediate 'begin ' || l_ibx_type.proc_pay ||
                        '(:p_src_nls, :l_nd, :p_sum, :p_date, :p_res_code, :p_res_text, :p_res_ref); end;'
        using l_ibx_type.nls, l_nd, l_sum, l_ext_date, out p_res_code, out p_res_text, out p_res_ref;

      -- добавляем документ в таблицу квитовки
      insert into ibx_recs
        (type_id, ext_ref, ext_date, ext_source, deal_id, summ, abs_ref)
      values
        (p_type_id,
         p_ext_ref,
         l_ext_date,
         p_ext_source,
         l_deal_id,
         l_sum,
         p_res_ref);
    exception
      when others then
        rollback to savepoint sp_before_pay;

        p_res_code := 300;
        p_res_text := 'Внутреняя ошибка';

        bars_audit.error(substr(g_pack || '. ' || l_proc ||
                                ': Error: Ошибка оплаты: ' ||
                                dbms_utility.format_error_backtrace,
                                1,
                                4000));
        return;
    end;


      select to_char(pdat, 'yyyy-mm-dd HH24:MI:SS') into p_res_date from oper where ref= p_res_ref;

    -- оплата прошла успешно
    p_res_code := 0;

    p_res_text := 'Переказ власних коштів між рахунками без ПДВ.';
    bars_audit.info(g_pack || '. ' || l_proc || ': Finish. p_res_ref = ' ||
                    to_char(p_res_ref) || ' p_res_code => ' ||
                    to_char(p_res_code) || ', p_res_text => ' ||
                    p_res_text);
    return;
  end pay_qiwi;*/

   --Сторно с терминала QiWi On-line
  /*procedure bak_qiwi(p_type_id    in ibx_recs.type_id%type, -- Тип интерфейса
                p_ext_ref    in ibx_recs.ext_ref%type, -- Референс документа в IBox
                p_ext_date   in varchar2, -- Дата/время операции в IBox
                p_ext_ref_bak    in ibx_recs.ext_ref%type, -- Референс документа в IBox на который пришло сторно
                p_ext_date_bak   in varchar2, -- Дата/время операции в IBox на который пришло сторно
                p_deal_id    in varchar2, -- Ид. сделки
                p_sum        in varchar2, -- Сумма операции (в коп)
                      p_res_code   out number, -- Код результата
                p_res_text   out varchar2, -- Текст результата
                p_res_ref    out oper.ref%type -- Референс-результат оплаты
                ) is
    l_proc varchar2(30) := 'bak_qiwi';
    l_ibx_type ibx_types%rowtype;
    l_ibx_rec  ibx_recs%rowtype;
    l_ibx_file ibx_files%rowtype;
    l_nd       w4_acc.nd%type;
    l_deal_id number;
    l_ext_date date;
    l_sum number;
  begin

    bars_audit.trace(g_pack || '. ' || l_proc ||
                     ': Start. Params: p_type_id = ' || p_type_id ||
                     'p_ext_ref = ' || p_ext_ref || 'p_ext_date = ' ||
                     to_char(p_ext_date) || 'p_ext_ref_bak = ' ||
                     p_ext_ref_bak ||'p_ext_date_bak = ' || p_ext_date_bak || 'p_deal_id = ' || p_deal_id ||
                     'p_sum = ' || to_char(p_sum));

    -- проверка доступности интерфейса пользователю
    check_type_access(p_type_id);

    begin
      l_deal_id:=to_number(p_deal_id);
      exception when others then
        p_res_code:=4;
        p_res_text:='Невірний формат номера договора клієнта';
        return;
      end;

     begin
       l_ext_date:=to_date(p_ext_date, 'yyyymmddHH24MISS');
       exception when others then
         p_res_code:=8;
         p_res_text:='Невірний формат Дати';
         return;
       end;

        begin
       l_sum:=to_number(replace(p_sum, '.', ''));
       exception when others then
         p_res_code:=8;
         p_res_text:='Невірний формат Суми';
         return;
       end;


      l_nd:=get_nd(l_deal_id);

    -- отсекаем нулевые и отрицательные суммы
    if (l_sum <= 0) then
      p_res_code := 241;
      p_res_text := 'Платеж на данную сумму невозможен для данного клиента';
      return;
    end if;

    -- поиск документа в уже принятых
    begin
      select ir.*
        into l_ibx_rec
        from ibx_recs ir
       where ir.type_id = p_type_id
         and ir.ext_ref = p_ext_ref
         for update;

      -- оплачен ли уже документ
      if (l_ibx_rec.abs_ref is not null) then
        p_res_code := 7;
        p_res_text := 'Документ уже был принят';
        p_res_ref  := l_ibx_rec.abs_ref;
        return;
      end if;
    exception
      when no_data_found then
        null;
    end;

    -- попытка проплатить сквитованым днем
    begin
      select if.*
        into l_ibx_file
        from ibx_files if
       where if.type_id = p_type_id
         and if.file_date = trunc(l_ext_date);

      p_res_code := 7;
      p_res_text := 'Попытка оплатить сквитованим днем';
      return;
    exception
      when no_data_found then
        null;
    end;

    -- Проверка Дата «Интерфейса» не отличается от Нашего Банковского Дня Больше чем на 30 дней
    if (abs(l_ext_date - gl.bdate) > 30) then
      p_res_code := 7;
      p_res_text := 'Дата "Оплаты" отличается от нашей Банковской больше чем на 30 дней';
      return;
    end if;

    -- параметьры интерфейса оплаты
    select it.* into l_ibx_type from ibx_types it where it.id = p_type_id;

    -- оплата
    begin
      savepoint sp_before_pay;

      -- разбор суммы погашения
      -- Имя процедуры оплаты (параметры: p_src_nls in varchar2 (номер счета для списания), p_deal_id in varchar2 (ид. сделки), p_sum in number (сумма платежа в коп), p_date in date (дата платежа), p_res_code out number (код результата), p_res_text out varchar2 (текст результата), p_res_ref out oper.ref%type (референс))
   --   execute immediate 'begin ' || l_ibx_type.proc_pay ||
     --                   '(:p_src_nls, :l_nd, :p_sum, :p_date, :p_res_code, :p_res_text, :p_res_ref); end;'
     --   using l_ibx_type.nls, l_nd, l_sum, l_ext_date, out p_res_code, out p_res_text, out p_res_ref;

      -- добавляем документ в таблицу квитовки
      insert into ibx_recs
        (type_id, ext_ref, ext_date, ext_source, deal_id, summ, abs_ref)
      values
        (p_type_id,
         p_ext_ref,
         l_ext_date,
         null,
         l_deal_id,
         l_sum,
         null);
    exception
      when others then
        rollback to savepoint sp_before_pay;

        p_res_code := 300;
        p_res_text := 'Внутреняя ошибка';

        bars_audit.error(substr(g_pack || '. ' || l_proc ||
                                ': Error: Ошибка оплаты: ' ||
                                dbms_utility.format_error_backtrace,
                                1,
                                4000));
        return;
    end;



    -- Пока сторнировать давать не будем
    -- будем записывать себе в табличку а обратно отдавать ошибку
    p_res_code := 7;

    p_res_text := 'Сторно заборонено провайдером';
    bars_audit.info(g_pack || '. ' || l_proc || ': Finish. p_res_ref = ' ||
                    to_char(p_res_ref) || ' p_res_code => ' ||
                    to_char(p_res_code) || ', p_res_text => ' ||
                    p_res_text);
    return;
  end bak_qiwi;*/


 /*
    Получение информации о договоре
 */
  procedure get_info_osc(p_acc_id in w4_acc.acc_pk%type,
                         p_sign   in varchar2,
                         p_bs_id  out ibx_types.id%type,
                         p_comp_id out varchar2,
                         p_res_code out number,
                         p_res_text out varchar2
                        )
    is
      l_proc varchar2(50):='get_info_osc';
      l_fio varchar2(250);
      l_close_date date;
      l_debt_sum number(38);
      l_lim number(38);
      l_avans number(38);
      l_av_amount number(38);
      l_result number(38):=0;
      l_comment varchar2(256):='';
      l_secret   varchar2(256) :='UNITYBARS22';
      l_sign_validate varchar2(256);
    begin

       bars_audit.trace(g_pack || '. ' || l_proc ||
                     ': Start: Params: agr_num => %s, hash=> %s',  p_acc_id, p_sign);

       --Проверка подписи
    l_sign_validate:=get_md5(p_acc_id||'|'||l_secret);

    if p_sign<>l_sign_validate then
          l_result := 4;
          l_comment := 'CRC_ERR(неверный hash)';
    end if;

       begin
        select c.nmk as fio,
               a.dazs as close_date,
               nvl(-fost(wa.acc_pk, gl.bdate), 0) / 100 as debt_sum,
               (a.lim-nvl(-fost(wa.acc_pk, gl.bdate), 0)) / 100 as lim,
               nvl(fost(wa.acc_2625x, gl.bdate), 0) / 100 as avans,
               nvl(-fost(wa.acc_2208, gl.bdate), 0)/100+nvl(-fost(wa.acc_2209, gl.bdate), 0)/100 as av_amount -- по просьбе Прейгера Андрея нужно показывать простроч.и нач. %%
          into l_fio,
               l_close_date,
               l_debt_sum,
               l_lim,
               l_avans,
               l_av_amount
          from w4_acc wa, accounts a, customer c
         where wa.acc_ovr = p_acc_id
           and wa.acc_pk = a.acc
           and a.rnk = c.rnk;
      exception
        when no_data_found then
          l_result  := 2;
          l_comment := 'Deal №' || to_char(p_acc_id) || ' not found';
      end;

      if l_close_date is not null
        then
          l_result:=3;
          l_comment:='Deal №'||p_acc_id||' is closed';
      end if;

      --Если все ОК формируем текст
      if l_result=0 then
        l_comment:='ПІБ -'||l_fio||';'||chr(13)||chr(10)||
                   'Рекомендована сума для погашення -'||l_av_amount||';'||chr(13)||chr(10)||
                   'Сума кредиту -'||l_debt_sum||';'||chr(13)||chr(10)||
                   'Доступно коштів -'||l_lim||';'||chr(13)||chr(10)||
                   'Аванс -'||l_avans||';';
      end if;

      p_bs_id:='OSCHAD';
      p_comp_id:=null;
      p_res_code:=l_result;
      p_res_text:=l_comment;

       bars_audit.info(g_pack || '. ' || l_proc || ': Finish. p_res_code => ' ||
                    to_char(p_res_code) || ', p_res_text => ' || p_res_text);

    end get_info_osc;



  /*
    Оплата - терминал Ощадбанка
  */
  procedure pay_osc(p_type_id    in ibx_recs.type_id%type, -- Тип интерфейса           bs_id
                p_ext_ref    in ibx_recs.ext_ref%type, -- Референс документа в IBox    id
                p_ext_date   in varchar2, -- Дата/время операции в IBox  date
                p_ext_source in varchar2, --код  терминала
                p_receipt_num in varchar2,--номер чека                
                p_deal_id    in ibx_recs.deal_id%type, -- Ид. сделки                   acc_id
                p_sum        in ibx_recs.summ%type, -- Сумма операции (в коп)          sum
                p_sign       in clob,           --                                 hash
                p_act        in decimal,
                p_serv_id    in varchar2,
                p_res_code   out number, -- Код результата
                p_res_text   out varchar2, -- Текст результата
                p_res_ref    out oper.ref%type -- Референс-результат оплаты
                ) is
    l_proc varchar2(30) := 'pay_osc';
    l_ibx_type ibx_types%rowtype;
    l_ibx_rec  ibx_recs%rowtype;
    l_ibx_file ibx_files%rowtype;
    l_nd       w4_acc.nd%type;
    l_secret   varchar2(256) :='UNITYBARS22';
    l_sign_validate varchar2(256);
    l_ext_date date;
    l_recid number;
    l_kf accounts.kf%type;
    l_kv accounts.kv%type;
  begin

    bars_audit.trace(g_pack || '. ' || l_proc ||
                     ': Start. Params: p_type_id = ' || p_type_id ||
                     'p_ext_ref = ' || p_ext_ref || 'p_ext_date = ' ||
                     to_char(p_ext_date) || 'p_deal_id = ' || p_deal_id ||
                     'p_sum = ' || to_char(p_sum));

    l_ext_date:=to_date(p_ext_date,'YYYY-MM-DD HH24:MI:SS');
    -- проверка доступности интерфейса пользователю
    check_type_access(p_type_id);

        --Проверка подписи
    l_sign_validate:=get_sha1(p_act||'_'||p_deal_id||'_'||p_serv_id||'_'||p_ext_ref||'_'||l_secret);

    /*if (p_sign<>upper(l_sign_validate)) or p_sign is null then
          p_res_code := 4;
          p_res_text := 'CRC_ERR(неверный hash)';
            return;
    end if;*/

    --l_nd:=get_nd(p_deal_id);
    --l_nd := p_deal_id;
    select REGEXP_SUBSTR(s, '[^.]+', 1, 1) kf,
       REGEXP_SUBSTR(s, '[^.]+', 1, 2) nd,
       REGEXP_SUBSTR(s, '[^.]+', 1, 3) kv
    into l_kf, l_nd, l_kv
    from (select p_deal_id s from dual);

    -- отсекаем нулевые и отрицательные суммы
    if (p_sum <= 0) then
      p_res_code := 3;
      p_res_text := 'FAILED(передали неверные данные)';
      return;
    end if;

    -- поиск документа в уже принятых
    begin
      select ir.*
        into l_ibx_rec
        from ibx_recs ir
       where ir.type_id = p_type_id
         and ir.ext_ref = p_ext_ref
         for update;

      -- оплачен ли уже документ
      if (l_ibx_rec.abs_ref is not null) then
        p_res_code := 1;
        p_res_text := 'DUPLICATE(дублирующий платеж)';
        p_res_ref  := l_ibx_rec.abs_ref;
        return;
      end if;
    exception
      when no_data_found then
        null;
    end;

    -- попытка проплатить сквитованым днем
    begin
      select if.*
        into l_ibx_file
        from ibx_files if
       where if.type_id = p_type_id
         and if.file_date = trunc(l_ext_date);

      p_res_code := 3;
      p_res_text := 'FAILED(Попытка оплатить сквитованим днем)';
      return;
    exception
      when no_data_found then
        null;
    end;

    -- Проверка Дата «Интерфейса» не отличается от Нашего Банковского Дня Больше чем на 30 дней
    if (abs(l_ext_date - gl.bdate) > 30) then
      p_res_code := 3;
      p_res_text := 'FAILED(Дата "Оплаты" отличается от нашей Банковской больше чем на 30 дней)';
      return;
    end if;

    -- параметьры интерфейса оплаты
    select it.* into l_ibx_type from ibx_types it where it.id = p_type_id;

    -- оплата
    begin
      savepoint sp_before_pay;

      -- разбор суммы погашения
      -- Имя процедуры оплаты (параметры: p_src_nls in varchar2 (номер счета для списания), p_deal_id in varchar2 (ид. сделки), p_sum in number (сумма платежа в коп), p_date in date (дата платежа), p_res_code out number (код результата), p_res_text out varchar2 (текст результата), p_res_ref out oper.ref%type (референс))
      /*execute immediate 'begin ' || l_ibx_type.proc_pay ||
                        '(:p_src_nls, :l_nd, :p_sum, :p_date, :p_res_code, :p_res_text, :p_res_ref); end;'
        using l_ibx_type.nls, l_nd, p_sum, l_ext_date, out p_res_code, out p_res_text, out p_res_ref;
*/ 
       pay_gl( p_src_nls  => l_ibx_type.ext_nls,
              p_trans_nls=> l_ibx_type.nls,
              p_deal_id=> l_nd,
              p_sum=>p_sum,
              p_date=>l_ext_date,
              p_receipt_num=>p_receipt_num,
              p_res_code=>p_res_code,
              p_res_text=>p_res_text,
              p_res_ref=>p_res_ref);

      -- добавляем документ в таблицу квитовки
      if p_res_code <> 0 then
        return;
      else
        insert into ibx_recs
          (type_id, ext_ref, ext_date, deal_id, summ, abs_ref)
        values
          (p_type_id,
           p_ext_ref,
           l_ext_date,
           p_deal_id,
           p_sum,
           p_res_ref);
       end if;
    exception
      when others then
        rollback to savepoint sp_before_pay;

        p_res_code := 5;
        p_res_text := 'ERR(Проблемы с системой)';

/*        bars_audit.error(substr(g_pack || '. ' || l_proc ||
                                ': Error: Ошибка оплаты: ' ||
                                dbms_utility.format_error_backtrace,
                                1,
                                4000));*/
        bars_audit.error(sqlerrm);
       bars_audit.error(dbms_utility.format_error_stack()||chr(10)||
          dbms_utility.format_error_backtrace(), '', null, l_recid);
        return;
    end;

    -- оплата прошла успешно
    p_res_code := 22;
    --p_res_text := 'ОК';

    bars_audit.info(g_pack || '. ' || l_proc || ': Finish. p_res_ref = ' ||
                    to_char(p_res_ref) || ' p_res_code => ' ||
                    to_char(p_res_code) || ', p_res_text => ' ||
                    p_res_text);
    return;
  end pay_osc;


  /*
   IBox - квитовка реестра - вставка заголовка файла
  */
  procedure kwt_file_header(p_type_id     in ibx_files.type_id%type, -- Тип интерфейса
                            p_file_name   in ibx_files.file_name%type, -- Имя пакета реестра
                            p_file_date   in ibx_files.file_date%type, -- Дата реестра
                            p_total_count in ibx_files.total_count%type, -- Общее кол-во записей в реестре
                            p_total_sum   in ibx_files.total_sum%type, -- Общая сумма записей в реестре
                            p_res_code    out number, -- Код результата
                            p_res_text    out varchar2 -- Текст результата
                            ) is
    l_proc varchar2(30) := 'kwt_file_header';

    l_ibx_file ibx_files%rowtype;
  begin
    bars_audit.trace(g_pack || '. ' || l_proc ||
                     ': entry point. Params: p_type_id => %s, p_file_name => %s, p_total_count => %s, p_total_sum => %s',
                     p_type_id,
                     p_file_name,
                     to_char(p_total_count),
                     to_char(p_total_sum));

    -- проверка доступности интерфейса пользователю
    check_type_access(p_type_id);

    begin
      -- проверяем не загружался ли файл раньше
      select f.*
        into l_ibx_file
        from ibx_files f
       where f.type_id = p_type_id
         and f.file_name = p_file_name;

      -- нашли что загружался
      p_res_code := 1;
      p_res_text := 'Реєстр вже прийнят0 (' ||
                    to_char(l_ibx_file.loaded, 'yyyy-mm-dd hh24:mi:ss') || ')';

    exception
      when no_data_found then

        -- если не загружался то добавляем запись
        insert into ibx_files
          (type_id, file_name, file_date, total_count, total_sum, loaded)
        values
          (p_type_id,
           p_file_name,
           p_file_date,
           p_total_count,
           p_total_sum,
           sysdate);

        p_res_code := 0;
        p_res_text := 'Файл прийнято на обробку';

    end;

    bars_audit.trace(g_pack || '. ' || l_proc ||
                     ': end. Results: p_res_code => %s, p_res_text => %s',
                     to_char(p_res_code),
                     p_res_text);
  end kwt_file_header;

  /*
   IBox - квитовка реестра - проверка тела и заголовка файла
   return:
   1 - успешная проверка
   0 - неуспешная проверка
  */
  function kwt_check_file(p_type_id   in ibx_files.type_id%type, -- Тип интерфейса
                          p_file_name in ibx_files.file_name%type -- Имя пакета реестра
                          ) return number is
    l_proc varchar2(30) := 'kwt_check_file';

    l_ibx_file    ibx_files%rowtype;
    l_total_count number;
    l_total_sum   number;

  begin
    bars_audit.trace(g_pack || '. ' || l_proc ||
                     ': entry point. Params: p_type_id => %s, p_file_name => %s',
                     p_type_id,
                     p_file_name);
    -- проверка доступности интерфейса пользователю
    check_type_access(p_type_id);

    -- берем данные по файлу
    select f.*
      into l_ibx_file
      from ibx_files f
     where f.type_id = p_type_id
       and f.file_name = p_file_name;

    -- подсчитываем данные по сточкам
    select count(*), nvl(sum(ir.summ), 0)
      into l_total_count, l_total_sum
      from ibx_recs ir
     where ir.type_id = p_type_id
       and trunc(ir.ext_date) = l_ibx_file.file_date;

    -- сравниваем
    if l_ibx_file.total_count = l_total_count and
       l_ibx_file.total_sum = l_total_sum then

      bars_audit.trace(g_pack || '. ' || l_proc ||
                       ': end. Results: check sums are right.');
      return 1;
    end if;

    bars_audit.trace(g_pack || '. ' || l_proc ||
                     ': end. Results: check sums are wrong. l_ibx_file.total_count = ' ||
                     l_ibx_file.total_count || ', l_total_count = ' ||
                     l_total_count || ', l_ibx_file.total_sum = ' ||
                     l_ibx_file.total_sum || ', l_total_sum = ' ||
                     l_total_sum);
    return 0;
  end kwt_check_file;

  /*
   IBox - квитовка реестра - вставка одной записи файла
  */
  procedure kwt_file_record(p_type_id   in ibx_recs.type_id%type, -- Тип интерфейса
                            p_file_name in ibx_recs.file_name%type, -- Имя пакета реестра
                            p_ext_ref   in ibx_recs.ext_ref%type, -- Референс документа в IBox
                            p_ext_date  in ibx_recs.ext_date%type, -- Дата/время операции в IBox
                            p_deal_id   in ibx_recs.deal_id%type, -- Ид сделки
                            p_sum       in ibx_recs.summ%type, -- Сумма операции
                            p_res_code  out number, -- Код результата
                            p_res_text  out varchar2 -- Текст результата
                            ) is
    l_proc varchar2(30) := 'kwt_file_record';

    l_kwt     number;
    l_ibx_rec ibx_recs%rowtype;
  begin
    bars_audit.trace(g_pack || '. ' || l_proc ||
                     ': entry point. Params:
    p_type_id => %s, p_file_name => %s, p_ext_ref => %s, p_ext_date => %s, p_deal_id => %s, p_sum => %s',
                     p_type_id,
                     p_file_name,
                     p_ext_ref,
                     to_char(p_ext_date),
                     p_deal_id,
                     to_char(p_sum));

    -- проверка доступности интерфейса пользователю
    check_type_access(p_type_id);

    begin
      -- ищем запись для квитовки
      select ir.*
        into l_ibx_rec
        from ibx_recs ir
       where ir.type_id = p_type_id
         and ir.ext_ref = p_ext_ref;

      -- проверяем совпадение реквизитов
      if l_ibx_rec.ext_date = p_ext_date and l_ibx_rec.ext_ref=p_ext_ref and to_number(l_ibx_rec.deal_id) = p_deal_id and
         l_ibx_rec.summ = p_sum then
        l_kwt := 1;
      else
        l_kwt := 0;
      end if;

      -- квитуем платеж
      update ibx_recs ir
         set ir.kwt = l_kwt, ir.file_name = p_file_name
       where ir.type_id = p_type_id
         and ir.ext_ref = p_ext_ref;

      -- результат квитовки
      if (l_kwt = 0) then
        p_res_code := 2;
        p_res_text := 'Запис в реєстрі та у АБС мають різні реквізити';
      else
        p_res_code := 0;
        p_res_text := '';
      end if;

    exception
      when no_data_found then
        -- не нашли запись для квитовки
        p_res_code := 1;
        p_res_text := 'Запис не знайдено у АБС';
    end;

    bars_audit.trace(g_pack || '. ' || l_proc ||
                     ': end. Results: p_res_code => %s, p_res_text => %s',
                     to_char(p_res_code),
                     p_res_text);
  end kwt_file_record;


     -- Квитовка
  procedure verification(p_type_id in ibx_types.id%type, -- Тип интерфейса
                     p_params  in xmltype, -- XML c входящими параметрами
                     p_result  out xmltype -- XML c результатом выполнения
                     ) is
   l_proc varchar2(30):='verification';
   l_file_name varchar2(4000);
   l_file_date date;
   l_total_count number;
   l_total_sum number;
   l_res_code_d number;
   l_res_code_h number;
   l_res_msg_h varchar2(4000);
   l_res_code_b number;
   l_res_msg_b varchar2(4000);
   l_res_code number;
   l_res_text varchar2(4000);
   l_check_file number;
   l_ibx_file ibx_files%rowtype;
   l_xml_text clob;

 begin
    --
      bars_audit.trace(g_pack || '. ' || l_proc ||
                       ': Start: Params: p_type_id => ' || p_type_id ||
                       ', p_params => ' || p_params.getStringVal());

    -- проверка доступности интерфейса пользователю
    check_type_access(p_type_id);

     /* Пример входящего XML
    <?xml version="1.0" encoding="UTF-8"?>
    <commandCall>
         <login>platezhka</login>
         <password>1234567</password>
         <command>verification</command>
         <transactionID>1234567890123</transactionID>
          <Register FILE_NAME="1234567890123" FILE_DATE="2013-10-20" TOTAL_COUNT="2" TOTAL_SUM="1200.25">
              <Pay ExtRef="1" ExtDate="2008-11-26 00:00:01" Id="546254" Sum="237.45" />
              <Pay ExtRef="5" ExtDate="2008-11-26 12:00:01" Id="546254" Sum="222" />
              <Pay ExtRef="2" ExtDate="2008-11-26 12:00:01" Id="546254" Sum="777" />
          </Register>
    </commandCall>
    */

    /*
          Коды возврата для заголовка

          -3 -- Некоректный формат даных в квитовке заголовка;
          -2 -- Реєстр вже прийнято
          -1 --Помилка в контрольних сумах
           0 -- ОК

    */


    -- Достанем общие даные по файлу, если что то плохо возвращаем ошибку и текст
      begin
      --
         l_file_name := p_params.extract('/commandCall/Register/@FILE_NAME').getstringval();
         l_file_date := to_date(p_params.extract('/commandCall/Register/@FILE_DATE').getstringval(), 'yyyy-mm-dd');
         l_total_count := to_number(p_params.extract('/commandCall/Register/@TOTAL_COUNT').getstringval());
         l_total_sum := to_number(p_params.extract('/commandCall/Register/@TOTAL_SUM').getstringval());
      --
         exception when others then  l_res_code_d:=-3;
       end;


      kwt_file_header(p_type_id =>p_type_id, -- Тип интерфейса
                            p_file_name =>l_file_name, -- Имя пакета реестра
                            p_file_date =>l_file_date, -- Дата реестра
                            p_total_count =>l_total_count, -- Общее кол-во записей в реестре
                            p_total_sum   =>l_total_sum*100, -- Общая сумма записей в реестре
                            p_res_code    =>l_res_code, -- Код результата
                            p_res_text    =>l_res_text -- Текст результата
                            );

      /*
     IBox - квитовка реестра - проверка тела и заголовка файла
     return:
     1 - успешная проверка
     0 - неуспешная проверка
    */
     l_check_file:= kwt_check_file(p_type_id, l_file_name);

           if  l_check_file=1 then
                     l_res_code_h:=0;
                     l_res_msg_h :='OK';
           end if;
           if  l_check_file=0 then
                     l_res_code_h:=-1;
                     l_res_msg_h :='Помилка в контрольних сумах';
           end if;
           if l_res_code=1 then
                     l_res_code_h := -2;
                     l_res_msg_h := l_res_text;
           end if;
           if l_res_code_d=-3 then
                     l_res_code_h:=-3;
                     l_res_msg_h:='Некоректный формат даных в квитовке заголовка';
           end if;

           l_xml_text:='<?xml version="1.0" encoding="UTF-8"?>
                          <commandResponse>
                             <extTransactionID></extTransactionID>
                             <DateTime>'||to_char(sysdate, 'yyyy-mm-dd HH24:MI:SS')||'</DateTime>
                             <ServiceName>'||p_type_id||'</ServiceName>
                             <Result>
                             <Register FileName="'||l_file_name||'" FileDate="'||to_char(l_file_date,'yyyy-mm-dd')||'" TotalCount="'||l_total_count||'" TotalSum="'||l_total_sum||'" ResultCode="'||
                             l_res_code_h||'" ResultDescription="'||l_res_msg_h||'"> ';

    begin

     for k in(select xml_list.extract('/Pay/@ExtRef').getstringval() transaction_id,
                    to_date(xml_list.extract('/Pay/@ExtDate').getstringval(),'yyyy-mm-dd HH24:MI:SS') ibx_date,
                    to_number(xml_list.extract('/Pay/@Id').getstringval()) agr_num,
                    to_number(xml_list.extract('/Pay/@Sum').getstringval()) sum
             from table(xmlsequence(extract(p_params,'commandCall/Register/Pay'))) xml_list)

     loop
                kwt_file_record(p_type_id => p_type_id, -- Тип интерфейса
                                p_file_name =>l_file_name, -- Имя пакета реестра
                                p_ext_ref   =>k.transaction_id, -- Референс документа в IBox
                                p_ext_date  =>k.ibx_date, -- Дата/время операции в IBox
                                p_deal_id   =>k.agr_num, -- Ид сделки
                                p_sum       =>k.sum*100, -- Сумма операции
                                p_res_code  =>l_res_code_b, -- Код результата
                                p_res_text  =>l_res_msg_b -- Текст результата
                                );

           --если что-то плохо - добавляем строкус PAY
           if l_res_code_b<>0 then
                       l_xml_text:=l_xml_text||' <Pay ExtRef="'||k.transaction_id||'" ExtDate="'||to_char(k.ibx_date,'yyyy-mm-dd HH24:MI:SS')||'" Id="'||k.agr_num||'" Sum="'||k.sum||
                                                        '" ResultCode="'||l_res_code_b||'" ResultDescription="'||l_res_msg_b||'"/> '||chr(13)||chr(10);
           end if;

         end loop;
     end;

    begin
     for c in(select * from ibx_recs
              where type_id = p_type_id
               and trunc(ext_date) = l_file_date
               and file_name is null)
     loop
            l_xml_text:=l_xml_text||' <Pay ExtRef="'||c.ext_ref||'" ExtDate="'||to_char(c.ext_date,'yyyy-mm-dd HH24:MI:SS')||'" Id="'||c.deal_id||'" Sum="'||to_char(c.summ/100)||
                                                        '" ResultCode="3" ResultDescription="Запись не найдена в реестре"/> '||chr(13)||chr(10);
       end loop;
     end;

     l_xml_text:=l_xml_text||' </Register>
                              </Result>
                             </commandResponse>';

     /*
          <?xml version="1.0" encoding="UTF-8"?>
          <commandResponse>
             <extTransactionID></extTransactionID>
             <DateTime>2008-11-26 16:53:25</DateTime>
             <ServiceName>Ibox exchange</ServiceName>
             <Result>
                 <Register FileName="register20081126" FileDate="2008-11-26" TotalCount="3" TotalSum="1236.45" ResultCode="2" ResultDescription="Не совпадают контрольные суммы реестра с ОДБ">
                     <Pay ExtRef="5" ExtDate="2008-11-26 12:00:01" Id="546254" Sum="222" ResultCode="1" ResultDescription="Запись не найдена в ОДБ" />
                     <Pay ExtRef="2" ExtDate="2008-11-26 12:00:01" Id="546254" Sum="777" ResultCode="2" ResultDescription="Запись в реестре и в ОДБ имеют разные реквизиты" />
                     <Pay ExtRef="3" ExtDate="2008-11-26 23:59:59" Id="546254" Sum="547.00" ResultCode="3" ResultDescription="Запись не найдена в реестре" />
                 </Register>
             </Result>
          </commandResponse>

     */


     p_result:=xmltype(l_xml_text);

    --
      bars_audit.trace(g_pack || '. ' || l_proc || ': Finish: p_result => ' ||p_result.getStringVal());
    --
   end verification;


  -- Получение справки о сделке
  procedure get_info(p_type_id in ibx_types.id%type, -- Тип интерфейса
                     p_params  in xmltype, -- XML c входящими параметрами
                     p_result  out xmltype -- XML c результатом выполнения
                     ) is
    l_proc varchar2(30) := 'get_info';

    l_type_r ibx_types%rowtype;
  begin
    bars_audit.trace(g_pack || '. ' || l_proc ||
                     ': Start: Params: p_type_id => ' || p_type_id ||
                     ', p_params => ' || p_params.getStringVal());

    -- проверка доступности интерфейса пользователю
    check_type_access(p_type_id);

    -- параметры интерфейса
    select t.* into l_type_r from ibx_types t where t.id = p_type_id;

    -- вызываем процедуру конкретного интерфейса (Имя процедуры получения справки (параметры: p_params in xmltype, p_result out xmltype)), ошибку пробрасываем
    /*execute immediate 'begin ' || l_type_r.proc_getinfo ||
                      '(:p_params, :p_result); end;'
      using p_params, out p_result;*/
    get_info_nonstop24(p_params,p_result);

    bars_audit.trace(g_pack || '. ' || l_proc || ': Finish: p_result => ' ||
                     p_result.getStringVal());
  end get_info;

  -- !!! Временно - Получение справки о сделке - БНК24
  --!!!Ниче не временно)))) Все тип-топ
  /*procedure get_info_bnk24(p_params in xmltype, -- XML c входящими параметрами
                           p_result out xmltype -- XML c результатом выполнения
                           ) is
    l_proc varchar2(30) := 'get_info_bnk24';

    l_account          number;
    l_agr_num_bday     varchar2(100);
    l_bday             date;
    l_transaction_id number;

    l_result           number := 0;
    l_comment          varchar2(300) := 'ОК';
    l_fio              varchar2(300);
    l_close_date       date;
    l_debt_sum         number;
    l_lim              number;
    l_avans            number;
    l_av_amount        number;

    l_xml_text varchar2(4000);
  begin
    bars_audit.trace(g_pack || '. ' || l_proc ||
                     ': Start: Params: p_params => %s',
                     p_params.getStringVal());

    \* Пример входящего XML
    <?xml version="1.0" encoding="UTF-8"?>
    <commandCall>
         <login>platezhka</login>
         <password>1234567</password>
         <command>check</command>
         <transactionID>1234567890123</transactionID>
         <payElementID>0</payElementID>
         <account>1234567890</account>
    </commandCall>
    *\
    l_transaction_id := to_number(p_params.extract('/commandCall/transactionID/text()')
                                  .getstringval());

    l_agr_num_bday:=p_params.extract('/commandCall/account/text()')
                             .getstringval();                        -- agr_num и Дата рождения
    begin
      l_account := to_number(substr(l_agr_num_bday,1,instr(l_agr_num_bday,'|')-1));
      \*l_account := to_number(p_params.extract('/commandCall/account/text()')
                             .getstringval());*\
    exception
      when others then
        l_result  := 4;
        l_comment := 'Номер договору повинен бути числовий';
    end;

    begin
    l_bday:= to_date(substr(l_agr_num_bday,instr(l_agr_num_bday,'|')+1),'dd.mm.yyyy');
    exception
      when others then
        l_result  := 300;
        l_comment := 'Не коректно задана дата народження';
    end;

    \* Ищем параметры
    ФИО
    Сумма задолженности
    Размер текущего платежа за использование кредита
    Размер просроченного платежа за использование кредита
    Сумма доступных средств.
    *\
    if (l_result = 0) then
      begin
        select c.nmk as fio,
               a.dazs as close_date,
               nvl(-fost(wa.acc_pk, gl.bdate), 0) / 100 as debt_sum,
               (a.lim-nvl(-fost(wa.acc_pk, gl.bdate), 0)) / 100 as lim,
               nvl(fost(wa.acc_2625x, gl.bdate), 0) / 100 as avans,
               Int_for_pay(wa.nd)/100 as av_amount -- по просьбе Прейгера Андрея нужно показывать простроч.и нач. %%,
                                                   --Int_for_pay написано Суховой Т.А, 08/11/2013
          into l_fio,
               l_close_date,
               l_debt_sum,
               l_lim,
               l_avans,
               l_av_amount
          from w4_acc wa, accounts a, customer c, person p
         where wa.agr_num = l_account
           and wa.acc_pk = a.acc
           and a.rnk = c.rnk
           and c.rnk = p.rnk
           and trunc(p.bday) = l_bday;
      exception
        when no_data_found then
          l_result  := 5;
          l_comment := 'Договір №' || to_char(l_account) || ' не знайдено';
      end;
    end if;

    -- проверка договора на закрытость
    if (l_result = 0) then
      if (l_close_date is not null) then
        l_result  := 79;
        l_comment := 'Договір №' || to_char(l_account) || ' закрито';
      end if;
    end if;

    \* Пример исходящего XML
    <?xml version="1.0" encoding="UTF-8"?>
    <commandResponse>
         <extTransactionID>1234567</extTransactionID>
         <account>1234567890</account>
         <result>0</result>
         <fields>
               <field1 name=”FIO”>Иванов Иван Петрович</field1>
               <field2 name=”balance”>152.17</field2>
                  …
               <fieldN name=”nameN”>valueN</fieldN>
         </fields>
         <comment></comment>
    </commandResponse>

    result:
    0 - ОК
    1 - Временная ошибка. Повторите запрос позже
    4 - Неверный формат идентификатора абонента
    5 - Идентификатор абонента не найден (Ошиблись номером)
    7 - Прием платежа запрещен провайдером
    8 - Прием платежа запрещен по техническим причинам
    79 - Счет абонента не активен
    90 - Проведение платежа не окончено
    300 - Другая ошибка провайдера
    *\

    bars_audit.info('IBOX: БНК24: Запит інформації (' || l_transaction_id ||
                    ') по договору № ' || l_account ||
                    '. Код результату обробки - ' || to_char(l_result) || ' (' ||
                    l_comment || ')');

    l_xml_text := '<?xml version="1.0" encoding="UTF-8"?>';
    l_xml_text := l_xml_text || '<commandResponse>';
    l_xml_text := l_xml_text || '<extTransactionID></extTransactionID>';
    l_xml_text := l_xml_text || '<account>' || to_char(l_account) ||
                  '</account>';
    l_xml_text := l_xml_text || '<result>' || to_char(l_result) ||
                  '</result>';
    if (l_result = 0) then
      l_xml_text := l_xml_text || '<fields>';
      l_xml_text := l_xml_text || '<field1 name="FIO">' || l_fio ||
                    '</field1>';
      l_xml_text := l_xml_text || '<field2 name="balance">'||trim(to_char(l_av_amount, '9999999999999999990.00'))||'</field2>';
      l_xml_text := l_xml_text ||
                    '<field3 name="Message">Сума виданого кредиту - '||trim(to_char(l_debt_sum, '9999999999999999990.00'))||';'||chr(13)||chr(10)||
                    'Доступні кошти - ' ||trim(to_char(l_lim, '9999999999999999990.00'))||';'||chr(13)||chr(10)||
                    'Аванс - ' ||trim(to_char(l_avans,'9999999999999999990.00'))||chr(13)||chr(10) || '</field3>';
      l_xml_text := l_xml_text || '</fields>';
    end if;
    l_xml_text := l_xml_text || '<comment>' || l_comment || '</comment>';
    l_xml_text := l_xml_text || '</commandResponse>';

    -- переводим в XMLType
    p_result := XMLType(l_xml_text);

    bars_audit.trace(g_pack || '. ' || l_proc || ': Finish: l_result = ' ||
                     l_xml_text);
  end get_info_bnk24;*/


    -----------------------------------------------------------------
    --     Функция получения SHA1
    -----------------------------------------------------------------
    function get_sha1(p_string varchar2) return varchar2
    is
     --
     l_stmt varchar2(4000);
     --
    begin
     --
        l_stmt:= lower (to_char (rawtohex (dbms_crypto.hash (src   => utl_raw.cast_to_raw (p_string),
                                                             typ   => dbms_crypto.hash_sh1))));
     --
        return l_stmt;
     --
    end;

---
-- Получение MD5
--
function get_md5 (input_string varchar2) return varchar2
  is
  begin
    return dbms_obfuscation_toolkit.md5(input_string => input_string);
  end;

  procedure get_info_nonstop24(p_params in xmltype, -- XML c входящими параметрами
                               p_result out xmltype -- XML c результатом выполнения
                               )
    is
        l_proc           varchar2(30) := 'get_info_nonstop24';
        l_status_code    number :=21;
        l_act            number;
        l_service_id     varchar2(20);
        l_transaction_id varchar2(100);
        l_pay_account    varchar2(100);
        l_trade_point    varchar2(20);
        l_sign           clob;
        l_sign_validate  varchar2(256);
        l_secret         varchar2(256) :='UNITYBARS22';
        l_comment        varchar2(256):='Платеж возможный';
        l_close_date     date;
        l_fio            varchar2(256);
        l_debt_sum         number;
        l_okpo           varchar2(11);
        l_lim              number;
        l_avans            number;
        l_av_amount        number;
        l_xml_text varchar2(4000);
        l_kf accounts.kf%type;
        l_kv accounts.kv%type;
        l_rezid number;
    begin
        bars_audit.trace(g_pack || '. ' || l_proc ||
                     ': Start: Params: p_params => %s',
                     p_params.getStringVal());

        --Описание статусов
        /*
        -101 Параметры запроса не корректны. Обратитесь к администратору.
        -100 В биллинговой системе найдено более одного платежа c данным Pay_id
        -90 Сервис недоступный
        -42 Платеж на данную сумму невозможен для данного клиента
        -41 Прием платежей для данного клиента невозможен
        -40 Клиента не найдено
        -10 Транзакцию не найдено
        11 Статус транзакции определен
        21 Платеж возможный
        22 Платеж принят
        */
        --Пример входящего XML
        /*
        <pay-request>
        <act>1</act>
        <service_id> XXX</service_id>
        <pay_account>123434</pay_account>
        <pay_id>XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX</pay_id>
        <trade_point>term1232</trade_point>
        <sign>F454FR43DE32JHSAGDSSFS</sign>
        </pay-request>
        */


        --Код операции
        begin
        l_act :=to_number(p_params.extract('/pay-request/act/text()')
                             .getstringval());
            exception when others then
                l_status_code  := -101;
                l_comment:='Не числовой код операции';
        end;
        --Идентификатор системы
        l_service_id :=p_params.extract('/pay-request/service_id/text()').getstringval();
        --Уникальный номер транзакции
        l_transaction_id:=p_params.extract('/pay-request/pay_id/text()').getstringval();
        --Номер договора - наш AGR_NUM
        l_pay_account:=p_params.extract('/pay-request/pay_account/text()').getstringval();
        select REGEXP_SUBSTR(s, '[^.]+', 1, 1) kf,
           REGEXP_SUBSTR(s, '[^.]+', 1, 2) nd,
           REGEXP_SUBSTR(s, '[^.]+', 1, 3) kv
        into l_kf, l_pay_account, l_kv
        from (select l_pay_account s from dual);
        --Идентификатор терминала
        l_trade_point:=p_params.extract('/pay-request/trade_point/text()').getstringval();

        --Подпись
        l_sign:=p_params.extract('/pay-request/sign/text()').getclobval();

        --Проверим подпись по алгоритму NONSTOP24
         /*l_sign_validate:=get_sha1(l_act||'_'||l_pay_account||'_'||l_service_id||'_'||l_transaction_id||'_'||l_secret);

            if upper(l_sign_validate)<>l_sign then
                l_status_code  := -101;
                l_comment:='Подпись не верна';
            end if;*/
     /*if substr(l_pay_account,1,4) not in ('2620','2625','2630','2635') then
       l_status_code  := -101;
       l_comment:='Не допустимий балансовий номер рахунку';
     end if;*/

     if (l_status_code = 21) then
      begin
        select c.nmk as fio,
               a.dazs as close_date,
               nvl(fost(a.acc, gl.bdate), 0) / 100 as debt_sum,
               c.okpo
          into l_fio,
               l_close_date,
               l_debt_sum,
               l_okpo
          from accounts a, customer c
         where a.nls = l_pay_account
           and a.rnk = c.rnk
           and a.kv = 980;
       exception
        when others then
          l_status_code  := -40;
          l_comment := 'Номер счета №' || to_char(l_pay_account) || ' не найден';
      end;
    end if;

    -- проверка договора на закрытость
    if (l_status_code = 21) then
      if (l_close_date is not null) then
        l_status_code  := -41;
        l_comment := 'Прием платежей для данного клиента невозможен, договор закрыт';
      end if;
    end if;

    -- проверка клиента на нерезидента
    if (l_status_code = 21) then
      select cc.rezid
      into l_rezid   --(1-резидент, 2-не резидент)
      from  CODCAGENT cc      
      where cc.codcagent=(
      select c.codcagent from accounts a, customer c
      where a.nls = l_pay_account
           and a.rnk = c.rnk
           and a.kv = 980
                         );
      if (l_rezid<>1) then      
       l_status_code  := -41;
       l_comment := 'Прийом платежів для даного клієнта неможливий (нерез.)';
      end if; 
    end if; 
--

    bars_audit.info('IBOX: NONSTOP24: Запит інформації (' || l_transaction_id ||
                    ') по договору № ' || l_pay_account ||
                    '. Код результату обробки - ' || to_char(l_status_code) || ' (' ||
                    l_comment || ')');

    --Пример исходящегоXML
    /*
    <?xml version="1.0" encoding="UTF-8" ?>
    <pay-response>
    <balance>14515.47</balance>
    <name>test_name</name>
    <account>52654</account>
    <service_id>XXX</ service_id>
    <abonplata>23.22</abonplata>
    <min_amount>0.01</min_amount>
    <max_amount>20000</max_amount>
    <parameters>…</ parameters >
    <status_code>21</status_code>
    <time_stamp>27.01.2006 10:27:21</time_stamp>
    </pay-response>
    */

    l_xml_text := '<?xml version="1.0" encoding="UTF-8"?>';
    l_xml_text := l_xml_text || '<pay-response>';
  if (l_status_code=21) then
    l_xml_text := l_xml_text || '<balance>' ||l_av_amount||'</balance>';
    l_xml_text := l_xml_text || '<name>'|| l_fio ||'</name>';
    l_xml_text := l_xml_text || '<account>' || to_char(l_pay_account) || '</account>';
    l_xml_text := l_xml_text || '<okpo>' || l_okpo || '</okpo>';
    l_xml_text := l_xml_text || '<service_id>' || to_char(l_service_id) || '</service_id>';
    l_xml_text := l_xml_text || '<abonplata>'||'</abonplata>';
    l_xml_text := l_xml_text || '<min_amount>' || '</min_amount>';
    l_xml_text := l_xml_text || '<max_amount>' || '</max_amount>';
    l_xml_text := l_xml_text || '<parameters>' || l_comment || '</parameters>';
  end if;
    l_xml_text := l_xml_text || '<status_code>' || to_char(l_status_code) || '</status_code>';
    l_xml_text := l_xml_text || '<time_stamp>' || to_char(sysdate, 'dd.mm.yyyy HH24:MI:SS')  || '</time_stamp>';
    l_xml_text := l_xml_text || '</pay-response>';

    -- переводим в XMLType
    p_result := XMLType(l_xml_text);

         bars_audit.trace(g_pack || '. ' || l_proc || ': Finish: l_status_code = ' ||
                     l_xml_text);
    end get_info_nonstop24;


  /*procedure get_info_qiwi(p_transaction_id in varchar2,
                          p_agr_num in varchar2, -- номер договора
                          p_result out xmltype -- XML c результатом выполнения
                               )
    is
        l_proc           varchar2(30) := 'get_info_qiwi';
        l_status_code    number :=0;
        l_service_id     varchar2(20);
        l_transaction_id varchar2(100);
        l_comment        varchar2(256);
        l_close_date     date;
        l_fio            varchar2(256);
        l_debt_sum         number;
        l_lim              number;
        l_avans            number;
        l_av_amount        number;
        l_xml_text varchar2(4000);
        ---
        l_agr_num number;
    begin
        bars_audit.trace(g_pack || '. ' || l_proc ||
                     ': Start: Params: p_agr_num => %s', p_agr_num);

        --Код операции
        begin
        l_agr_num :=to_number(p_agr_num);
            exception when others then
                l_status_code  := 4;
                l_comment:='Не вірний формат ідентифікатора абонента';
        end;
        --Идентификатор системы
        l_service_id :='QIWI';
      begin
        select c.nmk as fio,
               a.dazs as close_date,
               nvl(-fost(wa.acc_pk, gl.bdate), 0) / 100 as debt_sum,
               (a.lim-nvl(-fost(wa.acc_pk, gl.bdate), 0)) / 100 as lim,
               nvl(fost(wa.acc_2625x, gl.bdate), 0) / 100 as avans,
               Int_for_pay(wa.nd)/100 as av_amount -- по просьбе Прейгера Андрея нужно показывать простроч.и нач. %%,
                                                   --Int_for_pay написано Суховой Т.А, 08/11/2013
          into l_fio,
               l_close_date,
               l_debt_sum,
               l_lim,
               l_avans,
               l_av_amount
          from w4_acc wa, accounts a, customer c
         where wa.agr_num = l_agr_num
           and wa.acc_pk = a.acc
           and a.rnk = c.rnk;
       exception
        when no_data_found then
           l_status_code  := 5;
           l_comment := 'Договор №' || to_char(p_agr_num) || ' не найден';
        when others then
           l_status_code  := 300;
           l_comment := 'Інша помилка провайдера';
      end;


      if (l_close_date is not null) then
        l_status_code  := 79;
        l_comment := 'Прием платежей для данного клиента невозможен, договор закрыт';
      end if;

    bars_audit.info('IBOX: QIWI: Запит інформації (' || p_transaction_id ||
                    ') по договору № ' || l_agr_num ||
                    '. Код результату обробки - ' || to_char(l_status_code) || ' (' ||
                    l_comment || ')');


    l_xml_text := '<?xml version="1.0" encoding="UTF-8"?>';
    l_xml_text := l_xml_text || '<response>';
    l_xml_text := l_xml_text || '<osmp_txn_id>' ||p_transaction_id||'</osmp_txn_id>';
    l_xml_text := l_xml_text || '<result>' ||l_status_code||'</result>';
--Если все хорошо, то построем тег fields
   if l_status_code=0 then
      l_xml_text:= l_xml_text||'<fields>';
      l_xml_text := l_xml_text || '<field1 name="FIO">'||'ПІБ - ' || l_fio ||'</field1>';
      l_xml_text := l_xml_text || '<field2 name="DEBT_SUM">'||'Сума виданого кредиту - '||l_debt_sum||'</field2>';
      l_xml_text := l_xml_text || '<field3 name="LIM">'||'Доступні кошти - '||l_lim||'</field3>';
      l_xml_text := l_xml_text || '<field4 name="AVANS">'||'Аванс - '||l_avans||'</field4>';
      l_xml_text := l_xml_text || '<field5 name="AV_AMOUNT">'||'Рекомендована сума до погашення - '||l_av_amount||'</field5>';
      l_xml_text:= l_xml_text||'</fields>';
   end if;
    l_xml_text := l_xml_text || '<comment>'||l_comment||'</comment>';
    l_xml_text := l_xml_text || '</response>';

    -- переводим в XMLType
    p_result := XMLType(l_xml_text);

         bars_audit.trace(g_pack || '. ' || l_proc || ': Finish: response = ' ||
                     l_xml_text);
    end get_info_qiwi;*/


procedure get_info_doc(p_params in xmltype, -- XML c входящими параметрами
                               p_result out xmltype -- XML c результатом выполнения
                               )
    is
        l_proc           varchar2(30) := 'get_info_doc';
        l_status_code    number :=11;
        l_act            number;
        l_service_id     varchar2(20);
        l_transaction_id varchar2(100);
        r_ibx_recs       ibx_recs%rowtype;
        --l_sign           varchar2(256);
        l_sign_validate  varchar2(256);
        l_secret         varchar2(256) :='UNITYBARS22';
        l_comment        varchar2(256):='Статус транзакции определен';
        l_sos            oper.sos%type;
        l_s              oper.s%type;
        l_transaction_code number;

        l_xml_text varchar2(4000);
    begin
        bars_audit.trace(g_pack || '. ' || l_proc ||
                     ': Start: Params: p_params => %s',
                     p_params.getStringVal());

        --Описание статусов
        /*
        -101 Параметры запроса не корректны. Обратитесь к администратору.
        -100 В биллинговой системе найдено более одного платежа c данным Pay_id
        -90 Сервис недоступный
        -42 Платеж на данную сумму невозможен для данного клиента
        -41 Прием платежей для данного клиента невозможен
        -40 Клиента не найдено
        -10 Транзакцию не найдено
        11 Статус транзакции определен
        21 Платеж возможный
        22 Платеж принят
        */

        /*
        Таблица кодов transaction status
        111 Платеж успешно выполнен.
        120 Платеж находится в обработке
        130 Платеж отменен
        */

        --Пример входящего XML
        /*
        <pay-request>
        <act>7</act>
        <service_id>ХХХ</service_id>
        <pay_id>XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX</pay_id>
        <sign>F454FR43DE32JHSAGDSSFS</sign>
        </pay-request>
        */


        --Код операции
        begin
        l_act :=to_number(p_params.extract('/pay-request/act/text()')
                             .getstringval());
            exception when others then
                l_status_code  := -101;
                l_comment:='Не числовой код операции';
        end;
        --Идентификатор системы
        l_service_id :=p_params.extract('/pay-request/service_id/text()').getstringval();
        --Уникальный номер транзакции
        l_transaction_id:=p_params.extract('/pay-request/pay_id/text()').getstringval();
        --Подпись
        --l_sign:=p_params.extract('/pay-request/sign/text()').getstringval();

        begin
            select ir.* into r_ibx_recs from ibx_recs ir
               where ir.type_id='TOMAS'
                 and ir.ext_ref=l_transaction_id;
            exception when no_data_found then
                l_status_code  := -10;
                l_comment:='Транзакцию не найдено';
          end;

        --Проверим подпись по алгоритму NONSTOP24
         --l_sign_validate:=get_sha1(l_act||'_'||''||'_'||l_service_id||'_'||l_transaction_id||'_'||l_secret);

            /*if upper(l_sign_validate)<>l_sign then
                l_status_code  := -101;
                l_comment:='Подпись не верна';
            end if;*/

     if (l_status_code = 11) then
      begin
        select  o.sos, o.s into l_sos, l_s
          from oper o
         where o.ref=r_ibx_recs.abs_ref ;
      exception
        when no_data_found then
          l_status_code  := -10;
          l_comment:='Транзакцию не найдено';
      end;
    end if;

    --Проверка статуса документа в АБС
    if l_sos=5 then
         l_transaction_code:=111;
    elsif l_sos<0 then
         l_transaction_code:=130;
    else
         l_transaction_code:=120;
    end if;

    bars_audit.info('IBOX: NonStop24: Запит інформації  по транзакции  ' || l_transaction_id ||
                    '. Код результату обробки - ' || to_char(l_status_code) || ' (' ||
                    l_comment || '). Статус платежа = '||l_transaction_code);

    --Пример исходящегоXML
    /*
    Код результата запроса:
        <?xml version="1.0" encoding="UTF-8" ?>
            <pay-response>
                <status_code>11</status_code>
                <time_stamp>27.01.2006 10:27:21</time_stamp>
                <transaction>
                <pay_id> XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX</pay_id >
                <service_id>XXX</ service_id>
                <amount>10.20</amount>
                <status>111</status>
                <time_stamp>24.01.2006 10:27:21</time_stamp>
                </transaction>
                </pay-response>

                ИЛИ
                <?xml version="1.0" encoding="UTF-8" ?>
                <pay-response>
                <status_code>-10</status_code>
                <time_stamp>27.01.2006 10:27:21</time_stamp>
               </pay-response>
    */

    l_xml_text := '<?xml version="1.0" encoding="UTF-8"?>';
    l_xml_text := l_xml_text || '<pay-response>';
    l_xml_text := l_xml_text || '<status_code>' || to_char(l_status_code) || '</status_code>';
    l_xml_text := l_xml_text || '<time_stamp>' || to_char(sysdate, 'dd.mm.yyyy HH24:MI:SS')  || '</time_stamp>';
  if(l_status_code=11) then
    l_xml_text := l_xml_text || '<transaction>';
    l_xml_text := l_xml_text || '<pay_id>' || to_char(l_transaction_id) || '</pay_id>';
    l_xml_text := l_xml_text || '<service_id>' || to_char(l_service_id) || '</service_id>';
    l_xml_text := l_xml_text || '<amount>' || to_char(l_s) ||'</amount>';
    l_xml_text := l_xml_text || '<status>' || to_char(l_transaction_code) || '</status>';
    l_xml_text := l_xml_text || '<time_stamp>' || to_char(sysdate, 'dd.mm.yyyy HH24:MI:SS')  || '</time_stamp>';
    l_xml_text := l_xml_text || '</transaction>';
  end if;
    l_xml_text := l_xml_text || '</pay-response>';

    -- переводим в XMLType
    p_result := XMLType(l_xml_text);

         bars_audit.trace(g_pack || '. ' || l_proc || ': Finish: l_status_code = ' ||
                     l_xml_text);
    end get_info_doc;

 --Процедура оплати по всем правилам через PAYTT
  procedure pay_gl_real(p_src_nls  in varchar2,
                   p_deal_id  in varchar2,
                   p_sum      in number,
                   p_date     in date,
                   p_receipt_num varchar2,
                   p_res_code out number,
                   p_res_text out varchar2,
                   p_res_ref  out oper.ref%type)
    is
       --l_w4acc_r    w4_acc%rowtype;
       l_acc        accounts%rowtype;
       l_nd         oper.nd%type := substr(p_deal_id, -10);
       l_debit_nls  oper.nlsa%type;
       l_nls_credit oper.nlsb%type;
       l_debit_name oper.nam_a%type;
       l_nms_credit oper.nam_b%type;
       l_dk         number:=1;
       l_ref        oper.ref%type;
       l_kv         tabval.kv%type:=980;
       l_mfo        banks.mfo%type;
       l_bdate      date;
       l_tt         tts.tt%type:='328';
       l_nazn       varchar2(160);
       l_okpo       customer.okpo%type;
 begin
        -- обнуляем результат
        p_res_code := 0;
        p_res_text := null;
        p_res_ref  := null;

    -- проверка суммы на корректность
    if (p_sum is null or p_sum < 1) then
      p_res_code := 1;
      p_res_text := 'Помилка суми погашення';
      return;
    end if;
    if substr(p_deal_id,1,4) not in ('2620','2625','2630','2635') then
       p_res_code  := 2;
       p_res_text:='Не допустимий балансовий номер рахунку';
     end if;

    -- получение параметров счета источника
    begin
      select a.nls, substr(a.nms, 1, 38)
        into l_debit_nls, l_debit_name
        from accounts a
       where a.nls = p_src_nls
         and a.kv = l_kv
         and a.dazs is null;
    exception
      when no_data_found then
        p_res_code := 2;
        p_res_text := 'Рахунок джерела для списання не найдено nls=' || p_src_nls;
        return;
    end;

    -- ищем договор
    begin
      /*select wa.*
        into l_w4acc_r
        from w4_acc wa
       where wa.nd = p_deal_id;*/
       select a.*
         into l_acc
         from accounts a
        where a.nls = p_deal_id
          and a.kv = 980;
    exception
      when no_data_found then
        p_res_code := 3;
        p_res_text := 'Рахунок №' || p_deal_id || ' не знайдено';
        return;
    end;

    --ищем счет 2625 и ОКПО клиента
    begin
      select a.nls, substr(a.nms,1,38), c.okpo
        into l_nls_credit,l_nms_credit, l_okpo
      from accounts a, customer c
        where c.rnk=a.rnk
          and a.acc=l_acc.acc;
    exception
      when no_data_found then
        p_res_code:=4;
        p_res_text:='Рахунок №'||l_nls_credit||' не знайдено!';
        return;
    end;

    if l_acc.tip = 'DEP' then
      declare
        l_lim decimal;
        l_deposit v_mway_dpt_portfolio_all%rowtype;
      begin
        select * into l_deposit from v_mway_dpt_portfolio_all v where v.dpt_accnum = l_nls_credit;
        select limit * 100 into l_lim from dpt_vidd where vidd = l_deposit.vidd_code;

        if p_sum < l_lim then
          p_res_code:=4;
          p_res_text:='Мінімальна сума платежу '||l_lim/100||' грн.';
        end if;
      exception
        when no_data_found then
          p_res_code:=4;
          p_res_text:='Не знайдено депозитний договір за рахунком №'||l_nls_credit;
      end;
    end if;


  l_bdate := gl.bdate;
  l_mfo   := f_ourmfo_g/*gl.amfo*/;
  l_nazn := substr('Поповнення рахунку №'||p_deal_id,1,160);
  p_res_text := l_nazn;

  --Оплата документа
  gl.ref (l_ref);

  gl.in_doc3 (ref_    => l_ref,
              tt_     => l_tt,
              vob_    => 6,
              nd_     => l_nd,
              pdat_   => sysdate,
              vdat_   => l_bdate,
              dk_     => l_dk,
              kv_     => l_kv,
              s_      => p_sum,
              kv2_    => l_kv,
              s2_     =>p_sum,
              sk_     => 5,
              data_   => l_bdate,
              datp_   => p_date,
              nam_a_  => l_debit_name,
              nlsa_   => l_debit_nls,
              mfoa_   => l_mfo,
              nam_b_  => l_nms_credit,
              nlsb_   => l_nls_credit,
              mfob_   => l_mfo,
              nazn_   => l_nazn,
              d_rec_  => null,
              id_a_   => f_ourokpo,
              id_b_   => l_okpo,
              id_o_   => null,
              sign_   => null,
              sos_    => null,
              prty_   => 0,
              uid_    => null);

  paytt ( flg_ => null,
          ref_ => l_ref,
         datv_ => l_bdate,
           tt_ => l_tt,
          dk0_ => l_dk,
          kva_ => l_kv,
         nls1_ => l_debit_nls,
           sa_ => p_sum,
          kvb_ => l_kv,
         nls2_ => l_nls_credit,
           sb_ => p_sum );


    p_res_ref:=l_ref;

 end;

 --Процедура оплати по всем правилам через PAYTT
 procedure pay_gl(p_src_nls  in varchar2,
                  p_trans_nls in varchar2,
                  p_deal_id  in varchar2,
                  p_sum      in number,
                  p_date     in date,
                  p_receipt_num varchar2,
                  p_res_code out number,
                  p_res_text out varchar2,
                  p_res_ref  out oper.ref%type)
    is
       --l_w4acc_r    w4_acc%rowtype;
       l_acc        accounts%rowtype;
       l_trans_acc  accounts%rowtype;
       l_nd         oper.nd%type := substr(p_deal_id, -10);
       l_src_nls    oper.nlsa%type;
       l_debit_nls  oper.nlsa%type;
       l_nls_credit oper.nlsb%type;
       l_debit_name oper.nam_a%type;
       l_nms_credit oper.nam_b%type;
       l_dk         number:=1;
       l_ref        oper.ref%type;
       l_kv         tabval.kv%type:=980;
       l_mfo        banks.mfo%type;
       l_bdate      date;
       l_tt         tts.tt%type:='328';
       l_nazn       varchar2(160);
       l_okpo       customer.okpo%type;
 begin
        -- обнуляем результат
        p_res_code := 0;
        p_res_text := null;
        p_res_ref  := null;

    -- проверка суммы на корректность
    if (p_sum is null or p_sum < 1) then
      p_res_code := 1;
      p_res_text := 'Помилка суми погашення';
      return;
    end if;
    /*if substr(p_deal_id,1,4) not in ('2620','2625','2630','2635') then
       p_res_code  := 2;
       p_res_text:='Не допустимий балансовий номер рахунку';
     end if;*/


     --l_src_nls := '10049000001001';--'10040000012001';


    -- получение параметров счета источника
    begin
      select a.nls, substr(a.nms, 1, 38)
        into l_debit_nls, l_debit_name
        from accounts a
       where a.nls = p_src_nls
         and a.kv = l_kv
         and a.dazs is null;
    exception
      when no_data_found then
        p_res_code := 2;
        p_res_text := 'Рахунок джерела для списання не найдено nls=' || p_src_nls;
        return;
    end;

    -- ищем договор
    begin
      /*select wa.*
        into l_w4acc_r
        from w4_acc wa
       where wa.nd = p_deal_id;*/
       select a.*
         into l_acc
         from accounts a
        where a.nls = p_deal_id
          and a.kv = 980;
    exception
      when no_data_found then
        p_res_code := 3;
        p_res_text := 'Рахунок №' || p_deal_id || ' не знайдено';
        return;
    end;

    -- ищем договор
    begin
      /*select wa.*
        into l_w4acc_r
        from w4_acc wa
       where wa.nd = p_deal_id;*/
       select a.*
         into l_trans_acc
         from accounts a
        where a.nls = p_trans_nls
          and a.kv = 980;
    exception
      when no_data_found then
        p_res_code := 3;
        p_res_text := 'Рахунок №' || p_trans_nls || ' не знайдено';
        return;
    end;

    --ищем счет 2625 и ОКПО клиента
    begin
      select a.nls, substr(a.nms,1,38), c.okpo
        into l_nls_credit,l_nms_credit, l_okpo
      from accounts a, customer c
        where c.rnk=a.rnk
          and a.acc=l_acc.acc;
    exception
      when no_data_found then
        p_res_code:=4;
        p_res_text:='Рахунок №'||l_nls_credit||' не знайдено!';
        return;
    end;

    /*
    if l_acc.tip = 'DEP' then
      declare
        l_lim decimal;
        l_deposit v_mway_dpt_portfolio_all%rowtype;
      begin
        select * into l_deposit from v_mway_dpt_portfolio_all v where v.dpt_accnum = l_nls_credit;
        select limit * 100 into l_lim from dpt_vidd where vidd = l_deposit.vidd_code;

        if p_sum < l_lim then
          p_res_code:=4;
          p_res_text:='Мінімальна сума платежу '||l_lim/100||' грн.';
        end if;
      exception
        when no_data_found then
          p_res_code:=4;
          p_res_text:='Не знайдено депозитний договір за рахунком №'||l_nls_credit;
      end;
    end if; */


  l_bdate := gl.bdate;
  l_mfo   := f_ourmfo_g/*gl.amfo*/;
  l_nazn := 'Поповнення сейфу';
  p_res_text := l_nazn;

  --Оплата документа
  gl.ref (l_ref);

  gl.in_doc3 (ref_    => l_ref,
              tt_     => l_tt,
              vob_    => 6,
              nd_     => l_nd,
              pdat_   => sysdate,
              vdat_   => l_bdate,
              dk_     => l_dk,
              kv_     => l_kv,
              s_      => p_sum,
              kv2_    => l_kv,
              s2_     =>p_sum,
              sk_     => 5,
              data_   => l_bdate,
              datp_   => p_date,
              nam_a_  => l_debit_name,
              nlsa_   => l_debit_nls,
              mfoa_   => l_mfo,
              nam_b_  => l_nms_credit,
              nlsb_   => l_nls_credit,
              mfob_   => l_mfo,
              nazn_   => l_nazn,
              d_rec_  => null,
              id_a_   => f_ourokpo,
              id_b_   => l_okpo,
              id_o_   => null,
              sign_   => null,
              sos_    => null,
              prty_   => 0,
              uid_    => null);

  paytt ( flg_ => null,
          ref_ => l_ref,
         datv_ => l_bdate,
           tt_ => l_tt,
          dk0_ => l_dk,
          kva_ => l_kv,
         nls1_ => l_debit_nls,
           sa_ => p_sum,
          kvb_ => l_kv,
         nls2_ => p_trans_nls,
           sb_ => p_sum );

  paytt ( flg_ => null,
          ref_ => l_ref,
         datv_ => l_bdate,
           tt_ => l_tt,
          dk0_ => l_dk,
          kva_ => l_kv,
         nls1_ => p_trans_nls,
           sa_ => p_sum,
          kvb_ => l_kv,
         nls2_ => l_nls_credit,
           sb_ => p_sum );

    gl.pay( 2, l_ref,l_bdate);

       --Добавляем в доп. реквезит документа номер чека ТОМАС
        insert into OPERW ( REF, TAG, VALUE ) values ( l_ref, 'NUMCH', p_receipt_num );
 
   
    p_res_ref := l_ref;


 end;

 --Процедура оплати по всем правилам через PAYTT
 procedure pay_legal_pers(p_trade_point in varchar2,
                          p_payer_name in varchar2,
                          p_receiver_acc in varchar2,
                          p_receiver_mfo in varchar2,
                          p_receiver_curr in varchar2,
                          p_receiver_okpo in integer,
                          p_receiver_name in varchar2,
                          p_cash_symb in varchar2,
                          p_payment_purpose in varchar2,
                          p_transaction_info in varchar2_list_pck,
                          p_answer_info out varchar2_list_pck,
                          p_res_code out number,
                          p_res_text out varchar2) is
       l_nd         oper.nd%type;
       l_debit_nls  oper.nlsa%type;
       l_trans_2902 oper.nlsb%type;
       l_trans_2902_nm accounts.nms%type;
       l_6110 oper.nlsb%type;
       l_nls_t00 oper.nlsb%type;
       l_debit_name oper.nam_a%type;
       l_dk         number:=1;
       l_ref        oper.ref%type;
       l_trade_point  ibx_trade_point.trade_point%type;
       l_mfo          banks.mfo%type;
       l_bdate        date;
       l_tt           tts.tt%type:='TO1';
       l_nazn         varchar2(160);
       l_pay_amount   number(32);
       l_fee_amount   number(32);
       l_pay_id       varchar2(300);
       l_transaction_info varchar2(1000);
       l_receipt_num  varchar2(220);

       err_   NUMBER;    -- Return code
       rec_   NUMBER;    -- Record number
       mfoa_  VARCHAR2(12);   -- Sender's MFOs
       nlsa_  VARCHAR2(15);   -- Sender's account number
       mfob_  VARCHAR2(12);   -- Destination MFO
       nlsb_  VARCHAR2(15);   -- Target account number
       dk_    NUMBER;         -- Debet/Credit code
       s_     DECIMAL(24);    -- Amount
       vob_   NUMBER;         -- Document type
       nd_    VARCHAR2(10);   -- Document number
       kv_    NUMBER;         -- Currency code
       datD_  DATE;           -- Document date
       datP_  DATE;           -- Posting date
       nam_a_  VARCHAR2(38);  -- Sender's customer name
       nam_b_  VARCHAR2(38);  -- Target customer name
       nazn_   VARCHAR(160);  -- Narrative
       nazns_ CHAR(2);        -- Narrative contens type
       id_a_  VARCHAR2(14);   -- Sender's customer identifier
       id_b_  VARCHAR2(14);   -- Target's customer identifier
       datA_  DATE;           -- Input file date/time
       d_rec_ VARCHAR2(80);   -- Additional parameters
       sos_   NUMBER;
       refA_  VARCHAR2(9);
       prty_  NUMBER;
 begin

        -- обнуляем результат
    p_res_code := 22;
    p_res_text := null;

    l_mfo   := substr(p_trade_point,-6,6);

    bc.go(l_mfo);

    l_bdate := gl.bdate;
    l_trade_point := substr(p_trade_point, 0, length(p_trade_point)-6);

/*    if (l_pay_amount < 100) or (l_fee_amount < 100) then
          p_res_code := 101;
          p_res_text := 'Суммы платежа и комиссии должны быть кратными 1 грн(мелочь не допускается)';
          return;
    end if;*/

    begin
       select itp.nls
         into l_debit_nls
         from ibx_trade_point itp
        where itp.trade_point = l_trade_point
          and itp.mfo = l_mfo;
      exception
        when no_data_found then
          p_res_code := 101;
          p_res_text := 'Код устройства Томас в указанном МФО не найден';
          return;
     end;

     begin
       select acc.nms
         into l_debit_name
         from accounts acc
        where acc.nls = l_debit_nls
          and acc.kf = l_mfo;
      exception
        when no_data_found then
          p_res_code := 101;
          p_res_text := 'Счет 1004 для устройства Томас не найден';
          return;
     end;

    l_nazn  := nvl(p_payment_purpose, 'Поповнення рахунку від '||p_payer_name);

    p_res_text := l_nazn;

    for c0 in p_transaction_info.first..p_transaction_info.last loop
       l_receipt_num := substr(p_transaction_info(c0),1,instr(p_transaction_info(c0),'@')-1);
       l_transaction_info := substr(p_transaction_info(c0),instr(p_transaction_info(c0),'@') + 1);
       l_pay_id := substr(l_transaction_info,1,instr(l_transaction_info,'@')-1);
       l_transaction_info := substr(l_transaction_info,instr(l_transaction_info,'@') + 1);
       l_pay_amount := to_number(substr(l_transaction_info,1,instr(l_transaction_info,'@')-1));
       l_transaction_info := substr(l_transaction_info,instr(l_transaction_info,'@') + 1);
       l_fee_amount := to_number(substr(l_transaction_info,1));

       begin
           select i.ref
             into l_ref
             from ibx_legal_pers_paym i
            where i.pay_id = l_pay_id;
        exception when no_data_found then
          l_ref := null;
       end;

       if (l_ref is null) then
          --Оплата документа
          gl.ref (l_ref);

          gl.in_doc3 (ref_    => l_ref,
                      tt_     => l_tt,
                      vob_    => 6,
                      nd_     => substr(to_char(l_ref), 1, 10),
                      pdat_   => sysdate,
                      vdat_   => l_bdate,
                      dk_     => l_dk,
                      kv_     => p_receiver_curr,
                      s_      => l_pay_amount + l_fee_amount,
                      kv2_    => p_receiver_curr,
                      s2_     => l_pay_amount + l_fee_amount,
                      sk_     => p_cash_symb,
                      data_   => l_bdate,
                      datp_   => l_bdate,
                      nam_a_  => l_debit_name,
                      nlsa_   => l_debit_nls,
                      mfoa_   => l_mfo,
                      nam_b_  => p_receiver_name,
                      nlsb_   => p_receiver_acc,
                      mfob_   => p_receiver_mfo,
                      nazn_   => l_nazn,
                      d_rec_  => null,
                      id_a_   => f_ourokpo,
                      id_b_   => p_receiver_okpo,
                      id_o_   => null,
                      sign_   => null,
                      sos_    => null,
                      prty_   => 0,
                      uid_    => null);

        --Добавляем в доп. реквезит документа номер чека ТОМАС
        insert into OPERW ( REF, TAG, VALUE ) values ( l_ref, 'NUMCH', l_receipt_num );

                      
          select ac.nls, ac.nms
            into l_trans_2902, l_trans_2902_nm
            from accounts ac
           where ac.nls = '29023061015099'
             and ac.ob22 = '06'
             and ac.kv = p_receiver_curr
             and ac.dazs is null
             and ac.kf = l_mfo
             and ac.branch = '/'||l_mfo||'/';

          paytt ( flg_ => 0,
                  ref_ => l_ref,
                 datv_ => l_bdate,
                   tt_ => l_tt,
                  dk0_ => l_dk,
                  kva_ => p_receiver_curr,
                 nls1_ => l_debit_nls,
                   sa_ => l_pay_amount + l_fee_amount,
                  kvb_ => p_receiver_curr,
                 nls2_ => l_trans_2902,
                   sb_ => l_pay_amount + l_fee_amount );

           if (l_fee_amount > 0) then
              select ac.nls
                into l_6110
                from accounts ac
               where ac.nls = '65104740015099'
                 and ac.ob22 = '74'
                 and ac.kf = l_mfo
                 and ac.kv = p_receiver_curr
                 and ac.dazs is null
                 and ac.branch = '/'||l_mfo||'/';

              paytt ( flg_ => 0,
                      ref_ => l_ref,
                     datv_ => l_bdate,
                       tt_ => l_tt,
                      dk0_ => l_dk,
                      kva_ => p_receiver_curr,
                     nls1_ => l_trans_2902,
                       sa_ => l_fee_amount,
                      kvb_ => p_receiver_curr,
                     nls2_ => l_6110,
                       sb_ => l_fee_amount);
           end if;



              if (l_mfo != p_receiver_mfo) then
                select get_proc_nls('T00',980)
                  into l_nls_t00
                  from dual;
                paytt ( flg_ => 0,
                        ref_ => l_ref,
                       datv_ => l_bdate,
                         tt_ => l_tt,
                        dk0_ => l_dk,
                        kva_ => p_receiver_curr,
                       nls1_ => l_trans_2902,
                         sa_ => l_pay_amount,
                        kvb_ => p_receiver_curr,
                       nls2_ => l_nls_t00,
                         sb_ => l_pay_amount );

                gl.pay( 2,l_ref,l_bdate);

                 SELECT mfoa, nlsa, mfob, nlsb, dk, s, vob, nd, kv,
                        datd, datp, nam_a, nam_b, nazn, id_a, id_b,
                        d_rec, sos, ref_a, prty
                   INTO mfoa_,nlsa_,mfob_,nlsb_,dk_,s_,vob_,nd_,kv_,
                        datd_,datp_,nam_a_,nam_b_,nazn_,id_a_,id_b_,
                        d_rec_, sos_, refA_, prty_
                   FROM oper WHERE ref=l_ref;

                 if (sos_ = 5 ) then
                    IF LENGTH(TRIM(NVL(d_rec_,'')))>0 THEN
                       nazns_ := '11';
                    ELSE
                       nazns_ := '10';
                    END IF;
                 end if;

                    sep.in_sep(err_,rec_,mfoa_,l_trans_2902,mfob_,nlsb_,dk_,l_pay_amount,
                               vob_,nd_,kv_,datD_,datP_,substr(l_trans_2902_nm,1,38),nam_b_,nazn_,
                               NULL,nazns_,id_a_,id_b_,'******',refA_,0,'0123',
                               NULL,NULL,datA_,d_rec_,0,l_ref,0);
              else
                paytt ( flg_ => null,
                        ref_ => l_ref,
                       datv_ => l_bdate,
                         tt_ => l_tt,
                        dk0_ => l_dk,
                        kva_ => p_receiver_curr,
                       nls1_ => l_trans_2902,
                         sa_ => l_pay_amount,
                        kvb_ => p_receiver_curr,
                       nls2_ => p_receiver_acc,
                         sb_ => l_pay_amount);
                gl.pay( 2, l_ref,l_bdate);
              end if;

           insert into ibx_legal_pers_paym (pay_id, ref)
           values (l_pay_id, l_ref);
       end if;
       p_answer_info(c0) :=  l_pay_id||'@'||l_ref;
    end loop;
    commit;
    exception when others then
       p_res_code := 101;
       p_res_text := sqlerrm;
       p_answer_info.delete;
       rollback;


 end;


 procedure ins_log_xml(p_in_xml clob, p_out_xml clob, p_ref varchar2) is

   begin

     merge into test_ibx_xml t
      using (select * from dual) on (t.ext_ref = p_ref)
      when matched then update set rq_clob = p_in_xml, rs_clob = p_out_xml
      when not matched then insert values (p_ref, p_in_xml, p_out_xml);

   end;

end ibx_pack;
/
 show err;
 
PROMPT *** Create  grants  IBX_PACK ***
grant EXECUTE                                                                on IBX_PACK        to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/ibx_pack.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 
