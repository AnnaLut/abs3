

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_CCK5R.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_CCK5R ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_CCK5R ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_CCK5R 
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




PROMPT *** ALTER_POLICIES to TMP_CCK5R ***
 exec bpa.alter_policies('TMP_CCK5R');


COMMENT ON TABLE BARS.TMP_CCK5R IS '';
COMMENT ON COLUMN BARS.TMP_CCK5R.BRANCH IS '';
COMMENT ON COLUMN BARS.TMP_CCK5R.SPOK IS '';
COMMENT ON COLUMN BARS.TMP_CCK5R.KV IS '';
COMMENT ON COLUMN BARS.TMP_CCK5R.SEGM IS '';
COMMENT ON COLUMN BARS.TMP_CCK5R.B1 IS '';
COMMENT ON COLUMN BARS.TMP_CCK5R.E1 IS '';
COMMENT ON COLUMN BARS.TMP_CCK5R.S11 IS '';
COMMENT ON COLUMN BARS.TMP_CCK5R.S12 IS '';
COMMENT ON COLUMN BARS.TMP_CCK5R.S13 IS '';
COMMENT ON COLUMN BARS.TMP_CCK5R.S14 IS '';
COMMENT ON COLUMN BARS.TMP_CCK5R.S15 IS '';
COMMENT ON COLUMN BARS.TMP_CCK5R.S16 IS '';
COMMENT ON COLUMN BARS.TMP_CCK5R.S17 IS '';
COMMENT ON COLUMN BARS.TMP_CCK5R.ND IS '';
COMMENT ON COLUMN BARS.TMP_CCK5R.CC_ID IS '';
COMMENT ON COLUMN BARS.TMP_CCK5R.RNK IS '';
COMMENT ON COLUMN BARS.TMP_CCK5R.SDATE IS '';
COMMENT ON COLUMN BARS.TMP_CCK5R.WDATE IS '';
COMMENT ON COLUMN BARS.TMP_CCK5R.V11 IS '';
COMMENT ON COLUMN BARS.TMP_CCK5R.V12 IS '';
COMMENT ON COLUMN BARS.TMP_CCK5R.V13 IS '';
COMMENT ON COLUMN BARS.TMP_CCK5R.V14 IS '';
COMMENT ON COLUMN BARS.TMP_CCK5R.V15 IS '';
COMMENT ON COLUMN BARS.TMP_CCK5R.V16 IS '';
COMMENT ON COLUMN BARS.TMP_CCK5R.V17 IS '';
COMMENT ON COLUMN BARS.TMP_CCK5R.PROD IS '';
COMMENT ON COLUMN BARS.TMP_CCK5R.ZN50 IS '';




PROMPT *** Create  constraint XPK_TMPCCK5R_ND ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_CCK5R ADD CONSTRAINT XPK_TMPCCK5R_ND PRIMARY KEY (ND, B1, E1) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_TMPCCK5R_ND ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_TMPCCK5R_ND ON BARS.TMP_CCK5R (ND, B1, E1) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_CCK5R ***
grant SELECT                                                                 on TMP_CCK5R       to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_CCK5R       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_CCK5R       to RCC_DEAL;
grant SELECT                                                                 on TMP_CCK5R       to SALGL;
grant SELECT                                                                 on TMP_CCK5R       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_CCK5R.sql =========*** End *** ===
PROMPT ===================================================================================== 
