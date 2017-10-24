

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CP_REZ_LOG.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CP_REZ_LOG ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_REZ_LOG'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CP_REZ_LOG'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CP_REZ_LOG'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CP_REZ_LOG ***
begin 
  execute immediate '
  CREATE TABLE BARS.CP_REZ_LOG 
   (	USERID NUMBER, 
	ID NUMBER, 
	ROWNUMBER NUMBER, 
	TXT VARCHAR2(1000), 
	VAL VARCHAR2(100), 
	DT DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CP_REZ_LOG ***
 exec bpa.alter_policies('CP_REZ_LOG');


COMMENT ON TABLE BARS.CP_REZ_LOG IS 'Таблица - протокол расчета резерва';
COMMENT ON COLUMN BARS.CP_REZ_LOG.USERID IS 'Пользователь';
COMMENT ON COLUMN BARS.CP_REZ_LOG.ID IS 'асс счета';
COMMENT ON COLUMN BARS.CP_REZ_LOG.ROWNUMBER IS 'Номер инф. строки';
COMMENT ON COLUMN BARS.CP_REZ_LOG.TXT IS 'Текст';
COMMENT ON COLUMN BARS.CP_REZ_LOG.VAL IS '';
COMMENT ON COLUMN BARS.CP_REZ_LOG.DT IS '';



PROMPT *** Create  grants  CP_REZ_LOG ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_REZ_LOG      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CP_REZ_LOG      to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_REZ_LOG      to RCC_DEAL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CP_REZ_LOG      to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CP_REZ_LOG.sql =========*** End *** ==
PROMPT ===================================================================================== 
