create or replace function f_tt_I00_chk(p_idchk  number,
                                        p_dk     number,  
                                        p_nlsa   varchar2,
                                        p_nlsb   varchar2,
                                        p_branch varchar2) return number
as
l_chk boolean := true;
l_branch  varchar2(30) := nvl(p_branch,SYS_CONTEXT ('bars_context', 'user_branch'));
begin

    if  l_branch  = '/300465/000041/' and p_idchk = 16  then return 0;
 elsif  l_branch  = '/300465/000041/' and p_idchk = 9   then return 1;
 elsif  l_branch != '/300465/000041/' and p_idchk = 9   then return 0;
 elsif  l_branch  = '/300465/000041/' and p_idchk = 5   then return 0;
    end if;

   -- для проводок Дт 2924 Кт 2902 або 6110   ставим візування своїх

    If p_dk = 1 and regexp_like(p_nlsa, '^2924')       and  regexp_like(p_nlsb, '^2902|^6110')  then l_chk := true;
 elsIf p_dk = 0 and regexp_like(p_nlsa, '^2902|^6110') and  regexp_like(p_nlsb, '^2924')        then l_chk := true;
                                                                                                else l_chk := false;     
    end if;
    
    case 
      when p_idchk = 5  then

          if  l_chk then return 1;
                    else return 0;
          end if; 
    
      when p_idchk = 16 then
    
          if  l_chk then return 0;
                    else return 1;
          end if; 
    
    else 
          return 1;                            
    end case;


end;
/

grant execute on f_tt_I00_chk to bars_access_defrole; 


 