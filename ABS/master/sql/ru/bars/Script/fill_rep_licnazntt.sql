begin
insert into rep_licnazntt(TT) values  ('ISG');
EXCEPTION WHEN dup_val_on_index THEN null;
END;
/
begin
insert into rep_licnazntt(TT) values  ('NE3');
EXCEPTION WHEN dup_val_on_index THEN null;
END;
/
begin
insert into rep_licnazntt(TT) values  ('KK1');
EXCEPTION WHEN dup_val_on_index THEN null;
END;
/
begin
insert into rep_licnazntt(TT) values  ('%%1');
EXCEPTION WHEN dup_val_on_index THEN null;
END;
/
begin
insert into rep_licnazntt(TT) values  ('KK2');
EXCEPTION WHEN dup_val_on_index THEN null;
END;
/
begin
insert into rep_licnazntt(TT) values  ('IB1');
EXCEPTION WHEN dup_val_on_index THEN null;
END;
/
begin
insert into rep_licnazntt(TT) values  ('ZAL');
EXCEPTION WHEN dup_val_on_index THEN null;
END;
/
begin
insert into rep_licnazntt(TT) values  ('ASG');
EXCEPTION WHEN dup_val_on_index THEN null;
END;
/
begin
insert into rep_licnazntt(TT) values  ('ASP');
EXCEPTION WHEN dup_val_on_index THEN null;
END;
/
commit;