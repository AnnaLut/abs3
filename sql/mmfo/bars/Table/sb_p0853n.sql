

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SB_P0853N.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SB_P0853N ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SB_P0853N'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SB_P0853N'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SB_P0853N'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SB_P0853N ***
begin 
  execute immediate '
  CREATE TABLE BARS.SB_P0853N 
   (	R020 VARCHAR2(4), 
	P080 VARCHAR2(4), 
	R020_FA VARCHAR2(4), 
	OB22 VARCHAR2(2), 
	TXT VARCHAR2(254), 
	AP VARCHAR2(1), 
	PRIZN_VIDP VARCHAR2(1), 
	D_OPEN DATE, 
	D_CLOSE DATE, 
	COD_ACT VARCHAR2(1), 
	GR_FA VARCHAR2(4), 
	GR_IN VARCHAR2(1)
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





PROMPT *** Create SYNONYM  to SB_P0853N ***

  CREATE OR REPLACE PUBLIC SYNONYM SB_P0853N FOR BARS.SB_P0853N;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SB_P0853N.sql =========*** End *** ===
PROMPT ===================================================================================== 
