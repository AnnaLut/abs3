

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F44.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F44 ***

  CREATE OR REPLACE PROCEDURE BARS.P_F44 (Dat_ DATE, sheme_ varchar2 default 'G' )  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Процедура формирование файла #44 для КБ
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
% VERSION     : 08/11/2017 (23/03/2017)
%-----------------------------------------------------------------------------
%23.03.2017 - показатели 92-98 будут формироваться по корреспонденции счетов 
%             доп.реквизит "D#44" не обязателен 
%20.04.2016 - добавлены блоки для определения кода территории по некоторым 
%             показателям (в эталонной версии были)
%21.03.2016 - на 01.04.2016 исключены показатели 11-38, A2-A7
%10.12.2015 - косметические изменения
%20.11.2015 - в курсоре OPL_DOK1 будут включаться операции 'FX3','FX4','NOS'
%             (ранее исключались)
%17.07.2015 - оптимизация
%25.04.2013 - выполнены некоторые изменения для исключения проводок по
%             инвестиционным монетам
%21.02.2013 - не будут включаться инвестиционные монеты
%             (type_=4 (набiр) и поле cena_nomi в BANK_METALS не пустое)
% 10.09.2012 - формируем в разрезе кодов территорий
% 21.10.2011 - не будут включаться док-ты в которых назн.платежа похож на
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
kodf_    varchar2(2) := '44';
dk_      number;
buf_     number;
acc_     number;
accd_    number;
acck_    number;
acc3800_ number;
acc3801_ number;
acc6204_ number;
ref_     number;
ref1_    number;
kol_     number;
kod_     Varchar2(2);
tt_      Varchar2(3);
typ_     number;
mfo_     VARCHAR2(12);
mfou_    NUMBER;
mfoa_    varchar2(12);
mfob_    varchar2(12);
branch_  varchar2(30);
tag_     varchar2(5);
a_       varchar2(20);
b_       varchar2(20);
dl_      number:=100; -- для металлов
ddd39_   varchar2(3) ;
d39_     varchar2(200);
kurs_    varchar2(200);
kurs1_   Number(9,4);
nls_     varchar2(15);
nls1_    varchar2(15);
nlsk_    varchar2(15);
nlsb_    varchar2(15);
data_    date;
kv_      number;
kv1_     number;
kva_     number;
kvb_     number;
prf_     number;
dat1_    Date;
datd_    Date;
dig_     number;
bsu_     number;
sum1_    number;
sum0_    number;
sum_eqv_ number;
sn_      DECIMAL(24) ;
se_      DECIMAL(24) ;
se1_     DECIMAL(24) ;
kodp_    varchar2(30);
znap_    varchar2(30);
VVV      varchar2(3) ;
d#44_    varchar2(2) ;
d020_    varchar2(3) ;
userid_  Number;
userid1_ Number;
fmt_     varchar2(20):='999999990D0000';
nbuc_    varchar2(12);
nbuc1_   varchar2(12);
rate_o_  number;
div_     number;
comm_    Varchar2(200);
cena_nomi_  Number;

-- покупка/продажа безналичных металлов
CURSOR OPL_DOK1 IS
   SELECT /*+ leading(a) */
          a.acc, a.nls, a.kv, a1.acc, a1.nls, o.ref, o.mfoa, o.mfob, o.nlsb, 
          c.ref, c.fdat, k.tag, k.value, translate(p.value,',','.'), sum(c.s)
   FROM accounts a, accounts a1, opldok c, opldok c1, oper o, operw k, operw p
   WHERE a.kv in (959,961,962,964)  AND
         a.acc = c.acc              AND
         a.nls not like '110%'      AND
         a.nls not like '8%'        AND
         a.nls not like '9%'        AND
         c.fdat = any (select fdat from fdat where fdat between Dat1_ and Dat_) AND
         c.dk = 0                   AND
         c.sos = 5                  AND
         a1.acc = c1.acc            AND
         a1.nls not like '110%'     AND
         c1.dk = 1-c.dk             AND
         c.stmt = c1.stmt           AND
         c.tt not in ('024')        AND   
         c.ref = k.ref(+)           AND
         c.ref = o.ref              AND
         ((k.tag(+) LIKE 'D#39%' AND substr(k.value(+),1,3) in ('112','122') ) OR
          (k.tag(+) LIKE 'D#44%' AND substr(k.value(+),1,2) in ('92','93','94',
                                                    '95','96','97') ) 
          or k.tag(+) is null)  AND
         c.ref = p.ref(+)           AND
         p.tag(+) LIKE '%KURS%'        AND
         SUBSTR(LOWER(TRIM(o.nazn)),1,4) <> 'конв'
GROUP BY a.acc, a.nls, a.kv, a1.acc, a1.nls, o.ref, o.mfoa, o.mfob, o.nlsb, 
         c.ref, c.fdat, k.tag, k.value, translate(p.value,',','.')
ORDER BY 1, 2, 3, 9, 10;

CURSOR BaseL IS
    SELECT kodp, SUM(TO_NUMBER(znap))
    FROM rnbu_trace
    GROUP BY kodp;

CURSOR Basel1 IS
   SELECT nbuc, kodp, SUM(TO_NUMBER (znap)),
          SUM (TO_NUMBER (znap_pr))
   FROM (SELECT a.nbuc NBUC, a.kodp KODP,
                a.znap ZNAP, '0' ZNAP_PR
         FROM RNBU_TRACE a
         WHERE SUBSTR (a.kodp, 1, 1) = '1'
         UNION ALL
         SELECT a.nbuc NBUC, '1'||decode(substr(a.kodp,2,1),'A','1','2')||
                                  substr(a.kodp,3,18) KODP,
                '0' ZNAP, a.znap ZNAP_PR
         FROM RNBU_TRACE a
         WHERE SUBSTR (a.kodp, 1, 1) = '3')
   GROUP BY nbuc, kodp;

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
    logger.info ('P_F44_NN: Begin for '||to_char(dat_,'dd.mm.yyyy'));
    -------------------------------------------------------------------
    userid_ := user_id;
    EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';
    -------------------------------------------------------------------
    mfo_ := gl.aMFO;
    if mfo_ is null then
        mfo_ := f_ourmfo_g;
    end if;

    -- МФО "родителя"
    BEGIN
       SELECT NVL(trim(mfou), mfo_)
          INTO mfou_
       FROM BANKS
       WHERE mfo = mfo_;
    EXCEPTION WHEN NO_DATA_FOUND THEN
       mfou_ := mfo_;
    END;

    Dat1_ := TRUNC(Dat_, 'MM');

    p_proc_set(kodf_,sheme_,nbuc1_,typ_);
    nbuc_ := nbuc1_;

    ----------------------------------------------------------------------------
    -- межбанк
    OPEN OPL_DOK1;
       LOOP
          FETCH OPL_DOK1 INTO accd_, nls_, kv_, acck_, nlsk_, ref_, mfoa_, mfob_,
                              nlsb_, ref_, data_, tag_, d39_, kurs_, sum1_ ;
          EXIT WHEN OPL_DOK1%NOTFOUND;

          kol_ := 0;
          ddd39_ := '00';

          IF mfoa_ <> mfob_ THEN
             SELECT count(*) INTO kol_ FROM v_branch
             WHERE mfob_ = mfo and mfo <> mfou;
          END IF;
   
          VVV := lpad(kv_,3,'0');

          -- банки
          if nls_ like '1%' and nlsk_ like '1%'
          then
             begin
                select kva, kvb
                   into kva_, kvb_
                from fx_deal
                where ref = ref_
                  and (kod_na is null OR (kod_na is not null and kod_na like '8443%'));
             exception when no_data_found then
                kva_ := '000'; 
                kvb_ := '000';
             end;

             if kva_ <> 980 and kvb_ = 980 
             then
                nls1_ := nlsk_;
                acc_ := acck_;
                ddd39_ := '92';
             end if;

             if kva_ = 980 and kvb_ <> 980 
             then
                nls1_ := nls_;
                acc_ := accd_;
                ddd39_ := '95';
             end if;

          end if;

          IF SUM1_ <> 0 and substr(nls_,1,4) in ('2600','2610','2615','2650','2651','2652') and
                            substr(nlsk_,1,4) in ('2900') 
          then
             nls1_ := nlsk_;
             acc_ := acck_;
             ddd39_ := '93';
          end if;

          IF SUM1_ <> 0 and substr(nls_,1,4) in ('2900') and 
                            substr(nlsk_,1,4) in ('2600','2610','2615','2650','2651','2652') 
          then
             nls1_ := nls_;
             acc_ := accd_;
             ddd39_ := '96';
          end if;


          IF SUM1_ <> 0 and substr(nls_,1,4) in ('2620') and
                            substr(nlsk_,1,4) in ('2900') 
          then
             nls1_ := nlsk_;
             acc_ := acck_;
             ddd39_ := '94';
          end if;

          IF SUM1_ <> 0 and substr(nls_,1,4) in ('2900') and 
                            substr(nlsk_,1,4) in ('2620') 
          then
             nls1_ := nls_;
             acc_ := accd_;
             ddd39_ := '97';
          end if;
             
          IF sum1_ <> 0 and ddd39_ in ('92','93','94','95','96','97','98','99')
          THEN

             -- объем
             kodp_ := '1' || ddd39_ || VVV || '00000000000000';
             znap_ := TO_CHAR(SUM1_) ;

             INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, ref)
             VALUES
                                    (nls1_, kv_, data_, kodp_,znap_,nbuc_, ref_);

             -- официальный курс по данной валюте
             begin
                SELECT  r.bsum, r.rate_o
                   into bsu_, rate_o_
                FROM cur_rates r
                WHERE r.kv = kv_               AND
                      r.vdate IN (SELECT max(rr.vdate) FROM cur_rates rr
                                  WHERE rr.kv = kv_ and rr.vdate <= data_);
             exception
                when no_data_found then
                rate_o_ :=  kurs_;
                bsu_ := 1;
             end;

             if kurs_ is null OR kurs_ = '1' then
                kurs_ := rate_o_;
             end if;
             -- курс
             kodp_ := '4' || ddd39_ || VVV || '00000000000000';

             begin
                buf_ := to_number(kurs_);
             exception
                when others then
                if sqlcode=-6502 then
                   raise_application_error(-20003,'Помилка: введений курс мiстить не числове значення (ref='||ref_||', kurs='''||kurs_||''')');
                else
                   raise_application_error(-20004,'Помилка: '||sqlerrm);
                end if;
             end;

             div_ := f_div( kurs_ , rate_o_ / bsu_);

             znap_:= ltrim(TO_CHAR(to_number(kurs_)*bsu_/div_,fmt_));

             INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, ref)
             VALUES
                                    (nls1_, kv_, data_, kodp_, znap_, nbuc_, ref_);

             -- объем**курс
             kodp_ := '3' || ddd39_ || VVV || '00000000000000';
             znap_ := TO_CHAR(sum1_*to_number(znap_));

             INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, ref)
             VALUES
                                    (nls1_, kv_, data_, kodp_, znap_, nbuc_, ref_);
          end if;
       END LOOP;
    CLOSE OPL_DOK1;
    ---------------------------------------------------
    ---------------------------------------------------
    DELETE FROM tmp_nbu where kodf='44' and datf= dat_;
    ---------------------------------------------------
    OPEN basel1;
       LOOP
          FETCH basel1
          INTO nbuc_, kodp_, sum0_, sum1_;
          EXIT WHEN basel1%NOTFOUND;

          IF sum0_<>0 then

             -- сумма
             kv_:=to_number(substr(kodp_,4,3));

             dig_:=f_ret_dig(kv_);

             b_ := TO_CHAR(ROUND(to_number(sum0_)/dig_,0));

             INSERT INTO tmp_nbu
                  (kodf, datf, kodp, znap, nbuc)
             VALUES
                  (kodf_, Dat_, kodp_, b_, nbuc_) ;


             if substr(kodp_,2,2) in ('12','13','14','15','16','17',
                                      '92','93','94','95','96','97')
             then
                if substr(kodp_,2,2) in ('12','13','14','15','16','17') then
                   kodp_ := 'A' || substr(kodp_,3,18);
                end if;

                if substr(kodp_,2,2) in ('92','93','94','95','96','97') then
                   kodp_ := 'B' || substr(kodp_,3,18);
                end if;

                -- курс
                b_ := LTRIM(TO_CHAR(ROUND(sum1_/sum0_,4)*10,'99999999D00'));  --fmt_

                INSERT INTO tmp_nbu
                     (kodf, datf, kodp, znap, nbuc)
                VALUES
                     (kodf_, Dat_, '4'|| kodp_, b_, nbuc_) ;
             end if;

          end if;

       END LOOP;
    CLOSE basel1;

    DELETE FROM RNBU_TRACE
       WHERE userid = userid_ AND
             kodp like '3%';
    -----------------------------------------------------------------------------
    logger.info ('P_F44_NN: End for '||to_char(dat_,'dd.mm.yyyy'));
END p_f44;
/
show err;

PROMPT *** Create  grants  P_F44 ***
grant EXECUTE                                                                on P_F44           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_F44           to RPBN002;
grant EXECUTE                                                                on P_F44           to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F44.sql =========*** End *** ===
PROMPT ===================================================================================== 
