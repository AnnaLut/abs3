begin execute immediate'
   create sequence bars.s_zp_deals start with 1000';
exception when others then  
  if sqlcode = -00955 then null;   else raise; end if;   
end;
/