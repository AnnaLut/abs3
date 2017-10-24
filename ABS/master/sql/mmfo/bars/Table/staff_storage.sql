

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/STAFF_STORAGE.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to STAFF_STORAGE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''STAFF_STORAGE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''STAFF_STORAGE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''STAFF_STORAGE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table STAFF_STORAGE ***
begin 
  execute immediate '
  CREATE TABLE BARS.STAFF_STORAGE 
   (	ID NUMBER(38,0), 
	STORAGE_STMT VARCHAR2(500), 
	GRANTS VARCHAR2(500), 
	ROLES VARCHAR2(500), 
	GRANTOR NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to STAFF_STORAGE ***
 exec bpa.alter_policies('STAFF_STORAGE');


COMMENT ON TABLE BARS.STAFF_STORAGE IS 'Таблица для временного хранения параметров пользователя, строки удаляются при подтверждении';
COMMENT ON COLUMN BARS.STAFF_STORAGE.ID IS 'Идентификатор пользователя комплекса';
COMMENT ON COLUMN BARS.STAFF_STORAGE.STORAGE_STMT IS '';
COMMENT ON COLUMN BARS.STAFF_STORAGE.GRANTS IS 'Ресурсы пользователя';
COMMENT ON COLUMN BARS.STAFF_STORAGE.ROLES IS 'Роли пользователя';
COMMENT ON COLUMN BARS.STAFF_STORAGE.GRANTOR IS 'Идентификатор пользователя, который выдал разрешения';




PROMPT *** Create  constraint PK_STAFFSTG ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_STORAGE ADD CONSTRAINT PK_STAFFSTG PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_STAFFSTG_STAFF2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_STORAGE ADD CONSTRAINT FK_STAFFSTG_STAFF2 FOREIGN KEY (GRANTOR)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_STAFFSTG_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_STORAGE ADD CONSTRAINT FK_STAFFSTG_STAFF FOREIGN KEY (ID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STAFFSTG_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_STORAGE MODIFY (ID CONSTRAINT CC_STAFFSTG_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_STAFFSTG ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_STAFFSTG ON BARS.STAFF_STORAGE (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  STAFF_STORAGE ***
grant DELETE,INSERT,SELECT,UPDATE                                            on STAFF_STORAGE   to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on STAFF_STORAGE   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on STAFF_STORAGE   to BARS_DM;
grant SELECT                                                                 on STAFF_STORAGE   to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on STAFF_STORAGE   to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/STAFF_STORAGE.sql =========*** End ***
PROMPT ===================================================================================== 
