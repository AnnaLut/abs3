

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/S_NR.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to S_NR ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''S_NR'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''S_NR'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''S_NR'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table S_NR ***
begin 
  execute immediate '
  CREATE TABLE BARS.S_NR 
   (	K_RK VARCHAR2(1), 
	N_RK VARCHAR2(120), 
	S_RK VARCHAR2(38)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to S_NR ***
 exec bpa.alter_policies('S_NR');


COMMENT ON TABLE BARS.S_NR IS 'Доп.реквизиты СЭП';
COMMENT ON COLUMN BARS.S_NR.K_RK IS 'Код реквизита';
COMMENT ON COLUMN BARS.S_NR.N_RK IS 'Наименование реквизита';
COMMENT ON COLUMN BARS.S_NR.S_RK IS 'Неизвестно что';




PROMPT *** Create  constraint PK_SNR ***
begin   
 execute immediate '
  ALTER TABLE BARS.S_NR ADD CONSTRAINT PK_SNR PRIMARY KEY (K_RK)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SNR_KRK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.S_NR MODIFY (K_RK CONSTRAINT CC_SNR_KRK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SNR_NRK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.S_NR MODIFY (N_RK CONSTRAINT CC_SNR_NRK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SNR ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SNR ON BARS.S_NR (K_RK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  S_NR ***
grant SELECT                                                                 on S_NR            to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on S_NR            to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on S_NR            to WR_ALL_RIGHTS;
grant SELECT                                                                 on S_NR            to WR_QDOCS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/S_NR.sql =========*** End *** ========
PROMPT ===================================================================================== 
