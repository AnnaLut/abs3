

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_BLKD11.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_BLKD11 ***

  CREATE OR REPLACE TRIGGER BARS.TIU_BLKD11 
   BEFORE INSERT OR UPDATE OF blkd
   ON accounts
   FOR EACH ROW
     WHEN (NEW.blkd = '11' OR (OLD.blkd = '11' AND NEW.blkd = '0')) DECLARE
   /* 03/08/2015 ������� �����, ���� �������� ������ http://jira.unity-bars.com.ua:11000/browse/COBUSUPABS-3507
      � ������ ������� �� ������� �Գ�����⳻ � ��� ����������� �� ������ ����������� ��������
      ������������� �������� �� �������� ����������� ��� ����� ����� ��������� �����������
      �������� �������� �������� � ���� ���������� ������� � ����� ������������ ���������
      ���������� ������� ����� � �������, �� �� ��������� �����, � ����� ���� �����,
      �� ��������� �������� ����� ���� ����������� ������.


      ���� ����� ��������� added a comment - 17/Jul/15 2:44 PM
      �������, ���� �����, �����, �� ������� �������� ����������� �������� ����������� ��������
      : �...� ��� ���������� ������ �� �������/ ���� ������� ���� �������� ����������� ��������
      �� ������� � ��� ����������� �� ����� ��������� ��� �����. ���������� ����������� ��������
      ����������� � ���, ���������� �� ���� ������ ������...�

      ���� ����� ��� �������� ���������� ������ ������� ������
      (���� ������������ � ������ ������� �� ������� �Գ�����⳻ � ��� ����������� �� ������
      ��������� ������������� �������� �� ���������� ���� ���������� �������) ����������� ����������
      ����������� ������� �� �������� � ���� ���������� ������.
      ����������� ������� �� ���������� ���� ���� ������ ������ � ���,
      ���������� �� ���� ������ ������.
      ��� ����� ������� �� ������ �������������� �� �����
      䳿 ������ (� ���� ���������� ������ �� ���� ������ ������ �������).
   */
   is_dp   INT := 0;      -- �������, ��������� � ���������� ��������� ��� ���
   l_id    int_ratn.id%TYPE;
   l_ir    int_ratn.ir%TYPE;
   l_br    int_ratn.br%TYPE;
   l_op    int_ratn.op%TYPE;

   FUNCTION f_is_dp (p_acc accounts.nbs%TYPE, p_nbs accounts.nbs%TYPE)
      RETURN INT
   IS
   BEGIN
      BEGIN
         SELECT 1
           INTO is_dp
           FROM dpt_accounts
          WHERE accid = p_acc;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            IF p_nbs IN ('2620',
                         '2628',
                         '2630',
                         '2635',
                         '2638',
                         '2610',
                         '2618',
                         '2615',
                         '2650',
                         '2658')
            THEN
               is_dp := 1;
            ELSE
               is_dp := 0;
            END IF;
      END;

      RETURN is_dp;
   END;
BEGIN
   IF :NEW.BLKD = '11' AND NVL (COALESCE (:NEW.LIM, :OLD.LIM), 0) = 0
   THEN
      bars_error.raise_nerror ('CAC', 'ERR_BLKD11');
   ELSE
      IF :NEW.blkd = '11'
      THEN
         BEGIN
            -- 1. ��������, ��������� �� �������� ����������� ���� � ����������� ��������
            is_dp := f_is_dp (p_acc => :old.acc, p_nbs => :old.nbs);
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               RETURN;
         END;

         -- 1.a �������� ��������� ����������� ���������� �������� �����
         IF NVL (IS_DP, 0) = 1
         THEN
            BEGIN
               SELECT ia.id, 0
                 INTO l_id, l_ir
                 FROM int_ratn it, int_accn ia
                WHERE     it.acc = ia.acc
                      AND it.acc = :old.acc
                      AND it.bdat = (SELECT MAX (bdat)
                                       FROM int_ratn
                                      WHERE acc = it.acc AND id = ia.id);
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  BARS_ERROR.RAISE_NERROR ('CAC', 'ERR_BLKD11_DPT');
            END;

            -- 2. ������������� � ���������� �������� �������� ������ = 0
            BEGIN
               INSERT INTO int_ratn (ACC,
                                     ID,
                                     BDAT,
                                     IR,
                                     BR,
                                     OP,
                                     IDU)
                    VALUES (:old.acc,
                            l_id,
                            gl.bd,
                            l_ir,
                            NULL,
                            NULL,
                            user_id); -- ��� ���� ������ = 0 � ������� ������ ������
            EXCEPTION
               WHEN DUP_VAL_ON_INDEX
               THEN
                  RETURN;
            END;
         END IF;
      ELSIF (:OLD.blkd = '11' AND :NEW.blkd = '0')
      THEN
         -- 1. ��������, ��������� �� �������� ����������� ���� � ����������� ��������
         BEGIN
            -- 1. ��������, ��������� �� �������� ����������� ���� � ����������� ��������
            is_dp := f_is_dp (p_acc => :old.acc, p_nbs => :old.nbs);
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               RETURN;
         END;

         IF NVL (is_dp, 0) = 1
         THEN
            -- 1.a �������� ��������� ����������� ���������� �������� �����
            BEGIN
               SELECT ir0.id,
                      ir0.ir,
                      ir0.br,
                      ir0.op
                 INTO l_id,
                      l_ir,
                      l_br,
                      l_op
                 FROM int_ratn ir0
                WHERE     acc = :old.acc
                      AND bdat =
                             (SELECT MAX (bdat)
                                FROM (SELECT it.acc,
                                             it.id,
                                             it.bdat,
                                             LEAD (it.bdat)
                                                OVER (ORDER BY it.acc)
                                                bdat2,
                                             it.ir
                                        FROM int_ratn it, int_accn ia
                                       WHERE     it.acc = ia.acc
                                             AND it.acc = :old.acc)
                               WHERE bdat2 IS NOT NULL);
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  BARS_ERROR.RAISE_NERROR ('CAC', 'ERR_BLKD11_DPT_PR');
            END;

            -- 2. ��������������� � ���������� �������� �������� ������ = ���������� �������� ����� 0
            BEGIN
               INSERT INTO int_ratn (ACC,
                                     ID,
                                     BDAT,
                                     IR,
                                     BR,
                                     OP,
                                     IDU)
                    VALUES (:old.acc,
                            l_id,
                            gl.bd + 1,
                            l_ir,
                            l_br,
                            l_op,
                            user_id); -- ��� ���� ������ = 0 � ������� ������ ������
            EXCEPTION
               WHEN DUP_VAL_ON_INDEX
               THEN
                  DELETE FROM int_ratn
                        WHERE acc = :old.acc AND bdat = gl.bd;
            END;
         END IF;
      END IF;
   END IF;
END TIU_BLKD11;



/
ALTER TRIGGER BARS.TIU_BLKD11 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_BLKD11.sql =========*** End *** 
PROMPT ===================================================================================== 
