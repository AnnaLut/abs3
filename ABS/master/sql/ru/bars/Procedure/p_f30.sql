

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F30.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F30 ***

  CREATE OR REPLACE PROCEDURE BARS.P_F30 (dat_ DATE)
IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
DESCRIPTION : процедура #30
VERSION     : 17/01/2017 (16/01/2017, 07/06/2016, 29/04/2016)
COMMENT     :
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
17/01/2017 для 9129 и ненулевой суммы резерва и R013='9' изменяем R013 на "1"
16/01/2017 показатель для резерва будем формировать если есть ненулевая сумма
07/06/2016 для выравнивания остатков по счетам резерва включаем и 5 категорию
29/04/2016 для показателя с N='3'(теперішня вартість) будем включать счета
           типа SNA
29/03/2016 для счетов типа "SNA" не будем формировать показатель с N='3'
           (теперішня вартість)
17/03/2016 для некоторых ACC (балансовых счетов 1508, 1509) формируем L='2'
09/02/2016 для 1508 выбираем основной счет 1500 если ID не похож 'NLO'
           для 1509 дополнительно добавил условие для ND и KV
20/01/2016 отменяем все условия для даты 31.12.2015
           будем формировать файл как было ранее
19/01/2016 удаляем пассивные счета начисленных и просроченных процентов
           только по показателям теперішньої вартості (13..., 23,,,)
18/01/2016 удаляем пассивные счета начисленных и просроченных процентов
16/01/2016 добавлен блок для проводок по списанию со счетов резерва
15/01/2016 сумму резерва для даты 31.12.2015 выбираем из даты 01.12.2015
12/01/2016 убрал неиспользуемые курсоры и сумму резерва выбираем из REZQ
10/01/2016 сумму резерва выбираем из поля REZQ23 вместо поля REZQ
07/12/2015 выравнивание остатков по счетам резерва с файлом 02 выполняется
           если разница остатков меньше или равна 100
04/12/2015 выбор MAX(REF) из REZ_PROTOCOL т.к. возможно несколько записей
14/05/2014 при выравнивании остатков по счету резерва 2401 убрал S090_ ='8'
22/04/2015 убрал вызов функции F_CODOBL_TOBO_NEW т.к. только для Киева и города СБ
           и Крыма СБ выполняется разбивка по кодам территории
08/04/2015 при выравнивании остатков заполняем поля RNK, ND, а также выбираем поле
           REGID т.к. суммы по обеспечению в некоторых случаях имеют одинаковые значения
19/03/2015 изменен блок для выравнивания остатков по счетам резерва
           с файлом #02
17/12/2014 изменен блок формирования видов обеспечения (показатель 14.......)
01/12/2014 для формирования показателей по видам обеспечения добавил сортировку
           по S031 (выборка из TMP_REZ_OBESP23)
08/07/2014 для показателя 37,,,,,,,,, не включаем сумму по договору
08/04/2014 для бал.счета 1509 определяем наличие счета 1500 из NBU23_REZ
           по данному клиенту и если существует то код "L"='2' иначе "1"
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
   acc_        NUMBER;
   acc1_       NUMBER;
   acc2_       NUMBER;
   accs_       NUMBER;
   acco_       NUMBER;
   vidd_       NUMBER;
   mfo_        NUMBER;
   mfou_       NUMBER;
   nd_         NUMBER;
   pawn_       NUMBER;
   c_ag_       SMALLINT;
   pr_         NUMBER;
   pr2_        NUMBER;
   pr3_        NUMBER;
   grp_        NUMBER;
   prgr_       NUMBER;
   dni_        NUMBER;
   nbs_        VARCHAR2 (4);
   nls_        VARCHAR2 (15);
   s_fond_     VARCHAR2 (15);
   daos_       DATE;
   nls1_       VARCHAR2 (15);
   comm_       VARCHAR2 (200);
   cust_       SMALLINT;
   rnk_        NUMBER;
   country_    NUMBER;
   dat1_       DATE;
   dat2_       DATE;
   data_       DATE;
   data1_      DATE;
   dato_       DATE;
   wdate_      DATE;
   kv_         NUMBER;
   kv1_        NUMBER;
   kvk_        NUMBER;
   sn_         DECIMAL (24);
   sn1_        DECIMAL (24);
   se_         DECIMAL (24);
   del_        DECIMAL (24);
   dosnk_      DECIMAL (24);
   kosnk_      DECIMAL (24);
   dosek_      DECIMAL (24);
   kosek_      DECIMAL (24);
   kodp_       VARCHAR2 (10);
   znap_       VARCHAR2 (70);
   s080_       VARCHAR2 (1);
   s080_r      VARCHAR2 (1);
   s090_       VARCHAR2 (1);
   s080_1      VARCHAR2 (1);
   s180_       VARCHAR2 (1);
   r013_       VARCHAR2 (1);
   r013_2_     VARCHAR2 (5);
   x9_         VARCHAR2 (9);
   rez_        NUMBER (10, 2);
   k041_       CHAR (1);
   k041n_      CHAR (1);
   ddd_        CHAR (3);
   l_          VARCHAR2 (1);
   n_          VARCHAR2 (1);
   f30_        SMALLINT;
   sk_         NUMBER;
   sz1_        NUMBER;
   soq_        NUMBER;
   srq_        NUMBER;
   szq_        NUMBER;
   sz_         NUMBER;
   delt_zo_    NUMBER;
   ostc_zo_    NUMBER;
   kk_         NUMBER (20, 10);
   userid_     NUMBER;
   mode_       NUMBER          := 1;
   sk1_        NUMBER;
   sk2_        NUMBER;
   se2_        NUMBER;
   obesp_      NUMBER;
   pr4_        NUMBER;
   r031_       CHAR (1);
   bannkrez_   NUMBER;
   istval_     NUMBER;
   rezid_      NUMBER;
   kodf_       VARCHAR2 (2):= '30';
   sheme_      Varchar2 (1):= 'C';
   st_         NUMBER;
   st2_        NUMBER;
   korr_       NUMBER := 0;
   sql_acc_    VARCHAR2(2000):='';
   ret_        number;
   typ_        number;
   nbuc1_      varchar2(30);
   nbuc_       varchar2(30);
   s031_       Varchar2(2);
   s031_1      Varchar2(2);
   s031_2      Varchar2(2);
   bvq_        Number;
   zal_        Number;
   zal_9129    Number;
   pvq_        Number;
   rezq_       Number;
   pvzq_       Number;
   kol_accs_   Number;
   bv_nd_      Number;
   pv_nd_      Number;
   rez_nd_     Number;
   zal_nd_     Number;
   recid_      Number;
   isp_        Number;
   datp_       Date;
   dat_izm1    Date := to_date('31/07/2013','dd/mm/yyyy');

   TYPE tk_type IS TABLE OF NUMBER
      INDEX BY PLS_INTEGER;

   CURSOR basel
   IS
      SELECT   kodp, nbuc, SUM (znap)
          FROM rnbu_trace
      GROUP BY kodp, nbuc
        HAVING SUM (znap) <> 0;

BEGIN
   commit;

   EXECUTE IMMEDIATE 'ALTER SESSION ENABLE PARALLEL DML';
-------------------------------------------------------------------
   logger.info ('P_F30: Begin for datf = '||to_char(dat_, 'dd/mm/yyyy'));
-------------------------------------------------------------------
   execute immediate 'truncate table otcn_fa7_temp';

   userid_ := user_id;

  EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';

-------------------------------------------------------------------
   mfo_ := f_ourmfo ();

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

   dat1_ := TRUNC (dat_, 'MM');
   dat2_ := TRUNC (dat_ + 28);
   dato_:=add_months(Dat1_, -1);
-------------------------------------------------------------------
BEGIN
   select A017
      into sheme_
   from kl_f00
   where kodf = kodf_
     and a017 <> sheme_;
EXCEPTION WHEN NO_DATA_FOUND THEN
   NULL;
END;

-- определение начальных параметров (код области или МФО или подразделение)
P_Proc_Set(kodf_,sheme_,nbuc1_,typ_);

------------------------------------------------------------------
if Dat_ >= to_date('30112012','ddmmyyyy') then
   Dat1_  := TRUNC(add_months(Dat_,1),'MM');
end if;

-------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
-- с 01.01.2012 новая структура показателя и новая таблица для формирования NBU23_REZ
-- сума резерву
-- сделать под структуру файла #30 07.01.2013
if Dat_ >= to_date('30112012','ddmmyyyy') then
   for z in ( select distinct nb1.fdat FDAT1, nb1.rnk RNK1, nb1.nd ND1,
                           nb1.kat KAT1, nb1.kv KV1,
                           nb1.rz RZ1
               from nbu23_rez nb1
               where nb1.fdat = dat1_
                and nb1.ddd not like '21%'
                and nb1.ddd not like '31%'
                and nb1.nbs not like '3548%'
              order by 1, 2
             )
   loop
     for k in ( select /*+leading(nb) index(nb I3_NBU23REZ)*/
                  nb.acc, NVL(nb.rnk,0) RNK, nb.nbs, nb.nls, nb.kv, nb.nd, nb.id, NVL(trim(nb.kat),'0') kat,
                  NVL(trim(nb.dd),'2') dd, NVL(trim(nb.irr),0) IRR,
                  NVL(round(nb.bvq*100,0),0) BV,
                  least( NVL(round(nb.pvq*100,0),0) + NVL(round(GL.P_ICURVAL(nb.kv, NVL(nb.diskont,0)*100, Dat_),0),0), NVL(round(nb.bvq*100,0),0) ) PV,
                  NVL(round(nb.pvzq*100,0),0) ZAL,
                  NVL(round(nb.zprq*100,0),0) ZAL1,
                  NVL(round(nb.rezq*100,0),0) rezq,
                  nb.istval, NVL(nb.ddd,'000') DDD, 2-MOD(c.codcagent,2) REZ,
                  NVL(nb.s250,'0') s250, sp.s090,
                  NVL(Trim(sp.s031),'90') S031, NVL(nb.r013,'0') R013,
                  NVL(nb.tip,'ODB') TIP
              from nbu23_rez nb, customer c, specparam sp
              where nb.fdat = z.fdat1
                and nb.rnk = z.rnk1
                and nb.nd = z.nd1
                and nb.kat = z.kat1
                and nb.kv = z.kv1
                and nb.rz = z.rz1
                and nb.ddd not like '21%'
                and nb.ddd not like '31%'
                and nb.nbs not like '3548%'
                and nb.rnk = c.rnk
                and nb.acc = sp.acc(+)
            )

     loop

       bv_nd_ := 0;
       pv_nd_ := 0;
       rez_nd_ := 0;
       zal_nd_ := 0;
       r013_ := k.r013;

       if Dat_ = to_date('30122016','ddmmyyyy') and k.rezq <> 0 and
          k.nls like '9129%' and k.r013 = '9'
       then
          r013_ := '1';
       end if;

       IF typ_>0 THEN
          --nbuc_ := NVL(f_codobl_tobo_new (k.acc, dat_, typ_),nbuc1_);
          nbuc_ := NVL(F_Codobl_Tobo (k.acc, typ_), nbuc1_);
       ELSE
          nbuc_ := nbuc1_;
       END IF;

       comm_ := 'ID='||k.id||' RNK='||k.rnk||' ND='||k.nd||' DDD='||k.ddd;

       if k.nbs like '1500%' then  --or k.nbs like '1508%'  -- or k.nbs like '1502%'
          l_ := '2';
       else
          l_ := '1';
       end if;

       if dat_ > dat_izm1 and (k.nbs like '90%' or k.nbs like '91%') then
          l_ := '3';
       end if;

       if k.nbs like '1508%' then  --and k.id not like 'NLO%' then
          begin
             select a.nls
                into nls_
             from accounts a, int_accn i
             where i.acra = k.acc
               and a.acc = i.acc
               and rownum = 1;

             if nls_ like '1500%' then
                l_ := '2';
             end if;
          EXCEPTION WHEN NO_DATA_FOUND THEN
              null;
          end;
       end if;

       -- 26.01.2016
       -- ACC бал.счета 1508 (пассивные остатки) и не привязаны до 1500
       -- поэтому вынуждены так сделать
       if mfo_ = 300465 and dat_ >= to_date('31122015','ddmmyyyy') and
          k.acc in (474041,474045,474046,475949,475950,475981)
       then
          l_ := '2';
       end if;

       if k.nbs like '1509%' then
          begin
             select a.nls
                into nls_
             from nbu23_rez a
             where a.fdat = dat1_
             and a.nbs like '1500%'
             and a.rnk = k.rnk
             --and a.nd = k.nd
             and a.kv = k.kv
             and a.kat = k.kat
             and rownum = 1;

             l_ := '2';
          EXCEPTION WHEN NO_DATA_FOUND THEN
              null;
          end;
       end if;

       -- 10.02.2016
       -- ACC бал.счета 1509 и не привязаны до 1500
       -- поэтому вынуждены так сделать
       if mfo_ = 300465 and dat_ >= to_date('29012016','ddmmyyyy') and
          k.acc in (413093, 475949, 413092, 475981, 418792, 475950, 367806, 474041)
       then
          l_ := '2';
       end if;

       s090_ := k.s250;
       -- 26.04.2013 AlexY - s250 берется только из NBU23_REZ
       -- для ГОУ, УПБ, Демарка не заполнено
       if mfo_ = 300465
       then

          -- умолчание для s090
          IF TRIM (k.s090) IS NULL OR TRIM (k.s090) IS NOT NULL AND k.s090 <> '4'
          THEN
             IF k.nbs LIKE '1%' AND k.kv <> 980
             THEN
                s090_ := '5';
             ELSIF k.nbs LIKE '1%' AND k.kv = 980
             THEN
                s090_ := '1';
             ELSIF k.kv = '980'
             THEN
                s090_ := '1';
             ELSE
                IF k.istval = '1'
                THEN
                   s090_ := '2';
                ELSE
                   s090_ := '3';
                END IF;
             END IF;
          END IF;

          if s090_ in ('0','3') then
             s090_ := '7';
          elsif s090_ in ('1','2') then
             s090_ := '6';
          elsif s090_ = '5' then
             s090_ := '9';
          else
             null;
          end if;

          if k.kv = 980 then
             s090_ := '7';
          end if;

          if k.nls = '9100713002492' then
             s090_ := '9';
          end if;

          if k.id like 'RU%' then
             s090_ := k.s250;
          end if;

          if k.nbs like '15%' then
             s090_ := '9';
          end if;
       end if;

       if L_ = '3' then
          if substr(k.nbs,1,3) in ('900','902') and k.nbs||r013_ <> '90231' then
             s090_:='A';
          elsif substr(k.nbs,1,3) in ('910','912') and k.nbs||r013_ <> '91299' then
             s090_:='B';
          elsif k.nbs||r013_='90231' or k.nbs||r013_='91299' then
             s090_:='C';
          else
             null;
          end if;
       end if;

       if L_ = '2' then
          s090_ := '0';
       end if;

       zal_9129 := 0;

       -- вся балансова варт?сть
       if k.BV <> 0
       then

          n_ := 1;

          kodp_:= L_ || N_ || k.kat || s090_ || '00' || lpad(to_char(k.kv),3,'0') || k.REZ;
          znap_:= TO_CHAR(k.BV);

          if k.nbs||r013_ <> '90231' and k.nbs||r013_ <> '91299' then
             bv_nd_ := bv_nd_ + k.bv;
          end if;

          INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, rnk, nd, comm, acc)
          VALUES (k.nls, k.kv, dat_, kodp_, znap_, nbuc_, k.rnk, k.nd, comm_, k.acc);
       end if;

       -- балансова варт?сть (новий показник 37ТШ00VVVR) - резерви не формуються
       -- авалiв що наданi клiєнтам за податковими векселями  - 9023 R013='1'
       -- неризиковi зобов'язання з кредитування клiєнтiв     - 9129 R013='9'
       if L_ = '3' then
          if (k.BV - k.PV) > 0 and ( k.nbs||r013_ <> '90231' and k.nbs||r013_ <> '91299')
          then
             n_ := '7';
             kodp_:= L_ || N_ || k.kat || s090_ || '00' || lpad(to_char(k.kv),3,'0') || k.REZ;
             znap_:= TO_CHAR(k.BV - k.PV);

             INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, rnk, nd, comm, acc)
             VALUES (k.nls, k.kv, dat_, kodp_, znap_, nbuc_, k.rnk, k.nd, comm_, k.acc);
          end if;
       end if;

       -- балансова варт?сть нарахованих в?дсотк?в в тому числ?
       if k.BV <> 0
          and (k.nbs like '___8%' or k.nbs like '___9%' or k.nbs in ('1607','2607','2627','2657','8026') )
          and k.nbs not like '9%'
       then
          n_ := '2';
          kodp_:= L_ || N_ || k.kat || s090_ || '00' || lpad(to_char(k.kv),3,'0') || k.REZ;
          znap_:= TO_CHAR(k.BV);

          INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, rnk, nd, comm, acc)
          VALUES (k.nls, k.kv, dat_, kodp_, znap_, nbuc_, k.rnk, k.nd, comm_, k.acc);
       end if;

       -- теперiшня вартiсть
       if k.PV >= 0 and k.nbs not like '9%' and
                          ( (k.nbs in ('2600','2607','2067','2069','2625','2627',
                                        '2650','2655','2657','8025','8026') and k.id like 'OVER%') OR
                             ((k.id like 'BPK%' and k.nbs like '9129%' and r013_='1') or
                              (k.id like 'BPK%' and k.nbs not like '9129%') ) OR
                             ((k.id like 'W4%' and k.nbs like '9129%' and r013_='1') or
                             (k.id like 'W4%' and k.nbs not like '9129%') )
                          )
       then
          -- балансова вартість по договору + резерв по договору
          bvq_ := k.bv;
          rezq_ := k.rezq;
          --if k.nbs in ('2600','2607','9129','8025','8026') and k.pv <> 0 then
             pvq_ := k.pv;
          --else
          --   pvq_ := bvq_ - rezq_;
          --end if;
          if pvq_ <> 0 then
             n_ := '3';
             kodp_:= L_ || N_ || k.kat || s090_ || '00' || lpad(to_char(k.kv),3,'0') || k.REZ;
             znap_ := to_char(pvq_);
             pv_nd_ := pv_nd_ + pvq_;

             INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, rnk, nd, comm, acc)
             VALUES (k.nls, k.kv, dat_, kodp_, znap_, nbuc_, k.rnk, k.nd, comm_, k.acc);
          end if;
       end if;

       -- теперiшня вартiсть
       if k.PV <> 0 and k.nbs not like '9%'
                    and k.id not like 'OVER%'
                    and k.id not like 'BPK%'
                    and k.id not like 'W4%'
       then
          if k.nbs like '9%' then
             isp_ := 9;
          elsif k.nbs like '1%' then
             isp_ := 1;
          else
             isp_ := 2;
          end if;

          bvq_  := k.bv;
          rezq_ := k.rezq;
          pvq_ := k.pv;

          n_ := '3';
          kodp_:= L_ || N_ || k.kat || s090_ || '00' || lpad(to_char(k.kv),3,'0') || k.REZ;

          --if pvq_ > 0 and pvq_ >= bvq_ and rezq_ >= 0 then
          --   zal_ := 0 ;
          --   znap_ := to_char(bvq_ - rezq_);
          --   pv_nd_ := pv_nd_ + (bvq_ - rezq_);

          --   INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, rnk, nd, comm, acc, isp)
          --   VALUES (k.nls, k.kv, dat_, kodp_, znap_, nbuc_, k.rnk, k.nd, comm_, k.acc, isp_);
          --end if;

          --if pvq_ > 0 and bvq_ > pvq_ and bvq_ - pvq_ = rezq_ and rezq_ >= 0 then
          --   zal_ := 0;
          --   znap_ := to_char(pvq_);
          --   pv_nd_ := pv_nd_ + pvq_;

          --   INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, rnk, nd, comm, acc, isp)
          --   VALUES (k.nls, k.kv, dat_, kodp_, znap_, nbuc_, k.rnk, k.nd, comm_, k.acc, isp_);
          --end if;

          --if pvq_ > 0 and bvq_ > pvq_ and bvq_ - pvq_ > rezq_ and rezq_ >= 0 then
          --   zal_ :=  bvq_ - (pvq_ + rezq_) ;
          --   znap_ := to_char(pvq_);
          --   pv_nd_ := pv_nd_ + pvq_;
          --   INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, rnk, nd, comm, acc, isp)
          --   VALUES (k.nls, k.kv, dat_, kodp_, znap_, nbuc_, k.rnk, k.nd, comm_, k.acc, isp_);
          --end if;

          --if pvq_ > 0 and bvq_ > pvq_ and bvq_ - pvq_  < rezq_ and rezq_ >= 0 then
          --   zal_ := 0;
          --   znap_ := to_char(bvq_ - rezq_);
          --   pv_nd_ := pv_nd_ + (bvq_ - rezq_);
          --   INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, rnk, nd, comm, acc, isp)
          --   VALUES (k.nls, k.kv, dat_, kodp_, znap_, nbuc_, k.rnk, k.nd, comm_, k.acc, isp_);
          --end if;

          --if pvq_ < 0 and pvq_ = bvq_ then
             zal_ := 0 ;
             znap_ := to_char(pvq_);
             pv_nd_ := pv_nd_ + pvq_;

             INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, rnk, nd, comm, acc, isp)
             VALUES (k.nls, k.kv, dat_, kodp_, znap_, nbuc_, k.rnk, k.nd, comm_, k.acc, isp_);
          --end if;

       end if;

       -- где взять iншi грошовi потоки за кредитом  !!!
       -- резерв
       -- на 01.01.2017 формируем все суммі резерва если они ненулевые
       if k.rezq <> 0 and ( (k.nbs like '9023%' and r013_='9') or
                            (k.nbs like '9129%' and r013_='1') or
                            (k.nbs not like '9023%' and k.nbs not like '9129%')
                          )
       then
          n_ := '6';
          kodp_:= L_ || N_ || k.kat || s090_ || '00' || lpad(to_char(k.kv),3,'0') || k.REZ;
          znap_:= TO_CHAR(ABS(k.rezq));
          rez_nd_ := rez_nd_ + k.rezq;

          INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, rnk, nd, comm, acc, isp)
          VALUES (k.nls, k.kv, dat_, kodp_, znap_, nbuc_, k.rnk, k.nd, comm_, k.acc, isp_);
       end if;

       if k.ZAL <> 0 then  --bv_nd_ - pv_nd_ - rez_nd_ <> 0

          --zal_nd_ := bv_nd_ - pv_nd_ - rez_nd_;


          -- блок для формирования сум по видам залога
          for z1 in ( select t.accs, a.nls, a.kv, cc.s031,
                             t.pvzq zpr
                     from tmp_rez_obesp23 t, cc_pawn cc, accounts a
                     where t.dat = dat1_
                       and t.accs = k.acc
                       and t.pawn = cc.pawn
                       and t.accs = a.acc
                     order by cc.s031
                   )
          loop

             --if z1.zpr > 0 and z1.zpr < zal_nd_ and zal_nd_ <> 0 then
                s031_ := z1.s031;
                if s031_ = '30' then
                   s031_ := '38';
                end if;
                if s031_ = '31' then
                   s031_ := '37';
                end if;
                if s031_ = '32' then
                   s031_ := '29';
                end if;

                n_ := '4';
                kodp_:= L_ || N_ || z.kat1 || s090_ || s031_ || lpad(to_char(z.kv1),3,'0') || z.RZ1;
                znap_ := to_char(z1.zpr);
                zal_nd_ := zal_nd_ - z1.zpr;

                INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, rnk, nd, comm, acc, isp)
                VALUES (z1.nls, z1.kv, dat_, kodp_, znap_, nbuc_, z.rnk1, z.nd1, comm_, z1.accs, isp_);
             --else
             --   if z1.zpr > 0 and z1.zpr >= zal_nd_ and zal_nd_ <> 0then
             --      s031_ := z1.s031;
             --      if s031_ = '30' then
             --         s031_ := '38';
             --      end if;
             --      if s031_ = '31' then
             --         s031_ := '37';
             --      end if;
             --      if s031_ = '32' then
             --         s031_ := '29';
             --      end if;

             --     n_ := '4';
             --      kodp_:= L_ || N_ || z.kat1 || s090_ || s031_ || lpad(to_char(z.kv1),3,'0') || z.RZ1;
             --      znap_ := to_char(zal_nd_);
             --      zal_nd_ := 0;

             --      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, rnk, nd, comm, acc, isp)
             --      VALUES (z1.nls, z1.kv, dat_, kodp_, znap_, nbuc_, z.rnk1, z.nd1, comm_,z1.accs, isp_);
             --   end if;
             --end if;
          end loop;
       end if;
    end loop;
   end loop;

   -- этот блок был нужен только для 23 Постанови
   -- с декабря месяца 2015 года сумма резерва рассчитана по МСФЗ
   -- и этот блок отключаем
   if dat_ < to_date('01122015','ddmmyyyy')
   then
      begin
         for k in
         (
           select acc, kv, kodp, bv, pv, zal, rezerv,balans
           from
           (
             select acc, kv,
                    substr(kodp,1,1)||'0'||substr(kodp,3,2)||'00'||substr(kodp,-4) kodp,
                    sum(decode(substr(kodp,1,2),11,znap,0)) BV,
                    sum(decode(substr(kodp,1,2),13,znap,0)) PV,
                    sum(decode(substr(kodp,1,2),14,znap,0)) ZAL,
                    sum(decode(substr(kodp,1,2),16,znap,0)) REZERV,
                    sum(decode(substr(kodp,1,2),11,znap,0))  - sum(decode(substr(kodp,1,2),13,znap,0)) - sum(decode(substr(kodp,1,2),14,znap,0)) - sum(decode(substr(kodp,1,2),16,znap,0)) Balans
             from rnbu_trace
             where kodp is not null and kodp not like '31%'
             group by acc, kv, substr(kodp,1,1)||'0'||substr(kodp,3,2)||'00'||substr(kodp,-4)
             )
           where ABS(balans) <> 0 and ABS(balans) <=100
           order by 1,2,3
         )

         loop
              BEGIN
                 select r.recid, r.kodp, r.nbuc
                    INTO recid_, kodp_, nbuc_
                 from rnbu_trace r
                 where r.znap = (select max(to_number(znap))
                               from rnbu_trace
                               where  substr(kodp,1, 2) in ('14','24')
                                  and acc = k.acc
                                  and substr(kodp,3, 1) = substr(k.kodp,3,1)
                                  and substr(kodp,7, 3) = substr(k.kodp,7,3)
                                  and substr(kodp,10, 1) = substr(k.kodp,10,1) )
                  and substr(r.kodp,1, 2)  in ('14','24')
                  and r.acc = k.acc
                  and substr(r.kodp,3, 1) = substr(k.kodp,3,1)
                  and substr(r.kodp,7, 3) = substr(k.kodp,7,3)
                  and substr(r.kodp,10, 1) = substr(k.kodp,10,1)
                  and rownum=1;

                  update rnbu_trace set znap = znap+k.balans
                  where recid = recid_ and acc=k.acc and kv=k.kv and kodp = kodp_ and nbuc = nbuc_;

              EXCEPTION WHEN NO_DATA_FOUND THEN
                 BEGIN
                    select r.recid, r.kodp, r.nbuc
                       INTO recid_, kodp_, nbuc_
                    from rnbu_trace r
                    where r.znap = (select max(to_number(znap))
                                  from rnbu_trace
                                  where substr(kodp,1, 2) in ('13','23')
                                    and acc = k.acc
                                    and substr(kodp,3, 1) = substr(k.kodp,3,1)
                                    and substr(kodp,7, 3) = substr(k.kodp,7,3)
                                    and substr(kodp,10, 1) = substr(k.kodp,10,1) )
                      and substr(r.kodp,1, 2) in ('13','23')
                      and r.acc = k.acc
                      and substr(r.kodp,3, 1) = substr(k.kodp,3,1)
                      and substr(r.kodp,7, 3) = substr(k.kodp,7,3)
                      and substr(r.kodp,10, 1) = substr(k.kodp,10,1)
                      and rownum=1;

                     update rnbu_trace set znap = znap+k.balans
                     where recid = recid_ and acc=k.acc and kv=k.kv and kodp = kodp_ and nbuc = nbuc_;

                 EXCEPTION WHEN NO_DATA_FOUND THEN
                     null;
                 END;
              END;
         end loop;
      end;
   end if;

-- нужен блок для выравнивания остатков счетов резерва файла #30 и #02
----------------------------------------------------------------------
   if mfo_ not in (300465)   -- Dat_ <> to_date('31122015','ddmmyyyy') and
   then

      sql_acc_ := 'select r020 from kod_r020 where a010=''11''
                                               and r020 not like ''9%''
                                               and d_close is null';

      ret_ := F_Pop_Otcn(Dat_, 2, sql_acc_);

      for k in (select a.nbs, a.kv, 2-MOD(c.codcagent ,2) REZ,
                       NVL(s.s080,'0') S080,
                       sum(a.Ost) Ostn, sum(a.Ostq) Ostq,
                       sum(a.Dos96) dos96, sum(a.Kos96) Kos96,
                       sum(a.Dosq96) Dosq96, sum(a.Kosq96) kosq96
                from otcn_saldo a, customer c, specparam s
                where a.rnk = c.rnk
                  and a.acc = s.acc(+)
                  and (a.Ost-a.Dos96+a.Kos96 <> 0  or a.Ostq-a.Dosq96+a.Kosq96<>0)
                  --and nvl(s.s080, '0') <> '5'
                group by a.nbs, a.kv, 2-MOD(c.codcagent ,2), NVL(s.s080,'0')
                order by 1,2)

      loop
         IF k.kv <> 980 THEN
            se_:=k.Ostq - k.Dosq96 + k.Kosq96;
         ELSE
            se_:=k.Ostn - k.Dos96 + k.Kos96;
         END IF;

         if k.nbs = '1592' then
            l_ := '2';
            s090_ := '0';
         elsif k.nbs = '1590' then
            l_ := '1';
            s090_ := '9';
         elsif k.nbs = '2400' then
            l_ := '1';
            s090_ := '_';
         elsif k.nbs = '2401' then
            l_ := '1';
            s090_ := '_';
         elsif k.nbs = '3690' then
            l_ := '3';
            s090_ := '_';
         end if;

         if k.nbs like '3690%' then
            isp_ := 9;
            select NVL(sum(to_number(znap)),0)
               into sn_
            from rnbu_trace
            where  kodp like l_ || '6' || k.s080 || s090_ || '__' ||
                             lpad(to_char(k.kv), 3, '0') || to_char(k.rez) || '%'
               and nls like '9%';
         end if;

         if k.nbs like '159%' then
            isp_ := 1;
            select NVL(sum(to_number(znap)),0)
               into sn_
            from rnbu_trace
            where  kodp like l_ || '6' || k.s080 || s090_ || '__' ||
                             lpad(to_char(k.kv), 3, '0') || to_char(k.rez) || '%'
              and  nls like '1%';
         end if;

         if k.nbs like '2400%' then
            isp_ := 2;
            select NVL(sum(to_number(znap)),0)
               into sn_
            from rnbu_trace
            where kodp like l_ || '6' || k.s080 || s090_ || '__' ||
                             lpad(to_char(k.kv), 3, '0') || to_char(k.rez) || '%'
              and substr(kodp,4,1) <> '8'
              and nls not like '1%' and nls not like '9%' and nls not like '0%';
         end if;

         if k.nbs like '2401%' then
            isp_ := 2;
            select NVL(sum(to_number(znap)),0)
               into sn_
            from rnbu_trace
            where  kodp like l_ || '6' || k.s080 || s090_ || '__' ||
                             lpad(to_char(k.kv), 3, '0') || to_char(k.rez) || '%'
               and nls not like '1%' and nls not like '9%' and nls not like '0%';
         end if;

         -- формируем разницу остатков
         if se_ <> 0 and se_ <> sn_ and ABS(se_ - sn_) <= 100 then
             znap_ := to_char(se_ - sn_);
             comm_ := 'Рiзниця залишкiв ' || k.nbs || ' по валюті = ' ||
                     lpad(to_char(k.kv),3,'0') ||
                     ' кат. ризику = ' || k.s080 ||
                     ' резидентн?сть = ' || to_char(k.rez) ||
                     ' залишок по балансу = ' ||to_char(ABS(se_)) ||
                     ' сума в файлi =  ' || to_char(sn_);

            BEGIN
               select nd, rnk, kodp, nbuc
                  INTO nd_, rnk_, kodp_, nbuc_
               from rnbu_trace
               where znap = ( select max(to_number(znap))
                              from rnbu_trace
                              where kodp like l_ || '6' || k.s080 || s090_ || '__' ||
                                              lpad(to_char(k.kv), 3, '0') || to_char(k.rez) || '%'
                                and isp like to_char(isp_) || '%'
                            )
                 and kodp like l_ || '6' || k.s080 || s090_ || '__' ||
                               lpad(to_char(k.kv), 3, '0') || to_char(k.rez) || '%'
                 and isp like to_char(isp_) || '%'
                 and rownum=1;

               INSERT INTO rnbu_trace
                  (nls, kv, odate, kodp, znap, rnk, nd, comm, nbuc)
               VALUES
                  ('000000', k.kv, dat_, kodp_, znap_, rnk_, nd_, comm_, nbuc_);

               s090_ := substr(kodp_, 4, 1);
            EXCEPTION WHEN NO_DATA_FOUND THEN
                null;
            END;

            BEGIN
               select kodp, nbuc
                  INTO kodp_, nbuc_
               from rnbu_trace
               where znap = ( select max(to_number(znap))
                              from rnbu_trace
                              where kodp like l_ || '4' || k.s080 || s090_ || '__' ||
                                              lpad(to_char(k.kv), 3, '0') || to_char(k.rez) || '%'
                                and isp like to_char(isp_) || '%'
                            )
                 and kodp like l_ || '4' || k.s080 || s090_ || '__' ||
                          lpad(to_char(k.kv), 3, '0') || to_char(k.rez) || '%'
                 and isp like to_char(isp_) || '%'
                 and rnk = rnk_
                 and nd = nd_
                 and rownum=1;

                INSERT INTO rnbu_trace
                   (nls, kv, odate, kodp, znap, rnk, nd, comm, nbuc)
                VALUES
                   ('000000', k.kv, dat_, kodp_, 0-znap_, rnk_, nd_, comm_, nbuc_);
            EXCEPTION WHEN NO_DATA_FOUND THEN
               BEGIN
                  select kodp, nbuc
                     INTO kodp_, nbuc_
                  from rnbu_trace
                  where znap = ( select max(to_number(znap))
                                 from rnbu_trace
                                 where kodp like l_ || '3' || k.s080 || s090_ || '__' ||
                                                 lpad(to_char(k.kv), 3, '0') || to_char(k.rez) || '%'
                                   and isp like to_char(isp_) || '%'
                               )
                    and kodp like l_ || '3' || k.s080 || s090_ || '__' ||
                                  lpad(to_char(k.kv), 3, '0') || to_char(k.rez) || '%'
                    and isp like to_char(isp_) || '%'
                    and rnk = rnk_
                    and nd = nd_
                    and rownum=1;

                   INSERT INTO rnbu_trace
                      (nls, kv, odate, kodp, znap, rnk, nd, comm, nbuc)
                   VALUES
                      ('000000', k.kv, dat_, kodp_, 0-znap_, rnk_, nd_, comm_, nbuc_);
               EXCEPTION WHEN NO_DATA_FOUND THEN
                  null;
               END;
            END;
         end if;
      end loop;
   end if;
    ----------------------------------------------------------------------

end if;
-----------------------------------------------------------------------------
   DELETE FROM tmp_nbu
         WHERE kodf = kodf_ AND datf = dat_;

   OPEN basel;

   LOOP
      FETCH basel
       INTO kodp_, nbuc_, znap_;

      EXIT WHEN basel%NOTFOUND;

      INSERT INTO tmp_nbu
                  (kodf, datf, kodp, znap, nbuc
                  )
           VALUES ('30', dat_, kodp_, znap_, nbuc_
                  );
   END LOOP;

   CLOSE basel;
  --------------------------------------------------
-----------------------------------------------------------------------------
  logger.info ('P_F30: End for datf = '||to_char(dat_, 'dd/mm/yyyy'));
END p_f30;
/
show err;

PROMPT *** Create  grants  P_F30 ***
grant EXECUTE                                                                on P_F30           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_F30           to RPBN002;
grant EXECUTE                                                                on P_F30           to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F30.sql =========*** End *** ===
PROMPT ===================================================================================== 
