BEGIN
    bc.go('/'); 

    for rec in (select kf from mv_kf)
        loop
            bc.go(rec.kf);
            For i in (select d.deposit_id, d.branch, a.nls, d.kf
		                   from bars.dpt_deposit d, bars.accounts a 
                       where a.nlsalt = d.nls_d and a.kf = d.mfo_d
                       and a.kv = d.kv and d.nls_d like '2635%'
                       and (d.dat_end >= sysdate or d.dat_end is null)
                      ) loop

                update dpt_deposit set nls_d = i.nls where deposit_id = i.deposit_id;
            
            end loop;
        end loop;
   bc.home;
END;
/
