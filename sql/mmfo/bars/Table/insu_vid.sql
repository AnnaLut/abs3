

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/INSU_VID.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to INSU_VID ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''INSU_VID'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''INSU_VID'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''INSU_VID'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table INSU_VID ***
begin 
  execute immediate '
  CREATE TABLE BARS.INSU_VID 
   (	INSU NUMBER(*,0), 
	NAME VARCHAR2(35), 
	ZAL NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to INSU_VID ***
 exec bpa.alter_policies('INSU_VID');


COMMENT ON TABLE BARS.INSU_VID IS 'Види договорiв страхування';
COMMENT ON COLUMN BARS.INSU_VID.INSU IS 'Код~виду';
COMMENT ON COLUMN BARS.INSU_VID.NAME IS 'Назва виду';
COMMENT ON COLUMN BARS.INSU_VID.ZAL IS '=1 Для Дог.залога';




PROMPT *** Create  constraint XPK_INSU_VID ***
begin   
 execute immediate '
  ALTER TABLE BARS.INSU_VID ADD CONSTRAINT XPK_INSU_VID PRIMARY KEY (INSU)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_INSU_VID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_INSU_VID ON BARS.INSU_VID (INSU) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  INSU_VID ***
grant SELECT                                                                 on INSU_VID        to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on INSU_VID        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on INSU_VID        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on INSU_VID        to RCC_DEAL;
grant SELECT                                                                 on INSU_VID        to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on INSU_VID        to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on INSU_VID        to WR_REFREAD;



PROMPT *** Create SYNONYM  to INSU_VID ***

  CREATE OR REPLACE PUBLIC SYNONYM INSU_VID FOR BARS.INSU_VID;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/INSU_VID.sql =========*** End *** ====
PROMPT ===================================================================================== 
