

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PAYTT_NO.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PAYTT_NO ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PAYTT_NO'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''PAYTT_NO'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''PAYTT_NO'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PAYTT_NO ***
begin 
  execute immediate '
  CREATE TABLE BARS.PAYTT_NO 
   (	ID NUMBER(38,0), 
	NAME VARCHAR2(35), 
	NBSD CHAR(4), 
	NBSK CHAR(4), 
	TT CHAR(3)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PAYTT_NO ***
 exec bpa.alter_policies('PAYTT_NO');


COMMENT ON TABLE BARS.PAYTT_NO IS 'Бiзнес-логiка "Забороненi пари"';
COMMENT ON COLUMN BARS.PAYTT_NO.ID IS 'Код~правила';
COMMENT ON COLUMN BARS.PAYTT_NO.NAME IS 'Коментар~до правила';
COMMENT ON COLUMN BARS.PAYTT_NO.NBSD IS 'БР-Деб~схожий на';
COMMENT ON COLUMN BARS.PAYTT_NO.NBSK IS 'БР-Крд~схожий на';
COMMENT ON COLUMN BARS.PAYTT_NO.TT IS 'Код Оп (Null=всi)';




PROMPT *** Create  constraint PK_PAYTTNO ***
begin   
 execute immediate '
  ALTER TABLE BARS.PAYTT_NO ADD CONSTRAINT PK_PAYTTNO PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PAYTTNO_TT ***
begin   
 execute immediate '
  ALTER TABLE BARS.PAYTT_NO ADD CONSTRAINT FK_PAYTTNO_TT FOREIGN KEY (TT)
	  REFERENCES BARS.TTS (TT) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PAYTTNO_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PAYTT_NO MODIFY (ID CONSTRAINT CC_PAYTTNO_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PAYTTNO_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PAYTT_NO MODIFY (NAME CONSTRAINT CC_PAYTTNO_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PAYTTNO_NBSD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PAYTT_NO MODIFY (NBSD CONSTRAINT CC_PAYTTNO_NBSD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PAYTTNO_NBSK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PAYTT_NO MODIFY (NBSK CONSTRAINT CC_PAYTTNO_NBSK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PAYTTNO ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_PAYTTNO ON BARS.PAYTT_NO (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PAYTT_NO ***
grant DELETE,INSERT,SELECT,UPDATE                                            on PAYTT_NO        to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on PAYTT_NO        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PAYTT_NO        to BARS_DM;
grant FLASHBACK,SELECT                                                       on PAYTT_NO        to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PAYTT_NO.sql =========*** End *** ====
PROMPT ===================================================================================== 
