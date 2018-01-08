

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_SIGN_TYPES.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_SIGN_TYPES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_SIGN_TYPES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_SIGN_TYPES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_SIGN_TYPES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_SIGN_TYPES ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_SIGN_TYPES 
   (	ID VARCHAR2(100), 
	NAME VARCHAR2(255), 
	SIGN VARCHAR2(10)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_SIGN_TYPES ***
 exec bpa.alter_policies('WCS_SIGN_TYPES');


COMMENT ON TABLE BARS.WCS_SIGN_TYPES IS 'Типы знаков неравенства';
COMMENT ON COLUMN BARS.WCS_SIGN_TYPES.ID IS 'Идентификатор';
COMMENT ON COLUMN BARS.WCS_SIGN_TYPES.NAME IS 'Наименование';
COMMENT ON COLUMN BARS.WCS_SIGN_TYPES.SIGN IS 'Символьное представление знака';




PROMPT *** Create  constraint PK_SIGNTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SIGN_TYPES ADD CONSTRAINT PK_SIGNTYPES PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SIGNTYPES_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SIGN_TYPES MODIFY (NAME CONSTRAINT CC_SIGNTYPES_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SIGNTYPES_SIGN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SIGN_TYPES MODIFY (SIGN CONSTRAINT CC_SIGNTYPES_SIGN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SIGNTYPES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SIGNTYPES ON BARS.WCS_SIGN_TYPES (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WCS_SIGN_TYPES ***
grant SELECT                                                                 on WCS_SIGN_TYPES  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on WCS_SIGN_TYPES  to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_SIGN_TYPES.sql =========*** End **
PROMPT ===================================================================================== 
