

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ARJK.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ARJK ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ARJK ***
begin 
  execute immediate '
  CREATE TABLE BARS.ARJK 
   (	ID NUMBER, 
	NAME VARCHAR2(35), 
	DAT1 DATE, 
	IR_NOT NUMBER, 
	IR_YES NUMBER, 
	DATF DATE, 
	NLS_2909 VARCHAR2(15), 
	NLS_2809 VARCHAR2(15), 
	NLS_9510 VARCHAR2(15), 
	NLS_7061 VARCHAR2(15), 
	IR NUMBER, 
	RNK NUMBER, 
	MFOB VARCHAR2(12), 
	NLSB VARCHAR2(15)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ARJK ***
 exec bpa.alter_policies('ARJK');


COMMENT ON TABLE BARS.ARJK IS '';
COMMENT ON COLUMN BARS.ARJK.ID IS '';
COMMENT ON COLUMN BARS.ARJK.NAME IS '';
COMMENT ON COLUMN BARS.ARJK.DAT1 IS '';
COMMENT ON COLUMN BARS.ARJK.IR_NOT IS 'Проц.до дати финансирования';
COMMENT ON COLUMN BARS.ARJK.IR_YES IS 'Проц.после дати финансирования';
COMMENT ON COLUMN BARS.ARJK.DATF IS 'Дата відкриття фінансування по пулу';
COMMENT ON COLUMN BARS.ARJK.NLS_2909 IS 'Рах.Кред.заб.з ДИУ за кредитами його пулу';
COMMENT ON COLUMN BARS.ARJK.NLS_2809 IS 'Рах.деб. заборгов ДИУ за кредитами його пулу';
COMMENT ON COLUMN BARS.ARJK.NLS_9510 IS 'Рах.наданої застави ДИУ';
COMMENT ON COLUMN BARS.ARJK.NLS_7061 IS 'Рах.нар витрат по ставці ДИУ';
COMMENT ON COLUMN BARS.ARJK.IR IS '% ст. рефiнансування ДИУ';
COMMENT ON COLUMN BARS.ARJK.RNK IS 'РНК клiєнта (власне ЮО=ДИУ)';
COMMENT ON COLUMN BARS.ARJK.MFOB IS 'Пл.реквiзити для пулу (банк отримувача)';
COMMENT ON COLUMN BARS.ARJK.NLSB IS 'Пл.реквiзити для пулу (рах.отримувача)';




PROMPT *** Create  constraint SYS_C006377 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ARJK MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ARJK ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ARJK            to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ARJK            to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ARJK            to RCC_DEAL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ARJK            to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on ARJK            to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ARJK.sql =========*** End *** ========
PROMPT ===================================================================================== 
