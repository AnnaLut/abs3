

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/USSR_ERR_REF1_STORNO.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to USSR_ERR_REF1_STORNO ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''USSR_ERR_REF1_STORNO'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''USSR_ERR_REF1_STORNO'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''USSR_ERR_REF1_STORNO'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table USSR_ERR_REF1_STORNO ***
begin 
  execute immediate '
  CREATE TABLE BARS.USSR_ERR_REF1_STORNO 
   (	REF NUMBER(38,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to USSR_ERR_REF1_STORNO ***
 exec bpa.alter_policies('USSR_ERR_REF1_STORNO');


COMMENT ON TABLE BARS.USSR_ERR_REF1_STORNO IS '';
COMMENT ON COLUMN BARS.USSR_ERR_REF1_STORNO.REF IS '';




PROMPT *** Create  constraint SYS_C005724 ***
begin   
 execute immediate '
  ALTER TABLE BARS.USSR_ERR_REF1_STORNO MODIFY (REF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  USSR_ERR_REF1_STORNO ***
grant SELECT                                                                 on USSR_ERR_REF1_STORNO to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on USSR_ERR_REF1_STORNO to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on USSR_ERR_REF1_STORNO to START1;
grant SELECT                                                                 on USSR_ERR_REF1_STORNO to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/USSR_ERR_REF1_STORNO.sql =========*** 
PROMPT ===================================================================================== 
