

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KAZ_ZOBT.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KAZ_ZOBT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KAZ_ZOBT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KAZ_ZOBT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KAZ_ZOBT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KAZ_ZOBT ***
begin 
  execute immediate '
  CREATE TABLE BARS.KAZ_ZOBT 
   (	DK NUMBER(*,0), 
	D_REC VARCHAR2(60), 
	NLSA VARCHAR2(14), 
	KVA NUMBER(*,0), 
	MFOB VARCHAR2(12), 
	NLSB VARCHAR2(14), 
	KVB NUMBER(*,0), 
	TT CHAR(3), 
	VOB NUMBER(*,0), 
	ND VARCHAR2(10), 
	DATD DATE, 
	S NUMBER, 
	NAM_A VARCHAR2(38), 
	NAM_B VARCHAR2(38), 
	NAZN VARCHAR2(160), 
	OKPOA VARCHAR2(14), 
	OKPOB VARCHAR2(14), 
	GRP NUMBER(*,0), 
	REF NUMBER(*,0), 
	SOS NUMBER(*,0), 
	ID NUMBER(*,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KAZ_ZOBT ***
 exec bpa.alter_policies('KAZ_ZOBT');


COMMENT ON TABLE BARS.KAZ_ZOBT IS '';
COMMENT ON COLUMN BARS.KAZ_ZOBT.DK IS '';
COMMENT ON COLUMN BARS.KAZ_ZOBT.D_REC IS '';
COMMENT ON COLUMN BARS.KAZ_ZOBT.NLSA IS '';
COMMENT ON COLUMN BARS.KAZ_ZOBT.KVA IS '';
COMMENT ON COLUMN BARS.KAZ_ZOBT.MFOB IS '';
COMMENT ON COLUMN BARS.KAZ_ZOBT.NLSB IS '';
COMMENT ON COLUMN BARS.KAZ_ZOBT.KVB IS '';
COMMENT ON COLUMN BARS.KAZ_ZOBT.TT IS '';
COMMENT ON COLUMN BARS.KAZ_ZOBT.VOB IS '';
COMMENT ON COLUMN BARS.KAZ_ZOBT.ND IS '';
COMMENT ON COLUMN BARS.KAZ_ZOBT.DATD IS '';
COMMENT ON COLUMN BARS.KAZ_ZOBT.S IS '';
COMMENT ON COLUMN BARS.KAZ_ZOBT.NAM_A IS '';
COMMENT ON COLUMN BARS.KAZ_ZOBT.NAM_B IS '';
COMMENT ON COLUMN BARS.KAZ_ZOBT.NAZN IS '';
COMMENT ON COLUMN BARS.KAZ_ZOBT.OKPOA IS '';
COMMENT ON COLUMN BARS.KAZ_ZOBT.OKPOB IS '';
COMMENT ON COLUMN BARS.KAZ_ZOBT.GRP IS '';
COMMENT ON COLUMN BARS.KAZ_ZOBT.REF IS '';
COMMENT ON COLUMN BARS.KAZ_ZOBT.SOS IS '';
COMMENT ON COLUMN BARS.KAZ_ZOBT.ID IS '';



PROMPT *** Create  grants  KAZ_ZOBT ***
grant SELECT                                                                 on KAZ_ZOBT        to BARSREADER_ROLE;
grant SELECT,UPDATE                                                          on KAZ_ZOBT        to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on KAZ_ZOBT        to PYOD001;
grant SELECT                                                                 on KAZ_ZOBT        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KAZ_ZOBT.sql =========*** End *** ====
PROMPT ===================================================================================== 
