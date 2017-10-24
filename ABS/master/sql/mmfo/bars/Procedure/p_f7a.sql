

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F7A.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F7A ***

  CREATE OR REPLACE PROCEDURE BARS.P_F7A (Dat_ DATE,
                                      sheme_ varchar2 default 'G') IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	Процедура формирования файла #7A для КБ
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
% VERSION     : 12/04/2012 (31/03/2012)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
параметры: Dat_ - отчетная дата
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
12.04.2012 - формироем показатели с нулевыми значениями.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
kodf_    varchar2(2):='7A';
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
   SELECT '1010' from dual
   union all
   SELECT '2020' from dual
   union all
   SELECT '2030' from dual
   union all
   SELECT '2040' from dual
   union all
   SELECT '2050' from dual
   union all
   SELECT '2060' from dual
   union all
   SELECT '2070' from dual
   union all
   SELECT '2080' from dual
   union all
   SELECT '2090' from dual
   union all
   SELECT '1100' from dual
   union all
   SELECT '1101' from dual
   union all
   SELECT '1110' from dual
   union all
   SELECT '1111' from dual
   union all
   SELECT '1120' from dual
   union all
   SELECT '1121' from dual
   union all
   SELECT '1130' from dual
   union all
   SELECT '1131' from dual
   union all
   SELECT '1140' from dual
   union all
   SELECT '1141' from dual
   union all
   SELECT '1150' from dual
   union all
   SELECT '1161' from dual
   union all
   SELECT '1162' from dual;

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
END p_f7a;
/
show err;

PROMPT *** Create  grants  P_F7A ***
grant EXECUTE                                                                on P_F7A           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_F7A           to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F7A.sql =========*** End *** ===
PROMPT ===================================================================================== 
