declare 
tb_id number;
begin 
  select distinct tabid into tb_id  from bars.meta_tables where tabname='V_CORE_PLEDGE_DEP';
  update bars.meta_columns set coltype='C' where colname='FLAGINSURANCEPLEDGE' and tabid=tb_id;
end;
/