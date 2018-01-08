

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/MGR_CHECKS.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to MGR_CHECKS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table MGR_CHECKS ***
begin 
  execute immediate '
  CREATE TABLE BARS.MGR_CHECKS 
   (	KF VARCHAR2(6), 
	CHECK_ORDER NUMBER(*,0), 
	CHECK_PROC VARCHAR2(93), 
	CHECK_STATUS VARCHAR2(30) DEFAULT ''SUCCEEDED'', 
	CHECK_COMMENT VARCHAR2(250), 
	 CONSTRAINT PK_MGRCHECKS PRIMARY KEY (KF, CHECK_PROC) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSSMLD 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to MGR_CHECKS ***
 exec bpa.alter_policies('MGR_CHECKS');


COMMENT ON TABLE BARS.MGR_CHECKS IS 'Проверки перед миграцией';
COMMENT ON COLUMN BARS.MGR_CHECKS.KF IS 'Код филиала';
COMMENT ON COLUMN BARS.MGR_CHECKS.CHECK_ORDER IS 'Порядковый номер проверки';
COMMENT ON COLUMN BARS.MGR_CHECKS.CHECK_PROC IS 'Процедура проверки';
COMMENT ON COLUMN BARS.MGR_CHECKS.CHECK_STATUS IS 'Статус проверки: SUCCEEDED/FAILED';
COMMENT ON COLUMN BARS.MGR_CHECKS.CHECK_COMMENT IS 'Комментарий проверки';




PROMPT *** Create  constraint CC_MGRCHECKS_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.MGR_CHECKS MODIFY (KF CONSTRAINT CC_MGRCHECKS_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_MGRCHECKS_CHECKORDER_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.MGR_CHECKS MODIFY (CHECK_ORDER CONSTRAINT CC_MGRCHECKS_CHECKORDER_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_MGRCHECKS ***
begin   
 execute immediate '
  ALTER TABLE BARS.MGR_CHECKS ADD CONSTRAINT PK_MGRCHECKS PRIMARY KEY (KF, CHECK_PROC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_MGRCHECKS_CHECKSTATUS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.MGR_CHECKS MODIFY (CHECK_STATUS CONSTRAINT CC_MGRCHECKS_CHECKSTATUS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_MGRCHECKS_CHECKPROC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.MGR_CHECKS MODIFY (CHECK_PROC CONSTRAINT CC_MGRCHECKS_CHECKPROC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_MGRCHECKS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_MGRCHECKS ON BARS.MGR_CHECKS (KF, CHECK_PROC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/MGR_CHECKS.sql =========*** End *** ==
PROMPT ===================================================================================== 
