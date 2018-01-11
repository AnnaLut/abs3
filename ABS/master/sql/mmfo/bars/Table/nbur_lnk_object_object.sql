

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBUR_LNK_OBJECT_OBJECT.sql =========**
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NBUR_LNK_OBJECT_OBJECT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBUR_LNK_OBJECT_OBJECT'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''NBUR_LNK_OBJECT_OBJECT'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''NBUR_LNK_OBJECT_OBJECT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NBUR_LNK_OBJECT_OBJECT ***
begin 
  execute immediate '
  CREATE TABLE BARS.NBUR_LNK_OBJECT_OBJECT 
   (	OBJECT_ID NUMBER(38,0), 
	OBJECT_PID NUMBER(38,0), 
	 CONSTRAINT PK_OBJDEPENDENCIES PRIMARY KEY (OBJECT_ID, OBJECT_PID) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSMDLI 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NBUR_LNK_OBJECT_OBJECT ***
 exec bpa.alter_policies('NBUR_LNK_OBJECT_OBJECT');


COMMENT ON TABLE BARS.NBUR_LNK_OBJECT_OBJECT IS 'Довідник залежностей об`єктів';
COMMENT ON COLUMN BARS.NBUR_LNK_OBJECT_OBJECT.OBJECT_ID IS 'Object identifier';
COMMENT ON COLUMN BARS.NBUR_LNK_OBJECT_OBJECT.OBJECT_PID IS 'Parent object identifier';




PROMPT *** Create  constraint CC_OBJDEPENDENCIES_OBJID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_LNK_OBJECT_OBJECT MODIFY (OBJECT_ID CONSTRAINT CC_OBJDEPENDENCIES_OBJID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OBJDEPENDENCIES_OBJPID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_LNK_OBJECT_OBJECT MODIFY (OBJECT_PID CONSTRAINT CC_OBJDEPENDENCIES_OBJPID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OBJDEPENDENCIES_ID_PID ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_LNK_OBJECT_OBJECT ADD CONSTRAINT CC_OBJDEPENDENCIES_ID_PID CHECK ( OBJECT_ID <> OBJECT_PID ) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_OBJDEPENDENCIES ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_LNK_OBJECT_OBJECT ADD CONSTRAINT PK_OBJDEPENDENCIES PRIMARY KEY (OBJECT_ID, OBJECT_PID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OBJDEPENDENCIES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OBJDEPENDENCIES ON BARS.NBUR_LNK_OBJECT_OBJECT (OBJECT_ID, OBJECT_PID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_OBJDEPENDENCIES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_OBJDEPENDENCIES ON BARS.NBUR_LNK_OBJECT_OBJECT (GREATEST(OBJECT_ID,OBJECT_PID), LEAST(OBJECT_ID,OBJECT_PID)) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NBUR_LNK_OBJECT_OBJECT ***
grant SELECT                                                                 on NBUR_LNK_OBJECT_OBJECT to BARSREADER_ROLE;
grant SELECT                                                                 on NBUR_LNK_OBJECT_OBJECT to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NBUR_LNK_OBJECT_OBJECT to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBUR_LNK_OBJECT_OBJECT.sql =========**
PROMPT ===================================================================================== 
