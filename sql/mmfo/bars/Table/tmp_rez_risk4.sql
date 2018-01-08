

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_REZ_RISK4.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_REZ_RISK4 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMP_REZ_RISK4'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_REZ_RISK4'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_REZ_RISK4'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_REZ_RISK4 ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_REZ_RISK4 
   (	DAT DATE, 
	USERID NUMBER, 
	ACCS NUMBER, 
	ACCP NUMBER, 
	ND NUMBER, 
	SPALL NUMBER, 
	SK NUMBER, 
	SKALL NUMBER, 
	SP NUMBER, 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_REZ_RISK4 ***
 exec bpa.alter_policies('TMP_REZ_RISK4');


COMMENT ON TABLE BARS.TMP_REZ_RISK4 IS 'расшифровка премии в разрезе кредитных счетов';
COMMENT ON COLUMN BARS.TMP_REZ_RISK4.DAT IS 'дата расчета';
COMMENT ON COLUMN BARS.TMP_REZ_RISK4.USERID IS 'пользователь запустивший расчет (rez.rez_risk)';
COMMENT ON COLUMN BARS.TMP_REZ_RISK4.ACCS IS 'acc ссудный счет';
COMMENT ON COLUMN BARS.TMP_REZ_RISK4.ACCP IS 'acc счет примии';
COMMENT ON COLUMN BARS.TMP_REZ_RISK4.ND IS 'номер договора (из nd_acc)';
COMMENT ON COLUMN BARS.TMP_REZ_RISK4.SPALL IS 'вся примия на данный договор (ND)';
COMMENT ON COLUMN BARS.TMP_REZ_RISK4.SK IS 'эквивалент ссудного счета на расчетную дату с учетом корректирующих';
COMMENT ON COLUMN BARS.TMP_REZ_RISK4.SKALL IS 'эквивалент ссудных счетов по номеру договора на расчетную дату с учетом корректирующих';
COMMENT ON COLUMN BARS.TMP_REZ_RISK4.SP IS 'эквивалент дисконта с учетом корректирующих';
COMMENT ON COLUMN BARS.TMP_REZ_RISK4.BRANCH IS '';




PROMPT *** Create  constraint CC_REZ8_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_REZ_RISK4 MODIFY (BRANCH CONSTRAINT CC_REZ8_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TMP_REZ_RISK4 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TMP_REZ_RISK4 ON BARS.TMP_REZ_RISK4 (DAT, USERID, ACCS, ACCP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_REZ_RISK4 ***
grant SELECT                                                                 on TMP_REZ_RISK4   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_REZ_RISK4   to BARS_DM;
grant SELECT                                                                 on TMP_REZ_RISK4   to RCC_DEAL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_REZ_RISK4   to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to TMP_REZ_RISK4 ***

  CREATE OR REPLACE PUBLIC SYNONYM TMP_REZ_RISK4 FOR BARS.TMP_REZ_RISK4;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_REZ_RISK4.sql =========*** End ***
PROMPT ===================================================================================== 
