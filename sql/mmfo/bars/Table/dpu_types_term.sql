

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPU_TYPES_TERM.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPU_TYPES_TERM ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPU_TYPES_TERM'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPU_TYPES_TERM'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPU_TYPES_TERM ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPU_TYPES_TERM 
   (	TYPE_ID NUMBER(38,0), 
	TERM_ID NUMBER(6,4), 
	 CONSTRAINT PK_DPUTYPESTERM PRIMARY KEY (TYPE_ID, TERM_ID) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSSMLD 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPU_TYPES_TERM ***
 exec bpa.alter_policies('DPU_TYPES_TERM');


COMMENT ON TABLE BARS.DPU_TYPES_TERM IS 'Періодичності виплати відсотків доступні депозитному продукту ЮО';
COMMENT ON COLUMN BARS.DPU_TYPES_TERM.TYPE_ID IS 'Код продукту';
COMMENT ON COLUMN BARS.DPU_TYPES_TERM.TERM_ID IS 'Термін депозиту (місяців.днів)';




PROMPT *** Create  constraint CC_DPUTYPESTERM_TYPEID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_TYPES_TERM MODIFY (TYPE_ID CONSTRAINT CC_DPUTYPESTERM_TYPEID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUTYPESTERM_TERMID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_TYPES_TERM MODIFY (TERM_ID CONSTRAINT CC_DPUTYPESTERM_TERMID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_DPUTYPESTERM ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_TYPES_TERM ADD CONSTRAINT PK_DPUTYPESTERM PRIMARY KEY (TYPE_ID, TERM_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPUTYPESTERM ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPUTYPESTERM ON BARS.DPU_TYPES_TERM (TYPE_ID, TERM_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPU_TYPES_TERM ***
grant DELETE,INSERT,SELECT,UPDATE                                            on DPU_TYPES_TERM  to ABS_ADMIN;
grant SELECT                                                                 on DPU_TYPES_TERM  to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPU_TYPES_TERM  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPU_TYPES_TERM  to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPU_TYPES_TERM  to DPT_ADMIN;
grant SELECT                                                                 on DPU_TYPES_TERM  to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPU_TYPES_TERM.sql =========*** End **
PROMPT ===================================================================================== 
