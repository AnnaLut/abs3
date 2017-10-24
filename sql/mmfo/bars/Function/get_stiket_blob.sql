
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/get_stiket_blob.sql =========*** Ru
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.GET_STIKET_BLOB (p_ref int) return blob is
  ttt_temp blob;
  ttt      blob;
  x        long raw;
begin
  select stiket into x from cp_arch where ref = p_ref;

  dbms_lob.createtemporary(ttt_temp, false);
  dbms_lob.append(ttt_temp, x);
  ttt := ttt_temp;
  dbms_lob.freetemporary(ttt_temp);

  return ttt;
end;
/
 show err;
 
PROMPT *** Create  grants  GET_STIKET_BLOB ***
grant EXECUTE                                                                on GET_STIKET_BLOB to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/get_stiket_blob.sql =========*** En
 PROMPT ===================================================================================== 
 