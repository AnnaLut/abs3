begin
bpa.alter_policy_info('BANK_MON','WHOLE',null,'E','E',null);
bpa.alter_policy_info('BANK_MON','FILIAL','F','F','F','F');
bpa.alter_policies('BANK_MON');
end;
/
commit;