CREATE OR REPLACE FUNCTION c_tag_customer (rnk_ number, tag_ VARCHAR2, val_ VARCHAR2)
   RETURN varchar2
IS
   -- RETURN  - ���������� ��������� ���������. ���� �����, �� ��������� �������� �������
   smessage   VARCHAR2 (1000);
BEGIN
   BEGIN
      IF tag_ IN ('MEMB')
      THEN
         BEGIN
            IF to_number(val_) <0 or to_number(val_)> 99
            THEN
               RETURN '�������� �� ������� � ������� 0-99!';
            END IF;
         END;
      ------------------------------------------------
      END IF;

      RETURN null;
   EXCEPTION
      WHEN OTHERS
      THEN
         RETURN '����������� �������!';
   END;
END c_tag_customer;
/
grant execute on c_tag_customer to bars_access_defrole;