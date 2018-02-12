PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ZDK.sql =========*** Run *** =========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ZDK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ZDK'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ZDK'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''ZDK'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/
  

PROMPT *** Create  table ZDK ***
begin 
  execute immediate '
  CREATE TABLE BARS.ZDK 
  (  DK       NUMBER(1),
     Z_TYPE   VARCHAR2(35)
  ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


PROMPT *** ALTER_POLICIES to ZDK ***
 exec bpa.alter_policies('ZDK');


COMMENT ON TABLE BARS.ZDK IS 'Виды биржевых заявок';
COMMENT ON COLUMN BARS.ZDK.DK IS 'Код вида заявки';
COMMENT ON COLUMN BARS.ZDK.Z_TYPE IS 'Описание';


PROMPT *** Create  grants  ZDK ***
grant DELETE,INSERT,SELECT,UPDATE                                            on DK              to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DK              to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DK              to START1;

COMMIT;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ZDK.sql =========*** End *** =========
PROMPT ===================================================================================== 
