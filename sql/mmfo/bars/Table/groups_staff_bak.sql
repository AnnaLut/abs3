

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/GROUPS_STAFF_BAK.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to GROUPS_STAFF_BAK ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table GROUPS_STAFF_BAK ***
begin 
  execute immediate '
  CREATE TABLE BARS.GROUPS_STAFF_BAK 
   (	IDU NUMBER(38,0), 
	IDG NUMBER(38,0), 
	SECG NUMBER(1,0), 
	APPROVE NUMBER(1,0), 
	ADATE1 DATE, 
	ADATE2 DATE, 
	RDATE1 DATE, 
	RDATE2 DATE, 
	REVOKED NUMBER(1,0), 
	GRANTOR NUMBER(38,0), 
	SEC_SEL NUMBER(1,0), 
	SEC_CRE NUMBER(1,0), 
	SEC_DEB NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to GROUPS_STAFF_BAK ***
 exec bpa.alter_policies('GROUPS_STAFF_BAK');


COMMENT ON TABLE BARS.GROUPS_STAFF_BAK IS '';
COMMENT ON COLUMN BARS.GROUPS_STAFF_BAK.IDU IS '';
COMMENT ON COLUMN BARS.GROUPS_STAFF_BAK.IDG IS '';
COMMENT ON COLUMN BARS.GROUPS_STAFF_BAK.SECG IS '';
COMMENT ON COLUMN BARS.GROUPS_STAFF_BAK.APPROVE IS '';
COMMENT ON COLUMN BARS.GROUPS_STAFF_BAK.ADATE1 IS '';
COMMENT ON COLUMN BARS.GROUPS_STAFF_BAK.ADATE2 IS '';
COMMENT ON COLUMN BARS.GROUPS_STAFF_BAK.RDATE1 IS '';
COMMENT ON COLUMN BARS.GROUPS_STAFF_BAK.RDATE2 IS '';
COMMENT ON COLUMN BARS.GROUPS_STAFF_BAK.REVOKED IS '';
COMMENT ON COLUMN BARS.GROUPS_STAFF_BAK.GRANTOR IS '';
COMMENT ON COLUMN BARS.GROUPS_STAFF_BAK.SEC_SEL IS '';
COMMENT ON COLUMN BARS.GROUPS_STAFF_BAK.SEC_CRE IS '';
COMMENT ON COLUMN BARS.GROUPS_STAFF_BAK.SEC_DEB IS '';




PROMPT *** Create  constraint SYS_C0025770 ***
begin   
 execute immediate '
  ALTER TABLE BARS.GROUPS_STAFF_BAK MODIFY (IDG NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0025769 ***
begin   
 execute immediate '
  ALTER TABLE BARS.GROUPS_STAFF_BAK MODIFY (IDU NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  GROUPS_STAFF_BAK ***
grant SELECT                                                                 on GROUPS_STAFF_BAK to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/GROUPS_STAFF_BAK.sql =========*** End 
PROMPT ===================================================================================== 
