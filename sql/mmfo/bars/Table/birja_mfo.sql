

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BIRJA_MFO.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BIRJA_MFO ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BIRJA_MFO'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''BIRJA_MFO'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''BIRJA_MFO'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BIRJA_MFO ***
begin 
  execute immediate '
  CREATE TABLE BARS.BIRJA_MFO 
   (	PAR VARCHAR2(8), 
	COMM VARCHAR2(70), 
	VAL VARCHAR2(254), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BIRJA_MFO ***
 exec bpa.alter_policies('BIRJA_MFO');


COMMENT ON TABLE BARS.BIRJA_MFO IS 'Конфиг.параметры модулей "Бирж.операции" и "Вал.контроль"';
COMMENT ON COLUMN BARS.BIRJA_MFO.PAR IS 'Код параметра';
COMMENT ON COLUMN BARS.BIRJA_MFO.COMM IS 'Комментарий';
COMMENT ON COLUMN BARS.BIRJA_MFO.VAL IS 'Значение параметра';
COMMENT ON COLUMN BARS.BIRJA_MFO.KF IS 'Код филиала';




PROMPT *** Create  constraint FK_BIRJA_MFO_BANKS ***
begin   
 execute immediate '
  ALTER TABLE BARS.BIRJA_MFO ADD CONSTRAINT FK_BIRJA_MFO_BANKS FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BIRJA_MFO_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BIRJA_MFO MODIFY (KF CONSTRAINT CC_BIRJA_MFO_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_BIRJA_MFO ***
begin   
 execute immediate '
  ALTER TABLE BARS.BIRJA_MFO ADD CONSTRAINT PK_BIRJA_MFO PRIMARY KEY (KF, PAR)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BIRJA_MFO ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BIRJA_MFO ON BARS.BIRJA_MFO (KF, PAR) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BIRJA_MFO ***
grant FLASHBACK,REFERENCES,SELECT                                            on BIRJA_MFO       to BARSAQ with grant option;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BIRJA_MFO       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BIRJA_MFO       to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on BIRJA_MFO       to F_500;
grant SELECT                                                                 on BIRJA_MFO       to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BIRJA_MFO       to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on BIRJA_MFO       to WR_REFREAD;
grant DELETE,INSERT,SELECT,UPDATE                                            on BIRJA_MFO       to ZAY;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BIRJA_MFO.sql =========*** End *** ===
PROMPT ===================================================================================== 
