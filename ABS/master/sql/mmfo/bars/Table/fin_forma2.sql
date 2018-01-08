

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FIN_FORMA2.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FIN_FORMA2 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FIN_FORMA2'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''FIN_FORMA2'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''FIN_FORMA2'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FIN_FORMA2 ***
begin 
  execute immediate '
  CREATE TABLE BARS.FIN_FORMA2 
   (	NAME VARCHAR2(70), 
	ORD NUMBER(*,0), 
	KOD VARCHAR2(4), 
	POB NUMBER(*,0), 
	FM CHAR(1) DEFAULT '' '', 
	KOD_OLD VARCHAR2(2000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FIN_FORMA2 ***
 exec bpa.alter_policies('FIN_FORMA2');


COMMENT ON TABLE BARS.FIN_FORMA2 IS 'Шаблон фiн.звiту "Фiнансовi результати" (Форма № 2)';
COMMENT ON COLUMN BARS.FIN_FORMA2.NAME IS 'Стаття';
COMMENT ON COLUMN BARS.FIN_FORMA2.ORD IS '№ п/п';
COMMENT ON COLUMN BARS.FIN_FORMA2.KOD IS 'Код';
COMMENT ON COLUMN BARS.FIN_FORMA2.POB IS '';
COMMENT ON COLUMN BARS.FIN_FORMA2.FM IS '';
COMMENT ON COLUMN BARS.FIN_FORMA2.KOD_OLD IS '';




PROMPT *** Create  constraint XPK_FIN_FORMA2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_FORMA2 ADD CONSTRAINT XPK_FIN_FORMA2 PRIMARY KEY (ORD, FM)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_FIN_FORMA2 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_FIN_FORMA2 ON BARS.FIN_FORMA2 (ORD, FM) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FIN_FORMA2 ***
grant SELECT                                                                 on FIN_FORMA2      to BARSUPL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on FIN_FORMA2      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FIN_FORMA2      to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on FIN_FORMA2      to RCC_DEAL;
grant DELETE,INSERT,SELECT,UPDATE                                            on FIN_FORMA2      to R_FIN2;
grant SELECT                                                                 on FIN_FORMA2      to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on FIN_FORMA2      to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on FIN_FORMA2      to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FIN_FORMA2.sql =========*** End *** ==
PROMPT ===================================================================================== 
