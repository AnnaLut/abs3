

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_SET_ACCSPECPARAM.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_SET_ACCSPECPARAM ***

  CREATE OR REPLACE PROCEDURE BARS.P_SET_ACCSPECPARAM (
  p_nbs   varchar2,
  p_code  varchar2,
  p_value varchar2 )
is
  l_count number;
begin

  for z in ( select acc, nls, kv from accounts
               where nbs = p_nbs
                 and dazs is null )
  loop

     select count(*) into l_count from specparam where acc = z.acc;

     if l_count = 0 then
        insert into specparam (acc) values (z.acc);
     end if;

     execute immediate '
     update specparam set ' || p_code || ' = ''' || p_value || '''
     where acc = ' || z.acc;

     bars_audit.info('CAC-SPEC. Счет ' || z.nls || '/' || z.kv ||
     ': обновление спецпараметра ' || p_code || '=>' || p_value || '.');

  end loop;

end;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_SET_ACCSPECPARAM.sql =========**
PROMPT ===================================================================================== 
