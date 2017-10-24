
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_check_zp.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_CHECK_ZP (p_ref oper.ref%type)
	return number
  is
    l_nazn  varchar2(160);
    l_val operw.value%type :=null;
    ern   CONSTANT POSITIVE := 803;
    err            EXCEPTION;
    erm            VARCHAR2 (4000);
BEGIN

   -- Определяем назначения платежа и ТТ:
   Begin
      Select trim(NAZN) into l_nazn from OPER where REF=p_ref;
   Exception when no_data_found then
      raise_application_error(-20000, 'Document '||p_ref||' not found');
   End;


   Begin
      select value into l_val from OperW where REF = p_ref and tag='ED_VN' ;
   Exception when no_data_found then
      l_val:=null;
   End;


   if upper(l_nazn) like upper('%зар%плат%') and nvl(l_val,'0') = '0' then

     erm := '       Не заповнено реквізит «Довідка про сплату єд.внеску».  Якщо це кошти на зарплату, то введіть:  або дані про Довідку, або 1 - якщо в клієнта наявні плат.доруч. про перерах. податку';
     RAISE err;

   end if;

   Return 0;

EXCEPTION  WHEN err THEN
   raise_application_error(-(20000+ern),'\'||erm,TRUE);
END;
/
 show err;
 
PROMPT *** Create  grants  F_CHECK_ZP ***
grant EXECUTE                                                                on F_CHECK_ZP      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_CHECK_ZP      to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_check_zp.sql =========*** End ***
 PROMPT ===================================================================================== 
 