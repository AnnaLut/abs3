

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/REBRANCH_DEPOSIT.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to REBRANCH_DEPOSIT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''REBRANCH_DEPOSIT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''REBRANCH_DEPOSIT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''REBRANCH_DEPOSIT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table REBRANCH_DEPOSIT ***
begin 
  execute immediate '
  CREATE TABLE BARS.REBRANCH_DEPOSIT 
   (	DPT_ID NUMBER(38,0), 
	BRANCH_NEW VARCHAR2(30), 
	OUTMSG VARCHAR2(100)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to REBRANCH_DEPOSIT ***
 exec bpa.alter_policies('REBRANCH_DEPOSIT');


COMMENT ON TABLE BARS.REBRANCH_DEPOSIT IS '';
COMMENT ON COLUMN BARS.REBRANCH_DEPOSIT.DPT_ID IS '';
COMMENT ON COLUMN BARS.REBRANCH_DEPOSIT.BRANCH_NEW IS '';
COMMENT ON COLUMN BARS.REBRANCH_DEPOSIT.OUTMSG IS '';




PROMPT *** Create  constraint CC_DPTREBRANCH_DPTID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.REBRANCH_DEPOSIT MODIFY (DPT_ID CONSTRAINT CC_DPTREBRANCH_DPTID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTREBRANCH_BRNEW_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.REBRANCH_DEPOSIT MODIFY (BRANCH_NEW CONSTRAINT CC_DPTREBRANCH_BRNEW_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  REBRANCH_DEPOSIT ***
grant DELETE,INSERT,SELECT,UPDATE                                            on REBRANCH_DEPOSIT to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on REBRANCH_DEPOSIT to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on REBRANCH_DEPOSIT to DPT_ADMIN;
grant FLASHBACK,SELECT                                                       on REBRANCH_DEPOSIT to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/REBRANCH_DEPOSIT.sql =========*** End 
PROMPT ===================================================================================== 
