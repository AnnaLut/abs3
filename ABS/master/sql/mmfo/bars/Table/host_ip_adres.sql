

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/HOST_IP_ADRES.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to HOST_IP_ADRES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''HOST_IP_ADRES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''HOST_IP_ADRES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''HOST_IP_ADRES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table HOST_IP_ADRES ***
begin 
  execute immediate '
  CREATE TABLE BARS.HOST_IP_ADRES 
   (	HOSTNAME VARCHAR2(64), 
	IP VARCHAR2(15)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to HOST_IP_ADRES ***
 exec bpa.alter_policies('HOST_IP_ADRES');


COMMENT ON TABLE BARS.HOST_IP_ADRES IS 'IP адреса рабочих станций';
COMMENT ON COLUMN BARS.HOST_IP_ADRES.HOSTNAME IS 'Наименование рабочей станции';
COMMENT ON COLUMN BARS.HOST_IP_ADRES.IP IS 'IP адрес';




PROMPT *** Create  constraint CC_HOSTIPADRES_HOSTNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.HOST_IP_ADRES MODIFY (HOSTNAME CONSTRAINT CC_HOSTIPADRES_HOSTNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_HOSTIPADRES_IP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.HOST_IP_ADRES MODIFY (IP CONSTRAINT CC_HOSTIPADRES_IP_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_HOSTIPADRES ***
begin   
 execute immediate '
  ALTER TABLE BARS.HOST_IP_ADRES ADD CONSTRAINT PK_HOSTIPADRES PRIMARY KEY (HOSTNAME)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_HOSTIPADRES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_HOSTIPADRES ON BARS.HOST_IP_ADRES (HOSTNAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  HOST_IP_ADRES ***
grant DELETE,INSERT,SELECT,UPDATE                                            on HOST_IP_ADRES   to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on HOST_IP_ADRES   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on HOST_IP_ADRES   to BARS_DM;
grant INSERT,SELECT,UPDATE                                                   on HOST_IP_ADRES   to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on HOST_IP_ADRES   to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/HOST_IP_ADRES.sql =========*** End ***
PROMPT ===================================================================================== 
