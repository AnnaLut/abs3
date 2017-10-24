
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_nbur_ret_dig.sql =========*** Run
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_NBUR_RET_DIG (kv_ NUMBER, dat_ DATE DEFAULT NULL) RETURN NUMBER IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	Ooieoey aica?auaao eie-ai neiaieia iinea caiyoie
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     : 10.11.2004
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    ia?aiao?u: kv_ - eia aae?ou
			   Dat_ - io?aoiay aaoa
			   		(aiaaaeaia aey niaianoeiinoe n i?aauaoueie aa?neyie)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
   dig_ NUMBER:=100;
BEGIN
   BEGIN
      SELECT POWER(10,k.dig)
	  INTO dig_
      FROM tabval k
      WHERE k.kv=kv_;
   EXCEPTION WHEN NO_DATA_FOUND THEN
      NULL;
   END ;

   dig_ := dig_/100;

   RETURN dig_;
END;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_nbur_ret_dig.sql =========*** End
 PROMPT ===================================================================================== 
 