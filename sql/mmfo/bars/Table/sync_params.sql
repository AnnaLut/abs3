

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SYNC_PARAMS.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SYNC_PARAMS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SYNC_PARAMS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SYNC_PARAMS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SYNC_PARAMS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SYNC_PARAMS ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.SYNC_PARAMS 
   (	PARAMS VARCHAR2(32), 
	TYPE VARCHAR2(32), 
	VALUE VARCHAR2(4000)
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SYNC_PARAMS ***
 exec bpa.alter_policies('SYNC_PARAMS');


COMMENT ON TABLE BARS.SYNC_PARAMS IS '“имчасова таблиц€ значень параметр≥в сеансу обм≥ну даними через WEB-серв≥с';
COMMENT ON COLUMN BARS.SYNC_PARAMS.PARAMS IS 'ѕсевдон≥м параметру';
COMMENT ON COLUMN BARS.SYNC_PARAMS.TYPE IS '“ип параметру';
COMMENT ON COLUMN BARS.SYNC_PARAMS.VALUE IS '«наченн€ параметру';




PROMPT *** Create  constraint CC_SYNCPARAMS_TYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.SYNC_PARAMS ADD CONSTRAINT CC_SYNCPARAMS_TYPE CHECK (type in (''NUM'', ''STR'', ''DATE'', ''DATETIME'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SYNCPARAMS ***
begin   
 execute immediate '
  ALTER TABLE BARS.SYNC_PARAMS ADD CONSTRAINT PK_SYNCPARAMS PRIMARY KEY (PARAMS) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SYNCPARAMS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SYNCPARAMS ON BARS.SYNC_PARAMS (PARAMS) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SYNC_PARAMS ***
grant SELECT                                                                 on SYNC_PARAMS     to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SYNC_PARAMS     to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SYNC_PARAMS     to CIM_ROLE;
grant SELECT                                                                 on SYNC_PARAMS     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SYNC_PARAMS.sql =========*** End *** =
PROMPT ===================================================================================== 
