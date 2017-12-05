prompt ##############################################
prompt 1. Зміни в структурі таблиць та Їх БМД
prompt ##############################################
----------------------------------------
begin EXECUTE IMMEDIATE 'alter table bars.CP_ACCC add ( D_Close date) ';
exception when others then   if SQLCODE = -01430 then null;   else raise; end if;   -- ORA-01430: column being added already exists in table
end;
/
COMMENT ON COLUMN BARS.CP_ACCC.D_Close IS 'Дата закр Суб.Портф';
------------------------------------------------
begin EXECUTE IMMEDIATE 'alter table bars.CP_RYN add ( D_Close date) ';
exception when others then   if SQLCODE = -01430 then null;   else raise; end if;   -- ORA-01430: column being added already exists in table
end;
/

COMMENT ON COLUMN BARS.CP_RYN.D_Close IS 'Дата закр Суб.Портф';

