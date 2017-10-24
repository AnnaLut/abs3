

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/MVW_WCS_SUR_GRP_QUEST_RELATION.sql ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to MVW_WCS_SUR_GRP_QUEST_RELATION ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''MVW_WCS_SUR_GRP_QUEST_RELATION'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''MVW_WCS_SUR_GRP_QUEST_RELATION'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table MVW_WCS_SUR_GRP_QUEST_RELATION ***
begin 
  execute immediate '
  CREATE TABLE BARS.MVW_WCS_SUR_GRP_QUEST_RELATION 
   (	SURVEY_ID VARCHAR2(100), 
	SGROUP_ID VARCHAR2(100), 
	QUESTION_ID VARCHAR2(100), 
	CQID VARCHAR2(100), 
	TYPE_ID VARCHAR2(100), 
	DNSHOW_IF VARCHAR2(4000), 
	TAB_NAME VARCHAR2(255), 
	SHOW_FIELDS VARCHAR2(255), 
	WHERE_CLAUSE VARCHAR2(4000), 
	HAS_REL NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to MVW_WCS_SUR_GRP_QUEST_RELATION ***
 exec bpa.alter_policies('MVW_WCS_SUR_GRP_QUEST_RELATION');


COMMENT ON COLUMN BARS.MVW_WCS_SUR_GRP_QUEST_RELATION.SURVEY_ID IS '';
COMMENT ON COLUMN BARS.MVW_WCS_SUR_GRP_QUEST_RELATION.SGROUP_ID IS '';
COMMENT ON COLUMN BARS.MVW_WCS_SUR_GRP_QUEST_RELATION.QUESTION_ID IS '';
COMMENT ON COLUMN BARS.MVW_WCS_SUR_GRP_QUEST_RELATION.CQID IS '';
COMMENT ON COLUMN BARS.MVW_WCS_SUR_GRP_QUEST_RELATION.TYPE_ID IS '';
COMMENT ON COLUMN BARS.MVW_WCS_SUR_GRP_QUEST_RELATION.DNSHOW_IF IS '';
COMMENT ON COLUMN BARS.MVW_WCS_SUR_GRP_QUEST_RELATION.TAB_NAME IS '';
COMMENT ON COLUMN BARS.MVW_WCS_SUR_GRP_QUEST_RELATION.SHOW_FIELDS IS '';
COMMENT ON COLUMN BARS.MVW_WCS_SUR_GRP_QUEST_RELATION.WHERE_CLAUSE IS '';
COMMENT ON COLUMN BARS.MVW_WCS_SUR_GRP_QUEST_RELATION.HAS_REL IS '';




PROMPT *** Create  constraint SYS_C003177457 ***
begin   
 execute immediate '
  ALTER TABLE BARS.MVW_WCS_SUR_GRP_QUEST_RELATION MODIFY (CQID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003177456 ***
begin   
 execute immediate '
  ALTER TABLE BARS.MVW_WCS_SUR_GRP_QUEST_RELATION MODIFY (QUESTION_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003177455 ***
begin   
 execute immediate '
  ALTER TABLE BARS.MVW_WCS_SUR_GRP_QUEST_RELATION MODIFY (SGROUP_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003177454 ***
begin   
 execute immediate '
  ALTER TABLE BARS.MVW_WCS_SUR_GRP_QUEST_RELATION MODIFY (SURVEY_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  MVW_WCS_SUR_GRP_QUEST_RELATION ***
grant SELECT                                                                 on MVW_WCS_SUR_GRP_QUEST_RELATION to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/MVW_WCS_SUR_GRP_QUEST_RELATION.sql ===
PROMPT ===================================================================================== 
