prompt fill FM_POSS

begin
begin
insert into fm_poss (id, name) values (1, '�����');
exception
when dup_val_on_index then null;
end;
begin
insert into fm_poss (id, name) values (2, '³�����');
exception
when dup_val_on_index then null;
end;
commit;
end;
/