 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/z23.sql =========*** Run *** =======
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.Z23 IS

--***************************************************************--
--                 Резерв по НБУ-23                               --
--***************************************************************--

G_HEADER_VERSION  CONSTANT VARCHAR2(64)  := 'version 2.02 21.07.2016';

/*

21-07-2016 LUDA procedure p_delta ( dat00_ date, dat01_ date);
26-03-2014 Sta  Проверка на НЕ-формирование мес снимков - NOZ

08.01.2014 Sta  Новая проц IR_ALL по заявке Надра для заполнения информации о проц.ставках

   COMMENT ON COLUMN BARS.NBU23_REZ.IR   IS 'Ном.% ст сч - текущая';
   COMMENT ON COLUMN BARS.NBU23_REZ.IRR  IS 'Эфф.% ст КД - использованная';
   COMMENT ON COLUMN BARS.NBU23_REZ.IR0  IS 'Ном.% ст сч - начальная';
   COMMENT ON COLUMN BARS.NBU23_REZ.IRR0 IS 'Эфф.% ст КД - известная';

17.09.2013 STA Новая SQL-функция WDATE1(p_dat) для определения последнего рабочего дня.
   Это м.б. как сам день -  если он рабочий, так и предыдущий - если он выходной.

07.02.2013 Sta 1) Страховочное полное перезаполение реквизитов   rez , rezq,  BVQ , PVQ , ddd , dd ;
               2) Страховочное заполение потерянных реквизитов   OKPO, NMK, CUSTTYPE, RZ, ISTVAL, r013
06.02.2013 Sta PV  Теп.варт КД (тiльки грошовi кошти по ГПК)     PVZ Теп.варт КД (тiльки забезп)'
*/

 CHK_OK  int    ;
 cRnk    number ;
 DAT_BEG date   ;
 DAT_END date   ;
 DI_     number ;
 XOZ_    int    ;

 -------------------------------
 procedure BV_upd (p_dat01 date) ; -- Кориг бал.варт на суму SNA+SDI
 -------------------------------
 --Функция получения  PV на дату по КД
 FUNCTION F_PV(p_nd number, p_dat01 date, mode_ number ) return number ;
 ---------------------------------------------------------
 -- функция для определения последнего рабочего дня.
 -- Это м.б. как сам день -  если он рабочий, так и предыдущий - если он выходной.
 FUNCTION WDATE1(p_dat date) return date;
 -------------------------------
 FUNCTION  B   return date     ;
 FUNCTION  E   return date     ;
 FUNCTION  R   return number   ;
 FUNCTION  DI  return number   ;
/*
 PROCEDURE NOZ (p_kol OUT int) ; Пока не у всех установлена дельта
*/
---------------------------------

 procedure IR_ALL ( p_fdat nbu23_rez.fdat%type, p_nd nbu23_rez.nd%type);

 procedure ins_accp ( p_ACC   cc_accp.acc%type  ,
                      p_ACCS  cc_accp.accs%type ,
                      p_ND    cc_accp.nd%type   ,
                      p_PR_12 cc_accp.pr_12%type,
                      p_IDZ   cc_accp.idz%type
                     ) ;
-------------------------------------------------
PROCEDURE zalog_23  (dat01_ date, mode_ number) ;
  -- mode_ - 1 - по справедливой стоимости с записью в TMP_REZ_OBESP23 (для резерва)
  --         0 - по балансовой   стоимости с записью в TMP_REZ_ZALOG23 (для #D8)
-------------------------------------------------
PROCEDURE zalog (dat_ date) ;
  -- Общий вызов процедуры расчета залогов, в которой
  --      Z23.zalog_23( dat_,1); -- по справедливой стоимости (для резерва)
  --      Z23.zalog_23( dat_,0); -- по балансовой   стоимости (для #D8)
-------------------------------------------------
procedure p_delta ( dat00_ date, dat01_ date);
-- Протокол змін резерву
-------------------------------------------------
PROCEDURE INS_NLO( p_dat01 in date );
-- Вставки в NLO
-------------------------------------------------
-- Запись в журнал событий
PROCEDURE to_log_rez(id_ NUMBER, kod_ number, data_ date,txt_ varchar2);
-------------------------------------------------
PROCEDURE start_rez
( p_dat01 date,
  p_mode  int -- =0 все дела, =1 только допривязка счетов
) ;

-- подготовительные работы для расчета резервов
--------------------------------------------------
PROCEDURE pvz_pawn (p_dat01     date,
                    p_kv        TMP_REZ_OBESP23.kv%type,
                    p_acc       TMP_REZ_OBESP23.accs%type,
                    Z_koef      number,
                    p_pvz       TMP_REZ_OBESP23.pvz%type ,
                    p_pvzq      TMP_REZ_OBESP23.pvzq%type ) ;
  --поделить PVZ 1-го счета по видам обеспечения
------------------------------------------------------

PROCEDURE kontrol1  (p_dat01 date, p_id varchar2);
 -- Страховочное полное перезаполение реквизитов rez , rezq,  BVQ , PVQ , ddd , dd ;
 -- Перерасчет учтенного  залога (для ф.604) -PVZ+PVZq Враховане (частина або все Справ.варт) забезпечення, ном+eкв
 -- Страховочное заполение потерянных реквизитов OKPO, NMK, CUSTTYPE, RZ, ISTVAL, r013
-------------------
PROCEDURE CHEK_modi (p_dat01 in  date) ; -- проверяет возможность модификации протокола.
-------------------
PROCEDURE RNK_KAT (ch_ int); --создание таблицы единая кат.качества
-------------------
PROCEDURE DI_SNP ; --установка Ид дат
-------------------
PROCEDURE TKr_many
 (p_mode    in  int   , -- 0 = без записи в test_many. 1 = с записью в  test_many
  p_nd      IN  number,
  p_SS      IN  number, -- сумма выданого кредита в копейках
  p_GPK     IN  int   , -- 3- ануитет
  DAT04_    IN  date  , -- дата завершения КД
  p_RATE    IN  number, -- годовая % ставка
  p_basey   IN  int   DEFAULT 0 , --базовый год
  p_irr0    IN  number, -- нач.єф.ставка
  DAT31_    IN  date  , -- дата среза инф
  DAT01_    IN  date  , -- 01 число отчетного мес
  k_        IN  number, -- коеф (показник ризику)
  p_pv     OUT number , -- Теп.варт КД (тiльки грошовi кошти по ГПК)
  -----------------------
  Not_Use1  IN  number, -- НЕ ИСП обеспечение для включения в потоки по рын.стоимости, уже умноженное на коеф ликвидности
  Not_Use2 in  int    , -- НЕ ИСП ПЛАНОВОЕ КОЛИЧЕСТВО ДНЕЙ ДЛЯ РЕАЛИЗАЦИИ ЗАЛОГА ЭТОГО ВИДА
  Not_Use3 OUT number   -- НЕ ИСП Теп.варт КД (тiльки забезп)
 ) ;
-----------------------

PROCEDURE TK_many
 (p_nd    IN  number  ,          --:A(SEM=Реф_КД,TYPE=N)
  P_DAT01 IN  date default null, --:D(SEM=Зв_дата_01,TYPE=D)
  p_modeR IN  int     ,          -- :R(SEM=Перег=1/0,TYPE=N) 1 - с записью в TEST_MANY
  p_modeZ IN  int,                -- :Z(SEM=Включ.в 1B=1/0,TYPE=N)  = 8 для псевдо-расчета по НАДРА
  ch_     in  int  DEFAULT 0
  ) ;
-----------------------
PROCEDURE deb_kat
( dat_   in date,
  mode_  in  int,
  modeZ_ IN  int,                -- :Z(SEM=Включ.в 1B=1/0,TYPE=N)
  ch_    in  int  DEFAULT 0
);

PROCEDURE rez_deb_SB
( dat_   in date,
  mode_  in  int,
  modeZ_ IN  int,                -- :Z(SEM=Включ.в 1B=1/0,TYPE=N)
  ch_    in  int  DEFAULT 0
);
/*
 Процедура расчета резерва по дебеторской задолженности.
   mode_=0 - финансовая дебиторка
   mode_=1 - хозяйственная дебиторка
*/
-----------------------

PROCEDURE rez_deb_F
( dat_   in date,
  mode_  in  int,
  modeZ_ IN  int,                -- :Z(SEM=Включ.в 1B=1/0,TYPE=N)
  ch_    in  int  DEFAULT 0
) ;
/*
 Процедура расчета резерва по дебеторской задолженности.
   mode_=0 - финансовая дебиторка
   mode_=1 - хозяйственная дебиторка
*/
--------------------------
PROCEDURE rez_deb
( dat_   in date,
  mode_  in  int,
  modeZ_ IN  int                -- :Z(SEM=Включ.в 1B=1/0,TYPE=N)
) ;
/*
 Процедура расчета резерва по дебеторской задолженности.
   mode_=0 - финансовая дебиторка
   mode_=1 - хозяйственная дебиторка
*/
---------------------------
PROCEDURE PUL_DAT_OVR
( S_DAT01 IN  VARCHAR2, --:s(SEM=Зв_дата_01,TYPE=s)
  p_modeZ IN  int,                -- :Z(SEM=Включ.в 1B=1/0,TYPE=N)
  ch_     in  int  DEFAULT 0
 ) ;
------------------------------
PROCEDURE PUL_DAT_BPK
( S_DAT01 IN  VARCHAR2, --:s(SEM=Зв_дата_01,TYPE=s)
  p_modeZ IN  int,                -- :Z(SEM=Включ.в 1B=1/0,TYPE=N)
  ch_     in  int  DEFAULT 0
 ) ;
-------------------
PROCEDURE PUL_DAT_9
( S_DAT01 IN  VARCHAR2, --:s(SEM=Зв_дата_01,TYPE=s)
  p_modeZ IN  int,                -- :Z(SEM=Включ.в 1B=1/0,TYPE=N)
  ch_     in  int  DEFAULT 0
 ) ;

-----------------------------
procedure mbk_many
( p_dat    IN  date    ,  -- отчетная дата = 01.mm.yyyy
  p_modeZ  IN  int,       -- :Z(SEM=Включ.в 1B=1/0,TYPE=N)
  ch_      in  int  DEFAULT 0
 ) ;
-------------------------------
PROCEDURE rez_korr
(dat_    in date ,
 p_modeZ IN  int ,      -- :Z(SEM=Включ.в 1B=1/0,TYPE=N)
 ch_    in  int  DEFAULT 0
 ) ;
-------------------------------
PROCEDURE PUL_DAT_CP
( S_DAT01 IN  DATE, --:s(SEM=Зв_дата_01,TYPE=s) сделан тип даты (портилась DAT01_)
  p_modeZ IN  int,                -- :Z(SEM=Включ.в 1B=1/0,TYPE=N)
  ch_     in  int  DEFAULT 0
 ) ;
---------------------------------
PROCEDURE Rez_23( dat_   in date );
-- Вставки в общий протокол
-----------------------------------

FUNCTION nbu23_rez_crcchk (fdat_ date) RETURN boolean;

PROCEDURE nbu23_rez_crcset (fdat_ date);

FUNCTION header_version RETURN VARCHAR2; -- header_version - возвращает версию заголовка пакета
FUNCTION body_version   RETURN VARCHAR2; -- body_version   - возвращает версию тела пакета

END Z23;
/
CREATE OR REPLACE PACKAGE BODY BARS.Z23 IS

  G_BODY_VERSION  CONSTANT VARCHAR2(64)  := 'version 23.7 26-02-2018'; 

/*
115) 26-02-2018(23.7)/COBUMMFO-6811/ - В START_REZ - создание архива PRVN_FIN_DEB --> FIN_DEB_ARC 
114) 27-11-2017(23.6) - Убрала перепривязку задогов по ЦБ
113) 20-11-2017(23.5) - добавлено в START_REZ - REZ_PAR_9200   убрала (01-12-2017)
112) 26-10-2017(23.4) - финансовый лизинг (207*) - обеспечение само на себя по параметру кредитного договора ZAL_LIZ 
111) 11-09-2017 -    Очистка  errors_351 в start_rez
110) 08-08-2017 -    При отметка закрытых W4 - остатки с корректирующими
109) 31-07-2017 -    ОВЕР из CC_DEAL по условию VIDD = 110
108) 06-06-2017 -    Залоги по ОВЕРАМ ХОЛДИНГА
107) 11-04-2017 -    Очистка  nd_val,  nd_kol в start_rez
106) 04-04-2017 -    + залоги по ЦБ
105) 15-03-2017 -    в привязке залогов ограничение (ostc < 0)
104) 09-03-2017 -    p_DELTA
---------------------------
103) 29-01-2017 LUDA Заблокировала единую категорию по 23
102) 29-01-2017 LUDA при 351 теп. вартість забезпечення не розраховується
101) 29-01-2017 LUDA Блокировка расчета по 23
100) 16-01-2017 LUDA В карточках W4 добавлен счет ACC_2627X
 99) 22-12-2016 LUDA Перераспределение SNA и резерва по ЦБ аналогично кредитам. Типы счетов распределены по BPK_NBS_TIP
 98) 22-12-2016 LUDA SNA по ОВЕРАМ + Перераспределение SNA и резерва по ОВЕРАМ аналогично кредитам. Типы счетов распределены по BPK_NBS_TIP
 97) 24-11-2016 LUDA Для ММФО переоценка ЦБ через процедуру (На реал не ставить)
 96) 23-11-2016 LUDA Оптимизировала BV_upd (убрала лишний UPDATE)
 95) 07-11-2016 LUDA BV по хоз.дебиторке исправила
 94) 28-10-2016 LUDA По МБДК эф. ставка пересчитывается и записывается в CC_DEAL, если она пустая
                     (новый договор и не меняется). Если эф. ставка есть по дог. используется с договора
 93) 20-10-2016 LUDA Фінансова дебіторка (По БПК дата погашення  <--> дата прострочки)
 92) 19-10-2016 LUDA Счета дисконта записываются в протокол , даже если нет тела кредита
 91) 12-10-2016 LUDA Для 9020, 9023 ... DD=2 для ФОП
 90) 29-09-2016 LUDA Выпадали договора где SNA>BV. Исправила
 89) 27-09-2016 LUDA ВКР по 9020
 88) 03-08-2016 LUDA Сиквенс s_REZ_LOG
 87) 02-08-2016 LUDA v_gl --> accounts
 86) 01-08-2016 LUDA чтение BPK_PARAMETERS VNCRR существующие в  CCK_RATING
 85) 29-07-2016 LUDA dat_last --> dat_last_work
 84) 27-07-2016 LUDA KF в массиве по залогам
 83) 27-07-2016 LUDA По БПК, если не нашла в accounts --> bv=0
 82) 26-07-2016 LUDA tmp_nbu23_delta  --> rez_nbu23_delta
 81) 21-07-2016 LUDA P_DELTA по интервалу дат (2 параметра + z23.h)
 80) 19-07-2016 LUDA Перевычисление переоценки по ЦБ CP_UPD_PEREOC (Не установлена на реале)
--------------------
 79) 21-06-2016 LUDA Использование эф.ставки < номинальной, при установленном параметре договора RE_RN
 78) 21-06-2016 LUDA BV_upd - обнуление BVU, BVUQ
 77) 18-05-2016 LUDA W4_acc (acc_2625D) - мобільні заощадження включити до резерву
 76) 15.04.2016 Sta  Кориг бал.варт на суму невизнаних дох та дисконту  procedure BV_upd  SNA+SDI
                     Тютюнникова Л.О. 78-58, 247-85-72
 75) 29-03-2016 LUDA 3541 из ценных бумаг
 75) 25-03-2016 LUDA Восстановление показателей из таблицы откорректированных праметров.
 74) 25-03-2016 LUDA 1418 (кривой купон) ACCR3 - не учитывался в резерве
 73) 21-03-2016 LUDA 1419, 1428 дочерние счета + убрала из NLO 1428
 72) 16-03-2016 LUDA Пересчитать переоценку Ценных бумаг в связи с изменением невизнанних доходів
 71) 01-03-2016 LUDA Удалила процедуру ZPR_IRR - не нужна
 70) 01-03-2016 LUDA Упорядочила таблицы REZ_ACC, REZ_ZAL
 69) 01-03-2016 LUDA Убрала таблицу TEST_DEB (которая была для УПБ)
 ------------------- 02.1.16  17.02.2016
 68) 15-02-2016 LUDA добавлены в ЦБ accexpr - 3119, accunrec - SNA
 67) 15-02-2016 LUDA 3119 дочерние счета + убрала из NLO 3119
 ------------------- 01.2.16  31.01.2016
 66) 15-01-2016 LUDA BARSUPL.CHECK_UPLOADED_T0(p_dat01) проверка выгрузки Т0 с параметром дата
 65) 13-01-2016 LUDA Вставила блокировку расчета резерва после выгрузки T0
 64) 13-01-2016 LUDA Убрала формирование снимков (при выгрузке T0 снимки накопленны)
 63) 23-12-2015 LUDA По дебиторке финансовой несколько строк с деление на счета резерва до 30 дней и свыше
 -------------------- 9.12 02.12.2015
 62) 14-12-2015 LUDA Убрала ZAL<>0 для расчета балансовой стоимости обеспечения
 61) 08-12-2015 LUDA Убрала в дебиторке (поиск в NBU23_REZ, если сделаны проводки nd=k.acc
                     и если не найдено в NBU23_REZ REZ=0, и остальное )
 60) 02-12-2015 LUDA по МБДК эф.ставка записывается в CC_DEAL если irr0_ < 100
 59) 25-11-2015 LUDA Коррсчета из CC_DEAL
 ----           -------
 58) 29-10-2015 LUDA Реанимация договора БПК, если реанимированы счета
 57) 01-10-2015 LUDA Из МБДК исключила 1502, зачем-то занесенный в портфель МБДК
 56) 30-09-2015 Kharin Добавлена строка-условие if nvl(p_s1,0) <> 0 or nvl(p_s,0) <> 0 в МБДК для исключения добавлений пустых потоков
 55) 14-09-2015 LUDA Дата просрочки по 3570
 54) 27-07-2015 LUDA В NBU23_rez добавлено поле PVP -  «Сума очікуваних майбутніх грошових
                     потоків за кредитом відповідно до договору (Вк)»
 53) 05-05-2015 LUDA При определении догвора БПК как не работающего добавила 2627 по W4_acc
 52) 25-03-2015 LUDA ВНИМАНИЕ! Только вместе с pay_23.
                     Проверка на проводки (CHEK_modi) добавлено условие and crc=1
 51) 17-03-2015 LUDA В допривязке счетов нач.% по залогам кроме счетов ('SS ','DEP','DIU')
 50) 17-02-2015 LUDA Убрала IRR0,IRR,IR,OBESP,FIN,OBS из дебиторки
 49) 26-01-2015 LUDA Убрала TBI_ACCP_PROD disable в PROCEDURE start_rez
 48) 26-01-2015 LUDA Портфельный метод
 47) 12-11-2014 LUDA Дебиторка ISTVAL = f_get_istval (0, a.acc,  a.daos, a.kv)
 46) 14-10-2014 LUDA В допривязке счетов нач.% по залогам уточнение по номеру договора
 45) 16-09-2014 LUDA По БПК заполнила DD
 44) 16-09-2014 LUDA По МБК определение номера договора в залогах SDATE < dat01_
 43) 09-09-2014 LUDA Убрала из кредитов 2620 (Кировоград ОЩАД имеет в кредитном портфеле?)
 42) 26-08-2014 LUDA В залогах поставила PUL_DAT (портился другими функц.)
 41) 05-08-2014 LUDA ISTVAL=2 для коррсчетов для единой категории качества,
                     показатель риска берется из TMP_OB_KORR
 40) 24-07-2014 LUDA При формировании протоколов по дебиторке (07,08), если выполнены
                     проводки - категория качества берется из сформированного
                     резерва (NBU23_REZ).
 39) 11-07-2014 LUDA Определение договора по ОВЕРУ для счетов нач.% из проц.карточки для ЗАЛОГОВ
 38) 08-07-2014 LUDA Привязка залога к 9129 по кредиту (в Луганске не было привязки)
 37) 16-06-2014 LUDA Разделила ACC_DEB_23 на DEb=0-фин. DEB=1 -хоз.
 36) 27-05-2014 LUDA 3578 и 3570 - резервируются если понижается категория качества
 35) 12-05-2014 LUDA Единая категория качетва по РНК + дебиторка (v_rnk_kat-->tmp_rnk_kat)
 34) 26-03-2014 Sta  Проверка на НЕ-формирование мес снимков NOZ ;
 33) 19-02-2014 LUDA Добавлен внутренний кредитный рейтинг в 04 ПРОТОКОЛ по кредитам
 32) 19-02-2014 LUDA Переписала BPK
 31) 15-01-2014 LUDA Номер договора по гарантиям 9020 (cc_id) надо v_rez_9020.sql
 30) 08.01.2014 Sta Новая проц IR_ALL по заявке Надра для заполнения информации о проц.ставках

 29) 13.12.2013 Sta Использование ном.ставки вместо эф.
 28) 12.12.2013 Sta nbu23_rez_8
 27) 28-11-2013 Sta Вывод PV по одному пл.
 26) 25-11-2013 LUDA При расчете залогов:
                     - делится пропорционально счетам договора
                     - умножить на коэф.ликвидности
                     - вычитаются затраты на реализацию.
                     - дисконтируется по эф. ставке
                     Затраты на реализацию:
                       залог*коэф.ликвидности*%затрат на реализацию
                     По 59 постанове при наличии эф. ставки залог принимается в суме меньшей из:
                        (сума залога*коэф.ликвидности или     потоки по кредиту * k)
 25) 25-11-2013 LUDA 9129 для кредитов у которых есть ВИНАГОРОДА 3600 (3600 не правильно учитывался)
 24) 01-11-2013 LUDA start_rez - допривязка счетов залога перенесена в процедуру ZALOG
 23) 30.10.2013 LUDA прострочені платежі  до  майбутніх грошових потоків
                     включаються в  останній  період по параметру REZ_WDATE=1
 22) 30.10.2013 LUDA Дебиторка СБЕРБАНК ДНЕПРОПЕТРОВСКА уточнил дебіторську заборгованість
                     за  капітальними вкладеннями 3510 (r011=1).
 21) 30.10.2013 LUDA Доработки по 59 постанове
 20) 10.10.2013 LUDA При привязке залогов исключила привязку к счетам 'DEP' (2620)
 19) 17.09.2013 LUDA Погрешности округления в залогах
 18) 17.09.2013 LUDA Параметр s250 проставляется:
      nbu.s250:='6'; -- Заборгованість за кредитними операціями з позичальниками, у яких є джерела надходження валютної виручки
      nbu.s250:='7'; -- Заборгованість за кредитними операціями з позичальниками, у яких немає джерела надходження валютної виручки
      nbu.s250:='8'; -- Заборгованість за кредитними операціями за фінансовими активами
      nbu.s250:='9'; -- Заборгованість за кредитними операціями на міжбанківському ринку
      nbu.s250:='A'; -- Заборгованість за наданими фінансовими зобов`язаннями, щодо наданих гарантій
      nbu.s250:='B'; -- Заборгованість за наданими фінансовими зобов`язаннями з кредитування
      nbu.s250:='C'; -- Заборгованість за операціями, за якими немає ризику
 17) 17.09.2013 LUDA 2805,2806 включены в дебиторку, но резерв по ним не считается (для отчетности)
 16) 17.09.2013 STA  Новая SQL-функция WDATE1(p_dat) для определения последнего рабочего дня.
     Это м.б. как сам день -  если он рабочий, так и предыдущий - если он выходной.
     Использую  в МБК для определения короткий/длин

 15) 27.08.2013+04-09-2013  Sta Проц по МБК с учетом изм % ставки / Исправлены дл
 14) 12-08-2013 по 2401 - категория качества только по обслуживанию долга.
                по таблице 21 постановы 23 (реализованно в тригере tbu_CCDEAL_K23)
 13) 02-08-2013 Единая категория качества для КРЕДИТОВ, ОВЕРДРАФТОВ, БПК + источник
                валютной выручки (по параметру REZ_KAT).
 12) 02-07-2013 МБК Удлинили до 2- мес понятие "коротких",
                Для PV: % - всегда за весь период, независимо от
                        остатка на сч нач %,
                        суммы погашенных  %,
                        даты посл.начисления - это переменчивие и случайные значения
                        они изменяют BV, и следовательно, сумму рез REZ.
                        Это справедливо, т.е. если проц.доходы банка уже начислены за счет дебиторки (1528),
                        которая м.б. не полностью погашена, то ее надо резерсировать дополнительно.
                                                   не
 11) 03.06.2013 МБК проц за весь период минус то, что погашено
 -------------------------------------------------------------
 10) Добавлено поле OB22 + TIP
  9) Добавлено поле Diskont. XOZ - по параметру
  8) При поиске ном.% ставки ищем незакрытый счет тела с мин датой отк счета
  7) Все по заг - переехало в свою проц.
     НБУ 59.
     ГПК оригинал и архив

  6) допривязка залогов ко всем счетам ОВР
  5) процедура ZALOG_23 переехала в этот пакедж
  4) DI_ гл.переменная и функция
  3) Утюжок Выравнивает
     DDD DD
     дисконт
     округляет
     заполение  ISTVAL, r013 по АСС
     r013 ='9' and k.nbs = '9129'
     BV-PV-PVZ-REZ = 0 (кроме  ЦБ)
     Все Эквиваленты;
     заполение  OKPO, NMK, CUSTTYPE, RZ
     расшифровка обеспечения  PVZ и PVZq по видам обеспечения

  2) 9129 без тела кредита
  1) функция в сентуре "->Перенесення поточних ГПК в архiв"

*/

------------------------------
  --общие переменные
  DAT19_ date := to_date('01-01-1900','dd-mm-yyyy');
  DAT01_ DATE ; DAT31_ DATE ;
  TYPE DDDR IS  RECORD (r020 char(4), ddd char(3) );
  TYPE DDDM IS  TABLE  OF DDDR INDEX BY varchar2(4);
  tmp  DDDM   ;
  ddd_9100 char(3);

  TYPE accr IS RECORD ( nbs char(4), kv   BINARY_INTEGER, nls varchar2(15),
                        bv  NUMBER , bvq  NUMBER,         tip varchar2(3) ,
                        pv  NUMBER , pvq  NUMBER,         acc  INTEGER    ,
                        pvz NUMBER , pvzq NUMBER,         ob22 varchar2(2),
                        rez NUMBER , rezq NUMBER,
                        zal NUMBER , zalq NUMBER,
                        pvp NUMBER , sdate date
                       );
  TYPE accm IS TABLE OF accr INDEX BY BINARY_INTEGER ;
  acct accm   ;
  acc_ BINARY_INTEGER ;
  sa_  number ;
  ddd_ NBU23_REZ.DDD%type;

  BV_    NUMBER ; BVq_   number ;
  PV_    NUMBER ; PVq_   NUMBER ;
  PVZ_   number ; PVZq_  number ;
  ZAL_   NUMBER ; ZALq_  NUMBER ;
  REZ_   NUMBER ; REZQ_  NUMBER ;

  -- для балансировки разницы округлений
  D_PV   number ; D_PVq  number ;
  D_PVZ  number ; D_PVZq number ;
  D_REZ  number ; D_REZq number ;
  D_ZAL  number ; D_ZALq number ;

-------------------------------------------------------------------
procedure BV_upd (p_dat01 date) is z_dat01 date; s_dat01 varchar2(10) ;

l_commit number;
dat31_   date;
begin
   z23.to_log_rez (user_id , 351 , p_dat01 ,'--> BV_UPD');
   dat31_:= Dat_last_work (p_dat01 -1 );  -- последний рабочий день месяца
   if   p_dat01 is null then   s_dat01 := pul.get_mas_ini_val('sFdat1') ;
        if s_dat01 is null then   raise_application_error( -20333,'   PRVN_FLOW.heir39 : Не задано звітну дату = 01.mm.yyyy');    end if;
        z_dat01 := to_date( s_dat01, 'dd.mm.yyyy') ;
   else z_dat01 := p_dat01;   s_dat01 := to_char(z_dat01, 'dd.mm.yyyy')  ;  pul_dat(s_dat01, null ) ;
   end if;
   z23.to_log_rez (user_id , 351 , p_dat01 ,'--> BVU = BV');
   for k in (select rowid RI from nbu23_rez where fdat=p_dat01)
   LOOP
      update nbu23_rez set bvu = bv, bvuq = bvq where rowid = k.ri;
   end LOOP;
   z23.to_log_rez (user_id , 351 , p_dat01 ,'<> BVU = BV');
   commit;
   l_commit := 0;
   z23.to_log_rez (user_id , 351 , p_dat01 ,'--> SNA');
   for x in (select nd, BV, kv, substr(id,1,3) ID from nbu23_rez where fdat = z_dat01 and tip ='SNA' and bv <0 and nls < '4')
   loop
      for  y in (select rowid RI, bv, tip, BVu    from nbu23_rez
                 where fdat = z_dat01 and kv = x.kv  and bv > 0 and nd= x.nd and id like x.ID||'%' and nls<'4'
                 order by  decode (tip, 'SPN',1, 'SNO',2, 'SN ',3, 'SPI',4, 'SP ',5, 'SS ',6, 10 ),bv
                 )
      loop y.BVu := x.BV + y.BV;
           If y.BVu < 0 then  x.BV := y.BVu ; y.BVu := 0;
           else               x.BV := 0     ;
           end if;
           If x.kv = gl.baseval then  update nbu23_rez set BVu = y.BVu, BVuq =                     y.BVu                   where rowid = y.RI;
           else                       update nbu23_rez set BVu = y.BVu, BVuq = gl.p_icurval( x.kv, y.BVu*100, dat31_)/100  where rowid = y.RI;
           end if;
         l_commit :=  l_commit + 1 ;
         If l_commit >= 500 then  commit;  l_commit:= 0 ;  end if;

      end loop; --y
   end loop; -- x
   z23.to_log_rez (user_id , 351 , p_dat01 ,'<> SNA');
   --------------------------
   l_commit := 0;
   z23.to_log_rez (user_id , 351 , p_dat01 ,'--> SDI');
   for x in (select nd,  BV, kv, substr(id,1,3) ID from nbu23_rez where fdat = z_dat01 and tip ='SDI' and bv <0 and nls < '4')
   loop
      for  y in (select rowid RI, nvl(BVu,BV) BV, tip, BVu  from nbu23_rez
                 where fdat = z_dat01 and kv = x.kv  and nvl(BVu,BV) > 0 and nd= x.nd and id like x.ID||'%' and nls < '4'
                 order by  decode (tip, 'SP ',1, 'SS ',2, 'SPI',3, 'SPN',4, 'SNO',5, 'SN ',6, 10 )
                 )
      loop y.BVu := x.BV + y.BV;
         If y.BVu < 0 then  x.BV := y.BVu ; y.BVu := 0;
         else               x.BV := 0     ;
         end if;

         If x.kv = gl.baseval then  update nbu23_rez set BVu = y.BVu, BVuq =                     y.BVu                    where rowid = y.RI;
         else                       update nbu23_rez set BVu = y.BVu, BVuq = gl.p_icurval( x.kv, y.BVu*100, dat31_)/100  where rowid = y.RI;
         end if;
         l_commit :=  l_commit + 1 ;
         If l_commit >= 500 then  commit;  l_commit:= 0 ;  end if;

      end loop; -- y
   end loop;    -- x
   z23.to_log_rez (user_id , 351 , p_dat01 ,'<> SDI');
   -- Первоначально заполняется BV и BVQ
   -- update nbu23_rez set BVu = BV, BVuq =  BVq where  fdat = z_dat01 and BVu is null ;

end BV_upd;
-------------------------

 --Функция получения  PV на дату по КД
 FUNCTION F_PV(p_nd number, p_dat01 date, mode_ number ) return number is
  --  mode_ = 0 - не дисконтированный поток
  --  mode_ = 1 - дисконтированный поток

  TELO_   number := 0; l_pv    number; TELO1_     number;  l_dat31 date; d8     VARCHAR2(8);
  S_      number := 0; l_basey number; rez_wdate_ number;  DAT042_ date; d9     VARCHAR2(8);
  INT_31  number := 0; Ref_    number;                     l_fdat  date; r_fdat date       ;
  int_    number := 0;

  dd  cc_deal%rowtype ;
  a8  accounts%rowtype;
  K1  SYS_REFCURSOR   ;
  gpk cc_lim%rowtype  ;

  l_RATE  number ; -- годовая % ставка
  l_irr0  number ; -- нач.єф.ставка
  l_ost   number ; -- непогаш ост по телу
  l_s1    number ; -- общ.сумма 1-го платежа
  l_ss    number ; -- в нем - сумма тела \
  l_sn    number ; -- в нем - сумма проц /  общ.сумма 1-го платежа

  PVDAT_  date   := p_DAT01 ; -- дата для включения просрочки - оптимистичный сценарий
  DAT_pl1 date   := null   ; -- первая пл.дата в следующем периоде
----------------------------------------
  TYPE many1 IS RECORD (fdat date, p1_ss number, p1_sn number, many number, lim2 number, lim1 number, plan1 number, NOT_SN number);
  TYPE MANY  IS TABLE  OF many1 INDEX BY VARCHAR2(8);
  tmp  MANY;

BEGIN
    begin
       select   * into dd from cc_deal where nd = p_nd;
       select a.* into a8 from accounts a, nd_acc n where n.nd = p_nd and n.acc= a.acc and a.tip='LIM';
    exception when others then return null;
    end;
    if a8.vid  = 4 THEN a8.vid := 3;
    else                a8.vid := 1;
    end if;
    ------------------
    IF dd.wdate < p_DAT01 THEN    RETURN null; END IF ;
    rez_wdate_ := nvl(F_Get_Params('REZ_WDATE', 0) ,0);
    if gl.amfo in ( '353575' , '300120') or rez_wdate_ = 1  THEN   --ДЕМАРК + ПЕТРОКОМЕРЦ = 59 постанова
       PVDAT_  := dd.wdate; --пессимитстичнo-индивидуальный сценарий.
       -- по доп.реквизиту. если нет. то на посл. дату
       begin
          select to_date(txt,'dd/mm/yyyy') into  PVDAT_ from nd_txt where nd = p_nd and tag = 'PVDAT';
       exception when others then null;
       end;
    end if;

    PVDAT_  := greatest      ( p_DAT01   , PVDAT_   );
    l_dat31 := Dat_last_work ( p_dat01-1);
    l_irr0  := round(acrn.fprocn   ( a8.acc ,-2, l_dat31 ), 8);

    begin
       select RATE , BASEY  INTO   l_RATE, l_BASEY
       from ( SELECT ACRN.FPROCN(ACC,0, l_DAT31) RATE,  NBS, KV, BASEY
              FROM  (SELECT A.ACC, A.NBS, A.KV, I.BASEY
                     FROM   ACCOUNTS A, INT_ACCN I
                     WHERE  A.ACCC = a8.acc and ost_korr(a.acc,l_dat31,z23.di_,a.nbs)<>0 AND I.ID=0 AND I.ACC=A.ACC
                            and (a.dazs is null or a.dazs >l_dat31)
                     ORDER BY A.daos
                    )
              WHERE ACRN.FPROCN(ACC,0, l_DAT31) >0 and ROWNUM =1
            );

    EXCEPTION  WHEN NO_DATA_FOUND  THEN  l_basey:=2;
    end;

    -- общий баланс по ГРК (-выдано(факт) + погашение(план). TELO_ = разница
    l_ss   := fost(a8.acc, l_dat31 );   TELO_  := l_ss;

    tmp.DELETE;
    d8     := TO_CHAR(l_DAT31,'yyyymmdd');
    tmp(d8).fdat  := l_DAT31 ;
    tmp(d8).p1_ss := l_ss    ;
    tmp(d8).many  := 0       ;
    -------------------------------------------------
    -- след даты = типа погашение
    If p_dat01 > sysdate   then   -- прямо из ГПК
       OPEN k1 FOR SELECT fdat,sumg,sumo,NOT_SN from cc_lim     where                  nd = p_nd and fdat > l_DAT31 and fdat <= dd.wdate order by fdat ;
    else                       -- уже из архива ГПК
       OPEN k1 FOR select fdat,sumg,sumo,NOT_SN from cc_lim_arc where mdat=p_DAT01 and nd = p_nd and fdat > l_DAT31 and fdat <= dd.wdate order by fdat ;
    end if;
    IF NOT K1%ISOPEN THEN    RETURN null; END IF;
    LOOP
    FETCH     K1 into gpk.fdat, gpk.sumg, gpk.sumo, gpk.NOT_SN;
       EXIT WHEN K1%NOTFOUND;
       TELO_    := TELO_ + nvl(gpk.sumg,0) ;
       If gpk.fdat < p_DAT01 then  d8 := TO_CHAR( p_DAT01,'yyyymmdd');     tmp(d8).fdat :=  p_DAT01 ;
       else                        d8 := TO_CHAR(gpk.fdat,'yyyymmdd');     tmp(d8).fdat := gpk.fdat ;
       end if ;
       tmp(d8).p1_ss := gpk.sumg ;
       tmp(d8).many  := 0      ;
       tmp(d8).p1_sn := (gpk.sumo-gpk.sumg) ;
       tmp(d8).NOT_SN:= gpk.NOT_SN;
       dat_pl1       := nvl( dat_pl1, gpk.fdat) ;
    end loop;
    CLOSE k1;
    ----------------------------------------------

    -- DAT04 = последняя дата (на свякий случай)
    d8      := TO_CHAR(dd.wdate,'yyyymmdd');

    if NOT tmp.EXISTS(d8) then
       tmp(d8).fdat := dd.wdate ;
       tmp(d8).p1_ss:= 0 ;
       tmp(d8).many := 0 ;
       tmp(d8).p1_sn:= 0 ;
    end if;

    DAT042_  := add_months( dd.wdate , 2);

    --ВСТАВКА ОТЧЕТНыХ ДАТ (01), ЕСЛИ ОНИ изначально НЕ ЕСТЬ ПЛАТЕЖНыМИ
    for k in ( select trunc( add_months( l_DAT31, c.num),'MM') FDAT  from conductor c
               where c.NUM > 0  and add_months( l_DAT31,c.num) < DAT042_ )
    loop
       d8     := TO_CHAR(k.fdat,'yyyymmdd');
       if NOT tmp.EXISTS(d8) then
          tmp(d8).fdat := k.fdat ;
          tmp(d8).p1_ss:= 0      ;
          tmp(d8).many := 1      ;
       end if;

    end loop;

    If PVDAT_ > p_DAT01 then
       d8     := TO_CHAR(PVDAT_,'yyyymmdd');
       if NOT tmp.EXISTS(d8) then
          tmp(d8).fdat  := PVDAT_ ;
          tmp(d8).p1_ss := 0      ;
          tmp(d8).many  := 0      ;
       end if;
    end if;
    TELO1_ := TELO_;
    If TELO_ < 0 then    --просрочка
       d8     := TO_CHAR(PVDAT_,'yyyymmdd');       tmp(d8).p1_ss := NVL (tmp(d8).p1_ss, 0)  - TELO_;
    elsIf TELO_ > 0 and a8.vid = 3 then
       -- досрочка Ануитет
       l_ost := - l_ss;

       -- последняя плат дата в отчетном (пред.) периоде
       --  общ.суммы 1-го платежа
       begin
          If  p_DAT01 > sysdate then
             select max(fdat) into l_fdat from cc_lim     where                   fdat < p_DAT01 and nd = p_nd ;
             select sumo      into l_s1   from cc_lim     where                   fdat = l_fdat  and nd = p_nd ;
          else
             select max(fdat) into l_fdat from cc_lim_arc where mdat = p_DAT01 and fdat < p_DAT01 and nd = p_nd ;
             select sumo      into l_s1   from cc_lim_arc where mdat = p_DAT01 and fdat = l_fdat  and nd = p_nd ;
          end if;
       EXCEPTION  WHEN NO_DATA_FOUND  THEN      l_s1 := 0;
       end;

       -- перестроить весь график (сверху -> вниз) с сохранением общ.суммы 1-го платежа
       d8 := tmp.FIRST; -- установить курсор на  первую запись
       WHILE d8 IS NOT NULL
       LOOP
          If tmp(d8).fdat >= p_DAT01 and  tmp(d8).many = 0 then
             l_sn := 0;
             If l_ost > 0 then
	        l_sn := ROUND(  calp(l_ost, l_RATE, l_FDAT, tmp(d8).fdat -1,nvl(l_basEy,2) ),0);
             end if;
             l_ss := least( l_ost, greatest(l_s1 - l_sn,0) );
             tmp(d8).p1_ss := l_ss  ;
             tmp(d8).p1_sn := l_sn  ;
             l_ost         := l_ost - l_ss ;
             l_fdat        := tmp(d8).fdat ;
          end if;
          d8 := tmp.NEXT(d8); -- установить курсор на след.вниз запись
       end loop;

    elsIf TELO_ > 0 then

       -- досрочка - не ануитет  -- поиск снизу->вверх ненулевых сумм (каникул НЕТ)
       d8 := tmp.LAST; -- установить курсор на последнюю запись
       WHILE d8 IS NOT NULL
       LOOP
          If tmp(d8).fdat >= p_DAT01  and  tmp(d8).p1_ss > 0 and TELO_ > 0 then
             S_    := least( TELO_,tmp(d8).p1_ss   );
             tmp(d8).p1_ss    := tmp(d8).p1_ss- S_;
             TELO_ := TELO_ -S_ ;
          end if;
          d8 := tmp.PRIOR(d8); -- установить курсор на след.вверх запись
       end loop;

    end if;

    -- Проставить вх и исх остатки
    l_ss := 0;
    d8   := tmp.LAST; -- установить курсор на последнюю запись
    WHILE d8 IS NOT NULL
    loop
       tmp(d8).lim2 := l_ss ;  l_ss := l_ss - Nvl( tmp(d8).p1_ss, 0 ) ;
       tmp(d8).lim1 := l_ss ;  d8   := tmp.PRIOR(d8); -- установить курсор на след.вверх запись
    end loop;

    -- еще раз пересчитаем проценты (кроме ануитета)
    If TELO1_ <> 0 and a8.vid  <> 3 then
       -- начальные проценты = строго остаткам на счетах ( SN )  +  ( SNO c mdate=null)
       select -NVL(sum(  ost_korr(a.acc,l_dat31,z23.di_,a.nbs)  ),0)    into INT_31
       from nd_acc n, accounts a where n.nd  = p_ND   and n.acc  = a.acc   and ( a.tip ='SN ' or a.tip ='SNO' and a.mdate is null    );

       --Расчитать проц и запомнить их
       d8 := tmp.FIRST; -- установить курсор на  первую запись
       l_fdat := null ;
       r_fdat := p_DAT01 - 1 ;
       WHILE d8 IS NOT NULL
       LOOP
          If tmp(d8).fdat >=   p_DAT01 then
             If tmp(d8).fdat > p_DAT01 then
                s_ := ROUND(calp(-tmp(d8).LIM1,l_RATE,l_FDAT,tmp(d8).FDAT-1, nvl(l_basey,0)),0);  int_31 := Int_31 + s_;
             end if;
             l_FDAT := tmp(d8).FDAT ;
             If substr( d8,-2) = '01' or tmp(d8).fdat = dd.wdate then
                -- необходимо выложить проц в ближ плат. дату. в кот проц еще  НЕ выкладывались

                If r_fdat = dd.wdate then   d9 := TO_CHAR( dd.wdate ,'yyyymmdd');
                   tmp(d9).p1_sn := nvl(tmp(d9).p1_sn, 0) + S_ ;
                else
                   d9 := d8;
                   WHILE d9 IS NOT NULL
                   LOOP
                      If tmp(d9).many   = 0  and  nvl(tmp(d9).NOT_SN,0) <> 1 and tmp(d9).fdat > r_fdat  then
                         tmp(d9).p1_sn := int_31 ; int_31 := 0 ;  r_fdat := tmp(d9).fdat; EXIT ;
                      end if ;
                      d9 := tmp.NEXT(d9); -- установить курсор на след.вниз запись
                   end loop  ;
                end if;

             end if;
          end if;
          d8 := tmp.NEXT(d8); -- установить курсор на след.вниз запись
       end loop;
    end if;
    -------------------------------------------------
    --счета-одиночки  типа просроченных и отложенных нач %%
    for k in (select a.tip, ost_korr(a.acc,l_dat31,z23.di_,a.nbs) OST, mdate, a.nbs, a.acc  from nd_acc n, accounts a
              where n.nd = p_nd  and n.acc = a.acc and a.tip in ('SPN','SNO') and ost_korr(a.acc,l_dat31,z23.di_,a.nbs) <> 0   )
    loop
       if k.tip =    'SPN' and k.nbs like '2__9' then
          -- просроченные проценты   - на p_DAT01
          d8     := TO_CHAR(PVDAT_,'yyyymmdd');
          tmp(d8).p1_sn := nvl( tmp(d8).p1_sn, 0 ) - k.ost ;

       Elsif k.tip = 'SNO' and k.nbs like '2__8' and k.mdate is not null then

          begin
             --реструктуризированные отложенные проценты. кот имеют ГПП
             select refp into ref_ from cc_add where nd = p_nd and adds =0 and refp is not null;
             for o in (select Dat_Next_U(fdat,1) FDAT, S from opldok where ref=REF_ and dk=1 and acc=k.acc and fdat >= l_dat31)
             loop
                d8 := TO_CHAR( o.FDAT,'yyyymmdd');
                tmp(d8).fdat  := o.FDAT;
                tmp(d8).p1_ss := nvl( tmp(d8).p1_ss, 0 ) ;
                tmp(d8).p1_sn := nvl( tmp(d8).p1_sn, 0 ) + o.S ;
                tmp(d8).many  := 0;
             end loop;

          EXCEPTION  WHEN NO_DATA_FOUND  THEN
             -- отложенные  проценты   - на mdate, кот НЕ имеют ГПП
             d8     := TO_CHAR(k.mdate,'yyyymmdd');
             tmp(d8).fdat  := k.mdate;
             tmp(d8).p1_ss := nvl( tmp(d8).p1_ss, 0 ) ;
             tmp(d8).p1_sn := nvl( tmp(d8).p1_sn, 0 ) - k.ost ;
             tmp(d8).many  := 0;
          end;

       end if;
    end loop;

    -- PV  Теп.варт КД (тiльки грошовi кошти по ГПК)
    l_pv  := 0 ;
    d8    := tmp.FIRST; -- установить курсор на  первую запись
    WHILE d8 IS NOT NULL
    LOOP
       S_ := 0 ;
       if tmp(d8).FDAT > l_DAT31 then
          tmp(d8).plan1 := nvl( tmp(d8).p1_ss, 0 ) + nvl( tmp(d8).p1_sn, 0 )   ;
          if mode_=0 THEN  s_:= tmp(d8).plan1;
          else             s_:= tmp(d8).plan1 / power (  (1+ l_irr0/100 ), (tmp(d8).FDAT - p_DAT01 )/365 ) ;
          end if;
          s_ := round(S_,0);   l_pv :=  l_pv  + S_;
       end if;
       d8 := tmp.NEXT(d8); -- установить курсор на след.вниз запись
    end loop;

    -- l_pv  := ROUND(  l_pv,0); -- HE умножено !!
    Return L_PV;
 end f_pv;

 ------------------------------------
 -- функция для определения последнего рабочего дня.
 -- Это м.б. как сам день -  если он рабочий, так и предыдущий - если он выходной.
 FUNCTION WDATE1(p_dat date) return date is
   l_datr date;
 begin
   l_datr := Dat_Next_U (  (p_dat + 1), -1 );
   return l_datr;
 end WDATE1;

 ---------------------------
 FUNCTION B  return date   is begin   return Z23.DAT_BEG ; end B  ;
 FUNCTION E  return date   is begin   return Z23.DAT_END ; end E  ;
 FUNCTION R  return number is begin   return Z23.cRNK    ; end R  ;
 FUNCTION DI return number is begin   return Z23.DI_     ; end DI ;
 ------------------------------------------------------------------
 -- процедура вставки данных в протокол расчета резерва - таблицу rez_log
 PROCEDURE to_log_rez (id_ NUMBER, kod_ number, data_ date,txt_ varchar2)
   IS
      PRAGMA AUTONOMOUS_TRANSACTION;
   l_row_id  number;
   l_CHGDATE date  ;
   BEGIN

      --  dbms_output.put_line(txt_||' '||val_);

     l_row_id := bars_sqnc.get_nextval('s_REZ_LOG');
     l_CHGDATE:= sysdate;

     INSERT INTO rez_log (KOD ,ROW_ID  ,USER_ID,CHGDATE,TXT ,fdat )
                  VALUES (kod_,l_row_id,id_    ,sysdate,txt_,data_);

     COMMIT;
   END;


/*  ПОКА НЕ У ВСЕХ УСТАНОВЛЕНА ДЕЛЬТА
 PROCEDURE NOZ (p_kol OUT int) is
 begin
   p_kol := 0 ;

   -- Если идет накопление мес снимка, расчет НЕ делаем
   select count(*)
   into p_kol
   from ( select o.object_name from (select * from dba_objects where owner='BARS') o inner join v$session v on o.object_id = v.plsql_entry_object_id
          union all
          select o.object_name from (select * from dba_objects where owner='BARS') o inner join v$session v on o.object_id = v.plsql_object_id
         )
   where upper( object_name)  in ('AGG_02' ) ;

   If p_kol > 0  then
      begin
         bms.enqueue_msg('Идет Накоп.мес.снимков, подождите', dbms_aq.no_delay, dbms_aq.never, nvl(user_id,1) ) ;
      exception when others then null;
      end ;
   end if;

 end NOZ;
*/

-------------------------------------------------------------------
procedure IR_ALL ( p_fdat nbu23_rez.fdat%type, p_nd nbu23_rez.nd%type) is

/*
  08.01.2014 Sta Новая проц IR_ALL по заявке Надра для заполнения информации о проц.ставках
     COMMENT ON COLUMN BARS.NBU23_REZ.IR   IS 'Ном.% ст сч - текущая';
     COMMENT ON COLUMN BARS.NBU23_REZ.IRR  IS 'Эфф.% ст КД - использованная';
     COMMENT ON COLUMN BARS.NBU23_REZ.IR0  IS 'Ном.% ст сч - начальная';
     COMMENT ON COLUMN BARS.NBU23_REZ.IRR0 IS 'Эфф.% ст КД - известная';
*/

l_nd    nbu23_rez.nd%type := -1 ;
l_acc8  accounts.acc%type ;
dat31_  date;
l_mind  date;

l_irr0  number;
l_ir0   number;
l_ir    number;

begin
  dat31_:= Dat_last_work (p_fdat - 1 );  -- последний рабочий день месяца

  for k in ( select rowid RI, nd, acc, irr, nbs  from nbu23_rez r
             where r.fdat = p_fdat and r.id like 'CCK2%' and p_nd in (0,r.nd)
             order by r.nd
           )
  loop

     If l_nd <> k.nd then l_nd := k.nd;      l_irr0 := k.irr;
        if nvl(l_irr0,0) = 0 then
           begin
              select round(acrn.fprocn(a.acc,-2,dat31_),8) into l_irr0 from accounts a,nd_acc n where n.nd=k.nd and n.acc=a.acc and a.tip='LIM';
           exception when no_data_found then null;
           end;
        end if;
     end if;

     if l_irr0 is null then   l_irr0 := k.irr;  end if;

     If substr(k.nbs,3,1) <'5' then  select min(BDAT) into  l_mind from INT_RATN where acc=k.acc and id=0;
        if l_mind is not null  then  l_ir0 := acrn.fprocn(k.acc,0, l_mind ) ;  l_ir  := acrn.fprocn(k.acc,0, dat31_ ) ;
             update nbu23_rez set irr0 = l_irr0, ir0 = l_ir0, ir = l_ir  where rowid = k.RI;
        else update nbu23_rez set irr0 = l_irr0                          where rowid = k.RI;        end if;
     else    update nbu23_rez set irr0 = l_irr0                          where rowid = k.RI;
     end if;

  end loop;

end IR_ALL;
----------------------------

procedure ins_accp ( p_ACC   cc_accp.acc%type  ,
                     p_ACCS  cc_accp.accs%type ,
                     p_ND    cc_accp.nd%type   ,
                     p_PR_12 cc_accp.pr_12%type,
                     p_IDZ   cc_accp.idz%type
                   ) is
begin
   begin
      insert into CC_ACCP (ACC,ACCS,ND,PR_12,IDZ) values (p_ACC,p_ACCS,p_ND,p_PR_12,p_IDZ);
   exception when others then
      --ORA-00001: unique constraint (BARS.XPK_CC_ACCP) violated
      if SQLCODE = -00001 then null;   else raise; end if;
   end;
end ins_accp;

-----------------
PROCEDURE zalog ( dat_ date) is

l_59_ZAL   NUMBER  DEFAULT 0;
REZ_KAT_   NUMBER  DEFAULT 0;
dat31_     DATE;
pv_        NUMBER;
k_         NUMBER;
pr_imp_    NUMBER;
sdat01_    char(10);
ch_        number;
-------------------------
-- Снимки
sid_       varchar2(64)  ;
sess_      varchar2(64)  :=bars_login.get_session_clientid;
l_GET_SNP_RUNNING number ;
--------------------------


begin
   z23.CHEK_modi(DAT_) ;               --блокировка расчета после формирования проводок
   sdat01_ := to_char( DAT_,'dd.mm.yyyy');
   PUL_dat(sdat01_,'');
   dat31_:= Dat_last_work (dat_ - 1);  -- последний рабочий день месяца
   z23.start_rez(dat_,1);              --допривязка счетов залога
   --p_w4_arc;
   -- Снимки
   -- И расчет резерва и снимки устанавливают флажок
   -- Чтение флажка
   begin
      select BARS_UTL_SNAPSHOT.GET_SNP_RUNNING into l_GET_SNP_RUNNING from dual;
   EXCEPTION WHEN NO_DATA_FOUND THEN l_GET_SNP_RUNNING := 0;
   end;
   if l_GET_SNP_RUNNING = 1 THEN -- накапливаются снимки или считается резерв

      SYS.DBMS_SESSION.CLEAR_IDENTIFIER;
      sid_:=SYS_CONTEXT('BARS_GLPARAM','MONBAL');
      SYS.DBMS_SESSION.SET_IDENTIFIER(sess_);

      begin
         select sid into sid_ from v$session
          where sid=sid_ and sid<>SYS_CONTEXT ('USERENV', 'SID');
         raise_application_error(-20000,'Формується знімок балансу. Зачекайте і повторіть знову SID '|| sid_);
      exception
         when no_data_found THEN   BARS_UTL_SNAPSHOT.stop_running;
      end;

   end if;
/* Убрано, снимки должны быть обновлены
   if sysdate>dat_ THEN
      -- формирование снимков
      BARS_UTL_SNAPSHOT.sync_month(dat31_);
   end if;
*/
   -- установка флажка что формируются снимки (резерв)
   BARS_UTL_SNAPSHOT.start_running;
   execute immediate 'truncate table REZ_ACC';
   z23.to_log_rez (user_id , 1 , dat01_ ,'REZ_ACC');
   --занесение данных по  кредитным счетам
   --(по которых будем считать резерв)
   for k in ( select a.acc, a.nls, a.kv, nvl(a.nbs,substr(a.nls,1,4)) nbs, a.rnk rnk, ost_korr(a.acc,dat31_,z23.di_,a.nbs) lim, a.tip
              from  rez_nls_23 nb, accounts a
              where   nvl(a.nbs,substr(a.nls,1,4)) = nb.nbs AND (a.dazs IS NULL  OR  a.dazs > dat31_)
            )
   LOOP
      If k.lim < 0 THEN
         insert into REZ_ACC
              ( ACC   ,
                NLS   , -- кредитный счет
                KV    , -- код валюты
                NBS   , -- номер балансового счета
                RNK   , -- реф.договора
                LIM   , -- остаток по счету с учетом корректирующих
                TIP     -- тип счета
              )
         values (k.acc,k.nls,k.kv,k.nbs,k.rnk,k.lim,k.tip);
      end if;
   end LOOP;

   z23.to_log_rez (user_id , 14 , dat_ ,'Начало залог - справедливая стоимость');
   Z23.zalog_23( dat_,1); -- по справедливой стоимости (для резерва)
   z23.to_log_rez (user_id ,-14 , dat_ ,'Конец залог  - справедливая стоимость');
   z23.to_log_rez (user_id , 15 , dat_ ,'Начало залог - балансовая  стоимость');
   Z23.zalog_23( dat_,0); -- по балансовой   стоимости (для #D8)
   z23.to_log_rez (user_id ,-15 , dat_ ,'Конец залог  - балансовая  стоимость');

/*
   Постанова 59 Загальна сума недисконтованих майбутніх грошових
      потоків, у тому  числі  грошових  потоків  від  реалізації
      застави,  не може перевищувати суми платежів, що передбачена
      кредитним договором.

      По телефонной консультации ДЕМАРКа с НБУ было уточнение
      "не може перевищувати МАЙБУТНЬОЇ суми платежів,
      що передбачена кредитним договором".
      Добавлено условие: and fdat>=DAT01_ c учетом просрочки, досрочки
*/

   --z23.to_log_rez (user_id , 16 , dat_ ,'Начало залог - Теперішня вартість');
   --BEGIN
   --   SELECT TO_NUMBER (NVL (val, '0')) INTO l_59_ZAL FROM params  WHERE par = '59_ZAL';
   --EXCEPTION  WHEN NO_DATA_FOUND   THEN      l_59_ZAL := 0;
   --END;
   --REZ_KAT_:=nvl(F_Get_Params('REZ_KAT', 0) ,0);

   l_59_ZAL:=0;  -- 29-01-2017 при 351 теп. вартість забезпечення не розраховується
   if l_59_ZAL=1 THEN
      -- z23.RNK_KAT(1);
--      select count(*) into ch_ from tmp_rnk_kat;
      begin
         for k in (select distinct nd from tmp_rez_obesp23   where dat=dat_ and nvl(IRR0,0)<>0  )
         loop
            begin
               select decode(REZ_KAT_,1,f_rnk_kat_k(d.rnk,d.kat23,d.k23,2,f_get_istval(d.nd,0,d.sdate,cd.kv)),d.k23) into k_
               from cc_deal d,cc_add cd  where d.nd=k.nd and cd.nd=k.nd and adds=0;
            EXCEPTION  WHEN NO_DATA_FOUND   THEN               k_:=0;
            end;

            pv_:=nvl(z23.F_PV(k.nd, dat_,0),0)*k_;
            for p in (select rowid ri,nd,kv,accs, accz,pawn,sum_imp,s,decode(z,0,s,z) z,
                             round(least (s,decode(z,0,s,z)) ,0) s1,irr0,dat_p
                      from (select t.nd,t.kv,t.accs,t.accz, t.S, t.pawn, t.sum_imp,
                                   nvl(round((pv_)*t.S / sum(t.s) over  (partition by 1) , 0),t.s) Z, irr0,dat_p
                            from tmp_rez_obesp23 t
                            where t.nd = k.nd and t.dat = dat_ and t.s> 0 ))
            loop
               if p.IRR0<>0 THEN  -- залог по эф.ставке
--                  BEGIN
--                     SELECT nvl(ad.proc_imp,0)
--                     INTO   pr_imp_
--                     FROM   CC_PAWN23ADD ad
--                     WHERE  ad.pawn = p.pawn;
--                  EXCEPTION WHEN NO_DATA_FOUND THEN pr_imp_:=0;
--                  END;

                  if p.dat_p<DAT_ THEN  -- если договор просрочен для УПБ (Дата окончания дог.+к-во дней на реализ.)
                     p.s1:=0; p.z:=0;
                  else
                     p.s1     := round(  p.s1 / power (  (1+ p.irr0/100 ), (p.dat_p - DAT_ )/365 ) , 0 ) ;
                  end if;

--                  p.sum_imp:= round(p.s1 * pr_imp_/100,0);
--                  p.s1     := greatest(p.s1 - p.sum_imp,0);
                  update tmp_rez_obesp23 set pv = p.z, s = p.s1,sq=p_icurval(p.kv,p.s1,dat31_),
                         sum_imp = p.sum_imp, sumq_imp = p_icurval(p.kv,p.sum_imp,dat31_),
                         k = k_
                  where rowid=p.ri;
               end if;
            end loop;
         end loop;
      end;
   end if;
   --z23.to_log_rez (user_id , -16 , dat_ ,'Конец залог - Теперішня вартість');
   BARS_UTL_SNAPSHOT.stop_running;
end zalog;
------------------

PROCEDURE zalog_23  (dat01_ date, mode_ number) is
  -- mode_ - 1 - по справедливой стоимости с записью в TMP_REZ_OBESP23 (для резерва)
  --         0 - по балансовой   стоимости с записью в TMP_REZ_ZALOG23 (для #D8)

g_restdate DATE;            -- дата накопления корректирующих проводок
dat31_     date;

zal_sp_    NUMBER  DEFAULT 0; -- Включити до розрах.резерву справедливу варт.забезпечення
--rez_disc_  NUMBER  DEFAULT 0; -- 1 - дисконт включается в резерв в рамках балансового счета и валюты
rez_upz_   NUMBER  DEFAULT 0; -- флаг - Проставление признака первичного залога (заказ Демарк)
--rezpar2_   NUMBER  DEFAULT 0;
--rezpar3_   NUMBER  DEFAULT 0;
--rezpar4_   NUMBER  DEFAULT 0;
--rezpar9_   NUMBER  DEFAULT 0; -- флаг - расчет обесп проср > 30 дней коредитов по спец алгоритму
--rezpar10_  NUMBER  DEFAULT 0; --T 22.01.2009
--rezpar11_  NUMBER  DEFAULT 0; --T 07.04.2009
l_59_ZAL   NUMBER  DEFAULT 0; -- флаг - расчет обеспечения по 59 постанове.

n_         NUMBER  := 0;
discont_   NUMBER  := 0;
prem_      NUMBER  := 0;
OBESP_     NUMBER  := 0;
zal_       NUMBER;
vid_zal    NUMBER;
userid_    NUMBER;
DAY_       NUMBER;
grp_       NUMBER;
RATE_      NUMBER;
BASEY_     NUMBER;
accs_      NUMBER;
nds_       NUMBER;

ind_       VARCHAR2 (30);

vidd_      CC_deal.vidd%type;

   TYPE type_zal IS TABLE OF tmp_rez_obesp23%ROWTYPE
   INDEX BY BINARY_INTEGER;

   allzal_         type_zal;
   onezal_         type_zal;

   TYPE type_discont IS TABLE OF tmp_rez_risk3%ROWTYPE
   INDEX BY BINARY_INTEGER;

   alldisc_        type_discont;
   onedisc_        type_discont;

   TYPE type_prem IS TABLE OF tmp_rez_risk4%ROWTYPE
   INDEX BY BINARY_INTEGER;

   allprem_        type_prem;
   oneprem_        type_prem;

   TYPE type_odncre IS TABLE OF VARCHAR2 (1)
   INDEX BY BINARY_INTEGER;

   dodncre_        type_odncre;

   TYPE type_prcrd IS TABLE OF VARCHAR2 (1)
      INDEX BY BINARY_INTEGER;

   prcrd_          type_prcrd;

   TYPE type_przalkl IS TABLE OF VARCHAR2 (1)
      INDEX BY BINARY_INTEGER;

   przalkl_        type_przalkl;

   TYPE type_dnpr IS TABLE OF NUMBER
      INDEX BY BINARY_INTEGER;

   TYPE type_prcrezal IS TABLE OF VARCHAR2 (1)
   INDEX BY VARCHAR(30);

   prcrezal_       type_prcrezal;

   allzal_null_    type_zal;
   alldisc_null_   type_discont;
   allprem_null_   type_prem;
   dodncre_null_   type_odncre;
   dnprcre_null_   type_dnpr;
   prcrd_null_     type_prcrd;
   przalkl_null    type_przalkl;
   prcrezal_null_       type_prcrezal;

   -- начало функции
   function obesp_23 (
      acc_         INT,
      dat_         DATE,
      mode_   IN   INT DEFAULT 0,
      zal_    out  number,
      vid_zal out  number ,
      disc_        number,
      prm_         number,
      p_ostc       number,
      p_nd         number,
      p_KVS        number
   )
      RETURN NUMBER
   IS

   IRR0_     NUMBER; sk1_    NUMBER; onezals_ NUMBER := 0    ;   erm    VARCHAR2 (80); acc8_   INT ; l_dat   DATE;  r013_   CHAR (5);
   kk_31     NUMBER; sz_     NUMBER; k_       NUMBER := 1    ;   r013_2 varchar2 (10); l_RE_RN INT ; wdate_  DATE;  REZ_N_  CHAR (1);
   sz1_      NUMBER; zal1_   NUMBER; sk_      NUMBER := 0    ;
   pr_       NUMBER;
   --dni_    NUMBER;
   sk_s     NUMBER := 0    ;
   ostc_zo_  NUMBER; o31_    NUMBER; n1_      NUMBER := 0    ;
   OSTC_Z31_ NUMBER; sk1_31  NUMBER; kk_      NUMBER (20, 10);
   sum_imp_  NUMBER; pr_imp_ NUMBER; nd_      NUMBER ;
   ret_      NUMBER; sall_   NUMBER; rnk_     NUMBER ;

   fl_use_as_first_zal_       NUMBER:= 0    ; -- счет привязанного к залогу кредита просрочен >30 дней
   ern      CONSTANT POSITIVE       := 208;
   err      EXCEPTION;

   BEGIN
      IF acc_ IS NULL      THEN         RETURN 0;      END IF;
      --------------------------------------------------------
      nd_:= p_nd;  sz_:= 0;  zal_:= 0; vid_zal := null; n1_:= 0;
      onezal_.DELETE;

      --проверить все договора залога на этот кредит с ЗО
      --цикл по всем счетам залога относящимся к данному счету
      --и для каждого счета залога - по всем крединтым счетам
      FOR k IN (SELECT z5.ACC, z5.kv, --счет залога
                       --следующий счет залога относящийся к данному счету
                       lead(z5.acc,1,-1) over(order by z5.acc, z5.ACCS1 ) next_acc,
                       --предыдущий счет залога относящийся к данному счету
                       lag(z5.acc,1,-1)  over(order by z5.acc, z5.ACCS1 ) prev_acc,
                       z5.NLS, z5.NBS, abs(gl.p_icurval( z5.kv,z5.OSTC_Z,DAT31_)) ostc, z5.PAWN, z5.S031, z5.R031, z5.PR_12, z5.PWN cnt,
                       gl.p_icurval( z5.kv_s,z5.OSTC_s,DAT31_) s, z5.ACCS1, z5.nd, z5.kv_s kv_s
                 from  REZ_ZAL z5 --,accounts a,specparam p
                 where z5.accs = acc_ and z5.OSTC_s <> 0 --a.acc = z5.accs1 and
                 group by z5.ACC, z5.kv, z5.kv_s, z5.NLS, z5.NBS, z5.OSTC_Z, z5.PAWN, z5.S031, z5.R031, z5.PR_12, z5.PWN, z5.OSTC_s, z5.ACCS1, z5.nd
                 order by z5.acc, z5.ACCS1
               )
      LOOP
         l_dat := NULL;  IRR0_ := 0;  REZ_N_:= 0;  o31_ := k.ostc;
         -- Убрала, в ОЩАДБАНКЕ не используется (Не учитывать залог) - возможно использование в др. ситуациях.
         --if mode_ = 1 THEN
         --   begin
         --      select substr(trim(value),1,1) into REZ_N_ from accountsw where acc=k.acc and tag='REZ_N';
         --   EXCEPTION  WHEN NO_DATA_FOUND THEN NULL;
         --   end;
         --end if;

         --if REZ_N_ = '1' and mode_ = 1 THEN
         --   k.ostc   := 0; o31_   := 0;
         --end if;

         begin
            SELECT a.nbs || DECODE (NVL (p.r013, '1'), '9', '9', '1') INTO   r013_  FROM   accounts a, specparam p
            WHERE  a.acc = p.acc(+) AND a.acc = k.accs1;
         EXCEPTION  WHEN NO_DATA_FOUND THEN RETURN 0;
         end;

         if erm is null then            -- сумма 1-го кредита на дату dat_ (с ЗО)
            BEGIN
               --параметры счета, влияющие на расчет обеспечения
               SELECT p_ostc, a.rnk,a.nbs||DECODE (NVL (p.r013, '1'), '9', '9', '1') INTO sk1_, rnk_, r013_2
               FROM   accounts a,specparam p  WHERE  a.acc = p.acc(+) and a.acc = acc_;

               sk1_31 := sk1_;

               nd_ := p_nd;

               --if dat_ <= to_date('31122011','ddmmyyyy') then --В соответствии с Постановой №650 (от 03,11,2009)
               --   dni_ := greatest(to_date('01102008','ddmmyyyy') - wdate_,0);
               --else
               --   dni_ := dat_ - wdate_;
               --end if;

               --спец обработка 9129, 9023
               IF r013_2='91299' OR sk1_>0 THEN
                  sk1_31 := 0; -- (для отчетности #D8 надо общая сумма залога)
                  sk1_   := 0;
               END IF;
               if r013_2='90231' and mode_=1 THEN
                  sk1_31 := 0; -- (для отчетности #D8 надо общая сумма залога)
               end if;

            EXCEPTION  WHEN NO_DATA_FOUND THEN RETURN 0;
            END;
            erm := '1';
         end if;

         --начали обрабатывать новый счет залога
         --т.е. предыдущий счет залога (k.prev_acc) оличается от текущего (k.acc)
         --1. определяем вид залога
         --2. определяем остаток по счету залога
         if k.prev_acc <> k.acc then

             --1.
             if k.cnt > 1 then  vid_zal :=  40;
             else               vid_zal := k.pawn;
             end if;

             --2.
             ostc_zo_ := k.ostc   ;
             OSTC_Z31_:= o31_ ;

             -- если данное обеспечение является первичным, а кредит просрочен > 30 дней
             -- то используем только для данного кредита
             fl_use_as_first_zal_ := 0;

             ind_:=to_number(TRIM(TO_CHAR(k.acc))||trim(TO_CHAR(nd_)));

             IF prcrezal_.EXISTS (ind_)    THEN
                -- если acc_ не относится к кредиту просроченному > 30 дней
                -- обеспечение не очитывается

                IF NOT prcrd_.EXISTS (nd_) THEN

                   ostc_zo_ := 0;
                   OSTC_Z31_:= 0;

                   IF k.pr_12=3 THEN  fl_use_as_first_zal_ := 3;
                   ELSE               fl_use_as_first_zal_ := 0;
                   END IF;

                ELSE
                   IF k.pr_12=3 THEN  fl_use_as_first_zal_ := 3;
                   ELSE               fl_use_as_first_zal_ := 1;
                   END IF;
                END IF;
             ELSE
                IF k.pr_12=3 THEN     fl_use_as_first_zal_ := 3;
                ELSE                  fl_use_as_first_zal_ := 0;
                END IF;
             END IF;

             -- сумма всех кредитов, имеющих текущий k.NDZ общий дог залога
             -- только отрицательные  п2600 не брать !
             sk_  := 0; --discont_ := 0;   premiy_ := 0;
         end if;

         -- обрабтываем информацию по кредитным счетам, которые относятся к текущему счету залога
         if mode_=1 THEN
            IF k.s < 0 AND r013_ <> '91299' AND r013_ <> '90231' THEN
            -- 1. рассматриваем как кредиты все кроме однородных кредитов
            -- 2. в расчете пропорции для первичного залога (cc_accp.pr_12 =1)
            -- не участвуют счета относящиеся к другим договрам

            if    ((fl_use_as_first_zal_ = 1  AND (k.accs1 = acc_ OR k.nd = nd_)                            )
               OR  (fl_use_as_first_zal_ = 0  AND NOT przalkl_.EXISTS(rnk_)  AND NOT prcrezal_.EXISTS (ind_))
               or  (fl_use_as_first_zal_ = 3                                                                )
               ) THEN
               sk_s := k.s;
               sk_s := LEAST (sk_s, 0);
            END IF;

            sk_   := sk_ + sk_s;
            sk_s  :=0;

         END IF;
         ELSE
         IF k.s < 0 AND r013_ <> '91299' THEN
            if   ((fl_use_as_first_zal_ = 1  AND (k.accs1= acc_ OR k.nd = nd_)                             )
               OR (fl_use_as_first_zal_ = 0  AND NOT przalkl_.EXISTS(rnk_)  AND NOT prcrezal_.EXISTS (ind_))
               or (fl_use_as_first_zal_ = 3                                                                )
               ) THEN
               sk_s := k.s;
               sk_s := LEAST (sk_s, 0);
            END IF;

            sk_   := sk_ + sk_s;
            sk_s  :=0;
         END IF;
         END IF;

         -- закончили обрабатывать один счет залога
         --т.е. следующий счет залога (k.next_acc) отличается от текущего (k.acc)
         --рассчитываем сумму обеспечения по данному счету залога
         if k.next_acc <> k.acc then

            IF sk_ <> 0 THEN

               BEGIN
                  SELECT p.KL*100, nvl(ad.DAY_IMP,180), c.grp23,nvl(ad.sum_imp,0),
                         nvl(ad.proc_imp,0)
                  INTO   pr_, DAY_, grp_,sum_imp_,pr_imp_
                  FROM   cc_pawn c, cc_pawn_23 p, CC_PAWN23ADD ad
                  WHERE  c.pawn = k.pawn and c.grp23=p.grp23 and c.pawn = ad.pawn(+) ;
               EXCEPTION WHEN NO_DATA_FOUND THEN   pr_ := 0; DAY_ := 180; grp_:=0;sum_imp_:=0;pr_imp_:=0;
               END;

               begin
                  SELECT A.ACC,d.vidd,d.wdate INTO ACC8_, vidd_, wdate_
                  FROM ND_ACC N, ACCOUNTS A, cc_deal d
                  WHERE n.nd=d.nd and N.ND=nd_ AND N.ACC=A.ACC AND
                        A.TIP='LIM' and rownum=1;
               EXCEPTION WHEN NO_DATA_FOUND THEN acc8_:=NULL;
                  begin
                     select ir,wdate,vidd into IRR0_,wdate_,vidd_
                     from cc_deal where nd=nd_;
                  EXCEPTION WHEN NO_DATA_FOUND THEN IRR0_:=0;
                  end;
               END;


               if vidd_ in (1,11) then     -- проверим эфф. ставку ?\

                  if gl.amfo in ('353575','380764','300205') THEN   -- ДЕМАРК, НАДРА, УПБ (FPROCN долго работает)
                     begin
                        if gl.amfo in ('300205') THEN  -- УПБ (первоначальная эф. ставка)
                           select round(IR,8) INTO IRR0_
                           from INT_RATN
                           where acc=acc8_ and id=-2 and
                                 bdat = (SELECT MIN(bdat) FROM int_ratn
                                         WHERE acc=acc8_ AND id=-2 AND bdat<=dat01_);

                        else
                           select round(IR,8) INTO IRR0_
                           from INT_RATN
                           where acc=acc8_ and id=-2 and
                                 bdat = (SELECT MAX(bdat) FROM int_ratn
                                         WHERE acc=acc8_ AND id=-2 AND bdat<=dat01_);
                        end if;
                     EXCEPTION WHEN NO_DATA_FOUND THEN IRR0_ := 0 ;
                     end;
                  else   -- остальные
                     IRR0_ := NVL(round(ACRN.FPROCN(acc8_,-2,DAT31_),8), 0);
                  end if;

                  If IRR0_ <= 0 or IRR0_ >= 100 then
                     IRR0_ := 0 ;
                  end if;

                  -- ном
                  If gl.amfo ='380764' THEN  -- НАДРА ОЧЕНЬ ДОЛГО РАБОТАЕТ НИЖНИЙ ВАРИАНТ
                     begin
                        select IR INTO RATE_
                        from INT_RATN
                        where acc=acc8_ and id=0 and ROWNUM =1;
                     EXCEPTION WHEN NO_DATA_FOUND THEN rate_:= 0 ;
                     end;
                  else
                     begin
                        select RATE  INTO RATE_
                        from ( SELECT ACRN.FPROCN(ACC,0, DAT31_) RATE
                               FROM  (SELECT A.ACC FROM ACCOUNTS A, INT_ACCN I
                               WHERE A.ACCC = acc8_ and a.ostc<>0 AND I.ID=0 AND I.ACC=A.ACC
                                 and (a.dazs is null or a.dazs>dat31_)
                               ORDER BY A.daos)
                        WHERE ACRN.FPROCN(ACC,0, DAT31_) >0 and ROWNUM =1);
                     EXCEPTION WHEN NO_DATA_FOUND THEN rate_:= 0 ;
                     end;
                  end if;
                  -- COBUSUPABS-4614 (Использование эф.ставки < номинальной, при установленном параметре договора RE_RN)
                  l_RE_RN := (case when cck_app.Get_ND_TXT (nd_, 'RE_RN')='Taк' THEN 0 else 1 end) ;
                  If IRR0_ < RATE_ and l_RE_RN = 1 then
                     IRR0_ := 0 ;
                  end if;
               end if;

               --заносим информацию по текущему обеспечению в массив
               --расчитываем сумму залога по данному счету залога

               kk_   := sk1_ / sk_;
               kk_31 := sk1_31 / sk_;

               zal1_ := ostc_zo_ * kk_ ; --T 24.02.2009
               sz1_  := ostc_zo_ * kk_ * pr_ / 100;

               /* Сума витрат на реалізацію застави:
                  Попередньо оцінені майбутні грошові потоки від реалізації застави
                  зменшуються на суму витрат на її реалізацію.
                  То есть мы уменьшаем на затраты исходя из оцененных потоков,
                  а не исходя из текущей рыночной стоимости.
                  А оцененные потоки, это рыночная стоимость*Кликвидности.
               */
               if pr_imp_<>0 THEN
                  -- sum_imp_ := zal1_*pr_imp_/100;
                  sum_imp_ := round(sz1_*pr_imp_/100,0);
               end if;

               sall_ := ROUND (ABS (OSTC_Z31_*kk_31));
               zal_  := zal_ + ROUND (ABS (zal1_));
               ND_   := nvl( ND_, acc_);
               n1_   := n1_ + 1;

               If ( getglobaloption('MFOP') = '300465' or gl.aMfo = '300465' )  then
                  if l_59_ZAL=0 THEN
                     -- для СБЕРБАНКА дисконтирование залога на дату окончания договора +
                     If WDATe_ < DAT31_ then  l_dat := DAT31_ + 180;
                     else                     l_dat := WDATe_;
                     end if;
                  else
                     l_dat:= DAT01_ + DAY_;
                  end if;
               else
                  If gl.amfo ='300205' then
                     l_dat:=WDATE_ + DAY_;
                  else
                     l_dat:= DAT01_ + DAY_;
                  end if;
               end if;
               If gl.amfo ='353575' then -- По просьбе ДЕМАРК (они ввели параметр для счета дата реализации залога)
                  begin
                     select to_date(value,'dd.mm.yyyy') into l_dat from accountsw
                     where acc=k.acc and tag='DRZ' ;
                  EXCEPTION WHEN NO_DATA_FOUND THEN null ;

                  end ;
                  if l_dat<=DAT01_ then
                     l_dat:=DAT01_ ;
                  end if;
                  DAY_:=l_dat-DAT01_;
               end if;

               if l_59_ZAL=0 THEN  -- по старому без 59 постановы
                                     -- для 59 постановы по эф.ставке перенесено вконец
                  if IRR0_<>0 THEN  -- залог по эф.ставке
                     sz1_ := round(  sz1_ / power (  (1+ irr0_/100 ), (l_dat - DAT01_ )/365 ) , 0 ) ;
                  end if;
               end if ;
               If l_59_ZAL<>0  then
                  sz1_:=greatest(abs(sz1_)-sum_imp_,0);  -- минус затраты на реализацию
               end if;
               onezal_ (n1_).dat     := dat01_;
               onezal_ (n1_).userid  := userid_;
               onezal_ (n1_).accs    := acc_;
               onezal_ (n1_).accz    := k.acc;
               onezal_ (n1_).pawn    := k.pawn;
               onezal_ (n1_).s       := gl.p_Ncurval(p_KVS,ROUND (ABS (sz1_),0),DAT31_);
               onezal_ (n1_).sq      := ROUND (ABS (sz1_),0);
               onezal_ (n1_).s_l     := gl.p_Ncurval(p_KVS,ROUND (ABS (sz1_),0),DAT31_);
               onezal_ (n1_).sq_l    := ROUND (ABS (sz1_),0);
               onezal_ (n1_).proc    := pr_;
               onezal_ (n1_).grp     := grp_;
               onezal_ (n1_).sall    := gl.p_Ncurval(p_KVS,sall_,DAT31_);
               onezal_ (n1_).sallq   := sall_;
               onezal_ (n1_).nd      := nd_;
               onezal_ (n1_).kv      := p_KVS;
               onezal_ (n1_).DAY_IMP := DAY_;
               onezal_ (n1_).DAT_P   := l_dat;
               onezal_ (n1_).IRR0    := IRR0_;
               onezal_ (n1_).sum_imp := gl.p_Ncurval(p_KVS,sum_imp_,DAT31_);
               onezal_ (n1_).sumq_imp:= sum_imp_;
               onezal_ (n1_).pr_imp  := pr_imp_;
               onezal_ (n1_).kf      := sys_context('bars_context','user_mfo');
               sz_ := sz_ + ROUND (ABS (sz1_));

            END IF;
         end if;
      END LOOP;

      -- расчет приведенного обеспечения
      IF ABS (sk1_) < ABS (sz_)   THEN
         k_ := ABS (sk1_ / sz_);
      END IF;

      --заносим информацию по обеспечению в массив
      IF onezal_.COUNT > 0        THEN
         FOR p IN onezal_.FIRST .. onezal_.LAST
         LOOP
            n_ := n_ + 1;
            allzal_ (n_).dat     := dat01_;
            allzal_ (n_).userid  := userid_;
            allzal_ (n_).accs    := onezal_ (p).accs;
            allzal_ (n_).accz    := onezal_ (p).accz;
            allzal_ (n_).pawn    := onezal_ (p).pawn;
            allzal_ (n_).s       := onezal_ (p).s;
            allzal_ (n_).sq      := onezal_ (p).sq;
            allzal_ (n_).s_l     := onezal_ (p).s_l;
            allzal_ (n_).sq_l    := onezal_ (p).sq_l;
            allzal_ (n_).grp     := onezal_ (p).grp;
            allzal_ (n_).proc    := onezal_ (p).proc;
            allzal_ (n_).sall    := onezal_ (p).sall;
            allzal_ (n_).sallq   := onezal_ (p).sallq;
            allzal_ (n_).nd      := onezal_ (p).nd;
            allzal_ (n_).kv      := onezal_ (p).kv;
            allzal_ (n_).DAY_IMP := onezal_ (p).DAY_IMP;
            allzal_ (n_).DAT_P   := onezal_ (p).DAT_P;
            allzal_ (n_).IRR0    := onezal_ (p).IRR0;
            allzal_ (n_).sum_imp := onezal_ (p).sum_imp;
            allzal_ (n_).sumq_imp:= onezal_ (p).sumq_imp;
            allzal_ (n_).pr_imp  := onezal_ (p).pr_imp;
            allzal_ (n_).kf      := onezal_ (p).kf;
            onezals_ := onezals_ + ROUND (onezal_ (p).s * k_);
         END LOOP;
      END IF;

      ret_ := ABS (sz_);
      RETURN ret_;
   END obesp_23;
   ----  конец функции

BEGIN

   z23.CHEK_modi(DAT01_) ;  --блокировка расчета после формирования проводок
   z23.DI_SNP;
--   z23.start_rez(dat01_,1); --допривязка счетов залога

   dat31_ := Dat_last_work(dat01_ - 1);  -- последний рабочий день месяца
   g_restdate := NULL;
   userid_    := gl.aUid;

   If gl.amfo ='380764'  THEN
      --execute immediate 'delete from REZ_ACC';
      execute immediate 'delete from rez_zal';
   else
      --execute immediate 'truncate table REZ_ACC';
      execute immediate 'truncate table rez_zal';
   end if;

   if mode_=1 THEN
      -- флаг - включити до розрах.резерву справедливу варт.забезпечення
      BEGIN
         SELECT TO_NUMBER (NVL (val, '0'))  INTO zal_sp_   FROM params WHERE par = 'ZAL_SP';
      EXCEPTION  WHEN NO_DATA_FOUND THEN zal_sp_ := 0;
      END;
   else                                          zal_sp_:=0;
   end if;

   -- флаг - включать дисконт в рамках балансового счета и валюты
   --BEGIN
   --   SELECT TO_NUMBER (NVL (val, '0'))     INTO rez_disc_ FROM params  WHERE par = 'REZ_DISC';
   --EXCEPTION  WHEN NO_DATA_FOUND      THEN       rez_disc_ := 0;
   --END;

   -- флаг - автом.проставление признака первичного залога (заказ Демарк)
   -- Если у клиента есть залог под несколько кредитов и по одному
   -- или нескольким из них есть просрочка > 30 дней, то первичным
   -- считается залог для кредита с наибольшей суммой задолженности
   -- из числа просроченных.
   BEGIN
      SELECT TO_NUMBER (NVL (val, '0'))   INTO l_59_ZAL FROM params  WHERE par = '59_ZAL';
   EXCEPTION  WHEN NO_DATA_FOUND     THEN      l_59_ZAL := 0;
   END;

   BEGIN
      SELECT TO_NUMBER (NVL (val, '0'))   INTO rez_upz_ FROM params  WHERE par = 'REZ_UPZ';
   EXCEPTION  WHEN NO_DATA_FOUND     THEN      rez_upz_ := 0;
   END;

   -- ??? флаг - учитывать при расчете обеспечениеи 26 для кредитов > 2 лет (КИЕВ)
   --BEGIN
   --   SELECT TO_NUMBER (NVL (val, '0'))   INTO rezpar2_ FROM params   WHERE par = 'REZPAR2';
   --EXCEPTION  WHEN NO_DATA_FOUND   THEN        rezpar2_ := 0;
   --END;

   -- ??? флаг - специальная обработка Лизинга 2071 (АКБ Ажио)
   --   BEGIN
   --   SELECT TO_NUMBER (NVL (val, '0'))   INTO rezpar3_ FROM params   WHERE par = 'REZPAR3';
   --EXCEPTION  WHEN NO_DATA_FOUND  THEN         rezpar3_ := 0;
   --END;

   -- ????флаг - не учитывать при расчете дисконт
   --BEGIN
   --   SELECT TO_NUMBER (NVL (val, '0'))   INTO rezpar4_ FROM params   WHERE par = 'REZPAR4';
   --EXCEPTION  WHEN NO_DATA_FOUND      THEN     rezpar4_ := 0;
   --END;

   -- ??? флаг - расчет обесп проср > 30 дней коредитов по спец алгоритму
   --BEGIN
   --   SELECT TO_NUMBER (NVL (val, '0'))   INTO rezpar9_ FROM params  WHERE par = 'REZPAR9';
   --EXCEPTION   WHEN NO_DATA_FOUND    THEN      rezpar9_ := 0;
   --END;
   --???
   --BEGIN
   --   SELECT TO_NUMBER (NVL (val, '0'))   INTO rezpar10_ FROM params  WHERE par = 'REZPAR10';
   --EXCEPTION  WHEN NO_DATA_FOUND     THEN      rezpar10_ := 0;
   --END;
   ---???
   --BEGIN
   --   SELECT TO_NUMBER (NVL (val, '0'))   INTO rezpar11_ FROM params   WHERE par = 'REZPAR11';
   --EXCEPTION  WHEN NO_DATA_FOUND     THEN      rezpar11_ := 0;
   --END;

--   If gl.amfo<>'380764' THEN  -- Для НАДРА таблица чистится в JOBe

      -- Расшифровка обеспечения в разрезе кредитных счетов
      if mode_=1 THEN
         DELETE FROM tmp_rez_obesp23   WHERE dat = dat01_;
      else
         DELETE FROM tmp_rez_ZALOG23   WHERE dat = dat01_;
      end if;
--   end if;

  z23.to_log_rez (user_id , 1 , dat01_ ,'REZ_ZAL');
   insert into rez_zal
        ( ACC     , -- АСС счета залога
          ACCS    , -- ACC счета кредитного
          KV      , -- код валюты
          NLS     , -- счет залога
          NBS     , -- балансовый счет
          PAWN    , -- вид залога
          S031    , -- вид залога НБУ
          PR_12   , -- признак первичности кредита
          PWN     , -- кол-во видов залога по одному основному счету
          OSTC_Z  , -- остаток по счету залога
          ACCS1   , -- счет кредитный, который тоже онтосится к данному счету залога
          kv_s    , -- валюта ссудного счета
          OSTC_S  , -- остаток по кредитному счету
          ND        -- РНК клиента
        )
   SELECT z.acc, z.accs, a.kv, a.nls, a.nbs, sz.pawn, c.s031, z.pr_12,
          count(distinct c.s031) over(partition by z.accs) pwn,
          decode(zal_sp_,1,nvl(sz.sv,ost_korr(a.acc,dat31_,z23.di_,a.nbs)),
          ost_korr(a.acc,dat31_,z23.di_,a.nbs)) ostc_z, z1.accs accs1,o.kv kv_s, nvl(o.lim,0) ostc_s, o.rnk
   FROM   cc_pawn c, pawn_acc sz, cc_accp z, accounts a,cc_accp z1,REZ_ACC o
   WHERE  z.acc = a.acc AND sz.acc = z.acc AND c.pawn(+) = sz.pawn AND (a.dazs IS NULL OR a.dazs > dat31_)
          and  z.acc  = z1.acc  and z1.accs = o.acc(+) and nvl(o.lim,0)  <> 0
          and  decode(zal_sp_,1,nvl(sz.sv,ost_korr(a.acc,dat31_,z23.di_,a.nbs)),
                                          ost_korr(a.acc,dat31_,z23.di_,a.nbs)) <> 0;

   commit;

   IF rez_upz_ = 1 then
      z23.to_log_rez (user_id , 1 , dat01_ ,'Первичный залог');
      rez1.p_perv_zal(dat31_);
   ELSE
      z23.to_log_rez (user_id , 1 , dat01_ ,' update cc_accp set pr_12=0 where pr_12<>1');
      update cc_accp set pr_12=0 where pr_12<>1;
   END IF;
   commit;

   --rez1.p_load_data (dat31_);
   ----------------------------
   z23.to_log_rez (user_id , 1 , dat01_ ,'Start - Залоги');
   for k in (select a.acc, a.kv, a.nls, a.nbs, gl.p_icurval( a.kv,a.lim,DAT31_) ostc, a.tip from REZ_ACC a)
   LOOP
      zal_    := 0;
      vid_zal := null;

      begin
         if f_mmfo THEN
            select nvl(n.acc,c.acc),nvl(n.nd,c.nd) into accs_,nds_
            from  (select n.acc, max(n.nd) nd from nd_acc n,cc_deal d
                   where  acc=k.acc and n.nd=d.nd and d.sdate < dat01_ and vidd<>10 group by acc) n,
                  (select a.acc,c.ref nd from cp_deal c,accounts a
                   where c.active=1 and a.acc in (c.acc,c.accd,c.accp,c.accr,c.accs,c.accr2,c.accs5,c.accs6,c.accexpn,c.accexpr,c.accr3,c.accunrec)) c,
                   accounts a
            where a.acc= k.acc and a.acc=n.acc (+) and a.acc = c.acc(+) and ROWNUM = 1;

         else

            select nvl(n.acc,nvl(o.acc,c.acc)),nvl(n.nd,nvl(o.nd,c.nd)) into accs_,nds_
            from (select acco acc,nd  from acc_over where acco=k.acc union all
                  select acc_9129, nd from acc_over where acc_9129= k.acc union all
                  select k.acc,nd from acc_over where acc in (select acc from int_accn where acra=k.acc and id=0)) o,
                 (select n.acc, max(n.nd) nd from nd_acc n,cc_deal d
                  where  acc=k.acc and n.nd=d.nd and d.sdate < dat01_ and vidd<>10 group by acc) n,
                 (select a.acc,c.ref nd from cp_deal c,accounts a
                  where c.active=1 and a.acc in (c.acc,c.accd,c.accp,c.accr,c.accs,c.accr2,c.accs5,c.accs6,c.accexpn,c.accexpr,c.accr3,c.accunrec)) c,
                  accounts a
            where a.acc= k.acc  and a.acc=o.acc (+)  and a.acc=n.acc (+) and a.acc = c.acc(+) and ROWNUM = 1;
         end if;

      EXCEPTION WHEN NO_DATA_FOUND THEN nds_:=null ;
      end;

      obesp_   := obesp_23(k.acc,dat31_,mode_,zal_,vid_zal,0,0,k.ostc,nds_,k.kv);

   end LOOP;
   z23.to_log_rez (user_id , 1 , dat01_ ,'End - Залоги');

   --заносим данные по обеспечению
   IF allzal_.COUNT () <> 0 THEN
      if mode_=1 THEN
         FORALL i IN allzal_.FIRST .. allzal_.LAST
         INSERT INTO tmp_rez_obesp23 VALUES allzal_(i);

      else
         FORALL i IN allzal_.FIRST .. allzal_.LAST
         INSERT INTO tmp_rez_ZALOG23 VALUES allzal_(i);

         if gl.amfo <> '380764' THEN
            -- погрешность округления
            begin
               for k in (  select x.accz,x.s,x.sq,y.a_s,y.a_sq,y.a_sq-x.sq d
                           from (select accz,sum(sall) s,sum(sallq) sq from tmp_rez_zalog23 where dat=dat01_ group by accz) x,
                                (select distinct p.acc,abs(ost_korr(a.acc,dat31_,z23.di_,a.nbs)) a_s,
                                        p_icurval(kv,abs(ost_korr(a.acc,dat31_,z23.di_,a.nbs)),dat31_) a_sq
                                 from cc_accp p,accounts a where p.acc=a.acc) y
                           where  x.accz=y.acc  and x.sq<>y.a_sq
                        )
               LOOP
                  update tmp_rez_zalog23 set sallq=sallq+k.d where dat=dat01_ and accz=k.accz and sallq<>0 and rownum = 1;
               END LOOP;
            END;
         end if;
      end if;
   END IF;
   z23.to_log_rez (user_id , 1 , dat01_ ,'Занесли');

END zalog_23;
-------------------------------------------------
procedure p_delta ( dat00_ date, dat01_ date) is

kat_   NBU23_REZ.kat%type; k_    nbu23_rez.k%type   ; bv_    nbu23_rez.bv%type   ; bvq_    nbu23_rez.bvq%type   ;
pv_    nbu23_rez.pv%type ; pvq_  nbu23_rez.pvq%type ; pvz_   nbu23_rez.pvz%type  ; pvzq_   nbu23_rez.pvzq%type  ;
rez_   nbu23_rez.rez%type; rezq_ nbu23_rez.rezq%type; rez23_ nbu23_rez.rez23%type; rezq23_ nbu23_rez.rezq23%type;
fin_   nbu23_rez.fin%type;
dat31_ date; dat_    date;

begin
   dat_  := dat00_;
   dat31_:= Dat_last_work ( dat01_   -1);
   delete from rez_nbu23_delta;
   for k in (select * from nbu23_rez where fdat = dat01_)
   LOOP
      begin
         select fin ,kat , k , bv , bvq , pvz , pvzq , rez , rezq , rez23 , rezq23
           into fin_,kat_, k_, bv_, bvq_, pvz_, pvzq_, rez_, rezq_, rez23_, rezq23_
           from nbu23_rez where fdat=dat_ and  acc=k.acc and id=k.id;
      EXCEPTION  WHEN NO_DATA_FOUND THEN
         kat_ := null; k_   := null;
         bv_  := 0   ; bvq_ := 0   ; pvz_ := 0   ; pvzq_ := 0; rez_ := 0; rezq_ := 0; rez23_ := 0; rezq23_ := 0;
      end;
      insert  into rez_nbu23_delta
             (FDAT  , RNK       , NBS    , KV      , ND     , CC_ID   , ACC      , NLS       , BRANCH  , FIN   , BV   , BVQ   , PVZ  , PVZQ  ,
              REZ   , REZQ      , REZ23  , REZQ23  , REZ23_N, REZQ23_N, BV_N     , BVQ_N     , PVZ_N   , PVZQ_N, REZ_N, REZQ_N, NMK  , OB22  ,
              FIN_N , DELTA     , DELTAQ , id      , dd     , ddd     , DELTA_351, DELTAQ_351)
      values (k.FDAT, k.RNK     , k.NBS  , k.KV    , k.ND   , k.CC_ID , k.ACC    , k.NLS     , k.BRANCH, k.FIN , k.BV , k.BVQ , k.PVZ, k.PVZQ,
              k.REZ , k.REZQ    , k.REZ23, k.REZQ23, REZ23_ , REZQ23_ , BV_      , BVQ_      , PVZ_    , PVZQ_ , REZ_ , REZQ_ , k.NMK, k.OB22,
              FIN_  , k.rez-rez_, gl.p_icurval( k.kv, (k.rez-rez_)*100, dat31_)/100,k.id,k.dd,k.ddd,k.rez23-rez23_,
              gl.p_icurval( k.kv, (k.rez23-rez23_)*100, dat31_)/100);
   end loop;
   insert  into rez_nbu23_delta
          (FDAT    , RNK   , NBS    , KV      , ND       , CC_ID     , ACC, NLS , BRANCH, FIN, BV, BVQ, PVZ, PVZQ, REZ, REZQ, BV_N, BVQ_N,
           PVZ_N   , PVZQ_N, REZ_N  , REZQ_N  ,
           REZ23   , REZq23, REZ23_N, REZQ23_N, DELTA_351, DELTAQ_351, NMK, OB22, DELTA , DELTAQ,
           id      , dd    , ddd    )
   select  FDAT    , RNK   , NBS    , KV      , ND       , CC_ID     , ACC, NLS , BRANCH, FIN, 0 , 0  , 0  , 0   , 0  , 0   , BV  , BVQ  ,
           PVZ     , PVZQ  , REZ    , gl.p_icurval( kv , rez*100, dat31_)/100 ,
           0       , 0     , REZ23  , REZQ23  , -REZ23   , -gl.p_icurval( kv, REZ23*100, dat31_)/100, NMK, OB22, -rez  ,
           -gl.p_icurval( kv, rez*100, dat31_)/100,  id||' i', dd    , ddd
   from nbu23_rez n where n.fdat=dat_ and
        not exists (select 1 from nbu23_rez r where r.id=n.id and r.fdat=dat01_);

end p_delta;
----------------------------------------
PROCEDURE INS_NLO( p_dat01   in date ) is
  -- Вставки в NLO
 id23_  NBU23_REZ.ID%type;
begin
  dat01_ := p_dat01;
  dat31_ := Dat_last_work (dat01_ - 1 ) ;  -- последний рабочий день месяца

  z23.DI_SNP;

  If gl.amfo ='380764' THEN  -- НАДРА

     insert into acc_nlo (acc)
     select acc  from accounts a, kl_f3_29 f
      where ost_korr(a.acc,dat31_,z23.di_,a.nbs) < 0 and a.nbs = f.r020 and f.kf='1B'
        and f.r020 not in
            ('2805','2806','1410','1415','1417','1418','3103','3105','3107','3114','3115','3116','3117',
             '3118','1811','1819','2800','2801','2806','2809','3540','3541','3548','3710','3510','3519',
             '3550','3551','3552','3559')
        and not exists (select 1 from nbu23_rez n where a.acc=n.acc and fdat=dat01_);

  elsif gl.amfo ='353575'  THEN   --ДЕМАРК (не резервируют котлы 2627,2625, а вместо них 8025 и 8026)

     insert into acc_nlo (acc)
     select acc  from accounts a, kl_f3_29 f
      where ost_korr(a.acc,dat31_,z23.di_,a.nbs)<0 and a.nbs=f.r020 and f.kf='1B'
        and f.r020 not in
            ('2627','2625','2805','2806','1410','1415','1417','1418','3103','3105','3107','3114','3115',
             '3116','3117','3118') and not exists (select 1 from nbu23_rez n where a.acc=n.acc and fdat=dat01_);
  elsif gl.amfo ='300205' THEN    -- УПБ
     insert into acc_nlo (acc)
     select acc  from accounts a, kl_f3_29 f
      where ost_korr(a.acc,dat31_,z23.di_,a.nbs)<0 and a.nbs=f.r020 and f.kf='1B'
        and f.r020 not in
            ('9023','2805','2806','1410','1415','1417','1418','3103','3105','3107','3114','3115','3116',
             '3117','3118','3510','3519','3550','3551','3552','3559')
        and not exists (select 1 from nbu23_rez n where a.acc=n.acc and fdat=dat01_);
  else
     insert into acc_nlo (acc)
     select acc  from accounts a, kl_f3_29 f
      where ost_korr(a.acc,dat31_,z23.di_,a.nbs)<0 and a.nbs=f.r020 and f.kf='1B'
        and f.r020 not in
            ('2805','2806','1410','1412','1413','1414','1415','1417','1418','1419','1420','1427','1428','3103',
             '3102','3105','3107','3110','3111','3113','3114','3115','3116','3117','3118','3119','3214')
        and a.acc not in ( select accc from accounts
                           where nbs is null and substr(nls,1,4)='3541' and accc is not null)
        and not exists (select 1 from nbu23_rez n where a.acc=n.acc and fdat=dat01_);
  end if;

  INSERT INTO NBU23_REZ ( ob22, tip, acc, FDAT  , ID       , branch, nls, nmk, RNK,NBS            ,KV,ND,
                          FIN , OBS, KAT, K     , BV       , BVQ   , PV , REZ,
                          REZQ,PVQ,sdate )
                   SELECT ob22, tip, nd , DAT01_, 'NLO'||ND, branch, nls, nmk, rnk,substr(nls,1,4),kv,0 ,
                          fin , obs, kat, k     , BV       , BVQ   , PV , REZ,
                          gl.p_icurval( kv, rez*100, dat31_)/100, gl.p_icurval( kv, pv *100, dat31_)/100,sdate
                   from  V_rez_NLO;

  commit;

  id23_:='NLO';
  z23.kontrol1  (p_dat01 =>DAT01_ , p_id =>id23_||'%' );
  commit;

end INS_NLO;
-------------------
PROCEDURE start_rez
( p_dat01 date,
  p_mode  int -- =0 все дела, =1 только допривязка счетов
) is

  -- подготовительные работы для расчета резервов
  ------------------------------------------------

  -- переменные
  aa        accounts%rowtype;
  kol_max   int    ;  dat31_    date  ; l_d1    date  ;  s_dat01  varchar2(10);
  nd_       number ;  accs_    number ; l_time  number;

begin

  dat01_  := p_dat01;
  dat31_  := Dat_last_work (dat01_ - 1 );

  s_dat01 := to_char(p_dat01, 'dd.mm.yyyy')  ;
  pul_dat(s_dat01, null ) ;

  If nvl(p_mode ,0) = 0 then
     update rez_log set fdat = dat01_+1 where fdat = dat01_;
     delete from nd_val     where fdat = p_dat01;
     delete from errors_351 where fdat = p_dat01;
     delete from nd_kol;
     p_nd_open  (p_dat01);
     -- Портфель БПК
     z23.to_log_rez (user_id , 351 , p_dat01 ,' реанимация BPK, если были реанимированы счета');
     -- реанимация BPK, если были реанимированы счета
     for k in ( select b.rowid RI, b.* from bpk_acc b where b.dat_end is not null)
     LOOP
        begin
           select a.acc into nd_
           from  accounts a
           where acc  in (k.acc_2207, k.acc_2208, k.acc_2209, k.ACC_OVR, k.ACC_TOVR, k.ACC_PK, k.ACC_9129,k.acc_3570,k.acc_3579)
             and (a.dazs is null or a.dazs>=dat01_) and ost_korr(a.acc,dat31_,null,a.nbs)<0 and a.nbs not in ('3551','3550') and rownum=1;
           update bpk_acc set dat_end = null where rowid = k.RI;
        EXCEPTION WHEN NO_DATA_FOUND THEN NULL;
        end;
     end loop;
     z23.to_log_rez (user_id , 351 , p_dat01 ,' реанимация W4, если были реанимированы счета');
     for k in (  select b.rowid RI, b.* from w4_acc b where b.NOT_USE_REZ23 is not null)
     LOOP
        begin
           select a.acc into acc_
           from  accounts a
           where acc  in (k.acc_2203, k.acc_2207, k.acc_2209, k.acc_2627, k.acc_2208, k.acc_2625X, k.acc_2627X, k.acc_2625D, k.acc_3570, k.acc_3579,
                          k.ACC_OVR , k.ACC_PK  , k.ACC_9129) and (a.dazs is null or a.dazs>=dat01_) and ost_korr(a.acc,dat31_,null,a.nbs)<0
                 and a.nbs not in ('3551','3550') and rownum=1;
           update w4_acc set NOT_USE_REZ23 = null where rowid = k.RI;
        EXCEPTION WHEN NO_DATA_FOUND THEN NULL;
        end;
     end loop;
     z23.to_log_rez (user_id , 351 , p_dat01 ,' отметка закрытых БПК');
     -- отметка закрытых БПК
     begin
        for k in (select b.rowid RI,b.*,a.dazs from bpk_acc b,accounts a
                  where  b.acc_pk =a.acc and dazs is not null and dazs<=dat01_
                         and b.dat_end is null
                  )
        LOOP
           begin
              select a.acc into nd_
              from  accounts a
              where acc  in (k.acc_2207, k.acc_2208, k.acc_2209, k.ACC_OVR, k.ACC_TOVR, k.ACC_PK, k.ACC_9129,k.acc_3570,k.acc_3579)
                    and  (a.dazs is null or a.dazs>=dat01_) and ost_korr(a.acc,dat31_,null,a.nbs) < 0 and
                    a.nbs not in ('3551','3550') and rownum=1;
           EXCEPTION WHEN NO_DATA_FOUND THEN
              update bpk_acc set dat_end = k.dazs where rowid = k.RI;
           end;
        end loop;
        z23.to_log_rez (user_id , 351 , p_dat01 ,' отметка закрытых W4');
        for k in (select b.rowid RI, b.*, a.dazs from w4_acc b,accounts a
                  where  b.acc_pk = a.acc and dazs is not null and dazs<=dat01_
                         and b.NOT_USE_REZ23 is null
                  )
        LOOP
           begin
              select a.acc into nd_
              from  accounts a
              where acc  in (k.acc_2203, k.acc_2207, k.acc_2209, k.acc_2627, k.acc_2208, k.acc_2625X, k.acc_2627X, k.acc_2625D, k.acc_3570, k.acc_3579,
                             k.ACC_OVR , k.ACC_PK  , k.ACC_9129)  and (a.dazs is null or a.dazs>=dat01_)
                and ost_korr(a.acc,dat31_,null,a.nbs) < 0 and a.nbs not in ('3551','3550') and rownum=1;
           EXCEPTION WHEN NO_DATA_FOUND THEN
              update W4_acc set NOT_USE_REZ23 = k.dazs where rowid = k.RI;
           end;
        end loop;
     end;
     z23.to_log_rez (user_id , 351 , p_dat01 ,'   p_bpk(p_dat01)');
     p_bpk(p_dat01);
     -- Убрала  truncate Долинченко требует архива графиков!!!
     -- Вернулась к cck_arc_cc_lim !!! LUDA
     -- EXECUTE IMMEDIATE 'truncate table CC_LIM_ARC ';
     -- производим вставку ГПК которых нет в архиве на отчетную дату
     --     insert into cc_lim_arc (ND,MDAT,   FDAT, LIM2, ACC,SUMG,SUMO,SUMK)
     --                     select  ND,dat01_, FDAT, LIM2, ACC,SUMG,SUMO,SUMK from cc_lim ;

     z23.to_log_rez (user_id , 351 , p_dat01 ,' cck_arc_cc_lim');
     cck_arc_cc_lim (P_DAT =>gl.bd,P_ND =>0 );
     -- архив по хоз.дебиторке
     z23.to_log_rez (user_id , 351 , p_dat01 ,' xoz_ref_arc');
     insert into xoz_ref_arc (REF1, STMT1, REF2, ACC, MDATE, S, FDAT, S0, NOTP, PRG, BU, DATZ, REFD, ID, KF, mdat)
     select t.REF1, t.STMT1, t.REF2, t.ACC, t.MDATE, t.S, t.FDAT, t.S0, t.NOTP, t.PRG, t.BU, t.DATZ, t.REFD, t.ID, t.KF, p_dat01
     from xoz_ref t
     where not exists (select 1 from xoz_ref_arc cl where cl.mdat= p_dat01 and rownum=1);
     commit;
     z23.to_log_rez (user_id , 351 , p_dat01 ,' fin_deb_arc');
     insert into fin_deb_arc ( ACC_SS, ACC_SP, EFFECTDATE, AGRM_ID, MDAT, kf)
     select f.ACC_SS, f.ACC_SP, f.EFFECTDATE, f.AGRM_ID, p_dat01, f.kf
     from prvn_fin_deb f
     where not exists (select 1 from fin_deb_arc cl where cl.mdat= p_dat01 and rownum=1);
     commit;
     /*
     -- формування 
     begin
        delete from rez_par_9200 where fdat = p_dat01; 
        l_d1 := sysdate; 
        z23.to_log_rez (user_id , 351 , p_dat01 ,'Начало rez_par_9200');
        for k in ( select p_dat01 fdat,c.custtype,substr(c.nmk,1,35) nmk, 'NEW/' || acc id, - ost_korr(a.acc,dat31_,null,a.nbs) bv, 1 fin, 1 kat, 
                          c.OKPO, DECODE (NVL (c.codcagent, 1), '2', 2, '4', 2, '6', 2, 1) RZ, case when d.tipa in (12, 93) then 1 else 0 end PD_0,
                          d.tipa, a.*, d.tipa_FV  
                   from accounts a, customer c, rez_deb d 
                   where d.tipa in (30, 92, 93) and ost_korr(a.acc,dat31_,null,a.nbs) < 0 and a.rnk = c.rnk and a.nbs = d.nbs and (a.dazs is null or  a.dazs>= p_dat01)
                 )
        LOOP
           insert into rez_par_9200 (RNK, ND, FDAT) values (k.rnk,k.acc,P_dat01);
        end LOOP;                                                                                             
        l_time := round((sysdate - l_d1) * 24 * 60 , 2 ); 
        z23.to_log_rez (user_id , 351 , p_dat01 ,'Конец rez_par_9200 - ' || l_time || ' мин.');
    end;
    */
  end if;
--------------------------------------

  If nvl(p_mode ,0) in ( 0,1) then

     begin
        for k in (select to_number(nvl(cck_app.Get_ND_TXT (nd, 'ZAL_LIZ'),'0')) pawn,n.nd ,  a.acc from nd_acc n, accounts a
                  where a.nbs like '207%' and ost_korr(a.acc,dat31_,null,a.nbs)<>0 and a.acc = n.acc
                 )
        LOOP
           if k.pawn <>0 THEN
              begin
                 insert into cc_accp (ACC,  ACCS, ND, PR_12, IDZ) values ( k.acc, k.acc, k.nd, 0, k.nd);
              exception when others then
                 --ORA-00001: unique constraint (BARS.PK_NBU23REZ_ID) violated
                 if SQLCODE = -00001 then NULL;
                 else raise;
                 end if;
              end;
              begin
                 insert into pawn_acc  (acc, pawn,mpawn ) values (k.acc, k.pawn, 1);
              exception when others then
                 --ORA-00001: unique constraint (BARS.PK_NBU23REZ_ID) violated
                 if SQLCODE = -00001 then NULL;
                 else raise;
                 end if;
              end;
           end if;
        end LOOP;
     end;
     -- заполнение номера кредитного договора
     -- (25-04-2016 добавлен 9129 в рамках заявок COBUPRVN-271,COBUSUPABS-4459)
    z23.to_log_rez (user_id , 351 , p_dat01 ,' заполнение номера кредитного договора в залогах ');
     begin
        for k in (
                  select p.acc,p.accs,n.nd from accounts a, kl_f3_29 f,cc_accp p,nd_acc n
                  where (a.dazs is null or a.dazs>=p_dat01) and a.nbs = f.r020 and f.kf='1B'
                         and (nbs>'2' and nbs <'3' or nbs='9129') and a.acc=p.accs and p.nd is null
                         and a.acc=n.acc
                 )
        loop
           update cc_accp set nd=k.nd where acc=k.acc and accs=k.accs and nd is null;
           -- and nd is null (два счета были привязаны к двум разным договорам (это не правильно)!!! Номер договора проставился
           --                 из ND_ACC и по чужому договору. При отвязке счета 2063 от не правильного договора залоги не
           --                 отвязались, т.к. номер договора потерялся)
        end loop;
        commit;
     end;
       z23.to_log_rez (user_id , 351 , p_dat01 ,' допривязка счетов нач процентов+9129 к залогам по КП ');
     -- допривязка счетов нач процентов+9129 к залогам по КП
     for K1 in (select n.*, ost_korr(a.acc,dat31_,null,a.nbs) ostc from accounts a, nd_acc n 
                where a.acc = n.acc 
                 and a.tip not in ('SS ','DEP','DIU','SDI','SNA') 
                 and (a.nls <'3' or a.nbs='9129') and (a.dazs is null or a.dazs >=p_dat01) 
                 and not exists (select 1 from cc_accp where accs = a.acc)
              )
     loop
        if k1.ostc < 0 THEN
           begin
              select p.accs into aa.acc from cc_accp p, nd_acc n where n.nd = K1.nd and n.nd=p.nd and n.acc = p.accs and rownum=1;
              begin
                 insert into CC_ACCP (ACC,ACCS,ND,PR_12,IDZ) select acc,K1.acc,ND,PR_12,IDZ from cc_accp where accs= aa.acc;
              exception when others then
                 --ORA-00001: unique constraint (BARS.XPK_CC_ACCP) violated
                 if SQLCODE = -00001 then null;   else raise; end if;
              end;
           EXCEPTION WHEN NO_DATA_FOUND THEN  null;
           end;
        end if;
     end loop; -- K1

     commit;
     z23.to_log_rez (user_id , 351 , p_dat01 ,' не довязаны залоги!!! (один есть - второго нет или два есть а третьего нет) ');
     -- не довязаны залоги!!! (один есть - второго нет или два есть а третьего нет)
     nd_  := -1;
     for K2 in (select nd, accs, count(*) kol
                from cc_accp
                where nd is not null
                group by nd, accs
                order by 1, 3 desc)
     loop
        if nd_ <> K2.nd then
           nd_ := K2.nd;  kol_max := K2.kol ; accs_ := K2.accs;
        else
           If K2.kol < kol_max then
              for p in (select * from cc_accp where accs = ACCS_ and nd = ND_)
              loop
                 Z23.ins_accp ( p_ACC => p.ACC, p_ACCS => K2.ACCS, p_ND => p.ND, p_PR_12 => p.pr_12, p_IDZ => p.idz);
              end loop; -- P
           end if;
        end if;
     end loop; -- K2
      z23.to_log_rez (user_id , 351 , p_dat01 ,' Допривязка обеспечения ко всем сч ОВР ');
     --Допривязка обеспечения ко всем сч ОВР

     if f_MMFO  THEN

        for KO in ( SELECT distinct z.acc, c.nd, z.idz, z.pr_12 from cc_deal c,  nd_acc n, nd_open o, cc_accp z
                    where c.vidd in (110) and o.fdat=p_dat01 and c.nd=o.nd and c.nd=n.nd and n.acc = z.accs  )
        LOOP
           for O in ( select a.acc acco from  nd_acc n, accounts a where n.nd=ko.nd  and n.acc=a.acc and ost_korr(a.acc,dat31_,null,a.nbs) <0 )
           LOOP
              Z23.ins_accp ( p_ACC => KO.ACC, p_ACCS => O.acco, p_ND => KO.ND, p_PR_12 => KO.pr_12, p_IDZ => KO.idz);
           end loop; -- O
        end loop; -- KO
     else
        for KO in (select o.acc_9129, o.nd, o.acco, z.ACCS, z.ACC, z.PR_12, z.IDZ, i.acra
                   from acc_over o, cc_accp z,  (select * from int_accn where id =0 and acra is not null ) i
                   where o.acc= z.accs and o.acco = i.acc (+)
                  )
        loop
           FOR O in (select KO.acco from dual where KO.acco <> KO.accs    -- просрочка
                     union all
                     select KO.acra from dual where KO.acra is not null   -- нач %
                     union all
                     select a.acc  from accounts a, nd_acc n where a.acc=n.acc and a.nbs='2069' and n.nd = KO.nd  --леваки 2069 из мешка
                    )
           LOOP
              Z23.ins_accp ( p_ACC => KO.ACC, p_ACCS => O.acco, p_ND => KO.ND, p_PR_12 => KO.pr_12, p_IDZ => KO.idz);
           end loop; -- O
        end loop; -- KO
     end if;
     ------------------
     z23.to_log_rez (user_id , 351 , p_dat01 ,'Допривязка обеспечения ко всем сч. W4-карточки ');
     --Допривязка обеспечения ко всем сч. W4-карточки
     for KO in ( select distinct b.nd, z.acc, z.pr_12, z.idz from rez_w4_bpk b, cc_accp z  where b.acc = z.accs )
     loop
        FOR O in ( select *  from rez_w4_bpk b where nd = KO.nd )
        LOOP
           Z23.ins_accp ( p_ACC => KO.ACC, p_ACCS => O.acc, p_ND => KO.ND, p_PR_12 => KO.pr_12, p_IDZ => KO.idz);
        end loop; -- O
     end loop; -- KO
     z23.to_log_rez (user_id , 351 , p_dat01 ,'Допривязка обеспечения по ЦБ ');
     --Допривязка обеспечения по ЦП
/*
     for KO in ( select distinct b.ref, z.acc, z.pr_12, z.idz from cp_deal b, cc_accp z  
                 where  z.accs in (b.acc,b.accs,b.accr,accexpn , accexpr, accp, accr2 , accr3) 
                )
     loop
        FOR O in ( select acc  acc    from cp_deal b where ref = KO.ref and acc     is not null union all
                   select accs        from cp_deal b where ref = KO.ref and accs    is not null union all
                   select accr        from cp_deal b where ref = KO.ref and accr    is not null union all
                   select accexpn     from cp_deal b where ref = KO.ref and accexpn is not null union all
                   select accexpr     from cp_deal b where ref = KO.ref and accexpr is not null union all
                   select accp        from cp_deal b where ref = KO.ref and accp    is not null union all
                   select accr2       from cp_deal b where ref = KO.ref and accr2   is not null union all
                   select accr3       from cp_deal b where ref = KO.ref and accr3   is not null
                  )
        LOOP
           Z23.ins_accp ( p_ACC => KO.ACC, p_ACCS => O.acc, p_ND => KO.ref, p_PR_12 => KO.pr_12, p_IDZ => KO.idz);
        end loop; -- O
     end loop; -- KO
 */
  end if;
  z23.to_log_rez (user_id , 351 , p_dat01 ,'  delete from acc_nlo;  ');
  If nvl(p_mode ,0) = 0 then
     delete from acc_nlo;
     commit;
  end if;

end start_rez;

--------------------------------------------------
PROCEDURE pvz_pawn (p_dat01     date,
                    p_kv        TMP_REZ_OBESP23.kv%type,
                    p_acc       TMP_REZ_OBESP23.accs%type,
                    Z_koef      number,
                    p_pvz       TMP_REZ_OBESP23.pvz%type ,
                    p_pvzq      TMP_REZ_OBESP23.pvzq%type )  is
  --поделить PVZ 1-го счета по видам обеспечения
begin

  --Z_koef - отношение PVZ(приведенный залог) / ZAL(ликвидный залог) в целом по КД
  --Разбивка PVZ + PVZq по видам обеспечения
  if p_kv = 980 then
     update TMP_REZ_OBESP23 set pvz  = round(s*Z_koef,0),
                                pvzq = round(s*Z_koef,0),
                                kv   = nvl(kv, p_kv)
                          where dat  = p_dat01 and accs=p_acc;
  else
     update TMP_REZ_OBESP23 set pvz  = round(s*Z_koef,0),
                                pvzq = gl.p_icurval(p_kv, round(s*Z_koef,0), (p_dat01-1) ),
                                kv   = nvl(kv, p_kv)
                          where dat  = p_dat01 and accs=p_acc;
  end if;
end pvz_pawn;
------------------------------------------------------
PROCEDURE kontrol1  (p_dat01 date, p_id varchar2) is

  -- Страховочное полное перезаполение реквизитов

  TYPE     D354 IS RECORD (ddd char(3) );
  TYPE     M354 IS TABLE  OF D354 INDEX BY varchar2(1);
  t35      M354;
  r012_    varchar2(1);
  nbu      NBU23_REZ%rowtype;
  ob_      int;
  DEL_     number;
  PVZT_    number;
  ---------------
begin
   dat01_ := p_dat01;
   -----------
   tmp.DELETE;
   for k in (select r020, ddd, r012 from kl_f3_29 where kf='1B')
   loop
      If k.r020  = '3548' then t35(k.r012).ddd := k.DDD ;  else        tmp(k.r020).ddd := k.ddd ;      end if;
   end loop;
   -------------------
   dat31_ := Dat_last_work (dat01_ - 1 ) ;  -- последний рабочий день месяца
   If ( getglobaloption('MFOP') = '300465' or gl.aMfo = '300465' )  then   OB_ := 1; end if;
   -----------------------------------------------------------------------------------------

   for k in (select n.*, rowid RI from NBU23_REZ n where fdat= dat01_ and id like p_id || '%')
   loop

      --1) Страховочное полное перезаполение реквизитов       rez , rezq,  BVQ , PVQ , ddd , dd ;
      nbu.diskont:=0;

      nbu.zal_BL  := 0;
      nbu.zal_BLq := 0;
      nbu.zal_SV  := 0;
      nbu.zal_SVq := 0;


      nbu.S_L     := 0;
      nbu.Sq_L    := 0;
      nbu.PV_ZAL  := 0;
      nbu.sum_imp := 0;
      nbu.sumq_imp:= 0;

      --1-2) Страховочное заполение потерянных реквизитов   ISTVAL, r013 по АСС
      nbu.istval := k.istval ;
      nbu.r013   := k.r013   ;
      nbu.s250   := k.S250   ;

      If k.acc is not null then
         if k.r013 is null THEN
            begin
               select r013  into nbu.r013  from specparam  where acc = k.acc ;
            EXCEPTION WHEN NO_DATA_FOUND THEN    null ;
            end;
         end if;
         if k.istval is null THEN
            begin
               select NVL(istval,'0') into nbu.istval from specparam  where acc = k.acc ;
            EXCEPTION WHEN NO_DATA_FOUND THEN    null ;
            end;
         end if;

      end if;

      If k.BV <= 0 then
         --дисконт
         nbu.BV  := k.BV;
         nbu.PV  := k.BV;
         nbu.PVZ := 0;
         nbu.rez := 0;
         nbu.zal := 0;
         if k.kv=980 THEN
            nbu.s250 := '7';
         else
            if nbu.istval='1' tHEN
               nbu.s250 := '6';
            else
               nbu.s250 := '7';
            end if;
         end if;
         goto UPD;
      end if  ;

      nbu.BV  := round (             nvl(k.BV ,0)  ,2) ;
      nbu.PV  := round ( greatest(0, nvl(k.PV ,0) ),2) ;
      nbu.pvz := round ( greatest(0, nvl(k.pvz,0) ),2) ;
      nbu.Rez := round ( greatest(0, nvl(k.rez,0) ),2) ;
      nbu.zal := round ( greatest(0, nvl(k.zal,0) ),2) ;

      if k.nbs = '1500' THEN
         nbu.s250:='0'; -- по настоянию ПЕТРОКОММЕРЦ ???
      elsif substr(k.id,1,3)='MBD' or k.nbs in ('1502','1509','1510')  THEN
         nbu.s250:='9'; -- Заборгованість за кредитними операціями на міжбанківському ринку
      elsif k.nbs in ('2625','2627') and gl.amfo = '300120' THEN
         nbu.s250:='8'; -- портфельный метод для ПЕТРОКОММЕРЦ (2401)
      ELSIF k.nbs||nbu.r013 in ('91299','90231') and substr(k.id,1,2)<>'RU' THEN
         nbu.s250:='C'; -- Заборгованість за операціями, за якими немає ризику
      ELSif substr(k.nbs,1,2)='90' and substr(k.id,1,2)<>'RU' THEN
         nbu.s250:='A'; -- Заборгованість за наданими фінансовими зобов`язаннями, щодо наданих гарантій
      ELSif substr(k.nbs,1,2)='91' and substr(k.id,1,2)<>'RU' THEN
         nbu.s250:='B'; -- Заборгованість за наданими фінансовими зобов`язаннями з кредитування
      ELSif nbu.istval='1' and substr(k.id,1,2)<>'RU' and
            k.kv<>980 and (k.s250<>'8' or k.s250 is null)  THEN
         nbu.s250:='6';  -- Заборгованість за кредитними операціями з позичальниками, у яких є джерела надходження валютної виручки
      ELSif nbu.istval<>'1' and substr(k.id,1,2)<>'RU' and
            (k.s250<>'8' or k.s250 is null)  THEN
         nbu.s250:='7';  -- Заборгованість за кредитними операціями з позичальниками, у яких немає джерела надходження валютної виручки
      ELSif substr(k.id,1,2)<>'RU' and (k.s250<>'8' or k.s250 is null) THEN
         nbu.s250:='7';
      end if;


      if nbu.r013 ='9' and k.nbs = '9129' then
         nbu.PV  := k.BV ;
         nbu.pvz := 0 ;
         nbu.Rez := 0 ;
         nbu.zal := 0;
      end if;

      -- НЕ делаем утюжок
      If K.id like 'CACP%' then
         goto UPD;
      end if;
      ------------------------------------------

      -- Рихтовка (УТЮГ)
      DEL_ := nbu.bv - nbu.pv - nbu.pvz - nbu.rez ;
      -- 0) Разницы нет - ничего не делаем
      If DEL_ = 0   then
         goto UPD;
      end if ;

      -- 1) Разница больше 0 , куда-то надо ее добавить
      If DEL_ > 0   then

         If nbu.REZ > 0 then

            If gl.amfo ='380764'  THEN
               --В НАДРАХ нет дисконта. и надо быстрее
               nbu.REZ  := nbu.REZ + DEL_ ;  -- увеличим сумму резерву, если он больше 0
            else
               begin
                  select del_  into nbu.diskont  from nbu23_rez r where fdat = k.fdat
                  and exists (select 1 from nbu23_rez where fdat = k.fdat and nd = k.nd and bv<0) and rownum=1;
               EXCEPTION WHEN NO_DATA_FOUND THEN
                  nbu.REZ  := nbu.REZ + DEL_ ;  -- увеличим сумму резерву, если он больше 0
               end;
            end if;

         else
            if nbu.pvz > 0 THEN -- Увеличивало PV там где оно было 0. 17-07-2014
               If gl.amfo = '380764'  THEN --В НАДРАХ нет дисконта. и надо быстрее
                  nbu.PVz  := nbu.PVz  + DEL_ ;  -- если есть залог увеличим сумму залога
               else
                  begin
                     select del_  into nbu.diskont  from nbu23_rez r where fdat = k.fdat
                     and exists (select 1 from nbu23_rez where fdat = k.fdat and nd = k.nd and bv<0) and rownum=1;
                  EXCEPTION WHEN NO_DATA_FOUND THEN
                     nbu.PVz  := nbu.PVz  + DEL_ ;  -- если есть залог увеличим сумму залога
                  end;
               end if;
            else
               nbu.PV  := nbu.PV  + DEL_ ;    -- или увеличим сумму PV
            end if;
      end if;         goto UPD;
      end if;

      -- 2) Разница меньше 0, откуда-то надо ее отнять, но не делая отрицательных значений
      -----2.1.уменьшим сумму рез, но не менее НУЛЯ
      If nbu.REZ > 0 then
         nbu.REZ := greatest (0, nbu.REZ+DEL_ ) ;
         DEL_ := nbu.bv - nbu.pv - nbu.pvz - nbu.rez ;
         If DEL_ = 0   then
            goto UPD;
         end if ;
      end if;

      -----2.2. уменьшим PVz, но не менее НУЛЯ
      If nbu.PVz >0  then
         nbu.PVz  := greatest (0, nbu.PVz + DEL_ )   ;--  уменьшим сумму PVz , но не менее НУЛЯ
         DEL_ := nbu.bv - nbu.pv - nbu.pvz - nbu.rez ;
         If DEL_ = 0   then
            goto UPD;
         end if ;
      end if;

      -----2.3.уменьшим  PV, но не менее НУЛЯ
      If nbu.PV > 0  then
         nbu.PV := greatest (0, nbu.PV + DEL_ )  ;  -- уменьшим сумму PV , но не менее НУЛЯ
      end if;

      --- Эквиваленты;
      <<UPD>> null;
      --------------
      If k.kv = 980 then nbu.BVQ  := nbu.BV  ;
                         nbu.PVQ  := nbu.PV  ;
                         nbu.PVZQ := nbu.PVZ ;
                         nbu.rezq := nbu.rez ;
                         nbu.zalq := nbu.zal ;

      else               nbu.BVQ  := gl.p_icurval(k.kv, nbu.BV *100, dat31_) /100;
                         nbu.PVQ  := gl.p_icurval(k.kv, nbu.PV *100, dat31_) /100;
                         nbu.PVZQ := gl.p_icurval(k.kv, nbu.PVZ*100, dat31_) /100;
                         nbu.rezq := gl.p_icurval(k.kv, nbu.rez*100, dat31_) /100;
                         nbu.zalQ := gl.p_icurval(k.kv, nbu.zal*100, dat31_) /100;
      end if;


      nbu.ddd := null;   nbu.dd := null;
      If k.nbs = '3548' then
          begin
            select r011 into   r012_ from specparam where acc = k.acc ;
            if t35.EXISTS(r012_) then  nbu.ddd := t35(r012_).ddd  ; end if;
          EXCEPTION WHEN NO_DATA_FOUND THEN  null;
          end;
       else
          if tmp.EXISTS(k.nbs) then  nbu.ddd := tmp(k.nbs).ddd  ;   end if;
       end if;

      If (k.nbs like '9%' and k.nbs not in ('9100','9001') or k.nbs='2607')
          and k.dd is null then
         -- По 9100 Батюк Лариса (ГОУ СБЕРБАНК) 14-05-2013 просила ничего не проставлять в DD
         -- Добавлено decode(trim(sed),'91',2,3) для СПД(ФОП) в рамках (351) Петращук
         begin
            select decode(custtype,1,2,2,2,decode(trim(sed),'91',2,3)) into nbu.dd from customer where rnk = k.rnk;
         EXCEPTION WHEN NO_DATA_FOUND THEN  null;
         end;
      else nbu.dd := k.dd ;
      end if;
----
      --2) Страховочное заполение потерянных реквизитов   OKPO, NMK, CUSTTYPE, RZ, ob22 + tip
      nbu.okpo     := k.okpo;
      nbu.nmk      := k.nmk;
      nbu.custtype := k.custtype;
      nbu.rz       := k.RZ;
      nbu.ob22     := nvl(k.ob22,'01');
      nbu.tip      := k.tip;

      If k.nmk is null and k.rnk is not null  then
         begin
            select c.okpo, substr( decode(c.custtype,3, c.nmk, nvl(c.nmkk,c.nmk) ) , 1,35),
                   DECODE (TRIM (c.sed),'91', DECODE (c.custtype, 3, 2, c.custtype), c.custtype) ,
                   DECODE (NVL (c.codcagent, 1), '2', 2, '4', 2, '6', 2, 1)
            into nbu.okpo, nbu.nmk, nbu.custtype, nbu.rz
            from customer c where c.rnk= k.rnk  ;
         EXCEPTION WHEN NO_DATA_FOUND THEN null ;
         end;
      end if;

      If k.acc > 0 and (k.ob22 is null or k.tip is null) then
         begin
            select nvl(ob22,'01'), nvl(k.tip,tip), isp  into nbu.ob22, nbu.tip,nbu.isp  from accounts where acc= k.acc ;
         EXCEPTION WHEN NO_DATA_FOUND THEN null ;
         end;
      end if;

      nbu.idr  := nvl(rez1.id_nbs(k.nbs),0);
      nbu.spec := rez.id_specrez(k.sdate, nbu.istval, k.kv, nbu.idr, nbu.custtype);

--      if k.zal<>0 THEN -- есть залог
         begin
            select nvl(sum(s_l),0)/100,nvl(sum(sq_l),0)/100,nvl(sum(PV),0)/100,
                   nvl(sum(sum_imp),0)/100,nvl(sum(sumq_imp),0)/100,
                   nvl(sum(sALL),0)/100, nvl(sum(sALLQ),0)/100
            into   nbu.S_L,nbu.SQ_l,nbu.pv_zal,nbu.sum_imp,nbu.sumq_imp,
                   nbu.zal_SV,nbu.zal_SVQ
            from   tmp_rez_obesp23 where dat=dat01_ and accs=k.acc;
         end;

         begin
            select nvl(sum(sall),0)/100,nvl(sum(sallq),0)/100 into nbu.zal_BL,nbu.zal_BLq
            from   tmp_rez_zalog23 where dat=dat01_ and accs=k.acc;
         end;
--      end if;

      update NBU23_REZ set
             diskont = nbu.diskont , spec    = nbu.spec    , BVQ     = nbu.BVQ     , idr     = nbu.idr     ,
             PV      = nbu.pv      , PVQ     = nbu.PVQ     , PVZ     = nbu.pvz     , PVZQ    = nbu.PVZQ    ,
             REZ     = nbu.rez     , REZQ    = nbu.REZQ    , REZ23   = nbu.rez     , REZQ23  = nbu.REZQ    ,
             ZAL     = nbu.ZAL     , ZALQ    = nbu.ZALQ    , ddd     = nbu.ddd     , dd      = nbu.dd      ,
             okpo    = nbu.okpo    , nmk     = nbu.nmk     , custtype= nbu.custtype, rz      = nbu.rz      ,
             ISTVAL  = nbu.istval  , s250    = nbu.s250    , s250_23 = nbu.s250    , OB22    = nbu.ob22    ,
             tip     = nbu.tip     , isp     = nbu.isp     , r013    = nbu.r013    , ZAL_BL  = nbu.ZAL_BL  ,
             ZAL_BLQ = nbu.ZAL_BLQ , ZAL_SV  = nbu.ZAL_SV  , ZAL_SVQ = nbu.ZAL_SVQ , S_L     = nbu.S_L     ,
             SQ_L    = nbu.SQ_L    , SUM_IMP = nbu.SUM_IMP , SUMQ_IMP= nbu.SUMQ_IMP, PV_ZAL  = nbu.PV_ZAL  ,
             KAT23   = k.KAT
      where rowid   = k.RI;

      if nbu.pvz>0 then
         -- 2) расшифровка обеспечения  PVZ по видам обеспечения
         select sum (nvl(pvz,0)) into pvzt_ from TMP_REZ_OBESP23 where s>0 and dat= dat01_ and accs= K.acc;

         If pvzt_  is null then
            insert into TMP_REZ_OBESP23 (DAT, USERID, ACCS, ACCZ, PAWN, PROC, ND,  KV, GRP, S, SQ, PVZ,pvzq)
            select DAT,USERID,k.ACC,ACCZ,PAWN,PROC,nd,k.kv,grp,nbu.ZAL*100,nbu.ZALq*100,nbu.pvz*100,nbu.pvzq*100
            from TMP_REZ_OBESP23 where dat = dat01_ and nd = k.nd and s > 0 and rownum=1;
         else
            DEL_ :=  nbu.pvz*100 - pvzt_;
            if DEL_ < 0 then
               update TMP_REZ_OBESP23 set pvz = pvz+DEL_, pvzq = gl.p_icurval (k.kv, pvz+DEL_, dat31_)
                      where dat = DAT01_ and accs = k.acc and pvz + DEL_ >= 0 and s>0 and rownum = 1;
            elsif DEL_ > 0 then
               update TMP_REZ_OBESP23 set pvz  = nvl(pvz,0)+DEL_,
                                          pvzq = gl.p_icurval (k.kv, nvl(pvz,0)+DEL_, dat31_)
               where  dat = DAT01_ and accs = k.acc and s>0 and rownum = 1;
            end if;
         end if;
      end if;

   end loop;

end kontrol1;
-----------------

PROCEDURE CHEK_modi (p_dat01 in  date) is
   -- проверяет возможность модификации протокола.
   fl_       int;           FV_       int;
   sess_     varchar2(64) :=bars_login.get_session_clientid;
   sid_      varchar2(64) ;
   l_res_kf  varchar2(13);
begin
   IF p_DAT01 IS NULL THEN
      raise_application_error(-20000,'Укажiть звiтну дату !');
   END IF;

   dat31_ := Dat_last_work ( p_dat01 - 1 ) ;
   begin
     select 1 into fl_ from rez_protocol where dat= dat31_ and crc='1' and rownum=1;
     raise_application_error(-20000,'Модифiкацiя NBU23_REZ - неможлива!
                             Виконанi проводки по резерву за '|| to_char(DAT31_,'dd.mm.yyyy')
                            );
   EXCEPTION WHEN NO_DATA_FOUND THEN
      --select BARSUPL.CHECK_UPLOADED_T0(p_dat01) into FV_ from dual;
      FV_ := 0;
      if FV_ = 1 THEN
         raise_application_error(-20000,'Модифiкацiя NBU23_REZ - неможлива!
                                 Виконана загрузка данних в FINEVARE за '|| to_char(p_DAT01,'dd.mm.yyyy'));
      end if;
   END;
   l_res_kf := trim('RESERVE'||sys_context('bars_context','user_mfo'));
   SYS.DBMS_SESSION.CLEAR_IDENTIFIER;
   sid_:=SYS_CONTEXT('BARS_GLPARAM',l_res_kf);
   SYS.DBMS_SESSION.SET_IDENTIFIER(sess_);

   begin
      select sid into sid_ from v$session
      where  sid=sid_ and sid<>SYS_CONTEXT ('USERENV', 'SID');
      raise_application_error(-20000,'Формування резерву вже виконується SID '|| sid_);
   exception
      when no_data_found THEN NULL;
   end;

end CHEK_modi;
-------------------
PROCEDURE RNK_KAT (ch_ int) is

-- ch_ = 0 - вызвано из rez_23
-- ch_ = 1 - единая категория качества формирование таблицы
--           в REZ_23 один раз, zalog, все процедуры вызванные из меню

begin
   return;
--   sdat01_ := to_char( DAT_,'dd.mm.yyyy');
--   PUL.Set_Mas_Ini( 'sFdat1', sdat01_, 'Пар.sFdat1' );
   if ch_=1 THEN
      z23.to_log_rez (user_id , 35 , dat01_ ,'KAT-заполнение(начало) ');
      z23.deb_kat(dat01_,1,0,0);
      z23.deb_kat(dat01_,0,0,0);
      LOGGER.INFO('REZ23 8 KAT-заполнение ');
      execute immediate 'truncate table tmp_rnk_kat';
      insert into  tmp_rnk_kat
      select rnk,max(kat23),istval from v_rnk_kat group by rnk,istval;
      --LOGGER.INFO('REZ23 8 KAT-все ');
      z23.to_log_rez (user_id , -35 , dat01_ ,'KAT-заполнение(конец ) ');
   end if;
end RNK_KAT;
-------------------

PROCEDURE DI_SNP is --установка Ид дат

begin

   select to_char ( add_months (DAT01_,-1), 'J' ) - 2447892 into z23.DI_ from dual;

/*
   begin
      select 1 into kat1_ from tmp_rnk_kat where rnk=0 and kat=10;
   EXCEPTION  WHEN NO_DATA_FOUND  THEN
      LOGGER.INFO('REZ23 8 KAT-заполнение ');
      execute immediate 'truncate table tmp_rnk_kat';
      insert into  tmp_rnk_kat
      select rnk,max(kat23),istval from v_rnk_kat group by rnk,istval;
      insert into  tmp_rnk_kat (rnk,kat,istval)
                         values(  0, 10,     1);
      LOGGER.INFO('REZ23 8 KAT-все ');
   end;
*/

   z23.DAT_BEG := DAT01_  ;
   dat31_      := Dat_last_work (dat01_ - 1 )      ; -- последний рабочий день месяца
   z23.DAT_END := dat31_  ;
   z23.XOZ_    := nvl(F_Get_Params('XOZ_REZ', 0) ,0)  ; -- внедрен ли модуль XOZ c расчетом резервов

/*
  If     DAT01_ = to_date('01/12/2012','dd/mm/yyyy') then DI_ := 8341 ;
  elsIf  DAT01_ = to_date('01/01/2013','dd/mm/yyyy') then DI_ := 8371 ;
  elsIf  DAT01_ = to_date('01/02/2013','dd/mm/yyyy') then DI_ := 8402 ;
  elsIf  DAT01_ = to_date('01/03/2013','dd/mm/yyyy') then DI_ := 8433 ;
  elsIf  DAT01_ = to_date('01/04/2013','dd/mm/yyyy') then DI_ := 8461 ;
  elsIf  DAT01_ = to_date('01/05/2013','dd/mm/yyyy') then DI_ := 8492 ;
  elsIf  DAT01_ = to_date('01/06/2013','dd/mm/yyyy') then DI_ := 8522 ;
  elsIf  DAT01_ = to_date('01/07/2013','dd/mm/yyyy') then DI_ := 8553 ;
  elsIf  DAT01_ = to_date('01/08/2013','dd/mm/yyyy') then DI_ := 8583 ;
  elsIf  DAT01_ = to_date('01/09/2013','dd/mm/yyyy') then DI_ := 8614 ;
  elsIf  DAT01_ = to_date('01/10/2013','dd/mm/yyyy') then DI_ := 8645 ;
  elsIf  DAT01_ = to_date('01/11/2013','dd/mm/yyyy') then DI_ := 8675 ;
  elsIf  DAT01_ = to_date('01/12/2013','dd/mm/yyyy') then DI_ := 8706 ;
  elsIf  DAT01_ = to_date('01/01/2014','dd/mm/yyyy') then DI_ := 8736 ;
  end if;
*/

end DI_SNP;


PROCEDURE TKr_many
 (p_mode    in  int   , -- 0 = без записи в test_many. 1 = с записью в  test_many
  p_nd      IN  number,
  p_SS      IN  number, -- сумма выданого кредита в копейках
  p_GPK     IN  int   , -- 3- ануитет
  DAT04_    IN  date  , -- дата завершения КД
  p_RATE    IN  number, -- годовая % ставка
  p_basey   IN  int   DEFAULT 0 , --базовый год
  p_irr0    IN  number, -- нач.єф.ставка
  DAT31_    IN  date  , -- дата среза инф
  DAT01_    IN  date  , -- 01 число отчетного мес
  k_        IN  number, -- коеф (показник ризику)
  p_pv     OUT number , -- Теп.варт КД (тiльки грошовi кошти по ГПК)
  -----------------------
  Not_Use1  IN  number, -- НЕ ИСП обеспечение для включения в потоки по рын.стоимости, уже умноженное на коеф ликвидности
  Not_Use2  in  int   , -- НЕ ИСП ПЛАНОВОЕ КОЛИЧЕСТВО ДНЕЙ ДЛЯ РЕАЛИЗАЦИИ ЗАЛОГА ЭТОГО ВИДА
  Not_Use3 OUT number   -- НЕ ИСП Теп.варт КД (тiльки забезп)
 ) is

/*

 27-12-2012 - убрала отсюда расчет бал.стоимости, он будет сверху и одинаков для всех КД ( с PV и без)
 подпрограмма для: Протокол PV,BV,Irr по реальн.КП по ОДНОМУ КД

функції роботи з хеш-таблицями

 EXISTS   --    перевірити чи існує елемент
 COUNT    --    дізнатися скільки записів
 LIMIT    --    дізнатися скільки ще можна записів вставити (там де встановлено фіксований розмір таблиці)
 FIRST and LAST  -- отримати 1-й чи останній
 PRIOR and NEXT  -- вибрати попередній чи наступний
 EXTEND          --розширити таблицю (там де встановлено фіксований розмір таблиці)
 TRIM            --вкоротити таблицю на кілька елементів (там де встановлено фіксований розмір таблиці)
 DELETE          -- вилучити запис  чи всі

*/

  S_    number := 0 ; -- раб.ячейка
  l_ost number ; -- непогаш ост по телу
  l_s1  number ; -- общ.сумма 1-го платежа
  l_ss  number ; -- в нем - сумма тела \
  l_sn  number ; -- в нем - сумма проц /  общ.сумма 1-го платежа
  l_fdat  date ; d8 VARCHAR2(8);
  r_fdat  date ; d9 VARCHAR2(8);
----------------------------------------
  TYPE many1 IS RECORD
 (fdat date, p1_ss number, p1_sn number, many number, lim2 number, lim1 number, plan1 number, NOT_SN number);
  TYPE MANY  IS TABLE  OF many1 INDEX BY VARCHAR2(8);
  tmp  MANY;


  DAT_pl1    date   := null   ; -- первая пл.дата в следующем периоде
  INT_31     number := 0      ; -- проц за прошлий месяц
  int_       number := 0      ;
  TELO_      number := 0      ; -- Отклонения по телу
  TELO1_     number := 0      ;
  rez_wdate_ number ;
  DAT042_    date   ;
  PVDAT_     date   := DAT01_ ; -- дата для включения просрочки

  K1  SYS_REFCURSOR;
  gpk cc_lim%rowtype;
------------------
BEGIN

 tmp.DELETE;
 rez_wdate_ := nvl(F_Get_Params('REZ_WDATE', 0) ,0);


 if gl.amfo in ( '353575' , '300120') or rez_wdate_ = 1 THEN  --ДЕМАРК + ПЕТРОКОМЕРЦ = 59 постанова
    PVDAT_  := DAT04_; --пессимитстичный сценарий.
    -- по доп.реквизиту. если нет. то на посл. дату
    begin
      select to_date(txt,'dd/mm/yyyy') into  PVDAT_ from nd_txt where nd = p_nd and tag = 'PVDAT';
    exception when others then null;
    end;
 end if;

 PVDAT_ := greatest( DAT01_, PVDAT_);

 -- общий баланс по ГРК (-выдано(факт) + погашение(план). TELO_ = разница
 TELO_  := p_ss;

 d8     := TO_CHAR(DAT31_,'yyyymmdd');
 tmp(d8).fdat := DAT31_ ;
 tmp(d8).p1_ss:= p_ss   ;
 tmp(d8).many := 0      ;
 -------------------------------------------------
 -- след даты = типа погашение
 If dat01_ > sysdate   then   -- прямо из ГПК
    OPEN k1 FOR SELECT fdat,sumg,sumo, NOT_SN from cc_lim
                where                 nd=p_nd and fdat>DAT31_ and fdat <= DAT04_ order by fdat ;
 else                       -- уже из архива ГПК
    OPEN k1 FOR select fdat,sumg,sumo, NOT_SN from cc_lim_arc
                where mdat=DAT01_ and nd=p_nd and fdat>DAT31_ and fdat <= DAT04_ order by fdat ;
 end if;


 IF NOT K1%ISOPEN THEN    RETURN; END IF;
 LOOP
    FETCH     K1 into gpk.fdat, gpk.sumg, gpk.sumo, gpk.NOT_SN;
    EXIT WHEN K1%NOTFOUND;
    TELO_    := TELO_ + nvl(gpk.sumg,0) ;
    If gpk.fdat < DAT01_ then  d8     := TO_CHAR(  DAT01_,'yyyymmdd');     tmp(d8).fdat :=   DAT01_ ;
    else                       d8     := TO_CHAR(gpk.fdat,'yyyymmdd');     tmp(d8).fdat := gpk.fdat ;
    end if ;
    tmp(d8).p1_ss := gpk.sumg ;
    tmp(d8).many  := 0      ;
    tmp(d8).p1_sn := (gpk.sumo-gpk.sumg) ;
    tmp(d8).NOT_SN:= gpk.NOT_SN;
    dat_pl1       := nvl( dat_pl1, gpk.fdat) ;
 end loop;
 CLOSE k1;
 ----------------------------------------------

 -- DAT04 = последняя дата (на свякий случай)
 d8      := TO_CHAR(DAT04_,'yyyymmdd');

 if NOT tmp.EXISTS(d8) then
    tmp(d8).fdat := DAT04_ ;
    tmp(d8).p1_ss:= 0 ;
    tmp(d8).many := 0 ;
    tmp(d8).p1_sn:= 0 ;
 end if;

 DAT042_  := add_months( DAT04_, 2);

 --ВСТАВКА ОТЧЕТНыХ ДАТ (01), ЕСЛИ ОНИ изначально НЕ ЕСТЬ ПЛАТЕЖНыМИ
 for k in ( select trunc( add_months( DAT31_, c.num),'MM') FDAT  from conductor c
            where c.NUM > 0  and add_months( DAT31_,c.num) < DAT042_ )
 loop
    d8     := TO_CHAR(k.fdat,'yyyymmdd');
    if NOT tmp.EXISTS(d8) then
       tmp(d8).fdat := k.fdat ;
       tmp(d8).p1_ss:= 0      ;
       tmp(d8).many := 1      ;
    end if;

 end loop;

 If PVDAT_ > DAT01_ then
    d8     := TO_CHAR(PVDAT_,'yyyymmdd');
    if NOT tmp.EXISTS(d8) then
       tmp(d8).fdat := PVDAT_ ;
       tmp(d8).p1_ss:= 0      ;
       tmp(d8).many := 0      ;
    end if;
 end if;
 TELO1_ := TELO_;
 If TELO_ < 0 then
    --просрочка
    d8     := TO_CHAR(PVDAT_,'yyyymmdd');
    tmp(d8).p1_ss := NVL (tmp(d8).p1_ss, 0)  - TELO_;

 elsIf TELO_ > 0 and p_gpk =3 then

    -- досрочка Ануитет
    l_ost := - p_ss;

    -- последняя плат дата в отчетном (пред.) периоде
    --  общ.суммы 1-го платежа
    begin
       If  DAT01_ > sysdate then
          select max(fdat) into l_fdat from cc_lim     where                   fdat < DAT01_ and nd = p_nd ;
          select sumo      into l_s1   from cc_lim     where                   fdat = l_fdat and nd = p_nd ;
       else
          select max(fdat) into l_fdat from cc_lim_arc where mdat = DAT01_ and fdat < DAT01_ and nd = p_nd ;
          select sumo      into l_s1   from cc_lim_arc where mdat = DAT01_ and fdat =l_fdat  and nd = p_nd ;
       end if;
    EXCEPTION  WHEN NO_DATA_FOUND  THEN      l_s1 := 0;
    end;

    -- перестроить весь график (сверху -> вниз) с сохранением общ.суммы 1-го платежа
    d8 := tmp.FIRST; -- установить курсор на  первую запись
    WHILE d8 IS NOT NULL
    LOOP
       If tmp(d8).fdat >= DAT01_ and  tmp(d8).many = 0 then
          l_sn := 0;
          If l_ost > 0 then
             l_sn := ROUND(  calp(l_ost, p_RATE, l_FDAT, tmp(d8).fdat -1, nvl(p_basey,2) )  ,0);
          end if;
          l_ss := least( l_ost, greatest(l_s1 - l_sn,0) );
          tmp(d8).p1_ss := l_ss  ;
          tmp(d8).p1_sn := l_sn  ;
          l_ost  := l_ost - l_ss ;
          l_fdat := tmp(d8).fdat ;
       end if;
       d8 := tmp.NEXT(d8); -- установить курсор на след.вниз запись
    end loop;

 elsIf TELO_ > 0 then

    -- досрочка - не ануитет  -- поиск снизу->вверх ненулевых сумм (каникул НЕТ)
    d8 := tmp.LAST; -- установить курсор на последнюю запись
    WHILE d8 IS NOT NULL
    LOOP
       If tmp(d8).fdat >= DAT01_  and  tmp(d8).p1_ss > 0 and TELO_ > 0 then
          S_    := least( TELO_,tmp(d8).p1_ss   );
          tmp(d8).p1_ss    := tmp(d8).p1_ss- S_;
          TELO_ := TELO_ -S_ ;
       end if;
       d8 := tmp.PRIOR(d8); -- установить курсор на след.вверх запись
    end loop;

 end if;

 -- Проставить вх и исх остатки
 l_ss := 0;
 d8   := tmp.LAST; -- установить курсор на последнюю запись
 WHILE d8 IS NOT NULL
 loop
    tmp(d8).lim2 := l_ss ; l_ss := l_ss - Nvl( tmp(d8).p1_ss, 0 ) ;   tmp(d8).lim1 := l_ss ;
    d8 := tmp.PRIOR(d8); -- установить курсор на след.вверх запись
 end loop;

 -- еще раз пересчитаем проценты (кроме ануитета)
 If TELO1_ <> 0 AND  p_gpk <> 3 then
    -- начальные проценты = строго остаткам на счетах ( SN )  +  ( SNO c mdate=null)
    select -NVL(sum(  ost_korr(a.acc,dat31_,z23.di_,a.nbs)  ),0)    into INT_31
    from nd_acc n, accounts a
    where n.nd  = p_ND   and n.acc  = a.acc   and ( a.tip ='SN '    or a.tip ='SNO' and a.mdate is null    );
    --Расчитать проц и запомнить их
    d8 := tmp.FIRST; -- установить курсор на  первую запись
    l_fdat := null ;
    r_fdat := DAT01_ - 1 ;
    WHILE d8 IS NOT NULL
    LOOP
       If tmp(d8).fdat >=   DAT01_ then
          If tmp(d8).fdat > DAT01_ then
             s_ := ROUND(calp(-tmp(d8).LIM1,p_RATE,l_FDAT,tmp(d8).FDAT-1, nvl(p_basey,0)),0);  int_31 := Int_31 + s_;
          end if;
          l_FDAT := tmp(d8).FDAT ;
          If substr( d8,-2) = '01' or tmp(d8).fdat = dat04_ then
             -- необходимо выложить проц в ближ плат. дату. в кот проц еще  НЕ выкладывались

             If r_fdat = dat04_ then   d9 := TO_CHAR(dat04_,'yyyymmdd');
                tmp(d9).p1_sn := nvl(tmp(d9).p1_sn, 0) + S_ ;
             else
               d9 := d8;
               WHILE d9 IS NOT NULL
               LOOP
                  If tmp(d9).many   = 0  and  nvl(tmp(d9).NOT_SN,0) <> 1 and tmp(d9).fdat > r_fdat  then
                     tmp(d9).p1_sn := int_31 ; int_31 := 0 ;  r_fdat := tmp(d9).fdat; EXIT ;
                  end if ;
                  d9 := tmp.NEXT(d9); -- установить курсор на след.вниз запись
               end loop  ;
             end if;

          end if;
       end if;
       d8 := tmp.NEXT(d8); -- установить курсор на след.вниз запись
    end loop;
 end if;
-------------------------------------------------
  p_pv  := null;
------------------------------------------------
 --счета-одиночки  типа просроченных и отложенных нач %%
 for k in (select a.tip, ost_korr(a.acc,dat31_,z23.di_,a.nbs) OST, mdate, a.nbs
           from nd_acc n, accounts a
           where n.nd = p_nd  and n.acc = a.acc and a.tip in ('SPN','SNO')
             and ost_korr(a.acc,dat31_,z23.di_,a.nbs) <> 0   )
 loop
    if k.tip =    'SPN' and k.nbs like '2__9' then
       -- просроченные проценты   - на DAT01_
       d8     := TO_CHAR(PVDAT_,'yyyymmdd');
       tmp(d8).p1_sn := nvl( tmp(d8).p1_sn, 0 ) - k.ost ;

    Elsif k.tip = 'SNO' and k.nbs like '2__8' and k.mdate is not null then
       -- отложенные  проценты   - на mdate
       d8     := TO_CHAR(k.mdate,'yyyymmdd');
       tmp(d8).fdat  := k.mdate;
       tmp(d8).p1_ss := nvl( tmp(d8).p1_ss, 0 ) ;
       tmp(d8).p1_sn := nvl( tmp(d8).p1_sn, 0 ) - k.ost ;
       tmp(d8).many  := 0;
    end if;
 end loop;

 -- PV  Теп.варт КД (тiльки грошовi кошти по ГПК)
 p_pv  := 0 ;
 d8    := tmp.FIRST; -- установить курсор на  первую запись
 WHILE d8 IS NOT NULL
 LOOP
    S_ := 0 ;
    if tmp(d8).FDAT > DAT31_ then
       tmp(d8).plan1 :=  nvl( tmp(d8).p1_ss, 0 ) + nvl( tmp(d8).p1_sn, 0 )   ;
       s_   :=  tmp(d8).plan1 / power (  (1+ p_irr0/100 ), (tmp(d8).FDAT - DAT01_ )/365 ) ;
       s_   :=  round ( ( 1-nvl(k_,0) ) * S_ , 0) ;
       p_pv :=  p_pv  + S_ ;
    end if;

    If p_mode = 1 then
       insert into test_many   (dat, id, nd, fdat, p1_ss, p1_sn, many, lim2, lim1, plan1, PLAN2 )   values
          (DAT01_,gl.auid,p_nd,TMP(d8).fdat,TMP(d8).p1_ss,TMP(d8).p1_sn,TMP(d8).many,TMP(d8).lim2,TMP(d8).lim1,TMP(d8).plan1 , s_);
    end if;

    d8 := tmp.NEXT(d8); -- установить курсор на след.вниз запись

 end loop;
--  уже умножено !! p_pv  := ROUND(  ( 1-nvl(k_,0) ) *  p_pv,0); -- HE умножено !!

 If p_mode = 1 then
    update test_many set irr= p_irr0, pv= p_pv, k= k_, gpk= p_GPK, ir= p_RATE
    where fdat= DAT31_ and dat= DAT01_ and id=gl.auid and nd=p_nd;
 end if;

 RETURN;

end tKr_many;
---------------------

PROCEDURE TK_many
 (p_nd    IN  number , --:A(SEM=Реф_КД,TYPE=N)
  P_DAT01 IN  date   , --:D(SEM=Зв_дата_01,TYPE=D)
  p_modeR IN  int    , -- :R(SEM=Перег=1/0,TYPE=N) 1 - с записью в TEST_MANY
  p_modeZ IN  int    , -- :Z(SEM=Включ.в 1B=1/0,TYPE=N)   > 1 / not in (0,1)  для псевдо-расчета по НАДРА
  ch_     in  int  DEFAULT 0
  ) is

  KV_      NUMBER ; IRR0_  NUMBER; SS_      NUMBER; NBS_    CHAR(4) ; l_dat    DATE; l_DAY_IMP int; VKR_  VARCHAR2(10)  ;  -- внутренний кредитный рейтинг
  GPK_     NUMBER ; ACC8_  NUMBER; SDI_     NUMBER; s2401_  CHAR(1) ; dat5_    DATE; l_RE_RN   int; id2_  VARCHAR2(20)  ;
  RATE_    NUMBER ; BASEY_ NUMBER; ZAL9_    NUMBER; sdat01_ CHAR(10); l_rsdate DATE; cust_     int; id9_  VARCHAR2(20)  ;
  D_KAT5   NUMBER ; pvp_   NUMBER; REZ_KAT_ NUMBER;                   sdate_   DATE;                IDN8_ VARCHAR2(30)  ;
                                                                      d5_      DATE;                sd01_ VARCHAR2(40)  ;
                                                                                                    sSql_ VARCHAR2(4000);
  Z_koef   NUMBER ; -- отношение PVZ(приведенный залог) / ZAL(ликвидный залог) в целом по КД.
                    -- Использую при делении PVZ по ВИДАМ залога PAWN внутри одного счета
  A_koef   NUMBER ; -- отношение BV (бал.стоим одного ACC) / SA(сумма актива в целом по КД)
                    -- Использую при делении PV,PVZ,REZ,ZAL, ZALALL по СЧЕТАМ внутри одного КД
  k_       NUMBER ; -- коэф.риска
  -----------------
  SAN_     NUMBER ; --\
  SAQ_     NUMBER ; --/ суммарный актив по КД (без дисконта)
  SDQ_     NUMBER ; --дисконт
  TELO_    NUMBER ; -- сумма выданого кредита в копейках
  -----------------
  Not_Use3 NUMBER ; -- рабочая переменная. не использ
  dat_23   date   := to_date('01-11-2012','dd-mm-yyyy'); --дата начала действия постановы 23
  kol_     int    := 0  ;
  -----------------
  istval_  SPECPARAM.ISTVAL%type;
  -----------------

BEGIN

   logger.info ('REZ23 НАЧАЛО CCK' || sysdate );
   REZ_KAT_ := nvl(F_Get_Params('REZ_KAT', 0) ,0);

   If p_ND is null then  RETURN; end if;
   -------------------------------------
   IF p_DAT01 IS NULL THEN
      raise_application_error(-20000,'Укажiть звiтну дату !');
   END IF;

   DAT01_  := p_DAT01;                 -- 01 число отч мес
   dat31_  := dat_last_work(dat01_ - 1); -- последний рабочий день месяца
   sdat01_ := to_char( DAT01_,'dd.mm.yyyy');
   PUL_dat(sdat01_,'');

   If p_modeZ = 1 then   z23.CHEK_modi(DAT01_) ;   end if;
   ------------------------
   z23.to_log_rez (user_id , 4 , p_dat01 ,'Начало Кредиты '||p_nd);
   Z23.di_snp;
   z23.RNK_KAT(ch_);

   If gl.amfo ='380764' THEN
      EXECUTE IMMEDIATE  'delete from TEST_MANY';
      EXECUTE IMMEDIATE  'delete from TEST_MANY_CCK';
   else

      EXECUTE IMMEDIATE 'truncate table TEST_MANY';
      EXECUTE IMMEDIATE 'truncate table TEST_MANY_CCK';
   end if;
   ------------------------------------------
   if p_modeZ = 1 then      tmp.DELETE;
      for k in (select r020, ddd from kl_f3_29 where kf='1B' and ( r020 >='2000' and r020 <'2300' or r020 ='9129' ) )
      loop      tmp(k.r020).ddd := k.ddd ;   end loop;
   end if;

   if p_modeZ > 1 then      sd01_ := ' to_date(''' || to_char( DAT01_,'dd.mm.yyyy') || ''',''dd.mm.yyyy'') '; end if;

   if p_nd=0 and p_modeZ =1 THEN  delete from NBU23_rez where fdat = DAT01_ and id like ('CCK%') ;            end if;

   FOR D IN (SELECT * FROM CC_DEAL e
             WHERE  e.VIDD IN (1,2,3,11,12,13)  AND e.SDATE  <  DAT01_
             --and  (e.WDATE >= DAT01_ OR e.SOS >= 10 and e.SOS <14)
             --and  nvl(e.branch,' ') like NVL(sys_context('bars_context','user_branch'),'' ) ||'%'
               and  p_nd in (0, e.nd)
            )
   loop
      --logger.info('IRR_EF 2 : nd = ' || d.nd || ' d.vidd = '|| d.vidd ) ;
      If p_modeZ > 1   and d.vidd not in (1,11) then          Goto next8;       end if;
      IRR0_ := 0; TELO_ := 0  ; SS_  := 0; ZAL9_ := 0; D_KAT5:= 0; GPK_  := NULL; RATE_ := NULL;
      BV_   := 0; BVq_  := 0  ; PV_  := 0; PVq_  := 0; PVZ_  := 0; ACC8_ := NULL; BASEY_:= NULL; id2_  := 'CCK2/'|| d.ND || '/' ;
      Rez_  := 0; Rezq_ := 0  ; Zal_ := 0; ZALq_ := 0; PVZq_ := 0; nbs_  := null; S2401_:= '0' ; id9_  := 'CCK9/'|| d.ND || '/' ;
      SDQ_  := 0;

      If p_modeZ = 1 and p_nd<>0  then
         delete from NBU23_rez where fdat = DAT01_ and  ( id like id2_||'%' or id like  id9_||'%' ) ;
      end if ;
      If d.vidd < 10 then cust_ := 2; else cust_ := 3; end if;
      begin
         If d.prod is null then   ---  В Коопспилках нет PROD
            begin     select a.nbs  into nbs_ from   cc_add c,accounts a where  c.nd=d.nd and c.accs=a.acc;
            EXCEPTION WHEN NO_DATA_FOUND THEN  null;
            END;
         else   nbs_:= substr(d.prod,1,4);
         end if;

         ----проверим тело кредита    -- остаток , вид ГПК, асс8,  баз вал
         begin
            SELECT DECODE(A.VID,4,3,1), A.ACC,a.kv,s.istval,cck_app.get_nd_txt(d.nd, 'VNCRR')
                   INTO GPK_,ACC8_,kv_,ISTVAL_,VKR_  FROM ND_ACC N, ACCOUNTS A,specparam s
            WHERE a.acc = s.acc(+) and ND=d.nd AND N.ACC=A.ACC AND A.TIP='LIM' and rownum=1 ;
         EXCEPTION WHEN NO_DATA_FOUND THEN   GPK_ := 0; ACC8_ := NULL; kv_ := NULL; ISTVAL_:= NULL;
         END;

         istval_ := f_get_istval (d.nd,0,d.sdate,kv_);

         If ( getglobaloption('MFOP') = '300465' or gl.aMfo = '300465' )  then
            if d.s250='8' THEN
               s2401_:= '1';
               If    d.kol_sp <=  7  then d.kat23 :=1; d.k23 := 0.02;
               ElsIf d.kol_sp <= 30  then d.kat23 :=2; d.k23 := 0.10;
               ElsIf d.kol_sp <= 90  then d.kat23 :=3; d.k23 := 0.40;
               ElsIf d.kol_sp <=180  then d.kat23 :=4; d.k23 := 0.80;
               Else                       d.kat23 :=5; d.k23 := 1;
               end if;
            else
               s2401_:= '0';
            end if;
         else
            S2401_:= nvl(cck_app.Get_ND_TXT(d.nd,'2401'),'0');
         end if;

         if REZ_KAT_=1 THEN
            if s2401_='1' THEN
               d.k23  := f_rnk_kat_k(d.rnk,d.kat23,d.k23,6,istval_);
               d.kat23:= f_rnk_kat_k(d.rnk,d.kat23,d.k23,5,istval_);
            else
               d.k23  := f_rnk_kat_k(d.rnk,d.kat23,d.k23,2,istval_);
               d.kat23:= f_rnk_kat_k(d.rnk,d.kat23,d.k23,1,istval_);
            end if;
         end if;

         begin
            select (ostf-dos+kos) into TELO_ from saldoa
            where acc=ACC8_ and fdat=(select max(fdat) from saldoa where acc=ACC8_ and fdat < dat01_);
         EXCEPTION WHEN NO_DATA_FOUND THEN If p_modeZ > 1  then Goto next8; end if; TELO_:= 0 ; goto ZALOGI; --м.б. есть только 9129
         end;
         If d.wdate < DAT01_ OR TELO_ = 0 then
            If p_modeZ > 1 then
               Goto next8;
            end if;
            IRR0_ := 0 ;
            goto ZALOGI; -- просрочка ! эф ставка не нужна !
         end if;
         --logger.info('IRR_EF 1 : nd = ' || d.nd || ' s2401_ = '|| s2401_ ) ;
         if s2401_='1' THEN
            IRR0_:= 0;
            If p_modeZ > 1 then
               Goto next8;
            end if;  -- Портф метод по 23 пост, считается по простой формуле без Эф.ставки
         else
         --logger.info('IRR_EF 1 : nd = ' || d.nd || ' d.vidd = '|| d.vidd ) ;
            if d.vidd in (1,11) then
               --logger.info('IRR_EF 1 : nd = ' || d.nd || ' l_RE_RN = '|| l_RE_RN ) ;
               if gl.amfo in ('300205') THEN   -- УПБ
                  begin
                     select round(IR,8) INTO IRR0_
                     from INT_RATN
                     where acc=acc8_ and id=-2 and
                           bdat = (SELECT min(bdat) FROM int_ratn   --  min (только для УПБ)
                                   WHERE acc=acc8_ AND id=-2 AND bdat<=dat01_);
                  EXCEPTION WHEN NO_DATA_FOUND THEN IRR0_ := 0 ;
                  end;
               else   -- остальные
                  IRR0_ := NVL(round(ACRN.FPROCN(acc8_,-2,DAT31_),8), 0); -- проверим эфф. ставку ?
               end if;
               If IRR0_ <= 0 or IRR0_ >= 100 then
                  IRR0_ := 0;
                  If p_modeZ > 1 then
                     Goto next8;
                  end if;
                  goto ZALOGI;  --эф ставка ПЛОХАЯ, и потому она нам не нужна !
               end if;
               -- ном
               begin
                  select RATE, BASEY  INTO   RATE_, BASEY_
                  from (SELECT ACRN.FPROCN(ACC,0, DAT31_) RATE,  NBS, KV, BASEY
                        FROM (SELECT A.ACC,A.NBS,A.KV,I.BASEY FROM ACCOUNTS A,INT_ACCN I
                              WHERE A.ACCC=ACC8_ and ost_korr(a.acc,dat31_,z23.di_,a.nbs)<>0
                                    AND I.ID=0 AND I.ACC=A.ACC  and (a.dazs is null or a.dazs >dat31_)
                              ORDER BY A.daos )
                        WHERE ACRN.FPROCN(ACC,0, DAT31_) >0 and ROWNUM =1
                       );
               EXCEPTION WHEN NO_DATA_FOUND THEN       IRR0_ := 0 ; goto ZALOGI;
               end;
               -- COBUSUPABS-4614 - Использование эф.ставки < номинальной, при установленном параметре договора RE_RN
               l_RE_RN := (case when cck_app.Get_ND_TXT (d.nd, 'RE_RN')='Taк' THEN 0 else 1 end) ;
               --logger.info('IRR_EF 1 : nd = ' || d.nd || ' l_RE_RN = '|| l_RE_RN ) ;
               If IRR0_ < RATE_ and l_RE_RN = 1 then
                  If p_modeZ > 1 then
                     Goto next8;
                  end if;
                  IRR0_ := 0 ;
                  goto ZALOGI; --эф ставка меньше номинальной, т.е.ПЛОХАЯ, и потому она нам не нужна !
               end if;
            end if;
         end if;

         ------    залоги  --
         <<ZALOGI>> null;
         dat5_:=to_date(cck_app.Get_ND_TXT(d.nd,'KAT5'),'dd/mm/yyyy');
         -- текущая отчетная дата (расчетная)
         select round(sysdate,'MM') into l_rsdate from dual;
         if l_rsdate = dat01_ THEN  --только для текущей отчетной даты

            if d.kat23 = 5 and dat5_ is null THEN
               update nd_TXT set txt=to_char(DAT01_,'dd/mm/yyyy')
               where nd=d.nd and tag='KAT5';

               if SQL%rowcount = 0 then
                  insert into nd_txt (nd,tag,txt) values (d.nd,'KAT5',to_char(DAT01_,'dd/mm/yyyy'));
               end if;
               dat5_:=dat01_;
            elsif d.kat23 < 5 and dat5_ is not null THEN
               update nd_TXT set txt=null
               where nd=d.nd and tag='KAT5';
               dat5_:=NULL;
            end if;
         end if;

         --   Для НАДРА, ПЕТРОКОМЕРЦА, ДЕМАРКА залоги берутся всегда
         If gl.amfo <>'380764' and gl.amfo <>'300120' and gl.amfo <>'353575' and d.KAT23=5 then
            if dat5_ is null THEN
               dat5_:=dat31_;
            end if;
            D_KAT5 := nvl(dat31_-dat5_,2000);
         end if;

         if d_kat5 < 1096 THEN
            --Залоги поделены по счетам в удельном все без 9129
            --поле t.s - это ликвидное (умножен на коеф ликвидности)
            --               дисконтированное на срок реализации
            --               очищенное от накладных расходов на реализацию
            -- т.е. ВЕСЬ расчет перенесено в процедуру расчета рбеспечения
            begin
               SELECT NVL(SUM(decode(a.tip,'CR9',t.S,0)),0),  NVL(SUM(decode(a.tip,'CR9',0, gl.p_icurval(t.kv,t.S, dat31_)  )),0),
                      min(nvl(t.DAY_IMP,180)) INTO ZAL9_, Zalq_, l_DAY_IMP
               FROM   TMP_REZ_OBESP23 t, accounts a    WHERE t.ND = D.ND and  t.DAT = DAT01_ and t.accs=a.acc and t.s >0 ;
               zal_ := gl.p_ncurval( KV_, Zalq_, dat31_);
            EXCEPTION WHEN NO_DATA_FOUND THEN ZAL9_:=0; Zal_ :=0;  Zalq_:=0;  l_DAY_IMP:=0;
            end;
         end if;

         if s2401_='1' THEN
            IRR0_:= 0; ZAL9_:=0; Zal_ :=0; Zalq_:=0; l_DAY_IMP:=0;
         end if;  -- Портфельный метод по 23 постанове -- залоги не учитываются
         PVZ_ := ZAL_ ;
         PVZq_:= ZALq_;
         SAQ_ := 0;  -- сумма акт в экв
         SAN_ := 0;  -- сумма акт в ном
         acct.DELETE;
         -- балансовая стоимость в вал КД KV_
         ss_ := 0;
         for q in (select a.tip, a.nls, a.acc, a.kv,  a.nbs, - ost_korr(a.acc,dat31_,z23.di_,a.nbs) S
                   from   nd_acc n, accounts a
                   where  n.nd = d.nd and n.acc = a.acc and a.nls <'3' and a.nbs<>'2620'
                     and  a.tip in  ('SN ','SL ','SLN','SNO','SPN','SDI','SNA','SPI','SS ','SP ','SK9','SK0')
                     and  ost_korr(a.acc,dat31_,z23.di_,a.nbs) <>0       )
         loop
            If q.kv <> KV_ then  IRR0_ :=0;   end if; --скрытая мультивалютка
            If nbs_ is null then       nbs_ := q.nbs;        end if;
            If    KV_  = q.KV then  ss_ := SS_ +                                        q.S                     ;
            ElsIf KV_  = 980  then  ss_ := ss_ +                    gl.p_icurval( q.kv, q.S, DAT31_)            ;
            ElsIf q.KV = 980  then  ss_ := ss_ + gl.p_Ncurval( KV_ ,                    q.S,           DAT31_ ) ;
            else                    ss_ := ss_ + gl.p_Ncurval( KV_, gl.p_icurval( q.kv, q.S, DAT31_) , dat31_ ) ;
            end if;
            acct(q.acc).tip :=  q.tip ;
            acct(q.acc).kv  :=  q.kv  ;
            acct(q.acc).nls :=  q.nls ;
            acct(q.acc).nbs :=  q.nbs ;
            acct(q.acc).bv  :=  q.s   ;
            acct(q.acc).bvq :=  gl.p_icurval(q.kv,q.s,dat31_);
            If acct(q.acc).bvq > 0 then SAQ_ := SAQ_ + acct(q.acc).bvq;  --общ сумма акт в экв
            else                        SDQ_ := SDQ_ + acct(q.acc).bvq;  --общ сумма контр.акт в экв
            end if;
         end loop;
         ------------
         -- SS_ := greatest(0, SS_);
         BV_ := SS_ ;
         PV_ := 0   ;
         If irr0_ = 0  or d.kat23 = 5  then  irr0_ := 0;       end if;
         If IRR0_ > 0   then     ---------  PV по эф.ставке
            If p_modeZ > 1 then IRR0_ := p_modeZ; end if;
            Z23.TKr_MANY ( p_modeR,
                           P_ND   => D.ND  , P_SS     => TELO_, P_GPK     => GPK_  , DAT04_ => D.WDATE, P_RATE => RATE_,
                           P_BASEY=> BASEY_, P_IRR0   => IRR0_, DAT31_    => DAT31_, DAT01_ => DAT01_ , K_     => D.K23 ,
                           P_PV    => PV_  ,
                           ------------------------------------------------------------
                           Not_Use1=> null , Not_Use2 => null,  Not_Use3  => Not_Use3  ) ;
         elsIf SS_>= 0 and SAQ_ > 0  then If p_modeZ > 1 then Goto next8; end if;
            SAN_:= gl.p_Ncurval( KV_, SAQ_, DAT31_ ) ;  PV_ := round ( ( SAN_ * (1-d.k23)), 0) ;
         else              If p_modeZ > 1 then Goto next8; end if;
         end if;
         sdate_ := d.SDATE;
         If d.NDI is not null then
            begin select nvl(sdate, d.sdate)  into sdate_ from cc_deal where nd = d.ndi;
            EXCEPTION WHEN NO_DATA_FOUND THEN  sdate_ := d.SDATE;
            end;
         end if;
         -------------
         If BV_ <> 0 or SAQ_ > 0 then
            REZ_  := GREATEST ( BV_ - PV_ - PVZ_, 0)  ; --простые+слож
            PVZ_  := greatest ( BV_ - PV_ - REZ_,0)   ;
            BVq_  := gl.p_icurval (KV_, BV_ , DAT31_) ;        -- \
            PVq_  := gl.p_icurval (KV_, PV_ , DAT31_) ;        --  \   -- PV увеличиваем на дисконт
            ZALq_ := gl.p_icurval (KV_, ZAL_, DAT31_) ;        --   | 5
            REZQ_ := gl.p_icurval (KV_, REZ_, DAT31_) ;        --  /
            PVZQ_ := gl.p_icurval (KV_, PVZ_, DAT31_) ;        -- /
            If pvz_ > 0 and zal_ >0 then   Z_koef := pvz_/zal_;  -- отношение PVZ(приведенный залог) / ZAL(ликвидный залог) в целом по КД
            else                           Z_koef := 0;
            end if;

            INSERT INTO TEST_MANY_CCK (RNK, ND, FIN, OBS, KAT ,K , KV, IRR0,   NLS, branch, vidd, sdate, wdate, ir, dat, id,
                 BV , PV , OBESP, PVZ , REZ, BVq, PVq,  ZALq, PVZq, REZq,VKR )  VALUES
                (D.RNK,D.ND,D.FIN23,D.OBS23,D.KAT23,D.K23,KV_,IRR0_,NBS_,d.branch,d.vidd, sdate_, d.wdate,rate_,DAT01_, gl.auid,
                 BV_ /100, PV_ /100, ZAL_ /100, PVZ_ /100, REZ_ /100, BVq_/100, PVq_/100, ZALq_/100, PVZQ_/100, REZq_/100,VKR_);

            -- поделить в удельном весе теп.варт. PV(PVq)+PVZ(PVZq) +резерв REZ(REZq)+залог ZAL(ZALQ)+  - через екв
            D_PVq := PVq_; D_PVZq := PVZq_; D_REZq := REZq_; D_ZALq := ZALq_;
            pvp_  := nvl(z23.F_PV(d.nd, dat01_,0),0);
            acc_  := acct.FIRST; -- установить курсор на  первую запись
            WHILE acc_ IS NOT NULL
            LOOP
               If acct(acc_).BVQ > 0 and SAQ_>0 and acct(acc_).tip<>'SPI' then
                  a_koef     := acct(acc_).BVq / SAQ_;
                  acct(acc_).PVp  := round(PVp_  * A_koef,0) ;    -- Поток
                  acct(acc_).PVq  := round(PVq_  * A_koef,0) ;    -- теп.варт
                  acct(acc_).PVZq := round(PVZq_ * A_koef,0) ;    -- теп.варт zaloga
                  acct(acc_).rezq := round(REZq_ * A_koef,0) ;    -- резерв
                  acct(acc_).zalq := round(ZALq_ * A_koef,0) ;    -- ликв.залог
                  D_PVq  := D_PVq  - acct(acc_).PVq  ;
                  D_PVZq := D_PVZq - acct(acc_).PVZq ;
                  D_REZq := D_REZq - acct(acc_).REZq ;
                  D_ZALq := D_ZALq - acct(acc_).ZALq ;
                  -- Номинал по счету - в валюте счета
                  acct(acc_).PV   := gl.p_ncurval( acct(acc_).kv, acct(acc_).PVq , dat31_);
                  acct(acc_).PVZ  := gl.p_ncurval( acct(acc_).kv, acct(acc_).PVZq, dat31_);
                  acct(acc_).rez  := gl.p_ncurval( acct(acc_).kv, acct(acc_).rezq, dat31_);
                  acct(acc_).zal  := gl.p_ncurval( acct(acc_).kv, acct(acc_).zalq, dat31_);
                  If p_modeZ in (0,1) THEN
                     z23.pvz_pawn (p_dat01 => dat01_, p_kv   => acct(acc_).kv, p_acc => acc_, Z_koef => Z_koef,
                                   p_pvz   => pvz_  , p_pvzq => pvzq_ ) ;
                  end if;
               else
                   acct(acc_).PV  := 0 ;
                   acct(acc_).PVp := 0 ;
                   acct(acc_).PVq := 0 ;
                   acct(acc_).PVZ := 0 ;  acct(acc_).PVZq := 0 ;
                   acct(acc_).rez := 0 ;  acct(acc_).rezq := 0 ;
                   acct(acc_).zal := 0 ;  acct(acc_).zalq := 0 ;
               end if;
               --------------
               If  tmp.EXISTS(nbs_) then DDD_:= tmp(nbs_).ddd;
               else                      DDD_:= null;
               end if;
               acc_ := acct.NEXT(acc_); -- установить курсор на след.вниз запись
            end loop;
            ---**** Запись балансовых сосставляющих 2*** в окончательный протокол NBU23_REZ   ******************************
            If p_modeZ > 0  then
               kol_ := kol_ + 1;
               acc_  := acct.FIRST; -- установить курсор на  первую запись
               WHILE acc_ IS NOT NULL
               LOOP
                  --балансировка разницы окр
                  If acct(acc_).pvq > 0 then acct(acc_).pv   := acct(acc_).pv   + gl.p_ncurval( acct(acc_).kv, D_PVq , dat31_);
                                             acct(acc_).pvq  := acct(acc_).pvq  + D_PVq  ;                     D_PVq := 0 ;
                  end if;
                  If acct(acc_).pvzq> 0 then acct(acc_).pvz  := acct(acc_).pvz  + gl.p_ncurval( acct(acc_).kv, D_PVZq, dat31_);
                                             acct(acc_).pvZq := acct(acc_).pvZq + D_PVZq ;                     D_PVZq:= 0 ;
                  end if;
                  If acct(acc_).rezq> 0 then acct(acc_).rez  := acct(acc_).rez  + gl.p_ncurval( acct(acc_).kv, D_rezq, dat31_);
                                             acct(acc_).rezq := acct(acc_).rezq + D_rezq ;                     D_rezq := 0 ;
                                             acct(acc_).rez  := least (acct(acc_).bv, acct(acc_).rez );
                                             acct(acc_).rezq := least (acct(acc_).bvq,acct(acc_).rezq);
                  end if;

                  If acct(acc_).zalq> 0 then acct(acc_).zal  := acct(acc_).zal  + gl.p_ncurval( acct(acc_).kv, D_zalq, dat31_);
                                             acct(acc_).zalq := acct(acc_).zalq + D_zalq ;                     D_zalq := 0 ;
                  end if;

                  IDN8_ :=id2_||acc_;
                  If p_modeZ = 1  then
                     begin
                        INSERT INTO NBU23_REZ (cc_id,branch,RNK,ND,FIN,OBS,KAT,K,FDAT,irr,DDD,dd,acc,
                                               ID,NBS,nls,KV,BV,PV,PVZ,REZ,ZAL,BVq,PVq,PVZq,REZq,ZALq,
                                               FIN_R,sdate,wdate,s250,VKR,grp,kol_sp,pvp)
                        values (d.cc_id,d.branch,d.RNK,d.ND,d.FIN23,d.OBS23,d.KAT23,d.K23,DAT01_,irr0_,
                                DDD_,cust_,acc_,IDN8_, acct(acc_).nbs,acct(acc_).nls,acct(acc_).kv,
                                acct(acc_).bv/100,acct(acc_).pv/100,acct(acc_).pvz/100,acct(acc_).rez/100,
                                acct(acc_).zal/100,acct(acc_).bvq/100,acct(acc_).pvq/100,acct(acc_).pvzq/100,
                                acct(acc_).rezq/100,acct(acc_).zalq/100,d.fin, sdate_,d.wdate,
                                decode(ddd_,123,decode(S2401_,'1','8',NULL),NULL),VKR_,d.grp,
                                nvl(d.kol_sp,0),acct(acc_).pvp/100);
                     exception when others then
                        --ORA-00001: unique constraint (BARS.PK_NBU23REZ_ID) violated
                        if SQLCODE = -00001 then
                           raise_application_error(-20000, 'NBU23_REZ dubl '|| to_char(DAT01_,'dd.mm.yyyy') || ' '|| id2_||acc_);
                        else  raise;
                        end if;
                     end;

                  elsIf p_modeZ > 1 then
                        sSql_ := 'INSERT INTO NBU23_REZ_8 (ND,FDAT,irr,acc,ID,KV,BV,PV,PVZ,REZ) values (:ND, :DAT01_, :IRR0_, :ACC_, :IDN8_,'||
                                  acct(acc_).kv     ||', '||
                                  acct(acc_).bv/100 ||', '||acct(acc_).pv/100 ||', '||acct(acc_).pvz/100||', '||acct(acc_).rez/100||')';

                        execute immediate  sSql_ using d.ND, DAT01_, IRR0_, ACC_, IDN8_;

                  end if;

                  --------------
                  acc_ := acct.NEXT(acc_); -- установить курсор на след.вниз запись
               end loop;
            end if;

         end if;

         If p_modeZ > 1 then Goto next8; end if;

         ------9129---
         for k in (select a.acc, a.nbs, a.nls,a.kv, p.r013, -ost_korr(a.acc,dat31_,z23.di_,a.nbs) BV, a.ob22, a.tip
                   from   accounts a, nd_acc n, specparam p
                   where  n.nd = D.ND and n.acc = a.acc and a.tip ='CR9' and a.acc= p.acc (+)
                     and  (a.dazs is null or a.dazs >= DAT01_)
                     and  ost_korr(a.acc,dat31_,z23.di_,a.nbs)  <0
                  )
         loop

            begin
               select NVL( gl.p_Ncurval(k.KV, sum( gl.p_icurval(a.kv, ost_korr(a.acc,dat31_,z23.di_,a.nbs), DAT31_)), DAT31_), 0 )
               into SDI_ from accounts a,nd_acc n  where n.nd=D.ND and n.acc = a.acc and a.nbs = '3600' ;
            EXCEPTION  WHEN NO_DATA_FOUND THEN SDI_:= 0;
            end;

            BV_  := k.BV;
            If k.r013='9' then PV_:=      BV_             ; REZ_:= 0                            ; PVZ_:=0  ;
            else               PV_:=round(BV_*(1-D.K23)+SDI_,0); REZ_:=greatest(BV_-PV_-ZAL9_,0); PVZ_:=greatest(BV_-PV_-REZ_,0);
            end if;
            BVq_  := gl.p_icurval ( k.KV, BV_  , DAT31_) ;
            PVq_  := gl.p_icurval ( k.KV, PV_  , DAT31_) ;
            PVZq_ := gl.p_icurval ( k.KV, PVZ_ , DAT31_) ;
            ZALq_ := gl.p_icurval ( k.KV, ZAL9_, DAT31_) ;
            REZQ_ := gl.p_icurval ( k.KV, REZ_ , DAT31_) ;

            If p_modeR = 1 then
               INSERT INTO TEST_MANY_CCK (RNK, ND , FIN, OBS, KAT ,K , KV, NLS, branch, vidd, sdate, wdate,R013, dat, id,
                  BV , PV , OBESP, PVZ , REZ , BVq, PVq,  ZALq, PVZq, REZq,SDI )
               VALUES
                 (D.RNK,-D.ND,D.FIN23,D.OBS23,D.KAT23,D.K23,KV_,k.NlS,d.branch,d.vidd, sdate_, d.wdate,k.R013,DAT01_, gl.auid,
                  BV_ /100, PV_ /100, ZAL9_/100, PVZ_ /100, REZ_ /100, BVq_/100, PVq_/100, ZALq_/100, PVZQ_/100, REZq_/100,SDI_/100);
            end if;

            If pvz_ > 0 and zal9_ >0 then Z_koef := pvz_/zal9_; --отношение PVZ(приведенный залог) / ZAL(ликвидный залог) в целом по КД
            else                          Z_koef := 0;
            end if;
            If p_modeZ in (0,1) THEN
               z23.pvz_pawn (p_dat01 => dat01_, p_kv   => k.kv, p_acc => k.acc, Z_koef => Z_koef,
                             p_pvz   => pvz_  , p_pvzq => pvzq_ ) ;
            end if;
            ---**** Запись внебалансовых сосставляющих 9129 в окончательный протокол NBU23_REZ   ******************************
            If p_modeZ = 1 then
               If  tmp.EXISTS(k.nbs) then DDD_:= tmp(k.nbs).ddd;
               else                       DDD_:= null;
               end if;
               begin
                  INSERT INTO NBU23_REZ
                     (ob22     ,tip     ,cc_id   ,branch   ,RNK      ,ND        ,FIN_R ,FIN    ,OBS     ,KAT    ,K       ,FDAT    ,
                      DDD      ,dd      ,acc     ,ID                 ,NBS       ,nls   ,KV     ,BV      ,PV     ,PVZ     ,REZ     ,
                      ZAL      ,BVq     ,PVq     ,PVZq     ,REZq     ,ZALq      ,r013  ,sdate  ,wdate   ,VKR)
                  values
                     (k.ob22   ,k.tip   ,d.cc_id ,d.branch ,d.RNK    ,d.ND      ,d.fin ,d.FIN23,d.OBS23 ,d.KAT23,d.K23   ,DAT01_  ,
                      DDD_     ,cust_   ,k.acc   ,id9_||k.acc        ,k.nbs     ,k.nls ,k.kv   ,bv_ /100,pv_/100,pvz_/100,rez_/100,
                      zal9_/100,bvq_/100,pvq_/100,pvzq_/100,rezq_/100,zalq_ /100,k.r013,sdate_ ,d.wdate ,VKR_ );
               exception when others then
                  --ORA-00001: unique constraint (BARS.PK_NBU23REZ_ID) violated
                  if SQLCODE = -00001 then
                     raise_application_error(-20000, 'NBU23_REZ dubl '|| to_char(DAT01_,'dd.mm.yyyy') || ' '|| id9_||k.acc );
                  else  raise;
                  end if;
               end;

            end if ;
            ---**********************************
         end loop;

      EXCEPTION WHEN NO_DATA_FOUND THEN  null;
      END;

      <<next8>> null;
      If kol_ > 500 then commit; kol_ := 0; end if ;

   END LOOP; -- d
   commit;

   if  p_modeZ = 1 THEN
       if p_nd = 0 THEN  z23.kontrol1  (p_dat01 =>DAT01_ , p_id =>'CCK%'                 );
       else              z23.kontrol1  (p_dat01 =>DAT01_ , p_id =>'CCK_/' || p_nd || '/%'  );
       end if;
   end if;
   z23.to_log_rez (user_id ,-4 , p_dat01 ,'Конец Кредиты '||p_nd);
   commit;
   logger.info ('REZ23 KOHEЦ CCK' || sysdate );

end tK_many;
------------------------

PROCEDURE deb_kat
( dat_   in date,
  mode_  in  int,
  modeZ_ IN  int,                -- :Z(SEM=Включ.в 1B=1/0,TYPE=N)
  ch_    in  int  DEFAULT 0
) is
/*
 Процедура расчета резерва по дебеторской задолженности.
   mode_=0 - финансовая дебиторка
   mode_=1 - хозяйственная дебиторка
*/

-- id23_  NBU23_REZ.ID%type;

-- p_pv    number ;
-- obesp_  number ; -- обеспечение
 DAT_V    date  ;
 DAT_P    date  ;
-------------------
 REZ_KAT_  NUMBER  DEFAULT 0;
-- rez_      number  ;
-- PV_       number  ;
-- BV_       number  ; -- -- бал.стоим
-- nls_      accounts.nls%type;  kv_   accounts.kv%type;
 K_        number;
 nbs_      varchar2(150);
---------------------

 type t_obs_ is record
     (
      acc     int,
      obs_old int,
      obs_new int,
      k       number,
      d_p     date,
      d_v     date,
      kol_p   int,
      kol_vz  int,
      serr    varchar2(100)
     );
 type t_mas_obs_ is table of t_obs_ index by binary_integer;
      ND_bad_ int;
      i int;
      j int;

 SP_ number; SL_ number; SPN_ number;SK9_ number;
 KOL_     int;
 KOL_1    int;
 KOL_2    int;
 KOL_3    int;
 KOL_4    int;
 KOL_V    int;
 KOL_VZ   int;
 FDAT_    date:= DAT_;
 OBS_     int;
 SUM_KOS  number;
 l_s180   number;
 mas_obs_ t_mas_obs_;
 TXT_     varchar2(100);
 sdat01_  char(10);

begin
   REZ_KAT_:=nvl(F_Get_Params('REZ_KAT', 0) ,0);
   dat01_ :=  dat_;
   sdat01_ := to_char( DAT01_,'dd.mm.yyyy');
   PUL_dat(sdat01_,'');

   IF DAT_ IS NULL THEN
      raise_application_error(-20000,'Укажiть звiтну дату !');
   END IF;

   logger.info ('REZ23 НАЧАЛО пар.DEB' || sysdate );

   if mode_=0 THEN
      If gl.amfo ='380764' THEN          nbs_  := '3570,3578,3579';
      else                               nbs_  := '1811,1819,2800,2801,2805,2806,2809,3540,3541,3548,3570,3578,3579,3710';
      end if;
      --  Счета 2805,2806 - не резервируются согласно гл.8 п.8.1 пост.23
   else
      If gl.amfo ='380764' THEN          nbs_  := '';
      else                               nbs_  := '3510,3519,3550,3551,3552,3559';
         --3552,3559 перенесены в финансовую 20.05.2013 вернули обратно в хоз. 01-10-2013
      end if;
   end if;

   --Sta удаление из общего протокола
   if nvl(modeZ_,0) =1 then ---        -- :Z(SEM=Включ.в 1B=1/0,TYPE=N)
      z23.CHEK_modi(dat01_ ) ;
      --logger.info('REZ23-1 rez_deb_,mode='|| mode_ || ' отч.дата DAT01_=' ||to_char(DAT01_,'dd.mm.yyyy' )) ;
   end if;

   Z23.di_snp;

   delete from ACC_DEB_23 where deb=mode_ or deb is null;

   -- определение категории качества и показателя риска.
   dat31_:= Dat_last_work (dat_-1);  -- последний рабочий день месяца
   for k in (select a.RNK  ,a.acc,a.daos sdate, a.KV,substr(a.nbs,1,3) n371, decode(substr(a.nbs,1,3),'371',
                    DAT19_ ,nvl(a.mdate,DAT19_ )) wdate, a.nls, a.nbs, a.tobo,nvl(d.kat,1) obs, s.s080, s.s180,
                    decode(substr(a.nbs,1,3),'371', to_char(null),
                          (select value from accountsw aw where tag='DATVZ' and aw.acc=a.acc)
                          ) d_vz,nvl(s.r011,'0') r011
             from  accounts a,ACC_DEB_23 d,SPECPARAM S
             where (a.dazs is null or a.dazs >=dat01_) and a.acc = d.acc (+) and
                    ost_korr(a.acc,dat31_,z23.di_,a.nbs)<0  and a.acc = s.acc (+) and
                    nbs_  like '%' || nbs || '%' and a.nbs is not null And ( a.tip <> 'XOZ'  or z23.XOZ_ != 1 )
             union all
             select a.RNK  ,a.acc,a.daos sdate, a.KV,substr(a.nbs,1,3) n371, decode(substr(a.nbs,1,3),'371',
                    DAT19_ ,nvl(a.mdate,DAT19_ )) wdate, a.nls,nvl(a.nbs,substr(a.nls,1,4)) nbs, a.tobo,nvl(d.kat,1) obs, s.s080, s.s180,
                    decode(substr(a.nbs,1,3),'371', to_char(null),
                          (select value from accountsw aw where tag='DATVZ' and aw.acc=a.acc)
                          ) d_vz,nvl(s.r011,'0') r011
             from  accounts a,ACC_DEB_23 d,SPECPARAM S
             where  a.acc in (select acc from
                   (select 'nl' tip, acc     ,ref from cp_deal union all
                    select 'd'     , accd    ,ref from cp_deal union all
                    select 'p'     , accp    ,ref from cp_deal union all
                    select 'r'     , accr    ,ref from cp_deal union all
                    select 's'     , accs    ,ref from cp_deal union all
                    select '2'     , accr2   ,ref from cp_deal union all
                    select 's5'    , accs5   ,ref from cp_deal union all
                    select '6'     , accs6   ,ref from cp_deal union all
                    select 'expn'  , accexpn ,ref from cp_deal union all
                    select 'expr'  , accexpr ,ref from cp_deal union all
                    select '3'     , accr3   ,ref from cp_deal union all
                    select 'unrec' ,accunrec ,ref from cp_deal ) c
                   ) and  substr(a.nls,1,4) = '3541' and  (a.dazs is null or a.dazs >=dat01_)
                     and a.acc = d.acc (+) and ost_korr(a.acc,dat31_,null,a.nbs)<0  and a.acc = s.acc (+)
            )
   LOOP

      KOL_  := null; KOL_VZ := null; obs_  := 1   ; k_     := 0   ;
      DAT_P := null; DAT_V  := null; TXT_  := ''  ;

      if (k.nbs in ('3578','3570')  and
         gl.amfo NOT IN ('353575','300120')) or -- кроме ДЕМАРК, ПЕТРОКОМЕРЦ -- счет начисленной деб задолж. считается не просроченным
         k.nbs in ('2805','2806')  THEN         -- Счета включаются в резерв, но резерв по ним не считается
         obs_:=1;
         k_  :=0;
      else
         if k.s080 is not null  THEN --and k.n371<>'371' THEN
            if    k.s080='1' THEN obs_:=1; k_:=0;
            ElsIf k.s080='2' then obs_:=2; k_:=0.2;
            ElsIf k.s080='3' then obs_:=3; k_:=0.5;
            ElsIf k.s080='4' then obs_:=4; k_:=0.8;
            Else                  obs_:=5; k_:=1;
            end if;
            TXT_:='S080='||k.s080;
         else

            if k.d_vz is not null and mode_=1 THEN
               if k.n371='371' THEN
                  DAT_V:= null ; -- нет даты визнання только по расчетной просрочке dat_next_u(k.d_vz,5);
                  -- TXT_ :=TXT_||' Дата визнан.+5 (3710)='||DAT_V;
               else
                  DAT_V:= TO_date(k.d_vz,'dd/mm/yyyy');  --k.d_vz;
                  TXT_ :=TXT_||' Дата визнан.='||k.d_vz;
               end if;
            end if;

            if k.wdate   <> DAT19_ THEN
               if k.wdate<  DAT01_ THEN
                  KOL_ := DAT01_- k.wdate;
                  DAT_P:= k.wdate;
               else
                  KOL_ := 0;
               end if;
               TXT_ :=TXT_||' Дата погаш.='||k.wdate;
            end if;
            if k.d_vz is null and k.wdate = DAT19_   THEN
               SP_ := -nvl(ost_korr(k.acc,dat31_,z23.di_,k.nbs),0) ;
               If SP_>0 THEN
                  -- УЗНАЕМ НА СКОЛЬКО ДНЕЙ ПРОСРОЧЕНО
                  KOL_:=0;
                  FDAT_:= DAT01_;

                  -- узнаем сумму всех кредитовых оборотов
                  select sum(s.kos)     into   SUM_KOS   from   saldoa s,accounts a
                  where  k.acc=s.acc and a.acc=k.acc and s.FDAT<=DAT31_ and     s.fdat>=k.sdate;

                   if mode_ = 1 THEN
                      If    k.s180 is null then l_s180 :=    0 ;
                      ElsIf k.s180 = '3'   then l_s180 :=    7 ;       -- Вiд   2 до 7 дня
                      ElsIf k.s180 = '4'   then l_s180 :=   21 ;       -- Вiд   8 до 21 дня
                      ElsIf k.s180 = '5'   then l_s180 :=   31 ;       -- Вiд  22 до 31 дня
                      ElsIf k.s180 = '6'   then l_s180 :=   92 ;       -- Вiд  32 до 92 днiв
                      ElsIf k.s180 = '7'   then l_s180 :=  183 ;       -- Вiд  93 до 183 днiв
                      ElsIf k.s180 = '8'   then l_s180 :=  365 ;       -- Вiд 184 до 365(366) днiв
                      ElsIf k.s180 = 'A'   then l_s180 :=  274 ;       -- Вiд 184 до 274 днiв
                      ElsIf k.s180 = 'B'   then l_s180 :=  365 ;       -- Вiд 275 до 365(366) днiв
                      ElsIf k.s180 = 'C'   then l_s180 :=  548 ;       -- Від 366(367) до 548(549) днiв
                      ElsIf k.s180 = 'D'   then l_s180 :=  730 ;       -- Від 549(550) днів до 2 років
                      ElsIf k.s180 = 'E'   then l_s180 := 1095 ;       -- Більше 2 до 3 років
                      ElsIf k.s180 = 'F'   then l_s180 := 1826 ;       -- Більше 3 до 5 років
                      ElsIf k.s180 = 'G'   then l_s180 := 3652 ;       -- Більше 5 до 10 років
                      Else                      l_s180 := 9999 ;       -- Понад 10 років
                      End if;
                   else
                      l_s180 := 0;
                   end if;

                  -- case введен из за  пост миграционных баз данный в которых остаток появляется без оборотов
                  for p in (select s.fdat,
                                sum((case when fdat=(select min(fdat) from saldoa where acc=a.acc) then greatest(-s.ostf,s.dos)
                                     else s.dos
                                     end)) DOS
                            from   saldoa s,accounts a
                            where  k.acc=s.acc and a.acc=k.acc and s.FDAT<=DAT31_ and s.fdat>=k.sdate
                            group by s.fdat
                            order by s.fdat
                          )
                  loop
                     SUM_KOS:= SUM_KOS - p.DOS;

                     If SUM_KOS < 0 THEN
                        if k.n371='371' THEN  DAT_P := dat_next_u(p.FDAT,5);
                        else                  DAT_P := greatest(p.FDAT,k.wdate);
                        end if;
                        KOL_ := greatest(0,DAT01_- (DAT_P+l_s180));
                        EXIT;
                     end if;
                  end loop;
               else   GOTO NEXTREC;
               end if;
            end if;
            if KOL_ is not null THEN
               -- просрочка
               If    KOL_<= 7  then OBS_:=1; k_:=0;
               ElsIf KOL_<=30  then OBS_:=2; k_:=0.2;
               ElsIf KOL_<=90  then OBS_:=3; k_:=0.5;
               ElsIf KOL_<=180 then OBS_:=4; k_:=0.8;
               Else                 OBS_:=5; k_:=1;
               end if;
            end if;
            if mode_= 1 THEN

               if dat_v is not null THEN
                  KOL_Vz:=dat01_-dat_v;

                  -- СБЕРБАНК ДНЕПРОПЕТРОВСКА уточнил дебіторську заборгованість за
                  -- капітальними вкладеннями 3510 (r011=1).

                  if k.nbs in ('3510') and k.r011='1' THEN
                     kol_1:=90; kol_2:=180; kol_3:=270; kol_4:=360;
                  else
                     kol_1:=30; kol_2:= 90; kol_3:=180; kol_4:=270;
                  end if;

                  If    KOL_Vz<=kol_1 then OBS_:=greatest(1,OBS_);
                  ElsIf KOL_Vz<=kol_2 then OBS_:=greatest(2,OBS_);
                  ElsIf KOL_Vz<=kol_3 then OBS_:=greatest(3,OBS_);
                  ElsIf KOL_Vz<=kol_4 then OBS_:=greatest(4,OBS_);
                  Else                    OBS_:=greatest(5,OBS_);
                  end if;

                  if    obs_=1 THEN k_:=0;
                  elsif obs_=2 THEN k_:=0.2;
                  elsif obs_=3 THEN k_:=0.5;
                  elsif obs_=4 THEN k_:=0.8;
                  else              k_:=1;
                  end if;
               end if;
            end if;
         end if;

      end if;

      mas_obs_(k.acc).acc    :=k.acc;
      mas_obs_(k.acc).obs_old:=k.obs;
      mas_obs_(k.acc).obs_new:=OBS_;
      mas_obs_(k.acc).k      :=k_;
      mas_obs_(k.acc).d_p    :=DAT_P;
      mas_obs_(k.acc).d_v    :=DAT_V;
      mas_obs_(k.acc).kol_p  :=kol_;
      mas_obs_(k.acc).kol_vz :=kol_vz;
      mas_obs_(k.acc).serr   :=txt_;
      <<NEXTREC>>  NULL;
   end loop;
   i:=mas_obs_.first;
   LOOP
   EXIT WHEN i IS NULL;
      update ACC_DEB_23 set kat   = mas_obs_(i).obs_new,k      = mas_obs_(i).k,
                            d_p   = mas_obs_(i).d_p    ,d_v    = mas_obs_(i).d_v,
                            kol_p = mas_obs_(i).kol_p  ,kol_vz = mas_obs_(i).kol_vz,
                            serr  = mas_obs_(i).serr   ,deb    = mode_
      where acc=i;
      if SQL%rowcount = 0 then
         INSERT  INTO ACC_DEB_23 (acc,kat,k,d_p,d_v,kol_p,kol_vz,serr,deb)
                          VALUES (i, mas_obs_(i).obs_new,mas_obs_(i).k,
                                     mas_obs_(i).d_p, mas_obs_(i).d_v,
                                     mas_obs_(i).kol_p,mas_obs_(i).kol_vz,
                                     mas_obs_(i).serr,mode_);
      end if;
      i:=mas_obs_.NEXT(i);
   end loop;
   logger.info ('REZ23 КОНЕЦ пар.DEB' || sysdate );
-----------------------------------------------------------------

END deb_kat;

PROCEDURE rez_deb_F
( dat_   in date,
  mode_  in  int,
  modeZ_ IN  int,                -- :Z(SEM=Включ.в 1B=1/0,TYPE=N)
  ch_    in  int  DEFAULT 0
) is

begin
   If ( getglobaloption('MFOP') = '300465' or gl.aMfo = '300465'      or gl.amfo ='300120' )  then   -- СБЕРБАНК + ПЕТРОКОММЕРЦ
      Z23.rez_deb_sb( dat_,mode_,modeZ_,ch_ );           -- :Z(SEM=Включ.в 1B=1/0,TYPE=N)
   else
      Z23.rez_deb   ( dat_,mode_,modeZ_ );               -- :Z(SEM=Включ.в 1B=1/0,TYPE=N)
   end if;
end rez_deb_F;
-------------------------

PROCEDURE rez_deb_SB
( dat_   in date,
  mode_  in  int,
  modeZ_ IN  int,                -- :Z(SEM=Включ.в 1B=1/0,TYPE=N)
  ch_    in  int  DEFAULT 0
) is
/*
 Процедура расчета резерва по дебеторской задолженности.
   mode_=0 - финансовая дебиторка
   mode_=1 - хозяйственная дебиторка
*/

 id23_  NBU23_REZ.ID%type;

 fl_           int := 0;
 l_ch          int ;
 i_            int ;
 REZ_KAT_      NUMBER  DEFAULT 0;
 rez_          number;
 rezq_         number;
 p_pv          number;
 p_pvq         number;
 p_bvq         number;
 l_acc         number;
 l_acc_rez     number;
 l_acc_rezn    number;
 l_acc_rez_30  number;
 l_rez39       number;
 l_rez_0       number;
 l_rezn        number;
 l_rez_30      number;
 l_rezq_0      number;
 l_rezqn       number;
 l_rezq_30     number;
 l_bv          number;
 l_bvn         number;
 l_bv_30       number;
 nbs_          varchar2(150);
 l_nbs         varchar2(4)  ;
 l_nbs_rez     varchar2(4)  ;
 l_nls_rez     varchar2(14) ;
 l_nls_rezn    varchar2(14) ;
 l_nls_rez_30  varchar2(14) ;
 l_ob22_rez    varchar2(2)  ;
 l_ob22_rezn   varchar2(2)  ;
 l_ob22_rez_30 varchar2(2)  ;
 l_ob22_r      varchar2(2)  ;

-------------------
 dat_dos   date;
 sdat01_   char(10);
 nm_       varchar2(4);

begin
   if mode_=0 THEN
      nm_:='DEBF';
   else
      nm_:='DEBH';
   end if;
   REZ_KAT_:=nvl(F_Get_Params('REZ_KAT', 0) ,0);
   dat01_ :=  dat_;
   dat31_:= Dat_last_work (dat01_-1);  -- последний рабочий день месяца
   sdat01_ := to_char( DAT01_,'dd.mm.yyyy');
   PUL_dat(sdat01_,'');
   l_ch := ch_;
   begin
      select 1 into fl_ from rez_protocol where dat= dat31_ and crc='1' and rownum=1;
      l_ch:=0;
   EXCEPTION WHEN NO_DATA_FOUND THEN fl_ := 0;
   end;
   IF modeZ_ = 0 THEN fl_ := 1; end if;
   z23.RNK_KAT(l_ch);

   IF DAT_ IS NULL THEN
      raise_application_error(-20000,'Укажiть звiтну дату !');
   END IF;

   logger.info ('REZ23 НАЧАЛО DEB' || sysdate );

   if mode_=0 THEN id23_ := 'DEBF';
      If gl.amfo ='380764' THEN          nbs_  := '3570,3578,3579';
      else                               nbs_  := '1811,1819,2800,2801,2805,2806,2809,3540,3541,3548,3570,3578,3579,3710';
      end if;
      --  Счета 2805,2806 - не резервируются согласно гл.8 п.8.1 пост.23
      delete from TEST_MANY_CCK_DF;
   else            id23_ := 'DEBH';
      If gl.amfo ='380764' THEN          nbs_  := '';
      else                               nbs_  := '3510,3519,3550,3551,3552,3559';
         --3552,3559 перенесены в финансовую 20.05.2013 вернули обратно в хоз. 01-10-2013
      end if;
      delete from TEST_MANY_CCK_DH;
   end if;

   --Sta удаление из общего протокола
   if nvl(modeZ_,0) =1 then ---        -- :Z(SEM=Включ.в 1B=1/0,TYPE=N)
      z23.CHEK_modi(dat01_ ) ;
      delete from NBU23_REZ where FDAT = dat_ and ID like id23_ || '%' ;
   end if;
   z23.to_log_rez (user_id , 2 , dat01_ ,'Начало rez_deb_SB-'||nm_);
   Z23.di_snp;

   -- определение категории качества и показателя риска.
   dat31_:= Dat_last_work (dat_-1);  -- последний рабочий день месяца

   -- сделать курсор по всем счетам

   begin
      for k in (select nvl(w.nd,a.acc) nd,a.RNK,a.acc ,a.mdate wdate,a.nls ,a.nbs ,a.kv  ,a.tobo,a.ob22,
                       nvl(d.k,1),a.branch, a.daos,d.k ,d.kat,serr  ,s.s180,s.r013,s.r011,c.okpo,
                       - ost_korr(a.acc,dat31_,z23.di_,a.nbs) p_bv,d_p ,d_v ,kol_p,kol_vz,
                       f_get_istval (0, a.acc, a.daos, a.kv) ISTVAL
                from   accounts a, acc_deb_23 d,specparam s,customer c,w4_acc w
                where a.acc = d.acc(+) and a.rnk=c.rnk and a.acc=w.acc_3570 (+) and nbs_ like '%' || nbs || '%'
                      and a.nbs  is  not null and a.acc=s.acc (+) And ( a.tip <> 'XOZ'  or z23.XOZ_ != 1 )
                      and (a.dazs is null  or dazs >= dat01_)
                      and  a.acc not in ( select accc from accounts
                                          where nbs is null and substr(nls,1,4)='3541' and accc is not null)
                union all
                select cp.ref nd,a.RNK,a.acc ,a.mdate wdate,a.nls ,nvl(a.nbs,substr(a.nls,1,4)) nbs ,a.kv  ,a.tobo,a.ob22,
                       nvl(d.k,1),a.branch, a.daos,d.k ,d.kat,serr  ,s.s180,s.r013,s.r011,c.okpo,
                       - ost_korr(a.acc,dat31_,null,a.nbs) p_bv,d_p ,d_v ,kol_p,kol_vz,
                       f_get_istval (0, a.acc, a.daos, a.kv) ISTVAL
                from   accounts a, acc_deb_23 d,specparam s,customer c,cp_deal cp
                where a.acc = d.acc(+) and a.rnk=c.rnk and a.acc=s.acc (+) and substr(nls,1,4)='3541'
                      and (a.dazs is null  or a.dazs >= dat01_) and a.acc in  (cp.accr,cp.acc) and mode_=0
                      and a.acc not in ( select accc from accounts where nbs is null and substr(nls,1,4)='3541'
                                         and accc is not null)
                )
      LOOP

         if k.p_bv>0 THEN
            dat_dos      := null;
            l_nls_rez    := null; l_ob22_rez    := null; l_acc_rez    := null ;
            l_nls_rezn   := null; l_ob22_rezn   := null; l_acc_rezn   := null ;
            l_nls_rez_30 := null; l_ob22_rez_30 := null; l_acc_rez_30 := null ;

            if fl_=1 THEN
               begin
                  select kat  , k  , bv    , pv , pvq  , rez  , rezq         , rez39       ,
                         rezq_0    , rez_0      , nls_rez     , ob22_rez     , acc_rez     , bv*100-nvl(bv_30,0)*100,
                         reznq     , rezn       , nls_rezn    , ob22_rezn    , acc_rezn    , decode(rez,rezn,bv*100,decode(rezn,0,0,bv*100-nvl(bv_30,0)*100)),
                         rezq_30   , rez_30     , nls_rez_30  , ob22_rez_30  , acc_rez_30  , decode(rez,rez_30,bv*100,nvl(bv_30,0)*100)
                    into k.kat, k.k, k.p_bv,p_pv, p_pvq, rez_ , rezq_        , l_rez39     ,
                         l_rezq_0  , l_rez_0    , l_nls_rez   , l_ob22_rez   , l_acc_rez   , l_bv,
                         l_rezqn   , l_rezn     , l_nls_rezn  , l_ob22_rezn  , l_acc_rezn  , l_bvn,
                         l_rezq_30 , l_rez_30   , l_nls_rez_30, l_ob22_rez_30, l_acc_rez_30, l_bv_30
                    from nbu23_rez where fdat=dat01_ and acc=k.acc;

               EXCEPTION WHEN NO_DATA_FOUND THEN
                  k.kat := 1; k.k := 0; rez_ := 0; rezq_ := 0;
                  p_pv  := k.p_bv/100;
                  p_pvq := gl.p_icurval(k.kv,k.p_bv,DAT31_)/100;

               end;
               if l_rez39 = rez_ THEN
                  k.serr := 'МСФЗ-'||k.serr;
               else
                  k.serr := '23..-'||k.serr;
               end if;

            else
               if k.nbs in ('2805','2806') THEN -- Счета включаются в резерв, но резерв по ним не считается
                  k.k  := k.k;
                  k.kat:= k.kat;
               else
                  if REZ_KAT_=1 THEN -- единая категория качества
                     k.k  := f_rnk_kat_k(k.rnk,k.kat,k.k,4,k.istval);
                     k.kat:= f_rnk_kat_k(k.rnk,k.kat,k.k,3,k.istval);
                  end if;
               end if;
               p_pv  := round(k.p_bv/100*(1-k.k),2);
               rez_  := round(k.p_bv/100*k.k,2);
               rez_  := greatest (rez_ , 0 );
               p_pv  := k.p_bv/100 - rez_;
               p_pvq := gl.p_icurval(k.kv,p_pv*100,DAT31_)/100;
               rezq_ := gl.p_icurval(k.kv,rez_*100,DAT31_)/100;
            end if;

            p_bvq :=  gl.p_icurval(k.kv,k.p_bv,DAT31_)/100;
            if k.nd is not null and k.nbs='3570'  THEN
               select f_get_date_3570(f_get_date_dos(k.acc)) INTO dat_dos from dual;
               k.wdate := dat_dos;
            end if;
            i_ := 1;
            l_nbs := substr(k.nls,1,4);
            while  i_<4
            loop
               if mode_ = 0 and fl_ = 1  THEN
                  if    i_=1 THEN l_ob22_r := l_ob22_rez   ; rez_     := l_rez_0 ; rezq_ := l_rezq_0 ; l_acc := l_acc_rez   ;
                                  k.p_bv   := l_bv         ; l_nbs_rez:= substr(l_nls_rez,1,4 );
                  elsif i_=2 THEN l_ob22_r := l_ob22_rezn  ; rez_     := l_rezn  ; rezq_ := l_rezqn  ; l_acc := l_acc_rezn  ;
                                  k.p_bv   := l_bvn        ; l_nbs_rez:= substr(l_nls_rezn,1,4);
                  elsif i_=3 THEN l_ob22_r := l_ob22_rez_30; rez_     := l_rez_30; rezq_ := l_rezq_30; l_acc := l_acc_rez_30;
                                  k.p_bv   := l_bv_30      ; l_nbs_rez:= substr(l_nls_rez_30,1,4);
                  end if;
                  p_bvq :=  gl.p_icurval(k.kv,k.p_bv,DAT31_)/100;
                  begin
                     select r013 into k.r013 from specparam where acc = l_acc;
                  EXCEPTION WHEN NO_DATA_FOUND THEN k.r013 := null;
                  end;
               end if;

               if mode_ = 0 and fl_ <> 1 and i_ = 1  THEN
                  if k.p_bv <> 0 THEN
                     insert into TEST_MANY_CCK_DF
                            (nd    , nbs  , pv     , pvq   , branch  , vidd   , sdate   , wdate  , bv        ,
                             bvq   , d_v  , d_p    , RNK   , k       , nls    , kv      , s180   , r011      ,
                             rez   , rezq , id     , dat   , kat     , kol_p  , kol_vz  , serr   , ob22      ,
                             okpo  , r013 )
                     values (k.acc , l_nbs, p_pv   , p_pvq , k.branch, 9      , k.daos  , k.wdate, k.p_bv/100,
                             p_bvq , k.d_v, k.d_p  , k.rnk , k.k     , k.nls  , k.kv    , k.s180 , k.r011    ,
                             REz_  , rezq_, gl.auid, dat_  , k.kat   , k.kol_p, k.kol_vz, k.serr , k.ob22    ,
                             k.okpo, k.r013);
                  end if;
               elsif mode_ = 0 and fl_ = 1 and i_ = 1 and l_rez_0+l_rezn+l_rez_30 =0 THEN
                  if k.p_bv <> 0 THEN
                     insert into TEST_MANY_CCK_DF
                            (nd    , nbs  , pv     , pvq  , branch  , vidd   , sdate   , wdate  , bv  ,
                             bvq   , d_v  , d_p    , RNK  , k       , nls    , kv      , s180   , r011,
                             rez   , rezq , id     , dat  , kat     , kol_p  , kol_vz  , serr   , ob22,
                             okpo  , r013 )
                     values (k.acc , l_nbs, p_pv   , p_pvq, k.branch, 9      , k.daos  , k.wdate, k.p_bv/100,
                             p_bvq , k.d_v, k.d_p  , k.rnk, k.k     , k.nls  , k.kv    , k.s180 , k.r011    ,
                             REz_  , rezq_, gl.auid, dat_ , k.kat   , k.kol_p, k.kol_vz, k.serr , k.ob22    ,
                             k.okpo, k.r013);
                  end if;
               elsif mode_ = 0 and fl_ = 1  and rez_<>0 THEN
                  if k.p_bv <> 0 THEN
                     insert into TEST_MANY_CCK_DF
                            (nd    , nbs   , pv       , pvq     , branch  , vidd    , sdate   , wdate  , bv  ,
                             bvq   , d_v   , d_p      , RNK     , k       , nls     , kv      , s180   , r011,
                             rez   , rezq  , id       , dat     , kat     , kol_p   , kol_vz  , serr   , ob22,
                             okpo  , r013  , nbs_rez  , ob22_rez)
                     values (k.acc , l_nbs , p_pv     , p_pvq   , k.branch, 9       , k.daos  , k.wdate, k.p_bv/100,
                             p_bvq , k.d_v , k.d_p    , k.rnk   , k.k     , k.nls   , k.kv    , k.s180 , k.r011    ,
                             REz_  , rezq_ , gl.auid  , dat_    , k.kat   , k.kol_p , k.kol_vz, k.serr , k.ob22    ,
                             k.okpo, k.r013, l_nbs_rez, l_ob22_r );
                  end if;
               elsif mode_ = 1 and i_ = 1 THEN
                  if fl_=1 THEN
                     k.p_bv := k.p_bv * 100;
                     p_bvq  :=  gl.p_icurval(k.kv,k.p_bv,DAT31_)/100;
                  end if;
                  --logger.info('DEBH_23 : acc   = ' || k.acc ) ;
                  --logger.info('DEBH_23 : i     = ' || i_    ) ;
                  insert into TEST_MANY_CCK_DH
                         (nd   ,nbs               ,pv  ,pvq  ,branch  ,vidd,sdate ,wdate  ,bv        ,bvq   ,d_v   ,d_p   ,RNK   ,k  ,
                          nls  ,kv  ,s180  ,r011  ,rez ,rezq ,id      ,dat ,kat   ,kol_p  ,kol_vz    ,serr  ,ob22  ,okpo  ,r013)
                  values (k.acc,substr(k.nls,1,4) ,p_pv,p_pvq,k.branch,9   ,k.daos,k.wdate,k.p_bv/100,p_bvq ,k.d_v ,k.d_p ,k.rnk ,k.k,
                          k.nls,k.kv,k.s180,k.r011,rez_,rezq_,gl.auid ,dat_,k.kat ,k.kol_p,k.kol_vz  ,k.serr,k.ob22,k.okpo,k.r013);
               end if;
               i_ := i_+1;
            end loop;

         end if;
      END LOOP;

      -- STA вставить в общ проtокол -- :Z(SEM=Включ.в 1B=1/0,TYPE=N)

      if nvl(modeZ_,0) =1 and mode_ = 0 then
         --07.Протокол BV по фин.дебитор.задолж.
         INSERT INTO NBU23_REZ (FDAT,ID            ,branch,sdate,wdate,nls,RNK,acc,NBS            ,KV,ND,KAT,K,BV,PV,REZ,
                                PVZ ,PVZq,BVq,PVq  ,REZq  ,s180 ,r011,r013)
         SELECT                 DAT_,id23_||ND||kat,branch,sdate,wdate,nls,RNK,nd ,substr(NLS,1,4),KV,ND,KAT,K,BV,PV,REZ,
                                0   ,0   ,bvq,pvq  ,rezq  ,s180 ,r011,r013
         FROM TEST_MANY_CCK_DF;
      Elsif nvl(modeZ_,0) =1 and mode_ = 1 then
         INSERT INTO NBU23_REZ (FDAT,ID            ,branch,sdate,wdate,nls,RNK,acc,NBS            ,KV,ND,KAT,K,BV,PV,REZ,
                                PVZ ,PVZq,BVq,PVq  ,REZq  ,s180 ,r013 )
         SELECT                 DAT_,id23_||ND||kat,branch,sdate,wdate,nls,RNK,nd ,substr(NLS,1,4),KV,ND,KAT,K,BV,PV,REZ,
                                0   ,0   ,bvq,pvq  ,rezq  ,s180 ,r013
         FROM TEST_MANY_CCK_DH;
      end if;
      commit;

      if nvl(modeZ_,0) =1  THEN
         z23.kontrol1  (p_dat01 =>DAT_ , p_id =>id23_||'%' );
         commit;
      end if;
      z23.to_log_rez (user_id ,-2 , dat01_ ,'Конец rez_deb_SB-'||nm_);
      logger.info ('REZ23 КОНЕЦ DEB' || sysdate );
   end;
END rez_deb_SB;
------------------------------------

PROCEDURE rez_deb
( dat_   in date,
  mode_  in  int,
  modeZ_ IN  int                -- :Z(SEM=Включ.в 1B=1/0,TYPE=N)
) is
/*
 Процедура расчета резерва по дебеторской задолженности.
   mode_=0 - финансовая дебиторка
   mode_=1 - хозяйственная дебиторка
*/
 id23_  NBU23_REZ.ID%type;
 p_pv    number ;
 obesp_  number ; -- обеспечение
 DAT_V    date   ;
--------------------
 rez_   number  ;
 PV_    number  ;
 BV_    number  ; -- -- бал.стоим
 nls_   accounts.nls%type;  kv_   accounts.kv%type;
 K_     number;
 nbs_   varchar2(150);
---------------------
 type t_obs_ is record   (  acc     int,
                            obs_old int,
                            obs_new int,
                            k       number,
                            rnk     number );
 type t_mas_obs_ is table of t_obs_ index by binary_integer;
      ND_bad_ int;
      i int;
      j int;

 SP_ number; SL_ number; SPN_ number;SK9_ number;
 KOL_  int  ;
 KOL_1 int  ;
 KOL_2 int  ;
 KOL_3 int  ;
 KOL_4 int  ;
 KOL_V int  ;
 r011_ varchar(1);
 FDAT_ date := DAT_; OBS_ int;
 SUM_KOS number;
 mas_obs_ t_mas_obs_;

begin

 dat01_ := nvl( dat_, to_date('01-02-2013','dd-mm-yyyy'));

 Z23.di_snp;
 dbms_output.put_line('-3 Начало ');

    if mode_=0 THEN id23_ := 'DEBF';
       If gl.amfo ='380764' THEN          nbs_ := '3570,3578,3579';    -- НАДРА
       else                               nbs_ := '1811,1819,2800,2801,2805,2806,2809,3540,3541,3548,3570,3578,3579,3710';
       end if;
       --  Счета 2805,2806 - не резервируются согласно гл.8 п.8.1 пост.23, но включаются в отчет
       delete from TEST_MANY_CCK_DF;
    else
       id23_ := 'DEBH';
       If    gl.amfo ='380764' THEN    nbs_  := '' ;                  -- НАДРА
       elsif gl.amfo ='300205' THEN    nbs_  := '' ;                  -- УПБ (Хоз отдельный модуль)
       else                            nbs_  := '3510,3519,3550,3551,3552,3559';
       end if;
       delete from TEST_MANY_CCK_DH;
    end if;

 --Sta удаление из общего протокола
 if nvl(modeZ_,0) =1 then ---        -- :Z(SEM=Включ.в 1B=1/0,TYPE=N)
    z23.CHEK_modi(dat01_ ) ;
    delete from NBU23_REZ where FDAT = dat01_ and ID like id23_ || '%' ;
 end if;

 if gl.amfo ='353575'  THEN   --ДЕМАРК
    delete from ACC_DEB_23 where dat=dat01_;
 end if;

 -- определение категории качества и показателя риска.
 select Dat_last_work (dat01_-1) into dat31_ from dual; -- последний рабочий день месяца

 for k in (select a.RNK,a.ACC, a.daos sdate , nvl(a.mdate, DAT19_ ) wdate,
                  a.nls,a.KV , a.NBS, a.tobo, d.kat obs
           from  accounts a,ACC_DEB_23 d
           where a.acc = d.acc (+)
             and   nbs_ like '%' || nbs || '%'
             and a.nbs is not null
             And ( a.tip <> 'XOZ'  or z23.XOZ_ != 1 )
            )

 LOOP
    if (k.nbs in ('3578','3570') and
       gl.amfo NOT IN ('353575','300120')) or   -- кроме ДЕМАРК, ПЕТРОКОМЕРЦ
       k.nbs in ('2805','2806')  THEN           -- Счета включаются в резерв, но резерв по ним не считается
       obs_:= 1 ;  k_  :=0;
    else
       obs_:= 1 ;  -- изначально присваиваем хорошее
       --узнать тек остаток
       SP_ := - nvl(ost_korr(k.acc,dat31_,z23.di_,k.NBS), 0);

       If SP_>0 THEN
          -- УЗНАЕМ НА СКОЛЬКО ДНЕЙ ПРОСРОЧЕНО
          KOL_:=0 ; FDAT_:= DAT31_;
-- НАДО З КОРР !!!
          -- узнаем сумму всех кредитовых оборотов
          select nvl(sum(s.kos),0) into SUM_KOS
          from   saldoa s
          where  k.acc=s.acc and s.FDAT<=DAT31_ and s.fdat>=k.sdate;

          -- case введен из за  пост миграционных баз данный в которых остаток появляется без оборотов
          for p in (select s.fdat,
                           nvl(sum(
                               (case when fdat=(select min(fdat) from saldoa ss where acc=s.acc) then greatest(-s.ostf,s.dos)
                                                 else  s.dos
                                            end )
                                ),0) DOS
                    from  saldoa s
                    where k.acc = s.acc and s.FDAT<DAT31_ and s.fdat>=k.sdate
                    group by s.fdat
                    order by s.fdat
                    )
          loop
             SUM_KOS:= SUM_KOS - p.DOS;
             -- -10  для устранения погрешности возник из за использования нац валюты
             If SUM_KOS < 0 THEN -- or DAT31_- p.FDAT > 180 then

                if gl.amfo ='353575'  THEN  KOL_  := DAT31_ - p.FDAT;                  --ДЕМАРК
                else                        KOL_  := DAT31_ - greatest(p.FDAT,k.wdate);
                end if;

                DAT_V := p.fdat ;
                EXIT;
             end if;
          end loop;

          -- просрочка была и раньше
          If    KOL_<= 7  then OBS_:=1; k_:=0   ;   ElsIf KOL_<=30  then OBS_:=2; k_:=0.2;
          ElsIf KOL_<=90  then OBS_:=3; k_:=0.5 ;   ElsIf KOL_<=180 then OBS_:=4; k_:=0.8;
          Else                 OBS_:=5; k_:=1   ;
          end if;
       else
          GOTO NEXTREC;
       end if ;  --- SP_>0

    end if; -- k.nbs in ('3578','3570')

    if mode_  = 1 THEN          KOL_V := dat31_ - dat_v;
       begin
          select nvl(r011,'0') into r011_ from specparam where acc=k.acc;
       EXCEPTION WHEN NO_DATA_FOUND THEN  r011_ := '0';
       end;
       -- СБЕРБАНК ДНЕПРОПЕТРОВСКА уточнил дебіторську заборгованість за
       -- капітальними вкладеннями 3510 (r011=1).
       if k.nbs in ('3510') and r011_='1' THEN
          kol_1:=90; kol_2:=180; kol_3:=270; kol_4:=360;
       else
          kol_1:=30; kol_2:= 90; kol_3:=180; kol_4:=270;
       end if;

       If    KOL_V <= kol_1 then OBS_ := greatest(1,OBS_) ;  ElsIf KOL_V <= kol_2 then OBS_ := greatest(2,OBS_) ;
       ElsIf KOL_V <= kol_3 then OBS_ := greatest(3,OBS_) ;  ElsIf KOL_V <= kol_4 then OBS_ := greatest(4,OBS_) ;
       Else                      OBS_ := greatest(5,OBS_) ;
       end if;

       if    obs_ = 1 THEN k_:=0  ;   elsif obs_ = 2 THEN k_:=0.2;
       elsif obs_ = 3 THEN k_:=0.5;   elsif obs_ = 4 THEN k_:=0.8;
       else                k_:=1   ;
       end if;

    end if;

    mas_obs_(k.acc).acc     := k.acc;
    mas_obs_(k.acc).obs_old := k.obs;
    mas_obs_(k.acc).obs_new := OBS_;
    mas_obs_(k.acc).k       := k_;
    mas_obs_(k.acc).rnk     := k.rnk;

  <<NEXTREC>>  NULL;

 end loop;

 i := mas_obs_.first ;
 LOOP  EXIT WHEN i IS NULL;
    if gl.amfo = '353575' and mode_=0 THEN
       begin
          select greatest(mas_obs_(i).obs_new,nvl(max(kat),0))
            into obs_ from ACC_DEB_23
           where rnk = mas_obs_(i).rnk and dat=dat01_ ; --and acc=i; убрала, т.к. надо мах по РНК
       EXCEPTION WHEN NO_DATA_FOUND THEN  obs_:=1;
       end;

       if    obs_ = 1 THEN k_:=0  ;   elsif obs_ = 2 THEN k_:=0.2;
       elsif obs_ = 3 THEN k_:=0.5;   elsif obs_ = 4 THEN k_:=0.8;
       else                k_:=1   ;
       end if;

       update ACC_DEB_23 set kat = obs_, k = k_, dat = dat01_,rnk = mas_obs_(i).rnk,deb=mode_
       where acc = i;
       if SQL%rowcount = 0 then
          INSERT  INTO ACC_DEB_23 (acc,rnk,dat,kat,k,deb)
                           VALUES (i, mas_obs_(i).rnk,dat01_,obs_,k_,mode_);
       end if;

       update ACC_DEB_23 set kat = obs_, k = k_
       where rnk = mas_obs_(i).rnk and dat=dat01_ ;

    else
       update ACC_DEB_23 set kat=mas_obs_(i).obs_new,k=mas_obs_(i).k,
                             dat = dat01_,rnk = mas_obs_(i).rnk,deb=mode_
       where acc=i;
       if SQL%rowcount = 0 then
          INSERT  INTO ACC_DEB_23 (acc,kat,k,rnk,dat,deb)
                           VALUES (i, mas_obs_(i).obs_new,mas_obs_(i).k,
                                   mas_obs_(i).rnk,dat01_,mode_);
       end if;
    end if;
    i:=mas_obs_.NEXT(i);
 end loop;
-----------------------------------------------------------------
 -- сделать курсор по всем счетам

 for k in (select a.RNK,a.acc,a.mdate wdate,a.nls,a.nbs,a.kv,a.tobo,
                  nvl(d.k,1),a.branch,a.daos,d.k,d.kat,   nvl(-ost_korr(a.acc,dat31_,z23.di_,a.nbs),0) p_bv
           from   accounts a, acc_deb_23 d
           where  a.acc = d.acc(+)
             and    nbs_  like '%' || nbs || '%'
             and  a.nbs is not null
             And (a.tip <> 'XOZ'  or z23.XOZ_ != 1 )
          )
 LOOP
    p_pv := round(k.p_bv/100*(1-k.k),2);   rez_ := k.p_bv/100-p_pv;
    rez_ := greatest (rez_ , 0 );
     if k.p_bv > 0 THEN
       if mode_=0 THEN
          insert into TEST_MANY_CCK_DF
                 (nd   ,nbs              ,pv  ,branch  ,vidd,sdate ,wdate  ,bv        ,bvq,
                  RNK  ,k  ,nls  ,kv     ,rez ,rezq                                   ,id      ,dat  ,kat  )
          values (k.acc,substr(k.nls,1,4),p_pv,k.branch,9   ,k.daos,k.wdate,k.p_bv/100,gl.p_icurval(k.kv,k.p_bv,DAT31_)/100,
                  k.rnk,k.k,k.nls,k.kv   ,rez_,gl.p_icurval(k.kv,rez_*100,DAT31_)/100 ,gl.auid ,dat_ ,k.kat) ;
       else
          insert into TEST_MANY_CCK_DH
                 (nd   ,nbs              ,pv  ,branch  ,vidd,sdate ,wdate  ,bv        ,bvq,
                  RNK  ,k  ,nls  ,kv     ,rez ,rezq                                   ,id      ,dat  ,kat  )
          values (k.acc,substr(k.nls,1,4),p_pv,k.branch,9   ,k.daos,k.wdate,k.p_bv/100,gl.p_icurval(k.kv,k.p_bv,DAT31_)/100,
                  k.rnk,k.k,k.nls,k.kv   ,rez_,gl.p_icurval(k.kv,rez_*100,DAT31_)/100 ,gl.auid ,dat_ ,k.kat) ;
       end if;
    end if;
 END LOOP;

 -- STA вставить в общ проtокол -- :Z(SEM=Включ.в 1B=1/0,TYPE=N)
 if nvl(modeZ_,0) =1 and mode_ = 0 then

    --07.Протокол BV по фин.дебитор.задолж.

    INSERT INTO NBU23_REZ (FDAT,ID,branch,sdate,wdate,nls,RNK,acc,NBS,KV,ND,FIN,OBS,KAT,K,BV,PV,REZ,
                           PVZ,PVZq,BVq,PVq,REZq)
    SELECT DAT01_,id23_||ND||kat,branch, sdate,wdate,nls,RNK,nd,substr(NLS,1,4),KV,ND, FIN,OBS,KAT,K,BV,PV,REZ,
                           0, 0,
                           gl.p_icurval(kv, bv*100,dat31_)/100,
                           gl.p_icurval(kv, pv*100,dat31_)/100,
                           gl.p_icurval(kv, rez*100,dat31_)/100
    FROM TEST_MANY_CCK_DF;

 Elsif modeZ_ =1 and mode_ = 1 then

    INSERT INTO NBU23_REZ (FDAT,ID,branch,sdate,wdate,nls,RNK,acc,NBS,KV,ND,FIN,OBS,KAT,K,BV,PV,REZ,
                           PVZ,PVZq,BVq,PVq,REZq)
    SELECT DAT01_,id23_||ND||kat,branch, sdate,wdate,nls,RNK, nd, substr(NLS,1,4),KV,ND, FIN,OBS,KAT,K,BV,PV,REZ,
                           0, 0,
                           gl.p_icurval(kv, bv*100,dat31_)/100,
                           gl.p_icurval(kv, pv*100,dat31_)/100,
                           gl.p_icurval(kv, rez*100,dat31_)/100
    FROM TEST_MANY_CCK_DH;

 end if;
 commit;

 if nvl(modeZ_,0) =1  THEN
    z23.kontrol1  (p_dat01 =>DAT_ , p_id =>id23_||'%' );
    commit;
 end if;

END rez_deb;
--------------------------

PROCEDURE PUL_DAT_OVR (
  S_DAT01 IN  VARCHAR2, --:s(SEM=Зв_дата_01,TYPE=s)
  p_modeZ IN  int,                -- :Z(SEM=Включ.в 1B=1/0,TYPE=N)
  ch_     in  int  DEFAULT 0
  ) is
---------------------- ДЛЯ овердрафтов
  nls_  varchar2(15);  nbs_ char(4) ; id23_ NBU23_REZ.id%type ;  aa accounts%rowtype ;  ss specparam%rowtype ;

  k_       number ; -- коэф.риска
  REZ_KAT_ number ;
  SDI_     number ;
  istval_  SPECPARAM.ISTVAL%type;
  fin_     nbu23_rez.fin_r%type;
  dd_      number ;
  vkr_     varchar2(3);

  B2_     number; aa2  accounts%rowtype ; z2_ number;  v2_ number ;  r2_ number ; bv_     number; bv_sna  number;
  B8_     number; aa8  accounts%rowtype ; z8_ number;  v8_ number ;  r8_ number ; pv2_    number; pv8_    number;
  b9_     number; aa9  accounts%rowtype ; z9_ number;  v9_ number ;  r9_ number ;
  l_SNA2  number; sna_ accounts%rowtype ;
  l_SNA8  number;


BEGIN

 IF trim(s_DAT01) IS NULL THEN  raise_application_error(-20000,'Укажiть звiтну дату !'); END IF;

 dat01_ := to_date( s_dat01,'dd.mm.yyyy');
 If nvl(p_modeZ,0) = 1 then z23.CHEK_modi(dat01_) ; end if;
 z23.to_log_rez (user_id , 5 , dat01_ ,'Начало ОВЕРДРАФТЫ ');
 ---------------------------------------------
 PUL_DAT( s_DAT01, '');
 select Dat_last_work (dat01_-1) into dat31_ from dual;  -- последний рабочий день месяца
 Z23.DI_SNP;
 z23.RNK_KAT(ch_);
 --Справочник - в массив

 tmp.DELETE;
 for k in (select r020, ddd, r012 from kl_f3_29 where kf='1B')
 loop
    tmp(k.r020).ddd := k.ddd ;
 end loop;
 REZ_KAT_:=nvl(F_Get_Params('REZ_KAT', 0) ,0);
 -------------------------------
 If gl.amfo ='380764' THEN
    EXECUTE IMMEDIATE 'delete from TEST_MANY_OVR';
 else
    EXECUTE IMMEDIATE 'truncate table TEST_MANY_OVR';
 end if;

 If nvl(p_modeZ,0) = 1 then
   delete from NBU23_REZ where id like 'OVER%' and fdat = dat01_;
 end if;

 for k in (select * from acc_over )
 loop
    --logger.info('SNA 0 : nd = ' || k.nd  ) ;
    vkr_ := cck_app.get_nd_txt(k.nd, 'VNCRR') ;
    If k.datd is null then
       begin
          select datd into k.datd from acc_over where nd = k.nd and datd is not null;
       EXCEPTION WHEN NO_DATA_FOUND THEN  k.datd := NULL;
       end;
    end if;

    fin_ := null;
    B2_  := 0;  B8_ := 0;  b9_ :=0;  z2_ :=0; z8_ :=0 ; z9_ :=0 ; r2_ := 0; r8_:= 0; v2_:=0 ; v8_:= 0; SDI_:=0; bv_SNA := 0;

    select * into aa2 from accounts where acc= k.acco;
    aa2.tip := f_get_tip (aa2.nbs, aa2.tip);

    begin
       select nvl(istval,0) into istval_ from specparam where k.acco = acc;
    EXCEPTION WHEN NO_DATA_FOUND THEN istval_ := 0;
    end;

    b2_  := - least ( ost_korr(aa2.acc, dat31_, z23.di_, aa2.nbs ), 0) ;

    if aa2.kv = 980 THEN
       istval_ := 1;
    end if;

    if REZ_KAT_=1 THEN
       k.k23  := f_rnk_kat_k(aa2.rnk,k.kat23,k.k23,2,istval_);
       k.kat23:= f_rnk_kat_k(aa2.rnk,k.kat23,k.k23,1,istval_);
    end if;

    begin
       if gl.amfo ='353575' THEN  -- ДЕМАРК
          select * into aa8 from accounts
          where acc = (select acra from int_accn where id=0 and acc=aa2.acc);
       else
          select * into aa8 from accounts
          where acc = (select acra from int_accn where id=0 and acc=aa2.acc) and nbs not like '8%' ;
       end if;
       aa8.tip := f_get_tip (aa8.nbs, aa8.tip);
       b8_     := -  least ( ost_korr(aa8.acc, dat31_, z23.di_, aa8.nbs ) , 0 ) ;

    EXCEPTION WHEN NO_DATA_FOUND THEN b8_ :=0 ; aa8.acc := -8;
    end;

    begin
       select a.* into sna_ from nd_acc n,accounts a where nd = k.nd and n.acc=a.acc and a.tip='SNA';
       bv_sna  :=  ost_korr(sna_.acc, dat31_, z23.di_, sna_.nbs ) ;
       --select ost_korr(a.acc, dat31_, z23.di_, a.nbs ) into bv_SNA from nd_acc n,accounts a where nd = k.nd and n.acc=a.acc and a.tip='SNA';
    --logger.info('SNA 0 : nd = ' || k.nd  || ' bv_sna = '|| bv_sna ) ;
    EXCEPTION WHEN NO_DATA_FOUND THEN bv_SNA :=0 ;
    end;

    SELECT nvl(SUM(s),0) into z2_ FROM tmp_rez_obesp23 WHERE dat=dat01_ AND accs = aa2.acc;
    SELECT nvl(SUM(s),0) into z8_ FROM tmp_rez_obesp23 WHERE dat=dat01_ AND accs = aa8.acc;

    --logger.info('SNA 1 : nd = ' || k.nd || ' b2_ = '|| b2_ || ' b8_ = '|| b8_  ) ;

    BV_  := greatest(B2_ + B8_ - BV_SNA , 0);

    --logger.info('SNA 2 : nd = ' || k.nd  || ' bv_ = '|| bv_  ) ;
    PV_  := round   ( (BV_) * (1-k.k23) , 0) ;
    REZ_ := GREATEST( (BV_) * k.k23 - (z2_+z8_), 0) ;

    PVZ_ := GREATEST( (BV_) * k.k23 - REZ_ ,0);
    --logger.info('SNA 3 : nd = ' || k.nd || ' rez_ = '|| rez_  || ' bv_ = '|| bv_ || ' bv_sna = '|| bv_sna ) ;


    if b2_ + b8_ >0 then
       r2_    := REZ_   * b2_ / (B2_+B8_);
       r8_    := REZ_   - r2_ ;
       v2_    := PVZ_   * b2_ / (B2_+B8_);
       v8_    := PVZ_   - v2_ ;
       pv2_  :=  PV_   * b2_ / (B2_+B8_);
       pv8_  :=  PV_ - pv2_;
       l_SNA2 := bv_SNA * b2_ / (B2_+B8_);
       l_SNA8 := bv_SNA - l_SNA2 ;
    end if;

    --logger.info('SNA 4 : nd = ' || k.nd || ' l_sna2 = '|| round(l_sna2/100,2) || ' l_sna8 = '|| round(l_sna8,2) ) ;
    --logger.info('SNA 44 : nd = ' || k.nd || ' r2_ = '|| round(r2_/100,2) || ' r8_ = '|| round(r8_,2) ) ;
    --основной счет

    if b2_ > 0 then
       begin
          select crisk,custtype into fin_,dd_ from customer  where rnk=aa2.RNK;
       EXCEPTION WHEN NO_DATA_FOUND THEN fin_ := null; dd_:=null;
       end;

       id23_ := 'OVER'||k.ND||aa2.acc;
       bvq_  := gl.p_icurval( aa2.kv, b2_, dat31_) ;
       rezq_ := gl.p_icurval( aa2.kv, r2_, dat31_) ;

       if tmp.EXISTS(aa2.nbs) then ddd_  := tmp(aa2.nbs).ddd;
       else                        ddd_  := null;
       end if;
       if not (gl.amfo ='353575' and aa2.nbs like '22%')  THEN  -- ДЕМАРК
          begin
             INSERT INTO TEST_MANY_OVR
                    (cc_id  , branch  , RNK    , ND  , FIN    , KAT    , OBS    , K    , FDAT  , acc    , id   , NBS    , nls    , KV    ,
                     BV     , PV      , BVQ    , REZ , rezq   , zal    , DDD    )
             values (k.ndoc , aa2.tobo, aa2.RNK, k.ND, k.FIN23, k.KAT23, k.OBS23, k.K23, DAT01_, aa2.acc, id23_, aa2.nbs, aa2.nls, aa2.kv,
                     round(B2_/100,2) , round(PV2_ /100,2)    , round(bvq_/100,2)      ,
                     round(r2_/100,2) , round(rezq_/100,2)    , round(z2_ /100,2)      , ddd_  );
          exception when others then
                --ORA-00001: unique constraint (BARS.PK_NBU23REZ_ID) violated
                if SQLCODE = -00001 then
                   raise_application_error(-20000, 'TEST_MANY_OVR dubl '|| to_char(DAT01_,'dd.mm.yyyy') || ' '|| id23_ );
                else raise;
                end if;
          end;
            If nvl(p_modeZ,0) = 1 then
             begin
                INSERT INTO NBU23_REZ
                       (cc_id  , branch  , RNK    , ND  , FIN_R, FIN    , KAT    , OBS    , K    , FDAT  , acc    , ob22    , tip    , id   , NBS  , nls, KV,
                        diskont, BV      , PV     , BVQ , REZ  , rezq   , zal    , DD     , DDD  , PVq   , ZALq   , pvz     , pvzq   , sdate, wdate,vkr)
                values (k.ndoc , aa2.tobo, aa2.RNK, k.ND, fin_ , k.FIN23, k.KAT23, k.OBS23, k.K23, DAT01_, aa2.acc, aa2.ob22, aa2.tip, id23_,
                        aa2.nbs, aa2.nls , aa2.kv ,
                        round(l_SNA2/100,2),
                        round(B2_/100,2),
                        round(PV2_/100,2),
                        round(bvq_/100,2),
                        round(r2_/100,2),
                        round(rezq_/100, 2),
                        round(z2_/100,2),dd_    ,ddd_ ,
                        round(gl.p_icurval(aa2.kv,PV2_,dat31_)/100,2),
                        round(gl.p_icurval(aa2.kv, z2_,dat31_)/100,2),
                        round(v2_/100,2),
                        round(gl.p_icurval( aa2.kv,v2_,dat31_)/100, 2),k.datd,k.datd2,vkr_
                        );
             exception when others then
                --ORA-00001: unique constraint (BARS.PK_NBU23REZ_ID) violated
                if SQLCODE = -00001 then
                   raise_application_error(-20000, 'NBU23_REZ dubl '|| to_char(DAT01_,'dd.mm.yyyy') || ' '|| id23_ );
                else raise;
                end if;
             end;
          End if;
       end if;
    end if;

   if bv_sna > 0 then
       begin
          select crisk,custtype into fin_,dd_ from customer  where rnk=aa2.RNK;
       EXCEPTION WHEN NO_DATA_FOUND THEN fin_ := null; dd_:=null;
       end;

       id23_ := 'OVER'||k.ND||sna_.acc;
       bvq_  := gl.p_icurval( aa2.kv, bv_sna, dat31_) ;
       rezq_ := 0;

       if tmp.EXISTS(aa2.nbs) then ddd_  := tmp(aa2.nbs).ddd;
       else                        ddd_  := null;
       end if;
       if not (gl.amfo ='353575' and aa2.nbs like '22%')  THEN  -- ДЕМАРК
          begin
             INSERT INTO TEST_MANY_OVR
                    (cc_id   , branch   , RNK     , ND  , FIN    , KAT    , OBS       , K    , FDAT        , acc     , id   , NBS     ,
                     nls     , KV       , BV                     , PV                 , BVQ                , REZ     , rezq , zal     , DDD  )
             values (k.ndoc  , sna_.tobo, sna_.RNK, k.ND, k.FIN23, k.KAT23, k.OBS23   , k.K23, DAT01_      , sna_.acc, id23_, sna_.nbs,
                     sna_.nls,sna_.kv   , round(-Bv_sna/100,2)   ,round(-Bv_sna/100,2), round(-bvq_/100, 2), 0       , 0    , 0       , ddd_ );
          exception when others then
                --ORA-00001: unique constraint (BARS.PK_NBU23REZ_ID) violated
                if SQLCODE = -00001 then NULL;
                   --raise_application_error(-20000, 'TEST_MANY_OVR dubl '|| to_char(DAT01_,'dd.mm.yyyy') || ' '|| id23_ );
                else raise;
                end if;
          end;
            If nvl(p_modeZ,0) = 1 then
             begin
                INSERT INTO NBU23_REZ
                       (cc_id               , branch              , RNK               , ND      , FIN_R  , FIN     , KAT     , OBS    , K                 ,
                        FDAT                , acc                 , ob22              , tip     , id     , NBS     , nls     , KV     , diskont           ,
                        BV                  , PV                  , BVQ               , REZ     , rezq   , zal     , DD      , DDD    , PVq               ,
                        ZALq                , pvz                 , pvzq              , sdate   , wdate  , vkr     )
                values (k.ndoc              , sna_.tobo           , sna_.RNK          , k.ND    , fin_   , k.FIN23 , k.KAT23 , k.OBS23, k.K23             ,
                        DAT01_              , sna_.acc            , sna_.ob22         , sna_.tip, id23_  , sna_.nbs, sna_.nls, sna_.kv, 0                 ,
                        round(-Bv_sna/100,2), round(-Bv_sna/100,2), round(-bvq_/100,2), 0       , 0      , 0       , dd_     , ddd_   , round(-bvq_/100,2),
                        0                   , 0                   , 0                 , k.datd  , k.datd2, vkr_    );
             exception when others then
                --ORA-00001: unique constraint (BARS.PK_NBU23REZ_ID) violated
                if SQLCODE = -00001 then NULL;
                   -- raise_application_error(-20000, 'NBU23_REZ dubl '|| to_char(DAT01_,'dd.mm.yyyy') || ' '|| id23_ );
                else raise;
                end if;
             end;
          End if;
       end if;
    end if;

    -- нач проц
    if b8_ > 0 then

       begin
         select crisk,custtype into fin_,dd_ from customer  where rnk=aa8.RNK;
       EXCEPTION WHEN NO_DATA_FOUND THEN fin_:=null; dd_:=null;
       end;

       id23_ := 'OVER8'||k.ND||aa8.acc;
       bvq_  := gl.p_icurval( aa8.kv, b8_, dat31_) ;
       rezq_ := gl.p_icurval( aa8.kv, r8_, dat31_) ;
       if tmp.EXISTS(aa8.nbs) then ddd_  := tmp(aa8.nbs).ddd;
       else                        ddd_  := null;
       end if;

       if not (gl.amfo ='353575' and aa8.nbs like '22%')  THEN  -- ДЕМАРК (у них 2203 находится и в OVER и в кредитах)
          begin
             INSERT   INTO TEST_MANY_OVR
                    ( cc_id  , branch   , RNK    , ND  , FIN    , KAT    , OBS    , K    , FDAT  , acc    , id   , NBS    , nls    , KV    ,
                      BV     , PV       , BVQ    , REZ , rezq   , zal    , DDD    )
             values ( k.ndoc , aa8.tobo , aa8.RNK, k.ND, k.FIN23, k.KAT23, k.OBS23, k.K23, DAT01_, aa8.acc, id23_, aa8.nbs, aa8.nls, aa8.kv,
                      round(B8_  /100,2), round(PV8_ /100,2)    , round(bvq_ /100,2),
                      round(r8_  /100,2), round(rezq_/100,2)    , round(z8_  /100,2),ddd_);
          exception when others then
              --ORA-00001: unique constraint (BARS.PK_NBU23REZ_ID) violated
              if SQLCODE in (-20000,-00001) then  logger.info ( 'TEST_MANY_OVR '|| to_char(DAT01_,'dd.mm.yyyy') || ' ' || id23_);
              else raise;
              end if;
          end;
          If nvl(p_modeZ,0) = 1 then
             begin

                INSERT INTO NBU23_REZ
                       (cc_id   , branch  , RNK    , ND     , FIN_R  , FIN    , KAT    , OBS    , K    , FDAT  ,    acc , diskont,
                        ob22    , tip     , id     , NBS    , nls    , KV     , BV     , PV     , BVQ  , REZ   ,    rezq,
                        zal     , DD      , DDD    , PVq    , ZALq   , pvz    , pvzq   , sdate  , wdate, VKR   )
                values (k.ndoc  , aa8.tobo, aa8.RNK, k.ND   , fin_   , k.FIN23, k.KAT23, k.OBS23, k.K23, DAT01_, aa8.acc, round(l_SNA8/100,2) ,
                        aa8.ob22, aa8.tip , id23_  , aa8.nbs, aa8.nls, aa8.kv ,
                        round(B8_  /100,2),
                        round(PV8_ /100,2),
                        round(bvq_ /100,2),
                        round(r8_  /100,2),
                        round(rezq_/100,2),
                        round(z8_  /100,2), dd_, ddd_ ,
                        round(gl.p_icurval( aa2.kv, PV8_, dat31_)/100, 2),
                        round(gl.p_icurval( aa2.kv, z8_ , dat31_)/100, 2),
                        round(v8_/100,2),
                        round(gl.p_icurval( aa2.kv, v8_            , dat31_)/100, 2),
                        k.datd, k.datd2, vkr_
                       );

             exception when others then
                --ORA-00001: unique constraint (BARS.PK_NBU23REZ_ID) violated
                if SQLCODE = -00001 then  logger.info ( 'NBU23_REZ dubl '|| to_char(DAT01_,'dd.mm.yyyy') || ' ' || id23_);
                else raise;
                end if;
             end;
          End if;
       end if;
    end if;

    --леваки 2069 из мешка
    for l in (select * from accounts where acc in (select acc from nd_acc where nd=k.nd) and nbs='2069' and acc<>aa8.acc)
    loop
       l.tip := f_get_tip (l.nbs, l.tip);
       b8_ := - ost_korr(l.acc, dat31_, z23.di_, l.nbs ) ;
       If b8_ > 0 then

          begin
             select crisk,custtype into fin_,dd_ from customer  where rnk=l.RNK;
          EXCEPTION WHEN NO_DATA_FOUND THEN fin_:=null;dd_:=null;
          end;

          r8_   := B8_ * k.k23 ;
          id23_ := 'OVER8'||k.ND||l.acc;
          bvq_  := gl.p_icurval( l.kv, b8_, dat31_) ;
          rezq_ := gl.p_icurval( l.kv, r8_, dat31_) ;

          if tmp.EXISTS(l.nbs) then ddd_  := tmp(l.nbs).ddd;
          else                      ddd_  := null;
          end if;
          begin
             INSERT INTO TEST_MANY_OVR
                    (cc_id ,branch,RNK  ,ND  ,FIN    ,KAT    ,OBS    ,K    ,FDAT  ,acc  ,id   ,NBS  ,nls  ,KV  ,
                     BV    ,PV    ,BVQ  ,REZ ,rezq   ,zal    ,DDD )
             values (k.ndoc,l.tobo,l.RNK,k.ND,k.FIN23,k.KAT23,k.OBS23,k.K23,DAT01_,l.acc,id23_,l.nbs,l.nls,l.kv,
                     round(B8_/100,2),
                     round(B8_*(1-k.k23)/100, 2),
                     round(bvq_/100,2),
                     round(r8_/100,2),
                     round(rezq_/100,2), 0,ddd_);
          exception when others then
                    --ORA-00001: unique constraint (BARS.PK_NBU23REZ_ID) violated
                    if SQLCODE = -00001 then  logger.info ( 'NBU23_REZ dubl '|| to_char(DAT01_,'dd.mm.yyyy') || ' ' || id23_);
                    else raise;
                    end if;
          end;
          If nvl(p_modeZ,0) = 1 then
             begin
                INSERT INTO NBU23_REZ
                       (cc_id, branch, RNK, ND , FIN_R, FIN, KAT , OBS  , K    , FDAT, acc  ,
                        ob22 , tip   , id , NBS, nls  , KV , BV  , PV   , BVQ  , REZ , rezq ,
                        zal  , DD    , DDD, PVq, ZALq , pvz, pvzq, sdate, wdate, VKR)
                values (k.ndoc,l.tobo,l.RNK,k.ND ,fin_ ,k.FIN23,k.KAT23,k.OBS23,k.K23,DAT01_,
                        l.acc,l.ob22,l.tip , id23_ ,l.nbs ,l.nls,l.kv ,
                        round(B8_/100,2),
                        round(B8_ * (1-k.k23) /100  , 2),
                        round(bvq_/100,2),
                        round(r8_/100,2),
                        round(rezq_ /100,2), 0, dd_, ddd_,
                        round(gl.p_icurval( l.kv, B8_ * (1-k.k23), dat31_)/100, 2), 0, 0,0,k.datd,k.datd2,vkr_ );
             exception when others then
               --ORA-00001: unique constraint (BARS.PK_NBU23REZ_ID) violated
               if SQLCODE = -00001 then  logger.info ( 'NBU23_REZ dubl '|| to_char(DAT01_,'dd.mm.yyyy') || ' ' || id23_);
               else raise;
               end if;
             end;
          end if;
       end if;
    end loop;  -- леваки 2069 из мешка

    -- 9129
    If k.acc_9129 is not null then
       SDI_:=0;
       if gl.amfo ='353575' THEN  -- Для ДЕМАРК
          begin
             select ost_korr(s.acc, dat31_, z23.di_, s.nbs ) into SDI_
             from int_accn i,accounts s,accounts a
             where i.acc=a.acc and i.acra=s.acc and id=2
                   and a.acc=aa2.acc and s.nbs=3600;
          EXCEPTION WHEN NO_DATA_FOUND THEN SDI_ := 0;
          end;
       END IF;

       select * into aa9 from accounts where acc= k.acc_9129;
       b9_  := - ost_korr(aa9.acc, dat31_, z23.di_, aa9.nbs ) ;
       if b9_ > 0 then   id23_ := 'OVER'||k.ND||aa9.acc;  bvq_ := gl.p_icurval( aa9.kv, b9_, dat31_) ;
          begin
            select crisk,custtype into fin_,dd_ from customer  where rnk=aa9.RNK;
          EXCEPTION WHEN NO_DATA_FOUND THEN fin_:=null;dd_:=null;
          end;

          if tmp.EXISTS(aa9.nbs) then ddd_  := tmp(aa9.nbs).ddd;
          else                        ddd_  := null;
          end if;
          begin
            select * into ss  from specparam  where acc = aa9.acc;
          EXCEPTION WHEN NO_DATA_FOUND THEN ss.r013 := '0';
          end;
          pv_ := round(B9_*(1-k.k23)+SDI_,0);
          SELECT nvl(SUM(s),0) into z9_ FROM tmp_rez_obesp23 WHERE dat=dat01_ AND accs=aa9.acc;

          If ss.r013 = '9' then
             REZ_  := 0 ;
             REZq_ := 0 ;
             v9_   := 0 ;
          else
             rez_  := GREATEST( (b9_*k.k23 -z9_ - SDI_),0);
             rezq_ := gl.p_icurval( aa2.kv, REZ_, dat31_) ;
             v9_   := GREATEST( (b9_*k.k23 -rez_),0);
          end if;
          begin
             INSERT INTO TEST_MANY_OVR
                    (cc_id ,branch  ,RNK    ,ND  ,FIN    ,KAT    ,OBS    ,K    ,FDAT  ,acc    ,id   ,NBS    , nls    ,KV    ,
                     BV    ,PV      ,BVQ    ,REZ ,rezq   ,zal    ,DDD )
             values (k.ndoc,aa9.tobo,aa9.RNK,k.ND,k.FIN23,k.KAT23,k.OBS23,k.K23,DAT01_,aa9.acc,id23_,aa9.nbs, aa9.nls,aa9.kv,
                     round(B9_/100 ,2),
                     round(pv_/100,  2),
                     round(bvq_/100, 2),
                     round(rez_/100,2),
                     round(rezq_/100,2),
                     round(z9_/100 , 2), ddd_    );
          exception when others then
                    --ORA-00001: unique constraint (BARS.PK_NBU23REZ_ID) violated
                    if SQLCODE = -00001 then  logger.info ( 'NBU23_REZ dubl '|| to_char(DAT01_,'dd.mm.yyyy') || ' ' || id23_);
                    else raise;
                    end if;
          end;

          If nvl(p_modeZ,0) = 1 then
             begin
               INSERT INTO NBU23_REZ
                      (cc_id, branch, RNK, ND , FIN_R, FIN, KAT , OBS  , K    , FDAT, acc ,
                       ob22 , tip   , id , NBS, nls  , KV , BV  , PV   , BVQ  , REZ , rezq,
                       zal  , DD    , DDD, PVq, ZALq , pvz, pvzq, sdate, wdate, VKR)
               values (k.ndoc,aa9.tobo,aa9.RNK,k.ND  ,fin_ ,k.FIN23,k.KAT23,k.OBS23,k.K23 ,
                       DAT01_,aa9.acc,aa9.ob22,aa9.tip,id23_ ,aa9.nbs ,aa9.nls,aa9.kv,
                       round(B9_/100 ,2),
                       round(pv_/100,  2),
                       round(bvq_/100, 2),
                       round(rez_/100,2),
                       round(rezq_/100,2),
                       round(z9_/100 , 2), dd_ , ddd_ ,
                       round(gl.p_icurval( aa2.kv, pv_, dat31_)/100, 2),
                       round(gl.p_icurval( aa2.kv, z9_, dat31_)/100, 2),
                       round(v9_/100,2),
                       round(gl.p_icurval( aa2.kv, v9_, dat31_)/100, 2),k.datd,k.datd2,vkr_ );
             exception when others then
                --ORA-00001: unique constraint (BARS.PK_NBU23REZ_ID) violated
                if SQLCODE = -00001 then
                raise_application_error(-20000, 'NBU23_REZ dubl '|| to_char(DAT01_,'dd.mm.yyyy') || ' '|| id23_ );
                else raise;
                end if;
             end;
          end if;
       end if;
    end if;
 end loop; -- d
 commit;

 if nvl(p_modeZ,0) =1  THEN
    z23.kontrol1  (p_dat01 =>DAT01_ , p_id => 'OVER%' );
    commit;
 end if;

 z23.to_log_rez (user_id ,-5 , dat01_ ,'Конец ОВЕРДРАФТЫ ');

 return;

end PUL_DAT_OVR;
-------------------------

PROCEDURE PUL_DAT_BPK (
  S_DAT01 IN  VARCHAR2, --:s(SEM=Зв_дата_01,TYPE=s)
  p_modeZ IN  int,       -- :Z(SEM=Включ.в 1B=1/0,TYPE=N)
  ch_     in  int  DEFAULT 0
  ) is

 k_        number ;
 kat_      number ;
 rez_      number ;
 REZQ_     NUMBER ;
 PV_       number ;
 PVQ_      number ;
 BV_       number ; -- -- бал.стоим
 BVQ_      NUMBER ;
 ZAL_      NUMBER ;
 ZALQ      NUMBER ;
 PVZ_      NUMBER ;
 PVZQ_     NUMBER ;
 Z_koef    NUMBER ;
 rez_kat_  NUMBER ;
 p_2401    number ;
 VKR_      varchar2(10);  -- внутренний кредитный рейтинг
 nls_      accounts.nls%type;
 rnk_      accounts.rnk%type;
 kv_       accounts.kv%type;
 tobo_     accounts.tobo%type;
 nbs_      accounts.nbs%type;
 r013_     specparam.r013%type;
 dat31_    date;

BEGIN
 IF trim(s_DAT01) IS NULL THEN
    raise_application_error(-20000,'Укажiть звiтну дату !');
 END IF;

 PUL_DAT( s_DAT01, '');
 dat01_ := to_date( s_dat01,'dd.mm.yyyy');
 ---------------------------------------------
 Z23.di_snp;
 PUL_dat(s_dat01,'');


 If nvl(p_modeZ,0) = 1 then
    z23.CHEK_modi(dat01_) ;
    delete from NBU23_REZ where ( id like 'BPK%' or id like 'W4%' ) and fdat = dat01_;
 end if;
 z23.to_log_rez (user_id , 6 , dat01_ ,'Начало резерв БПК ');
 z23.RNK_KAT(ch_);
 dat31_ := Dat_last_work(dat01_-1);  -- последний рабочий день месяца
 delete from v_rez_bpk;
 rez_KAT_ := NVL (F_Get_Params ('REZ_KAT', 0), 0);

 for k in ( select acc_2207 ACC,fin23,obs23,kat23,k23,'BPK' BPK,nd, null sdate,s250,grp,nvl(kol_sp,0) kol_sp
            from v_bbpk_acc where acc_2207 is not null
            union all
            select acc_2209,fin23,obs23,kat23,k23,'BPK' BPK,nd, null sdate,s250,grp,nvl(kol_sp,0) kol_sp
            from v_bbpk_acc where acc_2209 is not null
            union all
            select acc_2208,fin23,obs23,kat23,k23,'BPK' BPK,nd, null sdate,s250,grp,nvl(kol_sp,0) kol_sp
            from V_bbpk_acc where acc_2208 is not null
            union all
            select ACC_OVR,fin23,obs23,kat23,k23,'BPK' BPK,nd, null sdate,s250,grp,nvl(kol_sp,0) kol_sp
            from V_bbpk_acc where acc_OVR is not null
            union all
            select ACC_9129,fin23,obs23,kat23,k23,'BPK' BPK,nd, null sdate,s250,grp,nvl(kol_sp,0) kol_sp
            from V_bbpk_acc where acc_9129 is not null
            union all
            select ACC_PK,fin23,obs23,kat23,k23,'BPK' BPK,nd, null sdate,s250,grp,nvl(kol_sp,0) kol_sp
            from V_bbpk_acc  where acc_PK is not null
            union all
            select acc_2207,fin23,obs23,kat23,k23,'W4' BPK,nd, dat_begin sdate,s250,grp,nvl(kol_sp,0) kol_sp
            from V_w4_acc where acc_2207 is not null
            union all
            select acc_2209,fin23,obs23,kat23,k23,'W4' BPK,nd, dat_begin sdate,s250,grp,nvl(kol_sp,0) kol_sp
            from V_w4_acc where acc_2209 is not null
            union all
            select acc_2208,fin23,obs23,kat23,k23,'W4' BPK,nd, dat_begin sdate,s250,grp,nvl(kol_sp,0) kol_sp
            from V_w4_acc where acc_2208 is not null
            union all
            select nvl(ACC_OVR,acc_2203),fin23,obs23,kat23,k23,'W4' BPK,nd, dat_begin sdate,s250,grp,nvl(kol_sp,0) kol_sp
            from V_w4_acc where nvl(ACC_OVR,acc_2203) is not null
            union all
            select ACC_2627,fin23,obs23,kat23,k23,'W4' BPK,nd, dat_begin sdate,s250,grp,nvl(kol_sp,0) kol_sp
            from V_w4_acc where acc_2627 is not null
            union all
            select ACC_9129,fin23,obs23,kat23,k23,'W4' BPK,nd, dat_begin sdate,s250,grp,nvl(kol_sp,0) kol_sp
            from V_w4_acc where acc_9129 is not null
            union all
            select ACC_PK,fin23,obs23,kat23,k23,'W4' BPK,nd, dat_begin sdate,s250,grp,nvl(kol_sp,0) kol_sp
            from v_w4_acc  where acc_PK is not null
            union all -- мобільні заощадження
            select ACC_2625D,fin23,obs23,kat23,k23,'W4' BPK,nd, dat_begin sdate,s250,grp,nvl(kol_sp,0) kol_sp
            from v_w4_acc  where acc_2625D is not null
            union all -- Несанкционированный оердрафт - просрочка
            select ACC_2627X,fin23,obs23,kat23,k23,'W4' BPK,nd, dat_begin sdate,s250,grp,nvl(kol_sp,0) kol_sp
            from v_w4_acc  where ACC_2627X is not null
            )
 LOOP
    ZAL_ := 0;
    ZALQ_:= 0;
    PVZ_ := 0;
    PVZQ_:= 0;
    begin
       select value into VKR_ from BPK_PARAMETERS b,CCK_RATING R
       where nd=k.nd and tag='VNCRR' and TRIM(substr(b.value,1,3))=r.CODE;
    EXCEPTION WHEN NO_DATA_FOUND THEN VKR_ := NULL;
    end;
    if k.s250  = '8' THEN

       p_2401 := 1;
       If    k.kol_sp <=  7  then k.kat23 :=1; k.k23 := 0.02;
       ElsIf k.kol_sp <= 30  then k.kat23 :=2; k.k23 := 0.10;
       ElsIf k.kol_sp <= 90  then k.kat23 :=3; k.k23 := 0.40;
       ElsIf k.kol_sp <=180  then k.kat23 :=4; k.k23 := 0.80;
       Else                       k.kat23 :=5; k.k23 := 1;
       end if;
       if k.bpk='W4' THEN
          update w4_acc  set kat23=k.kat23,k23=k.k23 where nd=k.nd;
       else
          update bpk_acc set kat23=k.kat23,k23=k.k23 where nd=k.nd;
       end if;

    else
       p_2401 := 0;

    end if;
    begin

       select DECODE (rez_KAT_,1, f_rnk_kat_k (a.rnk, k.kat23,k.k23,decode(p_2401,1,5,1),f_get_istval(0,k.acc,k.sdate,a.kv)),k.kat23),
              DECODE (rez_KAT_,1, f_rnk_kat_k (a.rnk, k.kat23,k.k23,decode(p_2401,1,6,2),f_get_istval(0,k.acc,k.sdate,a.kv)),k.k23),
              -ost_korr (a.acc, dat31_, z23.di,'2') / 100,a.nbs,a.tobo,a.rnk,a.nls,a.kv
         INTO kat_,k_,bv_,nbs_,tobo_,rnk_,nls_,kv_
         from accounts a
        where a.acc=k.acc ;

    EXCEPTION WHEN NO_DATA_FOUND THEN kat_ := k.kat23; k_ := k.k23; nls_ := NULL; bv_ := 0;
    end ;
    if bv_ > 0 and nbs_ not in ('3551','3550') THEN
       if p_2401 = 1 THEN
          ZAL_  := 0 ;
       else
          SELECT nvl(ROUND(SUM(s)/100,2),0) into ZAL_ FROM tmp_rez_obesp23 WHERE dat = dat01_ AND accs = k.acc;
       end if;

       if nbs_='9129' THEN
          begin
             select r013 into r013_ from specparam where acc=k.acc;
          EXCEPTION WHEN NO_DATA_FOUND THEN r013_:= 1 ;
          end;
       end if;

       PV_  := ROUND (bv_ * (1 - k_), 2);

       if nbs_='9129' and r013_='9' THEN pv_ := BV_; rez_:= 0;
       else    rez_:=GREATEST(ROUND (bv_ - pv_, 2) - zal_, 0);
       end if;

       pvq_  := gl.p_icurval( kv_, pv_ *100, dat31_)/100;
       zalq_ := gl.p_icurval( kv_, zal_*100, dat31_)/100;
       PVZ_  := greatest    ( BV_ - PV_ - REZ_,0)       ;
       PVZQ_ := GL.P_ICURVAL( KV_, PVZ_*100, DAT31_)/100;
       BVQ_  := GL.P_ICURVAL( KV_, BV_ *100, DAT31_)/100;
       REZQ_ := GL.P_ICURVAL( KV_, REZ_*100, DAT31_)/100;

       If pvz_ > 0 and zal_ >0 then   Z_koef := pvz_/zal_;   -- отношение PVZ(приведенный залог) / ZAL(ликвидный залог) в целом по КД
       else                           Z_koef := 0;
       end if;

       z23.pvz_pawn (p_dat01 => dat01_, p_kv   => kv_, p_acc => k.acc, Z_koef => Z_koef,
                     p_pvz   => pvz_  , p_pvzq => pvzq_ ) ;

       begin
          select ddd into ddd_ from kl_f3_29 where kf='1B' and r020=nbs_;
       EXCEPTION WHEN NO_DATA_FOUND THEN ddd_:='000';
       end;

       insert into v_rez_bpk (FDAT   ,TOBO   ,BPK  ,RNK ,ND  ,KV ,NBS ,ACC  ,NLS , FIN    ,OBS    ,KAT  ,K   ,BV  ,PV ,REZ ,BVQ  ,PVQ ,
                              REZQ   ,ZAL    ,ZALq )
                      values (dat01_ ,tobo_  ,k.bpk,RNK_,k.nd,kv_,nbs_,k.acc,nls_, k.FIN23,k.obs23,KAT_ ,K_  ,BV_ ,PV_,rez_,BVQ_ ,PVQ_,
                              rezQ_  ,pvz_   ,pvzq_);
       If nvl(p_modeZ,0) = 1 then

          INSERT INTO NBU23_REZ (id                ,branch ,RNK  ,ND  ,FIN     ,obs    ,KAT ,K    , FDAT  ,acc  ,NBS  ,nls   , KV  ,BV  ,PV ,
                                 REZ  ,BVQ ,rezq   ,DD                    ,DDD ,PVq    ,ZAL ,ZALq , pvz   ,pvzq ,s250                       ,
                                 grp  ,vkr ,kol_sp)
                         values (k.BPK||k.nd||k.acc,tobo_  ,RNK_ ,k.nd,k.FIN23 ,k.obs23,KAT_,K_   , DAT01_,k.acc,nbs_ ,nls_  , kv_ ,BV_ ,PV_,
                                 rez_ ,bvq_,rezq_  ,decode(ddd_,'122',2,3),ddd_,pvq_   ,zal_,ZALq_, zal_  ,zalq_,decode(p_2401,1,'8',null)  ,
                                 k.grp,vkr_,nvl(k.kol_sp,0)) ;

       end if;
    end if;
 END LOOP;

 logger.info('REZ23-4  rez_BPK КОНЕЦ    = '||sysdate);
 z23.kontrol1  (p_dat01 =>DAT01_ , p_id => 'BPK%'  );
 commit;
 z23.kontrol1  (p_dat01 =>DAT01_ , p_id => 'W4%'  );
 z23.to_log_rez (user_id , -6 , dat01_ ,'Конец резерв БПК ');
 commit;

end PUL_DAT_BPK;

---------------------------------
PROCEDURE PUL_DAT_9
( S_DAT01 IN  VARCHAR2, --:s(SEM=Зв_дата_01,TYPE=s)
  p_modeZ IN  int,                -- :Z(SEM=Включ.в 1B=1/0,TYPE=N)
  ch_     in  int  DEFAULT 0
 ) is

  Z_koef number ; -- отношение PVZ(приведенный залог) / ZAL(ликвидный залог) в целом по КД.
                  -- Использую при делении PVZ по ВИДАМ залога PAWN внутри одного счета

begin
--РАЗНЫЕ внебалансы
 IF trim(s_DAT01) IS NULL THEN
    raise_application_error(-20000,'Укажiть звiтну дату !');
 END IF;

 PUL_DAT( s_DAT01, '');

 IF NVL(p_modeZ,0) <> 1
    THEN RETURN;
 END IF;

 dat01_ := to_date( s_dat01,'dd.mm.yyyy');

 logger.info('REZ23-9  PUL_DAT_9, отч.дата = '||to_date(dat01_,'dd-mm-yyyy') );
 ---------------------------------------------
 --Sta ДЛЯ общего протокола

 Z23.di_snp;
 z23.RNK_KAT(ch_);
 If nvl(p_modeZ,0) = 1 then z23.CHEK_modi(dat01_) ; end if;
 z23.to_log_rez (user_id , 10, dat01_ ,'Начало резерв внебалансы ');
 dat31_ := Dat_last_work ( dat01_ - 1);   -- последний рабочий день месяца

 delete from NBU23_REZ where  id like '9%' and fdat = dat01_;

 for k in (SELECT ND      , nd acc, null cc_id, branch, nls, rnk, kv, fin, obs, kat, k, sdate, wdate, nbs, BV, PV, ZAL, 0 SDI, REZ, 0 PVZ,
                  '0' r013, DECODE (kv, 980, 1, istval) istval, vkr from V_rez_9000
           union all
           SELECT ND      ,    acc,      cc_id, branch, nls, rnk, kv, fin, obs, kat, k, sdate, wdate, nbs, BV, PV, ZAL,   SDI, REZ, 0 PVZ,
                      r013, DECODE (kv, 980, 1, nvl(istval,0)) istval, vkr from V_rez_9020
           union all
           SELECT ND      , nd acc, null cc_id, branch, nls, rnk, kv, fin, obs, kat, k, sdate, wdate, nbs, BV, PV, ZAL,   SDI, REZ, 0 PVZ,
                      r013, DECODE (kv, 980, 1, istval) istval, vkr from V_rez_9129
          )
 loop

    if nvl(F_Get_Params ('REZ_KAT', 0),0) = 1 THEN
       k.k   := f_rnk_kat_k(k.rnk,k.kat,k.k,2,k.istval);
       k.kat := f_rnk_kat_k(k.rnk,k.kat,k.k,1,k.istval);
    end if;

    if k.nbs=9023 and k.r013='1' or k.nbs='9129' and k.r013='9' THEN
       k.pv  := k.BV;
       k.rez := 0;
    else
       k.pv  := ROUND (k.BV * (1 - k.k), 2)+k.SDI;
       k.rez := GREATEST(ROUND ((k.bv * k.k) - k.zal - k.sdi, 2),0);
    end if;

    k.pvz:=least(greatest(k.BV-k.PV-k.REZ,0),k.zal);

    if k.SDI<>0 THEN
       k.pv:=greatest(k.bv-k.pvz-k.rez,0);
    end if;

    rezq_ := gl.p_icurval( k.kv, k.rez * 100, dat31_)/100 ;
    bvq_  := gl.p_icurval( k.kv, k.bv  * 100, dat31_)/100 ;
    pvzq_ := gl.p_icurval( k.kv, k.pvz * 100, dat31_)/100 ;
    zalq_ := gl.p_icurval( k.kv, k.zal * 100, dat31_)/100 ;
    pvq_  := gl.p_icurval( k.kv, k.pv  * 100, dat31_)/100 ;

    If k.pvz > 0 and k.zal >0 then Z_koef := k.pvz/k.zal ;  -- отношение PVZ(приведенный залог) / ZAL(ликвидный залог) в целом по КД
    else                           Z_koef := 0;
    end if;


    INSERT INTO NBU23_REZ (ACC  , FDAT  , ID                             , branch  , cc_id  , nls  , RNK  , NBS                ,
                           KV   , ND    , FIN  , OBS    , KAT    , K     , BV      , PV     , ZAL  , REZ  , REZQ , BVQ  , PVZ  ,
                           PVZQ , ZALQ  , PVQ  , sdate  , wdate  , VKR   )
                   values (k.acc, DAT01_, substr(k.nls,1,4)||k.ND||k.acc , k.branch, k.cc_id, k.nls, k.rnk, substr(k.nls,1,4)  ,
                           k.kv , k.ND  , k.fin, k.obs  , k.kat  , k.k   , k.BV    , k.PV   , k.ZAL, k.REZ, rezq_, bvq_ , k.PVZ,
                           pvzq_, zalq_ , pvq_ , k.sdate, k.wdate, k.VKR );

    z23.pvz_pawn (p_dat01 => dat01_, p_kv   => k.kv, p_acc => k.acc, Z_koef => Z_koef,
                  p_pvz   => k.pvz , p_pvzq => pvzq_ ) ;
 end loop;
 commit;
 z23.kontrol1  (p_dat01 =>DAT01_ , p_id => '9%'  ); --утюжок
 z23.to_log_rez (user_id , -10, dat01_ ,'Конец резерв внебалансы ');
 commit;

end PUL_DAT_9;

--------------------------------------------------------------------------------------

procedure mbk_many
(  p_dat    IN  date    ,  -- отчетная дата = 01.mm.yyyy
   p_modeZ  IN  int     ,  -- :Z(SEM=Включ.в 1B=1/0,TYPE=N)
   ch_      in  int  DEFAULT 0
 ) is
-------------------
  fdat1_    date  ;
  fdat2_    date  ;
  mdat_     date  ;
  dat1p_    date  ; -- дата, с кот начинать прогноз проц
  Z_koef    number; -- отношение PVZ(приведенный залог) / ZAL(ликвидный залог) в целом по КД.
                    -- Использую при делении PVZ по ВИДАМ залога PAWN внутри одного счета
  A_koef    number; -- отношение BV (бал.стоим одного ACC) / SA(сумма актива в целом по КД)
                    -- Использую при делении PV,PVZ,REZ,ZAL, ZALALL по СЧЕТАМ внутри одного КД
  IRR0_     number;
  SAQ_      NUMBER;
  int_      number;  -- прогноз нач проц для расчета эф.ставки
  int1_     number;  ---- прогноз нач проц для модиф денеж.потоков
  kos1_     number;  -- Cумма реально погаш %
  int2_     number;  ---- прогноз нач проц для модиф денеж.потоков

  VKR_      varchar2(10);  -- внутренний кредитный рейтинг
  -----------------
  l_count int := 0 ;
  g1      SYS_REFCURSOR ;
  gpk     cc_lim%rowtype ;
  II      int_accn%rowtype;
  -------------------


 procedure ins_mbk (p_nd   test_many_mbk.nd%type,
                     p_fdat test_many_mbk.fdat%type,
                     p_s1   test_many_mbk.s1%type, -- сумма процентов
                     p_s    test_many_mbk.s%type,  -- сумма тела
                     I_n    TMP_IRR.n%type,
                     I_S    TMP_IRR.s%type
                     ) is
  begin
     If I_s <> 0 then
        insert into TMP_IRR (n,s) values (I_n , I_s);
     end if;
     if nvl(p_s1,0) <> 0 or nvl(p_s,0) <> 0 then --добавлена строка Kharin 30.09.2015 для исключения добавлений пустых потоков
        insert into test_many_mbk (nd, fdat,s1, s) values (p_nd, p_fdat, p_s1, p_s);
     end if;                                     --добавлена строка Kharin 30.09.2015
  end ins_mbk;
  -----------------
begin

 IF p_DAT IS NULL THEN    raise_application_error(-20000,'Укажiть звiтну дату !'); END IF;

 dat01_ := p_dat ;
 Z23.di_snp;

  --Sta ДЛЯ общего протокола
  if nvl(p_modeZ,0)  = 1 then ---        -- :Z(SEM=Включ.в 1B=1/0,TYPE=N)
     z23.CHEK_modi(dat01_) ;
     z23.to_log_rez (user_id , 7 , dat01_ ,'Начало резерв МБДК ');
     logger.info ('REZ23-5 MBK_+9100 отч дата='|| to_date(dat01_, 'dd.mm.yyyy') );
     delete from NBU23_REZ where FDAT = p_dat  and (ID like  'MBDK%' or id like '9100%') ;
     COMMIT;

     tmp.DELETE;
     for k in (select r020, ddd from kl_f3_29 where kf='1B' and (r020 >='1500' and r020 <'1600'  or r020  in ('9100','9001')) )
     loop
        tmp(k.r020).ddd := k.ddd ;        if k.r020 = '9100' then      ddd_9100 := k.ddd;   end if ;
     end loop;
  end if;

  PUL.Set_Mas_Ini( 'sFdat1', to_char(p_dat,'dd.mm.yyyy'), 'Пар.sFdat1' );
  PUL_dat(to_char(p_dat,'dd.mm.yyyy'),'');
  dat31_ := Dat_last_work (dat01_-1);  -- последний рабочий день месяца
  z23.RNK_KAT(ch_);
  delete from test_many_mbk ;
  delete from TEST_MANY_CCK ;

  for k in (SELECT acrn.fproc(a.acc,dat31_) IR,- ost_korr(a.acc,dat31_,z23.di_,a.nbs) S,
                    a.acc, d.nd, d.sdate, d.wdate, d.vidd,(1-nvl(d.k23,0)) k1, D.K23,
                    A.NBS, A.KV, D.KAT23, D.FIN23, D.OBS23, D.CC_ID, D.RNK, D.BRANCH, d.IR IRR
             FROM (select * from accounts where  nbs >'1500' and nbs < '1600') a,
                  (select * from cc_deal
                   where (vidd> 1500  and vidd<  1600 ) and sdate< dat01_ and vidd<>1502 and
                         (sos>9 and sos< 15 or wdate >= dat31_ )) d, cc_add ad
             WHERE a.acc = ad.accs  and d.nd = ad.nd  and ad.adds = 0  and
                   ost_korr(a.acc,dat31_,z23.di_,a.nbs)<0
                   and d.nd=(select max(n.nd) from nd_acc n,cc_deal d1
                             where n.acc=a.acc and n.nd=d1.nd and (d1.vidd> 1500  and d1.vidd<  1600 ) and d1.vidd<>1502
                               and d1.sdate< dat01_ and  (sos>9 and sos< 15 or d1.wdate >= dat31_ ) )
            )
loop

   vkr_ := cck_app.get_nd_txt(k.nd, 'VNCRR');
   If k.IR >0 then
      begin
         select * into II  from int_accn where acc = k.acc and id =0 ;
      EXCEPTION WHEN NO_DATA_FOUND THEN II.basey := 0;
      end;
   end if;

   delete from TMP_IRR;
   ins_mbk (p_nd=> k.nd, p_fdat=> k.sdate, p_s1=> 0, p_s=> (-k.s), I_n=> 1, I_s=> (-k.s) );
   ------------  29.01.2015 если есть инд. ГПК. берем его. иначе - по умолчанию. по-старому
   l_count := 0 ;
   If k.wdate > DAT31_  then
      If dat01_ > sysdate then
         select count(*) into l_count from cc_lim     where                  nd = k.nd ;  -- прямо из ГПК
      else
         select count(*) into l_count from cc_lim_arc where mdat = p_DAT and nd = k.nd ;
      end if;
   end if;
   If l_count > 0  then
      If dat01_ > sysdate then
         OPEN g1 FOR SELECT fdat,sumg,sumo from cc_lim     where                   nd = k.nd order by fdat ;
      else
         OPEN g1 FOR select fdat,sumg,sumo from cc_lim_arc where mdat = dat01_ and nd = k.nd order by fdat ;   -- уже из архива ГПК
      end if;
      LOOP  FETCH g1 into gpk.fdat, gpk.sumg, gpk.sumo ;  EXIT WHEN g1%NOTFOUND;
         ins_mbk (p_nd=> k.nd,p_fdat=> gpk.fdat,p_s1=> (gpk.sumo-gpk.sumg), p_s=> gpk.sumg, I_n=> (gpk.fdat-k.sdate+2), I_s=> gpk.sumo);
      end loop;
      CLOSE g1;
   Else
      If k.VIDD in (1510, 1512, 1521, 1523) and months_between ( z23.WDATE1(k.wdate), k.sdate) <= 1  then
         --    wdate1 = k.wdate – если  k.wdate – рабочий день
         --    wdate1 = «последний рабочий день» перед k.wdate – если  k.wdate – выходной.

         ---------------------------------- для коротких---------------------
         -- проц за весь период
         acrn.p_int ( k.acc, 0, k.sdate, k.wdate-1, int_ , -k.s, 0  );
         int_:= ROUND(-int_,0);
         insert into TMP_IRR(n,s) values ( (k.wdate-k.sdate)+1, k.s + int_ );

         -- для потоков
         If k.wdate >= DAT31_  then  ----- нет просрочки = тело + проц (реально начисленные  прогнозные).включаем в послед дату
            ins_mbk (p_nd => k.nd, p_fdat => k.wdate, p_s1 => int_, p_s => k.s, I_n=>(k.wdate-k.sdate)+1, I_s=> (k.s+int_));
         else                       ----- просрочка
            ins_mbk (p_nd => k.nd, p_fdat => dat01_ , p_s1 => int_, p_s => k.s, I_n=>(k.wdate-k.sdate)+1, I_s=> (k.s+int_));
         end if;

      else
         --------------- № 1 для длинных  ----------------
         fdat1_ := k.sdate;
         WHILE 1<2    loop
            --промеж. платежи
            fdat2_ := last_day (fdat1_ );
            If fdat2_  >= k.wdate then   exit;         end if;

            -- для эф.ставки
            acrn.p_int ( k.acc, 0, fdat1_, fdat2_, int_, -k.s, 0 );
            int_:= ROUND(- int_,0);
   --       insert into TMP_IRR(n,s) values ( fdat2_- k.sdate+2, int_);
            -- для потоков
   --       ins_mbk (p_nd  => k.nd, p_fdat => fdat2_,  p_s1 => int_ , p_s => 0  );     ---MBK10
            ins_mbk    (p_nd  => k.nd, p_fdat => fdat2_,  p_s1 => int_ , p_s => 0, I_n=> (fdat2_-k.sdate+2), I_s=> int_ );
            fdat1_ := fdat2_ + 1;
         end loop;

         -- расчет проц за последний период
         fdat1_ := trunc(k.wdate,'MM');   int_  := 0;

         If fdat1_ < k.wdate then
--          int_  := ROUND( calp( k.s, k.ir, fdat1_ , k.wdate-1,II.basey),0);
            acrn.p_int ( k.acc, 0, fdat1_, k.wdate-1, int_, -k.s, 0 );         int_:= ROUND(- int_,0);
         end if;

         If k.wdate >= DAT31_ then
            -- нет просрочки = тело + проц
            ins_mbk (p_nd=> k.nd, p_fdat=> k.wdate, p_s1=> int_, p_s=> k.s, I_n=> (k.wdate-k.sdate+1), I_s=> (k.s+int_) );

         else
            --просрочка = только проц.
            ins_mbk (p_nd=> k.nd, p_fdat=> k.wdate, p_s1=> int_, p_s=> 0  , I_n=> (k.wdate-k.sdate+1), I_s=> (k.s+int_) );
            -- тело + проц за просроч период
            int_  := ROUND(calp(k.s, k.ir, k.wdate, DAT31_, II.basey),0);
            ins_mbk (p_nd  => k.nd, p_fdat => DAT01_ ,  p_s1 => int_ , p_s => k.s, I_n=> 0, I_s=> 0);
         end if;
      end if;
   end if;
--  update test_many_mbk set s = round(s * k.k1,0) where nd = k.nd and fdat > k.sdate ;
    update test_many_mbk set sk = round((s+s1) * k.k1,0) where nd = k.nd and fdat > k.sdate ;
   begin
   if k.IRR is null THEN irr0_ := round(XIRR(k.ir) * 100,8);
   else                  irr0_ := k.IRR;
   end if;
   exception when others then irr0_ := 0;
   end;
   IF K.ND not in (518455,116605) and k.irr is NULL THEN
      update cc_deal set ir = irr0_ where nd = k.nd and irr0_ < 100;
   end if;
--------------------------------------------------------------------------------------
   -- BV oбщая и ПО СЧЕТАМ
   acct.DELETE;
   SAQ_ := 0; SA_ := 0; zal_:= 0;
   for q in (select a.nls, a.acc, a.kv, a.nbs, -ost_korr(a.acc,dat31_,z23.di_,a.nbs) S,
                 (select sum(s) from tmp_rez_obesp23 where dat = dat01_ and accs= a.acc ) ZAL
             from   nd_acc n, accounts a
             where n.nd = K.ND and n.acc = a.acc  and ost_korr(a.acc,dat31_,z23.di_,a.nbs) <>0 AND NBS LIKE '15%'
             )
   loop
      acct(q.acc).sdate:= k.sdate;
      acct(q.acc).kv   := q.kv   ; acct(q.acc).nls := q.nls ;
      acct(q.acc).nbs  := q.nbs  ; acct(q.acc).bv  := q.s   ;
      acct(q.acc).bvq  := gl.p_icurval(q.kv, q.s, dat31_)  ;
      If q.s > 0 then SAQ_ := SAq_ + acct(q.acc).bvq;
                      SA_  := SA_  + acct(q.acc).bv ;
                      ZAL_ := ZAL_ + nvl(q.zal,0);
     end if;
   end loop;
   BV_ := SA_ ; BVQ_  := SAQ_ ;

   -- PV oбщая и ПО СЧЕТАМ
   PV_   := null ;
   iF irr0_ >0 AND Dat_Next_U (K.sdate, 1) < K.wdate THEN
      update test_many_mbk set sr = round(SK / POWER((1+IRR0_/100),(FDAT-dat01_)/365 ),2)
      WHERE ND=K.nd AND fdat>= DAT01_;
      select round(Sum(SR),0) INTO PV_ FROM test_many_mbk WHERE ND=K.nd AND fdat>= DAT01_;
   END IF;

   IF PV_ IS NULL THEN   PV_  :=  round(BV_*(1-K.k23),2) ; REZ_ := round(BV_ * K.K23,2);   ELSE     REZ_ := BV_ - PV_;   END IF;
   REZ_   := GREATEST ( REZ_ - ZAL_      , 0 );
   PVZ_   := GREATEST ( BV_  - PV_ - REZ_, 0 );

   PVq_   := GL.P_ICURVAL( K.KV, PV_ , DAT31_);
   PVZq_  := GL.P_ICURVAL( K.KV, PVZ_, DAT31_);
   REZQ_  := GL.P_ICURVAL( K.KV, REZ_, DAT31_);
   ZALQ_  := GL.P_ICURVAL( K.KV, ZAL_, DAT31_);

   If pvz_ > 0 and zal_ >0 then  Z_koef := pvz_/zal_;   -- отношение PVZ(приведенный залог) / ZAL(ликвидный залог) в целом по КД
   else                          Z_koef := 0;
   end if;

   INSERT INTO TEST_MANY_CCK (RNK,ND,FIN,OBS,KAT,K,KV,IRR0,NLS,sdate,wdate,ir,dat,id,BV,PV,OBESP,PVZ,REZ,BVq,PVq,ZALq,PVZq,REZq)
   VALUES (k.RNK,k.ND,k.FIN23,k.OBS23,k.KAT23,k.K23,k.KV,IRR0_,k.NBS,k.sdate,k.wdate,k.ir,DAT01_, gl.auid,
           BV_ /100, PV_ /100, ZAL_ /100, PVZ_ /100, REZ_ /100, BVq_/100, PVq_/100, ZALq_/100, PVZQ_/100, REZq_/100);

   -- поделить в удельном весе теп.варт. PV(PVq)+PVZ(PVZq) +резерв REZ(REZq)+залог ZAL(ZALQ)+  - через екв
   D_PV  := PV_ ; D_PVZ  := PVZ_ ; D_REZ  := REZ_ ; D_ZAL  := ZAL_ ;
   D_PVq := PVq_; D_PVZq := PVZq_; D_REZq := REZq_; D_ZALq := ZALq_;

   acc_  := acct.FIRST; -- установить курсор на  первую запись
   WHILE acc_ IS NOT NULL
   LOOP
     If acct(acc_).BV>0 and sa_>0 then  a_koef     := acct(acc_).BV / sa_;
        acct(acc_).PVq  := round(PVq_  * A_koef,0)  ;    -- теп.варт
        acct(acc_).PVZq := round(PVZq_ * A_koef,0)  ;    -- теп.варт zaloga
        acct(acc_).rezq := round(REZq_ * A_koef,0)  ;    -- резерв
        acct(acc_).zalq := round(ZALq_ * A_koef,0)  ;    -- ликв.залог

        acct(acc_).PV  := gl.p_ncurval( acct(acc_).kv, acct(acc_).PVq , dat31_);
        acct(acc_).PVZ := gl.p_ncurval( acct(acc_).kv, acct(acc_).PVZq, dat31_);
        acct(acc_).rez := gl.p_ncurval( acct(acc_).kv, acct(acc_).rezq, dat31_);
        acct(acc_).zal := gl.p_ncurval( acct(acc_).kv, acct(acc_).zalq, dat31_);

        D_PV  := D_PV  - acct(acc_).PV  ; D_PVq  := D_PVq  - acct(acc_).PVq  ;
        D_PVZ := D_PVZ - acct(acc_).PVZ ; D_PVZq := D_PVZq - acct(acc_).PVZq ;
        D_REZ := D_REZ - acct(acc_).REZ ; D_REZq := D_REZq - acct(acc_).REZq ;
        D_ZAL := D_ZAL - acct(acc_).ZAL ; D_ZALq := D_ZALq - acct(acc_).ZALq ;

        z23.pvz_pawn (p_dat01 => dat01_, p_kv   => acct(acc_).kv, p_acc => acc_, Z_koef => Z_koef,
                      p_pvz   => pvz_  , p_pvzq => pvzq_ ) ;
     else
        acct(acc_).PV  := 0 ;  acct(acc_).PVq  := 0 ;
        acct(acc_).PVZ := 0 ;  acct(acc_).PVZq := 0 ;
        acct(acc_).rez := 0 ;  acct(acc_).rezq := 0 ;
        acct(acc_).zal := 0 ;  acct(acc_).zalq := 0 ;
     end if;
     If  tmp.EXISTS(k.nbs) then DDD_:= tmp(k.nbs).ddd; else          DDD_:= null;     end if;
       acc_ := acct.NEXT(acc_); -- установить курсор на след.вниз запись
   end loop;

   ---**** Запись балансовых сосставляющих 2*** в окончательный протокол NBU23_REZ   ******************************
   If nvl(p_modeZ,0)= 1  then
      acc_  := acct.FIRST; -- установить курсор на  первую запись
      WHILE acc_ IS NOT NULL         LOOP
         --балансировка разницы окр
         If acct(acc_).pv  > 0 then acct(acc_).pv   := acct(acc_).pv   + D_PV   ; D_PV   := 0 ;
                                    acct(acc_).pvq  := acct(acc_).pvq  + D_PVq  ; D_PVq  := 0 ;
         end if;
         If acct(acc_).pvz > 0 then acct(acc_).pvz  := acct(acc_).pvz  + D_PVZ  ; D_PVZ  := 0 ;
                                    acct(acc_).pvZq := acct(acc_).pvZq + D_PVZq ; D_PVZq := 0 ;
         end if;

         If acct(acc_).rez > 0 then acct(acc_).rez  := acct(acc_).rez  + D_rez  ; D_rez  := 0 ;
                                    acct(acc_).rezq := acct(acc_).rezq + D_rezq ; D_rezq := 0 ;
         end if;
         If acct(acc_).zal > 0 then acct(acc_).zal  := acct(acc_).zal  + D_zal  ; D_zal  := 0 ;
                                    acct(acc_).zalq := acct(acc_).zalq + D_zalq ; D_zalq := 0 ;
         end if;

         begin
            INSERT INTO NBU23_REZ (cc_id  ,branch     ,RNK  ,ND  ,FIN     ,OBS    ,KAT       ,K     ,FDAT  ,irr  ,DDD ,acc ,VKR ,
                                   ID                 ,NBS                ,nls               ,KV                 ,
                                   BV                 ,PV                 ,PVZ               ,REZ                ,
                                   ZAL                ,BVq                ,PVq               ,PVZq               ,
                                   REZq               ,ZALq               ,sdate             ,wdate)
                           values (k.cc_id,k.branch   ,k.RNK,k.ND,k.FIN23 ,k.OBS23,k.KAT23   ,k.K23 ,DAT01_,irr0_,DDD_,acc_,VKR_,
                                   'MBDK'||K.ND||ACC_ ,acct(acc_).nbs     ,acct(acc_).nls    ,acct(acc_).kv      ,
                                   acct(acc_).bv  /100,acct(acc_).pv  /100,acct(acc_).pvz/100,acct(acc_).rez /100,
                                   acct(acc_).zal /100,acct(acc_).bvq /100,acct(acc_).pvq/100,acct(acc_).pvzq/100,
                                   acct(acc_).rezq/100,acct(acc_).zalq/100,acct(acc_).sdate  ,k.wdate );
         exception when others then    --ORA-00001: unique constraint (BARS.PK_NBU23REZ_ID) violated
           if SQLCODE = -00001 then
              raise_application_error(-20000, 'NBU23_REZ dubl '|| to_char(DAT01_,'dd.mm.yyyy') || ' '|| 'MBDK'||K.ND|| ACC_ );
           else raise;
           end if;
        end;
         --------------
         acc_ := acct.NEXT(acc_); -- установить курсор на след.вниз запись
      end loop;
   end if;

END LOOP;
-----------------------------

--9129
for k in (select x.acc,x.RNK,x.kv,x.nls,x.nbs,x.BV, y.ND,y.fin23,y.obs23,y.kat23,y.k23, y.sdate, y.wdate, y.branch, y.cc_id
          from (select acc,nbs,nls,rnk,kv,   -ost_korr(acc,dat31_,z23.di_,nbs)  BV
                from accounts  where nbs in ('9100','9001')  and ost_korr(acc,dat31_,z23.di_,nbs) <>0
                ) x,
               (select n.ACC,d.ND,d.branch, d.cc_id,  d.sdate, d.wdate, d.fin23, d.obs23, d.kat23, d.k23
                from cc_deal d, nd_ACC N where d.vidd  in (9100,9001) AND d.sdate < DAT01_ AND d.wdate >= DAT01_ AND d.nd=n.nd
                ) y
          where x.acc = y.acc
         )
loop
   SELECT nvl(SUM(s),0) into ZAL_ FROM tmp_rez_obesp23 WHERE dat= DAT01_ AND accs=k.acc;
   BVQ_  :=                                                       gl.p_icurval( k.kv, k.BV, dat31_) ;
   PV_   := round(          k.BV*(1-k.K23)      ,0);     PVQ_  := gl.p_icurval( k.kv, PV_ , dat31_) ;
   REZ_  := round(greatest (k.BV*k.k23 - ZAL_,0),0);     REZQ_ := gl.p_icurval( k.kv, REZ_, dat31_) ;
   pvz_  := round(greatest (k.BV*k.k23 - REZ_,0),0);     PVZQ_ := gl.p_icurval( k.kv, PVZ_, dat31_) ;
   ZALQ_ :=                                                       gl.p_icurval( k.kv, ZAL_, dat31_) ;

   INSERT INTO TEST_MANY_CCK (RNK,ND,FIN,OBS,KAT,K,KV,NLS,sdate,wdate,dat,id,BV,BVq,PV,PVq,PVZ,PVZq, REZ,REZq , OBESP,ZALq)
   VALUES  (k.RNK,k.ND,k.FIN23,k.OBS23,k.KAT23, k.K23, k.KV, k.NlS, k.sdate,k.wdate, DAT01_,gl.auid,
                     k.BV/100, BVq_/100, PV_/100, PVq_/100, PVZ_ /100, PVZQ_/100, REZ_ /100, REZq_/100, ZAL_/100,ZALq_/100);

   If nvl(p_modeZ,0) = 1 then
      If  tmp.EXISTS(k.nbs) then DDD_:= tmp(k.nbs).ddd; else          DDD_:= null;     end if;
      -- в INSERT возможно добавить вместо DDD_9100 -->  tmp(k.nbs).ddd
      INSERT INTO NBU23_REZ (DDD     ,ACC      ,FDAT     ,ID                ,branch  ,sdate  ,wdate   ,nls     ,RNK     ,NBS     ,
                             KV      ,ND       ,cc_id    ,FIN    ,OBS       ,KAT     ,K      ,BV      ,ZAL     ,BVQ     ,PV      ,
                             REZ     ,REZQ     ,pvz      ,pvzq )
                     values (DDD_9100,k.acc    ,DAT01_   ,'MBDK'||K.ND||ACC_,k.branch,k.sdate,k.wdate ,k.nls   ,k.rnk   ,k.nbs   ,
                             k.kv    ,k.nd     ,k.cc_id  ,k.fin23,k.obs23   ,k.kat23 ,k.k23  ,k.BV/100,ZAL_/100,BVQ_/100, PV_/100,
                             REZ_/100,REZQ_/100,PVZ_ /100,PVZQ_/100);
   end if;
end loop;

commit;

if nvl(p_modeZ,0) =1  THEN
   z23.kontrol1  (p_dat01 =>DAT01_ , p_id => 'MBDK%'  );
   commit;
   z23.kontrol1  (p_dat01 =>DAT01_ , p_id => '9100%'  );
   commit;
end if;
z23.to_log_rez (user_id , -7 , dat01_ ,'Конец резерв МБДК ');
commit;

end mbk_many;
--------------------------

PROCEDURE rez_korr
(dat_    in date ,
 p_modeZ IN  int ,      -- :Z(SEM=Включ.в 1B=1/0,TYPE=N)
 ch_     in  int  DEFAULT 0
) is

-- STA 21-12-2012 Вставки в общий протокол
 obesp_   number ; -- обеспечение
--------------------
 A_koef   number  ; -- отношение BV (бал.стоим одного ACC) / SA(сумма актива в целом по КД)
                    -- Использую при делении PV,PVZ,REZ,ZAL, ZALALL по СЧЕТАМ внутри одного КД
 SAQ_     NUMBER  ;
 k_       number  ;
 fin_     number  ;
 kat_     number  ;
 obs_     number  ;
 rez_     number  ;
 REZQ_    NUMBER  ;
 PV_      number  ;
 BV_      number  ; -- -- бал.стоим
 BVR_     NUMBER  ;
 BVQ_     NUMBER  ;
 DISKONT_ NUMBER  ;
 REZ_KAT  NUMBER  DEFAULT 0;
 nls_     accounts.nls%type;  kv_   accounts.kv%type;
 IDD_     VARCHAR2(22);
 nbs_     varchar2(150);
 sdat01_  char(10);
---------------------
 function obs_korr (acc_ number)      RETURN NUMBER IS
  --  До выяснения ситуации просрочки по корсчетам obs_=1
  begin
    OBS_:=1;
    return obs_;
  end  obs_korr;
-----------------------------------------------------
BEGIN

   IF DAT_ IS NULL THEN
      raise_application_error(-20000,'Укажiть звiтну дату !');
   END IF;

   DAT01_ := DAT_; -- 01 число отч мес
   Z23.di_snp;
   sdat01_ := to_char( DAT01_,'dd.mm.yyyy');
   PUL_dat( sdat01_,'' );
   z23.RNK_KAT(ch_);
   dat31_ := Dat_last_work (dat01_-1);  -- последний рабочий день месяца

   if nvl(p_modeZ,0)  = 1 then ---        -- :Z(SEM=Включ.в 1B=1/0,TYPE=N)
      z23.CHEK_modi(dat01_) ;
      logger.info ('REZ23-6 KORR+1500 отч.дата='|| to_date( dat01_,'dd.mm.yyyy') );
      delete from NBU23_REZ where FDAT = dat01_ and ID like  '15%' ;
      COMMIT;
      tmp.DELETE;
      for k in (select r020, ddd from kl_f3_29  where kf='1B' and r020 IN  ('1500','1502','1508','1509','1510','1521','1517','1519' ) )
      loop
         tmp(k.r020).ddd := k.ddd ;
      end loop;
   end if;
   z23.to_log_rez (user_id , 8 , dat01_ ,'Начало резерв коррсчета ');
   REZ_KAT:=nvl(F_Get_Params('REZ_KAT', 0) ,0);
   delete from TEST_MANY_korr;

   If gl.amfo ='380764' THEN     nbs_:='1500,1502,1508,1509,1510';  -- НАДРА
   else                          nbs_:='1500,1502,1508,1509';
   end if;


   for k in (select d.nd, nvl(d.fin23,1) FIN, nvl(d.obs23,1) OBS,nvl(d.kat23,1) KAT, nvl(d.k23,0) K,
                    d.sdate, d.wdate, d.branch, rnk, 2 istval -- для коррсчетов istval=2, показатель риска берется из TMP_OB_KORR
             from  cc_deal d  where vidd = 150)
   LOOP

      if REZ_KAT = 1 THEN
         k.k   := f_rnk_kat_k(k.rnk,k.kat,k.k,2,k.istval);
         k.kat := f_rnk_kat_k(k.rnk,k.kat,k.k,1,k.istval);
      end if;

      -- BV oбщая и ПО СЧЕТАМ
      acct.DELETE;
      SAQ_ := 0; SA_ := 0; zal_:= 0;
      for q in (select n.nd,A.KV, A.NLS, A.NBS , A.RNK, A.ACC, A.DAOS, a.mdate, a.tobo branch,
                       -ost_korr(a.acc,dat31_,null,a.nbs) ost,nvl(ob22,'01') ob22,c.country, c.crisk
                from   accounts a,customer c,nd_acc n
                where  nbs in ('1500','1502','1508','1509') and ost_korr(a.acc,dat31_,null,a.nbs)  <>0
                       and nbs is not null and (dazs is null or dazs> DAT31_) and  a.rnk=c.rnk
                       and a.acc=n.acc (+) and n.nd=k.nd
               )
      loop

         acct(q.acc).kv  := q.kv ; acct(q.acc).nls := q.nls ; acct(q.acc).nbs := q.nbs ;
         acct(q.acc).bv  := q.ost; acct(q.acc).bvq := gl.p_icurval(q.kv, q.ost, dat31_);
         acct(q.acc).acc := q.acc; acct(q.acc).ob22:= q.ob22 ;
         BVR_ := SA_  + acct(q.acc).bv ;
         If q.ost > 0 then SAQ_ := SAq_ + acct(q.acc).bvq;
                           SA_  := SA_  + acct(q.acc).bv ;

         end if;
         kv_ := q.kv;
      end loop;
      if SA_ <> 0 or SAQ_ <> 0 THEN
         BV_  := SA_ ; BVQ_  := SAQ_ ;
         -- PV oбщая и ПО СЧЕТАМ
         PV_  := null ;
         PV_  := BVR_*(1-K.k); REZ_ := BVR_ * K.K;
         PVq_ := GL.P_ICURVAL( KV_, PV_ , DAT31_);
         REZQ_:= GL.P_ICURVAL( KV_, REZ_, DAT31_);

         -- поделить в удельном весе теп.варт. PV(PVq) +резерв REZ(REZq) - через екв
         D_PV  := PV_ ;  D_REZ  := REZ_ ; D_PVq := PVq_;  D_REZq := REZq_;

         acc_  := acct.FIRST; -- установить курсор на  первую запись
         WHILE acc_ IS NOT NULL
         LOOP

            If acct(acc_).BV>0 and sa_>0 then
               a_koef          := acct(acc_).BV / sa_;
               acct(acc_).PVq  := round(PVq_  * A_koef,0)  ;    -- теп.варт
               acct(acc_).rezq := round(REZq_ * A_koef,0)  ;    -- резерв
               acct(acc_).PV   := gl.p_ncurval( acct(acc_).kv, acct(acc_).PVq , dat31_);
               acct(acc_).rez  := gl.p_ncurval( acct(acc_).kv, acct(acc_).rezq, dat31_);

               D_PV  := D_PV  - acct(acc_).PV  ; D_PVq  := D_PVq  - acct(acc_).PVq  ;
               D_REZ := D_REZ - acct(acc_).REZ ; D_REZq := D_REZq - acct(acc_).REZq ;
            else
               acct(acc_).PV  :=acct(acc_).BV ;  acct(acc_).PVq  := acct(acc_).BVq ;
               acct(acc_).rez := 0 ;  acct(acc_).rezq := 0 ;
            end if;
            If  tmp.EXISTS(acct(acc_).nbs) then DDD_:= tmp(acct(acc_).nbs).ddd; else  DDD_:= null;     end if;
            acc_ := acct.NEXT(acc_); -- установить курсор на след.вниз запись
         end loop;


         --          delete from NBU23_REZ where FDAT = dat_  and ID = IDD_;
         acc_  := acct.FIRST; -- установить курсор на  первую запись
         WHILE acc_ IS NOT NULL
         LOOP
            If  tmp.EXISTS(acct(acc_).nbs) then DDD_:= tmp(acct(acc_).nbs).ddd;
            else                       DDD_:= null;
            end if;
            IDD_ := acct(acc_).nbs||acct(acc_).acc;

            If acct(acc_).pv  > 0 then
               acct(acc_).pv  := acct(acc_).pv   + D_PV   ; D_PV   := 0 ;
               acct(acc_).pvq := acct(acc_).pvq  + D_PVq  ; D_PVq  := 0 ;
            end if;
            If acct(acc_).rez > 0 then
               acct(acc_).rez := acct(acc_).rez  + D_rez  ; D_rez  := 0 ;
               acct(acc_).rezq:= acct(acc_).rezq + D_rezq ; D_rezq := 0 ;
            end if;

            insert into TEST_MANY_KORR (nd, branch, pv, vidd, sdate,
                                        bv, bvq, RNK, k, nls,
                                        kv, obesp,obs,rez,rezq,
                                        id, dat, kat, fin  )
                                values (k.nd, k.branch,acct(acc_).pv/100, acct(acc_).nbs, k.sdate,
                                        acct(acc_).bv/100, acct(acc_).bvq/100, k.rnk, k.k, acct(acc_).nls,
                                        acct(acc_).kv, 0 , k.obs, round(acct(acc_).rez/100,2), round(acct(acc_).rezq/100,2),
                                        gl.auid, dat_, k.kat, k.fin)        ;
            if nvl(p_modeZ,0) =1 then

               begin
                  DISKONT_ := acct(acc_).bv/100 - acct(acc_).pv/100 - round(acct(acc_).rez/100,2);
                  INSERT INTO NBU23_REZ (    FDAT, ID          , branch        , sdate         , wdate          ,
                                              nls, RNK         , NBS           , KV            , ND             ,
                                              ACC, FIN         , OBS           , KAT           , K              ,
                                              zal, BV          , PV            , REZ           , BVQ            ,
                                             REZQ, DDD         , PVZ           , PVZq          , PVq            ,
                                             ZALq, ob22,DISKONT )
                                  VALUES(    dat_, IDD_        , k.branch      , k.sdate       , k.wdate        ,
                                   acct(acc_).nls, k.rnk       , acct(acc_).nbs, acct(acc_).kv , k.nd           ,
                                   acct(acc_).acc, k.fin       , k.obs         , k.kat         , k.k            ,
                                                0,acct(acc_).bv/100, acct(acc_).pv/100 ,
                                                round(acct(acc_).rez/100,2), acct(acc_).bvq/100 ,
                                                round(acct(acc_).rezq/100,2), ddd_        , 0             , 0             , acct(acc_).pvq/100 ,
                                                0, acct(acc_).ob22,DISKONT_);

               exception when others then
                  --ORA-00001: unique constraint (BARS.PK_NBU23REZ_ID) violated
                  if SQLCODE = -00001 then     raise_application_error(-20000, 'NBU23_REZ dubl '|| to_char(DAT_,'dd.mm.yyyy') || ' '|| idd_ );
                  else raise;
                  end if;
               end;
            end if;
            acc_ := acct.NEXT(acc_);
            end loop;
            z23.kontrol1  (p_dat01 =>DAT_ , p_id => SUBSTR(IDD_,1,2) );
      end if;
   END LOOP;
   z23.to_log_rez (user_id , -8 , dat01_ ,'Конец резерв коррсчета ');

END rez_korr ;
---------------------------

PROCEDURE PUL_DAT_CP (
  S_DAT01 IN  DATE, --:s(SEM=Зв_дата_01,TYPE=s) сделат тип DATE - портилась DAT01_
  p_modeZ IN  int,                -- :Z(SEM=Включ.в 1B=1/0,TYPE=N)
  ch_     in  int  DEFAULT 0
  ) is

  BV_    NUMBER;
  BVQ_   NUMBER;
  PV_    NUMBER;
  REZ_   NUMBER;
  REZQ_  NUMBER;
  sdate_ DATE;
  --nls_ varchar2(15);
  nbs_   char(4);
  id23_  NBU23_REZ.id%type;
  cp_acc_   number; cp_accp_  number; cp_accd_   number; cp_accs_ number; cp_accr_  number;
  cp_accr2_ number; l_accexpr number; l_accunrec number; l_accr3  number;

BEGIN

 IF trim(s_DAT01) IS NULL THEN
    raise_application_error(-20000,'Укажiть звiтну дату !');
 END IF;

 PUL_DAT( to_char(s_DAT01,'dd-mm-yyyy'), '');
 IF NVL(p_modeZ,0) <> 1 THEN RETURN; END IF;
 ---------------------------------------------

 --Sta ДЛЯ общего протокола
 dat01_ := nvl(s_dat01,to_date('01.01.2013','dd.mm.yyyy'));
 Z23.di_snp;
 z23.CHEK_modi(dat01_) ;
 z23.to_log_rez (user_id , 9 , dat01_ ,'Начало резерв ЦБ ');
 z23.RNK_KAT(ch_);
 --logger.info ('REZ23-7 CP_DAT отч дата =' || to_date(dat01_,'dd-mm-yyyy')   );

 dat31_ := Dat_last_work (dat01_-1);  -- последний рабочий день месяца

 --Справочник - в массив
 tmp.DELETE;
 for k in (select r020, ddd, r012 from kl_f3_29 where kf='1B')
 loop
    tmp(k.r020).ddd := k.ddd ;
 end loop;
 -------------------------------
 delete from NBU23_REZ where id like 'CACP%' and fdat = dat01_;
 -- пересчитать переоценку в связи с изменением невизнанних доходів
 update cp_pereoc_v set fl_alg23=fl_alg23 where fl_alg23<>0;

/*
 -- Новая переоценка пока не стоит
 begin
    for k in (select * from cp_pereoc_v where fl_alg23<>0)
    LOOP
       CP_UPD_PEREOC( p_ref      => k.ref     , p_rate_b   => k.rate_b  , p_fl_alg   => k.fl_alg  , p_QUOT_SIGN => k.QUOT_SIGN,  P_REZ23 => k.REZ23,
                      P_PEREOC23 => k.PEREOC23, P_FL_ALG23 => k.FL_ALG23, P_DATREZ23 => k.DATREZ23, P_KOL_CP    => k.KOL_CP   );
    end LOOP;
 end;
*/


 FOR d IN (SELECT * FROM V_CP_MANY)
 loop
    sdate_:=null;
    select  acc ,    accp ,    accd ,    accs ,    accr ,    accr2 ,   accr3,   accexpr,   accunrec
    into cp_acc_, cp_accp_, cp_accd_, cp_accs_, cp_accr_, cp_accr2_, l_accr3, l_accexpr, l_accunrec
    from cp_deal where ref = d.ref;

    for s in (select acc, nls, tobo,ob22,  BV, BA , sum(BA)  over (partition by 1) sba, tip
              from ( select acc, nls, tobo,nvl(ob22,'01') ob22, tip,
                            -ost_korr (acc,dat31_,z23.di_,nbs) /100          BV,
                            greatest  (-ost_korr (acc,dat31_,z23.di_,nbs),0) BA
                     from  accounts
                     where acc in (cp_acc_ , cp_accp_ , cp_accd_  , cp_accs_, cp_accr_, cp_accr2_,
                                   l_accr3 , l_accexpr, l_accunrec) and nls not like '8%'
                    )
               )
    loop

       if s.bv > 0 THEN s.tip := f_get_tip (substr(s.nls,1,4), s.tip); end if;
       if s.bv<> 0 THEN
          nbs_  := substr( s.nls,1,4);
          if tmp.EXISTS(nbs_) then ddd_  := tmp(nbs_).ddd;
          else                     ddd_  := null;
          end if;

          id23_ := 'CACP'||d.REF || s.acc;

          If s.sba >0 then rez_  := d.rez23 * s.Ba/s.SBA;
          else             rez_  := 0;
          end if;

          rezq_ := gl.p_icurval( d.kv, rez_*100, dat31_) /100;
          bvq_  := gl.p_icurval( d.kv, s.bv*100, dat31_) /100;
          pv_   := d.pv;

          begin
             select dat_ug into sdate_  from   cp_arch where  ref = d.ref and rownum=1;
          exception when no_data_found then sdate_:=null;
          end;

          If gl.amfo ='300205' and s.tobo like '/______/' THEN  -- УПБ
             s.tobo:= s.tobo || '000000/';
          end if;
          if gl.amfo ='380764' THEN
             d.nomd := to_number(substr(d.nomd,1,1));
          end if;

          begin
            INSERT INTO NBU23_REZ (branch, ob22  , cc_id  , nd_cp , RNK  , ND   , FIN    , KAT    , K     , FDAT   , irr   , acc  , id   , NBS ,
                                   nls   , KV    , BV     , PV    , BVQ  , REZ  , rezq   , DDD    , sdate , VKR    , tip   )
                           values (s.tobo, s.ob22, d.cp_id, d.nomd, d.RNK, d.ref, d.FIN23, d.KAT23, d.K23 , DAT01_ , d.irr0, s.acc, id23_, nbs_,
                                   s.nls , d.kv  , s.BV   , PV_   , bvq_ , rez_ , rezq_  , ddd_   , sdate_, d.VNCRR, s.tip);
          exception when others then
            --ORA-00001: unique constraint (BARS.PK_NBU23REZ_ID) violated
            if SQLCODE = -00001 then  raise_application_error(-20000, 'NBU23_REZ dubl '|| to_char(DAT01_,'dd.mm.yyyy') || ' '|| id23_ );
            else raise;
            end if;
          end;

          <<NextAcc>> null;
       end if;
    end loop;   -- s
 end loop; -- d

 if nvl(p_modeZ,0) =1  THEN
    z23.kontrol1  (p_dat01 =>DAT01_ , p_id => 'CACP%'  );
    commit;
 end if;
 z23.to_log_rez (user_id , -9 , dat01_ ,'Конец резерв ЦБ ');
 return;

end PUL_DAT_cp;
---------------------------------------

PROCEDURE Rez_23( dat_   in date ) is

  -- Вставки в общий протокол
  sdat01_   char(10)         ;
  l_res_kf  varchar2(13);
  sd01_     varchar2(40)     ;
  sSql_     varchar2(4000)   ;
  n00_      char(4)          ;
  ACC_      NUMBER           ;
  REZ_KAT_  NUMBER  DEFAULT 0;
  A01_      date             ;
  q01_      varchar2(55)     ;
  --------------------------
  -- Снимки
  sid_      varchar2(64)     ;
  sess_     varchar2(64)     :=bars_login.get_session_clientid;
  l_GET_SNP_RUNNING  number  ;
  --------------------------
  Z_koef    number           ; -- отношение PVZ(приведенный залог) / ZAL(ликвидный залог) в целом по КД.
  sss_      varchar2 (200)   ;
  l_kol     int              ;

BEGIN
  RETURN;
  --  z23.NOZ (p_kol => l_kol) ;  пОКА НЕ У ВСЕХ УСТАНОВЛЕНА ДЕЛЬТА
  IF DAT_ IS NULL THEN  return;  END IF;
  DAT01_  :=  dat_  ;
  -----------------------
  z23.CHEK_modi(DAT01_) ;
  -----------------------
  l_res_kf := trim('RESERVE'||sys_context('bars_context','user_mfo'));
  -- проверка на повторный запуск резерва
  SYS.DBMS_SESSION.CLEAR_IDENTIFIER;
  sid_:=SYS_CONTEXT('BARS_GLPARAM',l_res_kf);
  SYS.DBMS_SESSION.SET_IDENTIFIER(sess_);

  begin
     select sid into sid_ from v$session
     where  sid=sid_ and sid<>SYS_CONTEXT ('USERENV', 'SID');
     raise_application_error(-20000,'Формування резерву вже виконується SID '|| sid_);
  exception
     when no_data_found THEN NULL;
  end;

  -- установка флага
  gl.setp(l_res_kf,SYS_CONTEXT ('USERENV', 'SID'),NULL);

  -- Снимки проверка
  begin
     select BARS_UTL_SNAPSHOT.GET_SNP_RUNNING into l_GET_SNP_RUNNING from dual;
  EXCEPTION WHEN NO_DATA_FOUND THEN l_GET_SNP_RUNNING := 0;
  end;
  if l_GET_SNP_RUNNING = 1 THEN

     SYS.DBMS_SESSION.CLEAR_IDENTIFIER;
     sid_:=SYS_CONTEXT('BARS_GLPARAM','MONBAL');
     SYS.DBMS_SESSION.SET_IDENTIFIER(sess_);

     begin
        select sid into sid_ from v$session
         where sid=sid_ and sid<>SYS_CONTEXT ('USERENV', 'SID');
        raise_application_error(-20000,'Формується знімок балансу. Зачекайте і повторіть знову SID '|| sid_);
     exception
        when no_data_found THEN   BARS_UTL_SNAPSHOT.stop_running;
     end;

  end if;
  dat31_:=Dat_last_work (dat01_-1 );  -- последний рабочий день месяца
  /* Убрано, снимки должны быть обновлены
  if sysdate>dat_ THEN
     BARS_UTL_SNAPSHOT.sync_month(dat31_);
  end if;
  */
  BARS_UTL_SNAPSHOT.start_running;
  Z23.di_snp;
  logger.info ('REZ23 НАЧАЛО' || sysdate );
  z23.to_log_rez (user_id ,13, dat01_ ,'Начало ВСЕГО резерва ');
  sdat01_ := to_char( DAT01_,'dd.mm.yyyy');
  sd01_   := ' to_date(''' || sdat01_ || ''',''dd.mm.yyyy'') ';
  a01_    := add_months (DAT01_,-1)     ;
  q01_    := to_char( a01_,'dd.mm.yyyy');
  q01_    := ' to_date(''' || q01_    || ''',''dd.mm.yyyy'') ';
  PUL.Set_Mas_Ini( 'sFdat1', sdat01_, 'Пар.sFdat1' );
  PUL_dat(sdat01_, 'Пар.sFdat1' );

  begin  -- Восстановление параметров, которые подвергались корректировке
     for k in (  select * from nbu23_CCK_ul_kor where zdat=dat_ )
     LOOP
        update cc_deal set obs23=k.obs23 where nd=k.nd;
     end LOOP;
     commit;
  end;

  z23.RNK_KAT(1);

  logger.info ('REZ23 -0 delete' || DAT01_ );
  DELETE FROM NBU23_REZ WHERE FDAT = DAT01_ and id not like 'RU%' and id not like 'DEBN%' ;
  DELETE FROM acc_nlo;
  commit;

   --ДЕБИТОРКА
   If gl.amfo ='380764' THEN   -- НАДРА (плохо работает TRUNCATE) LUDA
      EXECUTE IMMEDIATE 'delete from TEST_MANY_CCK_DF';
   else
      EXECUTE IMMEDIATE 'delete from TEST_MANY_CCK_DF';
      EXECUTE IMMEDIATE 'delete from TEST_MANY_CCK_DH';
      Z23.rez_deb_F(dat_=>DAT01_, mode_=>1,modeZ_=>1);
      COMMIT;
   end if;
   --logger.info ('XOZ '|| DAT01_);
   Z23.rez_deb_F(dat_=>DAT01_, mode_   =>0,modeZ_=>1);
   COMMIT;

   -- хоз.дебиторка из модуля
   If z23.XOZ_ = 1  then
      sdat01_ := to_char( DAT01_,'dd.mm.yyyy');
      sd01_   := ' to_date(''' || sdat01_ || ''',''dd.mm.yyyy'') ';
      z23.to_log_rez (user_id , 3 , dat_ ,'Начало Хоз.дебиторка');
      sss_ := 'begin XOZ.REZ(''' || sdat01_ ||''',1) ; end;' ;
      z23.to_log_rez (user_id ,-3 , dat_ ,'Конец  Хоз.дебиторка');
      logger.info ('XOZ '|| sss_);
      execute immediate sss_ ;
      commit;
   end if;

   --КРЕДИТЫ
   z23.TK_many (p_nd=>0, P_DAT01 =>DAT01_, p_modeR =>0, p_modeZ => 1 ); commit;

   --------
   --ОВЕРДРАФТЫ
   Z23.PUL_DAT_OVR (sDat01_, 1);                                        COMMIT;

   --БПК
   Z23.PUL_DAT_BPK (sDat01_, 1);                                        COMMIT;
   -------------------------------------------------------------

   If gl.amfo = '380764' THEN   -- НАДРА
      -- МБК
      execute immediate 'begin Z23.MBK_MANY  ('||sd01_||',1) ; end;';  COMMIT;
      -- Корсчета
      execute immediate 'begin Z23.REZ_KORR  ('||sd01_||',1) ; end;';  commit;
      -- ЦБ
      execute immediate 'begin Z23.pul_dat_cp('||sd01_||',1) ; end;';  commit;
   else

      select nbs into n00_ from accounts where kv=980 and tip='N00';
      ---только для головных банков (ЦА), где есть корсчет в НБУ
      If n00_ ='1200' then
         -- МБК
         execute immediate 'begin Z23.MBK_MANY  ('||sd01_||',1) ; end;';  COMMIT;
         -- Корсчета
         execute immediate 'begin Z23.REZ_KORR  ('||sd01_||',1) ; end;';  commit;
      end if;
   end if;
   ----------------------------
   --РАЗНЫЕ внебалансы
   Z23.PUL_DAT_9 (sDat01_, 1);                                        COMMIT;
   -----------------------------

   -- ЦБ - вынесены, т.к. есть в регионах тоже.
   execute immediate 'begin Z23.pul_dat_cp('||sd01_||',1) ; end;';  commit;

   If gl.amfo ='300205' then   -- Для УПБ это надо!!!!!
      logger.info ('REZ23-nadra 2605' );
      z23.to_log_rez (user_id , 11, dat01_ ,'Начало резерв 2605 ');
      INSERT INTO NBU23_REZ ( ACC,FDAT, ID ,branch,nls,RNK,NBS,KV,ND,FIN,OBS,KAT,K,sdate,
                              BV,bvq,PV,pvq,ZAL,ZALQ,REZ,rezq )
      SELECT ACC, DAT01_,'2605'||ACC,branch,nls,rnk,NBS,kv,ND,fin,obs,kat,k,sdate,
             BV, gl.p_icurval(kv,bv *100,dat31_)/100, PV , gl.p_icurval(kv,pv *100,dat31_)/100,
             ZAL,gl.p_icurval(kv,ZAL*100,dat31_)/100, REZ, gl.p_icurval(kv,rez*100,dat31_)/100
      from  V_rez_2605;
      z23.kontrol1  (p_dat01 => DAT01_ , p_id => '2605%'  );
      z23.to_log_rez (user_id , -11, dat01_ ,'Конец резерв 2605 ');
      COMMIT;
   end if;
   ------------------
   update nbu23_rez n set acc = (select acc from accounts where nls=n.nls and kv=n.kv)
   where acc is null and fdat = dat01_;
   z23.to_log_rez (user_id , 12, dat01_ ,'Начало резерв NLO ');
   z23.INS_NLO   (p_dat01 => DAT01_ );
   z23.kontrol1  (p_dat01 => DAT01_ , p_id => 'NLO%'  );
   z23.to_log_rez (user_id ,-12, dat01_ ,'Конецо резерв NLO ');
   commit;

   ------------------

   rezerv_23(dat01_);
   z23.to_log_rez (user_id ,-13, dat01_ ,'Конец ВСЕГО резерва ');
   commit;

   logger.info ('REZ23 КОНЕЦ' || sysdate );
   execute immediate 'truncate table tmp_rnk_kat';
   -- снятие флага
   gl.setp(l_res_kf,'',NULL);
   BARS_UTL_SNAPSHOT.stop_running;
end Rez_23;
------------------------------------

FUNCTION nbu23_rez_crcchk (fdat_ date) RETURN boolean
IS
  cnt_     number;  cntcrc_  number;  crc_     number;  crcrez_  number;  str_     varchar2(4000);  i_       number;
BEGIN
  SELECT count(*)  into   cnt_  from   nbu23_rez  where  fdat=fdat_;

  begin
    select to_number(substr(crc,30,10))-
           to_number(substr(crc,15,1)||substr(crc,28,2)||substr(crc,40,3)||substr(crc,1,4))+
           to_number(substr(crc,5,10))
    into   cntcrc_
    from   rez_protocol
    where  dat_otcn=fdat_;
  exception when no_data_found then    cntcrc_ := 0;
  end;

  i_ := 0;

--проверка
  if cnt_=cntcrc_ then

    crc_ := 0;
    for k in (select ID           ||
                     to_char(RNK) ||
                     NBS          ||
                     to_char(KV)  ||
                     to_char(ND)  ||
                     CC_ID        ||
                     to_char(ACC) ||
                     NLS          ||
                     BRANCH       ||
                     to_char(FIN) ||
                     to_char(OBS) ||
                     to_char(KAT) ||
                     to_char(K)   ||
                     to_char(IRR) ||
                     to_char(ZAL) ||
                     to_char(BV)  ||
                     to_char(PV)  ||
                     to_char(REZ) ||
                     to_char(REZQ)||
                     DD           ||
                     DDD allstr
              from   nbu23_rez
              where  fdat=fdat_
              order by ID,KV)
    loop
      str_ := k.allstr;
      i_   := i_+1;
--    bars_audit.info(i_||' ------------------------------------- str_ = '||str_);
      while length(str_)>0
      loop
        crc_ := crc_+Round((Ascii(substr(str_,1,1))+
                            Ascii(nvl(substr(str_,2,1),'0'))+
                            Ascii(nvl(substr(str_,3,1),'0'))+
                            Ascii(nvl(substr(str_,4,1),'0'))+
                            Ascii(nvl(substr(str_,5,1),'0'))+
                            Ascii(nvl(substr(str_,6,1),'0'))+
                            Ascii(nvl(substr(str_,7,1),'0'))+
                            Ascii(nvl(substr(str_,8,1),'0'))+
                            Ascii(nvl(substr(str_,9,1),'0')))*
                     power(2.71828182845904523536,(length(k.allstr)-length(str_))/10)-.5);
        str_ := substr(str_,10);
      end loop;
    end loop;

    select to_number(substr(crc,16,12))
    into   crcrez_
    from   rez_protocol
    where  dat_otcn=fdat_;

--  bars_audit.info('------------------------------------- crcrez_ = '||to_char(crcrez_));
--  bars_audit.info('------------------------------------- crc_ = '   ||to_char(crc_));

    return crcrez_=crc_;

  else
    return FALSE;
  end if;

end nbu23_rez_crcchk;

--

PROCEDURE nbu23_rez_crcset (fdat_ date)
IS
  i_      number;
  crc_    number;
  str_    varchar2(4000);
  rand_   number;
  const_  varchar2(10);
begin

 IF fdat_ IS NULL THEN
    raise_application_error(-20000,'Укажiть звiтну дату !');
 END IF;

  crc_ := 0;
  i_   := 0;
  const_ := '';

  while  i_<10
  loop
    if i_=0 then
      rand_ := mod(abs(DBMS_RANDOM.random),7)+3;
    else
      rand_ := mod(abs(DBMS_RANDOM.random),10);
    end if;
    const_ := const_||to_char(rand_);
    i_     := i_+1;
  end loop;

  i_   := 0;
  select abs(DBMS_RANDOM.random)
  into   rand_
  from   dual;

  for k in (select ID           ||
                   to_char(RNK) ||
                   NBS          ||
                   to_char(KV)  ||
                   to_char(ND)  ||
                   CC_ID        ||
                   to_char(ACC) ||
                   NLS          ||
                   BRANCH       ||
                   to_char(FIN) ||
                   to_char(OBS) ||
                   to_char(KAT) ||
                   to_char(K)   ||
                   to_char(IRR) ||
                   to_char(ZAL) ||
                   to_char(BV)  ||
                   to_char(PV)  ||
                   to_char(REZ) ||
                   to_char(REZQ)||
                   DD           ||
                   DDD allstr
            from   nbu23_rez
            where  fdat=fdat_
            order by ID,KV)
  loop
    str_ := k.allstr;
    i_   := i_+1;
--  bars_audit.info(i_||' ------------------------------------- str_ = '||str_);
    while length(str_)>0
    loop
      crc_ := crc_+Round((Ascii(substr(str_,1,1))+
                          Ascii(nvl(substr(str_,2,1),'0'))+
                          Ascii(nvl(substr(str_,3,1),'0'))+
                          Ascii(nvl(substr(str_,4,1),'0'))+
                          Ascii(nvl(substr(str_,5,1),'0'))+
                          Ascii(nvl(substr(str_,6,1),'0'))+
                          Ascii(nvl(substr(str_,7,1),'0'))+
                          Ascii(nvl(substr(str_,8,1),'0'))+
                          Ascii(nvl(substr(str_,9,1),'0')))*
                   power(2.71828182845904523536,(length(k.allstr)-length(str_))/10)-.5);
      str_ := substr(str_,10);
    end loop;
  end loop;
--bars_audit.info('------------------------------------- crc_ = '||to_char(crc_));
  update REZ_PROTOCOL
  set    crc=substr(const_,7,4)||
             substr(to_char(10000000000+rand_),2,10)||
             substr(const_,1,1)||
             substr(to_char(1000000000000+crc_),2,12)||
             substr(const_,2,2)||
             substr(to_char(10000000000+to_number(const_)-rand_+i_),2,10)||
             substr(const_,4,3)
  where  dat_otcn=fdat_;
--commit;
end nbu23_rez_crcset;

-----------------------
FUNCTION header_version RETURN VARCHAR2 IS --   возвращает версию заголовка пакета
BEGIN
  RETURN 'Package header Z23 '||G_HEADER_VERSION;
END header_version;


FUNCTION body_version RETURN VARCHAR2 IS  --  возвращает версию тела пакета
BEGIN
  RETURN 'Package body Z23 '||G_BODY_VERSION;
END body_version;


END Z23;
/
 show err;
 
PROMPT *** Create  grants  Z23 ***
grant EXECUTE                                                                on Z23             to BARSUPL;
grant EXECUTE                                                                on Z23             to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on Z23             to RCC_DEAL;
grant EXECUTE                                                                on Z23             to START1;
grant EXECUTE                                                                on Z23             to UPLD;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/z23.sql =========*** End *** =======
 PROMPT ===================================================================================== 
 