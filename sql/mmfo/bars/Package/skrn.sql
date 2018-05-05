PROMPT =====================================================================================
PROMPT *** Run *** ========== Scripts /Sql/BARS/package/skrn.sql =========*** Run *** ======
PROMPT =====================================================================================
 
CREATE OR REPLACE PACKAGE SKRN
IS
/*

  пакет управления договорами депозитных сейфрв
  version 6.1 25/04/2012

  Параметры в TOBO_PARAMS
  DEP_KAS - счет кассы
  DEP_S1  - счет внебаланса 9898
  DEP_S2  - счет внебаланса 9819
  DEP_S3  - счет 6519 (по старому плану счетов 6119)
  DEP_S4  - счет 3600
  DEP_S5  - сводный 2909 для отражения НДС
  DEP_S6  - сводный 3579
  DEP_S7  - сводный счет для списания НДС 6519 (по старому плану счетов 6119)
  DEP_S9  - рахунок для перерахування плати за довіреність 2909
  DEP_S10  - рахунок для перерахування штрафу 6397

  Параметры в PARAMS
  SKRNPAR1=1 - не расщеплять доходы банка по НДС (безбалансовые,Петрокоммерц)
  SKRNPAR2=1 - использовать индивидуальный счет просрочки
  SKRNPAR3=1 - все проводки в одном референсе документа
*/
   header_version_        VARCHAR2 (30)            := 'version 6.3 08/02/2018';

   skrnpar1_   NUMBER := 0;
   skrnpar2_   NUMBER := 0;
   skrnpar3_   NUMBER := 0;
   skrnpar4_   NUMBER := 0;

   FUNCTION header_version RETURN VARCHAR2;

   FUNCTION body_version RETURN VARCHAR2;

   -- вставка в документ допреквизитов юрлиц
   PROCEDURE operw_ul (ref_ NUMBER);

   -- вставка в документ допреквизитов физлиц
   PROCEDURE operw_fl (ref_ NUMBER);

   -- процедура расчета тарифа
   PROCEDURE p_tariff (tariff_code_ NUMBER, dat11_ DATE, dat12_ DATE, bdate_ DATE);

   -- создание лимита на индивидуальном счете 8 класса
   PROCEDURE p_tariff2 (n_sk_ NUMBER, dat11_ DATE, dat12_ DATE, bdate_ DATE);

   -- точка входа для автоматических операций по сейфам
   PROCEDURE p_dep_skrn ( dat_    DATE, dat2_   DATE, n_sk_   NUMBER, mode_   NUMBER, par_    NUMBER DEFAULT NULL, p_userid NUMBER DEFAULT NULL, p_sum number default null, p_extnd varchar2 DEFAULT NULL);

   -- очистка відпрацьованих та незакритих 3600
   PROCEDURE p_cleanup (DUMMY NUMBER);

   -- расчет тарифа по параметрам карточки сейфа (текщий договор)
   PROCEDURE p_calc_tariff (n_sk_ NUMBER, par_ number default null);

   -- расчет оплаты за период исходя из суммы аренды за весь срок
   PROCEDURE p_calcperiod_tariff (dat1_ DATE, dat2_ DATE, nd_ NUMBER, par_ number default null);

   --  Оплата прострочки
   PROCEDURE overdue_payment(  dat_    DATE,  dat2_   DATE,  n_sk_   NUMBER, mode_   NUMBER,  par_    NUMBER );

   --! сумма текущих проплат по аренде (НДС, доходы текущего периода, доходы будующих периодоа)
   FUNCTION f_get_opl_sum (nd_ NUMBER) RETURN NUMBER;

   --! сумма общей текущей задолженности клиента (общей) = сумм аренды - сумма текущих проплат
   FUNCTION f_get_borg_sum (nd_ NUMBER) RETURN NUMBER;

   --! плановая сумма аренды = сумма аренды от начала договора на текущую дату
   FUNCTION f_get_oplplan_sum (nd_ NUMBER) RETURN NUMBER;

   --! плановая сумма аренды = сумма аренды от начала договора на текущую дату
   FUNCTION f_get_oplplan_sum_4date (nd_ NUMBER, dt_term DATE) RETURN NUMBER;

   --! плановая сумма аренды = сумма аренды от за период
   FUNCTION f_get_oplplan_sum_4period (nd_ NUMBER, dt_start DATE, dt_end DATE) RETURN NUMBER;

   --! сумма проплат по счету доходов будующих периодов
   FUNCTION f_get_3600_sum (nd_ NUMBER) RETURN NUMBER;

   --! сумма проплат по счету НДС
   FUNCTION f_get_nds_sum (nd_ NUMBER) RETURN NUMBER;

   --! сумма проплат по счету доходов текущего периода
   FUNCTION f_get_curdoh_sum (nd_ NUMBER) RETURN NUMBER;

   --! сумма амортизированных доходов будующих периодов
   FUNCTION f_get_amort3600_sum (nd_ NUMBER) RETURN NUMBER;

   --! добова сума штрафу по договору
   FUNCTION f_get_peny(nd_ NUMBER) RETURN NUMBER;

   -- 1 - потрібно виконати амортизацію, 0 - ні
   FUNCTION f_amort_needed RETURN NUMBER;

   --! добова сума штрафу по договору прописом
   FUNCTION f_get_peny_literal(nd_ NUMBER) RETURN VARCHAR2;

   -- создание переменных-параметров модуля
   PROCEDURE initparams (par_ NUMBER);
   PROCEDURE setparams (par_ VARCHAR2, val_ VARCHAR2);

   -- инициализация переменных-параметров модуля
   PROCEDURE init (parn_ NUMBER);

   -- Операція дострокового закриття договору оренди індивідуального сейфа (нал)
  PROCEDURE P_ADVANCE_CLOSED_DEAL(DAT_  IN DATE,
                                  DAT2_ IN DATE,
                                  N_SK_ IN NUMBER,
                                  MODE_ IN NUMBER,
                                  PAR_  IN NUMBER DEFAULT NULL);
------------------------------------------------------------------------------------------------------------------------------
   -- НЕ ВИКОРИСТОВУЄТЬСЯ
   FUNCTION get_par (par_ NUMBER) RETURN VARCHAR2;
   -- НЕ ВИКОРИСТОВУЄТЬСЯ
   FUNCTION f_getnextdat (n_sk_ NUMBER, dat11_ DATE, s_ NUMBER) RETURN NUMBER;
   -- НЕ ВИКОРИСТОВУЄТЬСЯ
   PROCEDURE p_prepare_ptotocol (dat_ DATE, dat2_ DATE, n_sk_ NUMBER, mode_ NUMBER, par_ NUMBER DEFAULT NULL);
   -- НЕ ВИКОРИСТОВУЄТЬСЯ
   FUNCTION f_get_protocol_line RETURN VARCHAR2;

END skrn;
/
CREATE OR REPLACE PACKAGE BODY SKRN
-- *******************************************************************************
IS
   version_   constant  varchar2(30)   := 'version 6.17 15/03/2018';
   body_awk   constant  varchar2(512)  := ''
    ||'IND_ACC' ||chr(10)
    ||'M_AMORT' ||chr(10)
    ||'PRLNG' ||chr(10)
    ||'AMORT_NAZN' ||chr(10)
    ||'RENT' ||chr(10)
    ||'AUTO_PRLNG' ||chr(10)
    ||'FINAL_AMORT' ||chr(10)
    ||'UPB_PENALTY' ||chr(10)
    ||'FULL_AMORT' ||chr(10)
    ||'AMORT_DATE' ||chr(10)
    ||'SBER' ||chr(10)
    ||'OBU' ||chr(10)
  ;

   newnd_          NUMBER;
   oldnd_          NUMBER;
   tt_             CHAR (3);
   tt2_            CHAR (3);
   tt3_            CHAR (3);
   vob_            oper.vob%TYPE            := 6;
   vob2_           oper.vob%TYPE            := 6;
   vob3_           oper.vob%TYPE            := 6;
   itemname_       skrynka_menu.NAME%TYPE;
   s_              NUMBER;
   sz_             NUMBER;
   sa_             NUMBER;
   kv_             NUMBER                   := 980;
   userid_         NUMBER;
   okpok_          VARCHAR2 (14);
   -- Рахунок застави
   nls2909_        VARCHAR2 (15);
   nms2909_        accounts.nms%TYPE;
   nlss2909_       VARCHAR2 (15);
   nmss2909_       accounts.nms%TYPE;
   ostc2909_       NUMBER;

   nlss3579_       VARCHAR2 (15);
   nmss3579_       accounts.nms%TYPE;

   -- рахунок для штрафу ( прострочки) - інд. УПБ
   nls6397_      accounts.nls%type;
   nms6397_      accounts.nms%type;

   nls9898_        VARCHAR2 (15);
   nms9898_        accounts.nms%TYPE;

   nls9819_        VARCHAR2 (15);
   nms9819_        accounts.nms%TYPE;
   -- Рахунок прибутків теперішнього періоду (по старому плану счетов 6119)
   nls6519_        VARCHAR2 (15);
   nms6519_        accounts.nms%TYPE;
   -- Рахунок прибутків майбутнього періоду
   nls3600_        VARCHAR2 (15);
   nms3600_        accounts.nms%TYPE;

   nls8_           VARCHAR2 (15);
   nms8_           accounts.nms%TYPE;

   nlss8_          VARCHAR2 (15);
   nmss8_          accounts.nms%TYPE;
   -- Рахунок каси
   nlskas_         VARCHAR2 (15);
   nmskas_         accounts.nms%TYPE;
   -- Рахунок для ПДВ
   nlsnds_         VARCHAR2 (15);
   nmsnds_         accounts.nms%TYPE;
   -- Рахунок для плати за довіреність
   nls_s9_       accounts.nls%type;
   nms_s9_       accounts.nms%type;

   nam_a_          oper.nam_a%TYPE;
   nam_b_          oper.nam_b%TYPE;
   nazn_           oper.nazn%TYPE;
   ref_            NUMBER;
   nd_             NUMBER;
   okpoa_          VARCHAR2 (14);
   okpob_          VARCHAR2 (14);
   mfoa_           oper.mfoa%TYPE;
   mfob_           oper.mfoa%TYPE;
   sk_             oper.sk%TYPE;
   bankdate_       DATE;
   dk_             NUMBER;
   dk2_            NUMBER;
   skrnd_          skrynka_nd%ROWTYPE;
   skr_            skrynka%ROWTYPE;
   mainacc_        accounts%ROWTYPE;
   accm_           NUMBER;
   def_rnk_        NUMBER;
   r1_             NUMBER;
   nls_            VARCHAR2 (15);
   nlsa_           VARCHAR2 (15);
   nlsb_           VARCHAR2 (15);
   dend_           DATE;
   del_            NUMBER                   := 0;
   -- период аренды дней (включая дату начала - конца)
   proc_           NUMBER                   := 0;           -- процент скидки
   tariff_         NUMBER                   := 0;
   -- абон плата без скидки (с НДС)
   tariff2_        NUMBER                   := 0;
   -- абон плата со скидкой (с НДС)
   tariff3_        NUMBER                   := 0;
   -- абон плата со скидкой без НДС
   daystariff_     NUMBER;
   sd_             NUMBER;
   monthstariff_   NUMBER;
   enddate_        DATE;
   nds_            NUMBER                   := 20;
   snds_           NUMBER;                                       -- сумма НДС
   scperiod_       NUMBER;                          -- сумма текущего периода
   sfperiod_       NUMBER;                          -- сумма будущих периодов
   months_         NUMBER;
   days_           NUMBER;
   otcndat_        DATE;
   d1_             DATE;
   d2_             DATE;
   n_sk_old_       NUMBER;
   trf_            NUMBER;
   trf_old_        NUMBER;
   olddat_         DATE;                     -- дата начала предыдущей аренды
   olddat2_        DATE;                      -- дата конца предыдущей аренды
   otvisp_         NUMBER;                       --отв исп по автооткр счетам
   grp_            NUMBER;                   -- гр доступа по автооткр счетам
   tcode_          NUMBER;
   -- переменные для расчета аренды за произвольный период
   dni1_           NUMBER;                  -- количество дней в сроке аренды
   dni2_           NUMBER;                -- количество дней текущего периода
   dni3_           NUMBER;                -- количество дней будущего периода
   dni4_           NUMBER;                  -- количество дней периода оплаты
   sd1_            NUMBER;                                   -- дневной тариф
   datp1_          DATE;                       -- дата конца текущего периода
   datp2_          DATE;                      -- дата начала будущего периода
   sb1_            NUMBER;                          -- сумма аренды за период
   sb2_            NUMBER;                          -- сумма аренды за период
   sc1_            NUMBER;                          -- сумма текущего периода
   sf1_            NUMBER;                          -- сумма будущего периода
   snds1_          NUMBER;                            -- НДС за период аренды
   sall1_          NUMBER;
   datk_           DATE;
   st_             NUMBER;
   prsc_           NUMBER                   := 0;           -- процент скидки
   peny_           NUMBER                   := 0;           -- процент скидки
   sopl_           NUMBER;
   l_monts_        NUMBER;                                  -- місячна сума для тарифу 1
   branch_         VARCHAR2 (30);
   -- код модуля для відображення помилок
   l_mod  constant varchar2(3) := 'SKR';
-- *******************************************************************************
   -- протокол
-- *******************************************************************************
   TYPE type_prot IS TABLE OF VARCHAR2 (100)
      INDEX BY BINARY_INTEGER;

   prot_           type_prot;
   proti_          NUMBER;
   proti2_         NUMBER;
----------------------------------------------------------------------------
   ern    CONSTANT POSITIVE                 := 208;
   err             EXCEPTION;
   erm             VARCHAR2 (80);

----------------------------------------------------------------------------
-- *******************************************************************************
   -- вставка в документ допреквизитов физлиц
-- *******************************************************************************
   PROCEDURE operw_fl (ref_ NUMBER)
   IS
   l_s_ number;
   l_dk_ oper.dk%type;
   BEGIN

     select ( GL.P_NCURVAL(kv, S, vdat) )/100, dk into l_s_, l_dk_ from oper where ref =  ref_;


      FOR k IN (SELECT *
                  FROM op_field
                 WHERE tag IN
                          ('FIO','PASP','PASPN','ATRT','ADRES','SKR_D','POKPO'))
      LOOP
         IF k.tag = 'FIO'
         THEN
            INSERT INTO operw(REF, tag, VALUE)
                 VALUES (ref_, 'FIO', skrnd_.fio);
         ELSIF k.tag = 'PASP' and  (l_s_ >= 150000 or l_dk_ = 1)
         THEN
            INSERT INTO operw(REF, tag, VALUE)
                 VALUES (ref_, 'PASP', 'паспорт');
         ELSIF k.tag = 'PASPN' and (l_s_ >= 150000 or l_dk_ = 1)
         THEN
            INSERT INTO operw(REF, tag, VALUE)
                 VALUES (ref_, 'PASPN', skrnd_.dokum);
         ELSIF k.tag = 'ATRT' and  (l_s_ >= 150000 or l_dk_ = 1)
         THEN
            INSERT INTO operw(REF, tag, VALUE)
                 VALUES (ref_, 'ATRT', skrnd_.issued);
         ELSIF k.tag = 'ADRES' and  (l_s_ >= 150000) -- or l_dk_ = 1) --COBUMMFO-5602
         THEN
            INSERT INTO operw(REF, tag, VALUE)
                 VALUES (ref_, 'ADRES', skrnd_.adres);
         ELSIF k.tag = 'SKR_D' and  (l_s_ >= 150000 or l_dk_ = 1)
         THEN
            INSERT INTO operw(REF, tag,VALUE)
                 VALUES (ref_, 'SKR_D',TO_CHAR (skrnd_.dat_begin, 'dd.mm.yyyy'));
         ELSIF k.tag = 'POKPO'
         THEN
            INSERT INTO operw(REF, tag, VALUE)
                 VALUES (ref_, 'POKPO', skrnd_.okpo1);
         END IF;
      END LOOP;
   END;
-- *******************************************************************************
   -- вставка в документ допреквизитов юрлиц
-- *******************************************************************************
   PROCEDURE operw_ul (ref_ NUMBER)
   IS
   BEGIN
      FOR k IN (SELECT *
                  FROM op_field
                 WHERE tag IN
                          ('FIO', 'PASP', 'PASPN', 'ATRT', 'ADRES', 'SKR_D'))
      LOOP
         IF k.tag = 'FIO'
         THEN
            INSERT INTO operw(REF, tag, VALUE)
                 VALUES (ref_, 'FIO', skrnd_.fio2);
         ELSIF k.tag = 'PASP'
         THEN
            INSERT INTO operw(REF, tag, VALUE)
                 VALUES (ref_, 'PASP', 'паспорт');
         ELSIF k.tag = 'PASPN'
         THEN
            INSERT INTO operw(REF, tag, VALUE)
                 VALUES (ref_, 'PASPN', skrnd_.pasp2);
         ELSIF k.tag = 'ATRT'
         THEN
            INSERT INTO operw(REF, tag, VALUE)
                 VALUES (ref_, 'ATRT', skrnd_.issued2);
         ELSIF k.tag = 'ADRES'
         THEN
            INSERT INTO operw(REF, tag, VALUE)
                 VALUES (ref_, 'ADRES', skrnd_.adres2);
         ELSIF k.tag = 'SKR_D'
         THEN
            INSERT INTO operw(REF, tag,VALUE)
                 VALUES (ref_, 'SKR_D',TO_CHAR (skrnd_.dat_begin, 'dd.mm.yyyy'));
         END IF;
      END LOOP;
   END;

-- *******************************************************************************
    -- вставка в документ допреквизитов для внебал операции выдачи ключа
-- *******************************************************************************
   PROCEDURE operw_vnebal (ref_ NUMBER)
   IS
   f_   skrynka_staff.fio%TYPE;
   BEGIN
      FOR k IN (SELECT *
                  FROM op_field
                 WHERE tag IN ('FIO','GOLD','SUMGD','VLASN','FIO1','FIO2','PO_N1','PO_K1','PO_S1','PO_KK','PO_OS'))
      LOOP
         IF k.tag = 'FIO'
         THEN
            -- допреквизиты для Петрокоммерца
            INSERT INTO operw(REF, tag, VALUE)
                 VALUES (ref_, 'FIO', NVL (skrnd_.fio, skrnd_.fio2));
         ELSIF k.tag = 'GOLD'
         THEN
            INSERT INTO operw(REF, tag, VALUE)
                 VALUES (ref_, 'GOLD', 'ключ від сейфу № ' || skr_.snum);
         ELSIF k.tag = 'SUMGD'
         THEN
            INSERT INTO operw(REF, tag, VALUE)
                 VALUES (ref_, 'SUMGD', '1');
         ELSIF k.tag = 'VLASN'
         THEN
            INSERT INTO operw(REF, tag, VALUE)
                 VALUES (ref_, 'VLASN', 'касса банку');
         ELSIF k.tag = 'FIO1'
         THEN
            -- допреквизиты для всех
            IF gl.amfo = '380214'
            THEN
               BEGIN
                  SELECT ss.fio
                    INTO f_
                    FROM skrynka_staff ss
                   WHERE tip = 1 AND ROWNUM = 1;

                  INSERT INTO operw(REF, tag, VALUE)
                       VALUES (ref_, 'FIO1', f_);
               EXCEPTION
                  WHEN OTHERS
                  THEN NULL;
               END;
            ELSE
               INSERT INTO operw(REF, tag, VALUE)
                    VALUES (ref_, 'FIO1', skrnd_.fio);
            END IF;
         ELSIF k.tag = 'FIO2'
         THEN
            -- допреквизиты для всех
            IF gl.amfo = '380214'
            THEN
               BEGIN
                  SELECT ss.fio
                    INTO f_
                    FROM skrynka_staff ss
                   WHERE tip = 1 AND ROWNUM = 1;

                  INSERT INTO operw(REF, tag, VALUE)
                       VALUES (ref_, 'FIO2', f_);
               EXCEPTION
                  WHEN OTHERS
                  THEN NULL;
               END;
            ELSE
               INSERT INTO operw(REF, tag, VALUE)
                    VALUES (ref_, 'FIO2', skrnd_.fio);
            END IF;
         ELSIF k.tag = 'PO_N1'
         THEN
            INSERT INTO operw(REF, tag,VALUE)
                 VALUES (ref_, 'PO_N1',
                            'ключ № '
                         || skr_.keynumber
                         || ' від деп. ячейки № '
                         || TO_CHAR (skr_.n_sk)
                         || '.'
                        );
         ELSIF k.tag = 'PO_K1'
         THEN
            INSERT INTO operw(REF, tag, VALUE)
                 VALUES (ref_, 'PO_K1', '1');
         ELSIF k.tag = 'PO_S1'
         THEN
            INSERT INTO operw(REF, tag, VALUE)
                 VALUES (ref_, 'PO_S1', '1.00');
         ELSIF k.tag = 'PO_KK'
         THEN
            INSERT INTO operw(REF, tag, VALUE)
                 VALUES (ref_, 'PO_KK', '1');
         ELSIF k.tag = 'PO_OS'
         THEN
            INSERT INTO operw(REF, tag,VALUE)
                 VALUES (ref_, 'PO_OS',
                            'згідно угоди № '
                         || skrnd_.ndoc
                         || ' від '
                         || skrnd_.docdate
                         || '.'
                        );
         END IF;
      END LOOP;
   END;


    Procedure p_nls_6519 (p_cust number)
    as
    l_nbs  accounts.nbs%type;
    l_ob22 accounts.ob22%type;
    BEGIN

      if p_cust in (3,2)
         then null;
         else return;
      end if;

     SELECT (CASE WHEN p_cust = 3 THEN ob22 ELSE ob22_u END), nbs
       INTO l_ob22, l_nbs
       FROM SKRYNKA_ACC_TIP
      WHERE tip = 'C';

      ------- ЗАГЛУШКА ДЛЯ СЧЕТА 6119 (стал 6519)
      if newnbs.g_state <> 1
        then l_nbs := 6119;
      end if;

     SELECT a.nls, a.nms
       INTO nls6519_, nms6519_
       FROM accounts a
      WHERE a.nls = nbs_ob22(l_nbs, l_ob22)
        and a.kv = 980;
    EXCEPTION WHEN NO_DATA_FOUND THEN NULL;
    END;


    -- ****************************************************
    --  Визначення кількості виданих ключів
    -- ****************************************************
    function f_keyused (p_nd skrynka_nd.nd%type) return number
     as
    l_kol number;
    begin
     SELECT SUM (s / 100 * DECODE (dk, 0, -1, 1))
          INTO l_kol
          FROM SKRYNKA_ND_REF s, opldok p, accounts a
         WHERE     s.REF = p.REF
               AND p.acc = a.acc
               AND s.nd = p_nd
               AND a.nls LIKE '9819%'
               AND sos >= 0;
    return nvl(l_kol,0);
    end;


-- *******************************************************************************
   -- процедура расчета тарифа
-- *******************************************************************************
PROCEDURE p_tariff (tariff_code_   IN NUMBER,
                    dat11_         IN DATE,
                    dat12_         IN DATE,
                    bdate_         IN DATE)
IS
  tip_      NUMBER;
  fl_       NUMBER;                                        -- флаг тарифа
  st_       NUMBER;                                       -- сумма тарифа
  mcount_   NUMBER;
  months3_  NUMBER;
  months6_  NUMBER;
  months9_  NUMBER;
  months12_ NUMBER;
  months15_ NUMBER;

   BEGIN
       -- обработка вида тарифа
      -- 1- Специально для Петрокоммерца
      -- 2- диапазонная для всех от календарных дней)
      BEGIN
         SELECT t.tip
           INTO tip_
           FROM skrynka_tariff t
          WHERE t.tariff = tariff_code_ AND branch = branch_;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN tip_ := NULL;
      END;

      tcode_ := tariff_code_;
      -- количество дней аренды
      del_ := dat12_ - dat11_ + 1;

      if del_ > 365
      then
        bars_error.raise_nerror(l_mod, 'RENT_TERM_INCORRECT', TO_CHAR(del_));
      end if;

      IF tip_ = 1
      THEN
         del_ := 0;
         proc_ := 0;
         tariff_ := 0;
         tariff2_ := 0;
         tariff3_ := 0;
         months_ := 0;
         days_ := 0;
         daystariff_ := 0;
         monthstariff_ := 0;

         IF dat11_ > dat12_ OR dat11_ IS NULL OR dat12_ IS NULL
         THEN
      bars_error.raise_nerror(l_mod, 'RENT_DATE_INCORRECT', TO_CHAR (dat11_,'dd/mm/yyyy'), TO_CHAR (dat12_,'dd/mm/yyyy'));
         END IF;

         -- количество календарных месяцев в сроке аренды
         BEGIN
            d1_ := dat11_;
            d2_ := dat12_;
            dend_ := d1_;

            WHILE (ADD_MONTHS (d1_, months_ + 1) <= d2_)
            LOOP
               dend_ := ADD_MONTHS (d1_, months_ + 1);
               months_ := months_ + 1;
            END LOOP;

            IF months_ <> 0
            THEN days_ := d2_ - dend_;
            ELSE days_ := d2_ - dend_ + 1;
            END IF;
         END;

         BEGIN
            SELECT NVL (s.months, 0), NVL (s.days, 0), NVL(peny,0), months3, months6, months9, months12, months15
              INTO monthstariff_, daystariff_, peny_, months3_, months6_, months9_, months12_, months15_
              FROM skrynka_tariff1 s
             WHERE tariff = tariff_code_
               AND s.tariff_date =
                      (SELECT MAX (ss.tariff_date)
                         FROM skrynka_tariff1 ss
                        WHERE ss.tariff = tariff_code_
                          AND ss.tariff_date <= bdate_);

      --bars_audit.info('skrn: peny = '|| peny_);
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN bars_error.raise_nerror(l_mod, 'TARIF_NOT_FOUND', tariff_code_);
         END;

         BEGIN
            SELECT proc
              INTO proc_
              FROM (SELECT   ROWNUM, tariff, months, tariff_date, proc
                        FROM skrynka_tariff_skidka
                       WHERE tariff_date <= bdate_
                         AND tariff = tariff_code_
                         AND months =
                                (SELECT MAX (ss.months)
                                   FROM skrynka_tariff_skidka ss
                                  WHERE ss.tariff_date <= bdate_
                                    AND ss.tariff = tariff_code_
                                    AND ss.months <= months_
                                )
                    ORDER BY tariff_date DESC, months DESC)
             WHERE ROWNUM = 1;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN proc_ := 0;
         END;

         CASE
         WHEN months_ >= 12
         THEN tariff_  := months12_ * months_ + daystariff_ * days_;
              l_monts_ := months12_;
         WHEN months_ >= 9
         THEN tariff_  := months9_ * months_ + daystariff_ * days_;
              l_monts_ := months9_;
         WHEN months_ >= 6
         THEN tariff_  := months6_ * months_ + daystariff_ * days_;
              l_monts_ := months6_;
         WHEN months_ >= 3
         THEN tariff_  := months3_ * months_ + daystariff_ * days_;
              l_monts_ := months3_;
         ELSE tariff_  := monthstariff_ * months_ + daystariff_ * days_;
              l_monts_ := monthstariff_;
         END CASE;


         IF months_ >= 1
         THEN tariff3_ := ROUND (tariff_ * (1 - proc_ / 100), 2);
         ELSE tariff3_ := tariff_;
         END IF;

         -- сумма без НДС
         IF skrnpar1_ = 0
         THEN tariff2_ := ROUND (tariff3_ * 5 / 6, 2);
         ELSE tariff2_ := tariff3_;
         END IF;

         tariff_ := 100 * tariff_;
         tariff2_ := 100 * tariff2_;
         tariff3_ := 100 * tariff3_;

         /* определение суммы текущего периода */

         /* если начало периода в следующем месяце
              дох тек периода = 0 */

         /*
            текущие доходы Петрокоммерц

            1. если идет аренда сейфа на срок более 30(28-29 для февраля) дней, то
               сумма за первые 30 дней без НДС идет на текущие доходы(6 класс), а
               остальное все на будущие (3600).
            2. если пролонгация и дата завершения текущей аренды еще не наступила,
               то вся сумма без НДС на будущие доходы(3600) - даже, если до конца
               текущей аренды 1 день;
            3. если дата завершения текущей аренды сегодня и пролонгация сегодня,
               то сумма без НДС за первый месяц срока пролонгации на текущие доходы,
               а все остальное без НДС на будущие;
            4. если дата текущей аренды прошла, то по сегодняшнюю дату берется
               просрочка и сумма ее без НДС на текущие доходы, с сегодняшнего дня
               по правилам новой аренды расщепляется арендная плата.*/
         IF     olddat2_ IS NOT NULL
            AND (olddat2_ > bankdate OR dat11_ > LAST_DAY (bankdate))
         THEN                                                   -- пролонгация
            scperiod_ := 0;
         ELSIF     olddat2_ IS NULL
               AND dat11_ > LAST_DAY (bankdate)   -- начало аренды через месяц
         THEN
            scperiod_ := 0;
         ELSE
            IF ADD_MONTHS (d1_, 1) >= d2_
            THEN
               scperiod_ := tariff2_;
            ELSE
               scperiod_ := ROUND (  (1 - (1 - skrnpar1_) / 6)
                         --* monthstariff_
             * l_monts_
                         * 100 * (1 - proc_ / 100));
            END IF;
         END IF;
      ELSIF tip_ = 2
      THEN
         d1_ := dat11_;
         d2_ := dat12_;

         BEGIN
            SELECT NVL (s.s, 0) * 100, flag1, NVL (proc, 0), NVL (peny, 0)
              INTO st_, fl_, prsc_, peny_
              FROM skrynka_tariff2 s
             WHERE tariff = tariff_code_
               AND del_ >= s.daysfrom
               AND del_ <= s.daysto
               AND s.tariff_date =
                      (SELECT MAX (ss.tariff_date)
                         FROM skrynka_tariff2 ss
                        WHERE ss.tariff = tariff_code_
                          AND del_ >= daysfrom
                          AND del_ <= daysto
                     AND ss.tariff_date <= bdate_);
         EXCEPTION WHEN NO_DATA_FOUND
                   THEN bars_error.raise_nerror(l_mod, 'TARIF_NOT_FOUND', tariff_code_);
         END;

         -- количество календарных месяцев (30 дн) в сроке
         -- пока определение количства месяцев только здесь
         months_ := CEIL (del_ / 30);
         days_ := del_;

         IF fl_ = 1
         THEN
            sd_ := st_;
            tariff3_ := ROUND (st_ * del_ * NVL (1 - prsc_ / 100, 1));
            tariff2_ := ROUND (tariff3_ * 100 / (100 + nds_));
         ELSIF fl_ = 2
         THEN
            sd_ := st_ / 30;
            tariff3_ := ROUND (sd_ * del_ * NVL (1 - prsc_ / 100, 1));
            tariff2_ := ROUND (tariff3_ * 100 / (100 + nds_));
         END IF;

         tariff_ := tariff3_;

         -- месячный тариф для расщепления на доходы текущего и будующих периодов
         IF months_ = 0
         THEN scperiod_ := tariff2_;
         ELSE scperiod_ := ROUND (tariff2_ / months_);
         END IF;

    END IF;
   END p_tariff;

-- *******************************************************************************\
--        Попередній розрахунок тарифу
--          НЕ ВИКОРИСТОВУЄТЬСЯ
-- *******************************************************************************
PROCEDURE p_tariff2 (n_sk_     NUMBER,
                     dat11_    DATE,
                     dat12_    DATE,
                     bdate_    DATE)
   IS
      trf_   NUMBER;
   BEGIN
      BEGIN
         SELECT tariff
           INTO trf_
           FROM skrynka_nd n
          WHERE n.sos = 0 AND n_sk = n_sk_;
      EXCEPTION WHEN NO_DATA_FOUND
                THEN trf_ := NULL;
      END;
      p_tariff (trf_, dat11_, dat12_, bankdate);
   END;

-- *******************************************************************************
--        Для попереднього розрахуноку тарифу
--          НЕ ВИКОРИСТОВУЄТЬСЯ
-- *******************************************************************************
   FUNCTION f_getnextdat (n_sk_ NUMBER, dat11_ DATE, s_ NUMBER)
      RETURN NUMBER
   IS
      d_   NUMBER := 0;
   BEGIN
      IF n_sk_old_ IS NULL OR n_sk_old_ <> n_sk_
      THEN
         BEGIN
            SELECT tariff
              INTO trf_
              FROM skrynka_nd n
             WHERE n.sos = 0 AND n_sk = n_sk_;

            n_sk_old_ := n_sk_;
            trf_old_ := trf_;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN trf_ := NULL;
         END;
      ELSE
         trf_ := trf_old_;
      END IF;

      LOOP
         p_tariff (trf_, dat11_, dat11_ + d_, bankdate);

         IF d_ >= 10000 OR s_ < skrn.get_par (10)
         THEN
            EXIT;
         END IF;

         d_ := d_ + 1;
      END LOOP;

      RETURN GREATEST (d_ - 1, 0);
   END f_getnextdat;

-- *******************************************************************************
--             для f_getnextdat
--            НЕ ВИКОРИСТОВУЄТЬСЯ
-- *******************************************************************************
   FUNCTION get_par (par_ NUMBER)
      RETURN VARCHAR2
   IS
   BEGIN
      IF par_ = 1
      THEN                                              -- дата начала аренды
         RETURN TO_CHAR (d1_, 'dd.mm.yyyy');
      ELSIF par_ = 2
      THEN                                                -- дата конца аренды
         RETURN TO_CHAR (d2_, 'dd.mm.yyyy');
      ELSIF par_ = 3
      THEN                                                             -- дней
         RETURN days_;
      ELSIF par_ = 4
      THEN                                                          -- месяцев
         RETURN months_;
      ELSIF par_ = 5
      THEN                                                   -- тарифф месяцев
         RETURN monthstariff_;
      ELSIF par_ = 6
      THEN                                                      -- тарифф дней
         RETURN daystariff_;
      ELSIF par_ = 7
      THEN                                                   -- процент скидки
         RETURN proc_;
      ELSIF par_ = 8
      THEN                                           -- тариф с НДС без скидки
         RETURN tariff_;
      ELSIF par_ = 9
      THEN                                           -- тариф с НДС без скидки
         RETURN tariff2_;
      ELSIF par_ = 10
      THEN                                           -- тариф с НДС со скидкой
         RETURN tariff3_;
      ELSIF par_ = 11
      THEN                                           -- доход текущего периода
         RETURN scperiod_;
      ELSIF par_ = 12
      THEN                                                       -- код тарифа
         RETURN tcode_;

    ELSIF par_ = 13
      THEN            -- тобо
     RETURN branch_;
      END IF;

      RETURN 0;
   END get_par;

-- *******************************************************************************
--        Розрахунок тарифу по договору за період
-- *******************************************************************************
   PROCEDURE p_calcperiod_tariff (dat1_ DATE, dat2_ DATE, nd_ NUMBER, par_ NUMBER default null)
   IS
   l_tarif_ number;
   tipt_ number;
   BEGIN

          SELECT n.s_arenda, n.sd, n.dat_end - n.dat_begin + 1, n.prskidka, n.peny, tariff
            INTO st_, sd1_, dni1_, prsc_, peny_, l_tarif_
            FROM skrynka_nd n
           WHERE nd = nd_;

        begin
           SELECT tip
            INTO tipt_
            FROM skrynka_tariff st
           WHERE st.tariff = l_tarif_;
        exception when no_data_found then tipt_ :=2;
        end;

        if tipt_ = 2
        then
          -- sopl_ := f_get_opl_sum (nd_);
          SELECT LAST_DAY (dat1_)
            INTO datk_
            FROM DUAL;

          -- срок оплаты в днях
          IF dat2_ < dat1_
          THEN
            dni4_ := 0;
             --dni4_ := 1;
          ELSE
             dni4_ := dat2_ - dat1_ + 1;
          END IF;

          -- дней от начала периода до последнего календарного дня в месяце
          -- даты начала периода
          IF datk_ > dat2_
          THEN dni2_ := dni4_;
          ELSE dni2_ := datk_ - dat1_ + 1;
          END IF;

          -- если банковская дата <= дата начала периода вся сумма - доходы будующих периодов
          IF TO_CHAR (bankdate, 'YYYYMM') < TO_CHAR (dat1_, 'YYYYMM')
          THEN
             dni2_ := 0;
             datk_ := NULL;
          END IF;

          -- дней будущего периода
          dni3_     := dni4_ - dni2_;
          sb1_      := ROUND (dni4_ * sd1_ * (1 - prsc_ / 100));
          snds1_    := ROUND (sb1_ * (1 - 1 / (1 + nds_ / 100)));
          sb2_      := sb1_ - snds1_;
          if dni4_ = 0
          then sc1_ := 0;
          else sc1_ := ROUND (sb2_ * dni2_ / dni4_);
          end if;
          sf1_ := sb1_ - snds1_ - sc1_;

        elsif tipt_ = 1
        then
          if nd_ is not null
          then
            select *
              into skrnd_
              from skrynka_nd
             where nd = nd_;
          end if;

         skrn.p_tariff (skrnd_.tariff, skrnd_.dat_begin, skrnd_.dat_end, skrnd_.dat_begin );

      sb1_:=round(l_monts_*100 *     (MONTHS_BETWEEN(dat2_,dat1_)));
        else null;
        end if;

   END;

-- *******************************************************************************
--                Застава
--            Тільки по відкритих договорах
-- *******************************************************************************
   PROCEDURE p_oper_zalog (
      dat_    DATE,
      dat2_   DATE,
      n_sk_   NUMBER,
      mode_   NUMBER,
      par_    NUMBER DEFAULT NULL,
    p_userid NUMBER DEFAULT NULL,
    p_sum   NUMBER DEFAULT NULL
   )
   IS
    l_userid number;
   BEGIN
      if p_userid is null
      then l_userid := userid_;
    else  l_userid := p_userid;
    end if;
      -- cумма залога
      sz_ := NVL (skrnd_.sdoc, 0);

    if nvl(p_sum ,0) != 0
         then sz_ := nvl(p_sum ,0);
    end if;

      IF sz_ = 0
      THEN
     bars_error.raise_nerror(l_mod, 'ZERO_BAIL_SUM', n_sk_);
      END IF;

      IF skr_.keyused = 1 AND mode_ = 15
      THEN
     bars_error.raise_nerror(l_mod, 'KEY_GIVEN', n_sk_);
      ELSIF skr_.keyused = 0 AND mode_ = 16
      THEN
     bars_error.raise_nerror(l_mod, 'KEY_RETURNED', n_sk_);
      END IF;

    -- Працюємо з індивідуальними рахунками по кожному сейфу
        /*
    select a.nms, a.nls, a.ostc
    into nms2909_, nls2909_,ostc2909_
    from skrynka_nd_acc s, accounts a, skrynka_nd n
    where s.tip = 'M' and s.nd = n.nd and s.acc = a.acc and n.n_sk = n_sk_ and n.sos = 0;

    select a.nms, a.nls
    into nms6119_, nls6119_
    from skrynka_nd_acc s, accounts a, skrynka_nd n
    where s.tip = 'C' and s.nd = n.nd and s.acc = a.acc and n.n_sk = n_sk_ and n.sos = 0;
        */
    select a.nms, a.nls
      into nms3600_, nls3600_
      from skrynka_nd_acc s, accounts a, skrynka_nd n
     where s.tip = 'D'
           and s.nd = n.nd
           and s.acc = a.acc
           and n.n_sk = n_sk_
           and n.sos = 0;
      -- обратить вниманме на то, что операции по кассе должны (для правильной печати тикетов)
      -- учитывать правильно ДК
      IF mode_ = 10
      THEN
         --
         nam_a_     := SUBSTR (nms2909_, 1, 38);
         mfoa_      := gl.amfo;
         nlsa_      := nls2909_;
         nam_b_     := SUBSTR(COALESCE (skrnd_.fio, skrnd_.nmk), 1, 38);
         mfob_      := gl.amfo;
         nlsb_      := nlskas_;
         okpob_     := f_ourokpo;
         -- okpob_ := skrnd_.okpo1;
            --
         nazn_      := 'Внесення застави за ключ, сейф № '  || TO_CHAR (skr_.snum)
                        || ' згідно договору № '            || TO_CHAR (skrnd_.ndoc)
                        || ' від '                          || TO_CHAR (skrnd_.docdate, 'dd.mm.yyyy')
                        || ', без ПДВ.';
         -- дебет реальный
         dk_ := 0;
      ELSIF mode_ = 12
      THEN
         nam_a_     := SUBSTR (nms2909_, 1, 38);
         nlsa_      := nls2909_;
         mfoa_      := gl.amfo;
         nam_b_     := SUBSTR(COALESCE (skrnd_.fio, skrnd_.nmk), 1, 38);
         nlsb_      := nlskas_;
         mfob_      := gl.amfo;
         okpob_     := f_ourokpo;
         -- okpob_ := skrnd_.okpo1;
         nazn_      := 'Повернення застави за ключ, сейф № '        || TO_CHAR (skr_.snum)
                        || ' в зв''язку з закінченням договору № '  || TO_CHAR (skrnd_.ndoc)
                        || ' від '                                  || TO_CHAR (skrnd_.docdate, 'dd.mm.yyyy')
                        || ', без ПДВ.';
         sz_        := ostc2909_;
         -- кредит реальный
         dk_        := 1;
      ELSIF mode_ = 13
      THEN
    BEGIN
         SELECT nms
           INTO nmskas_
           FROM accounts
          WHERE nls = skrnd_.nlsk AND kv = '980';
        EXCEPTION  WHEN NO_DATA_FOUND THEN
                    bars_error.raise_nerror(l_mod, 'NOT_NLK_CLIENT', n_sk_);
        -- Рахунок клієнта не заповнено або заповнено не вірно
        END;
         --
         nam_a_     := SUBSTR (nms2909_, 1, 38);
         nlsa_      := nls2909_;
         mfoa_      := gl.amfo;
         nlsb_      := skrnd_.nlsk;
         nam_b_     := SUBSTR (skrnd_.nmk, 1, 38);
         mfob_      := gl.amfo;
         --okpob_ := skrnd_.okpo1;
         okpob_     := f_ourokpo;
         nazn_      := 'Повернення застави за ключ, сейф № '                    || TO_CHAR (skr_.snum)
                        || ' в зв''язку з закінченням терміну дії договору № '  || TO_CHAR (skrnd_.ndoc)
                        || ' від '                                              || TO_CHAR (skrnd_.docdate, 'dd.mm.yyyy')
                        || ', без ПДВ.';
         nlskas_    := skrnd_.nlsk;
         sz_        := ostc2909_;
         dk_        := 1;
      ELSIF mode_ = 11
      THEN

     BEGIN
       SELECT nms,     ostc
         INTO nmskas_, sz_
         FROM accounts
        WHERE nls = skrnd_.nlsk
                AND kv = '980'
                AND kf = skrnd_.mfok;

       nlsa_  := skrnd_.nlsk;
       nam_a_ := nvl( SUBSTR (skrnd_.nmk, 1, 38) , substr(nmskas_,1,38) );
       mfoa_  := gl.amfo;
       okpoa_ := skrnd_.okpo1;
       sz_    := NVL (skrnd_.sdoc, 0);
     EXCEPTION WHEN NO_DATA_FOUND
                   THEN bars_error.raise_nerror(l_mod, 'NOT_NLK_CLIENT', n_sk_);
                        -- Рахунок клієнта не заповнено або заповнено не вірно
                        -- Ненайшли рахунок можна поругатись!! але покищо нічого робить не будем.
                        -- Невірний рахунок або рахунок іншого банку. Що робить????
                    sz_ := 0;
     END;

        --
         nam_b_     := SUBSTR (nms2909_, 1, 38);
         nlsb_      := nls2909_;
         mfob_      := gl.amfo;
         okpob_     := f_ourokpo;
         nazn_      := 'Внесення застави за ключ, сейф № '          || TO_CHAR (skr_.snum)
                        || ' згідно  договору № '                   || TO_CHAR (skrnd_.ndoc)
                        || ' від '                                  || TO_CHAR (skrnd_.docdate, 'dd.mm.yyyy')
                        || ', без ПДВ.';
         nlskas_    := skrnd_.nlsk;
         dk_        := 1;
      END IF;


      -- ДОКУМЕНТ 1 внесение залога
      IF sz_ <> 0
      THEN
         gl.REF (ref_);

         INSERT INTO oper
                     (REF, tt, vob, nd, dk, pdat, vdat,
                      datd, datp, nam_a, nlsa, mfoa, kv, s,
                      nam_b, nlsb, mfob, kv2, s2, nazn, userid,
                      id_a, id_b, sk)
              VALUES (ref_, tt_, vob_, substr(ref_,4,10), dk_, SYSDATE, bankdate_,
                      SYSDATE, bankdate_, nam_a_, nlsa_, mfoa_, kv_, sz_,
                      nam_b_, nlsb_, mfob_, kv_, sz_, nazn_, l_userid,
                      okpoa_, okpob_, sk_);

         -- внесение залога
         gl.payv (0,ref_,bankdate_,tt_,dk_,kv_,nlsa_,sz_,kv_,nlsb_,sz_);

         IF ref_ IS NOT NULL
         THEN
            INSERT INTO skrynka_nd_ref(REF, bdate, nd)
                 VALUES (ref_, bankdate_, skrnd_.nd);
     END IF;

         IF NVL (skrnd_.custtype, 3) = 3
         THEN operw_fl (ref_);
         ELSE operw_ul (ref_);
         END IF;
      END IF;

        -- якщо вказаується сума застави(різниці) операції з ключом не проводимо.
    if nvl(p_sum ,0) != 0
         then return;
    end if;

      -- ДОКУМЕНТ 2 выдача ключа
      IF NVL (skrnpar3_, 0) = 0
      THEN
         gl.REF (ref_);
      END IF;

      sk_ := NULL;

      IF mode_ = 10 OR  mode_ = 11
      THEN
         nam_a_     := SUBSTR (nms9898_, 1, 38);
         nlsa_      := nls9898_;
         mfoa_      := gl.amfo;
         nam_b_     := SUBSTR (nms9819_, 1, 38);
         nlsb_      := nls9819_;
         mfob_      := gl.amfo;
         nazn_      := 'Видача ключа № '        || skr_.keynumber
                        || ', сейф № '          || TO_CHAR (skr_.snum)
                        || ' згідно угоди № '   || TO_CHAR (skrnd_.ndoc)
                        || ' від '              || TO_CHAR (skrnd_.docdate, 'dd.mm.yyyy')
                        || '.';
         dk_        := 1;
      ELSIF mode_ = 12
      THEN
         nam_b_     := SUBSTR (nms9898_, 1, 38);
         nam_a_     := SUBSTR (nms9819_, 1, 38);
         nlsb_      := nls9898_;
         nlsa_      := nls9819_;
         mfoa_      := gl.amfo;
         mfob_      := gl.amfo;
         nazn_      := 'Повернення ключа № '    || skr_.keynumber
                        || ', сейф № '          || TO_CHAR (skr_.snum)
                        || ' в зв''язку з закінченням терміну дії угоди № ' || TO_CHAR (skrnd_.ndoc)
                        || ' від '              || TO_CHAR (skrnd_.docdate, 'dd.mm.yyyy')
                        || '.';
         dk_        := 1;
      ELSIF mode_ = 13
      THEN
         nam_b_     := SUBSTR (nms9898_, 1, 38);
         nam_a_     := SUBSTR (nms9819_, 1, 38);
         nlsb_      := nls9898_;
         nlsa_      := nls9819_;
         mfoa_      := gl.amfo;
         mfob_      := gl.amfo;
         nazn_      := 'Повернення ключа № '            || skr_.keynumber
                        || ', сейф № '                  || TO_CHAR (skr_.snum)
                        || ' в зв''язку з закінченням терміну дії угоди № '     || TO_CHAR (skrnd_.ndoc)
                        || ' від '                      || TO_CHAR (skrnd_.docdate, 'dd.mm.yyyy')
                        || '.';
         dk_        := 1;
      END IF;

      -- ведем учет если клиенту выдан 1 ключ
      IF skrnd_.keycount > 0 AND ref_ IS NOT NULL AND tt2_ is not null
      THEN
         IF NVL (skrnpar3_, 0) = 0
         THEN
            INSERT INTO oper
                        (REF, tt, vob, nd, dk, pdat, vdat,
                         datd, datp, nam_a, nlsa, mfoa, kv,
                         s, nam_b, nlsb, mfob, kv2, s2, nazn,
                         userid, id_a, id_b, sk)
                 VALUES (ref_, tt2_, vob2_, substr(ref_,4,10), dk_, SYSDATE, bankdate_,
                         bankdate_, bankdate_, nam_a_, nlsa_, mfoa_, kv_,
                         100 * skrnd_.keycount, nam_b_, nlsb_, mfob_, kv_, 100 * skrnd_.keycount, nazn_,
                         l_userid, okpoa_, okpob_, sk_);
         END IF;

         -- внесение залога
         gl.payv (0,ref_, bankdate_, tt2_, dk_, kv_, nlsa_, 100 * skrnd_.keycount, kv_, nlsb_, 100 * skrnd_.keycount);

         IF NVL (skrnpar3_, 0) = 0
         THEN
            operw_vnebal (ref_);
         END IF;
      END IF;

      IF     ref_ IS NOT NULL
        AND NVL (skrnpar3_, 0) = 0
        AND skrnd_.keycount > 0
        AND tt2_ is not null
      THEN
            INSERT INTO skrynka_nd_ref(REF, bdate, nd)
                 VALUES (ref_, bankdate_, skrnd_.nd);
      END IF;

      IF mode_ IN ('10', '11') AND skrnd_.keycount > 0
      THEN
         UPDATE skrynka
            SET keyused = 1
          WHERE n_sk = n_sk_;
      ELSIF mode_ IN ('12', '13') AND skrnd_.keycount > 0
      THEN
         UPDATE skrynka
            SET keyused = 0
          WHERE n_sk = n_sk_;
      END IF;

--Рорзрахунок і створення документів по погашенню прострочки та пені
    IF     mode_ IN ('12', '13')
        AND skrnd_.dat_end < gl.bdate
      THEN

        SELECT tt, tt2, tt3, NAME, sk, NVL (vob, 6), NVL (vob2, 6),NVL (vob3, 6)
          INTO tt_, tt2_, tt3_, itemname_, sk_, vob_, vob2_,vob3_
          FROM skrynka_menu
         WHERE item = decode(mode_, 12, 14, 13, 15, 14)
           and kf = sys_context('bars_context','user_mfo');

    overdue_payment(trunc(sysdate), trunc(sysdate)+(skrnd_.dat_end-skrnd_.dat_begin), n_sk_, (case when mode_= 12 then 14 else 15 end), par_);
      END IF;

   END;

-- *******************************************************************************
--          Взяття орендної плати за період
-- *******************************************************************************
  PROCEDURE p_oper_arenda_period (dat_    IN DATE,
                                  dat2_   IN DATE,
                                  n_sk_   IN NUMBER,
                                  mode_   IN NUMBER,
                                  par_    IN NUMBER DEFAULT NULL)
   IS
  new_ref_flag    NUMBER := 0;
  nmsnls_         accounts.nms%type;
   BEGIN
    -- Працюємо з індивідуальними рахунками по кожному сейфу
        /*
    select a.nms, a.nls, a.ostc
    into nms2909_, nls2909_,ostc2909_
    from skrynka_nd_acc s, accounts a, skrynka_nd n
    where s.tip = 'M' and s.nd = n.nd and s.acc = a.acc and n.n_sk = n_sk_ and n.sos = 0;

    select a.nms, a.nls
    into nms6119_, nls6119_
    from skrynka_nd_acc s, accounts a, skrynka_nd n
    where s.tip = 'C' and s.nd = n.nd and s.acc = a.acc and n.n_sk = n_sk_ and n.sos = 0;
        */
    if par_ is not null
        then
      select a.nms, a.nls
          into nms3600_, nls3600_
        from skrynka_nd_acc s, accounts a, skrynka_nd n
       where s.tip = 'D'
               and s.nd = n.nd
               and s.acc = a.acc
               and n.nd = par_;
    else
      select a.nms, a.nls
        into nms3600_, nls3600_
        from skrynka_nd_acc s, accounts a, skrynka_nd n
       where s.tip = 'D'
               and s.nd = n.nd
               and s.acc = a.acc
               and n.n_sk = n_sk_
               and n.sos = 0;
    end if;

    -- сюди передаємо сист. номер договору при пролонгації
    if par_ is not null
      then
        SELECT *
          INTO skrnd_
          FROM skrynka_nd
         WHERE nd = par_;
    end if;

      -- расчет суммы аренды полностью определяется
      -- суммой аренды в карточке и количеством календарных дней срока
      skrn.p_calcperiod_tariff (dat_, dat2_, skrnd_.nd, par_);

      -- доход текущего периода умножаем на количество введенных месяцев
      IF sb1_ = 0
      THEN bars_error.raise_nerror(l_mod, 'ZERO_RENT_SKR', n_sk_);
      END IF;


      IF mode_ = 15
      THEN
        BEGIN
         SELECT nms
           INTO nmsnls_
           FROM accounts
          WHERE nls = skrnd_.nlsk
            AND kv = '980'
            AND kf = skrnd_.mfok;
        EXCEPTION WHEN NO_DATA_FOUND
                  THEN nmsnls_ := null;
                       bars_error.raise_nerror(l_mod, 'NOT_NLK_CLIENT', n_sk_);
        END;
      END IF;
     -- для 15 - немає проводку на касу
      IF mode_ != 15 or (skrnd_.mfok = f_ourmfo and nmsnls_ is not null)
      THEN
    -- ОПЕРАЦИЯ № 1 - КАССА

         gl.REF (ref_);
         nam_a_     := SUBSTR (nmss2909_, 1, 38);
         nlsa_      := nlss2909_;
       --nam_a_ := SUBSTR(COALESCE (skrnd_.fio, skrnd_.nmk), 1, 38);

     IF mode_ != 15
         THEN
        nam_a_    := SUBSTR (nmss2909_, 1, 38);
          nlsa_     := nlss2909_;
          nlsb_     := nlskas_;
          okpob_    := f_ourokpo;
          nam_b_    := SUBSTR (nmskas_, 1, 38);
          dk_       := 0;
       ELSE
          nlsa_     := skrnd_.nlsk;
          okpoa_    := skrnd_.okpo1;
          nam_a_    := SUBSTR(nmsnls_, 1, 38);
          nam_b_    := SUBSTR (nmss2909_, 1, 38);
          nlsb_     := nlss2909_;
          dk_       := 1;
     END IF;
     mfoa_  := gl.amfo;
     mfob_  := gl.amfo;

     nam_b_ := nvl(SUBSTR(skrnd_.fio, 1, 38),SUBSTR(skrnd_.nmk, 1, 38)) ;------ COBUSUPABS-6028 13.06.2017
     nazn_  := 'Орендна плата за користування сейфом № '    || TO_CHAR (skr_.snum)
              || ' за період з '                          || TO_CHAR (dat_, 'dd.mm.yyyy')
              || 'р. по '                                 || TO_CHAR (dat2_, 'dd.mm.yyyy')
              || 'р., згідно Договору № '                 || skrnd_.ndoc
              || ' від '                                  || TO_CHAR (skrnd_.docdate, 'dd.mm.yyyy')
              || 'р.';

         IF skrnpar1_ = 0
         THEN
             nazn_ := SUBSTR (   nazn_ || ' В т.ч. ПДВ ' || TRIM (TO_CHAR (snds1_ / 100, '9999999990.00')) || ' грн.', 1, 160);
          ELSE
             nazn_ := nazn_ || '.';
         END IF;


        gl.in_doc3 (ref_,tt_,vob_,substr(ref_,4,10),SYSDATE,bankdate_,dk_,kv_,sb1_,kv_,sb1_,sk_,SYSDATE,bankdate_,
      nam_a_,nlsa_,mfoa_,nam_b_,nlsb_,mfob_,nazn_,NULL,okpoa_,okpob_,NULL,NULL,0,NULL,null);

        -- сумма с НДС
        gl.payv (0,ref_,bankdate_,tt_,dk_,kv_,nlsa_,sb1_,kv_,nlsb_,tariff3_);

        IF NVL (skrnd_.custtype, 3) = 3
        THEN operw_fl (ref_);
        ELSE operw_ul (ref_);
        END IF;

        IF ref_ IS NOT NULL
        THEN
        -- проставляємо хоч якусь ознаку, для подальшої роботи з котловими рахунками
        INSERT INTO skrynka_nd_ref(REF, bdate, nd, rent)
           VALUES (ref_, bankdate_, skrnd_.nd, 1);
      END IF;
   END IF;

      -- ОПЕРАЦИЯ № 2 - ОПЕРУ - доходы текущего периода
      -- если дата операции <= дата окончания договора все на будущие периоды
      -- olddat2_ < bankdate условие того, что процедура расчета новой аренды
      -- вызвана из процедуры просрочки т.е. что клиент пришел после окончания
      -- срока старой аренды
     IF mode_ = 15 AND ref_ is null
     THEN new_ref_flag := 1;
   END IF;

   IF sc1_ IS NOT NULL AND sc1_ > 0 AND nls6519_ IS NOT NULL
     THEN
         IF (new_ref_flag = 1) OR NVL (skrnpar3_, 0) = 0
         THEN
            gl.REF (ref_);
         END IF;

         sk_    := NULL;
         nam_a_ := SUBSTR (nmss2909_, 1, 38);
         nam_b_ := SUBSTR (nms6519_, 1, 38);
     IF mode_ = 15
         then
      nazn_ := 'Орендна плата за користування сейфом № '      || TO_CHAR (skr_.snum)
                  || ' за період з '                          || TO_CHAR (dat_, 'dd.mm.yyyy')
                  || 'р. по '                                 || TO_CHAR (dat2_, 'dd.mm.yyyy')
                  || 'р., згідно Договору № '                 || skrnd_.ndoc
                  || ' від '                                  || TO_CHAR (skrnd_.docdate, 'dd.mm.yyyy')
                  || 'р.';
      IF skrnpar1_ = 0
      THEN nazn_ := SUBSTR (nazn_ || ' В т.ч. ПДВ ' || TRIM (TO_CHAR (snds1_ / 100, '9999999990.00')) || ' грн.', 1, 160);
      ELSE nazn_ := nazn_ || '.';
      END IF;
     else
          nazn_ := 'Орендна плата за користування сейфом № '      || TO_CHAR (skr_.snum)
                      || ' за період з '                          || TO_CHAR (dat_, 'dd.mm.yyyy')
                      || ' по '                                   || TO_CHAR (datk_, 'dd.mm.yyyy')
                      || ', згідно Договору № '                 || TO_CHAR (skrnd_.ndoc)
                      || ' від '                                || TO_CHAR (skrnd_.docdate, 'dd.mm.yyyy')
                      || '.';
     end if;
         dk_    := 1;

         IF (new_ref_flag = 1) OR NVL (skrnpar3_, 0) = 0
         THEN
      new_ref_flag := 0;
            INSERT INTO oper
                        (REF, tt, vob, nd, dk, pdat, vdat,
                         datd, datp, nam_a, nlsa, mfoa,
                         kv, s, nam_b, nlsb, mfob, kv2, s2,
                         nazn, userid, id_a, id_b, sk)
                 VALUES (ref_, tt2_, vob2_, substr(ref_,4,10), dk_, SYSDATE, bankdate_,
                         bankdate_, bankdate_, nam_a_, nlss2909_, mfoa_,
                         kv_, sc1_, nam_b_, nls6519_, mfob_, kv_, sc1_,
                         nazn_, userid_, okpoa_, okpob_, sk_);
         END IF;

         gl.payv (0,ref_,bankdate_,tt2_,dk_,kv_,nlss2909_,sc1_,kv_,nls6519_,scperiod_);

         IF ref_ IS NOT NULL AND ((mode_ = 15 and nmsnls_ is null) OR NVL (skrnpar3_, 0) = 0)
         THEN
      -- проставляємо хоч якусь ознаку, для подальшої роботи з котловими рахунками
      INSERT INTO skrynka_nd_ref(REF, bdate, nd, rent)
         VALUES (ref_, bankdate_, skrnd_.nd, 1);
     END IF;

     update skrynka_nd
            set amort_date = least(datk_,dat2_)
      where nd = par_;
      --ELSE
      --   scperiod_ := 0;
      END IF;

      --sfperiod_ := tariff2_ - scperiod_;

      -- ОПЕРАЦИЯ № 3 - ОПЕРУ - доходы будущего периода
      IF sf1_ > 0 AND sf1_ IS NOT NULL AND nls3600_ IS NOT NULL
      THEN
         IF (new_ref_flag = 1) OR NVL (skrnpar3_, 0) = 0
         THEN
            gl.REF (ref_);
         END IF;

         sk_    := NULL;
         nam_a_ := SUBSTR (nmss2909_, 1, 38);
         nam_b_ := SUBSTR (nms3600_, 1, 38);

         IF scperiod_ <> 0
         THEN
            nazn_ := 'Орендна плата за користування сейфом № '      || TO_CHAR (skr_.snum)
                        || ' за період з '                          || TO_CHAR (datk_ + 1, 'dd.mm.yyyy')
                        || ' по '                                   || TO_CHAR (dat2_, 'dd.mm.yyyy')
                        || ', згідно Договору № '                   || TO_CHAR (skrnd_.ndoc)
                        || ' від '                                  || TO_CHAR (skrnd_.docdate, 'dd.mm.yyyy')
                        || '.';
         ELSE
            nazn_ := 'Орендна плата за користування сейфом № '      || TO_CHAR (skr_.snum)
                        || ' за період з '                          || TO_CHAR (dat_, 'dd.mm.yyyy')
                        || ' по '                                   || TO_CHAR (dat2_, 'dd.mm.yyyy')
                        || ', згідно Договору № '                   || TO_CHAR (skrnd_.ndoc)
                        || ' від '                                  || TO_CHAR (skrnd_.docdate, 'dd.mm.yyyy')
                        || '.';
         END IF;

    if new_ref_flag = 1
        then
      nazn_ := 'Орендна плата за користування сейфом № '      || TO_CHAR (skr_.snum)
                  || ' за період з '                          || TO_CHAR (dat_, 'dd.mm.yyyy')
                  || 'р. по '                                 || TO_CHAR (dat2_, 'dd.mm.yyyy')
                  || 'р., згідно Договору № '                 || skrnd_.ndoc
                  || ' від '                                  || TO_CHAR (skrnd_.docdate, 'dd.mm.yyyy')
                  || 'р.';
      IF skrnpar1_ = 0
      THEN
       nazn_ := SUBSTR (nazn_ || ' В т.ч. ПДВ ' || TRIM (TO_CHAR (snds1_ / 100, '9999999990.00'))|| ' грн.',1,160);
            ELSE
       nazn_ := nazn_ || '.';
      END IF;
    END IF;

        dk_ := 1;

        IF (new_ref_flag = 1) OR NVL (skrnpar3_, 0) = 0
        THEN
     new_ref_flag := 0;
           INSERT INTO oper
                        (REF, tt, vob, nd, dk, pdat, vdat,
                         datd, datp, nam_a, nlsa, mfoa,
                         kv, s, nam_b, nlsb, mfob, kv2, s2,
                         nazn, userid, id_a, id_b, sk)
                 VALUES (ref_, tt3_, vob3_, substr(ref_,4,10), dk_, SYSDATE, bankdate_,
                         bankdate_, bankdate_, nam_a_, nlss2909_, mfoa_,
                         kv_, sf1_, nam_b_, nls3600_, mfob_, kv_, sf1_,
                         nazn_, userid_, okpoa_, okpob_, sk_);
        END IF;

        -- доходы будущего периода
         IF nvl(sf1_,0) > 0
         THEN  gl.payv (0,ref_,bankdate_,tt3_,dk_,kv_,nlss2909_,sf1_,kv_,nls3600_,sfperiod_);
         END IF;

         IF ref_ IS NOT NULL AND NVL (skrnpar3_, 0) = 0
         THEN
            -- проставляємо хоч якусь ознаку, для подальшої роботи з котловими рахунками
            INSERT INTO skrynka_nd_ref(REF, bdate, nd, rent)
                 VALUES (ref_, bankdate_, skrnd_.nd, 1);
         END IF;
      --END IF;
      END IF;

      -- ОПЕРАЦИЯ № 4 - ОПЕРУ - списание НДС
      IF nlsnds_ IS NOT NULL AND snds1_ IS NOT NULL AND snds1_ > 0
      THEN
         IF NVL (skrnpar3_, 0) = 0
         THEN
            gl.REF (ref_);
         END IF;

         sk_    := NULL;
         nam_a_ := SUBSTR (nmss2909_, 1, 38);
         nam_b_ := SUBSTR (nmsnds_, 1, 38);
         nazn_  := 'ПДВ за користування сейфом № '      || TO_CHAR (skr_.snum)
                    || ' за період з '                  || TO_CHAR (dat_, 'dd.mm.yyyy')
                    || ' по '                           || TO_CHAR (dat2_, 'dd.mm.yyyy')
                    || ', згідно Договору № '           || TO_CHAR (skrnd_.ndoc)
                    || ' про надання в оренду індивідуального  від '    || TO_CHAR (skrnd_.docdate, 'dd.mm.yyyy')
                    || '.';
         dk_   := 1;

         IF NVL (skrnpar3_, 0) = 0
         THEN
            INSERT INTO oper
                        (REF, tt, vob, nd, dk, pdat, vdat,
                         datd, datp, nam_a, nlsa, mfoa,
                         kv, s, nam_b, nlsb, mfob, kv2, s2,
                         nazn, userid, id_a, id_b, sk)
                 VALUES (ref_, tt3_, vob3_, substr(ref_,4,10), dk_, SYSDATE, bankdate_,
                         bankdate_, bankdate_, nam_a_, nlss2909_, mfoa_,
                         kv_, snds1_, nam_b_, nlsnds_, mfob_, kv_, snds1_,
                         nazn_, userid_, okpoa_, okpob_, sk_);
         END IF;

         -- доходы будущего периода
         gl.payv (0,ref_,bankdate_,tt3_,dk_,kv_,nlss2909_,snds1_,kv_,nlsnds_,snds1_);

         IF ref_ IS NOT NULL AND NVL (skrnpar3_, 0) = 0
         THEN
      -- проставляємо хоч якусь ознаку, для подальшої роботи з котловими рахунками
      INSERT INTO skrynka_nd_ref(REF, bdate, nd, rent)
         VALUES (ref_, bankdate_, skrnd_.nd, 1);
     END IF;
      END IF;
   END;

-- *******************************************************************************
--            Взяття орендної плати
--  par_ = 1 - пролонгація
-- *******************************************************************************
 PROCEDURE p_oper_arenda (dat_    IN DATE,
                          dat2_   IN DATE,
                          n_sk_   IN NUMBER,
                          mode_   IN NUMBER,
                          par_    IN NUMBER DEFAULT NULL)
   IS
      tipt_         NUMBER;
    new_ref_flag  NUMBER := 0;
    nmsnls_       accounts.nms%type;
   BEGIN
   -- Працюємо з індивідуальними рахунками по кожному сейфу
        /*
    select a.nms, a.nls, a.ostc
    into nms2909_, nls2909_,ostc2909_
    from skrynka_nd_acc s, accounts a, skrynka_nd n
    where s.tip = 'M' and s.nd = n.nd and s.acc = a.acc and n.n_sk = n_sk_ and n.sos = 0;

    select a.nms, a.nls
    into nms6119_, nls6119_
    from skrynka_nd_acc s, accounts a, skrynka_nd n
    where s.tip = 'C' and s.nd = n.nd and s.acc = a.acc and n.n_sk = n_sk_ and n.sos = 0;
        */
    if par_ is not null
        then
      select a.nms, a.nls
        into nms3600_, nls3600_
        from skrynka_nd_acc s, accounts a, skrynka_nd n
       where s.tip = 'D'
               and s.nd = n.nd
               and s.acc = a.acc
               and n.nd = par_;
    else
      select a.nms, a.nls
        into nms3600_, nls3600_
        from skrynka_nd_acc s, accounts a, skrynka_nd n
       where s.tip = 'D'
               and s.nd = n.nd
               and s.acc = a.acc
               and n.n_sk = n_sk_
               and n.sos = 0;
    end if;

    -- сюди передаємо сист. номер договору при пролонгації
    if par_ is not null then
        SELECT *
          INTO skrnd_
          FROM skrynka_nd
         WHERE nd = par_;
    end if;

      SELECT tip
        INTO tipt_
        FROM skrynka_tariff st
       WHERE st.tariff = skrnd_.tariff;

      IF tipt_ = 2
      THEN
         p_calc_tariff (n_sk_, par_);
         p_oper_arenda_period (skrnd_.dat_begin,
                               skrnd_.dat_end,
                               n_sk_,
                               mode_,
                               par_);
      ELSE
         skrn.p_tariff (skrnd_.tariff,
                        skrnd_.dat_begin,
                        skrnd_.dat_end,
                        bankdate_);
         snds_ := tariff3_ - tariff2_;

         UPDATE skrynka_nd
            SET s_arenda = tariff3_,
                s_nds = snds_
          WHERE nd = skrnd_.nd;

         IF tariff3_ = 0
         THEN
      bars_error.raise_nerror(l_mod, 'ZERO_RENT', skrnd_.nd);
         END IF;

        BEGIN
           SELECT nms
             INTO nmsnls_
             FROM accounts
            WHERE nls = skrnd_.nlsk AND kv = '980' AND kf = skrnd_.mfok;
        EXCEPTION
           WHEN NO_DATA_FOUND
           THEN
              nmsnls_ := NULL;
        END;

     IF mode_ = 15
         THEN
            BEGIN
                 SELECT nms
                   INTO nmsnls_
                   FROM accounts
                  WHERE nls = skrnd_.nlsk
                    AND kv = '980'
                    AND kf = skrnd_.mfok;
            EXCEPTION WHEN NO_DATA_FOUND
                      THEN nmsnls_ := null;
                           bars_error.raise_nerror(l_mod, 'NOT_NLK_CLIENT', n_sk_);
            END;
     END IF;

     -- для 15 - немає проводку на касу
       IF mode_ != 15 or (skrnd_.mfok = f_ourmfo and nmsnls_ is not null)
         THEN
       -- ОПЕРАЦИЯ № 1 - КАССА
            gl.REF (ref_);
            nam_a_  := SUBSTR (nmss2909_, 1, 38);
            nlsa_   := nlss2909_;

      nam_b_  := SUBSTR(COALESCE (skrnd_.fio, skrnd_.nmk), 1, 38);

         if mode_ != 15
         then
            nlsb_  := nlskas_;
            okpob_ := f_ourokpo;
            dk_    := 0;
         else
            nlsa_  := skrnd_.nlsk;
            okpoa_ := skrnd_.okpo1;
            nam_a_ := SUBSTR(nmsnls_, 1, 38);
            nam_b_ := SUBSTR (nmss2909_, 1, 38);
            nlsb_  := nlss2909_;
            dk_    := 1;
         end if;
            mfoa_ := gl.amfo;
            mfob_ := gl.amfo;
            nazn_ := 'Орендна плата за користування сейфом № '     || TO_CHAR (skr_.snum)
                       || ' з '                                    || TO_CHAR (skrnd_.dat_begin, 'dd.mm.yyyy')
                       || ' по '                                   || TO_CHAR (skrnd_.dat_end, 'dd.mm.yyyy')
                       || ' , згідно договору № '                  || TO_CHAR (skrnd_.ndoc)
                       || ' від '                                  || TO_CHAR (skrnd_.docdate, 'dd.mm.yyyy');
        IF skrnpar1_ = 0
        THEN nazn_ := nazn_ || ', з ПДВ.';
        ELSE nazn_ := nazn_ || '.';
        END IF;

       --dk_ := 0;

      gl.in_doc3 (ref_,tt_,vob_,substr(ref_,4,10),SYSDATE,bankdate_,dk_,kv_,tariff3_,kv_,tariff3_,sk_,SYSDATE,bankdate_,
            nam_a_,nlsa_,mfoa_,nam_b_,nlsb_,mfob_,nazn_,NULL,okpoa_,okpob_,NULL,NULL,0,NULL,null);

           -- сумма с НДС
           gl.payv (0,ref_,bankdate_,tt_,dk_,kv_,nlsa_,tariff3_,kv_,nlsb_,tariff3_);

           IF NVL (skrnd_.custtype, 3) = 3
           THEN operw_fl (ref_);
           ELSE operw_ul (ref_);
           END IF;

           IF ref_ IS NOT NULL
           THEN
              INSERT INTO skrynka_nd_ref(REF, bdate, nd, rent)
                   VALUES (ref_, bankdate_, skrnd_.nd, 1);
           END IF;
       END IF;

         -- ОПЕРАЦИЯ № 2 - ОПЕРУ - доходы текущего периода
         -- если дата операции <= дата окончания договора все на будущие периоды
         -- olddat2_ < bankdate условие того, что процедура расчета новой аренды
         -- вызвана из процедуры просрочки т.е. что клиент пришел после окончания
         -- срока старой аренды
     if mode_ = 15 AND ref_ is null
         then
      new_ref_flag := 1;
     end if;

         IF olddat2_ <= bankdate OR olddat2_ IS NULL
         THEN
            IF scperiod_ <> 0
            THEN
               IF new_ref_flag = 1 OR NVL (skrnpar3_, 0) = 0
               THEN
                  gl.REF (ref_);
               END IF;

               --end if;
               sk_    := NULL;
               nam_a_ := SUBSTR (nmss2909_, 1, 38);
               nam_b_ := SUBSTR (nms6519_, 1, 38);
               okpob_ := f_ourokpo;
               nazn_  := 'Орендна плата за користування сейфом № '      || TO_CHAR (skr_.snum)
                            || ' з '                                    || TO_CHAR (skrnd_.dat_begin, 'dd.mm.yyyy')
                            || ' по '                                   || TO_CHAR (ADD_MONTHS (d1_, 1), 'dd.mm.yyyy')
                            || ' , згідно договору № '                  || TO_CHAR (skrnd_.ndoc)
                            || ' від '                                  || TO_CHAR (skrnd_.docdate, 'dd.mm.yyyy')
                            || ', без ПДВ.';
               dk_ := 1;

               IF (new_ref_flag = 1) OR  NVL (skrnpar3_, 0) = 0
               THEN
          new_ref_flag := 0;
                  INSERT INTO oper
                              (REF, tt, vob, nd, dk, pdat,
                               vdat, datd, datp, nam_a,
                               nlsa, mfoa, kv, s, nam_b,
                               nlsb, mfob, kv2, s2, nazn,
                               userid, id_a, id_b, sk)
                       VALUES (ref_, tt2_, vob2_, substr(ref_,4,10), dk_, SYSDATE,
                               bankdate_, bankdate_, bankdate_, nam_a_,
                               nlss2909_, mfoa_, kv_, scperiod_, nam_b_,
                               nls6519_, mfob_, kv_, scperiod_, nazn_,
                               userid_, okpoa_, okpob_, sk_);
               END IF;

               gl.payv (0,ref_,bankdate_,tt2_,dk_,kv_,nlss2909_,scperiod_,kv_,nls6519_,scperiod_);

               IF ref_ IS NOT NULL AND ((mode_ = 15 and nmsnls_ is null) OR NVL (skrnpar3_, 0) = 0)
               THEN
          -- проставляємо хоч якусь ознаку, для подальшої роботи з котловими рахунками
                INSERT INTO skrynka_nd_ref(REF, bdate, nd, rent)
                     VALUES (ref_, bankdate_, skrnd_.nd, 1);
               END IF;
            END IF;
         ELSE
            scperiod_ := 0;
         END IF;

         sfperiod_ := tariff2_ - scperiod_;

         -- ОПЕРАЦИЯ № 3 - ОПЕРУ - доходы будущего периода
         IF sfperiod_ > 0 or snds_ != 0
         THEN
            IF (new_ref_flag = 1) OR NVL (skrnpar3_, 0) = 0
            THEN
               gl.REF (ref_);
            END IF;

            sk_ := NULL;
            nam_a_ := SUBSTR (nmss2909_, 1, 38);
            nam_b_ := SUBSTR (nms3600_, 1, 38);
            okpob_ := f_ourokpo;

            IF scperiod_ <> 0
            THEN
               nazn_ :=
                     'Орендна плата за користування сейфом № '
                  || TO_CHAR (skr_.snum)
                  || ' з '
                  || TO_CHAR (ADD_MONTHS (d1_, 1) + 1, 'dd.mm.yyyy')
                  || ' по '
                  || TO_CHAR (skrnd_.dat_end, 'dd.mm.yyyy')
                  || ' , згідно договору № '
                  || TO_CHAR (skrnd_.ndoc)
                  || ' від '
                  || TO_CHAR (skrnd_.docdate, 'dd.mm.yyyy')
                  || ', без ПДВ.';
            ELSE
               nazn_ :=
                     'Орендна плата за користування сейфом № '
                  || TO_CHAR (skr_.snum)
                  || ' з '
                  || TO_CHAR (skrnd_.dat_begin, 'dd.mm.yyyy')
                  || ' по '
                  || TO_CHAR (skrnd_.dat_end, 'dd.mm.yyyy')
                  || ' , згідно договору № '
                  || TO_CHAR (skrnd_.ndoc)
                  || ' від '
                  || TO_CHAR (skrnd_.docdate, 'dd.mm.yyyy')
                  || ', без ПДВ.';
            END IF;

            dk_ := 1;

            IF (new_ref_flag = 1) OR NVL (skrnpar3_, 0) = 0
            THEN
         new_ref_flag := 0;
               INSERT INTO oper
                           (REF, tt, vob, nd, dk, pdat,
                            vdat, datd, datp, nam_a,
                            nlsa, mfoa, kv, s, nam_b,
                            nlsb, mfob, kv2, s2, nazn, userid,
                            id_a, id_b, sk
                           )
                    VALUES (ref_, tt3_, vob3_, substr(ref_,4,10), dk_, SYSDATE,
                            bankdate_, bankdate_, bankdate_, nam_a_,
                            nlss2909_, mfoa_, kv_, sfperiod_, nam_b_,
                            nls3600_, mfob_, kv_, sfperiod_, nazn_, userid_,
                            okpoa_, okpob_, sk_
                           );
            END IF;

            -- доходы будущего периода
            gl.payv (0,ref_,bankdate_,tt3_,dk_,kv_,nlss2909_,sfperiod_,kv_,nls3600_,sfperiod_);

            IF ref_ IS NOT NULL AND NVL (skrnpar3_, 0) = 0
            THEN
        -- проставляємо хоч якусь ознаку, для подальшої роботи з котловими рахунками
        INSERT INTO skrynka_nd_ref(REF, bdate, nd, rent)
           VALUES (ref_, bankdate_, skrnd_.nd, 1);
      END IF;

            -- ОПЕРАЦИЯ № 4 - ОПЕРУ - списание НДС
            IF (snds_ > 0)
            THEN
            IF nlsnds_ IS NOT NULL
            THEN
               IF NVL (skrnpar3_, 0) = 0
               THEN
                  gl.REF (ref_);
               END IF;

               sk_    := NULL;
               nam_a_ := SUBSTR (nmss2909_, 1, 38);
               nam_b_ := SUBSTR (nmsnds_, 1, 38);
               okpob_ := f_ourokpo;
               nazn_ :=
                     'ПДВ за користування сейфом № '
                  || TO_CHAR (skr_.snum)
                  || ' з '
                  || TO_CHAR (ADD_MONTHS (d1_, 1) + 1, 'dd.mm.yyyy')
                  || ' по '
                  || TO_CHAR (skrnd_.dat_end, 'dd.mm.yyyy')
                  || ' , згідно договору № '
                  || TO_CHAR (skrnd_.ndoc)
                  || ' від '
                  || TO_CHAR (skrnd_.docdate, 'dd.mm.yyyy')
                  || '.';
               dk_ := 1;

               IF NVL (skrnpar3_, 0) = 0
               THEN
                  INSERT INTO oper
                              (REF, tt, vob, nd, dk, pdat,
                               vdat, datd, datp, nam_a,
                               nlsa, mfoa, kv, s, nam_b,
                               nlsb, mfob, kv2, s2, nazn, userid,
                               id_a, id_b, sk
                              )
                       VALUES (ref_, tt3_, vob3_, substr(ref_,4,10), dk_, SYSDATE,
                               bankdate_, bankdate_, bankdate_, nam_a_,
                               nlss2909_, mfoa_, kv_, snds_, nam_b_,
                               nlsnds_, mfob_, kv_, snds_, nazn_, userid_,
                               okpoa_, okpob_, sk_
                              );
               END IF;

               -- доходы будущего периода
               gl.payv (0,ref_,bankdate_,tt3_,dk_,kv_,nlss2909_,snds_,kv_,nlsnds_,snds_);

               IF ref_ IS NOT NULL AND NVL (skrnpar3_, 0) = 0
               THEN
          -- проставляємо хоч якусь ознаку, для подальшої роботи з котловими рахунками
                INSERT INTO skrynka_nd_ref(REF, bdate, nd, rent)
                     VALUES (ref_, bankdate_, skrnd_.nd, 1);
                END IF;
              END IF;
            END IF;
         END IF;
      END IF;
   END;

-- *******************************************************************************
--            Оплата прострочки
--    par_ == nd
-- *******************************************************************************
PROCEDURE overdue_payment (dat_    IN DATE,
                           dat2_   IN DATE,
                           n_sk_   IN NUMBER,
                           mode_   IN NUMBER,
                           par_    IN NUMBER)
IS
      tipt_   NUMBER;
      dpr_    NUMBER;
    nTmp    INTEGER;
    nAcc    NUMBER(38);
    nSND    NUMBER(38);
    nlsk_  skrynka_nd.nlsk%type;
    mfok_  skrynka_nd.mfok%type;
    nmk_   skrynka_nd.nmk%type;
    nmsnls_  accounts.nms%type;
    l_count int;
      l_dat   date;
    ob22_ SPECPARAM_INT.OB22%type;      -- ob22
  begin
    -- якщо некоректні дати - нічого не робимо
    IF dat_+1 <= skrnd_.dat_end OR dat2_ < dat_
      THEN
    bars_error.raise_nerror(l_mod, 'PROLONG_DATES_ERROR', par_);
      END IF;

    -- Працюємо з індивідуальними рахунками по кожному сейфу

    SELECT a.nms,
           a.nls,
           n.nlsk,
           n.mfok,
           n.nmk
      INTO nms3600_,
           nls3600_,
           nlsk_,
           mfok_,
           nmk_
      FROM skrynka_nd_acc s, accounts a, skrynka_nd n
     WHERE s.tip = 'D' AND s.nd = n.nd AND s.acc = a.acc AND n.nd = par_;

     l_dat := skrnd_.dat_end;

    -- якщо дата закриття припадає на вихідний день, то її рахуємо як перший робочий день
    SELECT COUNT (fdat), MIN (fdat)
      INTO l_count, l_dat
      FROM fdat
     WHERE fdat BETWEEN skrnd_.dat_end
       AND TRUNC (SYSDATE);

    IF l_count = 1
    THEN l_dat := l_dat;
    ELSE l_dat := skrnd_.dat_end;
    END IF;

    IF skrnd_.imported = 1
    then
    s_ := GREATEST ((1 + skrnd_.peny/100/365) * skrnd_.sd * (dat_ - l_dat ), 0);
  else
      SELECT tip
        INTO tipt_
        FROM skrynka_tariff st
       WHERE st.tariff = skrnd_.tariff;

      skrn.p_tariff (skrnd_.tariff, dat_, dat2_, bankdate_);

      -- сумма просрочки
      IF tipt_ = 1
      THEN
         s_ := GREATEST (100 * peny_ * (dat_ - l_dat ), 0);
      ELSIF tipt_ = 2
      THEN


     -- пеня за прострочений період SBER
    dpr_ := GREATEST (dat_ - l_dat , 0);
    s_ := skrnd_.sd* dpr_;

      END IF;

  END IF;

    if mode_ = 17
    then
     BEGIN
         SELECT nms
           INTO nmskas_
           FROM accounts
          WHERE nls = skrnd_.nlsk
            AND kv = '980'
            AND kf = skrnd_.mfok;
     EXCEPTION WHEN NO_DATA_FOUND
               THEN bars_error.raise_nerror(l_mod, 'NOT_NLK_CLIENT', n_sk_);
                    -- Рахунок клієнта не заповнено або заповнено не вірно
     END;
    end if;


  IF NVL (s_, 0) > 0
  THEN
    -- ДОКУМЕНТ 1 ПРОСРОЧКА
    gl.REF (ref_);

    if mode_ = 17 and mfok_ = f_ourmfo
    then
     mfoa_  := gl.amfo;
   nlsa_  := nlsk_;
     nam_a_ := SUBSTR (nmk_, 1, 38);
     mfob_  := gl.amfo;
   nlsb_  := nls6397_;
   nam_b_ := SUBSTR (nms6397_, 1, 38);
   dk_    := 1;

    else     -- mode_ =  18
   mfoa_  := gl.amfo;
   nlsa_  := nls6397_;
     nam_a_ := SUBSTR (nms6397_, 1, 38);
   mfob_  := gl.amfo;
   nlsb_  := nlskas_;
   nam_b_ := SUBSTR (nmskas_, 1, 38);
     dk_    := 0;
  end if;

     nazn_ := 'Сплата штрафу за період з '      || to_char(l_dat+1,'dd.mm.yyyy') || ' по ' || to_char(dat_,'dd.mm.yyyy')
      --   || ' згідно  реф дог. ' || TO_CHAR (skrnd_.nd)  || '. Без ПДВ (сейф №'
      --   || TO_CHAR (skr_.snum) || ').';
                || ' , згідно договору № '      || TO_CHAR (skrnd_.ndoc)
                || ' від '                      || TO_CHAR (skrnd_.docdate, 'dd.mm.yyyy');

     gl.in_doc3 (ref_,tt_,vob_,substr(ref_,4,10),SYSDATE,bankdate_,dk_,kv_,s_,kv_,s_,sk_,SYSDATE,bankdate_,nam_a_,nlsa_,mfoa_,
          nam_b_,nlsb_,mfob_,nazn_,NULL,okpoa_,okpob_,NULL,NULL,0,NULL,null);

     IF nlsa_ IS NOT NULL
     THEN
        gl.payv (0,ref_,bankdate_,tt_,dk_,kv_,nlsa_,s_,kv_,nlsb_,s_);
     END IF;

     IF ref_ IS NOT NULL
     THEN
        INSERT INTO skrynka_nd_ref(REF, bdate, nd)
             VALUES (ref_, bankdate_, skrnd_.nd);
     END IF;

     IF NVL (skrnd_.custtype, 3) = 3
     THEN
        operw_fl (ref_);
     ELSE
        operw_ul (ref_);
     END IF;

  END IF;

   -- орендна плата за прострочений період
   if  tipt_ != -1
   then
      p_calc_tariff (n_sk_, par_);
    /*      p_oper_arenda_period (skrnd_.dat_end + 1,
                               dat_,
                               n_sk_,
                               mode_,
                               par_);  */

      skrn.p_calcperiod_tariff (skrnd_.dat_end + 1, dat_, skrnd_.nd, par_);

      IF  mode_ = 15
      THEN
        BEGIN
           SELECT nms
             INTO nmsnls_
             FROM accounts
            WHERE nls = skrnd_.nlsk
              AND kv = '980'
              AND kf = skrnd_.mfok;
        EXCEPTION
           WHEN NO_DATA_FOUND
           THEN nmsnls_ := NULL;
                bars_error.raise_nerror (l_mod, 'NOT_NLK_CLIENT', n_sk_);
        END;

      END IF;
     -- для 15 - немає проводку на касу
      IF mode_ != 15 or (skrnd_.mfok = f_ourmfo and nmsnls_ is not null)
      THEN
    -- ОПЕРАЦИЯ № 1 - КАССА
      gl.REF (ref_);
      nam_a_  := SUBSTR (nmss2909_, 1, 38);
    nlsa_   := nlss2909_;
        --nam_a_ := SUBSTR(COALESCE (skrnd_.fio, skrnd_.nmk), 1, 38);

         IF mode_ != 15 THEN
            nam_a_  := SUBSTR (nmss2909_, 1, 38);
            nlsa_   := nlss2909_;
            nlsb_   := nlskas_;
            okpob_  := f_ourokpo;
            nam_b_  := SUBSTR (nmskas_, 1, 38);
            dk_     := 0;
         ELSE
            nlsa_   := skrnd_.nlsk;
            okpoa_  := skrnd_.okpo1;
            nam_a_  := SUBSTR(nmsnls_, 1, 38);
            nam_b_  := SUBSTR (nmss2909_, 1, 38);
            nlsb_   := nlss2909_;
            dk_     := 1;
         END IF;
     mfoa_ := gl.amfo;
     mfob_ := gl.amfo;

     nam_b_ := SUBSTR(skrnd_.fio, 1, 38);
     nazn_  := 'Орендна плата за користування сейфом № '|| TO_CHAR (skr_.snum)|| ' за період з '|| to_char(skrnd_.dat_end+1,'dd.mm.yyyy')|| 'р. по '
              || TO_CHAR (dat_, 'dd.mm.yyyy')|| 'р., згідно Договору № '|| skrnd_.ndoc|| ' від '|| TO_CHAR (skrnd_.docdate, 'dd.mm.yyyy')|| 'р.';

        IF skrnpar1_ = 0
        THEN nazn_ :=SUBSTR (   nazn_|| ' В т.ч. ПДВ '|| TRIM (TO_CHAR (snds1_ / 100, '9999999990.00'))|| ' грн.',1,160);
    ELSE nazn_ := nazn_ || '.';
    END IF;

    -- Якщо сума оренди менше рівна 0 то виходим. ніяких докуменетів не створюємо.
    if  sb1_ <= 0 then return; else null; end if;

    gl.in_doc3 (ref_,tt_,vob_,substr(ref_,4,10),SYSDATE,bankdate_,dk_,kv_,sb1_,kv_,sb1_,sk_,SYSDATE,bankdate_,nam_a_,nlsa_,mfoa_,nam_b_,nlsb_,mfob_,nazn_,NULL,okpoa_,okpob_,NULL,NULL,0,NULL,null);
        -- сумма с НДС
        gl.payv (0,ref_,bankdate_,tt_,dk_,kv_,nlsa_,sb1_,kv_,nlsb_,tariff3_);

    dk_ := 1;
         -- доходи
        IF sc1_ IS NOT NULL AND sc1_ > 0 AND nls6519_ IS NOT NULL THEN
        gl.payv (0,ref_,bankdate_,tt2_,dk_,kv_,nlss2909_,sc1_+sf1_,kv_,nls6519_,scperiod_);
    end if;

      IF nlsnds_ IS NOT NULL AND snds1_ IS NOT NULL AND snds1_ > 0  THEN
    -- НДС
         gl.payv (0,ref_,bankdate_,tt3_,dk_,kv_,nlss2909_,snds1_,kv_,nlsnds_,snds1_);
    end if;

    IF ref_ IS NOT NULL
      THEN
        -- проставляємо хоч якусь ознаку, для подальшої роботи з котловими рахунками
        INSERT INTO skrynka_nd_ref(REF, bdate, nd, rent)
           VALUES (ref_, bankdate_, skrnd_.nd, 1);
    END IF;

      IF NVL (skrnd_.custtype, 3) = 3
      THEN operw_fl (ref_);
      ELSE operw_ul (ref_);
      END IF;

      end if;
   end if;




end overdue_payment;

-- *******************************************************************************
--            Пролонгація
--    par_ == nd
-- *******************************************************************************
   PROCEDURE p_oper_prolong (
      dat_    DATE,
      dat2_   DATE,
      n_sk_   NUMBER,
      mode_   NUMBER,
      par_    NUMBER,
    p_extnd varchar2)
   IS
      tipt_     NUMBER;
      dpr_      NUMBER;
    nTmp      INTEGER;
    nAcc      NUMBER(38);
    nSND      NUMBER(38);
    nlsk_     skrynka_nd.nlsk%type;
    mfok_     skrynka_nd.mfok%type;
    nmk_      skrynka_nd.nmk%type;
    ob22_     SPECPARAM_INT.OB22%type;      -- ob22
   BEGIN
    --Рорзрахунок і створення документів по погашенню прострочки та пені
   overdue_payment(dat_-1, dat2_-1, n_sk_, mode_, par_);

    /*
    -- якщо некоректні дати - нічого не робимо
    IF dat_ <= skrnd_.dat_end OR dat2_ < dat_
      THEN
    bars_error.raise_nerror(l_mod, 'PROLONG_DATES_ERROR', par_);
      END IF;

    -- Працюємо з індивідуальними рахунками по кожному сейфу

    select a.nms,  a.nls,    n.nlsk, n.mfok,  n.nmk
    into nms3600_, nls3600_, nlsk_,  mfok_,   nmk_
    from skrynka_nd_acc s, accounts a, skrynka_nd n
    where s.tip = 'D' and s.nd = n.nd and s.acc = a.acc and n.nd = par_;


    if skrnd_.imported = 1 then
      s_ := GREATEST ((1 + skrnd_.peny/100/365) * skrnd_.sd * (dat_ - skrnd_.dat_end - 1), 0);
    else

      SELECT tip
        INTO tipt_
        FROM skrynka_tariff st
       WHERE st.tariff = skrnd_.tariff;

      skrn.p_tariff (skrnd_.tariff, dat_, dat2_, bankdate_);

      -- сумма просрочки
      IF tipt_ = 1
      THEN
         s_ := GREATEST (100 * peny_ * (dat_ - skrnd_.dat_end - 1), 0);
      ELSIF tipt_ = 2
      THEN
         dpr_ := GREATEST (dat_ - skrnd_.dat_end - 1, 0);
         s_ := 100 * peny_ * dpr_;
      END IF;

    end if;

    if mode_ = 17 then
         Begin
             SELECT nms
               INTO nmskas_
               FROM accounts
              WHERE nls = skrnd_.nlsk AND kv = '980' and kf = skrnd_.mfok;
         EXCEPTION  WHEN NO_DATA_FOUND THEN
                    bars_error.raise_nerror(l_mod, 'NOT_NLK_CLIENT', n_sk_);
        -- Рахунок клієнта не заповнено або заповнено не вірно
        End;
     end if;


      IF NVL (s_, 0) > 0
      THEN
         -- ДОКУМЕНТ 1 ПРОСРОЧКА
         gl.REF (ref_);

    if mode_ = 17 and mfok_ = f_ourmfo then

       mfoa_ := gl.amfo;
     nlsa_ := nlsk_;
         nam_a_ := SUBSTR (nmk_, 1, 38);

     mfob_ := gl.amfo;
     nlsb_ := nls6397_;
     nam_b_ := SUBSTR (nms6397_, 1, 38);

      dk_ := 1;

    else     -- mode_ =  18
       mfoa_ := gl.amfo;
     nlsa_ := nls6397_;
     nam_a_ := SUBSTR (nms6397_, 1, 38);

     mfob_ := gl.amfo;
     nlsb_ := nlskas_;
     nam_b_ := SUBSTR (nmskas_, 1, 38);
         dk_ := 0;
  end if;

         nazn_ :=
               'Сплата штрафу за період з ' || to_char(skrnd_.dat_end+1,'dd.mm.yyyy') || ' по ' || to_char(dat_-1,'dd.mm.yyyy')
         || ' згідно  реф дог. ' || TO_CHAR (skrnd_.nd)  || '. Без ПДВ (сейф №'
         || TO_CHAR (skr_.snum) || ').';

--         dk_ := 0;

         gl.in_doc3 (ref_,tt_,vob_,substr(ref_,4,10),SYSDATE,bankdate_,dk_,kv_,s_,kv_,s_,sk_,SYSDATE,bankdate_,nam_a_,nlsa_,mfoa_,
            nam_b_,nlsb_,mfob_,nazn_,NULL,okpoa_,okpob_,NULL,NULL,0,NULL,null);

         IF nlsa_ IS NOT NULL
         THEN
            gl.payv (0,ref_,bankdate_,tt_,dk_,kv_,nlsa_,s_,kv_,nlsb_,s_);
         END IF;

         IF ref_ IS NOT NULL
         THEN
            INSERT INTO skrynka_nd_ref(REF, bdate, nd)
                 VALUES (ref_, bankdate_, skrnd_.nd);
         END IF;

     IF NVL (skrnd_.custtype, 3) = 3
     THEN
      operw_fl (ref_);
     ELSE
      operw_ul (ref_);
     END IF;

   END IF;
*/

      IF dat_ > skrnd_.dat_end AND dat2_ >= dat_
      THEN
         IF dat2_ >= dat_
         THEN
      nSND :=bars_sqnc.get_nextval('s_cc_deal');
            SELECT rnk
              INTO def_rnk_
              FROM customer a
             WHERE a.rnk = (SELECT TO_NUMBER (val)
                              FROM branch_parameters
                             WHERE tag = 'DEP_SKRN' AND branch = branch_);

            SELECT TO_NUMBER (val)
              INTO otvisp_
              FROM branch_parameters
             WHERE tag = 'DEP_ISP' AND branch = branch_;

            SELECT TO_NUMBER (val)
              INTO grp_
              FROM branch_parameters
             WHERE tag = 'DEP_GRP' AND branch = branch_;

      Op_Reg_Ex(99, 0, 0, grp_, nTmp, def_rnk_,
        substr(f_newnls2(null,'SD_DR','3600',def_rnk_,null,null),1,14), 980,
        substr('Рах. приб. майб. пер. для банк. сейфу  №' || skrnd_.n_sk ,1, 70),
        'ODB', otvisp_, nAcc, '1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,sys_context('bars_context','user_branch'),NULL);

            SELECT (CASE WHEN skrnd_.custtype = 3 THEN ob22 ELSE ob22_u END)
              INTO ob22_
              FROM SKRYNKA_ACC_TIP
             WHERE tip = 'D';

            accreg.setAccountSParam (nAcc, 'OB22', ob22_);


      INSERT into skrynka_nd_acc (acc,nd,tip)
      values (nAcc,nSND,'D');

      -- Номер угоди нової
      skrnd_.ndoc := nvl(p_extnd, skrnd_.ndoc);

      insert into skrynka_nd
         (nd, sos, n_sk, ndoc, dat_begin, dat_end, custtype,
        fio, dokum, issued, adres,
          tel, nmk, nlsk, mfok, fio2, pasp2,
        issued2, adres2, dov_dat1, dov_dat2,
          isp_dov, ndov, tariff, docdate, sdoc,
        okpo1, okpo2, keycount, datr,
          mr, datr2, mr2, rnk)
        values(nSND, 1, skrnd_.n_sk, skrnd_.ndoc, dat_,dat2_, skrnd_.custtype,
               skrnd_.fio, skrnd_.dokum, skrnd_.issued, skrnd_.adres,
               skrnd_.tel, skrnd_.nmk, skrnd_.nlsk, skrnd_.mfok, skrnd_.fio2, skrnd_.pasp2,
               skrnd_.issued2, skrnd_.adres2, skrnd_.dov_dat1, skrnd_.dov_dat2,
               skrnd_.isp_dov, skrnd_.ndov, skrnd_.tariff, sysdate , skrnd_.sdoc,
           skrnd_.okpo1, skrnd_.okpo2, skrnd_.keycount, skrnd_.datr,
           skrnd_.mr, skrnd_.datr2, skrnd_.mr2, skrnd_.rnk);

            UPDATE skrynka_nd
               SET sdoc =
                      (SELECT s * 100
                         FROM skrynka_tip t, skrynka s
                        WHERE t.o_sk = s.o_sk AND s.n_sk = skrnd_.n_sk)
             WHERE nd = nSND
       RETURNING  sdoc INTO  skrnd_.sdoc;

            UPDATE accounts
               SET mdate = dat2_
             WHERE acc = mainacc_.acc;

            UPDATE specparam
               SET R011 = (skrnd_.custtype - 1)
             WHERE acc = mainacc_.acc;
            IF SQL%ROWCOUNT = 0 then
        INSERT INTO SPECPARAM(acc,R011)
        values (mainacc_.acc, (skrnd_.custtype - 1));
      END IF;

      insert into cc_docs(id,nd,adds,version,state,comm,text,doneby)
            SELECT id,
                   nSND,
                   adds,
                   version,
                   state,
                   comm,
                   text,
                   doneby
              FROM cc_docs
             WHERE nd = skrnd_.nd;

      insert into nd_txt(nd,tag,txt)
            SELECT nSND, n.tag, SUBSTR (n.txt, 1, 254)
              FROM nd_txt n
             WHERE n.nd = skrnd_.nd;

         END IF;

         -- расчет новой арендной платы

         -- запоминаем старые даты аренды
        olddat_    := skrnd_.dat_begin;
        olddat2_   := skrnd_.dat_end;
     --
        if mode_ = 17 and mfok_ = f_ourmfo
        then --безнал
          p_dep_skrn (dat_, dat2_, n_sk_, 15, nSND);
        else
              p_dep_skrn (dat_, dat2_, n_sk_, 14, nSND);
    end if;

    -- Різниця заставної плати

    If ostc2909_ <  skrnd_.sdoc then
      If  mode_ = 18
         then  p_dep_skrn (dat_, dat2_, n_sk_, 10, nSND, null,  skrnd_.sdoc-ostc2909_);
         else  p_dep_skrn (dat_, dat2_, n_sk_, 11, nSND, null,  skrnd_.sdoc-ostc2909_);
      end if;
        end if;

    END IF;
   END;

--------------------------------------------------------------------------------------------------------------------------------------------------------
--            Амортизація при закритті договору
--------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE p_final_amort ( nd_   IN NUMBER)
   IS
      splan_      NUMBER;
      sopl_       NUMBER;
      sdoc_       NUMBER;
    l_month     NUMBER;
    l_month_let varchar2(20);
   BEGIN
  FOR k IN (    SELECT n.n_sk, sk.snum, n.nd, a.nls, a.kv, n.dat_begin, n.dat_end,
                         a.ostc, ROUND (skrn.f_get_oplplan_sum (n.nd) * 5 / 6) s1,
                         skrn.f_get_curdoh_sum (n.nd) s2,
                         skrn.f_get_3600_sum (n.nd) s3,
                         skrn.f_get_3600_sum (n.nd) sp2, n.CUSTTYPE,
             a.branch
                    FROM skrynka_nd n, skrynka_acc s, accounts a, skrynka sk
                   WHERE n.n_sk = s.n_sk
           AND n.nd = nd_
                     AND a.ostc = a.ostb
                     AND s.acc = a.acc
                     AND s.tip = 'M'
                     AND n.n_sk = sk.n_sk)
      LOOP
     init(null);
     -- визначаємо рахунок 6519 відповідно типу клієнта
         p_nls_6519(k.CUSTTYPE);
         sdoc_ := k.sp2;

         IF sdoc_ > 0
         THEN
            nazn_ := 'Доходи звітного періоду по сейфу № '
      || LPAD (TO_CHAR (k.snum), 3, '0') || ' (відділення ' || k.branch || ' )' ||
      ' реф.дог. ' || TO_CHAR (k.nd) || '. Без ПДВ.';
            -- реквизиты документа
            gl.REF (ref_);

            SELECT SUBSTR (a.nms, 1, 38), a.nls
              INTO nms3600_, nls3600_
              FROM skrynka_nd_acc s, accounts a, skrynka_nd n
             WHERE s.tip = 'D' AND s.nd = n.nd AND s.acc = a.acc AND n.nd = k.nd;

      nlsa_   := nls3600_;
            nam_a_  := SUBSTR (nms3600_, 1, 38);
            --okpoa_ := skrnd_.okpo1;
            mfoa_   := gl.amfo;
            nlsb_   := nls6519_;
            nam_b_  := SUBSTR (nms6519_, 1, 38);
            --okpob_ := skrnd_.okpo1;
            okpob_  := f_ourokpo;
            mfob_   := gl.amfo;
            dk_     := 1;
            sk_     := NULL;
            kv_     := 980;
            gl.in_doc3 (ref_,tt_,vob_,substr(ref_,4,10),SYSDATE,bankdate_,dk_,kv_,sdoc_,kv_,sdoc_,sk_,bankdate_,bankdate_,nam_a_,
            nlsa_,mfoa_,nam_b_,nlsb_,mfob_,nazn_,NULL,okpoa_,okpob_,NULL,NULL,0,NULL,null);
            gl.payv (2,ref_,bankdate_,tt_,dk_,kv_,nlsa_,sdoc_,kv_,nlsb_,sdoc_);

            IF ref_ IS NOT NULL
            THEN
              INSERT INTO skrynka_nd_ref(REF, bdate, nd)
                   VALUES (ref_, bankdate_, k.nd);
            END IF;

      -- Завжди проставляти дату останньої амортизації
            UPDATE skrynka_nd
               SET amort_date = dat_end
             WHERE nd = k.nd;
         END IF;
      END LOOP;
   END;
----------------------------------------------------------------------------
--    Амортизація
----------------------------------------------------------------------------
PROCEDURE p_oper_amort_doh (dat_    IN DATE,
                            dat2_   IN DATE,
                            n_sk_   IN NUMBER,
                            mode_   IN NUMBER,
                            par_    IN NUMBER DEFAULT NULL)
   IS
      splan_        NUMBER;
      sopl_         NUMBER;
      sdoc_         NUMBER;
    l_month     NUMBER;
    l_month_let varchar2(20);
   BEGIN
  FOR k IN (    SELECT n.n_sk, sk.snum, n.nd, a.nls, a.kv, n.dat_begin, n.dat_end,
                         a.ostc,n.amort_date,
                         ROUND (skrn.f_get_oplplan_sum (n.nd) * 5 / 6) s1,
                         skrn.f_get_curdoh_sum (n.nd) s2,
                         skrn.f_get_3600_sum (n.nd) s3,
                         LEAST (  ROUND (skrn.f_get_oplplan_sum_4date (n.nd, last_day(bankdate))  * 5 / 6)
                                - skrn.f_get_curdoh_sum (n.nd),
                                skrn.f_get_3600_sum (n.nd)
                               ) sp2,
             LEAST ( ROUND(f_get_oplplan_sum_4period(n.nd, n.amort_date+1, least(last_day(bankdate),n.dat_end)) * 5/6 ),
                                skrn.f_get_3600_sum (n.nd)) sp3, n.CUSTTYPE,
               a.branch
                    FROM skrynka_nd n, skrynka_acc s, accounts a, skrynka sk
                   WHERE n.n_sk = s.n_sk
                     AND s.acc = a.acc
                     AND s.tip = 'M'
                     AND n.sos <> 15
                     AND n.n_sk = sk.n_sk
           AND ((skrn.f_get_opl_sum (n.nd) > 0 AND
               ROUND (skrn.f_get_oplplan_sum_4date(n.nd,last_day(bankdate)) * 5 / 6) <> skrn.f_get_curdoh_sum (n.nd) )
               OR
              (n.amort_date is not null)
              )
                ORDER BY n_sk)
      LOOP
     init(null);
     -- визначаємо рахунок 6519 відповідно типу клієнта
         p_nls_6519(k.CUSTTYPE);

     IF k.amort_date is not null
     then
      sdoc_ := k.sp3;
         ELSE
            sdoc_ := k.sp2;
         END IF;

         IF sdoc_ > 0
         THEN
            nazn_ := 'Доходи звітного періоду по сейфу № '
     || LPAD (TO_CHAR (k.snum), 3, '0') || ' (відділення ' || k.branch || ' )' ||
      ' реф.дог. ' || TO_CHAR (k.nd) || '. Без ПДВ.';
            -- реквизиты документа
            gl.REF (ref_);

            SELECT SUBSTR (a.nms, 1, 38), a.nls
              INTO nms3600_, nls3600_
              FROM skrynka_nd_acc s, accounts a, skrynka_nd n
             WHERE s.tip = 'D' AND s.nd = n.nd AND s.acc = a.acc AND n.nd = k.nd;

      nlsa_   := nls3600_;
            nam_a_  := SUBSTR (nms3600_, 1, 38);
          --okpoa_  := skrnd_.okpo1;
            mfoa_   := gl.amfo;
            nlsb_   := nls6519_;
            nam_b_  := SUBSTR (nms6519_, 1, 38);
          --okpob_  := skrnd_.okpo1;
            okpob_  := f_ourokpo;
            mfob_   := gl.amfo;
            dk_     := 1;
            sk_     := NULL;
            kv_     := 980;
            gl.in_doc3 (ref_,tt_,vob_,substr(ref_,4,10),SYSDATE,bankdate_,dk_,kv_,sdoc_,kv_,sdoc_,sk_,bankdate_,bankdate_,nam_a_,
            nlsa_,mfoa_,nam_b_,nlsb_,mfob_,nazn_,NULL,okpoa_,okpob_,NULL,NULL,0,NULL,null);

            gl.payv (0,ref_,bankdate_,tt_,dk_,kv_,nlsa_,sdoc_,kv_,nlsb_,sdoc_);

            IF ref_ IS NOT NULL
            THEN
              INSERT INTO skrynka_nd_ref(REF, bdate, nd)
                   VALUES (ref_, bankdate_, k.nd);
            END IF;
      -- Завжди проставляти дату останньої амортизації
            UPDATE skrynka_nd
               SET amort_date = LEAST (LAST_DAY (bankdate), dat_end)
             WHERE nd = k.nd;
         END IF;
      END LOOP;
-- Виконуємо амортизацію і по закритих договорах. Повне списання з рахунку 3600
  FOR k IN (    SELECT n.nd
                    FROM skrynka_nd n, skrynka_nd_acc sa, accounts a
                   WHERE n.sos = 15
                     AND n.nd = sa.nd
                     AND sa.acc = a.acc
                     AND a.ostc = a.ostb
                     AND skrn.f_get_3600_sum (n.nd) > 0
                ORDER BY n.n_sk)
  LOOP
    p_final_amort(k.nd);
  END LOOP;


END;

/*
*    Сплат комісії за оформлення довіреності в установі банку на право користування індивідуальним сейфом
*/
PROCEDURE p_commis_of_attorney (dat_    IN DATE,
                          dat2_   IN DATE,
                          n_sk_   IN NUMBER,
                          mode_   IN NUMBER,
                          par_    IN NUMBER,
                          ref_    IN NUMBER DEFAULT NULL)
 IS
  nls6397_    accounts.nls%type;
  nms6397_    accounts.nms%type;
  nls2600_    accounts.nls%type;
    nms2600_    accounts.nms%type;
    tax_        number;
  opr         oper%rowtype;
  l_ob22      accounts.ob22%type;
BEGIN
  /*
    Необхідно доопрацювати модуль «Депозитні сейфи», а саме:
    створити операцію для сплати комісії за оформлення довіреності в установі банку на право користування індивідуальним сейфом.
    Бухгалтерська модель за операцією наступна:
    Дт 1002/01, поточні рахунки клієнтів Кт 3739/03
    Дт 3739/03 Кт 6110/28,29 – сума комісії без ПДВ
    Дт 3739/03 Кт 3622/51 – ПДВ.
  */

        IF NVL (skrnd_.custtype, 3) = 3
        THEN l_ob22 := '28';
        ELSE l_ob22 := '29';
        END IF;

     begin
     if newnbs.g_state = 0 then
     select nls,      substr(nms,1,38)
       into opr.nlsb, opr.nam_b
       from accounts
      where   nls =  NBS_OB22_NULL('6110', l_ob22);
     else
     select nls,      substr(nms,1,38)
       into opr.nlsb, opr.nam_b
       from accounts
      where   nls =  NBS_OB22_NULL('6510', l_ob22);
     end if;
     exception when no_data_found then bars_audit.info('Податок неможливо зняти 3622/51 не знайдено');
     end;


     -- vob3_  прописали код тарифа


   if mode_ = 29    -- через касу
     then
     opr.nlsa      := nlskas_;
       opr.nam_a     := substr(nmskas_,1,38) ;
     else           -- безнал 30
        BEGIN
         SELECT nms, nls
           INTO nms2600_, nls2600_
           FROM accounts
          WHERE nls = skrnd_.nlsk AND kv = '980';
        EXCEPTION  WHEN NO_DATA_FOUND THEN
                    bars_error.raise_nerror(l_mod, 'NOT_NLK_CLIENT', n_sk_);
        -- Рахунок клієнта не заповнено або заповнено не вірно
        END;
           opr.nlsa      := nls2600_;
           opr.nam_a     := substr(nms2600_,1,38) ;

   end if;



       opr.id_a      := skrnd_.okpo1;
     opr.id_b      := f_ourokpo;
     opr.tt        := tt_;
     opr.vob       := vob_;
     opr.sk        := sk_;
       opr.s         := case when par_ = 0 then f_tarif(KOD_ => vob3_, KV_ => 980, NLS_ => '', S_ => 0, KVK_ => null, DAT_ => gl.bd) else par_*100 end;
     opr.nazn      := 'Сплата комісії за оформлення довіреності по сейфу №'||skr_.snum||' (договір №'||skrnd_.ndoc||')';
     opr.sos       := 1;

     if opr.s <= 0
     then return;
     end if;

   if ref_ is null
     then
        gl.ref (opr.REF);

        gl.in_doc3( ref_   => opr.REF,
                    tt_    => opr.tt ,
                    vob_   => opr.vob,
                    nd_    => substr(to_char(opr.REF),1,10),
                    pdat_  => SYSDATE ,
                    vdat_  => gl.BDATE,
                    dk_    => 1,
                    kv_    => gl.baseval,
                    s_     => opr.s,
                    kv2_   => gl.baseval,
                    s2_    => opr.s,
                    sk_    =>  opr.sk  ,
                    data_  => gl.bdate ,
                    datp_  => gl.bdate ,
                    nam_a_ => substr(opr.nam_a,1,38),
                    nlsa_  => opr.nlsa ,
                    mfoa_  => gl.aMfo  ,
                    nam_b_ => substr(opr.nam_b,1,38),
                    nlsb_  => opr.nlsb ,
                    mfob_  => gl.aMfo  ,
                    nazn_  => substr(opr.nazn,1,158),
                    d_rec_ => null,
                    id_a_  => opr.id_b ,
                    id_b_  => opr.id_a ,
                    id_o_  => null,
                    sign_  => null,
                    sos_   => opr.sos,
                    prty_  => null,
                    uid_   => null);

     else opr.ref  := ref_;
     end if;


        IF opr.REF IS NOT NULL     THEN

         insert into operw (ref, tag, value)  values ( opr.REF, 'PDV', '1' );

         GL.dyntt2(SOS_     => opr.sos,            
                   MOD1_    => 1,            
                   MOD2_    => 0,
                   REF_     => opr.REF,        
                   VDAT1_   => gl.BDATE,     
                   VDAT2_   => gl.BDATE,
                   TT0_     => opr.tt,         
                   DK_      => 1,              
                   SA_      => opr.s,
                   KVA_     => gl.baseval,       
                   MFOA_    => gl.aMfo,      
                   NLSA_    => opr.nlsa,
                   KVB_     => gl.baseval,       
                   MFOB_    => gl.aMfo,      
                   NLSB_    => opr.nlsb,
                   SB_      => opr.s,          
                   SQ_      => opr.s,        
                   NOM_     => null);

            INSERT INTO skrynka_nd_ref(REF, bdate,  nd)
                 VALUES (opr.REF,  gl.bdate,  skrnd_.nd);

    END IF;

        IF NVL (skrnd_.custtype, 3) = 3
        THEN operw_fl (opr.REF);
        ELSE operw_ul (opr.REF);
        END IF;


end;

/*
*    Внесення коштів у разі недостатньої суми для покриття витрат банку
*/
PROCEDURE p_cost_of_bank (dat_    IN DATE,
                          dat2_   IN DATE,
                          n_sk_   IN NUMBER,
                          mode_   IN NUMBER,
                          par_    IN NUMBER,
                          ref_    IN NUMBER DEFAULT NULL)
 IS
  nls6397_    accounts.nls%type;
  nms6397_    accounts.nms%type;
  nls3622_    accounts.nls%type;
        nms3622_    accounts.nms%type;
        tax_        number;
  opr         oper%rowtype;
BEGIN
   BEGIN
        SELECT a.nls, SUBSTR (a.nms, 1, 38), f_ourokpo
             INTO   opr.nlsb, opr.nam_b, opr.id_b
             FROM accounts a
            WHERE a.nls = (SELECT val
                           FROM branch_parameters
                          WHERE tag = 'DEP_S11' AND branch = branch_)
               AND a.kv = 980;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         bars_error.raise_nerror(l_mod, 'PARAM_NOT_FOUND', 'DEP_S11');
    END;

   nls3622_ := NBS_OB22_NULL('3622', '51');

    begin
     select substr(nms,1,38)
       into nms3622_
       from accounts
      where nbs = '3622'
        and nls = nls3622_;
    exception when no_data_found then bars_audit.info('Податок неможливо зняти 3622/51 не знайдено');
    end;


       opr.id_a      := skrnd_.okpo1;
     opr.tt        := tt_;
     opr.vob       := vob_;
     opr.nlsa      := nlskas_;
       opr.nam_a     := substr(nmskas_,1,38) ;
       opr.s         := nvl(par_,0)*100;
     opr.nazn      := 'Внесення коштів у разі недостатньої суми для покриття витрат банку за ключі від сейфу №'||skr_.snum||' у разі їх втрати (договір №'||skrnd_.ndoc||')';

     if opr.s <= 0
     then return;
     end if;

   if ref_ is null
     then
        gl.ref (opr.REF);

        gl.in_doc3(ref_  => opr.REF,       tt_    => opr.tt ,    vob_   => opr.vob,     nd_    => substr(to_char(opr.REF),1,10),
                pdat_  => SYSDATE ,     vdat_  => gl.BDATE,   dk_    => 0,
                kv_    => gl.baseval,   s_     => opr.s,      kv2_   => gl.baseval,  s2_    => opr.s,
                sk_    =>  32 ,       data_  => gl.bdate ,   datp_  => gl.bdate ,
                nam_a_ => substr(opr.nam_b,1,38),     nlsa_  => opr.nlsb ,       mfoa_  => gl.aMfo  ,
                nam_b_ => substr(opr.nam_a,1,38),     nlsb_  => opr.nlsa ,       mfob_  => gl.aMfo  ,
                nazn_  => substr(opr.nazn,1,158),
                d_rec_ => null,                        id_a_  => opr.id_b ,     id_b_  => opr.id_a ,          id_o_  => null,
                sign_  => null,                        sos_   => 1,              prty_  => null,              uid_   => null);

       else opr.ref  := ref_;
       end if;


     if nvl(nms3622_,'') is not null and nvl(nls3622_,'') is not null
       then
        tax_ := round(opr.s/6);
        opr.s := opr.s - tax_;
    end if;

    paytt ( flg_  => 0,          -- флаг оплаты
            ref_  => opr.REF,    -- референция
            datv_ => gl.bdate,   -- дата валютировния
            tt_   => opr.tt,     -- тип транзакции
            dk0_  => 1,          -- признак дебет-кредит
            kva_  => gl.baseval, -- код валюты А
            nls1_ => opr.nlsa,   -- номер счета А
            sa_   => opr.s,      -- сумма в валюте А
            kvb_  => gl.baseval, -- код валюты Б
            nls2_ => opr.nlsb  , -- номер счета Б
            sb_   => opr.s       -- сумма в валюте Б
           );

     if tax_ >0
     then
         begin
          paytt (   flg_  => 0,          -- флаг оплаты
                    ref_  => opr.REF,    -- референция
                    datv_ => gl.bdate,   -- дата валютировния
                    tt_   => opr.tt,     -- тип транзакции
                    dk0_  => 1,          -- признак дебет-кредит
                    kva_  => gl.baseval, -- код валюты А
                    nls1_ => opr.nlsa,   -- номер счета А
                    sa_   => tax_,      -- сумма в валюте А
                    kvb_  => gl.baseval, -- код валюты Б
                    nls2_ => nls3622_ , -- номер счета Б
                    sb_   => tax_       -- сумма в валюте Б
                   );

          end;
     end if;

        IF opr.REF IS NOT NULL
        THEN
            INSERT INTO skrynka_nd_ref(REF, bdate,  nd)
                 VALUES (opr.REF,  gl.bdate,  skrnd_.nd);
    END IF;

        IF NVL (skrnd_.custtype, 3) = 3
        THEN operw_fl (opr.REF);
        ELSE operw_ul (opr.REF);
        END IF;

        UPDATE skrynka
          SET keyused = 0
        WHERE n_sk = skrnd_.n_sk;
end;

/*
*    Списання заставної плати  за втрату чи пошкодження ключа.
--http://jira.unity-bars.com.ua:11000/browse/COBUSUPABS-4624
--Необхідно доопрацювати модуль «Депозитні сейфи» в частині зміни бухгалтерської моделі за операцією SN3 списання суми із заставної плати за ключі, у разі їх втрати.
--Бухгалтерська модель за операцією наступна:
--Дт 2909/19 Кт 3622/51 – на суму ПДВ;
--Дт 2909/19 Кт 6399/02 – визнання доходів на суму списання із заставної плати за вирахуванням ПДВ.
--(Наприклад: сума для списання – 1000,00 грн; сума ПДВ – 166,67 грн., сума доходів установи банку – 833,33грн.).
*/
    procedure p_mortgage_income(dat_    DATE,
                                dat2_   DATE,
                                n_sk_   NUMBER,
                                mode_   NUMBER,
                                par_    NUMBER,
                                ref_    NUMBER default null)
   IS
  nls6397_    accounts.nls%type;
  nms6397_    accounts.nms%type;
    nls3622_    accounts.nls%type;
    nms3622_    accounts.nms%type;
    tax_        number;
  opr         oper%rowtype;
   BEGIN
        BEGIN
           SELECT a.nls, SUBSTR (a.nms, 1, 38), f_ourokpo
             INTO opr.nlsb, opr.nam_b, opr.id_b
             FROM accounts a
         WHERE a.nls = (SELECT val
                          FROM branch_parameters
                         WHERE tag = 'DEP_S11'
                           AND branch = branch_)
           AND a.kv = 980;
    EXCEPTION WHEN NO_DATA_FOUND
              THEN bars_error.raise_nerror(l_mod, 'PARAM_NOT_FOUND', 'DEP_S11');
    END;

    nls3622_ := NBS_OB22_NULL('3622', '51');

    begin
     select substr(nms,1,38)
       into nms3622_
       from accounts
      where nbs = '3622'
        and nls = nls3622_;
    exception when no_data_found then bars_audit.info('Податок неможливо зняти 3622/51 не знайдено');
    end;

       opr.id_a      := skrnd_.okpo1;
     opr.tt        := tt_;
     opr.vob       := vob_;
     opr.nlsa      := nls2909_;
       opr.nam_a     := substr(nms2909_,1,38) ;

       if par_ * 100 <= ostc2909_
       then opr.s := par_ * 100;
     else raise_application_error (- (20777), '\.'|| '     Не достатньо коштів на рахунку застави', TRUE);
     end if;


     if mode_ = 25
       then opr.nazn := 'Оприбуткування на рахунок доходів Банку заставної суми за ключі від сейфу №'||skr_.snum||' у разі їх втрати (договір №'||skrnd_.ndoc||')';
     else opr.nazn := 'Оприбуткування на рахунок доходів Банку заставної суми за ключі від сейфу №'||skr_.snum||' відкритті сейфу без присутності клієнта (договір №'||skrnd_.ndoc||')';
       end if;

       if opr.s <= 0 then return; end if;

     if ref_ is null then
        gl.ref (opr.REF);

        gl.in_doc3( ref_  => opr.REF,                   tt_    => opr.tt,   vob_   => opr.vob,     nd_    => SUBSTR(TO_CHAR(opr.REF),1,10),
                    pdat_  => SYSDATE,                  vdat_  => gl.BDATE, dk_    => 1,
                    kv_    => gl.baseval,               s_     => opr.s,    kv2_   => gl.baseval,  s2_    => opr.s,
                    sk_    => NULL,                     data_  => gl.bdate, datp_  => gl.bdate,
                    nam_a_ => SUBSTR(opr.nam_a,1,38),   nlsa_  => opr.nlsa, mfoa_  => gl.aMfo,
                    nam_b_ => SUBSTR(opr.nam_b,1,38),   nlsb_  => opr.nlsb, mfob_  => gl.aMfo,
                    nazn_  => SUBSTR(opr.nazn,1,158),
                    d_rec_ => NULL,                     id_a_  => opr.id_a, id_b_  => opr.id_b,     id_o_  => NULL,
                    sign_  => NULL,                     sos_   => 1,        prty_  => NULL,         uid_   => NULL);

       else opr.ref  := ref_;
       end if;

       if nvl(nms3622_,'') is not null and nvl(nls3622_,'') is not null
       then
        tax_ := round(opr.s/6);
        opr.s := opr.s - tax_;
       end if;


     paytt (    flg_  => 0,          -- флаг оплаты
                ref_  => opr.REF,    -- референция
                datv_ => gl.bdate,   -- дата валютировния
                tt_   => opr.tt,     -- тип транзакции
                dk0_  => 1,          -- признак дебет-кредит
                kva_  => gl.baseval, -- код валюты А
                nls1_ => opr.nlsa,   -- номер счета А
                sa_   => opr.s,      -- сумма в валюте А
                kvb_  => gl.baseval, -- код валюты Б
                nls2_ => opr.nlsb  , -- номер счета Б
                sb_   => opr.s       -- сумма в валюте Б
               );
     if tax_ >0
     then
         begin
          paytt (   flg_  => 0,          -- флаг оплаты
                    ref_  => opr.REF,    -- референция
                    datv_ => gl.bdate,   -- дата валютировния
                    tt_   => opr.tt,     -- тип транзакции
                    dk0_  => 1,          -- признак дебет-кредит
                    kva_  => gl.baseval, -- код валюты А
                    nls1_ => opr.nlsa,   -- номер счета А
                    sa_   => tax_,       -- сумма в валюте А
                    kvb_  => gl.baseval, -- код валюты Б
                    nls2_ => nls3622_  , -- номер счета Б
                    sb_   => tax_        -- сумма в валюте Б
                   );

          end;
     end if;

        IF opr.REF IS NOT NULL
        THEN
            INSERT INTO skrynka_nd_ref(REF, bdate,  nd)
                 VALUES (opr.REF,  gl.bdate,  skrnd_.nd);
    END IF;

        IF NVL (skrnd_.custtype, 3) = 3
        THEN operw_fl (opr.REF);
        ELSE operw_ul (opr.REF);
        END IF;

        UPDATE skrynka
          SET keyused = 0
        WHERE n_sk = skrnd_.n_sk;
   END;

    PROCEDURE add_package_repository (dat_    IN DATE,
                                      dat2_   IN DATE,
                                      n_sk_   IN NUMBER,
                                      mode_   IN NUMBER,
                                      par_    IN NUMBER)
    is
    nls6397_            accounts.nls%type;
    nms6397_            accounts.nms%type;
    opr                 oper%rowtype;
    l_skrynka_acc_tip   SKRYNKA_ACC_TIP%rowtype;
    l_nls               accounts.nls%type;
    l_nms               accounts.nms%type;

    i                   number := 0;
    dep_isp             branch_parameters.val%type; --  виконавець
    dep_grp             branch_parameters.val%type; --  група рахунків
    our_rnk             branch_parameters.val%type; --  рнк банку
    macc                accounts.acc%type;        --  код рахунку
    nTmp                INTEGER;

  BEGIN
        /*
    begin
         SELECT a.nls, a.nms, f_ourokpo
         INTO   opr.nlsb, opr.nam_b, opr.id_b
         FROM accounts a
        WHERE a.nls = (SELECT val
                 FROM branch_parameters
                WHERE tag = 'DEP_S12' AND branch = branch_)
         and a.kv = 980;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         bars_error.raise_nerror(l_mod, 'PARAM_NOT_FOUND', 'DEP_S12');
        END;*/

    begin
       select *
         into l_skrynka_acc_tip
       from SKRYNKA_ACC_TIP
      where tip = 'P'
        and nbs  is not null
        and ob22 is not null;
    exception when no_data_found
                  then return;        --  позабалансовий облік ключів не проводитсья.
    end;

    if skrnd_.dat_end + 45 < gl.bd
        then raise_application_error(-20100,'Вилучення вмісту ячейки без клієнта не можливо.');
    end if;

     if mode_ in(26)
       then
         -- відкриваємо рахунок

         while i < 10    -- 10 попиток визначить рахунок
          loop
            l_nls := vkrzn(substr(f_ourmfo,1,5),  l_skrynka_acc_tip.nbs||'0'|| lpad(i,2,'0')||lpad(skrnd_.nd,7,'0'));

            begin
              SELECT acc
                INTO macc
                FROM accounts
               WHERE nls = l_nls AND kv = 980;
            exception when no_data_found then exit;
            end;
            i:= i+1;
          end loop;

            BEGIN
               SELECT a.acc                                    --, a.nls, a.nms, f_ourokpo
                 INTO macc                              --,  opr.nlsb, opr.nam_b, opr.id_b
                 FROM accounts a
                WHERE nls = l_nls AND kv = 980;

               bars_error.raise_nerror ('SKR', 'ACCOUNT_ALREADY_EXISTS', TO_CHAR (l_nls));
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  NULL;
            END;

            select val into dep_isp from branch_parameters where tag = 'DEP_ISP' and branch = sys_context('bars_context','user_branch');
            select val into our_rnk from branch_parameters where tag = 'DEP_SKRN' and branch = sys_context('bars_context','user_branch');
            select val into dep_grp from branch_parameters where tag = 'DEP_GRP' and branch = sys_context('bars_context','user_branch');

      l_nms:= 'Вилучені цінності Сейф дог.№' || to_char(skrnd_.ndoc);

      Op_Reg_Ex(99, 0, 0, dep_grp, nTmp, our_rnk, l_nls, 980, l_nms,'ODB', dep_isp , macc,
        '1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,sys_context('bars_context','user_branch'),NULL);

      --INSERT into skrynka_acc (acc,n_sk,tip) values (macc,P_ND,'K');
        -- вставка показника ОБ22
      accreg.setAccountSParam (macc, 'OB22', l_skrynka_acc_tip.ob22);
     else return;
       end if;

        BEGIN
           SELECT a.nls, SUBSTR (a.nms, 1, 38), f_ourokpo
             INTO opr.nlsb, opr.nam_b, opr.id_b
             FROM accounts a
            WHERE a.nls = l_nls AND a.kv = 980;
        EXCEPTION
           WHEN NO_DATA_FOUND
           THEN
              bars_error.raise_nerror (l_mod, 'PARAM_NOT_FOUND', l_nls);
        END;

       opr.id_a      := f_ourokpo;
     opr.tt        := tt_;
     opr.vob       := vob_;

     if substr(nls9819_,1,4) = '9910'
       then     opr.nlsa      := nls9819_;
                opr.nam_a     := substr(nms9819_,1,38) ;
       elsif    substr(nls9898_,1,4) = '9910'
       then     opr.nlsa      := nls9898_;
                opr.nam_a     := substr(nms9898_,1,38) ;
     end if;

     opr.s         :=  100;

       if mode_ = 26
       then opr.dk   :=1;
          opr.nazn := 'Внесення  цінностей до каси на зберігання, що були вилучені при відкритті сейфу №'||skrnd_.n_sk||' без присутності клієнта   (договір №'||skrnd_.ndoc||')';
     else opr.dk   :=0;
          opr.nazn := 'Повернення клієнту цінностей, що були вилучені при відкритті сейфу №'||skrnd_.n_sk||' без присутності клієнта   (договір №'||skrnd_.ndoc||')';
       end if;

       if opr.s <= 0 then return; end if;

        gl.ref (opr.REF);

        gl.in_doc3(ref_  => opr.REF,       tt_    => opr.tt ,    vob_   => opr.vob,     nd_    => substr(to_char(opr.REF),1,10),
                pdat_  => SYSDATE ,     vdat_  => gl.BDATE,   dk_    => 1-opr.dk,
                kv_    => gl.baseval,   s_     => opr.s,      kv2_   => gl.baseval,  s2_    => opr.s,
                sk_    =>  null ,       data_  => gl.bdate ,   datp_  => gl.bdate ,
                nam_a_ => substr(opr.nam_a,1,38),     nlsa_  => opr.nlsa ,       mfoa_  => gl.aMfo  ,
                nam_b_ => substr(opr.nam_b,1,38),     nlsb_  => opr.nlsb ,       mfob_  => gl.aMfo  ,
                nazn_  => substr(opr.nazn,1,158),
                d_rec_ => null,                        id_a_  => opr.id_a ,     id_b_  => opr.id_b ,         id_o_  => null,
                sign_  => null,                        sos_   => 1,              prty_  => null,              uid_   => null);

        paytt ( flg_  => 0,          -- флаг оплаты
                ref_  => opr.REF,    -- референция
                datv_ => gl.bdate,   -- дата валютировния
                tt_   => opr.tt,     -- тип транзакции
                dk0_  => 1-opr.dk,   -- признак дебет-кредит
                kva_  => gl.baseval, -- код валюты А
                nls1_ => opr.nlsa,   -- номер счета А
                sa_   => opr.s,      -- сумма в валюте А
                kvb_  => gl.baseval, -- код валюты Б
                nls2_ => opr.nlsb  ,  -- номер счета Б
                sb_   => opr.s        -- сумма в валюте Б
               );

         p_mortgage_income(dat_, dat2_,n_sk_, mode_, par_, opr.ref);

         /*     IF opr.REF IS NOT NULL
                 THEN
                    INSERT INTO skrynka_nd_ref(REF, bdate,  nd)
                         VALUES (opr.REF,  gl.bdate,  skrnd_.nd);
                END IF;

                 IF NVL (skrnd_.custtype, 3) = 3
                 THEN
                    operw_fl (opr.REF);
                 ELSE
                    operw_ul (opr.REF);
                 END IF;         */

          UPDATE skrynka
            SET keyused = 0
          WHERE n_sk = skrnd_.n_sk;
  end;
   ----------------------------------------------------------------------------

    PROCEDURE p_dep_skrn (dat_       IN DATE,
                          dat2_      IN DATE,
                          n_sk_      IN NUMBER,
                          mode_      IN NUMBER,
                          par_       IN NUMBER DEFAULT NULL,
                          p_userid   IN NUMBER DEFAULT NULL,
                          p_sum      IN NUMBER DEFAULT NULL,
                          p_extnd    IN VARCHAR2 DEFAULT NULL)
    IS
        /*
        параметры:
        -----------------------------------
        dat_  - дата операции 1
        dat2_  - дата операции 2
        n_sk_ - номер сейфа
        mode_ - операция

        p_sum - для параметра веб numpar  - сума

        коды опереаций
        0 - открытие нового договора, генерация референса из S_CC_DEAL, вставка записи в skrynka_nd
        1 - закрытие договора
        10 - внесение залога со счета кассы (без НДС)
        11 - внесение залога с р.с. клиента (без НДС)
        12 - возврат залога со счета кассы (без НДС)
        14 - аренда
        15 - аренда (безнал.)
        ----15,16 - возврат ключа, выдача ключа
        17 - пролонгация аренды ( с р.с. клиента )  NVV extnd_ mandatory
        18 - пролонгация аренды extnd_ mandatory
        19 - просрочка
        20 - test функции тарифов
        21 - оплата месячного тарифа (вводится начало - конец периода)
        22 - ежемесячная амортизация доходов будущих периодов, амортизация выполняется по всему портфелю
        23 - плата за довіреність
        25 -- Оприбуткування на рахунок доходів Банку заставної суми за ключі від сейфу у разі їх втрати
        26 -- Внесення до каси на зберігання місту ІБС, який було відкрито Банком без присутності клієнта
        27 -- Повернення клієнту цінностей, що були вилучені при відкритті сейфу без присутності клієнта
        28 -- Внесення коштів у разі недостатньої суми для покриття витрат банку
        31 -- Дострокове закриття договору оренди індивідуального сейфа через касу
        32 -- Дострокове закриття договору оренди індивідуального сейфа(безнал)
        */
  prolong_nd      skrynka_nd.nd%type;
  n_acc           accounts.acc%type;
  oldnd_state_    skrynka_nd.sos%type;
  l_dealcreated   skrynka_nd.deal_created%type;
   BEGIN
      IF par_ IS NULL
      THEN
         olddat_ := NULL;
         olddat2_ := NULL;
      END IF;

      -- отбор необходимых параметров
      -- операция
    -- при закритті необхідно зробити "фінальну" амортизацію
    if mode_ = 1 then
        SELECT tt, tt2, tt3, NAME, sk, NVL (vob, 6), NVL (vob2, 6),NVL (vob3, 6)
          INTO tt_, tt2_, tt3_, itemname_, sk_, vob_, vob2_,vob3_
          FROM skrynka_menu
         WHERE item = 22
             and kf = sys_context('bars_context','user_mfo');
       tt_ := 'SN6';
    else
      SELECT tt, tt2, tt3, NAME, sk, NVL (vob, 6), NVL (vob2, 6),NVL (vob3, 6)
          INTO tt_, tt2_, tt3_, itemname_, sk_, vob_, vob2_,vob3_
          FROM skrynka_menu
         WHERE item = mode_
             and kf = sys_context('bars_context','user_mfo');

    end if;
      -- обязательно обнулить SK для не кассовых операций
      IF mode_ NOT IN ('10', '12', '14', '15', '18', '19', '21','29', '31')
      THEN
         sk_ := NULL;
      END IF;

    IF p_userid is not null
    then
         sk_ := NULL;
    end if;

      bankdate_ := bankdate;

      -- ближайшая месячная отчетная дата
      IF mode_ <> 0 AND mode_ <> 1 AND mode_ <> 22
      THEN
    if par_ is not null AND par_ <> 0 then
           BEGIN
              SELECT *
                INTO skrnd_
                FROM skrynka_nd
               WHERE nd = par_;
           EXCEPTION
              WHEN NO_DATA_FOUND
              THEN bars_error.raise_nerror(l_mod, 'DEAL_CLOSED_ND', par_);
           END;
    else
           BEGIN
              SELECT *
                INTO skrnd_
                FROM skrynka_nd
               WHERE n_sk = n_sk_ AND sos = 0;
           EXCEPTION
              WHEN NO_DATA_FOUND
              THEN bars_error.raise_nerror(l_mod, 'DEAL_CLOSED_NSK', n_sk_);
           END;
    end if;
      END IF;

-- визначаємо рахунок 6519 відповідно типу клієнта
   p_nls_6519(skrnd_.CUSTTYPE);




    IF mode_ <> 1 AND mode_ <> 12 AND mode_ <> 13 AND mode_ <> 25 AND mode_ <> 26 AND mode_ <> 28 AND mode_ <> 19 AND mode_ <> 22
      THEN
      if skrnd_.imported = 1
      then
        bars_error.raise_nerror(l_mod, 'IMPORTED_MODE_ERROR', skrnd_.nd);
      end if;
    END IF;
        /*
              IF mode_ = 22
              THEN
                    if sys_context('bars_context','user_branch') <> '/' || sys_context('bars_context','user_mfo') || '/'
                    then
                        bars_error.raise_nerror(l_mod, 'IMPORTED_MODE_ERROR', skrnd_.nd);
                    end if;
              END IF;
        */

    IF  mode_ != 22 then
        BEGIN
           SELECT *
             INTO skr_
             FROM skrynka
            WHERE n_sk = n_sk_;
        EXCEPTION
           WHEN NO_DATA_FOUND
           THEN bars_error.raise_nerror(l_mod, 'SAFE_NOT_FOUND', n_sk_);
      END;

        BEGIN
           SELECT a.*
             INTO mainacc_
             FROM skrynka_acc s, accounts a
            WHERE s.n_sk = n_sk_
                AND s.acc = a.acc
                AND s.tip = 'M';

           nls2909_  := mainacc_.nls;
           nms2909_  := mainacc_.nms;
           ostc2909_ := ABS (mainacc_.ostc);
        EXCEPTION
           WHEN NO_DATA_FOUND
           THEN bars_error.raise_nerror(l_mod, 'ACCOUNT_NOT_FOUND', nls2909_);
        END;
    END IF;

      -- МФО
      mfoa_     := gl.amfo;
      mfob_     := gl.amfo;
      okpoa_    := f_ourokpo;
      okpob_    := f_ourokpo;

      SELECT ID
        INTO userid_
        FROM staff$base
       WHERE id = user_id;

     -- неможна  повторно пролонговувати.
      IF mode_ in ( 17,18)
       THEN
            BEGIN
               SELECT nd
                 INTO prolong_nd
                 FROM skrynka_nd
                WHERE n_sk = n_sk_ AND sos = 1;

               bars_error.raise_nerror (l_mod, 'PROLONGED_CONTRACT', prolong_nd);
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN NULL;
            END;
    End If;

      IF mode_ = 0
      THEN
         null;--skrn.p_dep_skrn (dat_, dat2_, n_sk_, 1, p_extnd);
    ELSIF mode_ = 1
      THEN
         -- проверка на наличие назакрытого договора
     BEGIN
      SELECT nd, sos, deal_created
        INTO oldnd_, oldnd_state_, l_dealcreated
        FROM skrynka_nd
       WHERE nd = par_;
     EXCEPTION
      WHEN NO_DATA_FOUND
      THEN bars_error.raise_nerror(l_mod, 'DEAL_CLOSED_ND', par_);
     END;

         -- договор нельзя закрывать
         BEGIN
      -- перевіряємо на пролонгацію
      prolong_nd := null;

      if oldnd_state_ = 0 then
        begin
          select min(nd)
                      into prolong_nd
            from skrynka_nd
           where n_sk = n_sk_
                       and sos = 1;
        exception when NO_DATA_FOUND then null;
        end;
      end if;

      if prolong_nd is null then
        if l_dealcreated is null or l_dealcreated <> bankdate or oldnd_state_ = 0 then
          begin
            SELECT a.ostc
              INTO s_
              FROM skrynka s, skrynka_acc g, accounts a
             WHERE s.n_sk = g.n_sk
               --AND s.o_sk = g.o_sk
               AND g.acc = a.acc
                           AND g.tip = 'M'
               AND a.ostc = 0
                           AND a.ostb = 0
               AND s.n_sk = n_sk_;
           EXCEPTION
            WHEN NO_DATA_FOUND
            THEN bars_error.raise_nerror(l_mod, 'BAIL_NOT_EMPTY', n_sk_);
          end;
        end if;
      end if;
         END;

     if prolong_nd is null then
      null;
     end if;

     -- виконуємо автоматичну амортизацію при закритті договору
     p_final_amort(oldnd_);

         IF oldnd_ IS NOT NULL
         THEN
            UPDATE skrynka_nd
               SET sos = 15, dat_close = gl.bd
             WHERE nd = oldnd_;

      -- закриваємо рахунок тільки якщо немає пролонгації
            UPDATE accounts
               SET mdate = NULL
             WHERE acc IN (SELECT acc
                             FROM skrynka_acc a
                            WHERE     a.n_sk = n_sk_
                                  AND NOT EXISTS
                                         (SELECT n_sk
                                            FROM skrynka_nd
                                           WHERE n_sk = n_sk_ AND sos = 1));
         END IF;
     -- відкриваємо договір, який висить з станом "пролонгація"
         IF prolong_nd IS NOT NULL and oldnd_state_ = 0
         THEN
            UPDATE skrynka_nd
               SET sos = 0
             WHERE nd = prolong_nd;
         END IF;
      ELSIF mode_ = 10 OR mode_ = 11 OR mode_ = 12 OR mode_ = 13
      THEN
         p_oper_zalog (dat_, dat2_, n_sk_, mode_, par_, p_userid, p_sum);
      ELSIF mode_ = 14                                    -- внесение аренды
      THEN
         p_oper_arenda (dat_, dat2_, n_sk_, mode_, par_);
      ELSIF mode_ = 15                                    -- внесение аренды
      THEN
         p_oper_arenda (dat_, dat2_, n_sk_, mode_, par_);
      ELSIF mode_ = 17                                 -- пролонгация аренды безнал
      THEN
         p_oper_prolong (dat_, dat2_, n_sk_, mode_, par_,p_extnd);
      ELSIF mode_ = 18                                 -- пролонгация аренды
      THEN
         p_oper_prolong (dat_, dat2_, n_sk_, mode_, par_,p_extnd);
      ELSIF mode_ = 19                                          -- просрочка
      THEN
       p_oper_prolong (dat_+1, dat_+1, n_sk_, 18, par_,p_extnd);
      ELSIF mode_ = 20
      THEN
         p_tariff (skr_.o_sk, dat_, dat2_, bankdate_);
      ELSIF mode_ = 21                                            -- mode=21
      THEN
         p_oper_arenda_period (dat_, dat2_, n_sk_, mode_, par_);
      ELSIF mode_ = 22
      THEN
         p_oper_amort_doh (dat_, dat2_, n_sk_, mode_, par_);


    ELSIF mode_ = 25 -- Оприбуткування на рахунок доходів Банку заставної суми за ключі від сейфу у разі їх втрати
      THEN
      p_mortgage_income(dat_, dat2_, n_sk_, mode_, p_sum);

    ELSIF mode_ = 26 -- Внесення до каси на зберігання місту ІБС, який було відкрито Банком без присутності клієнта
      THEN
     --p_mortgage_income(dat_, dat2_, n_sk_, mode_, par_);
     add_package_repository(dat_, dat2_, n_sk_, mode_, par_);

    ELSIF mode_ = 27 -- Повернення клієнту цінностей, що були вилучені при відкритті сейфу без присутності клієнта
      THEN
     add_package_repository(dat_, dat2_, n_sk_, mode_, par_);
    null;

      ELSIF mode_ = 28 -- Внесення коштів у разі недостатньої суми для покриття витрат банку
      THEN
     p_cost_of_bank(dat_, dat2_, n_sk_, mode_, p_sum);

      ELSIF mode_ = 29 -- Сплат комісії за оформлення довіреності в установі банку на право користування індивідуальним сейфом
      THEN             -- в таблиця skrynka_menu поле vob3 прописано код тарифу, або дать доступ до введення суми код операції K21 (з відокремленням ПДВ)
     p_commis_of_attorney(dat_, dat2_, n_sk_, mode_, p_sum);
    ELSIF mode_ = 30 -- Сплат комісії за оформлення довіреності в установі банку на право користування індивідуальним сейфом безготівково
      THEN             -- в таблиця skrynka_menu поле vob3 прописано код тарифу, або дать доступ до введення суми код операції K24 (з відокремленням ПДВ)
     p_commis_of_attorney(dat_, dat2_, n_sk_, mode_, p_sum);
    --COBUSUPABS-6272 (5602)
    ELSIF MODE_ = 31 OR MODE_ = 32 -- Операція дострокового закриття договору оренди індивідуального сейфа
     THEN
      p_advance_closed_deal(dat_, dat2_, n_sk_, mode_, par_);
    ELSE
      bars_error.raise_nerror(l_mod, 'MOD_NOT_FOUND', mode_);
    END IF;

      COMMIT;
   END;
   
 ---------------------------------------------------------------------------------------------------------
  --       Операція дострокового закриття договору оренди індивідуального сейфа (нал)
  ---------------------------------------------------------------------------------------------------------
  PROCEDURE P_ADVANCE_CLOSED_DEAL(DAT_  IN DATE,
                                  DAT2_ IN DATE,
                                  N_SK_ IN NUMBER,
                                  MODE_ IN NUMBER,
                                  PAR_  IN NUMBER DEFAULT NULL) IS
    SDOC_    NUMBER;
    ACC_3600 ACCOUNTS.ACC%TYPE;
    TYPE T_SKRN_AMORT IS RECORD(
      N_SK       SKRYNKA_ND.N_SK%TYPE,
      SNUM       SKRYNKA.SNUM%TYPE,
      ND         SKRYNKA_ND.ND%TYPE,
      NLS        ACCOUNTS.NLS%TYPE,
      KV         ACCOUNTS.KV%TYPE,
      DAT_BEGIN  SKRYNKA_ND.DAT_BEGIN%TYPE,
      DAT_END    SKRYNKA_ND.DAT_END%TYPE,
      OSTC       ACCOUNTS.OSTC%TYPE,
      AMORT_DATE SKRYNKA_ND.AMORT_DATE%TYPE,
      S1         NUMBER(30),
      S2         NUMBER(30),
      S3         NUMBER(30),
      SP2        NUMBER(30),
      SP3        NUMBER(30),
      CUSTTYPE   SKRYNKA_ND.CUSTTYPE%TYPE,
      BRANCH     ACCOUNTS.BRANCH%TYPE);
    L_SKRN_AMORT T_SKRN_AMORT;
    L_ERR_CHECK1 EXCEPTION;

  BEGIN

    IF PAR_ IS NOT NULL AND PAR_ <> 0 THEN

      ---*************************** Доамортизируем по текущий банковский день включительно
      BEGIN
        SAVEPOINT SP1;
        -- Вычисляем сумму которую надо доамортизировать по введенному договору
        SELECT N.N_SK,
               SK.SNUM,
               N.ND,
               A.NLS,
               A.KV,
               N.DAT_BEGIN,
               N.DAT_END,
               A.OSTC, --остаток фактический
               N.AMORT_DATE,
               ROUND(SKRN.F_GET_OPLPLAN_SUM(N.ND) * 5 / 6) S1, --Сума, яку треба було б амортизувати на поточну bankdate
               SKRN.F_GET_CURDOH_SUM(N.ND) S2, --  Прибуток поточного періоду
               SKRN.F_GET_3600_SUM(N.ND) S3, --  Прибуток майбутніх періодів
               LEAST(ROUND(SKRN.F_GET_OPLPLAN_SUM_4DATE(N.ND, GL.BD) * 5 / 6) -
                     SKRN.F_GET_CURDOH_SUM(N.ND),
                     SKRN.F_GET_3600_SUM(N.ND)) SP2, --Сума, яку треба було б амортизувати на задану дату
               LEAST(ROUND(SKRN.F_GET_OPLPLAN_SUM_4PERIOD(N.ND,
                                                          N.AMORT_DATE + 1,
                                                          LEAST(GL.BD,
                                                                N.DAT_END)) * 5 / 6),
                     SKRN.F_GET_3600_SUM(N.ND)) SP3, --  Сума, яку треба було б амортизувати за заданий проміжок часу
               N.CUSTTYPE,
               A.BRANCH
          INTO L_SKRN_AMORT
          FROM SKRYNKA_ND N, SKRYNKA_ACC S, ACCOUNTS A, SKRYNKA SK
         WHERE N.N_SK = S.N_SK
           AND S.ACC = A.ACC
           AND S.TIP = 'M'
           AND N.SOS <> 15
           AND N.N_SK = SK.N_SK
           AND N.ND = PAR_
           AND ((SKRN.F_GET_OPL_SUM(N.ND) > 0 AND
               ROUND(SKRN.F_GET_OPLPLAN_SUM_4DATE(N.ND, BANKDATE) * 5 / 6) <>
               SKRN.F_GET_CURDOH_SUM(N.ND)) OR (N.AMORT_DATE IS NOT NULL))
         ORDER BY N_SK;

        DBMS_OUTPUT.PUT_LINE(L_SKRN_AMORT.N_SK || ' ' || L_SKRN_AMORT.SNUM || ' ' ||
                             L_SKRN_AMORT.ND || ' ' || L_SKRN_AMORT.NLS || ' ' ||
                             L_SKRN_AMORT.KV || ' ' ||
                             L_SKRN_AMORT.DAT_BEGIN || ' ' ||
                             L_SKRN_AMORT.DAT_END || ' ' ||
                             L_SKRN_AMORT.OSTC || ' ' ||
                             L_SKRN_AMORT.AMORT_DATE || ' ' ||
                             L_SKRN_AMORT.S1 || ' ' || L_SKRN_AMORT.S2 || ' ' ||
                             L_SKRN_AMORT.S3 || ' ' || L_SKRN_AMORT.SP2 || ' ' ||
                             L_SKRN_AMORT.SP3 || ' ' ||
                             L_SKRN_AMORT.CUSTTYPE || ' ' ||
                             L_SKRN_AMORT.BRANCH);

        -- визначаємо рахунок 6119 відповідно типу клієнта
        P_NLS_6519(L_SKRN_AMORT.CUSTTYPE);
        DBMS_OUTPUT.PUT_LINE('POSLE: ' || NLS6519_ || ' ' || NMS6519_);

        IF L_SKRN_AMORT.AMORT_DATE IS NOT NULL THEN
          SDOC_ := L_SKRN_AMORT.SP3;
        ELSE
          SDOC_ := L_SKRN_AMORT.SP2;
        END IF;

        -- определяем счет 3600
        SELECT SUBSTR(A.NMS, 1, 38), A.NLS, A.ACC
          INTO NMS3600_, NLS3600_, ACC_3600
          FROM SKRYNKA_ND_ACC S, ACCOUNTS A, SKRYNKA_ND N
         WHERE S.TIP = 'D'
           AND S.ND = N.ND
           AND S.ACC = A.ACC
           AND N.ND = L_SKRN_AMORT.ND
           AND N.SOS = 0;

        DBMS_OUTPUT.PUT_LINE(NMS3600_ || ' ' || NLS3600_ || ' ' ||
                             ACC_3600);

        IF SDOC_ > 0 THEN
          DBMS_OUTPUT.PUT_LINE('СОздаем документ 3600-6519');
          -- Назначение платежа
          NAZN_ := 'Доходи звітного періоду по сейфу № ' ||
                   LPAD(TO_CHAR(L_SKRN_AMORT.SNUM), 3, '0') ||
                   ' (відділення ' || L_SKRN_AMORT.BRANCH || ' )' ||
                   ' реф.дог. ' || TO_CHAR(L_SKRN_AMORT.ND) || '. Без ПДВ.';

          -- референс документа
          GL.REF(REF_);
          DBMS_OUTPUT.PUT_LINE('REF_1:' || REF_);

          -- определяем переменные;
          NLSA_  := NLS3600_;
          NAM_A_ := SUBSTR(NMS3600_, 1, 38);
          --okpoa_  := skrnd_.okpo1;
          MFOA_  := GL.AMFO;
          NLSB_  := NLS6519_;
          NAM_B_ := SUBSTR(NMS6519_, 1, 38);
          --okpob_  := skrnd_.okpo1;
          OKPOB_ := F_OUROKPO;
          MFOB_  := GL.AMFO;
          DK_    := 1;
          SK_    := NULL;
          KV_    := 980;

          -- Создаем новый документ в опере
          GL.IN_DOC3(REF_,
                     TT2_,
                     VOB2_,
                     SUBSTR(REF_, 4, 10),
                     SYSDATE,
                     BANKDATE_,
                     DK_,
                     KV_,
                     SDOC_,
                     KV_,
                     SDOC_,
                     SK_,
                     BANKDATE_,
                     BANKDATE_,
                     NAM_A_,
                     NLSA_,
                     MFOA_,
                     NAM_B_,
                     NLSB_,
                     MFOB_,
                     NAZN_,
                     NULL,
                     OKPOA_,
                     OKPOB_,
                     NULL,
                     NULL,
                     0,
                     NULL,
                     NULL);

          GL.PAYV(0,
                  REF_,
                  BANKDATE_,
                  TT2_,
                  DK_,
                  KV_,
                  NLSA_,
                  SDOC_,
                  KV_,
                  NLSB_,
                  SDOC_);

          IF REF_ IS NOT NULL THEN
            INSERT INTO SKRYNKA_ND_REF
              (REF, BDATE, ND)
            VALUES
              (REF_, BANKDATE_, L_SKRN_AMORT.ND);
          END IF;

          -- Завжди проставляти дату останньої амортизації
          UPDATE SKRYNKA_ND
             SET AMORT_DATE = LEAST(LAST_DAY(BANKDATE), DAT_END)
           WHERE ND = L_SKRN_AMORT.ND;
        END IF;

        --*****************************Возвращаем остаток с амортизации************************************
        -- остаток на счете 3600
        SA_ := NVL(FOST(ACC_3600, GL.BD), 0) - SDOC_;
        DBMS_OUTPUT.PUT_LINE('SA_' || SA_);

        IF SA_ > 0 THEN
          IF MODE_ = 31 THEN
            --определение параметров проводки
            NAM_A_ := NMS3600_;
            NLSA_  := SUBSTR(NLS3600_, 1, 38);
            MFOA_  := GL.AMFO;

            NAM_B_ := SUBSTR(COALESCE(SKRND_.FIO, SKRND_.NMK), 1, 38);
            NLSB_  := NLSKAS_;
            MFOB_  := GL.AMFO;
            OKPOB_ := F_OUROKPO;

            NAZN_ := 'Повернення неамортизованних коштів, сейф № ' ||
                     TO_CHAR(SKR_.SNUM) ||
                     ' в зв''язку з закінченням договору № ' ||
                     TO_CHAR(SKRND_.NDOC) || ' від ' ||
                     TO_CHAR(SKRND_.DOCDATE, 'dd.mm.yyyy') || ', без ПДВ.';
            -- кредит реальный
            DK_ := 1;

          ELSIF MODE_ = 32 THEN
            BEGIN
              SELECT NMS
                INTO NMSKAS_
                FROM ACCOUNTS
               WHERE NLS = SKRND_.NLSK
                 AND KV = '980';
            EXCEPTION
              WHEN NO_DATA_FOUND THEN
                RAISE L_ERR_CHECK1;
                -- Рахунок клієнта не заповнено або заповнено не вірно
            END;
            --
            NLSA_  := SUBSTR(NLS3600_, 1, 38);
            NAM_A_ := NMS3600_;
            MFOA_  := GL.AMFO;
            NLSB_  := SKRND_.NLSK;
            NAM_B_ := SUBSTR(SKRND_.NMK, 1, 38);
            MFOB_  := GL.AMFO;
            --okpob_ := skrnd_.okpo1;
            OKPOB_ := F_OUROKPO;

            NAZN_   := 'Повернення неамортизованних коштів, сейф № ' || -- було "Повернення застави за ключ"
                       TO_CHAR(SKR_.SNUM) ||
                       ' в зв''язку з закінченням терміну дії договору № ' ||
                       TO_CHAR(SKRND_.NDOC) || ' від ' ||
                       TO_CHAR(SKRND_.DOCDATE, 'dd.mm.yyyy') ||
                       ', без ПДВ.';
            NLSKAS_ := SKRND_.NLSK;
            DK_     := 1;

          END IF;

          -- ДОКУМЕНТ 1 возврат амортизации
          DBMS_OUTPUT.PUT_LINE('СОздаем документ 3600-1002');
          GL.REF(REF_);
          DBMS_OUTPUT.PUT_LINE('REF_2:' || REF_);

          INSERT INTO OPER
            (REF,
             TT,
             VOB,
             ND,
             DK,
             PDAT,
             VDAT,
             DATD,
             DATP,
             NAM_A,
             NLSA,
             MFOA,
             KV,
             S,
             NAM_B,
             NLSB,
             MFOB,
             KV2,
             S2,
             NAZN,
             USERID,
             ID_A,
             ID_B,
             SK)
          VALUES
            (REF_,
             TT_,
             VOB_,
             SUBSTR(REF_, 4, 10),
             DK_,
             SYSDATE,
             BANKDATE_,
             BANKDATE_,
             BANKDATE_,
             NAM_A_,
             NLSA_,
             MFOA_,
             KV_,
             SA_,
             NAM_B_,
             NLSB_,
             MFOB_,
             KV_,
             SA_,
             NAZN_,
             USERID_,
             OKPOA_,
             OKPOB_,
             SK_);

          GL.PAYV(0,
                  REF_,
                  BANKDATE_,
                  TT_,
                  DK_,
                  KV_,
                  NLSA_,
                  SA_,
                  KV_,
                  NLSB_,
                  SA_);

          IF REF_ IS NOT NULL THEN
            INSERT INTO SKRYNKA_ND_REF
              (REF, BDATE, ND)
            VALUES
              (REF_, BANKDATE_, SKRND_.ND);
          END IF;

          IF NVL(SKRND_.CUSTTYPE, 3) = 3 THEN
            OPERW_FL(REF_);
          ELSE
            OPERW_UL(REF_);
          END IF;
        END IF;

     EXCEPTION
        WHEN NO_DATA_FOUND THEN
          ROLLBACK TO SP1;
          BARS_ERROR.RAISE_NERROR(L_MOD, 'DEAL_CLOSED_ND', PAR_);

        WHEN L_ERR_CHECK1 THEN
          ROLLBACK TO SP1;
          BARS_ERROR.RAISE_NERROR(L_MOD, 'NOT_NLK_CLIENT', N_SK_);

        WHEN OTHERS THEN
          ROLLBACK TO SP1;
          BARS_ERROR.RAISE_NERROR(L_MOD, 'DEAL_CLOSED_ND', PAR_);
          --RAISE_APPLICATION_ERROR(-20343, SQLCODE || ' ' || SQLERRM);
          
      END;

    END IF;

  END P_ADVANCE_CLOSED_DEAL;
    
---------------------------------------------------------------------------------------------------------
--        Закриття відпрацьованих 3600
---------------------------------------------------------------------------------------------------------
   PROCEDURE p_cleanup (DUMMY NUMBER)
   IS
   BEGIN
    FOR K IN (  SELECT n.n_sk,
                       n.nd,
                       n.dat_begin,
                       n.dat_end
                  FROM skrynka_nd n, skrynka s
                 WHERE     n.dat_end < bankdate
                       AND n.sos = 0
                       AND n.n_sk = s.n_sk
                       AND n.n_sk IN (SELECT n1.n_sk
                                        FROM skrynka_nd n1, skrynka s1
                                       WHERE     n1.n_sk = n.n_sk
                                             AND n1.sos = 1
                                             AND n1.n_sk = s1.n_sk))
    loop
        skrn.p_dep_skrn(k.dat_end, k.dat_end, k.n_sk, 1, k.nd);
    END LOOP;

    FOR K IN (  SELECT a.acc
                  FROM accounts A, skrynka_nd n, skrynka_nd_acc na
                 WHERE n.sos = 15
                   AND n.nd = na.nd
                   AND na.tip = 'D'
                   AND na.acc = a.acc
                   AND a.ostc = 0
                   AND a.ostb = 0
                   --AND a.ostf = 0
                   AND (a.dapp < bankdate OR a.dapp IS NULL)
                   AND a.dazs IS NULL)
    LOOP
        UPDATE accounts
           SET dazs = bankdate
         WHERE acc = k.acc;
    END LOOP;
   END;
-----------------------------------
   FUNCTION header_version
      RETURN VARCHAR2
   IS
   BEGIN
      RETURN header_version_;
   END;

-----------------------------------
   FUNCTION body_version
      RETURN VARCHAR2
   IS
   BEGIN
      RETURN version_ ||chr(10)|| body_awk;
   END;

-----------------------------------
   PROCEDURE initparams (par_ NUMBER)
   IS
      val_   branch_parameters.val%TYPE;
   BEGIN
      BEGIN
         SELECT val
           INTO skrnpar1_
           FROM params
          WHERE par = 'SKRNPAR1';
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN skrnpar1_ := 0;

            INSERT INTO params(par, val, comm)
                 VALUES ('SKRNPAR1', '0', 'Деп. ячейки, не расщеплять дох банка по НДС (безбалансовые)');
            COMMIT;
      END;

      BEGIN
         SELECT val
           INTO skrnpar2_
           FROM params
          WHERE par = 'SKRNPAR2';
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN skrnpar2_ := 0;

            INSERT INTO params(par, val, comm)
                 VALUES ('SKRNPAR2', '0', 'Деп. ячейки, использовать индивидуальный счет просрочки');
            COMMIT;
      END;

      BEGIN
         SELECT val
           INTO skrnpar3_
           FROM params
          WHERE par = 'SKRNPAR3';
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN skrnpar3_ := 1;

            INSERT INTO params(par, val, comm)
                 VALUES ('SKRNPAR3', '1', 'Деп. ячейки, бухмодель аренд. платы в одном референсе');
            COMMIT;
      END;

      BEGIN
         SELECT val
           INTO val_
           FROM branch_parameters
          WHERE tag = 'DEP_KAS'
            AND branch = branch_;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            INSERT INTO branch_parameters(tag, val, branch)
                 VALUES ('DEP_KAS', '', branch_);     -- 'деп. ячейки, acc счета кассы'
            COMMIT;
      END;

      BEGIN
         SELECT val
           INTO val_
           FROM branch_parameters
          WHERE tag = 'DEP_S1'
            AND branch = branch_;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            INSERT INTO branch_parameters(tag, val, branch)
                 VALUES ('DEP_S1', '', branch_);    -- 'деп. ячейки, acc счета 9898'
            COMMIT;
      END;

      BEGIN
         SELECT val
           INTO val_
           FROM branch_parameters
          WHERE tag = 'DEP_S2'
            AND branch = branch_;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            INSERT INTO branch_parameters(tag, val, branch)
                 VALUES ('DEP_S2', '', branch_);    -- 'деп. ячейки, acc счета 9819'
            COMMIT;
      END;

      BEGIN
         SELECT val
           INTO val_
           FROM branch_parameters
          WHERE tag = 'DEP_S3'
            AND branch = branch_;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            INSERT INTO branch_parameters(tag, val, branch)
                 VALUES ('DEP_S3', '', branch_);    --  'деп. ячейки, acc счета дох тек периода'
            COMMIT;
      END;


      BEGIN
         SELECT val
           INTO val_
           FROM branch_parameters
          WHERE tag = 'DEP_S5'
            AND branch = branch_;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            INSERT INTO branch_parameters(tag, val, branch)
                 VALUES ('DEP_S5', '', branch_);    -- 'деп. ячейки, acc счета 2909'
            COMMIT;
      END;

      BEGIN
         SELECT val
           INTO val_
           FROM branch_parameters
          WHERE tag = 'DEP_S6'
            AND branch = branch_;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            INSERT INTO branch_parameters(tag, val, branch)
                 VALUES ('DEP_S6', '', branch_);    -- 'деп. ячейки, acc счета 3579'
            COMMIT;
      END;

      BEGIN
         SELECT val
           INTO val_
           FROM branch_parameters
          WHERE tag = 'DEP_S7'
            AND branch = branch_;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            INSERT INTO branch_parameters(tag, val, branch)
                 VALUES ('DEP_S7', '', branch_);    --, 'деп. ячейки, acc счета для НДС'
            COMMIT;
      END;

      BEGIN
         SELECT val
           INTO val_
           FROM branch_parameters
          WHERE tag = 'DEP_SKRN' AND branch = branch_;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            INSERT INTO branch_parameters(tag, val, branch)
                 VALUES ('DEP_SKRN', '', branch_);    --  'деп. ячейки, RNK клиента для регестрации счетов'
            COMMIT;
      END;

      BEGIN
         SELECT TO_NUMBER (val)
           INTO otvisp_
           FROM branch_parameters
          WHERE tag = 'DEP_ISP' AND branch = branch_;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            INSERT INTO branch_parameters(tag, val, branch)
                 VALUES ('DEP_ISP', '', branch_);     --  'деп. ячейки, RNK клиента для регестрации счетов'
            COMMIT;
      END;

      BEGIN
         SELECT TO_NUMBER (val)
           INTO grp_
           FROM branch_parameters
          WHERE tag = 'DEP_GRP' AND branch = branch_;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            INSERT INTO branch_parameters(tag, val, branch)
                 VALUES ('DEP_GRP', '', branch_);     --  'деп. ячейки, код группы счета для регистрации счетов'
            COMMIT;
      END;

      BEGIN
         SELECT '1'
           INTO val_
           FROM newnlsdescr
          WHERE typeid = '^';
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            INSERT INTO newnlsdescr(typeid, descr,sqlval)
                 VALUES ('^', 'Номер сейфа','select num from conductor where num=:ACC');
            COMMIT;
      END;

      BEGIN
         SELECT '1'
           INTO val_
           FROM nlsmask
          WHERE maskid = 'SCRN';
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            INSERT INTO nlsmask(maskid, descr, MASK, masknms)
                 VALUES ('SCRN', 'депозитные ячейки', '_____^^^^', NULL);
            COMMIT;
      END;
   END;

-----------------------------------
   PROCEDURE setparams (par_ VARCHAR2, val_ VARCHAR2)
   IS
   BEGIN
      UPDATE branch_parameters
         SET val = val_
       WHERE tag = par_ AND branch = skrn.branch_;
      COMMIT;
   END;


--***********************************************************************************
-- контроль тарифу на відповідність до мінімальних тарифів встановленнив ЦА Ощадбанку
--***********************************************************************************
PROCEDURE control_tariff (p_tariff      IN SKRYNKA_TARIFF2.TARIFF%TYPE,
                          p_sd          IN SKRYNKA_TARIFF2.S%TYPE,
                          p_dat_begin   IN DATE,
                          p_dat_end     IN DATE)
is
    l_id    number;
    l_tarif number;
BEGIN
  begin
      select etalon_id
        into l_id
        from skrynka_tip s, SKRYNKA_TARIFF t
       where s.o_sk = T.O_SK
         and T.TARIFF = p_tariff;

     if nvl(l_id,0) = 0 then
       raise_application_error (- (20777), '\'|| '     Для виду ячейки не прописано код еталонної ячейки', TRUE);
     end if;
  exception when no_data_found then raise_application_error (- (20777), '\'|| '     Для виду ячейки не прописано код еталонної ячейки', TRUE);
  end;

    begin
        SELECT v.TARIFF_AMOUNT
          INTO l_tarif
          FROM SKRYNKA_TIP_ETALON s,
               SKRYNKA_ETALON_TARIFF p,
               SKRYNKA_ETALON_TARIFF_value v
         WHERE     S.id = P.etalon_id
               AND p.id = v.TARIFF_ID
               AND s.id = l_id
               AND (P.DAYS_COUNT, P.ID) IN (SELECT MIN (DAYS_COUNT), etalon_ID
                                              FROM SKRYNKA_ETALON_TARIFF
                                             WHERE days_count >=
                                                      (p_dat_end - p_dat_begin + 1) group by etalon_ID)
               AND (TARIFF_ID, APPLY_DATE) IN (  SELECT TARIFF_ID, MAX (APPLY_DATE)
                                                   FROM SKRYNKA_ETALON_TARIFF_value
                                                  WHERE APPLY_DATE <= p_dat_begin
                                               GROUP BY TARIFF_ID);
    exception when no_data_found then
      return;
    end;

    if l_tarif*100 > p_sd
    then raise_application_error (- (20777), '\'|| '     Встановлення тарифу для договору менше Мінімального тарифу з надання в оренду індивідуальних сейфів АТ "Ощадбанк" заборонено', TRUE);
    else null;
    end if;
END;

--************************************************************************************************************************************
--  +  Розрахунок тарифу по договору
--  par_ = 0  - "ексклюзивно"  для центури
--************************************************************************************************************************************
   PROCEDURE p_calc_tariff (n_sk_ NUMBER, par_ number default null)
   IS
      ttip_   NUMBER;
   BEGIN
      bankdate_ := bankdate;

      BEGIN
    if par_ is null or par_ = 0  then
         SELECT *
           INTO skrnd_
           FROM skrynka_nd
          WHERE n_sk = n_sk_;
    else
         SELECT *
           INTO skrnd_
           FROM skrynka_nd
          WHERE nd = par_;
    end if;
      END;

      BEGIN
         SELECT t.tip
           INTO ttip_
           FROM skrynka_tariff t
          WHERE t.tariff = skrnd_.tariff;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            ttip_ := NULL;
      END;

      skrn.p_tariff (skrnd_.tariff,
                     skrnd_.dat_begin,
                     skrnd_.dat_end,
                     least(bankdate_, skrnd_.dat_begin)
                    );
      IF ttip_ = 1
      THEN
         UPDATE skrynka_nd sn
            SET sn.s_arenda = tariff3_,
                sn.s_nds = ROUND (tariff3_ / 6),
                sn.sd = sd_,
                sn.prskidka = prsc_,
                sn.peny = peny_
          WHERE sn.nd = skrnd_.nd;
      ELSE
    -- контроль тарифу на відповідність до мінімальних тарифів встановленнив ЦА Ощадбанку
    control_tariff (skrnd_.tariff,sd_, skrnd_.dat_begin, skrnd_.dat_end);
         UPDATE skrynka_nd sn
            SET sn.s_arenda = tariff3_,
                sn.s_nds = ROUND ((tariff3_) / 6),
                sn.sd = sd_,
                sn.prskidka = prsc_,
                sn.peny = peny_
          WHERE sn.nd = skrnd_.nd;
      END IF;
   END;

-----------------------------------
   PROCEDURE p_add_protocol (str_ VARCHAR2)
   IS
   BEGIN
      proti_ := proti_ + 1;
      prot_ (proti_) := SUBSTR (str_, 1, 100);
   END;

-----------------------------------
   PROCEDURE p_prepare_ptotocol (
      dat_    DATE,
      dat2_   DATE,
      n_sk_   NUMBER,
      mode_   NUMBER,
      par_    NUMBER DEFAULT NULL
   )
   IS
   BEGIN
      prot_.DELETE;
      proti_ := 0;
      proti2_ := 0;

      IF mode_ = 21
      THEN
         SELECT *
           INTO skrnd_
           FROM skrynka_nd
          WHERE n_sk = n_sk_ AND sos <> 15;

         p_calcperiod_tariff (dat_, dat2_, skrnd_.nd);
         p_add_protocol ('сумма всей аренды =' || TO_CHAR (st_));
         p_add_protocol ('дней аренды =' || TO_CHAR (dni1_));
         --p_add_protocol ('-------------------------------------' );
         p_add_protocol ('дневной тариф =' || TO_CHAR (sd1_));
         --p_add_protocol ('=====================================' );
         p_add_protocol ('дата окончания тек.пер. =' || TO_CHAR (datk_));
         p_add_protocol ('дней тек.пер. =' || TO_CHAR (dni2_));
         p_add_protocol ('дней буд.пер. =' || TO_CHAR (dni3_));
         --p_add_protocol ('-------------------------------------' );
         p_add_protocol ('сумма аренды за период  =' || TO_CHAR (sb1_));
         p_add_protocol ('НДС =' || TO_CHAR (snds1_));
         p_add_protocol ('сумма тек. периода =' || TO_CHAR (sc1_));
         p_add_protocol ('сумма буд. периода =' || TO_CHAR (sf1_));
         p_add_protocol ('осталось сумма     =' || TO_CHAR (st_ - sopl_ - sb1_));
      END IF;
   END;

   -----------------------------------
   FUNCTION f_get_protocol_line
      RETURN VARCHAR2
   IS
   BEGIN
      IF proti2_ <= proti_
      THEN
         proti2_ := proti2_ + 1;

         IF prot_.EXISTS (proti2_)
         THEN
            RETURN prot_ (proti2_);
         END IF;
      ELSE
         RETURN '';
      END IF;

      RETURN '';
   END;

--  %%%%%%%%%%%%%%%%%%%%%%%%
--  Сума, яку треба було б амортизувати на поточну bankdate
--  %%%%%%%%%%%%%%%%%%%%%%%%
   FUNCTION f_get_oplplan_sum (nd_ NUMBER)
      RETURN NUMBER
   IS
      s_      NUMBER;
      dat1_   DATE;
   BEGIN
      SELECT *
        INTO skrnd_
        FROM skrynka_nd n
       WHERE n.nd = nd_;

      p_calcperiod_tariff (skrnd_.dat_begin, bankdate, nd_);
      RETURN GREATEST (sb1_, 0);
   END;
--  %%%%%%%%%%%%%%%%%%%%%%%%
--  Сума, яку треба було б амортизувати на задану дату
--  %%%%%%%%%%%%%%%%%%%%%%%%
   FUNCTION f_get_oplplan_sum_4date (nd_ NUMBER, dt_term DATE)
      RETURN NUMBER
   IS
   BEGIN
      SELECT *
        INTO skrnd_
        FROM skrynka_nd n
       WHERE n.nd = nd_;

      p_calcperiod_tariff (skrnd_.dat_begin, dt_term, nd_);
      RETURN GREATEST (sb1_, 0);
   END;

   -- %%%%%%%%%%%%%%%%%%%%%%%%
--  Сума, яку треба було б амортизувати за заданий проміжок часу
--  %%%%%%%%%%%%%%%%%%%%%%%%
   FUNCTION f_get_oplplan_sum_4period (nd_ NUMBER, dt_start DATE, dt_end DATE)
      RETURN NUMBER
   IS
   BEGIN
      SELECT *
        INTO skrnd_
        FROM skrynka_nd n
       WHERE n.nd = nd_;

    if dt_start is not null then
    p_calcperiod_tariff (dt_start, dt_end, nd_);
    else
    p_calcperiod_tariff (skrnd_.dat_begin, dt_end, nd_);
    end if;

      RETURN GREATEST (sb1_, 0);
   END;

--  %%%%%%%%%%%%%%%%%%%%%%%%
--  Всі кошти внесені клієнтом
--  %%%%%%%%%%%%%%%%%%%%%%%%
   FUNCTION f_get_opl_sum (nd_ NUMBER)
      RETURN NUMBER
   IS
      s_   NUMBER;
   BEGIN
      BEGIN
         SELECT a.nls, a.nms
           INTO nlsnds_, nmsnds_
           FROM accounts a
          WHERE a.nls = (SELECT val
               FROM branch_parameters
                          WHERE tag = 'DEP_S7' and branch = branch_)
        and a.kv = 980;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            nlsnds_ := NULL;
            nmsnds_ := NULL;
      END;

    -- Працюємо з індивідуальними рахунками по кожному сейфу
    s_ := 0;

    BEGIN
     SELECT a.nls, a.nms
       INTO nls6519_, nms6519_
       FROM accounts a
      WHERE a.nls = (SELECT val
               FROM branch_parameters
                          WHERE tag = 'DEP_S3' and branch = branch_)
        and a.kv = 980;
    EXCEPTION
     WHEN NO_DATA_FOUND
     THEN
      nls6519_ := NULL;
      nms6519_ := NULL;
    END;

        SELECT s_ + ostc
          INTO s_
          FROM accounts a, skrynka_nd_acc n
         WHERE n.nd = nd_ AND n.tip = 'D' AND n.acc = a.acc;

        SELECT NVL (SUM (o.s * (2 * dk - 1)), 0) + s_
          INTO s_
          FROM opldok o, accounts a, skrynka_nd_ref r
         WHERE o.acc = a.acc
           AND a.nls IN (nls6519_, nlsnds_)
           AND o.s > 0
           AND o.sos = 5
           AND o.REF = r.REF
           AND r.nd = nd_
           AND a.kv = '980';

     return s_;
   END;

-----------------------------------
   FUNCTION f_get_borg_sum (nd_ NUMBER)
      RETURN NUMBER
   IS
      s_   NUMBER;
   BEGIN
      SELECT GREATEST (s_arenda - f_get_opl_sum (nd_), 0)
        INTO s_
        FROM skrynka_nd
       WHERE nd = nd_;

      RETURN s_;
   END;

-----------------------------------
-- ?????
-----------------------------------
   FUNCTION f_get_amort3600_sum (nd_ NUMBER)
      RETURN NUMBER
   IS
      s_     NUMBER;
      acc_   NUMBER;
   BEGIN
    -- Працюємо з індивідуальними рахунками по кожному сейфу
    select ostc
    into s_
    from accounts a, skrynka_nd_acc n
    where n.nd = nd_ and n.tip = 'D' and n.acc = a.acc;

    RETURN s_;
   END;

--  %%%%%%%%%%%%%%%%%%%%%%%%
--  Прибуток майбутніх періодів
--  %%%%%%%%%%%%%%%%%%%%%%%%
   FUNCTION f_get_3600_sum (nd_ NUMBER)
      RETURN NUMBER
   IS
      s_     NUMBER;
      acc_   NUMBER;
   BEGIN
    -- Працюємо з індивідуальними рахунками по кожному сейфу
    SELECT ostc
      INTO s_
      FROM accounts a, skrynka_nd_acc n
     WHERE n.nd = nd_
       AND n.tip = 'D'
       AND n.acc = a.acc;
    RETURN s_;
   END;

--  %%%%%%%%%%%%%%%%%%%%%%%%
--  ПДВ
--  %%%%%%%%%%%%%%%%%%%%%%%%
   FUNCTION f_get_nds_sum (nd_ NUMBER)
      RETURN NUMBER
   IS
      s_     NUMBER;
      acc_   NUMBER;
   BEGIN
      BEGIN
         SELECT a.acc
           INTO acc_
           FROM branch_parameters t, accounts a
          WHERE t.tag = 'DEP_S7' and t.branch = branch_ and a.kv = 980 and a.nls = t.val /*and a.branch = t.branch*/;

      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            acc_ := NULL;
      END;

      SELECT NVL (SUM (o.s * (2*dk - 1)), 0)
        INTO s_
        FROM opldok o
       WHERE o.REF IN (SELECT r.REF
                         FROM skrynka_nd_ref r
                        WHERE r.nd = nd_)
         AND acc = acc_
         AND s > 0
         AND sos = 5;

     RETURN s_;
   END;

--  %%%%%%%%%%%%%%%%%%%%%%%%
--  1 - потрібно виконати амортизацію, 0 - ні
--  %%%%%%%%%%%%%%%%%%%%%%%%
   FUNCTION f_amort_needed RETURN NUMBER
   is
  l_amort number(1) := 0;
  sdoc_   number := 0;
   begin
  FOR k IN (    SELECT n.n_sk, sk.snum, n.nd, a.nls, a.kv, n.dat_begin, n.dat_end,
                         a.ostc,n.amort_date,
                         ROUND (skrn.f_get_oplplan_sum (n.nd) * 5 / 6) s1,
                         skrn.f_get_curdoh_sum (n.nd) s2,
                         skrn.f_get_3600_sum (n.nd) s3,
                         LEAST (  ROUND (skrn.f_get_oplplan_sum_4date (n.nd, last_day(bankdate))  * 5 / 6)
                                - skrn.f_get_curdoh_sum (n.nd),
                                skrn.f_get_3600_sum (n.nd)
                               ) sp2,
             LEAST ( ROUND(f_get_oplplan_sum_4period(n.nd, n.amort_date+1, least(last_day(bankdate),n.dat_end)) * 5/6 ),
                                skrn.f_get_3600_sum (n.nd)) sp3,
               a.branch
                    FROM skrynka_nd n, skrynka_acc s, accounts a, skrynka sk
                   WHERE n.n_sk = s.n_sk and s.tip = 'M'
                     AND s.acc = a.acc
                     AND n.sos <> 15
                     AND n.n_sk = sk.n_sk
           AND  ( ( skrn.f_get_opl_sum (n.nd) > 0 AND
                ROUND (skrn.f_get_oplplan_sum_4date(n.nd,last_day(bankdate)) * 5 / 6) <> skrn.f_get_curdoh_sum (n.nd) )
              OR
              (n.amort_date is not null)
              )
                ORDER BY n_sk)
      LOOP
     init(null);

     IF k.amort_date is not null
     then
      sdoc_ := k.sp3;
         ELSE
            sdoc_ := k.sp2;
         END IF;

         IF sdoc_ > 0
     THEN
      l_amort := 1;
      EXIT;
     END IF;

    END LOOP;

    return l_amort;
   end;

--  %%%%%%%%%%%%%%%%%%%%%%%%
--  Прибуток поточного періоду
--  %%%%%%%%%%%%%%%%%%%%%%%%
   FUNCTION f_get_curdoh_sum (nd_ NUMBER)
      RETURN NUMBER
   IS
      s_     NUMBER;
      acc_   NUMBER;
   BEGIN
    /*
            -- Працюємо з індивідуальними рахунками по кожному сейфу
            select ostc
            into s_
            from accounts a, skrynka_nd_acc n
            where n.nd = nd_ and n.tip = 'C' and n.acc = a.acc;
    */
      BEGIN
         SELECT a.acc
           INTO acc_
           FROM branch_parameters t, accounts a
          WHERE t.tag = 'DEP_S3'
            AND t.branch = branch_
            AND a.kv = 980
            AND a.nls = t.val /*and a.branch = t.branch*/;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN acc_ := NULL;
      END;
      SELECT NVL (SUM (o.s * (2*dk - 1)), 0)
        INTO s_
        FROM opldok o
       WHERE o.REF IN (SELECT r.REF
                         FROM skrynka_nd_ref r
                        WHERE r.nd = nd_
                          AND (rent = 1 or rent is null) )
         AND acc = acc_
         AND s > 0
         AND sos = 5;
   RETURN s_;
   END;

   --! добова сума штрафу по договору
   FUNCTION f_get_peny(nd_ NUMBER)
  RETURN NUMBER
   IS
    res_ number;
   BEGIN
        WITH m
             AS (SELECT s.tariff, n.dat_begin, n.dat_end - n.dat_begin + 1 AS term
                   FROM skrynka_nd n, skrynka_tariff s
                  WHERE n.nd = nd_ AND s.o_sk = n.o_sk AND n.tariff = s.tariff)
        SELECT NVL (s.peny * 100, 0)
          INTO res_
          FROM skrynka_tariff2 s, m
         WHERE     s.tariff = m.tariff
               AND m.term >= s.daysfrom
               AND m.term <= s.daysto
               AND s.tariff_date =
                      (SELECT MAX (ss.tariff_date)
                         FROM skrynka_tariff2 ss
                        WHERE ss.tariff = m.tariff AND ss.tariff_date <= m.dat_begin);

    return res_;
   END;

   --! добова сума штрафу по договору прописом
   FUNCTION f_get_peny_literal(nd_ NUMBER)
  RETURN VARCHAR2
   IS
    res_ varchar2(256);
   BEGIN
        WITH m
             AS (SELECT s.tariff, n.dat_begin, n.dat_end - n.dat_begin + 1 AS term
                   FROM skrynka_nd n, skrynka_tariff s
                  WHERE n.nd = nd_ AND s.o_sk = n.o_sk)
        SELECT f_sumpr (NVL (s.peny * 100, 0), 980, 'F')
          INTO res_
          FROM skrynka_tariff2 s, m
         WHERE     s.tariff = m.tariff
               AND m.term >= s.daysfrom
               AND m.term <= s.daysto
               AND s.tariff_date =
                      (SELECT MAX (ss.tariff_date)
                         FROM skrynka_tariff2 ss
                        WHERE ss.tariff = m.tariff AND ss.tariff_date <= m.dat_begin);
    return res_;
   END;

--  %%%%%%%%%%%%%%%%%%%%%%%%
--  Ініціалізація параметрів модуля
--  %%%%%%%%%%%%%%%%%%%%%%%%
   PROCEDURE init(parn_ NUMBER)
   IS
   BEGIN
      IF parn_ IS NULL
      THEN
    branch_ := sys_context('bars_context','user_branch');
      ELSE
        branch_ := parn_;
      END IF;

      BEGIN
         SELECT val
           INTO skrnpar1_
           FROM params
          WHERE par = 'SKRNPAR1';
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            skrnpar1_ := 0;
      END;

      BEGIN
         SELECT val
           INTO skrnpar2_
           FROM params
          WHERE par = 'SKRNPAR2';
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            skrnpar2_ := 0;
      END;

      BEGIN
         SELECT val
           INTO skrnpar3_
           FROM params
          WHERE par = 'SKRNPAR3';
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            skrnpar3_ := 1;
      END;

      BEGIN
         SELECT a.nls, a.nms
           INTO nlskas_, nmskas_
           FROM accounts a
          WHERE a.nls = (SELECT val
                           FROM branch_parameters
                          WHERE tag = 'DEP_KAS' AND branch = branch_)
        and a.kv = 980;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
      bars_error.raise_nerror(l_mod, 'PARAM_NOT_FOUND', 'DEP_KAS');
      END;

      BEGIN
         SELECT rnk
           INTO def_rnk_
           FROM customer a
          WHERE a.rnk = (SELECT val
                           FROM branch_parameters
                          WHERE tag = 'DEP_SKRN' AND branch = branch_);
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
      bars_error.raise_nerror(l_mod, 'PARAM_NOT_FOUND', 'DEP_SKRN');
      END;

      BEGIN
         SELECT a.nls, a.nms
           INTO nls9898_, nms9898_
           FROM accounts a
          WHERE a.nls = (SELECT val
                           FROM branch_parameters
                          WHERE tag = 'DEP_S1' AND branch = branch_)
        and a.kv = 980;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            nls9898_ := NULL;
            nms9898_ := NULL;
      END;

      BEGIN
         SELECT a.nls, a.nms
           INTO nls9819_, nms9819_
           FROM accounts a
          WHERE a.nls = (SELECT val
                           FROM branch_parameters
                          WHERE tag = 'DEP_S2' AND branch = branch_)
        and a.kv = 980;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            nls9819_ := NULL;
            nms9819_ := NULL;
      END;

      BEGIN
         SELECT a.nls, a.nms
           INTO nls6519_, nms6519_
           FROM accounts a
          WHERE a.nls = (SELECT val
                           FROM branch_parameters
                          WHERE tag = 'DEP_S3' AND branch = branch_)
        and a.kv = 980;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN  null;
      bars_error.raise_nerror(l_mod, 'PARAM_NOT_FOUND', 'DEP_S3');
      END;


      BEGIN
         SELECT a.nls, a.nms
           INTO nlss2909_, nmss2909_
           FROM accounts a
          WHERE a.nls = (SELECT val
                           FROM branch_parameters
                          WHERE tag = 'DEP_S5' AND branch = branch_)
        and a.kv = 980;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
      bars_error.raise_nerror(l_mod, 'PARAM_NOT_FOUND', 'DEP_S5');
      END;

      BEGIN
         SELECT a.nls, a.nms
           INTO nlss3579_, nmss3579_
           FROM accounts a
          WHERE a.nls = (SELECT val
                           FROM branch_parameters
                          WHERE tag = 'DEP_S6' AND branch = branch_)
        and a.kv = 980;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            nlss3579_ := NULL;
            nmss3579_ := NULL;
      END;

      BEGIN
         SELECT a.nls, a.nms
           INTO nlsnds_, nmsnds_
           FROM accounts a
          WHERE a.nls = (SELECT val
                           FROM branch_parameters
                          WHERE tag = 'DEP_S7' AND branch = branch_)
        and a.kv = 980;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            nlsnds_ := NULL;
            nmsnds_ := NULL;
      END;

      BEGIN
         SELECT a.nls, a.nms
           INTO nls_s9_, nms_s9_
           FROM accounts a
          WHERE a.nls = (SELECT val
                           FROM branch_parameters
                          WHERE tag = 'DEP_S9' AND branch = branch_)
          and a.kv = 980;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            nls_s9_ := NULL;
            nms_s9_ := NULL;
      END;

      BEGIN
         SELECT a.nls, a.nms
           INTO nls6397_, nms6397_
           FROM accounts a
          WHERE a.nls = (SELECT val
                           FROM branch_parameters
                          WHERE tag = 'DEP_S10' AND branch = branch_)
        and a.kv = 980;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
      nls6397_ := null;
      nms6397_ := null;
      END;

      SELECT ID
        INTO userid_
        FROM staff$base
       WHERE id = user_id;

      -- ОКПО
      BEGIN
         SELECT SUBSTR (val, 1, 14), SUBSTR (val, 1, 14)
           INTO okpoa_, okpob_
       FROM branch_parameters
      WHERE tag = 'OKPO' and branch = branch_;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            okpoa_ := '';
            okpob_ := '';
      END;
   END;
-----------------------------------
BEGIN
   init(NULL);
END;
/
show err;
 
PROMPT *** Create  grants  SKRN ***
grant EXECUTE                                                                on SKRN            to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on SKRN            to DEP_SKRN;
grant EXECUTE                                                                on SKRN            to WR_ALL_RIGHTS;

 
 
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/package/skrn.sql =========*** End *** ======
PROMPT ===================================================================================== 
