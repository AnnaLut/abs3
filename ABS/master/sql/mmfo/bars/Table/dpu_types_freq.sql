

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPU_TYPES_FREQ.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPU_TYPES_FREQ ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPU_TYPES_FREQ'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPU_TYPES_FREQ'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DPU_TYPES_FREQ'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPU_TYPES_FREQ ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPU_TYPES_FREQ 
   (	TYPE_ID NUMBER(38,0), 
	FREQ_ID NUMBER(3,0), 
	 CONSTRAINT PK_DPUTYPESFREQ PRIMARY KEY (TYPE_ID, FREQ_ID) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSSMLD 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPU_TYPES_FREQ ***
 exec bpa.alter_policies('DPU_TYPES_FREQ');


COMMENT ON TABLE BARS.DPU_TYPES_FREQ IS 'Періодичності виплати відсотків доступні депозитному продукту ЮО';
COMMENT ON COLUMN BARS.DPU_TYPES_FREQ.TYPE_ID IS 'Код продукту';
COMMENT ON COLUMN BARS.DPU_TYPES_FREQ.FREQ_ID IS 'Код періодичності виплати';




PROMPT *** Create  constraint CC_DPUTYPESFREQ_TYPEID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_TYPES_FREQ MODIFY (TYPE_ID CONSTRAINT CC_DPUTYPESFREQ_TYPEID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUTYPESFREQ_FREQID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_TYPES_FREQ MODIFY (FREQ_ID CONSTRAINT CC_DPUTYPESFREQ_FREQID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_DPUTYPESFREQ ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_TYPES_FREQ ADD CONSTRAINT PK_DPUTYPESFREQ PRIMARY KEY (TYPE_ID, FREQ_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPUTYPESFREQ ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPUTYPESFREQ ON BARS.DPU_TYPES_FREQ (TYPE_ID, FREQ_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPU_TYPES_FREQ ***
grant DELETE,INSERT,SELECT,UPDATE                                            on DPU_TYPES_FREQ  to ABS_ADMIN;
grant SELECT                                                                 on DPU_TYPES_FREQ  to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPU_TYPES_FREQ  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPU_TYPES_FREQ  to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPU_TYPES_FREQ  to DPT_ADMIN;
grant SELECT                                                                 on DPU_TYPES_FREQ  to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPU_TYPES_FREQ.sql =========*** End **
PROMPT ===================================================================================== 
