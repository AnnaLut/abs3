

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_EDIT_PS_SPARAM.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_EDIT_PS_SPARAM ***

  CREATE OR REPLACE PROCEDURE BARS.P_EDIT_PS_SPARAM (P_FL     in number,
                                             P_NBS    in varchar2, 
                                             P_SPID   in number, 
                                             P_OPT    in varchar2:=null, 
                                             P_SQLVAL in varchar2:=null
                                             ) is
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Процедура дляредагування  розподілу спецпараметрів по БР
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
% VERSION     : 16/03/2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
параметри:
     P_FL        режим (1-insert, 2-update, 3-delete)
     P_NBS       балансовий рахунок
     P_SPID      ідентифікатор спецпараметру
     P_OPT       позначка обовязковості заповнення параметру
     P_SQLVAL    запит для формування набору даних для спецпараметра 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
begin
    if P_FL is not null then
       if P_FL = 1 then -- insert
          insert into PS_SPARAM(NBS, SPID, OPT, SQLVAL)
          values (P_NBS, P_SPID, P_OPT, P_SQLVAL);       
       elsif P_FL = 2 then -- update
          update PS_SPARAM
          set opt = P_OPT,
              sqlval = P_SQLVAL
          where nbs = P_NBS and
                spid = P_SPID;   
       elsif P_FL = 3 then -- delete
          delete 
          from PS_SPARAM     
          where nbs = P_NBS and
                spid = P_SPID;        
       end if;
       
       commit;
    end if;
end;
/
show err;

PROMPT *** Create  grants  P_EDIT_PS_SPARAM ***
grant EXECUTE                                                                on P_EDIT_PS_SPARAM to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_EDIT_PS_SPARAM.sql =========*** 
PROMPT ===================================================================================== 
