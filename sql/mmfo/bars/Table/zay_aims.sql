

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ZAY_AIMS.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ZAY_AIMS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ZAY_AIMS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ZAY_AIMS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ZAY_AIMS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ZAY_AIMS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ZAY_AIMS 
   (	AIM NUMBER, 
	NAME VARCHAR2(50), 
	TYPE NUMBER, 
	DESCRIPTION VARCHAR2(100), 
	DESCRIPTION_ENG VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 1 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ZAY_AIMS ***
 exec bpa.alter_policies('ZAY_AIMS');


COMMENT ON TABLE BARS.ZAY_AIMS IS 'Справочник целей покупки-продажи валюты';
COMMENT ON COLUMN BARS.ZAY_AIMS.AIM IS 'Код цели';
COMMENT ON COLUMN BARS.ZAY_AIMS.NAME IS 'Наименование цели';
COMMENT ON COLUMN BARS.ZAY_AIMS.TYPE IS 'Тип цели: 1-покупка, 2-продажа, 3-обз.продажа';
COMMENT ON COLUMN BARS.ZAY_AIMS.DESCRIPTION IS '';
COMMENT ON COLUMN BARS.ZAY_AIMS.DESCRIPTION_ENG IS '';




PROMPT *** Create  constraint PK_ZAYAIMS ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_AIMS ADD CONSTRAINT PK_ZAYAIMS PRIMARY KEY (AIM)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_ZAY_AIM_AIM ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_AIMS MODIFY (AIM CONSTRAINT NK_ZAY_AIM_AIM NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ZAYAIMS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ZAYAIMS ON BARS.ZAY_AIMS (AIM) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ZAY_AIMS ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ZAY_AIMS        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ZAY_AIMS        to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ZAY_AIMS        to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on ZAY_AIMS        to WR_REFREAD;
grant DELETE,INSERT,SELECT,UPDATE                                            on ZAY_AIMS        to ZAY;



PROMPT *** Create SYNONYM  to ZAY_AIMS ***

  CREATE OR REPLACE PUBLIC SYNONYM ZAY_AIMS FOR BARS.ZAY_AIMS;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ZAY_AIMS.sql =========*** End *** ====
PROMPT ===================================================================================== 
