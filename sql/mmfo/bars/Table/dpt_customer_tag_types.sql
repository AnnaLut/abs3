

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_CUSTOMER_TAG_TYPES.sql =========**
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_CUSTOMER_TAG_TYPES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_CUSTOMER_TAG_TYPES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_CUSTOMER_TAG_TYPES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_CUSTOMER_TAG_TYPES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_CUSTOMER_TAG_TYPES ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_CUSTOMER_TAG_TYPES 
   (	TYPE_CODE VARCHAR2(10), 
	TYPE_NAME VARCHAR2(70)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_CUSTOMER_TAG_TYPES ***
 exec bpa.alter_policies('DPT_CUSTOMER_TAG_TYPES');


COMMENT ON TABLE BARS.DPT_CUSTOMER_TAG_TYPES IS 'Типи реквізитів клієнта';
COMMENT ON COLUMN BARS.DPT_CUSTOMER_TAG_TYPES.TYPE_CODE IS 'Код типу реквізиту клієнта';
COMMENT ON COLUMN BARS.DPT_CUSTOMER_TAG_TYPES.TYPE_NAME IS 'Назва типу реквізиту клієнта';




PROMPT *** Create  constraint PK_DPTCUSTTAGTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_CUSTOMER_TAG_TYPES ADD CONSTRAINT PK_DPTCUSTTAGTYPES PRIMARY KEY (TYPE_CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint DPTCUSTTAGTYPES_TYPECODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_CUSTOMER_TAG_TYPES MODIFY (TYPE_CODE CONSTRAINT DPTCUSTTAGTYPES_TYPECODE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint DPTCUSTTAGTYPES_TYPENAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_CUSTOMER_TAG_TYPES MODIFY (TYPE_NAME CONSTRAINT DPTCUSTTAGTYPES_TYPENAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPTCUSTTAGTYPES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPTCUSTTAGTYPES ON BARS.DPT_CUSTOMER_TAG_TYPES (TYPE_CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_CUSTOMER_TAG_TYPES ***
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_CUSTOMER_TAG_TYPES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_CUSTOMER_TAG_TYPES to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_CUSTOMER_TAG_TYPES to DPT_ADMIN;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_CUSTOMER_TAG_TYPES.sql =========**
PROMPT ===================================================================================== 
