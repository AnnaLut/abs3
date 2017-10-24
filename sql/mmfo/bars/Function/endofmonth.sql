
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/endofmonth.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.ENDOFMONTH (dat date := sysdate)
/* 
   ������� ���������� ��� ������
   =============================
   ���� �������� dat �� �����, ������������ ��������� ���� �������� ������,
   � ��������� ������ - ��������� ���� ���������� ������

-- ��������� �.�. 29/01/2013 --
-- ��������������� �������� �.�. 03/04/2015 --
*/
RETURN date
IS
BEGIN
  RETURN TRUNC(LAST_DAY(dat));
END;
/
 show err;
 
PROMPT *** Create  grants  ENDOFMONTH ***
grant EXECUTE                                                                on ENDOFMONTH      to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/endofmonth.sql =========*** End ***
 PROMPT ===================================================================================== 
 