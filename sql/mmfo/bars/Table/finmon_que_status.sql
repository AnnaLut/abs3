

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FINMON_QUE_STATUS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FINMON_QUE_STATUS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FINMON_QUE_STATUS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''FINMON_QUE_STATUS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''FINMON_QUE_STATUS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FINMON_QUE_STATUS ***
begin 
  execute immediate '
  CREATE TABLE BARS.FINMON_QUE_STATUS 
   (	STATUS VARCHAR2(1), 
	NAME VARCHAR2(35)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FINMON_QUE_STATUS ***
 exec bpa.alter_policies('FINMON_QUE_STATUS');


COMMENT ON TABLE BARS.FINMON_QUE_STATUS IS 'Перечень статусов операций в очереди Фин.Мона';
COMMENT ON COLUMN BARS.FINMON_QUE_STATUS.STATUS IS 'Код статуса';
COMMENT ON COLUMN BARS.FINMON_QUE_STATUS.NAME IS 'Наименование';




PROMPT *** Create  constraint XPK_FINMONQUE_STATUS ***
begin   
 execute immediate '
  ALTER TABLE BARS.FINMON_QUE_STATUS ADD CONSTRAINT XPK_FINMONQUE_STATUS PRIMARY KEY (STATUS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_FINMONQUE_STATUS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_FINMONQUE_STATUS ON BARS.FINMON_QUE_STATUS (STATUS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FINMON_QUE_STATUS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on FINMON_QUE_STATUS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FINMON_QUE_STATUS to BARS_DM;
grant ALTER,DEBUG,DELETE,FLASHBACK,INDEX,INSERT,ON COMMIT REFRESH,QUERY REWRITE,REFERENCES,SELECT,UPDATE on FINMON_QUE_STATUS to FINMON;
grant DELETE,INSERT,SELECT,UPDATE                                            on FINMON_QUE_STATUS to FINMON01;



PROMPT *** Create SYNONYM  to FINMON_QUE_STATUS ***

  CREATE OR REPLACE PUBLIC SYNONYM FINMON_QUE_STATUS FOR BARS.FINMON_QUE_STATUS;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FINMON_QUE_STATUS.sql =========*** End
PROMPT ===================================================================================== 
