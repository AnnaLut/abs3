
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BILLS/table/resolutions.sql =========*** Run *** 
 PROMPT ===================================================================================== 

begin
  for r in (select 1 from dual where not exists (select 1 from user_tables where table_name = 'RESOLUTIONS'))
  loop
    execute immediate ' 
  CREATE TABLE BILLS.RESOLUTIONS 
   (	"RES_CODE" VARCHAR2(50), 
	"RES_DATE" DATE, 
	"STATUS" VARCHAR2(2), 
	"RES_ID" NUMBER(*,0), 
	"LAST_USER" VARCHAR2(100), 
	"LAST_DT" DATE, 
	"RESPONSE" VARCHAR2(1000), 
	"COURTNAME" VARCHAR2(1000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "BRSMDLD" ';
  end loop;
end;
/

begin
  for r in (select 1 from dual where not exists (select 1 from user_constraints where constraint_name = 'UK_RESOLUTIONS'))
  loop
    execute immediate 'ALTER TABLE BILLS.RESOLUTIONS ADD CONSTRAINT "UK_RESOLUTIONS" UNIQUE ("RES_ID")
                       USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
                       TABLESPACE "USERS"  ENABLE';
  end loop;

  for r in (select 1 from dual where not exists (select 1 from user_constraints where constraint_name = 'XPK_RESOLUTIONS'))
  loop
    execute immediate 'ALTER TABLE BILLS.RESOLUTIONS ADD CONSTRAINT "XPK_RESOLUTIONS" PRIMARY KEY ("RES_CODE", "RES_DATE")
                       USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
                       TABLESPACE "USERS"  ENABLE';
  end loop;
end;
/

declare
  v_num integer;
begin
select count(1) into v_num
  from user_tab_columns
  where table_name = 'RESOLUTIONS'
    and column_name = 'COURTNAME';
if v_num = 0 then
  execute immediate 'alter table RESOLUTIONS add COURTNAME varchar2(1000)';
end if;
end;
/ 

 show err;

 
PROMPT *** Create  grants  RESOLUTIONS ***
grant SELECT                                                                 on RESOLUTIONS     to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BILLS/table/resolutions.sql =========*** End *** 
 PROMPT ===================================================================================== 
 