

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/XML_DPTPARAMS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to XML_DPTPARAMS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''XML_DPTPARAMS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''XML_DPTPARAMS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''XML_DPTPARAMS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table XML_DPTPARAMS ***
begin 
  execute immediate '
  CREATE TABLE BARS.XML_DPTPARAMS 
   (	PAR VARCHAR2(100), 
	DESCRIPT VARCHAR2(1000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to XML_DPTPARAMS ***
 exec bpa.alter_policies('XML_DPTPARAMS');


COMMENT ON TABLE BARS.XML_DPTPARAMS IS 'Параметры для депозитов для синхронизации с оффлайн';
COMMENT ON COLUMN BARS.XML_DPTPARAMS.PAR IS '';
COMMENT ON COLUMN BARS.XML_DPTPARAMS.DESCRIPT IS '';




PROMPT *** Create  constraint XPK_XMLDPTPARAMS ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_DPTPARAMS ADD CONSTRAINT XPK_XMLDPTPARAMS PRIMARY KEY (PAR)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_XMLDPTPARAMS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_XMLDPTPARAMS ON BARS.XML_DPTPARAMS (PAR) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  XML_DPTPARAMS ***
grant SELECT                                                                 on XML_DPTPARAMS   to BARSREADER_ROLE;
grant SELECT                                                                 on XML_DPTPARAMS   to BARS_DM;
grant SELECT                                                                 on XML_DPTPARAMS   to KLBX;
grant SELECT                                                                 on XML_DPTPARAMS   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/XML_DPTPARAMS.sql =========*** End ***
PROMPT ===================================================================================== 
