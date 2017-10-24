

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_SET_DREC.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_SET_DREC ***

  CREATE OR REPLACE PROCEDURE BARS.P_SET_DREC (p_ref number, p_refold number, p_write_arcrrp number)
is
l_drec oper.d_rec%type;
l_string varchar2(120):='';
begin

select d_rec into l_drec from oper where ref=p_refold;

if p_write_arcrrp = 1 then
    select case when l_drec is null then '#' else '' end ||'C'||mfoa||','||nlsa||','||nam_a||'#' into l_string from arc_rrp where ref=p_refold;
end if;


update oper set d_rec=l_drec||l_string where ref=p_ref;
end;
/
show err;

PROMPT *** Create  grants  P_SET_DREC ***
grant EXECUTE                                                                on P_SET_DREC      to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_SET_DREC.sql =========*** End **
PROMPT ===================================================================================== 
