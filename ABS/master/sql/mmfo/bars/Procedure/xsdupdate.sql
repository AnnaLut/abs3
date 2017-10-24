

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/XSDUPDATE.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure XSDUPDATE ***

  CREATE OR REPLACE PROCEDURE BARS.XSDUPDATE (kod_ number, txt_ varchar2) IS
BEGIN
  update zapros set xsd_data=txt_ where kodz=kod_;
END xsdupdate;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/XSDUPDATE.sql =========*** End ***
PROMPT ===================================================================================== 
