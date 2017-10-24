

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/STAFFTIP_KLF00.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to STAFFTIP_KLF00 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''STAFFTIP_KLF00'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''STAFFTIP_KLF00'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table STAFFTIP_KLF00 ***
begin 
  execute immediate '
  CREATE TABLE BARS.STAFFTIP_KLF00 
   (	ID NUMBER(22,0), 
	KODF CHAR(2), 
	A017 CHAR(1), 
	REVERSE NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to STAFFTIP_KLF00 ***
 exec bpa.alter_policies('STAFFTIP_KLF00');


COMMENT ON TABLE BARS.STAFFTIP_KLF00 IS '�����_ ����������_ <-> ��_�� ���';
COMMENT ON COLUMN BARS.STAFFTIP_KLF00.ID IS '��� �������� �����������';
COMMENT ON COLUMN BARS.STAFFTIP_KLF00.KODF IS '��� �����';
COMMENT ON COLUMN BARS.STAFFTIP_KLF00.A017 IS '������ �����';
COMMENT ON COLUMN BARS.STAFFTIP_KLF00.REVERSE IS '';




PROMPT *** Create  constraint FK_STAFFTIPKLF00_KLF00 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFFTIP_KLF00 ADD CONSTRAINT FK_STAFFTIPKLF00_KLF00 FOREIGN KEY (KODF, A017)
	  REFERENCES BARS.KL_F00$GLOBAL (KODF, A017) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_STAFFTIPKLF00_STAFFTIPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFFTIP_KLF00 ADD CONSTRAINT FK_STAFFTIPKLF00_STAFFTIPS FOREIGN KEY (ID)
	  REFERENCES BARS.STAFF_TIPS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_STAFFTIPKLF00 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFFTIP_KLF00 ADD CONSTRAINT PK_STAFFTIPKLF00 PRIMARY KEY (ID, KODF, A017)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STAFFTIPKLF00_A017_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFFTIP_KLF00 MODIFY (A017 CONSTRAINT CC_STAFFTIPKLF00_A017_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STAFFTIPKLF00_KODF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFFTIP_KLF00 MODIFY (KODF CONSTRAINT CC_STAFFTIPKLF00_KODF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STAFFTIPKLF00_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFFTIP_KLF00 MODIFY (ID CONSTRAINT CC_STAFFTIPKLF00_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_STAFFTIPKLF00 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_STAFFTIPKLF00 ON BARS.STAFFTIP_KLF00 (ID, KODF, A017) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  STAFFTIP_KLF00 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on STAFFTIP_KLF00  to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on STAFFTIP_KLF00  to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/STAFFTIP_KLF00.sql =========*** End **
PROMPT ===================================================================================== 
