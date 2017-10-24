

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_ISTR.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_ISTR ***

  CREATE OR REPLACE PROCEDURE BARS.P_ISTR (
  p_txt     varchar2,
  p_otm out number )
is
-- проверка на вхождение в справочник террористов
begin
  p_otm := f_istr(p_txt);
end;
/
show err;

PROMPT *** Create  grants  P_ISTR ***
grant EXECUTE                                                                on P_ISTR          to BARS014;
grant EXECUTE                                                                on P_ISTR          to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_ISTR.sql =========*** End *** ==
PROMPT ===================================================================================== 
