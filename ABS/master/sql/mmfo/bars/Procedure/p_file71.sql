

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_FILE71.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_FILE71 ***

  CREATE OR REPLACE PROCEDURE BARS.P_FILE71 (DAT_ DATE, sheme_ VARCHAR2 DEFAULT 'G') IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	Процедура консолидации по типу "Спецобработка #91"
%  			  	для файла 71
% COPYRIGHT   :	COPYRIGHT UNITY-BARS LIMITED, 1999.  ALL RIGHTS RESERVED.
% VERSION     : 10.10.2006
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    параметры: DAT_   - звiтна дата
               sheme_ - код схеми формування
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
KODF_     VARCHAR2(2) := '71';

LAST_	   NUMBER:=0;

FILE_ID_   NUMBER;
FILE_NAME_  VARCHAR2(100);

NBUC_      NUMBER;

KODP_      VARCHAR2(35);
N_KODP_    VARCHAR2(35);
ZNAP_      VARCHAR2(128);

MFO_       VARCHAR2(12);

P_NNN_	   NUMBER := 0;
NNN_	   NUMBER := 0;
nbucGL_    NUMBER;

-- Залишки
CURSOR SALDO IS
   SELECT FILE_ID, FILE_NAME,
   		  KODP, ZNAP
   FROM V_BANKS_REPORT
   WHERE DATF=DAT_    AND
         KODF=KODF_   AND
		 KODP IS NOT NULL
   ORDER BY SUBSTR(KODP,4,10), SUBSTR(KODP,14,4), SUBSTR(KODP,1,3),
   		 	SUBSTR(KODP,18,4), SUBSTR(KODP,22,3);

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

OPEN SALDO;
LOOP
   FETCH SALDO INTO FILE_ID_, FILE_NAME_, KODP_, ZNAP_ ;
   EXIT WHEN SALDO%NOTFOUND;

   NNN_ := TO_NUMBER(SUBSTR(KODP_,14,4));

   IF NNN_=0 THEN
   	  N_KODP_ := KODP_;
	  IF FILE_ID_ = 0 THEN
		  N_KODP_ := SUBSTR(KODP_,1,3)||SUBSTR(KODP_,4,10)||
		  		  	 LPAD(TO_CHAR(NNN_),4,'0')||SUBSTR(KODP_,18,4)||SUBSTR(KODP_,22,3);
	  ELSE
		  N_KODP_ := SUBSTR(KODP_,1,3)||SUBSTR(FILE_NAME_,4,3)||SUBSTR(KODP_,7,7)||
		  		  	 LPAD(TO_CHAR(NNN_),4,'0')||SUBSTR(KODP_,18,4)||SUBSTR(KODP_,22,3);
	  END IF;
   ELSE
   	  IF P_NNN_ <> NNN_ THEN
	  	 LAST_:=LAST_+1;
	  END IF;

	  IF FILE_ID_ = 0 THEN
		  N_KODP_ := SUBSTR(KODP_,1,3)||SUBSTR(KODP_,4,10)||
		  		  	 LPAD(TO_CHAR(LAST_),4,'0')||SUBSTR(KODP_,18,4)||SUBSTR(KODP_,22,3);
	  ELSE
		  N_KODP_ := SUBSTR(KODP_,1,3)||SUBSTR(FILE_NAME_,4,3)||SUBSTR(KODP_,7,7)||
		  		  	 LPAD(TO_CHAR(LAST_),4,'0')||SUBSTR(KODP_,18,4)||SUBSTR(KODP_,22,3);
	  END IF;
   END IF;

   INSERT INTO V_BANKS_REPORT91  (NBUC, KODF, DATF, KODP, ZNAP)
   VALUES (nbucGL_, KODF_, DAT_, N_KODP_, ZNAP_);

   P_NNN_ := NNN_;
END LOOP;
CLOSE SALDO;
----------------------------------------
END P_FILE71;
/
show err;

PROMPT *** Create  grants  P_FILE71 ***
grant EXECUTE                                                                on P_FILE71        to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_FILE71.sql =========*** End *** 
PROMPT ===================================================================================== 
