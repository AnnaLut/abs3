

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_PRVNFINDEB_EFFECTDATE.sql ======
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_PRVNFINDEB_EFFECTDATE ***

  CREATE OR REPLACE TRIGGER BARS.TBI_PRVNFINDEB_EFFECTDATE 
BEFORE INSERT
ON PRVN_FIN_DEB
FOR EACH ROW
   WHEN ( new.EFFECTDATE Is Null ) BEGIN
  :new.EFFECTDATE := nvl(to_date(sys_context('bars_gl','bankdate'),'MM/DD/YYYY'),trunc(sysdate));
END TBI_PRVNFINDEB_EFFECTDATE;


/
ALTER TRIGGER BARS.TBI_PRVNFINDEB_EFFECTDATE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_PRVNFINDEB_EFFECTDATE.sql ======
PROMPT ===================================================================================== 
