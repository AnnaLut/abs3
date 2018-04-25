
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/cck_ui.sql =========*** Run *** ====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.CCK_UI IS

  g_header_version CONSTANT VARCHAR2(64) := 'ver.3.1. 20.07.2017';
/*
  20.07.2016 Sta COBUMMFO-4088  розділення  PROCEDURE trs_upd   та об'єднання траншів  PROCEDURE trs_add
  20.06.2017 LSO acc_add добавлен OB22 если приходит из формы то проставляем с проверкой
*/

  PROCEDURE pass_dop
  (
    p_tag VARCHAR2
   ,p_txt VARCHAR2
  );
  --------------------------------------------------------
 --Зміна призначення платежу при нарахуванні % в портфелі ССKF i CCKU
  PROCEDURE p_int_reckoning_nazn_edit
  (
    int_id  NUMBER
   ,deal_id NUMBER
   ,p_nazn  VARCHAR2
  );
   PROCEDURE p_cc_lim_repair
  (
    p_id cc_lim_copy_header.id%TYPE
   /*,p_nd cc_deal.nd%TYPE*/
  ) ;
  /*Зміна суми платежу при нарахуванні % в портфелі CCKU (лише по одному клієнту)
  Постійно виникає розбіжність в сумах за рахунок заокруглень
  */
  PROCEDURE p_int_reckoning_summ_edit
  (
    int_id  NUMBER
   ,deal_id NUMBER
   ,p_summ  NUMBER --дельта на яку вирівнюємо
  ) ;
  procedure p_cc_lim_copy (p_nd cc_deal.nd%type,
                    p_comments cc_lim_copy_header.comments%type default null);
 -- Перен на прост. %% згідно ДНЯ і ТИПУ погаш -- вырезать из CCK_SBER 4
  PROCEDURE aspn_sber(p_dat DATE);

  -- Начисление процентов в КП (можно добавить др по cc_deal)
  PROCEDURE cck_interest(p_dat2 DATE);

  PROCEDURE sob(p_mode NUMBER
               , -- 1 - Insert
                -- 2 - Update
                -- 0 - Delete
                p_nd       NUMBER
               ,p_id       NUMBER
               ,p_fdat     DATE
               ,p_fact_dat DATE
               ,p_txt      VARCHAR2
               ,p_otm      INT
               ,p_freq     INT
               ,p_sys      INT);

  ---- получение прогноз- № счета
  FUNCTION na_nls
  (
    x_nls  VARCHAR2
   ,x_acc8 NUMBER
   ,x_tip  VARCHAR2
   ,x_prod VARCHAR2
  ) RETURN VARCHAR2;

  ---- получение урл для допустимой операции
  FUNCTION url_tip
  (
    x_sos   INT
   ,x_dazs  DATE
   ,x_nd    NUMBER
   ,x_cc_id VARCHAR2
   ,x_sdate DATE
   ,x_tip   VARCHAR2
   ,x_nls   VARCHAR2
   ,x_kv    INT
   ,x_lim   NUMBER
   ,x_ostc  NUMBER
   ,x_mfob  VARCHAR2
   ,x_nlsb  VARCHAR2
   ,x_okpo  VARCHAR2
   ,x_nmk   VARCHAR2
  ) RETURN VARCHAR2;

  -- получение семантического названия доп.рекц по таблице допустимых значений
  FUNCTION dop_sem
  (
    p_txt VARCHAR2
   ,p_tab VARCHAR2
   ,p_sk  VARCHAR2
   ,p_fk  VARCHAR2
  ) RETURN VARCHAR2;

  ----Авторизация КД ---------------------------------------------------------------------
  PROCEDURE autor
  (
    p_nd   NUMBER
   ,p_mode NUMBER
   ,p_x1   VARCHAR2
   ,p_x2   VARCHAR2
  ); -- авторизация

  --График Погашения Кредита (ГПК)
  PROCEDURE gpk_upd
  (
    p_mode NUMBER
   , ---     0 - INS, 1-UDD, 2 -DEL
    p_nd   NUMBER
   , --Реф КД
    p_fdat DATE
   , --Плат.дата или Дата изм.лимита
    p_9129 NUMBER
   , --Не менять 9129
    p_sumg NUMBER
   , --План-сумма гашения осн.долга
    p_sumo NUMBER
   , --Общая План-Сумма гашения
    p_sumk NUMBER
   , --План-Сумма гашения комиссии
    p_sn   NUMBER --1= В занную дату Не платить нач.доходы (% и комиссию)
  );
  ---- OTM    INTEGER,               --Отметка о ПОЛНОСТЬЮ загашенном платеже
  ---- KF        VARCHAR2(6 BYTE)    --DEFAULT sys_context('bars_context','user_mfo')
  ---  LIM2   NUMBER(38),            --Сумма нового лимита
  ---  ACC    INTEGER,               --Сч 8999

  --  он же График Лимитов Кредитования (ГЛК)
  PROCEDURE glk_upd
  (
    p_mode     NUMBER
   , ---     0 - INS, 1-UDD, 2 -DEL
    p_nd       NUMBER
   , --Реф КД
    p_fdat     DATE
   , --Плат.дата или Дата изм.лимита
    p_lim2     NUMBER
   , --План-сумма ИСХОД лимита
    p_d9129    NUMBER
   , --Поточна~Дельта~ для 9129
    p_daysn    NUMBER
    --
    ,p_upd_flag NUMBER
    ,p_not_9129 number default null
  );
  -- Стартове переформування таблиці траншів по КД p_ND (від дати відкриття рахунку боргу)
  PROCEDURE trs0(p_nd NUMBER);
  --Процедура коригування суми щомісячного платежу (наприклад маємо 1333 грн, а втсановлюмо 1300,різниця падає на останній місяцб
  PROCEDURE gpk_sumg_bal
  (
    p_nd       cc_deal.nd%TYPE
   ,p_sumg_new cc_lim.lim2%TYPE
  );

--ручная модификация траншей: Редагування або Відокремлення траншу (створення нового підтраншу)
  PROCEDURE trs_upd
  ( p_id     NUMBER, --Ид траншу
    p_sv1    NUMBER,
    p_dplan  DATE  ,
    p_dplan1 DATE  ,
    p_sz     NUMBER,
    p_sz1    NUMBER,
    p_comm   VARCHAR2  ) ;

--ручная модификация траншей : Об`єднати однорідні ВИДІЛЕНІ транші
  PROCEDURE trs_ADD  ( p_Id number) ;  -- Ид траншу

 ----------------------

 PROCEDURE p_interest_cck
  (
   p_type    IN NUMBER DEFAULT 0,
   P_MODE    IN NUMBER,
   p_date_to IN DATE default  gl.bd
  ) ;
  -----------------------
  PROCEDURE gpk_bild
  (
    p_nd      NUMBER
   ,p_mode    NUMBER
   ,p_dat_beg DATE
   ,p_dat_pl1 DATE
   ,p_dat_end DATE
   ,p_sumr    NUMBER
  ); --- балансировка тела
  -----------------------
  PROCEDURE gpk_bal
  (
    p_nd      NUMBER
   ,p_dat_beg DATE default gl.bd
   ,p_mode    NUMBER default null
  ); --- балансировка тела
  PROCEDURE glk_bal
  (
    p_nd      NUMBER
   ,p_dat_beg DATE  default gl.bD

  ); --- балансировка лимита
  PROCEDURE gpk_prc
  (
    p_nd   NUMBER
   ,p_mode NUMBER
  ); --- пересчет процентов
  ------------------
  PROCEDURE p_cck_interest
(
  p_type    IN NUMBER DEFAULT 0
 ,p_date_to IN DATE default gl.bDATE
 ,p_mode   in number default 0
);
  PROCEDURE acc_del
  (
    p_nd  NUMBER
   ,p_acc NUMBER
   ,p_tip VARCHAR2
  );
  PROCEDURE acc_add
  (
    p_nd   NUMBER
   ,p_acc  NUMBER
   ,p_nls  VARCHAR2
   ,p_tip  VARCHAR2
   ,p_kv   INT
   ,p_opn  NUMBER
   ,p_ob22 VARCHAR2 DEFAULT NULL
  );
  PROCEDURE p9129(p_nd NUMBER); -- Актуализація ліміту КД на вимогу (9129)
  PROCEDURE cls(p_nd NUMBER); ---- закрыть КД
  PROCEDURE viza2(p_nd NUMBER); ---- виза бух на КД
  PROCEDURE rel_nls
  (
    p_nd  NUMBER
   ,p_nls VARCHAR
   ,p_kv  INT
  ); ---- U) Установити зв`язок довільного рах. з КД
  -----------------------
  PROCEDURE chk_acc
  (
    p_nd  NUMBER
   ,p_nls VARCHAR
   ,p_kv  INT
   ,dd    OUT cc_deal%ROWTYPE
   ,aa    OUT accounts%ROWTYPE
  ); ---- проверить счет
  PROCEDURE c_irr
  (
    p_mode INT
   ,p_nd   NUMBER
   ,p_dat  DATE
  ); ---- Розрахунок ЕПС
  ------------------
  FUNCTION header_version RETURN VARCHAR2;
  FUNCTION body_version RETURN VARCHAR2;
  -------------------
END cck_ui;
/
CREATE OR REPLACE PACKAGE BODY BARS.CCK_UI AS

  g_body_version CONSTANT VARCHAR2(64) := 'ver.3.3 PLAN 29.11.2017';
  g_errn NUMBER := -20203;
  g_errs VARCHAR2(16) := 'CCK_UI:';

/*
  20.07.2016 Sta COBUMMFO-4088  розділення  PROCEDURE trs_upd   та об'єднання траншів  PROCEDURE trs_add
  LSO ver.2.1.8 19/03/2017 процедура   rel_nls реализовал проверку что счет принадлежит клиенту
  LSO ver.2.1.6 09/03/2017 Фикс Подбор счетов при ручніх операциях
  LSO acc_add добавлен OB22 если приходит из формы то проставляем с проверкой
  Открытие счетов SK9 берем из таблицы cck_ob22  не SK9_31 а SK9

  дополнительный пакедж к CCK по реализации в ВЄБ
*/
  nlchr CHAR(2) := chr(13) || chr(10);
  --------------------------------------
  PROCEDURE pass_dop
  (
    p_tag VARCHAR2
   ,p_txt VARCHAR2
  ) IS
    l_nd NUMBER;
  BEGIN
    l_nd := to_number(pul.get('ND'));
    logger.info('DOP*' || l_nd || '*');
    cck_app.set_nd_txt(l_nd, p_tag, p_txt);
  END pass_dop;

  -- Перен на прост. %% згідно ДНЯ і ТИПУ погаш -- вырезать из CCK_SBER 4
  PROCEDURE aspn_sber(p_dat DATE) IS
    l_dat1    DATE; -- прош.раб. день
    l_dat2    DATE; -- поза-прош.раб. день
    l_acr_dat DATE; -- дата по яку нараховані відсотки
    l_ostc_sn accounts.ostc%TYPE; -- залишок тип  SN
    l_acc_sn  accounts.acc%TYPE; -- SN
    l_max     NUMBER; -- l_max > 0  - max допусимая сумма для переноса на просрочку (из ГПК) - используется в новом ануитете
    -- l_max = Null - по остатку
    dd_ CHAR(2);
    d1_ DATE;
    d2_ DATE := cck_app.correctdate2(980, p_dat - 1, 0);
    d3_ DATE;
  BEGIN

    l_dat1 := dat_next_u(p_dat, -1); -- прошлый раб день
    l_dat2 := dat_next_u(p_dat, -2); -- поза-прошлый раб день

    FOR k IN (SELECT d.nd
                    ,d.rnk
                    ,d.cc_id
                    ,d.wdate
                    ,d.vidd
                    ,d.sdate
                    ,a.kv
                    ,c.okpo
                    ,c.nmk
                    ,substr(t.txt, 2, 1) dp
                    ,i.basem
                    ,i.basey
                    ,i.apl_dat
                    ,(SELECT MAX(l.fdat)
                        FROM cc_lim l
                       WHERE l.nd = d.nd
                         AND fdat > l_dat2
                         AND l.fdat <= l_dat1
                         AND l.sumo > 0) pl_dat
                FROM cc_deal  d
                    ,accounts a
                    ,customer c
                    ,int_accn i
                    ,nd_acc   n
                    ,nd_txt   t
                    ,cc_add   da
               WHERE d.vidd IN (1, 2, 3, 11, 12, 13)
                 AND d.sos >= 10
                 AND d.sos < 14
                 AND d.nd = n.nd
                 AND n.acc = a.acc
                 AND a.tip = 'LIM'
                 AND d.rnk = c.rnk
                 AND da.nd = d.nd
                 AND nvl(to_number(cck_app.get_nd_txt(d.nd, 'FREQP')
                                  ,'99999999999D99'
                                  ,'NLS_NUMERIC_CHARACTERS = ''. ''')
                        ,da.freq) <> 400
                 AND i.acc = a.acc
                 AND i.id = 0
                 AND d.nd = t.nd
                 AND t.tag = 'FLAGS')
    LOOP
      dd_ := substr(cck_app.pay_day_sn_to_nd(k.nd), 1, 2); -- платежный день
      d1_ := cck_app.valid_date(dd_ || to_char(p_dat, '/mm/yyyy')); -- дата платежа в текущем месяце
      IF d1_ > p_dat THEN
        d1_ := add_months(d1_, -1);
      END IF; -- если она в будущем, то берем прошлый месяц
      d1_ := cck_app.correctdate2(980, least(d1_, k.wdate), 1); -- вычисляем раб.день
      d3_ := nvl(nvl(to_date(cck_app.get_nd_txt(k.nd, 'DATSN')
                            ,'dd/mm/yyyy')
                    ,k.apl_dat)
                ,k.sdate); -- Дата уплаты процентов
      IF d1_ <> d2_
         OR d3_ > d2_ THEN
        GOTO nexrec;
      END IF;
      -----------------------------------------------------------
      -- новый (жесткий ) аннуитет
      IF k.basem = 1
         AND k.basey = 2 THEN
        BEGIN
          -- По новому от STA
          l_max     := NULL;
          l_ostc_sn := NULL;
          l_acc_sn  := NULL;

          -- Есть ли проц карточка % ?
          SELECT nvl(MAX(i.acr_dat), k.pl_dat - 1), MAX(i.acra)
            INTO l_acr_dat, l_acc_sn
            FROM int_accn i, accounts a, nd_acc n
           WHERE n.nd = k.nd
             AND n.acc = a.acc
             AND i.acc = a.acc
             AND i.id = 0
             AND a.tip = 'SS '
             AND a.dazs IS NULL
             AND a.kv = k.kv;

          -- Есть ли остаток на сч нач.% ?
          SELECT abs(a.ostc)
            INTO l_ostc_sn
            FROM accounts a
           WHERE a.acc = l_acc_sn
             AND ostc < 0
             AND ostc = ostb
             AND a.tip = 'SN '
             AND a.kv = k.kv;

          -- Если это ануитет по-новому, то д.б. сумма нач проц >= сумме из ГПК , т.к. переносу подлежит не более суммы из ГПК

          IF k.pl_dat <= l_acr_dat THEN
            l_max := greatest(l_ostc_sn -
                              cck.fint(k.nd, k.pl_dat, l_acr_dat)
                             ,0);
          ELSE
            l_max := l_ostc_sn;
          END IF;
          cck.cc_aspn_dog(k.nd, k.cc_id, k.okpo, k.nmk, -3, l_max);
        EXCEPTION
          WHEN no_data_found THEN
            GOTO nexrec;
        END;

      ELSIF k.dp = 0 THEN
        -- за прошлый день (когда % платяться по предыдущий день)
        cck.cc_aspn_dog(k.nd, k.cc_id, k.okpo, k.nmk, -3, NULL);
      ELSE
        -- за прошлый месяц
        cck.cc_aspn_dog(k.nd, k.cc_id, k.okpo, k.nmk, -2, NULL);
      END IF;
      <<nexrec>>
      NULL;
    END LOOP;
    RETURN;

  END aspn_sber;

  -- Начисление процентов в КП (можно добавить др по cc_deal)
  PROCEDURE cck_interest(p_dat2 DATE) IS
    l_dat2_curr DATE; -- дата (текущая), по которую надо начислить проц.
    l_dat2_next DATE; -- следующая  банк-дата
    l_dat2_prev DATE; -- предыдущая банк-дата
    l_dat2_last DATE; -- посл календарная дата в текущ месяце
    --l_fdat_next date ; -- след.пл.дата по ГПК, которая меньше или равна следующей банк-дате
    l_dat2  DATE;
    l_count INT := 0;
    ------------------------------
    fl_   INT := 0;
    nint_ NUMBER;
    remi_ NUMBER;
    oo    oper%ROWTYPE;
  BEGIN
    l_dat2_curr := nvl(p_dat2, gl.bdate); -- дата, по которую надо начислить проц.
    l_dat2_next := dat_next_u(l_dat2_curr, 1); -- следующая банк-дата
    l_dat2_prev := dat_next_u(l_dat2_curr, -1); -- пред банк-дата
    l_dat2_last := last_day(l_dat2_curr); -- посл календарная дата в текущ месяце

    l_dat2 := l_dat2_curr;
    IF to_char(l_dat2_curr, 'yyyymm') < to_char(l_dat2_next, 'yyyymm') THEN
      fl_    := 1;
      l_dat2 := l_dat2_last;
    END IF;
    -------------------------------------------------------------------------------------------------------------------------------

    FOR p IN (SELECT d.nd
                    ,d.wdate
                    ,d.cc_id
                    ,d.sdate
                    ,a.tip
                    ,a.kv
                    ,a.nls
                    ,d.vidd
                    ,greatest(nvl(i.acr_dat + 1, a.daos), a.daos) dat1
                    ,i.acc
                    ,i.id
                    ,i.basey
                    ,i.basem
                    ,nvl(i.s, 0) s
                    ,i.acra
                    ,i.acrb
                    ,nvl(i.tt, '%%1') tt
                    ,i.rowid ri
                    ,CASE
                       WHEN i.metr IN (4, 95, 96, 97, 98) THEN
                        i.metr
                       ELSE
                        NULL
                     END metr
                    ,CASE
                       WHEN i.basem = 1
                            AND i.basey = 2
                            AND a.tip = 'SS ' THEN
                        (SELECT MAX(fdat)
                           FROM cc_lim
                          WHERE nd = d.nd
                            AND fdat > (l_dat2_curr + 1)
                            AND fdat <= l_dat2_next)
                       ELSE
                        NULL
                     END dat_pl
                FROM int_accn i, accounts a, nd_acc n, cc_deal d
               WHERE d.sos >= 10
                 AND d.sos < 14
                 AND d.vidd IN (1, 2, 3, 11, 12, 13)
                 AND d.nd = n.nd
                 AND n.acc = a.acc
                 AND a.acc = i.acc
                 AND i.id IN (0, 2, 1)
                 AND i.acra IS NOT NULL
                 AND i.acrb IS NOT NULL
                 AND i.acr_dat < l_dat2_curr
                 AND a.tip IN
                     ('SS ', 'SP ', 'CR9', 'SPN', 'SK9', 'LIM', 'SDI', 'S36'))

    LOOP
      -------------------------------------------------- Шаг-1 = Начисление
      IF p.id = 0
         AND p.tip IN ('SS ', 'SP ', 'CR9') THEN
        IF p.dat_pl IS NOT NULL THEN
          l_dat2 := (p.dat_pl - 1);
          nint_  := cck.fint(p.nd, p.dat1, l_dat2); -- начисление по ануитету
          IF p.dat_pl <= l_dat2_last THEN
            p.dat_pl := NULL;
          END IF;
        END IF;

        IF fl_ = 1
           AND p.dat_pl IS NULL THEN
          -- По 31 числам --
          l_dat2 := l_dat2_last;
          IF p.tip = 'SS '
             AND p.basey = 2
             AND p.basem = 1 THEN
            nint_ := cck.fint(p.nd, p.dat1, l_dat2); -- начисление по ануитету
          ELSE
            acrn.p_int(p.acc, p.id, p.dat1, l_dat2, nint_, NULL, 0); -- начисление банковское
          END IF;
        ELSIF p.wdate <= l_dat2_curr THEN
          -- По просрочкам
          l_dat2 := l_dat2_curr;
          acrn.p_int(p.acc, p.id, p.dat1, l_dat2, nint_, NULL, 0);
        END IF;

      ELSIF p.id = 2
            AND p.tip IN ('SP ', 'SPN', 'SK9') THEN
        -- пеня
        l_dat2 := l_dat2_curr;
        acrn.p_int(p.acc, p.id, p.dat1, l_dat2, nint_, NULL, 0);

      ELSIF (fl_ = 1 OR gl.bdate = p.wdate) THEN
        -- щом.коміс + лін.амортизація

        l_dat2 := least(l_dat2_last, p.wdate);
        IF p.id = 2
           AND p.tip = 'LIM' THEN
          cc_komissia(p.metr, p.acc, p.id, p.dat1, l_dat2, nint_, NULL, 0);
        ELSIF p.id = 1
              AND p.tip IN ('SDI', 'S36') THEN
          acrn.p_int(p.acc, p.id, p.dat1, l_dat2, nint_, NULL, 0);
        END IF;

      END IF;

      --------------------------------------------- Шаг-2 = Проводка
      SAVEPOINT do_opl;
      ------------------
      BEGIN
        nint_ := nint_ + p.s; --\
        oo.s  := round(nint_); ---| разница округлений для запоминания
        remi_ := nint_ - oo.s; --/
        SELECT kv, nls, substr(nms, 1, 38)
          INTO oo.kv, oo.nlsa, oo.nam_a
          FROM accounts
         WHERE acc = p.acra;
        SELECT kv, nls, substr(nms, 1, 38)
          INTO oo.kv2, oo.nlsb, oo.nam_b
          FROM accounts
         WHERE acc = p.acrb;
        IF p.kv <> oo.kv THEN
          -- вал ресурса HE = валюте нач.проц.
          oo.s := gl.p_ncurval(oo.kv
                              ,gl.p_icurval(p.kv, oo.s, gl.bdate)
                              ,gl.bdate);
        END IF;
        UPDATE int_accn SET acr_dat = l_dat2, s = remi_ WHERE ROWID = p.ri;
        IF oo.s = 0 THEN
          GOTO nextrec_;
        END IF;
        ------------------------------------------
        IF oo.kv = oo.kv2 THEN
          oo.s2 := oo.s;
        ELSIF oo.kv2 = gl.baseval THEN
          oo.s2 := gl.p_icurval(oo.kv, oo.s, gl.bdate);
        ELSE
          oo.s2 := gl.p_ncurval(oo.kv2
                               ,gl.p_icurval(oo.kv, oo.s, gl.bdate)
                               ,gl.bdate);
        END IF;
        IF oo.s < 0 THEN
          oo.dk := 1;
          oo.s  := -oo.s;
          oo.s2 := -oo.s2;
        ELSE
          oo.dk := 0;
        END IF;

        IF p.tip = 'LIM' THEN
          oo.nazn := 'Нарах.Комісії за супровід КД ' || p.cc_id || ' від ' ||
                     to_char(p.sdate, 'dd.MM.yy');
        ELSE
          IF p.tip = ' CR9' THEN
            oo.nazn := 'Комісії за ліміт';
          ELSIF oo.nlsa LIKE '8008%' THEN
            oo.nazn := 'Пені за простр.';
          ELSE
            oo.nazn := 'Відсотків';
          END IF;
          oo.nazn := 'Нарах.' || oo.nazn || ' по рах.' || p.nls || ' з ' ||
                     to_char(p.dat1, 'dd.MM.yy') || ' по ' ||
                     to_char(l_dat2, 'dd.MM.yy');
        END IF;

        gl.ref(oo.ref);
        oo.nd := TRIM(substr('          ' || to_char(oo.ref), -10));
        gl.in_doc3(oo.ref
                  ,p.tt
                  ,6
                  ,oo.nd
                  ,SYSDATE
                  ,gl.bdate
                  ,oo.dk
                  ,oo.kv
                  ,oo.s
                  ,oo.kv2
                  ,oo.s2
                  ,NULL
                  ,gl.bdate
                  ,gl.bdate
                  ,oo.nam_a
                  ,oo.nlsa
                  ,gl.amfo
                  ,oo.nam_b
                  ,oo.nlsb
                  ,gl.amfo
                  ,oo.nazn
                  ,NULL
                  ,gl.aokpo
                  ,gl.aokpo
                  ,NULL
                  ,NULL
                  ,1
                  ,NULL
                  ,NULL);
        gl.payv(0
               ,oo.ref
               ,gl.bdate
               ,p.tt
               ,oo.dk
               ,oo.kv
               ,oo.nlsa
               ,oo.s
               ,oo.kv2
               ,oo.nlsb
               ,oo.s2);
        gl.pay(2, oo.ref, gl.bdate);
        -- Вставка записи-истории о начислении процентов, если, в будущем будет необходимость СТОРНО или персчета процентов.
        acrn.acr_dati(p.acc, p.id, oo.ref, (p.dat1 - 1), p.s);

      EXCEPTION
        WHEN OTHERS THEN
          ROLLBACK TO do_opl;
          DECLARE
            code_   NUMBER;
            erm_    VARCHAR2(2048);
            tmp_    VARCHAR2(2048);
            status_ VARCHAR2(10);
            l_recid NUMBER;
          BEGIN
            bars_audit.error(p_msg     => 'CCK_INTEREST-err*' || SQLERRM
                            ,p_module  => NULL
                            ,p_machine => NULL
                            ,p_recid   => l_recid);
            deb.trap(SQLERRM, code_, erm_, status_);
            IF code_ <= -20000 THEN
              bars_error.get_error_info(SQLERRM, erm_, tmp_, tmp_);
            END IF;
            -- l_txt := substr( l_txt ||l_recid||'*'|| erm_, 1, 70) ;
          END;
          GOTO nextrec_;
      END;
      -------------------
      <<nextrec_>>
      NULL;
      l_count := l_count + 1;
      IF l_count >= 200 THEN
        COMMIT;
        l_count := 0;
      END IF;

    END LOOP; ----p
    COMMIT;
    --------------------
  END cck_interest;

  -------------------- Поддержка Графика событий по одному КД -------------------------------
  PROCEDURE sob(p_mode NUMBER
               , -- 1 - Insert
                -- 2 - Update
                -- 0 - Delete
                p_nd       NUMBER
               ,p_id       NUMBER
               ,p_fdat     DATE
               ,p_fact_dat DATE
               ,p_txt      VARCHAR2
               ,p_otm      INT
               ,p_freq     INT
               ,p_sys      INT) IS
    t_dat DATE;
    n_dat DATE;
    l_nd  NUMBER;
  BEGIN
    t_dat := nvl(p_fdat, gl.bdate);
    l_nd  := nvl(p_nd, to_number(pul.get_mas_ini_val('ND')));

    IF p_mode = 0 THEN
      DELETE FROM cc_sob
       WHERE nd = l_nd
         AND id = p_id
         AND fdat >= gl.bdate
         AND psys > 0;
    ELSIF p_mode = 1 THEN
      IF t_dat >= gl.bdate THEN
        INSERT INTO cc_sob
          (nd, fdat, txt, freq, psys)
        VALUES
          (l_nd, t_dat, p_txt, p_freq, p_sys);
      ELSE
        raise_application_error(g_errn
                               ,g_errs || 'Пл.дата = ' ||
                                to_char(t_dat, 'dd.mm.yyyy') ||
                                ' менша поточної = ' ||
                                to_char(gl.bdate, 'dd.mm.yyyy'));
      END IF;
    ELSIF p_mode = 2 THEN
      UPDATE cc_sob
         SET fdat      = t_dat
            ,fact_date = p_fact_dat
            ,txt       = p_txt
            ,otm       = p_otm
            ,freq      = p_freq
            ,psys      = p_sys
       WHERE nd = l_nd
         AND id = p_id
         AND fdat >= gl.bdate
         AND psys > 0;

      IF p_otm = 6 THEN
        IF p_freq = 1 THEN
          n_dat := correctdate2(980, t_dat + 1, 0);
        ELSIF p_freq = 3 THEN
          n_dat := correctdate2(980, t_dat + 7, 0);
        ELSIF p_freq = 5 THEN
          n_dat := add_months(t_dat, 1);
        ELSIF p_freq = 7 THEN
          n_dat := add_months(t_dat, 3);
        ELSIF p_freq = 7 THEN
          n_dat := add_months(t_dat, 3);
        ELSIF p_freq = 180 THEN
          n_dat := add_months(t_dat, 6);
        ELSIF p_freq = 360 THEN
          n_dat := add_months(t_dat, 12);
        END IF;
        INSERT INTO cc_sob
          (nd, fdat, txt, freq, psys)
        VALUES
          (l_nd, n_dat, p_txt, p_freq, p_sys);
      END IF;
    END IF;

  END sob;

  ----------------------- получение № счета -----------------------------

  FUNCTION na_nls
  (
    x_nls  VARCHAR2
   ,x_acc8 NUMBER
   ,x_tip  VARCHAR2
   ,x_prod VARCHAR2
  ) RETURN VARCHAR2 IS
    l_nls accounts.nls%TYPE := x_nls;
    l_nbs accounts.nbs%TYPE := substr(x_prod, 1, 4);
    l_b3  CHAR(3);
    ntmp_ INT;
  BEGIN
    IF x_nls IS NULL
       OR x_nls = 'N/A' THEN
      l_b3 := substr(x_prod, 1, 3);

      IF x_tip = 'CR9' THEN
        l_nbs := '9129';
      ELSIF x_tip = 'SP ' THEN
        if NEWNBS.GET_STATE = 1 then
          if l_b3 = '207' then
             l_nbs := l_b3 || '1';
          else
         l_nbs := l_b3 || '3';
          end if;
        else
         l_nbs := l_b3 || '7';
        end if;
      ELSIF x_tip = 'SPN' THEN
        if NEWNBS.GET_STATE = 1 then
         l_nbs := l_b3 || '8';
        else
         l_nbs := l_b3 || '9';
        end if;
      ELSIF x_tip = 'SDI'
            AND x_prod NOT LIKE '9%' THEN
        l_nbs := l_b3 || '6';
      ELSIF x_tip = 'SPI' THEN
        if NEWNBS.GET_STATE = 1 then
         l_nbs := l_b3 || '6';
        else
         l_nbs := l_b3 || '5';
        end if;
      ELSIF x_tip = 'SN ' THEN
        l_nbs := l_b3 || '8';
      ELSIF x_tip = 'SNO' THEN
        l_nbs := l_b3 || '8';
      ELSIF x_tip = 'SNA' THEN
        l_nbs := l_b3 || '8';
      ELSIF x_tip = 'S36' THEN
        l_nbs := '3600';
      ELSIF x_tip = 'SK0' THEN
        l_nbs := '3578';
      ELSIF x_tip = 'SK9' THEN
        if NEWNBS.GET_STATE = 1 then
         l_nbs := '3578';
        else
         l_nbs := '3579';
        end if;
      ELSIF x_tip = 'SG ' THEN
        l_nbs := '3739';
      ELSIF x_tip = 'SN8' THEN
        l_nbs := '8008';
      ELSIF x_tip = 'SDI'
            AND x_prod LIKE '9%' THEN
        l_nbs := '3648';
      ELSIF x_tip = 'ISG' THEN
        l_nbs := '3600';
      END IF; -- SS   SS  Основний борг
      /*9023 (один в валюті договору)
      3578 (декілька, в будь-яких валютах)
      3579 (декілька, в будь-яких валютах)
      3648 (один в будь-якій валюті)
      3739 (декілька, в будь-яких валютах)
      3600 (декілька, в будь-яких валютах)
         */
      --------по маске счета---------------------------------------------------------------
      l_nls := vkrzn(substr(gl.amfo, 1, 5), f_newnls(x_acc8, 'SS ', l_nbs));

      --------по случайному числу----------------------------------------------------------
      /*
           While 1<2
           loop  nTmp_ := trunc ( dbms_random.value(1, 999999999));
                 l_nLs := l_nBs ||'_'||nTmp_ ;
                 begin select 1 into nTmp_ from accounts where nls like l_nLs ;
                 EXCEPTION  WHEN NO_DATA_FOUND THEN  l_nls := vkrzn ( substr(gl.KF,1,5), l_nLs);  EXIT ;
                 end;
           end loop ;
      */
    END IF;
    RETURN l_nls;
  END na_nls;

  --- получение урл для допустимой оерации
  FUNCTION url_tip
  (
    x_sos   INT
   ,x_dazs  DATE
   ,x_nd    NUMBER
   ,x_cc_id VARCHAR2
   ,x_sdate DATE
   ,x_tip   VARCHAR2
   ,x_nls   VARCHAR2
   ,x_kv    INT
   ,x_lim   NUMBER
   ,x_ostc  NUMBER
   ,x_mfob  VARCHAR2
   ,x_nlsb  VARCHAR2
   ,x_okpo  VARCHAR2
   ,x_nmk   VARCHAR2
  ) RETURN VARCHAR2 IS
    ------
    --cc_add_row  cc_add.%type;
    stmp_    accounts.nls%TYPE;
    url_     VARCHAR2(1000) := NULL;
    l_x_mfob VARCHAR2(6);
  BEGIN
    l_x_mfob := x_mfob;
    IF x_sos NOT IN (10, 11, 12, 13)
       OR x_dazs IS NOT NULL
       OR x_tip NOT IN ('SS ', 'SP ', 'SPN', 'SK9', 'SN8')
       OR x_nls IS NULL
       OR x_nls LIKE 'N%'
       OR x_nls LIKE '9%' THEN
      RETURN NULL;
    END IF;

    IF x_tip = 'SS '
       AND x_lim + x_ostc > 0 THEN

      IF l_x_mfob = sys_context('bars_context', 'user_mfo') and x_nlsb IS   not null THEN
        stmp_ := 'KK1';
      ELSE
        stmp_ := 'KK2';
      END IF;
      --20/03/2017 Pivanova
     /* IF c IS NULL
         AND l_x_mfob = '300465' THEN
        l_x_mfob := NULL;
      END IF;*/
      --bars_audit.info('stmp_='||stmp_||' ,x_kv='||x_kv||' ,x_nls='||x_nls||' ,x_okpo= '||x_okpo||' ,x_nlsb= '||x_nlsb||' ,x_mfob= '||x_mfob||' ,x_okpo= '||x_okpo);
      url_ := make_docinput_url(stmp_
                               ,'Видати->'
                               ,'DisR'
                               ,'1'
                               ,'Kv_A'
                               ,x_kv
                               ,'Nls_A'
                               ,x_nls
                               ,'Id_A'
                               ,x_okpo
                               ,'Nls_B'
                               ,x_nlsb
                               ,'Mfob'
                               ,l_x_mfob
                               ,'Id_B'
                               ,x_okpo
                               ,'Nam_B'
                               ,substr(x_nmk, 1, 38)
                               ,'SumC_t'
                               ,(x_lim + x_ostc) * 100
                               ,'Flag_se'
                               ,1
                               ,'Nazn'
                               ,'Перерахування коштів згідно КД № ' ||
                                x_cc_id || ' від ' ||
                                to_char(x_sdate, 'dd/MM/yyyy'));

    END IF;

    IF x_tip = 'SP ' THEN
      BEGIN
        SELECT q.nls
          INTO stmp_
          FROM accounts q, nd_acc w
         WHERE w.nd = x_nd
           AND q.acc = w.acc
           AND q.ostc < 0
           AND q.kv = x_kv
           AND q.dazs IS NULL
           AND rownum = 1
           AND q.tip = 'SS ';

        url_ := make_docinput_url('KK1'
                                 ,'<-Простр.тіло'
                                 ,'DisR'
                                 ,'1'
                                 ,'Kv_A'
                                 ,x_kv
                                 ,'Nls_A'
                                 ,x_nls
                                 ,'Id_A'
                                 ,x_okpo
                                 ,'Nls_B'
                                 ,stmp_
                                 ,'Nazn'
                                 ,'Перенесення на прострочку основного боргу угоди № ' ||
                                  x_cc_id || ' від ' ||
                                  to_char(x_sdate, 'dd/MM/yyyy')
                                 ,'vob'
                                 ,(CASE
                                    WHEN x_kv = 980 THEN
                                     6
                                    ELSE
                                     46
                                  END));
      EXCEPTION
        WHEN no_data_found THEN
          NULL;
      END;
    END IF;

    IF x_tip = 'SPN' THEN
      BEGIN
        SELECT q.nls
          INTO stmp_
          FROM accounts q, nd_acc w
         WHERE w.nd = x_nd
           AND q.acc = w.acc
           AND q.ostc < 0
           AND q.kv = x_kv
           AND q.dazs IS NULL
           AND rownum = 1
           AND q.tip = 'SN ';
        url_ := make_docinput_url('KK1'
                                 ,'<-Простр.проц'
                                 ,'DisR'
                                 ,'1'
                                 ,'Kv_A'
                                 ,x_kv
                                 ,'Nls_A'
                                 ,x_nls
                                 ,'Id_A'
                                 ,x_okpo
                                 ,'Nls_B'
                                 ,stmp_
                                 ,'Nazn'
                                 ,'Перенесення на прострочку процентного боргу угоди № ' ||
                                  x_cc_id || ' від ' ||
                                  to_char(x_sdate, 'dd/MM/yyyy'));
      EXCEPTION
        WHEN no_data_found THEN
          NULL;
      END;
    END IF;

    IF x_tip = 'SK9' THEN
      BEGIN
        SELECT q.nls
          INTO stmp_
          FROM accounts q, nd_acc w
         WHERE w.nd = x_nd
           AND q.acc = w.acc
           AND q.ostc < 0
           AND q.kv = x_kv
           AND q.dazs IS NULL
           AND rownum = 1
           AND q.tip = 'SK0';
        url_ := make_docinput_url('KK1'
                                 ,'<-Простр.коміс'
                                 ,'DisR'
                                 ,'1'
                                 ,'Kv_A'
                                 ,x_kv
                                 ,'Nls_A'
                                 ,x_nls
                                 ,'Id_A'
                                 ,x_okpo
                                 ,'Nls_B'
                                 ,stmp_
                                 ,'Nazn'
                                 ,'Перенесення на прострочку комісійного боргу угоди № ' ||
                                  x_cc_id || ' від ' ||
                                  to_char(x_sdate, 'dd/MM/yyyy'));
      EXCEPTION
        WHEN no_data_found THEN
          NULL;
      END;
    END IF;

    IF x_tip = 'SN8' THEN
      BEGIN
        SELECT q.nls
          INTO stmp_
          FROM accounts q, nd_acc w
         WHERE w.nd = x_nd
           AND q.acc = w.acc
           AND q.kv = 980
           AND q.dazs IS NULL
           AND q.tip = 'SG '
           AND rownum = 1;
        url_ := make_docinput_url('KK4'
                                 ,'Деб.зап->.'
                                 ,'DisR'
                                 ,'3'
                                 ,'Kv_A'
                                 ,'980'
                                 ,'Nls_A'
                                 ,stmp_
                                 ,'Kv_B'
                                 ,'980'
                                 ,'Nls_B'
                                 ,x_nlsb
                                 ,'Id_A'
                                 ,x_okpo
                                 ,'Mfob'
                                 ,x_mfob
                                 ,'Id_B'
                                 ,x_okpo
                                 ,'Nam_B'
                                 ,substr(x_nmk, 1, 38)
                                 ,'Nazn'
                                 ,'Заборгованість по пені згідно КД № ' ||
                                  x_cc_id || ' від ' ||
                                  to_char(x_sdate, 'dd/MM/yyyy') ||
                                  ' станом на  ' ||
                                  to_char(gl.bd, 'dd/MM/yyyy') ||
                                  ' становить ' || to_char(-x_ostc) ||
                                  '(вал=' || x_kv || ')'
                                 ,'SumC_t'
                                 ,to_char(-x_ostc * 100));
      EXCEPTION
        WHEN no_data_found THEN
          NULL;
      END;
    END IF;
    RETURN url_;

  END url_tip;

  ------Сухова -------------------------------------------------------------------
  FUNCTION dop_sem
  (
    p_txt VARCHAR2
   ,p_tab VARCHAR2
   ,p_sk  VARCHAR2
   ,p_fk  VARCHAR2
  ) RETURN VARCHAR2 IS
    -- получение семантического названия доп.рекц по таблице допустимых значений
    l_sem VARCHAR2(250);
  BEGIN
    IF p_txt IS NOT NULL
       AND p_tab IS NOT NULL
       AND p_sk IS NOT NULL
       AND p_fk IS NOT NULL THEN
      BEGIN
        EXECUTE IMMEDIATE 'select ' || p_fk || ' from ' || p_tab ||
                          ' where ' || p_sk || ' = ''' || p_txt || ''''
          INTO l_sem;
      EXCEPTION
        WHEN no_data_found THEN
          NULL;
      END;
    END IF;

    RETURN l_sem;
  END dop_sem;

  ------Сухова -------------------------------------------------------------------
  PROCEDURE autor
  (
    p_nd   NUMBER
   , -- реф КД >0 = авторизовать, <0 = Де-авторизовать
    p_mode NUMBER
   , -- =1 с полным фаршем, =0 - без него
    p_x1   VARCHAR2
   , -- Основание
    p_x2   VARCHAR2 -- Инициатива
  ) IS
    -- авторизация
    l_nd  NUMBER;
    dd    cc_deal%ROWTYPE;
    a89   accounts%ROWTYPE;
    i89   int_accn%ROWTYPE;
    aa    accounts%ROWTYPE;
	L_ss_count NUMBER;
    stmp_ VARCHAR2(50);
    ntmp_ NUMBER;
    l_x1  VARCHAR2(50);
  BEGIN
    l_nd := abs(p_nd);

    BEGIN
      stmp_ := 'cc_deal';
      SELECT *
        INTO dd
        FROM cc_deal d
       WHERE nd = l_nd
         AND d.sos < 14;
      stmp_ := 'accounts';
      SELECT a.*
        INTO a89
        FROM nd_acc n, accounts a
       WHERE n.nd = dd.nd
         AND n.acc = a.acc
         AND a.tip = 'LIM';
      stmp_ := 'int_accn';
      SELECT *
        INTO i89
        FROM int_accn
       WHERE acc = a89.acc
         AND id = 0;
    EXCEPTION
      WHEN no_data_found THEN
        raise_application_error(g_errn
                               ,g_errs || 'Не знайдено Договір ref=' || p_nd || ' ' ||
                                stmp_);
    END;

    --- Проверки по ДОГ.
    -- If p_X1 is null         then  raise_application_error(g_errn, g_errS||'Не указано підставу для  Договору ref='||l_nd )  ;    end if;
    l_x1 := p_x1;
    IF l_x1 IS NULL THEN
      l_x1 := 'Авторизація дог. ' || dd.cc_id || ' від ' || dd.sdate;
    END IF;

    IF p_nd < 0 THEN
      UPDATE cc_deal SET sos = 0 WHERE nd = l_nd;
      INSERT INTO cc_sob
        (nd, fdat, isp, txt, otm)
      VALUES
        (dd.nd
        ,gl.bdate
        ,gl.auid
        ,'ДЕ-Авторизовано:Договір'
        ,6);
      RETURN;
    END IF;

    --if gl.aUid = dd.user_id then raise_application_error(g_errn,'Користувач '||  gl.aUid || ' Не може авторизувати <свою> угоду ' ||dd.nd); end if;

    IF p_mode = 0 THEN
      -- Проста

      BEGIN
        SELECT count(1)
          INTO L_ss_count
          FROM accounts a, nd_acc n
         WHERE nd = l_nd
           AND n.acc = a.acc
           AND a.tip = 'SS ';
     /* EXCEPTION
        WHEN no_data_found THEN
          raise_application_error(g_errn
                                 ,g_errs || 'Не відкрито рах.позики SS');*/
      END;
  if L_ss_count=0 then
   raise_application_error(g_errn
                                 ,g_errs || 'Не відкрито рах.позики SS');
  end if;
   /*   BEGIN
        SELECT 1
          INTO ntmp_
          FROM cc_accp z, nd_acc n
         WHERE n.nd = l_nd
           AND n.acc = z.accs
           AND rownum = 1;
      EXCEPTION
        WHEN no_data_found THEN
          raise_application_error(g_errn
                                 ,g_errs ||
                                  'Відсутнє будь-яке забесперення до Договору ref=' || l_nd);
      END;*/

      cck.cc_autor(p_nd, l_x1, nvl(p_x2, dd.branch));
      -- НАЧАЛЬНАЯ 9129 ???????????

    ELSE
      -- з повним фаршем
      cck_dop.cc_autor(p_nd, l_x1, nvl(p_x2, dd.branch));
    END IF;

  END autor;
  ---------------------------------------------------------------------------
  PROCEDURE p_cc_lim_repair(p_id cc_lim_copy_header.id%TYPE
                            /*,p_nd cc_deal.nd%TYPE */) IS
  BEGIN
    DELETE FROM cc_lim t
     WHERE t.nd =
           (SELECT t1.nd FROM cc_lim_copy_header t1 WHERE t1.id = p_id);

    INSERT INTO cc_lim
      (nd, fdat, lim2, acc, not_9129, sumg, sumo, otm, kf, sumk, not_sn)
      SELECT nd
            ,fdat
            ,lim2
            ,acc
            ,not_9129
            ,sumg
            ,sumo
            ,otm
            ,kf
            ,sumk
            ,not_sn
        FROM cc_lim_copy_body
       WHERE /* nd = p_nd
               AND*/
       id = p_id;
  END p_cc_lim_repair;

  PROCEDURE p_cc_lim_copy
  (
    p_nd       cc_deal.nd%TYPE
   ,p_comments cc_lim_copy_header.comments%TYPE DEFAULT NULL
  ) IS
    --Створення копії ГПК(ШЛК) перед модифікацією
    l_id NUMBER DEFAULT bars_sqnc.get_nextval('S_CCK_CC_LIM_COPY');
  BEGIN
    INSERT INTO cc_lim_copy_header
      (id, nd, userid, comments)
    VALUES
      (l_id, p_nd, gl.auid, p_comments);
    INSERT INTO cc_lim_copy_body
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
      SELECT l_id
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
       WHERE t.nd = p_nd;
  END p_cc_lim_copy;
  --График Погашения Кредита (ГПК) [ он же График Лимитов Кредитования (ГЛК)] -- РЕДАКТИРОВАНИЕ
  PROCEDURE gpk_upd
  (
    p_mode NUMBER
   , ---     0 - INS, 1-UDD, 2 -DEL
    p_nd   NUMBER
   , --Реф КД
    p_fdat DATE
   , --Плат.дата или Дата изм.лимита
    p_9129 NUMBER
   , --Не менять 9129
    p_sumg NUMBER
   , --План-сумма гашения осн.долга
    p_sumo NUMBER
   , --Общая План-Сумма гашения
    p_sumk NUMBER
   , --План-Сумма гашения комиссии
    p_sn   NUMBER --1= В занную дату Не платить нач.доходы (% и комиссию)
  ) IS
    ---- OTM    INTEGER,               --Отметка о ПОЛНОСТЬЮ загашенном платеже
    ---- KF        VARCHAR2(6 BYTE)    --DEFAULT sys_context('bars_context','user_mfo')
    ---  LIM2   NUMBER(38),            --Сумма нового лимита
    ---  ACC    INTEGER,               --Сч 8999
    l_nd  NUMBER;
    l_acc NUMBER;
    l_vid NUMBER;
    l_bas NUMBER;
  BEGIN

    l_nd := nvl(p_nd, to_number(pul.get_mas_ini_val('ND')));

    BEGIN
      SELECT a.acc, a.vid, i.basem
        INTO l_acc, l_vid, l_bas
        FROM accounts a, nd_acc n, int_accn i, cc_deal d
       WHERE n.nd = l_nd
         AND n.acc = a.acc
         AND a.tip = 'LIM'
         AND a.acc = i.acc
         AND i.id = 0
         AND d.nd = n.nd
         AND d.sos < 14;
    EXCEPTION
      WHEN no_data_found THEN
        raise_application_error(g_errn
                               ,g_errs || '8999*:Не знайдено ');
    END;

    IF l_bas = 1 THEN
      raise_application_error(g_errn
                             ,g_errs ||
                              'Поодинокі виправлення ГПК в Ануїтеті недопустимі');
    END IF;
    ------------------------------------------
    p_cc_lim_copy(p_nd => l_nd, p_comments => 'CCK_UI.GPK_UPD');
    IF p_mode = 0 THEN
      IF l_vid = 4 THEN
        INSERT INTO cc_lim
          (nd, fdat, acc, sumo, sumk, not_sn)
        VALUES
          (l_nd, p_fdat, l_acc, p_sumo * 100, p_sumk * 100, p_sn);
      ELSE
        INSERT INTO cc_lim
          (nd, fdat, acc, sumg, sumk, not_sn)
        VALUES
          (l_nd, p_fdat, l_acc, p_sumg * 100, p_sumk * 100, p_sn);
      END IF;

    ELSIF p_mode = 1 THEN
      IF l_vid = 4 THEN
        UPDATE cc_lim
           SET sumo   = p_sumo * 100
              ,sumk   = p_sumk * 100
              ,not_sn = decode(p_sn, 1, 1, NULL)
         WHERE fdat = p_fdat
           AND nd = l_nd
           AND fdat > gl.bdate;
      ELSE
        UPDATE cc_lim
           SET sumg   = p_sumg * 100
              ,sumk   = p_sumk * 100
              ,not_sn = decode(p_sn, 1, 1, NULL)
         WHERE fdat = p_fdat
           AND nd = l_nd
           AND fdat > gl.bdate;
      END IF;

    ELSIF p_mode = 2 THEN
      DELETE FROM cc_lim
       WHERE fdat = p_fdat
         AND nd = l_nd
         AND fdat > gl.bd
         AND fdat <> (SELECT MIN(t.fdat) FROM cc_lim t WHERE t.nd = l_nd);
    ELSE
      RETURN;
    END IF;

    --cck_ui.gpk_bal(NULL, NULL, 0);
  END gpk_upd;

  PROCEDURE glk_upd
  (
    p_mode     NUMBER
   , ---     0 - INS, 1-UDD, 2 -DEL
    p_nd       NUMBER
   , --Реф КД
    p_fdat     DATE
   , --Плат.дата или Дата изм.лимита
    p_lim2     NUMBER
   , --План-сумма ИСХОД лимита
    p_d9129    NUMBER
   , --Поточна~Дельта~ для 9129
    p_daysn    NUMBER -- можливо буде необхідність обирати опцію з інтерфейсу
   --
   ,p_upd_flag NUMBER
   ,p_not_9129 number default null
  ) IS
    l_nd        NUMBER;
    l_acc       NUMBER;
    dd          cc_deal%ROWTYPE;
    l_fdat_next DATE;
    l_vidd      NUMBER;
    l_bdat_1    DATE;
    l_dat4_     DATE;
    l_old_lim   NUMBER;
    l_daysn     NUMBER;
  BEGIN
    l_daysn := p_daysn;
    l_nd    := nvl(p_nd, to_number(pul.get_mas_ini_val('ND')));

    ------------------------------------------
   /* IF p_fdat < gl.bdate THEN
      raise_application_error(g_errn
                             ,g_errs || 'Дата ' ||
                              to_char(p_fdat, 'dd.mm.yyyy') ||
                              ' < поточної ' ||
                              to_char(gl.bdate, 'dd.mm.yyyy'));
    END IF;*/

    IF p_mode = 2 THEN
      DELETE FROM cc_lim
       WHERE fdat = p_fdat
         AND nd = l_nd;
      p_cc_lim_copy(p_nd       => l_nd
                   ,p_comments => 'CCK_UI.GLK_UPD.p_mode = 2');
      --ELsif p_mode=0 then
    ELSE

      p_cc_lim_copy(p_nd       => l_nd
                   ,p_comments => 'CCK_UI.GLK_UPD.p_mode = 0');
      /* else*/

      BEGIN
        INSERT INTO cc_lim
          (nd, fdat, acc, lim2, not_sn)
          SELECT l_nd, p_fdat, acc, p_lim2 * 100, l_daysn
            FROM cc_lim
           WHERE nd = l_nd
             AND rownum = 1;

        p_cc_lim_copy(p_nd       => l_nd
                     ,p_comments => 'CCK_UI.GLK_UPD.p_mode = 0');
      EXCEPTION
        WHEN OTHERS THEN
          IF SQLCODE = -01400
             AND sys_context('bars_context', 'user_mfo') IS NULL
             OR sys_context('bars_context', 'user_mfo') = '\' THEN
            raise_application_error(-20005
                                   ,'Встановіть коректне відділення. На рівні / модифікувати дані заборонено');

          END IF;
      END;

      IF SQL%ROWCOUNT = 0 THEN

        UPDATE cc_lim
           SET lim2 = p_lim2 * 100, not_sn = l_daysn
         WHERE fdat = p_fdat
           AND nd = l_nd;
        UPDATE cc_lim
           SET not_9129 =p_not_9129
         WHERE fdat >= p_fdat
           AND nd = l_nd;
      END IF;
      UPDATE nd_txt
         SET txt = to_char(p_d9129 * 100)
       WHERE nd = l_nd
         AND tag = 'D9129';
      IF SQL%ROWCOUNT = 0 THEN
        INSERT INTO nd_txt
          (nd, tag, txt)
        VALUES
          (l_nd, 'D9129', to_char(p_d9129 * 100));
      END IF;
      IF p_upd_flag = 1 THEN
        --raise_application_error(-20005,p_UPD_FLAG);
        UPDATE cc_lim t
           SET lim2 = p_lim2 * 100
         WHERE t.nd = l_nd
           AND t.fdat > p_fdat
           AND t.fdat <>
               (SELECT MAX(fdat) FROM cc_lim t1 WHERE t1.nd = l_nd);

      ELSE
        BEGIN
          SELECT t1.lim2
            INTO l_old_lim
            FROM (SELECT t.fdat
                        ,t.lim2
                        ,row_number() over(PARTITION BY t.nd ORDER BY t.fdat) AS lim_id
                    FROM cc_lim t
                   WHERE t.nd = l_nd
                     AND t.fdat > p_fdat) t1
           WHERE t1.lim_id = 1;
          exception when no_data_found then
            l_old_lim:=0;
        END;

        UPDATE cc_lim t
           SET lim2 = p_lim2 * 100
         WHERE t.nd = l_nd
           AND t.fdat >= p_fdat
           AND t.lim2 = l_old_lim;
      END IF;

    END IF;
    BEGIN
      SELECT a.vid
        INTO l_vidd
        FROM accounts a, nd_acc n
       WHERE n.nd = l_nd
         AND n.acc = a.acc
         AND a.tip = 'LIM';
    EXCEPTION
      WHEN no_data_found THEN
        raise_application_error(g_errn
                               ,g_errs || '8999*:Не знайдено ');
    END;

    cck.cc_lim_gpk(nd_ => l_nd, datn_ => p_fdat);

    cck.cc_tmp_gpk(nd_ => l_nd);
    cck.lim_bdate(p_nd => l_nd, p_dat => p_fdat);
  END glk_upd;
  ---
  PROCEDURE trs0(p_nd NUMBER) IS
    l_nd NUMBER;
  BEGIN
    l_nd := nvl(p_nd, to_number(pul.get_mas_ini_val('ND')));
    cct.start0(l_nd);
  END trs0;


--ручная модификация траншей: Редагування або Відокремлення траншу (створення нового підтраншу)
  PROCEDURE trs_upd
  ( p_id     NUMBER, --Ид траншу
    p_sv1    NUMBER,
    p_dplan  DATE  ,
    p_dplan1 DATE  ,
    p_sz     NUMBER,
    p_sz1    NUMBER,
    p_comm   VARCHAR2  ) IS

    tt    cc_trans%ROWTYPE;    l_err VARCHAR2(250);
  BEGIN

    BEGIN  SELECT *  INTO tt   FROM cc_trans WHERE npp = p_id  AND d_fakt IS NULL;
    EXCEPTION  WHEN no_data_found THEN       l_err := 'CC_TRANS*Не знайдено НЕПОГАШ. ид.транша ' || p_id;  raise_application_error(g_errn, g_errs || l_err);
    END;

    IF p_sv1 >= tt.sv THEN  l_err := 'Cума видачi вiдокремленого траншу >= суми видачi основного траншу';  raise_application_error(g_errn, g_errs || l_err);  END IF;
    IF p_dplan <= tt.fdat   OR p_dplan1 <= tt.fdat THEN l_err := 'План-дата погаш не м.б.<= дати видачі';  raise_application_error(g_errn, g_errs || l_err);  END IF;

    IF p_sz1 >0 and p_sz1 >= p_sz THEN l_err := 'Cума погаш. вiдокр.траншу >= суми погаш. основ. траншу';  raise_application_error(g_errn, g_errs || l_err);  END IF;

    IF p_sz <> tt.sz/100          THEN      cct.upd_sz (p_id, tt.sz/100, p_sz  );
    ELSE                                    cct.upd_pog(p_id, p_dplan  , p_sv1, p_dplan1, p_sz1, p_comm);
    END IF;

    -- CCT.Start0 ( Nd )
    -- CCT.UPD_POG
    -- CCT.UPD_POG
    -- Об`єднати однорідні ВИДІЛЕНІ транші
    -- CCT.Del_TRANSH( Id)
    -- CCT.Upd_TRANSH( nId , nSv, nSz, sCom)

  END trs_upd;


--ручная модификация траншей : Об`єднати ДВА однорідні ВИДІЛЕНІ транші в ОДИН
  PROCEDURE trs_ADD  ( p_Id number) is  -- Ид траншу
        tt1 cc_trans%ROWTYPE ; -- для першого   траншу ;
        tt2 cc_trans%ROWTYPE ; -- для поточного траншу ;
        l_err VARCHAR2(250);
  BEGIN
    tt1.npp     := to_number( PUL.GET('ID_TRANSH') );
    If tt1.npp  is null then  PUL.put('ID_TRANSH', p_ID) ; RETURN; end if; -- вход с первой записью
    tt2.npp     := p_id;

    begin select * into tt1 from cc_trans where npp = tt1.npp;
          select * into tt2 from cc_trans where npp = tt2.npp;
    EXCEPTION  WHEN no_data_found THEN
          PUL.put('ID_TRANSH', null );
          return;
    end;

    If  tt1.acc <> tt2.acc  OR  tt1.fdat <> tt2.fdat  OR  tt1.D_PLAN <> tt2.D_PLAN then
        PUL.put('ID_TRANSH', null );
        l_err := tt1.npp ||' та '||tt2.npp ||' : Реквізити "Рахунок","Дата видачі","Дата погашення" НЕ співпадають !';  raise_application_error(g_errn, g_errs || l_err);
    END IF;

    CCT.Del_TRANSH( tt2.npp);
    CCT.Upd_TRANSH( tt1.npp , (tt1.Sv + tt2.Sv) , (tt1.Sz + tt2.Sz), NVL( tt1.comm, 'Об`єднання в один транш')|| '+' || tt2.npp ) ;
    PUL.put('ID_TRANSH', null );

  END trs_ADD;
---------------------------------

  --Нарахування %, комісій, пені по КП ЮО та ФО
 PROCEDURE p_cck_interest
(
  p_type    IN NUMBER DEFAULT 0
 ,p_date_to IN DATE default gl.bDATE
 ,p_mode   in number default 0
) IS

  /*
    27/05/2017  Pivanova додано опцію по нарахуванню % в регламенті
    20/03/2017  Pivanova розділила нарахування по ануїтету і по рівним частинам на дві
    19/03/2017  Pivanova змінено визначення платіжної дати для ануїтету фізіків
    16/03/2017  Pivanova змінено призначення платежу при нарахуванні амортизації

   25.01.2017 Sta Разные начисления в КП ФЛ и ЮЛ

          ЮЛ   ФЛ
    p_type = 1 , 11 НА ВИМОГУ - по ВСІМ - Щомiсячне Нар. %%  та комісії
    p_type = 2 , 12 НА ВИМОГУ - з залишками на SG
    p_type=  5,15  ануїтет   ЩОДЕННЕ   - по пл. датах
    p_type = 3 , 13 ЩОДЕННЕ   - по пл. датах
    p_type = 4 , 14 ЩОДЕННЕ   - по прострочених дог.
    p_type = 17   для Києва тимчасово

    p_type < 0 НА ВИМОГУ - по 1 КД


    p_mode описано в  V_CCK_INTEREST_MODE
  */
  nint_  NUMBER;
  ddat2_ DATE; -- пл.дата из ГПК -1 или заданная дата  = ПО
  d_prev DATE; -- пред.банк-да та
  d_next DATE; -- след.банк-дата
  l_nazn VARCHAR2(160);
  dd     cc_deal%ROWTYPE;
  k1     SYS_REFCURSOR;
  l_mode INT := 1;

  l_bdat_real DATE;
  l_bdat_next DATE;

BEGIN

  IF p_type >= 0
     AND p_type NOT IN (1, 2, 3, 4, 11, 12, 13, 14, 15, 15,17) THEN
    RETURN;
  END IF;
  interest_utl.start_reckoning;
  IF p_date_to IS NULL and p_type not in(5,15) THEN
    l_bdat_real := nvl(p_date_to, gl.bdate);
    l_bdat_next := dat_next_u(l_bdat_real, 1);

    IF to_number(to_char(l_bdat_next, 'YYMM')) >
       to_number(to_char(l_bdat_real, 'YYMM')) THEN
      ddat2_ := trunc(l_bdat_next, 'MM') - 1;
    END IF;
  else
   ddat2_ := nvl(p_date_to, gl.bd);
  END IF;
   --ddat2_ := nvl(p_date_to, gl.bd);
  d_prev := dat_next_u(ddat2_, -1);
  d_next := ddat2_ + 1;

  IF p_type < 0
     AND p_type <> -999 THEN
    -- НА ВИМОГУ- по 1 КД
    OPEN k1 FOR
      SELECT nd, cc_id, sdate, wdate
        FROM cc_deal d
       WHERE nd = (-p_type)
         AND sos >= 10
         AND sos < 14
         AND vidd IN (1, 2, 3, 11, 12, 13);
    -- RAISE_APPLICATION_ERROR(-20008,p_type);
    pul.put('ND', substr(p_type, 2)); --для коректного вібображення view
 elsif p_type=17 then
 OPEN k1 FOR SELECT d.nd, d.cc_id, d.sdate, d.wdate
    FROM cc_deal d, accounts a8, int_accn ia, nd_acc n,nd_txt tz
   WHERE  p_type = 17 AND vidd IN (11, 12, 13)
     AND ia.acc = a8.acc
     and ia.stp_dat is null
     AND n.acc = a8.acc
     AND n.nd = d.nd
     and tz.nd = d.nd
     AND ia.id in(0,1)
     and tz.tag = 'FLAGS'
     and ia.s = 25
     and substr(tz.txt, 2, 1) = '0'
     and d.sos<>15;
 ELSIF p_type = -999 THEN
    -- НА ВИМОГУ- по 1 КД
    OPEN k1 FOR
      SELECT nd, cc_id, sdate, wdate
        FROM cc_deal d
       WHERE nd = (-to_number(pul.get_mas_ini_val('ND')))
         AND sos >= 10
         AND sos < 14
         AND vidd IN (1, 2, 3, 11, 12, 13);

  ELSIF p_type IN (1, 11) THEN

    -- НА ВИМОГУ- по ВСІМ
    OPEN k1 FOR
      SELECT nd, cc_id, sdate, wdate
        FROM cc_deal d
       WHERE sos >= 10
         AND sos < 14
         AND (p_type = 1 AND vidd IN (1, 2, 3) OR
             p_type = 11 AND vidd IN (11, 12, 13));

  ELSIF p_type IN (2, 12) THEN
    -- НА ВИМОГУ- з залишками на SG
    OPEN k1 FOR
      SELECT nd, cc_id, sdate, wdate
        FROM cc_deal d
       WHERE sos >= 10
         AND sos < 14
         AND (p_type = 2 AND vidd IN (1, 2, 3) OR
             p_type = 12 AND vidd IN (11, 12, 13))
         AND EXISTS (SELECT 1
                FROM accounts a, nd_acc n
               WHERE a.ostc > 0
                 AND a.tip = 'SG '
                 AND a.acc = n.acc
                 AND n.nd = d.nd);

  ELSIF p_type IN (3, 13) THEN
    -- ЩОДЕННЕ   - по пл. датах
    OPEN k1 FOR
      SELECT nd, cc_id, sdate, wdate
        FROM cc_deal d
       WHERE sos >= 10
         AND sos < 14
         AND (p_type = 3 AND vidd IN (1, 2, 3) OR
             p_type = 13 AND vidd IN (11, 12, 13))
         AND EXISTS (SELECT 1
                FROM cc_lim
               WHERE nd = d.nd
                 AND fdat > d_prev
                 AND fdat < d_next);
  ELSIF p_type IN (5, 15) THEN
    -- ЩОДЕННЕ   - по пл. датах АНУЇТЕТ
    OPEN k1 FOR
      SELECT UNIQUE d.nd, d.cc_id, d.sdate, d.wdate
        FROM cc_deal d, accounts a8, int_accn ia, nd_acc n
       WHERE sos >= 10
         AND sos < 14
         AND (p_type = 5 AND vidd IN (1, 2, 3) OR
             p_type = 15 AND vidd IN (11, 12, 13))
         AND ia.acc = a8.acc
            --and ia.stp_dat is null
         AND ia.id = 0
         AND n.acc = a8.acc
         AND n.nd = d.nd
         AND ia.basey = 2
         AND ia.basem = 1
         AND ia.id = 0
         AND EXISTS (SELECT 1
                FROM cc_lim
               WHERE nd = d.nd
                 AND fdat > d_prev
                 AND fdat < d_next);

  ELSIF p_type IN (3, 13) THEN
    -- ЩОДЕННЕ   - по пл. датах
    OPEN k1 FOR
      SELECT nd, cc_id, sdate, wdate
        FROM cc_deal d
       WHERE sos >= 10
         AND sos < 14
         AND (p_type = 3 AND vidd IN (1, 2, 3) OR
             p_type = 13 AND vidd IN (11, 12, 13))
         AND EXISTS (SELECT 1
                FROM cc_lim
               WHERE nd = d.nd
                 AND fdat > d_prev
                 AND fdat < d_next);

  ELSIF p_type IN (4, 14) THEN
    -- ЩОДЕННЕ  - по прострочених дог.
    OPEN k1 FOR
      SELECT nd, cc_id, sdate, wdate
        FROM cc_deal d
       WHERE sos = 13
         AND d.wdate < ddat2_
         AND (p_type = 4 AND vidd IN (1, 2, 3) OR
             p_type = 14 AND vidd IN (11, 12, 13));

  END IF;

  IF NOT k1%ISOPEN THEN
    RETURN;
  END IF;

  LOOP
    FETCH k1
      INTO dd.nd, dd.cc_id, dd.sdate, dd.wdate;
    EXIT WHEN k1%NOTFOUND;
    --------------------------------------------

    IF p_type IN (3, 13, 5, 15) THEN
      SELECT MAX(fdat) - 1
        INTO ddat2_
        FROM cc_lim
       WHERE nd = dd.nd
         AND fdat > d_prev
         AND fdat < d_next;
    END IF;

    FOR p IN (SELECT a.nls
                    ,a.accc
                    ,a.acc
                    ,a.tip
                    ,i.basem
                    ,i.basey
                    ,greatest(nvl(i.acr_dat, a.daos - 1), dd.sdate - 1) + 1 ddat1
                    ,i.metr
                    ,i.id
                    ,n.nd

                FROM accounts a, int_accn i, nd_acc n
               WHERE n.nd = dd.nd
                 AND n.acc = a.acc
                 AND a.acc = i.acc
                 AND (i.stp_dat IS NULL or i.stp_dat >=ddat2_)
                 AND (a.tip IN ('SS ', 'SP ', 'LIM', 'SPN', 'SK9','CR9') AND
                     i.id IN (0, 2) OR i.metr = 4 AND i.id = 1)
                 AND i.acra IS NOT NULL
                 AND i.acrb IS NOT NULL
                 AND i.acr_dat < ddat2_)
    LOOP
      DELETE FROM acr_intn;
      l_nazn := NULL;
   if p.tip in('SS ', 'SP ') and p.nd =dd.nd and p.id =0 /*and p.metr=0 and p.basey=0 and p.basem=0*/ then
      acrn.p_int(p.acc, p.id, p.ddat1, ddat2_, nint_, NULL, l_mode);

  elsif
     p.tip IN ('SS ')
         AND p.accc IS NOT NULL
         AND p.basey = 2
         AND p.basem = 1
         AND p.id = 0 THEN
        cck.int_metr_a(p.accc
                      ,p.acc
                      ,p.id
                      ,p.ddat1
                      ,ddat2_
                      ,nint_
                      ,NULL
                      ,l_mode); ------ начисление по ануитету

      ELSIF p.tip IN ('SS ', 'SP ')
            AND p.accc IS NOT NULL
            AND p.id = 0
            AND p.basey <> 2
            AND p.basem <> 1 THEN
        acrn.p_int(p.acc, p.id, p.ddat1, ddat2_, nint_, NULL, l_mode); ------ начисление банковское
      ELSIF p.id = 1
            AND p.metr = 4
            AND p.tip IN ('S36') and p_mode in (0,1) THEN
        acrn.p_int(p.acc, p.id, p.ddat1, ddat2_, nint_, NULL, l_mode); ------ начисление банковское */

        l_nazn := substr('Амортизація рах.(пропорц.) ' || p.nls /*||
                         '. Період: з ' || to_char(p.ddat1, 'dd.mm.yyyy') ||
                         ' по ' || to_char(ddat2_, 'dd.mm.yyyy') || ' вкл.'*/
                        ,1
                        ,160);
      ELSIF p.id = 1
            AND p.metr = 4
            AND p.tip IN ('SDI') THEN
        acrn.p_int(p.acc, p.id, p.ddat1, ddat2_, nint_, NULL, l_mode); ------ начисление банковское */
                l_nazn := substr('Аморт. дисконту по рах.' || p.nls /*||
                         '. Період: з ' || to_char(p.ddat1, 'dd.mm.yyyy') ||
                         ' по ' || to_char(ddat2_, 'dd.mm.yyyy') || ' вкл.'*/
                        ,1
                        ,160);
     ELSIF p.tip IN ('SP ', 'SPN', 'SK9')
            AND p.id = 2  THEN
        acrn.p_int(p.acc, p.id, p.ddat1, ddat2_, nint_, NULL, l_mode); ------ начисление пени

        l_nazn := substr('Нарахування пені. КД № ' || dd.cc_id || ' від  ' ||
                         to_char(dd.sdate, 'dd.mm.yyyy') || ', рах.' ||
                         p.nls /*|| '. Період: з ' ||
                         to_char(p.ddat1, 'dd.mm.yyyy') || ' по ' ||
                         to_char(ddat2_, 'dd.mm.yyyy')*/
                        ,1
                        ,160);

      ELSIF p.tip IN ('CR9')
            AND p.id = 0 THEN
        acrn.p_int(p.acc, p.id, p.ddat1, ddat2_, nint_, NULL, l_mode); ------ начисление пени

        l_nazn := substr('Ком.за невикор.ліміт по рах. ' ||
                         p.nls /*|| '. Період: з ' ||
                         to_char(p.ddat1, 'dd.mm.yyyy') || ' по ' ||
                         to_char(ddat2_, 'dd.mm.yyyy')||' вкл. '*/
                        ,1
                        ,160);
      ELSIF p.metr > 90
            AND p.id = 2
            AND p.tip = 'LIM' THEN
        cc_komissia(p.metr
                   ,p.acc
                   ,p.id
                   ,p.ddat1
                   ,ddat2_
                   ,nint_
                   ,NULL
                   ,l_mode); -------- Начисление комиссий

        l_nazn := substr('Нарахування комісії. КД № ' || dd.cc_id ||
                         ' від  ' || to_char(dd.sdate, 'dd.mm.yyyy') /*||
                         '. Період: з ' || to_char(p.ddat1, 'dd.mm.yyyy') ||
                         ' по ' || to_char(ddat2_, 'dd.mm.yyyy')*/
                        ,1
                        ,160);
      END IF;

      ------------------
      interest_utl.take_reckoning_data(p_base_year => p.basey
                                      ,p_purpose   => l_nazn
                                      ,p_deal_id   => dd.nd);


    END LOOP; -- p\
         update INT_RECKONING t set t.purpose =
       t.purpose || ' Період: з ' || to_char(t.date_from, 'dd.mm.yyyy') ||
       ' по ' || to_char(t.DATE_TO, 'dd.mm.yyyy') || ' вкл.'
         where t.deal_id =dd.nd;
  END LOOP; --k1


  CLOSE k1;
END p_cck_interest;

  PROCEDURE p_interest_cck
  (
    p_type    IN NUMBER DEFAULT 0
   ,p_mode    IN NUMBER
   ,p_date_to IN DATE DEFAULT gl.bd
  ) IS

    /* p_type -0 -ВСІ КД, 1-КД ФО,2-КД ЮО
        P_MODE = 1 , 11 НА ВИМОГУ - по ВСІМ - Щомiсячне Нар. %%  та комісії
        P_MODE = 2 , 12 НА ВИМОГУ - з залишками на SG
        P_MODE=  5,15  ануїтет   ЩОДЕННЕ   - по пл. датах
        P_MODE = 3 , 13 ЩОДЕННЕ   - по пл. датах
        P_MODE = 4 , 14 ЩОДЕННЕ   - по прострочених дог.
        P_MODE < 0 НА ВИМОГУ - по 1 КД
    */
    nint_  NUMBER;
    ddat2_ DATE; -- пл.дата из ГПК -1 или заданная дата  = ПО
    d_prev DATE; -- пред.банк-да та
    d_next DATE; -- след.банк-дата
    l_nazn VARCHAR2(160);
    dd     cc_deal%ROWTYPE;
    k1     SYS_REFCURSOR;
    l_mode INT := 1;

  BEGIN

    IF p_type = 1 THEN

      p_interest_cck1(11, NULL);
      cdb_mediator.pay_accrued_interest;
    ELSIF p_type = 2 THEN
      p_interest_cck1(1, NULL);
      cdb_mediator.pay_accrued_interest;
    END IF;
  END p_interest_cck;
  --Зміна призначення платежу при нарахуванні % в портфелі ССKF i CCKU
  PROCEDURE p_int_reckoning_nazn_edit
  (
    int_id  NUMBER
   ,deal_id NUMBER
   ,p_nazn  VARCHAR2
  ) IS
  BEGIN
    --bars_audit.info('CCK_UI.p_int_reckoning_nazn_edit.int_id='||int_id||' ,deal_id='||deal_id||' ,p_nazn='||p_nazn);
    IF p_nazn IS NOT NULL THEN
      UPDATE int_reckoning t
         SET t.purpose = p_nazn
       WHERE t.id = int_id
         AND t.deal_id = deal_id;
    END IF;

  END p_int_reckoning_nazn_edit;
  /*Зміна суми платежу при нарахуванні % в портфелі CCKU (лише по одному клієнту)
  Постійно виникає розбіжність в сумах за рахунок заокруглень
  */
  PROCEDURE p_int_reckoning_summ_edit
  (
    int_id  NUMBER
   ,deal_id NUMBER
   ,p_summ  NUMBER --дельта на яку вирівнюємо
  ) IS
    l_okpo customer.okpo%TYPE;
  BEGIN

    BEGIN
      SELECT t.okpo
        INTO l_okpo
        FROM customer t, cc_deal t1, int_reckoning t2
       WHERE t2.deal_id = t1.nd
         AND t1.rnk = t.rnk
         AND t2.id = int_id
         AND t1.nd = deal_id;
    EXCEPTION
      WHEN no_data_found THEN
        raise_application_error(-20005
                               ,'По обраним вхідним даним не знайдено інформацію по контрагенту.Операцію не буде виконано!');
    END;
    --bars_audit.info('CCK_UI.p_int_reckoning_nazn_edit.int_id='||int_id||' ,deal_id='||deal_id||' ,p_nazn='||p_nazn);

    IF l_okpo IN ('21515381'
                 ,'2688313610'
                 ,'1919712238'
                 ,'2385703369'
                 ,'2495503820'
                 ,'22927045'
                 ,'20077720') THEN
      UPDATE int_reckoning t
         SET t.interest_amount = t.interest_amount + p_summ
       WHERE t.id = int_id
         AND t.deal_id = deal_id;
    ELSE
      raise_application_error(-20005
                             ,'Для клієнта з ОКПО ' || l_okpo ||
                              ' операція заборонена!');
    END IF;

  END p_int_reckoning_summ_edit;
  -----------------------
  PROCEDURE gpk_bild
  (
    p_nd      NUMBER
   ,p_mode    NUMBER
   ,p_dat_beg DATE
   ,p_dat_pl1 DATE
   ,p_dat_end DATE
   ,p_sumr    NUMBER
  ) IS
    -- Проект ГПК
    dd cc_deal%ROWTYPE;
    d1 cc_add%ROWTYPE;
    ll cc_lim%ROWTYPE;
    aa accounts%ROWTYPE;
    ii int_accn%ROWTYPE;

    l_nd      NUMBER;
    l_mode    NUMBER; -- способ разбиения
    l_dat_beg DATE; -- начало разбиения
    l_dat_pl1 DATE; -- первая пл.дата
    l_dat_end DATE; -- конец разбиения
    l_sumr    NUMBER; -- сумма разбиения
    --l_Freq int     ; -- периодичность
  BEGIN

    l_nd := nvl(p_nd, to_number(pul.get_mas_ini_val('ND')));

    BEGIN
      SELECT *
        INTO dd
        FROM cc_deal d
       WHERE nd = l_nd
         AND vidd IN (1, 2, 3, 11, 12, 13)
         AND d.sos < 14;
      l_dat_end := least(nvl(p_dat_end, dd.wdate), dd.wdate);
    EXCEPTION
      WHEN no_data_found THEN
        raise_application_error(g_errn
                               ,g_errs || 'CC_DEAL:Не знайдено КД ' || l_nd);
    END;

    BEGIN
      SELECT *
        INTO d1
        FROM cc_add
       WHERE nd = dd.nd
         AND adds = 0;
      l_dat_beg := greatest(nvl(p_dat_beg, d1.wdate), d1.wdate);
    EXCEPTION
      WHEN no_data_found THEN
        raise_application_error(g_errn
                               ,g_errs || 'CC_ADD:Не знайдено КД ' ||
                                dd.nd);
    END;

    BEGIN
      SELECT *
        INTO ll
        FROM cc_lim
       WHERE nd = dd.nd
         AND fdat = dd.wdate
         AND lim2 = 0;
    EXCEPTION
      WHEN no_data_found THEN
        raise_application_error(g_errn
                               ,g_errs ||
                                'Невідповідність останньої дати в ГПК=' ||
                                to_char(dd.wdate, ' dd.mm.yyyy'));
    END;


    BEGIN
      SELECT * INTO aa FROM accounts WHERE acc = ll.acc;
    EXCEPTION
      WHEN no_data_found THEN
        raise_application_error(g_errn
                               ,g_errs || 'Не знайдено рах LIM');
    END;

    BEGIN
      SELECT *
        INTO ii
        FROM int_accn
       WHERE acc = ll.acc
         AND id = 0;
    EXCEPTION
      WHEN no_data_found THEN
        raise_application_error(g_errn
                               ,g_errs ||
                                'INT_ACCN:Не знайдено проц.карточку для рах LIM, acc=' ||
                                ll.acc);
    END;

    IF p_dat_pl1 IS NULL THEN
      l_dat_pl1 := nvl(ii.apl_dat, add_months(l_dat_beg, 1));
    ELSE
      l_dat_pl1 := p_dat_pl1;
    END IF;

    IF l_dat_pl1 <= l_dat_beg
       OR l_dat_pl1 >= l_dat_end THEN
      raise_application_error(g_errn
                             ,g_errs || 'Невірно задані дати ' ||
                              to_char(l_dat_beg, 'dd.mm.yyyy') || '<' ||
                              to_char(l_dat_pl1, 'dd.mm.yyyy') || '<' ||
                              to_char(l_dat_end, 'dd.mm.yyyy'));
    END IF;

    IF ii.basem = 1 THEN
      l_mode := 3; -- новый настоящий анитет
    ELSE
      IF p_mode IS NULL THEN
        IF aa.vid = 2 THEN
          l_mode := 1;
        ELSIF aa.vid = 4 THEN
          l_mode := 3;
        ELSE
          l_mode := 2;
        END IF;
      ELSE
        l_mode := p_mode;
      END IF;
    END IF;

    IF l_mode < 1
       OR l_mode > 3 THEN
      raise_application_error(g_errn
                             ,g_errs || 'Невідомий спосіб побудови ГПК ' ||
                              to_char(l_mode));
    END IF;

    IF p_sumr IS NULL THEN
      l_sumr := -aa.ostx / 100;
    ELSE
      l_sumr := p_sumr;
    END IF;

    IF l_sumr = 0 THEN
      raise_application_error(g_errn
                             ,g_errs || 'Не визначено суму погашення ');
    END IF;

    cck.cc_gpk(p_mode
              ,dd.nd
              ,ll.acc
              ,l_dat_beg
              ,l_dat_pl1
              ,l_dat_end
              ,l_sumr
              ,ii.freq
              ,acrn.fprocn(aa.acc, 0, l_dat_beg)
              ,0);

  END gpk_bild;
  PROCEDURE gpk_sumg_bal
  (
    p_nd       cc_deal.nd%TYPE
   ,p_sumg_new cc_lim.lim2%TYPE
  ) IS

    l_deal   cc_deal%ROWTYPE;
    l_cc_lim cc_lim%ROWTYPE;

  BEGIN

    UPDATE cc_lim t
       SET /*t.sumo=(t.sumo-t.sumg)+p_sumg_new * 100
           ,*/ t.sumg = p_sumg_new * 100
     WHERE t.nd = p_nd
       AND t.fdat > gl.bd
       AND t.sumg > 0
       AND t.fdat < (SELECT MAX(fdat) FROM cc_lim t1 WHERE t1.nd = p_nd);
    cck_ui.gpk_bal(NULL, NULL);
  END gpk_sumg_bal;

  PROCEDURE gpk_bal
  (
    p_nd      NUMBER
   ,p_dat_beg DATE DEFAULT gl.bd
   ,p_mode    NUMBER DEFAULT NULL
  ) IS
    --- балансировка тела
    dd        cc_deal%ROWTYPE;
    d1        cc_add%ROWTYPE;
    l_nd      NUMBER;
    l_acc     NUMBER;
    l_vid     NUMBER;
    l_bas     NUMBER;
    l_del     NUMBER;
    l_delm    NUMBER;
    l_dat_beg DATE;
    l_sum     NUMBER;
  BEGIN
    l_nd := nvl(p_nd, to_number(pul.get_mas_ini_val('ND')));

    BEGIN
      SELECT *
        INTO dd
        FROM cc_deal d
       WHERE nd = l_nd
         AND vidd IN (1, 2, 3, 11, 12, 13)
         AND d.sos < 14;
    EXCEPTION
      WHEN no_data_found THEN
        raise_application_error(g_errn
                               ,g_errs || 'CC_DEAL:Не знайдено КД ' || l_nd);
    END;

    BEGIN
      SELECT *
        INTO d1
        FROM cc_add
       WHERE nd = dd.nd
         AND adds = 0;
      l_dat_beg := greatest(nvl(gl.bd, d1.wdate), d1.wdate);
    EXCEPTION
      WHEN no_data_found THEN
        raise_application_error(g_errn
                               ,g_errs || 'CC_ADD:Не знайдено КД ' ||
                                dd.nd);
    END;

    BEGIN
      SELECT a.acc, a.vid, i.basem
        INTO l_acc, l_vid, l_bas
        FROM accounts a, nd_acc n, int_accn i
       WHERE n.nd = l_nd
         AND n.acc = a.acc
         AND a.tip = 'LIM'
         AND a.acc = i.acc
         AND i.id = 0;
    EXCEPTION
      WHEN no_data_found THEN
        raise_application_error(g_errn
                               ,g_errs || '8999*:Не знайдено ');
    END;

    SELECT SUM(sumg) - dd.sdog * 100
      INTO l_del
      FROM cc_lim
     WHERE nd = l_nd
       AND fdat >= l_dat_beg;

        IF l_del <> 0 THEN
      FOR k IN (SELECT ROWID ri, l.*
                  FROM cc_lim l
                 WHERE nd = l_nd
                   AND l.fdat >= gl.bd
                 ORDER BY fdat DESC)
      LOOP
        IF l_del < 0 THEN
          UPDATE cc_lim SET sumg = sumg - l_del WHERE ROWID = k.ri;
          EXIT;
        END IF;
        l_delm := least(k.sumg, l_del);
        UPDATE cc_lim SET sumg = sumg - l_delm WHERE ROWID = k.ri;
        l_del := l_del - l_delm;
        IF l_del = 0 THEN
          EXIT;
        END IF;
      END LOOP;
    END IF;

    UPDATE cc_lim x
       SET x.lim2 = nvl((SELECT SUM(sumg)
                          FROM cc_lim
                         WHERE nd = x.nd

                           AND fdat > x.fdat)
                       ,0)
     WHERE nd = l_nd
       AND fdat >= l_dat_beg;

    --cck.cc_lim_null(l_nd);

    cck.cc_tmp_gpk(l_nd
                  ,l_vid
                  ,l_acc
                  ,l_dat_beg
                  ,dd.wdate
                  ,NULL
                  ,NULL
                  ,NULL);

    cck.cc_lim_gpk(l_nd, l_acc, gl.bdate);

  END gpk_bal;

  PROCEDURE glk_bal
  (
    p_nd      NUMBER
   ,p_dat_beg DATE DEFAULT gl.bd
  ) IS
    --- балансировка лимита

    dd        cc_deal%ROWTYPE;
    d1        cc_add%ROWTYPE;
    l_nd      NUMBER;
    l_acc     NUMBER;
    l_vid     NUMBER;
    l_bas     NUMBER;
    l_del     NUMBER;
    l_delm    NUMBER;
    l_dat_beg DATE;
    l_sum     NUMBER;
  BEGIN
    l_nd := nvl(p_nd, to_number(pul.get_mas_ini_val('ND')));

    /*
    BEGIN
      SELECT *
        INTO dd
        FROM cc_deal d
       WHERE nd = l_nd
         AND vidd IN (2, 3, 12, 13)
         AND d.sos < 14;
    EXCEPTION
      WHEN no_data_found THEN
        raise_application_error(g_errn
                               ,g_errs ||
                                'CC_DEAL*Не знайденоугоду кред.лін');
    END;*/

    -- Превращение ГЛК (Петрокомерц) - ГПК (АЖИО)
    /*  UPDATE cc_lim x
      SET sumg = nvl((SELECT lim2
                       FROM cc_lim
                      WHERE nd = l_nd
                        AND fdat = (SELECT MAX(fdat)
                                      FROM cc_lim
                                     WHERE nd = l_nd
                                       AND fdat < x.fdat))
                    ,lim2) - lim2
    WHERE nd = l_nd;*/
    BEGIN
      SELECT *
        INTO dd
        FROM cc_deal d
       WHERE nd = l_nd
         AND vidd IN (1, 2, 3, 11, 12, 13)
         AND d.sos < 14;
    EXCEPTION
      WHEN no_data_found THEN
        raise_application_error(g_errn
                               ,g_errs || 'CC_ADD:Не знайдено КД ' || l_nd);
    END;
    /*
    SELECT d.sos, d.wdate, f.name||' по ', a.acc, a.kv, a.nls, ad.wdate, nvl(a.vid,0),to_number(trunc(i.s))
      \* INTO :hWndForm.Tbl_Lim.nSOS,  :hWndForm.Tbl_Lim.dfDAT4,:hWndForm.Tbl_Lim.dfFREQ,
            :hWndForm.Tbl_Lim.nAcc8, :hWndForm.Tbl_Lim.nKV8,  :hWndForm.Tbl_Lim.sNLS8,
            :hWndForm.Tbl_Lim.dfDAT3,:hWndForm.Tbl_Lim.nVid, :hWndForm.Day_Pog*\
       FROM cc_deal d, cc_add ad, freq f, cc_lim l, accounts a, int_accn I
       WHERE d.nd = ad.nd AND ad.freq = f.freq
         AND i.id =0 AND i.acc = a.acc AND l.nd = d.nd AND l.acc=a.acc */

    BEGIN
      SELECT a.acc, a.vid, i.basem
        INTO l_acc, l_vid, l_bas
        FROM accounts a, nd_acc n, int_accn i
       WHERE n.nd = l_nd
         AND n.acc = a.acc
         AND a.tip = 'LIM'
         AND a.acc = i.acc
         AND i.id = 0;
    EXCEPTION
      WHEN no_data_found THEN
        raise_application_error(g_errn
                               ,g_errs || '8999*:Не знайдено ');
    END;
    cck.cc_lim_gpk(nd_ => l_nd, acc_ => l_acc, datn_ => gl.bd);

    cck.cc_tmp_gpk(l_nd
                  ,0
                  ,l_acc
                  ,to_date('31/05/2016', 'dd/mm/yyyy')
                  ,to_date('31/05/2016', 'dd/mm/yyyy'));
    cck.lim_bdate(l_nd, gl.bdate);
  END glk_bal;

  PROCEDURE gpk_prc
  (
    p_nd   NUMBER
   ,p_mode NUMBER
  ) IS --- пересчет процентов
  BEGIN
    NULL;
  END gpk_prc;
  ------------------
  PROCEDURE acc_del
  (
    p_nd  NUMBER
   ,p_acc NUMBER
   ,p_tip VARCHAR2
  ) IS -- Вивести рах(без закрытия) з-під КД
  BEGIN
    cck.del_acc(p_nd, NULL, NULL, p_acc);
    -- cck.CC_EXIT_NLS (p_ND  ,             p_acc) ;
  END acc_del;

  PROCEDURE acc_add
  (
    p_nd   NUMBER
   ,p_acc  NUMBER
   ,p_nls  VARCHAR2
   ,p_tip  VARCHAR2
   ,p_kv   INT
   ,p_opn  NUMBER
   ,p_ob22 VARCHAR2 DEFAULT NULL
  ) IS
    -- открыть и присоединить счет

    aa    accounts%ROWTYPE;
    a8    accounts%ROWTYPE;
    dd    cc_deal%ROWTYPE;
    b3_   CHAR(3);
    rr    cck_ob22%ROWTYPE;
    sb    sb_ob22%ROWTYPE;
    ntmp_ NUMBER;
  BEGIN
    IF nvl(p_opn, 0) <> 1 THEN
      raise_application_error(g_errn
                             ,g_errs || 'Відсутнє <<Ок>> на відкриття рах');
    END IF;
    /*IF p_acc IS NOT NULL THEN
      raise_application_error(g_errn
                             ,g_errs || 'Рахунок уже відкрито AСС=' ||
                              p_acc);
    END IF;*/

    BEGIN
      SELECT *
        INTO dd
        FROM cc_deal d
       WHERE nd = p_nd
         AND d.sos < 14;
    EXCEPTION
      WHEN no_data_found THEN
        raise_application_error(g_errn
                               ,g_errs || 'Відсутній KД ' || p_nd);
    END;

    BEGIN
      SELECT a.*
        INTO a8
        FROM accounts a, nd_acc n
       WHERE n.nd = p_nd
         AND a.acc = n.acc
         AND a.tip = 'LIM';
    EXCEPTION
      WHEN no_data_found THEN
        raise_application_error(g_errn
                               ,g_errs || 'Відсутній рах.LIM');
    END;

    BEGIN
      SELECT *
        INTO rr
        FROM cck_ob22
       WHERE nbs || ob22 = substr(dd.prod, 1, 6);
    EXCEPTION
      WHEN no_data_found THEN
        raise_application_error(g_errn
                               ,g_errs || 'CCK_OB22*Відсутній продукт ' ||
                                dd.prod);
    END;
    /*
      b3_    := substr(dd.prod,1,3);
      aa.nbs := CASE WHEN p_tip = 'SS ' THEN  substr(dd.prod,1,4)
                     WHEN p_tip = 'SPI' THEN  b3_|| '5'  -- Премія
                     WHEN p_tip = 'SDI' THEN  b3_|| '6'  -- Дисконт
                     WHEN p_tip = 'SP ' THEN  b3_|| '7'  -- Просрочений осн.борг
                     WHEN p_tip = 'SN ' THEN  b3_|| '8'  -- Процентний борг
                     WHEN p_tip = 'SNO' THEN  b3_|| '8'  -- Процентний борг ВІДКЛАДЕНИЙ
                     WHEN p_tip = 'SPN' THEN  b3_|| '9'  -- Просрочений проц.борг
                     WHEN p_tip = 'SK0' THEN  '3578'     -- Нарах. комісія за кредит
                     WHEN p_tip = 'SG ' THEN  '3739'     -- Рахунок ПОГАШЕННЯ
                     WHEN p_tip = 'SN8' THEN  '8008'     -- Нарах.пеня
                     WHEN p_tip = 'S36' THEN  '3600'     -- Доходи майбутнiх перiодiв
                     WHEN p_tip = 'SK9' THEN  '3600'     -- Просроч. комісія за кредит
                     WHEN p_tip = 'CR9' THEN  '9129'     --
                     end;
       If aa.nbs is null then raise_application_error(g_errn,g_errS||'НЕможливо визначити бал.рах');   end if;
       While 1<2     loop
           nTmp_ := trunc(dbms_random.value(1, 999999999));
           begin select 1 into nTmp_ from accounts where nls like aa.nbs||'_'||nTmp_  and rownum = 1 ;
           EXCEPTION WHEN NO_DATA_FOUND THEN EXIT ;
           end;
       end loop;
    -- aa.nls := cc_f_nls( aa.nbs, a8.Rnk, 4, p_ND,p_Kv,p_TIP );
       aa.nls := aa.nbs||'0'||nTmp_;
    */
  if p_acc is null then
    aa.nls := vkrzn(substr(gl.amfo, 1, 5), p_nls);

    cck.cc_op_nls(p_nd
                 ,p_kv
                 ,aa.nls
                 ,p_tip
                 ,a8.isp
                 ,a8.grp
                 ,NULL
                 ,a8.mdate
                 ,aa.acc);
    end if;
    IF p_ob22 IS NOT NULL and p_acc is  not null THEN
       accreg.setaccountsparam(p_acc, 'OB22', p_ob22);
    elsif p_ob22 IS NOT NULL and p_acc is   null THEN
      BEGIN
        SELECT *
          INTO sb
          FROM sb_ob22
         WHERE r020 = substr(aa.nls, 1, 4)
           AND ob22 = p_ob22
           AND d_close IS NULL;
      EXCEPTION
        WHEN no_data_found THEN
          raise_application_error(g_errn
                                 ,g_errs ||
                                  'SB_OB22*Відсутня аналітика у плані рахунків NBS = ' ||
                                  substr(aa.nls, 1, 4) || ' OB22= ' ||
                                  p_ob22);
      END;

      aa.ob22 := sb.ob22;

    ELSE
      aa.ob22 := CASE
                   WHEN p_tip = 'SS ' THEN
                    rr.ob22
                   WHEN p_tip = 'SPI' THEN
                    rr.spi -- Премія
                   WHEN p_tip = 'SDI' THEN
                    rr.sdi -- Дисконт
                   WHEN p_tip = 'SP ' THEN
                    rr.sp -- Просрочений осн.борг
                   WHEN p_tip = 'SN ' THEN
                    rr.sn -- Процентний борг
                   WHEN p_tip = 'SNO' THEN
                    rr.sn -- Процентний борг ВІДКЛАДЕНИЙ
                   WHEN p_tip = 'SPN' THEN
                    rr.spn -- Просрочений проц.борг
                   WHEN p_tip = 'SK0' THEN
                    rr.sk0 -- Нарах. комісія за кредит
                   WHEN p_tip = 'SG ' THEN
                    rr.sg -- Рахунок ПОГАШЕННЯ
                   WHEN p_tip = 'S36' THEN
                    rr.s36 -- Доходи майбутнiх перiодiв
                   WHEN p_tip = 'SK9' THEN
                    rr.sk9 -- Просроч. комісія за кредит
                   WHEN p_tip = 'CR9' THEN
                    rr.cr9 --
                 END;
    END IF;
    --Переглянути логіку по цій процедурі
    if aa.acc is not null and  aa.ob22 is not null then
    accreg.setaccountsparam(aa.acc, 'OB22', aa.ob22);
    end if;

  END acc_add;
  -------------
  PROCEDURE cls(p_nd NUMBER) IS
    ---- Z) Закрити КД
    l_nd  NUMBER;
    l_err VARCHAR(1000);
  BEGIN
    l_nd := nvl(p_nd, to_number(pul.get_mas_ini_val('ND')));
    cck.cc_close(l_nd, l_err);
    IF l_err IS NOT NULL THEN
      raise_application_error(g_errn, g_errs || l_err);
    END IF;
  END cls;
  --------------
  PROCEDURE p9129(p_nd NUMBER) IS
    -- L) Актуализація ліміту КД на вимогу (9129)
    l_nd NUMBER;
  BEGIN
    l_nd := nvl(p_nd, to_number(pul.get_mas_ini_val('ND')));
    cck.cc_day_lim(gl.bdate, l_nd);
    cck.cc_9129(gl.bdate, l_nd, 0);
  END p9129;
  ---------------
  PROCEDURE viza2(p_nd NUMBER) IS
    ---- B) Віза № 2 : "Передати для авторизації"
    l_nd NUMBER;
    dd   cc_deal %ROWTYPE;
  BEGIN
    l_nd := nvl(p_nd, to_number(pul.get_mas_ini_val('ND')));
    BEGIN
      SELECT *
        INTO dd
        FROM cc_deal d
       WHERE nd = l_nd
         AND d.sos < 10;
      IF dd.sos >= 4 THEN
        raise_application_error(g_errn
                               ,g_errs || 'КД уже має більш високу візу=' ||
                                dd.sos);
      END IF;
      UPDATE cc_deal SET sos = 4 WHERE nd = l_nd;
    EXCEPTION
      WHEN no_data_found THEN
        raise_application_error(g_errn
                               ,g_errs || 'КД не знайдено' || l_nd);
    END;
  END viza2;
  ------------------------------
  PROCEDURE rel_nls
  (
    p_nd  NUMBER
   ,p_nls VARCHAR
   ,p_kv  INT
  ) IS
    ---- U) Установити зв`язок довільного рах. з КД
    l_nd  NUMBER;
    aa    accounts%ROWTYPE;
    l_rnk NUMBER;
  BEGIN
    l_nd := nvl(p_nd, to_number(pul.get_mas_ini_val('ND')));

    BEGIN
      SELECT rnk INTO l_rnk FROM cc_deal WHERE nd = l_nd;
    EXCEPTION
      WHEN no_data_found THEN
        raise_application_error(g_errn
                               ,g_errs || 'Договір з РЕФ = ' || l_nd ||
                                ' не знайдено!');
    END;

    BEGIN
      SELECT *
        INTO aa
        FROM accounts
       WHERE kv = p_kv
         AND nls = p_nls
         AND rnk = l_rnk;
    EXCEPTION
      WHEN no_data_found THEN
        raise_application_error(g_errn
                               ,g_errs || 'Рах.' || p_nls || '/' || p_kv ||
                                ' не знайдено або не належить клієнту');
    END;
    IF aa.nbs LIKE '20%'
       OR aa.nbs LIKE '22%'
       OR aa.nbs = case when NEWNBS.GET_STATE =  1 then '3578' else '3579'end
       AND aa.tip = 'SK9'
       OR aa.nbs = '3578'
       AND aa.tip = 'SK0'
       OR aa.nbs = '9129'
       AND aa.tip = 'CR9' THEN
      raise_application_error(g_errn
                             ,g_errs || 'Рах.' || p_nls || '/' || p_kv || '/' ||
                              aa.tip ||
                              ' не допустимий для "ручного" приєднання');
    END IF;
    INSERT INTO nd_acc (nd, acc) VALUES (l_nd, aa.acc);

  END rel_nls;
  -----------------------
  PROCEDURE chk_acc
  (
    p_nd  NUMBER
   ,p_nls VARCHAR
   ,p_kv  INT
   ,dd    OUT cc_deal%ROWTYPE
   ,aa    OUT accounts%ROWTYPE
  ) IS ---- проверить счет
  BEGIN

    BEGIN
      SELECT *
        INTO dd
        FROM cc_deal d
       WHERE nd = p_nd
         AND d.sos < 14;
    EXCEPTION
      WHEN no_data_found THEN
        raise_application_error(g_errn
                               ,g_errs || ' CC_DEAL*не знайдено КД =' || p_nd);
    END;

    IF p_nls IS NULL
       AND p_kv IS NULL THEN
      BEGIN
        SELECT a.*
          INTO aa
          FROM accounts a, nd_acc n
         WHERE a.tip = 'LIM'
           AND a.acc = n.acc
           AND n.nd = p_nd;
      EXCEPTION
        WHEN no_data_found THEN
          raise_application_error(g_errn
                                 ,g_errs ||
                                  'Рах. 8999*LIM  не знайдено для КД =' || p_nd);
      END;
    ELSE
      BEGIN
        SELECT a.*
          INTO aa
          FROM accounts a, nd_acc n
         WHERE a.kv = p_kv
           AND a.nls = p_nls
           AND a.acc = n.acc
           AND n.nd = p_nd;
      EXCEPTION
        WHEN no_data_found THEN
          raise_application_error(g_errn
                                 ,g_errs || 'Рах.' || p_nls || '/' || p_kv ||
                                  ' не знайдено для КД =' || p_nd);
      END;
    END IF;

  END chk_acc;

  PROCEDURE c_irr
  (
    p_mode INT
   ,p_nd   NUMBER
   ,p_dat  DATE
  ) IS
    ---- Розрахунок ЕПС
    l_nd  NUMBER;
    dd    cc_deal%ROWTYPE;
    aa    accounts%ROWTYPE;
    l_dat DATE;
  BEGIN
    l_nd  := nvl(p_nd, to_number(pul.get_mas_ini_val('ND')));
    l_dat := nvl(p_dat, gl.bdate);

    cck_ui.chk_acc(l_nd, NULL, NULL, dd, aa);

    IF p_mode = 0 THEN
      p_irr_bv(-l_nd, l_dat);
    ELSE
      p_irr_bv(l_nd, l_dat);
    END IF;

    BEGIN
      SELECT decode(aa.kv, gl.baseval, sd_m, sd_j)
        INTO aa.ob22
        FROM cck_ob22
       WHERE substr(dd.prod, 1, 6) = nbs || ob22;
      IF length(TRIM(aa.ob22)) > 0 THEN
        IF dd.vidd IN (1, 2, 3) THEN
          aa.nbs := '6020';
        ELSE
          aa.nbs := case when NEWNBS.GET_STATE =  1 then '6052' else '6042' end;
        END IF;
        aa.nls := nbs_ob22_null(aa.nbs, aa.ob22, substr(dd.branch, 1, 15));
        UPDATE int_accn
           SET acrb =
               (SELECT acc
                  FROM accounts
                 WHERE kv = gl.baseval
                   AND nls = aa.nls)
         WHERE acc = aa.acc
           AND id = -2;
      END IF;
    EXCEPTION
      WHEN no_data_found THEN
        NULL;
    END;
    --Call FunNSIEditF("PROT_IRR",2)
  END c_irr;

  ------------------------------------------------------------------------------------------------
  FUNCTION header_version RETURN VARCHAR2 IS
  BEGIN
    RETURN 'Package header ' || g_errs || g_header_version;
  END header_version;
  FUNCTION body_version RETURN VARCHAR2 IS
  BEGIN
    RETURN 'Package body   ' || g_errs || g_body_version;
  END body_version;

---Аномимный блок --------------
BEGIN
  NULL;
END cck_ui;
/
 show err;
 
PROMPT *** Create  grants  CCK_UI ***
grant EXECUTE                                                                on CCK_UI          to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/cck_ui.sql =========*** End *** ====
 PROMPT ===================================================================================== 
 