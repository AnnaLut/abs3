begin
   for k in (select r.rowid ri, r.* from nbu23_rez r where r.fdat=to_date('01-01-2018','dd-mm-yyyy')) 
   LOOP
      update nbu23_rez set ddd_6b = f_ddd_6B(k.nbs) where rowid = k.RI ;
   end loop;
   commit;
end;
/