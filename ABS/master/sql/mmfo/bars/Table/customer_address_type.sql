

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CUSTOMER_ADDRESS_TYPE.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CUSTOMER_ADDRESS_TYPE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CUSTOMER_ADDRESS_TYPE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CUSTOMER_ADDRESS_TYPE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CUSTOMER_ADDRESS_TYPE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CUSTOMER_ADDRESS_TYPE ***
begin 
  execute immediate '
  CREATE TABLE BARS.CUSTOMER_ADDRESS_TYPE 
   (	ID NUMBER(38,0), 
	NAME VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CUSTOMER_ADDRESS_TYPE ***
 exec bpa.alter_policies('CUSTOMER_ADDRESS_TYPE');


COMMENT ON TABLE BARS.CUSTOMER_ADDRESS_TYPE IS 'Типы адресов';
COMMENT ON COLUMN BARS.CUSTOMER_ADDRESS_TYPE.ID IS 'Идентификатор типа адреса';
COMMENT ON COLUMN BARS.CUSTOMER_ADDRESS_TYPE.NAME IS 'Наименование типа адреса';




PROMPT *** Create  constraint PK_CUSTOMERADRTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_ADDRESS_TYPE ADD CONSTRAINT PK_CUSTOMERADRTYPE PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERADRTYPE_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_ADDRESS_TYPE MODIFY (ID CONSTRAINT CC_CUSTOMERADRTYPE_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERADRTYPE_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_ADDRESS_TYPE MODIFY (NAME CONSTRAINT CC_CUSTOMERADRTYPE_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CUSTOMERADRTYPE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CUSTOMERADRTYPE ON BARS.CUSTOMER_ADDRESS_TYPE (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CUSTOMER_ADDRESS_TYPE ***
grant SELECT                                                                 on CUSTOMER_ADDRESS_TYPE to BARSUPL;
grant SELECT                                                                 on CUSTOMER_ADDRESS_TYPE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CUSTOMER_ADDRESS_TYPE to BARS_DM;
grant SELECT                                                                 on CUSTOMER_ADDRESS_TYPE to CUST001;
grant SELECT                                                                 on CUSTOMER_ADDRESS_TYPE to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CUSTOMER_ADDRESS_TYPE to WR_ALL_RIGHTS;
grant SELECT                                                                 on CUSTOMER_ADDRESS_TYPE to WR_CUSTREG;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CUSTOMER_ADDRESS_TYPE.sql =========***
PROMPT ===================================================================================== 
