

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/FM_BLOCKDOC.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  procedure FM_BLOCKDOC ***

  CREATE OR REPLACE PROCEDURE BARS.FM_BLOCKDOC (p_ref number, p_otm  number) is
  PRAGMA AUTONOMOUS_TRANSACTION;
begin
  insert into fm_ref_que(ref, otm) values(p_ref, p_otm);
  commit;
end;
/
show err;

PROMPT *** Create  grants  FM_BLOCKDOC ***
grant EXECUTE                                                                on FM_BLOCKDOC     to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/FM_BLOCKDOC.sql =========*** End *
PROMPT ===================================================================================== 
