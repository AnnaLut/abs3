

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


COMMENT ON TABLE BARS.SGN_INT_STORE IS 'Сховище внутрішніх підписів по документам (oper_visa)';
COMMENT ON COLUMN BARS.SGN_INT_STORE.REF IS 'Ідентифікатор документу';
COMMENT ON COLUMN BARS.SGN_INT_STORE.REC_ID IS 'Ідентифікатор запису у oper_visa';
COMMENT ON COLUMN BARS.SGN_INT_STORE.SIGN_ID IS 'Ідентифікатор підпису';




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




PROMPT *** Create  constraint CC_SGNINTSTORE_SIGNID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SGN_INT_STORE MODIFY (SIGN_ID CONSTRAINT CC_SGNINTSTORE_SIGNID_NN NOT NULL ENABLE)';
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




PROMPT *** Create  index I2_SGN_INT_STORE_SIGN_ID ***
begin   
 execute immediate '
  CREATE INDEX BARS.I2_SGN_INT_STORE_SIGN_ID ON BARS.SGN_INT_STORE (SIGN_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SGN_INT_STORE ***
grant SELECT                                                                 on SGN_INT_STORE   to BARSREADER_ROLE;
grant SELECT                                                                 on SGN_INT_STORE   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SGN_INT_STORE.sql =========*** End ***
PROMPT ===================================================================================== 
