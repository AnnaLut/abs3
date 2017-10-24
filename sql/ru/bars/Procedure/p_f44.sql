

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F44.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F44 ***

  CREATE OR REPLACE PROCEDURE BARS.P_F44 (Dat_ DATE, sheme_ varchar2 default 'G' )  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Процедура формирование файла #44 для КБ
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
% VERSION     : 21/03/2016 (10/12/2015, 20/11/2015, 17/07/2015)
%-----------------------------------------------------------------------------
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
buf_	 number;
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

--- Обороты для файла #44
CURSOR OPL_DOK IS
    select a.ref, a.tt, a.nlsd, a.accd, a.kv, a.fdat, NVL(substr(a1.value,1,2),'00') d#44,
        trim(substr(translate(a2.value,',','.'), 1, length(a2.value)-instr(a2.value, 'грн'))) kurs,
        a.s, a.sq, a.nlsk, a.acck, a.dk, a.datd, a.branch, a.userid
    from (
       SELECT /*INDEX(o.o.p, XIE_FDAT_ACC_OPLDOK) */
              o.ref, o.tt, o.nlsd, o.accd, o.kv, o.fdat,
              o.s*100 s, o.sq*100 sq, o.nlsk, o.acck,
              o.dk_o dk, o.pdatd datd, o.branch, o.isp userid,
              o.nlsa, o.nlsb
       FROM  provodki_otc o
       WHERE  o.kv<>980
          and o.tt != '024'
          and ( (o.nlsd like '110%' and o.nlsk not like '263%') or
                (o.nlsd not like '263%' and o.nlsk like '110%')
              )
          and o.fdat between Dat1_ and Dat_
          and lower(o.pnazn) not like '%отрим%'
          and lower(o.pnazn) not like '%висл%'
          and lower(o.pnazn) not like '%выд%'
          and lower(o.pnazn) not like '%получ%'
          and lower(o.pnazn) not like '%оприбутк%'
          and lower(o.pnazn) not like '%видан%'
          and lower(o.pnazn) not like '%оприходов% '
          and lower(o.pnazn) not like '%пополнение%'
          and lower(o.pnazn) not like '%принят%'
          and lower(o.pnazn) not like '%прийнят%'
          and lower(o.pnazn) not like '%п_дкр_плен%'
          and not ( (o.nlsa like '1101%' and o.nlsb like '390%') OR
                    (o.nlsa like '390%' and o.nlsb like '1101%')
                  )
         ) a
    left outer join operw a1
    on (a.ref = a1.ref and
        a1.tag in ('D#44', '44'||a.tt))
    left outer join operw a2
    on (a.ref = a2.ref and
        a2.tag like '%KURS%');

-- покупка/продажа безналичных металлов
CURSOR OPL_DOK1 IS
   SELECT  /*+PARALLEL */
          a.acc, a.nls, a.kv, a1.acc, a1.nls, o.ref, o.mfoa, o.mfob, o.nlsb,
          c.ref, c.fdat, k.tag, k.value, translate(p.value,',','.'), sum(c.s)
   FROM accounts a, accounts a1, opldok c, opldok c1, oper o, operw k, operw p
   WHERE a.kv in (959,961,962,964)  AND
         a.acc = c.acc              AND
         a.nls not like '110%'      AND
         a.nls not like '8%'        AND
         c.fdat between Dat1_ and Dat_ AND
         c.dk = 0                   AND
         c.sos = 5                  AND
         a1.acc = c1.acc            AND
         a1.nls not like '110%'     AND
         c1.dk = 1-c.dk             AND
         c.stmt = c1.stmt           AND
         c.tt not in ('024')        AND   -- 'FX3','FX4','NOS',
         c.ref = k.ref              AND
         c.ref = o.ref              AND
         ((k.tag = 'D#39' AND substr(k.value,1,3) in ('112','122') ) OR
          (k.tag = 'D#44' AND substr(k.value,1,2) in ('92','93','94',
                                                    '95','96','97') ) )  AND
         c.ref = p.ref              AND
         p.tag LIKE 'KURS%'         AND
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

if dat_ <= to_date('29022016','ddmmyyyy')
then
    -----------------------------------------------------------------------
    OPEN OPL_DOK;
    LOOP
       FETCH OPL_DOK INTO ref_, tt_, nls_, accd_, kv_, data_, d#44_, kurs_, sn_, se_,
                          nlsk_, acck_, dk_, datd_, branch_, userid1_ ;
       EXIT WHEN OPL_DOK%NOTFOUND;

          -- официальный курс по данной валюте
          begin
             SELECT  POWER(10,t.dig), r.bsum, r.rate_o
                into dig_, bsu_, rate_o_
             FROM tabval t, cur_rates r
             WHERE r.kv = kv_
               and t.kv = r.kv
               and r.vdate IN ( SELECT max(rr.vdate)
                                FROM cur_rates rr
                                WHERE rr.kv = kv_
                                  and rr.vdate <= dat_
                              );
          exception
             when no_data_found then
             dig_ := 100;
             rate_o_ :=  kurs_;
             bsu_ := 1;
          end;

          cena_nomi_ := 0;
          se1_ := 0;

          if kurs_ = '1'
          then
             kurs_ := rate_o_;
          end if;

          prf_ := 0;

          -- определяем базовую сумму введенных курсов
          if kurs_ is not null then
             begin
                buf_ := to_number(kurs_);
             exception when others then
                if sqlcode=-6502 then
                   raise_application_error(-20001,'Помилка: введений курс мiстить не числове значення (ref='||ref_||', kurs='''||kurs_||''')');
                else
                   raise_application_error(-20002,'Помилка: '||sqlerrm);
                end if;
             end;

             div_ := f_div( kurs_ , rate_o_ / bsu_);

             -- dbms_output.put_line('div_='||to_char(div_)||' bsu_='||to_char(bsu_));
          end if;

          --- 21.02.2005 покупка металлов у физ.лиц коды 14,24,34
          IF sn_ > 0 and (substr(nls_,1,4) in ('1101','1102') and substr(nlsk_,1,4)='3800') and d#44_ = '00' THEN

             IF typ_>0 THEN
                nbuc_ := NVL(F_Codobl_Tobo(accd_,typ_),nbuc1_);
             ELSE
                nbuc_ := nbuc1_;
             END IF;

             BEGIN
                SELECT to_char(b.type_), NVL(b.cena_nomi,0)
                   INTO d#44_, cena_nomi_
                FROM bank_metals b, operw w
                WHERE w.ref = ref_
                  AND w.tag = 'BM__C'
                  AND b.kod = trim(w.value);
             EXCEPTION WHEN NO_DATA_FOUND THEN
                cena_nomi_ := 0;
             END;

             kod_ := '14';

             if d#44_ = '2' then
                kod_ := '24';
             end if;

             if substr(d#44_,1,1) <> '4' and cena_nomi_ = 0 then
                -- объем
                if dat_ < to_date('20082008','ddmmyyyy') then
                   a_ := kod_ || lpad(kv_,3,'0') || '00000000000000' ;
                else
                   a_ := '1' || kod_ || lpad(kv_,3,'0') || '00000000000000' ;
                   d#44_ := kod_;
                end if;
                b_ := TO_CHAR(SN_) ;

                INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, ref)
                VALUES
                                       (nls_, kv_, data_, a_, b_, nbuc_, ref_);

                -- курс
                if dat_ >= to_date('20082008','ddmmyyyy') and
                   d#44_ in ('12','13','14','15','16','17','24','27')
                then

                   acc_ := acck_;
                   acc3800_ := acc_;
                   dk_ := 0;

                   BEGIN
                     select acc3801, acc6204
                        into acc3801_, acc6204_
                     from vp_list
                     where acc3800=acc_;

                     select sum(o.s)
                        into se1_
                     from opldok o, opldok o1, accounts a1
                     where o.fdat = data_
                       and o.ref = ref_
                       and o.acc = acc3801_
                       and o.dk = dk_
                       and o1.fdat = o.fdat
                       and o1.ref = o.ref
                       and o1.tt = tt_
                       and o1.tt = o.tt
                       and o1.stmt = o.stmt
                       and o1.dk = 1-dk_
                       and o1.acc not in (acc6204_)
                       and o1.acc = a1.acc
                       and ( (a1.nls like '100%' and a1.kv = 980) or
                             (substr(a1.nls,1,4) in ('3540','3640') and a1.kv = 980)
                           ) ;
                   exception when no_data_found then
                      null;
                   END;

                   if se1_ <> 0 then
                      se_ := se1_;
                   end if;

                   if kod_ in ('12','13','14','15','16','17') then
                      kod_ := 'A' || substr(kod_,2,1);
                   end if;

                   a_:= '4' || kod_ || lpad(kv_,3,'0') || '00000000000000' ;
                   if kurs_ is null then -- розрахований курс
                      b_ := LTRIM(TO_CHAR(ROUND(se_*bsu_/sn_,5)*dig_/dl_,fmt_));

                      if mfo_ = 333368 then
                         BEGIN
                            SELECT NVL(sum(p.s*100),0)
                               into sum_eqv_
                            from provodki p, vp_list v
                            where p.fdat = Dat_
                              and p.isp = userid1_
                              and p.kv = 980
                              and v.acc3800 = acc3800_
                              and p.acck = v.acc3801;
                         EXCEPTION WHEN NO_DATA_FOUND THEN
                            BEGIN
                               select rate_o
                                  into kurs1_
                               from cur_rates$base
                               where vdate=datd_
                                 and kv=kv1_
                                 and branch=branch_;
                            EXCEPTION WHEN NO_DATA_FOUND THEN
                               null;
                            END;
                         END;

                         if sum_eqv_ <> 0 then

                            if sum1_ = 8 then
                               kol_ := 1;
                            else
                               kol_ := 0;
                            end if;

                            b_ := ltrim(TO_CHAR((sum_eqv_/(round(sn_*31.1/100,kol_))*31.1034807/100),fmt_));
                            comm_ := comm_||' курс розрахований '||b_||
                                     ' сума екв. = '||to_char(sum_eqv_/100,'999999999D00');
                         end if;
                      end if;
                   else -- введений курс
                      b_ := ltrim(TO_CHAR(to_number(kurs_)*bsu_/div_,fmt_));
                   end if;

                   INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, ref)
                   VALUES
                                          (nls_, kv_, data_, a_, b_, nbuc_, ref_);

                   -- объем**курс
                   a_ := '3' || kod_ || lpad(kv_,3,'0') || '00000000000000' ;
                   b_ := TO_CHAR(sn_*b_);

                   INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, ref)
                   VALUES
                                          (nls_, kv_, data_, a_, b_, nbuc_, ref_);
                end if;
             end if;
             prf_ := 1;
          END IF;
    -------------------------------------------------------------------------------
          --- 21.02.2005 продажа металлов у физ.лицам коды 17,27,37
    -------------------------------------------------------------------------------
          IF sn_ > 0 and (substr(nls_,1,4) = '3800' and substr(nlsk_,1,4) in ('1101','1102') and d#44_ = '00') THEN
             -- объем

             BEGIN
                SELECT to_char(b.type_), NVL(b.cena_nomi,0)
                   INTO d#44_, cena_nomi_
                FROM bank_metals b, operw w
                WHERE w.ref = ref_
                  AND w.tag = 'BM__C'
                  AND b.kod = trim(w.value);
             EXCEPTION WHEN NO_DATA_FOUND THEN
                cena_nomi_ := 0;
             END;

             IF typ_ > 0 THEN
                nbuc_ := NVL(F_Codobl_Tobo(acck_,typ_),nbuc1_);
             ELSE
                nbuc_ := nbuc1_;
             END IF;

             kod_ := '17';

             if d#44_ = '2' then
                kod_ := '27';
             end if;

             if substr(d#44_,1,1) <> '4' and cena_nomi_ = 0 then
                if dat_ < to_date('20082008','ddmmyyyy') then
                   a_ := kod_ || lpad(kv_,3,'0') || '00000000000000' ;
                else
                   a_ := '1' || kod_ || lpad(kv_,3,'0') || '00000000000000' ;
                   d#44_ := kod_;  --'17';
                end if;
                b_ := TO_CHAR(SN_) ;

                INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, ref)
                VALUES
                                       (nls_, kv_, data_, a_, b_, nbuc_, ref_);

                -- курс
                if dat_ >= to_date('20082008','ddmmyyyy') and
                   d#44_ in ('12','13','14','15','16','17','24','27')
                then
                   acc_ := accd_;
                   acc3800_ := acc_;
                   dk_ := 1;

                   BEGIN
                      select acc3801, acc6204
                         into acc3801_, acc6204_
                      from vp_list
                      where acc3800 = acc_;

                      select sum(o.s)
                         into se1_
                      from opldok o, opldok o1, accounts a1
                      where o.fdat = data_
                        and o.ref = ref_
                        and o.acc = acc3801_
                        and o.dk = 1
                        and o1.fdat = o.fdat
                        and o1.ref = o.ref
                        and o1.tt = tt_
                        and o1.tt = o.tt
                        and o1.stmt = o.stmt
                        and o1.dk = 1-1
                        and o1.acc not in (acc6204_)
                        and o1.acc = a1.acc
                        and ( (a1.nls like '100%' and a1.kv = 980) or
                              (substr(a1.nls,1,4) in ('3540','3640') and a1.kv = 980)
                            ) ;
                   exception when no_data_found then
                      null;
                   END;

                   if se1_ <> 0 then
                      se_ := se1_;
                   end if;

                   if kod_ in ('12','13','14','15','16','17') then
                      kod_ := 'A' || substr(kod_,2,1);
                   end if;

                   a_ := '4' || kod_ || lpad(kv_,3,'0') || '00000000000000' ;
                   if kurs_ is null then -- розрахований курс
                      b_ := LTRIM(TO_CHAR(ROUND(se_*bsu_/sn_,5)*dig_/dl_,fmt_));

                      if mfo_ = 333368 then
                         BEGIN
                            SELECT NVL(sum(p.s*100),0)
                               into sum_eqv_
                            from provodki p, vp_list v
                            where p.fdat = Dat_
                              and p.isp = userid1_
                              and p.kv = 980
                              and v.acc3800 = acc3800_
                              and p.acck = v.acc3801;
                         EXCEPTION WHEN NO_DATA_FOUND THEN
                            BEGIN
                               select rate_o
                                  into kurs1_
                               from cur_rates$base
                               where vdate = datd_
                                 and kv = kv1_
                                 and branch = branch_;
                            EXCEPTION WHEN NO_DATA_FOUND THEN
                               null;
                            END;
                         END;

                         if sum_eqv_ <> 0 then

                            if sum1_ = 8 then
                               kol_ := 1;
                            else
                               kol_ := 0;
                            end if;

                            b_ := ltrim(TO_CHAR((sum_eqv_/(round(sn_*31.1/100,kol_))*31.1034807/100),fmt_));
                            comm_ := comm_||' курс розрахований '||b_||
                                     ' сума екв. = '||to_char(sum_eqv_/100,'999999999D00');
                         end if;
                      end if;
                   else -- введений курс
                      b_ := ltrim(TO_CHAR(to_number(kurs_)*bsu_/div_,fmt_));
                   end if;

                   INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, ref)
                   VALUES
                                          (nls_, kv_, data_, a_, b_, nbuc_, ref_);

                   -- объем**курс
                   a_ := '3' || kod_ || lpad(kv_,3,'0') || '00000000000000' ;
                   b_ := TO_CHAR(sn_*b_);

                   INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, ref)
                   VALUES
                                          (nls_, kv_, data_, a_, b_, nbuc_, ref_);
                end if;
             end if;
             prf_ := 1;
          END IF;

          IF sn_ > 0 and d#44_ = '00' and prf_ = 0 and substr(nls_,1,3) = '110' and
             substr(nlsk_,1,4) not in ('1101','1102','1107','3678','3800',
                                       '3902','3903','3906','3907')
          THEN
             -- объем
             if dat_ < to_date('20082008','ddmmyyyy') then
                a_ := d#44_ || lpad(kv_,3,'0') || '00000000000000' ;
             else
                a_ := '1' || d#44_ || lpad(kv_,3,'0') || '00000000000000' ;
             end if;

             b_ := TO_CHAR(SN_) ;
             INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, ref)
             VALUES
                                    (nls_, kv_, data_, a_, b_, nbuc_, ref_);

             -- курс
             if dat_ >= to_date('20082008','ddmmyyyy') and
                d#44_ in ('12','13','14','15','16','17','24','27')
             then
                if nls_ like '3800%' then
                   acc_ := accd_;
                   dk_ := 1;
                else
                   acc_ := acck_;
                   dk_ := 0;
                end if;

                BEGIN
                   select acc3801, acc6204
                      into acc3801_, acc6204_
                   from vp_list
                   where acc3800 = acc_;

                   select sum(o.s)
                      into se1_
                   from opldok o, opldok o1, accounts a1
                   where o.fdat = data_
                     and o.ref = ref_
                     and o.acc = acc3801_
                     and o.dk = 1   --dk_
                     and o1.fdat = o.fdat
                     and o1.ref = o.ref
                     and o1.tt = tt_
                     and o1.tt = o.tt
                     and o1.stmt = o.stmt
                     and o1.dk = 1-1   --dk_
                     and o1.acc not in (acc6204_)
                     and o1.acc = a1.acc
                     and ( (a1.nls like '100%' and a1.kv = 980) or
                           (substr(a1.nls,1,4) in ('3540','3640') and a1.kv = 980)
                         ) ;
                exception when no_data_found then
                   null;
                END;

                if se1_ <> 0 then
                   se_ := se1_;
                end if;

                if d#44_ in ('12','13','14','15','16','17') then
                   d#44_ := 'A' || substr(d#44_,2,1);
                end if;

                a_ := '4' || d#44_ || lpad(kv_,3,'0') || '00000000000000' ;
                if kurs_ is null then -- розрахований курс
                   b_ := LTRIM(TO_CHAR(ROUND(se_*bsu_/sn_,5)*dig_/dl_,fmt_));
                else -- введений курс
                   b_ := ltrim(TO_CHAR(to_number(kurs_)*bsu_/div_,fmt_));
                end if;

                INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, ref)
                VALUES
                                       (nls_, kv_, data_, a_, b_, nbuc_, ref_);

                -- объем**курс
                a_ := '3' || d#44_ || lpad(kv_,3,'0') || '00000000000000' ;
                b_ := TO_CHAR(sn_*b_);

                INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, ref)
                VALUES
                                       (nls_, kv_, data_, a_, b_, nbuc_, ref_);

             end if;

             prf_ := 1;
          END IF;

          IF sn_ > 0 and d#44_ = '00' and prf_ = 0 and
             substr(nls_,1,4) not in ('1101','1102','1107','3678','3800','3902','3903','3906','3907') and
             substr(nlsk_,1,3) = '110'
          THEN
             -- объем
             if dat_ < to_date('20082008','ddmmyyyy') then
                a_ := d#44_ || lpad(kv_,3,'0') || '00000000000000' ;
             else
                a_ := '1' || d#44_ || lpad(kv_,3,'0') || '00000000000000' ;
             end if;
             b_ := TO_CHAR(SN_) ;
             INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, ref)
             VALUES
                                    (nls_, kv_, data_, a_, b_, nbuc_, ref_);

             if dat_ >= to_date('20082008','ddmmyyyy') and
                d#44_ in ('12','13','14','15','16','17','24','27')
             then

                if nls_ like '3800%' then
                   acc_ := accd_;
                   dk_ := 1;
                else
                   acc_ := acck_;
                   dk_ := 0;
                end if;

                BEGIN
                   select acc3801, acc6204
                      into acc3801_, acc6204_
                   from vp_list
                   where acc3800=acc_;

                   select sum(o.s)
                      into se1_
                   from opldok o, opldok o1, accounts a1
                   where o.fdat = data_
                     and o.ref = ref_
                     and o.acc = acc3801_
                     and o.dk = dk_
                     and o1.fdat = o.fdat
                     and o1.ref = o.ref
                     and o1.tt = tt_
                     and o1.tt = o.tt
                     and o1.stmt = o.stmt
                     and o1.dk = 1-dk_
                     and o1.acc not in (acc6204_)
                     and o1.acc = a1.acc
                     and ( (a1.nls like '100%' and a1.kv = 980) or
                           (substr(a1.nls,1,4) in ('3540','3640') and a1.kv = 980)
                         ) ;
                exception when no_data_found then
                   null;
                END;

                if se1_ <> 0 then
                   se_ := se1_;
                end if;

                if d#44_ in ('12','13','14','15','16','17') then
                   d#44_ := 'A' || substr(d#44_,2,1);
                end if;

                a_ := '4' || d#44_ || lpad(kv_,3,'0') || '00000000000000' ;
                if kurs_ is null then -- розрахований курс
                   b_ := LTRIM(TO_CHAR(ROUND(se_*bsu_/sn_,5)*dig_/dl_,fmt_));
                else -- введений курс
                   b_ := ltrim(TO_CHAR(to_number(kurs_)*bsu_/div_,fmt_));
                end if;
                INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, ref)
                VALUES
                                       (nls_, kv_, data_, a_, b_, nbuc_, ref_);

                -- объем**курс
                a_ := '3' || d#44_ || lpad(kv_,3,'0') || '00000000000000' ;
                b_ := TO_CHAR(sn_*b_);

                INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, ref)
                VALUES
                                       (nls_, kv_, data_, a_, b_, nbuc_, ref_);

             end if;

             prf_ := 1;
          END IF;

          IF SN_ > 0 and prf_ = 0 THEN
             IF substr(nls_,1,3) = '110' and to_number(d#44_) > 0 THEN
                -- объем
                if dat_ < to_date('20082008','ddmmyyyy') then
                   a_ := d#44_ || lpad(kv_,3,'0') || '00000000000000' ;
                else
                   a_ := '1' || d#44_ || lpad(kv_,3,'0') || '00000000000000' ;
                end if;
                b_ := TO_CHAR(SN_) ;
                INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, ref) VALUES
                                       (nls_, kv_, data_, a_, b_, nbuc_, ref_);

                if dat_ >= to_date('20082008','ddmmyyyy') and
                   d#44_ in ('12','13','14','15','16','17','24','27')
                then

                   if nls_ like '3800%' then
                      acc_ := accd_;
                      acc3800_ := acc_;
                      dk_ := 1;
                   else
                      acc_ := acck_;
                      acc3800_ := acc_;
                      dk_ := 0;
                   end if;

                   BEGIN
                      select acc3801, acc6204
                         into acc3801_, acc6204_
                      from vp_list
                      where acc3800 = acc_;

                      select sum(o.s)
                         into se1_
                      from opldok o, opldok o1, accounts a1
                      where o.fdat = data_
                        and o.ref = ref_
                        and o.acc = acc3801_
                        and o.dk = dk_
                        and o1.fdat = o.fdat
                        and o1.ref = o.ref
                        and o1.tt = tt_
                        and o1.tt = o.tt
                        and o1.stmt = o.stmt
                        and o1.dk = 1-dk_
                        and o1.acc not in (acc6204_)
                        and o1.acc = a1.acc
                    and ( (a1.nls like '100%' and a1.kv = 980) or
                          (substr(a1.nls,1,4) in ('3540','3640') and a1.kv = 980)
                        ) ;
                   exception when no_data_found then
                      null;
                   END;

                   if se1_ <> 0 then
                      se_ := se1_;
                   end if;

                   if d#44_ in ('12','13','14','15','16','17') then
                      d#44_ := 'A' || substr(d#44_,2,1);
                   end if;

                   a_ := '4' || d#44_ || lpad(kv_,3,'0') || '00000000000000' ;
                   if kurs_ is null then -- розрахований курс
                      b_ := LTRIM(TO_CHAR(ROUND(se_*bsu_/sn_,5)*dig_/dl_,fmt_));

                      if mfo_ = 333368 then
                         BEGIN
                            SELECT NVL(sum(p.s*100),0)
                               into sum_eqv_
                            from provodki p, vp_list v
                            where p.fdat = Dat_
                              and p.isp = userid1_
                              and p.kv = 980
                              and v.acc3800 = acc3800_
                              and p.acck = v.acc3801;
                         EXCEPTION WHEN NO_DATA_FOUND THEN
                            BEGIN
                               select rate_o
                                  into kurs1_
                               from cur_rates$base
                               where vdate = datd_
                                 and kv = kv1_
                                 and branch = branch_;
                            EXCEPTION WHEN NO_DATA_FOUND THEN
                               null;
                            END;
                         END;

                         if sum_eqv_ <> 0 then

                            if sum1_ = 8 then
                               kol_ := 1;
                            else
                               kol_ := 0;
                            end if;

                            b_ := ltrim(TO_CHAR((sum_eqv_/(round(sn_*31.1/100,kol_))*31.1034807/100),fmt_));
                            comm_ := comm_||' курс розрахований '||b_||
                                    ' сума екв. = '||to_char(sum_eqv_/100,'999999999D00');
                         end if;
                      end if;
                   else -- введений курс
                      b_ := ltrim(TO_CHAR(to_number(kurs_)*bsu_/div_,fmt_));
                   end if;

                   INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, ref)
                   VALUES
                                          (nls_, kv_, data_, a_, b_, nbuc_, ref_);

                   -- объем**курс
                   a_ := '3' || d#44_ || lpad(kv_,3,'0') || '00000000000000' ;
                   b_ := TO_CHAR(sn_*b_);

                   INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, ref)
                   VALUES
                                          (nls_, kv_, data_, a_, b_, nbuc_, ref_);
                end if;
             END IF;

             IF substr(nlsk_,1,3) = '110' and to_number(d#44_) > 0 THEN
                -- объем
                if dat_ < to_date('20082008','ddmmyyyy') then
                   a_ := d#44_ || lpad(kv_,3,'0') || '00000000000000' ;
                else
                   a_ := '1' || d#44_ || lpad(kv_,3,'0') || '00000000000000' ;
                end if;
                b_ := TO_CHAR(SN_) ;
                INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, ref)
                VALUES
                                       (nlsk_, kv_, data_, a_, b_, nbuc_, ref_);

                if dat_ >= to_date('20082008','ddmmyyyy') and
                   d#44_ in ('12','13','14','15','16','17')
                then
                   if nls_ like '3800%' then
                      acc_ := accd_;
                      acc3800_ := acc_;
                      dk_ := 1;
                   else
                      acc_ := acck_;
                      acc3800_ := acc_;
                      dk_ := 0;
                   end if;

                   BEGIN
                      select acc3801, acc6204
                         into acc3801_, acc6204_
                      from vp_list
                      where acc3800 = acc_;

                      select sum(o.s)
                         into se1_
                      from opldok o, opldok o1, accounts a1
                      where o.fdat = data_
                        and o.ref = ref_
                        and o.acc = acc3801_
                        and o.dk = dk_
                        and o1.fdat = o.fdat
                        and o1.ref = o.ref
                        and o1.tt = tt_
                        and o1.tt = o.tt
                        and o1.stmt = o.stmt
                        and o1.dk = 1-dk_
                        and o1.acc not in (acc6204_)
                        and o1.acc = a1.acc
                    and ( (a1.nls like '100%' and a1.kv = 980) or
                          (substr(a1.nls,1,4) in ('3540','3640') and a1.kv = 980)
                        ) ;
                   exception when no_data_found then
                      null;
                   END;

                   if se1_ <> 0 then
                      se_ := se1_;
                   end if;

                   if d#44_ in ('12','13','14','15','16','17') then
                      d#44_ := 'A' || substr(d#44_,2,1);
                   end if;

                   a_ := '4' || d#44_ || lpad(kv_,3,'0') || '00000000000000' ;
                   if kurs_ is null then -- розрахований курс
                      b_ := LTRIM(TO_CHAR(ROUND(se_*bsu_/sn_,5)*dig_/dl_,fmt_));

                      insert into otcn_log (userid, kodf, txt)
                       values (userid_, '44', to_char(b_)||';'||to_char(se_)||';'||to_char(bsu_)||';'||to_char(sn_));

                      if mfo_ = 333368 then
                         BEGIN
                            SELECT NVL(sum(p.s*100),0)
                               into sum_eqv_
                            from provodki p, vp_list v
                            where p.fdat = Dat_
                              and p.isp = userid1_
                              and p.kv = 980
                              and v.acc3800 = acc3800_
                              and p.acck = v.acc3801;
                         EXCEPTION WHEN NO_DATA_FOUND THEN
                            BEGIN
                               select rate_o
                                  into kurs1_
                               from cur_rates$base
                               where vdate = datd_
                                 and kv = kv1_
                                 and branch = branch_;
                            EXCEPTION WHEN NO_DATA_FOUND THEN
                               null;
                            END;
                         END;

                         if sum_eqv_ <> 0 then

                            if sum1_ = 8 then
                               kol_ := 1;
                            else
                               kol_ := 0;
                            end if;

                            b_ := ltrim(TO_CHAR((sum_eqv_/(round(sn_*31.1/100,kol_))*31.1034807/100),fmt_));
                            comm_ := comm_||' курс розрахований '||b_||
                                    ' сума екв. = '||to_char(sum_eqv_/100,'999999999D00');
                         end if;
                      end if;
                   else -- введений курс
                      b_ := ltrim(TO_CHAR(to_number(kurs_)*bsu_/div_,fmt_));
                   end if;

                   INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, ref)
                   VALUES
                                          (nlsk_, kv_, data_, a_, b_, nbuc_, ref_);

                   -- объем**курс
                   a_ := '3' || D#44_ || lpad(kv_,3,'0') || '00000000000000' ;
                   b_ := TO_CHAR(sn_*b_);

                   INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, ref)
                   VALUES
                                          (nlsk_, kv_, data_, a_, b_, nbuc_, ref_);

                end if;
             END IF;

          END IF;
       END LOOP;
    CLOSE OPL_DOK;
end if;
    ----------------------------------------------------------------------------
    if dat_ >=to_date('20082008','ddmmyyyy') then
       -- межбанк
       OPEN OPL_DOK1;
       LOOP
          FETCH OPL_DOK1 INTO accd_, nls_, kv_, acck_, nlsk_, ref_, mfoa_, mfob_,
                              nlsb_, ref_, data_, tag_, d39_, kurs_, sum1_ ;
          EXIT WHEN OPL_DOK1%NOTFOUND;

          kol_ := 0;
          IF mfoa_ <> mfob_ THEN
             SELECT count(*) INTO kol_ FROM v_branch
             WHERE mfob_ = mfo and mfo <> mfou;
          END IF;

          --select nlsb into nlsb_ from oper where ref=ref_;

          IF SUM1_ <> 0 and (substr(nlsb_,1,4) = '2600' or not ((d39_ in ('92','93','94','112') and
                             '3901' in (substr(nls_,1,4), substr(nlsk_,1,4)) and
                              mfoa_ = mfob_) or
                             (d39_ in ('95','96','97','122') and kol_ <> 0)))
          then

             VVV := lpad(kv_,3,'0');

             IF substr(tag_,1,4) in ('D#39','D#44') THEN
                -- покупка или продажа?
                IF substr(nls_,1,4) = '3800' and d39_ in ('92','93','94','112') THEN
                   d39_ := '122';
                END IF;

                IF d39_ in ('92','93','94','112') THEN
                   nls1_ := nlsk_;
                   acc_ := acck_;
                ELSE
                   nls1_ := nls_;
                   acc_ := accd_;
                END IF;

                ddd39_ := substr(d39_,1,3);
                ref1_ := ref_ ;

                if ddd39_ = '112' then
                   ddd39_ := '92';
                end if;
                if ddd39_ = '122' then
                   ddd39_ := '95';
                end if;

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
                                     WHERE rr.kv=kv_ and rr.vdate<=dat_);
                exception
                   when no_data_found then
                   rate_o_ :=  kurs_;
                   bsu_ := 1;
                end;

                if kurs_ = '1' then
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
          END IF;
       END LOOP;
       CLOSE OPL_DOK1;
    end if;
    ---------------------------------------------------
    ---------------------------------------------------
    DELETE FROM tmp_nbu where kodf='44' and datf= dat_;
    ---------------------------------------------------
    if dat_ < to_date('20082008','ddmmyyyy') then
       OPEN BaseL;
       LOOP
          FETCH BaseL INTO  kodp_, znap_;
          EXIT WHEN BaseL%NOTFOUND;
          b_:=TO_CHAR(ROUND(TO_NUMBER(znap_)/10,0));
          INSERT INTO tmp_nbu
               (kodf, datf, kodp, znap)
          VALUES
               ('44', Dat_, kodp_, b_);
       END LOOP;
       CLOSE BaseL;
    end if;

    if dat_ >=to_date('20082008','ddmmyyyy') then
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
    end if;
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
