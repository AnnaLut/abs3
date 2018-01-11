

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SEC_ACTION.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SEC_ACTION ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SEC_ACTION'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SEC_ACTION'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''SEC_ACTION'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SEC_ACTION ***
begin 
  execute immediate '
  CREATE TABLE BARS.SEC_ACTION 
   (	ID NUMBER(3,0), 
	NAME VARCHAR2(50), 
	SEMANTIC VARCHAR2(5)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SEC_ACTION ***
 exec bpa.alter_policies('SEC_ACTION');


COMMENT ON TABLE BARS.SEC_ACTION IS 'Действия безопасности';
COMMENT ON COLUMN BARS.SEC_ACTION.ID IS 'Идентификатор действия';
COMMENT ON COLUMN BARS.SEC_ACTION.NAME IS 'Наименование действия';
COMMENT ON COLUMN BARS.SEC_ACTION.SEMANTIC IS 'Семантика';




PROMPT *** Create  constraint PK_SECACTION ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_ACTION ADD CONSTRAINT PK_SECACTION PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SECACTION ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SECACTION ON BARS.SEC_ACTION (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SEC_ACTION ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SEC_ACTION      to ABS_ADMIN;
grant SELECT                                                                 on SEC_ACTION      to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SEC_ACTION      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SEC_ACTION      to BARS_DM;
grant SELECT                                                                 on SEC_ACTION      to START1;
grant SELECT                                                                 on SEC_ACTION      to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SEC_ACTION      to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SEC_ACTION.sql =========*** End *** ==
PROMPT ===================================================================================== 
