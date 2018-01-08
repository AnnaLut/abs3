

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SB_P085_OLD.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SB_P085_OLD ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SB_P085_OLD'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SB_P085_OLD'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SB_P085_OLD'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SB_P085_OLD ***
begin 
  execute immediate '
  CREATE TABLE BARS.SB_P085_OLD 
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




PROMPT *** ALTER_POLICIES to SB_P085_OLD ***
 exec bpa.alter_policies('SB_P085_OLD');


COMMENT ON TABLE BARS.SB_P085_OLD IS '';
COMMENT ON COLUMN BARS.SB_P085_OLD.R020 IS '';
COMMENT ON COLUMN BARS.SB_P085_OLD.P080 IS '';
COMMENT ON COLUMN BARS.SB_P085_OLD.R020_FA IS '';
COMMENT ON COLUMN BARS.SB_P085_OLD.OB22 IS '';
COMMENT ON COLUMN BARS.SB_P085_OLD.TXT IS '';
COMMENT ON COLUMN BARS.SB_P085_OLD.AP IS '';
COMMENT ON COLUMN BARS.SB_P085_OLD.PRIZN_VIDP IS '';
COMMENT ON COLUMN BARS.SB_P085_OLD.D_OPEN IS '';
COMMENT ON COLUMN BARS.SB_P085_OLD.D_CLOSE IS '';
COMMENT ON COLUMN BARS.SB_P085_OLD.COD_ACT IS '';
COMMENT ON COLUMN BARS.SB_P085_OLD.GR_FA IS '';
COMMENT ON COLUMN BARS.SB_P085_OLD.GR_IN IS '';



PROMPT *** Create  grants  SB_P085_OLD ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SB_P085_OLD     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SB_P085_OLD     to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on SB_P085_OLD     to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SB_P085_OLD.sql =========*** End *** =
PROMPT ===================================================================================== 
