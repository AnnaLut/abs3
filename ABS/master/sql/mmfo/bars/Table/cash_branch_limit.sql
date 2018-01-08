

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CASH_BRANCH_LIMIT.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CASH_BRANCH_LIMIT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CASH_BRANCH_LIMIT'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CASH_BRANCH_LIMIT'', ''FILIAL'' , ''B'', ''B'', ''B'', ''B'');
               bpa.alter_policy_info(''CASH_BRANCH_LIMIT'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CASH_BRANCH_LIMIT ***
begin 
  execute immediate '
  CREATE TABLE BARS.CASH_BRANCH_LIMIT 
   (	BRANCH VARCHAR2(30), 
	KV NUMBER(3,0) DEFAULT 0, 
	LIM_P NUMBER(24,0) DEFAULT 0, 
	LIM_M NUMBER(24,0) DEFAULT 0, 
	L_T VARCHAR2(1), 
	DAT_LIM DATE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CASH_BRANCH_LIMIT ***
 exec bpa.alter_policies('CASH_BRANCH_LIMIT');


COMMENT ON TABLE BARS.CASH_BRANCH_LIMIT IS '';
COMMENT ON COLUMN BARS.CASH_BRANCH_LIMIT.BRANCH IS '';
COMMENT ON COLUMN BARS.CASH_BRANCH_LIMIT.KV IS '';
COMMENT ON COLUMN BARS.CASH_BRANCH_LIMIT.LIM_P IS 'Ліміт поточний';
COMMENT ON COLUMN BARS.CASH_BRANCH_LIMIT.LIM_M IS 'Ліміт максимальний';
COMMENT ON COLUMN BARS.CASH_BRANCH_LIMIT.L_T IS 'Тип ліміту: 1 - ТВБВ 2 рівня; 2 - банковати; 3 - ТВБВ 3 рівня';
COMMENT ON COLUMN BARS.CASH_BRANCH_LIMIT.DAT_LIM IS '';




PROMPT *** Create  constraint XPK_CASH_BRANCH_LIMIT ***
begin   
 execute immediate '
  ALTER TABLE BARS.CASH_BRANCH_LIMIT ADD CONSTRAINT XPK_CASH_BRANCH_LIMIT PRIMARY KEY (BRANCH, KV, L_T, DAT_LIM)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CASH_BRANCH_LIMIT_KV ***
begin   
 execute immediate '
  ALTER TABLE BARS.CASH_BRANCH_LIMIT ADD CONSTRAINT FK_CASH_BRANCH_LIMIT_KV FOREIGN KEY (KV)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007843 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CASH_BRANCH_LIMIT MODIFY (DAT_LIM NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007842 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CASH_BRANCH_LIMIT MODIFY (L_T NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007841 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CASH_BRANCH_LIMIT MODIFY (LIM_M NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007840 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CASH_BRANCH_LIMIT MODIFY (LIM_P NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007839 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CASH_BRANCH_LIMIT MODIFY (KV NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CASHBRANCHLIMIT_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.CASH_BRANCH_LIMIT ADD CONSTRAINT FK_CASHBRANCHLIMIT_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) ON DELETE CASCADE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007838 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CASH_BRANCH_LIMIT MODIFY (BRANCH NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CASH_BRANCH_LIMIT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CASH_BRANCH_LIMIT ON BARS.CASH_BRANCH_LIMIT (BRANCH, KV, L_T, DAT_LIM) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CASH_BRANCH_LIMIT ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CASH_BRANCH_LIMIT to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CASH_BRANCH_LIMIT to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CASH_BRANCH_LIMIT to RPBN001;
grant DELETE                                                                 on CASH_BRANCH_LIMIT to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CASH_BRANCH_LIMIT.sql =========*** End
PROMPT ===================================================================================== 
