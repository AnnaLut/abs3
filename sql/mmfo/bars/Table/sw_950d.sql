

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SW_950D.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SW_950D ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SW_950D'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''SW_950D'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''SW_950D'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SW_950D ***
begin 
  execute immediate '
  CREATE TABLE BARS.SW_950D 
   (	SWREF NUMBER(38,0), 
	N NUMBER(10,0), 
	FUND CHAR(1), 
	S NUMBER(24,0), 
	THEIR_REF VARCHAR2(16), 
	DETAIL VARCHAR2(35), 
	ADD_INFO VARCHAR2(400), 
	CONTRA_ACC NUMBER(38,0), 
	CHECKED_IND CHAR(1), 
	OUR_REF NUMBER(38,0), 
	MT NUMBER(3,0), 
	SWTT CHAR(3), 
	VDATE DATE, 
	EDATE DATE, 
	THEIR2_REF VARCHAR2(16), 
	SRC_SWREF NUMBER(38,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	STMT_DK VARCHAR2(2)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SW_950D ***
 exec bpa.alter_policies('SW_950D');


COMMENT ON TABLE BARS.SW_950D IS 'SWT. Детальные строки выписок';
COMMENT ON COLUMN BARS.SW_950D.SWREF IS 'Референс сообщения';
COMMENT ON COLUMN BARS.SW_950D.N IS 'Номер строки выписки';
COMMENT ON COLUMN BARS.SW_950D.FUND IS 'Fund code';
COMMENT ON COLUMN BARS.SW_950D.S IS 'Сумма транзакции';
COMMENT ON COLUMN BARS.SW_950D.THEIR_REF IS 'Референс транзакции';
COMMENT ON COLUMN BARS.SW_950D.DETAIL IS 'Детали';
COMMENT ON COLUMN BARS.SW_950D.ADD_INFO IS 'Дополнительная информация';
COMMENT ON COLUMN BARS.SW_950D.CONTRA_ACC IS 'Код счета, который был использован (ностро)';
COMMENT ON COLUMN BARS.SW_950D.CHECKED_IND IS 'Признак обработанной строки выписки';
COMMENT ON COLUMN BARS.SW_950D.OUR_REF IS 'Код документа в АБС, который соответствует данной транзакции';
COMMENT ON COLUMN BARS.SW_950D.MT IS 'Тип сообщения SWIFT';
COMMENT ON COLUMN BARS.SW_950D.SWTT IS 'Тип транзакции';
COMMENT ON COLUMN BARS.SW_950D.VDATE IS 'Дата валютирования';
COMMENT ON COLUMN BARS.SW_950D.EDATE IS 'Дата поступления';
COMMENT ON COLUMN BARS.SW_950D.THEIR2_REF IS '';
COMMENT ON COLUMN BARS.SW_950D.SRC_SWREF IS 'Референс исходного сообщения';
COMMENT ON COLUMN BARS.SW_950D.KF IS '';
COMMENT ON COLUMN BARS.SW_950D.STMT_DK IS '';




PROMPT *** Create  constraint FK_SW950D_ACCOUNTS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_950D ADD CONSTRAINT FK_SW950D_ACCOUNTS2 FOREIGN KEY (KF, CONTRA_ACC)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SW950D_SWMT ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_950D ADD CONSTRAINT FK_SW950D_SWMT FOREIGN KEY (MT)
	  REFERENCES BARS.SW_MT (MT) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SW950D_VDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_950D MODIFY (VDATE CONSTRAINT CC_SW950D_VDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SW950D_THEIRREF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_950D MODIFY (THEIR_REF CONSTRAINT CC_SW950D_THEIRREF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SW950D_S_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_950D MODIFY (S CONSTRAINT CC_SW950D_S_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SW950D_N_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_950D MODIFY (N CONSTRAINT CC_SW950D_N_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SW950D_SWREF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_950D MODIFY (SWREF CONSTRAINT CC_SW950D_SWREF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SW950D ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_950D ADD CONSTRAINT PK_SW950D PRIMARY KEY (SWREF, N)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SW950D_CHECKEDIND ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_950D ADD CONSTRAINT CC_SW950D_CHECKEDIND CHECK (checked_ind in (''Y'', ''N'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SW950D_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_950D MODIFY (KF CONSTRAINT CC_SW950D_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SW950D_SWJOURNAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_950D ADD CONSTRAINT FK_SW950D_SWJOURNAL FOREIGN KEY (SWREF)
	  REFERENCES BARS.SW_JOURNAL (SWREF) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SW950D_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_950D ADD CONSTRAINT FK_SW950D_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SW950D_SWTT ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_950D ADD CONSTRAINT FK_SW950D_SWTT FOREIGN KEY (SWTT)
	  REFERENCES BARS.SW_TT (SWTT) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SW950D ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SW950D ON BARS.SW_950D (SWREF, N) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SW_950D ***
grant SELECT,UPDATE                                                          on SW_950D         to BARS013;
grant SELECT,UPDATE                                                          on SW_950D         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SW_950D         to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SW_950D         to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to SW_950D ***

  CREATE OR REPLACE PUBLIC SYNONYM SW_950D FOR BARS.SW_950D;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SW_950D.sql =========*** End *** =====
PROMPT ===================================================================================== 
