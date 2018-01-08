

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KAS_VID.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KAS_VID ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KAS_VID'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KAS_VID'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KAS_VID'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KAS_VID ***
begin 
  execute immediate '
  CREATE TABLE BARS.KAS_VID 
   (	VID NUMBER(*,0), 
	NAME VARCHAR2(25)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KAS_VID ***
 exec bpa.alter_policies('KAS_VID');


COMMENT ON TABLE BARS.KAS_VID IS 'Вид касових заявок';
COMMENT ON COLUMN BARS.KAS_VID.VID IS 'Код';
COMMENT ON COLUMN BARS.KAS_VID.NAME IS 'Назва';




PROMPT *** Create  constraint PK_KAS_VID ***
begin   
 execute immediate '
  ALTER TABLE BARS.KAS_VID ADD CONSTRAINT PK_KAS_VID PRIMARY KEY (VID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_KAS_VID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_KAS_VID ON BARS.KAS_VID (VID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KAS_VID ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KAS_VID         to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KAS_VID         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KAS_VID         to BARS_DM;
grant SELECT                                                                 on KAS_VID         to PYOD001;
grant FLASHBACK,SELECT                                                       on KAS_VID         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KAS_VID.sql =========*** End *** =====
PROMPT ===================================================================================== 
