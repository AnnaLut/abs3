

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/SBB_SPEC.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure SBB_SPEC ***

  CREATE OR REPLACE PROCEDURE BARS.SBB_SPEC (p_grp number) is
   l_row number;
begin
   l_row := nvl(to_number(getglobaloption('SBBSPEC')),3000);
   for c in ( select ref from oper
              where ref in (select ref from ref_que)
                and ref in (select ref from tmp_sbbspec)
                and rownum <= l_row
                and sos between 1 and 3 for update of chk nowait)
   loop
      chk.put_ack0(c.ref, p_grp);
   end loop;
end;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/SBB_SPEC.sql =========*** End *** 
PROMPT ===================================================================================== 
