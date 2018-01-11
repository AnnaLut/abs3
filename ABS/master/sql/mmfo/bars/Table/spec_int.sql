

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SPEC_INT.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SPEC_INT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SPEC_INT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SPEC_INT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SPEC_INT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SPEC_INT ***
begin 
  execute immediate '
  CREATE TABLE BARS.SPEC_INT 
   (	KV NUMBER(*,0), 
	NLS VARCHAR2(14), 
	ACC NUMBER(10,0), 
	P080 CHAR(4), 
	OB22 CHAR(2), 
	MFO CHAR(6), 
	R020_FA CHAR(4)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SPEC_INT ***
 exec bpa.alter_policies('SPEC_INT');


COMMENT ON TABLE BARS.SPEC_INT IS '';
COMMENT ON COLUMN BARS.SPEC_INT.KV IS '';
COMMENT ON COLUMN BARS.SPEC_INT.NLS IS '';
COMMENT ON COLUMN BARS.SPEC_INT.ACC IS '';
COMMENT ON COLUMN BARS.SPEC_INT.P080 IS '';
COMMENT ON COLUMN BARS.SPEC_INT.OB22 IS '';
COMMENT ON COLUMN BARS.SPEC_INT.MFO IS '';
COMMENT ON COLUMN BARS.SPEC_INT.R020_FA IS '';



PROMPT *** Create  grants  SPEC_INT ***
grant SELECT                                                                 on SPEC_INT        to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SPEC_INT        to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SPEC_INT        to START1;
grant SELECT                                                                 on SPEC_INT        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SPEC_INT.sql =========*** End *** ====
PROMPT ===================================================================================== 
