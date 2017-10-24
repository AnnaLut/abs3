

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F07_NN.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F07_NN ***

  CREATE OR REPLACE PROCEDURE BARS.P_F07_NN (Dat_ DATE,
                                      sheme_ varchar2 default 'G')  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :    Процедура формирование файла #07 для КБ
% COPYRIGHT   :    Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
% VERSION     : 29/03/2016 (10/07/2015, 26/02/2015)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    параметры: Dat_ - отчетная дата
               sheme_ - схема формирования
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
29.03.2016 - на 01.04.2016 будет формироваться новая часть показателя 
             "код виду цінних паперів" (параметр S130 2-х значный код) 
10.07.2015 - для KL_K070 добавлено условие "D_CLOSE is null"
             после перехода на DRAPS(ы) не будем добавлять коректирующие 
             проводки по родительским счетам (они уже добавлены) 
25.02.2015 - для нерезидентов параметр K072 будет равен '0'
             (изменения необходимы для ФЛ предпринимателей Крыма)
07.02.2014 - для бал.счета 3115 выбираем родительские счета вместо 
             дочерних (Замечание ГОУ) 
21.01.2014 - добавлен блок для наполнения корректирующих проводок 
             прошлого и текущего отчетных месяцев по родительским счетам 
             из дочерних (счета для ЦБ)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
kodf_    varchar2(2):='07';
rnk_     number;
typ_     number;
acc_     Number;
acc1_    Number;
mfo_     Number;
mfou_    Number;
nbs_     Varchar2(4);
nls_     Varchar2(15);
data_    Date;
Dat1_    Date;
Dat2_    Date;
kv_      SMALLINT;
rez_     SMALLINT;
se_      DECIMAL(24);
Ostn_    DECIMAL(24);
Ostq_    DECIMAL(24);
Dos96_   DECIMAL(24);
Kos96_   DECIMAL(24);
Dosq96_  DECIMAL(24);
Kosq96_  DECIMAL(24);
dk_      Char(1);
kodp_    Varchar2(13);
znap_    Varchar2(30);
s180_    Varchar2(1);
s183_    Varchar2(1);
r011_    Varchar2(1);
r012_    Varchar2(1);
s120s_   Varchar2(1);
s120_    Varchar2(1);
s130_    Varchar2(2);
k071_    Varchar2(1);
k072_    Varchar2(1);
r031_    Char(1);
kol_     Number;
pr_accc  Number;
userid_  Number;
nbuc1_   varchar2(12);
nbuc_    varchar2(12);
DatN_    date;
sql_acc_ varchar2(2000):='';
sql_doda_ varchar2(200):='';
ret_     number;
dati_    NUMBER;
dats_    Date;

---Значение R011 из кл-ра KL_R011
CURSOR SCHETA IS
   SELECT k.r011
   FROM accounts a, accounts b, kl_r011 k
   WHERE a.nbs = nbs_ and a.nbs = k.r020 and a.kv = b.kv and
         substr(a.nls,6,9) = substr(b.nls,6,9) and
         b.nbs = k.r020r011 and trim(k.prem) = 'КБ' and a.acc = acc_ ;

--Остатки
CURSOR Saldo IS
   SELECT s.rnk, s.acc, s.nls, s.kv, s.fdat, s.nbs,
          NVL(cd.k071,'0'), NVL(cd.k072,'0'), 2-mod(cc.codcagent,2),
          s.ost, s.ostq, s.dos96, s.kos96, s.dosq96, s.kosq96,
          NVL ( sp.s130, '00')
   FROM  otcn_saldo s, customer cc, kl_k070 cd, specparam sp 
   WHERE (s.ost-s.dos96+s.kos96<>0 OR s.ostq-s.dosq96+kosq96 <> 0)
     and s.rnk = cc.rnk
     and cc.ise = cd.k070(+) 
     and cd.d_open <= dat_ 
     and (cd.d_close is null or cd.d_close > dat_)
     and s.acc = sp.acc (+);

procedure p_ins(p_dat_ date, p_tp_ varchar2, p_nls_ varchar2,p_nbs_ varchar2,
          p_kv_ smallint, p_r011_ varchar2, p_k071_ varchar2,
          p_s183_ varchar2, p_s130_ varchar2, 
                p_znap_ varchar2, p_nbuc_ varchar2) IS
                kod_ varchar2(13);

begin

   kod_:= p_tp_ || p_nbs_ || p_r011_ || p_k071_ || lpad(p_kv_,3,'0') || p_s183_ || p_s130_;

   INSERT INTO rnbu_trace
            (nls, kv, odate, kodp, znap, nbuc)
   VALUES  (p_nls_, p_kv_, p_dat_, kod_, p_znap_, p_nbuc_);
end;
-----------------------------------------------------------------------------
BEGIN
commit;
       
EXECUTE IMMEDIATE 'ALTER SESSION ENABLE PARALLEL DML';
-------------------------------------------------------------------
logger.info ('P_F07_NN: Begin ');
-------------------------------------------------------------------
userid_ := user_id;

EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';
-------------------------------------------------------------------
mfo_:=F_OURMFO();

-- МФО "родителя"
BEGIN
   SELECT mfou
     INTO mfou_
   FROM BANKS
   WHERE mfo = mfo_;
EXCEPTION WHEN NO_DATA_FOUND THEN
   mfou_ := mfo_;
END;

-- определение кода МФО или кода области для выбранного файла и схемы
p_proc_set(kodf_,sheme_,nbuc1_,typ_);

dati_ := f_snap_dati(dat_, 2);

if mfou_ in (300205, 300465, 380623) then
   sql_acc_ := 'select r020 from kod_r020 where trim(prem)=''КБ'' and a010=''07'') or '||
               '(nbs is null and substr(nls,1,4) in
                (select r020 from kod_r020 where trim(prem)=''КБ'' and a010=''07'')';
else
   sql_acc_ := 'select r020 from kod_r020 where trim(prem)=''КБ'' and a010=''07'' ';
end if;

ret_ := f_pop_otcn(Dat_, 2, sql_acc_,null,1); -- после перехода на SNAP таблицы

BEGIN
   SELECT TO_DATE(val,'DDMMYYYY') 
      INTO dats_ 
   FROM params WHERE par='DATRAPS';
EXCEPTION
   WHEN NO_DATA_FOUND
   THEN
      dats_ := null;
END;

if mfo_ = 300465 then
   -- блок для наполнения корректирующих проводок
   -- прошлого и текущего отчетных месяцев
   -- по родительским счетам из дочерних
   IF dats_ is null 
   THEN
      for tt in ( select a.accc accc, a.acc acc, a.nls, a.kv,
                         s.crdos, s.crdosq, s.crkos, s.crkosq,
                         s.cudos, s.cudosq, s.cukos, s.cukosq
                  from accounts a, accm_agg_monbals s, kod_r020 k
                  where a.accc is not null
                    and a.acc = s.acc
                    and s.caldt_id = dati_
                    and a.nls like k.r020 || '%'
                    and a010 = '02'
                    and trim(prem)='КБ'
                )

         loop

            if tt.cudos+tt.cudosq+tt.cukos+tt.cukosq+tt.crdos+tt.crdosq+tt.crkos+tt.crkosq<>0 then

               update otcn_saldo set dos96p=dos96p+tt.cudos, dosq96p=decode(tt.kv,980,0,dosq96p+tt.cudosq),
                                     kos96p=kos96p+tt.cukos, kosq96p=decode(tt.kv,980,0,kosq96p+tt.cukosq),
                                     dos96=dos96+tt.crdos,   dosq96=decode(tt.kv,980,0,dosq96+tt.crdosq),
                                     kos96=kos96+tt.crkos,   kosq96=decode(tt.kv,980,0,kosq96+tt.crkosq)
               where acc = tt.accc;
            end if;

      end loop;
   END IF;

   -- коригуючі за минулий місяць добавляємо по "родительским" рахункам
   IF to_char(dats_,'MM') = to_char(Dat_,'MM') 
   THEN
      for tt in ( select a.accc accc, a.acc acc, a.nls, a.kv, 
                         s.crdos, s.crdosq, s.crkos, s.crkosq,
                         s.cudos, s.cudosq, s.cukos, s.cukosq  
                  from accounts a, accm_agg_monbals s, kod_r020 k
                  where a.accc is not null
                    and a.acc = s.acc 
                    and s.caldt_id = dati_
                    and a.nls like k.r020 || '%'
                    and a010 = '02' 
                    and trim(prem)='КБ' 
                )

         loop
    
            if tt.cudos+tt.cudosq+tt.cukos+tt.cukosq<>0 then

               update otcn_saldo set dos96p = dos96p + tt.cudos, 
                                     dosq96p = dosq96p + decode(tt.kv, 980, 0, tt.CUdosq),
                                     kos96p = kos96p + tt.cukos, 
                                     kosq96p = kosq96p + decode(tt.kv, 980, 0, tt.CUkosq)
               where acc = tt.accc;

            end if;  

      end loop;
   END IF;

end if;
----------------------------------------------------------------------
OPEN SALDO;
LOOP
   FETCH SALDO INTO rnk_, acc_, nls_, kv_, data_, nbs_, k071_, k072_, rez_, 
                    Ostn_, Ostq_, Dos96_, Kos96_, Dosq96_, Kosq96_, s130_;
   EXIT WHEN SALDO%NOTFOUND;

   IF kv_ <> 980 THEN
      se_ := Ostq_-Dosq96_+Kosq96_;
      if se_ = 0 then
         se_ := GL.P_ICURVAL(kv_, Ostn_-Dos96_+Kos96_, Dat_);
      end if;
   ELSE
      se_ := Ostn_-Dos96_+Kos96_;
   END IF;

   if nbs_ is null then
      -- отбор корректирующих по дочерним счетам ЦБ
      BEGIN
         SELECT NVL(SUM(DECODE(a.DK, 0, a.s, 0)),0),
                NVL(SUM(DECODE(s.kv,980,0,DECODE(a.DK, 0, Gl.P_Icurval(s.kv, a.s, p.vDat),0))),0),
                NVL(SUM(DECODE(a.DK, 1, a.s, 0)),0),
                NVL(SUM(DECODE(s.kv,980,0,DECODE(a.DK, 1, Gl.P_Icurval(s.kv, a.s, p.vDat),0))),0)
             INTO dos96_, dosq96_, kos96_, kosq96_
         FROM ref_kor p, opldok a, otcn_saldo s
         WHERE a.sos = 5
           and a.fdat >= dat_+1
           and a.fdat <= dat_+28
           and a.ref = p.ref
           and a.acc = s.acc
           and s.acc = acc_;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         dos96_ := 0;
         dosq96_ := 0;
         kos96_ := 0;
         kosq96_ := 0;
      END;

      IF kv_ <> 980 THEN
         se_ := Ostq_ - Dosq96_ + Kosq96_;
         if se_ = 0 then
            se_ := GL.P_ICURVAL(kv_, Ostn_ - Dos96_ + Kos96_, Dat_);
         end if;
      ELSE
         se_ := Ostn_ - Dos96_ + Kos96_;
      END IF;

   end if;

   IF se_ <> 0 THEN

      if rez_ = 2 then 
         k072_ := '0';
      end if;

      if typ_ > 0 then  
         nbuc_ := nvl(f_codobl_tobo_new(acc_,dat_,typ_),nbuc1_);
      else
         nbuc_ := nbuc1_;
      end if;

      pr_accc:=0;

      if mfou_ in (300205,300465) and substr(nls_,1,3) in
                                           ('140','141','142','143','144',
                                            '300','301','310','311','312',
                                            '313','321','330','331','410','420') then
         if nbs_ is not null
            and ((mfo_ = 300465 and nbs_ not in ('1405','1415','1435','3007','3015','3107','3115')) or
                  mfo_ <> 300465)
         then
            BEGIN
               SELECT count(*)
                  INTO pr_accc
               FROM otcn_saldo a, accounts s
               WHERE s.accc = acc_
                 and s.accc = a.acc
                 and s.nbs is null;
            EXCEPTION WHEN NO_DATA_FOUND THEN
               pr_accc := 0;
            END ;
         end if;
      end if;

      if (mfou_ in (300205,300465) and
         ((nbs_ is null
           and ((mfo_ = 300465 and substr(nls_,1,4) not in ('1405','1415','1435','3007','3015','3107','3115')) or
                mfo_ <> 300465)
          ) OR
          (pr_accc = 0 and nbs_ is not null))) OR
         mfou_ not in (300205,300465) then

         if nbs_ is null then
            nbs_ := substr(nls_,1,4);
         end if;
-----------------------------------------------------------------------------
         begin
            r011_ := '0';

            BEGIN
               SELECT count(*) INTO kol_
               FROM KL_R011
               WHERE r020 = nbs_ ;
            EXCEPTION WHEN NO_DATA_FOUND THEN
               kol_ := 0;
            END ;

            IF kol_<>0 THEN
               BEGIN
                  SELECT acc, nvl(r011,'0') into acc1_, r011_
                  FROM specparam
                  WHERE acc = acc_ ;
               EXCEPTION WHEN NO_DATA_FOUND THEN     
                  acc1_ := 0;
                  r011_ := '0';
               END ;

               IF acc1_=0  THEN
                  insert into specparam (acc,r011) values (acc_,'0') ;
                  acc1_ := acc_;
               END IF;

               IF r011_ = '0' THEN
                  OPEN SCHETA;
                     LOOP
                        FETCH Scheta INTO r012_ ;
                        EXIT WHEN Scheta%NOTFOUND;

                        IF acc1_>0 and r011_='0' THEN
                           update specparam set r011 = r012_ where acc = acc_ ;
                           r011_ := r012_ ;
                        END IF;

                     END LOOP;
                  CLOSE Scheta;
               END IF ;
            END IF;

            IF (kol_ <> 0 and r011_ = '0') or k072_ = '0' THEN
               nls_ := 'X' || nls_;
            END IF;
         end;

         BEGIN
            SELECT DECODE(Trim(s180), NULL, Fs180(acc_,SUBSTR(nbs_,1,1), dat_), s180)
            INTO s180_
            FROM specparam
            WHERE acc = acc_ ;
         EXCEPTION WHEN NO_DATA_FOUND THEN
            s180_ := '0';
         END ;

         IF substr(nbs_,1,3) in ('140','301') and s180_='0' THEN
            s180_ := '1';
         END IF;

-- с 01.02.2007 добавляется параметр S183
         BEGIN
            SELECT NVL(s183,'0')
            INTO S183_
            FROM kl_s180
            WHERE s180 = s180_;
         EXCEPTION WHEN NO_DATA_FOUND THEN
            s183_ := '0';
         END ;

         dk_ := IIF_N(se_,0,'1','2','2');
         p_ins(data_, dk_, nls_, nbs_, kv_, r011_, k072_, s183_, s130_, TO_CHAR(ABS(se_)), nbuc_);
      end if;
   END IF;
END LOOP;
CLOSE SALDO;
---------------------------------------------------
DELETE FROM tmp_nbu where kodf=kodf_ and datf= dat_;
---------------------------------------------------
INSERT INTO TMP_NBU (kodf, datf, kodp, nbuc, znap)
select kodf_, dat_, kodp, nbuc, SUM(znap)
from RNBU_TRACE  
GROUP BY kodp, nbuc;

----------------------------------------
logger.info ('P_F07_NN: End ');

END p_f07_nn;
/
show err;

PROMPT *** Create  grants  P_F07_NN ***
grant EXECUTE                                                                on P_F07_NN        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_F07_NN        to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F07_NN.sql =========*** End *** 
PROMPT ===================================================================================== 
