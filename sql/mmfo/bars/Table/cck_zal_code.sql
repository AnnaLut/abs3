

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CCK_ZAL_CODE.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CCK_ZAL_CODE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CCK_ZAL_CODE'', ''CENTER'' , ''C'', ''C'', ''C'', null);
               bpa.alter_policy_info(''CCK_ZAL_CODE'', ''FILIAL'' , ''F'', ''F'', ''F'', null);
               bpa.alter_policy_info(''CCK_ZAL_CODE'', ''WHOLE'' , ''C'', ''C'', ''C'', null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CCK_ZAL_CODE ***
begin 
  execute immediate '
  CREATE TABLE BARS.CCK_ZAL_CODE 
   (	CODE VARCHAR2(3), 
	DESCR_CODE VARCHAR2(250)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CCK_ZAL_CODE ***
 exec bpa.alter_policies('CCK_ZAL_CODE');


COMMENT ON TABLE BARS.CCK_ZAL_CODE IS 'Додатковий код предмету застави';
COMMENT ON COLUMN BARS.CCK_ZAL_CODE.CODE IS 'Код';
COMMENT ON COLUMN BARS.CCK_ZAL_CODE.DESCR_CODE IS 'Опис коду';



PROMPT *** Create  grants  CCK_ZAL_CODE ***
grant SELECT                                                                 on CCK_ZAL_CODE    to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CCK_ZAL_CODE    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CCK_ZAL_CODE    to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CCK_ZAL_CODE    to RCC_DEAL;
grant SELECT                                                                 on CCK_ZAL_CODE    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CCK_ZAL_CODE.sql =========*** End *** 
PROMPT ===================================================================================== 
