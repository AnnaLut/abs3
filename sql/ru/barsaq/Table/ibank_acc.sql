

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


COMMENT ON TABLE BARSAQ.IBANK_ACC IS '������ ������ ���������� � IBANK';
COMMENT ON COLUMN BARSAQ.IBANK_ACC.KF IS '��� �����, ��� ������ ����';
COMMENT ON COLUMN BARSAQ.IBANK_ACC.ACC IS 'ACC �����';




PROMPT *** Create  constraint FK_IBANKACC_ACCOUNTS ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.IBANK_ACC ADD CONSTRAINT FK_IBANKACC_ACCOUNTS FOREIGN KEY (KF, ACC)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_IBANKACC_BANKS ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.IBANK_ACC ADD CONSTRAINT FK_IBANKACC_BANKS FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
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




PROMPT *** Create  constraint CC_IBANKACC_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.IBANK_ACC MODIFY (KF CONSTRAINT CC_IBANKACC_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




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





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/IBANK_ACC.sql =========*** End *** =
PROMPT ===================================================================================== 
