

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/IBANK_RNK.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  table IBANK_RNK ***
begin 
  execute immediate '
  CREATE TABLE BARSAQ.IBANK_RNK 
   (	KF VARCHAR2(6), 
	RNK NUMBER(*,0), 
	 CONSTRAINT PK_IBANKRNK PRIMARY KEY (KF, RNK) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSDYND 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSAQ.IBANK_RNK IS 'Список счетов клиентов в IBANK';
COMMENT ON COLUMN BARSAQ.IBANK_RNK.KF IS 'Код банка';
COMMENT ON COLUMN BARSAQ.IBANK_RNK.RNK IS 'RNK клиента';




PROMPT *** Create  constraint CC_IBANKRNK_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.IBANK_RNK MODIFY (KF CONSTRAINT CC_IBANKRNK_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_IBANKRNK_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.IBANK_RNK MODIFY (RNK CONSTRAINT CC_IBANKRNK_RNK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_IBANKRNK ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.IBANK_RNK ADD CONSTRAINT PK_IBANKRNK PRIMARY KEY (KF, RNK)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_IBANKRNK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSAQ.PK_IBANKRNK ON BARSAQ.IBANK_RNK (KF, RNK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  IBANK_RNK ***
grant SELECT                                                                 on IBANK_RNK       to BARS;
grant SELECT                                                                 on IBANK_RNK       to BARSREADER_ROLE;
grant SELECT                                                                 on IBANK_RNK       to BARSUPL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/IBANK_RNK.sql =========*** End *** =
PROMPT ===================================================================================== 
