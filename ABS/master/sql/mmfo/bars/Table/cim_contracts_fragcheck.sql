

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIM_CONTRACTS_FRAGCHECK.sql ===*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIM_CONTRACTS_FRAGCHECK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIM_CONTRACTS_FRAGCHECK'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_CONTRACTS_FRAGCHECK'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_CONTRACTS_FRAGCHECK'', ''WHOLE'' , null, null, null, null);
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIM_CONTRACTS_FRAGCHECK ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIM_CONTRACTS_FRAGCHECK 
   (	ID_CHECK NUMBER, 
        CONTR_ID NUMBER,
        IS_FRAGMENT NUMBER(1),
        TYPE_CHECK VARCHAR2(20),
	BDATE DATE, 
        SDATE DATE default sysdate,
        USER_ID NUMBER default sys_context(''bars_global'',''user_id'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIM_CONTRACTS_FRAGCHECK ***
 exec bpa.alter_policies('CIM_CONTRACTS_FRAGCHECK');

COMMENT ON TABLE BARS.CIM_CONTRACTS_FRAGCHECK IS 'Документи при розрахунку Ознаки дроблення';
COMMENT ON COLUMN BARS.CIM_CONTRACTS_FRAGCHECK.ID_CHECK IS 'Унікальний ідентифікатор перевірки на ознаку';
COMMENT ON COLUMN BARS.CIM_CONTRACTS_FRAGCHECK.CONTR_ID IS 'ID контракту який отримав Ознаку';
COMMENT ON COLUMN BARS.CIM_CONTRACTS_FRAGCHECK.IS_FRAGMENT IS 'Змінено ознаку дроблення:  на 1 - Так, 0 - Ні';
COMMENT ON COLUMN BARS.CIM_CONTRACTS_FRAGCHECK.TYPE_CHECK IS 'перевірка спрацювала за тиждень/місяць';
COMMENT ON COLUMN BARS.CIM_CONTRACTS_FRAGCHECK.BDATE IS 'Банківська дата';
COMMENT ON COLUMN BARS.CIM_CONTRACTS_FRAGCHECK.SDATE IS 'Системна дата';
COMMENT ON COLUMN BARS.CIM_CONTRACTS_FRAGCHECK.USER_ID IS 'ID Користувача';



-- Create/Recreate primary, unique and foreign key constraints 
begin   
 execute immediate '
  alter table CIM_CONTRACTS_FRAGCHECK
  add constraint PK_CIM_ID_CHECK_FRAGM primary key (ID_CHECK)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/


PROMPT *** Create  constraint FK_CIM_FRAGCHECK_CONTR_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONTRACTS_FRAGCHECK ADD CONSTRAINT FK_CIM_FRAGCHECK_CONTR_ID FOREIGN KEY (CONTR_ID)
	  REFERENCES BARS.CIM_CONTRACTS (CONTR_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  constraint CC_CIMCONTRFRCH_ISFRAG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONTRACTS_FRAGCHECK MODIFY (IS_FRAGMENT CONSTRAINT CC_CIMCONTRFRCH_ISFRAG_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  constraint CC_CIMCONTRFRAGM_USERID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONTRACTS_FRAGCHECK MODIFY (USER_ID CONSTRAINT CC_CIMCONTRFRAGM_USERID_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  constraint CC_CIMCONTRFRAGM_SDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONTRACTS_FRAGCHECK MODIFY (SDATE CONSTRAINT CC_CIMCONTRFRAGM_SDATE_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CIM_CONTRACTS_FRAGCHECK ***
grant SELECT                                                                 on CIM_CONTRACTS_FRAGCHECK to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_CONTRACTS_FRAGCHECK to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIM_CONTRACTS_FRAGCHECK to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_CONTRACTS_FRAGCHECK to CIM_ROLE;
grant SELECT                                                                 on CIM_CONTRACTS_FRAGCHECK to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIM_CONTRACTS_FRAGCHECK.sql =========*** 
PROMPT ===================================================================================== 
