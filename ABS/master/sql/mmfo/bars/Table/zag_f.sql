

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ZAG_F.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ZAG_F ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ZAG_F'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''ZAG_F'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''ZAG_F'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ZAG_F ***
begin 
  execute immediate '
  CREATE TABLE BARS.ZAG_F 
   (	FN VARCHAR2(30), 
	DAT DATE, 
	N NUMBER, 
	OTM NUMBER, 
	DATK DATE, 
	ERR VARCHAR2(4), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	FNK VARCHAR2(30), 
	TXTK VARCHAR2(254),
	fnk1 varchar2(30), 
	datk1 date
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

begin 
  execute immediate '
alter table bars.zag_f add (
	fnk1 varchar2(30), 
	datk1 date)';
exception when others then       
  if sqlcode = -1430 then null; else raise; end if; 
end; 
/


PROMPT *** ALTER_POLICIES to ZAG_F ***
 exec bpa.alter_policies('ZAG_F');


COMMENT ON TABLE BARS.ZAG_F IS '';
COMMENT ON COLUMN BARS.ZAG_F.FN IS '';
COMMENT ON COLUMN BARS.ZAG_F.DAT IS '';
COMMENT ON COLUMN BARS.ZAG_F.N IS '';
COMMENT ON COLUMN BARS.ZAG_F.OTM IS '';
COMMENT ON COLUMN BARS.ZAG_F.DATK IS '';
COMMENT ON COLUMN BARS.ZAG_F.ERR IS '';
COMMENT ON COLUMN BARS.ZAG_F.KF IS '';
COMMENT ON COLUMN BARS.ZAG_F.FNK IS '';
COMMENT ON COLUMN BARS.ZAG_F.TXTK IS '';




PROMPT *** Create  constraint PK_ZAGF ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAG_F ADD CONSTRAINT PK_ZAGF PRIMARY KEY (FN, DAT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_ZAGF ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAG_F ADD CONSTRAINT UK_ZAGF UNIQUE (KF, FN, DAT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZAGF_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAG_F MODIFY (KF CONSTRAINT CC_ZAGF_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ZAGF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ZAGF ON BARS.ZAG_F (FN, DAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_ZAGF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_ZAGF ON BARS.ZAG_F (KF, FN, DAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ZAG_F ***
grant SELECT                                                                 on ZAG_F           to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on ZAG_F           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ZAG_F           to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on ZAG_F           to RPBN002;
grant SELECT                                                                 on ZAG_F           to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ZAG_F           to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to ZAG_F ***

  CREATE OR REPLACE PUBLIC SYNONYM ZAG_F FOR BARS.ZAG_F;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ZAG_F.sql =========*** End *** =======
PROMPT ===================================================================================== 
