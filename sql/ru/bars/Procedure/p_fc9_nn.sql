CREATE OR REPLACE PROCEDURE BARS.p_fc9_nn ( dat_     DATE,
                                       sheme_   VARCHAR2 DEFAULT 'G' ) IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Процедура формирования #C9 для КБ
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     : 16/03/2018 (11/12/2017, 14/11/2017)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
параметры: Dat_ - отчетная дата
           sheme_ - схема формирования
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Внимание !!!   отбор документов по кл-ру KL_FC9
               обрабатываем доп.параметры D1#C9 - "код мети надходження" 
               (классификатор KOD_C9_1) и D2#70 - DC#70.
               Нужен доп.пармаметр DC#70 - номер ВМД.%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
16.03.2018 для проводок Дт 2909 Кт 2924 из OPERW и TAG='59' определяем
           номер лиц.счета 2625 и по нему определяем ОКПО клиента
11.12.2017 для проводок Дт 2909 Кт 2924 добавил условие поиска RNK 
           контрагента из проводки Дт 3739 Кт 2909 и TAG like '59%'
14.11.2017 удалил ненужные строки и изменил некоторые блоки формирования 
18.08.2017 для Запорожья МФО=313957 не будут включаться проводки 
           Дт 3739  Кт 29091100070000
15.08.2017 для кода 31 и значения = '6' будем формировать как '006'
10.08.2017 значение показателя 31 для блока обязательной продажи будет
           формироваться как '0' вместо '000'
04.08.2017 удаляем проводки Дт 3739 Кт 2924 и для которых в OPER
           NLSA like '2924%' and NLSB like '2924%' and MFOA <> MFOB 
02.06.2017 удалил блок для проовдок Дт 262(263) Кт 263(262)
31.05.2017 на 02.06.2017 будут вкючаться все суммы док-тов > 100 (1 USD)
05.04.2017 для кода 36 будем брать 50% вместо 65% 
           (постанова НБУ N30 від 04.04.2017) 
15.03.2017 код страны поступления валюты сначала определяем по TAG='52A'
           и другим TAGам и при пустом значение из TAG='KOD_G' 
13.03.2017 для проводок Дт 2909 Кт 2924 (в бух.моделе для данного REF  
                                         еще и Дт 2924 Кт 2625)  
           (в OPER NLSA='2909...' NLSB='2625...') будем выбирать 
           первоначальную сумму из документа и ОКПО для счета 2625
           (добавлено для MFO=331467 Полтава)
11.04.2016 OKPO для бал.счета 2625 код OKPO будем выбирать ID_B в OPER 
23.03.2016 изменения от 18.02.2016 будем использовать только для Чернигова
22.03.2016 убрал формирование показателя 41NNN для кода 36 
15.03.2016 с 21.03.2016 (на 22.03.2016) закрывается показатель 41NNN
23.02.2016 протокол формирования будет сохраняться в таблицу 
           OTCN_TRACE_70
18.02.2016 для проводок Дт 2909 Кт 2924 (в бух.моделе для данного REF  
                                         еще и Дт 2924 Кт 2625)  
           (в OPER NLSA='2909...' NLSB='2625...') будем выбирать 
           первоначальную сумму из документа и ОКПО для счета 2625
16.11.2015 для таблицы ZAYAVKA добавлено условие  sos <> -1 т.к. было
           задвоение суммы по данному документу (замечание Чернигова) 
15.10.2015 для кода мети 36 показатель 99 (відомості про операцію) будем
           формировать значение "Сума що підлягає обов"язковому продажу"
21.09.2015 для назначения "комерц_йний переказ" формируем значение 
           показателя 40 как "01"
16.09.2014 для назначения платежа "prepayment" код мети будет '30'
           изменен блок всех показателей с кодом мети '36'
           (используем таблицу ZAYAVKA)
10.09.2015 для проводок Дт 2909 Кт 2603 и пустом значении "код мети"
           будет формироваться значение "01"
           для проводок Дт 2909 Кт 2620 и пустом значении "код мети"
           будет формироваться значение "30"
09.09.2015 для назначения "виручка" или "выручка" формируем значение 
           показателя 40 как "01"
27.08.2015 для 300465 показатель 99 (відомості про операцію) будем 
           формировать в зависимости от кода меты покупки 
           (службова Рощиної 52-18/773 від 12.06.2015)
21.08.2015 для определения кода страны дополнительно обработываем доп.
           реквизит 52A и значение кода с 10 позиции 10 символов
           (SWIFT код).
11.08.2015 для всех РУ СБ при формировании будут включаться проводки
           Дт 1500, 1600, 3720, 3739, 3900, 2909  
           Кт 2520,2530,2541,2542,2544,2545
06.03.2015 для кода 36 мети переказу сумму для обязательной продажи
           определяем из поля S2 табл. ZAYAVKA и при отсутствии как ранее  
10.10.2014 для кода меты 36 будем формировать показатель для суммы 20NNNN 
           не 75% от суммы а 100% 
30.09.2014 для проводок Дт 2909 Кт 2909 не будем включать документы с 
           назначением "алименты", "пенсия"
22.09.2014 добавлен новый блок всех показателей с кодом мети '36'
14.04.2014 включались суммы док-тов >=1001$ а необходимо 1000.01$ и больше 
25.03.2014 исключаем обработку доп.рек. 57A и добавляем обработку 50F
19.02.2014 для физлиц резидентов не имеющих ОКРО определяем серию и номер
           паспорта
13.02.2014 будут включаться док-ты с суммой не менее 1000.00$
17.10.2013 дополнительно обрабатываем доп.реквизиты док-тов "n" - код
           країни Платника/Отримувача и другие доп.реквизиты 
           предназначенные для кода страны
26.07.2013 код страны поступления валюты еще будем определять 
           по TAG='50F' и в значении проверяем символы 'UA'
           (не будем включать валютные переводы по Украине)
14/11/2012 виключила операції АСВ + косметичні правки
26.09.2012 при PR_TOBO<>0 формируем в разрезе кодов территорий не только
           для схемы "G" 
26.07.2012 вместо кода мети надходження 09 формируем 30. 
           (письмо Рощиной от 11.07.2012)
11.05.2012 для выбора ОКРО строки 643-654 добавил условие ROWNUM=1
23.11.2011 для Дт 2909______0000 Кт 2909 районов будем искать проводки по
           зачислению Дт 2909 района Кт 2603 (2620)
29.09.2011 c 01/09/2011 код 62 формируем из параметра KOD_G
           и если пустой то из параметра D6#C9
           (змiни 162 вiд 24.05.2011)
13.05.2011 убрал условие формирования показателя 40 для Николаева и
           будем формировать для всех по контексту назначения платежа
19.04.2011 ДОРАБОТКА по заполнению 40 и 62 показателя
14.04.2011 для MFOU_=300465 формируем показатель 99 значением назн.пл. и
           для МФО=326461(Николаев) показатель 40 будет '09' если доп.
           реквизит не заполнен
13.03.2011 отбор документов по кл-ру KL_FC9
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
   kodf_      VARCHAR2 (2)   := 'C9';
   sql_z      VARCHAR2 (200);
   typ_       NUMBER;
   --для покупки
   gr_sum_    NUMBER         := 5000000;
   sum_kom    NUMBER;                       -- сума комiciї 100000$
   -- для продажу i надходження вiд нерезидентiв
   gr_sumn_   NUMBER         := 5000000;    --до 13.08.2007 было 10000000;
   flag_      NUMBER;
   -- флаг для определения наличия поля BENEFCOUNTRY т.TOP_CONTRACTS
   -- (из модуля биржевые операции)
   pr_s3_     NUMBER;    -- флаг для определение наличия поля S3 табл.ZAYAVKA
   pr_2625_   NUMBER;
   -- (из модуля биржевые операции)
   s3_        NUMBER;
   ko_        VARCHAR2 (2);      -- ознака операцii з безготiвковою iнвалютою
   ko_1       VARCHAR2 (2);      -- ознака операцii з безготiвковою iнвалютою
   kod_b      VARCHAR2 (10);                          -- код iноземного банку
   nam_b      VARCHAR2 (70);                        -- назва iноземного банку
   -- кол-во доп.параметров до 03.07.2006 после n_=11
   n_         NUMBER         := 10;
   acc_       NUMBER;
   accd_      NUMBER;
   kv_        NUMBER;
   kv1_       NUMBER;
   nls_       VARCHAR2 (15);
   nls1_      VARCHAR2 (15);
   nlsk_      VARCHAR2 (15);
   nlsk1_     VARCHAR2 (15);
   nbuc1_     VARCHAR2 (12);
   nbuc_      VARCHAR2 (12);
   country_   VARCHAR2 (3);
   b010_      VARCHAR2 (10);
   bic_code   VARCHAR2 (14);
   rnk_       NUMBER;
   okpo_      VARCHAR2 (14);
   okpo_1     VARCHAR2 (14);
   ourOKPO_   varchar2 (14);
   ourGLB_    varchar2 (3);
   nmk_       VARCHAR2 (70);
   adr_       VARCHAR2 (70);
   k040_      VARCHAR2 (3);
   k110_      VARCHAR2 (5);
   nd_        Varchar2 (10);
   val_       VARCHAR2 (70);
   d1#C9_     VARCHAR2 (70);
   d2#C9_     Varchar2 (70);
   d3#C9_     Varchar2 (70);
   d4#C9_     Varchar2 (70);
   d6#C9_     VARCHAR2 (70);
   dc#C9_     Varchar2 (70);
   dc#C9_max  VARCHAR2 (70);
   dc1#C9_    Varchar2 (70);
   d99#C9_    VARCHAR2 (170);
   de#C9_     Varchar2 (3);
   nazn_      VARCHAR2 (160);
   kol_99     number;
   kod_g_     VARCHAR2 (3);
   a1_        VARCHAR2 (70);
   a2_        VARCHAR2 (70);
   a3_        VARCHAR2 (70);
   a4_        VARCHAR2 (70);
   a5_        VARCHAR2 (70);
   a6_        VARCHAR2 (70);
   a7_        VARCHAR2 (70);
   nb_        VARCHAR2 (70);
   tg_        VARCHAR2 (70);
   data_      DATE;
   dig_       NUMBER;
   bsum_      NUMBER;
   bsu_       NUMBER;
   sum1_      DECIMAL (24);
   sum0_      DECIMAL (24);
   sumk1_     DECIMAL (24);                 --ком_с_я в ц_лому по контрагенту
   sumk0_     DECIMAL (24);                 --ком_с_я по контракту
   kodp_      VARCHAR2 (10);
   znap_      VARCHAR2 (70);
   kurs_      NUMBER;
   tag_       VARCHAR2 (5);
   nnnn_      NUMBER         := 0;
   nnnn1_     NUMBER         := 0;
   userid_    NUMBER;
   ref_       NUMBER;
   refd_      NUMBER;
   refd1_     NUMBER;
   rez_       NUMBER;
   codc_      NUMBER;
   mfo_       number;
   mfou_      number;
   pid_       Number;
   id_        Number;
   name_      Varchar2 (70);
   datedoc_   Varchar2 (10);
   swift_k_   VARCHAR2 (12);
   ser_       person.ser%TYPE;
   numdoc_    person.numdoc%TYPE;
   s_nom_     number;
   s_nom_2603 number;
   dat_Izm1_  DATE := TO_DATE('18032016','ddmmyyyy'); -- закривається показник 
                                                      -- 41000
   dat_Izm2_  DATE := TO_DATE('01062017','ddmmyyyy'); -- нова сума для відбору 
   name_sp_        varchar2(30);
   exist_trans     NUMBER                 := 0;
   kol_fc9_   number;

--курсор по контрагентам
   CURSOR c_main
   IS
      SELECT   t.ko, c.rnk, c.okpo, c.nmk, TO_CHAR (c.country), c.adr,
               NVL (c.ved, '00000'), c.codcagent, SUM (t.s_eqv),
               SUM (gl.p_icurval (t.kv, t.s_kom, dat_))
                                                    --сумма в формате грн.коп
          FROM otcn_f70_temp t, customer c
         WHERE t.rnk = c.rnk
      GROUP BY t.ko,
               c.rnk,
               c.okpo,
               c.nmk,
               TO_CHAR (c.country),
               c.adr,
               NVL (c.ved, '00000'),
               c.codcagent;

--- надходження вiд нерезидентiв безгот?вково? валюти
   CURSOR opl_dok
   IS
      SELECT t.ko, t.REF, t.acck, t.nlsk, t.kv, t.nlsd, t.accd, t.nazn,
             SUM (t.s_nom), SUM (t.s_eqv)
          FROM otcn_f70_temp t
         WHERE t.rnk = rnk_
      GROUP BY t.ko, t.REF, t.acck, t.nlsk, t.kv, t.nlsd, t.accd, t.nazn ;

-------------------------------------------------------------------
   PROCEDURE p_exist_trans
   IS
   BEGIN
      SELECT COUNT ( *)
        INTO exist_trans
        FROM all_tables
       WHERE owner = 'BARS' AND table_name LIKE 'OTCN_TRANSIT_NLS';
   END;
-------------------------------------------------------------------
   PROCEDURE p_ins (p_np_ IN NUMBER, p_kodp_ IN VARCHAR2, p_znap_ IN VARCHAR2)
   IS
      l_kodp_   VARCHAR2 (10);
      p_znap1_  VARCHAR2 (70);
   BEGIN

      if p_kodp_ = '31' and p_znap_ = '6'   
      then
         p_znap1_ := LPAD (p_znap_, 3, '0');
      else
         p_znap1_ := p_znap_;
      end if;

      if mfo_ = 300465 and p_kodp_ = '31' 
      then
         if (nlsk_ like '1500%' or nlsk_ like '1600%') and
             trim(nls_) in ('29091000580557','29092000040557',
                            '29095000081557','29091927',
                            '2909003101','29095000046547',
                            '292460205','292490204','29096000541557',
                            '37394501547','37391006','373990351') 
         then
            p_znap1_ := '006';
         end if;
      end if;
  
      if p_kodp_ = '31' and p_znap_ = '2603' 
      then
         p_znap1_ := '0';
      end if;

      l_kodp_ := p_kodp_ || LPAD (TO_CHAR (p_np_), 3, '0');

      INSERT INTO rnbu_trace
                  (nls, kv, odate, kodp, znap, nbuc, ref, nd
                  )
           VALUES (nls_, kv_, dat_, l_kodp_, p_znap1_, nbuc_, ref_, refd_
                  );
   END;

-------------------------------------------------------------------
   PROCEDURE p_tag (
      p_i_       IN       NUMBER,
      p_value_   IN OUT   VARCHAR2,
      p_kodp_    OUT      VARCHAR2,
      p_ref_     IN       NUMBER DEFAULT NULL,
      nazn_      in       VARCHAR2 DEFAULT NULL
   )
   IS
   BEGIN
      IF p_i_ = 1
      THEN
         p_kodp_ := '40';

         if mfo_ = 300465 
         then
            if (nlsk_ like '1500%' or nlsk_ like '1600%') and
               trim(nls_) in ('29091000580557','29092000040557','29095000081557',
                              '29091927','2909003101','29095000046547',
                              '292460205','292490204','29096000541557',
                              '373900354','373910357','373910360','373920363', 
                              '373930353','373940356','373950359', --'37394501547', 
                              '373950362','37395358','373960352','37397906547',
                              '373980361','37398355','373990351','373990364',
                              '37391006' )
            then
               --d1#C9_ := '09';  -- было до 26.07.2012
               d1#C9_ := '29';  -- с 26.07.2012 согласно письма Рощиной от 11.07.2012
            end if;
            if (nlsk_ like '1500%' or nlsk_ like '1600%') and
                nls_ = '37394501547' and 
               (instr(lower(nazn_),'розрахунки за чеками') > 0 or  instr(lower(nazn_),'розрахунки по чеках') > 0)
            then
               d1#C9_ := '09';  -- с 26.07.2012 согласно письма Рощиной от 11.07.2012
            end if;

            --  проверка наличия счета ДТ в справочнике систем переводов  13.01.2017
            if nlsk_ like '1500%' and
               ( nls_ like '3739%' or nls_ like '2924%' ) 
            then
               if exist_trans > 0 then
                  begin
                     select t_system  into name_sp_
                     from otcn_transit_nls
                     where nls = trim(nls_);
                  exception
                    when others
                    then name_sp_ :='';
                  end;
                  if trim(name_sp_) is not null  then
                     d1#C9_ := '29';
                  end if;
               end if;
            end if;
         end if;

         if TRIM (p_value_) is null and d1#C9_ is null and nazn_ is not null 
         then
            if instr(lower(nazn_),'виручка') > 0 OR instr(lower(nazn_),'выручка') > 0
            then
               d1#C9_ := '01';  
            end if;

            if instr(lower(nazn_),'prepayment') > 0 
            then
               d1#C9_ := '30';  
            end if;

            if instr(lower(nazn_),'грош') > 0 
            then
               --d1#C9_ := '09';  -- было до 26.07.2012
               d1#C9_ := '30';  -- с 26.07.2012 согласно письма Рощиной от 11.07.2012
            end if;
            
            if instr(lower(nazn_),'комерційний переказ') > 0  OR 
               instr(lower(nazn_),'комерцiйний переказ') > 0 
            then
               d1#C9_ := '01';  -- восстановил 21.09.2015 (было до 26.07.2012)
               --d1#C9_ := '30';  -- с 26.07.2012 согласно письма Рощиной от 11.07.2012
            end if;
            
            if instr(lower(nazn_),'соц_альний переказ') > 0 
            then
               --d1#C9_ := '05';  -- было до 26.07.2012
               d1#C9_ := '30';  -- с 26.07.2012 согласно письма Рощиной от 11.07.2012
            end if;

            if d1#C9_ is null and instr(lower(nazn_),'переказ') > 0 and 
               (nls_ like '2620%' or (nls_ like '2924%' and nlsk_ like '2909%'))
            then
               --d1#C9_ := '09';  -- было до 26.07.2012
               d1#C9_ := '30';  -- с 26.07.2012 согласно письма Рощиной от 11.07.2012
            end if;
         end if;

         if TRIM (p_value_) is null and d1#C9_ is null and 
            nls_ like '2909%' and nlsk_ like '2603%' 
         then
            d1#C9_ := '01';  
         end if;

         if TRIM (p_value_) is null and d1#C9_ is null and 
            nls_ like '2909%' and nlsk_ like '2620%' 
         then
            d1#C9_ := '30';  
         end if;

         if pr_2625_ = 1 
         then
            d1#C9_ := '30';
         end if;
 
         if TRIM (p_value_) is null and d1#C9_ is not null 
         then
            p_value_ := NVL (SUBSTR (TRIM (d1#C9_), 1, 70), '00');
         else
            p_value_ := NVL (LPAD (SUBSTR ( TRIM (p_value_), 1, 2), 2, '0'), '00');
         end if;

         d1#C9_ := p_value_;
      ELSIF p_i_ = 2
      THEN
         p_kodp_ := '51';
         if TRIM (p_value_) is null and d2#C9_ is not null 
         then
            p_value_ := NVL (SUBSTR (TRIM (d2#C9_), 1, 70), 'N контр.');
         else
            p_value_ := NVL (SUBSTR (TRIM (p_value_), 1, 70), 'N контр.');
         end if;
      ELSIF p_i_ = 3
      THEN
         p_kodp_ := '52';
         if TRIM (p_value_) is null and d3#C9_ is not null 
         then
            p_value_ := NVL (SUBSTR (TRIM (d3#C9_), 1, 70), 'дата контр.');
         else
            p_value_ := NVL (SUBSTR (TRIM (p_value_), 1, 70), 'дата контр.');
         end if;
      ELSIF p_i_ = 4
      THEN
         p_kodp_ := '60';
         if TRIM (p_value_) is null and d4#C9_ is not null 
         then
            p_value_ := NVL (SUBSTR (TRIM (d4#C9_), 1, 70), '');
         else
            p_value_ := NVL (SUBSTR (TRIM (p_value_), 1, 70), ''); --'DDMMYYYY');
         end if;
      ELSIF p_i_ = 6
      THEN
         p_kodp_ := '62';
         IF p_value_ IS NOT NULL
         THEN
            p_value_ := LPAD (p_value_, 3, '0');
         else
            p_value_ := LPAD (trim(D6#C9_), 3, '0');
         END IF;

         IF p_value_ is null 
         THEN
            BEGIN
               SELECT substr(trim(value), instr(UPPER(trim(value)),'3/')+2, 2)
                  INTO swift_k_
               FROM OPERW
               WHERE REF=REFD_
                 AND TAG LIKE '50F%'
                 AND ROWNUM = 1;
                 
               SELECT trim(b.k040)
               INTO p_value_
               from kl_k040 b
               where b.A2 like swift_k_ || '%';            
            EXCEPTION WHEN NO_DATA_FOUND THEN
               BEGIN
                  SELECT substr(trim(value), instr(UPPER(trim(value)),'/')+1, 2)
                  INTO swift_k_
                  FROM OPERW
                  WHERE REF=REF_
                    AND TAG LIKE '50K%'
                    AND ROWNUM = 1;
                 
                  SELECT trim(b.k040)
                     INTO p_value_
                  from kl_k040 b
                  where b.A2 like swift_k_ || '%'; 
               EXCEPTION WHEN NO_DATA_FOUND THEN
                  BEGIN
                     SELECT substr(trim(value), 1, 10)
                        INTO swift_k_
                     FROM OPERW
                     WHERE REF = REFD_
                       AND TAG = '52A'
                       AND length(trim(value)) > 3
                       AND ROWNUM = 1;

                     BEGIN
                        SELECT k040
                           INTO p_value_
                        FROM RC_BNK
                        WHERE SWIFT_CODE LIKE swift_k_||'%'
                          AND ROWNUM = 1;
                     EXCEPTION WHEN NO_DATA_FOUND THEN
                        swift_k_ := substr(swift_k_,1,4)||' '||substr(swift_k_,5,2)||
                                  ' '||substr(swift_k_,7,2);
                        BEGIN
                           SELECT k040
                              INTO p_value_
                           FROM RC_BNK
                           WHERE SWIFT_CODE LIKE swift_k_||'%'
                             AND ROWNUM = 1;
                        EXCEPTION WHEN NO_DATA_FOUND THEN
                           null;
                        END;
                     END;
                  EXCEPTION WHEN NO_DATA_FOUND THEN
                     BEGIN
                        SELECT substr(trim(value), 10, 10)
                           INTO swift_k_
                        FROM OPERW
                        WHERE REF = REFD_
                          AND TAG = '52A'
                          AND length(trim(value)) > 10
                          AND ROWNUM = 1;

                        BEGIN
                           SELECT k040
                              INTO p_value_
                           FROM RC_BNK
                           WHERE SWIFT_CODE LIKE swift_k_||'%'
                             AND ROWNUM = 1;
                        EXCEPTION WHEN NO_DATA_FOUND THEN
                           swift_k_ := substr(swift_k_,1,4)||' '||substr(swift_k_,5,2)||
                                     ' '||substr(swift_k_,7,2);
                           BEGIN
                              SELECT k040
                                 INTO p_value_
                              FROM RC_BNK
                              WHERE SWIFT_CODE LIKE swift_k_||'%'
                                AND ROWNUM = 1;
                           EXCEPTION WHEN NO_DATA_FOUND THEN
                              null;
                           END;
                        END;
                     EXCEPTION WHEN NO_DATA_FOUND THEN
                        null;
                     END;
                  END;
               END;
            END;
         END IF;

         if p_value_ is null 
         then
            begin
               SELECT substr(trim(value), 6, 11)
                   INTO bic_code
                FROM OPERW
                WHERE REF = REFD_
                  AND value like '%52A%'
                  AND length(trim(value)) > 3
                  AND instr(trim(value),'F52A:/') = 0 AND
                      ROWNUM = 1;

              SELECT trim(b.k040)
                 INTO p_value_
              from SW_BANKS a, kl_k040 b
              where a.bic = bic_code and
                    b.A2(+) = substr(a.bic, 5,2) AND
                    ROWNUM = 1;
            EXCEPTION WHEN NO_DATA_FOUND THEN
               null;
            end;
         end if;

         if p_value_ is null 
         then
            BEGIN
              SELECT substr(trim(value), 8, 2)
                 INTO swift_k_
              FROM OPERW
              WHERE REF = REFD_
              AND value like '%52D:/%'
              AND length(trim(value)) > 3
              AND ROWNUM = 1;

              BEGIN
                 SELECT k040
                    INTO p_value_
                 FROM KL_K040
                 WHERE A2 = swift_k_
                   AND ROWNUM = 1;
              EXCEPTION WHEN NO_DATA_FOUND THEN
                    null;
              end;
            EXCEPTION WHEN NO_DATA_FOUND THEN
                null;
            end;
         end if;

         if Dat_ >= to_date('01092011','ddmmyyyy') and p_value_ is null and 
            trim(kod_g_) is not null 
         then
            p_value_ := trim(kod_g_);
         end if;

         p_value_ :=
            NVL (SUBSTR (LPAD (TRIM (p_value_), 3, '0'), 1, 70),
                 'код краiни з якоi була переказана валюта'
                );
         country_ := SUBSTR ( LPAD (TRIM (p_value_), 3, '0'), 1, 3);
      -- код валютної операції (новий код 42 з 01.06.2017)
      ELSIF p_i_ = 11
      THEN
         IF dat_ >= dat_Izm2_
         THEN
            p_kodp_ := '42';
            p_value_ := '00';
         END IF;
      ELSIF p_i_ = 12
      THEN
         p_kodp_ := '69';
         if TRIM (p_value_) is null and dc#C9_ is not null 
         then
            p_value_ := NVL (SUBSTR (TRIM (dc#C9_), 1, 70), 'номер ВМД');
         else
            p_value_ := NVL (SUBSTR (TRIM (p_value_), 1, 70), 'б/н');
         end if;
      ELSIF p_i_ = 13
      THEN
        --новий код 99 - "вiдомостi про операцiю"
         p_kodp_ := '99';

         if TRIM (p_value_) is null and d99#C9_ is not null 
         then
            if length(trim(d99#C9_)) > 70 
            then
               n_ := 70;
            else
               n_ := length(trim(d99#C9_))-1;
            end if;
            p_value_ := NVL (SUBSTR (TRIM (d99#C9_), 1, n_), '');
         else
           p_value_ :=NVL (SUBSTR (TRIM (p_value_), 1, 70), '');
         end if;

         IF trim(p_value_) is NULL and mfo_ = 300465 
         THEN
            p_value_ := substr(nazn_, 1, 70);
         END IF;

         IF mfo_ = 300465 and d1#C9_ = '29'
         THEN
            if trim(name_sp_) is not null
            then
               p_value_ := substr(name_sp_, 1, 70);
            end if;
         END IF;

         IF mfou_ = 300465 and mfo_ <> mfou_
         THEN
            CASE
               WHEN d1#C9_ = '01'
               THEN
                  p_value_ := 'Виручка';
               WHEN d1#C9_ = '02'
               THEN
                  p_value_ := 'Інвестиції';
               WHEN d1#C9_ = '03'
               THEN
                  p_value_ := 'Кредит нерезидента';
               WHEN d1#C9_ = '04'
               THEN
                  p_value_ := 'Розміщення на депозит';
               WHEN d1#C9_ = '05'
               THEN
                  p_value_ := 'Гуманітарна допомога';
               WHEN d1#C9_ = '06'
               THEN
                  p_value_ := 'Погашення кредиту';
               WHEN d1#C9_ = '07'
               THEN
                  p_value_ :=
                     'Повернення ІВ від нерезидентів (не виконання зобов"язань)';
               WHEN d1#C9_ = '08'
               THEN
                  p_value_ := 'Участь у капіталі';
               WHEN d1#C9_ = '09'
               THEN
                  p_value_ :=
                     'Надходження з Іншою метою';
               WHEN d1#C9_ = '17'
               THEN
                  p_value_ :=
                     'За операціями з продажу банківських металів';
               WHEN d1#C9_ = '22'
               THEN
                  p_value_ := 'Доходи від інвестицій';
               WHEN d1#C9_ = '23'
               THEN
                  p_value_ :=
                     'Надходження за користування кредитом';
               WHEN d1#C9_ = '24'
               THEN
                  p_value_ :=
                     'Надходження від розміщення депозиту';
               WHEN d1#C9_ = '28'
               THEN
                  p_value_ :=
                     'Конвертація, у тому числі за неттінгом таких операцій';
               WHEN d1#C9_ = '29'
               THEN
                  p_value_ :=
                     'Розрахунки по платіжних системах '||name_sp_;
               WHEN d1#C9_ = '30'
               THEN
                  p_value_ := 'Приватні перекази';
               WHEN d1#C9_ = '31'
               THEN
                  p_value_ := 'Роялті';
               WHEN d1#C9_ = '32'
               THEN
                  p_value_ :=
                     'Утримання представництва';
               WHEN d1#C9_ = '33'
               THEN
                  p_value_ := 'Податки';
               WHEN d1#C9_ = '34'
               THEN
                  p_value_ := 'Державне фінансування';
               WHEN d1#C9_ = '35'
               THEN
                  p_value_ :=
                     'Платежі за судовими рішеннями';
               WHEN d1#C9_ = '36'
               THEN
                  p_value_ :=
                     'Сума що підлягає обов"язковому продажу';
               ELSE
                  NULL;
            END CASE;
         END IF;
      ELSIF p_i_ = 14
      THEN
         IF Dat_ <= dat_Izm1_ 
         THEN
            --новий код 41 - "код надходження вiдповiдно до платiжного календаря"    "
            p_kodp_ := '41';
            if TRIM (p_value_) is null and de#C9_ is not null 
            then
               p_value_ := NVL (SUBSTR (TRIM (de#C9_), 1, 3), 'код надходження');
            else
               p_value_ := NVL (SUBSTR (TRIM (p_value_), 1, 3), 'код надходження');
            end if;
            IF (p_value_ is null or p_value_ = 'код надходження') and
               substr(nlsk_,1,4) not in ('1522','1523','1524','1525',
                                         '1621','1623','1624')
            THEN
               p_value_ := '999';
            END IF;
            IF trim(d1#C9_) not in ('00','03') 
            THEN
               p_value_ := '999';
            end if;
            IF trim(d1#C9_) = '03' and p_value_ = '999' 
            THEN
               p_value_ := '000';
            end if;
         END IF;
      ELSE
         p_kodp_ := 'NN';
      END IF;

   END;
-----------------------------------------------------------------------------
BEGIN
    logger.info ('P_FC9_NN: Begin for datf = '||to_char(dat_, 'dd/mm/yyyy'));
    -------------------------------------------------------------------
    EXECUTE IMMEDIATE 'ALTER SESSION SET NLS_NUMERIC_CHARACTERS=''.,''';
    userid_ := user_id;
    EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';
    EXECUTE IMMEDIATE 'TRUNCATE TABLE OTCN_F70_TEMP';

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
   -- параметры формирования файла
   p_proc_set (kodf_, sheme_, nbuc1_, typ_);
   --- выбор курса долара для пересчета суммы
   kurs_ := f_ret_kurs (840, dat_);
   sum_kom := gl.p_icurval(840, 100000, dat_);  -- сума комiсiї 

   ourOKPO_ := lpad(F_Get_Params('OKPO',null), 8, '0');

   begin
     select lpad(to_char(glb), 3, '0')
        into ourGLB_
     from rcukru
     where mfo = mfo_
       and rownum = 1;
   exception
     when no_data_found then
         ourGLB_ := null;
   END;

   p_exist_trans ();

   -- з 01.06.2009 для надходження вал. вiд нерезид. вкл-ся операцii >=1000000$
   -- з 13.08.2007 (було 5000000$)
   IF dat_ >= to_date('01012009','ddmmyyyy') 
   THEN  
      gr_sumn_ := 1;   --100;   --1000000;
   END IF;

   -- з 11.02.2014 для надходження вал. вiд нерезид. вкл-ся операцii >=100000$
   IF dat_ >= to_date('11022014','ddmmyyyy') 
   THEN 
      gr_sumn_ := 100000;
   END IF;

   -- з 01.06.2017 для надходження вал. вiд нерезид. вкл-ся операцii >=100$
   IF dat_ >= dat_Izm2_ 
   THEN 
      gr_sumn_ := 1;
   END IF;

   select count(*)
      into kol_fc9_
   from kl_fc9;

   IF kol_fc9_ = 0 
   THEN
      -- отбор проводок, удовлетворяющих условию
      -- надходження вiд нерезидентiв
      INSERT INTO otcn_f70_temp
                  (ko, rnk, REF, acck, nlsk, kv, nlsd, accd, nazn, s_nom, s_eqv)
         SELECT *
           FROM (
                 SELECT   '3' ko, ca.rnk, o.REF, o.acck, o.nlsk, o.kv, o.nlsd,
                          o.accd, o.nazn,
                          SUM (o.s * 100) s_nom,
                          SUM (gl.p_icurval (o.kv, o.s * 100, dat_)) s_eqv
                     FROM provodki o, cust_acc ca
                    WHERE o.fdat = dat_
                      AND o.soso = 5 
                      AND o.kv <> 980
                      AND ( ( ( (SUBSTR (o.nlsd, 1, 4) IN
                               ('1500','1600','3720','3739','3900','2909')  --'2603'  --исключил 23.11.2012 т.к  
                             AND SUBSTR (o.nlsk, 1, 4) IN                             --введена 50% обязат.продажа
                                                          ('1511',
                                                           '1512',
                                                           '1515',
                                                           '1516',
                                                           '1600',
                                                           '1602',
                                                           '2520',   --добавил 11.08.2015 (службова 52-18/1047 Рощиної)
                                                           '2530', 
                                                           '2541',
                                                           '2542',
                                                           '2544',
                                                           '2545',
                                                           '2600',
                                                           '2602',
                                                           '2603',   --добавил 23.11.2012 т.к. введена 50% обязат.продажа
                                                           '2620',
                                                           '2625',
                                                           '2650',
                                                           '2901',
                                                           '2924'  ) )
                             OR ( SUBSTR (o.nlsd, 1, 4) = '2602'
                                 AND SUBSTR (o.nlsk, 1, 4) = '2603' )
                             OR ( o.nlsd LIKE '260013011667%'    -- 14/03/2016 ГОУ
                                 AND SUBSTR (o.nlsk, 1, 4) in ('2603')
                                 AND mfo_ = 300465)
                             OR ( SUBSTR (o.nlsd, 1, 4) in ('1500','1600')   -- 23/06/2009
                                 AND SUBSTR (o.nlsk, 1, 4) = '2909' )
                             OR ( SUBSTR (o.nlsd, 1, 4) = '1500'   -- 25/07/2009
                                 AND SUBSTR (o.nlsk, 1, 4) = '1819'
                                 AND mfo_ = 300465 )
                             OR ( o.nlsd = '29093000110000'   -- 12/10/2010
                                 AND (o.nlsk LIKE '2909%' or o.nlsk LIKE '2603%')  -- Крим ОБ
                                 AND mfo_ = 324805)
                             OR ( o.nlsd = '29099100170000'   -- 19/10/2010
                                 AND (o.nlsk LIKE '2909%' or o.nlsk LIKE '2603%' 
                                      or o.nlsk LIKE '2620%' or o.nlsk LIKE '2600%')  -- Рiвне ОБ
                                 AND mfo_ = 333368)
                             OR ( o.nlsd like '2909%'   -- 31/10/2014
                                 AND (o.nlsk LIKE '2603%' 
                                      or o.nlsk LIKE '2620%' or o.nlsk LIKE '2625%')  -- Iвано-Франкывськ ОБ
                                 AND mfo_ = 336503)
                             OR ( SUBSTR (o.nlsd, 1, 4) in ('1500','3720','3739','3900','2909')   -- 04/11/2009
                                 AND SUBSTR (o.nlsk, 1, 4) = '2603'  -- Житомир ОБ
                                 AND mfo_ in (300465,303398,311647,313957) )
                             OR ( SUBSTR(o.nlsd, 1, 4) in ('1500','1600')  -- 16/07/2010  OAB
                                 AND ( o.nlsk LIKE '373900354%'   OR        -- 26/05/2013  OAB
                                       o.nlsk like '373910357%'   OR
                                       o.nlsk like '373910360%'   OR
                                       o.nlsk like '373920363%'   OR
                                       o.nlsk like '373930353%'   OR
                                       o.nlsk like '373940356%'   OR
                                       o.nlsk like '37394501547%' OR
                                       o.nlsk like '373950359%'   OR
                                       o.nlsk like '373950362%'   OR
                                       o.nlsk like '37395358%'    OR
                                       o.nlsk like '373960352%'   OR
                                       o.nlsk like '37397906547%' OR
                                       o.nlsk like '373980361%'   OR
                                       o.nlsk like '37398355%'    OR
                                       o.nlsk like '373990351%'   OR
                                       o.nlsk like '373990364%'   OR
                                       o.nlsk LIKE '37391006%'    OR
                                       o.nlsk LIKE '373960365%'   
                                     ) 
                                 AND mfo_ in (300465) )            
                             OR ( SUBSTR(o.nlsd, 1, 4) ='1600'  -- 16/08/2010 Вирко
                                 AND o.nlsk = '18199' 
                                 AND mfo_ in (300465) )            
                             OR ( SUBSTR (o.nlsd, 1, 4) = '3739'   -- 22/07/2010
                                 AND (o.nlsk LIKE '29090100250000%' or o.nlsk LIKE '290969015%')  -- Чернiвцi ОБ
                                 AND mfo_ = 356334 )
                             OR ( SUBSTR (o.nlsd, 1, 4) = '1819'
                                 AND SUBSTR (o.nlsk, 1, 4) in ('1522','1523',
                                 '1524','1525','1621','1623','1624')) )
                      AND SUBSTR (LOWER (TRIM (o.nazn)), 1, 4) <> 'конв' )
                      OR ( SUBSTR (o.nlsd, 1, 4) = '1500'   -- 12/01/2010
                           AND SUBSTR (o.nlsk, 1, 4) in ('1819','3540')
                           AND mfo_ = 300465
                           AND SUBSTR (LOWER (TRIM (o.nazn)), 1, 4) = 'конв' )
                      OR ( SUBSTR (o.nlsd, 1, 4) in ('1500','1600')   -- 29/07/2012
                                 AND SUBSTR (o.nlsk, 1, 4) = '2603'  
                                 AND mfo_ in (300465) )
                      OR ( SUBSTR (o.nlsd, 1, 4) = '1500'   -- 12/01/2010
                           AND SUBSTR (o.nlsk, 1, 4) = '3540'
                           AND mfo_ in (300465)
                           AND SUBSTR (LOWER (TRIM (o.nazn)), 1, 3) = 'net' ) 
                      OR ( o.nlsd like '1502%'      -- 30/07/2012 лист Шпирки вiд 24.07.2012  
                           AND o.nlsk like '1518%'
                           AND mfo_ = 300465 )
                      OR ( o.nlsd like '1502%'   -- 30/07/2012
                           AND o.nlsk like '3800%'
                           AND mfo_ = 300465 
                           AND ref in (select ref 
                                       from oper 
                                       where nlsa like '1502%'
                                         and nlsb like '6010%')
                           AND gl.p_icurval(o.kv, o.s * 100, dat_) > sum_kom ) 
                      -- службова Рощиної від 10.12.2015 52-18/1672
                      OR   o.nlsd like '3739%'   -- 11/12/2015
                           AND o.nlsk like '260013011667%'
                           AND mfo_ = 300465 
                      OR ( o.nlsd like '2909%'   -- 25/11/2016 службова Рощиної від 21/11/2016
                           AND substr(o.nlsk, 1, 4) in ('2630', '2635') 
                           AND mfo_ = 300465 ) 
                      OR ( SUBSTR (o.nlsd, 1, 4) in ('1500','1600')   -- 29/07/2012
                           AND o.nlsk like '16_8%'
                           AND mfo_ = 300465 )
                      OR ( SUBSTR (o.nlsd, 1, 4) in ('1500','1600')   -- 29/07/2012
                           AND o.nlsk like '3800%' 
                           AND mfo_ = 300465 
                           AND ref in (select ref 
                                       from oper 
                                       where ( (substr(nlsa,1,4) in ('1500','1600') and
                                                (nlsb like '60%' or nlsb like '610%' or nlsb like '611%')) or 
                                               ((nlsa like '60%' or nlsa like '610%' or nlsa like '611%') and
                                                 substr(nlsb,1,4) in ('1500','1600')) ) 
                                      )
                           AND gl.p_icurval (o.kv, o.s * 100, dat_) > sum_kom )
                      )
                      AND DECODE(substr(o.nlsd,1,4),'2603', o.accd, o.acck) = ca.acc
                 GROUP BY '3', ca.rnk, o.REF, o.acck, o.nlsk, o.kv, o.nlsd,
                           o.accd, o.nazn);
   
      -- 11.08.2012 для всех всех РУ СБ и для ОПЕРУ также
      if mfou_ = 300465 
      then
         delete from otcn_f70_temp
         where nlsd like '3739%'
           and substr(nlsk,1,4) IN ('2620','2630','2635','2924') ;
      end if;
   
      if mfo_ in (300465, 333368, 303398, 311647, 324805, 336503) 
      then
         delete from otcn_f70_temp
         where nlsd like '2603%'
           and nlsk like '2600%' ;
      end if;
   
      -- удаляем проводки которые не с коррсчета (Дт 1500 Кт 2909) Житомир СБ
      if mfo_ in (311647, 356334) 
      then
         delete from otcn_f70_temp
         where nlsd like '3739%'
           and nlsk like '2909%'
           and ref in ( select a.ref
                        from oper a
                        where a.ref in ( select b.ref 
                                         from otcn_f70_temp b 
                                       )
                          and a.nlsa not like '1500%' and a.nlsb not like '2909%' 
                      );
      end if;
   
      -- удаляем проводки пополнения ЛОРО счета с коррсчета (Дт 1500 Кт 1600)
      if mfo_ = 300465 
      then
         delete from otcn_f70_temp o
         where exists ( select 1 from customer c 
                        where c.rnk = o.rnk
                          and c.country = 804 
                      )
           and o.ref in ( select a.ref
                          from oper a
                          where a.ref in ( select b.ref 
                                           from otcn_f70_temp b 
                                         )
                            and a.nlsa like '1500%' and a.nlsb like '1600%' 
                        );
      end if;
   
      -- удаляем проводки перевода отделения в ОБЛУПРАВЛЕНИЕ
      if mfou_ = 300465 
      then
         delete from otcn_f70_temp
         where ref in ( select a.ref
                        from oper a
                        where a.ref in ( select b.ref 
                                         from otcn_f70_temp b
                                       )
                          and a.tt in ('АСВ') 
                      );
      end if;
   
      -- удаляем проводки перевода отделения в ОБЛУПРАВЛЕНИЕ
      if mfou_ = 300465 
      then
         delete from otcn_f70_temp
         where nlsd like '3739%'
           and substr(nlsk,1,4) in ('2600','2602','2620','2625',
                                    '2630','2635','2650','2924')
           and ref in ( select a.ref
                        from oper a
                        where a.ref in ( select b.ref 
                                         from otcn_f70_temp b 
                                       )
                          and a.tt in ('024')
                          AND nlsk != '260013011667' 
                      );
      end if;
   
      -- удаляем проводки перевода для РОДОВИД 
      if mfou_ = 300465 
      then
         delete from otcn_f70_temp
         where nlsd like '2909%'
           and substr(nlsk,1,4) in ('2630','2635')  
           and ref in ( select a.ref
                        from oper a
                        where a.ref in ( select b.ref 
                                         from otcn_f70_temp b 
                                       )
                          and a.tt in ('024') 
                      );
      end if;
   
      -- удаляем проводки Дт 1500,1600 Кт 2909
      if mfo_ = 300465 
      then
         delete from otcn_f70_temp
         where (nlsd like '1500%' or nlsd like '1600%')
           and nlsk like '2909%'
           and nlsk not in ( '29096000541557','29095000046547',
                             '29095000081557','29091000580557',
                             '2909003101','29092000040557',
                             '29091927'
                           );
      end if;
   
      -- удаляем проводки Дт 29090100250000 Кт любой   Чернiвцi ОБ
      --if mfo_ = 356334 
      --then
      --   delete from otcn_f70_temp
      --   where nlsd like '29090100250000%'
      --     and nlsk not like '2603%';
      --end if;
   
      -- удаляем проводки Дт 3739 Кт 29099100170000 Запорожье ОБ
      if mfou_ = 300465 
      then
         delete from otcn_f70_temp
         where nlsd like '3739%' 
           and nlsk like '2909%' 
           and nlsk in ( select a.nls 
                         from accounts a, specparam_int s 
                         where a.nbs = '2909' 
                           and a.acc = s.acc(+)  
                           and s.ob22 = '66'
                       );
      end if;
      
      -- удаляем проводки Дт 2909 Кт 2620 Рiвне ОБ
      if mfo_ = 333368 
      then
         delete from otcn_f70_temp
         where nlsd like '2909%'
           and nlsd != '29099100170000'  
           and substr(nlsk, 1, 4) in ('2620', '2600', '2603', '2909');
      end if;
   
      -- удаляем проводки Дт 3739 Кт 29090100250000 Крим ОБ
      if mfo_ = 324805 
      then
         delete from otcn_f70_temp
         where nlsd like '3739%' 
           and nlsk like '29093000110000%';
      end if;
   
      -- удаляем проводки Дт 2909 Кт 2620 Крим ОБ
      if mfo_ = 324805 
      then
         delete from otcn_f70_temp
         where nlsd like '2909%' 
           and nlsk like '2620%';
      end if;
   
      -- 07.02.2017 закоментарил этот блок т.к. будут включаться проводки 
      -- для контрагентов 1600 бал.счета у которых код страны не равен 804 
      -- удаляем проводки Дт 1500 Кт 1600
      --if mfo_ = 300465 
      --then
      --   delete from otcn_f70_temp
      --   where nlsd like '1500%'
      --     and nlsk like '1600%';
      --end if;
   
      -- удаляем проводки Дт 1600 Кт 1600
      if mfo_ = 300465 
      then
         delete from otcn_f70_temp
         where nlsd like '1600%'
           and nlsk like '1600%';
      end if;
   ELSE 
      INSERT INTO otcn_f70_temp
                  (ko, rnk, REF, tt, acck, nlsk, kv, nlsd, accd, nazn, s_nom, s_eqv)
         SELECT *
           FROM (
                 SELECT   '3' ko, ca.rnk, o.REF, o.tt, o.acck, o.nlsk, o.kv, o.nlsd,
                          o.accd, o.nazn,
                          SUM (o.s * 100) s_nom,
                          SUM (gl.p_icurval (o.kv, o.s * 100, dat_)) s_eqv
                     FROM provodki o, accounts ca, kl_fc9 k
                    WHERE o.fdat = dat_
                      AND o.kv != 980
                      AND o.nlsd LIKE k.nlsd || '%'
                      AND o.nlsk LIKE k.nlsk || '%'
                      AND k.pr_del = 1
                      AND NVL(trim(k.tt),o.tt)=o.tt
                      AND SUBSTR (LOWER (TRIM (o.nazn)), 1, 4) != DECODE(trim(k.nazn),NULL, 'конв','XXXX')
                      AND SUBSTR (LOWER (TRIM (o.nazn)), 1,3) LIKE SUBSTR(LOWER (TRIM (k.nazn)),1,3)||'%'
                      AND o.acck = ca.acc
                      and o.tt <> 'АСВ'
                 GROUP BY '3', ca.rnk, o.REF, o.tt, o.acck, o.nlsk, o.kv, o.nlsd,
                           o.accd, o.nazn);
   END IF;
  
   -- удаление типов проводок по кл-ру KL_FC9
   for i in (select o.ref, trim(o.nlsd) NLSD, trim(o.nlsk) NLSK,
                    trim(k.tt) TT, trim(k.nazn) NAZN, k.pr_del PR_DEL
             from otcn_f70_temp o, kl_fc9 k
             where o.nlsd LIKE k.nlsd || '%'
               and o.nlsk LIKE k.nlsk || '%'
               and NVL(trim(k.tt),o.tt) = o.tt
               and SUBSTR (LOWER (TRIM (o.nazn)), 1,3) LIKE
                   NVL(TRIM(k.nazn), SUBSTR(LOWER(TRIM(o.nazn)),1,3))||'%'
               and SUBSTR (LOWER (TRIM (o.nazn)), 1,3) NOT IN (select NVL(SUBSTR(LOWER(TRIM(k1.nazn)),1,3),'XXX')
                                                               from kl_fc9 k1
                                                               where k1.nlsd = k.nlsd
                                                                 and k1.nlsk = k.nlsk
                                                                 and k1.pr_del = 1)
               and k.pr_del = 0)
      loop

          DELETE FROM OTCN_F70_TEMP
          WHERE ref = i.ref;

      end loop;

      -- удаляем проводки пополнения коррсчета (в OPER Дт 2600 Кт 2600)
      delete from otcn_f70_temp
      where ref in ( select a.ref
                     from oper a
                     where a.ref in (select b.ref from otcn_f70_temp b)
                       and (UPPER(a.nam_a) like '%УКРПОШТА%' or UPPER(a.nam_b) like '%УКРПОШТА%')
                   );

      -- удаляем проводки по урегулированию бал.счета 2924 
      -- и различные коды ЬФО (в OPER Дт 2924 Кт 2924  MFOA <> MFOB)
      delete from otcn_f70_temp
      where nlsd like '3739%'
        and nlsk like '2924%'
        and ref in ( select a.ref
                     from oper a
                     where a.vdat = Dat_
                       and a.ref in (select b.ref from otcn_f70_temp b)
                       and a.nlsa like '2924%'
                       and a.nlsb like '2924%'
                       and a.mfoa <> a.mfob 
                    );

      -- удаляем проводки пополнения карточного счета (в OPER Дт 2635 Кт 2625)
      delete from otcn_f70_temp  
      where ref in ( select a.ref  
                     from oper a
                     where a.ref in (select b.ref from otcn_f70_temp b) 
                       and ( (a.nlsa like '263%' and a.nlsb like '262%') or   
                             (a.nlsa like '262%' and a.nlsb like '262%')
                           )
                   );

      -- удаляем проводки Дт 2909 Кт 2909 (алименты, пенсии)
      delete from otcn_f70_temp
      where nlsd like '2909%'
        and nlsk like '2909%' 
        and ( lower(nazn) like '%пенс__%' or 
              lower(nazn) like '%ал_мент_%'
            );

      -- для Черниговского РУ
      -- удаляем проводки Дт 2909 Кт 2924 где в OPER не Дт 2909 Кт 2625
      -- для Полтавского РУ (добавлено 13.03.2017)
      IF mfo_ in (353553, 331467) 
      THEN 
         delete from otcn_f70_temp o
         where o.nlsd like '2909%'
           and o.nlsk like '2924%'
           and not exists ( select 1 
                            from provodki_otc p
                            where p.ref = o.ref
                              and p.kv = o.kv
                              and p.nlsd = o.nlsd
                              and p.nlsk = o.nlsk 
                              and p.nlsa like '2909%' 
                              and p.nlsb like '2625%'
                          );
      END IF;

      for k in ( select * from otcn_f70_temp
                 where nlsd like '2909%'
                   and nlsk like '2924%'
               )
         loop

            begin
               select p.rnkk 
                  into rnk_
               from provodki_otc p
               where p.fdat = Dat_ 
                 and p.nlsd like k.nlsk || '%'
                 and p.nlsk like '2625%'
                 and p.kv = k.kv 
                 and p.s*100 = k.s_nom
                 and rownum = 1;
            exception when no_data_found then
               BEGIN
                  select p.rnkk 
                     into rnk_
                  from provodki_otc p, operw w
                  where p.fdat = dat_ 
                    and ( (p.nlsd like '2924%' and p.nlsk like '2625%') OR 
                          (p.nlsd like '3739%' and p.nlsk like '2909%')
                        )
                    and p.kv = k.kv 
                    and p.s*100 = k.s_nom 
                    and w.ref = k.ref 
                    and w.tag like '59%' 
                    and p.nlsk = substr(w.value,2,14); 
   
                 update otcn_f70_temp t set t.rnk = rnk_
                 where t.ref = k.ref
                   and t.nlsd like '2909%' 
                   and t.nlsk like '2924%'; 
               exception when no_data_found then
                  null;
               END;
            end;
      end loop;
    
   OPEN c_main;

   LOOP
      FETCH c_main
       INTO ko_, rnk_, okpo_, nmk_, k040_, adr_, k110_, codc_, sum1_, sumk1_;

      EXIT WHEN c_main%NOTFOUND;
      sum1_ := sum1_ - NVL (sumk1_, 0);
      rez_ := MOD (codc_, 2);

      if length(trim(okpo_)) <= 8 
      then
         okpo_ := lpad(trim(okpo_),8,'0');
      else
         okpo_ := lpad(trim(okpo_),10,'0');
      end if;

      -- для банков по коду ОКПО из RCUKRU(IKOD)
      -- определяем код банка поле GLB
      if codc_ in (1,2) 
      then
         BEGIN
            select lpad(to_char(glb), 3, '0') 
               into okpo_
            from rcukru
            where trim(ikod) = trim(okpo_)
              and rownum = 1;
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
              and rownum = 1;
         okpo_ := trim(ser_) || ' ' || trim(numdoc_);               
         EXCEPTION WHEN NO_DATA_FOUND THEN 
            null;
         END;
      end if;

      -- до 13.08.07 в файл #C9 включалась сумма поступления от нерезидентов
      -- 100 тыс.долларов общая по клиенту, а
      -- с 13.08.2007 50 тыс.долларов только одной операции

      okpo_1 := okpo_;

      ---надходження в?д нерезидент?в безгот?вково? валюти
      OPEN opl_dok;

      LOOP
         FETCH opl_dok
          INTO ko_1, ref_, acc_, nls_, kv_, nlsk_, accd_, nazn_, sum0_, sumk0_ ;

         EXIT WHEN opl_dok%NOTFOUND;

         okpo_ := okpo_1;
         nls1_  := substr(nls_,1,2);
         d1#C9_ := null;
         d2#C9_ := null;
         d3#C9_ := null;
         d4#C9_ := null;
         d6#C9_ := null;
         dc#C9_ := null;
         d99#C9_:= null;
         de#C9_ := null;
         val_   := null;
         kol_99 := 0;
         refd1_ := ref_;
         kod_g_ := null;
         s_nom_2603 := 0;
         name_sp_ := '';
         pr_2625_ := 0;

         if nlsk_ like '2909______0000%' and nls_ like '2909%'
         then
            begin
               select c.okpo
                  into okpo_
                 from opldok p, opldok p1, accounts a, customer c
                 where p.fdat = Dat_
                   and p.dk = 0 
                   and p.acc = acc_                                        
                   and p.s = sum0_
                   and p.ref = p1.ref 
                   and p.stmt = p1.stmt 
                   and p1.dk = 1
                   and p1.acc = a.acc
                   and (a.nls like '2603%' or a.nls like '2620%') 
                   and a.rnk = c.rnk
                   and rownum = 1 ; 
            EXCEPTION WHEN NO_DATA_FOUND THEN
               NULL;
            END;
         end if;

         if nlsk_ like '2603%' and nls_ like '2900%' 
         then
            begin
               select ref
                  into refd1_
               from otcn_f70_temp
               where nlsd like '2603%'
                 and (nlsk like '2600%' or nlsk like '2650%')
                 and kv = kv_
                 and round(s_nom/100, 0) = round(sum0_/100, 0)
                 and rnk = rnk_
                 and rownum = 1;
            exception when no_data_found then
               null;
            end;
         end if;

         IF (ko_ = '3' AND ROUND (sumk0_ / kurs_, 0) > gr_sumn_ AND
             ( nls1_ not in ('15','16') OR
               ( nls1_ in ('15','16') and codc_ in (2,4,6)
               ) 
             ) 
            ) OR
            ROUND (GL.p_icurval(kv_, s_nom_2603, dat_) / kurs_, 0) > gr_sumn_

         THEN
            dig_ := f_ret_dig (kv_) * 100;
                                    -- сумма должна быть в единицах валюты

            IF ko_ = ko_1
            THEN
               IF typ_ > 0
               THEN
                  nbuc_ := NVL (f_codobl_tobo (acc_, typ_), nbuc1_);
               ELSE
                  nbuc_ := nbuc1_;
               END IF;

               -- OAB добавил 16.06.06 по просьбе Сбербанка
               -- определяем код страны перечисления валюты
               if ko_ = 3 
               then 
                  BEGIN
                     SELECT SUBSTR (VALUE, 1, 70)
                        INTO d6#c9_
                     FROM operw
                     WHERE REF = refd1_ AND tag = 'D6#70';
                  EXCEPTION
                     WHEN NO_DATA_FOUND
                     THEN
                     d6#C9_ := NULL;
                  END;
               end if;
               
               for k in (select * from operw where ref=refd1_)

               loop

                  -- с 01.08.2012 добавляется код страны отправителя или получателя перевода
                  if k.tag like 'n%' and substr(trim(k.value),1,1) in ('O','P','О','П') 
                  then
                     kod_g_ := substr(trim(k.value),2,3);
                  end if;

                  if kod_g_ is null and k.tag like 'n%' and substr(trim(k.value),1,1) not in ('O','P','О','П') 
                  then
                     kod_g_ := substr(trim(k.value),1,3);
                  end if;

                  if kod_g_ is null and k.tag like 'D6#70%' and substr(trim(k.value),1,1) in ('O','P','О','П') 
                  then
                     kod_g_ := substr(trim(k.value),2,3);
                  end if;

                  if kod_g_ is null and k.tag like 'D6#70%' and substr(trim(k.value),1,1) not in ('O','P','О','П') 
                  then
                     kod_g_ := substr(trim(k.value),1,3);
                  end if;

                  if kod_g_ is null and k.tag like 'D6#E2%' and substr(trim(k.value),1,1) in ('O','P','О','П') 
                  then
                     kod_g_ := substr(trim(k.value),2,3);
                  end if;

                  if kod_g_ is null and k.tag like 'D6#E2%' and substr(trim(k.value),1,1) not in ('O','P','О','П') 
                  then
                     kod_g_ := substr(trim(k.value),1,3);
                  end if;

                  if kod_g_ is null and k.tag like 'D1#E9%' and substr(trim(k.value),1,1) in ('O','P','О','П') 
                  then
                     kod_g_ := substr(trim(k.value),2,3);
                  end if;

                  if kod_g_ is null and k.tag like 'D1#E9%' and substr(trim(k.value),1,1) not in ('O','P','О','П') 
                  then
                     kod_g_ := substr(trim(k.value),1,3);
                  end if;

               end loop;

               -- новый блок 14.03.2017
               IF kod_g_ is null 
               THEN
                  BEGIN
                     SELECT substr(trim(value), instr(UPPER(trim(value)),'3/')+2, 2)
                        INTO swift_k_
                     FROM OPERW
                     WHERE REF=REFD1_
                       AND TAG LIKE '50F%'
                       AND ROWNUM = 1;
                       
                     SELECT trim(b.k040)
                     INTO kod_g_
                     from kl_k040 b
                     where b.A2 like swift_k_ || '%';            
                  EXCEPTION WHEN NO_DATA_FOUND THEN
                     BEGIN
                        SELECT substr(trim(value), instr(UPPER(trim(value)),'/')+1, 2)
                        INTO swift_k_
                        FROM OPERW
                        WHERE REF=REFD1_
                          AND TAG LIKE '50K%'
                          AND ROWNUM = 1;
                       
                        SELECT trim(b.k040)
                           INTO kod_g_
                        from kl_k040 b
                        where b.A2 like swift_k_ || '%'; 
                     EXCEPTION WHEN NO_DATA_FOUND THEN
                        BEGIN
                           SELECT substr(trim(value), 1, 10)
                              INTO swift_k_
                           FROM OPERW
                           WHERE REF = REFD1_
                             AND TAG = '52A'
                             AND length(trim(value)) > 3
                             AND ROWNUM = 1;
      
                           BEGIN
                              SELECT k040
                                 INTO kod_g_
                              FROM RC_BNK
                              WHERE SWIFT_CODE LIKE swift_k_||'%'
                                AND ROWNUM = 1;
                           EXCEPTION WHEN NO_DATA_FOUND THEN
                              swift_k_ := substr(swift_k_,1,4)||' '||substr(swift_k_,5,2)||
                                        ' '||substr(swift_k_,7,2);
                              BEGIN
                                 SELECT k040
                                    INTO kod_g_
                                 FROM RC_BNK
                                 WHERE SWIFT_CODE LIKE swift_k_||'%'
                                   AND ROWNUM = 1;
                              EXCEPTION WHEN NO_DATA_FOUND THEN
                                 null;
                              END;
                           END;
                        EXCEPTION WHEN NO_DATA_FOUND THEN
                           BEGIN
                              SELECT substr(trim(value), 10, 10)
                                 INTO swift_k_
                              FROM OPERW
                              WHERE REF = REFD1_
                                AND TAG = '52A'
                                AND length(trim(value)) > 10
                                AND ROWNUM = 1;
      
                              BEGIN
                                 SELECT k040
                                    INTO kod_g_
                                 FROM RC_BNK
                                 WHERE SWIFT_CODE LIKE swift_k_||'%'
                                   AND ROWNUM = 1;
                              EXCEPTION WHEN NO_DATA_FOUND THEN
                                 swift_k_ := substr(swift_k_,1,4)||' '||substr(swift_k_,5,2)||
                                           ' '||substr(swift_k_,7,2);
                                 BEGIN
                                    SELECT k040
                                       INTO kod_g_
                                    FROM RC_BNK
                                    WHERE SWIFT_CODE LIKE swift_k_||'%'
                                      AND ROWNUM = 1;
                                 EXCEPTION WHEN NO_DATA_FOUND THEN
                                    null;
                                 END;
                              END;
                           EXCEPTION WHEN NO_DATA_FOUND THEN
                              null;
                           END;
                        END;
                     END;
                  END;
               END IF;

               if kod_g_ is null 
               then
                  BEGIN
                     SELECT substr(value,1,3)
                        INTO kod_g_
                     FROM OPERW
                     WHERE REF = refd1_ AND tag = 'KOD_G';
                  EXCEPTION WHEN NO_DATA_FOUND THEN
                     BEGIN
                        SELECT '804'
                           INTO kod_g_
                        FROM OPERW
                        WHERE REF = refd1_ 
                          AND tag = '50F'
                          AND instr(UPPER(trim(value)),'3/UA') > 0;
                     EXCEPTION WHEN NO_DATA_FOUND THEN
                        kod_g_ := NULL;
                     END;
                  END;
               end if;

               if d6#C9_ is null and trim(kod_g_) is not null 
               then
                  d6#C9_ := kod_g_;
               end if;

               if d6#C9_ is null or d6#C9_ not in ('804','UKR') 
               then

                  -- для проводок Дт 2909 Кт 2924 в OPER NLSA='2909...' NLSB='2625...' 
                  -- будем выбирать первоначальную сумму док-та
                  -- и будем определять код ОКПО для счета 2625
                  if nlsk_ like '2909%' and nls_ like '2924%'
                  then
                     BEGIN
                        select o.s, trim(o.id_b)
                           into sum0_, okpo_
                        from oper o 
                        where o.ref = ref_
                          and o.nlsa like '2909%'
                          and o.nlsb like '2625%';                              
                        --select p.ps, trim(c.okpo)
                        --   into sum0_, okpo_
                        --from provodki_otc p, customer c
                        --where fdat = Dat_ 
                        --  and p.ref = ref_
                        --  and p.nlsd like nls_ || '%'
                        --  and p.nlsk like '2625%'
                        --  and p.rnkk = c.rnk;               
                     EXCEPTION WHEN NO_DATA_FOUND THEN
                        BEGIN 
                           select 1, trim(c.okpo)
                              into pr_2625_, okpo_
                           from operw o, accounts a, customer c
                           where o.ref = ref_
                             and o.tag like '59%'
                             and substr(o.value,2,14) like a.nls || '%'
                             and a.rnk = c.rnk;
                        EXCEPTION WHEN NO_DATA_FOUND THEN 
                           NULL;
                        END;
                     END;  
                  end if; 

                  if ref_ = refd1_
                  then
                     nnnn_ := nnnn_ + 1;

                     -- код валюти
                     p_ins (nnnn_, '10', LPAD (kv_, 3, '0'));

                     -- сума в единицах валюты (код 12)
                     -- округлять будем общую сумму по клиенту в TMP_NBU
                     --p_ins (nnnn_, '20', TO_CHAR (ROUND (sum0_ / dig_, 0)));
                     p_ins (nnnn_, '20', TO_CHAR (sum0_));

                     -- ОКПО клiєнта
                     -- для нерезидентiв
                     IF (rez_ = 0 and trim(okpo_) is null) OR 
                        (rez_ = 0 and trim(okpo_) in ('00000','000000000','0000000000','99999') )
                     THEN
                        okpo_ := '0';
                     END IF;

                     if okpo_ = ourOKPO_ 
                     then
                        okpo_ := ourGLB_;
                        codc_ := 1 ;
                     end if;

                     p_ins (nnnn_, '31', TRIM (okpo_));

                     if dat_ >= to_date('13082007','ddmmyyyy') 
                     then
                        -- код резидентностi
                        p_ins (nnnn_, '35', TO_CHAR(2 - mod(codc_,2)));
                     end if;
                  else 
                     BEGIN
                        select substr(kodp,3,3)
                           into nnnn1_
                        from rnbu_trace 
                        where ref = refd1_
                          and substr(kodp,1,2) = '20';
                     EXCEPTION WHEN NO_DATA_FOUND THEN
                        nnnn1_ := nnnn_ + 1;   
                     END;
                     -- сума в единицах валюты (код 12)
                     -- округлять будем общую сумму по клиенту в TMP_NBU
                     --p_ins (nnnn1_, '20', TO_CHAR (ROUND (sum0_ / dig_, 0)));
                     p_ins (nnnn1_, '20', TO_CHAR (sum0_));

                  end if;
               end if;

               refd_ := to_number(trim(f_dop(ref_, 'NOS_R')));

               begin
                  select trim(nd)
                     into nd_
                  from oper
                  where ref = ref_;
               exception
                         when no_data_found then
                  nd_ := '0';
               end;

               if refd_ is null 
               then
                  begin
                     select ref
                        into refd_
                     from oper
                     where vdat = any (select max(fdat) from fdat where fdat BETWEEN dat_ - 7 AND dat_)  
                       --vdat between dat_ - 7 and dat_  
                       and nlsb = nls_ 
                       and kv = kv_ 
                       and refl = ref_;
                  exception
                            when no_data_found then
                     begin
                        select ref
                           into refd_
                        from oper
                        where vdat = any (select max(fdat) from fdat where fdat BETWEEN dat_ - 7 AND dat_)  
                          --vdat between dat_ - 7 and dat_ 
                          and nlsb = nls_ 
                          and kv = kv_ 
                          and ref like nd_ || '%';
                     exception
                            when others then
                        begin
                           select ref
                              into refd_
                           from oper
                           where vdat = dat_ 
                             and nlsa like '2909%'   
                             and nlsb = nlsk_ 
                             and kv   = kv_ 
                             and s = sum0_   
                             and rownum = 1;
                        exception
                               when no_data_found then
                           refd_ := null;
                        end;
                     end;
                  end;
               end if;

               begin
                  select p.pid, max(p.id)
                     into pid_, id_
                  from contract_p p
                  where p.ref = ref_
                  group by p.pid;

                  select lpad(to_char(t.id_oper),2,'0'),
                         t.name, to_char(t.dateopen, 'ddmmyyyy'),
                         t.bankcountry
                     into D1#C9_, D2#C9_, D3#C9_, D6#C9_
                  from top_contracts t
                  where t.pid = pid_; --and p.kv=t.kv - Инна сказала, что это условие лишнее (платеж м.б. в другой валюте)

                  BEGIN
                     select max(trim(name))
                        into DC#C9_max
                     from tamozhdoc
                     where pid = pid_
                       and id = id_ ;

                     select count(*)
                        INTO kol_99
                     from contract_p
                     where ref = ref_;
                  exception
                            when no_data_found then
                     DC#C9_ := null;
                  END;

                  if DC#C9_max is not null 
                  then
                     BEGIN
                        select to_char(t.datedoc,'ddmmyyyy'),
                               lpad(trim(c.cnum_cst),9,'#')||'/'||
                               substr(c.cnum_year,-1)||'/'||
                               lpad(DC#C9_max,6,'0')
                           into D4#C9_, DC#C9_
                        from tamozhdoc t, customs_decl c
                        where t.pid = pid_
                          and t.id = id_
                          and trim(t.name) = trim(DC#C9_max)
                          and trim(c.cnum_num) = trim(t.name)
                          and trim(c.f_okpo) = trim(okpo_)
                          and rownum = 1;
                     exception
                               when no_data_found then
                        dc#c9_ := dc#c9_max;  --null;
                     end;

                     if kol_99 <= 3 
                     then
                        for k in ( select pid, id
                                   from contract_p
                                   where ref = ref_ and id <> id_
                                   order by pid, id )

                        loop

                           select t.name, to_char(t.datedoc,'dd/mm/yyyy'),
                                  lpad(trim(c.cnum_cst),9,'#')||'/'||
                                  substr(c.cnum_year,-1)||'/'
                              into name_, datedoc_, DC1#C9_
                           from  tamozhdoc t, customs_decl c
                           where t.pid = k.pid
                             and t.id = k.id
                             and trim(c.cnum_num) = trim(t.name)
                             and trim(c.f_okpo) = trim(okpo_)
                             and rownum = 1;

                           D99#C9_ := D99#C9_||DC1#C9_||trim(name_)||' '||
                                      datedoc_||',';

                        end loop;
                     else
                        D99#C9_ := 'оплата за'||to_char(kol_99)||'-ма ВМД';
                     end if;
                  end if;
               exception
                         when no_data_found then
                  null;
                         when too_many_rows then
                  null; -- если платеж по нескольким контрактам, то пусть разбивают сумму и вводят реквизиты сами
               end;

               if refd_ is null 
               then
                  refd_ := ref_;
               end if;

               -- додатковi параметри
               IF dat_ < TO_DATE ('13-08-2007','dd-mm-yyyy')
               THEN
                  n_ := 11;
               ELSE
                  n_ := 13;
               END IF;

               IF dat_ >= to_date('01062009','ddmmyyyy') and dat_ <= dat_Izm1_
               THEN
                  n_ := 14;
               END IF;

               if ref_ = refd1_ 
               then

                  FOR i IN 1 .. n_
                  LOOP
                     tag_ := '';
                 
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
                     ELSIF i = 13
                     THEN
                        tag_ := 'DD#70';
                     ELSE
                        tag_ := 'DE#C9';
                     END IF;

                     IF i = 1 
                     THEN
                        tag_ := 'D1#C9';
                     END IF;

                     -- с 01.07.2005 для поступлений от нерезидентов нужны
                     -- доп.реквизиты (D1#70,D6#70,D9#70,DA#70)
                     -- с 28.02.2006 нужны доп.реквизиты (D1#70,D6#70,DB#70)
                     -- с 13.08.2007 нужны доп.реквизиты (D1#70, D2#70, D3#70,
                     --                                   D4#70, D6#70, DB#70,
                     --                                   DC#70)

                     IF (dat_ < TO_DATE ('13-08-2007','dd-mm-yyyy') and
                         ko_ = 3 AND i IN (1, 6, 11)) OR
                        (dat_ >= TO_DATE ('13-08-2007','dd-mm-yyyy') and
                         dat_ <  TO_DATE ('01-06-2009','dd-mm-yyyy') and
                         ko_ = 3 AND i IN (1, 2, 3, 4, 6, 11, 12, 13) OR
                        (dat_ >= TO_DATE ('01-06-2009','dd-mm-yyyy') and
                         ko_ = 3 AND i IN (1, 6, 11, 13, 14)))
                     THEN
                        -- 16.06.06 OAB добавил условие, если Украина, то не формируем
                        IF d6#C9_ IS NULL OR TRIM (d6#C9_) not in ('804','UKR')
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
                           p_tag (i, val_, kodp_, ref_, nazn_);
                           -- запис показника
                           p_ins (nnnn_, kodp_, val_);
                        END IF;
                     END IF;
                  END LOOP;
               end if;
            END IF;
         END IF;
      END LOOP;

      CLOSE opl_dok;
   END LOOP;

   CLOSE c_main;
---------------------------------------------------
-- с 23.09.2014 будет формироваться новый блок с кодом мети надходження 36
-- общая сумма в разрезе валют всех поступлений в том числе меньше 1000.00$
if Dat_ >= to_date('23092014','ddmmyyyy')
then

   kv_ := '000';
   nbuc_ := nbuc1_;

   for k in ( SELECT t.kv, t.ref,
                     SUM ( NVL(round(z.s2 / 0.50,0), t.s_nom) ) s_nom, 
                     SUM (t.s_eqv) s_eqv
               FROM (select a.kv, a.nls nlsk, o.ref, o.s s_nom,o.sq s_eqv 
                     from opldok o, accounts a 
                     where o.fdat = dat_ 
                       and o.acc = a.acc 
                       and a.nbs = '2603' 
                       and a.kv <> 980 
                       and o.dk = 1 ) t, zayavka z
              WHERE t.nlsk like '2603%'
                and t.ref = z.refoper(+)
                and z.dk = 2 
                and z.obz = 1
                and z.sos <> -1
              GROUP BY t.kv, t.ref 
              ORDER BY 1, 2
            )

     loop

        dig_ := f_ret_dig (k.kv) * 100;
        ref_ := k.ref;

        if k.kv <> kv_ 
        then
           nnnn_ := nnnn_ + 1;
           kv_ := k.kv;

           -- код валюти
           p_ins (nnnn_, '10', LPAD (k.kv, 3, '0'));
       
           -- сума в единицах валюты (код 12)
           --p_ins (nnnn_, '20', TO_CHAR (round(k.s_nom / dig_ * 0.65,0)));

           -- ОКПО клiєнта
           p_ins (nnnn_, '31', '2603');

           -- код резидентностi
           p_ins (nnnn_, '35', '1');

           -- код мети
           p_ins (nnnn_, '40', '36');

           IF Dat_ <= dat_Izm1_ 
           THEN
              -- код надходження відп. до плат.календаря
              p_ins (nnnn_, '41', '999');
           END IF;

           IF Dat_ >= dat_Izm2_ 
           THEN
              -- код валютної операції
              p_ins (nnnn_, '42', '00');
           END IF;

           -- код країни
           p_ins (nnnn_, '62', '804');

           -- відомості про операцію
           p_ins (nnnn_, '99', 'Сума що підлягає обов"язковому продажу');
        end if;

        -- сума в единицах валюты (код 12)
        p_ins (nnnn_, '20', TO_CHAR (k.s_nom));

     end loop;

end if;
---------------------------------------------------
   DELETE FROM tmp_nbu
         WHERE kodf = kodf_ AND datf = dat_;

---------------------------------------------------
   INSERT INTO tmp_nbu 
      (kodp, datf, kodf, znap, nbuc)
       ( SELECT kodp, dat_, kodf_, to_char (ROUND(sum(znap)/100,0)) znap, nbuc
         FROM rnbu_trace
         where kodp like '20%'
         group by kodp, dat_, kodf_, nbuc
         UNION ALL
         SELECT kodp, dat_, kodf_, znap, nbuc
         FROM rnbu_trace
         where kodp not like '20%'
       );
----------------------------------------
DELETE FROM OTCN_TRACE_70
         WHERE kodf = kodf_ and datf = dat_ ;

insert into OTCN_TRACE_70(KODF, DATF, USERID, NLS, KV, ODATE, KODP, ZNAP, NBUC, ISP, RNK, ACC, REF, COMM, ND, MDATE, TOBO)
select kodf_, dat_, USERID_, NLS, KV, ODATE, KODP, ZNAP, NBUC, ISP, RNK, ACC, REF, COMM, ND, MDATE, TOBO
from rnbu_trace;

   logger.info ('P_FC9_NN: End for datf = '||to_char(dat_, 'dd/mm/yyyy'));
END p_fc9_nn;
/

show err;