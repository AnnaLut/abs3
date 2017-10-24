

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CUSTOMERW.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CUSTOMERW ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CUSTOMERW'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CUSTOMERW'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CUSTOMERW ***
begin 
  execute immediate '
  CREATE TABLE BARS.CUSTOMERW 
   (	RNK NUMBER(38,0), 
	TAG CHAR(5), 
	VALUE VARCHAR2(500), 
	ISP NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CUSTOMERW ***
 exec bpa.alter_policies('CUSTOMERW');


COMMENT ON TABLE BARS.CUSTOMERW IS 'Хранилище реквизитов клиентов';
COMMENT ON COLUMN BARS.CUSTOMERW.RNK IS 'Рег.№ клиента';
COMMENT ON COLUMN BARS.CUSTOMERW.TAG IS 'Код реквизита';
COMMENT ON COLUMN BARS.CUSTOMERW.VALUE IS 'Значение реквизита';
COMMENT ON COLUMN BARS.CUSTOMERW.ISP IS 'Исполнитель заполнения реквизита';




PROMPT *** Create  constraint FK_CUSTOMERW_CUSTOMER ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMERW ADD CONSTRAINT FK_CUSTOMERW_CUSTOMER FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMERW_CUSTFIELD ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMERW ADD CONSTRAINT FK_CUSTOMERW_CUSTFIELD FOREIGN KEY (TAG)
	  REFERENCES BARS.CUSTOMER_FIELD (TAG) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_CUSTOMERW ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMERW ADD CONSTRAINT UK_CUSTOMERW UNIQUE (RNK, TAG)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_CUSTOMERW ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMERW ADD CONSTRAINT PK_CUSTOMERW PRIMARY KEY (RNK, TAG, ISP)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERW_ISP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMERW MODIFY (ISP CONSTRAINT CC_CUSTOMERW_ISP_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERW_TAG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMERW MODIFY (TAG CONSTRAINT CC_CUSTOMERW_TAG_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERW_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMERW MODIFY (RNK CONSTRAINT CC_CUSTOMERW_RNK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_CUSTOMERW_TAG_VALUE ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_CUSTOMERW_TAG_VALUE ON BARS.CUSTOMERW (TAG, VALUE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_CUSTOMERW ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_CUSTOMERW ON BARS.CUSTOMERW (RNK, TAG) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CUSTOMERW ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CUSTOMERW ON BARS.CUSTOMERW (RNK, TAG, ISP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CUSTOMERW ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CUSTOMERW       to ABS_ADMIN;
grant SELECT                                                                 on CUSTOMERW       to AN_KL;
grant REFERENCES,SELECT                                                      on CUSTOMERW       to BARSAQ with grant option;
grant REFERENCES,SELECT                                                      on CUSTOMERW       to BARSAQ_ADM with grant option;
grant SELECT                                                                 on CUSTOMERW       to BARSDWH_ACCESS_USER;
grant SELECT                                                                 on CUSTOMERW       to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on CUSTOMERW       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CUSTOMERW       to BARS_DM;
grant SELECT                                                                 on CUSTOMERW       to BARS_SUP;
grant SELECT                                                                 on CUSTOMERW       to DPT;
grant SELECT                                                                 on CUSTOMERW       to DPT_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CUSTOMERW       to ELT;
grant DELETE,INSERT,SELECT,UPDATE                                            on CUSTOMERW       to RCC_DEAL;
grant SELECT                                                                 on CUSTOMERW       to START1;
grant SELECT                                                                 on CUSTOMERW       to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CUSTOMERW       to WR_ALL_RIGHTS;
grant DELETE,SELECT                                                          on CUSTOMERW       to WR_CUSTREG;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CUSTOMERW.sql =========*** End *** ===
PROMPT ===================================================================================== 
