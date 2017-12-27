begin
   for m in (select * from mv_kf)
   LOOP 
      bc.go(m.kf);
      for k in (select a.acc,decode(t.r013,5,3,4,2) r013_new from accounts a,TMP_NBS_OB22_R013 t
                where a.nbs||a.ob22 = t.nbs||t.ob22 and ostc <>0 and a.nbs='3599')
      LOOP
         update specparam  set r013 = k.r013_new where acc=k.acc;
         IF SQL%ROWCOUNT=0 then
            insert into specparam (acc, R013) values (k.acc, k.R013_new);
         end if;
      end loop;
      commit;
   end loop;
   commit; 
   bc.go('/'); 
end;
/

