/* ���� ����� ������� �-���� ������/����� ��� � ��� ��� �������
���������,���-�������,Գ�� (289) �� ���������,���-�������,����� (58) */
BEGIN
    UPDATE bars.tms_task
       SET SEQUENCE_NUMBER = 289
     WHERE id = 243; /*���������,���-�������,�����*/

    UPDATE bars.tms_task
       SET SEQUENCE_NUMBER = 58
     WHERE id = 242; /*���������,���-�������,Գ��*/
END;
/
COMMIT;
/