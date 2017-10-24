

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EBK_GCIF.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EBK_GCIF ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''EBK_GCIF'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''EBK_GCIF'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''EBK_GCIF'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table EBK_GCIF ***
begin 
  execute immediate '
  CREATE TABLE BARS.EBK_GCIF 
   (	KF VARCHAR2(6), 
	RNK NUMBER(38,0), 
	GCIF VARCHAR2(30), 
	INSERT_DATE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to EBK_GCIF ***
 exec bpa.alter_policies('EBK_GCIF');


COMMENT ON TABLE BARS.EBK_GCIF IS 'Таблица идентификатора мастер-карточки на уровне банка';
COMMENT ON COLUMN BARS.EBK_GCIF.KF IS '';
COMMENT ON COLUMN BARS.EBK_GCIF.RNK IS '';
COMMENT ON COLUMN BARS.EBK_GCIF.GCIF IS '';
COMMENT ON COLUMN BARS.EBK_GCIF.INSERT_DATE IS '';




PROMPT *** Create  constraint SYS_C008137 ***
begin   
 execute immediate '
  ALTER TABLE BARS.EBK_GCIF MODIFY (KF NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008138 ***
begin   
 execute immediate '
  ALTER TABLE BARS.EBK_GCIF MODIFY (RNK NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008139 ***
begin   
 execute immediate '
  ALTER TABLE BARS.EBK_GCIF MODIFY (GCIF NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index INDX_EBK_GCIF_U1 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.INDX_EBK_GCIF_U1 ON BARS.EBK_GCIF (GCIF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index INDX_EBK_GCIF_U2 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.INDX_EBK_GCIF_U2 ON BARS.EBK_GCIF (KF, RNK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  EBK_GCIF ***
grant DELETE,INSERT,SELECT,UPDATE                                            on EBK_GCIF        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on EBK_GCIF        to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EBK_GCIF.sql =========*** End *** ====
PROMPT ===================================================================================== 
