

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BANKS_UPDATE.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BANKS_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BANKS_UPDATE'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''BANKS_UPDATE'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''BANKS_UPDATE'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BANKS_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.BANKS_UPDATE 
   (	HEADER NUMBER(38,0), 
	ORD NUMBER(10,0), 
	OP CHAR(1), 
	MFO VARCHAR2(12), 
	NB VARCHAR2(38), 
	NBW VARCHAR2(38), 
	NLS VARCHAR2(14), 
	SAB CHAR(4), 
	SABP CHAR(4), 
	MODEL CHAR(1), 
	MODEL_NO CHAR(1), 
	MFOP VARCHAR2(9), 
	KV CHAR(3), 
	GATE CHAR(1), 
	BLK CHAR(1), 
	ARM2 CHAR(1), 
	MFOU VARCHAR2(12), 
	RESERVED CHAR(32), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 0 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BANKS_UPDATE ***
 exec bpa.alter_policies('BANKS_UPDATE');


COMMENT ON TABLE BARS.BANKS_UPDATE IS 'Детальные строки содержания файлов обновления участников СЭП';
COMMENT ON COLUMN BARS.BANKS_UPDATE.HEADER IS 'Таблица и строки используются при работе в СЭП НБУ';
COMMENT ON COLUMN BARS.BANKS_UPDATE.ORD IS 'Таблица и строки используются при работе в СЭП НБУ';
COMMENT ON COLUMN BARS.BANKS_UPDATE.OP IS 'Таблица и строки используются при работе в СЭП НБУ';
COMMENT ON COLUMN BARS.BANKS_UPDATE.MFO IS 'Таблица и строки используются при работе в СЭП НБУ';
COMMENT ON COLUMN BARS.BANKS_UPDATE.NB IS 'Таблица и строки используются при работе в СЭП НБУ';
COMMENT ON COLUMN BARS.BANKS_UPDATE.NBW IS 'Таблица и строки используются при работе в СЭП НБУ';
COMMENT ON COLUMN BARS.BANKS_UPDATE.NLS IS 'Таблица и строки используются при работе в СЭП НБУ';
COMMENT ON COLUMN BARS.BANKS_UPDATE.SAB IS 'Таблица и строки используются при работе в СЭП НБУ';
COMMENT ON COLUMN BARS.BANKS_UPDATE.SABP IS 'Таблица и строки используются при работе в СЭП НБУ';
COMMENT ON COLUMN BARS.BANKS_UPDATE.MODEL IS 'Таблица и строки используются при работе в СЭП НБУ';
COMMENT ON COLUMN BARS.BANKS_UPDATE.MODEL_NO IS 'Таблица и строки используются при работе в СЭП НБУ';
COMMENT ON COLUMN BARS.BANKS_UPDATE.MFOP IS 'Таблица и строки используются при работе в СЭП НБУ';
COMMENT ON COLUMN BARS.BANKS_UPDATE.KV IS 'Таблица и строки используются при работе в СЭП НБУ';
COMMENT ON COLUMN BARS.BANKS_UPDATE.GATE IS 'Таблица и строки используются при работе в СЭП НБУ';
COMMENT ON COLUMN BARS.BANKS_UPDATE.BLK IS 'Таблица и строки используются при работе в СЭП НБУ';
COMMENT ON COLUMN BARS.BANKS_UPDATE.ARM2 IS 'Таблица и строки используются при работе в СЭП НБУ';
COMMENT ON COLUMN BARS.BANKS_UPDATE.MFOU IS 'Таблица и строки используются при работе в СЭП НБУ';
COMMENT ON COLUMN BARS.BANKS_UPDATE.RESERVED IS 'Таблица и строки используются при работе в СЭП НБУ';
COMMENT ON COLUMN BARS.BANKS_UPDATE.KF IS '';




PROMPT *** Create  constraint PK_BANKSUPD ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANKS_UPDATE ADD CONSTRAINT PK_BANKSUPD PRIMARY KEY (HEADER, ORD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BANKSUPD_HEADER_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANKS_UPDATE MODIFY (HEADER CONSTRAINT CC_BANKSUPD_HEADER_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BANKSUPD_ORD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANKS_UPDATE MODIFY (ORD CONSTRAINT CC_BANKSUPD_ORD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BANKSUPD_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANKS_UPDATE MODIFY (KF CONSTRAINT CC_BANKSUPD_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BANKSUPD ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BANKSUPD ON BARS.BANKS_UPDATE (HEADER, ORD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BANKS_UPDATE ***
grant DELETE,INSERT,SELECT,UPDATE                                            on BANKS_UPDATE    to ABS_ADMIN;
grant SELECT                                                                 on BANKS_UPDATE    to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on BANKS_UPDATE    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BANKS_UPDATE    to BARS_DM;
grant SELECT                                                                 on BANKS_UPDATE    to START1;
grant INSERT                                                                 on BANKS_UPDATE    to TECH020;
grant DELETE,INSERT,SELECT,UPDATE                                            on BANKS_UPDATE    to TOSS;
grant SELECT                                                                 on BANKS_UPDATE    to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BANKS_UPDATE    to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BANKS_UPDATE.sql =========*** End *** 
PROMPT ===================================================================================== 
