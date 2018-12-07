begin
execute immediate'drop index IND_W4_ACC_INST_CH_IDT';
exception when others then
if sqlcode = -01418 then null; else raise; end if;
end;
/