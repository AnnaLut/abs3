
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/check_destruct_passp.sql =========*
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.CHECK_DESTRUCT_PASSP (p_ser varchar2, p_num varchar2) return number
is
  l_cnt number := null;
begin
  begin
     select count(*) into l_cnt
       from destruct_passp
     where trim(ser) = trim(p_ser)
       and trim(num) = trim(p_num);
  exception when no_data_found then
    l_cnt := 0;
  end;

  if l_cnt > 0 then
    return 1;
  elsif l_cnt = 0 then
    return 0;
  end if;
end check_destruct_passp;
/
 show err;
 
PROMPT *** Create  grants  CHECK_DESTRUCT_PASSP ***
grant EXECUTE                                                                on CHECK_DESTRUCT_PASSP to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on CHECK_DESTRUCT_PASSP to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/check_destruct_passp.sql =========*
 PROMPT ===================================================================================== 
 