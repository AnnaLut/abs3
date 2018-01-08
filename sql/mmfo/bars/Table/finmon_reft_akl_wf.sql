

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FINMON_REFT_AKL_WF.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FINMON_REFT_AKL_WF ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FINMON_REFT_AKL_WF'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''FINMON_REFT_AKL_WF'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''FINMON_REFT_AKL_WF'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''FINMON_REFT_AKL_WF'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FINMON_REFT_AKL_WF ***
begin 
  execute immediate '
  CREATE TABLE BARS.FINMON_REFT_AKL_WF 
   (	ID NUMBER, 
	C1 NUMBER, 
	WORD_FORM VARCHAR2(350), 
	 CONSTRAINT PK_FINMON_REFT_AKL_WF PRIMARY KEY (ID, C1, WORD_FORM) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSMDLI 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FINMON_REFT_AKL_WF ***
 exec bpa.alter_policies('FINMON_REFT_AKL_WF');


COMMENT ON TABLE BARS.FINMON_REFT_AKL_WF IS '';
COMMENT ON COLUMN BARS.FINMON_REFT_AKL_WF.ID IS '';
COMMENT ON COLUMN BARS.FINMON_REFT_AKL_WF.C1 IS '';
COMMENT ON COLUMN BARS.FINMON_REFT_AKL_WF.WORD_FORM IS '';




PROMPT *** Create  constraint PK_FINMON_REFT_AKL_WF ***
begin   
 execute immediate '
  ALTER TABLE BARS.FINMON_REFT_AKL_WF ADD CONSTRAINT PK_FINMON_REFT_AKL_WF PRIMARY KEY (ID, C1, WORD_FORM)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_FINMON_REFT_AKL_WF_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.FINMON_REFT_AKL_WF ADD CONSTRAINT FK_FINMON_REFT_AKL_WF_ID FOREIGN KEY (ID)
	  REFERENCES BARS.FINMON_REFT_AKALIST (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_FINMON_REFT_AKL_WF_C1 ***
begin   
 execute immediate '
  ALTER TABLE BARS.FINMON_REFT_AKL_WF ADD CONSTRAINT FK_FINMON_REFT_AKL_WF_C1 FOREIGN KEY (C1)
	  REFERENCES BARS.FINMON_REFT (C1) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_FINMON_REFT_AKL_WF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_FINMON_REFT_AKL_WF ON BARS.FINMON_REFT_AKL_WF (ID, C1, WORD_FORM) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_FINMON_REFT_AKL_WF_2 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.I_FINMON_REFT_AKL_WF_2 ON BARS.FINMON_REFT_AKL_WF (WORD_FORM, C1, ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FINMON_REFT_AKL_WF ***
grant DELETE,INSERT,SELECT,UPDATE                                            on FINMON_REFT_AKL_WF to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FINMON_REFT_AKL_WF to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on FINMON_REFT_AKL_WF to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FINMON_REFT_AKL_WF.sql =========*** En
PROMPT ===================================================================================== 
