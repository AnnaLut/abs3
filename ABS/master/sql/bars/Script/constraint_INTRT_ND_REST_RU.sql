PROMPT *** Create  constraint CC_ACCOUNTSW_TAG ***
begin
  execute immediate 'alter table accountsw
  add constraint accountsw_tag
  check ((tag IN (''INTRT'',''ND_REST'') and (value between 0 and 100 or tag is null)) or tag not IN (''INTRT'',''ND_REST''))';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/

PROMPT *** Create  constraint CC_BPK_PARAMETERS_TAG***
begin
  execute immediate 'alter table bpk_parameters
  add constraint bpk_parameters_tag
  check ((tag IN (''INTRT'',''ND_REST'') and (value between 0 and 100 or tag is null)) or tag not IN (''INTRT'',''ND_REST''))';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/
prompt  *** Create  constraint CC_ND_TXT_TAG *** 
begin
    execute immediate 'alter table ND_TXT
  add constraint ND_TXT_TAG
  check ((tag IN (''INTRT'',''ND_REST'') and (txt between 0 and 100 or tag is null)) or tag not IN (''INTRT'',''ND_REST''))';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


