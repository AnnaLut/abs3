

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/VER_DOC_MAKET.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to VER_DOC_MAKET ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''VER_DOC_MAKET'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''VER_DOC_MAKET'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''VER_DOC_MAKET'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table VER_DOC_MAKET ***
begin 
  execute immediate '
  CREATE TABLE BARS.VER_DOC_MAKET 
   (	NBS VARCHAR2(4), 
	NLS_REZ VARCHAR2(15), 
	OB22 VARCHAR2(2), 
	KV NUMBER(*,0), 
	ACC_REZ NUMBER(*,0), 
	S1 NUMBER, 
	SQ1 NUMBER, 
	NLSA VARCHAR2(15), 
	OST NUMBER, 
	DELTA NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to VER_DOC_MAKET ***
 exec bpa.alter_policies('VER_DOC_MAKET');


COMMENT ON TABLE BARS.VER_DOC_MAKET IS 'Таблиця відхилення резерву та залишкыв рах.резерву';
COMMENT ON COLUMN BARS.VER_DOC_MAKET.NBS IS 'Балансовий рахунок';
COMMENT ON COLUMN BARS.VER_DOC_MAKET.NLS_REZ IS 'Номер рахунку рез.(баланс)';
COMMENT ON COLUMN BARS.VER_DOC_MAKET.OB22 IS 'ОБ22';
COMMENT ON COLUMN BARS.VER_DOC_MAKET.KV IS 'Код валюти';
COMMENT ON COLUMN BARS.VER_DOC_MAKET.ACC_REZ IS 'Код валюти';
COMMENT ON COLUMN BARS.VER_DOC_MAKET.S1 IS 'Сума резерву (ном.)';
COMMENT ON COLUMN BARS.VER_DOC_MAKET.SQ1 IS 'Сума резерву (екв.)';
COMMENT ON COLUMN BARS.VER_DOC_MAKET.NLSA IS 'Номер рахунку рез.(резерв)';
COMMENT ON COLUMN BARS.VER_DOC_MAKET.OST IS 'Плановий залишок по рах резерву';
COMMENT ON COLUMN BARS.VER_DOC_MAKET.DELTA IS 'Відхилення розр.рах. резеву та розр.резервом';
COMMENT ON COLUMN BARS.VER_DOC_MAKET.KF IS '';



PROMPT *** Create  grants  VER_DOC_MAKET ***
grant SELECT                                                                 on VER_DOC_MAKET   to BARSREADER_ROLE;
grant SELECT                                                                 on VER_DOC_MAKET   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on VER_DOC_MAKET   to BARS_DM;
grant SELECT                                                                 on VER_DOC_MAKET   to RCC_DEAL;
grant SELECT                                                                 on VER_DOC_MAKET   to START1;
grant SELECT                                                                 on VER_DOC_MAKET   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/VER_DOC_MAKET.sql =========*** End ***
PROMPT ===================================================================================== 
