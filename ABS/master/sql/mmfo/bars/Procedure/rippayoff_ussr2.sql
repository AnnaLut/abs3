

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/RIPPAYOFF_USSR2.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  procedure RIPPAYOFF_USSR2 ***

  CREATE OR REPLACE PROCEDURE BARS.RIPPAYOFF_USSR2 (p_date date)
is
   l_blob blob;
begin
   l_blob := f_get_ussr2_rippayoff_data(p_date);
   delete from tmp_lob where id = -1001;
   insert into tmp_lob(id, blobdata) values(-1001, l_blob);
end;
/
show err;

PROMPT *** Create  grants  RIPPAYOFF_USSR2 ***
grant EXECUTE                                                                on RIPPAYOFF_USSR2 to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on RIPPAYOFF_USSR2 to RPBN001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/RIPPAYOFF_USSR2.sql =========*** E
PROMPT ===================================================================================== 
