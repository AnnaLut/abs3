BEGIN
   INSERT INTO BARS.DICT_EXCTXT (ID, NAME, USE)
           VALUES (
                     16,
                     '������ ���� ��� ������ ����� ������ (��������� ���), ��� ������ ����������� ���������',
                     2);
EXCEPTION
   WHEN DUP_VAL_ON_INDEX
   THEN
      NULL;
END;
/

COMMIT;