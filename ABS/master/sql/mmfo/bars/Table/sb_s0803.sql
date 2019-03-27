

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SB_S0803.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SB_S0803 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SB_S0803'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SB_S0803'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SB_S0803'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SB_S0803 ***
begin 
  execute immediate '
  CREATE TABLE BARS.SB_S0803 
   (	NDOC CHAR(2), 
	NROW CHAR(2), 
	NPP CHAR(10), 
	S080 CHAR(4), 
	NAME VARCHAR2(250), 
	ACC4COL CHAR(1), 
	D_OPEN DATE, 
	D_CLOSE DATE, 
	XNOMTABL NUMBER(*,0), 
	XNOMCOL NUMBER(*,0), 
	XNOMROW NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SB_S0803 ***
 exec bpa.alter_policies('SB_S0803');


COMMENT ON TABLE BARS.SB_S0803 IS '';
COMMENT ON COLUMN BARS.SB_S0803.NDOC IS '';
COMMENT ON COLUMN BARS.SB_S0803.NROW IS '';
COMMENT ON COLUMN BARS.SB_S0803.NPP IS '';
COMMENT ON COLUMN BARS.SB_S0803.S080 IS '';
COMMENT ON COLUMN BARS.SB_S0803.NAME IS '';
COMMENT ON COLUMN BARS.SB_S0803.ACC4COL IS '';
COMMENT ON COLUMN BARS.SB_S0803.D_OPEN IS '';
COMMENT ON COLUMN BARS.SB_S0803.D_CLOSE IS '';
COMMENT ON COLUMN BARS.SB_S0803.XNOMTABL IS '';
COMMENT ON COLUMN BARS.SB_S0803.XNOMCOL IS '';
COMMENT ON COLUMN BARS.SB_S0803.XNOMROW IS '';



PROMPT *** Create  grants  SB_S0803 ***
grant SELECT                                                                 on SB_S0803        to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SB_S0803        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SB_S0803        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on SB_S0803        to START1;
grant SELECT                                                                 on SB_S0803        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SB_S0803.sql =========*** End *** ====
PROMPT ===================================================================================== 