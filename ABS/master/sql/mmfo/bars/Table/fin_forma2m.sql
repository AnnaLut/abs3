

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FIN_FORMA2M.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FIN_FORMA2M ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FIN_FORMA2M'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''FIN_FORMA2M'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''FIN_FORMA2M'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FIN_FORMA2M ***
begin 
  execute immediate '
  CREATE TABLE BARS.FIN_FORMA2M 
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




PROMPT *** ALTER_POLICIES to FIN_FORMA2M ***
 exec bpa.alter_policies('FIN_FORMA2M');


COMMENT ON TABLE BARS.FIN_FORMA2M IS 'Шаблон фiн.звiту "Фiнансовi результати" (Форма № 2м)';
COMMENT ON COLUMN BARS.FIN_FORMA2M.NAME IS 'Стаття';
COMMENT ON COLUMN BARS.FIN_FORMA2M.ORD IS '№ п/п';
COMMENT ON COLUMN BARS.FIN_FORMA2M.KOD IS 'Код';
COMMENT ON COLUMN BARS.FIN_FORMA2M.POB IS '';
COMMENT ON COLUMN BARS.FIN_FORMA2M.FM IS '';
COMMENT ON COLUMN BARS.FIN_FORMA2M.KOD_OLD IS '';




PROMPT *** Create  constraint XPK_FIN_FORMA2M ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_FORMA2M ADD CONSTRAINT XPK_FIN_FORMA2M PRIMARY KEY (ORD, FM)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_FIN_FORMA2M ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_FIN_FORMA2M ON BARS.FIN_FORMA2M (ORD, FM) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FIN_FORMA2M ***
grant SELECT                                                                 on FIN_FORMA2M     to BARSUPL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on FIN_FORMA2M     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FIN_FORMA2M     to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on FIN_FORMA2M     to RCC_DEAL;
grant DELETE,INSERT,SELECT,UPDATE                                            on FIN_FORMA2M     to R_FIN2;
grant SELECT                                                                 on FIN_FORMA2M     to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on FIN_FORMA2M     to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on FIN_FORMA2M     to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FIN_FORMA2M.sql =========*** End *** =
PROMPT ===================================================================================== 
