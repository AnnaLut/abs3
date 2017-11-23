begin
  insert into op_field(tag, name, use_in_arch)
       values ('ATT_D',' л≥Їнт надав супров≥дн≥ док. в CORP', 0);
exception
  when dup_val_on_index then null;
end;
/

commit;
