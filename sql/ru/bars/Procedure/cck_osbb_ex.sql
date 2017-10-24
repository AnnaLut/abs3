

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/CCK_OSBB_EX.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  procedure CCK_OSBB_EX ***

  CREATE OR REPLACE PROCEDURE BARS.CCK_OSBB_EX (p_mode int )  is
 sErr varchar2(2000);  s1_ varchar2(100);  nlchr char(2) := chr(13)||chr(10);  i_ int ;
begin    delete from TMP_OPERW;
  for k in (select nd FROM V_CCK_OSBB )
  loop   cck_OSBB (p_mode , k.nd) ;    sErr := substr( pul.Get_Mas_Ini_Val('ERR_OSBB'), 3, 2000);
   while 1< 2   loop           i_   := instr(sErr,nlchr )-1 ;
      If i_ > 0 then
         s1_  := substr(sErr, 1, i_)    ;
         insert  into  TMP_OPERW(ord, value) values (k.nd, s1_) ;
         sErr := Substr( replace( sErr, s1_, '') , 3,2000);
      else EXIT ;
      end  if;
   end loop;
end loop;
end cck_OSBB_ex;
/
show err;

PROMPT *** Create  grants  CCK_OSBB_EX ***
grant EXECUTE                                                                on CCK_OSBB_EX     to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/CCK_OSBB_EX.sql =========*** End *
PROMPT ===================================================================================== 
