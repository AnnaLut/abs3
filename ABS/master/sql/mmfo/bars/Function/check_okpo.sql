
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/check_okpo.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.CHECK_OKPO (p_okpo varchar2)
return varchar2
is
x number :=0;
k varchar2(1);

begin
 if length(p_okpo)=10 and p_okpo not in('0000000000','9999999999') then
   for i in 1..9
   loop
    x:=x+to_number(substr(p_okpo,i,1))* case i
                              when 1 then -1
                              when 2 then 5
                              when 3 then 7
                              when 4 then 9
                              when 5 then 4
                              when 6 then 6
                              when 7 then 10
                              when 8 then 5
                              when 9 then 7
                              end;
   end loop;
   k:=case when  length(to_char(x-(11*trunc(x/11))))>1 then '0' else to_char(x-(11*trunc(x/11))) end;
 return substr(p_okpo,1,9)||k;
 elsif length(p_okpo)=8 then
  return v_okpo(p_okpo);
 else
  return p_okpo;
 end if;
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/check_okpo.sql =========*** End ***
 PROMPT ===================================================================================== 
 