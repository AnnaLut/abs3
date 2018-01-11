

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/RI_MESSAGES.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to RI_MESSAGES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''RI_MESSAGES'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''RI_MESSAGES'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''RI_MESSAGES'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table RI_MESSAGES ***
begin 
  execute immediate '
  CREATE TABLE BARS.RI_MESSAGES 
   (	KEY NUMBER, 
	ID NUMBER, 
	MSG VARCHAR2(1024), 
	DATEMSG DATE, 
	BRANCH VARCHAR2(30), 
	RNK NUMBER, 
	DESKTOP VARCHAR2(16), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	COMM VARCHAR2(512)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to RI_MESSAGES ***
 exec bpa.alter_policies('RI_MESSAGES');


COMMENT ON TABLE BARS.RI_MESSAGES IS 'Повідомлення Реєстру інсайдерів';
COMMENT ON COLUMN BARS.RI_MESSAGES.KEY IS 'Ключ';
COMMENT ON COLUMN BARS.RI_MESSAGES.ID IS 'Код користувача';
COMMENT ON COLUMN BARS.RI_MESSAGES.MSG IS 'Текст повідомлення';
COMMENT ON COLUMN BARS.RI_MESSAGES.DATEMSG IS 'Дата повідомлення';
COMMENT ON COLUMN BARS.RI_MESSAGES.BRANCH IS 'Бранч';
COMMENT ON COLUMN BARS.RI_MESSAGES.RNK IS 'Реєстраційниц номер клієнта';
COMMENT ON COLUMN BARS.RI_MESSAGES.DESKTOP IS 'Фронтальний інтерфейс';
COMMENT ON COLUMN BARS.RI_MESSAGES.KF IS 'Код филиала';
COMMENT ON COLUMN BARS.RI_MESSAGES.COMM IS 'Коментар';




PROMPT *** Create  constraint PK_RI_MESSAGES ***
begin   
 execute immediate '
  ALTER TABLE BARS.RI_MESSAGES ADD CONSTRAINT PK_RI_MESSAGES PRIMARY KEY (KF, KEY)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_RI_MESSAGES_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.RI_MESSAGES MODIFY (KF CONSTRAINT CC_RI_MESSAGES_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_RI_MESSAGES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_RI_MESSAGES ON BARS.RI_MESSAGES (KF, KEY) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  RI_MESSAGES ***
grant DELETE,INSERT,SELECT,UPDATE                                            on RI_MESSAGES     to ABS_ADMIN;
grant SELECT                                                                 on RI_MESSAGES     to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on RI_MESSAGES     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on RI_MESSAGES     to BARS_DM;
grant DELETE,INSERT,SELECT                                                   on RI_MESSAGES     to START1;
grant SELECT                                                                 on RI_MESSAGES     to UPLD;
grant FLASHBACK,SELECT                                                       on RI_MESSAGES     to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/RI_MESSAGES.sql =========*** End *** =
PROMPT ===================================================================================== 
