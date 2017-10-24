

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SGN_INT_STORE.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SGN_INT_STORE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SGN_INT_STORE'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''SGN_INT_STORE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SGN_INT_STORE ***
begin 
  execute immediate '
  CREATE TABLE BARS.SGN_INT_STORE 
   (	REF NUMBER(38,0), 
	REC_ID NUMBER(38,0), 
	SIGN_ID NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SGN_INT_STORE ***
 exec bpa.alter_policies('SGN_INT_STORE');


COMMENT ON TABLE BARS.SGN_INT_STORE IS '������� ��������� ������ �� ���������� (oper_visa)';
COMMENT ON COLUMN BARS.SGN_INT_STORE.REF IS '������������� ���������';
COMMENT ON COLUMN BARS.SGN_INT_STORE.REC_ID IS '������������� ������ � oper_visa';
COMMENT ON COLUMN BARS.SGN_INT_STORE.SIGN_ID IS '������������� ������';




PROMPT *** Create  constraint CC_SGNINTSTORE_REF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SGN_INT_STORE MODIFY (REF CONSTRAINT CC_SGNINTSTORE_REF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SGNINTSTORE_RECID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SGN_INT_STORE MODIFY (REC_ID CONSTRAINT CC_SGNINTSTORE_RECID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/


PROMPT *** Create index I2_SGN_INT_STORE_SIGN_ID ***
declare
    name_already_used exception;
    column_already_indexed exception;

    pragma exception_init(name_already_used, -955);
    pragma exception_init(column_already_indexed, -1408);
begin
    execute immediate 'create index i2_sgn_int_store_sign_id on BARS.SGN_INT_STORE (sign_id) tablespace brsbigi';
exception
    when column_already_indexed or name_already_used then
         null;
end;
/

PROMPT *** Create  constraint FK_SGNINTSTORE_SGNDATA_REF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SGN_INT_STORE ADD CONSTRAINT FK_SGNINTSTORE_SGNDATA_REF FOREIGN KEY (SIGN_ID)
	  REFERENCES BARS.SGN_DATA (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SGNINTSTORE ***
begin   
 execute immediate '
  ALTER TABLE BARS.SGN_INT_STORE ADD CONSTRAINT PK_SGNINTSTORE PRIMARY KEY (REF, REC_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SGNINTSTORE_OPER_VISA_REF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SGN_INT_STORE ADD CONSTRAINT FK_SGNINTSTORE_OPER_VISA_REF FOREIGN KEY (REC_ID)
	  REFERENCES BARS.OPER_VISA (SQNC) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SGNINTSTORE_SIGNID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SGN_INT_STORE MODIFY (SIGN_ID CONSTRAINT CC_SGNINTSTORE_SIGNID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SGNINTSTORE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SGNINTSTORE ON BARS.SGN_INT_STORE (REF, REC_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_SGN_INT_STORE ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_SGN_INT_STORE ON BARS.SGN_INT_STORE (REC_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SGN_INT_STORE.sql =========*** End ***
PROMPT ===================================================================================== 
