CREATE OR REPLACE PACKAGE cck IS

  g_header_version CONSTANT VARCHAR2(64) := 'ver.3.25  16/05/2018 ';

  /*
   16.05.2018 Sta Вынос на просрочку тела КЛ после разделения   PROCEDURE cc_asp

   14.02.2018 Sta Анализ НЕ-нул.остатка комиссии перед выдачей кредита (при наличии доп.реквизита по комиссии)
   23.01.2017 LSO Додано призначення платежу для ручного розбіру
   15.02.2016 Sta Контроль пл.инструкций
   24.11.2016 Sta Выдача кредита по списку пл.инструкций)
   05.11.2015 Ste Расширение проц CCK.MULTI_INT_EX на базовую ставку и признак ануитета
   18.05.2014 Sta Процедуры "Добавить счет" . Изъять счет
   13.05.2015 Sta Восстановила старые
                               PROCEDURE CC_IRR (TT_ char, MOD_ int, DAT_ date, RET_ OUT int);
                               PROCEDURE CC_IRR1(TT_ char, MOD_ int, DAT_ date, nDel_ number, RET_ OUT int);
                 Приготовилась делать новые
                               PROCEDURE CC_IRR_NEW (MOD_ int, p_DAT2 date )  -начисление проц.доходов на бал. стоимость по эф.ставке
                               PROCEDURE int_IRR (dd cc_deal%rowtype , p_dat2 date, p_Ref OUT number ) ;
  --------------------------------------------------
   21.01.2015 Сухова - Операция ISG. Перенеен SQL код из cBars017.apl GenericTableSpl: ISG  Индивидуальный ручной разбор сч.гашения
   21.08.2014 Sta Актуализация текущим лимитом дня - вынесла в отдельную процеду LIM_BDATE (p_nd number)
   04.07.2014 DAV Перенес с body переменную G_REPORTS для возможности формирования
                  отчетов по педварительным проводкам для функций не из пакета (напр. CCT.p2067)
   24.04.2014 Sta Новая функция FINT

   Модификация ГПК ФЛ - долгоиграющие изменения
   Плавяющая ставка + патч  ...\SQL\PATCHES.2\patch223.cck

  */
  -----------------
  tobo_     VARCHAR2(12); -- Кто регистрирует
  cc_tobo_  CHAR(1) := '0'; -- 0 инициатор ГБ; 1- инициатор ТОБО
  sumo_cf   NUMBER; -- расчетная сумма аннуитетного платежа
  g_cc_kom_ INT; -- Многоразовая ком по банку
  fl38_asp  INT; --Флаг оплаты для операции  "ASP"
  spn_bri_  INT; -- Базовая ставка пени;

  cc_kvsd8   CHAR(1); -- 1=счет пени открывать в вал КД, иначе в нац.вал.
  cc_daynp   NUMBER; -- Переносить день погашения на 0 - пятницу 1 - понед
  cc_slstp   NUMBER; -- При відкр рах SL призупиняти нарах-ня (0) чи продовжувати нарах - 1
  g_cck_migr NUMBER; -- 1- включен режим миграции
  ern CONSTANT POSITIVE := 203;
  erm VARCHAR2(250);
  err EXCEPTION;
  g_reports NUMBER := 0; -- (1) - включить режим выполнения для отчета
  ---================================================================
  PROCEDURE p_int_save(nd_        cc_deal.nd%type,
                       int_2_val  int_ratn.ir%type default null,
                       int_2_date int_ratn.bdat%type default null,
                       int_3_val  int_ratn.ir%type default null,
                       int_3_date int_ratn.bdat%type default null,
                       p_mode     number default 0 );
  PROCEDURE pl_ins_input
  (
    p_mode  INT
   ,p_nd    NUMBER
   ,p_mfob  VARCHAR2
   ,p_nlsb  VARCHAR2
   ,p_nam_b VARCHAR2
   ,p_id_b  VARCHAR2
   ,p_nazn  VARCHAR2
  );

  PROCEDURE pl_ins_s
  (
    p_s  NUMBER
   ,p_ri VARCHAR2
  );
  PROCEDURE pl_ins(p_nd NUMBER);
  PROCEDURE del_acc
  (
    p_nd  NUMBER
   ,p_nls VARCHAR2
   ,p_kv  INT
   ,p_acc NUMBER
  ); --Процедура "Изъять счет"
  PROCEDURE ins_acc
  (
    p_nd  NUMBER
   ,p_nls VARCHAR2
   ,p_kv  INT
   ,p_acc NUMBER
  ); --Процедура "Добавить счет"
  --------------------------------------------------------------------------
  PROCEDURE isg1
  (
    p_kvd  IN INT
   ,p_nlsd IN VARCHAR2
   ,p_sd   IN NUMBER
   ,p_kvk  IN INT
   ,p_nlsk IN VARCHAR2
   ,p_nazn IN VARCHAR2
   ,p_ref  OUT NUMBER
  );

  --Актуализация текущим лимитом дня - вынесла в отдельную процеду
  PROCEDURE lim_bdate
  (
   p_nd NUMBER, 
   p_dat DATE default gl.bdate
  );

  -- расчет суммы процентов в удельном весе по ГПК за период ( рекомендовано для ануитета)
  FUNCTION fint
  (
    p_nd   IN NUMBER
   ,p_dat1 IN DATE
   , -- дата "С"  включительно
    p_dat2 IN DATE -- дата "По" включительно
  ) RETURN NUMBER;

  -- Пересмотр значений плавающей ставки по базе источника при наступлении периода пересмотра.
  PROCEDURE set_floating_rate(p_nd NUMBER);

  -- Ожидается ли в эту банк-дату p_dat (или ранее, в выходной) по КД или по счету.
  -- 1-да , 0 -нет
  FUNCTION pay_gpk
  (
    p_dat DATE
   ,p_nd  NUMBER
   ,p_acc NUMBER
  ) RETURN NUMBER;

  -- КП S43: Нарахування %%  по поточним платіж. датам у КП ФЛ
  PROCEDURE int_metr_fl
  (
    p_dat DATE
   ,p_nd  NUMBER
  );

  --18.07.2012 Sta проц нач. % по ануитету.вызов из Bars010.apd для одного счета
  PROCEDURE int_metr_a
  (
    p_accc IN NUMBER
   , -- acc для 8999*LIM
    p_acc  IN NUMBER
   , -- acc для 2203*SSM
    p_id   IN INT
   , -- = 0
    p_dat1 IN DATE
   , -- дата "С"  включительно
    p_dat2 IN DATE
   , -- дата "По" включительно
    p_int  OUT NUMBER
   , -- Сумма процентов
    p_ost  IN NUMBER
   , -- null -- не исп
    p_mode IN NUMBER -- = 1
  );

  ----------------------------------
  -- процедура по установке платежных реквизитов по кредиту
  PROCEDURE set_pmt_instructions
  (
    p_nd       cc_add.nd%TYPE
   , -- реф КД
    p_mfokred  cc_add.mfokred%TYPE
   , -- Платежные инструкции МФО
    p_nlskred  cc_add.acckred%TYPE
   , --     -------//------- счет
    p_okpokred cc_add.okpokred%TYPE
   , -- ИПН получателя
    p_namkred  cc_add.namkred%TYPE
   , -- Наименование счета получателя
    p_naznkred cc_add.naznkred%TYPE -- Назначение платежа
  );

  ----------------------------
  PROCEDURE update_obs
  (
    dat_ DATE
   ,nd_  INT
  );
  --автоматичне визначення параметру "обслуговування боргу".

  -----------------------------------
  PROCEDURE get_info /*  для получения инф по КД Демарк*/
  (
    cc_id_  IN VARCHAR2
   , -- идентификатор   КД
    dat1_   IN DATE
   , -- дата ввода      КД
    nret_   OUT INT
   , -- Код возврата: =1 не найден, Найден =0
    sret_   OUT VARCHAR2
   , -- Текст ошибки (?)
    rnk_    OUT INT
   , -- Рег № заемщика
    ns_     OUT NUMBER
   , -- Сумма текущего платежа
    ns1_    OUT NUMBER
   , -- Сумма окончательного платежа
    nmk_    OUT VARCHAR2
   , -- наименованик клиента
    okpo_   OUT VARCHAR2
   , -- OKPO         клиента
    adres_  OUT VARCHAR2
   , -- адрес        клиента
    kv_     OUT INT
   , -- код валюты   КД
    lcv_    OUT VARCHAR2
   , -- ISO валюты   КД
    namev_  OUT VARCHAR2
   , -- валютa       КД
    unit_   OUT VARCHAR2
   , -- коп.валюты   КД
    gender_ OUT VARCHAR2
   , -- пол валюты   КД
    nss_    OUT NUMBER
   , -- Тек.Сумма осн.долга
    dat4_   OUT DATE
   , --\ дата завершения КД
    nss1_   OUT NUMBER
   , --/ Оконч.Сумма осн.долга
    dat_sn_ OUT DATE
   , --\ По какую дату нач %
    nsn_    OUT NUMBER
   , --/ Сумма нач %
    nsn1_   OUT NUMBER
   , -- | Оконч.Сумма проц.долга
    dat_sk_ OUT DATE
   , --\ По какую дату нач ком
    nsk_    OUT NUMBER
   , --/ сумма уже начисленной комиссии
    nsk1_   OUT NUMBER
   , --| Оконч.Сумма комис.долга
    kv_kom_ OUT INT
   , -- Вал комиссии
    dat_sp_ OUT DATE
   , -- По какую дату нач пеня
    nsp_    OUT NUMBER
   , -- сумма уже начисленной пени
    sn8_nls OUT VARCHAR2
   , --\
    sd8_nls OUT VARCHAR2
   , --/ счета начисления пени
    mfok_   OUT VARCHAR2
   , --\
    nlsk_   OUT VARCHAR2 --/ счет гашения
  );
  ---------------------------------------------
  FUNCTION fbs
  (
    nd_  INT
   ,acc_ INT
   ,dat_ DATE
  ) RETURN NUMBER;
  -- фактична балансова вартiсть КД в вал КД

  FUNCTION pbs
  (
    nd_  INT
   ,acc_ INT
   ,dat_ DATE
  ) RETURN NUMBER;
  -- планова балансова вартiсть КД в вал КД
  -----------------
  PROCEDURE cc_wdate
  (
    custtype_ INT
   ,dat_      DATE
   ,mode_     INT
  );
  /* 22.09.2006 Sta  Перенос на просрочку всех долгов на след.день после dd_deal.WDATE
     CUSTTYPE_: =1 КП БАНКИ (НБУ), =2 КП ЮЛ, =3 КП ФЛ , =0 КП ЮЛ+ФЛ,
     DAT_     : =  банковская дата
     Mode_    : =0 Для всех КД или Mode_=Реф.КД;
  */
  PROCEDURE p_after_open_deal
  (
    p_tbl_name_1 VARCHAR2 DEFAULT 'INT_RATN'
   ,p_acc        int_ratn.acc%TYPE
   ,p_id         int_ratn.id%TYPE
   ,p_bdat       int_ratn.bdat%TYPE
   ,p_ir         int_ratn.ir%TYPE DEFAULT NULL
   ,p_br         int_ratn.ir%TYPE
   ,p_op         int_ratn.op%TYPE

  );
  -----------------
  PROCEDURE cc_asg_sn8
  (
    nd_      INT
   ,nls_6397 VARCHAR2
   ,nls_8006 VARCHAR2
  );
  --Авто-погашение пени.
  ----------------
  PROCEDURE cc_update
  (
    nd_      INT
   ,dat1_    DATE
   ,dat2_    DATE
   ,dat3_    DATE
   ,dat4_    DATE
   ,nvidd_   INT
   ,cc_id_   VARCHAR2
   ,summa_   NUMBER
   ,isp_     NUMBER
   ,ssource_ VARCHAR2
   ,blk_     NUMBER
   ,nlsb_    VARCHAR2
   ,mfob_    VARCHAR2
   ,acc8_    NUMBER
   ,accs_    NUMBER
   ,rday_    NUMBER
   ,ndi_     INT
  );
  --------------------------------------------------
  PROCEDURE cc_irr
  (
    tt_  CHAR
   ,mod_ INT
   ,dat_ DATE
   ,ret_ OUT INT
  );
  PROCEDURE cc_irr1
  (
    tt_   CHAR
   ,mod_  INT
   ,dat_  DATE
   ,ndel_ NUMBER
   ,ret_  OUT INT
  );
  --------------------------------------------------
  PROCEDURE cc_irr_new
  (
    mod_   INT
   ,p_dat2 DATE
  );
  /* 10.03.2015 начисление проц.доходов на бал. стоимость по эф.ставке
     затвердженого постановою Правління НБУ від 25.01.2012 № 23,
    зареєстрованого в Міністерстві юстиції України 15.02.2012 за № 231/20544 (зі змінами)
  */
  PROCEDURE int_irr
  (
    dd     cc_deal%ROWTYPE
   ,p_dat2 DATE
   ,p_ref  OUT NUMBER
  );
  --------------------------------------------------

  PROCEDURE an_gpk
  (
    nd_  INT
   ,s1_  NUMBER
   ,den_ INT
  );
  --построение ГПК с суммой гашения 1 платежа (S1_) в указанный день(Den_)

  FUNCTION r011_s181
  (
    acc_ INT
   ,nd_  INT
  ) RETURN CHAR;
  --Спецпарам R011 + S181

  FUNCTION sum_int
  (
    kv8_ INT
   ,nd_  INT
   ,dat_ DATE
  ) RETURN NUMBER;
  --Сумма проц по договору в базовой валюте договора на дату
  ----------------------------------------
  FUNCTION sum_spn(nd_ INT) RETURN NUMBER;
  --Сумма просроч проц по договору на тек банк дату
  ---------------------------------------------
  FUNCTION sum_asg
  (
    nd_ INT
   ,kv_ INT
  ) RETURN NUMBER;
  --Сумма ожидаемого платежа по КД в заданной валюте на тек банк дату
  ----------------------------------------

  /*
    FUNCTION CC_DAY_POG (FDAT_ date,DAY_ number, KV_ number :=gl.baseval, DAYNP_ number:=CC_DAYNP) return DATE;
  --Совмещает дату (месяц и год) с днем погашения
  --после чего произодит проверку на кор-ку выходного дня
  -- самостоятельно вызывая процедуру CorrectDate2
  -- при DAYNP_=null - кор-ку выходных делать не будет

  */

  ----------------------------------------
  PROCEDURE cc_reports(p_id NUMBER);

  --  Выполнять автоматические операции КП в режиме отчетов
  ----------------------------------------
  FUNCTION correctdate
  (
    kv_      INT
   ,olddate_ DATE
   ,enddate_ DATE
  ) RETURN DATE;
  --Вычисление ближайшей рабочей даты
  --------------------------
  FUNCTION nls0
  (
    nd_  INT
   ,tip_ CHAR
  ) RETURN VARCHAR2;
  --PRAGMA RESTRICT_REFERENCES ( NLS0, WNDS );
  -- Прогноз номера счета по КД заданного вида
  ---------------
  FUNCTION cc_stop(ref_ INT) RETURN NUMBER;
  --PRAGMA RESTRICT_REFERENCES ( CC_STOP, WNDS );
  --  Стоп-правило при превышении лимита-2 при выдаче кредита по пл.остатку
  ---------------
  FUNCTION pmt
  (
    prcperiod_ NUMBER
   ,kolrazb_   INT
   ,summakred_ NUMBER
  ) RETURN NUMBER;
  --        PMT(RATE_*(DAT4_-DAT3_)/365,KOL2_,-LIM2_))
  --PRAGMA RESTRICT_REFERENCES ( PMT, WNDS );
  --  вычисление константы для кредита
  ---------------
  FUNCTION pmt1
  (
    nr  NUMBER
   ,nn  NUMBER
   ,npv NUMBER
   ,nfv NUMBER
  ) RETURN NUMBER;
  --Calculate rent payment (Пономаренко Андрей)

  ---------------
  FUNCTION ost_v
  (
    acc_  INT
   ,fdat_ DATE
  ) RETURN NUMBER;
  --PRAGMA RESTRICT_REFERENCES ( OST_V, WNDS );
  --  Вх.остаток
  ----------------
  PROCEDURE cc_lim_null(p_nd NUMBER);
  --наполнение CC_LIM хотя бы одной записью

  PROCEDURE cc_lim_del(nd_ INT);
  --удаление "модельных" КД

  -----------------
  PROCEDURE cc_kv
  (
    nd_  INT
   ,kv1_ INT
   ,kv2_ INT
  );
  --переустановка другой баз.валюты
  ----------------
  PROCEDURE cc_analiz
  (
    ntip_ur_ INT
   ,ntip_kl_ INT
   ,ngr_     INT
   ,dat1_    DATE
   ,dat2_    DATE
  );
  -- "Анализ ресурса, ставок, сроков "

  -------------
  PROCEDURE cc_analiz1
  (
    bkv_  INT
   ,dat1_ DATE
   ,dat2_ DATE
  );
  -- процедура-1(более сложная по алгоритму ПЕТРОКОМЕРЦ) анализа КП
  -----------------
  PROCEDURE cc_open
  (
    nd_    IN OUT INT
   ,nrnk   INT
   ,cc_id_ VARCHAR2
   ,dat1   DATE
   ,dat4   DATE
   ,dat2   DATE
   ,dat3   DATE
   ,nkv    INT
   ,ns     NUMBER
   ,nvid   INT
   ,nisto  INT
   ,ncel   INT
   ,ms_nx  VARCHAR2
   ,nfin   INT
   ,nobs   INT
   ,saim   VARCHAR2
   ,id_    INT
   ,nls    VARCHAR2
   ,nbank  NUMBER
   ,nfreq  INT
   ,dfproc NUMBER
   ,nbasey INT
   ,dfden  INT
   ,datnp  DATE
   ,nfreqp INT
   ,nkom   NUMBER
  );
  -- процедура открытия КД
  ---------------------------
  PROCEDURE cc_kor
  (
    acc_    INT
   , -- ACC сч 8999
    nd_     INT
   , -- реф КД
    nrnk_   INT
   , -- Рег № заемщика
    cc_id_  VARCHAR2
   , -- Ид КД
    datzak_ DATE
   , -- дата заключения
    datend_ DATE
   , -- дата завершениф
    datbeg_ DATE
   , -- дата начала действия
    datwid_ DATE
   , -- двта выдачи
    nkv_    INT
   , -- вал КД
    ns_     NUMBER
   , -- сумма по дог в цел. т.е. 10000.00
    nvid_   INT
   , -- вид КД
    nisto_  INT
   , -- код источника финансирования
    ncel_   INT
   , -- код цели
    ms_nx   VARCHAR2
   , -- доп.реквизит
    nfin_   INT
   , -- код фин стану
    nobs_   INT
   , -- код обс долга
    saim_   VARCHAR2
   , -- подробно о цели
    spawn_  VARCHAR2
   , -- подробно об обеспечении
    nkom_   NUMBER
   , -- % комис(был код пользователя, его заменила на gl.AUID)
    nls_    VARCHAR2
   , -- сч для пересисления
    nbank_  NUMBER
   , -- МФО для перечисления
    nfreq_  INT
   , -- периодичность погашения кредита
    dfproc_ NUMBER
   , -- % ставка
    nbasey_ INT
   , -- % база
    dfden_  INT
   , -- день погаш
    datnp_  DATE
   , -- дата начала пог
    nfreqp_ INT
  ); -- периодичность погаш %
  -- процедура обновления КД

  -- Процедура открытия КД ОБНОВЛЕННАЯ

  PROCEDURE cc_open_ext
  (
    p_nd         IN OUT INT
   , -- Реф кредитного договора (системный)
    p_rnk        INT
   , -- РНК залогозаемщика
    p_user_id    INT
   , -- Реф пользователя
    p_branch     VARCHAR2
   , -- BRANCH (инициатор)  nd_txt.INIC
    p_prod       VARCHAR2
   , -- продукт КД
    p_cc_id      VARCHAR2
   , -- № КД (пользовательский)
    p_dat1       DATE
   , -- Дата заключения
    p_dat2       DATE
   , -- Дата начала действия
    p_dat3       DATE
   , -- Дата выдачи (плановая)
    p_dat4       DATE
   , -- Дата окончания КД
    p_kv         INT
   , -- Код валюты
    p_s          NUMBER
   , -- Сума КД  (с коп-ми)
    p_vidd       INT
   , -- Вид договора (1,2,3 - ЮЛ , 11,12,13 - ФЛ)
    p_sour       INT
   , -- Источник валютной выручки
    p_aim        INT
   , -- Цель кредитования
    p_ms_nx      VARCHAR2
   , -- Галузь (S260)
    p_fin        INT
   , -- Фин стан
    p_obs        INT
   , -- Обслуживание долга
    p_ir         NUMBER
   , -- Процентная ставка
    p_op         INT
   , -- тип операции для % ставки
    p_br         INT
   , -- Базовая ставка
    p_basey      INT
   , -- База начисления
    p_dat_stp_ir DATE
   , -- Дата приостановления начисления процентов

    p_type_gpk INT
   , -- Тип погашения (0 - индив 2- равн част 4 ануитет)
    p_daynp    INT
   , -- Кор-ка выходных дней в ГПК
    p_freq     INT
   , -- Периодичность начисления по телу
    p_den      INT
   , -- День погашения
    p_datf     DATE
   , -- Первая дата погашения тела

    p_freqi INT
   , -- Периодичность начисления %
    p_deni  INT
   , -- День погашения %
    p_datfi DATE
   , -- Первая дата погашения %

    p_rang     INT
   , -- Шаблон погашения
    p_holidays INT
   , -- каникулы
    p_method   INT
   , -- способ начисления процентов

    p_mfokred  NUMBER
   , -- Платежные инструкции МФО
    p_nlskred  VARCHAR2
   , --     -------//------- счет
    p_okpokred VARCHAR2
   , -- OKPO получателя
    p_namkred  VARCHAR2
   , -- Наименование получателя
    p_naznkred VARCHAR2
   , -- назначение платежа

    p_saim      VARCHAR2
   , -- цель  кредитного договора (Текст-устаревшее)
    p_pawn      VARCHAR2
   , -- залог кредитного договора (Текст-устаревшее)
    nd_external VARCHAR2 -- идентификатор внешней системы (мигрированные КД)
  );

  PROCEDURE cc_open_com
  (
    p_nd       INT
   , -- Реф кредитного договора (системный)
    p_sdi      NUMBER
   , -- Сумма дисконта,
    p_f        NUMBER
   , -- Сумма первоначальной комиссии,
    p_f_freq   INT
   , -- периодичность уплаты перв комиссии
    p_kom      INT
   , -- Тип комиссии
    p_kom_ir   NUMBER
   , -- % ставка ежем-ной комис или сума в завис от метода
    p_kom_freq INT
   , --  периодичность ежемесячной комиссии
    p_kom_datf DATE
   , -- Дата первого начисления
    p_kom_date DATE
   , -- Дата окончания начисления
    p_kom_kv   INT
   , -- Вал.сч.для деб-кой зад-ти (3578) за ежем-ную ком НЕИСПОЛЬЗУЕТСЯ
    p_cr9_kv   INT
   , -- Вал.сч.для деб-кой зад-ти (3578) за неисп лимит
    p_cr9_ir   INT
   , -- % ставка за неисп лимит
    p_cr9_i    INT
   , -- % 0- возобн , 1- не возобн-мая Кред-ная линия
    p_sn8_ir   INT
   , -- % ставка пени
    p_sn8_kv   INT
   , -- % валюта пени
    p_sk4_ir   INT -- % ставка за досрочное погашение
  );

  /*
   Регистрация событий КП клиента и системы
    p_nd  - реф КД
    fdat  - дата наступления события
     id,  - порядковый номер события (для новых пусто)
    isp,  - создатель                (для новых пусто)
    txt,  - текстовое сообщение      (для типизированныз можно пусто)
    otm,  - отметка о состоянии КД   (по умолчанию на контроль)
    freq, - периодичность            (без периодичности)
    psys  - тип события
             null , 0        - безтиповые события
             отрицательные   - события системы
             положительные   - события пользователей
  */

  PROCEDURE cc_sob
  (
    p_nd   INT
   ,p_fdat DATE
   ,p_id   INT
   ,p_isp  INT
   ,p_txt  VARCHAR2
   ,p_otm  INT
   ,p_freq INT
   ,p_psys INT
  );

  ----------------------------
  -- процедура открытия и присоединения счетов к КД
  PROCEDURE cc_op_nls
  (
    nd_     INT
   ,kv_     INT
   ,nls_    VARCHAR2
   ,tip_prt VARCHAR2
   ,isp_    INT
   ,grp_    INT
   ,p080_   CHAR
   ,mda_    DATE
   ,acc_    OUT INT
  );

  -- Вывод счета из под договора без закрытия.
  PROCEDURE cc_exit_nls
  (
    p_nd  INT
   ,p_acc INT
  );

  ---------------------------
  PROCEDURE cc_delete(nd_ INT);
  -- процедура удаления ош. КД
  ---------------------
  PROCEDURE cc_close
  (
    nd_   INT
   ,serr_ OUT VARCHAR2
  );
  -- процедура закрытия КД
  ----------------------
  PROCEDURE cc_autor
  (
    nd_   INT
   ,saim_ VARCHAR2
   ,urov_ VARCHAR2
  );
  -- процедура авторизации КД
  --------------------------------------------------
  -- процедуры запоминания м/вал и баз.проц ставок
  PROCEDURE multi_int_ex
  (
    nd_ NUMBER
   , -- реф КД
    br_ NUMBER
   , -- код баз.ставки или пусто
    an_ INT
   , -- = 1 признак нового ануитета
    k1_ INT
   ,p1_ NUMBER
   ,k2_ INT
   ,p2_ NUMBER
   ,k3_ INT
   ,p3_ NUMBER
   ,k4_ INT
   ,p4_ NUMBER
  );

  PROCEDURE multi_int
  (
    nd_ NUMBER
   ,k1_ INT
   ,p1_ NUMBER
   ,k2_ INT
   ,p2_ NUMBER
   ,k3_ INT
   ,p3_ NUMBER
   ,k4_ INT
   ,p4_ NUMBER
  );
  PROCEDURE br_int
  (
    nd_ NUMBER
   ,br_ NUMBER
  );
  ---------------------------------------------------
  PROCEDURE cc_day_lim
  (
    fdat_ DATE
   ,nn_   INT
  );
  ---
  PROCEDURE rate_lim(acc8_ INT);
  -- Переоценка остатка родительского счета при дочерних в другой валюте
  ----------------------
  PROCEDURE cc_9129
  (
    fdat_ DATE
   ,nd_   INT
   ,tip_  INT
  );
  -- поддержка бс 9129
  ----------------------
  PROCEDURE cc_9031
  (
    fdat_ DATE
   ,nd_   INT
   ,tip_  INT
  );
  -- проводка по 9031 на сумму начального лимита по договору
  -----------------------
  PROCEDURE cc_close9031
  (
    fdat_ DATE
   ,nd_   INT
   ,tip_  INT
  );
  -- снятие с 9031

  ---------------------------
 PROCEDURE cc_grf_lim
  (
   mode_ INT default 1,
   nd_   cc_deal.nd%type,
   acc_  accounts.acc%type,
   fdap_ DATE default gl.bdate
  );
  -- Построение графика лимитов.
  --MODE_ - способ 1-равными суммами
  --ND_   - реф договора
  --ACC_  - консолид счет LIM
  --FDAP_ - дата начала построения);
  ----------------------
  PROCEDURE cc_gpk0
  (
    mode_   INT
   ,nd_0    INT
   ,acc_0   INT
   ,dat3_   DATE
   ,datn_   DATE
   ,dat4_   DATE
   ,sumr_   NUMBER
   ,freq_   INT
   ,rate_   NUMBER
   ,nbasey_ INT
   ,dig_    INT
  );
  -------------------------

  ---14.06.2013 --------------------
  FUNCTION f_dat
  (
    p_dd   NUMBER
   , -- <Платежный день>, по умол =(Null) DD от текущего банк.дня
    p_dat1 DATE
  ) RETURN DATE;
  -- ОПРЕДЕЛЕНИЕ ДАТЫ В МЕС ПО НОМЕРУ ДНЯ

  ---14.06.2013 --------------------
  FUNCTION f_pl1
  (
    p_nd   NUMBER
   ,p_lim2 NUMBER
   , -- новый лимит
    p_gpk  NUMBER
   , -- 4-Ануитет. 2 - Класс ( -- 1-Ануитет. 0 - Класс   )
    p_dd   NUMBER
   , -- <Платежный день>, по умол =(Null) DD от текущего банк.дня
    p_datn DATE
   , -- дата нач КД
    p_datk DATE
   , -- дата конца КД
    p_ir   NUMBER
   , -- проц.ставка
    p_ssr  NUMBER
   , -- признак =0 или Null = "с сохранением срока"
    p_dig  NUMBER DEFAULT 0
  ) RETURN NUMBER;
  -- ОПРЕДЕЛЕНИЕ сумми 1-го пл

  -----14.06.2013 -----------------
  PROCEDURE uni_gpk_fl
  (
    p_lim2  NUMBER
   , -- новый лимит
    p_gpk   NUMBER
   , -- 4-Ануитет. 2 - Класс    ( -- 1-Ануитет. 0 - Класс   )
    p_dd    NUMBER
   , -- <Платежный день>, по умол =(Null) DD от текущего банк.дня
    p_datn  DATE
   , -- дата нач КД
    p_datk  DATE
   , -- дата конца КД
    p_ir    NUMBER
   , -- проц.ставка
    p_pl1   NUMBER
   , -- сумма 1 пл (Null - расчитать автоматически)
    p_ssr   NUMBER
   , -- признак =0 ( Или Null) = "с сохранением срока"
    p_ss    NUMBER
   , -- остаток по норм телу (0 или Null - для начальных ГПК)
    p_acrd  DATE
   , -- с какой даты начислять % acr_dat+1 ( Null = p_datn)
    p_basey NUMBER -- база для нач %%;
  );

  -- универсальная процедура прстроения ГПК для ФЛ по постановке ОБ. Натуральный Ануитет.
  --- конец 14.06.2013 --------------------

  -- старая проц построения ГПК
  PROCEDURE cc_gpk(mode_  INT,
                   nd_    INT,
                   acc_   INT,
                   bdat_1 DATE, -- начало
                   datn_  DATE, -- первая дата погашенпя
                   dat4_  DATE, -- завершение
                   sum1_  NUMBER, -- сумма к погашению в грн (1.00)
                   freq_  INT,
                   rate_  NUMBER, -- годовая % ставка
                   dig_   INT); --Запускати чи ні процедуру cc_tmp_gpk);

  -----------------------------
  PROCEDURE cc_gpk_lim
  (
    p_nd   NUMBER
   ,p_acc8 NUMBER
   ,p_dat1 DATE
   ,p_datn DATE
   ,p_sum1 NUMBER
  );

  ----------------------
 PROCEDURE cc_lim_gpk
  (
    nd_   cc_deal.nd%type
   ,acc_  accounts.acc%type default null
   ,datn_ DATE default gl.bd

  );

  ----------------------
  PROCEDURE cc_sum_pog
  (
    dat1_   DATE
   ,dat2_   DATE
   ,ntip_kl INT
  );
  -- Расчет Прогноз суммы погашения за период работает НА ВРЕМЕННой  ТАБЛИЦе
  ---------------------
  PROCEDURE cc_intn(nd_ INT);
  -- Общий ГЛК +ГПК + ГП%
  ---------------------------------
  PROCEDURE cc_start(nd_ INT);
  --Установить остатки на счете консолидации
  -----------------------
  PROCEDURE cc_sv12
  (
    nd1_ INT
   ,nd2_ INT
  );
  --обединить 2 КД
  -----------------------
  PROCEDURE cc_m_accp
  (
    mod_  INT
   ,nd_   INT
   ,accz_ INT
  );
  --присoединить, oтсоединить залoговый счет
  -------------------
  PROCEDURE cc_9819
  (
    nd_ INT
   ,pr_ INT
  );
  -- ND_ - номер договора
  -- PR_ - 0 - приход (при открытии договора)
  --       1 - расход (при закрытии договора)
  --Учет количества договоров

  PROCEDURE cc_crd
  (
    nd_    INT
   ,pr_    INT
   ,refd_  INT
   ,nls_   VARCHAR2
   ,gold_  VARCHAR2
   ,nddop_ NUMBER
   ,t9819_ VARCHAR2
   ,o9819_ VARCHAR2
   ,fio_   VARCHAR2
   ,vlasn_ VARCHAR2
   ,nazn_  VARCHAR2
   ,crdvd_ DATE
   ,crdsn_ VARCHAR2
   ,crdsk_ VARCHAR2
  );
  --   ND_     номер договора
  --   dk_     Исользовать только 1 или 3 с проводками или без
  --           (информационный необходим особенно при внедрении)
  --   REF_    при постановке пусто в остальных случаях
  --           референс проводки постановки на учет (запоминать в доп параметре CRDND)
  --   NLS_    счет задается только когда необходимо для отправки в дорогу или под отчет
  --   GOLD_   Наименование документа
  --   T9819_  тип залога кредитный, залоговый ...
  --           используется только при постановке в остальных игнорируется
  --   O9819_  при пустом значении поля REF  игнорируется,
  --           для значений 2,4,6,8 необходимо чтобы было заполнено поле NLS
  --   NAZN_   назначение платежа будет подставленно данное иначе
  --           будет сгенерировано процедурой
  --  CRDVD_   Дата постановки на учет (устанавливается пользователем)
  --  CRDSN_   Счет родитель (в общем смысле) необязательный и необязательно счет
  --           Например: по каждому залогу создают счет 95ХХ и под него
  --           обычно оприходывают бланковую единицу
  --            бланковую еденицу
  --  CRDSK_   валюта счета родителя

  --Учет количества персонифицированных договоров

  -----------------------
  PROCEDURE cc_print
  (
    mod_  INT
   ,dat1_ DATE
   ,dat2_ DATE
  );
  -- Печати разные
  -- mod_  - режим
  -- dat1_ - дата начала
  -- dat2_ - дата конца

  -----------------------
  PROCEDURE cc_asg
  (
    nregim_ INT
   ,mode_   INT DEFAULT 1
  );
  --авто разбор счета гашения
  -----------------------
  PROCEDURE cc_asg1(p_nd cc_deal.nd%TYPE);
  --авто разбор счета гашения по одному КД
  -----------------------

  PROCEDURE cc_asp
  (
    p_nd INT
   ,day_ INT
  );
  --авто перенос на просрочку основного долга

  PROCEDURE cc_asp111
  (
    cc_kvsd8 VARCHAR2
   , -- гл.пар CC_KVSD8=1 счет пени в вал КД. Иначе в нац.вал - незав от вал КД.
    dat7_    DATE
   ,p_vob46  INT
   ,p_nd     NUMBER
   , -- реф.КД
    p_acc8   NUMBER
   , -- АСС счета консол
    p_kv     INT
   , -- вал
    p_isp    INT
   , -- исп ссудного сч
    p_grp    NUMBER
   , -- группе дост
    p_s080   VARCHAR2
   , -- кат риска
    p_mdate  DATE
   , -- дата заерш
    p_nmsk   VARCHAR2
   , -- наим.счта
    p_nlsk   VARCHAR2
   , -- номер ссудного счета
    p_cc_id  VARCHAR2
   , -- Ид.КД
    p_sdate  DATE
   , -- Дата начала КД
    p_s      NUMBER -- сумма для в?носа на просрочку
  );

  -----------------------
  PROCEDURE cc_aspn
  (
    custtype_ INT
   ,nd_       INT
   ,day_      INT
  );
  --авто перенос на просрочку долга по процентам

  PROCEDURE cc_aspn_dog
  (
    p_nd    INT
   ,p_cc_id IN VARCHAR2
   ,p_okpo  IN VARCHAR2
   ,p_nmk   IN VARCHAR2
   ,day_    INT
   ,p_max   NUMBER
  );
  --авто перенос на просрочку долга по процентам и комиссии по ОДНОМУ ДОГОВОРУ
  --18.07.2013 Сухова
  -- p_max > 0  - max допусимая сумма для переноса на просрочку - используется в новом ануитете
  -- p_max = Null - по остатку

  --------------------------------

  PROCEDURE cc_prolong
  (
    p_nd  INT
   , -- выбор по всем КД =0, или по одному
    p_dat DATE -- тек.дата
  );

 PROCEDURE cc_tmp_gpk
  (
    nd_      cc_deal.nd%type
   , -- реф КД
    nvid_    INT default null
   , -- вид ГПК = 4 для "типа ануитет", =2 иначе( клас + другое)
    acc8_    accounts.acc%type default null

   , -- АСС для сч 8999
    dat3_    DATE default null
   , -- Первая Дата выдачи КД
    dat4_    DATE default null
   , -- Дата завершения КД
    reserv_  CHAR default null
   , --резевв. не использую
    sumr_    NUMBER default null
   , --РЕЗЕРВ. НЕ ИСПОЛЬЗУЮ -- Новый лимит по КД
    gl_bdate DATE default gl.bd--резевв. не использую
  ) ;

  -------------------
  PROCEDURE cc_isg_nazn
  (
    l_nd   cc_deal.nd%TYPE
   ,l_nazn OUT VARCHAR2
  );
  /**
  * header_version - возвращает версию заголовка пакета CCK
  */
  FUNCTION header_version RETURN VARCHAR2;

  /**
  * body_version - возвращает версию тела пакета CCK
  */
  FUNCTION body_version RETURN VARCHAR2;
  -------------------

END cck;
/
CREATE OR REPLACE PACKAGE BODY BARS.CCK IS

  -------------------------------------------------------------------
  g_body_version CONSTANT VARCHAR2(64) := 'ver.4.17.08  06.08.2018';
  g_errn NUMBER := -20203;
  g_errs VARCHAR2(16) := 'CCK:';
  ------------------------------------------------------------------

  /*
  Формула для пересчета Эф.ст периода-Y в период-X
  X =  1,  Y = 365, IRR_1   = POWER ( (1+IRR_365),  1/365 ) -1 ;
  X = 31,  Y = 365, IRR_31  = POWER ( (1+IRR_365), 31/365 ) -1 ;
  X =365,  Y =  30, IRR_365 = POWER ( (1+IRR_30), 365/30  ) -1 ;
             =  1,20%  = 0.012
  select   POWER ( (1+0.012), 365/30 ) -1  IRR_365  from dual; -- 0.156190958390941
  IRR_365 = 0.156190958390941 = 15.6190958390941 %
  ----------------------------------------------
  */

  /*
22.02.2018 LSO Убрал проверку зарегестрирован ли счет по договору в процедуре cc_op_nls, так как там неверно отрабатывает.
01-08-2018 VPogoda  закрытие гендоговора с субдоговорами
22.05.2018 Sta PROCEDURE lim_bdate: Не делаем ничего для Суб/дог, хотя у них есть технический ГПК( в cc_lim 2 записи), а только для простых КД или ген.дог.
               FUNCTION cc_stop: Для операции КК1 + дебет счета SS - для проверки нач.комиссии
17.05.2018 Sta  PROCEDURE cc_day_lim + PROCEDURE lim_bdate  Обновление cc_deal.limit, cc_add.s, accounts.ostx по суб.дог

16.05.2018 Sta Вынос на просрочку тела КЛ после разделения   PROCEDURE cc_asp
26.02.2018 Sta Код вал Суб.дог определять не по счету SS, а по счету LIM
22.02.2018 LSO Добавление субдоговоров для пролонгации CC_PROLONG
22.02.2018 Sta Манипуляции псо счетом SG
  29.12.2016 Sta COBUSUPABS-5046
     При открытие счетов (раздел 20** и 22** ) в КП по "птичке" программа будет
     •  блокировать открытие - если таковой счет уже существует. При этом неважно – закрыт этот счет, или открыт в настоящее время.
          Таким образом,  присоединение ранее открытых вне портфеля счетов 20** и 22**  будет невозможным – что и требует от нас ХД.
     •  При выведении из-под КД счетов 20** и 22**  по кнопке тоже будет сообщение об ошибке – это тоже требование ХД.
          Для разовой чистки «неродных КД » счетов 20** и 22**  можно будет применить скрипт.
          Но в любом случае – это действие надо будет согласовывать с ХД.



   21.10.2016 Sta http://jira.unity-bars.com.ua:11000/browse/COBUSUPABS-4219
                  procedure UNI_GPK_FL - зауваження бізнеса після тестування
                  Банк-Дата - 29/07/2016   ND – 15387321 База HRSNTBD3 (HOST = 10.254.15.102)(PORT = 1521)) (як у вас на барсі не знаю)
   26/08/2016 LSO Перенёс в процедуре CC_CLOSE проверки и выход из неё если счета открыты.
   27.05.2016 LSO У  процедурі PL_ins поправлено виборку у курсорі по реф. договору, без неї йшло по всім записам
   26.05.2016 Sta COBUSUPABS-4501 Прошу підтвердити всі можливі комбінації операції видачі кредиту в б/гот формі
              Нехай: Позичальник =К1, Отримувач (Торговець) =К2

              Крок-1
              1) Деб.2203*К1 - Кред 2620*К1 - Для всіх комбінацій
              х) Деб.2203*К1 - Кред 2625*К1 - ВИКЛЮЧАЄТЬСЯ В принципі, як помилка

              Крок-2
              2.1.) KK1 Деб.2620*К1 - ВН.2600*К2 ( 2620*К2)
              2.2.) KK2 Деб.2620*К1 - МБ.2600*К2 МФО-Б.2600*К2
              2.3.) W43 Деб.2620*К1 - ПЦ.2605*К2 (2625*К2 ) - по схемі зарахування на БПК через 2924

   16.05.2016 LSO У новій версії процедури CC_TMP_GPK поправлено помилку невстановлення ліміту при побудові ГПК tmp(d8).Lim2 := tmp(d8).lim1 - tmp(d8).sumg;
   13.05.2016 Sta Фастованова Анна commented on COBUPRVN-225:
                  проверочное условие при авторизации кредита на установку > - VNCRP "Первинний ВКР" + > - VNCRR "Поточний ВКР"
                  должно выполнятся для всех РУ кроме ЦА.

   11.05.2016 Sta Добавила в сортировку при разборе счетов гашения   decode (a.nbs,  '3739',1,  '2620',2, 3 )   -- Щуцька Ірина Петрівна <ShutskaIP@oschadbank.ua>
   24/04/2016 LSO CC_OP_NLS Перенос ставок из счёта 8999 на SS, если их несколько.
   20.04.2016 Sta Доп.действия при обвязке счета от КД
   18.04.2016 Sta Абсолютная блокировка междоговорных привязок счетов PROCEDURE CC_OP_NLS
   14.04.2016 Sta COBUSUPABS-4449  проц.Ins_acc
                  Під час відкриття (присоединения) нового рахунку з типом SNO, параметру R013 такого рахунку має автоматично присвоюватись значення «4».
   11.04.2016 LUDA Остатки на счетах собственных договоров залога КД обнуляются при закрытии договора
                   (заявка COBUPRVN-154 - cc_close)
   30/03/2016 Lso   COBUSUPABS-4376 cc_autor
      Забезпечення неможливості авторизації заявок на кредитні угоди (окрім кредитів по БПК),
      якщо позичальник є інсайдером.
   16.02.2016 Sta   В процедуру cck.cc_close внесены соответствующие условия по "НЕзакрытию" tip like '%SG%'  TAG =  'MGR_T'
   15.02.2016 Sta Контроль пл.инструкций
   10.02.2016 LitvinSO По уточнению Новикова А.
              Процедура CC_ASPN_DOG
              Есть ошибка:
              If p_max > 0 then    s_:= least (s_, p_max);   end if;
              А должно быть  (=>)
              If p_max => 0 then    s_:= least (s_, p_max);   end if;
              Иначе будут некорректно переноситься % на прострочку.
              Поправлена процедура СС_9129, добавлен блок населения счёта NLS99_

   03.02.2016 Sta Отключение  возможности   ПЕРЕ-установки баз.вал, процедура = CCK.CC_KV( ND1, KV1, KV2 )
   27/01/2016 LitvinSO (COBUSUPABS-3976) В цикл P(строчка 6454) Додано сортування по d.wdate
   24.11.2016 Sta Выдача кредита по списку пл.инструкций)
   05.01.2016 Sta  Несколько пл.инструкций
   24.12.2015 Sta -- [JIRA] (COBUPRVN-225) Забезпечити перевірку заповнення параметрів ВКР при авторизації кредитних договорів
   18.12.2015 Sta+Lebedinskiy  Cделать курсор по датам изменения ставки - должно работать и для клас и для наст ануитета
   07.12.2015 Sta /COBUSUPABS-4011   Формувати назву рахунку згідно наступного шаблону: <номер угоди>< назва клієнта>
   04.12.2015 Sta Снова тестируем злополучную процедурк по пересчету процентов CC_TMP_GPK
   26.11.2015 Sta [JIRA] (COBUSUPABS-3976) Заявка на модифікацію  № 14/1- 428  ID: 4504 від  24.11.2015
   !!!!!!!!!!!    уже без AWK  !!!!!!
   16.11.2015 Sta Расширение проц CCK.MULTI_INT_EX на базовую ставку и HE ануитет

   13.11.2015 Sta Для ЮЛ сохраняем возможность АНУИТЕТО-ПОДОБНОГО ГПК . кот не есть настоящим Ануитетом.
   05.11.2015 Ste Расширение проц CCK.MULTI_INT_EX на базовую ставку и признак ануитета
   03.11.2015 Sta PROCEDURE INT_METR_FL - добавили вид КД = 1 для ЮЛ/        Обновление cc_add.ACCS
   28-10-2015 Cухова+Лебединский - отключинли в пересчете проц новый АНУИТЕТ. Перешли на ACRN.p_Int - для перем прой ставок
              Пересчет процентов по ГПК - на проверке у Ж.Мешко.
   24.09.2015 Сухова Сдвиг пл.даты "вперед", но в рамках тек.месяца
   04-09-2015 Sta b_date
   21-08-2015 Sta Я тут маленькую ош нашла (в построении анутета с началом в будущем, просто такого ранее не встречалось) .
       Исправила  PDAT_ := CCK.f_dat (L_DD, TRUNC(greatest(gl.bd,p_datn) ,'MM'));
   11.06.2015 Sta Ануитет по-новому для ЮЛ (ОСББ) - заявка
   09.06.2015 nov cc_reports - добавлена контекстная переменная 'cc_reports_id которая позволит создавать документы, при наличии доступа
                               пользователя к основной автомат-ой процедуре. заявка  COBUSUPABS-3535
                  cc_aspn_dog - изьят блок определения суммы резервирования переначисленных процентов по новым аннуитетам
                               (например когда начисляют по 31 число и с учетом начисленных % с 2207)
                               процедура теперь полагаентся по этим кредитам на поле p_max , сумму определяет процедура cck_sber.
   03.06.2015 Sta CCK.ISG1 - в части мультавал погашения
   18.05.2015 Sta Процедуры "Добавить счет" . Изъять счет
   13.05.2015 Sta Восстановила старые
                               PROCEDURE CC_IRR (TT_ char, MOD_ int, DAT_ date, RET_ OUT int)
                               PROCEDURE CC_IRR1(TT_ char, MOD_ int, DAT_ date, nDel_ number, RET_ OUT int)
                 Приготовилась делать новые
                               PROCEDURE CC_IRR_NEW (MOD_ int, p_DAT2 date )  -начисление проц.доходов на бал. стоимость по эф.ставке
                               PROCEDURE int_IRR (dd cc_deal%rowtype , p_dat2 date, p_Ref OUT number )
   -----------------------
  12-05-2015 function f_pl1  расчет суммы одного пл. Кол-во периодов
  02/04/2015 nov  Исправлена ошибка в функц авторазбора ануитетных %. При превышении даты начисления больше плат-ной запрос на дату начисления начинал возвращать null
                  в следствии чего дальнейший алгоритм не коректно отрабатывал и переставл списывать проценты.
                 - Убрал проверку на наличие остатка на счете 2625  (она есть ниже по процедуре с более сложной логикой)
  02.04.2015 Sta Передаю Саше Н для локалтных изм

  24.03.2015 DAV В процедуру закрытия договоров добавил тип счета S36      согласно заявки http://jira.unity-bars.com.ua:11000/browse/COBUPRVN-174
  10.03.2015 начисление проц.доходов на бал. стоимость по эф.ставке
              Начала работу ....... PROCEDURE CC_IRR (MOD_ int, p_DAT2 date ) is
     затвердженого постановою Правління НБУ від 25.01.2012 № 23,
     зареєстрованого в Міністерстві юстиції України 15.02.2012 за № 231/20544 (зі змінами)

  06.03.2015 Sta COBUSUPABS-3018  Шарадов И.Ю.
  Уточнення до процедури погашення:
  - Якщо у клієнта є хоча б одна прострочка (тіло=SP, відсотки=SPN, комісія=SK9, пеня=SN8),
    то при формуванні файла на ПЦ здійснюється перевірка залишку 2625 в АБС.
    В разі недостатності коштів на 2625 файл на ПЦ формується в межах кредитового залишку 2625.
  -------------------------------------------------
    02.03.2015 Sta Опеределение acr_dat в случае нескольки ссудных сч
    06.02.2015 Sta Новый код операции для гашения с 2625* - из гл.парам. По умолч W4X
                   Неснижаемый остаток  S29_ := 10000000000000;  -- Неорганиченный. т.к. неизвестный. М.б будет сенрвис - узнать остаток
    04.02.2015 Sta Хочу бас.сч 8999 сделать null. Оставить тип сч = LIM.Сохранить номер лиц/сч = 8999_ND
    27.01.2015 Сухова Закомм -- день платежный и уже сегодня платили 1 раз, больше не надо.
    21.01.2015 Сухова - Операция ISG1. Перенеен SQL код из cBars017.apl GenericTableSpl: ISG  Индивидуальный ручной разбор сч.гашения
    08.01.2015 Сухова- сделать «полную ревизию»  на правильность установки АССС и типа счета:
               1) Установить АССС для типов SS, SP, SL
               2) Отменить АССС всех для типов, кроме SS, SP, SL
     06.01.2015 Sta исправить старый глюк с процедуре cck.cc_day_lim
  */

 ------------------------------------------------------------
  PROCEDURE p_int_save(nd_        cc_deal.nd%type,
                       int_2_val  int_ratn.ir%type default null,
                       int_2_date int_ratn.bdat%type default null,
                       int_3_val  int_ratn.ir%type default null,
                       int_3_date int_ratn.bdat%type default null,
                       p_mode     number default 0) is
    l_acc        accounts.acc%type;
    l_ss_acc     accounts.acc%type;
    l_int_2_val  int_ratn.ir%type;
    l_int_2_date int_ratn.bdat%type;
    l_int_3_val  int_ratn.ir%type;
    l_int_3_date int_ratn.bdat%type;
    v_gpk_type   int_accn.basem%type;
  begin
    l_int_2_val  := int_2_val;
    l_int_3_val  := int_3_val;
    l_int_2_date := int_2_date;
    l_int_3_date := int_3_date;
   /* if l_int_2_val is null and l_int_2_date is null then
      begin
        SELECT R2_VAL,
               R3_VAL,
               to_date(R2_DATE, 'dd/mm/yyyy'),
               to_date(R3_DATE, 'dd/mm/yyyy')
          into l_int_2_val, l_int_3_val, l_int_2_date, l_int_3_date
          FROM (SELECT t.nd, t.tag, t.txt
                  FROM nd_txt t
                 WHERE t.tag IN ('R2_VAL', 'R3_VAL', 'R2_DATE', 'R3_DATE'))
        PIVOT(MAX(txt)
           FOR tag IN('R2_VAL' R2_VAL,
                      'R3_VAL' R3_VAL,
                      'R2_DATE' R2_DATE,
                      'R3_DATE' R3_DATE))
         where nd = nd_;
      exception
        when no_data_found then
          null;
      end;
    end if;*/
    begin
      select a.acc,
             decode(i.basem,1,3,1)
        into l_acc,
             v_gpk_type
        from nd_acc na,
             accounts a,
             int_accn i
       where a.tip = 'LIM'
         and na.acc = a.acc
         and a.nbs is null
         and na.nd = nd_
         and a.acc = i.acc
         and i.id = 0;
    exception
      when too_many_rows then
        null;
      when no_data_found then
        bars_audit.info('cck.p_int_save: nd = '||nd_||chr(10)||dbms_utility.format_call_stack());
        raise;
    end;

    --Заповняємо карточку рахунку LIM
    if p_mode = 0 then
      declare
        v_num integer;
        v_dt date;
      begin
        if l_int_2_date is not null and l_int_2_val is not null then
          select count(1), min(bdat)
            into v_num, v_dt
            from (select bdat, rank() over (partition by acc order by bdat) rnk
                    from int_ratn i
                    where acc = l_acc
                      and i.id = 0)
            where rnk = 2;
          if v_num = 0 then
            insert into int_ratn
              (acc, id, bdat, ir, br, op, idu)
              select ir.acc, ir.id, l_int_2_date, l_int_2_val, ir.br, 0, 1
                from int_ratn ir
               where ir.acc = l_acc
                 and ir.id = 0
                 and rownum = 1;
          else
            update int_ratn
              set bdat = l_int_2_date, ir = l_int_2_val
              where acc = l_acc
                and id = 0
                and bdat = v_dt;
          end if;
        end if;

        if l_int_3_date is not null and l_int_3_val is not null then
          select count(1), min(bdat)
            into v_num, v_dt
            from (select bdat, rank() over (partition by acc order by bdat) rnk
                    from int_ratn i
                    where acc = l_acc
                      and i.id = 0)
            where rnk = 3;
          if v_num = 0 then
            insert into int_ratn
              (acc, id, bdat, ir, br, op, idu)
              select ir.acc, ir.id, l_int_3_date, l_int_3_val, ir.br, 0, 1
                from int_ratn ir
               where ir.acc = l_acc
                 and ir.id = 0
                 and rownum = 1;
          else
            update int_ratn
              set bdat = l_int_3_date, ir = l_int_3_val
              where acc = l_acc
                and id = 0
                and bdat = v_dt;
          end if;
       end if;
     end;

  end if;
  --ЗАповняємо карточку рахунку SS
  if p_mode=1 then
  begin
      select a.acc
        into l_ss_acc
        from nd_acc na, accounts a
       where a.tip = 'SS '
         and na.acc = a.acc
         and na.nd = nd_;

    exception
      when too_many_rows then
        raise_application_error(-20010,'Для договору '||nd_ || ' знайдено кілька рахунків SS');
      when no_data_found then
          raise_application_error(-20010,'Для договору '||nd_ || ' не знайдено рахунків SS');
    end;
     update int_ratn ir
       set ir.bdat = l_int_2_date, ir.ir = l_int_2_val
     where ir.acc = l_ss_acc
       and ir.op = 0
       and ir.bdat = (select min(ir1.bdat)
                        from int_ratn ir1
                       where ir1.acc = l_ss_acc
                         and ir1.op = 0);
    IF SQL%ROWCOUNT = 0 and l_int_2_val is not null and
       l_int_2_date is not null THEN
      -- raise_application_error(-20009,nd);
      insert into int_ratn
        (acc, id, bdat, ir, br, op, idu)
        select ir.acc, ir.id, l_int_2_date, l_int_2_val, ir.br, 0, 1
          from int_ratn ir
         where ir.acc = l_ss_acc
           and ir.id = 0
           and rownum = 1;
    END IF;

    update int_ratn ir
       set ir.bdat = l_int_3_date, ir.ir = l_int_3_val
     where ir.acc = l_ss_acc
       and ir.op = 0
       and ir.bdat = (select MAX(ir1.bdat)
                        from int_ratn ir1
                       where ir1.acc = l_ss_acc
                         and ir1.op = 0
                         and ir1.bdat > l_int_2_date);
    IF SQL%ROWCOUNT = 0 and l_int_3_val is not null and
       l_int_3_date is not null then
      insert into int_ratn
        (acc, id, bdat, ir, br, op, idu)
        select ir.acc, ir.id, l_int_3_date, l_int_3_val, ir.br, 0, 1
          from int_ratn ir
         where ir.acc = l_ss_acc
           and ir.id = 0
           and rownum = 1;
    end if;
   end if;
  end p_int_save;
  -----------------------------------------------------
  PROCEDURE p_cc_lim_copy(p_nd       cc_deal.nd%TYPE,
                          p_comments cc_lim_copy_header.comments%TYPE DEFAULT NULL

                          ) IS
    --Noai?aiiy eii?? AIE(OEE) ia?aa iiaeo?eao???
    l_id NUMBER DEFAULT bars_sqnc.get_nextval('S_CCK_CC_LIM_COPY');
  BEGIN
    INSERT INTO cc_lim_copy_header
      (id, nd, userid, comments)
    VALUES
      (l_id, p_nd, gl.auid, p_comments);
    INSERT INTO cc_lim_copy_body
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
      SELECT l_id,
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
       WHERE t.nd = p_nd;
  END p_cc_lim_copy;

  PROCEDURE pl_ins_input(p_mode  INT,
                         p_nd    NUMBER,
                         p_mfob  VARCHAR2,
                         p_nlsb  VARCHAR2,
                         p_nam_b VARCHAR2,
                         p_id_b  VARCHAR2,
                         p_nazn  VARCHAR2) IS
    l_tmp INT;
    l_nd  NUMBER;
  BEGIN

    l_nd := nvl(p_nd, to_number(pul.get_mas_ini_val('ND')));

    -- 1) контроль на відповідність МФО довіднику діючих банків
    BEGIN
      SELECT 1
        INTO l_tmp
        FROM banks
       WHERE mfo = p_mfob
         AND blk = 0;
    EXCEPTION
      WHEN no_data_found THEN
        raise_application_error(-20203,
                                'Код МФО=' || p_mfob ||
                                ' не знайдено/заблоковано ');
    END;

    -- 2) номеру рахунку отримувача більше 14 розрядів
    IF TRIM(length(p_nlsb)) > 14 THEN
      raise_application_error(-20203,
                              'Рахунок отримувача=' || p_nlsb ||
                              ' більше 14 розрядів ');
    END IF;

    -- 3) відповідність контрольного розряду рахунку до МФО
    IF vkrzn(substr(p_mfob, 1, 5), p_nlsb) <> p_nlsb THEN
      raise_application_error(-20203,
                              'Помилка контр.розряду в рахунку отримувача=' ||
                              p_nlsb);
    END IF;

    -- 4) перевірка коду ЄДППОУ на правильність контрольного розряду,
    IF v_okpo(p_id_b) <> p_id_b THEN
      raise_application_error(-20203,
                              'Помилка контр.розряду коду ЄДППОУ =' ||
                              p_id_b);
    END IF;

    -- 5) отримувача обмежити в 38 розрядів.
    IF TRIM(length(p_nam_b)) < 3 OR TRIM(length(p_nam_b)) > 38 THEN
      raise_application_error(-20203,
                              'Назва отримувача=' || p_nam_b ||
                              ' менше 3, або більше 38 розрядів ');
    END IF;

    -- 6) Признач  пл більш 3 символів
    IF TRIM(length(p_nazn)) < 3 THEN
      raise_application_error(-20203,
                              'Признач пл ' || p_nazn ||
                              ' менше 3 розрядів ');
    END IF;

    IF p_mode = 0 THEN
      ------- inp ADD_PL_INS = TMP_ARJK_OPER
      INSERT INTO add_pl_ins
        (nd, nlsa, nlsb, nazn, nam_b)
      VALUES
        (p_id_b, p_mfob, p_nlsb, p_nazn, p_nam_b);

    ELSIF p_mode = 1 THEN
      ------- upd ADD_PL_INS
      UPDATE add_pl_ins
         SET nd = p_id_b, nazn = p_nazn, nam_b = p_nam_b
       WHERE nlsa = p_mfob
         AND nlsb = p_nlsb;

    ELSIF p_mode = 2 THEN
      ------- inp CCK_PL_INS
      INSERT INTO cck_pl_ins
        (nd, mfob, nlsb, nam_b, id_b, nazn)
      VALUES
        (l_nd, p_mfob, p_nlsb, p_nam_b, p_id_b, p_nazn);

    ELSIF p_mode = 3 THEN
      ------- upd CCK_PL_INS
      UPDATE cck_pl_ins
         SET id_b = p_id_b, nazn = p_nazn, nam_b = p_nam_b
       WHERE nd = l_nd
         AND mfob = p_mfob
         AND nlsb = p_nlsb;
    END IF;

  END pl_ins_input;
  ---------------------

  PROCEDURE pl_ins_s(p_s NUMBER, p_ri VARCHAR2) IS
    pp    cck_pl_ins%ROWTYPE;
    l_err VARCHAR2(20) := '\     PL_INS_S:';
    l_sos INT;
  BEGIN
    BEGIN
      SELECT * INTO pp FROM cck_pl_ins WHERE ROWID = p_ri;
    EXCEPTION
      WHEN no_data_found THEN
        raise_application_error(-20203,
                                l_err || 'не знайдено запис для коррекції');
    END;
    IF pp.ref IS NOT NULL THEN
      BEGIN
        SELECT sos
          INTO l_sos
          FROM oper
         WHERE REF = pp.ref
           AND sos > 0;
        raise_application_error(-20203,
                                l_err || 'Сумма уже сплачена. реф АБС=' ||
                                pp.ref);
      EXCEPTION
        WHEN no_data_found THEN
          NULL;
      END;
    END IF;
    UPDATE cck_pl_ins SET s = p_s, REF = NULL WHERE ROWID = p_ri;
  END;

  PROCEDURE pl_ins(p_nd NUMBER) IS
    oo oper%ROWTYPE;
    dd cc_deal%ROWTYPE;
    aa accounts%ROWTYPE;
    cc customer%ROWTYPE;
  BEGIN
    dd.nd := nvl(p_nd, to_number(pul.get_mas_ini_val('ND')));
    BEGIN
      SELECT *
        INTO dd
        FROM cc_deal
       WHERE nd = dd.nd
         AND sos >= 10
         AND sos < 15;
      SELECT *
        INTO aa
        FROM accounts
       WHERE tip = 'SS '
         AND acc IN (SELECT acc FROM nd_acc WHERE nd = dd.nd)
         AND dazs IS NULL
         AND rownum = 1;
      SELECT * INTO cc FROM customer WHERE rnk = dd.rnk;
    EXCEPTION
      WHEN no_data_found THEN
        raise_application_error(-20203,
                                '\PL_INS: не знайдено рах.КД=' || dd.nd);
    END;
    oo.nd := substr(dd.cc_id, 1, 10);
    FOR k IN (SELECT i.*, ROWID ri
                FROM cck_pl_ins i
               WHERE mfob IS NOT NULL
                 AND nlsb IS NOT NULL
                 AND nlsb NOT LIKE '10%'
                 AND s > 0
                 AND id_b IS NOT NULL
                 AND i.nd = dd.nd
                 AND NOT EXISTS (SELECT 1
                        FROM oper
                       WHERE REF = i.ref
                         AND sos > 0)) LOOP
      IF k.mfob <> gl.amfo THEN
        oo.tt := 'KK2';
      ELSE
        oo.tt := 'KK1';
      END IF;
      gl.ref(oo.ref);
      oo.s     := k.s * 100;
      oo.nam_a := substr(aa.nms, 1, 38);
      oo.nazn  := substr('Видача коштів зг.КД № ' || dd.cc_id || ' від ' ||
                         to_char(dd.sdate, 'dd.mm.yyyy') || '. ' || cc.nmk || '.' ||
                         k.nazn,
                         1,
                         160);
      gl.in_doc3(ref_   => oo.ref,
                 tt_    => oo.tt,
                 vob_   => 6,
                 nd_    => oo.nd,
                 pdat_  => SYSDATE,
                 vdat_  => gl.bdate,
                 dk_    => 1,
                 kv_    => aa.kv,
                 s_     => oo.s,
                 kv2_   => aa.kv,
                 s2_    => oo.s,
                 sk_    => NULL,
                 data_  => gl.bdate,
                 datp_  => gl.bdate,
                 nam_a_ => oo.nam_a,
                 nlsa_  => aa.nls,
                 mfoa_  => gl.amfo,
                 nam_b_ => k.nam_b,
                 nlsb_  => k.nlsb,
                 mfob_  => k.mfob,
                 nazn_  => oo.nazn,
                 d_rec_ => NULL,
                 id_a_  => gl.aokpo,
                 id_b_  => k.id_b,
                 id_o_  => NULL,
                 sign_  => NULL,
                 sos_   => 1,
                 prty_  => NULL,
                 uid_   => NULL);
      gl.dyntt2(oo.sos,
                0,
                NULL,
                oo.ref,
                gl.bdate,
                gl.bdate,
                oo.tt,
                1,
                aa.kv,
                gl.amfo,
                aa.nls,
                oo.s,
                oo.kv,
                k.mfob,
                k.nlsb,
                oo.s,
                NULL,
                NULL);
      UPDATE cck_pl_ins SET REF = oo.ref WHERE ROWID = k.ri;
    END LOOP;

  END pl_ins;
  ---------------
  PROCEDURE del_acc(p_nd NUMBER, p_nls VARCHAR2, p_kv INT, p_acc NUMBER) IS
    --Процедура "Изъять счет" из-под дог
    aa    accounts%ROWTYPE;
    acc8_ NUMBER;
  BEGIN
    -- найти счет
    BEGIN
      SELECT *
        INTO aa
        FROM accounts
       WHERE (acc = p_acc OR kv = p_kv AND nls = p_nls);
      --      If aa.tip = 'LIM'      then  raise_application_error(  -(20203), '\ Виведення рах '||aa.nls||'*LIM недопустимо!' );  end if ;
      IF (aa.nbs LIKE '20_%' OR aa.nbs LIKE '22_%' OR aa.tip = 'LIM') THEN
       if aa.tip = 'SPN' or aa.tip = 'SNO' or aa.tip = 'SS ' or aa.tip = 'SP ' or aa.tip = 'SN ' then -- Временно для разделения линий
         null;
       else	   
        raise_application_error(-20203,
                                '\ Виведення рах ' || aa.nls || '*' ||
                                aa.tip || ' недопустимо !');
	   end if;
      END IF;
    EXCEPTION
      WHEN no_data_found THEN
        raise_application_error(-20203,
                                '\ не знайдено рах.' || p_acc || ', ' || p_kv || '/' ||
                                p_nls);
    END;

    -- удалить его из связей
    DELETE FROM nd_acc
     WHERE nd = p_nd
       AND acc = aa.acc;

    -- если это счет тела и именно по  нашему КД, то отвязать его как дочерний от 8999* и переформировать сальдо 8999*
    IF aa.accc IS NOT NULL THEN
      BEGIN
        SELECT a.acc
          INTO acc8_
          FROM accounts a, nd_acc n
         WHERE a.tip = 'LIM'
           AND a.acc = n.acc
           AND n.nd = p_nd;
        IF aa.accc = acc8_ THEN
          UPDATE accounts SET accc = NULL WHERE acc = aa.acc;
          cck.cc_start(p_nd);
        END IF;
      EXCEPTION
        WHEN no_data_found THEN
          NULL;
      END;
    END IF;

    --разобраться с обеспечением - все, что не отвечает связям по счетам
    DELETE FROM cc_accp
     WHERE accs = aa.acc
       AND nd > 0
       AND nd NOT IN (SELECT nd FROM nd_acc WHERE acc = aa.acc);
    -----------------------------
    INSERT INTO cc_sob
      (nd, fdat, txt)
    VALUES
      (p_nd,
       gl.bdate,
       'Рах.' || aa.nls || '/' || aa.kv || '/' || aa.tip ||
       ' виведено з-під КД');

  END del_acc;
  --------------------------
  PROCEDURE ins_acc(p_nd NUMBER, p_nls VARCHAR2, p_kv INT, p_acc NUMBER) IS
    --Процедура "Добавить счет"
    aa accounts%ROWTYPE;
    --COBUSUPABS-4449
  BEGIN

    BEGIN
      SELECT *
        INTO aa
        FROM accounts
       WHERE (acc = p_acc)
          OR (kv = p_kv AND nls = p_nls);
    EXCEPTION
      WHEN no_data_found THEN
        raise_application_error(- (20203),
                                '\ не знайдено рах.' || p_acc || ', ' || p_kv || '/' ||
                                p_nls);
    END;

    BEGIN
      INSERT INTO nd_acc (nd, acc) VALUES (p_nd, aa.acc);
    EXCEPTION
      WHEN dup_val_on_index THEN
        NULL;
    END;

    IF aa.tip = 'SNO' THEN
      accreg.setaccountsparam(aa.acc, 'R013', '4');
    ELSIF aa.tip = 'SN ' THEN
      accreg.setaccountsparam(aa.acc, 'R013', '3');
    END IF;

  END ins_acc;
  --------------------

  PROCEDURE isg1(p_kvd  IN INT,
                 p_nlsd IN VARCHAR2,
                 p_sd   IN NUMBER,
                 p_kvk  IN INT,
                 p_nlsk IN VARCHAR2,
                 p_nazn IN VARCHAR2,
                 p_ref  OUT NUMBER) IS
    oo oper%ROWTYPE;
    kk accounts%ROWTYPE;
  BEGIN

    IF p_kvd = p_kvk THEN
      oo.vob := 6;
      oo.s   := p_sd;
    ELSIF p_kvk = gl.baseval THEN
      oo.vob := 16;
      oo.s   := gl.p_ncurval(p_kvd, p_sd, gl.bdate);
    ELSIF p_kvd = gl.baseval THEN
      oo.vob := 16;
      oo.s   := gl.p_icurval(p_kvk, p_sd, gl.bdate);
    ELSE
      oo.vob := 16;
       oo.s   := gl.p_ncurval(p_kvd,
                             gl.p_icurval(p_kvk, p_sd, gl.bdate),
                             gl.bdate);
    END IF;

    oo.tt  := 'ISG';
    oo.kv  := p_kvd;
    oo.kv2 := p_kvk;
    oo.s2  := p_sd;

    BEGIN
      SELECT substr(d.nms, 1, 38),
             substr(k.nms, 1, 38),
             k.tip,
             k.acc,
             c.okpo
        INTO oo.nam_a, oo.nam_b, kk.tip, kk.acc, oo.id_a
        FROM accounts d, accounts k, customer c
       WHERE d.kv = p_kvd
         AND d.nls = p_nlsd
         AND k.kv = p_kvk
         AND k.nls = p_nlsk
         AND d.dazs IS NULL
         AND k.dazs IS NULL
         AND d.rnk = c.rnk;
    EXCEPTION
      WHEN no_data_found THEN
        raise_application_error(- (20203),
                                '\8999  не знайдено рах.' || p_nlsd || ', ' ||
                                p_nlsk);
    END;

    oo.nlsa := p_nlsd;
    oo.nlsb := p_nlsk;

    IF p_nazn IS NULL THEN
      BEGIN
        SELECT CASE
                 WHEN kk.tip = 'SS ' THEN
                  'Погашення основного боргу'
                 WHEN kk.tip = 'SN ' THEN
                  'Погашення процентного боргу'
                 WHEN kk.tip = 'SP ' THEN
                  'Погашення проср.осн.боргу'
                 WHEN kk.tip = 'SPN' THEN
                  'Погашення проср.проц.боргу'
                 WHEN kk.tip = 'SL ' THEN
                  'Погашення сумн.осн.боргу'
                 WHEN kk.tip = 'SLN' THEN
                  'Погашення сумн.проц.боргу'
                 WHEN kk.tip = 'SK0' THEN
                  'Погашення нарах. комісії'
                 WHEN kk.tip = 'SK9' THEN
                  'Погашення проср.нарах.комісі'
                 WHEN kk.tip = 'SN8' THEN
                  'Погашення нарах.пені'
                 WHEN kk.tip = 'ISG' THEN
                  'Зарахування на погаш.майб.періодів'
                 WHEN kk.tip = 'SDI' THEN
                  'Перерахування на дисконт '
                 ELSE
                  ''
               END || ' зг. КД ' || d.cc_id || ' вiд ' ||
               to_char(d.sdate, 'dd.mm.yyyy')
          INTO oo.nazn
          FROM cc_deal d, nd_acc n
         WHERE n.acc = kk.acc
           AND n.nd = d.nd
           AND rownum = 1;
      EXCEPTION
        WHEN no_data_found THEN
          oo.nazn := oo.nam_b;
      END;
    ELSE
      oo.nazn := substr(p_nazn, 1, 160);
    END IF;

    IF kk.tip = 'SN8' THEN
      oo.nlsb := substr(branch_usr.get_branch_param_acc(p_nlsk,
                                                        p_kvk,
                                                        'CC_6397'),
                        1,
                        14);
      oo.kv2  := gl.baseval;
      IF p_kvk <> gl.baseval THEN
        oo.s2 := gl.p_icurval(p_kvk, p_sd, gl.bdate);
      END IF;
    END IF;

    gl.ref(oo.ref);
    oo.nd := substr('          ' || to_char(oo.ref), -10);
    gl.in_doc3(ref_   => oo.ref,
               tt_    => 'ISG',
               vob_   => oo.vob,
               nd_    => oo.nd,
               pdat_  => SYSDATE,
               vdat_  => gl.bdate,
               dk_    => 1,
               kv_    => oo.kv,
               s_     => oo.s,
               kv2_   => oo.kv2,
               s2_    => oo.s2,
               sk_    => NULL,
               data_  => gl.bdate,
               datp_  => gl.bdate,
               nam_a_ => oo.nam_a,
               nlsa_  => oo.nlsa,
               mfoa_  => gl.amfo,
               nam_b_ => oo.nam_b,
               nlsb_  => oo.nlsb,
               mfob_  => gl.amfo,
               nazn_  => oo.nazn,
               d_rec_ => NULL,
               id_a_  => oo.id_a,
               id_b_  => gl.aokpo,
               id_o_  => NULL,
               sign_  => NULL,
               sos_   => 1,
               prty_  => NULL,
               uid_   => NULL);

    gl.payv(0,
            oo.ref,
            gl.bdate,
            oo.tt,
            1,
            oo.kv,
            oo.nlsa,
            oo.s,
            oo.kv2,
            oo.nlsb,
            oo.s2);

    IF kk.tip = 'SN8' THEN
      BEGIN
        SELECT a.nls
          INTO oo.nlsa
          FROM accounts a
         WHERE a.tip = 'SD8'
           AND a.nbs = '8006'
           AND a.dazs IS NULL
           AND a.kv = p_kvk
           AND rownum = 1;
      EXCEPTION
        WHEN OTHERS THEN
          raise_application_error(- (20203),
                                  ' Не знайдено контр/рах. по пенi 8006 типу SD8 для вал = ' ||
                                  p_kvk);
      END;
      gl.payv(0,
              oo.ref,
              gl.bdate,
              oo.tt,
              1,
              p_kvk,
              oo.nlsa,
              p_sd,
              p_kvk,
              p_nlsk,
              p_sd);
    END IF;
    p_ref := oo.ref;

  END isg1;

  ------------------------------------------------------

  --Актуализация текущим лимитом дня - вынесла в отдельную процеду
  PROCEDURE lim_bdate(p_nd NUMBER, p_dat DATE default gl.bdate) IS    ll cc_lim%ROWTYPE; l_Kv8 int; 
    l_NDG number ;   
  BEGIN

    BEGIN --  22.05.2018 Не делаем ничего для Суб/дог, хотя у них есть технический ГПК( в cc_lim 2 записи), а только для простых КД или ген.дог.
       select NDG  into  l_NDG from cc_deal   where nd  = p_ND and ( NDG is null OR NDG = ND ) ;

       -- ШАГ-1. на заглавном КД
       SELECT l.* INTO ll    FROM cc_lim l WHERE l.nd = p_nd AND l.fdat = (SELECT MAX(fdat) FROM cc_lim WHERE nd = p_nd  AND fdat <= nvl(p_dat, gl.bdate));  ---       есть изменение лимита 
          UPDATE accounts SET   ostx  = -ll.lim2, pap = 1 WHERE acc = ll.acc;
          UPDATE cc_deal  SET   LIMIT =  ll.lim2 / 100    WHERE nd = p_nd;
          UPDATE cc_add   SET   s     =  ll.lim2 / 100    WHERE nd = p_nd  AND adds = 0;

       -- ШАГ-2. на его суб/дог, если они есть
       If l_NDG = p_ND then
          select kv  into  l_KV8 from accounts  where acc = ll.acc ;
          for d in (select a.kv , a.acc, a.ostx, x.nd FROM cc_deal x, accounts a , nd_acc n where x.ndg != x.nd and n.nd = x.nd and a.acc = n.acc and a.tip ='LIM' and x.ndg = p_ND)
          loop  d.ostx := gl.p_Ncurval( d.KV , gl.p_icurval( l_kv8, -ll.lim2, gl.bdate) , gl.bdate) ;
                update accounts set ostx  = d.ostx , pap = 3  where acc = d.acc ;
                d.ostx := - d.ostx /100;
                update cc_deal  set limit = d.ostx where nd = d.nd;
                update cc_add   set s     = d.ostx where nd = d.nd;          
          end loop  ;  -- d
       end if ; -- l_NDG = p_ND
    EXCEPTION  WHEN no_data_found THEN     NULL;  
    END;

  END lim_bdate;

  -- расчет суммы процентов в удельном весе по ГПК за период ( рекомендовано для ануитета)
  FUNCTION fint(p_nd   IN NUMBER,
                p_dat1 IN DATE, -- дата "С"  включительно
                p_dat2 IN DATE -- дата "По" включительно
                ) RETURN NUMBER IS

    s_       NUMBER := 0;
    l_dat1   DATE; -- дата "С"  включительно
    l_dat2   DATE; -- дата "По" включительно
    dat_min  DATE;
    dat_max  DATE;
    dat_prev DATE;
    dat_next DATE;
    kolm_    INT;
    kold_    INT;
    s1_      NUMBER;
    fdat_    DATE;
    sump_    NUMBER;
  BEGIN
    SELECT MIN(fdat), MAX(fdat)
      INTO dat_min, dat_max
      FROM cc_lim
     WHERE nd = p_nd;
    l_dat1 := nvl(p_dat1, dat_min);
    l_dat1 := greatest(dat_min, l_dat1);
    l_dat2 := nvl(p_dat2, dat_max);
    l_dat2 := least(dat_max, l_dat2);
    IF l_dat1 > l_dat2 THEN
      RETURN 0;
    END IF;

    FOR k IN (SELECT fdat
                FROM cc_lim
               WHERE nd = p_nd
                 AND fdat > l_dat1
                 AND fdat < l_dat2
              UNION ALL
              SELECT l_dat1
                FROM dual
              UNION ALL
              SELECT l_dat2
                FROM dual
              UNION ALL
              SELECT l_dat2 + 1
                FROM dual
               ORDER BY 1) LOOP
      IF fdat_ IS NOT NULL THEN
        SELECT nvl(MAX(fdat), dat_min)
          INTO dat_prev
          FROM cc_lim
         WHERE nd = p_nd
           AND fdat <= fdat_;
        SELECT nvl(MIN(fdat), dat_max)
          INTO dat_next
          FROM cc_lim
         WHERE nd = p_nd
           AND fdat > fdat_;
        kolm_ := dat_next - dat_prev;
        kold_ := k.fdat - fdat_;
        IF kolm_ > 0 AND kold_ > 0 THEN
          SELECT sumo - sumg - nvl(sumk, 0)
            INTO sump_
            FROM cc_lim
           WHERE nd = p_nd
             AND fdat = dat_next;
          s1_ := sump_ * kold_ / kolm_;
          s_  := s_ + s1_;
        END IF;
      END IF;
      fdat_ := k.fdat;
    END LOOP;
    RETURN round(s_, 0);

  END fint;

  ------------------------------------
  -- Пересмотр значений плавающей ставки по базе источника при наступлении периода пересмотра.
  PROCEDURE set_floating_rate(p_nd NUMBER) IS
    uu     cc_source%ROWTYPE;
    l_bdat DATE;
    l_ndat DATE;
    l_acc8 NUMBER;
    l_kv   NUMBER;
    l_irb  NUMBER;
    l_ir   NUMBER;
  BEGIN

    -- Есть ли данный КД с плавающей ставкой В принципе ?
    BEGIN
      SELECT u.*
        INTO uu
        FROM cc_source u, cc_add ad
       WHERE ad.nd = p_nd
         AND ad.adds = 0
         AND ad.sour = u.sour
         AND u.br IS NOT NULL
         AND u.n_mon IS NOT NULL;

      SELECT a.acc, a.kv
        INTO l_acc8, l_kv
        FROM accounts a, nd_acc n
       WHERE a.tip = 'LIM'
         AND a.acc = n.acc
         AND n.nd = p_nd;

    EXCEPTION
      WHEN no_data_found THEN
        RETURN;
    END;

    -- Наступило ли время пересмотра значения плавающей ставки ?
    SELECT nvl(MAX(bdat), to_date('01-01-1900', 'dd-mm-yyyy'))
      INTO l_bdat
      FROM int_ratn
     WHERE acc = l_acc8
       AND id = 0;
    l_ndat := add_months(l_bdat, uu.n_mon);

    IF l_ndat > gl.bdate THEN
      RETURN;
    END IF;
    ---------------
    BEGIN
      SELECT rate
        INTO l_irb
        FROM br_normal b
       WHERE b.kv = l_kv
         AND b.br_id = uu.br
         AND b.bdate = (SELECT MAX(bb.bdate)
                          FROM br_normal bb
                         WHERE bb.kv = l_kv
                           AND bb.br_id = uu.br
                           AND bb.bdate <= gl.bdate);
    EXCEPTION
      WHEN no_data_found THEN
        RETURN;
    END;

    l_ir := nvl(l_irb, 0) +
            nvl(cck_app.to_number2(cck_app.get_nd_txt(p_nd, 'ADDIR')), 0);
    IF uu.ir_max IS NOT NULL THEN
      l_ir := least(l_ir, uu.ir_max);
    END IF;

    FOR s IN (SELECT a.acc
                FROM accounts a, nd_acc n
               WHERE n.nd = p_nd
                 AND n.acc = a.acc
                 AND l_acc8 IN (a.acc, a.accc)) LOOP
      DELETE FROM int_ratn
       WHERE acc = s.acc
         AND id = 0
         AND bdat >= l_ndat;
      INSERT INTO int_ratn
        (acc, id, bdat, ir)
      VALUES
        (s.acc, 0, l_ndat, l_ir);
    END LOOP;

  END set_floating_rate;

  -----------------------------
  FUNCTION pay_gpk(p_dat DATE, p_nd NUMBER, p_acc NUMBER) RETURN NUMBER IS
    l_nd  NUMBER := p_nd;
    l_ret NUMBER := 0;
  BEGIN
    BEGIN
      IF p_nd IS NULL AND p_acc IS NOT NULL THEN
        SELECT nd INTO l_nd FROM nd_acc WHERE acc = p_acc;
      END IF;
      SELECT 1
        INTO l_ret
        FROM dual
       WHERE EXISTS (SELECT 1
                FROM cc_lim
               WHERE nd = l_nd
                 AND fdat BETWEEN p_dat - 4 AND p_dat);
      RETURN 1;
    EXCEPTION
      WHEN no_data_found THEN
        RETURN 0;
    END;
  END pay_gpk;
  -------------

  -- КП S43: Нарахування %%  по поточним платіж. датам у КП ФЛ
  PROCEDURE int_metr_fl(p_dat DATE, p_nd NUMBER) IS
    nint_    NUMBER;
    ddat2_   DATE; -- -- пл.дата из ГПК -1
    dat_prev DATE; -- пред.банк-дата
    dat_     DATE; -- тек. банк-дата
    dat_next DATE; -- след.банк-дата

  BEGIN
    dat_ := nvl(p_dat, gl.bdate);
    --Универсальная функция поиска банковской даты, отстоящей от заданной (datb_)
    --на расстоянии  next_ шагов вперед (next_ > 0) или назад (next_ < 0)

    dat_prev := dat_next_u(dat_, -1);
    --DAT_NEXT  := Dat_Next_U (DAT_, +1 ) ;
    dat_next := dat_ + 1;

    FOR k IN (SELECT d.*
                FROM cc_deal d
               WHERE d.sos >= 10
                 AND d.sos < 15
                 AND d.vidd IN (1, 11, 12, 13)
                 AND p_nd IN (0, d.nd)
                 AND EXISTS (SELECT 1
                        FROM cc_lim
                       WHERE nd = d.nd
                         AND fdat > dat_prev
                         AND fdat < dat_next)) LOOP
      SELECT MAX(fdat) - 1
        INTO ddat2_
        FROM cc_lim
       WHERE nd = k.nd
         AND fdat > dat_prev
         AND fdat < dat_next;

      IF ddat2_ IS NULL THEN
        GOTO next_nd;
      END IF;
      --------------------------------------------
      FOR p IN (SELECT a.accc,
                       a.acc,
                       a.tip,
                       i.basem,
                       i.basey,
                       greatest(nvl(i.acr_dat, a.daos - 1), k.sdate - 1) + 1 ddat1
                  FROM accounts a, int_accn i, nd_acc n
                 WHERE n.nd = k.nd
                   AND n.acc = a.acc
                   AND a.tip IN ('SS ', 'SP ')
                   AND a.acc = i.acc
                   AND i.id = 0
                   AND a.accc IS NOT NULL
                      ----------------and a.nbs like '22%'  -------------------- ФЛ + ОСББ
                   AND i.acr_dat < ddat2_) LOOP
        IF p.tip = 'SS ' AND p.basey = 2 AND p.basem = 1 THEN
          cck.int_metr_a(p.accc, p.acc, 0, p.ddat1, ddat2_, nint_, NULL, 1); -- начисление по ануитету
        ELSE
          acrn.p_int(p.acc, 0, p.ddat1, ddat2_, nint_, NULL, 1); -- начисление банковское
        END IF;
      END LOOP;
      <<next_nd>>
      NULL;
    END LOOP; --k
    COMMIT;

  END int_metr_fl;

  ----------------------------------

  --18.07.2012 Sta проц нач. % по ануитету.вызов из Bars010.apd для одного счета
  PROCEDURE int_metr_a(p_accc IN NUMBER, -- acc для 8999*LIM
                       p_acc  IN NUMBER, -- acc для 2203*SSM
                       p_id   IN INT, -- = 0
                       p_dat1 IN DATE, -- дата "С"  включительно
                       p_dat2 IN DATE, -- дата "По" включительно
                       p_int  OUT NUMBER, -- Сумма процентов
                       p_ost  IN NUMBER, -- null -- не исп
                       p_mode IN NUMBER -- = 1
                       ) IS
    l_nd NUMBER;
    ir_  NUMBER;
  BEGIN
    IF p_dat1 > p_dat2 THEN
      RETURN;
    END IF;
    p_int := 0;

    BEGIN
      SELECT d.nd
        INTO l_nd
        FROM accounts ra,
             nd_acc   rn,
             accounts da,
             nd_acc   dn,
             int_accn i,
             cc_deal  d
       WHERE ra.acc = p_accc
         AND ra.acc = rn.acc
         AND ra.tip = 'LIM'
         AND ra.vid = 4
         AND da.acc = p_acc
         AND da.acc = dn.acc
         AND da.tip = 'SS '
         AND ra.acc = da.accc
         AND rn.nd = dn.nd
         AND rn.nd = d.nd
         AND i.basem = 1
         AND i.basey = 2
         AND i.acc = da.acc
         AND i.id = 0
         AND d.vidd IN (11, 1) -------------------- ФЛ + ОСББ
         AND ra.dazs IS NULL
         AND da.dazs IS NULL
         AND rownum = 1;

      p_int := cck.fint(p_nd => l_nd, p_dat1 => p_dat1, p_dat2 => p_dat2);

      IF p_mode = 1 THEN
        ir_ := acrn.fprocn(p_acc, 0, p_dat2);
        DELETE FROM acr_intn
         WHERE acc = p_acc
           AND id = p_id;
        INSERT INTO acr_intn
          (acc, id, fdat, tdat, ir, br, acrd, remi)
        VALUES
          (p_acc, p_id, p_dat1, p_dat2, ir_, 0, p_int, 0);
      END IF;
    EXCEPTION
      WHEN no_data_found THEN
        acrn.p_int(p_acc, p_id, p_dat1, p_dat2, p_int, p_ost, p_mode);
    END;
  END int_metr_a;

  -----------------------------------
  -- процедура по установке платежных реквизитов по кредиту
  PROCEDURE set_pmt_instructions(p_nd       cc_add.nd%TYPE, -- реф КД
                                 p_mfokred  cc_add.mfokred%TYPE, -- Платежные инструкции МФО
                                 p_nlskred  cc_add.acckred%TYPE, --     -------//------- счет
                                 p_okpokred cc_add.okpokred%TYPE, -- ИПН получателя
                                 p_namkred  cc_add.namkred%TYPE, -- Наименование счета получателя
                                 p_naznkred cc_add.naznkred%TYPE -- Назначение платежа
                                 ) IS
    l_kol INT;
  BEGIN

    UPDATE cc_add
       SET mfokred  = p_mfokred,
           acckred  = p_nlskred,
           okpokred = p_okpokred,
           namkred  = p_namkred,
           naznkred = p_naznkred
     WHERE nd = p_nd
       AND adds = 0;
    IF SQL%ROWCOUNT = 0 THEN
      raise_application_error(- (20203),
                              '\8999 Set_pmt_instructions: Реф.КД ' || p_nd ||
                              ' не знайдено' || SQLERRM,
                              TRUE);
    END IF;

    FOR k IN (SELECT * FROM tmp_arjk_oper) LOOP
      INSERT INTO cck_pl_ins
        (nd, mfob, nlsb, nam_b, id_b, nazn)
      VALUES
        (p_nd, k.nlsa, k.nlsb, k.nam_b, k.nd, k.nazn);
    END LOOP;
    DELETE FROM tmp_arjk_oper;

  END set_pmt_instructions;
  ----------------------------

  PROCEDURE update_obs(dat_ DATE, nd_ INT) IS
    --автоматичне визначення параметру "обслуговування боргу".
    -- ND_ =  0 для всех КД
    -- ND_ = -2 для всех КД  ЮЛ
    -- ND_ = -3 для всех КД  ФЛ
    -- ND_ >  0 для 1 КД

    TYPE t_obs_ IS RECORD(
      rnk     INT,
      obs_old INT,
      obs_new INT);
    TYPE t_mas_obs_ IS TABLE OF t_obs_ INDEX BY BINARY_INTEGER;
    nd_bad_ INT;
    i       INT;
    j       INT;

    sp_      NUMBER;
    sl_      NUMBER;
    spn_     NUMBER;
    sk9_     NUMBER;
    kol_     INT;
    fdat_    DATE := dat_;
    obs_     INT;
    sum_kos  NUMBER;
    txt_     VARCHAR2(40) := 'НЕвизначенДобре(1)  Слабке(2) Незадов(3)';
    mas_obs_ t_mas_obs_;
  BEGIN
    /*


    1) При залишке  на рахунку SL автоматично проставляеться ОБС -  Незадов(3)
    2 При вiдсутностi заборгованностi проставляеться ОБС         - Добре(1)
    3) Якщо позичальник маї заборгованiсть одночасно за кiлькома кредитами,
       то оцiнка обслуговування позичальником боргу єрунтуїться на кредитнiй заборгованостi,
       що вiднесена до нижчоi групи.
    3) наявнiсть залишку та оборотiв по дебету та кредиту рахунку
       визначає кiлькiсть днiв вiд дати руху коштiв по дебету рахунку.
       В разi, коли за промiжок часу N вiдбулося збiльшення залишку по дебету,
       без наявностi оборотiв по кредиту,
       система продовжує вiдлiк кiлькостi днiв вiд попереднього руху по дебету.

       В разi, коли за промiжок часу N вiдбулося збiльшення залишку по дебету,
       при наявностi оборот по кредиту, в сумi не достатньої для погаш заборгов,
       система продовжує вiдлiк кiлькостi днiв вiд попереднього руху по дебету.

       В залежностi вiд кiлькостi днiв прострочення заборгованостi
       система встановлює значення параметру "обслуговування боргу"
       згiдно методу зазначеного вище.

       При наявн обор по кредиту, в сумi достатньої для повного погаш заборгов,
       система встановлює значення параметру "обслуговування боргу" на рiвнi "добре".

     4) (нужна для свернутых МФО) При наличии остатка на счетах просрочки и
         спец параметр 270=08 или r013=2.При выполнении за тек-й банк день
        (DAT_= банковскому день) устанавливать обслуживание = 3
    */

    FOR k IN (SELECT d.nd,
                     d.vidd,
                     nvl(d.obs, 0) obs,
                     d.sdate,
                     d.rnk,
                     d.wdate,
                     (SELECT SUM(1)
                        FROM nd_acc n, accounts a
                       WHERE a.tip IN ('SP ', 'SPN', 'SK9', 'SL ')
                         AND a.dazs IS NULL
                         AND a.acc = n.acc
                         AND n.nd = d.nd) sp_on,
                     (SELECT MAX(3)
                        FROM nd_acc nn, specparam p, accounts a
                       WHERE nn.acc = a.acc
                         AND nn.acc = p.acc
                         AND nn.nd = d.nd
                         AND a.tip IN ('SP ', 'SPN')
                         AND (p.s270 = '08' OR p.r013 = '2')
                         AND a.ostc < 0
                         AND dat_ = gl.bdate) obs3
                FROM cc_deal d
               WHERE d.sos >= 10
                 AND d.sos < 14
                 AND (vidd IN (1, 2, 3, 11, 12, 13) AND nd_ IN (0, d.nd) OR
                     vidd IN (1, 2, 3) AND nd_ = -2 OR
                     vidd IN (11, 12, 13) AND nd_ = -3)) LOOP
      BEGIN
        obs_ := nvl(k.obs3, 1);

        -- if (k.wdate <= DAT_-90) then OBS_:=3; end if;
        IF (k.wdate <= dat_) THEN
          obs_ := 3;
        END IF;

        IF k.sp_on IS NOT NULL AND obs_ < 3 THEN
          --узнать тек остаток
          SELECT --Nvl(sum(gl.p_icurval(a.kv,s.ostf-s.dos+s.kos,dat_)),0),
           nvl(SUM(decode(a.tip,
                          'SP ',
                          gl.p_icurval(a.kv, s.ostf - s.dos + s.kos, dat_),
                          0)),
               0),
           nvl(SUM(decode(a.tip,
                          'SPN',
                          gl.p_icurval(a.kv, s.ostf - s.dos + s.kos, dat_),
                          0)),
               0),
           nvl(SUM(decode(a.tip,
                          'SK9 ',
                          gl.p_icurval(a.kv, s.ostf - s.dos + s.kos, dat_),
                          0)),
               0),
           nvl(SUM(decode(a.tip,
                          'SL ',
                          gl.p_icurval(a.kv, s.ostf - s.dos + s.kos, dat_),
                          0)),
               0)
            INTO sp_, spn_, sk9_, sl_
            FROM saldoa s, accounts a, nd_acc n
           WHERE a.acc = s.acc
             AND a.acc = n.acc
             AND n.nd = k.nd
             AND a.acc = s.acc
             AND a.tip IN ('SP ', 'SPN', 'SK9', 'SL ')
             AND (s.acc, s.fdat) = (SELECT acc, MAX(fdat)
                                      FROM saldoa
                                     WHERE acc = s.acc
                                       AND fdat <= dat_
                                     GROUP BY acc);

          IF sl_ = 0 OR sl_ IS NULL THEN
            -- УЗНАЕМ НА СКОЛЬКО ДНЕЙ ПРОСРОЧЕНО ТЕЛО КРЕДИТА
            FOR sp IN (SELECT 'SP ' tip
                         FROM dual
                        WHERE sp_ <> 0
                       UNION ALL
                       SELECT 'SPN' tip
                         FROM dual
                        WHERE spn_ <> 0
                       UNION ALL
                       SELECT 'SK9' tip
                         FROM dual
                        WHERE sk9_ <> 0) LOOP
              kol_  := 0;
              fdat_ := dat_;

              IF obs_ = 3 THEN
                EXIT;
              END IF; -- нет смыска идти дальше если стан обс боргу уже самый плохой

              -- узнаем сумму всех кредитовых оборотов
              SELECT SUM(gl.p_icurval(a.kv, (s.kos), dat_))
                INTO sum_kos
                FROM saldoa s, accounts a, nd_acc n
               WHERE a.acc = s.acc
                 AND a.acc = n.acc
                 AND n.nd = k.nd
                 AND a.tip = sp.tip
                 AND s.fdat <= dat_
                 AND s.fdat >= k.sdate;

              --         for p in (select s.fdat,sum(gl.p_icurval(a.kv,(s.dos),dat_)) DOS

              -- case введен из за  пост миграционных баз данный в которых остаток появляется без оборотов
              FOR p IN (SELECT s.fdat,
                               SUM(gl.p_icurval(a.kv,
                                                ((CASE
                                                  WHEN fdat = (SELECT MIN(fdat)
                                                                 FROM saldoa ss
                                                                WHERE acc = a.acc) THEN
                                                   greatest(-s.ostf, s.dos)
                                                  ELSE
                                                   s.dos
                                                END)),
                                                dat_)) dos
                          FROM saldoa s, accounts a, nd_acc n
                         WHERE a.acc = s.acc
                           AND a.acc = n.acc
                           AND n.nd = k.nd
                           AND a.tip = sp.tip
                              --    and s.dos>0
                           AND s.fdat < dat_
                           AND s.fdat >= k.sdate
                         GROUP BY s.fdat
                         ORDER BY s.fdat) LOOP
                sum_kos := sum_kos - p.dos;
                -- -10  для устранения погрешности возник из за использования нац валюты
                IF sum_kos < -10 THEN
                  kol_ := dat_ - p.fdat;
                  EXIT;
                END IF;
              END LOOP;

              IF kol_ > 0 AND sp.tip = 'SP ' THEN
                -- просрочка была и раньше
                IF kol_ <= 7 THEN
                  obs_ := greatest(1, obs_);
                ELSIF kol_ <= 90 THEN
                  obs_ := greatest(2, obs_);
                ELSE
                  obs_ := greatest(3, obs_);
                END IF;
              END IF;
              IF kol_ > 0 AND sp.tip IN ('SPN', 'SK9') THEN
                -- просрочка была и раньше
                IF kol_ <= 7 THEN
                  obs_ := greatest(1, obs_);
                ELSIF kol_ <= 30 THEN
                  obs_ := greatest(2, obs_);
                ELSE
                  obs_ := greatest(3, obs_);
                END IF;
              END IF;

            END LOOP;

          ELSE
            obs_ := 3;
          END IF;

        END IF;
        mas_obs_(k.nd).rnk := k.rnk;
        mas_obs_(k.nd).obs_old := k.obs;
        mas_obs_(k.nd).obs_new := obs_;

      EXCEPTION
        WHEN no_data_found THEN
          NULL;
          logger.info('CCK.UPDATE_OBS nd=' || k.nd || '  ' || SQLERRM);
      END;

    END LOOP;

    i := mas_obs_.first;
    LOOP
      EXIT WHEN i IS NULL;
      obs_ := mas_obs_(i).obs_new;
      j    := mas_obs_.first;
      LOOP
        EXIT WHEN j IS NULL;
        IF mas_obs_(i).rnk = mas_obs_(j).rnk AND mas_obs_(j).obs_new > obs_ THEN
          nd_bad_ := j;
          obs_    := mas_obs_(j).obs_new;
        END IF;
        j := mas_obs_.next(j);
      END LOOP;

      --- Записываем в журнал событий
      -- договор сам по себе плохой
      IF mas_obs_(i)
       .obs_new = obs_ AND mas_obs_(i).obs_old <> mas_obs_(i).obs_new THEN
        UPDATE cc_deal SET obs = obs_ WHERE nd = i;
        INSERT INTO cc_sob
          (nd, fdat, isp, txt, otm)
        VALUES
          (i,
           gl.bdate,
           gl.auid,
           'Змiна ОБС.боргу з ' ||
           TRIM(substr(txt_, mas_obs_(i).obs_old * 10 + 1, 10)) || ' на ' ||
           TRIM(substr(txt_, obs_ * 10 + 1, 10)),
           6);
      ELSE
        -- в следствии обс других договоровдоговор
        -- у наслўдок ослуговування боргу дог №=
        IF nvl(mas_obs_(i).obs_old, 0) <> obs_ THEN
          UPDATE cc_deal SET obs = obs_ WHERE nd = i;
          INSERT INTO cc_sob
            (nd, fdat, isp, txt, otm)
          VALUES
            (i,
             gl.bdate,
             gl.auid,
             'Змiна ОБС.боргу з ' ||
             TRIM(substr(txt_, mas_obs_(i).obs_old * 10 + 1, 10)) || ' на ' ||
             TRIM(substr(txt_, obs_ * 10 + 1, 10)) ||
             'в наслiдок стану обслуговування боргу дог. № = ' ||
             to_char(nd_bad_),
             6);
        END IF;
      END IF;

      i := mas_obs_.next(i);
    END LOOP;

  END update_obs;
  ----

  PROCEDURE get_info /*  для получения инф по КД */
  (cc_id_  IN VARCHAR2, -- идентификатор   КД
   dat1_   IN DATE, -- дата ввода      КД
   nret_   OUT INT, -- Код возврата: =1 не найден, Найден =0
   sret_   OUT VARCHAR2, -- Текст ошибки (?)
   rnk_    OUT INT, -- Рег № заемщика
   ns_     OUT NUMBER, -- Сумма текущего платежа
   ns1_    OUT NUMBER, -- Сумма окончательного платежа
   nmk_    OUT VARCHAR2, -- наименованик клиента
   okpo_   OUT VARCHAR2, -- OKPO         клиента
   adres_  OUT VARCHAR2, -- адрес        клиента
   kv_     OUT INT, -- код валюты   КД
   lcv_    OUT VARCHAR2, -- ISO валюты   КД
   namev_  OUT VARCHAR2, -- валютa       КД
   unit_   OUT VARCHAR2, -- коп.валюты   КД
   gender_ OUT VARCHAR2, -- пол валюты   КД
   nss_    OUT NUMBER, -- Тек.Сумма осн.долга
   dat4_   OUT DATE, --\ дата завершения КД
   nss1_   OUT NUMBER, --/ Оконч.Сумма осн.долга
   dat_sn_ OUT DATE, --\ По какую дату нач %
   nsn_    OUT NUMBER, --/ Сумма нач %
   nsn1_   OUT NUMBER, -- | Оконч.Сумма проц.долга
   dat_sk_ OUT DATE, --\ По какую дату нач ком
   nsk_    OUT NUMBER, --/ сумма уже начисленной комиссии
   nsk1_   OUT NUMBER, --| Оконч.Сумма комис.долга
   kv_kom_ OUT INT, -- Вал комиссии
   dat_sp_ OUT DATE, -- По какую дату нач пеня
   nsp_    OUT NUMBER, -- сумма уже начисленной пени
   sn8_nls OUT VARCHAR2, --\
   sd8_nls OUT VARCHAR2, --/ счета начисления пени
   mfok_   OUT VARCHAR2, --\
   nlsk_   OUT VARCHAR2 --/ счет гашения
   ) IS
    --переменные
    nd_       INT;
    acc8_     INT;
    nint_     NUMBER;
    nlim_     NUMBER;
    dat_sn1_  DATE := gl.bdate - 1;
    dat_sk1_  DATE := gl.bdate - 1;
    l_title   VARCHAR2(20) := 'CCK.GET_INFO:'; -- префикс для трассировки
    l_bn      NUMBER := 0; -- ознака безнад_йност_
    l_acc_s8p accounts.acc%TYPE;
    l_acc_s8n accounts.acc%TYPE;
    l_acc_s8k accounts.acc%TYPE;
    l_nss1    NUMBER := 0;
    l_nsn1    NUMBER := 0;
    l_nsk1    NUMBER := 0;
  BEGIN
    nret_ := 1;
    sret_ := '?';
    --найти КД, вал.КД  и клиента
    BEGIN
      SELECT d.nd,
             d.wdate,
             c.nmk,
             c.okpo,
             c.rnk,
             c.adr,
             a.kv,
             t.lcv,
             t.name,
             t.unit,
             t.gender,
             a.acc,
             a.kf,
             d.rnk
        INTO nd_,
             dat4_,
             nmk_,
             okpo_,
             rnk_,
             adres_,
             kv_,
             lcv_,
             namev_,
             unit_,
             gender_,
             acc8_,
             mfok_,
             rnk_
        FROM cc_deal d, customer c, tabval t, accounts a, nd_acc n
       WHERE a.kv = t.kv
         AND d.sos > 9
         AND d.sos < 14
         AND d.rnk = c.rnk
         AND a.acc = n.acc
         AND a.tip = 'LIM'
         AND n.nd = d.nd
         AND d.cc_id = cc_id_
         AND d.sdate = dat1_;
    EXCEPTION
      WHEN no_data_found THEN
        nret_ := 1;
        sret_ := 'Кред.угоду НЕ знайдено !';
        RETURN;
    END;

    --найти счет гашения
    BEGIN
      SELECT a.nls
        INTO nlsk_
        FROM nd_acc n, accounts a
       WHERE n.nd = nd_
         AND a.tip = 'SG '
         AND a.kv = kv_
         AND n.acc = a.acc;
    EXCEPTION
      WHEN no_data_found THEN
        NULL;
    END;

    BEGIN
      /*  По какую дату нач % ? */
      SELECT MAX(i.acr_dat)
        INTO dat_sn_
        FROM accounts a, nd_acc n, int_accn i
       WHERE n.nd = nd_
         AND n.acc = a.acc
         AND a.tip IN ('SS ', 'SP ', 'SL ')
         AND i.id = 0
         AND a.acc = i.acc
         AND i.acr_dat IS NOT NULL;
    EXCEPTION
      WHEN no_data_found THEN
        NULL;
    END;

    nsk_ := 0;
    BEGIN
      /* По какую дату нач ком ? */
      SELECT acr_dat
        INTO dat_sk_
        FROM int_accn
       WHERE acc = acc8_
         AND id = 2;
      -- Вал и сумма уже начисленной комиссии
      SELECT MIN(a.kv), nvl(-sum(a.ostb + a.ostf), 0) / 100
        INTO kv_kom_, nsk_
        FROM accounts a, nd_acc n
       WHERE n.nd = nd_
         AND n.acc = a.acc
         AND a.tip IN ('SK0', 'SK9');
    EXCEPTION
      WHEN no_data_found THEN
        NULL;
    END;

    nsp_ := 0;
    BEGIN
      /* По какую дату нач пеня */
      SELECT nvl(i.acr_dat, a.daos - 1),
             a8.nls,
             a6.nls,
             - (a8.ostb + a.ostf) / 100
        INTO dat_sp_, sn8_nls, sd8_nls, nsp_
        FROM accounts a, nd_acc n, int_accn i, accounts a8, accounts a6
       WHERE n.nd = nd_
         AND n.acc = a.acc
         AND a.tip = 'SPN'
         AND i.id = 2
         AND a.acc = i.acc
         AND i.acra = a8.acc
         AND i.acrb = a6.acc;
    EXCEPTION
      WHEN no_data_found THEN
        NULL;
    END;

    BEGIN
      /*суммы задолженностей */
      SELECT -sum(decode(a.tip, 'LIM', ostb + ostf, 0)) / 100,
             -sum(decode(a.tip, 'LIM', 0, ostb + ostf)) / 100,
             -sum(decode(a.tip, 'LIM', ostx, 0)) / 100
        INTO nss1_, nsn_, nlim_
        FROM accounts a, nd_acc n
       WHERE n.nd = nd_
         AND n.acc = a.acc
         AND a.tip IN ('SN ', 'SPN', 'SLN', 'LIM');
      bars_audit.trace('%s 6.суммы задолженностей: nSS1_=%s,nSN_=%s,nLIM_=%s',
                       l_title,
                       to_char(nss1_),
                       to_char(nsn_),
                       to_char(nlim_));

      IF nss1_ >= 0 THEN
        nss_  := greatest(nss1_ - nlim_, 0);
        ns_   := nss_ + nsn_ + iif_n(kv_, kv_kom_, 0, nsk_, 0); /* Кiнцевий платiж */
        nsn1_ := 0;
        nsk1_ := 0;
        bars_audit.trace('%s 7.:nSS_=%s,nS_=%s',
                         l_title,
                         to_char(nss_),
                         to_char(ns_));
        --доначислить %% в игровом режиме
        IF dat_sn_ IS NULL OR dat_sn_ < dat_sn1_ THEN

          SAVEPOINT do_acrn;
          ------------------
          DELETE FROM acr_intn;
          FOR k IN (SELECT a.acc,
                           a.tip,
                           i.metr,
                           nvl(i.acr_dat, a.daos - 1) + 1 dat1
                      FROM nd_acc n, accounts a, int_accn i
                     WHERE n.nd = nd_
                       AND n.acc = a.acc
                       AND a.dazs IS NULL
                       AND a.acc = i.acc
                       AND (i.id = 0 AND a.tip IN ('SS ', 'SP ', 'SL ') OR
                           i.id = 2 AND a.tip = 'LIM' AND i.metr > 90)) LOOP
            IF k.tip = 'LIM' AND k.metr > 90 THEN
              /* Нач.комиспо разным METR>90 */
              cc_komissia(k.metr,
                          k.acc,
                          2,
                          k.dat1,
                          dat_sk1_,
                          nsk1_,
                          NULL,
                          0);
              bars_audit.trace('%s 8.доначислить %% в игровом режиме:nSK1_=%s',
                               l_title,
                               to_char(nsk1_));
              nsk1_ := -nsk1_ / 100;
            ELSE
              acrn.p_int(k.acc, 0, k.dat1, dat_sn1_, nint_, NULL, 1);
            END IF;
          END LOOP;

          BEGIN
            SELECT nvl(-sum(round(acrd + remi, 0)) / 100, 0)
              INTO nsn1_
              FROM acr_intn;
          EXCEPTION
            WHEN no_data_found THEN
              NULL;
          END;

          ROLLBACK TO do_acrn;

        END IF;
        bars_audit.trace('%s 9.рез-т: nSS1_=%s,nSN_=%s,nSN1_=%s,nSK_=%s,nSK1_=%s',
                         l_title,
                         to_char(nss1_),
                         to_char(nsn_),
                         to_char(nsn1_),
                         to_char(nsk_),
                         to_char(nsk1_));
        nsn1_ := nsn_ + nsn1_;
        nsk1_ := nsk_ + nsk1_;
        ns1_  := nss1_ + nsn1_ + iif_n(kv_, kv_kom_, 0, nsk1_, 0); /* Поточний платiж */
        bars_audit.trace('%s 10.рез-т: nSN1_=%s,nSK1_=%s,nS1_=%s',
                         l_title,
                         to_char(nsn1_),
                         to_char(nsk1_),
                         to_char(ns1_));
      END IF;

      BEGIN
        SELECT 1
          INTO l_bn
          FROM accounts a, nd_acc na
         WHERE na.nd = nd_
           AND na.acc = a.acc
           AND a.tip IN ('S8P', 'S8N', 'S8K')
           AND dazs IS NULL
           AND rownum = 1;
      EXCEPTION
        WHEN no_data_found THEN
          NULL;
      END;
      bars_audit.trace('%s 11.рез-т: l_bn=%s', l_title, to_char(l_bn));

      IF l_bn = 1 THEN
        BEGIN
          BEGIN
            SELECT a.acc
              INTO l_acc_s8p
              FROM accounts a, nd_acc na
             WHERE na.nd = nd_
               AND na.acc = a.acc
               AND a.tip = 'S8P'
               AND dazs IS NULL;
          EXCEPTION
            WHEN no_data_found THEN
              NULL;
          END;
          BEGIN
            SELECT a.acc
              INTO l_acc_s8n
              FROM accounts a, nd_acc na
             WHERE na.nd = nd_
               AND na.acc = a.acc
               AND a.tip = 'S8N'
               AND dazs IS NULL;
          EXCEPTION
            WHEN no_data_found THEN
              NULL;
          END;
          BEGIN
            SELECT a.acc
              INTO l_acc_s8k
              FROM accounts a, nd_acc na
             WHERE na.nd = nd_
               AND na.acc = a.acc
               AND a.tip = 'S8K'
               AND dazs IS NULL;
          EXCEPTION
            WHEN no_data_found THEN
              NULL;
          END;
          bars_audit.trace('%s 12.рез-т: l_acc_s8p=%s,l_acc_s8n=%s,l_acc_s8k=%s',
                           l_title,
                           to_char(l_acc_s8p),
                           to_char(l_acc_s8n),
                           to_char(l_acc_s8k));
          l_nss1 := nvl(-fost(l_acc_s8p, bankdate) / 100, 0);
          l_nsn1 := nvl(-fost(l_acc_s8n, bankdate) / 100, 0);
          l_nsk1 := nvl(-fost(l_acc_s8k, bankdate) / 100, 0);
          bars_audit.trace('%s 13.рез-т: l_nSS1=%s, l_nSN1=%s, l_nSK1=%s',
                           l_title,
                           to_char(l_nss1),
                           to_char(l_nsn1),
                           to_char(l_nsk1));
        END;
      END IF;

      nss1_ := nvl(nss1_, 0) + l_nss1;
      nsn1_ := nvl(nsn1_, 0) + l_nsn1;
      nsk1_ := nvl(nsk1_, 0) + l_nsk1;
      ns1_  := nss1_ + nsn1_ + iif_n(kv_, kv_kom_, 0, nsk1_, 0);
      bars_audit.trace('%s 14.рез-т: nSS1_=%s, nSN1_=%s, nSK1_=%s, nS1_=%s',
                       l_title,
                       to_char(nss1_),
                       to_char(nsn1_),
                       to_char(nsk1_),
                       to_char(ns1_));

    END;
    nret_ := 0;
    sret_ := '';
    RETURN;

  END get_info;

  ---------------------------------------------

  FUNCTION fbs(nd_ INT, acc_ INT, dat_ DATE) RETURN NUMBER IS
    kv8_ INT := NULL;
    tst_ NUMBER := 0; -- искомая факт.бал.вартiсть на заданную дату DAT_ в коп в вал КД
  BEGIN
    FOR k IN (SELECT a.tip, a.kv,- (s.ostf - s.dos + s.kos) s
                FROM nd_acc n, accounts a, saldoa s
               WHERE n.nd = nd_
                 AND a.acc = n.acc
                 AND a.tip IN ('LIM', 'SN ', 'SPN', 'SLN', 'SDI', 'SPI')
                 AND a.acc = s.acc
                 AND (s.acc, s.fdat) = (SELECT acc, MAX(fdat)
                                          FROM saldoa
                                         WHERE acc = s.acc
                                           AND fdat <= dat_
                                         GROUP BY acc)
               ORDER BY decode(a.tip, 'LIM', 1, 2)) LOOP
      IF k.tip = 'LIM' OR kv8_ IS NULL THEN
        kv8_ := k.kv;
      END IF;

      IF kv8_ = k.kv THEN
        tst_ := tst_ + k.s;
      ELSIF kv8_ = gl.baseval THEN
        tst_ := tst_ + gl.p_icurval(k.kv, k.s, dat_);
      ELSIF k.kv = gl.baseval THEN
        tst_ := tst_ + gl.p_ncurval(kv8_, k.s, dat_);
      ELSE
        tst_ := tst_ +
                gl.p_ncurval(kv8_, gl.p_icurval(k.kv, k.s, dat_), dat_);
      END IF;
    END LOOP;

    RETURN tst_;
  END fbs;

  FUNCTION pbs(nd_ INT, acc_ INT, dat_ DATE) RETURN NUMBER IS
    /*
    Якщо в майбутньому реальнi значення та строки потокiв грошових коштiв
    будуть вiдрiзнятися вiд запланованих,
    то на дату балансу необхiдно скоригувати балансову вартiсть
    фiнансового iнструменту (сделать проводками FBS = PBS)
    */
    acc8_ INT;
    irr_  NUMBER; --коеф дох.1 дня
    dat4_ DATE; -- последняя дата в потоке
    fdat_ DATE; -- дата периода
    s_    NUMBER; -- Сумма в одном периоде
    tst_  NUMBER := 0; -- искомая пл.бал.вартiсть на заданную дату DAT_ в коп в вал КД
  BEGIN

    RETURN 0;

    acc8_ := acc_;
    BEGIN
      /*последняя дата в потоке */
      SELECT MAX(fdat) INTO dat4_ FROM cc_many WHERE nd = nd_;
      IF dat4_ < dat_ THEN
        RETURN 0;
      END IF;
      IF acc_ IS NULL THEN
        SELECT a.acc
          INTO acc8_
          FROM accounts a, nd_acc n
         WHERE n.nd = nd_
           AND n.acc = a.acc
           AND a.tip = ' LIM';
      END IF;
      SELECT ir / 36500
        INTO irr_
        FROM int_ratn r
       WHERE r.acc = acc8_
         AND r.id = -2
         AND r.bdat = (SELECT MAX(bdat)
                         FROM int_ratn
                        WHERE acc = r.acc
                          AND id = r.id
                          AND bdat <= dat_);
    EXCEPTION
      WHEN no_data_found THEN
        RETURN 0;
    END;

    IF nvl(irr_, 0) = 0 THEN
      RETURN 0;
    END IF;

    --цикл по будущим потокам > DAT_ и <=DAT4_
    FOR k IN (SELECT num FROM conductor ORDER BY num) LOOP
      fdat_ := dat_ + k.num;
      IF fdat_ > dat4_ THEN
        EXIT;
      END IF;
      ------------------
      BEGIN
        SELECT (-ss1 + sdp + ss2 + sn2) * 100
          INTO s_
          FROM cc_many
         WHERE nd = nd_
           AND fdat = fdat_;
        tst_ := tst_ + (s_ / power((1 + irr_), k.num));
      EXCEPTION
        WHEN no_data_found THEN
          s_ := 0;
      END;
    END LOOP;

    RETURN tst_;
  END pbs;
  ----------------------
  PROCEDURE cc_wdate(custtype_ INT, dat_ DATE, mode_ INT) IS
    /* 22.09.2006 Sta  Перенос на просрочку всех долгов на след.день после dd_deal.WDATE
       CUSTTYPE_ : =1 КП БАНКИ (НБУ), =2 КП ЮЛ, =3 КП ФЛ , =0 КП ЮЛ+ФЛ,
       DAT_      : =  банковская дата
       Mode_     : =0 Для всех КД или Mode_=Реф.КД;
    */
    acc_ INT;

    kv_    accounts.kv%TYPE;
    acra_  int_accn.acra%TYPE;
    acrb_  int_accn.acrb%TYPE;
    tip_   accounts.tip%TYPE;
    isp_   accounts.isp%TYPE;
    grp_   accounts.grp%TYPE;
    s080_  specparam.s080%TYPE;
    mdate_ accounts.mdate%TYPE;
    nls_   accounts.nls%TYPE;
  BEGIN
    FOR k IN (SELECT d.nd, d.vidd, d.rnk
                FROM cc_deal d
               WHERE d.wdate > dat_ - 7
                 AND d.wdate < dat_
                 AND mode_ IN (0, d.nd)
                 AND (custtype_ = 0 OR
                     custtype_ <= 2 AND d.vidd IN (1, 2, 3) OR
                     custtype_ = 3 AND d.vidd IN (11, 12, 13))) LOOP
      cck.cc_asp(k.nd, 0);

      IF k.vidd < 10 THEN
        IF custtype_ = 2 THEN
          cck.cc_aspn(2, k.nd, -1);
        ELSE
          cck.cc_aspn(1, k.nd, -1);
        END IF;
      ELSE
        cck.cc_aspn(3, k.nd, -1);
      END IF;

      --06.11.2006 Sta  CC_WDATE Для сч SP в проц.карточке ставим SPN
      FOR p IN (SELECT a.kv,
                       a.acc,
                       vkrzn(substr(gl.amfo, 1, 5),
                             substr(a.nls, 1, 3) ||case when newnbs.get_state = 1 then '80' else '90' end ||
                             substr(a.nls, 6, 9)) nls,
                       a.isp,
                       a.grp,
                       a.mdate,
                       to_char(s.s080) s080
                  FROM nd_acc n, accounts a, specparam s
                 WHERE a.tip = 'SP '
                   AND s.acc = a.acc
                   AND a.acc = n.acc
                   AND n.nd = k.nd
                   AND a.dazs IS NULL) LOOP
        --15.08.2007 Sta Если в проц.карт счета SP уже стоит HE SN,
        --               то ничего не делать
        BEGIN
          SELECT i.acra
            INTO acc_
            FROM accounts a, int_accn i
           WHERE i.acc = p.acc
             AND i.acra = a.acc
             AND a.tip = 'SN ';
          BEGIN
            SELECT a.acc
              INTO acc_
              FROM accounts a, nd_acc n
             WHERE a.tip = 'SPN'
               AND a.kv = p.kv
               AND a.acc = n.acc
               AND n.nd = k.nd
               AND a.dazs IS NULL
               AND rownum = 1;
          EXCEPTION
            WHEN no_data_found THEN
              cck.cc_op_nls(k.nd,
                            p.kv,
                            p.nls,
                            'SPN',
                            p.isp,
                            p.grp,
                            p.s080,
                            p.mdate,
                            acc_);
          END;
          UPDATE int_accn
             SET acra = acc_
           WHERE acc = p.acc
             AND id = 0;
        EXCEPTION
          WHEN no_data_found THEN
            NULL;
        END;
      END LOOP;
      --------------
      BEGIN
        --  Novikov  перенос заполненной % карточки начисл. комиссии на счет проср. ком. с типом  SK9,  только если ком начисл на тип счета SK0
        SELECT a.kv,
               a.acc,
               r.acra,
               r.acrb,
               a.isp,
               a.grp,
               s.s080,
               a.mdate,
               (SELECT tip FROM accounts WHERE acc = r.acra) tip
          INTO kv_, acc_, acra_, acrb_, isp_, grp_, s080_, mdate_, tip_
          FROM nd_acc n, accounts a, int_accn r, specparam s
         WHERE a.tip = 'LIM'
           AND n.nd = k.nd
           AND r.acc = a.acc
           AND r.id = 2
           AND a.acc = n.acc
           AND a.dazs IS NULL
           AND a.acc = s.acc(+)
           AND r.acra IS NOT NULL;

        IF tip_ = 'SK0' THEN
          --пытаемся найти уже открытый счет SK9
          BEGIN
            SELECT a.acc
              INTO acra_
              FROM nd_acc n, accounts a
             WHERE a.tip = 'SK9'
               AND n.nd = k.nd
               AND a.acc = n.acc
               AND a.dazs IS NULL
               AND a.kv = kv_
               AND rownum = 1;
          EXCEPTION
            WHEN no_data_found THEN
              nls_ := f_newnls2(acc_, 'SK9', NULL, NULL, kv_);
              cck.cc_op_nls(k.nd,
                            kv_,
                            nls_,
                            'SK9',
                            isp_,
                            grp_,
                            to_char(s080_),
                            mdate_,
                            acra_);
          END;
          UPDATE int_accn
             SET acra = acra_
           WHERE acc = acc_
             AND id = 2;
        END IF;
      EXCEPTION
        WHEN no_data_found THEN
          NULL;
      END;

    END LOOP;

  END cc_wdate;
  -----------

  PROCEDURE cc_asg_sn8(nd_ INT, nls_6397 VARCHAR2, nls_8006 VARCHAR2) IS
    --Авто-погашение пени.
    nms_6397 VARCHAR2(38);
    tip_6397 CHAR(3);
    acc_6397 INT;
    s_       NUMBER;
    nls_8008 VARCHAR2(15);
    ost_8008 NUMBER;
    okpo_    VARCHAR2(14);
    nls_2909 VARCHAR2(15);
    ost_2909 NUMBER;
    nms_2909 VARCHAR2(38);
    nazn_    VARCHAR2(160);
    ref_     INT;
    fl_      INT;
    txt_     VARCHAR2(80);
    cc_sn8_  INT := nvl(to_number(getglobaloption('CC_SN8')), 0);
  BEGIN

    BEGIN

      txt_ := 'Ош.сч.' || nls_6397 || ' или ' || nls_8006;
      SELECT substr(a63.nms, 1, 38), a63.tip, a63.acc
        INTO nms_6397, tip_6397, acc_6397
        FROM accounts a63, accounts a80
       WHERE a63.dazs IS NULL
         AND a63.kv = gl.baseval
         AND a63.nls = nls_6397
         AND a80.dazs IS NULL
         AND a80.kv = gl.baseval
         AND a80.nls = nls_8006;

      txt_ := 'Ош.оп.ASG';
      SELECT to_number(nvl(substr(flags, 38, 1), '0'))
        INTO fl_
        FROM tts
       WHERE tt = 'ASG';

    EXCEPTION
      WHEN no_data_found THEN
        raise_application_error(- (20203),
                                '\8999 CC_ASC_SN8:' || txt_ || ' ' ||
                                SQLERRM,
                                TRUE);
    END;

    FOR k IN (SELECT d.nd, d.rnk, d.cc_id, d.sdate
                FROM cc_deal d, accounts a, nd_acc n
               WHERE nd_ IN (d.nd, 0)
                 AND a.ostc = a.ostb
                 AND (a.ostc = 0 OR cc_sn8_ = 1)
                 AND d.sos >= 10
                 AND d.sos < 14
                 AND a.acc = n.acc
                 AND n.nd = d.nd
                 AND a.tip = 'LIM') LOOP
      ost_8008 := 0;
      ost_2909 := 0;
      FOR k1 IN (SELECT a.tip, a.ostb, a.nls, a.nms, a.kv
                   FROM accounts a, nd_acc n
                  WHERE n.nd = k.nd
                    AND n.acc = a.acc
                    AND a.ostb = a.ostc
                    AND a.dazs IS NULL
                    AND a.ostb <> 0
                    AND a.tip IN
                        ('SN ', 'SPN', 'SLN', 'SK0', 'SK9', 'SN8', 'SG ')
                  ORDER BY decode(a.tip, 'SN8', 1, 'SG ', 2, 3)) LOOP

        IF k1.tip = 'SN8' AND k1.kv = gl.baseval THEN
          IF k1.ostb >= 0 THEN
            GOTO not_;
          END IF;
          nls_8008 := k1.nls;
          ost_8008 := -k1.ostb;

        ELSIF k1.tip = 'SG ' AND k1.kv = gl.baseval THEN
          IF k1.ostb <= 0 THEN
            GOTO not_;
          END IF;
          nls_2909 := k1.nls;
          ost_2909 := k1.ostb;
          nms_2909 := substr(k1.nms, 1, 38);

        ELSIF k1.ostb <> 0 AND cc_sn8_ = 1 THEN
          NULL;
        ELSIF k1.ostb <> 0 THEN
          GOTO not_;
        END IF;

      END LOOP;

      IF ost_8008 = 0 OR ost_2909 = 0 THEN
        GOTO not_;
      END IF;
      BEGIN
        SELECT okpo INTO okpo_ FROM customer WHERE rnk = k.rnk;
      EXCEPTION
        WHEN no_data_found THEN
          GOTO not_;
      END;
      nazn_ := substr('Погашення нарахованої пенi згiдно угоди ' || k.cc_id ||
                      ' вiд ' || to_char(k.sdate, 'dd/mm/yyyy'),
                      1,
                      160);

      s_ := least(ost_8008, ost_2909);

      gl.ref(ref_);
      gl.in_doc3(ref_,
                 'ASG',
                 6,
                 ref_,
                 SYSDATE,
                 gl.bdate,
                 1,
                 gl.baseval,
                 s_,
                 gl.baseval,
                 s_,
                 NULL,
                 gl.bdate,
                 gl.bdate,
                 nms_2909,
                 nls_2909,
                 gl.amfo,
                 nms_6397,
                 nls_6397,
                 gl.amfo,
                 nazn_,
                 NULL,
                 okpo_,
                 okpo_,
                 NULL,
                 NULL,
                 0,
                 NULL,
                 gl.auid);
      gl.payv(0,
              ref_,
              gl.bdate,
              'ASG',
              1,
              gl.baseval,
              nls_2909,
              s_,
              gl.baseval,
              nls_6397,
              s_);
      gl.payv(0,
              ref_,
              gl.bdate,
              'ASG',
              1,
              gl.baseval,
              nls_8006,
              s_,
              gl.baseval,
              nls_8008,
              s_);

      IF tip_6397 = 'NLX' OR fl_ = 1 THEN
        gl.pay(2, ref_, gl.bdate);
        IF tip_6397 = 'NLX' THEN
          DELETE FROM nlk_ref
           WHERE ref1 = ref_
             AND acc = acc_6397;
        END IF;
      END IF;

      <<not_>>
      NULL;
    END LOOP;
    COMMIT;

  END cc_asg_sn8;
  ----------------

  PROCEDURE cc_update(nd_      INT,
                      dat1_    DATE,
                      dat2_    DATE,
                      dat3_    DATE,
                      dat4_    DATE,
                      nvidd_   INT,
                      cc_id_   VARCHAR2,
                      summa_   NUMBER,
                      isp_     NUMBER,
                      ssource_ VARCHAR2,
                      blk_     NUMBER,
                      nlsb_    VARCHAR2,
                      mfob_    VARCHAR2,
                      acc8_    NUMBER,
                      accs_    NUMBER,
                      rday_    NUMBER,
                      ndi_     INT) IS
    ------ Процедура внесения изменений в параметры договора
    tempacc_  NUMBER;
    wdate_old DATE;
    wdatl_    DATE;
    s080_old  CHAR(1);

    l_naznkred VARCHAR2(160) := substr('Перерахування кредитних коштiв згiдно КД № ' ||
                                       cc_id_ || ' вiд ' ||
                                       to_char(dat1_, 'dd.mm.yyyy'),
                                       1,
                                       160); -- Назначение платежа
  BEGIN

    IF nlsb_ IS NOT NULL AND mfob_ = f_ourmfo() THEN
      BEGIN
        SELECT acc
          INTO tempacc_
          FROM accounts
         WHERE nls = nlsb_
           AND rownum = 1;
      EXCEPTION
        WHEN no_data_found THEN
          erm := '9354 - No account found ' || nlsb_ || ' (' || mfob_ || ')';
          RAISE err;
      END;
    END IF;

    BEGIN
      SELECT d.wdate, s.s080
        INTO wdate_old, s080_old
        FROM cc_deal d, nd_acc n, accounts a, specparam s
       WHERE d.nd = nd_
         AND d.nd = n.nd
         AND n.acc = a.acc
         AND a.tip = 'LIM'
         AND a.acc = s.acc(+);
    EXCEPTION
      WHEN no_data_found THEN
        erm := '9354 - No LIM account found ' || nd_;
        RAISE err;
    END;

    UPDATE cc_deal
       SET sdate   = dat1_,
           wdate   = dat4_,
           vidd    = nvidd_,
           cc_id   = cc_id_,
           LIMIT   = summa_,
           user_id = isp_,
           ndi     = ndi_
     WHERE nd = nd_;
    UPDATE cc_add
       SET bdate = dat2_,
           wdate = dat3_,
           sour  = to_number(ssource_),
           s     = summa_
     WHERE adds = 0
       AND nd = nd_;

    -- процедура по установке платежных реквизитов по кредиту
    cck.set_pmt_instructions(p_nd       => nd_, -- реф КД
                             p_mfokred  => mfob_, -- Платежные инструкции МФО
                             p_nlskred  => nlsb_, -------//------- счет
                             p_okpokred => NULL, -- ИПН получателя
                             p_namkred  => NULL, -- Наименование счета получателя
                             p_naznkred => NULL -- Назначение платежа
                             );

    UPDATE accounts
       SET mdate = dat4_, nlsalt = to_char(blk_)
     WHERE acc = acc8_;
    UPDATE int_accn SET s = rday_ WHERE acc = acc8_;

    IF dat4_ <> wdate_old THEN
      -- меняем дату окончания по всем счетам
      FOR k IN (SELECT n.acc, a.mdate, a.tip, a.nls, a.kv
                  FROM accounts a, nd_acc n
                 WHERE n.acc = a.acc
                   AND n.nd = nd_
                   AND a.tip IN ('LIM',
                                 'SS ',
                                 'SN ',
                                 'SP ',
                                 'SPN',
                                 'SL ',
                                 'SLN',
                                 'SDI',
                                 'SPI',
                                 'SK0',
                                 'SK9',
                                 'CR9',
                                 'SN8',
                                 'S9K',
                                 'S9N')) LOOP
        UPDATE accounts
           SET mdate = (CASE
                         WHEN k.tip = 'SS ' AND nvidd_ IN (2, 3, 12, 13) AND
                              mdate IS NOT NULL AND mdate <> wdate_old AND
                              mdate < dat4_ THEN
                          mdate
                         ELSE
                          dat4_
                       END)
         WHERE acc = k.acc
        RETURNING mdate INTO wdatl_;
        pul.PUT('MODULE', 'CCK');
        pul.PUT('ND', nd_);

        accreg.set_default_sparams(p_acc => k.acc);
        /* bars.cck_specparam(k.acc,
                           k.nls,
                           k.kv,
                           k.tip,
                           ssource_,
                           s080_old,
                           dat1_,
                           wdatl_,
                           nvidd_,
        nd_);*/
      END LOOP;
    END IF;

  EXCEPTION
    WHEN err THEN
      raise_application_error(- (20000 + ern), '\ ' || erm, TRUE);
  END cc_update;
  ---------------
  -- Процедура амортизации дисконта по-старому. Новая живет отдельно в CC_RMANY
  PROCEDURE cc_irr(tt_ CHAR, mod_ INT, dat_ DATE, ret_ OUT INT) IS

    /* 18-05-2010 запрет на отк сч Премии (для Демарка МФО= 353575)
       13-05-2010 По требованию Демарка.
       Все отд.реф.Не проводит  технического Д/П
       --точка отката при угрозе технического Д/П

       Процедура урегулирования начисленных % по методу эф.% ставки
       TT_  = 'IRR' код операции
       MOD_ = 0  По всем КД
       MOD_ > 0  По одному КД с nd=MOD_
    */

    fl_      INT;
    nms_     VARCHAR2(38);
    vob_     INT;
    nms6_    VARCHAR2(38);
    vdat_    DATE := gl.bdate;
    acc8_    INT;
    nls6_    VARCHAR2(15);
    irr_     NUMBER;
    acr_dat_ DATE;
    sn_      NUMBER;
    int_     NUMBER;
    se_      NUMBER;
    fdat1_   DATE;
    s_       NUMBER;
    tip_     CHAR(3) := 'SDI';
    dk_      INT;
    s65_     CHAR(1);
    r_       NUMBER;
    nlsr_    VARCHAR2(15);
    nls_     VARCHAR2(15);
    isp_     INT;
    nmsr_    VARCHAR2(38);
    grp_     INT;
    mdate_   DATE;
    acc_     INT;
    nazn_    VARCHAR2(160);
    ref_     INT;
    q_       NUMBER;
    zoirr_   NUMBER;
    dat_dos_ DATE;
    basey_   INT;
    ost3_    NUMBER;
    s3_      NUMBER;

  BEGIN
    return; -- COBUPRVNIX-161 блокировка амортизации дисконта и
    BEGIN
      SELECT to_number(substr(flags, 38, 1))
        INTO fl_
        FROM tts
       WHERE tt = tt_;
    EXCEPTION
      WHEN no_data_found THEN
        ret_ := 2;
        RETURN;
    END;

    BEGIN
      SELECT to_number(val) INTO zoirr_ FROM params WHERE par = 'ZO_IRR';
    EXCEPTION
      WHEN no_data_found THEN
        zoirr_ := 0;
    END;

    ret_ := 0;

    FOR k IN (SELECT d.nd,
                     c.okpo,
                     ad.kv,
                     substr(d.cc_id || ' ' || c.nmk, 1, 38) nms
                FROM cc_deal d, customer c, cc_add ad
               WHERE d.rnk = c.rnk
                 AND d.nd = ad.nd
                 AND ad.adds = 0
                 AND d.vidd IN (1, 2, 11, 12, 3, 13)
                 AND sos < 14
                 AND sos >= 10
                 AND mod_ IN (0, d.nd)
                 AND d.nd > 0) LOOP
      nms_ := k.nms;
      ret_ := 0;
      BEGIN
        --Найти все, что будет нужно
        SELECT a8.acc,
               a6.nls,
               i.acr_dat,
               round(r.ir, 4),
               substr(a6.nms, 1, 38),
               i.basey
          INTO acc8_, nls6_, acr_dat_, irr_, nms6_, basey_
          FROM accounts a8, nd_acc n, int_accn i, accounts a6, int_ratn r
         WHERE n.nd = k.nd
           AND n.acc = a8.acc
           AND a8.tip = 'LIM'
           AND i.acc = a8.acc
           AND i.id = -2
           AND i.acrb > 0
           AND i.acrb = a6.acc
           AND a6.dazs IS NULL
           AND nvl(i.acr_dat, a8.daos - 1) < dat_
           AND r.acc = i.acc
           AND r.id = i.id
           AND r.ir > 0
           AND (r.acc, r.id, r.bdat) =
               (SELECT acc, id, MAX(bdat)
                  FROM int_ratn
                 WHERE acc = r.acc
                   AND id = r.id
                   AND bdat <= dat_
                 GROUP BY acc, id);

        SELECT MIN(fdat)
          INTO dat_dos_
          FROM saldoa
         WHERE dos > 0
           AND acc = acc8_
           AND fdat <= dat_;

        IF dat_dos_ IS NULL THEN
          GOTO kin_;
        END IF;
        IF acr_dat_ IS NULL THEN
          acr_dat_ := dat_dos_ - 1;
        END IF;

      EXCEPTION
        WHEN no_data_found THEN
          ret_ := 0;
          GOTO kin_;
      END;

      sn_ := 0; /* пересчитать нормальные проценты по осн долгу в игровом режиме */
      FOR k1 IN (SELECT kv, acc FROM accounts WHERE accc = acc8_) LOOP
        int_ := 0;
        acrn.p_int(k1.acc, 0, acr_dat_ + 1, dat_, int_, NULL, 0);
        IF int_ <> 0 THEN
          /* k.KV - вал КД, k1.KV = вал ссудного сч */
          IF k.kv <> k1.kv THEN
            IF k1.kv = gl.baseval THEN
              int_ := gl.p_ncurval(k.kv, int_, gl.bdate);
            ELSIF k.kv = gl.baseval THEN
              int_ := gl.p_icurval(k1.kv, int_, gl.bdate);
            ELSE
              int_ := gl.p_ncurval(k.kv,
                                   gl.p_icurval(k1.kv, int_, gl.bdate),
                                   gl.bdate);
            END IF;
          END IF;
          sn_ := sn_ - int_;
        END IF;
      END LOOP; /* FOR k1 */

      IF k.kv = gl.baseval THEN
        vob_ := 6; /* определить VOB */
      ELSE
        vob_ := 16;
      END IF;
      -- в период ЗО на Украине
      IF zoirr_ = 1 THEN
        BEGIN
          IF gl.baseval = 980 AND
             to_char(gl.bdate, 'yyyyMM') > to_char(dat_, 'yyyyMM') THEN
            BEGIN
              SELECT MAX(fdat)
                INTO vdat_
                FROM fdat
               WHERE to_char(fdat, 'yyyyMM') < to_char(gl.bdate, 'yyyyMM');
              vob_ := 96;
            EXCEPTION
              WHEN no_data_found THEN
                NULL;
            END;
          END IF;
        END;
      END IF;

      nazn_ := substr('Регулювання нарахованих % по методу эф.% ставки=' || irr_ ||
                      ' за перiод з ' ||
                      to_char(acr_dat_ + 1, 'dd/mm/yyyy') || ' по ' ||
                      to_char(dat_, 'dd/mm/yyyy'),
                      1,
                      160);

      IF sn_ = 0 AND NOT (basey_ = 2 AND dat_ - acr_dat_ = 1 AND
          to_char(dat_, 'DD') = '31') THEN
        /*окончательное обнуление дисконта (или премии) */
        nazn_ := substr('Остаточне ' || nazn_, 1, 160);
        FOR k2 IN (SELECT a.ostb, a.nls, substr(a.nms, 1, 38) nms
                     FROM accounts a, nd_acc n
                    WHERE n.nd = k.nd
                      AND n.acc = a.acc
                      AND a.kv = k.kv
                      AND a.tip IN ('SDI', 'SPI')
                      AND a.ostb <> 0) LOOP
          IF k2.ostb > 0 THEN
            dk_ := 1;
            s_  := k2.ostb;
          ELSE
            dk_ := 0;
            s_  := -k2.ostb;
          END IF;
          q_ := gl.p_icurval(k.kv, s_, vdat_);
          gl.ref(ref_);
          INSERT INTO oper
            (s,
             s2,
             dk,
             REF,
             tt,
             vob,
             nd,
             pdat,
             vdat,
             datd,
             datp,
             nam_a,
             nlsa,
             mfoa,
             kv,
             nam_b,
             nlsb,
             mfob,
             kv2,
             nazn,
             userid,
             sign,
             id_a,
             id_b)
          VALUES
            (s_,
             q_,
             dk_,
             ref_,
             tt_,
             vob_,
             ref_,
             SYSDATE,
             vdat_,
             vdat_,
             gl.bdate,
             k2.nms,
             k2.nls,
             gl.amfo,
             k.kv,
             nms6_,
             nls6_,
             gl.amfo,
             gl.baseval,
             nazn_,
             user_id,
             getautosign,
             k.okpo,
             gl.aokpo);
          gl.payv(fl_,
                  ref_,
                  vdat_,
                  tt_,
                  dk_,
                  k.kv,
                  k2.nls,
                  s_,
                  gl.baseval,
                  nls6_,
                  q_);
        END LOOP; /* FOR k2 */

        UPDATE int_accn
           SET acr_dat = dat_
         WHERE acc = acc8_
           AND id = -2;
        ret_ := 1;
        GOTO kin_;
      END IF;
      se_    := 0;
      fdat1_ := acr_dat_; /* эф.проценты по бал стоимости в игровом режиме */

      FOR k3 IN (SELECT fdat1_ + c.num fdat
                   FROM conductor c
                  WHERE fdat1_ + c.num <= dat_
                    AND fdat1_ + c.num >= acr_dat_) LOOP
        ost3_ := 0;
        FOR p IN (SELECT a.kv,
                         s.ostf + s.kos -
                         decode(a.tip,
                                'SN ',
                                decode(s.fdat, gl.bdate, 0, s.dos),
                                s.dos) ost
                    FROM nd_acc n, accounts a, saldoa s
                   WHERE n.nd = k.nd
                     AND n.acc = a.acc
                     AND a.tip IN ('SS ',
                                   'SP ',
                                   'SL ',
                                   'SN ',
                                   'SPN',
                                   'SLN',
                                   'SDI',
                                   'SPI')
                     AND a.acc = s.acc
                     AND (s.acc, s.fdat) = (SELECT acc, MAX(fdat)
                                              FROM saldoa
                                             WHERE acc = s.acc
                                               AND fdat <= k3.fdat
                                             GROUP BY acc)) LOOP
          IF p.ost <> 0 THEN
            IF p.kv = k.kv THEN
              s3_ := p.ost;
            ELSIF p.kv = gl.baseval THEN
              s3_ := gl.p_ncurval(k.kv, p.ost, k3.fdat);
            ELSIF k.kv = gl.baseval THEN
              s3_ := gl.p_icurval(p.kv, p.ost, k3.fdat);
            ELSE
              s3_ := gl.p_ncurval(k.kv,
                                  gl.p_icurval(p.kv, p.ost, k3.fdat),
                                  k3.fdat);
            END IF;
            ost3_ := ost3_ + s3_;
          END IF;
        END LOOP; /* FOR p */

        int_ := 0;
        acrn.p_int(acc8_, -2, fdat1_ + 1, k3.fdat, int_, ost3_, 0);
        se_    := se_ - int_;
        fdat1_ := k3.fdat;

      END LOOP; /* FOR K3 */

      UPDATE int_accn
         SET acr_dat = dat_
       WHERE acc = acc8_
         AND id = -2;
      IF sn_ = se_ THEN
        ret_ := 1;
        GOTO kin_;
      END IF;
      ----------------
      -- Проводки
      s_ := sn_ - se_;
      IF s_ > 0 THEN
        dk_  := 0;
        tip_ := 'SDI';
        s65_ := '6'; /* Умен Премию,  Увел дисконт */
      ELSE
        s_   := -s_;
        dk_  := 1;
        tip_ := 'SPI';
        s65_ := '5'; /* Умен дисконт, Увел премию */
      END IF;
      q_ := gl.p_icurval(k.kv, s_, vdat_);
      ----------------------------
      -- точка отката при угрозе технического Д/П
      SAVEPOINT sp_before_payv;
      -----------------------------

      BEGIN
        -- а есть ли обратный счет  ?
        SELECT abs(a.ostb), a.nls, substr(a.nms, 1, 38)
          INTO r_, nlsr_, nmsr_
          FROM accounts a, nd_acc n
         WHERE n.nd = k.nd
           AND n.acc = a.acc
           AND a.kv = k.kv
           AND a.tip = decode(tip_, 'SDI', 'SPI', 'SDI')
           AND a.ostb <> 0;
      EXCEPTION
        WHEN no_data_found THEN
          r_ := 0;
      END;

      IF r_ >= s_ THEN
        /* забрать с реверса S_ */

        IF NOT (dk_ = 1 AND substr(nlsr_, 4, 1) = '5' OR
            dk_ = 0 AND substr(nlsr_, 4, 1) = '6') THEN
          -- оплата - 1
          gl.ref(ref_);
          INSERT INTO oper
            (s,
             s2,
             dk,
             REF,
             tt,
             vob,
             nd,
             vdat,
             datd,
             datp,
             mfoa,
             kv,
             nam_b,
             nlsb,
             mfob,
             kv2,
             nazn,
             userid,
             id_a,
             id_b,
             nlsa,
             nam_a)
          VALUES
            (s_,
             q_,
             dk_,
             ref_,
             tt_,
             vob_,
             ref_,
             vdat_,
             vdat_,
             gl.bdate,
             gl.amfo,
             k.kv,
             nms6_,
             nls6_,
             gl.amfo,
             gl.baseval,
             nazn_,
             user_id,
             k.okpo,
             gl.aokpo,
             nlsr_,
             nmsr_);
          gl.payv(fl_,
                  ref_,
                  vdat_,
                  tt_,
                  dk_,
                  k.kv,
                  nlsr_,
                  s_,
                  gl.baseval,
                  nls6_,
                  q_);
        END IF;

      ELSE

        BEGIN
          /* а есть ли прямой счет  ? */
          SELECT a.nls, substr(a.nms, 1, 38), a.acc
            INTO nls_, nms_, acc_
            FROM accounts a, nd_acc n
           WHERE a.tip = tip_
             AND a.kv = k.kv
             AND a.acc = n.acc
             AND n.nd = k.nd
             AND a.dazs IS NULL
             AND rownum = 1;
        EXCEPTION
          WHEN no_data_found THEN
            BEGIN
              /* а есть ли номинальный счет в какой-нибудь валюте ? */
              SELECT a.isp, a.grp, a.nls, a.mdate
                INTO isp_, grp_, nls_, mdate_
                FROM accounts a, nd_acc n
               WHERE a.tip = 'SS '
                 AND a.acc = n.acc
                 AND n.nd = k.nd
                 AND a.dazs IS NULL
                 AND rownum = 1;
            EXCEPTION
              WHEN no_data_found THEN
                RETURN;
            END;

            -- открыть прямой счет
            acc_ := NULL;
            nls_ := vkrzn(substr(gl.amfo, 1, 5),
                          substr(nls_, 1, 3) || s65_ || substr(nls_, 5, 10));

            IF s65_ = '5' AND gl.amfo = '353575' THEN
              NULL;
            ELSE
              cck.cc_op_nls(k.nd,
                            k.kv,
                            nls_,
                            tip_,
                            isp_,
                            grp_,
                            NULL,
                            mdate_,
                            acc_);
            END IF;

        END;

        IF acc_ IS NOT NULL THEN

          IF r_ > 0 THEN
            /* забрать с реверса R_ */
            q_ := gl.p_icurval(k.kv, r_, vdat_);

            IF NOT (dk_ = 1 AND substr(nlsr_, 4, 1) = '5' OR
                dk_ = 0 AND substr(nlsr_, 4, 1) = '6') THEN
              -- оплата - 2
              gl.ref(ref_);
              INSERT INTO oper
                (s,
                 s2,
                 dk,
                 REF,
                 tt,
                 vob,
                 nd,
                 vdat,
                 datd,
                 datp,
                 mfoa,
                 kv,
                 nam_b,
                 nlsb,
                 mfob,
                 kv2,
                 nazn,
                 userid,
                 id_a,
                 id_b,
                 nlsa,
                 nam_a)
              VALUES
                (s_,
                 q_,
                 dk_,
                 ref_,
                 tt_,
                 vob_,
                 ref_,
                 vdat_,
                 vdat_,
                 gl.bdate,
                 gl.amfo,
                 k.kv,
                 nms6_,
                 nls6_,
                 gl.amfo,
                 gl.baseval,
                 nazn_,
                 user_id,
                 k.okpo,
                 gl.aokpo,
                 nlsr_,
                 nmsr_);
              gl.payv(fl_,
                      ref_,
                      vdat_,
                      tt_,
                      dk_,
                      k.kv,
                      nlsr_,
                      r_,
                      gl.baseval,
                      nls6_,
                      q_);
            END IF;

            -- и провести по прямому (S_-R_)
            s_ := s_ - r_;
            q_ := gl.p_icurval(k.kv, s_, vdat_);
            IF NOT (dk_ = 1 AND substr(nls_, 4, 1) = '5' OR
                dk_ = 0 AND substr(nls_, 4, 1) = '6') THEN
              -- оплата - 3
              gl.ref(ref_);
              INSERT INTO oper
                (s,
                 s2,
                 dk,
                 REF,
                 tt,
                 vob,
                 nd,
                 vdat,
                 datd,
                 datp,
                 mfoa,
                 kv,
                 nam_b,
                 nlsb,
                 mfob,
                 kv2,
                 nazn,
                 userid,
                 id_a,
                 id_b,
                 nlsa,
                 nam_a)
              VALUES
                (s_,
                 q_,
                 dk_,
                 ref_,
                 tt_,
                 vob_,
                 ref_,
                 vdat_,
                 vdat_,
                 gl.bdate,
                 gl.amfo,
                 k.kv,
                 nms6_,
                 nls6_,
                 gl.amfo,
                 gl.baseval,
                 nazn_,
                 user_id,
                 k.okpo,
                 gl.aokpo,
                 nls_,
                 nms_);
              gl.payv(fl_,
                      ref_,
                      vdat_,
                      tt_,
                      dk_,
                      k.kv,
                      nls_,
                      s_,
                      gl.baseval,
                      nls6_,
                      q_);
            END IF;

          ELSE
            /* провести только по прямому S_ */

            IF NOT (dk_ = 1 AND substr(nls_, 4, 1) = '5' OR
                dk_ = 0 AND substr(nls_, 4, 1) = '6') THEN
              -- оплата - 4
              gl.ref(ref_);
              INSERT INTO oper
                (s,
                 s2,
                 dk,
                 REF,
                 tt,
                 vob,
                 nd,
                 vdat,
                 datd,
                 datp,
                 mfoa,
                 kv,
                 nam_b,
                 nlsb,
                 mfob,
                 kv2,
                 nazn,
                 userid,
                 id_a,
                 id_b,
                 nlsa,
                 nam_a)
              VALUES
                (s_,
                 q_,
                 dk_,
                 ref_,
                 tt_,
                 vob_,
                 ref_,
                 vdat_,
                 vdat_,
                 gl.bdate,
                 gl.amfo,
                 k.kv,
                 nms6_,
                 nls6_,
                 gl.amfo,
                 gl.baseval,
                 nazn_,
                 user_id,
                 k.okpo,
                 gl.aokpo,
                 nls_,
                 nms_);
              gl.payv(fl_,
                      ref_,
                      vdat_,
                      tt_,
                      dk_,
                      k.kv,
                      nls_,
                      s_,
                      gl.baseval,
                      nls6_,
                      q_);
            END IF;

          END IF;
        END IF;

      END IF;
      ret_ := 1;
      <<kin_>>
      NULL;
    END LOOP; /*  FOR k */

  END cc_irr;
  --------------===================
  PROCEDURE cc_irr1(tt_   CHAR, -- код операции для проводки
                    mod_  INT, -- реф КД (или 0= все)
                    dat_  DATE, -- дaта FBS и PBS
                    ndel_ NUMBER, -- детьта FBS  - PBS или NULL
                    ret_  OUT INT -- возвращаемый код
                    ) IS

    /* Процедура выравнивания фактич.бал стоимости до плановой
    TT_='IRR' код оп, MOD_ = 0  По всем КД,  MOD_ > 0  По одному КД с nd=MOD_ */

    fl_    INT;
    s_     NUMBER;
    nms_   VARCHAR2(38);
    nls_   VARCHAR2(15);
    vob_   INT := 6;
    q_     NUMBER;
    nms6_  VARCHAR2(38);
    nls6_  VARCHAR2(15);
    dk_    INT;
    r_     NUMBER;
    nmsr_  VARCHAR2(38);
    nlsr_  VARCHAR2(15);
    ref_   INT;
    mdate_ DATE;
    nazn_  VARCHAR2(160);
    vdat_  DATE := gl.bdate;
    isp_   INT;
    grp_   INT;
    s65_   CHAR(1);
    acc_   INT;
    tip_   CHAR(3);
  BEGIN
    ret_ := 0;
    SELECT to_number(substr(flags, 38, 1))
      INTO fl_
      FROM tts
     WHERE tt = tt_;
    -- в период ЗО на Украине
    IF gl.baseval = 980 AND
       to_char(gl.bdate, 'yyyyMM') > to_char(dat_, 'yyyyMM') THEN
      BEGIN
        SELECT MAX(fdat)
          INTO vdat_
          FROM fdat
         WHERE to_char(fdat, 'yyyyMM') < to_char(gl.bdate, 'yyyyMM');
        vob_ := 96;
      EXCEPTION
        WHEN no_data_found THEN
          NULL;
      END;
    END IF;
    --------------------------------
    FOR k IN (SELECT d.nd,
                     c.okpo,
                     ad.kv,
                     substr(d.cc_id || ' ' || c.nmk, 1, 38) nms
                FROM cc_deal d, customer c, cc_add ad
               WHERE d.rnk = c.rnk
                 AND d.nd = ad.nd
                 AND ad.adds = 0
                 AND sos < 14
                 AND sos >= 10
                 AND mod_ IN (0, d.nd)
                 AND d.nd > 0) /* найти параметры КД */
     LOOP
      nms_ := k.nms;
      ret_ := 0;
      IF mod_ = 0 OR ndel_ IS NULL THEN
        s_ := round(cck.pbs(k.nd, NULL, dat_) - cck.fbs(k.nd, NULL, dat_));
      ELSE
        s_ := -ndel_;
      END IF;

      IF nvl(s_, 0) <= 0 THEN
        GOTO kin_;
      END IF;
      --- Выполняем только в случае досрочного погашения, т.е. Пл>Фак или S_>0

      BEGIN
        /* Найти все, что будет нужно */

        SELECT a6.nls, substr(a6.nms, 1, 38)
          INTO nls6_, nms6_
          FROM accounts a8, nd_acc n, int_accn i, accounts a6
         WHERE n.nd = k.nd
           AND n.acc = a8.acc
           AND a8.tip = 'LIM'
           AND i.acc = a8.acc
           AND i.id = -2
           AND i.acrb > 0
           AND i.acrb = a6.acc
           AND a6.dazs IS NULL;

        SELECT a.nls, substr(a.nms, 1, 38)
          INTO nls_, nms_
          FROM accounts a, nd_acc n
         WHERE a.tip = 'SDI'
           AND a.kv = k.kv
           AND a.acc = n.acc
           AND n.nd = k.nd
           AND a.dazs IS NULL
           AND ostb > s_
           AND ostc = ostb;
      EXCEPTION
        WHEN no_data_found THEN
          ret_ := 0;
          GOTO kin_;
      END;
      IF vob_ <> 96 THEN
        /* определить VOB */
        IF k.kv = gl.baseval THEN
          vob_ := 6;
        ELSE
          vob_ := 16;
        END IF;
      END IF;
      nazn_ := substr('Регулювання фактичної бал.ватростi до планової станом на ' ||
                      to_char(dat_, 'dd/mm/yyyy'),
                      1,
                      160);
      q_    := gl.p_icurval(k.kv, s_, vdat_);
      dk_   := 1;
      ----- Проводки ---
      gl.ref(ref_);
      INSERT INTO oper
        (s,
         s2,
         dk,
         REF,
         tt,
         vob,
         nd,
         pdat,
         vdat,
         datd,
         datp,
         nam_a,
         nlsa,
         mfoa,
         kv,
         nam_b,
         nlsb,
         mfob,
         kv2,
         nazn,
         userid,
         sign,
         id_a,
         id_b)
      VALUES
        (s_,
         q_,
         dk_,
         ref_,
         tt_,
         vob_,
         ref_,
         SYSDATE,
         vdat_,
         vdat_,
         gl.bdate,
         nms_,
         nls_,
         gl.amfo,
         k.kv,
         nms6_,
         nls6_,
         gl.amfo,
         gl.baseval,
         nazn_,
         user_id,
         getautosign,
         k.okpo,
         gl.aokpo);
      gl.payv(fl_,
              ref_,
              vdat_,
              tt_,
              dk_,
              k.kv,
              nls_,
              s_,
              gl.baseval,
              nls6_,
              q_);

      ret_ := 1;
      <<kin_>>
      NULL;
    END LOOP;

  END cc_irr1;

  -------------------
  PROCEDURE cc_irr_new(mod_ INT, p_dat2 DATE) IS

    /* 10.03.2015 начисление проц.доходов на бал. стоимость по эф.ставке
       затвердженого постановою Правління НБУ від 25.01.2012 № 23,
      зареєстрованого в Міністерстві юстиції України 15.02.2012 за № 231/20544 (зі змінами)
       TT_  = 'IRR' код операции
       MOD_ = 0  По всем КД
       MOD_ > 0  По одному КД с nd=MOD_
    */
    dd    cc_deal%ROWTYPE;
    d1    SYS_REFCURSOR;
    l_ref NUMBER;
    -----------------------------------------------
  BEGIN
    IF mod_ = 2 THEN
      OPEN d1 FOR
        SELECT *
          FROM cc_deal
         WHERE sos >= 10
           AND sos < 14
           AND wdate >= p_dat2
           AND vidd IN (1, 2);
    ELSIF mod_ = 3 THEN
      OPEN d1 FOR
        SELECT *
          FROM cc_deal
         WHERE sos >= 10
           AND sos < 14
           AND wdate >= p_dat2
           AND vidd IN (11, 12);
    ELSIF mod_ > 0 THEN
      OPEN d1 FOR
        SELECT *
          FROM cc_deal
         WHERE sos >= 10
           AND sos < 14
           AND wdate >= p_dat2
           AND vidd IN (1, 2, 11, 12)
           AND nd = mod_;
    ELSIF mod_ = 0 THEN
      OPEN d1 FOR
        SELECT *
          FROM cc_deal
         WHERE sos >= 10
           AND sos < 14
           AND wdate >= p_dat2
           AND vidd IN (1, 2, 11, 12);
    ELSE
      RETURN;
    END IF;
    LOOP
      FETCH d1
        INTO dd;
      EXIT WHEN d1%NOTFOUND;
      cck.int_irr(dd, p_dat2, l_ref);
      --         If l_ref is not null then gl.pay (2, l_ref, gl.bdate);  end if;
    END LOOP;
    CLOSE d1;
  END cc_irr_new;
  -----------
  PROCEDURE int_irr(dd cc_deal%ROWTYPE, p_dat2 DATE, p_ref OUT NUMBER) IS

    i_irr  NUMBER; -- реальная  эф. ставка - коэф 1-го дня
    l_int  NUMBER; -- расч сумма процентов - рабочая ячейка
    l_bv   NUMBER; -- балансовая стоимость
    l_dat1 DATE; -- дата начала периода
    l_dati DATE; -- дата в периоде (в курсоре)
    l_rez  NUMBER; -- сумм резерва
    l_dn   INT; -- колич одинаковых дней
    l_remi NUMBER; -- разница округдений
    aa8    accounts%ROWTYPE; -- счет 8999*
    aa6    accounts%ROWTYPE; -- счет проц.дох 6042
    aa1    accounts%ROWTYPE; -- счет начисленных  проц 2208, актив, по ном ставке, тип =SN
    aa2    accounts%ROWTYPE; -- счет непризнанных проц 2208, контр/актив, по эф. ставке, тип =SNA
    aad    accounts%ROWTYPE; -- счет дисконта 22086 контр/актив,  тип = SDI
    l_txt  VARCHAR2(70);
    n_sdi  NUMBER; -- норма дисконта
    oo_s   NUMBER;
    oo_s2  NUMBER;
    oo_dk  INT;
    l_kol  INT;
  BEGIN

    --LIM 8999*
    BEGIN
      SELECT a.*
        INTO aa8
        FROM accounts a, nd_acc n
       WHERE n.nd = dd.nd
         AND n.acc = a.acc
         AND a.tip = 'LIM';
      SELECT a.*
        INTO aa1
        FROM accounts a, nd_acc n
       WHERE n.nd = dd.nd
         AND n.acc = a.acc
         AND a.tip = 'SN '
         AND kv = aa8.kv
         AND a.dazs IS NULL
         AND rownum = 1;
      BEGIN
        SELECT a.*
          INTO aa2
          FROM accounts a, nd_acc n
         WHERE n.nd = dd.nd
           AND n.acc = a.acc
           AND a.tip = 'SNA';
      EXCEPTION
        WHEN no_data_found THEN
          aa2.nls := f_newnls(aa8.acc, 'SN ', aa1.nbs);
          aa2.nms := 'Нараховані/невизнані дох.КД=' || dd.nd;
          aa2.kv  := aa8.kv;
          cck.cc_op_nls(dd.nd,
                        aa8.kv,
                        aa2.nls,
                        'SNA',
                        aa1.isp,
                        aa1.grp,
                        NULL,
                        aa1.mdate,
                        aa2.acc);
          accreg.setaccountsparam(aa2.acc, 'OB22', aa1.ob22);
          UPDATE accounts SET pap = 3 WHERE acc = aa2.acc;
      END;
    EXCEPTION
      WHEN no_data_found THEN
        RETURN;
    END;
    -----------------
    l_dat1 := NULL;
    oo_s   := 0;
    p_ref  := NULL;
    -----------------
    -- цикл по счетам тела кредита
    FOR k IN (SELECT i.acc,
                     nvl(i.acr_dat, a.daos - 1) acr_dat,
                     i.acrb,
                     a.kv,
                     a.nls,
                     i.acra
                FROM int_accn i, accounts a
               WHERE i.id = 0
                 AND i.acc = a.acc
                 AND nvl(i.acr_dat, a.daos - 1) < p_dat2
                 AND a.kv = aa8.kv
                 AND a.accc = aa8.acc
                 AND i.acra IS NOT NULL
                 AND i.acrb IS NOT NULL
                 AND a.dazs IS NULL
               ORDER BY a.daos) LOOP
      l_dat1 := k.acr_dat + 1;

      IF p_ref IS NULL THEN

        -- SD* счет 6-го кл
        BEGIN
          SELECT * INTO aa6 FROM accounts WHERE acc = k.acrb;
        EXCEPTION
          WHEN no_data_found THEN
            RETURN;
        END;

        gl.ref(p_ref);
        gl.in_doc3(ref_   => p_ref,
                   tt_    => 'IRR',
                   vob_   => 6,
                   nd_    => to_char(dd.nd),
                   vdat_  => gl.bdate,
                   dk_    => 1,
                   kv_    => aa2.kv,
                   s_     => 1,
                   kv2_   => gl.baseval,
                   s2_    => 1,
                   sk_    => NULL,
                   data_  => gl.bdate,
                   datp_  => gl.bdate,
                   nam_a_ => substr(aa2.nms, 1, 38),
                   nlsa_  => aa2.nls,
                   mfoa_  => gl.amfo,
                   nam_b_ => substr(aa6.nms, 1, 38),
                   nlsb_  => aa6.nls,
                   mfob_  => gl.amfo,
                   nazn_  => 'Нарах.%% по КД № ' || dd.cc_id || ' від ' ||
                             to_char(dd.sdate, 'dd.mm.yyyy') ||
                             ' за період з ' ||
                             to_char(l_dat1, 'dd.mm.yyyy') || ' по ' ||
                             to_char(p_dat2, 'dd.mm.yyyy') || '. Рах.' ||
                             k.nls,
                   d_rec_ => NULL,
                   id_a_  => gl.aokpo,
                   id_b_  => gl.aokpo,
                   id_o_  => NULL,
                   sign_  => NULL,
                   sos_   => 0,
                   prty_  => NULL,
                   uid_   => NULL);

        -- Ставка (коеф 1-го дня)
        i_irr := nvl(acrn.fprocn(aa8.acc, -2, l_dat1), 0);
        IF i_irr > 0 AND i_irr < 100 THEN
          i_irr := power((1 + i_irr / 100), 1 / 365) - 1;
          -- резерв за прошл мес
          SELECT nvl(SUM(rez * 100), 0)
            INTO l_rez
            FROM nbu23_rez
           WHERE fdat = trunc(p_dat2, 'MM')
             AND id LIKE 'CCK2%'
             AND nd = dd.nd
             AND kv = aa8.kv;

          -- 1) нач бал.стоимость и дисконт
          SELECT -nvl(SUM(fost(a.acc, l_dat1)), 0),
                 SUM(decode(a.tip, 'SDI', fost(a.acc, p_dat2), 0)),
                 MIN(decode(a.tip, 'SDI', a.nls, NULL))
            INTO l_bv, aad.ostc, aad.nls
            FROM accounts a, nd_acc n
           WHERE a.acc = n.acc
             AND n.nd = dd.nd
             AND a.nbs LIKE '2%'
             AND a.kv = aa8.kv;

          IF aad.ostc > 0 THEN
            n_sdi    := round(norm_sdi(dd.nd, p_dat2), 0);
            aad.ostc := greatest(0, aad.ostc - n_sdi);
            IF aad.ostc >= 1 THEN
              gl.payv(0,
                      p_ref,
                      gl.bdate,
                      'IRR',
                      1,
                      aa8.kv,
                      aad.nls,
                      aad.ostc,
                      aa8.kv,
                      aa2.nls,
                      aad.ostc);
              l_txt := 'Амортизація дисконту по еф.ставці.';
              UPDATE opldok
                 SET txt = l_txt
               WHERE REF = gl.aref
                 AND stmt = gl.astmt;
              oo_s := -aad.ostc;
            END IF; -- aad.ostc  >=1
          END IF; -- aad.ostc > 0

          l_bv := l_bv - l_rez;
          -- i) i-тая бал.стоимость  + проц от 1 до (N-1)
          l_dati := l_dat1;
          FOR b IN (SELECT f.fdat, -sum(fost(a.acc, f.fdat)) s
                      FROM fdat f, accounts a, nd_acc n
                     WHERE f.fdat > l_dat1
                       AND f.fdat <= p_dat2
                       AND a.acc = n.acc
                       AND n.nd = dd.nd
                       AND a.nbs LIKE '2%'
                       AND a.kv = aa8.kv
                     GROUP BY f.fdat
                     ORDER BY f.fdat) LOOP
            l_dn   := (b.fdat - l_dati);
            l_int  := l_bv * i_irr * l_dn;
            oo_s   := oo_s + l_int;
            l_bv   := b.s - l_rez;
            l_dati := b.fdat;
          END LOOP; --- b

          -- N) послед проц от (N-1) до N
          l_dn  := (p_dat2 + 1 - l_dati);
          l_int := l_bv * i_irr * l_dn;
          oo_s  := round(oo_s + l_int, 0);
          IF oo_s >= 1 THEN
            oo_dk := 1;
          ELSIF oo_s <= -1 THEN
            oo_dk := 0;
            oo_s  := -oo_s;
          END IF;

          IF oo_s > 0 THEN
            IF aa8.kv = gl.baseval THEN
              oo_s2 := oo_s;
            ELSE
              oo_s2 := gl.p_icurval(aa8.kv, oo_s, gl.bdate);
            END IF;
            gl.payv(0,
                    p_ref,
                    gl.bdate,
                    'IRR',
                    oo_dk,
                    aa8.kv,
                    aa2.nls,
                    oo_s,
                    gl.baseval,
                    aa6.nls,
                    oo_s2);
            l_txt := 'Нарахування доходу по еф.ставці';
            UPDATE opldok
               SET txt = l_txt
             WHERE REF = gl.aref
               AND stmt = gl.astmt;
            UPDATE oper SET s = oo_s, s2 = oo_s2 WHERE REF = p_ref;
          END IF; -- oo_s > 0
        END IF; -- i_irr > 0
        l_kol := 0;
      END IF; --- p_ref is null

      -- Ном.проценты на счет
      acrn.p_int(k.acc, 0, (k.acr_dat + 1), p_dat2, l_int, NULL, 1);

      -- Відмітити дату останнього нарахування та різницю округлень      -- сумма відсотків для проводки
      l_remi := l_int - round(l_int, 0);
      l_int  := -round(l_int, 0);
      UPDATE int_accn
         SET acr_dat = p_dat2, s = l_remi
       WHERE acc = k.acc
         AND id = 0;
      IF l_int >= 1 THEN

        IF l_kol > 0 THEN
          gl.ref(p_ref);
          gl.in_doc3(ref_   => p_ref,
                     tt_    => '%%1',
                     vob_   => 6,
                     nd_    => to_char(dd.nd),
                     vdat_  => gl.bdate,
                     dk_    => 1,
                     kv_    => k.kv,
                     s_     => 1,
                     kv2_   => gl.baseval,
                     s2_    => 1,
                     sk_    => NULL,
                     data_  => gl.bdate,
                     datp_  => gl.bdate,
                     nam_a_ => substr(aa1.nms, 1, 38),
                     nlsa_  => aa1.nls,
                     mfoa_  => gl.amfo,
                     nam_b_ => substr(aa2.nms, 1, 38),
                     nlsb_  => aa2.nls,
                     mfob_  => gl.amfo,
                     nazn_  => 'Нарах.%% по КД № ' || dd.cc_id || ' від ' ||
                               to_char(dd.sdate, 'dd.mm.yyyy') ||
                               ' за період з ' ||
                               to_char(l_dat1, 'dd.mm.yyyy') || ' по ' ||
                               to_char(p_dat2, 'dd.mm.yyyy') || '. Рах.' ||
                               k.nls,
                     d_rec_ => NULL,
                     id_a_  => gl.aokpo,
                     id_b_  => gl.aokpo,
                     id_o_  => NULL,
                     sign_  => NULL,
                     sos_   => 0,
                     prty_  => NULL,
                     uid_   => NULL);
        END IF;

        l_kol := l_kol + 1;

        gl.payv(0,
                p_ref,
                gl.bdate,
                '%%1',
                1,
                aa1.kv,
                aa1.nls,
                l_int,
                aa2.kv,
                aa2.nls,
                l_int);
        l_txt := substr('%% по ном.ст на рах.' || k.kv || '/' || k.nls ||
                        ' з ' || to_char((k.acr_dat + 1), 'dd.mm.yyyy') ||
                        ' по  ' || to_char(p_dat2, 'dd.mm.yyyy'),
                        1,
                        70);
        UPDATE opldok
           SET txt = l_txt
         WHERE REF = gl.aref
           AND stmt = gl.astmt;
        UPDATE oper SET s = l_int, s2 = NULL WHERE REF = p_ref;
        gl.pay(2, p_ref, gl.bdate);

        -- внести в архів для друку
        acrn.acr_dati(k.acc, 0, p_ref, p_dat2, l_remi);
      END IF; -- l_int >=1
    END LOOP; --- k
  END int_irr;
  --------------------------------
  PROCEDURE an_gpk(nd_ INT, s1_ NUMBER, den_ INT) IS

    --построение ГПК с суммой гашения 1 платежа (S1_) в указанный день(Den_)
    datn_  DATE; -- дата начала (выдачи)
    dat01_ DATE; -- 01-е число пред мес
    sk1_   NUMBER; -- сумма-кредита-1 от 01   по Den_-1
    sk2_   NUMBER; -- сумма кредита-2 от Den_ по 31
    dat31_ DATE; -- "31"-число пред мес
    datk_  DATE; -- дата завершения
    acc8_  INT;
    p1_    NUMBER;
    p2_    NUMBER;
    fdat1_ DATE;
    s_     NUMBER;
    acc_ss INT;

  BEGIN
    p_cc_lim_copy(p_nd => nd_, p_comments => 'CCK.AN_GPK');
    DELETE FROM cc_lim l
     WHERE l.nd = nd_
       AND (l.nd, l.fdat) <>
           (SELECT nd, MIN(fdat) FROM cc_lim WHERE nd = l.nd GROUP BY nd);
    BEGIN
      SELECT l.acc, l.fdat, l.lim2, d.wdate
        INTO acc8_, datn_, sk1_, datk_
        FROM cc_lim l, cc_deal d
       WHERE l.nd = nd_
         AND l.nd = d.nd;
      UPDATE cc_lim
         SET sumg = 0, sumo = 0
       WHERE nd = nd_
         AND fdat = datn_;
      fdat1_ := to_date(to_char(den_) || to_char(datn_, 'MMYYYY'),
                        'DDMMYYYY');

      INSERT INTO cc_lim
        (nd, fdat, sumo, acc, lim2, sumg)
        SELECT nd_, add_months(fdat1_, c.num), s1_, acc8_, 0, 0
          FROM conductor c
         WHERE c.num >= 1
           AND add_months(fdat1_, c.num) < datk_;

      SELECT a.acc
        INTO acc_ss
        FROM nd_acc n, accounts a
       WHERE n.nd = nd_
         AND a.acc = n.acc
         AND a.tip = 'SS '
         AND dazs IS NULL
         AND rownum = 1;
    EXCEPTION
      WHEN no_data_found THEN
        RETURN;
    END;

    sk2_   := sk1_;
    fdat1_ := datn_;
    p1_    := 0;
    p2_    := 0;
    DELETE FROM acr_intn;
    FOR k IN (SELECT fdat
                FROM cc_lim
               WHERE nd = nd_
                 AND fdat > datn_
               ORDER BY fdat) LOOP

      dat01_ := (fdat1_ - to_number(to_char(k.fdat, 'dd'))) + 1; /* 1 день пред мес */
      dat31_ := k.fdat - to_number(to_char(k.fdat, 'dd')); /* 31 день пред ме */

      IF fdat1_ > datn_ THEN
        acrn.p_int(acc_ss, 0, dat01_, fdat1_ - 1, p1_, -sk1_, 0);
      END IF;

      acrn.p_int(acc_ss, 0, fdat1_, dat31_, p2_, -sk2_, 0);
      p1_  := round(-p1_ - p2_, 0);
      sk1_ := sk2_;
      sk2_ := greatest(0, sk2_ - (s1_ - p1_));

      UPDATE cc_lim
         SET sumg    =
             (s1_ - p1_),
             lim2     = sk2_,
             not_9129 = 1
       WHERE nd = nd_
         AND fdat = k.fdat;
    END LOOP;

    acrn.p_int(acc_ss, 0, dat01_, datn_ - 1, p1_, -sk1_, 0);
    p1_ := round(-p1_, 0);

    INSERT INTO cc_lim
      (nd, fdat, lim2, acc, not_9129, sumg, sumo)
    VALUES
      (nd_, datk_, 0, acc8_, 1, sk1_, sk1_ + p1_);
    UPDATE accounts SET vid = 4 WHERE acc = acc8_;
  END an_gpk;

  ---------------------

  FUNCTION r011_s181(acc_ int, nd_ int) RETURN CHAR IS
    --Спецпарам R011 + S181
    nbs_      CHAR(4);
    tip_      CHAR(3);
    aim_      INT;
    nbs_ss_   CHAR(4);
    rs_       CHAR(2) := '  ';
    nbs_prod_ CHAR(4);
  BEGIN
 bars_audit.info('CCK.R011_S181 acc_= '||acc_||' , nd_ ='||nd_);
    BEGIN

      SELECT decode(i.aim, 0, 0, 1), a.nbs, a.tip
        INTO aim_, nbs_, tip_
        FROM cc_add i, accounts a
       WHERE i.nd = nd_
         AND i.adds = 0
         AND a.acc = acc_;

      IF tip_ IN ('SP ', 'SN ', 'SPN', 'SL ', 'SLN', 'SK0', 'SK9') THEN

        SELECT MIN(a.nbs)
          INTO nbs_ss_
          FROM accounts a, nd_acc n
         WHERE a.tip = 'SS '
           AND a.acc = n.acc
           AND n.nd = nd_
           AND a.dazs IS NULL;

        SELECT substr(d.prod, 1, 4)
          INTO nbs_prod_
          FROM cc_deal d
         WHERE d.nd = nd_;

        SELECT decode(nbs_ss_, NULL, nbs_prod_, nbs_ss_)
          INTO nbs_ss_
          FROM dual;

        IF nbs_ss_ IS NOT NULL THEN

          SELECT decode(tip_,
                        'SP ',
                        nvl(r011_sp, ' ') || nvl(s181_sp, ' '),
                        'SN ',
                        nvl(r011_sn, ' ') || nvl(s181_sn, ' '),
                        'SK0',
                        nvl(r011_sn, ' ') || nvl(s181_sn, ' '),
                        'SPN',
                        nvl(r011_spn, ' ') || nvl(s181_spn, ' '),
                        'SK9',
                        nvl(r011_spn, ' ') || nvl(s181_spn, ' '),
                        'SL ',
                        nvl(r011_sl, ' ') || nvl(s181_sl, ' '),
                        'SLN',
                        nvl(r011_sln, ' ') || nvl(s181_sln, ' '),
                        '  ')
            INTO rs_
            FROM cck_r011_r181
           WHERE aim = aim_
             AND ss = nbs_ss_;

        END IF;

      END IF;

    EXCEPTION
      WHEN no_data_found THEN
        null;
    END;
    RETURN rs_;

  END r011_s181;

  ---------------------------------------

  FUNCTION sum_int(kv8_ INT, nd_ INT, dat_ DATE) RETURN NUMBER IS
    --Сумма проц по договору в базовой валюте договора на дату
    s_ NUMBER := 0;
  BEGIN
    FOR k IN (SELECT a.kv, s.ostf - s.dos + s.kos s
                FROM accounts a, nd_acc n, saldoa s
               WHERE a.tip IN ('SN ', 'SPN')
                 AND a.acc = n.acc
                 AND a.acc = s.acc
                 AND n.nd = nd_
                 AND (a.acc, s.fdat) = (SELECT acc, MAX(fdat)
                                          FROM saldoa
                                         WHERE acc = a.acc
                                           AND fdat <= dat_
                                         GROUP BY acc)) LOOP
      IF kv8_ = k.kv THEN
        s_ := s_ + k.s;
      ELSIF kv8_ = gl.baseval THEN
        s_ := s_ + gl.p_icurval(k.kv, k.s, dat_);
      ELSE
        s_ := s_ + gl.p_ncurval(kv8_, gl.p_icurval(k.kv, k.s, dat_), dat_);
      END IF;
    END LOOP;
    RETURN s_;
  END sum_int;
  ----------------------------------------
  FUNCTION sum_spn(nd_ INT) RETURN NUMBER IS
    --Сумма просроч проц по договору на дату
    dat31_ DATE := gl.bdate - to_number(to_char(gl.bdate, 'dd'));
    sn_    NUMBER := 0;
    kos_   NUMBER := 0;
    k_     NUMBER := 0;
    spn_   NUMBER := 0;
    s_     NUMBER := 0;
    kv_    INT;

  BEGIN

    BEGIN
      SELECT kv
        INTO kv_
        FROM cc_add
       WHERE nd = nd_
         AND adds = 0;

      FOR k IN (SELECT a.kv, a.acc
                  FROM nd_acc n, accounts a
                 WHERE n.nd = nd_
                   AND a.acc = n.acc
                   AND a.tip = 'SN ') LOOP
        BEGIN
          --начислено (остаток) на 31 число
          SELECT -gl.p_icurval(k.kv, s.ostf + s.kos - s.dos, gl.bdate)
            INTO s_
            FROM saldoa s
           WHERE s.acc = k.acc
             AND (s.acc, s.fdat) = (SELECT acc, MAX(fdat)
                                      FROM saldoa
                                     WHERE acc = s.acc
                                       AND fdat <= dat31_
                                     GROUP BY acc);
          sn_ := sn_ + s_;

          --погашено с тех пор по запрош.дату
          SELECT nvl(SUM(gl.p_icurval(k.kv, s.kos, gl.bdate)), 0)
            INTO k_
            FROM saldoa s
           WHERE s.acc = k.acc
             AND s.fdat > dat31_
             AND s.fdat <= gl.bdate;
          kos_ := kos_ + k_;

        EXCEPTION
          WHEN no_data_found THEN
            s_ := 0;
        END;
      END LOOP;

      IF sn_ > kos_ THEN
        -- не все погасили !
        spn_ := gl.p_ncurval(kv_, sn_ - kos_, gl.bdate);
      END IF;

    EXCEPTION
      WHEN no_data_found THEN
        spn_ := 0;
    END;

    RETURN spn_;

  END sum_spn;
  --------------------
  FUNCTION sum_asg(nd_ INT, kv_ INT) RETURN NUMBER IS
    --Сумма ожидаемого платежа по КД в заданной валюте на тек банк дату
    --Внимание ! Норм проц долг = остатку на SN
    n_   NUMBER;
    ost_ NUMBER;
  BEGIN
    -- % долг
    SELECT nvl(SUM(a.ostb), 0)
      INTO n_
      FROM accounts a, nd_acc n
     WHERE n.nd = nd_
       AND n.acc = a.acc
       AND a.kv = kv_
       AND a.ostb < 0
       AND a.tip IN ('SPN_', 'SLN', 'SN ');

    BEGIN
      -- долг
      SELECT ostb - nvl(ostx, ostb)
        INTO ost_
        FROM accounts a, nd_acc n
       WHERE n.nd = nd_
         AND n.acc = a.acc
         AND a.kv = kv_
         AND a.tip = 'LIM';

      IF ost_ < 0 THEN
        n_ := n_ + ost_;
      END IF;

    EXCEPTION
      WHEN no_data_found THEN
        NULL;
    END;

    RETURN n_;

  END sum_asg;

  ----------------------
  -- Функция корректировки даты, если приходится на выходные - всегда идет вперед
  -- или назад в зависимости от глоб.пар-ра CC_DAYNP (2-я дата)

  FUNCTION correctdate(kv_ INT, olddate_ DATE, enddate_ DATE) RETURN DATE IS
    --Вычисление ближайшей рабочей даты
    ddat_ DATE;
    n1_   NUMBER;
    nn_   NUMBER;
    ed_   NUMBER;
  BEGIN
    ddat_ := olddate_;
    IF olddate_ < enddate_ THEN
      ed_ := 1;
    ELSE
      ed_ := -1;
    END IF;
    WHILE 1 < 2 LOOP
      BEGIN
        SELECT kv
          INTO nn_
          FROM holiday
         WHERE kv = nvl(kv_, gl.baseval)
           AND holiday = ddat_;
        ddat_ := ddat_ + ed_;
      EXCEPTION
        WHEN no_data_found THEN
          RETURN ddat_;
      END;
    END LOOP;
  END correctdate;

  --------------------------

  FUNCTION nls0(nd_ INT, tip_ CHAR) RETURN VARCHAR2 IS
    -- Прогноз номера счета по КД заданного вида
    nls0_ VARCHAR2(15);
    acc8_ INT;
    nbs_  CHAR(4);
    tmp_  VARCHAR2(10);
  BEGIN
    BEGIN
      --А есть ли этот тип в дискрипторах ?
      SELECT substr(maskid, 1, 10)
        INTO tmp_
        FROM nlsmask
       WHERE maskid = tip_;
      nbs_ := NULL;
      IF tip_ <> 'CR9' THEN
        SELECT l.acc,
               iif_n(months_between(d.wdate, a.bdate),
                     12,
                     decode(v.custtype, 2, i.nbs, i.nbsf),
                     decode(v.custtype, 2, i.nbs, i.nbsf),
                     decode(v.custtype, 2, i.nbs2, i.nbsf2))
          INTO acc8_, nbs_
          FROM cc_deal d, cc_add a, cc_lim l, cc_vidd v, cc_aim i
         WHERE d.nd = nd_
           AND i.aim = a.aim
           AND v.vidd = d.vidd
           AND a.nd = d.nd
           AND a.adds = 0
           AND l.nd = d.nd
           AND rownum = 1;
        IF tip_ = 'SN ' THEN
          nbs_ := substr(nbs_, 1, 3) || '8';
        ELSIF tip_ = 'SL ' THEN
          nbs_ := substr(nbs_, 1, 3) || '6';
        ELSIF tip_ = 'SP ' THEN
         if NEWNBS.GET_STATE = 0 then
          nbs_ := substr(nbs_, 1, 3) || '7';
         else
          nbs_ := substr(nbs_, 1, 3) || '3';
         end if;
        ELSIF tip_ = 'SPN' THEN
         if NEWNBS.GET_STATE = 0 then
          nbs_ := substr(nbs_, 1, 3) || '9';
         else
          nbs_ := substr(nbs_, 1, 3) || '8';
         end if;
        END IF;
      END IF;
      SELECT bars.f_newnls(acc8_, tip_, nbs_) INTO nls0_ FROM dual;
    EXCEPTION
      WHEN no_data_found THEN
        nls0_ := '';
    END;
    RETURN nls0_;
  END nls0;
  ---------------

  FUNCTION cc_stop(ref_ INT) RETURN NUMBER IS
    --  Стоп-правило при превышении лимита-2 при выдаче кредита по пл.остатку
    -- Описано в операциях выдачи KK1, KK2, KK3 ...
    -- Так же блокирует выдачу при отсутствии остатка на счете дисконта 'SDI'
    -- сумма на дисконт вычиввыыаеться из доп параметра nd_txt tag='S_SDI'
    -- Проверяет налтчие остатка на счете так-же по оборотам
    -- Для случаев выдачи второго транша - с уже частично амморт-ной суммой дисконта
    -- Не контролирует лимит для операции типа 'BAK'
    l_su   NUMBER;
    l_sdi  NUMBER;
    l_nd   NUMBER;   l_ndG   NUMBER;
    l_vidd NUMBER;

  BEGIN

     --  Проверка на выдачу дисконта    14.02.2018 Sta Анализ НЕ-нул.остатка комиссии перед выдачей кредита (при наличии доп.реквизита по комиссии)
    BEGIN   -- к какому дог привязан ссудный счет, с которого происходит выдача ? И есть ли на нем доп.реквизит про комиссию
        SELECT cck_app.to_number2(t.txt), d.nd, d.ndG, d.vidd    
       INTO l_sdi, l_nd, l_ndG, l_vidd  
       FROM nd_txt t, accounts a, oper o, nd_acc n, cc_deal d
       WHERE t.tag = 'S_SDI'  AND t.nd = n.nd  AND n.acc = a.acc
         AND n.nd  = d.nd     AND d.sos < 14   AND decode(o.dk, 1, o.nlsa, o.nlsb) = a.nls    AND decode(o.dk, 1, o.kv, o.kv2) = a.kv   AND o.ref = ref_
         and a.tip = 'SS ' ;
    EXCEPTION  WHEN OTHERS THEN     l_sdi := 0;


    END;

      -- 28.05.2013 - проверку на дисконт делаем только для стандартных договоров ЮЛ, а для ФЛ - для всех
    IF l_vidd IN (1, 11, 12, 13) and l_sdi > 0 THEN
        -- 05.09.2012  ( Кто ?) select max(s.ostf-s.dos+s.kos)/100
        -- Убрал -s.dos если в этот же день сделали амортизацию дисконта другие  -- будущие транши вылетали при следуюшем условии проверки как недоплата суммы дисконта
        SELECT MAX(s.ostf + s.kos) / 100   INTO l_su   FROM accounts aa, nd_acc nn, saldoa s
        WHERE nn.nd in (l_nd, l_nDG)   AND nn.acc = aa.acc     AND aa.tip IN ('SDI', 'S36')       AND s.acc = aa.acc       AND s.fdat >= aa.daos;
        IF l_sdi > nvl(l_su, 0) THEN   erm := '8999 - Недостатні залишки по початковій комісії ';     RAISE err;    END IF;
    END IF;

    --- Проверка допустимости лимита  STA

    BEGIN
      SELECT a88d.ostx / 100
        INTO l_su
        FROM accounts a88d,
             accounts a8d,
             accounts a2d,
             accounts a2k,
             (SELECT decode(dk, 1, nlsa, nlsb) nlsa,
                     decode(dk, 1, kv, kv2) kv,
                     decode(dk, 1, nlsb, nlsa) nlsb,
                     decode(dk, 1, kv2, kv) kv2
                FROM oper
               WHERE REF = ref_) o
       WHERE a88d.acc = a8d.accc
         AND a8d.acc = a2d.accc
         AND a2d.nls = o.nlsa
         AND a2k.nls = o.nlsb
         AND a2d.kv = o.kv
         AND a2k.kv = o.kv
         AND nvl(a2k.accc, 0) <> nvl(a2d.accc, 0)
         AND a88d.ostb < a88d.ostx
         AND NOT EXISTS (SELECT 1
                FROM opldok
               WHERE tt = 'BAK'
                 AND REF = ref_);
    EXCEPTION
      WHEN no_data_found THEN
        BEGIN
          SELECT a8d.ostx / 100
            INTO l_su
            FROM accounts a8d,
                 accounts a2d,
                 accounts a2k,
                 (SELECT decode(dk, 1, nlsa, nlsb) nlsa,
                         decode(dk, 1, kv, kv2) kv,
                         decode(dk, 1, nlsb, nlsa) nlsb,
                         decode(dk, 1, kv2, kv) kv2
                    FROM oper
                   WHERE REF = ref_) o
           WHERE a8d.acc = a2d.accc
             AND a2d.nls = o.nlsa
             AND a2k.nls = o.nlsb
             AND a2d.kv = o.kv
             AND a2k.kv = o.kv
             AND nvl(a2k.accc, 0) <> nvl(a2d.accc, 0)
             AND a8d.ostb < a8d.ostx
             AND NOT EXISTS (SELECT 1
                    FROM opldok
                   WHERE tt = 'BAK'
                     AND REF = ref_);
        EXCEPTION
          WHEN no_data_found THEN
            BEGIN
              SELECT d.ostx / 100
                INTO l_su
                FROM accounts d,
                     accounts k,
                     (SELECT decode(dk, 1, nlsa, nlsb) nlsa,
                             decode(dk, 1, kv, kv2) kv,
                             decode(dk, 1, nlsb, nlsa) nlsb,
                             decode(dk, 1, kv2, kv) kv2
                        FROM oper
                       WHERE REF = ref_) o
               WHERE d.nls = o.nlsa
                 AND d.kv = o.kv
                 AND substr(d.nls, 1, 1) = '9'
                 AND k.nls = o.nlsb
                 AND k.kv = o.kv
                 AND substr(k.nls, 1, 1) = '9'
                 AND d.ostb < d.ostx
                 AND NOT EXISTS (SELECT 1
                        FROM opldok
                       WHERE tt = 'BAK'
                         AND REF = ref_);
            EXCEPTION
              WHEN no_data_found THEN
                RETURN 0;
            END;
        END;
    END;
    erm := '8999 - Перевищення загального лiмiту по КД = ' ||
           to_char(l_su, '999G999G999G999D99');
    RAISE err;
  EXCEPTION
    WHEN err THEN
      raise_application_error(- (20000 + ern), '\ ' || erm, TRUE);
    WHEN OTHERS THEN
      raise_application_error(- (20000 + ern), SQLERRM, TRUE);
  END cc_stop;

  --------------------
  FUNCTION pmt(prcperiod_ NUMBER, kolrazb_ INT, summakred_ NUMBER)
    RETURN NUMBER IS
    --       PMT(RATE_*(DAT4_-DAT3_)/365,KOL2_,-LIM2_))
    --  вычисление константы для кредита
  BEGIN
    IF kolrazb_ = 0 THEN
      RETURN - summakred_;
    ELSE
      IF prcperiod_ = 0 THEN
        RETURN - summakred_ / kolrazb_;
      ELSE
        RETURN(0 - summakred_ * power(1 + prcperiod_, kolrazb_)) * prcperiod_ /(power(1 +
                                                                                      prcperiod_,
                                                                                      kolrazb_) - 1);
      END IF;
    END IF;
  END pmt;
  ----------------------------------

  FUNCTION pmt1(nr NUMBER, nn NUMBER, npv NUMBER, nfv NUMBER) RETURN NUMBER IS
    --Calculate rent payment (Пономаренко Андрей) Fincalc.apl
    nsff NUMBER;
  BEGIN
    ----- Если число периодов = 0, то возвращаем разницу
    IF nn = 0 THEN
      RETURN nfv - npv;
    END IF;
    ----- Если ставка=0, то нет прироста значения
    IF nr = 0 THEN
      RETURN(nfv - npv) / nn;
    END IF;
    nsff := nr / (power(1 + nr, nn) - 1);
    RETURN(nfv - npv * power(1 + nr, nn)) * nsff;
  END pmt1;

  -- Возвращает остаток на день (устаревшее)
  ----------------------------
  FUNCTION ost_v(acc_ INT, fdat_ DATE) RETURN NUMBER IS
    --  Вх.остаток
    dat_ DATE;
    n1_  NUMBER;
  BEGIN
    SELECT MAX(fdat) INTO dat_ FROM fdat WHERE fdat <= fdat_;
    BEGIN
      SELECT ostf
        INTO n1_
        FROM saldoa
       WHERE acc = acc_
         AND (acc, fdat) = (SELECT acc, MAX(fdat)
                              FROM saldoa
                             WHERE acc = acc_
                               AND fdat <= dat_
                             GROUP BY acc);
    EXCEPTION
      WHEN no_data_found THEN
        n1_ := 0;
    END;
    RETURN n1_;
  END ost_v;
  ----------------

  PROCEDURE cc_lim_null(p_nd NUMBER) IS
    s_    NUMBER;
    acc8_ INT;
    dat3_ DATE;
    dat4_ DATE;
    nd0_  INT := p_nd;
    rnk_  INT;
    ss_   NUMBER;
    --наполнение CC_LIM хотя бы ДВУМЯ записями
  BEGIN
    IF p_nd <= 0 THEN
      RETURN;
    END IF;

    BEGIN
      SELECT a.acc, ad.wdate, -a.ostx, a.mdate
        INTO acc8_, dat3_, s_, dat4_
        FROM accounts a, cc_add ad, nd_acc n
       WHERE ad.nd = p_nd
         AND ad.adds = 0
         AND n.nd = ad.nd
         AND n.acc = a.acc
         AND a.tip = 'LIM';
    EXCEPTION
      WHEN no_data_found THEN
        RETURN;
    END;

    IF dat4_ IS NULL THEN
      SELECT wdate INTO dat4_ FROM cc_deal WHERE nd = p_nd;
      UPDATE accounts SET mdate = dat4_ WHERE acc = acc8_;
    END IF;
    p_cc_lim_copy(p_nd => p_nd, p_comments => 'CCK.CC_LIM_NULL');
    UPDATE cc_lim
       SET sumg = 0, sumo = 0
     WHERE nd = p_nd
       AND fdat = dat3_;
    IF SQL%ROWCOUNT = 0 THEN
      INSERT INTO cc_lim
        (nd, acc, fdat, lim2, sumo, sumg)
      VALUES
        (p_nd, acc8_, dat3_, s_, 0, 0);
    END IF;

    UPDATE cc_lim
       SET lim2 = 0
     WHERE nd = p_nd
       AND fdat = dat4_;
    IF SQL%ROWCOUNT = 0 THEN
      INSERT INTO cc_lim
        (nd, acc, fdat, lim2, sumo, sumg)
      VALUES
        (p_nd, acc8_, dat4_, 0, 0, s_);
    END IF;

  END cc_lim_null;
  ----------------

  PROCEDURE cc_lim_del(nd_ INT) IS
    --удаление "модельных" КД
  BEGIN
    --резерв
    RETURN;
  END cc_lim_del;
  ----
  PROCEDURE cc_kv(nd_ INT, kv1_ INT, kv2_ INT) IS --переустановка другой баз.валюты
  BEGIN
    raise_application_error(- (20203),
                            '\8999 - Дану опцію відключено 03.02.2016');
    -----------------------------------------------------------------------------
    UPDATE cc_deal
       SET LIMIT = gl.p_ncurval(kv2_,
                                gl.p_icurval(kv1_, LIMIT, gl.bdate),
                                gl.bdate)
     WHERE nd = nd_;
    UPDATE cc_add
       SET kv = kv2_,
           s  = gl.p_ncurval(kv2_, gl.p_icurval(kv1_, s, gl.bdate), gl.bdate)
     WHERE nd = nd_
       AND adds = 0;
    UPDATE cc_lim
         SET lim2 = gl.p_ncurval(kv2_,
                               gl.p_icurval(kv1_, lim2, gl.bdate),
                               gl.bdate),
           sumg = gl.p_ncurval(kv2_,
                               gl.p_icurval(kv1_, sumg, gl.bdate),
                               gl.bdate),
           sumo = gl.p_ncurval(kv2_,
                               gl.p_icurval(kv1_, sumo, gl.bdate),
                               gl.bdate)
     WHERE nd = nd_;
    UPDATE accounts
       SET kv   = kv2_,
              ostx = gl.p_ncurval(kv2_,
                               gl.p_icurval(kv1_, ostx, gl.bdate),
                               gl.bdate)
     WHERE nls = vkrzn(substr(gl.amfo, 1, 5), '89990' || nd_)
       AND kv = kv1_;
    cck.cc_start(nd_);
  END cc_kv;
  -------------
  -- STA

  PROCEDURE cc_analiz(ntip_ur_ INT,
                      ntip_kl_ INT,
                      ngr_     INT,
                      dat1_    DATE,
                      dat2_    DATE) IS
    -- процедура "Анализ ресурса, ставок, сроков "
    dat_  DATE;
    n1_   NUMBER; -- S    остатки
    n2_   NUMBER; -- DOS  выдано осн.долг (дебет SS)
    n3_   NUMBER; -- KOS  погашено осн.долг
    n4_   NUMBER; -- DOSN перенесено на проср (дебет SP)
    n5_   NUMBER; -- KOSN перенесено на cомнит(дебет SL)
    srok_ INT;
    id_   INT;
    otd_  INT;
  BEGIN
    --   delete from cck_analiz;
    DELETE FROM cck_an_tmp;
    COMMIT;
    id_ := nvl(id_, user_id);
    -- максим раб дата в запрошенном периоде
     SELECT nvl(MAX(fdat), gl.bdate)
      INTO dat_
      FROM fdat
     WHERE fdat <= dat2_;

    FOR k IN (SELECT substr(a.tip, 2, 1) dl,
                     a.acc,
                     a.nbs,
                     a.nls,
                     a.kv,
                     ad.aim,
                     d.nd,
                     nvl(a.mdate, gl.bdate) mdate,
                     a.daos,
                     acrn.fproc(a.acc, dat_) pr,
                     d.user_id,
                     a.tobo
                FROM accounts a,
                     nd_acc n,
                     cc_deal d,
                     cc_add ad,
                     (SELECT idu, MAX(secg) secg
                        FROM groups_staff
                       GROUP BY idu) g
               WHERE d.nd = ad.nd
                 AND (a.dazs IS NULL OR a.dazs > dat1_)
                 AND a.tip IN ('SS ', 'SL ', 'SP ')
                 AND a.nls LIKE '2%'
                 AND
                    --                  sec.fit_umask(a.sec,USER_ID)>0            AND
                    --                  a.grp=decode(nGr_, 0, a.grp, nGr_ )       AND
                     id_ = g.idu
                 AND g.secg > 0
                 AND n.acc = a.acc
                 AND n.nd = d.nd
                 AND (ntip_kl_ = 2 AND d.vidd IN (1, 2, 3) OR
                     ntip_kl_ = 3 AND d.vidd IN (11, 12, 13))
               ORDER BY d.user_id)

     LOOP
      IF ntip_ur_ = 1 AND k.user_id = id_ OR ntip_ur_ = 0 THEN
        GOTO yes_;
      END IF;

      BEGIN
        IF id_ = k.user_id THEN
          GOTO yes_;
        END IF;

        SELECT u1.otd
          INTO otd_
          FROM otd_user u1, otd_user u2
         WHERE u1.otd = u2.otd
           AND u1.userid = id_
           AND u2.userid = k.user_id
           AND rownum = 1;
        GOTO yes_;
      EXCEPTION
        WHEN no_data_found THEN
          GOTO not_;
      END;

      <<yes_>>
      n1_ := 0;
      n2_ := 0;
      n4_ := 0;
      n5_ := 0;
      n3_ := 0;
      -- остаток
      BEGIN
        SELECT ostf - dos + kos
          INTO n1_
          FROM saldoa
         WHERE acc = k.acc
           AND (acc, fdat) = (SELECT acc, MAX(fdat)
                                FROM saldoa
                               WHERE acc = k.acc
                                 AND fdat <= dat_
                               GROUP BY acc);
      EXCEPTION
        WHEN no_data_found THEN
          n1_ := 0;
      END;

      -- сумма оборотов дебетовых
      SELECT nvl(SUM(dos), 0)
        INTO n2_
        FROM saldoa
       WHERE acc = k.acc
         AND fdat >= dat1_
         AND fdat <= dat2_;

      IF k.dl = 'P' THEN
        n4_ := n2_;
        n2_ := 0;
      ELSIF k.dl = 'L' THEN
        n5_ := n2_;
        n2_ := 0;
      END IF;

      -- сумма НУЖНЫХ оборотов кредитовых
      FOR t IN (SELECT ad.tip, ok.s
                  FROM opldok ok, opldok od, accounts ad
                 WHERE ok.acc = k.acc
                   AND ok.dk = 1
                   AND ok.sos = 5
                   AND od.acc = ad.acc
                   AND od.dk = 0
                   AND od.sos = 5
                   AND ok.ref = od.ref
                   AND ok.stmt = od.stmt
                   AND ok.fdat >= dat1_
                   AND ok.fdat <= dat2_) LOOP
        IF t.tip = 'SP ' THEN
          n4_ := n4_ + t.s;
        ELSIF t.tip = 'SL ' THEN
          n5_ := n5_ + t.s;
        ELSE
          n3_ := n3_ + t.s;
        END IF;
      END LOOP;

      -- срок в мес
      IF k.mdate < k.daos THEN
        srok_ := 0;
      ELSE
        srok_ := months_between(k.mdate, k.daos);
      END IF;

      IF n1_ < 0 OR n2_ > 0 OR n3_ > 0 OR n4_ > 0 OR n5_ > 0 THEN
        INSERT INTO cck_an_tmp
          (acc,
           dl,
           kv,
           nbs,
           nls,
           pr,
           n1,
           n2,
           n3,
           srok,
           n4,
           n5,
           aim,
           userid,
           branch,
           nd)
        VALUES
          (k.acc,
           k.dl,
           k.kv,
           k.nbs,
           k.nls,
           k.pr,
           n1_,
           n2_,
           n3_,
           srok_,
           n4_,
           n5_,
           k.aim,
           k.user_id,
           nvl(k.tobo, 0),
           k.nd);
      END IF;
      <<not_>>
      NULL;
    END LOOP;

    --------------------
    --cck_analiz | здесь
    -------------|------
    --DL         | k.dl
    --NBS        | k.nbs
    --KV         | k.kv
    --S          | N1_
    --DOS        | N2_
    --KOS        | N3_
    --PR         | ср.RP
    --SROK       | cp.SROK
    --DOSN       | N4_
    --KOSN       | N5_
    /*  insert into cck_analiz (DL, NBS, KV, S, DOS, KOS, PR, SROK, DOSN, KOSN )
         select DL, NBS, KV,  sum(N1), sum(N2), sum(N3),
                decode(sum(N1), 0, 0, sum(N1*PR  )/sum(N1)),
                decode(sum(N1), 0, 0, sum(N1*SROK)/sum(N1)), sum(N4), sum(N5)
         from cck_an_tmp  group by  DL, NBS, KV
         having sum(N1)<>0 or sum(N2)<>0 or sum(N3)<>0 or sum(N4)<>0 or sum(N5)<>0;
    */
  END cc_analiz;
  -----------------------------------

  PROCEDURE cc_analiz1(bkv_ INT, dat1_ DATE, dat2_ DATE) IS
    -- процедура-1(более сложная по алгоритму ПЕТРОКОМЕРЦ) анализа КП
    dat_   DATE;
    kv_    INT;
    acra_  INT;
    cc_id_ VARCHAR2(20);
    lim_   NUMBER;
    limq_  NUMBER;
    acc8_  INT;
    accs_  INT;
    s_     NUMBER;
    sq_    NUMBER;
    iq_    NUMBER;
    sn_    NUMBER;
    snq_   NUMBER;
    vn_    NUMBER;
    vnq_   NUMBER;
    kos_   NUMBER;
    kosq_  NUMBER;
    zal_   NUMBER;
    zalq_  NUMBER;
    rez_   NUMBER;
    rezq_  NUMBER;
    ir_    NUMBER;
    irs_   NUMBER;
    porog_ INT;

  BEGIN

    DELETE FROM cck_analiz;
    DELETE FROM cck_an_tmp;
    COMMIT;

    -- максим раб дата в запрошенном периоде
     SELECT nvl(MAX(fdat), gl.bdate)
      INTO dat_
      FROM fdat
     WHERE fdat <= dat2_;

    iq_ := 0;
    FOR k IN (SELECT a.acc,
                     a.kv,
                     a.accc,
                     a.nbs,
                     c.prinsider,
                     nvl(p.s080, '1') s080,
                     a.daos,
                     b.idp,
                     b.idt,
                     c.c_reg,
                     substr(c.oe, 1, 2) || '000' oe,
                     substr(c.nmk, 1, 30) nmk,
                     a.lim
                FROM accounts a, customer c, specparam p, cck_nbs b
               WHERE (a.dazs IS NULL OR a.dazs > dat_)
                 AND a.acc = p.acc(+)
                 AND a.rnk = c.rnk
                 AND a.nbs = b.nbs
                 AND (a.pap = 1 OR
                     a.nbs = 2600 AND a.acc IN (SELECT acc FROM acc_over))
              --and a.nbs=2600
              )

     LOOP

      --deb.trace(ern, '1', k.acc || ' '|| k.nbs);

      --остаток долга  в вал долга
      BEGIN
        SELECT ostf - dos + kos
          INTO s_
          FROM saldoa
         WHERE acc = k.acc
           AND ostf - dos + kos < 0
           AND (acc, fdat) = (SELECT acc, MAX(fdat)
                                FROM saldoa
                               WHERE acc = k.acc
                                 AND fdat <= dat_
                               GROUP BY acc);

        sq_ := gl.p_icurval(k.kv, s_, dat_);
      EXCEPTION
        WHEN no_data_found THEN
          s_  := 0;
          sq_ := 0;
      END;
      iq_ := iq_ + sq_;

      --deb.trace(ern, '2', S_ );

      -- расчетные % с начала периода
      DELETE FROM acr_intn;
      acrn.p_int(k.acc, 0, dat1_, dat2_, vn_, to_number(NULL), 1);
      IF vn_ IS NOT NULL AND vn_ <> 0 THEN
        BEGIN
          SELECT SUM(osts * (ir + br)) / SUM(osts) INTO irs_ FROM acr_intn;
        EXCEPTION
          WHEN zero_divide THEN
            irs_ := 0;
        END;
        vnq_ := gl.p_icurval(k.kv, vn_, dat_);

        --deb.trace(ern, '3', VN_ );

      END IF;

      -- лимиты разные
      BEGIN
        IF k.nbs = '2600' THEN
          --овердрафты
          lim_  := k.lim;
          limq_ := gl.p_icurval(k.kv, lim_, dat_);

        ELSIF k.accc IS NOT NULL THEN

          --КП
          SELECT a.kv, c.lim2, d.cc_id, ad.accs
            INTO kv_, lim_, cc_id_, accs_
            FROM cc_lim c, accounts a, cc_deal d, cc_add ad
           WHERE d.nd = ad.nd
             AND ad.adds = 0
             AND d.nd = c.nd
             AND c.acc = k.accc
             AND a.acc = k.acc
             AND c.fdat = (SELECT MAX(fdat)
                             FROM cc_lim
                            WHERE acc = k.accc
                              AND fdat <= dat_);
          IF accs_ = k.acc THEN
            limq_ := gl.p_icurval(kv_, lim_, dat_);
          ELSE
            lim_  := 0;
            limq_ := 0;
          END IF;
        ELSE
          lim_  := 0;
          limq_ := 0;
        END IF;
      EXCEPTION
        WHEN no_data_found THEN
          lim_  := 0;
          limq_ := 0;
      END;

      --deb.trace(ern, '4', CC_ID_ );

      -- % ставка
      BEGIN
        SELECT ir
          INTO ir_
          FROM int_ratn
         WHERE id = 0
           AND acc = k.acc
           AND bdat = (SELECT MAX(bdat)
                         FROM int_ratn
                        WHERE id = 0
                          AND acc = k.acc
                          AND bdat <= dat_);
      EXCEPTION
        WHEN no_data_found THEN
          ir_ := 0;
      END;

      --deb.trace(ern, '5', IR_ );

      -- порог суммы
      BEGIN
        SELECT MIN(id) INTO porog_ FROM cck_size WHERE s >= abs(s_);
      EXCEPTION
        WHEN no_data_found THEN
          porog_ := 0;
      END;

      --deb.trace(ern, '6', POROG_ );

      --остатки на сч нач %
      acra_ := NULL;

      BEGIN
        SELECT s.ostf - s.dos + s.kos, i.acra
          INTO sn_, acra_
          FROM saldoa s, int_accn i
         WHERE i.acc = k.acc
           AND i.id = 0
           AND i.acra = s.acc
           AND (s.acc, s.fdat) = (SELECT acc, MAX(fdat)
                                    FROM saldoa
                                   WHERE acc = s.acc
                                     AND fdat <= dat_
                                   GROUP BY acc);
        snq_ := gl.p_icurval(k.kv, sn_, dat_);
      EXCEPTION
        WHEN no_data_found THEN
          sn_  := 0;
          snq_ := 0;
      END;

      --deb.trace(ern, '7', SN_ );

      -- уплаченные % (кред обороты минус внутр.переброски)
      kos_ := 0;
      IF acra_ IS NOT NULL THEN
        SELECT nvl(SUM(ok.s), 0)
          INTO kos_
          FROM opldok ok, opldok od, accounts ad
         WHERE ok.dk = 1
           AND ok.sos = 5
           AND ok.acc = acra_
           AND ok.fdat >= dat1_
           AND ok.fdat <= dat2_
           AND od.dk = 0
           AND od.sos = 5
           AND od.acc = ad.acc
           AND od.fdat >= dat1_
           AND od.fdat <= dat2_
           AND ok.ref = od.ref
           AND ok.stmt = od.stmt
           AND ok.s = od.s
           AND substr(ad.nbs, 1, 3) <> substr(k.nbs, 1, 3);

        kosq_ := gl.p_icurval(k.kv, kos_, dat_);
      ELSE
        kos_  := 0;
        kosq_ := 0;
      END IF;
      --deb.trace(ern, '8', KOS_ );

      zalq_ := rez.ca_fq_zalog(k.acc, dat_);
      zal_  := gl.p_ncurval(k.kv, zalq_, dat2_);
      rez_  := rez.ca_f_rezerv(k.acc, dat_);
      rezq_ := gl.p_icurval(k.kv, rez_, dat2_);

      --deb.trace(ern, '9', REZ_ );

      INSERT INTO cck_an_tmp
        (kv,
         nbs,
         oe,
         insider,
         dl,
         pr,
         prs,
         srok,
         tip,
         porog,
         n1,
         n2,
         n3,
         n4,
         n5,
         reg,
         accl,
         acc,
         acra,
         NAME,
         cc_id,
         zal,
         zalq,
         rez,
         rezq,
         uv)
      VALUES
        (k.kv,
         k.nbs,
         k.oe,
         k.prinsider,
         k.s080,
         ir_,
         irs_,
         k.idt,
         k.idp,
         porog_,
         lim_,
         -s_,
         -sn_,
         -vn_,
         kos_,
         k.c_reg,
         nvl(k.accc, k.acc),
         k.acc,
         acra_,
         k.nmk,
         cc_id_,
         zal_,
         zalq_,
         rez_,
         rezq_,
         sq_);

    --deb.trace(ern, '10', k.nmk );

    END LOOP;

    -- cck_an_tmp            cck_analiz
    -------------------      -------------------
    -- KV       int          KV        int
    -- NBS      CHAR(4)      NBS       CHAR(4)
    -- TIP      int          TIP       int
    -- DL       CHAR(1)      DL        CHAR(1)
    -- SROK     NUMBER       SROK      NUMBER
    -- OE       int          OE        int
    -- INSIDER  int          INSIDER   int
    -- REG      int          REG       int
    -- N1       NUMBER       DOS       NUMBER = LIM_-лимиты разные
    -- POROG    int          POROG     int
    -- N2       NUMBER       S         NUMBER = S_  -остаток долга
    --                       KOSN      NUMBER = KOL -количество
    -- PR       NUMBER       PR        NUMBER
    -- N3       NUMBER       SN        NUMBER = SN_ -остатки на сч нач %
    -- N4       NUMBER       DOSN      NUMBER = VN_ -расчетные %
    -- N5       NUMBER       KOS       NUMBER = KOS_-упл.% (кр.об.-вн.переброски)
    -- NAME     VARCHAR2(30) NAME      VARCHAR2(30)
    -- ACC      int
    -- ACRA     int
    -- CC_ID    VARCHAR2(20)
    -- ACCL     int
    --
    IF iq_ <> 0 THEN
      UPDATE cck_an_tmp SET uv = uv * 100 / iq_;
    END IF;

  END cc_analiz1;

  --
  -- Додавання ставок і інших доппараметрів КД
  --HARDCODE ПОПРАВИТИ
  --
  PROCEDURE p_after_open_deal(p_tbl_name_1 VARCHAR2 DEFAULT 'INT_RATN',
                              p_acc        int_ratn.acc%TYPE,
                              p_id         int_ratn.id%TYPE,
                              p_bdat       int_ratn.bdat%TYPE,
                              p_ir         int_ratn.ir%TYPE DEFAULT NULL,
                              p_br         int_ratn.ir%TYPE,
                              p_op         int_ratn.op%TYPE) IS
    l_nd    cc_deal.nd%TYPE;
    l_count NUMBER;
  BEGIN

    BEGIN
      SELECT t.nd INTO l_nd FROM nd_acc t WHERE t.acc = p_acc;
    EXCEPTION
      WHEN no_data_found THEN
        bars.bars_audit.info('CCK.p_after_open_deal.Не знайдено договір для рахунку p_acc =' ||
                             p_acc);
    END;
    --bars.bars_audit.info('CCK.p_after_open_deal.UPDATE.p_acc= '||p_acc||' ,p_id='||p_id||' ,p_bdat='||p_bdat||' ,p_ir='||p_ir||' ,p_br='||p_br||' ,p_op='||p_op);

    BEGIN
      SELECT COUNT(1)
        INTO l_count
        FROM int_accn t
       WHERE t.acc = p_acc
         AND t.id = 4;
    END;

    IF l_count = 0 THEN
      INSERT INTO int_accn
        (acc, id, metr, basey, freq, acrb)
      VALUES
        (p_acc,
         p_id,
         0,
         0,
         1,
         cc_o_nls('8999', p_acc, 1, l_nd, 300465, 'SD4')) log errors INTO err$_int_accn
        ('INSERT') reject LIMIT unlimited;
    END IF;

    IF p_ir = 0 OR p_ir IS NULL THEN

      DELETE FROM int_ratn
       WHERE acc = p_acc
         AND id = p_id;
      DELETE FROM int_accn
       WHERE acc = p_acc
         AND id = p_id;

    ELSE

      UPDATE int_ratn
         SET ir = p_ir
       WHERE acc = p_acc
         AND id = p_id
         AND bdat = p_bdat log errors INTO err$_int_ratn('UPDATE')
       reject LIMIT unlimited;
      IF SQL%ROWCOUNT = 0 THEN
        --bars.bars_audit.info('CCK.p_after_open_deal.INSERT.p_acc= '||p_acc||' ,p_id='||p_id||' ,p_bdat='||p_bdat||' ,p_ir='||p_ir||' ,p_br='||p_br||' ,p_op='||p_op);
        INSERT INTO int_ratn
          (acc, id, bdat, ir, br, op, idu)
        VALUES
          (p_acc,
           p_id,
           p_bdat,
           p_ir,
           p_br,
           p_op,
           sys_context('bars_global', 'user_id')) log errors INTO err$_int_ratn
          ('INSERT') reject LIMIT unlimited;
      END IF;
    END IF;

    BEGIN
      SELECT COUNT(1)
        INTO l_count
        FROM int_ratn t
       WHERE t.acc = p_acc
         AND t.id = 4;
    EXCEPTION
      WHEN no_data_found THEN
        NULL;
    END;
    -- bars.bars_audit.info('CCK.p_after_open_deal.ND= '||L_ND||' ,int_ratn count = '||l_count);
    ------

    BEGIN
      SELECT COUNT(1)
        INTO l_count
        FROM int_accn t
       WHERE t.acc = p_acc
         AND t.id = 4;
    END;
    -- bars.bars_audit.info('CCK.p_after_open_deal.ND= '||L_ND||' ,int_accn count = '||l_count);
  END p_after_open_deal;
  -----------------------------------
  PROCEDURE cc_open(nd_    IN OUT INT,
                    nrnk   INT,
                    cc_id_ VARCHAR2,
                    dat1   DATE,
                    dat4   DATE,
                    dat2   DATE,
                    dat3   DATE,
                    nkv    INT,
                    ns     NUMBER,
                    nvid   INT,
                    nisto  INT,
                    ncel   INT,
                    ms_nx  VARCHAR2,
                    nfin   INT,
                    nobs   INT,
                    saim   VARCHAR2,
                    id_    INT,
                    nls    VARCHAR2,
                    nbank  NUMBER,
                    nfreq  INT,
                    dfproc NUMBER,
                    nbasey INT,
                    dfden  INT,
                    datnp  DATE,
                    nfreqp INT,
                    nkom   NUMBER) IS
    --
    l_daynp_c NUMBER;
    ret_      INT;
    acc_      INT;
    cc_kom_   INT;
    nms_      VARCHAR2(38);

    s080_ specparam.s080%TYPE;
    ntmp_ NUMBER;
    nint_ NUMBER := 0;

    l_okpokred cc_add.okpokred%TYPE; -- ИПН получателя
    l_namkred  cc_add.namkred%TYPE; -- Наименование счета получателя
    l_naznkred cc_add.naznkred%TYPE := substr('Перерахування кредитних коштiв згiдно КД № ' ||
                                              cc_id_ || ' вiд ' ||
                                              to_char(dat1, 'dd.mm.yyyy'),
                                              1,
                                              160); -- Назначение платежа

  BEGIN

    IF nvl(nd_, 0) = 0 THEN
      SELECT bars_sqnc.get_nextval('s_cc_deal') INTO nd_ FROM dual;
    ELSE
      UPDATE cc_zay SET datw = dat1 WHERE nz = nd_;
    END IF;

    SELECT okpo, substr(nmk, 1, 38), substr(cc_id_ || '/' || nmk, 1, 38)
      INTO l_okpokred, l_namkred, nms_
      FROM customer
     WHERE nrnk = rnk;
    UPDATE customer SET crisk = nfin WHERE rnk = nrnk;
    INSERT INTO cc_deal
      (nd,
       sos,
       cc_id,
       sdate,
       wdate,
       rnk,
       vidd,
       LIMIT,
       kprolog,
       user_id,
       obs,
       sdog)
    VALUES
      (nd_, 0, cc_id_, dat1, dat4, nrnk, nvid, ns, 0, id_, nobs, ns);
    INSERT INTO cc_add
      (nd, adds, aim, s, kv, bdate, wdate, sour, freq)
    VALUES
      (nd_, 0, ncel, ns, nkv, dat2, dat3, nisto, nfreq);
    BEGIN
      SELECT COUNT(*)
        INTO l_daynp_c
        FROM nd_txt t
       WHERE t.nd = nd_
         AND t.tag = 'DAYNP';
    END;

    IF l_daynp_c = 0 THEN
      cck_app.set_nd_txt(nd_, 'DAYNP', 1);
    END IF;
    if nvid in (2, 3) then
      update cc_deal
         set ndg = nd_
       where nd = nd_
         and ndg is null;
    end if;
    -- процедура по установке платежных реквизитов по кредиту
    cck.set_pmt_instructions(p_nd       => nd_, -- реф КД
                             p_mfokred  => to_char(nbank), -- Платежные инструкции МФО
                             p_nlskred  => nls, -------//------- счет
                             p_okpokred => NULL, -- ИПН получателя
                             p_namkred  => NULL, -- Наименование счета получателя
                             p_naznkred => NULL -- Назначение платежа
                             );

    INSERT INTO nd_txt (nd, tag, txt) VALUES (nd_, 'FREQ', to_char(nfreq));
    INSERT INTO nd_txt
      (nd, tag, txt)
    VALUES
      (nd_, 'FREQP', to_char(nfreqp));

    WHILE 1 < 2 LOOP
      ntmp_ := trunc(dbms_random.value(1, 999999999));
      BEGIN
        SELECT 1 INTO ntmp_ FROM accounts WHERE nls LIKE '8999_' || ntmp_;
      EXCEPTION
        WHEN no_data_found THEN
          EXIT;
      END;
    END LOOP;

    op_reg_ex(99,
              0,
              0,
              0,
              ret_,
              nrnk,
              vkrzn(substr(gl.amfo, 1, 5), '89990' || ntmp_), -----'89990'||ND_,
              nkv,
              nms_,
              'LIM',
              id_,
              acc_,
              NULL,
              NULL,
              NULL,
              NULL,
              NULL,
              NULL,
              NULL,
              NULL,
              NULL,
              NULL,
              NULL,
              NULL,
              tobo_);
    cck.ins_acc(p_nd => nd_, p_nls => NULL, p_kv => NULL, p_acc => acc_);

    -- Проставляем явно S080
    s080_ := cc_s080(nd_);
    begin
      INSERT INTO specparam (acc, s080) VALUES (acc_, s080_);
    exception
      when DUP_VAL_ON_INDEX then
        update specparam set s080 = s080_ where acc = acc_;
    end;

    DELETE FROM int_ratn WHERE acc = acc_;
    DELETE FROM int_accn WHERE acc = acc_;
    INSERT INTO int_accn
      (acc, id, metr, basem, basey, freq, s, apl_dat, acr_dat)
    VALUES
      (acc_, 0, 0, 0, nbasey, nfreqp, dfden, datnp, gl.bdate - 1);
    INSERT INTO int_ratn
      (acc, id, bdat, ir)
    VALUES
      (acc_, 0, dat3, dfproc);

    IF nvl(nkom, 0) > 0 THEN

      BEGIN
        SELECT m.metr
          INTO cc_kom_
          FROM params p, int_metr m
         WHERE p.par = 'CC_KOM'
           AND p.val = to_char(m.metr)
           AND m.metr > 90;
        INSERT INTO int_accn
          (acc, id, metr, basey, freq, acr_dat)
        VALUES
          (acc_,
           2,
           cc_kom_,
           nbasey,
           1,
           gl.bdate - to_number(to_char(gl.bdate, 'dd')));
        INSERT INTO int_ratn
          (acc, id, bdat, ir)
        VALUES
          (acc_, 2, dat3, nkom);
      EXCEPTION
        WHEN OTHERS THEN
          NULL;
      END;
    END IF;
    INSERT INTO cc_sob
      (nd, fdat, isp, txt, otm)
    VALUES
      (nd_, gl.bdate, id_, 'Договор введен', 6);
    ntmp_ := ns * 100;
    UPDATE accounts SET pap = 1, ostx = -ntmp_, mdate = dat4 WHERE acc = acc_;
    acrn.p_int(acc_, 0, dat3, dat4 - 1, nint_, -ntmp_, 0);
    nint_ := ntmp_ + round(-nint_, 0);
    INSERT INTO cc_lim
      (nd, fdat, acc, lim2, sumg, sumo)
    VALUES
      (nd_, dat3, acc_, ntmp_, 0, 0);
    INSERT INTO cc_lim
      (nd, fdat, acc, lim2, sumg, sumo)
    VALUES
      (nd_, dat4, acc_, 0, ntmp_, nint_);

    IF saim IS NOT NULL THEN
      INSERT INTO nd_txt (nd, tag, txt) VALUES (nd_, 'AIM', saim);
    END IF;
    IF ms_nx IS NOT NULL THEN
      INSERT INTO nd_txt (nd, tag, txt) VALUES (nd_, 'MS_NX', ms_nx);
    END IF;

  END cc_open;
  --------------------------------------
  PROCEDURE cc_kor
  (
    acc_    INT
   , -- ACC сч 8999
    nd_     INT
   , -- реф КД
    nrnk_   INT
   , -- Рег № заемщика
    cc_id_  VARCHAR2
   , -- Ид КД
    datzak_ DATE
   , -- дата заключения
    datend_ DATE
   , -- дата завершениф
    datbeg_ DATE
   , -- дата начала действия
    datwid_ DATE
   , -- дата выдачи
    nkv_    INT
   , -- вал КД
    ns_     NUMBER
   , -- сумма по дог в цел. т.е. 10000.00
    nvid_   INT
   , -- вид КД
    nisto_  INT
   , -- код источника финансирования
    ncel_   INT
   , -- код цели
    ms_nx   VARCHAR2
   , -- доп.реквизит
    nfin_   INT
   , -- код фин стану
    nobs_   INT
   , -- код обс долга
    saim_   VARCHAR2
   , -- подробно о цели
    spawn_  VARCHAR2
   , -- подробно об обеспечении
    nkom_   NUMBER
   , -- % комис(был код пользователя, его заменила на gl.AUID)
    nls_    VARCHAR2
   , -- сч для пересисления
    nbank_  NUMBER
   , -- МФО для перечисления
    nfreq_  INT
   , -- периодичность погашения кредита
    dfproc_ NUMBER
   , -- % ставка
    nbasey_ INT
   , -- % база
    dfden_  INT
   , -- день погаш
    datnp_  DATE
   , -- дата начала пог
    nfreqp_ INT
  ) -- периодичность погаш %
   IS
    -- процедура обновления КД
    dat3_   DATE;
    cc_kom_ INT;
    nsos cc_Deal.sos%type;
    l_nd    cc_Deal.nd%TYPE;
  BEGIN
   
    BEGIN
      --COBUPRVNIX-113
      SELECT d.nd
        INTO l_nd
        FROM cc_Deal d
       WHERE d.vidd in (2, 3)
         AND d.nd = nd_;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        NULL;
        --Тип КД не є ЮО або не заповнений !
      WHEN TOO_MANY_ROWS THEN
        raise_application_error(g_errn,
                                g_errs || 'cc_kor -' || 'КД =' || nd_ ||
                                ', має декілька записів');
      
        CASE
          WHEN l_nd IS NOT NULL AND nvid_ = 1 THEN
            raise_application_error(g_errn,
                                    g_errs || 'cc_kor' ||
                                    'Заборонено для кредитів ЮО змінювати вид КЛ на стандартний -' ||
                                    nvid_);
          ELSE
            NULL;
        END CASE;
    END;
  
    begin
      select t.sos into nsos from cc_deal t where t.nd = nd_;
    exception
      when no_data_found then
        nsos := 0;
  end;

    UPDATE customer SET crisk = nfin_ WHERE rnk = nrnk_;
 if  nsos=0 then
    UPDATE cc_deal
       SET cc_id = cc_id_
          ,sdate = datzak_
          ,wdate = datend_
          ,vidd  = nvid_
          ,LIMIT = ns_
          ,obs   = nobs_
          ,sdog  = ns_
     WHERE nd = nd_;
    UPDATE cc_add
       SET aim     = ncel_
          ,s       = ns_
          ,kv      = nkv_
          ,bdate   = datbeg_
          ,wdate   = datwid_
          ,sour    = nisto_
          ,acckred = nls_
          ,mfokred = nbank_
          ,freq    = nfreq_
     WHERE nd = nd_
       AND adds = 0;
else
   UPDATE cc_deal
       SET cc_id = cc_id_
          ,sdate = datzak_
          ,wdate = datend_
          ,vidd  = nvid_
          ,obs   = nobs_
     WHERE nd = nd_;
    UPDATE cc_add
       SET aim     = ncel_
          ,kv      = nkv_
          ,bdate   = datbeg_
          ,wdate   = datwid_
          ,sour    = nisto_
          ,acckred = nls_
          ,mfokred = nbank_
          ,freq    = nfreq_
     WHERE nd = nd_
       AND adds = 0;
end if;
    BEGIN
      INSERT INTO nd_txt
        (nd, tag, txt)
      VALUES
        (nd_, 'FREQ', to_char(nfreq_));
    EXCEPTION
      WHEN dup_val_on_index THEN
        UPDATE nd_txt
           SET txt = to_char(nfreq_)
         WHERE nd = nd_
           AND tag = 'FREQ';
    END;

    BEGIN
      INSERT INTO nd_txt
        (nd, tag, txt)
      VALUES
        (nd_, 'FREQP', to_char(nfreqp_));
    EXCEPTION
      WHEN dup_val_on_index THEN
        UPDATE nd_txt
           SET txt = to_char(nfreqp_)
         WHERE nd = nd_
           AND tag = 'FREQP';
    END;

    UPDATE accounts
       SET kv = nkv_, ostx = -ns_ * 100, mdate = datend_
     WHERE acc = acc_;

    DELETE FROM int_ratn
     WHERE acc = acc_
       AND id = 0;
    DELETE FROM int_accn
     WHERE acc = acc_
       AND id = 0;
    INSERT INTO int_accn
      (acc, id, metr, basem, basey, freq, s, apl_dat, acr_dat)
    VALUES
      (acc_, 0, 0, 0, nbasey_, nfreqp_, dfden_, datnp_, gl.bdate - 1);
    INSERT INTO int_ratn
      (acc, id, bdat, ir)
    VALUES
      (acc_, 0, datbeg_, dfproc_);

    IF nkom_ > 0 THEN
      DELETE FROM int_ratn
       WHERE acc = acc_
         AND id = 2;
      SELECT m.metr
        INTO cc_kom_
        FROM params p, int_metr m
       WHERE p.par = 'CC_KOM'
         AND p.val = to_char(m.metr)
         AND m.metr > 90;
      UPDATE int_accn
         SET metr    = nvl(metr, cc_kom_)
            ,basey   = 0
            ,freq    = 1
            ,acr_dat = datbeg_ - to_number(to_char(datbeg_, 'dd'))
       WHERE acc = acc_
         AND id = 2;
      IF SQL%ROWCOUNT = 0 THEN
        INSERT INTO int_accn
          (acc, id, metr, basem, basey, freq, acr_dat)
        VALUES
          (acc_
          ,2
          ,cc_kom_
          ,0
          ,0
          ,1
          ,datbeg_ - to_number(to_char(datbeg_, 'dd')));
      END IF;
      BEGIN
        INSERT INTO int_ratn
          (acc, id, bdat, ir)
        VALUES
          (acc_, 2, datbeg_ - to_number(to_char(datbeg_, 'dd')), nkom_);
      EXCEPTION
        WHEN dup_val_on_index THEN
          UPDATE int_ratn
             SET ir = nkom_
           WHERE acc = acc_
             AND id = 2
             AND bdat = datbeg_ - to_number(to_char(datbeg_, 'dd'))
             AND nvl(ir, 0) <> nvl(nkom_, 0);
      END;
    ELSE
      DELETE int_ratn
       WHERE acc = acc_
         AND id = 2;
    END IF;

    INSERT INTO cc_sob
      (nd, fdat, isp, txt, otm)
    VALUES
       (nd_,
       gl.bdate,
       gl.auid,
       'Договор модифицирован',
       6);
    UPDATE nd_txt
       SET txt = saim_
     WHERE nd = nd_
       AND tag = 'AIM';
    IF SQL%ROWCOUNT = 0 THEN
      INSERT INTO nd_txt (nd, tag, txt) VALUES (nd_, 'AIM', saim_);
    END IF;
    UPDATE nd_txt
       SET txt = ms_nx
     WHERE nd = nd_
       AND tag = 'MS_NX';
    IF SQL%ROWCOUNT = 0 THEN
      INSERT INTO nd_txt (nd, tag, txt) VALUES (nd_, 'MS_NX', ms_nx);
    END IF;
    UPDATE nd_txt
       SET txt = spawn_
     WHERE nd = nd_
       AND tag = 'PAWN';
    IF SQL%ROWCOUNT = 0 THEN
      INSERT INTO nd_txt (nd, tag, txt) VALUES (nd_, 'PAWN', spawn_);
    END IF;

    SELECT nvl(MIN(fdat), datwid_) INTO dat3_ FROM cc_lim WHERE nd = nd;
    IF datwid_ > dat3_ THEN
      DELETE FROM cc_lim
       WHERE nd = nd_
         AND fdat <= datwid_;
      INSERT INTO cc_lim
        (nd, fdat, lim2, acc, sumg, sumo)
      VALUES
        (nd_, datwid_, ns_ * 100, acc_, 0, 0);
    END IF;

  END cc_kor;

  PROCEDURE cc_open_ext(p_nd         IN OUT INT, -- Реф кредитного договора (системный)
                        p_rnk        INT, -- РНК залогозаемщика
                        p_user_id    INT, -- Реф пользователя
                        p_branch     VARCHAR2, -- BRANCH (инициатор)  nd_txt.INIC
                        p_prod       VARCHAR2, -- продукт КД
                        p_cc_id      VARCHAR2, -- № КД (пользовательский)
                        p_dat1       DATE, -- Дата заключения
                        p_dat2       DATE, -- Дата начала действия
                        p_dat3       DATE, -- Дата выдачи (плановая)
                        p_dat4       DATE, -- Дата окончания КД
                        p_kv         INT, -- Код валюты
                        p_s          NUMBER, -- Сума КД  (с коп-ми)
                        p_vidd       INT, -- Вид договора (1,2,3 - ЮЛ , 11,12,13 - ФЛ)
                        p_sour       INT, -- Источник валютной выручки
                        p_aim        INT, -- Цель кредитования
                        p_ms_nx      VARCHAR2, -- Галузь (S260)       -- НЕ ИСП! ЧТО БЫ НИ ПЕРЕДАВАЛИ - БУДЕМ ВЫЧИТЫВАТЬ ИЗ CC_POTRA ВСЕ РАВНО!!!!!!
                        p_fin        INT, -- Фин стан
                        p_obs        INT, -- Обслуживание долга
                        p_ir         NUMBER, -- Процентная ставка
                        p_op         INT, -- тип операции для % ставки
                        p_br         INT, -- Базовая ставка
                        p_basey      INT, -- База начисления
                        p_dat_stp_ir DATE, -- Дата приостановления начисления процентов

                        p_type_gpk INT, -- Тип погашения (0 - индив 2- равн част 4 ануитет)
                        p_daynp    INT, -- Кор-ка выходных дней в ГПК

                        p_freq INT, -- Периодичность начисления по телу
                        p_den  INT, -- День погашения
                        p_datf DATE, -- Первая дата погашения тела

                        p_freqi INT, -- Периодичность начисления %
                        p_deni  INT, -- День погашения %
                        p_datfi DATE, -- Первая дата погашения %

                        p_rang     INT, -- Шаблон погашения
                        p_holidays INT, -- каникулы
                        p_method   INT, -- способ начисления процентов

                        p_mfokred  NUMBER, -- Платежные инструкции МФО
                        p_nlskred  VARCHAR2, --     -------//------- счет
                        p_okpokred VARCHAR2, -- OKPO получателя
                        p_namkred  VARCHAR2, -- Наименование получателя
                        p_naznkred VARCHAR2, -- назначение платежа

                        p_saim      VARCHAR2, -- цель  кредитного договора (Текст-устаревшее)
                        p_pawn      VARCHAR2, -- залог кредитного договора (Текст-устаревшее)
                        nd_external VARCHAR2 -- идентификатор внешней системы (мигрированные КД)
                        ) IS
    --
    l_rnk    INT;
    l_ret    INT;
    l_acc    INT;
    l_cc_kom INT;
    l_nms    VARCHAR2(38);
    l_s260   VARCHAR2(2);
    l_rang   INT;
    l_s      NUMBER;
    l_sos    INT; -- состояние договора
    l_new    INT; -- Признак 0 - открываемого договора 1 - корректируемого
    l_ms_nx  cc_potra.name%TYPE;

    ntmp_ NUMBER;
    ret_  INT;
    nint_ NUMBER := 0;
    l_err VARCHAR2(2000) := NULL;

    l_nls8 accounts.nls%TYPE;

  BEGIN

    IF nvl(p_nd, 0) = 0 THEN
      SELECT bars_sqnc.get_nextval('s_cc_deal') INTO p_nd FROM dual;
    ELSE
      UPDATE cc_zay SET datw = p_dat1 WHERE nz = p_nd;
    END IF;

    IF p_rnk IS NULL THEN
      l_err := l_err || 'Не обран позичальник!' || chr(13);
    END IF;
    IF p_dat1 IS NULL THEN
      l_err := l_err || 'Не введена дата укладання договору!' || chr(13);
    END IF;
    IF p_dat4 IS NULL THEN
      l_err := l_err || 'Не введена дата закінчення договору!' || chr(13);
    END IF;
    IF p_cc_id IS NULL THEN
      l_err := l_err || 'Не введений номер договору!' || chr(13);
    END IF;
    IF p_s IS NULL THEN
      l_err := l_err || 'Не введена сума договору!' || chr(13);
    END IF;
    IF p_kv IS NULL THEN
      l_err := l_err || 'Не обрана валюта договору!' || chr(13);
    END IF;
    IF p_freq IS NULL THEN
      l_err := l_err || 'Не обрана періодичність основного боргу!' ||
               chr(13);
    END IF;
    IF p_freqi IS NULL THEN
      l_err := l_err || 'Не обрана періодичність сплати відсотків!' ||
               chr(13);
    END IF;
    IF p_datf IS NULL THEN
      l_err := l_err || 'Не задана перша дата погашення!' || chr(13);
    END IF;
    IF p_vidd IS NULL THEN
      l_err := l_err || 'Не обран від договору!' || chr(13);
    END IF;
    IF p_den IS NULL THEN
      l_err := l_err || 'Не вказан день погашення!' || chr(13);
    END IF;
    IF p_sour IS NULL THEN
      l_err := l_err || 'Не обрано джерело залучення коштів!' || chr(13);
    END IF;
    IF p_fin IS NULL THEN
      l_err := l_err || 'Не обран фінансовий стан позичальника!' || chr(13);
    END IF;
    IF p_fin NOT IN (1, 2, 3, 4, 5) THEN
      l_err := l_err ||
               'Неприпустимий код фінансовий стан позичальника! = ' ||
               p_fin || chr(13);
    END IF;
    IF (p_ir IS NULL AND p_br IS NULL) OR p_basey IS NULL THEN
      l_err := l_err ||
               'Не обрана процентна ставка або база нарахування по договору!' ||
               chr(13);
    END IF;
    IF p_aim IS NULL THEN
      l_err := l_err || 'Не обрана цель кредитування!' || chr(13);
    END IF;
    IF p_rang IS NULL THEN
      l_err := l_err || 'Не обран шаблон погашення!' || chr(13);
    END IF;
    IF p_holidays IS NULL THEN
      l_err := l_err || 'Не обраний параметр "канікули" !' || chr(13);
    END IF;

    IF p_method IS NULL THEN
      l_err := l_err ||
               'Не обраний параметр "спосіб нарахування відсотків" !' ||
               chr(13);
    END IF;

    IF l_err IS NOT NULL THEN
      raise_application_error(- (20203),
                              '\8999 - КД №' || to_char(p_nd) || chr(13) ||
                              l_err,
                              TRUE);
    END IF;

    -- Перевірка кліента на изменение клиента по договору
    BEGIN
      SELECT d.rnk, d.sos, a.acc
        INTO l_rnk, l_sos, l_acc
        FROM cc_deal d, nd_acc n, accounts a
       WHERE d.nd = p_nd
         AND d.nd = n.nd
         AND n.acc = a.acc
         AND a.tip = 'LIM';
      l_new := 1;
    EXCEPTION
      WHEN no_data_found THEN
        l_new := 0;

    END;

    IF p_rnk != nvl(l_rnk, p_rnk) THEN
      raise_application_error(- (20203),
                              '\8999 - КД №' || to_char(p_nd) ||
                              ' Для діючих договорів зміна позичальника заборонена!',
                              TRUE);
    END IF;
    IF nvl(l_sos, 0) > 0 THEN
      raise_application_error(- (20203),
                              '\8999 - КД №' || to_char(p_nd) ||
                              ' Зміна договору дозволяеться тільки для нових договорів!',
                              TRUE);
    END IF;

    --найти клиента
    BEGIN
      SELECT substr(p_cc_id || '/' ||
                    decode(getglobaloption('CCK_NBU'), '1', c.nmkk, c.nmk),
                    1,
                    38),
             c.rnk
        INTO l_nms, l_rnk
        FROM customer c
       WHERE c.rnk = p_rnk;
    EXCEPTION
      WHEN no_data_found THEN
        raise_application_error(- (20203),
                                '\8999 - КД №' || to_char(p_nd) ||
                                ' Не вірно задан ідентифікатор клієнта RNK=' ||
                                to_char(p_rnk),
                                TRUE);
    END;

    UPDATE customer SET crisk = p_fin WHERE rnk = l_rnk;

    IF l_new = 0 THEN
      INSERT INTO bars.cc_deal
        (nd,
         sos,
         cc_id,
         sdate,
         wdate,
         rnk,
         vidd,
         LIMIT,
         kprolog,
         user_id,
         obs,
         prod,
         sdog,
         skarb_id,
         fin)
      VALUES
        (p_nd,
         0,
         p_cc_id,
         p_dat1,
         p_dat4,
         l_rnk,
         p_vidd,
         p_s,
         0,
         nvl(p_user_id, user_id),
         p_obs,
         p_prod,
         p_s,
         nd_external,
         p_fin);

      INSERT INTO cc_add
        (nd, adds, aim, s, kv, bdate, wdate, sour, freq)
      VALUES
        (p_nd, 0, p_aim, p_s, p_kv, p_dat2, p_dat3, p_sour, p_freq);

      INSERT INTO nd_txt
        (nd, tag, txt)
      VALUES
        (p_nd, 'FREQ', to_char(p_freq));
      INSERT INTO nd_txt
        (nd, tag, txt)
      VALUES
        (p_nd, 'FREQP', to_char(p_freqi));

      -- 31-10-2011 Sta формируем лицевой счет с учетом контрольного разряда
      l_nls8 := vkrzn(substr(gl.amfo, 1, 5), '89990' || p_nd);

      -- проверяем есть ли такой счет и переоткрываем его если есть
      BEGIN
        SELECT a.acc
          INTO l_acc
          FROM accounts a
         WHERE a.nls = l_nls8
           AND a.kv = p_kv;
        accreg.p_acc_restore(l_acc, gl.bdate);
      EXCEPTION
        WHEN no_data_found THEN
          NULL;
      END;

      op_reg_ex(99,
                0,
                0,
                0,
                ret_,
                l_rnk,
                l_nls8,
                p_kv,
                l_nms,
                'LIM',
                nvl(p_user_id, user_id),
                l_acc,
                iif_n(getglobaloption('CCK_NBU'), '1', '1', NULL, '1'),
                NULL,
                p_type_gpk,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                tobo_);
      cck.ins_acc(p_nd  => p_nd,
                  p_nls => NULL,
                  p_kv  => NULL,
                  p_acc => l_acc);

    ELSE
      UPDATE bars.cc_deal
         SET branch   = p_branch,
             cc_id    = p_cc_id,
             sdate    = p_dat1,
             wdate    = p_dat4,
             vidd     = p_vidd,
             kprolog  = 0,
             user_id  = nvl(p_user_id, user_id),
             obs      = p_obs,
             prod     = p_prod,
             LIMIT    = p_s,
             skarb_id = nd_external,
             fin      = p_fin
       WHERE nd = p_nd;

      UPDATE bars.cc_add
         SET aim   = p_aim,
             s     = p_s,
             kv    = p_kv,
             bdate = p_dat2,
             wdate = p_dat3,
             sour  = p_sour,
             freq  = p_freq
       WHERE nd = p_nd
         AND adds = 0;

    END IF;

    -- процедура по установке платежных реквизитов по кредиту
    cck.set_pmt_instructions(p_nd       => p_nd, -- реф КД
                             p_mfokred  => to_char(p_mfokred), -- Платежные инструкции МФО
                             p_nlskred  => p_nlskred, -------//------- счет
                             p_okpokred => p_okpokred, -- ИПН получателя
                             p_namkred  => p_namkred, -- Наименование счета получателя
                             p_naznkred => p_naznkred -- Назначение платежа
                             );

    cck_app.set_nd_txt(p_nd, 'FREQ', to_char(p_freq));
    cck_app.set_nd_txt(p_nd, 'FREQP', to_char(p_freqi));

    -- Инициатива
    cck_app.set_nd_txt(p_nd, 'INIC', to_char(p_branch));

    cck_app.save_ratn(p_acc     => l_acc,
                      p_id      => 0,
                      p_metr    => 0,
                      p_basey   => p_basey,
                      p_freq    => p_freqi,
                      p_stp_dat => p_dat_stp_ir,
                      p_acr_dat => p_dat1,
                      p_apl_dat => p_datf,
                      p_tt      => '%%1',
                      p_acra    => NULL,
                      p_acrb    => NULL,
                      p_s       => p_den,
                      p_io      => NULL,
                      p_bdat    => p_dat3,
                      p_ir      => p_ir,
                      p_br      => p_br,
                      p_op      => p_op,
                      p_type    => 0,
                      p_del     => 1,
                      p_idu     => nvl(p_user_id, user_id),
                      p_idr     => NULL);

    l_s := p_s * 100;

    UPDATE accounts
       SET pap = 1, ostx = -l_s, mdate = p_dat4
     WHERE acc = l_acc;

    -- Строим минимальный ГПК
    acrn.p_int(l_acc, 0, p_dat3, p_dat4 - 1, nint_, -l_s, 0);
    nint_ := l_s + round(-nint_, 0);
    BEGIN
      -- FIRST
      INSERT INTO cc_lim
        (nd, fdat, acc, lim2, sumg, sumo)
      VALUES
        (p_nd, p_dat3, l_acc, l_s, 0, 0);
    EXCEPTION
      WHEN dup_val_on_index THEN

        UPDATE cc_lim
           SET lim2 = l_s, sumg = 0, sumo = 0
         WHERE nd = p_nd
           AND acc = l_acc
           AND fdat = p_dat3;

    END;

    BEGIN
      -- LAST
      INSERT INTO cc_lim
        (nd, fdat, acc, lim2, sumg, sumo)
      VALUES
        (p_nd, p_dat4, l_acc, 0, l_s, nint_);
    EXCEPTION
      WHEN dup_val_on_index THEN
        UPDATE cc_lim
           SET lim2 = 0, sumg = l_s, sumo = nint_
         WHERE nd = p_nd
           AND acc = l_acc
           AND fdat = p_dat4;

    END;

    -----------------------

    cck_app.set_nd_txt(p_nd, 'DAYNP', nvl(p_daynp, cc_daynp));

    -- День и первая дата погашения %
    IF p_deni IS NOT NULL AND p_datfi IS NOT NULL THEN
      cck_app.set_nd_txt(p_nd, 'DAYSN', to_char(p_deni));
      cck_app.set_nd_txt(p_nd, 'DATSN', to_char(p_datfi, 'dd/mm/yyyy'));
    END IF;

    -- Каникулы 0-Да /Период погашения 0 - День
    cck_app.set_nd_txt(p_nd,
                       'FLAGS',
                       coalesce(to_char(p_holidays),
                                getglobaloption('CC_GPK'),
                                '0') || coalesce(to_char(p_method),
                                                 getglobaloption('ASG-SN'),
                                                 '1'));

    -- Шаблон авторазбора (первый. который не пустой)
    l_rang := coalesce(p_rang, to_number(getglobaloption('CC_RANG')), 1);
    cck_app.set_nd_txt(p_nd, 'CCRNG', l_rang);

    -- S260/ Галузь
    SELECT s260, NAME
      INTO l_s260, l_ms_nx
      FROM cc_potra
     WHERE id = substr(p_prod, 1, 6);

    cck_app.set_nd_txt(p_nd, 'S260', l_s260);
    cck_app.set_nd_txt(p_nd, 'MS_NX', l_ms_nx);

    -- Подробно о Цели
    IF p_saim IS NOT NULL THEN
      cck_app.set_nd_txt(p_nd, 'AIM', p_saim);
    END IF;

    -- Подробно о залоге
    IF p_pawn IS NOT NULL THEN
      cck_app.set_nd_txt(p_nd, 'PAWN', p_pawn);
    END IF;

    cc_sob(p_nd, gl.bdate, NULL, NULL, NULL, NULL, NULL, 0);

  END cc_open_ext;

  PROCEDURE cc_open_com(p_nd       INT, -- Реф кредитного договора (системный)
                        p_sdi      NUMBER, -- Сумма дисконта,
                        p_f        NUMBER, -- Сумма первоначальной комиссии,
                        p_f_freq   INT, -- периодичность уплаты перв комиссии
                        p_kom      INT, -- Тип комиссии
                        p_kom_ir   NUMBER, -- % ставка ежем-ной комис или сума в завис от метода
                        p_kom_freq INT, --  периодичность ежемесячной комиссии
                        p_kom_datf DATE, -- Дата первого начисления
                        p_kom_date DATE, -- Дата окончания начисления
                        p_kom_kv   INT, -- Вал.сч.для деб-кой зад-ти (3578) за ежем-ную ком НЕИСПОЛЬЗУЕТСЯ
                        p_cr9_kv   INT, -- Вал.сч.для деб-кой зад-ти (3578) за неисп лимит
                        p_cr9_ir   INT, -- % ставка за неисп лимит
                        p_cr9_i    INT, -- % 0- возобн , 1- не возобн-мая Кред-ная линия
                        p_sn8_ir   INT, -- % ставка пени
                        p_sn8_kv   INT, -- % валюта пени
                        p_sk4_ir   INT -- % ставка за досрочное погашение
                        ) IS

    l_sos   INT; -- состояние КД
    l_col   INT; -- кол-во найденых строк
    l_acc8  INT; -- счет 8999
    l_dat3  DATE; -- дата выдачи
    l_basey INT;
  BEGIN

    SELECT MAX(d.sos), MAX(a.acc), MAX(ca.wdate)
      INTO l_sos, l_acc8, l_dat3
      FROM cc_deal d, nd_acc n, accounts a, cc_add ca
     WHERE d.nd = p_nd
       AND d.nd = n.nd
       AND n.acc = a.acc
       AND a.tip = 'LIM'
       AND d.nd = ca.nd
       AND ca.adds = 0;

    BEGIN
      SELECT basey
        INTO l_basey
        FROM int_accn
       WHERE id = 0
         AND acc = l_acc8;
    EXCEPTION
      WHEN no_data_found THEN
        l_basey := 0;
    END;

    IF l_sos IS NULL THEN
      raise_application_error(- (20203),
                              '\8999 - КД №' || to_char(p_nd) ||
                              ' не існує!',
                              TRUE);
    END IF;

    IF l_sos >= 14 THEN
      raise_application_error(- (20203),
                              '\8999 - КД №' || to_char(p_nd) || ' закрит!',
                              TRUE);
    END IF;

    -- Дисконт
    cck_app.set_nd_txt(p_nd,
                       'S_SDI',
                       to_char(p_sdi,
                               '999999999D99',
                               'NLS_NUMERIC_CHARACTERS = '',.'''));

    -- Ежем комиссия
    cck_app.save_ratn(p_acc   => l_acc8,
                      p_id    => 2,
                      p_metr  => p_kom,
                      p_basey => l_basey,
                      --------------------p_BASEY  => 0,
                      p_freq    => nvl(p_kom_freq, 1),
                      p_stp_dat => p_kom_date,
                      p_acr_dat => nvl(p_kom_datf,
                                       l_dat3 -
                                       to_number(to_char(l_dat3, 'dd'))),
                      p_apl_dat => NULL,
                      p_tt      => '%%1',
                      p_acra    => NULL,
                      p_acrb    => NULL,
                      p_s       => 0,
                      p_io      => NULL,
                      p_bdat    => nvl(p_kom_datf,
                                       l_dat3 -
                                       to_number(to_char(l_dat3, 'dd'))),
                      p_ir      => p_kom_ir,
                      p_br      => NULL,
                      p_op      => NULL,
                      p_type    => 1,
                      p_del     => 1,
                      p_idu     => NULL,
                      p_idr     => NULL);

    -- Валюта 3578 для неиспол-го лимита
    cck_app.set_nd_txt(p_nd, 'V_CR9', to_char(p_cr9_kv));

    -- % ставка за неиспользованный лимит
    cck_app.set_nd_txt(p_nd,
                       'R_CR9',
                       to_char(p_cr9_ir,
                               '999999999D99',
                               'NLS_NUMERIC_CHARACTERS = '',.'''));

    -- Пеня
    cck_app.set_nd_txt(p_nd,
                       'SN8_R',
                       to_char(p_sn8_ir,
                               '999999999D99',
                               'NLS_NUMERIC_CHARACTERS = '',.'''));

    -- Ежем комиссия
    IF p_sk4_ir IS NOT NULL THEN

      UPDATE int_accn
         SET metr = 0, basey = 0, freq = 1
       WHERE acc = l_acc8
         AND id = 4
      RETURNING COUNT(acc) INTO l_col;

      IF l_col = 0 THEN
        INSERT INTO int_accn
          (acc, id, metr, basey, freq, acr_dat)
        VALUES
          (l_acc8, 4, 0, l_basey, 1, gl.bdate - 1);
      END IF;

      DELETE FROM int_ratn
       WHERE acc = l_acc8
         AND id = 2
         AND bdat != l_dat3;
      UPDATE int_ratn
         SET ir = p_kom_ir
       WHERE acc = l_acc8
         AND id = 4
         AND bdat = l_dat3
      RETURNING COUNT(acc) INTO l_col;
      IF l_col = 0 THEN
        INSERT INTO int_ratn
          (acc, id, ir, bdat)
        VALUES
          (l_acc8, 4, p_sk4_ir, l_dat3);
      END IF;
    ELSE
      DELETE FROM int_ratn
       WHERE acc = l_acc8
         AND id = 4;
      DELETE FROM int_accn
       WHERE acc = l_acc8
         AND id = 4;
    END IF;

  END;

  --------------------------------------

  /*
   Регистрация событий КП клиента и системы
    p_nd  - реф КД
    fdat  - дата наступления события
     id,  - порядковый номер события (для новых пусто)
    isp,  - создатель                (для новых пусто)
    txt,  - текстовое сообщение      (для типизированныз можно пусто)
    otm,  - отметка о состоянии КД   (по умолчанию на контроль)
    freq, - периодичность            (без периодичности)
    psys  - тип события
             null , 0        - безтиповые события
             отрицательные   - события системы
             положительные   - события пользователей
  */

  PROCEDURE cc_sob(p_nd   INT,
                   p_fdat DATE,
                   p_id   INT,
                   p_isp  INT,
                   p_txt  VARCHAR2,
                   p_otm  INT,
                   p_freq INT,
                   p_psys INT) IS

    l_txt VARCHAR2(4000);

  BEGIN

    IF p_nd IS NULL THEN
      RETURN;
    END IF;

    IF p_txt IS NULL AND p_psys IS NOT NULL AND p_id IS NULL THEN
      SELECT MAX(txt) INTO l_txt FROM cc_sob_txt WHERE id = p_psys;
    END IF;

    IF p_txt IS NULL AND l_txt IS NULL AND p_psys IS NULL AND p_id IS NULL THEN
      RETURN;
    END IF;

    IF p_id IS NULL THEN

      INSERT INTO cc_sob
        (nd, fdat, id, isp, txt, otm, freq, psys)
      VALUES
        (p_nd,
         trunc(p_fdat),
         p_id,
         p_isp,
         nvl(p_txt, l_txt),
         p_otm,
         p_freq,
         p_psys);

    ELSE
      UPDATE cc_sob
         SET fdat = trunc(p_fdat),
             isp  = nvl(p_isp, isp),
             txt  = coalesce(p_txt, txt, l_txt),

             otm  = nvl(p_otm, otm),
             freq = nvl(p_freq, freq),
             psys = nvl(p_psys, psys)
       WHERE nd = p_nd
         AND id = p_id;
    END IF;
  END;

  --------------------------------------
  -- процедура открытия счетов по КД
  PROCEDURE cc_op_nls(nd_     INT,
                      kv_     INT,
                      nls_    VARCHAR2,
                      tip_prt VARCHAR2,
                      isp_    INT,
                      grp_    INT,
                      p080_   CHAR,
                      mda_    DATE,
                      acc_    OUT INT) IS

    aa accounts%ROWTYPE;

    rnk_   INT;
    sour_  INT;
    sdatl_ cc_prol.fdat%TYPE;
    mdate_ cc_deal.wdate%TYPE;
    prod_  cc_deal.prod%TYPE;
    tt_    CHAR(3) := '%%1';
    aim_   INT;
    nms_   VARCHAR2(70);
    tip_   CHAR(3);
    prt_   VARCHAR2(10);
    vidd_  INT;
    l_acc8 INT; -- счет LIM (8999)
    l_accc INT;
    blkd_  INT;

    kvl_       INT;
    fin_       INT;
    obs_       INT;
    ret_       INT;
    nbs_       accounts.nbs%TYPE;
    acc_ss     INT;
    nbs_ss     CHAR(4);
    acra_      INT;
    acrb_      INT;
    count_rat_ INT;
    rat_       NUMBER;
    rtobo_     VARCHAR2(12); -- На кого регистрируем если CC_TOBO_= 1 в ини файле
    cc_kom_    VARCHAR2(3) := '92';
    r_cr9      NUMBER; -- процентная ставка за неиспользованный лимит на счете 9129
    v_cr9      INT; -- код валюты для начисления комиссии за неиспользованный лимит 9129
    sn8_r      NUMBER; -- индивидуальная ставка пени
    l_aim      NUMBER;
    l_basey    int_accn.basey%TYPE;
    l_basem    int_accn.basem%TYPE;
    l_count    INT;
  BEGIN

    tip_ := substr(tip_prt, 1, 3);
    prt_ := substr(tip_prt, 4, 3);
    nbs_ := substr(nls_, 1, 4);
    IF nvl(kv_, 0) = 0 THEN
      raise_application_error(- (20203),
                              '\8999 - Для рахунку ' || nls_ ||
                              ' не вказана валюта',
                              TRUE);
    END IF;

    -- посмотрим, есть ли у нас иная цель на даный момент
    BEGIN
      SELECT to_number(txt)
        INTO l_aim
        FROM nd_txt
       WHERE nd = nd_
         AND tag = 'CC_AE';
    EXCEPTION
      WHEN no_data_found THEN
        l_aim := NULL;
    END;

    -- COBUSUPABS-4011 :по замовченню формувати назву рахунку згідно наступного шаблону: <номер угоди>< назва клієнта>
    BEGIN
      ----найти клиента , договор, источник финансирования
      SELECT d.rnk,
             a.sour,
             d.prod,
             d.wdate,
             a.aim,
             d.vidd,
             l.acc,
             c.crisk,
             d.obs,
             a.kv,
             decode(tip_, 'SS ', iif_n(d.sos, 10, 99, 0, 0), 0),
             nvl((SELECT MAX(fdat)
                   FROM cc_prol pp
                  WHERE pp.nd = d.nd
                    AND (txt LIKE '%кред%' OR txt IS NULL)),
                 d.sdate),
             substr(TRIM(d.cc_id) || ' ' || TRIM(c.nmk), 1, 70)
        INTO rnk_,
             sour_,
             prod_,
             mdate_,
             aim_,
             vidd_,
             l_acc8,
             fin_,
             obs_,
             kvl_,
             blkd_,
             sdatl_,
             nms_
        FROM cc_deal d, cc_add a, customer c, cc_lim l, params p, cc_aim ca
       WHERE p.par = 'KD_NMS'
         AND rownum = 1
         AND d.rnk = c.rnk
         AND a.nd = d.nd
         AND a.adds = 0
         AND nvl(l_aim, a.aim) = ca.aim
         AND d.nd = nd_
         AND l.nd = nd_;
      /*
       l_baseM = 1 для строгого Ануитета : при этом для SS baseY =2,    для SP baseY =0
       l_baseM НЕ= 1  (обычный способ обслуживания КД):   при этом для SS и SP baseY  берем из карточки 8999
      */
      SELECT decode(basem, 1, 2, basey), nvl(basem, 0)
        INTO l_basey, l_basem
        FROM int_accn
       WHERE acc = l_acc8
         AND id = 0;
    EXCEPTION
      WHEN no_data_found THEN
        RETURN;
    END;

    --есть ли уже этот счет и зарегистрирован ли он ?
    BEGIN
      SELECT *
        INTO aa
        FROM accounts
       WHERE kv = kv_
         AND nls = nls_;
      /*IF aa.nbs LIKE '22%' OR aa.nbs LIKE '20%' THEN -- Логика непонятная
        BEGIN
          SELECT acc INTO aa.acc FROM nd_acc WHERE nd = nd_;
        EXCEPTION
          WHEN no_data_found THEN
            raise_application_error(-20203,
                                    '\ Рах' || aa.nls || '*' || aa.tip ||
                                    ' уже існує !');
        END;
      END IF;*/

      acc_   := aa.acc;
      l_accc := aa.accc;

      IF l_accc IS NOT NULL AND l_accc != l_acc8 AND tip_ <> 'SD ' THEN
        -- это касалось только тела    / 18.04.2016
        raise_application_error(- (20000 + ern),
                                '\8999 ' || 'Рахунок боргу ' || nls_ ||
                                'не може бути  закріплен за декількома КД.',
                                TRUE);
      END IF;

      cck.ins_acc(p_nd => nd_, p_nls => NULL, p_kv => NULL, p_acc => acc_);

      IF (nls_ LIKE '20%' OR nls_ LIKE '22%') THEN
        -- это касается всех счетов КД \
        SELECT COUNT(*) INTO l_count FROM nd_acc WHERE acc = acc_;
        IF l_count > 1 THEN
          raise_application_error(- (20000 + ern),
                                  '\8999 ' || 'Рахунок боргу ' || nls_ ||
                                  'не може бути  закріплен за декількома КД.',
                                  TRUE);
        END IF;
      END IF;
      IF tip_ = 'SD ' THEN
        FOR k IN (SELECT a.acc
                    FROM nd_acc n, int_accn i, accounts a
                   WHERE a.acc = n.acc
                     AND a.acc = i.acc(+)
                     AND i.id(+) = 0
                     AND a.tip IN ('SS ', 'SP ', 'SL ')
                     AND a.dazs IS NULL
                     AND (i.acrb IS NULL OR i.tt IS NULL)
                     AND n.nd = nd_) LOOP
          UPDATE int_accn
             SET acrb = acc_
           WHERE acc = k.acc
             AND id = 0;
          IF SQL%ROWCOUNT = 0 THEN
            INSERT INTO int_accn
              (acc, id, metr, basem, basey, freq, acrb, acr_dat)
              SELECT k.acc, 0, 0, 0, basey, 1, acc_, gl.bdate - 1
                FROM int_accn
               WHERE acc = l_acc8
                 AND id = 0;
          END IF;
        END LOOP;
      END IF;
      IF tip_ IN ('SD ', 'SD8') THEN
        RETURN;
      END IF;
    EXCEPTION
      WHEN no_data_found THEN
        NULL;
    END;
    cc_kom_ := '92';
    rtobo_  := tobo_; --Код ТОБО на счета
    IF cc_tobo_ = '1' THEN
      BEGIN
        SELECT t.tobo
          INTO rtobo_
          FROM tobo t, nd_txt i
         WHERE i.nd = nd_
           AND i.tag = 'INIC'
           AND i.txt || ' ' LIKE t.tobo || ' %';
      EXCEPTION
        WHEN no_data_found THEN
          rtobo_ := tobo_;
      END;
    END IF;

    IF acc_ IS NULL THEN
      IF tip_ IN ('SK0', 'SK9') THEN
        BEGIN
          SELECT val INTO cc_kom_ FROM params WHERE par = 'CC_KOM';
        EXCEPTION
          WHEN no_data_found THEN
            cc_kom_ := NULL;
        END;
      END IF;
      op_reg_ex(1,
                nd_,
                0,
                grp_,
                ret_,
                rnk_,
                nls_,
                iif_n(cc_kom_, '91', kv_, gl.baseval, kv_),
                nms_,
                tip_,
                isp_,
                acc_,
                '1',
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                blkd_,
                NULL,
                NULL,
                NULL,
                prt_,
                rtobo_,
                NULL);
      -- группа доступа и дата окончания для новых
      UPDATE accounts SET mdate = nvl(mda_, mdate_) WHERE acc = acc_;
    ELSE
      -- группа доступа и дата окончания для старых ( если группа и юзер пустые - оставляем то, что было)
      UPDATE accounts
         SET tip    = tip_,
             grp    = nvl(grp_, grp),
             mdate  = nvl(mda_, mdate_),
             isp    = nvl(isp_, isp),
             nlsalt = prt_
       WHERE acc = acc_;
      --sec.addAgrp(ACC_,GRP_);
    END IF;

    IF tip_ = 'SS ' THEN
      --установить гр доступа для 8999 и ТОБО такую же, как и для SS
      UPDATE accounts SET grp = grp_ WHERE acc = l_acc8;
      UPDATE accounts SET tobo = rtobo_ WHERE acc = l_acc8;
      IF kv_ = kvl_ THEN
        UPDATE cc_add
           SET accs = acc_
         WHERE nd = nd_
           AND adds = 0;
      END IF;

    END IF;

    -- счет SS
    IF tip_ = 'SS ' THEN
      acc_ss := acc_;
      nbs_ss := nbs_;
    ELSE
      BEGIN
        SELECT acc, nbs
          INTO acc_ss, nbs_ss
          FROM accounts
         WHERE acc = (SELECT MIN(a.acc)
                        FROM accounts a, nd_acc n
                       WHERE a.kv = kv_
                         AND a.tip = 'SS '
                         AND a.acc = n.acc
                         AND n.nd = nd_
                         AND a.nls LIKE substr(nls_, 1, 3) || '%'
                         AND a.dazs IS NULL);
      EXCEPTION
        WHEN no_data_found THEN
          acc_ss := NULL;
          nbs_ss := NULL;
      END;
    END IF;

    IF tip_ = 'SG ' THEN
      /* счет ГАШЕНИЯ и зачем это ? */
       UPDATE cc_add SET accp = acc_   WHERE nd = nd_   AND adds = 0;
      begin  Insert into nd_acc ( nd, acc)   
             select d.nd, acc_  from cc_deal d, nd_acc n, accounts a   where d.ndg = nd_ and d.nd <> d.ndg and d.nd = n.nd and n.acc = a.acc and a.kv = kv_ and a.tip ='LIM' ;
      exception when others then   if SQLCODE = - 00001 then null;   else raise; end if; --ORA-00001: unique constraint 
      end;
    END IF;

    -- Заполнение спецпараметров
    -- заміняємо на новий механізм
    pul.PUT('MODULE', 'CCK');
    pul.PUT('ND', nd_);

    accreg.set_default_sparams(p_acc => acc_);
    /*bars.cck_specparam(acc_,
                       nls_,
                       kv_,
                       tip_,
                       sour_,
                       p080_,
                       sdatl_,
                       nvl(mda_, mdate_),
                       vidd_,
    nd_);*/

    -- привязать к залогам
    IF tip_ IN ('SS ', 'SL ', 'SP ', 'CR9', 'SN ', 'SNO', 'SPN') THEN
      INSERT INTO cc_accp
        (accs, acc, nd)
        SELECT DISTINCT acc_, z.acc, nd_
          FROM cc_accp z, nd_acc n, accounts az, accounts ss
         WHERE z.accs <> acc_
           AND z.accs = n.acc
           AND n.nd = nd_
           AND z.acc = az.acc
           AND az.dazs IS NULL
           AND z.accs = ss.acc
           AND ss.dazs IS NULL
           AND (acc_, z.acc) NOT IN (SELECT accs, acc FROM cc_accp);
    END IF;

    -- Консолид.Лимит
    IF tip_ IN ('SS ', 'SL ', 'SP ') THEN
      UPDATE accounts SET accc = l_acc8 WHERE acc = acc_;
      cck.cc_start(nd_);
    END IF;

    -- ССУДНЫЙ СЧЕТ
    IF tip_ = 'SS ' THEN
      UPDATE cc_add
         SET accs = acc_
       WHERE nd = nd_
         AND adds = 0;

      -- проц.базу берем из 8999
      acra_ := cc_o_nls_ext(nbs_,
                            rnk_,
                            sour_,
                            nd_,
                            kv_,
                            tip_,
                            'SN ',
                            prod_,
                            tt_);
      acrb_ := cc_o_nls_ext(nbs_,
                            rnk_,
                            sour_,
                            nd_,
                            kv_,
                            tip_,
                            'SD0',
                            prod_,
                            tt_);

      UPDATE int_accn
         SET basey = l_basey,
             basem = l_basem,
             tt    = nvl(tt, tt_),
             acra  = nvl(acra, acra_),
             acrb  = nvl(acrb, acrb_)
       WHERE id = 0
         AND acc = acc_;

      IF SQL%ROWCOUNT = 0 THEN
        INSERT INTO int_accn
          (acc, id, metr, basem, basey, freq, acra, acrb, tt, acr_dat)
        VALUES
          (acc_,
           0,
           0,
           l_basem,
           l_basey,
           1,
           acra_,
           acrb_,
           tt_,
           gl.bdate - 1);
        -- проц.ставку берем из доп.парам м/вал.договора
        BEGIN
          SELECT to_number(txt)
            INTO rat_
            FROM nd_txt
           WHERE nd = nd_
             AND tag = 'P' || kv_;
        EXCEPTION
          WHEN no_data_found THEN
            rat_ := NULL;
        END;
        IF rat_ IS NULL THEN
          -------- проц.ставку берем из счета LIM, Если несколько ставок переносим все
          FOR x IN (SELECT *
                      FROM int_ratn
                     WHERE acc = l_acc8
                       AND id = 0) LOOP
            INSERT INTO int_ratn
              (acc, id, bdat, ir)
            VALUES
              (acc_, 0, x.bdat, x.ir);
          END LOOP;
          /*insert into int_ratn (ACC,ID,BDAT,IR)
          select ACC_,0,gl.bdate,IR from int_ratn
          where  acc = l_acc8 and id = 0
            and  bdat = (select max(bdat) from int_ratn  where id=0 and acc=l_ACC8 ) ;*/
        ELSE
          ---------- проц.ставку берем из доп.парам м/вал.договора
          INSERT INTO int_ratn
            (acc, id, bdat, ir)
          VALUES
            (acc_, 0, gl.bdate, rat_);
        END IF;
      END IF;
    END IF;

    -- СЧЕТ ПРОСРОЧКИ осн.долга
    IF tip_ IN ('SP ') THEN
      -- проц.карточку и проц.ставку берем из проц.карточки счета SS
      acra_ := cc_o_nls_ext(nbs_,
                            rnk_,
                            sour_,
                            nd_,
                            kv_,
                            tip_,
                            'SN ',
                            prod_,
                            tt_);
      acrb_ := cc_o_nls_ext(nbs_,
                            rnk_,
                            sour_,
                            nd_,
                            kv_,
                            tip_,
                            'SD0',
                            prod_,
                            tt_);

      UPDATE int_accn
         SET basey = decode(l_basem, 1, 0, basey),
             acra  = decode(acra, NULL, acra_, acra),
             acrb  = decode(acrb, NULL, acrb_, acrb),
             tt    = tt_
       WHERE id = 0
         AND acc = acc_;

      IF SQL%ROWCOUNT = 0 THEN
        INSERT INTO int_accn
          (acc,
           id,
           metr,
           basem,
           basey,
           freq,
           stp_dat,
           acr_dat,
           apl_dat,
           tt,
           acra,
           acrb,
           s,
           ttb,
           kvb,
           nlsb,
           mfob,
           namb,
           nazn)
          SELECT acc_,
                 0,
                 metr,
                 0,
                 decode(l_basem, 1, 0, basey),
                 freq,
                 stp_dat,
                 acr_dat,
                 apl_dat,
                 nvl(tt, tt_),
                 nvl(acra, acra_),
                 nvl(acrb, acrb_),
                 s,
                 ttb,
                 kvb,
                 nlsb,
                 mfob,
                 namb,
                 nazn
            FROM int_accn
           WHERE id = 0
             AND acc = acc_ss;
      END IF;
      INSERT INTO int_ratn
        (acc, id, bdat, ir, br, op)
        SELECT acc_, 0, bdat, ir, br, op
          FROM int_ratn
         WHERE acc = acc_ss
           AND id = 0
           AND NOT EXISTS (SELECT 1
                  FROM int_ratn
                 WHERE acc = acc_
                   AND id = 0);
    END IF;

    IF vidd_ IN (2, 3, 12, 13) THEN
      -- АВТОЗАПОЛНЕНИЕ карточки ДИСКОНТА
      IF tip_ IN ('SDI', 'S36') THEN
        acra_ := acc_;
        acrb_ := cc_o_nls_ext(nbs_,
                              rnk_,
                              sour_,
                              nd_,
                              kv_,
                              tip_,
                              'SD0',
                              prod_,
                              tt_);
        UPDATE int_accn
           SET basey = 0,
               basem = 0,
               metr  = 4,
               tt    = nvl(tt, tt_),
               acra  = nvl(acra, acra_),
               acrb  = nvl(acrb, acrb_)
         WHERE id = 1
           AND acc = acc_;
        IF SQL%ROWCOUNT = 0 THEN
          INSERT INTO int_accn
            (acc, id, metr, basem, basey, freq, acra, acrb, tt, acr_dat)
          VALUES
            (acc_, 1, 4, 0, 0, 1, acra_, acrb_, tt_, gl.bdate - 1);
        END IF;
      END IF;
    END IF;

    -- Заполнение проц карточки за неиспользованный лимит
    --TO_number (translate(:NEW.OSTC, ',','. '),'99999999999D99','NLS_NUMERIC_CHARACTERS = ''. ''')
    IF tip_ IN ('CR9') THEN
      SELECT (SELECT to_number(translate(txt, ',', '. '),
                               '99999999999D99',
                               'NLS_NUMERIC_CHARACTERS = ''. ''')
                FROM nd_txt
               WHERE nd = nd_
                 AND tag = 'R_CR9'),
             (SELECT to_number(translate(txt, ',', '. '),
                               '99999999999D99',
                               'NLS_NUMERIC_CHARACTERS = ''. ''')
                FROM nd_txt
               WHERE nd = nd_
                 AND tag = 'V_CR9')
        INTO r_cr9, v_cr9
        FROM dual;

      IF r_cr9 IS NOT NULL THEN
        --  % карточка

        acra_ := cc_o_nls_ext(nbs_,
                              rnk_,
                              sour_,
                              nd_,
                              nvl(v_cr9, kv_),
                              tip_,
                              'SK0',
                              prod_,
                              tt_);
        acrb_ := cc_o_nls_ext(nbs_,
                              rnk_,
                              sour_,
                              nd_,
                              nvl(v_cr9, kv_),
                              tip_,
                              'SD ',
                              prod_,
                              tt_);

        UPDATE int_accn
           SET acra = nvl(acra, acra_),
               acrb = nvl(acrb, acrb_),
               tt   = nvl(tt, tt_)
         WHERE acc = acc_
           AND id = 0;

        IF SQL%ROWCOUNT = 0 THEN
          INSERT INTO int_accn
            (acc, id, metr, basem, basey, freq, tt, acra, acrb, acr_dat)
            SELECT acc_,
                   0,
                   c.metr,
                   c.basem,
                   c.basey,
                   1,
                   c.tt,
                   acra_,
                   acrb_,
                   acr_dat
              FROM int_accn c
             WHERE c.id = 0
               AND c.acc = l_acc8;
          -- Устанавливаем процент
          INSERT INTO int_ratn
            (acc, id, bdat, ir)
          VALUES
            (acc_, 0, gl.bdate, r_cr9);
        ELSE
          BEGIN
            INSERT INTO int_ratn
              (acc, id, bdat, ir)
              (SELECT acc_, 0, gl.bdate, r_cr9
                 FROM dual
                WHERE 0 = (SELECT COUNT(*)
                             FROM int_ratn
                            WHERE acc = acc_
                              AND id = 0
                              AND (br IS NOT NULL OR ir IS NOT NULL)));
          EXCEPTION
            WHEN dup_val_on_index THEN
              UPDATE int_ratn
                 SET ir = r_cr9
               WHERE acc = acc_
                 AND id = 0
                 AND bdat = gl.bdate;
          END;

        END IF;
      END IF;
    END IF;
    -- Счет нач комиссии
    IF tip_ = 'SK0' THEN

      -- ежем комиссия
      acrb_ := cc_o_nls_ext('8999',
                            rnk_,
                            sour_,
                            nd_,
                            kv_,
                            tip_,
                            'SD2',
                            prod_,
                            tt_);

      UPDATE int_accn
         SET acra = nvl(acra, acc_),
             acrb = nvl(acrb, acrb_),
             tt   = nvl(tt, tt_)
       WHERE id = 2
         AND acc = l_acc8;

      IF SQL%ROWCOUNT = 0 THEN
        INSERT INTO int_accn
          (acc, id, metr, basey, freq, tt, acra, acrb, acr_dat)
        VALUES
          (l_acc8, 2, 0, 0, 1, tt_, acc_, acrb_, gl.bdate - 1);
      END IF;
      -- дополняем проц каточку для коммиссии за неисользованный лимит
      UPDATE int_accn
         SET acra = nvl(acra, acc_)
       WHERE id = 0
         AND acc IN (SELECT a.acc
                       FROM accounts a, nd_acc n
                      WHERE a.acc = n.acc
                        AND n.nd = nd_
                        AND a.tip = 'CR9');
    END IF;

    -- привязать этот счет SN к проц.карточке счетов SS - SL
    IF tip_ = 'SN ' THEN

      FOR k IN (SELECT a.acc
                  FROM nd_acc n, int_accn i, accounts a
                 WHERE a.acc = n.acc
                   AND a.acc = i.acc(+)
                   AND i.id(+) = 0
                   AND a.tip IN ('SS ', 'SP ')
                   AND a.dazs IS NULL
                   AND i.acra IS NULL
                   AND n.nd = nd_) LOOP
        UPDATE int_accn
           SET acra = nvl(acra, acc_)
         WHERE acc = k.acc
           AND id = 0;

        IF SQL%ROWCOUNT = 0 THEN
          INSERT INTO int_accn
            (acc, id, metr, basem, basey, freq, acrb, acr_dat)
            SELECT k.acc, 0, 0, 0, basey, 1, acc_, acr_dat
              FROM int_accn
             WHERE acc = l_acc8
               AND id = 0;
        END IF;

      END LOOP;
    END IF;

    --разные просрочки
    IF tip_ IN ('SP ', 'SL ', 'SPN', 'SLN', 'SN8', 'SK9') THEN
      DECLARE
        acc_8006 INT;
        acc_8008 INT;
      BEGIN

        IF tip_ = 'SN8' THEN
          -- ищем счет доходов всегда под открываемую валюту
          -- счета 8008  (а иначе ожем получить 3800)
          acc_8006 := cc_o_nls_ext(NULL,
                                   rnk_,
                                   sour_,
                                   nd_,
                                   kv_,
                                   'SP ',
                                   'SD2',
                                   prod_,
                                   tt_);
          --при открытии счета SN8 привязать его к SP, SPN, SL, SLN, SK9
          FOR k8 IN (SELECT a.acc
                       FROM accounts a, nd_acc n
                      WHERE a.tip IN ('SP ', 'SL ', 'SPN', 'SLN', 'SK9')
                        AND a.acc = n.acc
                        AND n.nd = nd_) LOOP
            UPDATE int_accn
               SET acra = acc_, acrb = acc_8006, tt = tt_
             WHERE acc = k8.acc
               AND id = 2;
            IF SQL%ROWCOUNT = 0 THEN
              INSERT INTO int_accn
                (acc, id, metr, basey, freq, tt, acra, acrb, acr_dat)
              VALUES
                (k8.acc, 2, 0, 0, 1, tt_, acc_, acc_8006, gl.bdate - 1);
              IF spn_bri_ IS NOT NULL THEN
                SELECT COUNT(*)
                  INTO count_rat_
                  FROM int_ratn
                 WHERE acc = acc_
                   AND id = 2
                   AND (ir IS NOT NULL OR br IS NOT NULL);
                IF count_rat_ = 0 THEN
                  -- ищем индивидуальную ставку
                  INSERT INTO int_ratn
                    (acc, id, bdat, ir)
                    (SELECT k8.acc,
                            2,
                            gl.bdate,
                            to_number(translate(txt, '.', ','),
                                      '9999D9999',
                                      ' NLS_NUMERIC_CHARACTERS = '',.''')
                       FROM nd_txt
                      WHERE nd = nd_
                        AND tag = 'SN8_R');
                  IF SQL%ROWCOUNT = 0 THEN
                    INSERT INTO int_ratn
                      (acc, id, bdat, ir, op, br)
                    VALUES
                      (k8.acc, 2, gl.bdate, 2, 3, spn_bri_);
                  END IF;
                END IF;
              END IF;
            END IF;
          END LOOP;
        ELSE
          --при открытии счетов SP, SPN, SL, SLN, SK9 привязать их к SN8
          acc_8008 := cc_o_nls_ext(nbs_,
                                   rnk_,
                                   sour_,
                                   nd_,
                                   iif_s(cc_kvsd8,
                                         '1',
                                         gl.baseval,
                                         kv_,
                                         gl.baseval),
                                   tip_,
                                   'SN8',
                                   prod_,
                                   tt_);
          acc_8006 := cc_o_nls_ext(nbs_,
                                   rnk_,
                                   sour_,
                                   nd_,
                                   iif_s(cc_kvsd8,
                                         '1',
                                         gl.baseval,
                                         kv_,
                                         gl.baseval),
                                   tip_,
                                   'SD2',
                                   prod_,
                                   tt_);

          UPDATE int_accn
             SET acra = acc_8008, acrb = acc_8006, tt = nvl(tt, tt_)
           WHERE acc = acc_
             AND id = 2;

          IF SQL%ROWCOUNT = 0 THEN
            INSERT INTO int_accn
              (acc, id, metr, basey, freq, tt, acra, acrb, acr_dat)
            VALUES
              (acc_, 2, 0, 0, 1, tt_, acc_8008, acc_8006, gl.bdate - 1);
            IF spn_bri_ IS NOT NULL THEN
              SELECT COUNT(*)
                INTO count_rat_
                FROM int_ratn
               WHERE acc = acc_
                 AND id = 2
                 AND (ir IS NOT NULL OR br IS NOT NULL);
              IF count_rat_ = 0 THEN
                -- ищем индивидуальную ставку
                INSERT INTO int_ratn
                  (acc, id, bdat, ir)
                  (SELECT acc_,
                          2,
                          gl.bdate,
                          to_number(translate(txt, '.', ','),
                                    '9999D9999',
                                    ' NLS_NUMERIC_CHARACTERS = '',.''')
                     FROM nd_txt
                    WHERE nd = nd_
                      AND tag = 'SN8_R');
                IF SQL%ROWCOUNT = 0 THEN
                  INSERT INTO int_ratn
                    (acc, id, bdat, ir, op, br)
                  VALUES
                    (acc_, 2, gl.bdate, 2, 3, spn_bri_);
                END IF;
              END IF;
            END IF;
          END IF;
        END IF;
      EXCEPTION
        WHEN no_data_found THEN
          NULL;
      END;
    END IF;
    -- Переход договора в разряд сомнительных
    -- контр.счет
    --      select min(acc) into ACC_99_ from accounts
    --      where kv=KV_ and nbs='9910' and dazs is null;
    IF tip_ = 'SL ' THEN
      acra_ := cc_o_nls_ext(nbs_,
                            rnk_,
                            sour_,
                            nd_,
                            kv_,
                            tip_,
                            'S9N',
                            prod_,
                            tt_);
      acrb_ := cc_o_nls_ext(nbs_,
                            rnk_,
                            sour_,
                            nd_,
                            kv_,
                            tip_,
                            'SD0',
                            prod_,
                            tt_);
      UPDATE int_accn
         SET acra    = acra_,
             acrb    = acrb_,
             tt      = nvl(tt, tt_),
             stp_dat = (CASE
                         WHEN (stp_dat > nvl(acr_dat, gl.bdate) OR
                              stp_dat IS NULL) AND cc_slstp = 0 THEN
                          nvl(acr_dat, gl.bdate)
                         ELSE
                          stp_dat
                       END)
       WHERE id = 0
         AND (acc = acc_ OR
             acc IN (SELECT acc
                        FROM accounts
                       WHERE accc = l_acc8
                         AND dazs IS NULL));

    END IF;

    IF tip_ = 'S9N' THEN
      /* внебал. SN */
      acrb_ := cc_o_nls_ext(nbs_,
                            rnk_,
                            sour_,
                            nd_,
                            kv_,
                            tip_,
                            'SD0',
                            prod_,
                            tt_);
      UPDATE int_accn
         SET acra    = acc_,
             acrb    = acrb_,
             tt      = nvl(tt, tt_),
             stp_dat = (CASE
                         WHEN (stp_dat > nvl(acr_dat, gl.bdate) OR
                              stp_dat IS NULL) AND cc_slstp = 0 THEN
                          nvl(acr_dat, gl.bdate)
                         ELSE
                          stp_dat
                       END)
       WHERE id = 0
         AND acc IN (SELECT acc
                       FROM accounts
                      WHERE accc = l_acc8
                        AND dazs IS NULL);
    END IF;

    IF tip_ = 'S9K' THEN
      /* внебал.комиссия */
      acrb_ := cc_o_nls_ext(nbs_,
                            rnk_,
                            sour_,
                            nd_,
                            kv_,
                            tip_,
                            'SD0',
                            prod_,
                            tt_);
      UPDATE int_accn
         SET acra    = acc_,
             acrb    = acrb_,
             tt      = nvl(tt, tt_),
             stp_dat = (CASE
                         WHEN (stp_dat > nvl(acr_dat, gl.bdate) OR
                              stp_dat IS NULL) AND cc_slstp = 0 THEN
                          nvl(acr_dat, gl.bdate)
                         ELSE
                          stp_dat
                       END)
       WHERE id = 2
         AND acc = l_acc8;
    END IF;

    /*
    -- проценты  открыт ли уже внебал.счет S9N_ ?
    begin
       select a.acc into ACC_S9_  from nd_acc n, accounts a
       where n.nd= ND_ and a.acc=n.acc and a.tip='S9N' and a.dazs is null;
    EXCEPTION WHEN NO_DATA_FOUND THEN -- нет, его надо открыть
       NLS_S9_:= substr(F_NEWNLS(Acc_,'S9N',null),1,14);
       Op_Reg_Ex(1,ND_,0,GRP_, ret_ , RNK_, NLS_S9_, KV_,
             'Нач.% '||NMS_,'S9N', ISP_ , ACC_S9_,'1', NULL, NULL,
              NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, rTOBO_);
    end;
    */

    -- комиссия Есть ли комиссия вообще и  открыт ли уже внебал.счет S9K_ ?
    /*
    begin
       select 1 into nTmp_ from int_accn
       where id=2 and acc=l_ACC8 and acra is not null;
       begin
         select a.acc into ACC_S9_  from nd_acc n, accounts a
         where n.nd= ND_ and a.acc=n.acc and a.tip='S9K' and a.dazs is null;
       EXCEPTION WHEN NO_DATA_FOUND THEN -- нет, его надо открыть
         NLS_S9_:= substr(F_NEWNLS(Acc_,'S9K',null),1,14);
         Op_Reg_Ex(1,ND_,0,GRP_, ret_ , RNK_, NLS_S9_, KV_,
            'Нач.ком.'||NMS_,'S9K', ISP_ , ACC_S9_,'1', NULL, NULL,
             NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, rTOBO_);
       end;
       update int_accn set ACRA=ACC_S9_,Acrb=ACC_99_ where id=2 and acc=l_ACC8;
    EXCEPTION WHEN NO_DATA_FOUND THEN null;
    end;
    */

  END cc_op_nls;
  -----------------------------------
  PROCEDURE cc_exit_nls(p_nd INT, p_acc INT) IS
    r_aa  accounts%ROWTYPE;
    ern   NUMBER := 315;
    l_col INT;
  BEGIN

    BEGIN
      SELECT a.* INTO r_aa FROM accounts a WHERE a.acc = p_acc;
    EXCEPTION
      WHEN no_data_found THEN
        raise_application_error(- (20000 + ern),
                                '\8999 Не знайдено асс=' || p_acc,
                                TRUE);
    END;

    IF r_aa.tip = 'LIM' THEN
      raise_application_error(- (20000 + ern),
                              '\8999 ' || 'Рахунок ' || r_aa.nls ||
                              'заборонено виводити з під договору',
                              TRUE);
    END IF;

    IF r_aa.tip IN ('SS ', 'SP ', 'SL ') AND r_aa.accc IS NOT NULL THEN
      UPDATE accounts
         SET accc = NULL
       WHERE acc = p_acc
         AND accc = (SELECT a8.acc
                       FROM nd_acc n8, accounts a8
                      WHERE n8.nd = p_nd
                        AND n8.acc = a8.acc
                        AND a8.tip = 'LIM')
      RETURNING COUNT(acc) INTO l_col;
      IF l_col = 1 THEN
        cck.cc_start(p_nd);
      END IF;
    END IF;

    DELETE FROM nd_acc
     WHERE nd = p_nd
       AND acc = p_acc
    RETURNING COUNT(acc) INTO l_col;
    IF l_col = 1 THEN
      cc_sob(p_nd,
             gl.bdate,
             NULL,
             NULL,
             'З договору виведен рахунок № ' || r_aa.nls,
             NULL,
             NULL,
             -110);
    END IF;

  END cc_exit_nls;

  -------------------------------------
  PROCEDURE cc_delete(nd_ INT) IS
    -- процедура удаления ош. КД

    sos_ INT;
    ern  NUMBER := 313;
    erm  VARCHAR2(80);
    err EXCEPTION;

    l_acc8 accounts.accc%TYPE;

  BEGIN
    SELECT sos INTO sos_ FROM cc_deal WHERE nd = nd_;

    IF sos_ < 10 THEN

      -- есть ли остатки и тек.обороты на счетах КД?
      FOR k IN (SELECT a.nls, a.kv
                  FROM accounts a, nd_acc n
                 WHERE a.acc = n.acc
                   AND n.nd = nd_
                   AND (a.tip IN ('SS ',
                                  'SL ',
                                  'SP ',
                                  'SN ',
                                  'SPN',
                                  'LIM',
                                  'CRD',
                                  'CR9',
                                  'SLN',
                                  'SK0',
                                  'SK9',
                                  'SDI',
                                  'SPI',
                                  'ISG',
                                  'SN8',
                                  'ZZI') OR
                       (a.tip = 'SG ' AND substr(a.nbs, 1, 2) <> '26'))
                   AND (a.ostc <> 0 OR a.ostb <> 0 OR a.ostf <> 0 OR
                       (a.dos + a.kos) > 0 AND a.dapp >= gl.bdate)) LOOP
        erm := erm || ' Сч ' || k.nls || '/' || k.kv ||
               ' имеет остаток или обороты.';
        RAISE err;
      END LOOP;

      -- есть ли остатки и тек.обороты на счетах собственных договоров залога КД?
      FOR k IN (SELECT a.nls, a.kv
                  FROM accounts a, cc_accp p
                 WHERE a.acc = p.acc
                   AND p.accs IN (SELECT acc FROM nd_acc WHERE nd = nd_)
                   AND p.acc NOT IN
                       (SELECT acc
                          FROM cc_accp
                         WHERE accs NOT IN
                               (SELECT acc FROM nd_acc WHERE nd = nd_))
                   AND (a.ostc <> 0 OR a.ostb <> 0 OR a.ostf <> 0 OR
                       (a.dos + a.kos) > 0 AND a.dapp >= gl.bdate)) LOOP
        erm := erm || ' Сч ' || k.nls || '/' || k.kv ||
               ' имеет остаток или обороты.';
        RAISE err;
      END LOOP;

      FOR k IN (SELECT a.acc, d.rnk, a.tip
                  FROM cc_deal d, nd_acc n, accounts a
                 WHERE d.nd = nd_
                   AND d.nd = n.nd
                   AND n.acc = a.acc) LOOP
        UPDATE accounts
           SET dazs = bankdate
         WHERE acc = k.acc
           AND ostc = 0
           AND ostc = ostb
           AND rnk = k.rnk
           AND (tip IN ('SS ',
                        'SL ',
                        'SP ',
                        'SN ',
                        'SPN',
                        'LIM',
                        'CRD',
                        'CR9',
                        'SLN',
                        'SK0',
                        'SK9',
                        'SDI',
                        'SPI',
                        'ISG',
                        'SN8',
                        'ZZI',
                        'ISG') OR
               tip = 'SG ' AND substr(nbs, 1, 2) <> '26');

        IF k.tip = 'LIM' THEN
          l_acc8 := k.acc;
        END IF;

      END LOOP;

      DELETE FROM cc_lim WHERE nd = nd_;
      DELETE FROM nd_txt WHERE nd = nd_;
      DELETE FROM nd_txt_update WHERE nd = nd_;
      DELETE FROM cc_sob WHERE nd = nd_;
      DELETE FROM cc_accp
       WHERE accs IN (SELECT acc FROM nd_acc WHERE nd = nd_);
      DELETE FROM nd_acc WHERE nd = nd_;
      DELETE FROM cc_prol WHERE nd = nd_;
      DELETE FROM cc_docs WHERE nd = nd_;
      DELETE FROM cc_many WHERE nd = nd_;
      DELETE FROM cc_add WHERE nd = nd_;
      DELETE FROM cc_deal WHERE nd = nd_;

      DELETE FROM int_ratn WHERE acc = l_acc8;
      DELETE FROM int_accn WHERE acc = l_acc8;

    END IF;

  EXCEPTION
    WHEN err THEN
      raise_application_error(- (20000 + ern), '\ ' || erm, TRUE);

  END cc_delete;
  -- ВИконується пролонгація КД з додаванням запису в CC_LIM
  --COBUSUPMMFO-732 внесено зміни в вибірку
  PROCEDURE cc_prolong(p_nd  INT, -- выбор по всем КД =0, или по одному
                       p_dat DATE -- тек.дата

                       ) IS
    l_wdate_old DATE;
    l_wdatl     DATE;
    l_sour      NUMBER;
    l_kprol     NUMBER;
    l_txt       VARCHAR2(300);
    l_fio       VARCHAR2(60);
    l_id        INT;
    l_sos       INT;
    l_s080_old  VARCHAR2(1);
  BEGIN
    BEGIN
      SELECT id, fio INTO l_id, l_fio FROM staff WHERE logname = USER;
    EXCEPTION
      WHEN no_data_found THEN
        l_fio := '';
    END;
    --  raise_application_error(-20004,'dffhgj');
    FOR k IN (SELECT d.nd, c.mdate, d.vidd, d.sdate
                FROM cc_deal d, cc_prol c
               WHERE (p_nd = 0 OR p_nd = d.nd)
                 AND d.nd = c.nd
                 AND d.vidd IN (1, 2, 3, 11, 12, 13)
                 AND d.sos < 15
                 AND c.dmdat = p_dat
                 AND c.dmdat IS NOT NULL
                 AND c.npp = (SELECT MAX(npp)
                                FROM cc_prol
                               WHERE nd = d.nd
                                 AND dmdat = c.dmdat
                                 AND c.dmdat IS NOT NULL)
            union -- Добавление субдоговоров для пролонгации
             select d.nd,c.mdate, d.vidd, d.sdate
              from cc_deal d, cc_prol c
             where p_nd = d.ndg 
               and d.nd<>d.ndg 
               and d.ndg = c.nd
               and d.vidd in (1,2,3) and d.sos<15
               and c.dmdat = p_dat and c.dmdat is not null
               and c.npp = (select max(npp) from cc_prol where nd = d.ndg and dmdat = c.dmdat and c.dmdat is not null)) LOOP
      SELECT d.wdate,
             (SELECT MIN(s.s080)
                FROM nd_acc n, accounts a, specparam s
               WHERE n.nd = k.nd
                 AND n.acc = a.acc
                 AND a.tip IN ('SS ', 'SP ', 'SPN', 'SN ', 'S36')
                 AND a.acc = s.acc)
        INTO l_wdate_old, l_s080_old
        FROM cc_deal d
       WHERE d.nd = k.nd;

      IF (l_wdate_old <> k.mdate) THEN

        SELECT sour INTO l_sour FROM cc_add WHERE nd = k.nd;

        SELECT nvl(kprolog, 0) + 1, sos
          INTO l_kprol, l_sos
          FROM cc_deal
         WHERE nd = k.nd;

        IF l_wdate_old < k.mdate THEN
          l_txt := 'Змiни КД: Збiльшення термiну закiнчення з ' ||
                   to_char(l_wdate_old, 'dd/mm/yyyy') || ' на ' ||
                   to_char(k.mdate, 'dd/mm/yyyy') || ' (вик.' || l_id || ' ' ||
                   l_fio || ')';
        ELSE
          l_txt := 'Змiни КД: Зменшення термiну закiнчення з ' ||
                   to_char(l_wdate_old, 'dd/mm/yyyy') || ' на ' ||
                   to_char(k.mdate, 'dd/mm/yyyy') || ' (вик.' || l_id || ' ' ||
                   l_fio || ')';
        END IF;

        UPDATE cc_deal
           SET wdate = k.mdate, kprolog = l_kprol
         WHERE nd = k.nd;

        FOR l IN (SELECT n.acc, a.mdate, a.tip, a.nls, a.kv
                    FROM accounts a, nd_acc n
                   WHERE n.acc = a.acc
                     AND n.nd = k.nd
                     AND a.dazs IS NULL
                     AND a.mdate IS NOT NULL
                     AND a.tip IN ('LIM',
                                   'SS ',
                                   'SN ',
                                   'SP ',
                                   'SPN',
                                   'SL ',
                                   'SLN',
                                   'SDI',
                                   'SPI',
                                   'SG ',
                                   'SK0',
                                   'SK9',
                                   'CR9',
                                   'SN8',
                                   'SNA',
                                   'SNO'
                                   ,'S36')) LOOP

          UPDATE accounts
             SET mdate = CASE
                           WHEN l.tip = 'SS ' AND k.vidd IN (2, 3, 12, 13) AND
                                mdate IS NOT NULL AND mdate <> l_wdate_old AND
                                mdate < k.mdate THEN
                            mdate -- дата погашення траншу не міняється якщо відкривалися рахунки на кожен транш (дибілізм ощада)
                           ELSE
                            k.mdate
                         END
           WHERE acc = l.acc
          RETURNING mdate INTO l_wdatl;

          bars.cck_specparam(l.acc,
                             l.nls,
                             l.kv,
                             l.tip,
                             l_sour,
                             l_s080_old,
                             k.sdate,
                             l_wdatl,
                             k.vidd,
                             k.nd);

        END LOOP;

        IF l_sos = 0 THEN
          -- макети дог.
          UPDATE cc_prol
             SET mdate = k.mdate
           WHERE npp = 0
             AND nd = k.nd;
        ELSIF l_sos > 0 AND l_sos < 15 THEN
          -- діючі дог.
          UPDATE cc_prol
             SET txt = l_txt
           WHERE nd = k.nd
             AND dmdat = bankdate
             AND npp = l_kprol;
        END IF;

      END IF;

    END LOOP;
    --Додаємо відповідний запис про пролонацію в ГПК

  END cc_prolong;
  ----------------------------------------
  PROCEDURE cc_close(nd_ INT, serr_ OUT VARCHAR2) IS

    sd_    NUMBER;
    nls9_  VARCHAR2(15);
    dk_    INT;
    ref_   NUMBER;
    nms9_  VARCHAR2(38);
    sdate_ DATE;
    kv_    NUMBER;
    nls99_ VARCHAR2(15);
    sos_   NUMBER;
    nms99_ VARCHAR2(38);
    nint_  NUMBER;
    okpo_b VARCHAR2(14);
    okpo_a VARCHAR2(14);
    cc_id_ VARCHAR2(20);
    par_   VARCHAR2(14);

    l_migr   nd_txt.txt%TYPE;
    oo       oper%ROWTYPE;
    l_cc_id  cc_deal.cc_id%TYPE;
    l_sdate  cc_deal.sdate%TYPE;
    l_cc_idz pawn_acc.cc_idz%TYPE;
    l_sdatz  pawn_acc.sdatz%TYPE;

    -- процедура закрытия КД
  BEGIN
    serr_ := NULL;

    -- есть ли остатки и тек.обороты на счетах КД?
    FOR k IN (SELECT a.nls, a.kv
                FROM accounts a, nd_acc n, cc_deal c
               WHERE (c.nd = nd_ or c.ndg = nd_ )
                 and n.nd = c.nd
                 AND a.acc = n.acc
                 AND (a.tip IN ('SS ',
                                'SL ',
                                'SP ',
                                'SN ',
                                'SPN',
                                'LIM',
                                'CRD',
                                'CR9',
                                'SLN',
                                'SK0',
                                'SK9',
                                'SDI',
                                'SPI',
                                'SN8',
                                'ZZI',
                                'ISG',
                                'S9K',
                                'S9N',
                                'S8V',
                                'S36') OR
                     a.tip = 'SG ' AND substr(a.nbs, 1, 2) <> '26')
                 AND (a.ostc <> 0 OR a.ostb <> 0 OR a.ostf <> 0 OR
                     a.dos + a.kos > 0 AND a.dapp >= gl.bdate)) LOOP
      serr_ := serr_ || ' Сч ' || k.nls || '/' || k.kv ||
               ' имеет остаток или обороты.';
    END LOOP;

    /* -- есть ли остатки и тек.обороты на счетах собственных договоров залога КД?
    for k in ( SELECT a.nls, a.kv
               FROM accounts a, cc_accp p
               WHERE a.acc=p.acc  and  substr(a.tip,1,2) !='SD'  and
                     p.accs    in (select acc from nd_acc  where nd=ND_) and
                     p.acc not in (select acc from cc_accp
                                   where accs not in (select acc from nd_acc where nd=ND_)) and
                    (a.ostc<>0 or a.ostb<>0 or a.ostf<>0 or (a.dos+a.kos)>0 and a.dapp>=gl.bdate ) )
    loop  sErr_:= sErr_||' Сч '||k.NLS||'/'||k.kv||' имеет остаток или обороты.' ; end loop;
    */

    -- все ли проценты начислены ?
    FOR k IN (SELECT a.acc,
                     a.nls,
                     a.kv,
                     i.id,
                     nvl(i.acr_dat + 1, a.daos) dat1,
                     i.stp_dat
                FROM int_accn i, nd_acc n, accounts a, cc_deal c
               WHERE (c.nd = nd_ or c.ndg = nd_)
                 and n.nd = c.nd
                 AND a.acc = n.acc
                 and i.acc = a.acc
                 AND nvl(i.acr_dat + 1, a.daos) < a.dapp
                 AND a.dazs IS NULL
                 AND (a.tip IN ('SS ', 'SL ', 'SP ') AND i.id = 0 OR
                     a.tip = 'LIM' AND id = 2)) LOOP
      acrn.p_int(k.acc,
                 k.id,
                 k.dat1,
                 nvl(k.stp_dat, gl.bdate - 1),
                 nint_,
                 NULL,
                 1);
      IF nvl(nint_, 0) != 0 THEN
        serr_ := serr_ || ' Не начислен' || (CASE
                   WHEN k.id = 0 THEN
                    'ы %'
                   ELSE
                    'а пеня/комиссия'
                 END) || ' по cч ' || k.nls || '/' || k.kv;
      END IF;
    END LOOP;

    IF serr_ IS NOT NULL THEN
      RETURN;
    END IF;
    -- Остатки на счетах собственных договоров залога КД обнуляются при закрытии КД (заявка COBUPRVN-154)
    FOR k IN (SELECT DISTINCT a.acc,
                              abs(a.ostc) ostc,
                              a.pap,
                              a.kv,
                              a.nls,
                              a.branch,
                              substr(a.nms, 1, 38) nms
                FROM accounts a, cc_accp p
               WHERE a.acc = p.acc
                 AND substr(a.tip, 1, 2) != 'SD'
                 AND a.ostc <> 0
                 AND p.accs IN (SELECT acc FROM nd_acc n, cc_deal c WHERE (c.nd= nd_ or  c.ndg = nd_) and c.nd = n.nd)
                 AND p.acc NOT IN
                     (SELECT acc
                        FROM cc_accp
                       WHERE accs NOT IN
                             (SELECT acc FROM nd_acc WHERE nd = nd_))) LOOP
      BEGIN
        SELECT to_number(val)
          INTO oo.nlsa
          FROM branch_parameters
         WHERE tag = 'NLS_9900'
           AND branch = k.branch;
        SELECT substr(nms, 1, 38)
          INTO oo.nam_a
          FROM accounts
         WHERE nls = oo.nlsa
           AND kv = k.kv;
      EXCEPTION
        WHEN no_data_found THEN
          raise_application_error(-20000,
                                  'Не знайдено (NLS_9900)! Помилка!');
      END;
      BEGIN
        SELECT cc_id, sdate
          INTO l_cc_id, l_sdate
          FROM cc_deal
         WHERE nd = nd_;
        SELECT cc_idz, sdatz
          INTO l_cc_idz, l_sdatz
          FROM pawn_acc
         WHERE acc = k.acc;
      EXCEPTION
        WHEN no_data_found THEN
          l_cc_id  := NULL;
          l_sdate  := NULL;
          l_cc_idz := NULL;
          l_sdatz  := NULL;
      END;
      IF k.pap = 2 THEN
        oo.dk := 0;
      ELSIF k.pap = 1 THEN
        oo.dk := 1;
      END IF;
      gl.ref(oo.ref);
      oo.tt    := 'ZAL';
      oo.vob   := 6;
      oo.vdat  := gl.bdate;
      oo.kv    := k.kv;
      oo.s     := k.ostc;
      oo.nlsb  := k.nls;
      oo.nam_b := k.nms;
      oo.nazn  := 'Списання застави згідно договору № ' || l_cc_idz ||
                  ' від ' || to_char(l_sdatz, 'dd-mm-yyyy') ||
                  ' для кред.угоди ' || l_cc_id || ' від ' ||
                  to_char(l_sdate, 'dd-mm-yyyy') || ' (Закриття угоди)';
      gl.in_doc3(ref_   => oo.ref,
                 tt_    => oo.tt,
                 vob_   => oo.vob,
                 nd_    => oo.ref,
                 pdat_  => SYSDATE,
                 vdat_  => oo.vdat,
                 dk_    => oo.dk,
                 kv_    => oo.kv,
                 s_     => oo.s,
                 kv2_   => oo.kv,
                 s2_    => oo.s,
                 sk_    => NULL,
                 data_  => oo.vdat,
                 datp_  => oo.vdat,
                 nam_a_ => oo.nam_a,
                 nlsa_  => oo.nlsa,
                 mfoa_  => gl.amfo,
                 nam_b_ => oo.nam_b,
                 nlsb_  => oo.nlsb,
                 mfob_  => gl.amfo,
                 nazn_  => oo.nazn,
                 d_rec_ => NULL,
                 id_a_  => gl.aokpo,
                 id_b_  => gl.aokpo,
                 id_o_  => NULL,
                 sign_  => NULL,
                 sos_   => 1,
                 prty_  => NULL,
                 uid_   => NULL);
      gl.payv(1,
              oo.ref,
              oo.vdat,
              oo.tt,
              oo.dk,
              oo.kv,
              oo.nlsa,
              oo.s,
              oo.kv,
              oo.nlsb,
              oo.s);

    END LOOP;

    -- Нормальное Закрытие счетов по договору
    l_migr := cck_app.get_nd_txt(nd_, 'MGR_T');
    FOR k IN (SELECT a.acc, a.tip, a.nbs
                FROM accounts a, nd_acc n, cc_deal c
               WHERE (c.nd = nd_ or c.ndg = nd_)
                 AND n.nd = c.nd
                 and a.acc = n.acc
                 AND a.dazs IS NULL
                 AND (a.tip IN ('SS ',
                                'SL ',
                                'SP ',
                                'SN ',
                                'SPN',
                                'LIM',
                                'CRD',
                                'CR9',
                                'ISG',
                                'SLN',
                                'SK0',
                                'SK9',
                                'SDI',
                                'SPI',
                                'SN8',
                                'ZZI',
                                'S9K',
                                'S9N',
                                'S8V',
                                'S36') OR
                     a.tip = 'SG ' AND substr(a.nbs, 1, 2) <> '26')) LOOP
      IF l_migr IS NOT NULL AND k.tip LIKE '%SG%' AND k.nbs = '3739' THEN
        NULL;
      ELSE
        UPDATE accounts SET dazs = gl.bdate WHERE acc = k.acc;
      END IF;
    END LOOP;

    FOR k IN (SELECT a.acc
                FROM accounts a, cc_accp p
               WHERE a.acc = p.acc
                 AND p.accs IN (SELECT acc FROM nd_acc WHERE nd = nd_)
                 AND p.acc NOT IN
                     (SELECT acc
                        FROM cc_accp
                       WHERE accs NOT IN
                             (SELECT acc FROM nd_acc n, cc_deal c WHERE (c.nd= nd_ or c.ndg = nd_) and c.nd = n.nd)
                     )
                 AND a.ostc = 0
                 AND a.ostb = 0
                 AND a.ostf = 0
                 AND a.dapp < gl.bdate
                 AND a.dazs IS NULL) LOOP
      UPDATE accounts SET dazs = gl.bdate WHERE acc = k.acc;
    END LOOP;

    SELECT sos INTO sos_ FROM cc_deal WHERE nd = nd_;

    BEGIN
      SELECT substr(val, 1, 1) INTO par_ FROM params WHERE par = 'CC_KOL';
    EXCEPTION
      WHEN no_data_found THEN
        par_ := '0';
    END;

    for r in (select nd, sos from cc_deal where nd = nd_ or  ndg = nd_)
    loop
--      SELECT sos INTO sos_ FROM cc_deal WHERE nd = nd_;

      IF r.sos <> 15 AND par_ = '1' THEN
        cck.cc_9819(r.nd, 1);
      END IF;

      UPDATE cc_deal SET sos = 15 WHERE nd = r.nd;
    end loop;
    --exception when others then NULL;
    --commit;
  END cc_close;
  ----------------------------------------
  -- Перевірка по Держпрограмі
  PROCEDURE cc_escr_check(nd_ NUMBER, err_code OUT NUMBER)

   IS
    l_count_boiler   NUMBER;
    l_count_material NUMBER;
    cc_deal_row      cc_deal%ROWTYPE;

  BEGIN

    BEGIN
      SELECT * INTO cc_deal_row FROM cc_deal d WHERE d.nd = nd_;
    EXCEPTION
      WHEN OTHERS THEN
        NULL;

    END;

    BEGIN
      SELECT COUNT(d.nd)
        INTO l_count_boiler
        FROM cc_deal d
       WHERE d.rnk = cc_deal_row.rnk
         AND extract(YEAR FROM d.sdate) =
             extract(YEAR FROM cc_deal_row.sdate)
         AND substr(d.prod, 1, 6) IN ('220347', '220257','220373')
         AND d.sos <> 0;
    END;
    BEGIN
      SELECT COUNT(d.nd)
        INTO l_count_material
        FROM cc_deal d
       WHERE d.rnk = cc_deal_row.rnk
         AND extract(YEAR FROM d.sdate) =
             extract(YEAR FROM cc_deal_row.sdate)
         AND substr(d.prod, 1, 6) IN ('220258', '220348','220374')
         AND d.sos <> 0;
    END;
    IF l_count_boiler >= 1 AND l_count_material >= 1 THEN
      err_code := 1;
    ELSIF l_count_boiler >= 1 AND
          substr(cc_deal_row.prod, 1, 6) IN ('220347', '220257','220373') THEN
      err_code := 2;
    ELSIF l_count_material >= 1 AND
          substr(cc_deal_row.prod, 1, 6) IN ('220258', '220348','220374') THEN
      err_code := 3;
    ELSE
      err_code := 0;
    END IF;
  END cc_escr_check;
  -- Авторизация кредитного договора

  PROCEDURE cc_autor(nd_ INT, saim_ VARCHAR2, urov_ VARCHAR2) IS
    dd       cc_deal%ROWTYPE;
    l_pstart VARCHAR2(50);
    par_     VARCHAR2(14);
    ssql_    VARCHAR2(2000);
    stmp_    VARCHAR2(15);
    l_err_code NUMBER;
  BEGIN

    BEGIN
      SELECT * INTO dd FROM cc_deal WHERE nd = nd_;
    EXCEPTION
      WHEN no_data_found THEN
        RETURN;
    END;

    -- wcs_register.put_visa(nd_,4);
    -- grt_mgr.create_account_balance(null,nd_ );
    DELETE FROM nd_txt
     WHERE nd = nd_
       AND tag = 'AUTOR';
    DELETE FROM nd_txt
     WHERE nd = nd_
       AND tag = 'MS_UR';
    INSERT INTO nd_txt (nd, tag, txt) VALUES (nd_, 'AUTOR', saim_);
    INSERT INTO nd_txt
      (nd, tag, txt)
    VALUES
      (nd_, 'MS_UR', substr(urov_, 1, 35));
    INSERT INTO cc_sob
      (nd, fdat, isp, txt, otm)
    VALUES
      (nd_, gl.bdate, gl.auid, saim_, 6);

    BEGIN
      SELECT substr(val, 1, 1) INTO par_ FROM params WHERE par = 'CC_KOL';
    EXCEPTION
      WHEN no_data_found THEN
        par_ := '0';
    END;
    IF dd.sos = 0 AND par_ = '1' THEN
      cck.cc_9819(nd_, 0);
    END IF;
    if dd.prod in ('220258', '220348', '220347', '220257', '220374', '220373') then
      cc_escr_check(nd_, l_err_code);
      IF l_err_code = 1 THEN
        raise_application_error(-20203,
                                '\CCK.cc_autor:
ЗАБОРОНЕНО Авторизацію договору, так як клієнт вже отримав кредити по державній програмі ( по котлам і по матеріалам)');
        bars_audit.info('CCK.cc_autor: nd_:=' || nd_ ||
                        ' не авторизовано.Вже отримано КД по дежржпрограмі (по котлам і по матеріалам)');
      ELSIF l_err_code = 2 THEN
        raise_application_error(-20203,
                                '\CCK.cc_autor:
ЗАБОРОНЕНО Авторизацію договору, так як клієнт вже отримав кредити в рамках державної програми  по котлам');
        bars_audit.info('CCK.cc_autor: nd_:=' || nd_ ||
                        ' не авторизовано.Вже отримано КД по дежржпрограмі по котлам');
      ELSIF l_err_code = 3 THEN
        raise_application_error(-20203,
                                '\CCK.cc_autor:
ЗАБОРОНЕНО Авторизацію договору, так як клієнт вже отримав кредити в рамках державної програми  по матеріалам)');
        bars_audit.info('CCK.cc_autor: nd_:=' || nd_ ||
                        ' не авторизовано.Вже отримано КД по дежржпрограмі по матеріалам');
      END IF;
    END IF;
    UPDATE cc_deal SET sos = 10 WHERE nd = nd_;
	
	--COBUPRVNIX-148 При авторизации Кред.линии ЮО - необходимо авторизировать все его суб.договора
	if dd.vidd in (1, 2, 3) then 
		UPDATE cc_deal SET sos = 10 WHERE ndg = nd_;
	end if;
    --COBUPRVNIX-148 

    FOR k IN (SELECT a.acc
                FROM accounts a, nd_acc n
               WHERE n.nd = nd_
                 AND n.acc = a.acc
                 AND a.tip = 'SS '
                 AND a.blkd = 99
                 AND a.dazs IS NULL) LOOP
      UPDATE accounts SET blkd = 0 WHERE acc = k.acc;
    END LOOP;

    IF dd.sos < 10 THEN
      INSERT INTO cc_prol
        (nd, npp, mdate, fdat)
        SELECT dd.nd, 0, dd.wdate, MIN(fdat) FROM cc_lim WHERE nd = dd.nd;
    END IF;

    ssql_ := 'select pStart from cck_ob22 where nbs= ''' ||
             substr(dd.prod, 1, 4) || ''' and ob22= ''' ||
             substr(dd.prod, 5, 2) || ''' and pStart is not null ';
    logger.info('OSBB -1 ' || ssql_ || '=' || l_pstart);
    BEGIN
      EXECUTE IMMEDIATE ssql_
        INTO l_pstart;
    EXCEPTION
      WHEN OTHERS THEN
        NULL;
    END;

    ---Доп.биз-лог~при авториз. КД
    IF l_pstart IS NOT NULL THEN
      l_pstart := REPLACE(l_pstart, ':ND', to_char(nd_));
      EXECUTE IMMEDIATE 'begin ' || l_pstart || ';  end; ';
    END IF;
  /*Для кількох % ставок копіюємо % карточку на рахунок SS  */
  /* p_int_save(nd_  =>      nd_,
                       p_mode   => 1 )  ;*/
    /*
       COBUPRVN-225
       Забезпечити перевірку заповнення параметрів ВКР при авторизації кредитних договорів
       Для КД ЮО+ФО для "Авторизовано" необхідно контроль заповнення параметра  VNCRR "Поточний ВКР"
       При цьому параметр VNCRP "Первинний ВКР", повинен заповнюватися автоматично і бути недоступним для редагування , при першому збереженні "Поточного ВКР" .
    */
    /*stmp_ := TRIM(cck_app.get_nd_txt(nd_, 'VNCRR')); --   "Поточний ВКР"
        BEGIN
          SELECT r.code INTO stmp_ FROM cck_rating r WHERE r.code = stmp_;
        EXCEPTION
          WHEN no_data_found THEN
            raise_application_error(-20203
                                   , '\8999-CCK.cc_autor:
    НЕдопустимий/НЕзаповнений дод.реквізит VNCRR = Поточний ВКР ' ||
                                     stmp_);
        END;

        stmp_ := TRIM(cck_app.get_nd_txt(nd_, 'VNCRP')); --   "Первинний  ВКР"
        BEGIN
          SELECT r.code INTO stmp_ FROM cck_rating r WHERE r.code = stmp_;
        EXCEPTION
          WHEN no_data_found THEN
            raise_application_error(-20203
                                   , '\8999-CCK.cc_autor:
    НЕдопустимий/НЕзаповнений дод.реквізит VNCRP = Первинний ВКР ' ||
                                     stmp_);
        END;*/
    /*
        COBUSUPABS-4376
        Забезпечення неможливості авторизації заявок на кредитні угоди (окрім кредитів по БПК),
        якщо позичальник є інсайдером.
    */

    /*BEGIN
      SELECT c.prinsider INTO stmp_ FROM customer c WHERE dd.rnk = c.rnk;
    EXCEPTION
      WHEN no_data_found THEN
        raise_application_error(-20203,
                                '\8999-CCK.cc_autor:
Даних по клієнту НЕ знайдено ' || stmp_);
    END;

    IF stmp_ IS NULL THEN
      raise_application_error(-20203,
                              '\8999-CCK.cc_autor:
ПО клієнту НЕ ЗАПОВНЕНА ознака інсайдера ' ||
                               stmp_);
    ELSIF stmp_ <> '99' THEN
      raise_application_error(-20203,
                              '\8999-CCK.cc_autor:
ЗАБОРОНЕНО Авторизацію договора - клієнт являється ІНСАЙДЕРОМ/Ознака = ' ||
                               stmp_);
    END IF;*/

  END cc_autor;
  ---------------------------------------------------------------

  -- процедуры запоминания м/вал и баз.проц ставок
  PROCEDURE multi_int_ex(nd_ NUMBER, -- реф КД
                         br_ NUMBER, -- код баз.ставки или пусто
                         an_ INT, -- = 1 признак нового ануитета
                         k1_ INT,
                         p1_ NUMBER,
                         k2_ INT,
                         p2_ NUMBER,
                         k3_ INT,
                         p3_ NUMBER,
                         k4_ INT,
                         p4_ NUMBER) IS

    i_   INT;
    tag_ VARCHAR2(5);
    rat_ VARCHAR2(10);
  BEGIN
    FOR k IN (SELECT kv FROM tabval) LOOP
      DELETE FROM nd_txt
       WHERE nd = nd_
         AND tag = 'P' || k.kv;
    END LOOP;
    --------------------------------------------------------------------------------------------------------------
    FOR i_ IN 1 .. 4 LOOP
      SELECT 'P' || to_char(decode(i_,
                                   1,
                                   nvl(k1_, 0),
                                   2,
                                   nvl(k2_, 0),
                                   3,
                                   nvl(k3_, 0),
                                   nvl(k4_, 0))),
             to_char(decode(i_, 1, p1_, 2, p2_, 3, p3_, p4_), '9999.99')
        INTO tag_, rat_
        FROM dual;

      BEGIN
        SELECT tag INTO tag_ FROM cc_tag WHERE tag = tag_;
      EXCEPTION
        WHEN no_data_found THEN
          INSERT INTO cc_tag (tag) VALUES (tag_);
      END;

      IF tag_ <> 'P0' THEN
        UPDATE nd_txt
           SET txt = rat_
         WHERE nd = nd_
           AND tag = tag_;
        IF SQL%ROWCOUNT = 0 THEN
          INSERT INTO nd_txt (nd, tag, txt) VALUES (nd_, tag_, rat_);
        END IF;
      END IF;
    END LOOP;

    IF an_ = 1 THEN
      UPDATE int_accn i
         SET i.basem = 1, i.basey = 2
       WHERE i.id = 0
         AND i.acc = (SELECT a.acc
                        FROM accounts a, nd_acc n
                       WHERE n.nd = nd_
                         AND n.acc = a.acc
                         AND a.tip = 'LIM');
    END IF;

    IF br_ IS NOT NULL THEN
      cck.br_int(nd_, br_);
    END IF;

  END multi_int_ex;
  -----------------
  PROCEDURE br_int(nd_ NUMBER, br_ NUMBER) IS
    a8   accounts%ROWTYPE;
    i8   int_accn%ROWTYPE;
    dat_ DATE;
  BEGIN
    BEGIN
      SELECT a.*
        INTO a8
        FROM accounts a, nd_acc n
       WHERE n.nd = nd_
         AND n.acc = a.acc
         AND a.tip = 'LIM';
      SELECT i.*
        INTO i8
        FROM int_accn i
       WHERE i.id = 0
         AND i.acc = a8.acc;
    EXCEPTION
      WHEN no_data_found THEN
        RETURN;
    END;

    DELETE FROM int_ratn
     WHERE acc = a8.acc
       AND id = 0;

    FOR x IN (SELECT *
                FROM br_normal
               WHERE kv = a8.kv
                 AND br_id = br_
                 AND bdate <= a8.mdate
                 AND bdate >= (SELECT MAX(bdate)
                                 FROM br_normal
                                WHERE kv = a8.kv
                                  AND br_id = br_
                                  AND bdate <= a8.daos)
               ORDER BY bdate)

     LOOP
      IF x.bdate <= a8.daos THEN
        dat_ := a8.daos; -- первое значение
      ELSIF i8.basey = 2 AND i8.basem = 1 THEN
        dat_ := cck.f_dat(i8.s, trunc(x.bdate, 'MM')); -- ануитет - ближайшая пл.дата
        IF dat_ < x.bdate THEN
          dat_ := add_months(dat_, 1);
        END IF;
      ELSE
        dat_ := x.bdate;
      END IF;

      UPDATE int_ratn
         SET ir = x.rate
       WHERE acc = a8.acc
         AND id = 0
         AND bdat = dat_;
      IF SQL%ROWCOUNT = 0 THEN
        INSERT INTO int_ratn
          (acc, id, bdat, ir)
        VALUES
          (a8.acc, 0, dat_, x.rate);
      END IF;

    END LOOP;

  END br_int;
  ------------

  PROCEDURE multi_int(nd_ NUMBER,
                      k1_ INT,
                      p1_ NUMBER,
                      k2_ INT,
                      p2_ NUMBER,
                      k3_ INT,
                      p3_ NUMBER,
                      k4_ INT,
                      p4_ NUMBER) IS
  BEGIN
    cck.multi_int_ex(nd_,
                     to_number(NULL),
                     to_number(NULL),
                     k1_,
                     p1_,
                     k2_,
                     p2_,
                     k3_,
                     p3_,
                     k4_,
                     p4_);
  END multi_int;
  ----------------------------------------------------------------------------------------------------------

  Procedure RE_ost8 (p_nd number)   is l_ostc number ;
  begin

    -- простые КД
    FOR d1 in ( SELECT d.nd, a.acc, a.ostc FROM cc_deal d, nd_acc n, accounts a  
                WHERE  d.vidd in (1,11) and n.nd = d.nd  AND n.acc = a.acc  AND a.tip ='LIM' and d.sos >=10 and d.sos <14 
                  and  p_nd in ( 0, d.nd )  and d.nd <> nvl( d.ndg,0)
              )
    loop l_ostc := 0;
       for s1 in (select a.acc, nvl(a.accc,0) ACCC, a.OSTC FROM nd_acc n, accounts a WHERE n.nd = d1.nd  AND n.acc = a.acc  AND a.tip IN ('SS ', 'SP' ) )
       loop l_ostc := l_ostC + s1.ostc ; 
            If s1.ACCC <> d1.ACC then  update accounts a set a.accc = d1.acc where a.acc = s1.acc ; end if ;
       end loop; -- s1
       If l_ostc <> d1.ostc      then  update accounts a set a.ostc = l_ostc where a.acc = d1.acc ; end if ;
    end loop ; -- d1

    -- Сложные простые КД
    FOR d2 in ( SELECT d.nd, a.kv, a.acc, a.ostc FROM cc_deal d, nd_acc n, accounts a  
                WHERE  d.vidd not in (1,11) and n.nd = d.nd  AND n.acc = a.acc  AND a.tip ='LIM' and d.sos >=10 and d.sos <14 
                  and  p_nd in ( 0, d.nd )  and d.nd = d.ndg
              )
    loop select nvl( sum(  gl.p_Ncurval ( d2.kv, gl.p_icurval ( s2.kv, s2.ostc, gl.bdate),  gl.bdate ) ), 0 )  into l_ostc from accounts s2 where  accc = d2.acc;
         If l_ostc <> d2.ostc   then  update accounts a set a.ostc = l_ostc where a.acc = d2.acc ; end if ;
    end loop ; -- d2
  end ;
  ------------------------------------

  PROCEDURE cc_day_lim(fdat_ DATE, nn_ INT) IS

    /* 1. Актуализация текущим лимитом дня.
       2. пересмотреть просрочки, м.б. они уже исправились
       3. Переоценка остатка родительского счета при дочерних в другой валюте
       4. Отметки в ГПК о вып.платежей
    */
    a8     accounts%ROWTYPE;
    s_     NUMBER;
    ss_    NUMBER;
    par_   CHAR(1) := nvl(getglobaloption('CC_GPK'), '0');
    par1_  CHAR(1);
    s1_    NUMBER;
    s2_    NUMBER;
    sos    INT;
    datg_  cc_sparam.datg%TYPE;
    sumg_  cc_sparam.sumg%TYPE;
    ibank_ CHAR(1) := nvl(getglobaloption('IBANK'), '0');
    l_cnt  NUMBER;
    l_accs NUMBER;


  BEGIN

    -- IF nn_ = 0 THEN  RE_ost8 (0) ;  END IF; -- 0. Аварийное Исправление остатка на счете 8999
    -----------------------------------------------------
    FOR k IN (SELECT *  FROM cc_deal d WHERE sos < 14    AND vidd IN (1, 2, 3, 11, 12, 13)    AND (nn_ = 0 OR nd = nn_)) 
    LOOP
       cck.set_floating_rate(p_nd => k.nd);                -- пересмотр плавающей % ставки
       cck.lim_bdate(p_nd => k.nd, p_dat => fdat_);        -- установка cc_deal.limit,  cc_add.s, accounts.ostx

       ---  Обновление cc_add.ACCS
       SELECT MIN(a.acc)  INTO l_accs  FROM accounts a, nd_acc n WHERE a.acc = n.acc  AND n.nd = k.nd  AND a.tip IN ('SS ', 'SP ')   AND dazs IS NULL;
       IF l_accs IS NOT NULL THEN   UPDATE cc_add  SET accs = l_accs   WHERE nd = k.nd   AND adds = 0    AND nvl(accs, 0) <> l_accs ;  END IF;

       -- пересмотр поля SOS
       IF k.sos >= 10 THEN   
          SELECT nvl(SUM(a.ostc), 0), nvl(SUM(a.ostb), 0)  INTO s_, ss_ FROM accounts a, nd_acc n WHERE n.nd = k.nd   AND n.acc = a.acc AND a.tip IN ('SP ', 'SPN', 'SK9', 'SL ', 'SLN', 'SLK');
          IF s_ = ss_ THEN   
             IF s_ = 0 AND k.wdate - fdat_ >= 0 AND k.sos > 10  THEN    UPDATE cc_deal SET sos = 10 WHERE nd = k.nd;  END IF;
             IF k.sos = 10 AND (s_ != 0 OR k.wdate - fdat_ < 0) THEN    UPDATE cc_deal SET sos = 13 WHERE nd = k.nd;  END IF;
          END IF;
       END IF;

       -- Все-таки найти ACC8_
       BEGIN  SELECT acc INTO a8.acc FROM cc_lim   WHERE nd  = k.nd   AND rownum = 1;
              SELECT *   INTO a8     FROM accounts WHERE acc = a8.acc ;
       EXCEPTION  WHEN no_data_found THEN  GOTO kin_k;
       END;

       IF ibank_ = '1' THEN
          -- Реально предназначено для транспортировки в "интернет-банкинг"
          BEGIN SELECT l.fdat, l.sumg  INTO datg_, sumg_  FROM cc_lim l  WHERE l.nd = k.nd    AND  l.fdat = (SELECT MIN(fdat) FROM cc_lim  WHERE nd = l.nd   AND fdat >= fdat_ );
                UPDATE cc_sparam SET datg = datg_, sumg = sumg_ WHERE acc = a8.acc;
                IF SQL%ROWCOUNT = 0    THEN  INSERT INTO cc_sparam  (acc,datg,sumg) VALUES (a8.acc,datg_,sumg_); END IF ;
          EXCEPTION WHEN no_data_found THEN  UPDATE      cc_sparam   SET datg = NULL, sumg = NULL  WHERE acc = a8.acc   ;
          END;
       END IF; -- ibank_ = '1' 

       --   3.Переоц родит.сч при доч. в другой вал   Делаем  для VIDD 3,13 либо 2,12, если счетов SS несколько
       IF k.vidd IN (2, 3, 12, 13) THEN
          SELECT COUNT(*) INTO l_cnt  FROM accounts  WHERE accc = a8.acc AND kv <> a8.kv;
          IF   l_cnt > 0  THEN cck.rate_lim(a8.acc); END IF;
       END IF;
 
       --   4. Отметки в ГПК о вып.платежей
       SELECT nvl(SUM(kos - dos), 0)  INTO s1_  FROM saldoa  WHERE acc = a8.acc  AND kos > dos   AND kos > 0; -- всего погашено по сумме
       SELECT nvl(SUM(sumg), 0)       INTO s2_  FROM cc_pog  WHERE nd = k.nd     AND otm = 1;                 -- всего погашено по ГПК 
       s1_ := s1_ - s2_ ; IF s1_ <= 0 THEN      GOTO kin_k ; END IF;

       ------- отметим погашенные ПЛАНОВЫЕ платежи до тек дня
       FOR p IN (SELECT sumg, fdat  FROM cc_pog WHERE nd = k.nd   AND fdat > k.sdate   AND fdat < gl.bdate   AND nvl(otm, 0) <> 1 ORDER BY fdat) 
       LOOP
          IF s1_ <= 0 OR s1_ < p.sumg THEN  s1_ := 0;  EXIT ;     END IF ;
          UPDATE cc_pog  SET otm = 1  WHERE nd = k.nd  AND fdat = p.fdat ;
          s1_ := s1_ - p.sumg;
       END LOOP;  -- p
       IF s1_ <= 0 THEN   GOTO kin_k ;  END IF;

       ------- отметим погашенные ДОСРОЧНЕ платежи от тек дня
       BEGIN SELECT substr(txt,1,1)  INTO  par1_   FROM nd_txt  WHERE nd = k.nd   AND tag = 'FLAGS';
       EXCEPTION  WHEN no_data_found THEN  par1_:= NULL;
       END;
       IF par1_ IS NULL THEN  par1_ := par_; END IF;
                                                   
       FOR p IN (SELECT sumg, fdat   FROM cc_pog   WHERE nd = k.nd AND fdat >= gl.bdate  AND nvl(otm, 0) <> 1 ORDER BY decode(par1_, '0', -1, +1) * (k.wdate - fdat)) 
       LOOP
          IF s1_ <= 0 OR s1_< p.sumg THEN s1_:= 0; EXIT;   END IF;
          UPDATE cc_pog  SET otm = 1 WHERE nd = k.nd  AND fdat = p.fdat;
          s1_ := s1_ - p.sumg;
       END LOOP;
       ---------------------------------
       <<kin_k>>  NULL;

    END LOOP;  -- k

    -- 5. Установка плановых пролонгаций КД
    cck.cc_prolong(0, fdat_);

  END cc_day_lim;
  -------------------

  PROCEDURE rate_lim(acc8_ INT) IS
    -- Переоценка остатка родительского счета при дочерних в другой валюте
    kv_   INT;
    ostc_ NUMBER;
    sd_   NUMBER := 0;
    se_   NUMBER := 0;
  BEGIN
    SELECT kv, ostc INTO kv_, ostc_ FROM accounts WHERE acc = acc8_;

    logger.trace('CCK.RATE_LIM gl.bdate=' || to_char(gl.bdate) ||
                 ' sysdate=' || to_char(SYSDATE));

    FOR s IN (SELECT kv, ostc
                FROM accounts
               WHERE accc = acc8_
                 AND ostc <> 0) LOOP
      IF kv_ <> s.kv THEN
        IF s.kv <> gl.baseval THEN
          se_ := gl.p_icurval(s.kv, s.ostc, gl.bdate);
        ELSE
          se_ := s.ostc;
        END IF;
        IF kv_ <> gl.baseval THEN
          sd_ := sd_ + gl.p_ncurval(kv_, se_, gl.bdate);
        ELSE
          sd_ := sd_ + se_;
        END IF;
      ELSE
        sd_ := sd_ + s.ostc;
      END IF;
    END LOOP;

    IF ostc_ <> sd_ THEN
      UPDATE accounts SET ostc = sd_, ostb = sd_ WHERE acc = acc8_;
    END IF;

  EXCEPTION
    WHEN no_data_found THEN
      sd_ := NULL;
  END rate_lim;

  ---------------------
  PROCEDURE cc_9129(fdat_ DATE, nd_ INT, tip_ INT) IS
  
    -- TIP_ = 0 - все КП  -- TIP_ = 2 - все КП ЮЛ  -- TIP_ = 3 - все КП ФЛ
  
    fl_opl_ INT;
    sd_     NUMBER;
    x8_     NUMBER;
    I_CR9   char(1);
    acc9_   INT;
    ref_    INT;
    dk_     INT;
    dazs9_  DATE;
    nls9_   tts.nlsm%TYPE;
    nms9_   VARCHAR2(38);
    nazn_   oper.nazn%TYPE;
    nls99_  tts.nlsa%TYPE;
    nms99_  VARCHAR2(38);
    okpo_b  oper.id_b%TYPE;
    d9129_  NUMBER;
  
    vob_   INT := 6;
    vob_pr INT := 6;
    vob_rs INT := 6;
    r013_  INT;
  
    l_limt      NUMBER; -- текущий лимит из ГЛК
    l_dos       NUMBER; -- сумма всех выдач (ДТ оборотов) с начала жизни
    l_ost_fakt  NUMBER; -- текущий остаток 9129
    l_ost_plan  NUMBER; -- ожидаемый остаток 9129
    l_limb      NUMBER; -- первоначальный лимит из ГЛК
    l_kol       INT := 0;
    n_commit    INT := 100;
    i_commit    INT := 0;
    l_ref_check number;
    v_block_flag integer;
  BEGIN
    -- Проводки по 9129
  
    BEGIN
      -- есть ли карточка операции и контрсчет ?
      SELECT nlsa, nlsm, substr(flags, 38, 1)
        INTO nls99_, nls9_, fl_opl_
        FROM tts
       WHERE tt = 'CR9';
      IF nls9_ IS NOT NULL THEN
        UPDATE tts SET nlsa = nls9_, nlsm = NULL WHERE tt = 'CR9';
        nls99_ := nls9_;
      END IF; -- и модиф.карточку оп на будущее
      IF substr(nls99_, 1, 2) = '#(' THEN
        EXECUTE IMMEDIATE 'SELECT ' ||
                          substr(nls99_, 3, length(nls99_) - 3) ||
                          ' FROM DUAL'
          INTO nls99_;
      END IF; -- Шаг 2 если введена формула
      IF nls99_ IS NULL THEN
        nls99_ := substr(tobopack.gettoboparam('NLS_9900'), 1, 15);
      END IF; -- Шаг 3 если формула не введена то поисчем самостоятельно
    
      SELECT substr(a.nms, 1, 38), c.okpo
        INTO nms99_, okpo_b
        FROM accounts a, customer c
       WHERE a.kv = 980
         AND a.nls = nls99_
         AND c.rnk = a.rnk;
    
    EXCEPTION
      WHEN no_data_found THEN
        raise_application_error(- (20203),
                                '\9351 - CCK.CC_9129 : ош в карточке оп.CR9',
                                TRUE);
    END;
  
    BEGIN
      SELECT vob
        INTO vob_
        FROM tts_vob
       WHERE tt = 'CR9'
         AND ord IS NULL
         AND rownum = 1;
    EXCEPTION
      WHEN no_data_found THEN
        NULL;
    END;
    BEGIN
      SELECT vob
        INTO vob_pr
        FROM tts_vob
       WHERE tt = 'CR9'
         AND ord = 1;
    EXCEPTION
      WHEN no_data_found THEN
        NULL;
    END;
    BEGIN
      SELECT vob
        INTO vob_rs
        FROM tts_vob
       WHERE tt = 'CR9'
         AND ord = 2;
    EXCEPTION
      WHEN no_data_found THEN
        NULL;
    END;
  
    --курсор по всем лимитам КП
    FOR k IN (SELECT d.nd,
                     d.vidd,
                     d.sdate,
                     d.wdate,
                     d.cc_id,
                     c.nmk,
                     d.branch,
                     ad.kv,
                     l.acc acc8,
                     c.okpo,
                     ad.wdate dat_beg,
                     nvl(ad.ssuda, 0) ssuda,
                     d.NDG,
                     d.sdog * 100 lim_beg --первоначальный лимит
                FROM cc_deal d,
                     cc_add ad,
                     customer c,
                     (select n.nd, a.acc from nd_acc n, accounts a where n.acc = a.acc and a.tip = 'LIM') l
               WHERE d.nd = ad.nd
                 AND ad.adds = 0
                 and d.nd = l.nd
                 AND (nd_ = 0 OR d.nd = nd_)
                 AND d.sos < 14
                 AND sos <> 0
                 AND d.rnk = c.rnk
                 AND d.sdate <= fdat_
                 AND (tip_ IN (1, 2) AND d.vidd IN (1, 2, 3) OR
                     tip_ = 3 AND d.vidd IN (11, 12, 13) OR tip_ = 0)) LOOP
      If k.NDG is not null and k.NDG <> k.ND then
        goto kin_;
      end if; -- это подчитенные суб.дог. Они не имеют своего 9129
    
      -- невiдновлювана КЛ   I_CR9 = '1'
      BEGIN
        SELECT a9.acc,
               a9.nls,
               substr(a9.nms, 1, 38),
               a9.dazs,
               s.r013,
               -fost(a9.acc, fdat_), -- текущий остаток 9129
               substr(TRIM(cck_app.get_nd_txt(k.nd, 'I_CR9')), 1, 1),
               nvl(cck_app.to_number2(cck_app.get_nd_txt(k.nd, 'D9129')), 0)
          INTO acc9_,
               nls9_,
               nms9_,
               dazs9_,
               r013_,
               l_ost_fakt,
               I_CR9,
               d9129_
          FROM nd_acc n, accounts a9, specparam s
         WHERE a9.dazs IS NULL
           AND n.acc = a9.acc
           AND n.nd = k.nd
           AND a9.tip = 'CR9'
           AND a9.kv = k.kv
           AND rownum = 1
           AND a9.acc = s.acc
           AND a9.ostc = a9.ostb;
        IF NOT (dazs9_ IS NULL OR dazs9_ > fdat_) THEN
          GOTO kin_;
        END IF;
      EXCEPTION
        WHEN no_data_found THEN
          GOTO kin_;
      END;
      ---------------------------------------------------------------------
      l_dos  := 0;
      l_limb := k.lim_beg + d9129_; -- лимит начальный с учетом дельты
    
      -- лимит на дату FDAT_ с учетом дельты
      BEGIN
        SELECT lim2 + d9129_
          INTO l_limt
          FROM cc_lim
         WHERE nd = k.nd
           AND nvl(not_9129, 0) = 0
           AND fdat = (SELECT MAX(fdat)
                         FROM cc_lim
                        WHERE nd = k.nd
                          AND fdat <= fdat_
                          AND nvl(not_9129, 0) = 0);
      EXCEPTION
        WHEN no_data_found THEN
          l_limt := l_limb; -- берем просто первый с учетом дельты
      END;
    
      IF I_CR9 = '1' THEN
        --------------------------- HEвiдновлювана кредитна лiнiя
        If k.NDG is null then
          SELECT nvl(SUM(gl.p_ncurval(k.kv,
                                      gl.p_icurval(a.kv,
                                                   fdos(a.acc, a.daos, fdat_),
                                                   fdat_),
                                      fdat_)),
                     0) -- весь ДТ в начала жизни
            INTO l_dos
            FROM nd_acc n, accounts a
           WHERE n.nd = k.nd
             AND n.acc = a.acc
             AND a.tip = 'SS ';
        else
          SELECT nvl(SUM(gl.p_ncurval(k.kv,
                                      gl.p_icurval(a.kv,
                                                   fdos(a.acc, a.daos, fdat_),
                                                   fdat_),
                                      fdat_)),
                     0) -- весь ДТ c начала жизни
            INTO l_dos
            FROM nd_acc n, accounts a, cc_deal d
           WHERE d.nd = n.nd
             AND n.acc = a.acc
             AND a.tip = 'SS '
             and d.ndg = k.nd;
        end if;
        l_ost_plan := least(greatest(l_limb - l_dos, 0),
                            greatest(l_limt - (-fost(k.acc8, fdat_)), 0)); ---- Ожидаемый остаток на 9129
      ELSE
        l_ost_plan := l_limt - (-fost(k.acc8, fdat_)); ---- вiдновлювана кредитна лiнiя
      END IF;
    
      l_ost_plan := greatest(l_ost_plan, 0);
      IF k.wdate <= fdat_ THEN
        l_ost_plan := 0;
      END IF; -- если дата в прошлом - то обнуление лимита;
      sd_ := l_ost_fakt - l_ost_plan;
      IF nvl(sd_, 0) = 0 THEN
        GOTO kin_;
      END IF; -- определение дельты и ее проплата по факту
      ----------------------------------
      IF sd_ < 0 THEN
        dk_  := 1;
        vob_ := vob_pr;
        sd_  := -sd_;
      ELSE
        dk_  := 0;
        vob_ := vob_rs;
      END IF;

      select case dk_
               when 1 then blkd
               when 0 then blkk
               else null
             end
        into v_block_flag
        from accounts
        where nls = nls9_
          and kv = k.kv;
          
      if v_block_flag >0 then 
        bars_audit.info('CCK.CC_9129: Вирівнювання неможливе, рахунок '||nls9_||' блокований на '||case dk_ when 1 then 'дебетування' when 0 then 'кредитування' end||'!');
        continue;
      end if;        

    
      nazn_ := 'Невикористаний лiмiт кредитної угоди № ' || k.cc_id ||
               ' вiд ' || to_char(k.sdate, 'DD.MM.YYYY');
    
      --savepoint DO_PROVODKI;
      --begin
      gl.ref(ref_);
      l_ref_check := length(ref_);
      IF nvl(g_reports, 0) = 0 THEN
        if l_ref_check > 10 then
          gl.in_doc3(ref_   => ref_,
                     tt_    => 'CR9',
                     vob_   => vob_,
                     nd_    => substr(to_char(ref_), 1, 10),
                     vdat_  => gl.bdate,
                     dk_    => dk_,
                     kv_    => k.kv,
                     s_     => sd_,
                     kv2_   => k.kv,
                     s2_    => sd_,
                     sk_    => NULL,
                     data_  => gl.bdate,
                     datp_  => gl.bdate,
                     nam_a_ => nms9_,
                     nlsa_  => nls9_,
                     mfoa_  => gl.amfo,
                     nam_b_ => nms99_,
                     nlsb_  => nls99_,
                     mfob_  => gl.amfo,
                     nazn_  => nazn_,
                     d_rec_ => NULL,
                     id_a_  => k.okpo,
                     id_b_  => okpo_b,
                     id_o_  => NULL,
                     sign_  => NULL,
                     sos_   => 0,
                     prty_  => NULL);
        else
          gl.in_doc3(ref_   => ref_,
                     tt_    => 'CR9',
                     vob_   => vob_,
                     nd_    => substr(to_char(ref_), 1, 10),
                     vdat_  => gl.bdate,
                     dk_    => dk_,
                     kv_    => k.kv,
                     s_     => sd_,
                     kv2_   => k.kv,
                     s2_    => sd_,
                     sk_    => NULL,
                     data_  => gl.bdate,
                     datp_  => gl.bdate,
                     nam_a_ => nms9_,
                     nlsa_  => nls9_,
                     mfoa_  => gl.amfo,
                     nam_b_ => nms99_,
                     nlsb_  => nls99_,
                     mfob_  => gl.amfo,
                     nazn_  => nazn_,
                     d_rec_ => NULL,
                     id_a_  => k.okpo,
                     id_b_  => okpo_b,
                     id_o_  => NULL,
                     sign_  => NULL,
                     sos_   => 0,
                     prty_  => NULL);
        end if;
        gl.payv(fl_opl_,
                ref_,
                gl.bdate,
                'CR9',
                dk_,
                k.kv,
                nls9_,
                sd_,
                k.kv,
                nls99_,
                sd_);
      ELSE
        INSERT INTO bars.v_cck_rep
          (branch,
           tt,
           vob,
           vdat,
           kv,
           dk,
           s,
           nam_a,
           nlsa,
           mfoa,
           nam_b,
           nlsb,
           mfob,
           nazn,
           s2,
           kv2,
           sq2,
           nd,
           cc_id,
           sdate,
           nmk)
        VALUES
          (k.branch,
           'CR9',
           vob_,
           gl.bdate,
           k.kv,
           dk_,
           sd_ / 100,
           nms9_,
           nls9_,
           gl.amfo,
           nms99_,
           nls99_,
           gl.amfo,
           nazn_,
           sd_ / 100,
           k.kv,
           NULL,
           k.nd,
           k.cc_id,
           k.sdate,
           k.nmk);
      END IF;
    
      IF i_commit >= n_commit AND nvl(g_reports, 0) = 0 THEN
        COMMIT;
        l_kol    := l_kol + i_commit;
        i_commit := 0;
      END IF;
    
      <<kin_>>
      NULL;
    END LOOP; --- k
  
    COMMIT;
  
  END cc_9129;

  -------------------
  PROCEDURE cc_9031(fdat_ DATE, nd_ INT, tip_ INT) IS

    -- Проводки по 9031 на сумму начального лимита по договору

    -- TIP_ = 0 - все КП
    -- TIP_ = 2 - все КП ЮЛ
    -- TIP_ = 3 - все КП ФЛ

    fl_opl_ INT;
    nls99_  VARCHAR2(15);
    nls9_   VARCHAR2(15);
    nms99_  VARCHAR2(38);
    okpo_b  VARCHAR2(14);
    nazn_   VARCHAR2(160);
    vob_    INT;
    vob_pr  INT;
    vob_rs  INT;
    par_    VARCHAR2(1);

    x8_    NUMBER;
    acc9_  INT;
    ref_   INT;
    dazs9_ DATE;
    nms9_  VARCHAR2(38);

  BEGIN
    BEGIN
      SELECT substr(val, 1, 1)
        INTO par_
        FROM params
       WHERE par = 'CC_9031'
         AND val = '1';
      --есть ли карточка операции и контрсчет ?
      BEGIN
        -- Контрсч для CR9 берем из tts.NLSa (было из NLSm) и модиф.карточку оп на будущее
        SELECT nlsa, nlsm, substr(flags, 38, 1)
          INTO nls99_, nls9_, fl_opl_
          FROM tts
         WHERE tt = 'CR9';

        IF nls9_ IS NOT NULL THEN
          UPDATE tts SET nlsa = nls9_, nlsm = NULL WHERE tt = 'CR9';
          nls99_ := nls9_;
        END IF;

        SELECT substr(a.nms, 1, 38), c.okpo
          INTO nms99_, okpo_b
          FROM accounts a, customer c
         WHERE a.kv = 980
           AND a.nls = nls99_
           AND c.rnk = a.rnk;

      EXCEPTION
        WHEN no_data_found THEN
          RETURN;
          --отсутств. или плох оп CR9
      END;

      BEGIN
        SELECT vob
          INTO vob_
          FROM tts_vob
         WHERE tt = 'CR9'
           AND ord IS NULL
           AND rownum = 1;
      EXCEPTION
        WHEN no_data_found THEN
          vob_ := 6;
      END;

      BEGIN
        --курсор по всем лимитам КП
        FOR k IN (SELECT d.nd,
                         a.acc    accs,
                         d.vidd,
                         d.sdate,
                         d.wdate,
                         d.cc_id,
                         ad.kv,
                         l.acc    acc8,
                         c.okpo,
                         ad.wdate dat_beg
                    FROM cc_deal d,
                         cc_add ad,
                         accounts a,
                         customer c,
                         (SELECT nd, acc FROM cc_lim GROUP BY nd, acc) l
                   WHERE d.nd = ad.nd
                     AND ad.adds = 0
                     AND ad.accs = a.acc
                     AND a.ostc = a.ostb
                     AND d.nd = l.nd
                     AND (nd_ = 0 OR d.nd = nd_)
                     AND d.sos < 14
                     AND sos <> 0
                     AND d.rnk = c.rnk
                     AND a.daos <= fdat_
                     AND (tip_ = 2 AND d.vidd IN (1, 2, 3) OR
                         tip_ = 3 AND d.vidd IN (11, 12, 13) OR tip_ = 0)) LOOP
          BEGIN
            SELECT a9.acc, a9.nls, substr(a9.nms, 1, 38), a9.dazs
              INTO acc9_, nls9_, nms9_, dazs9_
              FROM nd_acc n, accounts a9
             WHERE a9.dazs IS NULL
               AND n.acc = a9.acc
               AND n.nd = k.nd
               AND a9.tip = 'ZZI'
               AND a9.kv = k.kv
               AND rownum = 1
               AND a9.ostc = a9.ostb;

            --начальный лимит по договору
            SELECT l.lim2
              INTO x8_
              FROM cc_lim l
             WHERE l.nd = k.nd
               AND l.acc = k.acc8
               AND (k.nd, l.fdat) = (SELECT nd, MIN(fdat)
                                       FROM cc_lim
                                      WHERE acc = k.acc8
                                        AND nd = k.nd
                                      GROUP BY nd);
            --  EXCEPTION WHEN NO_DATA_FOUND THEN  null;
          END;

          nazn_ := 'Встановлення суми порук згiдно';
          SAVEPOINT do_provodki;
          BEGIN
            gl.ref(ref_);
            INSERT INTO oper
              (REF,
               nd,
               tt,
               vob,
               dk,
               pdat,
               vdat,
               datd,
               datp,
               s,
               s2,
               nam_a,
               nlsa,
               mfoa,
               kv,
               nam_b,
               nlsb,
               mfob,
               kv2,
               nazn,
               userid,
               id_a,
               id_b)
            VALUES
              (ref_,
               ref_,
               'CR9',
               vob_,
               0,
               SYSDATE,
               gl.bdate,
               gl.bdate,
               gl.bdate,
               x8_,
               x8_,
               nms9_,
               nls9_,
               gl.amfo,
               k.kv,
               nms99_,
               nls99_,
               gl.amfo,
               k.kv,
               nazn_ || 'угоди N' || k.cc_id || ' вiд ' ||
               to_char(k.sdate, 'DD-MM-YYYY'),
               user_id,
               k.okpo,
               okpo_b);
            gl.payv(fl_opl_,
                    ref_,
                    gl.bdate,
                    'CR9',
                    0,
                    k.kv,
                    nls9_,
                    x8_,
                    k.kv,
                    nls99_,
                    x8_);
          EXCEPTION
            WHEN OTHERS THEN
              ROLLBACK TO do_provodki;
          END;
        END LOOP;
      END;
      COMMIT;
    EXCEPTION
      WHEN no_data_found THEN
        NULL;
    END;
  END cc_9031;
  -------------------
  PROCEDURE cc_close9031(fdat_ DATE, nd_ INT, tip_ INT) IS

    -- Снятие с 9031

    -- TIP_ = 0 - все КП
    -- TIP_ = 2 - все КП ЮЛ
    -- TIP_ = 3 - все КП ФЛ

    fl_opl_ INT;
    nls99_  VARCHAR2(15);
    nls9_   VARCHAR2(15);
    nms99_  VARCHAR2(38);
    okpo_b  VARCHAR2(14);
    nazn_   VARCHAR2(160);
    vob_    INT;
    vob_pr  INT;
    vob_rs  INT;
    par_    VARCHAR2(1);

    x8_    NUMBER;
    acc9_  INT;
    ref_   INT;
    dazs9_ DATE;
    nms9_  VARCHAR2(38);

  BEGIN
    BEGIN
      SELECT substr(val, 1, 1)
        INTO par_
        FROM params
       WHERE par = 'CC_9031'
         AND val = '1';
      --есть ли карточка операции и контрсчет ?
      BEGIN
        -- Контрсч для CR9 берем из tts.NLSa (было из NLSm) и модиф.карточку оп на будущее
        SELECT nlsa, nlsm, substr(flags, 38, 1)
          INTO nls99_, nls9_, fl_opl_
          FROM tts
         WHERE tt = 'CR9';

        IF nls9_ IS NOT NULL THEN
          UPDATE tts SET nlsa = nls9_, nlsm = NULL WHERE tt = 'CR9';
          nls99_ := nls9_;
        END IF;

        SELECT substr(a.nms, 1, 38), c.okpo
          INTO nms99_, okpo_b
          FROM accounts a, customer c
         WHERE a.kv = 980
           AND a.nls = nls99_
           AND c.rnk = a.rnk;

      EXCEPTION
        WHEN no_data_found THEN
          RETURN;
          --отсутств. или плох оп CR9
      END;

      BEGIN
        SELECT vob
          INTO vob_
          FROM tts_vob
         WHERE tt = 'CR9'
           AND ord IS NULL
           AND rownum = 1;
      EXCEPTION
        WHEN no_data_found THEN
          vob_ := 6;
      END;

      --begin
      --   select vob into VOB_PR from tts_vob where tt='CR9' and ord=1;
      --EXCEPTION WHEN NO_DATA_FOUND THEN  VOB_PR:=VOB_;
      --end;

      --begin
      --   select vob into VOB_RS from tts_vob where tt='CR9' and ord=2;
      --EXCEPTION WHEN NO_DATA_FOUND THEN  VOB_RS:=VOB_;
      --end;

      BEGIN
        --курсор по всем лимитам КП
        FOR k IN (SELECT c.nd, d.kv, c.sdate, u.okpo, c.cc_id
                    FROM cc_deal  c,
                         accounts a,
                         nd_acc   n,
                         cc_add   d,
                         customer u
                   WHERE c.nd = n.nd
                     AND n.acc = a.acc
                     AND a.tip = 'ZZI'
                     AND (a.dazs IS NULL OR a.dazs > fdat_)
                     AND a.ostc <> 0
                     AND c.nd = d.nd
                     AND (nd_ = 0 OR c.nd = nd_)
                     AND c.sos < 14
                     AND c.sos <> 0
                     AND a.daos <= fdat_
                     AND (tip_ = 3 AND c.vidd IN (11, 12, 13) OR tip_ = 0)
                     AND c.rnk = u.rnk) LOOP
          BEGIN
            SELECT a9.acc, a9.nls, substr(a9.nms, 1, 38), a9.dazs, a9.ostc
              INTO acc9_, nls9_, nms9_, dazs9_, x8_
              FROM nd_acc n, accounts a9
             WHERE a9.dazs IS NULL
               AND n.acc = a9.acc
               AND n.nd = k.nd
               AND a9.tip = 'ZZI'
               AND a9.kv = k.kv
               AND rownum = 1
               AND a9.ostc = a9.ostb;
          END;

          nazn_ := 'Зняття суми порук згiдно';
          SAVEPOINT do_provodki;
          BEGIN
            gl.ref(ref_);
            INSERT INTO oper
              (REF,
               nd,
               tt,
               vob,
               dk,
               pdat,
               vdat,
               datd,
               datp,
               s,
               s2,
               nam_a,
               nlsa,
               mfoa,
               kv,
               nam_b,
               nlsb,
               mfob,
               kv2,
               nazn,
               userid,
               id_a,
               id_b)
            VALUES
              (ref_,
               ref_,
               'CR9',
               vob_,
               1,
               SYSDATE,
               gl.bdate,
               gl.bdate,
               gl.bdate,
               x8_,
               x8_,
               nms9_,
               nls9_,
               gl.amfo,
               k.kv,
               nms99_,
               nls99_,
               gl.amfo,
               k.kv,
               nazn_ || 'угоди N' || k.cc_id || ' вiд ' ||
               to_char(k.sdate, 'DD-MM-YYYY'),
               user_id,
               k.okpo,
               okpo_b);
            gl.payv(fl_opl_,
                    ref_,
                    gl.bdate,
                    'CR9',
                    0,
                    k.kv,
                    nls9_,
                    x8_,
                    k.kv,
                    nls99_,
                    x8_);
          EXCEPTION
            WHEN OTHERS THEN
              ROLLBACK TO do_provodki;
          END;
        END LOOP;
      END;
      COMMIT;
    EXCEPTION
      WHEN no_data_found THEN
        NULL;
    END;
  END cc_close9031;
  ---------------------------------

  PROCEDURE cc_grf_lim(mode_ INT default 1,
                       nd_   cc_deal.nd%type,
                       acc_  accounts.acc%type,
                       fdap_ DATE default gl.bdate) IS

    -- Построение графика лимитов.

    lim2_   NUMBER; -- сумма лимита на дату FDAT_
    dat4_   DATE; -- дата погашения
    del2_   NUMBER; -- промежуточная дельта уменшения
    kol2_   INT; -- кол периодовж
    freq_   INT; -- периодичность гашения договора
    dati_   DATE; -- пред.дата изменения лимита
    datj_   DATE; -- след.дата изменения лимита
    dtmp_   DATE;
    fdat_   DATE; -- реальная дата начала построения
    day_pog INT; -- День погашения
    l_daynp INT; -- урегулирование сдвига ДНЯ погашения
    l_acc_  INT;
  BEGIN
    -----------------1 пока только равными долями
    BEGIN
      /* bars_audit.info('cck.CC_grf_LIM MODE_' || mode_ || ' ,ND_=' || nd_ ||
      ' ,ACC_' || l_acc_ || ' ,FDAP_' || fdap_);*/
      SELECT nvl(d.wdate, add_months(gl.bdate, 12)),
             a.freq,
             cck_app.to_number2(cck_app.get_nd_txt(nd_, 'DAYNP'))
      ----------(select to_number(txt) from nd_txt where TAG='DAYNP' and nd=d.nd)
        INTO dat4_, freq_, l_daynp
        FROM cc_deal d, cc_add a
       WHERE d.nd = nd_
         AND a.nd = d.nd
         AND a.adds = 0;

      --пoследний лимит, последняя в графике дата c суммой
      SELECT lim2, greatest(fdat, fdap_)
        INTO lim2_, fdat_
        FROM cc_lim l
       WHERE l.nd = nd_
         AND (l.nd, l.fdat) = (SELECT nd, MAX(fdat)
                                 FROM cc_lim
                                WHERE nd = l.nd
                                  AND fdat < dat4_
                                GROUP BY nd);
      DELETE FROM cc_lim
       WHERE nd = nd_
         AND fdat > fdap_;
    EXCEPTION
      WHEN no_data_found THEN
        erm := '8999 - ош. параметры';
        RAISE err;
    END;

    kol2_ := 1;
    BEGIN
      SELECT fdat
        INTO datj_
        FROM cc_lim
       WHERE nd = nd_
         AND fdat = fdap_;
    EXCEPTION
      WHEN no_data_found THEN
        INSERT INTO cc_lim
          (nd, acc, fdat, lim2, sumg, sumo)
        VALUES
          (nd_, l_acc_, fdap_, lim2_, 0, 0);
    END;
    datj_ := fdat_;
    dati_ := fdat_;
    IF freq_ IN (1, 3, 5, 7, 180, 360) THEN

      BEGIN
        SELECT nvl(trunc(i.s), to_char(fdat_, 'dd')), a.acc
          INTO day_pog, l_acc_
          FROM nd_acc n, accounts a, int_accn i
         WHERE n.nd = nd_
           AND n.acc = a.acc
           AND a.acc = i.acc
           AND a.tip = 'LIM'
           AND i.id = 0;
      EXCEPTION
        WHEN no_data_found THEN
          day_pog := to_char(fdat_, 'dd');
      END;
      IF day_pog > 32 OR day_pog < 1 THEN
        day_pog := to_char(fdat_, 'dd');
      END IF;

      WHILE datj_ < dat4_ LOOP
        IF freq_ = 1 THEN
          datj_ := datj_ + 1;
        ELSIF freq_ = 3 THEN
          datj_ := cck_app.correctdate2(gl.baseval, datj_ + 7, l_daynp);
        ELSIF freq_ = 5 THEN
          datj_ := cck_app.check_max_day(add_months(fdat_, kol2_),
                                         day_pog,
                                         l_daynp,
                                         gl.baseval);
        ELSIF freq_ = 7 THEN
          datj_ := cck_app.check_max_day(add_months(fdat_, 3 * kol2_),
                                         day_pog,
                                         l_daynp,
                                         gl.baseval);
        ELSIF freq_ = 180 THEN
          datj_ := cck_app.check_max_day(add_months(fdat_, 6 * kol2_),
                                         day_pog,
                                         l_daynp,
                                         gl.baseval);
        ELSIF freq_ = 360 THEN
          datj_ := cck_app.check_max_day(add_months(fdat_, 12 * kol2_),
                                         day_pog,
                                         l_daynp,
                                         gl.baseval);
        END IF;

        l_acc_ := nvl(acc_, l_acc_);

        IF datj_ < dat4_ THEN
          INSERT INTO cc_lim (nd, fdat, acc) VALUES (nd_, datj_, l_acc_);
          kol2_ := kol2_ + 1;
          dati_ := datj_;
        END IF;
      END LOOP;
    END IF;
    INSERT INTO cc_lim
      (nd, fdat, acc, lim2, sumg, sumo)
    VALUES
      (nd_, dat4_, l_acc_, 0, 0, 0);

    IF kol2_ > 0 THEN
      del2_ := round(lim2_ / kol2_, 0);
      kol2_ := 0;
      FOR k IN (SELECT fdat
                  FROM cc_lim
                 WHERE nd = nd_
                   AND fdat >= fdat_
                 ORDER BY fdat) LOOP
        UPDATE cc_lim
           SET lim2 = decode(k.fdat, dat4_, 0, lim2_ - (del2_ * kol2_))
         WHERE nd = nd_
           AND fdat = k.fdat;
        kol2_ := kol2_ + 1;
      END LOOP;
    END IF;

    BEGIN
      SELECT lim2
        INTO lim2_
        FROM cc_lim
       WHERE fdat = gl.bdate
         AND nd = nd_;
      UPDATE accounts SET ostx = -lim2_ WHERE acc = l_acc_;
      UPDATE cc_deal SET LIMIT = round(lim2_ / 100, 0) WHERE nd = nd_;
    EXCEPTION
      WHEN no_data_found THEN
        lim2_ := 0;
    END;

    --cck.cc_lim_gpk(nd_, l_acc_, fdap_);
    --cck_ui.glk_bal(NULL, NULL);
    EXECUTE IMMEDIATE  'begin cck_ui.glk_bal(NULL, NULL); end;'   ;

  EXCEPTION
    WHEN err THEN
      raise_application_error(- (20000 + ern), '\ ' || erm, TRUE);
  END cc_grf_lim;
  ---------------------------
  PROCEDURE cc_gpk0(mode_   INT,
                    nd_0    INT,
                    acc_0   INT,
                    dat3_   DATE,
                    datn_   DATE,
                    dat4_   DATE,
                    sumr_   NUMBER,
                    freq_   INT,
                    rate_   NUMBER,
                    nbasey_ INT,
                    dig_    INT) IS
  BEGIN
    DELETE FROM int_ratn
     WHERE acc = acc_0
       AND id = 0;
    DELETE FROM accounts_update WHERE acc = acc_0;
    DELETE FROM saldoa WHERE acc = acc_0;
    DELETE FROM cc_lim
     WHERE acc = acc_0
       AND nd = nd_0;
    UPDATE accounts
       SET ostx = -sumr_ * 100, mdate = dat4_
     WHERE acc = acc_0;
    UPDATE int_accn
       SET basey = nbasey_, freq = freq_, s = 0
     WHERE acc = acc_0
       AND id = 0;
    INSERT INTO int_ratn
      (acc, id, bdat, ir)
    VALUES
      (acc_0, 0, dat3_, rate_);
    UPDATE cc_deal
       SET sdate = dat3_, wdate = dat4_, LIMIT = sumr_
     WHERE nd = nd_0;
    UPDATE cc_add
       SET s = sumr_, bdate = dat3_, wdate = dat3_, freq = freq_
     WHERE nd = nd_0
       AND adds = 0;

    cck.cc_lim_null(p_nd => nd_0);

  END cc_gpk0;
  ----------------

  ---начало --14.06.2013 -----------------
  FUNCTION f_dat(p_dd   NUMBER, -- <Платежный день>, по умол =(Null) DD от текущего банк.дня
                 p_dat1 DATE) RETURN DATE IS

    -- ОПРЕДЕЛЕНИЕ ДАТЫ В МЕС ПО НОМЕРУ ДНЯ

    l_dd NUMBER := nvl(p_dd, to_number(to_char(gl.bdate, 'dd')));

    l_dat DATE;
    l_mm  INT := to_number(to_char(p_dat1, 'MM'));
  BEGIN
    IF l_dd > 28 AND l_mm IN (2) THEN
      l_dat := last_day(p_dat1);
    ELSIF l_dd > 30 AND l_mm IN (4, 6, 9, 11) THEN
      l_dat := last_day(p_dat1);
    ELSE
      l_dat := p_dat1 + l_dd - 1;
    END IF;
    RETURN l_dat;
  END f_dat;

  -----14.06.2013 + 29.08.2014 + 12-05-2015 --------
  FUNCTION f_pl1(p_nd   NUMBER,
                 p_lim2 NUMBER, -- новый лимит
                 p_gpk  NUMBER, -- 4-Ануитет. 2 - Класс ( -- 1-Ануитет. 0 - Класс   )
                 p_dd   NUMBER, -- <Платежный день>, по умол =(Null) DD от текущего банк.дня
                 p_datn DATE, -- дата нач КД
                 p_datk DATE, -- дата конца КД
                 p_ir   NUMBER, -- проц.ставка
                 p_ssr  NUMBER -- признак =0 или Null = "с сохранением срока"
                ,
                 p_dig  NUMBER DEFAULT 0) RETURN NUMBER IS
    -- ОПРЕДЕЛЕНИЕ сумми 1-го пл

    kol_   INT := 1;
    pdat_  DATE;
    ntmp_  NUMBER;
    sum1_  NUMBER;
    l_kk   NUMBER := to_number(to_char(p_datk, 'dd')); -- номер дня последний
    l_dd   NUMBER := nvl(p_dd, to_number(to_char(gl.bdate, 'dd'))); -- Номер дня платежный
    l_bb   NUMBER := to_number(to_char(gl.bdate, 'dd')); -- номер дня банковский
    l_ssr  NUMBER := nvl(p_ssr, 0);
    cl     cc_lim%ROWTYPE;
    b_date DATE;
  BEGIN
    /* bars_audit.info('CCK.f_pl1 p_nd =' || p_nd || ', p_lim2=' || p_lim2 ||

    ' ,p_gpk=' || p_gpk || ' ,p_dd=' || p_dd ||
    ' ,p_datn=' || p_datn || ' ,p_datk=' || p_datk ||
    ' ,p_ir=' || p_ir || ' ,p_ssr=' || p_ssr ); */
    IF l_ssr = 0 THEN
      -------- CCK_DPK.K3_= 0  Зi збереженням термiну

      IF p_gpk = 4 THEN
        -- -- ануитет

        --первая пл дата = Начало первого месяца
        ------- PDAT_ := CCK.f_dat (L_DD, TRUNC(         gl.bdate,         'MM'));------- 21.08.2015
        b_date := greatest(gl.bdate, p_datn);

        pdat_ := cck.f_dat(l_dd, trunc(b_date, 'MM'));
        kol_  := 1;
        IF pdat_ <= b_date THEN
          pdat_ := add_months(pdat_, 1);
        END IF;
        WHILE 1 < 2 LOOP
          IF add_months(pdat_, 1) > p_datk THEN
            EXIT;
          END IF;
          kol_ := kol_ + 1;
          IF add_months(pdat_, 2) > p_datk THEN
            EXIT;
          END IF;
          pdat_ := add_months(pdat_, 1);
        END LOOP;
        sum1_ := -round(cck.pmt1((p_ir / 100) / 12, kol_, p_lim2, 0), p_dig); -- ануитет

      ELSE
        kol_ := months_between(trunc(p_datk, 'MM'), trunc(p_datn, 'MM'));

        sum1_ := round(p_lim2 / (kol_), p_dig);
      END IF;

    ELSIF p_nd > 0 THEN
      -------- CCK_DPK.K3_= 1  Зi збереженням суми 1-го платежу

      -- !!! Важно для более одной досрочки в течепнии одного мес

      SELECT MIN(fdat)
        INTO cl.fdat
        FROM cc_lim
       WHERE nd = p_nd
         AND fdat >= gl.bdate; -- ближайший будущий день с учетом тек дня.
      BEGIN
        SELECT *
          INTO cl
          FROM cc_lim
         WHERE nd = p_nd
           AND fdat = cl.fdat;
      EXCEPTION
        WHEN no_data_found THEN
          SELECT MAX(fdat)
            INTO cl.fdat
            FROM cc_lim
           WHERE nd = p_nd
             AND fdat < gl.bdate; -- ближайший прошлый день без учета тек.дня
          BEGIN
            SELECT *
              INTO cl
              FROM cc_lim
             WHERE nd = p_nd
               AND fdat = cl.fdat;
          EXCEPTION
            WHEN no_data_found THEN
              NULL;
          END;
      END;

      IF p_gpk = 4 THEN
        sum1_ := cl.sumo;
      ELSE
        sum1_ := cl.sumg;
      END IF;

    END IF;

    RETURN nvl(sum1_, 0);

  END f_pl1;

  -----14.06.2013 -----------------
  PROCEDURE uni_gpk_fl(p_lim2  NUMBER, -- новый лимит
                       p_gpk   NUMBER, -- 4-Ануитет. 2 - Класс    ( -- 1-Ануитет. 0 - Класс   )
                       p_dd    NUMBER, -- <Платежный день>, по умол =(Null) DD от текущего банк.дня
                       p_datn  DATE, -- дата нач КД
                       p_datk  DATE, -- дата конца КД
                       p_ir    NUMBER, -- проц.ставка
                       p_pl1   NUMBER, -- сумма 1 пл (Null - расчитать автоматически)
                       p_ssr   NUMBER, -- признак =0 ( Или Null) = "с сохранением срока"
                       p_ss    NUMBER, -- остаток по норм телу (0 или Null - для начальных ГПК)
                       p_acrd  DATE, -- с какой даты начислять % acr_dat+1 ( Null = p_datn)
                       p_basey NUMBER -- база для нач %%;
                       ) IS

    -- 14.06.2013 Sta универсальная процедура прстроения ГПК для ФЛ по постановке ОБ. Натуральный Ануитет.
    d1_         DATE := trunc(gl.bdate, 'MM');
    si_         NUMBER;
    sg_         NUMBER;
    so_         NUMBER;
    lim2_       NUMBER := p_lim2;
    lim1_       NUMBER;
    fdat1_      DATE := gl.bdate;
    si1_        NUMBER := 0;
    pdat1_      DATE := gl.bdate;
    pdat2_      DATE;
    flag_       INT := 1;
    l_dd        NUMBER := nvl(p_dd, to_number(to_char(gl.bdate, 'dd')));
    l_ssr       NUMBER := nvl(p_ssr, 0);
    l_pl1       NUMBER;
    l_datn      DATE := nvl(p_datn, gl.bdate); -- дата нач КД, -- дата нач КД
    l_gpk_begin DATE := greatest(nvl(p_datn, gl.bdate), gl.bdate);
  BEGIN

    /* bars_audit.info('CCK.uni_gpk_fl p_lim2 =' || p_lim2 || ', p_gpk=' || p_gpk ||

    ' ,p_dd=' || p_dd || ' ,p_datn=' || p_datn ||
    ' ,p_datk=' || p_datk || ' ,p_ir=' || p_ir ||
    ' ,p_pl1=' || p_pl1 || ' ,p_ss=' || p_ss ||
    ',p_acrd=' || p_acrd ||',p_basey=' || p_basey); */
    DELETE FROM tmp_gpk;
    -- первая строка
    -- insert into tmp_gpk(fdat, lim2, sumg,sumo,sumk) values (gl.bdate,lim2_,0,0,0);
    -- Taras Shedenko Первая строка должна быть датой начала КД
    INSERT INTO tmp_gpk
      (fdat, lim2, sumg, sumo, sumk)
    VALUES
      (l_gpk_begin, lim2_, 0, 0, 0);

    --------------------------------------
    -- ОПРЕДЕЛЕНИЕ сумми 1-го пл
    IF nvl(p_pl1, 0) = 0 THEN
      l_pl1 := cck.f_pl1(p_nd   => 0,
                         p_lim2 => p_lim2,
                         p_gpk  => p_gpk,
                         p_dd   => l_dd,
                         p_datn => p_datn,
                         p_datk => p_datk,
                         p_ir   => p_ir,
                         p_ssr  => 0,
                         p_dig  => 0);
    ELSE
      l_pl1 := p_pl1;
    END IF;
    -------------------------
    IF p_gpk = 4 THEN
      -- АНУИТЕТ

      FOR m IN (SELECT cck.f_dat(l_dd, add_months(d1_, c.num - 1)) fdat
                  FROM conductor c
                 WHERE cck.f_dat(l_dd, add_months(d1_, c.num - 1)) <= p_datk
                   AND cck.f_dat(l_dd, add_months(d1_, c.num - 1)) >
                       l_gpk_begin
                 ORDER BY 1) LOOP
        si_    := round(lim2_ * p_ir / 1200, 0);
        sg_    := least(greatest(p_pl1 - si_, 0), lim2_);
        so_    := si_ + sg_;
        lim2_  := lim2_ - sg_;
        fdat1_ := m.fdat;
        INSERT INTO tmp_gpk
          (fdat, lim2, sumg, sumo)
        VALUES
          (m.fdat, lim2_, sg_, so_);
        IF lim2_ <= 0 THEN
          EXIT;
        END IF;
      END LOOP;

      -- балансировка в последнем
      IF lim2_ > 0 THEN
        UPDATE tmp_gpk
           SET sumg = sumg + lim2_, sumo = sumo + lim2_, lim2 = 0
         WHERE fdat = fdat1_;
      END IF;

      -- с сохранением срока
      IF l_ssr = 0 AND fdat1_ < p_datk THEN
        UPDATE tmp_gpk SET fdat = p_datk WHERE fdat = fdat1_;
      END IF;
      RETURN;
    END IF;
    ----------------------------------
    IF p_gpk = 2 THEN
      -- КЛАССИКА
      lim1_ := lim2_ + 0;
      si1_  := 0;

      -- Первый дату не берем
      -- Все следующие д.б. строго в след.мес
      --....
      --Предпоследняя д.б. в пред мес
      -- т.е. - ни при каких условиях не д.б. две платежные даты в одном кал.месяце

      /*   for m in (select CCK.F_DAT( l_dd, add_months(d1_,c.num-1) ) FDAT, add_months( d1_, c.num-2)  DAT01 from conductor c
                     where to_char ( CCK.F_DAT( l_dd, add_months(d1_,c.num-1) ),'YYYYMM') > to_char (l_datn ,'YYYYMM') -- В след за тек. мес
                       and to_char ( CCK.F_DAT( l_dd, add_months(d1_,c.num-1) ),'YYYYMM') < to_char (p_datk ,'YYYYMM') -- Но не с посл.мес
           union all select   p_datk FDAT, trunc(p_datk,'MM')         DAT01 from dual where l_ssr =0  -- а это посл.дата(если заказано)
                     order by 1    )
      */
      -----21.10.2013 -----------------

      /* Для разбора полетов - было на ММФО в Киев РУ
            FOR m IN (SELECT cck.f_dat(l_dd, add_months(d1_, c.num - 1)) fdat
                            ,add_months(d1_, c.num - 2) dat01
                        FROM conductor c
                       WHERE cck.f_dat(l_dd, add_months(d1_, c.num - 1)) > l_datn -- В след за тек. мес
                         AND cck.f_dat(l_dd, add_months(d1_, c.num - 1)) <= p_datk -- Но не в посл.мес
                      UNION ALL
                      SELECT p_datk fdat, trunc(p_datk, 'MM') dat01
                        FROM dual
                       WHERE l_ssr = 0 -- а это посл.дата(если заказано)
                       ORDER BY 1)
      меняем из Кировограда
      */

      FOR m IN (SELECT cck.f_dat(l_dd, add_months(d1_, c.num - 1)) fdat,
                       add_months(d1_, c.num - 2) dat01
                  FROM conductor c
                 WHERE to_char(cck.f_dat(l_dd, add_months(d1_, c.num - 1))

                              ,
                               'YYYYMM') > to_char(l_datn, 'YYYYMM') -- В след за тек. мес
                   AND to_char(cck.f_dat(l_dd, add_months(d1_, c.num - 1)),
                               'YYYYMM') < to_char(p_datk, 'YYYYMM') -- Но не с посл.мес
                UNION ALL
                SELECT p_datk fdat, trunc(p_datk, 'MM') dat01
                  FROM dual
                 WHERE l_ssr = 0 -- а это посл.дата(если заказано)
                 ORDER BY 1)

       LOOP
        pdat1_ := greatest(fdat1_, m.dat01);
        pdat2_ := add_months(m.dat01, 1);
        sg_    := least(p_pl1, lim2_);
        si_    := calp_ar(lim2_, p_ir, pdat1_, pdat2_ - 1, p_basey);

        IF m.fdat = p_datk THEN
          -- последний платеж
          flag_ := 0;
          so_   := sg_ + calp_ar(lim1_,
                                 p_ir,
                                 greatest(l_datn, trunc(fdat1_, 'MM')),
                                 fdat1_ - 1,
                                 p_basey) +
                   calp_ar(lim2_,
                           p_ir,
                           greatest(l_datn, fdat1_),
                           m.fdat - 1,
                           p_basey);
        ELSE
          so_ := round(si1_ + si_, 0) + sg_;
        END IF;

        si1_   := calp_ar(lim2_, p_ir, pdat2_, m.fdat - 1, p_basey);
        lim1_  := lim2_;
        lim2_  := lim2_ - sg_;
        fdat1_ := m.fdat;

        INSERT INTO tmp_gpk
          (fdat, lim2, sumg, sumo, sumk)
        VALUES
          (m.fdat, lim2_, sg_, so_, 0);
        IF lim2_ <= 0 THEN
          EXIT;
        END IF;

      END LOOP;

      IF flag_ = 1 AND si1_ <> 0 THEN
        UPDATE tmp_gpk SET sumo = sumo + si1_ WHERE fdat = fdat1_;
      END IF;

      IF lim2_ > 0 THEN
        UPDATE tmp_gpk
           SET sumg = sumg + lim2_, sumo = sumo + lim2_, lim2 = 0
         WHERE fdat = fdat1_;
      END IF;

      RETURN;
    END IF;

  END uni_gpk_fl;
  --- конец 14.06.2013 --------------------

  -- старая проц построения ГПК
  PROCEDURE cc_gpk(mode_  INT,
                   nd_    INT,
                   acc_   INT,
                   bdat_1 DATE, -- начало
                   datn_  DATE, -- первая дата погашенпя
                   dat4_  DATE, -- завершение
                   sum1_  NUMBER, -- сумма к погашению в грн (1.00)
                   freq_  INT,
                   rate_  NUMBER -- параметр не використовується в коді
                  , -- годовая % ставка
                   dig_   INT) IS

    -- Построение ГПК.
    -- рАБОЧАЯ ВЕРСИЯ С ЭТАЛОНА ОБ от 14.06.2013.
    -- + новая проц для ФЛ ОБ
    --25/01/2017 MPivanova  змінено для потреб ММФО
    -------
    l_acc    accounts.acc%TYPE;
    l_bdat_1 DATE;
    l_datn_  DATE;
    l_dat4_  DATE;
    l_sum1_  NUMBER;
    l_freq_  INTEGER;
    l_rate_  NUMBER;
    --------
    ost4_      NUMBER; -- сумма к погашению
    lim2_      NUMBER; -- сумма лимита на дату FDAT_
    del2_      NUMBER; -- промежуточная дельта уменшения
    kol2_      INT; -- кол периодовж
    dati_      DATE; -- пред.дата изменения лимита
    datj_      DATE; -- след.дата изменения лимита
    dat4k_     DATE; --
    fdat_      DATE; -- реальная дата начала построения
    nr_        NUMBER;
    nk_        NUMBER;
    asg_       CHAR(1);
    datnk_     DATE;
    int_       NUMBER;
    nfreq      INT;
    nfreqp     INT;
    day_pog    INT; -- День погашения
    day_pog_sn INT := NULL; -- День погашения процентов
    datn_sn    DATE;
    l_daynp    INT;
    metr96_    INT;
    irk_       NUMBER;
    sumk_      NUMBER;
    i_         INT;

    ii      int_accn%ROWTYPE;
    dd      cc_deal%ROWTYPE;
    l_pl1   NUMBER;
    l_gpk   INT;
    l_flags CHAR(2);
    flag    NUMBER := 1;

  BEGIN
    /* bars_audit.info('CC_GPK.MODE_=' || mode_ || ', ND_=' || nd_ ||
    ' ,ACC_=' || acc_ || ' ,BDAT_1=' || bdat_1 ||
    ' ,DATN_=' || datn_ || ' ,DAT4_=' || dat4_ ||
    ' ,SUM1_=' || sum1_ || ' ,FREQ_=' || l_freq_ ||
    ',DIG_=' || dig_);*/

    --|| ' ,RATE_=' || rate_||

    IF acc_ IS NULL AND bdat_1 IS NULL AND dat4_ IS NULL AND sum1_ IS NULL AND
       freq_ IS NULL THEN
      BEGIN
        SELECT -a.ostx / 100, l.fdat, d.wdate, a.acc, q.freq
          INTO l_sum1_, l_bdat_1, l_dat4_, l_acc, l_freq_
          FROM cc_lim   l,
               accounts a,
               cc_deal  d,
               cc_add   c,
               freq     q,
               int_accn i,
               basey    b
         WHERE b.basey = i.basey
           AND i.id = 0
           AND i.acc = a.acc
           AND c.nd = l.nd
           AND c.adds = 0
           AND q.freq = least(i.freq, c.freq)
           AND l.nd = d.nd
           AND l.acc = a.acc
           AND l.nd = nd_
           AND l.fdat = (SELECT MIN(fdat) FROM cc_lim WHERE nd = nd_);
      END;
    else
      l_acc    := acc_;
      l_bdat_1 := bdat_1;
      l_datn_  := datn_;
      l_dat4_  := dat4_;
      l_sum1_  := sum1_;
      l_freq_  := freq_;
      l_rate_  := rate_;
    END IF;
  
    l_datn_ := datn_;
    IF l_datn_ IS NULL THEN
      BEGIN
        SELECT t.apl_dat
          INTO l_datn_
          FROM int_accn t
         WHERE t.acc = l_acc
           AND t.id = 0;
      EXCEPTION
        WHEN no_data_found THEN
          NULL;
      END;
    END IF;
    /*l_dat4_:=dat4_;
    if l_dat4_ is null then
      begin
      select c.wdate into l_dat4_ from cc_deal c where c.nd=nd_;
       EXCEPTION
          WHEN no_data_found THEN
            null;
    end;
    end if;
    l_sum1_:=sum1_;
    if l_sum1_ is null then
     begin
     select d.into l_sum1_ from cc_deal d where d.nd=nd_;
      end;
     end if;*/
    BEGIN
      SELECT *
        INTO dd
        FROM cc_deal
       WHERE nd = nd_
         AND vidd IN (1, 2, 3, 11, 12, 13);
      SELECT *
        INTO ii
        FROM int_accn
       WHERE acc = l_acc
         AND id = 0;
    EXCEPTION
      WHEN no_data_found THEN
        raise_application_error(-20001,
                                'Не знайдено % картку рахунку 8999');
    END;
    l_flags := cck_app.get_nd_txt(nd_, 'FLAGS');
    IF (dd.vidd = 11 OR dd.vidd = 1) AND ii.basem = 1 AND mode_ <> 3 THEN
      raise_application_error(-20203,
                              'ГПК КД (' || nd_ ||
                              ' )з типом обслуговування ануїтет може бути перебудовано лише по способу розбивки 3-Погащення кредиту рівними долями з %% (ануїтет)!');
    END IF;
    -- Пока только для стандартных КД ФЛ + и уже ЮЛ/ануиет  (ОСББ).
    IF dd.vidd = 11 OR dd.vidd = 1 AND ii.basem = 1 AND mode_ = 3 THEN
      -- 4-Ануитет. 2 - Класс

      IF mode_ = 3 THEN
        l_gpk   := 4;
        l_flags := '10';
        UPDATE int_accn
           SET basem = 1, basey = 2
         WHERE acc = l_acc
           AND id = 0; -- 10 Без канікул. % за попередній день -- новый ануитет
      ELSE
        l_gpk   := 2;
        l_flags := '11';
        UPDATE int_accn
           SET basem = 0
         WHERE acc = l_acc
           AND id = 0; -- 11 Без канікул. % за попередній місяць
      END IF;

      l_flags := '9' || substr(l_flags, 2, 1);
      cck_app.set_nd_txt(p_nd => nd_, p_tag => 'FLAGS', p_txt => l_flags);
      UPDATE accounts SET vid = l_gpk WHERE acc = l_acc;

      --Cделать курсор по датам изменения ставки - должно раб и для кла и для наст ануитета

      lim2_ := l_sum1_ * 100; -- новый лимит

      FOR k IN (SELECT greatest(bdat, l_bdat_1) bdat, ir
                  FROM int_ratn
                 WHERE acc = l_acc
                   AND id = 0
                 ORDER BY 1) LOOP
        IF l_gpk IN (4, 2) THEN
          SELECT MIN(fdat)
            INTO k.bdat
            FROM cc_lim
           WHERE nd = nd_
             AND fdat >= k.bdat;
        END IF;
        IF k.bdat > l_bdat_1 THEN
          -- новый лимит
          BEGIN
            SELECT lim2
              INTO lim2_
              FROM cc_lim
             WHERE fdat = k.bdat
               AND lim2 > 0
               AND nd = nd_;
          EXCEPTION
            WHEN no_data_found THEN
              EXIT;
          END;
        END IF;

        -- ОПРЕДЕЛЕНИЕ сумми 1-го пл
        l_pl1 := cck.f_pl1(p_nd   => nd_,
                           p_lim2 => lim2_, -- новый лимит
                           p_gpk  => l_gpk, -- 4-Ануитет. 2 - Класс
                           p_dd   => ii.s, -- <Платежный день>, по умол = DD от текущего банк.дня
                           p_datn => k.bdat, -- дата нач
                           p_datk => l_dat4_, -- дата конца КД
                           p_ir   => k.ir, -- проц.ставка
                           p_ssr  => 0 -- признак =0= "с сохранением срока"
                          ,
                           p_dig  => dig_);

        cck.uni_gpk_fl(p_lim2  => lim2_, -- новый лимит
                       p_gpk   => l_gpk, -- 1-Ануитет. 0 - Класс
                       p_dd    => ii.s, -- <Платежный день>, по умол = DD от текущего банк.дня
                       p_datn  => k.bdat, -- дата нач КД
                       p_datk  => l_dat4_, -- дата конца КД
                       p_ir    => k.ir, -- проц.ставка
                       p_pl1   => l_pl1, -- сумма 1 пл
                       p_ssr   => 0, -- признак =0= "с сохранением срока"
                       p_ss    => 0, -- остаток по норм телу
                       p_acrd  => dati_, -- с какой даты начислять % acr_dat+1
                       p_basey => ii.basey -- база для нач %%;
                       );
        DELETE FROM cc_lim
         WHERE nd = nd_
           AND fdat > k.bdat;
        INSERT INTO cc_lim
          (nd, fdat, lim2, acc, sumg, sumo, sumk)
          SELECT nd_, fdat, lim2, l_acc, sumg, sumo, sumk
            FROM tmp_gpk
           WHERE fdat > k.bdat;

    -- расчет комиссии для ГПК
--    cck_ui.calc_comission_4_gpk(p_nd => nd_); 
     EXECUTE IMMEDIATE  'begin cck_ui.calc_comission_4_gpk (:ND ); end;'    USING nd_;


      END LOOP;
      RETURN;
    END IF;

    -------------------------
    ost4_ := l_sum1_ * 100;
    nfreq := l_freq_;

    --строим даты:
    l_daynp := cck_app.to_number2(cck_app.get_nd_txt(nd_, 'DAYNP'));

    --ПЕРВАЯ  дата погашения
    datnk_ := cck_app.correctdate2(gl.baseval, l_datn_, l_daynp);

    --текущая
    UPDATE cc_lim
       SET sumg = 0, sumo = 0
     WHERE nd = nd_
       AND fdat = l_bdat_1;
    IF SQL%ROWCOUNT = 0 THEN
      INSERT INTO cc_lim
        (nd, acc, fdat, sumg, sumo)
      VALUES
        (nd_, l_acc, l_bdat_1, 0, 0);
    END IF;

    -- и ПОСЛЕДНЯЯ
    dat4k_ := cck_app.correctdate2(gl.baseval, l_dat4_, l_daynp);
    --bars.bars_audit.info('CCK.CC_GPK.Step 2 dat4k_='||dat4k_);
    --raise_application_error(-20005,'CCK.CC_GPK.Step 2 dat4k_='||dat4k_);
    UPDATE cc_lim
       SET sumg = 0, sumo = 0
     WHERE nd = nd_
       AND fdat = dat4k_;
    IF SQL%ROWCOUNT = 0 THEN
      INSERT INTO cc_lim
        (nd, acc, fdat, sumg, sumo)
      VALUES
        (nd_, l_acc, dat4k_, 0, 0);
    END IF;

    -- график уже есть ?
    SELECT COUNT(*) - 1
      INTO kol2_
      FROM cc_lim
     WHERE nd = nd_
       AND acc = l_acc
       AND fdat >= datnk_
       AND fdat > l_bdat_1;

    IF kol2_ <= 2 THEN
      /* Hет, построим */

      -- день ДД погашения тела
      BEGIN
        day_pog := to_char(datnk_, 'dd');
        SELECT nvl(trunc(i.s), to_char(datnk_, 'dd'))
          INTO day_pog
          FROM nd_acc n, accounts a, int_accn i
         WHERE n.nd = nd_
           AND n.acc = a.acc
           AND a.acc = i.acc
           AND a.tip = 'LIM'
           AND i.id = 0;
      EXCEPTION
        WHEN no_data_found THEN
          NULL;
      END;

      IF day_pog > 32 OR day_pog < 1 THEN
        day_pog := to_char(datnk_, 'dd');
      END IF;

      --- для не ануитетных платежей узнаем день погашения процентов
      IF mode_ != 3 THEN
        -- DD день пог %%
        day_pog_sn := nvl(cck_app.to_number2(cck_app.get_nd_txt(nd_,
                                                                'DAYSN')),
                          day_pog);
        --ПЕРВАЯ дата погашения %%
        datn_sn := nvl(to_date(cck_app.get_nd_txt(nd_, 'DATSN'),
                               'dd.mm.yyyy'),
                       datnk_);
        IF day_pog_sn > 32 OR day_pog_sn < 1 THEN
          day_pog_sn := day_pog;
          datn_sn    := datnk_;
        ELSE
          SELECT a.freq, i.freq
            INTO nfreq, nfreqp
            FROM int_accn i, cc_add a
           WHERE i.acc = l_acc
             AND a.nd = nd_
             AND a.adds = 0
             AND i.id = 0;
        END IF;
      END IF;

      -- подбираем первую дату погашения
      fdat_ := datnk_;
      kol2_ := 0;
      WHILE (datnk_ > fdat_ OR kol2_ = 0) AND nfreq > 3 LOOP
        fdat_ := cck_app.check_max_day(add_months(fdat_, kol2_),
                                       day_pog,
                                       -2,
                                       gl.baseval);
        kol2_ := kol2_ + 1;
      END LOOP;

      kol2_ := 0;
      datj_ := cck_app.correctdate2(gl.baseval, fdat_, l_daynp); --  DATj_ - след.дата изменения лимита
      dati_ := fdat_; --  DATi_ - пред.дата изменения лимита
      WHILE datj_ < dat4k_ LOOP
        BEGIN
          INSERT INTO cc_lim
            (nd, fdat, acc, sumg, not_sn)
          VALUES
            (nd_, datj_, l_acc, 0, decode(day_pog_sn, NULL, NULL, 1));
        EXCEPTION
          WHEN dup_val_on_index THEN
            UPDATE cc_lim
               SET sumg = 0, not_sn = decode(day_pog_sn, NULL, NULL, 1)
             WHERE nd = nd_
               AND fdat = datj_
               AND acc = l_acc;
        END;
        kol2_ := kol2_ + 1;
        dati_ := datj_;
        IF nfreq = 3 THEN
          datj_ := cck_app.correctdate2(gl.baseval, datj_ + 7, l_daynp);
        ELSIF nfreq = 5 THEN
          datj_ := cck_app.check_max_day(add_months(fdat_, kol2_),
                                         day_pog,
                                         l_daynp,
                                         gl.baseval);
        ELSIF nfreq = 7 THEN
          datj_ := cck_app.check_max_day(add_months(fdat_, 3 * kol2_),
                                         day_pog,
                                         l_daynp,
                                         gl.baseval);
        ELSIF nfreq = 180 THEN
          datj_ := cck_app.check_max_day(add_months(fdat_, 6 * kol2_),
                                         day_pog,
                                         l_daynp,
                                         gl.baseval);
        ELSIF nfreq = 360 THEN
          datj_ := cck_app.check_max_day(add_months(fdat_, 12 * kol2_),
                                         day_pog,
                                         l_daynp,
                                         gl.baseval);
        ELSE
          datj_ := dat4k_;
        END IF;
      END LOOP;

      -- график уже есть !
      lim2_ := ost4_;

      BEGIN
        -- 95 = константа
        -- 99, 0 = Обычная годовая % ставка  IRK_
        -- 96 = % от тек остатка на дату расчета

        SELECT metr, nvl(acrn.fprocn(acc, 2, l_datn_), 0)
          INTO metr96_, irk_
          FROM int_accn
         WHERE acc = l_acc
           AND id = 2
           AND metr IN (96, 95, 0, 99);

        IF metr96_ = 95 THEN
          -------- % от первоначальной суммы
          sumk_ := irk_ * l_sum1_;
          irk_  := 0;
        ELSE
          -- надо попутно устанавливать Basey для комиссии таким же,
          -- как и для осн % карточки, т.к. здесь полный капец !
          UPDATE int_accn
             SET basey =
                 (SELECT basey
                    FROM int_accn
                   WHERE acc = l_acc
                     AND id = 0),
                 metr  = decode(metr, 99, 0, metr)
           WHERE acc = l_acc
             AND id = 2;
          sumk_ := 0;
        END IF;
      EXCEPTION
        WHEN no_data_found THEN
          metr96_ := 90;
          irk_    := 0;
          sumk_   := 0;
      END;

      IF mode_ = 1 THEN
        -------------------------------------------- равными доляли сумма кредита
        kol2_ := kol2_ + 1;
        del2_ := round(lim2_ / kol2_, 0); -- в коп.
        IF dig_ > 0 THEN
          del2_ := round((del2_ / power(10, dig_)) - 0.5, 0) *
                   power(10, dig_);
        END IF;

        i_ := 0;
        FOR k IN (SELECT *
                    FROM cc_lim
                   WHERE nd = nd_
                     AND fdat >= l_datn_
                   ORDER BY fdat) LOOP
          IF metr96_ = 96 THEN
            UPDATE cc_lim
               SET sumg = del2_, sumk = lim2_ - (del2_ * i_ * irk_ / 100)
             WHERE nd = nd_
               AND fdat = k.fdat;
          ELSE
            UPDATE cc_lim
               SET sumg = del2_, sumk = sumk_
             WHERE nd = nd_
               AND fdat = k.fdat;
          END IF;
          i_ := i_ + 1;
        END LOOP;

        --выравнивание за счет последней
        UPDATE cc_lim
           SET sumg = lim2_ - del2_ * (i_ - 1)
         WHERE acc = l_acc
           AND nd = nd_
           AND fdat = dat4k_;
        UPDATE cc_lim SET sumo = sumg WHERE acc = l_acc;

      ELSIF mode_ = 2 THEN
        ------------------------------------------- одной суммой в конце срока
        IF metr96_ = 96 THEN
          UPDATE cc_lim
             SET sumg = decode(fdat, dat4k_, lim2_, 0),
                 sumk = irk_ * l_sum1_
           WHERE nd = nd_
             AND fdat >= l_datn_;
        ELSE
          UPDATE cc_lim
             SET sumg = decode(fdat, dat4k_, lim2_, 0), sumk = sumk_
           WHERE nd = nd_
             AND fdat >= l_datn_;
        END IF;

      ELSE
        --- MODE_ = 3 --------------------- ануитет по-старому
        SELECT COUNT(*)
          INTO kol2_
          FROM cc_lim
         WHERE nd = nd_
           AND fdat >= datnk_;
        DECLARE
          pv_    NUMBER := l_sum1_ * 100; --  Текущая стоимость = сумма кредита
          fv_    NUMBER := 0; --  Будущая стоимость=0
          r_     NUMBER; ----  RATE_/100 ; --  Годовая % ст (коеф)
          n_     NUMBER := (dat4k_ - l_bdat_1) / 365; --  срок операции (лет)
          m_     NUMBER := (kol2_) / n_; --  Кол-во платежей в году
          g_     NUMBER := 1; -- Коеф.базового года
          cf_    NUMBER; --  величина платежа;
          sg_    NUMBER; -- сумма гашения
          so_    NUMBER;
          fdat1_ DATE;
          ss_    NUMBER;
          par1_  NUMBER;
          par2_  NUMBER;
          --m96_ int    ;-- \ методика,% ежем.комиссии, расчетная сумма
          --IRK_ number ;-- /
          sk0_ NUMBER := 0;
        BEGIN
          SELECT round(decode(i.basey, 3, 365 / 360, 1), 2),
                 decode(a.ostc, 0, l_rate_, acrn.fprocn(l_acc, 0, l_bdat_1)) / 100
            INTO g_, r_
            FROM int_accn i, accounts a
           WHERE a.acc = l_acc
             AND i.id = 0
             AND i.acc = l_acc;
          IF metr96_ = 96 THEN
            irk_ := irk_ * 12;
          END IF;
          r_      := r_ + irk_ / 100;
          par1_   := r_ * g_ / m_;
          par2_   := n_ * m_;
          cf_     := -pmt1(par1_, par2_, pv_, fv_);
          cf_     := trunc(cf_ / power(10, dig_)) * power(10, dig_);
          sumo_cf := cf_ + sumk_;

          FOR k IN (SELECT fdat
                      FROM cc_lim
                     WHERE nd = nd_
                       AND acc = l_acc
                       AND fdat >= l_bdat_1
                     ORDER BY fdat) LOOP
            sg_  := 0;
            so_  := 0;
            sk0_ := 0;

            IF k.fdat > l_bdat_1 THEN
              -- не первая банковская дата, начислить %

              acrn.p_int(l_acc, 0, fdat1_, k.fdat - 1, int_, -pv_, 0);
              --bars_audit.info('CC_GPK. ACRN.P_INT l_acc=' || l_acc || ', fdat1_=' || fdat1_ ||', int_='||int_||', pv_'||pv_);

              int_ := round(-int_, 0);
              IF irk_ > 0 THEN

                acrn.p_int(l_acc, 2, fdat1_, k.fdat - 1, sk0_, -pv_, 0);

                -- bars_audit.info('CC_GPK. ACRN.P_INT l_acc=' || l_acc || ', fdat1_=' || fdat1_ ||', int_='||int_||', pv_'||pv_);
                sk0_ := round(-sk0_, 0);
              END IF;

              IF k.fdat = dat4k_ THEN
                sg_ := pv_;
                so_ := pv_ + int_ + sumk_ + sk0_; -- последняя дата
              ELSIF cf_ > (int_ + sumk_ + sk0_) THEN
                sg_ := cf_ - (int_ + sumk_ + sk0_);
                so_ := cf_; -- обычная дата. Сума % меньше общей суммы
              ELSE
                sg_ := 0;
                so_ := int_ + sumk_ + sk0_; -- обычная дата. Сума % больше= общей суммы
              END IF;

              UPDATE cc_lim
                 SET lim2 = pv_ - sg_, sumg = sg_, sumo = so_, sumk = sumk_
               WHERE nd = nd_
                 AND fdat = k.fdat;
            END IF;
            fdat1_ := k.fdat;
            pv_    := pv_ - sg_;
            ss_    := ss_ + sg_;
          END LOOP;
        END;

      END IF;

      IF day_pog_sn IS NOT NULL OR (nfreqp != nfreq) THEN
        kol2_      := 0;
        datn_sn    := nvl(datn_sn, l_datn_);
        fdat_      := cck_app.check_max_day(datn_sn,
                                            day_pog_sn,
                                            -2,
                                            gl.baseval);
        day_pog_sn := nvl(day_pog_sn, day_pog);
        WHILE (datn_sn > fdat_ OR kol2_ = 0) AND nfreqp > 3 LOOP
          fdat_ := cck_app.check_max_day(add_months(fdat_, kol2_),
                                         day_pog_sn,
                                         -2,
                                         gl.baseval);
          kol2_ := kol2_ + 1;
        END LOOP;

        kol2_ := 0;
        datj_ := cck_app.correctdate2(gl.baseval, fdat_, l_daynp);
        dati_ := fdat_;

        WHILE datj_ < dat4k_ LOOP
          BEGIN
            INSERT INTO cc_lim
              (nd, fdat, acc, sumg, not_sn)
            VALUES
              (nd_, datj_, l_acc, 0, NULL);
          EXCEPTION
            WHEN dup_val_on_index THEN
              UPDATE cc_lim
                 SET not_sn = NULL
               WHERE nd = nd_
                 AND acc = l_acc
                 AND fdat = datj_;
          END;
          kol2_ := kol2_ + 1;
          dati_ := datj_;

          IF nfreqp = 3 THEN
            datj_ := cck_app.correctdate2(gl.baseval, datj_ + 7, l_daynp);
          ELSIF nfreqp = 5 THEN
            datj_ := cck_app.check_max_day(add_months(fdat_, kol2_),
                                           day_pog_sn,
                                           l_daynp,
                                           gl.baseval);
          ELSIF nfreqp = 7 THEN
            datj_ := cck_app.check_max_day(add_months(fdat_, 3 * kol2_),
                                           day_pog_sn,
                                           l_daynp,
                                           gl.baseval);
          ELSIF nfreqp = 180 THEN
            datj_ := cck_app.check_max_day(add_months(fdat_, 6 * kol2_),
                                           day_pog_sn,
                                           l_daynp,
                                           gl.baseval);
          ELSIF nfreqp = 360 THEN
            datj_ := cck_app.check_max_day(add_months(fdat_, 12 * kol2_),
                                           day_pog_sn,
                                           l_daynp,
                                           gl.baseval);
          ELSE
            datj_ := dat4k_;
          END IF;

        END LOOP;
      END IF; -- постр. процентов для не ануитетных платежей

    END IF;

    -- расчет комиссии для ГПК
--   cck_ui.calc_comission_4_gpk(p_nd => nd_); 
     EXECUTE IMMEDIATE  'begin cck_ui.calc_comission_4_gpk (:ND ); end;'    USING nd_;
    
    --переливка в лимиты
    cck.cc_gpk_lim(nd_, l_acc, l_bdat_1, l_datn_, l_sum1_);

--  cck_ui.gpk_bal(nd_, NULL);
    EXECUTE IMMEDIATE  'begin cck_ui.gpk_bal( :nd, NULL); end;'    USING nd_;

    /*    bars_audit.info('cck.cc_gpk_lim nd_=' || nd_ || ', l_acc=' || l_acc ||
    ' ,L_bdat_1=' || l_bdat_1 || ' ,l_datn_=' || l_datn_ ||
    ' ,l_sum1_=' || l_sum1_);*/

    IF flag = 1 THEN
      cck.cc_tmp_gpk(nd_,
                     2,
                     l_acc,
                     l_bdat_1,
                     l_dat4_,
                     1,
                     l_sum1_,
                     gl.bdate);
    END IF;
  END cc_gpk;
  ---------------------

  PROCEDURE cc_gpk_lim(p_nd   NUMBER,
                       p_acc8 NUMBER,
                       p_dat1 DATE,
                       p_datn DATE,
                       p_sum1 NUMBER) IS

    k_    INT;
    s_    NUMBER := p_sum1 * 100;
    dtmp_ DATE;
    stmp_ CHAR(1);
    d_    NUMBER;
    ss_   NUMBER;
  BEGIN

    --  update cc_lim set lim2=S_,sumg=0,sumo=0, sumk=0 where nd= p_ND and fdat= p_dat1 ;
    --  if SQL%rowcount = 0 then
    --     INSERT INTO cc_lim(nd,acc,fdat,lim2,sumg,sumo, sumk)  VALUES ( p_ND, p_ACC8, p_dat1 ,S_,0,0,0);
    --  end if;

    IF p_dat1 = gl.bdate THEN
      UPDATE accounts SET ostx = -s_ WHERE acc = p_acc8;
      UPDATE cc_deal SET LIMIT = p_sum1 WHERE nd = p_nd;
      UPDATE cc_add
         SET s = p_sum1
       WHERE nd = p_nd
         AND adds = 0;
    END IF;

    UPDATE cc_lim x
       SET x.lim2 =
           (SELECT SUM(sumg)
              FROM cc_lim
             WHERE nd = x.nd
               AND fdat > x.fdat)
     WHERE nd = p_nd
       AND fdat >= p_datn;

    -- поскольку данная процедура за одно построение выполняется 2 раза
    -- не позволяет вставлять одинаковые строки перестроения в тек. б.д.
    -- пока в табл не появятся другие события или соб др работника
    INSERT INTO cc_sob
      (nd, fdat, id, isp, txt, otm, freq)
      SELECT p_nd,
             gl.bdate,
             NULL,
             NULL,
             decode(id,
                    0,
                    'Построен ГПК',
                    'Изменен ГПК'),
             6,
             2
        FROM (SELECT nvl(MAX(id), 0) id
                FROM cc_sob
               WHERE nd = p_nd
                 AND fdat = gl.bdate
                 AND (txt LIKE 'Изменен Г%' OR txt LIKE 'Построен Г%')
                 AND isp = user_id
              MINUS
              SELECT nvl(MAX(id), 1) id
                FROM cc_sob
               WHERE nd = p_nd
                 AND fdat = gl.bdate);

    cck.cc_lim_null(p_nd => p_nd);

  END cc_gpk_lim;
  ---------------------------
  PROCEDURE cc_lim_gpk(nd_   cc_deal.nd%type,
                       acc_  accounts.acc%type default null,
                       datn_ DATE default gl.bd) IS
    -- Превращение ГЛК (Петрокомерц) - ГПК (АЖИО)
    pdat_ DATE;
    sumg_ NUMBER;
    l_acc number;
  BEGIN
    if acc_ is null then
      select a.acc into l_acc from nd_acc na ,accounts a
      where a.acc=na.acc
      and a.tip='LIM'
      and na.nd=ND_;
    else
      l_acc:=acc_;
    end if;  
    --raise_application_error (-20008,l_acc);

    -- 08.10.2013
    --- for k in (select FDAT,LiM2 from cc_lim where nd=ND_ and acc=ACC_ and fdat > DATN_ order by 1)
    FOR k IN (SELECT fdat, lim2, acc
                FROM cc_lim
               WHERE nd = nd_
                    AND acc = l_acc
                 AND fdat >= datn_
               ORDER BY 1) LOOP
      BEGIN
        SELECT MAX(fdat)
          INTO pdat_
          FROM cc_lim
         WHERE nd = nd_
           AND acc = k.acc
           AND fdat < k.fdat;
        SELECT lim2 - k.lim2
          INTO sumg_
          FROM cc_lim
         WHERE nd = nd_
           AND acc = k.acc
           AND fdat = pdat_;
      EXCEPTION
        WHEN no_data_found THEN
          sumg_ := 0;
      END;
      UPDATE cc_lim
         SET sumg = sumg_
       WHERE nd = nd_
         AND fdat = k.fdat;
    END LOOP;

    -- поскольку данная процедура за одно построение выполняется 2 раза
    -- не позволяет вставлять одинаковые строки перестроения в тек. б.д.
    -- пока в табл не появятся другие события или соб др работника
    INSERT INTO cc_sob
      (nd, fdat, id, isp, txt, otm, freq)
      SELECT nd_,
             gl.bdate,
             NULL,
             NULL,
             decode(id,
                    0,
                    'Построен ГЛК',
                    'Изменен ГЛК'),
             6,
             2
        FROM (SELECT nvl(MAX(id), 0) id
                FROM cc_sob
               WHERE nd = nd_
                 AND fdat = gl.bdate
                 AND (txt LIKE 'Изменен Г%' OR txt LIKE 'Построен Г%')
                 AND isp = user_id
              MINUS
              SELECT nvl(MAX(id), 1) id
                FROM cc_sob
               WHERE nd = nd_
                 AND fdat = gl.bdate);

  END cc_lim_gpk;
  ---------------------------

  PROCEDURE cc_sum_pog(dat1_ DATE, dat2_ DATE, ntip_kl INT) IS
    -- Расчет Прогноз суммы погашения за период работает НА ВРЕМЕННой  ТАБЛИЦе
    cck_nbu_ CHAR(1) := getglobaloption('CCK_NBU');
  BEGIN

    DELETE FROM cck_sum_pog;
    FOR k IN (SELECT a.acc,
                     d.nd,
                     a.kv,
                     c.rnk,
                     substr(decode(cck_nbu_, '1', c.nmkk, c.nmk), 1, 38) nmk,
                     substr(d.cc_id, 1, 20) cc_id,
                     a.ostx - a.ostc g2
                FROM accounts a, customer c, cc_deal d, cc_vidd v, nd_acc n
               WHERE v.vidd = d.vidd
                 AND v.custtype = ntip_kl
                 AND a.rnk = c.rnk
                 AND c.custtype IN (1, 2, 3)
                 AND d.rnk = c.rnk
                 AND a.acc = n.acc
                 AND n.nd = d.nd
                 AND a.tip = 'LIM'
                 AND a.ostc < 0) LOOP

      --1) + Просрочка
      --2) + Плановое пог
      --3) - Досрочное
      INSERT INTO cck_sum_pog
        (acc, nd, kv, rnk, nmk, cc_id, g1, g2)
        SELECT k.acc,
               k.nd,
               k.kv,
               k.rnk,
               k.nmk,
               to_char(fdat, 'dd/mm/yyyy'),
               sumg,
               0
          FROM cc_lim
         WHERE nd = k.nd
           AND sumg <> 0
           AND fdat >= dat1_
           AND fdat <= dat2_
           AND NOT EXISTS (SELECT nd
                  FROM nd_acc n, cc_trans t
                 WHERE n.nd = k.nd
                   AND n.acc = t.acc)
        UNION ALL
        SELECT k.acc,
               k.nd,
               k.kv,
               k.rnk,
               k.nmk,
               to_char(gl.bdate, 'dd/mm/yyyy'),
               0,
               k.g2
          FROM dual
         WHERE k.g2 <> 0
        UNION ALL
        SELECT k.acc,
               k.nd,
               k.kv,
               k.rnk,
               k.nmk,
               to_char(t.d_plan, 'dd/mm/yyyy'),
               t.sv - t.sz,
               0
          FROM cc_trans t, nd_acc n
         WHERE n.nd = k.nd
           AND n.acc = t.acc
           AND t.d_plan >= dat1_
           AND t.d_plan <= dat2_
           AND t.sv <> t.sz
           AND t.d_fakt IS NULL;

    END LOOP;
  END cc_sum_pog;
  ---------------------------------------
  PROCEDURE cc_intn(nd_ INT) IS
    -- Общий ГЛК +ГПК + ГП%

    dat4_ DATE; -- последняя дата КД
    acc_  INT; -- счет 8999 - LIM
    dat3_ DATE; -- первая дата действия лимита
    kv_   INT; -- вал лимита
    freq_ INT; -- периодичност уплаты %
    datn_ DATE; --дата начала уплаты %
    dat_  DATE; -- рабачаа
    s_    NUMBER;
    dos_  NUMBER;
    kos_  NUMBER;
    sli_  NUMBER;
    sl_   NUMBER;
    sn_   NUMBER; -- рабочая

    f06_ NUMBER;
    f07_ NUMBER;
    f08_ NUMBER;
    f09_ NUMBER;
    f10_ NUMBER;
    f11_ NUMBER;
    f12_ NUMBER;
    f13_ NUMBER;
    f14_ NUMBER;
    f15_ NUMBER;

  BEGIN
    DELETE FROM cck_int;
    BEGIN
      SELECT wdate INTO dat4_ FROM cc_deal WHERE nd = nd_;
      SELECT acc, fdat
        INTO acc_, dat3_
        FROM cc_lim
       WHERE nd = nd_
         AND rownum = 1
       ORDER BY fdat;
      SELECT a.kv, i.freq, i.apl_dat
        INTO kv_, freq_, datn_
        FROM accounts a, int_accn i
       WHERE a.acc = i.acc
         AND i.id = 0
         AND a.acc = acc_;
    EXCEPTION
      WHEN no_data_found THEN
        RETURN;
    END;
    UPDATE int_accn
       SET freq = 1
     WHERE acc = acc_
       AND id = 0;

    IF freq_ IN (3, 5, 7, 180, 360) THEN
      -- разметка дат ГП%
      WHILE datn_ < dat4_ LOOP
        dat_ := datn_;
        WHILE 1 < 2 LOOP
          BEGIN
            SELECT holiday
              INTO dat_
              FROM holiday
             WHERE kv = 980
               AND holiday = dat_;
          EXCEPTION
            WHEN no_data_found THEN
              EXIT;
          END;
          dat_ := dat_ + 1;
        END LOOP;
        INSERT INTO cck_int
          (fdat, ost, otmp, otm)
          SELECT dat_, lim2, 1, decode(dat_, fdat, 1, 0)
            FROM cc_lim
           WHERE nd = nd_
             AND fdat = (SELECT MAX(fdat)
                           FROM cc_lim
                          WHERE nd = nd_
                            AND fdat < dat_);
        IF freq_ = 3 THEN
          datn_ := datn_ + 7;
        ELSIF freq_ = 5 THEN
          datn_ := add_months(datn_, 1);
        ELSIF freq_ = 7 THEN
          datn_ := add_months(datn_, 3);
        ELSIF freq_ = 180 THEN
          datn_ := add_months(datn_, 6);
        ELSIF freq_ = 360 THEN
          datn_ := add_months(datn_, 12);
        END IF;
      END LOOP;
    END IF;

    -- + разметка дат ГПK
    INSERT INTO cck_int
      (fdat, ost, otmp, otm)
      SELECT l1.fdat, l2.lim2, decode(l1.fdat, dat4_, 1, 0), 1
        FROM cc_lim l1, cc_lim l2
       WHERE l1.nd = nd_
         AND l2.nd = nd_
         AND l1.fdat NOT IN (SELECT fdat FROM cck_int)
         AND l2.fdat = (SELECT MAX(l3.fdat)
                          FROM cc_lim l3
                         WHERE l3.nd = nd_
                           AND l3.fdat <= l1.fdat);

    -- + текущая дата и еще 3
    INSERT INTO cck_int
      (fdat, ost, otmp, otm)
      SELECT gl.bdate + d.dk, l2.lim2, 0, 0
        FROM cc_lim l2, dk d
       WHERE l2.nd = nd_
         AND gl.bdate + d.dk NOT IN (SELECT fdat FROM cck_int)
         AND l2.fdat = (SELECT MAX(l3.fdat)
                          FROM cc_lim l3
                         WHERE l3.nd = nd_
                           AND l3.fdat < gl.bdate + d.dk);
    -------------------------------
    dat_ := dat3_;
    sli_ := 0;
    sn_  := 0; -- для предыдущего F12_
    --deb.trace( ern, '8',ND_);

    FOR k IN (SELECT fdat, ost FROM cck_int WHERE osti IS NULL ORDER BY fdat) LOOP
      -- прогноз % на лимиты (частные суммы)
      acrn.p_int(acc_, 0, dat_, k.fdat - 1, sl_, -k.ost, 0); --от суммы лимита
      sl_  := -sl_;
      sli_ := sli_ + sl_;

      f06_ := 0;
      f07_ := 0;
      f08_ := 0;
      f09_ := 0;
      f10_ := 0;
      f11_ := 0;
      f12_ := 0;
      f13_ := 0;
      f14_ := 0;
      FOR p IN (SELECT a.kv, a.acc, a.tip
                  FROM accounts a, nd_acc n
                 WHERE a.acc = n.acc
                   AND a.tip IN ('SS ', 'SP ', 'SN ', 'SPN')
                   AND n.nd = nd_) LOOP
        BEGIN
          SELECT nvl(gl.p_icurval(p.kv, SUM(dos), k.fdat), 0),
                 nvl(gl.p_icurval(p.kv, SUM(kos), k.fdat), 0)
            INTO dos_, kos_
            FROM saldoa
           WHERE acc = p.acc
             AND fdat >= dat3_
             AND fdat <= k.fdat;
        EXCEPTION
          WHEN no_data_found THEN
            dos_ := 0;
            kos_ := 0;
        END;

        IF p.tip IN ('SS ', 'SP ') THEN
          IF p.tip = 'SS ' THEN
            f10_ := f10_ + dos_ - kos_;
          ELSE
            f11_ := f11_ + dos_ - kos_;
          END IF;
          --нач %
          acrn.p_int(p.acc, 0, dat3_, k.fdat - 1, s_, NULL, 0); --от остатка
          f06_ := f06_ + gl.p_icurval(p.kv, -s_, k.fdat);
        ELSE
          f07_ := f07_ + kos_;
          IF p.tip = 'SPN' THEN
            f07_ := f07_ - dos_;
            f08_ := f08_ + dos_;
            f09_ := f09_ + kos_;
          END IF;
        END IF;
      END LOOP;
      f06_ := gl.p_ncurval(kv_, f06_, k.fdat); -- нач %
      f07_ := gl.p_ncurval(kv_, f07_, k.fdat); -- погаш нач %
      f08_ := gl.p_ncurval(kv_, f08_, k.fdat); -- перенесено % на проср
      f09_ := gl.p_ncurval(kv_, f09_, k.fdat); -- погашено просроч %
      f10_ := gl.p_ncurval(kv_, f10_, k.fdat); -- ост осн долга
      f11_ := gl.p_ncurval(kv_, f11_, k.fdat); -- ост просроч долга
      f12_ := f06_ - f07_; --ост нач %
      f13_ := f08_ - f09_; --ост просроч %
      IF sn_ > f07_ THEN
        f14_ := sn_ - f07_;
      END IF;

      UPDATE cck_int
         SET ostd = sl_,
             osti = sli_,
             kv   = kv_,
             f10  = f10_,
             f11  = f11_,
             f06  = f06_,
             f07  = f07_,
             f08  = f08_,
             f09  = f09_,
             f12  = f12_,
             f13  = f13_,
             f14  = f14_
       WHERE fdat = k.fdat;
      --запомнить пред.значения
      sn_  := f06_;
      dat_ := k.fdat;
    END LOOP;

    UPDATE int_accn
       SET freq = freq_
     WHERE acc = acc_
       AND id = 0;
  END cc_intn;

  ----------------
  PROCEDURE cc_start(nd_ INT) IS
    --восстанавливает обороты и остатки по родительскому счету на
    --основании оборотов дочерних счетов
    --по реальным датам
    acc8_ INT;
    kv8_  INT;
    dos_  NUMBER;
    kos_  NUMBER;
    dat_  DATE;
    doss_ NUMBER;
    koss_ NUMBER;
    ostb_ accounts.ostb%TYPE := 0;
    dapp_ DATE := NULL;
    daos_ DATE := NULL;
  BEGIN
    dat_ := gl.bdate;
    BEGIN
      SELECT a.acc, a.kv
        INTO acc8_, kv8_
        FROM cc_lim l, accounts a
       WHERE a.acc = l.acc
         AND l.nd = nd_
         AND rownum = 1;
    EXCEPTION
      WHEN no_data_found THEN
        RETURN;
    END;
    ------удалим всю историю
    UPDATE accounts
       SET dos  = 0,
           kos  = 0,
           dosq = 0,
           kosq = 0,
           dapp = NULL,
           ostc = 0,
           ostb = 0,
           ostf = 0,
           ostq = 0
     WHERE acc = acc8_;
    DELETE FROM saldoa WHERE acc = acc8_;

    ------нарастим новую историю
    ------по каждому банковскому дню
    -- как сумму в экв всех подчиненных счетов
    FOR k IN (SELECT s.fdat,
                     s.pdat,
                     s.ostf,
                     gl.p_icurval(a.kv, s.dos, s.fdat) dos,
                     gl.p_icurval(a.kv, s.kos, s.fdat) kos
                FROM saldoa s, accounts a
               WHERE a.acc = s.acc
                 AND a.accc = acc8_
               ORDER BY s.fdat, a.acc) LOOP
      IF k.pdat IS NULL AND k.dos + k.kos = 0 AND k.ostf <> 0 THEN
        -- учет начальных остатков(созданных при импотре) вSALDOA
        IF k.ostf < 0 THEN
          doss_ := -k.ostf;
        ELSE
          koss_ := k.ostf;
        END IF;
      ELSE
        doss_ := k.dos;
        koss_ := k.kos;
      END IF;

      gl.bdate := k.fdat;

      IF daos_ IS NULL THEN
        daos_ := k.fdat;
        dapp_ := k.fdat;
      END IF;

      IF k.fdat > dapp_ THEN
        dapp_ := k.fdat;
      END IF;

      IF doss_ > 0 THEN
        --восстановим суммарный ДЕБ оборот в валюту лимита (сч.8999)
        dos_ := gl.p_ncurval(kv8_, doss_, k.fdat);
        UPDATE accounts
           SET ostb = ostb - dos_, ostc = ostc - dos_
         WHERE acc = acc8_;
      END IF;

      IF koss_ > 0 THEN
        --восстановим суммарный КРЕД оборот в валюту лимита (сч.8999)
        kos_ := gl.p_ncurval(kv8_, koss_, k.fdat);
        UPDATE accounts
           SET ostb = ostb + kos_, ostc = ostc + kos_
         WHERE acc = acc8_;
      END IF;
    END LOOP;

    gl.bdate := dat_;

    -- сумма план.остатков в экв всех доч.счетов
    SELECT nvl(SUM(gl.p_icurval(kv, ostb, gl.bdate)), 0)
      INTO ostb_
      FROM accounts
     WHERE accc = acc8_;
    -- сумма план.остатков в базовой вал КД всех доч.счетов
    IF kv8_ <> gl.baseval THEN
      ostb_ := gl.p_ncurval(kv8_, ostb_, gl.bdate);
    END IF;

    -- план.ост родительского счета
    UPDATE accounts
       SET ostb = ostb_, dapp = nvl(dapp_, dapp), daos = nvl(daos_, daos)
     WHERE acc = acc8_;

    cck.rate_lim(acc8_);
  END cc_start;
  ------------------------------------
  PROCEDURE cc_sv12(nd1_ INT, nd2_ INT) IS
    --обединить 2 КД
    acc1_ INT;
    acc2_ INT;
  BEGIN

    -- подвязать под другой 8999
    SELECT acc
      INTO acc1_
      FROM cc_lim
     WHERE nd = nd1_
       AND rownum = 1;
    SELECT acc
      INTO acc2_
      FROM cc_lim
     WHERE nd = nd2_
       AND rownum = 1;
    FOR k IN (SELECT acc FROM accounts WHERE accc = acc1_) LOOP
      UPDATE accounts SET accc = acc2_ WHERE acc = k.acc;
    END LOOP;
    UPDATE accounts SET pap = 3 WHERE acc = acc2_;
    cc_start(nd2_);
    UPDATE accounts SET pap = 1 WHERE acc = acc2_;

    UPDATE accounts SET dazs = gl.bdate WHERE acc = acc1_;

    -- присоединить счета к другому КД
    INSERT INTO nd_acc
      (nd, acc)
      SELECT nd2_, n.acc
        FROM nd_acc n, accounts a
       WHERE n.nd = nd1_
         AND a.acc = n.acc
         AND a.tip <> 'LIM'
         AND a.acc NOT IN (SELECT acc FROM nd_acc WHERE nd = nd2_);

    -- удалить по старому КД
    -- чтобы не удалять, а иметь какую-то историю по слитым договорам, удаляем только привязку счетов:
    -- delete from cc_lim  where nd=ND1_;
    -- delete from nd_txt  where nd=ND1_;
    -- delete from cc_sob  where nd=ND1_;
    DELETE FROM nd_acc WHERE nd = nd1_;
    -- delete from cc_add  where nd=ND1_;
    -- delete from cc_deal where nd=ND1_;

    UPDATE cc_deal SET sos = 14 WHERE nd = nd1_;

  END cc_sv12;
  ----------
  PROCEDURE cc_m_accp(mod_ INT, nd_ INT, accz_ INT) IS
    mpawn_ INT;
    pawn_  INT;
    rnk_   INT;
    ndz_   INT;

    --присoединить, oтсоединить залoговый счет
  BEGIN
    IF mod_ = 1 THEN
      ---присoединить
      FOR k IN (SELECT n.acc, a.tip
                  FROM nd_acc n, accounts a
                 WHERE a.acc = n.acc
                   AND n.nd = nd_
                   AND a.tip IN
                       ('SS ', 'SL ', 'SP ', 'CR9', 'SN ', 'SNO', 'SPN')
                   AND (accz_, n.acc) NOT IN (SELECT acc, accs FROM cc_accp)) LOOP

        INSERT INTO cc_accp
          (acc, nd, accs, pr_12)
        VALUES
          (accz_, nd_, k.acc, 2);
      END LOOP;
    ELSE
      ---oтсоединить
      DELETE FROM cc_accp
       WHERE acc = accz_
         AND accs IN (SELECT acc FROM nd_acc WHERE nd = nd_);
    END IF;
  END cc_m_accp;
  -----------

  PROCEDURE cc_9819(nd_ INT, pr_ INT) IS

    -- ND_ - номер договора
    -- PR_ - 0 - приход (при открытии договора)
    --       1 - расход (при закрытии договора)

    -- Учет кредитных договоров

    nls9_  tts.nlsm%TYPE;
    sd_    NUMBER;
    dk_    INT;
    nms9_  accounts.nms%TYPE;
    ref_   oper.ref%TYPE;
    vob_   INT;
    nls99_ tts.nlsm%TYPE;
    kv_    NUMBER;
    flg_   INT;
    nms99_ accounts.nms%TYPE;
    par_   VARCHAR2(14);
    okpo_b customer.okpo%TYPE;
    okpo_a customer.okpo%TYPE;
    nz_    VARCHAR2(14);

    fio_   VARCHAR2(70);
    sour_  INT;
    vidd_  INT;
    cc_id_ VARCHAR2(20);
    sdate_ DATE;
    svidd_ VARCHAR2(25);
    nazn_  VARCHAR2(170);
    --erm varchar2(2000);

  BEGIN
    BEGIN
      --   erm:='CCK.CC_9819: оп."CRD" ';
      SELECT nlsm, substr(flags, 38, 1)
        INTO nls99_, flg_
        FROM tts
       WHERE tt = 'CRD';
      -- Шаг 2 если введена формула
      IF substr(nls99_, 1, 2) = '#(' THEN
        -- Dynamic account number present
        BEGIN
          EXECUTE IMMEDIATE 'SELECT ' ||
                            substr(nls99_, 3, length(nls99_) - 3) ||
                            ' FROM DUAL'
            INTO nls99_;
          logger.trace('CCK.CC_9819 Start введена формула nlsa= ' ||
                       nls99_);
        EXCEPTION
          WHEN OTHERS THEN
            logger.trace('CCK.CC_9819 Cannot get account nom via ' ||
                         nls99_);
            raise_application_error(- (20203),
                                    '\9351 - Cannot get account nom via ' ||
                                    nls99_ || ' ' || SQLERRM,
                                    TRUE);

        END;
      END IF;

      IF nls99_ IS NULL THEN
        nls99_ := tobopack.gettoboparam('NLS_9910');
      END IF;
      -- erm:='CCK.CC_9819: не определен внеб.контрсч 9910';
      SELECT substr(a.nms, 1, 38), c.okpo
        INTO nms99_, okpo_b
        FROM accounts a, customer c
       WHERE a.kv = gl.baseval
         AND a.nls = nvl(nls99_, '9910')
         AND c.rnk = a.rnk;
    EXCEPTION
      WHEN no_data_found THEN
        logger.trace('CCK.CC_9819 Cannot get account nom via  9910');
        --RAISE err;
        RETURN;
    END;
    IF pr_ = 0 THEN
      par_ := 'VOB9_P';
      dk_  := 1;
      nz_  := ' (вiдкриття)';
    ELSE
      par_ := 'VOB9_R';
      dk_  := 0;
      nz_  := ' (закриття)';
    END IF;
    BEGIN
      SELECT to_number(val) INTO vob_ FROM params WHERE par = par_;
    EXCEPTION
      WHEN no_data_found THEN
        vob_ := 6;
    END;
    --erm:='CCK.CC_9819: ош.Реф.дог ='||ND_ ;
    logger.trace('CCK.CC_9819 Реф.дог =' || nd_);
    BEGIN
      /* определитиь вид дог ( cc_deal ) */
      SELECT d.vidd,
             d.sdate,
             d.cc_id,
             decode(getglobaloption('CCK_NBU'), '1', c.nmkk, c.nmk)
        INTO vidd_, sdate_, cc_id_, fio_
        FROM cc_deal d, customer c
       WHERE d.nd = nd_
         AND d.rnk = c.rnk;
    EXCEPTION
      WHEN no_data_found THEN
        BEGIN
          /* определитиь вид дог ( acc_over ) */
          SELECT DISTINCT o.vidd,
                          o.datd,
                          o.ndoc,
                          decode(getglobaloption('CCK_NBU'),
                                 '1',
                                 c.nmkk,
                                 c.nmk)
            INTO vidd_, sdate_, cc_id_, fio_
            FROM acc_over o, customer c, accounts a
           WHERE o.nd = nd_
             AND o.acc = o.acco
             AND a.acc = o.acc
             AND a.rnk = c.rnk
             AND nvl(o.sos, 0) <> 1;
        EXCEPTION
          WHEN no_data_found THEN
            logger.trace('CCK.CC_9819 Ошибка  Реф.дог =' || nd_);
            RETURN;
            --RAISE err;
        END;
    END;

    IF vidd_ = 9 THEN
      svidd_ := 'угоди гаранттiї';
    ELSIF vidd_ = 19 THEN
      svidd_ := 'угоди акредитиву';
    ELSIF vidd_ = 29 THEN
      svidd_ := 'угоди акцепту';
    ELSIF vidd_ = 39 THEN
      svidd_ := 'угоди авалю';
    ELSIF vidd_ = 4 THEN
      svidd_ := 'угоди на овер. ЮО';
    ELSIF vidd_ = 14 THEN
      svidd_ := 'угоди на овер. ФО';
    ELSIF vidd_ = 24 THEN
      svidd_ := 'угоди на овер. банку';
    ELSIF vidd_ = 203 THEN
      svidd_ := 'угоди Факторингу з рег.';
    ELSIF vidd_ = 204 THEN
      svidd_ := 'угоди Факторингу без рег.';
    ELSE
      svidd_ := 'кредитної угоди';
    END IF;
    nazn_ := substr('Облiк ' || svidd_ || ' № ' || cc_id_ || ' вiд ' ||
                    to_char(sdate_, 'DD-MM-YYYY') || nz_ || ' ' || fio_,
                    1,
                    160);
    BEGIN
      SELECT s.sour
        INTO sour_
        FROM cc_add s
       WHERE nd = nd_
         AND adds = 0;
    EXCEPTION
      WHEN no_data_found THEN
        sour_ := 4;
    END;
    BEGIN
      SELECT k.nls, substr(a.nms, 1, 38), c.okpo
        INTO nls9_, nms9_, okpo_a
        FROM cc_kol k, accounts a, customer c
       WHERE vidd_ = k.vidd
         AND sour_ = k.sour
         AND to_char(k.nls) = a.nls
         AND a.kv = gl.baseval
         AND a.rnk = c.rnk;
    EXCEPTION
      WHEN no_data_found THEN
        --erm := 'CCK.CC_9819: ош.сч. вид='||VIDD_ ||',ист='||SOUR_||'(спр.CC_KOL)';
        logger.trace('CCK.CC_9819: ош.сч. вид=' || vidd_ || ',ист=' ||
                     sour_ || '(спр.CC_KOL)');
        RETURN;
        --RAISE err;
    END;

    sd_ := 100;
    kv_ := gl.baseval;
    gl.ref(ref_);
    INSERT INTO oper
      (REF,
       nd,
       tt,
       vob,
       dk,
       pdat,
       vdat,
       datd,
       datp,
       s,
       s2,
       nam_a,
       nlsa,
       mfoa,
       kv,
       nam_b,
       nlsb,
       mfob,
       kv2,
       nazn,
       userid,
       id_a,
       id_b)
    VALUES
      (ref_,
       ref_,
       'CRD',
       vob_,
       dk_,
       SYSDATE,
       gl.bdate,
       gl.bdate,
       gl.bdate,
       sd_,
       sd_,
       nms9_,
       nls9_,
       gl.amfo,
       kv_,
       nms99_,
       nls99_,
       gl.amfo,
       kv_,
       nazn_,
       user_id,
       okpo_b,
       okpo_a);

    gl.payv(flg_,
            ref_,
            gl.bdate,
            'CRD',
            dk_,
            kv_,
            nls9_,
            sd_,
            kv_,
            nls99_,
            sd_);
  EXCEPTION
    --WHEN err    THEN raise_application_error(-(20000+ern), '\ ' , TRUE );
    WHEN OTHERS THEN
      raise_application_error(- (20000 + ern), SQLERRM, TRUE);
  END cc_9819;
  ----------------------

  PROCEDURE cc_crd(nd_    INT,
                   pr_    INT,
                   refd_  INT,
                   nls_   VARCHAR2,
                   gold_  VARCHAR2,
                   nddop_ NUMBER,
                   t9819_ VARCHAR2,
                   o9819_ VARCHAR2,
                   fio_   VARCHAR2,
                   vlasn_ VARCHAR2,
                   nazn_  VARCHAR2,
                   crdvd_ DATE,
                   crdsn_ VARCHAR2,
                   crdsk_ VARCHAR2) IS

    TYPE nls_typ IS RECORD(
      REF   oper.ref%TYPE,
      nlsa  accounts.nls%TYPE,
      nam_a oper.nam_a%TYPE,
      id_a  oper.id_a%TYPE,
      nlsb  accounts.nls%TYPE,
      nam_b oper.nam_b%TYPE,
      id_b  oper.id_a%TYPE,
      gold  VARCHAR2(254),
      nddop operw.value%TYPE,
      o9819 VARCHAR2(2),
      t9819 VARCHAR2(2),
      fio   operw.value%TYPE,
      vlasn operw.value%TYPE,
      crdvd VARCHAR2(10),
      crdsn VARCHAR2(50),
      crdsk VARCHAR2(3));

    nls_old nls_typ;
    nls_new nls_typ;

    TYPE o9819_typ IS TABLE OF VARCHAR2(50) INDEX BY BINARY_INTEGER;

    m_o9819 o9819_typ;
    m_t9819 o9819_typ;

    vidd_ NUMBER;

    sd_     NUMBER;
    dk_     INT;
    vob_    INT;
    kv_     NUMBER;
    flg_    INT;
    flg5_   INT;
    par_    INT;
    branch_ cc_deal.branch%TYPE;
    l_nlsm  tts.nlsm%TYPE;

    fio_kd     VARCHAR2(70);
    fio_o      VARCHAR2(70);
    cc_id_     VARCHAR2(20);
    sdate_     DATE;
    custtype_  INT;
    nazn_gener VARCHAR2(170);
    nazn_vidd  VARCHAR2(20);
    sos_       NUMBER;
    sos_kd     NUMBER;

  BEGIN

    logger.trace('CCK.CC_CRD Start nd_=' || nd_ || ' pr_=' || pr_ ||
                 ' REFd_=' || refd_ || ' NLS_=' || nls_ || ' T9819_=' ||
                 t9819_ || ' O9819_=' || o9819_ || ' NAZN_=' || nazn_);

    SELECT txt BULK COLLECT INTO m_o9819 FROM cc_kol_o9819 ORDER BY kod;
    SELECT txt
      BULK COLLECT
      INTO m_t9819
      FROM cc_kol_tblank
     ORDER BY tblank;

    BEGIN
      SELECT substr(flags, 38, 1), decode(substr(flags, 38, 1), 1, 5, 0)
        INTO flg_, flg5_
        FROM tts
       WHERE tt = 'CRD';
    EXCEPTION
      WHEN no_data_found THEN
        raise_application_error(- (20000 + 17),
                                '\8999 CCK.CC_CRD: не найдена операция CRD',
                                TRUE);
        logger.trace('CCK.CC_CRD: не найдена операция CRD');
    END;

    --Ищем параметры договора определитиь вид дог ( cc_deal )
    BEGIN
      SELECT d.vidd,
             d.sdate,
             d.cc_id,
             decode(getglobaloption('CCK_NBU'), '1', c.nmkk, c.nmk),
             c.custtype,
             nvl(d.branch, 0),
             d.sos
        INTO vidd_, sdate_, cc_id_, fio_kd, custtype_, branch_, sos_kd
        FROM cc_deal d, customer c
       WHERE d.nd = nd_
         AND d.rnk = c.rnk;

    EXCEPTION
      WHEN no_data_found THEN
        BEGIN
          -- определитиь вид дог ( acc_over )
          SELECT DISTINCT o.vidd,
                          o.datd,
                          o.ndoc,
                          decode(getglobaloption('CCK_NBU'),
                                 '1',
                                 c.nmkk,
                                 c.nmk),
                          c.custtype
            INTO vidd_, sdate_, cc_id_, fio_kd, custtype_
            FROM acc_over o, accounts a, customer c
           WHERE o.nd = nd_
             AND o.acc = o.acco
             AND o.acc = a.acc
             AND a.rnk = c.rnk
             AND nvl(o.sos, 0) <> 1;
        EXCEPTION
          WHEN no_data_found THEN
            logger.trace('CCK.CC_CRD: Помилковий Реф.дог =' || nd_);
            raise_application_error(- (20000 + 1),
                                    '\8999 CCK.CC_CRD: Помилковий Реф.дог =' || nd_,
                                    TRUE);
        END;
    END;

    IF refd_ IS NOT NULL THEN
      BEGIN
        -- nls_old.ref - реф активной записи
        SELECT (SELECT VALUE
                  FROM operw
                 WHERE tag = 'O9819'
                   AND REF = r.ref) o9819,
               (SELECT VALUE
                  FROM operw
                 WHERE tag = 'T9819'
                   AND REF = r.ref) t9819,
               (SELECT VALUE
                  FROM operw
                 WHERE tag = 'GOLD'
                   AND REF = r.ref) gold,
               (SELECT VALUE
                  FROM operw
                 WHERE tag = 'NDDOP'
                   AND REF = r.ref) nddop,
               (SELECT VALUE
                  FROM operw
                 WHERE tag = 'FIO'
                   AND REF = r.ref) fio,
               (SELECT VALUE
                  FROM operw
                 WHERE tag = 'VLASN'
                   AND REF = r.ref) vlasn,
               (SELECT VALUE
                  FROM operw
                 WHERE tag = 'CRDVD'
                   AND REF = r.ref) crdvd,
               (SELECT VALUE
                  FROM operw
                 WHERE tag = 'CRDSN'
                   AND REF = r.ref) crdsn,
               (SELECT VALUE
                  FROM operw
                 WHERE tag = 'CRDSK'
                   AND REF = r.ref) crdsk,
               r.ref ref_now,
               nlsa,
               nam_a,
               nlsb,
               nam_b,
               id_a,
               id_b,
               r.sos
          INTO nls_old.o9819,
               nls_old.t9819,
               nls_old.gold,
               nls_old.nddop,
               nls_old.fio,
               nls_old.vlasn,
               nls_old.crdvd,
               nls_old.crdsn,
               nls_old.crdsk,
               nls_old.ref,
               nls_old.nlsa,
               nls_old.nam_a,
               nls_old.nlsb,
               nls_old.nam_b,
               nls_old.id_a,
               nls_old.id_b,
               sos_
          FROM oper r
         WHERE REF IN (SELECT MAX(REF)
                         FROM (SELECT oo.ref REF,
                                      (SELECT VALUE
                                         FROM operw
                                        WHERE REF = oo.ref
                                          AND tag = 'CRDND'
                                          AND VALUE = refd_) crdnd
                                 FROM nd_ref rr, oper oo
                                WHERE rr.nd = nd_
                                  AND rr.ref = oo.ref
                                  AND oo.sos >= 0)
                        WHERE crdnd IS NOT NULL
                        GROUP BY crdnd);

      EXCEPTION
        WHEN no_data_found THEN
          logger.trace('CCK.CC_CRD: Системi не вдалося знайти вихiдний референс REFd=' ||
                       refd_);
          raise_application_error(- (20000 + 5),
                                  '\8999 CCK.CC_CRD: Системi не вдалося знайти вихiдний референс REFd=' ||
                                  refd_,
                                  TRUE);
      END;
    ELSE
      nls_new.t9819 := t9819_;
    END IF;

    -- исключаем нелогичные изменения
    IF refd_ IS NULL THEN
      nls_new.o9819 := '1';
    ELSE
      nls_new.t9819 := nvl(nls_old.t9819, nls_new.t9819);
      nls_new.o9819 := nvl(o9819_, nls_old.o9819);
    END IF;

    nls_new.gold  := nvl(gold_, nls_old.gold);
    nls_new.nddop := nddop_;
    nls_new.fio   := nvl(fio_, nls_old.fio);
    nls_new.vlasn := nvl(vlasn_, nls_old.vlasn);
    nls_new.crdvd := nvl(nvl(to_char(crdvd_, 'dd.mm.yyyy'), nls_old.crdvd),
                         to_char(gl.bdate, 'dd.mm.yyyy'));
    nls_new.crdsn := nvl(crdsn_, nls_old.crdsn);
    nls_new.crdsk := nvl(crdsk_, nls_old.crdsk);

    IF nls_new.vlasn IS NULL THEN
      BEGIN
        SELECT val INTO nls_new.vlasn FROM params WHERE par = 'NAME';
      EXCEPTION
        WHEN no_data_found THEN
          raise_application_error(- (20000 + 6),
                                  '\8999 CCK.CC_CRD: Не введен власник документа.',
                                  TRUE);
      END;
    END IF;

    IF nls_new.fio IS NULL THEN
      raise_application_error(- (20000 + 6),
                              '\8999 CCK.CC_CRD: Не введен ПIБ кому належить документи.',
                              TRUE);
    END IF;

    -- считаем что это не проводка, а кор-ка данных
    IF nls_new.o9819 = nls_old.o9819 THEN

      UPDATE operw
         SET VALUE = nls_new.gold
       WHERE REF = nls_old.ref
         AND tag = 'GOLD';
      IF SQL%ROWCOUNT = 0 THEN
        INSERT INTO operw
          (REF, tag, VALUE)
        VALUES
          (nls_old.ref, 'GOLD', nls_new.gold);
      END IF;

      UPDATE operw
         SET VALUE = nls_new.nddop
       WHERE REF = nls_old.ref
         AND tag = 'NDDOP';
      IF SQL%ROWCOUNT = 0 THEN
        INSERT INTO operw
          (REF, tag, VALUE)
        VALUES
          (nls_old.ref, 'NDDOP', nls_new.nddop);
      END IF;

      UPDATE operw
         SET VALUE = nls_new.crdvd
       WHERE REF = nls_old.ref
         AND tag = 'CRDVD';
      IF SQL%ROWCOUNT = 0 THEN
        INSERT INTO operw
          (REF, tag, VALUE)
        VALUES
          (nls_old.ref, 'CRDVD', nls_new.crdvd);
      END IF;

      UPDATE operw
         SET VALUE = nls_new.fio
       WHERE REF = nls_old.ref
         AND tag = 'FIO';
      IF SQL%ROWCOUNT = 0 THEN
        INSERT INTO operw
          (REF, tag, VALUE)
        VALUES
          (nls_old.ref, 'FIO', nls_new.fio);
      END IF;

      UPDATE operw
         SET VALUE = nls_new.vlasn
       WHERE REF = nls_old.ref
         AND tag = 'VLASN';
      IF SQL%ROWCOUNT = 0 THEN
        INSERT INTO operw
          (REF, tag, VALUE)
        VALUES
          (nls_old.ref, 'VLASN', nls_new.vlasn);
      END IF;

      UPDATE operw
         SET VALUE = nls_new.crdsn
       WHERE REF = nls_old.ref
         AND tag = 'CRDSN';
      IF SQL%ROWCOUNT = 0 THEN
        INSERT INTO operw
          (REF, tag, VALUE)
        VALUES
          (nls_old.ref, 'CRDSN', nls_new.crdsn);
      END IF;

      UPDATE operw
         SET VALUE = nls_new.crdsk
       WHERE REF = nls_old.ref
         AND tag = 'CRDSK';
      IF SQL%ROWCOUNT = 0 THEN
        INSERT INTO operw
          (REF, tag, VALUE)
        VALUES
          (nls_old.ref, 'CRDSK', nls_new.crdsk);
      END IF;

      GOTO the_end;
    END IF;
    IF sos_kd < 10 THEN
      logger.trace('CCK.CC_CRD: Договiр "' || nls_new.gold ||
                   '" не авторизований!');
      raise_application_error(- (20000 + 6),
                              '\8999 CCK.CC_CRD: Договiр "' || nls_new.gold ||
                              '" не авторизований!',
                              TRUE);
    END IF;
    IF sos_kd > 14 THEN
      logger.trace('CCK.CC_CRD: Договiр "' || nls_new.gold ||
                   '" вже закрит!');
      raise_application_error(- (20000 + 6),
                              '\8999 CCK.CC_CRD: Договiр "' || nls_new.gold ||
                              '" уже закритий!',
                              TRUE);
    END IF;
    IF sos_ < 5 AND sos_ > -2 THEN
      logger.trace('CCK.CC_CRD: Документ "' || nls_new.gold ||
                   '" перебуває на вiзуваннi. Подальшi змiни по рахунку неможливi!');
      raise_application_error(- (20000 + 8),
                              '\8999 CCK.CC_CRD: Документ "' ||
                              nls_new.gold ||
                              '" перебуває на вiзуваннi. Подальшi змiни по рахунку неможливi!',
                              TRUE);
    END IF;

    IF nls_old.o9819 || nls_new.o9819 IN (10,
                                          12,
                                          14,
                                          16,
                                          18,
                                          30,
                                          32,
                                          34,
                                          36,
                                          38,
                                          50,
                                          52,
                                          54,
                                          56,
                                          58,
                                          70,
                                          72,
                                          74,
                                          76,
                                          78,
                                          90,
                                          92,
                                          94,
                                          96,
                                          98,
                                          23,
                                          45,
                                          67,
                                          89) OR refd_ IS NULL THEN
      NULL;
    ELSE
      logger.trace('CCK.CC_CRD: Змiнити статус з "' || nls_old.o9819 || '-' ||
                   m_o9819(nvl(nls_old.o9819, 0) + 1) || '" на "' ||
                   nls_new.o9819 || '-' ||
                   m_o9819(nvl(nls_new.o9819, 0) + 1) || '" неможливо!');
      raise_application_error(- (20000 + 10),
                              '\8999 CCK.CC_CRD: Змiнити статус з "' ||
                              nls_old.o9819 || '-' ||
                              m_o9819(nvl(nls_old.o9819, 0) + 1) ||
                              '" на "' || nls_new.o9819 || '-' ||
                              m_o9819(nvl(nls_new.o9819, 0) + 1) ||
                              '" неможливо!',
                              TRUE);
      --raise_application_error(-(20000+10), 'CCK.CC_CRD: Змiнити статус з "'||nls_old.O9819||'" на "'||nls_new.O9819|| '" неможливо!', TRUE );
    END IF;

    -- Ищем сторону Б 9910
    IF nls_new.o9819 IN ('0', '1') THEN
      SELECT nlsm,
             substr(flags, 38, 1),
             decode(substr(flags, 38, 1), 1, 5, 0)
        INTO l_nlsm, flg_, flg5_
        FROM tts
       WHERE tt = 'CRD';
      IF l_nlsm IS NULL THEN
        nls_new.nlsb := tobopack.gettoboparam('NLS_9910');
      ELSE
        IF substr(l_nlsm, 1, 2) = '#(' THEN
          -- Dynamic account number present
          BEGIN
            EXECUTE IMMEDIATE 'SELECT ' ||
                              substr(l_nlsm, 3, length(l_nlsm) - 3) ||
                              ' FROM DUAL'
              INTO nls_new.nlsb;
          EXCEPTION
            WHEN OTHERS THEN
              raise_application_error(- (20203),
                                      '\9351 - Cannot get account nom via ' ||
                                      l_nlsm || ' ' || SQLERRM,
                                      TRUE);
          END;
        ELSE
          nls_new.nlsb := l_nlsm;
        END IF;
      END IF;
    ELSIF -- возврат на 9819 c транзита (3,5,7,9)
     nls_new.o9819 IN ('3', '5', '7', '9') THEN
      nls_new.nlsb  := nls_old.nlsb;
      nls_new.nam_b := nls_old.nam_b;
      nls_new.id_b  := nls_old.id_b;
    ELSE
      nls_new.nlsb := nls_;
      -- nam_b - заполняется ниже
    END IF;

    IF nls_new.nlsb IS NULL THEN
      raise_application_error(- (20000 + 12),
                              '\8999 Не знайден рахунок для кореспонденцiї з рахунком 9819!',
                              TRUE);
    END IF;
    --СЧЕТ Б
    IF nls_new.o9819 NOT IN ('3', '5', '7', '9') THEN
      BEGIN
        SELECT substr(a.nms, 1, 38), c.okpo
          INTO nls_new.nam_b, nls_new.id_b
          FROM accounts a, customer c
         WHERE a.kv = gl.baseval
           AND a.nls = nls_new.nlsb
           AND c.rnk = a.rnk;
      EXCEPTION
        WHEN no_data_found THEN
          logger.trace('CCK.CC_CRD: У системi рахунок ' || nls_new.nlsb ||
                       ' не знайден');
          raise_application_error(- (20000 + 15),
                                  '\8999 CCK.CC_CRD: У системi рахунок ' ||
                                  nls_new.nlsb || ' не знайден',
                                  TRUE);
      END;
    END IF;

    -- СЧЕТ А   (9819)
    IF nls_new.o9819 IN (1, 3, 5, 7, 9) THEN
      -- в справочнике
      BEGIN
        SELECT --+ ORDERED
         k.nls, substr(a.nms, 1, 38), c.okpo
          INTO nls_new.nlsa, nls_new.nam_a, nls_new.id_a
          FROM cc_kol2 k, accounts a, customer c
         WHERE a.kv = gl.baseval
           AND a.rnk = c.rnk
           AND k.tblank = nls_new.t9819
           AND k.custtype = custtype_
           AND k.nls = a.nls;

        --    and a.kf=gl.kf;
      EXCEPTION
        WHEN no_data_found THEN
          raise_application_error(- (20000 + 17),
                                  '\8999 CCK.CC_CRD: не найден счет 9819 для типа=' ||
                                  m_t9819(nls_new.t9819) || '; Вида лица=' ||
                                  custtype_ || ' и бранча=' || branch_,
                                  TRUE);
          logger.trace('CCK.CC_CRD: не найден счет 9819 для вида=' ||
                       nls_new.t9819 || '; Вида лица =' || custtype_ ||
                       ' и бранча=' || branch_);
      END;
    ELSE
      -- в преведущей операции
      nls_new.nlsa  := nls_old.nlsa;
      nls_new.nam_a := nls_old.nam_a;
      nls_new.id_a  := nls_old.id_a;
    END IF;

    IF nls_new.o9819 IN ('1', '3', '5', '7', '9') THEN
      par_ := 1;
      dk_  := pr_;
    ELSE
      par_ := 2;
      dk_  := pr_ - 1;
    END IF;
    BEGIN
      SELECT vob
        INTO vob_
        FROM tts_vob
       WHERE tt = 'CRD'
         AND ord = par_;
    EXCEPTION
      WHEN no_data_found THEN
        NULL;
    END;

    --  NAZN_GENER:=Substr('Облiк '|| m_T9819(nls_new.T9819)|| ' № '||CC_ID_ ||' вiд '||
    --         to_char(sdate_,'DD-MM-YYYY') ||' '|| m_O9819(nls_new.O9819+1) || ' ' || FIO_KD,  1, 160);

    IF nls_ IS NULL THEN
      IF vidd_ IN (1, 2, 3, 11, 12, 13) THEN
        nazn_vidd := ' КД. ';
      ELSIF vidd_ IN (9, 19, 29, 39) THEN
        nazn_vidd := ' ДГ. ';
      ELSIF vidd_ IN (4, 14) THEN
        nazn_vidd := ' ДО. ';
      END IF;

      IF nls_new.o9819 IN (2, 3) THEN
        BEGIN
          SELECT decode(getglobaloption('CCK_NBU'), '1', c.nmkk, c.nmk)
            INTO fio_o
            FROM customer c, accounts a
           WHERE c.rnk = a.rnk
             AND a.kv = gl.baseval
             AND a.nls = nls_new.nlsb;
        EXCEPTION
          WHEN no_data_found THEN
            raise_application_error(- (20000 + 18),
                                    '\8999 CCK.CC_CRD: не знайден рахунок ' ||
                                    nls_new.nlsb,
                                    TRUE);
        END;

        nazn_gener := fio_kd || '. ' || m_o9819(nls_new.o9819 + 1) || ' ' ||
                      fio_o || nazn_vidd || '№ ' || cc_id_ || ' вiд ' ||
                      to_char(sdate_, 'DD-MM-YYYY');
      ELSE
        nazn_gener := fio_kd || '. ' || m_o9819(nls_new.o9819 + 1) ||
                      nazn_vidd || '№ ' || cc_id_ || ' вiд ' ||
                      to_char(sdate_, 'DD-MM-YYYY');
      END IF;
    END IF;

    sd_ := 100;
    kv_ := gl.baseval;

    gl.ref(nls_new.ref);

    gl.in_doc3(nls_new.ref,
               'CRD',
               vob_,
               nls_new.ref,
               SYSDATE,
               gl.bdate,
               dk_,
               kv_,
               sd_,
               kv_,
               sd_,
               NULL,
               gl.bdate,
               gl.bdate,
               nls_new.nam_a,
               nls_new.nlsa,
               gl.amfo,
               nls_new.nam_b,
               nls_new.nlsb,
               gl.amfo,
               substr(nvl(nazn_, nazn_gener), 1, 160),
               NULL,
               nls_new.id_a,
               nls_new.id_b,
               NULL,
               NULL,
               flg5_,
               NULL,
               user_id);

    IF dk_ < 2 THEN
      gl.payv(flg_,
              nls_new.ref,
              gl.bdate,
              'CRD',
              dk_,
              kv_,
              nls_new.nlsa,
              sd_,
              kv_,
              nls_new.nlsb,
              sd_);
    END IF;

    INSERT INTO operw
      (REF, tag, VALUE)
    VALUES
      (nls_new.ref, 'O9819', nls_new.o9819);
    INSERT INTO operw
      (REF, tag, VALUE)
    VALUES
      (nls_new.ref, 'T9819', nls_new.t9819);
    INSERT INTO operw
      (REF, tag, VALUE)
    VALUES
      (nls_new.ref, 'CRDND', nvl(refd_, nls_new.ref));
    INSERT INTO operw
      (REF, tag, VALUE)
    VALUES
      (nls_new.ref, 'CRDVD', to_char(crdvd_, 'dd.mm.yyyy'));
    INSERT INTO operw
      (REF, tag, VALUE)
    VALUES
      (nls_new.ref, 'GOLD', nls_new.gold);
    INSERT INTO operw
      (REF, tag, VALUE)
    VALUES
      (nls_new.ref, 'NDDOP', REPLACE(to_char(nls_new.nddop), '.', ','));
    INSERT INTO operw
      (REF, tag, VALUE)
    VALUES
      (nls_new.ref, 'FIO', nls_new.fio);
    INSERT INTO operw
      (REF, tag, VALUE)
    VALUES
      (nls_new.ref, 'VLASN', nls_new.vlasn);
    INSERT INTO operw
      (REF, tag, VALUE)
    VALUES
      (nls_new.ref, 'CRDSN', nls_new.crdsn);
    INSERT INTO operw
      (REF, tag, VALUE)
    VALUES
      (nls_new.ref, 'CRDSK', nls_new.crdsk);
    INSERT INTO operw (REF, tag, VALUE) VALUES (nls_new.ref, 'SUMGD', '1');
    INSERT INTO operw (REF, tag, VALUE) VALUES (nls_new.ref, 'ND', nd_);

    INSERT INTO nd_ref (nd, REF) VALUES (nd_, nls_new.ref);

    <<the_end>>
    NULL;

  END cc_crd;

  PROCEDURE cc_print(mod_ INT, dat1_ DATE, dat2_ DATE) IS

    -- Печати разные
    -- mod_  - режим
    -- dat1_ - дата начала
    -- dat2_ - дата конца

    nom1_ NUMBER;
    eqv1_ NUMBER;
    nom2_ NUMBER;
    eqv2_ NUMBER;
    eqv3_ NUMBER;
    eqv4_ NUMBER; --исторический экв
    eqv5_ NUMBER; --усушка-переоценка(разница между офф.экв и историческим экв)
    n1_   NUMBER;
    n2_   NUMBER;
    n3_   NUMBER;
    n4_   NUMBER;
    zal_  NUMBER;
    rez_  NUMBER;
    rezq_ NUMBER;
    zalq_ NUMBER;
  BEGIN

    IF mod_ = 1 THEN

      DELETE FROM cck_an_tmp;
      COMMIT;
      FOR k IN (SELECT acc, kv
                  FROM accounts
                 WHERE kv <> 980
                   AND daos <= dat2_
                   AND substr(nbs, 1, 1) > '0'
                   AND substr(nbs, 1, 1) < '5'
                   AND (dazs IS NULL OR dazs >= dat1_ AND dazs <= dat2_)) LOOP
        BEGIN
          --эквивалент на DAT1_
          SELECT ostf - dos + kos
            INTO nom1_
            FROM saldoa
           WHERE acc = k.acc
             AND (k.acc, fdat) = (SELECT acc, MAX(fdat)
                                    FROM saldoa
                                   WHERE acc = k.acc
                                     AND fdat <= dat1_
                                   GROUP BY acc);
          eqv1_ := gl.p_icurval(k.kv, nom1_, dat1_);
        EXCEPTION
          WHEN no_data_found THEN
            nom1_ := 0;
            eqv1_ := 0;
        END;
        BEGIN
          --номинал + эквивалент на DAT2_
          SELECT ostf - dos + kos
            INTO nom2_
            FROM saldoa
           WHERE acc = k.acc
             AND (k.acc, fdat) = (SELECT acc, MAX(fdat)
                                    FROM saldoa
                                   WHERE acc = k.acc
                                     AND fdat <= dat2_
                                   GROUP BY acc);
          eqv2_ := gl.p_icurval(k.kv, nom2_, dat2_);
        EXCEPTION
          WHEN no_data_found THEN
            nom2_ := 0;
            eqv2_ := 0;
        END;
        --история между DAT1_ и DAT2_
        BEGIN
          SELECT nvl(SUM(gl.p_icurval(k.kv, kos - dos, fdat)), 0)
            INTO eqv3_
            FROM saldoa
           WHERE acc = k.acc
             AND fdat >= dat1_
             AND fdat <= dat2_;
        EXCEPTION
          WHEN no_data_found THEN
            eqv3_ := 0;
        END;

        eqv4_ := eqv1_ + eqv3_; --исторический экв со знаком
        eqv5_ := eqv2_ - eqv4_; --дельта со знаком

        IF nom2_ <> 0 OR eqv2_ <> 0 OR eqv3_ <> 0 OR eqv4_ <> 0 OR
           eqv4_ <> 0 THEN
          -- N1   - ном ДЕБЕТ
          -- N2   - ном КРЕДИТ
          IF nom2_ < 0 THEN
            n1_ := -nom2_;
            n2_ := 0;
          ELSE
            n1_ := 0;
            n2_ := nom2_;
          END IF;
          -- N3   - экв ДЕБЕТ
          -- N4   - экв КРЕДИТ
          IF eqv2_ < 0 THEN
            n3_ := -eqv2_;
            n4_ := 0;
          ELSE
            n3_ := 0;
            n4_ := eqv2_;
          END IF;
          -- REZ  - ист экв ДЕБЕТ
          -- REZQ - ист экв КРЕДИТ
          IF eqv4_ < 0 THEN
            rez_  := -eqv4_;
            rezq_ := 0;
          ELSE
            rez_  := 0;
            rezq_ := eqv4_;
          END IF;
          -- ZAL  - дельта эвк ДЕБЕТ
          -- ZALQ - дельта эвк КРЕДИТ
          IF eqv5_ < 0 THEN
            zal_  := -eqv5_;
            zalq_ := 0;
          ELSE
            zal_  := 0;
            zalq_ := eqv5_;
          END IF;
          -- ACC  - асс счета
          INSERT INTO cck_an_tmp
            (acc, n1, n2, n3, n4, rez, rezq, zal, zalq)
          VALUES
            (k.acc, n1_, n2_, n3_, n4_, rez_, rezq_, zal_, zalq_);
        END IF;
      END LOOP;
      COMMIT;

    END IF; -- MOD_= 1

  END cc_print;
  -------------------------------

  PROCEDURE cc_reports(p_id NUMBER) IS
    p_str VARCHAR2(100);
  BEGIN
    null;
    /* BEGIN

        SELECT func
          INTO p_str
          FROM (SELECT t1.id, t1.name, t1.func
                  FROM v_cck_rep_list_fl t1
                UNION
                SELECT t2.id, t2.name, t2.func
                  FROM v_cck_rep_list_yl t2)
         WHERE id = p_id
           AND rownum = 1;

      EXCEPTION
        WHEN no_data_found THEN
          raise_application_error(- (20209)
                                 ,'\8999    CC_REPORTS Не задана функция для выполнения'
                                 ,TRUE);
      END;

      g_reports := 1;

      IF p_str IS NOT NULL THEN
        EXECUTE IMMEDIATE 'truncate table tmp_cck_rep';
        pul.set_mas_ini('cc_reports_id'
                       ,to_char(p_id)
                       ,'Код функції по якій зроблен звіт');
        EXECUTE IMMEDIATE 'begin ' || p_str || '; end;';
      ELSE
        raise_application_error(- (20209)
                               ,'\8999   CC_REPORTS Не задана функция для выполнения'
                               ,TRUE);
      END IF;

      g_reports := 0;
      ROLLBACK;

    EXCEPTION
      WHEN OTHERS THEN
        g_reports := 0;
        ROLLBACK;
        raise_application_error(- (20203)
                               ,'\8999 CC_REPORTS: Функцию ' || p_str ||
                                ' выполнить не удалось по причине: ' ||
                                SQLERRM
                               ,TRUE);*/
  END;

  -------------------------------
  FUNCTION reservation_percent(p_acck    NUMBER,
                               p_sum     NUMBER,
                               p_tip     NUMBER := 0,
                               p_acr_dat DATE := NULL,
                               p_mdate   DATE := NULL,
                               p_s       NUMBER := NULL) RETURN NUMBER IS

    l_acr_dat DATE;
    ir_       NUMBER;
    nint_     NUMBER;
    dat31_    DATE := last_day(gl.bdate);
    l_ir_k    NUMBER;
    l_sum_ret NUMBER;
    l_mdate   DATE;
    l_s       NUMBER;
  BEGIN
    l_sum_ret := p_sum;

    IF p_acr_dat IS NULL OR p_mdate IS NULL OR p_s IS NULL THEN
      SELECT i.acr_dat,
             least(nvl(a.mdate, i.stp_dat), nvl(i.stp_dat, a.mdate)),
             abs(a.ostc)
        INTO l_acr_dat, l_mdate, l_s
        FROM int_accn i, accounts a
       WHERE i.acc = p_acck
         AND i.id = 0
         AND i.acc = a.acc;
    ELSE
      l_acr_dat := p_acr_dat;
      l_mdate   := p_mdate;
      l_s       := p_s;
    END IF;

    --1-й проц период по фактич. остаткам
    IF l_acr_dat < gl.bdate - 1 THEN
      nint_ := 0;
      acrn.p_int(p_acck, 0, l_acr_dat + 1, gl.bdate - 1, nint_, NULL, 0);
      l_sum_ret := l_sum_ret + nint_;
    END IF;

    IF l_sum_ret < 0 THEN
      l_sum_ret := 0;
    ELSE
      --2-й проц период по плановому исход остатку
      IF l_mdate > gl.bdate AND l_mdate <= dat31_ THEN
        --завершение договора в тек месяце
        dat31_ := l_mdate - 1;
      END IF;
      --формулу вывела Сухова - доке
      ir_       := acrn.fprocn(p_acck, 0, gl.bdate) / 100;
      l_ir_k    := (dat31_ - gl.bdate + 1) / 365;
      l_ir_k    := ir_ * l_ir_k;
      l_sum_ret := round((l_sum_ret - l_ir_k * l_s) / (1 - l_ir_k), 0);

      IF l_sum_ret < 0 THEN
        l_sum_ret := 0;
      ELSIF l_sum_ret > p_sum THEN
        l_sum_ret := p_sum;
      END IF;

    END IF;

    RETURN l_sum_ret;
  EXCEPTION
    WHEN no_data_found THEN
      RETURN p_sum;
  END;

  -------------------------------

  PROCEDURE cc_asg(nregim_ INT, mode_ INT DEFAULT 1) IS

    /* авто разбор счета гашения
      nREGIM_ = 0 Весь КП банка
      nREGIM_ < 0  разбор сч гашения по одному КД = -ND_

    27.07.2016 - Введено додатковий параметр в процедуру mode_ int:
                    mode_ = 1 процедура буде враховувати рахунки 2625 як рахунки погашення
                    mode_ = 2 процедура НЕ буде враховувати рахунки 2625 як рахунки погашення
    28.11.2012 - Безакцептное списание счетов 2600 для методов больше 10   по принцыпу 23.05/2011
    23.05/2011 - Безакцептное списание пени
               - списание со счетов 2620 для методов больше 10
               - Возможность задания первичного приоритета по сч.задолженности для нескольких договоров
                 а не по договорам
    04.07.2008 Sta - Гл.Параметр CC_BLK=1, Доср.погаш. HEблокир только в "платежные.дни"
    Если КД имеет личный признак блокировки,       то досрочное погаш НЕ допускается никогда
    Иначе Если АБС имеет общий признак блокировки, то досрочное погаш допускается только в плажежные дни.
    Иначе -  досрочное погаш допускается в любой день.

    */

    pl_dat  DATE; -- платежная дата  м.б. меньше (вых) банковской
    ntmp_   INT;
    pl_den_ INT;
    l_sumg  NUMBER;
    l_sumo  NUMBER;
    sum_ss_ NUMBER; --сколько погашено тела кредита

    -- по умолчанию из гл.пар
    cc_blk_    CHAR(1) := nvl(getglobaloption('CC_BLK'), '0');
    mode_e     CHAR(1) := nvl(getglobaloption('ASG-SN'), '0');
    mode_i     CHAR(1) := nvl(getglobaloption('CC_GPK'), '0');
    l_int_debt CHAR(1); -- что счетать процентным долгом
    l_holidays CHAR(1); -- Каникулы
    fl_        INT;
    vob_       INT;
    vob_980    INT;
    vob_val    INT;
    vob_mv     INT;
    s29_       NUMBER;
    s_         NUMBER; -- остаток на разбираемом счете который необходимо погасить после кор-ки (когда пог-ся должен не весь)
    ref_       INT;
    lim8_      NUMBER;
    yn_        INT := 1;
    dat_sn1_   DATE; -- дата проводки по нач %    (остаток для погашения)
    dat_sn2_   DATE; -- дата закрытого периода по нач % (в назн.пл)

    ratn_advanced NUMBER := 0; -- Проц ставка за достр. погашення

    ostb_8999 NUMBER;
    tt_       CHAR(3);
    tt_bpk    CHAR(3) := 'W4X';
    n_sos     INT;
    tt_odb    CHAR(3) := 'ASG';

    per_pr    VARCHAR2(10);
    nazn_     VARCHAR2(160);
    s_980     NUMBER;
    s2900_    VARCHAR2(15);
    s2800_    VARCHAR2(15);
    plan_pog_ NUMBER; -- плановая сумма погашения тела
    s_a_      NUMBER; -- сумма комиссии за досрочное погашение
    l_sum_sn8 NUMBER; -- сумма ПЕНИ в вал договора

    nls_2902 VARCHAR2(15);
    nls_6024 VARCHAR2(15);
    nms_6024 VARCHAR2(38);
    nls_6397 VARCHAR2(15);
    l_nlsk   VARCHAR2(15);
    nls_9603 VARCHAR2(15);
    nls_9910 VARCHAR2(15);
    nls_sd4  VARCHAR2(15);
    nls_8006 VARCHAR2(15);
    cc_pay_s INT := nvl(getglobaloption('CC_PAY_S'), '0'); -- 0 -считать сумму досрочным погашением при  погашении превышающем
    --    текущий лимит ГПК минус текущий платеж
    -- 1- считать сумму досрочным с учетом уже уплаченной суммы за
    --    досрочное погашение
  BEGIN
    BEGIN
      SELECT nvl(substr(TRIM(val), 1, 3), 'W4X')
        INTO tt_bpk
        FROM params$global
       WHERE par = 'ASG_FOR_BPK';
    EXCEPTION
      WHEN no_data_found THEN
        NULL;
    END;
    BEGIN
      SELECT vob
        INTO vob_980
        FROM tts_vob
       WHERE tt = 'ASG'
         AND ord = 1;
    EXCEPTION
      WHEN no_data_found THEN
        vob_980 := 6;
    END;
    BEGIN
      SELECT vob
        INTO vob_val
        FROM tts_vob
       WHERE tt = 'ASG'
         AND ord = 2;
    EXCEPTION
      WHEN no_data_found THEN
        vob_val := 46;
    END;
    BEGIN
      SELECT vob
        INTO vob_mv
        FROM tts_vob
       WHERE tt = 'ASG'
         AND ord = 3;
    EXCEPTION
      WHEN no_data_found THEN
        vob_mv := 16;
    END;

    BEGIN
      SELECT decode(nvl(substr(flags, 38, 1), '0'), '1', 2, 0)
        INTO fl_
        FROM tts
       WHERE tt = 'ASG';
    EXCEPTION
      WHEN no_data_found THEN
        raise_application_error(- (20203),
                                '\8999 CCK_ASG: В операції ASG не описано флаг 37. Зверніться до адміністратора.');
    END;
    BEGIN
      SELECT nlsb, nlsa INTO s2900_, s2800_ FROM tts WHERE tt = 'ASK';
    EXCEPTION
      WHEN no_data_found THEN
        s2900_ := NULL;
        s2800_ := NULL;
    END;

    -- выбирает все КД в которых есть отстаток где SG и 262*, 2600 имеют остатки

    FOR k IN (SELECT d.nd,
                     d.vidd,
                     d.branch,
                     a8.dapp,
                     a.tip,
                     a.acc accd,
                     a.nls nlsd,
                     substr(a.nms, 1, 38) nmsd,
                     a.kv,
                     d.wdate,
                     c.okpo,
                     i8.basey,
                     a8.ostx,
                     i8.basem,
                     a.lim s29_lim,
                     a8.vid typ_gpk,
                     i8.s pl_day_ss,
                     d.sos,
                     c.rnk,
                     i8.freq,
                     a8.ostc,
                     a8.kos,
                     a8.acc acc8,
                     a8.kv kv8,
                     -----------------------------------------
                     cck_app.get_nd_txt(d.nd, 'DAYNP') daynp,
                     cck_app.get_nd_txt(d.nd, 'CCRNG') rang,
                     cck_app.get_nd_txt(d.nd, 'FLAGS') flags,
                     -----------------------------------------
                     nvl((SELECT x.blk
                           FROM nd_txt y, cc_rang_name x
                          WHERE y.nd = d.nd
                            AND y.tag = 'CCRNG'
                            AND to_number(y.txt) = x.rang),
                         0) blk,
                     nvl((SELECT lpad(txt, 2, '0')
                           FROM nd_txt
                          WHERE nd = d.nd
                            AND tag = 'DAYSN'),
                         to_char(lpad(i8.s, 2, '0'))) pl_day_sn
                    ,a.dazs
                FROM accounts a,
                     nd_acc n,
                     nd_acc n8,
                     accounts a8,
                     customer c,
                     int_accn i8,
                     (SELECT *
                        FROM cc_deal
                       WHERE sdate < gl.bdate
                         AND sos >= 1
                         AND sos < 14
                         AND vidd IN (1, 2, 3, 11, 12, 13)
                         and substr(prod, 1, 1) <> '9'
                         AND (nregim_ < 0 AND nd = -nregim_ OR nregim_ >= 0)) d
               WHERE a8.tip = 'LIM'
                 AND n8.acc = a8.acc
                 AND n8.nd = d.nd
                 AND (a.dapp IS NULL OR a.dapp <= gl.bdate)
                 AND i8.acc = a8.acc
                 AND i8.id = 0
                 AND ((a.tip = 'SG' AND a.ostc > 0) OR
                     (a.nbs IN ('2620', '2600') AND a.ostc > 0) OR
                     a.nbs = '2625')
                 AND a8.rnk = c.rnk
                 AND d.nd = n.nd
                 AND a.acc = n.acc
              ----------- AND a.ostC=a.ostB  -------------------------------------------------
               ORDER BY d.sdate, d.wdate, d.sos DESC,
                        decode(a.nbs, '3739', 1, '2620', 2, 3)) LOOP
      --цикл по счетам гашения

      if k.dazs is not null and k.dazs>gl.bDATE then
        logger.info('CCK.CC_ASG: Рахунок '||k.nlsd||' закритий '||to_char(k.dazs,'dd.mm.yyyy')||'. Списання неможливе. Пропускаємо');
        continue;
      end if;

      --перевірка mode_ на необхідність врахування рахунків 2625 як рах. погашення
      IF (mode_ = 2) AND (k.nlsd LIKE '2625%') THEN
        continue;
      ELSE
        /*
        cc_rang_name
        rang|name
        ----|-----------------------------------------------|CUSTTYPE| BLK
        0    Без авто-розбору
        1    Стандартний
        2    Тільки основний борг (Чорнобильці)    3
        5    По платiжним дням (на рах. SG) основного боргу    3      2
        10   По платiжним дням з 262* або рах. погашення SG    3      14
        11   Доходи, основна заборгованість                  3      14
        --------
         Платежный ли сегодня день ?
         Если платежный день (DAYNP=-2 без сдвига) тогда считаем что день погашения следующий
         платежн?й день по ГПК с проверкой что день платежа не совпал с в?ходлн?м

         24.07.2014 Поиск платежного дня Сейчас для поиска платежного дня используется запрос:
            select count(*), nvl(sum(sumg),0), nvl( sum(sumo),0)
            into pl_Den_,l_sumg,l_sumo  from cc_lim
            where sumo > 0  and  cck_app.CorrectDate2( gl.baseval, fdat, nvl(k.daynp,1) ) =gl.bdate
              and fdat < gl.bdate + 30 and fdat > gl.bdate-30  and nd = k.ND  and sumo >0  ;

          Проблема в том что по новым договорам переменная k.daynp=-2 ( без корректировки по выходным дням)
          Предлагаю заменить nvl(k.daynp,1) на decode (k.daynp,null, CC_DAYNP, -2, CC_DAYNP, k.daynp).
          cck.CC_DAYNP – глобальная переменная пакета ССК (у всех установлена = 1).
          (если что еще раз выложу скрипт на установку единицы во всех РУ)
        */
        --------------------------------------------------------------------------------

        IF k.daynp IS NULL THEN
          ntmp_ := cck.cc_daynp;
        ELSIF k.daynp = -2 THEN
          ntmp_ := cck.cc_daynp;
        ELSE
          ntmp_ := k.daynp;
        END IF;

        SELECT COUNT(*), nvl(SUM(sumg), 0), nvl(SUM(sumo), 0)
          INTO pl_den_, l_sumg, l_sumo
          FROM cc_lim
         WHERE nd = k.nd
           AND sumo > 0
           AND fdat < gl.bdate + 30
           AND fdat > gl.bdate - 30
           AND cck_app.correctdate2(gl.baseval, fdat, ntmp_) = gl.bdate;
        --------------------------------------------------------------------------------
        -- Блокировка погашения  в неплатежные дни для блк >=10,11,14,15
        -- если оплата по платежным дням и договор нормальный (не просроченный) тогда гасить больше ничего не надо
        IF k.sos = 10 AND k.wdate >= gl.bdate AND k.blk IN (10, 11, 14, 15) THEN
          IF pl_den_ = 0 THEN
            GOTO met_kon;
          END IF; -- это НЕ платежный день
        END IF;

        -- запрещаем списание для блк < 10 всего остатка не со счетов гашения
        -- (то есть счета 2620 притянуты информативно , не для разбора  как в Демарке)
        IF k.blk < 10 AND k.tip != 'SG ' THEN
          GOTO met_kon;
        END IF;

        -- Для  договоров  с датой окончание считаем день погашения каждый день
        IF k.wdate <= gl.bdate THEN
          /* просрочка или завершение договора */
          dat_sn1_ := gl.bdate;
          dat_sn2_ := gl.bdate - 1;
          pl_den_  := 1;
        END IF;

        -- вычитываем остаток (для случаев когда счет прикреплен к двум КД)
        SELECT least(ostb, ostc)
          INTO s29_
          FROM accounts
         WHERE acc = k.accd;

        IF k.nlsd LIKE '2625%' AND k.sos = 10 THEN
          s29_ := 10000000000000; -- Неорганиченный. т.к. неизвестный. М.б будет сервис - узнать остаток
        ELSE
          s29_ := s29_ + k.s29_lim; -- Вычитаем неснижаемый остаток с учетом блокировок и оверд
        END IF;

        l_holidays := nvl(substr(k.flags, 1, 1), mode_i);
        l_int_debt := nvl(substr(k.flags, 2, 1), mode_e); -- =1 % за прош.мес, =0 % за прош.день

        -- 11.09.2014 --Для старых КД (k.blk=0) можно платить в любой день и не надо искать платежный день
        IF k.blk = 0 THEN
          pl_dat := gl.bdate;
        ELSE
          --платежная дата  м.б. меньше (вых) банковской  или равна
          IF pl_den_ = 1 AND k.wdate <= gl.bdate THEN
            pl_dat := gl.bdate;
          ELSE
            SELECT MAX(fdat)
              INTO pl_dat
              FROM cc_lim
             WHERE nd = k.nd
               AND fdat <= gl.bdate;
          END IF;
        END IF;

        -- l_int_debt = 1 % за прош.мес, = 0 % за прош.день
        -- DAT_SN1_  дата остатка счета  SN
        -- DAT_SN2_  дата. по кот д.б. начислены %%

        IF l_int_debt = '1' AND k.wdate > gl.bdate THEN
          -- если % по предмес и КД еще не завешен, то для погашения берем остаток за 31 число прош.мес
          dat_sn1_ := trunc(pl_dat, 'MM');
          dat_sn2_ := dat_sn1_ - 1; -- DAT_SN1_ = первый день тек месяца, DAT_SN2_ = последний пред.менсяца
        ELSE
          -- если % по пред.дент ИЛИ КД уже завешен, то для погашения берем остаток за пред.день (т.е. текущий остаток)
          dat_sn1_ := gl.bdate;
          dat_sn2_ := pl_dat - 1; -- DAT_SN1_ = сегодня    DAT_SN2_ = вчера
        END IF;

        plan_pog_ := NULL;

        --06.05.2014 резервирование расчетных процентов за пред.месяц
        IF k.vidd = 12 AND k.blk = 13 AND pl_den_ != 1 THEN
          DECLARE
            nint_ NUMBER := 0; -- расчетные проц
            dt2_  DATE := last_day(add_months(gl.bdate, -1));
            dt1_  DATE := trunc(last_day(add_months(gl.bdate, -1)), 'MM');
          BEGIN
            acrn.p_int(acc_  => k.acc8,
                       id_   => 0,
                       dt1_  => dt1_,
                       dt2_  => dt2_,
                       int_  => nint_,
                       ost_  => NULL,
                       mode_ => 0);
            nint_ := round(nint_ - 1, 0);
            s29_  := s29_ + nint_;
          END;
        END IF;
        -------------------------------
        -- сортируем все счета согласно приоритетам установленным в шаблоне
        -- а также если шаблон предпологает r.type_prior=1  выбираем счета
        -- из другого договора к которому прикреплен данный счет гашения
        sum_ss_ := 0;

        FOR p IN (SELECT d.cc_id,
                         d.sdate,
                         a.acc acck,
                         a.tip,
                         a.nls nlsk,
                         a.kv,
                         n.nd,
                         CASE
                           WHEN a.tip = 'SN ' THEN
                            - (s.ostf + s.kos - s.dos) -- нач.проц. остаток , согласно дате проц.долга
                           ELSE
                            least(-a.ostc, - (s.ostf + s.kos - s.dos))
                         END s,
                         substr(a.nms, 1, 38) nmsk,
                         a.mdate,
                         a.daos,
                         r.ord,
                         a.ostx
                    FROM cc_deal  d,
                         accounts a,
                         saldoa   s,
                         nd_acc   n,
                         cc_rang  r
                   WHERE n.nd IN
                         (SELECT nn.nd FROM nd_acc nn WHERE acc = k.accd) -- все счета привязанные к счету погашения
                     AND n.nd = decode(r.type_prior, 1, n.nd, k.nd) -- только для типов счетов которые определеня как междоговорные
                     AND n.nd = d.nd
                     AND a.acc = n.acc
                     AND a.acc = s.acc
                     AND a.tip = r.tip
                     AND r.rang = to_number(decode(k.rang,
                                                   NULL,
                                                   getglobaloption('CC_RANG'),
                                                   k.rang))
                     AND (a.tip IN ('SS ',
                                    'SP ',
                                    'SN ',
                                    'SPN',
                                    'SL ',
                                    'SLN',
                                    'S9N',
                                    'LIM') AND a.kv = k.kv OR
                         (a.tip IN ('SK0', 'SK9', 'SLK', 'S9K', 'SN8') AND
                         k.kv = gl.baseval))
                     AND s.ostf + s.kos - s.dos < 0
                     AND a.ostc < 0
                     AND a.ostc = a.ostb
                     AND s.fdat =
                         (SELECT MAX(fdat)
                            FROM saldoa
                           WHERE acc = a.acc
                             AND fdat <=
                                 decode(a.tip, 'SN ', dat_sn1_, gl.bdate))
                   ORDER BY r.ord, d.sdate, d.wdate, a.nlsalt)

        -- цикл по счетам долга
         LOOP
          IF s29_ <= 0 THEN
            EXIT;
          END IF;
          --------------------------------------
          s_ := p.s;
          -----------------------------------  SN     l_int_debt =1   -------------------------------
          IF p.tip = 'SN ' THEN

            IF k.blk = 15 AND pl_den_ = 0 THEN
              s_ := 0;
              GOTO met_pet;
            END IF;

            -- Особенности нового ануитета. Игра дней : выходных, платежных, конечных календарных месяца.
            IF k.basey = 2 AND k.basem = 1 THEN

              DECLARE
                acr_dat_ DATE; -- дата, по которую реально начислены %% по ССУДНОМУ счету  (так как дата на простр-м счете может быть начислена по "воскресенье" при плат-м дне суббота  18- платежный, 19- воскрес,  20 - понедельник клиент платит)
              BEGIN
                SELECT nvl(MAX(i.acr_dat), pl_dat - 1)
                  INTO acr_dat_
                  FROM int_accn i, accounts a
                 WHERE i.id = 0
                   AND i.acra = p.acck
                   AND i.acr_dat >= pl_dat
                   AND i.acc = a.acc
                   AND a.tip = 'SS ';

                -- 1)  после Финального месячного начисления % сегодня "наперед" по 31 число - разбор гашенич в части нач.процентов - Не делать !
                IF acr_dat_ >= gl.bdate THEN
                  s_ := 0;
                  GOTO met_pet;
                END IF;

                -- 2 ) Переначисленные % если это ануитент по-новому, то из суммы остатка p.S надо убрать излишки, которые мы могли начислить наперед
                --      в силу припадания пл.дня на выходные и конца мес на выходные дни ,  например.
                --      банк.день = 01.07.2013 - понед
                --      плат.день = 29.06.2013 - субб, проценты должны быть взяты только по 28.06.2013 включительно  по условиям КД
                --      но вечером= 28.06.2013 - пятн, были начислены проценты наперед ! по 30.06.2013 включительно, по банковским правилам
                --      т.е. проценты за период 29.06.2013 - 30.06.2013 уже есть на счете, но они к оплате излишни
                --If gl.bdate <> pl_DAT  then - при таком условии будем дергать все КД каждый "понедельник" (nov)
                -- cck.FINT (ND,  gl.bdate, gl.bdate-1  ) - возвращает ноль
                --cck.FINT (ND,  gl.bdate, gl.bdate  ) - возвращает % за один день
                IF pl_dat <= acr_dat_ THEN
                  p.s := p.s - cck.fint(k.nd, pl_dat, acr_dat_);
                  s_  := p.s;
                END IF;

              EXCEPTION
                WHEN no_data_found THEN
                  NULL;
              END;

            END IF; -- -- Особенности нового ануитета.

            IF l_int_debt = '1' THEN
              -- норм.проц долг по ПРЕД МЕС
              SELECT nvl(SUM(kos), 0)
                INTO s_
                FROM saldoa
               WHERE acc = p.acck
                 AND fdat > dat_sn1_;
              IF p.s > s_ THEN
                s_ := p.s - s_;
              ELSE
                s_ := 0;
              END IF;
            END IF;
            ------------------------------------  SK4   --------------------------------------------
          ELSIF p.tip = 'LIM' AND
                (k.blk = 0 OR k.blk IN (1, 2, 10) AND pl_den_ = 1) THEN

            s_ := 0;
            IF k.kv = 980 AND k.blk != 15 THEN
              ratn_advanced := acrn.fprocn(p.acck, 4, NULL);

              IF nvl(ratn_advanced, 0) > 0 THEN

                SELECT abs(SUM(a.ostb + a.ostf))
                  INTO s_
                  FROM accounts a, nd_acc n
                 WHERE n.acc = a.acc
                   AND a.tip = 'SS '
                   AND n.nd = p.nd
                   AND a.kv = k.kv;
                -- сумма опережения (внимание перенос на просрочку может вестись с каникулами
                -- по параметру flags => p_holidays
                -- но досрочка береться по параметру CC_PAY_S только после текущего платежа  )
                plan_pog_ := cck_plan_sum_pog(p.nd,
                                              p.kv,
                                              k.typ_gpk,
                                              p.ostx,
                                              cc_pay_s);

                --сумма комиссии
                IF (least(s29_, s_) - plan_pog_) > 0 THEN

                  s_a_ := (s_ - plan_pog_) * ratn_advanced * 0.01; -- узнаем сумму от текущего остатка
                  s_   := nvl(trunc((s29_ - plan_pog_) * ratn_advanced /
                                    (100 + ratn_advanced)),
                              0);
                  s_   := least(s_a_, s_);
                  -- ищем счет доходов из проц карточки счета 8999 (если нет динамически)
                  SELECT MAX((SELECT nls
                               FROM accounts
                              WHERE acc = decode(n.acrb,
                                                 NULL,
                                                 cc_o_nls('8999',
                                                          k.rnk,
                                                          4,
                                                          p.nd,
                                                          k.kv,
                                                          'SD4'),
                                                 n.acrb)))
                    INTO nls_sd4
                    FROM accounts a, int_accn n
                   WHERE a.acc = p.acck
                     AND n.acc = a.acc
                     AND n.id = 4;
                  IF nls_sd4 IS NULL THEN
                    raise_application_error(- (20203),
                                            '\8999 CCK_ASG: Не знайден дох за достр погаш для КД, Реф=' || p.nd);
                  END IF;
                ELSE
                  s_ := 0;
                END IF;
              END IF; --nvl(ratn_advanced,0)>0 then
            END IF; -- kv=980

            ----------------------------------------  SN8 -------------------------------------------------------------
            -- БЕЗАКЦЕПТНОЕ СПИСАНИЕ ПЕНИ
          ELSIF p.tip = 'SN8' AND k.kv = gl.baseval THEN

            l_sum_sn8 := gl.p_ncurval(p.kv, least(p.s, s29_), gl.bdate);
            nls_6397  := substr(branch_usr.get_branch_param_acc(p.nlsk,
                                                                p.kv,
                                                                'CC_6397'),
                                1,
                                14); -- счет для дох по пене эмит
            IF nls_6397 IS NULL THEN
              raise_application_error(-20000,
                                      'Не заповнено параметр CC_6397 відділення якому належить рахунок: ' ||
                                      p.nlsk,
                                      TRUE);
            END IF;

            BEGIN
              SELECT nls
                INTO nls_8006
                FROM accounts
               WHERE tip = 'SD8'
                 AND nbs = '8006'
                 AND dazs IS NULL
                 AND kv = p.kv
                 AND rownum = 1;
            EXCEPTION
              WHEN OTHERS THEN
                raise_application_error(- (20203),
                                        ' Не знайдено контр рах. по пенi 8006 типу SD8 для вал=' || p.kv);
            END;

            ----------------------------------------  SS -------------------------------------------------------------
          ELSIF p.tip = 'SS ' THEN

            s_ := 0; -- ПО умолчанию погашение = 0.
            --  ищем вариант разрешенной суммы к погашению  нормальный основной долг на тек.дату

            SELECT ostx - ostb, ostb
              INTO lim8_, ostb_8999
              FROM accounts
             WHERE acc = k.acc8;

            -- блокировки
            IF k.blk IN (2, 10) THEN

              --  2 По наявност? залишку з резервуванням в?дсотк?в
              -- 10 По платiжним дням (на рах. SG та 262*) основного боргу

              IF pl_den_ = 0 THEN
                GOTO met_pet;
              ELSE
                s_ := p.s;
              END IF;

            ELSIF k.blk IN (0, 13) THEN
              s_ := p.s;
              --По наявностi залишку (на рах. SG)

            ELSIF k.blk = 1 THEN
              s_ := p.s;
              -- По наявностi залишку (на рах. SG)  з резурв-ням вiдсоткiв до платiжного дня
              -- В банке КИЕВ надо зарезервировать под %% из свободных средств
              -- 1= НЕ испoльзование со сч.SG прогнозируемых %% текущего месяца

              SELECT nvl(i.acr_dat, p.daos - 1)
                INTO dat_sn2_
                FROM int_accn i
               WHERE i.acc = p.acck
                 AND i.id = 0;
              s29_ := reservation_percent(p.acck,
                                          s29_,
                                          0,
                                          dat_sn2_,
                                          p.mdate,
                                          s_);

            ELSIF k.blk = 11 THEN
              --По плат?жним дням з урахуванням кратної суми платежу
              IF pl_den_ = 0 THEN
                GOTO met_pet;
              ELSE
                s_ := l_sumg * trunc(least(s29_, p.s) / l_sumg);
              END IF;

            ELSIF k.blk = 14 THEN
              -- ОБ  По плат?жним дням не б?льши(262*)  план-платежу

              IF pl_den_ = 0 THEN
                GOTO met_pet;
              ELSE
                ------ Узнаем плановый остаток по всем счетам 'SS ' в валюте счета гашения
                ---- отмена от Новикова : PLAN_POG_ :=  CCK_PLAN_SUM_POG(p.ND, p.KV, K.TYP_GPK,p.ostx, l_holidays);

                SELECT nvl(abs(SUM(a.ostb + a.ostf)), 0)
                  INTO plan_pog_
                  FROM accounts a, nd_acc n
                 WHERE n.acc = a.acc
                   AND a.tip = 'SS '
                   AND n.nd = p.nd
                   AND a.kv = k.kv;
                s_ := least(plan_pog_ + k.ostx, p.s);
              END IF;

            ELSIF k.blk = 15 THEN
              ------ По плат?жним дням т?льки плановий плат?ж
              IF pl_den_ = 0 THEN
                GOTO met_pet;
              ELSE
                plan_pog_ := cck_plan_sum_pog(p.nd,
                                              p.kv,
                                              k.typ_gpk,
                                              p.ostx,
                                              l_holidays);
                s_        := least(plan_pog_, p.s);
                IF p.s < s_ THEN
                  s_ := 0;
                END IF;
              END IF;
            END IF;

          END IF; -- конец ссудных
          -----------------
          s_ := least(s_, s29_);

          IF s_ > 0 THEN
            SELECT name_plain
              INTO per_pr
              FROM meta_month
             WHERE to_char(dat_sn2_, 'mm') = n;
            IF k.kv = 980 THEN
              vob_ := vob_980;
            ELSE
              vob_ := vob_val;
            END IF;

            IF substr(k.nlsd, 1, 4) IN ('2625') THEN
              tt_ := tt_bpk;
            ELSE
              tt_ := tt_odb;
            END IF;

            gl.ref(ref_);
            IF substr(k.nlsd, 1, 4) IN ('2600', '2620', '2625') THEN
              IF p.tip = 'SPN' THEN
                nazn_ := 'Договiрне списання просрочених вiдсоткiв';
              ELSIF p.tip = 'S9N' THEN
                nazn_ := 'Договiрне списання нарах.(9603) та неотриманих вiдсоткiв';
              ELSIF p.tip = 'SK9' THEN
                nazn_ := 'Договiрне списання просроченої комiсiї';
              ELSIF p.tip = 'S9K' THEN
                nazn_ := 'Договiрне списання нарах.(9603) та неотриманої комiсiї';
              ELSIF p.tip = 'SP ' THEN
                nazn_ := 'Договiрне списання просроченого осн.боргу';
              ELSIF p.tip = 'SL ' THEN
                nazn_ := 'Договiрне списання сумнiвного осн.боргу';
              ELSIF p.tip = 'SLN' THEN
                nazn_ := 'Договiрне списання сумнiвного проц.боргу';
              ELSIF p.tip = 'SLK' THEN
                nazn_ := 'Договiрне списання сумнiвного комiс.боргу';
              ELSIF p.tip = 'SK0' THEN
                nazn_ := 'Договiрне списання нарахованої комiсiї';
              ELSIF p.tip = 'SS ' THEN
                nazn_   := 'Договiрне списання основного боргу';
                sum_ss_ := sum_ss_ + s_;
              ELSIF p.tip = 'LIM' THEN
                nazn_ := 'Договiрне списання комiсiї за дострокове погаш.';
              ELSIF p.tip = 'SN8' THEN
                nazn_ := 'Договiрне списання пенi ';
              ELSIF p.tip = 'SN ' THEN
                nazn_ := 'Договiрне списання нарахованих вiдсоткiв ';
                IF l_int_debt = 1 THEN
                  nazn_ := nazn_ || ' за ' || per_pr || ' ' ||
                           to_char(dat_sn2_, 'yyyy') || ' р.';
                END IF;
              ELSE
                nazn_ := 'боргу';
              END IF;
            ELSE
              IF p.tip = 'SPN' THEN
                nazn_ := 'Погашення просрочених вiдсоткiв';
              ELSIF p.tip = 'S9N' THEN
                nazn_ := 'Погашення нарах.(9603) та неотриманих вiдсоткiв';
              ELSIF p.tip = 'SK9' THEN
                nazn_ := 'Погашення просроченої комiсiї';
              ELSIF p.tip = 'S9K' THEN
                nazn_ := 'Погашення нарах.(9603) та неотриманої комiсiї';
              ELSIF p.tip = 'SP ' THEN
                nazn_ := 'Погашення просроченого осн.боргу';
              ELSIF p.tip = 'SL ' THEN
                nazn_ := 'Погашення сумнiвного осн.боргу';
              ELSIF p.tip = 'SLN' THEN
                nazn_ := 'Погашення сумнiвного проц.боргу';
              ELSIF p.tip = 'SLK' THEN
                nazn_ := 'Погашення сумнiвного комiс.боргу';
              ELSIF p.tip = 'SK0' THEN
                nazn_ := 'Погашення нарахованої комiсiї';
              ELSIF p.tip = 'SS ' THEN
                nazn_   := 'Погашення основного боргу';
                sum_ss_ := sum_ss_ + s_;
              ELSIF p.tip = 'LIM' THEN
                nazn_ := 'Сплата комiсiї за дострокове погаш.';
              ELSIF p.tip = 'SN8' THEN
                nazn_ := 'Погашення пенi ';
              ELSIF p.tip = 'SN ' THEN
                nazn_ := 'Погашення нарахованих вiдсоткiв ';
                IF l_int_debt = 1 THEN
                  nazn_ := nazn_ || ' за ' || per_pr || ' ' ||
                           to_char(dat_sn2_, 'yyyy') || ' р.';
                END IF;
              ELSE
                nazn_ := 'боргу';
              END IF;
            END IF;
            nazn_ := nazn_ || ' згiдно угоди ' || p.cc_id || ' вiд ' ||
                     to_char(p.sdate, 'dd/mm/yyyy');

            IF p.tip IN ('S9N', 'S9K') AND tt_ <> tt_bpk THEN
              --  внебалансовые проценты и комиссия c БПК не платим !

              nls_2902 := k.nlsd;
              nls_9603 := p.nlsk;
              BEGIN
                SELECT a9.nls, substr(a6.nms, 1, 38), i.nlsb
                  INTO nls_9910, nms_6024, nls_6024
                  FROM accounts a9, accounts a6, int_accn i
                 WHERE a9.acc = i.acrb
                   AND i.nlsb = a6.nls
                   AND a6.kv = gl.baseval
                   AND i.acra = p.acck
                   AND a9.dazs IS NULL
                   AND a6.dazs IS NULL
                   AND i.id = decode(p.tip, 'S9N', 0, 2)
                   AND rownum = 1;
              EXCEPTION
                WHEN no_data_found THEN
                  GOTO met_pet;
              END;

              gl.in_doc3(ref_,
                         tt_,
                         6,
                         ref_,
                         SYSDATE,
                         gl.bdate,
                         1,
                         k.kv,
                         s_,
                         gl.baseval,
                         s_980,
                         NULL,
                         gl.bdate,
                         gl.bdate,
                         k.nmsd,
                         nls_2902,
                         gl.amfo,
                         p.nmsk,
                         nls_6024,
                         gl.amfo,
                         nazn_,
                         NULL,
                         k.okpo,
                         gl.aokpo,
                         NULL,
                         NULL,
                         NULL,
                         NULL,
                         NULL);
              paytt(0,
                    ref_,
                    gl.bdate,
                    tt_,
                    1,
                    k.kv,
                    nls_2902,
                    s_,
                    gl.baseval,
                    nls_6024,
                    s_980);
              --внебалансовые проценты и комиссия в валюте договора
              paytt(0,
                    ref_,
                    gl.bdate,
                    tt_odb,
                    1,
                    k.kv,
                    nls_9910,
                    s_,
                    k.kv,
                    nls_9603,
                    s_);

            ELSIF s_ > 0 THEN
              -- обычная плоская ASG или сложная W4X
              n_sos  := 0; -------------------- обычная плоская ASG  + сложная W4X
              l_nlsk := (CASE
                          WHEN p.tip = 'LIM' THEN
                           nls_sd4
                          WHEN p.tip = 'SN8' THEN
                           nls_6397
                          ELSE
                           p.nlsk
                        END);
              gl.in_doc3(ref_   => ref_,
                         tt_    => tt_,
                         vob_   => vob_,
                         nd_    => to_char(ref_),
                         pdat_  => SYSDATE,
                         vdat_  => gl.bdate,
                         dk_    => 1,
                         kv_    => k.kv,
                         s_     => s_,
                         kv2_   => p.kv,
                         s2_    => s_,
                         sk_    => NULL,
                         data_  => gl.bdate,
                         datp_  => gl.bdate,
                         nam_a_ => k.nmsd,
                         nlsa_  => k.nlsd,
                         mfoa_  => gl.amfo,
                         nam_b_ => p.nmsk,
                         nlsb_  => l_nlsk,
                         mfob_  => gl.amfo,
                         nazn_  => nazn_,
                         d_rec_ => NULL,
                         id_a_  => k.okpo,
                         id_b_  => k.okpo,
                         id_o_  => NULL,
                         sign_  => NULL,
                         sos_   => 0,
                         prty_  => NULL,
                         uid_   => NULL);
              gl.dyntt2(sos_   => n_sos,
                        mod1_  => 0,
                        mod2_  => 1,
                        ref_   => ref_,
                        vdat1_ => gl.bdate,
                        vdat2_ => gl.bdate,
                        tt0_   => tt_,
                        dk_    => 1,
                        kva_   => k.kv,
                        mfoa_  => gl.amfo,
                        nlsa_  => k.nlsd,
                        sa_    => s_,
                        kvb_   => k.kv,
                        mfob_  => gl.amfo,
                        nlsb_  => l_nlsk,
                        sb_    => s_,
                        sq_    => 0,
                        nom_   => 0);
              -- сворачиваем пеню
              IF p.tip = 'SN8' THEN
                gl.payv(0,
                        ref_,
                        gl.bdate,
                        tt_odb,
                        1,
                        p.kv,
                        nls_8006,
                        l_sum_sn8,
                        p.kv,
                        p.nlsk,
                        l_sum_sn8);
              END IF;
            END IF;
            IF tt_ <> tt_bpk AND fl_ = 2 THEN
              gl.pay(2, ref_, gl.bdate);
            END IF;
            ---------------------------
            s29_ := s29_ - s_;
          END IF;

          <<met_pet>>
          NULL;
        END LOOP; -- p
      END IF;
      <<met_kon>>
      NULL;
    END LOOP; -- k
  END cc_asg;
  -----------------------

  PROCEDURE cc_asg1(p_nd cc_deal.nd%TYPE) IS
    --авто разбор счета гашения по одному КД
    dd          cc_deal%ROWTYPE;
    a2          accounts%ROWTYPE;
    a8          accounts%ROWTYPE;
    i8          int_accn%ROWTYPE;
    l_daynp     VARCHAR2(10);
    l_rang      VARCHAR2(10);
    l_flags     VARCHAR2(10);
    l_blk       NUMBER := 0;
    l_pl_day_sn VARCHAR2(10);
    l_holidays  VARCHAR2(10);
    l_int_debt  VARCHAR2(10);
    pl_den_     NUMBER;
    l_sumg      NUMBER;
    l_sumo      NUMBER;
    dat_sn1_    DATE;
    dat_sn2_    DATE;
    s29_        NUMBER;
    mode_i      CHAR(1) := nvl(getglobaloption('CC_GPK'), '0');
    mode_e      CHAR(1) := nvl(getglobaloption('ASG-SN'), '0');
  BEGIN

    BEGIN
      SELECT d.*
        INTO dd
        FROM cc_deal d
       WHERE d.nd = p_nd
         AND d.sos >= 10
         AND d.sos < 14
         AND d.vidd IN (1, 2, 3, 11, 12, 13);
      SELECT a.*
        INTO a8
        FROM accounts a, nd_acc n
       WHERE n.nd = dd.nd
         AND n.acc = a.acc
         AND a.rnk = dd.rnk
         AND a.dazs IS NULL
         AND a.tip = 'LIM';
      SELECT i.*
        INTO i8
        FROM int_accn i
       WHERE i.acc = a8.acc
         AND i.id = 0;
      SELECT a.*
        INTO a2
        FROM accounts a, nd_acc n
       WHERE n.nd = dd.nd
         AND n.acc = a.acc
         AND a.rnk = dd.rnk
         AND (a.ostb + a.lim) > 0
         AND a.ostc = a2.ostb
         AND (a.tip = 'SG ' OR a.nbs IN ('2600', '2620', '2625'))
         AND a.kv = a8.kv;
      s29_ := a2.ostb + a2.lim;
    EXCEPTION
      WHEN no_data_found THEN
        RETURN;
    END;

    -- Платежный ли сегодня день ?
    -- Если платежный день (DAYNP=-2 без сдвига) тогда считаем что день погашения следующий
    -- платежн?й день по ГПК с проверкой что день платежа не совпал с в?ходлн?м

    l_daynp := cck_app.get_nd_txt(dd.nd, 'DAYNP');

    SELECT COUNT(*), SUM(sumg), SUM(sumo)
      INTO pl_den_, l_sumg, l_sumo
      FROM cc_lim
     WHERE sumo > 0
       AND cck_app.correctdate2(gl.baseval, fdat, nvl(l_daynp, 1)) =
           gl.bdate
       AND fdat < gl.bdate + 30
       AND fdat > gl.bdate - 30
       AND nd = dd.nd;

    -- Для  договоров  с датой окончание считаем день погашения каждый день
    IF dd.wdate <= gl.bdate THEN
      dat_sn1_ := gl.bdate;
      dat_sn2_ := gl.bdate - 1;
      pl_den_  := 1;
    END IF;

    BEGIN
      SELECT crn.blk
        INTO l_blk
        FROM nd_txt nn, cc_rang_name crn
       WHERE nd = dd.nd
         AND tag = 'CCRNG'
         AND to_number(nn.txt) = crn.rang;
    EXCEPTION
      WHEN no_data_found THEN
        l_blk := 0;
    END;

    -- Блокировка погашения  в неплатежные дни для блк >=10,11,14,15
    -- если оплата по платежным дням и договор нормальный (не просроченный) тогда гасить больше ничего не надо
    IF dd.sos = 10 AND dd.wdate >= gl.bdate AND pl_den_ = 0 AND l_blk >= 10 THEN
      --10,11,14,15 = Только По платiжним дня
      RETURN;
    END IF;

    -- запрещаем списание для блк < 10 всего остатка не со счетов гашения
    -- (то есть счета 2620 притянуты информативно , не для разбора  как в Демарке)
    IF l_blk < 10 AND a2.tip != 'SG ' THEN
      RETURN;
    END IF;

    BEGIN
      SELECT txt
        INTO l_flags
        FROM nd_txt
       WHERE nd = dd.nd
         AND tag = 'FLAGS';
      l_holidays := substr(l_flags, 1, 1);
      l_int_debt := substr(l_flags, 2, 1); -- =1 % за прош.мес, =0 % за прош.день
    EXCEPTION
      WHEN no_data_found THEN
        l_flags := NULL;
        -- Нет индивидуального устанавливаем глобальный
        l_holidays := mode_i;
        l_int_debt := mode_e; -- =1 % за прош.мес, =0 % за прош.день
    END;

    IF l_int_debt = '1' AND dd.wdate > gl.bdate THEN
      -- если % по предмес и КД еще не завешен,
      -- то для погашения берем остаток за 31 число прош.мес
      -- это первый день тек месяца и последний пред.менсяца
      dat_sn1_ := trunc(gl.bdate, 'MM');
      dat_sn2_ := dat_sn1_ - 1;
    ELSE
      -- если % по пред.дент ИЛИ КД уже завешен,
      -- то для погашения берем остаток за пред.день (т.е. текущий остаток)
      -- это сегодня и вчера
      dat_sn1_ := gl.bdate;
      dat_sn2_ := dat_sn1_ - 1;
    END IF;

    l_rang := cck_app.get_nd_txt(dd.nd, 'CCRNG');

    BEGIN
      SELECT lpad(txt, 2, '0')
        INTO l_pl_day_sn
        FROM nd_txt
       WHERE nd = dd.nd
         AND tag = 'DAYSN';
    EXCEPTION
      WHEN no_data_found THEN
        l_pl_day_sn := to_char(lpad(i8.s, 2, '0'));
    END;

  END cc_asg1;
  -----------------------

  PROCEDURE cc_asp(p_nd INT, day_ INT) IS
    --авто перенос на просрочку основного долга

    -- p_ND = -1  = только ЮЛ
    -- p_ND = -11 = только ФЛ
    -- p_ND = 0   = ВСЕ ( ЮЛ + ФЛ)
    -- p_ND > 0   = один КД с реф = p_ND
    -- Анализу поддлежат КД, кот. имеют проврочку по сумме  на дату gl.bdate - DAY_;
    -- Если вынос делать в след.день за платежным (утром), то DAY_ = 1

    s7_      NUMBER;
    s8_      NUMBER;
    l_sumg   NUMBER;
    l_s_pay  NUMBER;
    q_       NUMBER;
    s_       NUMBER;
    q7_      NUMBER;
    dat7_    DATE;
    l_vob46  INT := 46;
    dp_      NUMBER; -- досрочно пог %
    l_branch cc_deal.branch%TYPE;
    l_vidd   cc_deal.vidd%TYPE;
    nd_      cc_deal.nd%TYPE;

    l_kol    INT := 0;
    n_commit INT := 100;
    i_commit INT := 0;

    cck_mpog NUMBER;
    k_flags  CHAR(1);
    k_fdat   DATE;
    k_fdat1  DATE;
    -- l_holay  int    := F_Get_Params('CC_HOLIDAY');
    ------------------------
    l_dat1 DATE; -- прошлый раб день
    l_dat2 DATE; -- поза-прошлый раб день
    ll     cc_lim%ROWTYPE;

  BEGIN

    SELECT MAX(fdat) INTO l_dat1 FROM fdat WHERE fdat < gl.bdate; -- прошлый раб день
    IF l_dat1 IS NULL THEN      RETURN;    END IF;
    SELECT MAX(fdat) INTO l_dat2 FROM fdat WHERE fdat < l_dat1; -- поза-прошлый раб день
    IF l_dat2 IS NULL THEN      RETURN;    END IF;
    --------------------------------------
    pul.set_mas_ini('SP_KOL', to_char(l_kol), 'Кол.просроч.');

    IF    p_nd = -1  THEN      nd_    := 0;      l_vidd := 1;
    ELSIF p_nd = -11 THEN      nd_    := 0;      l_vidd := 11;
    ELSE                       nd_    := p_nd;   l_vidd := NULL;
    END IF;

    dat7_    := gl.bdate - day_;
    l_branch := substr(pul.get_mas_ini_val('BRANCH'), 1, 30);

    --определение VOB для КД в инвалюте
    BEGIN SELECT vob INTO l_vob46  FROM tts_vob   WHERE tt = 'ASP'  AND ord = 2;
    EXCEPTION  WHEN no_data_found  THEN NULL;
    END;

    --цикл по договорам, которые имели факт просрочки в DAT7_  и имеют ее сейчас
    -- По ГПК !!!!
    FOR k IN (SELECT a.acc8, a.ost, a.kv8, a.rnk, d.nd, d.cc_id, d.sdate, a.tobo, d.vidd, d.NDG 
              FROM cc_deal d,  nd_acc n,   (SELECT tobo, acc acc8, -ostc ost, kv kv8, rnk FROM accounts WHERE tip = 'LIM'  AND ostc = ostb  AND ostc < 0 AND ostx <= 0) a
              WHERE nd_ IN (0, d.nd)       AND d.nd = n.nd    AND n.acc = a.acc8
                AND nvl(d.branch, 0) LIKE  nvl(l_branch || '%', nvl(d.branch, 0))
                AND (l_vidd IS NULL OR l_vidd = 1 AND d.vidd IN (1, 2, 3) OR   l_vidd = 11 AND d.vidd IN (11, 12, 13))
             ) 
    LOOP
      /*
      --   условия обхода выноса на просрочку
      00  З канікулами. % за попередній день
      01  З канікулами. % за попередній місяць
      10  Без канікул   % за попередній день
      11  Без канікул   % за попередній місяць
      02  З канікулами. % альтернативний день
      12  Без каникул   % альтернативний день
      */
      BEGIN  SELECT substr(t.txt, 1, 1) INTO k_flags  FROM nd_txt t  WHERE t.nd = k.nd  AND t.tag = 'FLAGS';
      EXCEPTION     WHEN no_data_found  THEN k_flags := '0';
      END;

      BEGIN
        -- Учет вых.дней, которые м.б. в только ГПК ФЛ
        --например: gl.bdate = сегодня            = 05.08.2013 - понедельник
        --          l_dat1   = прошлый банк.день  = 02.08.2013 - пятница
        --          ll.fdat  = пл.день по ГКП     = 03.08.2013 - суббота
        --          не выносим на просрочку
        -- ll - это платеж. кот орый должен состояться
        SELECT l.* INTO ll FROM cc_lim l WHERE nd = k.nd AND fdat = (SELECT nvl(MAX(fdat), k.sdate)  FROM cc_lim  WHERE nd = l.nd AND fdat < gl.bdate);
        IF NOT  (ll.fdat > l_dat2 AND ll.fdat <= l_dat1  AND ll.fdat <> k.sdate) THEN GOTO nexrec;   END IF;
      EXCEPTION    WHEN no_data_found THEN                                            GOTO nexrec;
      END;
      IF NOT (k.ost > ll.lim2 OR k_flags = '1') THEN                                  GOTO nexrec;   END IF; --- нет просрочки по сумме и нет обязательности платежа
      -------------------------------------------
      --общая сумма просрочки ПО СУММЕ и лимиту(перенесенной + неперенесенной)
      s7_ := k.ost - ll.lim2;

      -- ПРОВЕРКА ПО ЛИМИТУ
      --минус сумму, уже перенесенную на просрочку ранее

--Sta 16.05.2018
      SELECT gl.p_ncurval(k.kv8,  SUM(gl.p_icurval(a.kv, a.ostc, gl.bdate)),   gl.bdate)    INTO s8_   FROM accounts a, nd_acc n
      WHERE a.tip = 'SP '  AND a.acc = n.acc  AND n.nd in ( select x.nd from cc_deal x where k.nd = NVL( x.NDG, x.ND) ) ;  -- AND a.accc = k.acc8

      s8_ := nvl(s8_, 0);
      s7_ := s7_ + s8_;

      -- ПРОВЕРКА ПО ПЛАТЕЖУ
      IF k_flags = '1' THEN
         -- PLAN_POG_
         -- узнаем сколько погашено относительно последнего платежа
         -- с контролем что перплачено и выдаем отриц-ное число или 0
         -- столько ожидали ll.sumg
         -- Пред плат.день (Учет вых.дней, которые м.б. в только ГПК ФЛ)

         SELECT nvl(MAX(fdat), k.sdate)  INTO k_fdat1  FROM cc_lim  WHERE nd = k.nd   AND fdat < ll.fdat      AND sumg > 0;
         IF k.vidd IN (11, 12, 13)       THEN k_fdat1 := cck_app.correctdate2(980, k_fdat1, 1);  END IF;

         -- столько реально погашено за платежный период  (ТОЛЬКО НОРМАЛЬНОЕ ТЕЛО !!!)

--Sta 16.05.2018
         SELECT nvl ( SUM ( gl.p_icurval(a.kv,  decode(a.tip, 'SS ', s.kos, 0),  gl.bdate)),    0) 
              - nvl ( SUM ( gl.p_icurval(a.kv,  decode(a.tip, 'SP ', s.dos, 0),  gl.bdate)),    0)
         INTO l_s_pay
         FROM accounts a, nd_acc n, saldoa s
          WHERE n.nd  in ( select x.nd from cc_deal x where k.nd = NVL( x.NDG, x.ND) )   -- AND a.accc = k.acc8 k.nd
            AND n.acc = a.acc    AND a.tip IN ('SS ', 'SP ')  AND s.acc = a.acc    AND s.fdat > k_fdat1  AND s.fdat <= ll.fdat;

         l_s_pay := greatest(nvl(l_s_pay, 0), 0);
         IF l_s_pay <> 0 AND k.kv8 <> gl.baseval THEN       l_s_pay := gl.p_ncurval(k.kv8, l_s_pay, gl.bdate);     END IF;

         -- Клиент недогасил и проверяем что уже данный платеж мы не выносили
         s8_ := 0;

         IF ll.sumg > l_s_pay THEN
-- Sta 16.05.2018
            SELECT nvl(SUM(gl.p_icurval(a.kv, s.kos, gl.bdate)), 0)        INTO s8_       FROM accounts a, nd_acc n, saldoa s
            WHERE n.nd in ( select x.nd from cc_deal x where k.nd = NVL( x.NDG, x.ND) )   -- AND a.accc = k.acc8 k.nd 
              AND n.acc = a.acc   AND a.tip = 'SS '   AND s.acc = a.acc   AND s.fdat > ll.fdat;
            IF s8_ <> 0 AND k.kv8 <> gl.baseval THEN    s8_ := gl.p_ncurval(k.kv8, s8_, gl.bdate);    END IF;
         END IF;
         s7_ := greatest(s7_, (ll.sumg - l_s_pay - s8_), 0);
      END IF;

      IF s7_ <= 0 THEN   GOTO nexrec;   END IF;
      --------------------------

      --есть чего еще переносить
      UPDATE cc_deal SET sos = 13 WHERE nd = k.nd;
--Sta 16.05.2018
      FOR p IN (SELECT a.kv, a.nls nlsk, substr(a.nms,1,38) nmsk, least(- (s.ostf-s.dos+s.kos), -a.ostc) ss, a.isp, a.grp, p.s080, a.mdate, a.acc, n.ND , a.ACCC
                FROM accounts a, saldoa s, specparam p, nd_acc n
                WHERE a.acc = p.acc(+)  AND a.tip  = 'SS '   AND a.acc   = s.acc   AND a.acc = n.acc    AND a.ostc < 0   AND s.ostf-s.dos+s.kos < 0  
                  AND n.nd in (select nd from cc_deal where NVL( ndg,nd ) = k.nd )
--                AND a.accc = k.acc8  
                  AND a.ostc = a.ostb  AND s.fdat = (SELECT MAX(fdat)  FROM saldoa  WHERE acc = s.acc  AND fdat <= dat7_  )
                ORDER BY  a.mdate, s.fdat
                ) 
      LOOP  -- S7_ уменьшаемая сумма несделенной просрочки в вал LIM
         IF s7_ <= 0 THEN    EXIT;     END IF; --больше не надо.
         ----------------------------------------------------
         --уменьшаемая сумма несделенной просрочки в вал SS
         IF    p.kv  = k.kv8      THEN          q7_ := s7_;
         ELSIF p.kv  = gl.baseval THEN          q7_ := gl.p_icurval(k.kv8, s7_, gl.bdate);
         ELSIF k.kv8 = gl.baseval THEN          q7_ := gl.p_ncurval(p.kv , s7_, gl.bdate);
         ELSE                                   q7_ := gl.p_ncurval(p.kv , gl.p_icurval(k.kv8, s7_, gl.bdate),    gl.bdate);
         END IF;
         s_ := least(p.ss, q7_);

         --Сумма в вал LIM, которую можно еще перенести на просрочку
         IF    k.kv8 = p.kv       THEN          q_ := s_;
         ELSIF k.kv8 = gl.baseval THEN          q_ := gl.p_icurval(p.kv , s_, gl.bdate);
         ELSIF p.kv  = gl.baseval THEN          q_ := gl.p_ncurval(k.kv8, s_, gl.bdate);
         ELSE                                   q_ := gl.p_ncurval(k.kv8, gl.p_icurval(p.kv, s_, gl.bdate),    gl.bdate);
         END IF;

         --начало транзакции
         SAVEPOINT do_pr7;
         BEGIN
--Sta 16.05.2018
--          cck.cc_asp111(cc_kvsd8, dat7_, l_vob46, k.nd, k.acc8, p.kv, p.isp, p.grp, p.s080, p.mdate, p.nmsk, p.nlsk, k.cc_id, k.sdate, s_ );
            cck.cc_asp111(cc_kvsd8, dat7_, l_vob46, P.nd, p.ACCC, p.kv, p.isp, p.grp, p.s080, p.mdate, p.nmsk, p.nlsk, k.cc_id, k.sdate, s_ );
            s7_      := s7_ - q_;
            i_commit := i_commit + 1;
         EXCEPTION  WHEN OTHERS THEN   ROLLBACK TO do_pr7;
            BEGIN  logger.info('CCK_ASP ош.реф КД=' || k.nd);  GOTO kin7_;  END;
         END;
         --конец транзакции---------------
         <<kin7_>>    NULL;
      END LOOP; --конец цикла по счетам SS одного договора

      IF i_commit >= n_commit AND nvl(g_reports, 0) = 0 THEN    COMMIT;    l_kol    := l_kol + i_commit;     i_commit := 0;   END IF;
      <<nexrec>>  NULL;
    END LOOP; --конец цикла по ДОГОВОРАМ по ГПК
    ------------------------------------------------
    IF i_commit >= n_commit AND nvl(g_reports, 0) = 0 THEN      COMMIT;    l_kol    := l_kol + i_commit;     i_commit := 0;   END IF;
    l_kol := l_kol + i_commit;

    IF nvl(g_reports, 0) = 0 THEN      COMMIT;    END IF;
    pul.set_mas_ini('SP_KOL', to_char(l_kol), 'Кол.просроч.');
    i_commit := 0;

  END cc_asp;

  -------------------
  PROCEDURE cc_asp111(cc_kvsd8 VARCHAR2, -- гл.пар CC_KVSD8=1 счет пени в вал КД. Иначе в нац.вал - незав от вал КД.
                      dat7_    DATE,
                      p_vob46  INT,
                      p_nd     NUMBER, -- реф.КД
                      p_acc8   NUMBER, -- АСС счета консол
                      p_kv     INT, -- вал
                      p_isp    INT, -- исп ссудного сч
                      p_grp    NUMBER, -- группе дост
                      p_s080   VARCHAR2, -- кат риска
                      p_mdate  DATE, -- дата заерш
                      p_nmsk   VARCHAR2, -- наим.счта
                      p_nlsk   VARCHAR2, -- номер ссудного счета
                      p_cc_id  VARCHAR2, -- Ид.КД
                      p_sdate  DATE, -- Дата начала КД
                      p_s      NUMBER -- сумма для в?носа на просрочку
                      )

   IS

    -- обработка 1- счета SS

    accd_    NUMBER;
    nlsd_    VARCHAR2(15);
    nmsd_    VARCHAR2(38);
    acc_sn8_ INT;
    nls_sn8_ VARCHAR2(15);
    kv_sn8   INT; -- для счета пени
    l_vob6   INT := 6;
    vob_     INT;
    ref_     INT;
    nazn_    VARCHAR2(160);

    l_nmk    customer.nmk%TYPE;
    l_okpo   customer.okpo%TYPE;
    l_branch cc_deal.branch%TYPE;

  BEGIN

    --найти/открыть первый попавш незакр счет SP, куда будем переносить просрочку
    BEGIN
      SELECT a.nls, substr(a.nms, 1, 38)
        INTO nlsd_, nmsd_
        FROM accounts a, nd_acc n
       WHERE a.tip = 'SP '
         AND a.accc = p_acc8
         AND a.kv = p_kv
         AND a.acc = n.acc
         AND n.nd = p_nd
         AND a.dazs IS NULL
         AND rownum = 1;
    EXCEPTION
      WHEN no_data_found THEN
        SELECT cck.nls0(p_nd, 'SP ') INTO nlsd_ FROM dual;
        cck.cc_op_nls(p_nd,
                      p_kv,
                      nlsd_,
                      'SP ',
                      p_isp,
                      p_grp,
                      p_s080,
                      p_mdate,
                      accd_);
        SELECT substr(nms, 1, 38)
          INTO nmsd_
          FROM accounts
         WHERE acc = accd_;
    END;

    --найти/открыть счет SN8, на который будем начислять пеню
    IF spn_bri_ IS NOT NULL THEN

      kv_sn8 := iif_s(cc_kvsd8, '1', gl.baseval, p_kv, gl.baseval);

      BEGIN
        SELECT a.nls
          INTO nls_sn8_
          FROM accounts a, nd_acc n
         WHERE a.tip = 'SN8'
           AND a.kv = kv_sn8
           AND a.acc = n.acc
           AND n.nd = p_nd
           AND a.dazs IS NULL
           AND rownum = 1;
      EXCEPTION
        WHEN no_data_found THEN
          SELECT f_newnls2(p_acc8, 'SN8', NULL, NULL, kv_sn8)
            INTO nls_sn8_
            FROM dual;
          cck.cc_op_nls(p_nd,
                        kv_sn8,
                        nls_sn8_,
                        'SN8',
                        p_isp,
                        p_grp,
                        p_s080,
                        p_mdate,
                        acc_sn8_);
      END;
    END IF;

    IF p_kv = gl.baseval THEN
      vob_ := l_vob6;
    ELSE
      vob_ := p_vob46;
    END IF;

    gl.ref(ref_);
    nazn_ := 'Угода ' || p_cc_id || ' вiд ' ||
             to_char(p_sdate, 'dd.mm.yyyy') ||
             ' Перенесення на прострочку основного ' || 'боргу станом на ' ||
             to_char(dat7_, 'dd/mm/yyyy');
    nazn_ := substr(nazn_, 1, 160);

    SELECT d.branch, c.nmk, c.okpo
      INTO l_branch, l_nmk, l_okpo
      FROM cc_deal d, customer c
     WHERE d.nd = p_nd
       AND d.rnk = c.rnk;

    IF nvl(g_reports, 0) = 0 THEN
      gl.in_doc3(ref_   => ref_,
                 tt_    => 'ASP',
                 vob_   => vob_,
                 nd_    => substr(to_char(ref_), 1, 10),
                 pdat_  => SYSDATE,
                 vdat_  => gl.bdate,
                 dk_    => 1,
                 kv_    => p_kv,
                 s_     => p_s,
                 kv2_   => p_kv,
                 s2_    => p_s,
                 sk_    => NULL,
                 data_  => gl.bdate,
                 datp_  => gl.bdate,
                 nam_a_ => nmsd_,
                 nlsa_  => nlsd_,
                 mfoa_  => gl.amfo,
                 nam_b_ => p_nmsk,
                 nlsb_  => p_nlsk,
                 mfob_  => gl.amfo,
                 nazn_  => nazn_,
                 d_rec_ => NULL,
                 id_a_  => l_okpo,
                 id_b_  => l_okpo,
                 id_o_  => NULL,
                 sign_  => NULL,
                 sos_   => 0,
                 prty_  => NULL,
                 uid_   => NULL);

      gl.payv(cck.fl38_asp,
              ref_,
              gl.bdate,
              'ASP',
              1,
              p_kv,
              nlsd_,
              p_s,
              p_kv,
              p_nlsk,
              p_s);
    ELSE

      INSERT INTO bars.v_cck_rep
        (branch,
         tt,
         vob,
         vdat,
         kv,
         dk,
         s,
         nam_a,
         nlsa,
         mfoa,
         nam_b,
         nlsb,
         mfob,
         nazn,
         s2,
         kv2,
         sq2,
         nd,
         cc_id,
         sdate,
         nmk)
      VALUES
        (l_branch,
         'ASP',
         vob_,
         gl.bdate,
         p_kv,
         1,
         p_s / 100,
         nmsd_,
         nlsd_,
         gl.amfo,
         p_nmsk,
         p_nlsk,
         gl.amfo,
         nazn_,
         p_s / 100,
         p_kv,
         NULL,
         p_nd,
         p_cc_id,
         p_sdate,
         l_nmk);

    END IF;

  END cc_asp111;
  ------------------
  PROCEDURE cc_isg_nazn(l_nd cc_deal.nd%TYPE, l_nazn OUT VARCHAR2) IS
    l_cc_id   VARCHAR2(200);
    l_wdate   VARCHAR2(200);
    l_cc_deal cc_deal%ROWTYPE;
    l_ndi     NUMBER;
    l_sdate   DATE;
  BEGIN

    BEGIN
      SELECT * INTO l_cc_deal FROM cc_deal d WHERE d.nd = l_nd;
    EXCEPTION
      WHEN no_data_found THEN
        l_nazn := NULL;
    END;
    IF substr(l_cc_deal.prod, 1, 6) IN ('206219', '206309', '206325') AND
       l_cc_deal.ndi IS NOT NULL AND l_cc_deal.ndi <> l_nd THEN
      BEGIN
        SELECT cc.ndi INTO l_ndi FROM cc_deal cc WHERE cc.nd = l_nd;
      EXCEPTION
        WHEN no_data_found THEN
          l_nazn := NULL;
      END;
      BEGIN
        SELECT cc.cc_id, cc.sdate
          INTO l_cc_id, l_sdate
          FROM cc_deal cc
         WHERE cc.nd = l_ndi;
      EXCEPTION
        WHEN no_data_found THEN
          l_cc_id := l_cc_deal.cc_id;
          l_sdate := l_cc_deal.sdate;
      END;

      l_nazn := l_nazn || l_cc_id || ' aia ' ||
                to_char(l_sdate, 'dd/mm/yyyy');

    ELSE
      BEGIN
        SELECT cc.cc_id, cc.sdate
          INTO l_cc_id, l_sdate
          FROM cc_deal cc
         WHERE cc.nd = l_nd;
      EXCEPTION
        WHEN no_data_found THEN
          l_nazn := NULL;
      END;
      l_nazn := l_nazn || l_cc_id || ' aia ' ||
                to_char(l_sdate, 'dd/mm/yyyy');

    END IF;

  END cc_isg_nazn;
  PROCEDURE cc_aspn(custtype_ INT, nd_ INT, day_ INT) IS
    --авто перенос на просрочку долга по процентам и комиссии
  BEGIN
    FOR k IN (SELECT d.nd,
                     d.cc_id,
                     c.okpo,
                     decode(getglobaloption('CCK_NBU'), '1', c.nmkk, c.nmk) nmk
                FROM cc_deal d, accounts a, customer c, nd_acc n
               WHERE (custtype_ <= 2 AND vidd IN (1, 2, 3) OR
                     custtype_ = 3 AND vidd IN (11, 12, 13))
                 AND d.sos > 0
                 AND d.sos < 14
                 AND nd_ IN (0, d.nd)
                 AND d.nd = n.nd
                 AND n.acc = a.acc
                 AND a.tip = 'LIM'
                 AND d.rnk = c.rnk) LOOP
      cck.cc_aspn_dog(k.nd, k.cc_id, k.okpo, k.nmk, day_, NULL);
    END LOOP;

  END cc_aspn;
  -----------------------
  PROCEDURE cc_aspn_dog(p_nd    INT,
                        p_cc_id IN VARCHAR2,
                        p_okpo  IN VARCHAR2,
                        p_nmk   IN VARCHAR2,
                        day_    INT,
                        p_max   NUMBER) IS

    --авто перенос на просрочку долга по процентам и комиссии по ОДНОМУ ДОГОВОРУ

    --18.07.2013 Сухова
    -- p_max > 0  - max допусимая сумма для переноса на просрочку - используется в новом ануитете
    -- p_max = Null - по остатку

    s_            NUMBER;
    kos_          NUMBER;
    ref_          INT;
    accd_         INT;
    nlsd_         VARCHAR2(15);
    nmsd_         VARCHAR2(38);
    nazn_         VARCHAR2(160);
    vob_          INT;
    nls_sn8_      VARCHAR2(15); -- для пени
    acc_sn8_      INT; -- для пени
    kv_sn8_       INT; -- код валюты для счета пени
    l_sdate       DATE;
    l_branch      cc_deal.branch%TYPE;
    l_nmk         customer.nmk%TYPE;
    l_present_nls INT; -- отсутствие счета при открытии счета по маске от ссудного

    ern CONSTANT POSITIVE := 333;
    err EXCEPTION;
    erm VARCHAR2(80);

    dat30_ DATE; -- последний кал.день пред месяца, он же день, по который мы рассматриваем проценты к уплате

    datb1_ DATE; -- предыдущий раб.день
    datb2_ DATE; -- ПОЗА-предыдущий раб.день
    datpl_ DATE; -- ПЛАТЕЖНЫЙ ДЕНЬ КЛИЕНТА \= ДАТА
    l_dd   CHAR(2); --                        /  дд

  BEGIN

    dat30_ := trunc(gl.bdate, 'MM') - 1; -- последний кал.день пред месяца

    IF day_ = -1 THEN
      dat30_ := gl.bdate; -- а так же изменяет счет начисления процентов на счет просроченных процентов
    ELSIF day_ = -3 THEN
      dat30_ := gl.bdate;

    ELSIF day_ = -2 THEN
      -- Проц "За пред.мес" (- пока НЕ проверено или по какое-то фиксированное число, наприм 26 - как в УПБ)

      -- найти клиентскую пл.дату и узнать, надо ли она нам сегодня ?
      l_dd   := nvl(cck_app.pay_day_sn_to_nd(p_nd), '31'); -- день ДД погаш. процент долга в формате  '31'  '26'  '02' .... из доп.рекв. КД
      datpl_ := cck_app.valid_date(l_dd || to_char(gl.bdate, '/mm/yyyy')); -- день ДД в текущем  месяце
      IF datpl_ > gl.bdate THEN
        datpl_ := add_months(datpl_, -1);
      END IF; -- но он не мб больше тек.дня, иначе в прошлом мес

      --Универсальная функция поиска банковской даты, отстоящей от заданной (datb_) на расстоянии  next_ шагов вперед (next_ > 0) или назад (next_ < 0)
      datb1_ := dat_next_u(gl.bdate, -1); -- пред.раб.день
      datb2_ := dat_next_u(gl.bdate, -2); -- Поза-пред.раб.день
      IF NOT (datpl_ > datb2_ AND datpl_ <= datb1_) THEN
        RETURN;
      END IF;
      -----------------------------------------------------------------------
      dat30_ := trunc(datpl_, 'MM') - 1; -- последний кал.день пред месяца
    END IF;

    FOR p IN (SELECT a.acc acc8,
                     a.kv,
                     a.nls nlsk,
                     a.acc,
                     a.rnk,
                     substr(a.nms, 1, 38) nmsk,
                     a.isp,
                     a.grp,
                     a.mdate,
                     p.s080,
                     decode(a.tip, 'SN ', 'SPN', 'SK9') tipn
                FROM nd_acc n, accounts a, specparam p
               WHERE a.acc(+) = p.acc
                 AND n.nd = p_nd
                 AND n.acc = a.acc
                 AND a.tip IN ('SN ', 'SK0')
                 AND a.ostb <> 0
                 AND a.ostc = a.ostb) LOOP
      BEGIN
        --остаток на DAT30_
        SELECT - (s.ostf - s.dos + s.kos)
          INTO s_
          FROM saldoa s
         WHERE s.acc = p.acc
           AND s.fdat = (SELECT MAX(fdat)
                           FROM saldoa
                          WHERE acc = s.acc
                            AND fdat <= dat30_);
        IF p_max >= 0 THEN
          s_ := least(s_, p_max);
        END IF;
        --с тех пор погашено
        SELECT nvl(SUM(kos), 0)
          INTO kos_
          FROM saldoa
         WHERE acc = p.acc
           AND fdat > dat30_;
        s_ := s_ - kos_;
      EXCEPTION
        WHEN no_data_found THEN
          s_ := 0;
      END;

      IF s_ > 0 THEN

        --найти/открыть счет SPN/SK9, куда будем переносить просрочку
        BEGIN
          SELECT a.nls, nms, a.acc
            INTO nlsd_, nmsd_, accd_
            FROM (SELECT a.nls,
                         substr(a.nms, 1, 38) nms,
                         a.acc,
                         a.daos,
                         nvl(s.r013, 1.5)
                    FROM accounts a, nd_acc n, specparam s
                   WHERE a.tip = p.tipn
                     AND a.kv = p.kv
                     AND a.acc = n.acc
                     AND n.nd = p_nd
                     AND a.dazs IS NULL
                     AND s.acc = a.acc
                   ORDER BY a.daos, nvl(s.r013, 1.5)) a
           WHERE rownum = 1;
        EXCEPTION
          WHEN no_data_found THEN
          if NEWNBS.GET_STATE = 0 then -- Разпаралеливание кода
            nlsd_ := vkrzn(substr(gl.amfo, 1, 5),
                           substr(p.nlsk, 1, 3) || '9' ||
                           substr(p.nlsk, 5, 10));
            SELECT COUNT(*)
              INTO l_present_nls
              FROM accounts
             WHERE nls = nlsd_
               AND kv = p.kv;
            IF l_present_nls > 0 THEN
              nlsd_ := bars.f_newnls2(p.acc8,
                                      p.tipn,
                                      substr(p.nlsk, 1, 3) || '9',
                                      p.rnk,
                                      NULL);
            END IF;
          else
            nlsd_ := vkrzn(substr(gl.amfo, 1, 5),
                           substr(p.nlsk, 1, 3) || '8' ||
                           substr(p.nlsk, 5, 10));
            SELECT COUNT(*)
              INTO l_present_nls
              FROM accounts
             WHERE nls = nlsd_
               AND kv = p.kv;
            IF l_present_nls > 0 THEN
              nlsd_ := bars.f_newnls2(p.acc8,
                                      p.tipn,
                                      substr(p.nlsk, 1, 3) || '8',
                                      p.rnk,
                                      NULL);
            END IF;
          end if;

            cck.cc_op_nls(p_nd,
                          p.kv,
                          nlsd_,
                          p.tipn,
                          p.isp,
                          p.grp,
                          NULL,
                          p.mdate,
                          accd_);
            nmsd_ := substr(p_cc_id || ' ' || p_nmk, 1, 38);
        END;

        --найти/открыть счет SN8, на который будем начислять пеню
        IF spn_bri_ IS NOT NULL AND p.tipn = 'SPN' THEN
          kv_sn8_ := iif_s(cc_kvsd8, '1', gl.baseval, p.kv, gl.baseval);
          BEGIN
            SELECT a.nls
              INTO nls_sn8_
              FROM accounts a, nd_acc n
             WHERE a.tip = 'SN8'
               AND a.kv = kv_sn8_
               AND a.acc = n.acc
               AND n.nd = p_nd
               AND a.dazs IS NULL
               AND rownum = 1;
          EXCEPTION
            WHEN no_data_found THEN
              SELECT f_newnls2(p.acc8, 'SN8', NULL, NULL, kv_sn8_)
                INTO nls_sn8_
                FROM dual;
              cck.cc_op_nls(p_nd,
                            kv_sn8_,
                            nls_sn8_,
                            'SN8',
                            p.isp,
                            p.grp,
                            p.s080,
                            p.mdate,
                            acc_sn8_);
          END;
        END IF;

        IF day_ = -1 THEN
          UPDATE int_accn SET acra = accd_ WHERE acra = p.acc;
        END IF;
        IF p.kv = gl.baseval THEN
          BEGIN
            SELECT vob
              INTO vob_
              FROM tts_vob
             WHERE tt = 'ASP'
               AND ord = 1;
          EXCEPTION
            WHEN no_data_found THEN
              vob_ := 6;
          END;
        ELSE
          BEGIN
            SELECT vob
              INTO vob_
              FROM tts_vob
             WHERE tt = 'ASP'
               AND ord = 2;
          EXCEPTION
            WHEN no_data_found THEN
              vob_ := 46;
          END;
        END IF;

        --начало транзакции
        gl.ref(ref_);
        nazn_ := 'КД № ' || p_cc_id || '. Перенесення на прострочку ';

        IF p.tipn = 'SPN' THEN
          nazn_ := nazn_ || ' нарахованих вiдсоткiв';
          /*
            25.04.2014 если это ануитент по-новому,
               то из переносимой на просрочку суммы надо убрать излишки,
               которые мы могли начислить наперед
               в силу припадания пл.дня на выходные и конца мес на выходные дни
            например.
            банк.день = 01.07.2013 - понед
            плат.день = 29.06.2013 - субб, проценты должны быть взяты только по 28.06.2013 включительно  по условиям КД
            но вечером= 28.06.2013 - пятн, были начислены проценты наперед ! по 30.06.2013 включительно, по банковским правилам
                   т.е. проценты за период 29.06.2013 - 30.06.2013 уже есть на счете,
                        но они к оплате, а следовательно, и к ВЫНОСУ НА ПРОСРОЧКУ - излишни

           nov - код реализован в процедуре cck_sber  и передает сумму через переменную p_max.
           declare                  PDAT_ date  ; -- последняя пл.дата в ГПК по "сегодня"
           begin
             select max(fdat) into PDAT_ from cc_lim
             where nd=p_ND and to_char(fdat,'YYMM') < to_char(gl.bdate-1,'YYMM') and exists
                  (select 1 from int_accn i, accounts a, nd_acc n where n.nd=p_nd and n.acc=a.acc and a.tip='LIM' and a.acc=i.acc and i.id=0 and i.BASEY=2 and i.BASEM=1);
             If PDAT_ > gl.bdate - 6  then    S_ := S_ - cck.FINT ( p_ND,  PDAT_, last_day (PDAT_) ); end if ;
           end;
          */
        ELSE
          nazn_ := nazn_ || ' нарахованої комiciї';
        END IF;
        nazn_ := nazn_ || ' станом на ' || to_char(dat30_, 'dd/mm/yyyy');

        IF s_ > 0 THEN
          -- проводка
          IF nvl(g_reports, 0) = 0 THEN
            gl.in_doc3(ref_,
                       'ASP',
                       vob_,
                       ref_,
                       SYSDATE,
                       gl.bdate,
                       1,
                       p.kv,
                       s_,
                       p.kv,
                       s_,
                       NULL,
                       gl.bdate,
                       gl.bdate,
                       nmsd_,
                       nlsd_,
                       gl.amfo,
                       p.nmsk,
                       p.nlsk,
                       gl.amfo,
                       nazn_,
                       NULL,
                       p_okpo,
                       p_okpo,
                       NULL,
                       NULL,
                       0,
                       NULL,
                       NULL);
            gl.payv(cck.fl38_asp,
                    ref_,
                    gl.bdate,
                    'ASP',
                    1,
                    p.kv,
                    nlsd_,
                    s_,
                    p.kv,
                    p.nlsk,
                    s_);
            UPDATE cc_deal SET sos = 13 WHERE nd = p_nd;
          ELSE
            SELECT d.branch, c.nmk, d.sdate
              INTO l_branch, l_nmk, l_sdate
              FROM cc_deal d, customer c
             WHERE d.nd = p_nd
               AND d.rnk = c.rnk;
            INSERT INTO bars.v_cck_rep
              (branch,
               tt,
               vob,
               vdat,
               kv,
               dk,
               s,
               nam_a,
               nlsa,
               mfoa,
               nam_b,
               nlsb,
               mfob,
               nazn,
               s2,
               kv2,
               sq2,
               nd,
               cc_id,
               sdate,
               nmk)
            VALUES
              (l_branch,
               'ASP',
               vob_,
               gl.bdate,
               p.kv,
               1,
               s_,
               nmsd_,
               nlsd_,
               gl.amfo,
               p.nmsk,
               p.nlsk,
               gl.amfo,
               nazn_,
               s_,
               p.kv,
               NULL,
               p_nd,
               p_cc_id,
               l_sdate,
               l_nmk);
          END IF;
        END IF;

      END IF;
    END LOOP;

    IF nvl(g_reports, 0) = 0 THEN
      COMMIT;
    END IF;

  END cc_aspn_dog;

  --###############################################################
  -- 11.07.2016 - 07.12.2015 /08.10.2015 Вот она - новая версия
  /*procedure CC_TMP_GPK
   (ND_      int,     -- реф КД
    nVID_    int,     -- вид ГПК = 4 для "типа ануитет", =2 иначе( клас + другое)
    ACC8_    int,     -- АСС для сч 8999
    DAT3_    date,    -- Первая Дата выдачи КД
    DAT4_    date,    -- Дата завершения КД
    Reserv_  char,    -- резевв. не использую
    SUMR_    number,  -- РЕЗЕРВ. НЕ ИСПОЛЬЗУЮ -- Новый лимит по КД
    gl_BDATE date     -- резевв. не использую
     ) is
  -- окончательный пересчет процентов по ГПК  с учетом новой отметки об отсутствии платежа по процентам
    MODE2_ char(1) ;
    SS01_  char(2) :='01';
    RD_    int     :=  1 ;
    PD_    int     :=  1 ;
    dat01_ date    ;
    dd cc_deal%rowtype ;
    DAT_MIN  date  ; -- мin дата в ГПК исследуемого периода
    DAT_MAX  date  ; -- максимальная дата в ГПК
  -----------------
  lim1_ number ;
  T_DAT01 date ;
  datp_  date  ;
  basey_  int  ;
  Ir_   number := 0 ; l_sn  number := 0 ;  l_sn31  number := 0 ;
  Irk_  number := 0 ; l_sk  number := 0 ;  l_sk31  number := 0 ;
  Metr_   int  := 0 ;
  Sumk_ number := 0 ;
  -------------------------------------
  begin
   select mIN(fdat), max(fdat) into DAT_MIN, DAT_MAX from cc_lim   where nd  = ND_   ;
   begin  select s,basey       into PD_, basey_      from int_accn where acc = ACC8_ and  id = 0 and NOT( basey=2 and basem=1 )   ;
          select lim2          into lim1_            from cc_lim   where nd  = ND_   and  fDAT    = DAT_MIN  and DAT_MIN < DAT_MAX;
          select *             into dd               from cc_deal  where nd  = ND_   ;    datp_  := add_months ( DAT_MIN , -1 )   ;
          ir_ := acrn.fprocn(acc8_, 0, DAT_MIN);
   EXCEPTION WHEN NO_DATA_FOUND THEN return;
   end;
   begin  select to_number(txt)  into PD_    from nd_txt where nd=ND_ and tag='DAYSN';  EXCEPTION WHEN NO_DATA_FOUND THEN          null; end;
   begin  select substr(txt,2,1) into MODE2_ from nd_txt where nd=ND_ and tag='FLAGS';  EXCEPTION WHEN NO_DATA_FOUND THEN MODE2_:= null; end;
   IF MODE2_ is null              then     MODE2_ := nvl(GetGlobalOption('ASG-SN'),'0') ; end if ;
   If MODE2_ not in ('0','1','2') then     mode2_ :='0';                                  end if ;
  ----------------------------- MODE2_ := '0';
  --00    З канікулами. % за попередній день
  --01    З канікулами. % за попередній місяць
  --10    Без канікул   % за попередній день
  --11    Без канікул   % за попередній місяць
  --02    З канікулами. % альтернативний день
  --12    Без каникул   % альтернативний день
  --90    Вiдмiна Канік,% за попередній день
  --91    Вiдмiна Канік,% за попередній місяць
  -- 0 проц по пред.день
  -- 1 проц по пред.мес
  -- 2 проц по опеределенный, явно указанный день
   ---------------------------------------------------------
   If MODE2_ = '2' then    -- проц.долг по определенный день -1
      begin select substr(trim(txt),1,2) into ss01_ from nd_txt where nd = ND_ and tag='CCPRD';  RD_ := to_number (  ss01_     );
      exception when others then  begin RD_ := to_number(nvl(GetGlobalOption('CCPRD'),'26'));  exception when others then RD_ := 26;  end ;
      end;
      If RD_ < 1 or RD_ > 28 then RD_ := 26; end if;
      If    RD_ = 1    then MODE2_ := '1' ; -- РД= 01  ---По пред.МЕСЯЦ
      ElsIf RD_ = PD_  then MODE2_ := '0' ; -- РД= ПД  ---По пред.ДЕНЬ
      end if;
      SS01_ := substr('00'||RD_, -2 );
   end if;
   DAT01_   := to_date( SS01_ ||to_char(DAT_MIN,'MMYYYY'),'DDMMYYYY') ;
   If DAT01_ > DAT_MIN then   DAT01_ := add_months(DAT01_,-1); end if ;
   -- параметры ежемес комиссии    -- 95 = константа   -- 96 = Обычная % ставка  IRK_
   begin  select metr into  Metr_ from int_accn   where acc = ACC8_ and id = 2 and metr in (96,95,0,99) ;
          IRK_  := acrn.fprocn(acc8_, 2, DAT_MIN)         ;  --- стака годовая или простот процент
          If    metr_ =  0 then null                      ;  ---- по годовой % ставке применительно к остатку
          elsIf metr_ = 95 then SUMK_ := IRK_ * lim1_/100 ;  ---  простой % от суммы по дог, т.е. КОНСТАНТА
          elsIf metr_ = 96 then null                      ;  ---- простой % от текущей суммы остатка
          else                  null                      ;  ---- по годовой % ставке применительно сумме лимита
          end if;
   EXCEPTION WHEN NO_DATA_FOUND THEN Metr_:=null; IRK_:=0 ;
   end;
   ----------------------------------------------
  DECLARE type many1 is record ( fdat   date  , -- контрольная дата
                                 gpk    number, -- признак даты из ГПК
                                 lim1   number, -- вх.лимит
                                 sumg   number, -- сумма гашения тела
                                 sn     number, -- признак пл.по процентам
                                 sump   number, -- проц к уплате
                                 sump1  number, Dat1   date, Dat2 date,  -- расчетные про
                                 sumk   number, -- комис к уплате
                                 sumk1  number, -- комиссия расчетная
                                 sumo   number, -- итого к уплате
                                 lim2   number  );
          type  many  is  table  of many1 index by varchar2 (8) ;
          tmp   many  ;   d9 varchar2 (8) ;     d8 varchar2 (8) ;
          SNU_  number :=0 ;
          SKU_  number :=0 ;
          DatI_ date  ;
  BEGIN
     ---  Часть 1) Запомним в табл даты и делаем расчетные проценты------------------------------------
     select min (trunc(fdat,'MM')) into DatI_ from cc_lim where nd = ND_ and fdat > DAT_MIN;
     datp_  := DAT_MIN     ;
     tmp.delete;
  ---delete from TEST_TMP;
     for x in ( select        FDAT, Max(gpk) GPK, Max(sn)         SN,   Sum(sumg)  SUMG
                from ( select fdat,   1 gpk     , 1-nvl(not_sn,0) sn,  nvl(sumg,0) sumg   from cc_lim where nd = ND_   union  ALL
                       select add_months(DAT01_,num), 0, 0, 0 from conductor where NUM>0 and add_months(DAT01_,num) >= DatI_ and add_months(DAT01_,num) < DAT_MAX  and MODE2_<>'0'
                       union  ALL     select DAT_MAX, 1, 1, 0 from dual              )
                Group By FDAT Order by FDAT
              )
     loop       d8 := to_char(x.fdat,'yyyymmdd');
        if not tmp.exists(d8) then     --сформировать строку в табл
                                       tmp(d8).fdat := x.fdat; tmp(d8).lim1 := lim1_;  tmp(d8).Dat1 := datp_ ; tmp(d8).Dat2 := (tmp(d8).fdat-1);
           If    x.fdat = DAT_MAX then tmp(d8).gpk  := 1     ; tmp(d8).sn   := 1    ;  tmp(d8).sumg := lim1_ ;
           ElsIf x.fdat = DAT_MIN then tmp(d8).gpk  := 0     ; tmp(d8).sn   := 0    ;  tmp(d8).sumg := 0     ;
           else                        tmp(d8).gpk  := x.gpk ; tmp(d8).sn   := x.sn ;  tmp(d8).sumg := x.sumg;
           end if;
           -- Расчитать проц
           acrn.p_int (acc_=> ACC8_, id_=> 0,  dt1_=> tmp(d8).Dat1,   dt2_ =>tmp(d8).Dat2,  int_ => tmp(d8).sumP1, ost_ =>-tmp(d8).lim1,  mode_=>0 ) ;
           tmp(d8).sumP1 := -tmp(d8).sumP1 ;
           -- Расчитать комис
           tmp(d8).sumK1 := 0;
           If IRK_ > 0  then
              If    metr_ in (99, 0)                     then tmp(d8).sumK1:= calp_nr(tmp(d8).lim1,IRK_, tmp(d8).Dat1, tmp(d8).Dat2, basey_ ) ;    ---- по годовой % ставке применительно к остатку / лимиту
              elsIf metr_ in (95   ) and tmp(d8).gpk = 1 then tmp(d8).sumK1:= SUMK_ ;                                                         ---  простой % от суммы по дог, т.е. КОНСТАНТА
              elsIf metr_ in (96   ) and tmp(d8).gpk = 1 then tmp(d8).sumK1:= tmp(d8).lim1 * IRK_ / 100   ;                                   ---- простой % от текущей суммы остатка
              end if;
           end if ;
  ---insert into TEST_TMP values tmp(d8);
           -- переход к след строке
           lim1_ := lim1_ - tmp(d8).sumg ;
           datp_ := tmp(d8).Dat2 +1 ;
        end if;
     end loop ;  -- курсор х
     ---- Часть 2) разнесем расчетные проц по пл.датам ------------------------------------------------
     d8     := tmp.first   ; -- установить курсор на  первую запись
     d9     := tmp.first   ; -- установить курсор на  первую запись
     while d8 is not null loop
        -- сканируем даты с уплатой проц и комис
        If tmp(d8).sn =  1  then
           while d9 is not null loop
             -- сканируем все даты сверху, но меньшие или равные платежной по проц
             SNU_ := SNU_ + tmp(d9).sump1;
             SKU_ := SKU_ + tmp(d9).sumk1;
             ------------------------------
             Datp_ := Null ;
             If tmp(d8).Fdat = DAT_MAX                          then  Datp_ := tmp(d8).Fdat;  -- Посл.Период
             ElsIf MODE2_= '0' and tmp(d8).Fdat = tmp(d9).Fdat  then  Datp_ := tmp(d8).Fdat;  -- за прош ДЕНЬ
             elsIf        to_char(tmp(d9).Fdat, 'DD') = '01'    then  Datp_ := tmp(d9).Fdat;  -- за прош МЕС
             End If ;
             If Datp_ is Null then    -- Присуммировали и идем далее
                d9 := tmp.next(d9)  ; -- установить курсор на след.вниз запись
             Else                     -- Присуммировали и СТОП
                tmp(d8).sump := SnU_;
                tmp(d8).sumk := SkU_;
  ---update  TEST_TMP set sump = tmp(d8).sump , sumk= tmp(d8).sumk where fdat = tmp(d8).fdat;
                SnU_ := 0;
                SkU_ := 0;
                d9 := tmp.next(d9)  ; -- установить курсор на след.вниз запись
                EXIT;
             end if;
           end loop;  --- d9
        end if;
        d8 := tmp.next(d8)  ; -- установить курсор на след.вниз запись
     end loop;  -- d8
     --- Часть 3) Выложим все платежи в ГПК----------------------------------
     d8     := tmp.first   ; -- установить курсор на  первую запись
     while d8 is not null loop
        -- сканируем все пл.даты
        If tmp(d8).gpk   =  1  then
           tmp(d8).sumo := nvl(tmp(d8).sumk,0) + nvl(tmp(d8).sumg,0) + nvl(tmp(d8).sump,0) ;
           tmp(d8).Lim2 := tmp(d8).lim1 - tmp(d8).sumg;
  ---update  TEST_TMP set sumo = tmp(d8).sumo  where fdat = tmp(d8).fdat;
           update cc_lim  set sumk = tmp(d8).sumk, sumg = tmp(d8).sumg,  lim2 = tmp(d8).Lim2, sumo = tmp(d8).sumo    where nd = ND_  and fdat = tmp(d8).fdat;
        end if;
        d8 := tmp.next(d8)  ; -- установить курсор на след.вниз запись
     end loop;  -- d8
  ---update test_tmp set sump = round(sump,0), sump1 = round(sump1,0), sumo = round(sumo,0);
  END;  -- блок пересчета проц

   update accounts set vid = nVID_ where acccc = ACC8_ ; SUMO_CF := null;

  end CC_TMP_GPK;*/


  PROCEDURE cc_tmp_gpk(nd_      cc_deal.nd%TYPE, -- реф КД
                       nvid_    INT DEFAULT NULL, -- вид ГПК = 4 для "типа ануитет", =2 иначе( клас + другое)
                       acc8_    accounts.acc%TYPE DEFAULT NULL, -- АСС для сч 8999
                       dat3_    DATE DEFAULT NULL, -- Первая Дата выдачи КД
                       dat4_    DATE DEFAULT NULL, -- Дата завершения КД
                       reserv_  CHAR DEFAULT NULL, --резевв. не использую
                       sumr_    NUMBER DEFAULT NULL, --РЕЗЕРВ. НЕ ИСПОЛЬЗУЮ -- Новый лимит по КД
                       gl_bdate DATE DEFAULT gl.bd --резевв. не использую
                       ) IS

    -- MODE2_ = '2' -- проц.долг по определенный день. Это число м.б. только в интервале 01-28
    --    По умолчанию  мы берем его с гл.параметров. params.par='CCPRD',  но  оно м.б. задано и индивидуально         nd_txt.tag='CCPRD'

    mode2_  CHAR(1);
    lim_    NUMBER;
    sumg_   NUMBER;
    sumo_   NUMBER;
    sumk_   NUMBER := 0;
    ntmp_   NUMBER := 0; -- % за один текущий день
    int_31  NUMBER := 0; -- % за за прошлий месяц
    int_32  NUMBER := 0;
    int_    NUMBER := 0; -- % за за tek месяц
    dat_min DATE; --мin дата в ГПК исследуемого периода
    dat_max DATE; --максимальная дата в ГПК
    dat1_   DATE; -- первые числа 01-MM-YYYY исследуемого периода
    fdat_   DATE; -- пред.дата для нач %
    dd01_   INT := 1;
    ss01_   CHAR(2) := '01';
    metr96_ INT := 0;
    irk_    NUMBER := 0;
    ktmp_   NUMBER := 0;
    knt_31  NUMBER := 0;
    knt_32  NUMBER := 0;
    knt_    NUMBER := 0;
    dd      cc_deal%ROWTYPE;
    ------
    l_acc8 accounts.acc%TYPE;
    l_dat4 DATE;
    l_dat3 DATE;
    l_vidd NUMBER;
  BEGIN

   /*
    bars_audit.info('CC_TMP_GPK.ND_=' || nd_ || ' ,nVID_=' || nvid_ ||
                    ' ,ACC8_=' || acc8_ || ' ,DAT3_=' || dat3_ ||
                    ' ,DAT4_=' || dat4_ || ' ,Reserv_=' || reserv_ ||
                    ' ,SUMR_=' || sumr_ || ' ,gl_BDATE=' || gl_bdate);*/
    --ВИзначаємо необхідні параметри КД
    /*SELECT d.sos, d.wdate, f.name||' ii ', a.acc, a.kv, a.nls, ad.wdate, nvl(a.vid,0),to_number(trunc(i.s))
      \* INTO :hWndForm.Tbl_Lim.nSOS,  :hWndForm.Tbl_Lim.dfDAT4,:hWndForm.Tbl_Lim.dfFREQ,
            :hWndForm.Tbl_Lim.nAcc8, :hWndForm.Tbl_Lim.nKV8,  :hWndForm.Tbl_Lim.sNLS8,
            :hWndForm.Tbl_Lim.dfDAT3,:hWndForm.Tbl_Lim.nVid, :hWndForm.Day_Pog*\
       FROM cc_deal d, cc_add ad, freq f, cc_lim l, accounts a, int_accn I
       WHERE d.nd = ad.nd AND ad.freq = f.freq
         AND i.id =0 AND i.acc = a.acc AND l.nd = d.nd AND l.acc=a.acc
    */

    IF acc8_ IS NULL AND dat3_ IS NULL AND dat4_ IS NULL AND nvid_ IS NULL THEN
      BEGIN

        SELECT d.wdate, a.acc, nvl(a.vid, 0), ad.wdate
          INTO l_dat4, l_acc8, l_vidd, l_dat3
          FROM cc_deal d, cc_add ad, accounts a, int_accn i, nd_acc na
         WHERE d.nd = ad.nd
           AND i.id = 0
           AND i.acc = a.acc
           AND a.tip = 'LIM'
           AND na.nd = d.nd
           AND a.acc = na.acc
           AND d.nd = nd_;
      END;
    ELSE
      l_acc8 := acc8_;
      l_dat4 := dat4_;
      l_vidd := nvid_;
      l_dat3 := dat3_;
    END IF;
    BEGIN
      SELECT * INTO dd FROM cc_deal WHERE nd = nd_;
    EXCEPTION
      WHEN no_data_found THEN
        RETURN;
    END;
    SELECT nvl(MIN(fdat), l_dat3), nvl(MAX(fdat), l_dat4)
      INTO dat_min, dat_max
      FROM cc_lim
     WHERE nd = nd_;
    IF dat_min >= dat_max THEN
      RETURN;
    END IF;
    ----------------------------------------------
    BEGIN
      SELECT substr(txt, 2, 1)
        INTO mode2_
        FROM nd_txt
       WHERE nd = nd_
         AND tag = 'FLAGS';
    EXCEPTION
      WHEN no_data_found THEN
        mode2_ := NULL;
    END;

    IF mode2_ IS NULL THEN
      mode2_ := nvl(getglobaloption('ASG-SN'), '0');
    END IF;
    IF mode2_ NOT IN ('0', '1', '2') THEN
      mode2_ := '0';
    END IF;
    ---------------------------------------------------------
    IF mode2_ = '2' THEN
      -- проц.долг по определенный день
      BEGIN
        SELECT substr(TRIM(txt), 1, 2)
          INTO ss01_
          FROM nd_txt
         WHERE nd = nd_
           AND tag = 'CCPRD';
        dd01_ := to_number(ss01_);
      EXCEPTION
        WHEN OTHERS THEN
          BEGIN
            dd01_ := to_number(nvl(getglobaloption('CCPRD'), '26'));
          EXCEPTION
            WHEN OTHERS THEN
              dd01_ := 26;
          END;
      END;
      IF dd01_ < 1 OR dd01_ > 28 THEN
        dd01_ := 26;
      END IF;
      ss01_ := substr('00' || dd01_, -2);
    END IF;
    dat1_ := to_date(ss01_ || to_char(dat_min, 'MMYYYY'), 'DDMMYYYY');
    IF dat1_ > dat_min THEN
      dat1_ := add_months(dat1_, -1);
    END IF;

    BEGIN
      -- 95 = константа   -- 96 = Обычная % ставка  IRK_
      SELECT metr
        INTO metr96_
        FROM int_accn
       WHERE acc = l_acc8
         AND id = 2
         AND metr IN (96, 95, 0, 99);
      irk_ := acrn.fprocn(l_acc8, 2, dat_min);

      IF metr96_ = 95 THEN
        irk_  := 0;
        ktmp_ := 0;
      END IF;
    EXCEPTION
      WHEN no_data_found THEN
        metr96_ := NULL;
        irk_    := 0;
        sumk_   := 0;
    END;

    -- MODE2_ = '1' -- проц.долг по посл.день пред.месяца -- MODE2_ = '0' -- иначе - пред.дня

    fdat_ := dat_min;
    IF dd.vidd IN (2, 3, 12, 13) THEN
      FOR k IN (SELECT *
                  FROM cc_lim
                 WHERE nd = nd_
                   AND fdat >= dat_min
                 ORDER BY fdat) LOOP
        UPDATE cc_lim
           SET sumg = lim_ - k.lim2
         WHERE nd = nd_
           AND fdat = k.fdat;
        lim_ := k.lim2;
      END LOOP;
    END IF;

    SELECT lim2
      INTO lim_
      FROM cc_lim
     WHERE nd = nd_
       AND fdat = dat_min;
    fdat_ := dat_min;

    FOR k IN (SELECT fdat,
                     nvl(sumg, 0) sumg,
                     nvl(nvl(sumo, sumg), 0) sumo,
                     nvl(sumk, 0) sumk,
                     1 gpk,
                     nvl(not_sn, 0) prc_n,
                     to_char(fdat, 'DD') + 0 dd
                FROM cc_lim
               WHERE nd = nd_
                 AND fdat > dat_min
              UNION
              SELECT add_months(dat1_, num) fdat,
                     0 sumg,
                     0 sumo,
                     0 sumk,
                     0 gpk,
                     0 prc_n,
                     dd01_ dd
                FROM conductor
               WHERE num > 0
                 AND add_months(dat1_, num) < dat_max
                 AND mode2_ <> '0'
               ORDER BY 1) LOOP
      acrn.p_int(l_acc8, 0, fdat_, k.fdat - 1, ntmp_, -lim_, 0);
      ntmp_ := round(-ntmp_, 0);
      IF irk_ > 0 AND metr96_ <> 96 THEN
        acrn.p_int(l_acc8, 2, fdat_, k.fdat - 1, ktmp_, -lim_, 0);
        ktmp_ := round(-ktmp_, 0);
      END IF;

      --прирост %
      IF mode2_ <> '0' THEN
        --Сброс по DD01 числам, если проц учтены
        int_ := int_ + ntmp_;
        knt_ := knt_ + ktmp_;

        IF k.dd = dd01_ THEN
          int_31 := int_31 + int_;
          int_   := 0;
          knt_31 := knt_31 + knt_;
          knt_   := 0;
        END IF;
      ELSE
        int_31 := int_31 + ntmp_;
        knt_31 := knt_31 + ktmp_;
      END IF;

      IF k.gpk = 1 THEN

        IF k.fdat = dat_max THEN
          -- последняя дата - подхватываем все проценты
          int_31 := int_31 + int_;
          knt_31 := knt_31 + knt_;
          int_32 := greatest(int_31, 0);
          knt_32 := greatest(knt_31, 0);
          sumg_  := lim_;

          IF metr96_ = 96 THEN
            sumk_ := round(lim_ * irk_ / 100, 0);

          ELSE
            sumk_ := greatest(knt_32, k.sumk);
          END IF;
         --raise_application_error(-20005,'nd='||nd_||',sumk_ '||sumk_);
         sumo_ := round(lim_ + int_32 + sumk_, 0);
          -- первая дата для MODE2_<>'0'
          IF mode2_ <> '0' AND dat_min > dat1_ THEN
            acrn.p_int(l_acc8, 0, dat1_, dat_min - 1, ntmp_, NULL, 0);
            ntmp_ := round(-ntmp_, 0);
            IF irk_ > 0 THEN
              acrn.p_int(l_acc8, 2, dat1_, dat_min - 1, ktmp_, NULL, 0);
              ktmp_ := round(-ktmp_, 0);
            END IF;
            UPDATE cc_lim
               SET sumo = sumo + ntmp_ + ktmp_
             WHERE nd = nd_
               AND fdat = (SELECT MAX(fdat)
                             FROM cc_lim
                            WHERE nd = nd_
                              AND fdat <= dat_min);
          END IF;
        ELSE
          IF k.prc_n = 1 THEN
            int_32 := 0;
            knt_32 := 0; -- без процентов
          ELSE
            int_32 := greatest(int_31, 0);
            knt_32 := greatest(knt_31, 0); -- с процентами
          END IF;
          --raise_application_error(-20005,'nd='||nd_||',metr96_'||metr96_);
          IF metr96_ = 96 THEN
            sumk_ := round(lim_ * irk_ / 100, 0);
            -- raise_application_error(-20005,'nd='||nd_||',sumk_'||sumk_);
          ELSIF metr96_ = 95 THEN
            sumk_ := k.sumk;
          ELSIF metr96_ IN (0, 99) THEN
            sumk_ := knt_32;
          ELSE
            sumk_ := 0;
          END IF;

          IF dd.vidd IN (2, 3, 12, 13) THEN
            sumg_ := k.sumg;
            sumo_ := round(sumg_ + int_32 + sumk_, 0);
          ELSIF l_vidd = 4 THEN
            sumo_ := round(greatest(least(lim_ + int_32 + sumk_,
                                          nvl(sumo_cf, k.sumo)),
                                    int_32 + sumk_),
                           0);
            sumg_ := round(sumo_ - int_32 - sumk_, 0);
          ELSE
            sumg_ := least(lim_, k.sumg);
            sumo_ := round(sumg_ + int_32 + sumk_, 0);
          END IF;
        END IF;

        IF k.prc_n <> 1 THEN
          int_31 := 0;
          int_32 := 0;
          knt_31 := 0;
          knt_32 := 0;
        END IF; -- с процентами
        lim_ := greatest(lim_ - sumg_, 0);

        -- 15.08.2014 Для КЛ
        IF dd.vidd IN (2, 3, 12, 13) THEN
          UPDATE cc_lim
             SET sumo = sumo_, sumk = sumk_
           WHERE nd = nd_
             AND fdat = k.fdat;
        ELSE
          UPDATE cc_lim
             SET lim2 = lim_, sumg = sumg_, sumo = sumo_, sumk = sumk_
           WHERE nd = nd_
             AND fdat = k.fdat;
        END IF;
      END IF;
      fdat_ := k.fdat;
    END LOOP;
    UPDATE accounts SET vid = l_vidd WHERE acc = l_acc8;
    sumo_cf := NULL;

  END cc_tmp_gpk;

  --################################################################
  FUNCTION header_version RETURN VARCHAR2 IS
  BEGIN
    RETURN 'Package header CCK ' || g_header_version;
  END header_version;
  FUNCTION body_version RETURN VARCHAR2 IS
  BEGIN
    RETURN 'Package body CCK ' || g_body_version;
  END body_version;
  --------------

---Аномимный блок --------------
BEGIN

  IF getglobaloption('HAVETOBO') = '2' THEN
    fl38_asp := 0;
    tobo_    := '';
    cc_tobo_ := '';
  ELSE
    SELECT to_number(substr(flags, 38, 1))
      INTO fl38_asp
      FROM tts
     WHERE tt = 'ASP';
    tobo_    := tobopack.gettobo();
    cc_tobo_ := pul.get_mas_ini_val('CC_TOBO');
  END IF;

  spn_bri_  := to_number(getglobaloption('SPN_BRI')); -- Базовая ставка пени;
  cc_kvsd8  := nvl(getglobaloption('CC_KVSD8'), '0'); -- -- 1=счет пени открывать в вал КД, иначе в нац.вал.
  g_cc_kom_ := to_number(getglobaloption('CC_KOM'));
  cc_daynp  := to_number(nvl(getglobaloption('CC_DAYNP'), '1')); -- день гашения - следующий либо предыдущий для выбранного рабочего дня
  cc_slstp  := to_number(nvl(getglobaloption('CC_SLSTP'), '0'));
  IF to_date(getglobaloption('CCK_MIGR'), 'dd/mm/yyyy') >=
     nvl(gl.bdate, trunc(SYSDATE)) THEN
    g_cck_migr := 1;
  ELSE
    g_cck_migr := 0;
  END IF;

END cck;
/
show err;
