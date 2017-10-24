

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_KONS_T91.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_KONS_T91 ***

  CREATE OR REPLACE PROCEDURE BARS.P_KONS_T91 (Dat_ DATE, kodf_ VARCHAR2, sheme_ VARCHAR2 DEFAULT 'G')  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	Процедура спец. консолідації
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     : 26.08.2009 (09.07.2006)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    параметри: Dat_ - звітна дата
               kodf_ - код звіту
               sheme_ - схема формування 

26.08.2009 - добавлена спецконсолидация файла #1A
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
pr_tobo_ KL_F00.PR_TOBO%TYPE;

BEGIN
   BEGIN
      SELECT pr_tobo INTO pr_tobo_
      FROM KL_F00
      WHERE kodf=kodf_
        AND a017=sheme_;
   EXCEPTION
             WHEN NO_DATA_FOUND THEN
      pr_tobo_ :=  -1;
   END;

   IF kodf_ = '42' THEN
      P_File42(Dat_, sheme_);
   ELSIF kodf_ = '71' THEN
      P_File71(Dat_, sheme_);
   ELSIF kodf_ = '91' THEN
      P_File91(Dat_, sheme_);
   ELSIF kodf_ = 'C6' THEN
      P_Filec6(Dat_);
   ELSIF kodf_ = 'D8' THEN
      P_FileD8(Dat_, sheme_);
   ELSIF kodf_ = 'D9' THEN
      P_FileD9(Dat_, sheme_);
   ELSIF kodf_ = '1A' THEN
      P_File1A(Dat_, sheme_);
   -- консолідація для банку в цілому
   ELSIF NVL(pr_tobo_, -1) = 0 THEN
      P_Kons_Whole(Dat_, kodf_, sheme_);
   ELSE
--     DELETE
-- 	   FROM V_BANKS_REPORT91
-- 	   WHERE datf=Dat_ AND kodf=kodf_;
	   NULL;
   END IF;
END;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_KONS_T91.sql =========*** End **
PROMPT ===================================================================================== 
