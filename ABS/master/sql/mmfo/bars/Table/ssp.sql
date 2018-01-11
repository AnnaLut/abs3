

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SSP.sql =========*** Run *** =========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SSP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SSP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SSP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SSP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SSP ***
begin 
  execute immediate '
  CREATE TABLE BARS.SSP 
   (	NLS VARCHAR2(14), 
	KV NUMBER(*,0), 
	R011 CHAR(1), 
	R013 CHAR(1), 
	S080 CHAR(1), 
	S180 CHAR(1), 
	S181 CHAR(1), 
	S190 CHAR(1), 
	S200 CHAR(1), 
	S230 CHAR(3), 
	S240 CHAR(1), 
	D020 CHAR(2), 
	ACC NUMBER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SSP ***
 exec bpa.alter_policies('SSP');


COMMENT ON TABLE BARS.SSP IS '';
COMMENT ON COLUMN BARS.SSP.NLS IS '';
COMMENT ON COLUMN BARS.SSP.KV IS '';
COMMENT ON COLUMN BARS.SSP.R011 IS '';
COMMENT ON COLUMN BARS.SSP.R013 IS '';
COMMENT ON COLUMN BARS.SSP.S080 IS '';
COMMENT ON COLUMN BARS.SSP.S180 IS '';
COMMENT ON COLUMN BARS.SSP.S181 IS '';
COMMENT ON COLUMN BARS.SSP.S190 IS '';
COMMENT ON COLUMN BARS.SSP.S200 IS '';
COMMENT ON COLUMN BARS.SSP.S230 IS '';
COMMENT ON COLUMN BARS.SSP.S240 IS '';
COMMENT ON COLUMN BARS.SSP.D020 IS '';
COMMENT ON COLUMN BARS.SSP.ACC IS '';



PROMPT *** Create  grants  SSP ***
grant SELECT                                                                 on SSP             to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SSP             to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SSP             to START1;
grant SELECT                                                                 on SSP             to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SSP.sql =========*** End *** =========
PROMPT ===================================================================================== 
