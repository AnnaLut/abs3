

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_FE1_NN.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_FE1_NN ***

  CREATE OR REPLACE PROCEDURE BARS.P_FE1_NN ( dat_     DATE,
                                       sheme_   VARCHAR2 DEFAULT 'G') IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :   Процедура формирования #E1 для КБ
% COPYRIGHT   :   Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     :   30.09.2008 (17.09.2008, 05.09.2007)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
параметры: Dat_ - отчетная дата
      sheme_ - схема формирования
30.09.2008 - добавлены 3 новых кода 41, 42, 61 которые будут формироваться
             с 30.09.2008
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
   kodf_      VARCHAR2 (2)   := 'E1';
   sql_z      VARCHAR2 (200);
   typ_       NUMBER;
   flag_      NUMBER;
   n_         NUMBER         := 6; -- кол-во доп.параметров
   acc_       NUMBER;
   accd_      NUMBER;
   acck_      Number;
   kv_        NUMBER;
   kv1_       NUMBER;
   nls_       VARCHAR2 (15);
   nlsk_      VARCHAR2 (15);
   nlsk1_     VARCHAR2 (15);
   nbuc1_     VARCHAR2 (12);
   nbuc_      VARCHAR2 (12);
   rnk_       NUMBER;
   okpo_      VARCHAR2 (14);
   okpo_k     VARCHAR2 (14);
   nmk_       VARCHAR2 (70);
   adr_       VARCHAR2 (70);
   k040_      VARCHAR2 (3);
   val_       VARCHAR2 (70);
   dat1_      DATE;
   dat2_      Date;
   dat3_      Date;
   data_      DATE;
   dig_       NUMBER;
   bsum_      NUMBER;
   bsu_       NUMBER;
   sn_        DECIMAL (24);
   sum1_      DECIMAL (24);
   sum0_      DECIMAL (24);
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

--- операцii нерезидентiв з ЦП на територii Украiни
   CURSOR opl_dok
   IS
      SELECT  ref, accd, nlsd, kv, fdat, sum(s*100), acck, nlsk
      FROM otcn_f84_temp
      WHERE trim(ddd) = '01'
      GROUP BY ref, accd, nlsd, kv, fdat, acck, nlsk;

-------------------------------------------------------------------
   PROCEDURE p_ins (p_np_ IN NUMBER, p_kodp_ IN VARCHAR2, p_znap_ IN VARCHAR2)
   IS
      l_kodp_   VARCHAR2 (10);
   BEGIN
      l_kodp_ := p_kodp_ || LPAD (TO_CHAR (p_np_), 3, '0');

      INSERT INTO rnbu_trace
                  (nls, kv, odate, kodp, znap, nbuc
                  )
           VALUES (nls_, kv_, dat_, l_kodp_, p_znap_, nbuc_
                  );
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
         p_kodp_ := '01';
         p_value_ := NVL (SUBSTR (TRIM (p_value_), 1, 1), '0');
      ELSIF p_i_ = 2
      THEN
         p_kodp_ := '11';
         p_value_ := NVL (SUBSTR (TRIM (p_value_), 1, 70), 'код валюти у якiй емiт. ЦП');
      ELSIF p_i_ = 3
      THEN
         p_kodp_ := '21';
         p_value_ := NVL (SUBSTR (TRIM (p_value_), 1, 70), 'загальна ном. вартiсть');
      ELSIF p_i_ = 4
      THEN
         p_kodp_ := '40';
         p_value_ := NVL (SUBSTR (TRIM (p_value_), 1, 70), 'код виду ЦП');
      ELSIF p_i_ = 5
      THEN
         p_kodp_ := '32';
         p_value_ := NVL (SUBSTR (TRIM (p_value_), 1, 70), 'назва емiтента');
      ELSIF p_i_ = 6
      THEN
         p_kodp_ := '52';

         p_value_ :=
            NVL (SUBSTR (TRIM (p_value_), 1, 70), 'дата погашення ЦП' );
      ELSE
         p_kodp_ := 'NN';
      END IF;
      if dat_ >= to_date('01092008','ddmmyyyy') then

         IF p_i_ = 7
         THEN
            p_kodp_ := '41';

            p_value_ :=
               NVL (SUBSTR (TRIM (p_value_), 1, 70), 'код джерела iнформацiї' );
         ELSIF p_i_ = 8
         THEN
            p_kodp_ := '42';

            p_value_ :=
               NVL (SUBSTR (TRIM (p_value_), 1, 70), 'код стану розрахункiв' );
         ELSIF p_i_ = 9
         THEN
            p_kodp_ := '61';

            p_value_ :=
                NVL (SUBSTR (TRIM (p_value_), 1, 70), 'примiтки' );
         ELSE
            null ;  --p_kodp_ := 'NN';
         END IF;
      end if;
   END;
-----------------------------------------------------------------------------
BEGIN
   EXECUTE IMMEDIATE 'ALTER SESSION SET NLS_NUMERIC_CHARACTERS=''.,''';
-------------------------------------------------------------------
   SELECT ID
     INTO userid_
     FROM staff
    WHERE UPPER (logname) = UPPER (USER);

   DELETE FROM rnbu_trace
         WHERE userid = userid_;

EXECUTE IMMEDIATE 'alter session set NLS_NUMERIC_CHARACTERS=''.,''';

--Dat1_:= TRUNC(Dat_ - TO_NUMBER(TO_CHAR(Dat_,'DD')));
Dat1_ := TRUNC(Dat_,'MM'); -- початок попереднього м_сяця
Dat2_ := TRUNC(Dat_ + 28);

SELECT max(fdat) INTO Dat3_ FROM fdat WHERE fdat<Dat1_ ;

-- видалення записiв з тимчасовоi таблицi
DELETE FROM OTCN_F84_TEMP;
-- наповнення тимчасовоi таблицi
insert into OTCN_F84_TEMP(ref, accd, nlsd, kv, fdat, s, acck, nlsk, ddd, nazn)
select *
from (
   SELECT ref, accd, nlsd, kv, fdat, s*100, acck, nlsk, '01', nazn
   FROM  provodki
   WHERE substr(nlsd,1,4) in ('2801','2901','3541','3641') and
--         substr(nlsk,1,4) not in (select r020 from kl_f3_29 where kf='84') and
--         substr(nlsk,1,1)<>'6' and
         fdat between Dat1_ and Dat_         and
         tt not in (select a.tt from tts a
                      where a.tt in (select tt from tts_vob where vob=96))
UNION
   SELECT ref, accd, nlsd, kv, fdat, s*100, acck, nlsk, '01', nazn
   FROM  provodki
   WHERE --substr(nlsd,1,4) not in (select r020 from kl_f3_29 where kf='84') and
         --substr(nlsd,1,1)<>'6' and
         substr(nlsk,1,4) in ('2801','2901','3541','3641') and
         fdat between Dat1_ and Dat_         and
         tt not in (select a.tt from tts a
                      where a.tt in (select tt from tts_vob where vob=96))
UNION
   SELECT ref, accd, nlsd, kv, fdat, s*100, acck, nlsk, '01', nazn
   FROM  provodki
   WHERE substr(nlsd,1,4) in ('2801','2901','3541','3641') and
--         substr(nlsk,1,4) not in (select r020 from kl_f3_29 where kf='84') and
--         substr(nlsk,1,1)<>'6' and
         fdat between Dat_ and Dat2_         and
         tt in (select a.tt from tts a
                  where a.tt in (select tt from tts_vob where vob=96))
UNION
   SELECT ref, accd, nlsd, kv, fdat, s*100, acck, nlsk, '01', nazn
   FROM  provodki
   WHERE --substr(nlsd,1,4) not in (select r020 from kl_f3_29 where kf='84') and
         --substr(nlsd,1,1)<>'6' and
         substr(nlsk,1,4) in ('2801','2901','3541','3641') and
         fdat between Dat_ and Dat2_         and
         tt in (select a.tt from tts a
                  where a.tt in (select tt from tts_vob where vob=96)) ) ;

delete from otcn_f84_temp
where substr(nlsd,1,4) in ('2801','2901','3541','3641') and
      substr(nlsk,1,4) in (select r020 from kl_f3_29 where kf='84');

delete from otcn_f84_temp
where substr(nlsd,1,4) in (select r020 from kl_f3_29 where kf='84') and
      substr(nlsk,1,4) in ('2801','2901','3541','3641');

delete from otcn_f84_temp
where substr(nlsd,1,4) in ('2801','2901','3541','3641') and
      substr(nlsk,1,1)='6';

delete from otcn_f84_temp
where substr(nlsd,1,1)='6' and
      substr(nlsk,1,4) in ('2801','2901','3541','3641');
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
   nbuc_ := nbuc1_;

-- добавление нулей для кода ОКПО
--      if codc_ in (5,6) then
--         okpo_:=lpad(trim(okpo_),10,'0');
--      else
--         okpo_:=lpad(trim(okpo_),8,'0');
--      end if;

         ---данi про операцii нерезидентiв з ЦП на територii Украiни
         OPEN opl_dok;

         LOOP
            FETCH opl_dok
             INTO ref_, accd_, nls_, kv_, data_, sn_, acck_, nlsk_ ;

            EXIT WHEN opl_dok%NOTFOUND;

               okpo_ := '9999999999';
               dig_ := f_ret_dig (kv_) * 100;
                                       -- сумма должна быть в единицах валюты

               if substr(nls_,1,4) in ('2801','2901','3541','3641') then
                  acc_ := acck_;
               else
                  acc_ := accd_;
               end if;

               select trim(c.okpo), mod(c.codcagent,2)
                  into okpo_, rez_
               from customer c, cust_acc ca
               where ca.acc=acc_ and
                     c.rnk=ca.rnk ;

               okpo_k := NULL;

               if substr(nls_,1,4) in ('2801','2901','3541','3641') and
                  substr(nlsk_,1,4)='3929' then
                  select id_b
                     into okpo_k
                  from oper
                  where ref=ref_;
                  if trim(okpo_k) is NULL or
                     trim(okpo_k) in ('00000','000000000','0000000000',
                                      '99999','999999999','9999999999') then
                     rez_ := 0;
                  end if;
               end if;

               if substr(nls_,1,4)='3929' and
                  substr(nlsk_,1,4) in ('2801','2901','3541','3641') then
                  select id_a
                     into okpo_k
                  from oper
                  where ref=ref_;
                  if trim(okpo_k) is NULL or
                     trim(okpo_k) in ('00000','000000000','0000000000',
                                   '99999','999999999','9999999999') then
                     rez_ := 0;
                  end if;
               end if;

-- с 29.08.2008 стал консолидированным вместо территориального
--               IF sheme_ = 'G' AND typ_ > 0
--               THEN
--                  nbuc_ := NVL (f_codobl_tobo (acc_, typ_), nbuc1_);
--               ELSE
--                  nbuc_ := nbuc1_;
--               END IF;

-- условия отбора
               IF ((substr(nls_,1,4) in ('2801','2901','3541','3641') and
                    (substr(nlsk_,1,2) in ('20','21','22','25','26') OR
                     substr(nlsk_,1,4) in ('1500','2902','3929'))
                    and rez_=0) OR
                   ((substr(nls_,1,2) in ('20','21','22','25','26') OR
                    substr(nls_,1,4) in ('1500','2902','3929')) and
                    substr(nlsk_,1,4) in ('2801','2901','3541','3641')
                    and rez_=0) OR
                   (substr(nls_,1,4) in ('2801','2901','3541','3641') and
                    substr(nlsk_,1,2) not in ('20','21','22','25','26') and
                    substr(nlsk_,1,4) not in ('1001','1500','2902','3551','3929') ) OR
                   (substr(nls_,1,2) not in ('20','21','22','25','26') and
                    substr(nls_,1,4) not in ('1001','1500','2902','3551','3929') and
                    substr(nlsk_,1,4) in ('2801','2901','3541','3641') ) )
               THEN

                  nnnn_ := nnnn_ + 1;

                  -- код валюти
                  p_ins (nnnn_, '10', LPAD (kv_, 3, '0'));

                  -- сума в единицах валюты (код 12)
                  p_ins (nnnn_, '20', TO_CHAR (ROUND (sn_ / dig_, 0)));

                  -- ОКПО клiєнта
--                  IF rez_ = 0 -- для нерезидентiв
--                  THEN
--                     okpo_ := '0';
--                  END IF;

                  p_ins (nnnn_, '31', TRIM (okpo_));

                  -- додатковi параметри
                  n_ := 6;
                  if dat_ >=to_date('20082008','ddmmyyyy') then
                     n_ := 9;
                  end if;

                  FOR i IN 1 .. n_
                  LOOP

                     IF i = 1 then
                        tag_ := 'OP524';
                     ELSIF i = 2 then
                       tag_ := 'KV_CP';
                     ELSIF i = 3 then
                        tag_ := 'NV_CP';
                     ELSIF i = 4 then
                        tag_ := 'DF524';
                     ELSIF i = 5 then
                        tag_ := 'EM_CP';
                     ELSE
                        tag_ := 'DP_CP';
                     END IF;

                     if dat_ >=to_date('01092008','ddmmyyyy') then
                        if i=6 then
                           tag_ := 'DP_CP';
                        ELSIF i = 7 then
                           tag_ := 'KODDI';
                        elsif i = 8 then
                           tag_ := 'KODSR';
                        else
                           tag_ := 'PR_E1';
                        end if;
                     end if;

--                     tag_ := 'D' || TO_CHAR (i) || '#E1';
                     -- доп.реквизиты (DF524,OP524,KV_CP,NV_CP,EM_CP,DP_CP)
                     -- доп.реквизиты (D1#E1 - D6#E1)
                     BEGIN
                        SELECT SUBSTR (VALUE, 1, 70)
                           INTO val_
                        FROM operw
                        WHERE REF = ref_ AND
                              tag = tag_;   --in ('DF524','OP524','KV_CP','NV_CP','EM_CP','DP_CP');
                     EXCEPTION
                               WHEN NO_DATA_FOUND THEN
                        val_ := NULL;
                     END;

                     -- код показника та default-значення
                     p_tag (i, val_, kodp_, ref_);
                     -- запис показника
                     p_ins (nnnn_, kodp_, val_);

                  END LOOP;

               END IF;
         END LOOP;

         CLOSE opl_dok;
---------------------------------------------------
   DELETE FROM tmp_nbu
         WHERE kodf = kodf_ AND datf = dat_;

---------------------------------------------------
   INSERT INTO tmp_nbu
         (kodf, datf, kodp, znap, nbuc)
      SELECT kodf_, dat_, kodp, znap, nbuc
        FROM rnbu_trace
       WHERE userid = userid_;
EXCEPTION
   WHEN OTHERS
   THEN
      raise_application_error (-20000, 'Error in p_fe1_nn: ' || SQLERRM);
----------------------------------------
END p_fe1_nn;
 
/
show err;

PROMPT *** Create  grants  P_FE1_NN ***
grant EXECUTE                                                                on P_FE1_NN        to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_FE1_NN.sql =========*** End *** 
PROMPT ===================================================================================== 
