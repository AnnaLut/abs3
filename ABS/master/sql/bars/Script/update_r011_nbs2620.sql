-- замена параметра R011 co значения "1" на значение "3" 
-- для бал.счета 2620 OB22=14, 15, 16, 18, 23, 24, 25, 26, 27 

exec bc.home;  

begin
    for z in ( select kf from mv_kf)
    loop

        bc.subst_mfo(z.kf);

       dbms_output.put_line(' UPDATE_SPECPARAM R011 '); 

       for k in ( select sp.acc, sp.R011 
                  from specparam sp  
                  where sp.R011 = '1' 
                    and sp.acc in ( select a.acc 
                                    from accounts a 
                                    where a.nls like '2620%' 
                                      and a.dazs is null
                                      and a.ob22 in ('14', '15', '16', '18', 
                                                     '23', '24', '25', '26', '27'
                                                    )
                                  )
                )

          loop

             update specparam sp1 set sp1.R011 = '3' 
             where sp1.acc = k.acc and sp1.R011 = '1';

             commit;

         end loop;

  commit;

   end loop;
end;
/


