

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_RATE_RISE.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_RATE_RISE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_RATE_RISE'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''DPT_RATE_RISE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_RATE_RISE ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_RATE_RISE 
   (	VIDD NUMBER(38,0), 
	DURATION_M NUMBER(10,0), 
	DURATION_D NUMBER(10,0), 
	IR NUMBER(20,4), 
	OP NUMBER(38,0), 
	BR NUMBER(38,0), 
	ID NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 5 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_RATE_RISE ***
 exec bpa.alter_policies('DPT_RATE_RISE');


COMMENT ON TABLE BARS.DPT_RATE_RISE IS '����� ������������� ������ �� ������� ���������';
COMMENT ON COLUMN BARS.DPT_RATE_RISE.VIDD IS '��� ������';
COMMENT ON COLUMN BARS.DPT_RATE_RISE.DURATION_M IS '���� ��������� ������ � ������� �� ��� �������� ������';
COMMENT ON COLUMN BARS.DPT_RATE_RISE.DURATION_D IS '���� ��������� ������ � ���� �� ��� �������� ������';
COMMENT ON COLUMN BARS.DPT_RATE_RISE.IR IS '�������.%-��� ������';
COMMENT ON COLUMN BARS.DPT_RATE_RISE.OP IS '��� �������� ����� IR � BR';
COMMENT ON COLUMN BARS.DPT_RATE_RISE.BR IS '��� ������� %-��� ������';
COMMENT ON COLUMN BARS.DPT_RATE_RISE.ID IS '';




PROMPT *** Create  constraint FK_DPTRATERISE_INTOP ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_RATE_RISE ADD CONSTRAINT FK_DPTRATERISE_INTOP FOREIGN KEY (OP)
	  REFERENCES BARS.INT_OP (OP) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTRATERISE_BRATES ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_RATE_RISE ADD CONSTRAINT FK_DPTRATERISE_BRATES FOREIGN KEY (BR)
	  REFERENCES BARS.BRATES (BR_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTRATERISE_DPTVIDD ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_RATE_RISE ADD CONSTRAINT FK_DPTRATERISE_DPTVIDD FOREIGN KEY (VIDD)
	  REFERENCES BARS.DPT_VIDD (VIDD) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTRATERISE_INTIDN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_RATE_RISE ADD CONSTRAINT FK_DPTRATERISE_INTIDN FOREIGN KEY (ID)
	  REFERENCES BARS.INT_IDN (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_DPTRATERISE ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_RATE_RISE ADD CONSTRAINT PK_DPTRATERISE PRIMARY KEY (VIDD, DURATION_M, DURATION_D)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTRATERISE_DURATIOND_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_RATE_RISE MODIFY (DURATION_D CONSTRAINT CC_DPTRATERISE_DURATIOND_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTRATERISE_DURATIONM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_RATE_RISE MODIFY (DURATION_M CONSTRAINT CC_DPTRATERISE_DURATIONM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTRATERISE_VIDD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_RATE_RISE MODIFY (VIDD CONSTRAINT CC_DPTRATERISE_VIDD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTRATERISE_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_RATE_RISE MODIFY (ID CONSTRAINT CC_DPTRATERISE_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTRATERISE_RATES ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_RATE_RISE ADD CONSTRAINT CC_DPTRATERISE_RATES CHECK ((ir is not null and op is null and br is null)
    or (br is not null and op is null and ir is null)
    or (ir is not null and nvl(op, 0) > 0 and br is not null)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPTRATERISE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPTRATERISE ON BARS.DPT_RATE_RISE (VIDD, DURATION_M, DURATION_D) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_RATE_RISE ***
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_RATE_RISE   to ABS_ADMIN;
grant SELECT                                                                 on DPT_RATE_RISE   to BARSAQ;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_RATE_RISE   to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_RATE_RISE   to DPT;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_RATE_RISE   to DPT_ADMIN;
grant SELECT                                                                 on DPT_RATE_RISE   to KLBX;
grant SELECT                                                                 on DPT_RATE_RISE   to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_RATE_RISE   to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on DPT_RATE_RISE   to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_RATE_RISE.sql =========*** End ***
PROMPT ===================================================================================== 
