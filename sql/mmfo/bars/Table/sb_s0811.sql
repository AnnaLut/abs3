

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SB_S0811.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SB_S0811 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SB_S0811'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SB_S0811'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SB_S0811'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SB_S0811 ***
begin 
  execute immediate '
  CREATE TABLE BARS.SB_S0811 
   (	NDOC CHAR(4), 
	NNDOC CHAR(2), 
	NROW CHAR(2), 
	NPP CHAR(10), 
	S080 CHAR(4), 
	NAME VARCHAR2(254), 
	D_OPEN DATE, 
	D_CLOSE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SB_S0811 ***
 exec bpa.alter_policies('SB_S0811');


COMMENT ON TABLE BARS.SB_S0811 IS '';
COMMENT ON COLUMN BARS.SB_S0811.NDOC IS '';
COMMENT ON COLUMN BARS.SB_S0811.NNDOC IS '';
COMMENT ON COLUMN BARS.SB_S0811.NROW IS '';
COMMENT ON COLUMN BARS.SB_S0811.NPP IS '';
COMMENT ON COLUMN BARS.SB_S0811.S080 IS '';
COMMENT ON COLUMN BARS.SB_S0811.NAME IS '';
COMMENT ON COLUMN BARS.SB_S0811.D_OPEN IS '';
COMMENT ON COLUMN BARS.SB_S0811.D_CLOSE IS '';



PROMPT *** Create  grants  SB_S0811 ***
grant SELECT                                                                 on SB_S0811        to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SB_S0811        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SB_S0811        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on SB_S0811        to START1;
grant SELECT                                                                 on SB_S0811        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SB_S0811.sql =========*** End *** ====
PROMPT ===================================================================================== 
