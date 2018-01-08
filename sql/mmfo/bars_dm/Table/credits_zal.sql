begin
    execute immediate 'create table credits_zal(  per_id number, 
                                                  kf varchar2(6),
                                                  nd number,
                                                  vidd_name varchar2(250),
                                                  rnk number,
                                                  rel_type varchar2(30),
                                                  zal_sum number ) tablespace brsdynd';
exception
    when others then
        if sqlcode = -955 then null; else raise; end if;
end;
/

begin   
 execute immediate '
  CREATE INDEX BARS_DM.I_CRED_ZAL_PERID ON BARS_DM.CREDITS_ZAL (PER_ID) 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

grant SELECT on bars_dm.credits_zal to BARS;
grant SELECT on bars_dm.credits_zal to barsupl;