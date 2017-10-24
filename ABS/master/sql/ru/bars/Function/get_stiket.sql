
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/get_stiket.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.GET_STIKET (P_ref int)
return varchar is

ttt blob; ttt1 varchar2(4000);
x long raw;
begin

select STIKET into x from CP_ARCH where ref=p_ref;

dbms_lob.createtemporary(ttt,FALSE);
dbms_lob.append(ttt,x);
ttt1:=SUBSTR(UTL_RAW.CAST_TO_VARCHAR2(ttt),1,4000);
--dbms_output.put_line(substr(ttt1,300,50));
dbms_lob.freetemporary(ttt);

return ttt1;
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/get_stiket.sql =========*** End ***
 PROMPT ===================================================================================== 
 