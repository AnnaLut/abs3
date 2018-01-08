

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CC_KOL$BASE.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CC_KOL$BASE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CC_KOL$BASE'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CC_KOL$BASE'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''CC_KOL$BASE'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CC_KOL$BASE ***
begin 
  execute immediate '
  CREATE TABLE BARS.CC_KOL$BASE 
   (	VIDD NUMBER(38,0), 
	SOUR NUMBER(38,0), 
	NLS NUMBER(38,0), 
	KOL NUMBER(24,0), 
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




PROMPT *** ALTER_POLICIES to CC_KOL$BASE ***
 exec bpa.alter_policies('CC_KOL$BASE');


COMMENT ON TABLE BARS.CC_KOL$BASE IS '';
COMMENT ON COLUMN BARS.CC_KOL$BASE.VIDD IS '';
COMMENT ON COLUMN BARS.CC_KOL$BASE.SOUR IS '';
COMMENT ON COLUMN BARS.CC_KOL$BASE.NLS IS '';
COMMENT ON COLUMN BARS.CC_KOL$BASE.KOL IS '';
COMMENT ON COLUMN BARS.CC_KOL$BASE.BRANCH IS '';
COMMENT ON COLUMN BARS.CC_KOL$BASE.KF IS '';




PROMPT *** Create  constraint PK_CCKOL$BASE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_KOL$BASE ADD CONSTRAINT PK_CCKOL$BASE PRIMARY KEY (KF, VIDD, SOUR)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CCKOLBASE_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_KOL$BASE ADD CONSTRAINT FK_CCKOLBASE_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008468 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_KOL$BASE MODIFY (BRANCH NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CCKOLBASE_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_KOL$BASE MODIFY (KF CONSTRAINT CC_CCKOLBASE_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CCKOL$BASE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CCKOL$BASE ON BARS.CC_KOL$BASE (KF, VIDD, SOUR) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CC_KOL$BASE ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CC_KOL$BASE     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_KOL$BASE     to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CC_KOL$BASE     to RCC_DEAL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CC_KOL$BASE     to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CC_KOL$BASE.sql =========*** End *** =
PROMPT ===================================================================================== 
