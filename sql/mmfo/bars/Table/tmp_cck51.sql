

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_CCK51.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_CCK51 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_CCK51 ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_CCK51 
   (	BRANCH VARCHAR2(22), 
	SPOK VARCHAR2(7), 
	KV NUMBER(38,0), 
	SEGM VARCHAR2(7), 
	B1 DATE, 
	E1 DATE, 
	S11 NUMBER(18,2), 
	S12 NUMBER(18,2), 
	S13 NUMBER(18,2), 
	S14 NUMBER(18,2), 
	S15 NUMBER(18,2), 
	S16 NUMBER(18,2), 
	S17 NUMBER(18,2), 
	ND NUMBER(38,0), 
	CC_ID VARCHAR2(20), 
	RNK NUMBER(38,0), 
	SDATE DATE, 
	WDATE DATE, 
	V11 NUMBER(18,2), 
	V12 NUMBER(18,2), 
	V13 NUMBER(18,2), 
	V14 NUMBER(18,2), 
	V15 NUMBER(18,2), 
	V16 NUMBER(18,2), 
	V17 NUMBER(18,2), 
	PROD CHAR(6), 
	ZN50 VARCHAR2(7)
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_CCK51 ***
 exec bpa.alter_policies('TMP_CCK51');


COMMENT ON TABLE BARS.TMP_CCK51 IS '';
COMMENT ON COLUMN BARS.TMP_CCK51.BRANCH IS '';
COMMENT ON COLUMN BARS.TMP_CCK51.SPOK IS '';
COMMENT ON COLUMN BARS.TMP_CCK51.KV IS '';
COMMENT ON COLUMN BARS.TMP_CCK51.SEGM IS '';
COMMENT ON COLUMN BARS.TMP_CCK51.B1 IS '';
COMMENT ON COLUMN BARS.TMP_CCK51.E1 IS '';
COMMENT ON COLUMN BARS.TMP_CCK51.S11 IS '';
COMMENT ON COLUMN BARS.TMP_CCK51.S12 IS '';
COMMENT ON COLUMN BARS.TMP_CCK51.S13 IS '';
COMMENT ON COLUMN BARS.TMP_CCK51.S14 IS '';
COMMENT ON COLUMN BARS.TMP_CCK51.S15 IS '';
COMMENT ON COLUMN BARS.TMP_CCK51.S16 IS '';
COMMENT ON COLUMN BARS.TMP_CCK51.S17 IS '';
COMMENT ON COLUMN BARS.TMP_CCK51.ND IS '';
COMMENT ON COLUMN BARS.TMP_CCK51.CC_ID IS '';
COMMENT ON COLUMN BARS.TMP_CCK51.RNK IS '';
COMMENT ON COLUMN BARS.TMP_CCK51.SDATE IS '';
COMMENT ON COLUMN BARS.TMP_CCK51.WDATE IS '';
COMMENT ON COLUMN BARS.TMP_CCK51.V11 IS '';
COMMENT ON COLUMN BARS.TMP_CCK51.V12 IS '';
COMMENT ON COLUMN BARS.TMP_CCK51.V13 IS '';
COMMENT ON COLUMN BARS.TMP_CCK51.V14 IS '';
COMMENT ON COLUMN BARS.TMP_CCK51.V15 IS '';
COMMENT ON COLUMN BARS.TMP_CCK51.V16 IS '';
COMMENT ON COLUMN BARS.TMP_CCK51.V17 IS '';
COMMENT ON COLUMN BARS.TMP_CCK51.PROD IS '';
COMMENT ON COLUMN BARS.TMP_CCK51.ZN50 IS '';




PROMPT *** Create  constraint XPK_TMPCCK51_ND ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_CCK51 ADD CONSTRAINT XPK_TMPCCK51_ND PRIMARY KEY (ND, B1, E1) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_TMPCCK51_ND ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_TMPCCK51_ND ON BARS.TMP_CCK51 (ND, B1, E1) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_CCK51 ***
grant SELECT                                                                 on TMP_CCK51       to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_CCK51       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_CCK51       to RCC_DEAL;
grant SELECT                                                                 on TMP_CCK51       to SALGL;
grant SELECT                                                                 on TMP_CCK51       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_CCK51.sql =========*** End *** ===
PROMPT ===================================================================================== 