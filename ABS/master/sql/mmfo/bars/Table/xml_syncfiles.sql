

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/XML_SYNCFILES.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to XML_SYNCFILES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''XML_SYNCFILES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''XML_SYNCFILES'', ''FILIAL'' , ''M'', ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''XML_SYNCFILES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table XML_SYNCFILES ***
begin 
  execute immediate '
  CREATE TABLE BARS.XML_SYNCFILES 
   (	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	PNAM VARCHAR2(20), 
	DATF DATE, 
	ROWSCNT NUMBER, 
	REFNAME VARCHAR2(100), 
	SYNCTYPE NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to XML_SYNCFILES ***
 exec bpa.alter_policies('XML_SYNCFILES');


COMMENT ON TABLE BARS.XML_SYNCFILES IS 'Сформированные файлы синхронизации от нас на ТВБВ';
COMMENT ON COLUMN BARS.XML_SYNCFILES.KF IS '';
COMMENT ON COLUMN BARS.XML_SYNCFILES.PNAM IS 'Имя файла';
COMMENT ON COLUMN BARS.XML_SYNCFILES.DATF IS 'Дата формирования файла у нас';
COMMENT ON COLUMN BARS.XML_SYNCFILES.ROWSCNT IS 'Общее кол-во записей в файле';
COMMENT ON COLUMN BARS.XML_SYNCFILES.REFNAME IS 'Имя выгружаемого справочника';
COMMENT ON COLUMN BARS.XML_SYNCFILES.SYNCTYPE IS 'Тип синхронизации';




PROMPT *** Create  constraint XPK_XML_SYNCFILES ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_SYNCFILES ADD CONSTRAINT XPK_XML_SYNCFILES PRIMARY KEY (KF, PNAM, DATF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_XMLSYNFILES_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_SYNCFILES MODIFY (KF CONSTRAINT CC_XMLSYNFILES_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_XML_SYNCFILES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_XML_SYNCFILES ON BARS.XML_SYNCFILES (KF, PNAM, DATF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  XML_SYNCFILES ***
grant SELECT                                                                 on XML_SYNCFILES   to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on XML_SYNCFILES   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on XML_SYNCFILES   to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on XML_SYNCFILES   to START1;
grant SELECT                                                                 on XML_SYNCFILES   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/XML_SYNCFILES.sql =========*** End ***
PROMPT ===================================================================================== 
