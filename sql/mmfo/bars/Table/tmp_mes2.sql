

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_MES2.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_MES2 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_MES2 ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_MES2 
   (	ND NUMBER(10,0), 
	IDL1 VARCHAR2(40), 
	IDL2 VARCHAR2(40), 
	BRANCH VARCHAR2(30), 
	NAME_RU VARCHAR2(70), 
	NAME_PP VARCHAR2(70), 
	SEGMENT NUMBER(38,0), 
	TXT VARCHAR2(254), 
	NMK VARCHAR2(70), 
	T_T NUMBER, 
	T_P NUMBER, 
	T_K NUMBER, 
	P_T NUMBER, 
	P_P NUMBER, 
	P_K NUMBER
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_MES2 ***
 exec bpa.alter_policies('TMP_MES2');


COMMENT ON TABLE BARS.TMP_MES2 IS '';
COMMENT ON COLUMN BARS.TMP_MES2.ND IS '';
COMMENT ON COLUMN BARS.TMP_MES2.IDL1 IS '';
COMMENT ON COLUMN BARS.TMP_MES2.IDL2 IS '';
COMMENT ON COLUMN BARS.TMP_MES2.BRANCH IS '';
COMMENT ON COLUMN BARS.TMP_MES2.NAME_RU IS '';
COMMENT ON COLUMN BARS.TMP_MES2.NAME_PP IS '';
COMMENT ON COLUMN BARS.TMP_MES2.SEGMENT IS '';
COMMENT ON COLUMN BARS.TMP_MES2.TXT IS '';
COMMENT ON COLUMN BARS.TMP_MES2.NMK IS '';
COMMENT ON COLUMN BARS.TMP_MES2.T_T IS '';
COMMENT ON COLUMN BARS.TMP_MES2.T_P IS '';
COMMENT ON COLUMN BARS.TMP_MES2.T_K IS '';
COMMENT ON COLUMN BARS.TMP_MES2.P_T IS '';
COMMENT ON COLUMN BARS.TMP_MES2.P_P IS '';
COMMENT ON COLUMN BARS.TMP_MES2.P_K IS '';




PROMPT *** Create  constraint XPK_TMPMES2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_MES2 ADD CONSTRAINT XPK_TMPMES2 PRIMARY KEY (ND) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010398 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_MES2 MODIFY (ND NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010401 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_MES2 MODIFY (NAME_PP NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010400 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_MES2 MODIFY (NAME_RU NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010399 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_MES2 MODIFY (BRANCH NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_TMPMES2 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_TMPMES2 ON BARS.TMP_MES2 (ND) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_MES2 ***
grant SELECT                                                                 on TMP_MES2        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_MES2        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_MES2.sql =========*** End *** ====
PROMPT ===================================================================================== 
