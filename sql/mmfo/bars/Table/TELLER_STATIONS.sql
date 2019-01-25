PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TELLER_STATIONS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TELLER_STATIONS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TELLER_STATIONS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TELLER_STATIONS ***
begin 
  execute immediate '
  CREATE TABLE BARS.TELLER_STATIONS 
   (	STATION_NAME VARCHAR2(60), 
	EQUIP_REF NUMBER(2,0), 
	URL VARCHAR2(100), 
	EQUIP_POSITION VARCHAR2(1) DEFAULT ''R'', 
	C_TYPE VARCHAR2(5) DEFAULT ''http''
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TELLER_STATIONS ***
 exec bpa.alter_policies('TELLER_STATIONS');


COMMENT ON TABLE BARS.TELLER_STATIONS IS 'Зв"язок робочих станцій теллерів та обладнання';
COMMENT ON COLUMN BARS.TELLER_STATIONS.URL IS 'Адреса обладнання в локальній мережі';
COMMENT ON COLUMN BARS.TELLER_STATIONS.EQUIP_POSITION IS 'L - Left, R - Right';
COMMENT ON COLUMN BARS.TELLER_STATIONS.C_TYPE IS 'http, https';
COMMENT ON COLUMN BARS.TELLER_STATIONS.STATION_NAME IS 'Найменування робочої станції';
COMMENT ON COLUMN BARS.TELLER_STATIONS.EQUIP_REF IS 'Посилання на обладнання';




PROMPT *** Create  constraint UQ_TEL_STA ***
begin   
 execute immediate '
  ALTER TABLE BARS.TELLER_STATIONS ADD CONSTRAINT UQ_TEL_STA UNIQUE (STATION_NAME)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint TELLER_STATION_CHECK ***
begin   
 execute immediate '
  ALTER TABLE BARS.TELLER_STATIONS ADD CONSTRAINT TELLER_STATION_CHECK CHECK (nvl(equip_position,''R'') in (''R'',''L'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UQ_TEL_STA ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UQ_TEL_STA ON BARS.TELLER_STATIONS (STATION_NAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TELLER_STATIONS ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TELLER_STATIONS to BARS_ACCESS_DEFROLE;
grant FLASHBACK,SELECT                                                       on TELLER_STATIONS to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TELLER_STATIONS.sql =========*** End *
PROMPT ===================================================================================== 
