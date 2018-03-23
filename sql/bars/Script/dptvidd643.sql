begin
    update dpt_vidd set flag=0 where kv = 643;
exception 
 when dup_val_on_index then null;
end;
/

commit;
