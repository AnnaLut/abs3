

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_FILEC6.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_FILEC6 ***

  CREATE OR REPLACE PROCEDURE BARS.P_FILEC6 (Dat_ DATE )  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	Процедура консолидации по типу "Спецобработка #91"
%  			  	для файла C6
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     : 20.04.2005
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    параметры: Dat_ - отчетная дата
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
kodf_     varchar2(2) := 'C6';
file_id_   Number;
file_id1_  Number;
nbuc_      Number;
na1_       Number;
na2_       Number;
na3_       Number;
dd_        Varchar2(2);
kv_        Varchar2(3);
nn_        Varchar2(4);
kodp_      Varchar2(12);
znap_      Varchar2(70);

-- Всi записи
CURSOR SALDO IS
   SELECT file_id,
   	  kodp,
	  nbuc, znap
   FROM v_banks_report
   WHERE datf=Dat_    AND
         kodf=kodf_
   ORDER BY file_id,substr(kodp,3,4),substr(kodp,1,2),substr(kodp,7,3) ;

BEGIN
-------------------------------------------------------------------
DELETE FROM V_BANKS_REPORT91 where datf=Dat_ and kodf=kodf_;
-------------------------------------------------------------------
na1_:=0 ;
na2_:=0 ;
file_id1_:=-1;

OPEN SALDO;
LOOP
   FETCH SALDO INTO file_id_,kodp_, nbuc_, znap_ ;
   EXIT WHEN SALDO%NOTFOUND;

   IF file_id_=0 THEN
      na1_:=substr(kodp_,3,4);
      insert into V_BANKS_REPORT91  (nbuc, kodf, datf, kodp, znap)
      values (nbuc_, kodf_, dat_, kodp_, znap_);
   END IF;

   IF file_id_<>0 THEN
      na3_:=substr(kodp_,3,4);
      IF na2_<>na3_ THEN
         na2_:=na3_;
         na1_:=na1_+1;
      END IF;
      dd_:=substr(kodp_,1,2);
      kv_:=substr(kodp_,7,3);
      insert into V_BANKS_REPORT91  (nbuc, kodf, datf, kodp, znap)
      values (nbuc_, kodf_, dat_, dd_||substr('0000'||to_char(na1_),-4)||kv_, znap_);
   END IF;

END LOOP;
CLOSE SALDO;
------------------------------------------------------------
END p_fileC6;
/
show err;

PROMPT *** Create  grants  P_FILEC6 ***
grant EXECUTE                                                                on P_FILEC6        to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_FILEC6.sql =========*** End *** 
PROMPT ===================================================================================== 
