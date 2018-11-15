PROMPT *** Create  procedure MV_PAY_DATE  ***

CREATE OR REPLACE procedure BARS.MV_PAY_DATE (p_kf in varchar2) is

begin
   if sys_context( 'bars_context', 'user_branch' ) = '/'
   then
   begin 
     bars_audit.info('Start MV_PAY_DATE:'||p_kf);
     bars.bc.go(p_kf);
     bars.pay_date(gl.bd);
     bars.bc.home;
   end;
   else raise_application_error(-20000, 'Виконання процедури заборонено! Перейдіть на "/"  ' );
     end if;
end;
/
show err;

PROMPT *** Create  grants  PAYTT ***

grant EXECUTE on MV_PAY_DATE to BARS_ACCESS_DEFROLE;

