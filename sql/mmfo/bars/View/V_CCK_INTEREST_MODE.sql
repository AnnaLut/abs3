CREATE OR REPLACE VIEW V_CCK_INTEREST_MODE AS
SELECT id, p_mode
  FROM (SELECT 0 AS id
              ,'0-�������,����������� ��� ���,����������� ��������,����,����� �� �������������� ���,�����' AS p_mode
          FROM dual
        UNION ALL
        SELECT 1 AS id, '1-����������� ��� ���' AS p_mode
          FROM dual
        UNION ALL
        SELECT 2 AS id
              ,'2-����������� ��������' AS p_mode
          FROM dual
        UNION ALL
        SELECT 3 AS id, '3-����' AS p_mode
          FROM dual
        UNION ALL
        SELECT 4 AS id
              ,'4-����� �� �������������� ���' AS p_mode
          FROM dual
        UNION ALL
        SELECT 5 AS id, '5-�����' AS p_mode
          FROM dual);
