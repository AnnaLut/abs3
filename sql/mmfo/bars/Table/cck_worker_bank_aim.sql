

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CCK_WORKER_BANK_AIM.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CCK_WORKER_BANK_AIM ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CCK_WORKER_BANK_AIM'', ''CENTER'' , ''C'', ''C'', ''C'', null);
               bpa.alter_policy_info(''CCK_WORKER_BANK_AIM'', ''FILIAL'' , ''F'', ''F'', ''F'', null);
               bpa.alter_policy_info(''CCK_WORKER_BANK_AIM'', ''WHOLE'' , ''C'', ''C'', ''C'', null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CCK_WORKER_BANK_AIM ***
begin 
  execute immediate '
  CREATE TABLE BARS.CCK_WORKER_BANK_AIM 
   (	CODE VARCHAR2(2), 
	DESCR_AIM VARCHAR2(250)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CCK_WORKER_BANK_AIM ***
 exec bpa.alter_policies('CCK_WORKER_BANK_AIM');


COMMENT ON TABLE BARS.CCK_WORKER_BANK_AIM IS 'Цільове призначення кредитів працівникам банку';
COMMENT ON COLUMN BARS.CCK_WORKER_BANK_AIM.CODE IS 'Код';
COMMENT ON COLUMN BARS.CCK_WORKER_BANK_AIM.DESCR_AIM IS 'Опис цілі';



PROMPT *** Create  grants  CCK_WORKER_BANK_AIM ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CCK_WORKER_BANK_AIM to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CCK_WORKER_BANK_AIM to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CCK_WORKER_BANK_AIM to RCC_DEAL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CCK_WORKER_BANK_AIM.sql =========*** E
PROMPT ===================================================================================== 
