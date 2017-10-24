
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/get_stiket.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.GET_STIKET (p_ref int) return varchar is
  ttt  blob;
  ttt1 varchar2(4000);
  x    long raw;
begin

  select stiket into x from cp_arch where ref = p_ref;

  dbms_lob.createtemporary(ttt, false);
  dbms_lob.append(ttt, x);
  ttt1 := substr(utl_raw.cast_to_varchar2(ttt), 1, 4000);
  --dbms_output.put_line(substr(ttt1,300,50));
  dbms_lob.freetemporary(ttt);

  return ttt1;
end;
/
 show err;
 
PROMPT *** Create  grants  GET_STIKET ***
grant EXECUTE                                                                on GET_STIKET      to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/get_stiket.sql =========*** End ***
 PROMPT ===================================================================================== 
 