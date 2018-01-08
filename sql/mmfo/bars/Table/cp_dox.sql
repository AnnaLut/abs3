

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CP_DOX.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CP_DOX ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_DOX'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CP_DOX'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CP_DOX'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CP_DOX ***
begin 
  execute immediate '
  CREATE TABLE BARS.CP_DOX 
   (	DOX NUMBER, 
	NAME VARCHAR2(70)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CP_DOX ***
 exec bpa.alter_policies('CP_DOX');


COMMENT ON TABLE BARS.CP_DOX IS 'Вид доходност_ ЦП';
COMMENT ON COLUMN BARS.CP_DOX.DOX IS 'Код виду доходност_';
COMMENT ON COLUMN BARS.CP_DOX.NAME IS 'Назва ';




PROMPT *** Create  constraint XPK_CP_DOX ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_DOX ADD CONSTRAINT XPK_CP_DOX PRIMARY KEY (DOX)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005102 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_DOX MODIFY (DOX NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CP_DOX ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CP_DOX ON BARS.CP_DOX (DOX) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CP_DOX ***
grant SELECT                                                                 on CP_DOX          to BARSREADER_ROLE;
grant SELECT                                                                 on CP_DOX          to BARSUPL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CP_DOX          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CP_DOX          to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_DOX          to CP_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_DOX          to START1;
grant SELECT                                                                 on CP_DOX          to UPLD;
grant FLASHBACK,SELECT                                                       on CP_DOX          to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CP_DOX.sql =========*** End *** ======
PROMPT ===================================================================================== 
