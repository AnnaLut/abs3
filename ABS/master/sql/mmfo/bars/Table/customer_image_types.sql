

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CUSTOMER_IMAGE_TYPES.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CUSTOMER_IMAGE_TYPES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CUSTOMER_IMAGE_TYPES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CUSTOMER_IMAGE_TYPES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CUSTOMER_IMAGE_TYPES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CUSTOMER_IMAGE_TYPES ***
begin 
  execute immediate '
  CREATE TABLE BARS.CUSTOMER_IMAGE_TYPES 
   (	TYPE_IMG VARCHAR2(10), 
	NAME_IMG VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CUSTOMER_IMAGE_TYPES ***
 exec bpa.alter_policies('CUSTOMER_IMAGE_TYPES');


COMMENT ON TABLE BARS.CUSTOMER_IMAGE_TYPES IS 'Типи зображень клієнта';
COMMENT ON COLUMN BARS.CUSTOMER_IMAGE_TYPES.TYPE_IMG IS 'Тип зображення';
COMMENT ON COLUMN BARS.CUSTOMER_IMAGE_TYPES.NAME_IMG IS 'Опис типу зображення';




PROMPT *** Create  constraint PK_CUSTOMERIMGTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_IMAGE_TYPES ADD CONSTRAINT PK_CUSTOMERIMGTYPES PRIMARY KEY (TYPE_IMG)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERIMGTYPES_TYPEIMG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_IMAGE_TYPES MODIFY (TYPE_IMG CONSTRAINT CC_CUSTOMERIMGTYPES_TYPEIMG_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERIMGTYPES_NAMEIMG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_IMAGE_TYPES MODIFY (NAME_IMG CONSTRAINT CC_CUSTOMERIMGTYPES_NAMEIMG_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CUSTOMERIMGTYPES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CUSTOMERIMGTYPES ON BARS.CUSTOMER_IMAGE_TYPES (TYPE_IMG) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CUSTOMER_IMAGE_TYPES ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CUSTOMER_IMAGE_TYPES to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on CUSTOMER_IMAGE_TYPES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CUSTOMER_IMAGE_TYPES to BARS_DM;
grant SELECT                                                                 on CUSTOMER_IMAGE_TYPES to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CUSTOMER_IMAGE_TYPES to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CUSTOMER_IMAGE_TYPES.sql =========*** 
PROMPT ===================================================================================== 
