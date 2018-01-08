

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/USSR_3301.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to USSR_3301 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''USSR_3301'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''USSR_3301'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''USSR_3301'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table USSR_3301 ***
begin 
  execute immediate '
  CREATE TABLE BARS.USSR_3301 
   (	REF NUMBER, 
	SUM_BLK NUMBER(24,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to USSR_3301 ***
 exec bpa.alter_policies('USSR_3301');


COMMENT ON TABLE BARS.USSR_3301 IS '';
COMMENT ON COLUMN BARS.USSR_3301.REF IS '';
COMMENT ON COLUMN BARS.USSR_3301.SUM_BLK IS '';



PROMPT *** Create  grants  USSR_3301 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on USSR_3301       to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on USSR_3301       to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/USSR_3301.sql =========*** End *** ===
PROMPT ===================================================================================== 
