
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_nbur_ret_div.sql =========*** Run
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_NBUR_RET_DIV (kv_ NUMBER, dat_ DATE DEFAULT NULL) RETURN NUMBER IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	Ooieoey aica?auaao eie-ai neiaieia iinea caiyoie
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     : 15/07/2016
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    ia?aiao?u: kv_ - eia aae?ou
			   Dat_ - io?aoiay aaoa
			   		(aiaaaeaia aey niaianoeiinoe n i?aauaoueie aa?neyie)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
   div_ NUMBER:=100;
BEGIN
   BEGIN
      SELECT NOMINAL
	  INTO div_
      FROM tabval k
      WHERE k.kv=kv_;
   EXCEPTION WHEN NO_DATA_FOUND THEN
      NULL;
   END ;

   RETURN div_;
END;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_nbur_ret_div.sql =========*** End
 PROMPT ===================================================================================== 
 