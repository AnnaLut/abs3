

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SB_P085_L.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SB_P085_L ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SB_P085_L'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SB_P085_L'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SB_P085_L'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SB_P085_L ***
begin 
  execute immediate '
  CREATE TABLE BARS.SB_P085_L 
   (	R020 CHAR(4), 
	P080 CHAR(4), 
	R020_FA CHAR(4), 
	OB22 CHAR(2), 
	TXT VARCHAR2(254), 
	AP CHAR(1), 
	PRIZN_VIDP CHAR(1), 
	D_OPEN DATE, 
	D_CLOSE DATE, 
	COD_ACT CHAR(1), 
	GR_FA CHAR(4), 
	GR_IN CHAR(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SB_P085_L ***
 exec bpa.alter_policies('SB_P085_L');


COMMENT ON TABLE BARS.SB_P085_L IS '';
COMMENT ON COLUMN BARS.SB_P085_L.R020 IS '';
COMMENT ON COLUMN BARS.SB_P085_L.P080 IS '';
COMMENT ON COLUMN BARS.SB_P085_L.R020_FA IS '';
COMMENT ON COLUMN BARS.SB_P085_L.OB22 IS '';
COMMENT ON COLUMN BARS.SB_P085_L.TXT IS '';
COMMENT ON COLUMN BARS.SB_P085_L.AP IS '';
COMMENT ON COLUMN BARS.SB_P085_L.PRIZN_VIDP IS '';
COMMENT ON COLUMN BARS.SB_P085_L.D_OPEN IS '';
COMMENT ON COLUMN BARS.SB_P085_L.D_CLOSE IS '';
COMMENT ON COLUMN BARS.SB_P085_L.COD_ACT IS '';
COMMENT ON COLUMN BARS.SB_P085_L.GR_FA IS '';
COMMENT ON COLUMN BARS.SB_P085_L.GR_IN IS '';



PROMPT *** Create  grants  SB_P085_L ***
grant SELECT                                                                 on SB_P085_L       to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SB_P085_L       to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SB_P085_L       to START1;
grant SELECT                                                                 on SB_P085_L       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SB_P085_L.sql =========*** End *** ===
PROMPT ===================================================================================== 
