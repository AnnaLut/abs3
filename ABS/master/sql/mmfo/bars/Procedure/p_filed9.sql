

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_FILED9.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_FILED9 ***

  CREATE OR REPLACE PROCEDURE BARS.P_FILED9 (DAT_ DATE, sheme_ VARCHAR2 DEFAULT 'G') IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	Процедура консолидации по типу "Спецобработка #91"
%  			  	для файла D9
% COPYRIGHT   :	COPYRIGHT UNITY-BARS LIMITED, 1999.  ALL RIGHTS RESERVED.
% VERSION     : 09.07.2007
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    параметры: DAT_   - звiтна дата
               sheme_ - код схеми формування
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
KODF_     VARCHAR2(2) := 'D9';
nbucGL_    NUMBER;
MFO_       VARCHAR2(12);

BEGIN
-------------------------------------------------------------------
DELETE FROM V_BANKS_REPORT91 WHERE DATF=DAT_ AND KODF=KODF_;
-------------------------------------------------------------------
MFO_:=F_OURMFO();

BEGIN
   SELECT to_number(trim(zzz)) INTO nbucGL_
   FROM KL_F00
   WHERE kodf=kodf_
     AND a017=sheme_;
EXCEPTION
          WHEN NO_DATA_FOUND THEN
   nbucGL_ := to_number(mfo_);
END;

insert into V_BANKS_REPORT91(NBUC, KODF, DATF, KODP, ZNAP)
SELECT nbucGL_, KODF, DATF, KODP, ZNAP
   FROM V_BANKS_REPORT
   WHERE DATF=DAT_    AND
         KODF=KODF_;
----------------------------------------
END P_FILED9;
/
show err;

PROMPT *** Create  grants  P_FILED9 ***
grant EXECUTE                                                                on P_FILED9        to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_FILED9.sql =========*** End *** 
PROMPT ===================================================================================== 
