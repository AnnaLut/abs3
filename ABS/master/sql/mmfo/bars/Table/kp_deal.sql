

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KP_DEAL.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KP_DEAL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KP_DEAL'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KP_DEAL'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KP_DEAL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KP_DEAL ***
begin 
  execute immediate '
  CREATE TABLE BARS.KP_DEAL 
   (	ND NUMBER(*,0), 
	ACC NUMBER(*,0), 
	MFOB VARCHAR2(12), 
	NLSB VARCHAR2(15), 
	OKPOB VARCHAR2(14), 
	NMSB VARCHAR2(38), 
	NAK NUMBER(*,0), 
	SK NUMBER(*,0), 
	NAZN VARCHAR2(160), 
	TT CHAR(3), 
	KODZ1 NUMBER(*,0), 
	KODZ2 NUMBER(*,0), 
	KODZ3 NUMBER(*,0), 
	ACC6F NUMBER(*,0), 
	ACC6U NUMBER(*,0), 
	ACC3U NUMBER(*,0), 
	VOB NUMBER, 
	GRP NUMBER, 
	KOMU_VAL NUMBER, 
	KOMU_FLAG NUMBER(*,0) DEFAULT 0, 
	NAME VARCHAR2(160), 
	SUM NUMBER DEFAULT 0
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KP_DEAL ***
 exec bpa.alter_policies('KP_DEAL');


COMMENT ON TABLE BARS.KP_DEAL IS 'Договора на сбор комун.платежей';
COMMENT ON COLUMN BARS.KP_DEAL.ND IS 'Реф дог';
COMMENT ON COLUMN BARS.KP_DEAL.ACC IS '';
COMMENT ON COLUMN BARS.KP_DEAL.MFOB IS 'МФО-Б';
COMMENT ON COLUMN BARS.KP_DEAL.NLSB IS 'Счет-Б';
COMMENT ON COLUMN BARS.KP_DEAL.OKPOB IS 'ОКПО-Б';
COMMENT ON COLUMN BARS.KP_DEAL.NMSB IS 'Наим-Б';
COMMENT ON COLUMN BARS.KP_DEAL.NAK IS '';
COMMENT ON COLUMN BARS.KP_DEAL.SK IS 'СКП';
COMMENT ON COLUMN BARS.KP_DEAL.NAZN IS 'Назначение пл.';
COMMENT ON COLUMN BARS.KP_DEAL.TT IS 'Шаблон экрана ввода (Наимен.оп)';
COMMENT ON COLUMN BARS.KP_DEAL.KODZ1 IS 'Отчет-Этикетка.TXT(№ кат.запроса)';
COMMENT ON COLUMN BARS.KP_DEAL.KODZ2 IS 'Отчет-реестр.TXT(№ кат.запроса)';
COMMENT ON COLUMN BARS.KP_DEAL.KODZ3 IS 'Отчет-реестр.DBF(№ кат.запроса)';
COMMENT ON COLUMN BARS.KP_DEAL.ACC6F IS 'Сч дох от ФЛ';
COMMENT ON COLUMN BARS.KP_DEAL.ACC6U IS 'Сч дох от ЮЛ';
COMMENT ON COLUMN BARS.KP_DEAL.ACC3U IS 'Сч нар.дох от ЮЛ';
COMMENT ON COLUMN BARS.KP_DEAL.VOB IS '';
COMMENT ON COLUMN BARS.KP_DEAL.GRP IS '1=Накопит.платежи на сч.29, 0-одиночки';
COMMENT ON COLUMN BARS.KP_DEAL.KOMU_VAL IS 'Значение комиссии юр. лица';
COMMENT ON COLUMN BARS.KP_DEAL.KOMU_FLAG IS 'Комиссия юр. лиц. 0-%,1-Сумма,2-Сетка';
COMMENT ON COLUMN BARS.KP_DEAL.NAME IS 'Название ген. соглашения';
COMMENT ON COLUMN BARS.KP_DEAL.SUM IS 'Фиксированная сумма';




PROMPT *** Create  constraint XPK_KP_DEAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.KP_DEAL ADD CONSTRAINT XPK_KP_DEAL PRIMARY KEY (ND)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_KP_DEAL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_KP_DEAL ON BARS.KP_DEAL (ND) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KP_DEAL ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KP_DEAL         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KP_DEAL         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on KP_DEAL         to R_KP;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KP_DEAL         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KP_DEAL.sql =========*** End *** =====
PROMPT ===================================================================================== 
