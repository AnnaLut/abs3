

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ACCM_QUEUE_CORRDOCS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ACCM_QUEUE_CORRDOCS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ACCM_QUEUE_CORRDOCS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ACCM_QUEUE_CORRDOCS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ACCM_QUEUE_CORRDOCS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ACCM_QUEUE_CORRDOCS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ACCM_QUEUE_CORRDOCS 
   (	REF NUMBER(38,0), 
	 CONSTRAINT PK_ACCMQUECRDOCS PRIMARY KEY (REF) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSDYNI 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ACCM_QUEUE_CORRDOCS ***
 exec bpa.alter_policies('ACCM_QUEUE_CORRDOCS');


COMMENT ON TABLE BARS.ACCM_QUEUE_CORRDOCS IS 'Подсистема накопления. Очередь синхронизации исправительных документов';
COMMENT ON COLUMN BARS.ACCM_QUEUE_CORRDOCS.REF IS 'Реф. документа';




PROMPT *** Create  constraint CC_ACCMQUECRDOCS_REF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_QUEUE_CORRDOCS MODIFY (REF CONSTRAINT CC_ACCMQUECRDOCS_REF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_ACCMQUECRDOCS ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_QUEUE_CORRDOCS ADD CONSTRAINT PK_ACCMQUECRDOCS PRIMARY KEY (REF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ACCMQUECRDOCS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ACCMQUECRDOCS ON BARS.ACCM_QUEUE_CORRDOCS (REF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ACCM_QUEUE_CORRDOCS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on ACCM_QUEUE_CORRDOCS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ACCM_QUEUE_CORRDOCS to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACCM_QUEUE_CORRDOCS to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ACCM_QUEUE_CORRDOCS.sql =========*** E
PROMPT ===================================================================================== 
