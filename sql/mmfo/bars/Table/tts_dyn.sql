

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TTS_DYN.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TTS_DYN ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TTS_DYN'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TTS_DYN'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''TTS_DYN'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TTS_DYN ***
begin 
  execute immediate '
  CREATE TABLE BARS.TTS_DYN 
   (	TIP CHAR(3), 
	TT CHAR(3)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TTS_DYN ***
 exec bpa.alter_policies('TTS_DYN');


COMMENT ON TABLE BARS.TTS_DYN IS 'Динамические транзакции системы';
COMMENT ON COLUMN BARS.TTS_DYN.TIP IS 'Тип счета';
COMMENT ON COLUMN BARS.TTS_DYN.TT IS 'Тип операции';




PROMPT *** Create  constraint PK_TTSDYN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TTS_DYN ADD CONSTRAINT PK_TTSDYN PRIMARY KEY (TIP)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_TTSDYN_TIPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.TTS_DYN ADD CONSTRAINT FK_TTSDYN_TIPS FOREIGN KEY (TIP)
	  REFERENCES BARS.TIPS (TIP) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_TTSDYN_TTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.TTS_DYN ADD CONSTRAINT FK_TTSDYN_TTS FOREIGN KEY (TT)
	  REFERENCES BARS.TTS (TT) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TTSDYN_TIP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TTS_DYN MODIFY (TIP CONSTRAINT CC_TTSDYN_TIP_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005950 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TTS_DYN MODIFY (TT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TTSDYN ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TTSDYN ON BARS.TTS_DYN (TIP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TTS_DYN ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TTS_DYN         to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on TTS_DYN         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TTS_DYN         to BARS_DM;
grant SELECT                                                                 on TTS_DYN         to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TTS_DYN         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TTS_DYN.sql =========*** End *** =====
PROMPT ===================================================================================== 
