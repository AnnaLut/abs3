

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/QUEUE_OPERAPP_ACS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to QUEUE_OPERAPP_ACS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''QUEUE_OPERAPP_ACS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''QUEUE_OPERAPP_ACS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''QUEUE_OPERAPP_ACS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table QUEUE_OPERAPP_ACS ***
begin 
  execute immediate '
  CREATE TABLE BARS.QUEUE_OPERAPP_ACS 
   (	CODEAPP VARCHAR2(30), 
	 CONSTRAINT PK_QOPRAPPACS PRIMARY KEY (CODEAPP) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSDYNI 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to QUEUE_OPERAPP_ACS ***
 exec bpa.alter_policies('QUEUE_OPERAPP_ACS');


COMMENT ON TABLE BARS.QUEUE_OPERAPP_ACS IS 'Очередь на обновление зависимости АРМов и функций';
COMMENT ON COLUMN BARS.QUEUE_OPERAPP_ACS.CODEAPP IS 'Код арма';




PROMPT *** Create  constraint SYS_C004636 ***
begin   
 execute immediate '
  ALTER TABLE BARS.QUEUE_OPERAPP_ACS MODIFY (CODEAPP NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_QOPRAPPACS ***
begin   
 execute immediate '
  ALTER TABLE BARS.QUEUE_OPERAPP_ACS ADD CONSTRAINT PK_QOPRAPPACS PRIMARY KEY (CODEAPP)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_QOPRAPPACS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_QOPRAPPACS ON BARS.QUEUE_OPERAPP_ACS (CODEAPP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  QUEUE_OPERAPP_ACS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on QUEUE_OPERAPP_ACS to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on QUEUE_OPERAPP_ACS to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/QUEUE_OPERAPP_ACS.sql =========*** End
PROMPT ===================================================================================== 
