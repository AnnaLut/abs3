

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KRYM_GAZR.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KRYM_GAZR ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KRYM_GAZR'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KRYM_GAZR'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KRYM_GAZR'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KRYM_GAZR ***
begin 
  execute immediate '
  CREATE TABLE BARS.KRYM_GAZR 
   (	NLS VARCHAR2(14), 
	N VARCHAR2(2), 
	TT CHAR(3), 
	MFOB VARCHAR2(6), 
	NLSB VARCHAR2(14), 
	OKPO VARCHAR2(8), 
	POLU VARCHAR2(38), 
	NAZN VARCHAR2(217), 
	KOEF NUMBER, 
	NAME VARCHAR2(20), 
	VOB NUMBER(*,0), 
	KV NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KRYM_GAZR ***
 exec bpa.alter_policies('KRYM_GAZR');


COMMENT ON TABLE BARS.KRYM_GAZR IS '';
COMMENT ON COLUMN BARS.KRYM_GAZR.NLS IS '';
COMMENT ON COLUMN BARS.KRYM_GAZR.N IS '';
COMMENT ON COLUMN BARS.KRYM_GAZR.TT IS '';
COMMENT ON COLUMN BARS.KRYM_GAZR.MFOB IS '';
COMMENT ON COLUMN BARS.KRYM_GAZR.NLSB IS '';
COMMENT ON COLUMN BARS.KRYM_GAZR.OKPO IS '';
COMMENT ON COLUMN BARS.KRYM_GAZR.POLU IS '';
COMMENT ON COLUMN BARS.KRYM_GAZR.NAZN IS '';
COMMENT ON COLUMN BARS.KRYM_GAZR.KOEF IS '';
COMMENT ON COLUMN BARS.KRYM_GAZR.NAME IS '';
COMMENT ON COLUMN BARS.KRYM_GAZR.VOB IS '';
COMMENT ON COLUMN BARS.KRYM_GAZR.KV IS '';



PROMPT *** Create  grants  KRYM_GAZR ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KRYM_GAZR       to ABS_ADMIN;
grant SELECT                                                                 on KRYM_GAZR       to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KRYM_GAZR       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KRYM_GAZR       to UPLD;
grant FLASHBACK,SELECT                                                       on KRYM_GAZR       to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KRYM_GAZR.sql =========*** End *** ===
PROMPT ===================================================================================== 
