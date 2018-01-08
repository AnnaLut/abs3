

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_PROTOCOL_KOVBASA.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_PROTOCOL_KOVBASA ***

  CREATE OR REPLACE PROCEDURE p_protocol_kovbasa(p_day_before NUMBER)
--------------------------------------------------------------------------
  --  P_PROTOCOL_KOVBASA
  -- 
  --  ������������ ��������� ("�������" ��������) ��� ����� ���������� ���
  --  ( ��������� �.�. 03-2017 )
  --
  --  p_day_before - ���- �� ���������� ���� �����
  
  -- 2017/06/06 -- ������� �.�.
  -- ��������� �������� � "������������ �� ���� ��", �� ������������ "�� ������� ��� ��"
  -- ���� ����� p_day_before = 2, �� ������������� �� ���������, � ������ ������������ �� 
  -- ��������� � �����
  
  --------------------------------------------------------------------------
 IS
  l_bankdate VARCHAR2(10);
  l_numb     NUMBER := p_day_before;
BEGIN
  WHILE l_numb > 0
  LOOP
    SELECT to_char(MAX(fdat)
                  ,'DD/MM/YYYY')
      INTO l_bankdate
      FROM (SELECT fdat
                  ,row_number() over(ORDER BY fdat DESC) n
              FROM fdat
             WHERE fdat <= (SELECT MAX(fdat)
                              FROM fdat
                             WHERE fdat < trunc(SYSDATE))) fd
     WHERE n = l_numb;
  
    bars_zvtdoc.nest_report_table(to_date(l_bankdate
                                         ,'DD/MM/YYYY'));
    l_numb = l_numb - 1;
  END LOOP;
END p_protocol_kovbasa;
/

show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_PROTOCOL_KOVBASA.sql =========**
PROMPT ===================================================================================== 
