-- замена параметра K072 на новые значения которые будут действовать 
-- c 01.01.2018
-- параметр K072 на 01.01.2018 2-х значный 

exec bc.home;  

begin
    for z in ( select kf from mv_kf )
    loop

        bc.subst_mfo(z.kf);

       dbms_output.put_line(' UPDATE_SPECPARAM K072 '); 

       for k in ( select sp.acc, sp.k072 
                  from specparam sp  
                  where sp.k072 = '41' 
                    and sp.acc in ( select a.acc 
                                    from accounts a, customer c 
                                    where ( a.nls like '262%' or a.nls like '263%' or 
                                            a.nls like '220%' or a.nls like '223%' 
                                          )
                                      and a.dazs is null
                                      and a.rnk = c.rnk
                                      and c.custtype = 3
                                      and c.codcagent = 5
                                      and c.ise in ('14101','14201','14300','14410','14420','14430')
                                  )
                )

          loop

             update specparam sp1 set sp1.K072 = '42' 
             where sp1.acc = k.acc and sp1.k072 = '41';

             commit;

         end loop;

  commit;

   end loop;
end;
/


