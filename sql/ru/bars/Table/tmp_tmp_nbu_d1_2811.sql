

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_TMP_NBU_D1_2811.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_TMP_NBU_D1_2811 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_TMP_NBU_D1_2811 ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_TMP_NBU_D1_2811 
   (	KODP VARCHAR2(35), 
	DATF DATE, 
	KODF CHAR(2), 
	ZNAP VARCHAR2(70), 
	NBUC VARCHAR2(30), 
	KF VARCHAR2(6), 
	ERR_MSG VARCHAR2(1000), 
	FL_MOD NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_TMP_NBU_D1_2811 ***
 exec bpa.alter_policies('TMP_TMP_NBU_D1_2811');


COMMENT ON TABLE BARS.TMP_TMP_NBU_D1_2811 IS '';
COMMENT ON COLUMN BARS.TMP_TMP_NBU_D1_2811.KODP IS '';
COMMENT ON COLUMN BARS.TMP_TMP_NBU_D1_2811.DATF IS '';
COMMENT ON COLUMN BARS.TMP_TMP_NBU_D1_2811.KODF IS '';
COMMENT ON COLUMN BARS.TMP_TMP_NBU_D1_2811.ZNAP IS '';
COMMENT ON COLUMN BARS.TMP_TMP_NBU_D1_2811.NBUC IS '';
COMMENT ON COLUMN BARS.TMP_TMP_NBU_D1_2811.KF IS '';
COMMENT ON COLUMN BARS.TMP_TMP_NBU_D1_2811.ERR_MSG IS '';
COMMENT ON COLUMN BARS.TMP_TMP_NBU_D1_2811.FL_MOD IS '';




PROMPT *** Create  constraint SYS_C002512724 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_TMP_NBU_D1_2811 MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002512723 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_TMP_NBU_D1_2811 MODIFY (KODF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002512722 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_TMP_NBU_D1_2811 MODIFY (DATF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002512721 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_TMP_NBU_D1_2811 MODIFY (KODP NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_TMP_NBU_D1_2811.sql =========*** E
PROMPT ===================================================================================== 
