

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/S6_CONTRACT1.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to S6_CONTRACT1 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table S6_CONTRACT1 ***
begin 
  execute immediate '
  CREATE TABLE BARS.S6_CONTRACT1 
   (	BIC NUMBER(10,0), 
	IDCONTRACT VARCHAR2(40), 
	VIDCONTRACT NUMBER(5,0), 
	TARGET NUMBER(5,0), 
	CONTRPARENT VARCHAR2(40), 
	STRPERCEN NUMBER(9,4), 
	D_OPEN DATE, 
	D_CLOSE DATE, 
	D_BEGIN DATE, 
	D_DIST DATE, 
	D_RETURN DATE, 
	D_CANCEL DATE, 
	D_MODIFY DATE, 
	SUMMA NUMBER(16,2), 
	I_VA NUMBER(5,0), 
	IDCLIENT NUMBER(10,0), 
	VID_KRED NUMBER(3,0), 
	V_MAIN NUMBER(3,0), 
	N_PROLONG NUMBER(5,0), 
	C_RISK NUMBER(3,0), 
	EMITENT NUMBER(3,0), 
	EMIS NUMBER(3,0), 
	PAPER NUMBER(3,0), 
	QUOT NUMBER(3,0), 
	TERM CHAR(1), 
	T_KR NUMBER(3,0), 
	PROLONG CHAR(1), 
	SOURCE NUMBER(3,0), 
	PERREP NUMBER(3,0), 
	N_APPL VARCHAR2(20), 
	D_APPL DATE, 
	N_DCC VARCHAR2(20), 
	D_DCC DATE, 
	DESCRIPTION VARCHAR2(150), 
	ISP_OWNER NUMBER(5,0), 
	GROUP_C NUMBER(3,0), 
	STATUS NUMBER(3,0), 
	ISP_MODIFY NUMBER(5,0), 
	DOC_MODIFY NUMBER(10,0), 
	JURIDNUMBER VARCHAR2(40), 
	METHODCI NUMBER(3,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to S6_CONTRACT1 ***
 exec bpa.alter_policies('S6_CONTRACT1');


COMMENT ON TABLE BARS.S6_CONTRACT1 IS '';
COMMENT ON COLUMN BARS.S6_CONTRACT1.PERREP IS '';
COMMENT ON COLUMN BARS.S6_CONTRACT1.N_APPL IS '';
COMMENT ON COLUMN BARS.S6_CONTRACT1.D_APPL IS '';
COMMENT ON COLUMN BARS.S6_CONTRACT1.N_DCC IS '';
COMMENT ON COLUMN BARS.S6_CONTRACT1.D_DCC IS '';
COMMENT ON COLUMN BARS.S6_CONTRACT1.DESCRIPTION IS '';
COMMENT ON COLUMN BARS.S6_CONTRACT1.ISP_OWNER IS '';
COMMENT ON COLUMN BARS.S6_CONTRACT1.GROUP_C IS '';
COMMENT ON COLUMN BARS.S6_CONTRACT1.STATUS IS '';
COMMENT ON COLUMN BARS.S6_CONTRACT1.ISP_MODIFY IS '';
COMMENT ON COLUMN BARS.S6_CONTRACT1.DOC_MODIFY IS '';
COMMENT ON COLUMN BARS.S6_CONTRACT1.JURIDNUMBER IS '';
COMMENT ON COLUMN BARS.S6_CONTRACT1.METHODCI IS '';
COMMENT ON COLUMN BARS.S6_CONTRACT1.BIC IS '';
COMMENT ON COLUMN BARS.S6_CONTRACT1.IDCONTRACT IS '';
COMMENT ON COLUMN BARS.S6_CONTRACT1.VIDCONTRACT IS '';
COMMENT ON COLUMN BARS.S6_CONTRACT1.TARGET IS '';
COMMENT ON COLUMN BARS.S6_CONTRACT1.CONTRPARENT IS '';
COMMENT ON COLUMN BARS.S6_CONTRACT1.STRPERCEN IS '';
COMMENT ON COLUMN BARS.S6_CONTRACT1.D_OPEN IS '';
COMMENT ON COLUMN BARS.S6_CONTRACT1.D_CLOSE IS '';
COMMENT ON COLUMN BARS.S6_CONTRACT1.D_BEGIN IS '';
COMMENT ON COLUMN BARS.S6_CONTRACT1.D_DIST IS '';
COMMENT ON COLUMN BARS.S6_CONTRACT1.D_RETURN IS '';
COMMENT ON COLUMN BARS.S6_CONTRACT1.D_CANCEL IS '';
COMMENT ON COLUMN BARS.S6_CONTRACT1.D_MODIFY IS '';
COMMENT ON COLUMN BARS.S6_CONTRACT1.SUMMA IS '';
COMMENT ON COLUMN BARS.S6_CONTRACT1.I_VA IS '';
COMMENT ON COLUMN BARS.S6_CONTRACT1.IDCLIENT IS '';
COMMENT ON COLUMN BARS.S6_CONTRACT1.VID_KRED IS '';
COMMENT ON COLUMN BARS.S6_CONTRACT1.V_MAIN IS '';
COMMENT ON COLUMN BARS.S6_CONTRACT1.N_PROLONG IS '';
COMMENT ON COLUMN BARS.S6_CONTRACT1.C_RISK IS '';
COMMENT ON COLUMN BARS.S6_CONTRACT1.EMITENT IS '';
COMMENT ON COLUMN BARS.S6_CONTRACT1.EMIS IS '';
COMMENT ON COLUMN BARS.S6_CONTRACT1.PAPER IS '';
COMMENT ON COLUMN BARS.S6_CONTRACT1.QUOT IS '';
COMMENT ON COLUMN BARS.S6_CONTRACT1.TERM IS '';
COMMENT ON COLUMN BARS.S6_CONTRACT1.T_KR IS '';
COMMENT ON COLUMN BARS.S6_CONTRACT1.PROLONG IS '';
COMMENT ON COLUMN BARS.S6_CONTRACT1.SOURCE IS '';




PROMPT *** Create  constraint SYS_C0020249 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_CONTRACT1 MODIFY (STATUS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0020248 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_CONTRACT1 MODIFY (GROUP_C NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0020247 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_CONTRACT1 MODIFY (IDCLIENT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0020246 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_CONTRACT1 MODIFY (VIDCONTRACT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0020245 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_CONTRACT1 MODIFY (IDCONTRACT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0020244 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_CONTRACT1 MODIFY (BIC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index S6_CONTRACT1_ID ***
begin   
 execute immediate '
  CREATE INDEX BARS.S6_CONTRACT1_ID ON BARS.S6_CONTRACT1 (IDCONTRACT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/S6_CONTRACT1.sql =========*** End *** 
PROMPT ===================================================================================== 
