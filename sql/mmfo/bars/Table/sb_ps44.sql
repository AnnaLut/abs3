

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SB_PS44.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SB_PS44 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SB_PS44'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SB_PS44'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SB_PS44'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SB_PS44 ***
begin 
  execute immediate '
  CREATE TABLE BARS.SB_PS44 
   (	T020 CHAR(8), 
	R020 CHAR(4), 
	OB22 VARCHAR2(20), 
	OB40 CHAR(2), 
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




PROMPT *** ALTER_POLICIES to SB_PS44 ***
 exec bpa.alter_policies('SB_PS44');


COMMENT ON TABLE BARS.SB_PS44 IS '';
COMMENT ON COLUMN BARS.SB_PS44.T020 IS '';
COMMENT ON COLUMN BARS.SB_PS44.R020 IS '';
COMMENT ON COLUMN BARS.SB_PS44.OB22 IS '';
COMMENT ON COLUMN BARS.SB_PS44.OB40 IS '';
COMMENT ON COLUMN BARS.SB_PS44.D_OPEN IS '';
COMMENT ON COLUMN BARS.SB_PS44.D_CLOSE IS '';



PROMPT *** Create  grants  SB_PS44 ***
grant SELECT                                                                 on SB_PS44         to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SB_PS44         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SB_PS44         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on SB_PS44         to START1;
grant SELECT                                                                 on SB_PS44         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SB_PS44.sql =========*** End *** =====
PROMPT ===================================================================================== 
