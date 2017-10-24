

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBUR_REF_STATUS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NBUR_REF_STATUS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBUR_REF_STATUS'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''NBUR_REF_STATUS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''NBUR_REF_STATUS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NBUR_REF_STATUS ***
begin 
  execute immediate '
  CREATE TABLE BARS.NBUR_REF_STATUS 
   (	STATUS_TYPE VARCHAR2(20), 
	DESCRIPTION VARCHAR2(100), 
	 CONSTRAINT PK_NBURREFSTATUST PRIMARY KEY (STATUS_TYPE) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSMDLI 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NBUR_REF_STATUS ***
 exec bpa.alter_policies('NBUR_REF_STATUS');


COMMENT ON TABLE BARS.NBUR_REF_STATUS IS 'Довідник типів статусів';
COMMENT ON COLUMN BARS.NBUR_REF_STATUS.STATUS_TYPE IS 'Статус';
COMMENT ON COLUMN BARS.NBUR_REF_STATUS.DESCRIPTION IS 'Опис';




PROMPT *** Create  constraint CC_REFSTATUS_STATUSTYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_REF_STATUS MODIFY (STATUS_TYPE CONSTRAINT CC_REFSTATUS_STATUSTYPE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_NBURREFSTATUST ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_REF_STATUS ADD CONSTRAINT PK_NBURREFSTATUST PRIMARY KEY (STATUS_TYPE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_REFSTATUS_DESCRIPTION_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_REF_STATUS MODIFY (DESCRIPTION CONSTRAINT CC_REFSTATUS_DESCRIPTION_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_NBURREFSTATUST ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_NBURREFSTATUST ON BARS.NBUR_REF_STATUS (STATUS_TYPE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NBUR_REF_STATUS ***
grant SELECT                                                                 on NBUR_REF_STATUS to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBUR_REF_STATUS.sql =========*** End *
PROMPT ===================================================================================== 
