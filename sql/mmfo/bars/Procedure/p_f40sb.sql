

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F40SB.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F40SB ***

  CREATE OR REPLACE PROCEDURE BARS.P_F40SB (Dat_ DATE, sheme_ VARCHAR2 DEFAULT 'C')  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	Процедура формирование файла @40 для Ощадного Банку
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
% VERSION     : 16/11/2017 (30/03/2017, 11/02/2016)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    параметры: Dat_ - отчетная дата
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 16.11.2017 - удалил ненужные строки и изменил некоторые блоки формирования 
%              изменил курсор OPL_DOK
% 30.03.2017 - для остатков и оборотов добалены годовые корректирующие 
%              проводки
% 11.02.2016 - объеденены все изменения выполненные ранее
% 03.06.2015 - изменен курсор OPL_DOK
% 26.05.2012 - формируем в разрезе кодов территорий
% 06.10.2011 - не включались коригуючі
% 30.04.2011 - добавил acc,tobo в протокол
% 01.03.2011 - в поле комментарий вносим код TOBO и название счета
% 14.10.2010 - добавлен в?зов процедур? P_CH_FILE40 (проверка с 02 файлом)
% 11.03.2010 - в курсоре SaldoBQ добавил условие s.kv != 980
% 10.03.2010 - для курсора SaldoAOstfk вместо переменной SN_ использовали в
%              формировании показателя переменную SE_. Исправлено.
% 12.01.2010 - вместо табл. TTS_VOB будем использовать OPER т.к.
%              при миграции в Херсоне использовали для корректирующих
%              операцию "МГР" и VOB='96' вместо "096"("099") для которых
%              в табл. TTS_VOB vob in (96,99)
% 12.01.2010 - вместо условия vob in ('096','099') будет условие
%              vob in (96,99)
% 08.12.2009 - вместо конкретных операций '096','099' выбираем операции из
%               TTS_VOB у которых VOB in (96,99)
% 30.10.2009 - будем обрабатывать 2 доп.параметра OB40, OB40D вместо OB40
%              т.к. в проводке могут участвовать оба счета 4 класса
%              OB40 - доп.параметр для Дт счета
%              OB40D - доп.параметр для Кт счета
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
ret_	 number;
tobo_    accounts.tobo%TYPE;
nms_     accounts.nms%TYPE;
comm_    rnbu_trace.comm%TYPE;  -- Varchar2(200);
typ_     Number; 
nbuc1_   VARCHAR2(12);
nbuc_    VARCHAR2(12);

---Остатки на отчетную дату (грн. + валюта)
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
 select distinct REF, ACCD, NLSD, KV, FDAT, S*100, ACCK, NLSK, R020, NAZN
 from (
     with sel as
          ( select /*+ LEADING(a) */  --/*+ parallel(4) */
               a.acc, a.nls, a.kv, a.nbs,
               o.nazn,
               o.userid isp, o.vob,  
               p.ref, p.stmt, p.dk, p.tt,
               p.fdat, p.s/100 s, p.sq/100 sq
           FROM opldok p, accounts a, oper o
           WHERE p.fdat between Dat1_ and Dat_ and 
                 p.acc = a.acc and
                 a.nbs in (select r020
                           from sb_r020
                           where f_40 = '1') and  
                 p.sos >= 4 and
                 p.ref = o.ref and
                 o.sos = 5 and 
                 o.vob not in (96,99))
      select a.ref REF, a.acc ACCD, a.nls NLSD, a.kv KV, a.FDAT, a.s, 
         b.acc ACCK, b.nls NLSK, substr(a.nls,1,4) R020, a.NAZN
      from sel a, opl b
      where a.fdat between dat1_ and Dat_ and 
         a.dk = 0 and
         a.ref = b.ref and
         b.fdat between dat1_ and Dat_ and
         a.stmt = b.stmt and
         a.s = b.s/100 and
         a.sq = b.sq/100 and
         b.dk = 1
      union all
      select a.ref REF, b.acc ACCD, b.nls NLSD, a.kv KV, a.FDAT, a.s, 
         a.acc ACCK, a.nls NLSK, substr(a.nls,1,4) R020, a.NAZN
      from sel a, opl b
      where a.fdat between dat1_ and Dat_ and 
         a.dk = 1 and
         a.ref = b.ref and
         b.fdat between dat1_ and Dat_ and
         a.stmt = b.stmt and
         a.s = b.s/100 and
         a.sq = b.sq/100 and
         b.dk = 0);
----------------------------------------------------------------------
--- коррект. проводки для кодов '5' и '6'
CURSOR KOR_PROVODKI IS
    SELECT a.ref, a.acc, s.nls, s.kv, a.fdat,
           DECODE(a.dk, 0, GL.P_ICURVAL(s.kv, a.s, Dat_), 0),
           DECODE(a.dk, 1, GL.P_ICURVAL(s.kv, a.s, Dat_), 0)
    FROM  kor_prov a, accounts s, sb_r020 k
    WHERE a.acc=s.acc                               
      and s.nbs=k.r020                              
      and k.f_40='1'                                
      and a.fdat between Dat_+1 and Dat2_;

--- річні корегуючі проводки для кодів '5' и '6'
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

-- Остатки (грн. + валюта эквиваленты) --
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

   IF typ_ > 0 
   THEN
      nbuc_ := NVL(F_Codobl_Tobo(acc_,typ_),nbuc1_);
   ELSE
      nbuc_ := nbuc1_;
   END IF;

   se_ := 0;

   if kv_ = 980 
   then
      se_ := Ostn_- Dos96_ + Kos96_ - Dos99_ + Kos99_;
   else
      se_ := Ostq_-Dosq96_ + Kosq96_ - Dosq99_ + Kosq99_;
   end if;

   comm_ := substr(comm_ || tobo_ || '  ' || nms_, 1, 200);

   -- Остатки в номинале грн + экв.валюты
   IF se_ <> 0 
   THEN 
      dk_ := IIF_N(se_,0,'1','2','2') ;
      kodp_ := dk_ || nbs_ || zz_ || '00' ;
      znap_ := TO_CHAR(ABS(se_)) ;
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, acc, comm, tobo, nbuc) VALUES  
                             (nls_, kv_, data_, kodp_,znap_, acc_, comm_, tobo_, nbuc_) ;
   END IF;

END LOOP;
CLOSE Saldo;
-----------------------------------------------------------------------------
OPEN OPL_DOK;
LOOP
   FETCH OPL_DOK INTO ref_, accd_, nls_, kv_, data_, sn_, acck_,
                      nlsk_, nbs_, nazn_ ; 
   EXIT WHEN OPL_DOK%NOTFOUND;

   BEGIN
      SELECT NVL(SUBSTR(value,1,2),'00') INTO kk_d
      FROM operw
      WHERE ref = ref_ 
        and tag = 'OB40' ;
   EXCEPTION WHEN NO_DATA_FOUND THEN
      kk_d := '00';
   END;

   BEGIN
      SELECT NVL(SUBSTR(value,1,2),'00') INTO kk_k
      FROM operw
      WHERE ref = ref_ 
        and tag = 'OB40D' ;
   EXCEPTION WHEN NO_DATA_FOUND THEN
      kk_k := '00';
   END;

   comm_ := '';
   comm_ := substr(comm_||'Дт '||nls_||'  '||' Кт '||nlsk_||'  '||nazn_,1,200);

   IF sn_ > 0 and substr(nls_,1,4) = nbs_ 
   THEN
 
      IF typ_ > 0 
      THEN
         nbuc_ := NVL(F_Codobl_Tobo(accd_,typ_),nbuc1_);
      ELSE
         nbuc_ := nbuc1_;
      END IF;

      BEGIN
         SELECT NVL(ob22,'00') into zz_
         FROM specparam_int
         WHERE acc = accd_ ;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         zz_ := '00';
      END ;

      kk_ := '00';

      if kk_d != '00' 
      then
         kk_ := kk_d;
      end if;
      if kk_d = '00' and kk_k != '00' then
         kk_ := kk_k;
      end if;
      kodp_ := '5' || SUBSTR(nls_,1,4) || zz_ || kk_ ;
      znap_ := TO_CHAR(SN_) ;
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, ref, comm, nbuc) VALUES
                             (nls_, kv_, data_, kodp_,znap_, ref_, comm_, nbuc_);
   END IF;

   IF sn_ > 0 and substr(nlsk_,1,4) = nbs_ 
   THEN

      IF typ_ > 0 
      THEN
         nbuc_ := NVL(F_Codobl_Tobo(acck_,typ_),nbuc1_);
      ELSE
         nbuc_ := nbuc1_;
      END IF;

      BEGIN
         SELECT NVL(ob22,'00') into zz_
         FROM specparam_int
         WHERE acc = acck_ ;
         EXCEPTION WHEN NO_DATA_FOUND THEN
         zz_:='00';
      END ;

      kk_ := '00';

      if kk_k != '00' 
      then
         kk_ := kk_k;
      end if;
      if kk_k = '00' and kk_d != '00' 
      then
         kk_ := kk_d;
      end if;
      kodp_ := '6' || SUBSTR(nlsk_,1,4) || zz_ || kk_ ;
      znap_ := TO_CHAR(SN_) ;
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
      WHERE ref = ref_ 
        and tag  = 'OB40' ;
   EXCEPTION WHEN NO_DATA_FOUND THEN
      kk_d := '00';
   END;

   BEGIN
      SELECT NVL(SUBSTR(value,1,2),'00') INTO kk_k
      FROM operw
      WHERE ref = ref_ 
        and tag = 'OB40D' ;
   EXCEPTION WHEN NO_DATA_FOUND THEN
      kk_k := '00';
   END;

   begin
      select nlsd, nlsk, nazn
         into nlsd_, nlsk_, nazn_
      from provodki_otc o, opldok z
      where o.fdat = data_ 
        and o.ref = ref_
        and o.ref = z.ref 
        and o.stmt = z.stmt
        and z.acc = acc_;

      comm_ := '';
      comm_ := substr(comm_||'Дт '||nlsd_||'  '||' Кт '||nlsk_||'  '||nazn_,1,200);
   exception when no_data_found then     
      comm_ := '';
   end;            

   IF typ_ > 0 
   THEN
      nbuc_ := NVL(F_Codobl_Tobo(acc_,typ_),nbuc1_);
   ELSE
      nbuc_ := nbuc1_;
   END IF;

   IF Dosn_ > 0 
   THEN
      BEGIN
         SELECT NVL(ob22,'00') into zz_
         FROM specparam_int
         WHERE acc = acc_ ;
         EXCEPTION WHEN NO_DATA_FOUND THEN
         zz_ := '00';
      END ;
      if kk_d != '00' 
      then
         kk_ := kk_d;
      end if;
      if kk_d = '00' and kk_k != '00' 
      then
         kk_ := kk_k;
      end if;
      kodp_ := '5' || SUBSTR(nls_,1,4) || zz_ || kk_ ;
      znap_ := TO_CHAR(Dosn_) ;
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, ref, comm, nbuc) VALUES
                             (nls_, kv_, data_, kodp_,znap_, ref_, comm_, nbuc_);
   END IF;

   IF Kosn_ > 0 
   THEN
      BEGIN
         SELECT NVL(ob22,'00') into zz_
         FROM specparam_int
         WHERE acc = acc_ ;
         EXCEPTION WHEN NO_DATA_FOUND THEN
         zz_ := '00';
      END ;
      if kk_k != '00' 
      then
         kk_ := kk_k;
      end if;
      if kk_k = '00' and kk_d != '00' 
      then
         kk_ := kk_d;
      end if;
      kodp_ := '6' || SUBSTR(nls_,1,4) || zz_ || kk_ ;
      znap_ := TO_CHAR(Kosn_) ;
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, ref, comm, nbuc) VALUES
                             (nls_, kv_, data_, kodp_,znap_, ref_, comm_, nbuc_);
   END IF;
END LOOP;
CLOSE KOR_PROVODKI;
---------------------------------------------------
--- обороти по річних корегуючих проводках коды '5' и '6'
OPEN KOR_PROV_99;
LOOP
   FETCH KOR_PROV_99 INTO ref_, acc_, nls_, kv_, data_, Dosn_, Kosn_ ;
   EXIT WHEN KOR_PROV_99%NOTFOUND;

   kk_ := '00';

   BEGIN
      SELECT NVL(SUBSTR(value,1,2),'00') INTO kk_d
      FROM operw
      WHERE ref = ref_ 
        and tag = 'OB40' ;
   EXCEPTION WHEN NO_DATA_FOUND THEN
      kk_d := '00';
   END;

   BEGIN
      SELECT NVL(SUBSTR(value,1,2),'00') INTO kk_k
      FROM operw
      WHERE ref = ref_ 
        and tag = 'OB40D' ;
   EXCEPTION WHEN NO_DATA_FOUND THEN
      kk_k := '00';
   END;

   begin
      select nlsd, nlsk, nazn
         into nlsd_, nlsk_, nazn_
      from provodki_otc o, opldok z
      where o.fdat = data_ 
        and o.ref = ref_
        and o.ref = z.ref 
        and o.stmt = z.stmt
        and z.acc = acc_;
        
      comm_ := '';
      comm_ := substr(comm_||'Дт '||nlsd_||'  '||' Кт '||nlsk_||'  '||nazn_,1,200);
   exception when no_data_found then     
      comm_ := '';
   end;            

   IF typ_ > 0 
   THEN
      nbuc_ := NVL(F_Codobl_Tobo(acc_,typ_),nbuc1_);
   ELSE
      nbuc_ := nbuc1_;
   END IF;

   IF Dosn_ > 0 
   THEN
      BEGIN
         SELECT NVL(ob22,'00') into zz_
         FROM specparam_int
         WHERE acc = acc_ ;
         EXCEPTION WHEN NO_DATA_FOUND THEN
         zz_ := '00';
      END ;
      if kk_d != '00' 
      then
         kk_ := kk_d;
      end if;
      if kk_d = '00' and kk_k != '00' 
      then
         kk_ := kk_k;
      end if;
      kodp_ := '5' || SUBSTR(nls_,1,4) || zz_ || kk_ ;
      znap_ := TO_CHAR(Dosn_) ;
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, ref, comm, nbuc) VALUES
                             (nls_, kv_, data_, kodp_,znap_, ref_, comm_, nbuc_);
   END IF;

   IF Kosn_ > 0 
   THEN
      BEGIN
         SELECT NVL(ob22,'00') into zz_
         FROM specparam_int
         WHERE acc = acc_ ;
         EXCEPTION WHEN NO_DATA_FOUND THEN
         zz_ := '00';
      END ;
      if kk_k != '00' 
      then
         kk_ := kk_k;
      end if;
      if kk_k = '00' and kk_d != '00' 
      then
         kk_ := kk_d;
      end if;
      kodp_ := '6' || SUBSTR(nls_,1,4) || zz_ || kk_ ;
      znap_ := TO_CHAR(Kosn_) ;
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, ref, comm, nbuc) VALUES
                             (nls_, kv_, data_, kodp_,znap_, ref_, comm_, nbuc_);
   END IF;
END LOOP;
CLOSE KOR_PROV_99;
---------------------------------------------------
DELETE FROM tmp_irep where kodf='40' and datf= dat_;
---------------------------------------------------
INSERT INTO tmp_irep (kodf, datf, kodp, znap, nbuc)
select '40', Dat_, kodp, SUM (znap), nbuc
FROM rnbu_trace
GROUP BY kodp, nbuc;
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
