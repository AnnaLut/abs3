

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ZAY_DEBT_KLB.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ZAY_DEBT_KLB ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ZAY_DEBT_KLB'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''ZAY_DEBT_KLB'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''ZAY_DEBT_KLB'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ZAY_DEBT_KLB ***
begin 
  execute immediate '
  CREATE TABLE BARS.ZAY_DEBT_KLB 
   (	RNK NUMBER, 
	DATZ DATE, 
	KV2 NUMBER, 
	S2 NUMBER, 
	KURS_Z NUMBER(10,8), 
	ACC0 NUMBER, 
	MFO0 VARCHAR2(12), 
	NLS0 VARCHAR2(15), 
	OKPO0 VARCHAR2(10), 
	FNAMEKB VARCHAR2(12), 
	IDENTKB VARCHAR2(16), 
	TIPKB NUMBER(*,0), 
	DATEDOKKB DATE, 
	ND VARCHAR2(10), 
	DATT DATE, 
	FL_KURSZ NUMBER(1,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ZAY_DEBT_KLB ***
 exec bpa.alter_policies('ZAY_DEBT_KLB');


COMMENT ON TABLE BARS.ZAY_DEBT_KLB IS '';
COMMENT ON COLUMN BARS.ZAY_DEBT_KLB.RNK IS 'Рег.№ клиента';
COMMENT ON COLUMN BARS.ZAY_DEBT_KLB.DATZ IS 'Дата заявки';
COMMENT ON COLUMN BARS.ZAY_DEBT_KLB.KV2 IS 'Валюта заявки';
COMMENT ON COLUMN BARS.ZAY_DEBT_KLB.S2 IS 'Сумма валюты';
COMMENT ON COLUMN BARS.ZAY_DEBT_KLB.KURS_Z IS 'Курс заявленный (клиента)';
COMMENT ON COLUMN BARS.ZAY_DEBT_KLB.ACC0 IS 'Счет клиента в нашем банке для зачисления вырученной грн';
COMMENT ON COLUMN BARS.ZAY_DEBT_KLB.MFO0 IS 'МФО банка для зачисления грн';
COMMENT ON COLUMN BARS.ZAY_DEBT_KLB.NLS0 IS 'Счет клиента в чужом банке для зачисления вырученной грн';
COMMENT ON COLUMN BARS.ZAY_DEBT_KLB.OKPO0 IS 'ОКПО клиента для зачисления вырученной грн';
COMMENT ON COLUMN BARS.ZAY_DEBT_KLB.FNAMEKB IS 'Имя файла заявок, принятых по клиент-банку';
COMMENT ON COLUMN BARS.ZAY_DEBT_KLB.IDENTKB IS 'Идентификатор заявки, принятой по Клиент-Банку';
COMMENT ON COLUMN BARS.ZAY_DEBT_KLB.TIPKB IS 'Тип документа от Клиент-Банка';
COMMENT ON COLUMN BARS.ZAY_DEBT_KLB.DATEDOKKB IS 'Дата приема документа от Клиент-Банка';
COMMENT ON COLUMN BARS.ZAY_DEBT_KLB.ND IS 'Номер документа, поступившего из Клиент-Банка';
COMMENT ON COLUMN BARS.ZAY_DEBT_KLB.DATT IS 'Граничная дата действия заявки';
COMMENT ON COLUMN BARS.ZAY_DEBT_KLB.FL_KURSZ IS '';
COMMENT ON COLUMN BARS.ZAY_DEBT_KLB.KF IS '';




PROMPT *** Create  constraint CC_ZAYDEBTKLB_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_DEBT_KLB MODIFY (KF CONSTRAINT CC_ZAYDEBTKLB_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ZAY_DEBT_KLB ***
grant SELECT                                                                 on ZAY_DEBT_KLB    to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT                                                   on ZAY_DEBT_KLB    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ZAY_DEBT_KLB    to BARS_DM;
grant SELECT                                                                 on ZAY_DEBT_KLB    to START1;
grant INSERT                                                                 on ZAY_DEBT_KLB    to TECH_MOM1;
grant SELECT                                                                 on ZAY_DEBT_KLB    to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ZAY_DEBT_KLB    to WR_ALL_RIGHTS;
grant DELETE,SELECT                                                          on ZAY_DEBT_KLB    to ZAY;



PROMPT *** Create SYNONYM  to ZAY_DEBT_KLB ***

  CREATE OR REPLACE PUBLIC SYNONYM ZAY_DEBT_KLB FOR BARS.ZAY_DEBT_KLB;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ZAY_DEBT_KLB.sql =========*** End *** 
PROMPT ===================================================================================== 
