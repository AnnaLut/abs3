

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_BR_TIER_EDIT_111.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_BR_TIER_EDIT_111 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_BR_TIER_EDIT_111 ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_BR_TIER_EDIT_111 
   (	BR_ID NUMBER(38,0), 
	BDATE DATE, 
	KV NUMBER(3,0), 
	S NUMBER(24,0), 
	RATE NUMBER(30,8), 
	KF VARCHAR2(6), 
	BR_TP NUMBER, 
	BRANCH VARCHAR2(8)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_BR_TIER_EDIT_111 ***
 exec bpa.alter_policies('TMP_BR_TIER_EDIT_111');


COMMENT ON TABLE BARS.TMP_BR_TIER_EDIT_111 IS '';
COMMENT ON COLUMN BARS.TMP_BR_TIER_EDIT_111.BR_ID IS '';
COMMENT ON COLUMN BARS.TMP_BR_TIER_EDIT_111.BDATE IS '';
COMMENT ON COLUMN BARS.TMP_BR_TIER_EDIT_111.KV IS '';
COMMENT ON COLUMN BARS.TMP_BR_TIER_EDIT_111.S IS '';
COMMENT ON COLUMN BARS.TMP_BR_TIER_EDIT_111.RATE IS '';
COMMENT ON COLUMN BARS.TMP_BR_TIER_EDIT_111.KF IS '';
COMMENT ON COLUMN BARS.TMP_BR_TIER_EDIT_111.BR_TP IS '';
COMMENT ON COLUMN BARS.TMP_BR_TIER_EDIT_111.BRANCH IS '';




PROMPT *** Create  constraint SYS_C00127690 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_BR_TIER_EDIT_111 MODIFY (BR_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00127691 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_BR_TIER_EDIT_111 MODIFY (BDATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00127692 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_BR_TIER_EDIT_111 MODIFY (KV NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00127693 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_BR_TIER_EDIT_111 MODIFY (S NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00127694 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_BR_TIER_EDIT_111 MODIFY (RATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00127695 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_BR_TIER_EDIT_111 MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_BR_TIER_EDIT_111 ***
grant SELECT                                                                 on TMP_BR_TIER_EDIT_111 to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_BR_TIER_EDIT_111 to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_BR_TIER_EDIT_111.sql =========*** 
PROMPT ===================================================================================== 
