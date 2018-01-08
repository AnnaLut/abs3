

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_DICT_TRUSTYOPTIONS.sql =========**
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_DICT_TRUSTYOPTIONS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_DICT_TRUSTYOPTIONS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_DICT_TRUSTYOPTIONS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_DICT_TRUSTYOPTIONS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_DICT_TRUSTYOPTIONS ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_DICT_TRUSTYOPTIONS 
   (	ID_OPTION NUMBER, 
	NAME_OPTION VARCHAR2(50), 
	TYPE_OPTION NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYNI ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_DICT_TRUSTYOPTIONS ***
 exec bpa.alter_policies('DPT_DICT_TRUSTYOPTIONS');


COMMENT ON TABLE BARS.DPT_DICT_TRUSTYOPTIONS IS '';
COMMENT ON COLUMN BARS.DPT_DICT_TRUSTYOPTIONS.ID_OPTION IS '';
COMMENT ON COLUMN BARS.DPT_DICT_TRUSTYOPTIONS.NAME_OPTION IS '';
COMMENT ON COLUMN BARS.DPT_DICT_TRUSTYOPTIONS.TYPE_OPTION IS '';




PROMPT *** Create  constraint DPT_DICT_TRUSTYOPTIONS_PK ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DICT_TRUSTYOPTIONS ADD CONSTRAINT DPT_DICT_TRUSTYOPTIONS_PK PRIMARY KEY (ID_OPTION)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C004918 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DICT_TRUSTYOPTIONS MODIFY (ID_OPTION NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index DPT_DICT_TRUSTYOPTIONS_PK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.DPT_DICT_TRUSTYOPTIONS_PK ON BARS.DPT_DICT_TRUSTYOPTIONS (ID_OPTION) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_DICT_TRUSTYOPTIONS ***
grant SELECT                                                                 on DPT_DICT_TRUSTYOPTIONS to BARSREADER_ROLE;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on DPT_DICT_TRUSTYOPTIONS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_DICT_TRUSTYOPTIONS to BARS_DM;
grant SELECT                                                                 on DPT_DICT_TRUSTYOPTIONS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_DICT_TRUSTYOPTIONS.sql =========**
PROMPT ===================================================================================== 
