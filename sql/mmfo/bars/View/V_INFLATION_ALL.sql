CREATE OR REPLACE FORCE VIEW BARS.V_INFLATION_ALL
(
   T,
   P,
   K
)
AS
   SELECT '�����ֲ�Ͳ ������ Ҳ��' AS T,
          '�����ֲ�Ͳ ������ ��������' AS P,
          '�����ֲ�Ͳ ������ ��̲Ѳ�' AS K
     FROM DUAL;


GRANT SELECT ON BARS.V_INFLATION_ALL TO BARS_ACCESS_DEFROLE;