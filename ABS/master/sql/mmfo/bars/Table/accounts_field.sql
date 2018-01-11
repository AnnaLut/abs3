

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ACCOUNTS_FIELD.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ACCOUNTS_FIELD ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ACCOUNTS_FIELD'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ACCOUNTS_FIELD'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''ACCOUNTS_FIELD'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ACCOUNTS_FIELD ***
begin 
  execute immediate '
  CREATE TABLE BARS.ACCOUNTS_FIELD 
   (	TAG VARCHAR2(8), 
	NAME VARCHAR2(70), 
	DELETED DATE, 
	USE_IN_ARCH NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ACCOUNTS_FIELD ***
 exec bpa.alter_policies('ACCOUNTS_FIELD');


COMMENT ON TABLE BARS.ACCOUNTS_FIELD IS 'Справочник доп. параметров счета';
COMMENT ON COLUMN BARS.ACCOUNTS_FIELD.TAG IS 'Код доп.параметра';
COMMENT ON COLUMN BARS.ACCOUNTS_FIELD.NAME IS 'Наименование доп.параметра';
COMMENT ON COLUMN BARS.ACCOUNTS_FIELD.DELETED IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_FIELD.USE_IN_ARCH IS 'Перенос реквизита в архивную схему';




PROMPT *** Create  constraint CC_ACCFIELDS_INARCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_FIELD ADD CONSTRAINT CC_ACCFIELDS_INARCH_NN CHECK (use_in_arch is not null) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_ACCOUNTSFIELD ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_FIELD ADD CONSTRAINT PK_ACCOUNTSFIELD PRIMARY KEY (TAG)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOUNTSFIELD_TAG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_FIELD MODIFY (TAG CONSTRAINT CC_ACCOUNTSFIELD_TAG_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOUNTSFIELD_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_FIELD MODIFY (NAME CONSTRAINT CC_ACCOUNTSFIELD_NAME_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ACCOUNTSFIELD ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ACCOUNTSFIELD ON BARS.ACCOUNTS_FIELD (TAG) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ACCOUNTS_FIELD ***
grant DELETE,INSERT,SELECT,UPDATE                                            on ACCOUNTS_FIELD  to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACCOUNTS_FIELD  to ACCOUNTS_FIELD;
grant SELECT                                                                 on ACCOUNTS_FIELD  to BARSREADER_ROLE;
grant SELECT                                                                 on ACCOUNTS_FIELD  to BARSUPL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ACCOUNTS_FIELD  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ACCOUNTS_FIELD  to BARS_DM;
grant SELECT                                                                 on ACCOUNTS_FIELD  to CUST001;
grant SELECT                                                                 on ACCOUNTS_FIELD  to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ACCOUNTS_FIELD  to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on ACCOUNTS_FIELD  to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ACCOUNTS_FIELD.sql =========*** End **
PROMPT ===================================================================================== 
