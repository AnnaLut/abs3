

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SGN_EXT_STORE.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SGN_EXT_STORE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SGN_EXT_STORE'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''SGN_EXT_STORE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SGN_EXT_STORE ***
begin 
  execute immediate '
  CREATE TABLE BARS.SGN_EXT_STORE 
   (	REF NUMBER(38,0), 
	SIGN_ID NUMBER, 
	REC_ID NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SGN_EXT_STORE ***
 exec bpa.alter_policies('SGN_EXT_STORE');


COMMENT ON TABLE BARS.SGN_EXT_STORE IS 'Сховище СЕП підписів по документам (oper)';
COMMENT ON COLUMN BARS.SGN_EXT_STORE.REF IS 'Ідентифікатор документу';
COMMENT ON COLUMN BARS.SGN_EXT_STORE.SIGN_ID IS 'Ідентифікатор підпису';
COMMENT ON COLUMN BARS.SGN_EXT_STORE.REC_ID IS '';




PROMPT *** Create  constraint CC_SGNEXTSTORE_REF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SGN_EXT_STORE MODIFY (REF CONSTRAINT CC_SGNEXTSTORE_REF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SGNEXTSTORE_SIGNID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SGN_EXT_STORE MODIFY (SIGN_ID CONSTRAINT CC_SGNEXTSTORE_SIGNID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SGNEXTSTORE_SGNDATA_REF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SGN_EXT_STORE ADD CONSTRAINT FK_SGNEXTSTORE_SGNDATA_REF FOREIGN KEY (SIGN_ID)
	  REFERENCES BARS.SGN_DATA (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_SGNEXTSTORE ***
begin   
 execute immediate '
  ALTER TABLE BARS.SGN_EXT_STORE ADD CONSTRAINT UK_SGNEXTSTORE UNIQUE (REF, SIGN_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SGNEXTSTORE ***
begin   
 execute immediate '
  ALTER TABLE BARS.SGN_EXT_STORE ADD CONSTRAINT PK_SGNEXTSTORE PRIMARY KEY (REF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SGNEXTSTORE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SGNEXTSTORE ON BARS.SGN_EXT_STORE (REF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_SGNEXTSTORE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_SGNEXTSTORE ON BARS.SGN_EXT_STORE (REF, SIGN_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SGN_EXT_STORE ***
grant SELECT                                                                 on SGN_EXT_STORE   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SGN_EXT_STORE   to TOSS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SGN_EXT_STORE.sql =========*** End ***
PROMPT ===================================================================================== 
