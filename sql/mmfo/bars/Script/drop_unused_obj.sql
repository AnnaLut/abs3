begin
   execute immediate 'drop procedure cck_del6';
exception when others then       
  if sqlcode=-4043 then null; else raise; end if; 
end; 
/



begin
   execute immediate 'drop table "S6_Contract_V"';
exception when others then       
  if sqlcode=-942 then null; else raise; end if; 
end; 
/




begin
   execute immediate 'drop package CDB_MEDIATOR2';
exception when others then       
  if sqlcode=-942 then null; else raise; end if; 
end; 
/



begin
   execute immediate 'drop package INTEREST_UTL2';
exception when others then       
  if sqlcode=-942 then null; else raise; end if; 
end; 
/



begin
   execute immediate 'drop procedure NBU_2017_11';
exception when others then       
  if sqlcode=-942 then null; else raise; end if; 
end; 
/



begin
   execute immediate 'drop procedure NBU_2017_01_ARC';
exception when others then       
  if sqlcode=-942 then null; else raise; end if; 
end; 
/


begin
   execute immediate 'drop procedure NBU_2017_01';
exception when others then       
  if sqlcode=-942 then null; else raise; end if; 
end; 
/



begin
   execute immediate 'drop procedure MGR_BRATES';
exception when others then       
  if sqlcode=-942 then null; else raise; end if; 
end; 
/

begin
   execute immediate 'drop view "S6_Contract_V"';
exception when others then       
  if sqlcode=-942 then null; else raise; end if; 
end; 
/


begin
   execute immediate 'drop view V_INTEREST_TO_PAYMENT2';
exception when others then       
  if sqlcode=-942 then null; else raise; end if; 
end; 
/



begin
   execute immediate 'drop view V_INTEREST_TO_PAYMENT2';
exception when others then       
  if sqlcode=-942 then null; else raise; end if; 
end; 
/

