

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KAS_Z.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KAS_Z ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KAS_Z'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''KAS_Z'', ''FILIAL'' , ''B'', ''B'', ''B'', ''B'');
               bpa.alter_policy_info(''KAS_Z'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KAS_Z ***
begin 
  execute immediate '
  CREATE TABLE BARS.KAS_Z 
   (	IDZ NUMBER(*,0), 
	DAT1 DATE DEFAULT sysdate, 
	SOS NUMBER(*,0), 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	VID NUMBER, 
	KODV VARCHAR2(10), 
	KV NUMBER(*,0), 
	DAT2 DATE, 
	IDU NUMBER(*,0), 
	KOL NUMBER(*,0), 
	S NUMBER(24,2), 
	REFA NUMBER(*,0), 
	REFB NUMBER(*,0), 
	IDS NUMBER(*,0), 
	IDI NUMBER(*,0), 
	NLSB VARCHAR2(15), 
	S0 NUMBER, 
	K0 NUMBER, 
	IDM NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KAS_Z ***
 exec bpa.alter_policies('KAS_Z');


COMMENT ON TABLE BARS.KAS_Z IS 'Заявки на пiдкрiплення каси';
COMMENT ON COLUMN BARS.KAS_Z.IDZ IS 'Сист.№~заявки';
COMMENT ON COLUMN BARS.KAS_Z.DAT1 IS 'Дата+час~вводу';
COMMENT ON COLUMN BARS.KAS_Z.SOS IS 'Стан~заявки';
COMMENT ON COLUMN BARS.KAS_Z.BRANCH IS 'BRANCH~заявки';
COMMENT ON COLUMN BARS.KAS_Z.VID IS 'Вид~заявки';
COMMENT ON COLUMN BARS.KAS_Z.KODV IS 'Сист.код~цiнностi';
COMMENT ON COLUMN BARS.KAS_Z.KV IS 'Вал.~заявки';
COMMENT ON COLUMN BARS.KAS_Z.DAT2 IS 'План-Дата~поставки';
COMMENT ON COLUMN BARS.KAS_Z.IDU IS 'Користувач, що ввiв~заявку';
COMMENT ON COLUMN BARS.KAS_Z.KOL IS 'Кiльк.~одиниць';
COMMENT ON COLUMN BARS.KAS_Z.S IS 'Сума';
COMMENT ON COLUMN BARS.KAS_Z.REFA IS 'Реф.A~вiдправки зi сховища';
COMMENT ON COLUMN BARS.KAS_Z.REFB IS 'Реф.Б~надходження в касу';
COMMENT ON COLUMN BARS.KAS_Z.IDS IS 'Сист.№ сумки';
COMMENT ON COLUMN BARS.KAS_Z.IDI IS 'Сист.№ iнкасатора';
COMMENT ON COLUMN BARS.KAS_Z.NLSB IS '';
COMMENT ON COLUMN BARS.KAS_Z.S0 IS 'Сумма з первинної заявки';
COMMENT ON COLUMN BARS.KAS_Z.K0 IS 'Кiльк.з первинної заявки';
COMMENT ON COLUMN BARS.KAS_Z.IDM IS 'Сист.№ маршруту';




PROMPT *** Create  constraint CC_KASZ_SOS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KAS_Z MODIFY (SOS CONSTRAINT CC_KASZ_SOS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KASZ_BRN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KAS_Z MODIFY (BRANCH CONSTRAINT CC_KASZ_BRN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KASZ_VID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KAS_Z MODIFY (VID CONSTRAINT CC_KASZ_VID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KASZ_DT2_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KAS_Z MODIFY (DAT2 CONSTRAINT CC_KASZ_DT2_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_KASZ ***
begin   
 execute immediate '
  ALTER TABLE BARS.KAS_Z ADD CONSTRAINT PK_KASZ PRIMARY KEY (IDZ)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_KASZ ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_KASZ ON BARS.KAS_Z (IDZ) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KAS_Z ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KAS_Z           to ABS_ADMIN;
grant SELECT                                                                 on KAS_Z           to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KAS_Z           to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KAS_Z           to PYOD001;
grant SELECT                                                                 on KAS_Z           to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KAS_Z.sql =========*** End *** =======
PROMPT ===================================================================================== 
