

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CP_DOK_DNK.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CP_DOK_DNK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_DOK_DNK'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CP_DOK_DNK'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CP_DOK_DNK ***
begin 
  execute immediate '
  CREATE TABLE BARS.CP_DOK_DNK 
   (	ID NUMBER, 
	CP_ID VARCHAR2(20), 
	CP_REF NUMBER, 
	DATE_RUN DATE, 
	DESCRIPTION VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CP_DOK_DNK ***
 exec bpa.alter_policies('CP_DOK_DNK');


COMMENT ON TABLE BARS.CP_DOK_DNK IS 'Журнал роботи функції Автозавершення купонного періода';
COMMENT ON COLUMN BARS.CP_DOK_DNK.ID IS 'Ідентифікатор-id ЦП';
COMMENT ON COLUMN BARS.CP_DOK_DNK.CP_ID IS 'Ідентифікатор ЦП';
COMMENT ON COLUMN BARS.CP_DOK_DNK.CP_REF IS 'REF угоди ЦП';
COMMENT ON COLUMN BARS.CP_DOK_DNK.DATE_RUN IS 'Дата запуску';
COMMENT ON COLUMN BARS.CP_DOK_DNK.DESCRIPTION IS 'Результат виконання операції';




PROMPT *** Create  constraint SYS_C00109733 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_DOK_DNK MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CPDOKDNKREF ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_DOK_DNK ADD CONSTRAINT FK_CPDOKDNKREF FOREIGN KEY (CP_REF)
	  REFERENCES BARS.CP_DEAL (REF) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CPDOKDNKID ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_DOK_DNK ADD CONSTRAINT FK_CPDOKDNKID FOREIGN KEY (ID)
	  REFERENCES BARS.CP_KOD (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CP_DOK_DNK ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_DOK_DNK      to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CP_DOK_DNK.sql =========*** End *** ==
PROMPT ===================================================================================== 
