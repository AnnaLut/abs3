

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F2D_NN.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F2D_NN ***

  CREATE OR REPLACE PROCEDURE BARS.P_F2D_NN ( dat_     DATE,
                                       sheme_   VARCHAR2 DEFAULT 'G') IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Процедура формирования #2D для КБ
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     : 06/11/2017 (11/03/2016, 04/11/2015)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
параметры: Dat_ - отчетная дата
           sheme_ - схема формирования
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
06.11.2017 удалил все блоки для закрытых банков (по коду МФО)
11.03.2016 протокол формирования будет сохраняться в таблицу 
           OTCN_TRACE_70
03.11.2015 значение показателя 64 будем определять также как и в файле #E2.
30.09.2014 для банка Надра будут включаться проводки Дт 2650 Кт 1919
           Дт 2909 Кт 1919
           для 315784 (Хмельницького РУ) будут включаться проводки
           Дт 2600,2620,2650 Кт 2909
25.09.2014 с 25.09.2014 новый файл отчетности аналог файла #E2
24.06.2014 вместо доп.реквизита 57A будем обрабатывать доп.реквизит 58A
           - SWIFT_CODE (после изменеия перечня доп.реквизитов)
03.06.2014 для доп.реквизита tag like '59%' выбираем первых 3 символа
           из поля VALUE
09.04.2014 включались суммы док-тов >=1001$ а необходимо 1000.01$ и больше 
03.04.2014 будут отбираться суммы документов строго больше 1000$ 
27.02.2014 для ОПЕРУ СБ не будем включать проводки вида 
           Дт '37396506' Кт '1500%' и назначение "розрахунки за чеками"
19.02.2014 для физлиц резидентов не имеющих ОКРО определяем серию и номер
           паспорта
13.02.2014 будут включаться док-ты с суммой не менее 1000.00$
08.01.2014 для ОПЕРУ СБ будем включать проводки вида 
           Дт '37396506' Кт '1500%' и назначение "розрахунки за чеками"
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
   kodf_      VARCHAR2 (2)   := '2D';
   sql_z      VARCHAR2 (200);
   typ_       NUMBER;
   gr_sum_    NUMBER         := 100;   --для переказу
   sum_kom    NUMBER;                      -- сума комiсiї
   flag_      NUMBER;
   ko_        VARCHAR2 (2);      -- ознака операцii з безготiвковою iнвалютою
   ko_1       VARCHAR2 (2);      -- ознака операцii з безготiвковою iнвалютою
   kod_b_     VARCHAR2 (10);                          -- код банку
   nam_b      VARCHAR2 (70);                        -- назва банку
   n_         NUMBER         := 10;
   -- кол-во доп.параметров до 03.07.2006 после n_=11
   acc_       NUMBER;
   accd_      NUMBER;
   acck_      NUMBER;
   kv_        NUMBER;
   kv1_       NUMBER;
   nls_       VARCHAR2 (15);
   nlsk_      VARCHAR2 (15);
   nlsk1_     VARCHAR2 (15);
   nbuc1_     VARCHAR2 (12);
   nbuc_      VARCHAR2 (12);
   kod_g_     VARCHAR2 (3);
   country_   VARCHAR2 (3);
   b010_      VARCHAR2 (10);
   swift_k_   VARCHAR2 (12);
   bic_code   VARCHAR2 (14);
   rnk_       NUMBER;
   okpo_      VARCHAR2 (14);
   okpo1_     VARCHAR2 (14);
   nmk_       VARCHAR2 (70);
   adr_       VARCHAR2 (70);
   k040_      VARCHAR2 (3);
   k110_      VARCHAR2 (5);
   val_       VARCHAR2 (70);
   nb_        VARCHAR2 (70);
   tg_        VARCHAR2 (70);
   data_      DATE;
   dig_       NUMBER;
   bsum_      NUMBER;
   bsu_       NUMBER;
   sum1_      DECIMAL (24);
   sum0_      DECIMAL (24);
   sumk1_     DECIMAL (24);                 --ком_с_я в ц_лому по контрагенту
   sumk0_     DECIMAL (24);                            --ком_с_я по контракту
   kodp_      VARCHAR2 (10);
   znap_      VARCHAR2 (70);
   kurs_      NUMBER;
   tag_       VARCHAR2 (5);
   nnnn_      NUMBER         := 0;
   userid_    NUMBER;
   ref_       NUMBER;
   rez_       NUMBER;
   codc_      NUMBER;
   mfo_       number;
   mfou_      number;
   tt_        varchar2(3);

   kod_n_     varchar2(4);
   refd_      number;
   ttd_       varchar2(3);
   nlsdd_     varchar2(20);
   formOk_    boolean;
   s180_      varchar2(1);
   accdd_     number;

   d1#E2_     VARCHAR2 (70);
   d2#E2_     VARCHAR2 (70);
   d3#E2_     VARCHAR2 (70);
   d4#E2_     VARCHAR2 (70);
   d6#E2_     VARCHAR2 (70);
   d7#E2_     VARCHAR2 (70);
   d8#E2_     VARCHAR2 (70);
   db#E2_     VARCHAR2 (70);
   dc#E2_     VARCHAR2 (70);
   dc#E2_max  VARCHAR2 (70);
   d61#E2_    VARCHAR2 (170);
   kol_61     number;
   DC1#E2_    VARCHAR2 (70);
   DE#E2_     VARCHAR2 (3);
   nazn_      VARCHAR2 (160);
   mbkOK_     boolean;
   ourOKPO_   varchar2 (14);
   ourGLB_    varchar2 (3);
   pid_       Number;
   id_        Number;
   id_min_    Number :=0;
   kol_ref_   Number;
   kod_obl_   Varchar2 (2);
   ser_       person.ser%TYPE;
   numdoc_    person.numdoc%TYPE;

   --курсор по контрагентам
   CURSOR c_main
   IS
      SELECT   t.ko, decode(substr(b.b040,9,1),'2',substr(b.b040,15,2),substr(b.b040,10,2)), 
               c.rnk, trim(c.okpo), c.nmk, TO_CHAR (c.country), c.adr,
               NVL (c.ved, '00000'), c.codcagent, NVL(SUM (t.s_eqv),0),
               NVL(SUM (gl.p_icurval (t.kv, t.s_kom, dat_)),0)  
          FROM OTCN_PROV_TEMP t, customer c, tobo b  
         WHERE t.rnk = c.rnk
           and c.tobo = b.tobo   
      GROUP BY t.ko,
               decode(substr(b.b040,9,1),'2',substr(b.b040,15,2),substr(b.b040,10,2)), 
               c.rnk,
               c.okpo,
               c.nmk,
               TO_CHAR (c.country),
               c.adr,
               NVL (c.ved, '00000'),
               c.codcagent
      ORDER BY 2;

   --- переказ безготiвковоi валюти
   CURSOR opl_dok
   IS
      SELECT   t.ko, t.REF, t.tt, t.accd, t.nlsd, t.kv, t.acck, t.nlsk,
               t.nazn, t.s_nom, t.s_eqv
          FROM OTCN_PROV_TEMP t
         WHERE t.rnk = rnk_;

-------------------------------------------------------------------
   PROCEDURE p_ins (p_np_ IN NUMBER, p_kodp_ IN VARCHAR2, p_znap_ IN VARCHAR2)
   IS
      l_kodp_   VARCHAR2 (10);
      p_znap1_  VARCHAR2 (70);
   BEGIN

      if p_kodp_='31' and length(trim(p_znap_)) < 3 and trim(p_znap_) != '0' then
         p_znap1_ := LPAD (p_znap_, 3, '0');
      else
         p_znap1_ := p_znap_;
      end if;

      if mfo_ = 300465 and p_kodp_='31' then
         if (nlsk_ like '1500%' and ( nls_ in ('29091000580557',
                                               '29092000040557',
                                               '29095000081557',
                                               '29095000046547',
                                               '29091927',
                                               '2909003101',
                                               '292460205',
                                               '292490204') OR
                                      substr(nls_,1,4) = '1502')
                                             ) OR p_znap1_='6' then
            p_znap1_ := '006';
         end if;
      end if;

      l_kodp_ := p_kodp_ || LPAD (TO_CHAR (p_np_), 3, '0');

    if substr(l_kodp_, 1, 2) = '64' then
          INSERT INTO rnbu_trace
                      (nls, kv, odate, kodp, znap, nbuc, ref, rnk, comm
                      )
               VALUES (nls_, kv_, dat_, l_kodp_, p_znap1_, nbuc_, ref_, rnk_, D6#E2_
                      );
    elsif substr(l_kodp_, 1, 2) = '65' then
          INSERT INTO rnbu_trace
                      (nls, kv, odate, kodp, znap, nbuc, ref, rnk, comm
                      )
               VALUES (nls_, kv_, dat_, l_kodp_, p_znap1_, nbuc_, ref_, rnk_, nvl(D7#E2_, kod_b_||' '||to_char(kv_))
                      );
    else
         INSERT INTO rnbu_trace
                  (nls, kv, odate, kodp, znap, nbuc, ref, rnk, comm, nd
	                  )
           VALUES (nls_, kv_, dat_, l_kodp_, p_znap1_, nbuc_, ref_, rnk_, to_char(refd_), id_min_
                  );
    end if;
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

      BEGIN
         select substr(trim(value),1,4)
            into kod_n_
         from operw
         where ref = p_ref_
           and tag = 'KOD_N';
      EXCEPTION WHEN NO_DATA_FOUND THEN
         kod_n_ := null;
      END;

      IF p_i_ = 1
      THEN
         p_kodp_ := '40';

         if mfo_ = 300465 then
            if nlsk_ like '1500%' and nls_ in ('29091000580557',
                                               '29092000040557',
                                               '29095000081557',
                                               '29095000046547',
                                               '29091927',
                                               '2909003101',
                                               '292460205',
                                               '292490204') then
               --d1#E2_ := '31';  -- было до 26.07.2012                              
               d1#E2_ := '37';    -- с 26.07.2012 согласно письма Рощиной от 11.07.2012
            end if;
            if nlsk_ like '1500%' and
                nls_ in ('37394501547') --and  --,'37396506') 
               --(instr(lower(nazn_),'розрахунки за чеками') > 0 or  instr(lower(nazn_),'розрахунки по чеках') > 0)
            then
               d1#E2_ := '31';  -- с 26.07.2012 согласно письма Рощиной от 11.07.2012
            end if;

         end if;

         if TRIM (p_value_) is null and d1#E2_ is null and nazn_ is not null then
            if instr(lower(nazn_),'грош') > 0 then
               d1#E2_ := '38';  -- с 26.07.2012 согласно письма Рощиной от 11.07.2012
            end if;
            
            if mfo_ <> 300120 and instr(lower(nazn_),'комерц') > 0 then
               d1#E2_ := '38';  -- с 26.07.2012 согласно письма Рощиной от 11.07.2012
            end if;
            
            if instr(lower(nazn_),'соц_альний переказ') > 0 then
               d1#E2_ := '38';  -- с 26.07.2012 согласно письма Рощиной от 11.07.2012
            end if;

            if d1#E2_ is null and instr(lower(nazn_),'переказ') > 0 and trim(nls_) like '2620%' then
               d1#E2_ := '38';  -- с 26.07.2012 согласно письма Рощиной от 11.07.2012
            end if;
         end if;

         if mfo_ = 353575 then
            p_value_ := NVL (SUBSTR (TRIM (p_value_), 1, 2), '00');
         else 
            if TRIM (p_value_) is null and d1#E2_ is not null then
               p_value_ := NVL (SUBSTR (TRIM (d1#E2_), 1, 2), '00');
            else
               p_value_ := NVL (SUBSTR (TRIM (p_value_), 1, 2), '00');
               if p_value_ = '00' then
                  if kod_n_='8445' then
                     p_value_ := '30';
                  end if;
               end if;
               d1#E2_ := p_value_;
            end if;
         end if;
      ELSIF p_i_ = 6
      THEN
         p_kodp_ := '64';

         IF p_value_ IS NOT NULL
         THEN
            p_value_ := LPAD (p_value_, 3, '0');
         else
            p_value_ := trim(D6#E2_);
         END IF;

         if Dat_ >= to_date('01092011','ddmmyyyy') and trim(kod_g_) is not null then
            p_value_ := trim(kod_g_);
         end if;

         IF mfo_ != 353575 and p_value_ is null THEN
            BEGIN
               SELECT substr(trim(value), 1, 12)
                  INTO swift_k_
               FROM OPERW
               WHERE REF=REF_
                 AND TAG LIKE '58A%'
                 AND ROWNUM=1;

               BEGIN
                  SELECT k040
                     INTO p_value_
                  FROM RC_BNK
                  WHERE SWIFT_CODE LIKE swift_k_||'%'
                    AND ROWNUM=1;
               EXCEPTION WHEN NO_DATA_FOUND THEN
                  swift_k_ := substr(swift_k_,1,4)||' '||substr(swift_k_,5,2)||
                           ' '||substr(swift_k_,7,2);
                  BEGIN
                     SELECT k040
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
                    AND TAG LIKE '57A%'
                    AND ROWNUM=1;

                  BEGIN
                     SELECT k040
                        INTO p_value_
                     FROM RC_BNK
                     WHERE SWIFT_CODE LIKE swift_k_||'%'
                       AND ROWNUM=1;
                  EXCEPTION WHEN NO_DATA_FOUND THEN
                     swift_k_ := substr(swift_k_,1,4)||' '||substr(swift_k_,5,2)||
                              ' '||substr(swift_k_,7,2);
                     BEGIN
                        SELECT k040
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
                        SELECT k040
                           INTO p_value_
                        FROM RC_BNK
                        WHERE SWIFT_CODE LIKE swift_k_||'%'
                          AND ROWNUM=1;
                     EXCEPTION WHEN NO_DATA_FOUND THEN
                        swift_k_ := substr(swift_k_,1,4)||' '||substr(swift_k_,5,2)||
                                 ' '||substr(swift_k_,7,2);
                        BEGIN
                           SELECT k040
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
                           SELECT k040
                              INTO p_value_
                           FROM RC_BNK
                           WHERE SWIFT_CODE LIKE swift_k_||'%'
                             AND ROWNUM=1;
                        EXCEPTION WHEN NO_DATA_FOUND THEN
                           swift_k_ := substr(swift_k_,1,4)||' '||substr(swift_k_,5,2)||
                                       ' '||substr(swift_k_,7,2);
                           BEGIN
                              SELECT k040
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
                              SELECT k040
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
            END;
         END IF;
         country_ := NVL(SUBSTR (TRIM (p_value_), 1, 3), '000');
         p_value_ :=
            NVL (SUBSTR (TRIM (p_value_), 1, 70),
                 'код краiни у яку переказана валюта' );
      ELSIF p_i_ = 9
      THEN
         b010_ := null;
         p_kodp_ := '65';

         if TRIM (p_value_) is null and d7#E2_ is not null then
            p_value_ := NVL (SUBSTR (TRIM (d7#E2_), 1, 10), 'код банку');
         end if;

         if TRIM (p_value_) is null and d7#E2_ is null then
            BEGIN
               SELECT substr(trim(value), 1, 12)
                  INTO swift_k_
               FROM OPERW
               WHERE REF = REF_
                 AND TAG LIKE '58A%'
                 AND ROWNUM = 1;

               BEGIN
                  SELECT b010
                     INTO p_value_
                  FROM RC_BNK
                 WHERE SWIFT_CODE LIKE swift_k_||'%'
                   AND ROWNUM = 1;
               EXCEPTION WHEN NO_DATA_FOUND THEN
                  swift_k_ := substr(swift_k_,1,4)||' '||substr(swift_k_,5,2)||
                              ' '||substr(swift_k_,7,2);
                  BEGIN
                     SELECT b010
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
                  SELECT substr(trim(value), 1, 12)
                     INTO swift_k_
                  FROM OPERW
                  WHERE REF = REF_
                    AND TAG LIKE '57A%'
                    AND ROWNUM = 1;

                  BEGIN
                     SELECT b010
                        INTO p_value_
                     FROM RC_BNK
                     WHERE SWIFT_CODE LIKE swift_k_||'%'
                       AND ROWNUM = 1;
                  EXCEPTION WHEN NO_DATA_FOUND THEN
                     swift_k_ := substr(swift_k_,1,4)||' '||substr(swift_k_,5,2)||
                                 ' '||substr(swift_k_,7,2);
                     BEGIN
                        SELECT b010
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
                     SELECT substr(trim(value), 1, 12)
                        INTO swift_k_
                     FROM OPERW
                     WHERE REF = REF_
                       AND TAG LIKE '57D%'
                       AND ROWNUM = 1;

                     BEGIN
                        SELECT b010
                           INTO p_value_
                        FROM RC_BNK
                        WHERE SWIFT_CODE LIKE swift_k_||'%'
                          AND ROWNUM = 1;
                     EXCEPTION WHEN NO_DATA_FOUND THEN
                        swift_k_ := substr(swift_k_,1,4)||' '||substr(swift_k_,5,2)||
                                    ' '||substr(swift_k_,7,2);
                        BEGIN
                           SELECT b010
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
                        SELECT substr(trim(value), 1, 12)
                           INTO swift_k_
                        FROM OPERW
                        WHERE REF = REF_
                          AND TAG = '57'
                          AND length(trim(value)) > 3
                          AND ROWNUM = 1;

                        BEGIN
                           SELECT b010
                              INTO p_value_
                           FROM RC_BNK
                           WHERE SWIFT_CODE LIKE swift_k_||'%'
                             AND ROWNUM = 1;
                        EXCEPTION WHEN NO_DATA_FOUND THEN
                           swift_k_ := substr(swift_k_,1,4)||' '||substr(swift_k_,5,2)||
                                       ' '||substr(swift_k_,7,2);
                           BEGIN
                              SELECT b010
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
                           SELECT substr(trim(value), 1, 12)
                              INTO swift_k_
                           FROM OPERW
                           WHERE REF = REF_
                             AND TAG = 'NOS_B'
                             AND ROWNUM = 1;

                           swift_k_ := substr(swift_k_,1,4)||' '||substr(swift_k_,5,2)||
                                       ' '||substr(swift_k_,7,2);
                           BEGIN
                              SELECT b010
                                 INTO p_value_
                              FROM RC_BNK
                              WHERE SWIFT_CODE LIKE swift_k_||'%'
                                AND ROWNUM = 1;
                           EXCEPTION WHEN NO_DATA_FOUND THEN
                              null;
                           END;
                        EXCEPTION WHEN NO_DATA_FOUND THEN
                           null;
                        END;
                     END;
                  END;
               END;
            END;

            p_value_ := NVL (SUBSTR (TRIM (p_value_), 1, 10), 'код банку');
         end if;

         IF trim(p_value_) != 'код банку'
         THEN
            b010_:= SUBSTR (TRIM (p_value_), 1, 10);
         ELSE
            p_value_ := country_||'0000000';
         END IF;
      ELSE
         p_kodp_ := 'NN';
      END IF;

   END;
-----------------------------------------------------------------------------
BEGIN
   commit;

   EXECUTE IMMEDIATE 'ALTER SESSION ENABLE PARALLEL DML';
-------------------------------------------------------------------
   logger.info ('P_F2D_NN: Begin for datf = '||to_char(dat_, 'dd/mm/yyyy'));

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
   -- параметры формирования файла
   p_proc_set (kodf_, sheme_, nbuc1_, typ_);

   --- выбор курса долара для пересчета суммы
   kurs_ := f_ret_kurs (840, dat_);
   ourOKPO_ := lpad(F_Get_Params('OKPO',null), 8, '0');

   begin
     select decode(glb, 0, '0', lpad(to_char(glb), 3, '0'))
        into ourGLB_
     from rcukru
     where mfo = mfo_
       and rownum = 1;
   exception
     when no_data_found then
         ourGLB_ := null;
   END;

   sum_kom := gl.p_icurval(840, 100000, dat_);  -- сума комiсiї
    
   kol_ref_ := 0;
   
   IF mfou_=300465 and mfo_ != mfou_ and Dat_ > to_date('28072009','ddmmyyyy')
   THEN
      select count(*)
         INTO kol_ref_
      from arc_rrp
      where dat_a >= Dat_
        and dk = 3
        and nlsb like '2909%'
        and nazn like '#E2;%'
        and trim(d_rec) is not null
        and d_rec like '%D' || to_char(Dat_, 'yymmdd') || '%';
   END IF;

   if ( (mfou_ = 300465 and mfou_ = mfo_) OR mfou_ <> 300465 ) and kol_ref_ = 0 
   then
        -- отбор проводок, удовлетворяющих условию
        -- надходження вiд нерезидентiв
        INSERT INTO OTCN_PROV_TEMP
               (ko, rnk, REF, tt, accd, nlsd, kv, acck, nlsk, nazn,
                s_nom, s_eqv)
        SELECT *
        FROM (
              SELECT   '3' ko, ca.rnk, o.REF, tt, o.accd, o.nlsd, o.kv, o.acck,
                       o.nlsk, o.nazn,
                       o.s * 100 s_nom,
                       gl.p_icurval (o.kv, o.s * 100, dat_) s_eqv
                  FROM provodki o, cust_acc ca
                 WHERE o.fdat = dat_
                   AND o.kv not in (959,961,962,964,980)
        AND (
                       (SUBSTR (o.nlsd, 1, 4) in ('2600', '2620', '2650') and
                        SUBSTR (o.nlsk, 1, 4) in ('1919','2909','3739') and
                        mfo_ in (333368, 380764, 315784) ) -- BAP
                   OR  (SUBSTR (o.nlsd, 1, 4) in ('2909') and
                        SUBSTR (o.nlsk, 1, 4) in ('1919','3739') and
                        mfo_ in (333368) )
                   OR  (SUBSTR (o.nlsd, 1, 4) IN
                                                ('1502',
                                                 '1511',
                                                 '1512',
                                                 '1515',
                                                 '1516',
                                                 '1522',
                                                 '1523',
                                                 '1524',
                                                 '1525',
                                                 '1600',
                                                 '1602',
                                                 '1623',
                                                 '1624',
                                                 '1811',
                                                 '1819',
                                                 '1911',
                                                 '1919',
                                                 '2600',
                                                 '2602',
                                                 '2620',
                                                 '2625',
                                                 '2650',
                                                 '2901',
                                                 '2909',
                                                 '3510',
                                                 '3519',
                                                 '3660',  -- добавил 06.02.09
                                                 '3661',  -- 3660,3661,3668
                                                 '3668' )
        -- исключил 18.08.2008                             '3720',
        --                                                 '3739'  )
                          AND SUBSTR(o.nlsk,1,4) in ('1500', '3900')
                          AND SUBSTR (LOWER (TRIM (o.nazn)), 1, 4) != 'конв')
                   OR (o.nlsd LIKE '1919%'     and
                       o.nlsk LIKE '1500%'     and
                       mfo_ in (300465) and
                       SUBSTR (LOWER (TRIM (o.nazn)), 1, 4) = 'конв')
                   OR (o.nlsd LIKE '191992%'     and
                       (o.nlsk LIKE '1500%' or o.nlsk like '1600%') and
                       mfo_ in (300465) )
                   OR (o.nlsd in ('37394501547') and  --,'37396506')
                       o.nlsk LIKE '1500%' and
                       mfo_ in (300465) )
                   OR (o.nlsd LIKE '15_8%'     and
                       (o.nlsk LIKE '1500%' or o.nlsk like '1600%') and
                       mfo_ in (300465) )
                   OR ((o.nlsd LIKE '292490204%' or o.nlsd LIKE '292460205%') and  -- 03/01/2013
                        o.nlsk LIKE '1500%'  and
                       mfo_ in (300465) )
                   OR ((o.nlsd LIKE '292430003718%' or o.nlsd LIKE '292460003717%') and  -- 22/07/2013
                        o.nlsk LIKE '1500%'  and
                       mfo_ in (300465) )    
                   OR ( o.nlsd like '3800%'   -- 29/07/2012
                        AND SUBSTR (o.nlsk, 1, 4) in ('1500','1600')
                        AND mfo_ in (300465)
                        AND ref in (select ref 
                                    from oper 
                                    where ( ((nlsa like '70%' or nlsa like '71%') and 
                                             (nlsb like '1500%' or nlsb like '1600%')) or
                                            ((nlsa like '1500%' or nlsa like '1600%') and 
                                            (nlsb like '70%' or nlsb like '71%')) )
                                   )
                        AND gl.p_icurval(o.kv, o.s*100, dat_) > sum_kom ))
                   AND o.accd = ca.acc);

        -- удаляем проводки пополнения коррсчета (в OPER Дт 1500 Кт 1500)
        delete from otcn_prov_temp
        where ref in (select a.ref
                 from oper a
                 where a.ref in (select b.ref from otcn_prov_temp b)
                   and a.nlsa like '1500%' and a.nlsb like '1500%')
          AND SUBSTR (LOWER (TRIM (nazn)), 1, 4) != 'конв';

        -- удаляем проводки пополнения коррсчета с ЛОРО счета(Дт 1600 Кт 1500)
        delete from otcn_prov_temp
        where ref in (select a.ref
                 from oper a
                 where a.ref in (select b.ref from otcn_prov_temp b)
                   and a.nlsa like '1600%' and a.nlsb like '1500%');

        -- для MFO=300465 удаляем проводки у которых MFOA<>MFOB проводки областей
        IF mfo_ = 300465 THEN
            delete from otcn_prov_temp
            where ref in (select a.ref
                        from oper a
                        where a.ref in (select b.ref from otcn_prov_temp b)
                          and a.mfoa != a.mfob);
        END IF;

        -- удаляем проводки Дт 1600 Кт 1500
        if mfo_ = 300465 then
            delete from otcn_prov_temp
            where nlsd like '1600%'
            and nlsk like '1500%';
        end if;

        -- удаляем проводки комиссии (Дт 7100 Кт 1500)
        delete from otcn_prov_temp
        where ref in (select a.ref
                      from oper a
                      where a.ref in (select b.ref from otcn_prov_temp b)
                        and a.nlsa like '1500%' and a.nlsb like '7100%' and a.dk=0)
                        and round(s_eqv / kurs_, 0) < 100000 ;
   else
     -- отбор проводок, удовлетворяющих условию
     -- надходження вiд нерезидентiв
     INSERT INTO OTCN_PROV_TEMP
           (ko, rnk, REF, tt, accd, nlsd, kv, acck, nlsk, nazn,
            s_nom, s_eqv)
        SELECT *
        FROM (
            SELECT /*+NO_MERGE(v) PUSH_PRED(v) */
                  '3' ko, ca.rnk, o.REF, tt, o.accd, o.nlsd, o.kv, o.acck,
                     o.nlsk, o.nazn,
                     o.s * 100 s_nom,
                     gl.p_icurval (o.kv, o.s * 100, dat_) s_eqv
            FROM provodki o, cust_acc ca,
               ( select substr(d_rec, 6+instr(d_rec, '#CREF:'),
                                           instr(substr(d_rec, 6+instr(d_rec, '#CREF:')), '#')-1) ref
                             from arc_rrp
                             where dat_a >= Dat_
                               and dk = 3
                               and nlsb like '2909%'
                               and nazn like '#E2;%'
                               and trim(d_rec) is not null
                               and d_rec like '%D' || to_char(Dat_, 'yymmdd')|| '%') v 
            WHERE o.kv != 980
              and o.fdat between Dat_ - 10 and dat_
              and o.ref = v.ref
              and o.accd = ca.acc);
   end if;

   OPEN c_main;

   LOOP
      FETCH c_main
       INTO ko_, kod_obl_, rnk_, okpo1_, nmk_, k040_, adr_, k110_, codc_, sum1_, sumk1_;

      EXIT WHEN c_main%NOTFOUND;
      rez_ := MOD (codc_, 2);

      -- 16.06.2009 изменил на следующее
      if length(trim(okpo1_)) <= 8 then
         okpo1_:=lpad(trim(okpo1_),8,'0');
      else
         okpo1_:=lpad(trim(okpo1_),10,'0');
      end if;

      -- для банков по коду ОКПО из RCUKRU(IKOD)
      -- определяем код банка поле GLB
      if codc_ in (1,2) then
         BEGIN
            select glb into okpo1_
            from rcukru
            where trim(ikod)=trim(okpo1_)
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
         okpo_ := trim(ser_) || ' ' || trim(numdoc_);               
         EXCEPTION WHEN NO_DATA_FOUND THEN 
            null;
         END;
      end if;

         ---переказ безготiвковоi валюти
         OPEN opl_dok;

         LOOP
            FETCH opl_dok
             INTO ko_1, ref_, tt_, acc_, nls_, kv_, acck_, nlsk_,
                  nazn_, sum0_, sumk0_;

            EXIT WHEN opl_dok%NOTFOUND;

            okpo_ := okpo1_;
            ttd_ := null;
            nlsdd_ := null;
            d1#E2_ := null;
            d2#E2_ := null;
            d3#E2_ := null;
            d4#E2_ := null;
            d6#E2_ := null;
            d7#E2_ := null;
            d8#E2_ := null;
            db#E2_ := null;
            dc#E2_ := null;
            dc1#E2_ := '';
            d61#e2_ := null;
            de#E2_ := null;
            kol_61 := 0;

            mbkOK_ := false;
            kod_b_ := null;

            IF ko_ = '3' AND ROUND (sumk0_ / kurs_, 0) > gr_sum_
            THEN

               formOk_ := true;

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

                  refd_ :=ref_;

                  -- OAB добавил 18.08.08 по просьбе банка Петрокоммерц
                  -- определяем код страны для перечисления валюты
                  -- 25.07.2009 для всех банков определяем код страны
                  -- с 01.08.2012 добавляется код страны отправителя или получателя перевода
                  BEGIN
                    SELECT SUBSTR (VALUE, 2, 3)
                       INTO d6#E2_
                    FROM operw
                    WHERE REF = ref_
                      and tag like 'n%'
                      and substr(trim(value),1,1) in ('O','P','О','П');
                  EXCEPTION WHEN NO_DATA_FOUND THEN
                     BEGIN
                       SELECT SUBSTR (VALUE, 1, 3)
                          INTO d6#E2_
                       FROM operw
                       WHERE REF = ref_
                         and tag like 'n%'
                         and substr(trim(value),1,1) not in ('O','P','О','П');
                     EXCEPTION WHEN NO_DATA_FOUND THEN
                        BEGIN
                          SELECT SUBSTR (VALUE, 1, 70)
                             INTO d6#E2_
                          FROM operw
                          WHERE REF = ref_
                            AND tag = 'D6#70';
                        EXCEPTION WHEN NO_DATA_FOUND THEN
                           BEGIN
                             SELECT SUBSTR (VALUE, 1, 70)
                                INTO d6#E2_
                             FROM operw
                             WHERE REF = ref_
                               AND tag = 'D6#E2';
                           EXCEPTION WHEN NO_DATA_FOUND THEN
                              d6#E2_ := NULL;
                           END;
                        END;
                     END;
                  END;

                  BEGIN
                     SELECT substr(value,1,3)
                        INTO kod_g_
                     FROM OPERW
                     WHERE REF = ref_ AND tag = 'KOD_G';

                     If ascii(substr(kod_g_,1,1))<48 OR ascii(substr(kod_g_,1,1))>57 THEn
                        begin
                           SELECT nvl(kodc,'000') into kod_g_
                           from bopcount
                           where trim(iso_countr)=trim(kod_g_);
                        EXCEPTION WHEN NO_DATA_FOUND THEN
                           kod_g_:='000';
                        end;
                     end if;
                  EXCEPTION WHEN NO_DATA_FOUND THEN
                     BEGIN
                        SELECT '804'
                           INTO kod_g_
                        FROM OPERW
                        WHERE REF = ref_ 
                          AND tag like '59%'
                          AND substr(trim(value),1,3)='/UA';
                     EXCEPTION WHEN NO_DATA_FOUND THEN
                         BEGIN
                            SELECT '804'
                               INTO kod_g_
                            FROM OPERW
                            WHERE REF = ref_ 
                              AND tag like '59%'
                              AND instr(UPPER(trim(value)),'UKRAINE') > 0;
                         EXCEPTION WHEN NO_DATA_FOUND THEN
                            kod_g_ := NULL;
                         END;
                     END;
                  END;

                  if d6#E2_ is null and trim(kod_g_) is not null then
                     d6#E2_ := kod_g_;
                  end if;

                  if d6#E2_ is null or d6#E2_ not in ('804','UKR') then

                     begin
                        select p.pid, min(p.id), max(p.id)
                           into pid_, id_min_, id_
                        from contract_p p
                        where p.ref=ref_
                        group by p.pid;

                        select 20+t.id_oper, t.name, to_char(t.dateopen, 'ddmmyyyy'),
                               t.bankcountry, t.bank_code, t.benefbank, trim(t.aim)
                           into D1#E2_, D2#E2_, D3#E2_,
                                D6#E2_, D7#E2_, D8#E2_, DB#E2_
                        from top_contracts t
                        where t.pid=pid_ ;  -- and p.kv=t.kv ;

                        if length(trim(D7#E2_))=3 then
                           D7#E2_ := D7#E2_ ||'0000000';
                        end if;
                     exception
                               when no_data_found then
                        null;
                               when too_many_rows then
                        null; -- если платеж по нескольким контрактам, то пусть разбивают сумму и вводят реквизиты сами
                     end;

                     if nls_ like '1919%' or nls_ like '3739%' then
                        -- если это подбор корсчета
                        if tt_ = 'NOS' then
                           -- то ищем сязанную операцию, которая предшествовала NOS
                           refd_ := to_number(trim(f_dop(ref_, 'NOS_R')));

                           if refd_ is null then
                              begin
                                 select ref
                                    into refd_
                                 from oper
                                 where vdat between to_date(dat_)-7 and dat_
                                   and nlsb=nls_
                                   and kv=kv_
                                   and refl in (ref_);
                              exception
                                        when no_data_found then
                                 refd_ := null;
                              end;
                           end if;

                           -- если нашли предшествующую операцию, то выбираем рекизиты счетов
                           if refd_ is null then
                              begin
                                 select p.ref, p.tt, p.NLSD, p.accd
                                    into refd_, ttd_, nlsdd_, accdd_
                                 from provodki p
                                 where p.ref=ref_ and
                                       p.acck=acc_;
                              exception
                                        when no_data_found then
                                 refd_ := null;
                              end;
                           end if;

                           -- если нашли предшествующую операцию, то выбираем рекизиты клиентов
                           if refd_ is not null and refd_ != ref_ then
                              begin
                                 select c.rnk, trim(c.okpo), c.nmk, TO_CHAR (c.country), c.adr,
                                        NVL (c.ved, '00000'), c.codcagent, p.tt, p.NLSD, p.accd
                                    into rnk_, okpo_, nmk_, k040_, adr_, k110_, codc_, ttd_, nlsdd_, accdd_
                                 from provodki p, cust_acc ca, customer c
                                 where p.ref=refd_
                                   and p.acck=acc_
                                   and p.accd=ca.acc  --изменил на условие строкой выше 14.03.2008
                                   and ca.rnk=c.rnk;

                                 -- для банков по коду ОКПО из RCUKRU(IKOD)
                                 -- определяем код банка поле GLB
                                 if codc_ in (1, 2) then
                                    okpo_ := ourGLB_;
                                 end if;

                                 IF typ_ > 0
                                 THEN
                                    nbuc_ := NVL (f_codobl_tobo (accdd_, typ_), nbuc1_);
                                 ELSE
                                    nbuc_ := nbuc1_;
                                 END IF;

                              exception
                                        when no_data_found then
                                 null;
                              end;
                           end if;

                           if refd_ is not null then
                              -- если предшествующая операция - ФОРЕКС
                              if nvl(ttd_, '***') like 'FX%' then
                                 -- то инициатор проводки - сам банк, поэтому берем его код из RCUKRU
                                 okpo_ := ourGLB_;
                                 codc_ := 1;

                                 BEGIN
                                    -- берем рекизиты из модуля ФОРЕКС
                                    select decode(kva, 980, '30', '28'), ntik, to_char(dat, 'ddmmyyyy')
                                       into D1#E2_, D2#E2_, D3#E2_
                                    from fx_deal
                                    where refb=refd_;
                                 EXCEPTION WHEN NO_DATA_FOUND THEN
                                    null;
                                 END;
                                 if D1#E2_ = '30' then
                                    formOk_ := false;
                                 end if;
                              else
                                 -- если не ФОРЕКС, то возможно "поможет" модуль "Экпортно-Импортные контракты"
                                 begin
                                    select p.pid, min(p.id), max(p.id)
                                       into pid_, id_min_, id_
                                    from contract_p p
                                    where p.ref=refd_
                                    group by p.pid;

                                    select 20+t.id_oper, t.name, to_char(t.dateopen, 'ddmmyyyy'),
                                           t.bankcountry, t.bank_code, t.benefbank, trim(t.aim)
                                       into D1#E2_, D2#E2_, D3#E2_,
                                            D6#E2_, D7#E2_, D8#E2_, DB#E2_
                                    from top_contracts t
                                    where t.pid=pid_ ; -- and p.kv=t.kv - Инна сказала, что это условие лишнее (платеж м.б. в другой валюте)

                                    if length(trim(D7#E2_))=3 then
                                       D7#E2_ := D7#E2_ ||'0000000';
                                    end if;
                                 exception
                                           when no_data_found then
                                    null;
                                           when too_many_rows then
                                    null; -- если платеж по нескольким контрактам, то пусть разбивают сумму и вводят реквизиты сами
                                 end;
                              end if;
                           else
                              refd_:=ref_;
                           end if;
                        else
                           refd_:=ref_;
                        end if;
                     end if;

                     -- по межбанку нужно проверять срок кредита
                     if substr(nls_, 1, 3) in ('151', '152', '161', '162') or
                        substr(nlsdd_, 1, 3) in ('151', '152', '161', '162') then
                        if nlsdd_ is not null then
                           s180_ := fs180(accdd_, '1', dat_);
                        else
                           s180_ := fs180(acc_, '1', dat_);
                        end if;

                        -- если срок кредита меньше месяца, то не берем его
                        if s180_ in ('1', '2', '3', '4', '5') then
                           formOk_ := false;
                        else
                           mbkOK_ := true;
                        end if;
                     end if;

                     BEGIN
                         SELECT SUBSTR (trim(VALUE), 1, 2)
                            INTO d1#E2_
                         FROM operw
                         WHERE REF = refd_ AND tag = 'D1#2D';
                     EXCEPTION WHEN NO_DATA_FOUND THEN
                         d1#E2_ := null;
                     END;

                     if d1#E2_ in ('01','02','03','04','05','06','07','08') and formOk_ 
                     then
                        nnnn_ := nnnn_ + 1;
                        -- код валюти
                        p_ins (nnnn_, '10', LPAD (kv_, 3, '0'));

                        -- сума в единицах валюты (код 12)
                        p_ins (nnnn_, '20', TO_CHAR (sum0_));

                        if okpo_ = ourOKPO_ then
                           okpo_ := ourGLB_;
                           codc_ := 1 ;
                        end if;

                        p_ins (nnnn_, '31', TRIM (okpo_));

                        if okpo_='0' then
                           -- код резидентностi
                           p_ins (nnnn_, '62', '0');
                        else
                           -- код резидентностi
                           p_ins (nnnn_, '62', TO_CHAR(2 - mod(codc_,2)));
                        end if;

                        p_ins (nnnn_, '67', nmk_);

                        -- додатковi параметри
                        n_ := 10;

                        FOR i IN 1 .. n_
                        LOOP
                           IF i < 10
                           THEN
                              tag_ := 'D' || TO_CHAR (i) || '#70';
                           ELSIF i=10
                           THEN
                              tag_ := 'DA#70';
                           ELSIF i = 11
                           THEN
                              tag_ := 'DB#70';
                           ELSIF i=12
                           THEN
                              tag_ := 'DC#70';
                           ELSIF i=13
                           THEN
                              tag_ := 'DA#E2';  --'DD#70';
                           ELSE
                              tag_ := 'DE#E2';
                           END IF;

                           IF i = 1 THEN
                              tag_ := 'D1#2D';
                           END IF;

                        -- были доп.реквизиты (D1#E2 - DA#E2)
                        -- изменил 27.08.2007 доп.реквизиты (D1#E2, D2#70 - DC#70)
                        -- изменил 20.11.2007 добавлен доп.реквизит 13 - DD#70
                        -- (вiдомостi про операцiю)
                           IF ko_ = 3 AND i IN (1, 6, 9)
                           THEN
                              BEGIN
                                 SELECT trim(SUBSTR (VALUE, 1, 70))
                                    INTO val_
                                 FROM operw
                                 WHERE REF = refd_ AND tag = tag_;
                              EXCEPTION
                                        WHEN NO_DATA_FOUND
                              THEN
                                 if i=9 then
                                    tag_ := 'D7#E2';
                                 elsif i=10 then
                                    tag_ := 'D8#E2';
                                 elsif i=13 then
                                    tag_ := 'DD#70';
                                 else
                                    tag_ := substr(tag_,1,3)||'E2';
                                 end if;

                                 BEGIN
                                    SELECT trim(SUBSTR (VALUE, 1, 70))
                                       INTO val_
                                    FROM operw
                                    WHERE REF = refd_ AND tag = tag_ ;
                                 EXCEPTION
                                           WHEN NO_DATA_FOUND
                                 THEN
                                       val_ := NULL;
                                 END;
                              END;

                              if i=6 and val_ is null and D6#E2_ is null then
                                 begin
                                    select value
                                       into D6#E2_
                                    from operw
                                    where ref=refd_
                                      and tag='KOD_G';
                                 exception
                                           when no_data_found then
                                    D6#E2_ := null;
                                 end;
                              end if;

                              if i = 9 and val_ is null and D7#E2_ is null then
                                 begin
                                    select trim(value)
                                       into kod_b_
                                    from operw
                                    where ref=refd_
                                      and tag='KOD_B';
                                 exception
                                           when no_data_found then
                                    kod_b_ := null;
                                 end;

                                 if kod_b_ is not null then
                                    begin
                                       select distinct r.glb
                                          into D7#E2_
                                       from rcukru r
                                       where r.mfo in (select distinct f.mfo
                                                       from forex_alien f
                                                       where trim(f.kod_b)=kod_b_
                                                         and rownum=1);
                                    exception
                                              when no_data_found then
                                       D7#E2_ := null;
                                    end;
                                 end if;
                              end if;

                              -- код показника та default-значення
                              p_tag (i, val_, kodp_, ref_);
                              -- запис показника
                              p_ins (nnnn_, kodp_, val_);
                           END IF;
                        END LOOP;
                     END IF;
                  end if;
               end if;
            END IF;
         END LOOP;

         CLOSE opl_dok;
   END LOOP;

   CLOSE c_main;

---------------------------------------------------
   DELETE FROM tmp_nbu
         WHERE kodf = kodf_ AND datf = dat_;

---------------------------------------------------
   INSERT INTO tmp_nbu (kodp, datf, kodf, znap, nbuc)
      SELECT kodp, dat_, kodf_, znap, nbuc
        FROM rnbu_trace;
----------------------------------------
DELETE FROM OTCN_TRACE_70
         WHERE kodf = kodf_ and datf= dat_ ;

insert into OTCN_TRACE_70(KODF, DATF, USERID, NLS, KV, ODATE, KODP, ZNAP, NBUC, ISP, RNK, ACC, REF, COMM, ND, MDATE, TOBO)
select kodf_, dat_, USERID_, NLS, KV, ODATE, KODP, ZNAP, NBUC, ISP, RNK, ACC, REF, COMM, ND, MDATE, TOBO
from rnbu_trace;

logger.info ('P_F2D_NN: End for datf = '||to_char(dat_, 'dd/mm/yyyy'));

END p_f2d_nn;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F2D_NN.sql =========*** End *** 
PROMPT ===================================================================================== 
