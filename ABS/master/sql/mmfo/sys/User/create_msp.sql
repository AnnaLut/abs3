-- Create the user 
begin
  execute immediate 'create user MSP
                     identified by msp
                     default tablespace USERS
                     temporary tablespace TEMP';
  exception when others then
    if (sqlcode = 1920) then null; end if;
end;
/
-- Grant/Revoke object privileges 
grant select on BARS.ACCOUNTS to MSP with grant option;
grant execute on BARS.BARS_AUDIT to MSP;
grant execute on BARS.BARS_CONTEXT to MSP;
grant execute on BARS.BARS_ERROR to MSP;
grant execute on BARS.BARS_LOGIN to MSP;
grant execute on BARS.CRYPTO_UTL to MSP;
grant select on BARS.CUSTOMER to MSP with grant option;
grant execute on BARS.IMPORT_FLAT_FILE to MSP;
grant execute on BARS.LOB_UTL to MSP;
grant select on BARS.MV_KF to MSP;
grant execute on BARS.NUMBER_LIST to MSP;
grant select on BARS.OPER to MSP with grant option;
grant select on BARS.OPER_VISA to MSP with grant option;
grant select, insert, update, delete on BARS.TMP_IMP_FILE to MSP;
grant execute on BARS.TOOLS to MSP;
grant execute on BARS.USER_ID to MSP;
grant execute on BARS.WSM_MGR to MSP;
grant select on PFU.PFU_PENSACC to MSP;
grant select on PFU.PFU_PENSIONER to MSP;
grant select on PFU.PFU_PENS_BLOCK_TYPE to MSP;
grant select on PFU.PFU_SYNCRU_PARAMS to MSP;
grant execute on PFU.PFU_UTL to MSP;
grant execute on PFU.TRANSPORT_UTL to MSP;
grant select on PFU.V_PFU_PENSACC to MSP with grant option;
-- Grant/Revoke role privileges 
grant connect to MSP;
-- Grant/Revoke system privileges 
grant create job to MSP;
grant create procedure to MSP;
grant create sequence to MSP;
grant create table to MSP;
grant create type to MSP;
grant create view to MSP;
grant debug connect session to MSP;
grant exempt access policy to MSP;