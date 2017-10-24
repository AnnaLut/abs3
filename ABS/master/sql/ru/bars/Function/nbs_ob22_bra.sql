
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/nbs_ob22_bra.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.NBS_OB22_BRA 
( nbs_  accounts.nbs%type,
  ob22_ accounts.ob22%type,
  p_branch branch.branch%type default sys_context('bars_context','user_branch')
  )

 return accounts.nls%type is

 p_bra accounts.branch%type;

begin

 If length(p_branch) = 8
     then  p_bra := p_branch||'000000/';
     else  p_bra := p_branch;
 end if;



 If NBS_ ='3800' then
    for k in (select a.nls from accounts a, vp_list v
              where a.ob22=OB22_ and a.nbs=NBS_  and a.dazs is null
                and a.branch=p_branch and v.acc3800 = a.acc order by a.daos )
    loop
       return k.NLS;
    end loop;
 else
    for k in (select a.nls from accounts a
              where a.ob22=OB22_ and a.nbs=NBS_  and a.dazs is null
                and a.branch=p_bra order by a.daos desc  )
    loop
       return k.NLS;
    end loop;
 end if;
 -----------------
 return '';

end nbs_ob22_bra;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/nbs_ob22_bra.sql =========*** End *
 PROMPT ===================================================================================== 
 