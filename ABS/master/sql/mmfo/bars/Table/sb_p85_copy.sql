

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SB_P85_COPY.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SB_P85_COPY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SB_P85_COPY'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SB_P85_COPY'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SB_P85_COPY'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SB_P85_COPY ***
begin 
  execute immediate '
  CREATE TABLE BARS.SB_P85_COPY 
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




PROMPT *** ALTER_POLICIES to SB_P85_COPY ***
 exec bpa.alter_policies('SB_P85_COPY');


COMMENT ON TABLE BARS.SB_P85_COPY IS '';
COMMENT ON COLUMN BARS.SB_P85_COPY.R020 IS '';
COMMENT ON COLUMN BARS.SB_P85_COPY.P080 IS '';
COMMENT ON COLUMN BARS.SB_P85_COPY.R020_FA IS '';
COMMENT ON COLUMN BARS.SB_P85_COPY.OB22 IS '';
COMMENT ON COLUMN BARS.SB_P85_COPY.TXT IS '';
COMMENT ON COLUMN BARS.SB_P85_COPY.AP IS '';
COMMENT ON COLUMN BARS.SB_P85_COPY.PRIZN_VIDP IS '';
COMMENT ON COLUMN BARS.SB_P85_COPY.D_OPEN IS '';
COMMENT ON COLUMN BARS.SB_P85_COPY.D_CLOSE IS '';
COMMENT ON COLUMN BARS.SB_P85_COPY.COD_ACT IS '';
COMMENT ON COLUMN BARS.SB_P85_COPY.GR_FA IS '';
COMMENT ON COLUMN BARS.SB_P85_COPY.GR_IN IS '';



PROMPT *** Create  grants  SB_P85_COPY ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SB_P85_COPY     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SB_P85_COPY     to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on SB_P85_COPY     to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SB_P85_COPY.sql =========*** End *** =
PROMPT ===================================================================================== 
