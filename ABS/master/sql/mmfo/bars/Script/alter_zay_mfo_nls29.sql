begin
  execute immediate 'alter table zay_mfo_nls29 add nls6114 varchar2(16)';
exception when others then
  if sqlcode = -01430 then null; else raise; end if;
end;
/
update zay_mfo_nls29 
set nls6114='61140001'
where mfo='322669';
/
update zay_mfo_nls29 
set nls6114='61145010101078'
where mfo='300465';
/
commit;
/