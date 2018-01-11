

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_INT_RATN_2282.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_INT_RATN_2282 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_INT_RATN_2282 ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_INT_RATN_2282 
   (	ACC NUMBER(38,0), 
	ID NUMBER, 
	BDAT DATE, 
	IR NUMBER, 
	BR NUMBER(38,0), 
	OP NUMBER(4,0), 
	IDU NUMBER(38,0), 
	KF VARCHAR2(6)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_INT_RATN_2282 ***
 exec bpa.alter_policies('TMP_INT_RATN_2282');


COMMENT ON TABLE BARS.TMP_INT_RATN_2282 IS '';
COMMENT ON COLUMN BARS.TMP_INT_RATN_2282.ACC IS '';
COMMENT ON COLUMN BARS.TMP_INT_RATN_2282.ID IS '';
COMMENT ON COLUMN BARS.TMP_INT_RATN_2282.BDAT IS '';
COMMENT ON COLUMN BARS.TMP_INT_RATN_2282.IR IS '';
COMMENT ON COLUMN BARS.TMP_INT_RATN_2282.BR IS '';
COMMENT ON COLUMN BARS.TMP_INT_RATN_2282.OP IS '';
COMMENT ON COLUMN BARS.TMP_INT_RATN_2282.IDU IS '';
COMMENT ON COLUMN BARS.TMP_INT_RATN_2282.KF IS '';




PROMPT *** Create  constraint SYS_C00137331 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INT_RATN_2282 MODIFY (ACC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00137332 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INT_RATN_2282 MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00137333 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INT_RATN_2282 MODIFY (BDAT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00137334 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INT_RATN_2282 MODIFY (IDU NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00137335 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INT_RATN_2282 MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_INT_RATN_2282 ***
grant SELECT                                                                 on TMP_INT_RATN_2282 to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_INT_RATN_2282.sql =========*** End
PROMPT ===================================================================================== 
