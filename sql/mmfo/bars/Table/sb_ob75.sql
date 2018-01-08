

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SB_OB75.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SB_OB75 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SB_OB75'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SB_OB75'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SB_OB75'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SB_OB75 ***
begin 
  execute immediate '
  CREATE TABLE BARS.SB_OB75 
   (	OB75 CHAR(2), 
	NAZVA VARCHAR2(100), 
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




PROMPT *** ALTER_POLICIES to SB_OB75 ***
 exec bpa.alter_policies('SB_OB75');


COMMENT ON TABLE BARS.SB_OB75 IS '';
COMMENT ON COLUMN BARS.SB_OB75.OB75 IS '';
COMMENT ON COLUMN BARS.SB_OB75.NAZVA IS '';
COMMENT ON COLUMN BARS.SB_OB75.D_OPEN IS '';
COMMENT ON COLUMN BARS.SB_OB75.D_CLOSE IS '';



PROMPT *** Create  grants  SB_OB75 ***
grant SELECT                                                                 on SB_OB75         to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SB_OB75         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SB_OB75         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on SB_OB75         to START1;
grant SELECT                                                                 on SB_OB75         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SB_OB75.sql =========*** End *** =====
PROMPT ===================================================================================== 
