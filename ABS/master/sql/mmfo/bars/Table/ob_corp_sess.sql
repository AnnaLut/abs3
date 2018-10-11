

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OB_CORP_SESS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OB_CORP_SESS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OB_CORP_SESS'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''OB_CORP_SESS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OB_CORP_SESS ***
begin 
  execute immediate '
  CREATE TABLE BARS.OB_CORP_SESS 
   (	ID NUMBER(10,0), 
	KF VARCHAR2(6), 
	FILE_DATE DATE, 
	STATE_ID NUMBER(1,0), 
	SYS_TIME DATE, 
	ERR_LOG CLOB
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

begin
execute immediate'alter table OB_CORP_SESS drop column D_TYPE';
exception when others then 
if sqlcode = -00904 then null; else raise; end if;
end;
/

begin
execute immediate'alter table OB_CORP_SESS add ERR_LOG CLOB';
exception when others then 
if sqlcode = -01430 then null; else raise; end if;
end;
/


PROMPT *** ALTER_POLICIES to OB_CORP_SESS ***
 exec bpa.alter_policies('OB_CORP_SESS');


COMMENT ON TABLE BARS.OB_CORP_SESS IS 'Сесії завантаження К-Файлів';
COMMENT ON COLUMN BARS.OB_CORP_SESS.ID IS 'Ідентифікатор сесії';
COMMENT ON COLUMN BARS.OB_CORP_SESS.KF IS 'Код МФО регіонального управління (відправника даних)';
COMMENT ON COLUMN BARS.OB_CORP_SESS.FILE_DATE IS 'Дата, за яку сформований К-файл';
COMMENT ON COLUMN BARS.OB_CORP_SESS.STATE_ID IS 'Стан обробки сесії (0 - нова, 1 - оброблена успішно, 2 - оброблена з помилками, 3 - помилка обробки)';
COMMENT ON COLUMN BARS.OB_CORP_SESS.SYS_TIME IS 'Системний час створення сесії';
COMMENT ON COLUMN BARS.OB_CORP_SESS.ERR_LOG IS 'Помилкі наповнення таблиць';




PROMPT *** Create  constraint SYS_C0027392 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OB_CORP_SESS MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0027393 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OB_CORP_SESS MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0027394 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OB_CORP_SESS MODIFY (FILE_DATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0027395 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OB_CORP_SESS MODIFY (STATE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0027396 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OB_CORP_SESS MODIFY (SYS_TIME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_OB_CORP_SESS ***
begin   
 execute immediate '
  ALTER TABLE BARS.OB_CORP_SESS ADD CONSTRAINT PK_OB_CORP_SESS PRIMARY KEY (ID, KF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OB_CORP_SESS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OB_CORP_SESS ON BARS.OB_CORP_SESS (ID, KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OB_CORP_SESS ***
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on OB_CORP_SESS    to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OB_CORP_SESS.sql =========*** End *** 
PROMPT ===================================================================================== 

