

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/AQ_SUBSCRIBERS_ACC.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  table AQ_SUBSCRIBERS_ACC ***
begin 
  execute immediate '
  CREATE TABLE BARSAQ.AQ_SUBSCRIBERS_ACC 
   (	NAME VARCHAR2(30), 
	ACC NUMBER, 
	 CONSTRAINT PK_AQ_SUBSCRIBERS_ACC PRIMARY KEY (NAME, ACC) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSSMLI 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSAQ.AQ_SUBSCRIBERS_ACC IS 'Подписчики - счета';
COMMENT ON COLUMN BARSAQ.AQ_SUBSCRIBERS_ACC.NAME IS 'Имя подписчика';
COMMENT ON COLUMN BARSAQ.AQ_SUBSCRIBERS_ACC.ACC IS 'ACC счета';




PROMPT *** Create  constraint CC_AQSUBSCRIBERSACC_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.AQ_SUBSCRIBERS_ACC MODIFY (NAME CONSTRAINT CC_AQSUBSCRIBERSACC_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_AQSUBSCRIBERSACC_ACC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.AQ_SUBSCRIBERS_ACC MODIFY (ACC CONSTRAINT CC_AQSUBSCRIBERSACC_ACC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_AQ_SUBSCRIBERS_ACC ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.AQ_SUBSCRIBERS_ACC ADD CONSTRAINT PK_AQ_SUBSCRIBERS_ACC PRIMARY KEY (NAME, ACC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_AQ_SUBSCRIBERS_ACC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSAQ.PK_AQ_SUBSCRIBERS_ACC ON BARSAQ.AQ_SUBSCRIBERS_ACC (NAME, ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_AQ_SUBSCRIBERS_ACC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSAQ.I_AQ_SUBSCRIBERS_ACC ON BARSAQ.AQ_SUBSCRIBERS_ACC (ACC, NAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  AQ_SUBSCRIBERS_ACC ***
grant DELETE                                                                 on AQ_SUBSCRIBERS_ACC to BARS;
grant SELECT                                                                 on AQ_SUBSCRIBERS_ACC to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/AQ_SUBSCRIBERS_ACC.sql =========*** 
PROMPT ===================================================================================== 
