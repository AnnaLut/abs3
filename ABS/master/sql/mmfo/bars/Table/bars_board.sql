

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BARS_BOARD.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BARS_BOARD ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BARS_BOARD'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BARS_BOARD'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''BARS_BOARD'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BARS_BOARD ***
begin 
  execute immediate '
  CREATE TABLE BARS.BARS_BOARD 
   (	ID NUMBER(38,0), 
	MSG_DATE DATE DEFAULT sysdate, 
	MSG_TITLE VARCHAR2(500), 
	MSG_TEXT CLOB, 
	WRITER VARCHAR2(30) DEFAULT USER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD 
 LOB (MSG_TEXT) STORE AS BASICFILE (
  TABLESPACE BRSMDLD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BARS_BOARD ***
 exec bpa.alter_policies('BARS_BOARD');


COMMENT ON TABLE BARS.BARS_BOARD IS 'сообщени€ доски объ€влений';
COMMENT ON COLUMN BARS.BARS_BOARD.ID IS 'идентификатор сообщени€';
COMMENT ON COLUMN BARS.BARS_BOARD.MSG_DATE IS '';
COMMENT ON COLUMN BARS.BARS_BOARD.MSG_TITLE IS 'тема сообщени€';
COMMENT ON COLUMN BARS.BARS_BOARD.MSG_TEXT IS 'текст сообщени€';
COMMENT ON COLUMN BARS.BARS_BOARD.WRITER IS '';




PROMPT *** Create  constraint PK_BARSBOARD ***
begin   
 execute immediate '
  ALTER TABLE BARS.BARS_BOARD ADD CONSTRAINT PK_BARSBOARD PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BARSBOARD_MSGDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BARS_BOARD MODIFY (MSG_DATE CONSTRAINT CC_BARSBOARD_MSGDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BARSBOARD_MSGTITLE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BARS_BOARD MODIFY (MSG_TITLE CONSTRAINT CC_BARSBOARD_MSGTITLE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BARSBOARD ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BARSBOARD ON BARS.BARS_BOARD (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BARS_BOARD ***
grant DELETE,INSERT,SELECT,UPDATE                                            on BARS_BOARD      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BARS_BOARD      to BARS_DM;
grant SELECT                                                                 on BARS_BOARD      to BASIC_INFO;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BARS_BOARD      to WR_ALL_RIGHTS;
grant DELETE,INSERT,SELECT,UPDATE                                            on BARS_BOARD      to WR_BOARD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BARS_BOARD.sql =========*** End *** ==
PROMPT ===================================================================================== 
