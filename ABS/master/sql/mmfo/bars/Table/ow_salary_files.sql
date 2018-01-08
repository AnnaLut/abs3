

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OW_SALARY_FILES.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OW_SALARY_FILES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OW_SALARY_FILES'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''OW_SALARY_FILES'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''OW_SALARY_FILES'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OW_SALARY_FILES ***
begin 
  execute immediate '
  CREATE TABLE BARS.OW_SALARY_FILES 
   (	ID NUMBER(22,0), 
	FILE_NAME VARCHAR2(100), 
	FILE_DATE DATE DEFAULT sysdate, 
	CARD_CODE VARCHAR2(32), 
	BRANCH VARCHAR2(30), 
	ISP NUMBER(22,0), 
	PROECT_ID NUMBER(22,0), 
	FILE_N NUMBER(22,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OW_SALARY_FILES ***
 exec bpa.alter_policies('OW_SALARY_FILES');


COMMENT ON TABLE BARS.OW_SALARY_FILES IS 'OpenWay. Імпортовані файли зарплатних проектів';
COMMENT ON COLUMN BARS.OW_SALARY_FILES.KF IS '';
COMMENT ON COLUMN BARS.OW_SALARY_FILES.ID IS 'Ід.';
COMMENT ON COLUMN BARS.OW_SALARY_FILES.FILE_NAME IS 'Ім'я файлу';
COMMENT ON COLUMN BARS.OW_SALARY_FILES.FILE_DATE IS 'Дата імпорту файлу';
COMMENT ON COLUMN BARS.OW_SALARY_FILES.CARD_CODE IS '';
COMMENT ON COLUMN BARS.OW_SALARY_FILES.BRANCH IS '';
COMMENT ON COLUMN BARS.OW_SALARY_FILES.ISP IS '';
COMMENT ON COLUMN BARS.OW_SALARY_FILES.PROECT_ID IS '';
COMMENT ON COLUMN BARS.OW_SALARY_FILES.FILE_N IS '';




PROMPT *** Create  constraint CC_OWSALARYFILES_FILENAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_SALARY_FILES ADD CONSTRAINT CC_OWSALARYFILES_FILENAME_NN CHECK (file_name is not null) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWSALARYFILES_FILEDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_SALARY_FILES ADD CONSTRAINT CC_OWSALARYFILES_FILEDATE_NN CHECK (file_date is not null) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_OWSALARYFILES ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_SALARY_FILES ADD CONSTRAINT PK_OWSALARYFILES PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWSALARYFILES_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_SALARY_FILES MODIFY (KF CONSTRAINT CC_OWSALARYFILES_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OWSALARYFILES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OWSALARYFILES ON BARS.OW_SALARY_FILES (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OW_SALARY_FILES ***
grant SELECT                                                                 on OW_SALARY_FILES to BARSREADER_ROLE;
grant INSERT,SELECT                                                          on OW_SALARY_FILES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OW_SALARY_FILES to BARS_DM;
grant INSERT,SELECT                                                          on OW_SALARY_FILES to OW;
grant SELECT                                                                 on OW_SALARY_FILES to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OW_SALARY_FILES.sql =========*** End *
PROMPT ===================================================================================== 
