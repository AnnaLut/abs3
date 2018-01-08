

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FIN_NBU_SCORING.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FIN_NBU_SCORING ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FIN_NBU_SCORING'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''FIN_NBU_SCORING'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FIN_NBU_SCORING ***
begin 
  execute immediate '
  CREATE TABLE BARS.FIN_NBU_SCORING 
   (	ID VARCHAR2(1), 
	FM CHAR(1), 
	KOD VARCHAR2(4), 
	ORD NUMBER, 
	MIN_VAL NUMBER, 
	MIN_SIGN VARCHAR2(100), 
	MAX_VAL NUMBER, 
	MAX_SIGN VARCHAR2(100), 
	SCORE NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FIN_NBU_SCORING ***
 exec bpa.alter_policies('FIN_NBU_SCORING');


COMMENT ON TABLE BARS.FIN_NBU_SCORING IS 'Вопрос карты скоринга ';
COMMENT ON COLUMN BARS.FIN_NBU_SCORING.ID IS 'Идентификатор карты скоринга';
COMMENT ON COLUMN BARS.FIN_NBU_SCORING.FM IS '';
COMMENT ON COLUMN BARS.FIN_NBU_SCORING.KOD IS 'Идентификатор вопроса';
COMMENT ON COLUMN BARS.FIN_NBU_SCORING.ORD IS 'Номер отрезка';
COMMENT ON COLUMN BARS.FIN_NBU_SCORING.MIN_VAL IS 'Мин. значение отрезка';
COMMENT ON COLUMN BARS.FIN_NBU_SCORING.MIN_SIGN IS 'Знак мин. значения отрезка';
COMMENT ON COLUMN BARS.FIN_NBU_SCORING.MAX_VAL IS 'Макс. значение отрезка';
COMMENT ON COLUMN BARS.FIN_NBU_SCORING.MAX_SIGN IS 'Знак макс. значения отрезка';
COMMENT ON COLUMN BARS.FIN_NBU_SCORING.SCORE IS 'Баллы';




PROMPT *** Create  constraint CC_FINNBUSCOR_FM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_NBU_SCORING MODIFY (FM CONSTRAINT CC_FINNBUSCOR_FM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FINNBUSCOR_MINVAL_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_NBU_SCORING MODIFY (MIN_VAL CONSTRAINT CC_FINNBUSCOR_MINVAL_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FINNBUSCOR_MINSIGN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_NBU_SCORING MODIFY (MIN_SIGN CONSTRAINT CC_FINNBUSCOR_MINSIGN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FINSNBUCOR_MAXVAL_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_NBU_SCORING MODIFY (MAX_VAL CONSTRAINT CC_FINSNBUCOR_MAXVAL_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FINNBUSCOR_MAXSIGN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_NBU_SCORING MODIFY (MAX_SIGN CONSTRAINT CC_FINNBUSCOR_MAXSIGN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FINNBUSCOR_SCORE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_NBU_SCORING MODIFY (SCORE CONSTRAINT CC_FINNBUSCOR_SCORE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_FINNBUSCOR ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_NBU_SCORING ADD CONSTRAINT PK_FINNBUSCOR PRIMARY KEY (ID, FM, KOD, ORD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_FINNBUSCOR ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_FINNBUSCOR ON BARS.FIN_NBU_SCORING (ID, FM, KOD, ORD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FIN_NBU_SCORING ***
grant SELECT                                                                 on FIN_NBU_SCORING to BARSREADER_ROLE;
grant DELETE,FLASHBACK,UPDATE                                                on FIN_NBU_SCORING to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FIN_NBU_SCORING to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FIN_NBU_SCORING.sql =========*** End *
PROMPT ===================================================================================== 
