

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CC_SWTRACE.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CC_SWTRACE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CC_SWTRACE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CC_SWTRACE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CC_SWTRACE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CC_SWTRACE ***
begin 
  execute immediate '
  CREATE TABLE BARS.CC_SWTRACE 
   (	RNK NUMBER, 
	KV NUMBER, 
	SWO_BIC CHAR(11), 
	SWO_ACC VARCHAR2(35), 
	SWO_ALT VARCHAR2(250), 
	INTERM_B VARCHAR2(250), 
	FIELD_58D VARCHAR2(250), 
	NLS VARCHAR2(35)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CC_SWTRACE ***
 exec bpa.alter_policies('CC_SWTRACE');


COMMENT ON TABLE BARS.CC_SWTRACE IS 'Сохраненные параметры трасс договоров';
COMMENT ON COLUMN BARS.CC_SWTRACE.RNK IS 'Код клиента';
COMMENT ON COLUMN BARS.CC_SWTRACE.KV IS 'Код валюты';
COMMENT ON COLUMN BARS.CC_SWTRACE.SWO_BIC IS 'BIC-код партнера';
COMMENT ON COLUMN BARS.CC_SWTRACE.SWO_ACC IS 'Номер счета партнера';
COMMENT ON COLUMN BARS.CC_SWTRACE.SWO_ALT IS 'Альтернативное заполнение исходящей трассы (57D)';
COMMENT ON COLUMN BARS.CC_SWTRACE.INTERM_B IS 'Реквизиты посредника по стороне Б (56A)';
COMMENT ON COLUMN BARS.CC_SWTRACE.FIELD_58D IS 'Поле 58D для рублей';
COMMENT ON COLUMN BARS.CC_SWTRACE.NLS IS 'Счет партнера';




PROMPT *** Create  constraint XPK_CC_SWTRACE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_SWTRACE ADD CONSTRAINT XPK_CC_SWTRACE PRIMARY KEY (RNK, KV)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CCSWTRACE_SWBANKS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_SWTRACE ADD CONSTRAINT FK_CCSWTRACE_SWBANKS FOREIGN KEY (SWO_BIC)
	  REFERENCES BARS.SW_BANKS (BIC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CCSWTRACE_CUSTOMER ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_SWTRACE ADD CONSTRAINT FK_CCSWTRACE_CUSTOMER FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CCSWTRACE_KV ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_SWTRACE ADD CONSTRAINT FK_CCSWTRACE_KV FOREIGN KEY (KV)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CCSWTRACE_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_SWTRACE MODIFY (RNK CONSTRAINT CC_CCSWTRACE_RNK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CCSWTRACE_KV_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_SWTRACE MODIFY (KV CONSTRAINT CC_CCSWTRACE_KV_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CC_SWTRACE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CC_SWTRACE ON BARS.CC_SWTRACE (RNK, KV) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CC_SWTRACE ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CC_SWTRACE      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_SWTRACE      to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CC_SWTRACE      to FOREX;
grant DELETE,INSERT,SELECT,UPDATE                                            on CC_SWTRACE      to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CC_SWTRACE      to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on CC_SWTRACE      to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CC_SWTRACE.sql =========*** End *** ==
PROMPT ===================================================================================== 
