

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_VIDD_FIELD.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_VIDD_FIELD ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_VIDD_FIELD'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_VIDD_FIELD'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''DPT_VIDD_FIELD'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_VIDD_FIELD ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_VIDD_FIELD 
   (	TAG CHAR(5), 
	VIDD NUMBER(38,0), 
	OBZ NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 5 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_VIDD_FIELD ***
 exec bpa.alter_policies('DPT_VIDD_FIELD');


COMMENT ON TABLE BARS.DPT_VIDD_FIELD IS 'Допустимые доп.реквизиты для видов вкладов';
COMMENT ON COLUMN BARS.DPT_VIDD_FIELD.TAG IS 'Код реквизита';
COMMENT ON COLUMN BARS.DPT_VIDD_FIELD.VIDD IS 'Код вида вклада';
COMMENT ON COLUMN BARS.DPT_VIDD_FIELD.OBZ IS 'Признак обязательности';




PROMPT *** Create  constraint PK_DPTVIDDFIELD ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_FIELD ADD CONSTRAINT PK_DPTVIDDFIELD PRIMARY KEY (TAG, VIDD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDDFIELD_OBZ ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_FIELD ADD CONSTRAINT CC_DPTVIDDFIELD_OBZ CHECK (obz in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTVIDDFIELD_DPTVIDD ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_FIELD ADD CONSTRAINT FK_DPTVIDDFIELD_DPTVIDD FOREIGN KEY (VIDD)
	  REFERENCES BARS.DPT_VIDD (VIDD) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTVIDDFIELD_DPTFIELD ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_FIELD ADD CONSTRAINT FK_DPTVIDDFIELD_DPTFIELD FOREIGN KEY (TAG)
	  REFERENCES BARS.DPT_FIELD (TAG) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDDFIELD_TAG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_FIELD MODIFY (TAG CONSTRAINT CC_DPTVIDDFIELD_TAG_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDDFIELD_VIDD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_FIELD MODIFY (VIDD CONSTRAINT CC_DPTVIDDFIELD_VIDD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPTVIDDFIELD ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPTVIDDFIELD ON BARS.DPT_VIDD_FIELD (TAG, VIDD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_VIDD_FIELD ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_VIDD_FIELD  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_VIDD_FIELD  to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_VIDD_FIELD  to DPT_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_VIDD_FIELD  to DPT_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_VIDD_FIELD  to VKLAD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_VIDD_FIELD  to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on DPT_VIDD_FIELD  to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_VIDD_FIELD.sql =========*** End **
PROMPT ===================================================================================== 
