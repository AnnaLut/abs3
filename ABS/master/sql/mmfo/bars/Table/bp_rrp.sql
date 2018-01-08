

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BP_RRP.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BP_RRP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BP_RRP'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''BP_RRP'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''BP_RRP'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BP_RRP ***
begin 
  execute immediate '
  CREATE TABLE BARS.BP_RRP 
   (	RULE NUMBER(*,0), 
	MFO VARCHAR2(12), 
	FA CHAR(1), 
	BODY VARCHAR2(254), 
	NAME VARCHAR2(35), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BP_RRP ***
 exec bpa.alter_policies('BP_RRP');


COMMENT ON TABLE BARS.BP_RRP IS 'Условия автоматической блокировки
документов';
COMMENT ON COLUMN BARS.BP_RRP.KF IS '';
COMMENT ON COLUMN BARS.BP_RRP.RULE IS 'Код бизнес-правила';
COMMENT ON COLUMN BARS.BP_RRP.MFO IS 'Код МФО банка';
COMMENT ON COLUMN BARS.BP_RRP.FA IS 'Флаг активности (1 - активно, 0 - нет)';
COMMENT ON COLUMN BARS.BP_RRP.BODY IS 'Текст бизнес-правила';
COMMENT ON COLUMN BARS.BP_RRP.NAME IS '';




PROMPT *** Create  constraint SYS_C009818 ***
begin   
 execute immediate '
  ALTER TABLE BARS.BP_RRP MODIFY (RULE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BPRRP_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BP_RRP MODIFY (KF CONSTRAINT CC_BPRRP_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_BPRRP ***
begin   
 execute immediate '
  ALTER TABLE BARS.BP_RRP ADD CONSTRAINT PK_BPRRP PRIMARY KEY (KF, RULE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BPRRP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BPRRP ON BARS.BP_RRP (KF, RULE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BP_RRP ***
grant DELETE,INSERT,SELECT,UPDATE                                            on BP_RRP          to BARS014;
grant SELECT                                                                 on BP_RRP          to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on BP_RRP          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BP_RRP          to BARS_DM;
grant SELECT                                                                 on BP_RRP          to START1;
grant SELECT                                                                 on BP_RRP          to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BP_RRP          to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BP_RRP.sql =========*** End *** ======
PROMPT ===================================================================================== 
