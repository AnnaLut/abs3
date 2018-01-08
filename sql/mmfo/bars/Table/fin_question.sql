

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FIN_QUESTION.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FIN_QUESTION ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FIN_QUESTION'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''FIN_QUESTION'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''FIN_QUESTION'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FIN_QUESTION ***
begin 
  execute immediate '
  CREATE TABLE BARS.FIN_QUESTION 
   (	NAME VARCHAR2(254), 
	ORD NUMBER(*,0), 
	KOD VARCHAR2(4), 
	IDF NUMBER(*,0), 
	KOF NUMBER(38,2), 
	POB NUMBER(*,0) DEFAULT 0, 
	DESCRIPT VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FIN_QUESTION ***
 exec bpa.alter_policies('FIN_QUESTION');


COMMENT ON TABLE BARS.FIN_QUESTION IS 'Коди показників фінстану';
COMMENT ON COLUMN BARS.FIN_QUESTION.NAME IS 'Назва показника';
COMMENT ON COLUMN BARS.FIN_QUESTION.ORD IS '№ п/п';
COMMENT ON COLUMN BARS.FIN_QUESTION.KOD IS 'Код';
COMMENT ON COLUMN BARS.FIN_QUESTION.IDF IS 'Код групи';
COMMENT ON COLUMN BARS.FIN_QUESTION.KOF IS '';
COMMENT ON COLUMN BARS.FIN_QUESTION.POB IS 'Вирахування автоматичне чи ручне';
COMMENT ON COLUMN BARS.FIN_QUESTION.DESCRIPT IS 'Коментарій до питання';




PROMPT *** Create  constraint PK_FINQUESTION ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_QUESTION ADD CONSTRAINT PK_FINQUESTION PRIMARY KEY (KOD, IDF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FIN_QUESTION_KOD ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_QUESTION MODIFY (KOD CONSTRAINT CC_FIN_QUESTION_KOD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FIN_QUESTION_IDF ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_QUESTION MODIFY (IDF CONSTRAINT CC_FIN_QUESTION_IDF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_FINQUESTION ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_FINQUESTION ON BARS.FIN_QUESTION (KOD, IDF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FIN_QUESTION ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on FIN_QUESTION    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FIN_QUESTION    to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FIN_QUESTION.sql =========*** End *** 
PROMPT ===================================================================================== 
