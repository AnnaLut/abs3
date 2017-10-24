

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SB_P085N.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SB_P085N ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SB_P085N'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SB_P085N'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SB_P085N'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SB_P085N ***
begin 
  execute immediate '
  CREATE TABLE BARS.SB_P085N 
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




PROMPT *** ALTER_POLICIES to SB_P085N ***
 exec bpa.alter_policies('SB_P085N');


COMMENT ON TABLE BARS.SB_P085N IS '';
COMMENT ON COLUMN BARS.SB_P085N.R020 IS '';
COMMENT ON COLUMN BARS.SB_P085N.P080 IS '';
COMMENT ON COLUMN BARS.SB_P085N.R020_FA IS '';
COMMENT ON COLUMN BARS.SB_P085N.OB22 IS '';
COMMENT ON COLUMN BARS.SB_P085N.TXT IS '';
COMMENT ON COLUMN BARS.SB_P085N.AP IS '';
COMMENT ON COLUMN BARS.SB_P085N.PRIZN_VIDP IS '';
COMMENT ON COLUMN BARS.SB_P085N.D_OPEN IS '';
COMMENT ON COLUMN BARS.SB_P085N.D_CLOSE IS '';
COMMENT ON COLUMN BARS.SB_P085N.COD_ACT IS '';
COMMENT ON COLUMN BARS.SB_P085N.GR_FA IS '';
COMMENT ON COLUMN BARS.SB_P085N.GR_IN IS '';



PROMPT *** Create  grants  SB_P085N ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SB_P085N        to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SB_P085N        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SB_P085N.sql =========*** End *** ====
PROMPT ===================================================================================== 
