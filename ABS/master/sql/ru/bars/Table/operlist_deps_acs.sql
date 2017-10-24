

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OPERLIST_DEPS_ACS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OPERLIST_DEPS_ACS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OPERLIST_DEPS_ACS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OPERLIST_DEPS_ACS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OPERLIST_DEPS_ACS ***
begin 
  execute immediate '
  CREATE TABLE BARS.OPERLIST_DEPS_ACS 
   (	ID_PARENT NUMBER, 
	ID_CHILD NUMBER, 
	 CONSTRAINT PK_OPERLISTDEPSACS PRIMARY KEY (ID_PARENT, ID_CHILD) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSDYNI 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OPERLIST_DEPS_ACS ***
 exec bpa.alter_policies('OPERLIST_DEPS_ACS');


COMMENT ON TABLE BARS.OPERLIST_DEPS_ACS IS 'Зависимость веб-функций (развернутая)';
COMMENT ON COLUMN BARS.OPERLIST_DEPS_ACS.ID_PARENT IS 'Код родительской функции';
COMMENT ON COLUMN BARS.OPERLIST_DEPS_ACS.ID_CHILD IS 'Код дочерней функции';




PROMPT *** Create  constraint PK_OPERLISTDEPSACS ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPERLIST_DEPS_ACS ADD CONSTRAINT PK_OPERLISTDEPSACS PRIMARY KEY (ID_PARENT, ID_CHILD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C001985281 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPERLIST_DEPS_ACS MODIFY (ID_CHILD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C001985280 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPERLIST_DEPS_ACS MODIFY (ID_PARENT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OPERLISTDEPSACS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OPERLISTDEPSACS ON BARS.OPERLIST_DEPS_ACS (ID_PARENT, ID_CHILD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OPERLIST_DEPS_ACS.sql =========*** End
PROMPT ===================================================================================== 
