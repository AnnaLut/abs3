

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/MIGR_DPT_BR.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to MIGR_DPT_BR ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''MIGR_DPT_BR'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''MIGR_DPT_BR'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table MIGR_DPT_BR ***
begin 
  execute immediate '
  CREATE TABLE BARS.MIGR_DPT_BR 
   (	NBS VARCHAR2(4), 
	OB22 VARCHAR2(2), 
	BR NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to MIGR_DPT_BR ***
 exec bpa.alter_policies('MIGR_DPT_BR');


COMMENT ON TABLE BARS.MIGR_DPT_BR IS 'Перелік БР+ОБ22 для заповнення базових ставок по котловим рах.';
COMMENT ON COLUMN BARS.MIGR_DPT_BR.NBS IS 'Балансовий рахунок';
COMMENT ON COLUMN BARS.MIGR_DPT_BR.OB22 IS 'Параметр ОБ22 для бал.рах.';
COMMENT ON COLUMN BARS.MIGR_DPT_BR.BR IS 'Код базової ставки';




PROMPT *** Create  constraint PK_MIGRDPTBR ***
begin   
 execute immediate '
  ALTER TABLE BARS.MIGR_DPT_BR ADD CONSTRAINT PK_MIGRDPTBR PRIMARY KEY (NBS, OB22)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_MIGRDPTBR_NBS ***
begin   
 execute immediate '
  ALTER TABLE BARS.MIGR_DPT_BR ADD CONSTRAINT CC_MIGRDPTBR_NBS CHECK (NBS in (''2620'',''2630'',''2635'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_MIGRDPTBR_NBS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.MIGR_DPT_BR MODIFY (NBS CONSTRAINT CC_MIGRDPTBR_NBS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_MIGRDPTBR_OB22_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.MIGR_DPT_BR MODIFY (OB22 CONSTRAINT CC_MIGRDPTBR_OB22_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_MIGRDPTBR_BR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.MIGR_DPT_BR MODIFY (BR CONSTRAINT CC_MIGRDPTBR_BR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_MIGRDPTBR ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_MIGRDPTBR ON BARS.MIGR_DPT_BR (NBS, OB22) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  MIGR_DPT_BR ***
grant DELETE,INSERT,SELECT,UPDATE                                            on MIGR_DPT_BR     to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on MIGR_DPT_BR     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on MIGR_DPT_BR     to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on MIGR_DPT_BR     to DPT_ADMIN;
grant SELECT                                                                 on MIGR_DPT_BR     to START1;
grant FLASHBACK,SELECT                                                       on MIGR_DPT_BR     to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/MIGR_DPT_BR.sql =========*** End *** =
PROMPT ===================================================================================== 
