

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/XML_SERVLIST_PARAMS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to XML_SERVLIST_PARAMS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''XML_SERVLIST_PARAMS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''XML_SERVLIST_PARAMS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''XML_SERVLIST_PARAMS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table XML_SERVLIST_PARAMS ***
begin 
  execute immediate '
  CREATE TABLE BARS.XML_SERVLIST_PARAMS 
   (	SNAM VARCHAR2(20), 
	PARNUM NUMBER(*,0), 
	PARTYPE VARCHAR2(20), 
	PARDESC VARCHAR2(200), 
	DEFVALUE VARCHAR2(200)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to XML_SERVLIST_PARAMS ***
 exec bpa.alter_policies('XML_SERVLIST_PARAMS');


COMMENT ON TABLE BARS.XML_SERVLIST_PARAMS IS 'Описание параметров для сервисов';
COMMENT ON COLUMN BARS.XML_SERVLIST_PARAMS.SNAM IS '';
COMMENT ON COLUMN BARS.XML_SERVLIST_PARAMS.PARNUM IS '';
COMMENT ON COLUMN BARS.XML_SERVLIST_PARAMS.PARTYPE IS '';
COMMENT ON COLUMN BARS.XML_SERVLIST_PARAMS.PARDESC IS '';
COMMENT ON COLUMN BARS.XML_SERVLIST_PARAMS.DEFVALUE IS '';




PROMPT *** Create  constraint XPK_XMLSERVPARAMS ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_SERVLIST_PARAMS ADD CONSTRAINT XPK_XMLSERVPARAMS PRIMARY KEY (SNAM, PARNUM)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_XMLSERVPARAMS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_XMLSERVPARAMS ON BARS.XML_SERVLIST_PARAMS (SNAM, PARNUM) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  XML_SERVLIST_PARAMS ***
grant SELECT                                                                 on XML_SERVLIST_PARAMS to BARSREADER_ROLE;
grant SELECT                                                                 on XML_SERVLIST_PARAMS to BARS_DM;
grant SELECT                                                                 on XML_SERVLIST_PARAMS to KLBX;
grant SELECT                                                                 on XML_SERVLIST_PARAMS to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on XML_SERVLIST_PARAMS to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/XML_SERVLIST_PARAMS.sql =========*** E
PROMPT ===================================================================================== 
