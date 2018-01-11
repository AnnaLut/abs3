

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PS_SPARAM.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PS_SPARAM ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PS_SPARAM'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''PS_SPARAM'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''PS_SPARAM'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PS_SPARAM ***
begin 
  execute immediate '
  CREATE TABLE BARS.PS_SPARAM 
   (	NBS CHAR(4), 
	SPID NUMBER(38,0), 
	OPT CHAR(1), 
	SQLVAL VARCHAR2(500)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PS_SPARAM ***
 exec bpa.alter_policies('PS_SPARAM');


COMMENT ON TABLE BARS.PS_SPARAM IS 'Таблица связи ПС и спецпараметров';
COMMENT ON COLUMN BARS.PS_SPARAM.NBS IS 'Балансовый счет';
COMMENT ON COLUMN BARS.PS_SPARAM.SPID IS 'Идентификатор спецпараметра';
COMMENT ON COLUMN BARS.PS_SPARAM.OPT IS 'Обязательность заполнения спецпараметра (1/0)';
COMMENT ON COLUMN BARS.PS_SPARAM.SQLVAL IS 'Sql-выражение для умолчательного значения спецпараметра';




PROMPT *** Create  constraint PK_PSSPARAM ***
begin   
 execute immediate '
  ALTER TABLE BARS.PS_SPARAM ADD CONSTRAINT PK_PSSPARAM PRIMARY KEY (NBS, SPID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PSSPARAM_OPT ***
begin   
 execute immediate '
  ALTER TABLE BARS.PS_SPARAM ADD CONSTRAINT CC_PSSPARAM_OPT CHECK (opt in (''0'', ''1'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PSSPARAM_NBS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PS_SPARAM MODIFY (NBS CONSTRAINT CC_PSSPARAM_NBS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PSSPARAM_SPID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PS_SPARAM MODIFY (SPID CONSTRAINT CC_PSSPARAM_SPID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PSSPARAM ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_PSSPARAM ON BARS.PS_SPARAM (NBS, SPID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PS_SPARAM ***
grant DELETE,INSERT,SELECT,UPDATE                                            on PS_SPARAM       to ABS_ADMIN;
grant SELECT                                                                 on PS_SPARAM       to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on PS_SPARAM       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PS_SPARAM       to BARS_DM;
grant SELECT                                                                 on PS_SPARAM       to CUST001;
grant SELECT                                                                 on PS_SPARAM       to START1;
grant SELECT                                                                 on PS_SPARAM       to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on PS_SPARAM       to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on PS_SPARAM       to WR_REFREAD;
grant SELECT                                                                 on PS_SPARAM       to WR_VIEWACC;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PS_SPARAM.sql =========*** End *** ===
PROMPT ===================================================================================== 
