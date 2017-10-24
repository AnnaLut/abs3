

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SB_OB22N.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SB_OB22N ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SB_OB22N'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SB_OB22N'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SB_OB22N'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SB_OB22N ***
begin 
  execute immediate '
  CREATE TABLE BARS.SB_OB22N 
   (	R020 VARCHAR2(4), 
	OB22 VARCHAR2(2), 
	TXT VARCHAR2(254), 
	PRIZ VARCHAR2(1), 
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




PROMPT *** ALTER_POLICIES to SB_OB22N ***
 exec bpa.alter_policies('SB_OB22N');


COMMENT ON TABLE BARS.SB_OB22N IS '';
COMMENT ON COLUMN BARS.SB_OB22N.R020 IS '';
COMMENT ON COLUMN BARS.SB_OB22N.OB22 IS '';
COMMENT ON COLUMN BARS.SB_OB22N.TXT IS '';
COMMENT ON COLUMN BARS.SB_OB22N.PRIZ IS '';
COMMENT ON COLUMN BARS.SB_OB22N.D_OPEN IS '';
COMMENT ON COLUMN BARS.SB_OB22N.D_CLOSE IS '';
COMMENT ON COLUMN BARS.SB_OB22N.COD_ACT IS '';
COMMENT ON COLUMN BARS.SB_OB22N.A010 IS '';





PROMPT *** Create SYNONYM  to SB_OB22N ***

  CREATE OR REPLACE PUBLIC SYNONYM SB_OB22N FOR BARS.SB_OB22N;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SB_OB22N.sql =========*** End *** ====
PROMPT ===================================================================================== 
