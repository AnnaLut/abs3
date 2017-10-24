

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/NACH_VN2UN.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure NACH_VN2UN ***

  CREATE OR REPLACE PROCEDURE BARS.NACH_VN2UN (p_MFO varchar2, p_DAT date) is

/*
 ������.
 ����� II. �����������.
 SALDOA + SALDOB  �� 12 ����.�������
*/


begin

  NACH_VN2aun(p_MFO,p_DAT);
  logger.info('NACH_VN2. ������� SALDOA');

  NACH_VN2bun(p_MFO,p_DAT);
  logger.info('NACH_VN2. ������� SALDOB');

end NACH_VN2un;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/NACH_VN2UN.sql =========*** End **
PROMPT ===================================================================================== 
