CREATE OR REPLACE PROCEDURE BARS.p_f70_nn (
   dat_     DATE,
   sheme_   VARCHAR2 DEFAULT 'G',
   pr_op_   NUMBER DEFAULT 1
)
IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :   Процедура формирования #70 для КБ (универсальная)
% COPYRIGHT   :   Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     :   20/02/2018 (05/01/2018, 13/12/2017)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
параметры: Dat_ - отчетная дата
      sheme_ - схема формирования
      pr_op_ - признак операции (1 - купiвля/продаж валюти,
                                 2 - надходження вiд нерезидентiв
                                 3 - всi операцii
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
19/02/2018 для таблицы ZAYAVKA добавлено блок для обработки поля 
           REF (ранее было только поле REF_SPS) и 
           выбираем поле "meta" вместо "aims_code"
05/01/2018 для отбора кода мети продажу из табл. ZAYAVKA добавил условие
           rownum = 1 (замечание из Ровно)
13/12/2017 не будут показатели 32NNN, 33NNN, 41NNN для покупки валюты или 
           35NNN, 40NNN, 42NNN, 99NNN для продажи валюты 
           если сумма док-та после операции округления < 1.00 USD 
20/11/2017 для изменений от 26.04.2017 убрал условие MFO_ = 353553
           (Черниговское РУ) 
06/11/2017 удалил блоки для закрытых МФО
24/10/2017 показатель 71NNNN всегда будет '01' при пустом доп.реквизите 
25/09/2017 не будут включаться суммы док-тов которые после операции 
           округления < 100 (1 USD) 
09/08/2017 для проводок Дт 2625 Кт 3800 с доп.реквизитом "OW_AM" и если 
            значение содержит текст "/980" добавил d1#D3_ = '16'
26/07/2017 при формировании #70 дополнительно будем вибирать проводки
           перечисления данной валюты (Дт 2600 Кт 3739)
18/07/2017 при формировании #D3 будут включаться проводки  Дт 2555 Кт 2900  
10/07/2017 для проводок Дт 2625 Кт 3800 
           значение показателя 40 будет равен 16 и 
           значение показателя 99 будет равен 'продаж з іншою метою'
08/06/2017 для проводок Дт 2625 Кт 3800 включаем проводки с доп.реквизитом
           "OW_AM" и если значение содержит текст "/980"
07/06/2017 для файла #D3 не будут включаться проводки Дт 2625, 3570 Кт 2900
02/06/2017 будут включаться все суммы док-тов >= 0.01 (0.01 USD)
23/05/2017 на 02.06.2017 будут включаться все суммы док-тов > 100 (1 USD)
05/05/2017 для изменений от 26.04.2017 добавил условие MFO_ = 353553
           (только для Черниговского РУ) 
26/04/2017 для проводок Дт 2600 Кт 2900 дополнительно ищем проводку 
           Дт 2900 Кт 3739 и по ней определяем код меты 
           (поле AIMS_CODE табл. ZAYAVKA где REF_SPS = REF проводки 
05/12/2016 добавлена корреспонденция дт 2525,2546 кт 3800
           для корреспонденций дт 2610,2615,2630,2635,2525,2546 кт 3800
           сегмент 40='38', расширена расшифровка сегмента 99 
25/11/2016 проводка Дт 29003 Кт 26039301886 включалась в блок продажи 
           валюты вместо покупки. Исправлено.
21/11/2016 для МФО=300465 будем включать проводки Дт 29003 Кт 26039301886
19/07/2016 для показателей 62='804', 64='804', 65='8040000000' 
           будем формировать значения '0'(ноль) в показателях 65 и 66 
01/04/2016 для строки 1101 для переменной OKPO_ будем выбирать первых 14 
           символов
23/03/2016 будут включаться суммы документов строго больше 1000$ 
23/02/2016 протокол формирования будет сохраняться в таблицу 
           OTCN_TRACE_70
12/10/2015 Откоментарил формирование пок-ля 99 в зависимости от кода меты
11/08/2015 для всех РУ СБ при формировании #70, #D3
           будут включаться проводки
           #70 - Дт 2900  Кт 2520,2530,2541,2542,2544,2545
           #D3 - Дт 2520,2530,2541,2544  Кт 2900  
02/07/2015 Будут включаться проводки Дт 2620,2625 Кт 3800  (замечание СБ)
           Закоментарил формирование пок-ля 99 в зависимости от кода меты
22/06/2015 для 300465 показатель 99 (відомості про операцію) будем 
           формировать в зависимости от кода меты покупки 
           (службова Рощиної 52-18/773 від 12.06.2015)
12/06/2015 для Сбербанка(300465) для продажи будем включать проводки
           Дт 2603  Кт 3739 и назначение "перерахування кошт_в на продаж" 
29/05/2015 Будут включаться проводки Дт 2610,2615,2630,2635 Кт 3800 
           (замечание СБ)
26/05/2015 Будут включаться проводки Дт 2900 Кт 2602 (замечание СБ)
02/03/2015 Удалила дубли проводок, включаются проводки вида 2600 - 2900, а 
           затем 2900 - 3739. Вторую часть удаляєм.
13/02/2015 для продажи валюты код мети продажу дополнительно определяем из
           таблицы ZAYAVKA поле "aims_code"
02/10/2014 для 300120 показатель 71NNNN всегда будет '01'
01/09/2014 для покупки будут включаться док-ты с суммой не менее 100000.00$
17/07/2014 для Сбербанка(300465) и пока только для Харькова (351823) 
           для продажи будем удалять проводки 
           Дт 2600,2620,2650  Кт 2900 которые есть в табл. ZAYAVKA
14/07/2014 для Сбербанка(300465) для продажи будем включать проводки
           Дт 2900,2600,2620,2650  Кт 3739 и назначение "перерахування 
           коштів на продаж"
25/06/2014 для Сбербанка(300465) для продажи будем включать проводки
           Дт 2603  Кт 3739 и назначение "перерахування кошт_в для
           обов_язкового продажу" 
28/05/2014 исключаем проводки по конверсии (после внедрения модуля  
           конвертации валют) эти проволдки существуют в табл. ZAYAVKA и 
           для них DK=3
09/04/2014 включались суммы док-тов >=1001$ а необходимо 1000.01$ и больше 
03/04/2014 будут отбираться суммы документов строго больше 1000$ 
26/02/2014 не включаем проводки Дт 2900 Кт 2900 и D#39 in (110,120,131,132)
25/02/2014 для продажи не включались суммы которые в эквиваленте больше 
           1000.00$  
19/02/2014 для физлиц резидентов не имеющих ОКРО определяем серию и номер
           паспорта
17/02/2014 для продажи включались суммы которые в эквиваленте меньше 
           1000.00$ но общая сумма для клиента в эквиваленте больше 
           1000.00$ (было в ГОУ)
14/02/2014 для продажи не включались суммы которые в эквиваленте больше 
           1000.00$ (750.00 евро)
13/02/2014 для продажи будут включаться док-ты с суммой не менее 1000.00$
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
   kodf_      VARCHAR2 (2)   := '70';
   sql_z      VARCHAR2 (200);
   typ_       NUMBER;
   gr_sum_    NUMBER         := 5000000;     --для покупки
   gr_sumn_   NUMBER         := 5000000;     -- було до 13.08.2007 10000000;
   -- для продажу i надходження вiд нерезидентiв
   flag_      NUMBER;
   -- флаг для определение наличия поля BENEFCOUNTRY т.TOP_CONTRACTS
   -- (из модуля биржевые операции)
   pr_s3_     NUMBER;    -- флаг для определение наличия поля S3 табл.ZAYAVKA
   -- (из модуля биржевые операции)
   s3_        NUMBER;
   ko_        VARCHAR2 (2);      -- ознака операцii з безготiвковою iнвалютою
   ko_1       VARCHAR2 (2);      -- ознака операцii з безготiвковою iнвалютою
   kod_b      VARCHAR2 (10);                          -- код iноземного банку
   nam_b      VARCHAR2 (70);                        -- назва iноземного банку
   n_         NUMBER         := 10;
   -- кол-во доп.параметров до 03.07.2006 после n_=11
   acc_       NUMBER;
   acck_       NUMBER;
   kv_        NUMBER;
   kv1_       NUMBER;
   nls_       VARCHAR2 (15);
   nlsk_      VARCHAR2 (15);
   nlsk1_     VARCHAR2 (15);
   nbuc1_     VARCHAR2 (12);
   nbuc_      VARCHAR2 (12);
   country_   VARCHAR2 (3);
   country_b  VARCHAR2 (3);
   b010_      VARCHAR2 (10);
   kod_b_     VARCHAR2 (10);
   bic_code   VARCHAR2 (14);
   rnk_       NUMBER;
   okpo_      VARCHAR2 (14);
   ourOKPO_   varchar2(14);
   ourGLB_    varchar2(3); 
   nmk_       VARCHAR2 (70);
   adr_       VARCHAR2 (70);
   k040_      VARCHAR2 (3);
   k110_      VARCHAR2 (5);
   val_       VARCHAR2 (70);
   d1#70_     VARCHAR2 (70);
   d6#70_     VARCHAR2 (70);
   d1#D3_     VARCHAR2 (70);
   nazn_      VARCHAR2 (160);
   a1_        VARCHAR2 (70);
   a2_        VARCHAR2 (70);
   a3_        VARCHAR2 (70);
   a4_        VARCHAR2 (70);
   a5_        VARCHAR2 (70);
   a6_        VARCHAR2 (70);
   a7_        VARCHAR2 (70);
   nb_        VARCHAR2 (70);
   nb1_       VARCHAR2 (70);
   tg_        VARCHAR2 (70);
   data_      DATE;
   dig_       NUMBER;
   bsum_      NUMBER;
   bsu_       NUMBER;
   sum1_      DECIMAL (24);
   sum0_      DECIMAL (24);
   sumk1_     DECIMAL (24);                 --комiсiя в цiлому по контрагенту
   sumk0_     DECIMAL (24);                            --комiсiя по контракту
   kodp_      VARCHAR2 (10);
   znap_      VARCHAR2 (70);
   kurs_      NUMBER;
   kurs1_     NUMBER;
   tag_       VARCHAR2 (5);
   nnnn_      NUMBER         := 0;
   userid_    NUMBER;
   ref_       NUMBER;
   rez_       NUMBER;
   codc_      NUMBER;
   mfo_       number;
   mfou_      number;
   koldop_    number;
   refd_      number;
   s0_        varchar2(16);
   kol_       number;
   swift_k_   VARCHAR2 (12);
   --branch_    customer.branch%TYPE;
   branch_      customer.tobo%TYPE;
   ser_       person.ser%TYPE;
   numdoc_    person.numdoc%TYPE;
   kod_obl_   varchar2 (2);
   dat_Izm1_  DATE := to_date('21032016','ddmmyyyy'); -- новая сумма отбора 1000.00 
   dat_Izm2_  DATE := to_date('01062017','ddmmyyyy'); -- новая сумма отбора 1.00 

--курсор по контрагентам
   CURSOR c_main
   IS
      SELECT   t.ko, 
               nvl(decode(substr(b.b040,9,1),'2',substr(b.b040,15,2),substr(b.b040,10,2)),nbuc_), 
               c.rnk, c.okpo, c.nmk, TO_CHAR (c.country), c.adr,
               NVL (c.ved, '00000'), c.codcagent, 
               1, 
               SUM (t.s_eqv),
               SUM (gl.p_icurval (t.kv, t.s_kom, dat_))
                                                    --сумма в формате грн.коп
          FROM OTCN_PROV_TEMP t, customer c, tobo b  --branch b
         WHERE t.rnk = c.rnk
           and c.tobo = b.tobo(+)  --c.branch = b.branch 
      GROUP BY t.ko,
               nvl(decode(substr(b.b040,9,1),'2',substr(b.b040,15,2),substr(b.b040,10,2)),nbuc_), 
               c.rnk,
               c.okpo,
               c.nmk,
               TO_CHAR (c.country),
               c.adr,
               NVL (c.ved, '00000'),
               c.codcagent, 
               1 
      ORDER BY 2, 3;

--- Покупка/Продаж безготiвковоi валюти i надходження вiд нерезидентiв
   CURSOR opl_dok
   IS
      SELECT   t.ko, t.REF, t.acck, t.nlsk, t.kv, t.accd, t.nlsd, t.nazn, 
               SUM (t.s_nom),
               SUM (t.s_kom)
          FROM OTCN_PROV_TEMP t
         WHERE t.rnk = rnk_
      GROUP BY t.ko, t.REF, t.acck, t.nlsk, t.kv, t.accd, t.nlsd, t.nazn;

-------------------------------------------------------------------
   PROCEDURE p_ins (p_np_ IN NUMBER, p_kodp_ IN VARCHAR2, p_znap_ IN VARCHAR2)
   IS
      l_kodp_   VARCHAR2 (10);
   BEGIN
      l_kodp_ := p_kodp_ || LPAD (TO_CHAR (p_np_), 3, '0');

      INSERT INTO rnbu_trace
                  (nls, kv, odate, kodp, znap, nbuc, ref, rnk, comm
                  )
           VALUES (nls_, kv_, dat_, l_kodp_, p_znap_, nbuc_, ref_, rnk_, to_char(refd_)
                  );
   END;

-------------------------------------------------------------------
   FUNCTION f_benef_country (p_ref_ IN NUMBER)
      RETURN VARCHAR2
   IS
      code_     NUMBER;
      v_code_   VARCHAR2 (3)   := NULL;
      sql_      VARCHAR2 (200);
   BEGIN
      IF flag_ >= 1
      THEN
         sql_ :=
               'select t.benefcountry '
            || 'from zayavka z, TOP_CONTRACTS t '
            || 'where z.ref=:p_ref_ and '
            || '		z.dk=1 and '
            || '		z.pid=t.pid';

         EXECUTE IMMEDIATE sql_
                      INTO code_
                     USING p_ref_;

         v_code_ := LPAD (TRIM (code_), 3, '0');
      END IF;

      RETURN v_code_;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         RETURN NULL;
   END;

-------------------------------------------------------------------
   FUNCTION f_benef_bic (p_ref_ IN NUMBER)
      RETURN VARCHAR2
   IS
      bic_   VARCHAR2 (12)  := NULL;
      sql_   VARCHAR2 (200);
   BEGIN
      IF flag_ >= 1
      THEN
         sql_ :=
               'select t.benefbic '
            || 'from zayavka z, TOP_CONTRACTS t '
            || 'where z.ref=:p_ref_ and '
            || '      z.dk=1 and '
            || '      z.pid=t.pid';

         EXECUTE IMMEDIATE sql_
                      INTO bic_
                     USING p_ref_;
      END IF;

      RETURN bic_;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         RETURN NULL;
   END;
-------------------------------------------------------------------
   FUNCTION f_benef_bank (p_ref_ IN NUMBER)
      RETURN VARCHAR2
   IS
      nam_b  VARCHAR2 (70)  := NULL;
      sql_   VARCHAR2 (200);
   BEGIN
      IF flag_ >= 1
      THEN
         sql_ :=
               'select t.benefbank '
            || 'from zayavka z, TOP_CONTRACTS t '
            || 'where z.ref=:p_ref_ and '
            || '      z.dk=1 and '
            || '      z.pid=t.pid';

         EXECUTE IMMEDIATE sql_
                      INTO nam_b
                     USING p_ref_;
      END IF;

      RETURN nam_b;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         RETURN NULL;
   END;
-------------------------------------------------------------------
   PROCEDURE p_tag (
      p_i_       IN       NUMBER,
      p_value_   IN OUT   VARCHAR2,
      p_kodp_    OUT      VARCHAR2,
      p_ref_     IN       NUMBER DEFAULT NULL
   )
   IS
   BEGIN
      IF p_i_ = 1
      THEN
         p_kodp_ := '40';

         IF ko_ = 1
         THEN
            p_value_ :=
                    NVL (LPAD (TRIM (SUBSTR (p_value_, 1, 2)), 2, '0'), '00');
         END IF;

         IF ko_ = 2
         THEN
            if d1#D3_ is not null then
                p_value_ :=
                        NVL (LPAD (TRIM (SUBSTR (d1#D3_, 1, 2)), 2, '1'), '00');
            else
                p_value_ :=
                        NVL (LPAD (TRIM (SUBSTR (p_value_, 1, 2)), 2, '1'), '00');
            end if;

            if nls_ like '2900205%' and nlsk_ like '29003%' or
               --nls_ like '2909%' and nlsk_ like '2900%' or
               nls_ like '2625%' and nlsk_ like '2900%' or 
               nls_ like '2625%' and nlsk_ like '3800%' 
            then
               p_value_ := '16';     
               d1#D3_ := '16';
            end if;

            if ( nls_ like '2610%'  or  nls_ like '2615%'  or
                 nls_ like '2630%'  or  nls_ like '2635%'  or
                 nls_ like '2525%'  or  nls_ like '2546%' )
               and nlsk_ like '3800%' 
            then
               p_value_ := '38';     
               d1#D3_ := '38';
            end if;
         END IF;

         IF ko_ = 3
         THEN
            p_value_ := NVL (SUBSTR (TRIM (p_value_), 1, 2), '00');
         END IF;
         
         d1#70_ := p_value_;
      ELSIF p_i_ = 2
      THEN
         p_kodp_ := '51';
         p_value_ := NVL (SUBSTR (TRIM (p_value_), 1, 70), 'N контр.');

         if ko_ = 2 and (trim(p_value_) is null or trim(p_value_)='N контр.') 
         then
            a2_ := ' ';
            IF pr_s3_ >= 1
            THEN
               sql_z := 'SELECT contract, to_char(id) '
                     || 'FROM ZAYAVKA  '
                     || 'WHERE REF = :ref_';

               BEGIN
                  EXECUTE IMMEDIATE sql_z
                     INTO p_value_, a2_
                  USING ref_ ;
               EXCEPTION WHEN NO_DATA_FOUND THEN
                 a2_ := ' ';  
               END;
            END IF;

            if trim(p_value_) is null or trim(p_value_)='N контр.' then  --and trim(a2_) is not null then
               p_value_ := a2_;
            end if;
         end if;
      ELSIF p_i_ = 3
      THEN
         p_kodp_ := '52';
         p_value_ := NVL (SUBSTR (TRIM (p_value_), 1, 70), 'DDMMYYYY');

         if ko_ = 2 and (trim(p_value_) is null or trim(p_value_)='DDMMYYYY') 
         then
            a3_ := ' ';
            IF pr_s3_ >= 1
            THEN
               sql_z := 'SELECT NVL(to_char(datz,''DDMMYYYY''),''DDMMYYYY''),'
                     || '       NVL(to_char(fdat,''DDMMYYYY''),''DDMMYYYY'') '
                     || 'FROM ZAYAVKA  '
                     || 'WHERE REF = :ref_';
               BEGIN
                  EXECUTE IMMEDIATE sql_z
                     INTO p_value_, a3_
                  USING ref_ ;
               EXCEPTION WHEN NO_DATA_FOUND THEN
                  a3_ := ' ';  
               END;
            END IF;

            if (trim(p_value_) is null or trim(p_value_)='DDMMYYYY') then --and trim(a3_) is not null then
               p_value_ := a3_;
            end if;
         end if;
      ELSIF p_i_ = 4
      THEN
         p_kodp_ := '60';

         if ko_ = 1 and trim(p_value_) is null
         then
            BEGIN
               select trim(w.value)
                  into p_value_
               from provodki_otc p, operw w
               where p.fdat = dat_
                 and p.kv = kv_ 
                 and p.s*100 = sum0_
                 and p.nlsd = nls_ 
                 and p.ref = w.ref
                 and w.tag like 'D4#70%';
            EXCEPTION WHEN NO_DATA_FOUND THEN
               null;  
            END;            
         end if;

         p_value_ := NVL (SUBSTR (TRIM (p_value_), 1, 70), ''); --'DDMMYYYY');
      ELSIF p_i_ = 5
      THEN
         p_kodp_ := '61';
         p_value_ := NVL (SUBSTR (TRIM (p_value_), 1, 70), ''); --'дати iнших ВМД');
      ELSIF p_i_ = 6
      THEN
         p_kodp_ := '62';

         IF p_value_ IS NOT NULL
         THEN
            p_value_ := LPAD (p_value_, 3, '0');
         END IF;

         p_value_ :=
            NVL (SUBSTR (TRIM (p_value_), 1, 70),
                 'код краiни банку-бенефiцiара'
                );
         country_ := SUBSTR (TRIM (p_value_), 1, 3);
      ELSIF p_i_ = 7
      THEN
         p_kodp_ := '63';
         p_value_ :=
              NVL (SUBSTR (TRIM (p_value_), 1, 70), 'пiдстава для придбання');
      ELSIF p_i_ = 8
      THEN
         p_kodp_ := '64';

         IF p_value_ IS NULL
         THEN
            p_value_ := f_benef_country (p_ref_);
         END IF;

         IF p_value_ IS NOT NULL
         THEN
            p_value_ := LPAD (p_value_, 3, '0');
         END IF;

         country_b := SUBSTR (TRIM (p_value_), 1, 3);

         p_value_ :=
            NVL (SUBSTR (TRIM (p_value_), 1, 70),
                 'код краiни клiєнта-бенефiцiара'
                );
      -- новi коди (добавляються з 01.07.2005)
      ELSIF p_i_ = 9
      THEN
         p_kodp_ := '65';
         bic_code := f_benef_bic (p_ref_);

         BEGIN
            SELECT   NVL (MIN (b010), '0000000000')
                INTO b010_
                FROM rc_bnk
               WHERE k040 = country_
                 AND TRIM (swift_code) = TRIM (bic_code)
                 AND swift_code IS NOT NULL
            GROUP BY swift_code;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
            BEGIN
               SELECT substr(trim(value), 1, 12)
                  INTO swift_k_
               FROM OPERW
               WHERE REF=REF_
                 AND TAG LIKE '57A%'
                 AND ROWNUM=1;

               BEGIN
                  SELECT b010
                     INTO p_value_
                  FROM RC_BNK
                  WHERE SWIFT_CODE LIKE swift_k_||'%'
                    AND ROWNUM=1;
               EXCEPTION WHEN NO_DATA_FOUND THEN
                  swift_k_ := substr(swift_k_,1,4)||' '||substr(swift_k_,5,2)||
                              ' '||substr(swift_k_,7,2);
                  BEGIN
                     SELECT b010
                        INTO p_value_
                     FROM RC_BNK
                     WHERE SWIFT_CODE LIKE swift_k_||'%'
                       AND ROWNUM=1;
                  EXCEPTION WHEN NO_DATA_FOUND THEN
                     null;
                  END;
               END;
            EXCEPTION WHEN NO_DATA_FOUND THEN
               BEGIN
                  SELECT substr(trim(value), 1, 12)
                     INTO swift_k_
                  FROM OPERW
                  WHERE REF=REF_
                    AND TAG LIKE '57D%'
                    AND ROWNUM=1;

                  BEGIN
                     SELECT b010
                        INTO p_value_
                     FROM RC_BNK
                     WHERE SWIFT_CODE LIKE swift_k_||'%'
                       AND ROWNUM=1;
                  EXCEPTION WHEN NO_DATA_FOUND THEN
                     swift_k_ := substr(swift_k_,1,4)||' '||substr(swift_k_,5,2)||
                                 ' '||substr(swift_k_,7,2);
                     BEGIN
                        SELECT b010
                           INTO p_value_
                        FROM RC_BNK
                        WHERE SWIFT_CODE LIKE swift_k_||'%'
                          AND ROWNUM=1;
                     EXCEPTION WHEN NO_DATA_FOUND THEN
                        null;
                     END;
                  END;
               EXCEPTION WHEN NO_DATA_FOUND THEN
                  BEGIN
                     SELECT substr(trim(value), 1, 12)
                        INTO swift_k_
                     FROM OPERW
                     WHERE REF=REF_
                       AND TAG='57'
                       AND length(trim(value))>3
                       AND ROWNUM=1;

                     BEGIN
                        SELECT b010
                           INTO p_value_
                        FROM RC_BNK
                        WHERE SWIFT_CODE LIKE swift_k_||'%'
                          AND ROWNUM=1;
                     EXCEPTION WHEN NO_DATA_FOUND THEN
                        swift_k_ := substr(swift_k_,1,4)||' '||substr(swift_k_,5,2)||
                                    ' '||substr(swift_k_,7,2);
                        BEGIN
                           SELECT b010
                              INTO p_value_
                           FROM RC_BNK
                           WHERE SWIFT_CODE LIKE swift_k_||'%'
                             AND ROWNUM=1;
                        EXCEPTION WHEN NO_DATA_FOUND THEN
                           null;
                        END;
                     END;
                  EXCEPTION WHEN NO_DATA_FOUND THEN
                     BEGIN
                        SELECT substr(trim(value), 1, 12)
                           INTO swift_k_
                        FROM OPERW
                        WHERE REF=REF_
                          AND TAG='NOS_B'
                          AND ROWNUM=1;

                        swift_k_ := substr(swift_k_,1,4)||' '||substr(swift_k_,5,2)||
                                    ' '||substr(swift_k_,7,2);
                        BEGIN
                           SELECT b010
                              INTO p_value_
                           FROM RC_BNK
                           WHERE SWIFT_CODE LIKE swift_k_||'%'
                             AND ROWNUM=1;
                        EXCEPTION WHEN NO_DATA_FOUND THEN
                           null;
                        END;
                     EXCEPTION WHEN NO_DATA_FOUND THEN
                        null;
                     END;
                  END;
               END;
            END;

            b010_ := NVL (SUBSTR (TRIM (p_value_), 1, 10), '0000000000');

         END;

         nb_ := f_benef_bank (p_ref_);
         nb1_:= nb_;

         IF b010_ <> '0000000000'
         THEN
            BEGIN
               SELECT NVL (b010, '0000000000'),
                      NVL (NAME, 'назва iноземного банку')
                 INTO p_value_,
                      nb_
                 FROM rc_bnk
                WHERE b010 = b010_;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  p_value_ := country_||'0000000';  --'код iноземного банку';
                  nb_ := NVL(trim(nb_),'назва iноземного банку');
            END;
            kod_b_ := p_value_;
         ELSE
            p_value_ := nvl(trim(p_value_), country_||'0000000');
            kod_b_ := p_value_;
            p_value_ :=
                NVL (SUBSTR (TRIM (p_value_), 1, 70), 'код iноземного банку');

            nb_ := trim(nb_);
         END IF;

         if mfo_=322498 and trim(nb1_) is not null then
            nb_ := nb1_;
         end if;

         IF trim(d1#70_) in ('03','07') THEN
            p_value_:='0';
         END IF;
         
         -- новый блок по служебной записке от 15.07.2016 (Рощина)
         if country_ = '804' and country_b = '804' and kod_b_ = '8040000000' 
         then 
            p_value_:='0';
         END IF;
      ELSIF p_i_ = 10
      THEN
         p_kodp_ := '66';

         IF p_value_ IS NULL
         THEN
            p_value_ :=
                   NVL (SUBSTR (TRIM (nb_), 1, 70), 'назва iноземного банку');
         END IF;

         IF p_value_ IS NOT NULL AND nb_ IS NOT NULL
         THEN
            p_value_ :=
                   NVL (SUBSTR (TRIM (nb_), 1, 70), 'назва iноземного банку');
         ELSE
            p_value_ :=
               NVL (SUBSTR (TRIM (p_value_), 1, 70),
                    'назва iноземного банку');
         END IF;

         IF trim(d1#70_) in ('03','07') THEN
            p_value_:='0';
         END IF;

         -- новый блок по служебной записке от 15.07.2016 (Рощина)
         if country_ = '804' and country_b = '804' and kod_b_ = '8040000000' 
         then 
            p_value_:='0';
         END IF;
      -- код валютної операції з 01.09.2014 для #70 і з 01.06.2017 для #D3
      ELSIF p_i_ = 11
      THEN
         IF dat_ >= TO_DATE ('03-07-2006','dd-mm-yyyy') and dat_ <= TO_DATE ('01-01-2012','dd-mm-yyyy') 
         THEN
            p_kodp_ := '70';
            p_value_ :=
                  NVL (SUBSTR (TRIM (p_value_), 1, 70), 'код товарної групи');
         END IF;
         -- пока возьмем с доп параметра если он есть
         IF pr_op_ = 1 and trim(d1#70_) <> '01' and p_value_ is null THEN
            p_value_:='0';
         end if;
         -- файл #70
         IF dat_ >= TO_DATE ('01-09-2014','dd-mm-yyyy') and pr_op_ = 1  
         THEN
            p_kodp_ := '71';
            p_value_ :=
                  NVL (SUBSTR (TRIM (p_value_), 1, 70), '01');
         END IF;
         -- файл #D3
         IF dat_ >= dat_Izm2_ and pr_op_ = 3     
         THEN
            p_kodp_ := '42';
            p_value_ :=
                  NVL (SUBSTR (TRIM (p_value_), 1, 70), '01');
         END IF;
     ELSIF p_i_ = 13 
     THEN
        --для продажу валюти i надходження вiд нерезидентiв новий показник
        IF dat_ >= TO_DATE('13082007','ddmmyyyy') AND ko_ = 2 then
           p_kodp_ := '99';
           p_value_ :=NVL (SUBSTR (TRIM (p_value_), 1, 70), '');
           if trim(p_value_) is null then
              BEGIN
                 select DECODE(substr(lower(txt),1,13), 'продано вир.в', 'продаж валютної виручки',txt) 
                    into p_value_
                 from kod_d3_1 
                 where p40 = d1#D3_;
              EXCEPTION WHEN NO_DATA_FOUND THEN
                 null;
              END;  
           end if;
        END IF;

        IF trim(p_value_) is NULL and mfo_ in (300465,333368) 
        THEN 
           p_value_ := substr(nazn_,1,70);
        END IF;

        if mfo_ = 300465 and nlsk_ like '2900%' and nls_ like '2909%' 
        then
           p_value_ := '555';     
        end if;

        if nls_ like '2900205%' and nlsk_ like '29003%' 
        then
           p_value_ := 'вiльний продаж';     
        end if;

        IF mfou_ = 300465 and ko_ = 2 
        THEN 
           case
              when d1#D3_ = '11' then p_value_ := 'Виручка';
              when d1#D3_ = '12' then p_value_ := 'Інвестиційні кошти';
              when d1#D3_ = '13' then p_value_ := 'Кредит банку';
              when d1#D3_ = '14' then p_value_ := 'Продаж ІВ, раніше купленої на МВРУ';
              when d1#D3_ = '15' then p_value_ := 'Власні кошти банку';
              when d1#D3_ = '16' then p_value_ := 'Продано з Іншою метою';
              when d1#D3_ = '18' then p_value_ := 'Кредитні кошти отримані банком від нерезидента';
              when d1#D3_ = '19' then p_value_ := 'Кредит клієнта банку від нерезидента';
              when d1#D3_ = '20' then p_value_ := 'Продаж повернутої передоплати';
              when d1#D3_ = '37' then p_value_ := 'Продаж переказів';
              when d1#D3_ = '38' then p_value_ := 'Повернен.вкладів/погаш.сертифiкатiв в iн.валютi,здiйснене в нац.валютi';
            else                                                                                                        
               p_value_ := null;                               
               d1#D3_ := null;
            end case;
        END IF;
      ELSE
         p_kodp_ := 'NN';
      END IF;

      IF p_kodp_ IN ('52', '60') AND length(trim(p_value_))=9
      THEN
         p_value_ :=
               SUBSTR (p_value_, 1, 1)
            || SUBSTR (p_value_, 3, 2)
            || SUBSTR (p_value_, 6, 4);
      END IF;

      IF p_kodp_ IN ('52', '60') AND length(trim(p_value_))=10
      THEN
         p_value_ :=
               SUBSTR (p_value_, 1, 2)
            || SUBSTR (p_value_, 4, 2)
            || SUBSTR (p_value_, 7, 4);
      END IF;

   END;
-----------------------------------------------------------------------------
BEGIN
   EXECUTE IMMEDIATE 'ALTER SESSION SET NLS_NUMERIC_CHARACTERS=''.,''';
-------------------------------------------------------------------
   userid_ := user_id;

   EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';

   EXECUTE IMMEDIATE 'TRUNCATE TABLE OTCN_PROV_TEMP';
-------------------------------------------------------------------
   -- свой МФО
   mfo_ := F_Ourmfo ();

-- МФО "родителя"
   BEGIN
      SELECT mfou
        INTO mfou_
        FROM BANKS
       WHERE mfo = mfo_;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         mfou_ := mfo_;
   END;
-------------------------------------------------------------------
   IF pr_op_ = 3
   THEN
      kodf_ := 'D3';
   END IF;

-- определение наличия поля BENEFCOUNTRY т.TOP_CONTRACTS
   SELECT COUNT (*)
     INTO flag_
     FROM all_tab_columns
    WHERE owner = 'BARS'
      AND table_name = 'TOP_CONTRACTS'
      AND column_name = 'BENEFCOUNTRY';

-- определение наличия поля S3 табл.ZAYAVKA
   SELECT COUNT (*)
     INTO pr_s3_
     FROM all_tab_columns
    WHERE owner = 'BARS' AND table_name = 'ZAYAVKA' AND column_name = 'S3';

   -- параметры формирования файла
   p_proc_set (kodf_, sheme_, nbuc1_, typ_);
   --- выбор курса долара для пересчета суммы
   kurs_ := f_ret_kurs (840, dat_);

   if kodf_ = 'D3' then
      kurs1_ := f_ret_kurs (840, dat_);  -- f_ret_kurs (kv1_, dat_);
   end if;

   ourOKPO_ := lpad(F_Get_Params('OKPO',null), 8, '0');

   BEGIN
     select lpad(to_char(glb), 3, '0')
        into ourGLB_
     from rcukru
     where mfo=mfo_;
   EXCEPTION WHEN NO_DATA_FOUND THEN
      ourGLB_ := null;
   END;

   -- з 01.06.2009 для продажу валюти включаються всi операцii >=1000000
   -- з 13.08.2007 було 5000000$
   IF dat_>= to_date('01062009','ddmmyyyy') then
      gr_sumn_ := 100;  -- "100" было до 22.09.10 и в Демарке не включилась сумма в руб. 1268 экв. 326;   --1000000;
   END IF;

   -- з 11.02.2014 для продажу валюти включаються всi операцii >=100000 долларов
   IF dat_>= to_date('11022014','ddmmyyyy') then
      gr_sumn_ := 100000;  
   END IF;

   -- з 01.06.2017 для продажу валюти включаються всi операцii >=1.00 (один доллар)
   IF dat_>= dat_Izm2_ then
      gr_sumn_ := 1;  
   END IF;

   -- з 01.09.2014 для купівлі валюти включаються всi операцii >=10000000 долларов
   IF dat_>= to_date('01092014','ddmmyyyy') and dat_ < dat_Izm1_ 
   then
      gr_sum_ := 10000000;  
   END IF;

   -- з 21.03.2016 для купівлі валюти включаються всi операцii >=100000 долларов
   IF dat_>= dat_Izm1_ then
      gr_sum_ := 100000;  
   END IF;

   -- з 01.06.2017 для купівлі валюти включаються всi операцii >=1.00 доллара
   IF dat_>= dat_Izm2_ then
      gr_sum_ := 1;  
   END IF;
    
   -- отбор проводок, удовлетворяющих условию
   INSERT INTO OTCN_PROV_TEMP
               (ko, rnk, REF, acck, nlsk, kv, accd, nlsd, nazn, s_nom, s_eqv)
      SELECT *
        FROM ( 		--купівля валюти
			  SELECT   '1' ko, ca.rnk, o.REF, o.acck, o.nlsk,
			           o.kv, o.accd, o.nlsd, o.nazn, 
                       SUM (o.s * 100) s_nom,
                       SUM (gl.p_icurval (o.kv, o.s * 100, dat_)) s_eqv
                  FROM provodki o, cust_acc ca
                 WHERE o.fdat = dat_
                   AND o.kv not in (959, 961, 962, 964, 980)
                   AND (   (    SUBSTR (o.nlsd, 1, 4) = '2900'
                            AND SUBSTR (o.nlsk, 1, 4) IN
                                     ('1600', '1602', '2520', '2530', 
                                      '2541', '2542', '2544', '2545', 
                                      '2600', '2602', '2620', '2650')
                            AND LOWER (TRIM (o.nazn)) not like '%конверс%'
                            AND LOWER (TRIM (o.nazn)) not like '%конверт%'
                            AND LOWER (TRIM (o.nazn)) not like '%за рахунок _ншо_%'
                           )
                        OR (    SUBSTR (o.nlsd, 1, 4) = '2903'
                            AND SUBSTR (o.nlsk, 1, 4) = '2900'
                           )
                        OR (    o.nlsd LIKE '29003%'    -- 21/11/2016 звернення SC-0007882 від УВК.zip 
                            AND o.nlsk LIKE '26039301886%'
                            AND mfo_ = 300465 
                           )
                       )
                   AND o.acck = ca.acc
              GROUP BY '1', ca.rnk, o.REF, o.acck, o.nlsk, o.kv, o.accd, o.nlsd, o.nazn 
              UNION ALL -- продаж валюти
              SELECT   '2' ko, ca.rnk, o.REF, o.accd, o.nlsd, o.kv, o.acck, o.nlsk, o.nazn, 
                       SUM (o.s * 100) s_nom,
                       SUM (gl.p_icurval (o.kv, o.s * 100, dat_)) s_eqv
                  FROM provodki o, cust_acc ca
                 WHERE o.fdat = dat_
                   AND o.kv not in (959, 961, 962, 964, 980)
                   AND (   (    SUBSTR (o.nlsk, 1, 4) = '2900'
                            AND                     
                                SUBSTR (o.nlsd, 1, 4) IN
                                     ('1600', '1602', '2520', '2530', 
                                      '2541', '2544', '2555', '2600', '2603',
                                      '2620', '2650', '3640')
                            AND LOWER (TRIM (o.nazn)) not like '%конверс%'
                            AND LOWER (TRIM (o.nazn)) not like '%конверт%'
                            AND LOWER (TRIM (o.nazn)) not like '%куп_вля%'
                           )
                        OR (    SUBSTR (o.nlsk, 1, 4) = '2900'
                            AND SUBSTR (o.nlsd, 1, 4) in ('2062','2063','2072','2073'))
                        OR (    SUBSTR (o.nlsk, 1, 4) = '2903'
                            AND SUBSTR (o.nlsd, 1, 4) = '2900'
                           )
                        OR (    SUBSTR (o.nlsk, 1, 4) = '2900'  -- 14.12.2012 было сделано только для Сбербанка
                            AND SUBSTR (o.nlsd, 1, 4) = '2909'  -- 28.12.2012 для Всех (убрал МФО)
                           )
                        OR (    SUBSTR (o.nlsd, 1, 4) = '2900'
                            AND SUBSTR (o.nlsk, 1, 4) = '2900'
                            AND mfou_ = 300465 AND mfou_ <> mfo_ 
                            AND LOWER (TRIM (o.nazn)) like '%продаж%'                            
                          )
                        OR (    o.nlsd LIKE '2900205%'    -- по письму Уманец от 16.04.2013 
                            AND o.nlsk LIKE '29003%'
                            AND mfo_ = 300465 
                           )
                        OR (    SUBSTR (o.nlsd, 1, 4) = '2603'
                            AND SUBSTR (o.nlsk, 1, 4) = '3739'
                            AND mfou_ = 300465 
                            AND ( LOWER (TRIM (o.nazn)) like '%перерахування кошт_в для обов_язкового продажу%' OR 
                                  LOWER (TRIM (o.nazn)) like '%перерахування кошт_в на продаж%'
                                )
                           )
                        OR (    SUBSTR (o.nlsd, 1, 4) in ('2900', '2600', '2620', '2650')
                            AND SUBSTR (o.nlsk, 1, 4) = '3739'
                            AND mfou_ = 300465 
                            AND ( LOWER (TRIM (o.nazn)) like '%перерахування кошт_в для обов_язкового продажу%' OR 
                                  LOWER (TRIM (o.nazn)) like '%перерахування кошт_в на продаж%'
                                )
                           )
                        OR (    SUBSTR (o.nlsd, 1, 4) in ('2610','2615', '2620','2625',
                                                          '2630','2635', '2525','2546')
                            AND SUBSTR (o.nlsk, 1, 4) = '3800'
                            AND mfou_ = 300465 
                           )
                       ) 
                   AND o.accd = ca.acc
              GROUP BY '2', ca.rnk, o.REF, o.accd, o.nlsd, o.kv, o.acck, o.nlsk, o.nazn );

   -- для РУ Ощадбанку видаляємо проводки виду Дт 2600/2620/2650 Кт 2900
   -- якщо наявна заявка на продаж валюти на цю суму по цьому клієнту в найближчі +/- 3 дні
   if mfou_ = 300465 and mfo_ = 351823 
   then 
      DELETE FROM otcn_prov_temp a
      WHERE 
        (select max(id) from zayavka z 
           where z.dk=2 and z.s2=a.s_nom and z.kv2=a.kv and abs(z.fdat-dat_)<4 and z.acc1=a.accd) is not null
        and SUBSTR (a.nlsk, 1, 4) in ('2600', '2620', '2650')
        and a.nlsd like '2900%';
   end if;
   
   -- удаляем проводки вида Дт 2900 Кт 2900 для продажи если это не ЦБ
   if mfo_ <> 300465 
   then 
      DELETE FROM otcn_prov_temp a
      WHERE a.nlsd like '2900%' 
        and a.nlsk like '2900%' 
        and a.ko = 2 
        and a.ref not in (SELECT ref 
                          FROM provodki 
                          WHERE ref=a.ref
                            and (nlsd like '2901%' or nlsk like '2901%'))
        and a.ref not in (SELECT ref 
                          FROM operw 
                          WHERE ref=a.ref
                            and tag ='D#39'
                            and trim(value) is not null
                            and trim(value) not in ('110','120','131','132'));
   end if;

   -- удаляем все проводки Дт 2909 Кт 2900 кроме Дт 2909 (OB22=56) Кт 2900 (OB22=01) Cбербанк
   if mfou_ = 300465 
   then
      delete from otcn_f70_temp a
      where a.nlsd like '2900%' 
        and a.nlsk like '2909%'
        and a.accd in ( select acc 
                        from specparam_int 
                        where acc in (select acc 
                                      from accounts 
                                      where nbs='2900') 
                          and NVL(trim(ob22),'00') <> '01'
                      );
   end if;

   if mfou_ = 300465 and pr_op_ = 3 
   then
      delete from otcn_prov_temp a
      where a.nlsk like '2900%' 
        and a.nlsd like '3739%' 
        and exists ( select 1 
                     from otcn_prov_temp b
                     where b.accd = a.acck 
                       and b.s_nom = a.s_nom
                   ) 
        and a.ref in ( select ref_sps
                       from zayavka
                     );     
   end if;
   
   -- 08.06.2017 для продажи 
   -- для корреспонденции Дт 2625 Кт 3800 включаем проводки 
   -- только с доп.реквизитом OW_AM и в значении есть текст "/980"
   if mfou_ = 300465 and pr_op_ = 3 
   then
      delete from otcn_prov_temp a
      where a.nlsk like '2625%' 
        and a.nlsd like '3800%' 
        and not exists ( select 1 
                         from operw b
                         where b.ref = a.ref 
                           and b.tag like 'OW_AM%'
                           and b.value like '%/980%'
                       ); 
   end if;
   
   IF pr_s3_ >= 1
   THEN
      sql_z :=
            'UPDATE OTCN_PROV_TEMP t '
         || 'SET t.s_kom=(SELECT z.s3 FROM ZAYAVKA z WHERE z.REF = t.REF) '
         || 'WHERE t.REF IN (SELECT REF FROM ZAYAVKA WHERE NVL(s3,0) <> 0)';

      EXECUTE IMMEDIATE sql_z;
   END IF;

   -- 28.05.2014 для 300465 исключаем проводки по конверсии
   -- c 26.05.2014 установлен модуль по конверсии
   IF mfou_ = 300465 
   THEN
      sql_z :=
            'UPDATE OTCN_PROV_TEMP t '
         || 'SET t.s_nom = 0, t.s_eqv = 0 '
         || 'WHERE t.REF IN (SELECT REF FROM ZAYAVKA WHERE dk = 3)';

      EXECUTE IMMEDIATE sql_z;
   END IF;

   OPEN c_main;

   LOOP
      FETCH c_main
       INTO ko_, kod_obl_, rnk_, okpo_, nmk_, k040_, adr_, k110_, codc_, kv1_, sum1_, sumk1_;

      EXIT WHEN c_main%NOTFOUND;

      sum1_ := sum1_ - NVL (sumk1_, 0);
      rez_ := MOD (codc_, 2);

      -- 10.06.2009 изменил на следующее         
      if length(trim(okpo_)) <= 8 
      then
         okpo_:=lpad(trim(okpo_),8,'0');
      else 
         okpo_:=lpad(trim(okpo_),10,'0');
      end if;

      -- для банков по коду ОКПО из RCUKRU(IKOD) 
      -- определяем код банка поле GLB
      if codc_ in (1,2) 
      then
         BEGIN
            select glb 
               into okpo_
            from rcukru
            where trim(ikod)=trim(okpo_)
              and rownum=1;
         EXCEPTION WHEN NO_DATA_FOUND THEN 
            null;
         END;
      end if;

      -- для физлиц резидентов не имеющих OKPO 
      --определяем серию и номер паспорта из PERSON
      if codc_ = 5 and trim(okpo_) in ('99999','999999999','00000','000000000','0000000000')
      then
         BEGIN
            select ser, numdoc 
               into ser_, numdoc_
            from person
            where rnk = rnk_
              and rownum=1;
              
            okpo_ := substr (trim(ser_) || ' ' || trim(numdoc_), 1, 14);               
         EXCEPTION WHEN NO_DATA_FOUND THEN 
            null;
         END;
      end if;

      IF (   (pr_op_ = 1 AND ko_ = '1' AND ROUND (sum1_ / kurs_, 0) > gr_sum_
             )
          OR (    (pr_op_ = 3 AND ko_ = '2')
              AND ROUND (sum1_ / kurs1_, 0) > gr_sumn_
             )
         )
      THEN
         dig_ := f_ret_dig (kv_) * 100; -- сумма должна быть в единицах валюты

         ---Покупка/Продажа безналичной валюты
         OPEN opl_dok;

         LOOP
            FETCH opl_dok
             INTO ko_1, ref_, acc_, nls_, kv_, acck_, nlsk_, nazn_, sum0_, sumk0_;

            EXIT WHEN opl_dok%NOTFOUND;

            IF ko_ = ko_1 and ( (kodf_='D3' AND ROUND (GL.P_ICURVAL(kv_, sum0_, dat_) / kurs1_, 0) > gr_sumn_) OR 
                                (kodf_<>'D3' AND ROUND (GL.P_ICURVAL(kv_, sum0_, dat_) / kurs_, 0) > gr_sum_) 
                              )  
            THEN
               IF typ_ > 0
               THEN
                  nbuc_ := NVL (f_codobl_tobo (acc_, typ_), nbuc1_);
               ELSE
                  nbuc_ := nbuc1_;
               END IF;

               s0_ := to_char(sum0_/100, '999999999999.99');

               nnnn_ := nnnn_ + 1;
               sum0_ := sum0_ - NVL (sumk0_, 0);

               if ko_ = 2 
               then
                   BEGIN
                      SELECT SUBSTR (VALUE, 1, 70)
                        INTO d1#D3_
                        FROM operw
                       WHERE REF = ref_ AND tag = 'D1#D3';
                   EXCEPTION
                      WHEN NO_DATA_FOUND
                      THEN
                      BEGIN
                         SELECT  meta 
                            INTO d1#D3_
                         FROM zayavka 
                         WHERE ref_sps = ref_
                           and rownum = 1;
                      EXCEPTION
                         WHEN NO_DATA_FOUND
                         THEN
                         BEGIN
                            SELECT  meta 
                               INTO d1#D3_
                            FROM zayavka 
                            WHERE ref = ref_
                              and rownum = 1;
                         EXCEPTION
                            WHEN NO_DATA_FOUND
                            THEN
                            d1#D3_ := NULL;
                         END;
                      END;
                   END;
               else
                  d1#D3_ := NULL;
               end if;

               if ko_ = 2 and   -- mfo_ in (353553, 313957) and 
                  nls_ like '2600%' and nlsk_ like '2900%' and 
                  d1#D3_ is null
               then
                  BEGIN
                     SELECT  z.meta 
                        INTO d1#D3_
                     FROM provodki_otc p, zayavka z
                     WHERE p.fdat = dat_
                       and p.nlsd = nlsk_
                       and p.s*100 = sum0_
                       and z.ref_sps = p.ref
                       and rownum = 1;
                  EXCEPTION
                     WHEN NO_DATA_FOUND
                     THEN
                        BEGIN
                           SELECT  z.meta 
                              INTO d1#D3_
                           FROM provodki_otc p, zayavka z
                           WHERE p.fdat = dat_
                            and p.nlsd = nlsk_
                            and p.s*100 = sum0_
                            and z.ref = p.ref
                            and rownum = 1;
                        EXCEPTION
                           WHEN NO_DATA_FOUND
                           THEN
                           d1#D3_ := NULL;
                        END;
                  END;
               end if;
                   
               -- проверка есть ли для данной проводки доп. реквизиты
               SELECT count(*)
                  INTO koldop_
               FROM operw
               WHERE REF = ref_ AND tag like 'D_#70';

               if koldop_ > 0 
               then
                  refd_ := ref_;
               else
                  if ko_ = 2 and nls_ like '2600%' and nlsk_ like '2900%' 
                  then
                     begin
                        select ref
                           into refd_
                        from provodki p
                        WHERE fdat = dat_
                          AND accd = acck_
                          AND kv=kv_
                          AND s = s0_
                          AND EXISTS (SELECT 1
                                      FROM operw o
                                      WHERE o.REF = p.ref AND tag like 'D_#70')
                          AND rownum=1;
                     exception
                               when no_data_found then
                        refd_ := null;
                     end;
                  else
                     refd_ := null;
                  end if;
               end if;

               -- определяем код страны перечисления валюты
               if refd_ is not null and pr_op_ = 2 AND ko_ = 3 and mfo_ in (300465, 380623) then
                   BEGIN
                      SELECT SUBSTR (VALUE, 1, 70)
                        INTO d6#70_
                        FROM operw
                       WHERE REF = refd_ AND tag = 'D6#70';
                   EXCEPTION
                      WHEN NO_DATA_FOUND
                      THEN
                         d6#70_ := NULL;
                   END;
               else
                  d6#70_ := NULL;
               end if;

               if (d6#70_ is null or d6#70_ <> '804') and ROUND (sum0_/dig_, 0) >= 1
               then
                  -- код валюти
                  p_ins (nnnn_, '10', LPAD (kv_, 3, '0'));

                  -- сума в единицах валюты (код 12)
                  p_ins (nnnn_, '20', TO_CHAR (ROUND (sum0_ / dig_, 0)));

                  -- ОКПО клiєнта
                  IF rez_ = 0 and trim(okpo_) is NULL -- для нерезидентiв
                  THEN
                     okpo_ := '0';
                  END IF;

                  if okpo_ = ourOKPO_ then
                     okpo_ := ourGLB_;
                     codc_ := 1 ;
                  end if;

                  if nls_ like '2900205%' and nlsk_ like '29003%' then
                     okpo_ := '0';     
                  end if;

	          p_ins (nnnn_, '31', TRIM (okpo_));

                  IF pr_op_ = 1 AND ko_ = '1'  -- тiльки для купiвлi
                  THEN
                     -- назва клiєнта
                     p_ins (nnnn_, '32', TRIM (nmk_));
                     -- адреса клiєнта
                     p_ins (nnnn_, '33', TRIM (adr_));
                     -- код виду економiчної дiяльностi клiєнта
                     p_ins (nnnn_, '41', TRIM (k110_));
                  END IF;

                  IF dat_ >=TO_DATE('13082007','ddmmyyyy') and
                     pr_op_ = 3 AND ko_ = 2 
                  THEN
                     -- код резидентностi
                     p_ins (nnnn_, '35', to_char(2-mod(codc_,2)));
                  END IF;

                  -- додатковi параметри
                  IF dat_ >= TO_DATE('03072006','ddmmyyyy')
                  THEN
                     n_ := 11;
                  END IF;
                  IF dat_ >= TO_DATE('13082007','ddmmyyyy') and
                     pr_op_ = 3 AND ko_ = 2
                  THEN
                     n_ := 13;
                  END IF;

                  FOR i IN 1 .. n_
                  LOOP
                     IF i < 10
                     THEN
                        tag_ := 'D' || TO_CHAR (i) || '#70';
                     ELSIF i = 10
                     THEN
                        tag_ := 'DA#70';
                     ELSIF i = 11
                     THEN
                        tag_ := 'DB#70';
                     ELSIF i = 12
                     THEN
                        tag_ := 'DC#70';
                     ELSE
                        tag_ := 'DD#70';
                     END IF;

                     -- для покупки нужны все доп.реквизиты (D1#70 - DA#70)
                     IF pr_op_ = 1 AND ko_ = 1
                     THEN
                        BEGIN
                           SELECT SUBSTR (VALUE, 1, 70)
                              INTO val_
                           FROM operw
                           WHERE REF = refd_ AND tag = tag_;
                        EXCEPTION
                           WHEN NO_DATA_FOUND
                           THEN
                              val_ := NULL;
                        END;

                        if dat_ <= to_date('01012013', 'ddmmyyyy') OR
                           (dat_ between to_date('01012013', 'ddmmyyyy') and
                                         to_date('31082014', 'ddmmyyyy') and 
                                         i <> 11) OR
                           dat_ >= to_date('01092014', 'ddmmyyyy')
                        then
                           -- код показника та default-значення
                           p_tag (i, val_, kodp_, ref_);
                           -- запис показника
                           p_ins (nnnn_, kodp_, val_);
                        end if;
                     END IF;

                     -- для продажи нужны доп.реквизиты (D1#70)
                     -- с 13.08.2007 нужны также доп.реквизиты D2#70,D3#70
                     IF (dat_ >=TO_DATE('03072006','ddmmyyyy') and
                         dat_ < TO_DATE('13082007','ddmmyyyy') and
                         pr_op_ = 3 AND ko_ = 2 AND i=1) OR
                         (dat_ >=TO_DATE('13082007','ddmmyyyy') and
                          dat_ < TO_DATE('01062009','ddmmyyyy') and 
                          pr_op_ = 3 AND ko_ = 2 AND i in (1, 2, 3, 13) OR 
                         (dat_ >=TO_DATE('01062009','ddmmyyyy') and
                          pr_op_ = 3 AND ko_ = 2 AND i in (1, 13)) OR 
                         (dat_ >=TO_DATE('01062017','ddmmyyyy') and
                          pr_op_ = 3 AND ko_ = 2 AND i in (1, 11, 13))) --AND ROUND (sum0_ / dig_, 0) >= 1
                     THEN
                        BEGIN
                           SELECT SUBSTR (VALUE, 1, 70)
                             INTO val_
                           FROM operw
                           WHERE REF = refd_ AND tag = tag_;
                        EXCEPTION
                           WHEN NO_DATA_FOUND
                           THEN
                           val_ := NULL;
                        END;

                        -- код показника та default-значення
                        p_tag (i, val_, kodp_, ref_);
                        -- запис показника
                        p_ins (nnnn_, kodp_, val_);
                     END IF;
                  END LOOP;
               end if;            
            END IF;
         END LOOP;

         CLOSE opl_dok;
      END IF;
   END LOOP;

   CLOSE c_main;

---------------------------------------------------
   DELETE FROM tmp_nbu
         WHERE kodf = kodf_ AND datf = dat_;

---------------------------------------------------
   INSERT INTO tmp_nbu 
   (kodf, datf, kodp, znap, nbuc) 
      SELECT kodf_, dat_, kodp, znap, nbuc
        FROM rnbu_trace
       WHERE userid = userid_;
----------------------------------------
DELETE FROM OTCN_TRACE_70
         WHERE kodf = kodf_ and datf= dat_ ;

insert into OTCN_TRACE_70(KODF, DATF, USERID, NLS, KV, ODATE, KODP, ZNAP, NBUC, ISP, RNK, ACC, REF, COMM, ND, MDATE, TOBO)
select kodf_, dat_, USERID_, NLS, KV, ODATE, KODP, ZNAP, NBUC, ISP, RNK, ACC, REF, COMM, ND, MDATE, TOBO
from rnbu_trace;

END p_f70_nn;
/

show err;
