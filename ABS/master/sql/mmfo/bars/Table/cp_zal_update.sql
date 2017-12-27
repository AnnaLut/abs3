

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CP_ZAL_UPDATE.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CP_ZAL_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_ZAL_UPDATE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CP_ZAL_UPDATE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CP_ZAL_UPDATE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/
 
PROMPT *** Create  table CP_ZAL_UPDATE ***

begin 
  execute immediate '
  CREATE TABLE BARS.CP_ZAL_UPDATE 
   (	IDUPD NUMBER(38,0), 
	CHGACTION CHAR(1), 
	EFFECTDATE DATE, 
	CHGDATE DATE, 
	DONEBY NUMBER(38,0),
        REF NUMBER, 
	ID NUMBER, 
	KOLZ NUMBER, 
	DATZ_FROM DATE,
        id_cp_zal number,
        rnk number,
	DATZ_TO DATE
   ) TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

PROMPT *** Alter table CP_ZAL_UPDATE ***

PROMPT *** ALTER_POLICIES to CP_ZAL_UPDATE ***
 exec bpa.alter_policies('CP_ZAL_UPDATE');

COMMENT ON TABLE  BARS.CP_ZAL_UPDATE IS '';
COMMENT ON COLUMN BARS.CP_ZAL_UPDATE.REF IS 'Реф-с угоди куп_вл_ пакета';
COMMENT ON COLUMN BARS.CP_ZAL_UPDATE.ID IS 'Код ЦП (ID)';
COMMENT ON COLUMN BARS.CP_ZAL_UPDATE.KOLZ IS 'К_льк_сть в застав_ (пакет або доля пакета )';
COMMENT ON COLUMN BARS.CP_ZAL_UPDATE.DATZ_FROM IS 'Дата з якої включення в заставу';
COMMENT ON COLUMN BARS.CP_ZAL_UPDATE.DATZ_FROM IS 'Дата по яку включення в заставу';
COMMENT ON COLUMN BARS.CP_ZAL_UPDATE.ID_CP_ZAL is 'Код CP_ZAL';
COMMENT ON COLUMN BARS.CP_ZAL_UPDATE.RNK       is 'Код Контрагента';

COMMENT ON COLUMN BARS.CP_ZAL_UPDATE.IDUPD IS 'Первичный ключ для таблицы обновления';
COMMENT ON COLUMN BARS.CP_ZAL_UPDATE.CHGACTION IS 'Код обновления (I/U/D)';
COMMENT ON COLUMN BARS.CP_ZAL_UPDATE.EFFECTDATE IS 'Банковская дата начала действия параметров';
COMMENT ON COLUMN BARS.CP_ZAL_UPDATE.CHGDATE IS 'Системаная дата обновления';
COMMENT ON COLUMN BARS.CP_ZAL_UPDATE.DONEBY IS 'Код пользователя. кто внес обновления(если в течении дня было несколько обновлений - остается только последнее)';



PROMPT *** Create  index Unique ***
begin   
 execute immediate 'create UNIQUE index IND_U_CP_ZAL_UPDATE on CP_ZAL_UPDATE (IDUPD) tablespace BRSMDLI';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/


begin   
 execute immediate 'create index IND1_CP_ZAL_UPDATE on CP_ZAL_UPDATE (ref, rnk) tablespace BRSMDLI';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

begin   
 execute immediate 'create index IND2_CP_ZAL_UPDATE on CP_ZAL_UPDATE (id_CP_ZAL) tablespace BRSMDLI';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

begin   
 execute immediate 'create index IND3_CP_ZAL_UPDATE on CP_ZAL_UPDATE (EFFECTDATE) tablespace BRSMDLI';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



begin   
 execute immediate '
  ALTER TABLE BARS.CP_ZAL_UPDATE MODIFY (IDUPD CONSTRAINT CC_CP_ZAL_UPD_IDUPD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

begin   
 execute immediate '
  ALTER TABLE BARS.CP_ZAL_UPDATE MODIFY (CHGACTION CONSTRAINT CC_CP_ZAL_UPD_CHGACTION_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

begin   
 execute immediate '
  ALTER TABLE BARS.CP_ZAL_UPDATE MODIFY (CHGDATE CONSTRAINT CC_CP_ZAL_UPD_CHGDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

begin   
 execute immediate '
  ALTER TABLE BARS.CP_ZAL_UPDATE MODIFY (EFFECTDATE CONSTRAINT CC_CP_ZAL_UPD_EFFECTDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  constraint CC_CUSTADDRUPD_DONEBY_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_ZAL_UPDATE MODIFY (DONEBY CONSTRAINT CC_CP_ZAL_UPD_DONEBY_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  grants  CP_ZAL_UPDATE ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_ZAL_UPDATE          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CP_ZAL_UPDATE          to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_ZAL_UPDATE          to CP_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_ZAL_UPDATE          to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CP_ZAL_UPDATE.sql =========*** End *** ======
PROMPT ===================================================================================== 
