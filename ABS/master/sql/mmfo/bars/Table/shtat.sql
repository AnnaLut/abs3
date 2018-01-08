

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SHTAT.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SHTAT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SHTAT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SHTAT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SHTAT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SHTAT ***
begin 
  execute immediate '
  CREATE TABLE BARS.SHTAT 
   (	TABN NUMBER(*,0), 
	FAMILY VARCHAR2(20), 
	NAME CHAR(10), 
	PATRONYMIC VARCHAR2(13), 
	DEPAT NUMBER(*,0), 
	SUM_OKL NUMBER(14,2), 
	INV NUMBER(*,0), 
	OSOBA_T CHAR(1), 
	KARTA_T CHAR(1)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SHTAT ***
 exec bpa.alter_policies('SHTAT');


COMMENT ON TABLE BARS.SHTAT IS '';
COMMENT ON COLUMN BARS.SHTAT.TABN IS '';
COMMENT ON COLUMN BARS.SHTAT.FAMILY IS '';
COMMENT ON COLUMN BARS.SHTAT.NAME IS '';
COMMENT ON COLUMN BARS.SHTAT.PATRONYMIC IS '';
COMMENT ON COLUMN BARS.SHTAT.DEPAT IS '';
COMMENT ON COLUMN BARS.SHTAT.SUM_OKL IS '';
COMMENT ON COLUMN BARS.SHTAT.INV IS '';
COMMENT ON COLUMN BARS.SHTAT.OSOBA_T IS '';
COMMENT ON COLUMN BARS.SHTAT.KARTA_T IS '';



PROMPT *** Create  grants  SHTAT ***
grant SELECT                                                                 on SHTAT           to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SHTAT           to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SHTAT           to START1;
grant SELECT                                                                 on SHTAT           to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SHTAT.sql =========*** End *** =======
PROMPT ===================================================================================== 
