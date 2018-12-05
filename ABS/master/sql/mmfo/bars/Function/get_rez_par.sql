 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/GET_REZ_PAR.sql =========*** Run
 PROMPT ===================================================================================== 

CREATE OR REPLACE function BARS.GET_REZ_PAR( p_par varchar2 )   return varchar2 is
  l_ret  rez_par.par%type;
begin

  begin
     select val into l_ret from rez_par  where par = p_par;
  exception  when no_data_found then  l_ret := null;
  end;
  return l_ret;
end;
/

 show err;
 
PROMPT *** Create  grants  GET_REZ_PAR ***
grant EXECUTE                                                                on GET_REZ_PAR  to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on GET_REZ_PAR  to START1;

 

