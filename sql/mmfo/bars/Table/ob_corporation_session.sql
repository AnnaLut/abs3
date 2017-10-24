

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OB_CORPORATION_SESSION.sql =========**
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OB_CORPORATION_SESSION ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OB_CORPORATION_SESSION'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''OB_CORPORATION_SESSION'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''OB_CORPORATION_SESSION'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OB_CORPORATION_SESSION ***
begin 
  execute immediate '
  CREATE TABLE BARS.OB_CORPORATION_SESSION 
   (	ID NUMBER(10,0), 
	KF NUMBER(6,0), 
	FILE_DATE DATE, 
	FILE_CORPORATION_ID NUMBER(5,0), 
	FILE_DATA CLOB, 
	STATE_ID NUMBER(5,0), 
	SYS_TIME DATE, 
	SYNC_TYPE VARCHAR2(4)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD 
 LOB (FILE_DATA) STORE AS BASICFILE (
  TABLESPACE BRSMDLD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OB_CORPORATION_SESSION ***
 exec bpa.alter_policies('OB_CORPORATION_SESSION');


COMMENT ON TABLE BARS.OB_CORPORATION_SESSION IS 'Сесії завантаження К-Файлів';
COMMENT ON COLUMN BARS.OB_CORPORATION_SESSION.ID IS 'Ідентифікатор сесії';
COMMENT ON COLUMN BARS.OB_CORPORATION_SESSION.KF IS 'Код МФО регіонального управління (відправника даних)';
COMMENT ON COLUMN BARS.OB_CORPORATION_SESSION.FILE_DATE IS 'Дата, за яку сформований К-файл';
COMMENT ON COLUMN BARS.OB_CORPORATION_SESSION.FILE_CORPORATION_ID IS 'Ідентифікатор корпорації, по якій сформований К-файл (null - всі корпорації)';
COMMENT ON COLUMN BARS.OB_CORPORATION_SESSION.FILE_DATA IS 'Вміст К-файлу';
COMMENT ON COLUMN BARS.OB_CORPORATION_SESSION.STATE_ID IS 'Стан обробки сесії (0 - нова, 1 - оброблена успішно, 2 - оброблена з помилками, 3 - помилка обробки)';
COMMENT ON COLUMN BARS.OB_CORPORATION_SESSION.SYS_TIME IS 'Системний час створення сесії';
COMMENT ON COLUMN BARS.OB_CORPORATION_SESSION.SYNC_TYPE IS 'Тип повідомлення (DICT - довідники, DATA - дані)';




PROMPT *** Create  constraint PK_OB_CORPORATION_SESSION ***
begin   
 execute immediate '
  ALTER TABLE BARS.OB_CORPORATION_SESSION ADD CONSTRAINT PK_OB_CORPORATION_SESSION PRIMARY KEY (ID, KF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00109851 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OB_CORPORATION_SESSION MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00109852 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OB_CORPORATION_SESSION MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00109856 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OB_CORPORATION_SESSION MODIFY (SYNC_TYPE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00109854 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OB_CORPORATION_SESSION MODIFY (STATE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00109855 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OB_CORPORATION_SESSION MODIFY (SYS_TIME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00109853 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OB_CORPORATION_SESSION MODIFY (FILE_DATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OB_CORPORATION_SESSION ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OB_CORPORATION_SESSION ON BARS.OB_CORPORATION_SESSION (ID, KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OB_CORPORATION_SESSION ***
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on OB_CORPORATION_SESSION to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OB_CORPORATION_SESSION.sql =========**
PROMPT ===================================================================================== 
