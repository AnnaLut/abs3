
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_getc.sql =========*** Run *** ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_GETC (p_kodz number, p_pos number, p_len number)
return varchar2 is
  l_txt varchar2(4000);
begin
  l_txt := null;
  begin
    select dbms_lob.substr(txt,p_len,p_pos) into l_txt
    from zapros where kodz=p_kodz;
  exception when no_data_found then
    l_txt := null;
  end;
  return l_txt;
end;
 
/
 show err;
 
PROMPT *** Create  grants  F_GETC ***
grant EXECUTE                                                                on F_GETC          to ABS_ADMIN;
grant EXECUTE                                                                on F_GETC          to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_GETC          to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_getc.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 