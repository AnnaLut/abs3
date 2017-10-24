

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/LT_AD_34.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  trigger LT_AD_34 ***

  CREATE OR REPLACE TRIGGER BARS.LT_AD_34 
     AFTER DELETE ON BARS.POLICY_GROUPS
     FOR EACH ROW
     DECLARE
       dummy             integer;   
       dependent_rows    boolean;
       ricLockStatus     integer;
       dummyLockStatus   integer;  
     BEGIN
       wmsys.lt_ctx_pkg.initializeRicLockingVars;ricLockStatus := wmsys.lt_ctx_pkg.request(10000001,3, wmsys.lt_ctx_pkg.MAXWAIT, true);
       if ( ricLockStatus = 0 ) then
          wmsys.lt_ctx_pkg.addToRicLocksList( 'BARS.POLICY_GROUPS', 'RE' );
       else 
          if ( ricLockStatus = 4 ) then
             if ( wmsys.lt_ctx_pkg.hasRicLockOn('BARS.POLICY_GROUPS', 'S')) then
                ricLockStatus := wmsys.lt_ctx_pkg.request(10000002, 6, 0, true);
                if ( ricLockStatus != 0 and ricLockStatus != 4 ) then 
                   WMSYS.WM_ERROR.RAISEERROR(WMSYS.LT.WM_ERROR_171_NO, 'deadlock detected while trying to acquire lock on BARS.POLICY_GROUPS'); 
                end if;
                ricLockStatus := wmsys.lt_ctx_pkg.convert(10000001, 6, wmsys.lt_ctx_pkg.MAXWAIT);
                if ( ricLockStatus != 0 ) then 
                   dummyLockStatus := wmsys.lt_ctx_pkg.release(10000002);
                   WMSYS.WM_ERROR.RAISEERROR(WMSYS.LT.WM_ERROR_171_NO, 'error while trying to acquire lock on BARS.POLICY_GROUPS, status = ' || ricLockStatus ); 
                end if;
             end if;
          else 
             WMSYS.WM_ERROR.RAISEERROR(WMSYS.LT.WM_ERROR_171_NO, 'error while trying to acquire lock on BARS.POLICY_GROUPS, status = ' || ricLockStatus ); 
          end if;
      end if; Begin dependent_rows := true; SELECT 1 Into dummy FROM dual WHERE EXISTS ( SELECT 1 FROM BARS.POLICY_TABLE_LT WHERE ((:OLD.POLICY_GROUP = POLICY_GROUP)) AND delstatus >= 0); EXCEPTION When NO_DATA_FOUND Then dependent_rows := false; When OTHERS Then Raise; End; Begin if (dependent_rows) then WMSYS.WM_ERROR.RAISEERROR(WMSYS.LT.WM_ERROR_5_NO, 'BARS', 'FK_POLICYTABLE_POLICYGROUPS'); end if; end; null; END;
/
ALTER TRIGGER BARS.LT_AD_34 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/LT_AD_34.sql =========*** End *** ==
PROMPT ===================================================================================== 
