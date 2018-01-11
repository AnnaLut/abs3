

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CC_PR_TR.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CC_PR_TR ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CC_PR_TR'', ''CENTER'' , ''C'', ''C'', ''C'', null);
               bpa.alter_policy_info(''CC_PR_TR'', ''WHOLE'' , ''C'', ''C'', ''C'', null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CC_PR_TR ***
begin 
  execute immediate '
  CREATE TABLE BARS.CC_PR_TR 
   (	ID_PR NUMBER(15,0), 
	NAME VARCHAR2(50)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CC_PR_TR ***
 exec bpa.alter_policies('CC_PR_TR');


COMMENT ON TABLE BARS.CC_PR_TR IS 'Справочник видов КД (транши)<p align="right"></p>';
COMMENT ON COLUMN BARS.CC_PR_TR.ID_PR IS 'Код вида';
COMMENT ON COLUMN BARS.CC_PR_TR.NAME IS 'Наименование вида';




PROMPT *** Create  index PK_CCPRTR ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CCPRTR ON BARS.CC_PR_TR (ID_PR) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CC_PR_TR ***
grant SELECT                                                                 on CC_PR_TR        to BARSREADER_ROLE;
grant SELECT                                                                 on CC_PR_TR        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_PR_TR        to BARS_DM;
grant SELECT                                                                 on CC_PR_TR        to RCC_DEAL;
grant SELECT                                                                 on CC_PR_TR        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CC_PR_TR.sql =========*** End *** ====
PROMPT ===================================================================================== 
