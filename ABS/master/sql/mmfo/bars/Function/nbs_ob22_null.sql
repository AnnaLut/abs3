
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/nbs_ob22_null.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.NBS_OB22_NULL 
 (nbs_  accounts.nbs%type,
  ob22_ accounts.ob22%type,
  p_branch branch.branch%type default sys_context('bars_context','user_branch')
  )
  return accounts.nls%type


is

/*
   24-01-2011 Sta перевод ОБ22 в accounts
   15-09-2009 STA  Поиск счета до самого высокого уровня (+ 2 этажа)
   24-04-2009 Sta  Особенности юзеров уровня МФО
   23-04-2009 Sta  Особенности вал.поз
   27-01-2009 Sta  счет в тек или вышестоящем бранче по БС+ОБ22
  найти самый новый незакр.счет в бранче по БС+ОБ22
*/


 NLS_    accounts.NLS%type := null ;
 Branch_ Branch.Branch%type := p_branch;
 Lng_    int;

begin

 if length(branch_) = 8 then
    branch_:= branch_||'000000/';
 end if;

 Lng_    := length(Branch_);

 FOR i in (select dk I from dk order by 1)
 
 loop
   Branch_ := substr(Branch_, 1, Lng_ - i.I*7);
   If NBS_ ='3800' then
      for k in (select a.nls from accounts a, vp_list v
                where a.ob22=OB22_ and a.nbs=NBS_  and a.dazs is null
                  and a.branch=Branch_ and v.acc3800 = a.acc order by a.daos )
      loop
         return k.NLS;
      end loop;
   else
      for k in (select a.nls from accounts a
                where a.ob22=OB22_ and a.nbs=NBS_  and a.dazs is null
                  and a.branch=Branch_ order by a.daos desc  )
      loop
         return k.NLS;
      end loop;
   end if;
   If length(Branch_) <=8 then  return NLS_; end if;
 end loop;
 -----------------
 return NLS_;
end nbs_ob22_null;
/
 show err;
 
PROMPT *** Create  grants  NBS_OB22_NULL ***
grant EXECUTE                                                                on NBS_OB22_NULL   to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on NBS_OB22_NULL   to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/nbs_ob22_null.sql =========*** End 
 PROMPT ===================================================================================== 
 