

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CC_PAWN_S080.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CC_PAWN_S080 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CC_PAWN_S080'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CC_PAWN_S080'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CC_PAWN_S080 ***
begin 
  execute immediate '
  CREATE TABLE BARS.CC_PAWN_S080 
   (	PAWN NUMBER(38,0), 
	S080 VARCHAR2(1), 
	PR NUMBER(10,2), 
	KOD_F30 VARCHAR2(3), 
	PR2 NUMBER, 
	PR3 NUMBER, 
	PROLD NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CC_PAWN_S080 ***
 exec bpa.alter_policies('CC_PAWN_S080');


COMMENT ON TABLE BARS.CC_PAWN_S080 IS '������� �����������  �������� � ������ � ����������� �� ���� ����������� � ��������� �����';
COMMENT ON COLUMN BARS.CC_PAWN_S080.PAWN IS '��� �����������';
COMMENT ON COLUMN BARS.CC_PAWN_S080.S080 IS '��������� �����';
COMMENT ON COLUMN BARS.CC_PAWN_S080.PR IS '������� ����������� 1 ��������� � ������';
COMMENT ON COLUMN BARS.CC_PAWN_S080.KOD_F30 IS '��� ����������� ��� 30 �����';
COMMENT ON COLUMN BARS.CC_PAWN_S080.PR2 IS '������� ����������� 2 ��������� � ������';
COMMENT ON COLUMN BARS.CC_PAWN_S080.PR3 IS '������� ����������� 3 ��������� � ������';
COMMENT ON COLUMN BARS.CC_PAWN_S080.PROLD IS '�� ������������';




PROMPT *** Create  constraint FK_CC_PS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_PAWN_S080 ADD CONSTRAINT FK_CC_PS2 FOREIGN KEY (S080)
	  REFERENCES BARS.CRISK (CRISK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CC_PS1 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_PAWN_S080 ADD CONSTRAINT FK_CC_PS1 FOREIGN KEY (PAWN)
	  REFERENCES BARS.CC_PAWN (PAWN) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PAWN_S080 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_PAWN_S080 ADD CONSTRAINT PAWN_S080 PRIMARY KEY (PAWN, S080)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_CC_PAWN_S080_S080 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_PAWN_S080 MODIFY (S080 CONSTRAINT NK_CC_PAWN_S080_S080 NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_CC_PAWN_S080_PAWN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_PAWN_S080 MODIFY (PAWN CONSTRAINT NK_CC_PAWN_S080_PAWN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PAWN_S080 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PAWN_S080 ON BARS.CC_PAWN_S080 (PAWN, S080) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CC_PAWN_S080 ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CC_PAWN_S080    to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CC_PAWN_S080    to RCC_DEAL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CC_PAWN_S080    to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on CC_PAWN_S080    to WR_REFREAD;



PROMPT *** Create SYNONYM  to CC_PAWN_S080 ***

  CREATE OR REPLACE PUBLIC SYNONYM CC_PAWN_S080 FOR BARS.CC_PAWN_S080;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CC_PAWN_S080.sql =========*** End *** 
PROMPT ===================================================================================== 
