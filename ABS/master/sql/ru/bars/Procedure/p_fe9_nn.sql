

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_FE9_NN.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_FE9_NN ***

  CREATE OR REPLACE PROCEDURE BARS.P_FE9_NN ( dat_     DATE,
                                       sheme_   VARCHAR2 DEFAULT 'D') IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :   Процедура формирования #E9 для КБ
% COPYRIGHT   :   Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     :   17.03.2009 (08.04.2008,31.03.2008)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
параметры: Dat_ - отчетная дата
           sheme_ - схема формирования
17.03.2009 - добавил для наполнения TMP_NBU перечень полей
02.04.2008 - в протокол формирования табл. RNBU_TRACE добавлено заполнение
             поля ISP - номер исполнителя
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
   kodf_      VARCHAR2 (2)   := 'E9';
   sql_z      VARCHAR2 (200);
   typ_       NUMBER;
   flag_      NUMBER;
   ko_        VARCHAR2 (2);      -- ознака операцii з безготiвковою iнвалютою
   ko_1       VARCHAR2 (2);      -- ознака операцii з безготiвковою iнвалютою
   kod_b_     VARCHAR2 (10);                          -- код банку
   nam_b      VARCHAR2 (70);                        -- назва банку
   n_         NUMBER         := 4;
   acc_       NUMBER;
   acc1_      NUMBER;
   acck_      NUMBER;
   kv_        NUMBER;
   kv1_       NUMBER;
   nls_       VARCHAR2 (15);
   nls1_      VARCHAR2 (15);
   nlsk_      VARCHAR2 (15);
   nlsk1_     VARCHAR2 (15);
   isp_       NUMBER;
   nbuc1_     VARCHAR2 (12);
   nbuc_      VARCHAR2 (12);
   country_   VARCHAR2 (3);
   d060_      NUMBER;
   rnk_       NUMBER;
   okpo_      VARCHAR2 (14);
   nmk_       VARCHAR2 (70);
   k040_      VARCHAR2 (3);
   val_       VARCHAR2 (70);
   tg_        VARCHAR2 (70);
   fdat_      DATE;
   data_      DATE;
   dat1_      DATE;
   sum0_      DECIMAL (24);
   sumk0_     DECIMAL (24);                            --ком_с_я по контракту
   kodp_      VARCHAR2 (12);
   znap_      VARCHAR2 (70);
   tag_       VARCHAR2 (5);
   userid_    NUMBER;
   ref_       NUMBER;
   mfo_       number;
   mfou_      number;
   tt_        varchar2(3);
   comm_      varchar2(200);

   formOk_    boolean;
   ttd_       varchar2(3);
   nlsdd_     varchar2(20);


   d1#E9_     VARCHAR2 (70);
   d2#E9_     VARCHAR2 (70);
   d3#E9_     VARCHAR2 (70);
   d4#E9_     VARCHAR2 (70);

-- переказ коштiв по мiжнароднiй системi переказу коштiв або отримання переказу
   CURSOR opl_dok
   IS
      SELECT   t.ko, t.fdat, t.REF, t.accd, t.nlsd, t.kv, t.acck, t.nlsk,
               max(t.s_nom), max(t.s_eqv)
      FROM OTCN_PROV_TEMP t
      WHERE t.nlsd is not null
        and t.nlsk is not null
      GROUP BY t.ko, t.fdat, t.REF, t.accd, t.nlsd, t.kv, t.acck, t.nlsk;

-------------------------------------------------------------------
   PROCEDURE p_ins (p_kodp_ IN VARCHAR2, p_znap_ IN VARCHAR2)
   IS
      l_kodp_   VARCHAR2 (12);
   BEGIN
      l_kodp_ := p_kodp_ ;

      INSERT INTO rnbu_trace
         (nls, kv, odate, kodp, znap, nbuc, isp, rnk, ref, comm)
      VALUES
         (nls1_, kv_, fdat_, l_kodp_, p_znap_, nbuc_, isp_, rnk_, ref_, comm_);

   END;
-------------------------------------------------------------------
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

   DELETE FROM OTCN_PROV_TEMP;
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
   Dat1_ := ADD_MONTHS(Dat_, -2);
   Dat1_ := TRUNC(Dat1_,'MM');

   -- параметры формирования файла
   p_proc_set (kodf_, sheme_, nbuc1_, typ_);

   -- отбор проводок, удовлетворяющих условию
   -- переказ коштiв по мiжнароднiй системi переказу коштiв або отримання переказу
   -- переказ коштiв нерезидентам (отримання коштiв вiд нерезидентiв)
   INSERT INTO OTCN_PROV_TEMP
               (ko, rnk, fdat, REF, tt, accd, nlsd, kv, acck, nlsk, s_nom, s_eqv)
      SELECT *
        FROM (
              SELECT   k.d060 ko, ca.rnk, o.fdat, o.REF, o.tt, o.accd, o.nlsd, o.kv, o.acck, o.nlsk,
                       o.s * 100 s_nom,
                       gl.p_icurval (o.kv, o.s * 100, dat_) s_eqv
                  FROM provodki o, cust_acc ca, kl_fe9 k
                 WHERE o.fdat >= Dat1_
                   AND o.fdat <= Dat_
                   AND DECODE(substr(k.nlsd,1,4),'2809',o.accd,o.acck)=ca.acc
--                   AND trim(o.nlsd)=trim(k.nlsd)
--                   AND trim(o.nlsk)=trim(k.nlsk)
                   AND trim(o.nlsd) LIKE trim(k.nlsd)||'%'
                   AND trim(o.nlsk) LIKE trim(k.nlsk)||'%'
                   AND NVL(trim(k.kv),o.kv)=o.kv
                   AND NVL(trim(k.tt),o.tt)=o.tt );

   -- переказ коштiв нерезидентам (отримання коштiв вiд нерезидентiв)
   OPEN opl_dok;

   LOOP
      FETCH opl_dok
       INTO d060_, fdat_, ref_, acc_, nls_, kv_, acck_, nlsk_, sum0_, sumk0_;

      EXIT WHEN opl_dok%NOTFOUND;

      ttd_ := null;
      nlsdd_ := null;
      d1#E9_ := null;
      d2#E9_ := null;
      d3#E9_ := null;
      d4#E9_ := null;
      kod_b_ := null;

      IF sum0_ <> 0 THEN

         formOk_ := true;

         if nls_ like '2809%' then
            acc1_ := acc_;
            nls1_ := nls_;
         else
            acc1_ := acck_;
            nls1_ := nlsk_;
         end if;

         IF sheme_ = 'G' AND typ_ > 0 THEN
            nbuc_ := NVL (f_codobl_tobo (acc1_, typ_), nbuc1_);
         ELSE
            nbuc_ := nbuc1_;
         END IF;

         if formOk_ then
            -- додатковi параметри
            n_ := 2;

            BEGIN
               select userid into isp_
               from oper
               where ref=ref_;
            EXCEPTION WHEN NO_DATA_FOUND THEN
               isp_ := 0;
            END;

            FOR i IN 1 .. n_
               LOOP
                  IF i = 1 THEN
                     begin
                        select value
                           into D1#E9_
                        from operw
                        where ref=ref_
                          and tag='D1#E9';
                     exception
                             when no_data_found then
                        D1#E9_ := '000';
                     end;
                  END IF;

                  if i=2 then
                     begin
                        select value
                           into D2#E9_
                        from operw
                        where ref=ref_
                          and tag='KOD_G';
                     exception
                             when no_data_found then
                        D2#E9_ := '000';
                     end;
                  end if;
            END LOOP;

            comm_ := 'D1#E9 = '||d1#e9_||'  KOD_G = '||d2#e9_;

            if nls_ like '2809%' then
               if trim(d2#e9_) is not null and
                  trim(d2#e9_)<>'804'      and
                  trim(d2#e9_)<>'UKR'      and
                  (trim(d1#e9_) is null or d1#e9_='000') then
                  d1#e9_ := d2#e9_;
               end if;
               d2#e9_ := '804';

               kodp_ := '1'||lpad(to_char(d060_),2,'0')||
                             lpad(to_char(kv_),3,'0')||
                             lpad(d1#e9_,3,'0')||
                             lpad(d2#e9_,3,'0');
            else
               if trim(d2#e9_) is not null and
                  trim(d2#e9_)<>'804'      and
                  trim(d2#e9_)<>'UKR'      and
                  (trim(d1#e9_) is null or d1#e9_='000') then
                  d1#e9_ := d2#e9_;
                  d2#e9_ := '804';
               end if;

               kodp_ := '1'||lpad(to_char(d060_),2,'0')||
                             lpad(to_char(kv_),3,'0')||
                             lpad(d2#e9_,3,'0')||
                             lpad(d1#e9_,3,'0');
            end if;

            -- запис показника суми
            p_ins (kodp_, to_char(sum0_) );
            -- запис показника кiлькостi
            kodp_ := '3'||substr(kodp_,2);
            p_ins (kodp_, '1' );

         end if;
      END IF;
   END LOOP;

   CLOSE opl_dok;
---------------------------------------------------
   DELETE FROM tmp_nbu
         WHERE kodf = kodf_ AND datf = dat_;
---------------------------------------------------
   INSERT INTO tmp_nbu (kodp, datf, kodf, znap, nbuc)
      SELECT kodp, dat_, kodf_, SUM(to_number(znap)), nbuc
        FROM rnbu_trace
       WHERE userid = userid_
      GROUP BY KODP,NBUC;
----------------------------------------
END p_fe9_nn;
/
show err;

PROMPT *** Create  grants  P_FE9_NN ***
grant EXECUTE                                                                on P_FE9_NN        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_FE9_NN.sql =========*** End *** 
PROMPT ===================================================================================== 
