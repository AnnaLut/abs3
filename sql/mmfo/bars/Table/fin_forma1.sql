

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FIN_FORMA1.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FIN_FORMA1 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FIN_FORMA1'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''FIN_FORMA1'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''FIN_FORMA1'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FIN_FORMA1 ***
begin 
  execute immediate '
  CREATE TABLE BARS.FIN_FORMA1 
   (	NAME VARCHAR2(70), 
	ORD NUMBER(*,0), 
	KOD VARCHAR2(4), 
	POB NUMBER(*,0), 
	FM CHAR(1) DEFAULT '' '', 
	KOD_OLD VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FIN_FORMA1 ***
 exec bpa.alter_policies('FIN_FORMA1');


COMMENT ON TABLE BARS.FIN_FORMA1 IS 'Шаблон фiн.звiту "Баланс" (Форма № 1)';
COMMENT ON COLUMN BARS.FIN_FORMA1.NAME IS 'Стаття';
COMMENT ON COLUMN BARS.FIN_FORMA1.ORD IS '№ п/п';
COMMENT ON COLUMN BARS.FIN_FORMA1.KOD IS 'Код';
COMMENT ON COLUMN BARS.FIN_FORMA1.POB IS 'Приз.обяз.';
COMMENT ON COLUMN BARS.FIN_FORMA1.FM IS '';
COMMENT ON COLUMN BARS.FIN_FORMA1.KOD_OLD IS '';




PROMPT *** Create  constraint XPK_FIN_FORMA1 ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_FORMA1 ADD CONSTRAINT XPK_FIN_FORMA1 PRIMARY KEY (ORD, FM)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_FIN_FORMA1 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_FIN_FORMA1 ON BARS.FIN_FORMA1 (ORD, FM) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FIN_FORMA1 ***
grant SELECT                                                                 on FIN_FORMA1      to BARSUPL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on FIN_FORMA1      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FIN_FORMA1      to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on FIN_FORMA1      to RCC_DEAL;
grant DELETE,INSERT,SELECT,UPDATE                                            on FIN_FORMA1      to R_FIN2;
grant SELECT                                                                 on FIN_FORMA1      to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on FIN_FORMA1      to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on FIN_FORMA1      to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FIN_FORMA1.sql =========*** End *** ==
PROMPT ===================================================================================== 
