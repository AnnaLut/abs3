

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBIU_OPER_ZO.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBIU_OPER_ZO ***

  CREATE OR REPLACE TRIGGER BARS.TBIU_OPER_ZO 
   --09.11.2016 Sta Разрешить корр для SNA (Finevare)
   --07.11.2016 Sta Не проверять  счет-Б для нач.МБ ( это есть в модуле CIN). Проверять : Внутр и Ответные
   BEFORE INSERT OR UPDATE
   ON BARS.OPER    FOR EACH ROW
DECLARE
   l_T0    VARCHAR2 (1) := 0 ;        -- = 1 -  Если Т0 уже сформировант за отч.дату
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
            raise_application_error ( -20096, 'Заборона на введення корр по рах.' || p_nls
                                                                                  || ' по причині Т0 !');
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
                  'Рахунок '
               || p_kv
               || '/'
               || p_nls
               || ' НЕ відкрито до '
               || TO_CHAR (l_Dat01, 'dd.mm.yyyy'));
      END;

      RETURN p_ret;
   END XX;
-------------------------
BEGIN
   IF    :new.vob <> 96                                              --не корр
      OR :new.tt IN ('ARE', 'AR*','RXP')     -- резерв, переоц.ЦБ на суму резерву
      OR :new.TT = 'IRR' AND :new.ND = 'FV9' -- Отримано з Finevare. Корекція доходів на суму НЕвизнаних
      OR TRUNC (:new.vdat, 'MM') = TRUNC (gl.bdate, 'MM') -- не переход, т.е в одном месяце
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
      l_T0 := barsupl.is_T0_OK (TRUNC (SYSDATE)); -- исключаем возможность манипуляции с лок.банкюдатой
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
