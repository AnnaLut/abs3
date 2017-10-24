

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_SAL_B.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_SAL_B ***

  CREATE OR REPLACE TRIGGER BARS.TU_SAL_B 
   -- Clears temp variables aiming next tu_sal fires
   -- VER  tu_sal.sql 5.0.0.0 03/14/04
   -- KF      -- для мульти-МФО схемы с полем KF
   BEFORE INSERT OR UPDATE OF dapp, ostc, ostq
   ON accounts
BEGIN
   gl.val.a_acc := NULL;
   gl.val.a_ost := NULL;
   gl.val.b_ost := NULL;
   gl.val.a_ostq := NULL;
   gl.val.b_ostq := NULL;
END;



/
ALTER TRIGGER BARS.TU_SAL_B ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_SAL_B.sql =========*** End *** ==
PROMPT ===================================================================================== 
