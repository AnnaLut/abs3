

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WEB_USERPARAMS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WEB_USERPARAMS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WEB_USERPARAMS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WEB_USERPARAMS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WEB_USERPARAMS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WEB_USERPARAMS ***
begin 
  execute immediate '
  CREATE TABLE BARS.WEB_USERPARAMS 
   (	PAR VARCHAR2(256), 
	VAL VARCHAR2(256), 
	COMM VARCHAR2(1024), 
	USRID NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WEB_USERPARAMS ***
 exec bpa.alter_policies('WEB_USERPARAMS');


COMMENT ON TABLE BARS.WEB_USERPARAMS IS '“аблица пользовательских установок дл€ WEB';
COMMENT ON COLUMN BARS.WEB_USERPARAMS.PAR IS 'PAR - им€ параметра';
COMMENT ON COLUMN BARS.WEB_USERPARAMS.VAL IS 'VAL - значение параметра';
COMMENT ON COLUMN BARS.WEB_USERPARAMS.COMM IS 'COMM - зкомментарий';
COMMENT ON COLUMN BARS.WEB_USERPARAMS.USRID IS '';




PROMPT *** Create  constraint PK_WEB_USERPARAMS ***
begin   
 execute immediate '
  ALTER TABLE BARS.WEB_USERPARAMS ADD CONSTRAINT PK_WEB_USERPARAMS PRIMARY KEY (USRID, PAR)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_WEB_USERPARAMS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_WEB_USERPARAMS ON BARS.WEB_USERPARAMS (USRID, PAR) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WEB_USERPARAMS ***
grant SELECT                                                                 on WEB_USERPARAMS  to BARSREADER_ROLE;
grant SELECT                                                                 on WEB_USERPARAMS  to BARS_DM;
grant SELECT                                                                 on WEB_USERPARAMS  to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on WEB_USERPARAMS  to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WEB_USERPARAMS.sql =========*** End **
PROMPT ===================================================================================== 
