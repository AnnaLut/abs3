

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/IBANK_ACC.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  table IBANK_ACC ***
begin 
  execute immediate '
  CREATE TABLE BARSAQ.IBANK_ACC 
   (	KF VARCHAR2(6), 
	ACC NUMBER(*,0), 
	 CONSTRAINT PK_IBANKACC PRIMARY KEY (KF, ACC) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSDYND 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSAQ.IBANK_ACC IS 'Список счетов работающих в IBANK';
COMMENT ON COLUMN BARSAQ.IBANK_ACC.KF IS 'Код банка, где открыт счет';
COMMENT ON COLUMN BARSAQ.IBANK_ACC.ACC IS 'ACC счета';




PROMPT *** Create  constraint CC_IBANKACC_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.IBANK_ACC MODIFY (KF CONSTRAINT CC_IBANKACC_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_IBANKACC_ACC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.IBANK_ACC MODIFY (ACC CONSTRAINT CC_IBANKACC_ACC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



/*
PROMPT *** Create  constraint PK_IBANKACC ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.IBANK_ACC ADD CONSTRAINT PK_IBANKACC PRIMARY KEY (KF, ACC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/
*/



PROMPT *** Create  constraint FK_IBANKACC_BANKS ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.IBANK_ACC ADD CONSTRAINT FK_IBANKACC_BANKS FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_IBANKACC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSAQ.PK_IBANKACC ON BARSAQ.IBANK_ACC (KF, ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

begin   
 execute immediate 'alter table BARSAQ.IBANK_ACC add acc_corp2 INTEGER';
exception when others then
  if  sqlcode=-1430  then null; else raise; end if;
 end;
/

begin   
 execute immediate 'alter table BARSAQ.IBANK_ACC add visa_count NUMBER';
exception when others then
  if  sqlcode=-1430  then null; else raise; end if;
 end;
/

-- Add comments to the columns 
comment on column BARSAQ.IBANK_ACC.acc_corp2
  is 'ACC счета Corp2';

PROMPT *** Create  grants  IBANK_ACC ***
grant SELECT                                                                 on IBANK_ACC       to BARSREADER_ROLE;
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/IBANK_ACC.sql =========*** End *** =
PROMPT ===================================================================================== 
