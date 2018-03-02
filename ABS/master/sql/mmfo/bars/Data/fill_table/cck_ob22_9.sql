declare
l_cn integer;
begin
   select count(*) into l_cn from cck_ob22_9;
   if l_cn = 0 THEN
      begin 
         EXECUTE IMMEDIATE ' insert into cck_ob22_9 (nbs, ob22)        select nbs, ob22 from cck_ob22 where  D_CLOSE is null';
      end;
   end if;
end;
/  