

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CUSTOMERW.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CUSTOMERW ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CUSTOMERW'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CUSTOMERW'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''CUSTOMERW'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CUSTOMERW ***
begin 
  execute immediate q'[
  CREATE TABLE BARS.CUSTOMERW 
   (KF VARCHAR2(6) default sys_context('bars_context', 'user_mfo'),
    RNK NUMBER(38,0), 
	TAG CHAR(5), 
	VALUE VARCHAR2(500), 
	ISP NUMBER(38,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSBIGD 
  PARTITION BY LIST (KF) subpartition by list (TAG)
SUBPARTITION TEMPLATE
( 
  SUBPARTITION SP_GENERAL values ('MATER', 'SWS86', 'VISA', 'OSN', 'FO', 'EXCLN', 'DOV_A', 'FGIDX', 'BUSSL', 'BUSSS', 'NER_D', 'NER_C', 'NER_N', 'OBPR', 'URKLI', 'VLIC', 'VPD', 'IO', 'MAMA', 'N_RPP', 'DATVR', 'DLIC', 'DATK', 'N_SVD', 'N_RPD', 'DOV_F', 'TEL_D', 'KODID', 'KVPKK', 'K013', 'AGENT', 'RCOMM', 'N_REE', 'KURAK', 'KURAT', 'KURAR', 'DR', 'MPNO', 'FIRMA', 'NLIC', 'N_RPN', 'INSFO', 'OPERB', 'OPER', 'N_SVO', 'VIDY', 'PIDPR', 'DOV_P', 'VNCRP', 'KONTR', 'ZVYO', 'WORKU', 'VNCRR', 'ISP', 'N_SVI', 'SUPR', 'FIN23', 'AF3', 'AF5', 'ADRU'),
  SUBPARTITION SP_GENERAL_SUM values ('SUM1', 'SUM2', 'SUM3', 'SUM4'),
  SUBPARTITION SP_GENERAL_COUNT values ('COUN1', 'COUN2', 'COUN3', 'COUN4'),
  SUBPARTITION SP_GENERAL_NOTAR values ('NOTAT', 'NOTAN', 'NOTAS', 'NOTTA', 'NOTAR'),
  SUBPARTITION SP_GENERAL_SN values ('SN_GC', 'SN_FN', 'SN_4N', 'SN_MN', 'SN_LN'),
  SUBPARTITION SP_GENERAL_NSM values ('NSMCV', 'NSMCC', 'NSMCT'),
  SUBPARTITION SP_BPK_W4 values ('W4SKS', 'W4KKS', 'W4KKA', 'W4KKT', 'W4KKB', 'W4KKZ', 'W4KKW', 'W4KKR'),
  SUBPARTITION SP_BPK_PC values ('PC_MF', 'PC_Z4', 'PC_Z3', 'PC_Z5', 'PC_Z2', 'PC_Z1', 'PC_SS'),
  SUBPARTITION SP_CRV values ('RVDBC', 'RVIBA', 'RVIBR', 'RVIBB', 'RVIDT', 'RV_XA', 'RVRNK', 'RVPH1', 'RVPH2', 'RVPH3'),
  SUBPARTITION SP_FM_DJ values ('DJ_S1', 'DJ_S2', 'DJ_S3', 'DJ_S4', 'DJ_C1', 'DJ_C2', 'DJ_C3', 'DJ_C4', 'DJER1', 'DJER2', 'DJER3', 'DJER4', 'DJOTH', 'DJOWF', 'DJ_MA', 'DJ_LN', 'DJ_TC', 'DJAVI', 'DJCFI', 'DJ_FH', 'DJ_CP'),
  SUBPARTITION SP_FM_FS values ('FSIN', 'FSZAS', 'FSVLI', 'FSVLA', 'FSVLZ', 'FSVLN', 'FSVLO', 'FSCP', 'FSVLM', 'FSDVD', 'FSOBK', 'FSDPD', 'FSZP', 'FSZOP', 'FSVED', 'FSKPK', 'FSKPR', 'FSKRB', 'FSKRD', 'FSKRN', 'FSDIB', 'FSKRK', 'FSOVR', 'FSOMD', 'FSODI', 'FSODV', 'FSODP', 'FSODT', 'FSPOR', 'FSDEP', 'FSRSK', 'FSRKZ', 'FSSST', 'FSSOD', 'FSDRY', 'FSVSN', 'FSB'),
  SUBPARTITION SP_FM values ('IDPPD', 'IDPIB', 'RIZIK', 'AF4_B', 'AINAB', 'SPECB', 'USTF', 'TIPFO', 'BKOR', 'ABSRE', 'POSRB', 'DJER', 'SUTD', 'PEP', 'HKLI', 'LICO', 'WORK', 'PUBLP', 'NRDAT', 'NRORG', 'NRSVI', 'SNSDR', 'OUNAM', 'OUCMP', 'OVIFS', 'OVIDP', 'FSZPD', 'AF6', 'O_REP', 'INZAS', 'ID_YN', 'OSOBA', 'OBSLU', 'OIST', 'HIST', 'EMAIL', 'ADRW', 'FADR', 'FADRB', 'PODR', 'PODR2', 'UPFO', 'CCVED', 'TIPA', 'PHKLI', 'GR', 'NPDV', 'AF1_9', 'PLPPR', 'IDDPD', 'DAIDI', 'DATZ', 'IDDPL', 'IDDPR'),
  SUBPARTITION SP_NDBO values ('NDBO'),
  SUBPARTITION SP_DDBO values ('DDBO'),
  SUBPARTITION SP_OTHERS values ('SUBSD', 'SUBSN', 'RS6S5', 'RS6HI', 'ELT_N', 'ELT_D', 'RNKS6', 'RS6S6', 'RNKUN', 'RNKUF', 'STMT', 'SW_RN', 'OSNUL', 'RKO_N', 'Y_ELT', 'SAMZ', 'VIDKL', 'VYDPP', 'RKO_D', 'CRSRC', 'CHORN', 'SPMRK', 'LINKG', 'UADR', 'MOB01', 'MOB02', 'MOB03', 'INVCL', 'DEATH', 'SUBS', 'UUCG', 'ADRP', 'VIP_K', 'NOTAX', 'WORKB', 'BIC', 'CIGPO', 'TARIF', 'FZ', 'UUDV'),
  SUBPARTITION SP_OTHERS_MS values ('MS_FS', 'MS_KL', 'MS_VD', 'MS_GR'),
  SUBPARTITION SP_OTHERS_FG values ('FGADR', 'FGTWN', 'FGOBL', 'FGDST'),
  SUBPARTITION SP_SDBO values ('SDBO'),
  SUBPARTITION SP_DEFAULT values (DEFAULT)
)
( PARTITION P_300465 VALUES ('300465')
, PARTITION P_302076 VALUES ('302076')
, PARTITION P_303398 VALUES ('303398')
, PARTITION P_304665 VALUES ('304665')
, PARTITION P_305482 VALUES ('305482')
, PARTITION P_311647 VALUES ('311647')
, PARTITION P_312356 VALUES ('312356')
, PARTITION P_313957 VALUES ('313957')
, PARTITION P_315784 VALUES ('315784')
, PARTITION P_322669 VALUES ('322669')
, PARTITION P_323475 VALUES ('323475')
, PARTITION P_324805 VALUES ('324805')
, PARTITION P_325796 VALUES ('325796')
, PARTITION P_326461 VALUES ('326461')
, PARTITION P_328845 VALUES ('328845')
, PARTITION P_331467 VALUES ('331467')
, PARTITION P_333368 VALUES ('333368')
, PARTITION P_335106 VALUES ('335106')
, PARTITION P_336503 VALUES ('336503')
, PARTITION P_337568 VALUES ('337568')
, PARTITION P_338545 VALUES ('338545')
, PARTITION P_351823 VALUES ('351823')
, PARTITION P_352457 VALUES ('352457')
, PARTITION P_353553 VALUES ('353553')
, PARTITION P_354507 VALUES ('354507')
, PARTITION P_356334 VALUES ('356334')
) ]';
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

declare
  e_idx_exists           exception;
  pragma exception_init( e_idx_exists,      -00955 );
  e_col_already_idx      exception;
  pragma exception_init( e_col_already_idx, -01408 );
  e_dup_keys_found       exception;
  pragma exception_init( e_dup_keys_found,  -01452 );
begin
  execute immediate 'create unique index UK_CUSTOMERW on CUSTOMERW (KF, TAG, RNK) tablespace BRSBIGI local compress 1';
  dbms_output.put_line( 'Index created.' );
exception
  when e_idx_exists
  then dbms_output.put_line( 'Name is already used by an existing object.' );
  when e_col_already_idx
  then dbms_output.put_line( 'Such column list already indexed.' );
  when e_dup_keys_found
  then dbms_output.put_line( 'Cannot create unique index: duplicate keys found' );
end;
/

prompt add default value for KF
alter table customerw modify kf default sys_context('bars_context', 'user_mfo');

begin
    execute immediate 'alter table customerw add constraint CC_CUSTOMERW_KF_NN check (KF is not null) enable validate';
exception
    when others then
        if sqlcode = -2264 then null; else raise; end if;
end;
/

PROMPT *** Create  grants  CUSTOMERW ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CUSTOMERW       to ABS_ADMIN;
grant SELECT                                                                 on CUSTOMERW       to AN_KL;
grant REFERENCES,SELECT                                                      on CUSTOMERW       to BARSAQ with grant option;
grant REFERENCES,SELECT                                                      on CUSTOMERW       to BARSAQ_ADM with grant option;
grant SELECT                                                                 on CUSTOMERW       to BARSREADER_ROLE;
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
