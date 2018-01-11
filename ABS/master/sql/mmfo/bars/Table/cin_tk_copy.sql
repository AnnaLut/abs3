

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIN_TK_COPY.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIN_TK_COPY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIN_TK_COPY'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIN_TK_COPY'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIN_TK_COPY'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIN_TK_COPY ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIN_TK_COPY 
   (	ID NUMBER(*,0), 
	RNK NUMBER(*,0), 
	MFO VARCHAR2(12), 
	NLS VARCHAR2(14), 
	S_A2 NUMBER, 
	NLSR VARCHAR2(14), 
	S_B2 NUMBER, 
	NAME VARCHAR2(38), 
	PR_B1 NUMBER, 
	S_C0 NUMBER, 
	BRANCH VARCHAR2(22), 
	SB1_MIN NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIN_TK_COPY ***
 exec bpa.alter_policies('CIN_TK_COPY');


COMMENT ON TABLE BARS.CIN_TK_COPY IS '';
COMMENT ON COLUMN BARS.CIN_TK_COPY.ID IS '';
COMMENT ON COLUMN BARS.CIN_TK_COPY.RNK IS '';
COMMENT ON COLUMN BARS.CIN_TK_COPY.MFO IS '';
COMMENT ON COLUMN BARS.CIN_TK_COPY.NLS IS '';
COMMENT ON COLUMN BARS.CIN_TK_COPY.S_A2 IS '';
COMMENT ON COLUMN BARS.CIN_TK_COPY.NLSR IS '';
COMMENT ON COLUMN BARS.CIN_TK_COPY.S_B2 IS '';
COMMENT ON COLUMN BARS.CIN_TK_COPY.NAME IS '';
COMMENT ON COLUMN BARS.CIN_TK_COPY.PR_B1 IS '';
COMMENT ON COLUMN BARS.CIN_TK_COPY.S_C0 IS '';
COMMENT ON COLUMN BARS.CIN_TK_COPY.BRANCH IS '';
COMMENT ON COLUMN BARS.CIN_TK_COPY.SB1_MIN IS '';




PROMPT *** Create  constraint SYS_C005518 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIN_TK_COPY MODIFY (RNK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005519 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIN_TK_COPY MODIFY (MFO NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005520 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIN_TK_COPY MODIFY (NLS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005521 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIN_TK_COPY MODIFY (NLSR NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005522 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIN_TK_COPY MODIFY (PR_B1 NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CIN_TK_COPY ***
grant SELECT                                                                 on CIN_TK_COPY     to BARSREADER_ROLE;
grant SELECT                                                                 on CIN_TK_COPY     to BARS_DM;
grant SELECT                                                                 on CIN_TK_COPY     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIN_TK_COPY.sql =========*** End *** =
PROMPT ===================================================================================== 
