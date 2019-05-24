

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CCK_REP_AUTOR.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CCK_REP_AUTOR ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CCK_REP_AUTOR'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CCK_REP_AUTOR'', ''FILIAL'' , null,  null,  null,  null);
               bpa.alter_policy_info(''CCK_REP_AUTOR'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CCK_REP_AUTOR ***
begin 
  execute immediate '
  CREATE TABLE BARS.CCK_REP_AUTOR 
   (    ID_USER NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CCK_REP_AUTOR ***
 exec bpa.alter_policies('CCK_REP_AUTOR');


COMMENT ON TABLE BARS.CCK_REP_AUTOR IS 'Пользователи для печати даных по авторизации КД';
COMMENT ON COLUMN BARS.CCK_REP_AUTOR.ID_USER IS 'Код пользователя';

PROMPT *** Create  constraint PK_CCKREPAUTOR ***
begin   
 execute immediate '
  ALTER TABLE BARS.CCK_REP_AUTOR ADD CONSTRAINT PK_CCKREPAUTOR PRIMARY KEY (ID_USER)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/


PROMPT *** Create  grants  CCK_REP_AUTOR ***

grant DELETE,INSERT,SELECT,UPDATE                                  on CCK_REP_AUTOR           to BARS_ACCESS_DEFROLE;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CCK_REP_AUTOR.sql =========*** End *** =======
PROMPT ===================================================================================== 

begin 
Insert into BARS.CCK_REP_AUTOR
   (ID_USER)
 Values
   (2050311);
 exception when dup_val_on_index then null;  
end;
/ 
begin 
Insert into BARS.CCK_REP_AUTOR
   (ID_USER)
 Values
   (2088811);
 exception when dup_val_on_index then null;  
end;
/ 
begin 
Insert into BARS.CCK_REP_AUTOR
   (ID_USER)
 Values
   (3434311);
 exception when dup_val_on_index then null;  
end;
/ 
begin 
Insert into BARS.CCK_REP_AUTOR
   (ID_USER)
 Values
   (229211);
 exception when dup_val_on_index then null;  
end;
/
begin 
Insert into BARS.CCK_REP_AUTOR
   (ID_USER)
 Values
   (50645100);
 exception when dup_val_on_index then null;  
end;
/
begin 
Insert into BARS.CCK_REP_AUTOR
   (ID_USER)
 Values
   (5113500);
 exception when dup_val_on_index then null;  
end;
/
begin 
Insert into BARS.CCK_REP_AUTOR
   (ID_USER)
 Values
   (50021800);
 exception when dup_val_on_index then null;  
end;
/
begin 
Insert into BARS.CCK_REP_AUTOR
   (ID_USER)
 Values
   (51012700);
 exception when dup_val_on_index then null;  
end;
/
begin 
Insert into BARS.CCK_REP_AUTOR
   (ID_USER)
 Values
   (51078900);
 exception when dup_val_on_index then null;  
end;
/
begin 
Insert into BARS.CCK_REP_AUTOR
   (ID_USER)
 Values
   (50417500);
 exception when dup_val_on_index then null;  
end;
/
begin 
Insert into BARS.CCK_REP_AUTOR
   (ID_USER)
 Values
   (3284711);
 exception when dup_val_on_index then null;  
end;
/
begin 
Insert into BARS.CCK_REP_AUTOR
   (ID_USER)
 Values
   (50532300);
 exception when dup_val_on_index then null;  
end;
/
begin 
Insert into BARS.CCK_REP_AUTOR
   (ID_USER)
 Values
   (2629911);
 exception when dup_val_on_index then null;  
end;
/
begin 
Insert into BARS.CCK_REP_AUTOR
   (ID_USER)
 Values
   (51070000);
 exception when dup_val_on_index then null;  
end;
/
begin 
Insert into BARS.CCK_REP_AUTOR
   (ID_USER)
 Values
   (2046611);
 exception when dup_val_on_index then null;  
end;
/
begin 
Insert into BARS.CCK_REP_AUTOR
   (ID_USER)
 Values
   (2084211);
 exception when dup_val_on_index then null;  
end;
/
begin 
Insert into BARS.CCK_REP_AUTOR
   (ID_USER)
 Values
   (3605311);
 exception when dup_val_on_index then null;  
end;
/
begin 
Insert into BARS.CCK_REP_AUTOR
   (ID_USER)
 Values
   (50945800);
 exception when dup_val_on_index then null;  
end;
/
begin 
Insert into BARS.CCK_REP_AUTOR
   (ID_USER)
 Values
   (3088109);
 exception when dup_val_on_index then null;  
end;
/
begin 
Insert into BARS.CCK_REP_AUTOR
   (ID_USER)
 Values
   (50764900);
 exception when dup_val_on_index then null;  
end;
/
begin 
Insert into BARS.CCK_REP_AUTOR
   (ID_USER)
 Values
   (51092500);
 exception when dup_val_on_index then null;  
end;
/
begin 
Insert into BARS.CCK_REP_AUTOR
   (ID_USER)
 Values
   (51148600);
 exception when dup_val_on_index then null;  
end;
/
begin 
Insert into BARS.CCK_REP_AUTOR
   (ID_USER)
 Values
   (51102400);
 exception when dup_val_on_index then null;  
end;
/
begin 
Insert into BARS.CCK_REP_AUTOR
   (ID_USER)
 Values
   (51074100);
 exception when dup_val_on_index then null;  
end;
/
begin 
Insert into BARS.CCK_REP_AUTOR
   (ID_USER)
 Values
   (51078300);
 exception when dup_val_on_index then null;  
end;
/
begin 
Insert into BARS.CCK_REP_AUTOR
   (ID_USER)
 Values
   (51092400);
 exception when dup_val_on_index then null;  
end;
/
begin 
Insert into BARS.CCK_REP_AUTOR
   (ID_USER)
 Values
   (2114611);
 exception when dup_val_on_index then null;  
end;
/
begin 
Insert into BARS.CCK_REP_AUTOR
   (ID_USER)
 Values
   (238111);
 exception when dup_val_on_index then null;  
end;
/
begin 
Insert into BARS.CCK_REP_AUTOR
   (ID_USER)
 Values
   (51091200);
 exception when dup_val_on_index then null;  
end;
/
begin 
Insert into BARS.CCK_REP_AUTOR
   (ID_USER)
 Values
   (50722600);
 exception when dup_val_on_index then null;  
end;
/
begin 
Insert into BARS.CCK_REP_AUTOR
   (ID_USER)
 Values
   (51112500);
 exception when dup_val_on_index then null;  
end;
/
begin 
Insert into BARS.CCK_REP_AUTOR
   (ID_USER)
 Values
   (2261015);
 exception when dup_val_on_index then null;  
end;
/
begin 
Insert into BARS.CCK_REP_AUTOR
   (ID_USER)
 Values
   (51299400);
 exception when dup_val_on_index then null;  
end;
/
begin 
Insert into BARS.CCK_REP_AUTOR
   (ID_USER)
 Values
   (51297900);
 exception when dup_val_on_index then null;  
end;
/

commit;

