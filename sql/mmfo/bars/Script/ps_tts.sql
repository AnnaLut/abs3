
begin
       insert into ps_tts ( TT, NBS, DK, OB22) values ('328', '2625', 1, null);
       exception  when dup_val_on_index then null;
end;
/
commit;
