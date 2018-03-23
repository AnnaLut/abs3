create or replace procedure P_F75SB
( Dat_   DATE
, sheme_ VARCHAR2 DEFAULT 'C'
) IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :    Процедура формирование файла @75 для СБ
% COPYRIGHT   :    Copyright UNITY-BARS Limited, 2009.All Rights Reserved.
%                                                 Версия для Сбербанка
% VERSION     :    08.02.2018 (30.01.2018)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
09.06.2017 - в курсоре SEL выбирались документы только после отчетной даты
             (добавлен период с начала месяца)
19.01.2017 - заполнение tmp_file03 разбито на два периода: отчетный месяц
             и период корректирующих
15.09.2012 - формируем в разрезе кодов территорий
07.11.2011 - переставила місцями блоки (проставлення по рахунку та OB22
             на початок, а потім вже обробка по проводках)
06.10.2011 - додала ще обробку деяких проводок
13.09.2001 - для проводок вида Дт 7 кл. OB22='06' и Кт 3590 OB22='03'
             будет формироваться код 12 (замечание Ровно)
08.09.2001 - добавила обработку проводок вида 1890 - 3800 и 3903 = 2400 и
             вызов F_POP_OTCN (с новым параметром)
15.06.2011 - при формировании файла за 31.05.2011 будет выполняться
             формирование показателей по оборотам за 5 месяцев
10.06.2011 - для коректирующих проводок выбираем дату валютирования
             а не дату оплаты
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
kodf_     varchar2(2) := '75';
ref_      Number;
acc_      Number;
accd_     Number;
acck_     Number;
Dos_      DECIMAL(24);
Dosq_     DECIMAL(24);
Kos_      DECIMAL(24);
Ostn_     DECIMAL(24);
Ostq_     DECIMAL(24);
Dos96_    DECIMAL(24);
Dosq96_   DECIMAL(24);
Kos96_    DECIMAL(24);
Kosq96_   DECIMAL(24);
Dos99_    DECIMAL(24);
Dosq99_   DECIMAL(24);
Kos99_    DECIMAL(24);
Kosq99_   DECIMAL(24);
kodp_     Varchar2(13);
znap_     Varchar2(30);
Kv_       SMALLINT;
Nbs_      Varchar2(4);
Nbsk_     Varchar2(4);
nls_      Varchar2(15);
nlsd_     Varchar2(15);
nlsk_     Varchar2(15);
rnk_      Number;
ob22_     Varchar2(2);
ob22_d    Varchar2(2);
ob22_k    varchar2(2);
kk_       varchar2(2);
data_     Date;
dk_       Varchar2(2);
pr_d      Varchar2(1);
pr_k      Varchar2(1);
userid_   Number;
sql_acc_  varchar2(2000);
ret_      number;
comm_     Varchar2(200);
nazn_     varchar2(160);
datb_     date;
typ_      Number;
nbuc1_    VARCHAR2(12);
nbuc_     VARCHAR2(12);
d_sum_    number;
k_sum_    number;
vdatr_    date := dat_;
days_     number;

  CURSOR Saldo
      IS
  select s.rnk, s.acc, s.nls, s.kv, s.fdat, s.nbs, nvl(s.OB22,'00')
       , s.ost, s.ostq
       , s.dos96, s.dosq96, s.kos96, s.kosq96
       , s.dos99, s.dosq99, s.kos99, s.kosq99
    from OTCN_SALDO s;

  CURSOR OBOROTY
      IS
  SELECT t.fdat, t.ref, t.accd, t.nlsd, t.kv, substr(t.nlsd,1,4) nbs, t.acck,
         t.nlsk, substr(t.nlsk,1,4) nbsk,
         t.s*100,
         DECODE(t.s*100, 0, t.sq*100, gl.p_icurval(t.kv, t.s*100, o.vdat)), t.nazn
       , NVL(sbd.f_75,'0') pr_d
       , NVL(sbk.f_75,'0') pr_k
       , NVL(t.OB22D,'00') ob22_d
       , NVL(t.OB22K,'00') ob22_k
    from TMP_FILE03 t
    join OPER o
      on ( o.ref = t.ref )
    join ( select R020, F_75
             from SB_R020
            where F_75 = '1'
              and D_OPEN <= Dat_
              and lnnvl( D_CLOSE <= Dat_ )
         ) sbd
      on ( sbd.R020 = substr(t.NLSD,1,4) )
    left
    join ( select R020, F_75
             from SB_R020
            where F_75 = '1'
              and D_OPEN <= Dat_
              and lnnvl( D_CLOSE <= Dat_ )
         ) sbk
      on ( sbk.R020 = substr(t.NLSK,1,4) )
   where not exists (select 1 from REF_KOR where ref=t.ref and vob in (96, 99))
   UNION
  SELECT t.fdat, t.ref, t.accd, t.nlsd, t.kv, substr(t.nlsd,1,4) nbs, t.acck,
         t.nlsk, substr(t.nlsk,1,4) nbsk,
         t.s*100, DECODE(t.s*100, 0, t.sq*100, gl.p_icurval( t.kv, t.s*100, r.vdat/*t.fdat*/)), t.nazn
       , NVL(sbd.f_75, '0') pr_d
       , NVL(sbk.f_75,'0') pr_k
       , NVL(t.OB22D,'00') ob22_d
       , NVL(t.OB22K,'00') ob22_k
    from TMP_FILE03 t
    join REF_KOR r
      on ( r.ref = t.REF )
    join ( select R020, F_75
             from SB_R020
            where F_75 = '1'
              and D_OPEN <= Dat_
              and lnnvl( D_CLOSE <= Dat_ )
         ) sbd
      on ( sbd.R020 = substr(t.NLSD,1,4) )
    left
    join ( select R020, F_75
             from SB_R020
            where F_75 = '1'
              and D_OPEN <= Dat_
              and lnnvl( D_CLOSE <= Dat_ )
         ) sbk
      on ( sbk.R020 = substr(t.NLSK,1,4) )
   where r.vob in (96,99)
     and r.vdat >= vdatr_
   UNION
  SELECT t.fdat, t.ref, t.accd, t.nlsd, t.kv, substr(t.nlsd,1,4) nbs, t.acck,
         t.nlsk, substr(t.nlsk,1,4) nbsk,
         t.s*100,
         DECODE(t.s*100, 0, t.sq*100, gl.p_icurval (t.kv, t.s*100, o.vdat)), t.nazn
       , NVL(sbd.f_75,'0') pr_d
       , NVL(sbk.f_75,'0') pr_k
       , NVL(t.OB22D,'00') ob22_d
       , NVL(t.OB22K,'00') ob22_k
    from TMP_FILE03 t
    join OPER o
      on ( o.ref = t.ref )
    join ( select R020, F_75
             from SB_R020
            where F_75 = '1'
              and D_OPEN <= Dat_
              and lnnvl( D_CLOSE <= Dat_ )
         ) sbk
      on ( sbk.R020 = substr(t.NLSK,1,4) )
    left
    join ( select R020, F_75
             from SB_R020
            where F_75 = '1'
              and D_OPEN <= Dat_
              and lnnvl( D_CLOSE <= Dat_ )
         ) sbd
      on ( sbd.R020 = substr(t.NLSD,1,4) )
   WHERE not exists (select 1 from ref_kor where ref=t.ref and vob in (96,99))
   UNION
  SELECT t.fdat, t.ref, t.accd, t.nlsd, t.kv, substr(t.nlsd,1,4) nbs, t.acck,
         t.nlsk, substr(t.nlsk,1,4) nbsk,
         t.s*100, DECODE(t.s*100, 0, t.sq*100, gl.p_icurval (t.kv, t.s*100, r.vdat/*t.fdat*/)), t.nazn
       , NVL(sbd.f_75,'0') pr_d
       , NVL(sbk.f_75,'0') pr_k
       , NVL(t.OB22D,'00') OB22_D
       , NVL(t.ob22K,'00') OB22_K
    FROM TMP_FILE03 t
    join REF_KOR    r
      on ( r.REF = t.REF )
    join ( select R020, F_75
             from SB_R020
            where F_75 = '1'
              and D_OPEN <= Dat_
              and lnnvl( D_CLOSE <= Dat_ )
         ) sbk
      on ( sbk.R020 = substr(t.NLSK,1,4) )
    left
    join ( select R020, F_75
             from SB_R020
            where F_75 = '1'
              and D_OPEN <= Dat_
              and lnnvl( D_CLOSE <= Dat_ )
         ) sbd
      on ( sbd.R020 = substr(t.NLSD,1,4) )
   WHERE r.vob in (96,99)
     and r.vdat >= vdatr_;

BEGIN

  bars_audit.info( $$PLSQL_UNIT||': BEGIN' );

  userid_ := user_id;

  EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';
  EXECUTE IMMEDIATE 'TRUNCATE TABLE TMP_FILE03';

  -- определение начальных параметров
  P_Proc_Set_Int(kodf_,sheme_,nbuc1_,typ_);

  -- используем классификатор SB_R020
  sql_acc_ := q'[select R020 from SB_R020 where F_75='1' and D_OPEN<=to_date('%rptdt','dd.mm.yyyy') and lnnvl(D_CLOSE<=to_date('%rptdt','dd.mm.yyyy'))]';
  sql_acc_ := replace( sql_acc_, '%rptdt', to_char(Dat_,'dd.mm.yyyy') );

  if to_char(dat_, 'mm') in ('12', '01')
  then

    ret_   := F_POP_OTCN( Dat_, 4, sql_acc_, null, 1 );
    vdatr_ := trunc(dat_, 'yyyy') - 1;

    select max(fdat)
      into vdatr_
      from fdat
     where fdat<=vdatr_;

    days_ := to_number(to_char(last_day(add_months(dat_, 1)), 'dd'));

  else

    ret_   := F_POP_OTCN( Dat_, 2, sql_acc_, null, 1 );
    vdatr_ := dat_;
    days_  := 28;

  end if;

  datb_ := trunc(Dat_,'MM');

  -- наполняем все Дт и Кт проводки за месяц для счетов файла @75
  insert
    into TMP_FILE03
       ( ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP, OB22D, OB22K )
  select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP, OB22D, OB22K
    from ( with sel
             as ( select /*+parallel(a)*/
                         a.acc, a.nls, a.kv, a.NBS, a.OB22,
                         o.nazn,
                         o.userid isp, o.vob,
                         p.ref, p.stmt, p.dk, p.tt,
                         p.FDAT, p.s/100 s, p.sq/100 sq
                    from OPLDOK p
                    join ACCOUNTS a
                      on ( a.ACC = p.ACC )
                    join OPER o
                      on ( o.ref = p.ref )
                    join ( select R020, min(D_OPEN) as OPN_DT
                             from SB_R020
                            where F_75 = '1'
                              and D_OPEN <= Dat_
                              and lnnvl( D_CLOSE <= Dat_ )
                            group by R020
                         ) r
                      on ( r.R020 = a.NBS )
                   WHERE p.FDAT between Datb_ and Dat_ + days_
                     and p.SOS >= 4
                     and o.sos = 5
                     and p.FDAT >= r.OPN_DT
                )
  select a.acc ACCD, a.TT, a.REF, a.KV, a.nls NLSD, a.OB22 OB22D, a.S, a.SQ,
         a.FDAT, a.NAZN, b.acc ACCK, b.nls NLSK, b.OB22 OB22K, a.ISP
    from sel a
       , opl b
   where a.fdat between datb_ and Dat_ and
         a.dk = 0 and
         a.ref = b.ref and
         b.fdat between datb_ and Dat_ and
         a.stmt = b.stmt and
         a.s = b.s/100 and
         a.sq = b.sq/100 and
         b.dk = 1
   union
  select b.acc ACCD, a.TT, a.REF, a.KV, b.nls NLSD, b.OB22 OB22D, a.S, a.SQ,
         a.FDAT, a.NAZN, a.acc ACCK, a.nls NLSK, a.OB22 OB22K, a.ISP
    from sel a
       , opl b
   where a.fdat between datb_ and Dat_ and
         a.dk = 1 and
         a.ref = b.ref and
         b.fdat between datb_ and Dat_ and
         a.stmt = b.stmt and
         a.s = b.s/100 and
         a.sq = b.sq/100 and
         b.dk = 0
   union --  период корректирующих проводок ДТ
  select a.acc ACCD, a.TT, a.REF, a.KV, a.nls NLSD, a.OB22 OB22D, a.S, a.SQ,
         a.FDAT, a.NAZN, b.acc ACCK, b.nls NLSK, b.OB22 OB22K, a.ISP
    from sel a
       , opl b
   where a.fdat between Dat_+1 and trunc(Dat_+days_) and
         a.vob in (96,99) and
         a.dk = 0 and
         a.ref = b.ref and
         b.fdat between Dat_+1 and trunc(Dat_+days_) and
         a.stmt = b.stmt and
         a.s = b.s/100 and
         a.sq = b.sq/100 and
         b.dk = 1
   union --  период корректирующих проводок КТ
  select b.acc ACCD, a.TT, a.REF, a.KV, b.nls NLSD, b.OB22 OB22D, a.S, a.SQ,
         a.FDAT, a.NAZN, a.acc ACCK, a.nls NLSK, a.OB22 OB22K, a.ISP
    from sel a
       , opl b
   where a.fdat between Dat_+1 and trunc(Dat_+days_) and
         a.vob in (96,99) and
         a.dk = 1 and
         a.ref = b.ref and
         b.fdat between Dat_+1 and trunc(Dat_+days_) and
         a.stmt = b.stmt and
         a.s = b.s/100 and
         a.sq = b.sq/100 and
         b.dk = 0
  );

    commit;

  -- удаляем проводки перекрытия года и кореектирующие проводки перекрытия
  delete from tmp_file03
   where fdat >= vdatr_
     and ( tt like 'ZG%' or
             (((nlsd LIKE '6%' or nlsd LIKE '7%') AND
              (nlsk LIKE '5040%' OR nlsk LIKE '5041%')) OR
             ((nlsd LIKE '5040%' OR nlsd LIKE '5041%') AND
              (nlsk LIKE '6%' OR nlsk LIKE '7%'))));

  delete from tmp_file03
   where ref in (select t.ref
                   from tmp_file03 t, oper o
                  where t.ref = o.ref and
                    (o.vob = 96 and
                     o.vdat <> dat_/* or
                     o.vob = 99 and
                     o.vdat <> vdatr_*/));

  OPEN Saldo;

  LOOP
  
    FETCH Saldo 
     INTO rnk_, acc_, nls_, kv_, data_, Nbs_, ob22_, Ostn_, Ostq_,
          Dos96_, Dosq96_, Kos96_, Kosq96_,
          Dos99_, Dosq99_, Kos99_, Kosq99_;
    
    EXIT WHEN Saldo%NOTFOUND;

    kk_ := '00';

    IF typ_>0 THEN
       nbuc_ := NVL(F_Codobl_Tobo(acc_,typ_),nbuc1_);
    ELSE
       nbuc_ := nbuc1_;
    END IF;

    -- обороты по перекрытию 6,7 классов на 5040,5041
    IF to_char(Dat_,'MM')='12' and (nls_ like '6%' or nls_ like '7%' or nls_ like '504%')
    THEN

      SELECT NVL(SUM(decode(dk,0,1,0)*s),0),
             NVL(SUM(decode(dk,1,1,0)*s),0)
        INTO d_sum_, k_sum_
        FROM opldok
       WHERE fdat between Dat_ AND Dat_+29
         AND acc = acc_
         AND tt in ('ZG8','ZG9');

      Dos96_:=Dos96_-d_sum_;
      Kos96_:=Kos96_-k_sum_;

    END IF;

    Ostn_:=Ostn_-Dos96_+Kos96_-Dos99_+Kos99_;

    IF ( Ostn_ <> 0 )
    then

      dk_ := case when ( Ostn_ < 0 ) then '1' else '2' end
          || case when ( kv_ = 980 ) then '0' else '1' end;

      kodp_:= dk_ || Nbs_ || ob22_ || lpad(kv_, 3, '0') || kk_;

      znap_:= to_char(abs(Ostn_));

      INSERT INTO rnbu_trace(nls, kv, odate, kodp, znap, acc, nbuc)
      VALUES ( nls_, kv_, data_, kodp_, znap_, acc_, nbuc_ );

    END IF;

    Ostq_:=Ostq_-Dosq96_+Kosq96_-Dosq99_+Kosq99_;

    IF ( Ostq_ <> 0 )
    THEN

      dk_ := case when ( Ostq_ < 0 ) then '1' else '2' end || '0';

      kodp_:= dk_ || Nbs_ || ob22_ || lpad(kv_, 3, '0') || kk_;
      
      znap_:= to_char(abs(Ostq_));

      INSERT INTO rnbu_trace(nls, kv, odate, kodp, znap, acc, nbuc)
      VALUES ( nls_, kv_, data_, kodp_, znap_, acc_, nbuc_ );

    END IF;

  END LOOP;

  CLOSE Saldo;
--------------------------------------------------------------------------------
  OPEN OBOROTY;

  LOOP

    FETCH OBOROTY
     INTO data_, ref_, accd_, nlsd_, kv_, Nbs_, acck_, nlsk_, nbsk_,
          Dos_, Dosq_, nazn_, pr_d, pr_k, ob22_d, ob22_k;
    
    EXIT WHEN OBOROTY%NOTFOUND;

    comm_ := substr('Дт рах. = ' || nlsd_ || ' Кт рах. = ' || nlsk_ || '  ' || nazn_, 1, 200);

    kk_ := '00';
--------------------------------------------------------------------------------
    IF pr_d in ('1','5') THEN
   
      if ( nbs_ = '7700' )
      then
        
        case
        when ob22_d in ('02','07')
        then kk_ := '01';
        when ob22_d in ('04','09')
        then kk_ := '12';
        when ob22_d in ('06')
        then kk_ := '14';
        else kk_ := '__';
        end case;
        
      end if;

      if ( nbs_ = '7701' )
      then
        
        case
        when ob22_d in ('02','09','23','24')
        then kk_ := '01';
        when ob22_d in ('04','11','26','27')
        then kk_ := '12';
        when ob22_d in ('07','25')
        then kk_ := '14';
        else kk_ := '__';
        end case;
        
      end if;

      if ( nbs_ = '7702' )
      then
        
        case
        when ob22_d in ('11','12','22','65','66','75','79','83','85','92','94','96')
        then kk_ := '01';
        when ob22_d in ('14','15','62','67','68','77','81','84','86','93','95','97')
        then kk_ := '12';
        when ob22_d in ('17','18','19','53','54','55')
        then kk_ := '14';
        else kk_ := '__';
        end case;
        
      end if;

      if ( nbs_ = '7703' )
      then

        case
        when ob22_d in ('01','03','07','09')
        then kk_ := '01';
        when ob22_d in ('06','08','13','16')
        then kk_ := '12';
        when ob22_d in ('12','23')
        then kk_ := '14';
        else kk_ := '__';
        end case;

      end if;

      if ( nbs_ = '7704' )
      then

        case
        when ob22_d in ('02','05','10','13')
        then kk_ := '01';
        when ob22_d in ('03','07','11','14')
        then kk_ := '12';
        when ob22_d in ('06','15')
        then kk_ := '14';
        else kk_ := '__';
        end case;

      end if;

      if ( nbs_ = '7705' )
      then

        case
        when ob22_d in ('02')
        then kk_ := '01';
        when ob22_d in ('06')
        then kk_ := '12';
        else kk_ := '__';
        end case;

      end if;

      if ( nbs_ = '7706' )
      then

        case
        when ob22_d in ('01','07','11','19')
        then kk_ := '01';
        when ob22_d in ('02','08','12','18')
        then kk_ := '12';
        else kk_ := '__';
        end case;

      end if;

      if ( nbs_ = '7707' )
      then

        case
        when ob22_d in ('01','04','06','13','14','17','19','21','25')
        then kk_ := '01';
        when ob22_d in ('02','05','07','15','16','18','20','22')
        then kk_ := '12';
        when ob22_d in ('03,08')
        then kk_ := '14';
        else kk_ := '__';
        end case;

      end if;

      -- кошти направленi на формування резерву
      if nlsd_ like '7%' and nlsk_ like '380%' then
         kk_ := '01';
      end if;

      if ( kv_ = 980 and 
           nlsd_ like '7%' and
           nbsk_ in ('1090','1190','1419','1429','1509','1529','1549','1609','1890'
                    ,'2019','2029','2039','2049','2069','2079','2089'
                    ,'2109','2119','2129','2139','2149'
                    ,'2209','2219','2229','2239','2249'
                    ,'2309','2319','2329','2339','2349','2359','2369','2379'
                    ,'2409','2419','2429','2439','2609','2629','2659','2890'
                    ,'3119','3219','3569','3590','3599','3690','3692','3699')
         )
      then
         kk_ := '01';
      end if;

      -- зменшення резервiв за рахунок уточнень
      if (nlsd_ like '1%' or nlsd_ like '2%' or nlsd_ like '3%') and
         nlsk_ like '380%'
      then
         kk_ := '02';
      end if;

      -- списання за рахунок резерву
      if nlsd_ not like '7%' and (nlsk_ like '1%' or nlsk_ like '2%' or nlsk_ like '3%') and
         nlsk_ not like '380%'
      then
         kk_ := '03';
      end if;

      -- повернення заборгованностi
      if kv_=980 and
         (nlsd_ like '1%' or nlsd_ like '2%' or nlsd_ like '3%') and nlsk_ like '7%' then
         kk_ := '02';
      end if;

      -- перерахування до iнших фондових рахункiв
      if kv_=980 and
         (nlsd_ like '1%' or nlsd_ like '2%' or nlsd_ like '3%') and nlsk_ like '5%' then
         kk_ := '05';
      end if;

      -- Перерахування до інших установ
      if kv_=980 and nlsd_ like '7%' and nlsk_ like '3739%'
      then
         kk_ := '07';
      end if;

      if ( nlsk_ like '3739%' and 
           nbs_ in ('1090','1190','1419','1429','1509','1529','1549','1609','1890'
                   ,'2019','2029','2039','2049','2069','2079','2089'
                   ,'2109','2119','2129','2139','2149'
                   ,'2209','2219','2229','2239','2249'
                   ,'2309','2319','2329','2339','2349','2359','2369','2379'
                   ,'2409','2419','2429','2439','2609','2629','2659','2890'
                   ,'3119','3219','3569','3590','3599','3690','3692','3699')
         )
      then
         kk_ := '07';
      end if;

      -- виправнi обороти (щодо коду 01)
      if ( nbs_ = nbsk_ )
      then
        kk_ := '11';
      end if;

      -- зменшення резервiв за рахунок прибутку банку
      if kv_ = 980 and (nlsd_ like '7%' and ob22_d='06') and (nlsk_ like '3590%' and ob22_k='03')
      then
         kk_ := '12';
      end if;

      IF Dos_ > 0 
      THEN
      
        if ( kv_ = 980 )
        then dk_ := '50';
        else dk_ := '51';
        end if;
      
        IF ( typ_ > 0 )
        THEN nbuc_ := NVL(F_Codobl_Tobo(accd_,typ_),nbuc1_);
        ELSE nbuc_ := nbuc1_;
        END IF;
      
        kodp_:= dk_ || Nbs_ || ob22_d || lpad(kv_, 3, '0') || kk_;
        znap_:= to_char(Dos_);
        
        INSERT INTO rnbu_trace(nls, kv, odate, kodp, znap, ref, comm, acc, nbuc)
        VALUES ( nlsd_, kv_, data_, kodp_, znap_, ref_, comm_, accd_, nbuc_ );
        
      END IF;

      IF kv_ != 980 and Dosq_ > 0 
      THEN
         
         dk_ := '50';
         
         IF ( typ_ > 0 )
         THEN nbuc_ := NVL(F_Codobl_Tobo(accd_,typ_),nbuc1_);
         ELSE nbuc_ := nbuc1_;
         END IF;

         kodp_:= dk_ || Nbs_ || ob22_d || lpad(kv_, 3, '0') || kk_ ;
         znap_:= to_char(Dosq_);

         INSERT INTO rnbu_trace(nls, kv, odate, kodp, znap, ref, comm, acc, nbuc)
         VALUES ( nlsd_, kv_, data_, kodp_, znap_, ref_, comm_, accd_, nbuc_ );

      END IF;
--------------------------------------------------------------------------------
      if pr_k in ('1','6') then

        -- при формировании новых счетов для резерва
        if nlsd_ like '3739%' and nlsk_ like '7%' 
        then
          kk_ := '07';
        end if;

        if ( nbsk_ = '7700' )
        then
          
          case
          when ob22_k in ('02','07')
          then kk_ := '11';
          when ob22_k in ('04','09')
          then kk_ := '02';
          when ob22_k in ('06')
          then kk_ := '04';
          else kk_ := '__';
          end case;
          
        end if;

        if ( nbsk_ = '7701' )
        then
          
          case
          when ob22_k in ('02','09','23','24')
          then kk_ := '11';
          when ob22_k in ('04','11','26','27')
          then kk_ := '02';
          when ob22_k in ('07','25')
          then kk_ := '04';
          else kk_ := '__';
          end case;
          
        end if;
        
        if ( nbsk_ = '7702' )
        then
          
          case
          when ob22_k in ('11','12','22','65','66','75','79','83','85','92','94','96')
          then kk_ := '11';
          when ob22_k in ('14','15','62','67','68','77','81','84','86','93','95','97')
          then kk_ := '02';
          when ob22_k in ('17','18','19','53','54','55')
          then kk_ := '04';
          else kk_ := '__';
          end case;
          
        end if;
        
        if ( nbsk_ = '7703' )
        then
        
          case
          when ob22_k in ('01','03','07','09')
          then kk_ := '11';
          when ob22_k in ('06','08','13','16')
          then kk_ := '02';
          when ob22_k in ('12','23')
          then kk_ := '04';
          else kk_ := '__';
          end case;
        
        end if;
        
        if ( nbsk_ = '7704' )
        then
        
          case
          when ob22_k in ('02','05','10','13')
          then kk_ := '11';
          when ob22_k in ('03','07','11','14')
          then kk_ := '02';
          when ob22_k in ('06','15')
          then kk_ := '04';
          else kk_ := '__';
          end case;
        
        end if;
        
        if ( nbsk_ = '7705' )
        then
        
          case
          when ob22_k in ('02')
          then kk_ := '11';
          when ob22_k in ('06')
          then kk_ := '02';
          else kk_ := '__';
          end case;
        
        end if;
        
        if ( nbsk_ = '7706' )
        then
        
          case
          when ob22_k in ('01','07','11','19')
          then kk_ := '11';
          when ob22_k in ('02','08','12','18')
          then kk_ := '02';
          else kk_ := '__';
          end case;
        
        end if;
        
        if ( nbsk_ = '7707' )
        then
        
          case
          when ob22_k in ('01','04','06','13','14','17','19','21','25')
          then kk_ := '11';
          when ob22_k in ('02','05','07','15','16','18','20','22')
          then kk_ := '02';
          when ob22_k in ('03,08')
          then kk_ := '04';
          else kk_ := '__';
          end case;
        
        end if;

        -- кошти направленi на формування резерву
        if nlsd_ like '7%' and nlsk_ not like '7%' then
           kk_ := '01';
        end if;

        -- виправнi обороти щодо коду 01
        if ( nbs_ = nbsk_ )
        then
          kk_ := '01';
        end if;
        
        -- при формировании новых счетов для резерва
        if ( nlsd_ like '3739%' and
             nbsk_ in ('1090','1190','1419','1429','1509','1529','1549','1609','1890'
                      ,'2019','2029','2039','2049','2069','2079','2089'
                      ,'2109','2119','2129','2139','2149'
                      ,'2209','2219','2229','2239','2249'
                      ,'2309','2319','2329','2339','2349','2359','2369','2379'
                      ,'2409','2419','2429','2439','2609','2629','2659','2890'
                      ,'3119','3219','3569','3590','3599','3690','3692','3699')
           )
        then
           kk_ := '07';
        end if;

        -- зменшення резервiв за рахунок прибутку банку
        if kv_ = 980 and (nlsd_ like '7%' and ob22_d='06') and (nlsk_ like '3590%' and ob22_k='03')
        then
           kk_ := '12';
        end if;
        
        IF Dos_ > 0 
        THEN
        
          if ( kv_ = 980 )
          then dk_ := '60';
          else dk_ := '61';
          end if;

          if ( typ_ > 0 )
          then nbuc_ := NVL(F_Codobl_Tobo(acck_,typ_),nbuc1_);
          else nbuc_ := nbuc1_;
          end if;

          kodp_:= dk_ || Nbsk_ || ob22_k || lpad(kv_, 3, '0') || kk_ ;
          znap_:= to_char(Dos_);

          INSERT INTO rnbu_trace(nls, kv, odate, kodp, znap, ref, comm, acc, nbuc)
          VALUES ( nlsk_, kv_, data_, kodp_, znap_, ref_, comm_, acck_, nbuc_ );

        END IF;

        IF kv_ != 980 and Dosq_ > 0 
        THEN

          dk_ := '60';

          IF ( typ_ > 0 )
          then nbuc_ := NVL(F_Codobl_Tobo(acck_,typ_),nbuc1_);
          else nbuc_ := nbuc1_;
          end if;

          kodp_:= dk_ || Nbsk_ || ob22_k || lpad(kv_, 3, '0') || kk_ ;
          znap_:= to_char(Dosq_);

          INSERT INTO rnbu_trace(nls, kv, odate, kodp, znap, ref, comm, acc, nbuc)
          VALUES ( nlsk_, kv_, data_, kodp_, znap_, ref_, comm_, acck_, nbuc_ );

        END IF;

      end if;
--------------------------------------------------------------------------------
    END IF;

    kk_ := '00';

    IF pr_k in ('1','6') and pr_d = '0' THEN

      comm_ := SubStr( comm_ || '   !!! Проверка !!!', 1, 200 );

      -- кошти направленi на формування резерву
      if nlsd_ like '380%' and nlsk_ NOT like '770%'
      then
        kk_ := '01';
      end if;

      if nlsd_ like '770%' and nlsk_ NOT like '770%'
      then
        kk_ := '01';
      end if;

      -- зменшення резервiв за рахунок уточнень
      if kv_ = 980 and nlsd_ like '3801%' and nlsk_ like '770%'
      then
        kk_ := '02';
      end if;

--    -- повернення заборгованностi
--    if (nlsd_ like '1%' or nlsd_ like '2%' or nlsd_ like '3%') and nlsd_ not like '3801%' and
--       nlsk_ like '7%' then
--       kk_ := '04';
--    end if;

--    -- при формировании новых счетов для резерва
--    if nlsd_ like '3739%' and nlsk_ like '7%' then
--       kk_ := '07';
--    end if;

      -- при формировании новых счетов для резерва
      if ( nlsd_ like '3739%' and
           nbsk_ in ('1090','1190','1419','1429','1509','1529','1549','1609','1890'
                    ,'2019','2029','2039','2049','2069','2079','2089'
                    ,'2109','2119','2129','2139','2149'
                    ,'2209','2219','2229','2239','2249'
                    ,'2309','2319','2329','2339','2349','2359','2369','2379'
                    ,'2409','2419','2429','2439','2609','2629','2659','2890'
                    ,'3119','3219','3569','3590','3599','3690','3692','3699')
         )
      then
        kk_ := '07';
      end if;

      -- списання резерву
      if ( nlsd_ like '3903%' and
           nbsk_ in ('1090','1190','1419','1429','1509','1529','1549','1609','1890'
                    ,'2019','2029','2039','2049','2069','2079','2089'
                    ,'2109','2119','2129','2139','2149'
                    ,'2209','2219','2229','2239','2249'
                    ,'2309','2319','2329','2339','2349','2359','2369','2379'
                    ,'2409','2419','2429','2439','2609','2629','2659','2890'
                    ,'3119','3219','3569','3590','3599','3690','3692','3699')
         )
      then
        kk_ := '07';
      end if;

      IF Dos_ > 0 
      THEN

        if ( kv_ = 980 )
        then dk_ := '60';
        else dk_ := '61';
        end if;

        if ( typ_ > 0 )
        then nbuc_ := NVL(F_Codobl_Tobo(acck_,typ_),nbuc1_);
        else nbuc_ := nbuc1_;
        end if;

        kodp_ := dk_ || Nbsk_ || ob22_k || lpad(kv_, 3, '0') || kk_;
        znap_ := TO_CHAR(Dos_);

         INSERT INTO rnbu_trace(nls, kv, odate, kodp, znap, ref, comm, acc, nbuc)
         VALUES ( nlsk_, kv_, data_, kodp_, znap_, ref_, comm_, acck_, nbuc_ );

      END IF;

      IF kv_ != 980 and Dosq_ > 0 
      THEN

        dk_ := '60';

        if ( typ_ > 0 )
        then nbuc_ := NVL(F_Codobl_Tobo(acck_,typ_),nbuc1_);
        else nbuc_ := nbuc1_;
        end if;

        kodp_ := dk_ || Nbsk_ || ob22_k || lpad(kv_, 3, '0') || kk_;
        znap_ := TO_CHAR(Dosq_);

        INSERT INTO rnbu_trace(nls, kv, odate, kodp, znap, ref, comm, acc, nbuc)
        VALUES ( nlsk_, kv_, data_, kodp_, znap_, ref_, comm_, acck_, nbuc_ );

      END IF;

    END IF;

  END LOOP;

  CLOSE OBOROTY;

  -- розрахунок показникыв курсової р?зниц? (код 06)
  comm_ := 'формирование показетелей переоценки';

  for k in ( select acc, nls, kv, substr(kodp,3,4) nbs,
                    substr(kodp,7,2) ob22, substr(kodp,9,3) kvp,
                    NVL(sum(decode(substr(kodp,1,2),'50',to_number(znap),0)),0) dos,
                    NVL(sum(decode(substr(kodp,1,2),'60',to_number(znap),0)),0) kos
               from rnbu_trace
              where kv != 980
                and odate <= Dat_
                and substr(kodp,-2) not in ('06')
              group by acc, nls, kv, substr(kodp,3,4), substr(kodp,7,2), substr(kodp,9,3)
              UNION
             select acc, nls, kv, nbs,
                    ob22, lpad(to_char(kv),3,'0') kvp,
                    0 dos,
                    0 kos
               from accounts
              where kv != 980
                and nbs in ( select R020 
                               from SB_R020
                              where F_75 = '1'
                                and D_OPEN <= Dat_ 
                                and lnnvl( D_CLOSE <= Dat_ )
                           )
                and acc not in ( select t.acc
                                   from RNBU_TRACE t
                                  where t.kv != 980
                                    and t.odate <= Dat_ ) )
  loop
    IF typ_>0 THEN
       nbuc_ := NVL(F_Codobl_Tobo(k.acc,typ_),nbuc1_);
    ELSE
       nbuc_ := nbuc1_;
    END IF;

    begin
      select NVL(dosq - cudosq, 0), NVL(kosq - cukosq,0)
        into dos_, kos_
        from AGG_MONBALS
       where FDAT = trunc(Dat_, 'mm')
         and ACC  = k.acc;
     exception
       when no_data_found then
         dos_ := 0;
         kos_ := 0;
    end;

    if dos_ != k.dos and dos_ != 0 and k.dos >= 0 
    then
    
      if dos_ -  k.dos > 0 then
         kodp_:= '50' || k.nbs || k.ob22 || lpad(k.kvp, 3, '0') || '06' ;
         znap_:= TO_CHAR(dos_ - k.dos);
      elsif dos_ -  k.dos < 0 then
         kodp_:= '60' || k.nbs || k.ob22 || lpad(k.kvp, 3, '0') || '06' ;
         znap_:= TO_CHAR(abs(dos_ - k.dos));
      end if;
   
      INSERT INTO rnbu_trace(nls, kv, odate, kodp, znap, ref, comm, acc, nbuc)
      VALUES  (k.nls, k.kv, dat_, kodp_, znap_, 0, comm_, k.acc, nbuc_) ;
      
    end if;

     if kos_ != k.kos and kos_ != 0 and k.kos >= 0 then
        if kos_ - k.kos > 0 then
            kodp_:= '60' || k.nbs || k.ob22 || lpad(k.kvp, 3, '0') || '06' ;
            znap_:= TO_CHAR(kos_ - k.kos);
        elsif kos_ -  k.kos < 0 then
           kodp_:= '50' || k.nbs || k.ob22 || lpad(k.kvp, 3, '0') || '06' ;
           znap_:= TO_CHAR(abs(kos_ - k.kos));
        end if;

        INSERT INTO rnbu_trace(nls, kv, odate, kodp, znap, ref, comm, acc, nbuc)
        VALUES  (k.nls, k.kv, dat_, kodp_, znap_, 0, comm_, k.acc, nbuc_) ;
     end if;
     
  end loop;

  -- удалаяем коректирующие проводки предыдущего месяца
  delete from rnbu_trace
   where odate < Dat_
     and ref in ( select ref from REF_KOR where vob=96 );

  delete from TMP_IREP
   where KODF = kodf_
     and DATF = dat_;

  insert into TMP_IREP ( KODF, DATF, KODP, ZNAP, NBUC )
  select kodf_, Dat_, KODP, sum(ZNAP), NBUC
    from RNBU_TRACE
   group by KODP, NBUC;

  bars_audit.info( $$PLSQL_UNIT||': END' );

end P_F75SB;
/

show errors;

grant EXECUTE on P_F75SB to BARS_ACCESS_DEFROLE;
grant EXECUTE on P_F75SB to RPBN002;
grant EXECUTE on P_F75SB to WR_ALL_RIGHTS;
