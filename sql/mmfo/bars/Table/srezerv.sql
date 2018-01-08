

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SREZERV.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SREZERV ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SREZERV'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SREZERV'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SREZERV'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SREZERV ***
begin 
  execute immediate '
  CREATE TABLE BARS.SREZERV 
   (	CUSTTYPE NUMBER(2,0), 
	S080 VARCHAR2(1), 
	S_FORM VARCHAR2(15), 
	S_RASF VARCHAR2(15), 
	S_ISP VARCHAR2(15), 
	S_FOND VARCHAR2(15), 
	S_FORMV VARCHAR2(15), 
	S_RASFV VARCHAR2(15), 
	S_ISPV VARCHAR2(15), 
	ID NUMBER(*,0), 
	S_FONDNR VARCHAR2(15), 
	OTVISP NUMBER(5,0), 
	OTVISPVAL NUMBER(5,0), 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	SPECREZ NUMBER DEFAULT 0
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SREZERV ***
 exec bpa.alter_policies('SREZERV');


COMMENT ON TABLE BARS.SREZERV IS '';
COMMENT ON COLUMN BARS.SREZERV.CUSTTYPE IS '';
COMMENT ON COLUMN BARS.SREZERV.S080 IS '';
COMMENT ON COLUMN BARS.SREZERV.S_FORM IS '';
COMMENT ON COLUMN BARS.SREZERV.S_RASF IS '';
COMMENT ON COLUMN BARS.SREZERV.S_ISP IS '';
COMMENT ON COLUMN BARS.SREZERV.S_FOND IS '';
COMMENT ON COLUMN BARS.SREZERV.S_FORMV IS '';
COMMENT ON COLUMN BARS.SREZERV.S_RASFV IS '';
COMMENT ON COLUMN BARS.SREZERV.S_ISPV IS '';
COMMENT ON COLUMN BARS.SREZERV.ID IS '';
COMMENT ON COLUMN BARS.SREZERV.S_FONDNR IS 'Счет фонда для нерезидентов';
COMMENT ON COLUMN BARS.SREZERV.OTVISP IS '';
COMMENT ON COLUMN BARS.SREZERV.OTVISPVAL IS '';
COMMENT ON COLUMN BARS.SREZERV.BRANCH IS '';
COMMENT ON COLUMN BARS.SREZERV.SPECREZ IS '';




PROMPT *** Create  constraint XPK_SREZERV ***
begin   
 execute immediate '
  ALTER TABLE BARS.SREZERV ADD CONSTRAINT XPK_SREZERV PRIMARY KEY (CUSTTYPE, S080, ID, SPECREZ)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SREZ_S080 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SREZERV ADD CONSTRAINT FK_SREZ_S080 FOREIGN KEY (S080)
	  REFERENCES BARS.CRISK (CRISK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SREZERV_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.SREZERV ADD CONSTRAINT FK_SREZERV_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SREZERV_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.SREZERV ADD CONSTRAINT FK_SREZERV_ID FOREIGN KEY (ID)
	  REFERENCES BARS.SREZ_ID (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SREZ_CUSTTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.SREZERV ADD CONSTRAINT FK_SREZ_CUSTTYPE FOREIGN KEY (CUSTTYPE)
	  REFERENCES BARS.CUSTTYPE (CUSTTYPE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_SREZERV_CUSTTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.SREZERV MODIFY (CUSTTYPE CONSTRAINT NK_SREZERV_CUSTTYPE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SREZERV_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SREZERV MODIFY (BRANCH CONSTRAINT CC_SREZERV_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_SREZERV_S080 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SREZERV MODIFY (S080 CONSTRAINT NK_SREZERV_S080 NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_SREZERV ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_SREZERV ON BARS.SREZERV (CUSTTYPE, S080, ID, SPECREZ) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SREZERV ***
grant ALTER,DEBUG,DELETE,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on SREZERV         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SREZERV         to BARS_DM;
grant ALTER,DEBUG,DELETE,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on SREZERV         to RCC_DEAL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SREZERV         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SREZERV.sql =========*** End *** =====
PROMPT ===================================================================================== 
