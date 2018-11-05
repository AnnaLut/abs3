

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ASVO_IMMOBILE_HISTORY.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ASVO_IMMOBILE_HISTORY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ASVO_IMMOBILE_HISTORY'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ASVO_IMMOBILE_HISTORY'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ASVO_IMMOBILE_HISTORY ***
begin 
  execute immediate 'CREATE TABLE ASVO_IMMOBILE_HISTORY
    (
      KEY        NUMBER,
      TAG        VARCHAR2(128),
      old        VARCHAR2(255),
      new        VARCHAR2(255),
	  chgdate    DATE,
      donebuy    varchar2(64),
	  table_name varchar2(30)
    )
 SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

PROMPT *** ALTER_POLICIES to SCALE_IMMOBILE ***
 exec bpa.alter_policies('ASVO_IMMOBILE_HISTORY');

PROMPT *** Create  index IDX_ACC_OV_HIST ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_KEY ON BARS.ASVO_IMMOBILE_HISTORY (KEY) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/ 

PROMPT *** Create  grants  ASVO_IMMOBILE_HISTORY  ***
grant DELETE,INSERT,SELECT,UPDATE                                            on ASVO_IMMOBILE_HISTORY    to BARS_ACCESS_DEFROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ASVO_IMMOBILE_HISTORY    to WR_ALL_RIGHTS;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ASVO_IMMOBILE_HISTORY .sql =========*** End ***
PROMPT ===================================================================================== 
