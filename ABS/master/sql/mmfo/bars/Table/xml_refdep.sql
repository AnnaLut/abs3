

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/XML_REFDEP.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to XML_REFDEP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''XML_REFDEP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''XML_REFDEP'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''XML_REFDEP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table XML_REFDEP ***
begin 
  execute immediate '
  CREATE TABLE BARS.XML_REFDEP 
   (	KLTABLE_NAME VARCHAR2(100), 
	KLTABLE_DEPNAME VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to XML_REFDEP ***
 exec bpa.alter_policies('XML_REFDEP');


COMMENT ON TABLE BARS.XML_REFDEP IS 'Связанные справочники(для выгрузки)';
COMMENT ON COLUMN BARS.XML_REFDEP.KLTABLE_NAME IS 'Имя справочника';
COMMENT ON COLUMN BARS.XML_REFDEP.KLTABLE_DEPNAME IS 'Имя справочника, который следует синхронизировать если синхронизировали справочник kltable_name';




PROMPT *** Create  constraint XUK_XMLREFDEP ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_REFDEP ADD CONSTRAINT XUK_XMLREFDEP UNIQUE (KLTABLE_NAME, KLTABLE_DEPNAME)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XFK_XMLREFDEPTAB ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_REFDEP ADD CONSTRAINT XFK_XMLREFDEPTAB FOREIGN KEY (KLTABLE_DEPNAME)
	  REFERENCES BARS.XML_REFLIST (KLTABLE_NAME) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XFK_XMLREFDEP ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_REFDEP ADD CONSTRAINT XFK_XMLREFDEP FOREIGN KEY (KLTABLE_NAME)
	  REFERENCES BARS.XML_REFLIST (KLTABLE_NAME) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XUK_XMLREFDEP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XUK_XMLREFDEP ON BARS.XML_REFDEP (KLTABLE_NAME, KLTABLE_DEPNAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  XML_REFDEP ***
grant SELECT                                                                 on XML_REFDEP      to BARS_DM;
grant SELECT                                                                 on XML_REFDEP      to KLBX;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on XML_REFDEP      to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/XML_REFDEP.sql =========*** End *** ==
PROMPT ===================================================================================== 
