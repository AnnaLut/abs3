

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/LT_AU_35.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  trigger LT_AU_35 ***

  CREATE OR REPLACE TRIGGER BARS.LT_AU_35 
     AFTER UPDATE ON BARS.POLICY_GROUPS
     FOR EACH ROW
     DECLARE
       dummy             integer;   
       dependent_rows    boolean;
       needToFire        boolean;
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
      end if;needToFire := false;if ( :OLD.POLICY_GROUP is null and :NEW.POLICY_GROUP is not null ) then needToFire := true; else if ( :OLD.POLICY_GROUP is not null and :NEW.POLICY_GROUP is null ) then needToFire := true; else if ( :NEW.POLICY_GROUP != :OLD.POLICY_GROUP) then needToFire := true; end if; end if; end if; If (needToFire) Then Begin dependent_rows := true; SELECT 1 Into dummy FROM dual WHERE EXISTS ( SELECT 1 FROM BARS.POLICY_TABLE_LT WHERE ((:OLD.POLICY_GROUP = POLICY_GROUP)) AND delstatus >= 0); EXCEPTION When NO_DATA_FOUND Then dependent_rows := false; When OTHERS Then Raise; End; BEGIN if ( dependent_rows ) then WMSYS.WM_ERROR.RAISEERROR(WMSYS.LT.WM_ERROR_5_NO, 'BARS', 'FK_POLICYTABLE_POLICYGROUPS'); end if; END; end if; null; END;
/
ALTER TRIGGER BARS.LT_AU_35 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/LT_AU_35.sql =========*** End *** ==
PROMPT ===================================================================================== 
