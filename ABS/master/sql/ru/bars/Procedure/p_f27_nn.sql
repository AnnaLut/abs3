

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F27_NN.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F27_NN ***

  CREATE OR REPLACE PROCEDURE BARS.P_F27_NN (Dat_ DATE ,
                                      sheme_ varchar2 default 'G')  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	Процедура формирования #27 для КБ (универсальная)
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     : 14/11/2017 (03/03/2015, 18.07.2014)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    параметры: Dat_ - отчетная дата
               sheme_ - схема формирования
14.11.2017 - удалил ненужные строки и изменил некоторые блоки формирования 
11.07.2014 = для банка Надра добавил проводки Дт 2900 Кт 2900 и TT='GO2'
30.05.2014 - для mfou_=300465 и показателя 7290900VVV будем включать 
             проводки Дт 2909 (OB22=55,56,75 добавлено значение 55) и 
             Кт 2900 (OB22=01 для 2900 убрал OB22=04)
10.04.2014 - для 300465 Кт 2900 выбираем OB22 in ('01','04') ранее было
             только '01' (замечание РУ Ровно)
17.02.2014 - проводки Дт 1919 Кт 3800 только для 300465
             проводки Дт 1919 Кт 3640 только для 380764
14.02.2014 - для 380764 удаляем проводки 
             Дт 1919  Кт 2900 OB22 in ('02','08') (свободная продажа)
13.02.2014 - будут включаться проводки Дт 1919,2909 Кт 2900,3800,3640
12.02.2014 - c 11.02.2014 добавлено формирование новых показателей 
             7191900VVV, 7290900VVV
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
kodf_    varchar2(2):='27';
typ_ number; 

acc_     Number;
nbs_     Varchar2(4);
nls_     Varchar2(15);
mfo_     number;
mfou_    number;
nbuc1_   Varchar2(12);
nbuc_    Varchar2(12);
data_    Date;
kv_      SMALLINT;
d020_    Varchar2(2);
sDos_    DECIMAL(24);
sKos_    DECIMAL(24);
kodp_    Varchar2(10);
znap_    Varchar2(30);
userid_  Number;

---  ОБОРОТЫ  Дт и Кт (списания и зачисления по 2603)
CURSOR SALDO IS
   SELECT a.acc, a.nls, a.kv, a.fdat, a.nbs, a.dos, a.kos,
          NVL(F_Codobl_Tobo_new(acc_, dat_, typ_), nbuc1_) nbuc
   FROM sal a
   WHERE a.fdat = Dat_    
     and a.dos + a.kos <> 0  
     and a.nbs like '2603%'  
     and a.kv NOT IN (980,959,961,962,964);

BEGIN

commit;

EXECUTE IMMEDIATE 'ALTER SESSION ENABLE PARALLEL DML';
-------------------------------------------------------------------
logger.info ('P_F27_NN: Begin for datf = '||to_char(dat_, 'dd/mm/yyyy'));
-------------------------------------------------------------------
userid_ := user_id;
EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';
-------------------------------------------------------------------
mfo_ := f_ourmfo;

-- МФО "родителя"
BEGIN
   SELECT mfou
     INTO mfou_
     FROM BANKS
    WHERE mfo = mfo_;
EXCEPTION
   WHEN NO_DATA_FOUND
   THEN
      mfou_ := mfo_;
END;

-- определение начальных параметров
p_proc_set(kodf_,sheme_,nbuc1_,typ_);

OPEN SALDO;
LOOP
   FETCH SALDO INTO acc_, nls_, kv_, data_, nbs_, sDos_, sKos_, nbuc_ ;
   EXIT WHEN SALDO%NOTFOUND;
   
   kv_ := lpad(kv_,3,'0');
   
   IF sDos_ > 0 
   THEN
      kodp_:= '5' || nbs_ || '00' || kv_;
      znap_:= TO_CHAR(sDos_) ;
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc) VALUES
                              (nls_, kv_, data_, kodp_, znap_, nbuc_);
   END IF ;

   IF sKos_ > 0 
   THEN
      kodp_:= '6' || nbs_ || '00' || kv_;
      znap_:= TO_CHAR(sKos_) ;
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc) VALUES
                              (nls_, kv_, data_, kodp_, znap_, nbuc_);
   END IF ;

END LOOP;
CLOSE SALDO;
---------------------------------------------------
if dat_ >= to_date('20112012','ddmmyyyy') 
then

   for k in ( select p.ref, p.fdat, p.tt, p.accd, p.nlsd, p.kv, p.nlsk, substr(p.nlsd,1,4) nbs, 
                     p.nazn, p.s*100 s, NVL(substr(trim(w.value),1,2),'00') d020,
                     NVL(p.ob22k,'00') ob22
              from provodki_otc p, operw w, oper o 
              where p.fdat = Dat_ 
                and p.ref = o.ref 
                and o.sos = 5
                and p.kv not in (980, 959, 961, 962, 964)
                and p.nlsd like '2603%'  
                and p.nlsk not like '25%'  
                and p.nlsk not like '26%'
                and p.ref = w.ref(+)
                and w.tag(+) like 'D020%'  
            )

      loop

         if typ_ > 0 
         then
            nbuc_ := nvl(F_Codobl_Tobo_new(k.accd, dat_, typ_),nbuc1_);
         else
            nbuc_ := nbuc1_;
         end if;

         d020_ := k.d020;

         if d020_ = '00' 
         then
            BEGIN
               select NVL(substr(trim(value),1,2),'00')
                  into d020_
               from operw 
               where ref(+) = k.ref
                 and tag(+) like 'D#27%';
            EXCEPTION WHEN NO_DATA_FOUND THEN
               NULL;
            END; 
         end if;

         if (d020_ not in ('01') and  (LOWER(k.nazn) like '%обов%прод%'             or
                                       LOWER(k.nazn) like '%обов_язков__ продаж%'   or 
                                       LOWER(k.nazn) like '%обовязков__ продаж%'    or
                                       LOWER(k.nazn) like '%обов_зков__ продаж%'    or 
                                       LOWER(k.nazn) like '%обовязков__ прдаж%'     or
                                       LOWER(k.nazn) like '%обов_язк. продаж%'      or 
                                       LOWER(k.nazn) like '%обов_язк. прод.%'       or
                                       LOWER(k.nazn) like '%обовязк. прод.%'        or
                                       LOWER(k.nazn) like '%обов_язкового продажу%' or
                                       LOWER(k.nazn) like '%обовязкового продажу%'  or 
                                       LOWER(k.nazn) like '%обязательный продаж%'   or
                                       LOWER(k.nazn) like '%об_язательный продаж%'  or
                                       LOWER(k.nazn) like '%об_язательная продажа%' or
                                       LOWER(k.nazn) like '%обязательная продажа%'  or  
                                       LOWER(k.nazn) like '%внутр_шн_й переказ%'    ) ) OR 
            (mfou_ = 300465 and k.nlsk like '2900%' and k.ob22 = '04')                  OR
             d020_ = '01'   
         then
            kodp_ := '7' || k.nbs || '00' || lpad(k.kv,3,'0');
            znap_:= TO_CHAR(k.s) ;
            INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, ref, nbuc) VALUES
                                   (k.nlsd, k.kv, k.fdat, kodp_, znap_, k.ref, nbuc_);
         end if;

      end loop; 

end if;
--------------------------------------------------------------------------------
if dat_ >= to_date('11022014','ddmmyyyy') 
then

   for k in ( select p.ref, p.fdat, p.tt, p.accd, p.nlsd, p.kv, p.nlsk, substr(p.nlsd,1,4) nbs, 
                     p.nazn, p.s*100 s, NVL(substr(trim(w.value),1,2),'00') d020,
                     NVL(p.ob22d,'00') ob22d, NVL(p.ob22k,'00') ob22k
              from provodki_otc p, operw w, oper o 
              where p.fdat = Dat_ 
                and p.ref = o.ref 
                and o.sos = 5
                and p.kv not in (980, 959, 961, 962, 964)
                and ( (p.nlsd like '2909%' and p.nlsk like '2900%') or   
                      (p.nlsd like '1919%' and p.nlsk like '2900%') or 
                      (p.nlsd like '1919%' and p.nlsk like '3800%' and mfo_ = 300465) or 
                      (p.nlsd like '1919%' and p.nlsk like '3640%' and mfo_ = 380764)
                    )
                and p.ref = w.ref(+)
                and w.tag(+) like 'D020%'  
            )

      loop

         if typ_ > 0 
         then
            nbuc_ := nvl(F_Codobl_Tobo_new(k.accd, dat_, typ_),nbuc1_);
         else
            nbuc_ := nbuc1_;
         end if;

         d020_ := k.d020;

         if d020_ = '00' 
         then
            BEGIN
               select NVL(substr(trim(value),1,2),'00')
                  into d020_
               from operw 
               where ref(+) = k.ref
                 and tag(+) like 'D#27%';
            EXCEPTION WHEN NO_DATA_FOUND THEN
               NULL;
            END; 
         end if;

         if ( (k.nlsd like '2909%' and k.ob22d in ('55','56','75') and
               k.nlsk like '2900%' and k.ob22k = '01' ) OR
              (k.nlsd like '1919%' and k.ob22d = '02' and
               k.nlsk like '3800%' and k.ob22k = '10') 
            )
         then
            kodp_ := '7' || k.nbs || '00' || lpad(k.kv,3,'0');
            znap_:= TO_CHAR(k.s) ;
            INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, ref, nbuc) VALUES
                                   (k.nlsd, k.kv, k.fdat, kodp_, znap_, k.ref, nbuc_);
         end if;

      end loop; 

end if;
---------------------------------------------------
DELETE FROM tmp_nbu where kodf = kodf_ and datf = dat_;
---------------------------------------------------
INSERT INTO tmp_nbu (kodf, datf, kodp, znap, nbuc)
SELECT kodf_, Dat_, kodp, SUM (znap), nbuc
FROM rnbu_trace
GROUP BY kodf_, Dat_, kodp, nbuc;
-------------------------------------------------
logger.info ('P_F27_NN: End for datf = '||to_char(dat_, 'dd/mm/yyyy'));
END p_f27_NN;
/
show err;

PROMPT *** Create  grants  P_F27_NN ***
grant EXECUTE                                                                on P_F27_NN        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F27_NN.sql =========*** End *** 
PROMPT ===================================================================================== 
