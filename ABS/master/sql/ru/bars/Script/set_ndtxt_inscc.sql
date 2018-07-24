begin
 for k in (select * from mv_kf)
 loop
   bc.go(k.kf);
   for d in (select * from cc_deal where vidd in (1,2,3,11,12,13,110,10) and sos >0 and sos < 15)
   loop
       if substr(d.prod,1,6) in ('220346', '220347', '220348', '220372', '220373', '220374') then
         CCK_APP.SET_ND_TXT(d.nd,'INSCC','Taê');
       else
         CCK_APP.SET_ND_TXT(d.nd,'INSCC','Í³'); 
       end if;
   end loop;   
 end loop;
 bc.home;
end;
/

commit;