

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CCK_RESTR_VID.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CCK_RESTR_VID ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CCK_RESTR_VID'', ''CENTER'' , ''C'', ''C'', ''C'', null);
               bpa.alter_policy_info(''CCK_RESTR_VID'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CCK_RESTR_VID'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CCK_RESTR_VID ***
begin 
  execute immediate '
  CREATE TABLE BARS.CCK_RESTR_VID 
   (	VID_RESTR NUMBER, 
	NAME_RESTR VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CCK_RESTR_VID ***
 exec bpa.alter_policies('CCK_RESTR_VID');


COMMENT ON TABLE BARS.CCK_RESTR_VID IS 'Справочник видов реструктуризации КД';
COMMENT ON COLUMN BARS.CCK_RESTR_VID.VID_RESTR IS 'Код вида реструктуризации';
COMMENT ON COLUMN BARS.CCK_RESTR_VID.NAME_RESTR IS 'Наименование(суть) вида реструктуризации';




PROMPT *** Create  constraint PK_CCKRESTRVID ***
begin   
 execute immediate '
  ALTER TABLE BARS.CCK_RESTR_VID ADD CONSTRAINT PK_CCKRESTRVID PRIMARY KEY (VID_RESTR)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CCKRESTRVID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CCKRESTRVID ON BARS.CCK_RESTR_VID (VID_RESTR) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CCK_RESTR_VID ***
grant SELECT                                                                 on CCK_RESTR_VID   to BARSUPL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CCK_RESTR_VID   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CCK_RESTR_VID   to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CCK_RESTR_VID   to RCC_DEAL;
grant FLASHBACK,SELECT                                                       on CCK_RESTR_VID   to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CCK_RESTR_VID.sql =========*** End ***
PROMPT ===================================================================================== 
