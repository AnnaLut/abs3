

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_STOP_A.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_STOP_A ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_STOP_A'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_STOP_A'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_STOP_A'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_STOP_A ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_STOP_A 
   (	ID NUMBER(38,0), 
	K_SROK NUMBER(5,2), 
	K_PROC NUMBER(5,2), 
	SH_PROC NUMBER(2,0), 
	K_TERM NUMBER(10,0), 
	SH_TERM NUMBER(2,0) DEFAULT 0
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_STOP_A ***
 exec bpa.alter_policies('DPT_STOP_A');


COMMENT ON TABLE BARS.DPT_STOP_A IS 'Справочник штрафов (расшифровка состава штрафов)';
COMMENT ON COLUMN BARS.DPT_STOP_A.ID IS 'ID';
COMMENT ON COLUMN BARS.DPT_STOP_A.K_SROK IS '';
COMMENT ON COLUMN BARS.DPT_STOP_A.K_PROC IS '';
COMMENT ON COLUMN BARS.DPT_STOP_A.SH_PROC IS '';
COMMENT ON COLUMN BARS.DPT_STOP_A.K_TERM IS '';
COMMENT ON COLUMN BARS.DPT_STOP_A.SH_TERM IS '';




PROMPT *** Create  constraint FK_DPTSTOPA_DPTSHTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_STOP_A ADD CONSTRAINT FK_DPTSTOPA_DPTSHTYPE FOREIGN KEY (SH_PROC)
	  REFERENCES BARS.DPT_SHTYPE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_DPTSTOPA ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_STOP_A ADD CONSTRAINT PK_DPTSTOPA PRIMARY KEY (ID, K_SROK)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint DPT_ST2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_STOP_A ADD CONSTRAINT DPT_ST2 FOREIGN KEY (ID)
	  REFERENCES BARS.DPT_STOP (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTSTOPA_DPTSHTERM ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_STOP_A ADD CONSTRAINT FK_DPTSTOPA_DPTSHTERM FOREIGN KEY (SH_TERM)
	  REFERENCES BARS.DPT_SHTERM (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTSTOPA_SHTERM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_STOP_A MODIFY (SH_TERM CONSTRAINT CC_DPTSTOPA_SHTERM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTSTOPA_KSROK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_STOP_A MODIFY (K_SROK CONSTRAINT CC_DPTSTOPA_KSROK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTSTOPA_KPROC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_STOP_A MODIFY (K_PROC CONSTRAINT CC_DPTSTOPA_KPROC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTSTOPA_SHPROC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_STOP_A MODIFY (SH_PROC CONSTRAINT CC_DPTSTOPA_SHPROC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTSTOPA_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_STOP_A MODIFY (ID CONSTRAINT CC_DPTSTOPA_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPTSTOPA ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPTSTOPA ON BARS.DPT_STOP_A (ID, K_SROK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_STOP_A ***
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_STOP_A      to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_STOP_A      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_STOP_A      to BARS_DM;
grant SELECT                                                                 on DPT_STOP_A      to CC_DOC;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_STOP_A      to DPT;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_STOP_A      to DPT_ADMIN;
grant SELECT                                                                 on DPT_STOP_A      to START1;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_STOP_A      to VKLAD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_STOP_A      to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on DPT_STOP_A      to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_STOP_A.sql =========*** End *** ==
PROMPT ===================================================================================== 
