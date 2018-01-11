

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/VIP_PARAMS_TEMPLATE.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to VIP_PARAMS_TEMPLATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''VIP_PARAMS_TEMPLATE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''VIP_PARAMS_TEMPLATE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table VIP_PARAMS_TEMPLATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.VIP_PARAMS_TEMPLATE 
   (	ID_PAR VARCHAR2(6), 
	NAME_PAR VARCHAR2(255), 
	TXT VARCHAR2(1000), 
	DAY VARCHAR2(255)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to VIP_PARAMS_TEMPLATE ***
 exec bpa.alter_policies('VIP_PARAMS_TEMPLATE');


COMMENT ON TABLE BARS.VIP_PARAMS_TEMPLATE IS 'Параметри формування повідомлень по VIP клієнтам';
COMMENT ON COLUMN BARS.VIP_PARAMS_TEMPLATE.ID_PAR IS 'Ідентифікатор параметру';
COMMENT ON COLUMN BARS.VIP_PARAMS_TEMPLATE.NAME_PAR IS 'Найменування параметру';
COMMENT ON COLUMN BARS.VIP_PARAMS_TEMPLATE.TXT IS 'Текст повідомлення';
COMMENT ON COLUMN BARS.VIP_PARAMS_TEMPLATE.DAY IS 'Кількість днів~Вказувати через кому';




PROMPT *** Create  constraint CC_VPT_IDPAR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.VIP_PARAMS_TEMPLATE MODIFY (ID_PAR CONSTRAINT CC_VPT_IDPAR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_VIPPARAMSTEMPLATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.VIP_PARAMS_TEMPLATE ADD CONSTRAINT UK_VIPPARAMSTEMPLATE UNIQUE (ID_PAR)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_VIPPARAMSTEMPLATE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_VIPPARAMSTEMPLATE ON BARS.VIP_PARAMS_TEMPLATE (ID_PAR) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  VIP_PARAMS_TEMPLATE ***
grant SELECT                                                                 on VIP_PARAMS_TEMPLATE to BARSREADER_ROLE;
grant INSERT,SELECT,UPDATE                                                   on VIP_PARAMS_TEMPLATE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on VIP_PARAMS_TEMPLATE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/VIP_PARAMS_TEMPLATE.sql =========*** E
PROMPT ===================================================================================== 
