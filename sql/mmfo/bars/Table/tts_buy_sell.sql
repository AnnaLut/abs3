

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TTS_BUY_SELL.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TTS_BUY_SELL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TTS_BUY_SELL'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TTS_BUY_SELL'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TTS_BUY_SELL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TTS_BUY_SELL ***
begin 
  execute immediate '
  CREATE TABLE BARS.TTS_BUY_SELL 
   (	TT CHAR(3), 
	COMMENTS VARCHAR2(200)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TTS_BUY_SELL ***
 exec bpa.alter_policies('TTS_BUY_SELL');


COMMENT ON TABLE BARS.TTS_BUY_SELL IS 'Довідник операцій купівлі продажу валют, які сторнуються(15 хв)';
COMMENT ON COLUMN BARS.TTS_BUY_SELL.TT IS 'Код операції';
COMMENT ON COLUMN BARS.TTS_BUY_SELL.COMMENTS IS 'Коментар';




PROMPT *** Create  constraint CC_TTSBUYSELL_TT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TTS_BUY_SELL MODIFY (TT CONSTRAINT CC_TTSBUYSELL_TT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_TTSBUYSELL ***
begin   
 execute immediate '
  ALTER TABLE BARS.TTS_BUY_SELL ADD CONSTRAINT PK_TTSBUYSELL PRIMARY KEY (TT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TTSBUYSELL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TTSBUYSELL ON BARS.TTS_BUY_SELL (TT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TTS_BUY_SELL ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TTS_BUY_SELL    to ABS_ADMIN;
grant SELECT                                                                 on TTS_BUY_SELL    to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TTS_BUY_SELL    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TTS_BUY_SELL    to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on TTS_BUY_SELL    to START1;
grant SELECT                                                                 on TTS_BUY_SELL    to UPLD;
grant FLASHBACK,SELECT                                                       on TTS_BUY_SELL    to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TTS_BUY_SELL.sql =========*** End *** 
PROMPT ===================================================================================== 
