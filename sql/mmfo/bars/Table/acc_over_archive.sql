

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ACC_OVER_ARCHIVE.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ACC_OVER_ARCHIVE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ACC_OVER_ARCHIVE'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''ACC_OVER_ARCHIVE'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''ACC_OVER_ARCHIVE'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ACC_OVER_ARCHIVE ***
begin 
  execute immediate '
  CREATE TABLE BARS.ACC_OVER_ARCHIVE 
   (	ACC NUMBER(*,0), 
	ACCO NUMBER(*,0), 
	TIPO NUMBER(*,0), 
	FLAG NUMBER(*,0), 
	ND NUMBER, 
	DAY NUMBER(*,0), 
	SOS NUMBER(*,0), 
	DATD DATE, 
	SD NUMBER(24,0), 
	NDOC VARCHAR2(30), 
	VIDD NUMBER, 
	DATD2 DATE, 
	KRL NUMBER, 
	USEOSTF NUMBER, 
	USELIM NUMBER, 
	ACC_9129 NUMBER(*,0), 
	ACC_8000 NUMBER(*,0), 
	OBS NUMBER(*,0), 
	TXT VARCHAR2(100), 
	USERID NUMBER, 
	DELETED NUMBER, 
	PR_2600A NUMBER, 
	PR_KOMIS NUMBER, 
	PR_9129 NUMBER, 
	PR_2069 NUMBER, 
	ACC_2067 NUMBER, 
	ACC_2069 NUMBER, 
	DELDATE DATE, 
	ACC_2096 NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ACC_OVER_ARCHIVE ***
 exec bpa.alter_policies('ACC_OVER_ARCHIVE');


COMMENT ON TABLE BARS.ACC_OVER_ARCHIVE IS '';
COMMENT ON COLUMN BARS.ACC_OVER_ARCHIVE.ACC IS '';
COMMENT ON COLUMN BARS.ACC_OVER_ARCHIVE.ACCO IS '';
COMMENT ON COLUMN BARS.ACC_OVER_ARCHIVE.TIPO IS '';
COMMENT ON COLUMN BARS.ACC_OVER_ARCHIVE.FLAG IS '';
COMMENT ON COLUMN BARS.ACC_OVER_ARCHIVE.ND IS '';
COMMENT ON COLUMN BARS.ACC_OVER_ARCHIVE.DAY IS '';
COMMENT ON COLUMN BARS.ACC_OVER_ARCHIVE.SOS IS '';
COMMENT ON COLUMN BARS.ACC_OVER_ARCHIVE.DATD IS '';
COMMENT ON COLUMN BARS.ACC_OVER_ARCHIVE.SD IS '';
COMMENT ON COLUMN BARS.ACC_OVER_ARCHIVE.NDOC IS '';
COMMENT ON COLUMN BARS.ACC_OVER_ARCHIVE.VIDD IS '';
COMMENT ON COLUMN BARS.ACC_OVER_ARCHIVE.DATD2 IS '';
COMMENT ON COLUMN BARS.ACC_OVER_ARCHIVE.KRL IS '';
COMMENT ON COLUMN BARS.ACC_OVER_ARCHIVE.USEOSTF IS '';
COMMENT ON COLUMN BARS.ACC_OVER_ARCHIVE.USELIM IS '';
COMMENT ON COLUMN BARS.ACC_OVER_ARCHIVE.ACC_9129 IS '';
COMMENT ON COLUMN BARS.ACC_OVER_ARCHIVE.ACC_8000 IS '';
COMMENT ON COLUMN BARS.ACC_OVER_ARCHIVE.OBS IS '';
COMMENT ON COLUMN BARS.ACC_OVER_ARCHIVE.TXT IS '';
COMMENT ON COLUMN BARS.ACC_OVER_ARCHIVE.USERID IS '';
COMMENT ON COLUMN BARS.ACC_OVER_ARCHIVE.DELETED IS '';
COMMENT ON COLUMN BARS.ACC_OVER_ARCHIVE.PR_2600A IS '';
COMMENT ON COLUMN BARS.ACC_OVER_ARCHIVE.PR_KOMIS IS '';
COMMENT ON COLUMN BARS.ACC_OVER_ARCHIVE.PR_9129 IS '';
COMMENT ON COLUMN BARS.ACC_OVER_ARCHIVE.PR_2069 IS '';
COMMENT ON COLUMN BARS.ACC_OVER_ARCHIVE.ACC_2067 IS '';
COMMENT ON COLUMN BARS.ACC_OVER_ARCHIVE.ACC_2069 IS '';
COMMENT ON COLUMN BARS.ACC_OVER_ARCHIVE.DELDATE IS '';
COMMENT ON COLUMN BARS.ACC_OVER_ARCHIVE.ACC_2096 IS 'acc сомнительной задолжности';
COMMENT ON COLUMN BARS.ACC_OVER_ARCHIVE.KF IS '';




PROMPT *** Create  constraint FK_ACCOVERARCHIVE_ACCOUNTS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_OVER_ARCHIVE ADD CONSTRAINT FK_ACCOVERARCHIVE_ACCOUNTS2 FOREIGN KEY (KF, ACCO)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCOVERARCHIVE_ACCOUNTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_OVER_ARCHIVE ADD CONSTRAINT FK_ACCOVERARCHIVE_ACCOUNTS FOREIGN KEY (KF, ACC)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ACC_OVER_ARCHIVE ***
grant DELETE,INSERT,SELECT,UPDATE                                            on ACC_OVER_ARCHIVE to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACC_OVER_ARCHIVE to BARS009;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACC_OVER_ARCHIVE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ACC_OVER_ARCHIVE to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACC_OVER_ARCHIVE to TECH005;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACC_OVER_ARCHIVE to TECH006;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ACC_OVER_ARCHIVE to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ACC_OVER_ARCHIVE.sql =========*** End 
PROMPT ===================================================================================== 
