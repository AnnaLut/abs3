

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/XML_SYNCTYPES.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to XML_SYNCTYPES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''XML_SYNCTYPES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''XML_SYNCTYPES'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''XML_SYNCTYPES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table XML_SYNCTYPES ***
begin 
  execute immediate '
  CREATE TABLE BARS.XML_SYNCTYPES 
   (	SYNCTYPE NUMBER, 
	DESCRIPT VARCHAR2(200), 
	MNEMONIC VARCHAR2(10)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to XML_SYNCTYPES ***
 exec bpa.alter_policies('XML_SYNCTYPES');


COMMENT ON TABLE BARS.XML_SYNCTYPES IS 'Типы синхронизации справочников';
COMMENT ON COLUMN BARS.XML_SYNCTYPES.SYNCTYPE IS '';
COMMENT ON COLUMN BARS.XML_SYNCTYPES.DESCRIPT IS 'тип синхронізації довідника';
COMMENT ON COLUMN BARS.XML_SYNCTYPES.MNEMONIC IS '';




PROMPT *** Create  constraint XPK_XMLSYNCTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_SYNCTYPES ADD CONSTRAINT XPK_XMLSYNCTYPES PRIMARY KEY (SYNCTYPE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_XMLSYNCTYPES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_XMLSYNCTYPES ON BARS.XML_SYNCTYPES (SYNCTYPE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  XML_SYNCTYPES ***
grant SELECT                                                                 on XML_SYNCTYPES   to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on XML_SYNCTYPES   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on XML_SYNCTYPES   to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on XML_SYNCTYPES   to START1;
grant SELECT                                                                 on XML_SYNCTYPES   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/XML_SYNCTYPES.sql =========*** End ***
PROMPT ===================================================================================== 
