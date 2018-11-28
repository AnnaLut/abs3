 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BILLS/table/wsm_params.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 prompt create table WSM_PARAMS
 begin
 execute immediate '
  CREATE TABLE BILLS.WSM_PARAMS 
   ("PAR_NAME" VARCHAR2(128), 
	"PAR_VALUE" VARCHAR2(4000), 
	"PAR_COMMENT" VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ROWDEPENDENCIES ';
exception
    when others then
        if sqlcode = -955 then null; else raise; end if;
end;
/
prompt PK_WSMPARAM
begin
execute immediate '
  ALTER TABLE BILLS.WSM_PARAMS ADD CONSTRAINT "PK_WSMPARAM" PRIMARY KEY ("PAR_NAME")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS"  ENABLE';
exception
    when others then
        if sqlcode in (-2260, -955) then null; else raise; end if;
end;
/
begin
    execute immediate 
  'ALTER TABLE BILLS.WSM_PARAMS ADD CONSTRAINT "CC_WSMPARAM_PARNAME_NN" CHECK ("PAR_NAME" IS NOT NULL) ENABLE';
exception
    when others then null;
end;
/
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BILLS/table/wsm_params.sql =========*** End *** =
 PROMPT ===================================================================================== 
 