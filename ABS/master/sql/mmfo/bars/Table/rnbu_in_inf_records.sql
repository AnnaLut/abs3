

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/RNBU_IN_INF_RECORDS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to RNBU_IN_INF_RECORDS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''RNBU_IN_INF_RECORDS'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''RNBU_IN_INF_RECORDS'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''RNBU_IN_INF_RECORDS'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table RNBU_IN_INF_RECORDS ***
begin 
  execute immediate '
  CREATE TABLE BARS.RNBU_IN_INF_RECORDS 
   (	RECORD_ID NUMBER, 
	FILE_ID NUMBER, 
	ISRESIDENT NUMBER(1,0) DEFAULT 1, 
	NBUCODE NUMBER(20,0), 
	PARAMETER VARCHAR2(32), 
	VALUE VARCHAR2(128), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to RNBU_IN_INF_RECORDS ***
 exec bpa.alter_policies('RNBU_IN_INF_RECORDS');


COMMENT ON TABLE BARS.RNBU_IN_INF_RECORDS IS 'Информационные строки принятых файлов филиалов для консолидации';
COMMENT ON COLUMN BARS.RNBU_IN_INF_RECORDS.RECORD_ID IS '';
COMMENT ON COLUMN BARS.RNBU_IN_INF_RECORDS.FILE_ID IS '';
COMMENT ON COLUMN BARS.RNBU_IN_INF_RECORDS.ISRESIDENT IS '';
COMMENT ON COLUMN BARS.RNBU_IN_INF_RECORDS.NBUCODE IS '';
COMMENT ON COLUMN BARS.RNBU_IN_INF_RECORDS.PARAMETER IS '';
COMMENT ON COLUMN BARS.RNBU_IN_INF_RECORDS.VALUE IS '';
COMMENT ON COLUMN BARS.RNBU_IN_INF_RECORDS.KF IS '';




PROMPT *** Create  constraint FK_RNBU_IN_RECORDS_FILES ***
begin   
 execute immediate '
  ALTER TABLE BARS.RNBU_IN_INF_RECORDS ADD CONSTRAINT FK_RNBU_IN_RECORDS_FILES FOREIGN KEY (FILE_ID)
	  REFERENCES BARS.RNBU_IN_FILES (FILE_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_RNBUININFRECORDS_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.RNBU_IN_INF_RECORDS ADD CONSTRAINT FK_RNBUININFRECORDS_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_RNBUININFRECORDS_RNBUINFILE ***
begin   
 execute immediate '
  ALTER TABLE BARS.RNBU_IN_INF_RECORDS ADD CONSTRAINT FK_RNBUININFRECORDS_RNBUINFILE FOREIGN KEY (KF, FILE_ID)
	  REFERENCES BARS.RNBU_IN_FILES (KF, FILE_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0011671 ***
begin   
 execute immediate '
  ALTER TABLE BARS.RNBU_IN_INF_RECORDS ADD PRIMARY KEY (RECORD_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_RNBUININFRECORDS_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.RNBU_IN_INF_RECORDS MODIFY (KF CONSTRAINT CC_RNBUININFRECORDS_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_RNBU_INF_REC ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_RNBU_INF_REC ON BARS.RNBU_IN_INF_RECORDS (KF, FILE_ID, PARAMETER, NBUCODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index SYS_C0011671 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.SYS_C0011671 ON BARS.RNBU_IN_INF_RECORDS (RECORD_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  RNBU_IN_INF_RECORDS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on RNBU_IN_INF_RECORDS to ABS_ADMIN;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on RNBU_IN_INF_RECORDS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on RNBU_IN_INF_RECORDS to BARS_DM;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on RNBU_IN_INF_RECORDS to RPBN002;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on RNBU_IN_INF_RECORDS to SALGL;
grant SELECT                                                                 on RNBU_IN_INF_RECORDS to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on RNBU_IN_INF_RECORDS to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/RNBU_IN_INF_RECORDS.sql =========*** E
PROMPT ===================================================================================== 
