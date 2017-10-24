
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/endofweek.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.ENDOFWEEK (dat date := sysdate)
/* 
   ������� ����� ������
   ====================
   ���� �������� dat �� �����, ������������ ����� ������� ������,
   � ��������� ������ - ����� ������ ��� ��������� ����

-- ��������� �.�. 03/04/2015 --
*/
RETURN date
IS
BEGIN
  RETURN trunc(dat, 'DAY')+7;
END;
/
 show err;
 
PROMPT *** Create  grants  ENDOFWEEK ***
grant EXECUTE                                                                on ENDOFWEEK       to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/endofweek.sql =========*** End *** 
 PROMPT ===================================================================================== 
 