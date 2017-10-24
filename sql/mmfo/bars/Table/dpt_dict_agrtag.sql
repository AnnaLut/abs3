

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_DICT_AGRTAG.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_DICT_AGRTAG ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_DICT_AGRTAG'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_DICT_AGRTAG'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_DICT_AGRTAG'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_DICT_AGRTAG ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_DICT_AGRTAG 
   (	TAG_ID NUMBER, 
	TAG_NAME VARCHAR2(25), 
	TAG_COMMENT VARCHAR2(100)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYNI ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_DICT_AGRTAG ***
 exec bpa.alter_policies('DPT_DICT_AGRTAG');


COMMENT ON TABLE BARS.DPT_DICT_AGRTAG IS '';
COMMENT ON COLUMN BARS.DPT_DICT_AGRTAG.TAG_ID IS '';
COMMENT ON COLUMN BARS.DPT_DICT_AGRTAG.TAG_NAME IS '';
COMMENT ON COLUMN BARS.DPT_DICT_AGRTAG.TAG_COMMENT IS '';




PROMPT *** Create  constraint DPT_DICT_AGRTAG_PK ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DICT_AGRTAG ADD CONSTRAINT DPT_DICT_AGRTAG_PK PRIMARY KEY (TAG_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006395 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DICT_AGRTAG MODIFY (TAG_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index DPT_DICT_AGRTAG_PK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.DPT_DICT_AGRTAG_PK ON BARS.DPT_DICT_AGRTAG (TAG_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_DICT_AGRTAG ***
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on DPT_DICT_AGRTAG to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_DICT_AGRTAG to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_DICT_AGRTAG.sql =========*** End *
PROMPT ===================================================================================== 
