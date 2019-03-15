

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CL_2_AC.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CL_2_AC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CL_2_AC'', ''FILIAL'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CL_2_AC ***
begin 
  execute immediate '
  CREATE TABLE BARS.CL_2_AC 
   (	DOC_REF NUMBER(38,0), 
	STATUS VARCHAR2(2), 
	CREATE_DATE DATE, 
	CREATE_USER VARCHAR2(100), 
	LAST_DATE DATE, 
	LAST_USER VARCHAR2(100), 
	DOC_BODY SYS.XMLTYPE , 
	BIR_TEXT VARCHAR2(2000), 
	WS_RESPONSE SYS.XMLTYPE , 
	LAST_ERR_TXT VARCHAR2(2000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND 
 XMLTYPE COLUMN DOC_BODY STORE AS SECUREFILE BINARY XML (
  TABLESPACE BRSDYND ENABLE STORAGE IN ROW CHUNK 8192
  NOCACHE LOGGING  NOCOMPRESS  KEEP_DUPLICATES ) ALLOW NONSCHEMA DISALLOW ANYSCHEMA 
 XMLTYPE COLUMN WS_RESPONSE STORE AS SECUREFILE BINARY XML (
  TABLESPACE BRSDYND ENABLE STORAGE IN ROW CHUNK 8192
  NOCACHE LOGGING  NOCOMPRESS  KEEP_DUPLICATES ) ALLOW NONSCHEMA DISALLOW ANYSCHEMA ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CL_2_AC ***
 exec bpa.alter_policies('CL_2_AC');


COMMENT ON TABLE BARS.CL_2_AC IS '';
COMMENT ON COLUMN BARS.CL_2_AC.DOC_REF IS 'посилання на документ (oper.ref)';
COMMENT ON COLUMN BARS.CL_2_AC.STATUS IS 'статус документа (IN - початковий, 2S - готовий до відправки, DL - помилки при обробці, SN - відправлений в Автокассу)';
COMMENT ON COLUMN BARS.CL_2_AC.CREATE_DATE IS 'Користувач Oracle, який створив запис';
COMMENT ON COLUMN BARS.CL_2_AC.CREATE_USER IS 'Дата створення заявки';
COMMENT ON COLUMN BARS.CL_2_AC.LAST_DATE IS 'Користувач Oracle, який вніс останні зміни';
COMMENT ON COLUMN BARS.CL_2_AC.LAST_USER IS 'Дата останніх змін';
COMMENT ON COLUMN BARS.CL_2_AC.DOC_BODY IS 'Тіло запиту для веб-сервіса';
COMMENT ON COLUMN BARS.CL_2_AC.BIR_TEXT IS 'Дані з додаткових реквізитів платежу';
COMMENT ON COLUMN BARS.CL_2_AC.WS_RESPONSE IS 'Остання відповідь від веб-сервіса';
COMMENT ON COLUMN BARS.CL_2_AC.LAST_ERR_TXT IS 'Помилка при останній обробці';




PROMPT *** Create  constraint SYS_C0028955 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CL_2_AC MODIFY (DOC_REF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_CL_2_AC ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_CL_2_AC ON BARS.CL_2_AC (DOC_REF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX2_CL_2_AC ***
begin   
 execute immediate '
  CREATE BITMAP INDEX BARS.IDX2_CL_2_AC ON BARS.CL_2_AC (STATUS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CL_2_AC ***
grant INSERT                                                                 on CL_2_AC         to BARSAQ;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CL_2_AC.sql =========*** End *** =====
PROMPT ===================================================================================== 
