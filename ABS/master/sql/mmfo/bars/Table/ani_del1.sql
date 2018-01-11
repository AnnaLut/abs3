

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ANI_DEL1.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ANI_DEL1 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ANI_DEL1'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ANI_DEL1'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ANI_DEL1'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ANI_DEL1 ***
begin 
  execute immediate '
  CREATE TABLE BARS.ANI_DEL1 
   (	REF VARCHAR2(81), 
	PDAT DATE, 
	FDAT DATE, 
	ND VARCHAR2(10), 
	DATD DATE, 
	USERID NUMBER(38,0), 
	NLSD VARCHAR2(15), 
	NLSK VARCHAR2(15), 
	SQ NUMBER(24,0), 
	KV NUMBER(3,0), 
	S NUMBER(24,0), 
	NAZN VARCHAR2(160)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ANI_DEL1 ***
 exec bpa.alter_policies('ANI_DEL1');


COMMENT ON TABLE BARS.ANI_DEL1 IS '';
COMMENT ON COLUMN BARS.ANI_DEL1.REF IS '';
COMMENT ON COLUMN BARS.ANI_DEL1.PDAT IS '';
COMMENT ON COLUMN BARS.ANI_DEL1.FDAT IS '';
COMMENT ON COLUMN BARS.ANI_DEL1.ND IS '';
COMMENT ON COLUMN BARS.ANI_DEL1.DATD IS '';
COMMENT ON COLUMN BARS.ANI_DEL1.USERID IS '';
COMMENT ON COLUMN BARS.ANI_DEL1.NLSD IS '';
COMMENT ON COLUMN BARS.ANI_DEL1.NLSK IS '';
COMMENT ON COLUMN BARS.ANI_DEL1.SQ IS '';
COMMENT ON COLUMN BARS.ANI_DEL1.KV IS '';
COMMENT ON COLUMN BARS.ANI_DEL1.S IS '';
COMMENT ON COLUMN BARS.ANI_DEL1.NAZN IS '';



PROMPT *** Create  grants  ANI_DEL1 ***
grant SELECT                                                                 on ANI_DEL1        to BARSREADER_ROLE;
grant SELECT,UPDATE                                                          on ANI_DEL1        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ANI_DEL1        to BARS_DM;
grant SELECT,UPDATE                                                          on ANI_DEL1        to START1;
grant SELECT                                                                 on ANI_DEL1        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ANI_DEL1.sql =========*** End *** ====
PROMPT ===================================================================================== 
