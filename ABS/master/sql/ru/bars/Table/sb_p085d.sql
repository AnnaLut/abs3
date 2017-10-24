

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SB_P085D.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SB_P085D ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SB_P085D'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SB_P085D'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SB_P085D ***
begin 
  execute immediate '
  CREATE TABLE BARS.SB_P085D 
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




PROMPT *** ALTER_POLICIES to SB_P085D ***
 exec bpa.alter_policies('SB_P085D');


COMMENT ON TABLE BARS.SB_P085D IS '������������� �� (SB_P085D)';
COMMENT ON COLUMN BARS.SB_P085D.R020 IS '';
COMMENT ON COLUMN BARS.SB_P085D.P080 IS '';
COMMENT ON COLUMN BARS.SB_P085D.R020_FA IS '';
COMMENT ON COLUMN BARS.SB_P085D.OB22 IS '';
COMMENT ON COLUMN BARS.SB_P085D.TXT IS '';
COMMENT ON COLUMN BARS.SB_P085D.AP IS '';
COMMENT ON COLUMN BARS.SB_P085D.PRIZN_VIDP IS '';
COMMENT ON COLUMN BARS.SB_P085D.D_OPEN IS '';
COMMENT ON COLUMN BARS.SB_P085D.D_CLOSE IS '';
COMMENT ON COLUMN BARS.SB_P085D.COD_ACT IS '';
COMMENT ON COLUMN BARS.SB_P085D.GR_FA IS '';
COMMENT ON COLUMN BARS.SB_P085D.GR_IN IS '';



PROMPT *** Create  grants  SB_P085D ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SB_P085D        to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on SB_P085D        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SB_P085D        to RPBN002;
grant SELECT                                                                 on SB_P085D        to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SB_P085D        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SB_P085D.sql =========*** End *** ====
PROMPT ===================================================================================== 
