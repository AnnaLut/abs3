

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_INT_RATN_PROLONG.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_INT_RATN_PROLONG ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_INT_RATN_PROLONG ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_INT_RATN_PROLONG 
   (	ACC NUMBER(38,0), 
	ID NUMBER, 
	BDAT DATE, 
	IR NUMBER, 
	BR NUMBER(38,0), 
	OP NUMBER(4,0), 
	IDU NUMBER(38,0), 
	KF VARCHAR2(6), 
	NEW_BR NUMBER(38,0), 
	NEW_IR NUMBER, 
	LONLINE NUMBER(9,6), 
	LZP NUMBER(9,6), 
	LINDV_RATE NUMBER(9,6)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_INT_RATN_PROLONG ***
 exec bpa.alter_policies('TMP_INT_RATN_PROLONG');


COMMENT ON TABLE BARS.TMP_INT_RATN_PROLONG IS '';
COMMENT ON COLUMN BARS.TMP_INT_RATN_PROLONG.ACC IS '';
COMMENT ON COLUMN BARS.TMP_INT_RATN_PROLONG.ID IS '';
COMMENT ON COLUMN BARS.TMP_INT_RATN_PROLONG.BDAT IS '';
COMMENT ON COLUMN BARS.TMP_INT_RATN_PROLONG.IR IS '';
COMMENT ON COLUMN BARS.TMP_INT_RATN_PROLONG.BR IS '';
COMMENT ON COLUMN BARS.TMP_INT_RATN_PROLONG.OP IS '';
COMMENT ON COLUMN BARS.TMP_INT_RATN_PROLONG.IDU IS '';
COMMENT ON COLUMN BARS.TMP_INT_RATN_PROLONG.KF IS '';
COMMENT ON COLUMN BARS.TMP_INT_RATN_PROLONG.NEW_BR IS '';
COMMENT ON COLUMN BARS.TMP_INT_RATN_PROLONG.NEW_IR IS '';
COMMENT ON COLUMN BARS.TMP_INT_RATN_PROLONG.LONLINE IS '';
COMMENT ON COLUMN BARS.TMP_INT_RATN_PROLONG.LZP IS '';
COMMENT ON COLUMN BARS.TMP_INT_RATN_PROLONG.LINDV_RATE IS '';




PROMPT *** Create  constraint SYS_C00137249 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INT_RATN_PROLONG MODIFY (ACC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00137250 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INT_RATN_PROLONG MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00137251 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INT_RATN_PROLONG MODIFY (BDAT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00137252 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INT_RATN_PROLONG MODIFY (IDU NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00137253 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INT_RATN_PROLONG MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_INT_RATN_PROLONG ***
grant SELECT                                                                 on TMP_INT_RATN_PROLONG to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_INT_RATN_PROLONG.sql =========*** 
PROMPT ===================================================================================== 
