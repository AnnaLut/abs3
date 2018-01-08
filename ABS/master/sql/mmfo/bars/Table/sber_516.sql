

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SBER_516.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SBER_516 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SBER_516'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SBER_516'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SBER_516'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SBER_516 ***
begin 
  execute immediate '
  CREATE TABLE BARS.SBER_516 
   (	ACC NUMBER, 
	NLS VARCHAR2(15), 
	KV NUMBER(*,0), 
	DAOS DATE, 
	DAZS DATE, 
	FDAT DATE, 
	TDAT DATE, 
	IR NUMBER, 
	BR NUMBER, 
	OSTS NUMBER(24,0), 
	PLANSUM NUMBER(24,0), 
	FACTSUM NUMBER(24,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SBER_516 ***
 exec bpa.alter_policies('SBER_516');


COMMENT ON TABLE BARS.SBER_516 IS '';
COMMENT ON COLUMN BARS.SBER_516.ACC IS '';
COMMENT ON COLUMN BARS.SBER_516.NLS IS '';
COMMENT ON COLUMN BARS.SBER_516.KV IS '';
COMMENT ON COLUMN BARS.SBER_516.DAOS IS '';
COMMENT ON COLUMN BARS.SBER_516.DAZS IS '';
COMMENT ON COLUMN BARS.SBER_516.FDAT IS '';
COMMENT ON COLUMN BARS.SBER_516.TDAT IS '';
COMMENT ON COLUMN BARS.SBER_516.IR IS '';
COMMENT ON COLUMN BARS.SBER_516.BR IS '';
COMMENT ON COLUMN BARS.SBER_516.OSTS IS '';
COMMENT ON COLUMN BARS.SBER_516.PLANSUM IS '';
COMMENT ON COLUMN BARS.SBER_516.FACTSUM IS '';



PROMPT *** Create  grants  SBER_516 ***
grant SELECT                                                                 on SBER_516        to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SBER_516        to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SBER_516        to START1;
grant SELECT                                                                 on SBER_516        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SBER_516.sql =========*** End *** ====
PROMPT ===================================================================================== 
