

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SMS_TEMPLATES_TYPES.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SMS_TEMPLATES_TYPES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SMS_TEMPLATES_TYPES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SMS_TEMPLATES_TYPES'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''SMS_TEMPLATES_TYPES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SMS_TEMPLATES_TYPES ***
begin 
  execute immediate '
  CREATE TABLE BARS.SMS_TEMPLATES_TYPES 
   (	ID NUMBER, 
	NAME VARCHAR2(100)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SMS_TEMPLATES_TYPES ***
 exec bpa.alter_policies('SMS_TEMPLATES_TYPES');


COMMENT ON TABLE BARS.SMS_TEMPLATES_TYPES IS 'Типы шаблонов SMS сообщений';
COMMENT ON COLUMN BARS.SMS_TEMPLATES_TYPES.ID IS 'ID';
COMMENT ON COLUMN BARS.SMS_TEMPLATES_TYPES.NAME IS 'Название типа шаблона';




PROMPT *** Create  constraint PK_SMS_TEMPLATES_TYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.SMS_TEMPLATES_TYPES ADD CONSTRAINT PK_SMS_TEMPLATES_TYPES PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C004883 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SMS_TEMPLATES_TYPES MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C004884 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SMS_TEMPLATES_TYPES MODIFY (NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SMS_TEMPLATES_TYPES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SMS_TEMPLATES_TYPES ON BARS.SMS_TEMPLATES_TYPES (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SMS_TEMPLATES_TYPES.sql =========*** E
PROMPT ===================================================================================== 
