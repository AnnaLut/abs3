CREATE OR REPLACE PROCEDURE BARS.P_REZ_PAR_COR (p_par rez_par.par%type, p_val rez_par.val%type  ) IS
  l_min  number :=0;                                                                                
  l_max  number :=1; 
  l_val  number;
   -- валідація параметру LGD
begin    
   if p_par is not null and p_par='LGD'  THEN 

      l_val := CASE WHEN REGEXP_LIKE(p_val,'^[ |.|,|0-9]+$')
               THEN 0.00+REPLACE(REPLACE(p_val ,' ',''),',','.')
                           ELSE 999 END;
      if l_val = 999 or l_val < l_min or l_val > l_max THEN
         raise_application_error(-(20001),'\      Не вірно значення параметру LGD - ' || p_val || '. Допустиме значення від '||l_min||' до '||l_max ,TRUE);
      end if;
      update rez_par set val = to_char(l_val,'0.00000') where par='LGD';
   end if;
end;
/

/
show err;

grant EXECUTE   on P_REZ_PAR_COR  to BARS_ACCESS_DEFROLE;
grant EXECUTE   on P_REZ_PAR_COR  to RCC_DEAL;
grant EXECUTE   on P_REZ_PAR_COR  to START1;

 
