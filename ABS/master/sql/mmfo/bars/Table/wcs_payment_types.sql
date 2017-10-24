

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_PAYMENT_TYPES.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_PAYMENT_TYPES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_PAYMENT_TYPES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_PAYMENT_TYPES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_PAYMENT_TYPES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_PAYMENT_TYPES ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_PAYMENT_TYPES 
   (	ID VARCHAR2(100), 
	NAME VARCHAR2(255)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_PAYMENT_TYPES ***
 exec bpa.alter_policies('WCS_PAYMENT_TYPES');


COMMENT ON TABLE BARS.WCS_PAYMENT_TYPES IS 'Типы торговцев партнеров';
COMMENT ON COLUMN BARS.WCS_PAYMENT_TYPES.ID IS 'Идентификатор';
COMMENT ON COLUMN BARS.WCS_PAYMENT_TYPES.NAME IS 'Наименование';




PROMPT *** Create  constraint PK_PAYMENTTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_PAYMENT_TYPES ADD CONSTRAINT PK_PAYMENTTYPES PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PAYMENTTYPES_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_PAYMENT_TYPES MODIFY (NAME CONSTRAINT CC_PAYMENTTYPES_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PAYMENTTYPES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_PAYMENTTYPES ON BARS.WCS_PAYMENT_TYPES (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WCS_PAYMENT_TYPES ***
grant SELECT                                                                 on WCS_PAYMENT_TYPES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on WCS_PAYMENT_TYPES to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_PAYMENT_TYPES.sql =========*** End
PROMPT ===================================================================================== 
