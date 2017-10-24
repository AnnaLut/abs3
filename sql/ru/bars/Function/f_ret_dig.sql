
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_ret_dig.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_RET_DIG (kv_ NUMBER, dat_ DATE DEFAULT NULL) RETURN NUMBER IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	Функция возвращает кол-во символов после запятой
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     : 10.11.2004
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    параметры: kv_ - код валюты
			   Dat_ - отчетная дата
			   		(добавлена для совместимости с предыдущими версиями)
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
 
PROMPT *** Create  grants  F_RET_DIG ***
grant EXECUTE                                                                on F_RET_DIG       to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_ret_dig.sql =========*** End *** 
 PROMPT ===================================================================================== 
 