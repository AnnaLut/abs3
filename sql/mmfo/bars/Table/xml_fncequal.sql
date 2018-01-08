

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/XML_FNCEQUAL.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to XML_FNCEQUAL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''XML_FNCEQUAL'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''XML_FNCEQUAL'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''XML_FNCEQUAL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table XML_FNCEQUAL ***
begin 
  execute immediate '
  CREATE TABLE BARS.XML_FNCEQUAL 
   (	BARS_FUNC VARCHAR2(500), 
	KLB_PARAM VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to XML_FNCEQUAL ***
 exec bpa.alter_policies('XML_FNCEQUAL');


COMMENT ON TABLE BARS.XML_FNCEQUAL IS 'Соответствие функций и параметров в настройках операций  для ТВБВ';
COMMENT ON COLUMN BARS.XML_FNCEQUAL.BARS_FUNC IS '';
COMMENT ON COLUMN BARS.XML_FNCEQUAL.KLB_PARAM IS '';




PROMPT *** Create  constraint XPK_XMLFNCEQUAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_FNCEQUAL ADD CONSTRAINT XPK_XMLFNCEQUAL PRIMARY KEY (BARS_FUNC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_XMLFNCEQUAL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_XMLFNCEQUAL ON BARS.XML_FNCEQUAL (BARS_FUNC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  XML_FNCEQUAL ***
grant SELECT                                                                 on XML_FNCEQUAL    to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on XML_FNCEQUAL    to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/XML_FNCEQUAL.sql =========*** End *** 
PROMPT ===================================================================================== 
