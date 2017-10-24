

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F9A.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F9A ***

  CREATE OR REPLACE PROCEDURE BARS.P_F9A (Dat_ DATE,
                                      sheme_ varchar2 default 'D') IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	Процедура формирования файла #9A для CБ
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
% VERSION     : 18/09/2013 (22/06/2012)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
параметры: Dat_ - отчетная дата
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
18.09.2013 - добавлен показатель "3300"
01.07.2012 - формируем показатели с нулевыми значениями.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
kodf_    varchar2(2):='9A';
kodp_    Varchar2(14);
znap_    Varchar2(30);
ddd_     Varchar(3);
userid_  Number;
nbuc1_   varchar2(20);
nbuc_    varchar2(20);
typ_     Number;
mfo_     Number;
mfou_    Number;
tobo_    accounts.tobo%TYPE;
nms_     otcn_acc.nms%TYPE;
comm_    rnbu_trace.comm%TYPE;
daos_    Date;
add_     NUMBER;

--- остатки счетов+месячные корректирующие обороты+
CURSOR SALDO IS
   SELECT '3111' from dual
   union all
   SELECT '3119' from dual
   union all
   SELECT '3211' from dual
   union all
   SELECT '3219' from dual
   union all
   SELECT '3191' from dual
   union all
   SELECT '1191' from dual
   union all
   SELECT '3192' from dual
   union all
   SELECT '3300' from dual
   union all
   SELECT '1192' from dual
   union all
   SELECT '1101' from dual
   union all
   SELECT '1102' from dual
   union all
   SELECT '1103' from dual;

CURSOR BaseL IS
   SELECT kodp, nbuc, SUM(znap)
   FROM rnbu_trace
   WHERE userid=userid_
   GROUP BY kodp, nbuc;

BEGIN
-------------------------------------------------------------------
userid_ := user_id;

EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';
-------------------------------------------------------------------
-- свой МФО
   mfo_ := F_Ourmfo ();

-- МФО "родителя"
   BEGIN
      SELECT NVL(trim(mfou), mfo_)
        INTO mfou_
      FROM BANKS
      WHERE mfo = mfo_;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         mfou_ := mfo_;
   END;

-- определение кода МФО или кода области для выбранного файла и схемы
p_proc_set(kodf_,sheme_,nbuc1_,typ_);

nbuc_ := nbuc1_;

-------------------------------------------------------------------
--- остатки
OPEN SALDO;
LOOP
   FETCH SALDO INTO  kodp_;
   EXIT WHEN SALDO%NOTFOUND;

   INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
   VALUES (kodp_, 0, dat_, kodp_, '0', nbuc_);

END LOOP;
CLOSE SALDO;
---------------------------------------------------------------------------
-----------------------------------------------------------------------------
DELETE FROM tmp_nbu where kodf=kodf_ and datf= dat_;
---------------------------------------------------
OPEN BaseL;
LOOP
   FETCH BaseL INTO  kodp_, nbuc_, znap_;
   EXIT WHEN BaseL%NOTFOUND;
   INSERT INTO tmp_nbu
        (kodf, datf, kodp, znap, nbuc)
   VALUES
        (kodf_, Dat_, kodp_, znap_, nbuc_);
END LOOP;
CLOSE BaseL;
----------------------------------------
END p_f9a;
/
show err;

PROMPT *** Create  grants  P_F9A ***
grant EXECUTE                                                                on P_F9A           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_F9A           to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F9A.sql =========*** End *** ===
PROMPT ===================================================================================== 
