

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F1B.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F1B ***

  CREATE OR REPLACE PROCEDURE BARS.P_F1B (Dat_ DATE,
                                      sheme_ varchar2 default 'G') IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	Процедура формирования файла #1B для КБ
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
% VERSION     : 09.01.2013 (13/12/12,10/12/12,07/12/12,06/12/12,29/11/12)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
параметры: Dat_ - отчетная дата
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
r011_    Varchar2(1);
r013_    Varchar2(1);
kat23_   Varchar2(1) :='0';
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
sql_acc_ varchar2(2000):='';
sql_doda_ varchar2(200):='';
ret_	 number;
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

--- остатки счетов+месячные корректирующие обороты+
CURSOR SALDO IS
select distinct z.*, NVL(trim(nb.kat),'0')
from (
  select a.*, nvl(nvl(nvl(nvl(n.nd, b.nd), o.nd), w.nd), -1) nd
  from  (SELECT s.rnk, s.acc, s.nls, s.kv, s.fdat, s.nbs, s.ost, s.ostq,
          s.dos, s.dosq, s.kos, s.kosq,
          s.dos96, s.dosq96, s.kos96, s.kosq96,
          NVL(k.ddd,'000'), NVL(trim(sp.r011),'9'), NVL(trim(sp.r013),'9'),
          a.tobo, a.nms
   FROM  otcn_saldo s, otcn_acc a, kl_f3_29 k, specparam sp--, nd_acc n, nbu23_rez nb
   WHERE a.acc=s.acc
     and s.nbs = k.r020
     and (s.nbs <> '3548' or s.nbs = '3548' and k.r012=NVL(trim(sp.r011),'9'))
     and k.kf='1B'
     and s.acc = sp.acc(+)
     and ( (s.ost-s.dos96+s.kos96 <> 0 and
            s.nbs not in ('1500','1600','1607','1608','2600','2605','2607','2620','2625','2627','2650','2655','2657')) OR
           (s.ost-s.dos96+s.kos96 < 0 and
            s.nbs in ('1500','1600','1607','1608','2600','2605','2607','2620','2625','2627','2650','2655','2657'))
         )) a
     left outer join (select n.acc, max(n.nd) nd
                      from nd_acc n, cc_deal e
                      WHERE e.sdate <= Dat_
                        --AND (e.sos > 9 AND e.sos <= 15
                        --     OR e.wdate >= Dat_ )
                        --AND e.vidd > 1500 AND e.vidd < 1600
                        AND e.nd = n.nd
                      group by n.acc ) n
     on (a.acc = n.acc)
     left outer join bpk_acc b
     on (a.acc in (b.ACC_PK, b.ACC_OVR, b.ACC_3570, b.ACC_2208, b.ACC_2207, b.ACC_3579, b.ACC_2209, b.ACC_9129))
     left outer join (select acc, nd from acc_over where sos<>1) o
     on (a.acc = o.acc)
     left outer join w4_acc w
     on (a.acc in (w.ACC_PK, w.ACC_OVR, w.ACC_9129, w.ACC_3570, w.ACC_2208, w.ACC_2627, w.ACC_2207, w.ACC_3579,
        w.ACC_2209, w.ACC_2625X, w.ACC_2627X, w.ACC_2625D, w.ACC_2203))) z,
        (select * from nbu23_rez where fdat = dat1_) nb
 where z.nd = nb.nd(+)
   and z.rnk = nb.rnk(+) ;

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

Dat1_  := TRUNC(add_months(Dat_,1),'MM');
Datnp_ := TRUNC(Dat_,'MM');

-- определение кода МФО или кода области для выбранного файла и схемы
p_proc_set(kodf_,sheme_,nbuc1_,typ_);

sql_acc_ := 'select distinct r020 from kl_f3_29 where kf=''1B''';
ret_ := f_pop_otcn(Dat_, 3, sql_acc_);

-- выполняем наполнение таблицы NBU23_REZ для всех кроме банка Надра
if mfou_ not in (300465, 380764) then
   -- вызов процедуры наполнения таблицы NBU23_REZ (резерв по постанове 23)
   z23.rez_23(TRUNC(Dat1_,'MM'));
end if;
-------------------------------------------------------------------
--- остатки
OPEN SALDO;
LOOP
   FETCH SALDO INTO   rnk_, acc_, nls_, kv_, data_, nbs_, Ostn_, Ostq_,
                      Dos_, Dosq_, Kos_, Kosq_,
                      Dos96_, Dosq96_, Kos96_, Kosq96_,
                      ddd_, r011_, r013_, tobo_, nms_, nd_, kat23_ ;
   EXIT WHEN SALDO%NOTFOUND;

   comm_ := '';
   comm_ := substr(comm_||tobo_||'  '||nms_||'  '||'R011='||r011_||'  '||'R013='||r013_, 1,200);

   IF kv_ <> 980 THEN
      se_:=Ostq_-Dosq96_+Kosq96_;
   ELSE
      se_:=Ostn_-Dos96_+Kos96_;
   END IF;

   IF se_ <> 0  THEN

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

      if kat23_ = '0' then
         BEGIN
            select NVL(trim(kat),'0')
               into kat23_
            from nbu23_rez
            where fdat = dat1_
              and rnk = rnk_
              and trim(nls) = nls_
              and kv = kv_
              and rownum=1;
         EXCEPTION WHEN NO_DATA_FOUND THEN
            --BEGIN
            --   select NVL(trim(kat),'0')
            --      into kat23_
            --   from nbu23_rez
            --   where fdat = dat1_
            --     and rnk = rnk_
            --     and trim(nls) like substr(nls_,1,3)||'__'||substr(nls_,6,9)||'%'
            --     and kv = kv_
            --     and rownum=1;
            --EXCEPTION WHEN NO_DATA_FOUND THEN
            --   NULL;
            --END;
            NULL;
         END;
      end if;

      if ddd_ in ('311','312') then   --and kat23_ = '0' then
         BEGIN
            select NVL(trim(kat),'0')
               into kat23_
            from acc_deb_23
            where acc = acc_;
         EXCEPTION WHEN NO_DATA_FOUND THEN
            NULL;
         END;
      end if;

      if kat23_ = '0' then
         BEGIN
            select NVL(trim(kat),'0')
               into kat23_
            from acc_fin_obs_kat
            where acc = acc_
              and rownum=1;
         EXCEPTION WHEN NO_DATA_FOUND THEN
            NULL;
         END;
      end if;

      kodp_:= ddd_ || kat23_ ;
      znap_:= TO_CHAR(0 - se_);

      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, rnk, nd, acc, comm)
      VALUES (nls_, kv_, data_, kodp_, znap_, nbuc_, rnk_, nd_, acc_, comm_);

   end if;

END LOOP;
CLOSE SALDO;
---------------------------------------------------------------------------
-- Обработка счетов начисленных процентов по овердрафтам "
-- "категорiю якостi" будем вычислять по основному счету
for k in ( select * from rnbu_trace
           where (nls like '26_7%' or nls like '8026%')
         )
     loop

        nbs_ := substr(k.nls,1,4);

        BEGIN
           SELECT i.acc, a.nls
             INTO acco_, nls_
           FROM int_accn i, accounts a
           WHERE i.acra = k.acc
             AND ID = 0
             AND i.acc = a.acc
             AND a.nbs LIKE SUBSTR (nbs_, 1, 3) || '%'
             AND a.nbs <> nbs_;

            IF acco_ IS NOT NULL
            THEN
               BEGIN
                  select substr(kodp,4,1)
                     into kat23_
                  from rnbu_trace
                  where acc=acco_;
               EXCEPTION WHEN NO_DATA_FOUND THEN
                  NULL;
               END;
            END IF;

            comm_ := substr('ОВЕРДРАФТЫ осн.счет = '||nls_||' KV = '||k.kv||' категорiя = '||kat23_, 1,200);

            kodp_:= substr(k.kodp,1,3) || kat23_ ;

            update rnbu_trace set kodp=kodp_, comm=comm_
            where acc=k.acc;

        EXCEPTION
           WHEN NO_DATA_FOUND
           THEN
           NULL;
        END;

     end loop;
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
                  into kat23_, acc_, kv_, nls_, nbs_, nms_, tobo_, ostq_, accc_, nlsr_, nbsr_, id_, nd_
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

              if kat23_ = '0' then
                 BEGIN
                    select NVL(trim(kat),'0')
                       into kat23_
                    from nbu23_rez
                    where fdat = dat1_
                      and ddd in ('211','212')
                      and nls = nls_
                      and kv  = kv_;
                 EXCEPTION WHEN NO_DATA_FOUND THEN
                    NULL;
                 END;
              end if;

              kodp_:= substr(j.kodp,1,3) || kat23_ ;
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
-- наполнение таблицы ACC_NLO ACC счетов с нулевыми категориями
for k in ( select acc
           from rnbu_trace
           where kodp like '___0%'
             and substr(kodp,1,3) not in ('116','126','127','128','213','214','313','314')
         )

     loop

     UPDATE acc_nlo SET acc=k.acc
     WHERE acc = k.acc;

     IF SQL%ROWCOUNT = 0 THEN
        INSERT INTO ACC_NLO ( ACC ) VALUES  (k.acc);
     END IF;

     end loop;


--insert into acc_nlo
--select acc from
--rnbu_trace
--where kodp like '___0%'
--  and substr(kodp,1,3) not in ('116','126','127','128','213','214','313','314');
---------------------------------------------------------------------------
-- сума резерву
for k in (select nb.rnk, nb.nls, nb.kv, nb.nd, nb.id, NVL(trim(nb.kat),'0') kat,
                 NVL(trim(nb.dd),'2') dd, round(nb.rezq*100,0) rezq,
                 NVL(nb.ddd,'000') DDD,
                 DECODE(substr(br.b040,9,1),'2',substr(br.b040,15,2),'0',substr(br.b040,4,2),substr(br.b040,10,2)) nbuc
          from nbu23_rez nb, branch br
          where nb.fdat = dat1_ --to_date('01112012','ddmmyyyy')
            and nb.rezq <> 0
            and nb.branch = br.branch
         )

    loop

       comm_ := 'ID='||k.id||' RNK='||k.rnk||' ND='||k.nd||' DDD='||k.ddd;

       if k.ddd in ('111','112','113','114','115')
       then
          ddd_ := '116';
       elsif k.ddd in ('121') or (k.ddd in ('124','125') and k.dd = '1') then
          ddd_ := '126';
       elsif k.ddd in ('122') or (k.ddd in ('124','125') and k.dd = '2') then
          ddd_ := '127';
       elsif k.ddd in ('123') or (k.ddd in ('124','125') and k.dd = '3')then
          ddd_ := '128';
      elsif k.ddd in ('211') then
          ddd_ := '213';
      elsif k.ddd in ('212') then
          ddd_ := '214';
      elsif k.ddd in ('311') then
          ddd_ := '313';
      elsif k.ddd in ('312') then
          ddd_ := '314';
      else
         null;
      end if;

      kodp_:= ddd_ || k.kat ;
      znap_:= TO_CHAR(ABS(k.rezq));

      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, rnk, nd, comm)
      VALUES (k.nls, k.kv, dat_, kodp_, znap_, k.nbuc, k.rnk, k.nd, comm_);

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
END p_f1b;
/
show err;

PROMPT *** Create  grants  P_F1B ***
grant EXECUTE                                                                on P_F1B           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_F1B           to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F1B.sql =========*** End *** ===
PROMPT ===================================================================================== 
