

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F2A_NN.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F2A_NN ***

  CREATE OR REPLACE PROCEDURE BARS.P_F2A_NN (Dat_ DATE, sheme_ varchar2 default 'G')  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :    Процедура формирование файла #2A для КБ (универсальная)
% COPYRIGHT   :    Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
% VERSION     :    20/02/2015 (19/01/2011) 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    параметры: Dat_ - отчетная дата
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
19/01/2011 - виключила умову на id при виборі з OPLDOK
01.04.2010 - добавил условие для операции "МГР" поле "ID" из OPLDOK
             т.к. множило количество записей
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
kodf_    varchar2(2):='2A';
fmt_     varchar2(20):='999990D0000';
dl_      number:=100; -- для металлов
DatP_     date; -- дата начала выходных дней, кот. предшествуют заданой дате
buf_     number;

count_   number;
flag_    number;
typ_     number;
kv_      number;
kv1_     number;
ref_     number;
ref1_    number;
nls_     varchar2(15);
nlsd_    varchar2(15);
nlsk_    varchar2(15);
nls1_    varchar2(15);
nlsb_    varchar2(15);
mfo_     Varchar2(12);
mfoa_    Varchar2(12);
mfob_    Varchar2(12);
dat1_    date;
data_    date;
datd_    date;
kol_     number;
dig_     number;
bsu_     number;
sum_     number;
sum1_    number;
sum0_    number;
sun1_    number;
sun0_    number;
kodp_    varchar2(10);
kodp1_   varchar2(10);
znap_    varchar2(30);
VVV      varchar2(3) ;
ddd39_   varchar2(3) ;
d39_     varchar2(200) ;
kurs_    varchar2(200) ;
kurs1_   Number(9,4);
tag_     varchar2(5) ;
a_       varchar2(20);
b_       varchar2(20);
userid_  number;
nbuc1_   varchar2(12);
nbuc_    varchar2(12);
acc_     number;
accd_    number;
acck_    number;
pr_      number;
rate_o_  number;
div_     number;
comm_    varchar2(200);
branch_  varchar2(30);

-- покупка/продажа безналичной валюты
CURSOR OPL_DOK IS
   SELECT a.acc, a.nls, a.kv, a1.acc, a1.nls, o.ref, o.nazn, o.mfoa, o.mfob,
          c.fdat, k.tag, k.value, translate(p.value,',','.'), sum(c.s)
   FROM accounts a, accounts a1, opldok c, opldok c1, oper o, operw k, operw p
   WHERE a.kv<>980                  AND
         a.acc =c.acc               AND
         a.nls not LIKE '8%'        AND
         c.fdat >= dat1_            AND
         c.fdat <= dat_             AND
         c.dk=0                     AND
         c.sos=5                    AND
         a1.acc=c1.acc              AND
         c1.dk=1-c.dk               AND
         c.stmt=c1.stmt and 
         c.tt not in ('FX3','FX4','NOS') AND
         c.ref=c1.ref               AND
         c.ref=k.ref                AND
         c.ref=o.ref                AND
         k.tag='D#39'               AND
         (substr(k.value,1,3) in ('112','122') or 
          substr(k.value,1,3) in (select kod from kf39)) AND
         c.ref=p.ref(+)             AND
         p.tag(+) LIKE 'KURS%'      
GROUP BY a.acc, a.nls, a.kv, a1.acc, a1.nls, o.ref, o.nazn, o.mfoa, o.mfob,
         c.fdat, k.tag, k.value, translate(p.value,',','.')
ORDER BY 1, 2, 3, 9, 10;

CURSOR tval IS
    SELECT  t.kv, POWER(10,t.dig), r.bsum, r.rate_o
    FROM tabval t, cur_rates r   -- cur_rates$base
    WHERE t.kv=r.kv                AND
          t.kv<>980                AND
          r.vdate IN (SELECT max(rr.vdate) FROM cur_rates rr
                      WHERE rr.kv=r.kv and rr.vdate<=dat_);

CURSOR Basel IS
   SELECT nbuc, kodp, SUM(TO_NUMBER (znap)),
          SUM (TO_NUMBER (znap_pr))
   FROM (SELECT a.nbuc NBUC, a.kodp KODP,
                a.znap ZNAP, '0' ZNAP_PR
         FROM RNBU_TRACE a
         WHERE SUBSTR (a.kodp, 1, 1) = '1'
         UNION ALL
         SELECT a.nbuc NBUC, '1'||substr(a.kodp,2,6) KODP,
                '0' ZNAP, a.znap ZNAP_PR
         FROM RNBU_TRACE a
         WHERE SUBSTR (a.kodp, 1, 1) = '3')
   GROUP BY nbuc, kodp;

CURSOR Basel1 IS
   SELECT nbuc, kodp, SUM(TO_NUMBER (znap)), 
          SUM (TO_NUMBER (znap_pr))
   FROM (SELECT a.nbuc NBUC, substr(a.kodp,1,3)||'0'||substr(a.kodp,5,3) KODP,
                a.znap ZNAP, '0' ZNAP_PR
         FROM RNBU_TRACE a
         WHERE SUBSTR (a.kodp, 1, 1) = '1'
         UNION ALL
         SELECT a.nbuc NBUC, '1'||substr(a.kodp,2,2)||'0'||substr(a.kodp,5,3) KODP,
                '0' ZNAP, a.znap ZNAP_PR
         FROM RNBU_TRACE a
         WHERE SUBSTR (a.kodp, 1, 1) = '3')
   GROUP BY nbuc, kodp;
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
commit;

EXECUTE IMMEDIATE 'ALTER SESSION ENABLE PARALLEL DML';
-------------------------------------------------------------------
logger.info ('P_F2A_NN: Begin for datf = '||to_char(dat_, 'dd/mm/yyyy'));
-------------------------------------------------------------------
userid_ := user_id;
DELETE FROM RNBU_TRACE WHERE userid = userid_;
-------------------------------------------------------------------
mfo_ := F_OURMFO();

p_proc_set(kodf_,sheme_,nbuc1_,typ_);
Datp_ := calc_pdat(dat_);
Dat1_ := trunc(Dat_,'MM');
------------------------------------------------------
-- межбанк
OPEN OPL_DOK;
LOOP
   FETCH OPL_DOK INTO accd_, nls_, kv_, acck_, nlsk_, ref_, comm_, mfoa_, mfob_,
                      data_, tag_, d39_, kurs_, sum1_ ;
   EXIT WHEN OPL_DOK%NOTFOUND;

   IF kv_ not in (959,961,962,964) 
   THEN

      kol_:=0;
      IF mfoa_<>mfob_ THEN
         SELECT count(*) INTO kol_ FROM v_branch
         WHERE mfob_=mfo and mfo<>mfou;
      END IF;

      select nlsb into nlsb_ from oper where ref=ref_;

      IF SUM1_<>0 
      then

         VVV:=lpad(kv_,3,'0');

         IF substr(tag_,1,4)='D#39' THEN
            -- покупка или продажа?
            IF substr(nls_,1,4)='3800' and d39_='110' THEN
               d39_:='120';
            END IF;

            IF d39_ in ('110','112','131','132','150') THEN
               nls1_:=nlsk_;
               acc_:=acck_;
            ELSE
               nls1_:=nls_;
               acc_:=accd_;
            END IF;

            -- определяем код области
            if typ_>0 then
               nbuc_ := nvl(F_Codobl_Tobo_new (acc_, dat_, typ_),nbuc1_);
            else
               nbuc_ := nbuc1_;
            end if;

            ddd39_:= substr(d39_,1,3);
            ref1_:=ref_ ;

            -- объем
            kodp_:= '1' || ddd39_ || VVV ;
            znap_:= TO_CHAR(SUM1_) ;

            INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, ref, comm) VALUES
                                   (nls1_, kv_, data_, kodp_,znap_,nbuc_, ref_, comm_);

            -- официальный курс по данной валюте
            begin
               SELECT  r.bsum, r.rate_o
                  into bsu_, rate_o_
               FROM cur_rates r
               WHERE r.kv = kv_               AND
                     r.vdate IN (SELECT max(rr.vdate) FROM cur_rates rr
                                 WHERE rr.kv=kv_ and rr.vdate<=dat_);
            exception
               when no_data_found then
               rate_o_ :=  kurs_;
               bsu_ := 1;
            end;

            if kurs_='1' then
               kurs_ := rate_o_;
            end if;

            -- курс
            if ddd39_ in ('110','112','120','122','131','132','141','142') 
            then

               kodp_:= '4' || ddd39_ || VVV ;
               --kodp_:= '4' || substr(ddd39_,1,2) || '0' || VVV ;


               begin
                  buf_ := to_number(kurs_);
               exception
                  when others then
                  if sqlcode=-6502 then
                     raise_application_error(-20003,'Помилка: введений курс містить не числове значення (REF='||ref_||', kurs='''||kurs_||''')');
                  else
                     raise_application_error(-20004,'Помилка: '||sqlerrm);
                  end if;
               end;

               div_ := f_div( kurs_ , rate_o_ / bsu_);

               znap_:= ltrim(TO_CHAR(to_number(kurs_)*bsu_/div_,fmt_));

               INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, ref, comm) VALUES
                                      (nls1_, kv_, data_, kodp_, znap_, nbuc_, ref_, comm_);

               -- объем**курс
               --kodp_:='3' || ddd39_ || VVV;
               kodp_:='3' || substr(kodp_,2,6);
               znap_:=TO_CHAR(sum1_*to_number(znap_));

               INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap,nbuc) VALUES
                                      (nls1_, kv_, data_, kodp_, znap_, nbuc_);
            end if;
         END IF;
      END IF;
   END IF;
END LOOP;
CLOSE OPL_DOK;
---------------------------------------------------
DELETE FROM tmp_nbu where kodf=kodf_ and datf=dat_;
---------------------------------------------------
-- сумма
OPEN basel;
   LOOP
      FETCH basel
      INTO nbuc_, kodp_, sum0_, sum1_;
      EXIT WHEN basel%NOTFOUND;

      IF sum0_<>0 then

         -- сумма
         kv_:=to_number(substr(kodp_,5,3));

         dig_:=f_ret_dig(kv_);

         b_ := TO_CHAR(ROUND(to_number(sum0_)/dig_,0));

         INSERT INTO tmp_nbu
              (kodf, datf, kodp, znap, nbuc)
         VALUES
              (kodf_, Dat_, kodp_, b_, nbuc_) ;
      end if;

   END LOOP;
CLOSE basel;


-- курс
OPEN basel1;
   LOOP
      FETCH basel1
      INTO nbuc_, kodp_, sum0_, sum1_;
      EXIT WHEN basel1%NOTFOUND;

      IF sum0_<>0 then

         -- сумма
         kv_:=to_number(substr(kodp_,5,3));

         dig_:=f_ret_dig(kv_);

         -- курс
         if sum1_ <> 0 
         then
            b_ := LTRIM(TO_CHAR(ROUND(sum1_/sum0_,4),fmt_));
    
            INSERT INTO tmp_nbu
                 (kodf, datf, kodp, znap, nbuc)
            VALUES
                 (kodf_, Dat_, '4'||substr(kodp_,2,2)||'0'||substr(kodp_,5,3), b_, nbuc_) ;
         end if;

      end if;

   END LOOP;
CLOSE basel1;

UPDATE RNBU_TRACE 
set kodp=substr(kodp,1,3)||'0'||substr(kodp,5,3)
WHERE userid = userid_  
 AND substr(kodp,1,1)='4';

DELETE FROM RNBU_TRACE
  WHERE userid = userid_ 
    AND kodp like '3%';
----------------------------------------
logger.info ('P_F2A_NN: End for datf = '||to_char(dat_, 'dd/mm/yyyy'));
END p_f2A_NN;
/
show err;

PROMPT *** Create  grants  P_F2A_NN ***
grant EXECUTE                                                                on P_F2A_NN        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F2A_NN.sql =========*** End *** 
PROMPT ===================================================================================== 
