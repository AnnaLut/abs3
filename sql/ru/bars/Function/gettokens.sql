
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/gettokens.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.GETTOKENS (p_tokenlist varchar2) return varchar2_list pipelined is
l_val varchar2(1000);
i     number;
/*
 * ф-ция отдает список последовательно значения для списка значений через запятую
 */
begin
   if p_tokenlist is null then return; end if;
   l_val:=p_tokenlist;
   i:=length(p_tokenlist);

   while i > 0 loop
      if instr(l_val,',')>0 then
         pipe row (substr(l_val,1,instr(l_val,',')-1)) ;
         l_val:=substr(l_val,instr(l_val,',')+1);
      else
         pipe row (l_val);
         i:=0;
   end if;
   end loop;
   return;
end;
/
 show err;
 
PROMPT *** Create  grants  GETTOKENS ***
grant EXECUTE                                                                on GETTOKENS       to BARSUPL;
grant EXECUTE                                                                on GETTOKENS       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on GETTOKENS       to BARS_SUP;
grant EXECUTE                                                                on GETTOKENS       to UPLD;
grant EXECUTE                                                                on GETTOKENS       to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/gettokens.sql =========*** End *** 
 PROMPT ===================================================================================== 
 