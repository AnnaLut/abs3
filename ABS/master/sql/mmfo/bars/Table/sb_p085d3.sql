

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SB_P085D3.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SB_P085D3 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SB_P085D3'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SB_P085D3'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SB_P085D3'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SB_P085D3 ***
begin 
  execute immediate '
  CREATE TABLE BARS.SB_P085D3 
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
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SB_P085D3 ***
 exec bpa.alter_policies('SB_P085D3');


COMMENT ON TABLE BARS.SB_P085D3 IS 'Классификатор ОБ (SB_P085D3)';
COMMENT ON COLUMN BARS.SB_P085D3.R020 IS '';
COMMENT ON COLUMN BARS.SB_P085D3.P080 IS '';
COMMENT ON COLUMN BARS.SB_P085D3.R020_FA IS '';
COMMENT ON COLUMN BARS.SB_P085D3.OB22 IS '';
COMMENT ON COLUMN BARS.SB_P085D3.TXT IS '';
COMMENT ON COLUMN BARS.SB_P085D3.AP IS '';
COMMENT ON COLUMN BARS.SB_P085D3.PRIZN_VIDP IS '';
COMMENT ON COLUMN BARS.SB_P085D3.D_OPEN IS '';
COMMENT ON COLUMN BARS.SB_P085D3.D_CLOSE IS '';
COMMENT ON COLUMN BARS.SB_P085D3.COD_ACT IS '';
COMMENT ON COLUMN BARS.SB_P085D3.GR_FA IS '';
COMMENT ON COLUMN BARS.SB_P085D3.GR_IN IS '';



PROMPT *** Create  grants  SB_P085D3 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SB_P085D3       to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SB_P085D3       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SB_P085D3       to BARS_DM;
grant SELECT                                                                 on SB_P085D3       to RPBN002;
grant DELETE,INSERT,SELECT,UPDATE                                            on SB_P085D3       to SB_P085D3;
grant SELECT                                                                 on SB_P085D3       to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SB_P085D3       to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on SB_P085D3       to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SB_P085D3.sql =========*** End *** ===
PROMPT ===================================================================================== 
