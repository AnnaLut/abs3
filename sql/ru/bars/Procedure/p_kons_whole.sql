CREATE OR REPLACE PROCEDURE BARS."P_KONS_WHOLE" (Dat_ DATE, kodf_ VARCHAR2, sheme_ VARCHAR2 DEFAULT 'G' )  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	Процедура спец. консолідації по банку в цілому (без розрізів)
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     : 10.10.2006
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    параметри: Dat_ - звітна дата
               kodf_ - код звіту
               sheme_ - схема формування 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
nbuc_      NUMBER;

BEGIN
-------------------------------------------------------------------
DELETE FROM V_BANKS_REPORT91 WHERE datf=Dat_ AND kodf=kodf_;
-------------------------------------------------------------------
   BEGIN
      SELECT ZZZ INTO nbuc_
      FROM KL_F00
      WHERE kodf=kodf_
        AND a017=sheme_;
   EXCEPTION
             WHEN NO_DATA_FOUND THEN
      BEGIN
         SELECT ZZZ INTO nbuc_
         FROM KL_F00
         WHERE kodf=kodf_
           AND ROWNUM=1;
      EXCEPTION
                WHEN NO_DATA_FOUND THEN
         nbuc_ := 0;
      END;
   END;

   INSERT INTO V_BANKS_REPORT91  (nbuc, kodf, datf, kodp, znap)
   SELECT nbuc_, kodf, dat_, kodp, to_char(SUM(TO_NUMBER(Trim(znap))))
   FROM v_banks_report
   WHERE datf=Dat_
     AND kodf=kodf_
   GROUP BY nbuc_, kodf, dat_, kodp;
EXCEPTION
          WHEN OTHERS THEN
   RAISE_APPLICATION_ERROR(-20001, 'Error in P_Kons_Whole: '|| SQLERRM);
------------------------------------------------------------
END P_Kons_Whole;
/

begin
    execute immediate 'DROP PUBLIC SYNONYM p_kons_whole';
exception
    when others then null;
end;
/    

create public synonym p_kons_whole for bars.p_kons_whole;
grant execute on p_kons_whole to rpbn002;
/

