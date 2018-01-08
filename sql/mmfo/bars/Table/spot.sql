

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SPOT.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SPOT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SPOT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SPOT'', ''FILIAL'' , ''F'', ''F'', ''F'', ''F'');
               bpa.alter_policy_info(''SPOT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SPOT ***
begin 
  execute immediate '
  CREATE TABLE BARS.SPOT 
   (	KV NUMBER(38,0), 
	VDATE DATE, 
	ACC NUMBER(*,0), 
	RATE_K NUMBER(38,15), 
	RATE_P NUMBER(38,15), 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	RATE_SPOT NUMBER(24,9)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SPOT ***
 exec bpa.alter_policies('SPOT');


COMMENT ON TABLE BARS.SPOT IS 'СПРОТ-курсы по валютным позициям';
COMMENT ON COLUMN BARS.SPOT.KV IS 'Код валюты';
COMMENT ON COLUMN BARS.SPOT.VDATE IS 'Банк.дата расчета курса';
COMMENT ON COLUMN BARS.SPOT.ACC IS 'Внутр.№ счета вал.поз.';
COMMENT ON COLUMN BARS.SPOT.RATE_K IS 'Курс поКупки';
COMMENT ON COLUMN BARS.SPOT.RATE_P IS 'Курс Продажи';
COMMENT ON COLUMN BARS.SPOT.BRANCH IS 'Код подразделения';
COMMENT ON COLUMN BARS.SPOT.RATE_SPOT IS '';




PROMPT *** Create  constraint SYS_C005308 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPOT MODIFY (VDATE NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SPOT ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPOT ADD CONSTRAINT PK_SPOT PRIMARY KEY (ACC, VDATE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SPOT_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPOT ADD CONSTRAINT FK_SPOT_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SPOT_KV ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPOT ADD CONSTRAINT FK_SPOT_KV FOREIGN KEY (KV)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SPOT_VP_LIST ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPOT ADD CONSTRAINT FK_SPOT_VP_LIST FOREIGN KEY (ACC)
	  REFERENCES BARS.VP_LIST (ACC3800) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005307 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPOT MODIFY (KV NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SPOT_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPOT MODIFY (BRANCH CONSTRAINT CC_SPOT_BRANCH_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SPOT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SPOT ON BARS.SPOT (ACC, VDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SPOT ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SPOT            to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SPOT            to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SPOT            to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on SPOT            to CUR_RATES;
grant SELECT                                                                 on SPOT            to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SPOT            to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on SPOT            to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SPOT.sql =========*** End *** ========
PROMPT ===================================================================================== 
