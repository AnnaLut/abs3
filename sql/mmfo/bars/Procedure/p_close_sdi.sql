CREATE OR REPLACE PROCEDURE BARS.p_close_sdi ( p_kf varchar2)  IS

begin
   delete from REZ_CLOSE_SDI where kf = p_kf;
   for k in (select a.kf, d.sos, d.nd, a.acc, a.nls, a.kv, a.tip, a.ostc, a.dazs  from cc_deal d, nd_acc n,accounts a 
              where d.nd in (select nd from (select d.nd, sum(ostc) s from cc_deal  d, nd_acc n,accounts a 
                                             where d.nd in (select distinct d.nd from cc_deal d, nd_acc n,accounts a 
                                                            where d.nd=n.nd and n.acc=a.acc and tip in ('SNA','SDF','SDA','SDI','SDM') and ostc<>0) 
                                                   and  d.nd=n.nd and n.acc=a.acc and tip in ('SS ','SP ','SN','SNO','SPN')  
                                             group by d.nd  )
                             where s=0)
                    and d.nd=n.nd and n.acc= a.acc          
              order by nd  )
   LOOP
      insert into REZ_CLOSE_SDI (fdat, kf, sos, nd, acc, nls, kv, tip, ostc, dazs) 
                         values (sysdate, k.kf, k.sos, k.nd, k.acc, k.nls, k.kv, k.tip, k.ostc, k.dazs);
   end loop;
end;
/
show err;

PROMPT *** Create  grants  p_close_sdi ***
grant EXECUTE       on p_close_sdi     to BARS_ACCESS_DEFROLE;
grant EXECUTE       on p_close_sdi     to RCC_DEAL;
grant EXECUTE       on p_close_sdi     to START1;



