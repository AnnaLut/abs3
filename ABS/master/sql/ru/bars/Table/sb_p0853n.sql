

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SB_P0853N.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SB_P0853N ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SB_P0853N'', ''FILIAL'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SB_P0853N ***
begin 
  execute immediate '
  CREATE TABLE BARS.SB_P0853N 
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




PROMPT *** ALTER_POLICIES to SB_P0853N ***
 exec bpa.alter_policies('SB_P0853N');


COMMENT ON TABLE BARS.SB_P0853N IS '';
COMMENT ON COLUMN BARS.SB_P0853N.R020 IS '';
COMMENT ON COLUMN BARS.SB_P0853N.P080 IS '';
COMMENT ON COLUMN BARS.SB_P0853N.R020_FA IS '';
COMMENT ON COLUMN BARS.SB_P0853N.OB22 IS '';
COMMENT ON COLUMN BARS.SB_P0853N.TXT IS '';
COMMENT ON COLUMN BARS.SB_P0853N.AP IS '';
COMMENT ON COLUMN BARS.SB_P0853N.PRIZN_VIDP IS '';
COMMENT ON COLUMN BARS.SB_P0853N.D_OPEN IS '';
COMMENT ON COLUMN BARS.SB_P0853N.D_CLOSE IS '';
COMMENT ON COLUMN BARS.SB_P0853N.COD_ACT IS '';
COMMENT ON COLUMN BARS.SB_P0853N.GR_FA IS '';
COMMENT ON COLUMN BARS.SB_P0853N.GR_IN IS '';



PROMPT *** Create  grants  SB_P0853N ***
grant SELECT                                                                 on SB_P0853N       to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SB_P0853N       to SB_P0853N;
grant SELECT                                                                 on SB_P0853N       to START1;



PROMPT *** Create SYNONYM  to SB_P0853N ***

  CREATE OR REPLACE PUBLIC SYNONYM SB_P0853N FOR BARS.SB_P0853N;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SB_P0853N.sql =========*** End *** ===
PROMPT ===================================================================================== 
