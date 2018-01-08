

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NLK_REF_HIST.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NLK_REF_HIST ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NLK_REF_HIST'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''NLK_REF_HIST'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NLK_REF_HIST ***
begin 
  execute immediate '
  CREATE TABLE BARS.NLK_REF_HIST 
   (	REF1 NUMBER(38,0), 
	REF2 NUMBER(38,0), 
	ACC NUMBER(38,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	AMOUNT NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NLK_REF_HIST ***
 exec bpa.alter_policies('NLK_REF_HIST');


COMMENT ON TABLE BARS.NLK_REF_HIST IS 'Картотека кредитовых поступлений';
COMMENT ON COLUMN BARS.NLK_REF_HIST.REF1 IS 'Референс начального документа';
COMMENT ON COLUMN BARS.NLK_REF_HIST.REF2 IS 'Референс перекредитованного документа';
COMMENT ON COLUMN BARS.NLK_REF_HIST.ACC IS 'Идентификатор счета картотеки';
COMMENT ON COLUMN BARS.NLK_REF_HIST.KF IS '';
COMMENT ON COLUMN BARS.NLK_REF_HIST.AMOUNT IS 'Cуми транзакції по реф.';




PROMPT *** Create  constraint PK_NLKREFHIST ***
begin   
 execute immediate '
  ALTER TABLE BARS.NLK_REF_HIST ADD CONSTRAINT PK_NLKREFHIST PRIMARY KEY (REF1, REF2, KF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_NLKREFHIST ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_NLKREFHIST ON BARS.NLK_REF_HIST (REF1, REF2, KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_NLKREFHIST ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_NLKREFHIST ON BARS.NLK_REF_HIST (ACC, REF1) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NLK_REF_HIST ***
grant DELETE,INSERT,SELECT,UPDATE                                            on NLK_REF_HIST    to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NLK_REF_HIST.sql =========*** End *** 
PROMPT ===================================================================================== 
