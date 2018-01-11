

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SB_PS75.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SB_PS75 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SB_PS75'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SB_PS75'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SB_PS75'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SB_PS75 ***
begin 
  execute immediate '
  CREATE TABLE BARS.SB_PS75 
   (	R020 VARCHAR2(4), 
	OB_22 VARCHAR2(14), 
	R020_7 VARCHAR2(4), 
	OB_22_7 VARCHAR2(10), 
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




PROMPT *** ALTER_POLICIES to SB_PS75 ***
 exec bpa.alter_policies('SB_PS75');


COMMENT ON TABLE BARS.SB_PS75 IS '';
COMMENT ON COLUMN BARS.SB_PS75.R020 IS '';
COMMENT ON COLUMN BARS.SB_PS75.OB_22 IS '';
COMMENT ON COLUMN BARS.SB_PS75.R020_7 IS '';
COMMENT ON COLUMN BARS.SB_PS75.OB_22_7 IS '';
COMMENT ON COLUMN BARS.SB_PS75.D_OPEN IS '';
COMMENT ON COLUMN BARS.SB_PS75.D_CLOSE IS '';



PROMPT *** Create  grants  SB_PS75 ***
grant SELECT                                                                 on SB_PS75         to BARSREADER_ROLE;
grant SELECT                                                                 on SB_PS75         to BARS_DM;
grant SELECT                                                                 on SB_PS75         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SB_PS75.sql =========*** End *** =====
PROMPT ===================================================================================== 
