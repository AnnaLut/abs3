begin
  begin
    insert into cp_pf1_pf2(pf1, pf2)
    values(4 , 1);
  exception
    when dup_val_on_index then
      null;
  end;
end;
/

begin
  begin
    insert into cp_pf1_pf2(pf1, pf2)
    values(4 , 3);
  exception
    when dup_val_on_index then
      null;
  end;
end;
/

begin
  begin
    insert into cp_pf1_pf2(pf1, pf2)
    values(1 , 4);
  exception
    when dup_val_on_index then
      null;
  end;
end;
/

begin
  begin
    insert into cp_pf1_pf2(pf1, pf2)
    values(3 , 4);
  exception
    when dup_val_on_index then
      null;
  end;
end;
/

begin
  begin
    insert into cp_pf1_pf2(pf1, pf2)
    values(2 , 4);
  exception
    when dup_val_on_index then
      null;
  end;
end;
/

begin
  begin
    insert into cp_pf1_pf2(pf1, pf2)
    values(2 , 2);
  exception
    when dup_val_on_index then
      null;
  end;
end;
/

commit;