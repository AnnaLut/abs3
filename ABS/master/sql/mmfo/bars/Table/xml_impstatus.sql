

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/XML_IMPSTATUS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to XML_IMPSTATUS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''XML_IMPSTATUS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''XML_IMPSTATUS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''XML_IMPSTATUS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table XML_IMPSTATUS ***
begin 
  execute immediate '
  CREATE TABLE BARS.XML_IMPSTATUS 
   (	STATUS NUMBER(*,0), 
	DESCRIPT VARCHAR2(100), 
	FULLDESC VARCHAR2(500)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to XML_IMPSTATUS ***
 exec bpa.alter_policies('XML_IMPSTATUS');


COMMENT ON TABLE BARS.XML_IMPSTATUS IS 'Статус документа для импорта в промежуточной таблице';
COMMENT ON COLUMN BARS.XML_IMPSTATUS.STATUS IS '';
COMMENT ON COLUMN BARS.XML_IMPSTATUS.DESCRIPT IS '';
COMMENT ON COLUMN BARS.XML_IMPSTATUS.FULLDESC IS '';




PROMPT *** Create  constraint XPK_XML_IMPSTATUS ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_IMPSTATUS ADD CONSTRAINT XPK_XML_IMPSTATUS PRIMARY KEY (STATUS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_XML_IMPSTATUS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_XML_IMPSTATUS ON BARS.XML_IMPSTATUS (STATUS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  XML_IMPSTATUS ***
grant SELECT                                                                 on XML_IMPSTATUS   to BARSREADER_ROLE;
grant SELECT                                                                 on XML_IMPSTATUS   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on XML_IMPSTATUS   to BARS_DM;
grant SELECT                                                                 on XML_IMPSTATUS   to OPER000;
grant SELECT                                                                 on XML_IMPSTATUS   to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on XML_IMPSTATUS   to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/XML_IMPSTATUS.sql =========*** End ***
PROMPT ===================================================================================== 
