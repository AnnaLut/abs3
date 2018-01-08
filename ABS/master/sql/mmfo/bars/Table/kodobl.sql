

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KODOBL.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KODOBL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KODOBL'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KODOBL'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KODOBL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KODOBL ***
begin 
  execute immediate '
  CREATE TABLE BARS.KODOBL 
   (	KO NUMBER(*,0), 
	KNB VARCHAR2(27), 
	NG VARCHAR2(16), 
	RC NUMBER(*,0), 
	KODREG NUMBER(*,0), 
	NCKS CHAR(4), 
	HCKS CHAR(4), 
	ISEP CHAR(4), 
	MFO NUMBER(*,0), 
	NLSEMD NUMBER(14,0), 
	BANKK VARCHAR2(51), 
	BANKO VARCHAR2(51), 
	BANKM VARCHAR2(51), 
	BANK VARCHAR2(51), 
	KB NUMBER(*,0), 
	DATA_O DATE, 
	DATA_C DATE, 
	GR_NBU CHAR(1), 
	KOD_CKV CHAR(10)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KODOBL ***
 exec bpa.alter_policies('KODOBL');


COMMENT ON TABLE BARS.KODOBL IS '';
COMMENT ON COLUMN BARS.KODOBL.KO IS '';
COMMENT ON COLUMN BARS.KODOBL.KNB IS '';
COMMENT ON COLUMN BARS.KODOBL.NG IS '';
COMMENT ON COLUMN BARS.KODOBL.RC IS '';
COMMENT ON COLUMN BARS.KODOBL.KODREG IS '';
COMMENT ON COLUMN BARS.KODOBL.NCKS IS '';
COMMENT ON COLUMN BARS.KODOBL.HCKS IS '';
COMMENT ON COLUMN BARS.KODOBL.ISEP IS '';
COMMENT ON COLUMN BARS.KODOBL.MFO IS '';
COMMENT ON COLUMN BARS.KODOBL.NLSEMD IS '';
COMMENT ON COLUMN BARS.KODOBL.BANKK IS '';
COMMENT ON COLUMN BARS.KODOBL.BANKO IS '';
COMMENT ON COLUMN BARS.KODOBL.BANKM IS '';
COMMENT ON COLUMN BARS.KODOBL.BANK IS '';
COMMENT ON COLUMN BARS.KODOBL.KB IS '';
COMMENT ON COLUMN BARS.KODOBL.DATA_O IS '';
COMMENT ON COLUMN BARS.KODOBL.DATA_C IS '';
COMMENT ON COLUMN BARS.KODOBL.GR_NBU IS '';
COMMENT ON COLUMN BARS.KODOBL.KOD_CKV IS '';



PROMPT *** Create  grants  KODOBL ***
grant SELECT                                                                 on KODOBL          to BARSREADER_ROLE;
grant SELECT                                                                 on KODOBL          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KODOBL          to BARS_DM;
grant SELECT                                                                 on KODOBL          to SALGL;
grant SELECT                                                                 on KODOBL          to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KODOBL          to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KODOBL.sql =========*** End *** ======
PROMPT ===================================================================================== 
