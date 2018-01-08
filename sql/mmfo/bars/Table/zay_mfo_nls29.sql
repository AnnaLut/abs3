

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ZAY_MFO_NLS29.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ZAY_MFO_NLS29 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ZAY_MFO_NLS29'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ZAY_MFO_NLS29'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ZAY_MFO_NLS29'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ZAY_MFO_NLS29 ***
begin 
  execute immediate '
  CREATE TABLE BARS.ZAY_MFO_NLS29 
   (	MFO VARCHAR2(6), 
	NLS29 VARCHAR2(15), 
	NLS29CA VARCHAR2(15), 
	NLS6114 VARCHAR2(16)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ZAY_MFO_NLS29 ***
 exec bpa.alter_policies('ZAY_MFO_NLS29');


COMMENT ON TABLE BARS.ZAY_MFO_NLS29 IS 'Справочник торговых счетов 2900 модуля "Бирж.операции"';
COMMENT ON COLUMN BARS.ZAY_MFO_NLS29.MFO IS 'МФО';
COMMENT ON COLUMN BARS.ZAY_MFO_NLS29.NLS29 IS 'Торговый счет РУ';
COMMENT ON COLUMN BARS.ZAY_MFO_NLS29.NLS29CA IS 'Торговый счет РУ открытый в ЦА';
COMMENT ON COLUMN BARS.ZAY_MFO_NLS29.NLS6114 IS '';




PROMPT *** Create  constraint PK_ZAYMFONLS29 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_MFO_NLS29 ADD CONSTRAINT PK_ZAYMFONLS29 PRIMARY KEY (MFO)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ZAYMFONLS29 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ZAYMFONLS29 ON BARS.ZAY_MFO_NLS29 (MFO) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ZAY_MFO_NLS29 ***
grant SELECT                                                                 on ZAY_MFO_NLS29   to BARSREADER_ROLE;
grant SELECT                                                                 on ZAY_MFO_NLS29   to BARS_DM;
grant SELECT                                                                 on ZAY_MFO_NLS29   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ZAY_MFO_NLS29.sql =========*** End ***
PROMPT ===================================================================================== 
