begin
tuda;
for k in (select a.acc,t.r013 r013_new from accounts a,TMP_NBS_OB22_R013 t
          where a.nbs||a.ob22 = t.nbs||t.ob22 and ostc <>0 )
LOOP
   update specparam  set r013 = k.r013_new where acc=k.acc;
   IF SQL%ROWCOUNT=0 then
      insert into specparam (acc, R013) values (k.acc, k.R013_new);
   end if;
end loop;
commit;
suda;
end;
/

