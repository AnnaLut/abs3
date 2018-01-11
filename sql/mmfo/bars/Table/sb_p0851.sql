

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SB_P0851.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SB_P0851 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SB_P0851'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SB_P0851'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SB_P0851'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SB_P0851 ***
begin 
  execute immediate '
  CREATE TABLE BARS.SB_P0851 
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




PROMPT *** ALTER_POLICIES to SB_P0851 ***
 exec bpa.alter_policies('SB_P0851');


COMMENT ON TABLE BARS.SB_P0851 IS '';
COMMENT ON COLUMN BARS.SB_P0851.R020 IS '';
COMMENT ON COLUMN BARS.SB_P0851.P080 IS '';
COMMENT ON COLUMN BARS.SB_P0851.R020_FA IS '';
COMMENT ON COLUMN BARS.SB_P0851.OB22 IS '';
COMMENT ON COLUMN BARS.SB_P0851.TXT IS '';
COMMENT ON COLUMN BARS.SB_P0851.AP IS '';
COMMENT ON COLUMN BARS.SB_P0851.PRIZN_VIDP IS '';
COMMENT ON COLUMN BARS.SB_P0851.D_OPEN IS '';
COMMENT ON COLUMN BARS.SB_P0851.D_CLOSE IS '';
COMMENT ON COLUMN BARS.SB_P0851.COD_ACT IS '';
COMMENT ON COLUMN BARS.SB_P0851.GR_FA IS '';
COMMENT ON COLUMN BARS.SB_P0851.GR_IN IS '';



PROMPT *** Create  grants  SB_P0851 ***
grant SELECT                                                                 on SB_P0851        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SB_P0851.sql =========*** End *** ====
PROMPT ===================================================================================== 
