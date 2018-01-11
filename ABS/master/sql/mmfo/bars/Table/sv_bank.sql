

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SV_BANK.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SV_BANK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SV_BANK'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SV_BANK'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SV_BANK'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SV_BANK ***
begin 
  execute immediate '
  CREATE TABLE BARS.SV_BANK 
   (	ID NUMBER(1,0), 
	VIDSOTOK NUMBER(7,4), 
	GOLOS NUMBER(16,0), 
	MAN_FIO_NM1 VARCHAR2(100), 
	MAN_FIO_NM2 VARCHAR2(50), 
	MAN_FIO_NM3 VARCHAR2(50), 
	MAN_MB_POS VARCHAR2(100), 
	MAN_MB_DT DATE, 
	ISP_FIO_NM1 VARCHAR2(100), 
	ISP_FIO_NM2 VARCHAR2(50), 
	ISP_FIO_NM3 VARCHAR2(50), 
	ISP_MB_TLF VARCHAR2(50)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SV_BANK ***
 exec bpa.alter_policies('SV_BANK');


COMMENT ON TABLE BARS.SV_BANK IS 'Керівник та виконавець';
COMMENT ON COLUMN BARS.SV_BANK.ID IS 'Id=1 - в таблице одна запись';
COMMENT ON COLUMN BARS.SV_BANK.VIDSOTOK IS 'Відсотки статутного капіталу банку';
COMMENT ON COLUMN BARS.SV_BANK.GOLOS IS 'Кількість голосів';
COMMENT ON COLUMN BARS.SV_BANK.MAN_FIO_NM1 IS 'Прізвище керівника, що підписав анкету';
COMMENT ON COLUMN BARS.SV_BANK.MAN_FIO_NM2 IS 'Ім’я керівника, що підписав анкету';
COMMENT ON COLUMN BARS.SV_BANK.MAN_FIO_NM3 IS 'По батькові керівника, що підписав анкету';
COMMENT ON COLUMN BARS.SV_BANK.MAN_MB_POS IS 'Посада керівника, що підписав анкету';
COMMENT ON COLUMN BARS.SV_BANK.MAN_MB_DT IS 'Дата підпису';
COMMENT ON COLUMN BARS.SV_BANK.ISP_FIO_NM1 IS 'Прізвище виконавця';
COMMENT ON COLUMN BARS.SV_BANK.ISP_FIO_NM2 IS 'Ім’я виконавця';
COMMENT ON COLUMN BARS.SV_BANK.ISP_FIO_NM3 IS 'По батькові виконавця';
COMMENT ON COLUMN BARS.SV_BANK.ISP_MB_TLF IS 'Номер контактного телефону';




PROMPT *** Create  constraint CC_SVBANK_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SV_BANK MODIFY (ID CONSTRAINT CC_SVBANK_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SVBANK_MANFIONM1_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SV_BANK MODIFY (MAN_FIO_NM1 CONSTRAINT CC_SVBANK_MANFIONM1_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SVBANK_MANFIONM2_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SV_BANK MODIFY (MAN_FIO_NM2 CONSTRAINT CC_SVBANK_MANFIONM2_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SVBANK_MANFIONM3_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SV_BANK MODIFY (MAN_FIO_NM3 CONSTRAINT CC_SVBANK_MANFIONM3_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SVBANK_MANMBPOS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SV_BANK MODIFY (MAN_MB_POS CONSTRAINT CC_SVBANK_MANMBPOS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SVBANK_MANMBDT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SV_BANK MODIFY (MAN_MB_DT CONSTRAINT CC_SVBANK_MANMBDT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SVBANK_ISPFIONM1_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SV_BANK MODIFY (ISP_FIO_NM1 CONSTRAINT CC_SVBANK_ISPFIONM1_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SVBANK_ISPFIONM2_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SV_BANK MODIFY (ISP_FIO_NM2 CONSTRAINT CC_SVBANK_ISPFIONM2_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SVBANK_ISPFIONM3_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SV_BANK MODIFY (ISP_FIO_NM3 CONSTRAINT CC_SVBANK_ISPFIONM3_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SVBANK_ISPMBTLF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SV_BANK MODIFY (ISP_MB_TLF CONSTRAINT CC_SVBANK_ISPMBTLF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SV_BANK ***
grant SELECT                                                                 on SV_BANK         to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SV_BANK         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SV_BANK         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on SV_BANK         to RPBN002;
grant SELECT                                                                 on SV_BANK         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SV_BANK.sql =========*** End *** =====
PROMPT ===================================================================================== 
