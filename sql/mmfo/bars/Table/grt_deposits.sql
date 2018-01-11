

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/GRT_DEPOSITS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to GRT_DEPOSITS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''GRT_DEPOSITS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''GRT_DEPOSITS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''GRT_DEPOSITS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table GRT_DEPOSITS ***
begin 
  execute immediate '
  CREATE TABLE BARS.GRT_DEPOSITS 
   (	DEAL_ID NUMBER(38,0), 
	DOC_NUM VARCHAR2(24), 
	DOC_DATE DATE, 
	DOC_ENDDATE DATE, 
	ACC NUMBER(38,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to GRT_DEPOSITS ***
 exec bpa.alter_policies('GRT_DEPOSITS');


COMMENT ON TABLE BARS.GRT_DEPOSITS IS 'Информация о залоговых депозитах';
COMMENT ON COLUMN BARS.GRT_DEPOSITS.DEAL_ID IS 'Идентификатор договора залога';
COMMENT ON COLUMN BARS.GRT_DEPOSITS.DOC_NUM IS 'Номер депозитного договора';
COMMENT ON COLUMN BARS.GRT_DEPOSITS.DOC_DATE IS 'Дата дата депозитного договора';
COMMENT ON COLUMN BARS.GRT_DEPOSITS.DOC_ENDDATE IS 'Дата окончания договора';
COMMENT ON COLUMN BARS.GRT_DEPOSITS.ACC IS 'Идентификатор счета договора';




PROMPT *** Create  constraint PK_DEPOSITS ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_DEPOSITS ADD CONSTRAINT PK_DEPOSITS PRIMARY KEY (DEAL_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DEPOSITS_DOCNUM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_DEPOSITS MODIFY (DOC_NUM CONSTRAINT CC_DEPOSITS_DOCNUM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DEPOSITS_DOCDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_DEPOSITS MODIFY (DOC_DATE CONSTRAINT CC_DEPOSITS_DOCDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DEPOSITS_ACC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_DEPOSITS MODIFY (ACC CONSTRAINT CC_DEPOSITS_ACC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DEPOSITS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DEPOSITS ON BARS.GRT_DEPOSITS (DEAL_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  GRT_DEPOSITS ***
grant SELECT                                                                 on GRT_DEPOSITS    to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on GRT_DEPOSITS    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on GRT_DEPOSITS    to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on GRT_DEPOSITS    to START1;
grant SELECT                                                                 on GRT_DEPOSITS    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/GRT_DEPOSITS.sql =========*** End *** 
PROMPT ===================================================================================== 
