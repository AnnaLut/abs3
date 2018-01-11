

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FIN_FORMA1M.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FIN_FORMA1M ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FIN_FORMA1M'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''FIN_FORMA1M'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''FIN_FORMA1M'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FIN_FORMA1M ***
begin 
  execute immediate '
  CREATE TABLE BARS.FIN_FORMA1M 
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




PROMPT *** ALTER_POLICIES to FIN_FORMA1M ***
 exec bpa.alter_policies('FIN_FORMA1M');


COMMENT ON TABLE BARS.FIN_FORMA1M IS 'Шаблон фiн.звiту "Баланс" (Форма № 1м)';
COMMENT ON COLUMN BARS.FIN_FORMA1M.NAME IS 'Стаття';
COMMENT ON COLUMN BARS.FIN_FORMA1M.ORD IS '№ п/п';
COMMENT ON COLUMN BARS.FIN_FORMA1M.KOD IS 'Код';
COMMENT ON COLUMN BARS.FIN_FORMA1M.POB IS 'Приз.обяз.';
COMMENT ON COLUMN BARS.FIN_FORMA1M.FM IS '';
COMMENT ON COLUMN BARS.FIN_FORMA1M.KOD_OLD IS '';




PROMPT *** Create  constraint XPK_FIN_FORMA1M ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_FORMA1M ADD CONSTRAINT XPK_FIN_FORMA1M PRIMARY KEY (ORD, FM)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_FIN_FORMA1M ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_FIN_FORMA1M ON BARS.FIN_FORMA1M (ORD, FM) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FIN_FORMA1M ***
grant SELECT                                                                 on FIN_FORMA1M     to BARSREADER_ROLE;
grant SELECT                                                                 on FIN_FORMA1M     to BARSUPL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on FIN_FORMA1M     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FIN_FORMA1M     to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on FIN_FORMA1M     to RCC_DEAL;
grant DELETE,INSERT,SELECT,UPDATE                                            on FIN_FORMA1M     to R_FIN2;
grant SELECT                                                                 on FIN_FORMA1M     to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on FIN_FORMA1M     to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on FIN_FORMA1M     to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FIN_FORMA1M.sql =========*** End *** =
PROMPT ===================================================================================== 
