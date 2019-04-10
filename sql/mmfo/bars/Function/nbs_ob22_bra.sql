
 
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

--logger.info('CCK: nbs_ob22_bra: nbs = '||nbs_||' ,ob22 ='||ob22_||' ,branch ='||p_branch);

 If NBS_ ='3800' then
    for k in (select a.nls from accounts a, vp_list v
              where a.ob22=OB22_ and a.nbs=NBS_  and a.dazs is null
                and a.branch=p_branch and v.acc3800 = a.acc order by a.daos )
    loop
       return k.NLS;
    end loop;
 elsif NBS_ ='8006' then --COBUMMFO-8982
    for k in (select a.nls from accounts a
              where a.ob22 is null and a.nbs=NBS_  and a.dazs is null
                and a.branch=p_branch --p_bra ???
								order by a.daos )
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
 
exception
	  when no_data_found then 
         bars_audit.error('nbs_ob22_bra. '||'Не вдалося знайти nls для nbs = '||nbs_||' ,ob22 ='||ob22_||' ,branch ='
				 ||p_branch||chr(10)||sqlerrm||chr(10) || dbms_utility.format_error_stack());
	  return '';
    when others then
         bars_audit.error('nbs_ob22_bra. '||'Помилка в nbs_ob22_bra. nbs = '||nbs_||' ,ob22 ='||ob22_||' ,branch ='
				 ||p_branch||chr(10)||sqlerrm||chr(10) || dbms_utility.format_error_stack());
	  return '';
end nbs_ob22_bra;
/
 show err;
 
PROMPT *** Create  grants  NBS_OB22_BRA ***
grant EXECUTE                                                                on NBS_OB22_BRA    to BARS_ACCESS_USER;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/nbs_ob22_bra.sql =========*** End *
 PROMPT ===================================================================================== 
 