

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SB_R040.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SB_R040 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SB_R040'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SB_R040'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SB_R040'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SB_R040 ***
begin 
  execute immediate '
  CREATE TABLE BARS.SB_R040 
   (	T020 VARCHAR2(1), 
	R020 VARCHAR2(4), 
	OB22 VARCHAR2(2), 
	OB40 VARCHAR2(2), 
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




PROMPT *** ALTER_POLICIES to SB_R040 ***
 exec bpa.alter_policies('SB_R040');


COMMENT ON TABLE BARS.SB_R040 IS '';
COMMENT ON COLUMN BARS.SB_R040.T020 IS '';
COMMENT ON COLUMN BARS.SB_R040.R020 IS '';
COMMENT ON COLUMN BARS.SB_R040.OB22 IS '';
COMMENT ON COLUMN BARS.SB_R040.OB40 IS '';
COMMENT ON COLUMN BARS.SB_R040.D_OPEN IS '';
COMMENT ON COLUMN BARS.SB_R040.D_CLOSE IS '';



PROMPT *** Create  grants  SB_R040 ***
grant SELECT                                                                 on SB_R040         to BARS_DM;



PROMPT *** Create SYNONYM  to SB_R040 ***

  CREATE OR REPLACE PUBLIC SYNONYM SB_R040 FOR BARS.SB_R040;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SB_R040.sql =========*** End *** =====
PROMPT ===================================================================================== 
