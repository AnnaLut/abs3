

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SSR_TMP_COUNT.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SSR_TMP_COUNT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SSR_TMP_COUNT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SSR_TMP_COUNT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SSR_TMP_COUNT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SSR_TMP_COUNT ***
begin 
  execute immediate '
  CREATE TABLE BARS.SSR_TMP_COUNT 
   (	FDAT DATE, 
	SOS5 NUMBER, 
	SOS1 NUMBER, 
	SOS3 NUMBER, 
	MFO NUMBER, 
	NLS NUMBER, 
	KV NVARCHAR2(3), 
	S NUMBER(*,0), 
	S1 NUMBER(*,0), 
	S3 NUMBER(*,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SSR_TMP_COUNT ***
 exec bpa.alter_policies('SSR_TMP_COUNT');


COMMENT ON TABLE BARS.SSR_TMP_COUNT IS '';
COMMENT ON COLUMN BARS.SSR_TMP_COUNT.FDAT IS '';
COMMENT ON COLUMN BARS.SSR_TMP_COUNT.SOS5 IS '';
COMMENT ON COLUMN BARS.SSR_TMP_COUNT.SOS1 IS '';
COMMENT ON COLUMN BARS.SSR_TMP_COUNT.SOS3 IS '';
COMMENT ON COLUMN BARS.SSR_TMP_COUNT.MFO IS '';
COMMENT ON COLUMN BARS.SSR_TMP_COUNT.NLS IS '';
COMMENT ON COLUMN BARS.SSR_TMP_COUNT.KV IS '';
COMMENT ON COLUMN BARS.SSR_TMP_COUNT.S IS '';
COMMENT ON COLUMN BARS.SSR_TMP_COUNT.S1 IS '';
COMMENT ON COLUMN BARS.SSR_TMP_COUNT.S3 IS '';




PROMPT *** Create  constraint SYS_C009050 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SSR_TMP_COUNT MODIFY (FDAT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009051 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SSR_TMP_COUNT MODIFY (MFO NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009052 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SSR_TMP_COUNT MODIFY (NLS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SSR_TMP_COUNT ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SSR_TMP_COUNT   to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SSR_TMP_COUNT   to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SSR_TMP_COUNT.sql =========*** End ***
PROMPT ===================================================================================== 
