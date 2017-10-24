

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ZAY_RECIPIENTS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ZAY_RECIPIENTS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ZAY_RECIPIENTS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ZAY_RECIPIENTS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ZAY_RECIPIENTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ZAY_RECIPIENTS 
   (	URL VARCHAR2(256), 
	MFO VARCHAR2(10)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ZAY_RECIPIENTS ***
 exec bpa.alter_policies('ZAY_RECIPIENTS');


COMMENT ON TABLE BARS.ZAY_RECIPIENTS IS 'Довідник шляхів до вебсервісів РУ';
COMMENT ON COLUMN BARS.ZAY_RECIPIENTS.URL IS 'url сервісу на стороні РУ';
COMMENT ON COLUMN BARS.ZAY_RECIPIENTS.MFO IS 'МФО РУ';




PROMPT *** Create  constraint UK_ZAYRECIPIENTSMFO ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_RECIPIENTS ADD CONSTRAINT UK_ZAYRECIPIENTSMFO UNIQUE (MFO)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_RECIPIENTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_RECIPIENTS ADD CONSTRAINT PK_RECIPIENTS PRIMARY KEY (URL)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_RECIPIENTS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_RECIPIENTS ON BARS.ZAY_RECIPIENTS (URL) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_ZAYRECIPIENTSMFO ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_ZAYRECIPIENTSMFO ON BARS.ZAY_RECIPIENTS (MFO) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ZAY_RECIPIENTS ***
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on ZAY_RECIPIENTS  to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ZAY_RECIPIENTS.sql =========*** End **
PROMPT ===================================================================================== 
