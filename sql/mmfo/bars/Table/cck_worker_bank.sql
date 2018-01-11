

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CCK_WORKER_BANK.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CCK_WORKER_BANK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CCK_WORKER_BANK'', ''CENTER'' , ''C'', ''C'', ''C'', null);
               bpa.alter_policy_info(''CCK_WORKER_BANK'', ''FILIAL'' , ''F'', ''F'', ''F'', null);
               bpa.alter_policy_info(''CCK_WORKER_BANK'', ''WHOLE'' , ''C'', ''C'', ''C'', null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CCK_WORKER_BANK ***
begin 
  execute immediate '
  CREATE TABLE BARS.CCK_WORKER_BANK 
   (	CODE VARCHAR2(1), 
	DESCRIPTION VARCHAR2(250)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CCK_WORKER_BANK ***
 exec bpa.alter_policies('CCK_WORKER_BANK');


COMMENT ON TABLE BARS.CCK_WORKER_BANK IS 'Приналежність до працівників банку';
COMMENT ON COLUMN BARS.CCK_WORKER_BANK.CODE IS 'Код';
COMMENT ON COLUMN BARS.CCK_WORKER_BANK.DESCRIPTION IS 'Опис';



PROMPT *** Create  grants  CCK_WORKER_BANK ***
grant SELECT                                                                 on CCK_WORKER_BANK to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CCK_WORKER_BANK to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CCK_WORKER_BANK to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CCK_WORKER_BANK to RCC_DEAL;
grant SELECT                                                                 on CCK_WORKER_BANK to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CCK_WORKER_BANK.sql =========*** End *
PROMPT ===================================================================================== 
