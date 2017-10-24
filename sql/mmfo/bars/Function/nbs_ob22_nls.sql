
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/nbs_ob22_nls.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.NBS_OB22_NLS 
( P_nbs   accounts.nbs%type,
  P_ob22  accounts.ob22%type,
  P_nlsA  accounts.NLS%type
)
  return accounts.nls%type is

/*  04-07-2012 nvv замінив nvl на case

    24-01-2011 Sta перевод ОБ22 в accounts
    Подбор счета по бранчу счета-корреспондента
*/

  l_nls     accounts.NLS%type  := null ;

begin
  begin
    select nbs_ob22_null ( P_nbs, P_ob22, a.Branch)
    into l_NLS
    from accounts a
    where a.dazs is null  and a.nls = p_NLSA  and rownum=1;
  EXCEPTION WHEN NO_DATA_FOUND THEN  null;
  end;

  Return ( case
                   when l_nls is null          then  nbs_ob22(P_nbs, P_ob22)
                     else   l_nls
                     end);



end nbs_ob22_nls ;
/
 show err;
 
PROMPT *** Create  grants  NBS_OB22_NLS ***
grant EXECUTE                                                                on NBS_OB22_NLS    to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on NBS_OB22_NLS    to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/nbs_ob22_nls.sql =========*** End *
 PROMPT ===================================================================================== 
 