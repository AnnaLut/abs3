

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SKRN_MSG.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SKRN_MSG ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SKRN_MSG'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SKRN_MSG'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SKRN_MSG'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SKRN_MSG ***
begin 
  execute immediate '
  CREATE TABLE BARS.SKRN_MSG 
   (	MSG_ID NUMBER(*,0), 
	CHANGE_TIME DATE DEFAULT sysdate, 
	BRANCH VARCHAR2(30), 
	ND NUMBER, 
	TYPE_SMS CHAR(6), 
	STATE NUMBER, 
	ERROR VARCHAR2(254)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SKRN_MSG ***
 exec bpa.alter_policies('SKRN_MSG');


COMMENT ON TABLE BARS.SKRN_MSG IS '';
COMMENT ON COLUMN BARS.SKRN_MSG.MSG_ID IS 'код смс';
COMMENT ON COLUMN BARS.SKRN_MSG.CHANGE_TIME IS 'дата отправки в очередь смс';
COMMENT ON COLUMN BARS.SKRN_MSG.BRANCH IS 'бранч';
COMMENT ON COLUMN BARS.SKRN_MSG.ND IS 'номер договора';
COMMENT ON COLUMN BARS.SKRN_MSG.TYPE_SMS IS 'тип смс';
COMMENT ON COLUMN BARS.SKRN_MSG.STATE IS 'статус: 1-отправлена в очередь; 0 - не обработана';
COMMENT ON COLUMN BARS.SKRN_MSG.ERROR IS 'ошибка';




PROMPT *** Create  constraint SYS_C00137963 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRN_MSG MODIFY (CHANGE_TIME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00137964 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRN_MSG MODIFY (BRANCH NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00137965 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRN_MSG MODIFY (ND NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00137966 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRN_MSG MODIFY (TYPE_SMS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SKRN_MSG_PR ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRN_MSG ADD CONSTRAINT SKRN_MSG_PR PRIMARY KEY (BRANCH, ND)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index SKRN_MSG_PR ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.SKRN_MSG_PR ON BARS.SKRN_MSG (BRANCH, ND) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index SKRN_MSG_NORM ***
begin   
 execute immediate '
  CREATE INDEX BARS.SKRN_MSG_NORM ON BARS.SKRN_MSG (BRANCH, ND, TYPE_SMS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SKRN_MSG ***
grant SELECT                                                                 on SKRN_MSG        to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SKRN_MSG        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SKRN_MSG        to BARS_DM;
grant SELECT                                                                 on SKRN_MSG        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SKRN_MSG.sql =========*** End *** ====
PROMPT ===================================================================================== 
