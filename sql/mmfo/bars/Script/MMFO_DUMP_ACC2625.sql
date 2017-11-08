begin
  bc.go('/');
   For k in  (select rnk, kf from bars.customer where custtype=3 and date_off is null order by rnk)
    
     loop --k
  
        INSERT INTO bars.ead_sync_queue (id, crt_date, type_id, obj_id, status_id, kf)
            values(bars.S_EADSYNCQUEUE.nextval, date '2000-01-01', 'CLIENT', to_char(k.rnk), 'OUTDATED', k.kf);
        For k1 in (select w4.nd FROM bars.w4_acc w4 join bars.accounts acc on W4.ACC_PK = acc.acc and acc.nbs = '2625' where acc.rnk=k.rnk ORDER BY w4.nd) 
         loop  --k1
            INSERT INTO bars.ead_sync_queue (id, crt_date, type_id, obj_id, status_id, kf)
                values( bars.S_EADSYNCQUEUE.nextval, date '2000-01-01', 'AGR', 'WAY;' || to_char(k1.nd), 'OUTDATED', k.kf);
         end loop;
       
     end loop ;
  commit work; 
end;
/