

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F21SB.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F21SB ***

  CREATE OR REPLACE PROCEDURE BARS.P_F21SB (Dat_ DATE)  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	Процедура формирование файла @22 для КБ
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 2009.All Rights Reserved.
% VERSION     : 30.04.2011 (01.03.11,05.11.09,28.07.09,10.07.09,08.07.09,
%             :             07.05.09,23.02.09 Версия для Сбербанка)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
параметры: Dat_ - отчетная дата
           sheme_ - схема формирования
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%30.04.2011 добавил acc,tobo в протокол
%01.03.2011 в поле комментарий вносим код TOBO и название счета
%05.11.2009 для Житомира СБ по бал.счетам 3902,3903 параметр S240 будем
%           вычислять
%28.07.2009 формировались строки с нулевыми значениями. Исправлено.
%10.07.2009 убрал ORDER BY для табл. RNBU_TRACE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
kodf_    varchar2(2):='21';
rnk_     number;
typ_ 	 number;
acc_     Number;
dat1_    Date;
Dose_    DECIMAL(24);
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
se_      DECIMAL(24);
Ostn_    DECIMAL(24);
Ostq_    DECIMAL(24);
kodp_    Varchar2(12);
znap_    Varchar2(30);
Kv_      SMALLINT;
Nbs_     Varchar2(4);
nls_     Varchar2(15);
data_    Date;
dk_      varchar2(2);
userid_  Number;
sql_acc_ varchar2(2000):='';
sql_doda_ varchar2(200):='';
s240_    Varchar2(1);
s240n_   Varchar2(1);
mfo_     VARCHAR2(12);
ret_	 NUMBER;
tobo_    accounts.tobo%TYPE;
nms_     accounts.nms%TYPE;
comm_    rnbu_trace.comm%TYPE;

-------------------------------------------------------------------------------
CURSOR Saldo IS
   SELECT s.rnk, s.acc, s.nls, s.kv, s.fdat, s.nbs, s.ost, s.ostq,
          s.dos, s.dosq, s.kos, s.kosq,
          s.dos96p, s.dosq96p, s.kos96p, s.kosq96p,
          s.dos96, s.dosq96, s.kos96, s.kosq96,
          s.dos99, s.dosq99, s.kos99, s.kosq99,
          s.doszg, s.koszg, s.dos96zg, s.kos96zg,
          DECODE (a.mdate, NULL, NVL(Trim(p.S240),'0'), Fs240 (dat_, a.acc)),
          a.tobo, a.nms
    FROM  otcn_saldo s, otcn_acc a, specparam p
    WHERE a.acc=s.acc
      and s.acc=p.acc(+);
---------------------------------------------------------------------------
CURSOR BaseL IS
    SELECT kodp, SUM (znap)
    FROM rnbu_trace
    WHERE userid=userid_
    GROUP BY kodp;
---------------------------------------------------------------------------
-------------------------------------------------------------------------------
procedure p_ins(p_dat_ date, p_tp_ varchar2, p_acc_ number, p_nls_ varchar2,
                p_nbs_ varchar2, p_s240_ varchar2, p_kv_ smallint,
  		p_znap_ varchar2, p_comm_ varchar2, p_tobo_ varchar2) IS
                kod_ varchar2(10);

begin

   kod_:= p_tp_ || p_nbs_ || s240_ || LPAD(p_kv_,3,'0') ;

   INSERT INTO rnbu_trace
            (nls, kv, odate, kodp, znap, acc, comm, tobo)
   VALUES  (p_nls_, p_kv_, p_dat_, kod_, p_znap_, p_acc_, p_comm_, p_tobo_);
end;
-------------------------------------------------------------------------------
BEGIN
-------------------------------------------------------------------
--SELECT id INTO userid_ FROM staff WHERE upper(logname)=upper(USER);
userid_ := user_id;
EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';
-------------------------------------------------------------------
mfo_:=gl.aMFO;
if mfo_ is null then
    mfo_ := f_ourmfo_g;
end if;

-- определение кода области для выбранного файла и схемы
--p_proc_set(kodf_,sheme_,nbuc1_,typ_);

--- удаление информации из табл. otcn_acc, otcn_saldo
--- наполнение счетов (в том числе счетов тех.переоценки) и
--- их остатков (номиналы+эквиваленты)+обороты+корректирующие обороты
--- все эти действия выполняются в функции F_POP_OTCN

-- используем классификатор SB_R020
sql_acc_ := 'select r020 from sb_r020 where f_21=''1'' ';

ret_ := f_pop_otcn(Dat_, 3, sql_acc_);

Dat1_ := TRUNC(Dat_,'MM'); -- початок попереднього м_сяця
----------------------------------------------------------------------------
OPEN Saldo;
   LOOP
   FETCH Saldo INTO rnk_, acc_, nls_, kv_, data_, Nbs_, Ostn_, Ostq_,
                    Dos_, Dosq_, Kos_, Kosq_,
                    Dos96p_, Dosq96p_, Kos96p_, Kosq96p_,
                    Dos96_, Dosq96_, Kos96_, Kosq96_,
                    Dos99_, Dosq99_, Kos99_, Kosq99_,
                    Doszg_, Koszg_, Dos96zg_, Kos96zg_, s240_,
                    tobo_, nms_;
   EXIT WHEN Saldo%NOTFOUND;

   comm_ := '';

   IF to_char(Dat_,'MM')='12' THEN
      BEGIN
         SELECT NVL(SUM(p.s*DECODE(p.DK,0,-1,1,1,0)),0) INTO Dose_
         FROM OPER o, OPLDOK p
         WHERE o.REF  = p.REF  AND
               p.FDAT = dat_   AND
               o.SOS  = 5      AND
               p.acc  = acc_   AND
               (o.tt  LIKE  'ZG%' OR
               ((SUBSTR(o.nlsa,1,1) IN ('6','7') AND
                 SUBSTR(o.nlsb,1,4) IN ('5040','5041')) OR
                (SUBSTR(o.nlsa,1,4) IN ('5040','5041') AND
                SUBSTR(o.nlsb,1,1) IN ('6','7'))));
      EXCEPTION WHEN NO_DATA_FOUND THEN
         Dose_:=0;
      END;
      Ostn_:=Ostn_-Dose_;
   END IF;

   IF nbs_ in ('3902','3903') THEN --- and s240_='0'
      s240_:='C';  --'9' ;
   END IF;

   IF mfo_ = 311647 and nbs_ in ('3902','3903') THEN
      s240n_:=FS240(Dat_,acc_) ;
      IF s240n_<>'0' THEN
         s240_:=s240n_;
      END IF;
   END IF;

   IF substr(nbs_,1,2) in ('10','11') or
      substr(nbs_,1,3) in ('120','130','150','160') THEN  --- and s240_='0'
      s240_:='1' ;
   END IF;

   IF substr(nbs_,1,2)='25' or
      substr(nbs_,1,3) in ('260','262','264','370','371','372') THEN  -- or
-- убрал по просьбе Оли 26.09.2006   292 и 373 группы
--      substr(nbs_,1,3)='292' or substr(nbs_,1,2)='37') THEN   --- and s240_='0'
      s240_:='1' ;
   END IF;

   IF nbs_ in ('3900','3901','3906','3907') or
      substr(nbs_,1,3) in ('391','392') THEN  --- and s240_='0'
      s240_:='1' ;
   END IF;

   IF substr(nbs_,1,3) in ('149','158','159','178','179','188','189') THEN   --- and s240_='0'
      s240_:='C';  --'9' ;
   END IF;

   IF substr(nbs_,1,3) in ('209','219','229','288','289','319') or
      substr(nbs_,1,2)='24' THEN   --- and s240_='0'
      s240_:='C';  --'9' ;
   END IF;

   IF nbs_ in ('3290','3299') or substr(nbs_,1,3) in ('229','350','358','359') or
      substr(nbs_,1,2)='34' THEN   --- and s240_='0'
      s240_:='C';  --'9' ;
   END IF;

   IF substr(nbs_,1,3) in ('360','369') or substr(nbs_,1,2)='38' or
      substr(nbs_,1,1) in ('5','6','7') THEN   --- and s240_='0'
      s240_:='C';  --'9' ;
   END IF;

   IF (nbs_='1509' or nbs_='1517' or nbs_='1519' or nbs_='1527' or
       nbs_='1529' or nbs_='2027' or nbs_='2029' or nbs_='2037' or
       nbs_='2039') THEN   --- and s240_='0'
      s240_:='C';  --'9' ;
   END IF;

   IF nbs_ in ('2047','2049','2057','2059','2067','2069','2077','2079') THEN   --- and s240_='0'
      s240_:='C';  --'9' ;
   END IF;

   IF nbs_ in ('2107','2109','2117','2119','2207','2209','2217','2219',
               '3119','3219','3579') THEN   --- and s240_='0'
      s240_:='C';  --'9' ;
   END IF;

   IF substr(nbs_,1,2)='37' or nbs_='3906' or
      substr(nbs_,1,3) in ('391','392','340','341','350') THEN
       s240n_:=FS240(Dat_,acc_) ;
       IF s240n_<>'0' THEN
          s240_:=s240n_;
       END IF;
   END IF;

   IF mfo_ = 333368 and  substr(nbs_,1,3) in ('371','372') THEN
      s240_:='3';
   END IF;

   IF mfo_ = 333368 and  substr(nbs_,1,1) in ('5','6','7') THEN
      s240n_:=FS240(Dat_,acc_) ;
      IF s240n_<>'0' THEN
         s240_:=s240n_;
      END IF;
   END IF;

   if kv_ = 980 then
      se_:=Ostn_-Dos96_+Kos96_;
   else
      se_:=Ostq_-Dosq96_+Kosq96_;
   end if;

   IF se_<>0 THEN
      comm_ := substr(comm_ || tobo_ || '  ' || nms_, 1, 200);
      dk_:=IIF_N(se_,0,'10','20','20');
      p_ins(data_, dk_, acc_, nls_, nbs_, s240_, kv_, TO_CHAR(ABS(se_)), comm_, tobo_);
   END IF;

END LOOP;
CLOSE Saldo;
---------------------------------------------------------------------------
---------------------------------------------------
DELETE FROM tmp_irep where kodf=kodf_ and datf=dat_;
---------------------------------------------------
OPEN BaseL;
LOOP
   FETCH BaseL INTO  kodp_, znap_;
   EXIT WHEN BaseL%NOTFOUND;

   INSERT INTO tmp_irep
	  (kodf, datf, kodp, znap)
   VALUES
	  (kodf_, Dat_, kodp_, znap_);
END LOOP;
CLOSE BaseL;
------------------------------------------------------------------
END p_f21sb;
/
show err;

PROMPT *** Create  grants  P_F21SB ***
grant EXECUTE                                                                on P_F21SB         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_F21SB         to RPBN002;
grant EXECUTE                                                                on P_F21SB         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F21SB.sql =========*** End *** =
PROMPT ===================================================================================== 
