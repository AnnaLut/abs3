

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PROC_DR$BASE.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PROC_DR$BASE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PROC_DR$BASE'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''PROC_DR$BASE'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''PROC_DR$BASE'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PROC_DR$BASE ***
begin 
  execute immediate '
  CREATE TABLE BARS.PROC_DR$BASE 
   (	NBS CHAR(4), 
	G67 VARCHAR2(15), 
	V67 VARCHAR2(15), 
	SOUR NUMBER(1,0), 
	NBSN CHAR(4), 
	G67N VARCHAR2(15), 
	V67N VARCHAR2(15), 
	NBSZ CHAR(4), 
	REZID NUMBER(38,0), 
	TT CHAR(3), 
	TTV CHAR(3), 
	IO NUMBER(1,0), 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PROC_DR$BASE ***
 exec bpa.alter_policies('PROC_DR$BASE');


COMMENT ON TABLE BARS.PROC_DR$BASE IS '';
COMMENT ON COLUMN BARS.PROC_DR$BASE.NBS IS '';
COMMENT ON COLUMN BARS.PROC_DR$BASE.G67 IS '';
COMMENT ON COLUMN BARS.PROC_DR$BASE.V67 IS '';
COMMENT ON COLUMN BARS.PROC_DR$BASE.SOUR IS '';
COMMENT ON COLUMN BARS.PROC_DR$BASE.NBSN IS '';
COMMENT ON COLUMN BARS.PROC_DR$BASE.G67N IS '';
COMMENT ON COLUMN BARS.PROC_DR$BASE.V67N IS '';
COMMENT ON COLUMN BARS.PROC_DR$BASE.NBSZ IS '';
COMMENT ON COLUMN BARS.PROC_DR$BASE.REZID IS '';
COMMENT ON COLUMN BARS.PROC_DR$BASE.TT IS '';
COMMENT ON COLUMN BARS.PROC_DR$BASE.TTV IS '';
COMMENT ON COLUMN BARS.PROC_DR$BASE.IO IS '';
COMMENT ON COLUMN BARS.PROC_DR$BASE.BRANCH IS '';
COMMENT ON COLUMN BARS.PROC_DR$BASE.KF IS '';




PROMPT *** Create  constraint PK_PROCDR$BASE ***
begin   
 execute immediate '
  ALTER TABLE BARS.PROC_DR$BASE ADD CONSTRAINT PK_PROCDR$BASE PRIMARY KEY (NBS, BRANCH, SOUR, REZID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PROC_DR$BASE_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.PROC_DR$BASE ADD CONSTRAINT FK_PROC_DR$BASE_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PROC_DR$BASE_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.PROC_DR$BASE ADD CONSTRAINT FK_PROC_DR$BASE_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008641 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PROC_DR$BASE MODIFY (IO NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PROC_DR$BASE_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PROC_DR$BASE ADD CONSTRAINT CC_PROC_DR$BASE_BRANCH_NN CHECK (BRANCH IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008639 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PROC_DR$BASE MODIFY (SOUR NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008640 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PROC_DR$BASE MODIFY (REZID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008642 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PROC_DR$BASE MODIFY (BRANCH NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PROC_DR$BASE_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PROC_DR$BASE MODIFY (KF CONSTRAINT CC_PROC_DR$BASE_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008638 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PROC_DR$BASE MODIFY (NBS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PROCDR$BASE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_PROCDR$BASE ON BARS.PROC_DR$BASE (NBS, BRANCH, SOUR, REZID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PROC_DR$BASE ***
grant FLASHBACK,SELECT                                                       on PROC_DR$BASE    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PROC_DR$BASE    to BARS_DM;
grant SELECT                                                                 on PROC_DR$BASE    to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on PROC_DR$BASE    to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on PROC_DR$BASE    to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PROC_DR$BASE.sql =========*** End *** 
PROMPT ===================================================================================== 
