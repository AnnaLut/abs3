

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PAY_ALT.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PAY_ALT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PAY_ALT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''PAY_ALT'', ''FILIAL'' , ''B'', ''B'', ''B'', ''B'');
               bpa.alter_policy_info(''PAY_ALT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PAY_ALT ***
begin 
  execute immediate '
  CREATE TABLE BARS.PAY_ALT 
   (	ID NUMBER(38,0), 
	ISP NUMBER(38,0), 
	ND VARCHAR2(10), 
	S NUMBER(24,2), 
	DOPR VARCHAR2(8), 
	NMSA VARCHAR2(38), 
	NLSA VARCHAR2(14), 
	NLSA_ALT VARCHAR2(14), 
	NMSB VARCHAR2(38), 
	NLSB VARCHAR2(14), 
	NLSB_ALT VARCHAR2(14), 
	NAZN VARCHAR2(160), 
	S2 NUMBER(24,2), 
	SOS NUMBER(*,0), 
	DATD DATE, 
	SK_ZB NUMBER(*,0), 
	NLS6 VARCHAR2(14), 
	IR NUMBER, 
	CEP_ACC VARCHAR2(1000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PAY_ALT ***
 exec bpa.alter_policies('PAY_ALT');


COMMENT ON TABLE BARS.PAY_ALT IS 'Для ввода док по АЛТ-счетам KV=980';
COMMENT ON COLUMN BARS.PAY_ALT.ID IS '№ пп';
COMMENT ON COLUMN BARS.PAY_ALT.ISP IS '№ вик';
COMMENT ON COLUMN BARS.PAY_ALT.ND IS 'Номер документа';
COMMENT ON COLUMN BARS.PAY_ALT.S IS 'Сумма';
COMMENT ON COLUMN BARS.PAY_ALT.DOPR IS 'Доп. реквизиты';
COMMENT ON COLUMN BARS.PAY_ALT.NMSA IS 'Наименование отправителя';
COMMENT ON COLUMN BARS.PAY_ALT.NLSA IS 'Счет отправителя';
COMMENT ON COLUMN BARS.PAY_ALT.NLSA_ALT IS 'Alt-Счет отправителя';
COMMENT ON COLUMN BARS.PAY_ALT.NMSB IS 'Наименование получателя';
COMMENT ON COLUMN BARS.PAY_ALT.NLSB IS 'Счет получателя';
COMMENT ON COLUMN BARS.PAY_ALT.NLSB_ALT IS 'Alt-Счет получателя';
COMMENT ON COLUMN BARS.PAY_ALT.NAZN IS 'Назначение платежа';
COMMENT ON COLUMN BARS.PAY_ALT.S2 IS 'Сумма доч.оп';
COMMENT ON COLUMN BARS.PAY_ALT.SOS IS 'Отметка об опл.';
COMMENT ON COLUMN BARS.PAY_ALT.DATD IS 'Дата документа';
COMMENT ON COLUMN BARS.PAY_ALT.SK_ZB IS 'Позаб.символ';
COMMENT ON COLUMN BARS.PAY_ALT.NLS6 IS 'Рах.~комiсiї';
COMMENT ON COLUMN BARS.PAY_ALT.IR IS '%~комiсiї';
COMMENT ON COLUMN BARS.PAY_ALT.CEP_ACC IS '';




PROMPT *** Create  constraint PK_PAYALT ***
begin   
 execute immediate '
  ALTER TABLE BARS.PAY_ALT ADD CONSTRAINT PK_PAYALT PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PAYALT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_PAYALT ON BARS.PAY_ALT (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PAY_ALT ***
grant SELECT                                                                 on PAY_ALT         to BARSREADER_ROLE;
grant SELECT                                                                 on PAY_ALT         to BARS_DM;
grant SELECT                                                                 on PAY_ALT         to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on PAY_ALT         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PAY_ALT.sql =========*** End *** =====
PROMPT ===================================================================================== 
