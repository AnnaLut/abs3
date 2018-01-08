

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/RNBU_IN_FILES.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to RNBU_IN_FILES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''RNBU_IN_FILES'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''RNBU_IN_FILES'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''RNBU_IN_FILES'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table RNBU_IN_FILES ***
begin 
  execute immediate '
  CREATE TABLE BARS.RNBU_IN_FILES 
   (	FILE_ID NUMBER, 
	FILE_KEY VARCHAR2(2), 
	NEXT_DATE VARCHAR2(8), 
	INIT_DATE VARCHAR2(8), 
	LAST_DATE VARCHAR2(8), 
	FORM_DATE VARCHAR2(8), 
	FORM_TIME VARCHAR2(6), 
	MFO VARCHAR2(10), 
	UNIT VARCHAR2(2), 
	INF_ROW_COUNT NUMBER, 
	FILE_NAME VARCHAR2(12), 
	SPARE1 VARCHAR2(6), 
	SPARE2 VARCHAR2(64), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to RNBU_IN_FILES ***
 exec bpa.alter_policies('RNBU_IN_FILES');


COMMENT ON TABLE BARS.RNBU_IN_FILES IS 'Заголовки принятых файлов филиалов для консолидации';
COMMENT ON COLUMN BARS.RNBU_IN_FILES.FILE_ID IS '';
COMMENT ON COLUMN BARS.RNBU_IN_FILES.FILE_KEY IS '';
COMMENT ON COLUMN BARS.RNBU_IN_FILES.NEXT_DATE IS '';
COMMENT ON COLUMN BARS.RNBU_IN_FILES.INIT_DATE IS '';
COMMENT ON COLUMN BARS.RNBU_IN_FILES.LAST_DATE IS '';
COMMENT ON COLUMN BARS.RNBU_IN_FILES.FORM_DATE IS '';
COMMENT ON COLUMN BARS.RNBU_IN_FILES.FORM_TIME IS '';
COMMENT ON COLUMN BARS.RNBU_IN_FILES.MFO IS '';
COMMENT ON COLUMN BARS.RNBU_IN_FILES.UNIT IS '';
COMMENT ON COLUMN BARS.RNBU_IN_FILES.INF_ROW_COUNT IS '';
COMMENT ON COLUMN BARS.RNBU_IN_FILES.FILE_NAME IS '';
COMMENT ON COLUMN BARS.RNBU_IN_FILES.SPARE1 IS '';
COMMENT ON COLUMN BARS.RNBU_IN_FILES.SPARE2 IS '';
COMMENT ON COLUMN BARS.RNBU_IN_FILES.KF IS '';




PROMPT *** Create  constraint SYS_C0012681 ***
begin   
 execute immediate '
  ALTER TABLE BARS.RNBU_IN_FILES ADD PRIMARY KEY (FILE_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_RNBUINFILES ***
begin   
 execute immediate '
  ALTER TABLE BARS.RNBU_IN_FILES ADD CONSTRAINT UK_RNBUINFILES UNIQUE (KF, FILE_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_RNBUINFILES_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.RNBU_IN_FILES ADD CONSTRAINT FK_RNBUINFILES_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_RNBUINFILES_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.RNBU_IN_FILES MODIFY (KF CONSTRAINT CC_RNBUINFILES_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_RNBUINFILES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_RNBUINFILES ON BARS.RNBU_IN_FILES (KF, FILE_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index SYS_C0012681 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.SYS_C0012681 ON BARS.RNBU_IN_FILES (FILE_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  RNBU_IN_FILES ***
grant DELETE,INSERT,SELECT,UPDATE                                            on RNBU_IN_FILES   to ABS_ADMIN;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on RNBU_IN_FILES   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on RNBU_IN_FILES   to BARS_DM;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on RNBU_IN_FILES   to RPBN002;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on RNBU_IN_FILES   to SALGL;
grant SELECT                                                                 on RNBU_IN_FILES   to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on RNBU_IN_FILES   to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to RNBU_IN_FILES ***

  CREATE OR REPLACE PUBLIC SYNONYM RNBU_IN_FILES FOR BARS.RNBU_IN_FILES;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/RNBU_IN_FILES.sql =========*** End ***
PROMPT ===================================================================================== 
