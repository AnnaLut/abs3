

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/APPLIST_STAFF_BAK.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to APPLIST_STAFF_BAK ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table APPLIST_STAFF_BAK ***
begin 
  execute immediate '
  CREATE TABLE BARS.APPLIST_STAFF_BAK 
   (	ID NUMBER(38,0), 
	CODEAPP VARCHAR2(30 CHAR), 
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




PROMPT *** ALTER_POLICIES to APPLIST_STAFF_BAK ***
 exec bpa.alter_policies('APPLIST_STAFF_BAK');


COMMENT ON TABLE BARS.APPLIST_STAFF_BAK IS '';
COMMENT ON COLUMN BARS.APPLIST_STAFF_BAK.ID IS '';
COMMENT ON COLUMN BARS.APPLIST_STAFF_BAK.CODEAPP IS '';
COMMENT ON COLUMN BARS.APPLIST_STAFF_BAK.APPROVE IS '';
COMMENT ON COLUMN BARS.APPLIST_STAFF_BAK.ADATE1 IS '';
COMMENT ON COLUMN BARS.APPLIST_STAFF_BAK.ADATE2 IS '';
COMMENT ON COLUMN BARS.APPLIST_STAFF_BAK.RDATE1 IS '';
COMMENT ON COLUMN BARS.APPLIST_STAFF_BAK.RDATE2 IS '';
COMMENT ON COLUMN BARS.APPLIST_STAFF_BAK.REVOKED IS '';
COMMENT ON COLUMN BARS.APPLIST_STAFF_BAK.GRANTOR IS '';




PROMPT *** Create  constraint SYS_C0025761 ***
begin   
 execute immediate '
  ALTER TABLE BARS.APPLIST_STAFF_BAK MODIFY (CODEAPP NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0025760 ***
begin   
 execute immediate '
  ALTER TABLE BARS.APPLIST_STAFF_BAK MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  APPLIST_STAFF_BAK ***
grant SELECT                                                                 on APPLIST_STAFF_BAK to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/APPLIST_STAFF_BAK.sql =========*** End
PROMPT ===================================================================================== 
