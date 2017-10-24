

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/VP_LIST.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to VP_LIST ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''VP_LIST'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''VP_LIST'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table VP_LIST ***
begin 
  execute immediate '
  CREATE TABLE BARS.VP_LIST 
   (	ACC3800 NUMBER(38,0), 
	ACC3801 NUMBER(38,0), 
	ACC6204 NUMBER(38,0), 
	COMM VARCHAR2(30), 
	ACC_RRD NUMBER(38,0), 
	ACC_RRR NUMBER(38,0), 
	ACC_RRS NUMBER(38,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to VP_LIST ***
 exec bpa.alter_policies('VP_LIST');


COMMENT ON TABLE BARS.VP_LIST IS '������ �������� �������';
COMMENT ON COLUMN BARS.VP_LIST.ACC3800 IS '';
COMMENT ON COLUMN BARS.VP_LIST.ACC3801 IS '';
COMMENT ON COLUMN BARS.VP_LIST.ACC6204 IS '';
COMMENT ON COLUMN BARS.VP_LIST.COMM IS '�����������';
COMMENT ON COLUMN BARS.VP_LIST.ACC_RRD IS '';
COMMENT ON COLUMN BARS.VP_LIST.ACC_RRR IS '';
COMMENT ON COLUMN BARS.VP_LIST.ACC_RRS IS '';
COMMENT ON COLUMN BARS.VP_LIST.KF IS '';




PROMPT *** Create  constraint FK_VPLIST_ACCOUNTS5 ***
begin   
 execute immediate '
  ALTER TABLE BARS.VP_LIST ADD CONSTRAINT FK_VPLIST_ACCOUNTS5 FOREIGN KEY (KF, ACC_RRS)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_VPLIST_ACCOUNTS4 ***
begin   
 execute immediate '
  ALTER TABLE BARS.VP_LIST ADD CONSTRAINT FK_VPLIST_ACCOUNTS4 FOREIGN KEY (KF, ACC_RRR)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_VPLIST_ACCOUNTS3 ***
begin   
 execute immediate '
  ALTER TABLE BARS.VP_LIST ADD CONSTRAINT FK_VPLIST_ACCOUNTS3 FOREIGN KEY (KF, ACC_RRD)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_VPLIST_ACCOUNTS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.VP_LIST ADD CONSTRAINT FK_VPLIST_ACCOUNTS2 FOREIGN KEY (KF, ACC6204)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_VPLIST_ACCOUNTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.VP_LIST ADD CONSTRAINT FK_VPLIST_ACCOUNTS FOREIGN KEY (KF, ACC3801)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_VPLIST_ACCOUNTS7 ***
begin   
 execute immediate '
  ALTER TABLE BARS.VP_LIST ADD CONSTRAINT FK_VPLIST_ACCOUNTS7 FOREIGN KEY (KF, ACC3800)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_VPLIST_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.VP_LIST ADD CONSTRAINT FK_VPLIST_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_VPLIST ***
begin   
 execute immediate '
  ALTER TABLE BARS.VP_LIST ADD CONSTRAINT PK_VPLIST PRIMARY KEY (ACC3800)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_VPLIST_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.VP_LIST MODIFY (KF CONSTRAINT CC_VPLIST_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0011981 ***
begin   
 execute immediate '
  ALTER TABLE BARS.VP_LIST MODIFY (ACC6204 NOT NULL DISABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0011980 ***
begin   
 execute immediate '
  ALTER TABLE BARS.VP_LIST MODIFY (ACC3801 NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0011979 ***
begin   
 execute immediate '
  ALTER TABLE BARS.VP_LIST MODIFY (ACC3800 NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_VPLIST ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_VPLIST ON BARS.VP_LIST (ACC3800) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  VP_LIST ***
grant DELETE,INSERT,SELECT,UPDATE                                            on VP_LIST         to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on VP_LIST         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on VP_LIST         to RPBN002;
grant SELECT                                                                 on VP_LIST         to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on VP_LIST         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/VP_LIST.sql =========*** End *** =====
PROMPT ===================================================================================== 
