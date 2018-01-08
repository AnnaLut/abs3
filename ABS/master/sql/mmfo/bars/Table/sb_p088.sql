

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SB_P088.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SB_P088 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SB_P088 ***
begin 
  execute immediate '
  CREATE TABLE BARS.SB_P088 
   (	R020 VARCHAR2(4), 
	P080 VARCHAR2(4), 
	R020_FA VARCHAR2(4), 
	OB22 VARCHAR2(2), 
	D_OPEN DATE, 
	D_CLOSE DATE, 
	COD_ACT VARCHAR2(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SB_P088 ***
 exec bpa.alter_policies('SB_P088');


COMMENT ON TABLE BARS.SB_P088 IS '';
COMMENT ON COLUMN BARS.SB_P088.R020 IS '';
COMMENT ON COLUMN BARS.SB_P088.P080 IS '';
COMMENT ON COLUMN BARS.SB_P088.R020_FA IS '';
COMMENT ON COLUMN BARS.SB_P088.OB22 IS '';
COMMENT ON COLUMN BARS.SB_P088.D_OPEN IS '';
COMMENT ON COLUMN BARS.SB_P088.D_CLOSE IS '';
COMMENT ON COLUMN BARS.SB_P088.COD_ACT IS '';



PROMPT *** Create  grants  SB_P088 ***
grant SELECT                                                                 on SB_P088         to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SB_P088         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SB_P088.sql =========*** End *** =====
PROMPT ===================================================================================== 
