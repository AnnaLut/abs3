BEGIN
<<KF>>        
  for k in ( select * from mv_kf )
LOOP
     bc.go('/'||k.kf||'/'); 
 
    <<FINFM>>  
    for x0 in (  Select f.okpo, f.fdat 
                   from fin_fm f
                  where okpo in ( select okpo from customer k, cc_deal d 
                                    where vidd between 1 and 3  and d.rnk = k.rnk )
                    and f.fdat between ADD_MONTHS(to_date('01-07-2017','dd-mm-yyyy'),-15) and to_date('01-07-2017','dd-mm-yyyy')
               ) 
     loop
            
            <<AGR>>  
            for k in ( 
                      select k.kod, k.idf,  fin_obu.CALC_POK_DOP(k.kod,m.fdat,m.okpo,2) ss
                        from fin_fm m, fin_kod k 
                       where okpo = X0.OKPO and fdat= X0.FDAT
                         and k.idf between 11 and 13
                       order by k.idf, k.ord )
            loop
              fin_nbu. record_fp(KOD_   => k.kod, 
                                 S_     => k.ss,  
                                 IDF_   => k.idf,
                                 DAT_   => x0.fdat,
                                 OKPO_  => x0.okpo);
            end loop AGR;
            
            
    END LOOP FINFM;        
     commit;
  END LOOP KF;    

END;
/          
