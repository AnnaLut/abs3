

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/LINES_F.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to LINES_F ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''LINES_F'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''LINES_F'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''LINES_F'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table LINES_F ***
begin 
  execute immediate '
  CREATE TABLE BARS.LINES_F 
   (	FN VARCHAR2(30), 
	DAT DATE, 
	N NUMBER, 
	MFO VARCHAR2(9), 
	OKPO VARCHAR2(14), 
	RTYPE NUMBER(1,0), 
	OTYPE NUMBER(1,0), 
	ODATE DATE, 
	NLS VARCHAR2(14), 
	NLSM NUMBER(1,0), 
	KV NUMBER(3,0), 
	RESID NUMBER(1,0), 
	NMKK VARCHAR2(38), 
	C_REG NUMBER(2,0), 
	NTAX NUMBER(2,0), 
	ID_O VARCHAR2(6), 
	SIGN RAW(64), 
	ERR VARCHAR2(4), 
	DAT_IN_DPA DATE, 
	DAT_ACC_DPA DATE, 
	ID_PR NUMBER(2,0), 
	ID_DPA NUMBER(2,0), 
	ID_DPS NUMBER(2,0), 
	ID_REC VARCHAR2(24), 
	FN_R VARCHAR2(30), 
	DATE_R DATE, 
	N_R NUMBER(6,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	ADR VARCHAR2(80)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to LINES_F ***
 exec bpa.alter_policies('LINES_F');

COMMENT ON TABLE BARS.LINES_F IS 'Детальні рядки файла @F';

COMMENT ON TABLE BARS.LINES_F IS '';
COMMENT ON COLUMN BARS.LINES_F.KF IS '';
COMMENT ON COLUMN BARS.LINES_F.ADR IS '';
COMMENT ON COLUMN BARS.LINES_F.FN IS '';
COMMENT ON COLUMN BARS.LINES_F.DAT IS '';
COMMENT ON COLUMN BARS.LINES_F.N IS '';
COMMENT ON COLUMN BARS.LINES_F.MFO IS '';
COMMENT ON COLUMN BARS.LINES_F.OKPO IS '';
COMMENT ON COLUMN BARS.LINES_F.RTYPE IS 'Реєстр, якому належить податковий номер: 0 - податковий номер не належить жодному реєстру, 1 - ЄДРПОУ, 2 - ДРФО, 3 - податковий номер, наданий контролюючим органом, 4 - серія та номер паспорта (для фізичної особи, яка має відмітку у паспорті про право здійснювати будь-які платежі за серією та номером паспорта)';
COMMENT ON COLUMN BARS.LINES_F.OTYPE IS 'Тип операції: 1 - відкрито рахунок, 3 - закрито рахунок, 5 - зміна рахунка (закрито рахунок не за ініціативою клієнта), 6 - зміна рахунка (відкрито рахунок не за ініціативою клієнта)';
COMMENT ON COLUMN BARS.LINES_F.ODATE IS 'Дата операції';
COMMENT ON COLUMN BARS.LINES_F.NLS IS '';
COMMENT ON COLUMN BARS.LINES_F.NLSM IS '';
COMMENT ON COLUMN BARS.LINES_F.KV IS '';
COMMENT ON COLUMN BARS.LINES_F.RESID IS '';
COMMENT ON COLUMN BARS.LINES_F.NMKK IS '';
COMMENT ON COLUMN BARS.LINES_F.C_REG IS '';
COMMENT ON COLUMN BARS.LINES_F.NTAX IS '';
COMMENT ON COLUMN BARS.LINES_F.ID_O IS '';
COMMENT ON COLUMN BARS.LINES_F.SIGN IS '';
COMMENT ON COLUMN BARS.LINES_F.ERR IS '';
COMMENT ON COLUMN BARS.LINES_F.DAT_IN_DPA IS '';
COMMENT ON COLUMN BARS.LINES_F.DAT_ACC_DPA IS '';
COMMENT ON COLUMN BARS.LINES_F.ID_PR IS '';
COMMENT ON COLUMN BARS.LINES_F.ID_DPA IS '';
COMMENT ON COLUMN BARS.LINES_F.ID_DPS IS '';
COMMENT ON COLUMN BARS.LINES_F.ID_REC IS '';
COMMENT ON COLUMN BARS.LINES_F.FN_R IS '';
COMMENT ON COLUMN BARS.LINES_F.DATE_R IS '';
COMMENT ON COLUMN BARS.LINES_F.N_R IS '';




PROMPT *** Create  constraint PK_LINESF ***
begin   
 execute immediate '
  ALTER TABLE BARS.LINES_F ADD CONSTRAINT PK_LINESF PRIMARY KEY (FN, DAT, N)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_LINESF_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.LINES_F MODIFY (KF CONSTRAINT CC_LINESF_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_LINESF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_LINESF ON BARS.LINES_F (FN, DAT, N) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

begin
    execute immediate 'alter table BARS.LINES_F add dpa_ead_que_id number(38)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/

COMMENT ON COLUMN BARS.LINES_F.DPA_EAD_QUE_ID IS 'ID запису в черзі на відправку документа в ЕА';

PROMPT *** Create  index i_lines_f_dpa_ead_que_id ***
begin
  execute immediate '
    create index i_lines_f_dpa_ead_que_id on BARS.LINES_F(dpa_ead_que_id)
      tablespace BRSMDLI
      pctfree 10
      initrans 2
      maxtrans 255
      storage
      (
        initial 64K
        next 1M
        minextents 1
        maxextents unlimited
      )
  ';
exception when others then 
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/


PROMPT *** Create  index i_lines_f_nlsotype ***
begin
  execute immediate '
    create index i_lines_f_nlsotype on BARS.LINES_F(mfo,nls,kv,otype)
      tablespace BRSMDLI
      pctfree 10
      initrans 2
      maxtrans 255
      storage
      (
        initial 64K
        next 1M
        minextents 1
        maxextents unlimited
      )
  ';
exception when others then 
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/


PROMPT *** Create  grants  LINES_F ***
grant SELECT                                                                 on LINES_F         to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on LINES_F         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on LINES_F         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on LINES_F         to RPBN002;
grant SELECT                                                                 on LINES_F         to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on LINES_F         to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to LINES_F ***

  CREATE OR REPLACE PUBLIC SYNONYM LINES_F FOR BARS.LINES_F;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/LINES_F.sql =========*** End *** =====
PROMPT ===================================================================================== 
