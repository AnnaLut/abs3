

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BP_DOMAIN.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BP_DOMAIN ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BP_DOMAIN'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BP_DOMAIN'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''BP_DOMAIN'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BP_DOMAIN ***
begin 
  execute immediate '
  CREATE TABLE BARS.BP_DOMAIN 
   (	TAB CHAR(12), 
	ATR CHAR(15), 
	NAME CHAR(35), 
	TATR NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BP_DOMAIN ***
 exec bpa.alter_policies('BP_DOMAIN');


COMMENT ON TABLE BARS.BP_DOMAIN IS 'Справочник полей, которые могут
быть задействованы в бизнес-правилах';
COMMENT ON COLUMN BARS.BP_DOMAIN.TAB IS 'Имя таблицы';
COMMENT ON COLUMN BARS.BP_DOMAIN.ATR IS 'Атрибут';
COMMENT ON COLUMN BARS.BP_DOMAIN.NAME IS 'Семантика';
COMMENT ON COLUMN BARS.BP_DOMAIN.TATR IS 'Тип атрибута';



PROMPT *** Create  grants  BP_DOMAIN ***
grant SELECT                                                                 on BP_DOMAIN       to BARSREADER_ROLE;
grant SELECT                                                                 on BP_DOMAIN       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BP_DOMAIN       to BARS_DM;
grant SELECT                                                                 on BP_DOMAIN       to START1;
grant SELECT                                                                 on BP_DOMAIN       to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BP_DOMAIN       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BP_DOMAIN.sql =========*** End *** ===
PROMPT ===================================================================================== 
