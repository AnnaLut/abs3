

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_DELOIT_REZ.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_DELOIT_REZ ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_DELOIT_REZ ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_DELOIT_REZ 
   (	DAT DATE, 
	USERID NUMBER, 
	ACCS NUMBER, 
	ACCZ NUMBER, 
	PAWN NUMBER, 
	S NUMBER, 
	SPRIV NUMBER, 
	PROC NUMBER, 
	SALL NUMBER, 
	ND NUMBER, 
	KV NUMBER(3,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_DELOIT_REZ ***
 exec bpa.alter_policies('TMP_DELOIT_REZ');


COMMENT ON TABLE BARS.TMP_DELOIT_REZ IS 'расшифровка обеспечения в разрезе кредитных договоров';
COMMENT ON COLUMN BARS.TMP_DELOIT_REZ.DAT IS 'дата расчета';
COMMENT ON COLUMN BARS.TMP_DELOIT_REZ.USERID IS 'пользователь запустивший расчет (rez.rez_risk)';
COMMENT ON COLUMN BARS.TMP_DELOIT_REZ.ACCS IS 'acc один из ссудніх счето';
COMMENT ON COLUMN BARS.TMP_DELOIT_REZ.ACCZ IS 'acc счет залога';
COMMENT ON COLUMN BARS.TMP_DELOIT_REZ.PAWN IS 'вид залога';
COMMENT ON COLUMN BARS.TMP_DELOIT_REZ.S IS 'сумма обеспечения ';
COMMENT ON COLUMN BARS.TMP_DELOIT_REZ.SPRIV IS 'Порядковий номер КД (перв, второй ...)';
COMMENT ON COLUMN BARS.TMP_DELOIT_REZ.PROC IS 'кількість КД ';
COMMENT ON COLUMN BARS.TMP_DELOIT_REZ.SALL IS '';
COMMENT ON COLUMN BARS.TMP_DELOIT_REZ.ND IS '';
COMMENT ON COLUMN BARS.TMP_DELOIT_REZ.KV IS '';




PROMPT *** Create  constraint PK_TMP_DELOIT_REZ ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_DELOIT_REZ ADD CONSTRAINT PK_TMP_DELOIT_REZ PRIMARY KEY (DAT, ND, ACCZ)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TMP_DELOIT_REZ ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TMP_DELOIT_REZ ON BARS.TMP_DELOIT_REZ (DAT, ND, ACCZ) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_DELOIT_REZ ***
grant SELECT                                                                 on TMP_DELOIT_REZ  to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_DELOIT_REZ  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_DELOIT_REZ.sql =========*** End **
PROMPT ===================================================================================== 
