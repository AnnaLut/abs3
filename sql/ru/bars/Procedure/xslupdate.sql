

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/XSLUPDATE.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure XSLUPDATE ***

  CREATE OR REPLACE PROCEDURE BARS.XSLUPDATE (kod_ number, txt_ varchar2) IS
BEGIN
  update zapros set xsl_data=txt_ where kodz=kod_;
END xslupdate;
/
show err;

PROMPT *** Create  grants  XSLUPDATE ***
grant EXECUTE                                                                on XSLUPDATE       to ABS_ADMIN;
grant EXECUTE                                                                on XSLUPDATE       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on XSLUPDATE       to START1;
grant EXECUTE                                                                on XSLUPDATE       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/XSLUPDATE.sql =========*** End ***
PROMPT ===================================================================================== 
