

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SW_OPERW.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SW_OPERW ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SW_OPERW'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''SW_OPERW'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''SW_OPERW'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SW_OPERW ***
begin 
  execute immediate '
  CREATE TABLE BARS.SW_OPERW 
   (	SWREF NUMBER(38,0), 
	TAG CHAR(2), 
	SEQ CHAR(1) DEFAULT ''A'', 
	N NUMBER(38,0) DEFAULT 0, 
	OPT CHAR(1), 
	VALUE VARCHAR2(1024), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SW_OPERW ***
 exec bpa.alter_policies('SW_OPERW');


COMMENT ON TABLE BARS.SW_OPERW IS 'SWT. Поля сообщений';
COMMENT ON COLUMN BARS.SW_OPERW.SWREF IS 'Референс сообщения';
COMMENT ON COLUMN BARS.SW_OPERW.TAG IS 'Код поля сообщения';
COMMENT ON COLUMN BARS.SW_OPERW.SEQ IS 'Код фрагмента сообщения';
COMMENT ON COLUMN BARS.SW_OPERW.N IS 'Порядковый номер поля в сообщении';
COMMENT ON COLUMN BARS.SW_OPERW.OPT IS 'Код опции поля';
COMMENT ON COLUMN BARS.SW_OPERW.VALUE IS 'Значение поля';
COMMENT ON COLUMN BARS.SW_OPERW.KF IS '';




PROMPT *** Create  constraint CC_SWOPERW_N ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_OPERW ADD CONSTRAINT CC_SWOPERW_N CHECK (n>=0) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SWOPERW ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_OPERW ADD CONSTRAINT PK_SWOPERW PRIMARY KEY (SWREF, N)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWOPERW_SWREF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_OPERW MODIFY (SWREF CONSTRAINT CC_SWOPERW_SWREF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWOPERW_TAG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_OPERW MODIFY (TAG CONSTRAINT CC_SWOPERW_TAG_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWOPERW_SEQ_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_OPERW MODIFY (SEQ CONSTRAINT CC_SWOPERW_SEQ_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWOPERW_N_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_OPERW MODIFY (N CONSTRAINT CC_SWOPERW_N_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWOPERW_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_OPERW MODIFY (KF CONSTRAINT CC_SWOPERW_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SWOPERW ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SWOPERW ON BARS.SW_OPERW (SWREF, N) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SW_OPERW ***
grant SELECT                                                                 on SW_OPERW        to BARS013;
grant SELECT                                                                 on SW_OPERW        to BARSREADER_ROLE;
grant SELECT                                                                 on SW_OPERW        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SW_OPERW        to BARS_DM;
grant SELECT                                                                 on SW_OPERW        to SWTOSS;
grant SELECT                                                                 on SW_OPERW        to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SW_OPERW        to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to SW_OPERW ***

  CREATE OR REPLACE PUBLIC SYNONYM SW_OPERW FOR BARS.SW_OPERW;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SW_OPERW.sql =========*** End *** ====
PROMPT ===================================================================================== 
