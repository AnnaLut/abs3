

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/XML_STREAMGUARD_RECIP.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to XML_STREAMGUARD_RECIP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''XML_STREAMGUARD_RECIP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''XML_STREAMGUARD_RECIP'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''XML_STREAMGUARD_RECIP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table XML_STREAMGUARD_RECIP ***
begin 
  execute immediate '
  CREATE TABLE BARS.XML_STREAMGUARD_RECIP 
   (	EMAIL_ADR VARCHAR2(200), 
	NAME VARCHAR2(200), 
	POST_MSGCODE NUMBER, 
	POST_DATE DATE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to XML_STREAMGUARD_RECIP ***
 exec bpa.alter_policies('XML_STREAMGUARD_RECIP');


COMMENT ON TABLE BARS.XML_STREAMGUARD_RECIP IS 'Список адрессатов, которые уведомлять по почте о збоях в работе ORACLE STREAMS при синхронизации справочников офф';
COMMENT ON COLUMN BARS.XML_STREAMGUARD_RECIP.EMAIL_ADR IS 'Электронный адресс';
COMMENT ON COLUMN BARS.XML_STREAMGUARD_RECIP.NAME IS 'Имя получателя';
COMMENT ON COLUMN BARS.XML_STREAMGUARD_RECIP.POST_MSGCODE IS 'Сообщение';
COMMENT ON COLUMN BARS.XML_STREAMGUARD_RECIP.POST_DATE IS 'Дата предидущего письма';




PROMPT *** Create  constraint XPK_XMLSTREAMGUARD ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_STREAMGUARD_RECIP ADD CONSTRAINT XPK_XMLSTREAMGUARD PRIMARY KEY (EMAIL_ADR)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_XMLSTREAMGUARD ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_XMLSTREAMGUARD ON BARS.XML_STREAMGUARD_RECIP (EMAIL_ADR) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  XML_STREAMGUARD_RECIP ***
grant DELETE,INSERT,SELECT,UPDATE                                            on XML_STREAMGUARD_RECIP to BARSAQ;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/XML_STREAMGUARD_RECIP.sql =========***
PROMPT ===================================================================================== 
