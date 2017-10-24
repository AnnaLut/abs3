
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/beginofyear.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.BEGINOFYEAR (dat date := sysdate)
/* 
   ������� ������� ��� ����
   ========================
   ���� �������� dat �� �����, ������������ ������ ���� �������� ����,
   � ��������� ������ - ������ ���� ���������� ����

-- ��������� �.�. 29/01/2013 --
-- ��������������� �������� �.�. 03/04/2015 --
*/
RETURN date
IS
BEGIN
  RETURN trunc(dat,'YYYY');
END;
/
 show err;
 
PROMPT *** Create  grants  BEGINOFYEAR ***
grant EXECUTE                                                                on BEGINOFYEAR     to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/beginofyear.sql =========*** End **
 PROMPT ===================================================================================== 
 