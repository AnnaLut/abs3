

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_RESTORE_TABLDEL.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_RESTORE_TABLDEL ***

  CREATE OR REPLACE PROCEDURE BARS.P_RESTORE_TABLDEL (
  p_tabname varchar2,
  p_filter  varchar2) is
l_Deleted date;
begin
  if p_tabname is not null and p_filter is not null then
  begin
    execute immediate 'select deleted from ' || p_tabname || ' where ' || p_filter into l_Deleted;
  exception when no_data_found then
    execute immediate 'update ' || p_tabname || ' set deleted=null where ' || p_filter;
    if sql%rowcount = 0 then
      bars_error.raise_nerror('ADM', 'RECORD_NOT_FOUND');
    end if;
  end;
  end if;
end;
/
show err;

PROMPT *** Create  grants  P_RESTORE_TABLDEL ***
grant EXECUTE                                                                on P_RESTORE_TABLDEL to ABS_ADMIN;
grant EXECUTE                                                                on P_RESTORE_TABLDEL to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_RESTORE_TABLDEL to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_RESTORE_TABLDEL.sql =========***
PROMPT ===================================================================================== 
