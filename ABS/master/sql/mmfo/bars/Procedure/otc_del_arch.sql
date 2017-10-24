

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/OTC_DEL_ARCH.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure OTC_DEL_ARCH ***

  CREATE OR REPLACE PROCEDURE BARS.OTC_DEL_ARCH (p_kodf in varchar2, p_datf in date, p_type in number) is
    isp_    number;
begin
    null;
end;
/
show err;

PROMPT *** Create  grants  OTC_DEL_ARCH ***
grant EXECUTE                                                                on OTC_DEL_ARCH    to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on OTC_DEL_ARCH    to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/OTC_DEL_ARCH.sql =========*** End 
PROMPT ===================================================================================== 
