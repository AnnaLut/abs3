

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BANK_ACC.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BANK_ACC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BANK_ACC'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''BANK_ACC'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''BANK_ACC'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BANK_ACC ***
begin 
  execute immediate '
  CREATE TABLE BARS.BANK_ACC 
   (	ACC NUMBER(38,0), 
	MFO VARCHAR2(12), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	 CONSTRAINT PK_BANKACC PRIMARY KEY (ACC, MFO) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSSMLI 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BANK_ACC ***
 exec bpa.alter_policies('BANK_ACC');


COMMENT ON TABLE BARS.BANK_ACC IS 'Принадлежность счетов расчетным палатам';
COMMENT ON COLUMN BARS.BANK_ACC.ACC IS 'Внутренний номер счета';
COMMENT ON COLUMN BARS.BANK_ACC.MFO IS 'Код МФО банка';
COMMENT ON COLUMN BARS.BANK_ACC.KF IS '';




PROMPT *** Create  constraint CC_BANKACC_ACC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANK_ACC MODIFY (ACC CONSTRAINT CC_BANKACC_ACC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BANKACC_MFO_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANK_ACC MODIFY (MFO CONSTRAINT CC_BANKACC_MFO_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BANKACC_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANK_ACC MODIFY (KF CONSTRAINT CC_BANKACC_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_BANKACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANK_ACC ADD CONSTRAINT PK_BANKACC PRIMARY KEY (ACC, MFO)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_BANKACC_BANKS ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANK_ACC ADD CONSTRAINT FK_BANKACC_BANKS FOREIGN KEY (MFO)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_BANKACC_ACCOUNTS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANK_ACC ADD CONSTRAINT FK_BANKACC_ACCOUNTS2 FOREIGN KEY (KF, ACC)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_BANKACC_BANKS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANK_ACC ADD CONSTRAINT FK_BANKACC_BANKS2 FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BANKACC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BANKACC ON BARS.BANK_ACC (ACC, MFO) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BANK_ACC ***
grant DELETE,INSERT,SELECT,UPDATE                                            on BANK_ACC        to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BANK_ACC        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BANK_ACC        to BARS_DM;
grant INSERT,SELECT                                                          on BANK_ACC        to CUST001;
grant INSERT,UPDATE                                                          on BANK_ACC        to ELT;
grant SELECT                                                                 on BANK_ACC        to RPBN001;
grant SELECT                                                                 on BANK_ACC        to SETLIM01;
grant SELECT                                                                 on BANK_ACC        to START1;
grant SELECT                                                                 on BANK_ACC        to TOSS;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BANK_ACC        to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on BANK_ACC        to WR_REFREAD;
grant SELECT                                                                 on BANK_ACC        to WR_VIEWACC;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BANK_ACC.sql =========*** End *** ====
PROMPT ===================================================================================== 
