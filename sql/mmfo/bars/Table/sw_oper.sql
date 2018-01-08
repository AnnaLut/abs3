

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SW_OPER.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SW_OPER ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SW_OPER'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''SW_OPER'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''SW_OPER'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SW_OPER ***
begin 
  execute immediate '
  CREATE TABLE BARS.SW_OPER 
   (	REF NUMBER(38,0), 
	SWREF NUMBER(38,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	SWRNUM NUMBER(10,0), 
	 CONSTRAINT PK_SWOPER PRIMARY KEY (REF, SWREF) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSMDLI 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SW_OPER ***
 exec bpa.alter_policies('SW_OPER');


COMMENT ON TABLE BARS.SW_OPER IS 'SWT. Связь сообщений и документов';
COMMENT ON COLUMN BARS.SW_OPER.REF IS 'Референс документа';
COMMENT ON COLUMN BARS.SW_OPER.SWREF IS 'Референс сообщения';
COMMENT ON COLUMN BARS.SW_OPER.KF IS '';
COMMENT ON COLUMN BARS.SW_OPER.SWRNUM IS '';




PROMPT *** Create  constraint FK_SWOPER_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_OPER ADD CONSTRAINT FK_SWOPER_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SWOPER_SWJOURNAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_OPER ADD CONSTRAINT FK_SWOPER_SWJOURNAL FOREIGN KEY (SWREF)
	  REFERENCES BARS.SW_JOURNAL (SWREF) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWOPER_REF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_OPER MODIFY (REF CONSTRAINT CC_SWOPER_REF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWOPER_SWREF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_OPER MODIFY (SWREF CONSTRAINT CC_SWOPER_SWREF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWOPER_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_OPER MODIFY (KF CONSTRAINT CC_SWOPER_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SWOPER ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_OPER ADD CONSTRAINT PK_SWOPER PRIMARY KEY (REF, SWREF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SWOPER ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SWOPER ON BARS.SW_OPER (REF, SWREF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_SWREF ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_SWREF ON BARS.SW_OPER (SWREF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SW_OPER ***
grant INSERT,SELECT,UPDATE                                                   on SW_OPER         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SW_OPER         to START1;
grant SELECT                                                                 on SW_OPER         to SWTOSS;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SW_OPER         to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to SW_OPER ***

  CREATE OR REPLACE PUBLIC SYNONYM SW_OPER FOR BARS.SW_OPER;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SW_OPER.sql =========*** End *** =====
PROMPT ===================================================================================== 
