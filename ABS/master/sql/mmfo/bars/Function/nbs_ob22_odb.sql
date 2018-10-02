
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/nbs_ob22_odb.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.NBS_OB22_ODB 
 (nbs_  accounts.nbs%type,
  ob22_ accounts.ob22%type,
  p_branch branch.branch%type default sys_context('bars_context','user_branch')
  )
  return accounts.nls%type
   is
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

      for k in (select a.nls from accounts a
                where a.ob22=OB22_ and a.nbs=NBS_  and a.dazs is null
                  and a.branch=Branch_ and a.TIP = 'ODB' order by a.daos desc  )
      loop
         return k.NLS;
      end loop;

   If length(Branch_) <=8 then  return NLS_; end if;
 end loop;
 -----------------
 return NLS_;
end nbs_ob22_ODB;
/
 show err;
 
PROMPT *** Create  grants  NBS_OB22_ODB ***
grant EXECUTE                                                                on NBS_OB22_ODB    to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/nbs_ob22_odb.sql =========*** End *
 PROMPT ===================================================================================== 
 