

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ZAY_DATA_TRANSFER.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ZAY_DATA_TRANSFER ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ZAY_DATA_TRANSFER ("ID", "MFO", "REQ_ID", "TRANSFER_TYPE", "TRANSFER_TYPE_NAME", "TRANSFER_DATE", "TRANSFER_RESULT", "COMM") AS 
  SELECT id,
            mfo,
            req_id,
            transfer_type,
            SUBSTR (
               CASE
                  WHEN transfer_type = 1
                  THEN
                     '������������ ������������ ����� ����� �� ����� �����'
                  WHEN transfer_type = 2
                  THEN
                     '��������� ������'
                  WHEN transfer_type = 3
                  THEN
                     '³������� ������'
                  WHEN transfer_type = 4
                  THEN
                     '������������ ��������� �����'
                  WHEN transfer_type = 5
                  THEN
                     '����������� ������'
                  WHEN transfer_type = 6
                  THEN
                     '���������� ���� �������� ����� �� ������'
                  WHEN transfer_type = 7
                  THEN
                     '���������� ���� ����������� ������'
                  WHEN transfer_type = 8
                  THEN
                     '���� ������'
                  WHEN transfer_type = 9
                  THEN
                     '³������� ������'
                  WHEN transfer_type = 10
                  THEN
                     '���������� ���� ����������'
                  WHEN transfer_type = 11
                  THEN
                     '���������� � ������� ������'
                  ELSE
                     NULL
               END,
               1,
               254),
            transfer_date,
            transfer_result,
            SUBSTR (comm, 1, 254)
       FROM zay_data_transfer
      WHERE    (kf = f_ourmfo () AND f_ourmfo () <> '300465')
            OR f_ourmfo () = '300465'
   ORDER BY 1 DESC;

PROMPT *** Create  grants  V_ZAY_DATA_TRANSFER ***
grant SELECT                                                                 on V_ZAY_DATA_TRANSFER to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_ZAY_DATA_TRANSFER to ZAY;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ZAY_DATA_TRANSFER.sql =========*** En
PROMPT ===================================================================================== 
