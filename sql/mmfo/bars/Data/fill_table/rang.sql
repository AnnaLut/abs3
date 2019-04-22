prompt fill rang
begin
    insert into rang (rang, name) values (13, 'Закриваються, як неактивні, за рішенням банку');
    commit;
exception
    when dup_val_on_index then null;
end;
/