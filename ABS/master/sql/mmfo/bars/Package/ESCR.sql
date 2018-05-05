
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/escr.sql =========*** Run *** ======
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.ESCR IS

  /*
  Бизнес-логика модуля Кредиты ФЛ на энергосбережение , слоган КОТЛЫ
  http://svn.unity-bars.com.ua:8080/svn/Products/ABSBars/Sql/_OLD/Modules/ESCR
  */
  G_HEADER_VERSION CONSTANT VARCHAR2(64) := 'ver.4.1.2 12/12/2017 Кредиты ФЛ на энергосбереж, <<КОТЛЫ>>';

  PROCEDURE p_log_header_set(id_log            in out number,
                             TOTAL_DEAL_COUNT  in escr_pay_log_header.total_deal_count%type default 0,
                             SUCCES_DEAL_COUNT in escr_pay_log_header.SUCCES_DEAL_COUNT%type default 0,
                             ERROR_DEAL_COUNT  in escr_pay_log_header.SUCCES_DEAL_COUNT%type default 0);
  PROCEDURE p_log_body_set(id_log   in escr_pay_log_header.id%type,
                           deal_id  in cc_deal.nd%type,
                           err_code in escr_errors_types.id%type,
                           comments in escr_pay_log_body.comments%type);
  procedure p_cc_lim_repair(id_log  escr_pay_log_body.id_log%type default null,
                            deal_id in cc_deal.nd%type default null);
  procedure p_deal_comp_sum(p_deal_id  cc_Deal.nd%type,
                            l_comp_sum out number);
  PROCEDURE p_ref_del(p_ref  NUMBER,
                      id_log in escr_pay_log_header.id%type default null);
  PROCEDURE oplv(p_ref  NUMBER,
                 id_log in escr_pay_log_header.id%type default null);

  procedure p_cc_lim_count(deal_id      cc_Deal.nd%type,
                           cc_lim_count out number);
  procedure p_deal_sumg(deal_id cc_Deal.nd%type, l_lim_sumg out number);
  PROCEDURE DOP(p_ref number,
                s_ND  varchar2,
                s_SD  varchar2,
                s_CD  varchar2,
                s_ID  varchar2);

  PROCEDURE pay1(flg_   SMALLINT, -- флаг оплаты
                 ref_   INTEGER, -- референция
                 vdat_  DATE, -- дата валютировния
                 tt_    CHAR, -- тип транзакции
                 dk_    NUMBER, -- признак дебет-кредит
                 kv_    SMALLINT, -- код валюты А
                 nlsm_  VARCHAR2, -- номер счета А
                 sa_    DECIMAL, -- сумма в валюте А
                 kvk_   SMALLINT, -- код валюты Б
                 nlsk_  VARCHAR2, -- номер счета Б
                 ss_    DECIMAL, -- сумма в валюте Б
                 id_log escr_pay_log_header.id%type -- номер запису в журналі виконання зарахувань
                 );

  PROCEDURE DEL1(p_ref number); -- вилучення реф з картотеки NLQ

  -----------------------------------------
  function header_version return varchar2;
  function body_version return varchar2;

end ESCR;
/
CREATE OR REPLACE PACKAGE BODY BARS.ESCR IS
  g_body_version CONSTANT VARCHAR2(64) := 'ver.4.1.8 26/01/2018';
  --nlchr CHAR(2) := chr(13) || chr(10);

  /*
  26/01/2018 Піванова додано установку статусу по КД одразу після оплати
  24/05/2017 Піванова додано формування копії ГПК до перебудови
  23/12/2016 Піванова виправлена помилка при парсінгу призначення платежу
  19.09.2016 Sta Заменила код оп 013 на PS1
  08.08.2016 Sta+Kempf SMS при зачислении на счет 2620
  25.07.2016 наглая виза + детальный комм по перестроению ГПК
  14.07.2016 Заменила NLE -> NLQ           Закомм полностью 2625           пл день в ГПК из параметоров КД
  ---------------------------------------------
  Бизнес-логика модуля Кредиты ФЛ на энергосбережение , слоган КОТЛЫ
  */
  ----------------------------------------------------------------------------------------------------------
  /*Створюємо журнал виконання зарахувань для фіксації помилок та подальшої
  їх обробки*/
  PROCEDURE p_log_header_set(id_log            in out number,
                             TOTAL_DEAL_COUNT  in escr_pay_log_header.total_deal_count%type default 0,
                             SUCCES_DEAL_COUNT in escr_pay_log_header.SUCCES_DEAL_COUNT%type default 0,
                             ERROR_DEAL_COUNT  in escr_pay_log_header.SUCCES_DEAL_COUNT%type default 0) IS
    l_TOTAL_DEAL_COUNT escr_pay_log_header.total_deal_count%type;
  BEGIN
    id_log := nvl(id_log, s_escr.nextval);
    if TOTAL_DEAL_COUNT = 0 then
      SELECT count(o.REF)
        into l_TOTAL_DEAL_COUNT
        FROM oper o, nlk_ref r, accounts a
       WHERE a.tip = 'NLQ'
         AND a.acc = r.acc
         AND r.ref2 IS NULL
         AND r.ref1 = o.REF;
    else
      l_TOTAL_DEAL_COUNT := TOTAL_DEAL_COUNT;
    end if;

    insert into escr_pay_log_header
      (id, total_deal_count, succes_deal_count, error_deal_count)
    values
      (id_log, l_TOTAL_DEAL_COUNT, SUCCES_DEAL_COUNT, ERROR_DEAL_COUNT);

    update escr_pay_log_header
       set total_deal_count  = l_TOTAL_DEAL_COUNT,
           succes_deal_count = SUCCES_DEAL_COUNT,
           error_deal_count  = ERROR_DEAL_COUNT
     where id = id_log;

  end p_log_header_set;
  PROCEDURE p_log_body_set(id_log   in escr_pay_log_header.id%type,
                           deal_id  in cc_deal.nd%type,
                           err_code in escr_errors_types.id%type,
                           comments in escr_pay_log_body.comments%type) IS
  BEGIN
    insert into escr_pay_log_body
      (id_log, deal_id, err_code, comments)
    values
      (id_log, deal_id, err_code, comments);

  END p_log_body_set;
  procedure p_cc_lim_count(deal_id      cc_Deal.nd%type,
                           cc_lim_count out number) is
  begin
    select count(t.nd)
      into cc_lim_count
      from cc_lim t
     where t.nd = deal_id;
  exception
    when no_data_found then
      cc_lim_count := 0;
  end p_cc_lim_count;

  procedure p_deal_sumg(deal_id cc_Deal.nd%type, l_lim_sumg out number) is
    l_cc_lim_count number;
  begin
    escr.p_cc_lim_count(deal_id => deal_id, cc_lim_count => l_cc_lim_count);
    if l_cc_lim_count > 2 then
      begin
        SELECT nvl(t.sumg / 100, 0)
          INTO l_lim_sumg
          FROM cc_lim t
         WHERE t.nd = deal_id
              --and fdat >= gl.bDATE
           and t.sumg <> 0
           and rownum = 1;
      exception
        when no_data_found then
          l_lim_sumg := 0;
      end;
    else
      begin
        SELECT nvl(t.sumg / 100, 0)
          INTO l_lim_sumg
          FROM cc_lim_arc t
         WHERE t.nd = deal_id
              --and fdat >= gl.bDATE
           and t.sumg <> 0
           and rownum = 1;
      exception
        when no_data_found then
          l_lim_sumg := 0;
      end;
    end if;
  end p_deal_sumg;

  procedure p_deal_comp_sum(p_deal_id  cc_Deal.nd%type,
                            l_comp_sum out number) is
    --Переписати на селект
  begin

    SELECT nvl(t.comp_sum, 0)
      INTO l_comp_sum
      FROM vw_escr_reg_header t
     WHERE t.deal_id = p_deal_id;
  exception
    when no_data_found then
      l_comp_sum := 0;
  end p_deal_comp_sum;
  procedure p_cc_lim_repair(id_log  escr_pay_log_body.id_log%type default null,
                            deal_id in cc_deal.nd%type default null) is

    p_k0                  number := 2;
    p_Z1                  number;
    p_Z2                  number;
    p_Z3                  number;
    p_Z4                  number;
    p_Z5                  number;
    p_R1                  number;
    p_R2                  number;
    p_P1                  number;
    p_P2                  number;
    p_P3                  number;
    p_K2                  number;
    aa                    accounts%rowtype;
    kv_                   int := 980;
    l_escr_pay_log_header escr_pay_log_header.id%type;
    l_lim_count_before    NUMBER;
    l_lim_count_after     NUMBER;
    l_lim_diff            NUMBER;
    l_sum_comp            NUMBER;
    l_lim_sumg            NUMBER;
  begin
    escr.p_log_header_set(id_log => l_escr_pay_log_header);
    for i in (select d.nd, a.acc
                from cc_deal d, nd_acc n, accounts a
               where d.nd in (select t.deal_id
                                from escr_pay_log_body t
                               where t.id_log = id_log
                                 and t.err_code = 24)
                 and d.nd = n.nd
                 and n.acc = a.acc
                 and a.tip = 'LIM') loop
      escr.p_cc_lim_count(deal_id      => i.nd,
                          cc_lim_count => l_lim_count_before);
      --Робимо копію ГПК до перебудови
      INSERT INTO cc_lim_copy
        (id,
         nd,
         fdat,
         lim2,
         acc,
         not_9129,
         sumg,
         sumo,
         otm,
         kf,
         sumk,
         not_sn)
        SELECT s_cck_cc_lim_copy.nextval,
               t.nd,
               t.fdat,
               t.lim2,
               t.acc,
               t.not_9129,
               t.sumg,
               t.sumo,
               t.otm,
               t.kf,
               t.sumk,
               t.not_sn
          FROM cc_lim t
         WHERE t.nd = i.nd;
      delete from cc_lim where nd = i.ND;

      insert into cc_lim
        (ND, FDAT, LIM2, ACC, NOT_9129, SUMG, SUMO, OTM, SUMK, NOT_SN)
        select ND, FDAT, LIM2, ACC, NOT_9129, SUMG, SUMO, OTM, SUMK, NOT_SN
          from cc_lim_arc
         where nd = i.nd
           and mdat = (select max(mdat)
                         from cc_lim_arc
                        where nd = i.ND
                          and typm is not null);
      delete from cc_lim_arc t
       where nd = i.ND
         and mdat = (select max(mdat)
                       from cc_lim_arc
                      where nd = i.ND
                        and typm is not null)
         and t.typm is not null;
      select s
        into p_k2
        from int_accn
       where acc = i.acc
         and id = 0;

      select *
        into aa
        from accounts
       where kv = KV_
         and nbs = '2620'
         and dazs is null
         and acc in (select acc from nd_acc where nd = i.ND)
         and rownum = 1;
      escr.p_deal_sumg(deal_id => i.nd, l_lim_sumg => l_lim_sumg);
      CCK_dpk.DPK(p_mode    => 2, -- IN  int   , -- 0 - справка, 1 - досрочное пог.+модификация ГПК (121) , 2 - только модификация ГПК (122)
                  p_ND      => i.nd, -- IN  number, -- реф КД
                  p_acc2620 => aa.acc, -- IN  number, -- счет гашения (2620) ----/2625/SG)
                  p_K0      => p_k0, -- IN OUT number, -- 1-Ануитет. 0 - Класс
                  p_K1      => 0, -- IN     number, -- <Сумма для досрочного пог>, по умолч = R2,
                  p_K2      => p_k2, -- IN     number, -- <Платежный день>, по умол = DD от текущего банк.дня
                  p_K3      => 1, -- IN     number, -- 1=ДА ,<с сохранением суммы одного платежа?>, 2=НЕТ (с перерасчетом суммы до последней ненулевой даты)
                  p_Z1      => p_Z1, --OUT number, -- Просрочки z1 =SLN+SLK+SL+SPN+SK9+SP+SN8
                  p_Z2      => p_Z2, --OUT number, -- Норм.проценты и комис z2 =SN+SN`+SK0
                  p_Z3      => p_Z3, --OUT number, -- <Сегодняшний> или БЛИЖАЙШИЙ (будущий, следующий) платеж по телу
                  p_Z4      => p_Z4, --OUT number, --ИТОГО  обязательного платежа = z4 =  z1 + z2 + z3
                  p_Z5      => p_Z5, --OUT number, -- Плановый остаток по телу  z5 = (SS - z3)
                  p_R1      => p_R1, --OUT number, -- Общий ресурс (ост на SG(262*)
                  p_R2      => p_R2, --OUT number, --  Свободный ресурс R2 =  R1 - z4
                  p_P1      => p_P1  --OUT number  --  Реф.платежа
                  );
      escr.p_cc_lim_count(deal_id      => i.nd,
                          cc_lim_count => l_lim_count_after);
      escr.p_deal_comp_sum(p_deal_id => i.nd, l_comp_sum => l_sum_comp);
      l_lim_diff := TRUNC(l_sum_comp / l_lim_sumg, 0);

      /*if abs (l_lim_count_before - l_lim_count_after) < 2 then--допрцювати умову*/

      escr.p_log_body_set(id_log   => l_escr_pay_log_header,
                          deal_id  => i.nd,
                          err_code => 24,
                          comments => 'Кількість платіжних періодів до та після виконання перебудови різняться на недопустиме значення ' ||
                                      'к-сть записів в ГПК до l_lim_count_before=' ||
                                      l_lim_count_before ||
                                      ', після l_lim_count_after=' ||
                                      l_lim_count_after ||
                                      ', розрахована різниця l_lim_diff=' ||
                                      l_lim_diff ||
                                      ',сума компенсаці l_sum_comp:=' ||
                                      l_sum_comp ||
                                      ',сума щомісячного погашення  l_lim_sumg:=' ||
                                      l_lim_sumg);
      /*end if;*/
    end loop;

  end p_cc_lim_repair;
  -------------------------------------
  PROCEDURE p_ref_del(p_ref  NUMBER,
                      id_log in escr_pay_log_header.id%type default null) IS
  BEGIN
    delete from bars.nlk_ref t where t.ref1 = p_ref;
    bars.bars_audit.info('Delete from nlk_ref ref1:=' || p_ref);
    --Додати логування в журнали

  END p_ref_del;
  ---------------------
  PROCEDURE oplv(p_ref  NUMBER,
                 id_log in escr_pay_log_header.id%type default null) IS
  BEGIN
    --Очищаємо картотеку від записів попередніх місяців, якщо попередньо користувачі не вичистили непотрібні записи
    for c in (SELECT o.REF
                FROM bars.oper o, bars.nlk_ref r, bars.accounts a
               WHERE a.tip = 'NLQ'
                 AND a.acc = r.acc
                 AND r.ref2 IS NULL
                 AND r.ref1 = o.REF
                 and extract(month from o.vdat) <> extract(month from gl.bd)) loop
      delete from bars.nlk_ref t where t.ref1 = c.ref;

      bars.bars_audit.info('Delete from nlk_ref ref1:=' || c.ref);
    end loop;
    --Додано умову, що виконання зарахування можливе лише місяць в місяць
    FOR k IN (SELECT o.*
                FROM oper o, nlk_ref r, accounts a
               WHERE a.tip = 'NLQ'
                 AND a.acc = r.acc
                 AND r.ref2 IS NULL
                 AND r.ref1 = o.ref
                 AND (p_ref = 0 OR
                     p_ref = o.ref and
                     extract(month from o.vdat) = extract(month from gl.bd))) LOOP
      escr.pay1(0,
                k.ref,
                gl.bdate,
                'PS1',
                1,
                k.kv,
                k.nlsb,
                k.s,
                k.kv,
                k.nlsb,
                k.s,
                id_log);
    END LOOP;
  END oplv;
  ----------------------------------------------------------------------------------------------------------
  PROCEDURE dop(p_ref NUMBER,
                s_nd  VARCHAR2,
                s_sd  VARCHAR2,
                s_cd  VARCHAR2,
                s_id  VARCHAR2) IS
  BEGIN
    set_operw(p_ref, 'ND   ', s_nd);
    set_operw(p_ref, 'DAT1 ', s_sd);
    set_operw(p_ref, 'CC_ID', s_cd);
    set_operw(p_ref, 'IDB  ', s_id);
    COMMIT;
    escr.oplv(p_ref, null);
  END dop;
  ----------------------------------------------------------------------------------------------------------
   PROCEDURE pay1(flg_   SMALLINT, -- флаг оплаты
                 ref_   INTEGER, -- референция
                 vdat_  DATE, -- дата валютировния
                 tt_    CHAR, -- тип транзакции
                 dk_    NUMBER, -- признак дебет-кредит
                 kv_    SMALLINT, -- код валюты А
                 nlsm_  VARCHAR2, -- номер счета А
                 sa_    DECIMAL, -- сумма в валюте А
                 kvk_   SMALLINT, -- код валюты Б
                 nlsk_  VARCHAR2, -- номер счета Б
                 ss_    DECIMAL, -- сумма в валюте Б
                 id_log escr_pay_log_header.id%type -- номер запису в журналі виконання зарахувань
                 ) IS
    dd       cc_deal%ROWTYPE;
    aa       accounts%ROWTYPE;
    oo       oper%ROWTYPE;
    --nls_2924 accounts.nls%TYPE;
    n_ss     NUMBER := 0;
    l_acc8   NUMBER;
    ntmp_    NUMBER;
    --stmp_    VARCHAR2(5);
    nazn_    VARCHAR2(160);
    i_       INT;
    l_txt    VARCHAR2(70) := NULL;

    l_tx1 VARCHAR2(70) := 'Неможливо вичленити реф КД з признач.платежу';
    l_tx2 VARCHAR2(70) := 'Дата КД*';
    l_tx3 VARCHAR2(70) := '№ КД*';
    l_tx4 VARCHAR2(70) := 'Перевірте вид КД*'; --вид КД може бути лише Стандарт (11)
    l_tx5 VARCHAR2(70) := 'Ід.код*';
    l_tx6 VARCHAR2(70) := 'р.2620*';
    l_tx7 VARCHAR2(70) := '->2620*';
    l_tx8 VARCHAR2(70) := '->220*';
    l_tx9 VARCHAR2(70) := '! ГПК*';
    --------------------
    code_   NUMBER;
    erm_    VARCHAR2(2048);
    tmp_    VARCHAR2(2048);
    status_ VARCHAR2(10);
    l_recid NUMBER;
    ------------------------------------------------
    s_nd VARCHAR2(255);
    s_sd VARCHAR2(255);
    s_cd VARCHAR2(255);
    s_id VARCHAR2(255);
    -----------------------------------------------
    i_ost   NUMBER;
    v_ost   NUMBER;
    fdat_   DATE; ----------------------- Перестроить ГПК, без досрочного погашения.
    p_k0    NUMBER := 2; --лише перебудова ГПК без дострокового погашення
    p_z1    NUMBER;
    p_z2    NUMBER;
    p_z3    NUMBER;
    p_z4    NUMBER;
    p_z5    NUMBER;
    p_r1    NUMBER;
    p_r2    NUMBER;
    p_p1    NUMBER;
    p_p2    NUMBER;
    p_p3    NUMBER;
    p_k2    NUMBER;
    phone_  acc_sms_phones.phone%TYPE;
    l_msgid INTEGER;
    l_count NUMBER;
    l_nazn  NUMBER;
    ---------------------------------------
    l_lim_count_before NUMBER;
    l_lim_count_after  NUMBER;
    l_lim_sumg         cc_lim.sumg%type;
    l_lim_diff         NUMBER;
    --l_sum_comp         NUMBER;
  BEGIN

    BEGIN
      SELECT * INTO oo FROM oper WHERE REF = ref_;
    EXCEPTION
      WHEN no_data_found THEN
        raise_application_error(-20203,
                                '\9517 - ESCR.Не знайдено Вх.ВПС-док');
    END;
    ---------------------------------------
    s_nd := substr(f_dop(ref_, 'ND'), 1, 12);
    s_sd := substr(f_dop(ref_, 'DAT1'), 1, 10);
    s_cd := substr(f_dop(ref_, 'CC_ID'), 1, 30);
    s_id := substr(f_dop(ref_, 'IDB'), 1, 14);
   -- bars.bars_audit.info('ESCR.PAY1 p_ref=' || ref_||',s_nd= '||s_nd||',s_sd= '||s_sd||',s_cd= '||s_cd||',s_id= '||s_id);
    IF s_cd IS NULL OR s_sd IS NULL THEN
      nazn_ := oo.nazn;
      BEGIN
        SELECT regexp_count(oo.nazn, ';') INTO l_count FROM dual;
      END;
      BEGIN
        WITH txt AS
         (SELECT substr(nazn_, 1, instr(nazn_, ';', 1, 1) - 1) AS text
            FROM dual)
        SELECT COUNT(*)
          INTO l_nazn
          FROM txt
         WHERE NOT regexp_like(txt.text, '^(\d+)([.,]?)(\d*)$');
      END;
      IF l_nazn = 0 AND l_count = 5 THEN
        i_    := instr(nazn_, ';', 1);
        s_nd  := substr(nazn_, 1, i_ - 1);
        nazn_ := substr(nazn_, i_ + 1, 160);
        s_sd  := substr(nazn_, 1, 10);
        nazn_ := substr(nazn_, 12, 160);
        i_    := instr(nazn_, ';', 1);
        s_cd  := substr(nazn_, 1, i_ - 1);
        nazn_ := substr(nazn_, i_ + 1, 160);
        i_    := instr(nazn_, ';', 1);
        s_id  := substr(nazn_, 1, i_ - 1);
        set_operw(ref_, 'ND   ', s_nd);
        set_operw(ref_, 'DAT1 ', s_sd);
        set_operw(ref_, 'CC_ID', s_cd);
        set_operw(ref_, 'IDB  ', s_id);
      END IF;

      IF l_nazn <> 0  or L_nazn=0 and l_count<>5  THEN
        i_    := instr(nazn_, ';', 1, 1);
        nazn_ := substr(nazn_, i_ + 1, 160);

        IF l_count = 6 THEN
          i_    := instr(nazn_, ';', 1);
          s_nd  := substr(nazn_, 1, i_ - 1);
          nazn_ := substr(nazn_, i_ + 1, 160);
          s_sd  := substr(nazn_, 1, 10);
          nazn_ := substr(nazn_, 12, 160);
          i_    := instr(nazn_, ';', 1);
          s_cd  := substr(nazn_, 1, i_ - 1);
          nazn_ := substr(nazn_, i_ + 1, 160);
          i_    := instr(nazn_, ';', 1);
          s_id  := substr(nazn_, 1, i_ - 1);
          set_operw(ref_, 'ND   ', s_nd);
          set_operw(ref_, 'DAT1 ', s_sd);
          set_operw(ref_, 'CC_ID', s_cd);
          set_operw(ref_, 'IDB  ', s_id);
        ELSIF l_count = 5 THEN
          i_    := instr(nazn_, ';', 1);
          s_nd  := substr(nazn_, 1, i_ - 1);
          nazn_ := substr(nazn_, i_ + 1, 160);
          s_sd  := substr(nazn_, 1, 10);
          nazn_ := substr(nazn_, 12, 160);
          i_    := instr(nazn_, ';', 1);
          s_cd  := substr(nazn_, 1, i_ - 1);
          --nazn_ := substr(nazn_, i_ + 1, 160);
          --i_    := instr(nazn_, ';', 1);
          -- s_id  := substr(nazn_, 1, i_ - 1);
          s_id := '';
          set_operw(ref_, 'ND   ', s_nd);
          set_operw(ref_, 'DAT1 ', s_sd);
          set_operw(ref_, 'CC_ID', s_cd);
          set_operw(ref_, 'IDB  ', s_id);
        END IF;
      END IF;
    END IF;
    BEGIN
      dd.nd := to_number(s_nd);
    EXCEPTION
      WHEN OTHERS THEN
        l_txt := l_tx1;
        GOTO no_pay;
    END;
    BEGIN
      dd.sdate := to_date(s_sd, 'dd/mm/yyyy');
    EXCEPTION
      WHEN OTHERS THEN
        l_txt := l_tx2;
        GOTO no_pay;
    END;
    dd.cc_id := s_cd;
    BEGIN
      dd.nd := to_number(s_nd);
    EXCEPTION
      WHEN OTHERS THEN
        l_txt := l_tx1;
        GOTO no_pay;
    END;
    BEGIN
      dd.sdate := to_date(s_sd, 'dd/mm/yyyy');
    EXCEPTION
      WHEN OTHERS THEN
        l_txt := l_tx2;
        GOTO no_pay;
    END;
    IF length(dd.cc_id) = 0 THEN
      l_txt := l_tx3;
      GOTO no_pay;
    END IF;
    oo.id_b := s_id;

    BEGIN
      SELECT *
        INTO dd
        FROM (SELECT *
                FROM cc_deal
               WHERE vidd = 11
                 AND sos > 0
                 AND (nd = dd.nd OR sdate = dd.sdate AND cc_id = dd.cc_id)
               ORDER BY sos)
       WHERE rownum = 1;
    EXCEPTION
      WHEN no_data_found THEN
        l_txt := l_tx4;
        GOTO no_pay;
    END;

    IF length(TRIM(oo.id_b)) > 0 THEN
      BEGIN
        SELECT 1
          INTO ntmp_
          FROM customer
         WHERE rnk = dd.rnk
           AND okpo = oo.id_b;
      EXCEPTION
        WHEN no_data_found THEN
          l_txt := l_tx5;
          GOTO no_pay;
      END;
    END IF;

    BEGIN
      SELECT *
        INTO aa
        FROM accounts
       WHERE kv = kv_
         AND nbs = '2620'
         AND dazs IS NULL
         AND acc IN (SELECT acc FROM nd_acc WHERE nd = dd.nd)
         AND rownum = 1;
    EXCEPTION
      WHEN no_data_found THEN
        l_txt := l_tx6;
        GOTO no_pay;
    END;
    l_txt := NULL;
    -------------------------------------------------------------------------------------------------------------------

    SAVEPOINT do_opl;
    Declare
      Dat20_    date := to_date('20.11.2017', 'dd.mm.yyyy');
      sa1_      DECIMAL := SA_; -- Поступившая сумма возмещения для зачисления на 2600
      sa2_      DECIMAL := 0; -- Поступившая сумма возмещения для Возврата в ЦА
      l_REF_RET number;
    BEGIN
      ----------------------------------------------------------------------- зачислить всю сумму на 2620
      l_txt := l_tx7;

/* VPogoda 
   -	Перевірку дати укладення кредитних договорів та суми залишку заборгованості – НЕ здійснювати  ( …If dd.sdate >= Dat20_);
*/   
      -- 23.11.2017 Повернення надлишкових сум  COBUMMFO-5548  - ESCR.
--      If dd.sdate >= Dat20_ then
        -------- дати укладення Кредитних договорів – до 19/11/2017 ВКЛЮЧНО (<20),  та після 20.11.2017р ВКЛЮЧНО.(>=20)
        select LEAST(SA_, -a.ostc)
          into SA1_
          from accounts a, nd_acc n
         where n.nd = dd.ND
           and n.acc = a.acc
           and a.tip = 'LIM';
        SA2_ := SA_ - SA1_;
--      end if;

/*      If SA2_ > 0 then
        oo.tt := case
                   when oo.mfoa = oo.mfob then
                    'PS1'
                   else
                    'PS2'
                 end;
        gl.ref(l_REF_RET);
        gl.in_doc3(ref_   => l_REF_RET,
                   tt_    => oo.tt,
                   vob_   => 6,
                   nd_    => oo.nd,
                   pdat_  => SYSDATE,
                   vdat_  => gl.BDATE,
                   dk_    => 1,
                   kv_    => oo.kv,
                   s_     => SA2_,
                   kv2_   => oo.kv2,
                   s2_    => SA2_,
                   sk_    => null,
                   data_  => oo.datd,
                   datp_  => gl.bdate,
                   nam_a_ => oo.nam_b,
                   nlsa_  => oo.nlsb,
                   mfoa_  => gl.aMfo,
                   nam_b_ => oo.nam_a,
                   nlsb_  => oo.nlsa, -- 37393000980030
                   mfob_  => oo.mfoa,
                   nazn_  => Substr('ПОВЕРНЕННЯ ' || oo.nazn,
                                    1,
                                    160),
                   d_rec_ => oo.d_rec,
                   id_a_  => oo.id_b,
                   id_b_  => oo.id_a,
                   id_o_  => null,
                   sign_  => null,
                   sos_   => 1,
                   prty_  => null,
                   uid_   => null);

        paytt(0,
              l_REF_RET,
              gl.bDATE,
              oo.TT,
              1,
              oo.kv,
              oo.nlsb,
              SA2_,
              oo.kv2,
              oo.nlsa,
              SA2_);
      end if;*/

      --- Зарахувати на 2625 ---------------------------
      If sa_ > 0 then
        gl.payv(flg_,
                ref_,
                vdat_,
                tt_,
                1,
                kv_,
                nlsm_,
                sa_,
                kv_,
                aa.nls,
                sa1_); -------------3739_05 ---> 2620
         gl.pay(2, ref_, vdat_);
         bars_audit.info('ESCR PAY1 По КД '||dd.nd ||' ,сума компенсації рівна '|| sa_);
      elsif sa_=0 then
         DELETE FROM nlk_ref WHERE ref1 = ref_;
         bars_audit.info('ESCR PAY1 По КД '||dd.nd ||' ,сума компенсації рівна 0. Запис з референсом '||ref_ ||' видалено з картотеки.');
      else
        RETURN;
      end if;
      -------------------------------------------------------------------------------------------------------------------
      DELETE FROM nlk_ref WHERE ref1 = ref_;

      IF dd.sos >= 14 THEN
        RETURN;
      END IF;

      l_txt   := l_tx8;
      aa.ostc := sa1_;
      n_ss    := 0; ------------2620 ---> 2203
      FOR kk IN (SELECT *
                   FROM accounts
                  WHERE kv = kv_
                    AND tip IN ('SP ', 'SS ')
                    AND ostc < 0
                    AND acc IN (SELECT acc FROM nd_acc WHERE nd = dd.nd)
                  ORDER BY tip) LOOP
        --- сумма к погашениею = меньшее из 2-х (сколько надо и сколько есть)
        oo.s := least(-kk.ostc, aa.ostc);
        IF oo.s > 0 THEN
          l_acc8 := kk.accc;
          IF kk.tip = 'SS ' THEN
            n_ss := n_ss + oo.s;
          END IF;
          gl.payv(flg_,
                  ref_,
                  vdat_,
                  tt_,
                  1,
                  kv_,
                  aa.nls,
                  oo.s,
                  kv_,
                  kk.nls,
                  oo.s);
        END IF;
        aa.ostc := aa.ostc - oo.s;
      END LOOP;
      gl.pay(2, ref_, vdat_);

      --- Перестроить ГПК, без досрочного погашения.
      IF n_ss > 0 AND l_acc8 > 0 THEN
        l_txt := l_tx9;
        SELECT ostc,- (ostc - kos + dos)
          INTO i_ost, v_ost
          FROM accounts
         WHERE acc = l_acc8;

        IF i_ost = 0 THEN
          ------------------------------------------------------------------- тело погашено полностью
          UPDATE cc_lim
             SET sumg = v_ost, lim2 = 0
           WHERE nd = dd.nd
             AND fdat = gl.bdate;
          IF SQL%ROWCOUNT = 0 THEN
            INSERT INTO cc_lim
              (nd, fdat, acc, lim2, sumg, sumo, sumk)
            VALUES
              (dd.nd, gl.bdate, l_acc8, 0, v_ost, v_ost, 0);
          END IF;
          SELECT MIN(fdat)
            INTO fdat_
            FROM cc_lim
           WHERE nd = dd.nd
             AND fdat > gl.bdate;
          DELETE FROM cc_lim
           WHERE nd = dd.nd
             AND fdat > fdat_;
          UPDATE cc_lim
             SET lim2 = 0, sumg = 0
           WHERE nd = dd.nd
             AND fdat = fdat_;
          UPDATE accounts SET ostx = 0 WHERE acc = l_acc8;
          UPDATE cc_deal SET LIMIT = 0, wdate = fdat_ WHERE nd = dd.nd;
          UPDATE cc_add
             SET s = 0
           WHERE nd = dd.nd
             AND adds = 0;
        ELSE
          ------------p_K2 := CCK_DPK.Day_PL(dd.nd) ; --------------------------------------  nMode = 122 Просто Перебудова ГПК
          -- Визначаємо к-сть записів в ГПК до перебудови та суму щомісячного погашення тіла

          escr.p_cc_lim_count(deal_id      => dd.nd,
                              cc_lim_count => l_lim_count_before);

          escr.p_deal_sumg(deal_id => dd.nd, l_lim_sumg => l_lim_sumg);

          SELECT s
            INTO p_k2
            FROM int_accn
           WHERE acc = l_acc8
             AND id = 0;
          /* --Робимо копію ГПК до перебудови
          INSERT INTO cc_lim_copy
            (id
            ,nd
            ,fdat
            ,lim2
            ,acc
            ,not_9129
            ,sumg
            ,sumo
            ,otm
            ,kf
            ,sumk
            ,not_sn)
            SELECT s_cck_cc_lim_copy.nextval
                  ,t.nd
                  ,t.fdat
                  ,t.lim2
                  ,t.acc
                  ,t.not_9129
                  ,t.sumg
                  ,t.sumo
                  ,t.otm
                  ,t.kf
                  ,t.sumk
                  ,t.not_sn
              FROM cc_lim t
             WHERE t.nd = dd.nd;*/
          cck_dpk.dpk(p_mode    => 2, -- IN  int   , -- 0 - справка, 1 - досрочное пог.+модификация ГПК (121) , 2 - только модификация ГПК (122)
                      p_nd      => dd.nd, -- IN  number, -- реф КД
                      p_acc2620 => aa.acc, -- IN  number, -- счет гашения (2620) ----/2625/SG)
                      p_k0      => p_k0, -- IN OUT number, -- 1-Ануитет. 0 - Класс
                      p_k1      => 0, -- IN     number, -- <Сумма для досрочного пог>, по умолч = R2,
                      p_k2      => p_k2, -- IN     number, -- <Платежный день>, по умол = DD от текущего банк.дня
                      p_k3      => 1, -- IN     number, -- 1=ДА ,<с сохранением суммы одного платежа?>, 2=НЕТ (с перерасчетом суммы до последней ненулевой даты)
                      p_z1      => p_z1, --OUT number, -- Просрочки z1 =SLN+SLK+SL+SPN+SK9+SP+SN8
                      p_z2      => p_z2, --OUT number, -- Норм.проценты и комис z2 =SN+SN`+SK0
                      p_z3      => p_z3, --OUT number, -- <Сегодняшний> или БЛИЖАЙШИЙ (будущий, следующий) платеж по телу
                      p_z4      => p_z4, --OUT number, --ИТОГО  обязательного платежа = z4 =  z1 + z2 + z3
                      p_z5      => p_z5, --OUT number, -- Плановый остаток по телу  z5 = (SS - z3)
                      p_r1      => p_r1, --OUT number, -- Общий ресурс (ост на SG(262*)
                      p_r2      => p_r2, --OUT number, --  Свободный ресурс R2 =  R1 - z4
                      p_p1      => p_p1 --OUT number  --  Реф.платежа
                      );
          escr.p_cc_lim_count(deal_id      => dd.nd,
                              cc_lim_count => l_lim_count_after);

          --Визначаємо орієнтовну к-сть періодів, на яку повинен зменшшитися ГПК після перебудови
          l_lim_diff := TRUNC((oo.s / 100) / l_lim_sumg, 0);
          if abs(l_lim_diff - (l_lim_count_before - l_lim_count_after)) > 1 then

            escr.p_log_body_set(id_log   => id_log,
                                deal_id  => dd.nd,
                                err_code => 24,
                                comments => 'Кількість платіжних періодів до та після виконання перебудови різняться на недопустиме значення ' ||
                                            'к-сть записів в ГПК до l_lim_count_before=' ||
                                            l_lim_count_before ||
                                            ', після l_lim_count_after=' ||
                                            l_lim_count_after ||
                                            ', розрахована різниця l_lim_diff=' ||
                                            l_lim_diff ||
                                            ',сума компенсаці l_sum_comp:=' ||
                                            oo.s / 100 ||
                                            ',сума щомісячного погашення  l_lim_sumg:=' ||
                                            l_lim_sumg);

          end if;
        END IF;
      END IF;
      l_txt := NULL;
      GOTO no_pay;
    EXCEPTION
      WHEN OTHERS THEN
        ROLLBACK TO do_opl;
        bars_audit.error(p_msg     => 'ESCR-err*' || SQLERRM,
                         p_module  => NULL,
                         p_machine => NULL,
                         p_recid   => l_recid);
        deb.trap(SQLERRM, code_, erm_, status_);
        IF code_ <= -20000 THEN
          bars_error.get_error_info(SQLERRM, erm_, tmp_, tmp_);
        END IF;
        l_txt := substr(l_txt || l_recid || '*' || erm_, 1, 70);
        GOTO no_pay;
    END;
    -----------------------------------------------------
    <<no_pay>>
    NULL;
    bars_audit.info('ESCR-inf* NP ' || aa.acc || ';' || l_txt || ';');
    IF l_txt IS NOT NULL THEN
      -- есть проблемы
      UPDATE opldok SET txt = l_txt WHERE REF = ref_;
    ELSE
      BEGIN
        SELECT phone INTO phone_ FROM acc_sms_phones WHERE acc = aa.acc; --ищем телефон по счету 2620
        bars_audit.info('ESCR-inf* SM ' || aa.acc || ';' || phone_ || ';');
        bars_sms.create_msg(p_msgid           => l_msgid,
                            p_creation_time   => SYSDATE,
                            p_expiration_time => SYSDATE + 1,
                            p_phone           => phone_,
                            p_encode          => 'lat',
                            p_msg_text        => 'Vam zarahovano vidshkoduvannja za teplim creditom.<\n>Data ' ||
                                                 to_char(SYSDATE,
                                                         'DD.MM.YYYY') ||
                                                 '. Dovidka 0800210800',
																								  p_kf              =>sys_context('bars_context','user_mfo'));
        --l_msgid := NULL;
        --phone_  := NULL; -- освобождаем переменную
      EXCEPTION
        WHEN no_data_found THEN
          NULL;
      END;
     -- По КД проставляємо статус "Оплачено"
      cck_app.set_nd_txt(dd.nd, 'ES000', 11);
      cck_app.set_nd_txt(dd.nd, 'ES005', 'Кошти зараховано');
      cck_app.set_nd_txt(dd.nd, 'ES006', sysdate);
      cck_app.set_nd_txt(dd.nd, 'ES007', 'Кошти зараховано по документу з реф = '||ref_);
    END IF;

    RETURN;

  END pay1;

  PROCEDURE del1(p_ref NUMBER) IS -- вилучення реф з картотеки NLQ в звязку з ручним обробленням
  BEGIN
    DELETE FROM nlk_ref WHERE ref1 = p_ref;
  END del1;
  -----------------------------------------------------------------------------------
  FUNCTION header_version RETURN VARCHAR2 IS
  BEGIN
    RETURN 'Package header ESCR ' || g_header_version;
  END header_version;
  FUNCTION body_version RETURN VARCHAR2 IS
  BEGIN
    RETURN 'Package body ESCR ' || g_body_version;
  END body_version;
  ---Аномимный блок --------------
BEGIN
  NULL;
END escr;
/
 show err;
 
PROMPT *** Create  grants  ESCR ***
grant EXECUTE                                                                on ESCR            to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/escr.sql =========*** End *** ======
 PROMPT ===================================================================================== 
 