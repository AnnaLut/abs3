

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SW_STMT_INFO.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SW_STMT_INFO ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SW_STMT_INFO'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''SW_STMT_INFO'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''SW_STMT_INFO'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SW_STMT_INFO ***
begin 
  execute immediate '
  CREATE TABLE BARS.SW_STMT_INFO 
   (	ACC NUMBER(38,0), 
	STATEMENT_NUMBER NUMBER(4,0), 
	LAST_MESSAGE_REF NUMBER(24,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SW_STMT_INFO ***
 exec bpa.alter_policies('SW_STMT_INFO');


COMMENT ON TABLE BARS.SW_STMT_INFO IS 'SWT. Информация о сформированных выписках';
COMMENT ON COLUMN BARS.SW_STMT_INFO.ACC IS 'Идентификатор счета';
COMMENT ON COLUMN BARS.SW_STMT_INFO.STATEMENT_NUMBER IS 'Номер последней сформированной выписки';
COMMENT ON COLUMN BARS.SW_STMT_INFO.LAST_MESSAGE_REF IS 'Идентификатор сформированного сообщения';
COMMENT ON COLUMN BARS.SW_STMT_INFO.KF IS '';




PROMPT *** Create  constraint PK_SWSTMTINFO ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_STMT_INFO ADD CONSTRAINT PK_SWSTMTINFO PRIMARY KEY (ACC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SWSTMTINFO_SWJOURNAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_STMT_INFO ADD CONSTRAINT FK_SWSTMTINFO_SWJOURNAL FOREIGN KEY (LAST_MESSAGE_REF)
	  REFERENCES BARS.SW_JOURNAL (SWREF) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SWSTMTINFO_ACCOUNTS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_STMT_INFO ADD CONSTRAINT FK_SWSTMTINFO_ACCOUNTS2 FOREIGN KEY (KF, ACC)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SWSTMTINFO_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_STMT_INFO ADD CONSTRAINT FK_SWSTMTINFO_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWSTMTINFO_ACC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_STMT_INFO MODIFY (ACC CONSTRAINT CC_SWSTMTINFO_ACC_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWSTMTINFO_STMTNUM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_STMT_INFO MODIFY (STATEMENT_NUMBER CONSTRAINT CC_SWSTMTINFO_STMTNUM_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWSTMTINFO_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_STMT_INFO MODIFY (KF CONSTRAINT CC_SWSTMTINFO_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SWSTMTINFO ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SWSTMTINFO ON BARS.SW_STMT_INFO (ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SW_STMT_INFO ***
grant SELECT                                                                 on SW_STMT_INFO    to BARS013;
grant SELECT                                                                 on SW_STMT_INFO    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SW_STMT_INFO    to BARS_DM;
grant SELECT,UPDATE                                                          on SW_STMT_INFO    to SWTOSS;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SW_STMT_INFO    to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to SW_STMT_INFO ***

  CREATE OR REPLACE PUBLIC SYNONYM SW_STMT_INFO FOR BARS.SW_STMT_INFO;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SW_STMT_INFO.sql =========*** End *** 
PROMPT ===================================================================================== 
