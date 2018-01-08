

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/UR1.sql =========*** Run *** =========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to UR1 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''UR1'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''UR1'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''UR1'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table UR1 ***
begin 
  execute immediate '
  CREATE TABLE BARS.UR1 
   (	NLS NUMBER(21,0), 
	KV CHAR(9), 
	KV1 CHAR(8), 
	NLSZ1 VARCHAR2(19), 
	KV2 VARCHAR2(16), 
	NLSZ2 VARCHAR2(15), 
	KV3 VARCHAR2(15), 
	NLSZ3 NUMBER(17,0), 
	ACCK NUMBER(*,0), 
	ACC1 NUMBER(*,0), 
	ACC2 NUMBER(*,0), 
	ACC3 NUMBER(*,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to UR1 ***
 exec bpa.alter_policies('UR1');


COMMENT ON TABLE BARS.UR1 IS '';
COMMENT ON COLUMN BARS.UR1.NLS IS '';
COMMENT ON COLUMN BARS.UR1.KV IS '';
COMMENT ON COLUMN BARS.UR1.KV1 IS '';
COMMENT ON COLUMN BARS.UR1.NLSZ1 IS '';
COMMENT ON COLUMN BARS.UR1.KV2 IS '';
COMMENT ON COLUMN BARS.UR1.NLSZ2 IS '';
COMMENT ON COLUMN BARS.UR1.KV3 IS '';
COMMENT ON COLUMN BARS.UR1.NLSZ3 IS '';
COMMENT ON COLUMN BARS.UR1.ACCK IS '';
COMMENT ON COLUMN BARS.UR1.ACC1 IS '';
COMMENT ON COLUMN BARS.UR1.ACC2 IS '';
COMMENT ON COLUMN BARS.UR1.ACC3 IS '';



PROMPT *** Create  grants  UR1 ***
grant SELECT                                                                 on UR1             to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on UR1             to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on UR1             to START1;
grant SELECT                                                                 on UR1             to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/UR1.sql =========*** End *** =========
PROMPT ===================================================================================== 
