

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OPERW.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OPERW ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OPERW'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''OPERW'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OPERW ***
begin 
  execute immediate '
  CREATE TABLE BARS.OPERW 
   (	REF NUMBER(38,0), 
	TAG CHAR(5), 
	VALUE VARCHAR2(220), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OPERW ***
 exec bpa.alter_policies('OPERW');


COMMENT ON TABLE BARS.OPERW IS 'Хранилище реквизитов документов';
COMMENT ON COLUMN BARS.OPERW.REF IS 'Внутренний номер документа';
COMMENT ON COLUMN BARS.OPERW.TAG IS 'Код реквизита';
COMMENT ON COLUMN BARS.OPERW.VALUE IS 'Значение реквизита';
COMMENT ON COLUMN BARS.OPERW.KF IS '';




PROMPT *** Create  constraint FK_OPERW_OPER2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPERW ADD CONSTRAINT FK_OPERW_OPER2 FOREIGN KEY (KF, REF)
	  REFERENCES BARS.OPER (KF, REF) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OPERW_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPERW ADD CONSTRAINT FK_OPERW_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OPERW_OPFIELD ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPERW ADD CONSTRAINT FK_OPERW_OPFIELD FOREIGN KEY (TAG)
	  REFERENCES BARS.OP_FIELD (TAG) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_OPERW ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPERW ADD CONSTRAINT PK_OPERW PRIMARY KEY (REF, TAG)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OPERW_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPERW MODIFY (KF CONSTRAINT CC_OPERW_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OPERW_TAG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPERW MODIFY (TAG CONSTRAINT CC_OPERW_TAG_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OPERW_REF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPERW MODIFY (REF CONSTRAINT CC_OPERW_REF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OPERW ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OPERW ON BARS.OPERW (REF, TAG) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OPERW ***
grant DELETE,INSERT,SELECT,UPDATE                                            on OPERW           to ABS_ADMIN;
grant FLASHBACK,INSERT,REFERENCES,SELECT,UPDATE                              on OPERW           to BARSAQ with grant option;
grant INSERT,REFERENCES,SELECT                                               on OPERW           to BARSAQ_ADM with grant option;
grant SELECT                                                                 on OPERW           to BARSUPL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OPERW           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OPERW           to BARS_SUP;
grant INSERT                                                                 on OPERW           to CHCK;
grant DELETE,UPDATE                                                          on OPERW           to CP_ROLE;
grant SELECT                                                                 on OPERW           to FINMON01;
grant INSERT                                                                 on OPERW           to FOREX;
grant SELECT                                                                 on OPERW           to OBPC;
grant INSERT                                                                 on OPERW           to PYOD001;
grant INSERT                                                                 on OPERW           to RCC_DEAL;
grant SELECT                                                                 on OPERW           to RPBN001;
grant DELETE,INSERT,SELECT,UPDATE                                            on OPERW           to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OPERW           to WR_ALL_RIGHTS;
grant SELECT                                                                 on OPERW           to WR_DOCVIEW;
grant INSERT                                                                 on OPERW           to WR_DOC_INPUT;
grant FLASHBACK,SELECT                                                       on OPERW           to WR_REFREAD;
grant INSERT                                                                 on OPERW           to ZAY;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OPERW.sql =========*** End *** =======
PROMPT ===================================================================================== 
