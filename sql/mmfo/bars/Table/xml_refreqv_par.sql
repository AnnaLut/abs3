

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/XML_REFREQV_PAR.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to XML_REFREQV_PAR ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''XML_REFREQV_PAR'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''XML_REFREQV_PAR'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''XML_REFREQV_PAR'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table XML_REFREQV_PAR ***
begin 
  execute immediate '
  CREATE TABLE BARS.XML_REFREQV_PAR 
   (	KLTABLE_NAME VARCHAR2(100), 
	PARNUM NUMBER(*,0), 
	PARNAME VARCHAR2(50), 
	PARDESC VARCHAR2(500), 
	PARDEFVAL VARCHAR2(500)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to XML_REFREQV_PAR ***
 exec bpa.alter_policies('XML_REFREQV_PAR');


COMMENT ON TABLE BARS.XML_REFREQV_PAR IS 'Параметры для синхронизации справочников по выбранным параметрам';
COMMENT ON COLUMN BARS.XML_REFREQV_PAR.KLTABLE_NAME IS '';
COMMENT ON COLUMN BARS.XML_REFREQV_PAR.PARNUM IS '';
COMMENT ON COLUMN BARS.XML_REFREQV_PAR.PARNAME IS '';
COMMENT ON COLUMN BARS.XML_REFREQV_PAR.PARDESC IS '';
COMMENT ON COLUMN BARS.XML_REFREQV_PAR.PARDEFVAL IS '';




PROMPT *** Create  constraint XFK_XMLREFREQV ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_REFREQV_PAR ADD CONSTRAINT XFK_XMLREFREQV FOREIGN KEY (KLTABLE_NAME)
	  REFERENCES BARS.XML_REFLIST (KLTABLE_NAME) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_XMLREFREQVPAR ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_REFREQV_PAR ADD CONSTRAINT XPK_XMLREFREQVPAR PRIMARY KEY (KLTABLE_NAME, PARNAME)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_XMLREFREQVPAR ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_XMLREFREQVPAR ON BARS.XML_REFREQV_PAR (KLTABLE_NAME, PARNAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  XML_REFREQV_PAR ***
grant SELECT                                                                 on XML_REFREQV_PAR to BARS_DM;
grant SELECT                                                                 on XML_REFREQV_PAR to KLBX;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on XML_REFREQV_PAR to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/XML_REFREQV_PAR.sql =========*** End *
PROMPT ===================================================================================== 
