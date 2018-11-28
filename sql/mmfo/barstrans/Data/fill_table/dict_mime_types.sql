
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSTRANS/Data/patch_data_DICT_MIME_TYPES.sql ===
PROMPT ===================================================================================== 

declare
l_DICT_MIME_TYPES  DICT_MIME_TYPES%rowtype;

procedure p_merge(p_DICT_MIME_TYPES DICT_MIME_TYPES%rowtype) 
as
Begin
   insert into DICT_MIME_TYPES
      values p_DICT_MIME_TYPES; 
 exception when dup_val_on_index then  
   update DICT_MIME_TYPES
      set row = p_DICT_MIME_TYPES
    where ID = p_DICT_MIME_TYPES.ID;
End;
Begin

l_DICT_MIME_TYPES.ID :=1;
l_DICT_MIME_TYPES.MIME_TYPES :='application/atom+xml';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=2;
l_DICT_MIME_TYPES.MIME_TYPES :='application/EDIFACT';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=3;
l_DICT_MIME_TYPES.MIME_TYPES :='application/EDI-X12';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=4;
l_DICT_MIME_TYPES.MIME_TYPES :='application/font-woff';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=5;
l_DICT_MIME_TYPES.MIME_TYPES :='application/gzip';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=6;
l_DICT_MIME_TYPES.MIME_TYPES :='application/javascript';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=7;
l_DICT_MIME_TYPES.MIME_TYPES :='application/json';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=8;
l_DICT_MIME_TYPES.MIME_TYPES :='application/msword';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=9;
l_DICT_MIME_TYPES.MIME_TYPES :='application/octet-stream';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=10;
l_DICT_MIME_TYPES.MIME_TYPES :='application/ogg';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=11;
l_DICT_MIME_TYPES.MIME_TYPES :='application/pdf';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=12;
l_DICT_MIME_TYPES.MIME_TYPES :='application/postscript';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=13;
l_DICT_MIME_TYPES.MIME_TYPES :='application/soap+xml';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=14;
l_DICT_MIME_TYPES.MIME_TYPES :='application/vnd.google-earth.kml+xml';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=15;
l_DICT_MIME_TYPES.MIME_TYPES :='application/vnd.mozilla.xul+xml';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=16;
l_DICT_MIME_TYPES.MIME_TYPES :='application/vnd.ms-excel';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=17;
l_DICT_MIME_TYPES.MIME_TYPES :='application/vnd.ms-powerpoint';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=18;
l_DICT_MIME_TYPES.MIME_TYPES :='application/vnd.oasis.opendocument.graphics';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=19;
l_DICT_MIME_TYPES.MIME_TYPES :='application/vnd.oasis.opendocument.presentation';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=20;
l_DICT_MIME_TYPES.MIME_TYPES :='application/vnd.oasis.opendocument.spreadsheet';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=21;
l_DICT_MIME_TYPES.MIME_TYPES :='application/vnd.oasis.opendocument.text';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=22;
l_DICT_MIME_TYPES.MIME_TYPES :='application/vnd.openxmlformats-officedocument.presentationml.presentation';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=23;
l_DICT_MIME_TYPES.MIME_TYPES :='application/vnd.openxmlformats-officedocument.spreadsheetml.sheet';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=24;
l_DICT_MIME_TYPES.MIME_TYPES :='application/vnd.openxmlformats-officedocument.wordprocessingml.document';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=25;
l_DICT_MIME_TYPES.MIME_TYPES :='application/x-bittorrent ';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=26;
l_DICT_MIME_TYPES.MIME_TYPES :='application/x-dvi';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=27;
l_DICT_MIME_TYPES.MIME_TYPES :='application/x-font-ttf';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=28;
l_DICT_MIME_TYPES.MIME_TYPES :='application/xhtml+xml';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=29;
l_DICT_MIME_TYPES.MIME_TYPES :='application/x-javascript';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=30;
l_DICT_MIME_TYPES.MIME_TYPES :='application/x-latex';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=31;
l_DICT_MIME_TYPES.MIME_TYPES :='application/xml';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=32;
l_DICT_MIME_TYPES.MIME_TYPES :='application/xml-dtd';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=33;
l_DICT_MIME_TYPES.MIME_TYPES :='application/xop+xml';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=34;
l_DICT_MIME_TYPES.MIME_TYPES :='application/x-pkcs12';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=35;
l_DICT_MIME_TYPES.MIME_TYPES :='application/x-pkcs12';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=36;
l_DICT_MIME_TYPES.MIME_TYPES :='application/x-pkcs7-certificates';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=37;
l_DICT_MIME_TYPES.MIME_TYPES :='application/x-pkcs7-certificates';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=38;
l_DICT_MIME_TYPES.MIME_TYPES :='application/x-pkcs7-certreqresp';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=39;
l_DICT_MIME_TYPES.MIME_TYPES :='application/x-pkcs7-mime';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=40;
l_DICT_MIME_TYPES.MIME_TYPES :='application/x-pkcs7-mime';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=41;
l_DICT_MIME_TYPES.MIME_TYPES :='application/x-pkcs7-signature';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=42;
l_DICT_MIME_TYPES.MIME_TYPES :='application/x-rar-compressed';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=43;
l_DICT_MIME_TYPES.MIME_TYPES :='application/x-shockwave-flash';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=44;
l_DICT_MIME_TYPES.MIME_TYPES :='application/x-stuffit';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=45;
l_DICT_MIME_TYPES.MIME_TYPES :='application/x-tar';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=46;
l_DICT_MIME_TYPES.MIME_TYPES :='application/x-tex ';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=47;
l_DICT_MIME_TYPES.MIME_TYPES :='application/zip';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=48;
l_DICT_MIME_TYPES.MIME_TYPES :='audio/aac';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=49;
l_DICT_MIME_TYPES.MIME_TYPES :='audio/basic';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=50;
l_DICT_MIME_TYPES.MIME_TYPES :='audio/L24';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=51;
l_DICT_MIME_TYPES.MIME_TYPES :='audio/mp4';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=52;
l_DICT_MIME_TYPES.MIME_TYPES :='audio/mpeg';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=53;
l_DICT_MIME_TYPES.MIME_TYPES :='audio/ogg';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=54;
l_DICT_MIME_TYPES.MIME_TYPES :='audio/vnd.rn-realaudio';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=55;
l_DICT_MIME_TYPES.MIME_TYPES :='audio/vnd.wave';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=56;
l_DICT_MIME_TYPES.MIME_TYPES :='audio/vorbis';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=57;
l_DICT_MIME_TYPES.MIME_TYPES :='audio/webm';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=58;
l_DICT_MIME_TYPES.MIME_TYPES :='audio/x-ms-wax';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=59;
l_DICT_MIME_TYPES.MIME_TYPES :='audio/x-ms-wma';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=60;
l_DICT_MIME_TYPES.MIME_TYPES :='image/gif';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=61;
l_DICT_MIME_TYPES.MIME_TYPES :='image/jpeg';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=62;
l_DICT_MIME_TYPES.MIME_TYPES :='image/pjpeg';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=63;
l_DICT_MIME_TYPES.MIME_TYPES :='image/png';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=64;
l_DICT_MIME_TYPES.MIME_TYPES :='image/svg+xml';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=65;
l_DICT_MIME_TYPES.MIME_TYPES :='image/tiff';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=66;
l_DICT_MIME_TYPES.MIME_TYPES :='image/vnd.microsoft.icon';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=67;
l_DICT_MIME_TYPES.MIME_TYPES :='image/vnd.wap.wbmp';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=68;
l_DICT_MIME_TYPES.MIME_TYPES :='image/webp';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=69;
l_DICT_MIME_TYPES.MIME_TYPES :='message/imdn+xml';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=70;
l_DICT_MIME_TYPES.MIME_TYPES :='message/partial';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=71;
l_DICT_MIME_TYPES.MIME_TYPES :='message/rfc822';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=72;
l_DICT_MIME_TYPES.MIME_TYPES :='model/example';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=73;
l_DICT_MIME_TYPES.MIME_TYPES :='model/iges';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=74;
l_DICT_MIME_TYPES.MIME_TYPES :='model/mesh';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=75;
l_DICT_MIME_TYPES.MIME_TYPES :='model/vrml';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=76;
l_DICT_MIME_TYPES.MIME_TYPES :='model/x3d+binary';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=77;
l_DICT_MIME_TYPES.MIME_TYPES :='model/x3d+vrml';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=78;
l_DICT_MIME_TYPES.MIME_TYPES :='model/x3d+xml';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=79;
l_DICT_MIME_TYPES.MIME_TYPES :='multipart/alternative';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=80;
l_DICT_MIME_TYPES.MIME_TYPES :='multipart/encrypted';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=81;
l_DICT_MIME_TYPES.MIME_TYPES :='multipart/form-data';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=82;
l_DICT_MIME_TYPES.MIME_TYPES :='multipart/mixed';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=83;
l_DICT_MIME_TYPES.MIME_TYPES :='multipart/related';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=84;
l_DICT_MIME_TYPES.MIME_TYPES :='multipart/signed';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=85;
l_DICT_MIME_TYPES.MIME_TYPES :='text/cache-manifest';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=86;
l_DICT_MIME_TYPES.MIME_TYPES :='text/cmd';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=87;
l_DICT_MIME_TYPES.MIME_TYPES :='text/css';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=88;
l_DICT_MIME_TYPES.MIME_TYPES :='text/csv';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=89;
l_DICT_MIME_TYPES.MIME_TYPES :='text/html';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=90;
l_DICT_MIME_TYPES.MIME_TYPES :='text/javascript (Obsolete)';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=91;
l_DICT_MIME_TYPES.MIME_TYPES :='text/markdown';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=92;
l_DICT_MIME_TYPES.MIME_TYPES :='text/php';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=93;
l_DICT_MIME_TYPES.MIME_TYPES :='text/plain';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=94;
l_DICT_MIME_TYPES.MIME_TYPES :='text/x-jquery-tmpl';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=95;
l_DICT_MIME_TYPES.MIME_TYPES :='text/xml';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=96;
l_DICT_MIME_TYPES.MIME_TYPES :='video/3gpp';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=97;
l_DICT_MIME_TYPES.MIME_TYPES :='video/3gpp2';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=98;
l_DICT_MIME_TYPES.MIME_TYPES :='video/mp4';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=99;
l_DICT_MIME_TYPES.MIME_TYPES :='video/mpeg';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=100;
l_DICT_MIME_TYPES.MIME_TYPES :='video/ogg';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=101;
l_DICT_MIME_TYPES.MIME_TYPES :='video/quicktime';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=102;
l_DICT_MIME_TYPES.MIME_TYPES :='video/webm';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=103;
l_DICT_MIME_TYPES.MIME_TYPES :='video/x-flv';

 p_merge( l_DICT_MIME_TYPES);


l_DICT_MIME_TYPES.ID :=104;
l_DICT_MIME_TYPES.MIME_TYPES :='video/x-ms-wmv';

 p_merge( l_DICT_MIME_TYPES);


commit;
END;
/


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSTRANS/Data/patch_data_DICT_MIME_TYPES.sql ===
PROMPT ===================================================================================== 

