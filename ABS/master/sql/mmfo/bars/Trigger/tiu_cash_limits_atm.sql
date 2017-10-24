

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_CASH_LIMITS_ATM.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_CASH_LIMITS_ATM ***

  CREATE OR REPLACE TRIGGER BARS.TIU_CASH_LIMITS_ATM 
INSTEAD OF UPDATE OR INSERT ON BARS.V_CASH_LIMITS_ATM FOR EACH ROW
BEGIN

  bars_audit.info( 'V_CASH_LIMITS_ATM: acc='||to_char(:new.ACC)||', LIM_DATE='||to_char(:new.LIM_DATE,'dd/mm/yyyy')||
                   ', lim_current='||to_char(:new.LIM_CURRENT) );

  If updating Then

    update CASH_LIMITS_ATM
       set LIM_CURRENT = :new.LIM_CURRENT,
           LIM_MAX     = :new.LIM_MAX
     where ACC         = :new.ACC
       and LIM_DATE    = :new.LIM_DATE;

    If (sql%rowcount = 0) Then
      insert into CASH_LIMITS_ATM
        ( ACC, LIM_DATE, LIM_CURRENT, LIM_MAX )
      values
        ( :new.ACC, :new.LIM_DATE, :new.LIM_CURRENT, :new.LIM_MAX );
    End If;
  Else
    insert into CASH_LIMITS_ATM
      ( ACC, LIM_DATE, LIM_CURRENT, LIM_MAX )
    values
      ( :new.LIM_ACC, :new.LIM_DATE, :new.LIM_CURRENT, :new.LIM_MAX );
  End If;

END;


/
ALTER TRIGGER BARS.TIU_CASH_LIMITS_ATM ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_CASH_LIMITS_ATM.sql =========***
PROMPT ===================================================================================== 
