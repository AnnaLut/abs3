

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/SHOWDEBUGMSG.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure SHOWDEBUGMSG ***

  CREATE OR REPLACE PROCEDURE BARS.SHOWDEBUGMSG (
  ern_in IN POSITIVE,
  var   IN VARCHAR2,
  thing  IN VARCHAR2) IS
BEGIN
 IF deb.debug THEN
      deb.trace(ern_in, var, thing);
 END IF;
END ShowDebugMsg;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/SHOWDEBUGMSG.sql =========*** End 
PROMPT ===================================================================================== 
