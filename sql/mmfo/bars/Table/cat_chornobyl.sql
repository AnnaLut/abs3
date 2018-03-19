PROMPT *** ALTER_POLICY_INFO to CAT_CHORNOBYL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CAT_CHORNOBYL'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CAT_CHORNOBYL'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CAT_CHORNOBYL'', ''WHOLE'' , null, null, null, null);
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
grant SELECT                                                                 on CAT_CHORNOBYL   to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CAT_CHORNOBYL   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CAT_CHORNOBYL   to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CAT_CHORNOBYL   to RCC_DEAL;
grant SELECT                                                                 on CAT_CHORNOBYL   to UPLD;


