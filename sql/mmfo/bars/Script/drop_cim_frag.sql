/* Для тестового полігону 
   для проду вже буде не потрібен
*/
begin
  execute immediate 'drop table cim_contracts_fragmentation';
  exception 
    when others then
      null;
end;
/

begin 
  update  cim_contracts_trade set is_fragment = 0  where is_fragment = 1;
end;
/

-- Drop columns 
begin
  execute immediate 'alter table CIM_CONTRACTS_TRADE drop column fragment_chg_date';
  exception 
    when others then
      null;
end;
/

begin
  execute immediate 'alter table CIM_CONTRACTS_TRADE drop column fragment_chg_userid';
  exception 
    when others then
      null;
end;
/
