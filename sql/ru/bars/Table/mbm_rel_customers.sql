exec BARS_POLICY_ADM.ALTER_POLICY_INFO('MBM_REL_CUSTOMERS','WHOLE', null, null, null, null);
exec BARS_POLICY_ADM.ALTER_POLICY_INFO('MBM_REL_CUSTOMERS','FILIAL', null, null, null, null);

begin
  execute immediate 
'create table MBM_REL_CUSTOMERS
(    
	id      		    	number,	
	tax_code	        varchar2(15),
	first_name		    varchar2(200),
	last_name		    	varchar2(200),
	second_name		    varchar2(200),
	doc_type		    	varchar2(10),	
	doc_series		    varchar2(10),
	doc_number		    varchar2(10),
	doc_organization	varchar2(300),
	doc_date		    	date,
	birth_date		    date,
	acsk_actual 			number(1) default 0,
	no_inn						number(1) default 0,
	created_date			date			default sysdate,
	cell_phone		    varchar2(20),
	address 					varchar2(4000),
	email			    		varchar2(100)
)';
exception
  when others then if (sqlcode = -955) then null; else raise; end if;
end;
/


begin   
 execute immediate '
  ALTER TABLE BARS.MBM_REL_CUSTOMERS ADD CONSTRAINT PK_MBM_REL_CUSTOMERS_ID PRIMARY KEY (id)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-955 or sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Add NO_INN column ***
begin
  execute immediate 'ALTER TABLE BARS.MBM_REL_CUSTOMERS ADD NO_INN NUMBER(1) DEFAULT 0';
exception when others then
  if sqlcode = -1430 then null; else raise; end if;
end;
/

PROMPT *** CREATE CC_MBM_REL_CUST_NOINN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.MBM_REL_CUSTOMERS ADD CONSTRAINT CC_MBM_REL_CUST_NOINN_NN CHECK (NO_INN IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Add ACSK_ACTUAL column ***
begin
  execute immediate 'ALTER TABLE BARS.MBM_REL_CUSTOMERS ADD ACSK_ACTUAL NUMBER(1) DEFAULT 0';
exception when others then
  if sqlcode = -1430 then null; else raise; end if;
end;
/

PROMPT *** CREATE CC_MBM_REL_CUST_ACSK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.MBM_REL_CUSTOMERS ADD CONSTRAINT CC_MBM_REL_CUST_ACSK_NN CHECK (ACSK_ACTUAL IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

begin   
 execute immediate 'alter table MBM_REL_CUSTOMERS modify doc_number VARCHAR2(14)';
end;
/


COMMENT ON TABLE MBM_REL_CUSTOMERS IS 'Повязані особи котрим надано доступ до CorpLight';

grant all on MBM_REL_CUSTOMERS to bars_access_defrole;