

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_FILE91.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_FILE91 ***

  CREATE OR REPLACE PROCEDURE BARS.P_FILE91 (Dat_ DATE, sheme_ VARCHAR2 DEFAULT 'G') IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	Процедура спец. консолiдацiї файлу 91
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     : 10.10.2006
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    параметри: Dat_   - звiтна дата
               sheme_ - код схеми формування
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
kodf_     varchar2(2) := '91';

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
kodp_     Varchar2(12);
znap_     Varchar2(70);
nbucGL_   Number;
mfo_       VARCHAR2(12);

CURSOR SALDO IS
   SELECT file_id,
	  substr(kodp,3,2),
	  nbuc,
      SUM(TO_NUMBER(znap))
   FROM v_banks_report
   WHERE datf=Dat_                          AND
         kodf=kodf_                         AND
         substr(kodp,1,2) in ('10','20')
   GROUP BY file_id, substr(kodp,3,2), nbuc
   ORDER BY 4 DESC ;

CURSOR SALDO1 IS
   SELECT  nbuc, kodf, datf, kodp, substr(znap,1,70), file_id
   FROM v_banks_report
   WHERE file_id=file_id_             AND
         nbuc=nbuc_                   AND
         datf=Dat_                    AND
         substr(kodp,3,2)=nn_         AND
         kodf=kodf_ ;

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

   na_:=1 ;

   OPEN SALDO;
      LOOP
         FETCH SALDO INTO file_id_, nn_, nbuc_, Oste_ ;
         EXIT WHEN SALDO%NOTFOUND;

         kol_:=0;

         IF na_ < 21 THEN
            OPEN SALDO1;
               LOOP
                  FETCH SALDO1 INTO nbuc1_, kodf1_, datf1_, kodp1_, znap1_, file_id1_ ;
                  EXIT WHEN SALDO1%NOTFOUND;

                  IF Oste_<>0 THEN
                     kodp_:=substr(kodp1_,1,2) || substr(to_char(100+na_),2,2) ||
                            substr(kodp1_,5,8);

                     INSERT INTO v_banks_report91 (nbuc, kodf, datf, kodp, znap)
                               VALUES (nbucGL_, kodf1_, datf1_, kodp_, znap1_);

                     kol_:=1;
                  END IF;

               END LOOP;
            CLOSE SALDO1;
         END IF;

         IF kol_<>0 THEN
            na_:= na_+1 ;
         END IF;
      END LOOP;
   CLOSE SALDO;
----------------------------------------
END p_file91;
/
show err;

PROMPT *** Create  grants  P_FILE91 ***
grant EXECUTE                                                                on P_FILE91        to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_FILE91.sql =========*** End *** 
PROMPT ===================================================================================== 
