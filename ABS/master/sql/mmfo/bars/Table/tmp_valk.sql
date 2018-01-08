

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_VALK.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_VALK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMP_VALK'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_VALK'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_VALK'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_VALK ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_VALK 
   (	KV NUMBER(38,0), 
	LCV CHAR(3), 
	NAME VARCHAR2(35), 
	BSUM NUMBER(9,4), 
	VDATE1 DATE, 
	VDATE2 DATE, 
	RATEO1 NUMBER(9,4), 
	RATEO2 NUMBER(9,4), 
	RATEB1 NUMBER(9,4), 
	RATEB2 NUMBER(9,4), 
	RATES1 NUMBER(9,4), 
	RATES2 NUMBER(9,4)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_VALK ***
 exec bpa.alter_policies('TMP_VALK');


COMMENT ON TABLE BARS.TMP_VALK IS '';
COMMENT ON COLUMN BARS.TMP_VALK.KV IS '';
COMMENT ON COLUMN BARS.TMP_VALK.LCV IS '';
COMMENT ON COLUMN BARS.TMP_VALK.NAME IS '';
COMMENT ON COLUMN BARS.TMP_VALK.BSUM IS '';
COMMENT ON COLUMN BARS.TMP_VALK.VDATE1 IS '';
COMMENT ON COLUMN BARS.TMP_VALK.VDATE2 IS '';
COMMENT ON COLUMN BARS.TMP_VALK.RATEO1 IS '';
COMMENT ON COLUMN BARS.TMP_VALK.RATEO2 IS '';
COMMENT ON COLUMN BARS.TMP_VALK.RATEB1 IS '';
COMMENT ON COLUMN BARS.TMP_VALK.RATEB2 IS '';
COMMENT ON COLUMN BARS.TMP_VALK.RATES1 IS '';
COMMENT ON COLUMN BARS.TMP_VALK.RATES2 IS '';



PROMPT *** Create  grants  TMP_VALK ***
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on TMP_VALK        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_VALK        to OPERKKK;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on TMP_VALK        to TECH_MOM1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_VALK        to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to TMP_VALK ***

  CREATE OR REPLACE PUBLIC SYNONYM TMP_VALK FOR BARS.TMP_VALK;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_VALK.sql =========*** End *** ====
PROMPT ===================================================================================== 
