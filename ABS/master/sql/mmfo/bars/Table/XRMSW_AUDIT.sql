

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/XRMSW_AUDIT.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to XRMSW_AUDIT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''XRMSW_AUDIT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''XRMSW_AUDIT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table XRMSW_AUDIT ***
begin 
  execute immediate '
  CREATE TABLE BARS.XRMSW_AUDIT 
   (	DATE_RUN DATE DEFAULT sysdate, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	TRANSACTIONID VARCHAR2(30), 
	TRANTYPE NUMBER(*,0), 
	DESCRIPTION VARCHAR2(50), 
	USER_LOGIN VARCHAR2(50)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to XRMSW_AUDIT ***
 exec bpa.alter_policies('XRMSW_AUDIT');


COMMENT ON TABLE BARS.XRMSW_AUDIT IS 'Журнал обробки операцфй Єдине Вікно XRM';
COMMENT ON COLUMN BARS.XRMSW_AUDIT.DATE_RUN IS 'Дата транзакції';
COMMENT ON COLUMN BARS.XRMSW_AUDIT.KF IS 'kf';
COMMENT ON COLUMN BARS.XRMSW_AUDIT.TRANSACTIONID IS 'TransactionId';
COMMENT ON COLUMN BARS.XRMSW_AUDIT.TRANTYPE IS 'Тип транзакції';
COMMENT ON COLUMN BARS.XRMSW_AUDIT.DESCRIPTION IS 'Коментар';
COMMENT ON COLUMN BARS.XRMSW_AUDIT.USER_LOGIN IS '';




PROMPT *** Create  constraint PK_XRMTRANSACTIONID ***
begin   
 execute immediate '
  ALTER TABLE BARS.XRMSW_AUDIT ADD CONSTRAINT PK_XRMTRANSACTIONID PRIMARY KEY (TRANSACTIONID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_XRMTRANSACTIONID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_XRMTRANSACTIONID ON BARS.XRMSW_AUDIT (TRANSACTIONID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IK_KF ***
begin   
 execute immediate '
  CREATE INDEX BARS.IK_KF ON BARS.XRMSW_AUDIT (KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IK_TRANTYPE ***
begin   
 execute immediate '
  CREATE INDEX BARS.IK_TRANTYPE ON BARS.XRMSW_AUDIT (TRANTYPE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  XRMSW_AUDIT ***
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on XRMSW_AUDIT     to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/XRMSW_AUDIT.sql =========*** End *** =
PROMPT ===================================================================================== 
