begin
   bars.bc.go('/');
   for c in (
	           select a.kf
                      , a.nls    nls_new
                      , a.nlsalt nls_old
               from bars.accounts a
               join pfu.pfu_pensacc pa on pa.kf = a.kf and pa.nls = a.nlsalt
               where a.nbs2 = '2625'
	        )
   loop
            update pfu.pfu_pensacc t
            set t.nls = c.nls_new
                , t.nlsalt = c.nls_old
            where t.nls = c.nls_old
                  and t.kf = c.kf;
   end loop;     
   bars.bc.home;
end;
