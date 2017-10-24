

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CONTRACTS.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CONTRACTS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CONTRACTS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CONTRACTS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CONTRACTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.CONTRACTS 
   (	ID NUMBER, 
	NAME VARCHAR2(50), 
	CLOSED NUMBER, 
	PID NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CONTRACTS ***
 exec bpa.alter_policies('CONTRACTS');


COMMENT ON TABLE BARS.CONTRACTS IS 'Субконтракты по Эксп-Имп.контрактам';
COMMENT ON COLUMN BARS.CONTRACTS.ID IS 'Код субконтракта';
COMMENT ON COLUMN BARS.CONTRACTS.NAME IS 'Имя субконтракта (не исп.)';
COMMENT ON COLUMN BARS.CONTRACTS.CLOSED IS 'Признак урегулир.субконтракта (не исп.)';
COMMENT ON COLUMN BARS.CONTRACTS.PID IS 'Код контракта';




PROMPT *** Create  constraint NK_CONTRACTS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.CONTRACTS MODIFY (ID CONSTRAINT NK_CONTRACTS_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CONTRACTS ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CONTRACTS       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CONTRACTS.sql =========*** End *** ===
PROMPT ===================================================================================== 
