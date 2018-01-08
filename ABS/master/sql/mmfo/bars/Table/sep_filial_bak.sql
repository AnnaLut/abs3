

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SEP_FILIAL_BAK.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SEP_FILIAL_BAK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SEP_FILIAL_BAK'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SEP_FILIAL_BAK'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SEP_FILIAL_BAK'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SEP_FILIAL_BAK ***
begin 
  execute immediate '
  CREATE TABLE BARS.SEP_FILIAL_BAK 
   (	MFO VARCHAR2(6), 
	TT CHAR(3), 
	NLS VARCHAR2(14), 
	OKPO VARCHAR2(14), 
	NMK VARCHAR2(38), 
	SORT_CODE VARCHAR2(20)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SEP_FILIAL_BAK ***
 exec bpa.alter_policies('SEP_FILIAL_BAK');


COMMENT ON TABLE BARS.SEP_FILIAL_BAK IS '';
COMMENT ON COLUMN BARS.SEP_FILIAL_BAK.MFO IS '';
COMMENT ON COLUMN BARS.SEP_FILIAL_BAK.TT IS '';
COMMENT ON COLUMN BARS.SEP_FILIAL_BAK.NLS IS '';
COMMENT ON COLUMN BARS.SEP_FILIAL_BAK.OKPO IS '';
COMMENT ON COLUMN BARS.SEP_FILIAL_BAK.NMK IS '';
COMMENT ON COLUMN BARS.SEP_FILIAL_BAK.SORT_CODE IS '';




PROMPT *** Create  constraint SYS_C009661 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEP_FILIAL_BAK MODIFY (MFO NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009662 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEP_FILIAL_BAK MODIFY (TT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009663 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEP_FILIAL_BAK MODIFY (NLS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009664 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEP_FILIAL_BAK MODIFY (OKPO NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009665 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEP_FILIAL_BAK MODIFY (NMK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009666 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEP_FILIAL_BAK MODIFY (SORT_CODE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SEP_FILIAL_BAK ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SEP_FILIAL_BAK  to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SEP_FILIAL_BAK  to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SEP_FILIAL_BAK.sql =========*** End **
PROMPT ===================================================================================== 
