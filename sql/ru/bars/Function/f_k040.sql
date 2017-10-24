
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_k040.sql =========*** Run *** ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_K040 (p_kod_lit in varchar2) return varchar2 result_cache is
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :    По літерному коду країни отримуємо К040
% COPYRIGHT   :    Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
% VERSION     :    03/02/2015
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
*/
  l_K040 varchar2(3) := '804';
begin
   begin
      select k040
      into l_k040
      from kl_k040
      where upper(kod_lit) = upper(p_kod_lit) and
            d_close is null and
            rownum = 1;
   EXCEPTION WHEN NO_DATA_FOUND
      THEN  l_K040 := '804';
   end;

   RETURN l_K040;
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_k040.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 