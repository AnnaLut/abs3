

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TIP_AKTIV.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TIP_AKTIV ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TIP_AKTIV'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TIP_AKTIV'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TIP_AKTIV'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TIP_AKTIV ***
begin 
  execute immediate '
  CREATE TABLE BARS.TIP_AKTIV 
   (	TIP NUMBER(*,0), 
	VID VARCHAR2(3), 
	NAME VARCHAR2(50)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TIP_AKTIV ***
 exec bpa.alter_policies('TIP_AKTIV');


COMMENT ON TABLE BARS.TIP_AKTIV IS 'Довідник видів активу для забезпечення';
COMMENT ON COLUMN BARS.TIP_AKTIV.TIP IS 'Тип';
COMMENT ON COLUMN BARS.TIP_AKTIV.VID IS 'Вид';
COMMENT ON COLUMN BARS.TIP_AKTIV.NAME IS 'Назва';




PROMPT *** Create  constraint PK_TIPAKTIV ***
begin   
 execute immediate '
  ALTER TABLE BARS.TIP_AKTIV ADD CONSTRAINT PK_TIPAKTIV PRIMARY KEY (TIP)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TIPAKTIV ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TIPAKTIV ON BARS.TIP_AKTIV (TIP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TIP_AKTIV ***
grant SELECT                                                                 on TIP_AKTIV       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TIP_AKTIV       to BARS_DM;
grant SELECT                                                                 on TIP_AKTIV       to RCC_DEAL;
grant SELECT                                                                 on TIP_AKTIV       to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TIP_AKTIV.sql =========*** End *** ===
PROMPT ===================================================================================== 
