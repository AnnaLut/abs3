begin 
   tuda;
   update xoz_ref_arc set mdat=to_date('02-03-2018','dd-mm-yyyy') 
   where mdat = to_date('01-03-2018','dd-mm-yyyy') and id in (select nd from nbu23_rez where fdat=to_date('01-03-2018','dd-mm-yyyy') and bv=0 );
   update nd_val set fdat=to_date('02-03-2018','dd-mm-yyyy') where fdat= to_date('01-03-2018','dd-mm-yyyy') and nd in (
   select nd from nbu23_rez where fdat=to_date('01-03-2018','dd-mm-yyyy') and bv=0);
   commit;
end;
/



