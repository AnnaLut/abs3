 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/wcs_register.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.WCS_REGISTER is

  -- ===============================================================================================
  g_header_version constant varchar2(64) := 'version 3.8 07/08/2015';

  -- возвращает версию заголовка пакета
  function header_version return varchar2;
  -- возвращает версию тела пакета
  function body_version return varchar2;

  -- ===============================================================================================
  -- Public types declarations
  -- структура платежных инструкций
  type t_pmt_instr is record(
    mfo  oper.mfob%type, -- МФО получателя
    nls  oper.nlsb%type, -- Номер счета получателя
    nam oper.nam_b%type, -- Наименование счета получателя
    okpo oper.id_b%type, -- ИПН получателя
    nazn oper.nazn%type -- Назначение платежа
    );
  -- ===============================================================================================

  function to_number2(p varchar2) return number;

  -- Получение платежных инструкций для перечисления кредитных средств
  function get_payment_instr(p_bid_id wcs_bids.id%type -- Идентификатор заявки
                             ) return t_pmt_instr;

  -- Регистрация кредита
  procedure register_credit(p_bid_id in v_wcs_bids.bid_id%type -- идентификатор заявки
                            );
  -- Визирование заявки/кредита
  /*
  p_visa - устанавливаемое значение договора
  0  - Отркыв-ся КД, строятся графики погашения и потоки рассчитывается эф ставка
  2  - Регистрируется обеспечение и договора страховки. И уст cc_deal.sos=4
  4  - Откр-ся счета договора и обеспечении. Присоединяется текущий счет
  10 - Формирование остатков на счетах залога. Формирование остатков на счете дисконта. Кд переходит в режим обслуживания

  15 - Закрывается КД
  */
  procedure put_visa(p_bid_id in number, -- идентификатор заявки
                     p_visa   in number);


  -- Регистрация договора обеспечения
  function set_guarantee_deal(p_bid_id       in v_wcs_bid_garantees.bid_id%type, -- Идентификатор заявки
                              p_garantee_id  in v_wcs_bid_garantees.garantee_id%type, -- Идентификатор типа обеспечения
                              p_garantee_num in v_wcs_bid_garantees.garantee_num%type, -- Номер обеспечения
                              p_rnk          in customer.rnk%type default null -- РНК клиента
                              ) return grt_deals.deal_id%type;

end wcs_register;
/
CREATE OR REPLACE PACKAGE BODY BARS.WCS_REGISTER is
  -- ================================== Константы ===============================================
  g_isto      int := 4; -- код источника финансирования
  g_obs       int := 1; -- код обс долга,
  g_freq      int := 5; -- периодичность погашения кредита
  g_freqp     int := 5; -- периодичность погаш %
  g_daynp     int := -2; -- Кор-ка выходных дней в ГПК
  g_grp       int := 5; -- код группы счета
  g_BR        int := 9999; -- код базовоц процентной ставки
  g_pack_name varchar2(20) := 'wcs_register. ';
  -- ===============================================================================================

  g_body_version constant varchar2(64) := 'version 3.8 07/08/2015';

  -- header_version - возвращает версию заголовка пакета
  function header_version return varchar2 is
  begin
    return 'Package header wcs_register ' || g_header_version || '.';
  end header_version;

  -- body_version - возвращает версию тела пакета
  function body_version return varchar2 is
  begin
    return 'Package body wcs_register ' || g_body_version || '.';
  end body_version;
  -- ===============================================================================================

  function to_number2(p varchar2) return number IS
  begin
    return round(TO_number(translate(p, ',', '. '),
                     '99999999999D999',
                     'NLS_NUMERIC_CHARACTERS = ''. '''),2);
  end;

  -- Соединяет строки через запятую
  function concat_strings(s1  in varchar2,
                          s2  in varchar2,
                          s3  in varchar2 default null,
                          s4  in varchar2 default null,
                          s5  in varchar2 default null,
                          s6  in varchar2 default null,
                          s7  in varchar2 default null,
                          s8  in varchar2 default null,
                          s9  in varchar2 default null,
                          s10 in varchar2 default null) return varchar2 is
    l_res varchar2(4000);
  begin
    select replace(s1, ',', ' ') || nvl2(s2, ', ', '') ||
           replace(s2, ',', ' ') || nvl2(s3, ', ', '') ||
           replace(s3, ',', ' ') || nvl2(s4, ', ', '') ||
           replace(s4, ',', ' ') || nvl2(s5, ', ', '') ||
           replace(s5, ',', ' ') || nvl2(s6, ', ', '') ||
           replace(s6, ',', ' ') || nvl2(s7, ', ', '') ||
           replace(s7, ',', ' ') || nvl2(s8, ', ', '') ||
           replace(s8, ',', ' ') || nvl2(s9, ', ', '') ||
           replace(s9, ',', ' ') || replace(s10, ',', ' ')
      into l_res
      from dual;

    return l_res;
  end concat_strings;

  -- Получение платежных инструкций для перечисления кредитных средств
  function get_payment_instr(p_bid_id wcs_bids.id%type -- Идентификатор заявки
                             ) return t_pmt_instr is
    l_res  t_pmt_instr;
    l_nazn varchar2(4000);

    function get_payment_nazn(p_bid_id wcs_bids.id%type -- Идентификатор заявки
                              ) return varchar2 is
      l_pattern varchar2(4000);
      l_res     varchar2(4000);
    begin
      select dbms_lob.substr(f.html, dbms_lob.getlength(f.html), 1)
        into l_pattern
        from wcs_forms f
       where f.id = 'CRD_PAYMENT_NAZN_PTRN';
      l_res := wcs_utl.parse_sql(p_bid_id, l_pattern);

      return l_res;
    end get_payment_nazn;

  begin
    -- Готовим назначение платежа
    l_nazn := get_payment_nazn(p_bid_id);

    -- Определяем выбраный тип выдачи и исходя из него платежные инструкции
    case
      when wcs_utl.get_answ(p_bid_id, 'PI_CURACC_SELECTED') = 1 then
        -- CURACC На поточний рахунок
        declare
          l_pi_curacc_accno accounts.acc%type;
        begin
          l_pi_curacc_accno := to_number(wcs_utl.get_answ(p_bid_id,
                                                          'PI_CURACC_ACCNO'));
          if (l_pi_curacc_accno is not null) then
            select a.kf   as mfo,
                   a.nls  as nls,
                   c.nmk  as nam,
                   c.okpo as okpo,
                   l_nazn as nazn
              into l_res.mfo, l_res.nls, l_res.nam, l_res.okpo, l_res.nazn
              from accounts a, customer c
             where a.acc = l_pi_curacc_accno
               and a.rnk = c.rnk;
          end if;
        end;

      when wcs_utl.get_answ(p_bid_id, 'PI_CARDACC_SELECTED') = 1 then
        -- CARDACC На картковий рахунок !!! Доделать !!!
        -- cmn.wp.ANSW_TEXT_SET(BID_ID, "PI_CARDACC_ACCNO", PI_CARDACC_ACCNO.Value);
        null;

      when wcs_utl.get_answ(p_bid_id, 'PI_PARTNER_SELECTED') = 1 then
        -- PARTNER На рахунок партнера
        select p.ptn_mfo  as mfo,
               p.ptn_nls  as nls,
               p.ptn_name as nam,
               p.ptn_okpo as okpo,
               l_nazn     as nazn
          into l_res.mfo, l_res.nls, l_res.nam, l_res.okpo, l_res.nazn
          from wcs_partners p
         where p.id =
               to_number(wcs_utl.get_answ(p_bid_id, 'PI_PARTNER_ID'));

      when wcs_utl.get_answ(p_bid_id, 'PI_FREE_SELECTED') = 1 then
        -- FREE На вказані реквізити
        l_res.mfo  := wcs_utl.get_answ(p_bid_id, 'PI_FREE_MFO');
        l_res.nls  := wcs_utl.get_answ(p_bid_id, 'PI_FREE_NLS');
        l_res.nam  := wcs_utl.get_answ(p_bid_id, 'PI_FREE_NAME');
        l_res.okpo := wcs_utl.get_answ(p_bid_id, 'PI_FREE_OKPO');
        l_res.nazn := l_nazn;

      when wcs_utl.get_answ(p_bid_id, 'PI_CASH_SELECTED') = 1 then
        -- CASH Через касу банка
        select a.kf as mfo,
               a.nls,
               substr(a.nms, 1, 38) as nam,
               c.okpo,
               l_nazn as nazn
          into l_res.mfo, l_res.nls, l_res.nam, l_res.okpo, l_res.nazn
          from accounts a, customer c
         where a.rnk = c.rnk
           and a.nls =
               (select val
                  from branch_parameters
                 where tag = 'CASH'
                   and branch = wcs_utl.get_answ(p_bid_id, 'PI_CASH_BRANCH'))
           and a.kv =
               (select kv
                  from tabval t
                 where t.lcv =
                       wcs_utl.get_creditdata(p_bid_id, 'CREDIT_CURRENCY'));

    end case;

    return l_res;
  end get_payment_instr;

  /* !!! Ждем обновления модуля страхования
  -- Построение графика платежей по страховке
  procedure append_payment_ins(p_deal_id   ins_payments_schedule.deal_id%type,
                               p_plan_date ins_payments_schedule.plan_date%type,
                               p_plan_sum  ins_payments_schedule.plan_sum%type,
                               p_alertdays ins_payments_schedule.alertdays%type default null,
                               p_freq      number) is
    l_ostc   number := p_plan_sum;
    l_sum    number;
    l_col    int;
    l_months int;
    l_num    int := 1;
  begin

    bars_audit.info(g_pack_name || ' append_payment_ins ' ||
                    'Start. Params:  p_deal_id=' || to_char(p_deal_id) ||
                    ' Plan Date= ' || to_char(p_plan_date) ||
                    ' Plan Summa=' || to_char(p_plan_sum) || ' Freq=' ||
                    to_char(p_freq));
    if p_plan_sum > 0 then
      l_col := (case
                 when p_freq = 5 then
                  12
                 when p_freq = 7 then
                  4
                 when p_freq = 180 then
                  2
                 when p_freq = 360 then
                  1
                 else
                  1
               end);

      l_months := (case
                    when p_freq = 5 then
                     1
                    when p_freq = 7 then
                     3
                    when p_freq = 180 then
                     6
                    else
                     12
                  end);
      l_sum    := round(p_plan_sum / l_col);
      for cur in 1 .. l_col loop
        if l_num = l_col then
          INS_PACK.P_ADD_PAYMENT(p_deal_id,
                                 add_months(p_plan_date,
                                            (l_num - 1) * l_months),
                                 l_ostc,
                                 p_alertdays);
        else
          INS_PACK.P_ADD_PAYMENT(p_deal_id,
                                 add_months(p_plan_date,
                                            (l_num - 1) * l_months),
                                 l_sum,
                                 p_alertdays);

        end if;
        l_ostc := l_ostc - l_sum;
        l_num  := l_num + 1;
      end loop;
    end if;
  end;
  */

  -- Открытие счетов
  procedure accounts_open(p_bid_id         in number, -- референс договора
                          p_subproduct_id  in varchar2, -- идентификатор субпродукта
                          p_prk            in number, -- % вiд суми для ЩОМIС. комiсiї
                          p_metr90         in number, -- код метода начисления комисии
                          p_dat4_corrected in date, -- скорректированая дата завершения договора
                          p_8_acc          out number, -- счет 8-го класса (acc)
                          p_ss_nls         out varchar2, -- ссудный счет SS (nls)
                          p_ss_acc         out number, -- ссудный счет SS (acc)
                          p_sn_nls         out varchar2, -- счет начисленных процентов SN (nls)
                          p_sn_acc         out number, -- счет начисленных процентов SN (acc)
                          p_sg_nls         out varchar2, -- счет гашения SG (nls)
                          p_sg_acc         out number, -- счет гашения SG (acc)
                          p_sk0_nls        out varchar2, -- счет комисии SK0 (nls)
                          p_sk0_acc        out number, -- счет комисии SK0 (acc)
                          p_sdi_nls        out varchar2, -- счет дисконта SDI (nls)
                          p_sdi_acc        out number -- счет дисконта SDI (acc)
                          ) is
    l_proc_name varchar2(40) := 'accounts_open. ';

    l_acrb number; -- счет доходов(расх) и др.
    l_kv   number;
    l_is_employee number := wcs_utl.get_answ_refer_text(p_bid_id,'WORKER_BANK');
    l_is_base_rate number := wcs_utl.get_answ_bool(p_bid_id,'BASE_RATES');
  begin
    bars_audit.trace(g_pack_name || l_proc_name ||
                     'Start. Params: p_bid_id=%s, p_subproduct_id=%s, p_prk=%s, p_metr90=%s, p_dat4_corrected=%s',
                     to_char(p_bid_id),
                     p_subproduct_id,
                     to_char(p_prk),
                     to_char(p_metr90),
                     to_char(p_dat4_corrected));

    -- счет 8-го класса
    select a.acc
      into p_8_acc
      from accounts a
     where a.nls like '8999_' || p_bid_id;

    bars_audit.trace(g_pack_name || l_proc_name ||
                     'Proccess. Params: p_8_acc=%s',
                     to_char(p_8_acc));

    -- ссудный счет SS
    p_ss_nls := substr(cck.nls0(p_bid_id, 'SS '), 1, 15);
    cck.cc_op_nls(p_bid_id,
                  l_kv,
                  p_ss_nls,
                  'SS ',
                  gl.aUID,
                  g_grp,
                  '1',
                  p_dat4_corrected,
                  p_ss_acc);

    bars_audit.trace(g_pack_name || l_proc_name ||
                     'Proccess. Params: p_ss_nls=%s, p_ss_acc=%s',
                     p_ss_nls,
                     to_char(p_ss_acc));

    -- счет начисленных процентов
    p_sn_nls := substr(cck.nls0(p_bid_id, 'SN '), 1, 15);
    cck.cc_op_nls(p_bid_id,
                  l_kv,
                  p_sn_nls,
                  'SN ',
                  gl.aUID,
                  g_grp,
                  null,
                  p_dat4_corrected,
                  p_sn_acc);

    bars_audit.trace(g_pack_name || l_proc_name ||
                     'Proccess. Params: p_sn_nls=%s, p_sn_acc=%s',
                     p_sn_nls,
                     to_char(p_sn_acc));

    update int_accn ia
       set ia.acrb = l_acrb
     where ia.acc = p_ss_acc
       and ia.id = 0;

    insert into nd_acc (nd, acc) values (p_bid_id, l_acrb);

    bars_audit.trace(g_pack_name || l_proc_name ||
                     'Proccess. Params: l_acrb=%s',
                     to_char(l_acrb));

    -- счет гашения
    p_sg_nls := substr(f_newnls2(p_8_acc, 'SG ', null, null, null), 1, 15);
    cck.cc_op_nls(p_bid_id,
                  l_kv,
                  p_sg_nls,
                  'SG ',
                  gl.aUID,
                  g_grp,
                  '1',
                  p_dat4_corrected,
                  p_sg_acc);

    bars_audit.trace(g_pack_name || l_proc_name ||
                     'Proccess. Params: p_sg_nls=%s, p_sg_acc=%s',
                     p_sg_nls,
                     to_char(p_sg_acc));

    -- комиссия ежемесячная
    p_sk0_nls := substr(f_newnls2(p_8_acc, 'SK0', null, null, null), 1, 15);
    cck.cc_op_nls(p_bid_id,
                  l_kv,
                  p_sk0_nls,
                  'SK0',
                  gl.auid,
                  g_grp,
                  '1',
                  p_dat4_corrected,
                  p_sk0_acc);

    bars_audit.trace(g_pack_name || l_proc_name ||
                     'Proccess. Params: p_sk0_nls=%s, p_sk0_acc=%s',
                     p_sk0_nls,
                     to_char(p_sk0_acc));

    bars_audit.trace(g_pack_name || l_proc_name ||
                     'Proccess. Params: l_acrb=%s',
                     to_char(l_acrb));

    update int_accn ia
       set ia.metr = p_metr90, ia.acrb = l_acrb, ia.acr_dat = null
     where ia.acc = p_8_acc
       and ia.id = 2;

    if l_is_employee = 1 and l_is_base_rate = 1 then
      insert into int_ratn(acc, id, bdat, br)
      values(p_8_acc, 2, gl.bdate, 9999);
    else
      insert into int_ratn(acc, id, bdat, ir)
      values(p_8_acc, 2, gl.bdate, p_prk);
    end if;

    -- SDI Дисконт
    p_sdi_nls := substr(f_newnls2(p_8_acc, 'SDI', null, null, null), 1, 15);
    cck.cc_op_nls(p_bid_id,
                  l_kv,
                  p_sdi_nls,
                  'SDI',
                  gl.auid,
                  g_grp,
                  '1',
                  p_dat4_corrected,
                  p_sdi_acc);

    bars_audit.trace(g_pack_name || l_proc_name ||
                     'Finish. Params: p_sdi_nls=%s, p_sdi_acc=%s',
                     p_sdi_nls,
                     to_char(p_sdi_acc));

  end accounts_open;

  -- Процедура возвращает Пользователя и бранч на котором зарегистрирован кредит (при отсутствии заявка)
  procedure get_branch_user(p_bid_id  in number,
                            p_branch  in varchar2,
                            p_user_id in varchar2,
                            l_branch  out varchar2,
                            l_user_id out varchar2) is
  begin
    if p_branch is null or p_user_id is null then
      begin
        select user_id, branch
          into l_USER_ID, l_branch
          from cc_deal
         where nd = p_bid_id;
      exception
        when no_data_found then
          select mgr_id, branch
            into l_USER_ID, l_branch
            from wcs_bids b
           where b.id = p_bid_id;
      end;
    end if;

    l_branch := nvl(p_branch, l_branch);

    if length(l_branch) < 8 then
      raise_application_error(-20331,
                              'Закріплення кредитного договору не за філією та користувачем  №' ||
                              l_USER_ID || ' заборонено!',
                              true);
    elsif length(l_branch) = 8 then
      l_branch := l_branch || '000000/';
    end if;

    l_user_id := nvl(p_user_id, l_user_id);
  end;

  -- Поиск клиента в уже зарегистрированных (null если не найден)
  function get_client_rnk(p_bid_id    in v_wcs_bids.bid_id%type, -- идентификатор заявки
                          p_ws_id     in wcs_answers.ws_id%type default wcs_utl.g_cur_ws_id, -- Идентификатор рабочего пространства
                          p_ws_number in wcs_answers.ws_number%type default wcs_utl.g_cur_ws_num -- Номер рабочего пространства
                          ) return customer.rnk%type is
    l_okpo varchar2(10) := wcs_utl.get_answ(p_bid_id,
                                            'CODE_002',
                                            p_ws_id,
                                            p_ws_number); -- Ідентифікаційний код клієнта
    l_f    varchar2(45) := wcs_utl.get_answ(p_bid_id,
                                            'CL_1',
                                            p_ws_id,
                                            p_ws_number); -- Прізвище
    l_i    varchar2(40) := wcs_utl.get_answ(p_bid_id,
                                            'CL_2',
                                            p_ws_id,
                                            p_ws_number); -- Ім’я
    l_o    varchar2(40) := wcs_utl.get_answ(p_bid_id,
                                            'CL_3',
                                            p_ws_id,
                                            p_ws_number); -- По батькові
    l_fio  varchar2(125) := l_f || ' ' || l_i || ' ' || l_o; -- ФИО
    l_bdat date := to_date(wcs_utl.get_answ(p_bid_id,
                                            'CL_4',
                                            p_ws_id,
                                            p_ws_number)); -- Дата народження

    l_rnk customer.rnk%type := null;
  begin
    -- пытаемся получить РНК контрагента (или поручителя)
    if (p_ws_id = 'MAIN') then
      select b.rnk into l_rnk from wcs_bids b where b.id = p_bid_id;
    else
      l_rnk := to_number(wcs_utl.get_answ(p_bid_id,
                                          'CL_RNK',
                                          p_ws_id,
                                          p_ws_number));
    end if;

    if (l_rnk is not null) then
      return l_rnk;
    end if;

    -- Ищем по ИНН
    select max(rnk)
      into l_rnk
      from (select rnk
              from customer
             where okpo = l_okpo
               and custtype = 3
               and okpo != '0000000000'
             order by date_off nulls first)
     where rownum = 1;

    if (l_rnk is not null) then
      return l_rnk;
    end if;

    -- Ищем по Фио и дате рожд.
    select max(rnk)
      into l_rnk
      from (select p.rnk
              from customer c, person p
             where upper(translate(c.nmk, '1 ', '1')) =
                   upper(translate(l_fio, '1 ', '1'))
               and c.custtype = 3
               and p.bday = l_bdat
               and p.rnk = c.rnk
             order by date_off nulls first, p.rnk desc)
     where rownum = 1;

    if (l_rnk is not null) then
      return l_rnk;
    end if;

    return null;
  end get_client_rnk;

  -- Регистрация контрагента
  function register_client(p_bid_id    in v_wcs_bids.bid_id%type, -- идентификатор заявки
                           p_ws_id     in wcs_answers.ws_id%type default wcs_utl.g_cur_ws_id, -- Идентификатор рабочего пространства
                           p_ws_number in wcs_answers.ws_number%type default wcs_utl.g_cur_ws_num -- Номер рабочего пространства
                           ) return customer.rnk%type is
    l_proc_name varchar2(40) := 'register_client. ';

    l_type_kl number := 3;
    l_rnk     customer.rnk%type;

    -- Особиста інформація про клієнта
    l_f                  varchar2(45) := wcs_utl.get_answ(p_bid_id,
                                                          'CL_1',
                                                          p_ws_id,
                                                          p_ws_number); -- Прізвище
    l_i                  varchar2(40) := wcs_utl.get_answ(p_bid_id,
                                                          'CL_2',
                                                          p_ws_id,
                                                          p_ws_number); -- Ім’я
    l_o                  varchar2(40) := wcs_utl.get_answ(p_bid_id,
                                                          'CL_3',
                                                          p_ws_id,
                                                          p_ws_number); -- По батькові
    l_fio                varchar2(125) := l_f || ' ' || l_i || ' ' || l_o; -- ФИО
    l_fio_k              varchar2(37) := substr((l_f || substr(l_i, 1, 1) || '.' ||
                                                substr(l_o, 1, 1) || '.'),
                                                1,
                                                38); -- Фио краткое
    l_fio_r              varchar2(125) := wcs_utl.get_answ(p_bid_id,
                                                          'CL_123_R',
                                                          p_ws_id,
                                                          p_ws_number); -- ПІБ у родовому відмінку
    l_sex                number := to_number(wcs_utl.get_answ(p_bid_id,
                                                              'CL_71',
                                                              p_ws_id,
                                                              p_ws_number)); -- Стать
    l_rez                number := to_number(wcs_utl.get_answ(p_bid_id,
                                                              'CL_63',
                                                              p_ws_id,
                                                              p_ws_number)); -- Резидент
    l_rez_kl number := (case
                         when l_type_kl = 2 and l_rez = 1 then
                          3
                         when l_type_kl = 2 and l_rez = 0 then
                          4
                         when l_type_kl = 3 and l_rez = 1 then
                          5
                         when l_type_kl = 3 and l_rez = 0 then
                          6
                         else
                          null
                       end);
    l_maiden_name        varchar2(40) := Null; -- Дівоче прізвище (лише для жінок)
    l_mother_maiden_name varchar2(40) := Null; -- Дівоче прізвище матері
    l_bdat               date := to_date(wcs_utl.get_answ(p_bid_id,
                                                          'CL_4',
                                                          p_ws_id,
                                                          p_ws_number)); -- Дата народження
    l_bplace             varchar2(70) := substr(wcs_utl.get_answ(p_bid_id,
                                                                 'CL_4_0',
                                                                 p_ws_id,
                                                                 p_ws_number),
                                                1,
                                                70); -- Місце народження
    l_okpo               varchar2(10) := wcs_utl.get_answ(p_bid_id,
                                                          'CODE_002',
                                                          p_ws_id,
                                                          p_ws_number); -- Ідентифікаційний код клієнта
    l_tel_prime          varchar2(20) := wcs_utl.get_answ(p_bid_id,
                                                          'CL_199',
                                                          p_ws_id,
                                                          p_ws_number); -- Контактний телефон
    l_has_tel_mob        varchar2(20) := to_number(wcs_utl.get_answ(p_bid_id,
                                                                    'CL_0_3',
                                                                    p_ws_id,
                                                                    p_ws_number)); -- Мобільний телефон
    l_tel_mob            varchar2(20) := wcs_utl.get_answ(p_bid_id,
                                                          'CL_0_4',
                                                          p_ws_id,
                                                          p_ws_number); -- Номер мобільного телефону
    l_e_mail             varchar2(45) := wcs_utl.get_answ(p_bid_id,
                                                          'CL_0_5',
                                                          p_ws_id,
                                                          p_ws_number); -- Електронна пошта

    -- Документи
    l_doc_ser   varchar2(2) := wcs_utl.get_answ(p_bid_id,
                                                'CL_7',
                                                p_ws_id,
                                                p_ws_number); -- Серія паспорту
    l_doc_num   varchar2(6) := wcs_utl.get_answ(p_bid_id,
                                                'CL_8',
                                                p_ws_id,
                                                p_ws_number); -- Номер паспорту
    l_doc_organ varchar2(120) := wcs_utl.get_answ(p_bid_id,
                                                  'CL_9',
                                                  p_ws_id,
                                                  p_ws_number) || '  ' ||
                                 wcs_utl.get_answ(p_bid_id,
                                                  'CL_10',
                                                  p_ws_id,
                                                  p_ws_number); -- Орган, що видав паспорт (і ДЕ)
    l_doc_dat   date := to_date(wcs_utl.get_answ(p_bid_id,
                                                 'CL_11',
                                                 p_ws_id,
                                                 p_ws_number)); -- Дата видачі паспорту

    -- Адреса проживання
    l_reg_live     varchar2(45) := wcs_utl.get_answ_refer_text(p_bid_id,
                                                               'CL_13',
                                                               p_ws_id,
                                                               p_ws_number); -- Область
    l_dst_live     varchar2(45) := wcs_utl.get_answ(p_bid_id,
                                                    'CL_14',
                                                    p_ws_id,
                                                    p_ws_number); -- Район
    l_twn_live     varchar2(45) := wcs_utl.get_answ(p_bid_id,
                                                    'CL_15',
                                                    p_ws_id,
                                                    p_ws_number); -- Місто/Населений пункт
    l_str_live     varchar2(100) := wcs_utl.get_answ(p_bid_id,
                                                    'CL_16',
                                                    p_ws_id,
                                                    p_ws_number); -- Вулиця, дім, квартира
    l_status_live  varchar2(255) := wcs_utl.get_answ_list_text(p_bid_id,
                                                               'CL_0_147',
                                                               p_ws_id,
                                                               p_ws_number); -- Статус місця проживання
    l_idx_live     varchar2(5) := wcs_utl.get_answ(p_bid_id,
                                                   'CL_12',
                                                   p_ws_id,
                                                   p_ws_number); -- Поштовий індекс
    l_has_tel_home varchar2(20) := wcs_utl.get_answ(p_bid_id,
                                                    'CL_0_6',
                                                    p_ws_id,
                                                    p_ws_number); -- Домашній телефон
    l_tel_home     varchar2(20) := wcs_utl.get_answ(p_bid_id,
                                                    'CL_23',
                                                    p_ws_id,
                                                    p_ws_number); -- Телефон за місцем проживання

    l_adr_live      varchar2(70) := l_str_live; -- улица дом квартира
    l_full_adr_live varchar2(170) := wcs_register.concat_strings(l_reg_live,
                                                                 l_dst_live,
                                                                 l_twn_live,
                                                                 l_str_live); -- полный адрес

    -- Адреса реєстрації
    l_adr_reg_like_live number := to_number(wcs_utl.get_answ(p_bid_id,
                                                             'CL_0_188',
                                                             p_ws_id,
                                                             p_ws_number)); -- Адреси місця проживання і реєстрації співпадають?
    l_reg_reg varchar2(45) := case
                                when l_adr_reg_like_live = 1 then
                                 l_reg_live
                                else
                                 wcs_utl.get_answ_refer_text(p_bid_id,
                                                             'CL_18',
                                                             p_ws_id,
                                                             p_ws_number)
                              end; --  Область
    l_dst_reg varchar2(45) := case
                                when l_adr_reg_like_live = 1 then
                                 l_dst_live
                                else
                                 wcs_utl.get_answ(p_bid_id,
                                                  'CL_19',
                                                  p_ws_id,
                                                  p_ws_number)
                              end; --  Район
    l_twn_reg varchar2(45) := case
                                when l_adr_reg_like_live = 1 then
                                 l_twn_live
                                else
                                 wcs_utl.get_answ(p_bid_id,
                                                  'CL_20',
                                                  p_ws_id,
                                                  p_ws_number)
                              end; --  Місто/Населений пункт
    l_str_reg varchar2(100) := case
                                when l_adr_reg_like_live = 1 then
                                 l_str_live
                                else
                                 wcs_utl.get_answ(p_bid_id,
                                                  'CL_21',
                                                  p_ws_id,
                                                  p_ws_number)
                              end; --  Вулиця, дім, квартира
    l_idx_reg varchar2(5) := case
                               when l_adr_reg_like_live = 1 then
                                l_idx_live
                               else
                                wcs_utl.get_answ(p_bid_id,
                                                 'CL_17',
                                                 p_ws_id,
                                                 p_ws_number)
                             end; --  Поштовий індекс місця реєстрації
    l_adr_reg           varchar2(100) := l_str_reg; -- улица дом квартира
    l_full_adr_reg      varchar2(170) := wcs_register.concat_strings(l_reg_reg,
                                                                     l_dst_reg,
                                                                     l_twn_reg,
                                                                     l_str_reg); -- полный адрес

    -- Скоринг
    l_s         number := to_number(wcs_utl.get_answ(p_bid_id,
                                                     'S',
                                                     p_ws_id,
                                                     p_ws_number)); -- Cума балів оцінки показників, яку отримав позичальник
    l_cr        number := to_number(wcs_utl.get_answ(p_bid_id,
                                                     'CR',
                                                     p_ws_id,
                                                     p_ws_number)); -- Значення кредитного ризику
    l_crisk_obu varchar2(255) := wcs_utl.get_answ_list_text(p_bid_id,
                                                            'CRISK_OBU',
                                                            p_ws_id,
                                                            p_ws_number); -- Внутрішній кредитний рейтинг Позичальника
    l_crisk_nbu varchar2(255) := wcs_utl.get_answ_list_text(p_bid_id,
                                                            'CRISK_NBU',
                                                            p_ws_id,
                                                            p_ws_number); -- Клас Позичальника (відповідно до класифікації НБУ)
    l_crisk     customer.crisk%type := to_number(wcs_utl.get_answ(p_bid_id,
                                                                  'CRISK_NBU',
                                                                  p_ws_id,
                                                                  p_ws_number)) + 1; -- Код класа позичальника

    -- Экономические нормативы
    l_sed customer.sed%type := case
                                 when l_type_kl = 3 then
                                  '00  '
                                 else
                                  null
                               end;

    -- Другое
    l_prinsider customer.prinsider%type := case
                                             when wcs_utl.get_answ(p_bid_id,
                                                                   'CL_0_109',
                                                                   p_ws_id,
                                                                   p_ws_number) = 1 then
                                              1
                                             when wcs_utl.get_answ(p_bid_id,
                                                                   'CL_0_110',
                                                                   p_ws_id,
                                                                   p_ws_number) = 1 then
                                              1
                                             when wcs_utl.get_answ(p_bid_id,
                                                                   'CL_0_111',
                                                                   p_ws_id,
                                                                   p_ws_number) = 1 then
                                              1
                                             when wcs_utl.get_answ(p_bid_id,
                                                                   'CL_0_112',
                                                                   p_ws_id,
                                                                   p_ws_number) = 1 then
                                              1
                                             else
                                              99
                                           end;

    l_ved varchar2(5); -- Вид экономической деятельности

  begin

    bars_audit.trace(g_pack_name || l_proc_name ||
                     'Start. Params: p_bid_id=%s',
                     to_char(p_bid_id));

    -- Определение вида экономической деятельности
    begin
      select val into l_ved from params where par = 'CUSTK110';
    exception when no_data_found then
      l_ved := '00000';
    end;

    -- ищем клиента в уже зарегистрированных
    l_rnk := get_client_rnk(p_bid_id, p_ws_id, p_ws_number);

    -- обновляем клиента если он закрыт
    update customer c
       set c.date_off = null
     where c.rnk = l_rnk
       and c.date_off is not null;

    -- регистрируем основные реквизиты контрагента
    kl.setcustomerattr(rnk_       => l_rnk, -- Customer number
                       custtype_  => l_type_kl, -- Тип клиента: 1-банк, 2-юр.лицо, 3-физ.лицо
                       nd_        => null, -- № договора
                       nmk_       => l_fio, -- Наименование клиента
                       nmkv_      => substr(l_fio, 1, 70), -- Наименование клиента международное
                       nmkk_      => l_fio_k, -- Наименование клиента краткое
                       adr_       => substr(l_full_adr_reg, 1, 70), -- Адрес клиента
                       codcagent_ => l_rez_kl, -- Характеристика (5-Физическое лицо-резидент)
                       country_   => 804, -- Страна (804 - Украина)
                       prinsider_ => l_prinsider, -- Признак инсайдера (0-Не належить до _нсайдер_в)
                       tgr_       => 2, -- Тип гос.реестра (2-Реєстр ДРФО (фiз.осiб))
                       okpo_      => l_okpo, -- ОКПО
                       stmt_      => 0, -- Формат выписки (0-Не используется)
                       sab_       => null, -- Эл.код
                       dateon_    => gl.bdate, -- Дата регистрации
                       taxf_      => null, -- Налоговый код
                       creg_      => null, -- Код обл.НИ
                       cdst_      => null, -- Код район.НИ
                       adm_       => null, -- Админ.орган
                       rgtax_     => null, -- Рег номер в НИ
                       rgadm_     => null, -- Рег номер в Адм.
                       datet_     => null, -- Дата рег в НИ
                       datea_     => null, -- Дата рег. в администрации
                       ise_       => null, -- Инст. сек. экономики
                       fs_        => null, -- Форма собственности
                       oe_        => null, -- Отрасль экономики
                       ved_       => l_ved, -- Вид эк. деятельности
                       sed_       => l_sed, -- Форма хозяйствования
                       notes_     => null, -- Примечание
                       notesec_   => null, -- Примечание для службы безопасности
                       crisk_     => l_crisk, -- Категория риска
                       pincode_   => null, --
                       rnkp_      => null, -- Рег. номер холдинга
                       lim_       => null, -- Лимит кассы
                       nompdv_    => null, -- № в реестре плат. ПДВ
                       mb_        => null, -- Принадл. малому бизнесу
                       bc_        => 0, -- Признак НЕклиента банка
                       tobo_      => sys_context('bars_context',
                                                 'user_branch'), -- Код безбалансового отделения
                       isp_       => user_id -- Менеджер клиента (ответ. исполнитель)
                       );

    -- регистрируем разширеный адрес в доп реквизитах
    KL.setCustomerElement(l_rnk, 'FGIDX', l_idx_reg, 0);
    KL.setCustomerElement(l_rnk, 'FGOBL', l_reg_reg, 0);
    KL.setCustomerElement(l_rnk, 'FGDST', l_dst_reg, 0);
    KL.setCustomerElement(l_rnk, 'FGTWN', l_twn_reg, 0);
    KL.setCustomerElement(l_rnk, 'FGADR', l_adr_reg, 0);

    -- регистрируем разширеный адрес в таблице доп адресов (если она есть)
    -- 1 - Адреса реєстрації, 2 - Адреса проживання

    kl.setcustomeraddress(l_rnk,
                          1,
                          804,
                          l_idx_reg,
                          l_reg_reg,
                          l_dst_reg,
                          l_twn_reg,
                          l_adr_reg);
    kl.setcustomeraddress(l_rnk,
                          2,
                          804,
                          l_idx_live,
                          l_reg_live,
                          l_dst_live,
                          l_twn_live,
                          l_adr_live);

    -- регистрируем реквизиты контрагента физ. лица
    kl.setpersonattr(l_rnk,
                     l_sex, -- пол (+1 для приведения с справочнику БАРСа)
                     1, -- документ паспорт
                     l_doc_ser, -- Серия паспорта
                     l_doc_num, -- Номер паспорта
                     l_doc_dat, -- Дата выдачи паспорта
                     l_doc_organ, -- Кем выдан паспорт
                     l_bdat, -- Дата рождения
                     null, -- место рождения
                     l_tel_prime, -- Контактный телефон
                     l_tel_home -- Дополнительный телефон
                     );

    -- =========================
    -- Допреквизиты контрагента

    -- DATZ - Дата заповнення анкети
    kl.setCustomerElement(l_rnk, 'DATZ', to_char(sysdate, 'dd/mm/yyyy'), 0);
    -- MPNO - Номер мобільного телефону
    if (l_has_tel_mob = 1) then
      kl.setCustomerElement(l_rnk, 'MPNO', l_tel_mob, 0);
    end if;
    -- EMAIL - Адреса електронної пошти
    kl.setCustomerElement(l_rnk, 'EMAIL', l_e_mail, 0);
    -- MN - Дівоче прізвище (лише для жінок)
    if (l_sex = 1) then
      kl.setCustomerElement(l_rnk, 'MN', l_maiden_name, 0);
    end if;
    -- MMN - Девичья фамилия матери клиента
    kl.setCustomerElement(l_rnk, 'MMN', l_mother_maiden_name, 0);
    -- SN_GC - ПІБ клієнта в родовому відмінку
    kl.setCustomerElement(l_rnk, 'SN_GC', l_fio_r, 0);

    -- Специфические допреквизиты контрагента для заказчика
    -- !!!! Добавить при необходимости

    bars_audit.trace(g_pack_name || l_proc_name || 'Finish.  RNK=' ||
                     to_char(l_rnk));
    return l_rnk;
  end register_client;

  -- Регистрация доп платежей
  procedure reg_servise_app_pay_client(p_bid_id in number -- идентификатор заявки
                                       ) is

    l_sum number(20, 2);
  begin
    /*
        SV0K1    Разова комiсiя, %
        SV1RK    Розр-Кас.Обсл., %
      + SV2PW    Страх.застави, щорiчно, %
        SV3CV    Страх.життя, щорiчно, %
        SV4TI    Страх.титулу, щорiчно(3 р), %
        SV5GO    Страх.цив.вiдпов, грн
      + SV6NO    Послуги нотарiуса, грн
        SV7RE    Послуги реєстрат., грн
        SV8MI    Державне мито, % вiд застави
        SV9PF    Пенсiйн.фонд, % вiд застави
      + SV:BT    Послуги БТI(МРЕО), грн
    */
    -- послугами оцінювачів заставного майна
    l_sum := nvl(to_number2(wcs_utl.get_answ(p_bid_id, 'CL_0_113')), 0);

    CCK_APP.SET_ND_TXT(p_bid_id, 'SV7RE', l_sum);

    -- страхуванням - Сплата страхових платежів - в день видачі кредиту за  перший рік
    l_sum := nvl(to_number2(wcs_utl.get_answ(p_bid_id, 'CL_0_121')), 0) +
             nvl(to_number2(wcs_utl.get_answ(p_bid_id, 'CL_0_122')), 0) +
             nvl(to_number2(wcs_utl.get_answ(p_bid_id, 'CL_0_123')), 0) +
             nvl(to_number2(wcs_utl.get_answ(p_bid_id, 'CL_0_124')), 0) +
             nvl(to_number2(wcs_utl.get_answ(p_bid_id, 'CL_0_125')), 0) +
             nvl(to_number2(wcs_utl.get_answ(p_bid_id, 'CL_0_126')), 0);

    CCK_APP.SET_ND_TXT(p_bid_id, 'SV2PW', l_sum);
    -- послугами нотаріусів - одноразово

    l_sum := /*nvl(to_number2(wcs_utl.get_answ(p_bid_id, 'CL_0_114')), 0) +
             nvl(to_number2(wcs_utl.get_answ(p_bid_id, 'CL_0_115')), 0) +
             nvl(to_number2(wcs_utl.get_answ(p_bid_id, 'CL_0_116')), 0) +
             nvl(to_number2(wcs_utl.get_answ(p_bid_id, 'CL_0_117')), 0) +
             nvl(to_number2(wcs_utl.get_answ(p_bid_id, 'CL_0_118')), 0) +
             nvl(to_number2(wcs_utl.get_answ(p_bid_id, 'CL_0_119')), 0)*/
             nvl(to_number2(wcs_utl.get_answ(p_bid_id, 'CL_0_260')), 0);

    CCK_APP.SET_ND_TXT(p_bid_id, 'SV6NO', l_sum);

    -- інші платежі

    l_sum := nvl(to_number2(wcs_utl.get_answ(p_bid_id, 'CL_0_120')), 0) +
             nvl(to_number2(wcs_utl.get_answ(p_bid_id, 'CL_0_128')), 0) +
             nvl(to_number2(wcs_utl.get_answ(p_bid_id, 'CL_0_129')), 0);

    CCK_APP.SET_ND_TXT(p_bid_id, 'SV:BT', l_sum);

    null;

  end;

  -- Регистрация кредитной сделки
  procedure register_deal(p_bid_id    in number, -- идентификатор заявки
                          p_rnk       in number, -- идентификатор клиента
                          p_ws_id     in wcs_answers.ws_id%type default wcs_utl.g_cur_ws_id, -- Идентификатор рабочего пространства
                          p_ws_number in wcs_answers.ws_number%type default wcs_utl.g_cur_ws_num, -- Номер рабочего пространства
                          p_branch    in varchar2 default null, -- Бранч
                          p_user_id   in varchar2 default null -- Staff
                          ) is

    l_proc_name varchar2(40) := 'register_deal. ';

    l_USER_ID int; -- Реф пользователя
    l_BRANCH  varchar2(50); -- BRANCH (инициатор)  nd_txt.INIC

    -- основные идентификаторы
    l_nd            int := p_bid_id;
    l_subproduct_id varchar2(100); -- идентификатор субпродукта
    l_ob22          varchar2(6);
    l_prod          varchar2(20);
    l_cc_id         varchar2(50) := wcs_utl.get_creditdata(p_bid_id,
                                                           'DEAL_NUMBER'); -- внешний номер договора
    l_Dat1          DATE; -- Дата заключения
    l_Dat4          DATE; -- Дата окончания КД
    l_term          int; -- Термин КД
    l_lcv           tabval.lcv%type; -- Символьный код валюты
    l_kv            tabval.kv%type; -- Числовой код валюты
    l_S             number; -- Сума КД  (с коп-ми)
    l_VIDD          int; -- Вид договора (1,2,3 - ЮЛ , 11,12,13 - ФЛ)
    l_SOUR          int; -- Источник валютной выручки
    l_AIM           int; -- Цель кредитования
    l_S260          varchar2(2); -- Галузь (S260)
    l_crisk         customer.crisk%type := to_number(wcs_utl.get_answ(p_bid_id,
                                                                      'CRISK_NBU',
                                                                      p_ws_id,
                                                                      p_ws_number)) + 1; -- Код класа позичальника
    l_OBS           int; -- Обслуживание долга
    l_ir            number := null; -- Процентная ставка
    l_br            int := null; -- Базовая процентная ставка
    l_Basey         int; -- База начисления
    l_method        int; -- проценты к уплате (1 - месяц)
    l_acc8          varchar2(15);

    l_FREQ          int; -- Периодичность начисления по телу
    l_pay_day       int; -- День погашения
    l_first_pay_dat date; -- Первая дата погашения тела

    l_FREQI int; -- Периодичность начисления %
    l_DenI  int; -- День погашения %
    l_DATfI date; -- Первая дата погашения %

    l_RANG     int; -- Шаблон погашения
    l_Holidays int; -- каникулы
    --   l_method        int;           -- способ начисления процентов

    type_gpk number; -- Тип графика погашения
    l_RTERM  number; -- Строк погашення чергового траншу по кредитній лінії (міс)

    -- Комиссионные доходы

    l_SDI      number; -- Сумма дисконта,
    l_KOM      int; -- Тип комиссии
    l_KOM_IR   number; -- % ставка ежем-ной комис или сума в завис от метода
    l_KOM_DATF DATE; -- Дата первого начисления
    l_KOM_DATE DATE; -- Дата окончания начисления
    l_KOM_KV   int; -- Вал.сч.для деб-кой зад-ти (3578) за ежем-ную ком НЕИСПОЛЬЗУЕТСЯ
    l_CR9_KV   int; -- Вал.сч.для деб-кой зад-ти (3578) за неисп лимит
    l_CR9_IR   int; -- % ставка за неисп лимит
    l_CR9_I    int; -- % 0- возобн , 1- не возобн-мая Кред-ная линия
    l_SN8_IR   int; -- % ставка пени
    l_SN8_KV   int; -- % валюта пени
    l_SK4_IR   int; -- % ставка за досрочное погашение

    l_pmt_instr t_pmt_instr; -- Платежные инструкции для перечисления кредитных средств
    l_is_standart number := 0;

    l_is_employee number := nvl(to_number(wcs_utl.get_answ_refer(p_bid_id,'WORKER_BANK')),0);
    l_is_base_rate number := nvl(wcs_utl.get_answ_bool(p_bid_id,'BASE_RATES'),0);

  begin

    bars_audit.info(g_pack_name || l_proc_name ||
                    'Start. Params: p_bid_id=' || to_char(p_bid_id));

    WCS_REGISTER.GET_BRANCH_USER(p_bid_id,
                                 p_branch,
                                 p_user_id,
                                 l_branch,
                                 l_user_id);
    bars_audit.info(g_pack_name || l_proc_name || ' l_branch=' || l_branch ||
                    ' p_user_id=' || p_user_id);

    -- идентификатор субпродукта
    select b.subproduct_id
      into l_subproduct_id
      from wcs_bids b
     where b.id = p_bid_id;

    bars_audit.trace(g_pack_name || l_proc_name ||
                     'Proccess. Params: l_subproduct_id=%s',
                     l_subproduct_id);

    -- срок кредита
    l_term := to_number(wcs_utl.get_creditdata(p_bid_id, 'CREDIT_TERM'));

    begin
      select 1 into l_is_standart from wcs_bids where id = p_bid_id and regexp_like(subproduct_id,'NONSTANDARD');
    exception
      when no_data_found then
        l_is_standart := 0;
    end;
    -- ОБ22 из настроек субпродукта
    if l_is_standart = 0 then
      if (l_term <= 12) then
        l_ob22 := wcs_utl.get_mac(p_bid_id, 'MAC_OB22_SHORT');
      else
        l_ob22 := wcs_utl.get_mac(p_bid_id, 'MAC_OB22_LONG');
      end if;
    elsif l_is_standart = 1 then
      l_ob22 := wcs_utl.get_answ_refer(p_bid_id,'OB22');
    end if;

    begin
      -- в зависимости от срока кредита берем разные маки ОБ22
      select id into l_prod from cc_potra where id = l_ob22;
    exception
      when no_data_found then
        raise_application_error(-20331,
                                'У кредитному продукті ' || l_subproduct_id ||
                                ' зазначен невірний бухгалтерський продукт (OB22)=' ||
                                substr(wcs_utl.get_mac(p_bid_id, 'MAC_OB22'),
                                       1,
                                       6),
                                true);
    end;

    --------------------------------------------------------------------------------
    -- l_Dat1          DATE,    -- Дата заключения
    -- l_Dat4          DATE,    -- Дата окончания КД
    -- l_Den           int,    -- День погашения
    -- l_DATf         date,    -- Первая дата погашения тела

    -- дата сделки вводится менеджером после согласования с клиент
    l_dat1 := to_date(wcs_utl.get_creditdata(p_bid_id, 'DEAL_DATE'));
    l_dat1 := cck.CorrectDate(gl.baseVal, l_dat1, l_dat1 + 1);

    -- платежный день и дата
    l_pay_day       := to_number(wcs_utl.get_creditdata(p_bid_id,
                                                        'REPAYMENT_DAY'));
    l_first_pay_dat := add_months(to_date('01' || to_char(l_dat1, 'mmyyyy'),
                                          'ddmmyyyy') + l_pay_day - 1,
                                  1);

    /* корректировка дат для ануитета
    -- 19.03.2010(4) Sta
    If l_first_pay_dat < gl.BDATE then
      l_first_pay_dat := add_months(l_first_pay_dat, 2);
    else
      l_first_pay_dat := add_months(l_first_pay_dat, 1);
    end if;
    If months_between(l_first_pay_dat, gl.bdate) > 1.5 OR
       l_first_pay_dat - gl.bdate > 45 then
      l_first_pay_dat := add_months(l_first_pay_dat, -1);
    end if;
    */

    -- завершения договора
    l_dat4 := add_months(l_dat1, l_term);
    --l_dat4 := cck.CorrectDate(gl.baseVal, l_dat4, l_dat4 - 1);

    --------------------------------------------------------------------------------
    l_lcv := wcs_utl.get_creditdata(p_bid_id, 'CREDIT_CURRENCY');
    select t.kv into l_kv from tabval t where t.lcv = l_lcv;

    --------------------------------------------------------------------------------
    l_s := to_number2(wcs_utl.get_creditdata(p_bid_id, 'CREDIT_SUM'));

    --------------------------------------------------------------------------------
    -- l_VIDD          int,    -- Вид договора (1,2,3 - ЮЛ , 11,12,13 - ФЛ)
    if l_is_standart = 0 then
      l_VIDD := to_number(wcs_utl.get_mac(p_bid_id, 'MAC_CRD_TYPE'));
    else
      l_VIDD := wcs_utl.get_answ_list(p_bid_id,'CRD_TYPE');
    end if;

    if l_VIDD = 0 then
      l_vidd  := 11;
      l_CR9_I := 0;
    elsif l_VIDD = 1 then
      l_vidd  := 12;
      l_CR9_I := 0;
    elsif l_VIDD = 2 then
      l_vidd  := 13;
      l_CR9_I := 0;
    elsif l_VIDD = 3 then
      l_vidd  := 12;
      l_CR9_I := 1;
    elsif l_VIDD = 4 then
      l_vidd  := 13;
      l_CR9_I := 1;
    elsif l_VIDD = 5 then
      l_vidd := 12;
      l_CR9_I := 0;
    end if;

    if l_vidd in (12, 13, 2, 3) then
      l_rterm := to_number(wcs_utl.get_mac(p_bid_id, 'MAC_REPAYMENT_TERM'));
    end if;

    --------------------------------------------------------------------------------
    -- G_SOUR          int,    -- Источник валютной выручки
    --
    --------------------------------------------------------------------------------
    -- l_AIM           int,    -- Цель кредитования
    --найти цель
    select nvl(min(AIM), 62)
      into l_aim
      from cc_aim
     where substr(l_prod, 1, 4) in
           (nvl(NBS,decode(NEWNBS.GET_STATE,0,'2062','2063') ),
            nvl(NBS2, '2063'),
            nvl(NBSF, decode(NEWNBS.GET_STATE,0,'2202','2203')),
            nvl(NBSF2, '2203'))
       and d_close is null
       and rownum = 1;

    --------------------------------------------------------------------------------
    --l_MS_NX    varchar2,    -- Галузь (S260)
    l_S260 := to_number(wcs_utl.get_mac(p_bid_id, 'MAC_S260'));

    --------------------------------------------------------------------------------
    -- l_IR         number,    -- Процентная ставка
    /*if l_is_employee = 1 and l_is_base_rate = 1 then
      l_br := g_BR;
    else*/
    l_ir := to_number2(wcs_utl.get_creditdata(p_bid_id, 'INTEREST_RATE'));
    --end if;

    --------------------------------------------------------------------------------
    -- l_Basey         int,    -- База начисления
    if l_is_standart = 0 then
      l_Basey := to_number(wcs_utl.get_mac(p_bid_id, 'MAC_BASEY'));
    else
      l_Basey := wcs_utl.get_answ_list(p_bid_id,'BASEY');
    end if;

    --------------------------------------------------------------------------------
    --l_FREQ          int,    -- Периодичность начисления по телу
    --G_FREQ

    --------------------------------------------------------------------------------
    -- l_FREQI         int,    -- Периодичность начисления %
    -- l_DenI          int,    -- День погашения %
    -- l_DATfI        date,    -- Первая дата погашения %
    -- Все по умолчанию и береться из гл параметров
    --------------------------------------------------------------------------------

    -- type_gpk
    type_gpk := to_number(wcs_utl.get_creditdata(p_bid_id,
                                                 'REPAYMENT_METHOD'));

    -- l_RANG          int,    -- Шаблон погашения
    begin
      if l_is_standart = 0 then
        l_rang := to_number(wcs_utl.get_mac(p_bid_id,'MAC_PAYMENT_PARSING_SCHEME'));
      else
        l_rang := to_number(wcs_utl.get_answ_list(p_bid_id,'PAYMENT_PARSING_SCHEME'));
      end if;
    exception
      when no_data_found then
        l_rang := GetGlobalOption('CC_RANG');
    end;
    --------------------------------------------------------------------------------
    --l_Holidays      int,    -- каникулы
    if l_is_standart = 0 then
      l_Holidays := to_number(wcs_utl.get_mac(p_bid_id, 'MAC_HOLIDAYS'));
    else
      l_Holidays := wcs_utl.get_answ_list(p_bid_id,'HOLIDAYS');
    end if;
    --------------------------------------------------------------------------------
    --l_method        int,    -- способ начисления процентов
    if type_gpk = 4 then
      l_method := 0;
    else
      l_method := 1;
    end if;

    --raise_application_error (-20331, substr(to_char(l_kv) ||' - '||sqlerrm,1,250),true);

    -- получение платежных инструкций для перечисления средств
    l_pmt_instr := get_payment_instr(p_bid_id);

    -- открытие договора
    cck.cc_open_ext(p_ND         => l_nd, -- Реф кредитного договора (системный)
                    p_RNK        => p_rnk, -- РНК залогозаемщика
                    p_USER_ID    => l_USER_ID, -- Реф пользователя
                    p_BRANCH     => l_branch, -- BRANCH (инициатор)  nd_txt.INIC
                    p_PROD       => l_prod || l_subproduct_id, -- продукт КД
                    p_CC_ID      => l_cc_id, -- № КД (пользовательский)
                    p_Dat1       => l_dat1, -- Дата заключения
                    p_Dat2       => l_dat1, -- Дата начала действия
                    p_Dat3       => l_dat1, -- Дата выдачи (плановая)
                    p_Dat4       => l_dat4, -- Дата окончания КД
                    p_KV         => l_kv, -- Код валюты
                    p_S          => l_s, -- Сума КД  (с коп-ми)
                    p_VIDD       => l_VIDD, -- Вид договора (1,2,3 - ЮЛ , 11,12,13 - ФЛ)
                    p_SOUR       => g_isto, -- Источник валютной выручки
                    p_AIM        => l_aim, -- Цель кредитования
                    p_MS_NX      => l_S260, -- Галузь (S260)
                    p_FIN        => l_crisk, -- Фин стан
                    p_OBS        => g_obs, -- Обслуживание долга
                    p_IR         => l_ir, -- Процентная ставка
                    p_OP         => null, -- тип операции для % ставки
                    p_BR         => l_br, -- Базовая ставка
                    p_Basey      => l_Basey, -- База начисления
                    p_DAT_STP_IR => Null, -- Дата приостановления начисления процентов

                    p_type_gpk => type_gpk, -- Тип погашения (0 - индив 2- равн част 4 ануитет)
                    p_daynp    => g_daynp, -- Кор-ка выходных дней в ГПК

                    p_FREQ => g_freq, -- Периодичность начисления по телу
                    p_Den  => l_pay_day, -- День погашения
                    p_DATf => l_first_pay_dat, -- Первая дата погашения тела

                    p_FREQI => g_freqp, -- Периодичность начисления %
                    p_DenI  => null, -- День погашения %
                    p_DATfI => null, -- Первая дата погашения %

                    p_RANG     => l_rang, -- Шаблон погашения
                    p_Holidays => l_Holidays, -- каникулы
                    p_method   => l_method, -- способ начисления процентов

                    p_MFOKRED  => l_pmt_instr.mfo, -- Платежные инструкции МФО
                    p_NLSKRED  => l_pmt_instr.nls, --     -------//------- счет
                    p_OKPOKRED => l_pmt_instr.okpo, -- ИПН получателя
                    p_NAMKRED  => l_pmt_instr.nam, -- Наименование счета получателя
                    p_NAZNKRED => l_pmt_instr.nazn, -- Назначение платежа

                    p_sAIM      => null, -- цель  кредитного договора (Текст-устаревшее)
                    p_PAWN      => null, -- залог кредитного договора (Текст-устаревшее)
                    ND_EXTERNAL => null -- идентификатор внешней системы (мигрированные КД)
                    );

    bars_audit.info(g_pack_name || l_proc_name || 'Register Commision');
    --------------------------------------------------------------------------------
    --------------------------------------------------------------------------------
    ----------------Сохраняем ком-ные доходы и лимиты-------------------------------
    --------------------------------------------------------------------------------

    -- l_sdi - Сумма дисконта (в грн., прим. 150.00грн)
    l_sdi := nvl(to_number2(wcs_utl.get_creditdata(p_bid_id, 'SINGLE_FEE')),
                 0);

    --l_KOM        int; -- Тип комиссии
    if l_is_standart = 0 then
      l_KOM := to_number(wcs_utl.get_mac(p_bid_id, 'MAC_MONTHLY_FEE_TYPE'));
    else
      l_KOM := to_number(wcs_utl.get_answ_refer(p_bid_id,'MONTHLY_FEE_TYPE'));
    end if;
    --l_KOM_IR  number; -- % ставка ежем-ной комис или сума в завис от метода
    l_KOM_IR := to_number2(wcs_utl.get_creditdata(p_bid_id, 'MONTHLY_FEE'));

    --l_KOM_KV     int; -- Вал.сч.для деб-кой зад-ти (3578) за ежем-ную ком НЕИСПОЛЬЗУЕТСЯ

    --l_CR9_KV     int; -- Вал.сч.для деб-кой зад-ти (3578) за неисп лимит

    --l_CR9_IR     int; -- % ставка за неисп лимит

    --l_CR9_I      int; -- % 0- возобн , 1- не возобн-мая Кред-ная линия

    --l_SN8_IR     int; -- % ставка пени
    l_SN8_IR := to_number2(wcs_utl.get_creditdata(p_bid_id, 'PENALTY'));

    --l_SN8_KV     int; -- % валюта пени

    --l_SK4_IR     int;  -- % ставка за досрочное погашение
    if l_is_standart = 0 then
      l_SK4_IR := to_number(wcs_utl.get_mac(p_bid_id, 'MAC_AHEADPAYMENT_FEE'));
    else
      l_SK4_IR := wcs_utl.get_answ_decimal(p_bid_id,'AHEADPAYMENT_FEE');
    end if;

    CCK.CC_OPEN_COM(p_ND       => p_bid_id, -- Реф кредитного договора (системный)
                    p_SDI      => l_SDI, -- Сумма дисконта (в грн., примю 150.00грн),
                    p_F        => Null, -- Сумма первоначальной комиссии,
                    p_F_FREQ   => 2, -- периодичность уплаты перв комиссии
                    p_KOM      => l_KOM, -- Тип комиссии
                    p_KOM_IR   => l_KOM_IR, -- % ставка ежем-ной комис или сума в завис от метода
                    p_KOM_FREQ => 2, --  периодичность ежемесячной комиссии
                    p_KOM_DATF => l_DAT1, -- Дата первого начисления
                    p_KOM_DATE => null, -- Дата окончания начисления
                    p_KOM_KV   => null, -- Вал.сч.для деб-кой зад-ти (3578) за ежем-ную ком НЕИСПОЛЬЗУЕТСЯ
                    p_CR9_KV   => l_kv, -- Вал.сч.для деб-кой зад-ти (3578) за неисп лимит
                    p_CR9_IR   => null, -- % ставка за неисп лимит
                    p_CR9_I    => l_CR9_I, -- % 0- возобн , 1- не возобн-мая Кред-ная линия
                    p_SN8_IR   => l_SN8_IR, -- % ставка пени
                    p_SN8_KV   => l_kv, -- % валюта пени
                    p_SK4_IR   => l_SK4_IR -- % ставка за досрочное погашение
                    );

    --реестрация процентной карточки 8999
    -- Дополнительные параметры при условии что это сотрудник банка
    if l_is_employee = 1 and l_is_base_rate = 1 then
      cck_app.Set_ND_TXT(p_bid_id,
                         'INTRT',
                         wcs_utl.get_creditdata(p_bid_id,'INTEREST_RATE'));-- Рыночная процентная ставка
      cck_app.Set_ND_TXT(p_bid_id,
                         'DTRTB',
                         wcs_utl.get_creditdata(p_bid_id,'DATE_RATE_BEGIN'));-- Дата начала действия рыночной процентной ставки
    end if;

    -- Строим ГПК
    if l_is_employee = 1 and l_is_base_rate = 1 then
      cck.BR_INT(p_bid_id,g_BR);
/*      cck_dop.builder_gpk(p_bid_id, null, l_rterm, 0);
    else
      cck_dop.builder_gpk(p_bid_id, null, l_rterm, 0);*/
    end if;
    cck_dop.builder_gpk(p_bid_id, null, l_rterm, 0);
    /*select a8.acc acc8
      into l_acc8
      from cc_deal d,
           accounts a8,
           cc_add ad,
           nd_acc n
     where ad.nd = d.nd
       and ad.adds = 0
       and n.nd = d.nd
       and n.acc = a8.acc
       and a8.tip = 'LIM'
       and d.nd = p_bid_id;
    cck.CC_TMP_GPK(ND_      => p_bid_id,
                   nVID_    => type_gpk,
                   ACC8_    => l_acc8,
                   DAT3_    => l_dat1,
                   DAT4_    => l_dat4,
                   Reserv_  => null,
                   SUMR_    => 0,
                   gl_BDATE => sysdate);*/
    -- Расчитываем эф ставку (l_SDI - в коп., прим. 15000коп)
    cck_dop.calc_sdi(p_bid_id, l_sdi * 100);

    -- Сохраняем доп-ные пар-ры
    -- Значення кредитного ризику
    cck_app.set_nd_txt(p_bid_id,
                       'VNCRR',
                       wcs_utl.get_answ_list_text(p_bid_id, 'CRISK_OBU'));

    if wcs_utl.get_answ_bool(p_bid_id,'PI_PARTNER_SELECTED') = 1 then
      cck_app.Set_ND_TXT(p_bid_id,
                         'PARTN',
                         'Так');
      cck_app.Set_ND_TXT(p_bid_id,
                         'PAR_N',
                         wcs_utl.get_answ_list_text(p_bid_id,'PI_PARTNER_ID'));
      cck_app.Set_ND_TXT(p_bid_id,
                         'PAR_I',
                         wcs_utl.get_answ_text(p_bid_id,'PI_WHO_INVOLVED'));
    else
      cck_app.Set_ND_TXT(p_bid_id,
                         'PARTN',
                         'Ні');
    end if;

    if wcs_utl.has_answ(p_bid_id,'CERTIFY_NOTARY',p_ws_id, p_ws_number) = 1 then
      declare
        l_acrnotary varchar2(100) := wcs_utl.get_answ_refer(p_bid_id,'CERTIFY_NOTARY',p_ws_id, p_ws_number);
        l_fionotary varchar2(200);
        l_innnotary varchar2(14);
        l_accnotary varchar2(14);
      begin
        select vn.id,
               vn.tin,
               n.ACCOUNT_NUMBER
          into l_fionotary,
               l_innnotary,
               l_accnotary
          from v_active_notary_accreditation vn,
               v_notary_accreditation n
         where vn.id = n.ID;

         cck_app.Set_ND_TXT(p_bid_id,
                         'FION',
                         l_fionotary);

         cck_app.Set_ND_TXT(p_bid_id,
                         'INNN',
                         l_innnotary);

         cck_app.Set_ND_TXT(p_bid_id,
                         'ACCN',
                         l_accnotary);
       end;
    end if;
    -- Источник КД = 2-заявка
    cck_app.set_nd_txt(p_bid_id, 'CCSRC', '2');
  end;

  -- Регистрация кредита
  procedure register_credit(p_bid_id in v_wcs_bids.bid_id%type -- идентификатор заявки
                            ) is
    l_proc_name varchar2(40) := 'register_credit. ';
    l_rnk       customer.rnk%type; -- РНК нового клиента
  begin
    bars_audit.debug(g_pack_name || l_proc_name ||
                     'START !!! Params: p_bid_id=' || to_char(p_bid_id));

    -- регистрация контрагента
    l_rnk := wcs_register.register_client(p_bid_id);
    wcs_pack.bid_set_rnk(p_bid_id, l_rnk);

    --  Регистрация КД
    wcs_register.register_deal(p_bid_id, l_rnk);

    -- Регистрация расходов 3-х лиц
    --wcs_register.reg_servise_app_pay_client(p_bid_id);

    bars_audit.debug(g_pack_name || l_proc_name || 'Finish. - OK!');
  end register_credit;

  /* !!! Ждем обновления модуля страхования
  -- Регистрация договора страховки по клиенту
  function set_client_ins_deal(p_bid_id        in v_wcs_bid_insurances.bid_id%type, -- Идентификатор заявки
                               p_insurance_id  in v_wcs_bid_insurances.insurance_id%type, -- Идентификатор типа страховки
                               p_insurance_num in v_wcs_bid_insurances.insurance_num%type, -- Номер страховки
                               p_rnk           in customer.rnk%type -- РНК клиента
                               ) return ins_deals.id%type is
    l_bi_row v_wcs_bid_insurances%rowtype;
    l_id_row ins_deals%rowtype;
  begin
    -- пареметры страховки из заявки
    select *
      into l_bi_row
      from v_wcs_bid_insurances bi
     where bi.bid_id = p_bid_id
       and bi.insurance_id = p_insurance_id
       and bi.insurance_num = p_insurance_num;

    -- вычитываем параметры для заведения договора
    l_id_row.partner_id := l_bi_row.partner_id;
    l_id_row.type_id    := l_bi_row.ins_type_id;
    l_id_row.ser        := l_bi_row.ser;
    l_id_row.num        := l_bi_row.num;
    l_id_row.date_on    := l_bi_row.date_on;
    l_id_row.date_off   := l_bi_row.date_off;
    l_id_row.sum        := l_bi_row.sum;

    if wcs_utl.get_answ(p_bid_id,
                        'INS_COST_TYPE',
                        l_bi_row.ws_id,
                        l_bi_row.insurance_num) = 0 then
      l_id_row.insu_tariff := wcs_utl.get_answ(p_bid_id,
                                               'INS_COST_TARIFF',
                                               l_bi_row.ws_id,
                                               l_bi_row.insurance_num);
      l_id_row.insu_sum    := l_id_row.sum * l_id_row.insu_tariff / 100;
    else
      l_id_row.insu_sum := wcs_utl.get_answ(p_bid_id,
                                            'INS_COST_SUM',
                                            l_bi_row.ws_id,
                                            l_bi_row.insurance_num);
    end if;

    l_id_row.rnk    := p_rnk;
    l_id_row.grt_id := null;
    l_id_row.nd     := p_bid_id;

    if wcs_utl.get_answ(p_bid_id,
                        'INS_RENEW_NEED',
                        l_bi_row.ws_id,
                        l_bi_row.insurance_num) in ('0', 'N') then
      l_id_row.renew_need      := 'N';
      l_id_row.renew_alertdays := null;
    else
      l_id_row.renew_need      := 'Y';
      l_id_row.renew_alertdays := ins_pack.get_alertdays;
    end if;

    -- регистрация договора страхования
    l_id_row.id := ins_pack.f_create_deal(p_partner_id      => l_id_row.partner_id,
                                          p_type_id         => l_id_row.type_id,
                                          p_ser             => l_id_row.ser,
                                          p_num             => l_id_row.num,
                                          p_date_on         => l_id_row.date_on,
                                          p_date_off        => l_id_row.date_off,
                                          p_sum             => l_id_row.sum,
                                          p_insu_tariff     => l_id_row.insu_tariff,
                                          p_insu_sum        => l_id_row.insu_sum,
                                          p_rnk             => l_id_row.rnk,
                                          p_grt_id          => l_id_row.grt_id,
                                          p_nd              => l_id_row.nd,
                                          p_renew_need      => l_id_row.renew_need,
                                          p_renew_alertdays => l_id_row.renew_alertdays);

    -- заполняем платежный календарь
    append_payment_ins(l_id_row.id,
                       sysdate,
                       l_id_row.insu_sum,
                       l_id_row.renew_alertdays,
                       wcs_utl.get_answ(p_bid_id,
                                        'INS_PAYMENTS_FREQ',
                                        l_bi_row.ws_id,
                                        l_bi_row.insurance_num));

    return l_id_row.id;
  end set_client_ins_deal;

  -- Регистрация договоров страховки по клиенту
  procedure register_client_insurances(p_bid_id in v_wcs_bid_insurances.bid_id%type, -- Идентификатор заявки
                                       p_rnk    in customer.rnk%type default null -- РНК клиента
                                       ) is
    l_rnk customer.rnk%type;
  begin
    -- получаем РНК клиента
    select nvl(p_rnk, min(cd.rnk))
      into l_rnk
      from cc_deal cd
     where cd.nd = p_bid_id;

    -- поочередно регистрируем договора страховки
    for cur in (select *
                  from v_wcs_bid_insurances bi
                 where bi.bid_id = p_bid_id) loop
      declare
        l_ins_deal_id ins_deals.id%type;
      begin
        l_ins_deal_id := set_client_ins_deal(cur.bid_id,
                                             cur.insurance_id,
                                             cur.insurance_num,
                                             l_rnk);
      end;
    end loop;
  end register_client_insurances;

  -- Регистрация договора страховки по обеспечению
  function set_grt_ins_deal(p_bid_id        in v_wcs_bid_grt_insurances.bid_id%type, -- Идентификатор заявки
                            p_garantee_id   in v_wcs_bid_grt_insurances.garantee_id%type, -- Идентификатор типа обеспечения
                            p_garantee_num  in v_wcs_bid_grt_insurances.garantee_num%type, -- Номер обеспечения
                            p_insurance_id  in v_wcs_bid_grt_insurances.insurance_id%type, -- Идентификатор типа страховки
                            p_insurance_num in v_wcs_bid_grt_insurances.insurance_num%type, -- Номер страховки
                            p_rnk           in customer.rnk%type, -- РНК залогодателя (поручителя в случае поруки)
                            p_grt_id        in grt_deals.deal_id%type -- Идентификатор договора залога
                            ) return ins_deals.id%type is
    l_bgi_row v_wcs_bid_grt_insurances%rowtype;
    l_id_row  ins_deals%rowtype;
  begin
    -- пареметры страховки из заявки
    select *
      into l_bgi_row
      from v_wcs_bid_grt_insurances bgi
     where bgi.bid_id = p_bid_id
       and bgi.garantee_id = p_garantee_id
       and bgi.garantee_num = p_garantee_num
       and bgi.insurance_id = p_insurance_id
       and bgi.insurance_num = p_insurance_num;

    -- вычитываем параметры для заведения договора
    l_id_row.partner_id := l_bgi_row.partner_id;
    l_id_row.type_id    := l_bgi_row.ins_type_id;
    l_id_row.ser        := l_bgi_row.ser;
    l_id_row.num        := l_bgi_row.num;
    l_id_row.date_on    := l_bgi_row.date_on;
    l_id_row.date_off   := l_bgi_row.date_off;
    l_id_row.sum        := l_bgi_row.sum;

    if wcs_utl.get_answ(p_bid_id,
                        'INS_COST_TYPE',
                        l_bgi_row.ws_id,
                        l_bgi_row.insurance_num) = 0 then
      l_id_row.insu_tariff := wcs_utl.get_answ(p_bid_id,
                                               'INS_COST_TARIFF',
                                               l_bgi_row.ws_id,
                                               l_bgi_row.insurance_num);
      l_id_row.insu_sum    := l_id_row.sum * l_id_row.insu_tariff / 100;
    else
      l_id_row.insu_sum := wcs_utl.get_answ(p_bid_id,
                                            'INS_COST_SUM',
                                            l_bgi_row.ws_id,
                                            l_bgi_row.insurance_num);
    end if;

    l_id_row.rnk    := p_rnk;
    l_id_row.grt_id := p_grt_id;
    l_id_row.nd     := p_bid_id;

    if wcs_utl.get_answ(p_bid_id,
                        'INS_RENEW_NEED',
                        l_bgi_row.ws_id,
                        l_bgi_row.insurance_num) in ('0', 'N') then
      l_id_row.renew_need      := 'N';
      l_id_row.renew_alertdays := null;
    else
      l_id_row.renew_need      := 'Y';
      l_id_row.renew_alertdays := ins_pack.get_alertdays;
    end if;

    -- регистрация договора страхования
    l_id_row.id := ins_pack.f_create_deal(p_partner_id      => l_id_row.partner_id,
                                          p_type_id         => l_id_row.type_id,
                                          p_ser             => l_id_row.ser,
                                          p_num             => l_id_row.num,
                                          p_date_on         => l_id_row.date_on,
                                          p_date_off        => l_id_row.date_off,
                                          p_sum             => l_id_row.sum,
                                          p_insu_tariff     => l_id_row.insu_tariff,
                                          p_insu_sum        => l_id_row.insu_sum,
                                          p_rnk             => l_id_row.rnk,
                                          p_grt_id          => l_id_row.grt_id,
                                          p_nd              => l_id_row.nd,
                                          p_renew_need      => l_id_row.renew_need,
                                          p_renew_alertdays => l_id_row.renew_alertdays);

    -- заполняем платежный календарь
    append_payment_ins(l_id_row.id,
                       l_id_row.date_on,
                       l_id_row.insu_sum,
                       ins_pack.get_alertdays,
                       wcs_utl.get_answ(p_bid_id,
                                        'INS_PAYMENTS_FREQ',
                                        l_bgi_row.ws_id,
                                        l_bgi_row.insurance_num));

    return l_id_row.id;
  end set_grt_ins_deal;
  */

  -- Регистрация доп. параметров обеспечения типа Транспортний засіб
  procedure set_grt_vehicle_deal(p_bid_id       in v_wcs_bid_garantees.bid_id%type, -- Идентификатор заявки
                                 p_ws_id        in v_wcs_bid_garantees.ws_id%type, -- Идентификатор рабочего пространства
                                 p_garantee_num in v_wcs_bid_garantees.garantee_num%type, -- Номер обеспечения
                                 p_grt_id       in grt_deals.deal_id%type -- Идентификатор договора обеспечения
                                 ) is
    l_gv_row grt_vehicles%rowtype;
  begin
    l_gv_row.deal_id              := p_grt_id;
    l_gv_row.type                 := wcs_utl.get_answ(p_bid_id,
                                                      'GRT_3_1',
                                                      p_ws_id,
                                                      p_garantee_num);
    l_gv_row.model                := wcs_utl.get_answ(p_bid_id,
                                                      'GRT_3_2',
                                                      p_ws_id,
                                                      p_garantee_num);
    l_gv_row.mileage              := wcs_utl.get_answ(p_bid_id,
                                                      'GRT_3_3',
                                                      p_ws_id,
                                                      p_garantee_num);
    l_gv_row.veh_reg_num          := wcs_utl.get_answ(p_bid_id,
                                                      'GRT_3_4',
                                                      p_ws_id,
                                                      p_garantee_num);
    l_gv_row.made_date            := to_date('01/01/' ||
                                             wcs_utl.get_answ(p_bid_id,
                                                              'GRT_3_5',
                                                              p_ws_id,
                                                              p_garantee_num),
                                             'dd/mm/yyyy');
    l_gv_row.color                := wcs_utl.get_answ(p_bid_id,
                                                      'GRT_3_6',
                                                      p_ws_id,
                                                      p_garantee_num);
    l_gv_row.vin                  := wcs_utl.get_answ(p_bid_id,
                                                      'GRT_3_7',
                                                      p_ws_id,
                                                      p_garantee_num);
    l_gv_row.engine_num           := wcs_utl.get_answ(p_bid_id,
                                                      'GRT_3_8',
                                                      p_ws_id,
                                                      p_garantee_num);
    l_gv_row.reg_doc_ser          := wcs_utl.get_answ(p_bid_id,
                                                      'GRT_3_9',
                                                      p_ws_id,
                                                      p_garantee_num);
    l_gv_row.reg_doc_num          := wcs_utl.get_answ(p_bid_id,
                                                      'GRT_3_10',
                                                      p_ws_id,
                                                      p_garantee_num);
    l_gv_row.reg_doc_date         := wcs_utl.get_answ(p_bid_id,
                                                      'GRT_3_10_0',
                                                      p_ws_id,
                                                      p_garantee_num);
    l_gv_row.reg_doc_organ        := wcs_utl.get_answ(p_bid_id,
                                                      'GRT_3_11',
                                                      p_ws_id,
                                                      p_garantee_num);
    l_gv_row.reg_owner_addr       := wcs_utl.get_answ(p_bid_id,
                                                      'GRT_3_12',
                                                      p_ws_id,
                                                      p_garantee_num);
    l_gv_row.reg_spec_marks       := wcs_utl.get_answ(p_bid_id,
                                                      'GRT_3_13',
                                                      p_ws_id,
                                                      p_garantee_num);
    l_gv_row.parking_addr         := wcs_utl.get_answ(p_bid_id,
                                                      'GRT_3_14',
                                                      p_ws_id,
                                                      p_garantee_num);
    l_gv_row.crd_end_date         := null;
    l_gv_row.ownship_reg_num      := wcs_utl.get_answ(p_bid_id,
                                                      'GRT_3_15',
                                                      p_ws_id,
                                                      p_garantee_num);
    l_gv_row.ownship_reg_checksum := wcs_utl.get_answ(p_bid_id,
                                                      'GRT_3_16',
                                                      p_ws_id,
                                                      p_garantee_num);

    grt_mgr.iu_vehicles(l_gv_row.deal_id,
                        l_gv_row.type,
                        l_gv_row.model,
                        l_gv_row.mileage,
                        l_gv_row.veh_reg_num,
                        l_gv_row.made_date,
                        l_gv_row.color,
                        l_gv_row.vin,
                        l_gv_row.engine_num,
                        l_gv_row.reg_doc_ser,
                        l_gv_row.reg_doc_num,
                        l_gv_row.reg_doc_date,
                        l_gv_row.reg_doc_organ,
                        l_gv_row.reg_owner_addr,
                        l_gv_row.reg_spec_marks,
                        l_gv_row.parking_addr,
                        l_gv_row.crd_end_date,
                        l_gv_row.ownship_reg_num,
                        l_gv_row.ownship_reg_checksum);
  end set_grt_vehicle_deal;

  -- Регистрация доп. параметров обеспечения типа Депозит
  procedure set_grt_deposit_deal(p_bid_id       in v_wcs_bid_garantees.bid_id%type, -- Идентификатор заявки
                                 p_ws_id        in v_wcs_bid_garantees.ws_id%type, -- Идентификатор рабочего пространства
                                 p_garantee_num in v_wcs_bid_garantees.garantee_num%type, -- Номер обеспечения
                                 p_grt_id       in grt_deals.deal_id%type -- Идентификатор договора обеспечения
                                 ) is
    l_gd_row grt_deposits%rowtype;
  begin
    l_gd_row.deal_id     := p_grt_id;
    l_gd_row.doc_num     := wcs_utl.get_answ(p_bid_id,
                                             'GRT_6_1',
                                             p_ws_id,
                                             p_garantee_num);
    l_gd_row.doc_date    := wcs_utl.get_answ(p_bid_id,
                                             'GRT_6_2',
                                             p_ws_id,
                                             p_garantee_num);
    l_gd_row.doc_enddate := wcs_utl.get_answ(p_bid_id,
                                             'GRT_6_3',
                                             p_ws_id,
                                             p_garantee_num);

    begin
      select a.acc
        into l_gd_row.acc
        from accounts a
       where a.nls =
             wcs_utl.get_answ(p_bid_id, 'GRT_6_4', p_ws_id, p_garantee_num)
         and a.kv =
             wcs_utl.get_answ(p_bid_id, 'GRT_6_5', p_ws_id, p_garantee_num);
    exception
      when no_data_found then
        /*
        TODO: owner="tvSukhov" created="06.06.2011"
        text="Переделать выброс ошибки на bars_error"
        */
        raise_application_error(-20331,
                                'Для кредитной заявки №' || p_bid_id ||
                                ' в обеспечении Депозитного договора введен не верный счет ' ||
                                wcs_utl.get_answ(p_bid_id,
                                                 'GRT_6_4',
                                                 p_ws_id,
                                                 p_garantee_num) || '(' ||
                                wcs_utl.get_answ(p_bid_id,
                                                 'GRT_6_5',
                                                 p_ws_id,
                                                 p_garantee_num) || ') !',
                                true);
    end;

    grt_mgr.iu_deposits(l_gd_row.deal_id,
                        l_gd_row.doc_num,
                        l_gd_row.doc_date,
                        l_gd_row.doc_enddate,
                        l_gd_row.acc);
  end set_grt_deposit_deal;

  -- Регистрация доп. параметров обеспечения типа Квартира/будинок
  procedure set_grt_mortgage_deal(p_bid_id       in v_wcs_bid_garantees.bid_id%type, -- Идентификатор заявки
                                  p_ws_id        in v_wcs_bid_garantees.ws_id%type, -- Идентификатор рабочего пространства
                                  p_garantee_num in v_wcs_bid_garantees.garantee_num%type, -- Номер обеспечения
                                  p_grt_id       in grt_deals.deal_id%type -- Идентификатор договора обеспечения
                                  ) is
    l_gm_row grt_mortgage%rowtype;
  begin
    l_gm_row.deal_id              := p_grt_id;
    l_gm_row.rooms_cnt            := wcs_utl.get_answ(p_bid_id,
                                                      'GRT_4_1',
                                                      p_ws_id,
                                                      p_garantee_num);
    l_gm_row.app_num              := wcs_utl.get_answ(p_bid_id,
                                                      'GRT_4_2',
                                                      p_ws_id,
                                                      p_garantee_num);
    l_gm_row.total_space          := wcs_utl.get_answ(p_bid_id,
                                                      'GRT_4_3',
                                                      p_ws_id,
                                                      p_garantee_num);
    l_gm_row.living_space         := wcs_utl.get_answ(p_bid_id,
                                                      'GRT_4_4',
                                                      p_ws_id,
                                                      p_garantee_num);
    l_gm_row.floor                := wcs_utl.get_answ(p_bid_id,
                                                      'GRT_4_5',
                                                      p_ws_id,
                                                      p_garantee_num);
    l_gm_row.addr                 := wcs_utl.get_answ(p_bid_id,
                                                      'GRT_4_6',
                                                      p_ws_id,
                                                      p_garantee_num);
    l_gm_row.buiding_type         := wcs_utl.get_answ_list_text(p_bid_id,
                                                                'GRT_4_7',
                                                                p_ws_id,
                                                                p_garantee_num);
    l_gm_row.building_num         := wcs_utl.get_answ(p_bid_id,
                                                      'GRT_4_8',
                                                      p_ws_id,
                                                      p_garantee_num);
    l_gm_row.building_lit         := wcs_utl.get_answ(p_bid_id,
                                                      'GRT_4_9',
                                                      p_ws_id,
                                                      p_garantee_num);
    l_gm_row.city                 := wcs_utl.get_answ(p_bid_id,
                                                      'GRT_4_10',
                                                      p_ws_id,
                                                      p_garantee_num);
    l_gm_row.city_distr           := wcs_utl.get_answ(p_bid_id,
                                                      'GRT_4_11',
                                                      p_ws_id,
                                                      p_garantee_num);
    l_gm_row.living_distr         := wcs_utl.get_answ(p_bid_id,
                                                      'GRT_4_12',
                                                      p_ws_id,
                                                      p_garantee_num);
    l_gm_row.micro_distr          := wcs_utl.get_answ(p_bid_id,
                                                      'GRT_4_13',
                                                      p_ws_id,
                                                      p_garantee_num);
    l_gm_row.area_num             := wcs_utl.get_answ(p_bid_id,
                                                      'GRT_4_14',
                                                      p_ws_id,
                                                      p_garantee_num);
    l_gm_row.build_sect_count     := wcs_utl.get_answ(p_bid_id,
                                                      'GRT_4_15',
                                                      p_ws_id,
                                                      p_garantee_num);
    l_gm_row.add_GRT_addr         := wcs_utl.get_answ(p_bid_id,
                                                      'GRT_4_16',
                                                      p_ws_id,
                                                      p_garantee_num);
    l_gm_row.mort_doc_num         := wcs_utl.get_answ(p_bid_id,
                                                      'GRT_4_17',
                                                      p_ws_id,
                                                      p_garantee_num);
    l_gm_row.mort_doc_date        := wcs_utl.get_answ(p_bid_id,
                                                      'GRT_4_18',
                                                      p_ws_id,
                                                      p_garantee_num);
    l_gm_row.ownship_reg_num      := wcs_utl.get_answ(p_bid_id,
                                                      'GRT_4_19',
                                                      p_ws_id,
                                                      p_garantee_num);
    l_gm_row.ownship_reg_checksum := wcs_utl.get_answ(p_bid_id,
                                                      'GRT_4_20',
                                                      p_ws_id,
                                                      p_garantee_num);

    grt_mgr.iu_mortgage(l_gm_row.deal_id,
                        l_gm_row.rooms_cnt,
                        l_gm_row.app_num,
                        l_gm_row.total_space,
                        l_gm_row.living_space,
                        l_gm_row.floor,
                        l_gm_row.addr,
                        l_gm_row.buiding_type,
                        l_gm_row.building_num,
                        l_gm_row.building_lit,
                        l_gm_row.city,
                        l_gm_row.city_distr,
                        l_gm_row.living_distr,
                        l_gm_row.micro_distr,
                        l_gm_row.area_num,
                        l_gm_row.build_sect_count,
                        l_gm_row.add_GRT_addr,
                        l_gm_row.mort_doc_num,
                        l_gm_row.mort_doc_date,
                        l_gm_row.ownship_reg_num,
                        l_gm_row.ownship_reg_checksum);
  end set_grt_mortgage_deal;

  -- Регистрация доп. параметров обеспечения типа Земельна ділянка
  procedure set_grt_mortgage_land_deal(p_bid_id       in v_wcs_bid_garantees.bid_id%type, -- Идентификатор заявки
                                       p_ws_id        in v_wcs_bid_garantees.ws_id%type, -- Идентификатор рабочего пространства
                                       p_garantee_num in v_wcs_bid_garantees.garantee_num%type, -- Номер обеспечения
                                       p_grt_id       in grt_deals.deal_id%type -- Идентификатор договора обеспечения
                                       ) is
    l_gml_row grt_mortgage_land%rowtype;
  begin
    l_gml_row.deal_id             := p_grt_id;
    l_gml_row.area                := wcs_utl.get_answ(p_bid_id,
                                                      'GRT_5_1',
                                                      p_ws_id,
                                                      p_garantee_num);
    l_gml_row.land_purpose        := wcs_utl.get_answ(p_bid_id,
                                                      'GRT_5_2',
                                                      p_ws_id,
                                                      p_garantee_num);
    l_gml_row.build_num           := wcs_utl.get_answ(p_bid_id,
                                                      'GRT_5_3',
                                                      p_ws_id,
                                                      p_garantee_num);
    l_gml_row.build_lit           := wcs_utl.get_answ(p_bid_id,
                                                      'GRT_5_4',
                                                      p_ws_id,
                                                      p_garantee_num);
    l_gml_row.ownship_doc_ser     := wcs_utl.get_answ(p_bid_id,
                                                      'GRT_5_5',
                                                      p_ws_id,
                                                      p_garantee_num);
    l_gml_row.ownship_doc_num     := wcs_utl.get_answ(p_bid_id,
                                                      'GRT_5_6',
                                                      p_ws_id,
                                                      p_garantee_num);
    l_gml_row.ownship_doc_date    := wcs_utl.get_answ(p_bid_id,
                                                      'GRT_5_7',
                                                      p_ws_id,
                                                      p_garantee_num);
    l_gml_row.ownship_doc_reason  := wcs_utl.get_answ(p_bid_id,
                                                      'GRT_5_8',
                                                      p_ws_id,
                                                      p_garantee_num);
    l_gml_row.ownship_regbook_num := wcs_utl.get_answ(p_bid_id,
                                                      'GRT_5_9',
                                                      p_ws_id,
                                                      p_garantee_num);
    l_gml_row.extract_reg_date    := wcs_utl.get_answ(p_bid_id,
                                                      'GRT_5_10',
                                                      p_ws_id,
                                                      p_garantee_num);
    l_gml_row.extract_reg_organ   := wcs_utl.get_answ(p_bid_id,
                                                      'GRT_5_11',
                                                      p_ws_id,
                                                      p_garantee_num);
    l_gml_row.extract_reg_num     := wcs_utl.get_answ(p_bid_id,
                                                      'GRT_5_12',
                                                      p_ws_id,
                                                      p_garantee_num);
    l_gml_row.extract_reg_sum     := wcs_utl.get_answ(p_bid_id,
                                                      'GRT_5_13',
                                                      p_ws_id,
                                                      p_garantee_num);
    l_gml_row.lessee_num          := wcs_utl.get_answ(p_bid_id,
                                                      'GRT_5_14',
                                                      p_ws_id,
                                                      p_garantee_num);
    l_gml_row.lessee_name         := wcs_utl.get_answ(p_bid_id,
                                                      'GRT_5_15',
                                                      p_ws_id,
                                                      p_garantee_num);
    l_gml_row.lessee_dog_enddate  := wcs_utl.get_answ(p_bid_id,
                                                      'GRT_5_16',
                                                      p_ws_id,
                                                      p_garantee_num);
    l_gml_row.lessee_dog_num      := wcs_utl.get_answ(p_bid_id,
                                                      'GRT_5_17',
                                                      p_ws_id,
                                                      p_garantee_num);
    l_gml_row.lessee_dog_date     := wcs_utl.get_answ(p_bid_id,
                                                      'GRT_5_18',
                                                      p_ws_id,
                                                      p_garantee_num);
    l_gml_row.bans_reg_num        := wcs_utl.get_answ(p_bid_id,
                                                      'GRT_5_19',
                                                      p_ws_id,
                                                      p_garantee_num);
    l_gml_row.bans_reg_date       := wcs_utl.get_answ(p_bid_id,
                                                      'GRT_5_20',
                                                      p_ws_id,
                                                      p_garantee_num);

    grt_mgr.iu_mortgage_land(l_gml_row.deal_id,
                             l_gml_row.area,
                             l_gml_row.land_purpose,
                             l_gml_row.build_num,
                             l_gml_row.build_lit,
                             l_gml_row.ownship_doc_ser,
                             l_gml_row.ownship_doc_num,
                             l_gml_row.ownship_doc_date,
                             l_gml_row.ownship_doc_reason,
                             l_gml_row.ownship_regbook_num,
                             l_gml_row.extract_reg_date,
                             l_gml_row.extract_reg_organ,
                             l_gml_row.extract_reg_num,
                             l_gml_row.extract_reg_sum,
                             l_gml_row.lessee_num,
                             l_gml_row.lessee_name,
                             l_gml_row.lessee_dog_enddate,
                             l_gml_row.lessee_dog_num,
                             l_gml_row.lessee_dog_date,
                             l_gml_row.bans_reg_num,
                             l_gml_row.bans_reg_date);
  end set_grt_mortgage_land_deal;

  -- Регистрация доп. параметров обеспечения типа Пром. товари
  procedure set_grt_product_deal(p_bid_id       in v_wcs_bid_garantees.bid_id%type, -- Идентификатор заявки
                                 p_ws_id        in v_wcs_bid_garantees.ws_id%type, -- Идентификатор рабочего пространства
                                 p_garantee_num in v_wcs_bid_garantees.garantee_num%type, -- Номер обеспечения
                                 p_grt_id       in grt_deals.deal_id%type -- Идентификатор договора обеспечения
                                 ) is
    l_gp_row grt_products%rowtype;
  begin
    l_gp_row.deal_id        := p_grt_id;
    l_gp_row.type_txt       := wcs_utl.get_answ(p_bid_id,
                                                'GRT_7_1',
                                                p_ws_id,
                                                p_garantee_num);
    l_gp_row.name           := wcs_utl.get_answ(p_bid_id,
                                                'GRT_7_2',
                                                p_ws_id,
                                                p_garantee_num);
    l_gp_row.model          := wcs_utl.get_answ(p_bid_id,
                                                'GRT_7_3',
                                                p_ws_id,
                                                p_garantee_num);
    l_gp_row.modification   := wcs_utl.get_answ(p_bid_id,
                                                'GRT_7_4',
                                                p_ws_id,
                                                p_garantee_num);
    l_gp_row.serial_num     := wcs_utl.get_answ(p_bid_id,
                                                'GRT_7_5',
                                                p_ws_id,
                                                p_garantee_num);
    l_gp_row.made_date      := wcs_utl.get_answ(p_bid_id,
                                                'GRT_7_6',
                                                p_ws_id,
                                                p_garantee_num);
    l_gp_row.other_comments := wcs_utl.get_answ(p_bid_id,
                                                'GRT_7_7',
                                                p_ws_id,
                                                p_garantee_num);

    grt_mgr.iu_products(l_gp_row.deal_id,
                        l_gp_row.type_txt,
                        l_gp_row.name,
                        l_gp_row.model,
                        l_gp_row.modification,
                        l_gp_row.serial_num,
                        l_gp_row.made_date,
                        l_gp_row.other_comments);
  end set_grt_product_deal;

  -- Регистрация доп. параметров обеспечения типа Цінності
  procedure set_grt_valuables_deal(p_bid_id       in v_wcs_bid_garantees.bid_id%type, -- Идентификатор заявки
                                   p_ws_id        in v_wcs_bid_garantees.ws_id%type, -- Идентификатор рабочего пространства
                                   p_garantee_num in v_wcs_bid_garantees.garantee_num%type, -- Номер обеспечения
                                   p_grt_id       in grt_deals.deal_id%type -- Идентификатор договора обеспечения
                                   ) is
    l_gv_row grt_valuables%rowtype;
  begin
    l_gv_row.deal_id        := p_grt_id;
    l_gv_row.name           := wcs_utl.get_answ(p_bid_id,
                                                'GRT_8_1',
                                                p_ws_id,
                                                p_garantee_num);
    l_gv_row.descr          := wcs_utl.get_answ(p_bid_id,
                                                'GRT_8_2',
                                                p_ws_id,
                                                p_garantee_num);
    l_gv_row.weight         := wcs_utl.get_answ(p_bid_id,
                                                'GRT_8_3',
                                                p_ws_id,
                                                p_garantee_num);
    l_gv_row.part_cnt       := wcs_utl.get_answ(p_bid_id,
                                                'GRT_8_4',
                                                p_ws_id,
                                                p_garantee_num);
    l_gv_row.part_disc_weig := wcs_utl.get_answ(p_bid_id,
                                                'GRT_8_5',
                                                p_ws_id,
                                                p_garantee_num);
    l_gv_row.value_weight   := wcs_utl.get_answ(p_bid_id,
                                                'GRT_8_6',
                                                p_ws_id,
                                                p_garantee_num);
    l_gv_row.tariff_price   := wcs_utl.get_answ(p_bid_id,
                                                'GRT_8_7',
                                                p_ws_id,
                                                p_garantee_num);
    l_gv_row.expert_price   := wcs_utl.get_answ(p_bid_id,
                                                'GRT_8_8',
                                                p_ws_id,
                                                p_garantee_num);
    l_gv_row.estimate_price := wcs_utl.get_answ(p_bid_id,
                                                'GRT_8_9',
                                                p_ws_id,
                                                p_garantee_num);

    grt_mgr.iu_valuables(l_gv_row.deal_id,
                         l_gv_row.name,
                         l_gv_row.descr,
                         l_gv_row.weight,
                         l_gv_row.part_cnt,
                         l_gv_row.part_disc_weig,
                         l_gv_row.value_weight,
                         l_gv_row.tariff_price,
                         l_gv_row.expert_price,
                         l_gv_row.estimate_price);
  end set_grt_valuables_deal;

  -- Регистрация договора обеспечения
  function set_guarantee_deal(p_bid_id       in v_wcs_bid_garantees.bid_id%type, -- Идентификатор заявки
                              p_garantee_id  in v_wcs_bid_garantees.garantee_id%type, -- Идентификатор типа обеспечения
                              p_garantee_num in v_wcs_bid_garantees.garantee_num%type, -- Номер обеспечения
                              p_rnk          in customer.rnk%type default null -- РНК клиента
                              ) return grt_deals.deal_id%type is
    l_b_row  v_wcs_bids%rowtype;
    l_bg_row v_wcs_bid_garantees%rowtype;
    l_gd_row grt_deals%rowtype;
  begin
    -- параметры заявки
    select * into l_b_row from v_wcs_bids b where b.bid_id = p_bid_id;

    -- параметры договора обеспечения из заявки
    select *
      into l_bg_row
      from v_wcs_bid_garantees bg
     where bg.bid_id = p_bid_id
       and bg.garantee_id = p_garantee_id
       and bg.garantee_num = p_garantee_num;

    -- регистрация владельца обеспечения/поручителя как контрагента
    if (p_garantee_id = 'GUARANTOR' or
       wcs_utl.get_answ(p_bid_id,
                         'GRT_0',
                         l_bg_row.ws_id,
                         l_bg_row.garantee_num) = 0) then
      l_gd_row.deal_rnk := register_client(p_bid_id,
                                           l_bg_row.ws_id,
                                           l_bg_row.garantee_num);
    else
      l_gd_row.deal_rnk := p_rnk;
    end if;

    -- вычитываем параметры для заведения договора
    l_gd_row.grt_type_id  := l_bg_row.type_obu_id;
    l_gd_row.grt_subj_id  := to_number(wcs_utl.get_answ(p_bid_id,
                                                        'GRT_2_1_0',
                                                        l_bg_row.ws_id,
                                                        l_bg_row.garantee_num));
    l_gd_row.grt_place_id := case
                               when p_garantee_id = 'GUARANTOR' then
                               -- для поручителя параметр "Розміщення забезпечення" ставим 1 - Знаходиться у заставодавця
                                1
                               else
                                wcs_utl.get_answ(p_bid_id,
                                                 'GRT_2_2',
                                                 l_bg_row.ws_id,
                                                 l_bg_row.garantee_num)
                             end;

    l_gd_row.deal_num        := wcs_utl.get_answ(p_bid_id,
                                                 'GRT_2_3',
                                                 l_bg_row.ws_id,
                                                 l_bg_row.garantee_num);
    l_gd_row.deal_date       := wcs_utl.get_answ(p_bid_id,
                                                 'GRT_2_4',
                                                 l_bg_row.ws_id,
                                                 l_bg_row.garantee_num);
    l_gd_row.grt_name := case
                           when p_garantee_id = 'GUARANTOR' then
                           -- для поручителя параметр "Повна назва застави" ставим null
                            null
                           else
                            wcs_utl.get_answ(p_bid_id,
                                             'GRT_2_7',
                                             l_bg_row.ws_id,
                                             l_bg_row.garantee_num)
                         end;
    l_gd_row.grt_comment     := wcs_utl.get_answ(p_bid_id,
                                                 'GRT_2_8',
                                                 l_bg_row.ws_id,
                                                 l_bg_row.garantee_num);
    l_gd_row.grt_buy_dognum  := wcs_utl.get_answ(p_bid_id,
                                                 'GRT_2_9',
                                                 l_bg_row.ws_id,
                                                 l_bg_row.garantee_num);
    l_gd_row.grt_buy_dogdate := wcs_utl.get_answ(p_bid_id,
                                                 'GRT_2_10',
                                                 l_bg_row.ws_id,
                                                 l_bg_row.garantee_num);

    case
      when p_garantee_id = 'MORTGAGE_LAND' then
        l_gd_row.grt_unit := 2;
      when p_garantee_id in ('VEHICLE',
                             'DEPOSIT',
                             'PRODUCT',
                             'VALUABLES',
                             'MORTGAGE',
                             'GUARANTOR') then
        l_gd_row.grt_unit := 1;
    end case;

    /*
    TODO: owner="tvSukhov" category="Finish" priority="1 - High" created="06.06.2011"
    text="Добавить вычитку кол-ва в l_gd_row.grt_cnt из заявки"
    */
    l_gd_row.grt_cnt := 1;

    case
      when p_garantee_id = 'GUARANTOR' then
        -- для поручителя сумму берем из вопроса GRT_2_13 - Сума поруки,
        -- а валюту из валюти кредита
        l_gd_row.grt_sum := wcs_utl.get_answ(p_bid_id,
                                             'GRT_2_16',
                                             l_bg_row.ws_id,
                                             l_bg_row.garantee_num);
        select nvl(min(t.kv), 980)
          into l_gd_row.grt_sum_curcode
          from tabval$global t
         where t.lcv = wcs_utl.get_creditdata(p_bid_id, 'CREDIT_CURRENCY')
           and rownum = 1;

        l_gd_row.chk_sum := wcs_utl.get_answ(p_bid_id,
                                             'GRT_2_16',
                                             l_bg_row.ws_id,
                                             l_bg_row.garantee_num);
      else
        l_gd_row.grt_sum         := wcs_utl.get_answ(p_bid_id,
                                                     'GRT_2_12',
                                                     l_bg_row.ws_id,
                                                     l_bg_row.garantee_num);
        l_gd_row.grt_sum_curcode := wcs_utl.get_answ(p_bid_id,
                                                     'GRT_2_11',
                                                     l_bg_row.ws_id,
                                                     l_bg_row.garantee_num);
        l_gd_row.chk_sum         := wcs_utl.get_answ(p_bid_id,
                                                     'GRT_2_13',
                                                     l_bg_row.ws_id,
                                                     l_bg_row.garantee_num);
    end case;

    l_gd_row.warn_days := grt_mgr.get_warn_days;
    l_gd_row.staff_id  := l_b_row.mgr_id;
    l_gd_row.branch    := l_b_row.branch;

    l_gd_row.deal_id := grt_mgr.register_deal(l_gd_row.grt_type_id,
                                              l_gd_row.grt_place_id,
                                              l_gd_row.deal_rnk,
                                              l_gd_row.deal_num,
                                              l_gd_row.deal_date,
                                              null, -- p_deal_name
                                              null, -- p_deal_place
                                              l_gd_row.grt_name,
                                              l_gd_row.grt_comment,
                                              l_gd_row.grt_buy_dognum,
                                              l_gd_row.grt_buy_dogdate,
                                              l_gd_row.grt_unit,
                                              l_gd_row.grt_cnt,
                                              l_gd_row.grt_sum * 100,
                                              l_gd_row.grt_sum_curcode,
                                              l_gd_row.chk_date_avail,
                                              l_gd_row.chk_date_status,
                                              l_gd_row.revalue_date,
                                              l_gd_row.chk_sum * 100,
                                              l_gd_row.warn_days,
                                              l_gd_row.staff_id,
                                              l_gd_row.branch,
                                              360,
                                              l_gd_row.grt_sum,
                                              l_gd_row.grt_subj_id);

    -- привязка к кредитному договору
    grt_mgr.fill_cc_grt(p_bid_id, l_gd_row.deal_id);

    -- регистрация доп. параметров
    case
      when p_garantee_id = 'VEHICLE' then
        set_grt_vehicle_deal(p_bid_id,
                             l_bg_row.ws_id,
                             p_garantee_num,
                             l_gd_row.deal_id);
      when p_garantee_id = 'DEPOSIT' then
        set_grt_deposit_deal(p_bid_id,
                             l_bg_row.ws_id,
                             p_garantee_num,
                             l_gd_row.deal_id);
      when p_garantee_id = 'MORTGAGE' then
        set_grt_mortgage_deal(p_bid_id,
                              l_bg_row.ws_id,
                              p_garantee_num,
                              l_gd_row.deal_id);
      when p_garantee_id = 'MORTGAGE_LAND' then
        set_grt_mortgage_land_deal(p_bid_id,
                                   l_bg_row.ws_id,
                                   p_garantee_num,
                                   l_gd_row.deal_id);
      when p_garantee_id = 'PRODUCT' then
        set_grt_product_deal(p_bid_id,
                             l_bg_row.ws_id,
                             p_garantee_num,
                             l_gd_row.deal_id);
      when p_garantee_id = 'VALUABLES' then
        set_grt_valuables_deal(p_bid_id,
                               l_bg_row.ws_id,
                               p_garantee_num,
                               l_gd_row.deal_id);
      else
        null;
    end case;

    /* !!! Ждем обновления модуля страхования
    -- страховки обеспечения (в том числе и порука)
    for cur in (select *
                  from v_wcs_bid_grt_insurances bgi
                 where bgi.bid_id = p_bid_id
                   and bgi.garantee_id = p_garantee_id
                   and bgi.garantee_num = p_garantee_num) loop
      declare
        l_ins_deal_id ins_deals.id%type;
      begin
        l_ins_deal_id := set_grt_ins_deal(cur.bid_id,
                                          cur.garantee_id,
                                          cur.garantee_num,
                                          cur.insurance_id,
                                          cur.insurance_num,
                                          l_gd_row.deal_rnk,
                                          l_gd_row.deal_id);
      end;

    end loop;
    */

    return l_gd_row.deal_id;
  end set_guarantee_deal;

  -- Регистрация договоров обеспечения
  procedure register_guarantees(p_bid_id in v_wcs_bid_garantees.bid_id%type, -- Идентификатор заявки
                                p_rnk    in customer.rnk%type default null -- РНК клиента
                                ) is
    l_rnk customer.rnk%type;
  begin
    -- получаем РНК клиента
    select nvl(p_rnk, min(cd.rnk))
      into l_rnk
      from cc_deal cd
     where cd.nd = p_bid_id;

    -- поочередно регистрируем договора обеспечения
    for cur in (select *
                  from v_wcs_bid_garantees bg
                 where bg.bid_id = p_bid_id) loop
      declare
        l_grt_deal_id grt_deals.deal_id%type;
      begin
        l_grt_deal_id := set_guarantee_deal(cur.bid_id,
                                            cur.garantee_id,
                                            cur.garantee_num,
                                            l_rnk);
      end;
    end loop;
  end register_guarantees;

  -- Визирование заявки/кредита
  /*
  p_visa - устанавливаемое значение договора
  0  - Отркыв-ся КД, строятся графики погашения и потоки рассчитывается эф ставка
  2  - Регистрируется обеспечение и договора страховки.
  4  - Откр-ся счета договора и обеспечении. Присоединяется текущий счет
  10 - Формирование остатков на счетах залога. Формирование остатков на счете дисконта. Кд переходит в режим обслуживания

  15 - Закрывается КД
  */
  procedure put_visa(p_bid_id in number, -- идентификатор заявки
                     p_visa   in number) is
    l_current_visa number;
    l_rnk          number;
    m_type         VARCHAR2_LIST;
    l_acc          accounts.acc%type;
  begin
    -- текущее состояние
    select max(sos)
      into l_current_visa
      from cc_deal cd
     where cd.nd = p_bid_id;

    -- Допустимые варианты изменения состояний
    if to_char(l_current_visa) || '_' || to_char(p_visa) not in
       ('_0',
        '0_2',
        '2_4',
        '4_4',
        '4_10',
        '0_15',
        '2_15',
        '4_15',
        '10_15',
        '13_15') then
      raise_application_error(-20899,
                              'Неприпустима зміна візи КД(' ||
                              to_char(p_bid_id) || ') зі стану - ' ||
                              to_char(l_current_visa) || ' у стан - ' ||
                              to_char(p_visa));
    end if;

    if (p_visa = 2) then

      -- Получение acc текущего счета
      l_acc := to_number(wcs_utl.get_answ_text(p_bid_id, 'PI_CURACC_ACCNO'));
      insert into nd_acc (nd, acc) values (p_bid_id, l_acc);

      -- Регистрация обеспечения
      wcs_register.register_guarantees(p_bid_id, null);

      /* !!! Ждем обновления модуля страхования
      -- Регистрация договора страховки по клиенту
      wcs_register.register_client_insurances(p_bid_id, null);
      */

      cck.cc_sob(p_bid_id, gl.bd, null, null, null, null, null, -2);
      update cc_deal cd set cd.sos = 2 where cd.nd = p_bid_id;

      -- !!! перенести в cck.put_sos(nd,2);

    elsif p_visa = 4 then

      -- ОТКРЫТИЕ КРЕДИТНЫХ СЧЕТОВ
      -- Какие счета открывать  узнаем из доступных
      select distinct tip BULK COLLECT
        INTO m_type
        from vidd_tip
       where vidd = 11
         and tip in ('SS ', 'SN ', 'SD ', 'SDI', 'CR9');

      cck_dop.open_an_account(p_bid_id, m_type);

      -- ОТКРЫТИЕ СЧЕТОВ ОБЕСПЕЧЕНИЯ
      for t_grt in (select grt_deal_id from cc_grt where nd = p_bid_id) loop
        l_acc := grt_mgr.authorize_deal(t_grt.grt_deal_id);
      end loop;

      cck.cc_sob(p_bid_id, gl.bd, null, null, null, null, null, -4);

      update cc_deal cd set cd.sos = 4 where cd.nd = p_bid_id;
      -- !!! перенести в cck.put_sos(nd,4);
    elsif p_visa = 10 then
      update cc_deal cd set cd.sos = 10 where cd.nd = p_bid_id;
      -- !!! перенести в cck.put_sos(nd,10);
    elsif p_visa = 15 and l_current_visa < 10 then
      cck.cc_delete(p_bid_id);
      cck.cc_sob(p_bid_id, gl.bd, null, null, null, null, null, -15);
    elsif p_visa = 15 and l_current_visa > 10 then
      update cc_deal set sos = 15 where nd = p_bid_id;
      cck.cc_sob(p_bid_id, gl.bd, null, null, null, null, null, -15);

      for t_grt in (select grt_deal_id from cc_grt where nd = p_bid_id) loop
        grt_mgr.close_deal(t_grt.grt_deal_id);
      end loop;

      update cc_deal cd set cd.sos = 15 where cd.nd = p_bid_id;
      -- !!! перенести в cck.put_sos(nd,15);
      null;
    end if;
  end put_visa;

end wcs_register;
/
show err;
 
PROMPT *** Create  grants  WCS_REGISTER ***
grant EXECUTE                                                                on WCS_REGISTER    to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on WCS_REGISTER    to RCC_DEAL;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/wcs_register.sql =========*** End **
 PROMPT ===================================================================================== 
