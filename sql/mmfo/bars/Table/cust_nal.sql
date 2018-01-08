

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CUST_NAL.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CUST_NAL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CUST_NAL'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CUST_NAL'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CUST_NAL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CUST_NAL ***
begin 
  execute immediate '
  CREATE TABLE BARS.CUST_NAL 
   (	RNK NUMBER(38,0), 
	NAL_NOTE VARCHAR2(20), 
	NAL_DATE DATE, 
	S NUMBER(38,0), 
	KV NUMBER(38,0), 
	CONTRACT VARCHAR2(50), 
	DAT_CONTR DATE, 
	PID NUMBER, 
	NAL_ID NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 5 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CUST_NAL ***
 exec bpa.alter_policies('CUST_NAL');


COMMENT ON TABLE BARS.CUST_NAL IS 'Справки из НИ на покупку валюты';
COMMENT ON COLUMN BARS.CUST_NAL.RNK IS 'Рег.№ клиента';
COMMENT ON COLUMN BARS.CUST_NAL.NAL_NOTE IS '№ справки';
COMMENT ON COLUMN BARS.CUST_NAL.NAL_DATE IS 'Дата справки';
COMMENT ON COLUMN BARS.CUST_NAL.S IS 'Сумма (в коп)';
COMMENT ON COLUMN BARS.CUST_NAL.KV IS 'Валюта';
COMMENT ON COLUMN BARS.CUST_NAL.CONTRACT IS '№ контракта';
COMMENT ON COLUMN BARS.CUST_NAL.DAT_CONTR IS 'Дата контракта';
COMMENT ON COLUMN BARS.CUST_NAL.PID IS 'Референс контракта';
COMMENT ON COLUMN BARS.CUST_NAL.NAL_ID IS 'Идентификатор записи';




PROMPT *** Create  constraint PK_CUSTNAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUST_NAL ADD CONSTRAINT PK_CUSTNAL PRIMARY KEY (NAL_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTNAL_TOPCONTRACTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUST_NAL ADD CONSTRAINT FK_CUSTNAL_TOPCONTRACTS FOREIGN KEY (PID)
	  REFERENCES BARS.TOP_CONTRACTS (PID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUST_NAL_KV ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUST_NAL ADD CONSTRAINT FK_CUST_NAL_KV FOREIGN KEY (KV)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUST_NAL_RNK ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUST_NAL ADD CONSTRAINT FK_CUST_NAL_RNK FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_CUST_NAL_ID_NOTE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUST_NAL MODIFY (NAL_ID CONSTRAINT NK_CUST_NAL_ID_NOTE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CUSTNAL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CUSTNAL ON BARS.CUST_NAL (NAL_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CUST_NAL ***
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on CUST_NAL        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CUST_NAL        to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CUST_NAL        to WR_ALL_RIGHTS;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on CUST_NAL        to ZAY;



PROMPT *** Create SYNONYM  to CUST_NAL ***

  CREATE OR REPLACE PUBLIC SYNONYM CUST_NAL FOR BARS.CUST_NAL;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CUST_NAL.sql =========*** End *** ====
PROMPT ===================================================================================== 
