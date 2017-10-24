

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/TEMP_KLBXVP.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  procedure TEMP_KLBXVP ***

  CREATE OR REPLACE PROCEDURE BARS.TEMP_KLBXVP 
is
begin
   for c in (select sab from v_klbx_branch where isactive = 1)
   loop
      bars_xmlklb_ref.postvp_for_sab(c.sab, sysdate, '%');
      commit;
   end loop;
end;
 
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/TEMP_KLBXVP.sql =========*** End *
PROMPT ===================================================================================== 
