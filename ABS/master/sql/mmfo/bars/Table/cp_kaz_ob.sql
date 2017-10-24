

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CP_KAZ_OB.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CP_KAZ_OB ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_KAZ_OB'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CP_KAZ_OB'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CP_KAZ_OB'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CP_KAZ_OB ***
begin 
  execute immediate '
  CREATE TABLE BARS.CP_KAZ_OB 
   (	ID NUMBER, 
	NLS_98R VARCHAR2(2), 
	NLS_29R VARCHAR2(2), 
	NLS_98V VARCHAR2(2), 
	NLS_28V VARCHAR2(2), 
	NLS_98K VARCHAR2(2), 
	NLS_28K VARCHAR2(2), 
	NLS_98N VARCHAR2(2), 
	NLS_28N VARCHAR2(2), 
	NLS_29R_GOU VARCHAR2(14), 
	NLS_28V_GOU VARCHAR2(14), 
	NLS_28K_GOU VARCHAR2(14), 
	NLS_28N_GOU VARCHAR2(14), 
	SER VARCHAR2(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CP_KAZ_OB ***
 exec bpa.alter_policies('CP_KAZ_OB');


COMMENT ON TABLE BARS.CP_KAZ_OB IS 'Аналітика для казначейських зобовязань';
COMMENT ON COLUMN BARS.CP_KAZ_OB.ID IS 'ID Цінного паперу';
COMMENT ON COLUMN BARS.CP_KAZ_OB.NLS_98R IS 'ОБ22 розмещение 9820';
COMMENT ON COLUMN BARS.CP_KAZ_OB.NLS_29R IS 'ОБ22 розмещение 2901';
COMMENT ON COLUMN BARS.CP_KAZ_OB.NLS_98V IS 'ОБ22 викуп 9819';
COMMENT ON COLUMN BARS.CP_KAZ_OB.NLS_28V IS 'ОБ22 викуп 2801';
COMMENT ON COLUMN BARS.CP_KAZ_OB.NLS_98K IS 'ОБ22 погаше куп 9812';
COMMENT ON COLUMN BARS.CP_KAZ_OB.NLS_28K IS 'ОБ22 погаше куп 2801';
COMMENT ON COLUMN BARS.CP_KAZ_OB.NLS_98N IS 'ОБ22 погаш ном + посл.куп 9812';
COMMENT ON COLUMN BARS.CP_KAZ_OB.NLS_28N IS 'ОБ22 погаш ном + посл.куп 2801';
COMMENT ON COLUMN BARS.CP_KAZ_OB.NLS_29R_GOU IS 'розмещение 2901 ГОУ';
COMMENT ON COLUMN BARS.CP_KAZ_OB.NLS_28V_GOU IS 'викуп 2801 ГОУ';
COMMENT ON COLUMN BARS.CP_KAZ_OB.NLS_28K_GOU IS 'погаше куп 2801 ГОУ';
COMMENT ON COLUMN BARS.CP_KAZ_OB.NLS_28N_GOU IS 'погаш ном + посл.куп 2801 ГОУ';
COMMENT ON COLUMN BARS.CP_KAZ_OB.SER IS 'Код серії КЗ';




PROMPT *** Create  constraint XPK_CP_KAZOB ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_KAZ_OB ADD CONSTRAINT XPK_CP_KAZOB PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CP_KAZOB ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CP_KAZOB ON BARS.CP_KAZ_OB (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CP_KAZ_OB ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CP_KAZ_OB       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CP_KAZ_OB       to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CP_KAZ_OB       to START1;
grant FLASHBACK,SELECT                                                       on CP_KAZ_OB       to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CP_KAZ_OB.sql =========*** End *** ===
PROMPT ===================================================================================== 
