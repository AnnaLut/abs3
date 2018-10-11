PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/sdo_autopay_nazn_templ.sql =========*** Run *** =====
PROMPT ===================================================================================== 

BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''sdo_autopay_nazn_templ'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''sdo_autopay_nazn_templ'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''sdo_autopay_nazn_templ'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/


PROMPT *** Create  table sdo_autopay_nazn_templs ***
begin 
  execute immediate ' CREATE TABLE sdo_autopay_nazn_templ
                ( word_template  varchar2(200), constraint  pk_word primary key(word_template)    )    organization index  tablespace brssmld';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARS.sdo_autopay_nazn_templ     IS 'Справочник слов для исключеyия из назначения поатежа';



grant SELECT                                                                 on BARS.sdo_autopay_nazn_templ          to BARSaq;
grant SELECt, insert, update, delete                                         on BARS.sdo_autopay_nazn_templ     to bars_access_defrole;
             



