

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/VKLAD_FG.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to VKLAD_FG ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''VKLAD_FG'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''VKLAD_FG'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''VKLAD_FG'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table VKLAD_FG ***
begin 
  execute immediate '
  CREATE TABLE BARS.VKLAD_FG 
   (	NPP NUMBER(10,0), 
	DAT DATE, 
	MFO CHAR(6), 
	FIO VARCHAR2(70), 
	OKPO VARCHAR2(14), 
	OBL VARCHAR2(30), 
	DST VARCHAR2(30), 
	TOWN VARCHAR2(30), 
	ADR VARCHAR2(70), 
	PASP VARCHAR2(100), 
	DATZ DATE, 
	ND VARCHAR2(30), 
	OST NUMBER(19,0), 
	OSTN NUMBER(19,0), 
	NLS VARCHAR2(14), 
	GAR NUMBER(*,0), 
	KV NUMBER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to VKLAD_FG ***
 exec bpa.alter_policies('VKLAD_FG');


COMMENT ON TABLE BARS.VKLAD_FG IS '';
COMMENT ON COLUMN BARS.VKLAD_FG.NPP IS '';
COMMENT ON COLUMN BARS.VKLAD_FG.DAT IS '';
COMMENT ON COLUMN BARS.VKLAD_FG.MFO IS '';
COMMENT ON COLUMN BARS.VKLAD_FG.FIO IS '';
COMMENT ON COLUMN BARS.VKLAD_FG.OKPO IS '';
COMMENT ON COLUMN BARS.VKLAD_FG.OBL IS '';
COMMENT ON COLUMN BARS.VKLAD_FG.DST IS '';
COMMENT ON COLUMN BARS.VKLAD_FG.TOWN IS '';
COMMENT ON COLUMN BARS.VKLAD_FG.ADR IS '';
COMMENT ON COLUMN BARS.VKLAD_FG.PASP IS '';
COMMENT ON COLUMN BARS.VKLAD_FG.DATZ IS '';
COMMENT ON COLUMN BARS.VKLAD_FG.ND IS '';
COMMENT ON COLUMN BARS.VKLAD_FG.OST IS '';
COMMENT ON COLUMN BARS.VKLAD_FG.OSTN IS '';
COMMENT ON COLUMN BARS.VKLAD_FG.NLS IS '';
COMMENT ON COLUMN BARS.VKLAD_FG.GAR IS '';
COMMENT ON COLUMN BARS.VKLAD_FG.KV IS '';



PROMPT *** Create  grants  VKLAD_FG ***
grant DELETE,INSERT,SELECT,UPDATE                                            on VKLAD_FG        to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on VKLAD_FG        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/VKLAD_FG.sql =========*** End *** ====
PROMPT ===================================================================================== 
