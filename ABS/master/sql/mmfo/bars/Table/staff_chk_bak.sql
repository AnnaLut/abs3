

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/STAFF_CHK_BAK.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to STAFF_CHK_BAK ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table STAFF_CHK_BAK ***
begin 
  execute immediate '
  CREATE TABLE BARS.STAFF_CHK_BAK 
   (	ID NUMBER(38,0), 
	CHKID NUMBER(38,0), 
	APPROVE NUMBER(1,0), 
	ADATE1 DATE, 
	ADATE2 DATE, 
	RDATE1 DATE, 
	RDATE2 DATE, 
	REVOKED NUMBER(1,0), 
	GRANTOR NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to STAFF_CHK_BAK ***
 exec bpa.alter_policies('STAFF_CHK_BAK');


COMMENT ON TABLE BARS.STAFF_CHK_BAK IS '';
COMMENT ON COLUMN BARS.STAFF_CHK_BAK.ID IS '';
COMMENT ON COLUMN BARS.STAFF_CHK_BAK.CHKID IS '';
COMMENT ON COLUMN BARS.STAFF_CHK_BAK.APPROVE IS '';
COMMENT ON COLUMN BARS.STAFF_CHK_BAK.ADATE1 IS '';
COMMENT ON COLUMN BARS.STAFF_CHK_BAK.ADATE2 IS '';
COMMENT ON COLUMN BARS.STAFF_CHK_BAK.RDATE1 IS '';
COMMENT ON COLUMN BARS.STAFF_CHK_BAK.RDATE2 IS '';
COMMENT ON COLUMN BARS.STAFF_CHK_BAK.REVOKED IS '';
COMMENT ON COLUMN BARS.STAFF_CHK_BAK.GRANTOR IS '';




PROMPT *** Create  constraint SYS_C0025771 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_CHK_BAK MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0025772 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_CHK_BAK MODIFY (CHKID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/STAFF_CHK_BAK.sql =========*** End ***
PROMPT ===================================================================================== 
