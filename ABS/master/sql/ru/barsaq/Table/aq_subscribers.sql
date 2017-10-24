

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/AQ_SUBSCRIBERS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  table AQ_SUBSCRIBERS ***
begin 
  execute immediate '
  CREATE TABLE BARSAQ.AQ_SUBSCRIBERS 
   (	NAME VARCHAR2(30), 
	DESCRIPTION VARCHAR2(250), 
	 CONSTRAINT PK_AQ_SUBSCRIBERS PRIMARY KEY (NAME) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSSMLI 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSAQ.AQ_SUBSCRIBERS IS 'Список допустимых подписчиков на очереди';
COMMENT ON COLUMN BARSAQ.AQ_SUBSCRIBERS.NAME IS 'Имя подписчика';
COMMENT ON COLUMN BARSAQ.AQ_SUBSCRIBERS.DESCRIPTION IS 'Описание подписчика';




PROMPT *** Create  constraint PK_AQ_SUBSCRIBERS ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.AQ_SUBSCRIBERS ADD CONSTRAINT PK_AQ_SUBSCRIBERS PRIMARY KEY (NAME)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_AQ_SUBSCRIBERS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSAQ.PK_AQ_SUBSCRIBERS ON BARSAQ.AQ_SUBSCRIBERS (NAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/AQ_SUBSCRIBERS.sql =========*** End 
PROMPT ===================================================================================== 
