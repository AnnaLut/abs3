

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CC_PENY_START.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CC_PENY_START ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CC_PENY_START'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CC_PENY_START'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CC_PENY_START'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CC_PENY_START ***
begin 
  execute immediate '
  CREATE TABLE BARS.CC_PENY_START 
   (	ACC NUMBER(*,0), 
	OSTC NUMBER(*,0), 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	ND NUMBER, 
	ACC_SN8 NUMBER, 
	NLS_SN8 VARCHAR2(15), 
	IR NUMBER(20,4)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CC_PENY_START ***
 exec bpa.alter_policies('CC_PENY_START');


COMMENT ON TABLE BARS.CC_PENY_START IS '';
COMMENT ON COLUMN BARS.CC_PENY_START.ACC IS '';
COMMENT ON COLUMN BARS.CC_PENY_START.OSTC IS '';
COMMENT ON COLUMN BARS.CC_PENY_START.BRANCH IS '';
COMMENT ON COLUMN BARS.CC_PENY_START.ND IS '';
COMMENT ON COLUMN BARS.CC_PENY_START.ACC_SN8 IS '';
COMMENT ON COLUMN BARS.CC_PENY_START.NLS_SN8 IS '';
COMMENT ON COLUMN BARS.CC_PENY_START.IR IS '';




PROMPT *** Create  constraint PK_CC_PENY_START ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_PENY_START ADD CONSTRAINT PK_CC_PENY_START PRIMARY KEY (ACC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CCPENYSTART_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_PENY_START ADD CONSTRAINT FK_CCPENYSTART_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CCPENYSTART_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_PENY_START MODIFY (BRANCH CONSTRAINT CC_CCPENYSTART_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CC_PENY_START ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CC_PENY_START ON BARS.CC_PENY_START (ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CC_PENY_START ***
grant SELECT                                                                 on CC_PENY_START   to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CC_PENY_START   to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CC_PENY_START.sql =========*** End ***
PROMPT ===================================================================================== 
