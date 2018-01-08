

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/RKO_TTS.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to RKO_TTS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''RKO_TTS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''RKO_TTS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''RKO_TTS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table RKO_TTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.RKO_TTS 
   (	TT CHAR(3), 
	DK NUMBER(*,0) DEFAULT 0, 
	NTAR NUMBER(*,0), 
	 CONSTRAINT PK_RKO_TTS PRIMARY KEY (TT, DK, NTAR) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSSMLI 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to RKO_TTS ***
 exec bpa.alter_policies('RKO_TTS');


COMMENT ON TABLE BARS.RKO_TTS IS 'Операции-тарифы для взымания платы за РКО';
COMMENT ON COLUMN BARS.RKO_TTS.TT IS 'Код операции';
COMMENT ON COLUMN BARS.RKO_TTS.DK IS 'Признак дебет/кредит';
COMMENT ON COLUMN BARS.RKO_TTS.NTAR IS 'Код тарифа';




PROMPT *** Create  constraint FK_RKO_TTS_TTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.RKO_TTS ADD CONSTRAINT FK_RKO_TTS_TTS FOREIGN KEY (TT)
	  REFERENCES BARS.TTS (TT) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_RKO_TTS_DK ***
begin   
 execute immediate '
  ALTER TABLE BARS.RKO_TTS ADD CONSTRAINT FK_RKO_TTS_DK FOREIGN KEY (DK)
	  REFERENCES BARS.DK (DK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_RKO_TTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.RKO_TTS ADD CONSTRAINT PK_RKO_TTS PRIMARY KEY (TT, DK, NTAR)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_RKO_TTS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_RKO_TTS ON BARS.RKO_TTS (TT, DK, NTAR) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  RKO_TTS ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on RKO_TTS         to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on RKO_TTS         to RKO;
grant DELETE,INSERT,SELECT,UPDATE                                            on RKO_TTS         to TARIF;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on RKO_TTS         to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on RKO_TTS         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/RKO_TTS.sql =========*** End *** =====
PROMPT ===================================================================================== 
