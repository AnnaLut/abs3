

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PS_TTS.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PS_TTS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PS_TTS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''PS_TTS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''PS_TTS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PS_TTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.PS_TTS 
   (	ID NUMBER(38,0), 
	TT CHAR(3), 
	NBS CHAR(4), 
	DK NUMBER(*,0), 
	OB22 CHAR(2)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLI ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PS_TTS ***
 exec bpa.alter_policies('PS_TTS');


COMMENT ON TABLE BARS.PS_TTS IS 'ОПЕРАЦИИ <-> БАЛ.СЧЕТА';
COMMENT ON COLUMN BARS.PS_TTS.ID IS 'N';
COMMENT ON COLUMN BARS.PS_TTS.TT IS 'Тип транзакции';
COMMENT ON COLUMN BARS.PS_TTS.NBS IS 'Класс, Раздел , Группа,БС';
COMMENT ON COLUMN BARS.PS_TTS.DK IS 'Дебет/Kредит';
COMMENT ON COLUMN BARS.PS_TTS.OB22 IS 'Допустимый OB22';




PROMPT *** Create  constraint PK_PS_TTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.PS_TTS ADD CONSTRAINT PK_PS_TTS PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PSTTS_DK ***
begin   
 execute immediate '
  ALTER TABLE BARS.PS_TTS ADD CONSTRAINT CC_PSTTS_DK CHECK (dk in (0,1)) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PSTTS_DK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PS_TTS MODIFY (DK CONSTRAINT CC_PSTTS_DK_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PSTTS_NBS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PS_TTS MODIFY (NBS CONSTRAINT CC_PSTTS_NBS_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PSTTS_TT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PS_TTS MODIFY (TT CONSTRAINT CC_PSTTS_TT_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PSTTS_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PS_TTS MODIFY (ID CONSTRAINT CC_PSTTS_ID_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PSTTS_TTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.PS_TTS ADD CONSTRAINT FK_PSTTS_TTS FOREIGN KEY (TT)
	  REFERENCES BARS.TTS (TT) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PSTTS_DK ***
begin   
 execute immediate '
  ALTER TABLE BARS.PS_TTS ADD CONSTRAINT FK_PSTTS_DK FOREIGN KEY (DK)
	  REFERENCES BARS.DK (DK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PSTTS_PS ***
begin   
 execute immediate '
  ALTER TABLE BARS.PS_TTS ADD CONSTRAINT FK_PSTTS_PS FOREIGN KEY (NBS)
	  REFERENCES BARS.PS (NBS) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_PS_TTS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.I1_PS_TTS ON BARS.PS_TTS (TT, NBS, DK, OB22) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PS_TTS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_PS_TTS ON BARS.PS_TTS (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PS_TTS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on PS_TTS          to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on PS_TTS          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PS_TTS          to BARS_DM;
grant SELECT                                                                 on PS_TTS          to KLBX;
grant DELETE,INSERT,SELECT,UPDATE                                            on PS_TTS          to PS_TTS;
grant SELECT                                                                 on PS_TTS          to START1;
grant DELETE,INSERT,SELECT,UPDATE                                            on PS_TTS          to TECH005;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on PS_TTS          to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on PS_TTS          to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PS_TTS.sql =========*** End *** ======
PROMPT ===================================================================================== 
