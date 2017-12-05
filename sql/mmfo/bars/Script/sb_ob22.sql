declare
sb    sb_ob22%rowtype;
ps_n  ps%rowtype;
begin
   for k in (select distinct nbs_rez,ob22_rez from srezerv_ob22_f)
   LOOP
      begin
         select * into sb from sb_ob22 where r020=k.nbs_rez and ob22=k.ob22_rez;
      EXCEPTION WHEN NO_DATA_FOUND THEN 
         insert into sb_ob22 (r020, ob22) values (k.nbs_rez, k.ob22_rez);
      end;
   end LOOP;
   commit;
   begin
      select * into ps_n from ps where nbs = '2609';
   EXCEPTION WHEN NO_DATA_FOUND THEN 
      insert into ps (nbs,name) values ('2609','Резерв за коштами на вимогу суб’єктів господарювання');
   end;
   begin
      select * into ps_n from ps where nbs = '2629';
   EXCEPTION WHEN NO_DATA_FOUND THEN 
      insert into ps (nbs,name) values ('2629','Резерв за коштами на вимогу фізичних осіб');
   end;
   begin
      select * into ps_n from ps where nbs = '3692';
   EXCEPTION WHEN NO_DATA_FOUND THEN 
      insert into ps (nbs,name) values ('3692','Резерви за кредитними зобов’язаннями');
   end;
   commit;
end;
/

      