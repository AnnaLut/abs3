

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FIN_OBU_SCORING.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FIN_OBU_SCORING ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FIN_OBU_SCORING'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''FIN_OBU_SCORING'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''FIN_OBU_SCORING'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FIN_OBU_SCORING ***
begin 
  execute immediate '
  CREATE TABLE BARS.FIN_OBU_SCORING 
   (	ID VARCHAR2(1), 
	KOD VARCHAR2(4), 
	ORD NUMBER, 
	MIN_VAL NUMBER, 
	MIN_SIGN VARCHAR2(100), 
	MAX_VAL NUMBER, 
	MAX_SIGN VARCHAR2(100), 
	SCORE NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FIN_OBU_SCORING ***
 exec bpa.alter_policies('FIN_OBU_SCORING');


COMMENT ON TABLE BARS.FIN_OBU_SCORING IS 'Вопрос карты скоринга ';
COMMENT ON COLUMN BARS.FIN_OBU_SCORING.ID IS 'Идентификатор карты скоринга';
COMMENT ON COLUMN BARS.FIN_OBU_SCORING.KOD IS 'Идентификатор вопроса';
COMMENT ON COLUMN BARS.FIN_OBU_SCORING.ORD IS 'Номер отрезка';
COMMENT ON COLUMN BARS.FIN_OBU_SCORING.MIN_VAL IS 'Мин. значение отрезка';
COMMENT ON COLUMN BARS.FIN_OBU_SCORING.MIN_SIGN IS 'Знак мин. значения отрезка';
COMMENT ON COLUMN BARS.FIN_OBU_SCORING.MAX_VAL IS 'Макс. значение отрезка';
COMMENT ON COLUMN BARS.FIN_OBU_SCORING.MAX_SIGN IS 'Знак макс. значения отрезка';
COMMENT ON COLUMN BARS.FIN_OBU_SCORING.SCORE IS 'Баллы';
COMMENT ON COLUMN BARS.FIN_OBU_SCORING.KF IS '';




PROMPT *** Create  constraint CC_FINOBUSCOR_MINVAL_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_OBU_SCORING MODIFY (MIN_VAL CONSTRAINT CC_FINOBUSCOR_MINVAL_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FINOBUSCOR_MINSIGN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_OBU_SCORING MODIFY (MIN_SIGN CONSTRAINT CC_FINOBUSCOR_MINSIGN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FINOBUSCOR_MAXVAL_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_OBU_SCORING MODIFY (MAX_VAL CONSTRAINT CC_FINOBUSCOR_MAXVAL_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FINOBUSCOR_MAXSIGN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_OBU_SCORING MODIFY (MAX_SIGN CONSTRAINT CC_FINOBUSCOR_MAXSIGN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FINOBUSCOR_SCORE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_OBU_SCORING MODIFY (SCORE CONSTRAINT CC_FINOBUSCOR_SCORE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FINOBUSCORING_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_OBU_SCORING MODIFY (KF CONSTRAINT CC_FINOBUSCORING_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_FINOBUSCORING ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_FINOBUSCORING ON BARS.FIN_OBU_SCORING (ID, KOD, ORD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FIN_OBU_SCORING ***
grant SELECT                                                                 on FIN_OBU_SCORING to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on FIN_OBU_SCORING to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FIN_OBU_SCORING to BARS_DM;
grant SELECT                                                                 on FIN_OBU_SCORING to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FIN_OBU_SCORING.sql =========*** End *
PROMPT ===================================================================================== 
