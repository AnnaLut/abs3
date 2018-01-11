

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/INT15_LOG.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to INT15_LOG ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''INT15_LOG'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''INT15_LOG'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''INT15_LOG'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table INT15_LOG ***
begin 
  execute immediate '
  CREATE TABLE BARS.INT15_LOG 
   (	REF NUMBER, 
	DAT DATE, 
	S NUMBER, 
	KV NUMBER, 
	S_TAX NUMBER, 
	MESS VARCHAR2(500)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to INT15_LOG ***
 exec bpa.alter_policies('INT15_LOG');


COMMENT ON TABLE BARS.INT15_LOG IS '';
COMMENT ON COLUMN BARS.INT15_LOG.REF IS '';
COMMENT ON COLUMN BARS.INT15_LOG.DAT IS '';
COMMENT ON COLUMN BARS.INT15_LOG.S IS '';
COMMENT ON COLUMN BARS.INT15_LOG.KV IS '';
COMMENT ON COLUMN BARS.INT15_LOG.S_TAX IS '';
COMMENT ON COLUMN BARS.INT15_LOG.MESS IS '';



PROMPT *** Create  grants  INT15_LOG ***
grant SELECT                                                                 on INT15_LOG       to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on INT15_LOG       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on INT15_LOG       to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on INT15_LOG       to START1;
grant SELECT                                                                 on INT15_LOG       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/INT15_LOG.sql =========*** End *** ===
PROMPT ===================================================================================== 
