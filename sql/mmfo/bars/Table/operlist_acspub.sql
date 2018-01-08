

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OPERLIST_ACSPUB.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OPERLIST_ACSPUB ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OPERLIST_ACSPUB'', ''CENTER'' , null, ''C'', ''C'', ''C'');
               bpa.alter_policy_info(''OPERLIST_ACSPUB'', ''FILIAL'' , null, ''C'', ''C'', ''C'');
               bpa.alter_policy_info(''OPERLIST_ACSPUB'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OPERLIST_ACSPUB ***
begin 
  execute immediate '
  CREATE TABLE BARS.OPERLIST_ACSPUB 
   (	FUNCNAME VARCHAR2(250), 
	FRONTEND NUMBER(38,0), 
	 CONSTRAINT PK_OPLISTACSPUB PRIMARY KEY (FUNCNAME, FRONTEND) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSSMLI 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OPERLIST_ACSPUB ***
 exec bpa.alter_policies('OPERLIST_ACSPUB');


COMMENT ON TABLE BARS.OPERLIST_ACSPUB IS 'Справочник общедоступных функций';
COMMENT ON COLUMN BARS.OPERLIST_ACSPUB.FUNCNAME IS 'Строка функции';
COMMENT ON COLUMN BARS.OPERLIST_ACSPUB.FRONTEND IS 'Ид. интерфейса';




PROMPT *** Create  constraint CC_OPLISTACSPUB_FNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPERLIST_ACSPUB MODIFY (FUNCNAME CONSTRAINT CC_OPLISTACSPUB_FNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OPLISTACSPUB_FID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPERLIST_ACSPUB MODIFY (FRONTEND CONSTRAINT CC_OPLISTACSPUB_FID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_OPLISTACSPUB ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPERLIST_ACSPUB ADD CONSTRAINT PK_OPLISTACSPUB PRIMARY KEY (FUNCNAME, FRONTEND)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OPLISTACSPUB ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OPLISTACSPUB ON BARS.OPERLIST_ACSPUB (FUNCNAME, FRONTEND) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OPERLIST_ACSPUB ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OPERLIST_ACSPUB to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OPERLIST_ACSPUB.sql =========*** End *
PROMPT ===================================================================================== 
