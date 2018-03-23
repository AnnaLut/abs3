-- Add/modify columns 
begin
    execute immediate 'alter table MBM_REL_CUSTOMERS add doc_date_to DATE';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 

-- Add comments to the columns 
comment on column MBM_REL_CUSTOMERS.doc_date_to
  is 'дата до якої дійсносна ID-картка';