

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CM_CREDITS.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CM_CREDITS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CM_CREDITS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CM_CREDITS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CM_CREDITS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CM_CREDITS ***
begin 
  execute immediate '
  CREATE TABLE BARS.CM_CREDITS 
   (	ND NUMBER, 
	BRANCH VARCHAR2(400), 
	KV NUMBER(3,0), 
	NLS VARCHAR2(400), 
	DCLASS VARCHAR2(2), 
	DVKR VARCHAR2(3), 
	DSUM NUMBER, 
	DDATE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CM_CREDITS ***
 exec bpa.alter_policies('CM_CREDITS');


COMMENT ON TABLE BARS.CM_CREDITS IS 'Кредитна фабрика: таблиця договорів та рейтингу клієнта по карткових кредитах';
COMMENT ON COLUMN BARS.CM_CREDITS.ND IS 'Номер договору';
COMMENT ON COLUMN BARS.CM_CREDITS.BRANCH IS '';
COMMENT ON COLUMN BARS.CM_CREDITS.KV IS 'Валюта рахунку';
COMMENT ON COLUMN BARS.CM_CREDITS.NLS IS 'Номер рахунку';
COMMENT ON COLUMN BARS.CM_CREDITS.DCLASS IS 'Клас позичальника, розрахований Кредитною Фабрикою';
COMMENT ON COLUMN BARS.CM_CREDITS.DVKR IS 'Внутрішній кредитний рейтинг, розрахований Кредитною Фабрикою';
COMMENT ON COLUMN BARS.CM_CREDITS.DSUM IS 'Сума кредиту';
COMMENT ON COLUMN BARS.CM_CREDITS.DDATE IS 'Дата видачі';




PROMPT *** Create  constraint PK_CM_CREDITS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CM_CREDITS ADD CONSTRAINT PK_CM_CREDITS PRIMARY KEY (ND, BRANCH)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CM_CREDITS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CM_CREDITS ON BARS.CM_CREDITS (ND, BRANCH) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CM_CREDITS ***
grant SELECT                                                                 on CM_CREDITS      to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CM_CREDITS.sql =========*** End *** ==
PROMPT ===================================================================================== 
