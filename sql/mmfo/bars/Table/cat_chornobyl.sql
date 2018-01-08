

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CAT_CHORNOBYL.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CAT_CHORNOBYL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CAT_CHORNOBYL'', ''CENTER'' , ''C'', ''C'', ''C'', null);
               bpa.alter_policy_info(''CAT_CHORNOBYL'', ''FILIAL'' , ''F'', ''F'', ''F'', null);
               bpa.alter_policy_info(''CAT_CHORNOBYL'', ''WHOLE'' , ''C'', ''C'', ''C'', null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CAT_CHORNOBYL ***
begin 
  execute immediate '
  CREATE TABLE BARS.CAT_CHORNOBYL 
   (	CODE VARCHAR2(1), 
	CATEGORY VARCHAR2(250)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CAT_CHORNOBYL ***
 exec bpa.alter_policies('CAT_CHORNOBYL');


COMMENT ON TABLE BARS.CAT_CHORNOBYL IS 'Категорія громадян, які постраждали внаслідок Чорнобильської катастрофи';
COMMENT ON COLUMN BARS.CAT_CHORNOBYL.CODE IS 'Код';
COMMENT ON COLUMN BARS.CAT_CHORNOBYL.CATEGORY IS 'Категорія';



PROMPT *** Create  grants  CAT_CHORNOBYL ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CAT_CHORNOBYL   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CAT_CHORNOBYL   to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CAT_CHORNOBYL   to RCC_DEAL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CAT_CHORNOBYL.sql =========*** End ***
PROMPT ===================================================================================== 
