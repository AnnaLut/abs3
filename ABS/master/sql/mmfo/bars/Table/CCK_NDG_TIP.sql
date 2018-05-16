PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CCK_NDG_TIP.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CCK_NDG_TIP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CCK_NDG_TIP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CCK_NDG_TIP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CCK_NDG_TIP ***
begin 
  execute immediate '
  CREATE TABLE BARS.CCK_NDG_TIP 
   (    ID_PAR number(1), 
    TIPS_NDG VARCHAR2(1000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CCK_NDG_TIP ***
 exec bpa.alter_policies('CCK_NDG_TIP');


COMMENT ON TABLE BARS.CCK_NDG_TIP IS 'Типи рахунків для відкриття Ген Угод';
COMMENT ON COLUMN BARS.CCK_NDG_TIP.ID_PAR IS 'Ідентифікатор 1 - Ген Угод, 0 - звичайна, 2 - суб.угод';
COMMENT ON COLUMN BARS.CCK_NDG_TIP.TIPS_NDG IS 'Перелік типів';


PROMPT *** Create  constraint CCK_NDG_TIP ***
begin   
 execute immediate '
  ALTER TABLE BARS.CCK_NDG_TIP ADD (
  CONSTRAINT CCK_NDG_TIP_ID_PAR
  CHECK (ID_PAR in (0,1,2))
  ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  constraint CCK_NDG_TIP ***
begin   
 execute immediate '
  ALTER TABLE BARS.CCK_NDG_TIP ADD (
  CONSTRAINT CCK_NDG_TIP_TIPS_NDG
  CHECK (regexp_like(TIPS_NDG, ''^([A-Z0-9 ]{3},){1,}$''))
  ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  grants  CCK_NDG_TIP ***
grant INSERT,SELECT,UPDATE                                                   on CCK_NDG_TIP to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CCK_NDG_TIP.sql =========*** E
PROMPT ===================================================================================== 