

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/WEB_TT_BM.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure WEB_TT_BM ***

  CREATE OR REPLACE PROCEDURE BARS.WEB_TT_BM (mode_ number)
   is
   kod_ number;
   cena_ number;
   ref_  oper.ref%type;
  begin
  ref_ := gl.aRef;

  kod_ := to_number(f_dop(ref_, 'BM__C'));
  cena_ := to_number(f_dop(ref_, 'BM__R'))*100;

  if cena_ != CENA_BM(mode_, kod_)
   --then  raise_application_error(-20100, 'Вартість цінності №'|| kod_||' '|| f_dop(ref_, 'BM__N') ||'      '||cena_ /100  || 'грн.    не відповідає вартості на даний момент ('||CENA_BM(mode_, kod_)/100||' грн.)' );
   then bars_error.raise_nerror('KBM', 'FALSE_COURSE');

 else null;
 end if;

  end;
/
show err;

PROMPT *** Create  grants  WEB_TT_BM ***
grant EXECUTE                                                                on WEB_TT_BM       to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/WEB_TT_BM.sql =========*** End ***
PROMPT ===================================================================================== 
