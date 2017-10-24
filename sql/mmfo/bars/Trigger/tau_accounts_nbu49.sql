

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAU_ACCOUNTS_NBU49.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAU_ACCOUNTS_NBU49 ***

  CREATE OR REPLACE TRIGGER BARS.TAU_ACCOUNTS_NBU49 
   AFTER UPDATE OF ostc
   ON ACCOUNTS
   FOR EACH ROW
     WHEN (    (   old.NBS IN ('2600', '2650')
              OR (old.NBS = '2604' AND old.OB22 IN (1, 3, 5))
              OR (    old.NBS LIKE '25__'
                  AND old.NBS NOT IN ('2560',
                                      '2565',
                                      '2568',
                                      '2570',
                                      '2571',
                                      '2572')))
         AND old.ostc > new.ostc) DECLARE
   oo      oper%ROWTYPE;
   ost_    NUMBER;                                       -- ���������� �������
   s_      NUMBER;                                           -- ����� ��������
   nTmp_   INT;
   DOS_    NUMBER;
BEGIN
   S_ := :old.ostc - :new.ostc;                              -- ����� ��������


   --- ��������� �� �������� "��������"  OK�O='20077720':

   BEGIN
      SELECT 1
        INTO nTmp_
        FROM Customer
       WHERE rnk = :old.rnk AND OKPO IN ('20077720');

      RETURN;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         NULL;
   END;

   --- ��������� �� �������� �����:

   IF gl.amfo = '300465' AND :old.NMS LIKE '%�����%'
   THEN
      RETURN;
   END IF;


   BEGIN
      SELECT *
        INTO oo
        FROM oper
       WHERE REF = gl.Aref;

      IF    oo.mfoa = gl.amfo AND oo.mfob LIKE '8%'
         OR oo.sk IN (40, 50, 59)
         OR     oo.sk = 61
            AND (   UPPER (oo.NAZN) LIKE '%������_�%'
                 OR UPPER (oo.NAZN) LIKE '%�_�����%')
      THEN
         RETURN;                       -- ��� ��. - ������ ������ �� ��������:
      /* �������� ������������� HE ����������������� ����������� ���:
         1. ������i �� �������, ���i������ ����i� � ��� �����-����������
            ���������� �� 8.
         2. ������� �����i��� �����, ����i�, �������i�, ���i������ ������,
            �i��������:
            �)  ������� �����i��� �����, �������i�.    ���=40
            �)  ������� ����i�, ���i������ ������       ���=50,59
      */

      END IF;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         RETURN;               -- ����� �� �.�. - ����� ����������� ���� � GL.
   END;


   IF :old.lim > 0
   THEN
      ost_ := :old.ostc + :old.lim;          -- ��������� ������ ��� (lim > 0)
   ELSE
      ost_ := :old.ostc;        -- ����������� ������� (lim < 0) �� ���������.
   END IF;


   IF :old.dapp = gl.bdate
   THEN
      --  ���������� DOS �� ���� ��� �����   M��-� like '8%'  �  ���=40,50,59
      BEGIN
         SELECT NVL (SUM (p.S), 0)
           INTO DOS_
           FROM opldok p, oper o
          WHERE     p.fdat = gl.bdate
                AND p.acc = :old.acc
                AND p.dk = 0
                AND p.SOS = 5
                AND o.REF = p.REF
                AND NOT (   o.mfob LIKE '8%'
                         OR NVL (o.SK, 0) IN (40, 50, 59)
                         OR (    NVL (o.SK, 0) = 61
                             AND (   UPPER (o.NAZN) LIKE '%������_�%'
                                  OR UPPER (o.NAZN) LIKE '%�_�����%')));
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            DOS_ := 0;
      END;

      ost_ := ost_ - :old.kos + :old.dos; -- ��.�������  c ������ ������ ��� � ���� ����
      s_ := s_ + DOS_;
   END IF;                      -- ��.�������  c ������ ������ ��� � ���� ����

   IF ost_ - s_ >= 0
   THEN
      RETURN;       -- 2) ��� ��. ��������� �� ��.�������, �.�. � ��������� 49
   END IF;


   -- �������� ��� ��������, ������� �� ���������� ������������, ���������  �������� 49.
   -- ��������, �.�. ��� ���������� �/�
   BEGIN
      SELECT 1
        INTO s_
        FROM operw
       WHERE REF = gl.Aref AND tag = 'NBU49';

      RETURN;                                 -- 3) �� ���������� ������������
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         NULL;
   END;


   -- ��������:  ����� ��� 'BAK'-�������� ?
   BEGIN
      SELECT 1
        INTO s_
        FROM opldok
       WHERE     REF = gl.Aref
             AND dk = 0
             AND tt = 'BAK'
             AND acc = :old.acc
             AND ROWNUM = 1;

      RETURN;                -- 4)  ��� 'BAK'-�������� ����������� �����������
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         NULL;
   END;


   -- �������� ������������� ��� �49 �� 06.02.2014 (��.���.:%s, ���.���.:%s)
   -- raise_application_error(-20203, '�������� ��������� ��� �49 �i� 06.02.2014 (���.���.:' || :old.nls || ', ���.���.:' || gl.Aref || ')');*/
   bars_error.raise_nerror ('BRS',
                            'BROKEN_ACT_NBU49',
                            :old.nls,
                            gl.Aref);
END tau_accounts_NBU49;



/
ALTER TRIGGER BARS.TAU_ACCOUNTS_NBU49 DISABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAU_ACCOUNTS_NBU49.sql =========*** 
PROMPT ===================================================================================== 
