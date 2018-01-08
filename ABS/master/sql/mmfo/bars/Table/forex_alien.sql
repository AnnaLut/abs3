

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FOREX_ALIEN.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FOREX_ALIEN ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FOREX_ALIEN'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''FOREX_ALIEN'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''FOREX_ALIEN'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FOREX_ALIEN ***
begin 
  execute immediate '
  CREATE TABLE BARS.FOREX_ALIEN 
   (	MFO VARCHAR2(12), 
	BIC CHAR(11), 
	NAME VARCHAR2(35), 
	NLS VARCHAR2(35), 
	KOD_G CHAR(3), 
	KOD_B CHAR(4), 
	OKPO VARCHAR2(10), 
	KV NUMBER(*,0), 
	BICK CHAR(11), 
	NLSK VARCHAR2(35), 
	ID NUMBER DEFAULT 0, 
	TXT VARCHAR2(100), 
	AGRMNT_NUM VARCHAR2(10), 
	AGRMNT_DATE DATE, 
	INTERM_B VARCHAR2(250), 
	CODCAGENT NUMBER(*,0), 
	TELEXNUM VARCHAR2(35), 
	ALT_PARTYB VARCHAR2(250), 
	FIELD_58D VARCHAR2(250)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FOREX_ALIEN ***
 exec bpa.alter_policies('FOREX_ALIEN');


COMMENT ON TABLE BARS.FOREX_ALIEN IS 'Форексные сделки';
COMMENT ON COLUMN BARS.FOREX_ALIEN.MFO IS '';
COMMENT ON COLUMN BARS.FOREX_ALIEN.BIC IS '';
COMMENT ON COLUMN BARS.FOREX_ALIEN.NAME IS '';
COMMENT ON COLUMN BARS.FOREX_ALIEN.NLS IS '';
COMMENT ON COLUMN BARS.FOREX_ALIEN.KOD_G IS '';
COMMENT ON COLUMN BARS.FOREX_ALIEN.KOD_B IS '';
COMMENT ON COLUMN BARS.FOREX_ALIEN.OKPO IS '';
COMMENT ON COLUMN BARS.FOREX_ALIEN.KV IS '';
COMMENT ON COLUMN BARS.FOREX_ALIEN.BICK IS '';
COMMENT ON COLUMN BARS.FOREX_ALIEN.NLSK IS '';
COMMENT ON COLUMN BARS.FOREX_ALIEN.ID IS '';
COMMENT ON COLUMN BARS.FOREX_ALIEN.TXT IS '';
COMMENT ON COLUMN BARS.FOREX_ALIEN.AGRMNT_NUM IS '';
COMMENT ON COLUMN BARS.FOREX_ALIEN.AGRMNT_DATE IS '';
COMMENT ON COLUMN BARS.FOREX_ALIEN.INTERM_B IS 'Реквизиты посредника по стороне Б (56A)';
COMMENT ON COLUMN BARS.FOREX_ALIEN.CODCAGENT IS '';
COMMENT ON COLUMN BARS.FOREX_ALIEN.TELEXNUM IS '';
COMMENT ON COLUMN BARS.FOREX_ALIEN.ALT_PARTYB IS 'Альтернативное заполнение исходящей трассы (57D)';
COMMENT ON COLUMN BARS.FOREX_ALIEN.FIELD_58D IS 'Поле 58D для рублей';




PROMPT *** Create  constraint SYS_C006137 ***
begin   
 execute immediate '
  ALTER TABLE BARS.FOREX_ALIEN MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FOREX_ALIEN ***
grant SELECT                                                                 on FOREX_ALIEN     to BARSUPL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on FOREX_ALIEN     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FOREX_ALIEN     to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on FOREX_ALIEN     to CP_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on FOREX_ALIEN     to FOREX;
grant SELECT                                                                 on FOREX_ALIEN     to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on FOREX_ALIEN     to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on FOREX_ALIEN     to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FOREX_ALIEN.sql =========*** End *** =
PROMPT ===================================================================================== 
