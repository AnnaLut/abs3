set timing on;
set serveroutput on size 1000000
declare
i_ pls_integer;
Begin
 For k in (   select * from mv_kf )
LOOP 
      
    bars.bc.go(k.kf);
    dbms_application_info.set_client_info('ÌÔÎ >'||k.kf); 
    i_ := 0;
           
    for cc in (
                with t_nd_hist as 
                      (  Select fdat, nd, rnk, sum(case when kod = 'CLS' then s else 0 end) fin, sum(case when kod = 'PD' then s else 0 end) pd
                         from bars.fin_nd_hist k
                        where kod in ('CLS','PD')  and idf = 60
                          and (nd, rnk) in (select nd, rnk from bars.cc_deal where sos < 15 and vidd in (11,12,13) )
                          and (rnk,nd,fdat) in (select rnk, nd, max(fdat) from bars.fin_nd_hist where nd = k.nd and rnk = k.rnk and idf = 60 and kod in ('CLS','PD')  group by rnk, nd)
                          group by fdat, nd, rnk
                      ),
                     t_nd  as 
                      (
                         Select max(fdat) fdat, nd, rnk, sum(case when kod = 'CLS' then s else 0 end) fin, sum(case when kod = 'PD' then s else 0 end) pd
                         from bars.fin_nd k
                        where kod in ('CLS','PD')  and idf = 60
                          and (nd, rnk) in (select nd, rnk from bars.cc_deal where sos < 15 and vidd in (11,12,13) )
                          group by nd, rnk
                       )     
                 Select n.fdat, n.ND, n.RNK, n.FIN, n.PD, h.FDAT fdat_h, h.FIN as FIN_H, h.pd as pd_h
                  from t_nd n
                       join t_nd_hist h on  n.nd = h.nd and n.rnk = h.rnk    
                  where n.fin != h.fin             
                ) 
      loop
         update fin_nd
            set s   = cc.FIN_H
          where nd  = cc.nd 
            and rnk = cc.rnk
            and kod = 'CLS'
            and idf = 60;
        
        i_ := i_+1;
        
        dbms_application_info.set_client_info('ÌÔÎ >'||k.kf||' count='||i_);
                      
      end loop;
      
      dbms_output.put_line('MFO >'||k.kf||' count='||i_);     
END LOOP;
  
  commit; 
  bars.bc.home;
END;
/