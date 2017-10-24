

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_FILE1A.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_FILE1A ***

  CREATE OR REPLACE PROCEDURE BARS.P_FILE1A (Dat_ DATE, sheme_ VARCHAR2 DEFAULT 'G') IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	Процедура спец. консолiдацiї файлу 1A
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 2009.  All Rights Reserved.
% VERSION     : 26.08.2009
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    параметри: Dat_   - звiтна дата
               sheme_ - код схеми формування
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
kodf_     varchar2(2) := '1A';

file_id_  Number;
file_id1_ Number;
nbuc_     Number;
nbuc1_    Number;
kodp1_    Varchar2(35);
znap1_    Varchar2(70);
datf1_    Date;
kodf1_    Varchar2(2);
Oste_     Number;
f91_      Number;
kol_      Number;
na_       Number;
nn_       Varchar2(2);
kodp_     Varchar2(16);
znap_     Varchar2(70);
nbucGL_   Number;
mfo_       VARCHAR2(12);

CURSOR SALDO IS
   SELECT file_id,
          datf,
	  substr(kodp,1,14),
	  nbuc,
      SUM(TO_NUMBER(znap))
   FROM v_banks_report
   WHERE datf=Dat_                          AND
         kodf=kodf_                         AND
         substr(kodp,6,3) in ('270')
   GROUP BY file_id, datf, substr(kodp,1,14), nbuc;

CURSOR SALDO1 IS
   SELECT file_id,
          datf,
	  kodp,
	  nbuc,
          znap
   FROM v_banks_report
   WHERE datf=Dat_                          AND
         kodf=kodf_                         AND
         substr(kodp,6,3) not in ('270');

BEGIN
-------------------------------------------------------------------
DELETE FROM V_BANKS_REPORT91 where datf=Dat_ and kodf=kodf_;
-------------------------------------------------------------------
   mfo_:=F_OURMFO();

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
         FETCH SALDO INTO file_id_, datf1_, kodp1_, nbuc_, Oste_ ;
         EXIT WHEN SALDO%NOTFOUND;

         IF Oste_<>0 THEN
            kodp1_:=kodp1_ || '0';
            znap1_ := to_char(Oste_);

            INSERT INTO v_banks_report91 (nbuc, kodf, datf, kodp, znap)
                       VALUES (nbuc_, kodf_, datf1_, kodp1_, znap1_);

         END IF;

      END LOOP;
   CLOSE SALDO;

   OPEN SALDO1;
      LOOP
         FETCH SALDO1 INTO file_id_, datf1_, kodp1_, nbuc_, Oste_ ;
         EXIT WHEN SALDO1%NOTFOUND;

         IF Oste_<>0 THEN
            znap1_ := to_char(Oste_);

            INSERT INTO v_banks_report91 (nbuc, kodf, datf, kodp, znap)
                       VALUES (nbuc_, kodf_, datf1_, kodp1_, znap1_);

         END IF;

      END LOOP;
   CLOSE SALDO1;


----------------------------------------
END p_file1A;
/
show err;

PROMPT *** Create  grants  P_FILE1A ***
grant EXECUTE                                                                on P_FILE1A        to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_FILE1A.sql =========*** End *** 
PROMPT ===================================================================================== 
