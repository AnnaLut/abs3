

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_NBU_F4.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_NBU_F4 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_NBU_F4 ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_NBU_F4 
   (	KODP VARCHAR2(35), 
	DATF DATE, 
	KODF CHAR(2), 
	ZNAP VARCHAR2(254), 
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




PROMPT *** ALTER_POLICIES to TMP_NBU_F4 ***
 exec bpa.alter_policies('TMP_NBU_F4');


COMMENT ON TABLE BARS.TMP_NBU_F4 IS '';
COMMENT ON COLUMN BARS.TMP_NBU_F4.KODP IS '';
COMMENT ON COLUMN BARS.TMP_NBU_F4.DATF IS '';
COMMENT ON COLUMN BARS.TMP_NBU_F4.KODF IS '';
COMMENT ON COLUMN BARS.TMP_NBU_F4.ZNAP IS '';
COMMENT ON COLUMN BARS.TMP_NBU_F4.NBUC IS '';
COMMENT ON COLUMN BARS.TMP_NBU_F4.KF IS '';
COMMENT ON COLUMN BARS.TMP_NBU_F4.ERR_MSG IS '';
COMMENT ON COLUMN BARS.TMP_NBU_F4.FL_MOD IS '';




PROMPT *** Create  constraint SYS_C00139787 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_NBU_F4 MODIFY (KODP NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00139788 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_NBU_F4 MODIFY (DATF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00139789 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_NBU_F4 MODIFY (KODF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00139790 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_NBU_F4 MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_NBU_F4.sql =========*** End *** ==
PROMPT ===================================================================================== 
