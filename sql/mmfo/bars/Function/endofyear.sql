
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/endofyear.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.ENDOFYEAR (dat date := sysdate)
/* 
   ������� ���������� ��� ����
   ===========================
   ���� �������� dat �� �����, ������������ ��������� ���� �������� ����,
   � ��������� ������ - ��������� ���� ���������� ����

-- ��������� �.�. 29/01/2013 --
-- ��������������� �������� �.�. 03/04/2015 --
*/
RETURN date
IS
BEGIN
  RETURN to_date('31/12/'||to_char(extract(year from dat),'9999'),'DD/MM/YYYY');
END;
/
 show err;
 
PROMPT *** Create  grants  ENDOFYEAR ***
grant EXECUTE                                                                on ENDOFYEAR       to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/endofyear.sql =========*** End *** 
 PROMPT ===================================================================================== 
 