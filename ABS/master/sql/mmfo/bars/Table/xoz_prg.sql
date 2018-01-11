

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/XOZ_PRG.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to XOZ_PRG ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''XOZ_PRG'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''XOZ_PRG'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''XOZ_PRG'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table XOZ_PRG ***
begin 
  execute immediate '
  CREATE TABLE BARS.XOZ_PRG 
   (	PRG NUMBER(*,0), 
	NAME VARCHAR2(100), 
	DETALI VARCHAR2(250)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to XOZ_PRG ***
 exec bpa.alter_policies('XOZ_PRG');


COMMENT ON TABLE BARS.XOZ_PRG IS 'Довідник проектів';
COMMENT ON COLUMN BARS.XOZ_PRG.PRG IS 'Код проекту';
COMMENT ON COLUMN BARS.XOZ_PRG.NAME IS 'Назва проекту';
COMMENT ON COLUMN BARS.XOZ_PRG.DETALI IS 'Короткий зміст проекту';




PROMPT *** Create  constraint PK_XOZPRG ***
begin   
 execute immediate '
  ALTER TABLE BARS.XOZ_PRG ADD CONSTRAINT PK_XOZPRG PRIMARY KEY (PRG)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_XOZPRG ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_XOZPRG ON BARS.XOZ_PRG (PRG) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  XOZ_PRG ***
grant SELECT                                                                 on XOZ_PRG         to BARSREADER_ROLE;
grant SELECT                                                                 on XOZ_PRG         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on XOZ_PRG         to BARS_DM;
grant SELECT                                                                 on XOZ_PRG         to START1;
grant SELECT                                                                 on XOZ_PRG         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/XOZ_PRG.sql =========*** End *** =====
PROMPT ===================================================================================== 
