

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/XML_SYNCCHECK.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to XML_SYNCCHECK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''XML_SYNCCHECK'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''XML_SYNCCHECK'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''XML_SYNCCHECK'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table XML_SYNCCHECK ***
begin 
  execute immediate '
  CREATE TABLE BARS.XML_SYNCCHECK 
   (	RNK NUMBER, 
	KLTABLE_NAME VARCHAR2(100), 
	LAST_SCN NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to XML_SYNCCHECK ***
 exec bpa.alter_policies('XML_SYNCCHECK');


COMMENT ON TABLE BARS.XML_SYNCCHECK IS 'Значения последних SCN для каждого бранча';
COMMENT ON COLUMN BARS.XML_SYNCCHECK.RNK IS 'рнк бранча';
COMMENT ON COLUMN BARS.XML_SYNCCHECK.KLTABLE_NAME IS 'Имя справочника в off linе отделении';
COMMENT ON COLUMN BARS.XML_SYNCCHECK.LAST_SCN IS 'Последний SCN обновлений для данного справочника';




PROMPT *** Create  constraint XPK_SYNCCHECK ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_SYNCCHECK ADD CONSTRAINT XPK_SYNCCHECK PRIMARY KEY (RNK, KLTABLE_NAME)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_SYNCCHECK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_SYNCCHECK ON BARS.XML_SYNCCHECK (RNK, KLTABLE_NAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  XML_SYNCCHECK ***
grant SELECT                                                                 on XML_SYNCCHECK   to BARSREADER_ROLE;
grant SELECT                                                                 on XML_SYNCCHECK   to BARS_DM;
grant SELECT                                                                 on XML_SYNCCHECK   to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on XML_SYNCCHECK   to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/XML_SYNCCHECK.sql =========*** End ***
PROMPT ===================================================================================== 
