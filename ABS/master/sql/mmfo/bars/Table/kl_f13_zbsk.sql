

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_F13_ZBSK.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_F13_ZBSK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_F13_ZBSK'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_F13_ZBSK'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_F13_ZBSK'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_F13_ZBSK ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_F13_ZBSK 
   (	NBSD VARCHAR2(15), 
	NBSK VARCHAR2(15), 
	SK_ZB NUMBER DEFAULT 0, 
	COMM VARCHAR2(60), 
	TT VARCHAR2(3), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KL_F13_ZBSK ***
 exec bpa.alter_policies('KL_F13_ZBSK');


COMMENT ON TABLE BARS.KL_F13_ZBSK IS '';
COMMENT ON COLUMN BARS.KL_F13_ZBSK.NBSD IS 'Особовий (бал.) рах. Дт';
COMMENT ON COLUMN BARS.KL_F13_ZBSK.NBSK IS 'Особовий (бал.) рах. Кт';
COMMENT ON COLUMN BARS.KL_F13_ZBSK.SK_ZB IS 'Позабалансовий символ';
COMMENT ON COLUMN BARS.KL_F13_ZBSK.COMM IS 'Коментар';
COMMENT ON COLUMN BARS.KL_F13_ZBSK.TT IS 'Код операцii';
COMMENT ON COLUMN BARS.KL_F13_ZBSK.KF IS '';




PROMPT *** Create  constraint FK_KLF13ZBSK_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.KL_F13_ZBSK ADD CONSTRAINT FK_KLF13ZBSK_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KLF13ZBSK_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KL_F13_ZBSK MODIFY (KF CONSTRAINT CC_KLF13ZBSK_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KL_F13_ZBSK ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_F13_ZBSK     to ABS_ADMIN;
grant ALTER,DELETE,FLASHBACK,INSERT,SELECT,UPDATE                            on KL_F13_ZBSK     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KL_F13_ZBSK     to BARS_DM;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on KL_F13_ZBSK     to RPBN001;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on KL_F13_ZBSK     to SALGL;
grant SELECT                                                                 on KL_F13_ZBSK     to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KL_F13_ZBSK     to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on KL_F13_ZBSK     to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_F13_ZBSK.sql =========*** End *** =
PROMPT ===================================================================================== 
