

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F6B_NN.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F6B_NN ***

 CREATE OR REPLACE PROCEDURE BARS.P_F6B_NN (Dat_ DATE, sheme_ Varchar2 DEFAULT 'G' )
IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 % DESCRIPTION : процедура #6B
 %
 % VERSION     :   v.18.005      26.04.2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
/*
   Структура показателя    GGG CC N H I OO R VVV

  1   GGG           вид задолженности       [kl_f3_29.DDD]
  4   CC            [список]
  6   N             код контрагента         [1/2/3/4/5]
  7   H             S083 тип оценки крединого риска
  8   I             S080 код класса должника
  9   OO            S031 код вида обеспечения кредита
 11   R             K030 резидентность
 12   VVV           R030 код валюты

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

26.04.2018  обработка счетов дисконтов с r013=1,2,3,4 из nbu23_rez  (CC=40)
16.04.2018  отдельная обработка  SNA-счета  654602611
11.04.2018  отдельная обработка  счетов 3-го класса и клиента  90593701
03.04.2018  отдельная обработка счетов SNA из nbu23_rez  (CC=40)
25.01.2018  изменение распределения счетов для сегмента GGG
15.11.2017  переход на новый план счетов
27.10.2017  сегмент N равен 5 при установленном доп.параметре клиента "юр.лицо SPE"
10.10.2017  код контрагента дополнительно определяется по customer.CUSTTYPE
11.09.2017  сегмент H равен 1 для ggg=161
09.08.2017  уточнения по отображению рисковых/безрисковых ЦБ (счета 3-го класса)
              по видам задолженности GGG =130,133,135,138
28.07.2017  -изменение справочника соответствия GGG балансовым счетам
            -расширение списка нерисковых активов по условию pd_0 =1
11.04.2017  ggg=133 и счета 3-го класса не переносятся в ggg=130,
            сегмент H для них равен 1
10.04.2017  для 2805,2806 код класса устанавливается A
20.02.2017  счета переоценок ЦБ приводим по остаткам к консолидированным счетам
16.01.2017  новый файл #6B, создание процедуры
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/

kodf_       VARCHAR2 (2):= '6B';
--sheme_      Varchar2 (1):= 'C';

mfo_        NUMBER;
mfou_       NUMBER;

pr_         NUMBER;
comm_       VARCHAR2 (200);
dat1_       DATE;
dat2_       DATE;
dato_       DATE;
kv_         varchar2(3);

kodp_       VARCHAR2 (30);
znap_       VARCHAR2 (70);

ddd_        CHAR (3);
CC_         VARCHAR2 (2);
OO_         VARCHAR2 (2);
I_          VARCHAR2 (1);
N_          VARCHAR2 (1);
H_          VARCHAR2 (1);

r011_          VARCHAR2 (1);

userid_     NUMBER;
typ_        number;
nbuc1_      varchar2(30);
nbuc_       varchar2(30);

is_budg_       number;         --при поиске счетов бюджета, раздел 25
is_spe_        varchar2(1);    --при проверке юр.лиц на принадлежность SPE

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
   logger.info ('P_F6B_NN: Begin for datf = '||to_char(dat_, 'dd/mm/yyyy'));
-------------------------------------------------------------------
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

   dat1_ := TRUNC (add_months(dat_,1), 'MM');
   dat2_ := TRUNC (dat_ + 28);
   dato_:=add_months(Dat1_, -1);
-------------------------------------------------------------------
--   проверка наличия месячного баланса
/*   select count( * )
     into pr_
     from agg_monbals
    where fdat = dat1_;
   if pr_ =0  then

        BARS_UTL_SNAPSHOT.start_running;

        BARS_UTL_SNAPSHOT.sync_month(dat1_);

        BARS_UTL_SNAPSHOT.stop_running;

   end if;
*/
--   определение начальных параметров (код области или МФО или подразделение)
   P_Proc_Set(kodf_,sheme_,nbuc1_,typ_);

-----------------------------------------------------------------------
   for z in ( select distinct nb1.fdat FDAT1, nb1.rnk RNK1, nb1.nd ND1,
                           nb1.kat KAT1, nb1.kv KV1,
                           nvl(nb1.rz,0) RZ1
               from nbu23_rez nb1
               where nb1.fdat = dat1_
              order by 1, 2
             )
   loop
     for k in ( select /*+leading(nb) index(nb I3_NBU23REZ)*/
                       nb.acc, NVL(nb.rnk,0) RNK, nb.nbs, nb.nls, nb.kv,
                       nb.nd, nb.id, NVL(trim(nb.kat),'0') kat,
                       NVL(round(nb.bvq*100,0),0) BV,
                       NVL(round(nb.pvzq*100,0),0) ZAL,
                       NVL(round(nb.crq*100,0),0) crq,
                       NVL(round(nb.rcq*100,0),0) rcq,
                       NVL(nb.ccf,0) ccf,
                       NVL(round(nb.rezq*100,0),0) rezq,
                       nb.istval, NVL(nb.ddd_6b,'000') DDD,
                       nvl(nb.s180,'0') s180, nb.s080 FIN,
                       nvl(nb.pd_0,0) pd_0,
                       c.codcagent, c.custtype,
                       2-MOD(c.codcagent,2) REZ, NVL(trim(c.sed),'00') sed,
                       NVL(nb.s250_23,'0') s250,
                       NVL(Trim(sp.s031),'90') S031, NVL(nb.r013,'0') R013,
                       NVL(nb.tip,'ODB') TIP
                  from nbu23_rez nb, customer c, specparam sp
                 where nb.fdat = z.fdat1
                   and nb.rnk = z.rnk1
                   and nb.nd = z.nd1
                   and nb.kat = z.kat1
                   and nb.kv = z.kv1
                   and nvl(nb.rz,0) = z.rz1
                   and NVL(nb.ddd_6b,'000') !='000'
                   and nb.rnk = c.rnk
                   and nb.acc = sp.acc(+)
              )
     loop

       ddd_ := k.DDD;
       kv_ := lpad(to_char(k.kv),3,'0');

       if    k.nbs  like '9%' and k.pd_0 =1  then

          ddd_ := '210';
       end if;

       if    ddd_ ='212' and k.ccf =20 and k.pd_0 !=1 then

          ddd_ := '214';
       elsif ddd_ ='212' and k.ccf =50 and k.pd_0 !=1 then

          ddd_ := '213';
       else
          null;
       end if;
       if ddd_ ='152' and k.s180 >'6'  then
          ddd_ := '151';
       end if;

       IF typ_>0 THEN
          nbuc_ := NVL(F_Codobl_Tobo (k.acc, typ_), nbuc1_);
       ELSE
          nbuc_ := nbuc1_;
       END IF;

       comm_ := 'ID='||k.id||' RNK='||k.rnk||' ND='||k.nd||' DDD='||k.ddd;

       CC_ := '11';

       if k.codcagent in (1, 2)               -- банки
       then
          N_ := '3';                          
       elsif k.codcagent in (3, 4)            -- юр.лица
       then

--   проверка наличия доп.параметра ISSPE
          begin
            select nvl(trim(value),'0')   into is_spe_
              from customerw
             where rnk =k.rnk
               and tag ='ISSPE';
          exception
            when others
               then is_spe_ :='0';
          end;

          if is_spe_ ='1'  then

             N_ := '5';
          else

             if k.nls like '21%'    or
                k.nls like '236%'   or
                k.nls like '237%'   or
                k.nls like '238%'   
             then
                     is_budg_ := 1;
             else    is_budg_ := 0;
             end if;

             -- для контрагента Министерство финансов ........
             if    is_budg_ !=0  or
                   ( mfo_ = 300465 and k.rnk in (90092301, 94312801) ) then

                  N_ := '4';                  --бюджет
             elsif k.sed = '56'  then
                  N_ := '6';                  --юр.лицо ОСББ
             else
                  N_ := '2';                  --юр.лицо
             end if;

          end if;

       elsif k.codcagent in (5,6) and k.sed <> '91'
       then
          N_ := '1';                          --физ.лицо
       elsif k.codcagent in (5,6) and k.sed = '91'
       then
          N_ := '1';                    --физ.лицо предприниматель (ранее =2)
       else

          if    k.custtype ='1'  then   N_ := '3';
          elsif k.custtype ='2'  then   N_ := '2';
          elsif k.custtype ='3'  then   N_ := '1';
          else
               N_ := 'X';
          end if;

       end if;

       OO_ := '00';

       -- балансова вартiсть нарахованих вiдсоткiв в тому числi
       if k.BV <> 0
          and ( (k.nbs like '___8%' or  k.nbs in ('1607','2607','2627','2657','8026') )
                and k.nbs not like '9%'
                and ddd_ not like '15%'
          or  ddd_ like '15%' and k.nbs in ('3570','3578') )
       then
          CC_ := '12';
       end if;

       H_ := '0';

       if k.pd_0 !=1 and k.s250 = '8' then
          H_ := '2';
       elsif k.pd_0 !=1  then
          H_ := '1';
       else
          H_ := '0';
       end if;

       if ddd_ ='161'  then
          H_ := '1';
       end if;

       -- формирование части кода "CC" для счетов 9 класса
       if k.nbs like '9%' and H_ = '1'
       then
          if    k.ccf = 0  then
             CC_ := '13';
          elsif k.ccf = 20 then
             CC_ := '14';
          elsif k.ccf = 50 then
             CC_ := '15';
          elsif k.ccf = 100 then
             CC_ := '16';
          else
             null;
          end if;
       end if;

       I_ := k.fin;
       if ddd_ like '15%'  and  trim(I_) is null  then
          I_ := 'K';
       end if;
--                      умолчание для 2805,2806
       if ddd_ = '150'  and  k.nbs in ('2805','2806')  then
          I_ := 'A';
       end if;

       if N_ ='X'  and ddd_ between '152' and '153'  then
          N_ :='3';
       end if;

       -- для контрагента Министерство финансов ........
       if mfo_ = 300465 and k.rnk in (90092301, 94312801)
       then
          I_ := 'M';
       end if;

       if    k.pd_0 =1  and
             k.nbs in ('1500','1502','1508','1600','1607') 
       then  
           ddd_ :='120';   
           H_ := '0';

       end if;

       if    k.pd_0 =1  and
             k.nbs in ('1402','1403','1405','1408', '3012','3015','3018',
                       '1412','1413','1415','1418', '3112','3115','3118',
                       '1422','1423','1428', '3212','3218')
       then  
           ddd_ :='130';   
           H_ := '0';

       end if;

-- отдельная обработка  счетов 3-го класса -могут быть в ggg=130
 
       if  ddd_ in('133','135','138') and k.nbs like '3%'   then
                 
          select count(*)  into pr_
            from nbu23_rez
           where fdat = z.fdat1
             and nd = k.nd
             and nbs = substr(k.nbs,1,3)||'0';

          if pr_ !=0  then

              ddd_ :='130';   
              H_ := '0';
          else

              H_ := '1';
          end if;
       end if;

-- отдельная обработка  счетов 3-го класса -могут быть в ggg=130
 
       if  ddd_ in('133','135','138') and k.nbs like '3%'   then
                 
          select count(*)  into pr_
            from nbu23_rez
           where fdat = z.fdat1
             and nd = k.nd
             and nbs = substr(k.nbs,1,3)||'0';

          if pr_ !=0  then

              ddd_ :='130';   
              H_ := '0';
          else

              H_ := '1';
          end if;
       end if;
                                     --  отдельная обработка клиента  90593701
       if    mfo_ = 300465 and k.rnk in (90593701) and
             k.nbs like '311%'
       then  
           ddd_ :='138';   
           H_ := '1';

       end if;

       if k.nbs in ('3005','3007','3008')  then

          r011_ :='0';
          begin
             select r011  into r011_
               from specparam
              where acc =k.acc;

          exception
              when others  then  r011_ :='0';
          end;

          if r011_ ='A'  then   ddd_ :='131';   end if;
       end if;

       if k.nbs in ('3105','3107','3108')  then

          r011_ :='0';
          begin
             select r011  into r011_
               from specparam
              where acc =k.acc;

          exception
              when others  then  r011_ :='0';
          end;

          if r011_ ='8'  then   ddd_ :='131';   end if;
       end if;

       -- вся балансова вартiсть
       if k.BV <> 0  then

          kodp_:= CC_|| N_|| H_|| I_||'00'|| to_char(k.rez) || kv_;
          znap_:= TO_CHAR(k.BV);

          if         ddd_ between '211' and '219'  then

             case when CC_='13'  then
               INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, rnk, nd, comm, acc)
               VALUES (k.nls, k.kv, dat_, ddd_||kodp_, to_char(round(k.BV*0.0)), nbuc_, k.rnk, k.nd, comm_, k.acc);
                  when CC_='14'  then
               INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, rnk, nd, comm, acc)
               VALUES (k.nls, k.kv, dat_, ddd_||kodp_, to_char(round(k.BV*0.2)), nbuc_, k.rnk, k.nd, comm_, k.acc);
                  when CC_='15'  then
               INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, rnk, nd, comm, acc)
               VALUES (k.nls, k.kv, dat_, ddd_||kodp_, to_char(round(k.BV*0.5)), nbuc_, k.rnk, k.nd, comm_, k.acc);
                  else
               INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, rnk, nd, comm, acc)
               VALUES (k.nls, k.kv, dat_, ddd_||kodp_, znap_, nbuc_, k.rnk, k.nd, comm_, k.acc);
             end case;

             INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, rnk, nd, comm, acc)
             VALUES (k.nls, k.kv, dat_, ddd_||'11'||substr(kodp_,3), znap_, nbuc_, k.rnk, k.nd, comm_, k.acc);

          else

             INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, rnk, nd, comm, acc)
             VALUES (k.nls, k.kv, dat_, ddd_||kodp_, znap_, nbuc_, k.rnk, k.nd, comm_, k.acc);

             if ddd_ = '121' and k.pd_0 =1 then
     
                INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, rnk, nd, comm, acc)
                VALUES (k.nls, k.kv, dat_, '120'||kodp_, znap_, nbuc_, k.rnk, k.nd, comm_, k.acc);
             end if;
          end if;
       end if;

    -- на индивидуальной основе
       -- розмір повернення боргу за рахунок реалізац.забезпечення (CV*k) СС=20
       if H_ ='1' and k.nbs not like '9%' and
             not ( ddd_ between '130' and '138' )  then

          CC_ := '20';

          for u in ( select nvl(round(cr.zalq*100,0),0) zalq,
                            nvl(round(cr.rcq*100,0),0) rcq,
                            nvl(cr.rpb,0) rpb,
                            cr.pawn, nvl(p.s031,'90') s031_n
                       from rez_cr cr, cc_pawn p
                      where cr.fdat = z.fdat1
                        and cr.acc  = k.acc
                        and cr.pawn = p.pawn(+)
                   )
          loop
             if u.zalq !=0  then
                OO_ := u.s031_n;

                kodp_:= CC_|| N_|| H_|| I_|| OO_|| to_char(k.rez) || kv_;
                znap_:= TO_CHAR(ABS(u.zalq));

                INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, rnk, nd, comm, acc)
                VALUES (k.nls, k.kv, dat_, ddd_||kodp_, znap_, nbuc_, k.rnk, k.nd, comm_, k.acc);

                if ddd_ = '121' and k.pd_0 =1 then

                   INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, rnk, nd, comm, acc)
                   VALUES (k.nls, k.kv, dat_, '120'||kodp_, znap_, nbuc_, k.rnk, k.nd, comm_, k.acc);
                end if;
             end if;
          end loop;
       end if;

       -- розмір повернення боргу за рахунок інш.надхождень (RC) СС=21
       if H_ ='1' and k.nbs not like '9%' and k.rcq <> 0
       then
          CC_ := '21';

          kodp_:= CC_|| N_|| H_|| I_||'00'|| to_char(k.rez) || kv_;
          znap_:= TO_CHAR(ABS(k.rcq));

             INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, rnk, nd, comm, acc)
             VALUES (k.nls, k.kv, dat_, ddd_||kodp_, znap_, nbuc_, k.rnk, k.nd, comm_, k.acc);

          if ddd_ = '121' and k.pd_0 =1 then

             INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, rnk, nd, comm, acc)
             VALUES (k.nls, k.kv, dat_, '120'||kodp_, znap_, nbuc_, k.rnk, k.nd, comm_, k.acc);
          end if;
       end if;

    -- на портфельной основе
       -- розмір повернення боргу по рівнях покриття боргу СС=22-27
       if H_ ='2' and k.nbs not like '9%' and
             not ( ddd_ between '130' and '138' )  then

          for u in ( select nvl(round(cr.zalq*100,0),0) zalq,
                            nvl(round(cr.rcq*100,0),0) rcq,
                            nvl(cr.rpb,0) rpb,
                            cr.pawn, nvl(p.s031,'90') s031_n
                       from rez_cr cr, cc_pawn p
                      where cr.fdat = z.fdat1
                        and cr.acc  = k.acc
                        and cr.pawn = p.pawn(+)
                   )
          loop
             if u.zalq !=0  then
                if    u.rpb > 100  then
                   CC_ := '27';
                elsif u.rpb > 80  then
                   CC_ := '26';
                elsif u.rpb > 60  then
                   CC_ := '25';
                elsif u.rpb > 40  then
                   CC_ := '24';
                elsif u.rpb > 20  then
                   CC_ := '23';
                else
                   CC_ := '22';
                end if;

                OO_ := u.s031_n;

                kodp_:= CC_|| N_|| H_|| I_|| OO_|| to_char(k.rez) || kv_;
                znap_:= TO_CHAR(ABS(u.zalq));

                INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, rnk, nd, comm, acc)
                VALUES (k.nls, k.kv, dat_, ddd_||kodp_, znap_, nbuc_, k.rnk, k.nd, comm_, k.acc);

                if ddd_ = '121' and k.pd_0 =1 then

                   INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, rnk, nd, comm, acc)
                   VALUES (k.nls, k.kv, dat_, '120'||kodp_, znap_, nbuc_, k.rnk, k.nd, comm_, k.acc);
                end if;
             end if;
          end loop;
       end if;

       -- розмір кредитного ризику за активами (CR) СС=30
       if k.crq <> 0
       then
          CC_ := '30';
          kodp_:= CC_|| N_|| H_|| I_||'00'|| to_char(k.rez) || kv_;
          znap_:= TO_CHAR(ABS(k.crq));

             INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, rnk, nd, comm, acc)
             VALUES (k.nls, k.kv, dat_, ddd_||kodp_, znap_, nbuc_, k.rnk, k.nd, comm_, k.acc);

          if ddd_ = '121' and k.pd_0 =1 then

             INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, rnk, nd, comm, acc)
             VALUES (k.nls, k.kv, dat_, '120'||kodp_, znap_, nbuc_, k.rnk, k.nd, comm_, k.acc);
          end if;
       end if;

       -- розмір резерву за активами СС=40
       if k.rezq <> 0
/*and ( (k.nbs like '9023%' and k.r013='9') or
                            (k.nbs like '9129%' and k.r013='1') or
                            (k.nbs not like '9023%' and k.nbs not like '9129%')
                          )   */
       then
          CC_ := '40';
          kodp_:= CC_|| N_|| H_|| I_||'00'|| to_char(k.rez) || kv_;
          znap_:= TO_CHAR(ABS(k.rezq));

             INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, rnk, nd, comm, acc)
             VALUES (k.nls, k.kv, dat_, ddd_||kodp_, znap_, nbuc_, k.rnk, k.nd, comm_, k.acc);

          if ddd_ = '121' and k.pd_0 =1 then

             INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, rnk, nd, comm, acc)
             VALUES (k.nls, k.kv, dat_, '120'||kodp_, znap_, nbuc_, k.rnk, k.nd, comm_, k.acc);
          end if;
       end if;

    end loop;

---------------------------------------------------------------    обработка счетов SNA
     for k in ( select /*+leading(nb) index(nb I3_NBU23REZ)*/
                       nb.acc, NVL(nb.rnk,0) RNK, nb.nbs, nb.nls, nb.kv,
                       nb.nd, nb.id,
                       NVL(round(nb.bvq*100,0),0) BV,
                       nb.s080 FIN, nvl(nb.pd_0,0) pd_0,
                       c.codcagent, c.custtype,
                       2-MOD(c.codcagent,2) REZ, NVL(trim(c.sed),'00') sed,
                       NVL(nb.s250_23,'0') s250, nb.tip
                  from nbu23_rez nb, customer c
                 where nb.fdat = z.fdat1
                   and nb.rnk = z.rnk1
                   and nb.nd = z.nd1
                   and nb.kat = z.kat1
                   and nb.kv = z.kv1
                   and nvl(nb.rz,0) = z.rz1
                   and nb.tip ='SNA'
                   and nb.rnk = c.rnk
     ) loop

         select max(ddd) into ddd_
           from kl_f3_29
          where kf='6B' and r020 like substr(k.nbs,1,3)||'%';

         kv_ := lpad(to_char(k.kv),3,'0');

         IF typ_>0 THEN
            nbuc_ := NVL(F_Codobl_Tobo (k.acc, typ_), nbuc1_);
         ELSE
            nbuc_ := nbuc1_;
         END IF;

         comm_ := 'ID='||k.id||' RNK='||k.rnk||' ND='||k.nd||' DDD='||ddd_||' TIP='||k.tip;

         CC_ := '40';

       if k.codcagent in (1, 2)               -- банки
       then
          N_ := '3';                          
       elsif k.codcagent in (3, 4)            -- юр.лица
       then

--   проверка наличия доп.параметра ISSPE
          begin
            select nvl(trim(value),'0')   into is_spe_
              from customerw
             where rnk =k.rnk
               and tag ='ISSPE';
          exception
            when others
               then is_spe_ :='0';
          end;

          if is_spe_ ='1'  then

             N_ := '5';
          else

             if k.nls like '21%'    or
                k.nls like '236%'   or
                k.nls like '237%'   or
                k.nls like '238%'   
             then
                     is_budg_ := 1;
             else    is_budg_ := 0;
             end if;

             -- временно на 01.02.2017
             -- для контрагента Министерство финансов ........
             if    is_budg_ !=0  or
                   ( mfo_ = 300465 and k.rnk in (90092301, 94312801) ) then

                  N_ := '4';                  --бюджет
             elsif k.sed = '56'  then
                  N_ := '6';                  --юр.лицо ОСББ
             else
                  N_ := '2';                  --юр.лицо
             end if;

          end if;

       elsif k.codcagent in (5,6) and k.sed <> '91'
       then
          N_ := '1';                          --физ.лицо
       elsif k.codcagent in (5,6) and k.sed = '91'
       then
          N_ := '1';                    --физ.лицо предприниматель (ранее =2)
       else

          if    k.custtype ='1'  then   N_ := '3';
          elsif k.custtype ='2'  then   N_ := '2';
          elsif k.custtype ='3'  then   N_ := '1';
          else
               N_ := 'X';
          end if;

       end if;

       H_ := '0';

       if k.pd_0 !=1 and k.s250 = '8' then
          H_ := '2';
       elsif k.pd_0 !=1  then
          H_ := '1';
       else
          H_ := '0';
       end if;

       I_ := k.fin;
       if ddd_ like '15%'  and  trim(I_) is null  then
          I_ := 'K';
       end if;
       -- для контрагента Министерство финансов ........
       if mfo_ = 300465 and k.rnk in (90092301, 94312801)
       then
          I_ := 'M';
       end if;

       if    k.pd_0 =1  and
             k.nbs in ('1500','1502','1508','1600','1607') 
       then  
           ddd_ :='120';   
           H_ := '0';

       end if;

          kodp_:= CC_|| N_|| H_|| I_||'00'|| to_char(k.rez) || kv_;
          znap_:= TO_CHAR(ABS(k.bv));

             INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, rnk, nd, comm, acc)
             VALUES (k.nls, k.kv, dat_, ddd_||kodp_, znap_, nbuc_, k.rnk, k.nd, comm_, k.acc);

          if ddd_ = '121' and k.pd_0 =1 then

             INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, rnk, nd, comm, acc)
             VALUES (k.nls, k.kv, dat_, '120'||kodp_, znap_, nbuc_, k.rnk, k.nd, comm_, k.acc);
          end if;

     end loop;

---------------------------------------------------------------    обработка счетов дисконтов
     for k in ( select /*+leading(nb) index(nb I3_NBU23REZ)*/
                       nb.acc, NVL(nb.rnk,0) RNK, nb.nbs, nb.nls, nb.kv,
                       nb.nd, nb.id, nvl(nb.r013,'0') r013,
                       NVL(round(nb.bvq*100,0),0) BV,
                       nb.s080 FIN, nvl(nb.pd_0,0) pd_0,
                       c.codcagent, c.custtype,
                       2-MOD(c.codcagent,2) REZ, NVL(trim(c.sed),'00') sed,
                       NVL(nb.s250_23,'0') s250, nb.tip
                  from nbu23_rez nb, customer c
                 where nb.fdat = z.fdat1
                   and nb.rnk = z.rnk1
                   and nb.nd = z.nd1
                   and nb.kat = z.kat1
                   and nb.kv = z.kv1
                   and nvl(nb.rz,0) = z.rz1
                   and nb.rnk = c.rnk
                   and nvl(nb.r013,'0') in ('1','2','3','4')
                   and nb.nbs in ( select r020 from kl_r020
                                    where txt like '%дисконт%'
                                      and d_close is null
                                       and trim(prem) ='КБ' )
     ) loop

         select max(ddd) into ddd_
           from kl_f3_29
          where kf='6B' and r020 like substr(k.nbs,1,3)||'%';

         kv_ := lpad(to_char(k.kv),3,'0');

         IF typ_>0 THEN
            nbuc_ := NVL(F_Codobl_Tobo (k.acc, typ_), nbuc1_);
         ELSE
            nbuc_ := nbuc1_;
         END IF;

         comm_ := 'ID='||k.id||' RNK='||k.rnk||' ND='||k.nd||' DDD='||ddd_||' TIP='||k.tip||' R013='||k.r013;

         CC_ := '40';

       if k.codcagent in (1, 2)               -- банки
       then
           N_ := '3';                          
       elsif k.codcagent in (3, 4)            -- юр.лица
       then

--   проверка наличия доп.параметра ISSPE
          begin
            select nvl(trim(value),'0')   into is_spe_
              from customerw
             where rnk =k.rnk
               and tag ='ISSPE';
          exception
            when others
               then is_spe_ :='0';
          end;

          if is_spe_ ='1'  then

             N_ := '5';
          else

             if k.nls like '21%'    or
                k.nls like '236%'   or
                k.nls like '237%'   or
                k.nls like '238%'   
             then
                     is_budg_ := 1;
             else    is_budg_ := 0;
             end if;

             -- для контрагента Министерство финансов ........
             if    is_budg_ !=0  or
                   ( mfo_ = 300465 and k.rnk in (90092301, 94312801) ) then

                  N_ := '4';                  --бюджет
             elsif k.sed = '56'  then
                  N_ := '6';                  --юр.лицо ОСББ
             else
                  N_ := '2';                  --юр.лицо
             end if;

          end if;

       elsif k.codcagent in (5,6) and k.sed <> '91'
       then
          N_ := '1';                          --физ.лицо
       elsif k.codcagent in (5,6) and k.sed = '91'
       then
          N_ := '1';                    --физ.лицо предприниматель (ранее =2)
       else

          if    k.custtype ='1'  then   N_ := '3';
          elsif k.custtype ='2'  then   N_ := '2';
          elsif k.custtype ='3'  then   N_ := '1';
          else
               N_ := 'X';
          end if;

       end if;

       H_ := '0';

       if k.pd_0 !=1 and k.s250 = '8' then
          H_ := '2';
       elsif k.pd_0 !=1  then
          H_ := '1';
       else
          H_ := '0';
       end if;

       I_ := k.fin;
       if ddd_ like '15%'  and  trim(I_) is null  then
          I_ := 'K';
       end if;
       -- для контрагента Министерство финансов ........
       if mfo_ = 300465 and k.rnk in (90092301, 94312801)
       then
          I_ := 'M';
       end if;

       if    k.pd_0 =1  and
             k.nbs in ('1500','1502','1508','1600','1607') 
       then  
           ddd_ :='120';   
           H_ := '0';

       end if;

          kodp_:= CC_|| N_|| H_|| I_||'00'|| to_char(k.rez) || kv_;
          znap_:= TO_CHAR(ABS(k.bv));

             INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, rnk, nd, comm, acc)
             VALUES (k.nls, k.kv, dat_, ddd_||kodp_, znap_, nbuc_, k.rnk, k.nd, comm_, k.acc);

     end loop;

   end loop;

   -- для балансовых рахунків з пасивними залишками
   --   змінюємо код CC  з 11 на 40

   for u in (
      select r.*, m.ostq-m.crdosq+m.crkosq ost_k
        from ( select *
                 from rnbu_trace
                where substr(nls, 1, 4) in (
                       '2307','2317','2327','2337','2347','2367','2377',
                       '2387','2397','2407','2417','2427','2437','2457',
                       '1535','1545','1405','1415','1435','1455',
                       '3007','3015','3107','3115' )
             ) r, accounts a, agg_monbals m
       where r.acc = a.acc
         and a.accc = m.acc
         and m.fdat = dato_
            )
   loop

       if u.ost_k >0   then
           update rnbu_trace
              set kodp = substr(u.kodp, 1,3) || '40' || substr(u.kodp, 6),
                  znap = (-1)* to_number(u.znap)
            where acc = u.acc
              and kodp = u.kodp and substr(u.kodp, 4,2)='11';

       end if;

   end loop;

       if dat_ =to_date('20180330','yyyymmdd')   then
           update rnbu_trace
              set kodp = substr(kodp, 1,3) || '40' || substr(kodp, 6),
                  znap = (-1)* to_number(znap)
            where acc = 1433732901 
              and kodp like '13011%';

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
                ( kodf, datf, kodp, znap, nbuc )
         VALUES ( kodf_, dat_, kodp_, znap_, nbuc_ );
   END LOOP;

   CLOSE basel;
-----------------------------------------------------------------------------
  logger.info ('P_F6B_NN: End for datf = '||to_char(dat_, 'dd/mm/yyyy'));
END p_f6b_nn;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F6B_NN.sql =========*** End *** 
PROMPT ===================================================================================== 