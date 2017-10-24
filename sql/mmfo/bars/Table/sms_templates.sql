

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SMS_TEMPLATES.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SMS_TEMPLATES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SMS_TEMPLATES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SMS_TEMPLATES'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''SMS_TEMPLATES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SMS_TEMPLATES ***
begin 
  execute immediate '
  CREATE TABLE BARS.SMS_TEMPLATES 
   (	ID NUMBER, 
	NAME VARCHAR2(100), 
	TYPE_ID VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SMS_TEMPLATES ***
 exec bpa.alter_policies('SMS_TEMPLATES');


COMMENT ON TABLE BARS.SMS_TEMPLATES IS 'Шаблоны SMS сообщений';
COMMENT ON COLUMN BARS.SMS_TEMPLATES.ID IS 'ID';
COMMENT ON COLUMN BARS.SMS_TEMPLATES.NAME IS 'Имя шаблона';
COMMENT ON COLUMN BARS.SMS_TEMPLATES.TYPE_ID IS 'Тип шаблона';




PROMPT *** Create  constraint PK_SMS_TEMPLATES ***
begin   
 execute immediate '
  ALTER TABLE BARS.SMS_TEMPLATES ADD CONSTRAINT PK_SMS_TEMPLATES PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008211 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SMS_TEMPLATES MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008212 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SMS_TEMPLATES MODIFY (NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008213 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SMS_TEMPLATES MODIFY (TYPE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SMS_TEMPLATES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SMS_TEMPLATES ON BARS.SMS_TEMPLATES (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SMS_TEMPLATES ***
grant SELECT                                                                 on SMS_TEMPLATES   to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SMS_TEMPLATES.sql =========*** End ***
PROMPT ===================================================================================== 
