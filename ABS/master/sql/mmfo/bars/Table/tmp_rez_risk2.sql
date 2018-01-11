

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_REZ_RISK2.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_REZ_RISK2 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMP_REZ_RISK2'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_REZ_RISK2'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_REZ_RISK2'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_REZ_RISK2 ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_REZ_RISK2 
   (	DAT DATE, 
	USERID NUMBER, 
	ACCS NUMBER, 
	ACCZ NUMBER, 
	PAWN NUMBER, 
	S NUMBER, 
	SPRIV NUMBER, 
	PROC NUMBER, 
	SALL NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_REZ_RISK2 ***
 exec bpa.alter_policies('TMP_REZ_RISK2');


COMMENT ON TABLE BARS.TMP_REZ_RISK2 IS 'расшифровка обеспечения в разрезе кредитных счетов';
COMMENT ON COLUMN BARS.TMP_REZ_RISK2.DAT IS 'дата расчета';
COMMENT ON COLUMN BARS.TMP_REZ_RISK2.USERID IS 'пользователь запустивший расчет (rez.rez_risk)';
COMMENT ON COLUMN BARS.TMP_REZ_RISK2.ACCS IS 'acc ссудный счет';
COMMENT ON COLUMN BARS.TMP_REZ_RISK2.ACCZ IS 'acc счет залога';
COMMENT ON COLUMN BARS.TMP_REZ_RISK2.PAWN IS 'вид залога';
COMMENT ON COLUMN BARS.TMP_REZ_RISK2.S IS 'сумма обеспечения на кредит (вся)';
COMMENT ON COLUMN BARS.TMP_REZ_RISK2.SPRIV IS 'сумма приведенного обеспечения на кредит (общая сумма не превышает риск)';
COMMENT ON COLUMN BARS.TMP_REZ_RISK2.PROC IS 'процент от обеспечения для данных кредита и залога';
COMMENT ON COLUMN BARS.TMP_REZ_RISK2.SALL IS '';




PROMPT *** Create  constraint PK_TMP_REZ_RISK2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_REZ_RISK2 ADD CONSTRAINT PK_TMP_REZ_RISK2 PRIMARY KEY (DAT, USERID, ACCS, ACCZ)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TMP_REZ_RISK2 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TMP_REZ_RISK2 ON BARS.TMP_REZ_RISK2 (DAT, USERID, ACCS, ACCZ) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_REZ_RISK2 ***
grant SELECT                                                                 on TMP_REZ_RISK2   to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_REZ_RISK2   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_REZ_RISK2   to BARS_DM;
grant SELECT                                                                 on TMP_REZ_RISK2   to RCC_DEAL;
grant SELECT                                                                 on TMP_REZ_RISK2   to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_REZ_RISK2   to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to TMP_REZ_RISK2 ***

  CREATE OR REPLACE PUBLIC SYNONYM TMP_REZ_RISK2 FOR BARS.TMP_REZ_RISK2;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_REZ_RISK2.sql =========*** End ***
PROMPT ===================================================================================== 
