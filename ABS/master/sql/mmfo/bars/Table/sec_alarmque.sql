

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SEC_ALARMQUE.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SEC_ALARMQUE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SEC_ALARMQUE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SEC_ALARMQUE'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''SEC_ALARMQUE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SEC_ALARMQUE ***
begin 
  execute immediate '
  CREATE TABLE BARS.SEC_ALARMQUE 
   (	REC_ID NUMBER(38,0), 
	 CONSTRAINT PK_SECALARMQUE PRIMARY KEY (REC_ID) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSDYNI 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SEC_ALARMQUE ***
 exec bpa.alter_policies('SEC_ALARMQUE');


COMMENT ON TABLE BARS.SEC_ALARMQUE IS 'Очередь событий аудита';
COMMENT ON COLUMN BARS.SEC_ALARMQUE.REC_ID IS 'Идентификатор записи журнала';




PROMPT *** Create  constraint CC_SECALARMQUE_RECID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_ALARMQUE MODIFY (REC_ID CONSTRAINT CC_SECALARMQUE_RECID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SECALARMQUE ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_ALARMQUE ADD CONSTRAINT PK_SECALARMQUE PRIMARY KEY (REC_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SECALARMQUE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SECALARMQUE ON BARS.SEC_ALARMQUE (REC_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SEC_ALARMQUE ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SEC_ALARMQUE    to ABS_ADMIN;
grant SELECT                                                                 on SEC_ALARMQUE    to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SEC_ALARMQUE    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SEC_ALARMQUE    to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SEC_ALARMQUE    to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SEC_ALARMQUE.sql =========*** End *** 
PROMPT ===================================================================================== 
