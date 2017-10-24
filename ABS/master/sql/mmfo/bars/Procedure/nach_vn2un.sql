

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/NACH_VN2UN.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure NACH_VN2UN ***

  CREATE OR REPLACE PROCEDURE BARS.NACH_VN2UN (p_MFO varchar2, p_DAT date) is

/*
 —ухова.
 „ј—“№ II. необходима€.
 SALDOA + SALDOB  за 12 пред.мес€цев
*/


begin

  NACH_VN2aun(p_MFO,p_DAT);
  logger.info('NACH_VN2. —делано SALDOA');

  NACH_VN2bun(p_MFO,p_DAT);
  logger.info('NACH_VN2. —делано SALDOB');

end NACH_VN2un;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/NACH_VN2UN.sql =========*** End **
PROMPT ===================================================================================== 
