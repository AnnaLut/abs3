

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_INDIVIDD.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_INDIVIDD ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_INDIVIDD'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_INDIVIDD'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_INDIVIDD'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_INDIVIDD ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_INDIVIDD 
   (	VIDD NUMBER, 
	DURATION_M NUMBER, 
	DURATION_D NUMBER, 
	KV NUMBER, 
	RATE NUMBER, 
	TAG CHAR(1), 
	VAL NUMBER, 
	DELTA NUMBER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_INDIVIDD ***
 exec bpa.alter_policies('DPT_INDIVIDD');


COMMENT ON TABLE BARS.DPT_INDIVIDD IS '';
COMMENT ON COLUMN BARS.DPT_INDIVIDD.VIDD IS '';
COMMENT ON COLUMN BARS.DPT_INDIVIDD.DURATION_M IS '';
COMMENT ON COLUMN BARS.DPT_INDIVIDD.DURATION_D IS '';
COMMENT ON COLUMN BARS.DPT_INDIVIDD.KV IS '';
COMMENT ON COLUMN BARS.DPT_INDIVIDD.RATE IS '';
COMMENT ON COLUMN BARS.DPT_INDIVIDD.TAG IS '';
COMMENT ON COLUMN BARS.DPT_INDIVIDD.VAL IS '';
COMMENT ON COLUMN BARS.DPT_INDIVIDD.DELTA IS '';



PROMPT *** Create  grants  DPT_INDIVIDD ***
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_INDIVIDD    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_INDIVIDD    to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_INDIVIDD    to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_INDIVIDD.sql =========*** End *** 
PROMPT ===================================================================================== 
