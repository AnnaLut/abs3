
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_cust_gap.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_CUST_GAP (p_text varchar2)
return varchar2
  is
v_number number;
v_length  number;
v_res number;
begin

  select instr (trim(p_text),' '), length(trim(p_text))
     into v_number,
     v_length
  from dual;

  if
    nvl(v_number,0) =0 and nvl(v_length,0)>3 then v_number:=0;
  elsif
    nvl(v_number,0) >=1 and nvl(v_length,0)>3 then v_number:=1;
  else v_number:=null;
  end if;

  return v_number;
end;
/
 show err;
 
PROMPT *** Create  grants  F_CUST_GAP ***
grant EXECUTE                                                                on F_CUST_GAP      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_CUST_GAP      to FINMON01;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_cust_gap.sql =========*** End ***
 PROMPT ===================================================================================== 
 