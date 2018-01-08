

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_INFLATION_COURT.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_INFLATION_COURT ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_INFLATION_COURT ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_INFLATION_COURT 
   (	ND NUMBER, 
	ACC NUMBER, 
	FDAT_BEG DATE, 
	FDAT_END DATE, 
	DAT_BEG_K DATE, 
	DAT_END_K DATE, 
	S_NOM NUMBER, 
	S NUMBER, 
	S_K NUMBER, 
	S3 NUMBER, 
	K NUMBER, 
	COMM VARCHAR2(1000), 
	DAT_IRR VARCHAR2(23), 
	TYP_KOD NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_INFLATION_COURT ***
 exec bpa.alter_policies('TMP_INFLATION_COURT');


COMMENT ON TABLE BARS.TMP_INFLATION_COURT IS '';
COMMENT ON COLUMN BARS.TMP_INFLATION_COURT.ND IS 'Реф договора';
COMMENT ON COLUMN BARS.TMP_INFLATION_COURT.ACC IS 'ид рах прострочки';
COMMENT ON COLUMN BARS.TMP_INFLATION_COURT.FDAT_BEG IS 'дата возн прострочки проводки';
COMMENT ON COLUMN BARS.TMP_INFLATION_COURT.FDAT_END IS 'дата погашен прострочки проводки';
COMMENT ON COLUMN BARS.TMP_INFLATION_COURT.DAT_BEG_K IS 'дата возн прострочки для использования коэф';
COMMENT ON COLUMN BARS.TMP_INFLATION_COURT.DAT_END_K IS 'дата подачи в суд (погашения прострочки)';
COMMENT ON COLUMN BARS.TMP_INFLATION_COURT.S_NOM IS 'Сумма проводки';
COMMENT ON COLUMN BARS.TMP_INFLATION_COURT.S IS 'сумма НЕПОГАШЕННОЙ прострочки';
COMMENT ON COLUMN BARS.TMP_INFLATION_COURT.S_K IS 'сумма инфляц втрат';
COMMENT ON COLUMN BARS.TMP_INFLATION_COURT.S3 IS 'сумма 3% від простроченної сумми заборгованості';
COMMENT ON COLUMN BARS.TMP_INFLATION_COURT.K IS 'коєф инфл. втрат';
COMMENT ON COLUMN BARS.TMP_INFLATION_COURT.COMM IS 'коментарий';
COMMENT ON COLUMN BARS.TMP_INFLATION_COURT.DAT_IRR IS 'Период за какой были начислены проценты/тело';
COMMENT ON COLUMN BARS.TMP_INFLATION_COURT.TYP_KOD IS '';



PROMPT *** Create  grants  TMP_INFLATION_COURT ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_INFLATION_COURT to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_INFLATION_COURT to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_INFLATION_COURT to RCC_DEAL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_INFLATION_COURT.sql =========*** E
PROMPT ===================================================================================== 
