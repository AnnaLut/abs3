
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/getbankname.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.GETBANKNAME (
  p_mfo in varchar2 ) return varchar2
is
l_bankName banks.nb%type;
begin

   select nb
     into l_bankName
     from banks
    where mfo = p_mfo;

    return l_bankName;

exception
    when NO_DATA_FOUND then return null;
end;
 
/
 show err;
 
PROMPT *** Create  grants  GETBANKNAME ***
grant EXECUTE                                                                on GETBANKNAME     to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on GETBANKNAME     to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/getbankname.sql =========*** End **
 PROMPT ===================================================================================== 
 