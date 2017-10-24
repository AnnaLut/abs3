

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_FILEA7.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_FILEA7 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_FILEA7 ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_FILEA7 
   (	Z_DATE DATE, 
	N_SYSTEM NUMBER, 
	NLS VARCHAR2(15), 
	KV NUMBER, 
	OST NUMBER, 
	NLS_K VARCHAR2(15), 
	SDATE DATE, 
	EDATE DATE, 
	COUNTRY NUMBER, 
	R013 VARCHAR2(1), 
	MIN_SUM NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_FILEA7 ***
 exec bpa.alter_policies('TMP_FILEA7');


COMMENT ON TABLE BARS.TMP_FILEA7 IS '';
COMMENT ON COLUMN BARS.TMP_FILEA7.Z_DATE IS 'Отчетная дата';
COMMENT ON COLUMN BARS.TMP_FILEA7.N_SYSTEM IS 'N подситемы (1-СБОН,2-IS-Card,3- , 4- )';
COMMENT ON COLUMN BARS.TMP_FILEA7.NLS IS 'Лицевой счет';
COMMENT ON COLUMN BARS.TMP_FILEA7.KV IS 'Код валюты';
COMMENT ON COLUMN BARS.TMP_FILEA7.OST IS 'Остаток на счете';
COMMENT ON COLUMN BARS.TMP_FILEA7.NLS_K IS 'Консолидированный лицевой счет';
COMMENT ON COLUMN BARS.TMP_FILEA7.SDATE IS 'Дата начала действия договора';
COMMENT ON COLUMN BARS.TMP_FILEA7.EDATE IS 'Дата окончания действия договора';
COMMENT ON COLUMN BARS.TMP_FILEA7.COUNTRY IS 'Код страны контрагента';
COMMENT ON COLUMN BARS.TMP_FILEA7.R013 IS 'Параметр R013 (1-на вимогу,9-iншi)';
COMMENT ON COLUMN BARS.TMP_FILEA7.MIN_SUM IS '';



PROMPT *** Create  grants  TMP_FILEA7 ***
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on TMP_FILEA7      to BARS_ACCESS_DEFROLE;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on TMP_FILEA7      to RPBN002;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_FILEA7      to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to TMP_FILEA7 ***

  CREATE OR REPLACE PUBLIC SYNONYM TMP_FILEA7 FOR BARS.TMP_FILEA7;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_FILEA7.sql =========*** End *** ==
PROMPT ===================================================================================== 
