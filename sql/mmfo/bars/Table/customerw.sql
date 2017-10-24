

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CUSTOMERW.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CUSTOMERW ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CUSTOMERW'', ''CENTER'' , null, null, null, null);
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
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSBIGD 
  PARTITION BY LIST (TAG) 
 (PARTITION P_GENERAL  VALUES (''MATER'', ''SWS86'', ''VISA'', ''OSN'', ''FO'', ''EXCLN'', ''DOV_A'', ''FGIDX'', ''BUSSL'', ''BUSSS'', ''NER_D'', ''NER_C'', ''NER_N'', ''OBPR'', ''URKLI'', ''VLIC'', ''VPD'', ''IO'', ''MAMA'', ''N_RPP'', ''DATVR'', ''DLIC'', ''DATK'', ''N_SVD'', ''N_RPD'', ''DOV_F'', ''TEL_D'', ''KODID'', ''KVPKK'', ''K013'', ''AGENT'', ''RCOMM'', ''N_REE'', ''KURAK'', ''KURAT'', ''KURAR'', ''DR'', ''MPNO'', ''FIRMA'', ''NLIC'', ''N_RPN'', ''INSFO'', ''OPERB'', ''OPER'', ''N_SVO'', ''VIDY'', ''PIDPR'', ''DOV_P'', ''VNCRP'', ''KONTR'', ''ZVYO'', ''WORKU'', ''VNCRR'', ''ISP'', ''N_SVI'', ''SUPR'', ''FIN23'', ''AF3'', ''AF5'', ''ADRU'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_GENERAL_SUM  VALUES (''SUM1'', ''SUM2'', ''SUM3'', ''SUM4'') SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_GENERAL_COUNT  VALUES (''COUN1'', ''COUN2'', ''COUN3'', ''COUN4'') SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_GENERAL_NOTAR  VALUES (''NOTAT'', ''NOTAN'', ''NOTAS'', ''NOTTA'', ''NOTAR'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_GENERAL_SN  VALUES (''SN_GC'', ''SN_FN'', ''SN_4N'', ''SN_MN'', ''SN_LN'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_GENERAL_NSM  VALUES (''NSMCV'', ''NSMCC'', ''NSMCT'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_BPK_W4  VALUES (''W4SKS'', ''W4KKS'', ''W4KKA'', ''W4KKT'', ''W4KKB'', ''W4KKZ'', ''W4KKW'', ''W4KKR'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_BPK_PC  VALUES (''PC_MF'', ''PC_Z4'', ''PC_Z3'', ''PC_Z5'', ''PC_Z2'', ''PC_Z1'', ''PC_SS'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_CRV  VALUES (''RVDBC'', ''RVIBA'', ''RVIBR'', ''RVIBB'', ''RVIDT'', ''RV_XA'', ''RVRNK'', ''RVPH1'', ''RVPH2'', ''RVPH3'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_FM_DJ  VALUES (''DJ_S1'', ''DJ_S2'', ''DJ_S3'', ''DJ_S4'', ''DJ_C1'', ''DJ_C2'', ''DJ_C3'', ''DJ_C4'', ''DJER1'', ''DJER2'', ''DJER3'', ''DJER4'', ''DJOTH'', ''DJOWF'', ''DJ_MA'', ''DJ_LN'', ''DJ_TC'', ''DJAVI'', ''DJCFI'', ''DJ_FH'', ''DJ_CP'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_FM_FS  VALUES (''FSIN'', ''FSZAS'', ''FSVLI'', ''FSVLA'', ''FSVLZ'', ''FSVLN'', ''FSVLO'', ''FSCP'', ''FSVLM'', ''FSDVD'', ''FSOBK'', ''FSDPD'', ''FSZP'', ''FSZOP'', ''FSVED'', ''FSKPK'', ''FSKPR'', ''FSKRB'', ''FSKRD'', ''FSKRN'', ''FSDIB'', ''FSKRK'', ''FSOVR'', ''FSOMD'', ''FSODI'', ''FSODV'', ''FSODP'', ''FSODT'', ''FSPOR'', ''FSDEP'', ''FSRSK'', ''FSRKZ'', ''FSSST'', ''FSSOD'', ''FSDRY'', ''FSVSN'', ''FSB'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_FM  VALUES (''IDPPD'', ''IDPIB'', ''RIZIK'', ''AF4_B'', ''AINAB'', ''SPECB'', ''USTF'', ''TIPFO'', ''BKOR'', ''ABSRE'', ''POSRB'', ''DJER'', ''SUTD'', ''PEP'', ''HKLI'', ''LICO'', ''WORK'', ''PUBLP'', ''NRDAT'', ''NRORG'', ''NRSVI'', ''SNSDR'', ''OUNAM'', ''OUCMP'', ''OVIFS'', ''OVIDP'', ''FSZPD'', ''AF6'', ''O_REP'', ''INZAS'', ''ID_YN'', ''OSOBA'', ''OBSLU'', ''OIST'', ''HIST'', ''EMAIL'', ''ADRW'', ''FADR'', ''FADRB'', ''PODR'', ''PODR2'', ''UPFO'', ''CCVED'', ''TIPA'', ''PHKLI'', ''GR'', ''NPDV'', ''AF1_9'', ''PLPPR'', ''IDDPD'', ''DAIDI'', ''DATZ'', ''IDDPL'', ''IDDPR'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_OTHERS  VALUES (''SUBSD'', ''SUBSN'', ''RS6S5'', ''RS6HI'', ''ELT_N'', ''ELT_D'', ''RNKS6'', ''RS6S6'', ''RNKUN'', ''RNKUF'', ''STMT'', ''SW_RN'', ''OSNUL'', ''RKO_N'', ''Y_ELT'', ''SAMZ'', ''VIDKL'', ''VYDPP'', ''DDBO'', ''RKO_D'', ''NDBO'', ''CRSRC'', ''CHORN'', ''SPMRK'', ''LINKG'', ''UADR'', ''MOB01'', ''MOB02'', ''MOB03'', ''INVCL'', ''DEATH'', ''SUBS'', ''UUCG'', ''ADRP'', ''VIP_K'', ''NOTAX'', ''WORKB'', ''BIC'', ''CIGPO'', ''TARIF'', ''FZ'', ''UUDV'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_OTHERS_MS  VALUES (''MS_FS'', ''MS_KL'', ''MS_VD'', ''MS_GR'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_OTHERS_FG  VALUES (''FGADR'', ''FGTWN'', ''FGOBL'', ''FGDST'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_DEFAULT  VALUES (DEFAULT) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD ) ';
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




PROMPT *** Create  constraint PK_CUSTOMERW ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMERW ADD CONSTRAINT PK_CUSTOMERW PRIMARY KEY (TAG, RNK)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS COMPRESS 1 
  TABLESPACE BRSMDLI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMERW_CUSTFIELD ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMERW ADD CONSTRAINT FK_CUSTOMERW_CUSTFIELD FOREIGN KEY (TAG)
	  REFERENCES BARS.CUSTOMER_FIELD (TAG) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMERW_CUSTOMER ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMERW ADD CONSTRAINT FK_CUSTOMERW_CUSTOMER FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CUSTOMERW ***
begin   
 execute immediate '
  CREATE INDEX BARS.PK_CUSTOMERW ON BARS.CUSTOMERW (TAG, RNK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS COMPRESS 1 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CUSTOMERW ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CUSTOMERW       to ABS_ADMIN;
grant SELECT                                                                 on CUSTOMERW       to AN_KL;
grant REFERENCES,SELECT                                                      on CUSTOMERW       to BARSAQ with grant option;
grant REFERENCES,SELECT                                                      on CUSTOMERW       to BARSAQ_ADM with grant option;
grant SELECT                                                                 on CUSTOMERW       to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on CUSTOMERW       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CUSTOMERW       to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CUSTOMERW       to CUSTOMERW;
grant SELECT                                                                 on CUSTOMERW       to DPT;
grant SELECT                                                                 on CUSTOMERW       to DPT_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CUSTOMERW       to ELT;
grant DELETE,INSERT,SELECT,UPDATE                                            on CUSTOMERW       to RCC_DEAL;
grant SELECT                                                                 on CUSTOMERW       to START1;
grant SELECT                                                                 on CUSTOMERW       to UPLD;
grant DELETE,INSERT,SELECT,UPDATE                                            on CUSTOMERW       to WR_ALL_RIGHTS;
grant DELETE,SELECT                                                          on CUSTOMERW       to WR_CUSTREG;
grant SELECT                                                                 on CUSTOMERW       to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CUSTOMERW.sql =========*** End *** ===
PROMPT ===================================================================================== 
