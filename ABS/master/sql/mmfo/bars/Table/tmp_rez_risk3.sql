

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_REZ_RISK3.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_REZ_RISK3 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMP_REZ_RISK3'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_REZ_RISK3'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_REZ_RISK3'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_REZ_RISK3 ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_REZ_RISK3 
   (	DAT DATE, 
	USERID NUMBER, 
	ACCS NUMBER, 
	ACCD NUMBER, 
	ND NUMBER, 
	SDALL NUMBER, 
	SK NUMBER, 
	SKALL NUMBER, 
	SD NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_REZ_RISK3 ***
 exec bpa.alter_policies('TMP_REZ_RISK3');


COMMENT ON TABLE BARS.TMP_REZ_RISK3 IS 'расшифровка дисконта в разрезе кредитных счетов';
COMMENT ON COLUMN BARS.TMP_REZ_RISK3.DAT IS 'дата расчета';
COMMENT ON COLUMN BARS.TMP_REZ_RISK3.USERID IS 'пользователь запустивший расчет (rez.rez_risk)';
COMMENT ON COLUMN BARS.TMP_REZ_RISK3.ACCS IS 'acc ссудный счет';
COMMENT ON COLUMN BARS.TMP_REZ_RISK3.ACCD IS 'acc счет дисконта';
COMMENT ON COLUMN BARS.TMP_REZ_RISK3.ND IS 'номер договора (из nd_acc)';
COMMENT ON COLUMN BARS.TMP_REZ_RISK3.SDALL IS 'весь дисконт на данный договор (ND)';
COMMENT ON COLUMN BARS.TMP_REZ_RISK3.SK IS 'эквивалент ссудного счета на расчетную дату с учетом корректирующих';
COMMENT ON COLUMN BARS.TMP_REZ_RISK3.SKALL IS 'эквивалент ссудных счетов по номеру договора на расчетную дату с учетом корректирующих';
COMMENT ON COLUMN BARS.TMP_REZ_RISK3.SD IS 'эквивалент дисконта с учетом корректирующих';




PROMPT *** Create  constraint PK_TMP_REZ_RISK3 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_REZ_RISK3 ADD CONSTRAINT PK_TMP_REZ_RISK3 PRIMARY KEY (DAT, USERID, ACCS, ACCD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TMP_REZ_RISK3 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TMP_REZ_RISK3 ON BARS.TMP_REZ_RISK3 (DAT, USERID, ACCS, ACCD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_REZ_RISK3 ***
grant SELECT                                                                 on TMP_REZ_RISK3   to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_REZ_RISK3   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_REZ_RISK3   to RCC_DEAL;
grant SELECT                                                                 on TMP_REZ_RISK3   to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_REZ_RISK3   to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to TMP_REZ_RISK3 ***

  CREATE OR REPLACE PUBLIC SYNONYM TMP_REZ_RISK3 FOR BARS.TMP_REZ_RISK3;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_REZ_RISK3.sql =========*** End ***
PROMPT ===================================================================================== 
