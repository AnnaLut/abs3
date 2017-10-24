
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/extract_first_name.sql =========***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.EXTRACT_FIRST_NAME (p_full_name in varchar2)
return varchar2 is
  --
  -- ���������� �������
  --
  l_nmk     customer.nmk%type;
  l_array   dbms_utility.lname_array;
  l_length  binary_integer;
  l_num     integer;
begin
  l_nmk := trim(p_full_name); l_num := length(l_nmk)+1;
  -- ������� ������ ������ �������
  while l_num > length(l_nmk) loop
    l_num := length(l_nmk);
    l_nmk := replace(l_nmk, '  ',' ');
  end loop;
  return substr(l_nmk,1,instr(l_nmk,' ')-1);
end extract_first_name;
 
/
 show err;
 
PROMPT *** Create  grants  EXTRACT_FIRST_NAME ***
grant EXECUTE                                                                on EXTRACT_FIRST_NAME to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/extract_first_name.sql =========***
 PROMPT ===================================================================================== 
 