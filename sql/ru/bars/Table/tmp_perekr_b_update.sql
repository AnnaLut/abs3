

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_PEREKR_B_UPDATE.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_PEREKR_B_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_PEREKR_B_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_PEREKR_B_UPDATE 
   (	ID NUMBER, 
	IDS NUMBER, 
	TT CHAR(9), 
	MFOB NUMBER, 
	NLSB VARCHAR2(15), 
	POLU VARCHAR2(47), 
	NAZN VARCHAR2(160), 
	OKPO VARCHAR2(10), 
	IDR NUMBER, 
	KOEF NUMBER, 
	VOB NUMBER, 
	FORMULA VARCHAR2(255), 
	KOD NUMBER(1,0), 
	FDAT DATE, 
	USER_NAME VARCHAR2(30), 
	IDUPD NUMBER, 
	CHACTION NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_PEREKR_B_UPDATE ***
 exec bpa.alter_policies('TMP_PEREKR_B_UPDATE');


COMMENT ON TABLE BARS.TMP_PEREKR_B_UPDATE IS '';
COMMENT ON COLUMN BARS.TMP_PEREKR_B_UPDATE.ID IS '';
COMMENT ON COLUMN BARS.TMP_PEREKR_B_UPDATE.IDS IS '';
COMMENT ON COLUMN BARS.TMP_PEREKR_B_UPDATE.TT IS '';
COMMENT ON COLUMN BARS.TMP_PEREKR_B_UPDATE.MFOB IS '';
COMMENT ON COLUMN BARS.TMP_PEREKR_B_UPDATE.NLSB IS '';
COMMENT ON COLUMN BARS.TMP_PEREKR_B_UPDATE.POLU IS '';
COMMENT ON COLUMN BARS.TMP_PEREKR_B_UPDATE.NAZN IS '';
COMMENT ON COLUMN BARS.TMP_PEREKR_B_UPDATE.OKPO IS '';
COMMENT ON COLUMN BARS.TMP_PEREKR_B_UPDATE.IDR IS '';
COMMENT ON COLUMN BARS.TMP_PEREKR_B_UPDATE.KOEF IS '';
COMMENT ON COLUMN BARS.TMP_PEREKR_B_UPDATE.VOB IS '';
COMMENT ON COLUMN BARS.TMP_PEREKR_B_UPDATE.FORMULA IS '';
COMMENT ON COLUMN BARS.TMP_PEREKR_B_UPDATE.KOD IS '';
COMMENT ON COLUMN BARS.TMP_PEREKR_B_UPDATE.FDAT IS '';
COMMENT ON COLUMN BARS.TMP_PEREKR_B_UPDATE.USER_NAME IS '';
COMMENT ON COLUMN BARS.TMP_PEREKR_B_UPDATE.IDUPD IS '';
COMMENT ON COLUMN BARS.TMP_PEREKR_B_UPDATE.CHACTION IS '';




PROMPT *** Create  constraint SYS_C003228959 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_PEREKR_B_UPDATE MODIFY (USER_NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003228958 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_PEREKR_B_UPDATE MODIFY (FDAT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003228957 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_PEREKR_B_UPDATE MODIFY (VOB NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003228956 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_PEREKR_B_UPDATE MODIFY (IDR NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003228955 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_PEREKR_B_UPDATE MODIFY (NAZN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003228954 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_PEREKR_B_UPDATE MODIFY (POLU NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003228953 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_PEREKR_B_UPDATE MODIFY (NLSB NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003228952 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_PEREKR_B_UPDATE MODIFY (MFOB NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003228951 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_PEREKR_B_UPDATE MODIFY (TT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003228950 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_PEREKR_B_UPDATE MODIFY (IDS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003228949 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_PEREKR_B_UPDATE MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_PEREKR_B_UPDATE.sql =========*** E
PROMPT ===================================================================================== 
