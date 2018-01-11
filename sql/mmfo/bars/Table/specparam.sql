

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SPECPARAM.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SPECPARAM ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SPECPARAM'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''SPECPARAM'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''SPECPARAM'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SPECPARAM ***
begin 
  execute immediate '
  CREATE TABLE BARS.SPECPARAM 
   (	ACC NUMBER(38,0), 
	R011 VARCHAR2(1), 
	R013 VARCHAR2(1), 
	S080 VARCHAR2(1), 
	S180 VARCHAR2(1), 
	S181 VARCHAR2(1), 
	S190 VARCHAR2(1), 
	S200 VARCHAR2(1), 
	S230 VARCHAR2(3), 
	S240 VARCHAR2(1), 
	D020 CHAR(2), 
	KEKD NUMBER(38,0), 
	KTK NUMBER(38,0), 
	KVK NUMBER(38,0), 
	IDG NUMBER(38,0), 
	IDS NUMBER(38,0), 
	SPS NUMBER(38,0), 
	KBK NUMBER(38,0), 
	S120 VARCHAR2(1), 
	S130 VARCHAR2(2), 
	S250 VARCHAR2(1), 
	NKD VARCHAR2(40), 
	S031 VARCHAR2(2), 
	S182 VARCHAR2(1), 
	ISTVAL NUMBER(1,0), 
	R014 VARCHAR2(1), 
	K072 VARCHAR2(1), 
	S090 CHAR(1), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	S270 VARCHAR2(2), 
	S260 VARCHAR2(2), 
	K150 VARCHAR2(1), 
	R114 VARCHAR2(1), 
	S280 VARCHAR2(2), 
	S290 VARCHAR2(2), 
	S370 VARCHAR2(1), 
	D1#F9 VARCHAR2(1), 
	NF#F9 VARCHAR2(2), 
	Z290 VARCHAR2(2), 
	DP1 VARCHAR2(1), 
	R012 VARCHAR2(1), 
	S580 VARCHAR2(1), 
	KVD NUMBER, 
	R016 VARCHAR2(2), 
	OB22_ALT CHAR(2)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SPECPARAM ***
 exec bpa.alter_policies('SPECPARAM');


COMMENT ON TABLE BARS.SPECPARAM IS 'Таблиця спец.параметрів рахунків';
COMMENT ON COLUMN BARS.SPECPARAM.OB22_ALT IS 'Ob22 РґР»СЏ СЂР°С… NLSALT';
COMMENT ON COLUMN BARS.SPECPARAM.ACC IS 'Внутренний номер счета';
COMMENT ON COLUMN BARS.SPECPARAM.R011 IS '';
COMMENT ON COLUMN BARS.SPECPARAM.R013 IS '';
COMMENT ON COLUMN BARS.SPECPARAM.S080 IS '';
COMMENT ON COLUMN BARS.SPECPARAM.S180 IS '';
COMMENT ON COLUMN BARS.SPECPARAM.S181 IS '';
COMMENT ON COLUMN BARS.SPECPARAM.S190 IS '';
COMMENT ON COLUMN BARS.SPECPARAM.S200 IS '';
COMMENT ON COLUMN BARS.SPECPARAM.S230 IS 'Символ банка';
COMMENT ON COLUMN BARS.SPECPARAM.S240 IS '';
COMMENT ON COLUMN BARS.SPECPARAM.D020 IS '';
COMMENT ON COLUMN BARS.SPECPARAM.KEKD IS 'Символ дох';
COMMENT ON COLUMN BARS.SPECPARAM.KTK IS 'Код тек';
COMMENT ON COLUMN BARS.SPECPARAM.KVK IS 'КВК';
COMMENT ON COLUMN BARS.SPECPARAM.IDG IS 'Гр перекрытия';
COMMENT ON COLUMN BARS.SPECPARAM.IDS IS 'Схема перекр';
COMMENT ON COLUMN BARS.SPECPARAM.SPS IS 'Способ вычисления';
COMMENT ON COLUMN BARS.SPECPARAM.KBK IS '';
COMMENT ON COLUMN BARS.SPECPARAM.S120 IS '';
COMMENT ON COLUMN BARS.SPECPARAM.S130 IS 'Вид ЦП';
COMMENT ON COLUMN BARS.SPECPARAM.S250 IS '';
COMMENT ON COLUMN BARS.SPECPARAM.NKD IS 'Номер договору (ф.71)';
COMMENT ON COLUMN BARS.SPECPARAM.S031 IS 'Вид забезпечення кредиту (ф.71)';
COMMENT ON COLUMN BARS.SPECPARAM.S182 IS 'Вид кредиту (ф.71)';
COMMENT ON COLUMN BARS.SPECPARAM.ISTVAL IS 'Джерело вал.виручки';
COMMENT ON COLUMN BARS.SPECPARAM.R014 IS 'Признак дистанцiйного обслуг.рахунку';
COMMENT ON COLUMN BARS.SPECPARAM.K072 IS 'Код сектора экономики';
COMMENT ON COLUMN BARS.SPECPARAM.S090 IS 'Вид заборгованостi';
COMMENT ON COLUMN BARS.SPECPARAM.KF IS '';
COMMENT ON COLUMN BARS.SPECPARAM.S270 IS 'Код строку погашення основного боргу';
COMMENT ON COLUMN BARS.SPECPARAM.S260 IS 'Коди iндивiд.споживання за цiлями';
COMMENT ON COLUMN BARS.SPECPARAM.K150 IS '';
COMMENT ON COLUMN BARS.SPECPARAM.R114 IS 'Додатковий параметр для файлів В5, В6';
COMMENT ON COLUMN BARS.SPECPARAM.S280 IS '';
COMMENT ON COLUMN BARS.SPECPARAM.S290 IS '';
COMMENT ON COLUMN BARS.SPECPARAM.S370 IS '';
COMMENT ON COLUMN BARS.SPECPARAM.D1#F9 IS '';
COMMENT ON COLUMN BARS.SPECPARAM.NF#F9 IS '';
COMMENT ON COLUMN BARS.SPECPARAM.Z290 IS '';
COMMENT ON COLUMN BARS.SPECPARAM.DP1 IS '';
COMMENT ON COLUMN BARS.SPECPARAM.R012 IS '';
COMMENT ON COLUMN BARS.SPECPARAM.S580 IS '';
COMMENT ON COLUMN BARS.SPECPARAM.KVD IS '';
COMMENT ON COLUMN BARS.SPECPARAM.R016 IS '';




PROMPT *** Create  constraint CC_SPECPARAM_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPECPARAM MODIFY (KF CONSTRAINT CC_SPECPARAM_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SPECPARAM ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPECPARAM ADD CONSTRAINT PK_SPECPARAM PRIMARY KEY (ACC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SPECPARAM_ACC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPECPARAM MODIFY (ACC CONSTRAINT CC_SPECPARAM_ACC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SPECPARAM ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SPECPARAM ON BARS.SPECPARAM (ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_SPECPARAM_IDG ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_SPECPARAM_IDG ON BARS.SPECPARAM (IDG) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SPECPARAM ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SPECPARAM       to ABS_ADMIN;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on SPECPARAM       to BARS015;
grant SELECT                                                                 on SPECPARAM       to BARSREADER_ROLE;
grant SELECT                                                                 on SPECPARAM       to BARSUPL;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on SPECPARAM       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SPECPARAM       to BARS_DM;
grant INSERT,SELECT,UPDATE                                                   on SPECPARAM       to CUST001;
grant UPDATE                                                                 on SPECPARAM       to DEP_SKRN;
grant INSERT,SELECT,UPDATE                                                   on SPECPARAM       to RCC_DEAL;
grant SELECT                                                                 on SPECPARAM       to REF0000;
grant SELECT                                                                 on SPECPARAM       to RPBN001;
grant SELECT                                                                 on SPECPARAM       to RPBN002;
grant UPDATE                                                                 on SPECPARAM       to R_KP;
grant UPDATE                                                                 on SPECPARAM       to SALGL;
grant SELECT                                                                 on SPECPARAM       to START1;
grant SELECT                                                                 on SPECPARAM       to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SPECPARAM       to WR_ALL_RIGHTS;
grant UPDATE                                                                 on SPECPARAM       to WR_DEPOSIT_U;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SPECPARAM.sql =========*** End *** ===
PROMPT ===================================================================================== 
