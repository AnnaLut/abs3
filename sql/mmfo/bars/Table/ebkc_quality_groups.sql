

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EBKC_QUALITY_GROUPS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EBKC_QUALITY_GROUPS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''EBKC_QUALITY_GROUPS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''EBKC_QUALITY_GROUPS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table EBKC_QUALITY_GROUPS ***
begin 
  execute immediate '
  CREATE TABLE BARS.EBKC_QUALITY_GROUPS 
   (	QG_ID NUMBER, 
	QG_NAME VARCHAR2(250), 
	CUST_TYPE VARCHAR2(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to EBKC_QUALITY_GROUPS ***
 exec bpa.alter_policies('EBKC_QUALITY_GROUPS');


COMMENT ON TABLE BARS.EBKC_QUALITY_GROUPS IS 'Таблиця груп якостi';
COMMENT ON COLUMN BARS.EBKC_QUALITY_GROUPS.QG_ID IS 'Iд.';
COMMENT ON COLUMN BARS.EBKC_QUALITY_GROUPS.QG_NAME IS 'Назва групи якостi';
COMMENT ON COLUMN BARS.EBKC_QUALITY_GROUPS.CUST_TYPE IS '';




PROMPT *** Create  constraint SYS_C0032181 ***
begin   
 execute immediate '
  ALTER TABLE BARS.EBKC_QUALITY_GROUPS MODIFY (QG_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0032182 ***
begin   
 execute immediate '
  ALTER TABLE BARS.EBKC_QUALITY_GROUPS MODIFY (QG_NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_EBKC_QUALITY_GROUPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.EBKC_QUALITY_GROUPS ADD CONSTRAINT PK_EBKC_QUALITY_GROUPS PRIMARY KEY (QG_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_EBKC_QUALITY_GROUPS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_EBKC_QUALITY_GROUPS ON BARS.EBKC_QUALITY_GROUPS (QG_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  EBKC_QUALITY_GROUPS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on EBKC_QUALITY_GROUPS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on EBKC_QUALITY_GROUPS to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EBKC_QUALITY_GROUPS.sql =========*** E
PROMPT ===================================================================================== 
