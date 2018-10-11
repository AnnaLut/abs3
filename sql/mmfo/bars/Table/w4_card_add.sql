
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/table/w4_card_add.sql =========*** Run *** =
 PROMPT ===================================================================================== 

BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''W4_CARD_ADD'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''W4_CARD_ADD'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          ';
END; 
/

PROMPT *** Create  table W4_CARD_ADD  ***

begin 
  execute immediate ' 
CREATE TABLE BARS.W4_CARD_ADD 
   (  "CARD_CODE" VARCHAR2(32), 
  "CARD_CODE_ADD" VARCHAR2(32), 
  "EN" NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "BRSDYND" 
';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/ 

begin 
  execute immediate ' 
  ALTER TABLE BARS.W4_CARD_ADD ADD CONSTRAINT "PK_W4_CARD_ADD" PRIMARY KEY ("CARD_CODE", "CARD_CODE_ADD")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "BRSDYND"  ENABLE
';
exception when others then       
  if sqlcode=-02260 then null; else raise; end if; 
end; 
/ 

 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/table/w4_card_add.sql =========*** End *** =
 PROMPT ===================================================================================== 
 