begin

   tuda;
   
       for k in ( select unique c.rnk, p.okpo
                  from customer c, CUST_PTKC p
                  where c.rnk in (select rnk
                                  from accounts 
                                  where nls like '2909%' 
                                    and kv = 980 
                                    and ob22 = '43') 
                    and c.okpo = p.okpo
                ) 
       loop
  
          update CUST_PTKC set rnk = k.rnk 
           where okpo = k.okpo;
      
       end loop;

   commit;

end;
/           
           
