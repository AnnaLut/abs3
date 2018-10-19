
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/rez.sql =========*** Run *** =======
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.REZ 
IS
/*
DESCRIPTION : Функции и процедуры для расчета резерва
VERSION     : 12.11.2008
СOMMENT     :

 Используемые модулем параметры в таблице PARAMS:

 'RZPRR013' = 1 - для определения просроченных > 31 дня процентов используется R013 (АКБ КИЕВ)
                (по умолчанию обрабатываются даты операций)
 'REZPAY2'  = 1 - для оплаты используется процедура ca_pay_rez2 (АКБ Киев)
               (по гривне только доформирование, документы создаются от отв исп по счету фонда )
 'REZPAR1'  = 1 - флаг - не разделять при обработке физиков и юриков (АКБ Киев)
 'REZPAR2'  = 1 - флаг - учитывать при расчете обеспечениеи 26 для кредитов > 2 лет (АКБ КИЕВ)
 'REZPAR3'  = 1 - флаг - специальная обработка Лизинга 2071 (АКБ Ажио), весь объект лизинга
                  движимое имущество, неучитываемую часть показываем как обеспечение с кодом 30,
              счет лизинга записывается как залог в таблицу - расшифровку залогов tmp_rez_risk2
 'REZPAR4'  = 1 - не учитывать при расчете дисконт
 'REZPAR5'  = 1 - процент резервирования по 83 постанове (уст по умолч в пакете, нету в PARAMS !!!)
 'REZPAR6'  = 1 - расчет с учетом однородных кредитов (уст по умолч в пакете, нету в PARAMS !!!)
 'REZPAR7'  = 1 - флаг - значение по умолчанию типа клиента для счетов (SK9) (custtype=1) (АКБ Киев)
 'REZPAR8'  = 1 - при расчете резерва по счетам просроченных процентов используется "смешанный алгоритм"
                  т.е. если параметр R013 заполнен
                       = 2 - резервируем 100 % остатка на отчетную дату,
                       = 1 - не резервируем
                  если не заполнен резервируем по умолчательному алгоитму
                  сумма резерва = остаток(на дату отчетная дата - 31 день) -
                                  кредитовые обороты (с отчетная дата -31 день по отчетная дата)
 'REZPAR9'  = 1 - расчет обеспечения по просроченным свыше 30 дней кредитам производится по
                  спец. алгоритму в соотв с инструкцией (анализируется признак - первичное обеспечение)

 'REZPAR10'  = 1 - перед формированием проводок по резервам проверять есть ли клиентские счета для
                   которых нет счета резерва в таблице SREZERV.
                   если да - выдавать сообщение об ошибке и проводки не формировать

 'REZPAR11'  = 1 - учитывать параметр S270 = 8 при расчете резерва по просроченным %
                   (если S270 = 8, то резервируются ВСЕ % - и начисленные, и просроченные до 31 дня
                   , и просроченные свыше, и сомнительные)

*/

   -- pacчетный S080 (по справочнику fin_obs_s080)
   -- на основе финансового состояния контрагента и состояния обслуживания долга
   FUNCTION r_s080 (fin_ INT, obs_ INT)
      RETURN CHAR;

   -- функция возвращает код вида резерва по балансовому счету
   FUNCTION id_nbs (nbs_ CHAR)
      RETURN NUMBER;

  FUNCTION id_specrez (p_dt date, p_istval number,p_kv varchar2, p_idr varchar2
                      , p_custtype varchar2  ) --T 13.01.2009
      RETURN NUMBER;

   -- остаток по счету с учетом ЗО.
   FUNCTION ostc96 (acc_ INT, dat_ DATE)
      RETURN NUMBER;

FUNCTION ostc96_3 (acc_ INT, dat_ IN DATE)
      RETURN NUMBER;

   --  расчет суммы финансового результата на дату DAT_
   --  6кл-7кл без резерва (счетов 7 класса в SREZERV)
   FUNCTION fin (dat_ IN DATE)
      RETURN NUMBER;

   -- расчет суммы дисконта в экв на дату по АСС ссудного счета
   FUNCTION ca_fq_discont (
      acc_    IN   INT,
      dat_    IN   DATE,
      mode_   IN   INT DEFAULT 0,
      par_         NUMBER DEFAULT NULL
   )
      RETURN NUMBER;

   -- расчет суммы премии в экв на дату по АСС ссудного счета
   FUNCTION ca_fq_prem (
      acc_    IN   INT,
      dat_    IN   DATE,
      mode_   IN   INT DEFAULT 0,
      par_         NUMBER DEFAULT NULL
   )
      RETURN NUMBER;

/*
    Пояснение для разработчиков по использованию функций возвращающих
    залог-обеспечение

    Все функции этого пакета возвращают "эффективное обеспечение" т.е.
   обеспечение используемое при расчете резерва:

   1. Обеспечение делится пропорционально между всеми активными счетами
       привязаннымик залогу в таблице cc_accp. В расчет принимаются активы
       которые требуют резервирования согласно инструкции НБУ !!!
    2. Процент от обеспечение определяется по specparam.S080 и pawn_acc.pawn
       (категория риска и вид залога) через справочник cc_pawn_s080.
       Категория риска по умолчанию (если не заполнено в specparam) = 1.

     В случае если не проставлен вид обеспечения, не описан или = 0
     процент от обеспечения, или актив не резервируется согласно инструкции НБУ
     (например nbs = 9129 и R013 = 9) обеспечение на данный счет актива = 0 !!!
*/

/*

   расчет суммы обеспечения в экв на дату по АСС ссудного счета

   acc_      - счет актива
   dat_      - дата
   mode_ = 0 - расчет обеспечения с учетом процента от залога
         = 1 - без учета процента от залога (для ca_fq_zalog)
         = 2 - размер процента от залога для залога вида "майнов_ права на грошов_ депозити" берется из pr (дял 42 файла)
         = 3 - расчет необеспеченной части кредита (для ca_fq_rasch)
   par_  = 1 - вводится если надо получить сумму обеспечения без  Прочих видов обеспечения (s031=33)
   pawn_     - код обеспечения, вводится если надо получить сумму на данный вид

*/
   FUNCTION ca_fq_obesp (
      acc_    IN   INT,
      dat_    IN   DATE,
      mode_   IN   INT DEFAULT 0,
      par_         NUMBER DEFAULT NULL,
      pawn_        NUMBER DEFAULT NULL
   )
      RETURN NUMBER;

        -- расчет суммы обеспечения в экв на дату по номеру кредитного договра
   -- все залоги привязанные к счетам типа SS, SP, SL, CR9
   FUNCTION ca_fq_obesp_nd (nd_ NUMBER, dat_ IN DATE, pawn_ NUMBER
            DEFAULT NULL)
      RETURN NUMBER;

   -- расчет суммы залога в экв на дату по АСС ссудного счета
   FUNCTION ca_fq_zalog (acc_ IN INT, dat_ IN DATE, pawn_ NUMBER DEFAULT NULL)
      RETURN NUMBER;

   -- расчет суммы залога в экв на дату по АСС ссудного счета для #D8
   -- в сумму включаются только обеспечения используемые при расчете резерва
   -- методикой НБУ т.е. не включаются имеющие s031 = 33, 90
   FUNCTION ca_fq_zalog_d8 (acc_ IN INT, dat_ IN DATE, pawn_ NUMBER DEFAULT NULL)
      RETURN NUMBER;

   -- расчет суммы залога в экв на дату по номеру кредитного договра
   -- все залоги привязанные к счетам типа SS, SP, SL, CR9
   FUNCTION ca_fq_zalog_nd (nd_ NUMBER, dat_ IN DATE, pawn_ NUMBER
            DEFAULT NULL)
      RETURN NUMBER;

   -- необеспеченная часть актива в экв по acc ссудного счета
   FUNCTION ca_fq_rasch (acc_ IN INT, dat_ IN DATE)
      RETURN NUMBER;

   -- необеспеченная часть актива в экв по номеру кредитного договра
   -- все залоги привязанные к счетам типа SS, SP, SL, CR9
   FUNCTION ca_fq_rasch_nd (nd_ NUMBER, dat_ IN DATE)
      RETURN NUMBER;

   -- расчет суммы РЕЗЕРВА в ном на дату по АСС ссудного счета
   FUNCTION ca_f_rezerv (acc_ IN INT, dat_ IN DATE)
      RETURN NUMBER;

   -- расчет суммы РЕЗЕРВА в экв на дату по номеру кредитного договра
   -- все залоги привязанные к счетам типа SS, SP, SL, CR9
   FUNCTION ca_f_rezerv_nd (nd_ NUMBER, dat_ IN DATE)
      RETURN NUMBER;

   -- баласовый счет - счет премии (return 1 если премия, 0 если нет)
   FUNCTION f_nbs_is_prem (nbs_ VARCHAR2)
      RETURN NUMBER;

   -- балансовый счет -  счет дисконта  (return 1 если дисконт, 0 если нет)
   FUNCTION f_nbs_is_disc (nbs_ VARCHAR2)
      RETURN NUMBER;

   -- балансовый счет - счет резервного фонда  (return 1 если фонд, 0 если нет)
   FUNCTION f_nbs_is_fond (nbs_ VARCHAR2)
      RETURN NUMBER;

   function f_get_rest_over_30(acc_ number, last_work_date_ date) return number;

   -- собственно расчет резерва
   PROCEDURE rez_risk (id_ INT, dat_ DATE, mode_ IN INT DEFAULT 0/*, pr_ in int default null*/);

   -- процедура проводок по расчету резервов .
   -- ФОРМИРОВАНИЕ резерва по состоянию на DAT_
   PROCEDURE ca_pay_rez (dat_ DATE, mode_ NUMBER DEFAULT 0, p_user number default null);

   -- версия программы оплаты для КБ Киев
   PROCEDURE ca_pay_rez2 (dat_ DATE, mode_ NUMBER DEFAULT 0);

   -- Процедура наполнения таблицы tmp_finrez.
   -- Данные таблицы представляют собой специфический отчет сделанный для банка Киев.
   -- Отчет представляет собой состояние фонда на предыдцщую и текущую отчетные даты,
   -- а также сумму доформирования резерва (по расчетнвм данным).
   -- Экранная форма связаная с отчетом, вызывается кнопкой "Резерв в разрезе валют и балансовых счетов НБУ"
   PROCEDURE p_finrez (dat1_ DATE, dat2_ DATE);

   -- процедура сверки 11 файла с расчетом резерва (устаревшая,не используется)
   PROCEDURE p_check_file11 (dat_ DATE);

   -- процедура сверки 30 файла с расчетом резерва (устаревшая,не используется)
   PROCEDURE p_check_file30 (dat_ DATE);

   -- процедура перекрестной сверки сверки 30 и 11 файлов (устаревшая, не используется)
   PROCEDURE p_check_file30_11 (dat_ DATE);

   -- Процедура наполнение таблицы tmp_rez_risk2 данными старого и нового расчета резерва
   -- Используется в экранной функции "Приращение в расчете резерва"
   PROCEDURE delta (id_ INT, dat1_ DATE, dat2_ DATE);

--     Функция возвращает остаток на счете с учетом корректирующих
--     проводок. Для поиска суммы корректирующих проводок исполь-
--     зуется временная таблица TMP_CRTX
   FUNCTION get_restc (
      p_acccode    IN   accounts.acc%TYPE,
      p_restdate   IN   saldoa.fdat%TYPE
   )
      RETURN saldoa.ostf%TYPE;

   -- Процедура установки периода дат.
   -- используется в некоторых отчетах.
   -- Устанавливаются внутренние переменные пакета
   -- dat1_ - текущая отчетная дата
   -- dat2_ - предідцщая отчетная дата
   PROCEDURE set_date (dat1_ DATE, dat2_ DATE);

   -- Функция возвращает текущую отчетнуя дату
   -- установленную процедурой set_date
   FUNCTION curdate
      RETURN DATE;

   -- Функция возвращает предыдущую отчетнуя дату
   -- установленную процедурой set_date
   FUNCTION prevdate
      RETURN DATE;

   -- Функция для получения некоторых параметров модуля (пакета) по имени параметра.
   -- Доступны следующие параметры
   -- par_ = 'VERSION' - версия пакета
   --      = 'NBSDISCONT' - строка с балансовыми счетами дисконтов (разделитель запятая)
   --      = 'NBSPREMIY'  - строка с балансовыми счетами премии (разделитель запятая)
   --      = 'USELOG'     - 1 - используется запись промежуточных данных в протокол (таб. cp_rez_log)
   --                     - 0 - протокол не используется
   --      = 'CALCDOPPAR' - 1 - при расчете выполняется расчет  и нахождение дополнительных параметров договоров
   --                     - 0 - расчета доп. параметров договоров не производится
   FUNCTION f_getpar (par_ VARCHAR2)
      RETURN VARCHAR2;


   -- процедура для установки параметров модуля
   -- можно установить два параметра
   --      = 'USELOG'     - 1 - используется запись промежуточных данных в протокол (таб. cp_rez_log)
   --                     - 0 - протокол не используется
   --      = 'CALCDOPPAR' - 1 - при расчете выполняется расчет  и нахождение дополнительных параметров договоров
   --                     - 0 - расчета доп. параметров договоров не производится
   PROCEDURE p_setpar (par_ VARCHAR2, val_ VARCHAR2);

   -- версия заголовка пакета
   FUNCTION header_version
      RETURN VARCHAR2;

   -- версия тела пакета
   FUNCTION body_version
      RETURN VARCHAR2;

   PROCEDURE set_log (acc_ number);

   PROCEDURE p_load_data (dat_ DATE, acc_ NUMBER DEFAULT NULL);
   PROCEDURE p_unload_data;


END rez;

/
CREATE OR REPLACE PACKAGE BODY BARS.REZ 
/*

  VERSION : 22.11.2017

*/
IS
   -- версия пакета
   version_        VARCHAR2 (30)   := '22.11.2017';
  sss varchar2(1000);
   c_dt date := to_date('28122008','ddmmyyyy');
   curdate_        DATE; -- текущая отчетная дата
   prevdate_       DATE; -- дата начала отчетного периода
   rownumber_      NUMBER; -- номер строки для проткола в таблице cp_rez_log
   userid_         NUMBER; -- код текущего пользователя из STAFF
   curacc_         NUMBER; -- текущее значение acc в курсорах из процедуры rez_risk
   n_              NUMBER          := 0;
   n1_             NUMBER          := 0;
   ndiscont_       NUMBER          := 0;
   ndiscont1_      NUMBER          := 0;
   nprem_          NUMBER          := 0;
   nprem1_         NUMBER          := 0;
   acckr_          NUMBER; -- асс счета, если расчет резерва производится по одному счету (вызов rez_risk из ф-й типа ca_..)
   rezerv_         NUMBER; -- сумма резерва по одному счету, используется для возврата рез расчета проц. rez_risk
   i_              NUMBER          := 0;
   i2_             NUMBER          := 0;
   i3_             NUMBER          := 0;
   i4_             NUMBER          := 0;
   -- балансовые счета дисконта
   nbsdiscont_     VARCHAR2 (2000)
      := '2236,2226,2216,2206,2116,2106,2086,2076,2066,2036,2026,1626,1526,1326,1316,';
   -- балансовые счета премии
   nbspremiy_      VARCHAR2 (2000)
      := '';
   -- балансовые счета страхового фонда
   nbsfond_        VARCHAR2 (2000)
           := ',1492,1590,1591,1592,1593,1790,2400,2401,2490,3291,3599,3690,';
   uselog_         NUMBER          := 0; -- флаг - признак, записи сообщений в таблицу протокола cp_rez_log
   calcdoppar_     NUMBER          := 1; -- признак расчета дополнительных параметров договоров при расчете резерва
   acountry        NUMBER          DEFAULT 804; -- код страны по умолчанию
   -- флаги управляющие алгоритмом расчета резерва
   rzprr013_       NUMBER          DEFAULT 0;
   rezpay2_        NUMBER          DEFAULT 0;
   rezpar1_        NUMBER          DEFAULT 0;
   rezpar2_        NUMBER          DEFAULT 0;
   rezpar3_        NUMBER          DEFAULT 0;
   rezpar4_        NUMBER          DEFAULT 0;
   rezpar5_        NUMBER          DEFAULT 1;
   rezpar6_        NUMBER          DEFAULT 1;
   rezpar7_        NUMBER          DEFAULT 0;
   rezpar8_        NUMBER          DEFAULT 0;
   rezpar9_        NUMBER          DEFAULT 0;
   rezpar10_        NUMBER          DEFAULT 0; --T 22.01.2009
   rezpar11_        NUMBER          DEFAULT 0; --T 07.04.2009
   -- флаг - обесп. по кредитам просроченным >30 дней по спец. алгоритму
   flagallrez_     NUMBER          DEFAULT 0;
   par_ob22        number := nvl(GetGlobalOption('OB22'),0);

   TYPE type_zal IS TABLE OF tmp_rez_risk2%ROWTYPE
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

   TYPE type_korprov IS RECORD (
      ob     NUMBER,
      fdat   DATE
   );

   TYPE type_korprov1 IS TABLE OF type_korprov
      INDEX BY varchar2(30);

   korprov_        type_korprov1;

   TYPE type_saldo IS RECORD (
      ost    NUMBER,
      fdat   DATE
   );

   TYPE type_saldo1 IS TABLE OF type_saldo
      INDEX BY varchar2(30);

   salost_         type_saldo1;

   TYPE type_nd_acc IS TABLE OF NUMBER
      INDEX BY varchar2(30);

   ndacc_          type_nd_acc;

   TYPE type_odncre IS TABLE OF VARCHAR2 (1)
      INDEX BY BINARY_INTEGER;

   dodncre_        type_odncre;

   TYPE type_prcrd IS TABLE OF VARCHAR2 (1)
      INDEX BY BINARY_INTEGER;

   prcrd_          type_prcrd;

   TYPE type_dnpr IS TABLE OF NUMBER
      INDEX BY BINARY_INTEGER;

   dnprcre_        type_dnpr;

   TYPE type_prcrezal IS TABLE OF VARCHAR2 (1)
      INDEX BY BINARY_INTEGER;

   prcrezal_       type_prcrezal;

   allzal_null_    type_zal;
   alldisc_null_   type_discont;
   allprem_null_   type_prem;
   korprov_null_   type_korprov1;
   salost_null_    type_saldo1;
   ndacc_null_     type_nd_acc;
   dodncre_null_   type_odncre;
   dnprcre_null_   type_dnpr;
   prcrd_null_     type_prcrd;
   prcrezal_null_       type_prcrezal;

   flagkorprov_    NUMBER          DEFAULT 0;
   g_restdate      DATE;            -- дата накопления корректирующих проводок


   -- декларация процедуры, сама процедура далее
   --PROCEDURE p_load_data (dat_ DATE, acc_ NUMBER DEFAULT NULL);

   -- процедура вставки данных в протокол расчета резерва - таблицу cp_rez_log
   PROCEDURE to_log (id_ NUMBER, txt_ VARCHAR2, val_ VARCHAR2)
   IS
      PRAGMA AUTONOMOUS_TRANSACTION;
   BEGIN
      --  dbms_output.put_line(txt_||' '||val_);
      IF uselog_ = 1 AND curacc_ = id_
      THEN
         rownumber_ := rownumber_ + 1;

         INSERT INTO cp_rez_log
                     (userid, ID, rownumber, txt, val
                     )
              VALUES (userid_, id_, rownumber_, txt_, val_
                     );

         COMMIT;
      END IF;
   END;

   PROCEDURE set_log (acc_ number)
   IS
   BEGIN
      uselog_ := 1;
      curacc_ := acc_;
      rownumber_ := 0;
   END;

-----------------------------------
   PROCEDURE p_finrez (dat1_ DATE, dat2_ DATE)
   IS
      formuser_      NUMBER;
      formuserold_   NUMBER;
      txt_           VARCHAR2 (200);
   BEGIN
      BEGIN
         SELECT userid
           INTO formuser_
           FROM rez_protocol
          WHERE dat = dat2_;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            rez.rez_risk (userid_, dat2_);
            formuser_ := userid_;
      END;

      BEGIN
         SELECT userid
           INTO formuserold_
           FROM rez_protocol
          WHERE dat = dat1_;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            formuserold_ := formuser_;
      END;

      DELETE FROM tmp_finrez;

      INSERT INTO tmp_finrez
                  (acc, fondid, kv, s080, s_oldf1, sq_oldf1, s_oldf2,
                   sq_oldf2, s_newf, sq_newf, s_del, sq_del, s_isp, sq_isp,
                   sq_curs)
         SELECT a.acc, '', a.kv, r.s080, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
           FROM srezerv r, accounts a
          WHERE r.s_fond = a.nls;

      -- 1. остатки фонда на предыдущую дату по курсу пред даты
      -- 2. остатки фонда на текущую отчетную дату по курсу тек. отчетной даты
      -- 3. остатки фонда на текущую отчетную дату по курсу пред.отчетной даты
      FOR k IN (SELECT a.nbs, a.nls, t.*
                  FROM tmp_finrez t, accounts a
                 WHERE t.acc = a.acc)
      LOOP
         DECLARE
            sn1_   NUMBER := 0;
            -- предыдущий остаток фонда с учетом корректирующих отчетного месяца
            sn2_   NUMBER := 0;
            -- суммы использования фонда на погашения кредита
            sn3_   NUMBER := 0;
            -- фактический исходящий остаток фонда на отчетную дату
            sn4_   NUMBER := 0;
            -- корректирущие проводки следующего за отчетным периодом месяца
            sn5_   NUMBER := 0;
            -- фактический исходящий остаток фонда на отчетную дату (с учетом ЗО)
            sn6_   NUMBER := 0;     -- расчетная сумма фонда на отчетную дату
            sn7_   NUMBER := 0;         -- старый фонд по данным tmp_rez_risk
         BEGIN
            -- 1.
            sn1_ := rez.ostc96 (k.acc, dat1_);

            -- 2.
            FOR b IN (SELECT o.s, p.nlsa, p.nlsb
                        FROM opldok o, oper p
                       WHERE k.acc = o.acc
                         AND o.REF = p.REF
                         AND p.vob <> '096'
                         AND o.fdat > dat1_
                         AND o.fdat <= dat2_
                         AND o.s < 0)
            LOOP
               IF     b.nlsa NOT LIKE '7%'
                  AND b.nlsa NOT LIKE '7%'
                  AND (b.nlsa = k.nls OR b.nlsb = k.nls)
                  AND SUBSTR (b.nlsa, 1, 4) <> SUBSTR (b.nlsb, 1, 4)
               THEN
                  sn2_ := sn2_ + b.s;
               END IF;
            END LOOP;

            -- 3.
            BEGIN
               SELECT s.ostf - s.dos + s.kos
                 INTO sn3_
                 FROM saldoa s
                WHERE (acc, fdat) =
                                  (SELECT   ss.acc, MAX (ss.fdat)
                                       FROM saldoa ss
                                      WHERE ss.fdat <= dat2_
                                            AND ss.acc = s.acc
                                   GROUP BY ss.acc)
                  AND s.acc = k.acc;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  sn3_ := 0;
            END;

            -- 4.
            sn4_ := 0;                                 -- пока не используется
            -- 5.
            sn5_ := rez.ostc96 (k.acc, dat2_);

            -- 6.
            BEGIN
               SELECT NVL (SUM (NVL (sz1, sz)), 0)
                 INTO sn6_
                 FROM tmp_rez_risk r, srezerv s
                WHERE r.s080 = s.s080
                  AND r.kv = k.kv
                  AND s.s_fond = k.nls
                  AND r.idr = s.ID
                  AND r.custtype = s.custtype
                  AND r.dat = dat2_
                  AND r.ID = formuser_;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  sn6_ := 0;
            END;

            txt_ := '';

            IF k.nbs = '2400'
            THEN
               txt_ := 'клиенты нестандартные ';
            ELSIF k.nbs = '2401'
            THEN
               txt_ := 'клиенты стандартные ';

               IF k.s080 = '2'
               THEN
                  txt_ := txt_ || ' (под контролем)';
               ELSIF k.s080 = '3'
               THEN
                  txt_ := txt_ || ' (субстандартные)';
               ELSIF k.s080 = '4'
               THEN
                  txt_ := txt_ || ' (сомнительные)';
               ELSIF k.s080 = '5'
               THEN
                  txt_ := txt_ || ' (безнадежные)';
               END IF;
            ELSIF k.nbs = '1590'
            THEN
               txt_ := 'межбанк нестандартные ';

               IF k.s080 = '2'
               THEN
                  txt_ := txt_ || ' (под контролем)';
               ELSIF k.s080 = '3'
               THEN
                  txt_ := txt_ || ' (субстандартные)';
               ELSIF k.s080 = '4'
               THEN
                  txt_ := txt_ || ' (сомнительные)';
               ELSIF k.s080 = '5'
               THEN
                  txt_ := txt_ || ' (безнадежные)';
               END IF;
            ELSIF k.nbs = '1591'
            THEN
               txt_ := 'межбанк стандартные ';
            ELSIF k.nbs = '1592'
            THEN
               txt_ := 'корсчета нестандартные ';
            ELSIF k.nbs = '1593'
            THEN
               txt_ := 'корсчета стандартные ';
            ELSIF k.nbs = '1790'
            THEN
               txt_ := 'межбанк просроченные доходы ';
            ELSIF k.nbs = '2490'
            THEN
               txt_ := 'клиенты просроченные доходы ';
            ELSIF k.nbs = '3599'
            THEN
               txt_ := 'клиенты прочие начисленные доходы ';
            ELSIF k.nbs = '3690'
            THEN
               txt_ := 'клиенты внебаланс ';

               IF k.s080 = '1'
               THEN
                  txt_ := txt_ || 'стандартные';
               ELSE
                  txt_ := txt_ || 'нестандартные';

                  IF k.s080 = '2'
                  THEN
                     txt_ := txt_ || ' (под контролем)';
                  ELSIF k.s080 = '3'
                  THEN
                     txt_ := txt_ || ' (субстандартные)';
                  ELSIF k.s080 = '4'
                  THEN
                     txt_ := txt_ || ' (сомнительные)';
                  ELSIF k.s080 = '5'
                  THEN
                     txt_ := txt_ || ' (безнадежные)';
                  END IF;
               END IF;
            END IF;

            UPDATE tmp_finrez
               SET s_oldf1 = sn1_ / 100,
                   sq_oldf1 = gl.p_icurval (k.kv, sn1_, dat1_) / 100,
                   s_oldf2 = sn5_ / 100,
                   sq_oldf2 = gl.p_icurval (k.kv, sn5_, dat2_) / 100,
                   s_newf = sn6_ / 100,
                   sq_newf = gl.p_icurval (k.kv, sn6_, dat2_) / 100,
                   s_isp = sn2_ / 100,
                   txt = txt_
             WHERE acc = k.acc;
         END;
      END LOOP;

      -- остатки фонда на текущую отчетную дату по курсу тек. отчетной даты
      COMMIT;
   END p_finrez;

-----------------------------------
   FUNCTION r_s080 (fin_ INT, obs_ INT)
      RETURN CHAR
   IS
--pac4. S080
      rs080_   CHAR (1);
   BEGIN
      BEGIN
         NULL;

         SELECT s080
           INTO rs080_
           FROM fin_obs_s080
          WHERE fin = fin_ AND obs = obs_;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            rs080_ := NULL;
      END;

      RETURN rs080_;
   END;

   FUNCTION id_nbs (nbs_ CHAR)
      RETURN NUMBER
   IS
--идентификатор типа резерва от бал сч.
      idr_   INT;
   BEGIN
      BEGIN
         SELECT ID
           INTO idr_
           FROM srez_id_nbs
          WHERE nbs = nbs_;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            idr_ := 0;
      END;

      RETURN idr_;
   END id_nbs;


  FUNCTION id_specrez (p_dt date, p_istval number,p_kv varchar2,
                       p_idr varchar2, p_custtype varchar2) --T 13.01.2009
      RETURN NUMBER
   IS
--идентификатор типа резерва от бал сч.
      idr_   INT;
   BEGIN
      if p_kv = '980' then return 0; end if;
      --if p_custtype = '1' then return 0; end if;
      BEGIN
         SELECT i.ID
           INTO idr_
           FROM srez_specrez i
          WHERE p_dt between i.DT_BEGIN and i.DT_END and
                decode(p_istval,1,1,0) = i.ISTVAL and
                instr(','||trim(both ',' from trim(i.id_nbs))||',',','||p_idr||',') <> 0 and
                instr(','||trim(both ',' from trim(i.custtype))||',',','||p_custtype||',') <> 0
                and rownum = 1;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            idr_ := 0;
      END;

      RETURN idr_;
   END id_specrez;


-----------
   FUNCTION ostc96 (acc_ INT, dat_ IN DATE)
      RETURN NUMBER
   IS
      ost_   NUMBER;
      ob_    NUMBER;
-- остаток с учетом ЗО
   BEGIN
      IF acc_ IS NULL
      THEN
         RETURN 0;
      END IF;

      -- to_log (acc_, 'function ostc96', '');
      IF salost_.EXISTS (to_char(acc_))
      THEN
         IF salost_ (to_char(acc_)).fdat = dat_
         THEN
            --     to_log (acc_, '..остаток1=', TO_CHAR (salost_ (acc_).ost));
            dbms_output.put_line('..остаток1= '|| TO_CHAR (salost_ (to_char(acc_)).ost));
            RETURN salost_ (to_char(acc_)).ost;
         END IF;
      END IF;

      BEGIN
         SELECT ostf - dos + kos
           INTO ost_
           FROM saldoa
          WHERE acc = acc_
            AND (acc, fdat) = (SELECT   acc, MAX (fdat)
                                   FROM saldoa
                                  WHERE acc = acc_ AND fdat <= dat_
                               GROUP BY acc);

         to_log (acc_, '..остаток2=', TO_CHAR (ost_));
         dbms_output.put_line('..остаток2= '|| TO_CHAR (ost_));
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            to_log (acc_, '..остаток2(данных в saldoa не найдено)=', '0');
            ost_ := 0;
            dbms_output.put_line('..остаток2(данных в saldoa не найдено)='|| '0');
      END;

      IF flagkorprov_ = 0
      THEN
         SELECT /*+ index(o IDX_OPLDOK_ACC) */NVL (SUM (DECODE (o.dk, 1, o.s, -o.s)), 0)
           INTO ob_
           FROM opldok o, oper p
          WHERE o.REF = p.REF
            AND o.sos = 5
            AND p.vob = 96
            AND o.acc = acc_
            AND o.fdat BETWEEN dat_ + 1 AND dat_ + 20
            --AND p.vdat <= dat_
            AND p.vdat = dat_;

         ost_ := ost_ + ob_;
         to_log (acc_, '..корректирующие1=', TO_CHAR (ob_));
         dbms_output.put_line('..корректирующие1='|| TO_CHAR (ob_));
      ELSE
         IF korprov_.EXISTS (to_char(acc_))
         THEN
            IF korprov_ (to_char(acc_)).fdat = dat_
            THEN
               to_log (acc_,
                       '..корректирующие2=',
                       TO_CHAR (NVL (korprov_ (to_char(acc_)).ob, 0))
                      );
              dbms_output.put_line('..корректирующие2='|| TO_CHAR (NVL (korprov_ (to_char(acc_)).ob, 0)));
               ost_ := ost_ + NVL (korprov_ (to_char(acc_)).ob, 0);
            ELSE
               SELECT NVL (SUM (DECODE (o.dk, 1, o.s, -o.s)), 0)
                 INTO ob_
                 FROM opldok o, oper p
                WHERE o.REF = p.REF
                  AND o.sos = 5
                  AND p.vob = 96
                  AND o.acc = acc_
                  AND o.fdat BETWEEN dat_ + 1 AND dat_ + 20
                  AND p.vdat = dat_;

               to_log (acc_, '..корректирующие3=', TO_CHAR (ob_));
                dbms_output.put_line('..корректирующие3='|| TO_CHAR (ob_));
               korprov_ (to_char(acc_)).ob := ob_;
               korprov_ (to_char(acc_)).fdat := dat_;
               ost_ := ost_ + ob_;
            END IF;
         END IF;
      END IF;

      salost_ (to_char(acc_)).ost := ost_;
      salost_ (to_char(acc_)).fdat := dat_;
      RETURN ost_;
   END ostc96;

-------------------------------------
   -- Для совместимости оставлен старый вариант функции получения остатка с учетом корректирующих.
   -- Функция использует данные вр. табл. tmp_crtx
   FUNCTION ostc96_2 (acc_ INT, dat_ IN DATE)
      RETURN NUMBER
   IS
      ost_   NUMBER;
-- остаток с учетом ЗО
   BEGIN
      BEGIN
         SELECT ostf - dos + kos
           INTO ost_
           FROM saldoa
          WHERE acc = acc_
            AND (acc, fdat) = (SELECT   acc, MAX (fdat)
                                   FROM saldoa
                                  WHERE acc = acc_ AND fdat <= dat_
                               GROUP BY acc);
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            ost_ := 0;
      END;

      SELECT ost_ + NVL (SUM (DECODE (dk, 1, s, -s)), 0)
        INTO ost_
        FROM tmp_crtx
       WHERE vob = 96 AND acc = acc_ AND fdat > dat_ AND vdat <= dat_;

      RETURN ost_;
   END ostc96_2;

-------------------------------------
   -- Функция нахождения остатка на счету на заданную дату.
   -- Используется для счетов просроченных >31 дня.
   -- Функция отдельно выделена, поскольку для счетов просроченных
   -- процентов логика нахождения остатка (на дату -31) может отличаться
   -- от логики нахождения остатка для обычных кредитов.
   -- В данной версии функции не обрабатываются корректирующие проводки.
   FUNCTION ostc96_3 (acc_ INT, dat_ IN DATE)
      RETURN NUMBER
   IS
      ost_     NUMBER;
      ldate_   DATE;
-- остаток с учетом ЗО
   BEGIN
      BEGIN
         SELECT ostf - dos + kos
           INTO ost_
           FROM saldoa
          WHERE acc = acc_
            AND (acc, fdat) = (SELECT   acc, MAX (fdat)
                                   FROM saldoa
                                  WHERE acc = acc_ AND fdat <= dat_
                               GROUP BY acc);
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            ost_ := 0;
      END;

      ldate_ := LAST_DAY (dat_);
--       IF flagkorprov_ = 0
--       THEN
--          SELECT ost_ + NVL (SUM (DECODE (o.dk, 1, o.s, -o.s)), 0)
--            INTO ost_
--            FROM opldok o, oper p
--           WHERE o.REF = p.REF
--             AND o.sos = 5
--             AND p.vob = 96
--             AND o.acc = acc_
--             AND o.fdat > dat_
--             AND p.vdat <= ldate_;
--       ELSE
--          IF korprov_.EXISTS (acc_)
--          THEN
--             ost_ := ost_ + NVL (korprov_ (acc_), 0);
--          END IF;
--       END IF;

      /* select ost_+ nvl(sum(decode(dk,1,S,-S)),0)
       into ost_
       from tmp_crtx
       where vob = 96
         and acc = ACC_
        and fdat >  dat_
        and vdat <= dat_;*/
      RETURN ost_;
   END ostc96_3;


-------------------------------------
   FUNCTION fin (dat_ DATE)
      RETURN NUMBER
   IS
      sf1_           NUMBER;
      sf2_           NUMBER;
      dat1_          DATE;
      ern   CONSTANT POSITIVE      := 208;
      err            EXCEPTION;
      erm            VARCHAR2 (80);
   BEGIN
      SELECT NVL (MAX (vdat), bankdate)
        INTO dat1_
        FROM oper
       WHERE tt IN ('ARE', 'AR*') AND sos = 5;

      sf1_ := 0;
      sf2_ := 0;

      SELECT NVL (SUM (rez.ostc96 (acc, dat_)), 0)
        INTO sf1_
        FROM accounts
       WHERE SUBSTR (nls, 1, 1) IN ('6', '7') AND kv = 980;

      SELECT NVL (SUM (gl.p_icurval (a.kv, rez.ostc96 (a.acc, dat_), dat1_)),
                  0
                 )
        INTO sf2_
        FROM accounts a, srezerv s
       WHERE a.nls = s.s_fond;

      RETURN ((sf1_ + sf2_) / 100);
   END fin;

-----------------------------------
   FUNCTION f_getpar (par_ VARCHAR2)
      RETURN VARCHAR2
   IS
   BEGIN
      IF par_ = 'VERSION'
      THEN
         RETURN version_;
      ELSIF par_ = 'NBSDISCONT'
      THEN
         RETURN nbsdiscont_;
      ELSIF par_ = 'NBSPREMIY'
      THEN
         RETURN nbspremiy_;
      ELSIF par_ = 'USELOG'
      THEN
         RETURN TO_CHAR (uselog_);
      ELSIF par_ = 'CALCDOPPAR'
      THEN
         RETURN TO_CHAR (calcdoppar_);
      END IF;

      RETURN '';
   END f_getpar;

   PROCEDURE p_setpar (par_ VARCHAR2, val_ VARCHAR2)
   IS
   BEGIN
      IF par_ = 'USELOG'
      THEN
         uselog_ := TO_NUMBER (val_);
      ELSIF par_ = 'CALCDOPPAR'
      THEN
         calcdoppar_ := TO_NUMBER (val_);
      END IF;
   END;

-----------------------------------
   FUNCTION header_version
      RETURN VARCHAR2
   IS
   BEGIN
      RETURN f_getpar ('VERSION');
   END;

-----------------------------------
   FUNCTION body_version
      RETURN VARCHAR2
   IS
   BEGIN

      RETURN f_getpar ('VERSION');

   END;

-----------------------------------
   FUNCTION ca_fq_obesp (
      acc_         INT,
      dat_         DATE,
      mode_   IN   INT DEFAULT 0,
      par_         NUMBER DEFAULT NULL,
      pawn_        NUMBER DEFAULT NULL
   )
      RETURN NUMBER
   IS
      sk1_                   NUMBER;                -- suma 1 kredita   в экв
      sk2_                   NUMBER;
      sz_                    NUMBER;                -- suma zaloga all  в экв
      sz1_                   NUMBER;                -- suma 1 zaloga    в экв
      sk_                    NUMBER;                -- suma kredita all в экв
      s080_                  CHAR (1);
      s090_                  CHAR (1);
      r013_                  CHAR (5);
      r031_                  CHAR (1);
      istval_                NUMBER;
      pr_                    NUMBER;
      pr2_                   NUMBER;
      pr3_                   NUMBER;
      pr4_                   NUMBER;
      kvk_                   NUMBER;                        -- валюта кредита
      dni_                   NUMBER;
      kk_                    NUMBER (20, 10);
      kk2_                   NUMBER;
      ostc_zo_               NUMBER;       --  сумма счета залога с учетом ЗО
      x9_                    VARCHAR2 (9);
      del_                   NUMBER;
      delq_                  NUMBER;
      nls_                   VARCHAR2 (15);
      kdate_                 DATE;
      wdate_                 DATE;
      k_                     NUMBER          := 1;
      onezals_               NUMBER          := 0;
      discont_               NUMBER          := 0;
      premiy_                NUMBER          := 0;
      datlizd_               DATE;
      datlizn_               NUMBER;
      prliz_                 NUMBER;
      nd_                    NUMBER;
      ret_                   NUMBER;
      sl_                    NUMBER;
      nbs_                   VARCHAR2 (4);
      rnk_                   NUMBER;
      fl_use_as_first_zal_   NUMBER          := 0;
      -- счет привязанного к залогу кредита просрочен >30 дней
      ern           CONSTANT POSITIVE        := 208;
      err                    EXCEPTION;
      erm                    VARCHAR2 (80);
   BEGIN
      IF acc_ IS NULL
      THEN
         RETURN 0;
      END IF;

      to_log (acc_, 'function ca_fq_obesp', '');
      sz_ := 0;
      n1_ := 0;
      onezal_.DELETE;

      IF flagallrez_ = 0
      THEN
         p_load_data (dat_, acc_);
      END IF;

      -- сумма 1-го кредита на дату dat_ (с ЗО)
      BEGIN
         SELECT gl.p_icurval (a.kv,
                               rez.ostc96 (a.acc, dat_),
                              dat_
                             ),
                NVL (p.s080, '1') s080, p.s090, NVL (p.istval, '0') istval,
                a.nbs || DECODE (NVL (p.r013, '1'), '9', '9', '1'), a.kv,
                a.nls, a.nbs, c.rnk
           INTO sk1_,
                s080_, s090_, istval_,
                r013_, kvk_,
                nls_, nbs_, rnk_
           FROM accounts a, specparam p, cust_acc c
          WHERE a.acc = p.acc(+) AND a.acc = c.acc AND a.acc = acc_;

         to_log (acc_, 'sk1_ остаток по '||acc_, TO_CHAR (sk1_));
         to_log (acc_, 's080_', s080_);
         to_log (acc_, 'istval_', istval_);
         to_log (acc_, 'r013_', r013_);
         to_log (acc_, 'kvk_', kvk_);
         to_log (acc_, 'nbs_', nbs_);

         IF dodncre_.EXISTS (rnk_) AND s090_ = '4'
         THEN
            to_log (acc_, 'однородный кредит', '');

            IF mode_ = '3'
            THEN
               RETURN ABS (sk1_);
            ELSE
               RETURN 0;
            END IF;
         END IF;

         BEGIN
            IF ndacc_.EXISTS (to_char(acc_))
            THEN
               nd_ := ndacc_ (to_char(acc_));
            ELSE
               SELECT MAX (nd)
                 INTO nd_
                 FROM nd_acc
                WHERE acc = acc_;
            END IF;

            SELECT wdate
              INTO wdate_
              FROM cc_add
             WHERE nd = nd_ AND adds = 0;

            dni_ := dat_ - wdate_;
         EXCEPTION
            WHEN OTHERS
            THEN
               wdate_ := NULL;
               dni_ := 0;
         END;

         to_log (acc_, 'dni_', dni_);
         discont_ := rez.ca_fq_discont (acc_, dat_, 1);
         premiy_ := rez.ca_fq_prem (acc_, dat_, 1);
         to_log (acc_, 'discont_', discont_);
         to_log (acc_, 'premiy_', premiy_);
         -- коррекция на дисконт
         del_ := 0;
         delq_ := 0;
         sk1_ := sk1_ + delq_ + discont_ + premiy_;
         to_log (acc_, 'sk1_ остаток по '||acc_||' +диск. и прем.', sk1_);

         IF r013_ = '91299' OR r013_ = '90031' OR sk1_ > 0
         THEN
            to_log (acc_, 'спец обр 9129, 9003 sk1_=0', '');
            sk1_ := 0;
         END IF;

         IF SUBSTR (r013_, 1, 4) IN ('9100', '9129')
         THEN
            to_log (acc_, 'спец обр 9100, 9129 sk1_=50%sk1_', '');
            sk1_ := ROUND (0.5 * sk1_);
         END IF;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            RETURN 0;
      END;

      -- проверить все договора залога на этот кредит с ЗО
      FOR k IN (SELECT z.acc, a.kv, a.nls, a.nbs,
                        rez.ostc96 (a.acc, dat_) ostc,
                       sz.pawn, c.s031, k.r031, z.pr_12
                  FROM cc_accp z,
                       accounts a,
                       pawn_acc sz,
                       cc_pawn c,
                       kl_r030 k
                 WHERE z.accs = acc_
                   AND z.acc = a.acc
                   AND sz.acc = z.acc
                   AND c.pawn = sz.pawn
                   AND TO_NUMBER (k.r030) = a.kv
                   --T 19.03.2009
                   and (par_ob22 = 0 or
                        --для СБЕРБАНКа не учитываем гарантии (9031)
                       (par_ob22 = 1 and a.nbs <> '9031')
                    -- and a.nbs <> '9031'
                      )
                   )
      LOOP
         IF k.s031 IN ('33', '90') AND par_ = 1
         THEN
            ostc_zo_ := 0;
         ELSE
            ostc_zo_ := gl.p_icurval (k.kv, k.ostc, dat_);
         END IF;

         -- если данное обеспечение является первичным, а кредит просрочен > 30 дней
         -- то используем только для данного кредита
         fl_use_as_first_zal_ := 0;

         IF prcrezal_.EXISTS (k.acc)
         THEN
            -- если acc_ не относится к кредиту просроченному > 30 дней
            -- обеспечение не очитывается
            IF NOT prcrd_.EXISTS (nd_)
            THEN
               ostc_zo_ := 0;
               fl_use_as_first_zal_ := 0;
            ELSE
               fl_use_as_first_zal_ := 1;
            END IF;
         END IF;
         to_log (acc_, 'fl_use_as_first_zal_', TO_CHAR (fl_use_as_first_zal_));
         -- сумма всех кредитов, имеющих текущий k.NDZ общий дог залога
         -- только отрицательные  п2600 не брать !
         sk_ := 0;
         discont_ := 0;
         premiy_ := 0;
         to_log (acc_, 'ostc_zo_ сумма текущего залога -'|| k.nls, TO_CHAR (ostc_zo_));

         FOR k1 IN (SELECT rez.ostc96 (a.acc, dat_) s, n.nd, p.s090, a.kv,
                           a.nls, a.acc,
                              a.nbs
                           || DECODE (NVL (p.r013, '1'), '9', '9', '1') r013
                      FROM accounts a,
                           specparam p,
                           cust_acc ca,
                           (SELECT   acc, MAX (nd) nd
                                FROM nd_acc
                            GROUP BY acc) n
                     WHERE a.acc IN (SELECT accs
                                       FROM cc_accp
                                      WHERE acc = k.acc)
                       AND a.acc = p.acc(+)
                       AND a.acc = ca.acc
                       AND a.acc = n.acc(+)
                       AND f_nbs_is_prem (a.nbs) = 0)
         LOOP
            -- IF    fl_use_as_first_zal_ = 1 AND (k1.acc = acc_ or k1.nd=nd_)
            --    OR fl_use_as_first_zal_ = 0 and not prcrezal_.EXISTS (k.acc)
            -- THEN
                --       to_log (acc_, '*** 1', '');
            IF k1.s < 0 AND k1.r013 <> '91299' AND k1.r013 <> '90031'
            THEN
--            to_log (acc_, '*** 1', '');
                  -- 1. рассматриваем как кредиты все кроме однородных кредитов
                  -- 2. в расчете пропорции для первичного залога (cc_accp.pr_12 =1)
                  --    не участвуют счета относящиеся к другим договрам
               to_log (acc_, '  остаток по' ||k1.nls||'('||k1.acc||') =', TO_CHAR (k1.s));
               IF     (k1.s090 IS NULL OR k1.s090 <> '4')
                  AND (       fl_use_as_first_zal_ = 1
                          AND (k1.acc = acc_ OR k1.nd = nd_)
                       OR     fl_use_as_first_zal_ = 0
                          AND NOT prcrezal_.EXISTS (k.acc)
                      )
               THEN
                  IF SUBSTR (k1.r013, 1, 4) IN ('9100', '9129')
                  THEN
                     sk_ := sk_ + 0.5 * gl.p_icurval (k1.kv, k1.s, dat_);
                  ELSE
                     sk_ := sk_ + gl.p_icurval (k1.kv, k1.s, dat_);
                  END IF;
               END IF;

               to_log (acc_, '  остаток с накоплением' ||k1.nls||'('||k1.acc||') =', TO_CHAR (sk_));

               discont_ := rez.ca_fq_discont (k1.acc, dat_, 1);
               premiy_ := rez.ca_fq_prem (k1.acc, dat_, 1);

               -- коррекция del_ на дисконт
               IF SUBSTR (k1.nls, 1, 4) = '2020'
               THEN
                  x9_ := SUBSTR (k1.nls, 6, 9);
                  del_ := 0;
                  delq_ := 0;
               ELSE
                  del_ := 0;
                  delq_ := 0;
               END IF;

               sk_ := LEAST (sk_ + delq_ + discont_ + premiy_, 0);
               to_log (acc_, 'sk_ по' ||k1.nls||'=', TO_CHAR (sk_));
            END IF;
         -- END IF;
         END LOOP;

         IF sk_ <> 0
         THEN
            -- обработка видов залога
            BEGIN
               SELECT pr, pr2, pr3, prold
                 INTO pr_, pr2_, pr3_, pr4_
                 FROM cc_pawn_s080
                WHERE pawn = k.pawn AND s080 = s080_;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  pr_ := 0;
                  pr2_ := 0;
                  pr3_ := 0;
                  pr4_ := 0;
            END;

            -- 15 майнови права на грошов_ депозити
            -- 25 нерухоме майно що належить до житлового фонду
            -- 26 майнови права на майбутне нерухоме майно
            IF k.s031 = '15'
            THEN
               IF kvk_ <> k.kv AND k.r031 NOT IN ('2')
               THEN
                  IF mode_ <> 2
                  THEN
                     pr_ := NVL (pr2_, pr_);
                  END IF;
               END IF;
            ELSIF k.s031 = '25'
            THEN
               IF kvk_ <> '980'
               THEN
                  pr_ := NVL (pr2_, pr_);
               END IF;
            ELSIF k.s031 = '26' AND rezpar2_ <> 1
            THEN
               IF dni_ / 365 > 2
               THEN
                  pr_ := 0;
               END IF;
            END IF;

            IF mode_ = 1
            THEN
               --IF k.nbs = '9031'
               --THEN
               --   pr_ := 0;
               --ELSE
               pr_ := 100;
            ---END IF;
            END IF;

            to_log (acc_, k.nls, '');
            to_log (acc_, 'pr_', pr_);

            IF pr_ <> 0
            THEN
               kk_ := sk1_ / sk_;
               sz1_ := ostc_zo_ * kk_ * pr_ / 100;
               n1_ := n1_ + 1;
               onezal_ (n1_).dat := dat_;
               onezal_ (n1_).userid := userid_;
               onezal_ (n1_).accs := acc_;
               onezal_ (n1_).accz := k.acc;
               onezal_ (n1_).pawn := k.pawn;
               onezal_ (n1_).s := ROUND (ABS (sz1_));
               onezal_ (n1_).proc := pr_;
               sz_ := sz_ + ROUND (ABS (sz1_));
               to_log (acc_, 'ostc_zo_ сумма текущего залога -'|| k.nls, ostc_zo_);
               to_log (acc_, 'kk_ = sk1_(счет)/sk_(сумма всех счетов)', kk_);
               to_log (acc_, 'sz1_ сумма по текущему счету залога = ostc_zo_*kk_*pr_/100', sz1_);
               to_log (acc_, 'sz_ сумма по всем залогам', sz_);
            END IF;
         END IF;
      END LOOP;

      IF SUBSTR (nls_, 1, 4) = '2071' AND rezpar3_ = '1'
      THEN
         -- финансовый лизинг процент по инструкции 411
         -- в данной версии весь остаток считаем объектом резервирования

         -- дата лизинга - срок от возникновения остатка на счету до
         -- отчетной даты
         -- год - принят 365 дней
         SELECT MIN (fdat)
           INTO datlizd_
           FROM saldoa
          WHERE acc = acc_ AND fdat <= dat_ AND dos <> 0;

         IF datlizd_ IS NULL OR dat_ - datlizd_ <= 365
         THEN
            datlizn_ := 0;
         ELSIF dat_ - datlizd_ <= 730
         THEN
            datlizn_ := 1;
         ELSIF dat_ - datlizd_ > 730
         THEN
            datlizn_ := 2;
         ELSE
            datlizn_ := NULL;
         END IF;

         prliz_ := 0;

         IF datlizn_ IS NOT NULL
         THEN
            IF s080_ = 1
            THEN
               IF datlizn_ = 0
               THEN
                  prliz_ := 80;
               ELSIF datlizn_ = 1
               THEN
                  prliz_ := 65;
               ELSIF datlizn_ = 2
               THEN
                  prliz_ := 50;
               END IF;
            ELSIF s080_ = 2
            THEN
               IF datlizn_ = 0
               THEN
                  prliz_ := 80;
               ELSIF datlizn_ = 1
               THEN
                  prliz_ := 65;
               ELSIF datlizn_ = 2
               THEN
                  prliz_ := 50;
               END IF;
            ELSIF s080_ = 3
            THEN
               IF datlizn_ = 0
               THEN
                  prliz_ := 60;
               ELSIF datlizn_ = 1
               THEN
                  prliz_ := 50;
               ELSIF datlizn_ = 2
               THEN
                  prliz_ := 35;
               END IF;
            ELSIF s080_ = 4
            THEN
               IF datlizn_ = 0
               THEN
                  prliz_ := 20;
               ELSIF datlizn_ = 1
               THEN
                  prliz_ := 10;
               ELSIF datlizn_ = 2
               THEN
                  prliz_ := 5;
               END IF;
            ELSIF s080_ = 5
            THEN
               prliz_ := 0;
            END IF;
         END IF;

         BEGIN
            SELECT gl.p_icurval (kvk_, s.dos, s.fdat)
              INTO sl_
              FROM saldoa s
             WHERE s.fdat = datlizd_ AND acc = acc_;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               sl_ := 0;
         END;

         n1_ := n1_ + 1;
         onezal_ (n1_).dat := dat_;
         onezal_ (n1_).userid := userid_;
         onezal_ (n1_).accs := acc_;
         onezal_ (n1_).accz := acc_;
         onezal_ (n1_).pawn := '30';
         onezal_ (n1_).s := ROUND (ABS (sl_ * prliz_ / 100));
         onezal_ (n1_).proc := prliz_;
         sz_ := sz_ + ROUND (ABS (sl_ * prliz_ / 100));
      END IF;

      -- расчет приведенного обеспечения
      IF ABS (sk1_) < ABS (sz_)
      THEN
         k_ := ABS (sk1_ / sz_);
      END IF;

      IF onezal_.COUNT > 0 AND mode_ IN (0, 1)
      THEN
         FOR p IN onezal_.FIRST .. onezal_.LAST
         LOOP
            n_ := n_ + 1;
            allzal_ (n_).dat := dat_;
            allzal_ (n_).userid := userid_;
            allzal_ (n_).accs := onezal_ (p).accs;
            allzal_ (n_).accz := onezal_ (p).accz;
            allzal_ (n_).pawn := onezal_ (p).pawn;
            allzal_ (n_).s := onezal_ (p).s;
            allzal_ (n_).proc := onezal_ (p).proc;
            onezals_ := onezals_ + ROUND (onezal_ (p).s * k_);

            IF p = onezal_.LAST AND k_ <> 1
            THEN
               allzal_ (n_).spriv :=
                            ROUND (onezal_ (p).s * k_)
                          + (onezals_ - ABS (sk1_));
            ELSE
               allzal_ (n_).spriv := ROUND (onezal_ (p).s * k_);
            END IF;

            onezal_ (p).spriv := allzal_ (n_).spriv;

            IF mode_ = 1
            THEN
               IF allzal_.COUNT > 0 AND allzal_.EXISTS (n_)
               THEN
                  allzal_.DELETE (n_);
               END IF;
            END IF;
         END LOOP;
      END IF;

      IF pawn_ IS NULL
      THEN
         to_log (acc_, 'if pawn is null ', ret_);

         IF mode_ = 3
         THEN
            ret_ := GREATEST (ABS (sk1_) - sz_, 0);
         ELSE
            ret_ := ABS (sz_);
         END IF;
      ELSE
         ret_ := 0;

         IF onezal_.COUNT > 0
         --AND mode_ = 0
         THEN
            to_log (acc_, 'onezal_ loop ', ret_);

            FOR p IN onezal_.FIRST .. onezal_.LAST
            LOOP
               to_log (acc_, 'p ', p);
               to_log (acc_, 'onezal_ (p).spriv', onezal_ (p).spriv);
               to_log (acc_, 'onezal_ (p).s', onezal_ (p).s);

               IF onezal_ (p).pawn = pawn_
               THEN
                  IF mode_ = 0
                  THEN
                     ret_ := ret_ + onezal_ (p).spriv;
                  ELSE
                     ret_ := ret_ + onezal_ (p).s;
                  END IF;

                  to_log (acc_, 'ret_', ret_);
               END IF;
            END LOOP;
         END IF;
      END IF;

      to_log (acc_, 'return ret_', ret_);
      RETURN ret_;
   END ca_fq_obesp;

-----------------------------------
   FUNCTION ca_fq_obesp_nd (nd_ NUMBER, dat_ IN DATE, pawn_ NUMBER
            DEFAULT NULL)
      RETURN NUMBER
   IS
      s_   NUMBER;
   BEGIN
      SELECT NVL (SUM (rez.ca_fq_obesp (a.acc, dat_, 0, NULL, pawn_)), 0)
        INTO s_
        FROM accounts a, nd_acc n
       WHERE a.acc = n.acc
         AND a.tip IN ('SS ', 'SL ', 'SP ', 'CR9')
         AND n.nd = nd_;

      RETURN s_;
   END;

-----------------------------------
   FUNCTION ca_fq_discont (
      acc_         INT,
      dat_         DATE,
      mode_   IN   INT DEFAULT 0,
      par_         NUMBER DEFAULT NULL
   )
      RETURN NUMBER
   IS
      skqall_        NUMBER;
      skq_           NUMBER;
      sdqall_        NUMBER;
      sdq_           NUMBER        := 0;
      nd_            NUMBER;
      n1_            NUMBER;
      kv_            NUMBER;
      x9_            VARCHAR2 (9);
      accd_          NUMBER;
      ern   CONSTANT POSITIVE      := 208;
      err            EXCEPTION;
      erm            VARCHAR2 (80);
   BEGIN
      IF acc_ IS NULL
      THEN
         RETURN 0;
      END IF;

      IF rezpar4_ = '1'
      THEN
         RETURN 0;
      END IF;

      ndiscont1_ := 0;
      onedisc_.DELETE;

      -- сумма 1-го кредита на дату dat_ (с ЗО)
      BEGIN
         SELECT ABS (gl.p_icurval (a.kv, rez.ostc96 (a.acc, dat_), dat_))
           INTO skq_
           FROM accounts a
          WHERE acc = acc_ AND a.tip IN ('SS', 'SP', 'SL');
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            skq_ := 0;
      END;

      BEGIN
         IF ndacc_.EXISTS (to_char(acc_))
         THEN
            nd_ := ndacc_ (to_char(acc_));
         ELSE
            SELECT MAX (nd)
              INTO nd_
              FROM nd_acc n
             WHERE acc = acc_;
         END IF;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            nd_ := NULL;
      END;

      SELECT NVL (ABS (SUM (gl.p_icurval (a.kv, rez.ostc96 (a.acc, dat_),
                                          dat_)
                           )
                      ),
                  0
                 )
        INTO skqall_
        FROM accounts a, nd_acc n
       WHERE a.acc = n.acc
         AND a.tip IN ('SS', 'SP', 'SL')
         AND f_nbs_is_disc (a.nbs) = 0
         AND n.nd = nd_;

      SELECT NVL (SUM (gl.p_icurval (a.kv, rez.ostc96 (a.acc, dat_), dat_)),
                  0)
        INTO sdqall_
        FROM accounts a, nd_acc n
       WHERE a.acc = n.acc AND a.tip = 'SDI' AND n.nd = nd_;

      FOR k IN (SELECT a.acc,
                       gl.p_icurval (a.kv, rez.ostc96 (a.acc, dat_),
                                     dat_) sdq
                  FROM accounts a, nd_acc n
                 WHERE a.acc = n.acc AND a.tip = 'SDI'
                       AND n.nd = nd_)
      LOOP
         ndiscont1_ := ndiscont1_ + 1;

         IF skqall_ <> 0
         THEN
            sdq_ := sdq_ + ROUND (k.sdq * skq_ / skqall_);
         ELSE
            sdq_ := 0;
         END IF;

         IF mode_ = 0
         THEN
            onedisc_ (ndiscont1_).dat := dat_;
            onedisc_ (ndiscont1_).userid := userid_;
            onedisc_ (ndiscont1_).accs := acc_;
            onedisc_ (ndiscont1_).accd := k.acc;
            onedisc_ (ndiscont1_).nd := nd_;
            onedisc_ (ndiscont1_).sk := skq_;
            onedisc_ (ndiscont1_).skall := skqall_;
            onedisc_ (ndiscont1_).sd := ROUND (k.sdq * skq_ / skqall_);
            onedisc_ (ndiscont1_).sdall := sdqall_;
         END IF;
      END LOOP;

      -- дисконт для счетов не охваченных кредитным портфелем
      -- пока только для 2020 и 2026
      IF sdqall_ = 0
      THEN
         ndiscont1_ := ndiscont1_ + 1;

         BEGIN
            SELECT ABS (gl.p_icurval (a.kv, rez.ostc96 (a.acc, dat_), dat_)),
                   SUBSTR (a.nls, 6, 9), a.kv
              INTO skq_,
                   x9_, kv_
              FROM accounts a
             WHERE acc = acc_ AND a.nbs = '2020';
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               skq_ := 0;
         END;

         skqall_ := skq_;

         BEGIN
            SELECT gl.p_icurval (kv, rez.ostc96 (acc, dat_), dat_), acc
              INTO sdqall_, accd_
              FROM accounts
             WHERE nbs = '2026' AND SUBSTR (nls, 6, 9) = x9_ AND kv = kv_;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
                  --sdqall_ := 0;
               --accd_:=null;
               RETURN 0;
         END;

         sdq_ := sdqall_;
         nd_ := NULL;

         IF mode_ = 0
         THEN
            onedisc_ (ndiscont1_).dat := dat_;
            onedisc_ (ndiscont1_).userid := userid_;
            onedisc_ (ndiscont1_).accs := acc_;
            onedisc_ (ndiscont1_).accd := accd_;
            onedisc_ (ndiscont1_).nd := nd_;
            onedisc_ (ndiscont1_).sk := skq_;
            onedisc_ (ndiscont1_).skall := skqall_;
            onedisc_ (ndiscont1_).sd := ROUND (sdq_ * skq_ / skqall_);
            onedisc_ (ndiscont1_).sdall := sdqall_;
         END IF;
      END IF;

      IF onedisc_.COUNT > 0 AND mode_ = 0
      THEN
         FOR p IN onedisc_.FIRST .. onedisc_.LAST
         LOOP
            ndiscont_ := ndiscont_ + 1;
            alldisc_ (ndiscont_) := onedisc_ (p);
         END LOOP;
      END IF;

      RETURN sdq_;
   EXCEPTION
      WHEN OTHERS
      THEN
         RETURN 0;
   END;

-----------------------------------
   FUNCTION ca_fq_prem (
      acc_         INT,
      dat_         DATE,
      mode_   IN   INT DEFAULT 0,
      par_         NUMBER DEFAULT NULL
   )
      RETURN NUMBER
   IS
      skqall_        NUMBER;
      skq_           NUMBER;
      spqall_        NUMBER;
      spq_           NUMBER        := 0;
      nd_            NUMBER;
      n1_            NUMBER;
      kv_            NUMBER;
      x9_            VARCHAR2 (9);
      accd_          NUMBER;
      ern   CONSTANT POSITIVE      := 208;
      err            EXCEPTION;
      erm            VARCHAR2 (80);
   BEGIN
      IF acc_ IS NULL
      THEN
         RETURN 0;
      END IF;

      IF rezpar4_ = '1'
      THEN
         RETURN 0;
      END IF;

      nprem1_ := 0;
      oneprem_.DELETE;

      -- сумма 1-го кредита на дату dat_ (с ЗО)
      BEGIN
         SELECT ABS (gl.p_icurval (a.kv, rez.ostc96 (a.acc, dat_), dat_))
           INTO skq_
           FROM accounts a
          WHERE acc = acc_ AND a.tip IN ('SS', 'SP', 'SL');
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            skq_ := 0;
      END;

      BEGIN
         IF ndacc_.EXISTS (to_char(acc_))
         THEN
            nd_ := ndacc_ (to_char(acc_));
         ELSE
            SELECT DISTINCT nd
                       INTO nd_
                       FROM nd_acc n
                      WHERE acc = acc_;
         END IF;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            nd_ := NULL;
      END;

      SELECT NVL (ABS (SUM (gl.p_icurval (a.kv, rez.ostc96 (a.acc, dat_),
                                          dat_)
                           )
                      ),
                  0
                 )
        INTO skqall_
        FROM accounts a, nd_acc n
       WHERE a.acc = n.acc
         AND a.tip IN ('SS', 'SP', 'SL')
         AND f_nbs_is_prem (a.nbs) = 0
         AND n.nd = nd_;

      SELECT NVL (SUM (gl.p_icurval (a.kv, rez.ostc96 (a.acc, dat_), dat_)),
                  0)
        INTO spqall_
        FROM accounts a, nd_acc n
       WHERE a.acc = n.acc AND a.tip='SDI' AND n.nd = nd_;

      FOR k IN (SELECT a.acc,
                       gl.p_icurval (a.kv, rez.ostc96 (a.acc, dat_),
                                     dat_) spq
                  FROM accounts a, nd_acc n
                 WHERE a.acc = n.acc AND f_nbs_is_prem (a.nbs) = 1
                       AND n.nd = nd_)
      LOOP
         nprem1_ := nprem1_ + 1;

         IF skqall_ <> 0
         THEN
            spq_ := spq_ + ROUND (k.spq * skq_ / skqall_);
         ELSE
            spq_ := 0;
         END IF;

         IF mode_ = 0
         THEN
            oneprem_ (nprem1_).dat := dat_;
            oneprem_ (nprem1_).userid := userid_;
            oneprem_ (nprem1_).accs := acc_;
            oneprem_ (nprem1_).accp := k.acc;
            oneprem_ (nprem1_).nd := nd_;
            oneprem_ (nprem1_).sk := skq_;
            oneprem_ (nprem1_).skall := skqall_;
            oneprem_ (nprem1_).sp := ROUND (k.spq * skq_ / skqall_);
            oneprem_ (nprem1_).spall := spqall_;
         END IF;
      END LOOP;

      IF oneprem_.COUNT > 0 AND mode_ = 0
      THEN
         FOR p IN oneprem_.FIRST .. oneprem_.LAST
         LOOP
            nprem_ := nprem_ + 1;
            allprem_ (nprem_) := oneprem_ (p);
         END LOOP;
      END IF;

      RETURN spq_;
   EXCEPTION
      WHEN OTHERS
      THEN
         RETURN 0;
   END;

-----------------------------------
   FUNCTION ca_fq_rasch (acc_ INT, dat_ DATE)
      RETURN NUMBER
   IS
      sk1_           NUMBER;
      nls_           VARCHAR2 (15);
      kv_            NUMBER;
      x9_            VARCHAR2 (9);
      r013_          CHAR (5);
      del_           NUMBER;
      delq_          NUMBER;
      ern   CONSTANT POSITIVE      := 208;
      err            EXCEPTION;
      erm            VARCHAR2 (80);
   BEGIN
      RETURN ca_fq_obesp (acc_, dat_, 3);
   END ca_fq_rasch;

--------------------------------------
   FUNCTION ca_fq_rasch_nd (nd_ NUMBER, dat_ IN DATE)
      RETURN NUMBER
   IS
      s_   NUMBER;
   BEGIN
      SELECT NVL (SUM (rez.ca_fq_rasch (a.acc, dat_)), 0)
        INTO s_
        FROM accounts a, nd_acc n
       WHERE a.acc = n.acc
         AND a.tip IN ('SS ', 'SL ', 'SP ', 'CR9')
         AND n.nd = nd_;

      RETURN s_;
   END;

--------------------------------------
   FUNCTION ca_f_rezerv (acc_ INT, dat_ DATE)
      RETURN NUMBER
   IS
      tip_           CHAR (3);
      r013_          CHAR (5);
      sk1_           NUMBER;
      sz_            NUMBER;
      uid_           NUMBER;
      ern   CONSTANT POSITIVE      := 208;
      err            EXCEPTION;
      erm            VARCHAR2 (80);
   BEGIN
      acckr_ := acc_;
      rezerv_ := 0;

      SELECT ID
        INTO uid_
        FROM staff
       WHERE UPPER (logname) = UPPER (USER);

      rez.rez_risk (uid_, dat_, 2);
      RETURN rezerv_;
   END ca_f_rezerv;

--------------------------------------
   FUNCTION ca_f_rezerv_nd (nd_ NUMBER, dat_ IN DATE)
      RETURN NUMBER
   IS
      s_   NUMBER;
   BEGIN
      SELECT NVL (SUM (gl.p_icurval (a.kv, rez.ca_f_rezerv (a.acc, dat_),
                                     dat_)
                      ),
                  0
                 )
        INTO s_
        FROM accounts a, nd_acc n
       WHERE a.acc = n.acc
         AND a.tip IN ('SS ', 'SL ', 'SP ', 'CR9')
         AND n.nd = nd_;

      RETURN s_;
   END;

--------------------------------------
   FUNCTION ca_fq_zalog (acc_ INT, dat_ DATE, pawn_ NUMBER DEFAULT NULL)
      RETURN NUMBER
   IS
   BEGIN
      RETURN ca_fq_obesp (acc_, dat_, 1, NULL, pawn_);
   END ca_fq_zalog;

--------------------------------------
   FUNCTION ca_fq_zalog_d8 (acc_ INT, dat_ DATE, pawn_ NUMBER DEFAULT NULL)
      RETURN NUMBER
   IS
   BEGIN
      RETURN ca_fq_obesp (acc_, dat_, 1, 1, pawn_);
   END ca_fq_zalog_d8;

--------------------------------------
   FUNCTION ca_fq_zalog_nd (nd_ NUMBER, dat_ IN DATE, pawn_ NUMBER
            DEFAULT NULL)
      RETURN NUMBER
   IS
      s_   NUMBER := 0;
   BEGIN
      SELECT SUM (rez.ca_fq_zalog (a.acc, dat_, pawn_))
        INTO s_
        FROM accounts a, nd_acc n
       WHERE a.acc = n.acc
         AND a.tip IN ('SS ', 'SL ', 'SP ', 'CR9')
         AND n.nd = nd_;

      IF s_ IS NULL
      THEN
         SELECT   NVL (rez.ca_fq_zalog (acc, dat_, pawn_), 0)
                + NVL (rez.ca_fq_zalog (acc_9129, dat_, pawn_), 0)
                + NVL (rez.ca_fq_zalog (acc_2067, dat_, pawn_), 0)
           INTO s_
           FROM acc_over
          WHERE nd = nd_
                and acco <> acc_2067; --T 04.02.2009
      END IF;

      RETURN s_;
   END;

--------------------------------------
   FUNCTION f_nbs_is_prem (nbs_ VARCHAR2)
      RETURN NUMBER
   IS
      ret_   NUMBER;
   BEGIN
      IF INSTR (nbspremiy_, nbs_) > 0
      THEN
         ret_ := 1;
      ELSE
         ret_ := 0;
      END IF;

      RETURN ret_;
   END;

--------------------------------------
   FUNCTION f_nbs_is_disc (nbs_ VARCHAR2)
      RETURN NUMBER
   IS
      ret_   NUMBER;
   BEGIN
      IF INSTR (nbsdiscont_, nbs_) > 0
      THEN
         ret_ := 1;
      ELSE
         ret_ := 0;
      END IF;

      RETURN ret_;
   END;

--------------------------------------
   FUNCTION f_nbs_is_fond (nbs_ VARCHAR2)
      RETURN NUMBER
   IS
      ret_   NUMBER;
   BEGIN
      IF INSTR (nbsfond_, nbs_) > 0
      THEN
         ret_ := 1;
      ELSE
         ret_ := 0;
      END IF;

      RETURN ret_;
   END;

   --T 24.03.2009
   function f_get_rest_over_30(acc_ number, last_work_date_ date) return number
   is

    sz_ number := 0;
    --last_work_date_ date;
    begin

      --T 02.12.2008
       sz_ := -rez.ostc96 (acc_, last_work_date_);
        dbms_output.put_line('SZ = '||sz_);
       if sz_ <= 0 then return 0; end if;


       sz_ := -rez.ostc96_3 (acc_, last_work_date_ - 31);
 dbms_output.put_line('SZ = '||sz_);
    --   dbms_output.put_line('1 sz='||to_char(sz_));
      IF sz_ >= 0
      THEN
        begin
          SELECT sz_ - NVL (SUM (o.s), 0)
             INTO sz_
             FROM opldok o, oper p
            WHERE o.acc = acc_
              AND o.fdat > last_work_date_ - 31
              AND o.fdat <= /*trunc(sysdate)--*/last_work_date_+20
              AND o.sos = 5
              AND o.dk = 1
              AND p.REF = o.REF
              AND ( --1. обычные проводки
                    (p.vob <> 96 AND o.fdat <= last_work_date_ )
                    --2. корректирующие проводки
                   OR (    p.vob = 96
                       AND
                       ( --2.1. все корпроводки за текущий месяц
                        (o.fdat > last_work_date_
                         AND o.fdat <= last_work_date_ + 28
                         )
                         or
                         --2.2. корпров. за предыдущий месяц если
                         --дата корректировки (последняя рабочая дата предыдущего месяца) <= даты на 31 день назад
                         ( o.fdat <= last_work_date_ and o.fdat > last_work_date_-31
                          AND (last_work_date_ - 31) >=
                             --последняя рабочая дата предыдущего месяца
                             (SELECT MAX (fdat)
                              FROM fdat
                              WHERE fdat NOT IN (SELECT holiday
                                                FROM holiday) AND
                                    fdat <= add_months(LAST_DAY (last_work_date_),-1))
                         )
                       )
                      )
                  );
        exception when others then
          sz_ := 0;
        end;
      end if;
      dbms_output.put_line('SZ = '||sz_);
      return sz_;
    end;
--------------------------------------
   -- Процедура предварительного накопления данных в массивы
   -- используется уменьшения времени выполнения процедуры REZ_RISK
   PROCEDURE p_load_data (dat_ DATE, acc_ NUMBER DEFAULT NULL)
   IS
      datkor1_   DATE;
      datkor2_   DATE;
   BEGIN
      allzal_.DELETE;
      alldisc_.DELETE;
      allprem_.DELETE;
      korprov_.DELETE;
      salost_.DELETE;
      ndacc_.DELETE;
      dodncre_.DELETE;
      dnprcre_.DELETE;
      prcrd_.DELETE;
      prcrezal_.DELETE;

      -- портфель одородных кредитов
      IF rezpar6_ = '1'
      THEN
         -- определяем максимальную просрочку на один RNK
         -- по умолчанию категория риска = 1
         FOR k IN (SELECT DISTINCT ca.rnk
                              FROM accounts a, specparam s, cust_acc ca
                             WHERE a.acc = s.acc
                               AND a.nbs IN
                                      ('2203',
                                       '2206',
                                       '2290',
                                       '2620',
                                       '2625',
                                       '2605'
                                      --,
                                               --'9129'
                                      )
                               AND s.s090 = '4'
                               --AND (   a.nbs <> '9129'
                               --     OR a.nbs = '9129' AND s.r013 <> '9'
                               --    )
                               AND ca.acc = a.acc
                               AND a.acc = NVL (acc_, a.acc))
         LOOP
            dodncre_ (k.rnk) := '1';
         END LOOP;

         -- количество дней просрочки на клиента по умолчанию = 0
         FOR k IN (SELECT rnk
                     FROM customer)
         LOOP
            dnprcre_ (k.rnk) := 0;
         END LOOP;
      END IF;

      -- Наполнение массивов следующими данными
      -- dodncre_ - категория риска клиента относящего к портфелю однородных кредитов,
      --            отнесение к конкретной категории производится по диапазонам из инструкции
      -- dnprcre_ - количество дней просрочки кредита
      -- prcrd_   - признак, что данный кредит просрочен > 30 дней
      -- Весь алгоритм вычисления просрочек строится от двух дат вычисляемых в курсоре
      -- datpr - максимальная дата возникновения суммарного активного остатка на любом из счетов
      --         просрочки договора не превышающая отчетную дату
      -- datn  - максимальная дата погашения суммарного активного остатка на всех счетах
      --         просрочки договора не превышающая отчетной даты
      FOR k IN (SELECT   ss.s090, ss.rnk, ss.nd,
                         NVL (MAX (CASE
                                      WHEN ss.ostf = 0 AND ss.dos - ss.kos > 0
                                         THEN ss.fdat
                                      ELSE NULL
                                   END
                                  ),
                              dat_
                             ) datpr,
                         MAX (CASE
                                 WHEN ss.ostf - ss.dos + ss.kos = 0
                                    THEN ss.fdat
                                 ELSE NULL
                              END
                             ) datn
                    FROM (SELECT   p.s090, ca.rnk, n.nd, s.fdat,
                                   SUM (s.dos) dos, SUM (s.kos) kos,
                                   SUM (s.ostf) ostf
                              FROM saldoa s,
                                   nd_acc n,
                                   accounts a,
                                   specparam p,
                                   cust_acc ca
                             WHERE s.acc = a.acc
                               AND a.acc = n.acc
                               AND a.acc = p.acc
                               AND a.tip in ('SP ')
                               AND a.acc = NVL (acc_, a.acc)
                               --AND p.s090 = '4'
                               AND s.fdat <= dat_
                               AND ca.acc = a.acc
                               AND n.nd IN (SELECT nd
                                              FROM nd_acc
                                             WHERE acc = NVL (acc_, acc))
                          GROUP BY p.s090, ca.rnk, n.nd, s.fdat) ss
                GROUP BY ss.s090, ss.rnk, ss.nd)
      LOOP
         DECLARE
            dnpr_    NUMBER       := 0;
            ts080_   VARCHAR2 (1) := '1';
         BEGIN
            IF k.datn IS NULL OR k.datpr > k.datn
            THEN
               dnpr_ := dat_ - k.datpr;

               IF k.s090 = '4'
               THEN
                  IF dnpr_ BETWEEN 1 AND 30 AND dodncre_ (k.rnk) < '2'
                  THEN
                     dodncre_ (k.rnk) := '2';
                  ELSIF dnpr_ BETWEEN 31 AND 60 AND dodncre_ (k.rnk) < '3'
                  THEN
                     dodncre_ (k.rnk) := '3';
                  ELSIF dnpr_ BETWEEN 61 AND 90 AND dodncre_ (k.rnk) < '4'
                  THEN
                     dodncre_ (k.rnk) := '4';
                  ELSIF dnpr_ > 90 AND dodncre_ (k.rnk) < '5'
                  THEN
                     dodncre_ (k.rnk) := '5';
                  END IF;
               END IF;

               -- кредиты просроченные > 30 дней
               IF rezpar9_ = '1'
               THEN
                  IF dnpr_ > 30
                  THEN
                     prcrd_ (k.nd) := '1';
                  END IF;
               END IF;

               dnprcre_ (k.rnk) := dnpr_;
            END IF;
         END;

         NULL;
      END LOOP;

      -- первичные обеспечение относящиеся к кредитам просроченным > 30 дней
      IF rezpar9_ = '1'
      THEN
         FOR k IN (SELECT c.acc, c.accs, n.nd, c.pr_12 perv
                     FROM nd_acc n, cc_accp c
                    WHERE n.acc = c.accs
                      AND n.nd IN (SELECT nd
                                     FROM nd_acc
                                    WHERE acc = NVL (acc_, acc)))
         LOOP
            IF k.perv = '1'
            THEN
               IF prcrd_.EXISTS (k.nd) AND prcrd_ (k.nd) = '1'
               THEN
                  prcrezal_ (k.acc) := '1';
               END IF;
            END IF;
         END LOOP;
      END IF;

      -- номера договоров
      FOR k IN (SELECT   *
                    FROM nd_acc
                   WHERE acc = NVL (acc_, acc)
                ORDER BY nd)
      LOOP
         ndacc_ (k.acc) := k.nd;
      END LOOP;

      -- корректирующие проводки
      datkor1_ := LAST_DAY (dat_) + 1;
      datkor2_ := LAST_DAY (dat_) + 21;

      FOR k IN (SELECT   o.acc, SUM (DECODE (o.dk, 1, o.s, -o.s)) s
                    FROM opldok o, oper p
                   WHERE o.REF = p.REF
                     AND o.sos = 5
                     AND p.vob = 96
                     AND o.acc = NVL (acc_, o.acc)
                     AND o.fdat BETWEEN datkor1_ AND datkor2_
                     AND p.vdat = dat_
                GROUP BY o.acc)
      LOOP
         korprov_ (k.acc).ob := k.s;
         korprov_ (k.acc).fdat := dat_;
      END LOOP;
   END;

--------------------------------------
   -- Процедура очистки неиспользуемых пользователем структур данных пакета
   -- после выполнения процедуры по расчету резерва.
   -- Процедура не влияет на логику работы модуля т.е. при необходимости
   -- вызов процедуры может быть отключен.
   PROCEDURE p_unload_data
   IS
   BEGIN
      allzal_ := allzal_null_;
      alldisc_ := alldisc_null_;
      allprem_ := allprem_null_;
      korprov_ := korprov_null_;
      salost_ := salost_null_;
      ndacc_ := ndacc_null_;
      dodncre_ := dodncre_null_;
      dnprcre_ := dnprcre_null_;
      prcrd_:=prcrd_null_;
      prcrezal_:=prcrezal_null_;


      DBMS_SESSION.free_unused_user_memory;
   END;

--------------------------------------
   PROCEDURE rez_risk (id_ INT, dat_ DATE, mode_ IN INT DEFAULT 0/*, pr_ in int default null*/)
   IS
      ostq_            NUMBER;
      ostqold_         NUMBER;
      discont_         NUMBER;
      prem_            NUMBER;
      x9_              VARCHAR2 (9);
      del_             NUMBER;
      cc_id_           VARCHAR2 (20);
      s080_name_       VARCHAR2 (35);
      delq_            NUMBER;
      idr_             INT;
      soq_             NUMBER;
      obs_             INT;
      srq_             NUMBER;
      nd_              INT;
      szq_             NUMBER;
      szq2_            NUMBER;
      grp_             INT;
      sz_              NUMBER;
      sz_60_           NUMBER;
      wdate_           DATE;
      pr_rez_          NUMBER;
      kdate_           DATE;
      kprolog_         NUMBER;
      dat_prol_        DATE;
      sg_              NUMBER;
      sv_              NUMBER;
      zal_             NUMBER;
      kol_zal          NUMBER;
      vid_zal          NUMBER;
      otd_             NUMBER;
      form_            NUMBER;
      s080_            VARCHAR2 (1);
      prliz_           NUMBER;
      sn_              NUMBER;
      datzo1_          DATE;
      datzo2_          DATE;
      custtype_        NUMBER;
      datlizd_         DATE;
      datlizn_         NUMBER;
      datkor1_         DATE;
      datkor2_         DATE;
      datpr_           DATE;
      last_work_date_  DATE;
      vidd_            NUMBER;
      istval_          VARCHAR2 (1);
      odncre_          VARCHAR2 (1);
      dnipr_           NUMBER;
      kvk_             NUMBER;
      ostc_            NUMBER;
      oldrez_userid_   NUMBER;
      oldrez_date_     DATE;
      ern     CONSTANT POSITIVE      := 208;
      err              EXCEPTION;
      erm              VARCHAR2 (80);
   BEGIN

      if  mode_ = 0 then
         rez1.rez_risk (id_ , dat_ );
         return;
      end if;

     --проверка - выбран ли рабочий день
      for r in
      (SELECT holiday fdat
                FROM holiday
       where holiday = dat_
      )
      loop
            bars_error.raise_error('REZ',2);
      end loop;
      -- не перезапускать расчет для пользователя который делал проводки
      -- по формированию фонда
      BEGIN
         SELECT userid
           INTO form_
           FROM rez_protocol
          WHERE dat = dat_;

         IF form_ = id_
         THEN
            RETURN;
         END IF;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            form_ := NULL;
      END;

      -- пользователь и дата последнего расчета
      -- если делались проводки, берется расчет пользователя из REZ_PROTOCOL
      -- если нет берется расчет того же пользователя на последний рабочий день месяца
      SELECT MAX (fdat)
        INTO oldrez_date_
        FROM (SELECT fdat
                FROM fdat
              MINUS
              SELECT holiday fdat
                FROM holiday)
       WHERE fdat <= LAST_DAY (ADD_MONTHS (dat_, -1));

      BEGIN
         SELECT userid
           INTO oldrez_userid_
           FROM rez_protocol
          WHERE dat = oldrez_date_;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            oldrez_userid_ := id_;
      END;

      IF mode_ <> 2
      THEN
         acckr_ := NULL;
         p_load_data (dat_);

         if uselog_ <> 0 then
             DELETE FROM cp_rez_log
                   WHERE userid = id_;
         end if;

         DELETE FROM tmp_rez_risk
               WHERE ID = id_ AND dat = dat_;

         DELETE FROM tmp_rez_risk2
               WHERE userid = id_ AND dat = dat_;

         DELETE FROM tmp_rez_risk3
               WHERE userid = id_ AND dat = dat_;

         DELETE FROM tmp_rez_risk4
               WHERE userid = id_ AND dat = dat_;

         DELETE FROM tmp_rez_params
                       WHERE ID = id_ AND dat = dat_;



         -- лечение всяких нехороших ситуаций

         -- 1. залоги вне залогового портфеля
         INSERT INTO pawn_acc
                     (acc)
            SELECT DISTINCT p.acc
                       FROM cc_accp p
                      WHERE NOT EXISTS (SELECT pp.acc
                                          FROM pawn_acc pp
                                         WHERE pp.acc = p.acc);

         -- 2. неразмноженные связи актив-залог
--          INSERT INTO cc_accp
--                      (accs, acc)
--             SELECT z.accs, z.acc
--               FROM (SELECT DISTINCT k.accs, n.acc
--                                FROM (SELECT n.acc accs, n.nd
--                                        FROM nd_acc n, accounts a
--                                       WHERE n.acc = a.acc
--                                         AND a.tip IN
--                                                  ('SS ', 'SL ', 'SP ', 'CR9')) k,
--                                     (SELECT DISTINCT p.acc, n.nd
--                                                 FROM cc_accp p, nd_acc n
--                                                WHERE p.accs = n.acc) n
--                               WHERE k.nd = n.nd
--                     MINUS
--                     SELECT accs, acc
--                       FROM cc_accp) z,
--                    accounts az,
--                    accounts ak
--              WHERE z.accs = ak.acc
--                AND z.acc = az.acc
--                AND (ak.dazs IS NULL OR ak.dazs > dat_)
--                AND (az.dazs IS NULL OR az.dazs > dat_);

         -- 3. проставляем категорию  риска по справочнику счетов фонда
         FOR k IN (SELECT a.acc, s.s080
                     FROM srezerv s, --таблица справочник с перечнем счетов резервного фонда
                          accounts a
                    WHERE (s.s_fond = a.nls OR s.s_fondnr = a.nls)
                          AND a.nbs IN ('2400', '2401', '3690')
                          AND s.s080 <> 9 --T 21.01.2009
                  )
         LOOP
            UPDATE specparam
               SET s080 = k.s080
             WHERE acc = k.acc;

        END LOOP;

--         COMMIT;
      ELSE
         p_load_data (dat_, acckr_);
      END IF;

      rownumber_ := 0;
      n_ := 0;
      ndiscont_ := 0;
      nprem_ := 0;
      n1_ := 0;
      ndiscont1_ := 0;
      nprem1_ := 0;
      flagkorprov_ := 1;
      flagallrez_ := 1;

      -- РЕЗЕРВЫ ПО РИСКОВЫМ АКТИВАМ ПО F11_ = '1'
      FOR k IN
         (WITH cw AS
               (--признак корпоративного клиента - для расчета не используется, нужен для отображения в клиенте
               SELECT DISTINCT rnk, tag,
                                FIRST_VALUE (VALUE) OVER (PARTITION BY rnk ORDER BY rnk)
                                                                         corp
                           FROM customerw
                          WHERE tag = 'CORP'
                       ORDER BY rnk)
          SELECT NVL (p.s080, '1') s080, p.s090, a.isp, a.tobo,
                 a.nbs || DECODE (NVL (p.r013, '1'), '9', '9', '1') r013,
                 p.r013 r013_2, NVL (p.istval, '0') istval, c.rnk,
                 SUBSTR (c.nmk, 1, 35) nmk,
                 DECODE (TRIM (c.sed),
                         '91', DECODE (custtype, 3, 2, custtype),
                         c.custtype
                        ) custtype,
                 a.acc, a.kv, a.nls, r.rez, r.rez2, r.rez3, r.rez4, r.rez5,
                 r.NAME,
                 a.nbs, c.crisk fin, SUBSTR (c.nd, 1, 20) cc_id,
                 NVL (c.country, acountry) country,
                 DECODE (NVL (c.codcagent, 1), '2', 2, '4', 2, '6', 2, 1) rz,
                 cw.corp
                 ,a.DAOS --T 09.01.2009
                 ,p.s182 --T 23.01.2009
            FROM accounts a,
                 specparam p,
                 crisk r,
                 cust_acc cu,
                 customer c,
                 --T 09.01.2009
                 (SELECT DISTINCT r020, '11' a010
                  FROM kod_r020
                  WHERE a010 = '11' AND prem = 'КБ '
                 ) k,
/*
                 (SELECT DISTINCT r020, '1' f_11
                             FROM kl_r020
                            WHERE f_11 = '1' AND prem = 'КБ ') k,*/
                 cw
           WHERE a.nbs = k.r020(+)
             AND nbspremiy_ NOT LIKE '%' || a.nbs || '%'
             AND (  k.a010 = '11' --T 09.01.2009
                    -- k.f_11 = '1'
                  OR a.nbs = '2600'
                  OR a.nbs = '1500'
                  OR a.nbs = '1515'
                  OR a.nbs = '1513'--T 09.01.2009
                  OR a.nbs = '1514'--T 09.01.2009
                  OR a.nbs = '1520'--T 09.01.2009
                 )
             AND a.nbs not in ('1590','1591','2400','2401','3690')
              --T 09.01.2009
             AND cu.acc = a.acc
             AND a.acc = NVL (acckr_, a.acc)
             AND cu.rnk = c.rnk
             AND NVL (p.s080, '1') = r.crisk
             AND (a.dazs IS NULL OR a.dazs > dat_)
             AND a.acc = p.acc(+)
             AND c.rnk = cw.rnk(+))
      LOOP
         curacc_ := k.acc;
         s080_name_ := k.NAME;
         to_log (k.acc,
                 '(nls)(kv)(асс)(rnk)',
                    '('
                 || k.nls
                 || ')('
                 || TO_CHAR (k.kv)
                 || ')'
                 || '('
                 || TO_CHAR (k.acc)
                 || ')'
                 || '('
                 || TO_CHAR (k.rnk)
                 || ')'
                );
         s080_ := k.s080;

         --ном дог
         IF ndacc_.EXISTS (k.acc)
         THEN
            nd_ := ndacc_ (k.acc);
         ELSE
            nd_ := NULL;
         END IF;

         -- флаг - есть источники валютной выручки
         istval_ := k.istval;

         -- дней просрочки кредита
         IF dnprcre_.EXISTS (k.rnk)
         THEN
            dnipr_ := dnprcre_ (k.rnk);
         END IF;

         -- флаг - счет включен в портфель однородных кредитов
         IF     dodncre_.EXISTS (k.rnk)
            AND k.nbs IN ('2203', '2290', '2620', '2625','2605')
            AND k.s090 = '4'
         THEN
            odncre_ := 'y';
            s080_ := dodncre_ (k.rnk);

            -- dnipr_ := dnprcre_ (k.rnk);

            -- обновление категории риска основного счета
            IF k.s080 <> s080_
            THEN
               UPDATE specparam
                  SET s080 = s080_
                WHERE acc = k.acc;

               IF SQL%ROWCOUNT = 0
               THEN
                  INSERT INTO specparam
                              (acc, s080
                              )
                       VALUES (k.acc, s080_
                              );
               END IF;

               COMMIT;
            END IF;

            -- обновление категории риска счета дисконта
            DECLARE
               accd_    NUMBER;
               s080d_   NUMBER;
            BEGIN
               SELECT a.acc, NVL (p.s080, '0')
                 INTO accd_, s080d_
                 FROM accounts a, nd_acc n, specparam p
                WHERE a.acc = n.acc
                  AND n.nd = nd_
                  AND p.acc(+) = a.acc
                  AND ROWNUM = 1
                  AND a.tip = 'SDI'
                  AND a.dazs IS NULL;

               IF s080d_ <> s080_
               THEN
                  UPDATE specparam
                     SET s080 = s080_
                   WHERE acc = accd_;

                  IF SQL%ROWCOUNT = 0
                  THEN
                     INSERT INTO specparam
                                 (acc, s080
                                 )
                          VALUES (accd_, s080_
                                 );
                  END IF;

                  COMMIT;
               END IF;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  NULL;
            END;
         ELSE
            odncre_ := NULL;
         -- dnipr_ := NULL;
         END IF;

         BEGIN
            SELECT   o.otd
                INTO otd_
                FROM otd_user o
               WHERE o.userid = k.isp AND ROWNUM = 1
            ORDER BY o.otd, o.pr;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               otd_ := 0;
         END;

         ostc_ := -rez.ostc96 (k.acc, dat_);
         --DBMS_OUTPUT.put_line ('1.ostc_=' || TO_CHAR (ostc_));

         --расчет резерва только для АКТИВНЫХ остатков
         IF ostc_ > 0
         THEN
            ostq_ := gl.p_icurval (k.kv, ostc_, dat_);
            ostqold_ := ostq_;

            SELECT ABS (NVL (SUM (sd), 0))
              INTO discont_
              FROM tmp_rez_risk3
             WHERE userid = id_ AND dat = dat_ AND accs = k.acc;

            IF SUBSTR (k.r013, 1, 4) IN ('9100', '9129')
            THEN
               ostq_ := ROUND (0.5 * ostq_);
            END IF;

            del_ := 0;
            delq_ := 0;
            soq_ := rez.ca_fq_obesp (k.acc, dat_);
            discont_ := NVL (rez.ca_fq_discont (k.acc, dat_), 0);
            prem_ := ABS (NVL (rez.ca_fq_prem (k.acc, dat_), 0));
            --сумма кредитного риска
            srq_ := (ostq_ + del_) - discont_ + prem_ - soq_;
            szq2_ := (ostq_ + del_) - soq_;

            IF szq2_ < 0
            THEN
               szq2_ := 0;
            END IF;

            IF srq_ < 0
            THEN
               srq_ := 0;
            END IF;

            --находятся данные нужные для отображения в клиентской части (для расчета не используются)
            IF mode_ <> 2 AND calcdoppar_ = 1
            THEN
               -- Расчет обеспечения
               BEGIN
                  SELECT (rez.ca_fq_zalog (k.acc, dat_) / 100)
                    INTO zal_
                    FROM DUAL;
               EXCEPTION
                  WHEN NO_DATA_FOUND
                  THEN
                     zal_ := 0;
               END;

               -- Вид обеспечения
               BEGIN
                  BEGIN
                     SELECT COUNT (*)
                       INTO kol_zal
                       FROM pawn_acc p, cc_accp ap, accounts a
                      WHERE ap.accs = k.acc
                        AND p.acc = ap.acc
                        AND p.acc = a.acc
                        AND NVL (a.dazs, dat_) >= dat_;
                  END;

                  IF kol_zal > 1
                  THEN
                     vid_zal := 40;
                  ELSE
                     BEGIN
                        SELECT p.pawn
                          INTO vid_zal
                          FROM pawn_acc p, cc_accp ap, accounts a
                         WHERE ap.accs = k.acc
                           AND p.acc = ap.acc
                           AND a.acc = p.acc
                           AND NVL (a.dazs, dat_) >= dat_;
                     EXCEPTION
                        WHEN NO_DATA_FOUND
                        THEN
                           vid_zal := NULL;
                     END;
                  END IF;
               EXCEPTION
                  WHEN NO_DATA_FOUND
                  THEN
                     vid_zal := NULL;
               END;


               wdate_ := null;   --T 09.01.2009

               BEGIN
                  SELECT SUBSTR (cc_id, 1, 20), obs, wdate, vidd
                    INTO cc_id_, obs_, kdate_, vidd_
                    FROM cc_deal
                   WHERE nd = nd_;

                  -- все по номеру последнего договра
                  -- начало действия договора
                  BEGIN
                     SELECT wdate
                       INTO wdate_
                       FROM cc_add
                      WHERE nd = nd_ AND adds = 0;
                  EXCEPTION
                     WHEN NO_DATA_FOUND
                     THEN
                        wdate_ := NULL;
                  END;

                  -- Кол-во пролонгаций
                  BEGIN
                     SELECT COUNT (*)
                       INTO kprolog_
                       FROM cc_prol
                      WHERE nd = nd_ AND acc = k.acc;
                  EXCEPTION
                     WHEN NO_DATA_FOUND
                     THEN
                        kprolog_ := 0;
                  END;

                  --КП ЮЛ, ФЛ, МБК (ном.дог,обсл.,дата оконч.договора)
                  kvk_ := k.kv;

                  IF vidd_ = 3
                  THEN
                     BEGIN
                        SELECT kv
                          INTO kvk_
                          FROM accounts a, nd_acc n
                         WHERE a.acc = n.acc
                           AND a.nbs = '8999'
                           AND nd = nd_
                           AND ROWNUM = 1;
                     EXCEPTION
                        WHEN NO_DATA_FOUND
                        THEN
                           kvk_ := k.kv;
                     END;
                  END IF;

                  -- начальная сумма в грн. и ном.
                  -- BEGIN
                  BEGIN
                     SELECT gl.p_icurval (kvk_, lim2 / 100, dat_), lim2 / 100
                       INTO sg_, sv_
                       FROM cc_lim c
                      WHERE nd = nd_ AND fdat = (SELECT MIN (fdat)
                                                   FROM cc_lim
                                                  WHERE nd = nd_);
                  EXCEPTION
                     WHEN NO_DATA_FOUND
                     THEN
                        sg_ := 0;
                        sv_ := 0;
                  END;

                  BEGIN
                     SELECT DISTINCT fdat
                                INTO dat_prol_
                                FROM cc_prol
                               WHERE nd = nd_
                                 AND fdat = (SELECT MIN (fdat)
                                               FROM cc_prol
                                              WHERE nd = nd_ AND npp <> 0);
                  EXCEPTION
                     WHEN NO_DATA_FOUND
                     THEN
                        dat_prol_ := NULL;
                  END;
               EXCEPTION
                  WHEN NO_DATA_FOUND
                  THEN
                     BEGIN
                        --Оверд
                        SELECT SUBSTR (ndoc, 1, 20), obs, datd, datd2,
                               gl.p_icurval (k.kv, sd, dat_) / 100, sd / 100
                          INTO cc_id_, obs_, wdate_, kdate_,
                               sg_, sv_
                          FROM acc_over
                         WHERE k.acc IN (acco, acc_9129) AND ROWNUM = 1;

                     EXCEPTION
                        WHEN NO_DATA_FOUND
                        THEN
                           -- Оверд - архив
                           BEGIN
                              SELECT SUBSTR (ndoc, 1, 20), obs, datd, datd2,
                                     gl.p_icurval (k.kv, sd, dat_) / 100,
                                     sd / 100
                                INTO cc_id_, obs_, wdate_, kdate_,
                                     sg_,
                                     sv_
                                FROM acc_over_archive
                               WHERE k.acc IN (acco, acc_9129)
                                 AND ROWNUM = 1
                                 AND deldate >= dat_;

                           EXCEPTION
                              WHEN NO_DATA_FOUND
                              THEN
                                 --остальное
                                 cc_id_ := k.cc_id;
                                 obs_ := TO_NUMBER (NULL);
                                 nd_ := TO_NUMBER (NULL);
                                 wdate_ := k.daos;--T 09.01.2009
                                 kdate_:= null;--T 09.01.2009
                                 sg_:= null;--T 09.01.2009
                                 sv_:= null;--T 09.01.2009
                           END;
                     END;
               END;
            END IF;

            --для счетов относящихся к договорам кредитных линий
            --вместо даты открытия договора берем дату открытия счета -
            -- т.к. дата открытия счета = дата транша
            -- кроме СБЕРБАНКа
            if nvl(k.s182,0) = 3 and par_ob22 <> 1 then
               wdate_ := k.daos;--T 23.01.2009
            end if;

            -- определение процента резервирования
            pr_rez_ := 0;
            /* процент резервирования в зависимости от наличия источника вылютной выручки
               для межбанка не имеет смысла, для корсчетов в других банках всегда определяется
               по группе страны риска */
            to_log (k.acc, '% резервирования', '');

            --определяем дату открытия кредита
            k.daos := nvl(wdate_,  k.daos);--T 09.01.2009

            IF rezpar5_ = 0
            THEN                                                 -- по старому
               IF    k.istval = 1
                  OR k.kv = 980
                  OR (SUBSTR (k.nbs, 1, 3) IN ('151', '152'))
                  OR k.nbs = '1502'
               THEN
                  pr_rez_ := k.rez;
               ELSIF k.nbs <> '1500'
               THEN
                  pr_rez_ := k.rez2;
               END IF;
            ELSIF rezpar5_ = 1
            THEN                                            -- по 83 постанове
               IF    k.kv = 980
                  OR (SUBSTR (k.nbs, 1, 3) IN ('151', --Строкові вклади (депозити), які розміщені в інших банках
                                               '152')) --Кредити, що надані іншим банкам
                  OR k.nbs = '1502'--Кошти банків у розрахунках
               THEN
                  to_log (k.acc, '..корсчет или межбанк', '');
                  pr_rez_ := k.rez;

               --коррсчета резервируются только если они открыты НЕ в украинских банках
               --или  НЕ первая группа страны
               -- процент резервирования для них расчитывается ТОЛЬКО по группе стран риска
               ELSIF k.nbs <> '1500'--Кореспондентські рахунки, що відкриті в інших   банках
               THEN
                  IF k.istval = 1
                  THEN
                     to_log (k.acc, '..есть источники валютной выручки', '');
                     pr_rez_ := k.rez3;
                  ELSE
                     to_log (k.acc, '..нет источников валютной выручки', '');
                     pr_rez_ := k.rez2;

                     --для договоров без валютной выручки открытых после 28.12.2008
                     --другой % резервирования
                     if k.daos >= c_dt and k.nbs <> '9129'  --T 31.03.2009
                     then --T 09.01.2009
                       to_log (k.acc, '..новый % резервирования', '');
                       pr_rez_ := k.rez5;
                     end if;

                  END IF;
               END IF;
            END IF;

            -- процент резервирования по группе стран риска
            -- только для корсчетов и межбанковских кредитов-депозитов
            IF k.country <> acountry AND k.nbs LIKE '1%'
            THEN
               to_log (k.acc,
                       '..процент резервирования по группе страны риска',
                       ''
                      );

               BEGIN
                  SELECT GREATEST (NVL (g.pr, 0), NVL (pr_rez_, 0)),
                         NVL (y.grp, 1)
                    INTO pr_rez_,
                         grp_
                    FROM country y, rez_grp_country g
                   WHERE y.country = k.country AND y.grp = g.grp;
               EXCEPTION
                  WHEN NO_DATA_FOUND
                  THEN
                     to_log
                        (k.acc,
                         '..ошибка !!!, для страны не заполнен спр. гр. стран риска ',
                         ''
                        );
                     pr_rez_ := k.rez;
               END;
            END IF;

            -- не резервируем в некоторых случаях
            -- k.istval = 2 - если не надо резервировать, а в процедуре нереализовано
            -- для 1500 не резервируем если банк Украинский или первая группа страны
            IF k.istval = 2
            THEN
               to_log (k.acc, '..не резервируем (istval=2)', '');
               pr_rez_ := 0;
            ELSIF k.nbs = '1500' AND (k.country = acountry OR grp_ = 1)
            THEN
               to_log
                  (k.acc,
                   '..не резервируем (корсчет в Украине или в стране 1 группы стран риска)',
                   ''
                  );
               pr_rez_ := 0;
            END IF;

            -- процент резервирования для портфеля однородных кредитов
            IF odncre_ = 'y'
            THEN
               to_log (k.acc, '..портфель однородных кредитов', '');
               --для однородных кредитов в валюте другой % резервирования
               IF  k.kv <> 980 and k.daos >= c_dt then --T 28.12.2008
                   to_log (k.acc, '..новый % резервирования', '');
                   IF s080_ = '1'
                   THEN
                      pr_rez_ := 50;
                   ELSIF s080_ = '2'
                   THEN
                      pr_rez_ := 100;
                   ELSIF s080_ = '3'
                   THEN
                      pr_rez_ := 100;
                   ELSIF s080_ = '4'
                   THEN
                      pr_rez_ := 100;
                   ELSIF s080_ = '5'
                   THEN
                      pr_rez_ := 100;
                   END IF;
                else
                   IF s080_ = '1'
                   THEN
                      pr_rez_ := 2;
                   ELSIF s080_ = '2'
                   THEN
                      pr_rez_ := 10;
                   ELSIF s080_ = '3'
                   THEN
                      pr_rez_ := 40;
                   ELSIF s080_ = '4'
                   THEN
                      pr_rez_ := 80;
                   ELSIF s080_ = '5'
                   THEN
                      pr_rez_ := 100;
                   END IF;
                end if;


              /* IF s080_ = '1'
               THEN
                  pr_rez_ := 2;
               ELSIF s080_ = '2'
               THEN
                  pr_rez_ := 10;
               ELSIF s080_ = '3'
               THEN
                  pr_rez_ := 40;
               ELSIF s080_ = '4'
               THEN
                  pr_rez_ := 80;
               ELSIF s080_ = '5'
               THEN
                  pr_rez_ := 100;
               END IF;*/
            END IF;

            -- резерв
            szq_ := srq_ * pr_rez_ / 100;
            szq2_ := szq2_ * pr_rez_ / 100;
            sz_ := gl.p_ncurval (k.kv, szq_, dat_);

            -- если залога нет брать процент от номинала
            -- существенно например для корсчетов в экзотических валютах
            -- двойная конвертация с округлением приводит к изменению
            -- фонда даже если остаток не менялся
            IF soq_ = 0 AND k.nbs LIKE '1%'
            THEN
               sz_ := ostc_ * pr_rez_ / 100;
            END IF;

            idr_ := rez.id_nbs (k.nbs);


            --1500 счет резервируется только на двух счетах фонда -
            -- для стандартной группы риска и нестандартной (1 и 2 соответственно)
            IF k.nbs = '1500'
            THEN
               IF grp_ = 1 OR grp_ = 2
               THEN
                  s080_ := '1';
               ELSE
                  s080_ := '2';
               END IF;
            END IF;

            --разбиваем на две категории - стандарстная и нестандартная
            --в расчете не участвует просто для информации
            IF k.country = '804'
            THEN
               IF s080_ = '1'
               THEN
                  sn_ := '1';
               ELSE
                  sn_ := '2';
               END IF;
            ELSE
               IF grp_ = 1 OR grp_ = 2
               THEN
                  sn_ := '1';
               ELSE
                  sn_ := '2';
               END IF;
            END IF;

            --для формирования проводок по резерву необх. знать тип клиента
            --(1 - банк, 2 - юр, 3 - физ)
            --резерв по каждому типу клиента идет на свой счет фонда
            -- для какого-то банка физ и юр идут на один счет

            IF rezpar1_ = '1' AND k.custtype = '3'
            THEN
               custtype_ := '2';
            --могут быть консолидированные карточные счета открытые на банк
            --но по сути это счета физиков
            elsif k.custtype = '1' and k.nbs in ('2620','2625') then
               custtype_:='3';
            ELSE
               custtype_ := k.custtype;
            END IF;

            -- некоторые специальные случаи которые не резервируются
            --1. Зобов'язання з кредитування клієнтів за кредитними лініями, за якими банк ризику не несе
            IF k.nbs = '9129' AND k.r013_2 = '9'
            THEN
               to_log
                    (k.acc,
                     'Специальная обработка: nbs = 9129 r013=9. Резерв = 0.',
                     ''
                    );
               sz_ := 0;
               szq_ := 0;
               szq2_ := 0;
               ostq_ := 0;
            --2. Авалі, що надані клієнтам за податковими векселями
            ELSIF k.nbs = '9003' AND k.r013_2 = '1'
            THEN
               to_log
                    (k.acc,
                     'Специальная обработка: nbs = 9003 r013=1. Резерв = 0.',
                     ''
                    );
               sz_ := 0;
               soq_ := srq_;
               szq_ := 0;
               szq2_ := 0;
               --stq_ := 0;
               srq_ := 0;

            --3.
            -- Гарантiйнi депозити та грошове покриття в iнших банках, крім НБУ (покритi)
            -- Гарантiйнi депозити та грошове покриття в НБУ   (покритi)
            ELSIF k.nbs = '1502' AND k.r013_2 IN ('1', '3')
            THEN
               to_log (k.acc,
                          'Специальная обработка: nbs = 1502 r013='
                       || k.r013_2
                       || '. Резерв = 0.',
                       ''
                      );
               sz_ := 0;
               szq_ := 0;
               szq2_ := 0;
               ostq_ := 0;
            END IF;

            rezerv_ := sz_;

            if s080_ <> '9' then --T 31.12.2008
              for cr in (select c.name from crisk c where c.CRISK = s080_)
              loop
                s080_name_ := cr.name;
              end loop;
            ELSIF s080_ = '9' then
              s080_name_ := 'простр. %';
            end if;

          /*  IF s080_ = '1'
            THEN
               s080_name_ := 'стандартний';
            ELSIF s080_ = '2'
            THEN
               s080_name_ := 'під контролем';
            ELSIF s080_ = '3'
            THEN
               s080_name_ := 'субстандартний';
            ELSIF s080_ = '4'
            THEN
               s080_name_ := 'сумнівний';
            ELSIF s080_ = '5'
            THEN
               s080_name_ := 'безнадійний';
            ELSIF s080_ = '9'
            THEN
               s080_name_ := 'простр. %';
            END IF;*/

            to_log (k.acc, 'Параметры расчета:', '');
            to_log (k.acc, 's080', s080_ || '(' || s080_name_ || ')');
            to_log (k.acc, 'страна', k.country);
            curacc_ := NULL;
           -- DBMS_OUTPUT.put_line (   'ostc_ + del_='
             --                     || TO_CHAR (ROUND (ostc_ + del_))
               --                  );

            IF mode_ <> 2
            THEN
               INSERT INTO tmp_rez_risk
                           (dat, ID, s080, s080_name, custtype, rnk,
                            nmk, kv, nls, sk,
                            skq, soq,
                            srq, szq, sz, cc_id,
                            idr, fin, obs, rs080,
                            country, pr_rez, rz, acc, nd, wdate,
                            kdate, sg, sv, kprolog, pawn, obesp,
                            dat_prol, isp, otd, tobo,
                            skq2,
                            discont, prem, sn, szq2, corp,
                            istval, odncre, dnipr
                            ,fl_newacc
                           )
                    VALUES (dat_, id_, s080_, s080_name_, custtype_, k.rnk,
                            k.nmk, k.kv, k.nls, ROUND (ostc_ + del_),
                            ROUND (ostqold_ + delq_), ROUND (soq_),
                            ROUND (srq_), ROUND (szq_), ROUND (sz_), cc_id_,
                            idr_, k.fin, obs_, rez.r_s080 (k.fin, obs_),
                            k.country, pr_rez_, k.rz, k.acc, nd_, wdate_,
                            kdate_, sg_, sv_, kprolog_, vid_zal, zal_,
                            dat_prol_, k.isp, otd_, k.tobo,
                            GREATEST (ostq_ - discont_ + prem_, 0),
                            discont_, prem_, sn_, ROUND (szq2_), k.corp,
                            istval_, odncre_, dnipr_
                            ,'n'
                           );

                 insert into TMP_REZ_PARAMS
                 (dat , id  , acc , r013 ,
                  s270 , istval , s090 ,ob22
                  )
                  values(dat_, id_, k.acc, k.r013_2,
                  null, k.istval, k.s090,
                  (select ob22 from specparam_int where acc = k.acc)
                  );


            END IF;
         END IF;
      END LOOP;

      obs_ := 3;

      SELECT MAX (fdat)
        INTO datpr_
        FROM fdat
       WHERE fdat NOT IN (SELECT holiday
                            FROM holiday) AND fdat <= LAST_DAY (dat_ - 31);

      datkor1_ := LAST_DAY (datpr_) + 1;
      datkor2_ := LAST_DAY (datpr_) + 20;
      korprov_.DELETE;

      FOR k IN (SELECT   o.acc, SUM (o.s) s
                    FROM opldok o, oper p
                   WHERE o.REF = p.REF
                     AND o.sos = 5
                     AND p.vob = 96
                     AND o.acc = NVL (acckr_, o.acc)
                     AND (       o.fdat BETWEEN datkor1_ AND datkor2_
                             AND p.vdat = datpr_
                             AND p.nlsa NOT LIKE '3589%'
                             AND p.nlsb NOT LIKE '3589%'
                          OR     o.fdat BETWEEN dat_ + 1 AND dat_ + 15
                             AND p.vdat = dat_
                             AND (p.nlsa LIKE '3589%' OR p.nlsb LIKE '3589%'
                                 )
                         )
                GROUP BY o.acc)
      LOOP
         korprov_ (k.acc).ob := k.s;
         korprov_ (k.acc).fdat := datpr_;
      END LOOP;




-- РЕЗЕРВЫ ПО ПРОСРОЧЕННЫМ ПРОЦЕНТАМ и СОМНИТЕЛЬНЫМ ПРОЦЕНТАМ
--1. не учитывается обеспечение
--2. резервируются только сомнительные и просроченные свыше 30 дней
--3. % резервирования всегда 100%
--4. категория риска одна - 9 в таблице CRISK
      FOR k IN
         (WITH cw AS
               (SELECT DISTINCT rnk, tag, FIRST_VALUE (VALUE) OVER (PARTITION BY rnk ORDER BY rnk) corp
                FROM customerw
                WHERE tag = 'CORP'
                ORDER BY rnk)
          --просроченные %
          SELECT a.tip, c.rnk, SUBSTR (c.nmk, 1, 35) nmk, DECODE (TRIM (c.sed), '91', DECODE (custtype, 3, 2, custtype), c.custtype ) custtype,
                 a.tobo,
                 NVL (p.s080, '') s080,
                 NVL (p.r013, '') r013,
                 a.acc, a.kv,
                 a.nls, a.isp, SUBSTR (a.nbs, 3, 2) priz, a.nbs, c.crisk fin,
                 NVL (c.country, acountry) country,
                 DECODE (NVL (c.codcagent, 1), '2', 2, '4', 2, '6', 2, 1) rz,
                 cw.corp, a.daos, p.s182, p.s270
            FROM accounts a, cust_acc cu, customer c, specparam p, cw
           WHERE cu.acc = a.acc
             AND cu.rnk = c.rnk
             AND a.acc = NVL (acckr_, a.acc)
             AND a.acc = p.acc(+)
             AND (a.dazs IS NULL OR a.dazs > dat_)
             AND a.tip IN ( 'SPN')
             AND c.rnk = cw.rnk(+)
             union all
           --начисленные
           SELECT a.tip, c.rnk, SUBSTR (c.nmk, 1, 35) nmk, DECODE (TRIM (c.sed),'91', DECODE (custtype, 3, 2, custtype),c.custtype) custtype,
                 a.tobo,
                 NVL (p.s080, '') s080,
                 NVL (p.r013, '') r013,
                 a.acc, a.kv,
                 a.nls, a.isp, SUBSTR (a.nbs, 3, 2) priz, a.nbs, c.crisk fin,
                 NVL (c.country, acountry) country,
                 DECODE (NVL (c.codcagent, 1), '2', 2, '4', 2, '6', 2, 1) rz,
                 cw.corp, a.daos, p.s182, p.s270
            FROM accounts a, cust_acc cu, customer c, specparam p, cw
           WHERE cu.acc = a.acc
             AND cu.rnk = c.rnk
             AND a.acc = NVL (acckr_, a.acc)
             AND a.acc = p.acc(+)
             AND (a.dazs IS NULL OR a.dazs > dat_)
             AND a.tip IN ( 'SN ')
             and p.s270 = '08'
             AND c.rnk = cw.rnk(+)
             and rezpar11_ = 1
         )
      LOOP
         curacc_ := k.acc;
         sz_ := 0;
         discont_ := 0;
         prem_ := 0;
         sn_ := 2;

         IF ndacc_.EXISTS (k.acc)
         THEN
            nd_ := ndacc_ (k.acc);
         ELSE
            nd_ := NULL;
         END IF;

         BEGIN
            SELECT   o.otd
                INTO otd_
                FROM otd_user o
               WHERE userid = k.isp AND ROWNUM = 1
            ORDER BY otd, pr;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               otd_ := 0;
         END;

         if k.s270 = '08' and rezpar11_ = 1 then --T19.03.2009
            sz_ := -rez.ostc96 (k.acc, dat_);
            IF k.r013 = '3' and SUBSTR (k.nbs, 4, 1) <> '8' then s080_name_ := 'Сомнительные %';
            else
               s080_name_ := ' % (S270 = 08)';
            end if;
         --IF k.priz = '80' OR k.nbs = '3589'
         elsIF k.priz = '80' OR k.nbs = '3589' or k.r013 = '3' --T 21.01.2009
         THEN
            --сомнительные %
            -- остаток на расчетную дату c ЗО
            sz_ := -rez.ostc96 (k.acc, dat_);
            s080_name_ := 'Сомнительные %';
         elsIF k.r013 = '2' --T 24.03.2009
         THEN
            --просроченные > 30
            -- остаток на расчетную дату c ЗО
            sz_ := -rez.ostc96 (k.acc, dat_);
            s080_name_ := 'Просроч.(>31д)';
         ELSE
            -- dbms_output.put_line('r013='||to_char(k.r013));
                --просроченные более 31 дня %
                -- остаток 31 день назад с ЗО
            IF    rzprr013_ = '0' AND rezpar8_ = '0'
               OR (rezpar8_ = '1' AND (k.r013 IS NULL OR k.r013 <> '2'))
            THEN
               --находим последний рабочий день --T 03.06.2009
              /* SELECT MAX (fdat)
                     INTO last_work_date_
                     FROM (SELECT fdat
                             FROM fdat
                           MINUS
                           SELECT holiday fdat
                             FROM holiday)
                    WHERE fdat <= LAST_DAY (dat_) ;

               --если рачет делается за последний РАБОЧИЙ день
               --то остаток за 30 дней назад определяется от последней КАЛЕНДАРНОЙ даты
               if last_work_date_ = dat_ then
                  last_work_date_ := LAST_DAY (dat_);
               else
                   last_work_date_ := dat_;
               end if;*/
               last_work_date_ := dat_; --T  03.06.2009

               --находим просрочку свыше 30 дней
               sz_ := f_get_rest_over_30(k.acc, last_work_date_ ); --T 24.03.2009
               s080_name_ := 'Просроч.(>31д) % (P)';
            ELSIF rzprr013_ = '1'
                  OR (rezpar8_ = '1' AND k.r013 IN ('1', '2'))
            THEN
               -- dbms_output.put_line('3');
               IF k.r013 = '2'
               THEN
                  --dbms_output.put_line('4');
                  sz_ := -rez.ostc96 (k.acc, dat_);
               --   dbms_output.put_line('sz_='||to_char(sz_));
               ELSE
                  --dbms_output.put_line('41');
                  sz_ := 0;
               END IF;
            END IF;
         END IF;


         -- dbms_output.put_line('sz_='||to_char(sz_));
           --сумма резерва
         IF sz_ > 0
         THEN
            -- dbms_output.put_line('5');
            idr_ := rez.id_nbs (k.nbs);
            szq_ := gl.p_icurval (k.kv, sz_, dat_);
            rezerv_ := sz_;

            IF    rezpar1_ = '1' AND k.custtype = '3'                                      THEN custtype_ := '2';
            ELSIF rezpar7_ = '1' AND k.custtype IN ('2', '3')  AND k.tip in ('SK9','OFR')  THEN custtype_ := '1';
            ELSE                                                                                custtype_ := k.custtype;
            END IF;

            IF mode_ <> 2 AND calcdoppar_ = 1
            THEN
               -- Вид обеспечения

               --ном дог
               BEGIN
                  SELECT SUBSTR (cc_id, 1, 20), obs, wdate, vidd
                    INTO cc_id_, obs_, kdate_, vidd_
                    FROM cc_deal
                   WHERE nd = nd_;
               EXCEPTION
                  WHEN NO_DATA_FOUND
                  THEN
                     cc_id_ := NULL;
                     obs_ := NULL;
                     nd_ := NULL;
                     kdate_ := NULL;
                     vidd_ := NULL;
               END;

               -- все по номеру последнего договра
                  -- начало действия договора
               BEGIN
                  SELECT wdate
                    INTO wdate_
                    FROM cc_add
                   WHERE nd = nd_ AND adds = 0;
               EXCEPTION
                  WHEN NO_DATA_FOUND
                  THEN
                     --wdate_ := NULL;
                     wdate_ := k.daos; --T 21.01.2009
               END;

               --для счетов относящихся к договорам кредитных линий
               --вместо даты открытия договора берем дату открытия счета -
               --т.к. дата открытия счета = дата транша
               if nvl(k.s182,0) = 3 then wdate_ := k.daos;--T 23.01.2009
               end if;

               -- Кол-во пролонгаций
               BEGIN
                  SELECT COUNT (*)
                    INTO kprolog_
                    FROM cc_prol
                   WHERE nd = nd_ AND acc = k.acc;
               EXCEPTION
                  WHEN NO_DATA_FOUND
                  THEN
                     kprolog_ := 0;
               END;

               --КП ЮЛ, ФЛ, МБК (ном.дог,обсл.,дата оконч.договора)
               kvk_ := k.kv;

               IF vidd_ = 3
               THEN
                  BEGIN
                     SELECT kv
                       INTO kvk_
                       FROM accounts a, nd_acc n
                      WHERE a.acc = n.acc
                        AND a.nbs = '8999'
                        AND nd = nd_
                        AND ROWNUM = 1;
                  EXCEPTION
                     WHEN NO_DATA_FOUND
                     THEN
                        kvk_ := k.kv;
                  END;
               END IF;

               --  начальная сумма в грн. и ном.
               BEGIN
                  SELECT gl.p_icurval (kvk_, lim2 / 100, dat_), lim2 / 100
                    INTO sg_, sv_
                    FROM cc_lim c
                   WHERE nd = nd_ AND fdat = (SELECT MIN (fdat)
                                                FROM cc_lim
                                               WHERE nd = nd_);
               EXCEPTION
                  WHEN NO_DATA_FOUND
                  THEN
                     sg_ := 0;
                     sv_ := 0;
               END;

               BEGIN
                  SELECT DISTINCT fdat
                             INTO dat_prol_
                             FROM cc_prol
                            WHERE nd = nd_
                              AND fdat = (SELECT MIN (fdat)
                                            FROM cc_prol
                                           WHERE nd = nd_ AND npp <> 0);
               EXCEPTION
                  WHEN NO_DATA_FOUND
                  THEN
                     dat_prol_ := NULL;
               END;
            END IF;

            curacc_ := NULL;

            IF mode_ <> 2
            THEN
               INSERT INTO tmp_rez_risk
                           (dat, ID, s080, s080_name, custtype, rnk,
                            nmk, kv, nls, sk, skq, soq, srq, szq,
                            sz, cc_id, idr, fin, obs,
                            rs080, country, pr_rez, rz,
                            acc, nd, wdate, kdate, sg, sv, kprolog,
                            pawn, obesp, dat_prol, isp, otd, tobo,
                            skq2, discont, prem, sn, szq2, corp
                            ,fl_newacc
                           )
                    VALUES (dat_, id_, '9', s080_name_, custtype_, k.rnk,
                            k.nmk, k.kv, k.nls, sz_, szq_, 0, szq_, szq_,
                            sz_, cc_id_, idr_, k.fin, obs_,
                            rez.r_s080 (k.fin, obs_), k.country, 100, k.rz,
                            k.acc, nd_, wdate_, kdate_, sg_, sv_, kprolog_,
                            vid_zal, zal_, dat_prol_, k.isp, otd_, k.tobo,
                            szq_, discont_, prem_, sn_, szq_, k.corp
                            ,'n'
                           );

                 insert into TMP_REZ_PARAMS
                 (dat , id  , acc , r013 ,
                  s270 , istval , s090 ,ob22
                  )
                  values(dat_, id_, k.acc, k.r013,
                  k.s270,null, null,
                  (select ob22 from specparam_int where acc = k.acc)
                  );
            END IF;
         END IF;
      END LOOP;

    /*  if pr_ = 1 then
         for k in
         (select acc, min(sz1) sz1 from tmp_rez_risk
          where sz1 is not null
                and dat = dat_ and id <> userid_
          group by acc
          )
          loop
            update tmp_rez_risk r
            set r.sz1 = k.sz1
            where r.dat = dat_ and r.id = userid_ and r.acc = k.acc
            ;
          end loop;
      end if;*/


      IF mode_ <> 2
      THEN
         MERGE INTO tmp_rez_risk n
            USING (SELECT ID, acc, dat_ dat, s080, s080_name, custtype, rnk,
                          nmk, kv, nls, sk, skq, soq, srq, szq, sz, cc_id,
                          idr, fin, obs, rs080, country, pr_rez, rz, nd,
                          wdate, kdate, sg, sv, kprolog, pawn, obesp,
                          dat_prol, isp, otd, tobo, skq2, discont, prem, sn,
                          szq2, corp, istval, odncre, dnipr
                     FROM tmp_rez_risk
                    WHERE dat = oldrez_date_
                      AND ID = oldrez_userid_
                      AND (sz <> 0 OR sz1 <> 0)) o
            ON (
            n.ID = userid_ and
            n.dat = dat_--o.dat --T 03.02.2009
            AND n.acc = o.acc)
            WHEN MATCHED THEN
               UPDATE
                  SET n.rezold = NVL (o.sz, 0),
                      n.delrez = NVL (n.sz, 0) - NVL (o.sz, 0),
                      n.rezoldq = NVL (o.szq, 0),
                      n.delrezq = NVL (n.szq, 0) - NVL (o.szq, 0),
                      n.delrezqcurs =
                           NVL (n.szq, 0)
                         - (  NVL (o.szq, 0)
                            + gl.p_icurval (COALESCE (n.kv, o.kv),
                                            NVL (n.sz, 0) - NVL (o.sz, 0),
                                            dat_
                                           )
                           ),
                      n.fl_newacc = 'u'
            WHEN NOT MATCHED THEN
               INSERT (n.ID, n.dat, n.acc, n.s080, n.s080_name, n.custtype,
                       n.rnk, n.nmk, n.kv, n.nls, n.sk, n.skq, n.soq, n.srq,
                       n.szq, n.sz, n.cc_id, n.idr, n.fin, n.obs, n.rs080,
                       n.country, n.pr_rez, n.rz, n.nd, n.wdate, n.kdate,
                       n.sg, n.sv, n.kprolog, n.pawn, n.obesp, n.dat_prol,
                       n.isp, n.otd, n.tobo, n.skq2, n.discont, n.prem, n.sn,
                       n.szq2, n.corp, n.istval, n.odncre, n.dnipr,
                       n.fl_newacc, n.rezold, n.delrez, n.rezoldq, n.delrezq,
                       n.delrezqcurs)
               VALUES (--o.ID, o.dat,
                       userid_,  dat_, --T 03.02.2009
                       o.acc, o.s080, o.s080_name, o.custtype,
                       o.rnk, o.nmk, o.kv, o.nls, 0, 0, 0, 0, 0, 0, o.cc_id,
                       o.idr, o.fin, o.obs, o.rs080, o.country, o.pr_rez,
                       o.rz, o.nd, o.wdate, o.kdate, 0, 0, o.kprolog, o.pawn,
                       o.obesp, o.dat_prol, o.isp, o.otd, o.tobo, 0, 0, 0, 0,
                       0, o.corp, o.istval, o.odncre, o.dnipr, 'i',
                       NVL (o.sz, 0), -NVL (o.sz, 0), NVL (o.szq, 0),
                       -NVL (o.szq, 0),
                       - (  NVL (o.szq, 0)
                          + gl.p_icurval (o.kv, -NVL (o.sz, 0), dat_)
                         ));

         delete from tmp_rez_risk --T 03.02.2009
         where ID = userid_ AND dat = dat_ AND fl_newacc = 'i';

         UPDATE tmp_rez_risk
            SET rezold = 0,
                delrez = NVL (sz, 0),
                rezoldq = 0,
                delrezq = NVL (szq, 0),
                delrezqcurs = 0
          WHERE ID = id_ AND dat = dat_ AND fl_newacc IS NULL;

         FOR k IN (SELECT   pc.acc, SUM (pc.s) s
                       FROM opldok pd, accounts ad, opldok pc, accounts ac
                      WHERE pd.REF = pc.REF
                        AND pd.dk = 0
                        AND pc.dk = 1
                        AND pd.s = pc.s
                        AND pd.acc = ad.acc
                        AND pc.acc = ac.acc
                        AND ad.nbs IN ('2401', '2400', '2490')
                        AND ac.nbs LIKE ('2%')
                        AND pd.sos = 5
                        AND pd.fdat BETWEEN TRUNC (dat_, 'MM') AND dat_
                   GROUP BY pc.acc)
         LOOP
            UPDATE tmp_rez_risk
               SET pogrez = k.s
             WHERE acc = k.acc AND dat = dat_ AND ID = id_;
         END LOOP;

         IF allzal_.COUNT () <> 0
         THEN
            FOR k IN allzal_.FIRST .. allzal_.LAST
            LOOP
               IF allzal_.EXISTS (k)
               THEN
                  INSERT INTO tmp_rez_risk2
                              (dat, userid,
                               accs, accz,
                               pawn, s,
                               spriv, proc
                              )
                       VALUES (allzal_ (k).dat, allzal_ (k).userid,
                               allzal_ (k).accs, allzal_ (k).accz,
                               allzal_ (k).pawn, allzal_ (k).s,
                               allzal_ (k).spriv, allzal_ (k).proc
                              );
               END IF;
            END LOOP;
         END IF;

         IF alldisc_.COUNT () <> 0
         THEN
            FOR k IN alldisc_.FIRST .. alldisc_.LAST
            LOOP
               IF alldisc_.EXISTS (k)
               THEN
                  NULL;

                  INSERT INTO tmp_rez_risk3
                              (dat, userid,
                               accs, accd,
                               nd, sd,
                               sdall, sk,
                               skall
                              )
                       VALUES (alldisc_ (k).dat, alldisc_ (k).userid,
                               alldisc_ (k).accs, alldisc_ (k).accd,
                               alldisc_ (k).nd, alldisc_ (k).sd,
                               alldisc_ (k).sdall, alldisc_ (k).sk,
                               alldisc_ (k).skall
                              );
               END IF;
            END LOOP;
         END IF;

         IF allprem_.COUNT () <> 0
         THEN
            FOR k IN allprem_.FIRST .. allprem_.LAST
            LOOP
               IF allprem_.EXISTS (k)
               THEN
                  NULL;

                  INSERT INTO tmp_rez_risk4
                              (dat, userid,
                               accs, accp,
                               nd, sp,
                               spall, sk,
                               skall
                              )
                       VALUES (allprem_ (k).dat, allprem_ (k).userid,
                               allprem_ (k).accs, allprem_ (k).accp,
                               allprem_ (k).nd, allprem_ (k).sp,
                               allprem_ (k).spall, allprem_ (k).sk,
                               allprem_ (k).skall
                              );
               END IF;
            END LOOP;
         END IF;
      END IF;

      p_unload_data;
      flagkorprov_ := 0;
      flagallrez_ := 0;

      IF mode_ = 10 then --T 04.12.2008 сделано для отчетов по резервам
                         -- поскольку перед вызовом отчета запускается ф-я расчета резерва
                         --нужно закомитить то что она посчитала
                         --т.к. больше некому)))
         commit;
      end if;

   END rez_risk;

--------------------------------------
   PROCEDURE ca_pay_rez (dat_ DATE, mode_ NUMBER DEFAULT 0, p_user number default null)
   IS
      dat_form       DATE;                        -- предыдущая отчетная дата
      dat2_          DATE;                         -- текущая банковская дата
      s_old_         NUMBER;
      s_old_q        NUMBER;
      s_new_         NUMBER;
      s_new_q        NUMBER;
      ref_           INT;
      dk_            INT;
      ost_           NUMBER;
      tt_            CHAR (3);
      f7702_         VARCHAR2 (15);
      r7702_         VARCHAR2 (15);
      s6204_         VARCHAR2 (15);
      id_            INT;
      ret1_          INT;
      acc_           INT;
      rnk_           INT;
      nam_a_         VARCHAR2 (38);
      nam_b_         VARCHAR2 (38);
      nazn_          VARCHAR2 (160);
      vob_           NUMBER;
      kurs_          VARCHAR2 (30);
      okpoa_         VARCHAR2 (14);
      okpob_         VARCHAR2 (14);
      rezs_          VARCHAR2 (50);
      otvisp_        NUMBER;
      ern   CONSTANT POSITIVE       := 300;
      err            EXCEPTION;
      erm            VARCHAR2 (1000)
                      := 'Помилка заповнення дов_дника рахунк_в резервування';
   BEGIN

      --Для сбербанка
      if nvl(GetGlobalOption('OB22'),0) = 1 then
          execute immediate 'begin REZ_PAY_OB22 (:dat_ , :mode_ , :p_user) ; end;'
          using dat_ , mode_, p_user;
          RETURN;
      end if;

      -- применять программу оплаты 2
      IF rezpay2_ = 1
      THEN
         ca_pay_rez2 (dat_, mode_);
         RETURN;
      END IF;


      dat2_ := bankdate;

      /* SELECT NVL (MAX (vdat), dat_)
        INTO dat_form
        FROM oper
       WHERE tt IN ('ARE', 'AR*') AND sos = 5 AND vdat <= dat_;*/

        SELECT -- + index(oper XIE_VDAT_OPER)
        NVL (MAX (vdat), dat_)
        INTO dat_form
        FROM oper
       WHERE tt like 'AR_' AND sos = 5 AND vdat between (dat_-90) and dat_;


      -- Возвращает код тек. пользователя STAFF.ID
      BEGIN
         SELECT ID
           INTO id_
           FROM staff
          WHERE UPPER (logname) = USER;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            id_ := 1;
      END;

      --проверка всем ли счетам по которым расчитан резерв
      --соответствуют счета резервного фонда
      --Т 20.01.2009
      if rezpar10_ = 0 then
          for r in
          (select count(*) qnt
            from tmp_rez_risk r
            where r.dat = dat_ and r.id = id_
                  and nvl(r.sz,nvl(sz1, 0))<> 0
                  and not exists
                  (select 1
                   from srezerv s
                   where r.custtype = s.custtype and r.s080 = s.s080 and r.idr = s.id
                         and rez.id_specrez(r.wdate, r.istval, r.kv, r.idr, r.custtype) = s.SPECREZ
                         and trim(nvl(s.s_fondnr, s.s_fond)) is not null
                  )
           ) loop
             if r.qnt <> 0 then
                bars_error.raise_error('REZ',1);
             end if;
           end loop;
      end if;

      -- ОКПО
      BEGIN
         SELECT SUBSTR (val, 1, 14)
           INTO okpoa_
           FROM params
          WHERE par = 'OKPO';
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            okpoa_ := '';
      END;

      IF mode_ = 1
      THEN
         DELETE FROM rez_doc_maket;
      --COMMIT;
      END IF;

      -- расформирование фонда
      FOR k IN (SELECT DISTINCT t.kv, s.s080, s.s_fond, s_fondnr, s.s_form,
                                s.s_formv, s.s_rasf, s.s_rasfv, 1 rz,
                                s.otvisp, s.otvispval
                           FROM srezerv s,
                                tabval t,
                                (SELECT crisk, NAME, rez
                                   FROM crisk
                                 where crisk <> '9' --T 21.01.2009
                                 UNION ALL
                                 SELECT '9', 'Просроч.%', 100
                                   FROM DUAL) r
                          WHERE r.crisk = s.s080
                            AND s.s_fond IS NOT NULL
                            AND s.s_form IS NOT NULL
                            AND s.s_formv IS NOT NULL
                            AND s.s_rasf IS NOT NULL
                            AND s.s_rasfv IS NOT NULL

                UNION
                SELECT DISTINCT t.kv, s.s080, NVL (s.s_fondnr, s.s_fond), '',
                                s.s_form, s.s_formv, s.s_rasf, s.s_rasfv,
                                2 rz, s.otvisp, s.otvispval
                           FROM srezerv s,
                                tabval t,
                                (SELECT crisk, NAME, rez
                                   FROM crisk
                                 where crisk <> '9' --T 21.01.2009
                                 UNION ALL
                                 SELECT '9', 'Просроч.%', 100
                                   FROM DUAL) r
                          WHERE r.crisk = s.s080
                            AND s.s_fond IS NOT NULL
                            AND s.s_form IS NOT NULL
                            AND s.s_formv IS NOT NULL
                            AND s.s_rasf IS NOT NULL
                            AND s.s_rasfv IS NOT NULL
                            AND s.s_fondnr IS NOT NULL
                            )
      LOOP
         IF k.kv = '980'
         THEN
            otvisp_ := NVL (k.otvisp, userid_);
         ELSE
            otvisp_ := NVL (k.otvispval, userid_);
         END IF;

         IF k.s080 = '1' OR k.s080 = '9'
         THEN
            tt_ := 'ARE';                                   --для стандартных
         ELSE
            tt_ := 'AR*';                                 --для НЕстандартных
         END IF;

         -- Работаем с ИН.вал или НАЦ.вал
         IF k.kv = 980
         THEN
            f7702_ := k.s_form;
            r7702_ := k.s_rasf;

            -- Определяем необходимый вид VOB
            IF TO_CHAR (dat2_, 'YYYYMM') > TO_CHAR (dat_, 'YYYYMM')
            THEN
               vob_ := 96;
            ELSE
               vob_ := 6;
            END IF;
         ELSE
            f7702_ := k.s_formv;
            r7702_ := k.s_rasfv;

            -- Определяем необходимый вид VOB
            IF TO_CHAR (dat2_, 'YYYYMM') > TO_CHAR (dat_, 'YYYYMM')
            THEN
               vob_ := 96;
            ELSE
               vob_ := 16;
            END IF;
         END IF;

         ----    расформирование резерва
         s_old_ := 0;

         -- узнать предыдущие остатки и их текущий экв.
         BEGIN
--             SELECT ost
--               INTO s_old_
--               FROM sal
--              WHERE fdat = dat_ AND nls = k.s_fond AND kv = k.kv;
            SELECT NVL (SUM (rez.ostc96 (a.acc, dat_)), 0)
              INTO s_old_
              FROM accounts a
             WHERE a.nls = k.s_fond AND a.kv = k.kv;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               s_old_ := 0;
         END;

         IF s_old_ > 0
         THEN
            s_old_q := gl.p_icurval (k.kv, s_old_, dat_form);

--             IF deb.DEBUG
--             THEN
--                deb.TRACE (ern, '2.', s_old_ || ' ' || s_old_q);
--             END IF;

            -- узнать название нужных счетов для вставки в OPER
            BEGIN
               SELECT SUBSTR (a.nms, 1, 38), SUBSTR (b.nms, 1, 38)
                 INTO nam_a_, nam_b_
                 FROM accounts a, accounts b
                WHERE a.kv = k.kv
                  AND a.nls = k.s_fond
                  AND b.kv = 980
                  AND b.nls = r7702_;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  nam_a_ := 'Сч.фонда';
                  nam_b_ := 'Сч.расформирования фонда';
            END;

            -- проводка по расформированию резерва
            IF mode_ = 0
            THEN
               gl.REF (ref_);
            END IF;

            IF k.kv <> 980
            THEN
               SELECT ' по курсу ' || TO_CHAR (cur.rate_o, '99999.0000')
                 INTO kurs_
                 FROM cur_rates cur
                WHERE cur.kv = k.kv
                  AND vdate = (SELECT MAX (vdate)
                                 FROM cur_rates
                                WHERE kv = k.kv AND vdate <= dat_form);
            ELSE
               kurs_ := '';
            END IF;

            IF vob_ <> 96
            THEN
               nazn_ :=
                     'Розформування резерву, сформованого станом за '
                  || TO_CHAR (dat_form, 'dd/mm/yyyy')
                  || kurs_;
            ELSE
               nazn_ :=
                     'Коригуюча проводка по розформуванню резерву, '
                  || 'сформованого станом за '
                  || TO_CHAR (dat_form, 'dd/mm/yyyy')
                  || kurs_;
            END IF;

            IF mode_ = 0
            THEN
               INSERT INTO oper
                           (REF, tt, vob, nd, dk, pdat, vdat, datd,
                            datp, nam_a, nlsa, mfoa, id_a,
                            nam_b, nlsb, mfob, id_b, kv, s,
                            kv2, s2, nazn, userid
                           )
                    VALUES (ref_, tt_, vob_, ref_, 1, SYSDATE, dat_, dat2_,
                            dat2_, nam_a_, k.s_fond, gl.amfo, okpoa_,
                            nam_b_, r7702_, gl.amfo, okpoa_, k.kv, s_old_,
                            980, s_old_q, nazn_, otvisp_
                           );

               paytt (0,
                      ref_,
                      dat_,
                      tt_,
                      1,
                      k.kv,
                      k.s_fond,
                      s_old_,
                      980,
                      r7702_,
                      s_old_q
                     );
            ELSIF mode_ = 1
            THEN
               INSERT INTO rez_doc_maket
                           (tt, vob, pdat, vdat, datd, datp, nam_a,
                            nlsa, mfoa, id_a, nam_b, nlsb,
                            mfob, id_b, kv, s, kv2, s2,
                            nazn, userid
                           )
                    VALUES (tt_, vob_, SYSDATE, dat_, dat2_, dat2_, nam_a_,
                            k.s_fond, gl.amfo, okpoa_, nam_b_, r7702_,
                            gl.amfo, okpoa_, k.kv, s_old_q, 980, s_old_,
                            nazn_, otvisp_
                           );
            END IF;
         END IF;
      END LOOP;

      -- курсор: по всем видам клиентов, резидентности, категориям риска и валютам
      FOR k IN (SELECT s.custtype, s.s080, r.NAME, t.kv, s.s_fond, s_fondnr,
                       s.s_form, s.s_formv, s.s_rasf, s.s_rasfv, s.ID, 1 rz,
                       s.otvisp, s.otvispval
                       ,s.specrez --T 13.01.2009
                  FROM srezerv s,
                       tabval t,
                       (SELECT crisk, NAME, rez
                          FROM crisk
                        where crisk <> '9' --T 21.01.2009
                        UNION ALL
                        SELECT '9', 'Просроч.%', 100
                          FROM DUAL) r
                 WHERE r.crisk = s.s080
                   AND s.s_fond IS NOT NULL
                   AND s.s_form IS NOT NULL
                   AND s.s_formv IS NOT NULL
                   AND s.s_rasf IS NOT NULL
                   AND s.s_rasfv IS NOT NULL
                UNION
                SELECT s.custtype, s.s080, r.NAME, t.kv,
                       NVL (s.s_fondnr, s.s_fond), '', s.s_form, s.s_formv,
                       s.s_rasf, s.s_rasfv, s.ID, 2 rz, s.otvisp, s.otvispval
                       ,s.specrez --T 13.01.2009
                  FROM srezerv s,
                       tabval t,
                       (SELECT crisk, NAME, rez
                          FROM crisk
                        where crisk <> '9' --T 21.01.2009
                        UNION ALL
                        SELECT '9', 'Просроч.%', 100
                          FROM DUAL) r
                 WHERE r.crisk = s.s080
                   AND s.s_fond IS NOT NULL
                   AND s.s_form IS NOT NULL
                   AND s.s_formv IS NOT NULL
                   AND s.s_rasf IS NOT NULL
                   AND s.s_rasfv IS NOT NULL
                   AND s.s_fondnr IS NOT NULL
                   )
      LOOP
         IF k.kv = '980'
         THEN
            otvisp_ := NVL (k.otvisp, userid_);
         ELSE
            otvisp_ := NVL (k.otvispval, userid_);
         END IF;

--   IF deb.debug THEN
--     deb.trace(ern,'1.',k.S080||' '||k.CUSTTYPE||' '||k.kv);
--   END IF;
         IF k.s080 = '1' OR k.s080 = '9'
         THEN
            tt_ := 'ARE';                                   --для стандартных
         ELSE
            tt_ := 'AR*';                                 --для НЕстандартных
         END IF;

         -- Работаем с ИН.вал или НАЦ.вал
         IF k.kv = 980
         THEN
            f7702_ := k.s_form;
            r7702_ := k.s_rasf;

            -- Определяем необходимый вид VOB
            IF TO_CHAR (dat2_, 'YYYYMM') > TO_CHAR (dat_, 'YYYYMM')
            THEN
               vob_ := 96;
            ELSE
               vob_ := 6;
            END IF;
         ELSE
            f7702_ := k.s_formv;
            r7702_ := k.s_rasfv;

            -- Определяем необходимый вид VOB
            IF TO_CHAR (dat2_, 'YYYYMM') > TO_CHAR (dat_, 'YYYYMM')
            THEN
               vob_ := 96;
            ELSE
               vob_ := 16;
            END IF;
         END IF;

         ----    формирование резерва
         s_new_ := 0;

         -- узнать новые суммы резерва
         IF k.rz = 1
         THEN                                       -- для резидентов или всех
            IF k.s_fondnr IS NULL
            THEN                                                       -- все
               SELECT NVL (SUM (NVL (sz1, sz)), 0)
                 INTO s_new_
                 FROM tmp_rez_risk r
                WHERE r.s080 = k.s080
                  AND r.custtype = k.custtype
                  AND r.kv = k.kv
                  AND r.dat = dat_
                  AND ID = id_
                  AND r.idr = k.ID
                  and id_specrez(r.wdate, r.istval,k.kv, r.idr,r.custtype) = k.specrez --T 13.01.2009
                  ;
            ELSIF k.s_fondnr IS NOT NULL AND NVL (k.s_fondnr, 'x') <> k.s_fond
            THEN                                           -- только резиденты
               SELECT NVL (SUM (NVL (sz1, sz)), 0)
                 INTO s_new_
                 FROM tmp_rez_risk r
                WHERE r.s080 = k.s080
                  AND r.custtype = k.custtype
                  AND r.kv = k.kv
                  AND r.dat = dat_
                  AND ID = id_
                  AND r.idr = k.ID
                  AND r.rz = 1
                  and id_specrez(r.wdate, r.istval,k.kv, r.idr,r.custtype) = k.specrez --T 13.01.2009
                  ;
            END IF;
         ELSIF k.rz = 2
         THEN                                              -- для нерезидентов
            SELECT NVL (SUM (NVL (sz1, sz)), 0)
              INTO s_new_
              FROM tmp_rez_risk r
             WHERE r.s080 = k.s080
               AND r.custtype = k.custtype
               AND r.kv = k.kv
               AND r.dat = dat_
               AND ID = id_
               AND r.idr = k.ID
               AND r.rz = 2
               and id_specrez(r.wdate, r.istval,k.kv, r.idr,r.custtype) = k.specrez --T 13.01.2009
               ;
         END IF;

         IF s_new_ > 0
         THEN
            -- текущий экв. новой суммы резерва
            s_new_q := gl.p_icurval (k.kv, s_new_, dat_);

--             IF deb.DEBUG
--             THEN
--                deb.TRACE (ern, '!!!3.', s_new_ || ' ' || s_new_q);
--             END IF;

            -- открыть счета резервирования, если их нет
            IF mode_ = 0
            THEN
               BEGIN
                  SELECT acc
                    INTO acc_
                    FROM accounts
                   WHERE nls = k.s_fond AND kv = k.kv;
               EXCEPTION
                  WHEN NO_DATA_FOUND
                  THEN
                     BEGIN
                        BEGIN
                           SELECT val
                             INTO rnk_
                             FROM params
                            WHERE par = 'OUR_RNK';
                        EXCEPTION
                           WHEN NO_DATA_FOUND
                           THEN
                              rnk_ := 1;
                        END;

                        nam_a_ :=
                           SUBSTR (   'Рез.фонд по '
                                   || iif_s (k.custtype,
                                             2,
                                             'Банкам',
                                             'Юр.ос.',
                                             'Фiз.ос.'
                                            )
                                   || '. Кат.'
                                   || k.NAME,
                                   1,
                                   38
                                  );
                        op_reg (99,
                                0,
                                0,
                                0,
                                ret1_,
                                rnk_,
                                k.s_fond,
                                k.kv,
                                nam_a_,
                                'ODB',
                                id_,
                                acc_
                               );
                     END;
               END;
            END IF;

            -- узнать название нужных счетов для вставки в OPER
            BEGIN
               SELECT SUBSTR (a.nms, 1, 38), SUBSTR (b.nms, 1, 38)
                 INTO nam_a_, nam_b_
                 FROM accounts a, accounts b
                WHERE a.kv = k.kv
                  AND a.nls = k.s_fond
                  AND b.kv = 980
                  AND b.nls = f7702_;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  nam_a_ := 'Сч.Фонда';
                  nam_b_ := 'Сч.формирования Фонда';
            END;

            -- проводка по формированию резерва
            IF mode_ = 0
            THEN
               gl.REF (ref_);
            END IF;

            IF k.kv <> 980
            THEN
               SELECT ' по курсу ' || TO_CHAR (cur.rate_o, '99999.0000')
                 INTO kurs_
                 FROM cur_rates cur
                WHERE cur.kv = k.kv
                  AND vdate = (SELECT MAX (vdate)
                                 FROM cur_rates
                                WHERE kv = k.kv AND vdate <= dat_);
            ELSE
               kurs_ := '';
            END IF;

            IF vob_ <> 96
            THEN
               nazn_ :=
                  SUBSTR (   'Формування резерву станом за '
                          || TO_CHAR (dat_, 'dd/mm/yyyy')
                          || kurs_
                          || ' ('
                          || k.NAME
                          || ')',
                          1,
                          160
                         );
            ELSE
               nazn_ :=
                  SUBSTR
                     (   'Коригуюча проводка по формуванню резерву станом за '
                      || TO_CHAR (dat_, 'dd/mm/yyyy')
                      || kurs_
                      || ' ('
                      || k.NAME
                      || ')',
                      1,
                      160
                     );
            END IF;

            IF mode_ = 0
            THEN
               INSERT INTO oper
                           (REF, tt, vob, nd, dk, pdat, vdat, datd,
                            datp, nam_a, nlsa, mfoa, id_a,
                            nam_b, nlsb, mfob, id_b, kv, s,
                            kv2, s2, nazn, userid
                           )
                    VALUES (ref_, tt_, vob_, ref_, 0, SYSDATE, dat_, dat2_,
                            dat2_, nam_a_, k.s_fond, gl.amfo, okpoa_,
                            nam_b_, f7702_, gl.amfo, okpoa_, k.kv, s_new_,
                            980, s_new_q, nazn_, otvisp_
                           );

               paytt (0,
                      ref_,
                      dat_,
                      tt_,
                      0,
                      k.kv,
                      k.s_fond,
                      s_new_,
                      980,
                      f7702_,
                      s_new_q
                     );
            ELSIF mode_ = 1
            THEN
               INSERT INTO rez_doc_maket
                           (tt, vob, pdat, vdat, datd, datp, nam_a,
                            nlsa, mfoa, id_a, nam_b, nlsb,
                            mfob, id_b, kv, s, kv2, s2,
                            nazn, userid
                           )
                    VALUES (tt_, vob_, SYSDATE, dat_, dat2_, dat2_, nam_b_,
                            f7702_, gl.amfo, okpoa_, nam_a_, k.s_fond,
                            gl.amfo, okpoa_, 980, s_new_q, k.kv, s_new_,
                            nazn_, otvisp_
                           );
            END IF;
         END IF;
      END LOOP;

      IF mode_ = 0
      THEN
         UPDATE rez_protocol
            SET userid = id_
          WHERE dat = dat_;

         IF SQL%ROWCOUNT = 0
         THEN
            INSERT INTO rez_protocol
                        (userid, dat
                        )
                 VALUES (id_, dat_
                        );
         END IF;
      END IF;

   exception when others then
         rollback;
         erm := '';
         if instr(sqlerrm, 'REZ') = 0 then
           --стек ошибок - если позволяет версия оракла
           begin
             execute immediate 'select substr(substr(dbms_utility.format_error_backtrace,instr(dbms_utility.format_error_backtrace,'':'')+1),1,900) from dual' into erm;
           exception when others then
              null;
           end;
           erm := substr(substr(sqlerrm,instr(sqlerrm,':')+1),1,99)||': '||erm;
           insert into cp_rez_log (USERID,ID,ROWNUMBER,TXT, VAL, DT)
           values (user_id, null, 1, erm, 'ca_pay_rez', sysdate);
           commit;
           bars_error.raise_error('REZ',5);
         else
           raise;
         end if;
   END ca_pay_rez;

--------------------------------------
   PROCEDURE ca_pay_rez2 (dat_ DATE, mode_ NUMBER DEFAULT 0)
   IS
      dat_form       DATE;                        -- предыдущая отчетная дата
      dat2_          DATE;                         -- текущая банковская дата
      s_old_         NUMBER;
      s_old_q        NUMBER;
      s_new_         NUMBER;
      s_new_q        NUMBER;
      ref_           INT;
      dk_            INT;
      ost_           NUMBER;
      tt_            CHAR (3);
      f7702_         VARCHAR2 (15);
      r7702_         VARCHAR2 (15);
      s6204_         VARCHAR2 (15);
      id_            INT;
      id2_           INT;
      ret1_          INT;
      acc_           INT;
      rnk_           INT;
      nam_a_         VARCHAR2 (38);
      nam_b_         VARCHAR2 (38);
      nazn_          VARCHAR2 (160);
      vob_           NUMBER;
      kurs_          VARCHAR2 (30);
      okpoa_         VARCHAR2 (14);
      okpob_         VARCHAR2 (14);
      rezs_          VARCHAR2 (50);
      otvisp_        NUMBER;
      ern   CONSTANT POSITIVE       := 300;
      err            EXCEPTION;
      erm            VARCHAR2 (1000)
                      := 'Помилка заповнення дов_дника рахунк_в резервування';

dummy number := 0;
s varchar2(100);

   BEGIN

       dat2_ := bankdate;

       /* SELECT NVL (MAX (vdat), dat_)
        INTO dat_form
        FROM oper
       WHERE tt IN ('ARE', 'AR*') AND sos = 5 AND vdat < dat_;*/

        SELECT -- + index(oper XIE_VDAT_OPER)
        NVL (MAX (vdat), dat_)
        INTO dat_form
        FROM oper
       WHERE tt like 'AR_' AND sos = 5 AND vdat between (dat_-90) and dat_;

      -- Возвращает код тек. пользователя STAFF.ID
      BEGIN
         SELECT ID
           INTO id_
           FROM staff
          WHERE UPPER (logname) = USER;
      END;

      --проверка всем ли счетам по которым расчитан резерв
      --соответствуют счета резервного фонда
      --Т 20.01.2009
      if rezpar10_ = 0 then
          for r in
          (select count(*) qnt
            from tmp_rez_risk r
            where r.dat = dat_ and r.id = id_
                  and nvl(r.sz,nvl(sz1, 0))<> 0
                  and not exists
                  (select 1
                   from srezerv s
                   where r.custtype = s.custtype and r.s080 = s.s080 and r.idr = s.id
                         and rez.id_specrez(r.wdate, r.istval, r.kv, r.idr, r.custtype) = s.SPECREZ
                         and trim(nvl(s.s_fondnr, s.s_fond)) is not null
                  )
           ) loop
             if r.qnt <> 0 then
                bars_error.raise_error('REZ',1);
             end if;
           end loop;
      end if;
      -- ОКПО
      BEGIN
         SELECT SUBSTR (val, 1, 14)
           INTO okpoa_
           FROM params
          WHERE par = 'OKPO';
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            okpoa_ := '';
      END;

      IF mode_ = 1
      THEN
         DELETE FROM rez_doc_maket;
      --COMMIT;
      END IF;

      -- расформирование фонда
      FOR k IN (SELECT DISTINCT s.ID, s.custtype, t.kv, s.s080, s.s_fond,
                                s_fondnr, s.s_form, s.s_formv, s.s_rasf,
                                s.s_rasfv, 1 rz, s.otvisp, s.otvispval
                                ,s.specrez --T 13.01.2009
                           FROM srezerv s,
                                tabval t,
                                (SELECT crisk, NAME, rez
                                   FROM crisk
                                where crisk <> '9' --T 21.01.2009
                                 UNION ALL
                                 SELECT '9', 'Просроч.%', 100
                                   FROM DUAL) r
                          WHERE r.crisk = s.s080
                            AND s.s_fond IS NOT NULL
                            AND s.s_form IS NOT NULL
                            AND s.s_formv IS NOT NULL
                            AND s.s_rasf IS NOT NULL
                            AND s.s_rasfv IS NOT NULL
                           -- and t.kv = '980'
                UNION
                SELECT DISTINCT s.ID, s.custtype, t.kv, s.s080,
                                NVL (s.s_fondnr, s.s_fond), '', s.s_form,
                                s.s_formv, s.s_rasf, s.s_rasfv, 2 rz,
                                s.otvisp, s.otvispval
                                ,s.specrez --T 13.01.2009
                           FROM srezerv s,
                                tabval t,
                                (SELECT crisk, NAME, rez
                                   FROM crisk
                                 where crisk <> '9' --T 21.01.2009
                                 UNION ALL
                                 SELECT '9', 'Просроч.%', 100
                                   FROM DUAL) r
                          WHERE r.crisk = s.s080
                            AND s.s_fond IS NOT NULL
                            AND s.s_form IS NOT NULL
                            AND s.s_formv IS NOT NULL
                            AND s.s_rasf IS NOT NULL
                            AND s.s_rasfv IS NOT NULL
                            AND s.s_fondnr IS NOT NULL
                           -- and t.kv = '980'
                            )
      LOOP
dummy := 1;
s :=   k.s_fond;
         IF k.kv = '980'
         THEN
            otvisp_ := NVL (k.otvisp, userid_);
         ELSE
            otvisp_ := NVL (k.otvispval, userid_);
         END IF;

         --if k.kv = '980' then
         IF k.s080 = '1' OR k.s080 = '9'
         THEN
            tt_ := 'ARE';                                   --для стандартных
         ELSE
            tt_ := 'AR*';                                 --для НЕстандартных
         END IF;

         BEGIN
            SELECT isp
              INTO id2_
              FROM accounts
             WHERE nls = k.s_fond AND kv = k.kv;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               id2_ := NULL;
         END;

         -- Работаем с ИН.вал или НАЦ.вал
         IF k.kv = 980
         THEN
            f7702_ := k.s_form;
            r7702_ := k.s_rasf;

            -- Определяем необходимый вид VOB
            IF TO_CHAR (dat2_, 'YYYYMM') > TO_CHAR (dat_, 'YYYYMM')
            THEN
               vob_ := 96;
            ELSE
               vob_ := 6;
            END IF;
         ELSE
            f7702_ := k.s_formv;
            r7702_ := k.s_rasfv;

            -- Определяем необходимый вид VOB
            IF TO_CHAR (dat2_, 'YYYYMM') > TO_CHAR (dat_, 'YYYYMM')
            THEN
               vob_ := 96;
            ELSE
               vob_ := 16;
            END IF;
         END IF;

         ----    расформирование резерва
         s_old_ := 0;
dummy := 100;
         -- узнать предыдущие остатки и их текущий экв.
         BEGIN
--            SELECT ost
--              INTO s_old_
--              FROM sal
--             WHERE fdat = dat_ AND nls = k.s_fond AND kv = k.kv;
            SELECT NVL (SUM (rez.ostc96 (a.acc, dat_)), 0) --T 16.01.2009
              INTO s_old_
              FROM accounts a
             WHERE a.nls = k.s_fond AND a.kv = k.kv;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               s_old_ := 0;
         END;
dummy := 101;
         --IF s_old_ > 0
         --THEN
         s_old_q := gl.p_icurval (k.kv, s_old_, dat_form);

         -- узнать название нужных счетов для вставки в OPER
         BEGIN
            SELECT SUBSTR (a.nms, 1, 38), SUBSTR (b.nms, 1, 38)
              INTO nam_a_, nam_b_
              FROM accounts a, accounts b
             WHERE a.kv = k.kv
               AND a.nls = k.s_fond
               AND b.kv = 980
               AND b.nls = r7702_;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               nam_a_ := 'Сч.фонда';
               nam_b_ := 'Сч.расформирования фонда';
         END;
dummy := 102;
         -- проводка по расформированию резерва
         IF mode_ = 0
         THEN
            gl.REF (ref_);
         END IF;

         IF k.kv <> 980
            and s_old_ <> 0 --T 19.01.2009
         THEN
            SELECT ' по курсу ' || TO_CHAR (cur.rate_o, '99999.0000')
              INTO kurs_
              FROM cur_rates cur
             WHERE cur.kv = k.kv
               AND vdate = (SELECT MAX (vdate)
                              FROM cur_rates
                             WHERE kv = k.kv AND vdate <= dat_form);
         ELSE
            kurs_ := '';
         END IF;
dummy := 103;
         IF vob_ <> 96
         THEN
            nazn_ :=
                  'Розформування резерву, сформованого станом на '
               || TO_CHAR (LAST_DAY (dat_form) + 1, 'dd/mm/yyyy')
               || kurs_;
         ELSE
            nazn_ :=
                  'Коригуюча проводка по розформуванню резерву, '
               || 'сформованого станом на '
               || TO_CHAR (LAST_DAY (dat_form) + 1, 'dd/mm/yyyy')
               || kurs_;
         END IF;

dummy := 2;
         IF k.kv <> 980
         THEN
            IF s_old_ <> 0
            THEN
dummy := 3;
               IF mode_ = 0
               THEN
                  INSERT INTO oper
                              (REF, tt, vob, nd, dk, pdat, vdat,
                               datd, datp, nam_a, nlsa, mfoa,
                               id_a, nam_b, nlsb, mfob, id_b,
                               kv, s, kv2, s2, nazn, userid
                              )
                       VALUES (ref_, tt_, vob_, ref_, 1, SYSDATE, dat_,
                               dat2_, dat2_, nam_a_, k.s_fond, gl.amfo,
                               okpoa_, nam_b_, r7702_, gl.amfo, okpoa_,
                               k.kv, s_old_, 980, s_old_q, nazn_, otvisp_
                              );

                  paytt (0,
                         ref_,
                         dat_,
                         tt_,
                         1,
                         k.kv,
                         k.s_fond,
                         s_old_,
                         980,
                         r7702_,
                         s_old_q
                        );
               ELSIF mode_ = 1
               THEN
dummy := 4;
                  INSERT INTO rez_doc_maket
                              (tt, vob, pdat, vdat, datd, datp,
                               nam_a, nlsa, mfoa, id_a, nam_b,
                               nlsb, mfob, id_b, kv, s, kv2,
                               s2, nazn, userid
                              )
                       VALUES (tt_, vob_, SYSDATE, dat_, dat2_, dat2_,
                               nam_a_, k.s_fond, gl.amfo, okpoa_, nam_b_,
                               r7702_, gl.amfo, okpoa_, k.kv, s_old_q, 980,
                               s_old_, nazn_, otvisp_
                              );


               END IF;
dummy := 5;
            END IF;
         ELSE                          -- для гривни доформировываем на дельту
            -- сумма нового резерва
            IF k.rz = 1
            THEN                                   -- для резидентов или всех
               IF k.s_fondnr IS NULL
               THEN                                                    -- все
                  SELECT NVL (SUM (NVL (sz1, sz)), 0)
                    INTO s_new_
                    FROM tmp_rez_risk r
                   WHERE r.s080 = k.s080
                     AND r.custtype = k.custtype
                     AND r.kv = k.kv
                     AND r.dat = dat_
                     AND ID = id_
                     AND r.idr = k.ID
                     and id_specrez(r.wdate, r.istval,k.kv, r.idr,r.custtype) = k.specrez --T 13.01.2009
                     ;
               ELSIF     k.s_fondnr IS NOT NULL
                     AND NVL (k.s_fondnr, 'x') <> k.s_fond
               THEN                                        -- только резиденты
                  SELECT NVL (SUM (NVL (sz1, sz)), 0)
                    INTO s_new_
                    FROM tmp_rez_risk r
                   WHERE r.s080 = k.s080
                     AND r.custtype = k.custtype
                     AND r.kv = k.kv
                     AND r.dat = dat_
                     AND ID = id_
                     AND r.idr = k.ID
                     AND r.rz = 1
                     and id_specrez(r.wdate, r.istval,k.kv, r.idr,r.custtype) = k.specrez --T 13.01.2009
                     ;
               END IF;
            ELSIF k.rz = 2
            THEN                                           -- для нерезидентов
               SELECT NVL (SUM (NVL (sz1, sz)), 0)
                 INTO s_new_
                 FROM tmp_rez_risk r
                WHERE r.s080 = k.s080
                  AND r.custtype = k.custtype
                  AND r.kv = k.kv
                  AND r.dat = dat_
                  AND ID = id_
                  AND r.idr = k.ID
                  AND r.rz = 2
                  and id_specrez(r.wdate, r.istval,k.kv, r.idr,r.custtype) = k.specrez --T 13.01.2009
                  ;
            END IF;
dummy := 6;
            IF s_old_ <> s_new_
            THEN
               IF s_old_ < s_new_
               THEN                                         -- доформирование
                  nazn_ :=
                        'Доформування резерву зг_дно розрахунка станом на '
                     || TO_CHAR (LAST_DAY (dat_) + 1, 'dd/mm/yyyy');
dummy := 7;
                  IF mode_ = 0
                  THEN
                     INSERT INTO oper
                                 (REF, tt, vob, nd, dk, pdat, vdat,
                                  datd, datp, nam_a, nlsa, mfoa,
                                  id_a, nam_b, nlsb, mfob, id_b,
                                  kv, s, kv2,
                                  s2, nazn, userid
                                 )
                          VALUES (ref_, tt_, vob_, ref_, 0, SYSDATE, dat_,
                                  dat2_, dat2_, nam_a_, k.s_fond, gl.amfo,
                                  okpoa_, nam_b_, f7702_, gl.amfo, okpoa_,
                                  k.kv, -s_old_ + s_new_, 980,
                                  -s_old_ + s_new_, nazn_, otvisp_
                                 );

                     paytt (0,
                            ref_,
                            dat_,
                            tt_,
                            0,
                            k.kv,
                            k.s_fond,
                            -s_old_ + s_new_,
                            980,
                            f7702_,
                            -s_old_ + s_new_
                           );
                  ELSIF mode_ = 1
                  THEN
dummy := 8;
--raise_application_error(-20001, k.s_fond||'  '||s_old_||'   '||s_new_);
                     INSERT INTO rez_doc_maket
                                 (tt, vob, pdat, vdat, datd, datp,
                                  nam_a, nlsa, mfoa, id_a, nam_b,
                                  nlsb, mfob, id_b, kv,
                                  s, kv2, s2,
                                  nazn, userid
                                 )
                          VALUES (tt_, vob_, SYSDATE, dat_, dat2_, dat2_,
                                  nam_a_, k.s_fond, gl.amfo, okpoa_, nam_b_,
                                  r7702_, gl.amfo, okpoa_, 980,
                                  -s_old_ + s_new_,
                                                   --s_new_,
                                  980, -s_old_ + s_new_,
                                  --s_new_,
                                  nazn_, otvisp_
                                 );

                  END IF;
               ELSIF s_old_ > s_new_
               THEN                                         -- расформирование
                  nazn_ :=
                        'Зменшення резерву зг_дно розрахунка станом на '
                     || TO_CHAR (LAST_DAY (dat_) + 1, 'dd/mm/yyyy');
dummy := 9;
                  IF mode_ = 0
                  THEN
                     INSERT INTO oper
                                 (REF, tt, vob, nd, dk, pdat, vdat,
                                  datd, datp, nam_a, nlsa, mfoa,
                                  id_a, nam_b, nlsb, mfob, id_b,
                                  kv, s, kv2,
                                  s2, nazn, userid
                                 )
                          VALUES (ref_, tt_, vob_, ref_, 1, SYSDATE, dat_,
                                  dat2_, dat2_, nam_a_, k.s_fond, gl.amfo,
                                  okpoa_, nam_b_, r7702_, gl.amfo, okpoa_,
                                  980, s_old_ - s_new_, 980,
                                  s_old_ - s_new_, nazn_, otvisp_
                                 );

                     paytt (0,
                            ref_,
                            dat_,
                            tt_,
                            1,
                            k.kv,
                            k.s_fond,
                            s_old_ - s_new_,
                            980,
                            r7702_,
                            s_old_ - s_new_
                           );
                  ELSIF mode_ = 1
                  THEN
dummy := 10;
                     INSERT INTO rez_doc_maket
                                 (tt, vob, pdat, vdat, datd, datp,
                                  nam_a, nlsa, mfoa, id_a, nam_b,
                                  nlsb, mfob, id_b, kv,
                                  s, kv2, s2,
                                  nazn, userid
                                 )
                          VALUES (tt_, vob_, SYSDATE, dat_, dat2_, dat2_,
                                  nam_a_, k.s_fond, gl.amfo, okpoa_, nam_b_,
                                  r7702_, gl.amfo, okpoa_, 980,
                                  s_old_ - s_new_, 980, s_old_ - s_new_,
                                  nazn_, otvisp_
                                 );

                  END IF;
               END IF;
            END IF;
         END IF;
dummy := 11;
      END LOOP;

      -- курсор: по всем видам клиентов, резидентности, категориям риска и валютам
      FOR k IN (SELECT s.custtype, s.s080, r.NAME, t.kv, s.s_fond, s_fondnr,
                       s.s_form, s.s_formv, s.s_rasf, s.s_rasfv, s.ID, 1 rz,
                       s.otvisp, s.otvispval
                       ,s.specrez --T 13.01.2009
                  FROM srezerv s,
                       tabval t,
                       (SELECT crisk, NAME, rez
                          FROM crisk) r
                 WHERE r.crisk = s.s080
                   AND s.s_fond IS NOT NULL
                   AND s.s_form IS NOT NULL
                   AND s.s_formv IS NOT NULL
                   AND s.s_rasf IS NOT NULL
                   AND s.s_rasfv IS NOT NULL
               --    and t.kv = '980'
                UNION
                SELECT s.custtype, s.s080, r.NAME, t.kv,
                       NVL (s.s_fondnr, s.s_fond), '', s.s_form, s.s_formv,
                       s.s_rasf, s.s_rasfv, s.ID, 2 rz, s.otvisp, s.otvisp
                       ,s.specrez --T 13.01.2009
                  FROM srezerv s,
                       tabval t,
                       (SELECT crisk, NAME, rez
                          FROM crisk
                        where crisk <> '9' --T 21.01.2009
                        UNION ALL
                         SELECT '9', 'Просроч.%', 100
                           FROM DUAL
                        ) r
                 WHERE r.crisk = s.s080
                   AND s.s_fond IS NOT NULL
                   AND s.s_form IS NOT NULL
                   AND s.s_formv IS NOT NULL
                   AND s.s_rasf IS NOT NULL
                   AND s.s_rasfv IS NOT NULL
                   AND s.s_fondnr IS NOT NULL
                 --  and t.kv = '980'
                   )
      LOOP
dummy := 12;
s :=   k.s_fond;
         IF k.kv = '980'
         THEN
            otvisp_ := NVL (k.otvisp, userid_);
         ELSE
            otvisp_ := NVL (k.otvispval, userid_);
         END IF;

         IF k.kv <> '980'
         THEN
            -- код отв.исполнителя
            BEGIN
               SELECT isp
                 INTO id2_
                 FROM accounts
                WHERE nls = k.s_fond AND kv = k.kv;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  id2_ := NULL;
            END;

            IF k.s080 = '1' OR k.s080 = '9'
            THEN
               tt_ := 'ARE';                                --для стандартных
            ELSE
               tt_ := 'AR*';                              --для НЕстандартных
            END IF;

            -- Работаем с ИН.вал или НАЦ.вал
            IF k.kv = 980
            THEN
               f7702_ := k.s_form;
               r7702_ := k.s_rasf;

               -- Определяем необходимый вид VOB
               IF TO_CHAR (dat2_, 'YYYYMM') > TO_CHAR (dat_, 'YYYYMM')
               THEN
                  vob_ := 96;
               ELSE
                  vob_ := 6;
               END IF;
            ELSE
               f7702_ := k.s_formv;
               r7702_ := k.s_rasfv;

               -- Определяем необходимый вид VOB
               IF TO_CHAR (dat2_, 'YYYYMM') > TO_CHAR (dat_, 'YYYYMM')
               THEN
                  vob_ := 96;
               ELSE
                  vob_ := 16;
               END IF;
            END IF;

            ----    формирование резерва
            s_new_ := 0;
dummy := 13;
            -- узнать новые суммы резерва
            IF k.rz = 1
            THEN                                    -- для резидентов или всех
               IF k.s_fondnr IS NULL
               THEN                                                    -- все
                  SELECT NVL (SUM (NVL (sz1, sz)), 0)
                    INTO s_new_
                    FROM tmp_rez_risk r
                   WHERE r.s080 = k.s080
                     AND r.custtype = k.custtype
                     AND r.kv = k.kv
                     AND r.dat = dat_
                     AND ID = id_
                     AND r.idr = k.ID
                     and id_specrez(r.wdate, r.istval,k.kv, r.idr,r.custtype) = k.specrez --T 13.01.2009
                     ;
               ELSIF     k.s_fondnr IS NOT NULL
                     AND NVL (k.s_fondnr, 'x') <> k.s_fond
               THEN                                        -- только резиденты
                  SELECT NVL (SUM (NVL (sz1, sz)), 0)
                    INTO s_new_
                    FROM tmp_rez_risk r
                   WHERE r.s080 = k.s080
                     AND r.custtype = k.custtype
                     AND r.kv = k.kv
                     AND r.dat = dat_
                     AND ID = id_
                     AND r.idr = k.ID
                     AND r.rz = 1
                     and id_specrez(r.wdate, r.istval,k.kv, r.idr,r.custtype) = k.specrez --T 13.01.2009
                     ;
               END IF;
            ELSIF k.rz = 2
            THEN                                           -- для нерезидентов
               SELECT NVL (SUM (NVL (sz1, sz)), 0)
                 INTO s_new_
                 FROM tmp_rez_risk r
                WHERE r.s080 = k.s080
                  AND r.custtype = k.custtype
                  AND r.kv = k.kv
                  AND r.dat = dat_
                  AND ID = id_
                  AND r.idr = k.ID
                  AND r.rz = 2
                  and id_specrez(r.wdate, r.istval,k.kv, r.idr,r.custtype) = k.specrez --T 13.01.2009
                  ;
            END IF;

dummy := 14;
            IF s_new_ > 0
            THEN
               -- текущий экв. новой суммы резерва
               s_new_q := gl.p_icurval (k.kv, s_new_, dat_);

               -- открыть счета резервирования, если их нет
               IF mode_ = 0
               THEN
                  BEGIN
                     SELECT acc
                       INTO acc_
                       FROM accounts
                      WHERE nls = k.s_fond AND kv = k.kv;
                  EXCEPTION
                     WHEN NO_DATA_FOUND
                     THEN
                        BEGIN
                           BEGIN
                              SELECT val
                                INTO rnk_
                                FROM params
                               WHERE par = 'OUR_RNK';
                           EXCEPTION
                              WHEN NO_DATA_FOUND
                              THEN
                                 rnk_ := 1;
                           END;

                           nam_a_ :=
                              SUBSTR (   'Рез.фонд по '
                                      || iif_s (k.custtype,
                                                2,
                                                'Банкам',
                                                'Юр.ос.',
                                                'Фiз.ос.'
                                               )
                                      || '. Кат.'
                                      || k.NAME,
                                      1,
                                      38
                                     );
                           op_reg (99,
                                   0,
                                   0,
                                   0,
                                   ret1_,
                                   rnk_,
                                   k.s_fond,
                                   k.kv,
                                   nam_a_,
                                   'ODB',
                                   id_,
                                   acc_
                                  );
                        END;
                  END;
               END IF;
dummy := 15;
               -- узнать название нужных счетов для вставки в OPER
               BEGIN
                  SELECT SUBSTR (a.nms, 1, 38), SUBSTR (b.nms, 1, 38)
                    INTO nam_a_, nam_b_
                    FROM accounts a, accounts b
                   WHERE a.kv = k.kv
                     AND a.nls = k.s_fond
                     AND b.kv = 980
                     AND b.nls = f7702_;
               EXCEPTION
                  WHEN NO_DATA_FOUND
                  THEN
                     nam_a_ := 'Сч.Фонда';
                     nam_b_ := 'Сч.формирования Фонда';
               END;

               -- проводка по формированию резерва
               IF mode_ = 0
               THEN
                  gl.REF (ref_);
               END IF;

               IF k.kv <> 980
               THEN
                  SELECT ' по курсу ' || TO_CHAR (cur.rate_o, '99999.0000')
                    INTO kurs_
                    FROM cur_rates cur
                   WHERE cur.kv = k.kv
                     AND vdate = (SELECT MAX (vdate)
                                    FROM cur_rates
                                   WHERE kv = k.kv AND vdate <= dat_);
               ELSE
                  kurs_ := '';
               END IF;

               IF vob_ <> 96
               THEN
                  nazn_ :=
                     SUBSTR (   'Формування резерву станом на '
                             || TO_CHAR (LAST_DAY (dat_) + 1, 'dd/mm/yyyy')
                             || kurs_
                             || ' ('
                             || k.NAME
                             || ')',
                             1,
                             160
                            );
               ELSE
                  nazn_ :=
                     SUBSTR
                        (   'Коригуюча проводка по формуванню резерву станом на '
                         || TO_CHAR (LAST_DAY (dat_) + 1, 'dd/mm/yyyy')
                         || kurs_
                         || ' ('
                         || k.NAME
                         || ')',
                         1,
                         160
                        );
               END IF;
dummy := 16;
               IF mode_ = 0
               THEN
                  INSERT INTO oper
                              (REF, tt, vob, nd, dk, pdat, vdat,
                               datd, datp, nam_a, nlsa, mfoa,
                               id_a, nam_b, nlsb, mfob, id_b,
                               kv, s, kv2, s2, nazn, userid
                              )
                       VALUES (ref_, tt_, vob_, ref_, 0, SYSDATE, dat_,
                               dat2_, dat2_, nam_a_, k.s_fond, gl.amfo,
                               okpoa_, nam_b_, f7702_, gl.amfo, okpoa_,
                               k.kv, s_new_, 980, s_new_q, nazn_, otvisp_
                              );

                  paytt (0,
                         ref_,
                         dat_,
                         tt_,
                         0,
                         k.kv,
                         k.s_fond,
                         s_new_,
                         980,
                         f7702_,
                         s_new_q
                        );
               ELSIF mode_ = 1
               THEN
dummy := 17;
                  INSERT INTO rez_doc_maket
                              (tt, vob, pdat, vdat, datd, datp,
                               nam_a, nlsa, mfoa, id_a, nam_b,
                               nlsb, mfob, id_b, kv, s,
                               kv2, s2, nazn, userid
                              )
                       VALUES (tt_, vob_, SYSDATE, dat_, dat2_, dat2_,
                               nam_b_, r7702_, gl.amfo, okpoa_, nam_a_,
                               k.s_fond, gl.amfo, okpoa_, 980, s_new_q,
                               k.kv, s_new_, nazn_, otvisp_
                              );

               END IF;
            END IF;
         END IF;
dummy := 18;
      END LOOP;

dummy := 19;
      IF mode_ = 0
      THEN
         UPDATE rez_protocol
            SET userid = id_
          WHERE dat = dat_;

         IF SQL%ROWCOUNT = 0
         THEN
            INSERT INTO rez_protocol
                        (userid, dat
                        )
                 VALUES (id_, dat_
                        );
         END IF;
      END IF;
dummy := 20;
      COMMIT;

     -- raise_application_error(-20001, 'dummy= '||dummy);

   exception when others then
         rollback;
         erm := '';
         if instr(sqlerrm, 'REZ') = 0 then
           --стек ошибок - если позволяет версия оракла
           begin
             execute immediate 'select substr(substr(dbms_utility.format_error_backtrace,instr(dbms_utility.format_error_backtrace,'':'')+1),1,900) from dual' into erm;
           exception when others then
              null;
           end;
           erm := substr(substr(sqlerrm,instr(sqlerrm,':')+1),1,99)||': '||erm;
           insert into cp_rez_log (USERID,ID,ROWNUMBER,TXT, VAL, DT)
           values (user_id, null, 1, erm, 'ca_pay_rez2', sysdate);
           commit;
           bars_error.raise_error('REZ',5);
         else
           raise;
         end if;
   END ca_pay_rez2;

--------------------------------------
   PROCEDURE delta (id_ INT, dat1_ DATE, dat2_ DATE)
   IS
      sk_1     NUMBER;
      skq_1    NUMBER;
      soq_1    NUMBER;
      srq_1    NUMBER;
      szq_1    NUMBER;
      sz_1     NUMBER;
      sz1_1    NUMBER;
      sk_2     NUMBER;
      skq_2    NUMBER;
      soq_2    NUMBER;
      srq_2    NUMBER;
      szq_2    NUMBER;
      sz_2     NUMBER;
      sz1_2    NUMBER;
      fl_col   NUMBER;
   BEGIN
      DELETE FROM tmp_rez_risks
            WHERE dat = dat1_ AND dat_ = dat2_;

      COMMIT;

      FOR k IN (SELECT DISTINCT ID, s080, s080_name, custtype, rnk, nmk, kv,
                                nls, cc_id, fin, obs, idr, rs080
                           FROM tmp_rez_risk
                          WHERE ID = id_ AND (dat = dat1_ OR dat = dat2_)
                       ORDER BY kv, nls)
      LOOP
         BEGIN
            SELECT sk, skq, soq, srq, szq, sz, sz1
              INTO sk_1, skq_1, soq_1, srq_1, szq_1, sz_1, sz1_1
              FROM tmp_rez_risk
             WHERE dat = dat1_ AND nls = k.nls AND kv = k.kv AND ID = id_;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               sk_1 := 0;
               skq_1 := 0;
               soq_1 := 0;
               srq_1 := 0;
               szq_1 := 0;
               sz_1 := 0;
               sz1_1 := 0;
         END;

         BEGIN
            SELECT sk, skq, soq, srq, szq, sz, sz1
              INTO sk_2, skq_2, soq_2, srq_2, szq_2, sz_2, sz1_2
              FROM tmp_rez_risk
             WHERE dat = dat2_ AND nls = k.nls AND kv = k.kv AND ID = id_;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               sk_2 := 0;
               skq_2 := 0;
               soq_2 := 0;
               srq_2 := 0;
               szq_2 := 0;
               sz_2 := 0;
               sz1_2 := 0;
         END;

         fl_col := 0;

         -- открытый (новый)
         IF sk_1 = 0 AND sk_2 <> 0
         THEN
            fl_col := 1;
         END IF;

         -- закрытый
         IF sk_2 = 0 AND sk_1 <> 0
         THEN
            fl_col := 2;
         END IF;

         INSERT INTO tmp_rez_risks
                     (dat, dat_, ID, s080, s080_name, custtype,
                      rnk, nmk, kv, nls, sk, sk_, skq, skq_,
                      soq, soq_, srq, srq_, cc_id, szq, szq_,
                      sz, sz_, sz1, sz1_, fin, obs, idr, rs080,
                      fl
                     )
              VALUES (dat1_, dat2_, id_, k.s080, k.s080_name, k.custtype,
                      k.rnk, k.nmk, k.kv, k.nls, sk_1, sk_2, skq_1, skq_2,
                      soq_1, soq_2, srq_1, srq_2, k.cc_id, szq_1, szq_2,
                      sz_1, sz_2, sz1_1, sz1_2, k.fin, k.obs, k.idr, k.rs080,
                      fl_col
                     );
      END LOOP;

      COMMIT;
   END delta;

--------------------------------------
-- Процедура накопления данных во временной таблице TMP_CRTX
-- накапливаются данніе о корректирующих оборотах
-- в текущей версии расчета резерва не используется
   PROCEDURE fill_crtx (p_restdate IN DATE)
   IS
      PRAGMA AUTONOMOUS_TRANSACTION;
   BEGIN
      -- Проверяем заполнена ли уже таблица на
      -- эту дату
      IF (g_restdate IS NOT NULL)
      THEN
         RETURN;
      END IF;

      -- Заполняем таблицу
      EXECUTE IMMEDIATE 'truncate table tmp_crtx';

      INSERT INTO tmp_crtx
                  (REF, dk, acc, s, fdat, vdat, vob)
         SELECT /*+INDEX(o) */
                o.REF, o.dk, o.acc, o.s, o.fdat, p.vdat, p.vob
           FROM opldok o, oper p
          WHERE o.REF = p.REF AND o.sos = 5 AND p.vob = 96;

      COMMIT;
      g_restdate := TRUNC (p_restdate);
   END fill_crtx;

------------------------------------------------------------------
-- Функция возвращает остаток на счете с учетом корректирующих
-- проводок. Для поиска суммы корректирующих проводок исполь-
-- зуется временная таблица TMP_CRTX
-- в текущей версии расчета резерва не используется
   FUNCTION get_restc (
      p_acccode    IN   accounts.acc%TYPE,
      p_restdate   IN   saldoa.fdat%TYPE
   )
      RETURN saldoa.ostf%TYPE
   IS
      l_rest   saldoa.ostf%TYPE   := 0;
   BEGIN
      -- Заполняем таблицу
      fill_crtx (SYSDATE);

      BEGIN
         -- Получаем фактический остаток на счету
         SELECT ostf - dos + kos
           INTO l_rest
           FROM saldoa
          WHERE acc = p_acccode
            AND fdat = (SELECT MAX (fdat)
                          FROM saldoa
                         WHERE acc = p_acccode AND fdat <= p_restdate);

         -- Корректируем остаток корректирующими проводками
         SELECT l_rest + NVL (SUM (DECODE (t.dk, 1, t.s, -t.s)), 0)
           INTO l_rest
           FROM tmp_crtx t
          WHERE t.acc = p_acccode
            AND t.fdat > p_restdate
            AND t.vdat <= p_restdate;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            RETURN l_rest;
      END;

      RETURN l_rest;
   END get_restc;

-- процедура установки дат для отчетов
   PROCEDURE set_date (dat1_ DATE, dat2_ DATE)
   IS
   BEGIN
      curdate_ := dat1_;
      prevdate_ := dat2_;
   END set_date;

-- текущая отчетная дата
   FUNCTION curdate
      RETURN DATE
   IS
   BEGIN
      RETURN curdate_;
   END curdate;

-- предыдущая отчетная дата
   FUNCTION prevdate
      RETURN DATE
   IS
   BEGIN
      RETURN prevdate_;
   END prevdate;

   PROCEDURE p_check_file11 (dat_ DATE)
   IS
      disk1_   NUMBER;
      disk2_   NUMBER;
   BEGIN
      rownumber_ := 0;
      uselog_ := 1;
      p_f11_nn (dat_);

      DELETE FROM cp_rez_log c
            WHERE c.userid = userid_;

      to_log (0, 'Сверка кредитных рисков #11 и расчета резерва ', '');
      to_log (0, '', '');

       -- счета которые есть в 11 файле но отсутствуют в расчете резерва
      -- только активы
      FOR k IN (SELECT *
                  FROM rnbu_trace r
                 WHERE SUBSTR (r.kodp, 1, 1) = '1'
                   AND NOT EXISTS (
                          SELECT *
                            FROM tmp_rez_risk t
                           WHERE ID = userid
                             AND dat = dat_
                             AND t.nls = r.nls
                             AND t.kv = r.kv))
      LOOP
         to_log (0,
                 k.nls || '(' || k.kv || ') kodp=' || k.kodp || ' znap='
                 || k.znap,
                 'отсутствует в расчете резерва'
                );
      END LOOP;

      -- счета которые есть в 11 файле но отсутствуют в расчете резерва
      FOR k IN (SELECT r.nls, r.kv, r.kodp, r.znap, t.s080, t.skq
                  FROM rnbu_trace r, tmp_rez_risk t
                 WHERE ID = userid
                   AND dat = dat_
                   AND t.nls = r.nls
                   AND t.kv = r.kv)
      LOOP
         IF TO_NUMBER (k.znap) <> k.skq
         THEN
            to_log (0,
                       k.nls
                    || '('
                    || k.kv
                    || ') #11='
                    || k.znap
                    || ' рез='
                    || TO_CHAR (k.skq),
                    'не совпадает остаток на отчетную дату'
                   );
         END IF;

         IF SUBSTR (k.kodp, 6, 1) <> k.s080
         THEN
            to_log (0,
                       k.nls
                    || '('
                    || k.kv
                    || ') #11='
                    || SUBSTR (k.kodp, 6, 1)
                    || ' рез='
                    || k.s080,
                    'не совпадает категория риска'
                   );
         END IF;
      END LOOP;

      -- сверка дисконтов в #11 и расчете резерва

      -- общая сумма дисконта
      SELECT NVL (SUM (znap), 0)
        INTO disk1_
        FROM rnbu_trace
       WHERE SUBSTR (kodp, 1, 1) = '2';

      SELECT NVL (SUM (discont), 0)
        INTO disk2_
        FROM tmp_rez_risk
       WHERE ID = userid_ AND dat = dat_;

      to_log (0, '', '');
      to_log (0, 'Сверка дисконта #11 и расчета резерва ', '');
      to_log (0, '', '');
      --IF disk1_ <> disk2_
      --THEN
      to_log (0,
                 '#11='
              || TO_CHAR (disk1_)
              || ' рез='
              || TO_CHAR (disk2_)
              || ' расхождение='
              || TO_CHAR (disk1_ - disk2_),
              'расхождение суммы общего дисконта #11 и расчета резерва'
             );
      --END IF;
      to_log (0, '', '');

      FOR k IN (SELECT DISTINCT a.nls, a.kv
                           FROM accounts a, tmp_rez_risk3 t
                          WHERE a.acc = t.accd
                            AND t.sd <> 0
                            AND t.userid = userid_
                            AND t.dat = dat_
                            AND NOT EXISTS (
                                           SELECT *
                                             FROM rnbu_trace r
                                            WHERE r.nls = a.nls
                                                  AND r.kv = a.kv))
      LOOP
         to_log (0, k.nls || '(' || k.kv || ')', 'счет отсутствует в #11');
      END LOOP;

      FOR k IN (WITH d AS
                     (SELECT   t.accd, SUM (t.sd) sd
                          FROM tmp_rez_risk3 t
                         WHERE t.userid = userid_ AND t.dat = dat_
                      GROUP BY t.accd)
                SELECT r.nls, r.kv, r.znap, NVL (d.sd, 0) sd
                  FROM d, rnbu_trace r, accounts a
                 WHERE d.accd(+) = a.acc
                   AND r.nls = a.nls
                   AND r.kv = a.kv
                   AND SUBSTR (r.kodp, 1, 1) = '2')
      LOOP
         IF k.sd <> k.znap
         THEN
            to_log (0,
                       k.nls
                    || '('
                    || k.kv
                    || ') #11='
                    || k.znap
                    || ' рез='
                    || TO_CHAR (k.sd),
                    'не совпадает отстаток дисконта в #11 и расчете резерва'
                   );
         END IF;
      END LOOP;

      FOR d IN (SELECT t.accd, t.accs, ad.nls nlsd, ad.kv kvd,
                       NVL (sd.s080, '?') s080d, ass.nls nlss, ass.kv kvs,
                       NVL (ss.s080, '?') s080s
                  FROM tmp_rez_risk3 t,
                       specparam sd,
                       specparam ss,
                       accounts ass,
                       accounts ad
                 WHERE ass.acc = ss.acc(+)
                   AND t.accs = ass.acc
                   AND ad.acc = sd.acc(+)
                   AND t.accd = ad.acc
                   AND t.userid = userid_
                   AND t.dat = dat_)
      LOOP
         IF d.s080d <> d.s080s OR d.s080d = '?' OR d.s080s = '?'
         THEN
            to_log (0,
                       d.nlsd
                    || '('
                    || d.kvd
                    || ')(s080='
                    || d.s080d
                    || ')='
                    || ' '
                    || d.nlss
                    || '('
                    || d.kvs
                    || ')(s080='
                    || d.s080s
                    || ')',
                    'Несвопадает категория риска актива и дисконта'
                   );
         --if d.s080s <> '?' then
         --  update specparam set s080 = d.s080s where acc=d.accd;
         --end if;
         END IF;
      END LOOP;

      uselog_ := 0;
   END;

   PROCEDURE p_check_file30 (dat_ DATE)
   IS
      zal1_        NUMBER;
      zal2_        NUMBER;
      zalall30_    NUMBER := 0;
      zalallrez_   NUMBER := 0;
   BEGIN
      rownumber_ := 0;
      p_f30 (dat_);
      uselog_ := 1;

      DELETE FROM cp_rez_log c
            WHERE c.userid = userid_;

      to_log (0, 'Сверка показателей обеспечения #30 и расчета резерва ', '');
      to_log (0, '', '');

      FOR k IN (SELECT *
                  FROM rnbu_trace
                 WHERE (kodp LIKE '12%' OR kodp LIKE '13%')
                   AND kodp NOT LIKE ('128%'))
      LOOP
         zalall30_ := zalall30_ + TO_NUMBER (k.znap);

         SELECT NVL (SUM (t1.spriv), 0)
           INTO zal1_
           FROM tmp_rez_risk2 t1, accounts a
          WHERE t1.userid = userid_
            AND t1.dat = dat_
            AND t1.accs = k.acc
            AND t1.accz = a.acc
            AND a.nls = k.nls
            AND k.kv = a.kv;

         IF TO_CHAR (k.znap) <> zal1_
         THEN
            to_log (0,
                       k.nls
                    || '('
                    || k.kv
                    || ') #30 kodp='
                    || k.kodp
                    || ' znap='
                    || TO_CHAR (k.znap)
                    || ' рез='
                    || TO_CHAR (zal1_),
                    'не совпадает сумма обеспечения в #30 и расчете резерва'
                   );
         END IF;
      END LOOP;

      FOR k IN (SELECT *
                  FROM tmp_rez_risk t1
                 WHERE t1.ID = userid_ AND t1.dat = dat_)
      LOOP
         zal1_ := LEAST (k.soq, k.skq2);

         SELECT NVL (SUM (TO_NUMBER (znap)), 0)
           INTO zal2_
           FROM rnbu_trace
          WHERE k.acc = acc;

         IF zal1_ <> zal2_
         THEN
            to_log (0,
                       k.nls
                    || '('
                    || k.kv
                    || ') #30='
                    || TO_CHAR (zal2_)
                    || ' рез='
                    || TO_CHAR (zal1_),
                    'не совпадает сумма обеспечения в #30 и расчете резерва'
                   );
         END IF;
      END LOOP;

      SELECT NVL (SUM (t1.spriv), 0)
        INTO zalallrez_
        FROM tmp_rez_risk2 t1
       WHERE t1.userid = userid_ AND t1.dat = dat_;

      --IF zalallrez_ <> zalall30_
      --THEN
      to_log
         (0,
          '#30=' || TO_CHAR (zalall30_) || ' рез=' || TO_CHAR (zalallrez_),
          'не совпадает общая сумма приведенного обеспечения в #30 и расчете резерва'
         );
      --END IF;
      uselog_ := 0;
   END;

   PROCEDURE p_check_file30_11 (dat_ DATE)
   IS
      sr11_    NUMBER;
      sd11_    NUMBER;
      so30_    NUMBER;
      sn30_    NUMBER;
      szq_     NUMBER;
      szq2_    NUMBER;
      proc_    NUMBER;
      proc2_   NUMBER;
   BEGIN
      rownumber_ := 0;
      p_f30 (dat_);
      p_f11_nn (dat_);
      uselog_ := 1;

      DELETE FROM cp_rez_log c
            WHERE c.userid = userid_;

      to_log (0,
              'Перекрестная сверка #11 и #30 в разрезе отдельного счета',
              ''
             );
      to_log (0, '', '');

      FOR k IN (SELECT r.kodp, r.znap, a.acc, a.nls, a.kv
                  FROM rnbu_trace r, accounts a
                 WHERE SUBSTR (kodp, 1, 1) = '1'
                   AND r.nls = a.nls
                   AND r.kv = a.kv)
      LOOP
         sr11_ := TO_NUMBER (k.znap);

         BEGIN
            SELECT NVL (SUM (TO_NUMBER (znap)), 0)
              INTO sd11_
              FROM rnbu_trace
             WHERE kv = k.kv
               AND SUBSTR (nls, 6) = SUBSTR (k.nls, 6)
               AND kodp LIKE '2%';
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               sd11_ := 0;
         END;

         BEGIN
            SELECT NVL (SUM (TO_NUMBER (znap)), 0)
              INTO so30_
              FROM otcn_history
             WHERE kodf = '30'
               AND datf = dat_
               AND acc = k.acc
               AND SUBSTR (kodp, 1, 2) IN ('12', '13')
               AND SUBSTR (kodp, 1, 3) <> '128';
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               so30_ := 0;
         END;

         BEGIN
            SELECT NVL (SUM (TO_NUMBER (znap)), 0)
              INTO sn30_
              FROM otcn_history
             WHERE kodf = '30'
               AND datf = dat_
               AND nls = k.nls
               AND kv = k.kv
               AND SUBSTR (kodp, 1, 3) = '128';
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               sn30_ := 0;
         END;

         BEGIN
            SELECT t.szq, t.pr_rez
              INTO szq_, proc2_
              FROM tmp_rez_risk t
             WHERE t.ID = userid_ AND t.dat = dat_ AND acc = k.acc;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               szq_ := 0;
         END;

         IF SUBSTR (k.kodp, 6, 1) = '1' AND k.kv = '980'
         THEN
            proc_ := 1;
         ELSIF SUBSTR (k.kodp, 6, 1) = '1' AND k.kv <> '980'
         THEN
            proc_ := 2;
         ELSIF SUBSTR (k.kodp, 6, 1) = '2' AND k.kv = '980'
         THEN
            proc_ := 5;
         ELSIF SUBSTR (k.kodp, 6, 1) = '2' AND k.kv <> '980'
         THEN
            proc_ := 7;
         ELSIF SUBSTR (k.kodp, 6, 1) = '3' AND k.kv = '980'
         THEN
            proc_ := 20;
         ELSIF SUBSTR (k.kodp, 6, 1) = '3' AND k.kv <> '980'
         THEN
            proc_ := 25;
         ELSIF SUBSTR (k.kodp, 6, 1) = '4' AND k.kv = '980'
         THEN
            proc_ := 50;
         ELSIF SUBSTR (k.kodp, 6, 1) = '4' AND k.kv <> '980'
         THEN
            proc_ := 60;
         ELSIF SUBSTR (k.kodp, 6, 1) = '5' AND k.kv = '980'
         THEN
            proc_ := 100;
         ELSIF SUBSTR (k.kodp, 6, 1) = '5' AND k.kv <> '980'
         THEN
            proc_ := 100;
         ELSE
            proc_ := 0;
         END IF;

         szq2_ :=
              ROUND (GREATEST (sr11_ - sd11_ - so30_ - sn30_, 0) * proc_ / 100);

         IF szq2_ <> szq_
         THEN
            to_log (0,
                       k.nls
                    || '('
                    || k.kv
                    || ')'
                    || ' по файлам='
                    || TO_CHAR (szq2_)
                    || ' по расчету='
                    || TO_CHAR (szq_),
                    'Не совпадает резерв по файлам и расчету'
                   );
            to_log (0, 'Р11=' || TO_CHAR (sr11_), '');
            to_log (0, 'Д11=' || TO_CHAR (sd11_), '');
            to_log (0, 'О30=' || TO_CHAR (so30_), '');
            to_log (0, 'Н30=' || TO_CHAR (sn30_), '');
            to_log (0, '% расч=' || TO_CHAR (proc_), '');
            to_log (0, '% рез =' || TO_CHAR (proc2_), '');
         END IF;
      END LOOP;

      to_log (0, '', '');
      to_log
           (0,
            'Перекрестная сверка #11 и #30 в разрезе категории риска, валюты',
            ''
           );
      to_log (0, '', '');

      FOR k IN (SELECT DISTINCT SUBSTR (kodp, 6, 1) s080,
                                SUBSTR (kodp, 9, 3) kv
                           FROM tmp_nbu
                          WHERE kodf = '11' AND datf = dat_ AND kodp LIKE '1%'
                       ORDER BY SUBSTR (kodp, 9, 3), SUBSTR (kodp, 6, 1))
      LOOP
         IF k.s080 = '1' AND k.kv = '980'
         THEN
            proc_ := 1;
         ELSIF k.s080 = '1' AND k.kv <> '980'
         THEN
            proc_ := 2;
         ELSIF k.s080 = '2' AND k.kv = '980'
         THEN
            proc_ := 5;
         ELSIF k.s080 = '2' AND k.kv <> '980'
         THEN
            proc_ := 7;
         ELSIF k.s080 = '3' AND k.kv = '980'
         THEN
            proc_ := 20;
         ELSIF k.s080 = '3' AND k.kv <> '980'
         THEN
            proc_ := 25;
         ELSIF k.s080 = '4' AND k.kv = '980'
         THEN
            proc_ := 50;
         ELSIF k.s080 = '4' AND k.kv <> '980'
         THEN
            proc_ := 60;
         ELSIF k.s080 = '5' AND k.kv = '980'
         THEN
            proc_ := 100;
         ELSIF k.s080 = '5' AND k.kv <> '980'
         THEN
            proc_ := 100;
         ELSE
            proc_ := 0;
         END IF;

         BEGIN
            SELECT NVL (SUM (TO_NUMBER (znap)), 0)
              INTO sr11_
              FROM tmp_nbu
             WHERE kodf = '11'
               AND datf = dat_
               AND SUBSTR (kodp, 6, 1) = k.s080
               AND SUBSTR (kodp, 9, 3) = k.kv
               AND kodp LIKE '1%';
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               sr11_ := 0;
         END;

         BEGIN
            SELECT NVL (SUM (TO_NUMBER (znap)), 0)
              INTO sd11_
              FROM tmp_nbu
             WHERE kodf = '11'
               AND datf = dat_
               AND SUBSTR (kodp, 6, 1) = k.s080
               AND SUBSTR (kodp, 9, 3) = k.kv
               AND kodp LIKE '2%';
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               sd11_ := 0;
         END;

         BEGIN
            SELECT NVL (SUM (TO_NUMBER (znap)), 0)
              INTO so30_
              FROM tmp_nbu
             WHERE kodf = '30'
               AND datf = dat_
               AND (kodp LIKE '12%' OR kodp LIKE '13%')
               AND kodp NOT LIKE '128%'
               AND SUBSTR (kodp, 4, 1) = k.s080
               AND SUBSTR (kodp, 5, 3) = k.kv;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               so30_ := 0;
         END;

         BEGIN
            SELECT NVL (SUM (TO_NUMBER (znap)), 0)
              INTO sn30_
              FROM tmp_nbu
             WHERE kodf = '30'
               AND datf = dat_
               AND kodp LIKE '128%'
               AND SUBSTR (kodp, 4, 1) = k.s080
               AND SUBSTR (kodp, 5, 3) = k.kv;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               sn30_ := 0;
         END;

         BEGIN
            SELECT NVL (SUM (TO_NUMBER (znap)), 0)
              INTO szq_
              FROM tmp_nbu
             WHERE kodf = '30'
               AND datf = dat_
               AND kodp LIKE '15%'
               AND SUBSTR (kodp, 4, 1) = k.s080
               AND SUBSTR (kodp, 5, 3) = k.kv;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               szq_ := 0;
         END;

         szq2_ :=
              ROUND (GREATEST (sr11_ - sd11_ - so30_ - sn30_, 0) * proc_ / 100);

         IF szq_ <> 0 OR szq2_ <> 0
         THEN
            to_log (0, 's080=' || k.s080 || ' ' || 'kv=' || k.kv, '');
            to_log (0, 'расчет =' || TO_CHAR (szq2_), '');
            to_log (0, 'файл   =' || TO_CHAR (szq_), '');
            to_log (0, 'Р11=' || TO_CHAR (sr11_), '');
            to_log (0, 'Д11=' || TO_CHAR (sd11_), '');
            to_log (0, 'О30=' || TO_CHAR (so30_), '');
            to_log (0, 'Н30=' || TO_CHAR (sn30_), '');
            to_log (0, '%=' || TO_CHAR (proc_), '');
         END IF;
      END LOOP;

      uselog_ := 0;
   END;
BEGIN
   -- Инициализируем глобальные переменные
   g_restdate := NULL;

  /* SELECT ID
     INTO userid_
     FROM staff
    WHERE UPPER (logname) = UPPER (USER);
*/
   userid_ := user_id;

   -- флаг - использовать для опр. проср > 31 % спецпараметр R013
   BEGIN
      SELECT TO_NUMBER (NVL (val, '0'))
        INTO rzprr013_
        FROM params
       WHERE par = 'RZPRR013';
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         rzprr013_ := 0;
   END;

   -- флаг - не разделять при обработке физиков и юриков
   BEGIN
      SELECT TO_NUMBER (NVL (val, '0'))
        INTO rezpar1_
        FROM params
       WHERE par = 'REZPAR1';
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         rezpar1_ := 0;
   END;

   -- флаг - учитывать при расчете обеспечениеи 26 для кредитов > 2 лет (КИЕВ)
   BEGIN
      SELECT TO_NUMBER (NVL (val, '0'))
        INTO rezpar2_
        FROM params
       WHERE par = 'REZPAR2';
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         rezpar2_ := 0;
   END;

   -- флаг - специальная обработка Лизинга 2071 (АКБ Ажио)
   BEGIN
      SELECT TO_NUMBER (NVL (val, '0'))
        INTO rezpar3_
        FROM params
       WHERE par = 'REZPAR3';
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         rezpar3_ := 0;
   END;

   -- флаг - не учитывать при расчете дисконт
   BEGIN
      SELECT TO_NUMBER (NVL (val, '0'))
        INTO rezpar4_
        FROM params
       WHERE par = 'REZPAR4';
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         rezpar4_ := 0;
   END;

   -- флаг - считать (SK9) внутрибанковским счетом (custtype=1)
   BEGIN
      SELECT TO_NUMBER (NVL (val, '0'))
        INTO rezpar7_
        FROM params
       WHERE par = 'REZPAR7';
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         rezpar7_ := 0;
   END;

   -- флаг - расчет резерва просроченных процентов по смешанному алгоритму
   BEGIN
      SELECT TO_NUMBER (NVL (val, '0'))
        INTO rezpar8_
        FROM params
       WHERE par = 'REZPAR8';
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         rezpar8_ := 0;
   END;

   -- флаг - расчет обесп проср > 30 дней коредитов по спец алгоритму
   BEGIN
      SELECT TO_NUMBER (NVL (val, '0'))
        INTO rezpar9_
        FROM params
       WHERE par = 'REZPAR9';
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         rezpar9_ := 0;
   END;

   BEGIN
      SELECT TO_NUMBER (NVL (val, '0'))
        INTO rezpar10_
        FROM params
       WHERE par = 'REZPAR10';
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         rezpar10_ := 0;
   END;

   BEGIN
      SELECT TO_NUMBER (NVL (val, '0'))
        INTO rezpar11_
        FROM params
       WHERE par = 'REZPAR11';
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         rezpar11_ := 0;
   END;


   -- флаг - процент резервирования по 83 постанове
--    BEGIN
--       SELECT TO_NUMBER (NVL (val, '0'))
--         INTO rezpar5_
--         FROM params
--        WHERE par = 'REZPAR5';
--    EXCEPTION
--       WHEN NO_DATA_FOUND
--       THEN
--          rezpar4_ := 0;
--    END;

   -- флаг - применяется программа оплаты ca_pay_rez2
   BEGIN
      SELECT TO_NUMBER (NVL (val, '0'))
        INTO rezpay2_
        FROM params
       WHERE par = 'REZPAY2';
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         rezpay2_ := 0;
   END;
END rez;

/
 show err;
 
PROMPT *** Create  grants  REZ ***
grant EXECUTE                                                                on REZ             to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on REZ             to RCC_DEAL;
grant EXECUTE                                                                on REZ             to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/rez.sql =========*** End *** =======
 PROMPT ===================================================================================== 
 