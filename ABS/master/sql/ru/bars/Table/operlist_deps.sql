

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OPERLIST_DEPS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OPERLIST_DEPS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OPERLIST_DEPS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''OPERLIST_DEPS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OPERLIST_DEPS ***
begin 
  execute immediate '
  CREATE TABLE BARS.OPERLIST_DEPS 
   (	ID_PARENT NUMBER(38,0), 
	ID_CHILD NUMBER(38,0), 
	 CONSTRAINT PK_OPERLISTDEPS PRIMARY KEY (ID_PARENT, ID_CHILD) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSSMLI 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OPERLIST_DEPS ***
 exec bpa.alter_policies('OPERLIST_DEPS');


COMMENT ON TABLE BARS.OPERLIST_DEPS IS 'Справочник для зависимостей функций из operlist';
COMMENT ON COLUMN BARS.OPERLIST_DEPS.ID_PARENT IS 'Код родительской функции';
COMMENT ON COLUMN BARS.OPERLIST_DEPS.ID_CHILD IS 'Код дочерней функции';




PROMPT *** Create  constraint FK_OPERLISTDEPS_OPERLIST2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPERLIST_DEPS ADD CONSTRAINT FK_OPERLISTDEPS_OPERLIST2 FOREIGN KEY (ID_CHILD)
	  REFERENCES BARS.OPERLIST (CODEOPER) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OPERLISTDEPS_OPERLIST ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPERLIST_DEPS ADD CONSTRAINT FK_OPERLISTDEPS_OPERLIST FOREIGN KEY (ID_PARENT)
	  REFERENCES BARS.OPERLIST (CODEOPER) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_OPERLISTDEPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPERLIST_DEPS ADD CONSTRAINT PK_OPERLISTDEPS PRIMARY KEY (ID_PARENT, ID_CHILD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OPERLISTDEPS_IDCHILD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPERLIST_DEPS MODIFY (ID_CHILD CONSTRAINT CC_OPERLISTDEPS_IDCHILD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OPERLISTDEPS_IDPARENT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPERLIST_DEPS MODIFY (ID_PARENT CONSTRAINT CC_OPERLISTDEPS_IDPARENT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OPERLISTDEPS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OPERLISTDEPS ON BARS.OPERLIST_DEPS (ID_PARENT, ID_CHILD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OPERLIST_DEPS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on OPERLIST_DEPS   to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on OPERLIST_DEPS   to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OPERLIST_DEPS   to WR_ALL_RIGHTS;
grant SELECT                                                                 on OPERLIST_DEPS   to WR_DIAGNOSTICS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OPERLIST_DEPS.sql =========*** End ***
PROMPT ===================================================================================== 
