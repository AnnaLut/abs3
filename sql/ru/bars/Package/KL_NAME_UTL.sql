CREATE OR REPLACE PACKAGE KL_NAME_UTL IS

--***************************************************************************--
-- (C) BARS. Contragents
--***************************************************************************--

G_HEADER_VERSION  CONSTANT VARCHAR2(64)  := 'Version 1.1 13/05/2017';
G_AWK_HEADER_DEFS CONSTANT VARCHAR2(512) := '';

--***************************************************************************--
    -- Ф-ция перевірки імені
--***************************************************************************--    
    function check_name(p_FIRST_NAME  FIRST_NAMES.FIRSTRU%type,
                        p_MIDDLE_NAME MIDDLE_NAMES.MIDDLERU%type) return varchar2;

--***************************************************************************--
-- процедура добавления/обновления имени
--***************************************************************************--
PROCEDURE Set_First_Name (
  p_firstid           first_names.firstid%type,   
  p_firstru           first_names.firstru%type,     
  p_firstua           first_names.firstua%type,     
  p_sexid             first_names.sexid%type,       
  p_middleuam         first_names.middleuam%type,   
  p_middleuaf         first_names.middleuaf%type,   
  p_middlerum         first_names.middlerum%type,   
  p_middleruf         first_names.middleruf%type,   
  p_firstuaof         first_names.firstuaof%type,   
  p_firstuarod        first_names.firstuarod%type,  
  p_firstuadat        first_names.firstuadat%type,  
  p_firstuavin        first_names.firstuavin%type,  
  p_firstuatvo        first_names.firstuatvo%type,  
  p_firstuapre        first_names.firstuapre%type,  
  p_firstrurod        first_names.firstrurod%type,  
  p_firstrudat        first_names.firstrudat%type,  
  p_firstruvin        first_names.firstruvin%type,  
  p_firstrutvo        first_names.firstrutvo%type,  
  p_firstrupre        first_names.firstrupre%type    
);

--***************************************************************************--
-- процедура удаления имени
--***************************************************************************--
PROCEDURE Del_First_Name ( p_firstid           first_names.firstid %type);

--***************************************************************************--
-- процедура добавления/обновления отчества
--***************************************************************************--
PROCEDURE Set_Middle_Name (
  p_middleid       middle_names.middleid%type,
  p_middleua       middle_names.middleua%type,
  p_middleru       middle_names.middleru%type,
  p_sexid          middle_names.sexid%type,
  p_firstid        middle_names.firstid%type,
  p_middleuaof     middle_names.middleuaof%type,
  p_middleuarod    middle_names.middleuarod%type,
  p_middleuadat    middle_names.middleuadat%type,
  p_middleuavin    middle_names.middleuavin%type,
  p_middleuatvo    middle_names.middleuatvo%type,
  p_middleuapre    middle_names.middleuapre%type,
  p_middlerurod    middle_names.middlerurod%type,
  p_middlerudat    middle_names.middlerudat%type,
  p_middleruvin    middle_names.middleruvin%type,
  p_middlerutvo    middle_names.middlerutvo%type,
  p_middlerupre    middle_names.middlerupre%type
);

--***************************************************************************--
-- процедура удаления отчества
--***************************************************************************--
PROCEDURE Del_Middle_Name ( p_middleid       middle_names.middleid%type);                        

END KL_NAME_UTL;
/
CREATE OR REPLACE PACKAGE BODY KL_NAME_UTL IS

--***************************************************************************--
-- (C) BARS. Contragents
--***************************************************************************--

G_HEADER_VERSION  CONSTANT VARCHAR2(64)  := 'Version 1.1 13/05/2017';
G_AWK_HEADER_DEFS CONSTANT VARCHAR2(512) := '';

--***************************************************************************--
    -- Ф-ция перевірки імені
--***************************************************************************--    
    function check_name(p_FIRST_NAME  FIRST_NAMES.FIRSTRU%type,
                        p_MIDDLE_NAME MIDDLE_NAMES.MIDDLERU%type) return varchar2
    is
     sres varchar2(50);
    begin
        if p_FIRST_NAME is not null then
         begin
           select distinct t.firstua into sres from FIRST_NAMES t where t.firstru = p_FIRST_NAME;
         exception when others then
          sres:= null;
         end;
        elsif p_MIDDLE_NAME is not null then
         begin
           select distinct t.middleua into sres from MIDDLE_NAMES t where t.middleru = p_MIDDLE_NAME;
         exception when others then
          sres:= null;
         end;
        else
          sres:= null;
        end if;
     return sres;
    end check_name;
    
--***************************************************************************--
-- процедура добавления/обновления имени
--***************************************************************************--
PROCEDURE Set_First_Name (
  p_firstid           first_names.firstid%type,   
  p_firstru           first_names.firstru%type,     
  p_firstua           first_names.firstua%type,     
  p_sexid             first_names.sexid%type,       
  p_middleuam         first_names.middleuam%type,   
  p_middleuaf         first_names.middleuaf%type,   
  p_middlerum         first_names.middlerum%type,   
  p_middleruf         first_names.middleruf%type,   
  p_firstuaof         first_names.firstuaof%type,   
  p_firstuarod        first_names.firstuarod%type,  
  p_firstuadat        first_names.firstuadat%type,  
  p_firstuavin        first_names.firstuavin%type,  
  p_firstuatvo        first_names.firstuatvo%type,  
  p_firstuapre        first_names.firstuapre%type,  
  p_firstrurod        first_names.firstrurod%type,  
  p_firstrudat        first_names.firstrudat%type,  
  p_firstruvin        first_names.firstruvin%type,  
  p_firstrutvo        first_names.firstrutvo%type,  
  p_firstrupre        first_names.firstrupre%type    
) IS
  l_title    varchar2(20) := 'KL_NAME_UTL.Set_First_Name: ';
  l_firstid  first_names.firstid %type; 
BEGIN
  bars_audit.trace('%s params 1:'
       || 'p_firstid     =>%s,'
       || 'p_firstru     =>%s,'
       || 'p_firstua     =>%s,'
       || 'p_sexid       =>%s,'
       || 'p_middleuam   =>%s,'
       || 'p_middleuaf   =>%s,'
       || 'p_middlerum   =>%s,'
       || 'p_middleruf   =>%s',
       l_title,
       to_char(p_firstid),
       p_firstru,   
       p_firstua ,  
       to_char(p_sexid),     
       p_middleuam, 
       p_middleuaf ,
       p_middlerum ,
       p_middleruf 
                   );
  bars_audit.trace('%s params 2:'   
       || 'p_firstuaof   =>%s,'
       || 'p_firstuarod  =>%s,'
       || 'p_firstuadat  =>%s,'
       || 'p_firstuavin  =>%s,'
       || 'p_firstuatvo  =>%s,'
       || 'p_firstuapre  =>%s,'
       || 'p_firstrurod  =>%s,'
       || 'p_firstrudat  =>%s',
       l_title,
       p_firstuaof ,
       p_firstuarod,
       p_firstuadat,
       p_firstuavin,
       p_firstuatvo,
       p_firstuapre,
       p_firstrurod,
       p_firstrudat
                   );                        
  bars_audit.trace('%s params 3:'
       || 'p_firstrudat  =>%s,'
       || 'p_firstruvin  =>%s,'
       || 'p_firstrutvo  =>%s,'
       || 'p_firstrupre  =>%s',
       l_title,
       p_firstrudat,
       p_firstruvin,
       p_firstrutvo,
       p_firstrupre
                   );       
                   
  UPDATE first_names
  SET firstru      = p_firstru,   
      firstua      = p_firstua,    
      sexid        = p_sexid,      
      middleuam    = p_middleuam,  
      middleuaf    = p_middleuaf,  
      middlerum    = p_middlerum,  
      middleruf    = p_middleruf,  
      firstuaof    = p_firstuaof , 
      firstuarod   = p_firstuarod, 
      firstuadat   = p_firstuadat,
      firstuavin   = p_firstuavin, 
      firstuatvo   = p_firstuatvo, 
      firstuapre   = p_firstuapre, 
      firstrurod   = p_firstrurod, 
      firstrudat   = p_firstrudat, 
      firstruvin   = p_firstruvin,
      firstrutvo   = p_firstrutvo, 
      firstrupre   = p_firstrupre 
   WHERE firstid      = p_firstid;  
  IF SQL%rowcount = 0 THEN
     l_firstid:=S_FIRST_NAMES.NEXTVAL;
     bars_audit.trace('%s 3. Начало добавления имени firstid=%s', l_title, l_firstid);
     INSERT INTO first_names 
       (
        firstid,
        firstru,
        firstua,
        sexid,
        middleuam,
        middleuaf,
        middlerum,
        middleruf,
        firstuaof,
        firstuarod,
        firstuadat,
        firstuavin,
        firstuatvo,
        firstuapre,
        firstrurod,
        firstrudat,
        firstruvin,
        firstrutvo,
        firstrupre
        )
     VALUES 
       (l_firstid,   
        p_firstru,   
        p_firstua,   
        p_sexid,     
        p_middleuam, 
        p_middleuaf, 
        p_middlerum, 
        p_middleruf, 
        p_firstuaof, 
        p_firstuarod,
        p_firstuadat,
        p_firstuavin,
        p_firstuatvo,
        p_firstuapre,
        p_firstrurod,
        p_firstrudat,
        p_firstruvin,
        p_firstrutvo,
        p_firstrupre
      );
     bars_audit.trace('%s 4. Завершено добавление имени firstid=%s', l_title, l_firstid);
  ELSE
     bars_audit.trace('%s 5. Завершено исправление имени firstid=%s', l_title, p_firstid);
  END IF;
END Set_First_Name;    


--***************************************************************************--
-- процедура удаления имени
--***************************************************************************--
PROCEDURE Del_First_Name ( p_firstid           first_names.firstid %type)
is
  l_title varchar2(30) := 'KL_NAME_UTL.Del_First_Name: ';
begin
  bars_audit.trace('%s 1.params: p_firstid =>%s',l_title, to_char(p_firstid));

     delete from first_names
      where firstid        = p_firstid;
  bars_audit.trace('%s 2. удаление имени: firstid=%s',l_title, to_char(p_firstid));
end Del_First_Name;


--***************************************************************************--
-- процедура добавления/обновления отчества
--***************************************************************************--
PROCEDURE Set_Middle_Name (
  p_middleid       middle_names.middleid%type,
  p_middleua       middle_names.middleua%type,
  p_middleru       middle_names.middleru%type,
  p_sexid          middle_names.sexid%type,
  p_firstid        middle_names.firstid%type,
  p_middleuaof     middle_names.middleuaof%type,
  p_middleuarod    middle_names.middleuarod%type,
  p_middleuadat    middle_names.middleuadat%type,
  p_middleuavin    middle_names.middleuavin%type,
  p_middleuatvo    middle_names.middleuatvo%type,
  p_middleuapre    middle_names.middleuapre%type,
  p_middlerurod    middle_names.middlerurod%type,
  p_middlerudat    middle_names.middlerudat%type,
  p_middleruvin    middle_names.middleruvin%type,
  p_middlerutvo    middle_names.middlerutvo%type,
  p_middlerupre    middle_names.middlerupre%type
) IS
  l_title    varchar2(20) := 'KL_NAME_UTL.Set_Middle_Name: ';
  l_middleid  middle_names.middleid %type; 
BEGIN
  bars_audit.trace('%s params 1:'
       || 'p_middleid     =>%s,'
       || 'p_middleua     =>%s,'
       || 'p_middleru     =>%s,'
       || 'p_sexid        =>%s,'
       || 'p_firstid      =>%s,'
       || 'p_middleuaof   =>%s,'
       || 'p_middleuarod  =>%s,'
       || 'p_middleuadat  =>%s',
       l_title,
       to_char(p_middleid),   
       p_middleua,   
       p_middleru,   
       p_sexid,         
       to_char(p_firstid) ,   
       p_middleuaof, 
       p_middleuarod,
       p_middleuadat
                   );
  bars_audit.trace('%s params 2:'   
       || 'p_middleuavin  =>%s,'
       || 'p_middleuatvo  =>%s,'
       || 'p_middleuapre  =>%s,'
       || 'p_middlerurod  =>%s,'
       || 'p_middlerudat  =>%s,'
       || 'p_middleruvin  =>%s,'
       || 'p_middlerutvo  =>%s,'
       || 'p_middlerupre  =>%s',
       l_title,
       p_middleuavin,
       p_middleuatvo,
       p_middleuapre,
       p_middlerurod,
       p_middlerudat,
       p_middleruvin,
       p_middlerutvo,
       p_middlerupre
                   );                             
                   
  UPDATE middle_names
  SET middleua     = p_middleua,    
      middleru     = p_middleru,    
      sexid        = p_sexid,       
      firstid      = p_firstid,     
      middleuaof   = p_middleuaof,  
      middleuarod  = p_middleuarod, 
      middleuadat  = p_middleuadat, 
      middleuavin  = p_middleuavin, 
      middleuatvo  = p_middleuatvo, 
      middleuapre  = p_middleuapre, 
      middlerurod  = p_middlerurod, 
      middlerudat  = p_middlerudat, 
      middleruvin  = p_middleruvin, 
      middlerutvo  = p_middlerutvo, 
      middlerupre  = p_middlerupre 
   WHERE middleid       = p_middleid ;  
  IF SQL%rowcount = 0 THEN
     l_middleid:=S_MIDDLE_NAMES.NEXTVAL;
     bars_audit.trace('%s 3. Начало добавления отчества middleid=%s', l_title, l_middleid);
     INSERT INTO middle_names 
       (
        middleid,
        middleua,
        middleru,
        sexid,
        firstid,
        middleuaof,
        middleuarod,
        middleuadat,
        middleuavin,
        middleuatvo,
        middleuapre,
        middlerurod,
        middlerudat,
        middleruvin,
        middlerutvo,
        middlerupre
        )
     VALUES 
       (l_middleid,   
        p_middleua,   
        p_middleru,   
        p_sexid,      
        p_firstid,    
        p_middleuaof, 
        p_middleuarod,
        p_middleuadat,
        p_middleuavin,
        p_middleuatvo,
        p_middleuapre,
        p_middlerurod,
        p_middlerudat,
        p_middleruvin,
        p_middlerutvo,
        p_middlerupre    
      );
     bars_audit.trace('%s 4. Завершено добавление отчества middleid=%s', l_title, l_middleid);
  ELSE
     bars_audit.trace('%s 5. Завершено исправление отчества middleid=%s', l_title, p_middleid);
  END IF;
END Set_Middle_Name;  

--***************************************************************************--
-- процедура удаления отчества
--***************************************************************************--
PROCEDURE Del_Middle_Name ( p_middleid       middle_names.middleid%type)
is
  l_title varchar2(30) := 'KL_NAME_UTL.Del_Middle_Name: ';
begin
  bars_audit.trace('%s 1.params: p_middleid =>%s',l_title, to_char(p_middleid));

     delete from middle_names
      where middleid        = p_middleid;
  bars_audit.trace('%s 2. удаление отчества: middleid=%s',l_title, to_char(p_middleid));
end Del_Middle_Name;

BEGIN

null;
END KL_NAME_UTL;
/

begin
    execute immediate 'grant execute on KL_NAME_UTL to BARS_ACCESS_DEFROLE';
 exception when others then 
    if sqlcode = -1917 then null; else raise; 
    end if; 
end;
/ 