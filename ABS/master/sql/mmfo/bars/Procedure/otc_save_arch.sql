

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/OTC_SAVE_ARCH.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  procedure OTC_SAVE_ARCH ***

  CREATE OR REPLACE PROCEDURE BARS.OTC_SAVE_ARCH (p_kodf in varchar2, p_datf in date, p_type in number) is
begin
    null;
end;
/
show err;

PROMPT *** Create  grants  OTC_SAVE_ARCH ***
grant EXECUTE                                                                on OTC_SAVE_ARCH   to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on OTC_SAVE_ARCH   to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/OTC_SAVE_ARCH.sql =========*** End
PROMPT ===================================================================================== 
