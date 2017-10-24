

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/CP_DEACTIVE.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  procedure CP_DEACTIVE ***

  CREATE OR REPLACE PROCEDURE BARS.CP_DEACTIVE (p_ref int, p_tt varchar2) IS
-- ver 1.4 â_ä 23/02-16    -- 18/12-14
l_id int;
begin
  if p_tt in ('FX7','FX8') then
  for k in (select ref, id from cp_deal
            where ref=p_ref)
  loop
  l_id:=k.id;
  update cp_deal set active=-2  where ref=k.ref and active in (1);
  logger.info('CP_DEACTIVE: BAK ref='||p_ref||' ID='||l_id);
  end loop;
  else
  null;
  --logger.info('CP_DEACTIVE: ref='||p_ref||' tt='||p_tt||' NO');
  end if;
end;
/
show err;

PROMPT *** Create  grants  CP_DEACTIVE ***
grant EXECUTE                                                                on CP_DEACTIVE     to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/CP_DEACTIVE.sql =========*** End *
PROMPT ===================================================================================== 
