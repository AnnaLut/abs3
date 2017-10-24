

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PAP_ZVT.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PAP_ZVT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PAP_ZVT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''PAP_ZVT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''PAP_ZVT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PAP_ZVT ***
begin 
  execute immediate '
  CREATE TABLE BARS.PAP_ZVT 
   (	TEMA NUMBER(*,0), 
	NAME VARCHAR2(35), 
	PRN NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PAP_ZVT ***
 exec bpa.alter_policies('PAP_ZVT');


COMMENT ON TABLE BARS.PAP_ZVT IS 'Папки для зводу док дня в РУ ОБ';
COMMENT ON COLUMN BARS.PAP_ZVT.TEMA IS 'Код папки';
COMMENT ON COLUMN BARS.PAP_ZVT.NAME IS 'Наим. папки';
COMMENT ON COLUMN BARS.PAP_ZVT.PRN IS '';




PROMPT *** Create  constraint XPK_PAPZVT ***
begin   
 execute immediate '
  ALTER TABLE BARS.PAP_ZVT ADD CONSTRAINT XPK_PAPZVT PRIMARY KEY (TEMA)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_PAPZVT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_PAPZVT ON BARS.PAP_ZVT (TEMA) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PAP_ZVT ***
grant SELECT                                                                 on PAP_ZVT         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PAP_ZVT         to BARS_DM;
grant SELECT                                                                 on PAP_ZVT         to RPBN001;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on PAP_ZVT         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PAP_ZVT.sql =========*** End *** =====
PROMPT ===================================================================================== 
