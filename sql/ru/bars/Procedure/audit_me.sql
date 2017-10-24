

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/AUDIT_ME.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure AUDIT_ME ***

  CREATE OR REPLACE PROCEDURE BARS.AUDIT_ME is
begin
  null;
end; 
/
show err;

PROMPT *** Create  grants  AUDIT_ME ***
grant EXECUTE                                                                on AUDIT_ME        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/AUDIT_ME.sql =========*** End *** 
PROMPT ===================================================================================== 
