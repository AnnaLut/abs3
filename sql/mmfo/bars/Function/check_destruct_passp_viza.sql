
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/check_destruct_passp_viza.sql =====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.CHECK_DESTRUCT_PASSP_VIZA (p_ref number default null)
----------------------------------------------------------------------
-- Функция проверки серии и номера паспорта, при визировании документа
-- для операций 045 AA3 AA4 AA5 AA6 AAE AAL
----------------------------------------------------------------------
  return number
is
  l_ser     operw.value%type;
  l_num     operw.value%type;
  l_flag    number(1);
begin
  begin
    select trim(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(value,'1'),'2'),'3'),'4'),'5'),'6'),'7'),'8'),'9'),'0')) into l_ser from operw where ref = p_ref and tag = 'PASPN';
  exception when no_data_found then
    l_ser := '';
  end;
  begin
    select trim (translate(value,'1234567890'||value,'1234567890')) into l_num from operw where ref = p_ref and tag = 'PASPN';
  exception when no_data_found then
    l_num := '';
  end;

  select check_destruct_passp(l_ser, l_num) into l_flag from dual;

  if l_flag = 0 then
    return 0;
  else
    bars_error.raise_nerror ('BRS', 'PASSP_MUST_BE_DESTROYED');
  end if;
end check_destruct_passp_viza;
/
 show err;
 
PROMPT *** Create  grants  CHECK_DESTRUCT_PASSP_VIZA ***
grant EXECUTE                                                                on CHECK_DESTRUCT_PASSP_VIZA to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on CHECK_DESTRUCT_PASSP_VIZA to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/check_destruct_passp_viza.sql =====
 PROMPT ===================================================================================== 
 