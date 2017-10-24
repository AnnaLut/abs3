

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F40SB.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F40SB ***

  CREATE OR REPLACE PROCEDURE BARS.P_F40SB (Dat_ DATE, sheme_ VARCHAR2 DEFAULT 'C')  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :    ѕроцедура формирование файла @40 дл¤ ќщадного Ѕанку
% COPYRIGHT   :    Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
% VERSION     : 30/03/2017 (11/02/2016, 03/06/2015)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    параметры: Dat_ - отчетна¤ дата
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 30.03.2017 - дл¤ остатков и оборотов добалены годовые корректирующие 
%              проводки
% 11.02.2016 - объеденены все изменени¤ выполненные ранее
% 03.06.2015 - изменен курсор OPL_DOK
% 26.05.2012 - формируем в разрезе кодов территорий
% 06.10.2011 - не включались коригуюч?
% 30.04.2011 - добавил†acc,tobo в протокол
% 01.03.2011 - в поле комментарий вносим код TOBO и название счета
% 14.10.2010 - добавлен в?зов процедур? P_CH_FILE40 (проверка с 02 файлом)
% 11.03.2010 - в курсоре SaldoBQ добавил условие s.kv != 980
% 10.03.2010 - дл¤ курсора SaldoAOstfk вместо переменной SN_ использовали в
%              формировании показател¤ переменную SE_. »справлено.
% 12.01.2010 - вместо табл. TTS_VOB будем использовать OPER т.к.
%              при миграции в ’ерсоне использовали дл¤ корректирующих
%              операцию "ћv–" и VOB='96' вместо "096"("099") дл¤ которых
%              в табл. TTS_VOB vob in (96,99)
% 12.01.2010 - вместо услови¤ vob in ('096','099') будет условие
%              vob in (96,99)
% 08.12.2009 - вместо конкретных операций '096','099' выбираем операции из
%               TTS_VOB у которых VOB in (96,99)
% 30.10.2009 - будем обрабатывать 2 доп.параметра OB40, OB40D вместо OB40
%              т.к. в проводке могут участвовать оба счета 4 класса
%              OB40 - доп.параметр дл¤ ?т счета
%              OB40D - доп.параметр дл¤  т счета
% 20.10.2009 - будем обрабатывать 2 доп.параметра OB40D, OB40K вместо OB40
%              т.к. в проводке могут участвовать оба счета 4 класса
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
kodf_    varchar2(2) := '40';
acc_     Number;
acc1_    Number;
accd_    Number;
acck_    Number;
rnk_     Number;
ref_     Number;
Dat1_    Date;
Dat2_    Date;
Dat99_   Date;
Dos_     DECIMAL(24);
Dosq_    DECIMAL(24);
Kos_     DECIMAL(24);
Kosq_    DECIMAL(24);
Dos96p_  DECIMAL(24);
Dosq96p_ DECIMAL(24);
Kos96p_  DECIMAL(24);
Kosq96p_ DECIMAL(24);
Dos96_   DECIMAL(24);
Dosq96_  DECIMAL(24);
Kos96_   DECIMAL(24);
Kosq96_  DECIMAL(24);
Dos99_   DECIMAL(24);
Dosq99_  DECIMAL(24);
Kos99_   DECIMAL(24);
Kosq99_  DECIMAL(24);
Doszg_   DECIMAL(24);
Koszg_   DECIMAL(24);
Dos96zg_ DECIMAL(24);
Kos96zg_ DECIMAL(24);
Dos99zg_ DECIMAL(24);
Kos99zg_ DECIMAL(24);
Ostn_    DECIMAL(24);
Ostq_    DECIMAL(24);
Dosnk_   DECIMAL(24);
Dosn_    DECIMAL(24);
Kosnk_   DECIMAL(24);
Kosn_    DECIMAL(24);
se_      DECIMAL(24);
sn_      DECIMAL(24);
kodp_    Varchar2(10);
znap_    Varchar2(30);
Kv_      SMALLINT;
Vob_     SMALLINT;
Nbs_     Varchar2(4);
nls_     Varchar2(15);
nlsd_    Varchar2(15);
nlsk_    Varchar2(15);
data_    date;
zz_      Varchar2(2);
kk_      Varchar2(2);
kk_o     Varchar2(2);
kk_d     Varchar2(2);
kk_k     varchar2(2);
dk_      char(1);
userid_  Number;
nazn_    Varchar2(160);
sql_acc_ varchar2(2000):='';
sql_doda_ varchar2(200):='';
ret_     number;
tobo_    accounts.tobo%TYPE;
nms_     accounts.nms%TYPE;
comm_    rnbu_trace.comm%TYPE;  -- Varchar2(200);
typ_     Number; 
nbuc1_   VARCHAR2(12);
nbuc_    VARCHAR2(12);

---ќстатки на отчетную дату (грн. + валюта)
CURSOR Saldo IS
   SELECT s.rnk, s.acc, s.nls, s.kv, s.fdat, s.nbs, s.ost, s.ostq,
          s.dos, s.dosq, s.kos, s.kosq,
          s.dos96p, s.dosq96p, s.kos96p, s.kosq96p,
          s.dos96, s.dosq96, s.kos96, s.kosq96,
          s.dos99, s.dosq99, s.kos99, s.kosq99,
          s.doszg, s.koszg, s.dos96zg, s.kos96zg,
          a.tobo, a.nms, NVL(trim(sp.ob22),'00')  
    FROM  otcn_saldo s, otcn_acc a, specparam_int sp
    WHERE s.acc=a.acc
      and s.acc=sp.acc(+);
-----------------------------------------------------------------------
CURSOR OPL_DOK IS
   SELECT distinct * FROM (
   SELECT o.ref, o.accd, o.nlsd, o.kv, o.fdat,
          o.s*100, o.acck, o.nlsk, o.nbsd r020, o.nazn
   FROM  provodki_otc o
   WHERE o.nbsd in (select r020 from sb_r020 where f_40='1')
     and o.vob not in (96,99)
     and o.fdat between Dat1_ and Dat_
UNION ALL
   SELECT o.ref, o.accd, o.nlsd, o.kv, o.fdat,
          o.s*100, o.acck, o.nlsk, nbsk r020, o.nazn
   FROM  provodki_otc o
   WHERE o.nbsk in (select r020 from sb_r020 where f_40='1')
     and o.vob not in (96,99)
     and o.fdat between Dat1_ and Dat_
) ;
----------------------------------------------------------------------
--- коррект. проводки дл¤ кодов '5' и '6'
CURSOR KOR_PROVODKI IS
    SELECT a.ref, a.acc, s.nls, s.kv, a.fdat,
           DECODE(a.dk, 0, GL.P_ICURVAL(s.kv, a.s, Dat_), 0),
           DECODE(a.dk, 1, GL.P_ICURVAL(s.kv, a.s, Dat_), 0)
    FROM  kor_prov a, accounts s, sb_r020 k
    WHERE a.acc=s.acc                               
      and s.nbs=k.r020                              
      and k.f_40='1'                                
      and a.fdat between Dat_+1 and Dat2_;

--- р?чн? корегуюч? проводки дл¤ код?в '5' и '6'
CURSOR KOR_PROV_99 IS
    SELECT a.ref, a.acc, s.nls, s.kv, a.fdat,
           DECODE(a.dk, 0, GL.P_ICURVAL(s.kv, a.s, Dat_), 0),
           DECODE(a.dk, 1, GL.P_ICURVAL(s.kv, a.s, Dat_), 0)
    FROM  kor_prov a, accounts s, sb_r020 k
    WHERE a.acc=s.acc                               
      and s.nbs=k.r020                              
      and k.f_40='1' 
      and a.vob = 99                                
      and a.fdat between Dat_ + 1 and Dat99_;
----------------------------------------------------------------------
CURSOR BaseL IS
    SELECT kodp, nbuc, SUM (znap)
    FROM rnbu_trace
    WHERE userid=userid_
    GROUP BY kodp, nbuc;

BEGIN
-------------------------------------------------------------------
userid_ := user_id;
EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';
-------------------------------------------------------------------
Dat1_ := TRUNC(Dat_, 'MM');
Dat2_ := TRUNC(Dat_ + 28);
Dat99_ := glb_bankdate();

-- определение начальных параметров
P_Proc_Set_Int(kodf_,sheme_,nbuc1_,typ_);

-- используем классификатор SB_R020 
sql_acc_ := 'select r020 from sb_r020 where f_40=''1'' ';

if to_char(Dat_,'MM') = '12' then
   ret_ := f_pop_otcn(Dat_, 4, sql_acc_, null, 1);
else
   ret_ := f_pop_otcn(Dat_, 3, sql_acc_, null, 1);
end if;

-- ќстатки (грн. + валюта эквиваленты) --
OPEN Saldo;
   LOOP
   FETCH Saldo INTO rnk_, acc_, nls_, kv_, data_, Nbs_, Ostn_, Ostq_,
                    Dos_, Dosq_, Kos_, Kosq_,
                    Dos96p_, Dosq96p_, Kos96p_, Kosq96p_,
                    Dos96_, Dosq96_, Kos96_, Kosq96_,
                    Dos99_, Dosq99_, Kos99_, Kosq99_,
                    Doszg_, Koszg_, Dos96zg_, Kos96zg_, 
                    tobo_, nms_, zz_;
   EXIT WHEN Saldo%NOTFOUND;

   comm_ := '';

   IF typ_>0 THEN
      nbuc_ := NVL(F_Codobl_Tobo(acc_,typ_),nbuc1_);
   ELSE
      nbuc_ := nbuc1_;
   END IF;

   se_:=0;

   if kv_ = 980 then
      se_:=Ostn_- Dos96_ + Kos96_ - Dos99_ + Kos99_;
   else
      se_:=Ostq_-Dosq96_ + Kosq96_ - Dosq99_ + Kosq99_;
   end if;

   comm_ := substr(comm_ || tobo_ || '  ' || nms_, 1, 200);

   -- ќстатки в номинале грн + экв.валюты
   IF se_ <> 0 THEN 
      dk_:=IIF_N(se_,0,'1','2','2') ;
      kodp_:= dk_ || nbs_ || zz_ || '00' ;
      znap_:= TO_CHAR(ABS(se_)) ;
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, acc, comm, tobo, nbuc) VALUES  
                             (nls_, kv_, data_, kodp_,znap_, acc_, comm_, tobo_, nbuc_) ;
   END IF;

END LOOP;
CLOSE Saldo;
-----------------------------------------------------------------------------
OPEN OPL_DOK;
LOOP
   FETCH OPL_DOK INTO ref_, accd_, nls_, kv_, data_, sn_, acck_,
                      nlsk_, nbs_, nazn_ ; --kk_
   EXIT WHEN OPL_DOK%NOTFOUND;

   BEGIN
      SELECT NVL(SUBSTR(value,1,2),'00')
         INTO kk_d
      FROM operw
      WHERE ref=ref_ and tag ='OB40' ;
   EXCEPTION WHEN NO_DATA_FOUND THEN
      kk_d := '00';
   END;

   BEGIN
      SELECT NVL(SUBSTR(value,1,2),'00')
         INTO kk_k
      FROM operw
      WHERE ref=ref_ and tag ='OB40D' ;
   EXCEPTION WHEN NO_DATA_FOUND THEN
      kk_k := '00';
   END;

   comm_ := '';
   comm_ := substr(comm_||'?т '||nls_||'  '||'  т '||nlsk_||'  '||nazn_,1,200);

   IF sn_>0 and substr(nls_,1,4)=nbs_ THEN
 
      IF typ_>0 THEN
         nbuc_ := NVL(F_Codobl_Tobo(accd_,typ_),nbuc1_);
      ELSE
         nbuc_ := nbuc1_;
      END IF;

      BEGIN
         SELECT NVL(ob22,'00')
            into zz_
         FROM specparam_int
         WHERE acc=accd_ ;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         zz_:='00';
      END ;

      kk_ := '00';

      if kk_d != '00' then
         kk_ := kk_d;
      end if;
      if kk_d = '00' and kk_k != '00' then
         kk_ := kk_k;
      end if;
      kodp_:= '5' || SUBSTR(nls_,1,4) || zz_ || kk_ ;
      znap_:= TO_CHAR(SN_) ;
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, ref, comm, nbuc) VALUES
                             (nls_, kv_, data_, kodp_,znap_, ref_, comm_, nbuc_);
   END IF;

   IF sn_>0 and substr(nlsk_,1,4)=nbs_ THEN

      IF typ_>0 THEN
         nbuc_ := NVL(F_Codobl_Tobo(acck_,typ_),nbuc1_);
      ELSE
         nbuc_ := nbuc1_;
      END IF;

      BEGIN
         SELECT NVL(ob22,'00')
            into zz_
         FROM specparam_int
         WHERE acc=acck_ ;
         EXCEPTION WHEN NO_DATA_FOUND THEN
         zz_:='00';
      END ;

      kk_ := '00';

      if kk_k != '00' then
         kk_ := kk_k;
      end if;
      if kk_k = '00' and kk_d != '00' then
         kk_ := kk_d;
      end if;
      kodp_:= '6' || SUBSTR(nlsk_,1,4) || zz_ || kk_ ;
      znap_:= TO_CHAR(SN_) ;
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, ref, comm, nbuc) VALUES
                             (nlsk_, kv_, data_, kodp_,znap_, ref_, comm_, nbuc_);
   END IF;
END LOOP;
CLOSE OPL_DOK;
----------------------------------------------------------------------
--- обороты по корректирующим проводкам коды '5' и '6'
OPEN KOR_PROVODKI;
LOOP
   FETCH KOR_PROVODKI INTO ref_, acc_, nls_, kv_, data_, Dosn_, Kosn_ ;
   EXIT WHEN KOR_PROVODKI%NOTFOUND;

   kk_ := '00';

   BEGIN
      SELECT NVL(SUBSTR(value,1,2),'00') INTO kk_d
      FROM operw
      WHERE ref=ref_ and tag ='OB40' ;
   EXCEPTION WHEN NO_DATA_FOUND THEN
      kk_d := '00';
   END;

   BEGIN
      SELECT NVL(SUBSTR(value,1,2),'00') INTO kk_k
      FROM operw
      WHERE ref=ref_ and tag ='OB40D' ;
   EXCEPTION WHEN NO_DATA_FOUND THEN
      kk_k := '00';
   END;

   begin
      select nlsd, nlsk, nazn
         into nlsd_, nlsk_, nazn_
      from provodki_otc
      where fdat = data_ 
        and ref = ref_;

      comm_ := '';
      comm_ := substr(comm_||'?т '||nlsd_||'  '||'  т '||nlsk_||'  '||nazn_,1,200);
   exception when no_data_found then     
      comm_ := '';
   end;            

   IF typ_>0 THEN
      nbuc_ := NVL(F_Codobl_Tobo(acc_,typ_),nbuc1_);
   ELSE
      nbuc_ := nbuc1_;
   END IF;

   IF Dosn_>0 THEN
      BEGIN
         SELECT NVL(ob22,'00') into zz_
         FROM specparam_int
         WHERE acc=acc_ ;
         EXCEPTION WHEN NO_DATA_FOUND THEN
         zz_:='00';
      END ;
      if kk_d != '00' then
         kk_ := kk_d;
      end if;
      if kk_d = '00' and kk_k != '00' then
         kk_ := kk_k;
      end if;
      kodp_:= '5' || SUBSTR(nls_,1,4) || zz_ || kk_ ;
      znap_:= TO_CHAR(Dosn_) ;
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, ref, comm, nbuc) VALUES
                             (nls_, kv_, data_, kodp_,znap_, ref_, comm_, nbuc_);
   END IF;

   IF Kosn_>0 THEN
      BEGIN
         SELECT NVL(ob22,'00') into zz_
         FROM specparam_int
         WHERE acc=acc_ ;
         EXCEPTION WHEN NO_DATA_FOUND THEN
         zz_:='00';
      END ;
      if kk_k != '00' then
         kk_ := kk_k;
      end if;
      if kk_k = '00' and kk_d != '00' then
         kk_ := kk_d;
      end if;
      kodp_:= '6' || SUBSTR(nls_,1,4) || zz_ || kk_ ;
      znap_:= TO_CHAR(Kosn_) ;
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, ref, comm, nbuc) VALUES
                             (nls_, kv_, data_, kodp_,znap_, ref_, comm_, nbuc_);
   END IF;
END LOOP;
CLOSE KOR_PROVODKI;
---------------------------------------------------
--- обороти по р?чних корегуючих проводках коды '5' и '6'
OPEN KOR_PROV_99;
LOOP
   FETCH KOR_PROV_99 INTO ref_, acc_, nls_, kv_, data_, Dosn_, Kosn_ ;
   EXIT WHEN KOR_PROV_99%NOTFOUND;

   kk_ := '00';

   BEGIN
      SELECT NVL(SUBSTR(value,1,2),'00') INTO kk_d
      FROM operw
      WHERE ref=ref_ and tag ='OB40' ;
   EXCEPTION WHEN NO_DATA_FOUND THEN
      kk_d := '00';
   END;

   BEGIN
      SELECT NVL(SUBSTR(value,1,2),'00') INTO kk_k
      FROM operw
      WHERE ref=ref_ and tag ='OB40D' ;
   EXCEPTION WHEN NO_DATA_FOUND THEN
      kk_k := '00';
   END;

   begin
      select nlsd, nlsk, nazn
         into nlsd_, nlsk_, nazn_
      from provodki_otc
      where fdat = data_ 
        and ref = ref_;

      comm_ := '';
      comm_ := substr(comm_||'?т '||nlsd_||'  '||'  т '||nlsk_||'  '||nazn_,1,200);
   exception when no_data_found then     
      comm_ := '';
   end;            

   IF typ_>0 THEN
      nbuc_ := NVL(F_Codobl_Tobo(acc_,typ_),nbuc1_);
   ELSE
      nbuc_ := nbuc1_;
   END IF;

   IF Dosn_>0 THEN
      BEGIN
         SELECT NVL(ob22,'00') into zz_
         FROM specparam_int
         WHERE acc=acc_ ;
         EXCEPTION WHEN NO_DATA_FOUND THEN
         zz_:='00';
      END ;
      if kk_d != '00' then
         kk_ := kk_d;
      end if;
      if kk_d = '00' and kk_k != '00' then
         kk_ := kk_k;
      end if;
      kodp_:= '5' || SUBSTR(nls_,1,4) || zz_ || kk_ ;
      znap_:= TO_CHAR(Dosn_) ;
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, ref, comm, nbuc) VALUES
                             (nls_, kv_, data_, kodp_,znap_, ref_, comm_, nbuc_);
   END IF;

   IF Kosn_>0 THEN
      BEGIN
         SELECT NVL(ob22,'00') into zz_
         FROM specparam_int
         WHERE acc=acc_ ;
         EXCEPTION WHEN NO_DATA_FOUND THEN
         zz_:='00';
      END ;
      if kk_k != '00' then
         kk_ := kk_k;
      end if;
      if kk_k = '00' and kk_d != '00' then
         kk_ := kk_d;
      end if;
      kodp_:= '6' || SUBSTR(nls_,1,4) || zz_ || kk_ ;
      znap_:= TO_CHAR(Kosn_) ;
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, ref, comm, nbuc) VALUES
                             (nls_, kv_, data_, kodp_,znap_, ref_, comm_, nbuc_);
   END IF;
END LOOP;
CLOSE KOR_PROV_99;
---------------------------------------------------
DELETE FROM tmp_irep where kodf='40' and datf= dat_;
---------------------------------------------------
OPEN BaseL;
LOOP
   FETCH BaseL INTO  kodp_, nbuc_, znap_;
   EXIT WHEN BaseL%NOTFOUND;
   INSERT INTO tmp_irep
        (kodf, datf, kodp, znap, nbuc)
   VALUES
        ('40', Dat_, kodp_, znap_, nbuc_);
END LOOP;
CLOSE BaseL;
------------------------------------------------------------------
-- перевiрка показник?в з файлом 02
p_ch_file40('40',dat_,userid_);
------------------------------------------------------------------
END p_f40sb;
/
show err;

PROMPT *** Create  grants  P_F40SB ***
grant EXECUTE                                                                on P_F40SB         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_F40SB         to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F40SB.sql =========*** End *** =
PROMPT ===================================================================================== 
