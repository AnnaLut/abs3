

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CUST_MARK_TYPES.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CUST_MARK_TYPES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CUST_MARK_TYPES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CUST_MARK_TYPES'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CUST_MARK_TYPES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CUST_MARK_TYPES ***
begin 
  execute immediate '
  CREATE TABLE BARS.CUST_MARK_TYPES 
   (	MARK_CODE NUMBER(1,0), 
	MARK_NAME VARCHAR2(35), 
	NEED_DOCS NUMBER(1,0) DEFAULT 0, 
	OPEN_SELF NUMBER(1,0) DEFAULT 1
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CUST_MARK_TYPES ***
 exec bpa.alter_policies('CUST_MARK_TYPES');


COMMENT ON TABLE BARS.CUST_MARK_TYPES IS 'Довідник "Особливих відміток" клієнта ФО';
COMMENT ON COLUMN BARS.CUST_MARK_TYPES.MARK_CODE IS 'Код відмітки';
COMMENT ON COLUMN BARS.CUST_MARK_TYPES.MARK_NAME IS 'Назва відмітки';
COMMENT ON COLUMN BARS.CUST_MARK_TYPES.NEED_DOCS IS 'Необхідність надання підтверджуючого документу ( 1 - так, 0 - ні )';
COMMENT ON COLUMN BARS.CUST_MARK_TYPES.OPEN_SELF IS 'Клієнт відкриває депозит самостійно ( 1 - так, 0 - ні )';




PROMPT *** Create  constraint PK_CUSTMARKTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUST_MARK_TYPES ADD CONSTRAINT PK_CUSTMARKTYPE PRIMARY KEY (MARK_CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTMARKTYPE_NEEDDOCS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUST_MARK_TYPES MODIFY (NEED_DOCS CONSTRAINT CC_CUSTMARKTYPE_NEEDDOCS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTMARKTYPE_OPENSELF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUST_MARK_TYPES MODIFY (OPEN_SELF CONSTRAINT CC_CUSTMARKTYPE_OPENSELF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CUSTMARKTYPE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CUSTMARKTYPE ON BARS.CUST_MARK_TYPES (MARK_CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CUST_MARK_TYPES ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CUST_MARK_TYPES to ABS_ADMIN;
grant SELECT                                                                 on CUST_MARK_TYPES to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CUST_MARK_TYPES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CUST_MARK_TYPES to BARS_DM;
grant SELECT                                                                 on CUST_MARK_TYPES to START1;
grant SELECT                                                                 on CUST_MARK_TYPES to UPLD;
grant DELETE,INSERT,SELECT,UPDATE                                            on CUST_MARK_TYPES to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CUST_MARK_TYPES.sql =========*** End *
PROMPT ===================================================================================== 
