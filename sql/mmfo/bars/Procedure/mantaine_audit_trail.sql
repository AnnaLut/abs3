

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/MANTAINE_AUDIT_TRAIL.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  procedure MANTAINE_AUDIT_TRAIL ***

  CREATE OR REPLACE PROCEDURE BARS.MANTAINE_AUDIT_TRAIL is
begin
  execute immediate 'delete from sys.aud$ where proxy$sid is not null';
end; 
 
/
show err;

PROMPT *** Create  grants  MANTAINE_AUDIT_TRAIL ***
grant EXECUTE                                                                on MANTAINE_AUDIT_TRAIL to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/MANTAINE_AUDIT_TRAIL.sql =========
PROMPT ===================================================================================== 
