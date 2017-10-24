

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/STAFFTIP_TTS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to STAFFTIP_TTS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''STAFFTIP_TTS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''STAFFTIP_TTS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''STAFFTIP_TTS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table STAFFTIP_TTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.STAFFTIP_TTS 
   (	ID NUMBER(22,0), 
	TT CHAR(3)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to STAFFTIP_TTS ***
 exec bpa.alter_policies('STAFFTIP_TTS');


COMMENT ON TABLE BARS.STAFFTIP_TTS IS 'Типов_ користувач_ <-> Операц_ї';
COMMENT ON COLUMN BARS.STAFFTIP_TTS.ID IS 'Код типового користувача';
COMMENT ON COLUMN BARS.STAFFTIP_TTS.TT IS 'Код операц_ї';




PROMPT *** Create  constraint PK_STAFFTIPTTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFFTIP_TTS ADD CONSTRAINT PK_STAFFTIPTTS PRIMARY KEY (ID, TT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_STAFFTIPTTS_STAFFTIPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFFTIP_TTS ADD CONSTRAINT FK_STAFFTIPTTS_STAFFTIPS FOREIGN KEY (ID)
	  REFERENCES BARS.STAFF_TIPS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_STAFFTIPTTS_TTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFFTIP_TTS ADD CONSTRAINT FK_STAFFTIPTTS_TTS FOREIGN KEY (TT)
	  REFERENCES BARS.TTS (TT) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STAFFTIPTTS_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFFTIP_TTS MODIFY (ID CONSTRAINT CC_STAFFTIPTTS_ID_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STAFFTIPTTS_TT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFFTIP_TTS MODIFY (TT CONSTRAINT CC_STAFFTIPTTS_TT_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_STAFFTIPTTS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_STAFFTIPTTS ON BARS.STAFFTIP_TTS (ID, TT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  STAFFTIP_TTS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on STAFFTIP_TTS    to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on STAFFTIP_TTS    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on STAFFTIP_TTS    to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/STAFFTIP_TTS.sql =========*** End *** 
PROMPT ===================================================================================== 
