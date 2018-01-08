

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_NADA8.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_NADA8 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_NADA8 ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_NADA8 
   (	DAT1 DATE, 
	DAT2 DATE, 
	BRANCH VARCHAR2(30), 
	PROD VARCHAR2(6), 
	KV NUMBER(3,0), 
	NLS VARCHAR2(15), 
	CC_ID VARCHAR2(50), 
	ND NUMBER(10,0), 
	ID1 VARCHAR2(40), 
	ID2 VARCHAR2(40), 
	SPOK VARCHAR2(40), 
	FIN NUMBER, 
	OBS NUMBER(38,0), 
	NMK VARCHAR2(70), 
	OST NUMBER, 
	ZN50 VARCHAR2(7), 
	MFO_OLD VARCHAR2(6), 
	FINS CHAR(1), 
	S6020 NUMBER, 
	S6040 NUMBER, 
	S6111 NUMBER, 
	S6110 NUMBER, 
	S6113 NUMBER, 
	S6114 NUMBER, 
	S6116 NUMBER, 
	S6118 NUMBER, 
	S6119 NUMBER, 
	S6397 NUMBER, 
	S6399 NUMBER, 
	ACC NUMBER(38,0), 
	OSTQS NUMBER
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_NADA8 ***
 exec bpa.alter_policies('TMP_NADA8');


COMMENT ON TABLE BARS.TMP_NADA8 IS '';
COMMENT ON COLUMN BARS.TMP_NADA8.DAT1 IS '';
COMMENT ON COLUMN BARS.TMP_NADA8.DAT2 IS '';
COMMENT ON COLUMN BARS.TMP_NADA8.BRANCH IS '';
COMMENT ON COLUMN BARS.TMP_NADA8.PROD IS '';
COMMENT ON COLUMN BARS.TMP_NADA8.KV IS '';
COMMENT ON COLUMN BARS.TMP_NADA8.NLS IS '';
COMMENT ON COLUMN BARS.TMP_NADA8.CC_ID IS '';
COMMENT ON COLUMN BARS.TMP_NADA8.ND IS '';
COMMENT ON COLUMN BARS.TMP_NADA8.ID1 IS '';
COMMENT ON COLUMN BARS.TMP_NADA8.ID2 IS '';
COMMENT ON COLUMN BARS.TMP_NADA8.SPOK IS '';
COMMENT ON COLUMN BARS.TMP_NADA8.FIN IS '';
COMMENT ON COLUMN BARS.TMP_NADA8.OBS IS '';
COMMENT ON COLUMN BARS.TMP_NADA8.NMK IS '';
COMMENT ON COLUMN BARS.TMP_NADA8.OST IS '';
COMMENT ON COLUMN BARS.TMP_NADA8.ZN50 IS '';
COMMENT ON COLUMN BARS.TMP_NADA8.MFO_OLD IS '';
COMMENT ON COLUMN BARS.TMP_NADA8.FINS IS '';
COMMENT ON COLUMN BARS.TMP_NADA8.S6020 IS '';
COMMENT ON COLUMN BARS.TMP_NADA8.S6040 IS '';
COMMENT ON COLUMN BARS.TMP_NADA8.S6111 IS '';
COMMENT ON COLUMN BARS.TMP_NADA8.S6110 IS '';
COMMENT ON COLUMN BARS.TMP_NADA8.S6113 IS '';
COMMENT ON COLUMN BARS.TMP_NADA8.S6114 IS '';
COMMENT ON COLUMN BARS.TMP_NADA8.S6116 IS '';
COMMENT ON COLUMN BARS.TMP_NADA8.S6118 IS '';
COMMENT ON COLUMN BARS.TMP_NADA8.S6119 IS '';
COMMENT ON COLUMN BARS.TMP_NADA8.S6397 IS '';
COMMENT ON COLUMN BARS.TMP_NADA8.S6399 IS '';
COMMENT ON COLUMN BARS.TMP_NADA8.ACC IS '';
COMMENT ON COLUMN BARS.TMP_NADA8.OSTQS IS '';




PROMPT *** Create  constraint SYS_C0010255 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_NADA8 MODIFY (ND NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010254 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_NADA8 MODIFY (BRANCH NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_NADA8 ***
grant SELECT                                                                 on TMP_NADA8       to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_NADA8.sql =========*** End *** ===
PROMPT ===================================================================================== 
