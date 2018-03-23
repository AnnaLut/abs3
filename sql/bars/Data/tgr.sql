begin
insert into tgr(name, tgr)
values ('5 - ќкремий ƒерж. реЇстр платник≥в податк≥в', 5);
exception
when dup_val_on_index then null;
end;
/
commit;
/