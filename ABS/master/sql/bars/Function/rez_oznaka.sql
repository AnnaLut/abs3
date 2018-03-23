CREATE OR REPLACE FUNCTION BARS.rez_oznaka(p_kol26 varchar2,p_mode number) RETURN varchar2 is

l_kol26  rez_cr.kol26%type;

begin
   if p_mode = 1 THEN 
      begin
         select ConcatStr(a.kod)   into l_kol26
         from  (select  '164216520' kod from dual where instr(p_kol26,'164216520')>0 union all 
                select  '164216560' kod from dual where instr(p_kol26,'164216560')>0 union all
                select  '164216580' kod from dual where instr(p_kol26,'164216580')>0 union all 
                select  '164216590' kod from dual where instr(p_kol26,'164216590')>0 union all 
                select  '164216510' kod from dual where instr(p_kol26,'164216510')>0 union all 
                select  '164216511' kod from dual where instr(p_kol26,'164216511')>0 union all
                select  '164216512' kod from dual where instr(p_kol26,'164216512')>0 union all 
                select  '164216513' kod from dual where instr(p_kol26,'164216513')>0 union all 
                select  '164216516' kod from dual where instr(p_kol26,'164216516')>0 union all 
                select  '164216518' kod from dual where instr(p_kol26,'164216518')>0 union all 
                select  '164216519' kod from dual where instr(p_kol26,'164216519')>0 union all
                select  '164216520' kod from dual where instr(p_kol26,'164216520')>0 union all 
                select  '164216521' kod from dual where instr(p_kol26,'164216521')>0 
                 ) a;
      EXCEPTION WHEN OTHERS THEN l_kol26 := null;  
      end;
   elsif p_mode =2 THEN
      begin
         select ConcatStr(a.kod)  into l_kol26
         from  (select  '164216601' kod from dual where instr(p_kol26,'164216601')>0 union all 
                select  '164216602' kod from dual where instr(p_kol26,'164216602')>0 union all
                select  '164216603' kod from dual where instr(p_kol26,'164216603')>0 union all 
                select  '164216604' kod from dual where instr(p_kol26,'164216604')>0 union all 
                select  '164216605' kod from dual where instr(p_kol26,'164216605')>0 union all 
                select  '164216606' kod from dual where instr(p_kol26,'164216606')>0 union all
                select  '164216607' kod from dual where instr(p_kol26,'164216607')>0 union all 
                select  '164216608' kod from dual where instr(p_kol26,'164216608')>0 union all 
                select  '164216609' kod from dual where instr(p_kol26,'164216609')>0 
                 ) a;
      EXCEPTION WHEN OTHERS THEN l_kol26 := null;  
      end;
   else 
      begin
         select ConcatStr(a.kod)   into l_kol26
         from  (select  '164216501' kod from dual where instr(p_kol26,'164216501')>0 union all 
                select  '164216530' kod from dual where instr(p_kol26,'164216530')>0 union all
                select  '164216530' kod from dual where instr(p_kol26,'164216540')>0 union all 
                select  '164216550' kod from dual where instr(p_kol26,'164216550')>0 union all 
                select  '164216570' kod from dual where instr(p_kol26,'164216570')>0 union all 
                select  '164216514' kod from dual where instr(p_kol26,'164216514')>0 union all
                select  '164216515' kod from dual where instr(p_kol26,'164216515')>0 union all 
                select  '164216516' kod from dual where instr(p_kol26,'164216517')>0 
                 ) a;
      EXCEPTION WHEN OTHERS THEN l_kol26 := null;  
      end;
   end if;
   return(l_kol26);
end;
/
 show err;
 
grant EXECUTE  on rez_oznaka   to BARS_ACCESS_DEFROLE;
grant EXECUTE  on rez_oznaka   to START1;

