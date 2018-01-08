

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/MV_WCS_SUR_GRP_QUEST_RELATION.sql ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to MV_WCS_SUR_GRP_QUEST_RELATION ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''MV_WCS_SUR_GRP_QUEST_RELATION'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''MV_WCS_SUR_GRP_QUEST_RELATION'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''MV_WCS_SUR_GRP_QUEST_RELATION'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table MV_WCS_SUR_GRP_QUEST_RELATION ***
begin 
  execute immediate '
  CREATE TABLE BARS.MV_WCS_SUR_GRP_QUEST_RELATION 
   (	SURVEY_ID VARCHAR2(100), 
	SGROUP_ID VARCHAR2(100), 
	QUESTION_ID VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to MV_WCS_SUR_GRP_QUEST_RELATION ***
 exec bpa.alter_policies('MV_WCS_SUR_GRP_QUEST_RELATION');


COMMENT ON COLUMN BARS.MV_WCS_SUR_GRP_QUEST_RELATION.SURVEY_ID IS 'Ідентифікатор анкети';
COMMENT ON COLUMN BARS.MV_WCS_SUR_GRP_QUEST_RELATION.SGROUP_ID IS 'Ідентифікатор групи';
COMMENT ON COLUMN BARS.MV_WCS_SUR_GRP_QUEST_RELATION.QUESTION_ID IS 'Ідентифікатор питання';



PROMPT *** Create  grants  MV_WCS_SUR_GRP_QUEST_RELATION ***
grant SELECT                                                                 on MV_WCS_SUR_GRP_QUEST_RELATION to BARSREADER_ROLE;
grant SELECT                                                                 on MV_WCS_SUR_GRP_QUEST_RELATION to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on MV_WCS_SUR_GRP_QUEST_RELATION to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/MV_WCS_SUR_GRP_QUEST_RELATION.sql ====
PROMPT ===================================================================================== 
