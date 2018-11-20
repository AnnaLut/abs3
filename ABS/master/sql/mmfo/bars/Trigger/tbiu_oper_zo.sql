

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBIU_OPER_ZO.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBIU_OPER_ZO ***

  CREATE OR REPLACE TRIGGER BARS.TBIU_OPER_ZO 
   --09.11.2016 Sta ��������� ���� ��� SNA (Finevare)
   --07.11.2016 Sta �� ���������  ����-� ��� ���.�� ( ��� ���� � ������ CIN). ��������� : ����� � ��������
   BEFORE INSERT OR UPDATE
   ON BARS.OPER    FOR EACH ROW
DECLARE
   l_T0    VARCHAR2 (1) := 0 ;        -- = 1 -  ���� �0 ��� ������������ �� ���.����
   l_Ret   INT;
   oo      oper%ROWTYPE;

   FUNCTION XX (p_kv INT, p_nls VARCHAR2)
      RETURN INT
   IS
      p_Ret     INT := 2;
      l_Dat01   DATE;
   BEGIN
      IF l_T0 = '1'   THEN
         BEGIN
            SELECT 0 INTO p_Ret FROM srezerv_ob22  WHERE  nbs = SUBSTR (p_nls, 1, 4)   AND ROWNUM = 1;
            raise_application_error ( -20096, '�������� �� �������� ���� �� ���.' || p_nls
                                                                                  || ' �� ������ �0 !');
         EXCEPTION  WHEN NO_DATA_FOUND  THEN  NULL;
         END;
      END IF;

      l_Dat01 := TRUNC (gl.Bdate, 'MM');

      BEGIN
         SELECT 1
           INTO p_Ret
           FROM accounts
          WHERE kv = p_kv AND nls = p_nls AND daos < l_Dat01;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            raise_application_error (
               -20096,
                  '������� '
               || p_kv
               || '/'
               || p_nls
               || ' �� ������� �� '
               || TO_CHAR (l_Dat01, 'dd.mm.yyyy'));
      END;

      RETURN p_ret;
   END XX;
-------------------------
BEGIN
   IF    :new.vob <> 96                                              --�� ����
      OR :new.tt IN ('ARE', 'AR*')                                   -- ������
      OR :new.TT = 'IRR' AND :new.ND = 'FV9' -- �������� � Finevare. �������� ������ �� ���� ����������
      OR TRUNC (:new.vdat, 'MM') = TRUNC (gl.bdate, 'MM') -- �� �������, �.� � ����� ������
   THEN
      RETURN;
   END IF;

   oo.vdat := :new.vdat;
   oo.kv := :new.kv;
   oo.mfoA := :new.mfoA;
   oo.nlsA := :new.nlsA;
   oo.kv2 := :new.kv2;
   oo.mfoB := :new.mfoB;
   oo.nlsB := :new.nlsB;
   ----------------------

   --l_T0 := pul.GET ('YES_T0');
   IF l_T0 IS NULL or l_T0 = '0'
   THEN
      l_T0 := barsupl.is_T0_OK (TRUNC (SYSDATE)); -- ��������� ����������� ����������� � ���.����������
      --   pul.put ('YES_T0', l_T0);
   END IF;

   IF oo.MfoA = gl.aMfo
   THEN
      l_Ret := XX (oo.kv, oo.nlsA);
   END IF;

   IF oo.MfoB = gl.aMfo
   THEN
      l_Ret := XX (oo.kv2, oo.nlsB);
   END IF;
END TBIU_OPER_ZO;
/
ALTER TRIGGER BARS.TBIU_OPER_ZO ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBIU_OPER_ZO.sql =========*** End **
PROMPT ===================================================================================== 
