

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CP_OB_MARKET.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CP_OB_MARKET ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_OB_MARKET'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CP_OB_MARKET'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CP_OB_MARKET ***
begin 
  execute immediate '
  CREATE TABLE BARS.CP_OB_MARKET 
   (	CODE VARCHAR2(2), 
	TXT VARCHAR2(70)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CP_OB_MARKET ***
 exec bpa.alter_policies('CP_OB_MARKET');


COMMENT ON TABLE BARS.CP_OB_MARKET IS 'Види операц_ї щодо маркетингу';
COMMENT ON COLUMN BARS.CP_OB_MARKET.CODE IS 'Код';
COMMENT ON COLUMN BARS.CP_OB_MARKET.TXT IS 'Розшифровка';




PROMPT *** Create  constraint SYS_C002685966 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_OB_MARKET MODIFY (CODE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CP_OB_MARKET ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_OB_MARKET    to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CP_OB_MARKET.sql =========*** End *** 
PROMPT ===================================================================================== 
