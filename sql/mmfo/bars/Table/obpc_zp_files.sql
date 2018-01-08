

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OBPC_ZP_FILES.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OBPC_ZP_FILES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OBPC_ZP_FILES'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''OBPC_ZP_FILES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OBPC_ZP_FILES'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OBPC_ZP_FILES ***
begin 
  execute immediate '
  CREATE TABLE BARS.OBPC_ZP_FILES 
   (	ID NUMBER(38,0), 
	FILE_NAME VARCHAR2(20), 
	FILE_DATE DATE DEFAULT sysdate, 
	FILE_ACC NUMBER(38,0), 
	FILE_SUM NUMBER(38,0), 
	PAY_ACC NUMBER(38,0), 
	PAY_SUM NUMBER(38,0), 
	TRANSIT_ACC NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OBPC_ZP_FILES ***
 exec bpa.alter_policies('OBPC_ZP_FILES');


COMMENT ON TABLE BARS.OBPC_ZP_FILES IS 'ПЦ. Информация по зарплатным файлам';
COMMENT ON COLUMN BARS.OBPC_ZP_FILES.ID IS 'Id';
COMMENT ON COLUMN BARS.OBPC_ZP_FILES.FILE_NAME IS 'Имя файла';
COMMENT ON COLUMN BARS.OBPC_ZP_FILES.FILE_DATE IS 'Дата файла';
COMMENT ON COLUMN BARS.OBPC_ZP_FILES.FILE_ACC IS 'Кол-во счетов в файле';
COMMENT ON COLUMN BARS.OBPC_ZP_FILES.FILE_SUM IS 'Сумма файла (коп.)';
COMMENT ON COLUMN BARS.OBPC_ZP_FILES.PAY_ACC IS 'Кол-во оплаченных счетов';
COMMENT ON COLUMN BARS.OBPC_ZP_FILES.PAY_SUM IS 'Сумма оплач. документов (коп.)';
COMMENT ON COLUMN BARS.OBPC_ZP_FILES.TRANSIT_ACC IS '';




PROMPT *** Create  constraint PK_OBPCZPFILES ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_ZP_FILES ADD CONSTRAINT PK_OBPCZPFILES PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OBPCZPFILES_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_ZP_FILES MODIFY (ID CONSTRAINT CC_OBPCZPFILES_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OBPCZPFILES_FILENAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_ZP_FILES MODIFY (FILE_NAME CONSTRAINT CC_OBPCZPFILES_FILENAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OBPCZPFILES_FILEDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_ZP_FILES MODIFY (FILE_DATE CONSTRAINT CC_OBPCZPFILES_FILEDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OBPCZPFILES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OBPCZPFILES ON BARS.OBPC_ZP_FILES (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OBPC_ZP_FILES ***
grant SELECT                                                                 on OBPC_ZP_FILES   to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on OBPC_ZP_FILES   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OBPC_ZP_FILES   to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on OBPC_ZP_FILES   to OBPC;
grant SELECT                                                                 on OBPC_ZP_FILES   to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OBPC_ZP_FILES   to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OBPC_ZP_FILES.sql =========*** End ***
PROMPT ===================================================================================== 
