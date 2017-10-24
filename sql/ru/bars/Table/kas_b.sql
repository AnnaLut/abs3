

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KAS_B.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KAS_B ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KAS_B'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''KAS_B'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KAS_B ***
begin 
  execute immediate '
  CREATE TABLE BARS.KAS_B 
   (	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	BRANCH VARCHAR2(30), 
	IDM NUMBER(*,0), 
	NSM NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KAS_B ***
 exec bpa.alter_policies('KAS_B');


COMMENT ON TABLE BARS.KAS_B IS '�����I �� �� ��������';
COMMENT ON COLUMN BARS.KAS_B.KF IS '��� ���';
COMMENT ON COLUMN BARS.KAS_B.BRANCH IS '���~������';
COMMENT ON COLUMN BARS.KAS_B.IDM IS '���~��������';
COMMENT ON COLUMN BARS.KAS_B.NSM IS '� ��i��';




PROMPT *** Create  constraint FK_KASB_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.KAS_B ADD CONSTRAINT FK_KASB_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_KASB_IDM ***
begin   
 execute immediate '
  ALTER TABLE BARS.KAS_B ADD CONSTRAINT FK_KASB_IDM FOREIGN KEY (IDM)
	  REFERENCES BARS.KAS_M (IDM) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_KASB ***
begin   
 execute immediate '
  ALTER TABLE BARS.KAS_B ADD CONSTRAINT PK_KASB PRIMARY KEY (BRANCH)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KASB_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KAS_B MODIFY (KF CONSTRAINT CC_KASB_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_KASB ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_KASB ON BARS.KAS_B (BRANCH) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KAS_B ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KAS_B           to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KAS_B           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KAS_B           to PYOD001;
grant FLASHBACK,SELECT                                                       on KAS_B           to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KAS_B.sql =========*** End *** =======
PROMPT ===================================================================================== 
