

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_ATTRIBUTE_T.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_ATTRIBUTE_T ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_ATTRIBUTE_T'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_ATTRIBUTE_T'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_ATTRIBUTE_T'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_ATTRIBUTE_T ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_ATTRIBUTE_T 
   (	ATTR_ID NUMBER(38,0), 
	ATTR_NAME VARCHAR2(128), 
	COMMENTS VARCHAR2(128)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_ATTRIBUTE_T ***
 exec bpa.alter_policies('DPT_ATTRIBUTE_T');


COMMENT ON TABLE BARS.DPT_ATTRIBUTE_T IS '';
COMMENT ON COLUMN BARS.DPT_ATTRIBUTE_T.ATTR_ID IS '';
COMMENT ON COLUMN BARS.DPT_ATTRIBUTE_T.ATTR_NAME IS '';
COMMENT ON COLUMN BARS.DPT_ATTRIBUTE_T.COMMENTS IS '';




PROMPT *** Create  constraint SYS_C007363 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_ATTRIBUTE_T MODIFY (ATTR_NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_ATTRIBUTE_T ***
grant SELECT                                                                 on DPT_ATTRIBUTE_T to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_ATTRIBUTE_T to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_ATTRIBUTE_T to BARS_DM;
grant SELECT                                                                 on DPT_ATTRIBUTE_T to UPLD;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_ATTRIBUTE_T to VKLAD;
grant FLASHBACK,SELECT                                                       on DPT_ATTRIBUTE_T to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_ATTRIBUTE_T.sql =========*** End *
PROMPT ===================================================================================== 
