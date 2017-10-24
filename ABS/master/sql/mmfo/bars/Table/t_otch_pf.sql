

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/T_OTCH_PF.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to T_OTCH_PF ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''T_OTCH_PF'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''T_OTCH_PF'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''T_OTCH_PF'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table T_OTCH_PF ***
begin 
  execute immediate '
  CREATE TABLE BARS.T_OTCH_PF 
   (	ID NUMBER(*,0), 
	ACC NUMBER(38,0), 
	NLS VARCHAR2(15), 
	KV NUMBER(38,0), 
	NMK VARCHAR2(70), 
	OKPO VARCHAR2(14), 
	DAT_OST DATE, 
	DAT_REG_D DATE, 
	DAT_END_D DATE, 
	ADR VARCHAR2(70), 
	BRANCH VARCHAR2(30), 
	DAT_1 DATE, 
	DAT_2 DATE, 
	DPT_ID NUMBER(38,0), 
	RNK NUMBER(38,0), 
	OB22 CHAR(2)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to T_OTCH_PF ***
 exec bpa.alter_policies('T_OTCH_PF');


COMMENT ON TABLE BARS.T_OTCH_PF IS 'Таблица для фрормирования отчета "Счета, по которым НЕ получают или получают пенсию ТОЛЬКО по доверенности с текущих счетов в банке';
COMMENT ON COLUMN BARS.T_OTCH_PF.ID IS '';
COMMENT ON COLUMN BARS.T_OTCH_PF.ACC IS 'Внутренний номер счета';
COMMENT ON COLUMN BARS.T_OTCH_PF.NLS IS 'Номер лицевого счета (внешний)';
COMMENT ON COLUMN BARS.T_OTCH_PF.KV IS 'Код валюты';
COMMENT ON COLUMN BARS.T_OTCH_PF.NMK IS 'Наименованиет клиента';
COMMENT ON COLUMN BARS.T_OTCH_PF.OKPO IS 'Номер ОКПО';
COMMENT ON COLUMN BARS.T_OTCH_PF.DAT_OST IS 'Дата Дт.оборотов';
COMMENT ON COLUMN BARS.T_OTCH_PF.DAT_REG_D IS 'Дата реггистрации доверенности';
COMMENT ON COLUMN BARS.T_OTCH_PF.DAT_END_D IS 'Дата окорчания действия доверености';
COMMENT ON COLUMN BARS.T_OTCH_PF.ADR IS 'Адрес клиента';
COMMENT ON COLUMN BARS.T_OTCH_PF.BRANCH IS 'Код безбалансового отделения';
COMMENT ON COLUMN BARS.T_OTCH_PF.DAT_1 IS 'Дата 1';
COMMENT ON COLUMN BARS.T_OTCH_PF.DAT_2 IS 'Дата 1';
COMMENT ON COLUMN BARS.T_OTCH_PF.DPT_ID IS 'Номер вклада';
COMMENT ON COLUMN BARS.T_OTCH_PF.RNK IS 'RNK клиента';
COMMENT ON COLUMN BARS.T_OTCH_PF.OB22 IS 'OB22 вкладного рах. для полілу по типам пенсіонерів';



PROMPT *** Create  grants  T_OTCH_PF ***
grant SELECT                                                                 on T_OTCH_PF       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on T_OTCH_PF       to BARS_DM;
grant SELECT                                                                 on T_OTCH_PF       to RPBN001;
grant SELECT                                                                 on T_OTCH_PF       to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on T_OTCH_PF       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/T_OTCH_PF.sql =========*** End *** ===
PROMPT ===================================================================================== 
