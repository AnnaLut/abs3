

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F13_NN.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F13_NN ***

  CREATE OR REPLACE PROCEDURE BARS.P_F13_Nn (Dat_ DATE  ,
                                      sheme_ VARCHAR2 DEFAULT 'G')  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	ѕроцедура формирование файла #13 дл€  Ѕ
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
% VERSION     : 18/04/2018 (06/02/2018)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    параметры: Dat_ - отчетна€ дата
    sheme_ - схема формировани€
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
06.02.2018 добавлен курсор SALDO_KOR_PP дл€ включени€ корректирующих
           проводок за пред≥дущий мес€ц в символ 35
05.02.2018 добавлен курсор OPER_KOR_PP дл€ исключени€ корректирующих
           символов кассплана за предыдущий мес€ц
           (значение показател€ будет формироватьс€ со знаком минус)
18.01.2018 добавлен курсор (OPER_KOR) дл€ включени€ символов кассплана
           корректирующих за мес€ц и
           добавлен курсор (SALDO_KOR) дл€ включени€ корректирующих
           за мес€ц дл€ остатков
09.11.2010 если в OPER занесены внебал.символа, то при обработке внебал.
           символов из табл.OTCN_F13_ZBSK выполн€етс€ суммирование
           значений данных сиволов (курсор BaseL)
20/09/2010 убрал ORDER BY в курсоре BASEL
17/09/2010 добавила –≈‘ документа в протокол
03.10.2007 дл€ проводки ƒт 2600 и  т 2625 берем ACC  т счета (ранее было
           ACC ƒт счета)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
kodf_    VARCHAR2(2):='13';
kodf_ext_ VARCHAR2(2):='13';
typ_ NUMBER;

nls_     VARCHAR2(15);
nls1_    varchar2(15);
nlsd_    varchar2(15);
nlsk_    VARCHAR2(15);
nazn_    varchar2(100);
mfo_     VARCHAR2(12);
data_    DATE;
kv_      SMALLINT;
s35      DECIMAL(24);
s70      DECIMAL(24);
kodp_    VARCHAR2(10);
znap_    VARCHAR2(30);
sk_      SMALLINT;
sk2_     SMALLINT;
sk_o_    SMALLINT;
s_       DECIMAL(24);
dk_      Number;
dk1_     Number;
nbu_     SMALLINT;
kol_     NUMBER;
flag_    NUMBER;
ref_     NUMBER;
ref1_    Number;
stmt_    Number;
userid_  NUMBER;
dat1_    DATE;
dat2_    DATE;
dc_      INTEGER;
nbuc1_   VARCHAR2(12);
nbuc_    VARCHAR2(12);
comm_    varchar2(1000);
acc_     NUMBER;
tt_      varchar2(3);
tt_pr    varchar2(3);
pr_bak   Number;
pr_doch  Number;
acc1_    NUMBER;
sql_     VARCHAR2(1000):=NULL;
TYPE CURSORType IS REF CURSOR;
CURS_ CURSORType;

--- позабалансовый сим.89 из OPERW (tag='SK_ZB') выручка прошлого мес€ца
--- проводитс€ в первые числа следующего мес€ца
CURSOR ZBSIMVOL89 IS
   SELECT  /*+ leading(s) */
         unique o.nlsa, o.kv, p.FDAT,
         SUBSTR(s.value,1,2), p.s, p.ref
   FROM OPER o, OPLDOK p, ACCOUNTS c, OPERW s
   WHERE c.acc=p.acc
     and c.kv=980
     and p.REF=s.REF
     and s.tag='SK_ZB'
     and SUBSTR(s.value,1,2)='89'
     and p.FDAT between Dat_ and Dat2_
     and o.REF=p.REF
     and p.SOS=5
     and p.DK=0 ;

-- коригуюч≥ документи за попередн≥й м≥с€ць
CURSOR OPER_KOR_PP IS
   SELECT  s.acc, s.nls, o.nlsa, o.kv, o.dk, p.fdat, p.ref, p.stmt,
           decode(p.tt, o.tt, o.sk, t.sk), p.s, o.tt, NVL(o.sk,0), p.dk,
           decode(p.tt, o.tt, 0, 1) pr -- признак дочерней операции
   FROM OPER o, OPLDOK p, ACCOUNTS s, tts t
   WHERE p.acc = s.acc           AND
         s.tip = 'KAS'           AND
         s.nbs in ('1001','1002','1003','1004') AND
         s.kv = 980              AND
         p.fdat between Dat1_  AND Dat1_ + 10  AND
         o.ref = p.ref           AND
         o.vob = 96              AND
         --o.vdat = Dat_           AND
         p.sos = 5               AND
         p.tt = t.tt ;

-- коригуюч≥ за м≥с€ць залишки
CURSOR SALDO_KOR_PP IS
   SELECT  s.acc, s.nls, s.kv, SUM(decode(p.dk, 0, p.s, -p.s)) SUM_KOR
   FROM OPER o, OPLDOK p, ACCOUNTS s
   WHERE p.acc = s.acc           AND
         s.tip = 'KAS'           AND
         s.nbs in ('1001','1002','1003','1004') AND
         s.kv = 980              AND
         p.fdat between Dat1_  AND Dat1_ + 10 AND
         o.ref = p.ref           AND
         o.vob = 96              AND
         --o.vdat = Dat_           AND
         p.sos = 5
group by s.acc, s.nls, s.kv
order by 1;

-- коригуюч≥ за м≥с€ць документи
CURSOR OPER_KOR IS
   SELECT  s.acc, s.nls, o.nlsa, o.kv, o.dk, p.fdat, p.ref, p.stmt,
           decode(p.tt, o.tt, o.sk, t.sk), p.s, o.tt, NVL(o.sk,0), p.dk,
           decode(p.tt, o.tt, 0, 1) pr -- признак дочерней операции
   FROM OPER o, OPLDOK p, ACCOUNTS s, tts t
   WHERE p.acc = s.acc           AND
         s.tip = 'KAS'           AND
         s.nbs in ('1001','1002','1003','1004') AND
         s.kv = 980              AND
         p.fdat between Dat_ + 1 AND Dat2_  AND
         o.ref = p.ref           AND
         o.vob = 96              AND
         o.vdat = Dat_           AND
         p.sos = 5               AND
         p.tt = t.tt ;

-- коригуюч≥ за м≥с€ць залишки
CURSOR SALDO_KOR IS
   SELECT  s.acc, s.nls, s.kv, SUM(decode(p.dk, 0, p.s, -p.s)) SUM_KOR
   FROM OPER o, OPLDOK p, ACCOUNTS s
   WHERE p.acc = s.acc           AND
         s.tip = 'KAS'           AND
         s.nbs in ('1001','1002','1003','1004') AND
         s.kv = 980              AND
         p.fdat between Dat_ + 1 AND Dat2_  AND
         o.ref = p.ref           AND
         o.vob = 96              AND
         o.vdat = Dat_           AND
         p.sos = 5
group by s.acc, s.nls, s.kv
order by 1;

CURSOR BaseL IS
   SELECT kodp, nbuc, SUM (znap)
   FROM RNBU_TRACE
   WHERE TO_NUMBER(kodp)>73
     and comm like 'SK_ZB%'
   GROUP BY kodp,nbuc;

-- коригуюч≥ за м≥с€ць
CURSOR BaseL1 IS
   SELECT kodp, nbuc, SUM (znap)
   FROM RNBU_TRACE
   WHERE TO_NUMBER(kodp) < 73
     and comm like '%коригуюч_ за%м_с€ць%'
   GROUP BY kodp,nbuc;
------------------------------------------------------------------------------
BEGIN
   commit;

   EXECUTE IMMEDIATE 'ALTER SESSION ENABLE PARALLEL DML';
-------------------------------------------------------------------
   logger.info ('P_F13_NN: Begin for '||to_char(dat_,'dd.mm.yyyy'));

   Dat1_ := TRUNC(Dat_, 'MM');
   Dat2_ := TRUNC(Dat_ + 10);

   -- определение наличи€ табл. OTCN_F13_ZBSK
   SELECT COUNT(*) INTO flag_
   FROM ALL_TABLES
   WHERE owner='BARS' AND table_name = 'OTCN_F13_ZBSK' ;

    IF flag_ > 0 THEN
        sql_ := 'SELECT accd ACC, nlsd NLS, acck ACC1, nlsk NLSK, kv KV, '||
                'fdat DATA, to_char(NVL(SK_ZB,0)) KODP, to_char(s) ZNAP, ref '||
                'FROM  otcn_f13_zbsk '||
                'WHERE NVL(sk_zb,0) > 0 AND fdat BETWEEN :Dat1_ AND :Dat_';
    END IF;

    nbu_:= Isnbubank();

    -- определение начальных параметров
    P_Proc_Set(kodf_,sheme_,nbuc1_,typ_);

    P_F12_Nn_sb (Dat_,sheme_,kodf_ext_);

    logger.info ('P_F13_NN: End etap 1 for '||to_char(dat_,'dd.mm.yyyy'));
    -------------------------------------------------------------------
    userid_ := user_id;
    -------------------------------------------------------------------
    OPEN ZBSIMVOL89;
    LOOP
       FETCH ZBSIMVOL89 INTO nls_, kv_, data_, sk_, s_, ref_ ;
       EXIT WHEN ZBSIMVOL89%NOTFOUND;

        IF typ_>0 THEN
           nbuc_ := NVL(F_Codobl_Tobo(acc_,typ_),nbuc1_);
        ELSE
           nbuc_ := nbuc1_;
        END IF;

       IF s_<>0 THEN
          kodp_:= lpad(TO_CHAR(sk_), 2, '0');
          znap_:= TO_CHAR(s_);
          INSERT INTO RNBU_TRACE (nls, kv, odate, kodp, znap, nbuc, ref)
          VALUES (nls_, kv_, data_, kodp_, znap_, nbuc_, ref_);
       END IF;
    END LOOP;
    CLOSE ZBSIMVOL89;

    logger.info ('P_F13_NN: End etap 2 for '||to_char(dat_,'dd.mm.yyyy'));

    -- формирование внебалансовых символов из табл. OTCN_F13_ZBSK
    IF sql_ is not null THEN
       OPEN CURS_ FOR sql_ USING Dat1_, Dat_;

       loop
           fetch CURS_ into acc_, nls_, acc1_, nlsk_, kv_, data_, kodp_, znap_, ref_;
           EXIT WHEN CURS_%NOTFOUND;

           IF substr(nls_,1,3) not in ('262','263') and 
              nls_ not like '2909%' and
              nls_ not like '1911%' 
           THEN
              nls_:=nlsk_;
              acc_:=acc1_;
           END IF;

           IF typ_>0 THEN
              nbuc_ := NVL(F_Codobl_Tobo(acc_,typ_),nbuc1_);
           ELSE
              nbuc_ := nbuc1_;
           END IF;

           INSERT INTO RNBU_TRACE (nls, kv, odate, kodp, znap, nbuc, ref, comm) 
           VALUES (nls_, kv_, data_, kodp_, znap_, nbuc_, ref_, 'SK_ZB');
       end loop;

       close CURS_;
    END IF;

    logger.info ('P_F13_NN: End etap 3 for '||to_char(dat_,'dd.mm.yyyy'));

    -- формирование корректирующих за мес€ц символов кассового плана
    OPEN OPER_KOR;
    LOOP
       FETCH OPER_KOR INTO acc_, nls1_, nls_, kv_, dk_, data_, ref_, stmt_, sk_, s_, tt_, sk_o_,
                    dk1_, pr_doch ;
       EXIT WHEN OPER_KOR%NOTFOUND;

       comm_ := 'коригуючi за мiс€ць: ';

       -- вибираЇмо рахунок кореспондент дл€ рахунку каси
       BEGIN
          select tt, nlsd, nlsk, substr(nazn,1,100)
             into tt_pr, nlsd_, nlsk_, nazn_
          from provodki
          where ref = ref_
            and fdat= Data_
            and kv  = 980
            and nlsd= nls1_
            and stmt=stmt_
            and s*100=s_;

          comm_ := comm_ || ' ƒт рах. = ' || nlsd_ || '  т рах. = ' || nlsk_ ||
                   '  ' || nazn_;
       EXCEPTION WHEN NO_DATA_FOUND THEN
          BEGIN
             select tt, nlsd, nlsk, substr(nazn,1,100)
                into tt_pr, nlsd_, nlsk_, nazn_
             from provodki
             where ref = ref_
               and stmt=stmt_
               and fdat= Dat_
               and kv  = 980
               and nlsk= nls1_
               and s*100=s_;

             comm_ := comm_ || ' ƒт рах. = ' || nlsd_ || '  т рах. = ' || nlsk_ ||
                      '  ' || nazn_;
          EXCEPTION WHEN NO_DATA_FOUND THEN
             comm_ := comm_ || ' кореспондент не знайдений ';
          END;
       END;

       IF typ_>0 THEN
          nbuc_ := NVL(F_Codobl_Tobo(acc_,typ_),nbuc1_);
       ELSE
          nbuc_ := nbuc1_;
       END IF;

       IF sk_ is null THEN
          begin
             select to_number(substr(value,1,2))  into sk_
             from operw where ref=ref_ and tag='SK';
          exception when others then sk_ := 0;
          end;
       END IF ;

       -- по насто€нию ƒепартамента —Ѕ≈–банка разделили операции TOC и TOP, поэтому возникли проблемы
       -- заполнени€ —  дл€ дочерней операции TOP (раньше символ был зашит в эту операцию)
       IF sk_ = 0 AND tt_ in ('TOC', 'TCC') and pr_doch = 1 then
          comm_ := '!!! авт. замена ' || sk_  ||' на '|| sk_o_  ||' '|| comm_;
          sk_ := sk_o_;
       end if;

       -- дл€ проводок вида ƒт 1001   т 1001,1002,1003,1004 или
       -- ƒт 1001,1002,1003,1004   т 1001
       IF substr(nls_,1,4) in ('1001','1002','1003','1004') and--nls_=nls1_ and
          dk_=1 and  dk1_=1 and sk_=39 and tt_ = 'ћ√–' THEN
          comm_ := '!!! авт. замена ' || sk_  ||' на 66 '|| comm_;
          sk_:=66;
       END IF;

       IF substr(nls_,1,4) in ('1001','1002','1003','1004') and substr(nls1_,1,4) in ('1001','1002','1003','1004') and
          dk1_=0 and sk_=66 THEN
          comm_ := '!!! авт. замена ' || sk_  ||' на 39 '|| comm_;
          sk_:='39';
       END IF;

       IF substr(nls_,1,4) in ('1001','1002','1003','1004') and substr(nls1_,1,4) in ('1001','1002','1003','1004') and
          dk1_=1 and sk_=39 THEN
          comm_ := '!!! авт. замена ' || sk_  ||' на 66 '|| comm_;
          sk_:=66;
       END IF;

       IF tt_ in ('025','K33','045','046','A22','150','151','AA3','AA4','AA5','AA6','AA7','AA8') then
          BEGIN
             select count(*)
                into pr_bak
             from provodki
             where ref=ref_
               and tt='BAK';
          EXCEPTION WHEN NO_DATA_FOUND THEN
             pr_bak := 0;
          END;

          if tt_ in ('025','K33','045','046','A22','150','AA4','AA6','AA8') and pr_bak != 0 and sk_o_ < 40 then
             if tt_ = tt_pr then
                comm_ := '!!! авт. замена ' || sk_o_  ||' на 32 '|| comm_;
                sk_ := 32;
             end if;
             if tt_ != tt_pr and tt_pr = 'BAK' and nlsk_ like '100%' and sk_o_ < 40 then
                comm_ := '!!! авт. замена ' || sk_o_  ||' на 61 '|| comm_;
                sk_ := 61;
             end if;
          end if;

          if tt_ in ('151','AA3','AA5','AA7') and pr_bak != 0 and sk_o_ > 39 then
             if tt_ = tt_pr then
                comm_ := '!!! авт. замена ' || sk_o_  ||' на 61 '|| comm_;
                sk_ := 61;
             end if;
             if tt_ != tt_pr and tt_pr = 'BAK' and nlsd_ like '100%' and sk_o_ > 39 then
                comm_ := '!!! авт. замена ' || sk_o_  ||' на 32 '|| comm_;
                sk_ := 32;
             end if;
          end if;
       END IF;

       -- добавил 02.10.2013 в Ќиколаеве была проводка дл€ Ўвидкоњ коп≥йки
       -- один REF=31025355 ƒт 1002  т 2909 и ƒт 2909  т 1002
       if tt_ = '416' and tt_ != tt_pr and tt_pr = 'K16' and nlsk_ like '100%' and sk_o_ < 40 then
          comm_ := '!!! авт. замена ' || sk_o_  ||' на 61 '|| comm_;
          sk_ := 61;
       end if;

       IF s_<>0 THEN
          kodp_:= iif_N(sk_,10,'0','','') || TO_CHAR(sk_);
          znap_:= TO_CHAR(s_) ;
          INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, ref, comm, nbuc) VALUES
                                 (nls_, kv_, data_, kodp_, znap_, ref_, substr(comm_, 1, 200), nbuc_);
       END IF;
    END LOOP;
    CLOSE OPER_KOR;

    -- формирование корректирующих за мес€ц залишки
    OPEN SALDO_KOR;
    LOOP
       FETCH SALDO_KOR INTO acc_, nls_, kv_, s_ ;
       EXIT WHEN SALDO_KOR%NOTFOUND;

       comm_ := 'коригуючi за мiс€ць: рах. = ' || nls_ || ' вал. = ' || to_char(kv_);

       IF typ_>0 THEN
          nbuc_ := NVL(F_Codobl_Tobo(acc_,typ_),nbuc1_);
       ELSE
          nbuc_ := nbuc1_;
       END IF;

       IF s_ <> 0
       THEN
          kodp_ := '70';
          znap_ := TO_CHAR(s_) ;
          INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, comm, nbuc) VALUES
                                 (nls_, kv_, data_, kodp_, znap_, substr(comm_, 1, 200), nbuc_);
       END IF;
    END LOOP;
    CLOSE SALDO_KOR;


    -- формирование корректирующих за мес€ц символов кассового плана
    OPEN OPER_KOR_PP;
    LOOP
       FETCH OPER_KOR_PP INTO acc_, nls1_, nls_, kv_, dk_, data_, ref_, stmt_, sk_, s_, tt_, sk_o_,
                    dk1_, pr_doch ;
       EXIT WHEN OPER_KOR_PP%NOTFOUND;

       comm_ := 'коригуючi за попередн≥й мiс€ць: ';

       -- вибираЇмо рахунок кореспондент дл€ рахунку каси
       BEGIN
          select tt, nlsd, nlsk, substr(nazn,1,100)
             into tt_pr, nlsd_, nlsk_, nazn_
          from provodki
          where ref = ref_
            and fdat= Data_
            and kv  = 980
            and nlsd= nls1_
            and stmt=stmt_
            and s*100=s_;

          comm_ := comm_ || ' ƒт рах. = ' || nlsd_ || '  т рах. = ' || nlsk_ ||
                   '  ' || nazn_;
       EXCEPTION WHEN NO_DATA_FOUND THEN
          BEGIN
             select tt, nlsd, nlsk, substr(nazn,1,100)
                into tt_pr, nlsd_, nlsk_, nazn_
             from provodki
             where ref = ref_
               and stmt=stmt_
               and fdat= Dat_
               and kv  = 980
               and nlsk= nls1_
               and s*100=s_;

             comm_ := comm_ || ' ƒт рах. = ' || nlsd_ || '  т рах. = ' || nlsk_ ||
                      '  ' || nazn_;
          EXCEPTION WHEN NO_DATA_FOUND THEN
             comm_ := comm_ || ' кореспондент не знайдений ';
          END;
       END;

       IF typ_>0 THEN
          nbuc_ := NVL(F_Codobl_Tobo(acc_,typ_),nbuc1_);
       ELSE
          nbuc_ := nbuc1_;
       END IF;

       IF sk_ is null THEN
          begin
             select to_number(substr(value,1,2))  into sk_
             from operw where ref=ref_ and tag='SK';
          exception when others then sk_ := 0;
          end;
       END IF ;

       -- по насто€нию ƒепартамента —Ѕ≈–банка разделили операции TOC и TOP, поэтому возникли проблемы
       -- заполнени€ —  дл€ дочерней операции TOP (раньше символ был зашит в эту операцию)
       IF sk_ = 0 AND tt_ in ('TOC', 'TCC') and pr_doch = 1 then
          comm_ := '!!! авт. замена ' || sk_  ||' на '|| sk_o_  ||' '|| comm_;
          sk_ := sk_o_;
       end if;

       -- дл€ проводок вида ƒт 1001   т 1001,1002,1003,1004 или
       -- ƒт 1001,1002,1003,1004   т 1001
       IF substr(nls_,1,4) in ('1001','1002','1003','1004') and--nls_=nls1_ and
          dk_=1 and  dk1_=1 and sk_=39 and tt_ = 'ћ√–' THEN
          comm_ := '!!! авт. замена ' || sk_  ||' на 66 '|| comm_;
          sk_:=66;
       END IF;

       IF substr(nls_,1,4) in ('1001','1002','1003','1004') and substr(nls1_,1,4) in ('1001','1002','1003','1004') and
          dk1_=0 and sk_=66 THEN
          comm_ := '!!! авт. замена ' || sk_  ||' на 39 '|| comm_;
          sk_:='39';
       END IF;

       IF substr(nls_,1,4) in ('1001','1002','1003','1004') and substr(nls1_,1,4) in ('1001','1002','1003','1004') and
          dk1_=1 and sk_=39 THEN
          comm_ := '!!! авт. замена ' || sk_  ||' на 66 '|| comm_;
          sk_:=66;
       END IF;

       IF tt_ in ('025','K33','045','046','A22','150','151','AA3','AA4','AA5','AA6','AA7','AA8') then
          BEGIN
             select count(*)
                into pr_bak
             from provodki
             where ref=ref_
               and tt='BAK';
          EXCEPTION WHEN NO_DATA_FOUND THEN
             pr_bak := 0;
          END;

          if tt_ in ('025','K33','045','046','A22','150','AA4','AA6','AA8') and pr_bak != 0 and sk_o_ < 40 then
             if tt_ = tt_pr then
                comm_ := '!!! авт. замена ' || sk_o_  ||' на 32 '|| comm_;
                sk_ := 32;
             end if;
             if tt_ != tt_pr and tt_pr = 'BAK' and nlsk_ like '100%' and sk_o_ < 40 then
                comm_ := '!!! авт. замена ' || sk_o_  ||' на 61 '|| comm_;
                sk_ := 61;
             end if;
          end if;

          if tt_ in ('151','AA3','AA5','AA7') and pr_bak != 0 and sk_o_ > 39 then
             if tt_ = tt_pr then
                comm_ := '!!! авт. замена ' || sk_o_  ||' на 61 '|| comm_;
                sk_ := 61;
             end if;
             if tt_ != tt_pr and tt_pr = 'BAK' and nlsd_ like '100%' and sk_o_ > 39 then
                comm_ := '!!! авт. замена ' || sk_o_  ||' на 32 '|| comm_;
                sk_ := 32;
             end if;
          end if;
       END IF;

       -- добавил 02.10.2013 в Ќиколаеве была проводка дл€ Ўвидкоњ коп≥йки
       -- один REF=31025355 ƒт 1002  т 2909 и ƒт 2909  т 1002
       if tt_ = '416' and tt_ != tt_pr and tt_pr = 'K16' and nlsk_ like '100%' and sk_o_ < 40 then
          comm_ := '!!! авт. замена ' || sk_o_  ||' на 61 '|| comm_;
          sk_ := 61;
       end if;

       IF s_<>0 THEN
          kodp_:= iif_N(sk_,10,'0','','') || TO_CHAR(sk_);
          znap_:= TO_CHAR(-s_) ;
          INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, ref, comm, nbuc) VALUES
                                 (nls_, kv_, data_, kodp_, znap_, ref_, substr(comm_, 1, 200), nbuc_);
       END IF;
    END LOOP;
    CLOSE OPER_KOR_PP;

    -- формирование корректирующих за предыдущий мес€ц залишки
    OPEN SALDO_KOR_PP;
    LOOP
       FETCH SALDO_KOR_PP INTO acc_, nls_, kv_, s_ ;
       EXIT WHEN SALDO_KOR_PP%NOTFOUND;

       comm_ := 'коригуючi за попередн≥й мiс€ць: рах. = ' || nls_ || ' вал. = ' || to_char(kv_);

       IF typ_>0 THEN
          nbuc_ := NVL(F_Codobl_Tobo(acc_,typ_),nbuc1_);
       ELSE
          nbuc_ := nbuc1_;
       END IF;

       IF s_ <> 0
       THEN
          kodp_ := '35';
          znap_ := TO_CHAR(s_) ;
          INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, comm, nbuc) VALUES
                                 (nls_, kv_, data_, kodp_, znap_, substr(comm_, 1, 200), nbuc_);
       END IF;
    END LOOP;
    CLOSE SALDO_KOR_PP;

    --- позабалансовые символа сформированные процедурой P_F13_NN
    OPEN BaseL;
    LOOP
       FETCH BaseL INTO  kodp_, nbuc_, znap_;
       EXIT WHEN BaseL%NOTFOUND;

       BEGIN
          INSERT INTO TMP_NBU
               (kodf, datf, kodp, znap, nbuc)
          VALUES
               (kodf_, Dat_, kodp_, znap_, nbuc_);
       EXCEPTION WHEN OTHERS THEN
          update tmp_nbu set znap=to_char(to_number(znap)+to_number(znap_))
          where kodf=kodf_
            and datf=Dat_
            and kodp=kodp_
            and nbuc = nbuc_;
       END;

    END LOOP;
    CLOSE BaseL;

    --- коригуюч≥ за м≥с€ць
    OPEN BaseL1;
    LOOP
       FETCH BaseL1 INTO  kodp_, nbuc_, znap_;
       EXIT WHEN BaseL1%NOTFOUND;

       BEGIN
          INSERT INTO TMP_NBU
               (kodf, datf, kodp, znap, nbuc)
          VALUES
               (kodf_, Dat_, kodp_, znap_, nbuc_);
       EXCEPTION WHEN OTHERS THEN
          update tmp_nbu set znap=to_char(to_number(znap)+to_number(znap_))
          where kodf=kodf_
            and datf=Dat_
            and kodp=kodp_
            and nbuc = nbuc_;
       END;

    END LOOP;
    CLOSE BaseL1;

   logger.info ('P_F13_NN: End for '||to_char(dat_,'dd.mm.yyyy'));
----------------------------------------
END P_F13_Nn;
/
show err;

PROMPT *** Create  grants  P_F13_NN ***
grant EXECUTE      on P_F13_NN        to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F13_NN.sql =========*** End *** 
PROMPT ===================================================================================== 
