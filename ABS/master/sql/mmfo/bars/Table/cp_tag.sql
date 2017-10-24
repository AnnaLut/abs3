

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CP_TAG.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CP_TAG ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_TAG'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CP_TAG'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CP_TAG'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CP_TAG ***
begin 
  execute immediate '
  CREATE TABLE BARS.CP_TAG 
   (	ID NUMBER(*,0), 
	TAG VARCHAR2(5), 
	NAME VARCHAR2(50)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CP_TAG ***
 exec bpa.alter_policies('CP_TAG');


COMMENT ON TABLE BARS.CP_TAG IS 'Коды доп.реквизитов ЦБ';
COMMENT ON COLUMN BARS.CP_TAG.ID IS 'К чему от относится доп.реквизит: 1- Эмитент, 2- ЦБ, 3-сделка';
COMMENT ON COLUMN BARS.CP_TAG.TAG IS 'ТЭГ -мнем.код доп.реквизита';
COMMENT ON COLUMN BARS.CP_TAG.NAME IS 'Семантика доп.реквизита';




PROMPT *** Create  constraint XPK_CPTAG ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_TAG ADD CONSTRAINT XPK_CPTAG PRIMARY KEY (TAG)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CPTAG ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CPTAG ON BARS.CP_TAG (TAG) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CP_TAG ***
grant SELECT                                                                 on CP_TAG          to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_TAG          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CP_TAG          to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_TAG          to CP_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_TAG          to START1;
grant SELECT                                                                 on CP_TAG          to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CP_TAG.sql =========*** End *** ======
PROMPT ===================================================================================== 
