

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_FILE03.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_FILE03 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_FILE03 ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_FILE03 
   (	ACCD NUMBER, 
	TT VARCHAR2(3), 
	REF NUMBER, 
	KV NUMBER, 
	NLSD VARCHAR2(15), 
	S NUMBER, 
	SQ NUMBER, 
	FDAT DATE, 
	NAZN VARCHAR2(160), 
	ACCK NUMBER, 
	NLSK VARCHAR2(15), 
	ISP NUMBER
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_FILE03 ***
 exec bpa.alter_policies('TMP_FILE03');


COMMENT ON TABLE BARS.TMP_FILE03 IS 'Временная таблица для проводок файла отчетности #03';
COMMENT ON COLUMN BARS.TMP_FILE03.ACCD IS 'Идентификатор Кт счета';
COMMENT ON COLUMN BARS.TMP_FILE03.TT IS 'Код операции';
COMMENT ON COLUMN BARS.TMP_FILE03.REF IS 'Референс док-та';
COMMENT ON COLUMN BARS.TMP_FILE03.KV IS 'Код валюты';
COMMENT ON COLUMN BARS.TMP_FILE03.NLSD IS 'Дт счета';
COMMENT ON COLUMN BARS.TMP_FILE03.S IS 'Сумма проводки';
COMMENT ON COLUMN BARS.TMP_FILE03.SQ IS 'Сумма экв. проводки';
COMMENT ON COLUMN BARS.TMP_FILE03.FDAT IS 'Дата проводки';
COMMENT ON COLUMN BARS.TMP_FILE03.NAZN IS 'Назначение платежа';
COMMENT ON COLUMN BARS.TMP_FILE03.ACCK IS '';
COMMENT ON COLUMN BARS.TMP_FILE03.NLSK IS 'Кт счета';
COMMENT ON COLUMN BARS.TMP_FILE03.ISP IS 'Код пользователя';




PROMPT *** Create  index I1_TMP_FILE03 ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_TMP_FILE03 ON BARS.TMP_FILE03 (FDAT, ACCD, NLSK) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I2_TMP_FILE03 ***
begin   
 execute immediate '
  CREATE INDEX BARS.I2_TMP_FILE03 ON BARS.TMP_FILE03 (FDAT, ACCK, NLSD) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I3_TMP_FILE03 ***
begin   
 execute immediate '
  CREATE INDEX BARS.I3_TMP_FILE03 ON BARS.TMP_FILE03 (REF) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I4_TMP_FILE03 ***
begin   
 execute immediate '
  CREATE INDEX BARS.I4_TMP_FILE03 ON BARS.TMP_FILE03 (NLSD, NLSK) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I5_TMP_FILE03 ***
begin   
 execute immediate '
  CREATE INDEX BARS.I5_TMP_FILE03 ON BARS.TMP_FILE03 (NLSK) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_FILE03 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_FILE03      to ABS_ADMIN;
grant SELECT                                                                 on TMP_FILE03      to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_FILE03      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_FILE03      to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_FILE03      to RPBN002;
grant SELECT                                                                 on TMP_FILE03      to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_FILE03      to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_FILE03.sql =========*** End *** ==
PROMPT ===================================================================================== 
