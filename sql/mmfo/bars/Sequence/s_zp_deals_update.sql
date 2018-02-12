begin execute immediate'
   create sequence bars.s_zp_deals_update start with 1';
exception when others then  
  if sqlcode = -00955 then null;   else raise; end if;   
end;
/