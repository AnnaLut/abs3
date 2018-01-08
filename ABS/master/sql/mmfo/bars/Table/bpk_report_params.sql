

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BPK_REPORT_PARAMS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BPK_REPORT_PARAMS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BPK_REPORT_PARAMS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BPK_REPORT_PARAMS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''BPK_REPORT_PARAMS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BPK_REPORT_PARAMS ***
begin 
  execute immediate '
  CREATE TABLE BARS.BPK_REPORT_PARAMS 
   (	CODE VARCHAR2(20), 
	NAME VARCHAR2(100), 
	SRC VARCHAR2(100), 
	TYPE VARCHAR2(1) DEFAULT ''C''
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BPK_REPORT_PARAMS ***
 exec bpa.alter_policies('BPK_REPORT_PARAMS');


COMMENT ON TABLE BARS.BPK_REPORT_PARAMS IS 'БПК. Довідник параметрів звіту';
COMMENT ON COLUMN BARS.BPK_REPORT_PARAMS.CODE IS 'Код параметру';
COMMENT ON COLUMN BARS.BPK_REPORT_PARAMS.NAME IS 'Назва';
COMMENT ON COLUMN BARS.BPK_REPORT_PARAMS.SRC IS 'Ресурс';
COMMENT ON COLUMN BARS.BPK_REPORT_PARAMS.TYPE IS 'Тип параметра';




PROMPT *** Create  constraint PK_SBPKREPORTPARAMS ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_REPORT_PARAMS ADD CONSTRAINT PK_SBPKREPORTPARAMS PRIMARY KEY (CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BPKREPORTPARAMS_TYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_REPORT_PARAMS ADD CONSTRAINT CC_BPKREPORTPARAMS_TYPE CHECK (type in (''C'',''N'')) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BPKREPORTPARAMS_CODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_REPORT_PARAMS MODIFY (CODE CONSTRAINT CC_BPKREPORTPARAMS_CODE_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BPKREPORTPARAMS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BPKREPORTPARAMS ON BARS.BPK_REPORT_PARAMS (CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BPK_REPORT_PARAMS ***
grant SELECT                                                                 on BPK_REPORT_PARAMS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BPK_REPORT_PARAMS to BARS_DM;
grant SELECT                                                                 on BPK_REPORT_PARAMS to OBPC;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BPK_REPORT_PARAMS.sql =========*** End
PROMPT ===================================================================================== 
