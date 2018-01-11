

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CUSTOMER_FIELD_CODES.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CUSTOMER_FIELD_CODES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CUSTOMER_FIELD_CODES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CUSTOMER_FIELD_CODES'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CUSTOMER_FIELD_CODES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CUSTOMER_FIELD_CODES ***
begin 
  execute immediate '
  CREATE TABLE BARS.CUSTOMER_FIELD_CODES 
   (	CODE VARCHAR2(30), 
	NAME VARCHAR2(30), 
	ORD NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CUSTOMER_FIELD_CODES ***
 exec bpa.alter_policies('CUSTOMER_FIELD_CODES');


COMMENT ON TABLE BARS.CUSTOMER_FIELD_CODES IS 'Коди модулів дод. реквізитів клієнтів';
COMMENT ON COLUMN BARS.CUSTOMER_FIELD_CODES.CODE IS 'Код модуля';
COMMENT ON COLUMN BARS.CUSTOMER_FIELD_CODES.NAME IS 'Назва модуля';
COMMENT ON COLUMN BARS.CUSTOMER_FIELD_CODES.ORD IS 'Сортування';




PROMPT *** Create  constraint PK_CUSTOMERFIELDCODES ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_FIELD_CODES ADD CONSTRAINT PK_CUSTOMERFIELDCODES PRIMARY KEY (CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERFIELDCODES_CODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_FIELD_CODES MODIFY (CODE CONSTRAINT CC_CUSTOMERFIELDCODES_CODE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CUSTOMERFIELDCODES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CUSTOMERFIELDCODES ON BARS.CUSTOMER_FIELD_CODES (CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CUSTOMER_FIELD_CODES ***
grant SELECT                                                                 on CUSTOMER_FIELD_CODES to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CUSTOMER_FIELD_CODES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CUSTOMER_FIELD_CODES to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CUSTOMER_FIELD_CODES to CUST001;
grant SELECT                                                                 on CUSTOMER_FIELD_CODES to UPLD;
grant FLASHBACK,SELECT                                                       on CUSTOMER_FIELD_CODES to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CUSTOMER_FIELD_CODES.sql =========*** 
PROMPT ===================================================================================== 
