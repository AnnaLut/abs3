

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SB_OB22.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SB_OB22 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SB_OB22'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SB_OB22'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SB_OB22'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SB_OB22 ***
begin 
  execute immediate '
  CREATE TABLE BARS.SB_OB22 
   (	R020 CHAR(4), 
	OB22 CHAR(2), 
	TXT VARCHAR2(254), 
	PRIZ CHAR(1), 
	D_OPEN DATE, 
	D_CLOSE DATE, 
	COD_ACT CHAR(1), 
	A010 CHAR(2), 
	ZN50 VARCHAR2(7), 
	SEGMENT NUMBER(38,0), 
	ZN501 VARCHAR2(7) GENERATED ALWAYS AS (NULL) VIRTUAL VISIBLE 
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SB_OB22 ***
 exec bpa.alter_policies('SB_OB22');


COMMENT ON TABLE BARS.SB_OB22 IS '';
COMMENT ON COLUMN BARS.SB_OB22.R020 IS '';
COMMENT ON COLUMN BARS.SB_OB22.OB22 IS '';
COMMENT ON COLUMN BARS.SB_OB22.TXT IS '';
COMMENT ON COLUMN BARS.SB_OB22.PRIZ IS '';
COMMENT ON COLUMN BARS.SB_OB22.D_OPEN IS '';
COMMENT ON COLUMN BARS.SB_OB22.D_CLOSE IS '';
COMMENT ON COLUMN BARS.SB_OB22.COD_ACT IS '';
COMMENT ON COLUMN BARS.SB_OB22.A010 IS '';
COMMENT ON COLUMN BARS.SB_OB22.ZN50 IS '';
COMMENT ON COLUMN BARS.SB_OB22.SEGMENT IS '';
COMMENT ON COLUMN BARS.SB_OB22.ZN501 IS '';




PROMPT *** Create  constraint XPK_SB_OB22 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SB_OB22 ADD CONSTRAINT XPK_SB_OB22 PRIMARY KEY (R020, OB22)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_SB_OB22 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_SB_OB22 ON BARS.SB_OB22 (R020, OB22) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SB_OB22 ***
grant SELECT                                                                 on SB_OB22         to BARSUPL;
grant INSERT,SELECT,UPDATE                                                   on SB_OB22         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SB_OB22         to BARS_DM;



PROMPT *** Create SYNONYM  to SB_OB22 ***

  CREATE OR REPLACE PUBLIC SYNONYM SB_OB22 FOR BARS.SB_OB22;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SB_OB22.sql =========*** End *** =====
PROMPT ===================================================================================== 
