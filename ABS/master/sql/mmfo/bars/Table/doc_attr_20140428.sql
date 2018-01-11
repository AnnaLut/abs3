

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DOC_ATTR_20140428.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DOC_ATTR_20140428 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DOC_ATTR_20140428'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DOC_ATTR_20140428'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DOC_ATTR_20140428'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DOC_ATTR_20140428 ***
begin 
  execute immediate '
  CREATE TABLE BARS.DOC_ATTR_20140428 
   (	ID VARCHAR2(35), 
	NAME VARCHAR2(140), 
	FIELD VARCHAR2(35), 
	SSQL VARCHAR2(1000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DOC_ATTR_20140428 ***
 exec bpa.alter_policies('DOC_ATTR_20140428');


COMMENT ON TABLE BARS.DOC_ATTR_20140428 IS '';
COMMENT ON COLUMN BARS.DOC_ATTR_20140428.ID IS '';
COMMENT ON COLUMN BARS.DOC_ATTR_20140428.NAME IS '';
COMMENT ON COLUMN BARS.DOC_ATTR_20140428.FIELD IS '';
COMMENT ON COLUMN BARS.DOC_ATTR_20140428.SSQL IS '';




PROMPT *** Create  constraint SYS_C006899 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DOC_ATTR_20140428 MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006900 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DOC_ATTR_20140428 MODIFY (NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DOC_ATTR_20140428 ***
grant SELECT                                                                 on DOC_ATTR_20140428 to BARSREADER_ROLE;
grant SELECT                                                                 on DOC_ATTR_20140428 to BARS_DM;
grant SELECT                                                                 on DOC_ATTR_20140428 to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DOC_ATTR_20140428.sql =========*** End
PROMPT ===================================================================================== 
