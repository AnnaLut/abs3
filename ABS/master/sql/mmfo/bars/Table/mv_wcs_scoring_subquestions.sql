

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/MV_WCS_SCORING_SUBQUESTIONS.sql ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to MV_WCS_SCORING_SUBQUESTIONS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''MV_WCS_SCORING_SUBQUESTIONS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''MV_WCS_SCORING_SUBQUESTIONS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''MV_WCS_SCORING_SUBQUESTIONS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table MV_WCS_SCORING_SUBQUESTIONS ***
begin 
  execute immediate '
  CREATE TABLE BARS.MV_WCS_SCORING_SUBQUESTIONS 
   (	SCORING_ID VARCHAR2(100), 
	QUESTION_ID VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to MV_WCS_SCORING_SUBQUESTIONS ***
 exec bpa.alter_policies('MV_WCS_SCORING_SUBQUESTIONS');


COMMENT ON COLUMN BARS.MV_WCS_SCORING_SUBQUESTIONS.SCORING_ID IS 'Ідентифікатор скоринговоъ карти';
COMMENT ON COLUMN BARS.MV_WCS_SCORING_SUBQUESTIONS.QUESTION_ID IS 'Ідентифікатор питання';



PROMPT *** Create  grants  MV_WCS_SCORING_SUBQUESTIONS ***
grant SELECT                                                                 on MV_WCS_SCORING_SUBQUESTIONS to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/MV_WCS_SCORING_SUBQUESTIONS.sql ======
PROMPT ===================================================================================== 
