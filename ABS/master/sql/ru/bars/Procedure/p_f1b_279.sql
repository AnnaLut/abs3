

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F1B_279.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F1B_279 ***

  CREATE OR REPLACE PROCEDURE BARS.P_F1B_279 (Dat_ DATE,
                                      sheme_ varchar2 default 'G') IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :    Процедура формирования файла #1B для КБ
% COPYRIGHT   :    Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
% VERSION     : 30/01/2013 (09/01/13,13/12/12,10/12/12,07/12/12,06/12/12)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
параметры: Dat_ - отчетная дата
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
29/01/2013 - данный вариант выбирает данные по счетам резерва из таблицы
             TMP_REZ_RISK (расчет резерва по постанове 279)
             код пользователя из REZ_PROTOCOL выбираем за 30.11.2012
09/01/2013 - вызываем z23.rez_23(TRUNC(Dat1_,'MM')) вместо
             rez_23(TRUNC(Dat1_,'MM'))
13/12/2012 - для показателей резерва выбираем DISTINCT R020 из KL_F3_29
             т.к. для 3548 существует несколько строк
10/12/2012 - убрал очистку таблицы ACC_NLO которую добавили 07.12.2012
07/12/2012 - в некоторых выборках для табл. NBU23_REZ отсутсвовало условие
             для даты формирования "fdat = dat1_". Добавлено.
06/12/2012 - для ЦБ выбираем дочерние счета и при отсутствии в CP_DEAL
29/11/2012 - для счетов Деб.зажолженности "категорiю якостi" дополнительно
             выбираем из табл. ACC_DEB_23
28/11/2012 - по ЦБ будем выбирать дочерние счета вместо родительских т.к.
             "категорiя якостi" заполнена по ним
27/11/2012 - по счетам БПК не находились счета прострочк, процентов и другие
             производные счета и категория качества была = 0
23.11.2012 - добавил в курсоре DISTINCT т.к. возникало
             задвоение по BPK счета 2202, 2208 один и тотже RNK и ND
21.11.2012 - отключил вызов процедуры REZ_23 (наполнение табл.NBU23_REZ)
             т.к. будет вызов процедуры будет из меню и затем корректировка
             данной таблицы
18.11.2012 - показатели для дисконта формируем с минусом
              в RNBU_TRACE формируем ND, ACC
16.11.2012 - добавил обработку таблицы ACC_FIN_OBS_KAT для счетов
15.11.2012 - выполняем наполнение таблицы NBU23_REZ для всех банков кроме
             банка НАДРА
14.11.2012 - первая версия
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
kodf_    varchar2(2):='1B';
acc_     Number;
acc1_    Number;
acc2_    Number;
accc_    Number;
acco_    Number;
id_      Varchar2(20);
dk_      Varchar2(2);
nbs_     Varchar2(4);
nbs1_    Varchar2(4);
nls_     Varchar2(15);
nlsr_    Varchar2(15);
nbsr_    Varchar2(4);
Dat1_    Date;
data_    Date;
Datnp_   Date;
kv_      SMALLINT;
s080_    Varchar2(1);
r011_    Varchar2(1);
r013_    Varchar2(1);
s180_    Varchar2(1);
kat23_   Varchar2(1) :='0';
vidd_    Number;
nd_      Number;
Ostn_    DECIMAL(24);
Ostq_    DECIMAL(24);
Dos_     DECIMAL(24);
Dosq_    DECIMAL(24);
Kos_     DECIMAL(24);
Kosq_    DECIMAL(24);
Dos96_   DECIMAL(24);
Kos96_   DECIMAL(24);
Dosq96_  DECIMAL(24);
Kosq96_  DECIMAL(24);
Doszg_   DECIMAL(24);
Koszg_   DECIMAL(24);
Dos96zg_ DECIMAL(24);
Kos96zg_ DECIMAL(24);
Dos99zg_ DECIMAL(24);
Kos99zg_ DECIMAL(24);
sn_      DECIMAL(24);
se_      DECIMAL(24);
kodp_    Varchar2(14);
kodp1_   Varchar2(14);
znap_    Varchar2(30);
ddd_     Varchar(3);
userid_  Number;
rezid_   Number;
sql_acc_ varchar2(2000):='';
sql_doda_ varchar2(200):='';
ret_     number;
rnk_     number;
nbuc1_   varchar2(20);
nbuc_    varchar2(20);
typ_     Number;
mfo_     Number;
mfou_    Number;
tobo_    accounts.tobo%TYPE;
nms_     otcn_acc.nms%TYPE;
comm_    rnbu_trace.comm%TYPE;
daos_    Date;
add_     NUMBER;
gr1_     Varchar2(1);  -- код группы банков из RCUKRU поле GR1
country_ Number;

--- остатки счетов+месячные корректирующие обороты+
CURSOR SALDO IS
  SELECT s.rnk, s.acc, s.nls, s.kv, s.fdat, s.nbs, s.ost, s.ostq,
          s.dos, s.dosq, s.kos, s.kosq,
          s.dos96, s.dosq96, s.kos96, s.kosq96,
          NVL(k.ddd,'000'), NVL(trim(sp.r011),'9'), NVL(trim(sp.r013),'9'), NVL(trim(sp.s080),'0'),
          a.tobo, a.nms
   FROM  otcn_saldo s, otcn_acc a, kl_f3_29 k, specparam sp
   WHERE a.acc=s.acc
     and a.nbs = k.r020
     and (a.nbs <> '9129' or a.nbs = '9129' and NVL(trim(sp.r013),'9')='1')
     and (a.nbs <> '3548' or a.nbs = '3548' and k.r012=NVL(trim(sp.r011),'9'))
     and k.kf='1B'
     and s.acc = sp.acc(+)
     and ( (s.ost-s.dos96+s.kos96 <> 0 and
            a.nbs not in ('1500','1600','1607','1608','2600','2605','2607','2620','2625','2627','2650','2655','2657')) OR
           (s.ost-s.dos96+s.kos96 < 0 and
            a.nbs in ('1500','1600','1607','1608','2600','2605','2607','2620','2625','2627','2650','2655','2657'))
         );

CURSOR BaseL IS
   SELECT kodp, nbuc, SUM(znap)
   FROM rnbu_trace
   WHERE userid=userid_
   GROUP BY kodp, nbuc;

BEGIN
-------------------------------------------------------------------
userid_ := user_id;

EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';
--EXECUTE IMMEDIATE 'TRUNCATE TABLE ACC_NLO';
-------------------------------------------------------------------
-- свой МФО
   mfo_ := F_Ourmfo ();

-- МФО "родителя"
   BEGIN
      SELECT NVL(trim(mfou), mfo_)
        INTO mfou_
      FROM BANKS
      WHERE mfo = mfo_;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         mfou_ := mfo_;
   END;

BEGIN
   select userid
      into rezid_
   from rez_protocol
   where dat = to_date('30112012','ddmmyyyy');
EXCEPTION WHEN NO_DATA_FOUND THEN
   rezid_ := userid_;
END;


Dat1_  := TRUNC(add_months(Dat_,1),'MM');
Datnp_ := TRUNC(Dat_,'MM');

-- определение кода МФО или кода области для выбранного файла и схемы
p_proc_set(kodf_,sheme_,nbuc1_,typ_);

sql_acc_ := 'select distinct r020 from kl_f3_29 where kf=''1B''';
ret_ := f_pop_otcn(Dat_, 3, sql_acc_);

-- выполняем наполнение таблицы NBU23_REZ для всех кроме банка Надра
--if mfou_ not in (300465, 380764) then
   -- вызов процедуры наполнения таблицы NBU23_REZ (резерв по постанове 23)
--   z23.rez_23(TRUNC(Dat1_,'MM'));
--end if;
-------------------------------------------------------------------
--- остатки
OPEN SALDO;
LOOP
   FETCH SALDO INTO   rnk_, acc_, nls_, kv_, data_, nbs_, Ostn_, Ostq_,
                      Dos_, Dosq_, Kos_, Kosq_,
                      Dos96_, Dosq96_, Kos96_, Kosq96_,
                      ddd_, r011_, r013_, s080_, tobo_, nms_ ;
   EXIT WHEN SALDO%NOTFOUND;

   comm_ := '';
   comm_ := substr(comm_||tobo_||'  '||substr(nms_,1,50)||'  '||'S080='||s080_, 1,100);

   IF kv_ <> 980 THEN
      se_:=Ostq_-Dosq96_+Kosq96_;
   ELSE
      se_:=Ostn_-Dos96_+Kos96_;
   END IF;

   IF se_ <> 0  THEN

      nd_ := null;
      acc2_ := null;

      if nbs_ in ('2600', '2607', '2620', '2627') then --овердрафты
         IF nbs_ in ('2607','2627')
         THEN
            BEGIN
               SELECT i.acc
                  INTO acco_
               FROM int_accn i, accounts a
               WHERE i.acra = acc_
                 AND ID = 0
                 AND i.acc = a.acc
                 AND a.nbs LIKE SUBSTR (nbs_, 1, 3) || '%'
                 AND a.nbs <> nbs_;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  acco_ := NULL;
            END;
         else
            acco_ := acc_;
         END IF;

         begin
           select nd
           into nd_
           from acc_over
           where acco = acco_ and
                 NVL (sos, 0) <> 1;
         exception
           when NO_DATA_FOUND THEN
             begin
               select max(nd)
               into nd_
               from acc_over_archive
               where acco = acco_;
             exception
               when NO_DATA_FOUND THEN
                 nd_ := NULL;
             END;
         END;
      elsif nbs_ like '1%' then -- межбанк
          if nbs_ not in ('1590','1592') then
             BEGIN
                SELECT n.nd, c.vidd
                   INTO nd_, vidd_
                FROM nd_acc n, cc_deal c
                WHERE n.acc = acc_
                  AND n.nd = c.nd
                  AND (c.sdate, c.nd) = (SELECT MAX (p.sdate), MAX (p.nd)
                                         FROM nd_acc a, cc_deal p
                                         WHERE a.acc = acc_
                                           AND a.nd = p.nd
                                           AND dat_ between p.sdate and p.wdate);
             EXCEPTION WHEN NO_DATA_FOUND THEN
                 BEGIN
                    SELECT n.nd, c.vidd
                       INTO nd_, vidd_
                    FROM nd_acc n, cc_deal c
                    WHERE n.acc = acc_
                      AND n.nd = c.nd
                      AND (c.sdate, c.nd) = (SELECT MAX (p.sdate), MAX (p.nd)
                                             FROM nd_acc a, cc_deal p
                                             WHERE a.acc = acc_
                                               AND a.nd = p.nd);
                 EXCEPTION WHEN NO_DATA_FOUND THEN
                    nd_ := NULL;
                    vidd_ := NULL;
                 END;
             end;
          end if;
      else -- все остальные
          if nbs_ not in ('2400','2401') then
             BEGIN
                SELECT n.nd, c.vidd
                   INTO nd_, vidd_
                FROM nd_acc n, cc_deal c
                WHERE n.acc = acc_
                  AND n.nd = c.nd
                  AND (c.sdate, c.nd) = (SELECT MAX (p.sdate), MAX (p.nd)
                                         FROM nd_acc a, cc_deal p
                                         WHERE a.acc = acc_
                                           AND a.nd = p.nd
                                           AND p.sdate <= dat_);
             EXCEPTION WHEN NO_DATA_FOUND THEN
                nd_ := NULL;
                vidd_ := NULL;
             END;
          end if;
      end if;

      P_GET_S080_S180(dat_, mfou_, acc_, nls_, kv_, acc2_, nd_, vidd_, rezid_, comm_, s080_, s180_);

      if nbs_ = '3548'
      then
         begin
            select ddd
               into ddd_
            from kl_f3_29
            where kf='1B'
              and r020=nbs_
              and r012=r011_;
          EXCEPTION WHEN NO_DATA_FOUND THEN
            null;
         END;
      end if;

      if nbs_ ='1508'
      then
         BEGIN
            SELECT a.nbs
              INTO nbs1_
              FROM int_accn i, accounts a
             WHERE i.acra = acc_
               AND ID = 0
               AND i.acc = a.acc
               AND a.nbs <> nbs_;

            IF nbs1_ = '1500'
            THEN
               ddd_ := '112';
            END IF;
         EXCEPTION WHEN NO_DATA_FOUND THEN
            NULL;
         END;
      end if;

      if typ_>0 then
         nbuc_ := nvl(f_codobl_tobo(acc_,typ_),nbuc1_);
      else
         nbuc_ := nbuc1_;
      end if;

      if ddd_ in ('113','114','115') then
         ddd_ := to_char(to_number(ddd_) -1);
      end if;

      -- для корреспонденских счетов 1500 формируем коды 411-419
      if ddd_ = '112' and (nbs_ like '1500%' or nbs_ like '1508%') then
         /*
         BEGIN
         select r.gr1
            into gr1_
         from rcukru r, custbank cu
         where cu.rnk = rnk_
           and cu.mfo = r.mfo;
         EXCEPTION WHEN NO_DATA_FOUND THEN
            gr1_ := '9';
         END;
         ddd_ := '41' || gr1_;
         */
         BEGIN
            select k.country, k.grp
               into country_, gr1_
            from country k, customer c
            where c.rnk = rnk_
              and k.country = c.country;
         EXCEPTION WHEN NO_DATA_FOUND THEN
               gr1_ := '9';
         END;
         if country_ = 804 then
            ddd_ := '419' ;
         else
            ddd_ := '41' || gr1_;
         end if;

      end if;

      --if ((nbs_ like '___8%' and r013_= '3') or (nbs_ like '___9%' and r013_='1'))
      --   and s080_ = '0'
      --then
      --   s080_ := '1';
      --end if;

      --if ((nbs_ like '___8%' and r013_= '4') or
      --    (nbs_ like '___9%' and r013_ in ('2','3')))
      --   and s080_ = '0'
      --then
      --   s080_ := '5';
      --end if;

      kodp_:= ddd_ || s080_ ;
      znap_:= TO_CHAR(0 - se_);

      -- коррсчета без просроченных процентов
      if ddd_ like '41%' then
         kodp_:= ddd_ || '0' ;
         INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, rnk, nd, acc, comm)
         VALUES (nls_, kv_, data_, kodp_, znap_, nbuc_, rnk_, nd_, acc_, comm_);
      end if;

      -- Межбанк без начисленных и просроченных процентов
      if ddd_ like '11%' and ddd_ not like '112%' and
         nbs_ not like '1__8%' and nbs_ not like '1__9%' and
         nbs_ not like '1607%'
      then
         INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, rnk, nd, acc, comm)
         VALUES (nls_, kv_, data_, kodp_, znap_, nbuc_, rnk_, nd_, acc_, comm_);
      end if;

      -- Счета клиентов без начисленных и просроченных процентов
      if ddd_ like '12%' and nbs_ not like '2__8%' and nbs_ not like '2__9%' and
         nbs_ not in ('2607','2627','2657') and
         nbs_ not like '357%'
      then
         INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, rnk, nd, acc, comm)
         VALUES (nls_, kv_, data_, kodp_, znap_, nbuc_, rnk_, nd_, acc_, comm_);
      end if;

      -- просроченные начисленные проценты  Межбанк
      if ddd_ like '11%' and (nbs_ like '1__8%' OR nbs_ like '1__9%' OR nbs_ like '1607%' ) then
         kodp_:= '511' || '0';  --s080_ ;
         --znap_:= TO_CHAR(0 - se_);

         INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, rnk, nd, acc, comm)
         VALUES (nls_, kv_, data_, kodp_, znap_, nbuc_, rnk_, nd_, acc_, comm_);
      end if;

      -- просроченные начисленные проценты  клиенты
      if ddd_ like '12%' and (nbs_ like '2__8%' OR nbs_ like '2__9%' OR
                              nbs_ in ('2607','2627','2657')) and
         nbs_ not like '9129%'
     then
         kodp_:= '512' || '0';  --s080_ ;
         --znap_:= TO_CHAR(0 - se_);

         INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, rnk, nd, acc, comm)
         VALUES (nls_, kv_, data_, kodp_, znap_, nbuc_, rnk_, nd_, acc_, comm_);
      end if;

      -- просроченные начисленные проценты  другие операции
      if ddd_ like '31%' and nbs_ like '357%'
      then
         kodp_:= '513' || '0';  --s080_ ;
         --znap_:= TO_CHAR(0 - se_);

         INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, rnk, nd, acc, comm)
         VALUES (nls_, kv_, data_, kodp_, znap_, nbuc_, rnk_, nd_, acc_, comm_);
      end if;

      -- для счетов дебиторской задолженности формируем коды 321-324
      if ddd_ like '31%' and nbs_ not like '357%' then
         kodp_ := '32' || s080_ || '0';  --s080_;
         --znap_:= TO_CHAR(0 - se_);

         INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, rnk, nd, acc, comm)
         VALUES (nls_, kv_, data_, kodp_, znap_, nbuc_, rnk_, nd_, acc_, comm_);
      end if;
   end if;

END LOOP;
CLOSE SALDO;
---------------------------------------------------------------------------
-------------------------------------------------------------------------------------------
-- Обработка счетов по ЦБ (выбираем дочерние счета т.к. "категорiя якостi" заполнена по ним
for j in ( select * from rnbu_trace
           where substr(kodp,1,3) in ('211','212')
         )
     loop

        for k in ( select a.acc, a.kv, a.nls NLSD, a.nbs NBSD, a.nms, a.tobo,
                       fostq(a.acc, Dat_) OST,
                       a.ACCC, r.nls NLSR, r.nbs NBSR
                   from accounts a, accounts r
                   where r.acc = j.acc
                     and a.accc = r.acc
                     and fostq(a.acc, Dat_)<> 0
                 )

            loop

               BEGIN
                  select NVL(k.kat23,'0'), k.acc, k.kv, k.NLSD, k.NBSD, k.nms, k.tobo,
                     k.OST,
                     k.ACCC, k.NLSR, k.NBSR , 'CACP'||NVL(d.ref,-1), NVL(d.ref,-1) ND
                  into s080_, acc_, kv_, nls_, nbs_, nms_, tobo_, ostq_, accc_, nlsr_, nbsr_, id_, nd_
                 from
                  (
                   select a.acc
                   from accounts a
                   where a.acc = k.acc
                     and fostq(a.acc, Dat_)<> 0) a
                     left outer join cp_deal d
                     on (a.acc in
                       (d.acc, NVL(d.accd, d.acc), NVL (d.accp, d.acc), NVL (d.accr, d.acc), NVL (d.accr2, d.acc), NVL (d.accs, d.acc) ))
                     left outer join cp_kod k
                     on (d.id = k.id)
                     and rownum = 1;

              comm_ := substr('ЦБ '||tobo_||'  '||nms_||' REF= '||nd_||' NLSR= '||nlsr_, 1,200);

              if s080_ = '0' then
                 BEGIN
                    select NVL(trim(s080),'0')
                       into s080_
                    from specparam
                    where acc = k.acc(+);
                 EXCEPTION WHEN NO_DATA_FOUND THEN
                    s080_ := '0';
                 END;
              end if;

              kodp_:= substr(j.kodp,1,3) || s080_ ;
              znap_:= TO_CHAR(0 - ostq_);

              INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, rnk, nd, acc, comm)
              VALUES (nls_, kv_, dat_, kodp_, znap_, j.nbuc, j.rnk, nd_, acc_, comm_);
           EXCEPTION WHEN NO_DATA_FOUND THEN
              NULL;
           END;

        end loop;

     end loop;

delete from rnbu_trace
where substr(kodp,1,3) in ('211','212')
  and acc in (select accc
              from accounts
              where accc is not null
                and substr(nls,1,2) in ('14','30','31','32'));
-------------------------------------------------------------------------------------------
-- розрахункова сума резерву iз TMP_REZ_RISK
for k in (select t.acc, t.nls, t.kv, t.dat, t.szq, t.sz, NVL(gl.p_icurval(t.kv, t.sz1, t.dat),0) sz1,
                 t.rnk, t.nmk, t.nd nd, t.tobo, t.s080_name,
                 t.cc_id, t.custtype, kl.ddd,
                 DECODE(substr(br.b040,9,1),'2',substr(br.b040,15,2),'0',substr(br.b040,4,2),substr(br.b040,10,2)) nbuc,
                 NVL(sp.s080,'0') S080
          from tmp_rez_risk t, tobo br, kl_f3_29 kl, specparam sp
          where t.dat = dat_ --to_date('29122012','ddmmyyyy')
            and substr(t.nls,1,4) = kl.r020
            and kl.kf = '1B'
            and t.acc = sp.acc(+)
            and t.tobo = br.tobo
            and t.id = rezid_
         )

    loop

       comm_ := 'CC_ID='||k.cc_id||' RNK='||k.rnk||' ND='||k.nd||' DDD='||k.ddd;
       s080_ := k.s080;

       BEGIN
          SELECT n.nd, c.vidd
             INTO nd_, vidd_
          FROM nd_acc n, cc_deal c
          WHERE n.acc = k.acc
            AND n.nd = c.nd
            AND (c.sdate, c.nd) = (SELECT MAX (p.sdate), MAX (p.nd)
                                   FROM nd_acc a, cc_deal p
                                   WHERE a.acc = k.acc
                                     AND a.nd = p.nd
                                     AND p.sdate <= dat_);
       EXCEPTION WHEN NO_DATA_FOUND THEN
          nd_ := NULL;
          vidd_ := NULL;
       END;

       P_GET_S080_S180(dat_, mfou_, k.acc, k.nls, k.kv, acc2_, nd_, vidd_, rezid_, comm_, s080_, s180_);

       --if s080_ = '9' then
       --   if (LOWER(k.s080_name) like 'сомнительные%' or
       --       k.s080_name like '%S270 = 08%' or
       --       LOWER(k.s080_name) like 'просроч.(>31д)%'
       --      )
       --   then
       --      s080_ := '5';
       --   else
       --      s080_ := '2';
       --   end if;
       --end if;

       if k.ddd in ('111','112','113','114','115') and k.nls not like '1500%'
       then
          ddd_ := '116';
       elsif k.ddd in ('112') and k.nls like '1500%' then
          ddd_ := '420';
       elsif k.ddd in ('121') and
             k.nls not like '21_8%' and
             k.nls not like '21_9%'
            or
            (k.ddd in ('124','125') and
             k.nls like '21%' and
             k.nls not like '21_8%' and
             k.nls not like '21_9%' and k.custtype = '2') then
          ddd_ := '126';
       elsif k.ddd in ('122') and
            k.nls not like '21%'   and
            k.nls not like '2__8%' and
            k.nls not like '2__9%' and
            k.nls not like '2607%' and
            k.nls not like '2657%'
            or
            (k.ddd in ('124','125') and
             k.nls not like '21%'   and
             k.nls not like '2__8%' and
             k.nls not like '2__9%' and
             k.nls not like '2607%' and
             k.nls not like '2657%' and k.custtype = '2') then
          ddd_ := '127';
       elsif k.ddd in ('123') and
            k.nls not like '21%'   and
            k.nls not like '2__8%' and
            k.nls not like '2__9%' and
            k.nls not like '2607%' and
            k.nls not like '2627%'
            or
           (k.ddd in ('124','125') and
            k.nls not like '21%'   and
            k.nls not like '2__8%' and
            k.nls not like '2__9%' and
            k.nls not like '2607%' and
            k.nls not like '2627%' and k.custtype = '3') then
          ddd_ := '128';
      elsif k.ddd in ('211') then
          ddd_ := '213';
      elsif k.ddd in ('212') then
          ddd_ := '214';
      elsif k.ddd in ('311') and k.nls not like '357%' then
          ddd_ := '325';
      elsif k.ddd in ('312') then
          ddd_ := '325';
      elsif k.ddd in ('311') and k.nls like '357%' then
          ddd_ := '514';
      elsif (k.nls like '2__8%' OR k.nls like '2__9%' OR
             k.nls like '2607%' OR k.nls like '2627%' OR
             k.nls like '2657%') and
             k.nls not like '9129%' then
          ddd_ := '514';
      else
         null;
      end if;

      if typ_>0 then
         nbuc_ := nvl(f_codobl_tobo(k.acc,typ_),nbuc1_);
      else
         nbuc_ := nbuc1_;
      end if;

      if ddd_ in ('325','420','514') then
         s080_ := '0';
      end if;

      if k.sz1 <> 0 then
         se_ := k.sz1;
      else
         se_ := k.szq;
      end if;

      if se_ <> 0 then
         kodp_:= ddd_ || s080_ ;
         znap_:= TO_CHAR(ABS(se_));

         INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, rnk, nd, comm)
         VALUES (k.nls, k.kv, dat_, kodp_, znap_, nbuc_, k.rnk, k.nd, comm_);
      end if;

    end loop;
---------------------------------------------------------------------------
DELETE FROM tmp_nbu where kodf=kodf_ and datf= dat_;
---------------------------------------------------
OPEN BaseL;
LOOP
   FETCH BaseL INTO  kodp_, nbuc_, znap_;
   EXIT WHEN BaseL%NOTFOUND;
   INSERT INTO tmp_nbu
        (kodf, datf, kodp, znap, nbuc)
   VALUES
        (kodf_, Dat_, kodp_, znap_, nbuc_);
END LOOP;
CLOSE BaseL;
----------------------------------------
END p_f1b_279;
/
show err;

PROMPT *** Create  grants  P_F1B_279 ***
grant EXECUTE                                                                on P_F1B_279       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_F1B_279       to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F1B_279.sql =========*** End ***
PROMPT ===================================================================================== 
