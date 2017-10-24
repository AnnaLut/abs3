

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_FILED8.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_FILED8 ***

  CREATE OR REPLACE PROCEDURE BARS.P_FILED8 (DAT_ DATE, sheme_ VARCHAR2 DEFAULT 'G') IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	Процедура консолидации по типу "Спецобработка #91"
%  			  	для файла D8
% COPYRIGHT   :	COPYRIGHT UNITY-BARS LIMITED, 1999.  ALL RIGHTS RESERVED.
% VERSION     : 27.02.2007
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    параметры: DAT_   - звiтна дата
               sheme_ - код схеми формування
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
KODF_     VARCHAR2(2) := 'D8';

LAST_	   NUMBER:=0;

FILE_ID_   NUMBER;
P_FILE_ID_ NUMBER;

NBUC_      NUMBER;

KODP_      VARCHAR2(35);
N_KODP_    VARCHAR2(35);
ZNAP_      VARCHAR2(128);

MFO_       VARCHAR2(12);

P_NNN_	   NUMBER := 0;
NNN_	   NUMBER := 0;
nbucGL_    NUMBER;

okpo_	   VARCHAR2(10);
p_okpo_	   VARCHAR2(10);

ddd_	   VARCHAR2(3);

-- Залишки
CURSOR SALDO IS
   SELECT FILE_ID,
   		  KODP, ZNAP
   FROM V_BANKS_REPORT
   WHERE DATF=DAT_    AND
         KODF=KODF_   AND
		 KODP IS NOT NULL
   ORDER BY SUBSTR(KODP,4,10), FILE_ID, SUBSTR(KODP,14,4), SUBSTR(KODP,1,3),
   		 	SUBSTR(KODP,18,4), SUBSTR(KODP,22,3);

BEGIN
-------------------------------------------------------------------
DELETE FROM V_BANKS_REPORT91 WHERE DATF=DAT_ AND KODF=KODF_;
DELETE FROM OTCN_F71_KONS_TEMP;
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

insert into OTCN_F71_KONS_TEMP
SELECT SUBSTR(KODP,4,10), sum(to_number(nvl(trim(ZNAP),'0'))) ZNAP
   FROM V_BANKS_REPORT
   WHERE DATF=DAT_    AND
         KODF=KODF_   AND
		 KODP IS NOT NULL and
		 kodp like '040%'
group by SUBSTR(KODP,4,10);

OPEN SALDO;
LOOP
   FETCH SALDO INTO FILE_ID_, KODP_, ZNAP_ ;
   EXIT WHEN SALDO%NOTFOUND;

   NNN_ := TO_NUMBER(SUBSTR(KODP_,14,4));
   okpo_ := SUBSTR(KODP_,4,10);
   ddd_ := SUBSTR(KODP_,1,3);

   IF NNN_=0 THEN
      N_KODP_ := KODP_;

      N_KODP_ := SUBSTR(KODP_,1,3)||SUBSTR(KODP_,4,10)||
                    LPAD(TO_CHAR(NNN_),4,'0')||SUBSTR(KODP_,18,4)||SUBSTR(KODP_,22,3);
   ELSE
      IF P_NNN_ <> NNN_ or
	  	 (p_okpo_ = okpo_ and
   	  	  P_FILE_ID_ <> FILE_ID_)
	  THEN
         LAST_:=LAST_+1;
      END IF;

      N_KODP_ := SUBSTR(KODP_,1,3)||SUBSTR(KODP_,4,10)||
                    LPAD(TO_CHAR(LAST_),4,'0')||SUBSTR(KODP_,18,4)||SUBSTR(KODP_,22,3);
   END IF;

   if p_okpo_ = okpo_ and
   	  P_FILE_ID_ <> FILE_ID_ and
	  --nnn_ <> 0 and
	  SUBSTR(KODP_,1,3) in ('010', '020', '025', '040', '050', '055', '060') then
	  null;
   else
   	   if ddd_ = '040' then
	   	   SELECT p040
		   into ZNAP_
		   FROM OTCN_F71_KONS_TEMP
		   WHERE okpo=okpo_;
	   end if;

	   INSERT INTO V_BANKS_REPORT91  (NBUC, KODF, DATF, KODP, ZNAP)
	   VALUES (nbucGL_, KODF_, DAT_, N_KODP_, ZNAP_);

	   P_NNN_ := NNN_;
	   p_okpo_ := okpo_;
	   P_FILE_ID_ := FILE_ID_;
   end if;
END LOOP;
CLOSE SALDO;
----------------------------------------
END P_FILED8;
/
show err;

PROMPT *** Create  grants  P_FILED8 ***
grant EXECUTE                                                                on P_FILED8        to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_FILED8.sql =========*** End *** 
PROMPT ===================================================================================== 
