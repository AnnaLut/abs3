

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CP_RYN.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CP_RYN ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_RYN'', ''CENTER'' , null, null, null, ''E'');
               bpa.alter_policy_info(''CP_RYN'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''CP_RYN'', ''WHOLE'' , null, null, null, ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CP_RYN ***
begin 
  execute immediate '
  CREATE TABLE BARS.CP_RYN 
   (	RYN NUMBER, 
	NAME VARCHAR2(35), 
	KV NUMBER, 
	TIPD NUMBER, 
	QUALITY NUMBER, 
	SERIES CHAR(3), 
	D_CLOSE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CP_RYN ***
 exec bpa.alter_policies('CP_RYN');


COMMENT ON TABLE BARS.CP_RYN IS 'Дов_дник субпортфелів';
COMMENT ON COLUMN BARS.CP_RYN.D_CLOSE IS 'Дата закр Суб.Портф';
COMMENT ON COLUMN BARS.CP_RYN.RYN IS 'Код субпортфеля';
COMMENT ON COLUMN BARS.CP_RYN.NAME IS 'Назва субпортфеля';
COMMENT ON COLUMN BARS.CP_RYN.KV IS 'Код валюти (null - мультивалютний)';
COMMENT ON COLUMN BARS.CP_RYN.TIPD IS 'Власні/Чужі ЦП';
COMMENT ON COLUMN BARS.CP_RYN.QUALITY IS 'Ознака якостi портфелю (-1 = "гнилой потфель"), 0 - нормальный';
COMMENT ON COLUMN BARS.CP_RYN.SERIES IS 'Серія';




PROMPT *** Create  constraint PK_CP_RYN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_RYN ADD CONSTRAINT PK_CP_RYN PRIMARY KEY (RYN)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007675 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_RYN MODIFY (RYN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CP_RYN ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CP_RYN ON BARS.CP_RYN (RYN) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CP_RYN ***
grant SELECT                                                                 on CP_RYN          to BARSREADER_ROLE;
grant SELECT                                                                 on CP_RYN          to BARSUPL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CP_RYN          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CP_RYN          to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_RYN          to CP_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_RYN          to START1;
grant SELECT                                                                 on CP_RYN          to UPLD;
grant FLASHBACK,SELECT                                                       on CP_RYN          to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CP_RYN.sql =========*** End *** ======
PROMPT ===================================================================================== 
