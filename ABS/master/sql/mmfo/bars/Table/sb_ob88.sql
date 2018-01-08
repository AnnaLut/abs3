

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SB_OB88.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SB_OB88 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SB_OB88'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SB_OB88'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SB_OB88'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SB_OB88 ***
begin 
  execute immediate '
  CREATE TABLE BARS.SB_OB88 
   (	R020 VARCHAR2(4), 
	OB88 VARCHAR2(4), 
	TXT VARCHAR2(254), 
	D_OPEN DATE, 
	D_CLOSE DATE, 
	COD_ACT VARCHAR2(1), 
	A010 VARCHAR2(2)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SB_OB88 ***
 exec bpa.alter_policies('SB_OB88');


COMMENT ON TABLE BARS.SB_OB88 IS '';
COMMENT ON COLUMN BARS.SB_OB88.R020 IS '';
COMMENT ON COLUMN BARS.SB_OB88.OB88 IS '';
COMMENT ON COLUMN BARS.SB_OB88.TXT IS '';
COMMENT ON COLUMN BARS.SB_OB88.D_OPEN IS '';
COMMENT ON COLUMN BARS.SB_OB88.D_CLOSE IS '';
COMMENT ON COLUMN BARS.SB_OB88.COD_ACT IS '';
COMMENT ON COLUMN BARS.SB_OB88.A010 IS '';



PROMPT *** Create  grants  SB_OB88 ***
grant SELECT                                                                 on SB_OB88         to BARSREADER_ROLE;
grant SELECT                                                                 on SB_OB88         to BARS_DM;
grant SELECT                                                                 on SB_OB88         to UPLD;



PROMPT *** Create SYNONYM  to SB_OB88 ***

  CREATE OR REPLACE PUBLIC SYNONYM SB_OB88 FOR BARS.SB_OB88;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SB_OB88.sql =========*** End *** =====
PROMPT ===================================================================================== 
