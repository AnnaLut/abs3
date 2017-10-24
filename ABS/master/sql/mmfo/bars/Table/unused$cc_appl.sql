

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/UNUSED$CC_APPL.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to UNUSED$CC_APPL ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table UNUSED$CC_APPL ***
begin 
  execute immediate '
  CREATE TABLE BARS.UNUSED$CC_APPL 
   (	NA NUMBER(24,0), 
	SOS NUMBER(*,0), 
	RNK NUMBER(*,0), 
	TIPD NUMBER(4,0), 
	ADATE DATE DEFAULT SYSDATE, 
	BDATE DATE DEFAULT SYSDATE, 
	MDATE DATE DEFAULT SYSDATE, 
	S NUMBER(24,0), 
	KV NUMBER(*,0), 
	PR NUMBER(9,4), 
	VDATE DATE DEFAULT SYSDATE, 
	ND NUMBER(10,0), 
	REJ_REASON VARCHAR2(70)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to UNUSED$CC_APPL ***
 exec bpa.alter_policies('UNUSED$CC_APPL');


COMMENT ON TABLE BARS.UNUSED$CC_APPL IS 'NOT USING';
COMMENT ON COLUMN BARS.UNUSED$CC_APPL.NA IS '';
COMMENT ON COLUMN BARS.UNUSED$CC_APPL.SOS IS '';
COMMENT ON COLUMN BARS.UNUSED$CC_APPL.RNK IS '';
COMMENT ON COLUMN BARS.UNUSED$CC_APPL.TIPD IS '';
COMMENT ON COLUMN BARS.UNUSED$CC_APPL.ADATE IS '';
COMMENT ON COLUMN BARS.UNUSED$CC_APPL.BDATE IS '';
COMMENT ON COLUMN BARS.UNUSED$CC_APPL.MDATE IS '';
COMMENT ON COLUMN BARS.UNUSED$CC_APPL.S IS '';
COMMENT ON COLUMN BARS.UNUSED$CC_APPL.KV IS '';
COMMENT ON COLUMN BARS.UNUSED$CC_APPL.PR IS '';
COMMENT ON COLUMN BARS.UNUSED$CC_APPL.VDATE IS '';
COMMENT ON COLUMN BARS.UNUSED$CC_APPL.ND IS '';
COMMENT ON COLUMN BARS.UNUSED$CC_APPL.REJ_REASON IS '';




PROMPT *** Create  constraint XPK_CC_APPL ***
begin   
 execute immediate '
  ALTER TABLE BARS.UNUSED$CC_APPL ADD CONSTRAINT XPK_CC_APPL PRIMARY KEY (NA)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_CC_APPL_NA ***
begin   
 execute immediate '
  ALTER TABLE BARS.UNUSED$CC_APPL MODIFY (NA CONSTRAINT NK_CC_APPL_NA NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CC_APPL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CC_APPL ON BARS.UNUSED$CC_APPL (NA) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  UNUSED$CC_APPL ***
grant SELECT                                                                 on UNUSED$CC_APPL  to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on UNUSED$CC_APPL  to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/UNUSED$CC_APPL.sql =========*** End **
PROMPT ===================================================================================== 
