

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KP_LOG.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KP_LOG ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KP_LOG'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KP_LOG'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KP_LOG'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KP_LOG ***
begin 
  execute immediate '
  CREATE TABLE BARS.KP_LOG 
   (	LOG NUMBER(*,0), 
	NAME VARCHAR2(40)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KP_LOG ***
 exec bpa.alter_policies('KP_LOG');


COMMENT ON TABLE BARS.KP_LOG IS 'КП. Логические группы';
COMMENT ON COLUMN BARS.KP_LOG.LOG IS 'Код группы';
COMMENT ON COLUMN BARS.KP_LOG.NAME IS 'Наименование группы';




PROMPT *** Create  constraint XPK_KP_LOG ***
begin   
 execute immediate '
  ALTER TABLE BARS.KP_LOG ADD CONSTRAINT XPK_KP_LOG PRIMARY KEY (LOG)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_KP_LOG ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_KP_LOG ON BARS.KP_LOG (LOG) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KP_LOG ***
grant SELECT                                                                 on KP_LOG          to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KP_LOG          to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KP_LOG          to R_KP;
grant SELECT                                                                 on KP_LOG          to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KP_LOG          to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KP_LOG.sql =========*** End *** ======
PROMPT ===================================================================================== 
