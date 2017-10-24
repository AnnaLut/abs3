begin 
  bpa.alter_policy_info('MWAY_MAPPING_BRANCH', 'WHOLE',  null,  null, null, null); 
end;
/
begin 
  bpa.alter_policy_info('MWAY_MAPPING_BRANCH', 'FILIAL',  null,  null, null, null); 
end;
/
begin
  execute immediate 'create table mway_mapping_branch(
                            mfo varchar2(8) primary key,
                            appcode varchar2(8),
                            rolecode varchar2(1)
                     )';
exception
  when others then
    if sqlcode = -955 then
      null;
    else 
      raise;
    end if;
end;
/