

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SEC_ATTRIBUTES.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SEC_ATTRIBUTES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SEC_ATTRIBUTES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SEC_ATTRIBUTES'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''SEC_ATTRIBUTES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SEC_ATTRIBUTES ***
begin 
  execute immediate '
  CREATE TABLE BARS.SEC_ATTRIBUTES 
   (	ATTR_ID NUMBER(38,0), 
	ATTR_NAME VARCHAR2(100), 
	ATTR_CODE VARCHAR2(30), 
	ATTR_TABNAME VARCHAR2(30), 
	ATTR_USERCOL VARCHAR2(30), 
	ATTR_STORAGE VARCHAR2(30), 
	ATTR_TYPE VARCHAR2(1), 
	INUSE NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SEC_ATTRIBUTES ***
 exec bpa.alter_policies('SEC_ATTRIBUTES');


COMMENT ON TABLE BARS.SEC_ATTRIBUTES IS 'Атрибути користувача для п_дтвердження службою безпеки';
COMMENT ON COLUMN BARS.SEC_ATTRIBUTES.ATTR_ID IS '_д. атрибуту';
COMMENT ON COLUMN BARS.SEC_ATTRIBUTES.ATTR_NAME IS 'Назва атрибуту';
COMMENT ON COLUMN BARS.SEC_ATTRIBUTES.ATTR_CODE IS 'Код атрибуту';
COMMENT ON COLUMN BARS.SEC_ATTRIBUTES.ATTR_TABNAME IS '_м'я таблиц_ для п_дтвердження атрибуту';
COMMENT ON COLUMN BARS.SEC_ATTRIBUTES.ATTR_USERCOL IS '_м'я колонки з _д. користувача в таблиц_ атрибут_в';
COMMENT ON COLUMN BARS.SEC_ATTRIBUTES.ATTR_STORAGE IS '_м'я таблиц_ збер_гання атрибуту';
COMMENT ON COLUMN BARS.SEC_ATTRIBUTES.ATTR_TYPE IS 'Тип атрибуту';
COMMENT ON COLUMN BARS.SEC_ATTRIBUTES.INUSE IS 'У використанн_';




PROMPT *** Create  constraint PK_SECATTRIBUTES ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_ATTRIBUTES ADD CONSTRAINT PK_SECATTRIBUTES PRIMARY KEY (ATTR_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SECATTRIBUTES_ATTRTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_ATTRIBUTES ADD CONSTRAINT CC_SECATTRIBUTES_ATTRTYPE CHECK (attr_type in (''S'', ''N'', ''D'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SECATTRIBUTES_INUSE ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_ATTRIBUTES ADD CONSTRAINT CC_SECATTRIBUTES_INUSE CHECK (inuse in (0, 1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SECATTRIBUTES_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_ATTRIBUTES MODIFY (ATTR_ID CONSTRAINT CC_SECATTRIBUTES_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SECATTRIBUTES_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_ATTRIBUTES MODIFY (ATTR_NAME CONSTRAINT CC_SECATTRIBUTES_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SECATTRIBUTES_CODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_ATTRIBUTES MODIFY (ATTR_CODE CONSTRAINT CC_SECATTRIBUTES_CODE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SECATTRIBUTES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SECATTRIBUTES ON BARS.SEC_ATTRIBUTES (ATTR_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_SECATTRIBUTES_ATTRCODE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_SECATTRIBUTES_ATTRCODE ON BARS.SEC_ATTRIBUTES (ATTR_CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SEC_ATTRIBUTES ***
grant SELECT                                                                 on SEC_ATTRIBUTES  to ABS_ADMIN;
grant SELECT                                                                 on SEC_ATTRIBUTES  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SEC_ATTRIBUTES  to BARS_DM;



PROMPT *** Create SYNONYM  to SEC_ATTRIBUTES ***

  CREATE OR REPLACE PUBLIC SYNONYM SEC_ATTRIBUTES FOR BARS.SEC_ATTRIBUTES;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SEC_ATTRIBUTES.sql =========*** End **
PROMPT ===================================================================================== 
