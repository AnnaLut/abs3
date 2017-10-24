

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F3C_NN.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F3C_NN ***

  CREATE OR REPLACE PROCEDURE BARS.P_F3C_NN (dat_ DATE ,
                                      sheme_ varchar2 default 'С')  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Процедура формирование файла #3С
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
%
% VERSION     : v.17.001     12.01.2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
параметры: dat_ - отчетная дата
           sheme_ - схема формирования

   Структура показателя    L DDD VVV

  1    L          1/4  (сумма/курс)
  2    DDD        код операции (210 покупка/220 продажа)
  5    VVV        R030 валюта

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 12.01.2017 формирование данных только по списку валют с изменившимся курсом
 29.09.2016 создание процедуры

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
kodf_       varchar2(2):='3C';
kodp_       varchar2(10);
znap_       varchar2(30);

fmt_        varchar2(20):='999990D0000';

userid_     number;
nbuc_       varchar2(20);
nbuc1_      varchar2(20);

typ_        number;
count_      number;
flag_       number;

DatP_        date; -- дата начала выходных дней, кот. предшествуют заданой дате
buf_        number;

mfo_        varchar2(15);
mfou_       varchar2(15);
vvv         varchar2(3);
kv_         number;
kv1_        number;
ref_        number;
dig_        number;
bsu_        number;

rate_o_     number;

branch_     varchar2(30);
branch_v    varchar2(30);
s_time      timestamp;
acc_        number;
nls_        varchar2(15);
kurs_       varchar2(200);
kurs1_      number(9,4);
data_       date;
datd_       date;
sum1_       number;
sum0_       number;
sun1_       number;
sun0_       number;

comm_       varchar2(200);
div_        number;
a_          varchar2(20);
b_          varchar2(20);

   TYPE     t_branch IS TABLE OF NUMBER(1) INDEX BY VARCHAR2(30);
   table_branch    t_branch;

--Валютообменные операции по кассе
CURSOR OPERVAL IS
select b.ref, b.acc, b.nls, b.kv, b.fdat, b.kurs, b.datd, b.branch,
   sum(b.ds), sum(b.ks),
   sum(b.pds2) dsq, sum(b.pks2) ksq
from
(select   --/*+parallel(o,16) parallel(v,16)*/
         a.acc, p.tt ptt, o.tt ott,
         a.nls, a.kv, o.fdat, p.ref,
         translate(w.value,',','.') kurs, p.datd, p.branch,
         decode (o2.dk, 0, o.s, 0) ds,
         decode (o2.dk, 1, o.s, 0) ks,
         decode(o2.dk,0,decode(p.tt,o.tt,decode(p.kv2,a.kv,p.s,p.s2),
         f_d3801(p.ref,o.tt,v.ACC3801,o2.dk,v.ACC_RRD,v.ACC_RRR)),0) pds2,
         decode(o2.dk,1,decode(p.tt,o.tt,decode(p.kv2,a.kv,p.s,p.s2),
         f_d3801(p.ref,o.tt,v.ACC3801,o2.dk,v.ACC_RRD,v.ACC_RRR)),0) pks2
from opldok o, vp_list v, opldok o2, accounts a, oper p, operw w
where o.fdat = dat_
      and o2.fdat = o.fdat
      and o.tt not in ('BAK')
      and o.sos=5
      and o.acc=v.ACC3800
      and o.ref=o2.ref
      AND o.dk != o2.dk
      AND o.tt = o2.tt
      AND o.stmt = o2.stmt
      and o2.acc=a.acc
      and a.nls like '100%'
      and a.kv=kv_ and ((p.kv != 980 and p.kv2=980) or
                        (p.kv=980 and p.kv2 != 980) or
                        (p.kv = p.kv2))
      and o.ref=p.ref
      and p.sos=5
      and p.nlsa not like '390%' and p.nlsb not like '390%'
      and ((o2.tt = p.tt and NOT exists (select 1
                  from operw z
                  where p.ref=z.ref and
                        z.tag in ('D#73','73'||o2.tt) and
                        substr(z.value,1,3) in ('220','221','222','223','270',
                                                '321','322','325','323','370')))
           OR
           (o2.tt != p.tt and NOT exists (select 1
                  from operw z
                  where p.ref=z.ref and
                        z.tag = '73'||o2.tt and
                        substr(z.value,1,3) in ('220','221','222','223','270',
                                                '321','322','325','323','370'))))
      and p.ref=w.ref(+)
      and w.tag(+) LIKE 'KURS%'
  and exists ( select 1
                 from cur_rate_kom_upd k
                where k.vdate = dat_
                  and (  instr(k.comments,'покупки') !=0
                      or instr(k.comments,'продажи') !=0 )
                  and k.kv = kv_
                  and k.branch = p.branch )
union
select  --/*+parallel(o,16) parallel(v,16)*/
     a.acc, p.tt ptt, o.tt ott,
     a.nls,
     a.kv, o.fdat, p.ref,
     null kurs, p.datd, p.branch,
         decode (o2.dk, 0, o.s, 0) ds,
         decode (o2.dk, 1, o.s, 0) ks,
         decode(o2.dk,0,f_d3801(p.ref,o.tt,v.ACC3801,o2.dk,v.ACC_RRD,v.ACC_RRR),0) pds2,
         decode(o2.dk,1,f_d3801(p.ref,o.tt,v.ACC3801,o2.dk,v.ACC_RRD,v.ACC_RRR),0) pks2
from opldok o, vp_list v, opldok o2, accounts a, oper p, operw w
where o.fdat = dat_
      and o2.fdat = o.fdat
      and o.tt not in ('BAK')
      and o.sos=5
      and o.acc=v.ACC3800
      and o.ref=o2.ref
      AND o.dk != o2.dk
      AND o.tt = o2.tt
      AND o.stmt = o2.stmt
      and o2.acc=a.acc
      and a.nls like '100%'
      and a.kv=kv_ and ((p.kv != p.kv2 and p.kv != 980 and p.kv2 != 980))
      and o.ref=p.ref
      and p.sos=5
      and p.nlsa not like '390%' and p.nlsb not like '390%'
  and exists ( select 1
                 from cur_rate_kom_upd k
                where k.vdate = dat_
                  and (  instr(k.comments,'покупки') !=0
                      or instr(k.comments,'продажи') !=0 )
                  and k.kv = kv_
                  and k.branch = p.branch )
      and ((o2.tt = p.tt and NOT exists (select 1
                  from operw z
                  where p.ref=z.ref and
                        z.tag in ('D#73','73'||o2.tt) and
                        substr(z.value,1,3) in ('220','221','222','223','270',
                                                '321','322','325','323','370')))
           OR
           (o2.tt != p.tt and NOT exists (select 1
                  from operw z
                  where p.ref=z.ref and
                        z.tag = '73'||o2.tt and
                        substr(z.value,1,3) in ('220','221','222','223','270',
                                                '321','322','325','323','370'))))
      and p.ref=w.ref(+)
      and w.tag(+) LIKE 'KURS%') b
where b.pds2 != 0 or b.pks2 != 0
group by b.ref, b.acc, b.nls, b.kv, b.fdat, b.kurs, b.datd, b.branch;

----------------------------------------------------
--                список валют с последними курсами
CURSOR tval IS
    SELECT  t.kv, POWER(10,t.dig), r.bsum, r.rate_o
      FROM tabval t, cur_rates r   -- cur_rates$base
     WHERE t.kv =r.kv
       AND t.kv != 980
       AND r.vdate IN (SELECT max(rr.vdate) FROM cur_rates rr
                        WHERE rr.kv=r.kv and rr.vdate<=dat_);

CURSOR Basel IS
   SELECT nbuc, kodp,
          SUM( to_number(znap) ),
          SUM( to_number(znap_pr) )
     FROM ( SELECT a.nbuc NBUC, a.kodp KODP,
                   a.znap ZNAP, '0' ZNAP_PR
              FROM RNBU_TRACE a
             WHERE SUBSTR (a.kodp, 1, 1) = '1'
            UNION ALL
            SELECT a.nbuc NBUC, '1'||substr(a.kodp,2,6) KODP,
                   '0' ZNAP, a.znap ZNAP_PR
              FROM RNBU_TRACE a
             WHERE SUBSTR (a.kodp, 1, 1) = '3' )
   GROUP BY nbuc, kodp
   ORDER BY nbuc, kodp;

-----------------------------------------------------------------------
function f_div(p_kurs_ in number, p_rate_ in number) return number is
         dv_ number;
    begin
       dv_ := round(p_kurs_ / p_rate_,0);

       if dv_ < 5 then
          dv_ := 1;
       elsif dv_ > 5 and dv_ < 50 then
          dv_ := 10;
       elsif dv_ between 50 and 150 then
          dv_ := 100;
       else
          dv_ := 1000;
       end if;

       return dv_;
    end;

BEGIN

begin
    EXECUTE IMMEDIATE 'ALTER SESSION ENABLE PARALLEL DML';
exception
    when others then null;
end;

EXECUTE IMMEDIATE 'alter session set NLS_NUMERIC_CHARACTERS = ''.,'' ';
-------------------------------------------------------------------
logger.info ('P_F3C_NN: Begin for datf = '||to_char(dat_, 'dd/mm/yyyy'));
-------------------------------------------------------------------
userid_ := user_id;
DELETE FROM RNBU_TRACE WHERE userid = userid_;
-------------------------------------------------------------------
mfo_ := F_OURMFO();

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

p_proc_set(kodf_,sheme_,nbuc1_,typ_);
Datp_ := calc_pdat(dat_);

--
OPEN tval;
LOOP
   FETCH tval INTO kv_, dig_, bsu_, rate_o_;
   EXIT WHEN tval%NOTFOUND;

   VVV:=lpad(kv_,3,'0');

-- покупка/продажа наличной валюты (валютообменные операции по кассе)
   OPEN OPERVAL;
   LOOP
      FETCH operval INTO ref_, acc_, nls_, kv1_, data_, kurs_,
                         datd_, branch_, sum1_, sum0_, sun1_, sun0_;
      EXIT WHEN operval%NOTFOUND ;

      comm_ := '';
      flag_ := 0;

      select count(*)
         into count_
      from holiday
      where holiday = datd_
        and kv = 980;

      begin
         select count(*)
            into flag_
         from provodki_otc
         where ref=ref_
           and fdat=dat_
           and ((nlsd like '3800%' and exists (select 1 from specparam_int sp
                                               where sp.acc=accd
                                                 and sp.ob22 not in ('03','10','11','12'))) or
                (nlsk like '3800%' and exists (select 1 from specparam_int sp1
                                               where sp1.acc=acck
                                                 and sp1.ob22 not in ('03','10','11','12'))));
      exception when others then
         flag_ := 0;
      end;

      if flag_ = 0
      then
         begin
            select count(*)
               into flag_
            from provodki_otc
            where ref=ref_
              and fdat=dat_
              and ((nlsd like '3800%' and exists (select 1 from specparam_int sp
                                                  where sp.acc=accd
                                                    and sp.ob22 in ('10'))
                    and LOWER(trim(nazn)) like '%передан%') or
                   (nlsk like '3800%' and exists (select 1 from specparam_int sp1
                                                  where sp1.acc=acck
                                                    and sp1.ob22 not in ('10'))
                    and LOWER(trim(nazn)) like '%передан%'));
         exception when others then
            flag_ := 0;
         end;
      end if;

      if flag_ = 0
      then
         -- определяем базовую сумму введенных курсов
         if kurs_ is not null
         then
            begin
               buf_ := to_number(kurs_);
            exception when others then
               if sqlcode=-6502 then
                  raise_application_error(-20001,'Помилка: введений курс містить не числове значення (ref='||ref_||', kurs='''||kurs_||''')');
               else
                  raise_application_error(-20002,'Помилка: '||sqlerrm);
               end if;
            end;

            div_ := f_div( kurs_ , rate_o_ / bsu_);
         end if;

         -- определяем код области
         if typ_>0
         then
            nbuc_ := nvl(f_codobl_tobo(acc_,typ_),nbuc1_);
         else
            nbuc_ := nbuc1_;
         end if;

         IF  kv_ not in (959,961,962,964)
         THEN

            -- покупка наличной валюты
            IF sum1_>0 AND sun1_>0
            THEN
               -- объем
               a_:='1210' || VVV;
               b_:=TO_CHAR(sum1_);

               INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, ref, comm) VALUES
                                      (nls_, kv_, datd_, a_, b_, nbuc_, ref_, comm_);

               -- курс
               a_:='4210' || VVV;
               if kurs_ is null     -- розрахований курс
               then
                  if mfou_ = 300465 and mfou_ != mfo_ or mfou_ = 380764
                  then
                     if count_ = 0
                     then
                        BEGIN
                           select rate_b
                              into kurs1_
                           from cur_rates$base
                           where vdate in (select max(r.vdate)
                                           from cur_rates$base r
                                           where r.vdate <= decode(mfo_,351823,datd_-1,datd_))
                             and kv=kv1_
                             and branch=branch_;
                        EXCEPTION WHEN NO_DATA_FOUND THEN
                           null;
                        END;
                     else
                        BEGIN
                           select rate_b
                              into kurs1_
                           from cur_rates$base
                           where vdate in (select min(r.vdate)
                                           from cur_rates$base r
                                           where r.vdate > decode(mfo_,351823,datd_-1,datd_))
                             and kv=kv1_
                             and branch=branch_;
                        EXCEPTION WHEN NO_DATA_FOUND THEN
                           null;
                        END;
                     end if;
                     b_:=ltrim(TO_CHAR(kurs1_,fmt_));
                     comm_ := comm_||' курс вибраний iз таблицi курсiв '||b_;
                  else
                     b_:=LTRIM(TO_CHAR(ROUND(sun1_*bsu_/sum1_,4),fmt_));
                     comm_ := comm_ || ' курс розрахований ' || b_;
                  end if;
               else -- введений курс
                  b_:=ltrim(TO_CHAR(to_number(kurs_)*bsu_/div_,fmt_));
                  comm_ := comm_ || ' курс введений в док-тi ' || b_;
               end if;

               INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, ref, comm) VALUES
                                      (nls_, kv_, datd_, a_, b_, nbuc_, ref_, comm_);

               -- объем**курс
               a_:='3210' || VVV;
               b_:=TO_CHAR(sum1_*b_);

               INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, ref) VALUES
                                      (nls_, kv_, datd_, a_, b_, nbuc_, ref_);
            END IF;

            -- продажа наличной валюты
            IF sum0_>0 AND sun0_>0
            THEN
               -- объем
               a_:='1220' || VVV;
               b_:=TO_CHAR(sum0_);

               INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, ref, comm) VALUES
                                      (nls_, kv_, datd_, a_, b_, nbuc_, ref_, comm_);

               -- курс
               a_:='4220' || VVV ;

               if kurs_ is null
               then

                  if mfou_ = 300465 and mfou_ != mfo_ or mfou_ = 380764
                  then
                     if count_ = 0
                     then
                        BEGIN
                           select rate_s
                              into kurs1_
                           from cur_rates$base
                           where vdate in (select max(r.vdate)
                                           from cur_rates$base r
                                           where r.vdate <= decode(mfo_,351823,datd_-1,datd_))
                             and kv=kv1_
                             and branch=branch_;
                        EXCEPTION WHEN NO_DATA_FOUND THEN
                           null;
                        END;
                     else
                        BEGIN
                           select rate_s
                              into kurs1_
                           from cur_rates$base
                           where vdate in (select min(r.vdate)
                                           from cur_rates$base r
                                           where r.vdate > decode(mfo_,351823,datd_-1,datd_))
                             and kv=kv1_
                             and branch=branch_;
                        EXCEPTION WHEN NO_DATA_FOUND THEN
                           null;
                        END;
                     end if;

                     b_:=ltrim(TO_CHAR(kurs1_,fmt_));
                     comm_ := comm_||' курс вибраний iз таблицi курсiв '||b_;
                  else
                     b_:=LTRIM(TO_CHAR(ROUND(sun0_*bsu_/sum0_,4),fmt_));
                     comm_ := comm_ || ' курс розрахований ' || b_;
                  end if;
               else
                  b_:=ltrim(TO_CHAR(to_number(kurs_)*bsu_/div_,fmt_));
                  comm_ := comm_ || ' курс введений в док-тi ' || b_;
               end if;

               INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, ref, comm) VALUES
                                      (nls_, kv_, datd_, a_, b_, nbuc_, ref_, comm_);

               -- объем**курс
               a_:='3220' || VVV;
               b_:=TO_CHAR(sum0_*b_);

               INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, ref) VALUES
                                      (nls_, kv_, datd_, a_, b_, nbuc_, ref_);
            END IF;
         END IF;
      end if;
   END LOOP;
   CLOSE operval;

END LOOP;
CLOSE tval;

------------------------------------------------------
   DELETE FROM tmp_nbu where kodf=kodf_ and datf=dat_;

   OPEN basel;

   LOOP
      FETCH basel
      INTO nbuc_, kodp_, sum0_, sum1_;
      EXIT WHEN basel%NOTFOUND;

      IF sum0_ != 0
      then
         -- сумма
         kv_:=to_number(substr(kodp_,5,3));

         dig_:=f_ret_dig(kv_);

         b_ := TO_CHAR(ROUND(to_number(sum0_)/dig_,0));

         INSERT INTO tmp_nbu
                  ( kodf, datf, kodp, znap, nbuc)
           VALUES ( kodf_, dat_, kodp_, b_, nbuc_) ;

         -- курс
         b_ := LTRIM(TO_CHAR(ROUND(sum1_/sum0_,4),fmt_));

         INSERT INTO tmp_nbu
                  ( kodf, datf, kodp, znap, nbuc)
           VALUES ( kodf_, dat_, '4'||substr(kodp_,2,6), b_, nbuc_) ;
      end if;

   END LOOP;
   CLOSE basel;

logger.info ('P_F3C_NN: End for datf = '||to_char(dat_, 'dd/mm/yyyy'));

END P_F3C_NN;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F3C_NN.sql =========*** End *** 
PROMPT ===================================================================================== 
