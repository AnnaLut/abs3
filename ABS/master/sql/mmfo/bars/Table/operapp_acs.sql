

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OPERAPP_ACS.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OPERAPP_ACS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OPERAPP_ACS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''OPERAPP_ACS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OPERAPP_ACS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OPERAPP_ACS ***
begin 
  execute immediate '
  CREATE TABLE BARS.OPERAPP_ACS 
   (	CODEAPP VARCHAR2(30), 
	CODEOPER NUMBER, 
	 CONSTRAINT PK_OPERAPPACS PRIMARY KEY (CODEAPP, CODEOPER) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSDYNI 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OPERAPP_ACS ***
 exec bpa.alter_policies('OPERAPP_ACS');


COMMENT ON TABLE BARS.OPERAPP_ACS IS 'Зависимость АРМов и функций (развернутая)';
COMMENT ON COLUMN BARS.OPERAPP_ACS.CODEAPP IS 'Код арма';
COMMENT ON COLUMN BARS.OPERAPP_ACS.CODEOPER IS 'Код функции';




PROMPT *** Create  constraint SYS_C004522 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPERAPP_ACS MODIFY (CODEAPP NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C004523 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPERAPP_ACS MODIFY (CODEOPER NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_OPERAPPACS ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPERAPP_ACS ADD CONSTRAINT PK_OPERAPPACS PRIMARY KEY (CODEAPP, CODEOPER)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OPERAPPACS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OPERAPPACS ON BARS.OPERAPP_ACS (CODEAPP, CODEOPER) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OPERAPP_ACS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on OPERAPP_ACS     to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on OPERAPP_ACS     to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OPERAPP_ACS.sql =========*** End *** =
PROMPT ===================================================================================== 
