
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_neruxomi.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_NERUXOMI 
(nbs_   accounts.nbs%type,
 ob22_  accounts.ob22%type,
 p_branch branch.branch%type default sys_context('bars_context','user_branch')
 )
  return accounts.nls%type is

/*
   24-01-2011 Sta перевод ОБ22 в accounts
   счет в тек или вышестоящем бранче по БС+ОБ22 по нерухомим

*/

 NLS_    accounts.NLS%type := null ;
 Branch_ Branch.Branch%type := p_branch;
 Lng_    int;
begin
 Lng_    := length(Branch_);
 for k in (select nls from MV_neruxomi
           where ob22=OB22_ and nbs=NBS_ and branch=Branch_)
 loop
    return k.NLS;
 end loop;
 -----------------
 If Lng_>14 then
    -- 2) счет в вышестоящем бранче по БС+ОБ22
    Branch_ := Substr(branch_,1,Lng_  -7);
    for k in (select nls from MV_neruxomi
              where ob22=OB22_ and nbs=NBS_  and branch=Branch_ )
    loop
       return k.NLS;
    end loop;
 end if;
 -------------------
 return NLS_;

end F_neruxomi;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_neruxomi.sql =========*** End ***
 PROMPT ===================================================================================== 
 