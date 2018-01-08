

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FIN_TXT.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FIN_TXT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FIN_TXT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''FIN_TXT'', ''FILIAL'' , null, null, ''F'', ''F'');
               bpa.alter_policy_info(''FIN_TXT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FIN_TXT ***
begin 
  execute immediate '
  CREATE TABLE BARS.FIN_TXT 
   (	FDAT DATE, 
	TXT VARCHAR2(2000), 
	OKPO NUMBER, 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	USERID NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FIN_TXT ***
 exec bpa.alter_policies('FIN_TXT');


COMMENT ON TABLE BARS.FIN_TXT IS 'Висновки';
COMMENT ON COLUMN BARS.FIN_TXT.FDAT IS 'дата';
COMMENT ON COLUMN BARS.FIN_TXT.TXT IS 'текст';
COMMENT ON COLUMN BARS.FIN_TXT.OKPO IS 'ОКПО(числовое) или РНК';
COMMENT ON COLUMN BARS.FIN_TXT.BRANCH IS '';
COMMENT ON COLUMN BARS.FIN_TXT.USERID IS '';




PROMPT *** Create  constraint XPK_FIN_TXT ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_TXT ADD CONSTRAINT XPK_FIN_TXT PRIMARY KEY (OKPO, FDAT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_FIN_TXT_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_TXT ADD CONSTRAINT FK_FIN_TXT_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FIN_TXT_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_TXT MODIFY (BRANCH CONSTRAINT CC_FIN_TXT_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_FIN_TXT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_FIN_TXT ON BARS.FIN_TXT (OKPO, FDAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FIN_TXT ***
grant SELECT                                                                 on FIN_TXT         to BARS009;
grant INSERT,SELECT,UPDATE                                                   on FIN_TXT         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FIN_TXT         to BARS_DM;
grant INSERT,SELECT,UPDATE                                                   on FIN_TXT         to R_FIN2;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on FIN_TXT         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FIN_TXT.sql =========*** End *** =====
PROMPT ===================================================================================== 
