
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_workday.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_WORKDAY (dat_   IN DATE,
                                           tp_    IN NUMBER DEFAULT 0)
   RETURN DATE
IS
   -------------------------------------------------------------------------------------------------
   -- ������� ���������� ������� ���� (���� dat_ �� �������, �� ���� ���� ������������ ����� tp_: --
   -- ���� tp_ > 0, �� ���� ���� ������, � tp_ < 0 - ����� �� �������� ����                       --
   -------------------------------------------------------------------------------------------------
   dtWork_   DATE := dat_;
   cnt_      NUMBER;
BEGIN
   LOOP
      SELECT COUNT (*)
        INTO cnt_
        FROM holiday
       WHERE kv = 980 AND HOLIDAY = dtWork_;

      IF cnt_ = 0
      THEN
         EXIT;
      ELSE
         IF tp_ = 0
         THEN
            dtWork_ := NULL;
            EXIT;
         END IF;

         dtWork_ := dtWork_ + tp_;
      END IF;
   END LOOP;

   RETURN dtWork_;
END;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_workday.sql =========*** End *** 
 PROMPT ===================================================================================== 
 