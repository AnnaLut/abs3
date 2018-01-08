

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SW_950.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SW_950 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SW_950'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''SW_950'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''SW_950'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SW_950 ***
begin 
  execute immediate '
  CREATE TABLE BARS.SW_950 
   (	SWREF NUMBER(38,0), 
	NOSTRO_ACC NUMBER(38,0), 
	NUM VARCHAR2(35), 
	STMT_DATE DATE DEFAULT null, 
	OBAL NUMBER(24,0), 
	CBAL NUMBER(24,0), 
	ADD_INFO VARCHAR2(400), 
	DONE NUMBER(1,0), 
	STMT_BDATE DATE, 
	KV NUMBER(3,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SW_950 ***
 exec bpa.alter_policies('SW_950');


COMMENT ON TABLE BARS.SW_950 IS 'SWT. Выписки';
COMMENT ON COLUMN BARS.SW_950.SWREF IS 'Референс сообщения';
COMMENT ON COLUMN BARS.SW_950.NOSTRO_ACC IS 'Код счета выписки';
COMMENT ON COLUMN BARS.SW_950.NUM IS 'Страница';
COMMENT ON COLUMN BARS.SW_950.STMT_DATE IS 'Конечная дата выписки';
COMMENT ON COLUMN BARS.SW_950.OBAL IS 'Входящий остаток';
COMMENT ON COLUMN BARS.SW_950.CBAL IS 'Исходящий остаток';
COMMENT ON COLUMN BARS.SW_950.ADD_INFO IS 'Дополнительная информация';
COMMENT ON COLUMN BARS.SW_950.DONE IS 'Признак обработанного сообщения';
COMMENT ON COLUMN BARS.SW_950.STMT_BDATE IS 'Начальная дата выписки';
COMMENT ON COLUMN BARS.SW_950.KV IS '';
COMMENT ON COLUMN BARS.SW_950.KF IS '';




PROMPT *** Create  constraint PK_SW950 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_950 ADD CONSTRAINT PK_SW950 PRIMARY KEY (SWREF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SW950_DONE ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_950 ADD CONSTRAINT CC_SW950_DONE CHECK (done in (1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SW950_TABVAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_950 ADD CONSTRAINT FK_SW950_TABVAL FOREIGN KEY (KV)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SW950_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_950 ADD CONSTRAINT FK_SW950_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SW950_ACCOUNTS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_950 ADD CONSTRAINT FK_SW950_ACCOUNTS2 FOREIGN KEY (KF, NOSTRO_ACC)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SW950_SWJOURNAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_950 ADD CONSTRAINT FK_SW950_SWJOURNAL FOREIGN KEY (SWREF)
	  REFERENCES BARS.SW_JOURNAL (SWREF) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SW950_KV_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_950 MODIFY (KV CONSTRAINT CC_SW950_KV_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SW950_SWREF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_950 MODIFY (SWREF CONSTRAINT CC_SW950_SWREF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SW950_NUM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_950 MODIFY (NUM CONSTRAINT CC_SW950_NUM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SW950_STMTDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_950 MODIFY (STMT_DATE CONSTRAINT CC_SW950_STMTDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SW950_OBAL_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_950 MODIFY (OBAL CONSTRAINT CC_SW950_OBAL_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SW950_CBAL_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_950 MODIFY (CBAL CONSTRAINT CC_SW950_CBAL_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SW950_STMTBDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_950 MODIFY (STMT_BDATE CONSTRAINT CC_SW950_STMTBDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SW950_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_950 MODIFY (KF CONSTRAINT CC_SW950_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SW950 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SW950 ON BARS.SW_950 (SWREF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SW_950 ***
grant SELECT,UPDATE                                                          on SW_950          to BARS013;
grant SELECT,UPDATE                                                          on SW_950          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SW_950          to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SW_950          to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to SW_950 ***

  CREATE OR REPLACE PUBLIC SYNONYM SW_950 FOR BARS.SW_950;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SW_950.sql =========*** End *** ======
PROMPT ===================================================================================== 
