

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ASYNC_WEBUI.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ASYNC_WEBUI ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ASYNC_WEBUI'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ASYNC_WEBUI'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ASYNC_WEBUI ***
begin 
  execute immediate '
  CREATE TABLE BARS.ASYNC_WEBUI 
   (	WEBUI_ID NUMBER, 
	WEBUI_URL VARCHAR2(4000), 
	PARAMS VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ASYNC_WEBUI ***
 exec bpa.alter_policies('ASYNC_WEBUI');


COMMENT ON TABLE BARS.ASYNC_WEBUI IS 'Довідник веб-сервісів';
COMMENT ON COLUMN BARS.ASYNC_WEBUI.WEBUI_ID IS 'Ідентифікатор веб-сервіса';
COMMENT ON COLUMN BARS.ASYNC_WEBUI.WEBUI_URL IS 'URL веб-сервіса';
COMMENT ON COLUMN BARS.ASYNC_WEBUI.PARAMS IS 'Параметри веб-сервіса';




PROMPT *** Create  constraint PK_ASNWEB ***
begin   
 execute immediate '
  ALTER TABLE BARS.ASYNC_WEBUI ADD CONSTRAINT PK_ASNWEB PRIMARY KEY (WEBUI_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ASNWEB ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ASNWEB ON BARS.ASYNC_WEBUI (WEBUI_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ASYNC_WEBUI ***
grant SELECT                                                                 on ASYNC_WEBUI     to BARSREADER_ROLE;
grant SELECT                                                                 on ASYNC_WEBUI     to BARS_DM;
grant SELECT                                                                 on ASYNC_WEBUI     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ASYNC_WEBUI.sql =========*** End *** =
PROMPT ===================================================================================== 
