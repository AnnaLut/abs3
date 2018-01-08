

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TABVAL_SORT.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TABVAL_SORT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TABVAL_SORT'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''TABVAL_SORT'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''TABVAL_SORT'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TABVAL_SORT ***
begin 
  execute immediate '
  CREATE TABLE BARS.TABVAL_SORT 
   (	USER_ID NUMBER(38,0), 
	KV NUMBER(3,0), 
	SORT_ORD NUMBER(5,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TABVAL_SORT ***
 exec bpa.alter_policies('TABVAL_SORT');


COMMENT ON TABLE BARS.TABVAL_SORT IS 'Сортировка валют для пользователей';
COMMENT ON COLUMN BARS.TABVAL_SORT.USER_ID IS 'Пользователь';
COMMENT ON COLUMN BARS.TABVAL_SORT.KV IS 'Код валюты';
COMMENT ON COLUMN BARS.TABVAL_SORT.SORT_ORD IS 'Порядок сортировки';




PROMPT *** Create  constraint FK_TABVALSORT_TABVAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.TABVAL_SORT ADD CONSTRAINT FK_TABVALSORT_TABVAL FOREIGN KEY (KV)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_TABVALSORT_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.TABVAL_SORT ADD CONSTRAINT FK_TABVALSORT_STAFF FOREIGN KEY (USER_ID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TABVALSORT_USERID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TABVAL_SORT MODIFY (USER_ID CONSTRAINT CC_TABVALSORT_USERID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TABVALSORT_KV_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TABVAL_SORT MODIFY (KV CONSTRAINT CC_TABVALSORT_KV_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_TABVALSORT ***
begin   
 execute immediate '
  ALTER TABLE BARS.TABVAL_SORT ADD CONSTRAINT PK_TABVALSORT PRIMARY KEY (USER_ID, KV)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TABVALSORT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TABVALSORT ON BARS.TABVAL_SORT (USER_ID, KV) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TABVAL_SORT ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TABVAL_SORT     to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TABVAL_SORT     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TABVAL_SORT     to BARS_DM;
grant SELECT                                                                 on TABVAL_SORT     to START1;
grant DELETE,INSERT,SELECT,UPDATE                                            on TABVAL_SORT     to TABVAL_SORT;
grant DELETE,INSERT,SELECT,UPDATE                                            on TABVAL_SORT     to TECH_MOM1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TABVAL_SORT     to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on TABVAL_SORT     to WR_REFREAD;
grant DELETE,INSERT,SELECT,UPDATE                                            on TABVAL_SORT     to ZAY;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TABVAL_SORT.sql =========*** End *** =
PROMPT ===================================================================================== 
